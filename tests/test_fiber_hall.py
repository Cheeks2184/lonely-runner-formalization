"""Regression tests for the exact fiberwise Hall arithmetic audit."""

from __future__ import annotations

import itertools
import math
import sys
import unittest
from pathlib import Path


SCRIPTS = Path(__file__).resolve().parents[1] / "scripts"
sys.path.insert(0, str(SCRIPTS))

from search_fiber_hall import (  # noqa: E402
    audit_box,
    best_pivot_attempt,
    certificate_is_valid,
    child_fibers,
    evaluate_order,
    fiber_lower_bound_from_masks,
    find_certificate,
)
from search_residual import pivot_bad_mask  # noqa: E402


class FiberHallTests(unittest.TestCase):
    def test_lower_bound_uses_maximum_single_parent_per_fiber(self) -> None:
        # The union meets this fiber twice, but each individual parent only
        # meets it once.  The audited criterion must return one, not two.
        self.assertEqual(fiber_lower_bound_from_masks((0b11,), (0b01, 0b10)), 1)

    def test_fibers_partition_current_literal_bad_masks(self) -> None:
        speeds = (1, 2, 5, 7, 9, 11, 12, 13)
        pivot = speeds.index(9)
        for child in range(len(speeds)):
            if child == pivot:
                continue
            fiber_masks = [mask for _target, mask in child_fibers(speeds, pivot, child)]
            self.assertTrue(
                all(
                    first & second == 0
                    for first, second in itertools.combinations(fiber_masks, 2)
                )
            )
            self.assertEqual(
                sum(fiber_masks), pivot_bad_mask(speeds, pivot, child)
            )

    def test_sol_pro_first_hard_tuple_table(self) -> None:
        speeds = (1, 2, 5, 7, 9, 11, 12, 13)
        pivot = speeds.index(9)
        order = tuple(speeds.index(speed) for speed in (1, 2, 12, 11, 13, 5, 7))
        reported = evaluate_order(speeds, pivot, order, q=9)
        self.assertTrue(certificate_is_valid(reported))
        self.assertEqual(reported.universe_size, 72)
        self.assertEqual(reported.final_upper_bound, 70)
        self.assertEqual(
            tuple(
                (step.bad_size, step.bad_size - reported.q, step.fiber_lower_bound)
                for step in reported.steps[1:]
            ),
            ((16, 7, 8), (12, 3, 4), (16, 7, 8), (16, 7, 8),
             (16, 7, 8), (16, 7, 8)),
        )

        # Exhaustive subset DP finds that Sol Pro's q=9 was not optimal: the
        # identical order works at q=8.
        best = best_pivot_attempt(speeds, pivot)
        self.assertEqual(best.q, 8)
        self.assertEqual(best.final_upper_bound, 64)

    def test_sol_pro_second_hard_tuple_table(self) -> None:
        speeds = (1, 5, 7, 8, 9, 11, 13, 15)
        pivot = speeds.index(8)
        order = tuple(speeds.index(speed) for speed in (5, 9, 15, 7, 11, 1, 13))
        reported = evaluate_order(speeds, pivot, order, q=8)
        self.assertTrue(certificate_is_valid(reported))
        self.assertEqual(reported.universe_size, 64)
        self.assertEqual(reported.final_upper_bound, 62)
        self.assertEqual(
            tuple(
                (step.bad_size, step.bad_size - reported.q, step.fiber_lower_bound)
                for step in reported.steps[1:]
            ),
            ((8, 0, 0), (14, 6, 6), (14, 6, 6), (14, 6, 6),
             (14, 6, 8), (14, 6, 10)),
        )

    def test_subset_dp_matches_explicit_permutation_search(self) -> None:
        # This independently checks the DP claim on every pivot of every
        # primitive four-speed tuple in a small complete box.
        for speeds in itertools.combinations(range(1, 8), 4):
            if math.gcd(*speeds) != 1:
                continue
            for pivot in range(len(speeds)):
                others = tuple(index for index in range(len(speeds)) if index != pivot)
                brute = min(
                    evaluate_order(speeds, pivot, order).final_upper_bound
                    for order in itertools.permutations(others)
                )
                self.assertEqual(best_pivot_attempt(speeds, pivot).final_upper_bound, brute)

    def test_smallest_bounded_counterexample(self) -> None:
        speeds = (1, 2, 3, 5)
        self.assertIsNone(find_certificate(speeds))
        self.assertEqual(
            tuple(
                best_pivot_attempt(speeds, pivot).final_upper_bound
                for pivot in range(len(speeds))
            ),
            (4, 8, 12, 20),
        )

        # No smaller primitive tuple in these complete boxes fails.  At four
        # runners and maximum speed five, the displayed tuple is the sole
        # failure and is the first in lexicographic enumeration.
        self.assertEqual(audit_box(2, 10, residual_only=False)[2], None)
        self.assertEqual(audit_box(3, 10, residual_only=False)[2], None)
        self.assertEqual(
            audit_box(4, 5, residual_only=False),
            (5, 4, speeds),
        )


if __name__ == "__main__":
    unittest.main()
