#!/usr/bin/env python3
"""Exact finite LP audit for zero-indicator bounds from binomial moments.

The data in this file come only from literal pivot grids of explicit integer
speed tuples.  The generic LP routines also accept abstract histograms, but
no abstract histogram is reported as an arithmetically realizable example.
"""

from __future__ import annotations

from fractions import Fraction
from itertools import combinations
from math import comb


G = (15, 21, 40, 48, 56, 105, 126, 280, 1200)
T10 = (1, 2, 3, 4, 5, 6, 7, 8, 9, 11)
T11 = (1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12)


def circular_residue(value: int, modulus: int) -> int:
    residue = value % modulus
    return min(residue, modulus - residue)


def individual_pivot_histograms(speeds: tuple[int, ...]) -> tuple[tuple[int, ...], ...]:
    """Return one literal bad-count histogram for each pivot grid."""

    n = len(speeds)
    if n < 2 or len(set(speeds)) != n or any(speed <= 0 for speed in speeds):
        raise ValueError("speeds must be distinct positive integers")
    N = n + 1
    result = []
    for pivot in speeds:
        histogram = [0] * n
        modulus = N * pivot
        for residue in range(modulus):
            if residue % N == 0:
                continue
            bad_count = sum(
                circular_residue(speed * residue, modulus) < pivot
                for speed in speeds
            )
            # The pivot runner is never bad on the candidate grid.
            if not 0 <= bad_count <= n - 1:
                raise AssertionError("candidate bad count escaped 0..n-1")
            histogram[bad_count] += 1
        if sum(histogram) != n * pivot:
            raise AssertionError("individual pivot-grid mass identity failed")
        result.append(tuple(histogram))
    return tuple(result)


def pivot_histogram(speeds: tuple[int, ...]) -> tuple[int, ...]:
    """Return the aggregate weighted bad-count histogram on all pivot grids."""

    pivot_rows = individual_pivot_histograms(speeds)
    histogram = tuple(sum(row[k] for row in pivot_rows) for k in range(len(speeds)))
    if sum(histogram) != len(speeds) * sum(speeds):
        raise AssertionError("pivot-grid mass identity failed")
    return histogram


def binomial_moments(histogram: tuple[int, ...], order: int) -> tuple[int, ...]:
    if not 0 <= order < len(histogram):
        raise ValueError("order must lie in 0..m")
    return tuple(
        sum(mass * comb(k, q) for k, mass in enumerate(histogram))
        for q in range(order + 1)
    )


def root_polynomial_values(m: int, roots: tuple[int, ...]) -> tuple[Fraction, ...]:
    """Values of the normalized polynomial with P(0)=1 and these roots."""

    if tuple(sorted(set(roots))) != roots or any(not 1 <= root <= m for root in roots):
        raise ValueError("roots must be distinct increasing points in 1..m")
    return tuple(
        product(Fraction(root - k, root) for root in roots)
        for k in range(m + 1)
    )


def product(values):
    result = Fraction(1)
    for value in values:
        result *= value
    return result


def binomial_coefficients(values: tuple[Fraction, ...]) -> tuple[Fraction, ...]:
    """Convert P(0),...,P(r) to Newton/binomial-basis coefficients."""

    row = list(values)
    coefficients = []
    while row:
        coefficients.append(row[0])
        row = [right - left for left, right in zip(row, row[1:])]
    return tuple(coefficients)


def solve_square(matrix: list[list[Fraction]], rhs: list[Fraction]) -> tuple[Fraction, ...]:
    """Solve a nonsingular square rational system by Gauss-Jordan elimination."""

    size = len(rhs)
    augmented = [list(row) + [value] for row, value in zip(matrix, rhs)]
    if len(augmented) != size or any(len(row) != size + 1 for row in augmented):
        raise ValueError("system must be square")
    for column in range(size):
        pivot = next((row for row in range(column, size) if augmented[row][column]), None)
        if pivot is None:
            raise ValueError("singular system")
        augmented[column], augmented[pivot] = augmented[pivot], augmented[column]
        scale = augmented[column][column]
        augmented[column] = [value / scale for value in augmented[column]]
        for row in range(size):
            if row == column:
                continue
            scale = augmented[row][column]
            if scale:
                augmented[row] = [
                    value - scale * pivot_value
                    for value, pivot_value in zip(augmented[row], augmented[column])
                ]
    return tuple(row[-1] for row in augmented)


def complementary_dual_certificate(
    histogram: tuple[int, ...], order: int, roots: tuple[int, ...]
) -> tuple[Fraction, ...]:
    """Return dual masses on support ``(0,)+roots`` for a positive optimum."""

    support = (0,) + roots
    moments = binomial_moments(histogram, order)
    # Rows are moment constraints q; columns are support points k.
    matrix = [
        [Fraction(comb(k, q)) for k in support]
        for q in range(order + 1)
    ]
    masses = solve_square(matrix, [Fraction(moment) for moment in moments])
    if any(mass < 0 for mass in masses):
        raise AssertionError("claimed optimal root set has a negative dual mass")
    for q, moment in enumerate(moments):
        if sum(mass * comb(k, q) for mass, k in zip(masses, support)) != moment:
            raise AssertionError("dual moment matching failed")
    return masses


def classified_root_sets(m: int, order: int) -> tuple[tuple[int, ...], ...]:
    """List all nonzero feasible vertex root sets for degree ``order``.

    A feasible vertex has P(0)=1 and exactly ``order`` positive grid roots.
    Its roots start at 1; every interval on which its sign would be positive
    has consecutive endpoints; and an even-degree polynomial ends at m.
    """

    if not 1 <= order <= m:
        raise ValueError("order must lie in 1..m")
    result = []
    for roots in combinations(range(1, m + 1), order):
        if roots[0] != 1:
            continue
        if order % 2 == 0 and roots[-1] != m:
            continue
        # After roots 2,4,... (one-based), the sign is positive until the
        # next root.  Those root pairs therefore must be consecutive.
        if any(roots[index + 1] != roots[index] + 1 for index in range(1, order - 1, 2)):
            continue
        values = root_polynomial_values(m, roots)
        if any(value > 0 for value in values[1:]):
            raise AssertionError("classified root set was not feasible")
        result.append(roots)
    return tuple(result)


def brute_feasible_root_sets(m: int, order: int) -> tuple[tuple[int, ...], ...]:
    """Independent small-size check of the root classification."""

    return tuple(
        roots
        for roots in combinations(range(1, m + 1), order)
        if all(value <= 0 for value in root_polynomial_values(m, roots)[1:])
    )


def optimal_moment_bound(
    histogram: tuple[int, ...], order: int
) -> tuple[Fraction, tuple[int, ...] | None, tuple[Fraction, ...]]:
    """Solve the finite primal LP exactly by enumerating all its vertices.

    ``None`` denotes the zero-polynomial candidate (a vertex when order<m).
    The returned coefficients are in the basis C(k,q), q=0,...,order.
    """

    m = len(histogram) - 1
    if not 1 <= order <= m:
        raise ValueError("order must lie in 1..m")
    best_score = Fraction(0)
    best_roots = None
    best_coefficients = (Fraction(0),) * (order + 1)
    for roots in classified_root_sets(m, order):
        values = root_polynomial_values(m, roots)
        score = sum(Fraction(mass) * value for mass, value in zip(histogram, values))
        if score > best_score:
            best_score = score
            best_roots = roots
            best_coefficients = binomial_coefficients(values[: order + 1])
    moments = binomial_moments(histogram, order)
    if sum(coefficient * moment for coefficient, moment in zip(best_coefficients, moments)) != best_score:
        raise AssertionError("moment and histogram objectives disagree")
    if best_roots is not None:
        dual = complementary_dual_certificate(histogram, order, best_roots)
        if dual[0] != best_score:
            raise AssertionError("primal and complementary dual objectives disagree")
    return best_score, best_roots, best_coefficients


def response39_bound(histogram: tuple[int, ...], depth: int) -> Fraction:
    """Evaluate the fixed even-degree Response 39 polynomial."""

    m = len(histogram) - 1
    order = 2 * depth
    if not 1 <= order <= m:
        raise ValueError("depth is outside the non-tautological range")
    moments = binomial_moments(histogram, order)
    coefficients = tuple(
        Fraction((-1) ** q) if q < order else Fraction(order, m)
        for q in range(order + 1)
    )
    return sum(coefficient * moment for coefficient, moment in zip(coefficients, moments))


def audit_root_classification() -> None:
    for m in range(1, 11):
        for order in range(1, m + 1):
            if classified_root_sets(m, order) != brute_feasible_root_sets(m, order):
                raise AssertionError(f"root classification failed at m={m}, r={order}")


def realizable_rows() -> dict[str, tuple[int, ...]]:
    rows = {
        "G": G,
        "T10": T10,
        "T11": T11,
        "A7": tuple(range(1, 8)),
        "A10": tuple(range(1, 11)),
        "A11": tuple(range(1, 12)),
        "A20": tuple(range(1, 21)),
        "powers2-9": tuple(2**index for index in range(9)),
    }
    return {name: pivot_histogram(speeds) for name, speeds in rows.items()}


def bounded_structured_scan(max_n: int = 35, max_order: int = 6):
    """Exact bounded scan of two explicit, arithmetically realizable families."""

    if max_n < 4 or max_order < 1:
        raise ValueError("scan bounds are too small")
    result = {}
    for family in ("consecutive", "powers2"):
        family_rows = []
        family_max_n = max_n if family == "consecutive" else min(max_n, 13)
        for n in range(4, family_max_n + 1):
            speeds = (
                tuple(range(1, n + 1))
                if family == "consecutive"
                else tuple(2**index for index in range(n))
            )
            histogram = pivot_histogram(speeds)
            first_positive = None
            for order in range(1, min(max_order, n - 1) + 1):
                score, roots, _ = optimal_moment_bound(histogram, order)
                if score > 0:
                    first_positive = (order, score, roots)
                    break
            family_rows.append((n, histogram[0], first_positive))
        result[family] = tuple(family_rows)
    return result


def audit_all() -> dict[str, tuple[int, ...]]:
    audit_root_classification()
    rows = realizable_rows()
    if rows["G"][:9] != (2272, 6134, 5610, 2208, 584, 180, 7, 16, 8):
        raise AssertionError("G literal pivot histogram changed")
    g_pivots = individual_pivot_histograms(G)
    if tuple(row[0] for row in g_pivots) != (0, 10, 0, 16, 48, 142, 156, 382, 1518):
        raise AssertionError("G individual safe-pivot counts changed")
    # The fixed Response 39 polynomial is one feasible LP vertex.  Exact
    # optimization therefore can never do worse.
    for histogram in rows.values():
        m = len(histogram) - 1
        for depth in range(1, (m // 2) + 1):
            optimum, _, _ = optimal_moment_bound(histogram, 2 * depth)
            if optimum < response39_bound(histogram, depth):
                raise AssertionError("optimized LP fell below its feasible fixed vertex")
    return rows


def main() -> None:
    rows = audit_all()
    for name, histogram in rows.items():
        print(name, "D0", histogram[0], "mass", sum(histogram))
        for order in range(1, min(6, len(histogram) - 1) + 1):
            score, roots, coefficients = optimal_moment_bound(histogram, order)
            print(" ", order, score, roots, coefficients)
    print("G individual pivots, first positive order <= 6")
    for pivot, histogram in zip(G, individual_pivot_histograms(G)):
        first_positive = None
        for order in range(1, 7):
            score, roots, _ = optimal_moment_bound(histogram, order)
            if score > 0:
                first_positive = (order, score, roots)
                break
        print(" ", pivot, histogram[0], first_positive)
    print("bounded structured scan")
    for family, family_rows in bounded_structured_scan().items():
        print(family)
        for row in family_rows:
            print(" ", row)


if __name__ == "__main__":
    main()
