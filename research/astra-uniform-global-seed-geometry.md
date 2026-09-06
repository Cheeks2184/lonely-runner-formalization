# Global protected-length accounting and its endpoint limitation

Date: 2026-09-06. Registered task `/root/uniform_global_seed_geometry`,
executed by `/root/uniform_seed_coupling`; requested Astra/xhigh.
Supplied and read-back checkpoint:
`1a24e2331d5d8fdcd49c1c77a546fe616671deff`.
Only this report is owned. Current project config, workflow, policy and
focused state were read; startup workflow validation passed. Runtime
model/effort, elapsed time and token usage are not independently exposed.

**Result.** There is an exact global accounting identity for the total
protected extension, the uncovered uniquely bad region, and threshold-shell
multiplicity. It implies a weighted component-count bound. That count bound
is already dominated by endpoint counting, and the complete length identity
also holds for tight positive tuples whose successful protected balls touch
full witnesses only at endpoints. An explicit unbounded prime-count family
has all deletion seeds nonempty and has this behavior. Thus these aggregate
invariants do not yet distinguish strict Q failure from closed equality.

This is manuscript mathematics, not a new Lean theorem. No mathematical computation,
tuple enumeration, dependency restoration, cache operation, shared-state
edit, Git mutation or further delegation was performed. The two approaches
were global extension accounting and the exact obstruction to making that
accounting endpoint-insensitive. Neither uses a local relabelling rule.

## Inputs and notation

Read source bindings:

| Input | SHA-256 |
| --- | --- |
| `research/astra-uniform-all-deletion-seed-screen.md` | `b2b6acd00dae3c8ed777bc3da4227fab0254016eec035c2c100f8d346a398f1b` |
| `research/astra-uniform-seed-coupling.md` | `b52f92b8dca3de5b0ba9f41c24c2dc6bd83a27329a035d40a1273a0401f215ea` |
| `research/astra-uniform-seed-coupling-review.md` | `537c008719aa858c9d97ab46acb5b5cd197b873a78d0266aeae6c05950c7c0bb` |
| `research/astra-tight-seed-grid-explanation.md` | `0ba5e0aaeedd556eecf24eb2986123e6a81369291d3547e48c42d709e2e5595a` |

Let `n=N-1>=3`, with `n` distinct positive integer speeds. Write

```
delta=1/(n+1), gamma=1/n, eta=gamma-delta=1/[n(n+1)],
H = {t : all i have ||v_i*t|| >= delta},
W_p = {t : all i!=p have ||v_i*t|| >= delta},
S_p = {t : all i!=p have ||v_i*t|| >= gamma}.
```

For `s in S_p`, use the accepted exact radius and score

```
rho_p(s)=min_(i!=p) (||v_i*s||-delta)/v_i,
F_p(s)=||v_p*s||+v_p*rho_p(s).
```

Q asks for `F_p(s)>=delta`, assuming every `S_p` is nonempty. Denote by
`B_p` the union of all its closed protected balls, and put `B=union_p B_p`.
For a strong component `C=[l,r]` in a weak component `[L,R]`, its protected
component is exactly `[max(L,2l-R),min(R,2r-L)]`.

All lengths and integrals below are taken over one period `[0,1)`. The
sets involved are finite unions of intervals and points, so `mu` can be
read simply as their total length. There is no equidistribution assumption.
Let `c_p` count the strong components in one period, including singletons,
and `M_p=max_(i!=p) v_i`.

Different strong components for the same deletion lie in different weak
components: on one connected weak component the actual integer phase bands
are fixed, and their gamma restrictions have a single interval intersection.
Consequently their protected components are disjoint. All these components
avoid a neighborhood of the period endpoints, since all speeds vanish there.

## Approach 1: a global extension budget

Define the actual bad multiplicities and uniquely bad sets

```
K_alpha(t)=#{i : ||v_i*t|| < alpha},
U_alpha={t : K_alpha(t)=1},
D(t)=K_gamma(t)-K_delta(t).
```

The shell of speed `i` is `{delta<=||v_i*t||<gamma}`. Its length is exactly
`2*eta`, using its `v_i` full periods. Thus

```
D>=0,  integral D = 2*n*eta = 2/N.                 (1)
```

Assume simultaneous trapping, namely **every** protected component of
every deletion is strictly bad for its own deleted speed. This is Q failure;
absence of all full delta witnesses is not assumed anywhere in this section.
Then:

* `B_p` has unique delta-bad coordinate `p`. Hence different `B_p` are
  disjoint, `B subset U_delta`, and `S_p` avoids `W_q` whenever `q!=p`.
* There is no full gamma witness, since one would immediately satisfy Q.
  The disjoint sets `S_p` therefore partition `U_gamma`.
* Each seed's deleted coordinate is still delta-bad. Hence
  `U_gamma subset U_delta` and `U_gamma subset B`.

Let the total protected extension be

```
E = sum_p [mu(B_p)-mu(S_p)] = mu(B)-mu(U_gamma),
J = U_delta \ U_gamma,
R = integral [D - 1_J].
```

At a point of `J`, the bad count drops from at least two to exactly one,
so `D>=1`; elsewhere `D>=0`. Thus `R>=0`. Equations (1) and the disjoint
partition of `U_delta` give the exact identity

```
E + mu(U_delta \ B) + R = 2*n*eta.                (2)
```

This accounts globally for every lost unit of bad-set multiplicity. The
second term is a uniquely bad region not reached by any protected seed;
the third includes threshold losses that do not create a new uniquely bad
point, and extra multiplicity losses when more than one coordinate changes.
Both are genuine unaccounted quantities in a proposed extension argument.
No statement that `B` covers the circle, `U_delta`, or all full witnesses
has been made.

**Lemma 1 (extension bound).** Under simultaneous trapping,

```
2*eta*sum_p c_p/M_p <= E <= 2*n*eta.              (3)
```

For every seed, `rho_p(s)>=eta/M_p`. The protected union for a strong
interval `[l,r]` therefore contains `[l-eta/M_p,r+eta/M_p]`. Each component
adds at least `2*eta/M_p` to the seed length, even for a singleton.
Summing disjoint components proves the first inequality; (2) proves the
second. This uses all labels simultaneously, not a change of cell or owner.

There is an explicit positive amount of wasted shell mass. Let `M` be the
largest speed and `M_2` the second largest, and put

```
epsilon = min(eta/M, delta*(1/M_2-1/M)) > 0.
```

On the interval `(delta/M, min(gamma/M,delta/M_2))`, the largest speed is
in its shell and every other speed is still delta-bad. Thus `K_delta=n-1>=2`,
`D=1`, and `1_J=0`. Reflection about an integer gives a disjoint interval
of the same length at the other end of the period. Therefore `R>=2*epsilon`,
and (3) sharpens to

```
sum_p c_p/M_p <= n-epsilon/eta < n.              (4)
```

### Why the count inequality is not an additional obstruction

It is tempting to promote (4) as a new global component constraint. A
direct endpoint charge already gives a bound at least as strong.

Whenever the seed sets are disjoint, choose a rising gamma-boundary owner
`i!=p` for the left endpoint of each strong component of `S_p`. This is
valid for singleton components as well: their left endpoint is still the
maximum of the old lower band endpoints. A chosen event is one of

```
(k+gamma)/v_i,  0<=k<v_i.
```

No event can be charged twice, since two such components at that time
would intersect. Its weight satisfies `1/M_p<=1/v_i`. There are exactly
`v_i` rising events of speed `i`, each with available weight `1/v_i`.
Thus `sum c_p/M_p<=n` from endpoint counting alone.

Moreover the first rising event of the largest speed, `gamma/M`, cannot
belong to any seed set: all `n-1>=2` other speeds are strictly gamma-bad.
Its weight `1/M` is unused. Hence already

```
sum_p c_p/M_p <= n-1/M.                          (5)
```

Since `epsilon/eta<=1/M`, (5) dominates (4). This comparison is exact;
there is no new arithmetic or component-count exclusion in (4). Identity
(2) retains more information than that coarse count, but needs an
independent bound on its remaining terms to force useful equality or a
contradiction.

## Approach 2: tight positive tuples satisfy the same length accounting

The following lemma identifies the endpoint information lost by (2).
It was suggested by root's measure-zero observation; the proof and explicit
all-deletion family below check its hypotheses without a finite search.

**Lemma 2 (measure-zero full set).** Suppose only that `mu(H)=0`. Then:

1. No full gamma witness exists, the sets `S_p` are disjoint, and every
   seed's deleted coordinate is strictly delta-bad.
2. Different protected unions satisfy `B_p intersect B_q subset H`.
   They are disjoint **almost everywhere**, which need not mean disjoint.
3. Every `F_p(s)<=delta`; full witnesses in `B_p` can occur only at
   endpoints of its protected components.
4. Identity (2) and inequalities (3)--(5) still hold with the same lengths.

Proof. A full gamma point has uniform slack above delta and hence a
neighborhood in `H`, impossible. Two deletion seeds would give such a
point. At a seed all old norms are strictly above delta. If its pivot norm
were greater than delta, it would already be a strict full witness. If it
equaled delta, a sufficiently small move in the pivot's increasing direction
would make every norm strictly above delta. Either case gives positive
length in `H`. This proves statement 1, including the strict
pivot inequality, and hence `U_gamma subset U_delta`.

Always `B_p subset W_p`, so for different labels an intersection of two
protected unions is fully delta-good. No failure-of-Q hypothesis is needed
for statement 2.

Inside a protected ball's interior, every old norm is strictly above delta:
Lipschitz continuity gives a strict inequality when `|t-s|<rho_p(s)`.
If `F_p(s)>delta`, the exact pivot maximum on the ball is strictly above
delta, and continuity supplies such a point in the ball's interior. It
would give positive length in `H`. Thus `F_p(s)<=delta`. Likewise, in
the interior of a protected component, all old phase-band inequalities are
strict. A full witness there could be moved into a strict full witness.
Therefore any full points in a protected component are endpoints.

Now `B` differs from a subset of `U_delta` only on the null set `H`, and
the protected sets overlap only there. All measure equalities used to prove
(2) survive, as do the component expansion and waste bounds. The endpoint
charge uses the exactly disjoint seed sets and also survives. This proves
statement 4. Notice that statement 3 is a **nonstrict** bound and permits Q
to succeed at equality.

### An unbounded actual family with all deletion seeds supplied

For every prime `N>=5`, take the consecutive speeds

```
v=(1,2,...,N-1),  n=N-1.
```

First, their full delta-good set is exactly

```
H = {a/N mod 1 : gcd(a,N)=1}.                    (6)
```

Indeed the `N` points `0,t,...,(N-1)t` have pairwise circular separation
at least `1/N` whenever `t in H`: a difference is `k*t` with
`1<=k<=N-1`. Each of their `N` cyclic gaps is at least `1/N`; their sum
is one, so all gaps equal `1/N`. Because zero is among the points, they
are the complete `1/N` grid. Thus `t=a/N` and its orbit has order `N`,
equivalently `gcd(a,N)=1`. Conversely a unit residue permutes the nonzero
grid points and gives a full witness. This argument for (6) does not require
primality. In particular `H` is nonempty but has length zero.

Primality is used to give **every** deletion seed explicitly, rather than
assuming an arbitrary lower-count theorem. For a deleted speed `p<n`, put
`q=N-p>=2`, choose `a in {1,...,N-1}` with `a*p=1 mod N`, and define

```
t=a/N,  h=1/[N*n*q],  s=t-h.
```

At `t` the old speed `q` has fractional phase `1-1/N`. At `s` it has
phase `1-1/N-q*h=1-1/n`, hence norm gamma. Every other retained speed has
norm at least `2/N` at `t`, because multiplication by `a` permutes the
nonzero residues and only `p,q` have residues `+1,-1`. Such a speed loses
at most

```
n*h = 1/(N*q) <= 1/(2*N).
```

Its norm at `s` is at least `3/(2*N)>=1/n`. All retained speeds are
therefore gamma-good. The omitted case `p=n` has the direct seed `s=1/n`,
since the retained speeds are `1,...,n-1`. This proves every `S_p` is
nonempty for this unbounded family, using actual common times throughout.

Q succeeds. For `p=1`, take

```
s=1/N-1/[N*n^2],  h=1/[N*n^2].
```

The preceding construction proves it is a seed. Every old speed is at most
`n`, so its radius contribution is at least `eta/n=h`; speed `n` has norm
exactly gamma and attains that bound. Thus `rho_1(s)=h`,
`F_1(s)=s+h=delta`, and the protected ball reaches `1/N` at its right
endpoint. This is also the consecutive-speed specialization of the read
grid explanation. Lemma 2 prevents any seed from having score greater than
delta, but correctly allows this equality.

Consequently (2)--(5), all seed nonemptiness, all seed disjointness, and
almost-everywhere protected disjointness coexist with Q success for
arbitrarily large prime `N`. This is not a synthetic phase configuration.
It refutes neither Q nor every possible use of lengths: an argument that
derives additional equality rigidity and then proves an endpoint contact
could still succeed. It shows why lengths alone cannot identify strict
trapping by treating almost-everywhere disjointness as exact disjointness.

## What is new and what remains

The new derivation is the exact global budget (2), including its two
nonnegative residual terms, and the comparison showing that its coarse
component bound is already paid for by endpoint events. The prime family
supplies an explicit hypothesis-complete obstruction to claiming that these
mass constraints exclude Q-success cases. Its purpose is to check the
aggregate argument's scope, not establish a new runner-count milestone.

No assumption that `H` is empty was used. Q failure allows full witnesses
outside `B`; the identities preserve that distinction. No new divisor,
height, owner-cycle or unrestricted supply theorem has been obtained. The
remaining obligation is to force a protected endpoint to meet a full closed
witness, or obtain a different genuinely restrictive consequence of all
components being **strictly** trapped. Neither an arbitrary full witness nor
a zero-length full set establishes that endpoint contact in general.

For Lean, the first part can be expressed through finite phase-interval
lengths and finite endpoint events; it need not introduce probabilistic
independence. The measure-zero lemma requires care with strict interiors
and closed endpoints. The explicit prime family uses modular inversion,
the existing circle-norm Lipschitz estimate, and rational inequalities.
These are manuscript candidates only. Implementing them would record the
scope limitation and a correct global accounting tool, without resolving Q.
Final independent semantic review remains necessary. No mathematical
program was run, so there is no computational evidence to infer beyond
the displayed proofs and source hash checks.
