#!/usr/bin/env python3
"""Audit the explicit whole-overlap capacity certificate for F at pivot 8.

Everything is rebuilt by literal residue enumeration.  The selected blocks
are data, not trusted summaries: each must equal a complete filtered target
fiber intersected with its stated parent's strict bad set.
"""

from __future__ import annotations

from collections import Counter
from dataclasses import dataclass


SPEEDS = (8, 15, 35, 40, 48, 56, 75, 132, 147)
PIVOT = 8
N = len(SPEEDS) + 1
MODULUS = N * PIVOT


@dataclass(frozen=True)
class Block:
    owner: int
    target: int
    parent: int
    residues: frozenset[int]


def block(owner: int, target: int, parent: int, *residues: int) -> Block:
    return Block(owner, target, parent, frozenset(residues))


SELECTED = (
    block(15, 0, 35, 16, 32, 48, 64),
    block(15, 5, 132, 43),
    block(15, 75, 132, 37),
    block(35, 0, 15, 16, 32, 48, 64),
    block(35, 5, 48, 55),
    block(35, 75, 48, 25),
    block(40, 0, 15, 16, 32, 48, 64),
    block(48, 0, 15, 5, 75),
    block(75, 5, 48, 15),
    block(75, 75, 48, 65),
    block(132, 4, 35, 57),
    block(132, 76, 35, 23),
    block(147, 1, 15, 43),
    block(147, 2, 40, 6),
    block(147, 3, 75, 49),
    block(147, 4, 40, 12),
    block(147, 5, 35, 55),
    block(147, 6, 40, 18),
    block(147, 74, 40, 62),
    block(147, 75, 35, 25),
    block(147, 76, 40, 68),
    block(147, 77, 75, 31),
    block(147, 78, 40, 74),
    block(147, 79, 15, 37),
)

EXPECTED_GOOD = (13, 29, 51, 67)
EXPECTED_SATURATED = {
    16: 3,
    32: 3,
    48: 3,
    64: 3,
    25: 2,
    37: 2,
    43: 2,
    55: 2,
}


@dataclass(frozen=True)
class CapacityReport:
    candidate_count: int
    bad_sum: int
    union_size: int
    good_residues: tuple[int, ...]
    selected_blocks: int
    selected_credit: int
    certified_bound: int
    ordered_additive_credit: int
    ordered_additive_bound: int
    used_capacity: tuple[tuple[int, int, int], ...]


def strict_bad(image: int) -> bool:
    return image < PIVOT or image > MODULUS - PIVOT


def literal_sets() -> tuple[tuple[int, ...], tuple[int, ...], dict[int, frozenset[int]]]:
    candidates = tuple(residue for residue in range(MODULUS) if residue % N != 0)
    vertices = tuple(speed for speed in SPEEDS if speed != PIVOT)
    bad_sets = {
        speed: frozenset(
            residue
            for residue in candidates
            if strict_bad(speed * residue % MODULUS)
        )
        for speed in vertices
    }
    if len(candidates) != 72 or any(residue % N == 0 for residue in candidates):
        raise AssertionError("candidate filter mismatch")
    if strict_bad(PIVOT) or strict_bad(MODULUS - PIVOT):
        raise AssertionError("strict endpoints were classified bad")
    return candidates, vertices, bad_sets


def ordered_additive_optimum(
    candidates: tuple[int, ...],
    vertices: tuple[int, ...],
    bad_sets: dict[int, frozenset[int]],
) -> tuple[int, int]:
    """Return maximum ordered credit and the corresponding minimum bound."""

    del candidates  # Fibers below use the same literal domain via bad sets.
    position = {speed: index for index, speed in enumerate(vertices)}
    full = (1 << len(vertices)) - 1
    tokens = {}
    for owner in vertices:
        targets = sorted({owner * residue % MODULUS for residue in bad_sets[owner]})
        tokens[owner] = tuple(
            tuple(
                (
                    parent,
                    len(
                        frozenset(
                            residue
                            for residue in bad_sets[owner]
                            if owner * residue % MODULUS == target
                        )
                        & bad_sets[parent]
                    ),
                )
                for parent in vertices
                if parent != owner
            )
            for target in targets
        )

    credit = [[0] * (full + 1) for _owner in vertices]
    for child, owner in enumerate(vertices):
        for predecessors in range(full + 1):
            if predecessors & (1 << child):
                continue
            credit[child][predecessors] = sum(
                max(
                    (
                        weight
                        for parent, weight in weights
                        if predecessors & (1 << position[parent])
                    ),
                    default=0,
                )
                for weights in tokens[owner]
            )
    maximum = [-1] * (full + 1)
    maximum[0] = 0
    for state in range(full + 1):
        if maximum[state] < 0:
            continue
        for child in range(len(vertices)):
            bit = 1 << child
            if state & bit == 0:
                successor = state | bit
                maximum[successor] = max(
                    maximum[successor], maximum[state] + credit[child][state]
                )
    bad_sum = sum(map(len, bad_sets.values()))
    return maximum[full], bad_sum - maximum[full]


def audit() -> CapacityReport:
    candidates, vertices, bad_sets = literal_sets()
    if len(SELECTED) != 24:
        raise AssertionError("selected block count changed")
    tokens = [(entry.owner, entry.target) for entry in SELECTED]
    if len(set(tokens)) != len(tokens):
        raise AssertionError("a token was selected more than once")

    for entry in SELECTED:
        if entry.owner not in vertices or entry.parent not in vertices:
            raise AssertionError("block uses pivot or absent speed")
        if entry.owner == entry.parent:
            raise AssertionError("self-parent block")
        fiber = frozenset(
            residue
            for residue in candidates
            if entry.owner * residue % MODULUS == entry.target
        )
        if not fiber or not fiber <= bad_sets[entry.owner]:
            raise AssertionError("selected target is not a whole strict bad fiber")
        literal_block = fiber & bad_sets[entry.parent]
        if entry.residues != literal_block:
            raise AssertionError(
                f"block {(entry.owner, entry.target, entry.parent)}: "
                f"{sorted(entry.residues)} != {sorted(literal_block)}"
            )

    multiplicity = {
        residue: sum(residue in bad_sets[speed] for speed in vertices)
        for residue in candidates
    }
    capacity = {
        residue: max(0, multiplicity[residue] - 1) for residue in candidates
    }
    used = Counter(
        residue for entry in SELECTED for residue in entry.residues
    )
    if any(used[residue] > capacity[residue] for residue in used):
        raise AssertionError("selected overlap exceeds a residue capacity")
    if any(used[residue] != cap for residue, cap in EXPECTED_SATURATED.items()):
        raise AssertionError("reported saturated capacities changed")
    if any(
        amount != 1
        for residue, amount in used.items()
        if residue not in EXPECTED_SATURATED
    ):
        raise AssertionError("a remaining selected residue is not used once")

    bad_sum = sum(map(len, bad_sets.values()))
    union = frozenset().union(*bad_sets.values())
    good = tuple(residue for residue in candidates if residue not in union)
    selected_credit = sum(map(len, (entry.residues for entry in SELECTED)))
    ordered_credit, ordered_bound = ordered_additive_optimum(
        candidates, vertices, bad_sets
    )
    if (
        bad_sum,
        len(union),
        good,
        selected_credit,
        bad_sum - selected_credit,
        ordered_credit,
        ordered_bound,
    ) != (104, 68, EXPECTED_GOOD, 34, 70, 32, 72):
        raise AssertionError("capacity certificate aggregate changed")
    if not bad_sum - selected_credit < len(candidates):
        raise AssertionError("selected capacity certificate is not strict")

    return CapacityReport(
        candidate_count=len(candidates),
        bad_sum=bad_sum,
        union_size=len(union),
        good_residues=good,
        selected_blocks=len(SELECTED),
        selected_credit=selected_credit,
        certified_bound=bad_sum - selected_credit,
        ordered_additive_credit=ordered_credit,
        ordered_additive_bound=ordered_bound,
        used_capacity=tuple(
            (residue, used[residue], capacity[residue]) for residue in sorted(used)
        ),
    )


def main() -> None:
    print(audit())


if __name__ == "__main__":
    main()
