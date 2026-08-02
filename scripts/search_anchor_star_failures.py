#!/usr/bin/env python3
"""Exact deterministic search for failures of the three-anchor criteria.

This is a search for obstructions to two *sufficient certificate schemes*, not
for counterexamples to the Lonely Runner Conjecture.  It shares the strict
candidate-residue convention of :mod:`audit_anchor_star`, but computes every
three-anchor cost once and tests the two uniform claims using integer sums.

For a fixed pivot, let ``C(H)`` be the corrected cost ``U_j(H)`` for a
three-element anchor set.  Then:

* ``3-ANCHOR`` succeeds iff ``min_H C(H) < n*a_j``;
* ``ANCHOR-STAR`` succeeds iff, for some first anchor ``h``, the average of
  ``C(H)`` over triples containing ``h`` is less than ``n*a_j``.

The second equivalence is the exact double-averaging identity audited in
``audit_anchor_star.py``.  Cross-check mode compares every optimized cost and
decision with that slower reference implementation.
"""

from __future__ import annotations

import argparse
import itertools
import math
import random
from dataclasses import dataclass
from functools import lru_cache
from typing import Iterable, Iterator

from audit_anchor_star import (
    anchor_cost,
    has_anchor_star_certificate,
    has_three_anchor_certificate,
    pair_degree,
    pivot_bad_mask,
    second_anchor_gain,
)
from audit_gamma_dispersion import gamma_dispersion_numerator, has_dispersion_star_certificate


@dataclass(frozen=True)
class PivotResult:
    pivot: int
    threshold: int
    minimum_cost: int
    best_anchor_sum: int
    anchor_denominator: int

    @property
    def three_anchor_succeeds(self) -> bool:
        return self.minimum_cost < self.threshold

    @property
    def anchor_star_succeeds(self) -> bool:
        return self.best_anchor_sum < self.threshold * self.anchor_denominator


@dataclass(frozen=True)
class TupleResult:
    speeds: tuple[int, ...]
    pivots: tuple[PivotResult, ...]

    @property
    def three_anchor_succeeds(self) -> bool:
        return any(result.three_anchor_succeeds for result in self.pivots)

    @property
    def anchor_star_succeeds(self) -> bool:
        return any(result.anchor_star_succeeds for result in self.pivots)


class ExactPivot:
    """Cached literal masks and corrected three-anchor costs for one pivot."""

    def __init__(self, speeds: tuple[int, ...], pivot: int):
        if len(speeds) < 4:
            raise ValueError("three-anchor search requires at least four runners")
        self.speeds = speeds
        self.pivot = pivot
        self.n = len(speeds)
        self.factor = self.n + 1
        self.a = speeds[pivot]
        self.modulus = self.factor * self.a
        self.others = tuple(index for index in range(self.n) if index != pivot)
        self.masks = {index: self._bad_mask(index) for index in self.others}

    def _bad_mask(self, index: int) -> int:
        speed = self.speeds[index]
        result = 0
        for residue in range(self.modulus):
            if residue % self.factor == 0:
                continue
            image = speed * residue % self.modulus
            if image < self.a or image > self.modulus - self.a:
                result |= 1 << residue
        return result

    @staticmethod
    def _bits(mask: int) -> Iterator[int]:
        while mask:
            low = mask & -mask
            yield low.bit_length() - 1
            mask ^= low

    @lru_cache(maxsize=None)
    def _distinguished_credit(
        self, child: int, h: int, q: int, r: int
    ) -> int:
        """Corrected credit with ``h`` distinguished and ``q,r`` secondary."""

        # A bin is one child target fiber further split by the full h-image.
        # Entries outside B_h record the two secondary-parent multiplicities.
        bins: dict[tuple[int, int], list[int]] = {}
        child_speed = self.speeds[child]
        h_speed = self.speeds[h]
        q_mask = self.masks[q]
        r_mask = self.masks[r]
        credit = 0
        for residue in self._bits(self.masks[child]):
            h_image = h_speed * residue % self.modulus
            if h_image < self.a or h_image > self.modulus - self.a:
                credit += 1
                continue
            key = (child_speed * residue % self.modulus, h_image)
            counts = bins.setdefault(key, [0, 0])
            bit = 1 << residue
            counts[0] += bool(q_mask & bit)
            counts[1] += bool(r_mask & bit)
        return credit + sum(max(counts) for counts in bins.values())

    @lru_cache(maxsize=None)
    def triple_cost(self, anchors: tuple[int, int, int]) -> int:
        anchors = tuple(sorted(anchors))
        union = 0
        for anchor in anchors:
            union |= self.masks[anchor]
        total = union.bit_count()
        for child in self.others:
            if child in anchors:
                continue
            bad_size = self.masks[child].bit_count()
            credit = 0
            for h in anchors:
                q, r = (anchor for anchor in anchors if anchor != h)
                credit = max(credit, self._distinguished_credit(child, h, q, r))
            total += bad_size - credit
        return total

    def evaluate(self, *, reference_check: bool = False) -> PivotResult:
        triples = tuple(itertools.combinations(self.others, 3))
        costs = {triple: self.triple_cost(triple) for triple in triples}
        if reference_check:
            for triple, cost in costs.items():
                expected = anchor_cost(self.speeds, self.pivot, triple)
                if cost != expected:
                    raise AssertionError(
                        f"optimized cost mismatch: {self.speeds=} {self.pivot=} "
                        f"{triple=} optimized={cost} reference={expected}"
                    )
        denominator = math.comb(len(self.others) - 1, 2)
        anchor_sums = {
            h: sum(cost for triple, cost in costs.items() if h in triple)
            for h in self.others
        }
        return PivotResult(
            pivot=self.pivot,
            threshold=self.n * self.a,
            minimum_cost=min(costs.values()),
            best_anchor_sum=min(anchor_sums.values()),
            anchor_denominator=denominator,
        )


def evaluate_tuple(speeds: tuple[int, ...], *, reference_check: bool = False) -> TupleResult:
    """Evaluate all pivots; optionally check the independent slow oracle."""

    if len(set(speeds)) != len(speeds) or any(speed <= 0 for speed in speeds):
        raise ValueError("speeds must be positive and distinct")
    speeds = tuple(sorted(speeds))
    pivots = tuple(
        ExactPivot(speeds, pivot).evaluate(reference_check=reference_check)
        for pivot in range(len(speeds))
    )
    result = TupleResult(speeds, pivots)
    if reference_check:
        if result.anchor_star_succeeds != has_anchor_star_certificate(speeds):
            raise AssertionError(f"anchor-star decision mismatch for {speeds}")
        if result.three_anchor_succeeds != has_three_anchor_certificate(speeds):
            raise AssertionError(f"three-anchor decision mismatch for {speeds}")
    return result


def certificate_margins(speeds: tuple[int, ...]) -> dict[str, int]:
    """Return exact all-pivot margins; each criterion succeeds iff margin > 0.

    The anchor-star margin is scaled by ``C(n-2,2)`` and the dispersion-star
    margin by ``(n-2)(n-3)``.  These denominators depend only on runner count,
    so margins can be compared exactly within one fixed-``n`` search cohort.
    """

    result = evaluate_tuple(speeds)
    three_margin = max(
        pivot.threshold - pivot.minimum_cost for pivot in result.pivots
    )
    anchor_margin = max(
        pivot.threshold * pivot.anchor_denominator - pivot.best_anchor_sum
        for pivot in result.pivots
    )

    n = len(speeds)
    dispersion_denominator = (n - 2) * (n - 3)
    dispersion_margin: int | None = None
    for pivot in range(n):
        others = tuple(index for index in range(n) if index != pivot)
        required = (
            sum(pivot_bad_mask(speeds, pivot, child).bit_count() for child in others)
            - n * speeds[pivot]
        )
        for h in others:
            sum_e = sum(
                second_anchor_gain(speeds, pivot, h, q)
                for q in others
                if q != h
            )
            numerator = (
                pair_degree(speeds, pivot, h) * dispersion_denominator
                + sum_e * (n - 3)
                + gamma_dispersion_numerator(speeds, pivot, h)
                - required * dispersion_denominator
            )
            if dispersion_margin is None or numerator > dispersion_margin:
                dispersion_margin = numerator
    assert dispersion_margin is not None
    return {
        "dispersion_star": dispersion_margin,
        "anchor_star": anchor_margin,
        "three_anchor": three_margin,
    }


def primitive(speeds: Iterable[int]) -> tuple[int, ...] | None:
    values = tuple(sorted(set(speeds)))
    if len(values) < 4 or values[0] <= 0:
        return None
    common = math.gcd(*values)
    values = tuple(value // common for value in values)
    return values if len(set(values)) == len(values) else None


def complete_box(runners: int, maximum: int) -> Iterator[tuple[int, ...]]:
    for speeds in itertools.combinations(range(1, maximum + 1), runners):
        if math.gcd(*speeds) == 1:
            yield speeds


def structured_cases(runners: int, maximum: int) -> Iterator[tuple[int, ...]]:
    """Gcd-rich, near-multiple, clustered, and lacunary deterministic families."""

    factor = runners + 1
    seen: set[tuple[int, ...]] = set()

    def emit(values: Iterable[int]) -> Iterator[tuple[int, ...]]:
        normalized = primitive(values)
        if normalized is not None and len(normalized) == runners and normalized[-1] <= maximum and normalized not in seen:
            seen.add(normalized)
            yield normalized

    # Arithmetic clusters and deliberately uneven gaps.
    for start in range(1, maximum + 1):
        for step in range(1, max(2, maximum // max(1, runners - 1)) + 1):
            yield from emit(start + step * k for k in range(runners))
            yield from emit(start + step * k * k for k in range(runners))

    # Residues close to multiples of N and shared large divisors.
    for scale in range(1, maximum // factor + 1):
        center = factor * scale
        offsets = tuple(range(-3, 4))
        for chosen in itertools.combinations(offsets, min(runners, len(offsets))):
            if len(chosen) == runners:
                yield from emit(center + offset for offset in chosen)
        for exceptional in range(1, min(maximum, 2 * factor) + 1):
            multiples = [center * k for k in range(1, runners)]
            yield from emit((exceptional, *multiples))

    # Smooth/divisor-heavy selections and truncated geometric progressions.
    smooth = sorted(
        value
        for value in range(1, maximum + 1)
        if value == 1 or all(value % prime for prime in range(7, int(math.sqrt(value)) + 1) if all(prime % d for d in range(2, int(math.sqrt(prime)) + 1)))
    )
    if len(smooth) >= runners:
        stride = max(1, len(smooth) // 25)
        for offset in range(0, len(smooth) - runners + 1, stride):
            yield from emit(smooth[offset : offset + runners])
    for base in (2, 3, 5):
        geometric = [1]
        while geometric[-1] * base <= maximum:
            geometric.append(geometric[-1] * base)
        if len(geometric) >= runners:
            yield from emit(geometric[:runners])
            yield from emit(geometric[-runners:])


def deterministic_random_cases(
    runners: int, maximum: int, samples: int, seed: int
) -> Iterator[tuple[int, ...]]:
    rng = random.Random(seed)
    seen: set[tuple[int, ...]] = set()
    while len(seen) < samples:
        mode = rng.randrange(4)
        if mode == 0:
            values = rng.sample(range(1, maximum + 1), runners)
        elif mode == 1:
            divisor = rng.randint(2, max(2, maximum // runners))
            values = [divisor * rng.randint(1, max(1, maximum // divisor)) for _ in range(runners - 1)]
            values.append(rng.randint(1, maximum))
        elif mode == 2:
            factor = runners + 1
            values = [
                factor * rng.randint(1, max(1, maximum // factor)) + rng.randint(-2, 2)
                for _ in range(runners)
            ]
        else:
            values = [rng.randint(1, max(1, int(math.sqrt(maximum)))) ** 2 for _ in range(runners)]
        normalized = primitive(values)
        if normalized is None or len(normalized) != runners or normalized[-1] > maximum or normalized in seen:
            continue
        seen.add(normalized)
        yield normalized


def scan(
    cases: Iterable[tuple[int, ...]],
    *,
    stop_on_failure: bool = False,
    track_margins: bool = False,
) -> dict[str, object]:
    checked = 0
    dispersion_failure: tuple[int, ...] | None = None
    anchor_failure: tuple[int, ...] | None = None
    three_failure: tuple[int, ...] | None = None
    closest: dict[str, tuple[int, tuple[int, ...]] | None] = {
        "dispersion_star": None,
        "anchor_star": None,
        "three_anchor": None,
    }
    for speeds in cases:
        checked += 1
        result = evaluate_tuple(speeds)
        if dispersion_failure is None and not has_dispersion_star_certificate(speeds):
            # Repeat literally before retaining a stronger-premise failure.
            if has_dispersion_star_certificate(speeds):
                raise AssertionError("non-reproducible DISPERSION-STAR decision")
            dispersion_failure = speeds
        if anchor_failure is None and not result.anchor_star_succeeds:
            # A putative hit is always reconstructed with the independent oracle.
            evaluate_tuple(speeds, reference_check=True)
            anchor_failure = speeds
        if three_failure is None and not result.three_anchor_succeeds:
            evaluate_tuple(speeds, reference_check=True)
            three_failure = speeds
        if track_margins:
            for criterion, margin in certificate_margins(speeds).items():
                previous = closest[criterion]
                if previous is None or margin < previous[0]:
                    closest[criterion] = (margin, speeds)
        if (
            stop_on_failure
            and dispersion_failure is not None
            and anchor_failure is not None
            and three_failure is not None
        ):
            break
    report = {
        "checked": checked,
        "first_dispersion_star_failure": dispersion_failure,
        "first_anchor_star_failure": anchor_failure,
        "first_three_anchor_failure": three_failure,
    }
    if track_margins:
        report["closest_scaled_margins"] = closest
    return report


def main() -> None:
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers(dest="mode", required=True)
    complete = subparsers.add_parser("complete")
    complete.add_argument("--runners", type=int, required=True)
    complete.add_argument("--maximum", type=int, required=True)
    structured = subparsers.add_parser("structured")
    structured.add_argument("--runners", type=int, required=True)
    structured.add_argument("--maximum", type=int, required=True)
    random_parser = subparsers.add_parser("random")
    random_parser.add_argument("--runners", type=int, required=True)
    random_parser.add_argument("--maximum", type=int, required=True)
    random_parser.add_argument("--samples", type=int, required=True)
    random_parser.add_argument("--seed", type=int, default=20260801)
    for search_parser in (complete, structured, random_parser):
        search_parser.add_argument("--track-margins", action="store_true")
    cross = subparsers.add_parser("cross-check")
    cross.add_argument("--samples", type=int, default=25)
    args = parser.parse_args()

    if args.mode == "complete":
        cases = complete_box(args.runners, args.maximum)
    elif args.mode == "structured":
        cases = structured_cases(args.runners, args.maximum)
    elif args.mode == "random":
        cases = deterministic_random_cases(args.runners, args.maximum, args.samples, args.seed)
    else:
        cases = deterministic_random_cases(4, 30, args.samples, 1729)
        checked = 0
        for speeds in cases:
            evaluate_tuple(speeds, reference_check=True)
            checked += 1
        print({"cross_checked": checked})
        return
    print(scan(cases, track_margins=args.track_margins))


if __name__ == "__main__":
    main()
