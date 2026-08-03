"""Independent deterministic checker for the supplied finite residue data."""

from __future__ import annotations

from functools import reduce
from itertools import combinations
from math import gcd


LABEL = "FINITE_COMPUTED_EVIDENCE_ONLY"


def _c2(value: int) -> int:
    return value * (value - 1) // 2


def _c3(value: int) -> int:
    return value * (value - 1) * (value - 2) // 6


def _rho(residue: int, speed: int, modulus: int) -> int:
    remainder = (residue * speed) % modulus
    return min(remainder, modulus - remainder)


def _ordinary_bad_sets(
    speeds: tuple[int, ...], pivot: int, *, include_excluded: bool = False
) -> tuple[tuple[int, frozenset[int]], ...]:
    """Return the pointwise strict-bad coordinate sets for one pivot grid."""
    n = len(speeds)
    pivot_speed = speeds[pivot]
    modulus = n * pivot_speed
    residues = range(modulus) if include_excluded else (
        residue for residue in range(modulus) if residue % n != 0
    )
    rows: list[tuple[int, frozenset[int]]] = []
    for residue in residues:
        bad = frozenset(
            index
            for index, speed in enumerate(speeds)
            if index != pivot and _rho(residue, speed, modulus) < pivot_speed
        )
        rows.append((residue, bad))
    return tuple(rows)


def _pivot_metrics(
    speeds: tuple[int, ...], pivot: int
) -> tuple[int, int, int]:
    """Compute D2, D3, and exact good count, checking D1 at every residue."""
    n = len(speeds)
    threshold_n = n + 1
    pivot_speed = speeds[pivot]
    modulus = n * pivot_speed
    residues = [residue for residue in range(modulus) if residue % n != 0]
    deltas: list[int] = []
    shells: list[int] = []
    actual_good = 0

    for residue in residues:
        delta = 0
        shell = 0
        for index, speed in enumerate(speeds):
            if index == pivot:
                continue
            distance = _rho(residue, speed, modulus)
            if threshold_n * distance < n * pivot_speed:
                delta += 1
            elif distance < pivot_speed:
                shell += 1

        # D1 is checked pointwise rather than inferred from the aggregate rows.
        is_good = delta == 0 and shell <= 1
        is_bad_by_complement = delta >= 1 or shell >= 2
        assert is_good == (not is_bad_by_complement)
        deltas.append(delta)
        shells.append(shell)
        if is_good:
            actual_good += 1

    d2 = len(residues) - sum(deltas) - sum(_c2(shell) for shell in shells)
    d3 = len(residues) - (
        sum(deltas)
        - sum(_c2(delta) for delta in deltas)
        + sum(_c3(delta) for delta in deltas)
    ) - sum(_c2(shell) for shell in shells)
    return d2, d3, actual_good


def _deletions_are_certified(speeds: tuple[int, ...]) -> bool:
    """Check every deletion against pointwise candidate rows at every pivot."""
    n = len(speeds)
    pivot_rows = tuple(
        (pivot, _ordinary_bad_sets(speeds, pivot)) for pivot in range(n)
    )
    for deleted in range(n):
        if not any(
            pivot != deleted and (not bad or bad == frozenset({deleted}))
            for pivot, rows in pivot_rows
            for _residue, bad in rows
        ):
            return False
    return True


def _eligible(speeds: tuple[int, ...]) -> bool:
    n = len(speeds)
    threshold_n = n + 1
    return (
        reduce(gcd, speeds) == 1
        and max(speeds) > threshold_n + threshold_n // 3
        and any(speed % threshold_n == 0 for speed in speeds)
        and _deletions_are_certified(speeds)
    )


def _complete_search(
    n: int, max_speed: int
) -> tuple[int, tuple[tuple[int, ...], tuple[int, ...], tuple[int, ...]] | None]:
    """Enumerate the requested finite box in combinations() order."""
    eligible_checked = 0
    first_qualifying: tuple[
        tuple[int, ...], tuple[int, ...], tuple[int, ...]
    ] | None = None
    for speeds in combinations(range(1, max_speed + 1), n):
        if not _eligible(speeds):
            continue
        eligible_checked += 1
        d3 = tuple(_pivot_metrics(speeds, pivot)[1] for pivot in range(n))
        if max(d3) <= 0:
            actual_good = tuple(
                _pivot_metrics(speeds, pivot)[2] for pivot in range(n)
            )
            first_qualifying = (speeds, d3, actual_good)
            break
    return eligible_checked, first_qualifying


def _p1_check() -> tuple[tuple[tuple[int, ...], ...], tuple[int, ...], int, int, int, int]:
    """Recompute the independent N=4, p=5 finite row check."""
    threshold_n = 4
    pivot_speed = 5
    speeds = (1, 3, 4)
    modulus = threshold_n * pivot_speed
    bad_sets = tuple(
        tuple(
            residue
            for residue in range(modulus)
            if _rho(residue, speed, modulus) < pivot_speed
        )
        for speed in speeds
    )
    deleted_gcds = tuple(
        reduce(gcd, (modulus,) + speeds[:index] + speeds[index + 1 :])
        for index in range(len(speeds))
    )
    rows = tuple(
        frozenset(index for index, bad in enumerate(bad_sets) if residue in bad)
        for residue in range(modulus)
    )
    z0 = sum(not row for row in rows)
    z1 = sum(len(row) == 1 for row in rows)
    p1_lower_bound = 2 * pivot_speed - (threshold_n - 1) * (threshold_n - 2)
    return bad_sets, deleted_gcds, z0, z1, 2 * z0 + z1, p1_lower_bound


def _shell_lifts(
    speeds: tuple[int, ...], pivot: int
) -> tuple[tuple[int, int, int], ...]:
    """Return shell-only candidates as (residue, coordinate, distance) triples."""
    n = len(speeds)
    threshold_n = n + 1
    pivot_speed = speeds[pivot]
    modulus = n * pivot_speed
    lifts: list[tuple[int, int, int]] = []
    for residue in range(modulus):
        if residue % n == 0:
            continue
        deep: list[int] = []
        shell: list[tuple[int, int, int]] = []
        for index, speed in enumerate(speeds):
            if index == pivot:
                continue
            distance = _rho(residue, speed, modulus)
            if threshold_n * distance < n * pivot_speed:
                deep.append(index)
            elif distance < pivot_speed:
                shell.append((index, speed, distance))
        if not deep and len(shell) == 1:
            lifts.append((residue, shell[0][1], shell[0][2]))
    return tuple(lifts)


def _tuple_text(values: tuple[int, ...]) -> str:
    return "(" + ",".join(str(value) for value in values) + ")"


def _triple_text(values: tuple[tuple[int, int, int], ...]) -> str:
    return "(" + ",".join(_tuple_text(triple) for triple in values) + ")"


def main() -> None:
    required_vectors = (
        ((1, 3, 4, 7), (0, -2, -6, -4), (0, 0, 0, 0), (0, 0, 0, 0)),
        ((1, 2, 3, 60), (-1, 0, -9, -36), (0, 0, 0, 24), (0, 0, 0, 24)),
        (
            (1, 2, 6, 8, 10),
            (0, -2, -8, -10, -22),
            (0, 0, 0, 4, 2),
            (0, 0, 0, 4, 4),
        ),
        (
            (15, 21, 40, 48, 56, 105, 126, 280, 1200),
            (-16, -70, -138, -174, -268, -492, -642, -1422, -5826),
            (28, 26, 26, 30, 26, 86, 26, -30, 90),
            (28, 28, 52, 48, 58, 126, 138, 304, 1328),
        ),
        ((1, 3, 4, 5, 18), (0, 0, -4, -12, -20), (0, 0, 0, 0, 0), (0, 0, 0, 0, 4)),
    )

    computed_vectors = []
    for speeds, expected_d2, expected_d3, expected_good in required_vectors:
        metrics = tuple(_pivot_metrics(speeds, pivot) for pivot in range(len(speeds)))
        computed = (
            tuple(row[0] for row in metrics),
            tuple(row[1] for row in metrics),
            tuple(row[2] for row in metrics),
        )
        assert computed == (expected_d2, expected_d3, expected_good)
        computed_vectors.append((speeds, computed))

    p1_bad_sets, p1_gcds, p1_z0, p1_z1, p1_weighted, p1_lower = _p1_check()
    assert p1_bad_sets == (
        (0, 1, 2, 3, 4, 16, 17, 18, 19),
        (0, 1, 6, 7, 8, 12, 13, 14, 19),
        (0, 1, 4, 5, 6, 9, 10, 11, 14, 15, 16, 19),
    )
    assert p1_gcds == (1, 1, 1)
    assert (p1_z0, p1_z1, p1_weighted, p1_lower) == (0, 13, 13, 4)
    assert p1_z0 == 0

    lifts_speed = _shell_lifts((1, 3, 4, 5, 18), 4)
    lifts_index = tuple(
        (residue, next(index for index, speed in enumerate((1, 3, 4, 5, 18)) if speed == speed_value), distance)
        for residue, speed_value, distance in lifts_speed
    )
    assert lifts_speed == ((39, 5, 15), (41, 4, 16), (49, 4, 16), (51, 5, 15))
    assert lifts_index == ((39, 3, 15), (41, 2, 16), (49, 2, 16), (51, 3, 15))

    searches = (
        (3, 20, 557, None),
        (4, 20, 2864, None),
        (5, 18, 266, ((1, 3, 4, 5, 18), (0, 0, 0, 0, 0), (0, 0, 0, 0, 4))),
    )
    computed_searches = []
    for n, max_speed, expected_checked, expected_first in searches:
        eligible_checked, first = _complete_search(n, max_speed)
        if first is None:
            normalized_first = None
        else:
            normalized_first = first
        assert eligible_checked == expected_checked
        assert normalized_first == expected_first
        computed_searches.append((n, max_speed, eligible_checked, normalized_first))

    print(f"label={LABEL}")
    for speeds, (d2, d3, actual_good) in computed_vectors:
        if speeds == (15, 21, 40, 48, 56, 105, 126, 280, 1200):
            vector_label = "OPT-ADD_G"
        else:
            vector_label = _tuple_text(speeds)
        print(
            f"vector={vector_label} d2={_tuple_text(d2)} "
            f"d3={_tuple_text(d3)} actual_good={_tuple_text(actual_good)}"
        )
    print(f"shell_lifts_speed={_triple_text(lifts_speed)}")
    print(f"shell_lifts_index={_triple_text(lifts_index)}")
    print(f"p1_A1={_tuple_text(p1_bad_sets[0])}")
    print(f"p1_A3={_tuple_text(p1_bad_sets[1])}")
    print(f"p1_A4={_tuple_text(p1_bad_sets[2])}")
    print(f"p1_deleted_coordinate_gcds={_tuple_text(p1_gcds)}")
    print(f"p1_Z0={p1_z0}")
    print(f"p1_Z1={p1_z1}")
    print(f"p1_2Z0_plus_Z1={p1_weighted}")
    print(f"p1_lower_bound={p1_lower}")
    print("p1_no_empty_residue=True")
    for n, max_speed, eligible_checked, first in computed_searches:
        if first is None:
            print(f"search=(n={n},max={max_speed}) eligible_checked={eligible_checked} first=NONE")
        else:
            speeds, d3, actual_good = first
            print(
                f"search=(n={n},max={max_speed}) eligible_checked={eligible_checked} "
                f"first={_tuple_text(speeds)} d3={_tuple_text(d3)} "
                f"actual_good={_tuple_text(actual_good)}"
            )


if __name__ == "__main__":
    main()
