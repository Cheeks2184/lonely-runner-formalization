"""Tests for exact adaptive fiber-credit ordering heuristics."""

from __future__ import annotations

import itertools
import math
import sys
import unittest
from fractions import Fraction
from pathlib import Path


SCRIPTS = Path(__file__).resolve().parents[1] / "scripts"
sys.path.insert(0, str(SCRIPTS))

from search_adaptive_orders import (  # noqa: E402
    HEURISTICS,
    admissible_children,
    audit_cross_pivot_box,
    best_heuristic_attempt,
    gcd_clock_result,
)
from search_fiber_hall import (  # noqa: E402
    _pivot_tables,
    best_additive_pivot_attempt,
)


class AdaptiveOrderTests(unittest.TestCase):
    def assert_failure(
        self,
        heuristic: str,
        speeds: tuple[int, ...],
        pivot_speed: int,
        optimal_order: tuple[int, ...],
        optimal_costs: tuple[int, ...],
        heuristic_order: tuple[int, ...],
        heuristic_costs: tuple[int, ...],
    ) -> None:
        pivot = speeds.index(pivot_speed)
        optimal = best_additive_pivot_attempt(speeds, pivot)
        attempt = best_heuristic_attempt(speeds, pivot, heuristic)  # type: ignore[arg-type]
        self.assertEqual(tuple(speeds[i] for i in optimal.order), optimal_order)
        self.assertEqual(
            tuple(step.increment_bound for step in optimal.steps), optimal_costs
        )
        self.assertLess(optimal.final_upper_bound, optimal.universe_size)
        self.assertEqual(tuple(speeds[i] for i in attempt.order), heuristic_order)
        self.assertEqual(
            tuple(step.increment_bound for step in attempt.steps), heuristic_costs
        )
        self.assertGreaterEqual(attempt.final_upper_bound, attempt.universe_size)

    def test_four_exact_fixed_pivot_failures(self) -> None:
        self.assert_failure(
            "minimum-increment",
            (1, 5, 6, 7),
            6,
            (1, 5, 7),
            (8, 10, 4),
            (1, 7, 5),
            (8, 6, 10),
        )
        self.assert_failure(
            "lookahead",
            (1, 5, 6, 7, 8),
            7,
            (1, 6, 8, 5),
            (10, 13, 6, 4),
            (1, 8, 5, 6),
            (10, 9, 6, 10),
        )
        self.assert_failure(
            "normalized-credit",
            (4, 6, 7, 10, 17),
            10,
            (4, 6, 7, 17),
            (18, 12, 8, 6),
            (4, 7, 17, 6),
            (18, 10, 10, 12),
        )
        self.assert_failure(
            "maximum-credit",
            (6, 8, 11, 14, 17),
            14,
            (6, 8, 11, 17),
            (24, 18, 12, 10),
            (6, 11, 17, 8),
            (24, 16, 14, 16),
        )

    def test_tie_optimized_dp_matches_explicit_admissible_orders(self) -> None:
        # Explicit permutation enumeration independently verifies that the DP
        # finds the best total over every heuristic-permitted tie choice.
        for speeds in ((1, 2, 3, 5), (1, 5, 6, 7)):
            for pivot in range(len(speeds)):
                others, counts, _fibers, lower_bounds = _pivot_tables(speeds, pivot)
                positions = {child: index for index, child in enumerate(others)}
                for heuristic in HEURISTICS:
                    admissible_totals: list[int] = []
                    for order in itertools.permutations(others):
                        state = 0
                        total = 0
                        permitted = True
                        for child in order:
                            allowed = admissible_children(
                                heuristic,
                                others,
                                positions,
                                counts,
                                lower_bounds,
                                state,
                            )
                            if child not in allowed:
                                permitted = False
                                break
                            total += counts[child] - lower_bounds[(child, state)]
                            state |= 1 << positions[child]
                        if permitted:
                            admissible_totals.append(total)
                    self.assertTrue(admissible_totals)
                    self.assertEqual(
                        best_heuristic_attempt(
                            speeds, pivot, heuristic
                        ).final_upper_bound,
                        min(admissible_totals),
                    )

    def test_small_cross_pivot_box_has_no_failure(self) -> None:
        result = audit_cross_pivot_box(4, 8)
        expected_tuples = sum(
            math.gcd(*speeds) == 1
            for speeds in itertools.combinations(range(1, 9), 4)
        )
        self.assertEqual(result.tuples, expected_tuples)
        self.assertEqual(result.tuples, 69)
        self.assertTrue(all(value is None for value in result.first_failures.values()))

    def test_gcd_clock_reported_exact_values_and_orders(self) -> None:
        cases = (
            (
                (2, 3, 7, 9, 10, 12, 15, 16, 19),
                3,
                Fraction(17614883, 664020),
                (15, 10, 16, 2, 7, 9, 12, 19),
                (12, 5, 2, 2, 0, 0, 2, 2),
            ),
            (
                (1, 2, 5, 7, 9, 11, 12, 13),
                7,
                Fraction(254, 5),
                (12, 1, 2, 5, 9, 11, 13),
                (14, 10, 4, 8, 6, 4, 4),
            ),
            (
                (1, 5, 7, 8, 9, 11, 13, 15),
                8,
                Fraction(398, 7),
                (15, 1, 5, 7, 9, 11, 13),
                (14, 12, 8, 8, 6, 4, 4),
            ),
            (
                (1, 2, 3, 5),
                3,
                Fraction(10),
                (1, 2, 5),
                (4, 2, 4),
            ),
            (
                (1, 2, 5, 6, 8),
                5,
                Fraction(23),
                (1, 2, 6, 8),
                (8, 5, 4, 6),
            ),
        )
        for speeds, pivot_speed, expectation, order, costs in cases:
            result = gcd_clock_result(speeds, speeds.index(pivot_speed))
            self.assertEqual(result.expected_bound, expectation)
            self.assertEqual(tuple(speeds[i] for i in result.greedy_order), order)
            self.assertEqual(
                tuple(step.increment_bound for step in result.greedy_steps), costs
            )
            self.assertEqual(result.greedy_bound, sum(costs))
            self.assertLessEqual(Fraction(result.greedy_bound), expectation)


if __name__ == "__main__":
    unittest.main()
