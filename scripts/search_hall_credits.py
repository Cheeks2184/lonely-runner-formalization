#!/usr/bin/env python3
"""Exact diagnostics for capacitated Hall overlap credits.

For a fixed pivot and a newly inserted child bad set ``B_i``, parent ``j`` is
eligible to supply credits from ``B_i ∩ B_j``.  A quota vector is realizable
iff every parent subset satisfies the capacitated Hall inequality.  This
script checks those cuts literally and independently computes the maximum
number of assignable quota units with an integral bipartite matching.

It can also search genuine Lonely Runner pivot bad sets for the first example
where checking cuts only through a prescribed size gives a false positive.
No floating-point arithmetic is used.
"""

from __future__ import annotations

import argparse
import itertools
from dataclasses import dataclass

import search_residual


@dataclass(frozen=True)
class HallFailure:
    parents: tuple[int, ...]
    weights: tuple[int, ...]
    cut: tuple[int, ...]
    demand: int
    capacity: int


def union_mask(masks: list[int], indices: tuple[int, ...]) -> int:
    result = 0
    for index in indices:
        result |= masks[index]
    return result


def mask_elements(mask: int) -> tuple[int, ...]:
    """Decode a nonnegative bitmask in increasing residue order."""

    elements: list[int] = []
    while mask:
        low_bit = mask & -mask
        elements.append(low_bit.bit_length() - 1)
        mask ^= low_bit
    return tuple(elements)


def first_failed_hall_cut(
    masks: list[int], weights: tuple[int, ...], minimum_size: int = 1
) -> HallFailure | None:
    """Return the lexicographically first violated nonempty Hall cut."""

    parent_count = len(masks)
    for size in range(max(1, minimum_size), parent_count + 1):
        for cut in itertools.combinations(range(parent_count), size):
            demand = sum(weights[index] for index in cut)
            capacity = union_mask(masks, cut).bit_count()
            if demand > capacity:
                return HallFailure(tuple(range(parent_count)), weights, cut, demand, capacity)
    return None


def hall_holds_through(
    masks: list[int], weights: tuple[int, ...], maximum_size: int
) -> bool:
    """Check all nonempty Hall cuts of size at most ``maximum_size``."""

    for size in range(1, min(maximum_size, len(masks)) + 1):
        for cut in itertools.combinations(range(len(masks)), size):
            if sum(weights[index] for index in cut) > union_mask(masks, cut).bit_count():
                return False
    return True


def maximum_assigned_units(masks: list[int], weights: tuple[int, ...]) -> int:
    """Maximum integral flow after cloning each parent by its quota.

    This is a deterministic augmenting-path bipartite matcher.  Right-side
    residue nodes have capacity one, so its value is the maximum disjoint
    overlap credit realizable by the requested parent quotas.
    """

    units = [parent for parent, weight in enumerate(weights) for _ in range(weight)]
    matched_parent_by_residue: dict[int, int] = {}

    def augment(parent: int, seen: set[int]) -> bool:
        eligible = masks[parent]
        while eligible:
            low_bit = eligible & -eligible
            residue = low_bit.bit_length() - 1
            eligible ^= low_bit
            if residue in seen:
                continue
            seen.add(residue)
            displaced = matched_parent_by_residue.get(residue)
            if displaced is None or augment(displaced, seen):
                matched_parent_by_residue[residue] = parent
                return True
        return False

    assigned = 0
    for parent in units:
        assigned += augment(parent, set())
    return assigned


def search_truncated_cut_counterexample(
    checked_cut_size: int,
    max_runners: int,
    max_speed: int,
    max_weight: int,
) -> dict[str, object] | None:
    """Find an arithmetic example defeating Hall cuts only up to a size.

    Exactly ``checked_cut_size + 1`` parents are used, so the only omitted cut
    is the full one.  All quotas are positive and at most ``max_weight``.
    Tuples and all internal choices are traversed lexicographically.
    """

    needed_parents = checked_cut_size + 1
    minimum_runners = needed_parents + 2  # pivot, child, and the parents
    for runner_count in range(minimum_runners, max_runners + 1):
        for speeds in itertools.combinations(range(1, max_speed + 1), runner_count):
            for pivot in range(runner_count):
                bad = {
                    other: search_residual.pivot_bad_mask(speeds, pivot, other)
                    for other in range(runner_count)
                    if other != pivot
                }
                for child in range(runner_count):
                    if child == pivot:
                        continue
                    available = tuple(
                        parent
                        for parent in range(runner_count)
                        if parent not in (pivot, child)
                    )
                    for parents in itertools.combinations(available, needed_parents):
                        masks = [bad[child] & bad[parent] for parent in parents]
                        if any(mask == 0 for mask in masks):
                            continue
                        for weights in itertools.product(
                            range(1, max_weight + 1), repeat=needed_parents
                        ):
                            if not hall_holds_through(masks, weights, checked_cut_size):
                                continue
                            failure = first_failed_hall_cut(
                                masks, weights, checked_cut_size + 1
                            )
                            if failure is None:
                                continue
                            flow = maximum_assigned_units(masks, weights)
                            return {
                                "speeds": speeds,
                                "N": runner_count + 1,
                                "pivot_index": pivot,
                                "pivot_speed": speeds[pivot],
                                "child_index": child,
                                "child_speed": speeds[child],
                                "parent_indices": parents,
                                "parent_speeds": tuple(speeds[p] for p in parents),
                                "weights": weights,
                                "eligible_sizes": tuple(mask.bit_count() for mask in masks),
                                "eligible_residues": tuple(mask_elements(mask) for mask in masks),
                                "failed_cut": failure.cut,
                                "failed_demand": failure.demand,
                                "failed_capacity": failure.capacity,
                                "maximum_flow": flow,
                                "total_demand": sum(weights),
                            }
    return None


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--checked-cut-size", type=int, default=2)
    parser.add_argument("--max-runners", type=int, default=6)
    parser.add_argument("--max-speed", type=int, default=12)
    parser.add_argument("--max-weight", type=int, default=3)
    args = parser.parse_args()
    if args.checked_cut_size < 1:
        parser.error("--checked-cut-size must be positive")
    result = search_truncated_cut_counterexample(
        args.checked_cut_size,
        args.max_runners,
        args.max_speed,
        args.max_weight,
    )
    if result is None:
        print("no counterexample in the requested box")
        return
    for key, value in result.items():
        print(f"{key}={value}")


if __name__ == "__main__":
    main()
