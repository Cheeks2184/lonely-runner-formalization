#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
tmp_dir="$(mktemp -d)"
trap 'rm -rf -- "$tmp_dir"' EXIT

python3 "$repo_dir/scripts/search_quadratic_chebyshev_failure.py" \
  --n-max 5 --B-max 7 > "$tmp_dir/output.txt"
cmp "$tmp_dir/output.txt" \
  "$repo_dir/certificates/quadratic_chebyshev_failure_expected.txt"

echo "The quadratic Chebyshev counterexample output matches exactly."
