"""Regression tests for the independent top-parent cycle audit."""

import unittest

from audit_top_parent_cycles import (
    EXPECTED_OPTIMIZED_BOUNDS,
    STRESS_ROWS,
    audit_top_parent,
)


class TopParentCycleTests(unittest.TestCase):
    def test_sol_response_33_table(self) -> None:
        for name, speeds, pivot, expected in STRESS_ROWS:
            with self.subTest(name=name):
                audit = audit_top_parent(speeds, pivot)
                self.assertEqual(
                    (
                        audit.bad_sum,
                        audit.top_credit,
                        audit.feedback_loss,
                        audit.top_bound,
                        audit.universe_size,
                    ),
                    expected,
                )

    def test_feedback_selector_and_optimized_relation(self) -> None:
        for name, speeds, pivot, _expected in STRESS_ROWS:
            with self.subTest(name=name):
                audit = audit_top_parent(speeds, pivot)
                self.assertEqual(
                    audit.top_bound,
                    audit.bad_sum - audit.top_credit + audit.feedback_loss,
                )
                self.assertEqual(
                    audit.selected_backward_weight, audit.feedback_loss
                )
                self.assertLessEqual(audit.optimized_bound, audit.top_bound)
                self.assertEqual(
                    audit.optimized_bound, EXPECTED_OPTIMIZED_BOUNDS[name]
                )


if __name__ == "__main__":
    unittest.main()
