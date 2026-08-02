"""Regression tests for the clean-room OPT-ADD-UNIF counterexample audit."""

from __future__ import annotations

from fractions import Fraction
import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "scripts"))

from audit_opt_add_counterexample import (
    EXPECTED_ROWS,
    EXPECTED_WITNESS_NUMERATORS,
    SPEEDS,
    audit_all,
    direct_witness,
)


class OptAddCounterexampleTests(unittest.TestCase):
    def test_all_pivot_table_and_exhaustive_orders(self) -> None:
        reports = audit_all()
        self.assertEqual(tuple(report.pivot for report in reports), SPEEDS)
        self.assertEqual(
            {
                report.pivot: (
                    report.bad_sum,
                    report.potential,
                    report.soft_optimum,
                    report.additive_optimum,
                    report.threshold,
                )
                for report in reports
            },
            EXPECTED_ROWS,
        )
        self.assertTrue(all(report.exhaustive_orders == 40320 for report in reports))
        self.assertTrue(
            all(report.additive_optimum >= report.threshold for report in reports)
        )
        self.assertEqual(
            tuple(
                report.pivot
                for report in reports
                if report.additive_optimum == report.threshold
            ),
            (15, 40),
        )

    def test_strict_boundaries_candidate_count_and_direct_witness(self) -> None:
        reports = audit_all()
        self.assertTrue(
            all(report.candidate_count == 9 * report.pivot for report in reports)
        )
        self.assertTrue(
            all(low == high for report in reports for low, high in [report.endpoint_hits])
        )
        residue, time, numerators = direct_witness()
        self.assertEqual(residue, 39)
        self.assertEqual(time, Fraction(13, 160))
        self.assertEqual(numerators, EXPECTED_WITNESS_NUMERATORS)
        self.assertGreaterEqual(min(numerators), 48)


if __name__ == "__main__":
    unittest.main()
