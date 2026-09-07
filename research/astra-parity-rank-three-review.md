# Independent review of rank-three parity transport

Reviewer task `/root/parity_rank_three_review`, requested Astra/xhigh;
source checkpoint `a9bd853a624525d9bb69d88f586da16530d9f5ab`.
Only this review is owned. The complete frozen author is
`research/astra-parity-rank-three-transport.md`, SHA-256
`7dd4d626a3efb1d2b8061261a9b286240f5207ac8655827079a0f887ef3a5048`.

**Verdict: accepted at the stated manuscript scope, without corrections.**
The rank-three congruence, midpoint structure, scalar-envelope calculation
and strict index bound are sound. The index bound excludes a range of
configurations under hypothetical failure; it does not close the remaining
indices, bound all velocities, or establish witness transport.

## Global hypotheses and saturated lattices

The input remains a positive distinct primitive ordinary integer failure,
minimal by moving count and then natural sum, with `d=N-1>=6`.
The old radius satisfies `beta_d<r<1`. The nearest odd lift is normalized
at `0<s_0<1`, and this branch explicitly requires every coordinate of
`w=v-2n` to be nonzero. The earlier zero-restoration problem is not
silently passed through this assumption.

Count/sum minimality supplies a witness for the positive deduplication of
the smaller folded tuple. Taking its global optimum gives the full signed
tuple's radius `0<R<=beta_ell<=beta_d<r`. Signs and duplicates preserve
the optimization because no zero is removed. Mixed parity persists and
excludes zero radius and an optimal ordinary half-time, so the normalized
new lift has `0<tau<1`. The bound `R<1` then gives the asserted signs
and `1<=|m_i|<=|w_i|` coordinatewise.

The fact that `m` is a global closest odd lift matters: a merely supplied
witness would not by itself make `Zw+Zm` saturated. The primitive
nearest-class proof uses primitive mixed parity, not distinct absolute
speeds. It therefore applies to the full signed folded tuple, even when
deduplication reduced its count. The prior in-plane exclusion gives
`m notin span_R(v,n)`, so `Gamma` has rank three.

The pair `(v,n)` extends to a basis of `Gamma`: its span is already
saturated in the ambient lattice, hence also in `Gamma`. Reversing the
third basis vector makes the nonzero coefficient `C` positive. Because
`Gamma` is saturated, `Gamma intersect 2Z^d=2Gamma`. The vector `m-n`
is even, which proves that `A` and `C` are even and `B` is odd.
This parity conclusion is about coordinates in the saturated basis, not
about an arbitrary independent triple of integer vectors.

In that basis the minors of `[w m]` are `B+2A,C,-2C`. Saturation of
the second primitive plane therefore gives `gcd(C,B+2A)=1`. This also
identifies the actual positive index `C`; no lattice factor is discarded.

## Coefficient normalization and midpoint

Projection modulo the original velocity gives
`epsilon=(B+2tau)y+C*U(u)`, with `||y||=r` and
`||epsilon||<=R` in the doubled-cube norm. Every vector `2u+D*n`,
with odd `D`, is an admissible old odd competitor. Applying the old
global lower bound and choosing the nearest odd coefficient gives (5).

Equivalently, use

    dist(2x/C,2Z+1)=1-(2/C)*dist(x,CZ).

This identity holds for every real `x` and positive `C`. It yields
`dist(B+2tau,CZ)<=R/r<1`. Here `C` is even and `B` is odd. Since
`B<B+2tau<B+2`, the only even integer less than distance one from
that point is `B+1`. Thus `C` divides `B+1`, and the residual distance
is exactly `|2tau-1|`. This proves the congruence and the closed bound,
including equality with `R/r`.

The integral basis change `u -> u+((B+1)/C)n` preserves the basis
and gives `B=-1`. With `theta=2tau-1`, all identities in (8), including
`gcd(C,2A-1)=1` and `r|theta|<=R`, follow without further assumptions.

The midpoint is integral because `m,n` are odd. For `w_i>0`, the
new lift bounds imply `0<n_i+m_i<=v_i-n_i<v_i`. For `w_i<0`, they
give `0<=v_i-n_i<=n_i+m_i<=n_i-1<v_i`. These verify
`0<=z_i<v_i/2` and show that equality at zero is exactly
`n_i=v_i,m_i=-v_i`, requiring an odd original speed. If all coordinates
were zero then `m=-n` would contradict the established plane exclusion.

Consequently deleting zeros, deduplicating positive entries and dividing
their gcd gives another smaller positive tuple. This is not a failure
preservation operation. The additional claim about its plane is also
correct: since `z=(A/2)v+(C/2)u` and `C>0`, its real span with `v`
equals `span(v,u)`. Any ambient odd integer point there would lie in
`Gamma`, but `n+2Gamma` has odd `n`-coefficient whereas that plane has
coefficient zero. Thus it contains no such odd vector and does not provide
a new original closest odd lift.

## Primitive direction and strict index exclusion

The pair `(v,u)` is a subset of a basis of saturated `Gamma`, so it
is saturated in the ambient lattice. It follows that `U(u)` is a
nonzero primitive vector in `Lambda=U(Z^d)`. The quotient identity in
(8) gives exactly

    g=||U(u)||_(B_0) <= (R+r|theta|)/C <= 2R/C.

The accepted projection criterion applies to the original ordinary
zonotope. Its generators have a relation with all positive nonzero
coordinates, so it is an LR zonotope in the source's sense. Projecting
along a primitive lattice direction is lattice-surjective onto the image
lattice. The centre-compatible contained LR zonotope and lower-count
ordinary witness supply are the hypotheses established in the accepted
projection audit. No shifted covering-radius assertion, distinct-minor
condition, or coloop-free property of every raw projected generator is
being assumed. The contained lower LR zonotope supplies the needed
nondegeneracy.

The factor two is essential. The accepted body is
`B_half=U([-1/2,1/2]^d)` and its target is `K=beta_d B_half`.
Since `B_0=2 B_half`, the direction's gauge in `K` is
`lambda_K=2g/beta_d`. Therefore

    lambda_K <= 4/[d(d-1)]
      iff g <= 2/[d(d+1)].

The criterion includes equality: its closed fibre has lattice length at
least one and thus contains a point of the correct ordinary affine
lattice. Original failure consequently forces the strict opposite
inequality for `g`. Combining it with the preceding upper bound gives

    2 <= C < (R+r|theta|)d(d+1)/2
             <= R d(d+1) <= d(d-1),       C even.

Every strict/weak boundary in the manuscript is correct. The last step
uses `R<=beta_d`; the original radius is not substituted for `R`.
This application uses an accepted geometric manuscript theorem and
lower-count minimality. It is not a new kernel-checked result or an
application of the compiled height theorem without its height premise.
Bounded index alone gives no bounded velocity family or proof of the
remaining small-index cases.

## All competitors and the remaining cancellation problem

The identity `Gamma intersect(1_d+2Z^d)=n+2Gamma` describes every
old odd vector in this lattice as `2j*v+D*n+2k*u`, where `D` is odd.
Its projected expression and triangle upper bound (14) therefore cover
all such competitors, rather than a chosen subset.

For `a=2k*theta/C`, the elementary inequality
`|D-a|>=|D|-|a|` gives

    M(k,D) >= r|D|+(2|k|/C)(R-r|theta|) >= r.

Oddness ensures `|D|>=1`, and `R>=r|theta|` gives the second
nonnegative term. The value `r` is attained at `k=0,D=+/-1`, so the
minimum of this scalar upper envelope is exactly `r`. This does not say
that the actual coordinate residual equals that envelope or cannot
cancel more strongly.

The common-time formula (16) checks directly. Substituting
`n=s_0*v+e`, `m=tau(v-2n)+e'` into the normalized basis expression
gives `C*u=-L*v+e'-theta*e` with `L=A-tau+theta*s_0`. This is
exactly the displayed original-time coefficient and residual for every
`j,k,D`. Thus a successful cancellation would be an actual original
witness calculation, not independently assigned phases. It is simply
not forced by the scalar estimates established here.

The additional decrease `w-2m=v-4z` also follows from the normalized
new lift. Its absolute coordinates weakly decrease, strictly at a nonzero
even folded coordinate; mixed parity supplies one. New zeros may appear.
This step folds a good smaller tuple and retains no original failure
invariant. It cannot establish iterative rank growth or a descent of
counterexamples.

The settled new conclusion is the strict index restriction together with
the rank-three parity and midpoint structure. The remaining nonzero-fold
obligation is a coordinate-cancellation or transport theorem in the
retained small-index range. The first-fold zero case remains separately
open. Neither an unrestricted witness nor a smaller failing tuple was
constructed, and no disconnected Lean implementation is warranted.

## Exact source bindings and checks

The complete frozen author was read. The predecessors and reviews were
already fully read in the preceding audits; the exact projection and
fibre contract was read again for this application. Current readback
matched all ten author input bindings:

| Input | Actual SHA-256 |
| --- | --- |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |
| `research/astra-parity-plane-joint-descent.md` | `2b9a2350701206bd4bf5af0589cb607b545afe5a96258239a5ad77a031f58472` |
| `research/astra-parity-plane-joint-review.md` | `eafc2a8545ffe8ab2eae1014be5c40ddb8b955723658e3bf0aeb00fc9a497e88` |
| `research/astra-parity-coset-minimum-audit.md` | `b5dd0bbc3ef5d27a986a47b144e225637e338d81c6abceedc2d05d37d392a942` |
| `research/astra-parity-coset-minimum-review.md` | `fda600dd2cdbf2f470bc18e24baeab0bb4b9a90616f34b10d160ba3fa86b3360` |
| `research/astra-center-preserving-projection-audit.md` | `0efe2d8bfb272f194249e6201491a64165d6a102900a71c8953618253f18c60e` |
| `research/astra-center-preserving-projection-review.md` | `a1402e6545dd2de6a2d4b2f832b2ff13ec52f759a1ae5fb183122d1ad3d0c7e6` |

Current configuration, workflow, policy and focused active state were read.
Actual command in `/home/joshua/lonely-runner-formalization`:

    python3 -B scripts/validate_workflow.py

Exit status 0; full raw output:

    workflow structural validation passed; it cannot certify mathematical validity.

Readback used `sha256sum` on the author and the exact listed paths.
Verification was exact hand lattice, parity, norm and interval algebra;
no mathematical program, numerical search, solver, Lean/cache work,
Git mutation, shared-state edit or additional agent was used. Only this
review was written. Its final whitespace/newline receipt and frozen hash
are reported to root separately.
