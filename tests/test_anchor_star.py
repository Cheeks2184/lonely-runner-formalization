from __future__ import annotations

import itertools
import math
import sys
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

from audit_anchor_star import (  # noqa: E402
    STRESS_CASES,
    anchor_cost,
    audit_case,
    has_anchor_star_certificate,
    has_three_anchor_certificate,
    pair_degree,
    second_anchor_gain,
    zero_target_count,
    zero_target_divisor_formula,
)
from search_fiber_hall import pivot_bad_mask  # noqa: E402


class AnchorStarAuditTests(unittest.TestCase):
    def test_reported_stress_values(self) -> None:
        reports = [audit_case(case) for case in STRESS_CASES]
        self.assertEqual([report["U"] for report in reports], [25, 129, 238, 10, 52, 58])
        self.assertTrue(all(report["U"] < report["threshold"] for report in reports))

    def test_single_and_pair_anchor_identities(self) -> None:
        for _name, speeds, pivot_speed, *_rest in STRESS_CASES:
            pivot = speeds.index(pivot_speed)
            others = tuple(i for i in range(len(speeds)) if i != pivot)
            s_total = sum(pivot_bad_mask(speeds, pivot, i).bit_count() for i in others)
            for h in others:
                self.assertEqual(anchor_cost(speeds, pivot, (h,)), s_total - pair_degree(speeds, pivot, h))
                for q in others:
                    if q != h:
                        self.assertEqual(
                            anchor_cost(speeds, pivot, (h, q)),
                            s_total - pair_degree(speeds, pivot, h) - second_anchor_gain(speeds, pivot, h, q),
                        )

    def test_sum_E_identity(self) -> None:
        for _name, speeds, pivot_speed, *_rest in STRESS_CASES:
            pivot = speeds.index(pivot_speed)
            others = tuple(i for i in range(len(speeds)) if i != pivot)
            masks = {i: pivot_bad_mask(speeds, pivot, i) for i in others}
            global_pairs = sum((masks[i] & masks[q]).bit_count() for i, q in itertools.combinations(others, 2))
            for h in others:
                triple_h = sum((masks[h] & masks[i] & masks[q]).bit_count() for i, q in itertools.combinations((x for x in others if x != h), 2))
                lhs = sum(second_anchor_gain(speeds, pivot, h, q) for q in others if q != h)
                rhs = 2 * (global_pairs - pair_degree(speeds, pivot, h) - triple_h)
                self.assertEqual(lhs, rhs)

    def test_zero_target_divisor_formula_and_three_pivot_sum(self) -> None:
        for _name, speeds, _pivot_speed, *_rest in STRESS_CASES:
            n_factor = len(speeds) + 1
            # Check all ordered triples, not only the selected stress pivot.
            for pivot, h, i in itertools.permutations(range(len(speeds)), 3):
                literal = zero_target_count(speeds, pivot, h, i)
                formula = zero_target_divisor_formula(speeds, pivot, h, i)
                self.assertEqual(literal, formula)
                d = math.gcd(speeds[pivot], speeds[h], speeds[i])
                self.assertEqual(
                    formula,
                    d * (math.gcd(n_factor, speeds[h] // d, speeds[i] // d) - 1),
                )
            # The cyclic three-pivot identity follows because the subtracted
            # gcd is the same for each choice of pivot.
            for a, b, c in itertools.combinations(range(len(speeds)), 3):
                d = math.gcd(speeds[a], speeds[b], speeds[c])
                lhs = sum(zero_target_divisor_formula(speeds, p, h, i) for p, h, i in ((a, b, c), (b, a, c), (c, a, b)))
                rhs = math.gcd(n_factor * speeds[a], speeds[b], speeds[c]) + math.gcd(n_factor * speeds[b], speeds[a], speeds[c]) + math.gcd(n_factor * speeds[c], speeds[a], speeds[b]) - 3 * d
                self.assertEqual(lhs, rhs)

    def test_prime_normalized_equality_characterization(self) -> None:
        # This checks the number-theoretic statement independently of the
        # modular masks.  Primitive normalized triples cannot all contain p.
        for prime in (2, 3, 5, 7, 11):
            for normalized in itertools.product(range(1, 13), repeat=3):
                if math.gcd(*normalized) != 1:
                    continue
                cyclic = sum(
                    math.gcd(prime, normalized[h], normalized[i]) - 1
                    for _pivot, h, i in ((0, 1, 2), (1, 0, 2), (2, 0, 1))
                )
                expected = prime - 1 if sum(value % prime == 0 for value in normalized) == 2 else 0
                self.assertEqual(cyclic, expected)

    def test_small_complete_boxes(self) -> None:
        # Kept deliberately small for routine CI.  The larger deterministic
        # boundaries recorded in the audit note are reproducible through the
        # script's explicit scan CLI.
        for runners, max_speed in ((4, 8), (5, 7)):
            for speeds in itertools.combinations(range(1, max_speed + 1), runners):
                if math.gcd(*speeds) == 1:
                    self.assertTrue(has_anchor_star_certificate(speeds), speeds)
                    self.assertTrue(has_three_anchor_certificate(speeds), speeds)


if __name__ == "__main__":
    unittest.main()
