#!/usr/bin/env bash
set -euo pipefail

gitleaks_image="zricethezav/gitleaks@sha256:c00b6bd0aeb3071cbcb79009cb16a60dd9e0a7c60e2be9ab65d25e6bc8abbb7f"
gitleaks_output=""

# Keep the manual check deliberately narrow and print only the names of tracked
# files. The pinned Gitleaks scan remains the authoritative history-aware check.
pattern='BEGIN (RSA |EC |OPENSSH |DSA |PGP )?PRIVATE KEY|gh[opurs]_[A-Za-z0-9_]{20,}|github_pat_[A-Za-z0-9_]{20,}|sk-(proj-|svcacct-)?[A-Za-z0-9_-]{20,}|(AKIA|ASIA)[A-Z0-9]{16}|(postgres|postgresql|mongodb|mysql|redis)://'

resolve_git_path() {
  local repo_dir="$1"
  local git_flag="$2"
  local resolved

  if ! resolved="$(git -C "$repo_dir" rev-parse --path-format=absolute "$git_flag" 2>/dev/null)"; then
    echo "Unable to resolve Git checkout metadata; refusing release." >&2
    return 1
  fi

  if [[ "$resolved" != /* || ! -d "$resolved" ]]; then
    echo "Git checkout metadata is not an absolute directory; refusing release." >&2
    return 1
  fi

  printf '%s\n' "$resolved"
}

extract_commits_scanned() {
  local output_file="$1"

  # Parse only the numeric summary. Never replay Gitleaks output, which could
  # contain matched content even when the image is asked to redact findings.
  grep -Eio '[0-9]+[[:space:]]+commits?[[:space:]]+scanned' "$output_file" \
    | awk '{print $1}' \
    | tail -n 1 \
    || true
}

main() {
  local repo_dir
  local git_dir
  local git_common_dir
  local metadata_destination
  local gitleaks_status
  local commits_scanned

  repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

  command -v docker >/dev/null || {
    echo "Docker is required for the pinned history-aware Gitleaks scan." >&2
    exit 2
  }

  # Git worktrees store a .git file in the checkout and keep the real common
  # metadata elsewhere. Resolve both paths through Git instead of inspecting
  # or assuming anything about the checkout's .git entry.
  if ! git_dir="$(resolve_git_path "$repo_dir" --git-dir)"; then
    exit 1
  fi
  if ! git_common_dir="$(resolve_git_path "$repo_dir" --git-common-dir)"; then
    exit 1
  fi

  # In a normal checkout, mount the common directory over /repo/.git so the
  # metadata Gitleaks uses is read-only. In a linked worktree, preserve the
  # checkout's .git pointer and mount the common directory at its absolute
  # path, which makes that pointer resolve inside the container.
  if [[ "$git_dir" == "$git_common_dir" ]]; then
    metadata_destination="/repo/.git"
  else
    metadata_destination="$git_common_dir"
  fi

  gitleaks_output="$(mktemp)"
  trap 'rm -f "$gitleaks_output"' EXIT

  if docker run --rm \
    --mount "type=bind,src=$repo_dir,dst=/repo" \
    --mount "type=bind,src=$git_common_dir,dst=$metadata_destination,readonly" \
    "$gitleaks_image" \
    detect --source /repo --redact --no-banner \
    >"$gitleaks_output" 2>&1; then
    gitleaks_status=0
  else
    gitleaks_status=$?
  fi

  commits_scanned="$(extract_commits_scanned "$gitleaks_output")"
  if [[ ! "$commits_scanned" =~ ^[1-9][0-9]*$ ]]; then
    echo "Pinned Gitleaks did not complete an authoritative history scan; refusing release." >&2
    exit 1
  fi

  # A positive history count is necessary but not sufficient: a Git metadata
  # resolution error must also fail closed even if a tool version emits a
  # misleading positive summary.
  if grep -Eiq 'not a git repository|git[^[:alnum:]]+fatal|history[^[:alnum:]]+(scan[^[:alnum:]]+)?(skipped|failed|unavailable)' "$gitleaks_output"; then
    echo "Pinned Gitleaks reported a non-authoritative history scan; refusing release." >&2
    exit 1
  fi

  if ((gitleaks_status != 0)); then
    echo "Pinned Gitleaks failed or found a match; no match details were printed." >&2
    exit 1
  fi

  echo "Pinned Gitleaks history scan passed: $commits_scanned commits scanned."

  # This deliberately prints only filenames, never matching credential text.
  mapfile -t suspect_files < <(git -C "$repo_dir" grep -IlE "$pattern" -- . || true)
  if ((${#suspect_files[@]})); then
    echo "Manual high-confidence patterns matched these tracked files:" >&2
    printf '  %s\n' "${suspect_files[@]}" >&2
    exit 1
  fi

  echo "Public-release secret scans passed. Inspect new paths manually before pushing."
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  main "$@"
fi
