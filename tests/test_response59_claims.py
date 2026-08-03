import hashlib
import subprocess
import sys
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "audit_response59_claims.py"
CERTIFICATE = ROOT / "certificates" / "response59_claims_expected.txt"
EXPECTED_SCRIPT_SHA256 = "a5a714961c9b93bf99fdaec5ebd0de80f5f9cc08708bd48b342241d31c28c9b9"


class Response59ClaimsTest(unittest.TestCase):
    def test_source_hash_is_pinned(self) -> None:
        digest = hashlib.sha256(SCRIPT.read_bytes()).hexdigest()
        self.assertEqual(digest, EXPECTED_SCRIPT_SHA256)

    def test_replay_matches_canonical_certificate(self) -> None:
        completed = subprocess.run(
            [sys.executable, str(SCRIPT)],
            cwd=ROOT,
            capture_output=True,
            text=True,
            check=False,
        )
        self.assertEqual(completed.returncode, 0, completed.stderr)
        self.assertEqual(completed.stderr, "")
        self.assertEqual(completed.stdout, CERTIFICATE.read_text(encoding="utf-8"))


if __name__ == "__main__":
    unittest.main()
