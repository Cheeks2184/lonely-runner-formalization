from __future__ import annotations

import subprocess
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


class LogarithmicHeightTests(unittest.TestCase):
    def test_exact_selector_and_small_configurations(self) -> None:
        subprocess.check_call(
            ["bash", str(ROOT / "scripts" / "audit_logarithmic_height.sh")]
        )


if __name__ == "__main__":
    unittest.main()
