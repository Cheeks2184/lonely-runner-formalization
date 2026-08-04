#!/usr/bin/env python3
"""Exact finite audit for Prompt 69's frozen weighted compensation inequality.

Standard-library only.  The program first replays the mandatory regressions,
then scans primitive strictly increasing tuples for n=2..6 with maximum speed
at most 12.  It stops at the first covered pivot violating

    2*a_j <= sum_{k != j} (a_k / gcd(a_j,a_k))*G_k.

All arithmetic is integer arithmetic.
"""

from __future__ import annotations

import hashlib
import itertools
import json
import math
import platform
import sys
from functools import reduce
from pathlib import Path
from typing import Any, Iterable, Sequence

SCHEMA = "p69-cross-pivot-weighted-deficit-compensation-audit/v1"


def rho(modulus: int, x: int) -> int:
    y = x % modulus
    return min(y, modulus - y)


def gcd_all(values: Sequence[int]) -> int:
    return reduce(math.gcd, values)


def pivot_record(a: Sequence[int], j: int, include_sets: bool = True) -> dict[str, Any]:
    n = len(a)
    N = n + 1
    p = a[j]
    M = N * p
    R = [r for r in range(M) if r % N != 0]

    owner_bad_sets: list[dict[str, Any]] = []
    bad_by_owner: dict[int, set[int]] = {}
    for i, ai in enumerate(a):
        if i == j:
            continue
        bad = {r for r in R if rho(M, r * ai) < p}
        bad_by_owner[i] = bad
        owner_record: dict[str, Any] = {
            "owner_index": i,
            "owner_speed": ai,
            "bad_count": len(bad),
        }
        if include_sets:
            owner_record["bad_residues"] = sorted(bad)
        owner_bad_sets.append(owner_record)

    union_bad: set[int] = set()
    for bad in bad_by_owner.values():
        union_bad.update(bad)

    # Independent exact formulations of Q_j.
    q_by_mu = [
        r
        for r in R
        if sum(1 for i in bad_by_owner if r in bad_by_owner[i]) == 0
    ]
    q_by_direct_avoidance = [
        r
        for r in R
        if all(rho(M, r * a[i]) >= p for i in range(n) if i != j)
    ]
    q_by_set_subtraction = sorted(set(R) - union_bad)

    assert q_by_mu == q_by_direct_avoidance == q_by_set_subtraction
    covers = len(q_by_mu) == 0
    assert covers == (union_bad == set(R))

    reflection = {r: (-r) % M for r in q_by_mu}
    assert all(reflection[r] in q_by_mu for r in q_by_mu)
    fixed_q = [r for r in q_by_mu if reflection[r] == r]

    record: dict[str, Any] = {
        "pivot_index": j,
        "pivot_speed": p,
        "N": N,
        "M": M,
        "R_count": len(R),
        "G": len(q_by_mu),
        "covers": covers,
        "Q": q_by_mu,
        "reflection_fixed_Q": fixed_q,
        "owners": owner_bad_sets,
        "covers_equivalence_checked": True,
    }
    if include_sets:
        record["R"] = R
        record["union_bad"] = sorted(union_bad)
    return record


def tuple_record(a: Sequence[int], include_sets: bool = True) -> dict[str, Any]:
    pivots = [pivot_record(a, j, include_sets=include_sets) for j in range(len(a))]
    G = [p["G"] for p in pivots]
    covered_rows = []
    for j, pj in enumerate(pivots):
        if not pj["covers"]:
            continue
        terms = []
        rhs = 0
        for k, ak in enumerate(a):
            if k == j:
                continue
            g = math.gcd(a[j], ak)
            weight = ak // g
            assert g > 0 and ak % g == 0 and weight > 0
            value = weight * G[k]
            rhs += value
            terms.append(
                {
                    "destination_index": k,
                    "destination_speed": ak,
                    "gcd": g,
                    "weight": weight,
                    "G": G[k],
                    "weighted_G": value,
                }
            )
        lhs = 2 * a[j]
        covered_rows.append(
            {
                "source_index": j,
                "source_speed": a[j],
                "lhs": lhs,
                "rhs": rhs,
                "slack": rhs - lhs,
                "holds": lhs <= rhs,
                "terms": terms,
            }
        )
    return {
        "tuple": list(a),
        "n": len(a),
        "N": len(a) + 1,
        "primitive": gcd_all(a) == 1,
        "G": G,
        "pivots": pivots,
        "covered_rows": covered_rows,
    }


def compact_tuple_record(a: Sequence[int]) -> dict[str, Any]:
    rec = tuple_record(a, include_sets=False)
    return {
        "tuple": rec["tuple"],
        "G": rec["G"],
        "covered_rows": rec["covered_rows"],
    }


def permutation_audit(a: Sequence[int]) -> dict[str, Any]:
    base = tuple_record(a, include_sets=False)
    base_G = base["G"]
    tested = 0
    for perm in itertools.permutations(range(len(a))):
        ap = tuple(a[i] for i in perm)
        rec = tuple_record(ap, include_sets=False)
        expected_G = [base_G[i] for i in perm]
        assert rec["G"] == expected_G

        original_by_speed = {
            base["tuple"][row["source_index"]]: (row["lhs"], row["rhs"])
            for row in base["covered_rows"]
        }
        permuted_by_speed = {
            rec["tuple"][row["source_index"]]: (row["lhs"], row["rhs"])
            for row in rec["covered_rows"]
        }
        assert original_by_speed == permuted_by_speed
        tested += 1
    return {"tuple": list(a), "permutations_tested": tested, "passed": True}


def scaling_audit(a: Sequence[int], scale: int) -> dict[str, Any]:
    assert scale > 0
    base = tuple_record(a, include_sets=False)
    scaled_a = tuple(scale * x for x in a)
    scaled = tuple_record(scaled_a, include_sets=False)
    assert scaled["G"] == [scale * g for g in base["G"]]

    base_weights = {
        (j, k): a[k] // math.gcd(a[j], a[k])
        for j in range(len(a))
        for k in range(len(a))
        if j != k
    }
    scaled_weights = {
        (j, k): scaled_a[k] // math.gcd(scaled_a[j], scaled_a[k])
        for j in range(len(a))
        for k in range(len(a))
        if j != k
    }
    assert base_weights == scaled_weights

    base_rows = {row["source_index"]: row for row in base["covered_rows"]}
    scaled_rows = {row["source_index"]: row for row in scaled["covered_rows"]}
    assert set(base_rows) == set(scaled_rows)
    for j in base_rows:
        assert scaled_rows[j]["lhs"] == scale * base_rows[j]["lhs"]
        assert scaled_rows[j]["rhs"] == scale * base_rows[j]["rhs"]

    return {
        "tuple": list(a),
        "scale": scale,
        "scaled_tuple": scaled_a,
        "base_G": base["G"],
        "scaled_G": scaled["G"],
        "weights_invariant": True,
        "covered_row_sides_scale": True,
    }


def mandatory_regressions() -> dict[str, Any]:
    fixtures: list[tuple[int, ...]] = [
        (1, 3, 4),
        (1, 3, 4, 5),
        (1, 2, 3, 4, 5, 7),
        (1, 2, 8),
        (1, 3),
        (1, 2, 3),
        (4, 5, 9),
        (1, 3, 5),
        (1, 3, 13),
    ]
    expected_G = {
        fixtures[0]: [0, 2, 2],
        fixtures[1]: [0, 0, 2, 2],
        fixtures[2]: [0, 0, 0, 0, 2, 2],
        fixtures[3]: [0, 0, 6],
        fixtures[4]: [0, 2],
        fixtures[5]: [2, 2, 2],
        fixtures[6]: [2, 2, 4],
        fixtures[7]: [3, 3, 5],
        fixtures[8]: [3, 5, 9],
    }
    expected_named_Q = {
        ((1, 2, 3, 4, 5, 7), 4): [6, 29],
        ((1, 2, 3, 4, 5, 7), 5): [8, 41],
    }

    records = []
    for a in fixtures:
        rec = tuple_record(a, include_sets=True)
        assert rec["G"] == expected_G[a]
        for row in rec["covered_rows"]:
            assert row["holds"]
        for (qa, j), q_expected in expected_named_Q.items():
            if a == qa:
                assert rec["pivots"][j]["Q"] == q_expected
        records.append(rec)

    # Fixture 5: the two good points are a reflection pair modulo 9.
    f5 = records[4]
    assert f5["pivots"][1]["Q"] == [4, 5]
    assert (-4) % 9 == 5 and (-5) % 9 == 4

    # Fixture 6: equality rho=p is safe at the speed-3 pivot, r=3.
    f6 = records[5]
    p6 = f6["pivots"][2]
    assert 3 in p6["Q"]
    assert rho(p6["M"], 3 * 1) == p6["pivot_speed"]

    # Fixture 8: all-odd half-time points are fixed by reflection and counted once.
    f8 = records[7]
    half_time_checks = []
    for pivot in f8["pivots"]:
        half = pivot["M"] // 2
        assert half in pivot["Q"]
        assert half in pivot["reflection_fixed_Q"]
        half_time_checks.append(
            {
                "pivot_speed": pivot["pivot_speed"],
                "half_residue": half,
                "counted_once": pivot["Q"].count(half) == 1,
            }
        )

    # Fixture 9: speeds 1 and 13 coincide modulo M=12 at the speed-3 pivot,
    # but remain separate owner-indexed bad sets.
    f9 = records[8]
    pivot3 = f9["pivots"][1]
    owner0 = next(o for o in pivot3["owners"] if o["owner_index"] == 0)
    owner2 = next(o for o in pivot3["owners"] if o["owner_index"] == 2)
    assert owner0["bad_residues"] == owner2["bad_residues"] == [1, 2, 10, 11]

    # Boundary and representative checks.
    boundary_checks = {
        "r_zero_excluded": 0 not in records[0]["pivots"][0]["R"],
        "N_multiple_excluded": records[0]["N"] not in records[0]["pivots"][1]["R"],
        "rho_p_minus_1_is_bad": rho(12, 2) < 3,
        "rho_p_is_safe": rho(12, 3) >= 3,
        "antipode_at_half_modulus": {
            "M": 12,
            "residue": 6,
            "rho": rho(12, 6),
            "fixed_by_reflection": (-6) % 12 == 6,
        },
        "reflection_involution_checked_for_every_fixture_Q": True,
        "unique_representatives_checked_by_ranges": True,
        "neither_divides_pair": {
            "speeds": [4, 9],
            "four_divides_nine": 9 % 4 == 0,
            "nine_divides_four": 4 % 9 == 0,
        },
        "nontrivial_gcd_pair": {
            "speeds": [2, 4],
            "gcd": math.gcd(2, 4),
        },
    }
    assert boundary_checks["r_zero_excluded"]
    assert boundary_checks["N_multiple_excluded"]
    assert boundary_checks["rho_p_minus_1_is_bad"]
    assert boundary_checks["rho_p_is_safe"]
    assert boundary_checks["antipode_at_half_modulus"]["rho"] == 6
    assert boundary_checks["antipode_at_half_modulus"]["fixed_by_reflection"]
    assert not boundary_checks["neither_divides_pair"]["four_divides_nine"]
    assert not boundary_checks["neither_divides_pair"]["nine_divides_four"]
    assert boundary_checks["nontrivial_gcd_pair"]["gcd"] == 2

    permutation_checks = [permutation_audit(a) for a in fixtures[:3]]
    scaling_checks = [scaling_audit(a, 2) for a in fixtures[:3]]

    return {
        "fixtures": records,
        "half_time_fixed_points": half_time_checks,
        "coincident_owner_sets": {
            "tuple": [1, 3, 13],
            "pivot_index": 1,
            "pivot_speed": 3,
            "owner_indices": [0, 2],
            "owner_speeds": [1, 13],
            "bad_residues_each": owner0["bad_residues"],
            "owners_retained_separately": True,
        },
        "boundary_checks": boundary_checks,
        "permutation_checks": permutation_checks,
        "scaling_checks": scaling_checks,
        "passed": True,
    }


def scan_domain() -> dict[str, Any]:
    total_tuples = 0
    total_covered_rows = 0
    per_n: list[dict[str, Any]] = []
    first_violation: dict[str, Any] | None = None
    closest_absolute_slack: dict[str, Any] | None = None
    closest_ratio: tuple[int, int, dict[str, Any]] | None = None

    for n in range(2, 7):
        tuples_n = 0
        covered_n = 0
        for a in itertools.combinations(range(1, 13), n):
            if gcd_all(a) != 1:
                continue
            tuples_n += 1
            total_tuples += 1
            rec = tuple_record(a, include_sets=False)
            for row in rec["covered_rows"]:
                covered_n += 1
                total_covered_rows += 1
                slack = row["slack"]
                candidate = {
                    "tuple": list(a),
                    "source_index": row["source_index"],
                    "source_speed": row["source_speed"],
                    "G": rec["G"],
                    "lhs": row["lhs"],
                    "rhs": row["rhs"],
                    "slack": slack,
                    "terms": row["terms"],
                }
                if (
                    closest_absolute_slack is None
                    or slack < closest_absolute_slack["slack"]
                    or (
                        slack == closest_absolute_slack["slack"]
                        and (list(a), row["source_index"])
                        < (
                            closest_absolute_slack["tuple"],
                            closest_absolute_slack["source_index"],
                        )
                    )
                ):
                    closest_absolute_slack = candidate

                # Compare rhs/lhs exactly via cross multiplication.
                if closest_ratio is None:
                    closest_ratio = (row["rhs"], row["lhs"], candidate)
                else:
                    old_num, old_den, _ = closest_ratio
                    if row["rhs"] * old_den < old_num * row["lhs"]:
                        closest_ratio = (row["rhs"], row["lhs"], candidate)

                if not row["holds"]:
                    full = tuple_record(a, include_sets=True)
                    first_violation = {
                        "tuple_record": full,
                        "failed_row": row,
                    }
                    break
            if first_violation is not None:
                break
        per_n.append(
            {
                "n": n,
                "primitive_tuples_tested": tuples_n,
                "covered_rows_tested": covered_n,
            }
        )
        if first_violation is not None:
            break

    ratio_record = None
    if closest_ratio is not None:
        num, den, candidate = closest_ratio
        g = math.gcd(num, den)
        ratio_record = dict(candidate)
        ratio_record["rhs_over_lhs"] = {"numerator": num // g, "denominator": den // g}

    return {
        "domain": {
            "n_values": [2, 3, 4, 5, 6],
            "tuples": "primitive strictly increasing positive integer tuples",
            "largest_speed_at_most": 12,
            "tuple_order": "n ascending, then itertools.combinations lexicographic order",
            "source_pivot_order": "natural index order",
            "residue_order": "natural representative order 0 <= r < N*a_j",
        },
        "stop_rule": "stop at the first covered pivot with lhs > rhs",
        "per_n": per_n,
        "total_primitive_tuples_tested": total_tuples,
        "total_covered_rows_tested": total_covered_rows,
        "first_violation": first_violation,
        "zero_failures": first_violation is None,
        "closest_absolute_slack": closest_absolute_slack,
        "closest_rhs_over_lhs": ratio_record,
    }


def sha256_file(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()


def main(argv: Sequence[str]) -> int:
    output_path = Path(argv[1]) if len(argv) > 1 else Path("p69_compensation_audit.json")
    source_path = Path(__file__).resolve()

    regressions = mandatory_regressions()
    scan = scan_domain()
    result = {
        "schema": SCHEMA,
        "implementation": {
            "language": "Python",
            "python_version": platform.python_version(),
            "python_implementation": platform.python_implementation(),
            "standard_library_only": True,
            "source_filename": source_path.name,
            "source_sha256": sha256_file(source_path),
            "command": f"python3 {source_path.name} {output_path.name}",
        },
        "definitions": {
            "rho": "min(x mod M, M - (x mod M))",
            "R_j": "0 <= r < N*a_j and N does not divide r",
            "bad_boundary": "rho < a_j",
            "safe_boundary": "rho >= a_j, including equality",
            "weight": "a_k // gcd(a_j,a_k)",
        },
        "execution_order": ["mandatory_regressions", "bounded_scan"],
        "mandatory_regressions": regressions,
        "bounded_scan": scan,
    }

    output_path.write_text(json.dumps(result, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(json.dumps({"output": str(output_path), "source_sha256": result["implementation"]["source_sha256"]}))
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
