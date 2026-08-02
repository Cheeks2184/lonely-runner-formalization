#!/usr/bin/env python3
r"""Audit the exact chain-aware block-peeling bound for soft fiber loss.

For an unplaced vertex set ``Q``, ``delta_i(Q)`` is the loss paid when owner
``i`` is removed next.  The exact cost of the best ordered ``k``-vertex block
inside ``Q`` is

    g_k(Q) = min_{distinct i_1,...,i_k in Q}
             sum_s delta_(i_s)(Q \ {i_1,...,i_(s-1)}).

Let ``b_k(q)`` be the worst ``g_k`` over all ``q``-element sets.  Removing
blocks of size ``k`` gives the valid universal bound

    B_k = b_k(m) + b_k(m-k) + ...,

with the last block shortened when necessary.  This verifier reconstructs
the literal strict modular fibers through the established independent token
oracle, but implements the block recurrence and all subset maxima here.
"""

from __future__ import annotations

from dataclasses import dataclass
from functools import cache

from audit_top_parent_rescue import LiteralPivot, literal_pivot


@dataclass(frozen=True)
class ChainAudit:
    name: str
    speeds: tuple[int, ...]
    pivot: int
    block_bounds: tuple[int, int, int]
    optimum: int
    cardinal_bound: tuple[int, ...]
    block_components: tuple[tuple[int, ...], ...]


CASES = (
    # name, speeds, pivot, expected (B_1, B_2, B_3, exact optimum)
    ("RF", (2, 3, 7, 9, 10, 12, 15, 16, 19), 19, (62, 50, 49, 44)),
    ("GCD1", (8, 15, 35, 40, 48, 56, 63, 75, 78), 75, (115, 101, 95, 77)),
    ("GCD2", (6, 8, 15, 21, 28, 35, 40, 48, 75), 75, (107, 95, 89, 75)),
    ("hardA", (1, 2, 5, 7, 9, 11, 12, 13), 9, (28, 28, 28, 28)),
    ("hardB", (1, 5, 7, 8, 9, 11, 13, 15), 15, (34, 34, 34, 34)),
    ("small", (1, 2, 3, 5), 3, (2, 2, 2, 2)),
    ("D", (10, 37, 45, 51, 54, 56, 61, 71, 91), 91, (169, 153, 151, 151)),
    ("C", (8, 15, 35, 40, 48, 56, 68, 75, 78), 75, (111, 95, 93, 85)),
    (
        "E-165",
        (5, 28, 35, 40, 68, 88, 108, 148, 165),
        165,
        (259, 219, 187, 165),
    ),
)


def audit_case(name: str, speeds: tuple[int, ...], pivot: int) -> ChainAudit:
    data: LiteralPivot = literal_pivot(speeds, pivot)
    vertices = data.others
    positions = {vertex: position for position, vertex in enumerate(vertices)}
    full = (1 << len(vertices)) - 1
    owned = {
        vertex: tuple(token for token in data.tokens if token.child == vertex)
        for vertex in vertices
    }

    @cache
    def deficit(vertex: int, unplaced: int) -> int:
        """Exact external deficit of ``vertex`` relative to ``unplaced``."""

        return sum(
            token.top_weight
            - max(
                (
                    weight
                    for parent, weight in token.weights
                    if not unplaced & (1 << positions[parent])
                ),
                default=0,
            )
            for token in owned[vertex]
        )

    @cache
    def block_cost(unplaced: int, length: int) -> int:
        if length == 0:
            return 0
        if not 1 <= length <= unplaced.bit_count():
            raise ValueError("invalid block length")
        return min(
            deficit(vertex, unplaced)
            + block_cost(unplaced ^ (1 << positions[vertex]), length - 1)
            for vertex in vertices
            if unplaced & (1 << positions[vertex])
        )

    by_cardinality = {
        size: tuple(
            subset
            for subset in range(full + 1)
            if subset.bit_count() == size
        )
        for size in range(1, len(vertices) + 1)
    }
    cardinal = tuple(
        max(block_cost(subset, 1) for subset in by_cardinality[size])
        for size in range(1, len(vertices) + 1)
    )

    # Check the chain inequality on every subset, not only on the displayed
    # stresses: g_k(Q) is no larger than the sum of the successive worst
    # one-step deficits for cardinalities |Q|,...,|Q|-k+1.
    for subset in range(1, full + 1):
        size = subset.bit_count()
        for length in range(1, size + 1):
            separate = sum(cardinal[size - offset - 1] for offset in range(length))
            if block_cost(subset, length) > separate:
                raise AssertionError("block cost exceeds cardinal peeling bound")

    block_bounds: list[int] = []
    all_components: list[tuple[int, ...]] = []
    for block_size in (1, 2, 3):
        components: list[int] = []
        size = len(vertices)
        while size:
            length = min(block_size, size)
            components.append(
                max(
                    block_cost(subset, length)
                    for subset in by_cardinality[size]
                )
            )
            size -= length
        all_components.append(tuple(components))
        block_bounds.append(sum(components))

    optimum = block_cost(full, len(vertices))
    if block_bounds[1] > block_bounds[0] or block_bounds[2] > block_bounds[0]:
        raise AssertionError("block grouping worsened the one-step bound")
    if optimum > min(block_bounds):
        raise AssertionError("a certified bound fell below the exact optimum")
    return ChainAudit(
        name=name,
        speeds=speeds,
        pivot=pivot,
        block_bounds=tuple(block_bounds),
        optimum=optimum,
        cardinal_bound=cardinal,
        block_components=tuple(all_components),
    )


def audit_all_cases() -> tuple[ChainAudit, ...]:
    reports = tuple(audit_case(name, speeds, pivot) for name, speeds, pivot, _ in CASES)
    for report, (*_prefix, expected) in zip(reports, CASES, strict=True):
        observed = (*report.block_bounds, report.optimum)
        if observed != expected:
            raise AssertionError(f"{report.name}: {observed} != {expected}")
    return reports


def main() -> None:
    for report in audit_all_cases():
        print(
            f"{report.name}: B={report.block_bounds}, optimum={report.optimum}, "
            f"components={report.block_components}"
        )


if __name__ == "__main__":
    main()
