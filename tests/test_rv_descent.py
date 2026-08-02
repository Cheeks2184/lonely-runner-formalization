from __future__ import annotations

import sys
import unittest
from fractions import Fraction
from pathlib import Path


SCRIPTS = Path(__file__).resolve().parents[1] / "scripts"
if str(SCRIPTS) not in sys.path:
    sys.path.insert(0, str(SCRIPTS))

from audit_rv_descent import (  # noqa: E402
    audit_common_scale,
    audit_deletion_obstruction,
    audit_fixed_pivot_signed_residues,
)


class ResidualVariationDescentTests(unittest.TestCase):
    def test_common_scale_components(self) -> None:
        for speeds in ((1, 2, 3, 5), (1, 2, 5, 7, 9, 11, 12, 13)):
            for factor in (2, 3):
                audit_common_scale(speeds, factor)

    def test_fixed_pivot_signed_residue_invariance(self) -> None:
        speeds = (2, 3, 7, 9, 10, 12, 15, 16, 19)
        audit_fixed_pivot_signed_residues(speeds, speeds.index(3))

    def test_deletion_certificate_does_not_lift(self) -> None:
        self.assertEqual(
            audit_deletion_obstruction(),
            {"deleted": Fraction(42, 5), "full": Fraction(-41, 7)},
        )


if __name__ == "__main__":
    unittest.main()
