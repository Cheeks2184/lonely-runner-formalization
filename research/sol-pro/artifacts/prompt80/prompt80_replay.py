#!/usr/bin/env python3
"""Independent literal replay of the Prompt 80 exact falsification.

This file does not import prompt80_exact_search.py. It independently rebuilds
canonical deletion rows, strict block capacities, the ordered prefix scan, the
declared mutation domains, and the key fixtures, then checks the emitted JSON.

Invocation: python3 prompt80_replay.py
Malformed input: any command-line argument is rejected with exit status 2.
"""
from __future__ import annotations

import hashlib
import itertools
import json
import math
import platform
import sys
from fractions import Fraction
from pathlib import Path
from typing import Any

VERSION = "PIPE-P80-INDEPENDENT-REPLAY-1.0.0"
BASES = ((1, 2, 3, 10), (1, 3, 4, 7), (1, 2, 3, 60), (1, 2, 6, 8, 10))


def R(m: int, z: int) -> int:
    u = z % m
    return u if u <= m - u else m - u


def G(xs: tuple[int, ...]) -> int:
    out = 0
    for x in xs:
        out = math.gcd(out, x)
    return out


def cert_stream(A: tuple[int, ...], k: int) -> list[tuple[int, int, int, tuple[int, ...]]]:
    n = len(A)
    out = []
    for j in range(n):
        if j == k:
            continue
        M = n * A[j]
        for r in range(M):
            if r % n == 0:
                continue
            vals = tuple(R(M, r * x) for x in A)
            if all(vals[i] >= A[j] for i in range(n) if i != k):
                out.append((A[j], j, r, vals))
    return sorted(out)


def canonical_summary(A: tuple[int, ...]) -> list[dict[str, Any]]:
    n = len(A)
    N = n + 1
    rows = []
    for k in range(n):
        stream = cert_stream(A, k)
        if not stream:
            rows.append({"deleted_speed": A[k], "count": 0, "canonical": None, "lift": None})
            continue
        p, j, r, vals = stream[0]
        rows.append(
            {
                "deleted_speed": A[k],
                "count": len(stream),
                "canonical": (p, j, r, vals),
                "lift": N * vals[k] >= n * p,
            }
        )
    return rows


def subset_rows(A: tuple[int, ...]) -> list[tuple[tuple[int, ...], tuple[int, ...], int, tuple[tuple[int, int, int], ...], int, bool]]:
    n = len(A)
    N = n + 1
    universe = set(range(n))
    rows = []
    for size in range(1, n):
        for S in itertools.combinations(range(n), size):
            T = tuple(sorted(universe.difference(S)))
            d = G(tuple(A[i] for i in T))
            terms = []
            total = 0
            for k in S:
                g = math.gcd(d, A[k])
                q = d // g
                cap = g * ((2 * q + N - 1) // N)
                terms.append((g, q, cap))
                total += cap
            rows.append((S, T, d, tuple(terms), total, total < d))
    return rows


def hard(A: tuple[int, ...]) -> tuple[bool, list[dict[str, Any]], list[Any]]:
    n = len(A)
    N = n + 1
    cs = canonical_summary(A)
    bs = subset_rows(A)
    premise = (
        n >= 3
        and G(A) == 1
        and max(A) > N + N // 3
        and any(x % N == 0 for x in A)
        and all(row["count"] > 0 for row in cs)
        and all(row["lift"] is False for row in cs)
    )
    return premise, cs, bs


def main_prefix() -> tuple[dict[str, int], dict[str, int], tuple[int, ...], list[dict[str, Any]], list[Any]]:
    counts = {
        "tuples_seen": 0,
        "primitive": 0,
        "above_cutoff": 0,
        "has_N_divisible": 0,
        "all_deletions_nonempty": 0,
        "hard_premise": 0,
        "hard_with_strict_block": 0,
        "hard_without_strict_block": 0,
    }
    by_n = {str(n): 0 for n in range(3, 7)}
    for n in range(3, 7):
        N = n + 1
        for A in itertools.combinations(range(1, 25), n):
            counts["tuples_seen"] += 1
            by_n[str(n)] += 1
            if G(A) != 1:
                continue
            counts["primitive"] += 1
            if max(A) <= N + N // 3:
                continue
            counts["above_cutoff"] += 1
            if not any(x % N == 0 for x in A):
                continue
            counts["has_N_divisible"] += 1
            cs = canonical_summary(A)
            if not all(row["count"] for row in cs):
                continue
            counts["all_deletions_nonempty"] += 1
            if not all(row["lift"] is False for row in cs):
                continue
            counts["hard_premise"] += 1
            bs = subset_rows(A)
            if any(row[-1] for row in bs):
                counts["hard_with_strict_block"] += 1
                continue
            counts["hard_without_strict_block"] += 1
            return counts, by_n, A, cs, bs
    raise AssertionError("expected a structural failure")


def mutations(base: tuple[int, ...]) -> list[tuple[int, ...]]:
    out = set()
    for position in range(len(base)):
        left = base[:position] + base[position + 1 :]
        for x in range(1, 121):
            candidate = tuple(sorted(left + (x,)))
            if len(set(candidate)) == len(base) and candidate != base:
                out.add(candidate)
    return sorted(out)


def mutation_summary(base: tuple[int, ...]) -> dict[str, Any]:
    domain = mutations(base)
    counts = {
        "mutations": len(domain),
        "primitive": 0,
        "hard_premise": 0,
        "hard_with_strict_block": 0,
        "hard_without_strict_block": 0,
    }
    first_hard = None
    first_bad = None
    for A in domain:
        if G(A) != 1:
            continue
        counts["primitive"] += 1
        premise, _, blocks = hard(A)
        if not premise:
            continue
        counts["hard_premise"] += 1
        if first_hard is None:
            first_hard = A
        if any(row[-1] for row in blocks):
            counts["hard_with_strict_block"] += 1
        else:
            counts["hard_without_strict_block"] += 1
            if first_bad is None:
                first_bad = A
    return {"counts": counts, "first_hard": first_hard, "first_bad": first_bad}


def dist(speed: int, t: Fraction) -> Fraction:
    u = (speed * t.numerator) % t.denominator
    return Fraction(min(u, t.denominator - u), t.denominator)


def canonical_json_bytes(x: Any) -> bytes:
    return (json.dumps(x, indent=2, sort_keys=True) + "\n").encode()


def main() -> int:
    if len(sys.argv) != 1:
        print("error: prompt80_replay.py accepts no arguments", file=sys.stderr)
        return 2

    root = Path(__file__).resolve().parent
    main_source = root / "prompt80_exact_search.py"
    main_output = root / "prompt80_exact_search.json"
    payload = json.loads(main_output.read_text(encoding="utf-8"))

    # Source/output binding and canonical results digest.
    main_source_sha = hashlib.sha256(main_source.read_bytes()).hexdigest()
    main_output_sha = hashlib.sha256(main_output.read_bytes()).hexdigest()
    assert payload["source_sha256"] == main_source_sha
    assert payload["results_sha256"] == hashlib.sha256(
        canonical_json_bytes(payload["results"])
    ).hexdigest()

    # Independent ordered prefix replay.
    counts, by_n, A, cs, bs = main_prefix()
    observed_scan = payload["results"]["main_scan"]
    assert observed_scan["counts_on_executed_prefix"] == counts
    assert observed_scan["examined_by_n"] == by_n
    assert tuple(observed_scan["first_failure"]["tuple"]) == A == (1, 3, 16)
    assert [(row["deleted_speed"], row["count"], row["canonical"], row["lift"]) for row in cs] == [
        (1, 12, (3, 1, 2, (2, 3, 4)), False),
        (3, 14, (1, 0, 1, (1, 0, 1)), False),
        (16, 2, (3, 1, 4, (4, 3, 1)), False),
    ]
    assert [(tuple(A[i] for i in S), tuple(A[i] for i in T), d, terms, total, strict)
            for S, T, d, terms, total, strict in bs] == [
        ((1,), (3, 16), 1, ((1, 1, 1),), 1, False),
        ((3,), (1, 16), 1, ((1, 1, 1),), 1, False),
        ((16,), (1, 3), 1, ((1, 1, 1),), 1, False),
        ((1, 3), (16,), 16, ((1, 16, 8), (1, 16, 8)), 16, False),
        ((1, 16), (3,), 3, ((1, 3, 2), (1, 3, 2)), 4, False),
        ((3, 16), (1,), 1, ((1, 1, 1), (1, 1, 1)), 2, False),
    ]

    # Independent mutation replay.
    expected_mutations = payload["results"]["targeted_mutations"]
    mutation_replay = []
    for base, emitted in zip(BASES, expected_mutations, strict=True):
        replay = mutation_summary(base)
        assert emitted["base"] == list(base)
        assert emitted["counts"] == replay["counts"]
        assert emitted["first_hard_tuple"] == (None if replay["first_hard"] is None else list(replay["first_hard"]))
        assert emitted["first_hard_without_block"] == (None if replay["first_bad"] is None else list(replay["first_bad"]))
        mutation_replay.append({"base": list(base), **replay})

    # Key fixtures and endpoint conventions.
    assert subset_rows((2, 4, 5))[2][2:] == (2, ((1, 2, 1),), 1, True)
    assert subset_rows((2, 4, 6))[2][2:] == (2, ((2, 1, 2),), 2, False)
    assert [dist(x, Fraction(2, 3)) for x in (2, 4, 5)] == [Fraction(1, 3)] * 3
    assert [dist(x, Fraction(1, 6)) for x in (2, 4, 6)] == [Fraction(1, 3), Fraction(1, 3), Fraction(0)]
    assert [dist(x, Fraction(2, 3)) for x in (2, 4, 6)] == [Fraction(1, 3), Fraction(1, 3), Fraction(0)]
    assert [dist(x, Fraction(5, 11)) for x in (1, 3, 16)] == [
        Fraction(5, 11), Fraction(4, 11), Fraction(3, 11)
    ]

    fixture_expectations = {
        (1, 2, 3, 10): ([18, 12, 16, 6], [8, 6, 6, 6], [False, True, True, True]),
        (1, 3, 4, 7): ([8, 8, 11, 4], [0, 0, 0, 0], [False, False, False, False]),
        (1, 2, 3, 60): ([48, 30, 48, 6], [18, 0, 6, 0], [False, False, False, False]),
        (1, 2, 6, 8, 10): ([8, 22, 16, 16, 26], [8, 8, 8, 4, 4], [True, False, True, False, False]),
    }
    emitted_fixture_records = {
        (1, 2, 3, 10): payload["results"]["fixtures"]["3_coarse_premises_do_not_force_block"],
        (1, 3, 4, 7): payload["results"]["fixtures"]["4_raw_deletion_lift_failure"],
        (1, 2, 3, 60): payload["results"]["fixtures"]["5_pairwise_phase_intersection_failure"]["record"],
        (1, 2, 6, 8, 10): payload["results"]["fixtures"]["6_N_divisible_pivot_not_required"]["record"],
    }
    fixture_replay = {}
    for fixture, (expected_counts, expected_total_lifts, expected_lifts) in fixture_expectations.items():
        rows = canonical_summary(fixture)
        actual_total_lifts = [sum(1 for item in cert_stream(fixture, k)
                                  if (len(fixture) + 1) * item[3][k] >= len(fixture) * item[0])
                              for k in range(len(fixture))]
        assert [row["count"] for row in rows] == expected_counts
        assert actual_total_lifts == expected_total_lifts
        assert [row["lift"] for row in rows] == expected_lifts
        emitted_rows = emitted_fixture_records[fixture]["canonical_deletions"]
        assert [row["certificate_count"] for row in emitted_rows] == expected_counts
        assert [row["certificate_lift_count"] for row in emitted_rows] == expected_total_lifts
        fixture_replay[str(fixture)] = {
            "counts": expected_counts,
            "total_lift_counts": expected_total_lifts,
            "canonical_lifts": expected_lifts,
        }

    # Fixed pivot 6 has 16 deletion-certificate rows and zero full lifts.
    A6 = (1, 2, 6, 8, 10)
    pivot6 = A6.index(6)
    p6_rows = []
    for k in range(len(A6)):
        if k == pivot6:
            continue
        for p, j, r, vals in cert_stream(A6, k):
            if j == pivot6:
                p6_rows.append((k, r, vals, 6 * vals[k] >= 5 * p))
    assert len(p6_rows) == 16 and not any(row[-1] for row in p6_rows)
    assert any(
        p == 8 and r == 9 and 6 * vals[0] >= 5 * p
        for p, j, r, vals in cert_stream(A6, 0)
    )

    replay_source = Path(__file__).resolve()
    replay_source_sha = hashlib.sha256(replay_source.read_bytes()).hexdigest()
    report = {
        "schema": "PIPE-P80-DIVISOR-BLOCK-REPLAY-v1",
        "script_version": VERSION,
        "status": "independent-replay-passed",
        "runtime": {
            "language": "Python",
            "version": platform.python_version(),
            "implementation": platform.python_implementation(),
            "platform": platform.platform(),
            "arithmetic": "exact arbitrary-precision integers and fractions.Fraction",
        },
        "invocation": "python3 /mnt/data/prompt80_replay.py",
        "malformed_input_behavior": "any command-line argument -> stderr diagnostic and exit status 2",
        "replay_source_file": replay_source.name,
        "replay_source_sha256": replay_source_sha,
        "main_source_sha256": main_source_sha,
        "main_output_sha256": main_output_sha,
        "source_output_binding": "replay verifies the main output's embedded source hash and results digest",
        "main_prefix_counts": counts,
        "first_failure": list(A),
        "targeted_mutations": mutation_replay,
        "fixtures": fixture_replay,
        "fixed_pivot_6_rows": len(p6_rows),
        "fixed_pivot_6_lifts": sum(row[-1] for row in p6_rows),
    }
    output = replay_source.with_suffix(".json")
    output.write_bytes(canonical_json_bytes(report))
    print(f"wrote={output}")
    print(f"replay_source_sha256={replay_source_sha}")
    print(f"main_output_sha256={main_output_sha}")
    print("status=independent-replay-passed")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
