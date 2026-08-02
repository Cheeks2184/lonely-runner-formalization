#!/usr/bin/env python3
"""Independent audit of Response 50's 14-shift fixed-pair certificate.

This deliberately enumerates both numerator coordinates directly instead of
using the attachment's solved-congruence `affine_pairs` implementation.
"""

from functools import cache
from itertools import combinations


N, A, B = 7, 98, 187
L = N * A * B
SHIFTS = (
    128273, 80, 71, 151, 128210, 150, 25,
    1156, 114, 87, 149, 2946, 24, 128252,
)
FIVE = (7, 63, 70, 77, 84)


def rho(modulus: int, value: int) -> int:
    residue = value % modulus
    return min(residue, modulus - residue)


constraints: list[tuple[int, int]] = []
pair_counts: list[int] = []
for shift in SHIFTS:
    robust_pairs: list[tuple[int, int]] = []
    for r_a in range(N * A):
        if r_a % N == 0 or rho(N * A, r_a * B) < A:
            continue
        for r_b in range(N * B):
            if r_b % N == 0 or rho(N * B, r_b * A) < B:
                continue
            if (B * r_a - A * r_b - shift) % L == 0:
                robust_pairs.append((r_a, r_b))
    pair_counts.append(len(robust_pairs))
    for r_a, r_b in robust_pairs:
        bad_a = 0
        bad_b = 0
        for speed in range(1, A):
            bit = 1 << (speed - 1)
            if rho(N * A, r_a * speed) < A:
                bad_a |= bit
            if rho(N * B, r_b * speed) < B:
                bad_b |= bit
        constraints.append((bad_a, bad_b))

assert len(constraints) == 64

checked = 0
for speeds in combinations(range(1, A), 4):
    selected = 0
    for speed in speeds:
        selected |= 1 << (speed - 1)
    if all(selected & bad_a and selected & bad_b for bad_a, bad_b in constraints):
        raise AssertionError(f"unexpected four-transversal: {speeds}")
    checked += 1
assert checked == 3_464_840

selected_five = 0
for speed in FIVE:
    selected_five |= 1 << (speed - 1)
assert all(
    selected_five & bad_a and selected_five & bad_b
    for bad_a, bad_b in constraints
)


def robust_grid(pivot: int, other_top: int) -> tuple[list[int], list[int], int]:
    residues = [
        r for r in range(N * pivot)
        if r % N and rho(N * pivot, r * other_top) >= pivot
    ]
    masks: list[int] = []
    for speed in range(1, A):
        mask = 0
        for index, residue in enumerate(residues):
            if rho(N * pivot, residue * speed) < pivot:
                mask |= 1 << index
        masks.append(mask)
    return residues, masks, (1 << len(residues)) - 1


def cover_exists(masks: list[int], full: int, depth: int) -> bool:
    """Exact branching on a least-supported uncovered residue.

    Unlike the recovered verifier, this keeps duplicate and dominated speed
    masks. A state is determined by its covered set and remaining capacity;
    a previously selected mask adds nothing and is skipped automatically.
    """

    bit_support: dict[int, list[int]] = {}
    for mask in masks:
        work = mask
        while work:
            bit = work & -work
            bit_support.setdefault(bit, []).append(mask)
            work ^= bit

    @cache
    def search(covered: int, remaining: int) -> bool:
        if covered == full:
            return True
        if remaining == 0:
            return False
        uncovered = full & ~covered
        gains = sorted(
            ((mask & uncovered).bit_count() for mask in masks), reverse=True
        )
        if sum(gains[:remaining]) < uncovered.bit_count():
            return False
        options: list[int] | None = None
        work = uncovered
        while work:
            bit = work & -work
            supported = bit_support.get(bit, [])
            if not supported:
                return False
            if options is None or len(supported) < len(options):
                options = supported
            work ^= bit
        assert options is not None
        return any(
            new != covered and search(new, remaining - 1)
            for mask in options
            for new in (covered | mask,)
        )

    return search(0, depth)


residues_a, masks_a, target_a = robust_grid(A, B)
residues_b, masks_b, target_b = robust_grid(B, A)
assert len(residues_a) == 420
assert len(residues_b) == 804
cover_a = (9, 31, 40, 49, 58, 89)
cover_b = (9, 18, 27, 36, 45, 54)
union_a = 0
union_b = 0
for speed in cover_a:
    union_a |= masks_a[speed - 1]
for speed in cover_b:
    union_b |= masks_b[speed - 1]
assert union_a == target_a
assert union_b == target_b
assert not cover_exists(masks_a, target_a, 5)
assert not cover_exists(masks_b, target_b, 5)

quotient_a = tuple(
    sum(rho(N * A, (j + N * u) * B) >= A for u in range(A))
    for j in range(1, N)
)
quotient_b = tuple(
    sum(rho(N * B, (j + N * u) * A) >= B for u in range(B))
    for j in range(1, N)
)
assert quotient_a == (70,) * 6
assert quotient_b == (134,) * 6

for m in range(2, 501):
    runner_n = 2 * m
    pivot = m + 1
    numerator = 2 * m + 1
    speeds = [speed for speed in range(1, runner_n + 1) if speed != m]
    assert numerator % runner_n
    assert numerator < runner_n * pivot
    assert all(
        rho(runner_n * pivot, numerator * speed) >= pivot
        for speed in speeds
    )

# Transversality is upward closed. If a transversal of size below four
# existed, adjoining arbitrary lower speeds would create a four-transversal.
# The exhaustive four-set rejection and displayed five-set witness therefore
# prove the exact minimum is five.
print(f"robust_pairs_per_shift={tuple(pair_counts)}")
print(f"constraints={len(constraints)}")
print(f"checked_four_sets={checked}")
print("no_transversal_of_size_at_most_four=True")
print(f"five_transversal={FIVE}")
print("tau_H=5")
print("kappa_A=6 kappa_B=6")
print(f"quotient_counts_A={quotient_a} quotient_counts_B={quotient_b}")
print("coefficient_two_family_checked_m=2..500")
