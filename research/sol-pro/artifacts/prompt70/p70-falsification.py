#!/usr/bin/env python3
"""Exact finite audit for Prompt 70.

Domain scan: primitive strictly increasing positive tuples of lengths 3, 4, 5,
and 6 with largest speed at most 12. Tuples are ordered first by length and
then lexicographically. The scan stops globally at the first all-pivot full
cover. The mandatory fixtures are evaluated and asserted before the scan.
"""

from __future__ import annotations

import argparse
import itertools
import json
import math
import platform
from functools import reduce
from pathlib import Path
from typing import Any, Iterable, Sequence


def rho(x: int, modulus: int) -> int:
    residue = x % modulus
    return min(residue, modulus - residue)


def pivot_record(speeds: Sequence[int], pivot: int) -> dict[str, Any]:
    n = len(speeds)
    N = n + 1
    p = speeds[pivot]
    modulus = N * p
    candidates = [r for r in range(modulus) if r % N != 0]
    bad_by_owner: dict[int, list[int]] = {}
    multiplicity = {r: 0 for r in candidates}

    for owner, speed in enumerate(speeds):
        if owner == pivot:
            continue
        bad = [r for r in candidates if rho(r * speed, modulus) < p]
        bad_by_owner[owner] = bad
        for r in bad:
            multiplicity[r] += 1

    good = [r for r in candidates if multiplicity[r] == 0]
    return {
        "pivot_index": pivot,
        "pivot_speed": p,
        "N": N,
        "modulus": modulus,
        "candidate_count": len(candidates),
        "good_count": len(good),
        "good_residues": good,
        "bad_by_owner": {str(k): v for k, v in bad_by_owner.items()},
        "multiplicity": {str(k): v for k, v in multiplicity.items()},
    }


def good_counts(speeds: Sequence[int]) -> list[int]:
    return [pivot_record(speeds, j)["good_count"] for j in range(len(speeds))]


def all_full(speeds: Sequence[int]) -> bool:
    return all(count == 0 for count in good_counts(speeds))


def gcd_all(speeds: Iterable[int]) -> int:
    return reduce(math.gcd, speeds)


def fixed_candidates(speeds: Sequence[int], pivot: int) -> list[int]:
    rec = pivot_record(speeds, pivot)
    M = rec["modulus"]
    N = rec["N"]
    return [r for r in range(M) if r % N != 0 and (2 * r) % M == 0]


def check_permutation_relabeling(speeds: Sequence[int]) -> bool:
    original = good_counts(speeds)
    for perm in itertools.permutations(range(len(speeds))):
        permuted = tuple(speeds[i] for i in perm)
        got = good_counts(permuted)
        expected = [original[i] for i in perm]
        if got != expected or all(x == 0 for x in got) != all(x == 0 for x in original):
            return False
    return True


def scaling_membership_check(base: Sequence[int], factor: int) -> bool:
    scaled = tuple(factor * x for x in base)
    n = len(base)
    N = n + 1
    for j in range(n):
        p = base[j]
        Mp = N * p
        Mscaled = factor * Mp
        for r in range(Mscaled):
            s = r % Mp
            if (r % N == 0) != (s % N == 0):
                return False
            if r % N == 0:
                continue
            for i in range(n):
                if i == j:
                    continue
                left = rho(r * scaled[i], Mscaled) < scaled[j]
                right = rho(s * base[i], Mp) < base[j]
                if left != right:
                    return False
    return True


def all_but_one_family(n: int) -> tuple[int, ...]:
    if n < 2:
        raise ValueError("family requires n >= 2")
    N = n + 1
    lcm = 1
    for k in range(1, n):
        lcm = math.lcm(lcm, k)
    L = N * lcm
    return tuple(range(1, n)) + (L,)


def mandatory_fixture_audit() -> dict[str, Any]:
    fixtures: dict[str, Any] = {}

    expected = {
        "1": ((1,), [1]),
        "2": ((1, 3), [0, 2]),
        "3": ((1, 2, 3), [2, 2, 2]),
        "4": ((4, 5, 9), [2, 2, 4]),
        "5": ((1, 2, 3, 5), [0, 0, 2, 2]),
        "6": ((1, 2, 3, 4, 5, 7), [0, 0, 0, 0, 2, 2]),
    }
    for key, (speeds, counts) in expected.items():
        got = good_counts(speeds)
        assert got == counts, (key, speeds, got, counts)
        fixtures[key] = {"speeds": list(speeds), "good_counts": got}

    rec3 = pivot_record((1, 2, 3), 2)
    assert 3 in rec3["good_residues"]
    assert rho(3 * 1, 12) == 3
    fixtures["3"]["strict_equality_safe"] = {
        "pivot_speed": 3,
        "residue": 3,
        "owner_speed": 1,
        "rho": 3,
        "bad_threshold": 3,
        "is_bad": False,
    }

    rec6_p5 = pivot_record((1, 2, 3, 4, 5, 7), 4)
    rec6_p7 = pivot_record((1, 2, 3, 4, 5, 7), 5)
    assert rec6_p5["good_residues"] == [6, 29]
    assert rec6_p7["good_residues"] == [8, 41]
    fixtures["6"]["pivot_speed_5_good"] = rec6_p5["good_residues"]
    fixtures["6"]["pivot_speed_7_good"] = rec6_p7["good_residues"]

    odd = (1, 3, 5)
    odd_data = []
    for j, p in enumerate(odd):
        fixed = fixed_candidates(odd, j)
        rec = pivot_record(odd, j)
        assert fixed == [2 * p]
        assert fixed[0] in rec["good_residues"]
        odd_data.append({
            "pivot_speed": p,
            "reflection_fixed_candidates": fixed,
            "fixed_candidate_is_good": True,
            "good_count": rec["good_count"],
        })
    fixtures["7"] = {"speeds": list(odd), "pivots": odd_data}

    collision = (1, 3, 13)
    collision_rec = pivot_record(collision, 1)
    owner0 = collision_rec["bad_by_owner"]["0"]
    owner2 = collision_rec["bad_by_owner"]["2"]
    assert owner0 == owner2 == [1, 2, 10, 11]
    fixtures["8"] = {
        "speeds": list(collision),
        "pivot_speed": 3,
        "modulus": 12,
        "owner_speed_1_bad": owner0,
        "owner_speed_13_bad": owner2,
        "owners_retained": 2,
    }

    scaling_pairs = [
        ((1, 2, 3), 2),
        ((1, 2, 3, 4, 5, 7), 2),
    ]
    scaling_data = []
    for base, factor in scaling_pairs:
        scaled = tuple(factor * x for x in base)
        base_counts = good_counts(base)
        scaled_counts = good_counts(scaled)
        assert scaled_counts == [factor * x for x in base_counts]
        assert scaling_membership_check(base, factor)
        scaling_data.append({
            "base": list(base),
            "factor": factor,
            "scaled": list(scaled),
            "base_good_counts": base_counts,
            "scaled_good_counts": scaled_counts,
            "membership_preserved_under_reduction": True,
        })
    fixtures["9"] = scaling_data

    N = 4
    p = 3
    M = N * p
    boundary = {
        "r_zero_excluded": 0 % N == 0,
        "N_multiple_excluded": 8 % N == 0,
        "rho_p_minus_1_bad": rho(p - 1, M) < p,
        "rho_p_safe": not (rho(p, M) < p),
        "negative_representative_p_minus_1_bad": rho(M - (p - 1), M) < p,
        "negative_representative_p_safe": not (rho(M - p, M) < p),
        "N2_antipode_safe": not (rho(3, 6) < 3),
        "N2_antipode_reflection_fixed": (2 * 3) % 6 == 0,
        "N2_antipode_candidate_when_p_odd": 3 % 2 != 0,
        "permutation_relabels_counts": check_permutation_relabeling((1, 2, 3, 5)),
    }
    assert all(boundary.values())
    fixtures["10"] = boundary

    return fixtures


def supplemental_audit() -> dict[str, Any]:
    unit_example = (1, 3, 4, 5, 7, 18)
    unit_rec = pivot_record(unit_example, 4)
    assert unit_rec["good_count"] == 0
    assert all(math.gcd(unit_example[i], 49) == 1 for i in range(len(unit_example)) if i != 4)

    family_records = []
    for n in range(2, 11):
        speeds = all_but_one_family(n)
        counts = good_counts(speeds)
        assert counts[:-1] == [0] * (n - 1)
        assert counts[-1] > 0
        N = n + 1
        L = speeds[-1]
        witness_residue = L + 1
        rec = pivot_record(speeds, n - 1)
        assert witness_residue in rec["good_residues"]
        assert gcd_all(speeds) == 1
        family_records.append({
            "n": n,
            "N": N,
            "speeds": list(speeds),
            "good_counts": counts,
            "last_pivot_explicit_good_residue": witness_residue,
            "gcd_all": 1,
        })

    return {
        "full_pivot_with_only_unit_nonpivot_speeds": {
            "speeds": list(unit_example),
            "pivot_speed": 7,
            "modulus": 49,
            "good_counts": good_counts(unit_example),
            "all_nonpivot_gcds_with_modulus": [
                math.gcd(unit_example[i], 49)
                for i in range(len(unit_example))
                if i != 4
            ],
            "bad_sets": unit_rec["bad_by_owner"],
        },
        "all_but_one_family_samples": family_records,
    }


def bounded_scan() -> dict[str, Any]:
    scanned_by_n: dict[str, int] = {}
    first_counterexample: dict[str, Any] | None = None

    for n in range(3, 7):
        scanned = 0
        for speeds in itertools.combinations(range(1, 13), n):
            if gcd_all(speeds) != 1:
                continue
            scanned += 1
            counts = good_counts(speeds)
            if all(count == 0 for count in counts):
                first_counterexample = {
                    "n": n,
                    "N": n + 1,
                    "speeds": list(speeds),
                    "good_counts": counts,
                }
                break
        scanned_by_n[str(n)] = scanned
        if first_counterexample is not None:
            break

    return {
        "domain": {
            "n_values": [3, 4, 5, 6],
            "positive": True,
            "strictly_increasing": True,
            "primitive": True,
            "largest_speed_at_most": 12,
        },
        "ordering": "n ascending, then tuple lexicographic",
        "early_stop": "global stop at first tuple with all pivot good-counts zero",
        "scanned_primitive_tuples_by_n": scanned_by_n,
        "first_all_pivot_full_tuple": first_counterexample,
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("output", type=Path)
    args = parser.parse_args()

    result = {
        "schema": "PIPE-P70-RESPEC-123/falsification-v1",
        "runtime": {
            "language": "Python",
            "version": platform.python_version(),
            "implementation": platform.python_implementation(),
            "standard_library_only": True,
        },
        "mandatory_fixtures": mandatory_fixture_audit(),
        "bounded_scan": bounded_scan(),
        "supplemental": supplemental_audit(),
    }
    args.output.write_text(json.dumps(result, indent=2, sort_keys=True) + "\n", encoding="utf-8")


if __name__ == "__main__":
    main()
