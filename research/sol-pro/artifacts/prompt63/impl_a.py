#!/usr/bin/env python3
"""Reference exact enumerator for the PRO-C deletion/correlation audit.

Implementation A uses Python integers, fractions.Fraction, and hashlib SHA-256.
It enumerates every canonical row (j,r), derives every deletion-certificate
member, and independently computes active-set components/maximizers for the
mandatory tuples and every tuple with no exceptional-good certificate.
"""
from __future__ import annotations

import hashlib
import math
import sys
from dataclasses import dataclass
from fractions import Fraction
from pathlib import Path
from typing import Iterable

VERSION = "PRO-C-IMPL-A-1.0.0"
ROOT = Path(__file__).resolve().parent


def rho(m: int, x: int) -> int:
    y = x % m
    return min(y, m - y)


def dist_at(a: int, t: Fraction) -> Fraction:
    rem = (a * t.numerator) % t.denominator
    return Fraction(min(rem, t.denominator - rem), t.denominator)


def frac_s(x: Fraction) -> str:
    return f"{x.numerator}/{x.denominator}"


def list_s(xs: Iterable[object]) -> str:
    return ",".join(str(x) for x in xs) if xs else "-"


def matrix_s(mat: list[list[int]]) -> str:
    return ";".join(",".join(str(x) for x in row) for row in mat)


def parse_domain(path: Path):
    for line in path.read_text(encoding="utf-8").splitlines():
        rid_s, families_s, a_s = line.split("\t")
        yield int(rid_s), families_s, tuple(map(int, a_s.split(",")))


@dataclass
class CoreResult:
    line: str
    any_good: bool


def analyze_core(rid: int, families: str, a: tuple[int, ...]) -> CoreResult:
    n = len(a)
    N = n + 1
    cert_counts = [0] * n
    good_counts = [0] * n
    pivot_good_counts = [0] * n
    empty_rows = [0] * n
    deep = [[0] * n for _ in range(n)]
    shell = [[0] * n for _ in range(n)]
    cert_total = 0
    good_total = 0
    h = hashlib.sha256()

    # Canonical certificate-stream order: pivot j, numerator r, deletion k.
    for j, p in enumerate(a):
        m = n * p
        for r in range(m):
            if r % n == 0:
                continue
            vals = [rho(m, r * x) for x in a]
            bad = [i for i, u in enumerate(vals) if u < p]
            if j in bad:
                raise AssertionError((rid, j, r, "pivot unsafe"))
            if not bad:
                empty_rows[j] += 1
                deletions = [k for k in range(n) if k != j]
            elif len(bad) == 1:
                k0 = bad[0]
                deletions = [k0]
                if N * vals[k0] < m:
                    deep[j][k0] += 1
                else:
                    shell[j][k0] += 1
            else:
                deletions = []

            for k in deletions:
                good = N * vals[k] >= m
                cert_counts[k] += 1
                cert_total += 1
                if good:
                    good_counts[k] += 1
                    pivot_good_counts[j] += 1
                    good_total += 1
                payload = (
                    f"{k},{j},{r},{p},{vals[k]},{1 if good else 0},"
                    + ",".join(map(str, vals))
                    + "\n"
                )
                h.update(payload.encode("ascii"))

    primitive = math.gcd(*a) == 1
    residual = max(a) > N + (N // 3)
    ndiv = [i for i, x in enumerate(a) if x % N == 0]
    all_nonempty = all(x > 0 for x in cert_counts)
    any_good = good_total > 0
    fields = [
        str(rid),
        families,
        str(n),
        list_s(a),
        "1" if primitive else "0",
        "1" if residual else "0",
        list_s(ndiv),
        list_s(cert_counts),
        list_s(good_counts),
        list_s(pivot_good_counts),
        str(cert_total),
        str(good_total),
        "1" if all_nonempty else "0",
        "1" if any_good else "0",
        list_s(empty_rows),
        matrix_s(deep),
        matrix_s(shell),
        h.hexdigest(),
    ]
    return CoreResult("\t".join(fields), any_good)


def boundary_times(n: int, speed: int) -> set[Fraction]:
    m = n * speed
    out: set[Fraction] = set()
    for z in range(speed):
        out.add(Fraction(1 + n * z, m))
        out.add(Fraction((n - 1) + n * z, m))
    return out


def k_feasible(a: tuple[int, ...], k: int, t: Fraction) -> bool:
    n = len(a)
    threshold = Fraction(1, n)
    return all(i == k or dist_at(x, t) >= threshold for i, x in enumerate(a))


class DSU:
    def __init__(self, n: int):
        self.p = list(range(n))

    def find(self, x: int) -> int:
        while self.p[x] != x:
            self.p[x] = self.p[self.p[x]]
            x = self.p[x]
        return x

    def union(self, x: int, y: int) -> None:
        x, y = self.find(x), self.find(y)
        if x != y:
            self.p[y] = x


def component_count(a: tuple[int, ...], k: int, boundaries: list[Fraction]) -> int:
    if not boundaries:
        return 1 if k_feasible(a, k, Fraction(0)) else 0
    L = len(boundaries)
    point_ok = [k_feasible(a, k, t) for t in boundaries]
    arc_ok: list[bool] = []
    for q, left in enumerate(boundaries):
        right = boundaries[(q + 1) % L]
        if q == L - 1:
            right += 1
        mid = (left + right) / 2
        mid %= 1
        arc_ok.append(k_feasible(a, k, mid))

    node_p = [-1] * L
    node_a = [-1] * L
    nodes = 0
    for q, ok in enumerate(point_ok):
        if ok:
            node_p[q] = nodes
            nodes += 1
    for q, ok in enumerate(arc_ok):
        if ok:
            node_a[q] = nodes
            nodes += 1
    if nodes == 0:
        return 0
    dsu = DSU(nodes)
    for q, ok in enumerate(arc_ok):
        if not ok:
            continue
        left, right = q, (q + 1) % L
        if not point_ok[left] or not point_ok[right]:
            raise AssertionError((a, k, q, "open feasible arc has infeasible closed endpoint"))
        dsu.union(node_a[q], node_p[left])
        dsu.union(node_a[q], node_p[right])
    return len({dsu.find(i) for i in range(nodes)})


def active_analysis_lines(rid: int, a: tuple[int, ...]) -> list[str]:
    n = len(a)
    N = n + 1
    out: list[str] = []
    for k, ak in enumerate(a):
        boundaries_set: set[Fraction] = set()
        candidates: set[Fraction] = {Fraction(0)}
        for i, speed in enumerate(a):
            if i == k:
                continue
            bt = boundary_times(n, speed)
            boundaries_set.update(bt)
            candidates.update(bt)
        for z in range(ak):
            candidates.add(Fraction(2 * z + 1, 2 * ak))

        boundaries = sorted(boundaries_set)
        comps = component_count(a, k, boundaries)
        feasible = sorted(t for t in candidates if k_feasible(a, k, t))
        if not feasible:
            out.append(f"{rid}\t{k}\t{comps}\tEMPTY\t-\t-\t-")
            continue
        eta = max(dist_at(ak, t) for t in feasible)
        max_times = [t for t in feasible if dist_at(ak, t) == eta]

        active_desc: list[str] = []
        edges: list[tuple] = []
        for t in max_times:
            active = [
                j
                for j, speed in enumerate(a)
                if j != k and dist_at(speed, t) == Fraction(1, n)
            ]
            active_desc.append(f"{frac_s(t)}:" + list_s(active))

            remk = (ak * t.numerator) % t.denominator
            if remk == 0:
                epsilons = [-1, 1]
            elif 2 * remk < t.denominator:
                epsilons = [1]
            elif 2 * remk > t.denominator:
                epsilons = [-1]
            else:
                epsilons = []

            for eps in epsilons:
                for j in active:
                    p = a[j]
                    remj = (p * t.numerator) % t.denominator
                    if n == 2 and 2 * remj == t.denominator:
                        s = -eps
                        decreases = True
                    elif n * remj == t.denominator:
                        s = 1
                        decreases = eps == -1
                    elif n * remj == (n - 1) * t.denominator:
                        s = -1
                        decreases = eps == 1
                    else:
                        raise AssertionError((rid, k, t, j, "active phase malformed"))
                    if not decreases:
                        continue
                    if eps != -s:
                        raise AssertionError((rid, k, t, j, "orientation mismatch"))
                    m = n * p
                    tr = t * m
                    if tr.denominator != 1:
                        raise AssertionError((rid, k, t, j, "noncanonical active time"))
                    r = tr.numerator % m
                    if (r - s) % n != 0:
                        raise AssertionError((rid, k, t, j, r, s, "wrong canonical class"))
                    vals = [rho(m, r * x) for x in a]
                    if any(i != k and vals[i] < p for i in range(n)):
                        raise AssertionError((rid, k, t, j, "not a certificate"))
                    d = vals[k]
                    rawk = (r * ak) % m
                    if rawk != ((-s * d) % m):
                        raise AssertionError((rid, k, t, j, rawk, s, d, "signed residue"))
                    if (ak + d) % n:
                        raise AssertionError((rid, k, t, j, "b nonintegral"))
                    b = (ak + d) // n
                    z = (r - s) // n
                    numq = z * ak + s * b
                    if numq % p:
                        raise AssertionError((rid, k, t, j, "q nonintegral"))
                    qv = numq // p
                    Rmod = N * ak
                    R = (N * qv - s) % Rmod
                    delta = Fraction(n * p - N * d, N * n * p * ak)
                    rev_res = [rho(Rmod, R * x) for x in a]
                    rev_full = all(x >= ak for x in rev_res)
                    if rev_res[k] != ak:
                        raise AssertionError((rid, k, t, j, "deleted reverse endpoint wrong"))
                    if rho(Rmod, R * p) != rho(Rmod, N * b - p):
                        raise AssertionError((rid, k, t, j, "pivot reverse identity wrong"))
                    edges.append(
                        (
                            t,
                            eps,
                            j,
                            s,
                            p,
                            r,
                            d,
                            b,
                            z,
                            qv,
                            R,
                            delta,
                            1 if rev_full else 0,
                            tuple(rev_res),
                        )
                    )

        # Remove exact duplicate oriented edges and sort canonically.
        edges = sorted(set(edges))
        edge_desc = []
        for (
            t,
            eps,
            j,
            s,
            p,
            r,
            d,
            b,
            z,
            qv,
            R,
            delta,
            rev_full,
            rev_res,
        ) in edges:
            edge_desc.append(
                ",".join(
                    [
                        frac_s(t),
                        str(eps),
                        str(j),
                        str(s),
                        str(p),
                        str(r),
                        str(d),
                        str(b),
                        str(z),
                        str(qv),
                        str(R),
                        frac_s(delta),
                        str(rev_full),
                        list_s(rev_res),
                    ]
                )
            )
        out.append(
            "\t".join(
                [
                    str(rid),
                    str(k),
                    str(comps),
                    frac_s(eta),
                    ";".join(frac_s(t) for t in max_times),
                    ";".join(active_desc),
                    "|".join(edge_desc) if edge_desc else "-",
                ]
            )
        )
    return out


def main() -> None:
    domain = ROOT / "domain.tsv"
    core_path = ROOT / "impl_a_core.tsv"
    active_path = ROOT / "impl_a_active.tsv"
    core_lines: list[str] = []
    active_lines: list[str] = []
    audited_ids: list[int] = []
    for rid, families, a in parse_domain(domain):
        result = analyze_core(rid, families, a)
        core_lines.append(result.line)
        if rid < 5 or not result.any_good:
            audited_ids.append(rid)
            active_lines.extend(active_analysis_lines(rid, a))
    core_path.write_text("\n".join(core_lines) + "\n", encoding="utf-8", newline="\n")
    active_path.write_text("\n".join(active_lines) + "\n", encoding="utf-8", newline="\n")
    print(
        f"{VERSION}\trecords={len(core_lines)}\tactive_tuple_ids={len(audited_ids)}\t"
        f"active_deletion_lines={len(active_lines)}\tids={','.join(map(str, audited_ids))}"
    )


if __name__ == "__main__":
    main()
