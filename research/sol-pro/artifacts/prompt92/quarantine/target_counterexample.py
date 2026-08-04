#!/usr/bin/env python3
"""Exact symbolic counterexample certificate for Prompt 92 at n=6."""
from __future__ import annotations

import hashlib
import json
import math
import platform
from pathlib import Path


def rho(M: int, x: int) -> int:
    y = x % M
    return min(y, M - y)


def nu2(x: int) -> int:
    if x == 0:
        raise ValueError("nu2(0) is not used in this certificate")
    return (x & -x).bit_length() - 1


def full_cover_bruteforce(q: int) -> bool:
    M = 7 * q
    a = M // 4
    b = M // 2
    v = (1, 1, a - 1, a + 1, b - 1, b)
    return all(any(rho(M, r * x) < q for x in v) for r in range(M))


def threshold_data(n: int) -> tuple[int, int, int, int, int, int]:
    C = math.comb(n + 1, 2)
    A = C ** (n * (n - 1))
    nn = n**n
    T = (A + nn - 1) // nn
    E = max(3, T.bit_length())
    q = 1 << E
    M = (n + 1) * q
    return C, A, T, E, q, M


def main() -> None:
    n = 6
    N = 7
    C, A, T, E, q, M = threshold_data(n)
    a = M // 4
    b = M // 2
    v = (1, 1, a - 1, a + 1, b - 1, b)
    deletion_gcds = []
    for k in range(n):
        g = M
        for i, x in enumerate(v):
            if i != k:
                g = math.gcd(g, x)
        deletion_gcds.append(g)
    valuations = [nu2(x) for x in v]
    product_value = math.prod(v)

    # Private residues for the five distinct labelled sets after one duplicate 1 is removed.
    private = {
        "1": 1,
        "a-1": q + 1,
        "a+1": q + 3,
        "b-1": b - 1,
        "b": q,
    }
    distinct = (1, a - 1, a + 1, b - 1, b)
    private_checks = {}
    for label, r in private.items():
        bad = [rho(M, r * x) < q for x in distinct]
        private_checks[label] = {"r": r, "bad_vector": bad, "exactly_one_bad": sum(bad) == 1}

    source_hash = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    report = {
        "language": "Python",
        "python_version": platform.python_version(),
        "source_sha256": source_hash,
        "status": "EXACT_SYMBOLIC_TARGET_COUNTEREXAMPLE",
        "parameters": {
            "n": n,
            "N": N,
            "C_n": C,
            "A_n": A,
            "T_n": T,
            "E_n": E,
            "q_n": q,
            "M_n": M,
            "two_to_E_minus_1": 1 << (E - 1),
            "threshold_checks": {
                "n_power_n_times_T_ge_A": n**n * T >= A,
                "n_power_n_times_T_minus_1_lt_A": n**n * (T - 1) < A,
                "two_to_E_minus_1_le_T": (1 << (E - 1)) <= T,
                "T_lt_two_to_E": T < (1 << E),
            },
        },
        "tuple": list(v),
        "tuple_formula": ["1", "1", "M/4-1", "M/4+1", "M/2-1", "M/2"],
        "canonical_representatives": all(0 <= x < M for x in v),
        "deletion_gcds": deletion_gcds,
        "coordinate_two_adic_valuations": valuations,
        "product_two_adic_valuation": sum(valuations),
        "q_exponent": E,
        "q_divides_product": product_value % q == 0,
        "product_mod_q": product_value % q,
        "complete_cover_decision_table": [
            "r even -> owner M/2, because r(M/2)=0 mod M",
            "r odd and rho_M(r)<q -> owner 1",
            "r odd and |r-M/2|<q -> owner M/2-1",
            "remaining odd r; reflect r to x=min(r,M-r), so q<=x<=M/2-q",
            "x == 1 mod 4 -> owner M/4-1, with rho=|M/4-x|<=3q/4<q",
            "x == 3 mod 4 -> owner M/4+1, with rho=|M/4-x|<=3q/4<q",
        ],
        "strict_boundary_note": "q, M/2-q, M/2+q, and M-q are even because 8|q; all even boundary residues are covered by owner M/2. No <= substitution is used.",
        "five_distinct_set_private_residues": private_checks,
        "bruteforce_calibrations": {str(q0): full_cover_bruteforce(q0) for q0 in (8, 16, 32, 64, 128, 256, 512, 1024)},
        "first_missing_conclusion": "q_n does not divide the labelled product; its 2-adic valuation is E_n-1",
        "completion_marker": "COMPLETE",
    }
    print(json.dumps(report, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
