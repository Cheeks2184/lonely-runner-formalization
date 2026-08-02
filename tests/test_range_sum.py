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
    THREE_ANCHOR_FAILURE,
    audit_three_anchor_failure,
    deep_audit_tuple,
    profile_dispersion,
    incidence_theta_and_profile,
    range_equality_characterization,
    range_profile_lower,
    range_sum_identity_terms,
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

    def test_pointwise_theta_dominates_profile_dispersion(self) -> None:
        universe = range(3)
        subsets = tuple(
            {point for point in universe if mask >> point & 1} for mask in range(8)
        )
        for length in range(5):
            for parents in itertools.product(subsets, repeat=length):
                theta, profile = incidence_theta_and_profile(parents)
                self.assertGreaterEqual(theta, profile_dispersion(profile))
                self.assertGreaterEqual(profile_dispersion(profile), range_profile_lower(profile))

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

    def test_all_pivot_failures_with_literal_oracle_and_live_routes(self) -> None:
        cases = (
            (
                (1, 14, 27, 40, 53, 66, 79, 92, 105),
                (
                    Fraction(0), Fraction(-2, 3), Fraction(-52, 7),
                    Fraction(-122, 7), Fraction(-98, 3), Fraction(-604, 21),
                    Fraction(-71, 3), Fraction(-86, 3), Fraction(-160, 7),
                ),
                (
                    Fraction(0), Fraction(-2, 3), Fraction(-52, 7),
                    Fraction(-122, 7), Fraction(-98, 3), Fraction(-604, 21),
                    Fraction(-71, 3), Fraction(-86, 3), Fraction(-160, 7),
                ),
                True,
                None,
            ),
            (
                (1, 4, 5, 7, 8, 9, 10, 11, 17),
                (
                    Fraction(0), Fraction(-40, 21), Fraction(-8, 21),
                    Fraction(-16, 3), Fraction(-76, 21), Fraction(-92, 21),
                    Fraction(-24, 7), Fraction(-16, 3), Fraction(-202, 21),
                ),
                (
                    Fraction(0), Fraction(-40, 21), Fraction(-8, 21),
                    Fraction(-16, 3), Fraction(-76, 21), Fraction(-92, 21),
                    Fraction(-24, 7), Fraction(-16, 3), Fraction(-202, 21),
                ),
                False,
                None,
            ),
            (
                (8, 15, 35, 40, 48, 56, 68, 75, 78),
                (
                    Fraction(-76, 21), Fraction(-76, 21), Fraction(-284, 21),
                    Fraction(-464, 21), Fraction(-668, 21), Fraction(-74, 3),
                    Fraction(-64, 3), Fraction(-718, 21), Fraction(-928, 21),
                ),
                (
                    Fraction(-76, 21), Fraction(-76, 21), Fraction(-12),
                    Fraction(-464, 21), Fraction(-662, 21), Fraction(-488, 21),
                    Fraction(-352, 21), Fraction(-212, 7), Fraction(-878, 21),
                ),
                False,
                (
                    Fraction(-24, 7), Fraction(-32, 21), Fraction(-200, 21),
                    Fraction(-418, 21), Fraction(-494, 21), Fraction(-430, 21),
                    Fraction(-104, 7), Fraction(-500, 21), Fraction(-192, 7),
                ),
            ),
        )
        for speeds, range_margins, dispersion_margins, anchor_star, anchor_margins in cases:
            report = deep_audit_tuple(speeds)
            self.assertFalse(report["range_sum_star"])
            self.assertFalse(report["dispersion_star"])
            self.assertEqual(
                tuple(row["best_range"][0] for row in report["rows"]["by_pivot"]),
                range_margins,
            )
            self.assertEqual(
                tuple(row["best_dispersion"][0] for row in report["rows"]["by_pivot"]),
                dispersion_margins,
            )
            self.assertEqual(report["anchor_star"], anchor_star)
            if anchor_margins is not None:
                self.assertEqual(
                    tuple(
                        row["threshold"] - row["anchor_average"]
                        for row in report["pivots"]
                    ),
                    anchor_margins,
                )
            self.assertTrue(report["three_anchor"])
            self.assertTrue(report["optimized_additive"])

    def test_range_sum_identity_on_every_stress_and_strict_failure_row(self) -> None:
        tuples = [case[1] for case in STRESS_CASES]
        tuples.append((8, 15, 35, 40, 48, 56, 68, 75, 78))
        for speeds in tuples:
            for pivot in range(len(speeds)):
                for h in range(len(speeds)):
                    if h != pivot:
                        terms = range_sum_identity_terms(speeds, pivot, h)
                        self.assertGreaterEqual(terms["loss"], 0)
                        self.assertGreaterEqual(terms["debt"], 0)

    def test_three_anchor_uniformity_failure_and_live_witnesses(self) -> None:
        report = audit_three_anchor_failure(THREE_ANCHOR_FAILURE)
        self.assertTrue(report["primitive"])
        self.assertTrue(report["positive_distinct"])
        self.assertFalse(report["three_anchor_succeeds"])
        expected_minimums = (
            (116, 102, 92), (431, 367, 333), (531, 443, 407),
            (603, 513, 461), (626, 540, 492), (652, 552, 504),
            (723, 615, 553), (847, 721, 645), (1083, 923, 827),
        )
        self.assertEqual(
            tuple(
                tuple(row["minimum_by_size"][size] for size in (1, 2, 3))
                for row in report["pivots"]
            ),
            expected_minimums,
        )
        self.assertEqual(
            tuple(row["tied_best_triples"] for row in report["pivots"]),
            (
                ((37, 56, 71), (37, 61, 71), (54, 56, 71)),
                ((45, 54, 61),),
                ((54, 56, 91),),
                ((37, 45, 56),),
                ((45, 51, 56),),
                ((37, 45, 51), (45, 51, 54), (45, 54, 91)),
                ((45, 56, 91),),
                ((37, 45, 56),),
                ((45, 54, 56),),
            ),
        )
        self.assertEqual(report["proposed_additive_bound"], 84)
        self.assertEqual(report["proposed_additive_costs"], (18, 8, 14, 12, 10, 8, 8, 6))
        self.assertTrue(report["proposed_additive_valid"])
        self.assertEqual(
            report["distance_numerators_at_3_over_100"],
            (30, 11, 35, 47, 38, 32, 17, 13, 27),
        )
        self.assertTrue(report["lonely_time_valid"])


if __name__ == "__main__":
    unittest.main()
