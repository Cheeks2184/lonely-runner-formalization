#!/usr/bin/env python3
"""Exact audit of the range--sum lower bound for residual profiles.

This is intentionally separate from ``audit_gamma_dispersion``.  It checks a
coarser, profile-by-profile lower bound for the exact ``L1`` numerator used by
``DISPERSION-STAR`` and searches for failures of the resulting sufficient
condition.  A failure here is only a failure of ``RANGE-SUM-STAR``.
"""

from __future__ import annotations

import argparse
import itertools
from fractions import Fraction
from math import gcd

from audit_anchor_star import STRESS_CASES, pair_degree, pivot_bad_mask, second_anchor_gain
from audit_gamma_dispersion import gamma_dispersion_bound, has_dispersion_star_certificate
from search_anchor_star_failures import ExactPivot, structured_cases
from search_fiber_hall import (
    additive_certificate_is_valid,
    best_additive_pivot_attempt,
    child_fibers,
)


LOSSY_TUPLE = (2, 4, 8, 16, 18, 26, 27)


def range_profile_lower(counts: tuple[int, ...]) -> int:
    """Return Sol Response 30's proposed ``w(c)`` in exact integer arithmetic."""

    r = len(counts)
    if r <= 1:
        return 0
    low, high = min(counts), max(counts)
    width = high - low
    if width == 0:
        return 0
    if r == 2:
        return width
    k = r - 2
    interior_sum = sum(counts) - r * low - width
    _quotient, remainder = divmod(interior_sum, k)
    return (r - 1) * width + remainder * (k - remainder)


def profile_dispersion(counts: tuple[int, ...]) -> int:
    return sum(abs(x - y) for x, y in itertools.combinations(counts, 2))


def range_equality_characterization(counts: tuple[int, ...]) -> bool:
    """Evaluate the claimed equality characterization, including multiplicities.

    Removing any one minimum and any one maximum yields the same multiset of
    remaining values, so duplicates at the extremes introduce no ambiguity.
    """

    if len(counts) <= 3:
        return True
    remaining = list(counts)
    remaining.remove(min(remaining))
    remaining.remove(max(remaining))
    return max(remaining) - min(remaining) <= 1


def _strict_bad_target(image: int, pivot_speed: int, modulus: int) -> bool:
    return image < pivot_speed or image > modulus - pivot_speed


def retained_profiles(
    speeds: tuple[int, ...], pivot: int, h: int
):
    """Yield ``(child speed, child target, h image, comparison counts)``."""

    others = tuple(index for index in range(len(speeds)) if index != pivot)
    modulus = (len(speeds) + 1) * speeds[pivot]
    pivot_speed = speeds[pivot]
    masks = {index: pivot_bad_mask(speeds, pivot, index) for index in others}
    for child in others:
        if child == h:
            continue
        comparison = tuple(index for index in others if index not in (h, child))
        for target, child_fiber in child_fibers(speeds, pivot, child):
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
                counts = tuple((cell & masks[q]).bit_count() for q in comparison)
                # ``child_fibers`` uses signed strict-target representatives;
                # report the canonical residue requested by the congruence API.
                yield speeds[child], target % modulus, image, counts


def range_sum_numerator(speeds: tuple[int, ...], pivot: int, h: int) -> int:
    return sum(range_profile_lower(row[3]) for row in retained_profiles(speeds, pivot, h))


def range_sum_bound(speeds: tuple[int, ...], pivot: int, h: int) -> Fraction:
    m = len(speeds) - 1
    denominator = (m - 1) * (m - 2)
    if denominator <= 0:
        raise ValueError("range-sum averaging requires at least three nonpivots")
    return Fraction(range_sum_numerator(speeds, pivot, h), denominator)


def literal_range_and_dispersion_numerators(
    speeds: tuple[int, ...], pivot: int, h: int
) -> tuple[int, int]:
    """Slow set/list oracle sharing no mask or child-fiber construction.

    It enumerates candidate residues, groups literal bad residues by the pair
    of modular images, and counts every comparison-anchor membership afresh.
    """

    n = len(speeds)
    pivot_speed = speeds[pivot]
    modulus = (n + 1) * pivot_speed
    candidates = tuple(r for r in range(modulus) if r % (n + 1) != 0)
    others = tuple(i for i in range(n) if i != pivot)
    total_w = total_v = 0
    for child in others:
        if child == h:
            continue
        comparison = tuple(i for i in others if i not in (h, child))
        cells: dict[tuple[int, int], list[int]] = {}
        for residue in candidates:
            child_image = speeds[child] * residue % modulus
            if not _strict_bad_target(child_image, pivot_speed, modulus):
                continue
            h_image = speeds[h] * residue % modulus
            if _strict_bad_target(h_image, pivot_speed, modulus):
                continue
            cells.setdefault((child_image, h_image), []).append(residue)
        for residues in cells.values():
            counts = tuple(
                sum(
                    _strict_bad_target(
                        speeds[q] * residue % modulus, pivot_speed, modulus
                    )
                    for residue in residues
                )
                for q in comparison
            )
            total_w += range_profile_lower(counts)
            total_v += profile_dispersion(counts)
    return total_w, total_v


def row_data(speeds: tuple[int, ...], pivot: int, h: int) -> dict[str, object]:
    others = tuple(i for i in range(len(speeds)) if i != pivot)
    pair_part = Fraction(pair_degree(speeds, pivot, h)) + Fraction(
        sum(second_anchor_gain(speeds, pivot, h, q) for q in others if q != h),
        len(others) - 1,
    )
    strict_sum = sum(pivot_bad_mask(speeds, pivot, i).bit_count() for i in others)
    required = strict_sum - len(speeds) * speeds[pivot]
    exact_v = gamma_dispersion_bound(speeds, pivot, h)
    bound_w = range_sum_bound(speeds, pivot, h)
    if bound_w > exact_v:
        raise AssertionError(f"range lower bound exceeds exact dispersion: {bound_w}>{exact_v}")
    return {
        "pivot": speeds[pivot],
        "h": speeds[h],
        "pair_part": pair_part,
        "V": exact_v,
        "W": bound_w,
        "required": required,
        "range_surplus": pair_part + bound_w - required,
        "dispersion_surplus": pair_part + exact_v - required,
    }


def has_range_sum_star_certificate(speeds: tuple[int, ...]) -> bool:
    for pivot in range(len(speeds)):
        for h in range(len(speeds)):
            if h != pivot and row_data(speeds, pivot, h)["range_surplus"] > 0:
                return True
    return False


def verify_coprime_fixed_pivot_descent(
    speeds: tuple[int, ...], pivot: int, divisor: int
) -> bool:
    """Check the fixed-pivot mask isomorphism induced by ``r -> D*r``.

    This deliberately checks set systems, not validity of the divided tuple as
    a globally distinct speed tuple and not any other pivot.
    """

    n = len(speeds)
    modulus = (n + 1) * speeds[pivot]
    if divisor <= 0 or gcd(divisor, modulus) != 1:
        raise ValueError("divisor must be positive and coprime to the pivot modulus")
    if any(speeds[i] % divisor for i in range(n) if i != pivot):
        raise ValueError("divisor must divide every nonpivot speed")
    divided = tuple(
        speed if i == pivot else speed // divisor for i, speed in enumerate(speeds)
    )
    candidates = tuple(r for r in range(modulus) if r % (n + 1) != 0)
    if {divisor * r % modulus for r in candidates} != set(candidates):
        return False
    for i in range(n):
        if i == pivot:
            continue
        old_mask = pivot_bad_mask(speeds, pivot, i)
        new_mask = pivot_bad_mask(divided, pivot, i)
        transported = 0
        for r in candidates:
            if old_mask >> r & 1:
                transported |= 1 << (divisor * r % modulus)
        if transported != new_mask:
            return False
    return True


def scan_complete_box(runners: int, max_speed: int) -> dict[str, object]:
    checked = 0
    dispersion_only = 0
    closest: tuple[Fraction, tuple[int, ...]] | None = None
    for speeds in itertools.combinations(range(1, max_speed + 1), runners):
        if gcd(*speeds) != 1:
            continue
        checked += 1
        best = max(
            row_data(speeds, p, h)["range_surplus"]
            for p in range(runners)
            for h in range(runners)
            if p != h
        )
        assert isinstance(best, Fraction)
        if closest is None or best < closest[0]:
            closest = (best, speeds)
        has_range = best > 0
        has_dispersion = has_dispersion_star_certificate(speeds)
        if has_dispersion and not has_range:
            dispersion_only += 1
        if not has_range:
            return {
                "runners": runners,
                "max_speed": max_speed,
                "checked_until_failure": checked,
                "failure": speeds,
                "failure_has_dispersion_certificate": has_dispersion,
                "dispersion_only_before_or_at_failure": dispersion_only,
                "closest": closest,
            }
    return {
        "runners": runners,
        "max_speed": max_speed,
        "checked": checked,
        "failure": None,
        "dispersion_only": dispersion_only,
        "closest": closest,
    }


def one_swap_neighborhood(
    seed: tuple[int, ...], maximum: int
):
    """Yield the primitive tuples obtained by changing at most one seed speed."""

    seen: set[tuple[int, ...]] = set()
    for removed in seed:
        base = set(seed)
        base.remove(removed)
        for inserted in range(1, maximum + 1):
            if inserted in base:
                continue
            candidate = tuple(sorted((*base, inserted)))
            if gcd(*candidate) == 1 and candidate not in seen:
                seen.add(candidate)
                yield candidate


def scan_targeted(cases, label: str) -> dict[str, object]:
    """Search a deterministic cohort, stopping only on an exact all-row failure."""

    checked = 0
    for speeds in cases:
        checked += 1
        if not has_range_sum_star_certificate(speeds):
            # Repeat the exact decision and separately evaluate DISPERSION-STAR.
            if has_range_sum_star_certificate(speeds):
                raise AssertionError("non-reproducible RANGE-SUM-STAR decision")
            return {
                "label": label,
                "checked_until_failure": checked,
                "failure": speeds,
                "failure_has_dispersion_certificate": has_dispersion_star_certificate(speeds),
            }
    return {"label": label, "checked": checked, "failure": None}


def audit_all_rows(speeds: tuple[int, ...]) -> dict[str, object]:
    rows = [
        row_data(speeds, pivot, h)
        for pivot in range(len(speeds))
        for h in range(len(speeds))
        if pivot != h
    ]
    by_pivot = []
    for pivot_speed in speeds:
        pivot_rows = [row for row in rows if row["pivot"] == pivot_speed]
        by_pivot.append(
            {
                "pivot": pivot_speed,
                "best_range": max((row["range_surplus"], row["h"]) for row in pivot_rows),
                "best_dispersion": max((row["dispersion_surplus"], row["h"]) for row in pivot_rows),
            }
        )
    return {
        "speeds": speeds,
        "best_range": max((row["range_surplus"], row["pivot"], row["h"]) for row in rows),
        "best_dispersion": max((row["dispersion_surplus"], row["pivot"], row["h"]) for row in rows),
        "by_pivot": by_pivot,
    }


def deep_audit_tuple(speeds: tuple[int, ...]) -> dict[str, object]:
    """Run independent row reconstruction plus exact anchor/additive searches."""

    n = len(speeds)
    row_report = audit_all_rows(speeds)
    for pivot in range(n):
        denominator = (n - 2) * (n - 3)
        for h in range(n):
            if h == pivot:
                continue
            literal_w, literal_v = literal_range_and_dispersion_numerators(
                speeds, pivot, h
            )
            if Fraction(literal_w, denominator) != range_sum_bound(speeds, pivot, h):
                raise AssertionError("literal W oracle mismatch")
            if Fraction(literal_v, denominator) != gamma_dispersion_bound(speeds, pivot, h):
                raise AssertionError("literal V oracle mismatch")

    pivot_certificates = []
    for pivot in range(n):
        oracle = ExactPivot(speeds, pivot)
        result = oracle.evaluate(reference_check=True)
        triples = tuple(itertools.combinations(oracle.others, 3))
        costs = {triple: oracle.triple_cost(triple) for triple in triples}
        best_triple, best_cost = min(costs.items(), key=lambda item: item[1])
        anchor_sums = {
            h: sum(cost for triple, cost in costs.items() if h in triple)
            for h in oracle.others
        }
        best_h, best_anchor_sum = min(anchor_sums.items(), key=lambda item: item[1])
        additive = best_additive_pivot_attempt(speeds, pivot)
        pivot_certificates.append(
            {
                "pivot": speeds[pivot],
                "threshold": result.threshold,
                "best_triple": tuple(speeds[i] for i in best_triple),
                "three_anchor_cost": best_cost,
                "best_first_anchor": speeds[best_h],
                "anchor_sum": best_anchor_sum,
                "anchor_denominator": result.anchor_denominator,
                "anchor_average": Fraction(best_anchor_sum, result.anchor_denominator),
                "additive_bound": additive.final_upper_bound,
                "additive_valid": additive_certificate_is_valid(additive),
                "additive_order": tuple(speeds[i] for i in additive.order),
                "additive_costs": tuple(step.increment_bound for step in additive.steps),
            }
        )
    return {
        "primitive": gcd(*speeds) == 1,
        "positive_distinct": len(set(speeds)) == n and min(speeds) > 0,
        "rows": row_report,
        "pivots": pivot_certificates,
        "range_sum_star": row_report["best_range"][0] > 0,
        "dispersion_star": row_report["best_dispersion"][0] > 0,
        "anchor_star": any(
            row["anchor_average"] < row["threshold"] for row in pivot_certificates
        ),
        "three_anchor": any(
            row["three_anchor_cost"] < row["threshold"] for row in pivot_certificates
        ),
        "optimized_additive": any(row["additive_valid"] for row in pivot_certificates),
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--scan-runners", type=int)
    parser.add_argument("--max-speed", type=int)
    parser.add_argument("--structured", action="store_true")
    parser.add_argument("--near-nine", action="store_true")
    parser.add_argument("--tuple", dest="tuple_text")
    parser.add_argument("--deep-tuple", dest="deep_tuple_text")
    args = parser.parse_args()
    if not args.near_nine and (args.scan_runners is None) != (args.max_speed is None):
        parser.error("--scan-runners and --max-speed must be supplied together")
    if args.structured and args.scan_runners is None:
        parser.error("--structured requires --scan-runners and --max-speed")
    if args.deep_tuple_text:
        speeds = tuple(int(value) for value in args.deep_tuple_text.split(","))
        print(deep_audit_tuple(speeds))
        return
    if args.tuple_text:
        speeds = tuple(int(value) for value in args.tuple_text.split(","))
        print(audit_all_rows(speeds))
        return
    if args.scan_runners is not None:
        if args.structured:
            print(scan_targeted(structured_cases(args.scan_runners, args.max_speed), f"structured-{args.scan_runners}-{args.max_speed}"))
        else:
            print(scan_complete_box(args.scan_runners, args.max_speed))
        return
    if args.near_nine:
        seed = (1, 2, 4, 5, 7, 8, 9, 10, 11)
        maximum = args.max_speed or 40
        print(scan_targeted(one_swap_neighborhood(seed, maximum), f"one-swap-{maximum}"))
        return
    for name, speeds, pivot_speed, h_speed, *_ in STRESS_CASES:
        print(name, row_data(speeds, speeds.index(pivot_speed), speeds.index(h_speed)))
    pivot, h = LOSSY_TUPLE.index(18), LOSSY_TUPLE.index(4)
    print("lossy", row_data(LOSSY_TUPLE, pivot, h))
    print("lossy profiles", [row for row in retained_profiles(LOSSY_TUPLE, pivot, h) if profile_dispersion(row[3]) != range_profile_lower(row[3])])


if __name__ == "__main__":
    main()
