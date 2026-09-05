# Dense induction: endpoint pairs and a trapped-witness obstruction

Task `/root/dense_pivot_audit`, requested in-session Astra/xhigh, 2026-09-05.
Frozen source: `808595cf7615d01f849eb071648d8a82ee7c97c1`.
The worker read the project configuration, workflow, policy, active state,
and relevant Lean definitions; `python3 scripts/validate_workflow.py` passed.
Only this evidence file is owned by the worker. No Lean build, dependency or
cache restoration, shared state edit, commit, push, or external model was used.

**Disposition: manuscript proofs of a conditional finite pair insertion
criterion and strict necessary conditions for a minimal-count failure; an
exact counterexample to the specified fastest-deletion component strategy.**
These are not kernel-checked declarations. The unrestricted canonical
Lonely Runner Conjecture remains unresolved.

## 1. Fixed contracts

Write `||x|| = dist(x,Z)` and

```text
G_k(V) = {t in R : ||a*t|| >= 1/k for every a in V}.
R(N,p) = {0 <= r < N*p : N does not divide r}.
B(N,p,a) = {r in R(N,p) : min(a*r mod Np, -a*r mod Np) < p}.
```

The strict bad inequality and closed good inequality agree with
`LonelyRunner/PivotResidues.lean`. `PositiveIntegerConjecture` has `N-1`
distinct positive moving speeds and threshold `1/N`.
`exists_witness_iff_exists_pivot_certificate` in
`LonelyRunner/PivotBoundary.lean` identifies empty `G_N(V)` with coverage of
**every actual pivot row**, not just the largest row.

For the insertion theorem below let `N>=4`, let `V` contain `N-2` distinct
positive integers, and let `p>max V`. Assume the *supplied premise*

```text
G_(N-1)(V) is nonempty.                                      (1)
```

In a hypothetical least moving-runner-count counterexample, smaller-count
LRC supplies (1). The geometric lemma itself needs only (1), at least two
old speeds, and the displayed inequalities; it does not assume LRC.

## 2. Exact good-component endpoints

Fix any `t0 in G_(N-1)(V)`. Set `h=1/(N-1)`, `delta=1/N` and
`k_a=floor(a*t0)`. Since `h>0`, no phase is integral, and

```text
(k_a+h)/a <= t0 <= (k_a+1-h)/a.
```

The maximal connected component of `G_N(V)` containing `t0` is the closed
interval `I=[L,R]`, where

```text
L = max_(a in V) (k_a+delta)/a,
R = min_(b in V) (k_b+1-delta)/b.                            (2)
```

Indeed, these are precisely the finitely many closed phase bands containing
`t0`; crossing either endpoint immediately leaves one of them. Also
`L<t0<R`, because `h>delta` and all speeds are positive.

Choose a lower-endpoint owner `a` and an upper-endpoint owner `b` in (2).
If `a=b`, then

```text
R-L = (N-2)/(N*a) > (N-2)/(N*p) >= 2/(N*p).                 (3)
```

If `a!=b`, put `k=k_a`, `l=k_b+1`, `g=gcd(a,b)`, and `H=a*l-b*k`.
The stronger witness gives

```text
H >= (a+b)/(N-1),       g divides H,
R-L = [N*H-(a+b)]/(N*a*b).                                 (4)
```

For the first inequality, multiply
`(k+h)/a <= t0 <= (l-h)/b` by `a*b`. The divisibility follows
directly from the definition of `H`.

Define the positive integer

```text
D_N(a,b) = N*g*ceil((a+b)/((N-1)*g)) - (a+b).               (5)
```

Consequently every distinct-endpoint component obeys

```text
R-L >= D_N(a,b)/(N*a*b)
    >= (1/a+1/b)/(N*(N-1)).                                 (6)
```

The gcd in (5) is essential for the strongest determinant-lattice bound.
Replacing it by 1 remains valid but can be substantially weaker.

## 3. A finite pair insertion criterion

**Theorem.** Under the hypotheses in section 1, if

```text
p*D_N(a,b) >= 2*a*b       for every distinct a,b in V,        (7)
```

then `G_N(V union {p})` is nonempty.

**Proof.** Use any witness in (1) and its interval (2). If the full tuple had
no witness, all of `I` would belong to the open bad set of speed `p`.
Connectedness puts this closed interval in one open arc

```text
((m-1/N)/p, (m+1/N)/p),       m in Z,
```

so `R-L<2/(N*p)`. Equation (3) rules out a common endpoint owner.
For distinct endpoint owners, (6) and (7) instead give
`R-L>=2/(N*p)`, a contradiction. Equality in (7) therefore suffices:
the bad arcs are open and the witness interval is closed. QED.

The arithmetic work in (7) comprises one gcd, ceiling, and integer comparison
per unordered pair. No enumeration up to `p` is required. The criterion is
only sufficient. It is scale invariant:

```text
D_N(t*a,t*b) = t*D_N(a,b)       for positive integer t.
```

Let `q>s` be the two largest old speeds. Since
`ab/(a+b) <= qs/(q+s)` for every distinct old pair, a convenient weaker
sufficient condition is

```text
p*(q+s) >= 2*(N-1)*q*s.                                    (8)
```

This improves the repository's existing sufficient fast-insertion condition
`p >= (N-1)*q`. No novelty claim is made for the harmonic mechanism:
the unnumbered proposition on PDF page 2 of
[Algebraic strengthening of lonely runner conjecture, version 4](https://rxiverse.org/pdf/2509.0023v4.pdf)
already states its strict-inequality version. The proof here was derived
independently and spells out the same-owner case, closed endpoint, and
determinant refinement. Other claims in that paper are not used or endorsed.

Two exact controls distinguish the pair test from the coarser conditions:

| N | old speeds V | p | maximum `2ab/D_N(a,b)` | old witness | full witness |
| --- | --- | --- | --- | --- | --- |
| 5 | 1,2,5 | 7 | 20/3, at (2,5) | 1/4 | 6/25 |
| 7 | 1,2,3,4,5 | 14 | 10, at (1,5) | 1/6 | 15/98 |

The full witness distances in the first row are
`(6/25,12/25,1/5,8/25)`. In the second they are
`(15/98,15/49,45/98,19/49,23/98,1/7)`.
Both rows lie outside the old fast-insertion condition. The first also lies
outside (8), whose threshold is `80/7`; the second lies outside (8), whose
threshold is `80/3`. These controls verify a real arithmetic improvement,
not necessity or an unrestricted existence claim.

## 4. Necessary structure of a minimal-count failure

Suppose a least-count positive-integer counterexample exists at total runner
count `N>=4`. Sort its moving speeds, writing `p>q>s` for the largest three.
Delete `p`. By smaller-count LRC, (1) holds. Therefore:

1. The strict top-order constraint is
   `p*(q+s)<2*(N-1)*q*s`.
2. There is a distinct old pair with
   `p*D_N(a,b)<2*a*b`. More strongly, **every** old `1/(N-1)` witness has a
   component (2) whose endpoint owners form such a pair.
3. Every one of those components is strictly contained in a single `p`-bad
   arc. Its two endpoints have all old speeds good and **only p bad**.

The third conclusion retains actual labels and produces two genuine
cross-pivot private candidates. Before reduction modulo one, the endpoints
are

```text
L=(N*k+1)/(N*a),       R=(N*l-1)/(N*b),       a!=b.
```

Reducing the numerators modulo `N*a` and `N*b` respectively preserves their
nonzero residues `+1` and `-1` modulo `N`. They therefore belong to the actual
`a` and `b` pivot grids. At both points speed `p` is the unique spoiling
original label. In particular one cannot replace the lower endpoints by
arbitrary abstract set-cover elements without losing this information.

This does **not** say that every old pair is obstructed, that every component
of `G_N(V)` contains an inductive witness, or that these necessary conditions
are sufficient for an LRC counterexample.

## 5. Exact obstruction to following a fastest-deletion witness component

Consider the candidate strategy:

> Delete the fastest speed, choose any witness at the smaller-count threshold,
> and move within its entire connected old-good component at the new threshold
> until the fastest speed also becomes good.

Even allowing arbitrary selection among **all** smaller-count witnesses,
this strategy does not work uniformly.

Use the existing correctly counted tuple

```text
N=7,       V=(1,4,5,6,7),       p=11.
```

The complete list of stronger old-good components in one time period is

```text
G_6(V) cap [0,1] =
 [13/36,11/30] union [19/42,11/24]
 union [13/24,23/42] union [19/30,23/36].
```

Every weak old-good component that meets this set is trapped:

| component of `G_7(V)` | containing open 11-bad arc |
| --- | --- |
| [5/14,13/35] | (27/77,29/77) |
| [22/49,13/28] | (34/77,36/77) |
| [15/28,27/49] | (41/77,43/77) |
| [22/35,9/14] | (48/77,50/77) |

All inclusions are strict at both endpoints. Nevertheless the full tuple's
complete witness set in `[0,1]` is

```text
G_7(V union {11}) cap [0,1] =
 [15/49,13/42] union [29/42,34/49].
```

These are the two remaining components of `G_7(V)`; neither meets `G_6(V)`.
For example `13/42` is a full witness with distances
`(13/42,5/21,19/42,1/7,1/6,17/42)`.

The largest row really is covered: the five owners cover all 66 candidates
of `R(7,11)`, with private residues `(3,18,15,13,11)` in owner order.
The covered original pivot speeds are exactly `{1,4,5,11}`; `6,7` are
noncovered. Thus this is a counterexample to the displayed *component
strategy*, not to LRC, not to an all-covered implication, and not to internal
redundancy at the maximum covered pivot. In particular the covering owners
6 and 7 are not internal in `Prompt99Scaling.lean`'s actual definition.

## 6. Small exact reproduction

The following standard-library Python script exactly intersects all phase
bands in the displayed period. It includes isolated good points and performs
no floating-point or unbounded search.

```python
from fractions import Fraction as F
from itertools import combinations
from math import floor, gcd

def norm(t):
    x = t % 1
    return min(x, 1-x)

def components(V, k):
    out = [(F(0), F(1))]
    for a in V:
        bands = [(F(k*j+1, k*a), F(k*(j+1)-1, k*a))
                 for j in range(a)]
        out = [(max(l,x), min(r,y)) for l,r in out for x,y in bands
               if max(l,x) <= min(r,y)]
    return sorted(set(out))

def D(N, a, b):
    g = gcd(a,b)
    den = (N-1)*g
    return N*g*((a+b+den-1)//den)-a-b

N, V, p = 7, (1,4,5,6,7), 11
strong = components(V, N-1)
weak = components(V, N)
seeded = [I for I in weak if any(max(I[0],J[0]) <= min(I[1],J[1])
                               for J in strong)]
assert strong == [(F(13,36),F(11,30)), (F(19,42),F(11,24)),
                  (F(13,24),F(23,42)), (F(19,30),F(23,36))]
assert seeded == [(F(5,14),F(13,35)), (F(22,49),F(13,28)),
                  (F(15,28),F(27,49)), (F(22,35),F(9,14))]
for l,r in seeded:
    m = floor(p*(l+r)/2 + F(1,2))
    assert F(N*m-1,N*p) < l <= r < F(N*m+1,N*p)
full = [(F(15,49),F(13,42)), (F(29,42),F(34,49))]
assert components(V+(p,),N) == full
assert [I for I in weak if I not in seeded] == full

def bad(N,p,a):
    return {r for r in range(N*p) if r%N and
            min(r*a%(N*p), (-r*a)%(N*p)) < p}
R = {r for r in range(N*p) if r%N}
B = {a: bad(N,p,a) for a in V}
assert set.union(*B.values()) == R
assert [min(B[a]-set.union(*(B[b] for b in V if b != a)))
        for a in V] == [3,18,15,13,11]
A = V+(p,)
covered = {a for a in A if set.union(*(bad(N,a,b) for b in A if b!=a))
           == {r for r in range(N*a) if r%N}}
assert covered == {1,4,5,11}

for N,V,p,t,w,expected in [
    (5,(1,2,5),7,F(1,4),F(6,25),F(20,3)),
    (7,(1,2,3,4,5),14,F(1,6),F(15,98),F(10))]:
    pair_bound = max(F(2*a*b,D(N,a,b)) for a,b in combinations(V,2))
    assert pair_bound == expected and p >= pair_bound
    assert all(norm(a*t) >= F(1,N-1) for a in V)
    assert all(norm(a*w) >= F(1,N) for a in V+(p,))
    assert all(D(N,3*a,3*b) == 3*D(N,a,b)
               for a,b in combinations(V,2))
print('Exact pair controls and all trapped-component assertions passed.')
```

## 7. Residual dense burden and next lemma

Together with the separate nearest-grid audit, smaller-count induction
removes quantitatively sparse proper owner covers and the insertion classes
above. It does not forbid a dense cover by all `N-2` lower labels. Applying
smaller-count LRC to those labels **plus the actual pivot** would use the
original moving count and is circular.

The concrete next formalizable lemma from this pass is section 3: from a
supplied stronger old witness and the pair inequalities (7), construct a full
closed witness. Sections 2 and 4 give its exact endpoint and private-candidate
interfaces. This would be a sound addition beside `FastRunnerInsertion.lean`,
not a proof of `IntegerInsertionCover` for every family.

A genuinely missing mathematical step must exploit relations among original
covered pivots or reach components that do not meet any selected induction
witness set. Section 5 proves that exhaustive selection of fastest-deletion
witnesses and movement within their old-good components is insufficient.
`Prompt95CanonicalBridge.lean` still requires the explicit
`MaxCoveredPivotInternalCoverRedundancy` premise; no inhabitant of that premise
or proof excluding all-covered tuples is supplied here.
