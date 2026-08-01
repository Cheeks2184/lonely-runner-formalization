"""Regression tests for the exact integer-tuple checker."""

from __future__ import annotations

import copy
import importlib.util
import itertools
import json
import subprocess
import sys
import tempfile
import unittest
from fractions import Fraction
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "check_integer_tuple.py"
SPEC = importlib.util.spec_from_file_location("check_integer_tuple", SCRIPT)
assert SPEC and SPEC.loader
checker = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(checker)

BAD_SET_SCRIPT = ROOT / "scripts" / "check_bad_sets.py"
BAD_SET_SPEC = importlib.util.spec_from_file_location("check_bad_sets", BAD_SET_SCRIPT)
assert BAD_SET_SPEC and BAD_SET_SPEC.loader
bad_sets = importlib.util.module_from_spec(BAD_SET_SPEC)
sys.modules["check_integer_tuple"] = checker
BAD_SET_SPEC.loader.exec_module(bad_sets)


class ExactCheckerTests(unittest.TestCase):
    def test_circle_distance_is_exact_and_periodic(self) -> None:
        self.assertEqual(checker.circle_distance(3, Fraction(1, 5)), Fraction(2, 5))
        self.assertEqual(checker.circle_distance(3, Fraction(6, 5)), Fraction(2, 5))

    def test_known_tight_consecutive_tuples(self) -> None:
        for moving_runners in range(1, 7):
            speeds = tuple(range(1, moving_runners + 1))
            optimum, witness, _ = checker.optimal_loneliness(speeds)
            self.assertEqual(optimum, Fraction(1, moving_runners + 1))
            self.assertEqual(checker.loneliness(speeds, witness), optimum)

    def test_repeated_speed_tuple_is_supported(self) -> None:
        certificate = checker.make_certificate((2, 2, 4))
        self.assertTrue(certificate["meets_target"])
        self.assertEqual(certificate["optimum"], "1/3")

    def test_certificate_round_trip_and_tamper_rejection(self) -> None:
        certificate = checker.make_certificate((1, 3, 4, 7))
        self.assertEqual(checker.verify_certificate(certificate), certificate)
        altered = copy.deepcopy(certificate)
        altered["optimum"] = "1/2"
        with self.assertRaisesRegex(ValueError, "differing fields: optimum"):
            checker.verify_certificate(altered)

    def test_certificate_rejects_python_equal_wrong_json_types(self) -> None:
        certificate = checker.make_certificate((1, 2))
        altered_count = copy.deepcopy(certificate)
        altered_count["candidate_count"] = float(certificate["candidate_count"])
        with self.assertRaisesRegex(ValueError, "candidate_count must be a JSON integer"):
            checker.verify_certificate(altered_count)

        altered_boolean = copy.deepcopy(certificate)
        altered_boolean["meets_target"] = 1
        with self.assertRaisesRegex(ValueError, "meets_target must be a JSON Boolean"):
            checker.verify_certificate(altered_boolean)

    def test_exhaustive_distinct_tuples_through_four_of_eight(self) -> None:
        summary = checker.exhaustive_summary(max_runners=4, max_speed=8)
        self.assertEqual(summary["instances"], 162)
        self.assertEqual(summary["failures"], [])
        for dimension in summary["by_dimension"]:
            self.assertGreaterEqual(Fraction(dimension["minimum_margin"]), 0)

    def test_cli_writes_and_verifies_certificate(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "certificate.json"
            created = subprocess.run(
                [sys.executable, str(SCRIPT), "check", "1", "2", "3", "--certificate", str(path)],
                check=False,
                text=True,
                capture_output=True,
            )
            self.assertEqual(created.returncode, 0, created.stderr + created.stdout)
            self.assertEqual(json.loads(path.read_text(encoding="utf-8"))["optimum"], "1/4")
            verified = subprocess.run(
                [sys.executable, str(SCRIPT), "verify", str(path)],
                check=False,
                text=True,
                capture_output=True,
            )
            self.assertEqual(verified.returncode, 0, verified.stderr + verified.stdout)

    def test_committed_outputs_recompute_exactly(self) -> None:
        certificate_path = ROOT / "certificates" / "integer-1-2-3.json"
        certificate = json.loads(certificate_path.read_text(encoding="utf-8"))
        self.assertEqual(checker.verify_certificate(certificate), certificate)

        summary_path = ROOT / "certificates" / "exhaustive-4-of-8.json"
        summary = json.loads(summary_path.read_text(encoding="utf-8"))
        self.assertEqual(summary, checker.exhaustive_summary(max_runners=4, max_speed=8))

    def test_exact_bad_set_audit_for_consecutive_four_tuple(self) -> None:
        speeds = (1, 2, 3, 4)
        threshold = Fraction(1, 5)
        expected_pairs = {
            (1, 2): Fraction(1, 5),
            (1, 3): Fraction(2, 15),
            (1, 4): Fraction(1, 10),
            (2, 3): Fraction(2, 15),
            (2, 4): Fraction(1, 5),
            (3, 4): Fraction(1, 6),
        }
        self.assertEqual(
            {
                pair: bad_sets.intersection_measure(pair, threshold)
                for pair in itertools.combinations(speeds, 2)
            },
            expected_pairs,
        )
        self.assertEqual(sum(expected_pairs.values()), Fraction(14, 15))

        triples = {
            triple: bad_sets.intersection_measure(triple, threshold)
            for triple in itertools.combinations(speeds, 3)
        }
        self.assertEqual(
            triples,
            {
                (1, 2, 3): Fraction(2, 15),
                (1, 2, 4): Fraction(1, 10),
                (1, 3, 4): Fraction(1, 10),
                (2, 3, 4): Fraction(1, 10),
            },
        )
        self.assertEqual(sum(triples.values()), Fraction(13, 30))
        self.assertEqual(bad_sets.intersection_measure(speeds, threshold), Fraction(1, 10))
        self.assertEqual(bad_sets.union_measure(speeds, threshold), Fraction(1))
        self.assertEqual(
            bad_sets.safe_decomposition(speeds, threshold),
            ((Fraction(1, 5), Fraction(2, 5), Fraction(3, 5), Fraction(4, 5)), ()),
        )


if __name__ == "__main__":
    unittest.main()
