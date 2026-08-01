"""Regression test for the fixed-pivot Fourier formulas."""

from __future__ import annotations

import importlib.util
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SCRIPT_PATH = ROOT / "scripts" / "check_fourier_badsets.py"
SPEC = importlib.util.spec_from_file_location("check_fourier_badsets", SCRIPT_PATH)
assert SPEC and SPEC.loader
fourier = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(fourier)


class FourierBadSetTests(unittest.TestCase):
    def test_candidate_pullback_and_convolution_formulas(self) -> None:
        checked = fourier.audit(5, 5, 2)
        self.assertGreater(checked, 0)


if __name__ == "__main__":
    unittest.main()
