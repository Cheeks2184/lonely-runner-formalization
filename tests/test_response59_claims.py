import hashlib
import subprocess
import sys
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "audit_response59_claims.py"
CERTIFICATE = ROOT / "certificates" / "response59_claims_expected.txt"
EXPECTED_SCRIPT_SHA256 = "a5116f7d8b8d89793e62c519e8534f9aa4f222078735b4a28ce88c836645659f"


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
            check=True,
        )
        self.assertEqual(completed.stderr, "")
        self.assertEqual(completed.stdout, CERTIFICATE.read_text(encoding="utf-8"))


if __name__ == "__main__":
    unittest.main()
