"""Regression tests for the exact all-pivot TOP-CYCLE failure audit."""

from fractions import Fraction
import unittest

from audit_top_cycle_failure import (
    EXPECTED_PIVOT_28_COSTS,
    EXPECTED_PIVOT_28_ORDER,
    EXPECTED_ROWS,
    EXPECTED_WITNESS_DISTANCES,
    TOP_CYCLE_FAILURE,
    _insertion_costs,
    accept_all_rows,
    exhaustive_key_rows,
    literal_pivot,
    strict_endpoint_audit,
    witness_audit,
)
from search_top_cycle_failures import score_tuple


class TopCycleFailureTests(unittest.TestCase):
    def test_every_pivot_fails_top_but_unrestricted_separates(self) -> None:
        rows = accept_all_rows()
        self.assertEqual(tuple(row.pivot for row in rows), TOP_CYCLE_FAILURE)
        self.assertTrue(all(row.top_bound >= row.threshold for row in rows))
        self.assertEqual(
            tuple(row.pivot for row in rows if row.top_bound == row.threshold),
            (5, 35),
        )
        self.assertEqual(
            tuple(
                row.pivot
                for row in rows
                if row.optimized_bound < row.threshold
            ),
            (28, 35, 40, 68, 88, 108, 165),
        )
        self.assertEqual(
            tuple(
                (
                    row.bad_sum,
                    row.top_credit,
                    row.feedback_loss,
                    row.top_bound,
                    row.optimized_bound,
                    row.threshold,
                )
                for row in rows
            ),
            tuple(EXPECTED_ROWS[pivot] for pivot in TOP_CYCLE_FAILURE),
        )
        self.assertTrue(
            all(row.selected_backward_weight == row.feedback_loss for row in rows)
        )
        self.assertTrue(
            all(
                row.top_order_full_bound
                == row.top_bound - row.top_order_rescue
                for row in rows
            )
        )

    def test_pivot_28_proposed_order_and_exhaustive_key_rows(self) -> None:
        data = literal_pivot(TOP_CYCLE_FAILURE, 28)
        self.assertEqual(
            _insertion_costs(data, EXPECTED_PIVOT_28_ORDER),
            EXPECTED_PIVOT_28_COSTS,
        )
        self.assertEqual(sum(EXPECTED_PIVOT_28_COSTS), 250)
        self.assertLess(250, 252)
        key_rows = exhaustive_key_rows()
        self.assertEqual(key_rows[5][:2], (45, 45))
        self.assertEqual(key_rows[28][:2], (258, 250))

    def test_strict_endpoints_and_explicit_lonely_time(self) -> None:
        endpoint_rows = strict_endpoint_audit()
        self.assertEqual(tuple(row[0] for row in endpoint_rows), TOP_CYCLE_FAILURE)
        self.assertTrue(
            all(low == high and low > 0 for _pivot, low, high in endpoint_rows)
        )
        time, distances = witness_audit()
        self.assertEqual(time, Fraction(3, 140))
        self.assertEqual(distances, EXPECTED_WITNESS_DISTANCES)
        self.assertGreaterEqual(min(distances), Fraction(1, 10))

    def test_search_engine_reproduces_the_accepted_failure(self) -> None:
        objective, search_rows = score_tuple(TOP_CYCLE_FAILURE)
        self.assertEqual(objective, 0)
        self.assertEqual(
            tuple(
                (
                    row.bad_sum,
                    row.top_credit,
                    row.top_bound,
                    row.threshold,
                )
                for row in search_rows
            ),
            tuple(
                (expected[0], expected[1], expected[3], expected[5])
                for expected in EXPECTED_ROWS.values()
            ),
        )


if __name__ == "__main__":
    unittest.main()
