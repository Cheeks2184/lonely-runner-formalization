"""Regression tests for the Lean trust-source filter."""

from __future__ import annotations

import shutil
import subprocess
import unittest
from pathlib import Path

from scripts.audit_lean_trust import source_has_forbidden_constructs


def find_lean(
    path_lookup=shutil.which, elan_lean: Path | None = None
) -> str | None:
    """Find Lean without requiring Lake or this project's dependencies."""
    if lean := path_lookup("lean"):
        return lean
    candidate = elan_lean or Path.home() / ".elan" / "bin" / "lean"
    return str(candidate) if candidate.is_file() else None


class LeanTrustAuditTests(unittest.TestCase):
    def assertAccepted(self, source: str) -> None:
        self.assertFalse(source_has_forbidden_constructs(source), source)

    def assertRejected(self, source: str) -> None:
        self.assertTrue(source_has_forbidden_constructs(source), source)

    def test_allows_only_exact_synchronous_elaboration_option(self) -> None:
        self.assertAccepted("set_option Elab.async false in\nexample : True := trivial")

    def test_rejects_neighboring_and_unknown_false_options(self) -> None:
        for source in (
            "set_option Elab.asyncx false in\nexample : True := trivial",
            "set_option elab.async false in\nexample : True := trivial",
            "set_option pp.universes false in\nexample : True := trivial",
            "set_option Elab.async.trace false in\nexample : True := trivial",
        ):
            with self.subTest(source=source):
                self.assertRejected(source)

    def test_synchronous_option_does_not_mask_later_forbidden_source(self) -> None:
        for source in (
            "set_option Elab.async false in\nset_option pp.universes false in\nexample : True := trivial",
            "set_option Elab.async false in\nsorry",
            "set_option Elab.async false in\naxiom forged : False",
            "set_option Elab.async false in axiom forged : False",
            "set_option Elab.async false in opaque forged : False := by trivial",
            "set_option Elab.async false in\nexample : True := by native_decide",
        ):
            with self.subTest(source=source):
                self.assertRejected(source)

    def test_comment_aware_guard_ignores_comments_and_catches_following_code(self) -> None:
        self.assertAccepted("/- axiom forged : False /- sorry -/ -/\n-- opaque hidden\nexample : True := trivial")
        for source in (
            "/- axiom forged : False -/\naxiom actual : False",
            "-- sorry\nopaque actual : True := trivial",
            "set_option Elab.async false in\ntheorem forged : False := by sorry",
        ):
            with self.subTest(source=source):
                self.assertRejected(source)

    def test_literals_and_quoted_names_do_not_hide_comment_markers(self) -> None:
        for source in (
            'def text := "-- /- still literal -/"\naxiom forged : False',
            'def text := r#"/- still raw -/ --"#\naxiom forged : False',
            "def marker := '-'\naxiom forged : False",
            "def «/- quoted --» := 0\naxiom forged : False",
        ):
            with self.subTest(source=source):
                self.assertRejected(source)

    def test_interpolation_and_prime_suffixed_identifiers_are_handled_conservatively(self) -> None:
        self.assertRejected(
            'def x := s!"{\"/-\"}"\naxiom forged : False\ndef y := "-/"\n-- "\n'
        )
        for source in (
            "def x'' : Nat := 0\nexample : Nat := x''",
            "def x_' : Nat := 0\nexample : Nat := x_'",
            "def α'' : Nat := 0\nexample : Nat := α''",
            'def plain := "ordinary string"\ndef raw := r#"raw string"#',
        ):
            with self.subTest(source=source):
                self.assertAccepted(source)

    def test_unterminated_lexical_structure_fails_closed(self) -> None:
        for source in ('/- never closes', '"never closes', 'r#"never closes', "'x"):
            with self.subTest(source=source):
                self.assertRejected(source)

    def test_all_existing_forbidden_construct_patterns_remain_rejected(self) -> None:
        for source in (
            "sorry",
            "admit",
            "axiom forged : False",
            "opaque hidden : True := trivial",
            "unsafe def escape := 1",
            "extern " + '"forged"' + " def escape : Nat",
            "partial_fixpoint escape : Nat := escape",
            "def escape : Nat := by implemented_by exact 0",
            "example : True := by native_decide",
        ):
            with self.subTest(source=source):
                self.assertRejected(source)

    def test_find_lean_returns_none_without_path_or_elan_binary(self) -> None:
        self.assertIsNone(find_lean(lambda _: None, Path("/missing/lean")))

    def test_sync_option_does_not_make_false_decide_kernel_check_pass(self) -> None:
        lean = find_lean()
        if lean is None:
            self.skipTest("Lean is unavailable; static trust-filter tests still ran")
        positive = subprocess.run(
            [lean, "--stdin"],
            input="set_option Elab.async false in\nexample : True := by decide\n",
            text=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            check=False,
            timeout=30,
        )
        self.assertEqual(positive.returncode, 0, positive.stdout)
        negative = subprocess.run(
            [lean, "--stdin"],
            input="set_option Elab.async false in\nexample : False := by decide\n",
            text=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            check=False,
            timeout=30,
        )
        self.assertNotEqual(negative.returncode, 0, negative.stdout)
        self.assertIn("Tactic `decide` proved that the proposition", negative.stdout)
        self.assertIn("False", negative.stdout)
        self.assertIn("is false", negative.stdout)


if __name__ == "__main__":
    unittest.main()
