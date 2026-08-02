#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
tmp_dir="$(mktemp -d)"
trap 'rm -rf -- "$tmp_dir"' EXIT

python3 \
  "$repo_dir/research/sol-pro/artifacts/prompt44_height_residual_verifier.py" \
  > "$tmp_dir/height.out"
cmp "$tmp_dir/height.out" \
  "$repo_dir/certificates/prompt44_height_residual_expected.txt"

g++ -O3 -std=c++20 \
  "$repo_dir/research/sol-pro/artifacts/prompt44_chebyshev_adversarial.cpp" \
  -o "$tmp_dir/prompt44_chebyshev"
"$tmp_dir/prompt44_chebyshev" > "$tmp_dir/chebyshev.out"
cmp "$tmp_dir/chebyshev.out" \
  "$repo_dir/certificates/prompt44_chebyshev_adversarial_expected.txt"

echo "Response 44 artifact outputs match exactly."
