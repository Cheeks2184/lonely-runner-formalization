from __future__ import annotations

import subprocess
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


class Response46AuditTests(unittest.TestCase):
    def test_recovered_artifact_reproduces(self) -> None:
        subprocess.check_call(["bash", str(ROOT / "scripts" / "audit_response46.sh")])


if __name__ == "__main__":
    unittest.main()
