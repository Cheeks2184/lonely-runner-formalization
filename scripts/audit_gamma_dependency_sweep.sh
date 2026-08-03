#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
tmp_dir="$(mktemp -d)"
trap 'rm -rf -- "$tmp_dir"' EXIT

(
  cd "$repo_dir/certificates"
  sha256sum --check gamma_dependency_source.sha256
)

g++ -std=c++20 -O3 -Wall -Wextra -Wpedantic \
  "$repo_dir/scripts/audit_gamma_dependency_sweep.cpp" \
  -o "$tmp_dir/gamma_dependency_sweep"

"$tmp_dir/gamma_dependency_sweep" medium-grid \
  > "$tmp_dir/medium.txt"
cmp "$repo_dir/certificates/gamma_dependency_medium_expected.txt" \
  "$tmp_dir/medium.txt"

if [[ "${GAMMA_DEPENDENCY_FULL:-0}" == "1" ]]; then
  "$tmp_dir/gamma_dependency_sweep" endpoint-grid \
    > "$tmp_dir/endpoint.txt"
  cmp "$repo_dir/certificates/gamma_dependency_endpoint_expected.txt" \
    "$tmp_dir/endpoint.txt"

  "$tmp_dir/gamma_dependency_sweep" high-grid \
    > "$tmp_dir/high.txt"
  cmp "$repo_dir/certificates/gamma_dependency_high_expected.txt" \
    "$tmp_dir/high.txt"

  "$tmp_dir/gamma_dependency_sweep" n20000-analysis \
    > "$tmp_dir/n20000.txt"
  cmp "$repo_dir/certificates/gamma_dependency_n20000_expected.txt" \
    "$tmp_dir/n20000.txt"

  echo "Gamma dependency full finite sweep passed."
else
  echo "Gamma dependency medium finite sweep passed."
fi
