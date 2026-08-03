"""Reproduce the lightweight Gamma matching-dependency sweep."""

from __future__ import annotations

import subprocess
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


class GammaDependencySweepTests(unittest.TestCase):
    def test_medium_grid_reproduces(self) -> None:
        subprocess.check_call(
            ["bash", str(ROOT / "scripts" / "audit_gamma_dependency_sweep.sh")]
        )


if __name__ == "__main__":
    unittest.main()
