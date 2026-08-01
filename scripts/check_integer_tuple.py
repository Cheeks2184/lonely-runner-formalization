#!/usr/bin/env python3
"""Exact finite-instance checker for the integer Lonely Runner problem.

This program intentionally uses only Python's standard library.  Every time
and distance is a ``fractions.Fraction``; floating-point approximations never
enter the decision whether an instance reaches its target.
"""

from __future__ import annotations

import argparse
import itertools
import json
from fractions import Fraction
from pathlib import Path
from typing import Iterable, Sequence


SCHEMA = "lonely-runner-integer-certificate-v1"


def _positive_speeds(values: Iterable[int]) -> tuple[int, ...]:
    """Normalize and validate a nonempty tuple of positive integer speeds."""

    speeds = tuple(values)
    if not speeds:
        raise ValueError("at least one moving-runner speed is required")
    if any(not isinstance(speed, int) or isinstance(speed, bool) or speed <= 0 for speed in speeds):
        raise ValueError("speeds must be positive integers")
    return speeds


def circle_distance(speed: int, time: Fraction) -> Fraction:
    """Return ||speed * time||_{R/Z} exactly."""

    position = speed * time
    fractional_part = position - (position.numerator // position.denominator)
    return min(fractional_part, 1 - fractional_part)


def loneliness(speeds: Sequence[int], time: Fraction) -> Fraction:
    """Return the least circular distance among all moving runners."""

    checked = _positive_speeds(speeds)
    return min(circle_distance(speed, time) for speed in checked)


def _affine_piece(speed: int, left: Fraction, right: Fraction) -> tuple[Fraction, Fraction]:
    """Give ``(slope, intercept)`` for one open common breakpoint cell."""

    midpoint = (left + right) / 2
    position = speed * midpoint
    integer_part = position.numerator // position.denominator
    fractional_part = position - integer_part

    # Common-cell endpoints include every k/(2v), so the midpoint is never a
    # cusp or zero for this speed.  Consequently exactly one branch applies.
    if fractional_part < Fraction(1, 2):
        return Fraction(speed), Fraction(-integer_part)
    return Fraction(-speed), Fraction(integer_part + 1)


def candidate_times(speeds: Sequence[int]) -> tuple[Fraction, ...]:
    """Enumerate a finite exact set containing every possible optimum.

    Each distance function has breakpoints k/(2v).  On a common cell all
    distance functions are affine, and their pointwise minimum is concave and
    piecewise affine.  Its maximum is therefore at a cell endpoint or at the
    intersection of two of those affine functions (a harmless superset is
    retained here; the intersecting functions need not both be active).
    """

    checked = _positive_speeds(speeds)
    breakpoints = {
        Fraction(k, 2 * speed)
        for speed in checked
        for k in range(2 * speed + 1)
    }
    ordered = sorted(breakpoints)
    candidates = set(ordered)

    for left, right in itertools.pairwise(ordered):
        if left == right:
            continue
        lines = [_affine_piece(speed, left, right) for speed in checked]
        for (slope_a, intercept_a), (slope_b, intercept_b) in itertools.combinations(lines, 2):
            if slope_a == slope_b:
                continue
            crossing = (intercept_b - intercept_a) / (slope_a - slope_b)
            if left <= crossing <= right:
                candidates.add(crossing)

    return tuple(sorted(candidates))


def optimal_loneliness(speeds: Sequence[int]) -> tuple[Fraction, Fraction, int]:
    """Return ``(maximum distance, earliest witness, candidate count)``."""

    checked = _positive_speeds(speeds)
    candidates = candidate_times(checked)
    values = [(loneliness(checked, time), time) for time in candidates]
    optimum = max(value for value, _ in values)
    witness = min(time for value, time in values if value == optimum)
    return optimum, witness, len(candidates)


def _fraction_text(value: Fraction) -> str:
    return str(value.numerator) if value.denominator == 1 else f"{value.numerator}/{value.denominator}"


def _parse_fraction(value: object, field: str) -> Fraction:
    if not isinstance(value, str):
        raise ValueError(f"{field} must be a fraction encoded as a string")
    try:
        return Fraction(value)
    except (ValueError, ZeroDivisionError) as exc:
        raise ValueError(f"invalid fraction in {field}: {value!r}") from exc


def make_certificate(speeds: Sequence[int]) -> dict[str, object]:
    """Compute a deterministic, self-describing certificate for one tuple."""

    checked = _positive_speeds(speeds)
    optimum, witness, candidate_count = optimal_loneliness(checked)
    distances = [circle_distance(speed, witness) for speed in checked]
    target = Fraction(1, len(checked) + 1)
    return {
        "schema": SCHEMA,
        "speeds": list(checked),
        "target": _fraction_text(target),
        "witness": _fraction_text(witness),
        "distances": [_fraction_text(distance) for distance in distances],
        "optimum": _fraction_text(optimum),
        "candidate_count": candidate_count,
        "meets_target": optimum >= target,
    }


def verify_certificate(certificate: object) -> dict[str, object]:
    """Recompute the full exact search and reject any mismatched field."""

    if not isinstance(certificate, dict):
        raise ValueError("certificate must be a JSON object")
    if certificate.get("schema") != SCHEMA:
        raise ValueError(f"unsupported certificate schema: {certificate.get('schema')!r}")
    raw_speeds = certificate.get("speeds")
    if not isinstance(raw_speeds, list):
        raise ValueError("speeds must be a JSON array")
    speeds = _positive_speeds(raw_speeds)

    # Parse rational claims independently before comparing against the
    # canonical recomputation, so malformed encodings fail clearly.
    _parse_fraction(certificate.get("target"), "target")
    _parse_fraction(certificate.get("witness"), "witness")
    _parse_fraction(certificate.get("optimum"), "optimum")
    raw_distances = certificate.get("distances")
    if not isinstance(raw_distances, list):
        raise ValueError("distances must be a JSON array")
    for index, distance in enumerate(raw_distances):
        _parse_fraction(distance, f"distances[{index}]")
    if type(certificate.get("candidate_count")) is not int:
        raise ValueError("candidate_count must be a JSON integer")
    if type(certificate.get("meets_target")) is not bool:
        raise ValueError("meets_target must be a JSON Boolean")

    expected = make_certificate(speeds)
    if certificate != expected:
        differing = sorted(
            key for key in set(certificate) | set(expected) if certificate.get(key) != expected.get(key)
        )
        raise ValueError("certificate does not match exact recomputation; differing fields: " + ", ".join(differing))
    return expected


def exhaustive_summary(max_runners: int, max_speed: int) -> dict[str, object]:
    """Check all distinct tuples selected from ``1..max_speed``."""

    if max_runners < 1 or max_speed < 1:
        raise ValueError("bounds must be positive")
    if max_runners > max_speed:
        raise ValueError("max-runners cannot exceed max-speed for distinct tuples")

    by_dimension: list[dict[str, object]] = []
    total = 0
    failures: list[dict[str, object]] = []
    for runner_count in range(1, max_runners + 1):
        target = Fraction(1, runner_count + 1)
        tight: list[list[int]] = []
        minimum_margin: Fraction | None = None
        dimension_count = 0
        for speeds in itertools.combinations(range(1, max_speed + 1), runner_count):
            optimum, witness, _ = optimal_loneliness(speeds)
            margin = optimum - target
            minimum_margin = margin if minimum_margin is None else min(minimum_margin, margin)
            if margin == 0:
                tight.append(list(speeds))
            if margin < 0:
                failures.append(
                    {
                        "speeds": list(speeds),
                        "optimum": _fraction_text(optimum),
                        "witness": _fraction_text(witness),
                        "target": _fraction_text(target),
                    }
                )
            dimension_count += 1
        total += dimension_count
        by_dimension.append(
            {
                "moving_runners": runner_count,
                "instances": dimension_count,
                "target": _fraction_text(target),
                "minimum_margin": _fraction_text(minimum_margin or Fraction(0)),
                "tight_tuples": tight,
            }
        )
    return {
        "schema": "lonely-runner-integer-exhaustive-summary-v1",
        "max_runners": max_runners,
        "max_speed": max_speed,
        "distinct_positive_speeds": True,
        "instances": total,
        "failures": failures,
        "by_dimension": by_dimension,
    }


def _write_json(path: Path, value: object) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value, indent=2, sort_keys=True) + "\n", encoding="utf-8")


def _build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    commands = parser.add_subparsers(dest="command", required=True)

    check = commands.add_parser("check", help="exactly optimize one positive-integer tuple")
    check.add_argument("speeds", nargs="+", type=int)
    check.add_argument("--certificate", type=Path, help="write the result as JSON")

    verify = commands.add_parser("verify", help="recompute and verify a JSON certificate")
    verify.add_argument("certificate", type=Path)

    exhaustive = commands.add_parser("exhaustive", help="check all distinct tuples in finite bounds")
    exhaustive.add_argument("--max-runners", type=int, default=4)
    exhaustive.add_argument("--max-speed", type=int, default=8)
    exhaustive.add_argument("--output", type=Path, help="write the summary as JSON")
    return parser


def main(argv: Sequence[str] | None = None) -> int:
    args = _build_parser().parse_args(argv)
    try:
        if args.command == "check":
            result = make_certificate(args.speeds)
            if args.certificate:
                _write_json(args.certificate, result)
        elif args.command == "verify":
            result = verify_certificate(json.loads(args.certificate.read_text(encoding="utf-8")))
        else:
            result = exhaustive_summary(args.max_runners, args.max_speed)
            if args.output:
                _write_json(args.output, result)
    except (OSError, json.JSONDecodeError, ValueError) as exc:
        print(f"error: {exc}")
        return 2

    print(json.dumps(result, indent=2, sort_keys=True))
    if args.command == "exhaustive" and result["failures"]:
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
