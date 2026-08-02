#!/usr/bin/env python3
"""Exact small audit for the top-two fractional-dual research route.

This verifies one fixed pair of top speeds.  It deliberately makes no
uniform assertion about the top-two pivot conjecture or LRC.
"""

from __future__ import annotations

from fractions import Fraction


RUNNERS = 7
N = RUNNERS + 1
PENULTIMATE = 14
FASTEST = 16
LOWER_SPEEDS = tuple(range(1, PENULTIMATE))


def rho(modulus: int, value: int) -> int:
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
            if residue % N == 0:
                continue
            if rho(modulus, residue * other_top) >= pivot:
                result.append((pivot, residue))
    return tuple(result)


def bad_signature(vertex: tuple[int, int]) -> int:
    """Bit ``x-1`` records that lower speed ``x`` is bad at this vertex."""

    pivot, residue = vertex
    modulus = N * pivot
    signature = 0
    for speed in LOWER_SPEEDS:
        if rho(modulus, residue * speed) < pivot:
            signature |= 1 << (speed - 1)
    return signature


def exact_signature_packing(
    vertices: tuple[tuple[int, int], ...],
) -> tuple[int, tuple[tuple[int, int], ...], int, int]:
    """Maximize vertices whose lower-speed bad signatures are disjoint.

    Equal nonzero signatures cannot both occur in a disjoint packing, so one
    representative of each is sufficient.  Zero signatures are all mutually
    compatible and are counted separately.  The DP enumerates every union of
    the 13 possible lower-speed bits and retains a maximum-cardinality witness.
    """

    zero_vertices = tuple(vertex for vertex in vertices if bad_signature(vertex) == 0)
    representative: dict[int, tuple[int, int]] = {}
    for vertex in vertices:
        signature = bad_signature(vertex)
        if signature:
            representative.setdefault(signature, vertex)

    # used signature -> selected representative vertices
    best: dict[int, tuple[tuple[int, int], ...]] = {0: ()}
    for signature, vertex in sorted(representative.items()):
        previous = tuple(best.items())
        for used, witness in previous:
            if used & signature:
                continue
            combined = used | signature
            proposal = witness + (vertex,)
            incumbent = best.get(combined)
            if incumbent is None or len(proposal) > len(incumbent):
                best[combined] = proposal

    nonzero_witness = max(best.values(), key=lambda witness: (len(witness), witness))
    witness = zero_vertices + nonzero_witness
    return len(witness), witness, len(representative), len(best)


DUAL_WEIGHTS = {
    (14, 5): Fraction(1, 2),
    (14, 13): Fraction(1, 2),
    (14, 15): Fraction(1, 2),
    (14, 19): Fraction(1, 2),
    (14, 22): Fraction(1, 2),
    (14, 30): Fraction(1),
    (14, 34): Fraction(1, 2),
    (14, 36): Fraction(1, 2),
    (14, 47): Fraction(1, 2),
    (16, 60): Fraction(1, 2),
}


def main() -> int:
    vertices = mutually_top_good_vertices()
    vertex_set = set(vertices)
    penultimate_vertices = sum(pivot == PENULTIMATE for pivot, _ in vertices)
    fastest_vertices = sum(pivot == FASTEST for pivot, _ in vertices)
    zero_signatures = sum(bad_signature(vertex) == 0 for vertex in vertices)

    packing, witness, unique_patterns, reachable_states = exact_signature_packing(vertices)
    assert packing == 5
    assert packing < RUNNERS - 1
    witness_signatures = tuple(bad_signature(vertex) for vertex in witness)
    assert all(
        first & second == 0
        for index, first in enumerate(witness_signatures)
        for second in witness_signatures[index + 1 :]
    )

    assert set(DUAL_WEIGHTS) <= vertex_set
    assert all(weight > 0 for weight in DUAL_WEIGHTS.values())
    total_weight = sum(DUAL_WEIGHTS.values(), start=Fraction(0))
    assert total_weight == Fraction(11, 2)
    assert total_weight > RUNNERS - 2

    constraint_rows = []
    for speed in LOWER_SPEEDS:
        bad_weight = sum(
            weight
            for (pivot, residue), weight in DUAL_WEIGHTS.items()
            if rho(N * pivot, residue * speed) < pivot
        )
        assert bad_weight == 1
        constraint_rows.append((speed, bad_weight))

    weighted_rows = tuple(
        (pivot, residue, weight.numerator, weight.denominator)
        for (pivot, residue), weight in sorted(DUAL_WEIGHTS.items())
    )
    print(
        f"instance n={RUNNERS} N={N} top=({PENULTIMATE},{FASTEST}) "
        f"lower=1..{PENULTIMATE - 1}"
    )
    print(
        f"mutually_top_good total={len(vertices)} "
        f"pivot_{PENULTIMATE}={penultimate_vertices} "
        f"pivot_{FASTEST}={fastest_vertices} zero_signatures={zero_signatures}"
    )
    print(
        f"integral_signature_packing={packing} target_n_minus_1={RUNNERS - 1} "
        f"unique_nonzero_patterns={unique_patterns} reachable_states={reachable_states}"
    )
    print(f"packing_witness={witness}")
    print(f"packing_witness_signatures={witness_signatures}")
    print(f"dual_weights={weighted_rows}")
    print(
        f"dual_total={total_weight.numerator}/{total_weight.denominator} "
        f"cover_budget_n_minus_2={RUNNERS - 2}"
    )
    print(
        "lower_speed_bad_weights="
        + " ".join(
            f"{speed}:{weight.numerator}/{weight.denominator}"
            for speed, weight in constraint_rows
        )
    )
    print(
        "AUDIT OK: integral disjoint-signature packing is too small, while "
        "the exact fractional dual blocks every five-lower-speed cover."
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
