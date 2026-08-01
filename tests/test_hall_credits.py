"""Regression tests for exact capacitated Hall overlap accounting."""

from __future__ import annotations

import itertools
import sys
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

import search_hall_credits as hall  # noqa: E402


class HallCreditTests(unittest.TestCase):
    def test_matching_equals_full_hall_condition_exhaustively(self) -> None:
        # Every family of at most three subsets of a three-point universe,
        # with every quota in {0,1,2}, is small enough to exhaust literally.
        for parent_count in range(1, 4):
            for masks in itertools.product(range(1 << 3), repeat=parent_count):
                for weights in itertools.product(range(3), repeat=parent_count):
                    hall_holds = hall.first_failed_hall_cut(list(masks), weights) is None
                    flow_saturates = (
                        hall.maximum_assigned_units(list(masks), weights)
                        == sum(weights)
                    )
                    self.assertEqual(hall_holds, flow_saturates, (masks, weights))

    def test_pairwise_singleton_checks_fail_on_arithmetic_bad_sets(self) -> None:
        result = hall.search_truncated_cut_counterexample(1, 5, 8, 3)
        self.assertIsNotNone(result)
        assert result is not None
        self.assertEqual(result["speeds"], (1, 2, 3, 4))
        self.assertEqual(result["pivot_speed"], 4)
        self.assertEqual(result["child_speed"], 1)
        self.assertEqual(result["parent_speeds"], (2, 3))
        self.assertEqual(result["weights"], (1, 2))
        self.assertEqual(result["maximum_flow"], 2)
        self.assertEqual(result["total_demand"], 3)

    def test_pair_cuts_do_not_imply_triple_cut_for_pivot_bad_sets(self) -> None:
        result = hall.search_truncated_cut_counterexample(2, 6, 12, 3)
        self.assertIsNotNone(result)
        assert result is not None
        self.assertEqual(result["speeds"], (1, 2, 3, 4, 5))
        self.assertEqual(result["pivot_speed"], 5)
        self.assertEqual(result["child_speed"], 1)
        self.assertEqual(result["parent_speeds"], (2, 3, 4))
        self.assertEqual(result["weights"], (3, 1, 1))
        self.assertEqual(result["eligible_sizes"], (4, 2, 2))
        self.assertEqual(result["failed_demand"], 5)
        self.assertEqual(result["failed_capacity"], 4)
        self.assertEqual(result["maximum_flow"], 4)


if __name__ == "__main__":
    unittest.main()
