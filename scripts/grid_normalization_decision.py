"""Exact all-modulus decision procedure for the A/B/R normalization union.

The domain is the fixed checker's: an odd prime N and a primitive, distinct,
positive integer tuple of length N-1.  INFEASIBLE concerns these normalization
contracts only, never the Lonely Runner Conjecture.  There is no default modulus
cutoff.  An optional case budget returns INCOMPLETE when exhausted.

Only integer/Fraction arithmetic decides signs, roots, or feasibility.  Negative
receipts retain deterministic coverage hashes for replay, not a kernel proof.
"""

from __future__ import annotations

import argparse
from dataclasses import dataclass, field
from fractions import Fraction as F
from functools import cmp_to_key
from hashlib import sha256
import json
from math import gcd, isqrt, lcm
from pathlib import Path
from typing import Iterator

try:  # Support both `python -m scripts...` and direct script execution.
    from scripts import grid_normalization as fixed
except ModuleNotFoundError:  # pragma: no cover - exercised by the CLI smoke check
    import grid_normalization as fixed


SPEC_SHA256 = "6e3a76646f4f93dec9420a4285ffbdc8848b4437dc607a6485a555f7c7c4d89f"
ALGORITHM_VERSION = 1
Poly = tuple[F, F, F]  # Ascending coefficients; signed scaling is preserved.


class DecisionError(RuntimeError):
    """A consistency failure must never be converted to INFEASIBLE."""


class CaseLimitReached(Exception):
    pass


def polynomial(c=0, b=0, a=0) -> Poly:
    if any(type(x) is not int and not isinstance(x, F) for x in (c, b, a)):
        raise TypeError("polynomial coefficients must be integers or Fractions")
    return (F(c), F(b), F(a))


def add(p: Poly, q: Poly) -> Poly:
    return tuple(x+y for x, y in zip(p, q))


def scale(p: Poly, k: int | F) -> Poly:
    if type(k) is not int and not isinstance(k, F):
        raise TypeError("polynomial scaling must be exact")
    return tuple(k*x for x in p)


def sub(p: Poly, q: Poly) -> Poly:
    return add(p, scale(q, -1))


def multiply(p: Poly, q: Poly) -> Poly:
    out = [F(0)] * 5
    for i, x in enumerate(p):
        for j, y in enumerate(q):
            out[i+j] += x*y
    if any(out[3:]):
        raise ValueError("the exact backend accepts degree at most two")
    return tuple(out[:3])


def sign(x: int | F) -> int:
    return (x > 0) - (x < 0)


@dataclass(frozen=True)
class QuadraticRoot:
    """Canonical irreducible integer quadratic and lower/upper root index.

    Rational isolating intervals are derived exactly on demand.  They do not
    participate in equality: proportional polynomial expressions must identify
    the same root before ordering/refinement can terminate reliably.
    """

    a: int
    b: int
    c: int
    index: int

    def __post_init__(self):
        if any(type(x) is not int for x in (self.a, self.b, self.c, self.index)):
            raise ValueError("root coefficients and index must be integers")
        d = self.b*self.b-4*self.a*self.c
        if (self.a <= 0 or gcd(self.a, self.b, self.c) != 1
                or self.index not in (0, 1) or d <= 0 or isqrt(d)**2 == d):
            raise ValueError("root requires a primitive irreducible quadratic")

    @property
    def discriminant(self) -> int:
        return self.b*self.b-4*self.a*self.c

    def bounds(self, bits: int = 0) -> tuple[F, F]:
        """Strict rational lower/upper bounds, using integer square roots."""
        if type(bits) is not int or bits < 0:
            raise ValueError("bits must be a nonnegative integer")
        den = 1 << bits
        low = F(isqrt(self.discriminant * den * den), den)
        high = low + F(1, den)
        if self.index == 0:
            return (F(-self.b)-high)/(2*self.a), (F(-self.b)-low)/(2*self.a)
        return (F(-self.b)+low)/(2*self.a), (F(-self.b)+high)/(2*self.a)

    def compare_rational(self, q: F) -> int:
        # Compare +/-sqrt(discriminant) with y without taking a real square root.
        if not isinstance(q, F):
            raise TypeError("rational comparison requires a Fraction")
        y = 2*self.a*q+self.b
        if self.index == 1:
            return 1 if y <= 0 else sign(self.discriminant-y*y)
        return -1 if y >= 0 else sign(y*y-self.discriminant)


Point = F | QuadraticRoot


def compare_points(x: Point, y: Point) -> int:
    if not isinstance(x, (F, QuadraticRoot)) or not isinstance(y, (F, QuadraticRoot)):
        raise TypeError("algebraic comparison requires exact point types")
    if x == y:
        return 0
    if isinstance(x, F):
        return sign(x-y) if isinstance(y, F) else -y.compare_rational(x)
    if isinstance(y, F):
        return x.compare_rational(y)
    # Distinct canonical irreducible quadratics cannot share an irrational root.
    bits = 0
    while True:
        xl, xh = x.bounds(bits)
        yl, yh = y.bounds(bits)
        if xh <= yl:
            return -1
        if yh <= xl:
            return 1
        bits = 1 if bits == 0 else bits*2


def real_roots(p: Poly) -> tuple[Point, ...]:
    """All distinct real roots, with rational/double/constant cases exact."""
    p = polynomial(*p)
    c, b, a = p
    if not a:
        return () if not b else (F(-c, b),)
    common_den = lcm(*(x.denominator for x in p))
    cc, bb, aa = (int(x*common_den) for x in p)
    common_gcd = gcd(aa, bb, cc)
    aa, bb, cc = (x//common_gcd for x in (aa, bb, cc))
    if aa < 0:
        aa, bb, cc = -aa, -bb, -cc
    d = bb*bb-4*aa*cc
    if d < 0:
        return ()
    root_d = isqrt(d)
    if root_d*root_d == d:
        return tuple(sorted({F(-bb-root_d, 2*aa), F(-bb+root_d, 2*aa)}))
    return (QuadraticRoot(aa, bb, cc, 0), QuadraticRoot(aa, bb, cc, 1))


def polynomial_sign(p: Poly, x: Point) -> int:
    if isinstance(x, F):
        return sign(p[0]+x*(p[1]+x*p[2]))
    # Reduce the tested polynomial modulo the root's minimal polynomial.
    constant = p[0]-p[2]*F(x.c, x.a)
    linear = p[1]-p[2]*F(x.b, x.a)
    if not linear:
        return sign(constant)
    return sign(linear)*x.compare_rational(-constant/linear)


def rational_inner_interval(left: Point, right: Point) -> tuple[F, F]:
    if compare_points(left, right) >= 0:
        raise ValueError("open atom must have distinct ordered endpoints")
    bits = 0
    while True:
        low = left if isinstance(left, F) else left.bounds(bits)[1]
        high = right if isinstance(right, F) else right.bounds(bits)[0]
        if low < high:
            return (2*low+high)/3, (low+2*high)/3
        bits = 1 if bits == 0 else bits*2


@dataclass(frozen=True)
class Compare:
    poly: Poly
    strict: bool = False  # poly >= 0, or poly > 0 when strict.

    def __post_init__(self):
        if type(self.strict) is not bool:
            raise TypeError("strictness must be a boolean")
        object.__setattr__(self, "poly", polynomial(*self.poly))


@dataclass(frozen=True)
class All:
    items: tuple


@dataclass(frozen=True)
class AnyOf:
    items: tuple


Formula = bool | Compare | All | AnyOf


def conjunction(items) -> Formula:
    items = tuple(items)
    if any(x is False for x in items):
        return False
    items = tuple(x for x in items if x is not True)
    return True if not items else items[0] if len(items) == 1 else All(items)


def disjunction(items) -> Formula:
    items = tuple(items)
    if any(x is True for x in items):
        return True
    items = tuple(x for x in items if x is not False)
    return False if not items else items[0] if len(items) == 1 else AnyOf(items)


def evaluate(formula: Formula, x: Point) -> bool:
    if type(formula) is bool:
        return formula
    if isinstance(formula, Compare):
        s = polynomial_sign(formula.poly, x)
        return s > 0 if formula.strict else s >= 0
    values = (evaluate(item, x) for item in formula.items)
    return all(values) if isinstance(formula, All) else any(values)


def formula_polynomials(formula: Formula) -> set[Poly]:
    if type(formula) is bool:
        return set()
    if isinstance(formula, Compare):
        return {formula.poly}
    return set().union(*(formula_polynomials(x) for x in formula.items))


def point_key(x: Point):
    if isinstance(x, F):
        return ["rational", x.numerator, x.denominator]
    return ["quadratic", x.a, x.b, x.c, x.index]


def formula_key(formula: Formula):
    if type(formula) is bool:
        return formula
    if isinstance(formula, Compare):
        return [">" if formula.strict else ">=",
                [[x.numerator, x.denominator] for x in formula.poly]]
    return ["and" if isinstance(formula, All) else "or",
            [formula_key(x) for x in formula.items]]


@dataclass
class Coverage:
    """Streaming deterministic replay receipt; never retain enormous atom dumps."""

    max_cases: int | None = None
    counts: dict[str, int] = field(default_factory=dict)
    digest: object = field(default_factory=sha256, repr=False)

    def event(self, name: str, data=None):
        self.counts[name] = self.counts.get(name, 0)+1
        self.digest.update(json.dumps([name, data], sort_keys=True,
                                      separators=(",", ":")).encode()+b"\n")

    def begin_case(self, label):
        if self.max_cases is not None and self.counts.get("cases", 0) >= self.max_cases:
            raise CaseLimitReached
        self.event("cases", label)


def prime_divisors(n: int) -> Iterator[int]:
    n, p = abs(n), 2
    while p*p <= n:
        if n % p == 0:
            yield p
            while n % p == 0:
                n //= p
        p += 1
    if n > 1:
        yield n


def prescribed_pair(N: int, u: int, m: int, left: F, right: F) -> tuple[int, int]:
    """Constructive CRT density, including m=0 and u=0 regimes."""
    if not (all(type(x) is int for x in (N, u, m))
            and isinstance(left, F) and isinstance(right, F)
            and fixed._is_odd_prime(N) and 0 <= u < N and 0 <= m < N
            and (u or m) and F(0) < left < right < F(1)):
        raise ValueError("invalid prime, classes, or rational inner interval")
    point = (left+right)/2
    a, b = point.numerator, point.denominator
    if a*m-b*u == 0:
        point = (2*left+right)/3
        a, b = point.numerator, point.denominator
    delta = a*m-b*u
    if not delta:
        raise DecisionError("the two distinct density seed points both vanished")
    epsilon = min(point-left, right-point)
    K = max(1, abs(delta)//(N*b*b*epsilon)+1)
    k0, Q = 0, 1
    for p in prime_divisors(delta):
        if p == N:
            continue
        bad = (-u*pow(N*a, -1, p) if a % p else -m*pow(N*b, -1, p)) % p
        good = (bad+1) % p
        k0 += Q*((good-k0)*pow(Q, -1, p) % p)
        Q *= p
    k = k0+Q*max(0, -((k0-K)//Q))
    c, M = N*a*k+u, N*b*k+m
    if not (K <= k < K+Q and M < N*b*(K+Q)+N and gcd(c, M) == 1
            and (c % N, M % N) == (u, m) and left < F(c, M) < right):
        raise DecisionError("constructive density postcondition failed")
    return c, M


@dataclass(frozen=True)
class FormulaWitness:
    c: int
    M: int
    kind: str  # open or point


def solve_formula(formula: Formula, left: F, right: F, N: int, u: int, m: int,
                  coverage: Coverage | None = None) -> FormulaWitness | None:
    """Complete feasibility for a single formula, cell, and arithmetic class.

    The caller supplies a velocity cell. Rational point atoms must use their
    actual reduced pair; density applies only to positive-width open atoms.
    """
    if not (all(type(x) is int for x in (N, u, m))
            and isinstance(left, F) and isinstance(right, F)
            and fixed._is_odd_prime(N) and 0 <= u < N and 0 <= m < N and (u or m)
            and F(0) <= left < right <= F(1)):
        raise ValueError("invalid cell or arithmetic class")
    cov = coverage if coverage is not None else Coverage()
    cov.event("formulas", [point_key(left), point_key(right), N, u, m, formula_key(formula)])
    if formula is False:
        cov.event("constant_false")
        return None
    roots = set()
    for p in sorted(formula_polynomials(formula)):
        roots.update(x for x in real_roots(p)
                     if compare_points(left, x) < 0 and compare_points(x, right) < 0)
    ordered = sorted(roots, key=cmp_to_key(compare_points))
    cov.event("root_sets", [point_key(x) for x in ordered])
    previous: Point = left
    for endpoint in [*ordered, right]:
        inner_left, inner_right = rational_inner_interval(previous, endpoint)
        sample = (inner_left+inner_right)/2
        good = evaluate(formula, sample)
        cov.event("open_atoms", [point_key(previous), point_key(endpoint), point_key(sample), good])
        if good:
            c, M = prescribed_pair(N, u, m, inner_left, inner_right)
            if not evaluate(formula, F(c, M)):
                raise DecisionError("a sign atom was not constant")
            cov.event("accepted_open", [c, M])
            return FormulaWitness(c, M, "open")
        if endpoint == right:
            break
        good = evaluate(formula, endpoint)
        cov.event("point_atoms", [point_key(endpoint), good])
        if good:
            if isinstance(endpoint, QuadraticRoot):
                cov.event("irrational_rejections", point_key(endpoint))
            elif (endpoint.numerator % N, endpoint.denominator % N) == (u, m):
                cov.event("accepted_point", point_key(endpoint))
                return FormulaWitness(endpoint.numerator, endpoint.denominator, "point")
            else:
                cov.event("class_rejections", point_key(endpoint))
        previous = endpoint
    return None


def velocity_cells(V: tuple[int, ...]) -> Iterator[tuple[F, F]]:
    breaks = {F(0), F(1)}
    for v in V:
        breaks.update(F(j, v) for j in range(1, v))
    ordered = sorted(breaks)
    yield from zip(ordered, ordered[1:])


def cell_formulas(N: int, V: tuple[int, ...], left: F, right: F,
                  u: int, m: int) -> Iterator[tuple[str, Formula]]:
    """A linear formula, then every eligible attained-minimum R anchor."""
    sample = (left+right)/2
    rows = []
    for v in V:
        q = (v*sample).__floor__()
        rows.append(((polynomial(-q, v), (v*u-q*m) % N),
                     (polynomial(q+1, -v), ((q+1)*m-v*u) % N)))
    a_formula = conjunction(disjunction(
        Compare(sub(polynomial(1), scale(f, N-1)), True) if delta else False
        for f, delta in row) for row in rows)
    yield "A", a_formula
    for p, row in enumerate(rows):
        for tau, (anchor, delta) in enumerate(row):
            if delta:
                continue
            D = add(polynomial(1), scale(anchor, N))
            top = scale(anchor, N-1)
            clauses = [Compare(sub(top, multiply(anchor, D)))]
            for i, options in enumerate(rows):
                if i == p:
                    continue
                choices = []
                for f, residue in options:
                    if residue:
                        choices.append(Compare(sub(anchor, multiply(f, D))))
                    else:
                        choices.append(conjunction((Compare(sub(f, anchor)),
                                                    Compare(sub(top, multiply(f, D))))))
                clauses.append(disjunction(choices))
            yield f"R:{p}:{tau}", conjunction(clauses)


def divisors(n: int) -> list[int]:
    out = set()
    for d in range(1, isqrt(n)+1):
        if n % d == 0:
            out.update((d, n//d))
    return sorted(out-{1})


def _b_holds(N: int, V: tuple[int, ...], M: int, c: int) -> bool:
    small = []
    for v in V:
        d = min(c*v % M, -c*v % M)
        small.append(0 < d and (N-1)*d < M and d % N != 0)
    return any(v % M == 0 and v % N != 0
               and all(small[j] for j in range(len(V)) if j != p)
               for p, v in enumerate(V))


def _verified_certificate(N: int, V: tuple[int, ...], M: int, c: int) -> dict:
    cert = fixed.find_fixed_normalization(N, V, M, c)
    if cert is None or not fixed.verify_certificate(cert):
        raise DecisionError("symbolic feasibility failed independent fixed reconstruction/verification")
    return cert


def source_hashes() -> dict[str, str]:
    return {"engine": sha256(Path(__file__).read_bytes()).hexdigest(),
            "fixed_checker": sha256(Path(fixed.__file__).read_bytes()).hexdigest(),
            "manuscript": SPEC_SHA256}


def decide_normalization(N: int, V: tuple[int, ...], *, max_cases: int | None = None) -> dict:
    """Decide the whole all-modulus union; raise on invalid input or arithmetic error.

    A case is one B unit pair or one A/R cell formula. The optional budget does
    not bound preprocessing, integer bit complexity, or a single case's work.
    No result after budget exhaustion is called INFEASIBLE.
    """
    if not fixed._valid_input(N, V, 2, 1):
        raise ValueError("expected odd prime N and a primitive distinct positive tuple of length N-1")
    if max_cases is not None and (type(max_cases) is not int or max_cases < 0):
        raise ValueError("max_cases must be None or a nonnegative integer")
    cov = Coverage(max_cases)
    cert = None
    status = "INFEASIBLE"
    discovery = None
    try:
        moduli = sorted(set().union(*(set(divisors(v)) for v in V if v % N)))
        for M in moduli:
            cov.event("b_moduli", M)
            for c in range(1, M):
                if gcd(c, M) != 1:
                    continue
                cov.begin_case(["B", M, c])
                good = _b_holds(N, V, M, c)
                cov.event("b_units", [M, c, good])
                if good:
                    cert = _verified_certificate(N, V, M, c)
                    discovery = {"branch": "B"}
                    break
            if cert is not None:
                break
        if cert is None:
            for left, right in velocity_cells(V):
                cov.event("velocity_cells", [point_key(left), point_key(right)])
                for u in range(N):
                    for m in range(N):
                        if u == m == 0:
                            continue
                        cov.event("class_pairs", [u, m])
                        for label, formula in cell_formulas(N, V, left, right, u, m):
                            cov.begin_case([label, point_key(left), point_key(right), u, m])
                            cov.event("a_cases" if label == "A" else "r_anchors")
                            witness = solve_formula(formula, left, right, N, u, m, cov)
                            if witness is not None:
                                cert = _verified_certificate(N, V, witness.M, witness.c)
                                discovery = {"branch": label, "atom": witness.kind,
                                             "cell": [point_key(left), point_key(right)],
                                             "classes": [u, m]}
                                break
                        if cert is not None:
                            break
                    if cert is not None:
                        break
                if cert is not None:
                    break
        if cert is not None:
            status = "FEASIBLE"
    except CaseLimitReached:
        status = "INCOMPLETE"
    return {"status": status, "scope": "A/B/R normalization union only; not an LRC decision",
            "algorithm_version": ALGORITHM_VERSION, "N": N, "V": V,
            "max_cases": max_cases, "counts": cov.counts,
            "coverage_sha256": cov.digest.hexdigest(), "sources": source_hashes(),
            "discovery": discovery, "certificate": cert}


def replay_record(record: dict) -> bool:
    """Replay a compact receipt with the same source hashes and deterministic order.

    This is computational replay, not a standalone proof checker for negatives.
    Positive certificates additionally have the independent fixed verifier.
    """
    if record.get("sources") != source_hashes() or record.get("algorithm_version") != ALGORITHM_VERSION:
        return False
    result = decide_normalization(record["N"], tuple(record["V"]), max_cases=record["max_cases"])
    # JSON normalization permits a receipt reloaded from the command-line output.
    return json.dumps(result, sort_keys=True) == json.dumps(record, sort_keys=True)


def main(argv=None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("N", type=int)
    parser.add_argument("speeds", type=int, nargs="+")
    parser.add_argument("--max-cases", type=int)
    args = parser.parse_args(argv)
    try:
        result = decide_normalization(args.N, tuple(args.speeds), max_cases=args.max_cases)
    except (ValueError, DecisionError) as error:
        print(json.dumps({"status": "ERROR", "error": str(error)}))
        return 2
    print(json.dumps(result, sort_keys=True))
    return 3 if result["status"] == "INCOMPLETE" else 0


if __name__ == "__main__":  # pragma: no cover
    raise SystemExit(main())
