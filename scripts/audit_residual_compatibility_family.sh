#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
tmp_dir="$(mktemp -d)"
trap 'rm -rf -- "$tmp_dir"' EXIT

python3 "$repo_dir/scripts/verify_residual_compatibility_family.py" \
  > "$tmp_dir/output.txt"
cmp "$tmp_dir/output.txt" \
  "$repo_dir/certificates/residual_compatibility_family_expected.txt"

echo "Residual compatibility-family output matches exactly."
