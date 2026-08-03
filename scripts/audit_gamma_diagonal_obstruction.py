#!/usr/bin/env python3
"""Reproduce the first nonempty-row obstruction to variable-total diagonal Hall."""

from itertools import combinations
from math import gcd


def omega(n: int) -> int:
    """Number of distinct prime factors of a positive integer."""
    x, p, count = n, 2, 0
    while p * p <= x:
        if x % p == 0:
            count += 1
            while x % p == 0:
                x //= p
        p += 1
    return count + int(x > 1)


def candidates(N: int, t: int) -> tuple[int, ...]:
    """Actual generic candidates after automatic and reciprocal repairs."""
    H = N + t
    a = 3 * (N - t) // 4 + 1
    b = H // 2
    result = []
    for c in range(max(1, a), b + 1):
        if max(0, N - c - t) >= 1 << omega(c):
            continue
        if any(gcd(c, d) == 1 for d in range(H + 1, 2 * N - c + 1)):
            continue
        result.append(c)
    return tuple(result)


def gamma(N: int, t: int, c: int) -> tuple[int, ...]:
    """Exact strict-lower/closed-upper Gamma neighborhood."""
    H = N + t
    lower = max(N + 1, H - c + 1)
    upper = min(H, 2 * N - c)
    return tuple(d for d in range(lower, upper + 1) if gcd(c, d) == 1)


def feasible_starts(N: int, t: int) -> tuple[int, ...]:
    q = t // 4
    ell = 2 * q
    a = 3 * (N - t) // 4 + 1
    b = (N + t) // 2
    lower = max(t - ell, b + 1 - 2 * ell)
    upper = min(a, N + 1 - 3 * ell)
    if 2 * ell > t or lower > upper:
        return ()
    return tuple(range(lower, upper + 1))


def diagonal_neighbors(
    N: int, t: int, c: int, starts: tuple[int, ...]
) -> tuple[int, ...]:
    """Reversal edges d = Q_s-c, retained exactly when gcd(c,Q_s)=1."""
    ell = 2 * (t // 4)
    return tuple(
        N + s + 2 * ell - c
        for s in starts
        if gcd(c, N + s + 2 * ell) == 1
    )


def maximum_matching(
    left: tuple[int, ...], graph: dict[int, tuple[int, ...]]
) -> dict[int, int]:
    """Return a right-to-left maximum matching via exact augmentation."""
    owner: dict[int, int] = {}

    def augment(c: int, seen: set[int]) -> bool:
        for d in graph[c]:
            if d in seen:
                continue
            seen.add(d)
            if d not in owner or augment(owner[d], seen):
                owner[d] = c
                return True
        return False

    for c in left:
        augment(c, set())
    return owner


def is_saturable(left: tuple[int, ...], graph: dict[int, tuple[int, ...]]) -> bool:
    return len(maximum_matching(left, graph)) == len(left)


def deficient_subset(
    left: tuple[int, ...], graph: dict[int, tuple[int, ...]]
) -> tuple[tuple[int, ...], tuple[int, ...]] | None:
    """Exhaustively return the first Hall-deficient subset in size/lex order."""
    for size in range(1, len(left) + 1):
        for subset in combinations(left, size):
            neighbors = set().union(*(set(graph[c]) for c in subset))
            if len(neighbors) < len(subset):
                return subset, tuple(sorted(neighbors))
    return None


def first_nonempty_row_failure() -> tuple[int, int]:
    """Exhaust the lexicographic domain preceding the claimed obstruction."""
    for N in range(32, 37):
        for t in range(16, N // 2 + 1):
            if N >= 3 * t:
                continue
            starts = feasible_starts(N, t)
            left = candidates(N, t)
            if not starts or not left:
                continue
            graph = {c: diagonal_neighbors(N, t, c, starts) for c in left}
            if all(graph[c] for c in left) and not is_saturable(left, graph):
                return N, t
    raise AssertionError("expected obstruction not found")


def main() -> None:
    N, t = 36, 16
    left = candidates(N, t)
    starts = feasible_starts(N, t)
    ell = 2 * (t // 4)
    totals = tuple(N + s + 2 * ell for s in starts)
    diagonal = {c: diagonal_neighbors(N, t, c, starts) for c in left}

    assert left == (20, 21, 22, 23, 24, 25, 26)
    assert starts == (11, 12, 13)
    assert totals == (63, 64, 65)
    assert diagonal == {
        20: (43,),
        21: (43, 44),
        22: (41, 43),
        23: (40, 41, 42),
        24: (41,),
        25: (38, 39),
        26: (37,),
    }
    witness = deficient_subset(left, diagonal)
    assert witness == ((20, 22, 24), (41, 43))
    assert all(diagonal[c] for c in left)
    assert first_nonempty_row_failure() == (36, 16)

    full_gamma = {c: gamma(N, t, c) for c in left}
    explicit_sdr = {20: 41, 21: 40, 22: 45, 23: 39, 24: 43, 25: 38, 26: 37}
    assert len(set(explicit_sdr.values())) == len(left)
    assert all(explicit_sdr[c] in full_gamma[c] for c in left)
    assert is_saturable(left, full_gamma)

    print("N=36 t=16 H=52 ell=8")
    print(f"candidates={left}")
    print(f"feasible_starts={starts}")
    print(f"reversal_totals={totals}")
    print(f"diagonal_neighbors={diagonal}")
    print("deficient_subset=(20,22,24)")
    print("deficient_neighborhood=(41,43)")
    print("all_diagonal_rows_nonempty=True")
    print("first_lex_nonempty_row_failure=(36,16)")
    print(f"full_gamma_explicit_sdr={explicit_sdr}")
    print("DIAGONAL_HALL_REFUTED=True")
    print("FULL_GAMMA_HALL_GOOD=True")


if __name__ == "__main__":
    main()
