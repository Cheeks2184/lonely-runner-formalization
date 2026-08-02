from fractions import Fraction
import unittest

from audit_response41 import (
    audit,
    brute_largest_signed_descents,
    characterized_largest_signed_descents,
    chebyshev_T,
    cross_pivot_scaling_holds,
    small_denominator_witness,
)


class Response41AuditTests(unittest.TestCase):
    def test_chebyshev_recurrence_exact(self) -> None:
        x = Fraction(7, 5)
        self.assertEqual(chebyshev_T(0, x), 1)
        self.assertEqual(chebyshev_T(1, x), x)
        self.assertEqual(chebyshev_T(2, x), 2 * x * x - 1)
        self.assertEqual(chebyshev_T(3, x), 4 * x**3 - 3 * x)

    def test_small_denominator_and_cross_pivot(self) -> None:
        self.assertTrue(small_denominator_witness((1, 5, 7, 11), 2))
        self.assertTrue(cross_pivot_scaling_holds((2, 3, 4, 6), 2, 3))

    def test_signed_descent_characterization_examples(self) -> None:
        examples = (
            (1, 2, 6, 20),
            (15, 21, 40, 48, 56, 105, 126, 280, 1200),
        )
        for speeds in examples:
            self.assertEqual(
                brute_largest_signed_descents(speeds),
                characterized_largest_signed_descents(speeds),
            )

    def test_full_response41_audit(self) -> None:
        result = audit()
        self.assertEqual(
            [(n, degree) for n, degree, _ in result["chebyshev_rows"]],
            [(59, 37), (84, 47)],
        )


if __name__ == "__main__":
    unittest.main()
