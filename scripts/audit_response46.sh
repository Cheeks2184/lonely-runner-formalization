#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
tmp_dir="$(mktemp -d)"
trap 'rm -rf -- "$tmp_dir"' EXIT

(
  cd "$repo_dir"
  sha256sum --check certificates/prompt46_artifact_sha256.txt
)

python3 \
  "$repo_dir/research/sol-pro/artifacts/prompt46_linear_height_verifier.py" \
  > "$tmp_dir/output.txt"
cmp "$tmp_dir/output.txt" \
  "$repo_dir/certificates/prompt46_linear_height_expected.txt"

echo "Response 46 artifact hash and output match exactly."
