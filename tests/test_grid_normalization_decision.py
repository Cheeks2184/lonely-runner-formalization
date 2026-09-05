"""Exact backend controls and complete finite comparisons, not LRC negatives."""

from fractions import Fraction as F
from functools import cmp_to_key
from itertools import combinations, product
import json
from math import gcd
import unittest
from unittest.mock import patch

from scripts import grid_normalization as fixed
from scripts import grid_normalization_decision as engine


def brute_ar(N, V, M, c):
    """Independent signed enumeration, with no anchor or polynomial backend."""
    rows = [[z for e in (1, -1) if (z := e*c*v % M)] for v in V]
    a = all(any((N-1)*z < M and z % N for z in row) for row in rows)
    r = False
    for assignment in product(*rows):
        zeros = [z for z in assignment if z % N == 0]
        if not zeros:
            continue
        L, H = min(zeros), max(zeros)
        if not (H < (N-1)*L and N*H*L <= ((N-1)*L-H)*M):
            continue
        if all(z % N == 0 or (z < L and N*z*L <= (L-z)*M) for z in assignment):
            r = True
            break
    return a, r


class QuadraticBackendTests(unittest.TestCase):
    def test_constants_linear_and_double_roots(self):
        self.assertEqual(engine.real_roots(engine.polynomial()), ())
        self.assertEqual(engine.real_roots(engine.polynomial(1)), ())
        self.assertEqual(engine.real_roots(engine.polynomial(1, 0, 1)), ())
        self.assertEqual(engine.real_roots(engine.polynomial(-1, 2)), (F(1, 2),))
        self.assertEqual(engine.real_roots(engine.polynomial(1, -4, 4)), (F(1, 2),))
        self.assertEqual(engine.real_roots(engine.polynomial(-1, 0, 1)), (F(-1), F(1)))

    def test_canonical_irrational_roots_under_signed_rational_scaling(self):
        p = engine.polynomial(-2, 0, 1)
        roots = engine.real_roots(p)
        self.assertTrue(all(isinstance(x, engine.QuadraticRoot) for x in roots))
        for factor in (-100, -1, F(-3, 17), F(1, 49), 1, 28):
            self.assertEqual(engine.real_roots(engine.scale(p, factor)), roots)
            for root in roots:
                self.assertEqual(engine.polynomial_sign(engine.scale(p, factor), root), 0)
        self.assertEqual(len(set(roots+engine.real_roots(engine.scale(p, -7)))), 2)

    def test_isolating_intervals_and_rational_comparisons(self):
        low, high = engine.real_roots(engine.polynomial(-2, 0, 1))
        self.assertEqual(low.compare_rational(F(-3, 2)), 1)
        self.assertEqual(low.compare_rational(F(-7, 5)), -1)
        self.assertEqual(high.compare_rational(F(7, 5)), 1)
        self.assertEqual(high.compare_rational(F(3, 2)), -1)
        for root in (low, high):
            for bits in (0, 1, 10, 100):
                left, right = root.bounds(bits)
                self.assertEqual(root.compare_rational(left), 1)
                self.assertEqual(root.compare_rational(right), -1)

    def test_sign_reduction_and_cross_field_order(self):
        sqrt2 = engine.real_roots(engine.polynomial(-2, 0, 1))[1]
        sqrt3 = engine.real_roots(engine.polynomial(-3, 0, 1))[1]
        self.assertEqual(engine.compare_points(sqrt2, sqrt3), -1)
        self.assertEqual(engine.polynomial_sign(engine.polynomial(-3, 1, 1), sqrt2), 1)
        self.assertEqual(engine.polynomial_sign(engine.polynomial(0, -2, 1), sqrt2), -1)
        self.assertEqual(engine.polynomial_sign(engine.polynomial(0), sqrt2), 0)
        self.assertEqual(engine.polynomial_sign(engine.polynomial(-1), sqrt2), -1)
        points = [sqrt3, F(0), sqrt2, F(2)]
        self.assertEqual(sorted(points, key=cmp_to_key(engine.compare_points)),
                         [F(0), sqrt2, sqrt3, F(2)])

    def test_extremely_close_irrational_roots(self):
        # sqrt(2)+1/Q has the displayed primitive quadratic, independently derived.
        Q = 10**60
        root = engine.real_roots(engine.polynomial(-2, 0, 1))[1]
        shifted = engine.real_roots(engine.polynomial(1-2*Q*Q, -2*Q, Q*Q))[1]
        self.assertNotEqual(root, shifted)
        self.assertEqual(engine.compare_points(root, shifted), -1)
        self.assertEqual(engine.compare_points(shifted, root), 1)
        left, right = engine.rational_inner_interval(root, shifted)
        self.assertTrue(left < right)
        self.assertEqual(engine.compare_points(root, left), -1)
        self.assertEqual(engine.compare_points(right, shifted), -1)

    def test_noncanonical_or_inexact_backend_inputs_rejected(self):
        with self.assertRaises(ValueError):
            engine.QuadraticRoot(2, 0, -4, 1)
        with self.assertRaises(ValueError):
            engine.QuadraticRoot(1, 0, -4, 1)
        with self.assertRaises(TypeError):
            engine.polynomial(0.5)
        with self.assertRaises(TypeError):
            engine.compare_points(0.5, F(1, 2))
        with self.assertRaises(ValueError):
            engine.multiply(engine.polynomial(0, 0, 1), engine.polynomial(0, 1))


class FormulaDecisionTests(unittest.TestCase):
    def test_constant_and_strict_boundary_formulas(self):
        for formula in (False, engine.Compare(engine.polynomial(), True)):
            self.assertIsNone(engine.solve_formula(formula, F(0), F(1), 7, 1, 0))
        self.assertIsNotNone(engine.solve_formula(engine.Compare(engine.polynomial()),
                                                 F(0), F(1), 7, 0, 1))
        p = engine.polynomial(F(-1, 2), 1)
        impossible = engine.conjunction((engine.Compare(p, True), engine.Compare(engine.scale(p, -1))))
        self.assertIsNone(engine.solve_formula(impossible, F(0), F(1), 7, 1, 2))

    def test_rational_singleton_actual_class_only(self):
        p = engine.polynomial(F(-3, 196), 1)
        singleton = engine.conjunction((engine.Compare(p), engine.Compare(engine.scale(p, -1))))
        witness = engine.solve_formula(singleton, F(0), F(1, 14), 7, 3, 0)
        self.assertEqual(witness, engine.FormulaWitness(3, 196, "point"))
        coverage = engine.Coverage()
        self.assertIsNone(engine.solve_formula(singleton, F(0), F(1, 14), 7, 1, 3, coverage))
        self.assertEqual(coverage.counts["class_rejections"], 1)

    def test_irrational_singleton_is_complete_negative_backend_control(self):
        p = engine.polynomial(-1, 0, 2)
        singleton = engine.conjunction((engine.Compare(p), engine.Compare(engine.scale(p, -1))))
        coverage = engine.Coverage()
        self.assertIsNone(engine.solve_formula(singleton, F(0), F(1), 7, 1, 1, coverage))
        self.assertEqual(coverage.counts["irrational_rejections"], 1)
        self.assertEqual(coverage.counts["open_atoms"], 2)

    def test_open_atoms_with_irrational_endpoints_and_zero_classes(self):
        formula = engine.conjunction((engine.Compare(engine.polynomial(-1, 0, 2), True),
                                      engine.Compare(engine.polynomial(F(3, 4), -1), True)))
        for u, m in ((0, 1), (1, 0), (4, 6)):
            witness = engine.solve_formula(formula, F(0), F(1), 7, u, m)
            self.assertIsNotNone(witness)
            self.assertEqual(witness.kind, "open")
            self.assertEqual((witness.c % 7, witness.M % 7), (u, m))
            self.assertEqual(gcd(witness.c, witness.M), 1)
            self.assertTrue(engine.evaluate(formula, F(witness.c, witness.M)))

    def test_open_cell_endpoints_are_excluded(self):
        p = engine.polynomial(F(-1, 2), 1)
        singleton = engine.conjunction((engine.Compare(p), engine.Compare(engine.scale(p, -1))))
        self.assertIsNone(engine.solve_formula(singleton, F(1, 2), F(3, 4), 7, 1, 2))

    def test_coincident_roots_do_not_create_duplicate_atoms(self):
        p = engine.polynomial(-1, 0, 2)
        impossible = engine.conjunction((engine.Compare(p, True),
                                          engine.Compare(engine.scale(p, -3))))
        coverage = engine.Coverage()
        self.assertIsNone(engine.solve_formula(impossible, F(0), F(1), 5, 1, 0, coverage))
        self.assertEqual(coverage.counts["point_atoms"], 1)
        self.assertEqual(coverage.counts["open_atoms"], 2)

    def test_all_admissible_density_classes(self):
        count = 0
        for N in (3, 5, 7):
            for u, m in product(range(N), repeat=2):
                if not (u or m):
                    continue
                for left, right in ((F(1, 70), F(1, 60)), (F(2, 7), F(3, 8))):
                    c, M = engine.prescribed_pair(N, u, m, left, right)
                    self.assertTrue(left < F(c, M) < right)
                    self.assertEqual((c % N, M % N), (u, m))
                    self.assertEqual(gcd(c, M), 1)
                    count += 1
        self.assertEqual(count, 160)
        for N, u, m in ((7, 0, 0), (9, 2, 4)):
            with self.assertRaises(ValueError):
                engine.prescribed_pair(N, u, m, F(1, 4), F(1, 3))


class CompleteFormulaEnumerationTests(unittest.TestCase):
    def test_generated_formulas_match_full_signed_enumeration(self):
        fixtures = [(3, V, 13) for V in combinations(range(1, 7), 2) if gcd(*V) == 1]
        fixtures += [(5, (1, 2, 3, 5), 18), (5, (1, 2, 5, 20), 18),
                     (7, (1, 2, 3, 4, 7, 14), 18)]
        checked = boundaries = 0
        for N, V, stop in fixtures:
            cells = list(engine.velocity_cells(V))
            for M in range(2, stop):
                for c in range(1, M):
                    if gcd(c, M) != 1:
                        continue
                    expected = brute_ar(N, V, M, c)
                    x = F(c, M)
                    cell = next(((left, right) for left, right in cells if left < x < right), None)
                    if cell is None:
                        self.assertEqual(expected, (False, False))
                        boundaries += 1
                    else:
                        formulas = list(engine.cell_formulas(N, V, *cell, c % N, M % N))
                        actual = (engine.evaluate(formulas[0][1], x),
                                  any(engine.evaluate(f, x) for label, f in formulas[1:]))
                        self.assertEqual(actual, expected, (N, V, M, c))
                    checked += 1
        self.assertEqual((checked, boundaries), (780, 85))

    def test_complete_class_and_anchor_counts(self):
        # This enumerates every formula on every cell for a tiny fixed tuple;
        # both feasible and infeasible formula cases are checked to completion.
        N, V = 3, (1, 2)
        positive = negative = cases = 0
        for cell in engine.velocity_cells(V):
            for u, m in product(range(N), repeat=2):
                if not (u or m):
                    continue
                for label, formula in engine.cell_formulas(N, V, *cell, u, m):
                    result = engine.solve_formula(formula, *cell, N, u, m)
                    cases += 1
                    if result is None:
                        negative += 1
                    else:
                        positive += 1
                        cert = fixed.find_fixed_normalization(N, V, result.M, result.c)
                        self.assertIsNotNone(cert)
                        self.assertTrue(fixed.verify_certificate(cert))
        self.assertEqual(cases, 32)
        self.assertEqual((positive, negative), (12, 20))

    def test_actual_rational_coarse_equality_case(self):
        N, V, c, M = 7, (1, 2, 3, 4, 7, 14), 3, 196
        formulas = dict(engine.cell_formulas(N, V, F(0), F(1, 14), c % N, M % N))
        self.assertTrue(engine.evaluate(formulas["R:4:0"], F(c, M)))
        cert = fixed.find_fixed_normalization(N, V, M, c)
        self.assertEqual(cert["mode"], "R")
        self.assertTrue(fixed.verify_certificate(cert))


class FullDecisionTests(unittest.TestCase):
    def test_known_a_b_r_fixtures(self):
        fixtures = [(3, (1, 2), "A"), (7, (1, 2, 3, 4, 5, 31), "B"),
                    (7, (1, 2, 3, 4, 7, 14), "R"),
                    (7, (2, 3, 4, 30, 7, 14), "R")]
        for N, V, mode in fixtures:
            result = engine.decide_normalization(N, V)
            self.assertEqual(result["status"], "FEASIBLE")
            self.assertEqual(result["certificate"]["mode"], mode)
            self.assertTrue(fixed.verify_certificate(result["certificate"]))
            self.assertIsNone(result["max_cases"])
        # This pair lies well beyond a finite modulus cutoff and uses c == 0 mod N.
        self.assertGreater(result["certificate"]["M"], 10**9)
        self.assertEqual(result["certificate"]["c"] % 7, 0)

    def test_m_divisible_by_n_is_preserved(self):
        result = engine.decide_normalization(7, (1, 2, 3, 4, 7, 14))
        self.assertEqual(result["certificate"]["M"] % 7, 0)
        self.assertNotEqual(result["certificate"]["c"] % 7, 0)

    def test_explicit_budget_is_incomplete_not_negative(self):
        for budget in (0, 1, 5):
            result = engine.decide_normalization(3, (1, 2), max_cases=budget)
            self.assertEqual(result["status"], "INCOMPLETE")
            self.assertIsNone(result["certificate"])
            self.assertEqual(result["counts"].get("cases", 0), budget)
        self.assertEqual(engine.decide_normalization(3, (1, 2), max_cases=8)["status"], "FEASIBLE")

    def test_deterministic_receipt_json_replay_and_tampering(self):
        result = engine.decide_normalization(3, (1, 2))
        self.assertEqual(result, engine.decide_normalization(3, (1, 2)))
        self.assertTrue(engine.replay_record(json.loads(json.dumps(result))))
        bad = dict(result, coverage_sha256="0"*64)
        self.assertFalse(engine.replay_record(bad))
        incomplete = engine.decide_normalization(3, (1, 2), max_cases=0)
        self.assertTrue(engine.replay_record(incomplete))

    def test_reconstruction_or_arithmetic_errors_do_not_become_negatives(self):
        with patch.object(fixed, "find_fixed_normalization", return_value=None):
            with self.assertRaises(engine.DecisionError):
                engine.decide_normalization(3, (1, 2))
        with patch.object(fixed, "verify_certificate", return_value=False):
            with self.assertRaises(engine.DecisionError):
                engine.decide_normalization(3, (1, 2))
        with patch.object(engine, "polynomial_sign", side_effect=ArithmeticError("test")):
            with self.assertRaises(ArithmeticError):
                engine.decide_normalization(3, (1, 2))

    def test_strict_domain_and_budget_validation(self):
        for N, V in ((9, tuple(range(1, 9))), (3, (1, 1)), (3, (2, 4)),
                     (3, (0, 1)), (3, (1, 2, 3)), (3, [1, 2]), (3, (1.0, 2))):
            with self.assertRaises(ValueError):
                engine.decide_normalization(N, V)
        for limit in (-1, True, 1.5):
            with self.assertRaises(ValueError):
                engine.decide_normalization(3, (1, 2), max_cases=limit)


if __name__ == "__main__":
    unittest.main()
