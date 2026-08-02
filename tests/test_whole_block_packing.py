"""Regression tests for exact and bounded whole-block capacity packing."""

from __future__ import annotations

import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "scripts"))

from audit_whole_block_packing import (
    F,
    G,
    audit_feasible_pivot,
    audit_pivot,
    audit_stress_set,
)


class WholeBlockPackingTests(unittest.TestCase):
    def test_completed_exact_rows(self) -> None:
        expected = {
            (F, 8): (32, 34, 36),
            (G, 15): (155, 155, 155),
            (G, 21): (167, 142, 177),
            (G, 40): (420, 420, 420),
            (G, 48): (424, 412, 440),
            (G, 126): (688, 654, 844),
        }
        for (speeds, pivot), row in expected.items():
            report = audit_pivot(speeds, pivot)
            self.assertEqual(
                (report.required_credit, report.optimum_credit, report.union_debt),
                row,
            )
            self.assertLessEqual(report.optimum_credit, report.union_debt)

    def test_all_pivot_replayed_bounds_and_g_rescue(self) -> None:
        expected_f = {
            8: (32, 34, 36),
            15: (102, 108, 118),
            35: (188, 204, 222),
            40: (194, 199, 232),
            48: (274, 254, 314),
            56: (308, 299, 368),
            75: (382, 436, 464),
            132: (692, 662, 820),
            147: (792, 793, 936),
        }
        expected_g = {
            15: (155, 155, 155),
            21: (167, 142, 177),
            40: (420, 420, 420),
            48: (424, 412, 440),
            56: (392, 400, 440),
            105: (465, 472, 607),
            126: (688, 642, 844),
            280: (1270, 1230, 1652),
            1200: (6432, 6630, 7950),
        }
        for speeds, expected in ((F, expected_f), (G, expected_g)):
            reports = {pivot: audit_feasible_pivot(speeds, pivot) for pivot in speeds}
            self.assertEqual(
                {
                    pivot: (
                        report.required_credit,
                        report.feasible_credit,
                        report.union_debt_upper,
                    )
                    for pivot, report in reports.items()
                },
                expected,
            )
        self.assertTrue(audit_feasible_pivot(G, 56).succeeds_strictly)

    def test_fixed_prior_stress_set_has_replayed_witnesses(self) -> None:
        observed = {
            name: (report.pivot, report.feasible_credit, report.required_credit)
            for name, report in audit_stress_set()
        }
        self.assertEqual(
            observed,
            {
                "RF": (3, 17, 15),
                "GCD1": (8, 40, 36),
                "GCD2": (6, 36, 34),
                "hardA": (7, 32, 26),
                "hardB": (7, 32, 26),
                "small": (3, 2, 0),
                "D": (10, 50, 44),
                "C": (15, 106, 105),
                "E": (28, 119, 108),
            },
        )


if __name__ == "__main__":
    unittest.main()
