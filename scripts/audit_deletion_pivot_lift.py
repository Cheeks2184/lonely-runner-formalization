#!/usr/bin/env python3
"""Finite audit of the corrected deletion-pivot lifting principle (DPLP).

This is finite evidence only. It checks exact closed-boundary pivot residues
with integer arithmetic and does not assert a uniform theorem.
"""

from __future__ import annotations

from itertools import combinations
from math import gcd


BOXES = (
    (3, 60),
    (4, 35),
    (5, 25),
    (6, 24),
    (7, 20),
    (8, 18),
    (9, 16),
    (10, 16),
)


def cyclic_distance(modulus: int, value: int) -> int:
    residue = value % modulus
    return min(residue, modulus - residue)


def pivot_certificate(speeds: tuple[int, ...]) -> tuple[int, int] | None:
    N = len(speeds) + 1
    for pivot in speeds:
        modulus = N * pivot
        for numerator in range(modulus):
            if numerator % N == 0:
                continue
            if all(
                cyclic_distance(modulus, numerator * speed) >= pivot
                for speed in speeds
            ):
                return pivot, numerator
    return None


def every_deletion_has_lower_certificate(speeds: tuple[int, ...]) -> bool:
    return all(
        pivot_certificate(speeds[:deleted] + speeds[deleted + 1 :]) is not None
        for deleted in range(len(speeds))
    )


def deletion_lift(
    speeds: tuple[int, ...],
) -> tuple[int, int, int, int] | None:
    """Return (deleted index, pivot, r, n*p) for one exact DPLP lift."""

    n = len(speeds)
    N = n + 1
    for deleted, exceptional in enumerate(speeds):
        old = speeds[:deleted] + speeds[deleted + 1 :]
        for pivot in old:
            modulus = n * pivot
            for numerator in range(modulus):
                if numerator % n == 0:
                    continue
                if not all(
                    cyclic_distance(modulus, numerator * speed) >= pivot
                    for speed in old
                ):
                    continue
                if N * cyclic_distance(modulus, numerator * exceptional) >= modulus:
                    return deleted, pivot, numerator, modulus
    return None


def encode(speeds: tuple[int, ...] | None) -> str:
    return "NONE" if speeds is None else ",".join(map(str, speeds))


def main() -> None:
    total_primitive = 0
    total_above_cutoff = 0
    total_reciprocal = 0
    total_DPLP = 0
    total_DPLP_premise_failures = 0
    total_DPLP_failures = 0
    smallest_raw_failure = None

    print("label=FINITE_EVIDENCE_ONLY")
    print("predicate=corrected_DPLP_exists_speed_divisible_by_N")
    print("boundary=closed_1_over_N")

    for n, maximum in BOXES:
        N = n + 1
        cutoff = N + N // 3
        primitive = 0
        above_cutoff = 0
        reciprocal = 0
        DPLP_cases = 0
        DPLP_premise_failures = 0
        DPLP_failures = 0
        raw_lift_failures = 0
        first_DPLP_failure = None
        first_raw_failure = None

        for speeds in combinations(range(1, maximum + 1), n):
            if gcd(*speeds) != 1:
                continue
            primitive += 1
            if speeds[-1] <= cutoff:
                continue
            above_cutoff += 1
            lift = deletion_lift(speeds)
            has_N_divisor = any(speed % N == 0 for speed in speeds)
            if not has_N_divisor:
                reciprocal += 1
                # This is exactly the q=N small-denominator witness premise.
                assert all(speed % N != 0 for speed in speeds)
            else:
                DPLP_cases += 1
                if not every_deletion_has_lower_certificate(speeds):
                    DPLP_premise_failures += 1
                if lift is None:
                    DPLP_failures += 1
                    if first_DPLP_failure is None:
                        first_DPLP_failure = speeds
            if lift is None:
                raw_lift_failures += 1
                if first_raw_failure is None:
                    first_raw_failure = speeds
                # Every raw failure found must be outside the corrected DPLP
                # premise and must still be an exact full pivot-certified tuple.
                assert not has_N_divisor
                assert pivot_certificate(speeds) is not None

        total_primitive += primitive
        total_above_cutoff += above_cutoff
        total_reciprocal += reciprocal
        total_DPLP += DPLP_cases
        total_DPLP_premise_failures += DPLP_premise_failures
        total_DPLP_failures += DPLP_failures
        if smallest_raw_failure is None and first_raw_failure is not None:
            smallest_raw_failure = first_raw_failure

        prefix = f"box_n{n}_max{maximum}"
        print(f"{prefix}_primitive={primitive}")
        print(f"{prefix}_coefficient_three_cutoff={cutoff}")
        print(f"{prefix}_above_cutoff={above_cutoff}")
        print(f"{prefix}_reciprocal_direct_cases={reciprocal}")
        print(f"{prefix}_DPLP_cases={DPLP_cases}")
        print(f"{prefix}_DPLP_premise_failures={DPLP_premise_failures}")
        print(f"{prefix}_DPLP_failures={DPLP_failures}")
        print(f"{prefix}_first_DPLP_failure={encode(first_DPLP_failure)}")
        print(f"{prefix}_raw_lift_failures={raw_lift_failures}")
        print(f"{prefix}_first_raw_lift_failure={encode(first_raw_failure)}")

    print(f"total_primitive={total_primitive}")
    print(f"total_above_cutoff={total_above_cutoff}")
    print(f"total_reciprocal_direct_cases={total_reciprocal}")
    print(f"total_DPLP_cases={total_DPLP}")
    print(f"total_DPLP_premise_failures={total_DPLP_premise_failures}")
    print(f"total_DPLP_failures={total_DPLP_failures}")
    print(f"smallest_raw_lift_failure={encode(smallest_raw_failure)}")
    assert total_above_cutoff == total_reciprocal + total_DPLP
    assert total_DPLP_failures == 0
    assert total_DPLP_premise_failures == 0
    assert smallest_raw_failure == (1, 3, 4, 7)
    print("status=PASS")


if __name__ == "__main__":
    main()
