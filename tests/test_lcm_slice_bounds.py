"""Regression tests for exact LCM slices and signed replacement descent."""

from __future__ import annotations

from fractions import Fraction
import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "scripts"))

from audit_lcm_slice_bounds import (
    G,
    NEAR_TOP,
    T10,
    T11,
    audit_all,
    audit_replacement_example,
    lower_bound,
    pivot_witness,
    replacement_candidates,
)


class LcmSliceBoundsTests(unittest.TestCase):
    def test_g_histogram_moments_and_safe_count_identity(self) -> None:
        report = audit_all()["G"]
        self.assertEqual(report.ell, 25200)
        self.assertEqual(report.modulus, 252000)
        self.assertEqual(
            report.histogram,
            (2272, 6134, 5610, 2208, 584, 180, 7, 16, 8, 0),
        )
        self.assertEqual(
            report.moments,
            (17019, 27432, 18203, 7492, 2709, 1006, 343, 80, 8, 0),
        )
        self.assertEqual(
            report.safe_pivot_counts,
            (0, 10, 0, 16, 48, 142, 156, 382, 1518),
        )
        self.assertEqual(sum(report.safe_pivot_counts), report.histogram[0])
        self.assertEqual(lower_bound(report, 2), Fraction(3305, 2))
        self.assertEqual(lower_bound(report, 4), Fraction(2272))

    def test_low_depth_rows_and_direct_certificates(self) -> None:
        reports = audit_all()
        self.assertEqual(
            (lower_bound(reports["T10"], 2), lower_bound(reports["T10"], 3)),
            (Fraction(-226, 9), Fraction(4)),
        )
        self.assertEqual(
            (
                lower_bound(reports["T11"], 2),
                lower_bound(reports["T11"], 3),
                lower_bound(reports["T11"], 4),
            ),
            (Fraction(-298, 5), Fraction(0), Fraction(22)),
        )
        self.assertEqual(
            pivot_witness(T10, 3, 10),
            (33, (10, 13, 3, 7, 16, 6, 4, 14, 9, 11)),
        )
        self.assertEqual(
            pivot_witness(T11, 3, 11),
            (36, (11, 14, 3, 8, 17, 6, 5, 16, 9, 13, 12)),
        )

    def test_near_top_zero_and_high_depth_tautology(self) -> None:
        report = audit_all()["near"]
        self.assertEqual(lower_bound(report, 1), 0)
        self.assertEqual(lower_bound(report, 2), 14)
        self.assertEqual(lower_bound(report, 2), report.histogram[0])
        self.assertEqual(pivot_witness(NEAR_TOP, 3, 7), (18, (7, 4, 3, 8, 6)))

    def test_replacement_example_and_exhaustive_g_absence(self) -> None:
        self.assertEqual(audit_replacement_example(), ((24, 6, 4),))
        self.assertEqual(replacement_candidates(G), ())


if __name__ == "__main__":
    unittest.main()
