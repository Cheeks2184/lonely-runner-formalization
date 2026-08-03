#!/usr/bin/env python3
"""Deterministic finite audit of J1-style shifted translations in exact Gamma.

This program produces finite evidence only.  It does not prove a uniform SDR
or any form of the Lonely Runner Conjecture.
"""

from __future__ import annotations

from itertools import combinations
from math import gcd


FIRST_N = 20
LAST_N = 300


def omega(value: int) -> int:
    count = 0
    prime = 2
    while prime * prime <= value:
        if value % prime == 0:
            count += 1
            while value % prime == 0:
                value //= prime
        prime += 1
    return count + int(value > 1)


def candidates(N: int, t: int) -> tuple[int, ...]:
    """The exact generic unresolved candidate set used in the Gamma frontier."""
    H = N + t
    answer: list[int] = []
    for c in range(3 * (N - t) // 4 + 1, H // 2 + 1):
        if max(0, N - c - t) >= 1 << omega(c):
            continue
        if any(gcd(c, d) == 1 for d in range(H + 1, 2 * N - c + 1)):
            continue
        answer.append(c)
    return tuple(answer)


def exact_gamma_row(N: int, t: int, c: int) -> tuple[int, ...]:
    """Right offsets r=d-N in the exact Gamma neighborhood of c."""
    return tuple(
        r
        for r in range(1, t + 1)
        if N + t < c + (N + r) <= 2 * N and gcd(c, N + r) == 1
    )


def shifted_row(N: int, t: int, c: int, shifts: tuple[int, ...]) -> tuple[int, ...]:
    """J1 base offset, shifted by each fixed member of shifts."""
    base = c if c <= t else c - t
    return tuple(
        sorted(
            {
                base + shift
                for shift in shifts
                if 1 <= base + shift <= t
                and N + t < c + (N + base + shift) <= 2 * N
                and gcd(c, N + base + shift) == 1
            }
        )
    )


def has_sdr(rows: tuple[tuple[int, ...], ...], t: int) -> bool:
    owner = [-1] * (t + 1)

    def augment(left: int, seen: set[int]) -> bool:
        for right in rows[left]:
            if right in seen:
                continue
            seen.add(right)
            if owner[right] < 0 or augment(owner[right], seen):
                owner[right] = left
                return True
        return False

    order = sorted(range(len(rows)), key=lambda index: (len(rows[index]), index))
    return all(augment(left, set()) for left in order)


def first_failure(
    instances: tuple[tuple[int, int, tuple[int, ...]], ...],
    shifts: tuple[int, ...],
) -> tuple[int, int, tuple[int, ...]] | None:
    for N, t, left in instances:
        rows = tuple(shifted_row(N, t, c, shifts) for c in left)
        if not has_sdr(rows, t):
            return N, t, left
    return None


def smallest_deficient_subset(
    left: tuple[int, ...], rows: tuple[tuple[int, ...], ...]
) -> tuple[tuple[int, ...], tuple[int, ...]] | None:
    for size in range(1, len(left) + 1):
        for indices in combinations(range(len(left)), size):
            neighborhood = tuple(sorted({r for i in indices for r in rows[i]}))
            if len(neighborhood) < size:
                return tuple(left[i] for i in indices), neighborhood
    return None


def main() -> None:
    instances = tuple(
        (N, t, left)
        for N in range(FIRST_N, LAST_N + 1)
        for t in range(N // 3 + 1, N // 2 + 1)
        if (left := candidates(N, t))
    )
    parameter_cases = sum(
        N // 2 - (N // 3 + 1) + 1 for N in range(FIRST_N, LAST_N + 1)
    )
    candidate_rows = sum(len(left) for _, _, left in instances)

    # J1 is precisely the zero-shift subgraph: lower rows use r=c, upper rows
    # use r=c-t.  Its one edge per row is an SDR exactly when all conditional
    # gcd and cross-collision hypotheses hold.
    j1_rows_by_graph = tuple(
        tuple(shifted_row(N, t, c, (0,)) for c in left)
        for N, t, left in instances
    )
    j1_applicable = sum(
        has_sdr(rows, t)
        for (_, t, _), rows in zip(instances, j1_rows_by_graph, strict=True)
    )
    j1_admissible_rows = sum(
        int(bool(row)) for rows in j1_rows_by_graph for row in rows
    )
    j1_graphs_with_admissible_row = sum(
        any(rows) for rows in j1_rows_by_graph
    )

    print("label=FINITE_EVIDENCE_ONLY")
    print(f"domain_N={FIRST_N}..{LAST_N}")
    print("domain_t=floor(N/3)+1..floor(N/2)")
    print(f"parameter_cases={parameter_cases}")
    print(f"nonempty_candidate_graphs={len(instances)}")
    print(f"candidate_rows={candidate_rows}")
    print(f"j1_zero_shift_admissible_rows={j1_admissible_rows}")
    print(f"j1_graphs_with_admissible_row={j1_graphs_with_admissible_row}")
    print(f"j1_zero_shift_applicable_graphs={j1_applicable}")

    # Search the most natural shifted extensions S={-radius,...,+radius}.
    for radius in range(0, 9):
        shifts = tuple(range(-radius, radius + 1))
        failure = first_failure(instances, shifts)
        if failure is None:
            print(f"symmetric_radius_{radius}_first_failure=NONE_THROUGH_{LAST_N}")
        else:
            N, t, left = failure
            print(
                f"symmetric_radius_{radius}_first_failure="
                f"N:{N},t:{t},rows:{len(left)}"
            )

    # At N=20, every feasible shifted edge uses a shift in [-9,8].  Hence a
    # shift outside this interval has no effect on any of the four active t
    # instances.  Exhausting all effective subsets of size at most three thus
    # audits every fixed integer family of at most three J1 shifts.
    N = 20
    active = tuple(
        (t, candidates(N, t)) for t in range(N // 3 + 1, N // 2 + 1)
    )
    feasible_shift_set = {
        right - (c if c <= t else c - t)
        for t, left in active
        for c in left
        for right in range(1, t + 1)
        if N + t < c + (N + right) <= 2 * N
    }
    feasible_shifts = tuple(sorted(feasible_shift_set))
    assert feasible_shifts == tuple(range(-9, 9))
    tested_families = 0
    surviving_families: list[tuple[int, ...]] = []
    for size in range(0, 4):
        for shifts in combinations(feasible_shifts, size):
            tested_families += 1
            if all(
                has_sdr(tuple(shifted_row(N, t, c, shifts) for c in left), t)
                for t, left in active
            ):
                surviving_families.append(shifts)
    print(f"N20_effective_shift_range={feasible_shifts[0]}..{feasible_shifts[-1]}")
    print(f"N20_shift_families_size_le_3_tested={tested_families}")
    print(f"N20_shift_families_size_le_3_surviving={len(surviving_families)}")

    # Give the exact smallest obstruction for the canonical three shifts.
    obstruction_N, obstruction_t = 20, 9
    obstruction_left = candidates(obstruction_N, obstruction_t)
    obstruction_rows = tuple(
        shifted_row(obstruction_N, obstruction_t, c, (-1, 0, 1))
        for c in obstruction_left
    )
    deficient = smallest_deficient_subset(obstruction_left, obstruction_rows)
    print("canonical_three_shifts=-1,0,1")
    print(f"canonical_obstruction_candidates={','.join(map(str, obstruction_left))}")
    for c, row in zip(obstruction_left, obstruction_rows, strict=True):
        print(f"canonical_row_c{c}={','.join(map(str, row))}")
    assert deficient is not None
    deficient_left, deficient_right = deficient
    print(f"canonical_deficient_left={','.join(map(str, deficient_left))}")
    print(f"canonical_deficient_right_offsets={','.join(map(str, deficient_right))}")

    # Check that this is only an obstruction to the translation restriction:
    # the complete exact Gamma graph itself still has an SDR.
    exact_rows = tuple(
        exact_gamma_row(obstruction_N, obstruction_t, c)
        for c in obstruction_left
    )
    print(f"canonical_full_Gamma_has_SDR={int(has_sdr(exact_rows, obstruction_t))}")

    # The first small obstruction whose complete Gamma graph still matches is
    # outside the N>=20 frontier: N=9,t=4.  Reporting it prevents "smallest"
    # from silently meaning only the principal audit domain.
    first_unrestricted = None
    for small_N in range(1, FIRST_N):
        for small_t in range(small_N // 3 + 1, small_N // 2 + 1):
            small_left = candidates(small_N, small_t)
            shifted = tuple(
                shifted_row(small_N, small_t, c, (-1, 0, 1))
                for c in small_left
            )
            complete = tuple(
                exact_gamma_row(small_N, small_t, c) for c in small_left
            )
            if small_left and not has_sdr(shifted, small_t) and has_sdr(
                complete, small_t
            ):
                first_unrestricted = small_N, small_t, small_left, shifted
                break
        if first_unrestricted is not None:
            break
    assert first_unrestricted is not None
    small_N, small_t, small_left, shifted = first_unrestricted
    small_deficient = smallest_deficient_subset(small_left, shifted)
    assert small_deficient is not None
    print(
        f"canonical_first_matching_Gamma_obstruction="
        f"N:{small_N},t:{small_t},candidates:{','.join(map(str, small_left))}"
    )
    print(
        "canonical_first_matching_Gamma_deficient_left="
        + ",".join(map(str, small_deficient[0]))
    )
    print(
        "canonical_first_matching_Gamma_deficient_right_offsets="
        + ",".join(map(str, small_deficient[1]))
    )

    # Four shifts are the first cardinality that can cover all four N=20
    # active instances.  Record every effective four-shift survivor there and
    # its immediate first failure in the audited global domain.
    four_survivors = []
    for shifts in combinations(feasible_shifts, 4):
        if all(
            has_sdr(tuple(shifted_row(N, t, c, shifts) for c in left), t)
            for t, left in active
        ):
            four_survivors.append(shifts)
    print(f"N20_shift_families_size_4_surviving={len(four_survivors)}")
    for shifts in four_survivors:
        failure = first_failure(instances, shifts)
        encoded = ",".join(map(str, shifts))
        if failure is None:
            print(f"four_shift_{encoded}_first_failure=NONE_THROUGH_{LAST_N}")
        else:
            fail_N, fail_t, fail_left = failure
            print(
                f"four_shift_{encoded}_first_failure="
                f"N:{fail_N},t:{fail_t},rows:{len(fail_left)}"
            )

    print("status=PASS")


if __name__ == "__main__":
    main()
