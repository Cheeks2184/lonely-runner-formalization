#!/usr/bin/env python3
"""Audit balanced and additive fiberwise overlap criteria on exact masks.

For a pivot speed ``A`` and ``N = len(speeds) + 1``, the candidate universe is
the residues modulo ``N*A`` that are not divisible by ``N``.  The bad masks
are imported from :mod:`search_residual`, so this program uses exactly the
same strict-boundary convention as the other modular-certificate searches.

If ``b`` is the child runner, its bad mask is partitioned into fibers by the
centered residue ``x = b*r (mod N*A)``, where ``-A < x < A``.  Given earlier
parents ``P``, the program uses only

    sum_x max_{c in P} |F_b(x) intersect B_c|.

In particular, it never replaces a fiber's maximum single-parent
intersection by its intersection with the union of all parents.  Two exact
subset DPs optimize respectively the common-``q`` bottleneck bound and the
sharper sum of the individual insertion bounds.
"""

from __future__ import annotations

import argparse
import itertools
import math
import random
from dataclasses import dataclass
from typing import Iterable

from search_residual import (
    covered_by_fast_insertion,
    covered_by_minimum_residue_bands,
    divisor_insertion_condition_indices,
    pivot_bad_mask,
)


@dataclass(frozen=True)
class FiberStep:
    """One insertion in a checked balanced-growth order."""

    child: int
    bad_size: int
    fiber_lower_bound: int

    @property
    def increment_bound(self) -> int:
        return self.bad_size - self.fiber_lower_bound


@dataclass(frozen=True)
class FiberCertificate:
    """An exact balanced-growth certificate for one pivot and order."""

    pivot: int
    order: tuple[int, ...]
    q: int
    universe_size: int
    steps: tuple[FiberStep, ...]

    @property
    def final_upper_bound(self) -> int:
        return self.steps[0].bad_size + (len(self.steps) - 1) * self.q


@dataclass(frozen=True)
class AdditiveFiberCertificate:
    """An exact fiber-credit certificate using every insertion separately."""

    pivot: int
    order: tuple[int, ...]
    universe_size: int
    steps: tuple[FiberStep, ...]

    @property
    def final_upper_bound(self) -> int:
        return sum(step.increment_bound for step in self.steps)


def pivot_candidates(speeds: tuple[int, ...], pivot: int) -> int:
    """Return the literal candidate-universe mask for ``pivot``."""

    modulus_factor = len(speeds) + 1
    modulus = modulus_factor * speeds[pivot]
    mask = 0
    for residue in range(modulus):
        if residue % modulus_factor != 0:
            mask |= 1 << residue
    return mask


def child_fibers(
    speeds: tuple[int, ...], pivot: int, child: int
) -> tuple[tuple[int, int], ...]:
    """Return the nonempty literal ``(x, F_child(x))`` masks.

    The target ``x`` is represented by its unique integer in
    ``{-A+1, ..., A-1}``.  The fibers are independently constructed from the
    defining congruence rather than by splitting ``pivot_bad_mask``.
    """

    if child == pivot:
        raise ValueError("the child must differ from the pivot")
    modulus_factor = len(speeds) + 1
    pivot_speed = speeds[pivot]
    modulus = modulus_factor * pivot_speed
    candidates = pivot_candidates(speeds, pivot)
    grouped: dict[int, int] = {}
    for residue in range(modulus):
        if not candidates & (1 << residue):
            continue
        image = (speeds[child] * residue) % modulus
        if image < pivot_speed:
            target = image
        elif image > modulus - pivot_speed:
            target = image - modulus
        else:
            continue
        grouped[target] = grouped.get(target, 0) | (1 << residue)
    result = sorted(grouped.items())

    # This identity checks both the strict endpoint convention and that the
    # fibers really partition the current literal bad mask.
    fiber_union = 0
    for _target, mask in result:
        if fiber_union & mask:
            raise AssertionError("child fibers are not disjoint")
        fiber_union |= mask
    literal_bad = pivot_bad_mask(speeds, pivot, child)
    if fiber_union != literal_bad:
        raise AssertionError("child fibers do not equal the literal bad mask")
    return tuple(result)


def fiber_lower_bound_from_masks(
    fibers: Iterable[int], parent_masks: Iterable[int]
) -> int:
    """Sum the largest *single-parent* intersection in each child fiber."""

    checked_parents = tuple(parent_masks)
    if not checked_parents:
        return 0
    return sum(
        max((fiber & parent).bit_count() for parent in checked_parents)
        for fiber in fibers
    )


def evaluate_order(
    speeds: tuple[int, ...],
    pivot: int,
    order: tuple[int, ...],
    q: int | None = None,
) -> FiberCertificate:
    """Evaluate one order, taking the least valid ``q`` when it is omitted."""

    expected = {index for index in range(len(speeds)) if index != pivot}
    if len(order) != len(expected) or set(order) != expected:
        raise ValueError("order must contain every nonpivot index exactly once")
    masks = {child: pivot_bad_mask(speeds, pivot, child) for child in order}
    fibers = {
        child: tuple(mask for _target, mask in child_fibers(speeds, pivot, child))
        for child in order
    }
    steps: list[FiberStep] = []
    parents: list[int] = []
    for child in order:
        lower_bound = fiber_lower_bound_from_masks(
            fibers[child], (masks[parent] for parent in parents)
        )
        steps.append(FiberStep(child, masks[child].bit_count(), lower_bound))
        parents.append(child)
    least_q = max((step.increment_bound for step in steps[1:]), default=0)
    if q is None:
        q = least_q
    if q < 0:
        raise ValueError("q must be nonnegative")
    return FiberCertificate(
        pivot=pivot,
        order=order,
        q=q,
        universe_size=len(speeds) * speeds[pivot],
        steps=tuple(steps),
    )


def certificate_is_valid(certificate: FiberCertificate) -> bool:
    """Check exactly the two inequalities in the balanced-growth criterion."""

    return (
        certificate.final_upper_bound < certificate.universe_size
        and all(
            step.increment_bound <= certificate.q
            for step in certificate.steps[1:]
        )
    )


def evaluate_additive_order(
    speeds: tuple[int, ...], pivot: int, order: tuple[int, ...]
) -> AdditiveFiberCertificate:
    """Evaluate the sum of the individual fiberwise insertion bounds."""

    balanced = evaluate_order(speeds, pivot, order)
    return AdditiveFiberCertificate(
        pivot=pivot,
        order=order,
        universe_size=balanced.universe_size,
        steps=balanced.steps,
    )


def additive_certificate_is_valid(certificate: AdditiveFiberCertificate) -> bool:
    """Check that the additive union upper bound is strictly below ``|R|``."""

    return certificate.final_upper_bound < certificate.universe_size


def _pivot_tables(
    speeds: tuple[int, ...], pivot: int
) -> tuple[
    tuple[int, ...],
    dict[int, int],
    dict[int, tuple[int, ...]],
    dict[tuple[int, int], int],
]:
    """Precompute subset fiber bounds used by the order-search DP."""

    others = tuple(index for index in range(len(speeds)) if index != pivot)
    positions = {child: position for position, child in enumerate(others)}
    masks = {child: pivot_bad_mask(speeds, pivot, child) for child in others}
    counts = {child: masks[child].bit_count() for child in others}
    fiber_masks = {
        child: tuple(mask for _target, mask in child_fibers(speeds, pivot, child))
        for child in others
    }
    lower_bounds: dict[tuple[int, int], int] = {}
    for child in others:
        for state in range(1 << len(others)):
            if state & (1 << positions[child]):
                continue
            parents = (
                masks[parent]
                for parent in others
                if state & (1 << positions[parent])
            )
            lower_bounds[(child, state)] = fiber_lower_bound_from_masks(
                fiber_masks[child], parents
            )
    return others, counts, fiber_masks, lower_bounds


def find_pivot_certificate(
    speeds: tuple[int, ...], pivot: int
) -> FiberCertificate | None:
    """Search all orders and all useful ``q`` by subset reachability.

    For fixed ``q`` and first child, a state is reachable exactly when some
    ordering of its members obeys every insertion inequality.  Thus the
    subset dynamic program is exhaustive over permutations without explicitly
    enumerating them.
    """

    certificate = best_pivot_attempt(speeds, pivot)
    return certificate if certificate_is_valid(certificate) else None


def best_pivot_attempt(
    speeds: tuple[int, ...], pivot: int
) -> FiberCertificate:
    """Minimize the balanced-growth final bound over every child order.

    With the first child fixed, the only path statistic needed is the largest
    insertion bound seen so far.  A subset DP minimizing that bottleneck is
    therefore exhaustive.  The outer minimization also tests every possible
    first child.
    """

    others, counts, _fiber_masks, lower_bounds = _pivot_tables(speeds, pivot)
    positions = {child: position for position, child in enumerate(others)}
    full_state = (1 << len(others)) - 1
    universe_size = len(speeds) * speeds[pivot]
    multiplier = max(0, len(others) - 1)
    best_certificate: FiberCertificate | None = None
    for first in others:
        initial = 1 << positions[first]
        infinity = sum(counts.values()) + 1
        bottleneck = [infinity] * (full_state + 1)
        bottleneck[initial] = 0
        predecessor: list[tuple[int, int] | None] = [None] * (full_state + 1)
        for state in range(full_state + 1):
            if bottleneck[state] == infinity:
                continue
            for child in others:
                child_bit = 1 << positions[child]
                if state & child_bit:
                    continue
                increment = counts[child] - lower_bounds[(child, state)]
                candidate = max(bottleneck[state], increment)
                next_state = state | child_bit
                if candidate < bottleneck[next_state]:
                    bottleneck[next_state] = candidate
                    predecessor[next_state] = (state, child)

        q = bottleneck[full_state]
        reverse_tail: list[int] = []
        state = full_state
        while state != initial:
            link = predecessor[state]
            if link is None:
                raise AssertionError("broken bottleneck-DP predecessor")
            state, child = link
            reverse_tail.append(child)
        order = (first, *reversed(reverse_tail))
        certificate = evaluate_order(speeds, pivot, order, q)
        if certificate.q != q:
            raise AssertionError("DP bottleneck disagrees with direct evaluation")
        if (
            best_certificate is None
            or certificate.final_upper_bound < best_certificate.final_upper_bound
        ):
            best_certificate = certificate
    if best_certificate is None:
        raise AssertionError("a pivot in a tuple of length at least two has children")
    if best_certificate.universe_size != universe_size:
        raise AssertionError("inconsistent candidate-universe size")
    return best_certificate


def find_certificate(speeds: tuple[int, ...]) -> FiberCertificate | None:
    """Return the first fiberwise certificate over every possible pivot."""

    if len(speeds) < 2:
        raise ValueError("at least two speeds are required")
    if any(speed <= 0 for speed in speeds) or len(set(speeds)) != len(speeds):
        raise ValueError("speeds must be distinct positive integers")
    for pivot in range(len(speeds)):
        certificate = find_pivot_certificate(speeds, pivot)
        if certificate is not None:
            return certificate
    return None


def best_additive_pivot_attempt(
    speeds: tuple[int, ...], pivot: int
) -> AdditiveFiberCertificate:
    """Minimize the sum of insertion bounds over every child order."""

    others, counts, _fiber_masks, lower_bounds = _pivot_tables(speeds, pivot)
    positions = {child: position for position, child in enumerate(others)}
    full_state = (1 << len(others)) - 1
    infinity = sum(counts.values()) + 1
    cost = [infinity] * (full_state + 1)
    predecessor: list[tuple[int, int] | None] = [None] * (full_state + 1)

    # Every possible first child is an initial state with cost |B_first|.
    for first in others:
        cost[1 << positions[first]] = counts[first]
    for state in range(1, full_state + 1):
        if cost[state] == infinity:
            continue
        for child in others:
            child_bit = 1 << positions[child]
            if state & child_bit:
                continue
            increment = counts[child] - lower_bounds[(child, state)]
            next_state = state | child_bit
            candidate = cost[state] + increment
            if candidate < cost[next_state]:
                cost[next_state] = candidate
                predecessor[next_state] = (state, child)

    reverse_order: list[int] = []
    state = full_state
    while state & (state - 1):
        link = predecessor[state]
        if link is None:
            raise AssertionError("broken additive-DP predecessor")
        state, child = link
        reverse_order.append(child)
    first = others[state.bit_length() - 1]
    order = (first, *reversed(reverse_order))
    certificate = evaluate_additive_order(speeds, pivot, order)
    if certificate.final_upper_bound != cost[full_state]:
        raise AssertionError("additive DP disagrees with direct evaluation")
    return certificate


def find_additive_pivot_certificate(
    speeds: tuple[int, ...], pivot: int
) -> AdditiveFiberCertificate | None:
    """Return the best additive certificate for one pivot, if it is strict."""

    certificate = best_additive_pivot_attempt(speeds, pivot)
    return certificate if additive_certificate_is_valid(certificate) else None


def find_additive_certificate(
    speeds: tuple[int, ...],
) -> AdditiveFiberCertificate | None:
    """Return the first additive fiber certificate over every pivot."""

    if len(speeds) < 2:
        raise ValueError("at least two speeds are required")
    if any(speed <= 0 for speed in speeds) or len(set(speeds)) != len(speeds):
        raise ValueError("speeds must be distinct positive integers")
    for pivot in range(len(speeds)):
        certificate = find_additive_pivot_certificate(speeds, pivot)
        if certificate is not None:
            return certificate
    return None


def is_structural_residual(speeds: tuple[int, ...]) -> bool:
    """Test the repository's three already-proved elementary branches."""

    return not (
        covered_by_fast_insertion(speeds)
        or covered_by_minimum_residue_bands(speeds)
        or divisor_insertion_condition_indices(speeds)
    )


def audit_box(
    runners: int,
    max_speed: int,
    residual_only: bool = True,
    objective: str = "balanced",
) -> tuple[int, int, tuple[int, ...] | None]:
    """Audit all primitive increasing tuples in the indicated finite box."""

    if objective not in {"balanced", "additive"}:
        raise ValueError("objective must be 'balanced' or 'additive'")

    checked = 0
    certified = 0
    first_failure = None
    for speeds in itertools.combinations(range(1, max_speed + 1), runners):
        if math.gcd(*speeds) != 1:
            continue
        if residual_only and not is_structural_residual(speeds):
            continue
        checked += 1
        certificate = (
            find_certificate(speeds)
            if objective == "balanced"
            else find_additive_certificate(speeds)
        )
        if certificate is not None:
            certified += 1
        elif first_failure is None:
            first_failure = speeds
    return checked, certified, first_failure


def audit_random(
    runners: int,
    max_speed: int,
    samples: int,
    seed: int,
    residual_only: bool = True,
    objective: str = "additive",
) -> tuple[int, int, tuple[int, ...] | None]:
    """Audit a reproducible sample of distinct primitive increasing tuples."""

    if samples < 1:
        raise ValueError("samples must be positive")
    generator = random.Random(seed)
    checked: set[tuple[int, ...]] = set()
    certified = 0
    attempts = 0
    while len(checked) < samples and attempts < 1000 * samples:
        attempts += 1
        speeds = tuple(sorted(generator.sample(range(1, max_speed + 1), runners)))
        if speeds in checked or math.gcd(*speeds) != 1:
            continue
        if residual_only and not is_structural_residual(speeds):
            continue
        checked.add(speeds)
        certificate = (
            find_certificate(speeds)
            if objective == "balanced"
            else find_additive_certificate(speeds)
        )
        if certificate is None:
            return len(checked), certified, speeds
        certified += 1
    if len(checked) != samples:
        raise RuntimeError("could not generate the requested number of eligible samples")
    return len(checked), certified, None


def _format_certificate(
    speeds: tuple[int, ...], certificate: FiberCertificate
) -> str:
    step_rows = tuple(
        (
            speeds[step.child],
            step.bad_size,
            step.bad_size - certificate.q,
            step.fiber_lower_bound,
        )
        for step in certificate.steps
    )
    return (
        f"pivot={speeds[certificate.pivot]} q={certificate.q} "
        f"universe={certificate.universe_size} "
        f"order={tuple(speeds[index] for index in certificate.order)} "
        f"rows(speed,bad,required,fiberLB)={step_rows} "
        f"upper_bound={certificate.final_upper_bound}"
    )


def _format_additive_certificate(
    speeds: tuple[int, ...], certificate: AdditiveFiberCertificate
) -> str:
    step_rows = tuple(
        (
            speeds[step.child],
            step.bad_size,
            step.fiber_lower_bound,
            step.increment_bound,
        )
        for step in certificate.steps
    )
    return (
        f"pivot={speeds[certificate.pivot]} universe={certificate.universe_size} "
        f"order={tuple(speeds[index] for index in certificate.order)} "
        f"rows(speed,bad,fiberLB,increment)={step_rows} "
        f"additive_upper_bound={certificate.final_upper_bound}"
    )


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--tuple", nargs="+", type=int, dest="speeds")
    parser.add_argument(
        "--show-all-pivots",
        action="store_true",
        help="with --tuple, print the globally best order for every pivot",
    )
    parser.add_argument("--runners", type=int)
    parser.add_argument("--max-speed", type=int)
    parser.add_argument(
        "--samples",
        type=int,
        help="audit this many deterministic pseudorandom eligible tuples",
    )
    parser.add_argument("--seed", type=int, default=0)
    parser.add_argument(
        "--objective",
        choices=("balanced", "additive"),
        default="balanced",
        help="order objective to optimize (default: balanced)",
    )
    parser.add_argument(
        "--all-tuples",
        action="store_true",
        help="include tuples covered by an existing elementary branch",
    )
    args = parser.parse_args()
    if args.speeds is not None:
        speeds = tuple(args.speeds)
        if args.show_all_pivots:
            for pivot in range(len(speeds)):
                if args.objective == "balanced":
                    attempt = best_pivot_attempt(speeds, pivot)
                    valid = certificate_is_valid(attempt)
                    formatted = _format_certificate(speeds, attempt)
                else:
                    attempt = best_additive_pivot_attempt(speeds, pivot)
                    valid = additive_certificate_is_valid(attempt)
                    formatted = _format_additive_certificate(speeds, attempt)
                print(f"speeds={speeds} valid={valid} {formatted}")
            return 0
        certificate = (
            find_certificate(speeds)
            if args.objective == "balanced"
            else find_additive_certificate(speeds)
        )
        if certificate is None:
            print(
                f"speeds={speeds} objective={args.objective} "
                "fiber_certificate=None"
            )
        else:
            formatted = (
                _format_certificate(speeds, certificate)
                if isinstance(certificate, FiberCertificate)
                else _format_additive_certificate(speeds, certificate)
            )
            print(f"speeds={speeds} objective={args.objective} {formatted}")
        return 0
    if args.runners is None or args.max_speed is None:
        parser.error("supply --tuple, or both --runners and --max-speed")
    if not 2 <= args.runners <= args.max_speed:
        parser.error("require 2 <= runners <= max-speed")
    if args.samples is None:
        checked, certified, failure = audit_box(
            args.runners,
            args.max_speed,
            residual_only=not args.all_tuples,
            objective=args.objective,
        )
        search_kind = "exhaustive"
    else:
        checked, certified, failure = audit_random(
            args.runners,
            args.max_speed,
            args.samples,
            args.seed,
            residual_only=not args.all_tuples,
            objective=args.objective,
        )
        search_kind = f"random(seed={args.seed})"
    print(
        f"runners={args.runners} max_speed={args.max_speed} "
        f"scope={'all-primitive' if args.all_tuples else 'structural-residual'} "
        f"objective={args.objective} search={search_kind} "
        f"checked={checked} certified={certified} "
        f"uncertified={checked - certified} first_failure={failure}"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
