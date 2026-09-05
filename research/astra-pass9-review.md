# Independent pass 9 review of weighted avoidance and exact cyclic bands

Status: **accepted**, 2026-09-05. The frozen manuscript, weighted field
proof, exact a priori envelope bridge, candidate construction, and separate
all-odd-count family proof are independently accepted. They are manuscript
results, not Lean declarations or a canonical LRC resolution. The stable
weighted field lemma below was separately confirmed for implementation.

Reviewer `/root/vanishing_slope`, requested in-session Astra xhigh, independent
of author `/root/affine_grid`. Observed runtime model/effort metadata is
unavailable. Current project configuration, workflow, policy, and state were
read, and workflow validation passed. Only this note is reviewer-owned.
No published source edit, Git action, or Lean cache restoration is part of
this review.

Final manuscript read in full after author freeze:

```text
research/astra-exact-band-route.md
  0e2d264986a98b69d93cbfd28ffd81f759df6031869b96a3219249e77b504554
```

No source correction was required. Its embedded checker independently ran
successfully: 53,848 weighted cases, 9,504 cyclic cases, 1,335 family cases,
three bridges, and the arithmetic shifted-pair control.

## 1. Stable field contract and independent proof

Let `p` be prime, `I` finite, and `a_i,v_i in F_p`. Let `F_i` be fixed
finite subsets containing 0. Define

```text
D={m in F_p^* : there exists i with v_i+m*a_i=0}.
```

Assume

```text
|D| <= p-2,       sum_i |F_i minus {0}| <= p-2.
```

Then there are nonzero `r,s` such that
`s*v_i+r*a_i` avoids `F_i` for every row.

There are `p-1` nonzero ratios, so choose `m` outside `D`. Every
`w_i=v_i+m*a_i` is nonzero. For each row, multiplication by `w_i` is a
bijection on the nonzero field elements. Exactly `|F_i minus {0}|`
nonzero choices of `s` can map into its forbidden set. The union of these
bad scales has size at most `p-2`, leaving some nonzero `s`. Set `r=s*m`.
Then `r` is nonzero and
`s*v_i+r*a_i=s*w_i` avoids every `F_i`.

This proves the parent's exact stable contract, even at `p=2`. No separate
nonzero-form assumption is necessary: a zero form would put every nonzero
ratio in `D`, contradicting its bound. The proof permits `a_i=0`, `v_i=0`,
repeated or proportional forms, and empty `I`. A nonzero form excludes at
most one ratio; hence at most `p-2` such rows suffice for the direction
condition, but counting distinct bad directions is the stronger statement.
No offset is assumed nonzero. When every forbidden set is `{0,-1}`, this
recovers the old `p-2` row contract. Larger row sets are possible when their
extra forbidden cardinalities still fit the displayed budget.

The manuscript uses the reciprocal ratio convention
`D_author={z!=0: exists i, a_i+z*v_i=0}`. Inversion on the nonzero field
elements maps this set bijectively to the parent's `D` above. Their
cardinality conditions are identical, and `|F_i|-1` equals
`|F_i minus {0}|` because 0 belongs to each set.

The field hypothesis is substantive. Over `Z/9`, with the stable convention
above, take the single form `3*s`, namely `a=0,v=3`, and forbidden set
`{0,3,6}`. Then `D` is empty and the forbidden weight is 2, yet every output
lies in the forbidden set. Multiplication by 3 is not injective. The
author's reciprocal-convention example uses `3*r` and has the same defect.
The abstract theorem must not be generalized to odd composite residue rings.

## 2. Exact cyclic bad sets and a priori envelopes

For real `q`, write `q=k+theta` with integer `k=floor(q)` and
`0<=theta<1`. For a residue `h`, the bad event is

```text
|| (h+q)/p || < 1/p.
```

Its exact cyclic bad set is `{ -k }` when `theta=0`, and
`{ -k, -k-1 }` when `0<theta<1`, with all residues reduced modulo `p`.
This includes negative `q`, large corrections, and any number of wraps.
At an integer correction there is only one bad residue: replacing the
closed target by an open one would incorrectly add boundary failures.

Fix a modulus `M`, bases `a_i`, actual integer speeds `U_i` congruent to
the bases modulo `M`, and an integer function `R(r0)` chosen in advance
on representatives `r0=1,...,p-1`. Define

```text
beta(r0)=p*R(r0)-M*r0,       q_i(r0)=a_i*beta(r0)/M.
```

For each ordinary row take a fixed forbidden envelope containing 0 and
the union of its exact cyclic bad sets over **every** permitted `r0`.
After those sets and their cardinalities are fixed, apply the field lemma
to `(a_i mod p,U_i mod p)`. Its selected pair therefore avoids the bad
set corresponding to its own selected rounding input. There is no
assumed fixed point or post-selection definition of the envelope.

For a zero row with `p|a_j` and `p|U_j`, the affine residue is zero for
every pair. It suffices to check in advance, for every permitted `r0`,
that `||q_j(r0)/p||>=1/p`. Together with the direction and envelope budgets,
these are an exact sufficient theorem for simultaneous avoidance of all
rows. They are stronger than a supplied successful grid pair. They remain
conditional: constructing such envelopes and uniform zero-row bounds for
arbitrary tuples is a separate unresolved supply problem.

The actual-speed phase identity is essential. If `U_i=a_i+k_i*M` and
`h_i=(s*U_i+r0*a_i) mod p`, then at
`t=s/p+R(r0)/M`,

```text
U_i*t = (h_i+q_i(r0))/p + an integer.
```

Indeed substitution leaves integer terms from
`p*R=M*r0+beta`; the affine offset uses the actual `U_i`, not merely
the base. For an original tuple `V`, independent signs and a common lift
transport this witness whenever
`U_i == sign_i*b*V_i mod(p*M)`: the added `p*M` multiples contribute
integers at the grid time, and the original time is `frac(b*t)`.
Mere congruence modulo `M` is insufficient for this last transport.
For example, `p=7,M=3,U=10,V=7,b=1,t=1/7` has `U==V mod M` and
`||U*t||=3/7`, but `||V*t||=0`.

## 3. Independent candidate audit

For `p=7,V=(2,3,4,7,14,9)`, use identity actual speeds and bases,
`L=7`, and the prescribed rounding

```text
R(r0)=ceil(M*r0/7+M/49),       M>=89.
```

Its exact remainder satisfies `M/7<=beta<M/7+7`. The ordinary corrections
for 2,3,4 lie strictly in `(0,1)`. For 9,

```text
9/7 <= 9*beta/M < 9/7+63/M < 2,
```

where `M>=89>441/5` supplies the strict final inequality. Thus the first
three fixed envelopes are `{0,-1}` and the fourth is `{0,-1,-2}`.
Their total forbidden weight is `1+1+1+2=5=p-2`. There are four nonzero
ordinary forms (with repeated slope 2 for speeds 2 and 9), so the direction
bound holds. In fact all forms are proportional and have only one bad ratio.

The zero corrections satisfy
`1<=7*beta/M<1+49/M<6` and
`2<=14*beta/M<2+98/M<6`. They are uniformly good for every rounding input.
No condition `7` not dividing `M` is used. For `M=98` the lower zero
boundary is actually attained: `beta=14=M/7` for every `r0`.

At `M=101,r0=2,s=6`, rounding gives `R=31,beta=15`. The unreduced time is
`823/707`, whose representative modulo 1 is `116/707`. Direct exact
evaluation gives minimum circle distance `105/707=15/101>1/7`.
The larger family of moduli is an explicit sufficient construction;
89 is not claimed to be a necessary or optimal threshold.

This candidate has no A/B/coarse-C/R normalization by the separately
reviewed obstruction. Hence the new envelope contract supplies a concrete
case outside that union. This is a strict extension of the robust R route;
it does not assert that the new theorem alone subsumes every unrelated
full-size A/B contract.

## 4. Independent uniform family and composite-count audit

The parent proposed the same-family extension during review. It is valid
as a separate elementary residue-ring argument for every **odd integer**
`N>=5` and every positive integer `v`:

```text
V=(2,3,...,N-3,v,N,2N),       length N-1.
```

Duplicates are harmless for this simultaneous-witness theorem. If the
family is presented as an admissible distinct LRC tuple, additionally
exclude values of `v` already present in the displayed other coordinates.
Primitivity holds without any condition on `v`, because speeds 2 and the
odd integer `N` already have gcd 1.

First suppose `N` does not divide `v`. Use the three candidate times

```text
t_K=K/N+1/N^2,       K in {1,(N+1)/2,N-1}.
```

These three `K` are distinct units, with inverses `1,2,-1`. For a core
speed `i=2,...,N-3`, its correction `i/N` lies in `(0,1)` and its affine
residue `i*K` is neither 0 nor -1: the latter would force `i` to be one
of `N-1,N-2,1`. Every core row is therefore good at all three times.
Speeds `N` and `2N` have phases `1/N` and `2/N`, respectively.

For the extra speed, write `v/N=floor(v/N)+theta`, `0<theta<1`.
The cyclic bad set has two adjacent residues. The residues `v` and `-v`
are distinct because 2 is a unit and `v` is nonzero modulo odd `N`.
If both occupy the adjacent bad pair, their difference gives
`2*v==1 or -1 mod N`, which forces `v` to be a unit. Multiplication by
that unit then makes all three `v*K` distinct, so the third escapes.
If either `v` or `-v` already escapes, its corresponding time works.
This handles nonunits `v` at odd composite `N`; primality is not being
silently imported into this three-time proof.

For prime `N` this also follows from the weighted envelope theorem:
choose `M` greater than all bases and divisible by `N^2`, so the usual
`L=N` rounding gives constant `beta=M/N`. The core weight is `N-4`,
the extra cyclic pair with 0 adjoined costs at most 2, and the total is
at most `N-2`. For large `v`, cyclic transport is necessary; a raw
unwrapped-band theorem alone does not justify this argument.

If `N|v` but `N^2` does not divide `v`, use `t0=(N+1)/N^2`. Its extra
phase is the nonzero residue of `v/N` divided by `N`, so it is good.
All other coordinates were already checked at the candidate `K=1`.

Finally, if `N^2|v`, use `t=t0+1/(N*v)`. The extra coordinate has phase
exactly `1/N`. Every core value at `t0` is between
`2/N+2/N^2` and `1-2/N-3/N^2`, and its added correction is less than
`1/N^2`. Thus all core phases stay unwrapped in the closed good band.
The two designated zero speeds have phases
`1/N+1/v` and `2/N+2/v`; since `v>=N^2`, both remain in
`[1/N,1-1/N]`. For the larger one the upper bound follows from
`3*N+2<=N^2`, valid for `N>=5`. No claim for even `N` is made.

These are closed witnesses: speed `N` is exactly at the threshold in
the unperturbed grid, and the extra speed is exactly at it in the final
perturbation. They must not be described as uniformly strict witnesses.

## 5. Independent verification already executed

All computations use exact standard-library integer/Fraction arithmetic.

* 148,848 finite-field avoidance instances passed: 24 exhaustive one-row
  cases at `p=3`; 53,568 exhaustive two-row forms/sets at `p=5`; 46,656
  five-distinct-direction cases at `p=7` with weight 5; and 48,600 genuinely
  weighted four-row cases at `p=7` with one triple forbidden set and three
  double sets, again weight 5. Zero offsets and zero slope coefficients
  occur in the exhaustive form tests.
* 35,000 exact cyclic-bad-set membership checks passed, including integer
  endpoints, negative corrections and multiple wraps.
* 33,264 actual/base integer phase identities and 15,120 common-lift
  original-speed transport checks passed, including signs and integer lifts.
  The modulo-M-only negative control above failed transport as expected.
* All 2,472 rounding inputs across every `89<=M<=500` passed the claimed
  correction envelopes. Every field pair avoiding those fixed sets gave
  a simultaneous original witness. The strict `M=101` fixture and the
  closed `M=98` endpoint were checked separately.
* The prime-family check covered all 3,190 nonzero-speed residue classes
  modulo `N^2` for primes `5,7,11,13,17,19,23,29,31`, including huge lifts.
  The extended direct family check covered all odd `5<=N<=31` and
  `1<=v<=2*N^2`: 10,892 cases, comprising 10,388 nondivisible, 476
  divisible-by-N-only, and 28 divisible-by-N-squared cases. Another 42
  huge-speed cases exercised all three branches.

The failure controls are essential: with `p=7`, all forms equal to `r`
and shifts `k=0,1,2,3,5`, the translated pairs `{ -k,-k-1 }` cover the
whole field. Merely allowing arbitrary row shifts in the old cardinality
lemma is false. The origin-adjoined weight is 9, exceeding the budget 5.
Also, six distinct bad directions at `p=7` cover all ratios even when
every forbidden set is just `{0}` and has zero weight. Finally a single
full forbidden set has weight `p-1` and prevents avoidance. These isolate
the separate roles of origin membership, direction count, and scale budget.

## 6. Final disposition

The final manuscript matches the independent arguments above. The sufficient
theorem in its Section 4 retains all `p-1` actual rows, allows empty ordinary
or zero subsystems when its explicit hypotheses permit them, quantifies
rounding envelopes over every nonzero rounding input, and supplies both
parameters without assuming a successful pair. The phase formula uses
actual offsets and preserves exact integer equality. The normalization
bridge explicitly requires modulo-`pM` representatives. Closed correction
endpoints, repeated slopes, zero actual offsets, and `p|M` are covered.

Its nonnegative correction contract is sufficient as stated. Section 2 of
this review records the algebraically valid signed-correction extension for
independent tests; that broader observation is not attributed to the
manuscript's formal statement. The manuscript correctly distinguishes its
new cyclic equivalence from the existing unwrapped Lean helper.

The additional arithmetic realization of the translated-pair failure was
also checked: `M=101,beta=15`, bases `(1,8,15,22,36)` and actual speeds
`(203,210,217,224,238)` have the claimed floor corrections and offsets.
Compatibility forces `r0=2 mod7`; every `s/7+31/101` fails an ordinary row.
Adding actual/base 7 gives the full distinct primitive original tuple
`(29,30,31,32,34,1)` under common unit 7. This is a fixed-correction failure,
not an all-modulus obstruction or a contradiction to the weighted bound.

Acceptance is for the manuscript field theorem, sufficient cyclic envelope
bridge, explicit candidate certificates and uniform structured family.
No global normalization/envelope supply mechanism, unrestricted tuple
theorem, or canonical LRC resolution follows. Uniform zero-row bounds and
small whole-envelope cardinalities remain unproved for arbitrary tuples.
The author explicitly preserves this gap. Only this review note was edited;
no verification process remains running at handoff.

## 7. Compact independent reproducibility block

This block imports no project code. It repeats the exhaustive weighted
controls, cyclic endpoint/wrap controls, all-odd family check and negative
controls. The additional lift/rounding test domains are recorded in Section 5.

```python
# BEGIN INDEPENDENT PASS9 CONTROLS
from fractions import Fraction as Q
from itertools import combinations, product

def norm(x):
    y = x % 1
    return min(y, 1-y)

def allowed_mask(p, a, u, forbidden):
    return sum(1 << j for j,(r,s) in enumerate(product(range(1,p), repeat=2))
               if (a*r+u*s) % p not in forbidden)

weighted = []
for p,length in ((3,1),(5,2)):
    forms = [(a,u) for a,u in product(range(p),repeat=2) if a or u]
    sets = [frozenset((0,*S)) for k in range(p-1)
            for S in combinations(range(1,p),k)]
    choices = [Ss for Ss in product(sets,repeat=length)
               if sum(len(S)-1 for S in Ss) <= p-2]
    masks = {(A,S):allowed_mask(p,*A,S) for A in forms for S in sets}
    count = 0
    for As in product(forms,repeat=length):
        for Ss in choices:
            valid = (1 << ((p-1)**2))-1
            for A,S in zip(As,Ss):
                valid &= masks[A,S]
            assert valid
            count += 1
    weighted.append(count)

p = 7
doubles = [frozenset((0,t)) for t in range(1,p)]
triples = [frozenset((0,*S)) for S in combinations(range(1,p),2)]
masks = {(d,S):allowed_mask(p,-d,1,S)
         for d in range(1,p) for S in doubles+triples}
count = 0
for ds in combinations(range(1,p),5):
    for Ss in product(doubles,repeat=5):
        valid = (1 << 36)-1
        for d,S in zip(ds,Ss):
            valid &= masks[d,S]
        assert valid
        count += 1
weighted.append(count)
count = 0
for ds in combinations(range(1,p),4):
    for T in triples:
        for Ss in product(doubles,repeat=3):
            valid = masks[ds[0],T]
            for d,S in zip(ds[1:],Ss):
                valid &= masks[d,S]
            assert valid
            count += 1
weighted.append(count)
assert weighted == [24,53568,46656,48600]

cyclic = 0
for p in (3,5,7,11):
    for k in range(-3*p,3*p+1):
        for d in range(1,8):
            for j in range(d):
                q = Q(k)+Q(j,d)
                n = q.__floor__()
                bad = {(-n)%p} if q.denominator == 1 else {(-n)%p,(-n-1)%p}
                for h in range(p):
                    assert (h in bad) == (norm((h+q)/p) < Q(1,p))
                    cyclic += 1
assert cyclic == 35000

family = [0,0,0]
for N in range(5,32,2):
    core = tuple(range(2,N-2))
    K = (1,(N+1)//2,N-1)
    assert tuple(k for k in range(N)
                 if all(norm(a*Q(k*N+1,N*N)) >= Q(1,N) for a in core)) == K
    for v in range(1,2*N*N+1):
        t0 = Q(N+1,N*N)
        if v % N:
            times = [Q(k*N+1,N*N) for k in K]
            branch = 0
        elif v % (N*N):
            times, branch = [t0], 1
        else:
            times, branch = [t0+Q(1,N*v)], 2
        V = (*core,v,N,2*N)
        assert len(V) == N-1
        assert any(all(norm(a*t) >= Q(1,N) for a in V) for t in times)
        family[branch] += 1
assert family == [10388,476,28]

shifted = [{(-k)%7,(-k-1)%7} for k in (0,1,2,3,5)]
assert set().union(*shifted) == set(range(7))
assert all(any(r in S for S in shifted) for r,s in product(range(7),repeat=2))
assert not any(all((s-d*r)%7 for d in range(1,7))
               for r,s in product(range(1,7),repeat=2))
assert all((3*s)%9 in {0,3,6} for r,s in product(range(1,9),repeat=2))
assert norm(Q(10,7)) >= Q(1,7) and norm(Q(7,7)) == 0
V = (2,3,4,7,14,9)
t = Q(6,7)+Q(31,101)
assert t == Q(823,707) and t % 1 == Q(116,707)
assert min(norm(v*t) for v in V) == Q(105,707) > Q(1,7)
print({'weighted':weighted,'cyclic':cyclic,'odd_family':family,
       'negative_controls':'PASS','strict_fixture':'PASS'})
# END INDEPENDENT PASS9 CONTROLS
```
