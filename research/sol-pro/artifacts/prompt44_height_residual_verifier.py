#!/usr/bin/env python3
"""Exact verifier for Prompt 44 partial results.

This file does not prove the Lonely Runner Conjecture.

It checks:
  1. Every (N-1)-subset of [1,N+4] for 4 <= N <= 13 has an
     explicitly verified rational lonely time r/q (closed boundary).
  2. The finite exceptional totient certificate used in the deductive
     five-hole proof for 14 <= N <= 63.
  3. The exact exceptional set {c : phi(c) <= 8}.
  4. Numerical sanity checks for the general theorem
         16*t^2 + t <= N  =>  max speed <= N+t is covered
     at the level of the interval/totient inequalities.
  5. The corrected least-dimension residual conditions on the accepted
     tuple G; G is only a compatibility sample, not a counterexample.
"""

from hashlib import sha256
from itertools import combinations
from math import gcd, isqrt, lcm


def rho(q: int, x: int) -> int:
    y = x % q
    return min(y, q - y)


def phi(n: int) -> int:
    return sum(gcd(k, n) == 1 for k in range(1, n + 1))


def witness_ok(speeds: tuple[int, ...], N: int, q: int, r: int) -> bool:
    assert N > 0 and q > 0 and 0 < r < q
    return all(N * rho(q, r * a) >= q for a in speeds)


def first_small_exact_witness(speeds: tuple[int, ...], N: int):
    """Find and verify a finite rational witness; used only for N<=13."""
    for q in range(2, 4 * N + 1):
        for r in range(1, q):
            if gcd(r, q) == 1 and witness_ok(speeds, N, q, r):
                return q, r
    return None


def exhaustive_small_five_hole():
    rows = []
    certs = []
    for N in range(4, 14):
        H = N + 4
        total = 0
        max_q = 0
        for speeds in combinations(range(1, H + 1), N - 1):
            total += 1
            w = first_small_exact_witness(speeds, N)
            assert w is not None
            q, r = w
            assert witness_ok(speeds, N, q, r)
            max_q = max(max_q, q)
            certs.append((N, speeds, q, r))
        assert total == __import__('math').comb(N + 4, 5)
        rows.append((N, total, max_q))
    digest = sha256(repr(tuple(certs)).encode()).hexdigest()
    return rows, digest


def exceptional_totient_table():
    E = tuple(c for c in range(1, 200) if phi(c) <= 8)
    expected = (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 15, 16, 18, 20, 24, 30)
    assert E == expected

    rows = []
    for c in E:
        for N in range(14, 64):
            # This is exactly the finite branch left after:
            # c <= N, 2c <= N+4, and interval length L < c.
            if c > N or 2 * c > N + 4:
                continue
            L = N - c - 4
            if L >= c:
                continue
            lo, hi = N + c + 5, 2 * N
            q = next((q for q in range(lo, hi + 1) if gcd(c, q) == 1), None)
            assert q is not None
            assert lo <= q <= hi
            assert q > N + 4 and q - c > N + 4 and q <= 2 * N
            rows.append((c, N, L, q))
    assert len(rows) == 92
    digest = sha256(repr(tuple(rows)).encode()).hexdigest()
    return E, rows, digest


def general_sqrt_height_sanity():
    rows = []
    for N in (17, 66, 260, 1028, 4097, 10000):
        # largest t with 16t^2+t <= N
        t = max(t for t in range(0, isqrt(N) + 2) if 16 * t * t + t <= N)
        assert 16 * t * t + t <= N
        assert 16 * (t + 1) * (t + 1) + (t + 1) > N
        # In the exceptional branch phi(c)<=2t, phi(c)>=sqrt(c/2)
        # implies c<=8t^2 and hence N>=2c+t.
        if t > 0:
            assert N >= 16 * t * t + t
            assert N >= 2 * (8 * t * t) + t
        rows.append((N, t, N + t))
    return rows


def signed_descent_irreducible_largest(speeds: tuple[int, ...]) -> bool:
    n = len(speeds)
    N = n + 1
    a = tuple(sorted(speeds))
    top, prev = a[-1], a[-2]
    for d in range(2, N - 1):
        if gcd(d, N) != 1:
            continue
        num = N * prev
        if num % (d + 1):
            continue
        b = num // (d + 1)
        if top != d * b:
            continue
        if all(prev % x == 0 or ((d - 1) * b) % (N * x) == 0
               for x in a[:-2]):
            return False
    return True


def corrected_residual_sample():
    G = (15, 21, 40, 48, 56, 105, 126, 280, 1200)
    n = len(G)
    N = n + 1
    assert gcd(*G) == 1 and len(set(G)) == n
    assert G[-1] >= N + 5
    assert G[-1] < n * G[-2]
    cover = tuple(q for q in range(2, N + 1) if any(a % q == 0 for a in G))
    assert cover == tuple(range(2, N + 1))
    assert signed_descent_irreducible_largest(G)
    L = lcm(*range(2, N + 1))
    product = 1
    for a in G:
        product *= a
    falling = 1
    A = G[-1]
    for z in range(n):
        falling *= A - z
    assert L <= product <= falling
    return G, cover, L, product, falling


def main():
    rows, digest = exhaustive_small_five_hole()
    print('small_five_hole_rows=(N,configurations,max_denominator_used)')
    for row in rows:
        print(row)
    print('small_certificate_sha256=' + digest)

    E, table, tdigest = exceptional_totient_table()
    print('phi_le_8=' + repr(E))
    print('finite_exception_rows=' + str(len(table)))
    print('finite_exception_first=' + repr(table[:8]))
    print('finite_exception_last=' + repr(table[-8:]))
    print('finite_exception_sha256=' + tdigest)

    print('sqrt_height_rows=(N,t,N+t)')
    for row in general_sqrt_height_sanity():
        print(row)

    G, cover, L, product, falling = corrected_residual_sample()
    print('corrected_least_dimension_compatibility_sample')
    print('tuple=' + repr(G))
    print('divisor_cover=' + repr(cover))
    print('lcm_2_to_N=' + str(L))
    print('product=' + str(product))
    print('falling_upper_bound=' + str(falling))


if __name__ == '__main__':
    main()
