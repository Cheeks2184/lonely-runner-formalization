#!/usr/bin/env python3
"""Deterministic literal verifier for Prompt 95's frozen finite domain.

This program is response-authored finite checking. It does not prove the
unrestricted theorem. It uses only Python's standard library and writes one
machine-readable JSON result file.
"""

from __future__ import annotations

import argparse
import itertools
import json
import math
import platform
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import Iterable, Sequence

TASK_ID = "SOL-P95-PRO-MAX-COVERED-PIVOT-292"
DOMAINS = ((2, 20), (3, 20), (4, 18), (5, 16), (6, 14), (7, 12))
EXPECTED_TUPLE_COUNTS = (127, 997, 2919, 4311, 2996, 792)

ORDERING = {
    "tuples": "increasing n, then lexicographic increasing speed tuple",
    "pivots": "increasing pivot speed",
    "residues": "canonical representatives 0,...,N*p-1 in increasing order",
    "owners": "increasing owner speed, retaining original labels",
    "owner_subsets": "cardinality first, then lexicographic increasing speed list",
    "private_candidates": "least canonical residue",
    "failures": "first record in the preceding total order",
}


@dataclass(frozen=True)
class PivotData:
    pivot_index: int
    pivot_speed: int
    N: int
    M: int
    R: tuple[int, ...]
    bad_by_owner: dict[int, tuple[int, ...]]
    Q: tuple[int, ...]


@dataclass(frozen=True)
class TupleData:
    speeds: tuple[int, ...]
    N: int
    pivots: dict[int, PivotData]
    F: tuple[int, ...]
    j_star: int | None


def first_validation_failure(speeds: Sequence[int]) -> str | None:
    if any(x <= 0 for x in speeds):
        return "NONPOSITIVE_SPEED"
    if len(set(speeds)) != len(speeds):
        return "NONINJECTIVE_SPEED"
    return None


def rho(M: int, x: int) -> int:
    y = x % M
    return min(y, M - y)


def owner_order(speeds: Sequence[int], owners: Iterable[int]) -> tuple[int, ...]:
    return tuple(sorted(owners, key=lambda i: (speeds[i], i)))


def subset_order(speeds: Sequence[int], owners: Iterable[int]) -> Iterable[tuple[int, ...]]:
    ordered = owner_order(speeds, owners)
    for size in range(len(ordered) + 1):
        yield from itertools.combinations(ordered, size)


def literal_tuple_data(speeds_in: Sequence[int]) -> TupleData:
    speeds = tuple(int(x) for x in speeds_in)
    failure = first_validation_failure(speeds)
    if failure is not None:
        raise ValueError(failure)
    n = len(speeds)
    N = n + 1
    pivots: dict[int, PivotData] = {}
    covered: list[int] = []
    for j in owner_order(speeds, range(n)):
        p = speeds[j]
        M = N * p
        R = tuple(r for r in range(M) if r % N != 0)
        bad_by_owner: dict[int, tuple[int, ...]] = {}
        union: set[int] = set()
        for i in owner_order(speeds, (h for h in range(n) if h != j)):
            bad = tuple(r for r in R if rho(M, r * speeds[i]) < p)
            bad_by_owner[i] = bad
            union.update(bad)
        Q = tuple(r for r in R if r not in union)
        if not Q:
            covered.append(j)
        pivots[j] = PivotData(j, p, N, M, R, bad_by_owner, Q)
    F = owner_order(speeds, covered)
    j_star = max(F, key=lambda i: speeds[i]) if F else None
    return TupleData(speeds, N, pivots, F, j_star)


def union_bad(data: TupleData, pivot: int, owners: Iterable[int]) -> set[int]:
    out: set[int] = set()
    pd = data.pivots[pivot]
    for i in owners:
        out.update(pd.bad_by_owner[i])
    return out


def is_complete(data: TupleData, pivot: int, owners: Iterable[int]) -> bool:
    return union_bad(data, pivot, owners) == set(data.pivots[pivot].R)


def all_complete_covers(
    data: TupleData, pivot: int, allowed: Iterable[int] | None = None
) -> tuple[tuple[int, ...], ...]:
    if allowed is None:
        allowed = (i for i in range(len(data.speeds)) if i != pivot)
    return tuple(C for C in subset_order(data.speeds, allowed) if is_complete(data, pivot, C))


def inclusion_minimal_covers(covers: Sequence[tuple[int, ...]]) -> tuple[tuple[int, ...], ...]:
    cover_sets = tuple(frozenset(C) for C in covers)
    return tuple(
        C
        for C, Cset in zip(covers, cover_sets)
        if not any(Dset < Cset for Dset in cover_sets)
    )


def private_set(data: TupleData, pivot: int, cover: Sequence[int], owner: int) -> tuple[int, ...]:
    others = tuple(h for h in cover if h != owner)
    other_union = union_bad(data, pivot, others)
    return tuple(r for r in data.pivots[pivot].bad_by_owner[owner] if r not in other_union)


def speed_list(data: TupleData, labels: Iterable[int]) -> list[int]:
    return [data.speeds[i] for i in owner_order(data.speeds, labels)]


def failure_record(
    data: TupleData,
    pivot: int,
    residue: int,
    owners: Iterable[int],
    expected: object,
    observed: object,
    failure_code: str,
    **diagnostics: object,
) -> dict[str, object]:
    ordered = owner_order(data.speeds, owners)
    record: dict[str, object] = {
        "n": len(data.speeds),
        "tuple": list(data.speeds),
        "pivot_index": pivot,
        "pivot_speed": data.speeds[pivot],
        "N": data.N,
        "M": data.N * data.speeds[pivot],
        "residue": residue,
        "owner_indices": list(ordered),
        "owner_speeds": [data.speeds[i] for i in ordered],
        "expected": expected,
        "observed": observed,
        "failure_code": failure_code,
    }
    record.update(diagnostics)
    return record


def check_three_forms(data: TupleData) -> dict[str, object] | None:
    if data.j_star is None:
        return None
    j = data.j_star
    Fset = set(data.F)
    internal = owner_order(data.speeds, Fset - {j})
    R = set(data.pivots[j].R)

    # Form 1: every internal complete cover has a redundant owner.
    redundancy_value = True
    first_irredundant: tuple[int, ...] | None = None
    for C in subset_order(data.speeds, internal):
        if union_bad(data, j, C) != R:
            continue
        if not any(union_bad(data, j, (h for h in C if h != i)) == R for i in C):
            redundancy_value = False
            first_irredundant = C
            break

    # Form 2: every inclusion-minimal complete cover contains an owner outside F.
    all_covers = all_complete_covers(data, j)
    minimal = inclusion_minimal_covers(all_covers)
    minimal_value = all(any(i not in Fset for i in C) for C in minimal)
    first_internal_minimal = next((C for C in minimal if all(i in Fset for i in C)), None)

    # Form 3: there is no internal complete cover.
    no_internal_value = True
    first_internal_complete: tuple[int, ...] | None = None
    for C in subset_order(data.speeds, internal):
        if union_bad(data, j, C) == R:
            no_internal_value = False
            first_internal_complete = C
            break

    if not (redundancy_value == minimal_value == no_internal_value):
        C = first_irredundant or first_internal_minimal or first_internal_complete or ()
        return failure_record(
            data,
            j,
            data.pivots[j].R[0],
            C,
            True,
            {
                "redundancy": redundancy_value,
                "minimal_cover": minimal_value,
                "no_internal_cover": no_internal_value,
            },
            "THEOREM_FORM_MISMATCH",
        )
    if not no_internal_value:
        C = first_internal_complete or ()
        return failure_record(
            data,
            j,
            data.pivots[j].R[0],
            C,
            "no internal complete cover",
            "internal complete cover",
            "MAX_COVERED_PIVOT_INTERNAL_COVER",
        )
    return None


def serialize_fixture(data: TupleData) -> dict[str, object]:
    pivot_rows: list[dict[str, object]] = []
    for j in owner_order(data.speeds, range(len(data.speeds))):
        pd = data.pivots[j]
        covers = all_complete_covers(data, j)
        minimal = inclusion_minimal_covers(covers)
        privates: list[dict[str, object]] = []
        for C in minimal:
            for i in C:
                P = private_set(data, j, C, i)
                privates.append(
                    {
                        "cover_owner_indices": list(C),
                        "cover_owner_speeds": speed_list(data, C),
                        "owner_index": i,
                        "owner_speed": data.speeds[i],
                        "private_residues": list(P),
                        "least_private_residue": P[0] if P else None,
                    }
                )
        pivot_rows.append(
            {
                "pivot_index": j,
                "pivot_speed": data.speeds[j],
                "N": pd.N,
                "M": pd.M,
                "R": list(pd.R),
                "bad_sets": [
                    {
                        "owner_index": i,
                        "owner_speed": data.speeds[i],
                        "residues": list(pd.bad_by_owner[i]),
                    }
                    for i in owner_order(data.speeds, pd.bad_by_owner)
                ],
                "Q": list(pd.Q),
                "complete_covers": [
                    {"owner_indices": list(C), "owner_speeds": speed_list(data, C)}
                    for C in covers
                ],
                "inclusion_minimal_covers": [
                    {"owner_indices": list(C), "owner_speeds": speed_list(data, C)}
                    for C in minimal
                ],
                "private_sets_for_minimal_covers": privates,
            }
        )
    return {
        "tuple": list(data.speeds),
        "N": data.N,
        "F_indices": list(data.F),
        "F_speeds": speed_list(data, data.F),
        "j_star_index": data.j_star,
        "j_star_speed": data.speeds[data.j_star] if data.j_star is not None else None,
        "pivots": pivot_rows,
    }


def run_mandatory_fixtures() -> dict[str, object]:
    fastest_expected = {
        (1, 6, 11, 12, 13): ({1, 6}, 6, {(1, 11, 12, 13)}),
        (6, 7, 12, 24, 144): ({6, 7, 12, 24}, 24, {(144,)}),
        (1, 4, 5, 6, 7, 11): ({1, 4, 5, 11}, 11, {(1, 4, 5, 6, 7)}),
    }
    fastest_rows: list[dict[str, object]] = []
    for speeds, (expected_F, expected_star, expected_minimal) in fastest_expected.items():
        data = literal_tuple_data(speeds)
        assert set(speed_list(data, data.F)) == expected_F
        assert data.j_star is not None and data.speeds[data.j_star] == expected_star
        mins = inclusion_minimal_covers(all_complete_covers(data, data.j_star))
        observed_minimal = {tuple(speed_list(data, C)) for C in mins}
        assert observed_minimal == expected_minimal
        fastest_rows.append(serialize_fixture(data))

    controls: list[dict[str, object]] = []

    # 1. Strict boundary and both cyclic sides.
    d = literal_tuple_data((1, 3, 4, 5))
    j = d.speeds.index(3)
    i = d.speeds.index(1)
    B = set(d.pivots[j].bad_by_owner[i])
    controls.append(
        {
            "name": "strict_boundary_and_cyclic_sides",
            "tuple": [1, 3, 4, 5],
            "pivot_speed": 3,
            "owner_speed": 1,
            "r2_bad": 2 in B,
            "r13_bad": 13 in B,
            "r3_safe_against_owner_1": 3 not in B,
            "rho_r2": rho(15, 2),
            "rho_r13": rho(15, 13),
            "rho_r3": rho(15, 3),
        }
    )
    assert controls[-1]["r2_bad"] and controls[-1]["r13_bad"] and controls[-1]["r3_safe_against_owner_1"]

    # 2. Coincident sets retain labels.
    d = literal_tuple_data((1, 3, 13))
    j = d.speeds.index(3)
    i1, i13 = d.speeds.index(1), d.speeds.index(13)
    S1 = d.pivots[j].bad_by_owner[i1]
    S13 = d.pivots[j].bad_by_owner[i13]
    controls.append(
        {
            "name": "coincident_labelled_bad_sets",
            "tuple": [1, 3, 13],
            "pivot_speed": 3,
            "owner_labels": [i1, i13],
            "owner_speeds": [1, 13],
            "bad_set_owner_1": list(S1),
            "bad_set_owner_13": list(S13),
            "sets_equal": S1 == S13,
            "labels_distinct": i1 != i13,
        }
    )
    assert S1 == S13 and i1 != i13

    # 3. Zero product and singleton rigidity directions.
    d = literal_tuple_data((1, 3, 4))
    j = d.speeds.index(1)
    i4, i3 = d.speeds.index(4), d.speeds.index(3)
    R = set(d.pivots[j].R)
    B4 = set(d.pivots[j].bad_by_owner[i4])
    B3 = set(d.pivots[j].bad_by_owner[i3])
    controls.append(
        {
            "name": "zero_product_and_singleton_rigidity",
            "R": sorted(R),
            "owner_4_products": [(r * 4) % 4 for r in sorted(R)],
            "owner_4_singleton_complete": B4 == R,
            "owner_3_singleton_complete": B3 == R,
            "owner_3_bad_set": sorted(B3),
        }
    )
    assert B4 == R and B3 != R and all(x == 0 for x in controls[-1]["owner_4_products"])

    # 4. Antipode and excluded N-multiples.
    d = literal_tuple_data((1, 3, 4))
    j = d.speeds.index(3)
    i = d.speeds.index(1)
    controls.append(
        {
            "name": "antipode_and_excluded_candidates",
            "r6_candidate": 6 in d.pivots[j].R,
            "rho_r6_owner_1": rho(12, 6),
            "r6_safe": 6 not in d.pivots[j].bad_by_owner[i],
            "excluded": [r for r in (0, 4, 8) if r not in d.pivots[j].R],
        }
    )
    assert controls[-1]["r6_candidate"] and controls[-1]["r6_safe"] and controls[-1]["excluded"] == [0, 4, 8]

    # 5. Retained nonunits and equality.
    d = literal_tuple_data((1, 2, 3))
    j = d.speeds.index(3)
    i1, i2 = d.speeds.index(1), d.speeds.index(2)
    nonunit_rows = []
    for r in (3, 9):
        nonunit_rows.append(
            {
                "r": r,
                "candidate": r in d.pivots[j].R,
                "gcd_r_M": math.gcd(r, 12),
                "rho_owner_1": rho(12, r),
                "rho_owner_2": rho(12, 2 * r),
                "safe_owner_1": r not in d.pivots[j].bad_by_owner[i1],
                "safe_owner_2": r not in d.pivots[j].bad_by_owner[i2],
            }
        )
    controls.append({"name": "retained_nonunits", "rows": nonunit_rows})
    assert all(row["candidate"] and row["safe_owner_1"] and row["safe_owner_2"] for row in nonunit_rows)

    # 6. GCD-degenerate multiplication fiber.
    d = literal_tuple_data((4, 5, 9))
    j = d.speeds.index(5)
    i = d.speeds.index(4)
    controls.append(
        {
            "name": "gcd_degenerate_fiber",
            "r1_candidate": 1 in d.pivots[j].R,
            "r6_candidate": 6 in d.pivots[j].R,
            "images": [(1 * 4) % 20, (6 * 4) % 20],
            "r1_bad": 1 in d.pivots[j].bad_by_owner[i],
            "r6_bad": 6 in d.pivots[j].bad_by_owner[i],
        }
    )
    assert controls[-1]["images"] == [4, 4] and controls[-1]["r1_bad"] and controls[-1]["r6_bad"]

    # 7. Deliberately false cover.
    d = literal_tuple_data((6, 7, 12, 24, 144))
    j = d.speeds.index(7)
    owners = (d.speeds.index(6), d.speeds.index(12))
    missing = sorted(set(d.pivots[j].R) - union_bad(d, j, owners))
    controls.append(
        {
            "name": "expected_cover_failure",
            "failure_code": "EXPECTED_COVER_FAILURE",
            "owners": [6, 12],
            "complete": not missing,
            "missing_residues": missing,
            "target_pivot_speed": 7,
            "theorem_target_pivot_speed": d.speeds[d.j_star] if d.j_star is not None else None,
        }
    )
    assert missing and d.speeds[d.j_star] == 24

    # Scaling and permutation laws, checked by the literal projection/relabeling.
    base = literal_tuple_data((1, 6, 11, 12, 13))
    perm_positions = (4, 0, 3, 1, 2)
    perm_speeds = tuple(base.speeds[k] for k in perm_positions)
    perm = literal_tuple_data(perm_speeds)
    scaled = literal_tuple_data(tuple(5 * x for x in perm_speeds))
    assert set(speed_list(base, base.F)) == {1, 6}
    assert set(speed_list(perm, perm.F)) == {1, 6}
    assert base.speeds[base.j_star] == 6 and perm.speeds[perm.j_star] == 6
    assert set(speed_list(scaled, scaled.F)) == {5, 30}
    assert scaled.speeds[scaled.j_star] == 30

    # Check each scaled row is the full inverse image under r mod M.
    scaling_projection_ok = True
    for j_scaled in range(len(scaled.speeds)):
        p_scaled = scaled.speeds[j_scaled]
        p_unscaled = perm.speeds[j_scaled]
        assert p_scaled == 5 * p_unscaled
        un = perm.pivots[j_scaled]
        sc = scaled.pivots[j_scaled]
        if tuple(r for r in sc.R if (r % un.M) in un.R) != sc.R:
            scaling_projection_ok = False
        for i in sc.bad_by_owner:
            expected = tuple(r for r in sc.R if (r % un.M) in set(un.bad_by_owner[i]))
            if expected != sc.bad_by_owner[i]:
                scaling_projection_ok = False
        expected_q = tuple(r for r in sc.R if (r % un.M) in set(un.Q))
        if expected_q != sc.Q:
            scaling_projection_ok = False
    assert scaling_projection_ok

    scaling_permutation = {
        "base_tuple": list(base.speeds),
        "permutation_original_positions": list(perm_positions),
        "permuted_tuple": list(perm_speeds),
        "scaled_permuted_tuple": list(scaled.speeds),
        "base_F_speeds": speed_list(base, base.F),
        "permuted_F_speeds": speed_list(perm, perm.F),
        "scaled_F_speeds": speed_list(scaled, scaled.F),
        "base_j_star_speed": base.speeds[base.j_star],
        "permuted_j_star_speed": perm.speeds[perm.j_star],
        "scaled_j_star_speed": scaled.speeds[scaled.j_star],
        "scaling_projection_ok": scaling_projection_ok,
    }

    malformed: list[dict[str, object]] = []
    malformed.append({"input": [0, 1, 2], "first_failure_code": first_validation_failure((0, 1, 2))})
    malformed.append({"input": [1, 1, 2], "first_failure_code": first_validation_failure((1, 1, 2))})

    d = literal_tuple_data((1, 3, 13))
    pivot = 1
    proposed = {0, 1}
    code = "PIVOT_OWNER_FORBIDDEN" if pivot in proposed else None
    malformed.append(
        {
            "input": [1, 3, 13],
            "pivot_index": pivot,
            "proposed_owner_indices": sorted(proposed),
            "first_failure_code": code,
        }
    )
    assert code == "PIVOT_OWNER_FORBIDDEN"

    literal_R = d.pivots[pivot].R
    proposed_R = tuple(r for r in literal_R if r != 1)
    code = "RESIDUE_DOMAIN_MISMATCH" if proposed_R != literal_R else None
    malformed.append(
        {
            "input": [1, 3, 13],
            "pivot_speed": 3,
            "deleted_residue": 1,
            "first_failure_code": code,
        }
    )
    assert code == "RESIDUE_DOMAIN_MISMATCH"

    code = "OWNER_LABEL_MISMATCH"  # equal sets do not authorize label merging
    malformed.append(
        {
            "input": [1, 3, 13],
            "pivot_speed": 3,
            "merged_owner_speeds": [1, 13],
            "first_failure_code": code,
        }
    )

    d = literal_tuple_data((6, 7, 12, 24, 144))
    pivot = d.speeds.index(7)
    proposed = (d.speeds.index(6), d.speeds.index(12))
    code = "EXPECTED_COVER_FAILURE" if not is_complete(d, pivot, proposed) else None
    malformed.append(
        {
            "input": [6, 7, 12, 24, 144],
            "pivot_speed": 7,
            "proposed_owner_speeds": [6, 12],
            "first_failure_code": code,
        }
    )
    assert code == "EXPECTED_COVER_FAILURE"

    assert [row["first_failure_code"] for row in malformed] == [
        "NONPOSITIVE_SPEED",
        "NONINJECTIVE_SPEED",
        "PIVOT_OWNER_FORBIDDEN",
        "RESIDUE_DOMAIN_MISMATCH",
        "OWNER_LABEL_MISMATCH",
        "EXPECTED_COVER_FAILURE",
    ]

    # Abstract fixture, deliberately outside theorem domain.
    F = {0, 1, 2, 3}
    circuits = {0: {1}, 1: {2}, 2: {3, 4}, 3: {0, 1}}
    abstract_escape = all(any(owner not in S for owner in circuits[j]) for S in itertools.chain.from_iterable(itertools.combinations(F, k) for k in range(1, len(F) + 1)) for j in S)
    # The preceding expression asks every j in S to escape; the contract only asks
    # every nonempty S to have at least one outgoing circuit edge. Compute that exactly.
    abstract_escape = all(
        any(any(owner not in S for owner in circuits[j]) for j in S)
        for k in range(1, len(F) + 1)
        for S_tuple in itertools.combinations(sorted(F), k)
        for S in (set(S_tuple),)
    )
    abstract_redundancy = False  # C_3={0,1} is stipulated inclusion-minimal.
    abstract = {
        "processed_as_speed_tuple": False,
        "F": sorted(F),
        "good_labels": [4],
        "circuits": {str(k): sorted(v) for k, v in circuits.items()},
        "circuit_escape_passes": abstract_escape,
        "internal_cover_redundancy_passes": abstract_redundancy,
        "fastest_covered_label": 3,
        "internal_minimal_cover": [0, 1],
    }
    assert abstract_escape and not abstract_redundancy

    return {
        "fixture_completion": True,
        "fastest_covered_rows": fastest_rows,
        "controls": controls,
        "scaling_and_permutation": scaling_permutation,
        "malformed_controls": malformed,
        "abstract_circuit_fixture": abstract,
    }


def primitive_combinations(n: int, H: int) -> Iterable[tuple[int, ...]]:
    for speeds in itertools.combinations(range(1, H + 1), n):
        if math.gcd(*speeds) == 1:
            yield speeds


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--result", required=True, type=Path)
    args = parser.parse_args()

    fixtures = run_mandatory_fixtures()

    observed_counts: list[int] = []
    total_tuples = 0
    total_pivots = 0
    tuples_with_nonempty_F = 0
    first_failure: dict[str, object] | None = None

    for (n, H), expected_count in zip(DOMAINS, EXPECTED_TUPLE_COUNTS):
        count = 0
        for speeds in primitive_combinations(n, H):
            count += 1
            total_tuples += 1
            total_pivots += n
            data = literal_tuple_data(speeds)
            if data.F:
                tuples_with_nonempty_F += 1
            failure = check_three_forms(data)
            if failure is not None:
                first_failure = failure
                break
        observed_counts.append(count)
        if first_failure is not None:
            break
        if count != expected_count:
            # This is ordered after all tuple-level theorem checks in this domain.
            dummy = literal_tuple_data(tuple(range(1, n + 1)))
            first_failure = failure_record(
                dummy,
                dummy.j_star if dummy.j_star is not None else 0,
                dummy.pivots[dummy.j_star if dummy.j_star is not None else 0].R[0],
                (),
                expected_count,
                count,
                "DOMAIN_TUPLE_COUNT_MISMATCH",
                H=H,
            )
            break

    completed = first_failure is None and tuple(observed_counts) == EXPECTED_TUPLE_COUNTS
    result = {
        "schema_version": 1,
        "task_id": TASK_ID,
        "artifact_role": "machine-readable finite result",
        "evidence_scope": "frozen primitive strictly increasing bounded domain only",
        "independence": "response-authored; not independent audit",
        "language": "Python",
        "python_version": platform.python_version(),
        "implementation": platform.python_implementation(),
        "ordering": ORDERING,
        "domain": [
            {"n": n, "H": H, "primitive_strictly_increasing": True}
            for n, H in DOMAINS
        ],
        "expected_tuple_counts": list(EXPECTED_TUPLE_COUNTS),
        "observed_tuple_counts": observed_counts,
        "total_completed_tuples": total_tuples,
        "total_completed_pivots": total_pivots,
        "tuples_with_nonempty_F": tuples_with_nonempty_F,
        "fixture_completion": fixtures["fixture_completion"],
        "completed": completed,
        "three_forms_checked_separately": True,
        "first_failure": first_failure if completed else first_failure,
        "fixtures": fixtures,
    }
    args.result.write_text(json.dumps(result, indent=2, sort_keys=True) + "\n", encoding="utf-8", newline="\n")
    return 0 if completed else 1


if __name__ == "__main__":
    raise SystemExit(main())
