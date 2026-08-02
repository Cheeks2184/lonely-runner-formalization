#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
tmp_dir="$(mktemp -d)"
trap 'rm -rf -- "$tmp_dir"' EXIT

python3 "$repo_dir/scripts/audit_top_two_fractional_dual.py" \
  > "$tmp_dir/output.txt"
cmp "$tmp_dir/output.txt" \
  "$repo_dir/certificates/top_two_fractional_dual_expected.txt"

(
  cd "$repo_dir/certificates"
  sha256sum --check top_two_fractional_dual_expected.sha256
  sha256sum --check top_two_fractional_dual_source.sha256
)

echo "Top-two fractional-dual fixed-instance audit matches exactly."
