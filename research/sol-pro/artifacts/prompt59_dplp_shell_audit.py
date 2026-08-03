#!/usr/bin/env python3
"""Exact DPLP shell-surplus audit for Prompt 59.

Python 3.13.5, standard library only, deterministic lexicographic enumeration.
No randomness and no heuristic pruning.
"""

from itertools import combinations
from math import gcd
from functools import reduce
import platform
import time


def rho(M: int, x: int) -> int:
    y = x % M
    return min(y, M - y)


def primitive(t):
    return reduce(gcd, t) == 1


def pivot_data(t, pivot):
    n = len(t)
    N = n + 1
    p = t[pivot]
    M = n * p
    R = tuple(r for r in range(M) if r % n != 0)
    coords = tuple(i for i in range(n) if i != pivot)

    bad = {}
    deep = {}
    shell = {}
    for i in coords:
        B = set()
        D = set()
        for r in R:
            value = rho(M, r * t[i])
            if value < p:
                B.add(r)
            if N * value < n * p:
                D.add(r)
        bad[i] = B
        deep[i] = D
        shell[i] = B - D

    empty = []
    shell_singletons = []
    deep_singletons = []
    deletion_certified = set()
    for r in R:
        bad_coords = tuple(i for i in coords if r in bad[i])
        deep_coords = tuple(i for i in coords if r in deep[i])
        if not bad_coords:
            empty.append(r)
            deletion_certified.update(coords)
        elif len(bad_coords) == 1:
            k = bad_coords[0]
            deletion_certified.add(k)
            if not deep_coords:
                shell_singletons.append((r, k, rho(M, r * t[k])))
            else:
                deep_singletons.append((r, k, rho(M, r * t[k])))

    deep_1 = sum(len(deep[i]) for i in coords)
    deep_2 = sum(
        len(deep[i] & deep[j]) for i, j in combinations(coords, 2)
    )
    deep_3 = sum(
        len(deep[i] & deep[j] & deep[k])
        for i, j, k in combinations(coords, 3)
    )
    shell_2 = sum(
        len(shell[i] & shell[j]) for i, j in combinations(coords, 2)
    )

    shell_surplus = len(R) - deep_1 - shell_2
    deep_bonferroni_surplus = (
        len(R) - (deep_1 - deep_2 + deep_3) - shell_2
    )

    return {
        "pivot": p,
        "M": M,
        "candidate_count": len(R),
        "deep_counts": tuple((t[i], len(deep[i])) for i in coords),
        "shell_counts": tuple((t[i], len(shell[i])) for i in coords),
        "deep_moments": (deep_1, deep_2, deep_3),
        "shell_pair_sum": shell_2,
        "shell_surplus": shell_surplus,
        "deep_bonferroni_surplus": deep_bonferroni_surplus,
        "empty": tuple(empty),
        "shell_singletons": tuple(shell_singletons),
        "deep_singleton_count": len(deep_singletons),
        "certified_deletions": tuple(sorted(deletion_certified)),
    }


def tuple_data(t):
    rows = tuple(pivot_data(t, j) for j in range(len(t)))
    certified = set()
    for row in rows:
        certified.update(row["certified_deletions"])
    return {
        "rows": rows,
        "all_deletions_certified": certified == set(range(len(t))),
        "has_lift": any(row["empty"] or row["shell_singletons"] for row in rows),
        "best_shell_surplus": max(row["shell_surplus"] for row in rows),
        "best_deep_bonferroni_surplus": max(
            row["deep_bonferroni_surplus"] for row in rows
        ),
        "good_counts": tuple(
            len(row["empty"]) + len(row["shell_singletons"]) for row in rows
        ),
    }


def dplp_eligible(t):
    n = len(t)
    N = n + 1
    data = tuple_data(t)
    return (
        primitive(t)
        and t[-1] > N + N // 3
        and any(a % N == 0 for a in t)
        and data["all_deletions_certified"]
    )


REQUIRED = {
    "raw_lifting_failure": (1, 3, 4, 7),
    "disjoint_phase_example": (1, 2, 3, 60),
    "nondivisible_pivot_lifts": (1, 2, 6, 8, 10),
    "OPT_ADD_G": (15, 21, 40, 48, 56, 105, 126, 280, 1200),
    "deep_bonferroni_failure": (1, 3, 4, 5, 18),
}


def main():
    started = time.perf_counter()
    print(f"python={platform.python_version()}")
    print("random_seed=none")
    print()

    print("[required tuples]")
    for name, t in REQUIRED.items():
        data = tuple_data(t)
        N = len(t) + 1
        print(
            f"{name}: tuple={t} N={N} primitive={primitive(t)} "
            f"N_divisible={any(a % N == 0 for a in t)} "
            f"height_premise={t[-1] > N + N // 3} "
            f"all_deletions_certified={data['all_deletions_certified']} "
            f"has_lift={data['has_lift']}"
        )
        print(
            "  pivots="
            + repr(
                tuple(
                    (
                        row["pivot"],
                        row["shell_surplus"],
                        row["deep_bonferroni_surplus"],
                        len(row["empty"]),
                        len(row["shell_singletons"]),
                        row["deep_moments"],
                        row["shell_pair_sum"],
                    )
                    for row in data["rows"]
                )
            )
        )
        if name == "deep_bonferroni_failure":
            print(
                "  lift_candidates_at_18="
                + repr(data["rows"][-1]["shell_singletons"])
            )
    print()

    print("[first eligible failure of deep-Bonferroni shell surplus]")
    domains = ((3, 20), (4, 20), (5, 18))
    found = None
    for n, max_speed in domains:
        eligible = 0
        failure = None
        for t in combinations(range(1, max_speed + 1), n):
            if not dplp_eligible(t):
                continue
            eligible += 1
            data = tuple_data(t)
            if data["best_deep_bonferroni_surplus"] <= 0:
                failure = (
                    t,
                    tuple(
                        row["deep_bonferroni_surplus"]
                        for row in data["rows"]
                    ),
                    data["good_counts"],
                )
                if found is None:
                    found = failure
                break
        print(
            f"n={n} max={max_speed} eligible_checked={eligible} "
            f"first_failure={failure}"
        )

    assert found == (
        (1, 3, 4, 5, 18),
        (0, 0, 0, 0, 0),
        (0, 0, 0, 0, 4),
    )
    print()

    print("[consecutive family]")
    for n in range(3, 21):
        t = tuple(range(1, n + 1))
        data = tuple_data(t)
        print(
            f"n={n} best_shell={data['best_shell_surplus']} "
            f"best_deep_bonf={data['best_deep_bonferroni_surplus']} "
            f"best_actual_good={max(data['good_counts'])} "
            f"N_divisible={any(a % (n + 1) == 0 for a in t)}"
        )

    elapsed = time.perf_counter() - started
    print()
    print(f"elapsed_seconds={elapsed:.6f}")


if __name__ == "__main__":
    main()
