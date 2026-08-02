"""Reproduce the bounded top-two pivot certificate and both checksums."""

from __future__ import annotations

import subprocess
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


class TopTwoPivotSearchTests(unittest.TestCase):
    def test_bounded_search_reproduces(self) -> None:
        subprocess.check_call(
            ["bash", str(ROOT / "scripts" / "audit_top_two_pivot_search.sh")]
        )


if __name__ == "__main__":
    unittest.main()
