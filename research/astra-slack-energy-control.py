#!/usr/bin/env python3
"""Exact bounded control for a proposed global slack-energy inequality.

Every mathematical quantity in this script is a Fraction.  The only use of
wall-clock time is the explicit finite-search limit; it never selects a phase,
sign, or integral value.
"""

from __future__ import annotations

import argparse
import hashlib
import itertools
import json
import math
import os
import sys
import time
from datetime import datetime, timezone
from fractions import Fraction


SEARCH_LIMIT_SECONDS = 60
EVALUATION_LIMIT = 1000
SPEED_RANGE = (1, 12)
DIMENSIONS = (2, 3, 4, 5)


def text(value: Fraction) -> str:
    """Render an exact rational value uniformly in the evidence receipt."""

    return f"{value.numerator}/{value.denominator}"


def multiply_affine(polynomial: list[Fraction], affine: tuple[Fraction, Fraction]) -> list[Fraction]:
    """Multiply a low-to-high polynomial by intercept + slope*t exactly."""

    intercept, slope = affine
    result = [Fraction(0) for _ in range(len(polynomial) + 1)]
    for degree, coefficient in enumerate(polynomial):
        result[degree] += coefficient * intercept
        result[degree + 1] += coefficient * slope
    return result


def integrate_polynomial(polynomial: list[Fraction], left: Fraction, right: Fraction) -> Fraction:
    """Integrate a low-to-high polynomial on a rational interval."""

    return sum(
        coefficient * (right ** (degree + 1) - left ** (degree + 1)) / (degree + 1)
        for degree, coefficient in enumerate(polynomial)
    )


def norm_affine(speed: int, midpoint: Fraction) -> tuple[Fraction, Fraction]:
    """Return the affine branch for ||speed*t|| containing midpoint.

    The partition includes every half-integer speed breakpoint, so midpoint is
    strictly inside one branch and never needs a numerical tie decision.
    """

    scaled = speed * midpoint
    integer_part = scaled.numerator // scaled.denominator
    fractional_part = scaled - integer_part
    if fractional_part < Fraction(1, 2):
        return Fraction(-integer_part), Fraction(speed)
    if fractional_part > Fraction(1, 2):
        return Fraction(integer_part + 1), Fraction(-speed)
    raise AssertionError("global partition midpoint unexpectedly hit a norm breakpoint")


def partition_points(speeds: tuple[int, ...], threshold: Fraction) -> list[Fraction]:
    """Return every affine or slack-sign boundary in [0, 1]."""

    points = {Fraction(0), Fraction(1)}
    for speed in speeds:
        # The norm changes affine slope at each multiple of 1/(2*speed).
        points.update(Fraction(index, 2 * speed) for index in range(2 * speed + 1))
        # On each period, distance equals threshold at these two rational times.
        points.update(Fraction(index + threshold, speed) for index in range(speed))
        points.update(Fraction(index + 1 - threshold, speed) for index in range(speed))
    return sorted(point for point in points if Fraction(0) <= point <= Fraction(1))


def slack_energy(speeds: tuple[int, ...], threshold: Fraction) -> dict[str, object]:
    """Integrate I and H exactly over the positive-slack phase partition.

    I is the integral of every slack factor.  H is the integral, on the same
    all-positive region, of the sum of all leave-one-out slack products.
    """

    if not speeds or any(speed <= 0 for speed in speeds) or len(set(speeds)) != len(speeds):
        raise ValueError("speeds must be a nonempty tuple of distinct positive integers")
    if not Fraction(0) <= threshold <= Fraction(1, 2):
        raise ValueError("threshold must lie in [0, 1/2]")

    points = partition_points(speeds, threshold)
    integral_i = Fraction(0)
    integral_h = Fraction(0)
    positive_intervals = 0
    for left, right in zip(points, points[1:]):
        if left == right:
            continue
        midpoint = (left + right) / 2
        slacks = [
            (intercept - threshold, slope)
            for intercept, slope in (norm_affine(speed, midpoint) for speed in speeds)
        ]
        # Threshold-crossing points are partition boundaries.  One midpoint
        # sign therefore classifies the entire open interval exactly.
        if any(intercept + slope * midpoint <= 0 for intercept, slope in slacks):
            continue
        positive_intervals += 1
        all_product = [Fraction(1)]
        for slack in slacks:
            all_product = multiply_affine(all_product, slack)
        integral_i += integrate_polynomial(all_product, left, right)
        for omitted in range(len(slacks)):
            leave_one_out = [Fraction(1)]
            for index, slack in enumerate(slacks):
                if index != omitted:
                    leave_one_out = multiply_affine(leave_one_out, slack)
            integral_h += integrate_polynomial(leave_one_out, left, right)
    dimension = len(speeds)
    defect = (dimension + 1) * integral_i - (Fraction(1, dimension + 1) - threshold) * integral_h
    return {
        "I": integral_i,
        "H": integral_h,
        "defect": defect,
        "partition_point_count": len(points),
        "all_positive_interval_count": positive_intervals,
    }


def result_record(speeds: tuple[int, ...], threshold: Fraction, result: dict[str, object]) -> dict[str, object]:
    """Convert exact evaluator output to receipt-safe rational text."""

    integral_i = result["I"]
    integral_h = result["H"]
    defect = result["defect"]
    assert isinstance(integral_i, Fraction)
    assert isinstance(integral_h, Fraction)
    assert isinstance(defect, Fraction)
    return {
        "v": list(speeds),
        "d": len(speeds),
        "a": text(threshold),
        "I": text(integral_i),
        "H": text(integral_h),
        "defect": text(defect),
        "partition_point_count": result["partition_point_count"],
        "all_positive_interval_count": result["all_positive_interval_count"],
    }


def run_regressions() -> dict[str, object]:
    """Check the two supplied exact values before the bounded search."""

    threshold = Fraction(1, 4)
    two_speed = slack_energy((1, 2), threshold)
    assert two_speed["I"] == Fraction(1, 768)
    assert two_speed["H"] == Fraction(3, 64)
    assert two_speed["defect"] == Fraction(0)
    one_speed = slack_energy((1,), threshold)
    assert one_speed["I"] == Fraction(1, 16)
    assert one_speed["H"] == Fraction(1, 2)
    return {
        "status": "passed",
        "v_1_2_a_1_4": result_record((1, 2), threshold, two_speed),
        "v_1_a_1_4": result_record((1,), threshold, one_speed),
    }


def primitive(speeds: tuple[int, ...]) -> bool:
    """Restrict the finite domain to its requested primitive representatives."""

    return math.gcd(*speeds) == 1


def bounded_search(started: float) -> dict[str, object]:
    """Search the supplied finite lexicographic domain once, with hard bounds."""

    checked = 0
    checked_by_dimension = {str(dimension): 0 for dimension in DIMENSIONS}
    last_evaluation: dict[str, object] | None = None
    for dimension in DIMENSIONS:
        for speeds in itertools.combinations(range(SPEED_RANGE[0], SPEED_RANGE[1] + 1), dimension):
            if not primitive(speeds):
                continue
            for numerator in range(1, 8):
                if time.monotonic() - started >= SEARCH_LIMIT_SECONDS:
                    return {
                        "stop_reason": "timeout",
                        "checked_tuple_threshold_count": checked,
                        "checked_by_dimension": checked_by_dimension,
                        "last_evaluation": last_evaluation,
                        "first_strictly_negative_defect": None,
                    }
                if checked >= EVALUATION_LIMIT:
                    return {
                        "stop_reason": "evaluation_limit_reached",
                        "checked_tuple_threshold_count": checked,
                        "checked_by_dimension": checked_by_dimension,
                        "last_evaluation": last_evaluation,
                        "first_strictly_negative_defect": None,
                    }
                threshold = Fraction(numerator, 8 * (dimension + 1))
                evaluation = result_record(speeds, threshold, slack_energy(speeds, threshold))
                checked += 1
                checked_by_dimension[str(dimension)] += 1
                last_evaluation = evaluation
                defect = Fraction(evaluation["defect"])
                if defect < 0:
                    return {
                        "stop_reason": "first_strictly_negative_defect",
                        "checked_tuple_threshold_count": checked,
                        "checked_by_dimension": checked_by_dimension,
                        "last_evaluation": last_evaluation,
                        "first_strictly_negative_defect": evaluation,
                    }
    return {
        "stop_reason": "finite_domain_exhausted_without_negative_defect",
        "checked_tuple_threshold_count": checked,
        "checked_by_dimension": checked_by_dimension,
        "last_evaluation": last_evaluation,
        "first_strictly_negative_defect": None,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", required=True, help="JSON receipt path")
    args = parser.parse_args()
    source_path = os.path.abspath(__file__)
    source_bytes = open(source_path, "rb").read()
    started_utc = datetime.now(timezone.utc).isoformat()
    program_started = time.monotonic()
    regressions = run_regressions()
    search_started = time.monotonic()
    result = bounded_search(search_started)
    duration = time.monotonic() - program_started
    payload = {
        "schema": "slack-energy-exact-control/v1",
        "task": "one exact bounded control for a proposed global slack-energy inequality",
        "source_checkpoint": "5aecd6775dd9480e3e4eaa8e8ec7fe76ebd80665",
        "exact_domain": {
            "tuple_order": "dimension-first, lexicographic combinations",
            "distinct_positive": True,
            "primitive": True,
            "dimensions": list(DIMENSIONS),
            "speed_range_inclusive": list(SPEED_RANGE),
            "thresholds": {
                "formula": "j/(8*(d+1))",
                "j_values": list(range(1, 8)),
            },
            "search_limit_seconds": SEARCH_LIMIT_SECONDS,
            "tuple_threshold_evaluation_limit": EVALUATION_LIMIT,
        },
        "exact_method": "Partition [0,1] at every k/(2*vi) and every in-range (k+a)/vi and (k+1-a)/vi. On each interval choose norm affine branches from the rational midpoint, retain only all-positive slack intervals, and integrate product and leave-one-out polynomials over Fraction coefficients.",
        "execution": {
            "source_path_at_execution": source_path,
            "source_sha256": hashlib.sha256(source_bytes).hexdigest(),
            "source_utf8": source_bytes.decode("utf-8"),
            "argv": sys.argv,
            "python": sys.version,
            "started_utc": started_utc,
            "program_duration_seconds": duration,
        },
        "focused_regressions": regressions,
        "result": result,
        "delivery_metrics": {
            "check_kind": "python",
            "first_check_success": None,
            "worker_repair_rounds": 0,
            "astra_repair_rounds": 0,
            "astra_repair_lines": 0,
            "worker_elapsed_seconds": None,
            "usage": None,
            "evidence": [
                "research/astra-slack-energy-control.py",
                "research/astra-slack-energy-control.json",
            ],
        },
        "failures": [],
        "scope_note": "A strictly negative defect would refute only the proposed slack-energy inequality, never the Lonely Runner Conjecture.",
    }
    with open(args.output, "w", encoding="utf-8") as handle:
        json.dump(payload, handle, indent=2, sort_keys=True)
        handle.write("\n")
    print(json.dumps({
        "stop_reason": result["stop_reason"],
        "checked_tuple_threshold_count": result["checked_tuple_threshold_count"],
        "strictly_negative_defect_found": result["first_strictly_negative_defect"] is not None,
        "program_duration_seconds": duration,
    }, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
