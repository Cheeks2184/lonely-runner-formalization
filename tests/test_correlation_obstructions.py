import unittest
from fractions import Fraction

from audit_correlation_obstructions import (
    consecutive_histogram,
    correlation_polynomial,
    depth_one_multiple_of_thirty_obstruction,
    fixed_depth_sufficient_condition,
    has_boundary_certificate,
    linear_depth_obstruction,
    pivot_bad_count_consecutive,
    safe_grid_count_formula,
    score_from_histogram,
    selected_extreme_contribution,
    theorem_upper_bound,
)


class CorrelationObstructionTests(unittest.TestCase):
    def test_consecutive_exact_rows(self) -> None:
        expected = {
            (7, 1): Fraction(-32, 3),
            (10, 2): Fraction(544, 9),
            (11, 2): Fraction(-156, 5),
            (29, 1): Fraction(-110027, 14),
        }
        histograms = {n: consecutive_histogram(n) for n, _ in expected}
        for (n, depth), score in expected.items():
            self.assertEqual(score_from_histogram(n, depth, histograms[n]), score)

    def test_safe_count_and_extreme_residues(self) -> None:
        for n in range(4, 25):
            histogram = consecutive_histogram(n)
            self.assertEqual(histogram[0], safe_grid_count_formula(n))
            self.assertTrue(has_boundary_certificate(n))
            for pivot in range(1, n + 1):
                modulus = (n + 1) * pivot
                self.assertEqual(pivot_bad_count_consecutive(n, pivot, 1), pivot - 1)
                self.assertEqual(
                    pivot_bad_count_consecutive(n, pivot, modulus - 1), pivot - 1
                )
            for depth in range(1, (n - 1) // 2 + 1):
                literal = sum(
                    2 * correlation_polynomial(n, depth, pivot - 1)
                    for pivot in range(2, n)
                )
                self.assertEqual(literal, selected_extreme_contribution(n, depth))
                score = score_from_histogram(n, depth, histogram)
                self.assertLessEqual(score, theorem_upper_bound(n, depth))

    def test_infinite_family_inequalities(self) -> None:
        for multiplier in range(1, 31):
            self.assertTrue(
                depth_one_multiple_of_thirty_obstruction(30 * multiplier - 1)
            )
            self.assertTrue(linear_depth_obstruction(60 * multiplier - 1))
        # These are sufficient, not necessary, thresholds.
        self.assertTrue(fixed_depth_sufficient_condition(329, 2))
        self.assertTrue(fixed_depth_sufficient_condition(59, 3))
        self.assertFalse(fixed_depth_sufficient_condition(29, 2))
        self.assertFalse(linear_depth_obstruction(29))


if __name__ == "__main__":
    unittest.main()
