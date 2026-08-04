#!/usr/bin/env python3
"""Exact integer verifier for the Prompt 77 primitive counterexample (6,7,168).

No floating-point arithmetic is used. The verifier checks the strict bad sets,
weights, G-values, negative-Gram identities for pivots 1 and 2, and the exact
period/count conditions forcing all degree-six Fourier coefficients of pivot 3
to vanish.

Malformed-input behavior: accepts no arguments; any argument exits with code 2.
"""

from __future__ import annotations

import hashlib
import json
import math
import os
import platform
import sys
from collections import Counter
from typing import Dict, List, Sequence, Tuple

SCRIPT_VERSION = "1.0.0"
A = (6, 7, 168)
N = 4
D = 6


def rho(M: int, x: int) -> int:
    y = x % M
    return min(y, M - y)


def data(a: Sequence[int], j: int):
    p = a[j]
    M = (len(a) + 1) * p
    R = [r for r in range(M) if r % (len(a) + 1) != 0]
    B: Dict[int, List[int]] = {}
    for i, ai in enumerate(a):
        if i != j:
            B[i] = [r for r in R if rho(M, r * ai) < p]
    mu = {r: sum(r in B[i] for i in B) for r in R}
    w = [0] * M
    for r in R:
        w[r] = 1 - mu[r]
    Q = [r for r in R if mu[r] == 0]
    return M, R, B, mu, w, Q


def least_period(bits: Sequence[int]) -> int:
    M = len(bits)
    for p in range(1, M + 1):
        if M % p == 0 and all(bits[r] == bits[r % p] for r in range(M)):
            return p
    raise AssertionError("period must exist")


def main() -> int:
    if len(sys.argv) != 1:
        print("error: prompt77_counterexample_verify.py accepts no arguments", file=sys.stderr)
        return 2

    assert math.gcd(*A) == 1
    assert all(x > 0 for x in A) and len(set(A)) == len(A)

    rows = []
    all_data = []
    for j in range(3):
        M, R, B, mu, w, Q = data(A, j)
        all_data.append((M, R, B, mu, w, Q))
        rows.append(
            {
                "pivot_index_zero_based": j,
                "pivot_speed": A[j],
                "M": M,
                "R_size": len(R),
                "B_sizes": {str(i): len(B[i]) for i in sorted(B)},
                "G": len(Q),
                "mu_distribution": {str(k): v for k, v in sorted(Counter(mu.values()).items())},
            }
        )

    # Pivot 1: a_3 = 168 is 0 modulo 24, so B_3 = R and w = -1_{B_2}.
    M1, R1, B1, _, w1, _ = all_data[0]
    assert M1 == 24 and B1[2] == R1
    assert all(w1[r] == -(1 if r in B1[1] else 0) for r in range(M1))
    S24 = B1[1]
    assert S24 == [3, 7, 10, 11, 13, 14, 17, 21]

    # Pivot 2: a_3 = 168 is 0 modulo 28, so B_3 = R and w = -1_{B_1}.
    M2, R2, B2, _, w2, _ = all_data[1]
    assert M2 == 28 and B2[2] == R2
    assert all(w2[r] == -(1 if r in B2[0] else 0) for r in range(M2))
    S28 = B2[0]
    assert S28 == [1, 5, 9, 10, 13, 14, 15, 18, 19, 23, 27]

    # Pivot 3: exact periodic fibers.
    M3, R3, B3, mu3, w3, Q3 = all_data[2]
    assert M3 == 672
    ind_R = [1 if r in R3 else 0 for r in range(M3)]
    ind_B6 = [1 if r in B3[0] else 0 for r in range(M3)]
    ind_B7 = [1 if r in B3[1] else 0 for r in range(M3)]
    assert least_period(ind_R) == 4
    assert least_period(ind_B6) == 112
    assert least_period(ind_B7) == 96
    assert len(R3) == 504 and len(B3[0]) == 252 and len(B3[1]) == 252
    assert len(Q3) == 126
    assert Counter(mu3.values()) == Counter({0: 126, 1: 252, 2: 126})

    # For differences 1..5, period 4 repeats 168 times, period 112 repeats 6
    # times, and period 96 repeats 7 times. None of 1..5 is divisible by any
    # repeat count, so each geometric fiber sum is exactly zero. At d=0 the
    # counts cancel: 504 - 252 - 252 = 0.
    repeat_counts = {"R": M3 // 4, "B6": M3 // 112, "B7": M3 // 96}
    assert repeat_counts == {"R": 168, "B6": 6, "B7": 7}
    for d in range(1, D):
        assert all(d % h != 0 for h in repeat_counts.values())
    assert len(R3) - len(B3[0]) - len(B3[1]) == 0

    script_path = os.path.abspath(__file__)
    with open(script_path, "rb") as fh:
        source_sha = hashlib.sha256(fh.read()).hexdigest()

    result = {
        "schema": "prompt77-counterexample-certificate-v1",
        "status": "verified-exact-integer-certificate",
        "first_failure": {
            "tuple": list(A),
            "criterion": "every literal degree-six block is negative semidefinite",
            "ordering_scope": "first member of the proved family (u,v,4uv) under u then v, with coprime 6 <= u < v",
        },
        "script_version": SCRIPT_VERSION,
        "language": platform.python_version(),
        "implementation": platform.python_implementation(),
        "exact_domain": {
            "tuple": list(A),
            "n": 3,
            "N": 4,
            "modes": list(range(D)),
            "ordering": "pivots ascending; residues ascending",
        },
        "algebraic_number_representation": "exact cyclotomic Gram sums V(S)^*V(S); no floating-point algebraic approximation",
        "interval_policy": "none; certificate uses exact integer membership, periodicity, counts, and geometric-sum divisibility",
        "tuple": list(A),
        "primitive_gcd": math.gcd(*A),
        "N": N,
        "literal_modes": list(range(D)),
        "rows": rows,
        "K1_exact": {
            "form": "-(1/24) V(S24)^* V(S24)",
            "S24": S24,
            "zeta": "exp(2*pi*i/24)",
        },
        "K2_exact": {
            "form": "-(1/28) V(S28)^* V(S28)",
            "S28": S28,
            "zeta": "exp(2*pi*i/28)",
        },
        "K3_exact": {
            "form": "zero 6x6 matrix",
            "periods": {"R": 4, "B6": 112, "B7": 96},
            "repeat_counts": repeat_counts,
            "zero_frequency_count_identity": "504-252-252=0",
            "nonzero_difference_range": [-5, 5],
        },
        "block_disposition": ["negative-semidefinite", "negative-semidefinite", "zero"],
        "G": [len(all_data[j][5]) for j in range(3)],
        "source_file": os.path.basename(script_path),
        "source_sha256": source_sha,
        "source_output_binding": "output embeds the SHA-256 of the exact verifier source",
        "malformed_input_behavior": "any command-line argument -> stderr diagnostic and exit status 2",
    }

    out_path = os.path.join(os.path.dirname(script_path), "prompt77_counterexample_certificate.json")
    with open(out_path, "w", encoding="utf-8", newline="\n") as fh:
        json.dump(result, fh, indent=2, sort_keys=True)
        fh.write("\n")
    print(json.dumps(result, indent=2, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
