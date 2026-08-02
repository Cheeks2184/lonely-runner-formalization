#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
tmp_dir="$(mktemp -d)"
trap 'rm -rf -- "$tmp_dir"' EXIT

(
  cd "$repo_dir"
  sha256sum --check certificates/prompt45_artifact_sha256.txt
)

python3 \
  "$repo_dir/research/sol-pro/artifacts/prompt45_primorial_residual_verifier.py" \
  > "$tmp_dir/primorial.out"
cmp "$tmp_dir/primorial.out" \
  "$repo_dir/certificates/prompt45_primorial_residual_expected.txt"

g++ -O3 -std=c++20 -Wall -Wextra -pedantic \
  "$repo_dir/research/sol-pro/artifacts/prompt45_cheb_grid.cpp" \
  -o "$tmp_dir/prompt45_cheb_grid"
"$tmp_dir/prompt45_cheb_grid" > "$tmp_dir/cheb.out"
cmp "$tmp_dir/cheb.out" \
  "$repo_dir/certificates/prompt45_cheb_grid_expected.txt"

echo "Response 45 artifact hashes and outputs match exactly."
