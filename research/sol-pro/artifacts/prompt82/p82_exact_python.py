#!/usr/bin/env python3
"""Exact verifier for Prompt 82: global saturated multiplicity score.

Implementation A deliberately uses literal representative enumeration:
  r = 0,...,N*p-1, excluding r divisible by N;
  rho_M(x) = min(x mod M, M-(x mod M));
  fractions.Fraction for every score.

Invocation: python3 p82_exact_python.py
Malformed input: any command-line argument is rejected with exit status 2.
Output: p82_exact_python.json beside this source.
"""
from __future__ import annotations

import hashlib
import itertools
import json
import math
import platform
import sys
from collections import Counter
from fractions import Fraction
from pathlib import Path
from typing import Any, Iterable, Sequence

SCHEMA = "PIPE-P82-EXACT-PYTHON-v1"
MUTATION_BASE = (1, 4, 5, 6, 7, 11)
MUTATION_MAX_INSERTION = 120
COUNTEREXAMPLE = (1, 4, 5, 6, 7, 11, 32)

PROMPT_CALIBRATIONS = (
    (1, 2, 8),
    (1, 3, 4),
    (1, 2, 3, 5),
    (4, 5, 9),
    (1, 4, 5, 6, 7, 11),
    (1, 2, 3, 4, 5, 7),
    (1, 6, 11, 12, 13),
    (6, 7, 168),
    (6, 7, 12, 24, 144),
    (8, 15, 35, 40, 48, 56, 75, 132, 147),
    (15, 21, 40, 48, 56, 105, 126, 280, 1200),
)

# Hash-locked Prompt 78 verifier fixture declaration plus its terminal
# unrestricted counterexample.
P78_FIXTURES = (
    (1, 2, 8),
    (1, 3, 4),
    (1, 3, 4, 5),
    (1, 2, 3, 5),
    (4, 5, 8),
    (4, 5, 32),
    (1, 3, 4, 9, 12),
    (1, 6, 11, 12, 13),
    (1, 2, 3, 4, 5, 7),
    (1, 3, 13),
    (6, 7, 12, 24, 144),
)

P80_CONTROLS = (
    (2, 5, 6),
    (2, 4, 6),
    (1, 2, 3, 10),
    (1, 3, 4, 7),
    (1, 2, 3, 60),
    (1, 2, 6, 8, 10),
)

TOP_TWO_HARD = ((7, 63, 70, 77, 98, 187),)

EXPECTED_CALIBRATION_SCORES = {
    (1, 2, 8): Fraction(93, 17),
    (1, 3, 4): Fraction(66, 17),
    (1, 2, 3, 5): Fraction(1532, 425),
    (4, 5, 9): Fraction(128, 17),
    (1, 4, 5, 6, 7, 11): Fraction(165878, 191675),
    (1, 2, 3, 4, 5, 7): Fraction(452714, 191675),
    (1, 6, 11, 12, 13): Fraction(101887, 4675),
    (6, 7, 168): Fraction(1997, 17),
    (6, 7, 12, 24, 144): Fraction(617587, 4675),
    (8, 15, 35, 40, 48, 56, 75, 132, 147): Fraction(900274298524, 2319842525),
    (15, 21, 40, 48, 56, 105, 126, 280, 1200): Fraction(32973892321, 19494475),
}

EXPECTED_FROZEN_COUNTS = {2: 63, 3: 325, 4: 965, 5: 1981, 6: 2996}
EXPECTED_FROZEN_MINIMA = {
    2: ((1, 3), Fraction(2, 1)),
    3: ((1, 4, 5), Fraction(64, 17)),
    4: ((1, 2, 3, 5), Fraction(1532, 425)),
    5: ((1, 5, 6, 7, 8), Fraction(26683, 4675)),
    6: ((1, 4, 5, 6, 7, 11), Fraction(165878, 191675)),
}


def frac_json(value: Fraction) -> dict[str, Any]:
    return {
        "numerator": value.numerator,
        "denominator": value.denominator,
        "text": str(value),
        "sign": (value > 0) - (value < 0),
    }


def gcd_all(values: Iterable[int]) -> int:
    result = 0
    for value in values:
        result = math.gcd(result, value)
    return result


def validate_tuple(values: Sequence[int], *, require_increasing: bool = False) -> tuple[int, ...]:
    values = tuple(values)
    if not values:
        raise ValueError("speed tuple must be nonempty")
    if any(not isinstance(value, int) or isinstance(value, bool) for value in values):
        raise TypeError("speeds must be ordinary integers")
    if any(value <= 0 for value in values):
        raise ValueError("speeds must be positive")
    if len(set(values)) != len(values):
        raise ValueError("speeds must be injective")
    if require_increasing and tuple(sorted(values)) != values:
        raise ValueError("tuple must be strictly increasing")
    return values


def rho(modulus: int, value: int) -> int:
    if modulus <= 0:
        raise ValueError("modulus must be positive")
    residue = value % modulus
    return min(residue, modulus - residue)


def phi8(multiplicity: int) -> Fraction:
    if multiplicity < 0:
        raise ValueError("multiplicity must be natural")
    return Fraction(1 - multiplicity, 8 * multiplicity + 1)


def pivot_record(values: Sequence[int], pivot: int, *, include_owner_sets: bool = False) -> dict[str, Any]:
    values = validate_tuple(values)
    n = len(values)
    if not 0 <= pivot < n:
        raise IndexError("pivot out of range")
    N = n + 1
    p = values[pivot]
    M = N * p
    candidates = [r for r in range(M) if r % N != 0]
    assert len(candidates) == n * p
    hist = [0] * n
    multiplicities: dict[int, int] = {}
    owner_sets: dict[int, list[int]] = {}
    boundary_p_minus_1 = 0
    boundary_p = 0
    nonunit_owner_count = 0

    for owner, speed in enumerate(values):
        if owner == pivot:
            continue
        if math.gcd(speed, M) > 1:
            nonunit_owner_count += 1
        bad: list[int] = []
        for r in candidates:
            d = rho(M, r * speed)
            boundary_p_minus_1 += int(d == p - 1)
            boundary_p += int(d == p)
            if d < p:
                bad.append(r)
        owner_sets[owner] = bad

    owner_sets_as_sets = {owner: set(points) for owner, points in owner_sets.items()}
    for r in candidates:
        mu = sum(r in points for points in owner_sets_as_sets.values())
        multiplicities[r] = mu
        hist[mu] += 1

    local_score = sum((count * phi8(m) for m, count in enumerate(hist)), Fraction(0))
    good = [r for r, m in multiplicities.items() if m == 0]
    reflected_ok = all(multiplicities[r] == multiplicities[(-r) % M] for r in candidates)
    assert reflected_ok

    antipode = M // 2 if M % 2 == 0 else None
    antipode_record: dict[str, Any] | None = None
    if antipode is not None:
        antipode_record = {
            "r": antipode,
            "fixed_by_reflection": (-antipode) % M == antipode,
            "candidate": antipode % N != 0,
            "multiplicity": multiplicities.get(antipode),
        }

    coincident: list[dict[str, Any]] = []
    owners = sorted(owner_sets)
    for x, y in itertools.combinations(owners, 2):
        if owner_sets[x] == owner_sets[y]:
            coincident.append({
                "owner_indices": [x, y],
                "owner_speeds": [values[x], values[y]],
                "bad_count_each": len(owner_sets[x]),
            })

    output: dict[str, Any] = {
        "pivot_index": pivot,
        "pivot_speed": p,
        "M": M,
        "R_size": len(candidates),
        "expected_R_size": n * p,
        "excluded_N_multiples": p,
        "histogram": hist,
        "local_score": frac_json(local_score),
        "good_residues": good,
        "reflection_invariance": reflected_ok,
        "antipode": antipode_record,
        "coincident_owner_sets": coincident,
        "nonunit_owner_count": nonunit_owner_count,
        "rho_equals_p_minus_1_owner_candidate_hits": boundary_p_minus_1,
        "rho_equals_p_owner_candidate_hits": boundary_p,
    }
    if include_owner_sets:
        output["owner_bad_sets"] = {
            str(owner): {
                "owner_speed": values[owner],
                "residues": points,
            }
            for owner, points in owner_sets.items()
        }
        output["multiplicity_by_candidate"] = {str(r): multiplicities[r] for r in candidates}
    return output


def tuple_record(values: Sequence[int], *, full: bool = False) -> dict[str, Any]:
    values = validate_tuple(values)
    pivots = [pivot_record(values, j, include_owner_sets=full) for j in range(len(values))]
    global_score = sum((Fraction(row["local_score"]["numerator"], row["local_score"]["denominator"]) for row in pivots), Fraction(0))
    return {
        "speeds": list(values),
        "n": len(values),
        "N": len(values) + 1,
        "gcd": gcd_all(values),
        "primitive": gcd_all(values) == 1,
        "total_candidate_count": sum(row["R_size"] for row in pivots),
        "expected_total_candidate_count": len(values) * sum(values),
        "global_score": frac_json(global_score),
        "total_good_candidates": sum(row["histogram"][0] for row in pivots),
        "pivots": pivots,
    }


def score(values: Sequence[int]) -> Fraction:
    record = tuple_record(values, full=False)
    return Fraction(record["global_score"]["numerator"], record["global_score"]["denominator"])


def scaling_fiber_audit(values: Sequence[int], c: int) -> dict[str, Any]:
    values = validate_tuple(values)
    if c < 1:
        raise ValueError("scale must be positive")
    scaled = tuple(c * value for value in values)
    n = len(values)
    N = n + 1
    base_record = tuple_record(values)
    scaled_record = tuple_record(scaled)
    for j, p in enumerate(values):
        M = N * p
        scaled_M = c * M
        fiber_counts = Counter(r % M for r in range(scaled_M) if r % N != 0)
        assert set(fiber_counts) == {r for r in range(M) if r % N != 0}
        assert set(fiber_counts.values()) == {c}
        base_pivot = base_record["pivots"][j]
        scaled_pivot = scaled_record["pivots"][j]
        assert scaled_pivot["histogram"] == [c * x for x in base_pivot["histogram"]]
        # Owner-labelled predicate equality on every scaled candidate.
        for rr in range(scaled_M):
            if rr % N == 0:
                continue
            r = rr % M
            for i, ai in enumerate(values):
                if i == j:
                    continue
                left = rho(scaled_M, rr * (c * ai)) < c * p
                right = rho(M, r * ai) < p
                assert left == right
                assert rho(scaled_M, rr * (c * ai)) == c * rho(M, r * ai)
    assert score(scaled) == c * score(values)
    return {
        "base": list(values),
        "factor": c,
        "scaled": list(scaled),
        "base_score": frac_json(score(values)),
        "scaled_score": frac_json(score(scaled)),
        "exact_score_scaling": True,
        "every_candidate_fiber_size": c,
        "owner_labelled_badness_preserved": True,
        "strict_and_equality_boundary_preserved": True,
    }


def frozen_scan() -> dict[str, Any]:
    counts: dict[int, int] = {}
    minima: dict[int, dict[str, Any]] = {}
    total = 0
    for n in range(2, 7):
        count = 0
        best_tuple: tuple[int, ...] | None = None
        best_score: Fraction | None = None
        for values in itertools.combinations(range(1, 15), n):
            if gcd_all(values) != 1:
                continue
            count += 1
            total += 1
            value = score(values)
            if best_score is None or value < best_score:
                best_tuple = values
                best_score = value
        assert count == EXPECTED_FROZEN_COUNTS[n]
        assert (best_tuple, best_score) == EXPECTED_FROZEN_MINIMA[n]
        counts[n] = count
        minima[n] = {"tuple": list(best_tuple or ()), "score": frac_json(best_score or Fraction(0))}
    return {
        "domain": "primitive strictly increasing tuples; 2 <= n <= 6; 1 <= a_1 < ... < a_n <= 14",
        "order": "n ascending, then lexicographic",
        "counts": {str(k): v for k, v in counts.items()},
        "total": total,
        "minima": {str(k): v for k, v in minima.items()},
        "nonpositive_found": False,
        "status": "computed finite evidence",
    }


def mutation_scan() -> dict[str, Any]:
    rows: list[dict[str, Any]] = []
    first_failure: dict[str, Any] | None = None
    tested = 0
    for x in range(1, MUTATION_MAX_INSERTION + 1):
        if x in MUTATION_BASE:
            continue
        values = tuple(sorted(MUTATION_BASE + (x,)))
        if gcd_all(values) != 1:
            continue
        tested += 1
        value = score(values)
        rows.append({"ordinal": tested, "inserted_speed": x, "tuple": list(values), "score": frac_json(value)})
        if value <= 0:
            first_failure = tuple_record(values, full=True)
            first_failure["mutation_ordinal"] = tested
            first_failure["inserted_speed"] = x
            break
    assert first_failure is not None
    assert tuple(first_failure["speeds"]) == COUNTEREXAMPLE
    assert Fraction(first_failure["global_score"]["numerator"], first_failure["global_score"]["denominator"]) == Fraction(-5245398, 1878415)
    assert tested == 26
    return {
        "definition": (
            "starting from (1,4,5,6,7,11), insert x for x=1..120 in ascending order; "
            "skip collisions and nonprimitive tuples; sort; stop at first S_8<=0"
        ),
        "first_failure_convention": "the first emitted primitive tuple with exact rational score <= 0",
        "tested_through_failure": tested,
        "prefix": rows,
        "first_failure": first_failure,
        "status": "exact counterexample",
    }


def permutation_audit(values: Sequence[int]) -> dict[str, Any]:
    values = validate_tuple(values)
    expected = score(values)
    count = 0
    for permuted in itertools.permutations(values):
        assert score(permuted) == expected
        count += 1
    return {
        "tuple": list(values),
        "permutations_checked": count,
        "expected_factorial": math.factorial(len(values)),
        "score": frac_json(expected),
        "all_equal": True,
    }


def malformed_input_audit() -> dict[str, Any]:
    cases = [(), (0, 1), (-1, 2), (1, 1), (1.0, 2)]
    rejected = 0
    for case in cases:
        try:
            validate_tuple(case)  # type: ignore[arg-type]
        except (ValueError, TypeError):
            rejected += 1
        else:
            raise AssertionError(f"malformed case accepted: {case!r}")
    try:
        validate_tuple((2, 1), require_increasing=True)
    except ValueError:
        rejected += 1
    else:
        raise AssertionError("decreasing tuple accepted in increasing mode")
    return {
        "cases_rejected": rejected,
        "empty_zero_negative_duplicate_noninteger_and_decreasing": True,
        "command_line_policy": "any argument -> stderr diagnostic and exit status 2",
    }


def fixture_suite() -> dict[str, Any]:
    ordered: list[tuple[int, ...]] = []
    seen: set[tuple[int, ...]] = set()
    for group in (PROMPT_CALIBRATIONS, P78_FIXTURES, P80_CONTROLS, TOP_TWO_HARD):
        for values in group:
            if values not in seen:
                seen.add(values)
                ordered.append(values)
    records = []
    for values in ordered:
        record = tuple_record(values)
        if values in EXPECTED_CALIBRATION_SCORES:
            assert score(values) == EXPECTED_CALIBRATION_SCORES[values]
            record["calibration_match"] = True
        records.append(record)
    scaling = []
    for values in ordered:
        for c in (2, 3):
            scaling.append(scaling_fiber_audit(values, c))
    return {
        "distinct_tuple_count": len(ordered),
        "records": records,
        "common_scaling_checks": scaling,
        "all_calibration_values_match": True,
    }


def algebraic_identities() -> dict[str, Any]:
    checks = []
    for m in range(0, 20):
        lhs = phi8(m)
        rhs = Fraction(9, 8 * (8 * m + 1)) - Fraction(1, 8)
        assert lhs == rhs
        checks.append({"m": m, "phi8": frac_json(lhs)})
    return {
        "phi_decomposition": "phi_8(m) = 9/(8*(8*m+1)) - 1/8",
        "score_equivalence": "S_8>0 iff sum_{j,r} 1/(8*mu_j(r)+1) > (total candidate count)/9",
        "generating_function_identity": "S_8 = integral_0^1(P(x)-(x/8)P'(x))dx = (9/8)integral_0^1 P(x)dx - P(1)/8",
        "checked_multiplicities": checks,
    }


def main() -> int:
    if len(sys.argv) != 1:
        print("error: p82_exact_python.py accepts no command-line arguments", file=sys.stderr)
        return 2

    source_path = Path(__file__).resolve()
    source_sha = hashlib.sha256(source_path.read_bytes()).hexdigest()

    frozen = frozen_scan()
    fixtures = fixture_suite()
    mutation = mutation_scan()
    ce = mutation["first_failure"]

    # Exact anti-tautology certificate: pivot speed 7, r=17 is good while the
    # global score is negative.
    ce_values = tuple(ce["speeds"])
    pivot = ce_values.index(7)
    p = ce_values[pivot]
    M = (len(ce_values) + 1) * p
    r = 17
    distances = [rho(M, r * speed) for speed in ce_values]
    assert r % (len(ce_values) + 1) != 0
    assert all(distance >= p for i, distance in enumerate(distances) if i != pivot)
    assert distances[pivot] >= p

    report: dict[str, Any] = {
        "schema": SCHEMA,
        "runtime": {
            "language": "Python",
            "implementation": platform.python_implementation(),
            "version": platform.python_version(),
            "platform": platform.platform(),
            "arithmetic": "exact arbitrary-precision integers and fractions.Fraction; no floating point",
            "overflow_policy": "none: Python integers are arbitrary precision",
        },
        "invocation": "python3 /mnt/data/p82_exact_python.py",
        "source_file": source_path.name,
        "source_sha256": source_sha,
        "source_output_binding": "output embeds SHA-256 of the exact source bytes",
        "domain_order_and_first_failure": {
            "frozen": frozen["domain"],
            "frozen_order": frozen["order"],
            "mutation": mutation["definition"],
            "first_failure": mutation["first_failure_convention"],
        },
        "rational_representation": "reduced numerator/positive denominator via fractions.Fraction",
        "malformed_input": malformed_input_audit(),
        "candidate_cardinality_proof_check": "exactly p multiples 0,N,...,(p-1)N are removed from Np representatives, leaving np",
        "algebraic_identities": algebraic_identities(),
        "frozen_scan": frozen,
        "fixture_suite": fixtures,
        "structured_mutation_scan": mutation,
        "permutation_audit_counterexample": permutation_audit(COUNTEREXAMPLE),
        "anti_tautology_counterexample": {
            "tuple": list(ce_values),
            "global_score": ce["global_score"],
            "pivot_index": pivot,
            "pivot_speed": p,
            "M": M,
            "r": r,
            "r_in_R": r % (len(ce_values) + 1) != 0,
            "distances_by_speed": [
                {"speed": speed, "rho": distance, "safe_at_closed_boundary": distance >= p}
                for speed, distance in zip(ce_values, distances, strict=True)
            ],
            "certificate_exists_but_score_nonpositive": True,
        },
        "final_disposition": "STOP",
        "sole_lemma_status": "rejected",
    }

    output_path = source_path.with_suffix(".json")
    canonical = (json.dumps(report, indent=2, sort_keys=True) + "\n").encode("utf-8")
    output_path.write_bytes(canonical)
    output_sha = hashlib.sha256(canonical).hexdigest()
    print(json.dumps({
        "schema": SCHEMA,
        "source_sha256": source_sha,
        "output_sha256": output_sha,
        "frozen_total": frozen["total"],
        "mutation_tested": mutation["tested_through_failure"],
        "first_failure": ce["speeds"],
        "score": ce["global_score"]["text"],
        "status": "STOP",
    }, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
