"""Regression tests for the anchor-star Gamma dispersion audit."""

from __future__ import annotations

import sys
import unittest
from fractions import Fraction
from pathlib import Path


SCRIPTS = Path(__file__).resolve().parents[1] / "scripts"
if str(SCRIPTS) not in sys.path:
    sys.path.insert(0, str(SCRIPTS))

from audit_anchor_star import STRESS_CASES  # noqa: E402
from audit_gamma_dispersion import (  # noqa: E402
    audit_instance,
    gamma_dispersion_bound,
    gamma_from_xi,
    gamma_term,
    has_dispersion_star_certificate,
)


class GammaDispersionTests(unittest.TestCase):
    def test_stress_cases_obey_nested_bounds_and_strict_certificate(self) -> None:
        expected_surpluses = (
            Fraction(13, 21),
            Fraction(4, 21),
            Fraction(22, 21),
            Fraction(2),
            Fraction(2, 5),
            Fraction(4, 5),
        )
        for case, expected in zip(STRESS_CASES, expected_surpluses, strict=True):
            name, speeds, pivot_speed, h_speed, *_rest = case
            row = audit_instance(
                speeds, speeds.index(pivot_speed), speeds.index(h_speed)
            )
            self.assertEqual(row["certified_surplus"], expected, name)
            self.assertGreater(row["certified_surplus"], 0, name)

    def test_exact_gamma_decomposition(self) -> None:
        speeds = (8, 15, 35, 40, 48, 56, 63, 75, 78)
        pivot, h = speeds.index(15), speeds.index(75)
        self.assertEqual(gamma_term(speeds, pivot, h), Fraction(58, 7))
        self.assertEqual(gamma_from_xi(speeds, pivot, h), Fraction(58, 7))
        self.assertEqual(
            gamma_dispersion_bound(speeds, pivot, h), Fraction(142, 21)
        )

    def test_collapsing_nonzero_target_cells_is_too_weak(self) -> None:
        speeds = (8, 15, 35, 40, 48, 56, 63, 75, 78)
        row = audit_instance(speeds, speeds.index(15), speeds.index(75))
        self.assertEqual(row["aggregate_surplus"], Fraction(-10, 3))
        self.assertEqual(row["certified_surplus"], Fraction(4, 21))

    def test_small_complete_box_has_dispersion_certificates(self) -> None:
        # This is a compact deterministic smoke box; larger complete boxes are
        # recorded as reproducible command-line audits in the accompanying note.
        from itertools import combinations
        from math import gcd

        for speeds in combinations(range(1, 9), 5):
            if gcd(*speeds) == 1:
                self.assertTrue(has_dispersion_star_certificate(speeds), speeds)


if __name__ == "__main__":
    unittest.main()
