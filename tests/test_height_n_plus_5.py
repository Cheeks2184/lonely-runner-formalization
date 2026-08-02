from __future__ import annotations

import subprocess
import sys
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


class HeightNPlus5CertificateTests(unittest.TestCase):
    def test_all_small_five_hole_certificates(self) -> None:
        output = subprocess.check_output(
            [sys.executable, str(ROOT / "scripts" / "verify_height_n_plus_5.py")],
            text=True,
        )
        expected = (
            ROOT / "certificates" / "height_n_plus_5_expected.txt"
        ).read_text()
        self.assertEqual(output, expected)


if __name__ == "__main__":
    unittest.main()
