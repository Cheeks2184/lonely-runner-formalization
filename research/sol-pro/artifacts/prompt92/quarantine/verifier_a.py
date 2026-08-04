#!/usr/bin/env python3
"""Prompt 92 verifier A: literal deletion gcds and literal residue loops."""
from __future__ import annotations

import hashlib
import itertools
import json
import math
import platform
import sys
from pathlib import Path
from typing import Any

CASES = ((3, 2), (3, 4), (3, 8), (3, 16), (4, 2), (4, 4), (4, 8))


def validate(n: Any, q: Any, M: Any, v: Any) -> tuple[int, ...]:
    if type(n) is not int or n < 3:
        raise ValueError("n must be an integer >= 3")
    if type(q) is not int or q <= 0:
        raise ValueError("q must be a positive integer")
    if type(M) is not int or M != (n + 1) * q:
        raise ValueError("M must equal (n+1)q")
    if not isinstance(v, (tuple, list)) or len(v) != n:
        raise ValueError("v must have length n")
    out = []
    for x in v:
        if type(x) is not int or not (0 <= x < M):
            raise ValueError("coordinates must be integer canonical representatives")
        out.append(x)
    return tuple(out)


def rho_literal(M: int, x: int) -> int:
    y = x % M
    return min(y, M - y)


def literal_deletion_gcds(M: int, v: tuple[int, ...]) -> tuple[int, ...]:
    ans = []
    for k in range(len(v)):
        g = M
        for i, x in enumerate(v):
            if i != k:
                g = math.gcd(g, x)
        ans.append(g)
    return tuple(ans)


def literal_product_divisible(q: int, v: tuple[int, ...]) -> bool:
    return math.prod(v) % q == 0


def literal_full_cover(M: int, q: int, v: tuple[int, ...]) -> bool:
    for r in range(M):
        owner_found = False
        for x in v:
            if rho_literal(M, r * x) < q:
                owner_found = True
                break
        if not owner_found:
            return False
    return True


def fixture_report() -> dict[str, Any]:
    # Boundary and strictness fixtures.
    eq = {
        "r1_strict_bad": rho_literal(8, 1) < 2,
        "r2_equality_safe": rho_literal(8, 2) == 2 and not (rho_literal(8, 2) < 2),
        "r6_reflected_equality_safe": rho_literal(8, 6) == 2 and not (rho_literal(8, 6) < 2),
    }
    zero_r = all(rho_literal(8, 0 * x) < 2 for x in (0, 1, 2, 7))

    v_rep = validate(3, 2, 8, (1, 1, 2))
    v_zero = validate(3, 2, 8, (0, 1, 1))
    v_bad_del = validate(3, 2, 8, (1, 2, 2))

    malformed = []
    malformed_inputs = (
        (3, 2, 8, (-1, 1, 2)),
        (3, 2, 8, (1.0, 1, 2)),
        (3, 2, 8, (1, 1, 8)),
        (3, 2, 8, (1, 2)),
        (3, 2, 9, (1, 1, 2)),
        (2, 2, 6, (1, 2)),
    )
    for args in malformed_inputs:
        try:
            validate(*args)
            malformed.append(False)
        except ValueError:
            malformed.append(True)

    prompt84 = validate(4, 8, 40, (1, 4, 19, 20))
    prompt84_individual = [x % 8 == 0 for x in prompt84]
    prompt84_aggregate = literal_product_divisible(8, prompt84)

    # Deliberately altered weak-bound test must differ at equality.
    weak_bad_r2 = rho_literal(8, 2) <= 2
    weak_bad_r6 = rho_literal(8, 6) <= 2

    return {
        "strict_equality": eq,
        "r0_included_and_bad_for_all_tested_owners": zero_r,
        "repeated_fixture": {
            "deletion_gcds": literal_deletion_gcds(8, v_rep),
            "product_divisible": literal_product_divisible(2, v_rep),
            "coincident_labelled_sets_retained": [
                [r for r in range(8) if rho_literal(8, r * v_rep[i]) < 2]
                for i in range(3)
            ],
        },
        "zero_fixture": {
            "deletion_gcds": literal_deletion_gcds(8, v_zero),
            "product_divisible": literal_product_divisible(2, v_zero),
        },
        "failed_deletion_fixture": {
            "deletion_gcds": literal_deletion_gcds(8, v_bad_del),
            "failed_labels": [i for i, g in enumerate(literal_deletion_gcds(8, v_bad_del)) if g != 1],
        },
        "malformed_rejected": all(malformed),
        "malformed_case_results": malformed,
        "weak_bound_deliberate_disagreement": weak_bad_r2 and weak_bad_r6,
        "prompt84_q8": {
            "deletion_gcds": literal_deletion_gcds(40, prompt84),
            "full_strict_cover": literal_full_cover(40, 8, prompt84),
            "individual_q_divisibility": prompt84_individual,
            "aggregate_q_divisibility": prompt84_aggregate,
            "strengthened_conclusion_fails": not any(prompt84_individual) and prompt84_aggregate,
        },
    }


def scan_case(n: int, q: int) -> dict[str, Any]:
    M = (n + 1) * q
    raw = deletion = product_nondiv = cover_failures = 0
    first_failure = None
    for v in itertools.product(range(M), repeat=n):
        raw += 1
        if literal_deletion_gcds(M, v) != (1,) * n:
            continue
        deletion += 1
        if literal_product_divisible(q, v):
            continue
        product_nondiv += 1
        if literal_full_cover(M, q, v):
            cover_failures += 1
            if first_failure is None:
                first_failure = list(v)
    return {
        "n": n,
        "q": q,
        "M": M,
        "raw_tuples": raw,
        "deletion_gcd_premise": deletion,
        "product_nondivisible_premise": product_nondiv,
        "full_cover_failures": cover_failures,
        "lexicographically_first_failure": first_failure,
    }


def main() -> None:
    source_hash = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    result = {
        "implementation": "A",
        "language": "Python",
        "python_version": platform.python_version(),
        "implementation_description": "literal deletion gcd for every label; natural product remainder; literal r/owner strict loops",
        "domain": "labelled tuples in range(M)^n, lexicographic itertools.product order",
        "case_order": [list(x) for x in CASES],
        "strict_test": "min((r*v)%M, M-((r*v)%M)) < q",
        "r_zero_included": True,
        "first_failure_rule": "first tuple in declared case order and lexicographic tuple order",
        "source_sha256": source_hash,
        "fixtures": fixture_report(),
        "cases": [scan_case(n, q) for n, q in CASES],
        "completion_marker": "COMPLETE",
    }
    print(json.dumps(result, sort_keys=True, indent=2))


if __name__ == "__main__":
    main()
