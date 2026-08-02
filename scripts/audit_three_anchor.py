#!/usr/bin/env python3
"""Audit the reproducible all-target reading of Response 26's anchor formula.

The response left a target set ``A`` undefined.  If ``A`` contains every
target of the selected anchor ``h``, its displayed depth-two expression is
exactly the existing one-level credit against ``h``.  This script computes
the resulting front-loaded bound for every ordering of the claimed anchors.
"""

from __future__ import annotations

import itertools

from audit_relocation_descent import _tables
from search_fiber_hall import pivot_bad_mask


CLAIMS = (
    ((2, 3, 7, 9, 10, 12, 15, 16, 19), 3, (15, 16), 25),
    ((8, 15, 35, 40, 48, 56, 63, 75, 78), 8, (35, 63, 78), 70),
    ((1, 2, 5, 7, 9, 11, 12, 13), 7, (1, 11, 12), 52),
    ((1, 5, 7, 8, 9, 11, 13, 15), 8, (5, 11, 15), 58),
    ((1, 2, 3, 5), 3, (1, 2), 10),
)


def all_target_front_cost(
    speeds: tuple[int, ...], pivot_speed: int, anchor_speeds: tuple[int, ...]
) -> tuple[int, ...]:
    pivot = speeds.index(pivot_speed)
    others, positions, costs = _tables(speeds, pivot)
    anchors = tuple(speeds.index(speed) for speed in anchor_speeds)
    anchor_state = sum(1 << positions[anchor] for anchor in anchors)
    remainder = tuple(child for child in others if child not in anchors)
    tail_cost = sum(costs[(child, anchor_state)] for child in remainder)
    totals: list[int] = []
    for anchor_order in itertools.permutations(anchors):
        state = 0
        prefix_cost = 0
        for child in anchor_order:
            prefix_cost += costs[(child, state)]
            state |= 1 << positions[child]
        totals.append(prefix_cost + tail_cost)
    return tuple(sorted(set(totals)))


def ordinary_completion_costs(
    speeds: tuple[int, ...], pivot_speed: int, anchor_speeds: tuple[int, ...]
) -> tuple[int, ...]:
    """Ordinary additive costs if the anchor set really is a prefix."""

    pivot = speeds.index(pivot_speed)
    others, positions, costs = _tables(speeds, pivot)
    anchors = tuple(speeds.index(speed) for speed in anchor_speeds)
    remainder = tuple(child for child in others if child not in anchors)
    totals: list[int] = []
    for anchor_order in itertools.permutations(anchors):
        for tail_order in itertools.permutations(remainder):
            state = 0
            total = 0
            for child in (*anchor_order, *tail_order):
                total += costs[(child, state)]
                state |= 1 << positions[child]
            totals.append(total)
    return min(totals), max(totals)


def exact_anchor_union_cost(
    speeds: tuple[int, ...], pivot_speed: int, anchor_speeds: tuple[int, ...]
) -> int:
    """Exact anchor union plus one-level residual costs against all anchors."""

    pivot = speeds.index(pivot_speed)
    others, positions, costs = _tables(speeds, pivot)
    anchors = tuple(speeds.index(speed) for speed in anchor_speeds)
    anchor_state = sum(1 << positions[anchor] for anchor in anchors)
    anchor_union = 0
    for anchor in anchors:
        anchor_union |= pivot_bad_mask(speeds, pivot, anchor)
    return anchor_union.bit_count() + sum(
        costs[(child, anchor_state)] for child in others if child not in anchors
    )


def main() -> None:
    for speeds, pivot, anchors, claimed in CLAIMS:
        totals = all_target_front_cost(speeds, pivot, anchors)
        completion_range = ordinary_completion_costs(speeds, pivot, anchors)
        exact_union_cost = exact_anchor_union_cost(speeds, pivot, anchors)
        print(
            f"speeds={speeds} pivot={pivot} anchors={anchors} "
            f"all_target_totals={totals} "
            f"ordinary_completion_range={completion_range} claimed={claimed}"
            f" exact_anchor_union_cost={exact_union_cost}"
        )


if __name__ == "__main__":
    main()
