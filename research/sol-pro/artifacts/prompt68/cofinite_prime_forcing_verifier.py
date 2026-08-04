#!/usr/bin/env python3
"""
Bounded falsification verifier for Prompt 68.

Primary exhaustive sweep:
  n = 3, N = 4
  primes = [5, 7, 11, 13, 17, 19, 23, 29]
  domain = every nondecreasing triple of residues v_i in [0, Np-1]
           with p not dividing v_i. This is exhaustive modulo coordinate
           permutation and includes repetitions.
  admissibility = gcd(Np, surviving pair) = 1 for every deletion.
  badness = rho_Np(r*v_i) < p. Equality rho = p is safe.
  order = increasing prime, then Python itertools.combinations_with_replacement
          lexicographic order. Every prime domain is completed.

Additional mandated certificate check:
  n = 4, p = 7, v = (1,3,4,5), without any surrounding search.
"""

from __future__ import annotations

import hashlib
import itertools
import json
import math
from pathlib import Path
from typing import Iterable

PRIMES = [5, 7, 11, 13, 17, 19, 23, 29]
SWEEP_N = 3
FIXTURES = [
    {"n": 3, "p": 5, "v": [1, 3, 4]},
    {"n": 4, "p": 7, "v": [1, 3, 4, 5]},
]


def rho(M: int, x: int) -> int:
    z = x % M
    return min(z, M - z)


def bad_mask(M: int, p: int, v: int) -> int:
    mask = 0
    for r in range(M):
        if rho(M, r * v) < p:
            mask |= 1 << r
    return mask


def bad_list(M: int, p: int, v: int) -> list[int]:
    return [r for r in range(M) if rho(M, r * v) < p]


def deletion_gcds(n: int, p: int, values: Iterable[int]) -> list[int]:
    values = list(values)
    M = (n + 1) * p
    out: list[int] = []
    for deleted in range(n):
        g = M
        for i, value in enumerate(values):
            if i != deleted:
                g = math.gcd(g, value)
        out.append(g)
    return out


def admissible(n: int, p: int, values: Iterable[int]) -> bool:
    values = list(values)
    return (
        len(values) == n
        and all(value % p != 0 for value in values)
        and all(g == 1 for g in deletion_gcds(n, p, values))
    )


def fixture_record(n: int, p: int, values: list[int]) -> dict:
    N = n + 1
    M = N * p
    sets = [bad_list(M, p, value) for value in values]
    union = set().union(*(set(s) for s in sets))
    deleted_missing = []
    for deleted in range(n):
        reduced_union = set().union(
            *(set(sets[i]) for i in range(n) if i != deleted)
        )
        deleted_missing.append(sorted(set(range(M)) - reduced_union))

    equality_safe = []
    for value in values:
        points = [r for r in range(M) if rho(M, r * value) == p]
        equality_safe.append(
            {
                "v": value,
                "r_with_rho_equal_p": points,
                "all_excluded_from_strict_bad_set": all(
                    r not in set(bad_list(M, p, value)) for r in points
                ),
            }
        )

    endpoint_residue_checks = []
    for value in values:
        endpoint_residue_checks.append(
            {
                "v": value,
                "solutions_product_residue_p": [
                    r for r in range(M) if (r * value) % M == p
                ],
                "solutions_product_residue_M_minus_p": [
                    r for r in range(M) if (r * value) % M == M - p
                ],
            }
        )

    return {
        "n": n,
        "N": N,
        "p": p,
        "M": M,
        "v": values,
        "p_nondivisibility": [value % p != 0 for value in values],
        "deletion_gcds": deletion_gcds(n, p, values),
        "admissible": admissible(n, p, values),
        "bad_sets": [
            {"v": value, "cardinality": len(sets[i]), "elements": sets[i]}
            for i, value in enumerate(values)
        ],
        "r_zero_in_every_bad_set": all(0 in s for s in sets),
        "union_cardinality": len(union),
        "missing_from_union": sorted(set(range(M)) - union),
        "full_cover": len(union) == M,
        "missing_after_deleting_each_coordinate": deleted_missing,
        "inclusion_minimal_selected_cover": all(
            len(missing) > 0 for missing in deleted_missing
        ),
        "equality_safe_checks": equality_safe,
        "cyclic_endpoint_residue_checks": endpoint_residue_checks,
    }


def exhaustive_n3_sweep() -> list[dict]:
    n = SWEEP_N
    N = n + 1
    results = []
    for p in PRIMES:
        M = N * p
        values = [value for value in range(M) if value % p != 0]
        masks = {value: bad_mask(M, p, value) for value in values}
        pair_ok = {
            (a, b): math.gcd(M, a, b) == 1
            for a in values
            for b in values
            if a <= b
        }

        def ok_pair(a: int, b: int) -> bool:
            return pair_ok[(a, b)] if a <= b else pair_ok[(b, a)]

        full = (1 << M) - 1
        total_canonical = 0
        admissible_canonical = 0
        failures = []

        for triple in itertools.combinations_with_replacement(values, 3):
            total_canonical += 1
            a, b, c = triple
            if not (ok_pair(a, b) and ok_pair(a, c) and ok_pair(b, c)):
                continue
            admissible_canonical += 1
            if (masks[a] | masks[b] | masks[c]) == full:
                failures.append(list(triple))

        results.append(
            {
                "n": n,
                "N": N,
                "p": p,
                "M": M,
                "canonical_domain": (
                    "all nondecreasing triples; exhaustive modulo coordinate "
                    "permutation; repetitions included"
                ),
                "total_canonical_tuples": total_canonical,
                "admissible_canonical_tuples": admissible_canonical,
                "failure_count": len(failures),
                "failure_tuples": failures,
                "domain_completed": True,
            }
        )
    return results


def main() -> None:
    script_path = Path(__file__).resolve()
    output_path = script_path.with_name(
        "cofinite_prime_forcing_verifier_output.json"
    )
    data = {
        "status": "computed finite evidence",
        "declaration": {
            "fixed_sweep_dimension_n": SWEEP_N,
            "prime_list": PRIMES,
            "prime_count": len(PRIMES),
            "tuple_order": (
                "increasing prime, then lexicographic "
                "combinations_with_replacement"
            ),
            "domain": (
                "all nondecreasing repeated triples of allowed residues; "
                "exhaustive modulo coordinate permutation"
            ),
            "strict_badness": "rho_M(r*v_i) < p",
            "equality_behavior": "rho_M(r*v_i) = p is safe",
            "deterministic_stop_rule": (
                "complete every declared prime domain; no adaptive expansion"
            ),
            "additional_searches": "none",
        },
        "sweep": exhaustive_n3_sweep(),
        "fixtures": [
            fixture_record(item["n"], item["p"], item["v"])
            for item in FIXTURES
        ],
    }
    data["source_sha256"] = hashlib.sha256(script_path.read_bytes()).hexdigest()
    output_path.write_text(json.dumps(data, indent=2, sort_keys=True) + "\n")
    print(json.dumps({
        "output": str(output_path),
        "source_sha256": data["source_sha256"],
        "output_sha256": hashlib.sha256(output_path.read_bytes()).hexdigest(),
        "sweep_summary": [
            {
                "p": row["p"],
                "admissible": row["admissible_canonical_tuples"],
                "failures": row["failure_count"],
            }
            for row in data["sweep"]
        ],
    }, indent=2))


if __name__ == "__main__":
    main()
