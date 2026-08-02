#!/usr/bin/env python3
"""Audit profile-free majorization and energy bounds for DISPERSION-STAR.

The exact cellwise bound in :mod:`audit_gamma_dispersion` uses
``sum_{q<r} |c_q-c_r|``.  This module records three rigorous lower bounds that
use only the first two moments of each integer profile, and an exact identity
for the first-anchor average of the pair part.  It also exposes the fixed
all-pivot counterexample showing that these profile-free bounds do not prove
the uniform arithmetic obligation.
"""

from __future__ import annotations

from fractions import Fraction
from math import isqrt

from audit_anchor_star import STRESS_CASES, pair_degree, pivot_bad_mask, second_anchor_gain
from audit_gamma_dispersion import gamma_dispersion_bound
from search_fiber_hall import child_fibers, pivot_candidates


ENERGY_COUNTEREXAMPLE = (8, 15, 35, 40, 48, 56, 63, 75, 78)


def pair_part(speeds: tuple[int, ...], pivot: int, h: int) -> Fraction:
    """Return ``D(h) + average_q E(q|h)`` exactly."""

    others = tuple(i for i in range(len(speeds)) if i != pivot)
    return Fraction(pair_degree(speeds, pivot, h)) + Fraction(
        sum(
            second_anchor_gain(speeds, pivot, h, q)
            for q in others
            if q != h
        ),
        len(others) - 1,
    )


def required_gain(speeds: tuple[int, ...], pivot: int) -> int:
    """Return ``S_j - |U_j|`` for the candidate residue universe."""

    others = tuple(i for i in range(len(speeds)) if i != pivot)
    return sum(pivot_bad_mask(speeds, pivot, i).bit_count() for i in others) - (
        len(speeds) * speeds[pivot]
    )


def pair_average_multiplicity_margin(
    masks: tuple[int, ...], universe: int
) -> Fraction:
    """Closed multiplicity formula for average pair part minus ``S-|U|``.

    For multiplicity ``k(x)`` and ``m=len(masks)``, the formula is

    ``u_0 - sum_x (k-1)(m-k)(m-k-1)/(m(m-1))``,

    where the sum is restricted to ``2 <= k <= m-2`` and ``u_0`` is the
    number of uncovered universe points.
    """

    m = len(masks)
    if m < 2:
        raise ValueError("the pair average needs at least two masks")
    uncovered = 0
    deficit_numerator = 0
    remaining = universe
    while remaining:
        bit = remaining & -remaining
        k = sum(bool(mask & bit) for mask in masks)
        if k == 0:
            uncovered += 1
        elif 2 <= k <= m - 2:
            deficit_numerator += (k - 1) * (m - k) * (m - k - 1)
        remaining ^= bit
    return Fraction(uncovered) - Fraction(deficit_numerator, m * (m - 1))


def direct_pair_average_margin(masks: tuple[int, ...], universe: int) -> Fraction:
    """Direct finite-set evaluation used to audit the closed identity."""

    m = len(masks)
    if m < 2:
        raise ValueError("the pair average needs at least two masks")
    pair_parts: list[Fraction] = []
    for h, bh in enumerate(masks):
        degree = sum((bh & bi).bit_count() for i, bi in enumerate(masks) if i != h)
        second_total = 0
        for q, bq in enumerate(masks):
            if q == h:
                continue
            second_total += sum(
                (bi & bq & ~bh & universe).bit_count()
                for i, bi in enumerate(masks)
                if i not in (h, q)
            )
        pair_parts.append(Fraction(degree) + Fraction(second_total, m - 1))
    required = sum((mask & universe).bit_count() for mask in masks) - universe.bit_count()
    return sum(pair_parts, Fraction()) / m - required


def _ceil_sqrt(value: int) -> int:
    root = isqrt(value)
    return root + (root * root < value)


def profile_energy_lower_bound(counts: tuple[int, ...], cell_size: int) -> int:
    """Lower-bound pairwise L1 dispersion from integer moments.

    If ``K=len(counts)``, ``T=sum(counts)``, and ``Q=sum(c*c)``, then the
    returned maximum combines

    * integer balancing: ``r(K-r)``, with ``r=T mod K``;
    * bounded energy: ``ceil((KQ-T^2)/cell_size)``;
    * Cauchy/integrality: ``ceil(sqrt(KQ-T^2))``.

    Each is at most ``sum_{q<r}|c_q-c_r|`` when ``0 <= c_q <= cell_size``.
    """

    k = len(counts)
    if k == 0:
        return 0
    if cell_size < 0 or any(c < 0 or c > cell_size for c in counts):
        raise ValueError("profile counts must lie between zero and cell_size")
    total = sum(counts)
    remainder = total % k
    balancing = remainder * (k - remainder)
    energy = k * sum(c * c for c in counts) - total * total
    bounded_energy = (energy + cell_size - 1) // cell_size if cell_size else 0
    return max(balancing, bounded_energy, _ceil_sqrt(energy))


def direct_profile_dispersion(counts: tuple[int, ...]) -> int:
    return sum(
        abs(counts[q] - counts[r])
        for q in range(len(counts))
        for r in range(q + 1, len(counts))
    )


def rv_energy_numerator(speeds: tuple[int, ...], pivot: int, h: int) -> int:
    """Sum the profile-energy lower bound over all retained cells."""

    others = tuple(i for i in range(len(speeds)) if i != pivot)
    modulus = (len(speeds) + 1) * speeds[pivot]
    pivot_speed = speeds[pivot]
    masks = {i: pivot_bad_mask(speeds, pivot, i) for i in others}
    numerator = 0
    for child in others:
        if child == h:
            continue
        anchors = tuple(i for i in others if i not in (h, child))
        for _target, fiber in child_fibers(speeds, pivot, child):
            cells: dict[int, int] = {}
            remaining = fiber
            while remaining:
                bit = remaining & -remaining
                residue = bit.bit_length() - 1
                image = speeds[h] * residue % modulus
                cells[image] = cells.get(image, 0) | bit
                remaining ^= bit
            for image, cell in cells.items():
                if image < pivot_speed or image > modulus - pivot_speed:
                    continue
                counts = tuple((cell & masks[q]).bit_count() for q in anchors)
                numerator += profile_energy_lower_bound(counts, cell.bit_count())
    return numerator


def rv_energy_bound(speeds: tuple[int, ...], pivot: int, h: int) -> Fraction:
    nonpivots = len(speeds) - 1
    denominator = (nonpivots - 1) * (nonpivots - 2)
    if denominator <= 0:
        raise ValueError("the RV energy bound needs at least three nonpivots")
    return Fraction(rv_energy_numerator(speeds, pivot, h), denominator)


def best_margin(
    speeds: tuple[int, ...], *, exact_dispersion: bool
) -> tuple[Fraction, int, int, Fraction]:
    """Return best margin, pivot speed, anchor speed, and dispersion term."""

    best: tuple[Fraction, int, int, Fraction] | None = None
    for pivot in range(len(speeds)):
        for h in range(len(speeds)):
            if h == pivot:
                continue
            dispersion = (
                gamma_dispersion_bound(speeds, pivot, h)
                if exact_dispersion
                else rv_energy_bound(speeds, pivot, h)
            )
            row = (
                pair_part(speeds, pivot, h) + dispersion - required_gain(speeds, pivot),
                speeds[pivot],
                speeds[h],
                dispersion,
            )
            if best is None or row[0] > best[0]:
                best = row
    assert best is not None
    return best


def modular_pair_identity_margin(speeds: tuple[int, ...], pivot: int) -> Fraction:
    others = tuple(i for i in range(len(speeds)) if i != pivot)
    masks = tuple(pivot_bad_mask(speeds, pivot, i) for i in others)
    return pair_average_multiplicity_margin(masks, pivot_candidates(speeds, pivot))


def direct_modular_pair_average_margin(speeds: tuple[int, ...], pivot: int) -> Fraction:
    others = tuple(i for i in range(len(speeds)) if i != pivot)
    return sum((pair_part(speeds, pivot, h) for h in others), Fraction()) / len(
        others
    ) - required_gain(speeds, pivot)


def main() -> None:
    for case in STRESS_CASES:
        name, speeds, pivot_speed, h_speed, *_rest = case
        pivot = speeds.index(pivot_speed)
        h = speeds.index(h_speed)
        energy = rv_energy_bound(speeds, pivot, h)
        exact = gamma_dispersion_bound(speeds, pivot, h)
        margin = pair_part(speeds, pivot, h) + energy - required_gain(speeds, pivot)
        print(name, "energy:", energy, "exact L1:", exact, "margin:", margin)
    speeds = ENERGY_COUNTEREXAMPLE
    print("profile-free energy best:", best_margin(speeds, exact_dispersion=False))
    print("full cellwise L1 best:", best_margin(speeds, exact_dispersion=True))
    for pivot in range(len(speeds)):
        closed = modular_pair_identity_margin(speeds, pivot)
        direct = direct_modular_pair_average_margin(speeds, pivot)
        if closed != direct:
            raise AssertionError((pivot, closed, direct))
    print("pair-average multiplicity identity: verified at every pivot")


if __name__ == "__main__":
    main()
