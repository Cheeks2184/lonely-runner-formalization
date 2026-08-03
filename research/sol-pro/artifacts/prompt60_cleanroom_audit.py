#!/usr/bin/env python3
"""Independent exact audits for Prompt 60.

Python standard library only.  This program does not prove the unrestricted
Lonely Runner Conjecture and does not import any earlier audit implementation.
"""

from __future__ import annotations

from dataclasses import dataclass
from fractions import Fraction
from hashlib import sha256
from itertools import combinations, product
from math import gcd
from pathlib import Path
from time import perf_counter
import platform


D2_TUPLE = (1, 2, 3, 60)
D3_TUPLE = (1, 3, 4, 5, 18)
RAW_LIFT_TUPLE = (1, 3, 4, 7)
PRIME_TUPLE = (1, 3, 4)
PRIME_P = 5


def rho(modulus: int, value: int) -> int:
    residue = value % modulus
    return min(residue, modulus - residue)


def gcd_all(values: tuple[int, ...] | list[int]) -> int:
    out = 0
    for value in values:
        out = gcd(out, value)
    return out


def circle_norm(value: Fraction) -> Fraction:
    residue = value % 1
    return min(residue, 1 - residue)


def fmt_fraction(value: Fraction) -> str:
    return str(value.numerator) if value.denominator == 1 else f"{value.numerator}/{value.denominator}"


def fmt_tuple(values) -> str:
    return "(" + ",".join(str(value) for value in values) + ")"


def fmt_set(values) -> str:
    return "{" + ",".join(str(value) for value in sorted(values)) + "}"


@dataclass(frozen=True)
class PivotAudit:
    speeds: tuple[int, ...]
    pivot: int
    modulus: int
    candidates: tuple[int, ...]
    bad: dict[int, frozenset[int]]
    deep: dict[int, frozenset[int]]
    shell: dict[int, frozenset[int]]
    good: tuple[int, ...]

    @property
    def n(self) -> int:
        return len(self.speeds)

    @property
    def N(self) -> int:
        return self.n + 1

    @property
    def p(self) -> int:
        return self.speeds[self.pivot]

    def deep_multiplicity(self, r: int) -> int:
        return sum(r in values for values in self.deep.values())

    def shell_multiplicity(self, r: int) -> int:
        return sum(r in values for values in self.shell.values())

    def deep_sums(self) -> tuple[int, int, int]:
        indices = tuple(sorted(self.deep))
        d1 = sum(len(self.deep[i]) for i in indices)
        d2 = sum(len(self.deep[i] & self.deep[k]) for i, k in combinations(indices, 2))
        d3 = sum(
            len(self.deep[i] & self.deep[k] & self.deep[l])
            for i, k, l in combinations(indices, 3)
        )
        return d1, d2, d3

    def shell_pair_sum(self) -> int:
        indices = tuple(sorted(self.shell))
        return sum(len(self.shell[i] & self.shell[k]) for i, k in combinations(indices, 2))

    def d2_lower_bound(self) -> int:
        d1, _, _ = self.deep_sums()
        return len(self.candidates) - d1 - self.shell_pair_sum()

    def d3_lower_bound(self) -> int:
        d1, d2, d3 = self.deep_sums()
        return len(self.candidates) - (d1 - d2 + d3) - self.shell_pair_sum()


def make_pivot_audit(speeds: tuple[int, ...], pivot: int) -> PivotAudit:
    n = len(speeds)
    N = n + 1
    p = speeds[pivot]
    modulus = n * p
    candidates = tuple(r for r in range(modulus) if r % n != 0)
    bad: dict[int, frozenset[int]] = {}
    deep: dict[int, frozenset[int]] = {}
    shell: dict[int, frozenset[int]] = {}
    for i in range(n):
        if i == pivot:
            continue
        b = frozenset(r for r in candidates if rho(modulus, r * speeds[i]) < p)
        d = frozenset(
            r for r in candidates if N * rho(modulus, r * speeds[i]) < n * p
        )
        assert d <= b
        bad[i] = b
        deep[i] = d
        shell[i] = b - d
    good = tuple(
        r
        for r in candidates
        if sum(r in values for values in deep.values()) == 0
        and sum(r in values for values in shell.values()) <= 1
    )
    audit = PivotAudit(speeds, pivot, modulus, candidates, bad, deep, shell, good)
    verify_d1_d3(audit)
    return audit


def verify_d1_d3(audit: PivotAudit) -> None:
    union_deep = set().union(*audit.deep.values()) if audit.deep else set()
    at_least_two_shell = {
        r for r in audit.candidates if audit.shell_multiplicity(r) >= 2
    }
    complement_good = set(audit.candidates) - set(audit.good)
    assert complement_good == union_deep | at_least_two_shell

    d1, d2, d3 = audit.deep_sums()
    h2 = audit.shell_pair_sum()
    assert len(audit.good) >= len(audit.candidates) - d1 - h2
    assert len(audit.good) >= len(audit.candidates) - (d1 - d2 + d3) - h2

    for r in audit.candidates:
        multiplicity = audit.deep_multiplicity(r)
        polynomial = (
            multiplicity
            - multiplicity * (multiplicity - 1) // 2
            + multiplicity * (multiplicity - 1) * (multiplicity - 2) // 6
        )
        assert (1 if multiplicity >= 1 else 0) <= polynomial


def deletion_certificates(speeds: tuple[int, ...], deleted: int):
    n = len(speeds)
    N = n + 1
    certs = []
    for pivot in range(n):
        if pivot == deleted:
            continue
        p = speeds[pivot]
        modulus = n * p
        for r in range(modulus):
            if r % n == 0:
                continue
            if all(
                rho(modulus, r * speeds[i]) >= p
                for i in range(n)
                if i != pivot and i != deleted
            ):
                numerators = tuple(rho(modulus, r * speed) for speed in speeds)
                exceptional_lhs = N * numerators[deleted]
                exceptional_rhs = n * p
                certs.append(
                    (
                        pivot,
                        r,
                        numerators,
                        exceptional_lhs,
                        exceptional_rhs,
                        exceptional_lhs >= exceptional_rhs,
                    )
                )
    return tuple(certs)


def direct_full_witness(speeds: tuple[int, ...], denominator: int, numerator: int):
    N = len(speeds) + 1
    numerators = tuple(rho(denominator, numerator * speed) for speed in speeds)
    return numerators, all(N * value >= denominator for value in numerators)


def continuous_eta(speeds: tuple[int, ...], deleted: int):
    """Exact maximization on K_deleted by checking all component endpoints
    and all antipodes of the objective triangular wave.
    """
    n = len(speeds)
    candidates: set[Fraction] = {Fraction(0)}
    for i, speed in enumerate(speeds):
        if i == deleted:
            continue
        for m in range(speed):
            candidates.add(Fraction(n * m + 1, n * speed) % 1)
            candidates.add(Fraction(n * m - 1, n * speed) % 1)
    own = speeds[deleted]
    for m in range(own):
        candidates.add(Fraction(2 * m + 1, 2 * own) % 1)

    feasible = tuple(
        sorted(
            t
            for t in candidates
            if all(
                circle_norm(t * speeds[i]) >= Fraction(1, n)
                for i in range(n)
                if i != deleted
            )
        )
    )
    if not feasible:
        return None, (), {}
    eta = max(circle_norm(t * own) for t in feasible)
    maximizers = tuple(t for t in feasible if circle_norm(t * own) == eta)
    active = {
        t: tuple(
            i
            for i in range(n)
            if i != deleted and circle_norm(t * speeds[i]) == Fraction(1, n)
        )
        for t in maximizers
    }
    return eta, maximizers, active


def canonical_deletion_times(speeds: tuple[int, ...], deleted: int):
    n = len(speeds)
    times: dict[Fraction, list[tuple[int, int]]] = {}
    for cert in deletion_certificates(speeds, deleted):
        pivot, r = cert[0], cert[1]
        t = Fraction(r, n * speeds[pivot]) % 1
        times.setdefault(t, []).append((pivot, r))
    return {time: tuple(entries) for time, entries in times.items()}


def active_graph(speeds: tuple[int, ...]):
    graph: dict[int, set[int]] = {}
    witnesses: dict[tuple[int, int], Fraction] = {}
    etas = []
    for k in range(len(speeds)):
        eta, maximizers, active = continuous_eta(speeds, k)
        etas.append(eta)
        graph[k] = set()
        for t in maximizers:
            for i in active[t]:
                graph[k].add(i)
                witnesses.setdefault((k, i), t)
    return tuple(etas), {k: tuple(sorted(v)) for k, v in graph.items()}, witnesses


def first_cycle(graph: dict[int, tuple[int, ...]], allowed: set[int] | None = None):
    vertices = tuple(sorted(graph if allowed is None else allowed))
    allowed_set = set(vertices)

    def visit(start: int, current: int, path: tuple[int, ...]):
        for nxt in graph[current]:
            if nxt not in allowed_set:
                continue
            if nxt == start and len(path) >= 2:
                return path
            if nxt not in path and nxt >= start:
                found = visit(start, nxt, path + (nxt,))
                if found is not None:
                    return found
        return None

    for start in vertices:
        found = visit(start, start, (start,))
        if found is not None:
            return found
    return None


def prime_forcing_premises(n: int, p: int, residues: tuple[int, ...]) -> bool:
    N = n + 1
    modulus = N * p
    if len(residues) != n:
        return False
    if any(value < 0 or value >= modulus or value % p == 0 for value in residues):
        return False
    return all(
        gcd_all([modulus] + [residues[i] for i in range(n) if i != deleted]) == 1
        for deleted in range(n)
    )


def prime_forcing_witness(n: int, p: int, residues: tuple[int, ...]):
    modulus = (n + 1) * p
    for r in range(modulus):
        if all(rho(modulus, r * value) >= p for value in residues):
            return r
    return None


def p1_data(n: int, p: int, residues: tuple[int, ...]):
    N = n + 1
    modulus = N * p
    bad_sets = tuple(
        frozenset(r for r in range(modulus) if rho(modulus, r * value) < p)
        for value in residues
    )
    rows = []
    for r in range(modulus):
        distances = tuple(rho(modulus, r * value) for value in residues)
        bad = tuple(i for i, values in enumerate(bad_sets) if r in values)
        rows.append((r, distances, bad, len(bad)))
    Z0 = sum(row[3] == 0 for row in rows)
    Z1 = sum(row[3] == 1 for row in rows)
    rhs = 2 * p - (N - 1) * (N - 2)
    exact_sizes = tuple(len(values) for values in bad_sets)
    fiber_sizes = []
    for value in residues:
        d = gcd(modulus, value)
        exact = d * (2 * ((p - 1) // d) + 1)
        assert exact == len(
            [r for r in range(modulus) if rho(modulus, r * value) < p]
        )
        fiber_sizes.append((d, exact))
    assert 2 * Z0 + Z1 >= rhs
    return tuple(rows), Z0, Z1, rhs, exact_sizes, tuple(fiber_sizes)


def sign_class_count(modulus: int, residues: tuple[int, ...]) -> int:
    classes = {min(value % modulus, (-value) % modulus) for value in residues}
    return len(classes)


def exhaustive_prime_forcing_status(n: int, p: int):
    """Lexicographic exhaustive check on the exact residue domain.

    Returns (premise_tuple_count, first_failure_or_None).  Bad-set bitmasks
    make the forcing check exact without repeatedly scanning every residue.
    """
    N = n + 1
    modulus = N * p
    domain = tuple(value for value in range(modulus) if value % p != 0)
    bad_masks = {}
    for value in domain:
        mask = 0
        for r in range(modulus):
            if rho(modulus, r * value) < p:
                mask |= 1 << r
        bad_masks[value] = mask
    full = (1 << modulus) - 1
    premise_count = 0
    for residues in product(domain, repeat=n):
        if not prime_forcing_premises(n, p, residues):
            continue
        premise_count += 1
        union = 0
        for value in residues:
            union |= bad_masks[value]
        if union == full:
            assert prime_forcing_witness(n, p, residues) is None
            return premise_count, residues
    return premise_count, None


def smallest_n3_prime_forcing_failure():
    cumulative_checked = 0
    for p in (2, 3, 5):
        count, failure = exhaustive_prime_forcing_status(3, p)
        cumulative_checked += count
        if failure is not None:
            return p, failure, cumulative_checked
    return None


def tuple_structure(speeds: tuple[int, ...]):
    N = len(speeds) + 1
    deletion_gcds = tuple(
        gcd_all([speeds[i] for i in range(len(speeds)) if i != deleted])
        for deleted in range(len(speeds))
    )
    cert_counts = []
    lift_counts = []
    first_certs = []
    first_lifts = []
    for deleted in range(len(speeds)):
        certs = deletion_certificates(speeds, deleted)
        lifts = tuple(cert for cert in certs if cert[-1])
        cert_counts.append(len(certs))
        lift_counts.append(len(lifts))
        first_certs.append(certs[0] if certs else None)
        first_lifts.append(lifts[0] if lifts else None)
    return {
        "positive": all(speed > 0 for speed in speeds),
        "injective": len(set(speeds)) == len(speeds),
        "primitive": gcd_all(list(speeds)) == 1,
        "N_divisible": tuple(i for i, speed in enumerate(speeds) if speed % N == 0),
        "deletion_gcds": deletion_gcds,
        "cert_counts": tuple(cert_counts),
        "lift_counts": tuple(lift_counts),
        "first_certs": tuple(first_certs),
        "first_lifts": tuple(first_lifts),
    }


def pivot_summary(speeds: tuple[int, ...]):
    rows = []
    for pivot in range(len(speeds)):
        audit = make_pivot_audit(speeds, pivot)
        d1, d2, d3 = audit.deep_sums()
        rows.append(
            (
                pivot,
                speeds[pivot],
                len(audit.candidates),
                len(audit.good),
                d1,
                d2,
                d3,
                audit.shell_pair_sum(),
                audit.d2_lower_bound(),
                audit.d3_lower_bound(),
                audit.good,
            )
        )
    return tuple(rows)


def table_for_pivot_case(label: str, speeds: tuple[int, ...]) -> list[str]:
    lines = [f"CASE {label} speeds={fmt_tuple(speeds)}"]
    for pivot in range(len(speeds)):
        audit = make_pivot_audit(speeds, pivot)
        lines.append(
            f"PIVOT index={pivot} speed={speeds[pivot]} modulus={audit.modulus} "
            f"R={len(audit.candidates)} G={len(audit.good)}"
        )
        lines.append("r | rho-vector | D-indices | H-indices | delta | shell | G")
        for r in audit.candidates:
            distances = tuple(rho(audit.modulus, r * speed) for speed in speeds)
            deep_indices = tuple(i for i in sorted(audit.deep) if r in audit.deep[i])
            shell_indices = tuple(i for i in sorted(audit.shell) if r in audit.shell[i])
            lines.append(
                f"{r} | {fmt_tuple(distances)} | {fmt_tuple(deep_indices)} | "
                f"{fmt_tuple(shell_indices)} | {len(deep_indices)} | "
                f"{len(shell_indices)} | {int(r in audit.good)}"
            )
        lines.append("")
    return lines


def make_literal_tables() -> str:
    lines: list[str] = []
    lines.extend(table_for_pivot_case("D2_UNIFORM_REJECTION", D2_TUPLE))
    lines.extend(table_for_pivot_case("D3_UNIFORM_REJECTION", D3_TUPLE))
    lines.extend(table_for_pivot_case("RAW_DELETION_LIFT_REJECTION", RAW_LIFT_TUPLE))

    prime_rows, Z0, Z1, rhs, sizes, fibers = p1_data(3, PRIME_P, PRIME_TUPLE)
    lines.append(
        f"CASE PRIME_FORCING_REJECTION n=3 N=4 p=5 M=20 v={fmt_tuple(PRIME_TUPLE)}"
    )
    lines.append(f"bad_set_sizes={fmt_tuple(sizes)} fibers={fibers} Z0={Z0} Z1={Z1} P1_rhs={rhs}")
    lines.append("r | rho-vector | bad-indices | mu | safe")
    for r, distances, bad, multiplicity in prime_rows:
        lines.append(
            f"{r} | {fmt_tuple(distances)} | {fmt_tuple(bad)} | {multiplicity} | "
            f"{int(multiplicity == 0)}"
        )
    lines.append("")
    return "\n".join(lines) + "\n"


def main() -> None:
    started = perf_counter()
    deterministic: list[str] = []
    deterministic.append("PROMPT60_CLEANROOM_AUDIT")
    deterministic.append("indexing=zero-based")
    deterministic.append("residue_order=ascending; tuple_order=lexicographic; pivot_order=ascending")

    for label, speeds in (
        ("D2", D2_TUPLE),
        ("D3", D3_TUPLE),
        ("RAW", RAW_LIFT_TUPLE),
    ):
        structure = tuple_structure(speeds)
        deterministic.append(f"{label}_speeds={fmt_tuple(speeds)}")
        deterministic.append(
            f"{label}_structure=positive:{structure['positive']},injective:{structure['injective']},"
            f"primitive:{structure['primitive']},N_divisible:{fmt_tuple(structure['N_divisible'])},"
            f"deletion_gcds:{fmt_tuple(structure['deletion_gcds'])}"
        )
        deterministic.append(
            f"{label}_deletion_cert_counts={fmt_tuple(structure['cert_counts'])}"
        )
        deterministic.append(
            f"{label}_deletion_lift_counts={fmt_tuple(structure['lift_counts'])}"
        )
        deterministic.append(f"{label}_first_deletion_certs={structure['first_certs']}")
        deterministic.append(f"{label}_first_deletion_lifts={structure['first_lifts']}")
        for row in pivot_summary(speeds):
            (
                pivot,
                speed,
                R,
                G,
                d1,
                d2,
                d3,
                h2,
                lower2,
                lower3,
                good,
            ) = row
            deterministic.append(
                f"{label}_pivot={pivot},speed={speed},R={R},G={G},D1={d1},D2={d2},"
                f"D3={d3},H2={h2},lower_D2={lower2},lower_D3={lower3},Gset={fmt_tuple(good)}"
            )

    d2_structure = tuple_structure(D2_TUPLE)
    first_d2_lift = next(
        cert for cert in d2_structure["first_lifts"] if cert is not None
    )
    deterministic.append(f"D2_first_exact_lift={first_d2_lift}")

    d3_audit = make_pivot_audit(D3_TUPLE, 4)
    closed_boundary = []
    for r in d3_audit.good:
        for i in d3_audit.shell:
            value = rho(d3_audit.modulus, r * D3_TUPLE[i])
            if r in d3_audit.shell[i] and d3_audit.N * value == d3_audit.n * d3_audit.p:
                closed_boundary.append((r, i, value))
    deterministic.append(f"D3_closed_shell_boundary_lifts={tuple(closed_boundary)}")

    raw_structure = tuple_structure(RAW_LIFT_TUPLE)
    assert all(count > 0 for count in raw_structure["cert_counts"])
    assert all(count == 0 for count in raw_structure["lift_counts"])
    raw_direct = direct_full_witness(RAW_LIFT_TUPLE, 5, 1)
    deterministic.append(f"RAW_direct_time=1/5,numerators={fmt_tuple(raw_direct[0])},full={raw_direct[1]}")

    prime_rows, Z0, Z1, rhs, sizes, fibers = p1_data(3, PRIME_P, PRIME_TUPLE)
    assert prime_forcing_premises(3, PRIME_P, PRIME_TUPLE)
    assert prime_forcing_witness(3, PRIME_P, PRIME_TUPLE) is None
    deterministic.append(
        f"PRIME_case=n:3,N:4,p:5,M:20,v:{fmt_tuple(PRIME_TUPLE)},"
        f"deletion_gcds:{fmt_tuple(tuple(gcd_all([20] + [PRIME_TUPLE[i] for i in range(3) if i != k]) for k in range(3)))},"
        f"bad_sizes:{fmt_tuple(sizes)},fibers:{fibers},Z0:{Z0},Z1:{Z1},P1_rhs:{rhs},safe:none"
    )
    deterministic.append(f"PRIME_n3_lex_first_failure={smallest_n3_prime_forcing_failure()}")
    supply_rows = []
    supply_product = 1
    for supply_p in (2, 3, 7, 11, 13):
        premise_count, failure = exhaustive_prime_forcing_status(3, supply_p)
        assert failure is None
        supply_rows.append((supply_p, premise_count))
        supply_product *= supply_p
    supply_threshold = 6 ** 6 // 3 ** 3
    assert supply_threshold == 1728 and supply_product == 6006
    assert supply_product > supply_threshold
    deterministic.append(
        f"PRIME_n3_verified_supply={tuple(supply_rows)},product={supply_product},"
        f"exact_threshold={supply_threshold},strictly_exceeds={supply_product > supply_threshold}"
    )

    p2_residues = (1, 2)
    p2_modulus = 9
    assert prime_forcing_premises(2, 3, p2_residues)
    p2_s = sign_class_count(p2_modulus, p2_residues)
    deterministic.append(
        f"P2_signclass_strengthening_counterexample=n:2,N:3,p:3,M:9,v:{fmt_tuple(p2_residues)},"
        f"s:{p2_s},2s:{2*p2_s},N:3"
    )
    p2_equality_residues = (1, 1, 1, 1, 1, 1, 2)
    p2_eq_n, p2_eq_p = 7, 3
    p2_eq_N = p2_eq_n + 1
    p2_eq_M = p2_eq_N * p2_eq_p
    assert prime_forcing_premises(p2_eq_n, p2_eq_p, p2_equality_residues)
    p2_eq_s = sign_class_count(p2_eq_M, p2_equality_residues)
    p2_eq_bound = p2_eq_s * (2 * p2_eq_p + p2_eq_N - 2)
    p2_eq_safe = tuple(
        r for r in range(p2_eq_M)
        if all(rho(p2_eq_M, r * value) >= p2_eq_p for value in p2_equality_residues)
    )
    assert (p2_eq_N, p2_eq_s, p2_eq_p) == (8, 2, 3)
    assert p2_eq_bound == p2_eq_M and p2_eq_safe
    deterministic.append(
        f"P2_nonstrict_equality_example=n:{p2_eq_n},N:{p2_eq_N},p:{p2_eq_p},M:{p2_eq_M},"
        f"v:{fmt_tuple(p2_equality_residues)},s:{p2_eq_s},coarse_bound:{p2_eq_bound},"
        f"safe_residues:{fmt_tuple(p2_eq_safe)}"
    )

    stress_tuples = (
        RAW_LIFT_TUPLE,
        D2_TUPLE,
        D3_TUPLE,
        (1, 2, 4),
        (1, 2, 6, 8, 10),
        *(tuple(range(1, m + 1)) for m in range(2, 9)),
        (15, 21, 40, 48, 56, 105, 126, 280, 1200),
    )
    smallest_cycle_avoid = (1, 2, 4)
    smallest_etas, smallest_graph, smallest_witnesses = active_graph(smallest_cycle_avoid)
    smallest_cycle = first_cycle(smallest_graph, {0, 1})
    assert smallest_cycle == (0, 1)
    deterministic.append(
        f"CONT_smallest_global_divisibility_cycle_avoidance_order=(n,height,lex),"
        f"speeds:{fmt_tuple(smallest_cycle_avoid)},N:4,divisible_index:2,cycle:{smallest_cycle},"
        f"etas:{fmt_tuple(fmt_fraction(x) for x in smallest_etas)}"
    )

    for speeds in stress_tuples:
        N = len(speeds) + 1
        etas, graph, edge_witnesses = active_graph(speeds)
        divisible = tuple(i for i, speed in enumerate(speeds) if speed % N == 0)
        eta_text = fmt_tuple("none" if eta is None else fmt_fraction(eta) for eta in etas)
        deterministic.append(
            f"CONT_speeds={fmt_tuple(speeds)},N={N},N_divisible={fmt_tuple(divisible)},etas={eta_text},"
            f"threshold=1/{N},graph={graph},cycle={first_cycle(graph)}"
        )
        for deleted in range(len(speeds)):
            eta, maximizers, active = continuous_eta(speeds, deleted)
            canonical = canonical_deletion_times(speeds, deleted)
            max_canonical = tuple(t for t in maximizers if t in canonical)
            deterministic.append(
                f"CONT_K={deleted},eta={'none' if eta is None else fmt_fraction(eta)},"
                f"maximizers={fmt_tuple(fmt_fraction(t) for t in maximizers)},"
                f"active={{{','.join(fmt_fraction(t)+':'+fmt_tuple(active[t]) for t in maximizers)}}},"
                f"canonical_count={len(canonical)},maximizers_canonical={fmt_tuple(fmt_fraction(t) for t in max_canonical)}"
            )
            if eta is not None and eta < Fraction(1, N):
                assert all(active[t] for t in maximizers)
                assert len(max_canonical) == len(maximizers)
                for t in maximizers:
                    for pivot in active[t]:
                        assert any(entry[0] == pivot for entry in canonical[t])
        for q in divisible:
            avoiding = first_cycle(graph, set(range(len(speeds))) - {q})
            deterministic.append(
                f"CONT_cycle_avoiding_divisible_index={q},speed={speeds[q]},cycle={avoiding}"
            )
            if avoiding is not None:
                edge_data = []
                for idx, source in enumerate(avoiding):
                    target = avoiding[(idx + 1) % len(avoiding)]
                    edge_data.append((source, target, fmt_fraction(edge_witnesses[(source, target)])))
                deterministic.append(f"CONT_avoiding_cycle_edge_times={tuple(edge_data)}")

    # Direct endpoint checks: equality belongs to H, not D.
    equality_checks = []
    for speeds in (D2_TUPLE, D3_TUPLE, RAW_LIFT_TUPLE):
        for pivot in range(len(speeds)):
            audit = make_pivot_audit(speeds, pivot)
            for i in audit.shell:
                for r in audit.shell[i]:
                    value = rho(audit.modulus, r * speeds[i])
                    if audit.N * value == audit.n * audit.p:
                        assert r not in audit.deep[i]
                        assert r in audit.shell[i]
                        equality_checks.append((speeds, pivot, i, r, value))
    deterministic.append(f"closed_lower_shell_equalities_checked={len(equality_checks)}")

    table_text = make_literal_tables()
    table_path = Path(__file__).with_name("prompt60_literal_tables.txt")
    table_path.write_text(table_text, encoding="utf-8", newline="\n")

    payload = "\n".join(deterministic) + "\n"
    source_hash = sha256(Path(__file__).read_bytes()).hexdigest()
    table_hash = sha256(table_text.encode("utf-8")).hexdigest()
    payload_hash = sha256(payload.encode("utf-8")).hexdigest()
    elapsed = perf_counter() - started

    print(payload, end="")
    print(f"python_version={platform.python_version()}")
    print(f"source_sha256={source_hash}")
    print(f"literal_tables_sha256={table_hash}")
    print(f"deterministic_payload_sha256={payload_hash}")
    print(f"runtime_seconds={elapsed:.6f}")


if __name__ == "__main__":
    main()
