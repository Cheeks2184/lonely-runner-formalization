from __future__ import annotations

import sys
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

from audit_anchor_star import (  # noqa: E402
    STRESS_CASES,
    has_anchor_star_certificate,
    has_three_anchor_certificate,
)
from audit_gamma_dispersion import has_dispersion_star_certificate  # noqa: E402
from search_anchor_star_failures import (  # noqa: E402
    certificate_margins,
    complete_box,
    deterministic_random_cases,
    evaluate_tuple,
    scan,
)


class AnchorStarSearchRound2Tests(unittest.TestCase):
    def test_every_optimized_stress_cost_matches_reference(self) -> None:
        # ``reference_check`` compares every triple at every pivot, rather
        # than checking only the certificate displayed in the audit note.
        for _name, speeds, *_rest in STRESS_CASES:
            evaluate_tuple(speeds, reference_check=True)

    def test_seeded_decisions_and_margin_signs_match_reference(self) -> None:
        cases = deterministic_random_cases(6, 40, 8, 20260801)
        for speeds in cases:
            result = evaluate_tuple(speeds, reference_check=True)
            margins = certificate_margins(speeds)
            self.assertEqual(
                margins["dispersion_star"] > 0,
                has_dispersion_star_certificate(speeds),
            )
            self.assertEqual(
                margins["anchor_star"] > 0,
                has_anchor_star_certificate(speeds),
            )
            self.assertEqual(
                margins["three_anchor"] > 0,
                has_three_anchor_certificate(speeds),
            )
            # The explicitly bounded Gamma is no larger than exact Gamma,
            # and averaging success produces an actual triple certificate.
            self.assertFalse(margins["dispersion_star"] > 0 and not result.anchor_star_succeeds)
            self.assertFalse(result.anchor_star_succeeds and not result.three_anchor_succeeds)

    def test_reported_consecutive_margins(self) -> None:
        expected = {
            4: {"dispersion_star": 8, "anchor_star": 4, "three_anchor": 4},
            5: {"dispersion_star": 12, "anchor_star": 6, "three_anchor": 2},
            6: {"dispersion_star": 72, "anchor_star": 36, "three_anchor": 6},
            7: {"dispersion_star": 80, "anchor_star": 40, "three_anchor": 4},
            8: {"dispersion_star": 180, "anchor_star": 90, "three_anchor": 6},
        }
        for runners, margins in expected.items():
            self.assertEqual(certificate_margins(tuple(range(1, runners + 1))), margins)

    def test_small_combined_complete_scan(self) -> None:
        report = scan(complete_box(4, 8), track_margins=True)
        self.assertEqual(report["checked"], 69)
        self.assertIsNone(report["first_dispersion_star_failure"])
        self.assertIsNone(report["first_anchor_star_failure"])
        self.assertIsNone(report["first_three_anchor_failure"])


if __name__ == "__main__":
    unittest.main()
