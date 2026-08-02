#!/usr/bin/env python3
"""Independent exact acceptance audit for an all-pivot TOP-CYCLE failure.

The tuple below refutes only the *top-parent restricted* sufficient condition.
It is not a Lonely Runner counterexample: the unrestricted additive optimizer
is already strict at pivot 28, and residue 6 in that pivot clock gives the
explicit lonely time 3/140.

Acceptance deliberately does not import ``search_top_cycle_failures``.  The
all-row values use the older literal set-based audit, while key rows are also
checked by the standalone exhaustive-permutation rescue oracle.
"""

from __future__ import annotations

from dataclasses import dataclass
from fractions import Fraction
from math import gcd

from audit_top_parent_cycles import TopParentAudit, audit_top_parent
from audit_top_parent_rescue import (
    LiteralPivot,
    exhaustive_optima,
    literal_pivot,
    order_credits,
)


TOP_CYCLE_FAILURE = (5, 28, 35, 40, 68, 88, 108, 148, 165)

# pivot: S, F_top, tau_top, D_top, D_opt, n*A
EXPECTED_ROWS = {
    5: (50, 6, 1, 45, 45, 45),
    28: (360, 148, 46, 258, 250, 252),
    35: (500, 245, 60, 315, 299, 315),
    40: (562, 322, 122, 362, 344, 360),
    68: (958, 480, 146, 624, 606, 612),
    88: (1254, 568, 124, 810, 786, 792),
    108: (1544, 756, 194, 982, 940, 972),
    148: (2110, 1040, 294, 1364, 1334, 1332),
    165: (2360, 1086, 215, 1489, 1439, 1485),
}

EXPECTED_PIVOT_28_ORDER = (40, 35, 88, 165, 148, 108, 68, 5)
EXPECTED_PIVOT_28_COSTS = (36, 24, 42, 36, 24, 30, 30, 28)
EXPECTED_WITNESS_DISTANCES = (
    Fraction(3, 28),
    Fraction(2, 5),
    Fraction(1, 4),
    Fraction(1, 7),
    Fraction(16, 35),
    Fraction(4, 35),
    Fraction(11, 35),
    Fraction(6, 35),
    Fraction(13, 28),
)


@dataclass(frozen=True)
class AcceptedRow:
    pivot: int
    bad_sum: int
    top_credit: int
    feedback_loss: int
    top_bound: int
    optimized_bound: int
    threshold: int
    top_order: tuple[int, ...]
    optimized_order: tuple[int, ...]
    optimized_costs: tuple[int, ...]
    positive_tokens: int
    tied_positive_tokens: int
    zero_weight_tokens: int
    top_order_rescue: int
    top_order_full_bound: int
    selected_backward_weight: int


def _index_order(speeds: tuple[int, ...], speed_order: tuple[int, ...]) -> tuple[int, ...]:
    return tuple(speeds.index(speed) for speed in speed_order)


def _insertion_costs(data: LiteralPivot, speed_order: tuple[int, ...]) -> tuple[int, ...]:
    """Reconstruct unrestricted insertion costs token by token."""

    order = _index_order(data.speeds, speed_order)
    bad_sizes = dict(data.bad_sizes)
    by_child = {
        child: tuple(token for token in data.tokens if token.child == child)
        for child in data.others
    }
    predecessors: set[int] = set()
    costs: list[int] = []
    for child in order:
        credit = sum(
            max(
                (
                    weight
                    for parent, weight in token.weights
                    if parent in predecessors
                ),
                default=0,
            )
            for token in by_child[child]
        )
        costs.append(bad_sizes[child] - credit)
        predecessors.add(child)
    return tuple(costs)


def _selected_backward_weight(
    data: LiteralPivot, speed_order: tuple[int, ...]
) -> int:
    """Choose an explicit top parent and total its backward edge weight."""

    order = _index_order(data.speeds, speed_order)
    position = {vertex: rank for rank, vertex in enumerate(order)}
    backward = 0
    for token in data.tokens:
        if token.top_weight == 0:
            continue
        earlier = tuple(
            parent
            for parent in token.top_parents
            if position[parent] < position[token.child]
        )
        selected = min(
            earlier or tuple(token.top_parents),
            key=lambda vertex: data.speeds[vertex],
        )
        if position[selected] > position[token.child]:
            backward += token.top_weight
    return backward


def accept_row(pivot: int) -> AcceptedRow:
    """Run two literal reconstructions and accept one fixed-pivot row."""

    speeds = TOP_CYCLE_FAILURE
    audit: TopParentAudit = audit_top_parent(speeds, pivot)
    data = literal_pivot(speeds, pivot)
    if data.candidate_count != audit.universe_size:
        raise AssertionError("independent candidate counts disagree")
    if data.bad_sum != audit.bad_sum or data.top_weight != audit.top_credit:
        raise AssertionError("independent token reconstructions disagree")

    top_order_indices = _index_order(speeds, audit.top_order)
    top_order_credit = order_credits(data, top_order_indices)
    feedback_loss = data.top_weight - top_order_credit.top
    if feedback_loss != audit.feedback_loss:
        raise AssertionError("literal top order does not realize tau_top")
    if data.bad_sum - top_order_credit.full > audit.top_bound:
        raise AssertionError("soft rescue unexpectedly worsened the top order")

    costs = _insertion_costs(data, audit.optimized_order)
    if sum(costs) != audit.optimized_bound:
        raise AssertionError("literal insertion costs do not sum to D_opt")
    backward = _selected_backward_weight(data, audit.top_order)
    if backward != audit.feedback_loss:
        raise AssertionError("explicit top selector does not realize tau_top")

    positive = tuple(token for token in data.tokens if token.top_weight > 0)
    row = AcceptedRow(
        pivot=pivot,
        bad_sum=audit.bad_sum,
        top_credit=audit.top_credit,
        feedback_loss=audit.feedback_loss,
        top_bound=audit.top_bound,
        optimized_bound=audit.optimized_bound,
        threshold=audit.universe_size,
        top_order=audit.top_order,
        optimized_order=audit.optimized_order,
        optimized_costs=costs,
        positive_tokens=len(positive),
        tied_positive_tokens=sum(
            len(token.top_parents) > 1 for token in positive
        ),
        zero_weight_tokens=sum(token.top_weight == 0 for token in data.tokens),
        top_order_rescue=top_order_credit.rescue,
        top_order_full_bound=data.bad_sum - top_order_credit.full,
        selected_backward_weight=backward,
    )
    expected = EXPECTED_ROWS[pivot]
    observed = (
        row.bad_sum,
        row.top_credit,
        row.feedback_loss,
        row.top_bound,
        row.optimized_bound,
        row.threshold,
    )
    if observed != expected:
        raise AssertionError(f"pivot {pivot}: {observed} != {expected}")
    return row


def accept_all_rows() -> tuple[AcceptedRow, ...]:
    if gcd(*TOP_CYCLE_FAILURE) != 1:
        raise AssertionError("failure tuple is not primitive")
    if len(set(TOP_CYCLE_FAILURE)) != len(TOP_CYCLE_FAILURE):
        raise AssertionError("failure tuple is not distinct")
    rows = tuple(accept_row(pivot) for pivot in TOP_CYCLE_FAILURE)
    if any(row.top_bound < row.threshold for row in rows):
        raise AssertionError("TOP-CYCLE unexpectedly succeeds at a pivot")
    if not any(row.optimized_bound < row.threshold for row in rows):
        raise AssertionError("no unrestricted additive separation was found")
    return rows


def exhaustive_key_rows() -> dict[int, tuple[int, int, tuple[int, ...], tuple[int, ...]]]:
    """Enumerate all 8! orders at the equality and separating key rows."""

    result = {}
    for pivot in (5, 28):
        data = literal_pivot(TOP_CYCLE_FAILURE, pivot)
        optima = exhaustive_optima(data)
        top_bound = data.bad_sum - optima.maximum_top
        optimized_bound = data.bad_sum - optima.maximum_full
        expected = EXPECTED_ROWS[pivot]
        if (top_bound, optimized_bound) != (expected[3], expected[4]):
            raise AssertionError("exhaustive order audit disagrees with subset DP")
        result[pivot] = (
            top_bound,
            optimized_bound,
            optima.top_order,
            optima.full_order,
        )
    return result


def strict_endpoint_audit() -> tuple[tuple[int, int, int], ...]:
    """Count endpoint hits and verify A and M-A are always classified good."""

    n = len(TOP_CYCLE_FAILURE)
    reports = []
    for pivot, A in enumerate(TOP_CYCLE_FAILURE):
        modulus = (n + 1) * A
        candidates = tuple(r for r in range(modulus) if r % (n + 1))
        if len(candidates) != n * A:
            raise AssertionError("literal candidate count mismatch")
        low_hits = 0
        high_hits = 0
        for child, speed in enumerate(TOP_CYCLE_FAILURE):
            if child == pivot:
                continue
            for residue in candidates:
                image = speed * residue % modulus
                if image == A:
                    low_hits += 1
                elif image == modulus - A:
                    high_hits += 1
                if image in (A, modulus - A) and (
                    image < A or image > modulus - A
                ):
                    raise AssertionError("a strict endpoint was classified bad")
        reports.append((A, low_hits, high_hits))
    return tuple(reports)


def witness_audit() -> tuple[Fraction, tuple[Fraction, ...]]:
    """Verify residue 6 in the pivot-28 clock, i.e. t = 3/140."""

    pivot = 28
    modulus = 10 * pivot
    residue = 6
    if residue % 10 == 0:
        raise AssertionError("witness residue is not a candidate")
    distances = tuple(
        Fraction(min((speed * residue) % modulus, modulus - (speed * residue) % modulus), modulus)
        for speed in TOP_CYCLE_FAILURE
    )
    if distances != EXPECTED_WITNESS_DISTANCES:
        raise AssertionError(f"witness distances {distances} are unexpected")
    if min(distances) < Fraction(1, len(TOP_CYCLE_FAILURE) + 1):
        raise AssertionError("explicit time is not lonely")
    return Fraction(residue, modulus), distances


def main() -> None:
    rows = accept_all_rows()
    strict_endpoint_audit()
    key_rows = exhaustive_key_rows()
    time, distances = witness_audit()
    pivot_28_data = literal_pivot(TOP_CYCLE_FAILURE, 28)
    proposed_costs = _insertion_costs(
        pivot_28_data, EXPECTED_PIVOT_28_ORDER
    )
    if proposed_costs != EXPECTED_PIVOT_28_COSTS:
        raise AssertionError("proposed pivot-28 insertion costs changed")
    if sum(proposed_costs) != rows[1].optimized_bound:
        raise AssertionError("proposed pivot-28 order is not optimal")
    for row in rows:
        relation = "=" if row.top_bound == row.threshold else ">"
        print(
            f"pivot={row.pivot:3d}: S={row.bad_sum:4d}, "
            f"F_top={row.top_credit:4d}, tau={row.feedback_loss:3d}, "
            f"D_top={row.top_bound:4d}{relation}{row.threshold:4d}, "
            f"D_opt={row.optimized_bound:4d}, rescue={row.top_order_rescue:3d}, "
            f"same_top_order={row.top_order_full_bound:4d}, "
            f"ties={row.tied_positive_tokens}/{row.positive_tokens}"
        )
    print(f"exhaustive key rows={key_rows}")
    print(
        f"pivot 28 proposed costs={proposed_costs}, "
        f"order={EXPECTED_PIVOT_28_ORDER}"
    )
    print(
        f"pivot 28 deterministic optimum costs={rows[1].optimized_costs}, "
        f"order={rows[1].optimized_order}"
    )
    print(f"witness t={time}, distances={distances}")


if __name__ == "__main__":
    main()
