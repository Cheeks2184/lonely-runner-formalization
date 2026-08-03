#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
tmp_dir="$(mktemp -d)"
trap 'rm -rf -- "$tmp_dir"' EXIT

expected_source_hash="ba277ba8bcf9783415a68eae955384bb3afbadea3af2af36e466060a1618f970"
actual_source_hash="$(sha256sum "$repo_dir/scripts/audit_coefficient_two_gamma.py" | cut -d' ' -f1)"
test "$actual_source_hash" = "$expected_source_hash"

python3 "$repo_dir/scripts/audit_coefficient_two_gamma.py" \
  > "$tmp_dir/coefficient_two_gamma.out"
cmp "$repo_dir/certificates/coefficient_two_gamma_expected.txt" \
  "$tmp_dir/coefficient_two_gamma.out"

echo "Coefficient-two Gamma finite audit passed."
