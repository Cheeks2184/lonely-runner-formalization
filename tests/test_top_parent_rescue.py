"""Regression tests for the independent top-parent rescue audit."""

from fractions import Fraction
from itertools import permutations
import unittest

from audit_top_parent_rescue import (
    CONDITIONED_ROWS,
    DIVISOR_ROWS,
    PREFIX_ROWS,
    SEPARATING_ROWS,
    TOP_UNIF_COUNTEREXAMPLE,
    TOP_UNIF_COUNTEREXAMPLE_ROWS,
    conditioned_random_loss,
    direct_witness_distances,
    exhaustive_optima,
    literal_pivot,
    order_credits,
    prefix_conditioned_bounds,
    reciprocal_base,
    top_unif_counterexample_rows,
)


class TopParentRescueTests(unittest.TestCase):
    def test_fixed_pivot_strict_separations(self) -> None:
        for name, speeds, pivot, expected in SEPARATING_ROWS:
            with self.subTest(name=name):
                data = literal_pivot(speeds, pivot)
                optima = exhaustive_optima(data)
                tau = data.top_weight - optima.maximum_top
                top_cost = data.bad_sum - optima.maximum_top
                same_order_cost = data.bad_sum - optima.top_order_full
                optimum_cost = data.bad_sum - optima.maximum_full
                reciprocal, residual = reciprocal_base(data, optima.top_order)
                self.assertEqual(
                    (
                        data.candidate_count,
                        data.bad_sum,
                        data.top_weight,
                        tau,
                        top_cost,
                        optima.top_order_rescue,
                        same_order_cost,
                        optimum_cost,
                        reciprocal,
                        residual,
                    ),
                    expected,
                )
                # Equality would still fail the avoidance theorem.  These
                # rows genuinely separate non-strict top failure from strict
                # unrestricted additive success at one fixed pivot.  On the
                # E row, unlike the first two rows, a different order is
                # required to turn the available rescue into a certificate.
                self.assertGreaterEqual(top_cost, data.candidate_count)
                self.assertLess(optimum_cost, data.candidate_count)
                if name == "E-28":
                    self.assertGreaterEqual(
                        same_order_cost, data.candidate_count
                    )
                else:
                    self.assertLess(same_order_cost, data.candidate_count)

    def test_rescue_identity_on_every_order(self) -> None:
        # ``exhaustive_optima`` calls ``order_credits`` on every permutation;
        # that routine asserts the identity separately on every token and on
        # the final sums.  Rechecking the recorded optimum makes the intended
        # global cost formula explicit here.
        speeds = (8, 15, 35, 40, 48, 56, 68, 75, 78)
        data = literal_pivot(speeds, 56)
        optima = exhaustive_optima(data)
        top_loss = data.top_weight - optima.maximum_top
        self.assertEqual(
            data.bad_sum - optima.top_order_full,
            data.bad_sum
            - data.top_weight
            + top_loss
            - optima.top_order_rescue,
        )

    def test_conditioned_random_loss_table(self) -> None:
        for name, speeds, pivot, expected, _threshold in CONDITIONED_ROWS:
            with self.subTest(name=name):
                data = literal_pivot(speeds, pivot)
                observed, _vertex, _placement = conditioned_random_loss(data)
                self.assertEqual(observed, expected)

    def test_conditioned_formula_is_literal_order_average(self) -> None:
        # On the three-vertex nonpivot universe, explicitly average all orders
        # with the minimizing vertex fixed at the claimed end.  This is an
        # independent finite check of the probability denominators.
        data = literal_pivot((1, 2, 3, 5), 3)
        bound, speed, placement = conditioned_random_loss(data)
        vertex = data.speeds.index(speed)
        remaining = tuple(child for child in data.others if child != vertex)
        losses = []
        for middle in permutations(remaining):
            order = (
                (vertex,) + middle
                if placement == "first"
                else middle + (vertex,)
            )
            credits = order_credits(data, order)
            losses.append(data.top_weight - credits.top)
        self.assertEqual(Fraction(sum(losses), len(losses)), bound)

    def test_strict_bad_boundaries_are_excluded(self) -> None:
        for speeds, pivot in (
            ((8, 15, 35, 40, 48, 56, 63, 75, 78), 40),
            ((8, 15, 35, 40, 48, 56, 68, 75, 78), 56),
        ):
            with self.subTest(pivot=pivot):
                data = literal_pivot(speeds, pivot)
                targets = {token.target for token in data.tokens}
                self.assertNotIn(pivot, targets)
                self.assertNotIn(data.modulus - pivot, targets)
                self.assertTrue(
                    all(
                        target < pivot or target > data.modulus - pivot
                        for target in targets
                    )
                )

    def test_prefix_conditioned_hierarchy(self) -> None:
        for name, speeds, pivot, expected_size, expected_bound, threshold in PREFIX_ROWS:
            with self.subTest(name=name):
                data = literal_pivot(speeds, pivot)
                hierarchy = prefix_conditioned_bounds(data)
                strict = tuple(
                    (size, bound)
                    for size, (bound, _order) in enumerate(hierarchy)
                    if bound < threshold
                )
                self.assertTrue(strict)
                self.assertEqual(strict[0], (expected_size, expected_bound))
                # The empty-prefix endpoint is ordinary tie-aware random
                # ordering, while the full-prefix endpoint has no random
                # tail and is the exact top feedback loss.
                random_bound = sum(
                    Fraction(token.top_weight, len(token.top_parents) + 1)
                    for token in data.tokens
                    if token.top_weight
                )
                self.assertEqual(hierarchy[0][0], random_bound)
                self.assertIsInstance(hierarchy[-1][0], Fraction)

    def test_full_prefix_endpoint_equals_exhaustive_top_loss(self) -> None:
        # Use the small row so the independent permutation oracle is tiny.
        data = literal_pivot((1, 2, 3, 5), 3)
        hierarchy = prefix_conditioned_bounds(data)
        optima = exhaustive_optima(data)
        self.assertEqual(
            hierarchy[-1][0], data.top_weight - optima.maximum_top
        )

    def test_all_pivot_top_unif_counterexample(self) -> None:
        observed = top_unif_counterexample_rows()
        self.assertEqual(
            tuple(row[:6] for row in observed),
            tuple(row[:6] for row in TOP_UNIF_COUNTEREXAMPLE_ROWS),
        )
        self.assertTrue(
            all(top_cost >= threshold for _a, threshold, _s, _f, _tau, top_cost, _opt in observed)
        )
        self.assertEqual(
            tuple(
                pivot
                for pivot, threshold, _s, _f, _tau, top_cost, _opt in observed
                if top_cost == threshold
            ),
            (5, 35),
        )

    def test_counterexample_pivot_28_direct_lonely_witness(self) -> None:
        pivot = 28
        residue = 6
        modulus = (len(TOP_UNIF_COUNTEREXAMPLE) + 1) * pivot
        self.assertNotEqual(residue % (len(TOP_UNIF_COUNTEREXAMPLE) + 1), 0)
        witness = direct_witness_distances(
            TOP_UNIF_COUNTEREXAMPLE, pivot, residue
        )
        self.assertEqual(
            tuple(distance for _speed, _image, distance in witness),
            (30, 112, 70, 40, 128, 32, 88, 48, 130),
        )
        self.assertTrue(
            all(distance >= pivot for _speed, _image, distance in witness)
        )
        self.assertEqual(Fraction(residue, modulus), Fraction(3, 140))

    def test_ordered_gcd_data_do_not_determine_top_credit(self) -> None:
        observed_rows = []
        for speeds, pivot, expected_gcds, expected in DIVISOR_ROWS:
            data = literal_pivot(speeds, pivot)
            optima = exhaustive_optima(data)
            tau = data.top_weight - optima.maximum_top
            observed = (
                data.candidate_count,
                data.bad_sum,
                data.top_weight,
                tau,
                data.bad_sum - optima.maximum_top,
            )
            self.assertEqual(observed, expected)
            observed_rows.append((expected_gcds, observed))
        self.assertEqual(observed_rows[0][0], observed_rows[1][0])
        self.assertNotEqual(observed_rows[0][1][2], observed_rows[1][1][2])


if __name__ == "__main__":
    unittest.main()
