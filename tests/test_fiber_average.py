"""Regression tests for random-order fiber-credit inequalities."""

from __future__ import annotations

import itertools
import sys
import unittest
from fractions import Fraction
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

import search_fiber_average as average  # noqa: E402
import search_fiber_hall as fiber_hall  # noqa: E402
import search_residual as residual  # noqa: E402


class FiberAverageTests(unittest.TestCase):
    def test_ranked_formula_equals_literal_permutation_average(self) -> None:
        speeds = (1, 2, 5, 6, 8)
        pivot = 2  # speed 5
        children = tuple(i for i in range(len(speeds)) if i != pivot)
        masks = {
            child: residual.pivot_bad_mask(speeds, pivot, child)
            for child in children
        }
        literal_total = Fraction(0)
        orders = tuple(itertools.permutations(children))
        for order in orders:
            certificate = fiber_hall.evaluate_additive_order(speeds, pivot, order)
            literal_total += certificate.final_upper_bound
        literal_average = literal_total / len(orders)
        ranked = average.pivot_ranked_fiber_expectation(speeds, pivot)
        self.assertEqual(literal_average, Fraction(ranked["expected_upper"]))
        self.assertEqual(literal_average, Fraction(23))

    def test_pairwise_average_fails_before_ranked_fiber_average(self) -> None:
        report = average.tuple_report((1, 2, 5, 6, 8))
        self.assertFalse(report["average_certified"])
        self.assertTrue(report["ranked_fiber_certified"])
        self.assertTrue(report["additive_certified"])

    def test_ranked_fiber_average_small_box(self) -> None:
        self.assertIsNone(
            average.first_failure(5, 9, "ranked_fiber_certified")
        )


if __name__ == "__main__":
    unittest.main()
