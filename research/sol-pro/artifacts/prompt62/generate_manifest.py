#!/usr/bin/env python3
"""Generate the deterministic PRO-B Prompt 62 exact-sweep manifest."""
from __future__ import annotations

from itertools import combinations
from math import gcd
from pathlib import Path

VERSION = "PROB-62-v1.0.0"
OUT = Path(__file__).with_name("pro_b_manifest.txt")

STRESSES = (
    ("RF", (2, 3, 7, 9, 10, 12, 15, 16, 19)),
    ("GCD_CLOCK_1", (8, 15, 35, 40, 48, 56, 63, 75, 78)),
    ("GCD_CLOCK_2", (6, 8, 15, 21, 28, 35, 40, 48, 75)),
    ("HARD_A", (1, 2, 5, 7, 9, 11, 12, 13)),
    ("HARD_B", (1, 5, 7, 8, 9, 11, 13, 15)),
    ("SMALL", (1, 2, 3, 5)),
    ("STRESS_C", (8, 15, 35, 40, 48, 56, 68, 75, 78)),
    ("STRESS_D", (10, 37, 45, 51, 54, 56, 61, 71, 91)),
    ("STRESS_E", (5, 28, 35, 40, 68, 88, 108, 148, 165)),
    ("CHAIN3", (8, 15, 35, 40, 48, 56, 75, 132, 147)),
    ("OPT_ADD", (15, 21, 40, 48, 56, 105, 126, 280, 1200)),
    ("AFFINE_HARD_7_98_187", (7, 63, 70, 77, 98, 187)),
)

BOX_BOUNDS = ((2, 30), (3, 24), (4, 18), (5, 14), (6, 12))


def primitive(xs: tuple[int, ...]) -> tuple[int, ...]:
    g = 0
    for x in xs:
        g = gcd(g, x)
    assert g > 0
    return tuple(sorted(x // g for x in xs))


def valid(xs: tuple[int, ...], min_n: int = 2) -> bool:
    return len(xs) >= min_n and all(x > 0 for x in xs) and len(set(xs)) == len(xs)


def add_unique(rows: list[tuple[str, str, tuple[int, ...]]], seen: set[tuple[str, tuple[int, ...]]],
               category: str, name: str, xs: tuple[int, ...]) -> None:
    if not valid(xs):
        return
    xs = primitive(xs)
    key = (category, xs)
    if key in seen:
        return
    seen.add(key)
    rows.append((category, name, xs))


def main() -> None:
    rows: list[tuple[str, str, tuple[int, ...]]] = []
    seen: set[tuple[str, tuple[int, ...]]] = set()

    # Fixed recovered stress tuples, in declared order.
    for name, xs in STRESSES:
        add_unique(rows, seen, "stress", name, xs)

    # Primitive lexicographic boxes. combinations() is lexicographic.
    for n, height in BOX_BOUNDS:
        idx = 0
        for xs in combinations(range(1, height + 1), n):
            if gcd(*xs) != 1:
                continue
            idx += 1
            add_unique(rows, seen, f"box_n{n}_H{height}", f"b{idx:06d}", xs)

    # Consecutive families, including dimensions beyond the box sweep.
    for n in range(2, 31):
        xs = tuple(range(1, n + 1))
        add_unique(rows, seen, "consecutive", f"n{n:02d}", xs)

    # Structured CRT mutations: shift each non-top coordinate by +/- N.
    for base_name, base in STRESSES[:10]:
        n = len(base)
        N = n + 1
        for i in range(max(0, n - 2)):
            for sign, tag in ((-1, "m"), (1, "p")):
                ys = list(base)
                ys[i] += sign * N
                add_unique(rows, seen, "structured_crt",
                           f"{base_name}_{tag}N_i{i}", tuple(ys))

    # Affine-fiber mutations around the exact N=7, A=98, B=187 row.
    affine_base = (7, 63, 70, 77, 98, 187)
    N = 7
    for i in range(4):
        for step, tag in ((-2, "m2"), (-1, "m1"), (1, "p1"), (2, "p2")):
            ys = list(affine_base)
            ys[i] += step * N
            add_unique(rows, seen, "affine_fiber", f"c{i}_{tag}N", tuple(ys))

    # Large-gap boundary mutations around B = n*A and B = N*A/2.
    for N in range(5, 13):
        n = N - 1
        lower = tuple(range(1, max(1, n - 1)))  # n-2 lower values: 1,...,n-2
        A = N + 2
        candidates = (
            (N * A) // 2 - 1,
            (N * A) // 2,
            (N * A) // 2 + 1,
            n * A - 1,
            n * A,
            n * A + 1,
        )
        for k, B in enumerate(candidates):
            xs = lower + (A, B)
            add_unique(rows, seen, "large_gap", f"N{N}_k{k}", xs)

    # Saturated lower intervals {1,...,N-2} plus B.
    for N in range(4, 13):
        A = N - 2
        lower = tuple(range(1, A + 1))
        Bs = (N - 1, N, 2 * N - 1, 2 * N, N * A, 2 * N * A)
        for k, B in enumerate(Bs):
            add_unique(rows, seen, "saturated", f"N{N}_k{k}", lower + (B,))

    # Deletion mutations of the recovered RF and CHAIN3 stress tuples.
    for base_name, base in (STRESSES[0], STRESSES[9]):
        for i in range(len(base)):
            ys = base[:i] + base[i + 1:]
            add_unique(rows, seen, "deletion", f"{base_name}_del{i}", ys)

    # Sort only within the generated global order already specified; assign IDs.
    with OUT.open("w", encoding="utf-8", newline="\n") as f:
        f.write(f"# version={VERSION}\n")
        f.write("# fields=id|category|name|speeds\n")
        for idx, (category, name, xs) in enumerate(rows, start=1):
            f.write(f"{idx:06d}|{category}|{name}|{','.join(map(str, xs))}\n")

    from collections import Counter
    counts = Counter(category for category, _, _ in rows)
    print(f"version={VERSION}")
    print(f"rows={len(rows)}")
    for key in sorted(counts):
        print(f"category[{key}]={counts[key]}")
    print(f"manifest={OUT}")


if __name__ == "__main__":
    main()
