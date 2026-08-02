from __future__ import annotations

from importlib.util import module_from_spec, spec_from_file_location
from itertools import combinations
from pathlib import Path
import unittest


ARTIFACT = (
    Path(__file__).resolve().parents[1]
    / "research"
    / "sol-pro"
    / "artifacts"
    / "prompt42_chebyshev_divisor_verifier.py"
)
SPEC = spec_from_file_location("prompt42_verifier", ARTIFACT)
assert SPEC is not None and SPEC.loader is not None
P42 = module_from_spec(SPEC)
SPEC.loader.exec_module(P42)


class Response42AuditTests(unittest.TestCase):
    def test_direct_crt_intersections(self) -> None:
        speeds = (1, 2, 3, 5)
        checked = 0
        for pivot in range(len(speeds)):
            others = tuple(i for i in range(len(speeds)) if i != pivot)
            for size in range(1, len(others) + 1):
                for runners in combinations(others, size):
                    self.assertEqual(
                        P42.intersection_count_crt(speeds, pivot, runners),
                        P42.intersection_count_literal(speeds, pivot, runners),
                    )
                    checked += 1
        self.assertEqual(checked, 28)

    def test_newton_score_matches_literal(self) -> None:
        for speeds in ((1, 2, 3, 5), (8, 15, 35, 40, 48, 56, 75, 132, 147)):
            for pivot in range(len(speeds)):
                literal, _ = P42.direct_pivot_score(speeds, pivot)
                self.assertEqual(literal, P42.score_from_moments(speeds, pivot))

    def test_complete_small_bounded_height_box(self) -> None:
        checked = 0
        for N in range(4, 14):
            for speeds in combinations(range(1, N + 2), N - 1):
                q, r = P42.bounded_height_witness(speeds)
                self.assertTrue(all(P42.rho(q, r * speed) * N >= q for speed in speeds))
                checked += 1
        self.assertEqual(checked, 445)


if __name__ == "__main__":
    unittest.main()
