#!/usr/bin/env python3
"""Exact audit of Response 28's fixed-anchor double average.

For a fixed pivot, all sets are literal bitmasks in the repository's strict
modular model.  ``U(H)`` charges the exact union of an anchor prefix ``H`` and
then uses the corrected anchored two-level credit for each remaining child.
Only anchor sets of size at most three are used here.

This is an audit of a sufficient certificate, not a test of the Lonely Runner
Conjecture itself.  In particular, a failure of the anchor-star inequality
would reject only this averaging route.
"""

from __future__ import annotations

import itertools
import argparse
from fractions import Fraction
from math import gcd

from search_fiber_hall import child_fibers, pivot_bad_mask


STRESS_CASES = (
    (
        "RF",
        (2, 3, 7, 9, 10, 12, 15, 16, 19),
        3,
        15,
        (15, 16, 2),
        (15, 16, 2, 7, 9, 10, 12, 19),
        (12, 3, 2, 0, 0, 4, 2, 2),
        Fraction(328, 21),
    ),
    (
        "GCD-clock failure",
        (8, 15, 35, 40, 48, 56, 63, 75, 78),
        15,
        75,
        (75, 48, 35),
        (75, 48, 35, 8, 40, 56, 63, 78),
        (60, 15, 8, 10, 12, 10, 4, 10),
        Fraction(726, 7),
    ),
    (
        "simpler GCD-clock failure",
        (6, 8, 15, 21, 28, 35, 40, 48, 75),
        28,
        8,
        (8, 15, 48),
        (8, 15, 48, 6, 21, 35, 40, 75),
        (52, 40, 38, 26, 22, 12, 28, 20),
        Fraction(2312, 21),
    ),
    (
        "small structural tuple",
        (1, 2, 3, 5),
        3,
        1,
        (1, 2, 5),
        (1, 2, 5),
        (4, 2, 4),
        Fraction(2),
    ),
    (
        "hard A",
        (1, 2, 5, 7, 9, 11, 12, 13),
        7,
        12,
        (12, 2, 5),
        (12, 2, 5, 1, 9, 11, 13),
        (14, 10, 8, 4, 6, 6, 4),
        Fraction(132, 5),
    ),
    (
        "hard B",
        (1, 5, 7, 8, 9, 11, 13, 15),
        8,
        5,
        (5, 11, 15),
        (5, 11, 15, 1, 7, 9, 13),
        (14, 12, 8, 6, 6, 6, 6),
        Fraction(144, 5),
    ),
)


def _indices(speeds: tuple[int, ...], selected: tuple[int, ...]) -> tuple[int, ...]:
    """Translate distinct speed values into tuple indices."""

    return tuple(speeds.index(speed) for speed in selected)


def _is_strict_bad_target(image: int, pivot_speed: int, modulus: int) -> bool:
    return image < pivot_speed or image > modulus - pivot_speed


def anchored_two_level_credit(
    speeds: tuple[int, ...], pivot: int, child: int, anchors: tuple[int, ...], anchor: int
) -> int:
    """Corrected fixed-anchor credit for one child and distinguished anchor."""

    if anchor not in anchors:
        raise ValueError("distinguished anchor must belong to the anchor set")
    modulus = (len(speeds) + 1) * speeds[pivot]
    pivot_speed = speeds[pivot]
    masks = {parent: pivot_bad_mask(speeds, pivot, parent) for parent in anchors}
    credit = 0
    for _target, child_fiber in child_fibers(speeds, pivot, child):
        subfibers: dict[int, int] = {}
        for residue in range(modulus):
            bit = 1 << residue
            if child_fiber & bit:
                image = speeds[anchor] * residue % modulus
                subfibers[image] = subfibers.get(image, 0) | bit
        for image, subfiber in subfibers.items():
            if _is_strict_bad_target(image, pivot_speed, modulus):
                credit += subfiber.bit_count()
            else:
                credit += max(
                    ((subfiber & masks[parent]).bit_count() for parent in anchors if parent != anchor),
                    default=0,
                )
    return credit


def l2_credit(
    speeds: tuple[int, ...], pivot: int, child: int, anchors: tuple[int, ...]
) -> int:
    """Best corrected two-level credit among distinguished anchors in ``H``."""

    if not anchors:
        return 0
    credit = max(
        anchored_two_level_credit(speeds, pivot, child, anchors, anchor)
        for anchor in anchors
    )
    masks = [pivot_bad_mask(speeds, pivot, anchor) for anchor in anchors]
    union = 0
    for mask in masks:
        union |= mask
    actual = (pivot_bad_mask(speeds, pivot, child) & union).bit_count()
    if credit > actual:
        raise AssertionError("two-level credit exceeded the literal overlap")
    return credit


def anchor_cost(speeds: tuple[int, ...], pivot: int, anchors: tuple[int, ...]) -> int:
    """The exact Response-28 functional ``U_j(H)``."""

    anchor_union = 0
    for anchor in anchors:
        anchor_union |= pivot_bad_mask(speeds, pivot, anchor)
    total = anchor_union.bit_count()
    for child in range(len(speeds)):
        if child == pivot or child in anchors:
            continue
        total += pivot_bad_mask(speeds, pivot, child).bit_count() - l2_credit(
            speeds, pivot, child, anchors
        )
    return total


def insertion_costs(
    speeds: tuple[int, ...], pivot: int, anchors: tuple[int, ...], order: tuple[int, ...]
) -> tuple[int, ...]:
    """Expose the exact per-step vector corresponding to ``U_j(H)``."""

    if order[: len(anchors)] != anchors:
        raise ValueError("the complete order must start with the anchor order")
    available: list[int] = []
    result: list[int] = []
    for child in order:
        bad_size = pivot_bad_mask(speeds, pivot, child).bit_count()
        result.append(bad_size - l2_credit(speeds, pivot, child, tuple(available)))
        if child in anchors:
            available.append(child)
    return tuple(result)


def pair_degree(speeds: tuple[int, ...], pivot: int, h: int) -> int:
    bh = pivot_bad_mask(speeds, pivot, h)
    return sum(
        (bh & pivot_bad_mask(speeds, pivot, child)).bit_count()
        for child in range(len(speeds))
        if child not in (pivot, h)
    )


def second_anchor_gain(speeds: tuple[int, ...], pivot: int, h: int, q: int) -> int:
    bh = pivot_bad_mask(speeds, pivot, h)
    bq = pivot_bad_mask(speeds, pivot, q)
    return sum(
        (pivot_bad_mask(speeds, pivot, child) & bq & ~bh).bit_count()
        for child in range(len(speeds))
        if child not in (pivot, h, q)
    )


def third_anchor_gain(
    speeds: tuple[int, ...], pivot: int, h: int, q: int, r: int
) -> int:
    return anchor_cost(speeds, pivot, (h, q)) - anchor_cost(speeds, pivot, (h, q, r))


def xi(speeds: tuple[int, ...], pivot: int, h: int) -> Fraction:
    """Compute ``Xi_j(h)`` by its literal nested average."""

    others = tuple(i for i in range(len(speeds)) if i != pivot)
    if len(others) < 3:
        raise ValueError("three-anchor averaging requires at least three nonpivots")
    q_terms: list[Fraction] = []
    for q in others:
        if q == h:
            continue
        gains = [
            third_anchor_gain(speeds, pivot, h, q, r)
            for r in others
            if r not in (h, q)
        ]
        if any(gain < 0 for gain in gains):
            raise AssertionError("third-anchor gain is negative")
        q_terms.append(Fraction(second_anchor_gain(speeds, pivot, h, q)) + Fraction(sum(gains), len(gains)))
    return Fraction(pair_degree(speeds, pivot, h)) + Fraction(sum(q_terms), len(q_terms))


def direct_average_triple_cost(speeds: tuple[int, ...], pivot: int, h: int) -> Fraction:
    others = tuple(i for i in range(len(speeds)) if i != pivot)
    costs = [
        anchor_cost(speeds, pivot, (h, q, r))
        for q in others
        if q != h
        for r in others
        if r not in (h, q)
    ]
    return Fraction(sum(costs), len(costs))


def has_anchor_star_certificate(speeds: tuple[int, ...]) -> bool:
    """Whether some pivot/first anchor satisfies the strict Xi inequality."""

    for pivot in range(len(speeds)):
        others = tuple(i for i in range(len(speeds)) if i != pivot)
        s_total = sum(pivot_bad_mask(speeds, pivot, i).bit_count() for i in others)
        threshold = len(speeds) * speeds[pivot]
        if any(xi(speeds, pivot, h) > s_total - threshold for h in others):
            return True
    return False


def has_three_anchor_certificate(speeds: tuple[int, ...]) -> bool:
    """Whether some pivot has a strict corrected certificate with <=3 anchors."""

    for pivot in range(len(speeds)):
        others = tuple(i for i in range(len(speeds)) if i != pivot)
        threshold = len(speeds) * speeds[pivot]
        for size in range(1, min(3, len(others)) + 1):
            if any(
                anchor_cost(speeds, pivot, anchors) < threshold
                for anchors in itertools.combinations(others, size)
            ):
                return True
    return False


def scan_complete_box(runners: int, max_speed: int) -> tuple[int, tuple[int, ...] | None, tuple[int, ...] | None]:
    """Scan every primitive increasing tuple in one finite complete box."""

    if runners < 4:
        raise ValueError("this three-anchor audit starts with four runners")
    checked = 0
    first_anchor_star_failure = None
    first_three_anchor_failure = None
    for speeds in itertools.combinations(range(1, max_speed + 1), runners):
        if gcd(*speeds) != 1:
            continue
        checked += 1
        if first_anchor_star_failure is None and not has_anchor_star_certificate(speeds):
            first_anchor_star_failure = speeds
        if first_three_anchor_failure is None and not has_three_anchor_certificate(speeds):
            first_three_anchor_failure = speeds
    return checked, first_anchor_star_failure, first_three_anchor_failure


def zero_target_count(speeds: tuple[int, ...], pivot: int, h: int, i: int) -> int:
    """Literal count of candidate residues killing both nonpivot speeds."""

    modulus_factor = len(speeds) + 1
    modulus = modulus_factor * speeds[pivot]
    return sum(
        residue % modulus_factor != 0
        and speeds[h] * residue % modulus == 0
        and speeds[i] * residue % modulus == 0
        for residue in range(modulus)
    )


def zero_target_divisor_formula(
    speeds: tuple[int, ...], pivot: int, h: int, i: int
) -> int:
    n_factor = len(speeds) + 1
    a, ah, ai = speeds[pivot], speeds[h], speeds[i]
    return gcd(n_factor * a, ah, ai) - gcd(a, ah, ai)


def audit_case(case: tuple[object, ...]) -> dict[str, object]:
    name, speeds, pivot_speed, h_speed, anchor_speeds, order_speeds, claimed_costs, claimed_xi = case
    assert isinstance(speeds, tuple)
    pivot = speeds.index(pivot_speed)
    h = speeds.index(h_speed)
    anchors = _indices(speeds, anchor_speeds)
    s_total = sum(
        pivot_bad_mask(speeds, pivot, child).bit_count()
        for child in range(len(speeds))
        if child != pivot
    )
    threshold = len(speeds) * pivot_speed
    computed_xi = xi(speeds, pivot, h)
    if computed_xi != claimed_xi:
        raise AssertionError(f"{name}: Xi {computed_xi} != claimed {claimed_xi}")
    average = direct_average_triple_cost(speeds, pivot, h)
    if average != Fraction(s_total) - computed_xi:
        raise AssertionError(f"{name}: double-average identity failed")
    cost = anchor_cost(speeds, pivot, anchors)
    vector = None
    if order_speeds is not None:
        order = _indices(speeds, order_speeds)
        vector = insertion_costs(speeds, pivot, anchors, order)
        if vector != claimed_costs or sum(vector) != cost:
            raise AssertionError(f"{name}: order vector mismatch: {vector}, U={cost}")
    return {
        "name": name,
        "threshold": threshold,
        "S_minus_threshold": s_total - threshold,
        "Xi": computed_xi,
        "surplus": computed_xi - (s_total - threshold),
        "anchors": anchor_speeds,
        "U": cost,
        "costs": vector,
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--scan-runners", type=int)
    parser.add_argument("--max-speed", type=int)
    args = parser.parse_args()
    if args.scan_runners is not None or args.max_speed is not None:
        if args.scan_runners is None or args.max_speed is None:
            parser.error("--scan-runners and --max-speed must be supplied together")
        checked, anchor_failure, three_failure = scan_complete_box(args.scan_runners, args.max_speed)
        print(
            f"complete primitive box: runners={args.scan_runners} "
            f"max_speed={args.max_speed} checked={checked} "
            f"first_anchor_star_failure={anchor_failure} "
            f"first_three_anchor_failure={three_failure}"
        )
        return
    for case in STRESS_CASES:
        print(audit_case(case))


if __name__ == "__main__":
    main()
