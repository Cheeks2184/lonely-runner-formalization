#!/usr/bin/env python3
"""Clean-room exact audit of the proposed OPT-ADD-UNIF counterexample G.

The implementation imports no repository fiber or search code.  It literally
enumerates strict modular candidates and fibers, solves each unrestricted
additive objective by subset DP, and independently checks all 8! orders.
"""

from __future__ import annotations

from dataclasses import dataclass
from fractions import Fraction
from itertools import permutations
from math import factorial, gcd


SPEEDS = (15, 21, 40, 48, 56, 105, 126, 280, 1200)
N = len(SPEEDS) + 1

# (S, F*, exact soft loss, Dopt, nA)
EXPECTED_ROWS = {
    15: (290, 182, 27, 135, 135),
    21: (356, 164, 28, 220, 189),
    40: (780, 492, 72, 360, 360),
    48: (856, 448, 56, 464, 432),
    56: (896, 442, 52, 506, 504),
    105: (1410, 529, 66, 947, 945),
    126: (1822, 728, 102, 1196, 1134),
    280: (3790, 1376, 154, 2568, 2520),
    1200: (17232, 7636, 1228, 10824, 10800),
}
EXPECTED_WITNESS_NUMERATORS = (105, 141, 120, 48, 216, 225, 114, 120, 240)


@dataclass(frozen=True)
class Token:
    owner: int
    target: int
    weights: tuple[tuple[int, int], ...]
    potential: int


@dataclass(frozen=True)
class PivotReport:
    pivot: int
    candidate_count: int
    bad_sum: int
    potential: int
    soft_optimum: int
    additive_optimum: int
    threshold: int
    optimal_order: tuple[int, ...]
    optimal_cost_vector: tuple[int, ...]
    exhaustive_orders: int
    endpoint_hits: tuple[int, int]


def strict_bad(image: int, pivot: int, modulus: int) -> bool:
    return image < pivot or image > modulus - pivot


def literal_data(
    pivot: int,
) -> tuple[
    tuple[int, ...],
    tuple[int, ...],
    dict[int, frozenset[int]],
    tuple[Token, ...],
]:
    if pivot not in SPEEDS:
        raise ValueError("absent pivot")
    modulus = N * pivot
    candidates = tuple(residue for residue in range(modulus) if residue % N != 0)
    if len(candidates) != (N - 1) * pivot:
        raise AssertionError("candidate count mismatch")
    if any(residue % N == 0 for residue in candidates):
        raise AssertionError("excluded pivot residue was retained")

    vertices = tuple(speed for speed in SPEEDS if speed != pivot)
    bad_sets = {
        speed: frozenset(
            residue
            for residue in candidates
            if strict_bad(speed * residue % modulus, pivot, modulus)
        )
        for speed in vertices
    }
    tokens: list[Token] = []
    for owner in vertices:
        targets = sorted({owner * residue % modulus for residue in bad_sets[owner]})
        for target in targets:
            fiber = frozenset(
                residue
                for residue in candidates
                if owner * residue % modulus == target
            )
            if not fiber or not fiber <= bad_sets[owner]:
                raise AssertionError("strict target fiber mismatch")
            weights = tuple(
                (parent, len(fiber & bad_sets[parent]))
                for parent in vertices
                if parent != owner
            )
            potential = max((weight for _parent, weight in weights), default=0)
            tokens.append(Token(owner, target, weights, potential))
    return candidates, vertices, bad_sets, tuple(tokens)


def audit_pivot(pivot: int) -> PivotReport:
    candidates, vertices, bad_sets, tokens = literal_data(pivot)
    position = {speed: index for index, speed in enumerate(vertices)}
    full = (1 << len(vertices)) - 1
    by_owner = {
        owner: tuple(token for token in tokens if token.owner == owner)
        for owner in vertices
    }

    insertion = [[0] * (full + 1) for _owner in vertices]
    for child, owner in enumerate(vertices):
        for predecessors in range(full + 1):
            if predecessors & (1 << child):
                continue
            credit = sum(
                max(
                    (
                        weight
                        for parent, weight in token.weights
                        if predecessors & (1 << position[parent])
                    ),
                    default=0,
                )
                for token in by_owner[owner]
            )
            insertion[child][predecessors] = len(bad_sets[owner]) - credit

    infinity = sum(map(len, bad_sets.values())) + 1
    dp = [infinity] * (full + 1)
    order_dp: list[tuple[int, ...] | None] = [None] * (full + 1)
    costs_dp: list[tuple[int, ...] | None] = [None] * (full + 1)
    dp[0] = 0
    order_dp[0] = ()
    costs_dp[0] = ()
    for state in range(full + 1):
        if dp[state] == infinity:
            continue
        for child, owner in enumerate(vertices):
            bit = 1 << child
            if state & bit:
                continue
            successor = state | bit
            step = insertion[child][state]
            candidate = dp[state] + step
            candidate_order = order_dp[state] + (owner,)  # type: ignore[operator]
            if candidate < dp[successor] or (
                candidate == dp[successor]
                and (order_dp[successor] is None or candidate_order < order_dp[successor])
            ):
                dp[successor] = candidate
                order_dp[successor] = candidate_order
                costs_dp[successor] = costs_dp[state] + (step,)  # type: ignore[operator]

    exhaustive_best = infinity
    exhaustive_order: tuple[int, ...] | None = None
    exhaustive_costs: tuple[int, ...] | None = None
    order_count = 0
    for local_order in permutations(range(len(vertices))):
        order_count += 1
        state = 0
        total = 0
        costs: list[int] = []
        for child in local_order:
            step = insertion[child][state]
            total += step
            costs.append(step)
            state |= 1 << child
        speed_order = tuple(vertices[child] for child in local_order)
        if total < exhaustive_best or (
            total == exhaustive_best
            and (exhaustive_order is None or speed_order < exhaustive_order)
        ):
            exhaustive_best = total
            exhaustive_order = speed_order
            exhaustive_costs = tuple(costs)
    if order_count != factorial(len(vertices)) or order_count != 40320:
        raise AssertionError("did not enumerate all 8! orders")
    if (exhaustive_best, exhaustive_order, exhaustive_costs) != (
        dp[full],
        order_dp[full],
        costs_dp[full],
    ):
        raise AssertionError("exhaustive order oracle disagrees with subset DP")

    bad_sum = sum(map(len, bad_sets.values()))
    potential = sum(token.potential for token in tokens)
    soft_optimum = dp[full] - bad_sum + potential
    modulus = N * pivot
    low_hits = 0
    high_hits = 0
    if strict_bad(pivot, pivot, modulus) or strict_bad(modulus - pivot, pivot, modulus):
        raise AssertionError("strict boundary classifier is wrong")
    for speed in vertices:
        for residue in candidates:
            image = speed * residue % modulus
            if image == pivot:
                low_hits += 1
                if residue in bad_sets[speed]:
                    raise AssertionError("low boundary entered bad set")
            elif image == modulus - pivot:
                high_hits += 1
                if residue in bad_sets[speed]:
                    raise AssertionError("high boundary entered bad set")

    return PivotReport(
        pivot=pivot,
        candidate_count=len(candidates),
        bad_sum=bad_sum,
        potential=potential,
        soft_optimum=soft_optimum,
        additive_optimum=dp[full],
        threshold=(N - 1) * pivot,
        optimal_order=order_dp[full],  # type: ignore[arg-type]
        optimal_cost_vector=costs_dp[full],  # type: ignore[arg-type]
        exhaustive_orders=order_count,
        endpoint_hits=(low_hits, high_hits),
    )


def direct_witness() -> tuple[int, Fraction, tuple[int, ...]]:
    pivot = 48
    residue = 39
    modulus = N * pivot
    if residue % N == 0:
        raise AssertionError("witness residue is excluded")
    numerators = tuple(
        min((speed * residue) % modulus, modulus - (speed * residue) % modulus)
        for speed in SPEEDS
    )
    if numerators != EXPECTED_WITNESS_NUMERATORS:
        raise AssertionError(f"witness numerators changed: {numerators}")
    if min(numerators) < pivot:
        raise AssertionError("direct witness is not lonely")
    return residue, Fraction(residue, modulus), numerators


def audit_all() -> tuple[PivotReport, ...]:
    if tuple(sorted(SPEEDS)) != SPEEDS or len(set(SPEEDS)) != len(SPEEDS):
        raise AssertionError("speeds are not positive/distinct/increasing")
    if SPEEDS[0] <= 0 or gcd(*SPEEDS) != 1:
        raise AssertionError("speeds are not positive and primitive")
    reports = tuple(audit_pivot(pivot) for pivot in SPEEDS)
    observed = {
        report.pivot: (
            report.bad_sum,
            report.potential,
            report.soft_optimum,
            report.additive_optimum,
            report.threshold,
        )
        for report in reports
    }
    if observed != EXPECTED_ROWS:
        raise AssertionError(f"reported table mismatch: {observed}")
    if any(report.additive_optimum < report.threshold for report in reports):
        raise AssertionError("strict OPT-ADD unexpectedly succeeds")
    if tuple(
        report.pivot for report in reports
        if report.additive_optimum == report.threshold
    ) != (15, 40):
        raise AssertionError("strict equality pivots changed")
    direct_witness()
    return reports


def main() -> None:
    print("A S F* soft Dopt 9A endpoints order costs")
    for report in audit_all():
        print(
            report.pivot,
            report.bad_sum,
            report.potential,
            report.soft_optimum,
            report.additive_optimum,
            report.threshold,
            report.endpoint_hits,
            report.optimal_order,
            report.optimal_cost_vector,
        )
    print("direct", direct_witness())


if __name__ == "__main__":
    main()
