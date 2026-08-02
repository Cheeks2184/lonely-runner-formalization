"""Exact finite certificate for the max-speed n+4 height theorem.

Here N=n+1 and H=N+3.  The infinite N>=12 argument is mathematical;
this program certifies the residual N=4,...,11 cases and the smallest
obstruction to using only the b=2 inverse pattern.
"""

from hashlib import sha256
from itertools import combinations
from math import gcd


def rho(q: int, x: int) -> int:
    x %= q
    return min(x, q - x)


def certificate(
    N: int, H: int, holes: tuple[int, ...], bmax: int
) -> tuple[str, int, int] | None:
    hole_set = set(holes)

    # Reciprocal certificate: every positive multiple in the height box is absent.
    for d in holes:
        if d <= N and all(x in hole_set for x in range(d, H + 1, d)):
            return ("R", d, 1)

    # Inverse certificate: avoiding +/-c,...,+/-(b-1)c forces residue >=b.
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
                    return (f"C{b}", q, pow(c, -1, q))
    return None


rows: list[tuple[int, tuple[int, ...], tuple[str, int, int]]] = []
for N in range(4, 12):
    H = N + 3
    case_count = 0
    type_counts: dict[str, int] = {}
    for holes in combinations(range(1, H + 1), 4):
        witness = certificate(N, H, holes, 3)
        assert witness is not None, (N, holes)
        speeds = [a for a in range(1, H + 1) if a not in holes]
        kind, q, r = witness
        assert all(rho(q, r * a) * N >= q for a in speeds)
        rows.append((N, holes, witness))
        case_count += 1
        type_counts[kind] = type_counts.get(kind, 0) + 1
    print(f"N={N} cases={case_count} types={type_counts}")

print(f"total={len(rows)} certificate_sha256={sha256(repr(tuple(rows)).encode()).hexdigest()}")

N = 4
H = 7
holes = (1, 2, 5, 6)
speeds = (3, 4, 7)
assert certificate(N, H, holes, 2) is None
witness = certificate(N, H, holes, 3)
assert witness == ("C3", 10, 1)
print(
    "b2_obstruction="
    f"speeds{speeds} holes{holes} b3_witness{witness} "
    f"scaled_residues{tuple(rho(witness[1], witness[2] * a) * N for a in speeds)}"
)
