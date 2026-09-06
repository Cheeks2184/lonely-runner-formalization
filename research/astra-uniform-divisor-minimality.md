# Uniform minimal-counterexample divisor profile

Date: 2026-09-06. Task: `/root/uniform_divisor_minimality`.
Requested route: Astra / xhigh; runtime model/usage not independently exposed.
Source checkpoint supplied by root: Pass 58, `a064347`.
Status: manuscript derivations and exact controls, not new Lean declarations or
an unrestricted LRC result. Only this report was edited; no build/cache or Git
mutation was performed. The workflow validator passed at task startup.

**Result.** The codimension-one divisor consequences and the stronger
multi-exception orbit-capacity inequalities below are arithmetically compatible with the sharper
finite-height bound for every `N >= 5`. A consecutive block beginning at
`lcm(2,...,N)` supplies an explicit family satisfying them. It also satisfies
the necessary fast-speed ratio bound and has an explicit common good time.
Consequently these divisor/height/ratio conditions cannot alone contradict a
least-count counterexample. A separate common-time phase constraint is given
below; no universal escape theorem is claimed for it.

## 1. Count convention and source contracts

Write `N` for total runners, `n=N-1` for moving speeds, and
`v=(v_0,...,v_(N-2))` for distinct positive integers. Let

```
W_N(v) := exists t in R, every i satisfies ||t v_i|| >= 1/N.
G := gcd(v_i : all i).
D_p := gcd(v_i : i != p).
C_d := #{i : d divides v_i}.
B_N := choose(N,2)^(N-2).
```

Assume `H_N = LowerCountPositiveIntegerHypothesis N` and `not W_N(v)`.
For the primitive profile also assume `G=1`. A hypothetical least total count
of positive-integer failure provides exactly `H_N`: every nonempty tuple of
`d <= N-2` moving speeds has its own margin `1/(d+1)`. In particular every
single-deletion complement receives `1/(N-1)`, not `1/N` and not `1/(N-2)`.
Common gcd division preserves failure by a time rescaling. The completed
canonical six-runner milestone means an actual least failing count would have
`N>=7`; the arguments below are deliberately uniform from their smaller stated
thresholds and are not a next-count research program.

Actual APIs read:

* `LowerCountSupply.lean`, `LowerCountPositiveIntegerHypothesis`: positivity,
  injectivity and `1 <= d <= N-2` are explicit. It does not assume global LRC.
* `SmallDenominatorWitness.lean`, `divisor_cover_of_no_small_witness`: for any
  positive target denominator `N`, failure forces every `2 <= q <= N` to
  divide at least one speed. This theorem does not use primitivity or `H_N`.
* `RationalShiftInsertion.lean`,
  `exists_nat_shift_preserving_divisible_family`: at any supplied real time,
  shifts `t+k/ell`, `0 <= k < ell`, preserve all `ell`-divisible coordinates
  exactly and give a single nondivisible coordinate margin `1/4`.
  `fiveMovingNaturalRunners_of_four_divisible` is only its fixed-count wrapper;
  it is not the required arbitrary-`N` lower-count theorem.
* `RationalShiftGcd.lean`,
  `exists_nat_rational_shift_circleNorm_ge_mesh`: the exceptional orbit size
  is `r=ell/gcd(ell,d)` and its uniform mesh margin is `(r-1)/(2r)`.
* `DivisorInsertion.lean`, `codimensionOneDivisorInsertion`: with `n_old`
  old moving speeds it consumes their own margin `1/(n_old+1)`, produces
  `1/(n_old+2)`, and requires `2r <= (n_old+2)(r-1)`.
  Here `n_old=N-2`, so that arithmetic condition is `2r <= N(r-1)`.
* `FiniteHeightReduction.lean`,
  `primitive_sorted_largeHeight_stationary_lonelyAt`: for sorted labels
  `(0,v)`, `m=N-2`, primitive gcd and `H_(m+2)`, a height strictly greater
  than `choose(m+2,2)^m` supplies the stationary witness. Its contrapositive
  has the inclusive cutoff `max(v) <= B_N`. No all-runner large-height
  specialization is needed here.

## 2. Necessary profile, with proofs and redundancies

**Proposition 1 (exact deletion gcd consequence).** For `N>=4`, without assuming
primitivity, `H_N` and `not W_N(v)` imply `D_p=G` for every label `p`.

Proof. The complement has `N-2` distinct positive speeds, so `H_N` gives a
time `t` with their norms at least `1/(N-1)`. If `D_p` did not divide `v_p`,
then `D_p>=2` and the generic reciprocal shift preserves all complement norms
and raises the exceptional norm to at least `1/4`. Both margins are at least
`1/N` for `N>=4`, a contradiction. Thus `D_p|v_p`, and the definition of the
full gcd gives `G=gcd(D_p,v_p)=D_p`.

The sharper orbit description gives the same result: use
`r=D_p/gcd(D_p,v_p)=D_p/G`. If `r>=2`, then
`N(r-1)-2r >= 4(r-1)-2r = 2(r-2) >= 0`, so divisor insertion succeeds.
This also explains the endpoint: at `N=4,r=2`, the attained `1/4` is enough
because the target is closed. At `N=3` the displayed mesh test only excludes
`r>=3`; one must not infer this proposition from that test for `r=2`.

For a single exceptional phase, `(r-1)/(2r)` is the exact phase-independent
mesh guarantee: after permuting the reduced coprime orbit, take its translate
`x=(r-1)/(2r)`. The antipode is halfway between two adjacent grid points, so
the maximum norm on that translate is exactly `(r-1)/(2r)`. This exactness is
about the one-coordinate orbit bound, not a characterization of failure.

**Corollary 2 (primitive divisor upper bound).** Under `G=1` and `N>=4`,

```
every deletion complement has gcd 1;
for every integer d>=2, C_d <= N-3.
```

These two displayed statements are equivalent for any positive tuple of this
size, even without a no-witness hypothesis. If a divisor divides at least
`N-2` coordinates, some deletion complement has gcd at least that divisor.
Conversely, a deletion gcd greater than one itself divides `N-2` coordinates.
The deletion-gcd condition already implies full primitivity. It is enough to
check the upper bound for primes: a prime divisor of `d` has at least as many
divisible coordinates. Thus listing all deletion gcds, all divisor upper
bounds and the prime upper bounds does not produce three independent
obstructions. Pairwise coprimality is not implied.

**Proposition 3 (small-denominator lower bound and finite height).**

```
for 2<=q<=N, 1 <= C_q <= N-3;
max(v) <= B_N.
```

Proof. If a denominator `q<=N` is missed, every nonzero residue has circle
distance at least `1/q >= 1/N`, and `t=1/q` is a witness. This is exactly the
small-denominator API. The upper bound is Corollary 2. For height, sort `(0,v)`
without changing the distinguished zero or the gcd, put `m=N-2`, and apply the
contrapositive of the sharper stationary large-height theorem.

The lower-cover conditions are equivalent to covering just the integers
`N/2 < q <= N`: multiply any smaller `q>=2` by powers of two until its multiple
lies in that interval. In contrast, covering prime powers alone is weaker;
`N=6`, `v=(3,4,5,7,11)` covers every prime power up to six and has deletion
gcds one, but misses denominator six. Likewise
`lcm(2,...,N) | lcm(v_i)` is necessary but not sufficient for the full divisor
cover. Composite denominators require their factors to occur in one speed.

These assertions concern the given stationary positive speeds. They do not
license imposing the same failure assumptions after choosing a different
distinguished runner and replacing speeds by pairwise differences.

**Proposition 3a (stronger reciprocal-orbit capacity).** The codimension-one
count cap is not the strongest arithmetic consequence of reciprocal shifts.
Under the same primitive no-witness hypotheses, for every `ell>=2`, put
`r_i=ell/gcd(ell,v_i)` for each nondivisible coordinate. Then necessarily

```
sum_(ell does not divide v_i) ceil(2 r_i/N)/r_i >= 1.       (O)
```

Proof. If `1 <= C_ell <= N-2`, apply `H_N` to the divisible subtuple; its
own margin `1/(C_ell+1)` is at least `1/N`. All `ell` shifts `t+k/ell`
preserve these coordinates. A nondivisible coordinate visits `r_i` equally
spaced circle points, each `ell/r_i` times. Its strict bad arc has length
`2/N`, and contains at most `ceil(2 r_i/N)` grid points. Indeed, lifting that
arc to the line, an open interval of length `a` contains at most `ceil(a)`
integers, including when `a` is integral. Thus its bad shifts number at most
`(ell/r_i)ceil(2 r_i/N)`. Since failure makes the union of exceptional bad
sets cover all `ell` shifts, the cardinality union bound proves (O).
Primitivity rules out `C_ell=N-1`; Corollary 2 already gives the stronger
`C_ell<=N-3`. If `C_ell=0`, (O) is automatic because there are `N-1` terms
and each is at least `2/N`.

This bound keeps strict bad arcs and closed desired margins: replacing the
ceiling by a floor is invalid for nonintegral arc lengths. Its individual
arc-count bound is sharp over arbitrary starting phases, but the union bound
does not account for simultaneous overlap and (O) is not a characterization
of actual complete covers. It is a manuscript consequence of the rational
grid argument, not a declaration supplied by the single-exception API.

For primes, (O) becomes the additional count restriction

```
(N-1-C_p) ceil(2p/N) >= p.
```

For `p<=N/2` this says `C_p<=N-1-p`; for example `C_3<=N-4` when `N>=6`.
Thus this prime restriction is stronger than the codimension-one bound.
More generally, when `ell<=N/2`, (O) is the exact simple inequality
`sum_(ell does not divide v_i) gcd(ell,v_i) >= ell`.
Once (O) is required for all `ell`, it subsumes the earlier upper count and
primitivity conditions: zero exceptions give sum zero, and one exception has
`ceil(2r/N)/r <= ceil(r/2)/r < 1` for `N>=4,r>=2`. The small-denominator
lower covers remain a separate constraint; (O) is automatic for a missed
denominator.

## 3. The arithmetic residual is false uniformly

Consider the precise proposed residual: there is no distinct positive
`(N-1)`-tuple with deletion gcds one, every denominator `2..N` covered,
all divisor counts at most `N-3`, all orbit inequalities (O), and maximum at
most `B_N`.

**Proposition 4 (uniform control family).** For every `N>=5`, let

```
L_N = lcm(2,3,...,N),
v_i = L_N+i,  0 <= i <= N-2.
```

This family satisfies every condition in that residual, and also
`v_p < (N-1) max_(i!=p) v_i` for every `p`. Nevertheless it has the explicit
witness `t=1/(2L_N)`.

Proof. Positivity, distinctness and the label count are immediate. The block
contains the two disjoint consecutive pairs `(L_N,L_N+1)` and
`(L_N+2,L_N+3)`. Every single deletion leaves at least one complete pair,
so every deletion gcd is one. Every `q<=N` divides `L_N`, giving the full
cover. Corollary 2's purely arithmetic equivalence yields the upper bound for
**all** `d>=2`, without scanning divisors of these large integers. Alternatively,
`C_d <= floor((N-2)/d)+1 <= floor((N-2)/2)+1 <= N-3`.

For height, `L_N | N!`, so `L_N+N-2 <= N!+N-2 <= B_N`.
The last inequality holds for all `N>=4`: its base is `24+2 <= 6^2`;
if it holds at `N`, then

```
(N+1)!+(N-1) <= (N+1)(N!+N-2)
              <= (N+1) choose(N,2)^(N-2)
              <= choose(N+1,2)^(N-1).
```

The first step uses `(N+1)(N-2) >= N-1`; the last uses
`N+1 <= choose(N+1,2)` and monotonicity of the binomial base.

Since `L_N>=N`, the block has `max(v)<2 min(v)`, hence it satisfies every
displayed fast-speed necessary ratio for `N>=5`.

It also satisfies (O) for every `ell>=2`. For `ell=2` at least two of the
speeds are odd and each contributes `1/2`. For `N>=6` and `ell>=3`, the
number of nondivisible speeds is at least

```
N-2-floor((N-2)/3) >= ceil(N/2).
```

The inequality follows directly for `N=6,7` and from
`2(N-2)/3 >= N/2` for `N>=8`. Every orbit term is at least `2/N`, so their
sum is at least one. For `N=5,ell=3`, the two nondivisible speeds each
contribute `2/3`; for `N=5,ell>=4`, at most one speed in this four-element
block is divisible, leaving three contributions each at least `2/5`.

At the proposed time,

```
t v_i = 1/2+i/(2L_N),
||t v_i|| = 1/2-i/(2L_N)
          >= 1/2-(N-2)/(2L_N) >= 1/N.
```

All phases lie between `1/2` and `1`, so the norm formula is exact.
In fact `N(N-1)|L_N`, since consecutive integers are coprime. Thus
`L_N>=2N`, and the minimum norm is at least `1/4+1/(2N) > 1/(N-1)`
for `N>=5`. The same time is an own-margin seed for every deletion.

This refutes only the explicitly stated arithmetic residual. It is not a
counterexample to LRC, and it is not claimed to survive every available
sufficient geometric theorem. Using a close block makes clear that merely
adding the elementary isolated-fast-speed exclusion does not fix the residual.
There is no reason to implement the routine uniform count corollary as a
purported new proof mechanism on the strength of these constraints alone.

## 4. An additional common-time constraint

The following phase-localization condition is stronger than the arithmetic
profile and is a concrete consequence of lower-count seed geometry. It uses
no generic endpoint escape, universal product weight, fixed odd Bonferroni
correction, whole-good-set isometry, or claim that a seeded component must
reach a witness.

**Proposition 5 (all lower seeds are quantitatively trapped).** Fix `p`, put
`M_p=max_(i!=p) v_i`, and let `t` be **any** own-margin lower-count seed:
`||t v_i|| >= 1/(N-1)` for all `i!=p`. If `not W_N(v)`, then

```
||t v_p|| + v_p / (N(N-1)M_p) < 1/N.                 (T)
```

More precisely, set `delta=1/N` and

```
rho_p(t) = min_(i!=p) (||t v_i||-delta)/v_i > 0.
```

Then `||t v_p||+v_p rho_p(t)<delta`. These are necessary conditions at every
actual seed, with the same `t` in every coordinate; independent replacement
of its phases is not justified.

Proof. Circle norm is 1-Lipschitz. For `|u-t|<=rho_p(t)`, every old norm
remains at least `delta`. Thus the entire closed interval
`[t-rho_p(t),t+rho_p(t)]` must lie in the exceptional runner's strict bad set.
The latter is the disjoint union of the open real intervals
`((k-delta)/v_p,(k+delta)/v_p)`, `k` integral. Connectedness places our closed
interval inside one such component. Its endpoints are strictly inside, giving

```
|t v_p-k| + v_p rho_p(t) < delta.
```

The absolute value is exactly `||t v_p||` because it is below `delta<1/2`.
Finally `rho_p(t) >= 1/(N(N-1)M_p)` proves (T). In particular (T) forces
`v_p < (N-1)M_p`, agreeing with the contrapositive of `fastRunnerInsertion`.
The strict sign is essential: equality yields a closed-boundary witness.

This is a quantitative phase restriction, not a replacement name for witness
existence: it constrains only the lower-count own-margin seed set and its
explicit guaranteed neighborhoods. It makes no assertion about unseeded
components. The family in Proposition 4 violates (T) at its displayed seed,
so (T) is not implied by the arithmetic profile. Conversely, no sufficiency
of this necessary condition for failure is claimed. The held seeded-component
counterexample prevents promoting this observation into a universal escape
principle. Any productive continuation must establish new common-time control
beyond the profile, or use geometry outside these guaranteed neighborhoods.

Source support: `abs_circleNorm_sub_circleNorm_le` in
`FastRunnerInsertion.lean`; finite floor-band intersection is already used by
`bufferedRunnerInsertion` in `BufferedRunnerInsertion.lean`. Proposition 5
itself has been proved here at manuscript level, not added to either module.

## 5. Exact controls and source bindings

The following standalone control ran successfully with `python3 -B` (exit 0).
It checks 60 explicitly constructed families, not an enumeration of candidate
counterexamples. No floating point, Lean invocation, generated table, or
large retained artifact is involved. The all-divisor upper bound follows from
the verified deletion gcds by the proved equivalence above.

```python
from math import lcm, gcd, comb, factorial
from functools import reduce
from fractions import Fraction as F
for N in range(5, 65):
    L = lcm(*range(2, N+1))
    v = list(range(L, L+N-1))
    assert len(v) == N-1 and len(set(v)) == N-1 and min(v) > 0
    assert reduce(gcd, v) == 1
    assert all(reduce(gcd, v[:p]+v[p+1:]) == 1 for p in range(N-1))
    assert all(1 <= sum(x % q == 0 for x in v) <= N-3
               for q in range(2, N+1))
    assert max(v) <= factorial(N)+N-2 <= comb(N, 2)**(N-2)
    for ell in range(2, 2*N+1):
        orbits = [ell//gcd(ell, x) for x in v if x % ell]
        assert sum((F((2*r+N-1)//N, r) for r in orbits), F(0)) >= 1
    assert max(v) < 2*min(v)
    assert all(v[p] < (N-1)*max(v[:p]+v[p+1:]) for p in range(N-1))
    t = F(1, 2*L)
    norms = [min((t*x) % 1, 1-(t*x) % 1) for x in v]
    assert min(norms) >= F(1, N)
    assert min(norms) > F(1, N-1)
    assert all(norms[p] + F(v[p], N*(N-1)*max(v[:p]+v[p+1:])) >= F(1, N)
               for p in range(N-1))
print('PASS: 60 explicit families, N=5..64; exact integers and fractions only.')
```

The additional orbit controls test `2<=ell<=2N` for those 60 families; the
all-`ell` conclusion is supplied by the proof, not by this finite control.

Selected readback `(N,L_N,max(v),minimum norm)`:

```
(5, 60, 63, 19/40)
(6, 60, 64, 7/15)
(7, 420, 425, 83/168)
(8, 840, 846, 139/280)
(10, 2520, 2528, 157/315)
(16, 720720, 720734, 51479/102960)
```

SHA-256 bindings of the actual source files read:

```
0705291adc53011fb72fc718a7260876512b092741442d6a6cceb4b76eb5ccf4  LonelyRunner/LowerCountSupply.lean
1570a359100594f4a5589588e3b32674dc2d54d60e500df1d47aca64c2faf95f  LonelyRunner/SmallDenominatorWitness.lean
6e9d1e3e084188a651e4c875cf36fd5d6fc7cbd5f1914784019a207a0cec01f4  LonelyRunner/RationalShiftGcd.lean
6ab6e77e8f5edcdc2a2d242fb2616327004b376496616f46896303a06876db23  LonelyRunner/RationalShiftInsertion.lean
212fa6d879bab6d70f09a4a43b2027b96724b5e5ac4a22cdf4b368509973166f  LonelyRunner/DivisorInsertion.lean
cb41059260b943411e2ab5360b84b59cd13f2ddf352c3c50a0b3715b9b9987d6  LonelyRunner/FiniteHeightReduction.lean
dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5  LonelyRunner/FastRunnerInsertion.lean
a135f5c41ead308a2a4250f07535bf3e32f78c88599497bf79bb632cd1e05f0a  LonelyRunner/BufferedRunnerInsertion.lean
0b62ef724eb8c24db4085e247e9f16f650ec450291c7ccac2b0ad0981f148727  LonelyRunner/SixTotalDivisorCounts.lean
```

`SixTotalDivisorCounts.lean` supplies a checked fixed-count comparison, not
the proof of the manuscript's arbitrary-`N` statement. No inference above
depends on the independent affine-phase screen's unfinished results.
