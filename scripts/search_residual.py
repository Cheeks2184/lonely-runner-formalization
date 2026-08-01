#!/usr/bin/env python3
"""Explore exact integer tuples outside the documented elementary classes.

This is a research utility, not a proof of the Lonely Runner Conjecture.  It
uses ``check_integer_tuple`` for exact optimization and reports tuples not
covered by either the fastest-runner insertion inequality or the documented
minimum-scale residue bands.
"""

from __future__ import annotations

import argparse
import itertools
import math
from fractions import Fraction

from check_integer_tuple import circle_distance, optimal_loneliness


def covered_by_fast_insertion(speeds: tuple[int, ...]) -> bool:
    """Test insertion of the largest speed after sorting increasingly."""

    return len(speeds) == 1 or speeds[-1] >= len(speeds) * speeds[-2]


def covered_by_minimum_residue_bands(speeds: tuple[int, ...]) -> bool:
    """Test the minimum-scale bands from ``docs/structured-classes.md``."""

    runner_count = len(speeds)
    modulus = runner_count + 1
    minimum = speeds[0]
    for speed in speeds:
        ratio = Fraction(speed, minimum)
        quotient = (ratio - 1) // modulus
        if not quotient * modulus + 1 <= ratio <= quotient * modulus + runner_count:
            return False
    return True


def divisor_insertion_condition_indices(speeds: tuple[int, ...]) -> tuple[int, ...]:
    """Return exceptional indices satisfying Sol Pro's divisor inequality.

    For an exceptional runner ``j``, let ``D`` be the gcd of all other speeds
    and ``m = D / gcd(D, a_j)``.  The arithmetic condition is
    ``(n + 1) * (m - 1) >= 2 * m``.  Turning this condition into an LRC proof
    also requires the conjecture for the divided ``n - 1`` tuple; this helper
    deliberately reports only the independently checkable arithmetic part.
    """

    if len(speeds) < 2:
        return ()
    modulus_factor = len(speeds) + 1
    result = []
    for exceptional, speed in enumerate(speeds):
        others = speeds[:exceptional] + speeds[exceptional + 1 :]
        deletion_gcd = math.gcd(*others)
        orbit_size = deletion_gcd // math.gcd(deletion_gcd, speed)
        if modulus_factor * (orbit_size - 1) >= 2 * orbit_size:
            result.append(exceptional)
    return tuple(result)


def witness_on_minimum_grid(speeds: tuple[int, ...]) -> Fraction | None:
    """Find a witness ``k / ((n+1) min(speeds))`` in one exact period."""

    target = Fraction(1, len(speeds) + 1)
    denominator = (len(speeds) + 1) * speeds[0]
    for numerator in range(denominator):
        time = Fraction(numerator, denominator)
        if all(circle_distance(speed, time) >= target for speed in speeds):
            return time
    return None


def witness_on_any_speed_grid(speeds: tuple[int, ...]) -> Fraction | None:
    """Find a witness ``k / ((n+1) a)`` for some speed ``a`` in the tuple."""

    target = Fraction(1, len(speeds) + 1)
    for anchor in speeds:
        denominator = (len(speeds) + 1) * anchor
        for numerator in range(denominator):
            time = Fraction(numerator, denominator)
            if all(circle_distance(speed, time) >= target for speed in speeds):
                return time
    return None


def witness_on_anchor_grid(speeds: tuple[int, ...], anchor: int) -> Fraction | None:
    """Find a witness on the ``(n+1) * anchor`` grid, if one exists."""

    target = Fraction(1, len(speeds) + 1)
    denominator = (len(speeds) + 1) * anchor
    for numerator in range(denominator):
        time = Fraction(numerator, denominator)
        if all(circle_distance(speed, time) >= target for speed in speeds):
            return time
    return None


def pair_sum_spectrum_optimum(
    speeds: tuple[int, ...],
) -> tuple[Fraction, Fraction, tuple[int, int]]:
    """Optimize exactly over the audited pair-sum critical spectrum."""

    if len(speeds) < 2:
        raise ValueError("pair-sum spectrum requires at least two speeds")
    best_value = Fraction(-1)
    best_time = Fraction(0)
    best_pair = (0, 1)
    for first, second in itertools.combinations(range(len(speeds)), 2):
        denominator = speeds[first] + speeds[second]
        for numerator in range(denominator):
            time = Fraction(numerator, denominator)
            value = min(circle_distance(speed, time) for speed in speeds)
            if value > best_value:
                best_value = value
                best_time = time
                best_pair = (first, second)
    return best_value, best_time, best_pair


def fastest_half_period_certificate(
    speeds: tuple[int, ...],
) -> tuple[Fraction | None, Fraction | None, tuple[int, ...]]:
    """Apply the elementary union bound on fastest-runner half-periods.

    At ``t = (2k+1)/(2V)``, where ``V`` is the largest speed, the fastest
    runner is exactly at distance ``1/2``.  For each other speed we count the
    values of ``k`` that violate the target.  If the sum of those counts is
    smaller than ``V``, their union cannot cover all ``V`` choices.  The
    returned witness is the first uncovered choice; the tuple records the
    individual bad-set cardinalities.  A witness may still exist when the
    union-bound certificate fails.
    """

    target = Fraction(1, len(speeds) + 1)
    fastest = speeds[-1]
    bad_sets = []
    for speed in speeds[:-1]:
        bad_sets.append(
            {
                k
                for k in range(fastest)
                if min(
                    (speed * (2 * k + 1)) % (2 * fastest),
                    2 * fastest - (speed * (2 * k + 1)) % (2 * fastest),
                )
                * (len(speeds) + 1)
                < 2 * fastest
            }
        )
    counts = tuple(len(values) for values in bad_sets)
    covered = set().union(*bad_sets) if bad_sets else set()
    uncovered = set(range(fastest)) - covered
    actual = Fraction(2 * min(uncovered) + 1, 2 * fastest) if uncovered else None
    certified = actual if sum(counts) < fastest else None
    return certified, actual, counts


def _cyclic_residue_distance(value: int, modulus: int) -> int:
    residue = value % modulus
    return min(residue, modulus - residue)


def pivot_bad_mask(speeds: tuple[int, ...], pivot: int, other: int) -> int:
    """Literal ``B_ij`` mask from Sol Pro round 5.

    Bit ``r`` is set exactly when ``r`` is a pivot-good residue modulo
    ``N*a_j`` but runner ``i`` is strictly below the ``1/N`` target.
    """

    modulus_factor = len(speeds) + 1
    pivot_speed = speeds[pivot]
    modulus = modulus_factor * pivot_speed
    mask = 0
    for residue in range(modulus):
        if residue % modulus_factor == 0:
            continue
        if _cyclic_residue_distance(residue * speeds[other], modulus) < pivot_speed:
            mask |= 1 << residue
    return mask


def _ceil_div(numerator: int, denominator: int) -> int:
    return (numerator + denominator - 1) // denominator


def pivot_bad_count_formula(speeds: tuple[int, ...], pivot: int, other: int) -> int:
    """Exact closed formula from Sol Pro round 5 for ``|B_ij|``.

    The regression suite compares it with literal residue masks.  Its proof is
    recorded in ``docs/modular-pivot-certificates.md``.
    """

    modulus_factor = len(speeds) + 1
    pivot_speed = speeds[pivot]
    other_speed = speeds[other]
    common_modulus_gcd = math.gcd(other_speed, modulus_factor * pivot_speed)
    speed_gcd = math.gcd(other_speed, pivot_speed)
    all_bad = common_modulus_gcd * (
        2 * _ceil_div(pivot_speed, common_modulus_gcd) - 1
    )
    excluded_pivot_bad = speed_gcd * (
        2 * _ceil_div(pivot_speed, modulus_factor * speed_gcd) - 1
    )
    return all_bad - excluded_pivot_bad


def _best_ordered_parent_bound(
    others: tuple[int, ...],
    masks: dict[int, int],
    counts: dict[int, int],
    parent_capacity: int,
) -> int:
    """Exact dynamic program over all orders and bounded parent subsets."""

    if not others:
        return 0
    positions = {other: position for position, other in enumerate(others)}
    full_state = (1 << len(others)) - 1
    infinity = sum(counts.values()) + 1
    best = [infinity] * (full_state + 1)
    best[0] = 0
    for state in range(full_state + 1):
        if best[state] == infinity:
            continue
        previous = tuple(
            other
            for other in others
            if state & (1 << positions[other])
        )
        for other in others:
            bit = 1 << positions[other]
            if state & bit:
                continue
            best_overlap = 0
            max_parents = min(parent_capacity, len(previous))
            for parent_count in range(1, max_parents + 1):
                for parents in itertools.combinations(previous, parent_count):
                    parent_union = 0
                    for parent in parents:
                        parent_union |= masks[parent]
                    best_overlap = max(
                        best_overlap,
                        (masks[other] & parent_union).bit_count(),
                    )
            next_state = state | bit
            best[next_state] = min(
                best[next_state], best[state] + counts[other] - best_overlap
            )
    return best[full_state]


def pivot_certificates(
    speeds: tuple[int, ...],
) -> tuple[bool, bool, bool, int]:
    """Return union-bound, two-parent, actual-pivot, and formula-audit data.

    The two-parent certificate searches every pivot and every ordering of the
    other runners.  For each newly inserted bad set it subtracts the largest
    overlap with the union of either one or two earlier bad sets.  This is a
    lower bound on its overlap with the full earlier union, hence gives a
    rigorous upper bound on the final union cardinality.
    """

    modulus_factor = len(speeds) + 1
    union_certified = False
    two_parent_certified = False
    actual_pivot_witness = False
    formula_mismatches = 0

    for pivot, pivot_speed in enumerate(speeds):
        others = tuple(index for index in range(len(speeds)) if index != pivot)
        masks = {other: pivot_bad_mask(speeds, pivot, other) for other in others}
        counts = {other: masks[other].bit_count() for other in others}
        for other in others:
            formula_mismatches += counts[other] != pivot_bad_count_formula(
                speeds, pivot, other
            )

        universe_size = (modulus_factor - 1) * pivot_speed
        union_certified |= sum(counts.values()) < universe_size
        union_mask = 0
        for mask in masks.values():
            union_mask |= mask
        actual_pivot_witness |= union_mask.bit_count() < universe_size

        if not two_parent_certified:
            two_parent_certified |= (
                _best_ordered_parent_bound(others, masks, counts, 2)
                < universe_size
            )

    return union_certified, two_parent_certified, actual_pivot_witness, formula_mismatches


def pivot_parent_best_bounds(
    speeds: tuple[int, ...], parent_capacity: int
) -> tuple[tuple[int, int, int], ...]:
    """Return best bounded-parent, universe, and exact-union sizes per pivot.

    `parent_capacity = 0` is the simple sum bound.  A positive capacity allows
    each newly ordered bad set to credit overlap with a union of at most that
    many earlier bad sets.  Every permutation and allowable parent subset is
    searched exactly, so this is intended for small research instances rather
    than large production enumeration.
    """

    if parent_capacity < 0:
        raise ValueError("parent capacity must be nonnegative")
    modulus_factor = len(speeds) + 1
    results = []
    for pivot, pivot_speed in enumerate(speeds):
        others = tuple(index for index in range(len(speeds)) if index != pivot)
        masks = {other: pivot_bad_mask(speeds, pivot, other) for other in others}
        counts = {other: masks[other].bit_count() for other in others}
        exact_union = 0
        for mask in masks.values():
            exact_union |= mask
        simple = sum(counts.values())
        best = simple if parent_capacity == 0 else _best_ordered_parent_bound(
            others, masks, counts, parent_capacity
        )
        results.append(
            (best, (modulus_factor - 1) * pivot_speed, exact_union.bit_count())
        )
    return tuple(results)


def adjacent_anchor_bounds(
    speeds: tuple[int, ...],
) -> tuple[tuple[int, int, int], ...]:
    """Return proposed adjacent-anchor bound, universe, and exact union.

    This exposes the rejected Sol Pro follow-up conjecture as a regression
    target.  For an endpoint pivot the anchors are the next two inward speeds;
    for an interior pivot they are its immediate neighbors.
    """

    if len(speeds) < 3:
        raise ValueError("adjacent anchors require at least three speeds")
    modulus_factor = len(speeds) + 1
    results = []
    for pivot, pivot_speed in enumerate(speeds):
        if pivot == 0:
            anchors = (1, 2)
        elif pivot == len(speeds) - 1:
            anchors = (len(speeds) - 3, len(speeds) - 2)
        else:
            anchors = (pivot - 1, pivot + 1)
        masks = {
            other: pivot_bad_mask(speeds, pivot, other)
            for other in range(len(speeds))
            if other != pivot
        }
        anchor_union = masks[anchors[0]] | masks[anchors[1]]
        bound = anchor_union.bit_count()
        exact_union = 0
        for other, mask in masks.items():
            exact_union |= mask
            if other not in anchors:
                bound += (mask & ~anchor_union).bit_count()
        results.append(
            (bound, (modulus_factor - 1) * pivot_speed, exact_union.bit_count())
        )
    return tuple(results)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--runners", type=int, required=True)
    parser.add_argument("--max-speed", type=int, required=True)
    parser.add_argument("--limit", type=int, default=20)
    parser.add_argument(
        "--equality-blocks",
        action="store_true",
        help="search multiplier blocks with max = n min and no strict n-runner margin",
    )
    parser.add_argument(
        "--primitive-only",
        action="store_true",
        help="restrict the search to tuples whose common gcd is one",
    )
    parser.add_argument(
        "--counts-only",
        action="store_true",
        help="skip optimization and grids; report scalable residual/half-period counts",
    )
    parser.add_argument(
        "--sol-pivot-counts",
        action="store_true",
        help="audit Sol round-5 pivot formulas and certificate coverage",
    )
    parser.add_argument(
        "--parent-capacity",
        type=int,
        help="also count ordered certificates with this parent capacity",
    )
    args = parser.parse_args()
    if not 1 <= args.runners <= args.max_speed:
        parser.error("require 1 <= runners <= max-speed")
    if args.parent_capacity is not None and args.parent_capacity < 0:
        parser.error("parent capacity must be nonnegative")
    if args.parent_capacity is not None and not args.sol_pivot_counts:
        parser.error("--parent-capacity requires --sol-pivot-counts")

    if args.equality_blocks:
        target = Fraction(1, args.runners + 1)
        found = []
        interior = range(2, args.runners)
        for size in range(2, args.runners):
            for middle in itertools.combinations(interior, size - 2):
                speeds = (1, *middle, args.runners)
                optimum, witness, _ = optimal_loneliness(speeds)
                if optimum == target:
                    found.append((speeds, optimum, witness))
        print(f"equality_blocks_without_strict_margin={len(found)}")
        for item in found[: args.limit]:
            print(item)
        return 0

    residual = []
    total_count = 0
    fast_count = 0
    band_after_nonfast_count = 0
    residual_count = 0
    half_certificate_count = 0
    half_actual_count = 0
    pivot_union_count = 0
    pivot_two_parent_count = 0
    pivot_actual_count = 0
    pivot_formula_mismatches = 0
    selected_parent_count = 0
    divisor_condition_count = 0
    for speeds in itertools.combinations(range(1, args.max_speed + 1), args.runners):
        if args.primitive_only and math.gcd(*speeds) != 1:
            continue
        total_count += 1
        if covered_by_fast_insertion(speeds):
            fast_count += 1
            continue
        if covered_by_minimum_residue_bands(speeds):
            band_after_nonfast_count += 1
            continue
        residual_count += 1
        divisor_condition_count += bool(divisor_insertion_condition_indices(speeds))
        if args.sol_pivot_counts:
            union_ok, two_parent_ok, actual_ok, mismatches = pivot_certificates(speeds)
            pivot_union_count += union_ok
            pivot_two_parent_count += two_parent_ok
            pivot_actual_count += actual_ok
            pivot_formula_mismatches += mismatches
            if args.parent_capacity is not None:
                selected_parent_count += any(
                    bound < universe
                    for bound, universe, _ in pivot_parent_best_bounds(
                        speeds, args.parent_capacity
                    )
                )
            continue
        if args.counts_only:
            half_witness, actual_half_witness, _ = fastest_half_period_certificate(speeds)
            half_certificate_count += half_witness is not None
            half_actual_count += actual_half_witness is not None
            continue
        optimum, witness, _ = optimal_loneliness(speeds)
        half_witness, actual_half_witness, bad_counts = fastest_half_period_certificate(speeds)
        residual.append(
            (
                speeds,
                optimum,
                witness,
                witness_on_minimum_grid(speeds),
                witness_on_any_speed_grid(speeds),
                witness_on_anchor_grid(speeds, speeds[-1]),
                half_witness,
                actual_half_witness,
                bad_counts,
            )
        )

    scope = "primitive" if args.primitive_only else "all"
    if args.sol_pivot_counts:
        parent_summary = ""
        if args.parent_capacity is not None:
            parent_summary = (
                f" pivot_parent_capacity={args.parent_capacity} "
                f"pivot_parent_certified={selected_parent_count}"
            )
        print(
            f"scope={scope} max_speed={args.max_speed} runners={args.runners} "
            f"total={total_count} fast={fast_count} "
            f"band_after_nonfast={band_after_nonfast_count} "
            f"residual={residual_count} pivot_formula_mismatches={pivot_formula_mismatches} "
            f"pivot_union_certified={pivot_union_count} "
            f"pivot_two_parent_certified={pivot_two_parent_count} "
            f"pivot_actual={pivot_actual_count} "
            f"divisor_insertion_condition={divisor_condition_count}"
            f"{parent_summary}"
        )
        return 0
    if args.counts_only:
        print(
            f"scope={scope} max_speed={args.max_speed} "
            f"runners={args.runners} residual={residual_count} "
            f"fastest_half_period_certified={half_certificate_count} "
            f"fastest_half_period_actual={half_actual_count} "
            f"divisor_insertion_condition={divisor_condition_count}"
        )
        return 0

    target = Fraction(1, args.runners + 1)
    tight = sum(optimum == target for _, optimum, _, _, _, _, _, _, _ in residual)
    no_grid = sum(grid is None for _, _, _, grid, _, _, _, _, _ in residual)
    no_anchor_grid = sum(grid is None for _, _, _, _, grid, _, _, _, _ in residual)
    no_fastest_grid = sum(grid is None for _, _, _, _, _, grid, _, _, _ in residual)
    half_certified = sum(half is not None for _, _, _, _, _, _, half, _, _ in residual)
    half_actual = sum(half is not None for _, _, _, _, _, _, _, half, _ in residual)
    print(
        f"scope={scope} residual={len(residual)} tight={tight} "
        f"without_minimum_grid_witness={no_grid} "
        f"without_any_speed_grid_witness={no_anchor_grid} "
        f"without_fastest_grid_witness={no_fastest_grid} "
        f"fastest_half_period_certified={half_certified} "
        f"fastest_half_period_actual={half_actual}"
    )
    for speeds, optimum, witness, grid, anchor_grid, fastest_grid, half, actual_half, counts in residual[: args.limit]:
        print(
            f"{speeds}: optimum={optimum} earliest={witness} "
            f"minimum_grid={grid} any_speed_grid={anchor_grid} "
            f"fastest_grid={fastest_grid} fastest_half_certificate={half} "
            f"fastest_half_actual={actual_half} bad_counts={counts}"
        )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
