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
from dataclasses import dataclass


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


@dataclass(frozen=True)
class MainTermAudit:
    """Absolute zero-sum convolution data for one pivot factorization."""

    main_term: float
    total_absolute: float
    good_residues: tuple[int, ...]

    @property
    def dominates(self) -> bool:
        """Whether the all-zero term strictly exceeds the remaining terms."""
        return 2 * self.main_term > self.total_absolute + 1e-12


def absolute_zero_sum_convolution(spectra: Sequence[Sequence[float]]) -> float:
    """Sum products of magnitudes over frequency tuples summing to zero."""
    modulus = len(spectra[0])
    totals = [0.0] * modulus
    totals[0] = 1.0
    for spectrum in spectra:
        updated = [0.0] * modulus
        for left, subtotal in enumerate(totals):
            for right, coefficient in enumerate(spectrum):
                updated[(left + right) % modulus] += subtotal * coefficient
        totals = updated
    return totals[0]


def main_term_audit(
    speeds: Sequence[int], pivot_index: int, *, candidate_filtered_bad: bool
) -> MainTermAudit:
    """Evaluate one factorization-dependent absolute Fourier criterion."""
    denominator = len(speeds) + 1
    pivot = speeds[pivot_index]
    modulus = denominator * pivot
    candidate = [int(residue % denominator != 0) for residue in range(modulus)]
    spectra = [[abs(value) for value in normalized_dft(candidate)]]
    good = [residue for residue in range(modulus) if candidate[residue]]

    for index, other in enumerate(speeds):
        if index == pivot_index:
            continue
        pulled = [
            int(
                min((other * residue) % modulus,
                    modulus - (other * residue) % modulus) < pivot
            )
            for residue in range(modulus)
        ]
        bad = [candidate[residue] * pulled[residue] for residue in range(modulus)]
        factor_bad = bad if candidate_filtered_bad else pulled
        good_factor = [1 - value for value in factor_bad]
        spectra.append([abs(value) for value in normalized_dft(good_factor)])
        good = [residue for residue in good if not bad[residue]]

    main_term = math.prod(spectrum[0] for spectrum in spectra)
    total = absolute_zero_sum_convolution(spectra)
    return MainTermAudit(main_term, total, tuple(good))


def audit_main_term_counterexamples() -> None:
    """Reproduce the smallest factorization failures recorded in the note."""
    beta_pivot_three = main_term_audit(
        (1, 2, 3), 2, candidate_filtered_bad=True
    )
    expected_beta_total = 37 / 72 + math.sqrt(3) / 18
    assert math.isclose(beta_pivot_three.main_term, 7 / 24, abs_tol=1e-12)
    assert math.isclose(
        beta_pivot_three.total_absolute, expected_beta_total, abs_tol=1e-12
    )
    assert beta_pivot_three.good_residues == (3, 9)
    assert not beta_pivot_three.dominates

    raw_pivot_three = main_term_audit(
        (1, 2, 3), 2, candidate_filtered_bad=False
    )
    assert math.isclose(raw_pivot_three.main_term, 7 / 32, abs_tol=1e-12)
    assert math.isclose(raw_pivot_three.total_absolute, 29 / 72, abs_tol=1e-12)
    assert raw_pivot_three.dominates

    beta_pivot_one = main_term_audit((1, 2, 3), 0, candidate_filtered_bad=True)
    raw_pivot_one = main_term_audit((1, 2, 3), 0, candidate_filtered_bad=False)
    assert beta_pivot_one.dominates
    assert not raw_pivot_one.dominates

    every_pivot = [
        main_term_audit((4, 5, 9), pivot_index, candidate_filtered_bad=True)
        for pivot_index in range(3)
    ]
    assert all(audit.good_residues for audit in every_pivot)
    assert all(not audit.dominates for audit in every_pivot)


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
    audit_main_term_counterexamples()
    print(f"verified {checked} pullback and bad-indicator Fourier coefficients")
    print("verified factorization-dependent main-term counterexamples")


if __name__ == "__main__":
    main()
