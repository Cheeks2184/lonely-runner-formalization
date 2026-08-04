#!/usr/bin/env python3
"""Independent replay of Prompt 76's first counterexample certificate.

This program intentionally imports no code from p76_global_private_deficit_scan.py.
It uses bit masks, a separate canonical-cover enumeration, and hard-coded
expected owner-labelled private sets for a=(1,4,5,6,7,11). It exits nonzero on
any mismatch.

Malformed command line behavior: argparse prints usage and exits with status 2.
"""

from __future__ import annotations

import argparse
import hashlib
import itertools
import json
import math
import platform
from pathlib import Path
from typing import Sequence

SPEEDS = (1, 4, 5, 6, 7, 11)
EXPECTED_F = (0, 1, 2, 5)
EXPECTED_G = (0, 0, 0, 2, 2, 0)
EXPECTED_Q = {
    0: (),
    1: (),
    2: (),
    3: (13, 29),
    4: (15, 34),
    5: (),
}
EXPECTED_COVERS = {
    0: (4,),
    1: (0, 2, 3, 4, 5),
    2: (0, 1, 3, 4, 5),
    5: (0, 1, 2, 3, 4),
}
EXPECTED_PRIVATE = {
    0: {
        4: (1, 2, 3, 4, 5, 6),
    },
    1: {
        0: (1, 2, 3, 25, 26, 27),
        2: (6, 11, 17, 22),
        3: (9, 19),
        4: (4, 8, 12, 16, 20, 24),
        5: (10, 13, 15, 18),
    },
    2: {
        0: (2, 4, 31, 33),
        1: (8, 9, 26, 27),
        3: (11, 12, 23, 24),
        4: (5, 10, 15, 20, 25, 30),
        5: (13, 16, 19, 22),
    },
    5: {
        0: (3, 4, 5, 6, 8, 9, 68, 69, 71, 72, 73, 74),
        1: (18, 19, 20, 36, 41, 57, 58, 59),
        2: (15, 16, 29, 30, 31, 46, 47, 48, 61, 62),
        3: (13, 24, 25, 26, 27, 50, 51, 52, 53, 64),
        4: (11, 22, 23, 33, 34, 43, 44, 54, 55, 66),
    },
}


def rho(modulus: int, value: int) -> int:
    residue = value % modulus
    return min(residue, modulus - residue)


def values(mask: int, limit: int) -> tuple[int, ...]:
    return tuple(r for r in range(limit) if (mask >> r) & 1)


def make_mask(items) -> int:
    mask = 0
    for item in items:
        mask |= 1 << item
    return mask


def replay_pivot(speeds: Sequence[int], pivot: int) -> dict:
    n = len(speeds)
    N = n + 1
    p = speeds[pivot]
    M = N * p
    R = make_mask(r for r in range(M) if r % N != 0)
    bad = {}
    for owner, speed in enumerate(speeds):
        if owner == pivot:
            continue
        bad[owner] = make_mask(
            r for r in range(M) if ((R >> r) & 1) and rho(M, r * speed) < p
        )
    union = 0
    for mask in bad.values():
        union |= mask
    Q = values(R & ~union, M)

    cover = None
    private = None
    if not Q:
        owners = tuple(sorted(bad, key=lambda i: speeds[i]))
        for size in range(len(owners) + 1):
            complete = []
            for candidate in itertools.combinations(owners, size):
                covered = 0
                for owner in candidate:
                    covered |= bad[owner]
                if covered == R:
                    complete.append(candidate)
            if complete:
                cover = min(complete, key=lambda C: tuple(speeds[i] for i in C))
                break
        assert cover is not None
        private = {}
        for owner in cover:
            other_union = 0
            for other in cover:
                if other != owner:
                    other_union |= bad[other]
            private[owner] = values(bad[owner] & ~other_union & R, M)
            assert private[owner]

    return {
        "pivot": pivot,
        "pivot_speed": p,
        "M": M,
        "Q": Q,
        "G": len(Q),
        "cover": cover,
        "private": private,
    }


def sha256_file(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()

    rows = tuple(replay_pivot(SPEEDS, j) for j in range(len(SPEEDS)))
    F = tuple(j for j, row in enumerate(rows) if row["G"] == 0)
    G = tuple(row["G"] for row in rows)
    assert F == EXPECTED_F
    assert G == EXPECTED_G
    assert {j: rows[j]["Q"] for j in range(len(SPEEDS))} == EXPECTED_Q
    assert {j: rows[j]["cover"] for j in F} == EXPECTED_COVERS
    assert {j: rows[j]["private"] for j in F} == EXPECTED_PRIVATE

    private_by_pivot = {
        SPEEDS[j]: sum(len(points) for points in EXPECTED_PRIVATE[j].values())
        for j in F
    }
    private_demand = sum(private_by_pivot.values())
    outside = tuple(k for k in range(len(SPEEDS)) if k not in F)
    capacity_terms = []
    external_capacity = 0
    for j in F:
        for k in outside:
            divisor = math.gcd(SPEEDS[j], SPEEDS[k])
            weight = SPEEDS[k] // divisor
            value = weight * G[k]
            external_capacity += value
            capacity_terms.append(
                {
                    "source_speed": SPEEDS[j],
                    "destination_speed": SPEEDS[k],
                    "gcd": divisor,
                    "weight": weight,
                    "G": G[k],
                    "value": value,
                }
            )

    assert private_by_pivot == {1: 6, 4: 22, 5: 22, 11: 50}
    assert private_demand == 100
    assert external_capacity == 98
    assert private_demand > external_capacity

    payload = {
        "schema": "p76-global-private-deficit-independent-replay/v1",
        "metadata": {
            "language": "Python",
            "implementation": platform.python_implementation(),
            "python_version": platform.python_version(),
            "platform": platform.platform(),
            "standard_library_only": True,
            "arithmetic": "exact arbitrary-precision integers and bit masks",
            "imports_scan_implementation": False,
            "source_sha256": sha256_file(Path(__file__).resolve()),
            "malformed_input_behavior": "argparse usage and exit status 2",
        },
        "speeds": list(SPEEDS),
        "N": len(SPEEDS) + 1,
        "F_indices": list(F),
        "F_speeds": [SPEEDS[j] for j in F],
        "G": list(G),
        "Q_by_pivot_speed": {str(SPEEDS[j]): list(rows[j]["Q"]) for j in range(len(SPEEDS))},
        "canonical_covers_by_pivot_speed": {
            str(SPEEDS[j]): [SPEEDS[i] for i in rows[j]["cover"]] for j in F
        },
        "private_sets_by_pivot_and_owner_speed": {
            str(SPEEDS[j]): {
                str(SPEEDS[i]): list(points)
                for i, points in EXPECTED_PRIVATE[j].items()
            }
            for j in F
        },
        "private_demand_by_pivot_speed": {
            str(key): value for key, value in private_by_pivot.items()
        },
        "private_demand": private_demand,
        "capacity_terms": capacity_terms,
        "external_capacity": external_capacity,
        "inequality_holds": False,
        "deficit": private_demand - external_capacity,
        "replay_passed": True,
    }
    data = (json.dumps(payload, indent=2, sort_keys=True) + "\n").encode("utf-8")
    args.output.write_bytes(data)
    print(
        json.dumps(
            {
                "output": str(args.output),
                "source_sha256": payload["metadata"]["source_sha256"],
                "output_sha256": sha256_file(args.output),
                "replay_passed": True,
            },
            sort_keys=True,
        )
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
