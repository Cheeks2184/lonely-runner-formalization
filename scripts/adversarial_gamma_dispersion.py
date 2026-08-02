#!/usr/bin/env python3
"""Independent adversarial checks of the anchor-star dispersion inequality.

This file deliberately does not import the implementation under audit.  It
checks the abstract finite-partition argument and reconstructs the modular
sets directly from their definitions.
"""

from __future__ import annotations

import argparse
import itertools
import random
from math import gcd


def _credit(
    bad: tuple[frozenset[int], ...],
    colors: tuple[tuple[int, ...], ...],
    child: int,
    anchors: tuple[int, ...],
    distinguished: int,
) -> int:
    """Corrected credit using joint child/distinguished color cells."""

    cells: dict[tuple[int, int], set[int]] = {}
    for x in bad[child]:
        key = (colors[child][x], colors[distinguished][x])
        cells.setdefault(key, set()).add(x)
    total = 0
    for cell in cells.values():
        if cell <= bad[distinguished]:
            total += len(cell)
        else:
            # A color class is required to be wholly bad or wholly nonbad.
            assert cell.isdisjoint(bad[distinguished])
            total += max(
                (len(cell & bad[a]) for a in anchors if a != distinguished),
                default=0,
            )
    return total


def _l2(
    bad: tuple[frozenset[int], ...],
    colors: tuple[tuple[int, ...], ...],
    child: int,
    anchors: tuple[int, ...],
) -> int:
    return max(_credit(bad, colors, child, anchors, a) for a in anchors)


def _u(
    bad: tuple[frozenset[int], ...],
    colors: tuple[tuple[int, ...], ...],
    anchors: tuple[int, ...],
) -> int:
    union = frozenset().union(*(bad[a] for a in anchors))
    return len(union) + sum(
        len(bad[i]) - _l2(bad, colors, i, anchors)
        for i in range(len(bad))
        if i not in anchors
    )


def check_model(
    bad: tuple[frozenset[int], ...], colors: tuple[tuple[int, ...], ...]
) -> None:
    """Check the undivided integer inequality for every first anchor."""

    m = len(bad)
    assert m >= 3
    for h in range(m):
        gamma_numerator = 0
        for q in range(m):
            if q == h:
                continue
            for r in range(m):
                if r in (h, q):
                    continue
                gamma_numerator += _u(bad, colors, (h, q)) - _u(
                    bad, colors, (h, q, r)
                )

        delta_numerator = 0
        for child in range(m):
            if child == h:
                continue
            comparison = tuple(i for i in range(m) if i not in (h, child))
            cells: dict[tuple[int, int], set[int]] = {}
            for x in bad[child]:
                key = (colors[child][x], colors[h][x])
                cells.setdefault(key, set()).add(x)
            for cell in cells.values():
                if not cell.isdisjoint(bad[h]):
                    assert cell <= bad[h]
                    continue
                counts = [len(cell & bad[q]) for q in comparison]
                delta_numerator += sum(
                    abs(a - b) for a, b in itertools.combinations(counts, 2)
                )
        if gamma_numerator < delta_numerator:
            raise AssertionError(
                (bad, colors, h, gamma_numerator, delta_numerator)
            )


def exhaustive_binary_models(universe_size: int, runners: int) -> int:
    """Exhaust all set systems, using membership itself as the color map."""

    universe = range(universe_size)
    checked = 0
    for masks in itertools.product(range(1 << universe_size), repeat=runners):
        bad = tuple(
            frozenset(x for x in universe if mask >> x & 1) for mask in masks
        )
        colors = tuple(
            tuple(int(x in bad[i]) for x in universe) for i in range(runners)
        )
        check_model(bad, colors)
        checked += 1
    return checked


def random_colored_models(
    universe_size: int, runners: int, trials: int, seed: int
) -> int:
    """Test refined partitions whose color classes have arbitrary sizes."""

    rng = random.Random(seed)
    for _ in range(trials):
        raw_colors = tuple(
            tuple(rng.randrange(4) for _x in range(universe_size))
            for _i in range(runners)
        )
        bad_color = tuple(
            frozenset(c for c in range(4) if rng.randrange(2))
            for _i in range(runners)
        )
        bad = tuple(
            frozenset(
                x for x, color in enumerate(raw_colors[i]) if color in bad_color[i]
            )
            for i in range(runners)
        )
        check_model(bad, raw_colors)
    return trials


def modular_model(speeds: tuple[int, ...], pivot: int):
    """Reconstruct candidate masks, images, and strict bad sets directly."""

    n_factor = len(speeds) + 1
    modulus = n_factor * speeds[pivot]
    universe = tuple(r for r in range(modulus) if r % n_factor != 0)
    others = tuple(i for i in range(len(speeds)) if i != pivot)
    colors = tuple(tuple(speeds[i] * r % modulus for r in universe) for i in others)
    # Relabel the candidate residues densely; colors retain modular images.
    bad = tuple(
        frozenset(
            x
            for x, image in enumerate(colors[i])
            if image < speeds[pivot] or image > modulus - speeds[pivot]
        )
        for i in range(len(others))
    )
    return bad, colors


def exhaustive_modular(runners: int, max_speed: int) -> tuple[int, int]:
    tuples = pairs = 0
    for speeds in itertools.combinations(range(1, max_speed + 1), runners):
        if gcd(*speeds) != 1:
            continue
        tuples += 1
        for pivot in range(runners):
            check_model(*modular_model(speeds, pivot))
            pairs += runners - 1
    return tuples, pairs


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--quick", action="store_true")
    args = parser.parse_args()
    binary = exhaustive_binary_models(3 if args.quick else 4, 4)
    random_count = random_colored_models(8, 5, 2_000 if args.quick else 20_000, 9173)
    modular = exhaustive_modular(5, 9 if args.quick else 12)
    print({"binary_models": binary, "random_colored": random_count, "modular": modular})


if __name__ == "__main__":
    main()
