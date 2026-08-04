#!/usr/bin/env python3
"""Prompt 92 verifier B: primewise deletion test, truncated valuations, bitset covers."""
from __future__ import annotations

import hashlib
import itertools
import json
import platform
from pathlib import Path
from typing import Any

SCAN_PAIRS = ((3, 2), (3, 4), (3, 8), (3, 16), (4, 2), (4, 4), (4, 8))


def checked_tuple(n: Any, q: Any, modulus: Any, data: Any) -> tuple[int, ...]:
    if type(n) is not int or n < 3:
        raise ValueError("invalid dimension")
    if type(q) is not int or q < 1:
        raise ValueError("invalid dyadic scale")
    if type(modulus) is not int or modulus != q * (n + 1):
        raise ValueError("invalid modulus")
    if type(data) not in (tuple, list) or len(data) != n:
        raise ValueError("invalid tuple length")
    z = tuple(data)
    if any(type(a) is not int or a < 0 or a >= modulus for a in z):
        raise ValueError("invalid representative")
    return z


def distinct_prime_divisors(t: int) -> tuple[int, ...]:
    ans = []
    p = 2
    while p * p <= t:
        if t % p == 0:
            ans.append(p)
            while t % p == 0:
                t //= p
        p = 3 if p == 2 else p + 2
    if t > 1:
        ans.append(t)
    return tuple(ans)


def primewise_all_deletions(primes: tuple[int, ...], data: tuple[int, ...]) -> bool:
    # For each p|M, every deletion leaves a p-nonmultiple iff at least two labels are p-nonmultiples.
    for p in primes:
        nonmultiples = 0
        for a in data:
            if a % p:
                nonmultiples += 1
        if nonmultiples < 2:
            return False
    return True


def truncated_two_order(a: int, exponent: int) -> int:
    if a == 0:
        return exponent
    s = 0
    while s < exponent and (a & 1) == 0:
        s += 1
        a >>= 1
    return s


def product_not_divisible_by_q(data: tuple[int, ...], exponent: int) -> bool:
    total = 0
    for a in data:
        total += truncated_two_order(a, exponent)
        if total >= exponent:
            return False
    return True


def owner_masks(modulus: int, q: int) -> tuple[int, ...]:
    table = []
    for a in range(modulus):
        bits = 0
        for r in range(modulus):
            y = (r * a) % modulus
            cyc = y if y <= modulus - y else modulus - y
            if cyc < q:
                bits |= 1 << r
        table.append(bits)
    return tuple(table)


def mask_covers_all(data: tuple[int, ...], masks: tuple[int, ...], target: int) -> bool:
    union = 0
    for a in data:
        union |= masks[a]
    return union == target


def independent_fixtures() -> dict[str, Any]:
    masks8 = owner_masks(8, 2)
    primes8 = distinct_prime_divisors(8)
    repeated = checked_tuple(3, 2, 8, [1, 1, 2])
    with_zero = checked_tuple(3, 2, 8, [0, 1, 1])
    deletion_fail = checked_tuple(3, 2, 8, [1, 2, 2])

    rejects = []
    for args in (
        (3, 2, 8, [-1, 1, 2]),
        (3, 2, 8, [1.5, 1, 2]),
        (3, 2, 8, [1, 1, 8]),
        (3, 2, 8, [1, 2]),
        (3, 2, 7, [1, 1, 2]),
        (1, 2, 4, [1]),
    ):
        try:
            checked_tuple(*args)
            rejects.append(False)
        except ValueError:
            rejects.append(True)

    # Compute deletion failures by the primewise criterion after each actual deletion,
    # independently from implementation A's gcd loop.
    deletion_label_status = []
    for k in range(3):
        survivors = tuple(a for i, a in enumerate(deletion_fail) if i != k)
        deletion_label_status.append(all(any(a % p for a in survivors) for p in primes8))

    prompt = checked_tuple(4, 8, 40, [1, 4, 19, 20])
    masks40 = owner_masks(40, 8)
    return {
        "strict_bits_owner_1_M8": [r for r in range(8) if (masks8[1] >> r) & 1],
        "equality_r2_and_r6_absent": not ((masks8[1] >> 2) & 1) and not ((masks8[1] >> 6) & 1),
        "r0_bit_present_for_zero_and_nonzero": bool(masks8[0] & 1) and bool(masks8[1] & 1),
        "repeated_primewise_premise": primewise_all_deletions(primes8, repeated),
        "repeated_product_divisible": not product_not_divisible_by_q(repeated, 1),
        "repeated_masks_equal_but_label_slots_retained": masks8[repeated[0]] == masks8[repeated[1]] and len(repeated) == 3,
        "zero_primewise_premise": primewise_all_deletions(primes8, with_zero),
        "zero_product_divisible": not product_not_divisible_by_q(with_zero, 1),
        "deletion_fixture_label_status": deletion_label_status,
        "malformed_rejected": all(rejects),
        "deliberate_weak_endpoint_includes_equalities": (min(2, 8 - 2) <= 2) and (min(6, 8 - 6) <= 2),
        "prompt84_q8": {
            "primewise_premise": primewise_all_deletions(distinct_prime_divisors(40), prompt),
            "full_cover": mask_covers_all(prompt, masks40, (1 << 40) - 1),
            "aggregate_divisible": not product_not_divisible_by_q(prompt, 3),
            "no_individual_multiple_of_q": all(a % 8 != 0 for a in prompt),
        },
    }


def scan(n: int, q: int) -> dict[str, Any]:
    modulus = (n + 1) * q
    exponent = q.bit_length() - 1
    primes = distinct_prime_divisors(modulus)
    masks = owner_masks(modulus, q)
    all_bits = (1 << modulus) - 1
    c_raw = c_del = c_nondiv = c_cover = 0
    first = None

    for data in itertools.product(range(modulus), repeat=n):
        c_raw += 1
        if not primewise_all_deletions(primes, data):
            continue
        c_del += 1
        if not product_not_divisible_by_q(data, exponent):
            continue
        c_nondiv += 1
        if mask_covers_all(data, masks, all_bits):
            c_cover += 1
            if first is None:
                first = list(data)

    return {
        "n": n,
        "q": q,
        "M": modulus,
        "raw_tuples": c_raw,
        "deletion_gcd_premise": c_del,
        "product_nondivisible_premise": c_nondiv,
        "full_cover_failures": c_cover,
        "lexicographically_first_failure": first,
    }


def main() -> None:
    own_hash = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    report = {
        "implementation": "B",
        "language": "Python",
        "python_version": platform.python_version(),
        "implementation_description": "primewise all-deletion characterization; total truncated 2-adic valuation; independently built owner bitsets",
        "domain": "all labelled tuples, itertools.product lexicographic order",
        "case_order": [list(pair) for pair in SCAN_PAIRS],
        "strict_test": "owner bit set only when cyclic representative is < q",
        "r_zero_included": True,
        "first_failure_rule": "first in case order, then tuple lexicographic order",
        "source_sha256": own_hash,
        "fixtures": independent_fixtures(),
        "cases": [scan(n, q) for n, q in SCAN_PAIRS],
        "completion_marker": "COMPLETE",
    }
    print(json.dumps(report, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
