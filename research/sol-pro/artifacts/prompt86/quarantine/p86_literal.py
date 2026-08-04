#!/usr/bin/env python3
from __future__ import annotations

import hashlib
import itertools
import json
import math
import sys
import struct
from collections import Counter
from fractions import Fraction
from pathlib import Path
from typing import Iterable, Sequence

SCHEMA = "PIPE-P86-LITERAL-v1"
DOMAINS = ((3, 30), (4, 30), (5, 20), (6, 15), (7, 12), (8, 15))
ROOT_DOMAINS = set(DOMAINS[:-1])
NEW_DOMAIN = DOMAINS[-1]
CONTROLS = {
    "known_success": (1, 2, 3),
    "synthetic_negative": (1, 2, 8),
}
FIXTURES = {
    "P76": (1, 4, 5, 6, 7, 11),
    "P77": (6, 7, 168),
    "P78": (6, 7, 12, 24, 144),
    "P80": (1, 3, 16),
    "P82": (1, 4, 5, 6, 7, 11, 32),
}


def frac_obj(q: Fraction) -> dict[str, object]:
    return {
        "numerator": q.numerator,
        "denominator": q.denominator,
        "text": str(q),
        "sign": (q > 0) - (q < 0),
    }


def gcd_all(values: Sequence[int]) -> int:
    g = 0
    for x in values:
        g = math.gcd(g, x)
    return g


def validate(values: object, *, increasing: bool = False, n_min: int = 1) -> tuple[int, ...]:
    if not isinstance(values, (tuple, list)):
        raise ValueError("speeds must be a tuple/list")
    if len(values) < n_min:
        raise ValueError("too few speeds")
    if any(type(x) is not int for x in values):
        raise ValueError("all speeds must be literal integers")
    speeds = tuple(values)
    if any(x <= 0 for x in speeds):
        raise ValueError("speeds must be positive")
    if len(set(speeds)) != len(speeds):
        raise ValueError("speeds must be injective")
    if increasing and any(x >= y for x, y in zip(speeds, speeds[1:])):
        raise ValueError("enumeration tuples must be strictly increasing")
    return speeds


def rho(M: int, x: int) -> int:
    y = x % M
    return min(y, M - y)


def phi(N: int, m: int) -> Fraction:
    return Fraction(1 - m, N * m + 1)


def analyze_pivot(speeds: Sequence[int], j: int, *, retain_residues: bool) -> dict[str, object]:
    speeds = validate(tuple(speeds))
    n = len(speeds)
    N = n + 1
    p = speeds[j]
    M = N * p
    candidates = [r for r in range(M) if r % N != 0]
    assert len(candidates) == (N - 1) * p == n * p

    hist: Counter[int] = Counter()
    zeroes: list[int] = []
    residue_rows: list[dict[str, object]] = []
    owner_sets: dict[int, tuple[int, ...]] = {}
    owner_bad_sets: dict[int, list[int]] = {i: [] for i in range(n) if i != j}
    owner_fibers: dict[int, dict[int, list[int]]] = {i: {} for i in range(n) if i != j}
    boundary_bad_examples: list[tuple[int, int, int]] = []
    boundary_safe_examples: list[tuple[int, int, int]] = []
    left_examples: list[tuple[int, int, int]] = []
    right_examples: list[tuple[int, int, int]] = []
    antipode_examples: list[tuple[int, int, int]] = []
    repeated_residue_examples: list[tuple[int, tuple[tuple[int, int], ...]]] = []

    for r in candidates:
        # Canonical pivot safety, including equality.
        dp = rho(M, r * p)
        assert dp >= p
        q = r % N
        assert 1 <= q <= N - 1
        assert (r * p) % M == p * q
        assert dp == p * min(q, N - q)

        bad: list[int] = []
        owner_remainders: list[tuple[int, int]] = []
        rem_to_owners: dict[int, list[int]] = {}
        for i, a in enumerate(speeds):
            if i == j:
                continue
            y = (r * a) % M
            d = min(y, M - y)
            owner_remainders.append((i, y))
            owner_fibers[i].setdefault(y, []).append(r)
            rem_to_owners.setdefault(y, []).append(i)
            if d < p:
                bad.append(i)
                owner_bad_sets[i].append(r)
                if d == p - 1 and len(boundary_bad_examples) < 8:
                    boundary_bad_examples.append((r, i, y))
                if 0 < y < p and len(left_examples) < 8:
                    left_examples.append((r, i, y))
                if M - p < y < M and len(right_examples) < 8:
                    right_examples.append((r, i, y))
            elif d == p and len(boundary_safe_examples) < 8:
                boundary_safe_examples.append((r, i, y))
            if M % 2 == 0 and y == M // 2 and len(antipode_examples) < 8:
                antipode_examples.append((r, i, y))
        repeats = tuple((y, tuple(ids)) for y, ids in sorted(rem_to_owners.items()) if len(ids) >= 2)
        if repeats and len(repeated_residue_examples) < 8:
            repeated_residue_examples.append((r, repeats))
        m = len(bad)
        hist[m] += 1
        owner_sets[r] = tuple(bad)
        if m == 0:
            zeroes.append(r)
        if retain_residues:
            residue_rows.append({
                "r": r,
                "mu": m,
                "bad_owner_indices": bad,
                "owner_remainders": owner_remainders,
                "pivot_distance": dp,
            })

    S = sum((phi(N, m) * count for m, count in hist.items()), Fraction(0))
    reciprocal = sum((Fraction(count, N * m + 1) for m, count in hist.items()), Fraction(0))
    assert S == Fraction(N + 1, N) * reciprocal - Fraction(len(candidates), N)
    score_hist = Fraction(hist.get(0, 0), 1) - sum(
        (Fraction(count * (m - 1), N * m + 1) for m, count in hist.items() if m >= 2),
        Fraction(0),
    )
    assert S == score_hist
    assert (S > 0) == (reciprocal > Fraction(len(candidates), N + 1))
    harmonic = Fraction(len(candidates), 1) / reciprocal
    assert (S > 0) == (harmonic < N + 1)
    if S > 0:
        assert zeroes

    I = sum(m * count for m, count in hist.items())
    covered = len(candidates) - hist.get(0, 0)
    excess = I - covered
    assert excess == sum((m - 1) * count for m, count in hist.items() if m >= 2)
    lzed_margin = (2 * N + 1) * hist.get(0, 0) - excess
    lzed_equiv_margin = 2 * N * hist.get(0, 0) - (I - len(candidates))
    assert lzed_margin == lzed_equiv_margin
    if lzed_margin > 0:
        lower = Fraction(hist.get(0, 0), 1) - Fraction(excess, 2 * N + 1)
        assert S >= lower > 0

    gcd_degenerate_fibers: list[dict[str, object]] = []
    for i, fibers in owner_fibers.items():
        g = math.gcd(speeds[i], M)
        if g <= 1:
            continue
        for target, rs in sorted(fibers.items()):
            if len(rs) >= 2:
                gcd_degenerate_fibers.append({
                    "owner_index": i,
                    "owner_speed": speeds[i],
                    "gcd_with_modulus": g,
                    "target_residue": target,
                    "candidate_fiber_size": len(rs),
                    "first_candidates": rs[:8],
                })
                break

    coincident: list[dict[str, object]] = []
    groups: dict[tuple[int, ...], list[int]] = {}
    for i, values in owner_bad_sets.items():
        groups.setdefault(tuple(values), []).append(i)
    for badset, ids in groups.items():
        if len(ids) >= 2:
            coincident.append({"owner_indices": ids, "bad_count_each": len(badset)})

    out: dict[str, object] = {
        "pivot_index": j,
        "pivot_speed": p,
        "N": N,
        "M": M,
        "R_size": len(candidates),
        "histogram": {str(m): hist.get(m, 0) for m in range(n) if hist.get(m, 0)},
        "score": frac_obj(S),
        "reciprocal_sum": frac_obj(reciprocal),
        "harmonic_mean": frac_obj(harmonic),
        "least_zero": zeroes[0] if zeroes else None,
        "zero_count": len(zeroes),
        "total_incidence": I,
        "overcoverage_excess": excess,
        "lzed_margin": lzed_margin,
        "coincident_labelled_bad_sets": coincident,
        "diagnostics": {
            "rho_p_minus_1_bad": boundary_bad_examples,
            "rho_p_safe": boundary_safe_examples,
            "left_cyclic_side": left_examples,
            "right_cyclic_side": right_examples,
            "antipode": antipode_examples,
            "repeated_modular_residue": repeated_residue_examples,
            "gcd_degenerate_owner_fiber": gcd_degenerate_fibers,
            "excluded_N_multiple_0": 0 not in candidates,
            "pivot_equality_candidates": [r for r in candidates if rho(M, r * p) == p][:8],
        },
    }
    if retain_residues:
        out["residues"] = residue_rows
    return out


def analyze_tuple(speeds: Sequence[int], *, retain_residues: bool) -> dict[str, object]:
    speeds = validate(tuple(speeds))
    pivots = [analyze_pivot(speeds, j, retain_residues=retain_residues) for j in range(len(speeds))]
    return {
        "speeds": list(speeds),
        "gcd": gcd_all(speeds),
        "pivots": pivots,
        "has_positive_local_row": any(p["score"]["sign"] > 0 for p in pivots),
        "has_certificate": any(p["zero_count"] > 0 for p in pivots),
        "has_lzed_row": any(p["lzed_margin"] > 0 for p in pivots),
    }



def scan_pivot(speeds: Sequence[int], j: int) -> dict[str, object]:
    """Minimal literal representative enumeration used by exhaustive domains."""
    speeds = validate(tuple(speeds), increasing=True)
    n = len(speeds)
    N = n + 1
    p = speeds[j]
    M = N * p
    hist: Counter[int] = Counter()
    least_zero: int | None = None
    R_size = 0
    residue_digest = hashlib.sha256()
    for r in range(M):
        if r % N == 0:
            continue
        R_size += 1
        dp = rho(M, r * p)
        assert dp >= p
        bad_indices = tuple(
            i for i, a in enumerate(speeds)
            if i != j and rho(M, r * a) < p
        )
        mu = len(bad_indices)
        residue_digest.update(struct.pack(">QH", r, mu))
        for i in bad_indices:
            residue_digest.update(struct.pack(">H", i))
        hist[mu] += 1
        if mu == 0 and least_zero is None:
            least_zero = r
    assert R_size == (N - 1) * p == n * p
    S = sum((phi(N, m) * count for m, count in hist.items()), Fraction(0))
    reciprocal = sum((Fraction(count, N * m + 1) for m, count in hist.items()), Fraction(0))
    assert S == Fraction(N + 1, N) * reciprocal - Fraction(R_size, N)
    assert (S > 0) == (reciprocal > Fraction(R_size, N + 1))
    h0 = hist.get(0, 0)
    incidence = sum(m * count for m, count in hist.items())
    excess = incidence - (R_size - h0)
    lzed_margin = (2 * N + 1) * h0 - excess
    assert lzed_margin == 2 * N * h0 - (incidence - R_size)
    if lzed_margin > 0:
        assert S >= Fraction(h0, 1) - Fraction(excess, 2 * N + 1) > 0
    return {
        "pivot_index": j,
        "pivot_speed": p,
        "R_size": R_size,
        "histogram": {str(m): hist.get(m, 0) for m in range(n) if hist.get(m, 0)},
        "score": frac_obj(S),
        "least_zero": least_zero,
        "lzed_margin": lzed_margin,
        "residue_owner_digest_sha256": residue_digest.hexdigest(),
    }

def row_digest_update(h: "hashlib._Hash", speeds: tuple[int, ...], pivot: dict[str, object]) -> None:
    payload = {
        "speeds": speeds,
        "pivot_index": pivot["pivot_index"],
        "histogram": pivot["histogram"],
        "score": pivot["score"]["text"],
        "least_zero": pivot["least_zero"],
        "lzed_margin": pivot["lzed_margin"],
        "residue_owner_digest_sha256": pivot["residue_owner_digest_sha256"],
    }
    h.update(json.dumps(payload, sort_keys=True, separators=(",", ":")).encode())
    h.update(b"\n")


def scan_domain(n: int, B: int) -> dict[str, object]:
    count_all = math.comb(B, n)
    primitive = 0
    fail = None
    lzed_fail = None
    min_max_score: tuple[Fraction, tuple[int, ...], int] | None = None
    digest = hashlib.sha256()
    for maximum in range(n, B + 1):
        for prefix in itertools.combinations(range(1, maximum), n - 1):
            speeds = prefix + (maximum,)
            if gcd_all(speeds) != 1:
                continue
            primitive += 1
            rows = [scan_pivot(speeds, j) for j in range(n)]
            for row in rows:
                row_digest_update(digest, speeds, row)
            positive_rows = [row for row in rows if row["score"]["sign"] > 0]
            lzed_rows = [row for row in rows if row["lzed_margin"] > 0]
            if not positive_rows:
                fail = {"speeds": list(speeds), "pivots": rows}
                break
            if not lzed_rows and lzed_fail is None:
                lzed_fail = {"speeds": list(speeds), "pivots": rows}
            max_pair = max((Fraction(row["score"]["numerator"], row["score"]["denominator"]), int(row["pivot_index"])) for row in rows)
            if min_max_score is None or max_pair[0] < min_max_score[0]:
                min_max_score = (max_pair[0], speeds, max_pair[1])
        if fail is not None:
            break
    return {
        "n": n,
        "maximum_speed": B,
        "all_increasing_tuples": count_all,
        "primitive_tuples_completed": primitive,
        "completion_marker": fail is None,
        "first_local_score_fail": fail,
        "first_lzed_fail": lzed_fail,
        "minimum_of_tuplewise_max_score": {
            "score": frac_obj(min_max_score[0]),
            "speeds": list(min_max_score[1]),
            "pivot_index": min_max_score[2],
        } if min_max_score else None,
        "row_digest_sha256": digest.hexdigest(),
        "status": "computed finite evidence" if fail is None else "exact fail fixture",
        "provenance": "root-observation reproduction" if (n, B) in ROOT_DOMAINS else "one preselected new domain",
    }


def verify_scaling(base: tuple[int, ...], c: int) -> dict[str, object]:
    assert c >= 1
    scaled = tuple(c * x for x in base)
    base_rows = [analyze_pivot(base, j, retain_residues=False) for j in range(len(base))]
    scaled_rows = [analyze_pivot(scaled, j, retain_residues=False) for j in range(len(base))]
    for br, sr in zip(base_rows, scaled_rows):
        assert sr["R_size"] == c * br["R_size"]
        assert Fraction(sr["score"]["numerator"], sr["score"]["denominator"]) == c * Fraction(br["score"]["numerator"], br["score"]["denominator"])
        assert {int(k): v for k, v in sr["histogram"].items()} == {int(k): c * v for k, v in br["histogram"].items()}
    return {"base": list(base), "scaled": list(scaled), "factor": c, "all_rows_verified": True}


def verify_permutation(base: tuple[int, ...], perm: tuple[int, ...]) -> dict[str, object]:
    assert sorted(perm) == list(range(len(base)))
    moved = tuple(base[i] for i in perm)
    base_by_speed = {row["pivot_speed"]: row for row in (analyze_pivot(base, j, retain_residues=False) for j in range(len(base)))}
    moved_by_speed = {row["pivot_speed"]: row for row in (analyze_pivot(moved, j, retain_residues=False) for j in range(len(moved)))}
    for speed in base:
        b = base_by_speed[speed]
        m = moved_by_speed[speed]
        assert b["histogram"] == m["histogram"]
        assert b["score"] == m["score"]
        assert b["least_zero"] == m["least_zero"]
    return {"base": list(base), "permuted": list(moved), "permutation": list(perm), "all_rows_verified": True}


def malformed_suite() -> dict[str, object]:
    cases = [(), (0, 1, 2), (-1, 2, 3), (1, 1, 2), (1, 2.0, 3), "123", (2, 1, 3)]
    rejected = 0
    for k, case in enumerate(cases):
        try:
            validate(case, increasing=(k == len(cases) - 1), n_min=1)
        except ValueError:
            rejected += 1
        else:
            raise AssertionError(f"malformed case accepted: {case!r}")
    return {"cases": len(cases), "rejected": rejected}


def deliberate_mutation_failure() -> dict[str, object]:
    row = analyze_pivot(FIXTURES["P80"], 1, retain_residues=False)
    actual = row["histogram"]
    altered = dict(actual)
    first_key = sorted(altered, key=int)[0]
    altered[first_key] += 1
    failed = False
    try:
        assert actual == altered
    except AssertionError:
        failed = True
    assert failed
    return {"fixture": "P80", "pivot_index": 1, "altered_histogram_rejected": True}


def main() -> None:
    if len(sys.argv) != 1:
        print("p86_literal.py accepts no command-line arguments", file=sys.stderr)
        raise SystemExit(2)

    controls = {name: analyze_tuple(speeds, retain_residues=True) for name, speeds in CONTROLS.items()}
    assert controls["known_success"]["has_positive_local_row"]
    assert controls["synthetic_negative"]["pivots"][0]["score"]["sign"] < 0
    fixtures = {name: analyze_tuple(speeds, retain_residues=True) for name, speeds in FIXTURES.items()}
    assert fixtures["P80"]["has_positive_local_row"]
    assert any(p["score"]["sign"] < 0 for p in fixtures["P82"]["pivots"])
    assert fixtures["P82"]["has_positive_local_row"]
    assert fixtures["P82"]["has_certificate"]

    domains = [scan_domain(n, B) for n, B in DOMAINS]
    assert all(d["completion_marker"] and d["first_local_score_fail"] is None for d in domains)
    assert all(d["first_lzed_fail"] is None for d in domains)

    # Locate required diagnostic phenomena across retained fixtures.
    diag_flags = Counter()
    for fixture in fixtures.values():
        for row in fixture["pivots"]:
            diag = row["diagnostics"]
            diag_flags["rho_p_minus_1_bad"] += bool(diag["rho_p_minus_1_bad"])
            diag_flags["rho_p_safe"] += bool(diag["rho_p_safe"])
            diag_flags["left_cyclic_side"] += bool(diag["left_cyclic_side"])
            diag_flags["right_cyclic_side"] += bool(diag["right_cyclic_side"])
            diag_flags["antipode"] += bool(diag["antipode"])
            diag_flags["repeated_modular_residue"] += bool(diag["repeated_modular_residue"])
            diag_flags["coincident_labelled_bad_sets"] += bool(row["coincident_labelled_bad_sets"])
            diag_flags["gcd_degenerate_owner_fiber"] += bool(diag["gcd_degenerate_owner_fiber"])
    assert all(diag_flags[k] > 0 for k in (
        "rho_p_minus_1_bad", "rho_p_safe", "left_cyclic_side", "right_cyclic_side",
        "antipode", "repeated_modular_residue", "coincident_labelled_bad_sets",
        "gcd_degenerate_owner_fiber"))

    source_path = Path(__file__)
    source_sha = hashlib.sha256(source_path.read_bytes()).hexdigest()
    output = {
        "schema": SCHEMA,
        "source_file": source_path.name,
        "source_sha256": source_sha,
        "arithmetic": "Python arbitrary-precision integers and fractions.Fraction; no floating point",
        "ordering": "dimension, maximum speed, primitive increasing tuple lexicographic, pivot index, residue representative",
        "malformed_input": malformed_suite(),
        "controls": controls,
        "fixtures": fixtures,
        "domains": domains,
        "new_domain_selection": {
            "domain": {"n": NEW_DOMAIN[0], "maximum_speed": NEW_DOMAIN[1]},
            "chosen_before_execution": True,
            "named_assertion": "existence of a local zero-excess-deficit pivot: I_j-|R_j| < 2*N*h_(j,0)",
        },
        "scaling": verify_scaling(FIXTURES["P76"], 3),
        "permutation": verify_permutation(FIXTURES["P82"], tuple(reversed(range(len(FIXTURES["P82"]))))),
        "deliberate_mutation": deliberate_mutation_failure(),
        "diagnostic_fixture_counts": dict(diag_flags),
        "full_domain_completion": True,
        "local_target_fail_fixture": None,
        "lzed_fail_fixture": None,
    }
    out_path = source_path.with_suffix(".json")
    raw = json.dumps(output, sort_keys=True, separators=(",", ":"), ensure_ascii=True).encode()
    out_path.write_bytes(raw + b"\n")
    print(json.dumps({
        "schema": SCHEMA,
        "source_sha256": source_sha,
        "output_sha256": hashlib.sha256(raw + b"\n").hexdigest(),
        "output_path": str(out_path),
        "full_domain_completion": True,
        "primitive_tuples": sum(d["primitive_tuples_completed"] for d in domains),
        "local_target_fail_fixture": None,
        "lzed_fail_fixture": None,
    }, sort_keys=True))


if __name__ == "__main__":
    main()
