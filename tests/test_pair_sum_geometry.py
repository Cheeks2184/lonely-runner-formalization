"""Regression tests for finite pair-sum geometry experiments."""

from __future__ import annotations

import importlib.util
import sys
import unittest
from fractions import Fraction
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]

CHECKER_SPEC = importlib.util.spec_from_file_location(
    "check_integer_tuple", ROOT / "scripts" / "check_integer_tuple.py"
)
assert CHECKER_SPEC and CHECKER_SPEC.loader
checker = importlib.util.module_from_spec(CHECKER_SPEC)
sys.modules["check_integer_tuple"] = checker
CHECKER_SPEC.loader.exec_module(checker)

GEOMETRY_SPEC = importlib.util.spec_from_file_location(
    "search_pair_sum_geometry", ROOT / "scripts" / "search_pair_sum_geometry.py"
)
assert GEOMETRY_SPEC and GEOMETRY_SPEC.loader
geometry = importlib.util.module_from_spec(GEOMETRY_SPEC)
GEOMETRY_SPEC.loader.exec_module(geometry)


class PairSumGeometryTests(unittest.TestCase):
    def test_unrestricted_pair_sum_finds_tight_consecutive_tuple(self) -> None:
        witness = geometry.pair_sum_witness((1, 2, 3), geometry._all_pairs(3))
        self.assertEqual(witness, (Fraction(1, 4), (0, 2)))

    def test_natural_certificate_matches_closed_circle_inequality(self) -> None:
        for speeds in ((1, 2, 3), (1, 3, 4), (2, 6, 8, 10, 11)):
            target = Fraction(1, len(speeds) + 1)
            for p, q in geometry._all_pairs(len(speeds)):
                denominator = speeds[p] + speeds[q]
                for numerator in range(denominator):
                    analytic = all(
                        checker.circle_distance(speed, Fraction(numerator, denominator))
                        >= target
                        for speed in speeds
                    )
                    self.assertEqual(
                        geometry.is_pair_sum_good(speeds, p, q, numerator),
                        analytic,
                    )

    def test_restricted_selector_counterexamples_are_exact(self) -> None:
        expected = {
            "adjacent": [1, 2, 3],
            "with-minimum": [1, 3, 4],
            "with-maximum": [2, 6, 8, 10, 11],
            "extremes": [1, 2, 4],
        }
        report = geometry.exhaustive_report(tuple(expected), 5, 11)
        self.assertEqual(
            {
                mode: result["speeds"]
                for mode, result in report["results"].items()
            },
            expected,
        )
        self.assertTrue(
            all(
                result["unrestricted_witness"] is not None
                for result in report["results"].values()
            )
        )

    def test_invalid_bounds_are_rejected(self) -> None:
        with self.assertRaisesRegex(ValueError, "at least two"):
            geometry.exhaustive_report(("adjacent",), 1, 5)
        with self.assertRaisesRegex(ValueError, "cannot exceed"):
            geometry.exhaustive_report(("adjacent",), 6, 5)


if __name__ == "__main__":
    unittest.main()
