"""Exact audit of the elementary logarithmic bounded-height theorem.

The proof itself is deductive.  This script checks its arithmetic selector
through N=500 and every admissible hole configuration through N=60 using only
integer modular-distance inequalities.
"""

from hashlib import sha256
from itertools import combinations
from math import gcd


def nat_log2(N: int) -> int:
    assert N > 0
    return N.bit_length() - 1


def denominator(N: int) -> int:
    return 4 * (nat_log2(N) + 1) + 1


def rho(q: int, x: int) -> int:
    y = x % q
    return min(y, q - y)


def missing_height_witness(
    N: int, t: int, holes: tuple[int, ...]
) -> tuple[str, int, int, int]:
    H = N + t
    c = next(hole for hole in holes if hole <= N)
    if 2 * c > H:
        return ("R", c, 1, c)

    lo, hi = N + c + t + 1, 2 * N
    q = next(q for q in range(lo, hi + 1) if gcd(c, q) == 1)
    return ("C2", q, pow(c, -1, q), c)


nonreciprocal = 0
short = 0
selector_digest = sha256()
for N in range(2, 501):
    D = denominator(N)
    for t in range(1, N // D + 1):
        H = N + t
        assert D * t <= N
        for c in range(1, N + 1):
            if 2 * c > H:
                continue
            nonreciprocal += 1
            L = N - c - t
            assert L >= 1
            lo, hi = N + c + t + 1, 2 * N
            q = next((q for q in range(lo, hi + 1) if gcd(c, q) == 1), None)
            assert q is not None
            assert lo <= q <= hi and q - c > H
            if L < c:
                short += 1
                selector_digest.update(repr((N, t, c, L, q)).encode() + b"\n")

assert nonreciprocal == 553_106
assert short == 15_955

configurations = 0
certificate_digest = sha256()
for N in range(2, 61):
    D = denominator(N)
    for t in range(1, N // D + 1):
        H = N + t
        for holes in combinations(range(1, H + 1), t + 1):
            witness = missing_height_witness(N, t, holes)
            _kind, q, r, _c = witness
            speeds = tuple(a for a in range(1, H + 1) if a not in holes)
            assert len(speeds) == N - 1
            assert all(N * rho(q, r * a) >= q for a in speeds)
            certificate_digest.update(
                repr((N, t, holes, witness)).encode() + b"\n"
            )
            configurations += 1

assert configurations == 361_220

print("arithmetic_N=2..500")
print(f"nonreciprocal_cases={nonreciprocal}")
print(f"short_interval_cases={short}")
print(f"short_selector_sha256={selector_digest.hexdigest()}")
print("hole_configurations_N=2..60")
print(f"configurations={configurations}")
print(f"certificate_sha256={certificate_digest.hexdigest()}")
print("samples=(N,N_div_D,N_plus_N_div_D)")
for N in (21, 60, 100, 500, 1000, 10_000, 1_000_000):
    gain = N // denominator(N)
    print((N, gain, N + gain))
