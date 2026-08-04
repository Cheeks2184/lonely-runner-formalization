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

SCHEMA = "PIPE-P86-OPTIMIZED-v1"
DOMAINS = ((3, 30), (4, 30), (5, 20), (6, 15), (7, 12), (8, 15))
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


def gcd_tuple(xs: tuple[int, ...]) -> int:
    out = 0
    for x in xs:
        out = math.gcd(out, x)
    return out


def score_of_hist(N: int, hist: Counter[int]) -> Fraction:
    return sum((Fraction((1-m)*c, N*m+1) for m, c in hist.items()), Fraction())


def frac_text(x: Fraction) -> str:
    return str(x)


def row_payload(speeds: tuple[int, ...], j: int, hist: Counter[int], score: Fraction,
                least_zero: int | None, lzed_margin: int, residue_digest: str) -> bytes:
    body = {
        "speeds": speeds,
        "pivot_index": j,
        "histogram": {str(m): hist[m] for m in range(len(speeds)) if hist[m]},
        "score": frac_text(score),
        "least_zero": least_zero,
        "lzed_margin": lzed_margin,
        "residue_owner_digest_sha256": residue_digest,
    }
    return json.dumps(body, sort_keys=True, separators=(",", ":")).encode() + b"\n"


class DomainKernel:
    """Precompute every owner/pivot badness vector, then combine by labels."""
    def __init__(self, n: int, B: int):
        self.n = n
        self.N = n + 1
        self.B = B
        self.candidates: dict[int, tuple[int, ...]] = {
            p: tuple(r for r in range(self.N*p) if r % self.N)
            for p in range(1, B+1)
        }
        self.bad: dict[tuple[int, int], tuple[int, ...]] = {}
        for p in range(1, B+1):
            M = self.N*p
            rs = self.candidates[p]
            for a in range(1, B+1):
                if a == p:
                    continue
                self.bad[p, a] = tuple(
                    int(min((r*a) % M, M - ((r*a) % M)) < p)
                    for r in rs
                )

    def row(self, speeds: tuple[int, ...], j: int):
        p = speeds[j]
        rs = self.candidates[p]
        owner_ids = [k for k in range(len(speeds)) if k != j]
        vectors = [self.bad[p, speeds[k]] for k in owner_ids]
        hist: Counter[int] = Counter()
        residue_digest = hashlib.sha256()
        least_zero = None
        incidence = 0
        for k, vals in enumerate(zip(*vectors)):
            bad_indices = tuple(owner_ids[q] for q, flag in enumerate(vals) if flag)
            m = len(bad_indices)
            residue_digest.update(struct.pack(">QH", rs[k], m))
            for i in bad_indices:
                residue_digest.update(struct.pack(">H", i))
            hist[m] += 1
            incidence += m
            if m == 0 and least_zero is None:
                least_zero = rs[k]
        R = len(rs)
        assert R == self.n*p
        h0 = hist[0]
        excess = incidence - (R-h0)
        margin = (2*self.N+1)*h0 - excess
        score = score_of_hist(self.N, hist)
        if margin > 0:
            assert score >= Fraction(h0) - Fraction(excess, 2*self.N+1) > 0
        return hist, score, least_zero, margin, residue_digest.hexdigest()


def scan_domain(n: int, B: int) -> dict[str, object]:
    kernel = DomainKernel(n, B)
    primitive = 0
    fail = None
    lzed_fail = None
    minimum: tuple[Fraction, tuple[int, ...], int] | None = None
    digest = hashlib.sha256()
    for maximum in range(n, B + 1):
        for prefix in itertools.combinations(range(1, maximum), n - 1):
            speeds = prefix + (maximum,)
            if gcd_tuple(speeds) != 1:
                continue
            primitive += 1
            rows = []
            for j in range(n):
                hist, score, least, margin, residue_hash = kernel.row(speeds, j)
                digest.update(row_payload(speeds, j, hist, score, least, margin, residue_hash))
                rows.append((hist, score, least, margin, residue_hash))
            positives = [j for j, row in enumerate(rows) if row[1] > 0]
            lzed = [j for j, row in enumerate(rows) if row[3] > 0]
            if not positives:
                fail = {"speeds": list(speeds)}
                break
            if not lzed and lzed_fail is None:
                lzed_fail = {"speeds": list(speeds)}
            max_score, max_j = max((row[1], j) for j, row in enumerate(rows))
            if minimum is None or max_score < minimum[0]:
                minimum = (max_score, speeds, max_j)
        if fail is not None:
            break
    assert minimum is not None
    return {
        "n": n,
        "maximum_speed": B,
        "primitive_tuples_completed": primitive,
        "completion_marker": fail is None,
        "first_local_score_fail": fail,
        "first_lzed_fail": lzed_fail,
        "minimum_score": frac_text(minimum[0]),
        "minimum_speeds": list(minimum[1]),
        "minimum_pivot_index": minimum[2],
        "row_digest_sha256": digest.hexdigest(),
    }


def fixture_rows(speeds: tuple[int, ...]) -> list[dict[str, object]]:
    n = len(speeds)
    N = n+1
    out=[]
    for j,p in enumerate(speeds):
        M=N*p
        hist=Counter()
        least=None
        incidence=0
        residues=[]
        for r in range(M):
            if r % N == 0:
                continue
            # Independent direct comparison via doubled distance.
            bad=[]
            owner_remainders=[]
            for i,a in enumerate(speeds):
                if i==j:
                    continue
                y=(r*a)%M
                owner_remainders.append([i,y])
                if y < p or y > M-p:
                    bad.append(i)
            m=len(bad)
            residues.append({
                "r":r,
                "mu":m,
                "bad_owner_indices":bad,
                "owner_remainders":owner_remainders,
                "pivot_distance":min((r*p)%M,M-((r*p)%M)),
            })
            hist[m]+=1
            incidence += m
            if m==0 and least is None:
                least=r
        R=n*p
        h0=hist[0]
        margin=(2*N+1)*h0-(incidence-(R-h0))
        out.append({
            "pivot_index": j,
            "histogram": {str(m):hist[m] for m in range(n) if hist[m]},
            "score": frac_text(score_of_hist(N,hist)),
            "least_zero": least,
            "lzed_margin": margin,
            "residues":residues,
        })
    return out


def main() -> None:
    if len(sys.argv) != 1:
        print("p86_optimized.py accepts no command-line arguments", file=sys.stderr)
        raise SystemExit(2)
    literal_path=Path('/tmp/p86_literal.json')
    literal=json.loads(literal_path.read_text())
    domains=[scan_domain(n,B) for n,B in DOMAINS]
    literal_domains={(d['n'],d['maximum_speed']):d for d in literal['domains']}
    for d in domains:
        ref=literal_domains[d['n'],d['maximum_speed']]
        assert d['primitive_tuples_completed']==ref['primitive_tuples_completed']
        assert d['completion_marker']==ref['completion_marker']
        assert d['first_local_score_fail']==ref['first_local_score_fail']
        assert d['first_lzed_fail']==ref['first_lzed_fail']
        assert d['minimum_score']==ref['minimum_of_tuplewise_max_score']['score']['text']
        assert d['minimum_speeds']==ref['minimum_of_tuplewise_max_score']['speeds']
        assert d['minimum_pivot_index']==ref['minimum_of_tuplewise_max_score']['pivot_index']
        assert d['row_digest_sha256']==ref['row_digest_sha256']
    fixture_checks={}
    for category, mapping in (("controls", CONTROLS), ("fixtures", FIXTURES)):
      for name,speeds in mapping.items():
        rows=fixture_rows(speeds)
        reference=literal[category][name]['pivots']
        assert len(rows)==len(reference)
        for row,ref in zip(rows,reference):
            assert row['pivot_index']==ref['pivot_index']
            assert row['histogram']==ref['histogram']
            assert row['score']==ref['score']['text']
            assert row['least_zero']==ref['least_zero']
            assert row['lzed_margin']==ref['lzed_margin']
            assert row['residues']==ref['residues']
        fixture_checks[f"{category}:{name}"]="exact per-residue owner-labelled match"
    source_path=Path(__file__)
    source_sha=hashlib.sha256(source_path.read_bytes()).hexdigest()
    output={
        "schema":SCHEMA,
        "source_sha256":source_sha,
        "literal_source_sha256":literal['source_sha256'],
        "literal_output_sha256":hashlib.sha256(literal_path.read_bytes()).hexdigest(),
        "implementation":"precomputed labelled owner/pivot badness vectors for domains; separate direct interval test for fixtures",
        "arithmetic":"arbitrary-precision integers and fractions.Fraction; no floating point",
        "domains":domains,
        "fixture_checks":fixture_checks,
        "all_comparisons_exact":True,
    }
    out_path=source_path.with_suffix('.json')
    raw=json.dumps(output,sort_keys=True,separators=(',',':')).encode()+b'\n'
    out_path.write_bytes(raw)
    print(json.dumps({
        "schema":SCHEMA,
        "source_sha256":source_sha,
        "output_sha256":hashlib.sha256(raw).hexdigest(),
        "all_comparisons_exact":True,
        "domains":len(domains),
        "fixtures":len(fixture_checks),
    },sort_keys=True))

if __name__=='__main__':
    main()
