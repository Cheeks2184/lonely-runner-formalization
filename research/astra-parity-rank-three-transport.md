# Rank-three parity transport and its bounded-index remainder

Task `/root/parity_rank_three_transport`, requested Astra/xhigh in the
established `/root/uniform_affine_phase_screen` session. Assignment source:
`6dc1d74935093041cb00e18773893f169aff9331`. Only this manuscript is owned.
The current project config, workflow, policy and focused state were read;
workflow validation passed. Both frozen predecessor manuscripts and their
accepted reviews retain their original bytes.

**Result.** In the nonzero-fold case, the forced outside-plane minimizer
has an even rank-three index `C` and a normalized coefficient `B=-1`.
The accepted short-fibre lemma excludes the entire large-index range:

    2<=C<R*d*(d+1)<=d*(d-1),       C even.

The midpoint supplies another smaller nonnegative integer direction.
However, over *all* odd competitors in the rank-three lattice, the best
upper bound obtained from the two residual magnitudes alone is exactly
the original radius `r`. No coordinate-cancellation argument closing the
remaining small-index range or preserving failure was found. This is one
bounded analytic branch, not an unrestricted proof or disproof.

Root proposed the rank-three arithmetic, midpoint and scalar-envelope
calculation; they are independently checked below. Applying the accepted
fibre bound to the divided primitive direction gives the displayed new
index restriction. No numerical program or search was used.

## Exact input and both primitive planes

Assume an ordinary positive distinct integer failure is minimal by moving
count `d=N-1>=6`, then by natural sum. It is primitive and mixed parity.
Write

    beta_d=(d-1)/(d+1),   r=min_(n odd, s real) ||n-s*v||_infty,
    beta_d<r<1.

The ordinary time is half the displayed lift parameter. Choose a globally
nearest odd vector with the normalized lift

    n=s_0*v+e,    0<s_0<1,    ||e||_infty=r,
    1<=n_i<=v_i.

The predecessor proves saturation of `Zv+Zn` and strict absolute-sum
decrease for `w=v-2n`. This report assumes **every `w_i` is nonzero**;
restoration of first-fold zeros remains a separate unsolved case.

The positive deduplication of `|w_i|` is an actual smaller tuple. Let its
moving count be `ell<=d`. Count/sum minimality supplies its own canonical
witness. Choose a *global* nearest odd vector for the full signed folded
tuple:

    m=tau*w+e',   0<tau<1,
    R=||e'||_infty<=beta_ell<=beta_d<r.                       (1)

Signs and duplicates do not change the circle optimization. Since no zero
was removed, mixed parity persists; the folded primitive vector is not
all odd after positive deduplication. Thus `R>0`, and periodicity and
reflection normalize its doubled ordinary time to `(0,1)` as above.
At this time

    sign(m_i)=sign(w_i),    1<=|m_i|<=|w_i|.                 (2)

These inequalities follow by applying `R<1` and `0<tau<1` after each
coordinate sign change. The predecessor excludes every odd vector of
radius below `r` in `P=span_R(v,n)`, so `m` is outside `P`.

Global nearest-point primitivity applies to `m` relative to `w`, too.
Its proof needs a primitive mixed-parity integer vector, not distinct
absolute coordinates: dividing a nonprimitive nearest quotient class by
its necessarily odd factor would give a shorter point in the same odd
coset. Therefore both `Zv+Zn` and `Zw+Zm` are saturated rank-two
sublattices of the ambient integer lattice.

Let

    Gamma=span_R(v,n,m) intersect Z^d.

This is saturated of rank three. Extend `(v,n)` to a basis `(v,n,u)`
of `Gamma`, and orient `u` so that

    m=A*v+B*n+C*u,    C>0.                                  (3)

Saturation gives `Gamma intersect 2Z^d=2Gamma`. Applying this to `m-n`
proves `A` even, `B` odd and `C` even. The two-by-two minors of the
columns `(1,-2,0)` and `(A,B,C)` in this basis are
`B+2A,C,-2C`. Saturation of `Zw+Zm` consequently gives

    gcd(C,B+2A)=1.                                         (4)

No lattice index is silently discarded in choosing these bases.

## The exact coefficient restriction

Use `E=R^d/Rv`, its actual image lattice `Lambda=U(Z^d)`, and the norm
with unit ball `B_0=U([-1,1]^d)`. Put

    y=U(n),    ||y||=r,    epsilon=U(e'),    ||epsilon||<=R.

The old odd coset is `U(1_d+2Z^d)`. From (1) and (3),

    epsilon=(B+2tau)*y+C*U(u).

For every odd integer `D`, the vector `2u+D*n` is an old admissible odd
vector. Old global optimality and the triangle inequality imply

    r <= 2R/C+r*dist(2(B+2tau)/C,2Z+1).                     (5)

For `C=2h`, distance to `CZ` and distance to `h+CZ` sum to `h`.
Multiplying (5) by `C/(2r)` therefore gives exactly

    dist(B+2tau,CZ)<=R/r<1.                                (6)

Because `B` is odd, `C` is even and `0<tau<1`, the only even integer
within distance strictly below one of `B+2tau` is `B+1`. Hence

    B=-1 mod C,    |2tau-1|<=R/r.                          (7)

Replacing `u` by `u+((B+1)/C)*n` preserves the basis and arranges
`B=-1`. From now on use this basis, and set `theta=2tau-1`. We have

    m=A*v-n+C*u,   A even,   C=2h>0,
    gcd(C,2A-1)=1,
    C*U(u)=epsilon-theta*y,   r*|theta|<=R.                 (8)

The inequalities at equality in (6)--(8) remain allowed; none has been
silently made strict.

## The midpoint and a genuine large-index exclusion

The midpoint

    z=(m+n)/2=(A/2)*v+h*u                                  (9)

is integral, nonzero, and satisfies

    0<=z_i<v_i/2    for every i.                           (10)

If `w_i>0`, (2) gives `m_i>=1` and `m_i<=v_i-2n_i`, so
`0<n_i+m_i<=v_i-n_i<v_i`. If `w_i<0`, it gives
`v_i-2n_i<=m_i<=-1`, hence
`0<=v_i-n_i<=n_i+m_i<=n_i-1<v_i`. Equality `z_i=0` occurs exactly when
`n_i=v_i` and `m_i=-v_i`; in particular that original speed is odd.
If every `z_i` were zero, `m=-n` would be in `P`, a contradiction.

Positive deduplication and primitive normalization after deleting any zeros
therefore produce a genuinely smaller tuple, with raw sum below half the
original sum. They do not produce a failure or preserve an odd target.
In fact `span(v,z)=span(v,u)` contains **no** ambient odd integer vector:
any such vector would lie in `Gamma`, and the identity

    Gamma intersect (1_d+2Z^d)=n+2Gamma

forces its `n`-coefficient to be odd, whereas that plane has coefficient
zero. Thus the midpoint is not a new odd closest vector. Its quotient
satisfies the bounds

    ||U(z)||<=(R+|theta|r)/2<=R,
    g=||U(u)||<=(R+|theta|r)/C<=2R/C.                       (11)

The second estimate has a useful consequence when `C` is large. Since
`(v,u)` is part of a basis of saturated `Gamma`, it is a saturated pair
in the ambient lattice; thus `U(u)` is primitive in `Lambda`.

The accepted centre-preserving projection audit supplies an original
closed witness, using lower-count ordinary supply, whenever

    g<=2/[d(d+1)].                                        (12)

Here is the normalization check. That audit uses
`B_half=U([-1/2,1/2]^d)` and target `K=beta_d*B_half` in lattice
`Lambda`. Its direction gauge is `lambda_K=2g/beta_d`. The accepted
fibre-length estimate is `4/[d(d-1)lambda_K]`; it is at least one,
including equality, when `2g/beta_d<=4/[d(d-1)]`, exactly (12).
The lower-count projection premise is available for the original minimal
failure, and the direction is primitive as just proved. Using `B_0`
with `Lambda` while forgetting this factor two would be incorrect.

Full original failure forces `g>2/[d(d+1)]`. Combining with (11) gives
the strict remaining-index bound

    2<=C < (R+|theta|r)*d(d+1)/2
          <=R*d(d+1)<=d(d-1),       C even.                (13)

This is a uniform exclusion of a large-index portion of the proposed
transport configuration. It does not bound all remaining velocities or
settle the finitely many possible indices at each count. No enumeration
of those indices or restricted-count proof is proposed.

## All rank-three norm bounds stop at the old radius

There is a precise obstruction to completing transport from the two
residual magnitudes alone. Every old odd vector in `Gamma` is

    q=2j*v+D*n+2k*u,   j,k integers,   D odd.

After (8), its quotient is exactly

    U(q)=(2k/C)*epsilon+(D-2k*theta/C)*y.

The triangle upper bound for its old gauge is

    M(k,D)=2|k|R/C+r*|D-2k*theta/C|.                       (14)

For **every** integer `k` and odd `D`,

    M(k,D) >= r*|D|+2|k|(R-r|theta|)/C >= r.               (15)

This follows from `|D-a|>=|D|-|a|` and (8). Its best value is exactly
`r`, attained at `k=0,D=+/-1`. Thus ranging over the entire old odd
coset inside this saturated rank-three lattice does not make that scalar
upper envelope certify any strict improvement. This is a limitation of
the norm-only bound, not a claim that actual coordinate cancellation is
impossible or that every candidate's gauge equals its bound.

The common time and the missing information can be displayed explicitly.
Let `L=A-tau+theta*s_0`. From the actual residuals,

    q-[2j+D*s_0-2k*L/C]*v
      =(2k/C)*e'+(D-2k*theta/C)*e.                         (16)

A successful contradiction to old nearest-point optimality would need a
justified choice of `k,D` and an additional real lift adjustment making
every coordinate of (16) strictly smaller than `r` in absolute value,
or an equivalent strict inequality in the quotient norm. Bounds on `r,R`
and `theta` alone give (15) instead. The actual sign and coordinate
constraints were retained, but no argument forcing that cancellation in
the small-index range (13) was obtained.

There is another numerical decrease of speeds, namely
`w-2m=v-4z`. By (2) its absolute coordinates are at most `|w_i|`,
strictly smaller at an even folded speed, so its absolute sum decreases
again. New zeros may occur. This is a fold of a good smaller tuple; it
does not carry original failure forward. The new minimizer is closest
for `w`, not for `v`, and cannot be treated as a new original nearest
point or used to infer indefinitely increasing independent rank.

## Disposition and source receipts

The strongest new restriction is (13), with the exact parity and midpoint
structure (8)--(10). The scalar comparison (15) proves why this rank-three
test, even with all its odd competitors, still needs additional coordinate
information. No preserved failure or original witness was constructed.
This branch stops at small-index coordinate cancellation; the first-fold
zero case also remains open. The unrestricted canonical completion gate
has not been met, and no disconnected Lean implementation is queued.

The complete frozen predecessors and reviews were read; the exact
short-fibre statement and its independent normalization review were read
again for (12). Current input bindings are:

| Input | SHA-256 |
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

Actual check in `/home/joshua/lonely-runner-formalization`:

    python3 -B scripts/validate_workflow.py

Exit status 0; full output:

    workflow structural validation passed; it cannot certify mathematical validity.

The displayed hand proofs are the mathematical reproduction. Readback
used `sha256sum`; final administrative checks verify all ten input hashes,
the owned file's final newline and absence of trailing whitespace, then
report its SHA-256. No mathematical program, numerical search, solver,
Lean/dependency/cache operation, Git/shared-state mutation or extra agent
was used. No new external mathematical source was invoked beyond the
bound accepted projection contract. No owned process remains or needs
`.lake`/dependency sources. Runtime model/effort observations, elapsed time
and token usage are unexposed and remain null.
