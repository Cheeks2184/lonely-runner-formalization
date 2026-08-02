"""Regression tests for exact chain-aware soft-loss block bounds."""

from __future__ import annotations

import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "scripts"))

from audit_soft_chain_blocks import CASES, audit_all_cases


class SoftChainBlockTests(unittest.TestCase):
    def test_all_expected_rows(self) -> None:
        reports = audit_all_cases()
        self.assertEqual(len(reports), len(CASES))
        self.assertEqual(reports[-1].block_bounds, (259, 219, 187))
        self.assertEqual(reports[-1].optimum, 165)


if __name__ == "__main__":
    unittest.main()

