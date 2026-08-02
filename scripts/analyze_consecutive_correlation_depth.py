#!/usr/bin/env python3
"""Exact depth profile for the correlation score on A_n=(1,...,n).

This file intentionally uses a literal pivot-grid enumeration.  It is an
audit program, not an efficient proof of a statement for unbounded ``n``.
All score calculations use ``Fraction``.
"""

from __future__ import annotations

import argparse
from fractions import Fraction
from math import comb


def phi(value: int) -> int:
    result = value
    divisor = 2
    remaining = value
    while divisor * divisor <= remaining:
        if remaining % divisor == 0:
            while remaining % divisor == 0:
                remaining //= divisor
            result -= result // divisor
        divisor += 1
    if remaining > 1:
        result -= result // remaining
    return result


def histogram(n: int) -> tuple[int, ...]:
    """Return D_0,...,D_{n-1} by exact pivot-incidence enumeration."""
    result = [0] * n
    modulus_factor = n + 1
    for pivot in range(1, n + 1):
        modulus = modulus_factor * pivot
        for residue in range(1, modulus):
            if residue % modulus_factor == 0:
                continue
            bad = 0
            for speed in range(1, n + 1):
                phase = speed * residue % modulus
                bad += phase < pivot or phase > modulus - pivot
            result[bad] += 1
    return tuple(result)


def maximum_nonextreme_bad_count(n: int) -> tuple[int, tuple[int, int]]:
    """Largest bad count away from the two residues +/-1 on a pivot grid."""
    best = (-1, (0, 0))
    modulus_factor = n + 1
    for pivot in range(1, n + 1):
        modulus = modulus_factor * pivot
        for residue in range(2, modulus - 1):
            if residue % modulus_factor == 0:
                continue
            bad = 0
            for speed in range(1, n + 1):
                phase = speed * residue % modulus
                bad += phase < pivot or phase > modulus - pivot
            if bad > best[0]:
                best = (bad, (pivot, residue))
    return best


def score(n: int, depth: int, counts: tuple[int, ...]) -> Fraction:
    """Use the closed form of P_{n,d}, avoiding alternating cancellation."""
    total = Fraction(counts[0])
    lower = 2 * depth
    for bad in range(lower, n - 1):
        total -= Fraction(
            counts[bad] * (n - 1 - bad) * comb(bad - 1, lower - 1), n - 1
        )
    return total


def minimum_positive_depth(n: int, counts: tuple[int, ...]) -> int:
    for depth in range(1, n // 2 + 1):
        if score(n, depth, counts) > 0:
            return depth
    raise AssertionError("tautological depth must be positive")


def selected_depth_one_debt(n: int, max_residue: int = 4) -> Fraction:
    """Debt from the distinct pivot residues +/-s, 1 <= s <= max_residue.

    At pivot ``p`` their bad count is exactly ``floor((p-1)/s)``.  Terms
    with bad count below two contribute zero to the depth-one score.
    """
    debt = Fraction(0)
    for pivot in range(1, n + 1):
        modulus = (n + 1) * pivot
        for residue in range(1, min(max_residue, pivot - 1) + 1):
            # +s and -s are distinct because 2s < (n+1)p in this range.
            assert 2 * residue < modulus
            bad = (pivot - 1) // residue
            if bad >= 2:
                debt += Fraction(2 * (n - 1 - bad) * (bad - 1), n - 1)
    return debt


def selected_depth_one_obstruction_threshold(max_residue: int = 4) -> int:
    """First point after which the elementary selected debt exceeds n^2."""
    last_failure = 0
    for n in range(4, 2001):
        if selected_depth_one_debt(n, max_residue) <= n * n:
            last_failure = n
    return last_failure + 1


def elementary_depth_one_debt_lower_bound(n: int) -> Fraction:
    """Floor-free lower bound for the debt from +/-1,...,+/-4."""
    # For s=1 the bad count p-1 is exact.
    total = sum(
        Fraction(2 * (n - pivot) * (pivot - 2), n - 1)
        for pivot in range(3, n + 1)
    )
    # For s>=2, k=floor((p-1)/s) lies below the midpoint and the displayed
    # factorwise bounds are nonnegative once p>=2s+1.
    for residue in range(2, 5):
        for pivot in range(2 * residue + 1, n + 1):
            x = Fraction(pivot - 1, residue)
            total += Fraction(2, n - 1) * (n - 1 - x) * (x - 2)
    return total


def elementary_depth_one_debt_closed(n: int) -> Fraction:
    """Closed form of ``elementary_depth_one_debt_lower_bound`` for n>=9."""
    return Fraction(
        490 * n**3 - 5865 * n**2 + 24383 * n - 29064,
        432 * (n - 1),
    )


def high_layer_score(n: int, depth: int) -> Fraction:
    """Closed score when 2d > floor(n/2), proved in the note."""
    if 2 * depth <= n // 2:
        raise ValueError("depth is outside the proved high-layer range")
    return Fraction(n * phi(n + 1)) - Fraction(
        2 * comb(n - 1, 2 * depth + 1), n - 1
    )


def asymptotic_minimum_positive_depth(n: int) -> int:
    """The proved exact d_min formula for every n>=90."""
    if n < 90:
        raise ValueError("the theorem is stated only for n>=90")
    cutoff = n // 2
    if n % 2 == 0:
        return cutoff - 2
    if 3 * n * phi(n + 1) > (n - 2) * (n - 3):
        return cutoff - 2
    return cutoff - 1


def profile(first: int, last: int) -> list[tuple[int, int, int, Fraction]]:
    rows = []
    for n in range(first, last + 1):
        counts = histogram(n)
        assert counts[0] == n * phi(n + 1)
        depth = minimum_positive_depth(n, counts)
        rows.append((n, depth, n // 2 - depth, score(n, depth, counts)))
    return rows


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--first", type=int, default=4)
    parser.add_argument("--last", type=int, default=60)
    parser.add_argument("--tops", type=int, default=0)
    parser.add_argument("--nonextreme", action="store_true")
    parser.add_argument("--all-scores", action="store_true")
    args = parser.parse_args()
    print("proved exact d_min formula applies for every n >= 90")
    for n, depth, gap, value in profile(args.first, args.last):
        suffix = ""
        if args.tops:
            counts = histogram(n)
            suffix = f" top={counts[max(0, n - args.tops):]}"
        if args.nonextreme:
            suffix += f" nonextreme={maximum_nonextreme_bad_count(n)}"
        if args.all_scores:
            counts = histogram(n)
            suffix += " scores=" + repr(
                [(d, score(n, d, counts)) for d in range(1, n // 2 + 1)]
            )
        print(f"n={n:3d} d_min={depth:3d} cutoff-gap={gap:2d} L={value}{suffix}")


if __name__ == "__main__":
    main()
