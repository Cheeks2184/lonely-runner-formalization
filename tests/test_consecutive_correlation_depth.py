import unittest
from fractions import Fraction

from analyze_consecutive_correlation_depth import (
    asymptotic_minimum_positive_depth,
    elementary_depth_one_debt_closed,
    elementary_depth_one_debt_lower_bound,
    high_layer_score,
    histogram,
    minimum_positive_depth,
    phi,
    score,
    selected_depth_one_debt,
)


class ConsecutiveCorrelationDepthTests(unittest.TestCase):
    def test_complete_small_minimum_depths(self) -> None:
        expected = {
            4: 1, 5: 1, 6: 1, 7: 2, 8: 2, 9: 2, 10: 2,
            11: 3, 12: 2, 13: 4, 14: 4, 15: 5, 16: 5,
            17: 6, 18: 6, 19: 7, 20: 8, 21: 8, 22: 9,
            23: 9, 24: 10, 25: 10, 26: 11, 27: 11, 28: 12,
            29: 13, 30: 13, 31: 13, 32: 14, 33: 14, 34: 15,
            35: 15,
        }
        for n, wanted in expected.items():
            self.assertEqual(minimum_positive_depth(n, histogram(n)), wanted)

    def test_high_bad_layers_and_closed_score(self) -> None:
        for n in range(4, 36):
            counts = histogram(n)
            self.assertEqual(counts[0], n * phi(n + 1))
            for bad in range(n // 2 + 1, n):
                self.assertEqual(counts[bad], 2)
            for depth in range(1, n // 2 + 1):
                if 2 * depth > n // 2:
                    self.assertEqual(
                        score(n, depth, counts), high_layer_score(n, depth)
                    )

    def test_depth_one_selected_debt_bounds(self) -> None:
        for n in range(9, 121):
            lower = elementary_depth_one_debt_lower_bound(n)
            self.assertEqual(lower, elementary_depth_one_debt_closed(n))
            self.assertLessEqual(lower, selected_depth_one_debt(n))
        self.assertLessEqual(elementary_depth_one_debt_closed(89), 89**2)
        self.assertGreater(elementary_depth_one_debt_closed(90), 90**2)

        # The numerator of B(n)-n^2 and its forward difference at the
        # theorem threshold; the latter quadratic increases thereafter.
        gap_numerator = lambda n: (
            58 * n**3 - 5433 * n**2 + 24383 * n - 29064
        )
        forward_difference = lambda n: 174 * n**2 - 10692 * n + 19008
        self.assertEqual(gap_numerator(90), 440106)
        self.assertGreater(forward_difference(90), 0)
        self.assertGreater(348 * 90 - 10518, 0)

    def test_asymptotic_formula_arithmetic_branches(self) -> None:
        # Every even n follows the gap-two branch.
        self.assertEqual(asymptotic_minimum_positive_depth(90), 43)
        self.assertEqual(asymptotic_minimum_positive_depth(120), 58)

        # n+1 divisible by 30 gives the gap-one branch here.
        self.assertEqual(asymptotic_minimum_positive_depth(119), 58)
        self.assertEqual(asymptotic_minimum_positive_depth(149), 73)

        # n+1 a power of two gives the odd gap-two branch.
        self.assertEqual(asymptotic_minimum_positive_depth(127), 61)
        self.assertEqual(asymptotic_minimum_positive_depth(255), 125)

        with self.assertRaises(ValueError):
            asymptotic_minimum_positive_depth(89)
        with self.assertRaises(ValueError):
            high_layer_score(20, 3)


if __name__ == "__main__":
    unittest.main()
