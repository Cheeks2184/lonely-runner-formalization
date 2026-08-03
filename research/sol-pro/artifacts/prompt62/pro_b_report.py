#!/usr/bin/env python3
"""Build the deterministic Prompt 62 PRO-B exact audit report."""
from __future__ import annotations

import hashlib
import itertools
import os
import platform
import subprocess
import sys
from collections import Counter, defaultdict
from math import comb, gcd
from pathlib import Path

ROOT = Path(__file__).resolve().parent
OUTPUT = ROOT / "pro_b_literal.out"
MANIFEST = ROOT / "pro_b_manifest.txt"
REPORT = ROOT / "pro_b_sweep_report.txt"
VERSION = "PROB-62-v1.0.0"

sys.path.insert(0, str(ROOT))
from pro_b_top_two_literal import (  # noqa: E402
    affine_score_literal,
    pivot_data,
    residual_flag,
    rho,
    slice_score,
)


def sha256(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for block in iter(lambda: f.read(1 << 20), b""):
            h.update(block)
    return h.hexdigest()


def source_bundle_hash(paths: list[Path]) -> str:
    h = hashlib.sha256()
    for path in sorted(paths, key=lambda p: p.name):
        h.update(f"FILE:{path.name}\n".encode())
        h.update(path.read_bytes())
        h.update(b"\nEND\n")
    return h.hexdigest()


def parse_rows():
    rows = []
    for line in OUTPUT.read_text(encoding="utf-8").splitlines():
        if not line or line.startswith("#"):
            continue
        f = line.split("|")
        assert len(f) == 28
        rows.append({
            "id": f[0], "cat": f[1], "name": f[2],
            "speeds": tuple(map(int, f[3].split(","))),
            "N": int(f[4]), "A": int(f[5]), "B": int(f[6]),
            "safeA": int(f[7]), "firstA": int(f[8]),
            "safeB": int(f[9]), "firstB": int(f[10]),
            "fq2A": int(f[11]), "fq3A": int(f[12]),
            "fq2B": int(f[13]), "fq3B": int(f[14]),
            "rhA": tuple(map(int, f[15].split(","))),
            "rq2A": int(f[16]), "rq3A": int(f[17]),
            "rhB": tuple(map(int, f[18].split(","))),
            "rq2B": int(f[19]), "rq3B": int(f[20]),
            "slice": int(f[21]),
            "defs": tuple(map(int, f[22].split(","))) if f[22] else (),
            "aff": int(f[23]), "h": int(f[24]),
            "P": int(f[25]), "U": int(f[26]), "res": int(f[27]),
        })
    return rows


def gcd_many(*xs: int) -> int:
    g = 0
    for x in xs:
        g = gcd(g, x)
    return g


def target_set(M: int, A: int) -> tuple[int, ...]:
    return tuple(x for x in range(M) if rho(M, x) < A)


def candidate_count_crt(N: int, A: int, coeffs: tuple[int, ...], targets: tuple[int, ...]) -> int:
    M = N * A
    assert coeffs and len(coeffs) == len(targets)

    def compatible(modulus_factor: int, divisibility: int) -> bool:
        if any(t % divisibility for t in targets):
            return False
        modulus = M * modulus_factor
        return all(
            (coeffs[q] * targets[p] - coeffs[p] * targets[q]) % modulus == 0
            for p in range(len(coeffs)) for q in range(p + 1, len(coeffs))
        )

    g = gcd_many(M, *coeffs)
    unrestricted = g if compatible(g, g) else 0
    h = gcd_many(A, *coeffs)
    excluded = h if compatible(h, N * h) else 0
    assert unrestricted >= excluded
    return unrestricted - excluded


def intersection_crt(speeds: tuple[int, ...], pivot: int, runners: tuple[int, ...]) -> int:
    N = len(speeds) + 1
    A = speeds[pivot]
    T = target_set(N * A, A)
    coeffs = tuple(speeds[i] for i in runners)
    return sum(
        candidate_count_crt(N, A, coeffs, targets)
        for targets in itertools.product(T, repeat=len(runners))
    )


def intersection_literal(speeds: tuple[int, ...], pivot: int, runners: tuple[int, ...]) -> int:
    N = len(speeds) + 1
    A = speeds[pivot]
    M = N * A
    return sum(
        r % N != 0 and all(rho(M, speeds[i] * r) < A for i in runners)
        for r in range(M)
    )


def crt_audit() -> int:
    checked = 0
    for n in range(2, 5):
        for speeds in itertools.combinations(range(1, 10), n):
            for pivot in (n - 2, n - 1):
                others = tuple(i for i in range(n) if i != pivot)
                for q in range(1, min(3, len(others)) + 1):
                    for runners in itertools.combinations(others, q):
                        lhs = intersection_crt(speeds, pivot, runners)
                        rhs = intersection_literal(speeds, pivot, runners)
                        assert lhs == rhs, (speeds, pivot, runners, lhs, rhs)
                        checked += 1
    assert checked == 2340
    return checked


def candidate_grid(N: int, P: int) -> tuple[int, ...]:
    return tuple(r for r in range(N * P) if r % N != 0)


def safe_residues(speeds: tuple[int, ...], pivot: int) -> tuple[int, ...]:
    N = len(speeds) + 1
    P = speeds[pivot]
    M = N * P
    return tuple(
        r for r in range(M) if r % N != 0 and
        all(rho(M, r * x) >= P for x in speeds)
    )


def certificate_lines(speeds: tuple[int, ...]) -> list[str]:
    n = len(speeds)
    N = n + 1
    ia, ib = n - 2, n - 1
    pa = pivot_data(speeds, ia, ib)
    pb = pivot_data(speeds, ib, ia)
    sl, defs = slice_score(pa, pb)
    af = affine_score_literal(speeds, pa, pb)
    lines = [f"tuple={speeds} n={n} N={N} A={pa.P} B={pb.P} residual={int(residual_flag(speeds))}"]
    for label, pivot, pd in (("A", ia, pa), ("B", ib, pb)):
        C = candidate_grid(N, pd.P)
        safe = safe_residues(speeds, pivot)
        assert safe == pd.safe
        lines.append(f"  C_{label}={C}")
        lines.append(f"  safe_{label}={safe}")
        if safe:
            r = safe[0]
            M = N * pd.P
            d = tuple(rho(M, r * x) for x in speeds)
            lines.append(f"  witness_{label}: r={r} modulus={M} distances={d}")
        lines.append(
            f"  scores_{label}: fullH={pd.fullH} fullQ2={pd.fullQ2} fullQ3={pd.fullQ3} "
            f"robustH={pd.robustH} robustQ2={pd.robustQ2} robustQ3={pd.robustQ3}"
        )
    lines.append(f"  slice: best={sl} deficits={defs}")
    lines.append(f"  affine: margin={af[0]} h={af[1]} pairs={af[2]} union={af[3]}")
    return lines


def key(r):
    return (len(r["speeds"]), max(r["speeds"]), r["speeds"])


def main() -> None:
    rows = parse_rows()
    assert len(rows) == 8108
    assert all(r["safeA"] > 0 or r["safeB"] > 0 for r in rows)
    crt_checked = crt_audit()

    criteria = {
        "FULL_QUADRATIC": lambda r: r["fq2A"] > 0 or r["fq2B"] > 0,
        "FULL_CUBIC_BONFERRONI": lambda r: r["fq3A"] > 0 or r["fq3B"] > 0,
        "ROBUST_QUADRATIC": lambda r: r["rq2A"] > 0 or r["rq2B"] > 0,
        "ROBUST_CUBIC": lambda r: r["rq3A"] > 0 or r["rq3B"] > 0,
        "QUOTIENT_SLICE_DUAL": lambda r: r["slice"] > 0,
        "UNWEIGHTED_AFFINE_UNION": lambda r: r["aff"] > 0,
    }

    source_paths = [
        ROOT / "generate_manifest.py",
        ROOT / "pro_b_top_two_literal.py",
        ROOT / "pro_b_top_two_optimized.cpp",
        ROOT / "pro_b_report.py",
        ROOT / "pro_b_affine_hard_verifier.py",
    ]
    bundle_hash = source_bundle_hash(source_paths)
    manifest_hash = sha256(MANIFEST)
    output_hash = sha256(OUTPUT)
    opt_hash = sha256(ROOT / "pro_b_optimized.out")
    assert output_hash == opt_hash

    counts = Counter(r["cat"] for r in rows)
    by_cat = defaultdict(list)
    for r in rows:
        by_cat[r["cat"]].append(r)

    pyver = platform.python_version()
    gpp = subprocess.check_output(["g++", "--version"], text=True).splitlines()[0]
    literal_time = (ROOT / "literal.time").read_text().strip().replace("\n", " ")
    optimized_time = (ROOT / "optimized.time").read_text().strip().replace("\n", " ")
    affine_hard_time = (ROOT / "affine_hard.time").read_text().strip().replace("\n", " ")
    affine_hard_hash = sha256(ROOT / "pro_b_affine_hard.out")

    out: list[str] = []
    out.append("PROMPT 62 PRO-B EXACT SWEEP REPORT")
    out.append(f"version={VERSION}")
    out.append(f"python={pyver}")
    out.append(f"compiler={gpp}")
    out.append(f"platform={platform.platform()}")
    out.append(f"source_bundle_sha256={bundle_hash}")
    out.append(f"manifest_sha256={manifest_hash}")
    out.append(f"canonical_output_sha256={output_hash}")
    out.append("literal_optimized_byte_agreement=YES")
    out.append(f"literal_timing={literal_time}")
    out.append(f"optimized_timing={optimized_time}")
    out.append(f"affine_hard_timing={affine_hard_time}")
    out.append(f"affine_hard_output_sha256={affine_hard_hash}")
    out.append(f"rows={len(rows)}")
    out.append(f"crt_literal_formula_intersections_checked={crt_checked}")
    out.append("order=manifest order; boxes are n ascending, then lexicographic combinations; finite-minimum key=(n,max_speed,lex_tuple)")
    out.append("")

    out.append("DOMAIN_COUNTS")
    for cat in sorted(counts):
        out.append(f"{cat}={counts[cat]}")
    out.append("")

    out.append("GLOBAL_RESULTS")
    out.append(f"top_two_failures={sum(not (r['safeA'] > 0 or r['safeB'] > 0) for r in rows)}")
    out.append(f"working_residual_rows={sum(r['res'] for r in rows)}")
    for name, pred in criteria.items():
        failures = [r for r in rows if not pred(r)]
        residual_failures = [r for r in rows if r["res"] and not pred(r)]
        first = min(failures, key=key) if failures else None
        rfirst = min(residual_failures, key=key) if residual_failures else None
        out.append(
            f"{name}: pass={len(rows)-len(failures)} fail={len(failures)} "
            f"finite_min={first['speeds'] if first else None} "
            f"residual_fail={len(residual_failures)} residual_finite_min={rfirst['speeds'] if rfirst else None}"
        )
    out.append("")

    out.append("STRESS_ROWS")
    for r in by_cat["stress"]:
        out.append(
            f"{r['name']} tuple={r['speeds']} top=({r['A']},{r['B']}) "
            f"safe=({r['safeA']},{r['safeB']}) fullQ2=({r['fq2A']},{r['fq2B']}) "
            f"fullQ3=({r['fq3A']},{r['fq3B']}) robustQ2=({r['rq2A']},{r['rq2B']}) "
            f"robustQ3=({r['rq3A']},{r['rq3B']}) slice={r['slice']} "
            f"affine=({r['aff']},h={r['h']},P={r['P']},U={r['U']}) residual={r['res']}"
        )
    out.append("")

    out.append("CONSECUTIVE_ROWS_COMPLETE")
    for r in by_cat["consecutive"]:
        out.append(
            f"n={len(r['speeds'])} A={r['A']} B={r['B']} safe=({r['safeA']},{r['safeB']}) "
            f"fullQ2=({r['fq2A']},{r['fq2B']}) fullQ3=({r['fq3A']},{r['fq3B']}) "
            f"robustQ2=({r['rq2A']},{r['rq2B']}) robustQ3=({r['rq3A']},{r['rq3B']}) "
            f"slice={r['slice']} affine={r['aff']}"
        )
    out.append("")

    out.append("MUTATION_AGGREGATES")
    mutation_cats = ["structured_crt", "affine_fiber", "large_gap", "saturated", "deletion"]
    for cat in mutation_cats:
        rs = by_cat[cat]
        terms = [f"count={len(rs)}", f"top_two_fail={sum(not (r['safeA'] or r['safeB']) for r in rs)}"]
        for name, pred in criteria.items():
            terms.append(f"{name}_fail={sum(not pred(r) for r in rs)}")
        out.append(cat + ": " + " ".join(terms))
    out.append("")

    out.append("FINITE_MINIMUM_REJECTED_CRITERION_CERTIFICATES")
    selected = [
        ("FULL_QUADRATIC", min((r for r in rows if not criteria["FULL_QUADRATIC"](r)), key=key)["speeds"]),
        ("FULL_CUBIC_AND_ROBUST_QUADRATIC", (1, 2, 3, 4, 5, 7)),
        ("ROBUST_CUBIC", min((r for r in rows if not criteria["ROBUST_CUBIC"](r)), key=key)["speeds"]),
        ("ROBUST_CUBIC_RESIDUAL", min((r for r in rows if r["res"] and not criteria["ROBUST_CUBIC"](r)), key=key)["speeds"]),
        ("QUOTIENT_SLICE_DUAL", min((r for r in rows if not criteria["QUOTIENT_SLICE_DUAL"](r)), key=key)["speeds"]),
        ("UNWEIGHTED_AFFINE_UNION_ABSOLUTE", min((r for r in rows if not criteria["UNWEIGHTED_AFFINE_UNION"](r)), key=key)["speeds"]),
        ("UNWEIGHTED_AFFINE_UNION_RESIDUAL", min((r for r in rows if r["res"] and not criteria["UNWEIGHTED_AFFINE_UNION"](r)), key=key)["speeds"]),
    ]
    seen = set()
    for label, speeds in selected:
        out.append(label)
        if speeds not in seen:
            out.extend(certificate_lines(speeds))
            seen.add(speeds)
        else:
            out.append(f"  tuple={speeds} (certificate printed above)")
    out.append("")

    out.append("AFFINE_HARD_INTEGRAL_TRANSVERSAL")
    out.extend((ROOT / "pro_b_affine_hard.out").read_text().strip().splitlines())
    out.append("")

    out.append("OPT_ADD_AFFINE_FAILURE_LITERAL")
    opt = next(r for r in by_cat["stress"] if r["name"] == "OPT_ADD")
    out.append(
        f"tuple={opt['speeds']} A={opt['A']} B={opt['B']} margin={opt['aff']} "
        f"h={opt['h']} pairs={opt['P']} union={opt['U']} "
        f"safe=({opt['safeA']},{opt['safeB']}) first=({opt['firstA']},{opt['firstB']})"
    )
    out.append("")

    REPORT.write_text("\n".join(out) + "\n", encoding="utf-8", newline="\n")
    print(REPORT)
    print(f"report_sha256={sha256(REPORT)}")
    print(f"source_bundle_sha256={bundle_hash}")
    print(f"manifest_sha256={manifest_hash}")
    print(f"canonical_output_sha256={output_hash}")


if __name__ == "__main__":
    main()
