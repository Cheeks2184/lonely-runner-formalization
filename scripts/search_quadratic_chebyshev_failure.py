#!/usr/bin/env python3
"""Exact search for all-pivot failure of the Response-44 quadratic minorant.

This is a scratch audit: it deliberately computes the first two collision
moments literally from pivot residues.  It keeps the full Chebyshev score and
an actual safe residue separate from the quadratic sufficient condition.
"""

from __future__ import annotations

import argparse
from fractions import Fraction
from hashlib import sha256
from itertools import combinations
from math import comb, gcd


def degree(n: int) -> int:
    # These are the exact prescribed ceilings for the only dimensions reached
    # by the canonical search.  Keeping them explicit avoids a floating-point
    # precomputation inside an otherwise exact certificate generator.
    exact_audited_degrees = {3: 3, 4: 4, 5: 5}
    if n not in exact_audited_degrees:
        raise ValueError("the exact audited degree table covers only n=3,4,5")
    return exact_audited_degrees[n]


def scaled_T(r: int, y: int, c: int) -> int:
    if r == 0:
        return 1
    if r == 1:
        return y
    a, b = 1, y
    cc = c * c
    for _ in range(2, r + 1):
        a, b = b, 2 * y * b - cc * a
    return b


def polynomial(n: int) -> tuple[int, int, tuple[int, ...]]:
    """degree, positive denominator, and integer numerators of P_n(k)."""
    assert n >= 3
    m, c, r = n - 1, n - 2, degree(n)
    cp = c**r
    den = scaled_T(r, m + 1, c) - cp
    nums = tuple(scaled_T(r, m + 1 - 2 * k, c) - cp for k in range(n))
    assert den > 0 and nums[0] == den
    assert all(-den < nums[k] <= 0 for k in range(1, n))
    return r, den, nums


def alpha(n: int, den: int, nums: tuple[int, ...]) -> Fraction:
    values = [Fraction(nums[k] + (k - 1) * den, den * comb(k, 2)) for k in range(2, n)]
    out = min(values)
    assert out > 0
    for k in range(n):
        lhs = Fraction(nums[k], den)
        rhs = 1 - k + out * comb(k, 2)
        assert lhs >= rhs
    return out


def rho(M: int, x: int) -> int:
    y = x % M
    return min(y, M - y)


def pivot_row(a: tuple[int, ...], j: int, den: int, nums: tuple[int, ...], al: Fraction):
    """Return literal H0,H1,H2, scaled quadratic score, full score, safe r."""
    n, N, A = len(a), len(a) + 1, a[j]
    M = N * A
    H0 = H1 = H2 = full_num = safe = 0
    for r in range(1, M):
        if r % N == 0:
            continue
        H0 += 1
        k = sum(rho(M, a[i] * r) < A for i in range(n) if i != j)
        H1 += k
        H2 += comb(k, 2)
        full_num += nums[k]
        if k == 0 and safe == 0:
            safe = r
    assert H0 == n * A
    q_num = al.denominator * (H0 - H1) + al.numerator * H2
    # q_num/al.denominator is the lower bound; full_num/den is exact score.
    assert Fraction(full_num, den) >= Fraction(q_num, al.denominator)
    return H0, H1, H2, q_num, full_num, safe


def primitive(a: tuple[int, ...]) -> bool:
    g = 0
    for x in a:
        g = gcd(g, x)
    return g == 1


def scan_box(n: int, B: int):
    r, den, nums = polynomial(n)
    al = alpha(n, den, nums)
    checked = 0
    digest_rows = []
    for a in combinations(range(1, B + 1), n):
        if a[-1] != B or not primitive(a):
            continue
        checked += 1
        rows = tuple(pivot_row(a, j, den, nums, al) for j in range(n))
        signs = tuple((row[3] > 0) - (row[3] < 0) for row in rows)
        digest_rows.append((a, tuple(row[3] for row in rows)))
        if max(row[3] for row in rows) <= 0:
            return checked, sha256(repr(tuple(digest_rows)).encode()).hexdigest(), (r, den, nums, al, a, rows)
    return checked, sha256(repr(tuple(digest_rows)).encode()).hexdigest(), None


def main() -> None:
    p = argparse.ArgumentParser()
    p.add_argument("--n-max", type=int, default=5, choices=range(3, 6))
    p.add_argument("--B-max", type=int, default=40)
    args = p.parse_args()
    grand = 0
    transcript = []
    for n in range(3, args.n_max + 1):
        r, den, nums = polynomial(n)
        al = alpha(n, den, nums)
        print(f"n={n} degree={r} Pden={den} alpha={al}", flush=True)
        for B in range(n, args.B_max + 1):
            count, h, found = scan_box(n, B)
            grand += count
            transcript.append((n, B, count, h))
            print(f"  shell_max={B} primitive={count} hash={h[:16]}", flush=True)
            if found is not None:
                rr, dd, nn, aa, tup, rows = found
                print(f"FOUND tuple={tup} n={n} degree={rr} Pden={dd} alpha={aa}")
                for j, row in enumerate(rows):
                    H0, H1, H2, qnum, fnum, safe = row
                    print(
                        f"pivot={tup[j]} H=({H0},{H1},{H2}) "
                        f"quadratic_scaled={qnum}/{aa.denominator} "
                        f"full_scaled={fnum}/{dd} full_sign={(fnum>0)-(fnum<0)} "
                        f"safe_r={safe} time={safe}/{(n+1)*tup[j] if safe else 0}"
                    )
                print(f"checked_total={grand}")
                print(f"transcript_sha256={sha256(repr(tuple(transcript)).encode()).hexdigest()}")
                return
    print(f"NO_FAILURE checked_total={grand}")
    print(f"transcript_sha256={sha256(repr(tuple(transcript)).encode()).hexdigest()}")


if __name__ == "__main__":
    main()
