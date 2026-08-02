#!/usr/bin/env python3
"""Independent exact audit of Response 39 LCM slices and replacement descent."""

from __future__ import annotations

from dataclasses import dataclass
from fractions import Fraction
from math import comb, gcd, lcm


G = (15, 21, 40, 48, 56, 105, 126, 280, 1200)
T10 = (1, 2, 3, 4, 5, 6, 7, 8, 9, 11)
T11 = (1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12)
NEAR_TOP = (1, 2, 3, 4, 12)


def choose(n: int, k: int) -> int:
    return 0 if k < 0 or k > n else comb(n, k)


def circular_residue(value: int, modulus: int) -> int:
    residue = value % modulus
    return min(residue, modulus - residue)


@dataclass(frozen=True)
class SliceReport:
    speeds: tuple[int, ...]
    ell: int
    modulus: int
    histogram: tuple[int, ...]
    moments: tuple[int, ...]
    safe_pivot_counts: tuple[int, ...]


def reconstruct_slices(speeds: tuple[int, ...]) -> SliceReport:
    n = len(speeds)
    N = n + 1
    ell = lcm(*speeds)
    modulus = N * ell
    quotients = tuple(ell // speed for speed in speeds)
    histogram = [0] * (n + 1)
    for slice_residue in range(modulus):
        depth = sum(
            slice_residue % quotient == 0
            and slice_residue % (N * quotient) != 0
            for quotient in quotients
        )
        bad_count = sum(
            circular_residue(speed * slice_residue, modulus) < ell
            for speed in speeds
        )
        histogram[bad_count] += depth

    moments = tuple(
        sum(histogram[k] * choose(k, q) for k in range(n + 1))
        for q in range(n + 1)
    )
    safe_counts = []
    for pivot in speeds:
        pivot_modulus = N * pivot
        candidates = tuple(
            residue
            for residue in range(pivot_modulus)
            if residue % N != 0
        )
        quotient = ell // pivot
        embedded = {
            quotient * residue % modulus for residue in candidates
        }
        expected_slice = {
            residue
            for residue in range(modulus)
            if residue % quotient == 0
            and residue % (N * quotient) != 0
        }
        if embedded != expected_slice or len(embedded) != n * pivot:
            raise AssertionError("pivot embedding does not equal C_j")
        safe_counts.append(
            sum(
                all(
                    circular_residue(speed * residue, pivot_modulus) >= pivot
                    for speed in speeds
                )
                for residue in candidates
            )
        )
    if sum(safe_counts) != histogram[0]:
        raise AssertionError("safe-count identity failed")
    if sum(histogram) != n * sum(speeds):
        raise AssertionError("weighted slice mass changed")
    return SliceReport(
        speeds,
        ell,
        modulus,
        tuple(histogram),
        moments,
        tuple(safe_counts),
    )


def polynomial_value(n: int, depth: int, k: int) -> Fraction:
    return sum(
        Fraction((-1) ** q * choose(k, q)) for q in range(2 * depth)
    ) + Fraction(2 * depth, n - 1) * choose(k, 2 * depth)


def lower_bound(report: SliceReport, depth: int) -> Fraction:
    n = len(report.speeds)
    if not 1 <= 2 * depth <= n - 1:
        raise ValueError("depth is outside the signed-polynomial range")
    moment_form = sum(
        Fraction((-1) ** q * report.moments[q])
        for q in range(2 * depth)
    ) + Fraction(2 * depth, n - 1) * report.moments[2 * depth]
    histogram_form = sum(
        report.histogram[k] * polynomial_value(n, depth, k)
        for k in range(n + 1)
    )
    if moment_form != histogram_form:
        raise AssertionError("moment and histogram forms disagree")
    for k in range(n):
        expected = (
            Fraction(1)
            if k == 0
            else -Fraction(n - 1 - k, n - 1) * choose(k - 1, 2 * depth - 1)
        )
        if polynomial_value(n, depth, k) != expected:
            raise AssertionError("pointwise signed-polynomial identity failed")
        if k > 0 and expected > 0:
            raise AssertionError("signed-polynomial coefficient became positive")
    return moment_form


def pivot_witness(
    speeds: tuple[int, ...], pivot: int, residue: int
) -> tuple[int, tuple[int, ...]]:
    N = len(speeds) + 1
    modulus = N * pivot
    if pivot not in speeds or residue % N == 0 or not 0 <= residue < modulus:
        raise AssertionError("invalid pivot candidate witness")
    distances = tuple(
        circular_residue(speed * residue, modulus) for speed in speeds
    )
    if min(distances) < pivot:
        raise AssertionError("pivot witness is not safe")
    return modulus, distances


def replacement_candidates(speeds: tuple[int, ...]) -> tuple[tuple[int, int, int], ...]:
    N = len(speeds) + 1
    result = []
    for index, old in enumerate(speeds):
        others = speeds[:index] + speeds[index + 1 :]
        for new in range(1, old):
            if new in others or old % new != 0:
                continue
            quotient = old // new
            if gcd(quotient, N) != 1:
                continue
            if all(
                (new - old) % (N * speed) == 0
                or (new + old) % (N * speed) == 0
                for speed in others
            ):
                result.append((old, new, quotient))
    return tuple(result)


def audit_replacement_example() -> tuple[tuple[int, int, int], ...]:
    old_speeds = (1, 2, 3, 24)
    new_speeds = (1, 2, 3, 6)
    N = 5
    if replacement_candidates(old_speeds) != ((24, 6, 4),):
        raise AssertionError("signed replacement condition changed")
    for pivot in (1, 2, 3):
        modulus = N * pivot
        candidates = tuple(r for r in range(modulus) if r % N != 0)
        old_bad = {
            r for r in candidates if circular_residue(24 * r, modulus) < pivot
        }
        new_bad = {
            r for r in candidates if circular_residue(6 * r, modulus) < pivot
        }
        if old_bad != new_bad:
            raise AssertionError("old-pivot strict bad set was not preserved")
    new_modulus, new_distances = pivot_witness(new_speeds, 6, 6)
    old_modulus, old_distances = pivot_witness(old_speeds, 24, 24)
    if (new_modulus, old_modulus, new_distances, old_distances) != (
        30,
        120,
        (6, 12, 12, 6),
        (24, 48, 48, 24),
    ):
        raise AssertionError("replacement witness map r -> q*r changed")
    return replacement_candidates(old_speeds)


def audit_all() -> dict[str, SliceReport]:
    reports = {
        "G": reconstruct_slices(G),
        "T10": reconstruct_slices(T10),
        "T11": reconstruct_slices(T11),
        "near": reconstruct_slices(NEAR_TOP),
    }
    if reports["G"].histogram != (
        2272,
        6134,
        5610,
        2208,
        584,
        180,
        7,
        16,
        8,
        0,
    ):
        raise AssertionError("G weighted histogram changed")
    if lower_bound(reports["G"], 2) != Fraction(3305, 2):
        raise AssertionError("G depth-2 bound changed")
    if lower_bound(reports["G"], 4) != reports["G"].histogram[0]:
        raise AssertionError("G high-depth identity is not exact safe count")
    if (
        lower_bound(reports["T10"], 2),
        lower_bound(reports["T10"], 3),
    ) != (Fraction(-226, 9), Fraction(4)):
        raise AssertionError("T10 low-depth rows changed")
    if (
        lower_bound(reports["T11"], 2),
        lower_bound(reports["T11"], 3),
        lower_bound(reports["T11"], 4),
    ) != (Fraction(-298, 5), Fraction(0), Fraction(22)):
        raise AssertionError("T11 low-depth rows changed")
    near_bounds = tuple(
        lower_bound(reports["near"], depth) for depth in (1, 2)
    )
    if near_bounds != (Fraction(0), Fraction(14)):
        raise AssertionError("near-top bounds changed")
    pivot_witness(T10, 3, 10)
    pivot_witness(T11, 3, 11)
    pivot_witness(NEAR_TOP, 3, 7)
    audit_replacement_example()
    if replacement_candidates(G):
        raise AssertionError("G unexpectedly admits a signed replacement")
    return reports


def main() -> None:
    reports = audit_all()
    for name, report in reports.items():
        print(name, report)
        print(
            "bounds",
            tuple(
                lower_bound(report, depth)
                for depth in range(1, (len(report.speeds) - 1) // 2 + 1)
            ),
        )
    print("witness T10", pivot_witness(T10, 3, 10))
    print("witness T11", pivot_witness(T11, 3, 11))
    print("witness near", pivot_witness(NEAR_TOP, 3, 7))
    print("replacement", audit_replacement_example())
    print("G replacements", replacement_candidates(G))


if __name__ == "__main__":
    main()
