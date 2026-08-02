#!/usr/bin/env python3
"""Exact three-item integrality gap for the clause/triangle LP relaxation.

Each item has one clause qualified by either of the other two items.  Every
integral order leaves exactly the first item's clause unsatisfied.  The
fractional pair assignment ``y[i,j] = 1/2`` and clause assignment ``z[i] = 1``
satisfy all pair, directed-triangle, and clause constraints, yielding cost
zero.
"""

from __future__ import annotations

import itertools
from fractions import Fraction


ITEMS = (0, 1, 2)


def integral_clause_cost(order: tuple[int, ...]) -> int:
    position = {item: index for index, item in enumerate(order)}
    return sum(
        not any(position[parent] < position[child] for parent in ITEMS if parent != child)
        for child in ITEMS
    )


def integral_costs() -> tuple[int, ...]:
    return tuple(integral_clause_cost(order) for order in itertools.permutations(ITEMS))


def verify_fractional_zero_cost() -> Fraction:
    y = {
        (first, second): Fraction(1, 2)
        for first in ITEMS
        for second in ITEMS
        if first != second
    }
    z = {child: Fraction(1) for child in ITEMS}

    for first, second in itertools.combinations(ITEMS, 2):
        if y[(first, second)] + y[(second, first)] != 1:
            raise AssertionError("pair-order equation failed")
    for first, second, third in itertools.permutations(ITEMS, 3):
        cycle_sum = y[(first, second)] + y[(second, third)] + y[(third, first)]
        if not Fraction(1) <= cycle_sum <= Fraction(2):
            raise AssertionError("directed triangle inequality failed")
    for child in ITEMS:
        qualifying_sum = sum(
            (y[(parent, child)] for parent in ITEMS if parent != child),
            start=Fraction(0),
        )
        if not Fraction(0) <= z[child] <= 1 or z[child] > qualifying_sum:
            raise AssertionError("relaxed clause constraint failed")
    return Fraction(len(ITEMS)) - sum(z.values(), start=Fraction(0))


def main() -> None:
    costs = integral_costs()
    lp_cost = verify_fractional_zero_cost()
    print(f"integral_costs={costs} integral_optimum={min(costs)} lp_cost={lp_cost}")


if __name__ == "__main__":
    main()
