#!/usr/bin/env python3
"""Numerically audit the fixed-pivot Fourier formulas.

This is regression evidence for ``docs/fourier-pivot-badsets.md``, not a
floating-point proof and not a proof of the Lonely Runner Conjecture.
"""

from __future__ import annotations

import argparse
import cmath
import math
from collections.abc import Sequence


def normalized_dft(values: Sequence[int]) -> list[complex]:
    """Return the normalized discrete Fourier transform."""
    modulus = len(values)
    return [
        sum(
            value * cmath.exp(-2j * math.pi * frequency * residue / modulus)
            for residue, value in enumerate(values)
        )
        / modulus
        for frequency in range(modulus)
    ]


def candidate_coefficient(modulus: int, denominator: int, frequency: int) -> float:
    """Closed formula for the nondivisibility-filter coefficient."""
    pivot = modulus // denominator
    return float(frequency % modulus == 0) - (
        1 / denominator if frequency % pivot == 0 else 0
    )


def pulled_interval_coefficient(
    denominator: int, pivot: int, other: int, frequency: int
) -> complex:
    """Closed gcd/Dirichlet formula for ``rho_M(other*r) < pivot``."""
    modulus = denominator * pivot
    divisor = math.gcd(other, modulus)
    quotient = modulus // divisor
    if frequency % divisor:
        return 0j
    if quotient == 1:
        return 1 + 0j
    reduced_other = other // divisor
    inverse = pow(reduced_other, -1, quotient)
    reduced_frequency = (frequency // divisor) * inverse % quotient
    radius = (pivot - 1) // divisor
    return sum(
        cmath.exp(-2j * math.pi * reduced_frequency * point / quotient)
        for point in range(-radius, radius + 1)
    ) / quotient


def audit(max_denominator: int, max_pivot: int, other_multiplier: int) -> int:
    """Check every coefficient in the requested deterministic box."""
    checked = 0
    tolerance = 1e-9
    for denominator in range(2, max_denominator + 1):
        for pivot in range(1, max_pivot + 1):
            modulus = denominator * pivot
            candidates = [int(residue % denominator != 0) for residue in range(modulus)]
            candidate_dft = normalized_dft(candidates)
            for frequency, actual in enumerate(candidate_dft):
                expected = candidate_coefficient(modulus, denominator, frequency)
                if abs(actual - expected) >= tolerance:
                    raise AssertionError(("candidate", denominator, pivot, frequency))

            for other in range(0, other_multiplier * modulus + 1):
                pulled = [
                    int(min((other * residue) % modulus,
                            modulus - (other * residue) % modulus) < pivot)
                    for residue in range(modulus)
                ]
                bad = [candidates[residue] * pulled[residue] for residue in range(modulus)]
                pulled_dft = normalized_dft(pulled)
                bad_dft = normalized_dft(bad)
                for frequency in range(modulus):
                    expected_pulled = pulled_interval_coefficient(
                        denominator, pivot, other, frequency
                    )
                    if abs(pulled_dft[frequency] - expected_pulled) >= tolerance:
                        raise AssertionError(
                            ("pullback", denominator, pivot, other, frequency)
                        )
                    expected_bad = pulled_dft[frequency] - sum(
                        pulled_dft[(frequency - q * pivot) % modulus]
                        for q in range(denominator)
                    ) / denominator
                    if abs(bad_dft[frequency] - expected_bad) >= tolerance:
                        raise AssertionError(
                            ("convolution", denominator, pivot, other, frequency)
                        )
                    checked += 1
    return checked


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--max-denominator", type=int, default=7)
    parser.add_argument("--max-pivot", type=int, default=9)
    parser.add_argument("--other-multiplier", type=int, default=3)
    args = parser.parse_args()
    checked = audit(args.max_denominator, args.max_pivot, args.other_multiplier)
    print(f"verified {checked} pullback and bad-indicator Fourier coefficients")


if __name__ == "__main__":
    main()
