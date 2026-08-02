"""Exact sanity audit for the residual-compatible family U_N.

This script does not search for a Lonely Runner counterexample.  It checks a
family that satisfies the currently known minimal-counterexample arithmetic
restrictions while still having an explicit lonely time.
"""

from functools import reduce
from hashlib import sha256
from math import gcd, lcm


def rho(q: int, x: int) -> int:
    y = x % q
    return min(y, q - y)


def family(N: int) -> tuple[int, ...]:
    return tuple(range(3, N + 1)) + (N + 4,)


def signed_compatible_replacement_exists(N: int, speeds: tuple[int, ...]) -> bool:
    for old in speeds:
        for new in range(1, old):
            if new in speeds:
                continue
            if all(
                (old - new) % (N * pivot) == 0
                or (old + new) % (N * pivot) == 0
                for pivot in speeds
                if pivot != old
            ):
                return True
    return False


def safe_numerators(N: int, speeds: tuple[int, ...], pivot: int) -> tuple[int, ...]:
    modulus = N * pivot
    return tuple(
        r
        for r in range(1, modulus)
        if r % N != 0
        and all(rho(modulus, r * speed) >= pivot for speed in speeds)
    )


rows: list[tuple[int, int, int, int]] = []
for N in range(5, 501):
    speeds = family(N)
    n = N - 1
    assert len(speeds) == n and len(set(speeds)) == n
    assert speeds[-1] == N + 4
    assert speeds[-1] < n * speeds[-2]
    assert reduce(gcd, speeds) == 1
    assert all(reduce(gcd, speeds[:i] + speeds[i + 1 :]) == 1 for i in range(n))

    counts = tuple(sum(speed % d == 0 for speed in speeds) for d in range(2, N + 1))
    assert all(1 <= count <= n - 2 for count in counts)

    speed_lcm = lcm(*speeds)
    required_lcm = lcm(*range(2, N + 1))
    product = 1
    for speed in speeds:
        product *= speed
    assert speed_lcm % required_lcm == 0
    assert product % speed_lcm == 0 and product <= (N + 4) ** n
    assert not signed_compatible_replacement_exists(N, speeds)

    q = 3 * N
    assert all(N * rho(q, speed) >= q for speed in speeds)
    rows.append((N, min(counts), max(counts), speed_lcm.bit_length()))

U7 = family(7)
S3 = safe_numerators(7, U7, 3)
S6 = safe_numerators(7, U7, 6)
assert S3 == (1, 20)
assert S6 == (2, 3, 5, 37, 39, 40)
assert {2 * r for r in S3} < set(S6)

print("checked_N=5..500")
print(f"row_sha256={sha256(repr(tuple(rows)).encode()).hexdigest()}")
print(f"U7={U7}")
print(f"S3={S3}")
print(f"S6={S6}")
print("witness=t=1/(3N)")
