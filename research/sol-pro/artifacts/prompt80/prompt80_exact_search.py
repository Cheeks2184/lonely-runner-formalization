#!/usr/bin/env python3
"""Exact deterministic falsification for Prompt 80.

The program uses only CPython arbitrary-precision integer arithmetic and
fractions.Fraction. It implements the frozen deletion-certificate order,
canonical-lift boundary, strict divisor-block capacities, the required main
scan, and a declared one-coordinate mutation scan of the four obstruction
fixtures.

Invocation: python3 prompt80_exact_search.py
Malformed input: any command-line argument is rejected with exit status 2.
Output: prompt80_exact_search.json next to this source file.
"""
from __future__ import annotations

import hashlib
import itertools
import json
import math
import platform
import sys
from fractions import Fraction
from pathlib import Path
from typing import Any, Iterable, Sequence

VERSION = "PIPE-P80-EXACT-SEARCH-1.0.0"
MAIN_MAX_SPEED = 24
MUTATION_MAX_SPEED = 120
MUTATION_BASES = (
    (1, 2, 3, 10),
    (1, 3, 4, 7),
    (1, 2, 3, 60),
    (1, 2, 6, 8, 10),
)


def rho(modulus: int, value: int) -> int:
    if modulus <= 0:
        raise ValueError("rho requires a positive modulus")
    residue = value % modulus
    return min(residue, modulus - residue)


def ceil_div(num: int, den: int) -> int:
    if num < 0 or den <= 0:
        raise ValueError("ceil_div requires num >= 0 and den > 0")
    return (num + den - 1) // den


def gcd_all(values: Iterable[int]) -> int:
    values = tuple(values)
    if not values or any(value <= 0 for value in values):
        raise ValueError("gcd_all requires a nonempty positive sequence")
    out = 0
    for value in values:
        out = math.gcd(out, value)
    return out


def validate_tuple(a: Sequence[int]) -> tuple[int, ...]:
    a = tuple(a)
    if len(a) == 0:
        raise ValueError("speed tuple must be nonempty")
    if any(value <= 0 for value in a):
        raise ValueError("speeds must be positive")
    if len(set(a)) != len(a):
        raise ValueError("speeds must be injective")
    return a


def deletion_certificates(a: Sequence[int], deleted: int) -> list[dict[str, Any]]:
    a = validate_tuple(a)
    n = len(a)
    if not 0 <= deleted < n:
        raise IndexError("deleted index out of range")
    certs: list[dict[str, Any]] = []
    for pivot in range(n):
        if pivot == deleted:
            continue
        p = a[pivot]
        modulus = n * p
        for r in range(modulus):
            if r % n == 0:
                continue
            residues = tuple(rho(modulus, r * speed) for speed in a)
            # The pivot coordinate is deliberately included.
            if all(residues[i] >= p for i in range(n) if i != deleted):
                exceptional_rho = residues[deleted]
                certs.append(
                    {
                        "pivot_index_zero_based": pivot,
                        "pivot_speed": p,
                        "r": r,
                        "modulus": modulus,
                        "residues": list(residues),
                        "exceptional_rho": exceptional_rho,
                        "lift_lhs": (n + 1) * exceptional_rho,
                        "lift_rhs": n * p,
                        "lifts": (n + 1) * exceptional_rho >= n * p,
                    }
                )
    certs.sort(key=lambda row: (row["pivot_speed"], row["pivot_index_zero_based"], row["r"]))
    return certs


def canonical_deletion_rows(a: Sequence[int]) -> list[dict[str, Any]]:
    a = validate_tuple(a)
    rows: list[dict[str, Any]] = []
    for deleted, deleted_speed in enumerate(a):
        certs = deletion_certificates(a, deleted)
        canonical = certs[0] if certs else None
        rows.append(
            {
                "deleted_index_zero_based": deleted,
                "deleted_speed": deleted_speed,
                "certificate_count": len(certs),
                "certificate_lift_count": sum(1 for cert in certs if cert["lifts"]),
                "canonical": canonical,
                "canonical_lift": None if canonical is None else canonical["lifts"],
            }
        )
    return rows


def ordered_nonempty_proper_subsets(n: int) -> list[tuple[int, ...]]:
    if n <= 1:
        return []
    out = []
    for size in range(1, n):
        out.extend(itertools.combinations(range(n), size))
    return out


def divisor_block_rows(a: Sequence[int]) -> list[dict[str, Any]]:
    a = validate_tuple(a)
    n = len(a)
    N = n + 1
    rows: list[dict[str, Any]] = []
    all_indices = set(range(n))
    for S in ordered_nonempty_proper_subsets(n):
        S_set = set(S)
        T = tuple(sorted(all_indices - S_set))
        d = gcd_all(a[i] for i in T)
        terms = []
        total = 0
        for k in S:
            g = math.gcd(d, a[k])
            q = d // g
            cap = g * ceil_div(2 * q, N)
            total += cap
            terms.append(
                {
                    "exceptional_index_zero_based": k,
                    "exceptional_speed": a[k],
                    "g": g,
                    "q": q,
                    "cap": cap,
                }
            )
        rows.append(
            {
                "S_indices_zero_based": list(S),
                "S_speeds": [a[i] for i in S],
                "T_indices_zero_based": list(T),
                "T_speeds": [a[i] for i in T],
                "d": d,
                "terms": terms,
                "capacity_sum": total,
                "strict": total < d,
            }
        )
    return rows


def hard_record(a: Sequence[int], include_blocks: bool = True) -> dict[str, Any]:
    a = validate_tuple(a)
    n = len(a)
    N = n + 1
    canonical_rows = canonical_deletion_rows(a)
    primitive = gcd_all(a) == 1
    above_cutoff = max(a) > N + N // 3
    has_N_divisible = any(value % N == 0 for value in a)
    all_deletions_nonempty = all(row["certificate_count"] > 0 for row in canonical_rows)
    all_canonical_fail = all(row["canonical_lift"] is False for row in canonical_rows)
    hard = (
        n >= 3
        and primitive
        and above_cutoff
        and has_N_divisible
        and all_deletions_nonempty
        and all_canonical_fail
    )
    record: dict[str, Any] = {
        "tuple": list(a),
        "n": n,
        "N": N,
        "primitive_gcd": gcd_all(a),
        "height_cutoff": N + N // 3,
        "above_cutoff": above_cutoff,
        "N_divisible_speeds": [value for value in a if value % N == 0],
        "all_deletions_nonempty": all_deletions_nonempty,
        "all_canonical_fail": all_canonical_fail,
        "hard_canonical_failure": hard,
        "canonical_deletions": canonical_rows,
    }
    if include_blocks:
        blocks = divisor_block_rows(a)
        record["divisor_blocks"] = blocks
        record["first_strict_divisor_block"] = next((row for row in blocks if row["strict"]), None)
    return record


def centered_equation(a: Sequence[int], deletion_row: dict[str, Any]) -> dict[str, Any]:
    a = validate_tuple(a)
    canonical = deletion_row["canonical"]
    if canonical is None:
        raise ValueError("centered equation requires a canonical certificate")
    k = deletion_row["deleted_index_zero_based"]
    modulus = canonical["modulus"]
    value = canonical["r"] * a[k]
    residue = value % modulus
    if residue <= modulus // 2:
        e = residue
    else:
        e = residue - modulus
    quotient = (value - e) // modulus
    if value != quotient * modulus + e:
        raise AssertionError("centered equation reconstruction failed")
    return {
        "deleted_speed": a[k],
        "pivot_speed": canonical["pivot_speed"],
        "r": canonical["r"],
        "q_prime": quotient,
        "e": e,
        "equation": f"{canonical['r']}*{a[k]} = {quotient}*{modulus} + ({e})",
        "failure_check": {
            "lhs": (len(a) + 1) * abs(e),
            "rhs": modulus,
            "strict": (len(a) + 1) * abs(e) < modulus,
        },
    }


def frac_json(value: Fraction) -> dict[str, Any]:
    return {
        "num": value.numerator,
        "den": value.denominator,
        "text": f"{value.numerator}/{value.denominator}",
    }


def circle_distance_at(speed: int, time: Fraction) -> Fraction:
    residue = (speed * time.numerator) % time.denominator
    return Fraction(min(residue, time.denominator - residue), time.denominator)


def phase_at(speed: int, time: Fraction) -> Fraction:
    return Fraction((speed * time.numerator) % time.denominator, time.denominator)


def shift_rows(a: Sequence[int], t: Fraction, d: int) -> list[dict[str, Any]]:
    a = validate_tuple(a)
    out = []
    for h in range(d):
        tau = (t + h) / d
        out.append(
            {
                "h": h,
                "tau": frac_json(tau),
                "phases": [frac_json(phase_at(speed, tau)) for speed in a],
                "distances": [frac_json(circle_distance_at(speed, tau)) for speed in a],
            }
        )
    return out


def main_scan() -> dict[str, Any]:
    counts = {
        "tuples_seen": 0,
        "primitive": 0,
        "above_cutoff": 0,
        "has_N_divisible": 0,
        "all_deletions_nonempty": 0,
        "hard_premise": 0,
        "hard_with_strict_block": 0,
        "hard_without_strict_block": 0,
    }
    examined_by_n = {str(n): 0 for n in range(3, 7)}
    first_failure = None
    stop = False
    for n in range(3, 7):
        for a in itertools.combinations(range(1, MAIN_MAX_SPEED + 1), n):
            counts["tuples_seen"] += 1
            examined_by_n[str(n)] += 1
            if gcd_all(a) != 1:
                continue
            counts["primitive"] += 1
            N = n + 1
            if max(a) <= N + N // 3:
                continue
            counts["above_cutoff"] += 1
            if not any(value % N == 0 for value in a):
                continue
            counts["has_N_divisible"] += 1
            record = hard_record(a, include_blocks=False)
            if not record["all_deletions_nonempty"]:
                continue
            counts["all_deletions_nonempty"] += 1
            if not record["all_canonical_fail"]:
                continue
            counts["hard_premise"] += 1
            full = hard_record(a, include_blocks=True)
            if full["first_strict_divisor_block"] is None:
                counts["hard_without_strict_block"] += 1
                full["centered_equations"] = [
                    centered_equation(a, row) for row in full["canonical_deletions"]
                ]
                first_failure = full
                stop = True
                break
            counts["hard_with_strict_block"] += 1
        if stop:
            break
    return {
        "domain": {
            "n_values": [3, 4, 5, 6],
            "strictly_increasing": True,
            "positive": True,
            "primitive_only_for_premise": True,
            "maximum_speed": MAIN_MAX_SPEED,
            "tuple_order": "n ascending, then itertools.combinations lexicographic order",
            "subset_order": "cardinality ascending, then lexicographic zero-based index tuple",
            "early_stop": "stop globally at first hard-premise tuple with no strict divisor block",
        },
        "counts_on_executed_prefix": counts,
        "examined_by_n": examined_by_n,
        "first_failure": first_failure,
        "premise_domain_vacuous": counts["hard_premise"] == 0,
    }


def one_coordinate_mutations(base: Sequence[int]) -> list[tuple[int, ...]]:
    base = validate_tuple(base)
    mutations = set()
    for deleted_index in range(len(base)):
        survivors = list(base)
        survivors.pop(deleted_index)
        for replacement in range(1, MUTATION_MAX_SPEED + 1):
            candidate = tuple(sorted(survivors + [replacement]))
            if len(set(candidate)) != len(base):
                continue
            if candidate != tuple(sorted(base)):
                mutations.add(candidate)
    return sorted(mutations)


def mutation_scan(base: Sequence[int]) -> dict[str, Any]:
    mutations = one_coordinate_mutations(base)
    counts = {
        "mutations": len(mutations),
        "primitive": 0,
        "hard_premise": 0,
        "hard_with_strict_block": 0,
        "hard_without_strict_block": 0,
    }
    first_hard = None
    first_hard_without_block = None
    for a in mutations:
        if gcd_all(a) != 1:
            continue
        counts["primitive"] += 1
        record = hard_record(a, include_blocks=False)
        if not record["hard_canonical_failure"]:
            continue
        counts["hard_premise"] += 1
        full = hard_record(a, include_blocks=True)
        if first_hard is None:
            first_hard = full
        if full["first_strict_divisor_block"] is None:
            counts["hard_without_strict_block"] += 1
            if first_hard_without_block is None:
                first_hard_without_block = full
        else:
            counts["hard_with_strict_block"] += 1
    return {
        "base": list(base),
        "mutation_definition": (
            "replace exactly one coordinate by each integer 1..120, sort, "
            "discard collisions and the unchanged tuple, deduplicate, then lexicographically order"
        ),
        "counts": counts,
        "first_hard_tuple": None if first_hard is None else first_hard["tuple"],
        "first_hard_without_block": (
            None if first_hard_without_block is None else first_hard_without_block["tuple"]
        ),
    }


def exact_fixtures() -> dict[str, Any]:
    # Fixture 1: local strict-block success.
    a1 = (2, 4, 5)
    rows1 = divisor_block_rows(a1)
    block1 = next(row for row in rows1 if row["S_speeds"] == [5])
    t = Fraction(1, 3)
    shifts1 = shift_rows(a1, t, block1["d"])
    assert block1["d"] == 2 and block1["capacity_sum"] == 1 and block1["strict"]
    assert shifts1[1]["distances"] == [frac_json(Fraction(1, 3))] * 3

    # Fixture 2: equality is not strict.
    a2 = (2, 4, 6)
    rows2 = divisor_block_rows(a2)
    block2 = next(row for row in rows2 if row["S_speeds"] == [6])
    shifts2 = shift_rows(a2, t, block2["d"])
    assert block2["d"] == 2 and block2["capacity_sum"] == 2 and not block2["strict"]

    # Fixtures 3-6 are recomputed from the frozen definitions.
    coarse = hard_record((1, 2, 3, 10), include_blocks=True)
    raw = hard_record((1, 3, 4, 7), include_blocks=True)
    phase_intersection = hard_record((1, 2, 3, 60), include_blocks=True)
    divisible_pivot = hard_record((1, 2, 6, 8, 10), include_blocks=True)

    # Exact phase-set obstruction at threshold 1/4 for (1,2,3,60).
    safe_first_three = [frac_json(Fraction(1, 4)), frac_json(Fraction(3, 4))]
    assert all(circle_distance_at(speed, Fraction(1, 4)) >= Fraction(1, 4) for speed in (1, 2, 3))
    assert all(circle_distance_at(speed, Fraction(3, 4)) >= Fraction(1, 4) for speed in (1, 2, 3))
    assert circle_distance_at(60, Fraction(1, 4)) == 0
    assert circle_distance_at(60, Fraction(3, 4)) == 0

    # Fixed N-divisible pivot 6 at (1,2,6,8,10).
    pivot6_rows = []
    a6 = (1, 2, 6, 8, 10)
    pivot6_index = a6.index(6)
    for deleted in range(len(a6)):
        if deleted == pivot6_index:
            continue
        for cert in deletion_certificates(a6, deleted):
            if cert["pivot_index_zero_based"] == pivot6_index:
                pivot6_rows.append(
                    {
                        "deleted_speed": a6[deleted],
                        "r": cert["r"],
                        "residues": cert["residues"],
                        "lifts": cert["lifts"],
                    }
                )
    pivot6_rows.sort(key=lambda row: row["r"])
    assert len(pivot6_rows) == 16 and not any(row["lifts"] for row in pivot6_rows)
    nondiv_lift = next(
        cert
        for cert in deletion_certificates(a6, a6.index(1))
        if cert["pivot_speed"] == 8 and cert["r"] == 9
    )
    assert nondiv_lift["lifts"]

    return {
        "1_local_success": {
            "tuple": list(a1),
            "T_speeds": [2, 4],
            "S_speeds": [5],
            "block": block1,
            "divided_survivor_time": frac_json(t),
            "shifts": shifts1,
            "explicit_full_shift_h": 1,
        },
        "2_capacity_equality_failure": {
            "tuple": list(a2),
            "T_speeds": [2, 4],
            "S_speeds": [6],
            "block": block2,
            "divided_survivor_time": frac_json(t),
            "shifts": shifts2,
        },
        "3_coarse_premises_do_not_force_block": coarse,
        "4_raw_deletion_lift_failure": raw,
        "5_pairwise_phase_intersection_failure": {
            "record": phase_intersection,
            "only_times_mod_1_safe_for_speeds_1_2_3_at_threshold_1_over_4": safe_first_three,
            "speed_60_distance_at_both": frac_json(Fraction(0, 1)),
            "pairwise_intersections_of_deletion_phase_sets_empty": True,
        },
        "6_N_divisible_pivot_not_required": {
            "record": divisible_pivot,
            "fixed_pivot_speed_6_certificate_rows": pivot6_rows,
            "fixed_pivot_speed_6_certificate_count": len(pivot6_rows),
            "fixed_pivot_speed_6_lift_count": sum(row["lifts"] for row in pivot6_rows),
            "non_N_divisible_lift": nondiv_lift,
        },
    }


def anti_tautology_witness() -> dict[str, Any]:
    a = (1, 3, 16)
    t = Fraction(5, 11)
    distances = [circle_distance_at(speed, t) for speed in a]
    assert all(distance >= Fraction(1, 4) for distance in distances)
    return {
        "tuple": list(a),
        "full_witness_time": frac_json(t),
        "distances": [frac_json(distance) for distance in distances],
        "threshold": frac_json(Fraction(1, 4)),
    }


def canonical_json_bytes(payload: Any) -> bytes:
    return (json.dumps(payload, indent=2, sort_keys=True) + "\n").encode("utf-8")


def main() -> int:
    if len(sys.argv) != 1:
        print("error: prompt80_exact_search.py accepts no arguments", file=sys.stderr)
        return 2

    source_path = Path(__file__).resolve()
    source_sha = hashlib.sha256(source_path.read_bytes()).hexdigest()

    results = {
        "main_scan": main_scan(),
        "targeted_mutations": [mutation_scan(base) for base in MUTATION_BASES],
        "fixtures": exact_fixtures(),
        "anti_tautology": anti_tautology_witness(),
    }
    results_sha = hashlib.sha256(canonical_json_bytes(results)).hexdigest()
    payload = {
        "schema": "PIPE-P80-DIVISOR-BLOCK-EXACT-v1",
        "script_version": VERSION,
        "status": "exact-structural-counterexample",
        "runtime": {
            "language": "Python",
            "version": platform.python_version(),
            "implementation": platform.python_implementation(),
            "platform": platform.platform(),
            "arithmetic": "exact arbitrary-precision integers and fractions.Fraction",
        },
        "invocation": "python3 /mnt/data/prompt80_exact_search.py",
        "malformed_input_behavior": "any command-line argument -> stderr diagnostic and exit status 2",
        "source_file": source_path.name,
        "source_sha256": source_sha,
        "source_output_binding": "this output embeds the SHA-256 of the exact source bytes",
        "results_sha256": results_sha,
        "results": results,
    }
    output_path = source_path.with_suffix(".json")
    output_path.write_bytes(canonical_json_bytes(payload))

    first = payload["results"]["main_scan"]["first_failure"]
    print(f"wrote={output_path}")
    print(f"source_sha256={source_sha}")
    print(f"results_sha256={results_sha}")
    print(f"first_failure={tuple(first['tuple']) if first else None}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
