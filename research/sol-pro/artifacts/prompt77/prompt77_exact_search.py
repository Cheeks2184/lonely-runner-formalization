#!/usr/bin/env python3
"""Deterministic exact-certification sweep for Prompt 77.

Fixed domain: primitive strictly increasing tuples with 2 <= n <= 6 and
1 <= a_i <= 14, ordered by n and then lexicographically.

Floating-point linear algebra is used only to propose an integer Rayleigh
vector. Acceptance is by a rigorous outward-rounded interval evaluation of the
corresponding cyclotomic quadratic form. Cosine enclosures are derived from an
exact rational Machin interval for pi and Taylor remainder bounds.

Malformed-input behavior: this script accepts no command-line arguments. Any
argument causes a diagnostic on stderr and exit status 2.
"""

from __future__ import annotations

import decimal
import hashlib
import itertools
import json
import math
import os
import platform
import sys
from collections import defaultdict
from fractions import Fraction
from typing import Dict, Iterable, List, Sequence, Tuple

import numpy as np

SCRIPT_VERSION = "1.0.0"
DECIMAL_PRECISION = 90
PI_GUARD_DIGITS = 20
COS_TAYLOR_TERMS = 70  # last included index k; degree 140
PROPOSAL_SCALES = (10_000, 100_000, 1_000_000, 10_000_000)
DOMAIN = {
    "n_min": 2,
    "n_max": 6,
    "speed_min": 1,
    "speed_max": 14,
    "primitive": "gcd of all entries equals 1",
    "ordering": "n ascending, then itertools.combinations lexicographic order",
}

Ctx = decimal.Context
D = decimal.Decimal
CTX_LO = Ctx(prec=DECIMAL_PRECISION, rounding=decimal.ROUND_FLOOR)
CTX_HI = Ctx(prec=DECIMAL_PRECISION, rounding=decimal.ROUND_CEILING)
CTX_NEAR = Ctx(prec=DECIMAL_PRECISION, rounding=decimal.ROUND_HALF_EVEN)

Interval = Tuple[D, D]


def _fraction_to_decimal_interval(x: Fraction) -> Interval:
    num = D(x.numerator)
    den = D(x.denominator)
    return CTX_LO.divide(num, den), CTX_HI.divide(num, den)


def _atan_reciprocal_interval(q: int, target_digits: int) -> Tuple[Fraction, Fraction]:
    """Exact alternating-series enclosure for atan(1/q)."""
    if q <= 1:
        raise ValueError("q must be greater than 1")
    eps = Fraction(1, 10 ** target_digits)
    total = Fraction(0)
    k = 0
    while True:
        term = Fraction(1, (2 * k + 1) * (q ** (2 * k + 1)))
        total = total + term if k % 2 == 0 else total - term
        next_k = k + 1
        next_term = Fraction(1, (2 * next_k + 1) * (q ** (2 * next_k + 1)))
        if next_term < eps:
            if k % 2 == 0:  # positive partial sum is above the limit
                return total - next_term, total
            return total, total + next_term
        k += 1


def _pi_interval() -> Interval:
    digits = DECIMAL_PRECISION + PI_GUARD_DIGITS
    a_lo, a_hi = _atan_reciprocal_interval(5, digits)
    b_lo, b_hi = _atan_reciprocal_interval(239, digits)
    # Machin: pi = 16 atan(1/5) - 4 atan(1/239)
    lo = 16 * a_lo - 4 * b_hi
    hi = 16 * a_hi - 4 * b_lo
    dlo, _ = _fraction_to_decimal_interval(lo)
    _, dhi = _fraction_to_decimal_interval(hi)
    return dlo, dhi


PI_INTERVAL = _pi_interval()


def _add(a: Interval, b: Interval) -> Interval:
    return CTX_LO.add(a[0], b[0]), CTX_HI.add(a[1], b[1])


def _sub(a: Interval, b: Interval) -> Interval:
    return CTX_LO.subtract(a[0], b[1]), CTX_HI.subtract(a[1], b[0])


def _mul_nonnegative(a: Interval, b: Interval) -> Interval:
    if a[0] < 0 or b[0] < 0:
        raise ValueError("_mul_nonnegative received a negative interval")
    return CTX_LO.multiply(a[0], b[0]), CTX_HI.multiply(a[1], b[1])


def _mul_int(a: Interval, c: int) -> Interval:
    dc = D(c)
    if c >= 0:
        return CTX_LO.multiply(a[0], dc), CTX_HI.multiply(a[1], dc)
    return CTX_LO.multiply(a[1], dc), CTX_HI.multiply(a[0], dc)


def _div_pos_int(a: Interval, c: int) -> Interval:
    if c <= 0:
        raise ValueError("positive divisor required")
    dc = D(c)
    return CTX_LO.divide(a[0], dc), CTX_HI.divide(a[1], dc)


def _mul_fraction_nonnegative(a: Interval, q: Fraction) -> Interval:
    if q < 0 or a[0] < 0:
        raise ValueError("nonnegative inputs required")
    num = D(q.numerator)
    den = D(q.denominator)
    lo = CTX_LO.divide(CTX_LO.multiply(a[0], num), den)
    hi = CTX_HI.divide(CTX_HI.multiply(a[1], num), den)
    return lo, hi


def _cos_at_nonnegative_decimal(x: D) -> Interval:
    """Outward Taylor enclosure of cos(x) for exact finite Decimal x in [0, pi/2]."""
    if x < 0:
        raise ValueError("x must be nonnegative")
    x_iv = (x, x)
    x2 = _mul_nonnegative(x_iv, x_iv)
    term: Interval = (D(1), D(1))
    total: Interval = (D(1), D(1))
    sign = -1
    for k in range(1, COS_TAYLOR_TERMS + 1):
        term = _mul_nonnegative(term, x2)
        term = _div_pos_int(term, (2 * k - 1) * (2 * k))
        total = _sub(total, term) if sign < 0 else _add(total, term)
        sign *= -1
    # Lagrange remainder bounded by the next absolute term because |d^m cos| <= 1.
    rem = _mul_nonnegative(term, x2)
    rem = _div_pos_int(rem, (2 * COS_TAYLOR_TERMS + 1) * (2 * COS_TAYLOR_TERMS + 2))
    return CTX_LO.subtract(total[0], rem[1]), CTX_HI.add(total[1], rem[1])


_COS_CACHE: Dict[Tuple[int, int], Interval] = {}


def cos_root_interval(modulus: int, exponent: int) -> Interval:
    """Rigorous interval for cos(2*pi*exponent/modulus)."""
    if modulus <= 0:
        raise ValueError("modulus must be positive")
    k = exponent % modulus
    key = (modulus, k)
    if key in _COS_CACHE:
        return _COS_CACHE[key]
    k = min(k, modulus - k)
    if k == 0:
        ans = (D(1), D(1))
    elif 4 * k == modulus:
        ans = (D(0), D(0))
    else:
        if 4 * k < modulus:
            alpha = Fraction(2 * k, modulus)
            sign = 1
        else:
            # cos(theta) = -cos(pi-theta), with pi-theta in (0, pi/2).
            alpha = Fraction(modulus - 2 * k, modulus)
            sign = -1
        x_iv = _mul_fraction_nonnegative(PI_INTERVAL, alpha)
        # cos is decreasing on [0, pi/2]. Endpoint point-enclosures therefore combine as below.
        at_hi = _cos_at_nonnegative_decimal(x_iv[1])
        at_lo = _cos_at_nonnegative_decimal(x_iv[0])
        pos = (at_hi[0], at_lo[1])
        ans = pos if sign > 0 else (-pos[1], -pos[0])
    _COS_CACHE[key] = ans
    _COS_CACHE[(modulus, (-exponent) % modulus)] = ans
    return ans


def rho(modulus: int, x: int) -> int:
    y = x % modulus
    return min(y, modulus - y)


def exact_weight(a: Sequence[int], pivot: int) -> Tuple[int, List[int], int]:
    n = len(a)
    N = n + 1
    p = a[pivot]
    M = N * p
    w = [0] * M
    G = 0
    for r in range(M):
        if r % N == 0:
            continue
        mu = 0
        for i, ai in enumerate(a):
            if i != pivot and rho(M, r * ai) < p:
                mu += 1
        w[r] = 1 - mu
        if mu == 0:
            G += 1
    return M, w, G


def numeric_block(a: Sequence[int], pivot: int) -> np.ndarray:
    M, w, _ = exact_weight(a, pivot)
    d = 2 * len(a)
    coeff = np.fft.ifft(np.asarray(w, dtype=float))
    idx = (np.arange(d)[None, :] - np.arange(d)[:, None]) % M
    K = coeff[idx]
    return ((K + K.conj().T) / 2).real


def primitive_tuples() -> Iterable[Tuple[int, ...]]:
    for n in range(DOMAIN["n_min"], DOMAIN["n_max"] + 1):
        for a in itertools.combinations(
            range(DOMAIN["speed_min"], DOMAIN["speed_max"] + 1), n
        ):
            if math.gcd(*a) == 1:
                yield a


def reduce_integer_vector(q: np.ndarray) -> Tuple[int, ...]:
    vals = [int(x) for x in q]
    g = 0
    for x in vals:
        g = math.gcd(g, abs(x))
    if g > 1:
        vals = [x // g for x in vals]
    for x in vals:
        if x < 0:
            vals = [-y for y in vals]
            break
        if x > 0:
            break
    return tuple(vals)


def exact_rayleigh_interval(a: Sequence[int], pivot: int, q: Sequence[int]) -> Interval:
    M, w, _ = exact_weight(a, pivot)
    d = 2 * len(a)
    if len(q) != d or not any(q):
        raise ValueError("nonzero vector of length 2*n required")
    autocorr = [sum(q[m] * q[m + gap] for m in range(d - gap)) for gap in range(d)]
    total: Interval = (D(0), D(0))
    for gap in range(d):
        factor = autocorr[gap] if gap == 0 else 2 * autocorr[gap]
        if factor == 0:
            continue
        for r, wr in enumerate(w):
            coefficient = factor * wr
            if coefficient:
                total = _add(total, _mul_int(cos_root_interval(M, gap * r), coefficient))
    return _div_pos_int(total, M)


def propose_certificates(a: Sequence[int]) -> Iterable[Tuple[int, float, Tuple[int, ...]]]:
    proposals = []
    for pivot in range(len(a)):
        K = numeric_block(a, pivot)
        eigenvalues, eigenvectors = np.linalg.eigh(K)
        proposals.append((float(eigenvalues[-1]), pivot, eigenvectors[:, -1]))
    proposals.sort(reverse=True, key=lambda item: item[0])
    seen = set()
    for eig, pivot, vector in proposals:
        for scale in PROPOSAL_SCALES:
            q = reduce_integer_vector(np.rint(vector * scale).astype(np.int64))
            key = (pivot, q)
            if any(q) and key not in seen:
                seen.add(key)
                yield pivot, eig, q


def decimal_string(x: D) -> str:
    return format(x, "f")


def main() -> int:
    if len(sys.argv) != 1:
        print("error: prompt77_exact_search.py accepts no arguments", file=sys.stderr)
        return 2

    script_path = os.path.abspath(__file__)
    with open(script_path, "rb") as fh:
        source_sha = hashlib.sha256(fh.read()).hexdigest()

    out_dir = os.path.dirname(script_path)
    cert_path = os.path.join(out_dir, "prompt77_search_certificates.jsonl")
    summary_path = os.path.join(out_dir, "prompt77_search_summary.json")

    counts = defaultdict(int)
    g_vectors = []
    unresolved = []
    first_failure = None
    cert_hasher = hashlib.sha256()
    minimum_unit_lower: D | None = None
    minimum_unit_tuple = None

    with open(cert_path, "w", encoding="utf-8", newline="\n") as cert_file:
        for a in primitive_tuples():
            n = len(a)
            counts[n] += 1
            certificate = None
            for pivot, diagnostic_eigenvalue, q in propose_certificates(a):
                interval = exact_rayleigh_interval(a, pivot, q)
                if interval[0] > 0:
                    norm2 = sum(x * x for x in q)
                    unit_lower = CTX_LO.divide(interval[0], D(norm2))
                    _, _, G = exact_weight(a, pivot)
                    certificate = {
                        "tuple": list(a),
                        "n": n,
                        "pivot_index_zero_based": pivot,
                        "pivot_speed": a[pivot],
                        "G_pivot": G,
                        "integer_rayleigh_vector": list(q),
                        "norm_squared": norm2,
                        "rayleigh_interval": [decimal_string(interval[0]), decimal_string(interval[1])],
                        "unit_rayleigh_lower_bound": decimal_string(unit_lower),
                        "floating_top_eigenvalue_diagnostic_only": format(diagnostic_eigenvalue, ".17g"),
                    }
                    if minimum_unit_lower is None or unit_lower < minimum_unit_lower:
                        minimum_unit_lower = unit_lower
                        minimum_unit_tuple = list(a)
                    break
            if certificate is None:
                # The program never calls an unresolved tuple a failure. It aborts the exact sweep instead.
                unresolved.append(list(a))
                break
            line = json.dumps(certificate, sort_keys=True, separators=(",", ":"))
            cert_file.write(line + "\n")
            cert_hasher.update((line + "\n").encode("utf-8"))
            g_vectors.append(certificate["G_pivot"])

    if unresolved:
        status = "aborted-unresolved"
    else:
        status = "complete-no-negative-semidefinite-all-block-tuple"

    cert_sha = cert_hasher.hexdigest()
    summary = {
        "schema": "prompt77-exact-search-summary-v1",
        "status": status,
        "script_version": SCRIPT_VERSION,
        "source_file": os.path.basename(script_path),
        "source_sha256": source_sha,
        "certificate_file": os.path.basename(cert_path),
        "certificate_sha256": cert_sha,
        "language": platform.python_version(),
        "implementation": platform.python_implementation(),
        "numpy_version": np.__version__,
        "domain": DOMAIN,
        "counts_by_n": {str(k): counts[k] for k in sorted(counts)},
        "total_certified_tuples": sum(counts.values()) if not unresolved else sum(counts.values()) - 1,
        "first_failure": first_failure,
        "unresolved": unresolved,
        "minimum_certified_unit_rayleigh_lower_bound": (
            decimal_string(minimum_unit_lower) if minimum_unit_lower is not None else None
        ),
        "minimum_bound_tuple": minimum_unit_tuple,
        "interval_policy": {
            "decimal_precision": DECIMAL_PRECISION,
            "pi": "exact rational Machin enclosure: 16*atan(1/5)-4*atan(1/239)",
            "atan": "alternating rational series with next-term enclosure",
            "cos": f"outward Decimal Taylor enclosure through degree {2 * COS_TAYLOR_TERMS} plus Lagrange remainder",
            "acceptance": "strictly positive lower endpoint for an integer Rayleigh vector",
            "floating_role": "candidate pivot/vector proposal only; never acceptance",
        },
        "algebraic_domain": "principal real embedding of exact cyclotomic sums generated by roots of unity",
        "malformed_input_behavior": "any command-line argument -> stderr diagnostic and exit status 2",
        "source_output_binding": "summary contains source SHA-256; certificate SHA-256 hashes canonical JSONL bytes",
    }

    with open(summary_path, "w", encoding="utf-8", newline="\n") as fh:
        json.dump(summary, fh, indent=2, sort_keys=True)
        fh.write("\n")

    print(json.dumps(summary, indent=2, sort_keys=True))
    return 0 if status.startswith("complete") else 1


if __name__ == "__main__":
    raise SystemExit(main())
