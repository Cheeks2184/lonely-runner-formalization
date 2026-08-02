#!/usr/bin/env python3
"""Exact adversarial audit for the LCM-slice correlation hierarchy.

The structured input is the consecutive-speed tuple (1,...,n).  We enumerate
pivot-grid incidences directly, so no common LCM is constructed and every
quantity is an integer or Fraction.  The theorem proved in the accompanying
document is stronger than the finite scan: it gives an infinite obstruction
family for every fixed correlation depth.
"""

from __future__ import annotations

from fractions import Fraction
from math import comb, gcd


def euler_phi(value: int) -> int:
    """Euler's phi, by an exact trial-division factorization."""
    if value <= 0:
        raise ValueError("phi is defined here only for positive integers")
    result = value
    remaining = value
    prime = 2
    while prime * prime <= remaining:
        if remaining % prime == 0:
            while remaining % prime == 0:
                remaining //= prime
            result -= result // prime
        prime += 1
    if remaining > 1:
        result -= result // remaining
    return result


def correlation_polynomial(n: int, depth: int, bad_count: int) -> Fraction:
    """P_{n,d}(k), with all divisions performed in Fraction."""
    if n < 2 or depth < 1 or not 0 <= bad_count <= n - 1:
        raise ValueError("inadmissible correlation-polynomial parameters")
    prefix = sum(
        (-1) ** q * comb(bad_count, q) for q in range(2 * depth)
    )
    return Fraction(prefix) + Fraction(2 * depth, n - 1) * comb(
        bad_count, 2 * depth
    )


def pivot_bad_count_consecutive(n: int, pivot: int, residue: int) -> int:
    """Number of bad speeds at r/((n+1)*pivot) for speeds 1,...,n."""
    if not 1 <= pivot <= n:
        raise ValueError("pivot must be one of the consecutive speeds")
    modulus = (n + 1) * pivot
    if not 1 <= residue < modulus or residue % (n + 1) == 0:
        raise ValueError("residue must be a pivot candidate")
    count = 0
    for speed in range(1, n + 1):
        phase = (speed * residue) % modulus
        if min(phase, modulus - phase) < pivot:
            count += 1
    return count


def consecutive_histogram(n: int) -> tuple[int, ...]:
    """Weighted D_k histogram, via literal enumeration of every pivot grid."""
    if n < 2:
        raise ValueError("at least two speeds are required")
    histogram = [0] * n
    for pivot in range(1, n + 1):
        modulus = (n + 1) * pivot
        for residue in range(1, modulus):
            if residue % (n + 1) == 0:
                continue
            bad_count = pivot_bad_count_consecutive(n, pivot, residue)
            histogram[bad_count] += 1
    return tuple(histogram)


def score_from_histogram(n: int, depth: int, histogram: tuple[int, ...]) -> Fraction:
    if len(histogram) != n:
        raise ValueError("histogram length must equal n")
    return sum(
        (multiplicity * correlation_polynomial(n, depth, bad_count)
         for bad_count, multiplicity in enumerate(histogram)),
        Fraction(0),
    )


def selected_extreme_contribution(n: int, depth: int) -> Fraction:
    """Contribution of r=+/-1 at pivots 2,...,n-1.

    The closed form is the weighted hockey-stick identity from the proof.
    """
    return -Fraction(2 * comb(n - 1, 2 * depth + 1), n - 1)


def theorem_upper_bound(n: int, depth: int) -> Fraction:
    """Rigorous upper bound for L_{n,d}(1,...,n)."""
    return Fraction(n * euler_phi(n + 1)) + selected_extreme_contribution(
        n, depth
    )


def has_boundary_certificate(n: int) -> bool:
    """Check the explicit certificate t=1/(n+1), using integer numerators."""
    modulus = n + 1
    return all(min(speed % modulus, (-speed) % modulus) >= 1
               for speed in range(1, n + 1))


def safe_grid_count_formula(n: int) -> int:
    """The proved exact D_0 formula for the consecutive tuple."""
    return n * euler_phi(n + 1)


def depth_one_multiple_of_thirty_obstruction(n: int) -> bool:
    """Apply the infinite-family proof for d=1 (N=n+1 divisible by 30)."""
    if n < 29 or (n + 1) % 30 != 0:
        return False
    # The proof uses phi(N) <= 4N/15 and then a strict polynomial inequality.
    phi_majorant = Fraction(4 * n * (n + 1), 15)
    extreme_debt = Fraction((n - 2) * (n - 3), 3)
    return phi_majorant - extreme_debt < 0 and theorem_upper_bound(n, 1) < 0


def fixed_depth_sufficient_condition(n: int, depth: int) -> bool:
    """Elementary explicit sufficient condition for a negative score.

    For d>=2, put k=2d+1.  The proof lower-bounds C(n-1,k) by
    ((n-1)/2)^k/k! and upper-bounds n^2(n-1) by 4(n-1)^3.
    """
    if depth < 2:
        return False
    k = 2 * depth + 1
    return (
        n - 1 >= 2 * k
        and (n - 1) ** (k - 3) > 2 ** (k + 1) * _factorial(k)
    )


def linear_depth_obstruction(n: int) -> bool:
    """A proved linearly growing-depth obstruction family.

    For n == 59 (mod 60), d=(n-3)/4 makes 2d+1=(n-1)/2, so the selected
    extreme-residue debt contains the central binomial coefficient.
    """
    if n < 59 or n % 60 != 59:
        return False
    depth = (n - 3) // 4
    assert 2 * depth + 1 == (n - 1) // 2
    return 2 ** n > n**3 * (n - 1) and theorem_upper_bound(n, depth) < 0


def _factorial(value: int) -> int:
    result = 1
    for factor in range(2, value + 1):
        result *= factor
    return result


def audit_bounded(max_n: int = 35) -> list[tuple[int, int, Fraction]]:
    """Complete finite scan through depth floor((n-1)/2)."""
    rows: list[tuple[int, int, Fraction]] = []
    for n in range(4, max_n + 1):
        histogram = consecutive_histogram(n)
        assert histogram[0] == safe_grid_count_formula(n)
        assert has_boundary_certificate(n)
        for depth in range(1, (n - 1) // 2 + 1):
            score = score_from_histogram(n, depth, histogram)
            assert score <= theorem_upper_bound(n, depth)
            rows.append((n, depth, score))
    return rows


def self_check() -> None:
    # Independent literal checks behind the two identities used by the theorem.
    for n in range(4, 36):
        histogram = consecutive_histogram(n)
        assert histogram[0] == safe_grid_count_formula(n)
        for pivot in range(1, n + 1):
            modulus = (n + 1) * pivot
            assert pivot_bad_count_consecutive(n, pivot, 1) == pivot - 1
            assert pivot_bad_count_consecutive(n, pivot, modulus - 1) == pivot - 1
        for depth in range(1, (n - 1) // 2 + 1):
            literal = sum(
                2 * correlation_polynomial(n, depth, pivot - 1)
                for pivot in range(2, n)
            )
            assert literal == selected_extreme_contribution(n, depth)
            score = score_from_histogram(n, depth, histogram)
            assert score <= theorem_upper_bound(n, depth)

    expected = {
        (7, 1): Fraction(-32, 3),
        (10, 2): Fraction(544, 9),
        (11, 2): Fraction(-156, 5),
        (29, 1): Fraction(-110027, 14),
    }
    cache: dict[int, tuple[int, ...]] = {}
    for (n, depth), value in expected.items():
        cache.setdefault(n, consecutive_histogram(n))
        assert score_from_histogram(n, depth, cache[n]) == value

    for multiplier in range(1, 21):
        assert depth_one_multiple_of_thirty_obstruction(30 * multiplier - 1)
        assert linear_depth_obstruction(60 * multiplier - 1)


def main() -> None:
    self_check()
    rows = audit_bounded(35)
    print("exact bounded scan: 4 <= n <= 35 (all admissible depths)")
    print(f"checked score rows: {len(rows)}")
    for n in (7, 11, 29, 35):
        values = [(d, score) for m, d, score in rows if m == n]
        print(f"n={n}: {values}")
    for depth in range(2, 6):
        n = 29
        while not fixed_depth_sufficient_condition(n, depth):
            n += 30
        print(
            f"d={depth}: elementary fixed-depth condition holds by n={n} "
            f"along n == 29 (mod 30)"
        )
    print("all correlation-obstruction checks passed")


if __name__ == "__main__":
    main()
