# Independent review of full replacement minimality

Task `/root/minimal_frequency_review`, executed in the existing
`/root/coordinate_cancellation_review` session. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed time and usage: `null`.
Assignment checkpoint: `60381f4b08e9cb0df5af1bc55e62c05efdf117d5`.
Only this review is owned; the author and other files remain unchanged.

**Accepted at manuscript scope, with no correction required.** The full-set
replacement argument, residue escape and integer rounding, sufficient descent
criterion, collective gcd and divisor restrictions, and both exact controls
are sound. The controls refute primitive-collision supply from one deletion's
least-frequency condition. They do not satisfy actual strict failure or joint
replacement minimality. No unrestricted contradiction or kernel theorem follows.

## Minimality, compactness and all components

Assume positive distinct primitive integer speeds `v_1,...,v_n`, `n>=2`,
with `N=n+1`, `alpha=1/N<1/2` and
`mu=max_(t in T) min_j ||v_j t||<alpha`, chosen first by least moving count
and then least sum among primitive failures. All norms are distances to Z,
and `T=R/Z`. For a deletion i with `m=v_i`, retain the entire closed set

```text
W_i={t : ||v_j t||>=alpha for every j!=i}.
```

Least count gives a deletion witness with its own margin `1/n>alpha`.
Normalizing a deletion by its gcd is harmless: multiplication by a positive
integer is onto T, so common gcd division preserves the ordinary maximum.
Continuity at that stronger witness supplies a nonempty interval in `W_i`.
Intersections of finitely many integer-speed good sets are finite unions of
closed intervals, possibly with additional singleton components. No component
is discarded. At every point of `W_i`, the retained norms exceed mu, so the
deleted coordinate realizes the full minimum and satisfies `||m t||<=mu`.

Fix `1<=u<m`. If u is retained, every point of `W_i` already satisfies
`||u t||>=alpha`. Otherwise replacing m by u preserves positivity and
distinctness and strictly lowers the sum. If the replacement has common gcd
d, division by d preserves its maximum and leaves primitive sum at most its
already smaller sum. A failure after replacement would contradict height
minimality. Therefore, for each such u, there is a possibly u-dependent
`t in W_i` with `||u t||>=alpha`. The duplicate case does not require a
fictitious distinct replacement tuple.

Conversely, if one smaller positive u is strictly alpha-bad on ALL of `W_i`,
the replacement is bad everywhere: inside `W_i` use u; outside it use a
retained coordinate. Its continuous minimum attains a maximum on compact T,
and at that maximizer the value is still strictly below alpha. This is the
needed global strict failure, not just an unattained pointwise upper bound.
A retained u is impossible by nonemptiness of `W_i`; a fresh u gives the
smaller primitive failure just excluded. A bound on one component alone
would not permit this transport.

## Collision residues and every displayed arithmetic bound

For a real lift of a point in `W_i`, write `m t=k+e` with `|e|<=mu`.
The integer k is unique because `2mu<1`. Changing the time lift by an integer
changes k by a multiple of m and leaves e unchanged. The residue `k mod m`
is constant on each connected component of `W_i`, since the closed mu-bad
arcs of speed m are disjoint. Thus the set `K_i` of ALL attained residues is
finite and nonempty; singleton components count, and repeated residues from
different components cause no problem. Gcds with m and the distances below
are independent of representatives.

For `1<=u<m`, put `D_u(k)=dist(u k,m Z)=m||u k/m||`, a nonnegative integer.
At a replacement witness, the circle triangle inequality gives

```text
alpha <= ||u t|| <= D_u(k)/m+u|e|/m <= D_u(k)/m+u mu/m.
```

Taking the maximum over attained residues proves exactly

```text
max_K D_u >= m alpha-u mu > (m-u)/N,
max_K D_u >= floor((m-u)/N)+1.                         (A)
```

The second comparison is strict because `u>0` and `mu<alpha`. The final
integer rounding therefore remains valid when `(m-u)/N` is itself integral.
The attaining or witnessing residue may depend on u.

For every residue, `D_(m-u)(k)=D_u(k)`. Apply (A) separately to u and m-u:

```text
max_K D_u > max(u,m-u)/N >= m/(2N),
max_K ||u k/m|| > 1/(2N).
```

Both multipliers are eligible positive integers below m, including when
they coincide. This does not assert that one residue works for every u.

If, instead, some smaller u satisfies

```text
D_u(k)<=(m-u)/N for every attained k,
```

then at every point of `W_i` its own residue gives

```text
||u t|| <= (m-u)/(mN)+u mu/m
         = alpha-(u/m)(alpha-mu) < alpha.
```

This proves the proposed sufficient descent criterion using the whole set.
It does not produce a multiplier satisfying that criterion.

Let `g=gcd(m,{k:k in K_i})`. If `g>1`, the smaller integer `u=m/g` obeys

```text
u t=k/g+e/g,   ||u t||<=mu/g<alpha
```

at every deletion-good point, since every actual collision lift is divisible
by g. Global transport then contradicts minimality, proving
`gcd(m,K_i)=1`. This is collective primitivity, not individual primitivity.

For ANY divisor `g|m`, `g>=2`, take `u=m/g`. Since
`D_u(k)=(m/g)dist(k,g Z)`, (A) supplies an attained residue with

```text
dist(k,g Z)>(g-1)/N,
dist(k,g Z)>=floor((g-1)/N)+1=ceil(g/N).                (B)
```

The last identity holds for integer g and positive integer N: writing
`g=qN+r`, the cases `r=0` and `1<=r<N` give q and q+1 respectively.
Thus for `g>N`, the required distance is at least two, a stronger restriction
than merely escaping the zero class. No simultaneity across different
divisors is asserted.

For `m=p^r>1`, collective gcd one forces some attained k not divisible by p,
hence `gcd(k,m)=1`. More generally, for each distinct prime dividing m choose
one attained residue not divisible by it. At most `omega(m)` selected residues
then have collective gcd one with m; discard duplicate selections. Neither
claim puts the collision center itself inside `W_i`, makes every component
primitive, or supplies a selected winding arc with unit determinant. For
`m=1`, the gcd statement is tautological and there is no smaller positive u.

## Both exact controls and the failed joint hypothesis

Here the test width a is separate from the native canonical margin. With
retained speeds `(1,5)` and deleted speed 6, the good set is the intersection
of `[a,1-a]` with the five intervals
`[(j+a)/5,(j+1-a)/5]`, `0<=j<5`.
The displayed sets use these real representatives; multiplied intervals below
are real phase ranges before reduction modulo integers.

At `a=1/3`, the intervals for j=1,2,3 give precisely

```text
W={1/3} union [7/15,8/15] union {2/3};
6W={2} union [14/5,16/5] union {4}.
```

The j=0 and j=4 intervals do not meet `[1/3,2/3]`. The nearest collision
integers are exactly 2,3,4; the middle error is at most `1/5<1/3`, and the
singleton errors vanish. Thus W is strictly 6-bad, while its collision set
has `gcd(6,{2,3,4})=1` and no individually primitive element.

All smaller positive frequencies are checked: for u=1,3,5 use `t=1/2`,
giving norm `1/2`; for u=2,4 use `t=1/3`, giving norm `1/3`. These witnesses
belong to W. Equality at width `1/3` is a valid closed good condition and
excludes the open bad covering condition. Hence 6 is actually the least
covering frequency, not just a chosen nonprimitive blocker.

At `a=3/10`, the same intersection gives exactly

```text
W=[3/10,17/50] union [23/50,27/50] union [33/50,7/10];
6W=[9/5,51/25] union [69/25,81/25] union [99/25,21/5].
```

Each component has positive length. The nearest integers remain 2,3,4;
their maximum errors are `1/5,6/25,1/5`, respectively. Thus
`max_W ||6t||=6/25<3/10`. The previous witnesses at `1/2` and `1/3` still
belong to W and now all have norms strictly above a. This verifies every
part of the second least-frequency example without enumeration or a solver.

The formal identity `3-2=1` does not create a primitive deletion-good point:
the actual collision times `1/2` and `1/3` have difference `1/6`, whose
speed-1 norm is below both test widths. No additive closure of W is available.

The full tuple `(1,5,6)` has three moving speeds, so its native margin is
`alpha=1/4`. Both test widths exceed it. At `t=2/7`, the original norms are
`(2/7,3/7,2/7)`, all strictly greater than `1/4`; the tuple is LRC-good.

It also explicitly fails joint least-frequency minimality at `a=3/10`.
Delete 5 and intersect `[3/10,7/10]` with the six-speed good intervals
`[(10j+3)/60,(10j+7)/60]`. Only j=2 and j=3 survive, giving

```text
W_5=[23/60,9/20] union [11/20,37/60],
2W_5=[23/30,9/10] union [11/10,37/30].
```

The speed-2 norm is at most `7/30<3/10` throughout both components. Since
`2<5` and 2 is fresh relative to `(1,6)`, replacing 5 by 2 really preserves
strict failure at this test width and lowers the sum. The complement of
`W_5` is blocked by a retained coordinate, and compactness gives the global
strict maximum as before. Thus these controls refute only the stated
single-set inference. They cannot refute a conclusion using every actual
coordinate condition together under canonical minimal failure.

## Source scope, first gap and verification

The four bound mathematical inputs were read. The winding source was fully
reviewed in the immediately preceding task at its unchanged hash. Its missing
primitive-owner/unit-transition step is not filled by the prime-power
collision statement. The divisor source supplies count/gcd normalization
and strictly trapped seed neighborhoods; those neighborhoods do not replace
all components of `W_i`. The global geometry source likewise distinguishes
the weak deletion sets from protected strong-seed unions. No unproved
coverage by those unions is used here.

Section 3 of the joint-seed audit already gives the stronger fixed-endpoint
replacement invariant in its stated `N>=7` setting. The present elementary
full-set argument is valid for its separately stated `n>=2` hypotheses and
does not import that endpoint selector outside its range. Full replacement
minimality itself is therefore not new. The explicit collision-residue
formulation is absent from the four focused sources, as claimed; this
bounded comparison establishes no literature novelty or independence from
the stronger endpoint constraints. Embedded earlier programs were not run.

The first unresolved implication is a useful synthesis of the joint actual
deletion data: no coordinate and smaller frequency satisfying the sufficient
descent criterion has been produced, and no primitive-collision conclusion
for general composite m follows from one least-frequency condition. Collective
gcd one permits arithmetic combinations of residues but does not preserve
deletion-good times under those combinations. The full coupled version is
open, not falsified. Neither unit winding transitions nor an unrestricted
LRC proof/disproof is supplied.

| Input | SHA-256 |
| --- | --- |
| `research/astra-minimal-frequency-synthesis.md` | `03cf038021f0bc1a2328bb77a02f6ab4fe649f5d3626d7bc368a67cd6c7b0000` |
| `research/astra-arithmetic-winding-exchange.md` | `6fbd8b96223e1697c33d5e187c25fb9f93707c880f2794892dfa16ca0ab2d6d4` |
| `research/astra-arithmetic-winding-review.md` | `45eca69dd2c8b48a0cec68ca737262b9f1a616b08f85046629c9c4e632618243` |
| `research/astra-uniform-divisor-minimality.md` | `8c4b6ee094f0f311f360d3abf371e95f731e28cee997d3810dd3218ff6f25746` |
| `research/astra-joint-seed-maximum-audit.md` | `ac73e29474e272167403c91db34331236bb3832f7ce916b2997d7c2f0d6b46ac` |
| `research/astra-uniform-global-seed-geometry.md` | `3a4a825f3f801282eb39b469571bbd4cac3a4e1f768d58542b7c1555cd725524` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Current project config, workflow, policy and focused state were read. The
state recorded `research/in_progress`, explicit 2026-09-05 start authorization,
this task, its requested route, assignment checkpoint and sole owned file.
`python3 -B scripts/validate_workflow.py` exited 0 with complete output:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

`sha256sum` matched all ten displayed bindings. Final administrative Python
checks verified those bindings again, a final newline and no trailing
whitespace, and returned this review's frozen hash separately. The owned
review was read back in full. All commands exited 0; no mathematical error
or author correction was found. Mathematics was checked only by the displayed
hand arguments. No mathematical program, search, solver, existing-computation
replay, build, cache operation, external model, additional agent, Git mutation,
shared-state edit, memory write or other-file edit was performed. This is
independent manuscript acceptance, not kernel-checked completion.
