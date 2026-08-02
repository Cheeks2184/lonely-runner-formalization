"""Regression tests for the exact all-pivot CHAIN3 counterexample audit."""

from __future__ import annotations

from fractions import Fraction
import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "scripts"))

from audit_chain3_counterexample import (
    EXPECTED_ENDPOINT_HITS,
    EXPECTED_PIVOT_15_COSTS,
    EXPECTED_PIVOT_15_ORDER,
    EXPECTED_ROWS,
    EXPECTED_WITNESS_NUMERATORS,
    SPEEDS,
    audit_all,
    direct_witness,
    strict_endpoint_audit,
)


class Chain3CounterexampleTests(unittest.TestCase):
    def test_exact_all_pivot_table_and_strict_failure(self) -> None:
        reports = audit_all()
        self.assertEqual(tuple(report.pivot for report in reports), SPEEDS)
        self.assertEqual(
            {
                report.pivot: (
                    report.bad_sum,
                    report.potential,
                    report.beta,
                    *report.block_bounds,
                    report.soft_optimum,
                    report.additive_optimum,
                    report.threshold,
                )
                for report in reports
            },
            EXPECTED_ROWS,
        )
        self.assertTrue(all(report.block_bounds[2] >= report.beta for report in reports))
        self.assertEqual(
            tuple(report.pivot for report in reports if report.block_bounds[2] == report.beta),
            (75,),
        )

    def test_three_block_formula_and_pivot_15_optimum(self) -> None:
        reports = audit_all()
        for report in reports:
            # With eight nonpivot vertices, B3=b3(8)+b3(5)+b2(2).
            self.assertEqual(len(report.block_components[2]), 3)
            self.assertEqual(sum(report.block_components[2]), report.block_bounds[2])
        pivot_15 = reports[SPEEDS.index(15)]
        self.assertEqual(pivot_15.optimal_order, EXPECTED_PIVOT_15_ORDER)
        self.assertEqual(pivot_15.optimal_cost_vector, EXPECTED_PIVOT_15_COSTS)
        self.assertEqual(sum(pivot_15.optimal_cost_vector), 131)
        self.assertLess(131, 135)

    def test_candidate_filter_endpoints_and_direct_time(self) -> None:
        endpoint_rows = strict_endpoint_audit()
        self.assertEqual(endpoint_rows, EXPECTED_ENDPOINT_HITS)
        self.assertTrue(all(low == high for _pivot, low, high in endpoint_rows))
        residue, time, numerators = direct_witness()
        self.assertEqual(residue, 13)
        self.assertEqual(time, Fraction(13, 80))
        self.assertEqual(numerators, EXPECTED_WITNESS_NUMERATORS)
        self.assertGreaterEqual(min(numerators), 8)


if __name__ == "__main__":
    unittest.main()
