#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
gitleaks_image="zricethezav/gitleaks@sha256:c00b6bd0aeb3071cbcb79009cb16a60dd9e0a7c60e2be9ab65d25e6bc8abbb7f"

command -v docker >/dev/null || {
  echo "Docker is required for the pinned history-aware Gitleaks scan." >&2
  exit 2
}

docker run --rm -v "$repo_dir:/repo" "$gitleaks_image" \
  detect --source /repo --redact --no-banner

# This deliberately prints only filenames, never matching credential text.
pattern='BEGIN (RSA |EC |OPENSSH |DSA |PGP )?PRIVATE KEY|gh[opurs]_[A-Za-z0-9_]{20,}|github_pat_[A-Za-z0-9_]{20,}|sk-(proj-|svcacct-)?[A-Za-z0-9_-]{20,}|(AKIA|ASIA)[A-Z0-9]{16}|(postgres|postgresql|mongodb|mysql|redis)://'
mapfile -t suspect_files < <(git -C "$repo_dir" grep -IlE "$pattern" -- . || true)
if ((${#suspect_files[@]})); then
  echo "Manual high-confidence patterns matched these tracked files:" >&2
  printf '  %s\n' "${suspect_files[@]}" >&2
  exit 1
fi

echo "Public-release secret scans passed. Inspect new paths manually before pushing."
