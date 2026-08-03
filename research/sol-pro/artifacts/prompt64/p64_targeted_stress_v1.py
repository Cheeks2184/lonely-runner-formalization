#!/usr/bin/env python3
"""Prompt 64 targeted strict-large-ratio stress replay.

This is not a second bounded box.  It evaluates a fixed, named list of
boundary/equality/large-gap/scaling/reindexing cases and deterministic
strict-branch mutations of previously tracked stress tuples.

Two independent implementations are compared:
  * literal: direct product, remainder, and cyclic distance for every r;
  * recurrence: per-coordinate modular recurrence, accumulating strict bad flags.
"""
from __future__ import annotations

from dataclasses import dataclass
from hashlib import sha256
from math import gcd
from pathlib import Path
from time import perf_counter
import itertools
import platform

VERSION = "P64-TARGETED-STRESS-v1.0.0"


def rho(M: int, x: int) -> int:
    y = x % M
    return min(y, M - y)


def gcd_all(xs: tuple[int, ...]) -> int:
    g = 0
    for x in xs:
        g = gcd(g, x)
    return g


def safe_literal(speeds: tuple[int, ...], pivot: int) -> tuple[int, ...]:
    n = len(speeds)
    N = n + 1
    P = speeds[pivot]
    M = N * P
    out = []
    for r in range(M):
        if r % N == 0:
            continue
        if all(rho(M, r * s) >= P for s in speeds):
            out.append(r)
    return tuple(out)


def safe_recurrence(speeds: tuple[int, ...], pivot: int) -> tuple[int, ...]:
    n = len(speeds)
    N = n + 1
    P = speeds[pivot]
    M = N * P
    candidate = [r % N != 0 for r in range(M)]
    bad = [False] * M
    for s in speeds:
        y = 0
        step = s % M
        for r in range(M):
            if candidate[r] and (y < P or y > M - P):  # strict badness; equality safe
                bad[r] = True
            y += step
            if y >= M:
                y %= M
    return tuple(r for r in range(M) if candidate[r] and not bad[r])


def first_spoiler(speeds: tuple[int, ...], pivot: int, r: int) -> tuple[int, int, int]:
    N = len(speeds) + 1
    P = speeds[pivot]
    M = N * P
    for i, s in enumerate(speeds):
        d = rho(M, r * s)
        if d < P:
            return i, s, d
    raise AssertionError("candidate is safe")


def distances(speeds: tuple[int, ...], pivot: int, r: int) -> tuple[int, ...]:
    N = len(speeds) + 1
    P = speeds[pivot]
    M = N * P
    return tuple(rho(M, r * s) for s in speeds)


def strict_boundary_mutation(base: tuple[int, ...]) -> tuple[int, ...]:
    lower = base[:-1]
    n = len(base)
    N = n + 1
    A = lower[-1]
    B = (N * A) // 2 + 1
    assert B > A and N * A < 2 * B and B not in lower
    return lower + (B,)


@dataclass(frozen=True)
class Case:
    name: str
    speeds: tuple[int, ...]
    expected_relation: str  # strict, equality, outside


BASES = (
    ("RF", (2, 3, 7, 9, 10, 12, 15, 16, 19)),
    ("GCD_CLOCK_1", (8, 15, 35, 40, 48, 56, 63, 75, 78)),
    ("GCD_CLOCK_2", (6, 8, 15, 21, 28, 35, 40, 48, 75)),
    ("HARD_A", (1, 2, 5, 7, 9, 11, 12, 13)),
    ("HARD_B", (1, 5, 7, 8, 9, 11, 13, 15)),
    ("SMALL_CRT", (1, 2, 3, 5)),
    ("ANCHOR_STAR_C", (8, 15, 35, 40, 48, 56, 68, 75, 78)),
    ("ANCHOR_STAR_D", (10, 37, 45, 51, 54, 56, 61, 71, 91)),
    ("TOP_CYCLE_E", (5, 28, 35, 40, 68, 88, 108, 148, 165)),
    ("CHAIN3_F", (8, 15, 35, 40, 48, 56, 75, 132, 147)),
    ("OPT_ADD_G", (15, 21, 40, 48, 56, 105, 126, 280, 1200)),
    ("AFFINE_HARD_7_98_187", (7, 63, 70, 77, 98, 187)),
)

cases: list[Case] = [
    Case("N2_exact_plus_one_A1", (1, 2), "strict"),
    Case("N2_exact_plus_one_A3", (3, 5), "strict"),
    Case("N2_equality", (2, 3), "equality"),
    Case("N3_equality", (1, 2, 4), "equality"),
    Case("N4_equality", (1, 2, 4, 10), "equality"),
    Case("N5_equality", (1, 2, 3, 4, 12), "equality"),
    Case("N2_parity_next_A2", (2, 4), "strict"),
    Case("N2_large_gap", (1, 1000), "strict"),
    Case("one_sided_A_empty", (1, 2, 8), "strict"),
    Case("extremal_singleton_exception", (1, 3, 8), "strict"),
    Case("bounded_block_family_failure", (4, 5, 12), "strict"),
    Case("sparse_lower", (1, 11, 23, 47, 89, 313), "strict"),
    Case("divisibility_NA_multiple", (1, 7, 14, 21, 35, 245), "strict"),
    Case("affine_residue", (7, 63, 70, 77, 98, 344), "strict"),
    Case("nonprimitive_scale2", (2, 4, 16), "strict"),
    Case("nonprimitive_scale6", (6, 18, 48), "strict"),
    Case("large_gap_sparse", (3, 10, 29, 87, 5000), "strict"),
]

# Original tracked rows are recorded as outside/equality/strict, then their
# deterministic smallest-integer strict-boundary mutation is evaluated.
for name, base in BASES:
    n = len(base)
    N = n + 1
    A, B = base[-2], base[-1]
    relation = "strict" if N * A < 2 * B else ("equality" if N * A == 2 * B else "outside")
    cases.append(Case(name + "_ORIGINAL", base, relation))
    cases.append(Case(name + "_BOUNDARY_PLUS", strict_boundary_mutation(base), "strict"))

# Consecutive/near-saturated strict-boundary rows.
for N in range(4, 21):
    lower = tuple(range(1, N - 1))
    A = N - 2
    B = (N * A) // 2 + 1
    cases.append(Case(f"CONSECUTIVE_BOUNDARY_N{N}", lower + (B,), "strict"))

# Deterministic deletion mutation: delete one interior lower coordinate from F,
# recompute N and the smallest strict-boundary B.
F_lower = BASES[9][1][:-1]
for deleted_pos in (1, 4, 6):
    lower = F_lower[:deleted_pos] + F_lower[deleted_pos + 1 :]
    n = len(lower) + 1
    N = n + 1
    B = (N * lower[-1]) // 2 + 1
    cases.append(Case(f"CHAIN3_F_DELETE_{deleted_pos}_BOUNDARY_PLUS", lower + (B,), "strict"))

start = perf_counter()
rows = []
literal_candidates = 0
recurrence_candidates = 0
strict_rows = 0
strict_failures = []
for case in cases:
    speeds = case.speeds
    assert len(speeds) >= 2 and tuple(sorted(speeds)) == speeds
    assert len(set(speeds)) == len(speeds) and all(s > 0 for s in speeds)
    n = len(speeds)
    N = n + 1
    A, B = speeds[-2], speeds[-1]
    lhs, rhs = N * A, 2 * B
    actual_relation = "strict" if lhs < rhs else ("equality" if lhs == rhs else "outside")
    assert actual_relation == case.expected_relation, (case, lhs, rhs)

    safeA_lit = safe_literal(speeds, n - 2)
    safeA_rec = safe_recurrence(speeds, n - 2)
    safeB_lit = safe_literal(speeds, n - 1)
    safeB_rec = safe_recurrence(speeds, n - 1)
    assert safeA_lit == safeA_rec
    assert safeB_lit == safeB_rec
    literal_candidates += N * A - A + N * B - B
    recurrence_candidates += N * A - A + N * B - B

    if actual_relation == "strict":
        strict_rows += 1
        if not safeA_lit and not safeB_lit:
            strict_failures.append(case.name)

    rows.append((
        case.name, speeds, gcd_all(speeds), actual_relation, lhs, rhs,
        len(safeA_lit), safeA_lit[0] if safeA_lit else None,
        len(safeB_lit), safeB_lit[0] if safeB_lit else None,
        distances(speeds, n - 2, safeA_lit[0]) if safeA_lit else None,
        distances(speeds, n - 1, safeB_lit[0]) if safeB_lit else None,
    ))

assert not strict_failures

# Exact rejected-strengthening certificates.
# (1) The extremal interval can be a divisible singleton.
speeds = (1, 3, 8); N = 4; A = 3; B = 8; m = 1
L = (B + m - 1) // m
U = ((N - 1) * B) // A
assert (L, U) == (8, 8) and L % N == 0
assert 14 in safe_literal(speeds, 2)
extremal_cert = (L, U, 14, distances(speeds, 2, 14))

# (2) A-grid is completely covered on (1,2,8), but B has r=9.
speeds = (1, 2, 8); N = 4
A_candidates = tuple(r for r in range(N * 2) if r % N != 0)
A_spoilers = tuple((r,) + first_spoiler(speeds, 1, r) for r in A_candidates)
assert safe_literal(speeds, 1) == () and 9 in safe_literal(speeds, 2)
one_sided_cert = (A_spoilers, 9, distances(speeds, 2, 9))

# (3) The no-wrap bounded family kB +/- d, 1<=d<=floor(N/2), can miss all certs.
speeds = (4, 5, 12); N = 4; B = 12
restricted = set()
for k in range(N):
    for d in range(1, N // 2 + 1):
        for r in (k * B - d, k * B + d):
            if 0 <= r < N * B and r % N != 0:
                restricted.add(r)
restricted = tuple(sorted(restricted))
restricted_spoilers = tuple((r,) + first_spoiler(speeds, 2, r) for r in restricted)
fullB = safe_literal(speeds, 2)
assert set(restricted).isdisjoint(fullB)
assert 3 in fullB
block_cert = (restricted, restricted_spoilers, fullB, 3, distances(speeds, 2, 3))

# Common-scaling equivalence, checked at the level of complete safe sets.
scaling_checks = 0
for base in ((1, 2, 8), (1, 3, 8), (4, 5, 12), (7, 63, 70, 77, 98, 344)):
    for d in (2, 3, 5):
        scaled = tuple(d * s for s in base)
        for pivot in (len(base) - 2, len(base) - 1):
            base_safe = set(safe_literal(base, pivot))
            scaled_safe = set(safe_literal(scaled, pivot))
            M0 = (len(base) + 1) * base[pivot]
            expected = {r for r in range(d * M0) if r % (len(base) + 1) != 0 and r % M0 in base_safe}
            assert scaled_safe == expected
            scaling_checks += 1

# Explicit reindexings: pivot values, not positions, determine the same safe sets.
reindex_checks = 0
for base in ((1, 2, 8), (4, 5, 12), (7, 63, 70, 77, 98, 344)):
    n = len(base)
    perms = [tuple(range(n)), tuple(reversed(range(n))), tuple((i + 1) % n for i in range(n))]
    baseline = {base[p]: safe_literal(base, p) for p in (n - 2, n - 1)}
    for perm in perms:
        permuted = tuple(base[i] for i in perm)
        for value in (base[-2], base[-1]):
            p = permuted.index(value)
            assert safe_literal(permuted, p) == baseline[value]
            reindex_checks += 1

elapsed = perf_counter() - start

print(f"version={VERSION}")
print(f"python={platform.python_version()}")
print("domain=fixed named stress list; originals plus deterministic boundary-plus mutations; consecutive N=4..20; three deletion mutations")
print("order=listed order in source")
print(f"case_count={len(cases)}")
print(f"strict_case_count={strict_rows}")
print(f"literal_candidates={literal_candidates}")
print(f"recurrence_candidates={recurrence_candidates}")
print(f"literal_recurrence_agreement={2 * len(cases)}")
print(f"strict_two_top_failures={len(strict_failures)}")
print(f"scaling_checks={scaling_checks}")
print(f"reindex_checks={reindex_checks}")
print(f"runtime_seconds={elapsed:.6f}")
print("ROWS")
print("name|speeds|gcd|relation|NA|2B|safeA_count|firstA|safeB_count|firstB|distA|distB")
for row in rows:
    print("|".join(str(x) for x in row))
print("REJECTED_EXTREMAL_INTERVAL_ALWAYS_NONEXCEPTIONAL")
print(f"speeds=(1,3,8)|L={extremal_cert[0]}|U={extremal_cert[1]}|surviving_B_r={extremal_cert[2]}|distances={extremal_cert[3]}")
print("REJECTED_ONE_SIDED_A_NONEMPTY")
print(f"A_spoilers={one_sided_cert[0]}|surviving_B_r={one_sided_cert[1]}|distances={one_sided_cert[2]}")
print("REJECTED_BOUNDED_KB_PM_D_FAMILY")
print(f"restricted={block_cert[0]}")
print(f"spoilers={block_cert[1]}")
print(f"full_B_safe={block_cert[2]}|surviving_r={block_cert[3]}|distances={block_cert[4]}")
