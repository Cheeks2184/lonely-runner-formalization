# Independent pass 7 review of the exact normalization decision engine

Status: **accepted**, 2026-09-05. The author froze the implementation before
source inspection and execution of the independent controls. The engine and
the specific complete computational obstruction below are accepted within
their stated scope; neither is a Lean kernel proof. The accepted mathematical
specification is `research/astra-normalization-decision.md`, SHA-256
`6e3a76646f4f93dec9420a4285ffbdc8848b4437dc607a6485a555f7c7c4d89f`.

Reviewer: `/root/vanishing_slope`, requested in-session Astra xhigh, independent
of the engine author. Runtime-observed model/effort metadata is unavailable.
Current project config, workflow/policy/state were read and workflow validation
passed. Only this note is reviewer-owned; no `.lake` restoration, Lean build,
source edit, or Git action is part of this review.

## 1. Required mathematical behavior

The engine must implement the accepted finite decision procedure for a fixed
valid tuple. Positive output must include a certificate accepted by the existing
fixed-pair verifier. Resource limits, interrupted enumeration, or arithmetic
failures must not produce negative output. A full negative requires exhausting
every B divisor/unit and every A/R velocity cell, arithmetic class, anchor,
open interval atom, and point atom. No actual negative tuple is assumed to
exist merely to furnish a regression test.

An exact symbolic engine still does not prove uniform normalization supply,
strict-witness equivalence, or unrestricted LRC. A manuscript reduction, a
bounded run, and a complete all-modulus negative certificate are different
forms of evidence and must be reported separately.

## 2. Independent adversarial controls prepared before source readiness

### Root identity and degree reduction

* Nonzero rational scalings of `x^2-2` must yield exactly the same two
  irrational roots, including negative scalings and fractional coefficients.
* Irreducible rational quadratics have a unique primitive integer minimal
  polynomial up to sign. A canonical representation with positive leading
  coefficient and root index therefore decides irrational-root equality.
  Different canonical irreducible quadratics cannot share an irrational root.
* Perfect-square discriminants give rational roots. The double root of
  `(2*x-1)^2` is one rational point `1/2`, not two distinct atoms.
* A zero leading coefficient reduces to a linear or constant polynomial.
  An identically zero polynomial is a constant relation, not an infinite
  list of root atoms. Constant true and false formulas remain correctly
  evaluable on an otherwise unsplit velocity cell.

### Exact order and signs

* Check both signs and cross-field ordering of `sqrt(2)`, `sqrt(3)`, and
  their negative roots, as well as rational cuts through their isolating
  intervals.
* At either root of `x^2-2`, evaluating any scalar multiple of that
  polynomial must terminate with sign zero. A refinement loop waiting for
  a nonzero sign would fail on this essential case.
* Use the independent radical-sign oracle below for many small irreducible
  quadratics and quadratic query polynomials; it does not use the engine's
  interval-refinement or root-comparison code.
* Let `Q=10^60`. The upper roots of `x^2-2` and
  `Q^2*x^2-2*Q*x+1-2*Q^2` are `sqrt(2)` and `sqrt(2)+1/Q`.
  They must compare strictly in that order and admit a rational sample
  between them. No fixed floating precision or root-separation tolerance
  can establish this general contract.

### Feasibility and arithmetic classes

* The formula `x>1/2` and `x<=1/2` is false, even though intersecting
  its closed relaxations would incorrectly retain `1/2`.
* An isolated rational point `3/196` has only reduced classes `(3,0)`
  modulo 7. It cannot be reassigned to `(1,3)` by scaling its numerator
  and denominator. Coarse non-strict equalities at its actual class remain
  valid.
* The isolated positive root of `2*x^2-1=0` in `(0,1)` is real but
  irrational and therefore cannot supply a permitted normalization ratio.
* At a velocity breakpoint, a zero residue blocks A/R. The B divisor
  scan must retain that point when a valid original pivot exists.
* Open feasible intervals must produce coprime pairs in every admissible
  arithmetic class, including zero numerator or denominator classes.
* R must force a chosen original zero row at the actual minimum value;
  rowwise threshold choices alone with an unattained guessed minimum are
  not enough.

## 3. Independent sign oracle

For an irreducible quadratic `p(x)=a*x^2+b*x+c`, `a>0`, let
`D=b^2-4*a*c>0` be nonsquare and
`alpha=(-b+sigma*sqrt(D))/(2*a)` with `sigma` equal to -1 or 1.
For a quadratic query `q(x)=d*x^2+e*x+f`, reduce modulo `p`:

```text
q(alpha)=L*alpha+C,
L=e-d*b/a,       C=f-d*c/a.
```

Thus `q(alpha)=A+B*sqrt(D)` with

```text
A=C-L*b/(2*a),       B=sigma*L/(2*a).
```

Its sign is determined by the signs of rational `A,B`, and, when they
oppose, by comparing `A^2` with `B^2*D`. If `B=0`, use `sign(A)`;
if `A=0`, use `sign(B)`; if both have the same nonzero sign, use that
sign. For `A>0>B`, use `sign(A^2-B^2*D)`; for `B>0>A`, use its negative.
All these operations are integer/Fraction arithmetic. This gives an
independent exact oracle for irrational-root sign tests without reproducing
the engine's expected isolating-interval implementation.

## 4. Results and final source binding

The frozen sources read in full and checked by SHA-256 are:

```text
scripts/grid_normalization_decision.py
  393cdc38eee2fdead8a3ef47bdad599917a5319e407d768b197c5997ffd8e5d1
tests/test_grid_normalization_decision.py
  43893659bea8251824d82c8dde6a50c55004ddbb05be0cdad4e462efb266985b
research/astra-decision-engine.md
  b65756e4c83365c05ae43c5a5ffc4d1f48d9bbc7b477c5df63ff3d910ec8b90f
scripts/grid_normalization.py
  38bc58b6a53c044998a9b48d4fda8dc4a717fa6936dee9e8cb68935bf690cdb0
```

The 30 engine/fixed-checker tests passed. The independent radical oracle
matched 48,000 quadratic signs, 1,152 signed rational polynomial scalings,
and 3,517 root-order comparisons. The `10^-60` separation control also passed
the independent squared-rational checks `q^2>2` and `(q-1/Q)^2<2` for both
returned strict interior endpoints.

The engine source and all tests were inspected, including every enumeration
and stopping path. No source correction was required. Specific conclusions:

* Primitive positive-leading irreducible quadratics and a root index give
  correct exact identity. Rational/double/constant cases reduce correctly.
  Distinct irrational roots eventually have disjoint rational enclosures;
  equality is resolved before refinement. Minimal-polynomial reduction
  handles zero signs without a nontermination path.
* Formula roots are restricted to the open velocity cell, deduplicated,
  and totally ordered exactly. Every intervening open atom and every
  internal point atom is inspected. Constants remain evaluable even with
  no roots. Rational points retain their unique reduced classes and
  irrational points never become normalization ratios.
* The signed class formula includes the crucial remainder term in
  `delta_minus=m-delta_plus`. All `N^2-1` classes occur, including zero
  numerator and zero denominator classes. Every eligible original row and
  sign occurs as an R anchor, and the chosen anchor is forced as an actual
  zero minimum. No ordinary-offset or common-unit-modulo-N condition was
  inserted. Empty ordinary/all-zero R is included.
* The B scan covers every divisor of every eligible original pivot, and
  every unit for each such modulus. These are exactly its possible moduli;
  this finite scan is not a heuristic cutoff. Zero-residue velocity
  boundaries excluded from A/R are correctly retained for B.
* A feasible open atom invokes the exact coprime CRT construction inside
  a strict rational subinterval. Both the determinant-zero seed exception
  and the `u=0`/`m=0` regimes are handled. The produced pair is rechecked,
  its formula is reevaluated, and its fixed certificate is independently
  verified before `FEASIBLE` is returned.
* `INFEASIBLE` requires successful completion of the complete outer
  enumeration. Only the explicit case-limit exception becomes
  `INCOMPLETE`; arithmetic, invalid-input, and reconstruction failures
  never become negative evidence. `max_cases` does not limit preprocessing,
  factoring, integer sizes, or time inside one case; the author documents
  this limitation. Replay is a deterministic rerun, not a standalone
  proof checker for negative receipts.

Additional independent checks passed: 40,474 rational checks of the separate
inequality-range solver against direct polynomial evaluation; 864 CRT density
constructions over all admissible classes at `N=11,13`, in three intervals
of width `10^-6` near 0, 1/2, and 1; and the all-zero R case
`N=3,V=(1,10),M=11,c=3`, whose ordinary flags are `(False,False)`.

The engine's uncapped run and deterministic replay on
`N=7,V=(2,3,4,7,14,9)` both completed with 3,395 cases and coverage digest
`0a6ce7c28901b555a65e478a87c3e6d94020da444aeb9b7db1a3be73fbb1a4c6`.
The exact budget boundary also behaved correctly: 3,394 gives `INCOMPLETE`,
while 3,395 gives the completed `INFEASIBLE` result. The adjacent tuple
with 8 instead of 9 gives a separately verified positive R certificate.

## 5. Independent all-modulus replay without the engine

The following reproducer imports no project code and uses no engine root,
formula, anchor, class-enumeration, or certificate routine. It enumerates
all signs explicitly, instead of disjoining row choices under a chosen
minimum anchor. Each signed choice and arithmetic class fixes its zero set
`Z`. Inside a velocity cell all signed affine values `f_i` are positive.
For each `p in Z` impose, for every row `q`,

```text
(N-1)*f_p - f_q - N*f_p*f_q >= 0       if q in Z,
       f_p - f_q - N*f_p*f_q >= 0       otherwise.
```

These simultaneous inequalities are exactly the direct R range inequalities:
the functions `(N-1)*lambda/(1+N*lambda)` and
`lambda/(1+N*lambda)` strictly increase for positive `lambda`. Consequently
requiring them for every zero row is equivalent to requiring them at the
attained minimum, without choosing or guessing an anchor. The zero maximum
and ordinary strict separation follow as in the original coarse contract.

The solver intersects the analytic solution intervals of each individual
linear or quadratic inequality. This differs from the engine's Boolean
formula atom decomposition. Root comparison uses a direct sign formula
for a sum of two radicals, without interval refinement: if
`T=A+B*sqrt(D)` and `C*sqrt(E)` have opposite signs, compare their squares
by the one-radical sign oracle. Rational singleton classes are checked
without scaling, and irrational singletons cannot yield rational ratios.

Run the following exact reproducer from any Python 3 environment. Its only
imports are from the standard library. The final candidate run has no
case, modulus, root-isolation, or sign-branch cutoff.

```python
# BEGIN INDEPENDENT REPLAY
from fractions import Fraction as F
from math import gcd, isqrt
from hashlib import sha256

def sg(x):
    return (x > 0) - (x < 0)

def radical_sign(A, B, D):
    if not B:
        return sg(A)
    if not A:
        return sg(B)
    if sg(A) == sg(B):
        return sg(A)
    return sg(A*A-B*B*D) * (1 if A > 0 else -1)

def unpack(x):
    return (x, F(0), 0) if isinstance(x, F) else x

def compare(x, y):
    A, B, D = unpack(x)
    C, E, G = unpack(y)
    A, E = A-C, -E
    z = radical_sign(A, B, D)
    if not E:
        return z
    if not z:
        return sg(E)
    if z == sg(E):
        return z
    return radical_sign(A*A+B*B*D-E*E*G, 2*A*B, D) * z

def roots(p):
    c, b, a = p
    if not a:
        return [] if not b else [F(-c, b)]
    if a < 0:
        a, b, c = -a, -b, -c
    D = b*b-4*a*c
    if D < 0:
        return []
    d = isqrt(D)
    if d*d == D:
        return sorted({F(-b-d, 2*a), F(-b+d, 2*a)})
    return [(F(-b, 2*a), F(-1, 2*a), D),
            (F(-b, 2*a), F(1, 2*a), D)]

def intersect(I, J):
    a, b, ac, bc = I
    c, d, cc, dc = J
    z = compare(a, c)
    if z < 0:
        a, ac = c, cc
    elif z == 0:
        ac = ac and cc
    z = compare(b, d)
    if z > 0:
        b, bc = d, dc
    elif z == 0:
        bc = bc and dc
    z = compare(a, b)
    return (a, b, ac, bc) if z < 0 or (z == 0 and ac and bc) else None

def ranges(p, strict=False):
    c, b, a = p
    zero, one, closed = F(0), F(1), not strict
    if not a and not b:
        return [(zero, one, True, True)] if c > 0 or c == 0 and not strict else []
    rr = roots(p)
    if not a:
        return [(rr[0], one, closed, True)] if b > 0 else [(zero, rr[0], True, closed)]
    if not rr:
        return [(zero, one, True, True)] if a > 0 else []
    if len(rr) == 1:
        if a < 0:
            return [] if strict else [(rr[0], rr[0], True, True)]
        return ([(zero, rr[0], True, False), (rr[0], one, False, True)]
                if strict else [(zero, one, True, True)])
    return ([(zero, rr[0], True, closed), (rr[1], one, closed, True)]
            if a > 0 else [(rr[0], rr[1], closed, closed)])

def solve(polys, cell, strict=False):
    intervals = [(*cell, False, False)]
    for p in polys:
        intervals = [cut for I in intervals for J in ranges(p, strict)
                     if (cut := intersect(I, J)) is not None]
        if not intervals:
            break
    return intervals

def bound(lam, f, K, N):
    l, m = lam
    c, b = f
    return (K*l-c-N*l*c, K*m-b-N*(l*b+m*c), -N*m*b)

def permits(intervals, N, classes):
    for left, right, lc, rc in intervals:
        if compare(left, right) < 0:
            return True
        if isinstance(left, F) and (left.numerator % N, left.denominator % N) in classes:
            return True
    return False

def replay(N, V):
    T = sorted({F(0), F(1)} | {F(j, v) for v in V for j in range(1, v)})
    classes = [(u, m) for u in range(N) for m in range(N) if u or m]
    B = 0
    # Independent finite B scan, using its proven upper bound max(V).
    for M in range(2, max(V)+1):
        if not any(v % N and v % M == 0 for v in V):
            continue
        for c in range(1, M):
            if gcd(c, M) > 1:
                continue
            B += 1
            small = [0 < (d := min(c*v % M, -c*v % M))
                     and (N-1)*d < M and d % N != 0 for v in V]
            if any(v % N and v % M == 0
                   and all(small[j] for j in range(len(V)) if j != i)
                   for i, v in enumerate(V)):
                return {'status': 'FEASIBLE', 'branch': 'B'}
    geometry = a_count = r_count = nonempty = 0
    digest = sha256()
    for cell_id, cell in enumerate(zip(T, T[1:])):
        x = sum(cell)/2
        floor = [(v*x).__floor__() for v in V]
        for mask in range(1 << len(V)):
            rows = [(-q, v) if not (mask >> i) & 1 else (q+1, -v)
                    for i, (v, q) in enumerate(zip(V, floor))]
            groups = {}
            for u, m in classes:
                Z = tuple(i for i, (c, b) in enumerate(rows) if (c*m+b*u) % N == 0)
                groups.setdefault(Z, []).append((u, m))
            for Z, cls in groups.items():
                if not Z:
                    pp = [(1-(N-1)*c, -(N-1)*b, 0) for c, b in rows]
                    intervals = solve(pp, cell, True)
                    a_count += len(cls)
                else:
                    pp = [bound(rows[p], rows[q], N-1 if q in Z else 1, N)
                          for p in Z for q in range(len(V))]
                    intervals = solve(pp, cell)
                    r_count += len(cls)
                geometry += 1
                nonempty += bool(intervals)
                if permits(intervals, N, cls):
                    return {'status': 'FEASIBLE', 'branch': 'R' if Z else 'A'}
                digest.update(repr((cell_id, mask, Z, cls, intervals)).encode()+b'\n')
    return {'status': 'INFEASIBLE', 'B_pairs': B, 'cells': len(T)-1,
            'signed_A_class_cases': a_count, 'signed_R_class_cases': r_count,
            'geometry_cases': geometry, 'nonempty_real_geometry_cases': nonempty,
            'coverage_sha256': digest.hexdigest()}

# Validate independent root and interval code before using a negative output.
sq2 = roots((-2, 0, 1))[1]
sq3 = roots((-3, 0, 1))[1]
assert compare(sq2, sq3) == -1 and compare(sq2, F(7, 5)) == 1
assert compare(sq2, roots((14, 0, -7))[1]) == 0
assert not solve([(1, -2, 0), (-1, 2, 0)], (F(0), F(1)), True)
point = solve([(-3, 196, 0), (3, -196, 0)], (F(0), F(1, 14)))
assert permits(point, 7, [(3, 0)]) and not permits(point, 7, [(1, 3)])
irrational = solve([(-1, 0, 2), (1, 0, -2)], (F(0), F(1)))
assert irrational and not permits(irrational, 7, [(1, 1)])
assert solve([(1, -4, 4)], (F(0), F(1))) == [(F(0), F(1), False, False)]
assert not solve([(-1, 4, -4)], (F(0), F(1)), True)
for N, V, branch in ((3, (1, 2), 'A'),
                     (7, (1, 2, 3, 4, 5, 31), 'B'),
                     (7, (1, 2, 3, 4, 7, 14), 'R'),
                     (7, (2, 3, 4, 7, 14, 8), 'R')):
    assert replay(N, V) == {'status': 'FEASIBLE', 'branch': branch}
result = replay(7, (2, 3, 4, 7, 14, 9))
assert result == {
    'status': 'INFEASIBLE', 'B_pairs': 11, 'cells': 24,
    'signed_A_class_cases': 27204, 'signed_R_class_cases': 46524,
    'geometry_cases': 7856, 'nonempty_real_geometry_cases': 0,
    'coverage_sha256': '83b18bf63072e61140f32c3666535d66efc4bdb5d28942d83dbfad4158f1e0af'}
assert min(min(v*F(1, 5) % 1, 1-v*F(1, 5) % 1)
           for v in (2, 3, 4, 7, 14, 9)) == F(1, 5) > F(1, 7)
print(result)
# END INDEPENDENT REPLAY
```

## 6. Accepted obstruction and remaining mathematical gap

The persisted independent reproducer completed, including its A, B, R,
adjacent-tuple, rational-point, irrational-point, double-root, and strict
boundary controls. For `N=7,V=(2,3,4,7,14,9)` it exhausts all 11 possible
B unit pairs and all `24*48*64=73,728` signed cell/class choices. Grouping
classes only when they induce exactly the same signed zero set produces
7,856 distinct geometric conjunctions: 27,204 original signed/class
choices for A and 46,524 for R. Every conjunction is empty even over the
reals in its open velocity cell. Consequently this negative does not rely
on constructive density or singleton class filtering; those were tested
separately for the general engine contract.

The independent coverage digest is
`83b18bf63072e61140f32c3666535d66efc4bdb5d28942d83dbfad4158f1e0af`.
It differs from the engine receipt because this replay uses explicit signs
and all-zero-row inequalities, with an analytic interval-intersection
solver. It imports no project code and checks the finite B branch directly.

Thus the exact A/B/R normalization union fails for this fixed primitive,
distinct six-speed tuple for **every** external modulus, common modular
unit, independent sign choice, and lift permitted by the accepted union
equivalence. This is accepted complete computational evidence, stronger
than a bounded modulus search and separate from a kernel-checked theorem.
The tuple has an ordinary strict witness at `t=1/5`, with minimum circle
distance `1/5>1/7`. The result refutes universal supply for these particular
normalization contracts; it neither refutes LRC nor establishes an
unrestricted replacement mechanism. That remaining gap is unchanged.

No engine/test source, Lean file, shared state, root import, or Git object
was edited by this reviewer. Only this review note was written. Source
hashes above were checked again after the review controls, and the current
workflow validator passed. The root may publish the reviewed checkpoint;
unrestricted LRC remains unresolved.
