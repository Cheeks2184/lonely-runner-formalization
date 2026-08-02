"""Reproduce the exact obstruction to the global fractional-dual invariant."""

from __future__ import annotations

import subprocess
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


class TopTwoFractionalObstructionTests(unittest.TestCase):
    def test_exact_obstruction_and_integral_noncover(self) -> None:
        subprocess.check_call(
            [
                "bash",
                str(
                    ROOT
                    / "scripts"
                    / "audit_top_two_fractional_obstruction.sh"
                ),
            ]
        )


if __name__ == "__main__":
    unittest.main()
