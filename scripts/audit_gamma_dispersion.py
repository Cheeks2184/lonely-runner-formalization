#!/usr/bin/env python3
"""Audit a deterministic dispersion lower bound for the anchor-star Gamma term.

This script uses the exact strict modular masks and corrected two-level credits
from :mod:`audit_anchor_star`.  It is deliberately separate from the main
anchor-star audit: its purpose is to test one new structural lower bound, not
to search for or claim a Lonely Runner proof.

For a fixed pivot and first anchor ``h``, partition each child bad fiber first
by its child target and then by the full ``h``-image.  Outside the bad targets
of ``h``, let ``c_q(C) = |C intersect B_q|``.  The audited inequality is

    Gamma(h) >= 1 / ((m-1)(m-2))
      * sum_i sum_C sum_{q<r, q,r != h,i} |c_q(C)-c_r(C)|,

where ``m`` is the number of nonpivot runners.  The proof is recorded in
``docs/gamma-arithmetic-audit.md``.
"""

from __future__ import annotations

import argparse
import itertools
from fractions import Fraction
from math import gcd

from audit_anchor_star import (
    STRESS_CASES,
    anchored_two_level_credit,
    pair_degree,
    pivot_bad_mask,
    second_anchor_gain,
    third_anchor_gain,
    xi,
)
from search_fiber_hall import child_fibers


def _strict_bad_target(image: int, pivot_speed: int, modulus: int) -> bool:
    return image < pivot_speed or image > modulus - pivot_speed


def gamma_term(speeds: tuple[int, ...], pivot: int, h: int) -> Fraction:
    """Return the exact ordered-pair average of the third-anchor gain."""

    others = tuple(index for index in range(len(speeds)) if index != pivot)
    denominator = (len(others) - 1) * (len(others) - 2)
    if denominator <= 0:
        raise ValueError("Gamma averaging requires at least three nonpivots")
    total = sum(
        third_anchor_gain(speeds, pivot, h, q, r)
        for q in others
        if q != h
        for r in others
        if r not in (h, q)
    )
    return Fraction(total, denominator)


def gamma_from_xi(speeds: tuple[int, ...], pivot: int, h: int) -> Fraction:
    """Independently recover Gamma as Xi minus its pair-gain part."""

    others = tuple(index for index in range(len(speeds)) if index != pivot)
    pair_part = Fraction(pair_degree(speeds, pivot, h)) + Fraction(
        sum(
            second_anchor_gain(speeds, pivot, h, q)
            for q in others
            if q != h
        ),
        len(others) - 1,
    )
    return xi(speeds, pivot, h) - pair_part


def gamma_dispersion_numerator(
    speeds: tuple[int, ...], pivot: int, h: int
) -> int:
    """Return the integer numerator in the deterministic dispersion bound."""

    others = tuple(index for index in range(len(speeds)) if index != pivot)
    modulus = (len(speeds) + 1) * speeds[pivot]
    pivot_speed = speeds[pivot]
    masks = {index: pivot_bad_mask(speeds, pivot, index) for index in others}
    total = 0
    for child in others:
        if child == h:
            continue
        comparison_anchors = tuple(
            index for index in others if index not in (h, child)
        )
        for _target, child_fiber in child_fibers(speeds, pivot, child):
            cells: dict[int, int] = {}
            remaining = child_fiber
            while remaining:
                bit = remaining & -remaining
                residue = bit.bit_length() - 1
                image = speeds[h] * residue % modulus
                cells[image] = cells.get(image, 0) | bit
                remaining ^= bit
            for image, cell in cells.items():
                if _strict_bad_target(image, pivot_speed, modulus):
                    continue
                counts = {
                    anchor: (cell & masks[anchor]).bit_count()
                    for anchor in comparison_anchors
                }
                total += sum(
                    abs(counts[q] - counts[r])
                    for q, r in itertools.combinations(comparison_anchors, 2)
                )
    return total


def gamma_aggregate_dispersion_bound(
    speeds: tuple[int, ...], pivot: int, h: int
) -> Fraction:
    """Collapse every ``h``-nonbad cell before taking absolute differences.

    Triangle inequality makes this no larger than the cellwise dispersion
    bound.  It uses only pair and triple intersection totals and therefore
    records exactly what is lost if the nonzero target cells are discarded.
    """

    others = tuple(index for index in range(len(speeds)) if index != pivot)
    masks = {index: pivot_bad_mask(speeds, pivot, index) for index in others}
    numerator = 0
    for child in others:
        if child == h:
            continue
        anchors = tuple(index for index in others if index not in (h, child))
        counts = {
            q: (masks[child] & masks[q] & ~masks[h]).bit_count()
            for q in anchors
        }
        numerator += sum(
            abs(counts[q] - counts[r])
            for q, r in itertools.combinations(anchors, 2)
        )
    denominator = (len(others) - 1) * (len(others) - 2)
    return Fraction(numerator, denominator)


def gamma_dispersion_bound(
    speeds: tuple[int, ...], pivot: int, h: int
) -> Fraction:
    """Return the rational lower bound for the averaged Gamma term."""

    nonpivots = len(speeds) - 1
    denominator = (nonpivots - 1) * (nonpivots - 2)
    if denominator <= 0:
        raise ValueError("dispersion averaging requires at least three nonpivots")
    return Fraction(gamma_dispersion_numerator(speeds, pivot, h), denominator)


def gamma_two_distinguished_bound(
    speeds: tuple[int, ...], pivot: int, h: int
) -> Fraction:
    """Use the better of distinguished ``h`` and ``q`` for every child.

    Both choices dominate the exact pair credit, so this is a nonnegative
    lower bound.  It is stronger than the closed-form dispersion bound but is
    retained mainly to audit when the third distinguished anchor is essential.
    """

    others = tuple(index for index in range(len(speeds)) if index != pivot)
    denominator = (len(others) - 1) * (len(others) - 2)
    total = 0
    for q in others:
        if q == h:
            continue
        pair = (h, q)
        for r in others:
            if r in pair:
                continue
            triple = (h, q, r)
            for child in others:
                if child in triple:
                    continue
                pair_credit = anchored_two_level_credit(
                    speeds, pivot, child, pair, h
                )
                credit_h = anchored_two_level_credit(
                    speeds, pivot, child, triple, h
                )
                credit_q = anchored_two_level_credit(
                    speeds, pivot, child, triple, q
                )
                if min(credit_h, credit_q) < pair_credit:
                    raise AssertionError("a retained distinguished anchor lost credit")
                total += max(credit_h, credit_q) - pair_credit
    return Fraction(total, denominator)


def audit_instance(
    speeds: tuple[int, ...], pivot: int, h: int
) -> dict[str, object]:
    exact = gamma_term(speeds, pivot, h)
    recovered = gamma_from_xi(speeds, pivot, h)
    lower = gamma_dispersion_bound(speeds, pivot, h)
    aggregate = gamma_aggregate_dispersion_bound(speeds, pivot, h)
    two_distinguished = gamma_two_distinguished_bound(speeds, pivot, h)
    if exact != recovered:
        raise AssertionError(f"Gamma decomposition mismatch: {exact} != {recovered}")
    if not aggregate <= lower <= exact:
        raise AssertionError(f"dispersion bound failed: {lower} > {exact}")
    if not lower <= two_distinguished <= exact:
        raise AssertionError(
            "nested Gamma bounds failed: "
            f"{lower} <= {two_distinguished} <= {exact}"
        )
    others = tuple(index for index in range(len(speeds)) if index != pivot)
    pair_part = Fraction(pair_degree(speeds, pivot, h)) + Fraction(
        sum(
            second_anchor_gain(speeds, pivot, h, q)
            for q in others
            if q != h
        ),
        len(others) - 1,
    )
    s_total = sum(
        pivot_bad_mask(speeds, pivot, child).bit_count()
        for child in others
    )
    required = s_total - len(speeds) * speeds[pivot]
    return {
        "pivot": speeds[pivot],
        "h": speeds[h],
        "pair_part": pair_part,
        "Gamma": exact,
        "aggregate_dispersion": aggregate,
        "dispersion": lower,
        "two_distinguished": two_distinguished,
        "dispersion_gap": exact - lower,
        "third_distinguished_gap": exact - two_distinguished,
        "required": required,
        "certified_surplus": pair_part + lower - required,
        "aggregate_surplus": pair_part + aggregate - required,
    }


def scan_complete_box(runners: int, max_speed: int) -> dict[str, object]:
    checked_tuples = 0
    checked_pairs = 0
    equality_pairs = 0
    zero_bound_positive_gamma = 0
    largest_gap: tuple[Fraction, tuple[int, ...], int, int] | None = None
    for speeds in itertools.combinations(range(1, max_speed + 1), runners):
        if gcd(*speeds) != 1:
            continue
        checked_tuples += 1
        for pivot in range(runners):
            for h in range(runners):
                if h == pivot:
                    continue
                checked_pairs += 1
                row = audit_instance(speeds, pivot, h)
                exact = row["Gamma"]
                lower = row["dispersion"]
                assert isinstance(exact, Fraction) and isinstance(lower, Fraction)
                if exact == lower:
                    equality_pairs += 1
                if lower == 0 and exact > 0:
                    zero_bound_positive_gamma += 1
                gap = exact - lower
                if largest_gap is None or gap > largest_gap[0]:
                    largest_gap = (gap, speeds, speeds[pivot], speeds[h])
    return {
        "runners": runners,
        "max_speed": max_speed,
        "tuples": checked_tuples,
        "pivot_anchor_pairs": checked_pairs,
        "equalities": equality_pairs,
        "zero_bound_positive_gamma": zero_bound_positive_gamma,
        "largest_gap": largest_gap,
    }


def has_dispersion_star_certificate(speeds: tuple[int, ...]) -> bool:
    """Test the new sufficient inequality without computing the exact Gamma."""

    for pivot in range(len(speeds)):
        others = tuple(index for index in range(len(speeds)) if index != pivot)
        s_total = sum(
            pivot_bad_mask(speeds, pivot, child).bit_count()
            for child in others
        )
        required = s_total - len(speeds) * speeds[pivot]
        for h in others:
            pair_part = Fraction(pair_degree(speeds, pivot, h)) + Fraction(
                sum(
                    second_anchor_gain(speeds, pivot, h, q)
                    for q in others
                    if q != h
                ),
                len(others) - 1,
            )
            if pair_part + gamma_dispersion_bound(speeds, pivot, h) > required:
                return True
    return False


def scan_dispersion_certificate_box(
    runners: int, max_speed: int
) -> dict[str, object]:
    """Search a complete primitive box for failure of the sufficient bound."""

    checked = 0
    first_failure = None
    for speeds in itertools.combinations(range(1, max_speed + 1), runners):
        if gcd(*speeds) != 1:
            continue
        checked += 1
        if not has_dispersion_star_certificate(speeds):
            first_failure = speeds
            break
    return {
        "runners": runners,
        "max_speed": max_speed,
        "checked_until_failure": checked,
        "first_dispersion_star_failure": first_failure,
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--scan-runners", type=int)
    parser.add_argument("--max-speed", type=int)
    parser.add_argument("--certificate-only", action="store_true")
    args = parser.parse_args()
    if args.scan_runners is not None or args.max_speed is not None:
        if args.scan_runners is None or args.max_speed is None:
            parser.error("--scan-runners and --max-speed must be supplied together")
        if args.certificate_only:
            print(
                scan_dispersion_certificate_box(
                    args.scan_runners, args.max_speed
                )
            )
        else:
            print(scan_complete_box(args.scan_runners, args.max_speed))
        return

    for case in STRESS_CASES:
        _name, speeds, pivot_speed, h_speed, *_rest = case
        pivot = speeds.index(pivot_speed)
        h = speeds.index(h_speed)
        print(_name, audit_instance(speeds, pivot, h))


if __name__ == "__main__":
    main()
