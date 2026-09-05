import itertools
import unittest
from unittest.mock import patch

from scripts.grid_normalization import _r_assignment, find_fixed_normalization, verify_certificate


def brute_r(N, V, M, c):
    rows = []
    for v in V:
        rows.append([(z, e) for e in (1, -1) if (z := (e*c*v) % M)])
    for assignment in itertools.product(*rows):
        bases = [x[0] for x in assignment]
        zeros = [z for z in bases if z % N == 0]
        if not zeros:
            continue
        L, H = min(zeros), max(zeros)
        if not (H < (N-1)*L and N*H*L <= ((N-1)*L-H)*M):
            continue
        if all(not z % N or (0 < z < L and N*z*L <= (L-z)*M) for z in bases):
            return True
    return False


def brute_union(N, V, M, c):
    rows = [[(z, e) for e in (1, -1) if (z := (e*c*v) % M)] for v in V]
    small = [any((N-1)*z < M and z % N for z,e in row) for row in rows]
    a = all(small)
    b = any(v % M == 0 and v % N and all(small[j] for j in range(len(V)) if j != i)
            for i,v in enumerate(V))
    return a or b or brute_r(N, V, M, c)


class FixedGridTests(unittest.TestCase):
    def test_documented_multiple_zero_fixtures(self):
        for V, M, c in [((2,3,4,30,7,14), 257, 35), ((1,2,3,4,7,14), 66, 1)]:
            cert = find_fixed_normalization(7, V, M, c)
            self.assertIsNotNone(cert)
            self.assertEqual(cert["mode"], "R")
            self.assertTrue(verify_certificate(cert))

    def test_a_tight_tuple(self):
        cert = find_fixed_normalization(7, (1,2,3,4,5,6), 1009, 1)
        self.assertIsNotNone(cert)
        self.assertEqual(cert["mode"], "A")
        self.assertTrue(verify_certificate(cert))

    def test_b_fixture(self):
        # Speed 31 is the unique M-divisible pivot; other absolute residues are small.
        cert = find_fixed_normalization(7, (1,2,3,4,5,31), 31, 1)
        self.assertIsNotNone(cert)
        self.assertEqual(cert["mode"], "B")
        self.assertTrue(verify_certificate(cert))

    def test_r_uses_actual_offsets_not_bases(self):
        # Here b=405 is zero modulo 5, while the ordinary bases are nonzero.
        # The tempting base-only affine pair (2,4) is not a grid witness.
        cert = find_fixed_normalization(5, (1,2,3,5), 101, 1)
        self.assertEqual(cert["mode"], "R")
        self.assertEqual(cert["b"], 405)
        # These are the required least positive representatives modulo 505;
        # unreduced positive lifts would be (405,810,1215,2025).
        self.assertEqual(cert["actual"], (405,305,205,5))
        self.assertEqual((cert["affine"]["r0"], cert["affine"]["s"]), (1,1))
        self.assertTrue(verify_certificate(cert))

    def test_r_matches_bruteforce_small_complete_domain(self):
        # This includes M divisible by N and compares the residue predicate,
        # rather than incidental affine-witness availability.
        for M in range(2, 15):
            for c in range(1, M):
                if __import__("math").gcd(c, M) != 1:
                    continue
                for V in itertools.combinations(range(1, 11), 2):
                    if __import__("math").gcd(*V) != 1:
                        continue
                    self.assertEqual(_r_assignment(3, V, M, c) is not None,
                                     brute_r(3, V, M, c), (V,M,c))

    def test_full_fixed_predicate_matches_bruteforce(self):
        for M in range(2, 15):
            for c in range(1, M):
                if __import__("math").gcd(c, M) != 1:
                    continue
                for V in itertools.combinations(range(1, 11), 2):
                    if __import__("math").gcd(*V) != 1:
                        continue
                    cert = find_fixed_normalization(3, V, M, c)
                    self.assertEqual(cert is not None, brute_union(3, V, M, c), (V,M,c))
                    if cert is not None:
                        self.assertTrue(verify_certificate(cert), (V,M,c,cert))

    def test_tampering_and_invalid_inputs_rejected(self):
        cert = find_fixed_normalization(7, (1,2,3,4,7,14), 66, 1)
        self.assertTrue(verify_certificate(cert))
        bad = dict(cert); bad["signs"] = tuple(-x for x in cert["signs"])
        self.assertFalse(verify_certificate(bad))
        bad = dict(cert); bad["bases"] = (2,) + cert["bases"][1:]
        self.assertFalse(verify_certificate(bad))
        bad = dict(cert); bad["b"] = float(cert["b"])
        self.assertFalse(verify_certificate(bad))
        bad = dict(cert); bad["affine"] = dict(cert["affine"], time_num=True)
        self.assertFalse(verify_certificate(bad))
        bad = dict(cert); bad["affine"] = dict(cert["affine"], time_den=0)
        self.assertFalse(verify_certificate(bad))
        self.assertIsNone(find_fixed_normalization(9, (1,2,3,4,5,6,7,8), 17, 1))
        self.assertIsNone(find_fixed_normalization(7, (1,1,2,3,4,5), 17, 1))
        self.assertIsNone(find_fixed_normalization(7, [1,2,3,4,5,6], 17, 1))
        self.assertIsNone(find_fixed_normalization(7, (1,2,3,4,5,6), 1, 0))

    def test_reconstruction_failure_is_not_predicate_none(self):
        with patch("scripts.grid_normalization._affine_certificate", return_value=None):
            with self.assertRaises(RuntimeError):
                find_fixed_normalization(7, (1,2,3,4,5,6), 1009, 1)


if __name__ == "__main__":
    unittest.main()
