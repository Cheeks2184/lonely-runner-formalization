# Independent review of the sieve invariant

Status: **accepted**, bound to `research/astra-sieve-invariant-audit.md`,
SHA-256 `d9c61da83237fa2cefcd533a081b90bd7d6d82ee6c9544ea6a62f7e5cf9dd6af`.
Review date: 2026-09-05. The full preceding frozen version was read, and the
superseding source-scope clarification was read back and checked. No mathematical
correction was required. Only this review file was written; no Lean builds,
cache changes, source/state/Git edits, or external messages were performed.
Current workflow/policy/state were read and structural validation passed.

The versioned primary source was independently opened and read, including
Definitions 2.1/2.3, Lemma 2.4, Proposition 3.1 and its proof, and the algorithm
diagrams in Section 5.2. The diagnosis concerns the displayed set identity and
the invariant sufficient for those idealized diagrams. It is not an audit of
the C++ implementation, computation logs, symmetry implementation, or the
paper's final finite-case theorem.

## 1. Contracts and independent conclusion

Fix `k≥2`, a prime `p`, and positive integer levels. Write `X_l` for the
`k`-tuples modulo `lp` whose coordinates are nonzero modulo
`p`. Let `I_l` be the improper tuples: no omitted-coordinate gcd with `l`
exceeds one, and there is no closed `1/(k+1)` witness on the `lp` grid. Write
`π_l:X_l→X_1` for reduction modulo `p`. The persistent set is
`J=⋂_{l≥1} π_l(I_l)`. These are the definitions used in the
[primary source, Section 2](https://arxiv.org/html/2604.23906v2#S2).

For `L=c*l`, let `ρ:X_L→X_l` be reduction. The lifting operation is
`T=ρ⁻¹(S)∩I_L`. The disputed proof asserts

`π_L(T) = π_l(S) ∩ π_L(I_L)`.

That identity is false for arbitrary `S`. The stated hypothesis
`J⊆π_l(S)` does not supply the missing equality. Projection can use different
witnesses in the same base fiber for the two sets on the right. This is the
specific problem in [Proposition 3.1 and its proof](https://arxiv.org/html/2604.23906v2#S3).

The exact counterexample below refutes this **identity**. It does not exhibit
an element of `J` lost by lifting, and therefore is not itself a counterexample
to the proposition's conclusion about `J`. In particular, a nonempty improper
set at one finite modulus does not prove `J` nonempty.

## 2. Exact counterexample to the projection identity

Take `k=4`, `p=7`, `l=2`, `c=2`, so `L=4`. Let

`E={2,4,6,8,10,12} ⊂ ℤ/14ℤ`, `S=E⁴`.

Reduction modulo 7 bijects `E` with the six nonzero classes, so
`π_l(S)=X_1`, and the advertised premise `J⊆π_l(S)` is automatic.
There are `6⁴=1296` tuples in `S` and `2⁴*6⁴=20736` lifts modulo 28.
Every lifted coordinate is even. For each omitted coordinate the gcd of the
remaining coordinates with 4 is at least 2. Thus every lift is proper and

`T=ρ⁻¹(S)∩I_4=∅`.

On the other hand, `w=(1,2,3,4)` is in `I_4`. All four omitted-coordinate
gcds with 4 equal one, and

`max_{0≤n<28} min_i d_28(n*w_i) = 5`,

where `d_m(x)=min(x mod m, -x mod m)`. Hence the best minimum distance on this
grid is `5/28<1/5`, with the strict inequality checked by `25<28`.
Therefore `(1,2,3,4) mod 7` belongs to `π_l(S)∩π_L(I_4)`, which is nonempty.
The left side of the disputed identity is empty. For example, the element
`(8,2,10,4)∈S` supplies the same base class as `w`, but `w mod 14` is not in
`S`. The witnesses in the two fibers cannot be combined.

This does not attack the closed threshold: at modulus 35 the same tuple has
the exact boundary witness `1/5`. Nor does it claim that this selected set of
proper even tuples is reachable in the actual sieve.

More generally, fix any prime `q≠p`, let `l=q`, and select all CRT
representatives whose coordinates are divisible by `q` and nonzero modulo
`p`. Their projection is all of `X_1`. After lifting by `c=q`, every lift is
proper through its omitted-coordinate gcd with `q²`. Thus arbitrary-`S`
propagation under the weak premise alone would imply `J(k,p)=∅` for every
`k≥2` and every prime `p`. This is an overreach diagnostic, not a proof or
disproof of that emptiness assertion, the paper's finite-case result, or LRC.

## 3. Correct sufficient invariant and proof

Properness is monotone under lifting whenever `l|L`:

`ρ(u) is proper at l  ⇒  u is proper at L`.

For the gcd clause, its divisor `d>1` divides `l`, hence `L`, and divides
each relevant coordinate of `u`, because reduction changes coordinates by
multiples of `lp`. For the grid clause, a witness `a/(lp)` is also on the
`Lp` grid and the changed phases differ by integers. Both arguments preserve
closed endpoints. Contrapositively,

`ρ(I_L)⊆I_l`.                                                   (M)

Maintain the following invariant for the current state `S⊆X_l`. Put
`B=π_l(S)` and require

`J⊆B`, and `I_l∩π_l⁻¹(B)⊆S`.                                   (F)

The second condition says that every improper tuple over every remaining
base class is retained. It is stronger than merely retaining one tuple in
that class. Proper extra tuples are harmless.

**Lifting.** Under (F), there is the exact equality

`T=ρ⁻¹(S)∩I_L = I_L∩π_L⁻¹(B)`.                                 (E)

The forward inclusion is immediate. For the reverse, take `u∈I_L` with
`π_L(u)∈B`. By (M), `ρ(u)∈I_l`, and (F) puts `ρ(u)` in `S`. This proves
(E) without distributing projection across an arbitrary intersection.
Consequently

`B'=π_L(T)=B∩π_L(I_L)`.

Both factors contain `J`, so `J⊆B'`. Also `B'⊆B`, so (E) gives
`I_L∩π_L⁻¹(B')⊆T`. Thus (F) persists at the new level.

**Backward projection.** Replacing `S⊆X_l` by `B⊆X_1` preserves `J⊆B`.
At level 1 the other condition is just `I_1∩B⊆B`, so it also persists.

**Initialization.** Starting from the complete `I_1` satisfies (F) by the
definition of `J`. It follows that any finite sequence of these two operations
preserves (F). In particular, consecutive filtered lifts starting from `I_1`
produce exactly `I_l` at every reached level, by (M).

The idealized algorithms initialize with `I_1`; the diagrams for `k=11` use
only lifts, and those for `k=10,12` project only after their lifts. The stronger
invariant therefore repairs the sieve argument for those diagrams.
[Primary source, Section 5.2](https://arxiv.org/html/2604.23906v2#S5.SS2)
This conclusion interprets each state as its full set of tuples. Using orbit
representatives requires the intended symmetry classes and their lifts to be
covered correctly; no implementation-level certification is asserted here.

## 4. Frozen audit and limited source observations

The author's exact-state invariant `S_l=I_l∩π_l⁻¹(B)`, with `J⊆B`, is a
stronger special case of the invariant proved above and is preserved as claimed.
Its weaker condition `I_l∩π_l⁻¹(J)⊆S_l` also suffices: any improper lift over
`J` descends to an improper tuple over `J` and is retained. Projecting to level
1 retains `J`, which is contained in `I_1`. Its equivalence between the
universal arbitrary-state lifting assertion and `J=∅` is valid: the CRT
construction proves necessity, and empty-set inclusion proves sufficiency.
The manuscript carefully does not assert that an instance of nonempty `J`
is known or that its finite-grid example refutes the final inclusion.

All six immutable C++ URLs in the audit were independently opened and their
source bytes independently fetched. Every SHA-256 matches its source table.
The historical driver at `bd4fb465b874db1fe29b73ee3e7b3811674c00a5` passes
`true` to `make_context` at both call sites. Its helper enumerates each
coordinate child `s+a*old_modulus`, and its complete candidate test rejects a
tuple when either grid coverage is incomplete or an omission gcd proves
properness. These statements concern enumeration relative to a supplied seed;
they do not certify that the supplied seed/orbit list is complete.
[Pinned driver](https://github.com/vzsky/13-lonely-runners/blob/bd4fb465b874db1fe29b73ee3e7b3811674c00a5/main.cpp),
[pinned helper](https://github.com/vzsky/13-lonely-runners/blob/bd4fb465b874db1fe29b73ee3e7b3811674c00a5/src/lift.h).

The one requested clarification was that this historical driver's active
configuration is `K=10`, prime list `{463}`, and
`Squeeze(2), Squeeze(3), Print()`. The name of its `for-k-12` branch is not
evidence of an executed twelve-speed configuration. The revised audit states
this explicitly. In the shown configuration, each squeeze begins at level 1;
at its stopping point the prior projected state is a safe superset. This
observation does not validate arbitrary unshown configurations.

At commit `755b116b2e6090cd4a83187a696f863388b7d746`, the named helper and
strategy code likewise contain complete coordinate-child loops and projection;
the gcd helper uses prefix/suffix omission gcds; the driver obtains its seed
state from the cover generator. I checked these limited source observations.
[Current pinned helper](https://github.com/vzsky/13-lonely-runners/blob/755b116b2e6090cd4a83187a696f863388b7d746/src/lift.h),
[strategy](https://github.com/vzsky/13-lonely-runners/blob/755b116b2e6090cd4a83187a696f863388b7d746/src/lift_strategy.h),
[gcd helper](https://github.com/vzsky/13-lonely-runners/blob/755b116b2e6090cd4a83187a696f863388b7d746/src/speedset.h),
[driver](https://github.com/vzsky/13-lonely-runners/blob/755b116b2e6090cd4a83187a696f863388b7d746/src/driver.h).

No initial cover-generator completeness, orbit reduction, pruning, analytic
orbit deletion, binary execution, historical logs, or large finite-case result
was certified. The audit's explicit implementation boundary is appropriate.
Its sole embedded reproducer was independently rerun and passed all 92
invariant controls and the concrete failed-identity example.

## 5. Independent exact controls

The standard-library block below checks the counterexample directly from the
gcd/grid definition. It independently enumerates complete improper sets for
`k=3,p=5,l∈{1,2,3,6}`, verifies monotonicity and a lift/project/lift history,
and checks the corrected identity for sixteen prescribed unions of base
fibers. All decisions use integer arithmetic and the closed threshold.

```python
from itertools import product
from math import gcd

def distance(m, x):
    return min(x % m, (-x) % m)

def proper(p, l, v):
    k, m = len(v), p*l
    gcd_clause = any(gcd(l, *(v[:i]+v[i+1:])) > 1 for i in range(k))
    grid_clause = any(all((k+1)*distance(m,n*a) >= m for a in v)
                      for n in range(m))
    return gcd_clause or grid_clause

def improper(p, l, k):
    values = [a for a in range(p*l) if a % p]
    return {v for v in product(values, repeat=k) if not proper(p,l,v)}

def project(S, m):
    return {tuple(a % m for a in v) for v in S}

p, k = 7, 4
E = tuple(range(2,14,2))
S = set(product(E, repeat=k))
assert len(S) == 1296
assert project(S,p) == set(product(range(1,p),repeat=k))
lift_count = 0
for v in S:
    for e in product(range(2), repeat=k):
        u = tuple(v[i]+14*e[i] for i in range(k))
        assert all(gcd(4, *(u[:i]+u[i+1:])) >= 2 for i in range(k))
        assert proper(7,4,u)
        lift_count += 1
assert lift_count == 20736
w = (1,2,3,4)
assert [gcd(4, *(w[:i]+w[i+1:])) for i in range(k)] == [1]*4
assert not proper(7,4,w)
assert max(min(distance(28,n*a) for a in w) for n in range(28)) == 5
assert 5*5 < 28
assert (8,2,10,4) in S and tuple(a % 7 for a in (8,2,10,4)) == w
assert w not in S and w in project(S,7)
assert proper(7,5,w)
assert min(distance(35,7*a) for a in w)*5 == 35

p, k = 5, 3
I = {l:improper(p,l,k) for l in (1,2,3,6)}
assert {l:len(T) for l,T in I.items()} == {1:48,2:96,3:288,6:384}
for l,L in ((1,2),(1,3),(1,6),(2,6),(3,6)):
    assert project(I[L],p*l) <= I[l]
S, l = I[1], 1
history = [(l,len(S))]
for L in (2,1,3,6,1):
    if L == 1:
        S, l = project(S,p), 1
    else:
        B = project(S,p)
        S = {v for v in I[L] if tuple(a % (p*l) for a in v) in S}
        assert S == {v for v in I[L] if tuple(a % p for a in v) in B}
        l = L
    B = project(S,p)
    assert {v for v in I[l] if tuple(a % p for a in v) in B} <= S
    history.append((l,len(S)))
assert history == [(1,48),(2,96),(1,48),(3,288),(6,384),(1,48)]
for mask in range(16):
    B = {v for v in product(range(1,p),repeat=k)
         if mask & (1 << (v[0]-1))}
    S = {v for v in I[2] if tuple(a % p for a in v) in B}
    T = {v for v in I[6] if tuple(a % 10 for a in v) in S}
    assert T == {v for v in I[6] if tuple(a % p for a in v) in B}
    assert project(T,p) == project(S,p) & project(I[6],p)
print({'S':1296, 'proper_lifts':lift_count, 'intersection':0,
       'counterexample_best_min':'5/28 < 1/5',
       'improper_counts':{l:len(T) for l,T in I.items()},
       'history':history, 'fiber_union_controls':16,
       'closed_endpoint_control':'passed'})
```

No finite check here decides membership in `J`. The corrected invariant and
monotonicity are proved symbolically above; the finite calculations are
independent controls of their definitions and boundary conventions.
