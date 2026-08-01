#!/usr/bin/env python3
"""Test the random-order pairwise lower bound for one-level fiber credit.

For ``m`` nonpivot bad sets, random-order averaging proves that some order has
one-level additive upper bound at most

    sum_i |B_i| - (2/m) * sum_{i<j} |B_i intersect B_j|.

This script tests whether that *generic set-system* estimate is already
strictly below the pivot candidate size for the arithmetic modular bad sets.
It uses integer cross multiplication throughout.
"""

from __future__ import annotations

import argparse
import itertools
import json
import math
import random
from fractions import Fraction
from typing import Sequence

from search_fiber_hall import child_fibers, find_additive_certificate
from search_residual import pivot_bad_mask


def pivot_average_data(speeds: tuple[int, ...], pivot: int) -> dict[str, object]:
    """Return the exact pairwise-average inequality for one pivot."""

    children = tuple(i for i in range(len(speeds)) if i != pivot)
    m = len(children)
    masks = tuple(pivot_bad_mask(speeds, pivot, child) for child in children)
    size_sum = sum(mask.bit_count() for mask in masks)
    intersection_sum = sum(
        (masks[i] & masks[j]).bit_count()
        for i, j in itertools.combinations(range(m), 2)
    )
    universe_size = len(speeds) * speeds[pivot]

    # m * U_average = m * size_sum - 2 * intersection_sum.
    scaled_upper = m * size_sum - 2 * intersection_sum
    scaled_universe = m * universe_size
    return {
        "pivot": speeds[pivot],
        "nonpivot_count": m,
        "size_sum": size_sum,
        "pair_intersection_sum": intersection_sum,
        "scaled_upper": scaled_upper,
        "scaled_universe": scaled_universe,
        "strict": scaled_upper < scaled_universe,
    }


def pivot_ranked_fiber_expectation(speeds: tuple[int, ...], pivot: int) -> dict[str, object]:
    """Compute the exact random-order expectation using fiberwise ranks.

    Fix a child fiber and sort all other-parent intersection sizes as
    ``y_1 >= ... >= y_(m-1)``.  At integer height ``t``, if ``c_t`` parents
    have intersection at least ``t``, the chance that one precedes the child
    is ``c_t/(c_t+1)``.  The integer tail-sum formula telescopes to weights
    ``1/(j(j+1))`` on the ranked values.  This remains valid with ties.
    Linearity of expectation applies across children and fibers even though
    the credit events are dependent.
    """

    children = tuple(i for i in range(len(speeds)) if i != pivot)
    masks = {child: pivot_bad_mask(speeds, pivot, child) for child in children}
    expected_credit = Fraction(0)
    size_sum = sum(mask.bit_count() for mask in masks.values())
    for child in children:
        possible_parents = tuple(parent for parent in children if parent != child)
        for _target, fiber in child_fibers(speeds, pivot, child):
            ranked = sorted(
                ((fiber & masks[parent]).bit_count() for parent in possible_parents),
                reverse=True,
            )
            expected_credit += sum(
                (Fraction(value, rank * (rank + 1)) for rank, value in enumerate(ranked, 1)),
                Fraction(0),
            )
    expected_upper = Fraction(size_sum) - expected_credit
    universe_size = len(speeds) * speeds[pivot]
    return {
        "pivot": speeds[pivot],
        "size_sum": size_sum,
        "expected_credit": str(expected_credit),
        "expected_upper": str(expected_upper),
        "universe_size": universe_size,
        "strict": expected_upper < universe_size,
    }


def tuple_report(speeds: tuple[int, ...]) -> dict[str, object]:
    """Test every pivot and compare with the exact additive DP."""

    pivots = tuple(pivot_average_data(speeds, pivot) for pivot in range(len(speeds)))
    ranked_pivots = tuple(
        pivot_ranked_fiber_expectation(speeds, pivot) for pivot in range(len(speeds))
    )
    additive = find_additive_certificate(speeds)
    return {
        "speeds": list(speeds),
        "average_certified": any(bool(data["strict"]) for data in pivots),
        "ranked_fiber_certified": any(bool(data["strict"]) for data in ranked_pivots),
        "additive_certified": additive is not None,
        "pivots": pivots,
        "ranked_fiber_pivots": ranked_pivots,
    }


def first_failure(
    runners: int, max_speed: int, criterion: str
) -> dict[str, object] | None:
    """Find the first primitive tuple not certified by the chosen average."""

    for speeds in itertools.combinations(range(1, max_speed + 1), runners):
        if math.gcd(*speeds) != 1:
            continue
        report = tuple_report(speeds)
        if not report[criterion]:
            return report
    return None


def first_random_failure(
    runners: int, max_speed: int, samples: int, seed: int, criterion: str
) -> dict[str, object] | None:
    """Test a deterministic sample of primitive increasing tuples."""

    generator = random.Random(seed)
    checked: set[tuple[int, ...]] = set()
    attempts = 0
    while len(checked) < samples and attempts < 1000 * samples:
        attempts += 1
        speeds = tuple(sorted(generator.sample(range(1, max_speed + 1), runners)))
        if speeds in checked or math.gcd(*speeds) != 1:
            continue
        checked.add(speeds)
        report = tuple_report(speeds)
        if not report[criterion]:
            report["sample_index"] = len(checked)
            report["seed"] = seed
            return report
    if len(checked) != samples:
        raise RuntimeError("could not generate the requested primitive sample")
    return None


def _build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--tuple", nargs="+", type=int, dest="speeds")
    parser.add_argument("--runners", type=int, default=4)
    parser.add_argument("--max-speed", type=int, default=12)
    parser.add_argument(
        "--criterion",
        choices=("pairwise", "ranked-fiber"),
        default="pairwise",
    )
    parser.add_argument("--samples", type=int)
    parser.add_argument("--seed", type=int, default=37)
    return parser


def main(argv: Sequence[str] | None = None) -> int:
    args = _build_parser().parse_args(argv)
    if args.speeds:
        speeds = tuple(args.speeds)
        if len(speeds) < 3 or any(a <= 0 for a in speeds) or len(set(speeds)) != len(speeds):
            raise SystemExit("speeds must be at least three distinct positive integers")
        report = tuple_report(speeds)
    else:
        key = "average_certified" if args.criterion == "pairwise" else "ranked_fiber_certified"
        report = (
            first_random_failure(
                args.runners, args.max_speed, args.samples, args.seed, key
            )
            if args.samples is not None
            else first_failure(args.runners, args.max_speed, key)
        )
    print(json.dumps(report, indent=2, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
