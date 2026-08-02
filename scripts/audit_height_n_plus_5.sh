#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
tmp_dir="$(mktemp -d)"
trap 'rm -rf -- "$tmp_dir"' EXIT

python3 "$repo_dir/scripts/verify_height_n_plus_5.py" \
  > "$tmp_dir/output.txt"

cmp "$tmp_dir/output.txt" \
  "$repo_dir/certificates/height_n_plus_5_expected.txt"

echo "The max-speed n+5 finite certificate output matches exactly."
