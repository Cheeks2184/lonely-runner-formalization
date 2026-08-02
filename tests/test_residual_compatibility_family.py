from __future__ import annotations

import subprocess
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


class ResidualCompatibilityFamilyTests(unittest.TestCase):
    def test_exact_family_audit(self) -> None:
        subprocess.check_call(
            ["bash", str(ROOT / "scripts" / "audit_residual_compatibility_family.sh")]
        )


if __name__ == "__main__":
    unittest.main()
