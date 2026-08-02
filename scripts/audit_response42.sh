#!/usr/bin/env bash
set -euo pipefail

# Rebuild and replay the exact Sol Pro response-42 artifacts.  All arithmetic
# comparisons are integral; Boost is used only for unbounded C++ integers.
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
tmp_dir="$(mktemp -d)"
trap 'rm -rf -- "$tmp_dir"' EXIT

python3 "$repo_root/research/sol-pro/artifacts/prompt42_chebyshev_divisor_verifier.py" \
  > "$tmp_dir/divisor.out"
cmp "$tmp_dir/divisor.out" \
  "$repo_root/certificates/prompt42_chebyshev_divisor_expected.txt"

g++ -std=c++20 -O2 -pipe \
  "$repo_root/research/sol-pro/artifacts/prompt42_chebyshev_box_scan.cpp" \
  -o "$tmp_dir/box_scan"
"$tmp_dir/box_scan" > "$tmp_dir/box.out"
cmp "$tmp_dir/box.out" \
  "$repo_root/certificates/prompt42_chebyshev_box_expected.txt"

g++ -std=c++20 -O2 -pipe \
  "$repo_root/research/sol-pro/artifacts/prompt42_chebyshev_mutations.cpp" \
  -o "$tmp_dir/mutation_scan"
"$tmp_dir/mutation_scan" > "$tmp_dir/mutations.out"
cmp "$tmp_dir/mutations.out" \
  "$repo_root/certificates/prompt42_chebyshev_mutations_expected.txt"

printf '%s\n' 'Response 42 artifact outputs match exactly.'
