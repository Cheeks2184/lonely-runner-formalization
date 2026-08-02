"""Regression wrapper for the exact fixed top-two fractional dual."""

from __future__ import annotations

import subprocess
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


class TopTwoFractionalDualTests(unittest.TestCase):
    def test_fixed_exact_certificate(self) -> None:
        subprocess.check_call(
            ["bash", str(ROOT / "scripts" / "audit_top_two_fractional_dual.sh")]
        )


if __name__ == "__main__":
    unittest.main()
