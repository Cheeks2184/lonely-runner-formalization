#!/usr/bin/env python3
"""Independent exact audit of Sol Response 33's top-parent criterion.

This file deliberately rebuilds the strict modular candidate universe, bad
sets, child fibers, and both subset dynamic programs from literal residues.
It imports none of the repository's earlier certificate implementations.

For a fixed pivot, a positive-weight fiber token earns its full top-parent
weight when at least one maximum-weight parent precedes its child.  The
minimum lost top weight over all orders is the optimized feedback loss.  The
unrestricted additive program instead earns the largest intersection with
*any* preceding parent, so its final bound can only improve on the top-parent
bound.
"""

from __future__ import annotations

from dataclasses import dataclass


@dataclass(frozen=True)
class FiberToken:
    child: int
    target: int
    fiber: frozenset[int]
    weights: tuple[tuple[int, int], ...]
    top_weight: int
    top_parents: frozenset[int]


@dataclass(frozen=True)
class TopParentAudit:
    speeds: tuple[int, ...]
    pivot: int
    universe_size: int
    bad_sum: int
    top_credit: int
    feedback_loss: int
    top_bound: int
    top_order: tuple[int, ...]
    selected_backward_weight: int
    optimized_bound: int
    optimized_order: tuple[int, ...]


def _strict_bad(image: int, pivot_speed: int, modulus: int) -> bool:
    """The boundary points ``A`` and ``M-A`` are good, not bad."""

    return image < pivot_speed or image > modulus - pivot_speed


def _candidate_residues(runners: int, pivot_speed: int) -> tuple[int, ...]:
    modulus = (runners + 1) * pivot_speed
    return tuple(residue for residue in range(modulus) if residue % (runners + 1))


def _literal_data(
    speeds: tuple[int, ...], pivot: int
) -> tuple[
    tuple[int, ...],
    int,
    dict[int, frozenset[int]],
    tuple[FiberToken, ...],
]:
    runners = len(speeds)
    pivot_speed = speeds[pivot]
    modulus = (runners + 1) * pivot_speed
    candidates = _candidate_residues(runners, pivot_speed)
    if len(candidates) != runners * pivot_speed:
        raise AssertionError("candidate count is not n*A")

    others = tuple(index for index in range(runners) if index != pivot)
    bad_sets: dict[int, frozenset[int]] = {}
    fibers: dict[int, dict[int, set[int]]] = {}
    for child in others:
        by_target: dict[int, set[int]] = {}
        bad: set[int] = set()
        for residue in candidates:
            image = speeds[child] * residue % modulus
            if _strict_bad(image, pivot_speed, modulus):
                bad.add(residue)
                by_target.setdefault(image, set()).add(residue)
        bad_sets[child] = frozenset(bad)
        fibers[child] = by_target

    tokens: list[FiberToken] = []
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
                FiberToken(
                    child=child,
                    target=target,
                    fiber=fiber,
                    weights=weights,
                    top_weight=top_weight,
                    top_parents=top_parents,
                )
            )
    return others, len(candidates), bad_sets, tuple(tokens)


def _best_order(
    speeds: tuple[int, ...],
    others: tuple[int, ...],
    tokens: tuple[FiberToken, ...],
    *,
    top_only: bool,
) -> tuple[int, tuple[int, ...]]:
    """Maximize retained credit, with a deterministic speed-order tie break."""

    positions = {child: position for position, child in enumerate(others)}
    full = (1 << len(others)) - 1
    best = [-1] * (full + 1)
    orders: list[tuple[int, ...] | None] = [None] * (full + 1)
    best[0] = 0
    orders[0] = ()

    by_child = {
        child: tuple(token for token in tokens if token.child == child)
        for child in others
    }
    for state in range(full + 1):
        prefix = orders[state]
        if prefix is None:
            continue
        predecessors = {
            child for child in others if state & (1 << positions[child])
        }
        for child in others:
            bit = 1 << positions[child]
            if state & bit:
                continue
            if top_only:
                increment = sum(
                    token.top_weight
                    for token in by_child[child]
                    if token.top_weight and token.top_parents & predecessors
                )
            else:
                increment = sum(
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
            successor = state | bit
            candidate_value = best[state] + increment
            candidate_order = prefix + (child,)
            old_order = orders[successor]
            speed_key = tuple(speeds[index] for index in candidate_order)
            old_key = (
                tuple(speeds[index] for index in old_order)
                if old_order is not None
                else None
            )
            if candidate_value > best[successor] or (
                candidate_value == best[successor]
                and (old_key is None or speed_key < old_key)
            ):
                best[successor] = candidate_value
                orders[successor] = candidate_order

    order = orders[full]
    if order is None:
        raise AssertionError("subset order DP did not reach its full state")
    return best[full], order


def audit_top_parent(speeds: tuple[int, ...], pivot_speed: int) -> TopParentAudit:
    if len(set(speeds)) != len(speeds) or any(speed <= 0 for speed in speeds):
        raise ValueError("speeds must be distinct positive integers")
    if pivot_speed not in speeds:
        raise ValueError("pivot speed is absent")
    pivot = speeds.index(pivot_speed)
    others, universe_size, bad_sets, tokens = _literal_data(speeds, pivot)
    bad_sum = sum(len(bad_sets[child]) for child in others)
    top_credit = sum(token.top_weight for token in tokens)

    retained_top, top_order = _best_order(
        speeds, others, tokens, top_only=True
    )
    feedback_loss = top_credit - retained_top
    top_bound = bad_sum - retained_top

    # Construct a top selector after fixing the optimal order.  Pick an
    # earlier top parent whenever possible.  Otherwise every possible top
    # edge is backward, so any deterministic choice realizes the exact loss.
    order_position = {child: position for position, child in enumerate(top_order)}
    selected_backward_weight = 0
    for token in tokens:
        if token.top_weight == 0:
            continue
        earlier = tuple(
            parent
            for parent in token.top_parents
            if order_position[parent] < order_position[token.child]
        )
        selected = min(
            earlier or tuple(token.top_parents), key=lambda index: speeds[index]
        )
        if order_position[selected] > order_position[token.child]:
            selected_backward_weight += token.top_weight

    retained_opt, optimized_order = _best_order(
        speeds, others, tokens, top_only=False
    )
    optimized_bound = bad_sum - retained_opt
    if selected_backward_weight != feedback_loss:
        raise AssertionError("constructed top selector disagrees with top DP")
    if optimized_bound > top_bound:
        raise AssertionError("unrestricted additive DP exceeded top-parent bound")
    return TopParentAudit(
        speeds=speeds,
        pivot=pivot,
        universe_size=universe_size,
        bad_sum=bad_sum,
        top_credit=top_credit,
        feedback_loss=feedback_loss,
        top_bound=top_bound,
        top_order=tuple(speeds[index] for index in top_order),
        selected_backward_weight=selected_backward_weight,
        optimized_bound=optimized_bound,
        optimized_order=tuple(speeds[index] for index in optimized_order),
    )


STRESS_ROWS = (
    ("RF", (2, 3, 7, 9, 10, 12, 15, 16, 19), 16, (224, 128, 36, 132, 144)),
    (
        "GCD1",
        (8, 15, 35, 40, 48, 56, 63, 75, 78),
        75,
        (1057, 487, 87, 657, 675),
    ),
    (
        "GCD2",
        (6, 8, 15, 21, 28, 35, 40, 48, 75),
        75,
        (1057, 489, 81, 649, 675),
    ),
    ("hardA", (1, 2, 5, 7, 9, 11, 12, 13), 9, (108, 72, 28, 64, 72)),
    ("hardB", (1, 5, 7, 8, 9, 11, 13, 15), 15, (174, 100, 34, 108, 120)),
    ("small", (1, 2, 3, 5), 3, (12, 4, 2, 10, 12)),
    (
        "D",
        (10, 37, 45, 51, 54, 56, 61, 71, 91),
        91,
        (1309, 733, 160, 736, 819),
    ),
    (
        "C",
        (8, 15, 35, 40, 48, 56, 68, 75, 78),
        75,
        (1060, 514, 97, 643, 675),
    ),
)

EXPECTED_OPTIMIZED_BOUNDS = {
    "RF": 132,
    "GCD1": 647,
    "GCD2": 643,
    "hardA": 64,
    "hardB": 108,
    "small": 10,
    "D": 727,
    "C": 631,
}


def main() -> None:
    for name, speeds, pivot, expected in STRESS_ROWS:
        audit = audit_top_parent(speeds, pivot)
        observed = (
            audit.bad_sum,
            audit.top_credit,
            audit.feedback_loss,
            audit.top_bound,
            audit.universe_size,
        )
        if observed != expected:
            raise AssertionError(f"{name}: {observed} != {expected}")
        if audit.optimized_bound != EXPECTED_OPTIMIZED_BOUNDS[name]:
            raise AssertionError(
                f"{name}: optimized {audit.optimized_bound} != "
                f"{EXPECTED_OPTIMIZED_BOUNDS[name]}"
            )
        print(
            f"{name:5s} pivot={pivot:2d}: "
            f"S={audit.bad_sum}, F_top={audit.top_credit}, "
            f"tau_top={audit.feedback_loss}, D_top={audit.top_bound}"
            f"<{audit.universe_size}; opt={audit.optimized_bound}; "
            f"top_order={audit.top_order}; opt_order={audit.optimized_order}"
        )


if __name__ == "__main__":
    main()
