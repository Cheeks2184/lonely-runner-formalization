"""Regression tests for the RV profile-energy audit."""

from __future__ import annotations

import itertools
import sys
import unittest
from fractions import Fraction
from pathlib import Path


SCRIPTS = Path(__file__).resolve().parents[1] / "scripts"
if str(SCRIPTS) not in sys.path:
    sys.path.insert(0, str(SCRIPTS))

from audit_gamma_dispersion import gamma_dispersion_bound  # noqa: E402
from audit_rv_energy import (  # noqa: E402
    ENERGY_COUNTEREXAMPLE,
    best_margin,
    direct_modular_pair_average_margin,
    direct_pair_average_margin,
    direct_profile_dispersion,
    modular_pair_identity_margin,
    pair_average_multiplicity_margin,
    profile_energy_lower_bound,
    rv_energy_bound,
)


class RVEnergyTests(unittest.TestCase):
    def test_pair_average_identity_on_all_small_set_systems(self) -> None:
        universe = (1 << 3) - 1
        for m in (3, 4):
            for masks in itertools.product(range(1 << 3), repeat=m):
                self.assertEqual(
                    direct_pair_average_margin(masks, universe),
                    pair_average_multiplicity_margin(masks, universe),
                )

    def test_energy_bound_on_all_small_integer_profiles(self) -> None:
        for k in range(1, 7):
            for cell_size in range(5):
                for counts in itertools.product(range(cell_size + 1), repeat=k):
                    self.assertLessEqual(
                        profile_energy_lower_bound(counts, cell_size),
                        direct_profile_dispersion(counts),
                        (counts, cell_size),
                    )

    def test_constant_and_balanced_equality_profiles(self) -> None:
        for value in range(6):
            counts = (value,) * 5
            self.assertEqual(profile_energy_lower_bound(counts, value), 0)
            self.assertEqual(direct_profile_dispersion(counts), 0)
        # Integer balancing is exact when the entries differ by at most one.
        counts = (2, 2, 2, 3, 3)
        self.assertEqual(profile_energy_lower_bound(counts, 3), 6)
        self.assertEqual(direct_profile_dispersion(counts), 6)

    def test_first_two_moments_do_not_determine_l1(self) -> None:
        left = (0, 1, 3, 3)
        right = (1, 1, 1, 4)
        self.assertEqual(sum(left), sum(right))
        self.assertEqual(sum(c * c for c in left), sum(c * c for c in right))
        self.assertEqual(profile_energy_lower_bound(left, 4), 7)
        self.assertEqual(profile_energy_lower_bound(right, 4), 7)
        self.assertEqual(direct_profile_dispersion(left), 11)
        self.assertEqual(direct_profile_dispersion(right), 9)

    def test_modular_pair_identity_on_counterexample(self) -> None:
        for pivot in range(len(ENERGY_COUNTEREXAMPLE)):
            self.assertEqual(
                modular_pair_identity_margin(ENERGY_COUNTEREXAMPLE, pivot),
                direct_modular_pair_average_margin(ENERGY_COUNTEREXAMPLE, pivot),
            )

    def test_profile_free_energy_bound_is_strictly_weaker(self) -> None:
        speeds = ENERGY_COUNTEREXAMPLE
        pivot = speeds.index(15)
        h = speeds.index(75)
        self.assertEqual(rv_energy_bound(speeds, pivot, h), Fraction(124, 21))
        self.assertEqual(gamma_dispersion_bound(speeds, pivot, h), Fraction(142, 21))

    def test_energy_simplification_has_exact_all_pivot_failure(self) -> None:
        self.assertEqual(
            best_margin(ENERGY_COUNTEREXAMPLE, exact_dispersion=False),
            (Fraction(-2, 3), 15, 75, Fraction(124, 21)),
        )
        self.assertEqual(
            best_margin(ENERGY_COUNTEREXAMPLE, exact_dispersion=True),
            (Fraction(4, 21), 15, 75, Fraction(142, 21)),
        )


if __name__ == "__main__":
    unittest.main()
