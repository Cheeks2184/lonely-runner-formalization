#!/usr/bin/env python3
"""Independent exact integral-transversal verifier for (N,A,B)=(7,98,187)."""
from __future__ import annotations

from hashlib import sha256
from itertools import combinations
from math import gcd
from pathlib import Path

VERSION = "PROB-62-v1.0.0"
N, A, B = 7, 98, 187
SHIFTS = (
    128273, 80, 71, 151, 128210, 150, 25,
    1156, 114, 87, 149, 2946, 24, 128252,
)
EXPECTED_ROBUST_H42698 = ((36, 942), (134, 1129), (428, 381), (526, 568))
EXPECTED_WITNESS = (7, 63, 70, 77, 84)
OUT = Path(__file__).with_name("pro_b_affine_hard.out")


def rho(M: int, x: int) -> int:
    y = x % M
    return min(y, M - y)


def candidates(P: int) -> tuple[int, ...]:
    return tuple(r for r in range(N * P) if r % N != 0)


def affine_pairs(h: int) -> tuple[tuple[int, int], ...]:
    g = gcd(A, B)
    alpha, beta = A // g, B // g
    L = N * g * alpha * beta
    cb_by_phase: dict[int, list[int]] = {}
    for s in candidates(B):
        cb_by_phase.setdefault((alpha * s) % L, []).append(s)
    pairs = []
    for r in candidates(A):
        target = (beta * r - h) % L
        for s in cb_by_phase.get(target, ()):
            pairs.append((r, s))
    return tuple(pairs)


def robust_pairs(h: int) -> tuple[tuple[int, int], ...]:
    return tuple(
        (r, s) for r, s in affine_pairs(h)
        if rho(N * A, r * B) >= A and rho(N * B, s * A) >= B
    )


def mask_bad_A(r: int) -> int:
    return sum(1 << (c - 1) for c in range(1, A) if rho(N * A, r * c) < A)


def mask_bad_B(s: int) -> int:
    return sum(1 << (c - 1) for c in range(1, A) if rho(N * B, s * c) < B)


def main() -> None:
    g = gcd(A, B)
    alpha, beta = A // g, B // g
    L = N * g * alpha * beta
    assert L == 128282
    rp = robust_pairs(42698)
    assert rp == EXPECTED_ROBUST_H42698

    constraints: list[tuple[int, int, int, int, int]] = []
    per_shift = []
    for h in SHIFTS:
        pairs = robust_pairs(h)
        per_shift.append((h, len(affine_pairs(h)), len(pairs)))
        for r, s in pairs:
            constraints.append((h, r, s, mask_bad_A(r), mask_bad_B(s)))
    assert len(constraints) == 64

    checked = 0
    for lower in combinations(range(1, A), 4):
        mask = sum(1 << (c - 1) for c in lower)
        assert not all((mask & ca) and (mask & cb) for _h, _r, _s, ca, cb in constraints), lower
        checked += 1
    assert checked == 3_464_840

    witness_mask = sum(1 << (c - 1) for c in EXPECTED_WITNESS)
    assert all((witness_mask & ca) and (witness_mask & cb) for _h, _r, _s, ca, cb in constraints)

    transcript = []
    transcript.append(f"version={VERSION}")
    transcript.append(f"N={N} A={A} B={B} L={L}")
    transcript.append(f"shifts={SHIFTS}")
    transcript.append(f"per_shift=(h,all_pairs,robust_pairs)={tuple(per_shift)}")
    transcript.append(f"h42698_robust_pairs={rp}")
    transcript.append(f"constraints={len(constraints)}")
    transcript.append(f"four_sets_checked={checked}")
    transcript.append("all_four_sets_fail_to_hit_both_endpoints_of_every_constraint=YES")
    transcript.append(f"five_set_witness={EXPECTED_WITNESS}")
    transcript.append("affine_transversal_number=5")
    digest = sha256(repr(tuple(constraints)).encode()).hexdigest()
    transcript.append(f"constraint_sha256={digest}")
    OUT.write_text("\n".join(transcript) + "\n", encoding="utf-8", newline="\n")
    print(OUT)
    print(f"output_sha256={sha256(OUT.read_bytes()).hexdigest()}")


if __name__ == "__main__":
    main()
