"""Exact audits for the max-speed n+5 bounded-height theorem.

Set N=n+1 and H=N+4.  The mathematical argument is uniform for N>=20.
This script certifies all residual N=4,...,19 configurations, checks the
finite totient-exception table, and records the first failure of the
restricted reciprocal/C2/C3 construction separately from loneliness.
"""

from hashlib import sha256
from itertools import combinations
from math import gcd


def rho(q: int, x: int) -> int:
    x %= q
    return min(x, q - x)


def pattern_certificate(
    N: int, H: int, holes: tuple[int, ...], bmax: int = 3
) -> tuple[str, int, int, int] | None:
    hole_set = set(holes)
    for d in holes:
        if d <= N and all(x in hole_set for x in range(d, H + 1, d)):
            return ("R", d, 1, d)
    for b in range(2, bmax + 1):
        for c in holes:
            for q in range(H + 1, b * N + 1):
                if gcd(c, q) != 1:
                    continue
                if all(
                    ((j * c) % q > H or (j * c) % q in hole_set)
                    and ((-j * c) % q > H or (-j * c) % q in hole_set)
                    for j in range(1, b)
                ):
                    return (f"C{b}", q, pow(c, -1, q), c)
    return None


def direct_certificate(N: int, speeds: tuple[int, ...]) -> tuple[str, int, int, int]:
    for q in range(1, 4 * N + 1):
        for r in range(1, q):
            if all(rho(q, r * a) * N >= q for a in speeds):
                return ("X", q, r, 0)
    raise AssertionError((N, speeds))


rows: list[tuple[int, tuple[int, ...], tuple[str, int, int, int]]] = []
fallbacks: list[
    tuple[int, tuple[int, ...], tuple[int, ...], tuple[str, int, int, int]]
] = []

for N in range(4, 20):
    H = N + 4
    case_count = 0
    type_counts: dict[str, int] = {}
    for holes in combinations(range(1, H + 1), 5):
        speeds = tuple(a for a in range(1, H + 1) if a not in holes)
        witness = pattern_certificate(N, H, holes)
        if witness is None:
            witness = direct_certificate(N, speeds)
            fallbacks.append((N, speeds, holes, witness))
        kind, q, r, _c = witness
        assert all(rho(q, r * a) * N >= q for a in speeds)
        rows.append((N, holes, witness))
        case_count += 1
        type_counts[kind] = type_counts.get(kind, 0) + 1
    print(f"N={N} cases={case_count} types={type_counts}")

print(
    f"total={len(rows)} "
    f"certificate_sha256={sha256(repr(tuple(rows)).encode()).hexdigest()}"
)
print(f"fallbacks={fallbacks}")

# The smallest lexicographic failure of reciprocal/C2/C3 is still lonely.
first_N, first_speeds, first_holes, first_witness = fallbacks[0]
assert (first_N, first_speeds, first_holes, first_witness) == (
    4,
    (2, 6, 8),
    (1, 3, 4, 5, 7),
    ("X", 7, 2, 0),
)
assert pattern_certificate(first_N, first_N + 4, first_holes) is None
obstruction_rows: list[tuple[object, ...]] = []
for q in range(first_N + 5, 3 * first_N + 1):
    for c in first_holes:
        if gcd(c, q) != 1:
            obstruction_rows.append((q, c, "nonunit"))
            continue
        required = tuple(sorted({
            x
            for j in (1, 2)
            for x in ((j * c) % q, (-j * c) % q)
            if 1 <= x <= first_N + 4
        }))
        speed_hits = tuple(x for x in required if x in first_speeds)
        assert speed_hits
        obstruction_rows.append((q, c, required, speed_hits))
print(
    f"obstruction_rows={len(obstruction_rows)} "
    f"obstruction_sha256={sha256(repr(tuple(obstruction_rows)).encode()).hexdigest()}"
)

# Exact exceptional table for the uniform N>=20 totient argument.
exception_table: dict[int, tuple[tuple[int, int], ...]] = {
    9: ((20, 34), (21, 35)),
    10: ((20, 37), (21, 37), (22, 37), (23, 39)),
    12: ((20, 37), (21, 41), (22, 41), (23, 41),
         (24, 41), (25, 43), (26, 43), (27, 47)),
    14: ((24, 43), (25, 45), (26, 45), (27, 47),
         (28, 47), (29, 51), (30, 51), (31, 51)),
    15: ((26, 46), (27, 47), (28, 49), (29, 49),
         (30, 52), (31, 52), (32, 52), (33, 53)),
    16: ((28, 49), (29, 51), (30, 51), (31, 53),
         (32, 53), (33, 55), (34, 55), (35, 57)),
    18: ((32, 55), (33, 59), (34, 59), (35, 59),
         (36, 59), (37, 61), (38, 61), (39, 65)),
    20: ((36, 61), (37, 63), (38, 63), (39, 67),
         (40, 67), (41, 67), (42, 67), (43, 69)),
    24: ((44, 73), (45, 77), (46, 77), (47, 77),
         (48, 77), (49, 79), (50, 79), (51, 83)),
    30: ((56, 91), (57, 97), (58, 97), (59, 97),
         (60, 97), (61, 97), (62, 97), (63, 101)),
}

small_totients = (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 15, 16, 18, 20, 24, 30)
expected_pairs = {
    (c, N)
    for c in small_totients
    for N in range(max(20, 2 * c - 4), 2 * c + 4)
}
actual_pairs = {(c, N) for c, rows_c in exception_table.items() for N, _q in rows_c}
assert actual_pairs == expected_pairs
for c, rows_c in exception_table.items():
    for N, q in rows_c:
        assert N + c + 5 <= q <= 2 * N
        assert gcd(c, q) == 1

print(
    f"exception_rows={len(actual_pairs)} "
    f"exception_sha256={sha256(repr(exception_table).encode()).hexdigest()}"
)
