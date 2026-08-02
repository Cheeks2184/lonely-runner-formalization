import unittest

from audit_crt_moment_formula import (
    EXPECTED_G_MOMENTS_0_TO_4,
    audit_g,
    audit_small_rows,
)


class CrtMomentFormulaTests(unittest.TestCase):
    def test_small_rows(self) -> None:
        audit_small_rows()

    def test_g(self) -> None:
        self.assertEqual(audit_g(), EXPECTED_G_MOMENTS_0_TO_4)


if __name__ == "__main__":
    unittest.main()
