"""Regression tests for the explicit pivot-8 whole-overlap certificate."""

from __future__ import annotations

import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "scripts"))

from audit_whole_overlap_capacity import EXPECTED_GOOD, SELECTED, audit


class WholeOverlapCapacityTests(unittest.TestCase):
    def test_literal_blocks_capacity_and_union(self) -> None:
        report = audit()
        self.assertEqual(report.candidate_count, 72)
        self.assertEqual(report.bad_sum, 104)
        self.assertEqual(report.selected_blocks, 24)
        self.assertEqual(len(SELECTED), 24)
        self.assertEqual(report.selected_credit, 34)
        self.assertEqual(report.certified_bound, 70)
        self.assertLess(report.certified_bound, report.candidate_count)
        self.assertEqual(report.union_size, 68)
        self.assertEqual(report.good_residues, EXPECTED_GOOD)
        self.assertTrue(all(used == capacity for _residue, used, capacity in report.used_capacity))

    def test_strict_fixed_row_dominance_over_ordering(self) -> None:
        report = audit()
        self.assertEqual(report.ordered_additive_credit, 32)
        self.assertEqual(report.ordered_additive_bound, 72)
        self.assertGreater(report.selected_credit, report.ordered_additive_credit)
        self.assertLess(report.certified_bound, report.ordered_additive_bound)
        self.assertLessEqual(report.selected_credit, report.bad_sum - report.union_size)


if __name__ == "__main__":
    unittest.main()
