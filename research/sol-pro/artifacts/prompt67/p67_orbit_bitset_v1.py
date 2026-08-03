#!/usr/bin/env python3
"""Independent Prompt 67 verifier.

This implementation does not import or call the literal C++ verifier. It
quotients ordered tuples by the coordinate-permutation action, enumerating one
nondecreasing representative with repetitions preserved. Orbit sizes recover
exact ordered counts. Prime forcing is tested by unions of precomputed strict
bad-set bitsets. The first clear bit is the canonical first witness.

For cross-replay, it independently expands each accepted orbit back to every
ordered tuple and writes the same one-byte outcome map contract as the literal
verifier: 255 for a nonpremise tuple, 254 for a forcing failure, and 0..M-1 for
the first safe witness. The two map families are then compared byte-for-byte.
"""

from __future__ import annotations

from collections import Counter
from hashlib import sha256
from itertools import combinations_with_replacement, permutations
from math import factorial, gcd
import json
import os
from pathlib import Path

VERSION = "p67-orbit-bitset-v1"
OUTCOME_ENCODING = (
    "one byte per lexicographic ordered tuple: 255 nonpremise, "
    "254 failure, 0..M-1 first witness"
)


def rho(modulus: int, x: int) -> int:
    y = x % modulus
    return min(y, modulus - y)


def gcd_with_deletion(modulus: int, values: tuple[int, ...], deleted: int) -> int:
    g = modulus
    for i, value in enumerate(values):
        if i != deleted:
            g = gcd(g, value)
    return g


def premises(n: int, p: int, values: tuple[int, ...]) -> bool:
    modulus = (n + 1) * p
    return (
        len(values) == n
        and all(0 <= value < modulus and value % p != 0 for value in values)
        and all(gcd_with_deletion(modulus, values, k) == 1 for k in range(n))
    )


def orbit_weight(values: tuple[int, ...]) -> int:
    out = factorial(len(values))
    for multiplicity in Counter(values).values():
        out //= factorial(multiplicity)
    return out


def lex_ordinal(values: tuple[int, ...], modulus: int) -> int:
    """Ordinal for lexicographic order with the last coordinate fastest."""
    out = 0
    for value in values:
        out = out * modulus + value
    return out


def first_zero_bit(mask: int, width: int) -> int | None:
    full = (1 << width) - 1
    missing = full ^ mask
    if missing == 0:
        return None
    low = missing & -missing
    return low.bit_length() - 1


def first_bad_index_certificate(
    n: int, p: int, values: tuple[int, ...]
) -> tuple[int, ...]:
    modulus = (n + 1) * p
    out: list[int] = []
    for r in range(modulus):
        for i, value in enumerate(values):
            if rho(modulus, r * value) < p:
                out.append(i)
                break
        else:
            raise AssertionError("cover certificate requested for a non-cover")
    return tuple(out)


def distance_rows(
    n: int, p: int, values: tuple[int, ...]
) -> tuple[tuple[int, ...], ...]:
    modulus = (n + 1) * p
    return tuple(
        tuple(rho(modulus, r * value) for value in values)
        for r in range(modulus)
    )


def run_case(n: int, p: int, scope: str, cert_dir: Path) -> dict[str, object]:
    N = n + 1
    modulus = N * p
    tuple_total = modulus**n
    full = (1 << modulus) - 1

    bad_masks: list[int] = []
    for value in range(modulus):
        mask = 0
        for r in range(modulus):
            if rho(modulus, r * value) < p:
                mask |= 1 << r
        bad_masks.append(mask)

    # Default is nonpremise. Premise orbits are independently expanded below.
    outcome_map = bytearray([255]) * tuple_total
    expanded_premise_assignments = 0
    failure_cover_records: list[tuple[int, bytes]] = []

    premise_total = 0
    failure_total = 0
    first_failure: tuple[int, ...] | None = None
    witness_histogram = [0] * modulus
    boundary_witness_tuple_count = 0
    collision_pattern_counts: dict[str, list[int]] = {}
    canonical_digest = sha256()
    representative_total = 0
    premise_representative_total = 0

    # combinations_with_replacement is lexicographic in the nondecreasing reps.
    for values in combinations_with_replacement(range(modulus), n):
        representative_total += 1
        if not premises(n, p, values):
            continue
        premise_representative_total += 1
        weight = orbit_weight(values)
        premise_total += weight
        pattern = tuple(sorted(Counter(values).values(), reverse=True))
        pattern_key = "+".join(map(str, pattern))
        collision_pattern_counts.setdefault(pattern_key, [0, 0])[0] += weight

        union = 0
        for value in values:
            union |= bad_masks[value]
        witness = first_zero_bit(union, modulus)
        outcome_code = 254 if witness is None else witness

        canonical_digest.update(bytes([n, p]))
        for value in values:
            canonical_digest.update(value.to_bytes(4, "little"))
        canonical_digest.update(weight.to_bytes(8, "little"))
        if witness is None:
            failure_total += weight
            collision_pattern_counts[pattern_key][1] += weight
            canonical_digest.update(b"F")
            if first_failure is None:
                first_failure = values
        else:
            witness_histogram[witness] += weight
            canonical_digest.update(b"S")
            canonical_digest.update(witness.to_bytes(4, "little"))
            if any(rho(modulus, witness * value) == p for value in values):
                boundary_witness_tuple_count += weight

        # Structural cross-certificate: independently reconstruct every ordered
        # tuple in the orbit. set(permutations(...)) is exact here (n <= 4).
        ordered_orbit = set(permutations(values))
        if len(ordered_orbit) != weight:
            raise AssertionError("orbit expansion weight mismatch")
        for ordered_values in ordered_orbit:
            ordinal = lex_ordinal(ordered_values, modulus)
            if outcome_map[ordinal] != 255:
                raise AssertionError("duplicate orbit assignment")
            outcome_map[ordinal] = outcome_code
            expanded_premise_assignments += 1
            if witness is None:
                cover = bytes(first_bad_index_certificate(n, p, ordered_values))
                if len(cover) != modulus:
                    raise AssertionError("failure cover width mismatch")
                failure_cover_records.append((ordinal, cover))

    if sum(witness_histogram) + failure_total != premise_total:
        raise AssertionError("weighted count mismatch")
    if expanded_premise_assignments != premise_total:
        raise AssertionError("expanded premise assignment mismatch")
    if sum(byte != 255 for byte in outcome_map) != premise_total:
        raise AssertionError("outcome-map premise count mismatch")
    if sum(byte == 254 for byte in outcome_map) != failure_total:
        raise AssertionError("outcome-map failure count mismatch")

    cert_name = f"p67_outcomes_n{n}_p{p}_orbit.bin"
    cert_path = cert_dir / cert_name
    cert_path.write_bytes(outcome_map)
    outcome_sha = sha256(outcome_map).hexdigest()

    failure_cover_records.sort(key=lambda record: record[0])
    if len(failure_cover_records) != failure_total:
        raise AssertionError("failure cover record count mismatch")
    failure_cover_stream = bytearray()
    for ordinal, cover in failure_cover_records:
        failure_cover_stream.extend(ordinal.to_bytes(8, "little"))
        failure_cover_stream.extend(cover)
    failure_cert_name = f"p67_failure_covers_n{n}_p{p}_orbit.bin"
    failure_cert_path = cert_dir / failure_cert_name
    failure_cert_path.write_bytes(failure_cover_stream)
    failure_cover_sha = sha256(failure_cover_stream).hexdigest()

    result: dict[str, object] = {
        "verifier": VERSION,
        "scope": scope,
        "n": n,
        "N": N,
        "p": p,
        "M": modulus,
        "tuple_total": tuple_total,
        "orbit_representative_total": representative_total,
        "premise_orbit_representative_total": premise_representative_total,
        "premise_total": premise_total,
        "failure_total": failure_total,
        "success_total": premise_total - failure_total,
        "first_failure": list(first_failure) if first_failure is not None else None,
        "first_failure_cover_first_bad_index_by_r": (
            list(first_bad_index_certificate(n, p, first_failure))
            if first_failure is not None
            else None
        ),
        "first_failure_distance_rows": (
            [list(row) for row in distance_rows(n, p, first_failure)]
            if first_failure is not None
            else None
        ),
        "first_witness_histogram": witness_histogram,
        "first_witness_boundary_tuple_count": boundary_witness_tuple_count,
        "collision_pattern_ordered_counts": {
            key: {"premise_total": value[0], "failure_total": value[1]}
            for key, value in sorted(collision_pattern_counts.items())
        },
        "canonical_orbit_record_sha256": canonical_digest.hexdigest(),
        "outcome_map_file": cert_name,
        "outcome_map_sha256": outcome_sha,
        "outcome_map_encoding": OUTCOME_ENCODING,
        "outcome_map_expanded_premise_assignments": expanded_premise_assignments,
        "failure_cover_file": failure_cert_name,
        "failure_cover_record_count": len(failure_cover_records),
        "failure_cover_sha256": failure_cover_sha,
        "failure_cover_encoding": (
            "records in failed-tuple lex order: uint64 little-endian tuple ordinal, "
            "then M one-byte first-bad-coordinate indices for r=0..M-1"
        ),
        "quotient": (
            "coordinate permutations S_n; repetitions retained; "
            "orbit weight n!/prod multiplicity!"
        ),
        "representative_order": "nondecreasing tuples, lexicographic",
        "tuple_order": "lexicographic over [0,M)^n; last coordinate fastest",
        "witness_order": "first clear bit r=0,1,...,M-1",
        "global_early_stop": False,
    }
    return result


def main() -> None:
    cert_dir = Path(os.environ.get("P67_CERT_DIR", "."))
    cert_dir.mkdir(parents=True, exist_ok=True)
    cases = [(3, 5, "mandatory-baseline")]
    cases.extend((4, p, "new-interval-n4-[2,7]") for p in (2, 3, 5, 7))
    for n, p, scope in cases:
        print(
            json.dumps(
                run_case(n, p, scope, cert_dir),
                sort_keys=False,
                separators=(",", ":"),
            )
        )


if __name__ == "__main__":
    main()
