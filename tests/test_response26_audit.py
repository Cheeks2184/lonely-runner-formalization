"""Regression tests for the independently reconstructed Response 26 claims."""

from __future__ import annotations

import sys
import unittest
from pathlib import Path

SCRIPTS = Path(__file__).resolve().parents[1] / "scripts"
sys.path.insert(0, str(SCRIPTS))

from audit_relocation_descent import CLAIMS, audit_local_minima  # noqa: E402
from audit_three_anchor import (  # noqa: E402
    CLAIMS as ANCHOR_CLAIMS,
    all_target_front_cost,
    exact_anchor_union_cost,
)


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


if __name__ == "__main__":
    unittest.main()
