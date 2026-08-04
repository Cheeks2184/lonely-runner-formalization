#!/usr/bin/env python3
"""Exact finite falsification suite for Prompt 72: MODULAR-COVER-CIRCUIT-ESCAPE.

The arithmetic is integer-only.  The scan domain and ordering are frozen:
primitive strictly increasing tuples, n=2..6, largest speed <=12; tuples are
ordered by n and then lexicographically.  Canonical covers are ordered by
(cardinality, increasing speed list).  Nonempty subsets of F are ordered by
(cardinality, increasing pivot index list).  The scan stops at the first closed
subset, if one exists.
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
from typing import Iterable, Sequence


def rho(modulus: int, x: int) -> int:
    residue = x % modulus
    return min(residue, modulus - residue)


def tuple_gcd(values: Sequence[int]) -> int:
    result = 0
    for value in values:
        result = math.gcd(result, value)
    return result


@dataclass(frozen=True)
class PivotRecord:
    pivot_index: int
    pivot_speed: int
    modulus: int
    residues: tuple[int, ...]
    bad_sets: dict[int, frozenset[int]]
    good_residues: tuple[int, ...]
    canonical_cover: tuple[int, ...] | None
    private_points: dict[int, tuple[int, ...]] | None

    @property
    def covers(self) -> bool:
        return not self.good_residues


def owner_order(speeds: Sequence[int], pivot_index: int) -> list[int]:
    return sorted(
        (i for i in range(len(speeds)) if i != pivot_index),
        key=lambda i: speeds[i],
    )


def canonical_cover(
    speeds: Sequence[int],
    residues: frozenset[int],
    bad_sets: dict[int, frozenset[int]],
    pivot_index: int,
) -> tuple[int, ...] | None:
    owners = owner_order(speeds, pivot_index)
    for size in range(len(owners) + 1):
        complete: list[tuple[int, ...]] = []
        for candidate in itertools.combinations(owners, size):
            union: set[int] = set()
            for owner in candidate:
                union.update(bad_sets[owner])
            if union == residues:
                complete.append(candidate)
        if complete:
            return min(complete, key=lambda c: tuple(speeds[i] for i in c))
    return None


def compute_pivot(speeds: Sequence[int], pivot_index: int) -> PivotRecord:
    n = len(speeds)
    N = n + 1
    p = speeds[pivot_index]
    modulus = N * p
    residues = tuple(r for r in range(modulus) if r % N != 0)
    residue_set = frozenset(residues)

    bad_sets: dict[int, frozenset[int]] = {}
    for owner, owner_speed in enumerate(speeds):
        if owner == pivot_index:
            continue
        bad_sets[owner] = frozenset(
            r for r in residues if rho(modulus, r * owner_speed) < p
        )

    covered: set[int] = set()
    for bad_set in bad_sets.values():
        covered.update(bad_set)
    good_residues = tuple(sorted(residue_set.difference(covered)))

    cover = None
    private = None
    if not good_residues:
        cover = canonical_cover(speeds, residue_set, bad_sets, pivot_index)
        assert cover is not None
        private = {}
        for owner in cover:
            covered_by_others: set[int] = set()
            for other in cover:
                if other != owner:
                    covered_by_others.update(bad_sets[other])
            points = tuple(sorted(bad_sets[owner].difference(covered_by_others)))
            assert points, "minimum-cardinality cover lacks a private point"
            private[owner] = points

    return PivotRecord(
        pivot_index=pivot_index,
        pivot_speed=p,
        modulus=modulus,
        residues=residues,
        bad_sets=bad_sets,
        good_residues=good_residues,
        canonical_cover=cover,
        private_points=private,
    )


def compute_tuple(speeds: Sequence[int]) -> tuple[list[PivotRecord], tuple[int, ...]]:
    pivots = [compute_pivot(speeds, j) for j in range(len(speeds))]
    covered_pivots = tuple(j for j, record in enumerate(pivots) if record.covers)
    return pivots, covered_pivots


def nonempty_subsets_in_frozen_order(values: Sequence[int]) -> Iterable[tuple[int, ...]]:
    for size in range(1, len(values) + 1):
        yield from itertools.combinations(values, size)


def first_closed_subset(
    pivots: Sequence[PivotRecord], covered_pivots: Sequence[int]
) -> tuple[int, ...] | None:
    for subset in nonempty_subsets_in_frozen_order(covered_pivots):
        subset_set = set(subset)
        if all(
            set(pivots[j].canonical_cover or ()).issubset(subset_set)
            for j in subset
        ):
            return subset
    return None


def centered_bad_equation(
    speeds: Sequence[int], pivot_index: int, owner: int, residue: int
) -> tuple[int, int]:
    n = len(speeds)
    N = n + 1
    p = speeds[pivot_index]
    modulus = N * p
    x = residue * speeds[owner]
    u = x % modulus
    if u < p:
        error = u
    elif modulus - u < p:
        error = u - modulus
    else:
        raise ValueError("point is not strictly bad")
    quotient = (x - error) // modulus
    assert x == quotient * modulus + error
    assert abs(error) < p
    return quotient, error


def pivot_to_json(speeds: Sequence[int], record: PivotRecord) -> dict:
    cover_speeds = None
    private_by_speed = None
    centered = None
    if record.canonical_cover is not None:
        cover_speeds = [speeds[i] for i in record.canonical_cover]
        assert record.private_points is not None
        private_by_speed = {
            str(speeds[i]): list(record.private_points[i])
            for i in record.canonical_cover
        }
        centered = {
            str(speeds[i]): [
                {
                    "r": r,
                    "q": centered_bad_equation(speeds, record.pivot_index, i, r)[0],
                    "e": centered_bad_equation(speeds, record.pivot_index, i, r)[1],
                }
                for r in record.private_points[i]
            ]
            for i in record.canonical_cover
        }

    return {
        "pivot_index": record.pivot_index,
        "pivot_speed": record.pivot_speed,
        "modulus": record.modulus,
        "R_size": len(record.residues),
        "G": len(record.good_residues),
        "good_residues": list(record.good_residues),
        "covers": record.covers,
        "canonical_cover_speeds": cover_speeds,
        "private_points_by_owner_speed": private_by_speed,
        "centered_private_equations": centered,
        "bad_sets_by_owner_speed": {
            str(speeds[i]): sorted(points)
            for i, points in sorted(record.bad_sets.items(), key=lambda item: speeds[item[0]])
        },
    }


FIXTURES: tuple[tuple[int, ...], ...] = (
    (1, 3, 4),
    (1, 3, 4, 5),
    (1, 2, 3, 4, 5, 7),
    (1, 6, 11, 12, 13),
    (1, 2, 8),
    (1, 3),
    (1, 2, 3),
    (1, 3, 5),
    (1, 3, 13),
)

EXPECTED_G = {
    (1, 3, 4): [0, 2, 2],
    (1, 3, 4, 5): [0, 0, 2, 2],
    (1, 2, 3, 4, 5, 7): [0, 0, 0, 0, 2, 2],
    (1, 6, 11, 12, 13): [0, 0, 8, 8, 10],
    (1, 2, 8): [0, 0, 6],
    (1, 3): [0, 2],
    (1, 2, 3): [2, 2, 2],
}

EXPECTED_COVERS = {
    (1, 3, 4): {1: (4,)},
    (1, 3, 4, 5): {1: (5,), 3: (1, 4, 5)},
    (1, 2, 3, 4, 5, 7): {
        1: (7,),
        2: (1, 3, 5, 7),
        3: (1, 4, 5, 7),
        4: (1, 2, 3, 5, 7),
    },
    (1, 6, 11, 12, 13): {1: (6,), 6: (1, 11, 12, 13)},
    (1, 2, 8): {1: (8,), 2: (8,)},
    (1, 3): {1: (3,)},
}


def canonical_map_by_speed(
    speeds: Sequence[int], pivots: Sequence[PivotRecord]
) -> dict[int, tuple[int, ...]]:
    result: dict[int, tuple[int, ...]] = {}
    for record in pivots:
        if record.canonical_cover is not None:
            result[record.pivot_speed] = tuple(
                speeds[i] for i in record.canonical_cover
            )
    return result


def tuple_signature_by_speed(speeds: Sequence[int]) -> dict[int, dict]:
    pivots, _ = compute_tuple(speeds)
    signature: dict[int, dict] = {}
    for record in pivots:
        signature[record.pivot_speed] = {
            "G": len(record.good_residues),
            "Q": record.good_residues,
            "cover": None
            if record.canonical_cover is None
            else tuple(speeds[i] for i in record.canonical_cover),
            "bad_sets": {
                speeds[i]: tuple(sorted(points)) for i, points in record.bad_sets.items()
            },
        }
    return signature


def validate_fixtures() -> tuple[list[dict], dict]:
    fixture_output: list[dict] = []
    for speeds in FIXTURES:
        pivots, covered = compute_tuple(speeds)
        closed = first_closed_subset(pivots, covered)

        if speeds in EXPECTED_G:
            assert [len(record.good_residues) for record in pivots] == EXPECTED_G[speeds]
        if speeds in EXPECTED_COVERS:
            assert canonical_map_by_speed(speeds, pivots) == EXPECTED_COVERS[speeds]

        fixture_output.append(
            {
                "speeds": list(speeds),
                "n": len(speeds),
                "N": len(speeds) + 1,
                "F_pivot_speeds": [speeds[j] for j in covered],
                "first_closed_subset_pivot_speeds": None
                if closed is None
                else [speeds[j] for j in closed],
                "pivots": [pivot_to_json(speeds, record) for record in pivots],
            }
        )

    # Fixture 3 exact good residues.
    p3, _ = compute_tuple((1, 2, 3, 4, 5, 7))
    by_speed3 = {record.pivot_speed: record for record in p3}
    assert by_speed3[5].good_residues == (6, 29)
    assert by_speed3[7].good_residues == (8, 41)

    # Fixture 4: false least-owner cycle, but full circuit escape.
    speeds4 = (1, 6, 11, 12, 13)
    p4, f4 = compute_tuple(speeds4)
    by_speed4 = {record.pivot_speed: record for record in p4}
    c1 = tuple(speeds4[i] for i in by_speed4[1].canonical_cover or ())
    c6 = tuple(speeds4[i] for i in by_speed4[6].canonical_cover or ())
    assert c1 == (6,) and c6 == (1, 11, 12, 13)
    assert min(c1) == 6 and min(c6) == 1
    assert any(owner not in {1, 6} for owner in c6)

    # Fixture 5: both covered circuits escape to the sole good pivot.
    speeds5 = (1, 2, 8)
    p5, f5 = compute_tuple(speeds5)
    assert [speeds5[j] for j in f5] == [1, 2]
    assert canonical_map_by_speed(speeds5, p5) == {1: (8,), 2: (8,)}

    # Fixture 6: n=2 reflection pair.
    speeds6 = (1, 3)
    p6, _ = compute_tuple(speeds6)
    by_speed6 = {record.pivot_speed: record for record in p6}
    assert by_speed6[3].good_residues == (4, 5)
    assert tuple(sorted(((-r) % 9) for r in by_speed6[3].good_residues)) == (4, 5)

    # Fixture 7: strict boundary at pivot speed 3.
    speeds7 = (1, 2, 3)
    p7, _ = compute_tuple(speeds7)
    pivot3 = next(record for record in p7 if record.pivot_speed == 3)
    owner1 = speeds7.index(1)
    assert rho(pivot3.modulus, 2 * 1) == 2  # p-1, bad
    assert 2 in pivot3.bad_sets[owner1]
    assert rho(pivot3.modulus, 3 * 1) == 3  # equality, safe
    assert 3 not in pivot3.bad_sets[owner1]
    assert 3 in pivot3.good_residues

    # Fixture 8: all-odd half-time fixed points are single fixed orbits and safe.
    speeds8 = (1, 3, 5)
    p8, _ = compute_tuple(speeds8)
    antipodes = {}
    for record in p8:
        half = record.modulus // 2
        assert record.modulus % 2 == 0
        assert half in record.residues
        assert (-half) % record.modulus == half
        assert half in record.good_residues
        antipodes[str(record.pivot_speed)] = half

    # Fixture 9: coincident sets retain distinct owner labels.
    speeds9 = (1, 3, 13)
    p9, _ = compute_tuple(speeds9)
    pivot3_9 = next(record for record in p9 if record.pivot_speed == 3)
    owner1_9 = speeds9.index(1)
    owner13_9 = speeds9.index(13)
    assert owner1_9 != owner13_9
    assert pivot3_9.bad_sets[owner1_9] == pivot3_9.bad_sets[owner13_9]
    assert len(pivot3_9.bad_sets) == 2

    checks = {
        "fixture_3_good_residues": True,
        "fixture_4_false_single_owner_cycle": {
            "least_owner_edges": [[1, 6], [6, 1]],
            "full_circuit_at_6": list(c6),
            "full_circuit_escapes_F": True,
        },
        "fixture_5_sole_good_pivot_escape": True,
        "fixture_6_reflection_pair": [4, 5],
        "fixture_7_strict_boundary": {
            "rho_p_minus_1_is_bad": True,
            "rho_equal_p_is_safe": True,
        },
        "fixture_8_safe_half_time_fixed_points": antipodes,
        "fixture_9_coincident_sets_distinct_labels": {
            "pivot_speed": 3,
            "owner_speeds": [1, 13],
            "common_bad_set": sorted(pivot3_9.bad_sets[owner1_9]),
        },
    }
    return fixture_output, checks


def validate_general_regressions() -> dict:
    # r=0 and every multiple of N are excluded; pivot coordinate is safe.
    exclusion_count = 0
    pivot_safety_count = 0
    reflection_count = 0
    for speeds in FIXTURES:
        N = len(speeds) + 1
        pivots, _ = compute_tuple(speeds)
        for record in pivots:
            assert 0 not in record.residues
            for r in range(record.modulus):
                assert (r in record.residues) == (r % N != 0)
                exclusion_count += 1
            p = record.pivot_speed
            for r in record.residues:
                assert rho(record.modulus, r * p) >= p
                pivot_safety_count += 1
                reflected = (-r) % record.modulus
                assert reflected in record.residues
                assert (r in record.good_residues) == (reflected in record.good_residues)
                for bad_set in record.bad_sets.values():
                    assert (r in bad_set) == (reflected in bad_set)
                reflection_count += 1

    # Every permutation of fixtures 1--4 preserves the speed-labelled data.
    permutation_checks = 0
    for base in FIXTURES[:4]:
        expected = tuple_signature_by_speed(base)
        for permuted in itertools.permutations(base):
            assert tuple_signature_by_speed(permuted) == expected
            permutation_checks += 1

    # Common scaling: canonical owner speeds scale, Q repeats by the old modulus,
    # and G scales by the common factor.
    scaling_checks = 0
    for base in FIXTURES:
        base_pivots, _ = compute_tuple(base)
        base_by_speed = {record.pivot_speed: record for record in base_pivots}
        for factor in (2, 3):
            scaled = tuple(factor * x for x in base)
            scaled_pivots, _ = compute_tuple(scaled)
            scaled_by_speed = {record.pivot_speed: record for record in scaled_pivots}
            for p, record in base_by_speed.items():
                scaled_record = scaled_by_speed[factor * p]
                assert len(scaled_record.good_residues) == factor * len(record.good_residues)
                expected_q = tuple(
                    sorted(
                        q + lift * record.modulus
                        for lift in range(factor)
                        for q in record.good_residues
                    )
                )
                assert scaled_record.good_residues == expected_q
                base_cover = None if record.canonical_cover is None else tuple(
                    base[i] for i in record.canonical_cover
                )
                scaled_cover = None if scaled_record.canonical_cover is None else tuple(
                    scaled[i] for i in scaled_record.canonical_cover
                )
                assert scaled_cover == (
                    None if base_cover is None else tuple(factor * x for x in base_cover)
                )
                scaling_checks += 1

    # Explicit nondividing and nontrivial-gcd cases.
    nondividing = {
        "speeds": [1, 3, 4, 5],
        "pivot_speed": 3,
        "owner_speed": 4,
        "modulus": 15,
        "gcd_owner_modulus": math.gcd(4, 15),
    }
    assert nondividing["gcd_owner_modulus"] == 1

    nontrivial_gcd = {
        "speeds": [1, 6, 11, 12, 13],
        "pivot_speed": 6,
        "owner_speed": 12,
        "modulus": 36,
        "gcd_owner_modulus": math.gcd(12, 36),
    }
    assert nontrivial_gcd["gcd_owner_modulus"] == 12

    # Two exact failures of the naive circuit-elimination transport.
    speeds = (1, 3, 4, 5)
    pivots, _ = compute_tuple(speeds)
    by_speed = {record.pivot_speed: record for record in pivots}
    pivot3 = by_speed[3]
    owner1 = speeds.index(1)
    owner5 = speeds.index(5)
    assert 13 in (pivot3.private_points or {})[owner1]
    q, e = centered_bad_equation(speeds, speeds.index(3), owner1, 13)
    assert (q, e) == (1, -2)
    pivot1 = by_speed[1]
    assert q in pivot1.residues
    assert q in pivot1.bad_sets[owner5]
    assert 13 not in pivot3.bad_sets[owner5]

    q0, e0 = centered_bad_equation(speeds, speeds.index(3), owner1, 1)
    assert (q0, e0) == (0, 1)
    assert q0 % (len(speeds) + 1) == 0

    return {
        "r_zero_and_N_multiples_excluded_checks": exclusion_count,
        "pivot_coordinate_safe_checks": pivot_safety_count,
        "reflection_invariance_checks": reflection_count,
        "permutations_of_fixtures_1_to_4_checked": permutation_checks,
        "common_scaling_pivot_checks": scaling_checks,
        "nondividing_pair": nondividing,
        "nontrivial_gcd_pair": nontrivial_gcd,
        "naive_elimination_failures": {
            "quotient_not_in_target_R": {
                "speeds": list(speeds),
                "source_pivot_speed": 3,
                "eliminated_owner_speed": 1,
                "private_r": 1,
                "q": q0,
                "e": e0,
                "N_divides_q": True,
            },
            "badness_does_not_transport": {
                "speeds": list(speeds),
                "source_pivot_speed": 3,
                "eliminated_owner_speed": 1,
                "private_r": 13,
                "source_equation": "13*1 = 1*15 - 2",
                "target_pivot_speed": 1,
                "replacement_owner_speed": 5,
                "target_equation": "1*5 = 1*5 + 0",
                "original_modulus_check": {
                    "13*5_mod_15": (13 * 5) % 15,
                    "rho": rho(15, 13 * 5),
                    "strict_bad_threshold": 3,
                    "is_bad": False,
                },
            },
        },
    }


def run_frozen_scan() -> dict:
    examined_by_n: dict[str, int] = {}
    total = 0
    failure = None

    for n in range(2, 7):
        examined = 0
        for speeds in itertools.combinations(range(1, 13), n):
            if tuple_gcd(speeds) != 1:
                continue
            examined += 1
            total += 1
            pivots, covered = compute_tuple(speeds)
            closed = first_closed_subset(pivots, covered)
            if closed is not None:
                failure = {
                    "speeds": list(speeds),
                    "F_pivot_indices": list(covered),
                    "F_pivot_speeds": [speeds[j] for j in covered],
                    "closed_subset_indices": list(closed),
                    "closed_subset_speeds": [speeds[j] for j in closed],
                    "pivots": [pivot_to_json(speeds, record) for record in pivots],
                }
                break
        examined_by_n[str(n)] = examined
        if failure is not None:
            break

    return {
        "domain": {
            "n": [2, 3, 4, 5, 6],
            "speeds": "primitive strictly increasing positive integer tuples",
            "largest_speed_at_most": 12,
            "tuple_order": "n, then lexicographic",
            "pivot_order": "natural index order (equal to speed order in scan domain)",
            "canonical_cover_order": "(|C|, increasing owner-speed list), lexicographic",
            "subset_order": "cardinality, then lexicographic pivot-index list",
            "early_stop": "first nonempty closed subset",
        },
        "examined_by_n": examined_by_n,
        "total_examined": total,
        "first_closed_subset": failure,
        "result_status": "computed finite evidence",
    }


def canonical_json_bytes(payload: dict) -> bytes:
    return (json.dumps(payload, indent=2, sort_keys=True) + "\n").encode("utf-8")


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", required=True, type=Path)
    args = parser.parse_args()

    fixtures, fixture_checks = validate_fixtures()
    regressions = validate_general_regressions()
    scan = run_frozen_scan()

    payload = {
        "metadata": {
            "language": "Python",
            "python_version": platform.python_version(),
            "implementation": platform.python_implementation(),
            "platform": platform.platform(),
            "integer_arithmetic": "exact arbitrary-precision integers",
            "script_argv": sys.argv,
            "schema": {
                "fixtures": "full pivot records for the mandatory tuples",
                "fixture_checks": "named regression assertions",
                "general_regressions": "boundary, symmetry, permutation, scaling, gcd, and elimination assertions",
                "frozen_scan": "domain metadata, counts, and first failure certificate or null",
            },
        },
        "fixtures": fixtures,
        "fixture_checks": fixture_checks,
        "general_regressions": regressions,
        "frozen_scan": scan,
    }

    data = canonical_json_bytes(payload)
    args.output.write_bytes(data)
    print(f"wrote {args.output}")
    print(f"bytes={len(data)}")
    print(f"sha256={hashlib.sha256(data).hexdigest()}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
