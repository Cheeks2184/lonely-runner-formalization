#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
tmp_dir="$(mktemp -d)"
trap 'rm -rf -- "$tmp_dir"' EXIT

g++ -O3 -std=c++20 \
  "$repo_dir/scripts/audit_response42_cheb_stress.cpp" \
  -o "$tmp_dir/response42_cheb_stress"

RESPONSE42_CHEB_STRESS_BIN="$tmp_dir/response42_cheb_stress" \
  python3 "$repo_dir/scripts/run_response42_cheb_stress.py" \
  > "$tmp_dir/output.txt"

cmp "$tmp_dir/output.txt" \
  "$repo_dir/certificates/response42_cheb_stress_expected.txt"

echo "Response 42 adversarial Chebyshev stress output matches exactly."
