#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
artifact_dir="$repo_dir/research/sol-pro/artifacts"
tmp_dir="$(mktemp -d)"
trap 'rm -rf -- "$tmp_dir"' EXIT

(
  cd "$artifact_dir"
  sha256sum --check prompt50_crosspivot_transversal_verifier.py.sha256
  sha256sum --check prompt50_crosspivot_transversal_verifier.out.sha256
  python3 prompt50_crosspivot_transversal_verifier.py \
    > "$tmp_dir/prompt50_crosspivot_transversal_verifier.out"
  cmp prompt50_crosspivot_transversal_verifier.out \
    "$tmp_dir/prompt50_crosspivot_transversal_verifier.out"
)

python3 "$repo_dir/scripts/audit_prompt50_transversal.py" \
  > "$tmp_dir/prompt50_independent_transversal.out"
cmp "$repo_dir/certificates/prompt50_independent_transversal_expected.txt" \
  "$tmp_dir/prompt50_independent_transversal.out"

echo "Response 50 artifact and independent transversal audits passed."
