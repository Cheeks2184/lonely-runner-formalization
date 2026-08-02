#!/usr/bin/env python3
from functools import lru_cache
from math import gcd


def rho(M: int, x: int) -> int:
    y = x % M
    return min(y, M - y)


def affine_pairs(N: int, A: int, B: int, h: int):
    g = gcd(A, B)
    alpha, beta = A // g, B // g
    L = N * g * alpha * beta
    out = []
    for r in range(N * A):
        if r % N == 0:
            continue
        target = (beta * r - h) % L
        if target % alpha:
            continue
        s = (target // alpha) % (N * B)
        if s % N:
            out.append((r, s))
    return out


def affine_formula(N: int, A: int, B: int, h: int) -> int:
    g = gcd(A, B)
    alpha, beta = A // g, B // g
    dA, dB = gcd(N, alpha), gcd(N, beta)
    return g * (
        N
        - (dA if h % dA == 0 else 0)
        - (dB if h % dB == 0 else 0)
        + (1 if h % N == 0 else 0)
    )


def robust_residues(N: int, P: int, Q: int):
    return [
        r for r in range(N * P)
        if r % N != 0 and rho(N * P, r * Q) >= P
    ]


def robust_masks(N: int, P: int, Q: int, max_lower: int):
    R = robust_residues(N, P, Q)
    masks = {}
    for speed in range(1, max_lower + 1):
        mask = 0
        for i, r in enumerate(R):
            if rho(N * P, r * speed) < P:
                mask |= 1 << i
        masks[speed] = mask
    return R, masks, (1 << len(R)) - 1


def cover_with_at_most(masks, full, depth):
    # Merge duplicate masks and remove masks contained in a larger mask.
    by_mask = {}
    for speed, mask in masks.items():
        if mask:
            by_mask.setdefault(mask, speed)
    items = [(speed, mask) for mask, speed in by_mask.items()]
    kept = []
    for speed, mask in sorted(items, key=lambda z: z[1].bit_count(), reverse=True):
        if any(mask | other == other for _, other in kept):
            continue
        kept.append((speed, mask))
    items = kept

    bit_to_items = {}
    for idx, (_, mask) in enumerate(items):
        work = mask
        while work:
            bit = work & -work
            bit_to_items.setdefault(bit.bit_length() - 1, []).append(idx)
            work -= bit

    @lru_cache(None)
    def search(covered, remaining_depth):
        if covered == full:
            return ()
        if remaining_depth == 0:
            return None
        uncovered = full & ~covered
        gains = sorted(
            ((mask & uncovered).bit_count() for _, mask in items),
            reverse=True,
        )
        if sum(gains[:remaining_depth]) < uncovered.bit_count():
            return None
        work = uncovered
        best = None
        while work:
            bit = work & -work
            candidates = bit_to_items.get(bit.bit_length() - 1, ())
            if not candidates:
                return None
            if best is None or len(candidates) < len(best):
                best = candidates
            work -= bit
        for idx in best:
            speed, mask = items[idx]
            new_covered = covered | mask
            if new_covered == covered:
                continue
            tail = search(new_covered, remaining_depth - 1)
            if tail is not None:
                return (speed,) + tail
        return None

    for k in range(depth + 1):
        answer = search(0, k)
        if answer is not None:
            return k, answer
    return None


def quotient_slice_counts(N: int, P: int, Q: int):
    counts = []
    for j in range(1, N):
        residues = (j + N * u for u in range(P))
        counts.append(sum(rho(N * P, r * Q) >= P for r in residues))
    return tuple(counts)


N, A, B = 7, 98, 187
g = gcd(A, B)
alpha, beta = A // g, B // g
L = N * g * alpha * beta
C = g * alpha * beta
assert gcd(N, alpha) == 7 and gcd(N, beta) == 1
assert affine_formula(N, A, B, 0) == 0

h = 42698
pairs = affine_pairs(N, A, B, h)
assert len(pairs) == affine_formula(N, A, B, h) == 6
robust = tuple(
    (r, s) for r, s in pairs
    if rho(N * A, r * B) >= A and rho(N * B, s * A) >= B
)
assert robust == ((36, 942), (134, 1129), (428, 381), (526, 568))
simultaneous_possible = tuple(
    speed for speed in range(1, A)
    if rho(L, h * speed) < 2 * C
)
assert simultaneous_possible == tuple(range(3, 98, 3))

assert quotient_slice_counts(N, A, B) == (70,) * 6
assert quotient_slice_counts(N, B, A) == (134,) * 6

RA, masksA, fullA = robust_masks(N, A, B, A - 1)
RB, masksB, fullB = robust_masks(N, B, A, A - 1)
coverA = cover_with_at_most(masksA, fullA, 6)
coverB = cover_with_at_most(masksB, fullB, 6)
assert coverA is not None and coverA[0] == 6
assert coverB is not None and coverB[0] == 6
assert cover_with_at_most(masksA, fullA, 5) is None
assert cover_with_at_most(masksB, fullB, 5) is None


# A 14-shift integral affine certificate for the same hard row.
# Any common set of four lower speeds covering both top robust grids would
# have to hit both endpoints of every robust pair on every listed shift.
affine_certificate_shifts = (
    128273, 80, 71, 151, 128210, 150, 25,
    1156, 114, 87, 149, 2946, 24, 128252,
)
affine_constraints = []
for shift in affine_certificate_shifts:
    for r, s in affine_pairs(N, A, B, shift):
        if rho(N * A, r * B) < A or rho(N * B, s * A) < B:
            continue
        cover_A = sum(
            1 << (speed - 1)
            for speed in range(1, A)
            if rho(N * A, r * speed) < A
        )
        cover_B = sum(
            1 << (speed - 1)
            for speed in range(1, A)
            if rho(N * B, s * speed) < B
        )
        affine_constraints.append((cover_A, cover_B))

checked_four_sets = 0
from itertools import combinations
for lower_set in combinations(range(1, A), 4):
    mask = sum(1 << (speed - 1) for speed in lower_set)
    assert not all(
        (mask & cover_A) and (mask & cover_B)
        for cover_A, cover_B in affine_constraints
    )
    checked_four_sets += 1
assert checked_four_sets == 3464840
affine_five_set = (7, 63, 70, 77, 84)
affine_five_mask = sum(1 << (speed - 1) for speed in affine_five_set)
assert all(
    (affine_five_mask & cover_A) and (affine_five_mask & cover_B)
    for cover_A, cover_B in affine_constraints
)

# Infinite obstruction to a pure missing-to-extra matching at coefficient two.
for m in range(2, 101):
    N2 = 2 * m
    P = m + 1
    r = N2 + 1
    speeds = tuple(s for s in range(1, N2 + 1) if s != m)
    assert len(speeds) == N2 - 1
    assert r % N2 != 0 and r < N2 * P
    assert all(rho(N2 * P, r * s) >= P for s in speeds)

print(f"hard_pair=(N,A,B)=({N},{A},{B})")
print(f"common_slice_size={affine_formula(N,A,B,0)}")
print(f"affine_shift={h} affine_pair_count={len(pairs)} robust_pairs={robust}")
print(f"simultaneous_spoiler_candidates={simultaneous_possible}")
print(f"quotient_A_slice_counts={quotient_slice_counts(N,A,B)}")
print(f"quotient_B_slice_counts={quotient_slice_counts(N,B,A)}")
print(f"kappa_A={coverA[0]} cover_A={coverA[1]} robust_A={len(RA)}")
print(f"kappa_B={coverB[0]} cover_B={coverB[1]} robust_B={len(RB)}")
print(f"affine_integral_certificate_shifts={affine_certificate_shifts}")
print(f"affine_constraints={len(affine_constraints)} checked_four_sets={checked_four_sets}")
print(f"affine_transversal_number=5 witness={affine_five_set}")
print("coefficient_two_internal_blocker_family_checked_m=2..100")
