"""Regression tests for independently reconstructed Responses 26 and 27."""

from __future__ import annotations

import sys
import unittest
from pathlib import Path

SCRIPTS = Path(__file__).resolve().parents[1] / "scripts"
sys.path.insert(0, str(SCRIPTS))

from audit_relocation_descent import CLAIMS, audit_local_minima  # noqa: E402
from audit_three_anchor import (  # noqa: E402
    CLAIMS as ANCHOR_CLAIMS,
    REPAIRED_CLAIMS,
    all_target_front_cost,
    exact_anchor_union_cost,
    repaired_order_costs,
)
from audit_triangle_lp import integral_costs, verify_fractional_zero_cost  # noqa: E402


class Response26RelocationTests(unittest.TestCase):
    def test_reported_counts_use_two_sided_relocations(self) -> None:
        expected = (
            (3144, (25, 26)),
            (48, (358,)),
            (2100, (50,)),
            (2100, (56,)),
            (6, (10,)),
        )
        for (speeds, pivot), (count, costs) in zip(CLAIMS, expected, strict=True):
            with self.subTest(speeds=speeds, pivot=pivot):
                report = audit_local_minima(speeds, pivot)
                self.assertEqual(report.two_sided_minimum_count, count)
                self.assertEqual(report.two_sided_costs, costs)

    def test_left_only_neighborhood_has_bad_local_minima(self) -> None:
        for claim_index in (0, 1):
            speeds, pivot = CLAIMS[claim_index]
            with self.subTest(speeds=speeds, pivot=pivot):
                report = audit_local_minima(speeds, pivot)
                self.assertIsNotNone(report.first_nonstrict_left_example)
                _order, cost = report.first_nonstrict_left_example or ((), -1)
                self.assertGreaterEqual(cost, report.universe_size)


class Response26AnchorTests(unittest.TestCase):
    def test_maximal_all_target_reading_rejects_two_claimed_costs(self) -> None:
        expected_exact_anchor_costs = (26, 82, 52, 58, 10)
        for claim, expected in zip(
            ANCHOR_CLAIMS, expected_exact_anchor_costs, strict=True
        ):
            speeds, pivot, anchors, _claimed = claim
            with self.subTest(speeds=speeds, pivot=pivot, anchors=anchors):
                self.assertEqual(
                    exact_anchor_union_cost(speeds, pivot, anchors), expected
                )

        rf = ANCHOR_CLAIMS[0]
        gcd_clock = ANCHOR_CLAIMS[1]
        self.assertEqual(all_target_front_cost(rf[0], rf[1], rf[2]), (26,))
        self.assertEqual(
            all_target_front_cost(gcd_clock[0], gcd_clock[1], gcd_clock[2]),
            (82, 84),
        )
        self.assertLess(rf[3], 26)
        self.assertLess(gcd_clock[3], 82)


class Response27AnchorTests(unittest.TestCase):
    def test_every_repaired_step_cost_matches(self) -> None:
        for speeds, pivot, anchors, order, expected_costs in REPAIRED_CLAIMS:
            with self.subTest(speeds=speeds, pivot=pivot, anchors=anchors):
                actual_costs, _chosen_anchors = repaired_order_costs(
                    speeds, pivot, anchors, order
                )
                self.assertEqual(actual_costs, expected_costs)
                self.assertLess(sum(actual_costs), len(speeds) * pivot)


class TriangleLPTests(unittest.TestCase):
    def test_three_item_clause_integrality_gap(self) -> None:
        self.assertEqual(integral_costs(), (1, 1, 1, 1, 1, 1))
        self.assertEqual(verify_fractional_zero_cost(), 0)


if __name__ == "__main__":
    unittest.main()
