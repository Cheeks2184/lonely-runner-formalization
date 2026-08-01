#!/usr/bin/env python3
"""Test structural restrictions on the pair-sum critical spectrum exactly.

For a sorted tuple ``a`` of ``n`` positive integer speeds, the pair-sum
extremal argument says that a global maximizer of

    min_i ||a_i t||

occurs at ``t = r / (a_p + a_q)`` for some pair ``p < q``.  Thus the
unrestricted pair family is complete *conditional on the existence of a
witness*.  This script tests stronger pair-selection conjectures that would
turn that finite spectrum into a more rigid route toward LRC.

All decisions use ``fractions.Fraction``; no floating-point arithmetic is
used.  A reported counterexample is independently checkable by enumerating
the displayed finite numerator ranges.
"""

from __future__ import annotations

import argparse
import itertools
import json
from fractions import Fraction
from typing import Callable, Iterable, Sequence

PairSelector = Callable[[int], Iterable[tuple[int, int]]]


def _all_pairs(n: int) -> Iterable[tuple[int, int]]:
    return itertools.combinations(range(n), 2)


def _adjacent_pairs(n: int) -> Iterable[tuple[int, int]]:
    return ((i, i + 1) for i in range(n - 1))


def _pairs_with_minimum(n: int) -> Iterable[tuple[int, int]]:
    return ((0, j) for j in range(1, n))


def _pairs_with_maximum(n: int) -> Iterable[tuple[int, int]]:
    return ((i, n - 1) for i in range(n - 1))


def _extreme_pair(n: int) -> Iterable[tuple[int, int]]:
    return ((0, n - 1),)


SELECTORS: dict[str, PairSelector] = {
    "all": _all_pairs,
    "adjacent": _adjacent_pairs,
    "with-minimum": _pairs_with_minimum,
    "with-maximum": _pairs_with_maximum,
    "extremes": _extreme_pair,
}


def cyclic_residue_distance(modulus: int, value: int) -> int:
    """Return ``min(value mod modulus, modulus - value mod modulus)``."""

    residue = value % modulus
    return min(residue, modulus - residue)


def is_pair_sum_good(speeds: Sequence[int], p: int, q: int, numerator: int) -> bool:
    """Check the same natural-number inequality as Lean's certificate.

    With ``N = len(speeds) + 1`` and ``D = a_p + a_q``, the closed
    inequality ``||r a_i / D|| >= 1/N`` is exactly

        D <= N * cyclic_residue_distance(D, r * a_i).
    """

    denominator = speeds[p] + speeds[q]
    threshold_denominator = len(speeds) + 1
    return all(
        denominator
        <= threshold_denominator
        * cyclic_residue_distance(denominator, numerator * speed)
        for speed in speeds
    )


def pair_sum_witness(
    speeds: Sequence[int], pairs: Iterable[tuple[int, int]]
) -> tuple[Fraction, tuple[int, int]] | None:
    """Return the earliest pair-sum witness from ``pairs``, if one exists."""

    best: tuple[Fraction, tuple[int, int]] | None = None
    for p, q in pairs:
        denominator = speeds[p] + speeds[q]
        for numerator in range(denominator):
            time = Fraction(numerator, denominator)
            if is_pair_sum_good(speeds, p, q, numerator):
                candidate = (time, (p, q))
                if best is None or candidate < best:
                    best = candidate
    return best


def first_counterexample(
    selector: PairSelector, max_runners: int, max_speed: int
) -> dict[str, object] | None:
    """Search in dimension-first, lexicographic order for a failure."""

    for runner_count in range(2, max_runners + 1):
        for speeds in itertools.combinations(range(1, max_speed + 1), runner_count):
            selected_pairs = tuple(selector(runner_count))
            if pair_sum_witness(speeds, selected_pairs) is not None:
                continue

            # Confirm that failure of the restricted selector is not an LRC
            # counterexample: the full pair-sum spectrum must still witness it.
            unrestricted = pair_sum_witness(speeds, _all_pairs(runner_count))
            return {
                "speeds": list(speeds),
                "moving_runners": runner_count,
                "target": str(Fraction(1, runner_count + 1)),
                "selected_pairs": [list(pair) for pair in selected_pairs],
                "unrestricted_witness": None
                if unrestricted is None
                else {
                    "time": str(unrestricted[0]),
                    "pair": list(unrestricted[1]),
                },
            }
    return None


def exhaustive_report(
    modes: Sequence[str], max_runners: int, max_speed: int
) -> dict[str, object]:
    """Return the first exact failure of each requested selection rule."""

    if max_runners < 2 or max_speed < 2:
        raise ValueError("max-runners and max-speed must both be at least two")
    if max_runners > max_speed:
        raise ValueError("max-runners cannot exceed max-speed")

    return {
        "schema": "lonely-runner-pair-sum-selection-search-v1",
        "max_runners": max_runners,
        "max_speed": max_speed,
        "distinct_positive_speeds": True,
        "results": {
            mode: first_counterexample(SELECTORS[mode], max_runners, max_speed)
            for mode in modes
        },
    }


def _build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--mode",
        action="append",
        choices=tuple(SELECTORS),
        dest="modes",
        help="pair-selection rule to test (repeatable; defaults to all restricted rules)",
    )
    parser.add_argument("--max-runners", type=int, default=8)
    parser.add_argument("--max-speed", type=int, default=20)
    return parser


def main(argv: Sequence[str] | None = None) -> int:
    args = _build_parser().parse_args(argv)
    modes = args.modes or tuple(mode for mode in SELECTORS if mode != "all")
    try:
        report = exhaustive_report(modes, args.max_runners, args.max_speed)
    except ValueError as exc:
        print(f"error: {exc}")
        return 2
    print(json.dumps(report, indent=2, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
