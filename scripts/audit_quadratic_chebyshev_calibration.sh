#!/usr/bin/env bash
set -euo pipefail

# This optional exhaustive calibration takes several minutes.  Runtime text is
# normalized before hashing; every mathematical row remains in the digest.
repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
tmp_dir="$(mktemp -d)"
trap 'rm -rf -- "$tmp_dir"' EXIT

g++ -O3 -std=c++20 \
  "$repo_dir/scripts/search_quadratic_small_dimensions.cpp" \
  -o "$tmp_dir/small_dimensions"
"$tmp_dir/small_dimensions" 240 > "$tmp_dir/small.out"
sed -E 's@seconds=[0-9.]+@seconds=ELAPSED@' \
  "$tmp_dir/small.out" > "$tmp_dir/small.stable.out"
small_hash="$(sha256sum "$tmp_dir/small.stable.out" | cut -d' ' -f1)"
test "$small_hash" = \
  "5bb7105944b7ef857ad004042cd2521ef202988094c3e5fa905d2691c8b19007"

g++ -O3 -std=c++20 \
  "$repo_dir/scripts/search_quadratic_small_adversarial.cpp" \
  -o "$tmp_dir/adversarial"
"$tmp_dir/adversarial" 20000 > "$tmp_dir/adversarial.out"
cmp "$tmp_dir/adversarial.out" \
  "$repo_dir/certificates/quadratic_chebyshev_adversarial_expected.txt"

echo "The lower-dimensional quadratic calibration outputs match exactly."
