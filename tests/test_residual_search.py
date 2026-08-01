"""Exact regression tests for residual-class research certificates."""

from __future__ import annotations

import importlib.util
import itertools
import math
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

    def test_pair_sum_spectrum_against_exact_optimizer(self) -> None:
        checked = 0
        for runner_count in range(2, 6):
            for speeds in itertools.combinations_with_replacement(
                range(1, 8), runner_count
            ):
                spectrum_value, _, _ = search.pair_sum_spectrum_optimum(speeds)
                exact_value, _, _ = checker.optimal_loneliness(speeds)
                self.assertEqual(spectrum_value, exact_value, speeds)
                checked += 1
        self.assertEqual(checked, 784)

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

    def test_parent_capacity_hierarchy(self) -> None:
        speeds = (1, 2, 7, 10, 11, 14)
        pivot = speeds.index(14)
        expected = {0: 110, 1: 78, 2: 70, 3: 66, 4: 64}
        for capacity, bound in expected.items():
            result = search.pivot_parent_best_bounds(speeds, capacity)[pivot]
            self.assertEqual(result, (bound, 84, 64))

    def test_parent_dynamic_program_against_permutation_reference(self) -> None:
        def reference_bound(
            speeds: tuple[int, ...], pivot: int, capacity: int
        ) -> int:
            others = tuple(i for i in range(len(speeds)) if i != pivot)
            masks = {
                other: search.pivot_bad_mask(speeds, pivot, other)
                for other in others
            }
            best = sum(mask.bit_count() for mask in masks.values())
            for order in itertools.permutations(others):
                previous: list[int] = []
                bound = 0
                for other in order:
                    overlap = 0
                    for size in range(1, min(capacity, len(previous)) + 1):
                        for parents in itertools.combinations(previous, size):
                            parent_union = 0
                            for parent in parents:
                                parent_union |= masks[parent]
                            overlap = max(
                                overlap,
                                (masks[other] & parent_union).bit_count(),
                            )
                    bound += masks[other].bit_count() - overlap
                    previous.append(other)
                best = min(best, bound)
            return best

        for runner_count in range(2, 6):
            for speeds in itertools.combinations(range(1, 8), runner_count):
                for capacity in range(4):
                    dynamic = search.pivot_parent_best_bounds(speeds, capacity)
                    for pivot in range(runner_count):
                        self.assertEqual(
                            dynamic[pivot][0],
                            reference_bound(speeds, pivot, capacity),
                            (speeds, pivot, capacity),
                        )

    def test_two_parent_failure_three_parent_witness(self) -> None:
        speeds = (1, 2, 5, 7, 9, 11, 12, 13)
        two_parent = search.pivot_parent_best_bounds(speeds, 2)
        self.assertTrue(all(bound >= universe for bound, universe, _ in two_parent))
        pivot = speeds.index(7)
        three_parent = search.pivot_parent_best_bounds(speeds, 3)
        self.assertEqual(three_parent[pivot], (50, 56, 50))
        self.assertEqual(search.witness_on_anchor_grid(speeds, 7), Fraction(8, 63))

    def test_second_two_parent_failure_three_parent_witness(self) -> None:
        speeds = (1, 5, 7, 8, 9, 11, 13, 15)
        two_parent = search.pivot_parent_best_bounds(speeds, 2)
        self.assertTrue(all(bound >= universe for bound, universe, _ in two_parent))
        pivot = speeds.index(7)
        three_parent = search.pivot_parent_best_bounds(speeds, 3)
        self.assertEqual(three_parent[pivot], (50, 56, 50))
        self.assertEqual(search.witness_on_anchor_grid(speeds, 7), Fraction(20, 63))

    def test_divisor_insertion_arithmetic_condition(self) -> None:
        speeds = (1, 2, 4, 6, 8, 14)
        self.assertEqual(search.divisor_insertion_condition_indices(speeds), (0,))
        deletion_gcd = 2
        orbit_size = deletion_gcd // math.gcd(deletion_gcd, speeds[0])
        self.assertEqual(orbit_size, 2)
        self.assertGreaterEqual((len(speeds) + 1) * (orbit_size - 1), 2 * orbit_size)

        # In a nonprimitive tuple m need not equal the deletion gcd.
        self.assertEqual(search.divisor_insertion_condition_indices((2, 4, 6)), ())


if __name__ == "__main__":
    unittest.main()
