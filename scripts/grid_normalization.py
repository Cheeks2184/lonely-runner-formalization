"""Exact checker for one fixed modulus/unit in the A/B/R normalization union.

This module deliberately makes no assertion about other moduli or units.  A
returned dictionary is a finite certificate; ``verify_certificate`` rechecks it
without calling the search routine.
"""

from fractions import Fraction
from math import gcd
from typing import Any, Iterable


def _is_odd_prime(n: int) -> bool:
    if n < 3 or n % 2 == 0:
        return False
    d = 3
    while d * d <= n:
        if n % d == 0:
            return False
        d += 2
    return True


def _valid_input(N: int, V: tuple[int, ...], M: int, c: int) -> bool:
    return (
        type(N) is int
        and
        _is_odd_prime(N)
        and type(V) is tuple
        and len(V) == N - 1
        and all(type(x) is int and x > 0 for x in V)
        and len(set(V)) == len(V)
        and gcd(*V) == 1
        and type(M) is int and M >= 2
        and type(c) is int and 1 <= c < M and gcd(c, M) == 1
    )


def _ceil_div(a: int, b: int) -> int:
    return (a + b - 1) // b


def _signed_options(v: int, M: int, c: int) -> list[tuple[int, int]]:
    """Return (positive residue, sign) options, deduplicated by signed pair."""
    out = []
    for sign in (1, -1):
        z = (sign * c * v) % M
        if z:
            out.append((z, sign))
    return out


def _common_lift(N: int, M: int, c: int, mode: str) -> int:
    """The lift required by Section 4; it is intentionally deterministic."""
    if M % N == 0:
        return c
    target = 0 if mode == "R" else 1
    # CRT, written as a tiny exact search to avoid a modular-inverse dependency.
    for k in range(N):
        b = c + M * k
        if b % N == target:
            return b
    raise AssertionError("coprime CRT lift was unexpectedly absent")


def _affine_certificate(
    N: int, V: tuple[int, ...], M: int, b: int, mode: str,
    bases: list[int], actual: list[int], ordinary: list[bool], L: int | None,
) -> dict[str, Any] | None:
    """Find the prescribed finite affine parameters and check original speeds."""
    if mode == "A" and all((b * v) % N for v in V):
        return {"kind": "direct", "time_num": 1, "time_den": N}
    s_values: Iterable[int] = range(N) if mode == "A" else range(1, N)
    den = N * M
    for r0 in range(1, N):
        for s in s_values:
            # The affine residue has slope base and offset actual speed.  They
            # agree modulo M, but generally not modulo N (notably in R).
            if any(ok and (s * w + r0 * z) % N in (0, N - 1)
                   for z, w, ok in zip(bases, actual, ordinary)):
                continue
            r = (_ceil_div(M * r0, N) if mode in ("A", "B")
                 else _ceil_div(M * r0 * L + M, N * L))
            n = s * M + N * r
            t = Fraction((b * n) % den, den)
            if all(N * min((v * t) % 1, (-v * t) % 1) >= 1 for v in V):
                return {"kind": "affine", "r0": r0, "s": s, "r": r,
                        "n": n, "time_num": t.numerator, "time_den": t.denominator}
    return None


def _make_certificate(N: int, V: tuple[int, ...], M: int, c: int, mode: str,
                      bases: list[int], signs: list[int], ordinary: list[bool],
                      L: int | None = None, pivot: int | None = None) -> dict[str, Any] | None:
    b = _common_lift(N, M, c, mode)
    den = N * M
    actual = []
    for sign, v in zip(signs, V):
        w = (sign * b * v) % den
        actual.append(w if w else den)
    affine = _affine_certificate(N, V, M, b, mode, bases, actual, ordinary, L)
    if affine is None:
        raise RuntimeError("residue predicate held but affine witness reconstruction failed")
    cert: dict[str, Any] = {"N": N, "V": V, "M": M, "c": c, "mode": mode,
                            "b": b, "bases": tuple(bases), "signs": tuple(signs),
                            "ordinary": tuple(ordinary), "actual": tuple(actual),
                            "affine": affine}
    if L is not None:
        cert["L"] = L
        cert["H"] = max(z for z, ok in zip(bases, ordinary) if not ok)
    if pivot is not None:
        cert["pivot"] = pivot
    return cert


def _r_assignment(N: int, V: tuple[int, ...], M: int, c: int) -> tuple[list[int], list[int], list[bool], int] | None:
    """The O(n²) residue-only R decision step, kept separate from witnessing."""
    rows = [_signed_options(v, M, c) for v in V]
    zero_values = sorted({z for opts in rows for z, _ in opts if z % N == 0})
    for L in zero_values:
        choices: list[tuple[int, int, bool] | None] = []
        forced = None
        D = N * L + M
        for i, opts in enumerate(rows):
            zero = [(z, e) for z, e in opts if z >= L and z % N == 0 and z * D <= (N - 1) * L * M]
            ordinary = [(z, e) for z, e in opts if z % N and z * D <= L * M]
            exact = [(z, e) for z, e in zero if z == L]
            if exact and forced is None:
                forced = i
                choices.append((exact[0][0], exact[0][1], False))
            elif ordinary:
                choices.append((ordinary[0][0], ordinary[0][1], True))
            elif zero:
                choices.append((zero[0][0], zero[0][1], False))
            else:
                choices.append(None)
        if forced is not None and all(choices):
            return ([x[0] for x in choices if x], [x[1] for x in choices if x],
                    [x[2] for x in choices if x], L)
    return None


def find_fixed_normalization(N: int, V: tuple[int, ...], M: int, c: int) -> dict[str, Any] | None:
    """Return an A, B, or R certificate for this *fixed* ``(M,c)``, or None."""
    if not _valid_input(N, V, M, c):
        return None
    rows = [_signed_options(v, M, c) for v in V]
    small = []
    for opts in rows:
        candidates = [(z, e) for z, e in opts if (N - 1) * z < M and z % N]
        small.append(min(candidates, default=None))
    if all(small):
        bases, signs = zip(*small)
        return _make_certificate(N, V, M, c, "A", list(bases), list(signs), [True] * len(V))
    for p, v in enumerate(V):
        if v % M == 0 and v % N and all(small[i] for i in range(len(V)) if i != p):
            # The pivot is a positive zero-residue base, not the integer zero.
            bases = [small[i][0] if i != p else M for i in range(len(V))]
            signs = [small[i][1] if i != p else 1 for i in range(len(V))]
            return _make_certificate(N, V, M, c, "B", bases, signs,
                                     [i != p for i in range(len(V))], pivot=p)
    assignment = _r_assignment(N, V, M, c)
    if assignment:
        bases, signs, ordinary, L = assignment
        return _make_certificate(N, V, M, c, "R", bases, signs, ordinary, L=L)
    return None


def verify_certificate(cert: object) -> bool:
    """Independently verify a candidate certificate; never invokes the finder."""
    if not isinstance(cert, dict):
        return False
    try:
        N, V, M, c = cert["N"], tuple(cert["V"]), cert["M"], cert["c"]
        mode, b = cert["mode"], cert["b"]
        bases, signs, ordinary, actual = (tuple(cert[x]) for x in ("bases", "signs", "ordinary", "actual"))
        if mode not in ("A", "B", "R") or not _valid_input(N, V, M, c): return False
        if type(b) is not int: return False
        if len(bases) != len(V) or len(signs) != len(V) or len(ordinary) != len(V) or len(actual) != len(V): return False
        if any(type(e) is not int or e not in (-1, 1) for e in signs) or any(type(o) is not bool for o in ordinary): return False
        if any(type(x) is not int or x <= 0 for x in bases + actual): return False
        if b != _common_lift(N, M, c, mode): return False
        D = N * M
        if any(w != ((e * b * v) % D or D) for w, e, v in zip(actual, signs, V)): return False
        if any((z % M) != (e * c * v) % M for z, e, v in zip(bases, signs, V)): return False
        if mode == "A":
            if not all(ordinary) or any(not (0 < z and (N-1)*z < M and z % N) for z in bases): return False
        elif mode == "B":
            p = cert.get("pivot")
            if type(p) is not int or not 0 <= p < len(V) or ordinary[p] or sum(not x for x in ordinary) != 1: return False
            if V[p] % M or V[p] % N == 0 or bases[p] % M: return False
            if any(not (0 < z and (N-1)*z < M and z % N) for i,z in enumerate(bases) if i != p): return False
            if actual[p] % M or (actual[p] // M) % N == 0: return False
        else:
            L, H = cert.get("L"), cert.get("H")
            zeros = [z for z,o in zip(bases, ordinary) if not o]
            if not zeros or type(L) is not int or type(H) is not int or min(zeros) != L or max(zeros) != H: return False
            if not (H < (N-1)*L and N*H*L <= ((N-1)*L-H)*M): return False
            for z,o in zip(bases, ordinary):
                if not o and not (z % N == 0 and z >= L): return False
                if o and not (0 < z < L and z % N and N*z*L <= (L-z)*M): return False
            if any(w % N for w,o in zip(actual, ordinary) if not o): return False
        a = cert["affine"]
        if not isinstance(a, dict) or set(a) - {"kind","r0","s","r","n","time_num","time_den"}: return False
        if type(a.get("time_num")) is not int or type(a.get("time_den")) is not int or a["time_den"] <= 0: return False
        t = Fraction(a["time_num"], a["time_den"])
        if a.get("kind") == "direct":
            if mode != "A" or t != Fraction(1,N) or not all((b*v)%N for v in V): return False
        elif a.get("kind") == "affine":
            r0,s,r,n = (a.get(x) for x in ("r0","s","r","n"))
            if not all(type(x) is int for x in (r0,s,r,n)) or not 1 <= r0 < N: return False
            if not (0 <= s < N if mode == "A" else 1 <= s < N): return False
            expected_r = _ceil_div(M*r0,N) if mode in ("A","B") else _ceil_div(M*r0*cert["L"]+M,N*cert["L"])
            if r != expected_r or n != s*M+N*r or t != Fraction((b*n)%(N*M),N*M): return False
            if any(o and (s*w+r0*z)%N in (0,N-1) for z,w,o in zip(bases,actual,ordinary)): return False
        else: return False
        return all(N * min((v*t)%1, (-v*t)%1) >= 1 for v in V)
    except (KeyError, TypeError, ValueError, ZeroDivisionError):
        return False
