"""Exact regression tests for residual-class research certificates."""

from __future__ import annotations

import importlib.util
import itertools
import sys
import unittest
from fractions import Fraction
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
CHECKER_PATH = ROOT / "scripts" / "check_integer_tuple.py"
CHECKER_SPEC = importlib.util.spec_from_file_location("check_integer_tuple", CHECKER_PATH)
assert CHECKER_SPEC and CHECKER_SPEC.loader
checker = importlib.util.module_from_spec(CHECKER_SPEC)
CHECKER_SPEC.loader.exec_module(checker)
sys.modules["check_integer_tuple"] = checker

SEARCH_PATH = ROOT / "scripts" / "search_residual.py"
SEARCH_SPEC = importlib.util.spec_from_file_location("search_residual", SEARCH_PATH)
assert SEARCH_SPEC and SEARCH_SPEC.loader
search = importlib.util.module_from_spec(SEARCH_SPEC)
SEARCH_SPEC.loader.exec_module(search)


class ResidualSearchTests(unittest.TestCase):
    def test_minimum_grid_and_fastest_half_counterexamples(self) -> None:
        self.assertIsNone(search.witness_on_minimum_grid((1, 2, 4)))
        self.assertEqual(checker.optimal_loneliness((1, 2, 4))[:2], (Fraction(1, 3), Fraction(1, 3)))

        certified, actual, counts = search.fastest_half_period_certificate((1, 3, 4))
        self.assertIsNone(certified)
        self.assertIsNone(actual)
        self.assertEqual(counts, (2, 2))
        self.assertEqual(checker.optimal_loneliness((1, 3, 4))[:2], (Fraction(2, 7), Fraction(3, 7)))

    def test_fastest_half_period_union_bound_witness(self) -> None:
        certified, actual, counts = search.fastest_half_period_certificate((1, 2, 4))
        self.assertEqual(counts, (2, 0))
        self.assertEqual(certified, Fraction(3, 8))
        self.assertEqual(actual, certified)
        self.assertGreaterEqual(checker.loneliness((1, 2, 4), certified), Fraction(1, 4))

    def test_sol_pivot_bad_count_formula_against_literal_sets(self) -> None:
        for runner_count in range(2, 5):
            for speeds in itertools.combinations(range(1, 9), runner_count):
                for pivot in range(runner_count):
                    for other in range(runner_count):
                        if other == pivot:
                            continue
                        literal = search.pivot_bad_mask(speeds, pivot, other).bit_count()
                        formula = search.pivot_bad_count_formula(speeds, pivot, other)
                        self.assertEqual(literal, formula, (speeds, pivot, other))

    def test_two_parent_certificate_is_sound_on_small_tuples(self) -> None:
        for runner_count in range(2, 6):
            for speeds in itertools.combinations(range(1, 9), runner_count):
                union_ok, two_parent_ok, actual_ok, mismatches = search.pivot_certificates(speeds)
                self.assertEqual(mismatches, 0)
                if union_ok:
                    self.assertTrue(two_parent_ok)
                if two_parent_ok:
                    self.assertTrue(actual_ok)

    def test_union_certificate_is_incomparable_with_band_criterion(self) -> None:
        # The pivot grids are broader than the fixed minimum-scale witness, but
        # the single-set union bound can lose too much to overlaps.  These are
        # exact counterexamples to the claim that its inequality subsumes the
        # residue-band theorem.
        for speeds in ((4, 5, 9), (2, 3, 5, 7), (2, 3, 4, 5, 6)):
            self.assertTrue(search.covered_by_minimum_residue_bands(speeds))
            union_ok, two_parent_ok, actual_ok, mismatches = search.pivot_certificates(speeds)
            self.assertFalse(union_ok)
            self.assertTrue(two_parent_ok)
            self.assertTrue(actual_ok)
            self.assertEqual(mismatches, 0)

    def test_fastest_anchor_grid_counterexample(self) -> None:
        speeds = (1, 4, 5, 6, 7, 11)
        self.assertIsNone(search.witness_on_anchor_grid(speeds, speeds[-1]))
        self.assertEqual(search.witness_on_any_speed_grid(speeds), Fraction(13, 42))
        self.assertEqual(
            checker.optimal_loneliness(speeds)[:2],
            (Fraction(2, 13), Fraction(4, 13)),
        )

    def test_adjacent_anchor_uniform_conjecture_counterexample(self) -> None:
        speeds = (1, 2, 3, 4, 5, 7)
        self.assertFalse(search.covered_by_fast_insertion(speeds))
        self.assertFalse(search.covered_by_minimum_residue_bands(speeds))
        results = search.adjacent_anchor_bounds(speeds)
        self.assertEqual(
            results,
            ((6, 6, 6), (12, 12, 12), (18, 18, 18),
             (24, 24, 24), (30, 30, 28), (46, 42, 40)),
        )
        self.assertTrue(all(bound >= universe for bound, universe, _ in results))
        self.assertTrue(any(exact < universe for _, universe, exact in results))


if __name__ == "__main__":
    unittest.main()
