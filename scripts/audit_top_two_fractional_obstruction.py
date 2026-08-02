#!/usr/bin/env python3
"""Exact obstruction to the proposed global top-two fractional dual.

The certificate is a feasible fractional cover for one two-grid instance.
By weak LP duality it rules out the hoped-for dual mass, but it does not
produce an integral cover and therefore does not refute the top-two pivot
conjecture.
"""

from __future__ import annotations

from itertools import combinations
from math import comb


RUNNERS = 6
N = RUNNERS + 1
PENULTIMATE = 98
FASTEST = 187
LOWER_SPEEDS = tuple(range(1, PENULTIMATE))

# The fractional cover assigns q_x / DENOMINATOR to lower speed x.  This
# integer encoding makes every check below exact and independent of an LP
# solver or floating-point arithmetic.
DENOMINATOR = 241
COVER_NUMERATORS = (
    12, 14, 17, 13, 17, 22, 13, 15, 21, 17, 11, 19, 17, 12, 18, 10,
    11, 14, 10, 16, 9, 11, 10, 20, 12, 18, 6, 13, 7, 18, 4, 12, 11,
    6, 11, 21, 9, 15, 13, 10, 8, 16, 9, 7, 10, 8, 5, 16, 4, 14, 5,
    12, 4, 16, 8, 6, 10, 7, 3, 24, 7, 7, 6, 0, 15, 12, 4, 7, 8, 7,
    5, 11, 5, 6, 15, 4, 4, 17, 5, 11, 5, 5, 5, 6, 7, 3, 3, 6, 2,
    12, 5, 2, 4, 1, 8, 4, 1,
)


def rho(modulus: int, value: int) -> int:
    """Least absolute residue of ``value`` modulo ``modulus``."""

    residue = value % modulus
    return min(residue, modulus - residue)


def mutually_top_good_vertices() -> tuple[tuple[int, int], ...]:
    """Candidate residues not already bad for the other top speed."""

    result = []
    for pivot, other_top in (
        (PENULTIMATE, FASTEST),
        (FASTEST, PENULTIMATE),
    ):
        modulus = N * pivot
        for residue in range(1, modulus):
            # This is exactly the condition that the pivot runner itself is
            # at closed circular distance at least 1/N.
            if residue % N == 0:
                continue
            if rho(modulus, residue * other_top) >= pivot:
                result.append((pivot, residue))
    return tuple(result)


def lower_speed_is_bad(speed: int, vertex: tuple[int, int]) -> bool:
    """Whether ``speed`` is strictly inside the forbidden 1/N arc."""

    pivot, residue = vertex
    return rho(N * pivot, residue * speed) < pivot


def lower_speed_masks(vertices: tuple[tuple[int, int], ...]) -> tuple[int, ...]:
    """Bit masks of vertices covered (made bad) by each lower speed."""

    masks = []
    for speed in LOWER_SPEEDS:
        mask = 0
        for index, vertex in enumerate(vertices):
            if lower_speed_is_bad(speed, vertex):
                mask |= 1 << index
        masks.append(mask)
    return tuple(masks)


def audit_fractional_cover(
    vertices: tuple[tuple[int, int], ...],
) -> tuple[int, tuple[tuple[int, int], ...]]:
    """Verify all fractional-cover rows using scaled integer arithmetic."""

    assert len(COVER_NUMERATORS) == len(LOWER_SPEEDS)
    assert all(numerator >= 0 for numerator in COVER_NUMERATORS)
    assert sum(COVER_NUMERATORS) == 962
    assert sum(COVER_NUMERATORS) < (RUNNERS - 2) * DENOMINATOR

    row_sums = []
    for vertex in vertices:
        row_sum = sum(
            numerator
            for speed, numerator in zip(LOWER_SPEEDS, COVER_NUMERATORS)
            if lower_speed_is_bad(speed, vertex)
        )
        assert row_sum >= DENOMINATOR
        row_sums.append(row_sum)

    minimum = min(row_sums)
    minimum_vertices = tuple(
        vertex
        for vertex, row_sum in zip(vertices, row_sums)
        if row_sum == minimum
    )
    return minimum, minimum_vertices


def audit_four_speed_integral_cover(
    vertices: tuple[tuple[int, int], ...],
) -> tuple[int, tuple[int, int, int, int], int]:
    """Exhaust every possible set of four distinct lower speeds."""

    masks = lower_speed_masks(vertices)
    full_mask = (1 << len(vertices)) - 1
    checked = 0
    maximum_covered = -1
    best_witness = (0, 0, 0, 0)

    for indices in combinations(range(len(LOWER_SPEEDS)), RUNNERS - 2):
        union = 0
        for index in indices:
            union |= masks[index]
        covered = union.bit_count()
        checked += 1
        if covered > maximum_covered:
            maximum_covered = covered
            best_witness = tuple(LOWER_SPEEDS[index] for index in indices)
        assert union != full_mask

    assert checked == comb(len(LOWER_SPEEDS), RUNNERS - 2) == 3_464_840
    assert maximum_covered == 1_142
    assert best_witness == (3, 89, 92, 95)
    return checked, best_witness, maximum_covered


def main() -> int:
    vertices = mutually_top_good_vertices()
    penultimate_vertices = sum(
        pivot == PENULTIMATE for pivot, _ in vertices
    )
    fastest_vertices = sum(pivot == FASTEST for pivot, _ in vertices)
    assert len(vertices) == 1_224
    assert penultimate_vertices == 420
    assert fastest_vertices == 804

    minimum, minimum_vertices = audit_fractional_cover(vertices)
    checked, best_witness, maximum_covered = audit_four_speed_integral_cover(
        vertices
    )

    numerator_sum = sum(COVER_NUMERATORS)
    target_numerator = (RUNNERS - 2) * DENOMINATOR
    print(
        f"instance n={RUNNERS} N={N} top=({PENULTIMATE},{FASTEST}) "
        f"lower=1..{PENULTIMATE - 1}"
    )
    print(
        f"mutually_top_good total={len(vertices)} "
        f"pivot_{PENULTIMATE}={penultimate_vertices} "
        f"pivot_{FASTEST}={fastest_vertices}"
    )
    print(
        f"fractional_cover denominator={DENOMINATOR} "
        f"numerator_sum={numerator_sum} target={target_numerator} "
        f"total={numerator_sum}/{DENOMINATOR}"
    )
    print(
        f"minimum_constraint_numerator={minimum} "
        f"minimum_vertices={minimum_vertices}"
    )
    print(
        "fractional_dual_global_invariant=REJECTED_BY_EXACT_WEAK_DUALITY"
    )
    print(
        f"integral_four_speed_subsets={checked} integral_cover_exists=False "
        f"maximum_covered={maximum_covered}/{len(vertices)} "
        f"best_witness={best_witness} "
        f"uncovered={len(vertices) - maximum_covered}"
    )
    print(
        "AUDIT OK: the fractional-dual invariant is false, while this exact "
        "instance is not an integral top-two counterexample."
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
