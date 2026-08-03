import hashlib
import subprocess
import sys
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "audit_gamma_diagonal_obstruction.py"
EXPECTED = ROOT / "certificates" / "gamma_diagonal_obstruction_expected.txt"
SOURCE_SHA256 = "401a1323c2939c81507fbcd94a0ad7e9a588b4a0bfbe7c58d750bf2e69004937"


class GammaDiagonalObstructionTests(unittest.TestCase):
    def test_exact_counterexample(self) -> None:
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
