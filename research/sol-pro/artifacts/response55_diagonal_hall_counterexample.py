#!/usr/bin/env python3
"""Exact deterministic audit of the feasible-total diagonal graph.

Runtime: Python 3.13.5
No third-party packages, randomness, or heuristic pruning.
Search order: lexicographic (N,t), with
  4 <= N <= 32,
  1 <= t <= floor(N/2),
  t >= 16,
  3*t > N,
  nonempty feasible-start interval,
  nonempty exact candidate set C(N,t).
"""
from math import gcd

EXCEPTIONS_22 = {
    (4,1,2), (5,2,2), (6,3,2),
    (5,1,3), (6,2,3), (7,3,3), (8,4,3),
    (10,2,6), (11,2,6), (11,3,6), (12,3,6),
    (12,4,6), (13,4,6), (13,5,6), (14,5,6),
    (14,6,6), (15,6,6), (15,7,6), (16,7,6),
    (16,8,6), (17,8,6), (18,9,6),
}

def omega(n: int) -> int:
    if n <= 1:
        return 0
    x, out, p = n, 0, 2
    while p * p <= x:
        if x % p == 0:
            out += 1
            while x % p == 0:
                x //= p
        p += 1
    if x > 1:
        out += 1
    return out

def auto(N: int, t: int, c: int) -> bool:
    H = N + t
    return any(gcd(c, d) == 1 for d in range(H + 1, 2 * N - c + 1))

def gamma(N: int, t: int, c: int) -> tuple[int, ...]:
    H = N + t
    lo = max(N + 1, H - c + 1)
    hi = min(H, 2 * N - c)
    if lo > hi:
        return ()
    return tuple(d for d in range(lo, hi + 1) if gcd(c, d) == 1)

def candidate_set(N: int, t: int) -> tuple[int, ...]:
    H = N + t
    out = []
    for c in range(1, N + 1):
        if 2 * c > H:
            continue
        if not (N - c - t < 2 ** omega(c)):
            continue
        if auto(N, t, c):
            continue
        if 3 * (N - t) < 4 * c or (N, t, c) in EXCEPTIONS_22:
            out.append(c)
    return tuple(out)

def rectangle_parameters(N: int, t: int):
    q = t // 4
    ell = 2 * q
    a = 3 * (N - t) // 4 + 1
    b = (N + t) // 2
    s_min = max(t - ell, b + 1 - 2 * ell)
    s_max = min(a, N + 1 - 3 * ell)
    return q, ell, a, b, s_min, s_max

def maximum_matching(left, neighborhoods):
    owner = {}
    def augment(c, seen):
        for d in neighborhoods[c]:
            if d in seen:
                continue
            seen.add(d)
            if d not in owner or augment(owner[d], seen):
                owner[d] = c
                return True
        return False
    size = 0
    for c in left:
        if augment(c, set()):
            size += 1
    matching = tuple(sorted((c, d) for d, c in owner.items()))
    return size, matching

rows_checked = 0
failure = None
for N in range(4, 33):
    for t in range(1, N // 2 + 1):
        if t < 16 or 3 * t <= N:
            continue
        q, ell, a, b, s_min, s_max = rectangle_parameters(N, t)
        if s_min > s_max:
            continue
        C = candidate_set(N, t)
        if not C:
            continue
        rows_checked += 1
        totals = tuple(N + s + 2 * ell for s in range(s_min, s_max + 1))
        diagonal = {
            c: tuple(sorted({Q - c for Q in totals if gcd(c, Q) == 1}))
            for c in C
        }
        d_size, d_matching = maximum_matching(C, diagonal)
        if d_size < len(C):
            full = {c: gamma(N, t, c) for c in C}
            g_size, g_matching = maximum_matching(C, full)
            failure = (
                N, t, q, ell, a, b, s_min, s_max, C, totals,
                diagonal, d_size, d_matching, full, g_size, g_matching,
            )
            break
    if failure is not None:
        break

assert failure is not None
(
    N, t, q, ell, a, b, s_min, s_max, C, totals,
    diagonal, d_size, d_matching, full, g_size, g_matching,
) = failure

assert (N, t) == (32, 16)
assert (q, ell, a, b, s_min, s_max) == (4, 8, 13, 24, 9, 9)
assert C == (14, 16, 17, 18, 19, 20, 21, 22, 23, 24)
assert totals == (57,)
assert d_size == 6
assert tuple(c for c in C if not diagonal[c]) == (18, 19, 21, 24)
assert g_size == len(C) == 10
expected_gamma_matching = (
    (14, 43), (16, 41), (17, 38), (18, 37), (19, 36),
    (20, 33), (21, 40), (22, 39), (23, 34), (24, 35),
)
assert g_matching == expected_gamma_matching
for c, d in g_matching:
    assert d in full[c]
    assert N < d <= N + t
    assert N + t < c + d <= 2 * N
    assert gcd(c, d) == 1

print(f"python_version=3.13.5")
print(f"search_rows_checked={rows_checked}")
print(f"first_diagonal_failure=(N,t)=({N},{t})")
print(f"rectangle=(q,ell,a,b,s_min,s_max)=({q},{ell},{a},{b},{s_min},{s_max})")
print(f"candidate_set={C}")
print(f"feasible_totals={totals}")
print(f"diagonal_neighborhoods={tuple((c, diagonal[c]) for c in C)}")
print(f"diagonal_matching_size={d_size}/{len(C)} matching={d_matching}")
print(f"empty_diagonal_rows={tuple(c for c in C if not diagonal[c])}")
print(f"full_gamma_matching_size={g_size}/{len(C)}")
print(f"full_gamma_matching={g_matching}")
print("diagonal_hall_rejected_but_gamma_hall_passes=PASS")
