#!/usr/bin/env python3
"""Deterministic exact falsification for Prompt 76.

This standard-library-only program implements the frozen modular definitions,
canonical complete-cover order, owner-labelled private sets, PrivateDemand,
and ExternalCapacity. It scans primitive strictly increasing tuples for
2 <= n <= 6 with maximum speed <= 14, in n-then-lexicographic order. For each
primitive tuple it tests common scales 1, 2, and 3 in that order and stops at
the first failure of

    PrivateDemand(a) <= ExternalCapacity(a).

All arithmetic is exact Python integer arithmetic. A second bit-mask
implementation independently replays the first failure. Recovered attachments
are neither imported nor executed.

Malformed command line behavior: argparse prints usage and exits with status 2.
A missing/unwritable output parent produces a nonzero uncaught filesystem error.
"""

from __future__ import annotations

import argparse
import hashlib
import itertools
import json
import math
import platform
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import Any, Iterable, Sequence

SCHEMA = "p76-global-canonical-private-deficit-hall/v1"
SCALES = (1, 2, 3)
MANDATORY_FIXTURES: tuple[tuple[int, ...], ...] = (
    (1, 3, 4),
    (1, 3, 4, 5),
    (1, 2, 3, 5),
    (1, 6, 11, 12, 13),
    (1, 2, 8),
    (1, 2, 3, 4, 5, 7),
    (1, 3, 13),
)


def rho(modulus: int, value: int) -> int:
    if modulus <= 0:
        raise ValueError("modulus must be positive")
    residue = value % modulus
    return min(residue, modulus - residue)


def gcd_all(values: Sequence[int]) -> int:
    out = 0
    for value in values:
        out = math.gcd(out, value)
    return out


def centered_bad_equation(
    speeds: Sequence[int], pivot_index: int, owner_index: int, residue: int
) -> tuple[int, int]:
    """Return q,e with r*a_i=q*N*a_j+e and |e|<a_j for a bad incidence."""
    n = len(speeds)
    N = n + 1
    p = speeds[pivot_index]
    modulus = N * p
    x = residue * speeds[owner_index]
    u = x % modulus
    if u < p:
        e = u
    elif modulus - u < p:
        e = u - modulus
    else:
        raise ValueError("the declared incidence is not strictly bad")
    q = (x - e) // modulus
    assert x == q * modulus + e
    assert abs(e) < p
    return q, e


@dataclass(frozen=True)
class PivotRecord:
    pivot_index: int
    pivot_speed: int
    N: int
    modulus: int
    candidates: tuple[int, ...]
    bad_sets: dict[int, frozenset[int]]
    good_residues: tuple[int, ...]
    canonical_cover: tuple[int, ...] | None
    private_sets: dict[int, tuple[int, ...]] | None

    @property
    def covered(self) -> bool:
        return len(self.good_residues) == 0

    @property
    def G(self) -> int:
        return len(self.good_residues)

    @property
    def private_demand(self) -> int:
        if self.private_sets is None:
            return 0
        return sum(len(points) for points in self.private_sets.values())


def owner_order(speeds: Sequence[int], pivot_index: int) -> tuple[int, ...]:
    return tuple(
        sorted(
            (i for i in range(len(speeds)) if i != pivot_index),
            key=lambda i: speeds[i],
        )
    )


def canonical_cover(
    speeds: Sequence[int],
    pivot_index: int,
    candidate_set: frozenset[int],
    bad_sets: dict[int, frozenset[int]],
) -> tuple[int, ...] | None:
    """Least complete cover under (cardinality, increasing speed list)."""
    owners = owner_order(speeds, pivot_index)
    complete: list[tuple[int, ...]] = []
    for size in range(len(owners) + 1):
        complete.clear()
        for subset in itertools.combinations(owners, size):
            covered: set[int] = set()
            for owner in subset:
                covered.update(bad_sets[owner])
            if covered == candidate_set:
                complete.append(subset)
        if complete:
            return min(complete, key=lambda subset: tuple(speeds[i] for i in subset))
    return None


def compute_pivot(speeds: Sequence[int], pivot_index: int) -> PivotRecord:
    n = len(speeds)
    if n < 2:
        raise ValueError("this scanner's pivot record requires n >= 2")
    if any(value <= 0 for value in speeds):
        raise ValueError("speeds must be positive")
    if len(set(speeds)) != n:
        raise ValueError("speeds must be injective")

    N = n + 1
    p = speeds[pivot_index]
    modulus = N * p
    candidates = tuple(r for r in range(modulus) if r % N != 0)
    candidate_set = frozenset(candidates)

    bad_sets: dict[int, frozenset[int]] = {}
    for owner, owner_speed in enumerate(speeds):
        if owner == pivot_index:
            continue
        bad_sets[owner] = frozenset(
            r for r in candidates if rho(modulus, r * owner_speed) < p
        )

    covered_union: set[int] = set()
    for points in bad_sets.values():
        covered_union.update(points)
    good_residues = tuple(sorted(candidate_set.difference(covered_union)))

    cover: tuple[int, ...] | None = None
    private_sets: dict[int, tuple[int, ...]] | None = None
    if not good_residues:
        cover = canonical_cover(speeds, pivot_index, candidate_set, bad_sets)
        assert cover is not None
        private_sets = {}
        for owner in cover:
            covered_by_other_selected: set[int] = set()
            for other in cover:
                if other != owner:
                    covered_by_other_selected.update(bad_sets[other])
            private = tuple(
                sorted(bad_sets[owner].difference(covered_by_other_selected))
            )
            assert private, "minimum-cardinality complete cover lacks a private point"
            private_sets[owner] = private

    # Exact frozen-boundary checks.
    for r in candidates:
        assert rho(modulus, r * p) >= p  # pivot coordinate is safe
        reflected = (-r) % modulus
        assert reflected in candidate_set
        assert (r in good_residues) == (reflected in good_residues)
        for points in bad_sets.values():
            assert (r in points) == (reflected in points)

    return PivotRecord(
        pivot_index=pivot_index,
        pivot_speed=p,
        N=N,
        modulus=modulus,
        candidates=candidates,
        bad_sets=bad_sets,
        good_residues=good_residues,
        canonical_cover=cover,
        private_sets=private_sets,
    )


def compute_tuple(speeds: Sequence[int]) -> dict[str, Any]:
    pivots = tuple(compute_pivot(speeds, j) for j in range(len(speeds)))
    F = tuple(j for j, pivot in enumerate(pivots) if pivot.covered)
    outside = tuple(k for k in range(len(speeds)) if k not in set(F))
    G = tuple(pivot.G for pivot in pivots)

    private_demand = sum(pivots[j].private_demand for j in F)
    external_terms: list[dict[str, int]] = []
    external_capacity = 0
    for j in F:
        for k in outside:
            divisor = math.gcd(speeds[j], speeds[k])
            weight = speeds[k] // divisor
            value = weight * G[k]
            external_capacity += value
            external_terms.append(
                {
                    "source_pivot_index": j,
                    "source_pivot_speed": speeds[j],
                    "destination_pivot_index": k,
                    "destination_pivot_speed": speeds[k],
                    "gcd": divisor,
                    "weight": weight,
                    "G": G[k],
                    "weighted_G": value,
                }
            )

    regrouped_capacity = sum(
        G[k]
        * sum(speeds[k] // math.gcd(speeds[j], speeds[k]) for j in F)
        for k in outside
    )
    assert external_capacity == regrouped_capacity

    return {
        "speeds": tuple(speeds),
        "n": len(speeds),
        "N": len(speeds) + 1,
        "primitive": gcd_all(speeds) == 1,
        "pivots": pivots,
        "F": F,
        "outside_F": outside,
        "G": G,
        "private_demand": private_demand,
        "external_capacity": external_capacity,
        "regrouped_external_capacity": regrouped_capacity,
        "external_terms": external_terms,
        "inequality_holds": private_demand <= external_capacity,
        "slack": external_capacity - private_demand,
    }


def pivot_to_json(speeds: Sequence[int], record: PivotRecord, full_bad: bool) -> dict[str, Any]:
    cover = record.canonical_cover
    private = record.private_sets
    out: dict[str, Any] = {
        "pivot_index": record.pivot_index,
        "pivot_speed": record.pivot_speed,
        "N": record.N,
        "modulus": record.modulus,
        "R": list(record.candidates),
        "R_size": len(record.candidates),
        "Q": list(record.good_residues),
        "G": record.G,
        "covered": record.covered,
        "canonical_cover_indices": None if cover is None else list(cover),
        "canonical_cover_speeds": None
        if cover is None
        else [speeds[i] for i in cover],
        "private_sets_by_owner_index": None
        if private is None
        else {str(i): list(private[i]) for i in cover or ()},
        "private_sets_by_owner_speed": None
        if private is None
        else {str(speeds[i]): list(private[i]) for i in cover or ()},
        "private_sizes_by_owner_speed": None
        if private is None
        else {str(speeds[i]): len(private[i]) for i in cover or ()},
        "private_demand": record.private_demand,
    }
    if private is not None:
        out["centered_private_equations_by_owner_speed"] = {
            str(speeds[i]): [
                {
                    "r": r,
                    "q": centered_bad_equation(speeds, record.pivot_index, i, r)[0],
                    "e": centered_bad_equation(speeds, record.pivot_index, i, r)[1],
                    "equation": (
                        f"{r}*{speeds[i]}="
                        f"{centered_bad_equation(speeds, record.pivot_index, i, r)[0]}*"
                        f"{record.modulus}+"
                        f"({centered_bad_equation(speeds, record.pivot_index, i, r)[1]})"
                    ),
                }
                for r in private[i]
            ]
            for i in cover or ()
        }
    if full_bad:
        out["bad_sets_by_owner_index"] = {
            str(i): sorted(points) for i, points in record.bad_sets.items()
        }
        out["bad_sets_by_owner_speed"] = {
            str(speeds[i]): sorted(points) for i, points in record.bad_sets.items()
        }
    else:
        out["bad_set_sizes_by_owner_speed"] = {
            str(speeds[i]): len(points) for i, points in record.bad_sets.items()
        }
    return out


def tuple_to_json(record: dict[str, Any], full_bad: bool = False) -> dict[str, Any]:
    speeds = record["speeds"]
    F = record["F"]
    per_source_capacity: dict[str, int] = {}
    for term in record["external_terms"]:
        key = str(term["source_pivot_speed"])
        per_source_capacity[key] = per_source_capacity.get(key, 0) + term["weighted_G"]
    return {
        "speeds": list(speeds),
        "n": record["n"],
        "N": record["N"],
        "primitive": record["primitive"],
        "F_indices": list(F),
        "F_speeds": [speeds[j] for j in F],
        "outside_F_indices": list(record["outside_F"]),
        "outside_F_speeds": [speeds[k] for k in record["outside_F"]],
        "G": list(record["G"]),
        "private_demand_by_pivot_speed": {
            str(speeds[j]): record["pivots"][j].private_demand for j in F
        },
        "external_capacity_by_source_pivot_speed": per_source_capacity,
        "private_demand": record["private_demand"],
        "external_capacity": record["external_capacity"],
        "regrouped_external_capacity": record["regrouped_external_capacity"],
        "slack": record["slack"],
        "inequality_holds": record["inequality_holds"],
        "external_terms": record["external_terms"],
        "pivots": [pivot_to_json(speeds, pivot, full_bad) for pivot in record["pivots"]],
    }


# ---------------------------------------------------------------------------
# Structurally separate bit-mask replay of a tuple.
# ---------------------------------------------------------------------------

def _mask_from_values(values: Iterable[int]) -> int:
    mask = 0
    for value in values:
        mask |= 1 << value
    return mask


def _mask_values(mask: int, limit: int) -> tuple[int, ...]:
    return tuple(r for r in range(limit) if (mask >> r) & 1)


def compute_tuple_bitmask(speeds: Sequence[int]) -> dict[str, Any]:
    n = len(speeds)
    N = n + 1
    pivot_rows: list[dict[str, Any]] = []
    for j, p in enumerate(speeds):
        M = N * p
        R_mask = _mask_from_values(r for r in range(M) if r % N != 0)
        bad_masks: dict[int, int] = {}
        for i, owner_speed in enumerate(speeds):
            if i == j:
                continue
            mask = 0
            for r in range(M):
                if ((R_mask >> r) & 1) and rho(M, r * owner_speed) < p:
                    mask |= 1 << r
            bad_masks[i] = mask
        union = 0
        for mask in bad_masks.values():
            union |= mask
        Q_mask = R_mask & ~union
        Q = _mask_values(Q_mask, M)
        cover = None
        private: dict[int, tuple[int, ...]] | None = None
        if Q_mask == 0:
            owners = tuple(sorted(bad_masks, key=lambda i: speeds[i]))
            for size in range(len(owners) + 1):
                candidates: list[tuple[int, ...]] = []
                for subset in itertools.combinations(owners, size):
                    subset_union = 0
                    for owner in subset:
                        subset_union |= bad_masks[owner]
                    if subset_union == R_mask:
                        candidates.append(subset)
                if candidates:
                    cover = min(candidates, key=lambda C: tuple(speeds[i] for i in C))
                    break
            assert cover is not None
            private = {}
            for owner in cover:
                others = 0
                for other in cover:
                    if other != owner:
                        others |= bad_masks[other]
                private_mask = bad_masks[owner] & ~others & R_mask
                private[owner] = _mask_values(private_mask, M)
                assert private[owner]
        pivot_rows.append(
            {
                "Q": Q,
                "G": len(Q),
                "cover": cover,
                "private": private,
                "private_demand": 0
                if private is None
                else sum(len(x) for x in private.values()),
            }
        )

    F = tuple(j for j, row in enumerate(pivot_rows) if row["G"] == 0)
    outside = tuple(k for k in range(n) if k not in set(F))
    demand = sum(pivot_rows[j]["private_demand"] for j in F)
    capacity = sum(
        (speeds[k] // math.gcd(speeds[j], speeds[k])) * pivot_rows[k]["G"]
        for j in F
        for k in outside
    )
    return {
        "F": F,
        "G": tuple(row["G"] for row in pivot_rows),
        "Q": tuple(row["Q"] for row in pivot_rows),
        "covers": tuple(row["cover"] for row in pivot_rows),
        "private": tuple(row["private"] for row in pivot_rows),
        "private_demand": demand,
        "external_capacity": capacity,
    }


def verify_literal_vs_bitmask(record: dict[str, Any]) -> dict[str, Any]:
    speeds = record["speeds"]
    replay = compute_tuple_bitmask(speeds)
    assert replay["F"] == record["F"]
    assert replay["G"] == record["G"]
    assert replay["Q"] == tuple(p.good_residues for p in record["pivots"])
    assert replay["covers"] == tuple(p.canonical_cover for p in record["pivots"])
    literal_private = tuple(p.private_sets for p in record["pivots"])
    assert replay["private"] == literal_private
    assert replay["private_demand"] == record["private_demand"]
    assert replay["external_capacity"] == record["external_capacity"]
    return {
        "implementation": "independent integer bit masks",
        "agreement": True,
        "F": list(replay["F"]),
        "G": list(replay["G"]),
        "private_demand": replay["private_demand"],
        "external_capacity": replay["external_capacity"],
    }


def deterministic_scan() -> dict[str, Any]:
    primitive_base_count_by_n: dict[str, int] = {}
    tested_scaled_records_by_n: dict[str, int] = {}
    primitive_bases_before_failure = 0
    scaled_records_tested = 0
    failure: dict[str, Any] | None = None
    last_passing_primitive_bases: list[list[int]] = []

    for n in range(2, 7):
        primitive_n = 0
        scaled_n = 0
        for base in itertools.combinations(range(1, 15), n):
            if gcd_all(base) != 1:
                continue
            primitive_n += 1
            for scale in SCALES:
                speeds = tuple(scale * x for x in base)
                record = compute_tuple(speeds)
                scaled_records_tested += 1
                scaled_n += 1
                if not record["inequality_holds"]:
                    failure_scalings = []
                    for diagnostic_scale in (2, 3):
                        diagnostic_tuple = tuple(diagnostic_scale * x for x in base)
                        diagnostic_record = compute_tuple(diagnostic_tuple)
                        assert not diagnostic_record["inequality_holds"]
                        failure_scalings.append(
                            {
                                "scale": diagnostic_scale,
                                "tuple": list(diagnostic_tuple),
                                "G": list(diagnostic_record["G"]),
                                "private_demand": diagnostic_record["private_demand"],
                                "external_capacity": diagnostic_record["external_capacity"],
                                "deficit": diagnostic_record["private_demand"]
                                - diagnostic_record["external_capacity"],
                            }
                        )
                    failure = {
                        "primitive_base": list(base),
                        "scale": scale,
                        "scaled_tuple": list(speeds),
                        "primitive_base_ordinal_overall_one_based": primitive_bases_before_failure + 1,
                        "primitive_base_ordinal_within_n_one_based": primitive_n,
                        "scaled_record_ordinal_overall_one_based": scaled_records_tested,
                        "full_record": tuple_to_json(record, full_bad=True),
                        "independent_replay": verify_literal_vs_bitmask(record),
                        "post_stop_common_scaling_diagnostics": failure_scalings,
                    }
                    break
            if failure is not None:
                break
            primitive_bases_before_failure += 1
            last_passing_primitive_bases.append(list(base))
            last_passing_primitive_bases = last_passing_primitive_bases[-5:]
        primitive_base_count_by_n[str(n)] = primitive_n
        tested_scaled_records_by_n[str(n)] = scaled_n
        if failure is not None:
            break

    assert failure is not None, "frozen domain unexpectedly contained no failure"
    return {
        "domain": {
            "n_values": [2, 3, 4, 5, 6],
            "primitive_base_tuples": "positive strictly increasing tuples with gcd 1",
            "maximum_primitive_speed": 14,
            "base_order": "n ascending, then itertools.combinations lexicographic order",
            "scale_order_per_base": [1, 2, 3],
            "residue_order": "increasing representative 0 <= r < (n+1)*a_j",
            "owner_order": "increasing speed value; owner identities retained",
            "canonical_cover_order": "(|C|, increasing owner-speed list), lexicographic",
            "stop_rule": "first scaled tuple with PrivateDemand > ExternalCapacity",
        },
        "primitive_base_count_by_n_through_stop": primitive_base_count_by_n,
        "tested_scaled_records_by_n_through_stop": tested_scaled_records_by_n,
        "primitive_bases_before_failure": primitive_bases_before_failure,
        "scaled_records_tested_through_failure": scaled_records_tested,
        "last_five_passing_primitive_bases": last_passing_primitive_bases,
        "first_failure": failure,
        "status": "computed finite evidence",
    }


def fixture_transport_checks(records: dict[tuple[int, ...], dict[str, Any]]) -> dict[str, Any]:
    # (1,3,4): raw centered quotients from the sole canonical owner at pivot 1.
    a = (1, 3, 4)
    rec = records[a]
    pivot1 = rec["pivots"][0]
    assert pivot1.canonical_cover == (2,)
    raw = []
    for r in pivot1.private_sets[2] if pivot1.private_sets else ():
        q, e = centered_bad_equation(a, 0, 2, r)
        raw.append(
            {
                "private_r": r,
                "owner_speed": 4,
                "q": q,
                "e": e,
                "q_in_Q_speed_3": q in rec["pivots"][1].good_residues,
                "q_in_Q_speed_4": q in rec["pivots"][2].good_residues,
            }
        )
    assert all(not row["q_in_Q_speed_3"] and not row["q_in_Q_speed_4"] for row in raw)

    # (1,3,4,5): exact quotient-zero and nontransport of target badness.
    b = (1, 3, 4, 5)
    recb = records[b]
    pivot3 = recb["pivots"][1]
    owner1 = 0
    owner5 = 3
    assert 1 in (pivot3.private_sets or {})[owner1]
    q0, e0 = centered_bad_equation(b, 1, owner1, 1)
    assert (q0, e0) == (0, 1) and q0 % 5 == 0
    assert 13 in (pivot3.private_sets or {})[owner1]
    q1, e1 = centered_bad_equation(b, 1, owner1, 13)
    assert (q1, e1) == (1, -2)
    pivot1b = recb["pivots"][0]
    assert q1 in pivot1b.candidates
    assert q1 in pivot1b.bad_sets[owner5]
    assert 13 not in pivot3.bad_sets[owner5]

    return {
        "tuple_1_3_4_raw_centered_quotient_transport": raw,
        "tuple_1_3_4_scope_note": (
            "The frozen Prompt 76 text does not define Response69's full nearest-boundary "
            "target map. The exact raw centered-quotient candidates q=1,2,3 all fail to "
            "land in either external good set; no stronger unnamed map is inferred."
        ),
        "tuple_1_3_4_5_exact_failures": {
            "quotient_zero_excluded": {
                "private_r": 1,
                "source_pivot_speed": 3,
                "owner_speed": 1,
                "q": q0,
                "e": e0,
                "N_divides_q": True,
            },
            "target_badness_does_not_transport_back": {
                "private_r": 13,
                "source_equation": "13*1=1*15+(-2)",
                "target_pivot_speed": 1,
                "target_residue": 1,
                "target_owner_speed": 5,
                "target_bad": True,
                "source_owner_5_bad_at_r_13": False,
                "source_rho": rho(15, 13 * 5),
                "source_threshold": 3,
            },
        },
    }


def mandatory_fixture_suite() -> dict[str, Any]:
    records = {a: compute_tuple(a) for a in MANDATORY_FIXTURES}

    # Exact named regression assertions.
    expected_G = {
        (1, 3, 4): (0, 2, 2),
        (1, 3, 4, 5): (0, 0, 2, 2),
        (1, 2, 3, 5): (0, 0, 2, 2),
        (1, 6, 11, 12, 13): (0, 0, 8, 8, 10),
        (1, 2, 8): (0, 0, 6),
        (1, 2, 3, 4, 5, 7): (0, 0, 0, 0, 2, 2),
        (1, 3, 13): (3, 5, 9),
    }
    for a, G in expected_G.items():
        assert records[a]["G"] == G

    # Exact partition at (1,2,3,5), pivot speed 2.
    a = (1, 2, 3, 5)
    p2 = records[a]["pivots"][1]
    assert p2.canonical_cover == (0, 2, 3)
    private_partition = tuple((p2.private_sets or {})[i] for i in p2.canonical_cover)
    assert private_partition == ((1, 9), (3, 7), (2, 4, 6, 8))
    assert set().union(*(set(x) for x in private_partition)) == set(p2.candidates)
    assert sum(len(x) for x in private_partition) == len(p2.candidates)
    assert all(math.gcd(a[i], a[1]) == 1 for i in p2.canonical_cover)

    # Least-owner selector cycle at (1,6,11,12,13).
    a = (1, 6, 11, 12, 13)
    reca = records[a]
    assert reca["pivots"][0].canonical_cover == (1,)
    assert reca["pivots"][1].canonical_cover == (0, 2, 3, 4)
    selector_cycle = {
        "pivot_speed_1_least_owner": 6,
        "pivot_speed_6_least_owner": 1,
        "cycle": [1, 6, 1],
        "cover_key_speed_1": [1, [6]],
        "cover_key_speed_6": [4, [1, 11, 12, 13]],
        "strict_key_decrease_around_cycle": False,
    }

    # Sole destination at (1,2,8).
    a = (1, 2, 8)
    assert records[a]["F"] == (0, 1)
    assert records[a]["outside_F"] == (2,)
    assert records[a]["pivots"][0].canonical_cover == (2,)
    assert records[a]["pivots"][1].canonical_cover == (2,)

    # Four covered and two uncovered at the six-speed fixture.
    a = (1, 2, 3, 4, 5, 7)
    assert records[a]["F"] == (0, 1, 2, 3)
    assert sum(records[a]["G"]) == 4 < len(a)

    # Coincident bad sets retain owners.
    a = (1, 3, 13)
    p3 = records[a]["pivots"][1]
    assert p3.bad_sets[0] == p3.bad_sets[2] == frozenset((1, 2, 10, 11))

    boundary = {
        "rho_p_minus_1_bad": rho(12, 2) < 3,
        "rho_p_safe": rho(12, 3) >= 3,
        "N_multiple_excluded": 8 % 4 == 0,
        "negative_side_p_minus_1_bad": rho(12, 10) < 3,
        "negative_side_p_safe": rho(12, 9) >= 3,
        "reflection_fixed_antipode": (-6) % 12 == 6,
        "antipode_counted_once": list(range(12)).count(6) == 1,
        "nonunit_example_gcd_4_6": math.gcd(4, 6) == 2,
        "nonunit_example_gcd_12_36": math.gcd(12, 36) == 12,
    }
    assert all(boundary.values())

    # n=2 exact fixture.
    n2 = compute_tuple((1, 3))
    assert n2["F"] == (0,) and n2["G"] == (0, 2)
    assert n2["pivots"][0].private_sets == {1: (1, 2)}
    assert n2["private_demand"] == 2 and n2["external_capacity"] == 6

    # Common scaling by 2 and 3 for every mandatory fixture.
    scaling = []
    for base in MANDATORY_FIXTURES:
        base_record = records[base]
        for c in (2, 3):
            scaled = tuple(c * x for x in base)
            scaled_record = compute_tuple(scaled)
            assert scaled_record["F"] == base_record["F"]
            assert scaled_record["G"] == tuple(c * g for g in base_record["G"])
            assert scaled_record["private_demand"] == c * base_record["private_demand"]
            assert scaled_record["external_capacity"] == c * base_record["external_capacity"]
            assert tuple(
                None
                if p.canonical_cover is None
                else tuple(scaled[i] for i in p.canonical_cover)
                for p in scaled_record["pivots"]
            ) == tuple(
                None
                if p.canonical_cover is None
                else tuple(c * base[i] for i in p.canonical_cover)
                for p in base_record["pivots"]
            )
            scaling.append(
                {
                    "base": list(base),
                    "factor": c,
                    "scaled": list(scaled),
                    "base_G": list(base_record["G"]),
                    "scaled_G": list(scaled_record["G"]),
                    "base_private_demand": base_record["private_demand"],
                    "scaled_private_demand": scaled_record["private_demand"],
                    "base_external_capacity": base_record["external_capacity"],
                    "scaled_external_capacity": scaled_record["external_capacity"],
                    "canonical_owner_labels_scale": True,
                    "weights_invariant": True,
                }
            )

    return {
        "fixtures": [tuple_to_json(records[a], full_bad=True) for a in MANDATORY_FIXTURES],
        "transport_failures": fixture_transport_checks(records),
        "partition_at_tuple_1_2_3_5_pivot_2": {
            "owner_speed_1": list(private_partition[0]),
            "owner_speed_3": list(private_partition[1]),
            "owner_speed_5": list(private_partition[2]),
            "exact_disjoint_partition": True,
            "all_selected_owners_coprime_to_pivot": True,
        },
        "least_owner_selector_cycle": selector_cycle,
        "boundary_and_nonunit_checks": boundary,
        "n_equals_2": tuple_to_json(n2, full_bad=True),
        "scaling_checks": scaling,
        "status": "computed finite evidence",
    }


def lcm_1_to(m: int) -> int:
    out = 1
    for value in range(1, m + 1):
        out = math.lcm(out, value)
    return out


def symbolic_family_samples() -> dict[str, Any]:
    samples: list[dict[str, Any]] = []
    for n in range(2, 9):
        N = n + 1
        ell = lcm_1_to(n - 1)
        for m in (1, 2, 3):
            L = m * N * ell
            speeds = tuple(range(1, n)) + (L,)
            record = compute_tuple(speeds)
            assert record["F"] == tuple(range(n - 1))
            assert record["outside_F"] == (n - 1,)
            for j in range(n - 1):
                assert record["pivots"][j].canonical_cover == (n - 1,)
            T = L // (n - 1)
            declared_block = tuple(L + t for t in range(1, T + 1) if t % N != 0)
            assert all(r in record["pivots"][n - 1].good_residues for r in declared_block)
            assert record["inequality_holds"]
            samples.append(
                {
                    "n": n,
                    "N": N,
                    "m": m,
                    "lcm_1_to_n_minus_1": ell,
                    "L": L,
                    "speeds": list(speeds),
                    "F_speeds": list(speeds[:-1]),
                    "G_last": record["G"][-1],
                    "declared_good_block_size": len(declared_block),
                    "declared_good_block_lower_bound_formula": n * m * ell // (n - 1),
                    "private_demand": record["private_demand"],
                    "external_capacity": record["external_capacity"],
                    "inequality_holds": True,
                }
            )
    return {
        "family": "(1,2,...,n-1,m*(n+1)*lcm(1,...,n-1))",
        "sample_domain": "2 <= n <= 8 and m in {1,2,3}",
        "samples": samples,
        "status": "computed finite evidence; symbolic proof is in the accompanying memo",
    }


def canonical_json_bytes(payload: dict[str, Any]) -> bytes:
    return (json.dumps(payload, indent=2, sort_keys=True) + "\n").encode("utf-8")


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1 << 20), b""):
            digest.update(chunk)
    return digest.hexdigest()


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args(argv)

    source_path = Path(__file__).resolve()
    scan = deterministic_scan()
    fixtures = mandatory_fixture_suite()
    family = symbolic_family_samples()

    payload: dict[str, Any] = {
        "schema": SCHEMA,
        "metadata": {
            "language": "Python",
            "implementation": platform.python_implementation(),
            "python_version": platform.python_version(),
            "platform": platform.platform(),
            "standard_library_only": True,
            "arithmetic": "exact arbitrary-precision integers",
            "source_filename": source_path.name,
            "source_sha256": sha256_file(source_path),
            "command": f"python3 {source_path.name} --output {args.output.name}",
            "malformed_input_behavior": (
                "argparse usage and exit status 2; filesystem failures are nonzero"
            ),
            "recovered_attachments_executed": False,
        },
        "frozen_definitions": {
            "rho": "min(x mod M, M-(x mod M))",
            "R_j": "0 <= r < (n+1)*a_j and (n+1) does not divide r",
            "B_i_j": "r in R_j and rho_(M_j)(r*a_i) < a_j",
            "Q_j": "R_j minus the owner-indexed bad-set union",
            "canonical_cover_order": "(|C|, increasing owner-speed list), lexicographic",
            "privacy": "relative to selected canonical cover; omitted owners ignored",
            "weight": "a_k // gcd(a_j,a_k)",
        },
        "execution_order": [
            "deterministic_scan_until_first_failure",
            "mandatory_fixture_replay",
            "symbolic_family_finite_samples",
        ],
        "scan": scan,
        "mandatory_fixture_suite": fixtures,
        "symbolic_family_samples": family,
        "final_disposition": "STOP",
        "global_inequality_status": "rejected",
    }
    args.output.write_bytes(canonical_json_bytes(payload))
    print(
        json.dumps(
            {
                "output": str(args.output),
                "source_sha256": payload["metadata"]["source_sha256"],
                "output_sha256": sha256_file(args.output),
                "first_failure": scan["first_failure"]["scaled_tuple"],
                "private_demand": scan["first_failure"]["full_record"]["private_demand"],
                "external_capacity": scan["first_failure"]["full_record"]["external_capacity"],
            },
            sort_keys=True,
        )
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
