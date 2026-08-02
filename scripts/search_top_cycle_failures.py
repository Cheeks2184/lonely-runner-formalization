#!/usr/bin/env python3
"""Exact targeted search for an all-pivot TOP-CYCLE failure.

This is a search implementation, not the independent acceptance oracle in
``audit_top_cycle_failure.py``.  It reconstructs strict candidate bad sets
from modular residues, computes the best top-parent credit by subset dynamic
programming, and optionally computes the unrestricted additive optimum.

The objective for a tuple is

    max_A (n*A - D_top(A)).

Thus ``objective <= 0`` means that every pivot fails the *strict*
TOP-CYCLE sufficient condition.  Such a tuple is not a counterexample to the
Lonely Runner Conjecture.  In particular, this script records the unrestricted
additive optimum separately.
"""

from __future__ import annotations

import argparse
import itertools
import math
import random
from dataclasses import dataclass


@dataclass(frozen=True)
class PivotScore:
    pivot: int
    threshold: int
    bad_sum: int
    top_credit: int
    retained_top: int
    top_bound: int
    surplus: int
    retained_opt: int | None = None
    optimized_bound: int | None = None


def _strict_bad(image: int, pivot_speed: int, modulus: int) -> bool:
    return image < pivot_speed or image > modulus - pivot_speed


def _pivot_tokens(
    speeds: tuple[int, ...], pivot: int
) -> tuple[tuple[int, ...], int, int, tuple[tuple[tuple[int, int], ...], ...]]:
    """Return local vertices, threshold, S, and tokens grouped by child.

    Each token is ``(top_parent_mask, top_weight)``.  Parent masks use the
    local ordering of the non-pivot vertices.
    """

    n = len(speeds)
    A = speeds[pivot]
    N = n + 1
    modulus = N * A
    candidates = tuple(r for r in range(modulus) if r % N)
    if len(candidates) != n * A:
        raise AssertionError("candidate universe size mismatch")

    others = tuple(i for i in range(n) if i != pivot)
    local = {index: position for position, index in enumerate(others)}
    bad_masks: dict[int, int] = {}
    fibers: dict[int, tuple[int, ...]] = {}
    for child in others:
        by_target: dict[int, int] = {}
        bad_mask = 0
        speed = speeds[child]
        for position, residue in enumerate(candidates):
            image = speed * residue % modulus
            if _strict_bad(image, A, modulus):
                bit = 1 << position
                bad_mask |= bit
                by_target[image] = by_target.get(image, 0) | bit
        bad_masks[child] = bad_mask
        fibers[child] = tuple(by_target.values())

    tokens_by_child: list[tuple[tuple[int, int], ...]] = []
    top_credit = 0
    for child in others:
        child_tokens: list[tuple[int, int]] = []
        for fiber in fibers[child]:
            weights = tuple(
                (parent, (fiber & bad_masks[parent]).bit_count())
                for parent in others
                if parent != child
            )
            top_weight = max((weight for _parent, weight in weights), default=0)
            if top_weight:
                top_mask = sum(
                    1 << local[parent]
                    for parent, weight in weights
                    if weight == top_weight
                )
                child_tokens.append((top_mask, top_weight))
                top_credit += top_weight
        tokens_by_child.append(tuple(child_tokens))

    bad_sum = sum(mask.bit_count() for mask in bad_masks.values())
    return others, n * A, bad_sum, tuple(tokens_by_child)


def _retained_top(tokens_by_child: tuple[tuple[tuple[int, int], ...], ...]) -> int:
    m = len(tokens_by_child)
    full = (1 << m) - 1
    gain = [[0] * (full + 1) for _ in range(m)]
    for child in range(m):
        # Aggregate equal top-parent masks, then use a subset zeta transform.
        # The tokens missed by predecessor state P are exactly those whose
        # nonempty top mask is a subset of the complement of P.
        subset_sum = [0] * (full + 1)
        total = 0
        for parents, weight in tokens_by_child[child]:
            subset_sum[parents] += weight
            total += weight
        for bit_index in range(m):
            bit = 1 << bit_index
            for state in range(full + 1):
                if state & bit:
                    subset_sum[state] += subset_sum[state ^ bit]
        for state in range(full + 1):
            gain[child][state] = total - subset_sum[full ^ state]
    best = [-1] * (full + 1)
    best[0] = 0
    for state in range(full + 1):
        if best[state] < 0:
            continue
        for child in range(m):
            bit = 1 << child
            if not state & bit:
                successor = state | bit
                value = best[state] + gain[child][state]
                if value > best[successor]:
                    best[successor] = value
    return best[full]


def score_pivot(speeds: tuple[int, ...], pivot: int) -> PivotScore:
    others, threshold, bad_sum, tokens = _pivot_tokens(speeds, pivot)
    if len(others) != len(speeds) - 1:
        raise AssertionError("local vertex count mismatch")
    retained = _retained_top(tokens)
    top_credit = sum(weight for row in tokens for _parents, weight in row)
    top_bound = bad_sum - retained
    return PivotScore(
        pivot=speeds[pivot],
        threshold=threshold,
        bad_sum=bad_sum,
        top_credit=top_credit,
        retained_top=retained,
        top_bound=top_bound,
        surplus=threshold - top_bound,
    )


def score_tuple(speeds: tuple[int, ...]) -> tuple[int, tuple[PivotScore, ...]]:
    if not speeds or min(speeds) <= 0 or len(set(speeds)) != len(speeds):
        raise ValueError("speeds must be distinct positive integers")
    rows = tuple(score_pivot(speeds, pivot) for pivot in range(len(speeds)))
    return max(row.surplus for row in rows), rows


def score_tuple_if_at_most(
    speeds: tuple[int, ...], cutoff: int, pivot_order: tuple[int, ...]
) -> tuple[int, tuple[PivotScore, ...]] | None:
    """Return the exact score only when it is at most ``cutoff``.

    The current tuple's worst pivots are tested first.  Encountering one row
    with surplus above the incumbent objective proves that the proposal cannot
    improve even the secondary plateau score and avoids the remaining rows.
    """

    by_pivot: dict[int, PivotScore] = {}
    for pivot in pivot_order:
        row = score_pivot(speeds, pivot)
        if row.surplus > cutoff:
            return None
        by_pivot[pivot] = row
    rows = tuple(by_pivot[pivot] for pivot in range(len(speeds)))
    return max(row.surplus for row in rows), rows


def _descent_key(
    speeds: tuple[int, ...], rows: tuple[PivotScore, ...]
) -> tuple[object, ...]:
    """Refine the required maximum by the whole descending surplus profile."""

    profile = tuple(sorted((row.surplus for row in rows), reverse=True))
    return (profile, sum(max(0, value) for value in profile), speeds)


def normalize(speeds: tuple[int, ...]) -> tuple[int, ...]:
    common = math.gcd(*speeds)
    return tuple(sorted(speed // common for speed in speeds))


def one_coordinate_neighbors(
    speeds: tuple[int, ...], radius: int, maximum: int
) -> tuple[tuple[int, ...], ...]:
    values = set(speeds)
    neighbors: set[tuple[int, ...]] = set()
    for old in speeds:
        for new in range(max(1, old - radius), min(maximum, old + radius) + 1):
            if new == old or new in values:
                continue
            candidate = normalize(tuple(new if value == old else value for value in speeds))
            if len(candidate) == len(speeds):
                neighbors.add(candidate)
    return tuple(sorted(neighbors))


def two_coordinate_neighbors(
    speeds: tuple[int, ...], radius: int, maximum: int
) -> tuple[tuple[int, ...], ...]:
    """Return the exact one/two-coordinate box around ``speeds``."""

    neighbors = set(one_coordinate_neighbors(speeds, radius, maximum))
    for first, second in itertools.combinations(range(len(speeds)), 2):
        for first_delta in range(-radius, radius + 1):
            if first_delta == 0:
                continue
            first_value = speeds[first] + first_delta
            if not 1 <= first_value <= maximum:
                continue
            for second_delta in range(-radius, radius + 1):
                if second_delta == 0:
                    continue
                second_value = speeds[second] + second_delta
                if not 1 <= second_value <= maximum:
                    continue
                values = list(speeds)
                values[first] = first_value
                values[second] = second_value
                if len(set(values)) != len(values):
                    continue
                candidate = normalize(tuple(values))
                if len(candidate) == len(speeds):
                    neighbors.add(candidate)
    return tuple(sorted(neighbors))


def three_coordinate_neighbors(
    speeds: tuple[int, ...], radius: int, maximum: int
) -> tuple[tuple[int, ...], ...]:
    """Return the exact one/two/three-coordinate box around ``speeds``."""

    neighbors = set(two_coordinate_neighbors(speeds, radius, maximum))
    deltas = tuple(delta for delta in range(-radius, radius + 1) if delta)
    for positions in itertools.combinations(range(len(speeds)), 3):
        for changes in itertools.product(deltas, repeat=3):
            values = list(speeds)
            valid = True
            for position, delta in zip(positions, changes):
                values[position] += delta
                if not 1 <= values[position] <= maximum:
                    valid = False
                    break
            if not valid or len(set(values)) != len(values):
                continue
            candidate = normalize(tuple(values))
            if len(candidate) == len(speeds):
                neighbors.add(candidate)
    return tuple(sorted(neighbors))


def deterministic_descent(
    seed: tuple[int, ...], *, radius: int, maximum: int, rounds: int, coordinates: int
) -> tuple[tuple[int, ...], int, tuple[PivotScore, ...], int]:
    current = normalize(seed)
    objective, rows = score_tuple(current)
    examined = 1
    for round_index in range(rounds):
        best_tuple = current
        best_objective = objective
        best_rows = rows
        best_key = _descent_key(current, rows)
        pivot_order = tuple(
            sorted(range(len(current)), key=lambda pivot: rows[pivot].surplus, reverse=True)
        )
        if coordinates == 1:
            candidates = one_coordinate_neighbors(current, radius, maximum)
        elif coordinates == 2:
            candidates = two_coordinate_neighbors(current, radius, maximum)
        else:
            candidates = three_coordinate_neighbors(current, radius, maximum)
        for candidate in candidates:
            examined += 1
            scored = score_tuple_if_at_most(candidate, best_objective, pivot_order)
            if scored is None:
                continue
            candidate_objective, candidate_rows = scored
            candidate_key = _descent_key(candidate, candidate_rows)
            if candidate_key < best_key:
                best_tuple = candidate
                best_objective = candidate_objective
                best_rows = candidate_rows
                best_key = candidate_key
                if candidate_objective <= 0:
                    return best_tuple, best_objective, best_rows, examined
        if best_tuple == current:
            break
        current, objective, rows = best_tuple, best_objective, best_rows
        print(
            f"descent round={round_index + 1} objective={objective} tuple={current}",
            flush=True,
        )
    return current, objective, rows, examined


def stochastic_hill_climb(
    seeds: tuple[tuple[int, ...], ...],
    *,
    maximum: int,
    steps: int,
    restarts: int,
    seed_value: int,
) -> tuple[tuple[int, ...], int, tuple[PivotScore, ...], int]:
    rng = random.Random(seed_value)
    cache: dict[tuple[int, ...], tuple[int, tuple[PivotScore, ...]]] = {}

    def cached_score(candidate: tuple[int, ...]) -> tuple[int, tuple[PivotScore, ...]]:
        if candidate not in cache:
            cache[candidate] = score_tuple(candidate)
        return cache[candidate]

    global_tuple = normalize(seeds[0])
    global_objective, global_rows = cached_score(global_tuple)
    for restart in range(restarts):
        if restart < len(seeds):
            current = normalize(seeds[restart])
        else:
            base = seeds[rng.randrange(len(seeds))]
            current = normalize(
                tuple(
                    max(1, min(maximum, speed + rng.randint(-12, 12)))
                    for speed in base
                )
            )
            if len(set(current)) != len(base):
                continue
        current_objective, current_rows = cached_score(current)
        temperature = 12.0
        for step in range(steps):
            values = set(current)
            position = rng.randrange(len(current))
            old = current[position]
            radius = 2 + step * 18 // max(steps, 1)
            new = max(1, min(maximum, old + rng.randint(-radius, radius)))
            if new == old or new in values:
                continue
            proposal = normalize(current[:position] + (new,) + current[position + 1 :])
            proposal_objective, proposal_rows = cached_score(proposal)
            delta = proposal_objective - current_objective
            accept = delta <= 0 or rng.random() < math.exp(-delta / max(temperature, 0.2))
            if accept:
                current, current_objective, current_rows = (
                    proposal,
                    proposal_objective,
                    proposal_rows,
                )
            temperature *= 0.993
            if (current_objective, current) < (global_objective, global_tuple):
                global_tuple, global_objective, global_rows = (
                    current,
                    current_objective,
                    current_rows,
                )
                print(
                    f"hill best objective={global_objective} tuple={global_tuple} "
                    f"evaluated={len(cache)}",
                    flush=True,
                )
                if global_objective <= 0:
                    return global_tuple, global_objective, global_rows, len(cache)
    return global_tuple, global_objective, global_rows, len(cache)


def plateau_walk(
    seed: tuple[int, ...],
    *,
    maximum: int,
    radius: int,
    steps: int,
    seed_value: int,
) -> tuple[tuple[int, ...], int, tuple[PivotScore, ...], int]:
    """Explore the exact ``objective <= incumbent`` plateau deterministically."""

    rng = random.Random(seed_value)
    current = normalize(seed)
    cutoff, current_rows = score_tuple(current)
    best_tuple, best_rows = current, current_rows
    best_key = _descent_key(current, current_rows)
    accepted = {current}
    examined = 1
    for step in range(steps):
        proposal_values = list(current)
        changes = 2 if rng.random() < 0.3 else 1
        for _ in range(changes):
            position = rng.randrange(len(proposal_values))
            proposal_values[position] = max(
                1,
                min(
                    maximum,
                    proposal_values[position] + rng.randint(-radius, radius),
                ),
            )
        proposal = normalize(tuple(proposal_values))
        if len(set(proposal)) != len(current) or proposal in accepted:
            continue
        pivot_order = tuple(
            sorted(
                range(len(current)),
                key=lambda pivot: current_rows[pivot].surplus,
                reverse=True,
            )
        )
        scored = score_tuple_if_at_most(proposal, cutoff, pivot_order)
        examined += 1
        if scored is None:
            continue
        objective, rows = scored
        accepted.add(proposal)
        current, current_rows = proposal, rows
        key = _descent_key(proposal, rows)
        if key < best_key:
            best_tuple, best_rows, best_key = proposal, rows, key
            print(
                f"plateau best objective={objective} tuple={proposal} "
                f"accepted={len(accepted)} examined={examined}",
                flush=True,
            )
        if objective < cutoff:
            return proposal, objective, rows, examined
        if step and step % 500 == 0:
            # Recenter periodically at the strongest exact point found while
            # retaining the visited set, so neutral excursions cannot drift
            # forever from the useful boundary.
            current, current_rows = best_tuple, best_rows
    objective = max(row.surplus for row in best_rows)
    return best_tuple, objective, best_rows, examined


def scan_complete_box(
    runners: int, maximum: int, *, require_one: bool
) -> tuple[tuple[int, ...] | None, int, tuple[PivotScore, ...], int]:
    """Scan a finite normalized box, stopping at the first all-pivot failure."""

    if require_one:
        iterator = (
            (1, *tail)
            for tail in itertools.combinations(range(2, maximum + 1), runners - 1)
        )
    else:
        iterator = itertools.combinations(range(1, maximum + 1), runners)
    examined = 0
    closest_tuple: tuple[int, ...] | None = None
    closest_rows: tuple[PivotScore, ...] = ()
    closest_objective = 10**18
    for speeds in iterator:
        if math.gcd(*speeds) != 1:
            continue
        examined += 1
        rows: list[PivotScore] = []
        failed = True
        # Small pivots are often the closest rows in compact boxes; checking
        # them first makes rejection of TOP-success tuples inexpensive.
        for pivot in range(runners):
            row = score_pivot(speeds, pivot)
            rows.append(row)
            if row.surplus > 0:
                failed = False
                break
        if failed:
            full_rows = tuple(rows)
            return speeds, max(row.surplus for row in full_rows), full_rows, examined
        # Periodically compute complete rows for near misses so the reported
        # closest tuple is an exact maximum, never a partial-pivot inference.
        if rows[-1].surplus <= 4:
            objective, full_rows = score_tuple(speeds)
            if (objective, speeds) < (closest_objective, closest_tuple or speeds):
                closest_tuple, closest_objective, closest_rows = (
                    speeds,
                    objective,
                    full_rows,
                )
        if examined % 5000 == 0:
            print(
                f"scan examined={examined} closest={closest_objective} "
                f"tuple={closest_tuple}",
                flush=True,
            )
    return closest_tuple, closest_objective, closest_rows, examined


def scan_single_extensions(
    seed: tuple[int, ...], maximum: int
) -> tuple[tuple[int, ...], int, tuple[PivotScore, ...], int]:
    """Try every distinct extra speed and retain the exact best extension."""

    best_tuple: tuple[int, ...] | None = None
    best_objective = 10**18
    best_rows: tuple[PivotScore, ...] = ()
    examined = 0
    for new in range(1, maximum + 1):
        if new in seed:
            continue
        candidate = normalize((*seed, new))
        if len(candidate) != len(seed) + 1:
            continue
        objective, rows = score_tuple(candidate)
        examined += 1
        if (_descent_key(candidate, rows), candidate) < (
            _descent_key(best_tuple, best_rows) if best_tuple else ((10**18,),),
            best_tuple or candidate,
        ):
            best_tuple, best_objective, best_rows = candidate, objective, rows
            print(f"extension best objective={objective} tuple={candidate}", flush=True)
    if best_tuple is None:
        raise AssertionError("extension scan produced no tuple")
    return best_tuple, best_objective, best_rows, examined


SEEDS = (
    (8, 15, 35, 40, 48, 56, 68, 75, 78),
    (10, 37, 45, 51, 54, 56, 61, 71, 91),
    (8, 15, 35, 40, 48, 56, 63, 75, 78),
    (6, 8, 15, 21, 28, 35, 40, 48, 75),
    (1, 14, 27, 40, 53, 66, 79, 92, 105),
    (1, 4, 5, 7, 8, 9, 10, 11, 17),
    (1, 4, 5, 6, 7, 9, 10, 11, 17),
    (1, 4, 6, 7, 9, 10, 11, 13, 17),
    (1, 4, 6, 7, 9, 10, 13, 16, 17),
    (1, 4, 6, 7, 9, 10, 11, 13, 16, 17),
    (1, 4, 5, 6, 7, 9, 11, 13, 16, 17),
    (1, 3, 4, 5, 6, 7, 8, 9, 30),
    (1, 2, 3, 5, 6, 7, 8, 9, 30),
    (1, 4, 5, 6, 7, 9, 11, 13, 16, 17, 60),
    (1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 60),
)


def _print_result(
    speeds: tuple[int, ...], objective: int, rows: tuple[PivotScore, ...], examined: int
) -> None:
    print(f"RESULT objective={objective} examined={examined} tuple={speeds}")
    for row in rows:
        print(row)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--tuple")
    parser.add_argument("--descent", type=int)
    parser.add_argument("--radius", type=int, default=2)
    parser.add_argument("--maximum", type=int, default=120)
    parser.add_argument("--rounds", type=int, default=20)
    parser.add_argument("--coordinates", type=int, choices=(1, 2, 3), default=1)
    parser.add_argument("--hill", action="store_true")
    parser.add_argument("--hill-seed", type=int)
    parser.add_argument("--steps", type=int, default=400)
    parser.add_argument("--restarts", type=int, default=24)
    parser.add_argument("--random-seed", type=int, default=20260801)
    parser.add_argument("--plateau", type=int)
    parser.add_argument("--scan-runners", type=int)
    parser.add_argument("--require-one", action="store_true")
    parser.add_argument("--extend", type=int)
    args = parser.parse_args()
    if args.extend is not None:
        result = scan_single_extensions(SEEDS[args.extend], args.maximum)
        _print_result(*result)
    elif args.scan_runners is not None:
        result = scan_complete_box(
            args.scan_runners, args.maximum, require_one=args.require_one
        )
        _print_result(*result)
    elif args.tuple:
        speeds = tuple(int(value) for value in args.tuple.split(","))
        objective, rows = score_tuple(normalize(speeds))
        _print_result(normalize(speeds), objective, rows, 1)
    elif args.descent is not None:
        result = deterministic_descent(
            SEEDS[args.descent],
            radius=args.radius,
            maximum=args.maximum,
            rounds=args.rounds,
            coordinates=args.coordinates,
        )
        _print_result(*result)
    elif args.hill:
        hill_seeds = (SEEDS[args.hill_seed],) if args.hill_seed is not None else SEEDS
        result = stochastic_hill_climb(
            hill_seeds,
            maximum=args.maximum,
            steps=args.steps,
            restarts=args.restarts,
            seed_value=args.random_seed,
        )
        _print_result(*result)
    elif args.plateau is not None:
        result = plateau_walk(
            SEEDS[args.plateau],
            maximum=args.maximum,
            radius=args.radius,
            steps=args.steps,
            seed_value=args.random_seed,
        )
        _print_result(*result)
    else:
        for speeds in SEEDS:
            objective, rows = score_tuple(normalize(speeds))
            _print_result(normalize(speeds), objective, rows, 1)


if __name__ == "__main__":
    main()
