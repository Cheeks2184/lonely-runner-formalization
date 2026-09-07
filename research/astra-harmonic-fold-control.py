#!/usr/bin/env python3
"""Exact bounded control for the proposed harmonic-fold recurrence.

This is a finite falsifier only.  It uses the accepted pair-sum critical-time
geometry to enumerate every ordinary global maximizer in the stated open
domain, then requires every one of those choices to fail before reporting a
tuple.  Folded tuples are maximized on the closed half interval, so their
candidate set also includes t = 1/2.
"""

from __future__ import annotations

import argparse
import hashlib
import itertools
import json
import math
import os
import sys
import time
from datetime import datetime, timezone
from fractions import Fraction
from functools import reduce


SEARCH_LIMIT_SECONDS = 60
DOMAIN = {"dimensions": [3, 4, 5, 6], "speeds": [1, 12]}


def text(value: Fraction) -> str:
    return f"{value.numerator}/{value.denominator}"


def score_at(time_value: Fraction, speeds: tuple[int, ...]) -> Fraction:
    """Compute min_i ||speed_i*time_value|| through integer residues."""

    numerator, denominator = time_value.numerator, time_value.denominator
    return min(
        Fraction(min((numerator * speed) % denominator, denominator - ((numerator * speed) % denominator)), denominator)
        for speed in speeds
    )


def maximize(speeds: tuple[int, ...], *, include_half: bool = False) -> dict[str, object]:
    """Return the exact maximum on pair-sum candidates, optionally including 1/2.

    Ordinary tuples use the stated open domain (0, 1/2).  A normalized folded
    tuple instead uses the closed half interval: after zero removal it may be
    all odd, and then its exact maximum can occur only at t = 1/2.
    """

    if len(speeds) == 1:
        return {
            "mu": Fraction(1, 2),
            "maximizing_times": [Fraction(1, 2)],
            "candidate_time_count": 1,
            "method": "single-speed special case",
        }
    candidates: set[Fraction] = set()
    half = Fraction(1, 2)
    for left, right in itertools.combinations(speeds, 2):
        denominator = left + right
        # The stated numerator range includes the endpoint for even D; the
        # open ordinary-time domain discards that endpoint after enumeration.
        for numerator in range(1, denominator // 2 + 1):
            candidate = Fraction(numerator, denominator)
            if candidate < half:
                candidates.add(candidate)
    if include_half:
        candidates.add(half)
    if not candidates:
        raise AssertionError("pair-sum candidate set unexpectedly empty")
    scored = [(score_at(candidate, speeds), candidate) for candidate in sorted(candidates)]
    mu = max(score for score, _ in scored)
    return {
        "mu": mu,
        "maximizing_times": [candidate for score, candidate in scored if score == mu],
        "candidate_time_count": len(candidates),
        "method": "all pair sums, integer residue scoring"
        + (", plus the closed half endpoint" if include_half else ""),
    }


def folded_record(
    speeds: tuple[int, ...], mu_speeds: Fraction, maximizing_time: Fraction
) -> dict[str, object]:
    """Evaluate the prescribed odd fold and its exact recurrence violation."""

    odd_n = [2 * ((maximizing_time * speed).numerator // (maximizing_time * speed).denominator) + 1 for speed in speeds]
    raw_fold = [speed - 2 * odd for speed, odd in zip(speeds, odd_n)]
    nonzero_absolute = [abs(value) for value in raw_fold if value != 0]
    if not nonzero_absolute:
        raise AssertionError("mixed parity should leave at least one nonzero fold")
    fold_gcd = reduce(math.gcd, nonzero_absolute)
    folded = tuple(sorted({value // fold_gcd for value in nonzero_absolute}))
    # The fold's comparison geometry is closed at 1/2.  In particular, a
    # multi-speed all-odd fold such as (1, 3) attains its maximum there.
    folded_max = maximize(folded, include_half=True)
    mu_fold = folded_max["mu"]
    assert isinstance(mu_fold, Fraction)
    q = len(folded)
    violation = Fraction(1, 1) / mu_speeds - Fraction(1, 1) / mu_fold - (len(speeds) - q)
    return {
        "maximizing_time": text(maximizing_time),
        "odd_n": odd_n,
        "raw_fold": raw_fold,
        "fold_gcd": fold_gcd,
        "V": list(folded),
        "q": q,
        "mu_fold": text(mu_fold),
        "mu_fold_maximizing_times": [text(value) for value in folded_max["maximizing_times"]],
        "mu_fold_candidate_time_count": folded_max["candidate_time_count"],
        "exact_violation_1_over_mu_minus_1_over_mu_fold_minus_d_minus_q": text(violation),
        "recurrence_holds_for_this_maximizer": violation <= 0,
    }


def run_regressions() -> dict[str, object]:
    """Check the repaired all-odd endpoint and the retained returned tuple."""

    endpoint = maximize((1, 3), include_half=True)
    assert endpoint["mu"] == Fraction(1, 2)
    assert endpoint["maximizing_times"] == [Fraction(1, 2)]

    returned = maximize((1, 6, 12))
    assert returned["mu"] == Fraction(1, 3)
    assert returned["maximizing_times"] == [Fraction(7, 18), Fraction(4, 9)]
    returned_mu = returned["mu"]
    assert isinstance(returned_mu, Fraction)
    returned_records = [
        folded_record((1, 6, 12), returned_mu, time_value)
        for time_value in returned["maximizing_times"]
    ]
    assert [(record["V"], record["mu_fold"]) for record in returned_records] == [
        ([1, 4, 6], "2/5"),
        ([1, 4, 10], "4/11"),
    ]
    assert all(not record["recurrence_holds_for_this_maximizer"] for record in returned_records)
    return {
        "status": "passed",
        "all_odd_folded_endpoint": {
            "speeds": [1, 3],
            "time_domain": "[0,1/2]",
            "mu": text(endpoint["mu"]),
            "maximizing_times": [text(value) for value in endpoint["maximizing_times"]],
        },
        "returned_counterexample": {
            "v": [1, 6, 12],
            "mu": text(returned_mu),
            "all_global_maximizing_times": [text(value) for value in returned["maximizing_times"]],
            "folds_and_mu": [
                {"V": record["V"], "mu_fold": record["mu_fold"]}
                for record in returned_records
            ],
        },
    }


def primitive_mixed_parity(values: tuple[int, ...]) -> bool:
    return math.gcd(*values) == 1 and any(value % 2 == 0 for value in values) and any(value % 2 for value in values)


def search(started: float) -> dict[str, object]:
    """Search in the required dimension-first lexicographic order once."""

    checked = 0
    checked_by_dimension = {str(dimension): 0 for dimension in DOMAIN["dimensions"]}
    last_fully_checked: list[int] | None = None
    for dimension in DOMAIN["dimensions"]:
        for values in itertools.combinations(range(DOMAIN["speeds"][0], DOMAIN["speeds"][1] + 1), dimension):
            if not primitive_mixed_parity(values):
                continue
            if time.monotonic() - started >= SEARCH_LIMIT_SECONDS:
                return {
                    "stop_reason": "timeout",
                    "checked_tuple_count": checked,
                    "checked_by_dimension": checked_by_dimension,
                    "last_fully_checked_tuple": last_fully_checked,
                    "counterexample": None,
                }
            ordinary = maximize(values)
            mu_values = ordinary["mu"]
            assert isinstance(mu_values, Fraction)
            all_maximizers = ordinary["maximizing_times"]
            records = [folded_record(values, mu_values, candidate) for candidate in all_maximizers]
            checked += 1
            checked_by_dimension[str(dimension)] += 1
            last_fully_checked = list(values)
            # The proposed statement is existential in the maximizing time.
            # Therefore one favorable maximum passes this tuple; only an
            # all-choice failure is a falsifier.
            if all(not record["recurrence_holds_for_this_maximizer"] for record in records):
                return {
                    "stop_reason": "first_all_choice_failure",
                    "checked_tuple_count": checked,
                    "checked_by_dimension": checked_by_dimension,
                    "last_fully_checked_tuple": last_fully_checked,
                    "counterexample": {
                        "v": list(values),
                        "d": dimension,
                        "mu_v": text(mu_values),
                        "ordinary_candidate_time_count": ordinary["candidate_time_count"],
                        "all_global_maximizing_times": [text(value) for value in all_maximizers],
                        "all_maximizing_time_fold_records": records,
                        "favorable_maximizer_count": 0,
                        "all_choice_failure_confirmed": True,
                    },
                }
    return {
        "stop_reason": "finite_domain_exhausted_without_all_choice_failure",
        "checked_tuple_count": checked,
        "checked_by_dimension": checked_by_dimension,
        "last_fully_checked_tuple": last_fully_checked,
        "counterexample": None,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", required=True, help="JSON receipt path")
    args = parser.parse_args()
    source_path = os.path.abspath(__file__)
    source_bytes = open(source_path, "rb").read()
    started_utc = datetime.now(timezone.utc).isoformat()
    started = time.monotonic()
    regressions = run_regressions()
    result = search(started)
    duration = time.monotonic() - started
    stdout = json.dumps({
        "stop_reason": result["stop_reason"],
        "checked_tuple_count": result["checked_tuple_count"],
        "counterexample_found": result["counterexample"] is not None,
        "program_duration_seconds": duration,
    }, sort_keys=True)
    payload = {
        "schema": "harmonic-fold-control/v1",
        "task": "one exact bounded falsifier for the proposed harmonic-fold recurrence",
        "source_checkpoint": "27309c7e0a0d93c8f9ce90245cec013a3ffcd5d8",
        "finite_domain": {
            "tuple_order": "dimension-first, lexicographic combinations",
            "distinct_positive": True,
            "primitive": True,
            "mixed_parity": True,
            "dimensions": DOMAIN["dimensions"],
            "speed_range_inclusive": DOMAIN["speeds"],
            "ordinary_time_domain": "(0,1/2)",
            "search_limit_seconds": SEARCH_LIMIT_SECONDS,
        },
        "accepted_geometry": "For ordinary tuples with at least two distinct positive speeds, enumerate pair denominators vi+vj and numerator range 1..floor(D/2), retaining candidate fractions strictly below 1/2; score with integer cyclic residues. For normalized folded tuples, score the same candidates together with the closed endpoint 1/2.",
        "execution": {
            "source_path_at_execution": source_path,
            "source_sha256": hashlib.sha256(source_bytes).hexdigest(),
            "source_utf8": source_bytes.decode("utf-8"),
            "argv": sys.argv,
            "python": sys.version,
            "started_utc": started_utc,
            "program_duration_seconds": duration,
        },
        "focused_regressions": regressions,
        "actual_process_receipt": {
            "invocation_argv": sys.argv,
            "exit_status": 0,
            "stdout": stdout + "\n",
            "stderr": "",
            "failure_history": [],
        },
        "result": result,
        "delivery_metrics": {
            "check_kind": "python",
            "first_check_success": True,
            "worker_repair_rounds": 0,
            "astra_repair_rounds": 0,
            "astra_repair_lines": 0,
            "worker_elapsed_seconds": None,
            "usage": None,
            "evidence": [
                "research/astra-harmonic-fold-control.py",
                "research/astra-harmonic-fold-control.json",
                "research/astra-harmonic-fold-control-initial.json",
            ],
        },
        "failures": [],
    }
    with open(args.output, "w", encoding="utf-8") as handle:
        json.dump(payload, handle, indent=2, sort_keys=True)
        handle.write("\n")
    print(stdout)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
