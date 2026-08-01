#!/usr/bin/env python3
"""Exact interval arithmetic for integer-speed Lonely Runner bad sets.

For a positive integer speed ``v`` and rational threshold ``delta``, the bad
set on the fundamental interval ``[0, 1]`` is

    {t : ||v * t||_{R/Z} < delta}.

Interval endpoints and all reported measures use ``fractions.Fraction``.
Endpoint openness does not affect measure; safe-set classification evaluates
endpoints separately so strict bad-set inequalities are still respected.
"""

from __future__ import annotations

import itertools
from fractions import Fraction
from typing import Iterable, Sequence

from check_integer_tuple import circle_distance


Interval = tuple[Fraction, Fraction]


def _validate_threshold(threshold: Fraction) -> None:
    if not isinstance(threshold, Fraction):
        raise ValueError("threshold must be a Fraction")
    if not Fraction(0) < threshold <= Fraction(1, 2):
        raise ValueError("threshold must lie in (0, 1/2]")


def bad_intervals(speed: int, threshold: Fraction) -> tuple[Interval, ...]:
    """Return the bad-set interval interiors, clipped to ``[0, 1]``.

    The intervals around successive points ``k / speed`` are disjoint when
    ``threshold <= 1/2``. At 0 and 1 the clipped endpoint belongs to the bad
    set, but endpoint membership is deliberately handled by exact evaluation
    in ``safe_decomposition`` rather than encoded in this measure-oriented
    representation.
    """

    if not isinstance(speed, int) or isinstance(speed, bool) or speed <= 0:
        raise ValueError("speed must be a positive integer")
    _validate_threshold(threshold)
    radius = threshold / speed
    return tuple(
        (max(Fraction(0), Fraction(k, speed) - radius),
         min(Fraction(1), Fraction(k, speed) + radius))
        for k in range(speed + 1)
    )


def intersect_interval_families(left: Iterable[Interval], right: Iterable[Interval]) -> tuple[Interval, ...]:
    """Intersect two finite interval families, discarding zero-length pieces."""

    intersections: list[Interval] = []
    for left_start, left_end in left:
        for right_start, right_end in right:
            start = max(left_start, right_start)
            end = min(left_end, right_end)
            if start < end:
                intersections.append((start, end))
    return tuple(intersections)


def intersection_intervals(speeds: Sequence[int], threshold: Fraction) -> tuple[Interval, ...]:
    """Return interval interiors for the intersection of the selected bad sets."""

    if not speeds:
        raise ValueError("at least one speed is required")
    pieces = bad_intervals(speeds[0], threshold)
    for speed in speeds[1:]:
        pieces = intersect_interval_families(pieces, bad_intervals(speed, threshold))
    return pieces


def interval_measure(intervals: Iterable[Interval]) -> Fraction:
    """Measure a disjoint interval family exactly."""

    return sum((end - start for start, end in intervals), start=Fraction(0))


def intersection_measure(speeds: Sequence[int], threshold: Fraction) -> Fraction:
    """Return the exact measure of an intersection of bad sets."""

    return interval_measure(intersection_intervals(speeds, threshold))


def union_measure(speeds: Sequence[int], threshold: Fraction) -> Fraction:
    """Return the exact measure of the union of the selected bad sets."""

    if not speeds:
        return Fraction(0)
    pieces = sorted(
        interval
        for speed in speeds
        for interval in bad_intervals(speed, threshold)
    )
    merged: list[list[Fraction]] = []
    for start, end in pieces:
        if not merged or start > merged[-1][1]:
            merged.append([start, end])
        else:
            merged[-1][1] = max(merged[-1][1], end)
    return interval_measure((start, end) for start, end in merged)


def safe_decomposition(
    speeds: Sequence[int], threshold: Fraction
) -> tuple[tuple[Fraction, ...], tuple[Interval, ...]]:
    """Return safe boundary points and safe open cells in ``[0, 1]``.

    Every bad-set membership can change only at an endpoint of a bad interval.
    Testing those endpoints and one midpoint of every complementary open cell
    therefore gives an exact decomposition, including the closed-boundary
    convention ``||v*t|| >= threshold``.
    """

    if not speeds:
        raise ValueError("at least one speed is required")
    boundaries = sorted({
        endpoint
        for speed in speeds
        for interval in bad_intervals(speed, threshold)
        for endpoint in interval
    })

    def is_safe(time: Fraction) -> bool:
        return all(circle_distance(speed, time) >= threshold for speed in speeds)

    safe_points = tuple(time for time in boundaries if is_safe(time))
    safe_cells = tuple(
        (left, right)
        for left, right in itertools.pairwise(boundaries)
        if is_safe((left + right) / 2)
    )
    return safe_points, safe_cells
