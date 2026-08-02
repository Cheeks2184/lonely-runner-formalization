#!/usr/bin/env python3
"""Clean-room exact audit of the proposed CHAIN3-UNIF counterexample.

This verifier deliberately does not import any repository certificate or
fiber implementation.  It reconstructs the strict pivot candidates, bad
sets, target fibers, parent intersections, soft loss, and nested block bounds
directly from modular residues.  All optimization uses exact finite subset
dynamic programs.
"""

from __future__ import annotations

from dataclasses import dataclass
from fractions import Fraction
from functools import cache
from math import gcd


SPEEDS = (8, 15, 35, 40, 48, 56, 75, 132, 147)
N = len(SPEEDS) + 1

# (S, F*, beta, B1, B2, B3, exact soft loss, Dopt, nA)
EXPECTED_ROWS = {
    8: (104, 40, 8, 10, 8, 10, 8, 72, 72),
    15: (237, 121, 19, 23, 21, 20, 15, 131, 135),
    35: (503, 242, 54, 63, 62, 60, 38, 299, 315),
    40: (554, 222, 28, 50, 44, 44, 34, 366, 360),
    48: (706, 288, 14, 74, 62, 64, 44, 462, 432),
    56: (812, 348, 40, 82, 64, 64, 58, 522, 504),
    75: (1057, 515, 133, 149, 139, 133, 93, 635, 675),
    132: (1880, 756, 64, 172, 162, 160, 118, 1242, 1188),
    147: (2115, 945, 153, 256, 227, 225, 180, 1350, 1323),
}
EXPECTED_PIVOT_15_ORDER = (40, 75, 48, 35, 132, 8, 56, 147)
EXPECTED_PIVOT_15_COSTS = (25, 50, 14, 8, 12, 10, 8, 4)
EXPECTED_WITNESS_NUMERATORS = (24, 35, 25, 40, 16, 8, 15, 36, 9)
EXPECTED_ENDPOINT_HITS = (
    (8, 13, 13),
    (15, 8, 8),
    (35, 12, 12),
    (40, 26, 26),
    (48, 31, 31),
    (56, 19, 19),
    (75, 23, 23),
    (132, 3, 3),
    (147, 0, 0),
)


@dataclass(frozen=True)
class Token:
    owner: int
    target: int
    fiber: frozenset[int]
    weights: tuple[tuple[int, int], ...]
    potential: int


@dataclass(frozen=True)
class PivotReport:
    pivot: int
    modulus: int
    candidate_count: int
    bad_sum: int
    potential: int
    beta: int
    block_bounds: tuple[int, int, int]
    soft_optimum: int
    additive_optimum: int
    threshold: int
    optimal_order: tuple[int, ...]
    optimal_cost_vector: tuple[int, ...]
    block_components: tuple[tuple[int, ...], ...]


def strict_bad(image: int, pivot: int, modulus: int) -> bool:
    """The endpoints ``pivot`` and ``modulus-pivot`` are good."""

    return image < pivot or image > modulus - pivot


def reconstruct(pivot: int) -> tuple[tuple[int, ...], dict[int, frozenset[int]], tuple[Token, ...]]:
    if pivot not in SPEEDS:
        raise ValueError("pivot is not a speed")
    modulus = N * pivot
    # The canonical candidate set excludes exactly the multiples of N.
    candidates = tuple(residue for residue in range(modulus) if residue % N != 0)
    if len(candidates) != (N - 1) * pivot:
        raise AssertionError("wrong candidate count")

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
            # Since target was obtained from the owner's strict bad set, the
            # whole congruence fiber over the filtered candidate domain is bad.
            if not fiber or not fiber <= bad_sets[owner]:
                raise AssertionError("malformed strict target fiber")
            weights = tuple(
                (parent, len(fiber & bad_sets[parent]))
                for parent in vertices
                if parent != owner
            )
            potential = max((weight for _parent, weight in weights), default=0)
            tokens.append(Token(owner, target, fiber, weights, potential))
    return candidates, bad_sets, tuple(tokens)


def audit_pivot(pivot: int) -> PivotReport:
    candidates, bad_sets, tokens = reconstruct(pivot)
    vertices = tuple(speed for speed in SPEEDS if speed != pivot)
    position = {speed: index for index, speed in enumerate(vertices)}
    full = (1 << len(vertices)) - 1
    by_owner = {
        owner: tuple(token for token in tokens if token.owner == owner)
        for owner in vertices
    }

    @cache
    def deficit(owner: int, unplaced: int) -> int:
        # Earlier vertices are precisely those outside ``unplaced``.  The
        # owner itself is never eligible because it is absent from weights.
        return sum(
            token.potential
            - max(
                (
                    weight
                    for parent, weight in token.weights
                    if unplaced & (1 << position[parent]) == 0
                ),
                default=0,
            )
            for token in by_owner[owner]
        )

    @cache
    def block_cost(unplaced: int, length: int) -> int:
        if length == 0:
            return 0
        if length < 0 or length > unplaced.bit_count():
            raise ValueError("invalid block length")
        return min(
            deficit(owner, unplaced)
            + block_cost(unplaced ^ (1 << position[owner]), length - 1)
            for owner in vertices
            if unplaced & (1 << position[owner])
        )

    subsets_by_size = {
        size: tuple(
            subset
            for subset in range(1, full + 1)
            if subset.bit_count() == size
        )
        for size in range(1, len(vertices) + 1)
    }

    block_bounds: list[int] = []
    block_components: list[tuple[int, ...]] = []
    for width in (1, 2, 3):
        components: list[int] = []
        size = len(vertices)
        while size > 0:
            length = min(width, size)
            components.append(
                max(block_cost(subset, length) for subset in subsets_by_size[size])
            )
            size -= length
        block_components.append(tuple(components))
        block_bounds.append(sum(components))

    @cache
    def best_complete_order(unplaced: int) -> tuple[int, tuple[int, ...]]:
        if unplaced == 0:
            return 0, ()
        choices = []
        for owner in vertices:
            bit = 1 << position[owner]
            if unplaced & bit:
                tail_cost, tail_order = best_complete_order(unplaced ^ bit)
                choices.append((deficit(owner, unplaced) + tail_cost, (owner,) + tail_order))
        # Tuple comparison makes the tie-break deterministic and transparent.
        return min(choices)

    soft_optimum, optimal_order = best_complete_order(full)
    predecessors: set[int] = set()
    cost_vector: list[int] = []
    for owner in optimal_order:
        raw = len(bad_sets[owner])
        credit = sum(
            max(
                (weight for parent, weight in token.weights if parent in predecessors),
                default=0,
            )
            for token in by_owner[owner]
        )
        cost_vector.append(raw - credit)
        predecessors.add(owner)

    bad_sum = sum(map(len, bad_sets.values()))
    potential = sum(token.potential for token in tokens)
    beta = (N - 1) * pivot - bad_sum + potential
    additive_optimum = bad_sum - potential + soft_optimum
    if additive_optimum != sum(cost_vector):
        raise AssertionError("soft-loss and direct additive costs disagree")
    if soft_optimum != block_cost(full, len(vertices)):
        raise AssertionError("complete-order dynamic programs disagree")

    return PivotReport(
        pivot=pivot,
        modulus=N * pivot,
        candidate_count=len(candidates),
        bad_sum=bad_sum,
        potential=potential,
        beta=beta,
        block_bounds=tuple(block_bounds),
        soft_optimum=soft_optimum,
        additive_optimum=additive_optimum,
        threshold=(N - 1) * pivot,
        optimal_order=optimal_order,
        optimal_cost_vector=tuple(cost_vector),
        block_components=tuple(block_components),
    )


def direct_witness() -> tuple[int, Fraction, tuple[int, ...]]:
    pivot = 8
    residue = 13
    modulus = N * pivot
    if residue % N == 0:
        raise AssertionError("witness was excluded from the pivot candidates")
    distances = tuple(
        min((speed * residue) % modulus, modulus - (speed * residue) % modulus)
        for speed in SPEEDS
    )
    if min(distances) < pivot:
        raise AssertionError("claimed direct time is not lonely")
    return residue, Fraction(residue, modulus), distances


def strict_endpoint_audit() -> tuple[tuple[int, int, int], ...]:
    """Verify the strict convention and count actual endpoint occurrences."""

    rows = []
    for pivot in SPEEDS:
        candidates, bad_sets, _tokens = reconstruct(pivot)
        modulus = N * pivot
        if strict_bad(pivot, pivot, modulus) or strict_bad(
            modulus - pivot, pivot, modulus
        ):
            raise AssertionError("a boundary point was declared bad")
        low_hits = 0
        high_hits = 0
        for speed in SPEEDS:
            if speed == pivot:
                continue
            for residue in candidates:
                image = speed * residue % modulus
                if image == pivot:
                    low_hits += 1
                    if residue in bad_sets[speed]:
                        raise AssertionError("low endpoint entered a strict bad set")
                elif image == modulus - pivot:
                    high_hits += 1
                    if residue in bad_sets[speed]:
                        raise AssertionError("high endpoint entered a strict bad set")
        rows.append((pivot, low_hits, high_hits))
    return tuple(rows)


def audit_all() -> tuple[PivotReport, ...]:
    if tuple(sorted(SPEEDS)) != SPEEDS or len(set(SPEEDS)) != len(SPEEDS):
        raise AssertionError("speeds are not distinct and increasing")
    if any(speed <= 0 for speed in SPEEDS):
        raise AssertionError("speeds are not positive")
    if gcd(*SPEEDS) != 1:
        raise AssertionError("tuple is not primitive")
    reports = tuple(audit_pivot(pivot) for pivot in SPEEDS)
    observed = {
        report.pivot: (
            report.bad_sum,
            report.potential,
            report.beta,
            *report.block_bounds,
            report.soft_optimum,
            report.additive_optimum,
            report.threshold,
        )
        for report in reports
    }
    if observed != EXPECTED_ROWS:
        raise AssertionError(f"all-pivot table changed: {observed}")
    # CHAIN3-UNIF requires strict inequality at at least one pivot.
    if any(report.block_bounds[2] < report.beta for report in reports):
        raise AssertionError("tuple does not refute strict CHAIN3-UNIF")
    pivot_15 = reports[SPEEDS.index(15)]
    if pivot_15.optimal_order != EXPECTED_PIVOT_15_ORDER:
        raise AssertionError("pivot-15 deterministic optimum order changed")
    if pivot_15.optimal_cost_vector != EXPECTED_PIVOT_15_COSTS:
        raise AssertionError("pivot-15 insertion costs changed")
    residue, time, distances = direct_witness()
    if (residue, time, distances) != (
        13,
        Fraction(13, 80),
        EXPECTED_WITNESS_NUMERATORS,
    ):
        raise AssertionError("direct witness changed")
    if strict_endpoint_audit() != EXPECTED_ENDPOINT_HITS:
        raise AssertionError("endpoint occurrence audit changed")
    return reports


def main() -> None:
    print("pivot S F* beta B1 B2 B3 soft-opt Dopt threshold")
    for report in audit_all():
        print(
            report.pivot,
            report.bad_sum,
            report.potential,
            report.beta,
            *report.block_bounds,
            report.soft_optimum,
            report.additive_optimum,
            report.threshold,
        )
        print("  components", report.block_components)
        print("  order", report.optimal_order, "costs", report.optimal_cost_vector)
    print("direct", direct_witness())
    print("endpoints", strict_endpoint_audit())


if __name__ == "__main__":
    main()
