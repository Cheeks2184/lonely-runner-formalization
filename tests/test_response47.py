import subprocess
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


class Response47AuditTests(unittest.TestCase):
    def test_recovered_artifact_reproduces(self) -> None:
        subprocess.run(
            ["bash", str(ROOT / "scripts" / "audit_response47.sh")],
            cwd=ROOT,
            check=True,
        )


if __name__ == "__main__":
    unittest.main()
