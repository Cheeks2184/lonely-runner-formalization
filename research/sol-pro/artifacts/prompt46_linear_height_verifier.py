#!/usr/bin/env python3
from math import gcd
from hashlib import sha256


def omega(n: int) -> int:
    assert n >= 1
    k = 0
    p = 2
    while p * p <= n:
        if n % p == 0:
            k += 1
            while n % p == 0:
                n //= p
        p += 1 if p == 2 else 2
    if n > 1:
        k += 1
    return k


def jacobsthal(n: int) -> int:
    """Least L such that every L consecutive integers contains one coprime to n."""
    assert n >= 1
    if n == 1:
        return 1
    cop = [r for r in range(1, n + 1) if gcd(r, n) == 1]
    return max(b - a for a, b in zip(cop, cop[1:] + [cop[0] + n]))


def interval_has_coprime(N: int, t: int, c: int) -> bool:
    start = N + c + t + 1
    ell = N - c - t
    assert ell >= 0
    assert start + ell == 2 * N + 1
    return any(gcd(q, c) == 1 for q in range(start, start + ell))


def audit_triples(Nmax: int, coeff_num: int, coeff_den: int) -> int:
    """Check coeff_num*t <= coeff_den*N; count non-reciprocal branches."""
    count = 0
    for N in range(1, Nmax + 1):
        for t in range(1, N + 1):
            if coeff_num * t > coeff_den * N:
                continue
            for c in range(1, N + 1):
                if N + t < 2 * c:  # reciprocal branch
                    continue
                count += 1
                assert c + t <= N, (N, t, c)
                assert interval_has_coprime(N, t, c), (N, t, c)
    return count


def main() -> None:
    small = tuple(jacobsthal(c) for c in range(1, 7))
    assert small == (1, 2, 2, 2, 2, 4)

    kanold_max = 5000
    for c in range(1, kanold_max + 1):
        assert jacobsthal(c) <= 2 ** omega(c), c
        if c >= 7:
            assert 5 * (2 ** omega(c)) <= 2 * c, c

    # Stronger exact linear condition 17*t <= 3*N.
    triple_count_17_3 = audit_triples(500, 17, 3)
    # The proposed simpler corollary 6*t <= N.
    triple_count_6_1 = audit_triples(500, 6, 1)

    # Coefficient-five local selector obstruction.
    N, t, c = 11, 2, 6
    assert 5 * t <= N
    assert 2 * c <= N + t
    start = N + c + t + 1
    ell = N - c - t
    vals = tuple(range(start, start + ell))
    assert vals == (20, 21, 22)
    assert all(gcd(q, c) > 1 for q in vals)
    assert ell == 3 < jacobsthal(6) == 4

    print(f"small_g={small}")
    print(f"kanold_checked_through={kanold_max}")
    print(f"linear_17t_le_3N_nonreciprocal_triples_N_le_500={triple_count_17_3}")
    print(f"linear_6t_le_N_nonreciprocal_triples_N_le_500={triple_count_6_1}")
    print(f"coefficient5_local_failure=(N,t,c)=({N},{t},{c}) interval={vals}")


if __name__ == "__main__":
    main()
