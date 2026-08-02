#!/usr/bin/env python3
"""Audit the malformed Response 26 and repaired Response 27 anchor formulas.

The response left a target set ``A`` undefined.  If ``A`` contains every
target of the selected anchor ``h``, its displayed depth-two expression is
exactly the existing one-level credit against ``h``.  This script computes
the resulting front-loaded bound for every ordering of the claimed anchors.

Response 27 repairs the definition: every child fiber is partitioned by all
anchor images modulo ``M``.  Subfibers whose anchor image lies in the strict
bad-target set are credited completely; on every other subfiber, the largest
intersection with one other earlier parent is credited.  This is the literal
finite-mask specialization of Lean's ``anchoredSubfiberCredit``.
"""

from __future__ import annotations

import itertools

from audit_relocation_descent import _tables
from search_fiber_hall import (
    child_fibers,
    fiber_lower_bound_from_masks,
    pivot_bad_mask,
)


CLAIMS = (
    ((2, 3, 7, 9, 10, 12, 15, 16, 19), 3, (15, 16), 25),
    ((8, 15, 35, 40, 48, 56, 63, 75, 78), 8, (35, 63, 78), 70),
    ((1, 2, 5, 7, 9, 11, 12, 13), 7, (1, 11, 12), 52),
    ((1, 5, 7, 8, 9, 11, 13, 15), 8, (5, 11, 15), 58),
    ((1, 2, 3, 5), 3, (1, 2), 10),
)


REPAIRED_CLAIMS = (
    (
        (2, 3, 7, 9, 10, 12, 15, 16, 19),
        3,
        (15, 16),
        (15, 16, 2, 7, 9, 10, 12, 19),
        (12, 3, 2, 0, 0, 4, 2, 2),
    ),
    (
        (8, 15, 35, 40, 48, 56, 63, 75, 78),
        8,
        (35, 63, 78),
        (35, 63, 78, 15, 40, 48, 56, 75),
        (14, 12, 8, 6, 20, 4, 0, 6),
    ),
    (
        (1, 2, 5, 7, 9, 11, 12, 13),
        7,
        (1, 11, 12),
        (1, 11, 12, 2, 5, 9, 13),
        (12, 10, 10, 2, 6, 6, 6),
    ),
    (
        (1, 5, 7, 8, 9, 11, 13, 15),
        8,
        (5, 11, 15),
        (5, 11, 15, 1, 7, 9, 13),
        (14, 12, 8, 6, 6, 6, 6),
    ),
    ((1, 2, 3, 5), 3, (1, 2), (1, 2, 5), (4, 2, 4)),
    (
        (6, 8, 15, 21, 28, 35, 40, 48, 75),
        6,
        (8, 15, 21),
        (8, 15, 21, 28, 35, 40, 48, 75),
        (10, 10, 4, 4, 6, 10, 4, 0),
    ),
)


def _strict_anchor_target(image: int, pivot_speed: int, modulus: int) -> bool:
    """Whether a canonical residue is in the strict target set ``T_A``."""

    return image < pivot_speed or image > modulus - pivot_speed


def anchored_two_level_credit(
    speeds: tuple[int, ...],
    pivot: int,
    child: int,
    parents: tuple[int, ...],
    anchor: int,
) -> int:
    """Compute Response 27's corrected credit for one fixed anchor.

    The child fibers use strict bad targets.  Each is partitioned by the full
    residue ``speed[anchor] * r mod M``, including anchor-good targets.
    """

    if anchor not in parents:
        raise ValueError("the anchor must be an earlier parent")
    modulus = (len(speeds) + 1) * speeds[pivot]
    pivot_speed = speeds[pivot]
    parent_masks = {
        parent: pivot_bad_mask(speeds, pivot, parent) for parent in parents
    }
    credit = 0
    for _child_target, child_fiber in child_fibers(speeds, pivot, child):
        subfibers: dict[int, int] = {}
        for residue in range(modulus):
            bit = 1 << residue
            if child_fiber & bit:
                image = (speeds[anchor] * residue) % modulus
                subfibers[image] = subfibers.get(image, 0) | bit
        if sum(mask.bit_count() for mask in subfibers.values()) != child_fiber.bit_count():
            raise AssertionError("full anchor fibers do not partition child fiber")
        for image, subfiber in subfibers.items():
            if _strict_anchor_target(image, pivot_speed, modulus):
                # The entire subfiber is inside the anchor bad set.
                if subfiber & ~parent_masks[anchor]:
                    raise AssertionError("strict anchor target escaped anchor mask")
                credit += subfiber.bit_count()
            else:
                # The entire subfiber is outside the anchor.  Credit only one
                # other parent, exactly as anchoredSubfiberCredit does.
                if subfiber & parent_masks[anchor]:
                    raise AssertionError("good anchor target met anchor mask")
                credit += max(
                    (
                        (subfiber & parent_masks[parent]).bit_count()
                        for parent in parents
                        if parent != anchor
                    ),
                    default=0,
                )
    child_mask = pivot_bad_mask(speeds, pivot, child)
    parent_union = 0
    for parent_mask in parent_masks.values():
        parent_union |= parent_mask
    if credit > (child_mask & parent_union).bit_count():
        raise AssertionError("corrected anchor credit exceeds actual overlap")
    one_level = fiber_lower_bound_from_masks(
        (mask for _target, mask in child_fibers(speeds, pivot, child)),
        parent_masks.values(),
    )
    if credit < one_level:
        raise AssertionError("corrected anchor credit lost one-level credit")
    return credit


def repaired_order_costs(
    speeds: tuple[int, ...],
    pivot_speed: int,
    anchor_speeds: tuple[int, ...],
    order_speeds: tuple[int, ...],
) -> tuple[tuple[int, ...], tuple[int | None, ...]]:
    """Evaluate the corrected credit using a fixed front-loaded anchor set.

    While the anchor prefix is being inserted, only earlier anchors are
    available.  Every later child is charged using exactly the fixed anchor
    set; previous non-anchors are deliberately ignored.
    """

    pivot = speeds.index(pivot_speed)
    order = tuple(speeds.index(speed) for speed in order_speeds)
    fixed_anchors = tuple(speeds.index(speed) for speed in anchor_speeds)
    if order[: len(fixed_anchors)] != fixed_anchors:
        raise ValueError("the fixed anchors must be the order prefix")
    expected = {index for index in range(len(speeds)) if index != pivot}
    if set(order) != expected or len(order) != len(expected):
        raise ValueError("order must contain every nonpivot speed exactly once")
    available_anchors: list[int] = []
    step_costs: list[int] = []
    chosen_anchors: list[int | None] = []
    for child in order:
        bad_size = pivot_bad_mask(speeds, pivot, child).bit_count()
        if not available_anchors:
            credit = 0
            chosen_anchor = None
        else:
            options = tuple(
                (
                    anchored_two_level_credit(
                        speeds, pivot, child, tuple(available_anchors), anchor
                    ),
                    anchor,
                )
                for anchor in available_anchors
            )
            credit, chosen_anchor = max(options)
        step_costs.append(bad_size - credit)
        chosen_anchors.append(
            None if chosen_anchor is None else speeds[chosen_anchor]
        )
        if child in fixed_anchors:
            available_anchors.append(child)
    return tuple(step_costs), tuple(chosen_anchors)


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
    print("repaired Response 27 formula:")
    for speeds, pivot, fixed_anchors, order, claimed_costs in REPAIRED_CLAIMS:
        costs, anchors = repaired_order_costs(speeds, pivot, fixed_anchors, order)
        print(
            f"speeds={speeds} pivot={pivot} fixed_anchors={fixed_anchors} "
            f"order={order} costs={costs} "
            f"total={sum(costs)} chosen_anchors={anchors} "
            f"claimed={claimed_costs} match={costs == claimed_costs}"
        )


if __name__ == "__main__":
    main()
