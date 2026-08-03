#!/usr/bin/env python3
"""Literal exact evaluator for Prompt 62 PRO-B top-two criteria.

No third-party packages.  It scans every canonical pivot residue literally,
uses strict bad sets rho < pivot, and checks the pivot coordinate directly.
The affine score is accumulated by literal robust-pair enumeration.
"""
from __future__ import annotations

import argparse
from dataclasses import dataclass
from math import comb, gcd, lcm
from pathlib import Path
from typing import Iterable

VERSION = "PROB-62-v1.0.0"


def rho(M: int, x: int) -> int:
    y = x % M
    return min(y, M - y)


@dataclass(frozen=True)
class PivotData:
    P: int
    Q: int
    safe: tuple[int, ...]
    fullH: tuple[int, int, int, int]
    fullQ2: int
    fullQ3: int
    robust: tuple[tuple[int, int], ...]  # (r, lower bad multiplicity)
    robustH: tuple[int, int, int, int]
    robustQ2: int
    robustQ3: int
    robustSlices: tuple[int, ...]
    lowerBadSlices: tuple[tuple[int, ...], ...]


def pivot_data(speeds: tuple[int, ...], pivot: int, other_top: int) -> PivotData:
    n = len(speeds)
    N = n + 1
    P = speeds[pivot]
    Q = speeds[other_top]
    M = N * P
    lower_indices = tuple(i for i in range(n) if i not in (pivot, other_top))
    fullH = [0, 0, 0, 0]
    robustH = [0, 0, 0, 0]
    safe: list[int] = []
    robust: list[tuple[int, int]] = []
    robust_slices = [0] * N
    lower_bad_slices = [[0] * N for _ in lower_indices]

    for r in range(M):
        if r % N == 0:
            continue
        # Canonical candidates must automatically satisfy the pivot coordinate.
        assert rho(M, r * P) >= P, (speeds, P, r)
        lower_bad_flags = [rho(M, r * speeds[i]) < P for i in lower_indices]
        lower_k = sum(lower_bad_flags)
        top_bad = rho(M, r * Q) < P
        full_k = lower_k + int(top_bad)
        for q in range(4):
            fullH[q] += comb(full_k, q) if full_k >= q else 0
        if full_k == 0:
            safe.append(r)
        if not top_bad:
            robust.append((r, lower_k))
            j = r % N
            robust_slices[j] += 1
            for z, flag in enumerate(lower_bad_flags):
                if flag:
                    lower_bad_slices[z][j] += 1
            for q in range(4):
                robustH[q] += comb(lower_k, q) if lower_k >= q else 0

    assert fullH[0] == n * P
    assert robustH[0] == len(robust)
    m_full = n - 1
    full_q2 = m_full * fullH[0] - m_full * fullH[1] + 2 * fullH[2]
    full_q3 = fullH[0] - fullH[1] + fullH[2] - fullH[3]
    m_robust = n - 2
    if m_robust == 0:
        robust_q2 = robustH[0]
    else:
        robust_q2 = m_robust * robustH[0] - m_robust * robustH[1] + 2 * robustH[2]
    robust_q3 = robustH[0] - robustH[1] + robustH[2] - robustH[3]
    return PivotData(
        P=P,
        Q=Q,
        safe=tuple(safe),
        fullH=tuple(fullH),
        fullQ2=full_q2,
        fullQ3=full_q3,
        robust=tuple(robust),
        robustH=tuple(robustH),
        robustQ2=robust_q2,
        robustQ3=robust_q3,
        robustSlices=tuple(robust_slices),
        lowerBadSlices=tuple(tuple(row) for row in lower_bad_slices),
    )


def slice_score(a: PivotData, b: PivotData) -> tuple[int, tuple[int, ...]]:
    N = len(a.robustSlices)
    assert len(b.robustSlices) == N
    deficits = []
    for j in range(1, N):
        supply = a.robustSlices[j] + b.robustSlices[j]
        incidence = sum(row[j] for row in a.lowerBadSlices)
        incidence += sum(row[j] for row in b.lowerBadSlices)
        deficits.append(supply - incidence)
    return max(deficits, default=0), tuple(deficits)


def affine_score_literal(speeds: tuple[int, ...], a: PivotData, b: PivotData) -> tuple[int, int, int, int]:
    n = len(speeds)
    N = n + 1
    A, B = a.P, b.P
    assert A < B
    g = gcd(A, B)
    alpha, beta = A // g, B // g
    L = N * g * alpha * beta
    pair_counts = [0] * L
    union_counts = [0] * L
    for r, ka in a.robust:
        for s, kb in b.robust:
            h = (beta * r - alpha * s) % L
            pair_counts[h] += 1
            union_counts[h] += ka * kb
    best_margin: int | None = None
    best_h = best_p = best_u = 0
    for h, (p, u) in enumerate(zip(pair_counts, union_counts)):
        if p == 0:
            continue
        margin = p - u
        if best_margin is None or margin > best_margin:
            best_margin, best_h, best_p, best_u = margin, h, p, u
    if best_margin is None:
        return -1, -1, 0, 0
    return best_margin, best_h, best_p, best_u


def residual_flag(speeds: tuple[int, ...]) -> bool:
    """Explicit working residual reconstructed for this PRO-B turn.

    B<nA: fastest-pivot ratio residual.
    2B<=NA: large-gap branch removed.
    If B<2N, every integer q with B<2q and q<=N occurs as a speed:
    extremal terminal-interval residual.
    """
    n = len(speeds)
    if n < 2:
        return False
    N = n + 1
    A, B = speeds[-2], speeds[-1]
    if not (B < n * A and 2 * B <= N * A):
        return False
    S = set(speeds)
    return all(q in S for q in range(B // 2 + 1, N + 1))


def parse_manifest(path: Path) -> Iterable[tuple[str, str, str, tuple[int, ...]]]:
    with path.open(encoding="utf-8") as f:
        for line in f:
            line = line.rstrip("\n")
            if not line or line.startswith("#"):
                continue
            rid, category, name, csv = line.split("|", 3)
            speeds = tuple(map(int, csv.split(",")))
            assert tuple(sorted(speeds)) == speeds
            assert len(set(speeds)) == len(speeds)
            assert all(x > 0 for x in speeds)
            yield rid, category, name, speeds


def csv(xs: Iterable[int]) -> str:
    return ",".join(map(str, xs))


def evaluate_row(rid: str, category: str, name: str, speeds: tuple[int, ...]) -> str:
    n = len(speeds)
    N = n + 1
    ia, ib = n - 2, n - 1
    A, B = speeds[ia], speeds[ib]
    pa = pivot_data(speeds, ia, ib)
    pb = pivot_data(speeds, ib, ia)
    assert pa.P == A and pb.P == B
    sl_best, sl_vec = slice_score(pa, pb)
    af_margin, af_h, af_p, af_u = affine_score_literal(speeds, pa, pb)
    fields = (
        rid, category, name, csv(speeds), str(N), str(A), str(B),
        str(len(pa.safe)), str(pa.safe[0] if pa.safe else -1),
        str(len(pb.safe)), str(pb.safe[0] if pb.safe else -1),
        str(pa.fullQ2), str(pa.fullQ3), str(pb.fullQ2), str(pb.fullQ3),
        csv(pa.robustH), str(pa.robustQ2), str(pa.robustQ3),
        csv(pb.robustH), str(pb.robustQ2), str(pb.robustQ3),
        str(sl_best), csv(sl_vec),
        str(af_margin), str(af_h), str(af_p), str(af_u),
        "1" if residual_flag(speeds) else "0",
    )
    return "|".join(fields)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("manifest", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    header = (
        "# version=" + VERSION + "\n"
        "# fields=id|category|name|speeds|N|A|B|safeA|firstA|safeB|firstB|"
        "fullQ2A|fullQ3A|fullQ2B|fullQ3B|robH_A|robQ2A|robQ3A|"
        "robH_B|robQ2B|robQ3B|sliceBest|sliceDeficits|"
        "affineMargin|affineH|affinePairs|affineUnion|residual\n"
    )
    with args.output.open("w", encoding="utf-8", newline="\n") as out:
        out.write(header)
        for row in parse_manifest(args.manifest):
            out.write(evaluate_row(*row) + "\n")


if __name__ == "__main__":
    main()
