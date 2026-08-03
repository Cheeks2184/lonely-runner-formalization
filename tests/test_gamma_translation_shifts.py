import hashlib
import subprocess
import sys
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "audit_gamma_translation_shifts.py"
EXPECTED = ROOT / "certificates" / "gamma_translation_shifts_expected.txt"
SOURCE_SHA256 = "4464a40ac3bed5c98c1131e4430cd9b0285d219fcbc3d1dc6b927bb6b8637fc8"


class GammaTranslationShiftTests(unittest.TestCase):
    def test_exact_fixed_shift_audit(self) -> None:
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
