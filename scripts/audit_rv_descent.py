#!/usr/bin/env python3
"""Exact audits for safe and unsafe DISPERSION-STAR descent operations.

The script proves no uniform certificate.  It checks two elementary
invariances at the level of every term in the residual-variation margin and
records a fixed counterexample to naive deletion/insertion monotonicity.
"""

from __future__ import annotations

from fractions import Fraction

from audit_anchor_star import pair_degree, pivot_bad_mask, second_anchor_gain
from audit_gamma_dispersion import gamma_dispersion_numerator


def row_components(
    speeds: tuple[int, ...], pivot: int, anchor: int
) -> dict[str, int | Fraction]:
    """Return the denominator-cleared ingredients and exact RV surplus."""

    n = len(speeds)
    others = tuple(i for i in range(n) if i != pivot)
    denominator = (n - 2) * (n - 3)
    if denominator <= 0:
        raise ValueError("DISPERSION-STAR requires at least four runners")
    total_bad = sum(pivot_bad_mask(speeds, pivot, i).bit_count() for i in others)
    required = total_bad - n * speeds[pivot]
    degree = pair_degree(speeds, pivot, anchor)
    second_sum = sum(
        second_anchor_gain(speeds, pivot, anchor, q)
        for q in others
        if q != anchor
    )
    delta_numerator = gamma_dispersion_numerator(speeds, pivot, anchor)
    surplus_numerator = (
        degree * denominator
        + second_sum * (n - 3)
        + delta_numerator
        - required * denominator
    )
    return {
        "total_bad": total_bad,
        "required": required,
        "degree": degree,
        "second_sum": second_sum,
        "delta_numerator": delta_numerator,
        "denominator": denominator,
        "surplus_numerator": surplus_numerator,
        "surplus": Fraction(surplus_numerator, denominator),
    }


def _assert_mask_pullback(
    speeds: tuple[int, ...], scaled: tuple[int, ...], pivot: int, factor: int
) -> None:
    """Check B_{g b} is the pullback of B_b along r -> r mod N A."""

    n = len(speeds)
    base_modulus = (n + 1) * speeds[pivot]
    scaled_modulus = factor * base_modulus
    for child in range(n):
        if child == pivot:
            continue
        base_mask = pivot_bad_mask(speeds, pivot, child)
        scaled_mask = pivot_bad_mask(scaled, pivot, child)
        for residue in range(scaled_modulus):
            upper = bool(scaled_mask & (1 << residue))
            lower = bool(base_mask & (1 << (residue % base_modulus)))
            if upper != lower:
                raise AssertionError(
                    f"scale pullback failed at child={child}, residue={residue}"
                )


def audit_common_scale(speeds: tuple[int, ...], factor: int) -> None:
    """Check every fixed-pivot/fixed-anchor RV component scales by ``factor``."""

    if factor <= 0:
        raise ValueError("the common scale must be positive")
    scaled = tuple(factor * speed for speed in speeds)
    for pivot in range(len(speeds)):
        _assert_mask_pullback(speeds, scaled, pivot, factor)
        for anchor in range(len(speeds)):
            if anchor == pivot:
                continue
            base = row_components(speeds, pivot, anchor)
            upper = row_components(scaled, pivot, anchor)
            if upper["denominator"] != base["denominator"]:
                raise AssertionError("runner-count denominator changed under scaling")
            for key in (
                "total_bad",
                "required",
                "degree",
                "second_sum",
                "delta_numerator",
                "surplus_numerator",
                "surplus",
            ):
                if upper[key] != factor * base[key]:
                    raise AssertionError(
                        f"component {key} did not scale at pivot={pivot}, anchor={anchor}: "
                        f"{upper[key]} != {factor} * {base[key]}"
                    )


def audit_fixed_pivot_signed_residues(
    speeds: tuple[int, ...], pivot: int
) -> None:
    """Check local invariance under independent ``b -> +/- b (mod N A)``.

    We use a positive representative ``2 M - b`` for the negative class.
    Distinctness of the modified coefficients is deliberately not assumed:
    this is a fixed-pivot set-system identity, not a new valid speed tuple.
    """

    modulus = (len(speeds) + 1) * speeds[pivot]
    base_rows = {
        h: row_components(speeds, pivot, h)
        for h in range(len(speeds))
        if h != pivot
    }
    for changed in range(len(speeds)):
        if changed == pivot:
            continue
        modified = list(speeds)
        modified[changed] = 2 * modulus - (speeds[changed] % modulus)
        if modified[changed] == 2 * modulus:
            modified[changed] = modulus
        modified_tuple = tuple(modified)
        for child in range(len(speeds)):
            if child == pivot:
                continue
            if pivot_bad_mask(modified_tuple, pivot, child) != pivot_bad_mask(
                speeds, pivot, child
            ):
                raise AssertionError(
                    f"signed-residue bad mask changed for index {changed}"
                )
        for h, expected in base_rows.items():
            actual = row_components(modified_tuple, pivot, h)
            if actual != expected:
                raise AssertionError(
                    f"signed-residue RV row changed at replaced={changed}, anchor={h}"
                )


def audit_deletion_obstruction() -> dict[str, Fraction]:
    """Return the exact RF sign flip blocking naive deletion lifting."""

    full = (2, 3, 7, 9, 10, 12, 15, 16, 19)
    deleted = full[1:]  # delete the nonpivot, nonanchor speed 2
    full_row = row_components(full, full.index(15), full.index(19))
    deleted_row = row_components(deleted, deleted.index(15), deleted.index(19))
    expected = {"deleted": Fraction(42, 5), "full": Fraction(-41, 7)}
    actual = {
        "deleted": deleted_row["surplus"],
        "full": full_row["surplus"],
    }
    if actual != expected:
        raise AssertionError(f"deletion obstruction changed: {actual} != {expected}")
    return actual


def main() -> None:
    cases = (
        (1, 2, 3, 5),
        (2, 3, 7, 9, 10, 12, 15, 16, 19),
        (8, 15, 35, 40, 48, 56, 63, 75, 78),
    )
    for speeds in cases:
        audit_common_scale(speeds, 2)
        audit_common_scale(speeds, 3)
    audit_fixed_pivot_signed_residues(cases[0], cases[0].index(3))
    audit_fixed_pivot_signed_residues(cases[1], cases[1].index(3))
    print({"scale_cases": len(cases), "deletion_obstruction": audit_deletion_obstruction()})


if __name__ == "__main__":
    main()
