#!/usr/bin/env python3
"""Exact verifier for Prompt 42 partial results.

No third-party packages.

This script checks:
1. the exact rational Chebyshev polynomial and its Newton/binomial expansion;
2. reconstruction of global and pivot scores from H_q moments, without using D_0;
3. the direct generalized-CRT subset formula on every nonempty subset for (1,2,3,5);
4. all named stress tuples;
5. the constructive theorem for every (N-1)-subset of {1,...,N+1}, N=4,...,20.

The script does not claim a uniform proof of the pivot-certificate proposition.
"""

from fractions import Fraction
from hashlib import sha256
from itertools import combinations, product
from math import ceil, comb, gcd, isqrt, log, sqrt


def gcd_many(*xs: int) -> int:
    out = 0
    for x in xs:
        out = gcd(out, x)
    return out


def rho(M: int, x: int) -> int:
    y = x % M
    return min(y, M - y)


def chosen_degree(n: int) -> int:
    assert n >= 3
    return ceil(sqrt(n - 1) / 2 * log(4 * n * (n + 1)))


def scaled_chebyshev(degree: int, y: int, c: int) -> int:
    """c^degree * T_degree(y/c), computed by an integral recurrence."""
    if degree == 0:
        return 1
    if degree == 1:
        return y
    prev, cur = 1, y
    for _ in range(2, degree + 1):
        prev, cur = cur, 2 * y * cur - c * c * prev
    return cur


def chebyshev_values(n: int) -> tuple[int, int, tuple[int, ...]]:
    """Return degree, common denominator, and P(k) numerators for k=0,...,n-1.

    P(k) = (T_r(x_k)-1)/(T_r(x_0)-1),
    x_k=(n-2k)/(n-2).  All values share the returned positive denominator.
    """
    assert n >= 3
    m = n - 1
    c = m - 1
    degree = chosen_degree(n)
    c_pow = c ** degree
    top = scaled_chebyshev(degree, m + 1, c)
    denominator = top - c_pow
    nums = tuple(
        scaled_chebyshev(degree, m + 1 - 2 * k, c) - c_pow
        for k in range(n)
    )
    assert denominator > 0 and nums[0] == denominator
    assert all(x <= 0 for x in nums[1:])
    return degree, denominator, nums


def newton_coefficients(values: tuple[Fraction, ...]) -> tuple[Fraction, ...]:
    """Coefficients c_q with P(k)=sum_q c_q*C(k,q)."""
    row = list(values)
    out = []
    while row:
        out.append(row[0])
        row = [row[i + 1] - row[i] for i in range(len(row) - 1)]
    return tuple(out)


def pivot_moments_literal(speeds: tuple[int, ...], pivot: int, max_q: int) -> tuple[int, ...]:
    """H_{j,q}=sum_{r in R_j} C(k_j(r),q), without forming a histogram or safe set."""
    n = len(speeds)
    N = n + 1
    A = speeds[pivot]
    M = N * A
    out = [n * A]
    for q in range(1, max_q + 1):
        total = 0
        for r in range(M):
            if r % N == 0:
                continue
            k = sum(
                rho(M, speeds[i] * r) < A
                for i in range(n) if i != pivot
            )
            total += comb(k, q)
        out.append(total)
    return tuple(out)


def score_from_moments(speeds: tuple[int, ...], pivot: int) -> Fraction:
    n = len(speeds)
    degree, denominator, nums = chebyshev_values(n)
    values = tuple(Fraction(x, denominator) for x in nums)
    coeffs = newton_coefficients(values)
    max_q = min(degree, n - 1)
    H = pivot_moments_literal(speeds, pivot, max_q)
    # H_q=0 for q>n-1.
    return sum(coeffs[q] * H[q] for q in range(max_q + 1))


def direct_pivot_score(speeds: tuple[int, ...], pivot: int) -> tuple[Fraction, int]:
    n = len(speeds)
    N = n + 1
    A = speeds[pivot]
    M = N * A
    _, denominator, nums = chebyshev_values(n)
    score_num = 0
    safe = 0
    for r in range(M):
        if r % N == 0:
            continue
        k = sum(
            rho(M, speeds[i] * r) < A
            for i in range(n) if i != pivot
        )
        score_num += nums[k]
        safe += (k == 0)
    score = Fraction(score_num, denominator)
    assert score == score_from_moments(speeds, pivot)
    return score, safe


def target_set(M: int, A: int) -> tuple[int, ...]:
    # Strict endpoint: +/-A are excluded.
    return tuple(x for x in range(M) if rho(M, x) < A)


def candidate_count_crt(
    N: int, A: int, coeffs: tuple[int, ...], targets: tuple[int, ...]
) -> int:
    assert coeffs and len(coeffs) == len(targets)
    M = N * A

    def compatible(factor: int, target_divisor: int) -> bool:
        if any(t % target_divisor for t in targets):
            return False
        modulus = M * factor
        return all(
            (coeffs[q] * targets[p] - coeffs[p] * targets[q]) % modulus == 0
            for p in range(len(coeffs))
            for q in range(p + 1, len(coeffs))
        )

    g = gcd_many(M, *coeffs)
    unrestricted = g if compatible(g, g) else 0
    h = gcd_many(A, *coeffs)
    excluded = h if compatible(h, N * h) else 0
    assert excluded == 0 or unrestricted != 0  # C_exc implies C_M.
    return unrestricted - excluded


def intersection_count_crt(
    speeds: tuple[int, ...], pivot: int, runners: tuple[int, ...]
) -> int:
    n = len(speeds)
    N = n + 1
    A = speeds[pivot]
    M = N * A
    T = target_set(M, A)
    coeffs = tuple(speeds[i] for i in runners)
    return sum(
        candidate_count_crt(N, A, coeffs, t)
        for t in product(T, repeat=len(runners))
    )


def intersection_count_literal(
    speeds: tuple[int, ...], pivot: int, runners: tuple[int, ...]
) -> int:
    n = len(speeds)
    N = n + 1
    A = speeds[pivot]
    M = N * A
    return sum(
        r % N != 0 and all(rho(M, speeds[i] * r) < A for i in runners)
        for r in range(M)
    )


def bounded_height_witness(speeds: tuple[int, ...]) -> tuple[int, int]:
    """Construct the witness for max speed <= N+1, where N=len(speeds)+1."""
    speeds = tuple(sorted(speeds))
    N = len(speeds) + 1
    assert len(speeds) == N - 1
    assert 0 < speeds[0] and len(set(speeds)) == len(speeds)
    assert speeds[-1] <= N + 1
    missing = [x for x in range(1, N + 2) if x not in speeds]
    assert len(missing) == 2
    c, d = missing

    if d == N + 1:
        if c == N:
            q, r = N, 1
        elif 2 * c > N:
            q, r = c, 1
        else:
            # [N+1,2N-c] contains at least c consecutive integers.
            u = next(u for u in range(N + 1, 2 * N - c + 1) if u % c == 1 % c)
            q, r = c + u, pow(c, -1, c + u)
    else:
        if 2 * d > N + 1:
            q, r = d, 1
        else:
            # c<d<=(N+1)/2, so c<=(N-1)/2 and this interval has >=c terms.
            u = next(u for u in range(N + 2, 2 * N - c + 1) if u % c == 1 % c)
            q, r = c + u, pow(c, -1, c + u)

    assert all(rho(q, r * a) * N >= q for a in speeds)
    return q, r


def main() -> None:
    # Direct CRT subset formula, including collective gcds and candidate subtraction.
    small = (1, 2, 3, 5)
    checked = 0
    for pivot in range(len(small)):
        others = tuple(i for i in range(len(small)) if i != pivot)
        for q in range(1, len(others) + 1):
            for runners in combinations(others, q):
                assert intersection_count_crt(small, pivot, runners) == \
                    intersection_count_literal(small, pivot, runners)
                checked += 1
    assert checked == 28

    stress = {
        "RF": (2, 3, 7, 9, 10, 12, 15, 16, 19),
        "fixed_clock_1": (8, 15, 35, 40, 48, 56, 63, 75, 78),
        "fixed_clock_2": (6, 8, 15, 21, 28, 35, 40, 48, 75),
        "hard_A": (1, 2, 5, 7, 9, 11, 12, 13),
        "hard_B": (1, 5, 7, 8, 9, 11, 13, 15),
        "small": small,
        "C": (8, 15, 35, 40, 48, 56, 68, 75, 78),
        "D": (10, 37, 45, 51, 54, 56, 61, 71, 91),
        "E": (5, 28, 35, 40, 68, 88, 108, 148, 165),
        "F": (8, 15, 35, 40, 48, 56, 75, 132, 147),
        "G": (15, 21, 40, 48, 56, 105, 126, 280, 1200),
    }

    print(f"crt_small_checked={checked}")
    print("stress_scores")
    for name, speeds in stress.items():
        degree, denominator, _ = chebyshev_values(len(speeds))
        rows = [(speeds[j], *direct_pivot_score(speeds, j)) for j in range(len(speeds))]
        global_score = sum(row[1] for row in rows)
        best = max(rows, key=lambda row: row[1])
        score_hash = sha256(str(tuple((a, s, z) for a, s, z in rows)).encode()).hexdigest()[:16]
        print(
            f"{name}: n={len(speeds)} degree={degree} denominator={denominator} "
            f"global={global_score} best=(A={best[0]},score={best[1]},safe={best[2]}) "
            f"rows_hash={score_hash}"
        )
        assert global_score > 0

    # Exhaustively check the constructive max-speed <= N+1 theorem for N=4,...,20.
    bounded_count = 0
    witness_hash_data = []
    for N in range(4, 21):
        for speeds in combinations(range(1, N + 2), N - 1):
            q, r = bounded_height_witness(speeds)
            bounded_count += 1
            witness_hash_data.append((N, speeds, q, r))
    assert bounded_count == 1530
    witness_hash = sha256(str(tuple(witness_hash_data)).encode()).hexdigest()[:16]
    print(f"bounded_height_cases={bounded_count} witness_hash={witness_hash}")


if __name__ == "__main__":
    main()

