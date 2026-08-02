#!/usr/bin/env python3
"""Exact CRT evaluation of the common-slice moments from Response 39.

This verifier never constructs the weighted ``k`` histogram and never searches
for a safe slice.  Its primary calculation expands each binomial moment over
pivot slices and runner-index subsets, then intersects the resulting families
of one-variable congruence classes by the generalized CRT.
"""

from __future__ import annotations

from fractions import Fraction
from itertools import combinations
from math import comb, gcd, lcm


G = (15, 21, 40, 48, 56, 105, 126, 280, 1200)
EXPECTED_G_MOMENTS_0_TO_4 = (17019, 27432, 18203, 7492, 2709)
EXPECTED_G_DEPTH_TWO_BOUND = Fraction(3305, 2)


def circular_residue(value: int, modulus: int) -> int:
    residue = value % modulus
    return min(residue, modulus - residue)


def strict_ball_classes(speed: int, pivot: int, runner_count: int) -> tuple[int, tuple[int, ...]]:
    """Return ``m`` and the classes ``r=c (mod m)`` for one strict bad ball.

    The ambient pivot modulus is ``M=(runner_count+1)*pivot``.  Solving
    ``speed*r = h (mod M)`` for every integer ``|h|<pivot`` produces a
    disjoint family of classes modulo ``m=M/gcd(speed,M)``.
    """

    if speed <= 0 or pivot <= 0 or runner_count < 1:
        raise ValueError("speeds and pivot must be positive")
    N = runner_count + 1
    M = N * pivot
    divisor = gcd(speed, M)
    reduced_modulus = M // divisor
    reduced_speed = speed // divisor
    inverse = 0 if reduced_modulus == 1 else pow(reduced_speed, -1, reduced_modulus)
    classes = tuple(
        (inverse * (endpoint // divisor)) % reduced_modulus
        for endpoint in range(-(pivot - 1), pivot)
        if endpoint % divisor == 0
    )
    if len(classes) != len(set(classes)):
        raise AssertionError("strict endpoint representatives were not disjoint")
    return reduced_modulus, classes


def merge_class_families(
    left_modulus: int,
    left_classes: set[int],
    right_modulus: int,
    right_classes: tuple[int, ...],
) -> tuple[int, set[int]]:
    """Intersect two disjoint class families using the generalized CRT."""

    common = gcd(left_modulus, right_modulus)
    merged_modulus = lcm(left_modulus, right_modulus)
    left_step = left_modulus // common
    right_step = right_modulus // common
    inverse = 0 if right_step == 1 else pow(left_step, -1, right_step)
    merged: set[int] = set()
    compatible_pairs = 0
    for left in left_classes:
        for right in right_classes:
            difference = right - left
            if difference % common:
                continue
            multiplier = 0 if right_step == 1 else (difference // common * inverse) % right_step
            residue = (left + left_modulus * multiplier) % merged_modulus
            merged.add(residue)
            compatible_pairs += 1
    # The input families are disjoint in the ambient pivot cycle.  Hence two
    # compatible pairs cannot describe the same nonempty merged class.
    if len(merged) != compatible_pairs:
        raise AssertionError("CRT merge unexpectedly duplicated a solution class")
    return merged_modulus, merged


def subset_intersection_count(
    speeds: tuple[int, ...], pivot_index: int, runner_subset: tuple[int, ...]
) -> int:
    """Count candidate residues bad for every runner in ``runner_subset``."""

    n = len(speeds)
    if n < 1 or any(speed <= 0 for speed in speeds):
        raise ValueError("the speed tuple must be nonempty and positive")
    if not 0 <= pivot_index < n:
        raise IndexError("pivot index is outside the tuple")
    if tuple(sorted(set(runner_subset))) != runner_subset:
        raise ValueError("runner_subset must contain increasing distinct indices")
    if any(not 0 <= index < n for index in runner_subset):
        raise IndexError("runner subset index is outside the tuple")

    N = n + 1
    pivot = speeds[pivot_index]
    M = N * pivot
    modulus = 1
    classes = {0}
    for runner_index in runner_subset:
        condition_modulus, condition_classes = strict_ball_classes(
            speeds[runner_index], pivot, n
        )
        modulus, classes = merge_class_families(
            modulus, classes, condition_modulus, condition_classes
        )
        if not classes:
            return 0

    if M % modulus:
        raise AssertionError("the merged CRT modulus must divide the pivot modulus")
    total_per_class = M // modulus
    candidate_count = 0
    common_with_exclusion = gcd(modulus, N)
    exclusion_modulus = lcm(modulus, N)
    excluded_per_compatible_class = M // exclusion_modulus
    for residue in classes:
        candidate_count += total_per_class
        if residue % common_with_exclusion == 0:
            candidate_count -= excluded_per_compatible_class
    return candidate_count


def crt_moment(speeds: tuple[int, ...], order: int) -> int:
    """Evaluate H_order by the pivot/subset/CRT expansion."""

    n = len(speeds)
    if not 0 <= order <= n:
        raise ValueError("moment order must lie between zero and runner count")
    total = 0
    for pivot_index in range(n):
        # A candidate on pivot j is never bad for runner j, so subsets that
        # contain the pivot index contribute zero and need not be generated.
        other_indices = tuple(index for index in range(n) if index != pivot_index)
        total += sum(
            subset_intersection_count(speeds, pivot_index, subset)
            for subset in combinations(other_indices, order)
        )
    return total


def direct_pivot_moment(speeds: tuple[int, ...], order: int) -> int:
    """Independent literal pivot-grid audit, without a histogram or safe-set count."""

    n = len(speeds)
    N = n + 1
    total = 0
    for pivot in speeds:
        M = N * pivot
        for residue in range(M):
            if residue % N == 0:
                continue
            bad_count = sum(
                circular_residue(speed * residue, M) < pivot for speed in speeds
            )
            total += comb(bad_count, order)
    return total


def depth_two_bound_from_moments(moments: tuple[int, ...]) -> Fraction:
    """Compute `L_(n,2)` from `H_0,...,H_4`, with `n=len(G)=9` here."""

    if len(moments) != 5:
        raise ValueError("depth two needs exactly moments H_0 through H_4")
    return sum(
        (Fraction((-1) ** order * moments[order]) for order in range(4)),
        Fraction(0),
    ) + Fraction(4, len(G) - 1) * moments[4]


def audit_g() -> tuple[int, ...]:
    moments = tuple(crt_moment(G, order) for order in range(5))
    if moments != EXPECTED_G_MOMENTS_0_TO_4:
        raise AssertionError(f"G CRT moments changed: {moments}")
    direct = tuple(direct_pivot_moment(G, order) for order in range(5))
    if direct != moments:
        raise AssertionError(f"CRT/direct disagreement: CRT={moments}, direct={direct}")
    if depth_two_bound_from_moments(moments) != EXPECTED_G_DEPTH_TWO_BOUND:
        raise AssertionError("G's noncircular depth-two lower bound changed")

    # Boundary audit: equality at distance pivot is good, while pivot-1 is bad.
    pivot = 15
    M = (len(G) + 1) * pivot
    if circular_residue(pivot, M) < pivot:
        raise AssertionError("strict boundary was accidentally included")
    if not circular_residue(pivot - 1, M) < pivot:
        raise AssertionError("interior strict endpoint was accidentally excluded")

    # The pivot runner forces r=0 (mod N), which the candidate grid excludes.
    for pivot_index in range(len(G)):
        if subset_intersection_count(G, pivot_index, (pivot_index,)) != 0:
            raise AssertionError("self-runner contribution should vanish")
    return moments


def audit_small_rows() -> None:
    """Exercise non-coprime, repeated-speed, and very small boundary cases."""

    rows = (
        (1,),
        (1, 2, 3),
        (2, 4, 6, 9),
        (3, 3, 6),  # The identity itself does not require distinct speeds.
    )
    for speeds in rows:
        for order in range(len(speeds) + 1):
            crt = crt_moment(speeds, order)
            direct = direct_pivot_moment(speeds, order)
            if crt != direct:
                raise AssertionError(
                    f"small-row disagreement for {speeds}, q={order}: {crt} != {direct}"
                )


def main() -> None:
    audit_small_rows()
    moments = audit_g()
    print("G CRT moments H_0..H_4:", moments)
    print("G depth-two lower bound:", depth_two_bound_from_moments(moments))
    print("Verified by generalized CRT and an independent direct pivot-grid sum.")
    print("No weighted k histogram or safe-set enumeration was constructed.")


if __name__ == "__main__":
    main()
