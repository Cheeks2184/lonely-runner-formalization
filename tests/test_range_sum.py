"""Regression tests for the exact range--sum majorization audit."""

from __future__ import annotations

import itertools
import sys
import unittest
from fractions import Fraction
from pathlib import Path

SCRIPTS = Path(__file__).resolve().parents[1] / "scripts"
if str(SCRIPTS) not in sys.path:
    sys.path.insert(0, str(SCRIPTS))

from audit_anchor_star import STRESS_CASES  # noqa: E402
from audit_range_sum import (  # noqa: E402
    LOSSY_TUPLE,
    deep_audit_tuple,
    profile_dispersion,
    range_equality_characterization,
    range_profile_lower,
    retained_profiles,
    row_data,
    verify_coprime_fixed_pivot_descent,
)


class RangeSumTests(unittest.TestCase):
    def test_profile_bound_and_equality_exhaustively(self) -> None:
        for length in range(0, 8):
            for counts in itertools.product(range(6), repeat=length):
                exact = profile_dispersion(counts)
                lower = range_profile_lower(counts)
                self.assertLessEqual(lower, exact, counts)
                self.assertEqual(exact == lower, range_equality_characterization(counts), counts)

    def test_six_stress_rows(self) -> None:
        expected = (
            (Fraction(4, 3), Fraction(13, 21)),
            (Fraction(142, 21), Fraction(4, 21)),
            (Fraction(394, 21), Fraction(10, 21)),
            (Fraction(0), Fraction(2)),
            (Fraction(76, 15), Fraction(2, 5)),
            (Fraction(92, 15), Fraction(4, 5)),
        )
        for case, (bound, surplus) in zip(STRESS_CASES, expected, strict=True):
            name, speeds, pivot_speed, h_speed, *_ = case
            row = row_data(speeds, speeds.index(pivot_speed), speeds.index(h_speed))
            self.assertEqual(row["W"], bound, name)
            self.assertEqual(row["range_surplus"], surplus, name)
            self.assertLessEqual(row["W"], row["V"], name)

    def test_lossy_profiles_and_fraction(self) -> None:
        pivot, h = LOSSY_TUPLE.index(18), LOSSY_TUPLE.index(4)
        row = row_data(LOSSY_TUPLE, pivot, h)
        self.assertEqual(row["V"], Fraction(52, 5))
        self.assertEqual(row["W"], Fraction(51, 5))
        lossy = [x for x in retained_profiles(LOSSY_TUPLE, pivot, h) if profile_dispersion(x[3]) != range_profile_lower(x[3])]
        self.assertEqual(
            sorted(lossy),
            [(26, 10, 68, (0, 2, 2, 0)), (26, 134, 76, (0, 2, 2, 0))],
        )

    def test_fixed_pivot_coprime_descent(self) -> None:
        # M=5*5=25 and D=2.  Division creates a pivot collision (10/2=5),
        # documenting that the result is a fixed-pivot set-system isomorphism,
        # not automatically a valid global LRC descent.
        self.assertTrue(verify_coprime_fixed_pivot_descent((5, 2, 6, 10), 0, 2))
        self.assertTrue(verify_coprime_fixed_pivot_descent((5, 2, 6, 14), 0, 2))
        with self.assertRaises(ValueError):
            verify_coprime_fixed_pivot_descent((5, 2, 6, 10), 0, 5)

    def test_two_all_pivot_failures_with_literal_oracle_and_live_routes(self) -> None:
        cases = (
            (
                (1, 14, 27, 40, 53, 66, 79, 92, 105),
                (
                    Fraction(0), Fraction(-2, 3), Fraction(-52, 7),
                    Fraction(-122, 7), Fraction(-98, 3), Fraction(-604, 21),
                    Fraction(-71, 3), Fraction(-86, 3), Fraction(-160, 7),
                ),
                True,
            ),
            (
                (1, 4, 5, 7, 8, 9, 10, 11, 17),
                (
                    Fraction(0), Fraction(-40, 21), Fraction(-8, 21),
                    Fraction(-16, 3), Fraction(-76, 21), Fraction(-92, 21),
                    Fraction(-24, 7), Fraction(-16, 3), Fraction(-202, 21),
                ),
                False,
            ),
        )
        for speeds, margins, anchor_star in cases:
            report = deep_audit_tuple(speeds)
            self.assertFalse(report["range_sum_star"])
            self.assertFalse(report["dispersion_star"])
            self.assertEqual(
                tuple(row["best_range"][0] for row in report["rows"]["by_pivot"]),
                margins,
            )
            self.assertEqual(
                tuple(row["best_dispersion"][0] for row in report["rows"]["by_pivot"]),
                margins,
            )
            self.assertEqual(report["anchor_star"], anchor_star)
            self.assertTrue(report["three_anchor"])
            self.assertTrue(report["optimized_additive"])


if __name__ == "__main__":
    unittest.main()
