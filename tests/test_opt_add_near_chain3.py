"""Regression test for the fixed exact OPT-ADD neighborhoods around F."""

from __future__ import annotations

import subprocess
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


class OptAddNearChain3Tests(unittest.TestCase):
    def test_fixed_exact_audit(self) -> None:
        completed = subprocess.run(
            [
                "node",
                str(ROOT / "scripts" / "search_opt_add_near_chain3.js"),
                "--mode",
                "audit",
            ],
            cwd=ROOT,
            check=True,
            capture_output=True,
            text=True,
            timeout=120,
        )
        self.assertIn("AUDIT OK", completed.stdout)


if __name__ == "__main__":
    unittest.main()
