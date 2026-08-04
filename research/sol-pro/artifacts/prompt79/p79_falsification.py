#!/usr/bin/env python3
"""Deterministic exact falsification audit for Prompt 79.

No external packages, randomness, floating-point arithmetic, files, stdin, or
network access are used. The program accepts no command-line arguments.
"""
from __future__ import annotations

import hashlib
import itertools
import math
import platform
import sys
from pathlib import Path
from typing import Iterable


def is_prime(x: int) -> bool:
    if x < 2:
        return False
    d = 2
    while d * d <= x:
        if x % d == 0:
            return x == d
        d += 1
    return True


def rho(modulus: int, x: int) -> int:
    y = x % modulus
    return min(y, modulus - y)



def centered_lift(modulus: int, x: int) -> int:
    """Unique representative h with -M/2 < h <= M/2."""
    y = x % modulus
    return y - modulus if 2 * y > modulus else y


def determinant(matrix: tuple[tuple[int, ...], ...]) -> int:
    """Exact Leibniz determinant; fixture matrices have order at most four."""
    order = len(matrix)
    if any(len(row) != order for row in matrix):
        raise ValueError("determinant requires a square matrix")
    total = 0
    for permutation in itertools.permutations(range(order)):
        inversions = sum(
            permutation[i] > permutation[j]
            for i in range(order)
            for j in range(i + 1, order)
        )
        term = 1
        for row, column in enumerate(permutation):
            term *= matrix[row][column]
        total += -term if inversions % 2 else term
    return total


def first_nonzero_minor(
    matrix: tuple[tuple[int, ...], ...]
) -> tuple[int, tuple[int, ...], tuple[int, ...], int] | None:
    order = len(matrix)
    for size in range(2, order + 1):
        for rows in itertools.combinations(range(order), size):
            for columns in itertools.combinations(range(order), size):
                submatrix = tuple(
                    tuple(matrix[row][column] for column in columns) for row in rows
                )
                value = determinant(submatrix)
                if value != 0:
                    return size, rows, columns, value
    return None

def bad_mask(modulus: int, p: int, v: int) -> int:
    mask = 0
    for r in range(modulus):
        if rho(modulus, r * v) < p:
            mask |= 1 << r
    return mask


def deletion_gcds(modulus: int, values: tuple[int, ...]) -> tuple[int, ...]:
    out: list[int] = []
    for deleted in range(len(values)):
        g = modulus
        for i, value in enumerate(values):
            if i != deleted:
                g = math.gcd(g, value)
        out.append(g)
    return tuple(out)


def admissible(n: int, p: int, values: tuple[int, ...]) -> bool:
    modulus = (n + 1) * p
    return (
        len(values) == n
        and all(0 <= value < modulus for value in values)
        and all(value % p != 0 for value in values)
        and all(g == 1 for g in deletion_gcds(modulus, values))
    )


def canonical_cover(
    values: tuple[int, ...], masks: dict[int, int], modulus: int
) -> tuple[int, ...]:
    full = (1 << modulus) - 1
    for size in range(1, len(values) + 1):
        for owners in itertools.combinations(range(len(values)), size):
            union = 0
            for owner in owners:
                union |= masks[values[owner]]
            if union == full:
                return owners
    raise AssertionError("canonical_cover called on a non-cover")


def private_residues(
    values: tuple[int, ...],
    owners: tuple[int, ...],
    masks: dict[int, int],
    modulus: int,
) -> tuple[tuple[int, ...], ...]:
    full = (1 << modulus) - 1
    answer: list[tuple[int, ...]] = []
    for owner in owners:
        others = 0
        for other in owners:
            if other != owner:
                others |= masks[values[other]]
        private = masks[values[owner]] & (~others) & full
        residues = tuple(r for r in range(modulus) if (private >> r) & 1)
        if not residues:
            raise AssertionError("minimal-cover owner has no private residue")
        answer.append(residues)
    return tuple(answer)


def crt_anchor_unit(n: int, p: int, anchor_value: int) -> int:
    """Least u in [0,Np) with u=1 mod N and u*(anchor/N)=1 mod p."""
    N = n + 1
    modulus = N * p
    if anchor_value % N != 0:
        raise ValueError("anchor is not divisible by N")
    w = (anchor_value // N) % p
    if w == 0:
        raise ValueError("anchor is divisible by p")
    target_p = pow(w, -1, p)
    candidates = [
        u
        for u in range(modulus)
        if u % N == 1 and u % p == target_p and math.gcd(u, modulus) == 1
    ]
    if len(candidates) != 1:
        raise AssertionError(f"CRT unit count was {len(candidates)}, expected one")
    return candidates[0]


def signed_anchor_signature(
    n: int,
    p: int,
    values: tuple[int, ...],
    owners: tuple[int, ...],
) -> tuple[int, int, tuple[int, ...], tuple[int, ...], tuple[int, ...], int]:
    """Normalize the least selected N-divisible owner exactly to N.

    Other coordinates are independently reflected so their p-components have
    positive least absolute representatives. Returns
    (anchor_position, u, eps, c, z, H).
    """
    N = n + 1
    modulus = N * p
    anchor_positions = [s for s, owner in enumerate(owners) if values[owner] % N == 0]
    if not anchor_positions:
        raise AssertionError("selected cover has no N-divisible owner")
    anchor_position = anchor_positions[0]
    anchor_owner = owners[anchor_position]
    u = crt_anchor_unit(n, p, values[anchor_owner])
    normalized = tuple((u * values[owner]) % modulus for owner in owners)
    if normalized[anchor_position] != N:
        raise AssertionError("anchor did not normalize exactly to N")

    eps: list[int] = []
    c: list[int] = []
    z: list[int] = []
    for s, x in enumerate(normalized):
        residue_p = x % p
        if residue_p == 0:
            raise AssertionError("selected coordinate became zero modulo p")
        if s == anchor_position:
            sign = 1
            lift = N
        else:
            centered = residue_p if residue_p <= p // 2 else residue_p - p
            sign = 1 if centered > 0 else -1
            lift = abs(centered)
        eps.append(sign)
        c.append((sign * x) % N)
        z.append(lift)
    return anchor_position, u, tuple(eps), tuple(c), tuple(z), max(z)


def first_bounded_exact_relation(
    z: tuple[int, ...], bound: int
) -> tuple[int, ...] | None:
    """Canonical primitive full-support relation with coefficients in [-bound,bound]."""
    alphabet = tuple(range(-bound, bound + 1))
    candidates: list[tuple[int, ...]] = []
    for coeffs in itertools.product(alphabet, repeat=len(z)):
        if any(c == 0 for c in coeffs):
            continue
        if math.gcd(*(abs(c) for c in coeffs)) != 1:
            continue
        if sum(c * value for c, value in zip(coeffs, z, strict=True)) == 0:
            candidates.append(coeffs)
    if not candidates:
        return None
    return min(
        candidates,
        key=lambda coeffs: (
            max(abs(c) for c in coeffs),
            sum(abs(c) for c in coeffs),
            coeffs,
        ),
    )


def format_tuple(values: Iterable[int]) -> str:
    return "(" + ",".join(str(x) for x in values) + ")"


def audit_fixture(n: int, p: int, required_fixture: tuple[int, ...]) -> list[str]:
    N = n + 1
    modulus = N * p
    candidates = tuple(v for v in range(modulus) if v % p != 0)
    masks = {v: bad_mask(modulus, p, v) for v in candidates}
    full = (1 << modulus) - 1

    premise_count = 0
    failure_count = 0
    repeated_premise_count = 0
    repeated_failure_count = 0
    coincident_premise_count = 0
    coincident_failure_count = 0
    first_failure: tuple[int, ...] | None = None
    first_repeated_premise: tuple[int, ...] | None = None
    first_coincident_premise: tuple[int, ...] | None = None
    cover_size_counts: dict[int, int] = {}

    for values in itertools.product(candidates, repeat=n):
        if not admissible(n, p, values):
            continue
        premise_count += 1
        repeated = len(set(values)) < n
        coincident = any(
            masks[values[i]] == masks[values[j]]
            for i, j in itertools.combinations(range(n), 2)
        )
        if repeated:
            repeated_premise_count += 1
            if first_repeated_premise is None:
                first_repeated_premise = values
        if coincident:
            coincident_premise_count += 1
            if first_coincident_premise is None:
                first_coincident_premise = values

        union = 0
        for value in values:
            union |= masks[value]
        if union != full:
            continue

        failure_count += 1
        if first_failure is None:
            first_failure = values
        if repeated:
            repeated_failure_count += 1
        if coincident:
            coincident_failure_count += 1
        owners = canonical_cover(values, masks, modulus)
        cover_size_counts[len(owners)] = cover_size_counts.get(len(owners), 0) + 1

    if first_failure is None:
        raise AssertionError("mandatory fixture search found no failure")
    if required_fixture != first_failure:
        raise AssertionError(
            f"required fixture {required_fixture} was not first failure {first_failure}"
        )

    owners = canonical_cover(first_failure, masks, modulus)
    private = private_residues(first_failure, owners, masks, modulus)
    anchor_position, u, eps, c, z, H = signed_anchor_signature(
        n, p, first_failure, owners
    )
    relation_bound = N
    relation = first_bounded_exact_relation(z, relation_bound)
    if relation is None:
        raise AssertionError("first normalized signature had no bounded exact relation")
    delta = sum(a * b for a, b in zip(relation, z, strict=True))
    if delta != 0:
        raise AssertionError("expected exact-relation Delta=0")

    bad_sizes = tuple(masks[first_failure[i]].bit_count() for i in owners)
    least_private = tuple(block[0] for block in private)
    centered_matrix = tuple(
        tuple(
            centered_lift(modulus, least_private[row] * first_failure[owners[column]])
            for column in range(len(owners))
        )
        for row in range(len(owners))
    )
    for row in range(len(owners)):
        for column in range(len(owners)):
            absolute = abs(centered_matrix[row][column])
            if row == column and not absolute < p:
                raise AssertionError("private owner diagonal was not strictly bad")
            if row != column and not absolute >= p:
                raise AssertionError("private off-diagonal owner was not safe")
    centered_determinant = determinant(centered_matrix)
    if centered_determinant != 0:
        raise AssertionError("mandatory natural private-point determinant was nonzero")
    nonzero_minor = first_nonzero_minor(centered_matrix)
    if nonzero_minor is None:
        raise AssertionError("expected a nonzero private-point minor")
    minor_value = nonzero_minor[3]
    if minor_value % N != 0 or (minor_value // N) % p != 0:
        raise AssertionError("expected minor/N to be a nonzero multiple of p")
    minor_over_N = minor_value // N
    fixture_union = 0
    for value in required_fixture:
        fixture_union |= masks[value]
    missing = tuple(r for r in range(modulus) if not ((fixture_union >> r) & 1))

    lines = [
        f"FIXTURE n={n} p={p} N={N} M={modulus}",
        "ORDER tuple_lexicographic; canonical_cover=(cardinality,increasing_owner_list); "
        "private_residue=increasing",
        f"DOMAIN candidates={len(candidates)} ordered_repeated_tuples={len(candidates) ** n}",
        f"PREMISE tuples={premise_count}",
        f"FAILURES tuples={failure_count} first={format_tuple(first_failure)}",
        f"REQUIRED fixture={format_tuple(required_fixture)} admissible={admissible(n,p,required_fixture)} "
        f"deletion_gcds={format_tuple(deletion_gcds(modulus, required_fixture))} missing={format_tuple(missing)}",
        f"CANONICAL owners={format_tuple(owners)} values={format_tuple(first_failure[i] for i in owners)} "
        f"bad_sizes={format_tuple(bad_sizes)} cover_size_counts={sorted(cover_size_counts.items())}",
        f"PRIVATE least={format_tuple(least_private)} all={private}",
        f"PRIVATE_CENTERED_MATRIX matrix={centered_matrix} determinant={centered_determinant} "
        f"first_nonzero_minor={nonzero_minor} minor_over_N={minor_over_N} "
        f"p_divides_minor_over_N={minor_over_N % p == 0}",
        f"NONUNITS gcd_with_M={format_tuple(math.gcd(modulus, value) for value in required_fixture)}",
        f"REPEATED premise={repeated_premise_count} failure={repeated_failure_count} "
        f"first_premise={format_tuple(first_repeated_premise or ())}",
        f"COINCIDENT_BAD_SET premise={coincident_premise_count} failure={coincident_failure_count} "
        f"first_premise={format_tuple(first_coincident_premise or ())}",
        f"ANCHOR position={anchor_position} owner={owners[anchor_position]} unit_u={u} eps={format_tuple(eps)} "
        f"c={format_tuple(c)} z={format_tuple(z)} H_fixture={H}",
        f"ZERO_DELTA first_tuple={format_tuple(first_failure)} coeff_bound={relation_bound} "
        f"coeff={format_tuple(relation)} dot_z={delta}",
    ]
    return lines


def small_prime_checks() -> list[str]:
    lines = ["SMALL_PRIME_CHECKS witness_r=N strict_badness=(rho<p)"]
    for n in (3, 4):
        N = n + 1
        for p in range(2, N + 1):
            if not is_prime(p):
                continue
            modulus = N * p
            candidates = tuple(v for v in range(modulus) if v % p != 0)
            values = tuple(rho(modulus, N * v) for v in candidates)
            minimum = min(values)
            equality_count = sum(value == p for value in values)
            if minimum < p:
                raise AssertionError("small-prime witness failed")
            lines.append(
                f"SMALL n={n} p={p} p_divides_N={N % p == 0} candidates={len(candidates)} "
                f"min_rho={minimum} equality_count={equality_count} SAFE={minimum >= p}"
            )
    # Explicit rejected deletion-gcd edge cases.
    for n, p, values in (
        (3, 5, (1, 2, 4)),
        (4, 7, (1, 5, 10, 15)),
    ):
        modulus = (n + 1) * p
        lines.append(
            f"DELETION_EDGE n={n} p={p} tuple={format_tuple(values)} "
            f"p_nondivisible={all(v % p != 0 for v in values)} "
            f"deletion_gcds={format_tuple(deletion_gcds(modulus, values))} "
            f"admissible={admissible(n,p,values)}"
        )
    # Equality is safe because badness is strict rho<p.
    n, p, v, r = 4, 5, 1, 5
    modulus = (n + 1) * p
    value = rho(modulus, r * v)
    lines.append(
        f"EQUALITY_SAFE n={n} p={p} M={modulus} r={r} v={v} rho={value} "
        f"bad={value < p} safe={value >= p}"
    )
    return lines


def main() -> int:
    if len(sys.argv) != 1:
        print("usage: p79_falsification.py", file=sys.stderr)
        return 64

    source = Path(__file__).read_bytes()
    print("P79_EXACT_AUDIT_V1")
    print(f"SOURCE_SHA256 {hashlib.sha256(source).hexdigest()}")
    print(f"INTERPRETER {platform.python_implementation()} {platform.python_version()}")
    print("COMMAND python3 p79_falsification.py")
    print("INPUT none; arguments_or_stdin_not_accepted; extra_argument_exit=64")
    print("ARITHMETIC exact_integer_only; randomness=none; external_packages=none")
    print()

    for line in small_prime_checks():
        print(line)
    print()

    for n, p, fixture in (
        (3, 5, (1, 3, 4)),
        (4, 7, (1, 3, 4, 5)),
    ):
        for line in audit_fixture(n, p, fixture):
            print(line)
        print()

    print("DISPOSITION_SIGNAL ZERO_DELTA_ON_FIRST_LEX_FAILURE")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
