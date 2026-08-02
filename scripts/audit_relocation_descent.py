#!/usr/bin/env python3
"""Independently audit single-item relocation descent for fiber costs.

For a fixed pivot, ``C(i, P)`` is the insertion-cost upper bound for child
``i`` after the predecessor set ``P``.  A relocation takes an item ``i`` and
moves it left across a nonempty contiguous block ``T``.  This module checks
the proposed exact delta both from the marginal-benefit formula and by direct
subtraction, then enumerates every relocation-local order on selected small
instances.

The literal masks and target-fiber partition come from ``search_fiber_hall``;
the relocation tables and enumeration below are separate from its optimal-
order dynamic program.
"""

from __future__ import annotations

import argparse
import itertools
from dataclasses import dataclass

from search_fiber_hall import child_fibers, pivot_bad_mask


@dataclass(frozen=True)
class RelocationAudit:
    speeds: tuple[int, ...]
    pivot_speed: int
    local_minimum_count: int
    local_minimum_costs: tuple[int, ...]
    universe_size: int
    strict_left_minimum_count: int
    two_sided_minimum_count: int
    two_sided_costs: tuple[int, ...]
    first_nonstrict_left_example: tuple[tuple[int, ...], int] | None


def _tables(
    speeds: tuple[int, ...], pivot: int
) -> tuple[tuple[int, ...], dict[int, int], dict[tuple[int, int], int]]:
    others = tuple(index for index in range(len(speeds)) if index != pivot)
    positions = {child: position for position, child in enumerate(others)}
    masks = {child: pivot_bad_mask(speeds, pivot, child) for child in others}
    fibers = {
        child: tuple(mask for _target, mask in child_fibers(speeds, pivot, child))
        for child in others
    }
    costs: dict[tuple[int, int], int] = {}
    for child in others:
        for state in range(1 << len(others)):
            if state & (1 << positions[child]):
                continue
            credit = sum(
                max(
                    (
                        (fiber & masks[parent]).bit_count()
                        for parent in others
                        if state & (1 << positions[parent])
                    ),
                    default=0,
                )
                for fiber in fibers[child]
            )
            costs[(child, state)] = masks[child].bit_count() - credit
    return others, positions, costs


def order_cost(
    order: tuple[int, ...], positions: dict[int, int], costs: dict[tuple[int, int], int]
) -> int:
    state = 0
    total = 0
    for child in order:
        total += costs[(child, state)]
        state |= 1 << positions[child]
    return total


def relocation_delta(
    order: tuple[int, ...],
    destination: int,
    source: int,
    positions: dict[int, int],
    costs: dict[tuple[int, int], int],
) -> int:
    """Return new cost minus old cost when ``order[source]`` moves left.

    This is the claimed marginal formula, not a direct recomputation.  The
    caller can compare it with ``order_cost(relocated)-order_cost(order)``.
    """

    if not 0 <= destination < source < len(order):
        raise ValueError("a relocation must move one item strictly left")
    moved = order[source]
    crossed = order[destination:source]
    prefix = order[:destination]
    prefix_state = sum(1 << positions[child] for child in prefix)
    crossed_state = sum(1 << positions[child] for child in crossed)

    # Moving earlier removes all crossed items from the moved child's parent
    # set.  Each crossed item, conversely, gains the moved item as a parent.
    delta = costs[(moved, prefix_state)] - costs[
        (moved, prefix_state | crossed_state)
    ]
    state = prefix_state
    moved_bit = 1 << positions[moved]
    for child in crossed:
        marginal_benefit = costs[(child, state)] - costs[
            (child, state | moved_bit)
        ]
        delta -= marginal_benefit
        state |= 1 << positions[child]
    return delta


def relocated(
    order: tuple[int, ...], destination: int, source: int
) -> tuple[int, ...]:
    moved = order[source]
    return (*order[:destination], moved, *order[destination:source], *order[source + 1 :])


def audit_local_minima(speeds: tuple[int, ...], pivot_speed: int) -> RelocationAudit:
    pivot = speeds.index(pivot_speed)
    others, positions, costs = _tables(speeds, pivot)
    local_costs: list[int] = []
    strict_left_costs: list[int] = []
    two_sided_costs: list[int] = []
    first_nonstrict_left_example: tuple[tuple[int, ...], int] | None = None
    for order in itertools.permutations(others):
        old_cost = order_cost(order, positions, costs)
        locally_minimal = True
        strictly_left_minimal = True
        for source in range(1, len(order)):
            for destination in range(source):
                new_order = relocated(order, destination, source)
                direct_delta = order_cost(new_order, positions, costs) - old_cost
                formula_delta = relocation_delta(
                    order, destination, source, positions, costs
                )
                if formula_delta != direct_delta:
                    raise AssertionError(
                        f"relocation delta mismatch: {order=}, {destination=}, "
                        f"{source=}, {formula_delta=}, {direct_delta=}"
                    )
                if direct_delta < 0:
                    locally_minimal = False
                if direct_delta <= 0:
                    strictly_left_minimal = False
        if locally_minimal:
            local_costs.append(old_cost)
            if (
                old_cost >= len(speeds) * pivot_speed
                and first_nonstrict_left_example is None
            ):
                first_nonstrict_left_example = (
                    tuple(speeds[index] for index in order),
                    old_cost,
                )
        if strictly_left_minimal:
            strict_left_costs.append(old_cost)

        # A two-sided insertion neighborhood also permits moving an item to
        # the right.  This is a different convention from the displayed
        # left-relocation formula, so report it separately.
        two_sided_minimal = locally_minimal
        if two_sided_minimal:
            for source in range(len(order) - 1):
                for destination in range(source + 1, len(order)):
                    moved = order[source]
                    new_order = (
                        *order[:source],
                        *order[source + 1 : destination + 1],
                        moved,
                        *order[destination + 1 :],
                    )
                    if order_cost(new_order, positions, costs) < old_cost:
                        two_sided_minimal = False
        if two_sided_minimal:
            two_sided_costs.append(old_cost)
    return RelocationAudit(
        speeds=speeds,
        pivot_speed=pivot_speed,
        local_minimum_count=len(local_costs),
        local_minimum_costs=tuple(sorted(set(local_costs))),
        universe_size=len(speeds) * pivot_speed,
        strict_left_minimum_count=len(strict_left_costs),
        two_sided_minimum_count=len(two_sided_costs),
        two_sided_costs=tuple(sorted(set(two_sided_costs))),
        first_nonstrict_left_example=first_nonstrict_left_example,
    )


CLAIMS = (
    ((2, 3, 7, 9, 10, 12, 15, 16, 19), 3),
    ((8, 15, 35, 40, 48, 56, 63, 75, 78), 40),
    ((1, 2, 5, 7, 9, 11, 12, 13), 7),
    ((1, 5, 7, 8, 9, 11, 13, 15), 8),
    ((1, 2, 3, 5), 3),
)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--claim", type=int, choices=range(len(CLAIMS)))
    args = parser.parse_args()
    selected = CLAIMS if args.claim is None else (CLAIMS[args.claim],)
    for speeds, pivot_speed in selected:
        report = audit_local_minima(speeds, pivot_speed)
        print(
            f"speeds={speeds} pivot={pivot_speed} "
            f"local_minima={report.local_minimum_count} "
            f"costs={report.local_minimum_costs} "
            f"threshold={report.universe_size} "
            f"strict_left_minima={report.strict_left_minimum_count} "
            f"two_sided_minima={report.two_sided_minimum_count} "
            f"two_sided_costs={report.two_sided_costs} "
            f"bad_left_example={report.first_nonstrict_left_example}"
        )


if __name__ == "__main__":
    main()
