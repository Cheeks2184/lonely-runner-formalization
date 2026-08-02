#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
artifact_dir="$root/research/sol-pro/artifacts"
tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

cd "$artifact_dir"
sha256sum --check prompt47_arithmetic_verifier.py.sha256
sha256sum --check prompt47_arithmetic_verifier.out.sha256
python3 prompt47_arithmetic_verifier.py > "$tmp_dir/prompt47_arithmetic_verifier.out"
cmp --silent prompt47_arithmetic_verifier.out "$tmp_dir/prompt47_arithmetic_verifier.out"

echo "Response 47 arithmetic audit passed."
