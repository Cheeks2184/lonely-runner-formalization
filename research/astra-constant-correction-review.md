# Independent review of constant corrections and proportional grouping

Date: 2026-09-05. Task: `/root/vanishing_slope-constant-correction-review`,
requested Astra/xhigh. Runtime model and effort are not independently exposed.

**Accepted after one wording correction.** The six-point classification, the
normalized class-union lemma, the strict grouped certificate and the robust
construction for every `M≥200` are valid. The unrestricted grouped constant
certificate is equivalent to closed-witness existence for the fixed tuple,
including endpoint witnesses and the all-zero case with no ordinary rows. This
equivalence does not establish global supply.

## Source binding and correction

Final reviewed manuscript: `research/astra-constant-correction-audit.md`, SHA-256
`0b70fecaf49a7be91da0c49609e35ee56d3603222ac5d20efba9e3339707e9c0`.
The initial submitted hash was
`7f4cd5ede79e9de4068cfa9cd02d99a099105ff24b4658299182af5ae102dcc8`.

The initial Section 5 described the rounding envelopes as nonconstant for every
modulus. In fact, its correction is constant whenever `5|M`, including `M=200`.
Root applied the requested wording change to say that corrections are allowed
to vary. The formula and all substantive results are unchanged. I read back the
corrected sentence and bind this acceptance to the final hash above.

Read the current configuration, workflow, policy and state, and ran the workflow
validator successfully. Only this review note was written by this task. The
frozen `AffineCyclicBadResidues.lean` remains unchanged at
`5c5ec03de4c5363987098055aa0df170579156bd390206655e417c34f7a2a9bd`.
Earlier reviews/manuscripts, Lean sources, shared state, cache and Git are outside
the write scope. This is manuscript review and exact computation, not a new
Lean proof or a canonical LRC claim.

## Complete ungrouped classification

For the identity tuple `(1,6,11,5)` at `p=5`, the ordinary forms are all `(1,1)`
and their bad-direction set is exactly `{-1}`. Speed 5 has zero homogeneous
phase and correction `theta`, so its exact condition is `norm(theta)≥1/5`.

For `v*theta=q+e`, an integral correction has bad set `{-q}`, giving weight
zero if `q=0 mod5` and weight one otherwise. A nonintegral correction has two
distinct bad residues `{-q,-q-1}`. After adjoining zero its weight is one
precisely when the zero homogeneous phase is bad, equivalently
`norm(v*theta/5)<1/5`; otherwise its weight is two. This checks all four cases
of the stated formula, including singleton corrections and zero weights.

Period five in `theta` adds `5*v` to the quotient and changes no set. Reflection
`theta→5-theta` negates the singleton when integral, and exchanges the negated
pair elements when nonintegral. Thus it preserves every weight and the zero-row
distance, including boundary points.

If all three ordinary corrections are nonintegral, their weights are at least
one, so total weight at most three forces all to equal one. The three phases
`y_i=(1+5*i)*theta/5` then have integer translates `z_i` in `(-1/5,1/5)`.
Their second difference is an integer with absolute value less than `4/5`,
hence zero. In particular, `z_1-z_0=(z_2-z_0)/2` has absolute value less than
`1/5`. Because it is congruent to `theta` modulo one, the zero-row condition
fails. No density or sampled-cell assumption enters this exclusion.

An integral `theta` also fails the zero row. Otherwise only `6*theta` or
`11*theta` can be integral, and they cannot both be integral because
`2*(6*theta)-11*theta=theta`. Reducing by period and reflection to
`0<theta≤5/2`, the complete exceptional denominators are therefore 6 and 11.
The zero-row condition leaves exactly residues `{2,3,4}` modulo 6 and
`{3,4,5,6,7,8}` modulo 11. All 23 eligible entries of the two tables were
independently checked, not just their three passing entries.

The exact feasible set on `[0,5)` is consequently

```text
{5/11, 1/2, 8/11, 47/11, 9/2, 50/11}.
```

There is no feasible open interval in this ungrouped identity model. The
independent phase-based checker covers all 91 breakpoints and 90 open cells;
the analytic argument above proves the real-variable exclusion rather than
generalizing midpoint samples. It includes all ordinary integral corrections
and all zero-row boundary points.

Both isolated certificates are correct. Their times, after reduction modulo
one, are `3/10` and `16/55`, with distances respectively
`(3/10,1/5,3/10,1/2)` and `(16/55,14/55,1/5,5/11)`.
At the first, the integral `6*theta` singleton is essential. At the second,
the zero weight of row 11 compensates the weight-two row 6. Bases and actual
speeds coincide, both moduli exceed 11, and the common multiplier is one;
there is no hidden original-speed transport issue.

## Grouping retains every row and the actual directions

For prime `p`, surjective `pi:I→C` and nonzero field scalars `c_i`, the assumed
pair identities imply

```text
r0*a_i+s*u_i = c_i*(r0*A_pi(i)+s*U_pi(i)).
```

Each class is inhabited, so its union of the inverse-scaled `F_i` contains zero.
Applying the existing author-oriented weighted theorem to the class forms and
these fixed unions therefore produces the required nonzero `r0,s`. If an
original row failed, multiplying its forbidden value by `c_i⁻¹` would place the
class phase inside that class union, contradicting the output. No original row
is discarded.

Multiplication by a nonzero scalar is a bijection fixing zero, so its normalized
set has the same nonzero weight. Subadditivity of finite unions and the fiber
partition prove that the sum of class weights is at most the original total.
Likewise, `a_i+z*u_i=0` if and only if its class representative vanishes.
Surjectivity gives equality of the actual bad-direction sets in both directions.
The assumptions do not silently require every representative to have two
nonzero coefficients. A zero representative would itself violate the stated
direction bound; zero slopes or offsets separately are permitted.

This proof also handles empty row and class sets together and prime two, using
the already established weighted lemma. In the nonempty cases all inverses
used are justified by the nonzero scalar hypothesis. The finite controls below
exercise unequal scalars, repeated representative forms and individual zero
coefficients. The prime hypothesis is retained; no composite-field division is
inferred.

For rounding envelopes the order of unions is essential. Every row's set must
contain its bad residues for all prescribed `r0` values before the class unions
and the weighted theorem are applied. Grouping preserves that quantifier order;
it does not justify choosing the envelopes after the affine pair.

## Strict gain and uniform rounding envelope

At `theta=19/40`, `M=200`, the exact row sets are
`F_1=F_11={0,4}` and `F_6={0,2,3}`. The separate weight is four, while the
class union `{0,2,3,4}` has nonzero weight three. With `r0=2,s=4`, the common
homogeneous phase is one, outside that union. The actual time is `259/200`,
congruent to `59/200`, with exact distance vector `(59,46,49,95)/200` and
minimum `23/100>1/5`. Thus the gain from overlap is strict and concrete.

On the entire interval `[5/11,1/2]`, the same union is an upper bound. Row 11
shrinks to `{0}` at the left endpoint and row 6 shrinks to `{0,2}` at the right;
all interior sets are as above. At the representative time `(1+theta)/5`, the
only tight constraints are `6*t≤9/5` and `11*t≥16/5`. They are equivalent to
the two displayed interval endpoints. The other rows have slack, all four
distances are strict on the interior, and the endpoints meet the closed bound.

For every `M≥200`, writing
`x=M*r0/5+19*M/200`, the ceiling identity gives `0≤ceil(x)-x<1`. Hence

```text
beta/M = 19/40 + 5*(ceil(x)-x)/M
         ∈ [19/40, 19/40+5/M) ⊂ [5/11,1/2).
```

Both inequalities are uniform in `r0`, and `beta=5*R-M*r0` is nonnegative.
The prescribed function therefore has a fixed whole class envelope excluding
one, with the zero row uniformly good. Only then is the pair `r0=2,s=4`
selected. Since `M≥200>11`, every original identity base meets the modulus
bound, including moduli not divisible by five. In fact the selected time is
strictly good for every such modulus, since the whole correction interval lies
inside the strict interval of witnesses.

When `5|M`, the term `M*r0/5` is integral and the correction is constant in
`r0`. When `5∤M`, the four corrections have distinct residues modulo five and
are distinct. The corrected wording accurately permits both cases.

An ungrouped whole envelope passing its bound must pass the pointwise bound at
every `r0`, so every corresponding correction belongs to the six-point set
modulo five. This necessary condition is correctly confined to the ungrouped
identity model. It is not extended to arbitrary bases, signs or multipliers.

## Closed-witness equivalence and its value limit

Fix the stipulated odd prime and positive integer tuple of size `p-1`. The
identity grouping has one representative `(1,1)` for all nonzero residues,
using scalar `[V_i]_p`; all remaining coordinates are zero homogeneous rows.
The forward implication is the grouped theorem together with the uniformly
good zero rows and exact affine transport. Constant rounding is prescribed for
all permitted `r0`, so the selected pair always has its integral realization.

For the reverse implication, a real closed witness gives a common finite set
of floor intervals with rational endpoints. Their intersection is nonempty,
and its largest lower endpoint belongs to every interval. Thus a rational
closed witness exists even when this intersection is a singleton. Reduction
modulo one preserves all integer-speed phases. This step needs no strict
witness or perturbation assumption.

For that rational `t0`, select rational `0≤theta<p` with
`theta=pt0-1 (mod p)`. If its reduced denominator is `d`, choosing
`M=p²*d*L>max V_i` gives an integral `beta=M*theta` divisible by `p` and
integral nonnegative `R(r0)=(M*r0+beta)/p` for every `r0`. With `r0=2,s=p-1`,
both nonzero because `p` is odd, their sum is `p+1` and the resulting time is
congruent to `t0` modulo one.

The actual homogeneous residue of every ordinary row is `[V_i]_p`, which is
nonzero and good for its correction. Thus it avoids both its exact bad set and
the adjoined zero. In the normalized union this says `1∉G`. If the ordinary
index set is nonempty, `0∈G`, so its nonzero weight is at most `p-2`.
For each zero row `V_j=p*q_j`, the homogeneous part contributes an integer,
and its correction distance equals the original good phase. This applies even
to rows divisible by `p²` and to multiple zero rows simultaneously. If there
are no ordinary rows, use no classes and the same zero-row argument; the weight
is zero. All bases are positive and below `M`, actual speeds equal originals,
all signs are positive and multiplier one is a unit modulo `M`.

The equivalence is therefore exact for the stated fixed tuple. It is not an
independent proof of the availability of its bound. Allowing arbitrary valid
normalizations leaves that existential value barrier intact: identity choices
already encode every closed witness, and any correctly transported certificate
implies one. Arbitrary rational `theta` is crucial here. A modulus divisible by
`p²` alone does not put the resulting time on the `p²` grid; that required the
additional restriction `theta=j/p` in the refuted grid proposal. Thus there is
no conflict with the independently verified p=13 obstruction.

## Reproduction and independent controls

The author's final retained reproducer passes with its stated 91 breakpoints,
90 open cells, six feasible points, 23 exceptional entries, three certificates,
32 variable-correction controls and the exact p=13 control.

The independently written block below constructs forbidden sets by checking
actual rational phases for every field residue rather than by reusing the
quotient-based bad-pair function. It passed 181 classification atoms, all 23
table entries, 2,016 prescribed roundings, 41,472 proportional-row systems over
`F3` (4,032 satisfying the grouped bounds), and 113 reverse constructions.
Those reverse controls include 20 singleton floor intersections, seven cases
with no ordinary rows and a case containing prime-square-divisible zero rows.
Finite tests support the proofs above, not their unrestricted quantifiers.

```python
# BEGIN INDEPENDENT CONSTANT CORRECTION CONTROLS
from fractions import Fraction as Q
from itertools import product, combinations_with_replacement

def norm(x):
    r = x % 1
    return min(r, 1-r)
def forbidden(v, theta, p=5):
    return {0} | {h for h in range(p) if norm((h+v*theta)/p) < Q(1,p)}
def weights(theta):
    return tuple(len(forbidden(v,theta))-1 for v in (1,6,11))
def feasible(theta):
    return norm(theta) >= Q(1,5) and sum(weights(theta)) <= 3

points = sorted({Q(k,v) for v in (1,6,11) for k in range(5*v+1)} |
                {Q(k)+q for k in range(5) for q in (Q(1,5),Q(4,5))})
midpoints = [(a+b)/2 for a,b in zip(points,points[1:])]
expected = [Q(5,11),Q(1,2),Q(8,11),Q(47,11),Q(9,2),Q(50,11)]
assert len(points) == 91 and len(midpoints) == 90
assert [t for t in points if feasible(t)] == expected
assert not any(feasible(t) for t in midpoints)
for t in points+midpoints:
    assert weights(t) == weights(5-t) == weights(t+5)
table6 = {2:(1,1,2),3:(1,1,1),4:(1,1,2),8:(2,1,1),9:(2,1,2),10:(2,0,2),14:(2,1,1),15:(2,0,2)}
table11 = {**{k:(1,2,1) for k in (3,4,6,7)},5:(1,2,0),8:(1,1,1),14:(2,2,1),15:(2,2,0),16:(2,2,1),
           **{k:(2,1,1) for k in (17,18,19,26,27)},25:(2,2,0)}
assert all(weights(Q(k,6)) == w for k,w in table6.items())
assert all(weights(Q(k,11)) == w for k,w in table11.items())
for t, ds in ((Q(3,10),(Q(3,10),Q(1,5),Q(3,10),Q(1,2))),
              (Q(16,55),(Q(16,55),Q(14,55),Q(1,5),Q(5,11))),
              (Q(59,200),tuple(Q(n,200) for n in (59,46,49,95)))):
    assert tuple(norm(v*t) for v in (1,6,11,5)) == ds

robust = 0
for M in list(range(200,701))+[1001,10**20,10**20+1]:
    envelope = set()
    correction_values = []
    for r0 in range(1,5):
        x = Q(M*r0,5)+Q(19*M,200)
        r = -((-x.numerator)//x.denominator)
        theta = Q(5*r-M*r0,M)
        assert Q(19,40) <= theta < Q(1,2)
        row_union = set.union(*(forbidden(v,theta) for v in (1,6,11)))
        envelope |= row_union
        assert 1 not in row_union and norm(theta) > Q(1,5)
        correction_values.append(theta)
        robust += 1
    assert envelope <= {0,2,3,4}
    assert (len(set(correction_values)) == 1) == (M % 5 == 0)
    x = Q(M*2,5)+Q(19*M,200)
    r = -((-x.numerator)//x.denominator)
    assert min(norm(v*(Q(4,5)+Q(r,M))) for v in (1,6,11,5)) > Q(1,5)

p = 3
units = (1,2)
forms = list(product(range(p),repeat=2))
sets = [{0} | {i+1 for i in range(p-1) if bits>>i & 1} for bits in range(1<<(p-1))]
classes = (0,1,0)
group_cases = admitted = 0
for reps in product(forms,repeat=2):
    classD = {z for z in units if any((a+z*u) % p == 0 for a,u in reps)}
    for scalars in product(units,repeat=3):
        rows = [tuple(c*q % p for q in reps[k]) for c,k in zip(scalars,classes)]
        assert classD == {z for z in units if any((a+z*u) % p == 0 for a,u in rows)}
        for Fs in product(sets,repeat=3):
            G = [set() for _ in range(2)]
            for k,c,F in zip(classes,scalars,Fs):
                G[k] |= {y for y in range(p) if c*y % p in F}
            assert all(0 in g for g in G)
            assert sum(len(g)-1 for g in G) <= sum(len(f)-1 for f in Fs)
            if len(classD) <= p-2 and sum(len(g)-1 for g in G) <= p-2:
                assert any(all((r*a+s*u) % p not in f for (a,u),f in zip(rows,Fs))
                           for r,s in product(units,repeat=2))
                admitted += 1
            group_cases += 1
assert (group_cases,admitted) == (41472,4032)

singletons = zero_only = square_zero = 0
def reverse(p, V, witness):
    global singletons, zero_only, square_zero
    assert len(V) == p-1 and all(v > 0 for v in V)
    assert all(norm(v*witness) >= Q(1,p) for v in V)
    floors = [(v*witness).numerator//(v*witness).denominator for v in V]
    lower = max((Q(m)+Q(1,p))/v for m,v in zip(floors,V))
    upper = min((Q(m)+1-Q(1,p))/v for m,v in zip(floors,V))
    assert lower <= witness <= upper
    singletons += lower == upper
    t0 = lower % 1
    theta = (p*t0-1) % p
    d = theta.denominator
    L = max(V)//(p*p*d)+1
    M = p*p*d*L
    beta = M*theta
    assert beta.denominator == 1 and beta % p == 0 and M > max(V)
    beta = int(beta)
    R = {r:(M*r+beta)//p for r in range(1,p)}
    assert all(p*R[r] == M*r+beta for r in R)
    I = [v for v in V if v % p]
    J = [v for v in V if v % p == 0]
    G = set()
    for v in I:
        G |= {pow(v % p,-1,p)*f % p for f in forbidden(v,theta,p)}
    assert 1 not in G and len(G-{0}) <= p-2
    if I: assert 0 in G
    else: zero_only += 1
    square_zero += any(v % (p*p) == 0 for v in J)
    assert all(norm(Q(v,p)*theta) >= Q(1,p) for v in J)
    t = Q(p-1,p)+Q(R[2],M)
    assert t % 1 == t0 and all(norm(v*t) >= Q(1,p) for v in V)

fixtures = [(3,(1,2),Q(1,3)),(3,(3,6),Q(1,9)),(3,(9,18),Q(1,27)),
            (5,(1,6,11,5),Q(3,10)),(5,(1,6,11,5),Q(59,200)-2),
            (7,tuple(7*i for i in range(1,7)),Q(1,49)),
            (13,(1,7,8,9,10,17,33,36,64,69,13,26),Q(5,19))]
for p,V,t in fixtures: reverse(p,V,t)
finite = 0
for p,maxv in ((3,8),(5,5)):
    for V in combinations_with_replacement(range(1,maxv+1),p-1):
        candidates = sorted({(Q(m)+Q(1,p))/v for v in V for m in range(v)})
        t = next(t for t in candidates if all(norm(v*t) >= Q(1,p) for v in V))
        reverse(p,V,t)
        finite += 1
assert (robust,finite,singletons,zero_only,square_zero) == (2016,106,20,7,1)
print({'theta_atoms':len(points)+len(midpoints), 'table_entries':len(table6)+len(table11),
       'robust_roundings':robust, 'group_systems':group_cases, 'admitted_group_systems':admitted,
       'reverse_controls':len(fixtures)+finite, 'singleton_floor_intersections':singletons,
       'all_zero_ordinary_subsystems':zero_only, 'square_divisible_zero_controls':square_zero})
# END INDEPENDENT CONSTANT CORRECTION CONTROLS
```

No further correction is required at the bound final hash. The new useful
content is the proved overlap lemma and explicit robust interval estimate.
Unrestricted grouped supply, arbitrary-tuple closed witnesses and canonical
LRC are not established by their equivalence.
