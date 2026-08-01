#!/usr/bin/env python3
"""Audit proposed integer-LRC induction covers on exact finite boxes.

This utility deliberately distinguishes the proved insertion branches from the
unproved covering claim needed to make induction universal.  It enumerates
strictly increasing primitive positive-integer tuples and tests:

* fastest-runner insertion;
* the minimum-scale residue bands;
* the arithmetic premise of codimension-one divisor insertion;
* exact modular-pivot noncoverage;
* optional bounded-parent upper bounds for the pivot bad-set union.

The exact pivot test is a finite-instance computation, not a proof that every
tuple has a pivot certificate.  In particular, a zero count for
``all_pivot_covered`` only says that the audited box contains no LRC
counterexample.
"""

from __future__ import annotations

import argparse
import itertools
import math
from dataclasses import dataclass

from search_residual import (
    covered_by_fast_insertion,
    covered_by_minimum_residue_bands,
    divisor_insertion_condition_indices,
    pivot_certificates,
    pivot_parent_best_bounds,
)


@dataclass(frozen=True)
class InductionCoverAudit:
    total: int
    fast: int
    band_after_nonfast: int
    divisor_after_fast_band: int
    structural_residual: int
    fully_deletion_coprime_residual: int
    exact_pivot_certified_residual: int
    all_pivot_covered: int
    simple_union_certified_residual: int
    parent_certified_residual: int | None
    first_structural_residual: tuple[int, ...] | None
    first_simple_union_failure: tuple[int, ...] | None
    first_parent_failure: tuple[int, ...] | None


def deletion_gcds(speeds: tuple[int, ...]) -> tuple[int, ...]:
    """Gcd of every codimension-one deletion of a nonempty tuple."""

    if len(speeds) == 1:
        return (0,)
    return tuple(
        math.gcd(*(speeds[:index] + speeds[index + 1 :]))
        for index in range(len(speeds))
    )


def audit_box(
    runners: int, max_speed: int, parent_capacity: int | None = None
) -> InductionCoverAudit:
    """Exhaustively audit one primitive increasing finite box."""

    total = 0
    fast = 0
    band_after_nonfast = 0
    divisor_after_fast_band = 0
    structural_residual = 0
    fully_deletion_coprime_residual = 0
    exact_pivot_certified_residual = 0
    all_pivot_covered = 0
    simple_union_certified_residual = 0
    parent_certified_residual = 0 if parent_capacity is not None else None
    first_structural_residual = None
    first_simple_union_failure = None
    first_parent_failure = None

    for speeds in itertools.combinations(range(1, max_speed + 1), runners):
        if math.gcd(*speeds) != 1:
            continue
        total += 1
        if covered_by_fast_insertion(speeds):
            fast += 1
            continue
        if covered_by_minimum_residue_bands(speeds):
            band_after_nonfast += 1
            continue
        if divisor_insertion_condition_indices(speeds):
            divisor_after_fast_band += 1
            continue

        structural_residual += 1
        if first_structural_residual is None:
            first_structural_residual = speeds
        if all(value == 1 for value in deletion_gcds(speeds)):
            fully_deletion_coprime_residual += 1

        simple, _two_parent, exact, mismatches = pivot_certificates(speeds)
        if mismatches:
            raise AssertionError(
                f"pivot count formula mismatch for {speeds}: {mismatches}"
            )
        simple_union_certified_residual += int(simple)
        if not simple and first_simple_union_failure is None:
            first_simple_union_failure = speeds
        exact_pivot_certified_residual += int(exact)
        all_pivot_covered += int(not exact)

        if parent_capacity is not None:
            parent_ok = any(
                bound < universe
                for bound, universe, _exact_union in pivot_parent_best_bounds(
                    speeds, parent_capacity
                )
            )
            assert parent_certified_residual is not None
            parent_certified_residual += int(parent_ok)
            if not parent_ok and first_parent_failure is None:
                first_parent_failure = speeds

    return InductionCoverAudit(
        total=total,
        fast=fast,
        band_after_nonfast=band_after_nonfast,
        divisor_after_fast_band=divisor_after_fast_band,
        structural_residual=structural_residual,
        fully_deletion_coprime_residual=fully_deletion_coprime_residual,
        exact_pivot_certified_residual=exact_pivot_certified_residual,
        all_pivot_covered=all_pivot_covered,
        simple_union_certified_residual=simple_union_certified_residual,
        parent_certified_residual=parent_certified_residual,
        first_structural_residual=first_structural_residual,
        first_simple_union_failure=first_simple_union_failure,
        first_parent_failure=first_parent_failure,
    )


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--runners", type=int, required=True)
    parser.add_argument("--max-speed", type=int, required=True)
    parser.add_argument("--parent-capacity", type=int)
    args = parser.parse_args()
    if not 2 <= args.runners <= args.max_speed:
        parser.error("require 2 <= runners <= max-speed")
    if args.parent_capacity is not None and args.parent_capacity < 0:
        parser.error("parent capacity must be nonnegative")

    result = audit_box(args.runners, args.max_speed, args.parent_capacity)
    fields = [
        f"runners={args.runners}",
        f"max_speed={args.max_speed}",
        "scope=primitive-increasing",
        f"total={result.total}",
        f"fast={result.fast}",
        f"band_after_nonfast={result.band_after_nonfast}",
        f"divisor_after_fast_band={result.divisor_after_fast_band}",
        f"structural_residual={result.structural_residual}",
        (
            "fully_deletion_coprime_residual="
            f"{result.fully_deletion_coprime_residual}"
        ),
        f"exact_pivot_certified_residual={result.exact_pivot_certified_residual}",
        f"all_pivot_covered={result.all_pivot_covered}",
        (
            "simple_union_certified_residual="
            f"{result.simple_union_certified_residual}"
        ),
    ]
    if args.parent_capacity is not None:
        fields.extend(
            [
                f"parent_capacity={args.parent_capacity}",
                f"parent_certified_residual={result.parent_certified_residual}",
            ]
        )
    print(" ".join(fields))
    print(f"first_structural_residual={result.first_structural_residual}")
    print(f"first_simple_union_failure={result.first_simple_union_failure}")
    if args.parent_capacity is not None:
        print(f"first_parent_failure={result.first_parent_failure}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
