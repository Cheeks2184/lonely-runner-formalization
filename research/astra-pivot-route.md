# Astra pivot route: endpoint arithmetic and a uniform obstruction

Status: `proved-math-response` derivations and `computed finite evidence`,
awaiting independent mathematical review. No new Lean declaration. No proof or
disproof of unrestricted LRC. Source checkpoint:
`ec30e172d792e51ee9712a3f204336f7bee8724c`.

Task owner: `/root/pivot_route`. The authorized task is unrestricted mathematical
research; this note is the sole owned file. Workflow structural validation passed
at task entry. Read the current project configuration, workflow documents and
state, the exact bottleneck in `docs/full-proof-roadmap.md`, the declaration
inventory in `docs/proof-obligations.md`, `LonelyRunner/PivotBoundary.lean`,
`docs/integer-induction-cover.md`, and the Response61/Response101 audits.
Prompt104/105 remain on hold. Historical model-routing instructions were not used.

## Scope and outcome

The candidate examined here was a genuine algorithmic route to the ordinary
pivot existential: move forward from zero by exiting an interval on which one
runner is strictly bad. A successful termination is an endpoint pivot witness,
and no safe endpoint is skipped. Its exact transition has a small integer
certificate. However, neither bounded owner repetition nor a number of steps
bounded by the runner count is available: an infinite primitive four-speed
family forces an arbitrarily long chain.

This rejects those specific progress measures. It does not reject every possible
interval-based proof, nor assert that the endpoint algorithm ever fails to find
a witness. The family has an explicit closed-boundary witness. A more complicated
well-founded proof would need new information beyond distinct owners or bounded
chain length; saying that the chain terminates before one period is itself the
original witness-existence issue.

## 1. Exact endpoint-exit mechanism

Fix `N>=3` and a finite nonempty family of positive integer speeds. Write
`delta=1/N`. Runner `p` is strictly bad at `t` exactly when there is an integer
`k` with

```text
|p*t-k| < delta.
```

Such `k` is unique because `delta<1/2`. The right endpoint of this bad interval
is

```text
E(p,k) = (N*k+1)/(N*p).
```

It satisfies `t<E(p,k)`, and every `u` in `[t,E(p,k))` remains strictly bad
for this runner. In particular, replacing `t` by this endpoint cannot skip a
closed safe time. At an unsafe time define `F(t)` to be the largest `E(p,k)`
among currently bad runners. This is well-defined by finiteness and obeys the
same no-skipping property. At a safe time stop.

Initially all runners are bad with `k=0`, so the first endpoint is
`1/(N*min speed)`. Every later point is an endpoint of a labelled bad interval.
There are only finitely many such endpoints in one period. Consequently a
known witness in that period forces this procedure to stop by that witness.
This is an extraction algorithm conditional on witness existence, not a proof
of uniform termination.

For an exact transition from pivot `p` at
`t=(N*k+1)/(N*p)` through a bad runner `q` with center `l`, define

```text
D = p*(N*l+1) - q*(N*k+1).
```

Then

```text
0 < D < 2*p,
D = p-q (mod N),
E(q,l)-t = D/(N*p*q).
```

Indeed strict badness is
`-p < q*(N*k+1)-N*p*l < p`; subtracting the middle term from `p`
gives the strict two-sided bound on `D`. These inequalities preserve the safe
boundary: changing `<` to `<=` would invalidate the no-skipping claim at a
lonely endpoint. The integer transition bounds alone do not force the pivot
speed to increase or decrease.

## 2. A three-phase covering obstruction

The following elementary circle-gap fact is useful here. If points of the
circle all lie in a closed arc of length `1-2*delta`, some cyclic gap between
consecutive points has length at least `2*delta`. Therefore if all cyclic gaps
are strictly less than `2*delta`, no common rotation places every point in the
closed safe arc `[delta,1-delta]`.

For

```text
1/5 < t < 7/30
```

the three phases `0,3*t,6*t` have canonical cyclic order

```text
0 < 6*t-1 < 3*t < 1.
```

Their consecutive gaps are

```text
6*t-1, 1-3*t, 1-3*t.
```

All three are strictly less than `2/5`. Thus no translate of these three
phases puts all of them in `[1/5,4/5]`. This is a rotation-independent assertion:
it does not depend on the common speed of the three runners.

The endpoints matter. At `t=1/5`, two gaps equal `2/5`; at `t=7/30`, one gap
equals `2/5`. A strict-gap argument cannot discard either endpoint.

## 3. Infinite four-speed family and arbitrary owner repetition

Let `K>=5` be an integer divisible by five, and set

```text
n=4, N=5, a=(1,K-1,K+2,K+5).
```

This tuple is positive, injective and primitive. For `0<=t<1/5`, speed one is
strictly bad. At `t=1/5`, speed `K+5` has integral phase. For
`1/5<t<7/30`, the three fast phases are a common translate of
`0,3*t,6*t`; Section 2 proves that at least one is strictly bad. Therefore

```text
No time in [0,7/30) is a closed 1/5 witness.
```

The maximal-exit algorithm in Section 1 first jumps from zero to `1/5`. While
its current endpoint lies in `[1/5,7/30)`, speed one is safe, so the next exit
must be provided by one of the three fast speeds. Each such jump has length
strictly less than

```text
2/(5*(K-1)).
```

This is because a complete bad interval for a speed `q>=K-1` has length
`2/(5*q)`, and the current point is strictly inside that interval.
If `m` is the number of further jumps until the first endpoint at or beyond
`7/30`, then

```text
1/30 <= total advance < m * 2/(5*(K-1)),
so m > (K-1)/12.
```

Hence the number of endpoint exits, and the number of repeated visits to the
three fast labels, is unbounded already for four moving runners. This rejects
any proposed theorem bounding this algorithm's step count by a function of
`n` alone, as well as an owner-no-repeat or strictly speed-ranked invariant.
The stronger claim is uniform in the height parameter `K`, not an extrapolation
from a finite search.

A particularly small owner-repetition fixture, for the same strict algorithm,
is `(1,3,12)` at `N=4`:

```text
0 --speed 1--> 1/4
  --speed 12--> 13/48
  --speed 3--> 5/12
  --speed 12--> 7/16 (safe).
```

## 4. The counterfamily has explicit witnesses

This is an auxiliary-route counterfamily, not an LRC counterexample. If
`3` does not divide `K-1`, take `t=1/3`: all three fast phases are equal to
`1/3` or `2/3`, and the slow phase is `1/3`.

If `3` divides `K-1`, write `q=K-1` and take

```text
t = 1/3 + 1/(5*q).
```

The three fast speeds are `q,q+3,q+6`, all divisible by three. Their phases
at this time are

```text
1/5, (q+3)/(5*q), (q+6)/(5*q).
```

They lie in `[1/5,4/5]` because `q>=4`, and the slow phase lies in that
interval as well. The smallest fast speed is exactly on its safe boundary.
Thus there is no ambiguity about witness existence for any family member.

The long chain arises from correlated fast phases, not from individually long
bad intervals. A useful future approach would need to process such clusters
collectively; merely counting bad-interval exits loses that structure.

## 5. Exact finite checks and reproduction

The table was independently generated with Python standard-library rational
arithmetic. `steps` includes the initial `0 -> 1/5` jump. It is support for the
implementation and illustrative instances; Section 3 supplies the uniform proof.

| K | steps | first safe endpoint | explicit witness from Section 4 |
|---:|---:|---|---|
| 5 | 4 | 8/25 | 1/3 |
| 10 | 5 | 7/25 | 16/45 |
| 50 | 8 | 6/25 | 1/3 |
| 100 | 14 | 6/25 | 166/495 |
| 500 | 53 | 591/2525 | 1/3 |
| 1000 | 104 | 392/1675 | 1666/4995 |
| 5000 | 503 | 531/2275 | 1/3 |

Run the following block from any Python 3 environment; no repository imports,
floating-point calculations, or large generated files are needed.

```python
from fractions import Fraction as F

def rho(x):
    r = x % 1
    return min(r, 1-r)

def greedy(a):
    N, t, trace = len(a)+1, F(0), []
    while len(trace) < 100000:
        exits = []
        for p in a:
            x = t*p
            half_shift = x + F(1, 2)
            k = half_shift.numerator // half_shift.denominator
            if abs(x-k) < F(1, N):
                exits.append((F(N*k+1, N*p), p, k))
        if not exits:
            return trace, t
        s, p, k = max(exits)
        assert s > t
        trace.append((p, k, s))
        t = s
        assert t < 1  # This fixture has an explicit witness below one.
    raise AssertionError("fixture step budget exhausted")

for K in (5, 10, 50, 100, 500, 1000, 5000):
    a = (1, K-1, K+2, K+5)
    trace, t = greedy(a)
    w = F(1, 3) if (K-1) % 3 else F(1, 3)+F(1, 5*(K-1))
    assert min(rho(w*p) for p in a) >= F(1, 5)
    assert t >= F(7, 30)
    assert len(trace)-1 > F(K-1, 12)
    print(K, len(trace), t, w)

trace, t = greedy((1, 3, 12))
assert [(p, s) for p, k, s in trace] == [
    (1, F(1,4)), (12, F(13,48)), (3, F(5,12)), (12, F(7,16))]
assert t == F(7, 16)
```

## 6. Formalization-ready statements and exact remaining gap

The following local statements have complete elementary manuscript arguments
above, but have not been kernel-checked or independently promoted:

1. `badInterval_exit_no_skip`: for `p>0`, `N>=3`, and
   `|p*t-k|<1/N`, every `u` with `t<=u<(N*k+1)/(N*p)` is strictly bad.
2. `boundaryTransition_integer_bounds`: two consecutive right-endpoint data
   with the second owner bad at the first imply `0<D<2*p`,
   `D congruent p-q mod N`, and the exact rational time difference.
3. `threePhase_strictGap_obstruction`: for `1/5<t<7/30`, no real translate
   of `0,3*t,6*t` lies wholly in the closed arc `[1/5,4/5]` modulo one.
4. `fourSpeed_no_early_witness`: the family in Section 3 has no witness in
   `[0,7/30)`, and has the explicit witness in Section 4.
5. `fourSpeed_exit_steps_unbounded`: the exact maximal-exit algorithm requires
   more than `(K-1)/12` exits after its initial jump before reaching a safe time.

No Lean implementation is requested solely to preserve this rejected candidate.
The first unresolved unrestricted step would be a new arithmetic invariant
that rules out a complete period of strict bad-interval coverage despite long
repeated-owner chains. No such invariant was derived in this pass. Recasting
that missing assertion as `F terminates` would not be progress, and none of the
local statements above closes the canonical pivot existential.

## 7. Independent review of the affine-avoidance proposal

The orchestrator requested this bounded follow-up after Section 6 was complete.
Reviewed `research/astra-affine-avoidance.md` as present in this pass, containing
"Affine avoidance with prescribed slope product". Verdict: **ACCEPT at the exact
stated manuscript scope**, independently checked; Lean verification remains
pending. No LRC consequence or literature novelty claim is accepted by this
review.

### Exact hypotheses and conclusion

Let `p` be an odd prime, `I` a finite type of cardinality `p-1`, and
`a,v : I -> F_p`. Assume

```text
all a_i != 0,
product_i a_i = -1,
exists i, v_i = 0,
exists j, v_j != 0.
```

Then there exist `r,s != 0` such that every
`s*v_i+r*a_i` avoids both `0` and `-1`. Repeated slopes are allowed. Their
product, not their enumeration of all units, is the relevant hypothesis.
Nonzero slopes also follow from the product hypothesis, but retaining both
assumptions is harmless and simplifies interfaces.

### Independently reconstructed proof

Suppose there are no such `r,s`. Set

```text
P(X) = product_i (X + v_i/a_i),
G = {m in F_p^× : all v_i+m*a_i != 0}.
```

`P` is monic of degree `p-1`. At least one zero `v_i` implies `P(0)=0`.
Fix `m` in `G`. For every nonzero `s`, substitute `r=s*m`; these are both
nonzero. All `s*(v_i+m*a_i)` are nonzero, so failure of avoidance means some
one equals `-1`. Thus the map `i -> v_i+m*a_i` surjects onto `F_p^×`, since
`-1/s` runs through all its members. Domain and codomain each have exactly
`p-1` members, so this map is bijective even though slopes may repeat.

The product of all nonzero elements of an odd prime field is `-1` (pair each
unit with its inverse; the only self-inverse units are `1` and `-1`). Hence

```text
(product_i a_i) * P(m) = product_i(v_i+m*a_i) = -1,
```

and the assumed slope product gives `P(m)=1`. If `m` is nonzero and not in
`G`, one of its factors is zero, so `P(m)=0`. The same equality holds at zero.
Consequently

```text
sum_(m in F_p) P(m) = (|G| : F_p).
```

The sum of a monic degree `p-1` polynomial over `F_p` is `-1`. Explicitly,
the degree-zero monomial contributes `p=0`; each exponent `1<=k<p-1` has zero
power sum by multiplication by a unit whose `k`th power is not one; and the
`(p-1)`st power sums to `p-1=-1`. Such a unit for `k<p-1` exists because a
nonzero degree-`k` polynomial `X^k-1` cannot vanish on all `p-1` nonzero field
elements. Fermat's theorem handles the top power. Monicity supplies coefficient
one for that top term, so lower coefficients do not affect the sum.

It follows that `|G|` is congruent to `p-1` modulo `p`. Since
`0<=|G|<=p-1`, its only possible integer value is `p-1`. But a nonzero `v_j`
gives the nonzero bad value `m=-v_j/a_j`, contradicting that cardinality.
This closes the proof without a lonely-time premise or any cover assumption.

### Quantifier and hypothesis audit

- The field is exactly `F_p` for prime `p`. Do not generalize this proof to
  arbitrary finite fields `F_(p^k)`: the final natural-number congruence is only
  modulo the characteristic, so it no longer determines `|G|=p^k-1`.
  This identifies a proof boundary, not a counterexample to every extension.
- The zero and nonzero assumptions on `v` are both required for this universal
  theorem. With slopes enumerating `F_p^×`, `v=0` admits no pair because the
  values `r*a_i` enumerate all units. With the same slopes and `v=a`, either
  `r+s=0` gives zeros, or the values again enumerate all units. These are exact
  counterexamples after removing, respectively, the nonzero-`v` or zero-`v`
  hypothesis.
- The slope-product hypothesis cannot simply be deleted. Set all `a_i=1`
  and let the `v_i` be distinct, omitting exactly one field element and
  including zero and a nonzero element. For any nonzero `s`, the values
  `s*v_i+r` are `p-1` distinct field elements; they cannot all fit in the
  `p-2` allowed elements. Here the slope product is `1`, not `-1`.
- The argument uses no unstated injectivity of the slope map or of `v`.
  Injectivity of the affine values at a good `m` is derived from equal finite
  cardinalities after proving surjectivity.
- Oddness is consistent with every step. Keeping the odd-prime interface is
  appropriate. The size-one domain at `p=2` could not satisfy the mixed-`v`
  hypotheses anyway; this does not require broadening the formal target.

### Independent exact checks

Direct enumeration, using integer residues and no polynomial implementation,
found a valid pair in every hypothesis-satisfying instance for:

```text
p=3:      8 exhaustive (a,v) instances;
p=5: 23,552 exhaustive (a,v) instances;
p=7,11,13: 200 seeded instances each, seed 20260905.
```

The three removed-hypothesis counterexamples above were also checked at each
of `p=3,5,7`, giving nine negative controls. These are finite consistency checks,
not the unrestricted justification for the lemma.

Reproduction:

```python
from itertools import product
from math import prod
from random import Random

def pair(p, a, v):
    return next(((r, s)
        for r in range(1, p) for s in range(1, p)
        if all((s*y+r*x) % p not in (0, p-1)
               for x, y in zip(a, v))), None)

def check(p, a, v):
    assert len(a) == p-1 and all(a) and prod(a) % p == p-1
    assert 0 in v and any(v)
    assert pair(p, a, v) is not None

for p in (3, 5):
    count = 0
    for a in product(range(1, p), repeat=p-1):
        if prod(a) % p != p-1:
            continue
        for v in product(range(p), repeat=p-1):
            if 0 not in v or not any(v):
                continue
            check(p, a, v)
            count += 1
    print("exhaustive", p, count)

rng = Random(20260905)
for p in (7, 11, 13):
    for _ in range(200):
        a = [rng.randrange(1, p) for _ in range(p-2)]
        a.append((-pow(prod(a) % p, -1, p)) % p)
        v = [rng.randrange(p) for _ in range(p-1)]
        v[0], v[1] = 0, rng.randrange(1, p)
        check(p, a, v)
    print("seeded", p, 200)

for p in (3, 5, 7):
    a = tuple(range(1, p))
    assert pair(p, a, (0,)*(p-1)) is None
    assert pair(p, a, a) is None
    assert pair(p, (1,)*(p-1), tuple(range(p-1))) is None
print("9 necessary-hypothesis negative fixtures passed")
```

Recommended disposition: formalize the affine lemma at this exact prime-field
scope if it has a concrete use in the chosen proof route. The first useful
Lean obligation is the monic degree-`p-1` polynomial sum identity, or reuse of
an equivalent existing theorem. This review does not turn the slope-product
premise into a property of arbitrary integer-speed lift families; that separate
arithmetic bridge remains unresolved.
