#!/usr/bin/env python3
"""Audit adaptive ordering heuristics for additive fiber-credit bounds.

The arithmetic tables come from ``search_fiber_hall`` and therefore use the
repository's literal strict-boundary pivot masks and maximum-single-parent
fiber credit.  Every heuristic may have ties.  This program optimizes the
final additive bound over *all* orders permitted by those ties, so a reported
failure cannot be repaired merely by changing a deterministic tie-breaker.

All searches are finite computational evidence, not an unbounded Lonely
Runner theorem.
"""

from __future__ import annotations

import argparse
import itertools
import math
from dataclasses import dataclass
from fractions import Fraction
from typing import Literal

from search_fiber_hall import (
    FiberStep,
    _pivot_tables,
    best_additive_pivot_attempt,
    evaluate_additive_order,
)
from search_residual import pivot_bad_mask


Heuristic = Literal["minimum-increment", "maximum-credit", "normalized-credit", "lookahead"]
HEURISTICS: tuple[Heuristic, ...] = (
    "minimum-increment",
    "maximum-credit",
    "normalized-credit",
    "lookahead",
)


@dataclass(frozen=True)
class AdaptiveAttempt:
    """Best additive order among all tie choices allowed by one heuristic."""

    heuristic: Heuristic
    pivot: int
    order: tuple[int, ...]
    universe_size: int
    steps: tuple[FiberStep, ...]

    @property
    def final_upper_bound(self) -> int:
        return sum(step.increment_bound for step in self.steps)

    @property
    def succeeds(self) -> bool:
        return self.final_upper_bound < self.universe_size


@dataclass(frozen=True)
class FixedPivotFailure:
    """A local heuristic failure whose unrestricted additive optimum succeeds."""

    speeds: tuple[int, ...]
    pivot: int
    optimal_order: tuple[int, ...]
    optimal_costs: tuple[int, ...]
    optimal_bound: int
    heuristic_attempt: AdaptiveAttempt
    checked_pivot_instances: int


@dataclass(frozen=True)
class CrossPivotAudit:
    """Result of one complete primitive increasing tuple box."""

    runners: int
    max_speed: int
    tuples: int
    first_failures: dict[Heuristic, tuple[int, ...] | None]


@dataclass(frozen=True)
class GCDClockResult:
    """Exact exponential-clock expectation and its derandomized order."""

    pivot: int
    expected_bound: Fraction
    greedy_order: tuple[int, ...]
    greedy_steps: tuple[FiberStep, ...]
    universe_size: int

    @property
    def greedy_bound(self) -> int:
        return sum(step.increment_bound for step in self.greedy_steps)


@dataclass(frozen=True)
class GCDClockFirstStep:
    """Exact conditional potential after forcing one child to be first.

    ``conditional_bound`` includes both the forced child's literal insertion
    cost and the GCD-clock expectation for every remaining child.  It can be
    below the candidate-universe size even when the unconditioned expectation
    is not, so this is a strictly more flexible certificate interface than
    testing ``GCDClockResult.expected_bound`` alone.
    """

    child: int
    rate: int
    increment_bound: int
    conditional_bound: Fraction


@dataclass(frozen=True)
class GCDClockBoxAudit:
    """Cross-pivot GCD-clock expectation audit for one finite box."""

    runners: int
    max_speed: int
    tuples: int
    first_failure: tuple[int, ...] | None


def _increment(
    child: int,
    state: int,
    counts: dict[int, int],
    lower_bounds: dict[tuple[int, int], int],
) -> int:
    return counts[child] - lower_bounds[(child, state)]


def _normalized_credit(credit: int, bad_size: int) -> Fraction:
    # A zero bad mask also has zero fiber credit.  Giving it ratio zero makes
    # the heuristic total and agrees with the limiting no-coverage case.
    return Fraction(credit, bad_size) if bad_size else Fraction(0)


def admissible_children(
    heuristic: Heuristic,
    others: tuple[int, ...],
    positions: dict[int, int],
    counts: dict[int, int],
    lower_bounds: dict[tuple[int, int], int],
    state: int,
) -> tuple[int, ...]:
    """Return every next child tied for the heuristic's preferred score."""

    candidates = tuple(
        child
        for child in others
        if not state & (1 << positions[child])
    )
    if not candidates:
        return ()

    def increment(child: int) -> int:
        return _increment(child, state, counts, lower_bounds)

    if heuristic == "minimum-increment":
        scores = {child: increment(child) for child in candidates}
        target = min(scores.values())
    elif heuristic == "maximum-credit":
        scores = {child: lower_bounds[(child, state)] for child in candidates}
        target = max(scores.values())
    elif heuristic == "normalized-credit":
        scores = {
            child: _normalized_credit(lower_bounds[(child, state)], counts[child])
            for child in candidates
        }
        target = max(scores.values())
    elif heuristic == "lookahead":
        scores: dict[int, int] = {}
        for child in candidates:
            next_state = state | (1 << positions[child])
            remaining = tuple(
                later
                for later in others
                if not next_state & (1 << positions[later])
            )
            next_increment = min(
                (
                    _increment(later, next_state, counts, lower_bounds)
                    for later in remaining
                ),
                default=0,
            )
            scores[child] = increment(child) + next_increment
        target = min(scores.values())
    else:
        raise ValueError(f"unknown heuristic: {heuristic}")
    return tuple(child for child in candidates if scores[child] == target)


def best_heuristic_attempt(
    speeds: tuple[int, ...], pivot: int, heuristic: Heuristic
) -> AdaptiveAttempt:
    """Optimize the additive total over all heuristic-admissible tie choices."""

    others, counts, _fiber_masks, lower_bounds = _pivot_tables(speeds, pivot)
    positions = {child: position for position, child in enumerate(others)}
    full_state = (1 << len(others)) - 1
    infinity = sum(counts.values()) + 1
    best_tail = [infinity] * (full_state + 1)
    chosen: list[int | None] = [None] * (full_state + 1)
    best_tail[full_state] = 0

    # Adding a child always sets a new bit, hence every successor state is
    # numerically larger and this descending traversal is a valid backward DP.
    for state in range(full_state - 1, -1, -1):
        allowed = admissible_children(
            heuristic, others, positions, counts, lower_bounds, state
        )
        candidate, child = min(
            (
                _increment(child, state, counts, lower_bounds)
                + best_tail[state | (1 << positions[child])],
                child,
            )
            for child in allowed
        )
        best_tail[state] = candidate
        chosen[state] = child

    state = 0
    order: list[int] = []
    while state != full_state:
        child = chosen[state]
        if child is None:
            raise AssertionError("broken adaptive-order predecessor")
        order.append(child)
        state |= 1 << positions[child]

    additive = evaluate_additive_order(speeds, pivot, tuple(order))
    if additive.final_upper_bound != best_tail[0]:
        raise AssertionError("adaptive DP disagrees with direct order evaluation")
    return AdaptiveAttempt(
        heuristic=heuristic,
        pivot=pivot,
        order=tuple(order),
        universe_size=additive.universe_size,
        steps=additive.steps,
    )


def first_fixed_pivot_failures(
    max_runners: int,
    max_speed: int,
) -> dict[Heuristic, FixedPivotFailure | None]:
    """Find bounded-first local failures in a documented deterministic order.

    The enumeration order is runner count, tuple maximum, lexicographic tuple,
    then pivot index.  It stops once every heuristic has failed or the stated
    box is exhausted.  "First" refers only to this finite schedule.
    """

    if not 2 <= max_runners <= max_speed:
        raise ValueError("require 2 <= max_runners <= max_speed")
    result: dict[Heuristic, FixedPivotFailure | None] = {
        heuristic: None for heuristic in HEURISTICS
    }
    checked = 0
    for runners in range(2, max_runners + 1):
        for tuple_maximum in range(runners, max_speed + 1):
            for prefix in itertools.combinations(range(1, tuple_maximum), runners - 1):
                speeds = prefix + (tuple_maximum,)
                if math.gcd(*speeds) != 1:
                    continue
                for pivot in range(runners):
                    checked += 1
                    optimal = best_additive_pivot_attempt(speeds, pivot)
                    if optimal.final_upper_bound >= optimal.universe_size:
                        continue
                    for heuristic in HEURISTICS:
                        if result[heuristic] is not None:
                            continue
                        attempt = best_heuristic_attempt(speeds, pivot, heuristic)
                        if attempt.succeeds:
                            continue
                        result[heuristic] = FixedPivotFailure(
                            speeds=speeds,
                            pivot=pivot,
                            optimal_order=optimal.order,
                            optimal_costs=tuple(
                                step.increment_bound for step in optimal.steps
                            ),
                            optimal_bound=optimal.final_upper_bound,
                            heuristic_attempt=attempt,
                            checked_pivot_instances=checked,
                        )
                    if all(failure is not None for failure in result.values()):
                        return result
    return result


def audit_cross_pivot_box(runners: int, max_speed: int) -> CrossPivotAudit:
    """Check whether each heuristic succeeds at some pivot of every tuple."""

    if not 2 <= runners <= max_speed:
        raise ValueError("require 2 <= runners <= max_speed")
    first_failures: dict[Heuristic, tuple[int, ...] | None] = {
        heuristic: None for heuristic in HEURISTICS
    }
    tuple_count = 0
    for speeds in itertools.combinations(range(1, max_speed + 1), runners):
        if math.gcd(*speeds) != 1:
            continue
        tuple_count += 1
        succeeds = {heuristic: False for heuristic in HEURISTICS}
        for pivot, pivot_speed in enumerate(speeds):
            universe_size = runners * pivot_speed
            for heuristic in HEURISTICS:
                if succeeds[heuristic]:
                    continue
                attempt = best_heuristic_attempt(speeds, pivot, heuristic)
                succeeds[heuristic] = attempt.final_upper_bound < universe_size
        for heuristic in HEURISTICS:
            if not succeeds[heuristic] and first_failures[heuristic] is None:
                first_failures[heuristic] = speeds
    return CrossPivotAudit(runners, max_speed, tuple_count, first_failures)


def _gcd_clock_data(
    speeds: tuple[int, ...], pivot: int
) -> tuple[
    tuple[int, ...],
    dict[int, int],
    dict[int, tuple[int, ...]],
    dict[tuple[int, int], int],
    dict[int, int],
    dict[int, int],
    dict[int, int],
]:
    others, counts, fibers, lower_bounds = _pivot_tables(speeds, pivot)
    positions = {child: position for position, child in enumerate(others)}
    masks = {child: pivot_bad_mask(speeds, pivot, child) for child in others}
    modulus = (len(speeds) + 1) * speeds[pivot]
    rates = {child: math.gcd(speeds[child], modulus) for child in others}
    return others, counts, fibers, lower_bounds, positions, masks, rates


def _gcd_clock_remaining_expectation(
    data: tuple[
        tuple[int, ...],
        dict[int, int],
        dict[int, tuple[int, ...]],
        dict[tuple[int, int], int],
        dict[int, int],
        dict[int, int],
        dict[int, int],
    ],
    state: int,
) -> Fraction:
    """Conditional expected insertion total after fixing an order prefix."""

    others, counts, fibers, _lower_bounds, positions, masks, rates = data
    earlier = tuple(
        parent for parent in others if state & (1 << positions[parent])
    )
    remaining = tuple(
        child for child in others if not state & (1 << positions[child])
    )
    total = Fraction(0)
    for child in remaining:
        future_parents = tuple(parent for parent in remaining if parent != child)
        expected_credit = Fraction(0)
        for fiber in fibers[child]:
            baseline = max(
                ((fiber & masks[parent]).bit_count() for parent in earlier),
                default=0,
            )
            expected_credit += baseline
            maximum = max(
                (
                    (fiber & masks[parent]).bit_count()
                    for parent in future_parents
                ),
                default=baseline,
            )
            for level in range(baseline + 1, maximum + 1):
                rate_sum = sum(
                    rates[parent]
                    for parent in future_parents
                    if (fiber & masks[parent]).bit_count() >= level
                )
                if rate_sum:
                    expected_credit += Fraction(
                        rate_sum, rates[child] + rate_sum
                    )
        total += counts[child] - expected_credit
    return total


def gcd_clock_first_step_values(
    speeds: tuple[int, ...], pivot: int
) -> tuple[GCDClockFirstStep, ...]:
    """Return every exact first-step conditional GCD-clock potential.

    The returned child is an index into ``speeds``.  The function also checks
    the exponential-race identity at the root: the initial potential must be
    the rate-weighted average of these conditional potentials.  A caller may
    therefore force a favorable first child and then apply conditional
    expectation only to the remaining children.
    """

    data = _gcd_clock_data(speeds, pivot)
    others, counts, _fibers, lower_bounds, positions, _masks, rates = data
    if not others:
        return ()
    values = tuple(
        GCDClockFirstStep(
            child=child,
            rate=rates[child],
            increment_bound=_increment(child, 0, counts, lower_bounds),
            conditional_bound=(
                _increment(child, 0, counts, lower_bounds)
                + _gcd_clock_remaining_expectation(
                    data, 1 << positions[child]
                )
            ),
        )
        for child in others
    )
    initial = _gcd_clock_remaining_expectation(data, 0)
    total_rate = sum(value.rate for value in values)
    averaged = sum(
        (
            Fraction(value.rate, total_rate) * value.conditional_bound
            for value in values
        ),
        Fraction(0),
    )
    if averaged != initial:
        raise AssertionError("GCD-clock first-step weighted average mismatch")
    return values


def gcd_clock_result(speeds: tuple[int, ...], pivot: int) -> GCDClockResult:
    """Compute the exact GCD-rate expectation and conditional-expectation order.

    Child ``i`` receives exponential-clock rate ``gcd(a_i, (n+1)A)``.  At a
    fiber-credit tail level, qualifying parents have total rate ``Lambda``;
    one precedes the child with probability ``Lambda / (d_i + Lambda)``.
    """

    data = _gcd_clock_data(speeds, pivot)
    others, counts, _fibers, lower_bounds, positions, _masks, rates = data
    expectation = _gcd_clock_remaining_expectation(data, 0)
    full_state = (1 << len(others)) - 1
    state = 0
    order: list[int] = []
    while state != full_state:
        candidates = tuple(
            child
            for child in others
            if not state & (1 << positions[child])
        )
        conditional_values: dict[int, Fraction] = {}
        for child in candidates:
            next_state = state | (1 << positions[child])
            conditional_values[child] = (
                _increment(child, state, counts, lower_bounds)
                + _gcd_clock_remaining_expectation(data, next_state)
            )

        # Memorylessness gives the current conditional expectation as the
        # rate-weighted average of the values obtained by fixing the next
        # child.  This assertion independently checks every greedy step.
        current = _gcd_clock_remaining_expectation(data, state)
        total_rate = sum(rates[child] for child in candidates)
        averaged = sum(
            (
                Fraction(rates[child], total_rate)
                * conditional_values[child]
                for child in candidates
            ),
            Fraction(0),
        )
        if averaged != current:
            raise AssertionError("GCD-clock conditional expectation mismatch")
        child = min(
            candidates,
            key=lambda candidate: (
                conditional_values[candidate],
                speeds[candidate],
                candidate,
            ),
        )
        if conditional_values[child] > current:
            raise AssertionError("conditional-expectation step increased the bound")
        order.append(child)
        state |= 1 << positions[child]

    additive = evaluate_additive_order(speeds, pivot, tuple(order))
    if Fraction(additive.final_upper_bound) > expectation:
        raise AssertionError("derandomized order exceeds its initial expectation")
    return GCDClockResult(
        pivot=pivot,
        expected_bound=expectation,
        greedy_order=tuple(order),
        greedy_steps=additive.steps,
        universe_size=additive.universe_size,
    )


def audit_gcd_clock_box(runners: int, max_speed: int) -> GCDClockBoxAudit:
    """Search a complete box for failure of every pivot's clock expectation."""

    if not 2 <= runners <= max_speed:
        raise ValueError("require 2 <= runners <= max_speed")
    tuple_count = 0
    first_failure = None
    for speeds in itertools.combinations(range(1, max_speed + 1), runners):
        if math.gcd(*speeds) != 1:
            continue
        tuple_count += 1
        if all(
            gcd_clock_result(speeds, pivot).expected_bound
            >= runners * speeds[pivot]
            for pivot in range(runners)
        ):
            if first_failure is None:
                first_failure = speeds
    return GCDClockBoxAudit(runners, max_speed, tuple_count, first_failure)


def _speed_order(speeds: tuple[int, ...], order: tuple[int, ...]) -> tuple[int, ...]:
    return tuple(speeds[index] for index in order)


def _format_attempt(speeds: tuple[int, ...], attempt: AdaptiveAttempt) -> str:
    return (
        f"heuristic={attempt.heuristic} pivot={speeds[attempt.pivot]} "
        f"universe={attempt.universe_size} "
        f"order={_speed_order(speeds, attempt.order)} "
        f"costs={tuple(step.increment_bound for step in attempt.steps)} "
        f"bound={attempt.final_upper_bound} succeeds={attempt.succeeds}"
    )


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    commands = parser.add_subparsers(dest="command", required=True)

    fixed = commands.add_parser("fixed", help="evaluate one tuple and pivot")
    fixed.add_argument("speeds", nargs="+", type=int)
    fixed.add_argument("--pivot-speed", type=int, required=True)
    fixed.add_argument("--heuristic", choices=(*HEURISTICS, "all"), default="all")

    failures = commands.add_parser(
        "first-failures", help="search bounded-first fixed-pivot failures"
    )
    failures.add_argument("--max-runners", type=int, default=5)
    failures.add_argument("--max-speed", type=int, default=20)

    cross = commands.add_parser(
        "cross-pivot", help="scan one complete primitive tuple box"
    )
    cross.add_argument("--runners", type=int, required=True)
    cross.add_argument("--max-speed", type=int, required=True)

    clock = commands.add_parser(
        "gcd-clock", help="evaluate the GCD-rate exponential clock at one pivot"
    )
    clock.add_argument("speeds", nargs="+", type=int)
    clock.add_argument("--pivot-speed", type=int, required=True)

    clock_box = commands.add_parser(
        "gcd-clock-box", help="scan all pivots in one complete primitive box"
    )
    clock_box.add_argument("--runners", type=int, required=True)
    clock_box.add_argument("--max-speed", type=int, required=True)

    args = parser.parse_args()
    if args.command == "fixed":
        speeds = tuple(args.speeds)
        if args.pivot_speed not in speeds:
            parser.error("--pivot-speed must occur in the tuple")
        pivot = speeds.index(args.pivot_speed)
        selected = HEURISTICS if args.heuristic == "all" else (args.heuristic,)
        optimal = best_additive_pivot_attempt(speeds, pivot)
        print(
            f"speeds={speeds} pivot={args.pivot_speed} "
            f"optimal_order={_speed_order(speeds, optimal.order)} "
            f"optimal_costs={tuple(step.increment_bound for step in optimal.steps)} "
            f"optimal_bound={optimal.final_upper_bound} "
            f"universe={optimal.universe_size}"
        )
        for heuristic in selected:
            print(_format_attempt(speeds, best_heuristic_attempt(speeds, pivot, heuristic)))
        return 0

    if args.command == "first-failures":
        result = first_fixed_pivot_failures(args.max_runners, args.max_speed)
        print(
            f"scope=primitive-increasing max_runners={args.max_runners} "
            f"max_speed={args.max_speed} evidence_only=True"
        )
        for heuristic in HEURISTICS:
            failure = result[heuristic]
            if failure is None:
                print(f"heuristic={heuristic} failure=None")
                continue
            attempt = failure.heuristic_attempt
            print(
                f"heuristic={heuristic} speeds={failure.speeds} "
                f"pivot={failure.speeds[failure.pivot]} "
                f"universe={attempt.universe_size} "
                f"optimal_order={_speed_order(failure.speeds, failure.optimal_order)} "
                f"optimal_costs={failure.optimal_costs} "
                f"optimal_bound={failure.optimal_bound} "
                f"heuristic_order={_speed_order(failure.speeds, attempt.order)} "
                f"heuristic_costs={tuple(s.increment_bound for s in attempt.steps)} "
                f"heuristic_bound={attempt.final_upper_bound} "
                f"checked_pivot_instances={failure.checked_pivot_instances}"
            )
        return 0

    if args.command == "gcd-clock":
        speeds = tuple(args.speeds)
        if args.pivot_speed not in speeds:
            parser.error("--pivot-speed must occur in the tuple")
        result = gcd_clock_result(speeds, speeds.index(args.pivot_speed))
        print(
            f"speeds={speeds} pivot={args.pivot_speed} "
            f"universe={result.universe_size} "
            f"expected_bound={result.expected_bound} "
            f"greedy_order={_speed_order(speeds, result.greedy_order)} "
            f"greedy_costs={tuple(s.increment_bound for s in result.greedy_steps)} "
            f"greedy_bound={result.greedy_bound} evidence_only=True"
        )
        return 0

    if args.command == "gcd-clock-box":
        result = audit_gcd_clock_box(args.runners, args.max_speed)
        print(
            f"scope=primitive-increasing runners={result.runners} "
            f"max_speed={result.max_speed} tuples={result.tuples} "
            f"first_failure={result.first_failure} evidence_only=True"
        )
        return 0

    result = audit_cross_pivot_box(args.runners, args.max_speed)
    print(
        f"scope=primitive-increasing runners={result.runners} "
        f"max_speed={result.max_speed} tuples={result.tuples} "
        f"first_failures={result.first_failures} evidence_only=True"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
