"""Independent exact checks for the mathematical claims in Sol response 41.

The script deliberately distinguishes certificate scores from Lonely Runner
witnesses.  In particular, the consecutive Chebyshev calculation below uses
the already-known exact histogram; it is not presented as a noncircular proof
of that family's safe residues.
"""

from __future__ import annotations

from fractions import Fraction
from math import ceil, gcd, log, sqrt


def rho(modulus: int, value: int) -> int:
    residue = value % modulus
    return min(residue, modulus - residue)


def euler_phi(value: int) -> int:
    result = value
    remaining = value
    prime = 2
    while prime * prime <= remaining:
        if remaining % prime == 0:
            while remaining % prime == 0:
                remaining //= prime
            result -= result // prime
        prime += 1
    if remaining > 1:
        result -= result // remaining
    return result


def consecutive_histogram(n: int) -> list[int]:
    """Global pivot-candidate bad-count histogram for speeds 1,...,n."""
    N = n + 1
    histogram = [0] * n
    for pivot in range(1, n + 1):
        modulus = N * pivot
        for candidate in range(modulus):
            if candidate % N == 0:
                continue
            bad_count = sum(
                speed != pivot and rho(modulus, speed * candidate) < pivot
                for speed in range(1, n + 1)
            )
            histogram[bad_count] += 1
    return histogram


def chebyshev_T(degree: int, value: Fraction) -> Fraction:
    if degree == 0:
        return Fraction(1)
    previous, current = Fraction(1), value
    for _ in range(2, degree + 1):
        previous, current = current, 2 * value * current - previous
    return current


def chebyshev_degree(n: int) -> int:
    assert n >= 3
    return ceil(sqrt(n - 1) * log(4 * n * (n + 1)) / 2)


def chebyshev_score(n: int, degree: int, histogram: list[int]) -> Fraction:
    """Evaluate the feasible polynomial exactly on an supplied histogram."""
    assert n >= 3 and degree >= 1 and len(histogram) == n
    m = n - 1
    x0 = Fraction(m + 1, m - 1)
    denominator = chebyshev_T(degree, x0)
    epsilon = 1 / denominator
    assert 0 < epsilon < 1

    score = Fraction(0)
    for k, multiplicity in enumerate(histogram):
        xk = Fraction(m + 1 - 2 * k, m - 1)
        qk = chebyshev_T(degree, xk) / denominator
        pk = (qk - epsilon) / (1 - epsilon)
        if k == 0:
            assert pk == 1
        else:
            assert -2 * epsilon / (1 - epsilon) <= pk <= 0
        score += multiplicity * pk
    return score


def small_denominator_witness(speeds: tuple[int, ...], q: int) -> bool:
    """Check the exact integer inequality underlying t=1/q."""
    N = len(speeds) + 1
    assert 2 <= q <= N
    assert all(speed % q != 0 for speed in speeds)
    return all(N * rho(q, speed) >= q for speed in speeds)


def bad_vector(
    speeds: tuple[int, ...], pivot: int, candidate: int
) -> tuple[bool, ...]:
    N = len(speeds) + 1
    modulus = N * pivot
    return tuple(rho(modulus, speed * candidate) < pivot for speed in speeds)


def cross_pivot_scaling_holds(
    speeds: tuple[int, ...], lower: int, quotient: int
) -> bool:
    """Check every candidate in the image of r |-> quotient*r."""
    N = len(speeds) + 1
    upper = quotient * lower
    assert lower in speeds and upper in speeds and gcd(quotient, N) == 1
    lower_modulus = N * lower
    for candidate in range(lower_modulus):
        if candidate % N == 0:
            continue
        image = quotient * candidate
        if image >= N * upper or image % N == 0:
            return False
        if bad_vector(speeds, lower, candidate) != bad_vector(speeds, upper, image):
            return False
    return True


def brute_largest_signed_descents(
    speeds: tuple[int, ...],
) -> set[tuple[int, int]]:
    ordered = tuple(sorted(speeds))
    n = len(ordered)
    N = n + 1
    top = ordered[-1]
    if not top < n * ordered[-2]:
        return set()
    descents: set[tuple[int, int]] = set()
    for b in range(1, top):
        if top % b != 0 or gcd(top // b, N) != 1:
            continue
        if all((top - b) % (N * a) == 0 or (top + b) % (N * a) == 0 for a in ordered[:-1]):
            descents.add((top // b, b))
    return descents


def characterized_largest_signed_descents(
    speeds: tuple[int, ...],
) -> set[tuple[int, int]]:
    ordered = tuple(sorted(speeds))
    n = len(ordered)
    N = n + 1
    top, second = ordered[-1], ordered[-2]
    if not top < n * second:
        return set()
    descents: set[tuple[int, int]] = set()
    for quotient in range(2, N - 1):
        if gcd(quotient, N) != 1 or (N * second) % (quotient + 1) != 0:
            continue
        b = N * second // (quotient + 1)
        if top != quotient * b:
            continue
        if all(
            second % a == 0 or ((quotient - 1) * b) % (N * a) == 0
            for a in ordered[:-2]
        ):
            descents.add((quotient, b))
    return descents


def audit() -> dict[str, object]:
    rows: list[tuple[int, int, Fraction]] = []
    for n in (59, 84):
        histogram = consecutive_histogram(n)
        assert histogram[0] == n * euler_phi(n + 1)
        assert sum(histogram) == n * n * (n + 1) // 2
        degree = chebyshev_degree(n)
        score = chebyshev_score(n, degree, histogram)
        assert score > 0
        rows.append((n, degree, score))

    assert small_denominator_witness((1, 5, 7, 11), 2)
    cover = (2, 3, 4, 5)
    assert all(any(a % q == 0 for a in cover) for q in range(2, 6))
    assert cross_pivot_scaling_holds((2, 3, 4, 6), 2, 3)

    descent = (1, 2, 6, 20)
    stress = (15, 21, 40, 48, 56, 105, 126, 280, 1200)
    assert brute_largest_signed_descents(descent) == {(2, 10)}
    assert brute_largest_signed_descents(descent) == characterized_largest_signed_descents(descent)
    assert brute_largest_signed_descents(stress) == set()
    assert brute_largest_signed_descents(stress) == characterized_largest_signed_descents(stress)
    return {"chebyshev_rows": rows, "descent": (2, 10), "stress_descents": 0}


if __name__ == "__main__":
    result = audit()
    for n, degree, score in result["chebyshev_rows"]:
        print(f"n={n} chebyshev_degree={degree} score_positive={score > 0}")
    print("small_denominator=(1,5,7,11),q=2")
    print("divisor_cover_only=(2,3,4,5),q=2..5")
    print("cross_pivot=(2,3,4,6),2->6,q=3")
    print("largest_descent=(1,2,6,20)->(1,2,6,10)")
    print("largest_descent_G=none")
