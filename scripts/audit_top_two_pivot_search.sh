#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
tmp_dir="$(mktemp -d)"
trap 'rm -rf -- "$tmp_dir"' EXIT

g++ -O3 -std=c++20 -Wall -Wextra -pedantic \
  "$repo_dir/scripts/audit_top_two_pivot_search.cpp" \
  -o "$tmp_dir/top_two_pivot_search"

"$tmp_dir/top_two_pivot_search" > "$tmp_dir/output.txt"
cmp "$tmp_dir/output.txt" \
  "$repo_dir/certificates/top_two_pivot_search_expected.txt"

(
  cd "$repo_dir/certificates"
  sha256sum --check top_two_pivot_search_expected.sha256
  sha256sum --check top_two_pivot_search_source.sha256
)

echo "Top-two pivot bounded search output and source/output checksums match exactly."
