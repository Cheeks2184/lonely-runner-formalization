import unittest
from fractions import Fraction

from scripts.audit_moment_lp import (
    G,
    T10,
    T11,
    audit_all,
    bounded_structured_scan,
    brute_feasible_root_sets,
    classified_root_sets,
    complementary_dual_certificate,
    individual_pivot_histograms,
    optimal_moment_bound,
    pivot_histogram,
)


class MomentLPTests(unittest.TestCase):
    def test_grid_root_vertex_classification(self):
        for m in range(1, 11):
            for order in range(1, m + 1):
                self.assertEqual(
                    classified_root_sets(m, order),
                    brute_feasible_root_sets(m, order),
                )

    def test_exact_global_rows(self):
        expected = {
            G: (3, Fraction(6061, 6), (1, 3, 4)),
            T10: (5, Fraction(29, 9), (1, 2, 3, 8, 9)),
            T11: (5, Fraction(59, 9), (1, 3, 4, 8, 9)),
        }
        for speeds, (order, score, roots) in expected.items():
            histogram = pivot_histogram(speeds)
            actual_score, actual_roots, _ = optimal_moment_bound(histogram, order)
            self.assertEqual((actual_score, actual_roots), (score, roots))
            dual = complementary_dual_certificate(histogram, order, roots)
            self.assertEqual(dual[0], score)

    def test_exact_G_pivot_rows(self):
        rows = individual_pivot_histograms(G)
        self.assertEqual(
            tuple(row[0] for row in rows),
            (0, 10, 0, 16, 48, 142, 156, 382, 1518),
        )
        score, roots, _ = optimal_moment_bound(rows[4], 3)
        self.assertEqual((score, roots), (Fraction(38, 3), (1, 3, 4)))

    def test_bounded_structured_rows(self):
        scan = bounded_structured_scan(max_n=13, max_order=6)
        consecutive = {n: result for n, _, result in scan["consecutive"]}
        powers = {n: result for n, _, result in scan["powers2"]}
        self.assertEqual(consecutive[10], (3, Fraction(32), (1, 5, 6)))
        self.assertEqual(consecutive[11], (5, Fraction(232, 9), (1, 2, 3, 8, 9)))
        self.assertEqual(powers[13], (3, Fraction(24079), (1, 4, 5)))

    def test_full_audit(self):
        rows = audit_all()
        self.assertEqual(rows["G"][0], 2272)


if __name__ == "__main__":
    unittest.main()
