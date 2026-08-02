#!/usr/bin/env python3
"""Exact audit of second-best rescue beyond the top-parent criterion.

This script is deliberately self-contained.  It reconstructs the strict
fixed-pivot candidates, bad sets, target fibers, and parent weights directly
from modular residues.  Exhaustive permutation enumeration is then used
instead of importing the repository's top-parent subset DP.

For an order ``o``, ``top_credit(o)`` counts a token only when a globally
best parent precedes its child.  ``rescue(o)`` is the best earlier weight on
exactly the remaining tokens.  Tokenwise inspection gives the exact identity

    full_credit(o) = top_credit(o) + rescue(o).

Consequently, if ``F_top`` is total top weight and
``top_loss(o) = F_top - top_credit(o)``, then

    cost(o) = S - F_top + top_loss(o) - rescue(o).

The two separating rows below show why a top-parent failure does not imply an
additive-order failure: second-best parents can repair lost top edges.
"""

from __future__ import annotations

from dataclasses import dataclass
from fractions import Fraction
from itertools import permutations
from math import gcd


@dataclass(frozen=True)
class Token:
    """One nonempty strict bad child-target fiber."""

    child: int
    target: int
    fiber_size: int
    weights: tuple[tuple[int, int], ...]
    top_weight: int
    top_parents: frozenset[int]


@dataclass(frozen=True)
class LiteralPivot:
    speeds: tuple[int, ...]
    pivot: int
    modulus: int
    candidate_count: int
    others: tuple[int, ...]
    bad_sizes: tuple[tuple[int, int], ...]
    tokens: tuple[Token, ...]

    @property
    def bad_sum(self) -> int:
        return sum(size for _child, size in self.bad_sizes)

    @property
    def top_weight(self) -> int:
        return sum(token.top_weight for token in self.tokens)


@dataclass(frozen=True)
class OrderCredits:
    order: tuple[int, ...]
    top: int
    rescue: int
    full: int


@dataclass(frozen=True)
class ExhaustiveOptima:
    maximum_top: int
    top_order: tuple[int, ...]
    top_order_rescue: int
    top_order_full: int
    maximum_full: int
    full_order: tuple[int, ...]


def _strict_bad(image: int, pivot_speed: int, modulus: int) -> bool:
    """Use strict bad arcs; boundary images A and M-A remain good."""

    return image < pivot_speed or image > modulus - pivot_speed


def literal_pivot(speeds: tuple[int, ...], pivot_speed: int) -> LiteralPivot:
    """Rebuild all token weights by literal residue enumeration."""

    if len(set(speeds)) != len(speeds) or any(speed <= 0 for speed in speeds):
        raise ValueError("speeds must be distinct positive integers")
    if pivot_speed not in speeds:
        raise ValueError("pivot speed is absent")

    runners = len(speeds)
    pivot = speeds.index(pivot_speed)
    modulus = (runners + 1) * pivot_speed
    candidates = tuple(
        residue for residue in range(modulus) if residue % (runners + 1)
    )
    if len(candidates) != runners * pivot_speed:
        raise AssertionError("candidate count is not n*A")

    others = tuple(index for index in range(runners) if index != pivot)
    bad_sets: dict[int, frozenset[int]] = {}
    fibers: dict[int, dict[int, set[int]]] = {}
    for child in others:
        bad: set[int] = set()
        by_target: dict[int, set[int]] = {}
        for residue in candidates:
            image = speeds[child] * residue % modulus
            if _strict_bad(image, pivot_speed, modulus):
                bad.add(residue)
                by_target.setdefault(image, set()).add(residue)
        bad_sets[child] = frozenset(bad)
        fibers[child] = by_target

    tokens: list[Token] = []
    for child in others:
        for target in sorted(fibers[child]):
            fiber = frozenset(fibers[child][target])
            weights = tuple(
                (parent, len(fiber & bad_sets[parent]))
                for parent in others
                if parent != child
            )
            top_weight = max((weight for _parent, weight in weights), default=0)
            top_parents = frozenset(
                parent for parent, weight in weights if weight == top_weight
            )
            tokens.append(
                Token(
                    child=child,
                    target=target,
                    fiber_size=len(fiber),
                    weights=weights,
                    top_weight=top_weight,
                    top_parents=top_parents,
                )
            )

    return LiteralPivot(
        speeds=speeds,
        pivot=pivot,
        modulus=modulus,
        candidate_count=len(candidates),
        others=others,
        bad_sizes=tuple((child, len(bad_sets[child])) for child in others),
        tokens=tuple(tokens),
    )


def order_credits(data: LiteralPivot, order: tuple[int, ...]) -> OrderCredits:
    """Compute top, second-best rescue, and unrestricted credit exactly."""

    if set(order) != set(data.others) or len(order) != len(data.others):
        raise ValueError("order is not a permutation of the nonpivot children")

    by_child = {
        child: tuple(token for token in data.tokens if token.child == child)
        for child in data.others
    }
    predecessors: set[int] = set()
    top_total = 0
    rescue_total = 0
    full_total = 0
    for child in order:
        for token in by_child[child]:
            top = (
                token.top_weight
                if token.top_parents & predecessors
                else 0
            )
            full = max(
                (
                    weight
                    for parent, weight in token.weights
                    if parent in predecessors
                ),
                default=0,
            )
            # If a top parent is earlier, the unrestricted maximum is already
            # W.  Otherwise every positive unrestricted contribution is the
            # second-best rescue omitted by the top-only relaxation.
            rescue = full if top == 0 else 0
            if full != top + rescue:
                raise AssertionError("tokenwise rescue identity failed")
            top_total += top
            rescue_total += rescue
            full_total += full
        predecessors.add(child)

    if full_total != top_total + rescue_total:
        raise AssertionError("summed rescue identity failed")
    return OrderCredits(order, top_total, rescue_total, full_total)


def exhaustive_optima(data: LiteralPivot) -> ExhaustiveOptima:
    """Enumerate every order, with a deterministic speed-lexicographic tie."""

    best_top: OrderCredits | None = None
    best_full: OrderCredits | None = None
    for order in permutations(data.others):
        credits = order_credits(data, order)
        speed_order = tuple(data.speeds[index] for index in order)
        if best_top is None:
            best_top = credits
        else:
            old_speed_order = tuple(
                data.speeds[index] for index in best_top.order
            )
            if credits.top > best_top.top or (
                credits.top == best_top.top and speed_order < old_speed_order
            ):
                best_top = credits
        if best_full is None:
            best_full = credits
        else:
            old_speed_order = tuple(
                data.speeds[index] for index in best_full.order
            )
            if credits.full > best_full.full or (
                credits.full == best_full.full and speed_order < old_speed_order
            ):
                best_full = credits

    if best_top is None or best_full is None:
        raise AssertionError("empty nonpivot order universe")
    return ExhaustiveOptima(
        maximum_top=best_top.top,
        top_order=tuple(data.speeds[index] for index in best_top.order),
        top_order_rescue=best_top.rescue,
        top_order_full=best_top.full,
        maximum_full=best_full.full,
        full_order=tuple(data.speeds[index] for index in best_full.order),
    )


def conditioned_random_loss(data: LiteralPivot) -> tuple[Fraction, int, str]:
    """Best exact expected top loss after fixing one vertex first or last.

    If v is first, a token owned by v is certainly lost, a token having v as
    a top parent is certainly retained, and every other token loses with
    probability 1/(|T|+1).  If v is last, its own tokens are retained; a
    different token having v in T loses with probability 1/|T|; all other
    tokens again use 1/(|T|+1).
    """

    choices: list[tuple[Fraction, int, str]] = []
    for vertex in data.others:
        first = Fraction()
        last = Fraction()
        for token in data.tokens:
            weight = token.top_weight
            if weight == 0:
                continue
            top_count = len(token.top_parents)
            if token.child == vertex:
                first += weight
            elif vertex in token.top_parents:
                last += Fraction(weight, top_count)
            else:
                contribution = Fraction(weight, top_count + 1)
                first += contribution
                last += contribution
        choices.append((first, data.speeds[vertex], "first"))
        choices.append((last, data.speeds[vertex], "last"))
    return min(choices)


def prefix_conditioned_bounds(
    data: LiteralPivot,
) -> tuple[tuple[Fraction, tuple[int, ...]], ...]:
    """Best top-loss bound after optimizing a prefix of each cardinality.

    For a prefix set Q, ``H(Q)`` is the least deterministic loss among orders
    of Q.  Choosing the last prefix child gives the exact recurrence

        H(Q) = min_{i in Q} [H(Q minus {i})
          + sum_{owner(e)=i, T_e intersect (Q minus {i}) empty} W_e].

    Once a minimizing prefix is fixed, uniformly permute its complement.  A
    tail token already covered by a prefix top parent loses with probability
    zero; every other tail token loses with probability 1/(|T_e|+1).
    Therefore the exact expected loss of this randomized completion is

        B(P) = H(P)
          + sum_{owner(e) notin P, T_e intersect P empty} W_e/(|T_e|+1).

    A finite average contains a completion with loss at most B(P).  At the
    full set the random-tail sum vanishes and H is the exact top feedback
    loss, so this hierarchy interpolates between random ordering and the full
    top-only subset DP.
    """

    position = {vertex: index for index, vertex in enumerate(data.others)}
    full_state = (1 << len(data.others)) - 1
    infinity = data.top_weight + 1
    prefix_loss = [infinity] * (full_state + 1)
    prefix_order: list[tuple[int, ...] | None] = [None] * (full_state + 1)
    prefix_loss[0] = 0
    prefix_order[0] = ()
    by_child = {
        child: tuple(
            token
            for token in data.tokens
            if token.child == child and token.top_weight
        )
        for child in data.others
    }

    best_by_size: list[tuple[Fraction, tuple[int, ...]] | None] = [
        None
    ] * (len(data.others) + 1)
    for state in range(full_state + 1):
        order = prefix_order[state]
        if order is None:
            continue
        prefix = {
            vertex
            for vertex in data.others
            if state & (1 << position[vertex])
        }

        expected = Fraction(prefix_loss[state])
        for token in data.tokens:
            if (
                token.top_weight
                and token.child not in prefix
                and not (token.top_parents & prefix)
            ):
                expected += Fraction(
                    token.top_weight, len(token.top_parents) + 1
                )
        speed_order = tuple(data.speeds[vertex] for vertex in order)
        size = len(prefix)
        candidate = (expected, speed_order)
        if best_by_size[size] is None or candidate < best_by_size[size]:
            best_by_size[size] = candidate

        for child in data.others:
            bit = 1 << position[child]
            if state & bit:
                continue
            increment = sum(
                token.top_weight
                for token in by_child[child]
                if not (token.top_parents & prefix)
            )
            successor = state | bit
            candidate_loss = prefix_loss[state] + increment
            candidate_order = order + (child,)
            old_order = prefix_order[successor]
            candidate_key = tuple(
                data.speeds[vertex] for vertex in candidate_order
            )
            old_key = (
                tuple(data.speeds[vertex] for vertex in old_order)
                if old_order is not None
                else None
            )
            if candidate_loss < prefix_loss[successor] or (
                candidate_loss == prefix_loss[successor]
                and (old_key is None or candidate_key < old_key)
            ):
                prefix_loss[successor] = candidate_loss
                prefix_order[successor] = candidate_order

    if any(bound is None for bound in best_by_size):
        raise AssertionError("prefix DP did not populate every cardinality")
    return tuple(bound for bound in best_by_size if bound is not None)


def reciprocal_base(
    data: LiteralPivot, top_order: tuple[int, ...]
) -> tuple[int, int]:
    """Construct a top selector realizing an order and cancel two-cycles.

    Retained tokens choose an earlier top parent.  Lost tokens choose the
    least-speed top parent, necessarily later.  The resulting selector's
    backward weight is the top loss of the supplied top-optimal order.
    ``C2`` is the symmetric reciprocal base paid by every vertex order; the
    second result is the total one-way residual weight after cancellation.
    """

    order = tuple(data.speeds.index(speed) for speed in top_order)
    position = {vertex: index for index, vertex in enumerate(order)}
    edge_weight: dict[tuple[int, int], int] = {}
    for token in data.tokens:
        if token.top_weight == 0:
            continue
        earlier = tuple(
            parent
            for parent in token.top_parents
            if position[parent] < position[token.child]
        )
        parent = min(
            earlier or tuple(token.top_parents),
            key=lambda index: data.speeds[index],
        )
        edge = (parent, token.child)
        edge_weight[edge] = edge_weight.get(edge, 0) + token.top_weight

    reciprocal = sum(
        min(
            edge_weight.get((left, right), 0),
            edge_weight.get((right, left), 0),
        )
        for index, left in enumerate(data.others)
        for right in data.others[index + 1 :]
    )
    residual = sum(edge_weight.values()) - 2 * reciprocal
    return reciprocal, residual


SEPARATING_ROWS = (
    (
        "GCD1-40",
        (8, 15, 35, 40, 48, 56, 63, 75, 78),
        40,
        # N, S, F_top, tau_top, top cost, rescue, same-order full cost,
        # unrestricted optimum, reciprocal base, residual weight.
        (360, 554, 224, 34, 364, 6, 358, 358, 34, 156),
    ),
    (
        "C-56",
        (8, 15, 35, 40, 48, 56, 68, 75, 78),
        56,
        (504, 814, 368, 76, 522, 22, 500, 498, 74, 220),
    ),
)


CONDITIONED_ROWS = (
    ("RF", (2, 3, 7, 9, 10, 12, 15, 16, 19), 16, Fraction(3113, 70), 48),
    ("GCD1", (8, 15, 35, 40, 48, 56, 63, 75, 78), 75, Fraction(2293, 15), 105),
    ("GCD2", (6, 8, 15, 21, 28, 35, 40, 48, 75), 75, Fraction(4571, 30), 107),
    ("hardA", (1, 2, 5, 7, 9, 11, 12, 13), 9, Fraction(28), 36),
    ("hardB", (1, 5, 7, 8, 9, 11, 13, 15), 15, Fraction(39), 46),
    ("small", (1, 2, 3, 5), 3, Fraction(2), 4),
    ("D", (10, 37, 45, 51, 54, 56, 61, 71, 91), 91, Fraction(52337, 210), 243),
    ("C", (8, 15, 35, 40, 48, 56, 68, 75, 78), 75, Fraction(5149, 30), 129),
)


PREFIX_ROWS = (
    # name, speeds, pivot, first strict prefix size, its bound, threshold
    ("RF", (2, 3, 7, 9, 10, 12, 15, 16, 19), 16, 1, Fraction(3113, 70), 48),
    ("GCD1", (8, 15, 35, 40, 48, 56, 63, 75, 78), 75, 4, Fraction(96), 105),
    ("GCD2", (6, 8, 15, 21, 28, 35, 40, 48, 75), 75, 4, Fraction(103), 107),
    ("hardA", (1, 2, 5, 7, 9, 11, 12, 13), 9, 0, Fraction(917, 30), 36),
    ("hardB", (1, 5, 7, 8, 9, 11, 13, 15), 15, 0, Fraction(128, 3), 46),
    ("small", (1, 2, 3, 5), 3, 0, Fraction(2), 4),
    ("D", (10, 37, 45, 51, 54, 56, 61, 71, 91), 91, 2, Fraction(3074, 15), 243),
    ("C", (8, 15, 35, 40, 48, 56, 68, 75, 78), 75, 3, Fraction(362, 3), 129),
)


DIVISOR_ROWS = (
    ((1, 4, 10, 29, 30), 10, (1, 4, 1, 30), (50, 70, 32, 8, 46)),
    ((1, 10, 28, 29, 30), 10, (1, 4, 1, 30), (50, 70, 28, 8, 50)),
)


def main() -> None:
    for name, speeds, pivot, expected in SEPARATING_ROWS:
        data = literal_pivot(speeds, pivot)
        optima = exhaustive_optima(data)
        tau = data.top_weight - optima.maximum_top
        top_cost = data.bad_sum - optima.maximum_top
        same_order_cost = data.bad_sum - optima.top_order_full
        optimum_cost = data.bad_sum - optima.maximum_full
        reciprocal, residual = reciprocal_base(data, optima.top_order)
        observed = (
            data.candidate_count,
            data.bad_sum,
            data.top_weight,
            tau,
            top_cost,
            optima.top_order_rescue,
            same_order_cost,
            optimum_cost,
            reciprocal,
            residual,
        )
        if observed != expected:
            raise AssertionError(f"{name}: {observed} != {expected}")
        print(
            f"{name}: top={top_cost}>={data.candidate_count}, "
            f"rescue={optima.top_order_rescue}, "
            f"same-order full={same_order_cost}<{data.candidate_count}, "
            f"opt={optimum_cost}, C2={reciprocal}, residual={residual}"
        )

    for name, speeds, pivot, expected_bound, threshold in CONDITIONED_ROWS:
        data = literal_pivot(speeds, pivot)
        bound, vertex, placement = conditioned_random_loss(data)
        if bound != expected_bound:
            raise AssertionError(f"{name}: {bound} != {expected_bound}")
        relation = "<" if bound < threshold else ">="
        print(
            f"{name}: conditioned loss {bound} ({vertex} {placement}) "
            f"{relation} required {threshold}"
        )

    for name, speeds, pivot, expected_size, expected_bound, threshold in PREFIX_ROWS:
        data = literal_pivot(speeds, pivot)
        hierarchy = prefix_conditioned_bounds(data)
        strict = tuple(
            (size, bound, order)
            for size, (bound, order) in enumerate(hierarchy)
            if bound < threshold
        )
        if not strict:
            raise AssertionError(f"{name}: no strict prefix-conditioned bound")
        size, bound, order = strict[0]
        if (size, bound) != (expected_size, expected_bound):
            raise AssertionError(
                f"{name}: first strict {(size, bound)} != "
                f"{(expected_size, expected_bound)}"
            )
        print(
            f"{name}: first strict prefix k={size}, loss={bound}<{threshold}, "
            f"prefix={order}; exact endpoint={hierarchy[-1][0]}"
        )

    for speeds, pivot, expected_gcds, expected in DIVISOR_ROWS:
        data = literal_pivot(speeds, pivot)
        optima = exhaustive_optima(data)
        nonpivot_gcds = tuple(
            gcd(speed, data.modulus) for speed in speeds if speed != pivot
        )
        tau = data.top_weight - optima.maximum_top
        observed = (
            data.candidate_count,
            data.bad_sum,
            data.top_weight,
            tau,
            data.bad_sum - optima.maximum_top,
        )
        if nonpivot_gcds != expected_gcds or observed != expected:
            raise AssertionError(
                f"divisor row: gcds={nonpivot_gcds}, values={observed}"
            )
        print(
            f"divisor row {speeds}: gcds={nonpivot_gcds}, "
            f"S={data.bad_sum}, F={data.top_weight}, tau={tau}, "
            f"cost={observed[-1]}"
        )


if __name__ == "__main__":
    main()
