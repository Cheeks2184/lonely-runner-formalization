from __future__ import annotations

from fractions import Fraction
from math import gcd, isqrt


def primes_up_to(n: int) -> list[int]:
    out: list[int] = []
    for x in range(2, n + 1):
        if all(x % p for p in out if p * p <= x):
            out.append(x)
    return out


def phi(n: int) -> int:
    if n == 1:
        return 1
    z, x = n, n
    p = 2
    while p * p <= x:
        if x % p == 0:
            while x % p == 0:
                x //= p
            z -= z // p
        p += 1
    if x > 1:
        z -= z // x
    return z


def primorial_ratio(N: int) -> tuple[int, int, int]:
    P = Q = 1
    k = 0
    known: list[int] = []
    x = 2
    while True:
        prime = all(x % p for p in known if p * p <= x)
        if prime:
            known.append(x)
            if P * x > N:
                break
            P *= x
            Q *= x - 1
            k += 1
        x += 1
    return k, P, Q


def gain(N: int) -> tuple[int, int]:
    k, P, Q = primorial_ratio(N)
    exact = (N * Q - 1) // (4 * P - Q)
    old = N // (4 * ((N.bit_length() - 1) + 1) + 1)
    return exact, old

# Verify the exact maximum ratio formula for every N <= 5000.
limit = 5000
phis = list(range(limit + 1))
for p0 in range(2, limit + 1):
    if phis[p0] == p0:
        for z in range(p0, limit + 1, p0):
            phis[z] -= phis[z] // p0
phis[1] = 1
plist = primes_up_to(limit)
next_index = 0
P_run = Q_run = 1
running = Fraction(1, 1)
for N in range(1, limit + 1):
    running = max(running, Fraction(N, phis[N]))
    while next_index < len(plist) and P_run * plist[next_index] <= N:
        p0 = plist[next_index]
        P_run *= p0
        Q_run *= p0 - 1
        next_index += 1
    assert running == Fraction(P_run, Q_run), (N, running, Fraction(P_run, Q_run))

samples = [16, 27, 32, 100, 210, 1000, 2310, 10000, 30030, 1_000_000]
print("primorial_height_samples")
for N in samples:
    k, P, Q = primorial_ratio(N)
    exact, old = gain(N)
    print(N, k, P, Q, f"{P}/{Q}", exact, old)

# Infinite compatible residual family: (2,3,...,N-1,2N), N >= 6.
print("compatible_family_checks")
for N in range(6, 51):
    speeds = tuple(range(2, N)) + (2 * N,)
    assert len(speeds) == N - 1
    assert len(set(speeds)) == N - 1
    g = 0
    for a in speeds:
        g = gcd(g, a)
    assert g == 1

    # Every deletion gcd is one.
    for j in range(len(speeds)):
        d = 0
        for i, a in enumerate(speeds):
            if i != j:
                d = gcd(d, a)
        assert d == 1, (N, j, d)

    # Divisor cover for 2,...,N.
    for q in range(2, N + 1):
        assert any(a % q == 0 for a in speeds), (N, q)

    A, B, n = speeds[-1], speeds[-2], N - 1
    assert A < n * B
    assert 2 * A <= N * B  # blocks the largest-speed signed descent

    # Direct lonely time 1/(N+1): every residue has circular distance >= 2.
    q = N + 1
    numerators = [min(a % q, q - (a % q)) for a in speeds]
    assert min(numerators) >= 2
    assert all(N * d >= q for d in numerators)

print("family_N_range", 6, 50)
print("family_example_N10", tuple(range(2, 10)) + (20,))
print("family_example_distance_numerators_mod11",
      tuple(min(a % 11, 11 - (a % 11)) for a in tuple(range(2, 10)) + (20,)))

# Stronger compatible family with active terminal interval and max 2N-2.
print("active_terminal_family_checks")
for N in range(10, 51):
    core = {N}
    core.update(2 * m for m in range((N + 1) // 2, N))
    speeds_set = set(core)
    x = 2
    while len(speeds_set) < N - 1:
        speeds_set.add(x)
        x += 1
    speeds = tuple(sorted(speeds_set))
    assert len(speeds) == N - 1
    assert speeds[-1] == 2 * N - 2
    assert N in speeds
    assert all(2 <= a <= 2 * N - 2 for a in speeds)

    # Primitive and deletion-gcd-one.
    g = 0
    for a in speeds:
        g = gcd(g, a)
    assert g == 1
    for j in range(len(speeds)):
        d = 0
        for i, a in enumerate(speeds):
            if i != j:
                d = gcd(d, a)
        assert d == 1, (N, speeds, j, d)

    # Divisor cover.
    for q0 in range(2, N + 1):
        assert any(a % q0 == 0 for a in speeds), (N, q0, speeds)

    # Comparable top and inactive signed replacement by the 2A <= NB alternative.
    A, B, n = speeds[-1], speeds[-2], N - 1
    assert A < n * B
    assert 2 * A <= N * B

    # Terminal interval condition is active and satisfied.
    assert A < 2 * N
    for q0 in range(A // 2 + 1, N + 1):
        assert q0 in speeds

    # Direct closed-boundary witness t=1/(2N).
    numerators = [min(a % (2 * N), 2 * N - (a % (2 * N))) for a in speeds]
    assert min(numerators) >= 2
    assert all(N * d >= 2 * N for d in numerators)

print("active_family_N_range", 10, 50)
N = 10
core = {N} | {2 * m for m in range((N + 1) // 2, N)}
ss = set(core)
x = 2
while len(ss) < N - 1:
    ss.add(x); x += 1
example = tuple(sorted(ss))
print("active_family_example_N10", example)
print("active_family_example_numerators_mod20",
      tuple(min(a % 20, 20 - a % 20) for a in example))
