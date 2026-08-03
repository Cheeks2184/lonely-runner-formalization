"""Regression for the finite DPLP audit; this is not a uniform proof."""

from __future__ import annotations

import hashlib
from pathlib import Path
import subprocess
import sys
import unittest


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "audit_deletion_pivot_lift.py"
EXPECTED = ROOT / "certificates" / "deletion_pivot_lift_expected.txt"
SOURCE_SHA256 = "a152a8ed58f8257d2ce5f46f00a89d25bc9c4c9f4bc60d7b738a131f812ace1f"


class DeletionPivotLiftTests(unittest.TestCase):
    def test_complete_fixed_box_audit(self) -> None:
        self.assertEqual(hashlib.sha256(SCRIPT.read_bytes()).hexdigest(), SOURCE_SHA256)
        completed = subprocess.run(
            [sys.executable, str(SCRIPT)],
            cwd=ROOT,
            check=True,
            text=True,
            capture_output=True,
        )
        self.assertEqual(completed.stdout, EXPECTED.read_text(encoding="utf-8"))
        self.assertEqual(completed.stderr, "")


if __name__ == "__main__":
    unittest.main()
