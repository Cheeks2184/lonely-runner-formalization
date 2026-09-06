# Global ordinary half-coset minimum: contacts and basis descent

Task `/root/parity_coset_minimum_audit`, executed in the established
`/root/uniform_affine_phase_screen` session, requested Astra/xhigh.
Assignment source: `c97ae49e6e2787acb48ed8f5a13ca9dd8856f5b4`.
Only this manuscript is owned. The current configuration, workflow, policy
and focused active state were read; the workflow validator passed.

**Result.** The exact gauge and primitive-plane consequences below verify
the proposed reformulation, without supplying a sharper minimum. A uniform
ordinary integer family disproves a specific descent inference: a parity
basis change can decrease the speed sum and increase the tracked closest
candidate's gauge while decreasing the new *global* minimum. An exact
all-competitor calculation identifies the missing phase control. Neither
approach proves a uniform witness or a smaller failing tuple.

The basis-change proposal and residual comparison were suggested by root;
the explicit family and its all-real minimum verification were derived
here. Root also proposed the boundary span control in approach one. These
are manuscript derivations; no mathematical program or Lean check was run.

## Setting and exact normalization

Assume a positive distinct integer LRC failure has least moving count
`d=N-1>=6`, then least natural speed sum. It is primitive, since dividing
the gcd preserves failure by time scaling. Count minimality supplies the
ordinary conjecture at smaller counts with their own margins; sum minimality
supplies the original margin for a smaller sum at the same count. It does
not assert that a proposed smaller tuple fails.

Use the accepted intrinsic quotient and its actual image lattice:

    E=R^d/Rv,  U:R^d->E,  Lambda=U(Z^d),
    C=[-1/2,1/2]^d,  B=U(C),  c=U(1_d/2),
    beta=(d-1)/(d+1),  r(v)=min_(x in c+Lambda) ||x||_B.

The quotient lattice has rank `d-1`. The minimum exists: `B` is compact
with zero in its interior in `E`, and a lattice coset has only finitely
many points in any bounded sublevel set. If

    mu(v)=max_(t in R/Z) min_i ||t*v_i||,

then the exact relation is

    r(v)=min_(n in (2Z+1)^d, s in R) max_i |n_i-s*v_i|
        =1-2*mu(v).                                           (1)

Indeed the distance of `s*v_i` to the odd integers is
`1-2*||s*v_i/2||`; the coordinate choices of odd representatives are
independent at a *single common* `s`. Thus original closed-margin failure
is `r(v)>beta`. A time avoiding the finitely many integral phases in one
period has positive minimum circle norm, so `r(v)<1`.

The accepted parity statement gives `c in Lambda` exactly when primitive
`v` is all odd. That case has `mu(v)=1/2`. Hence the hypothetical failure
has `c notin Lambda` and `0<r(v)<1`.

## Approach one: all closest points and their contacts

For every `a in R^d`, interval intersection gives the exact formula

    ||U(a)||_B = max_(i<j) 2*|v_j*a_i-v_i*a_j|/(v_i+v_j).       (2)

For a proposed radius `r>=0`, a lift in `r*C` exists exactly when the
closed intervals

    [(-r/2-a_i)/v_i, (r/2-a_i)/v_i]

have a common point. A finite family of real intervals has a common point
exactly when every left endpoint is at most every right endpoint. Clearing
the positive denominators gives (2), in both orientations. Consequently

    r(v)=min_(n in (2Z+1)^d)
         max_(i<j) |v_j*n_i-v_i*n_j|/(v_i+v_j).               (3)

All odd competitors occur in (3); no bounded dilation or selected local
competitor set has replaced the minimum.

Let `x=U(n/2)` be a minimizing point and choose the optimal lift
`e=n-s*v`, with `max |e_i|=r(v)`. When `r(v)>0`, this `s` is unique.
At the least radius the common interval of lift parameters must be a
singleton: a positive-length intersection would contain a point strictly
inside every interval and permit a smaller radius. Both sets

    I_+={i:e_i=r(v)},   I_-={i:e_i=-r(v)}

are nonempty. Otherwise moving `s` a little, using positivity of every
speed, reduces the maximum. Equality in the triangle estimate for (3)
shows that its active pairs are exactly `I_+` crossed with `I_-`.
For any such pair,

    s=(n_i+n_j)/(v_i+v_j).

The corresponding ordinary time `s/2` has integer numerator over
`v_i+v_j`, since `n_i+n_j` is even. This is the existing balanced
pair-sum cell peak and completeness mechanism. The actual source
`PairSumCompleteness.lean` already proves witness/certificate equivalence;
these contacts do not add certificate supply.

Every minimizing `2x` is primitive in `Lambda`. Write `2x=k*w`, with
`k>0` integral and `w` primitive. Since `2x` has nonzero parity `2c`,
`k` is odd. Then `w` has the same parity, so `w/2` belongs to `c+Lambda`
and has gauge `r(v)/k`. Minimality forces `k=1`.
Equivalently, every minimizing odd lift satisfies

    gcd_(i<j) |v_j*n_i-v_i*n_j| = 1.                         (4)

To justify this coordinate version, extend primitive `v` to an integer
basis. In those coordinates the quotient class of `n` is primitive exactly
when its last `d-1` coordinates have gcd one. Those coordinates generate
the ideal of two-by-two minors of `[v n]`; the ideal is unchanged by
unimodular row operations. Thus `Zv+Zn` is a saturated rank-two lattice.
Equation (4) expresses the already established primitivity of `2x`; it
is not an additional upper bound for (3).

### Boundary control: closest points need not span

For every total `N>=4`, take `v=(1,...,N-1)`. The accepted consecutive
family argument gives exactly the full `1/N` witness times

    t=k/N mod 1,  gcd(k,N)=1.

Indeed the `N` orbit points `0,t,...,(N-1)t` must have all pairwise
circle separations at least `1/N`. Their cyclic gaps sum to one, forcing
the complete equally spaced grid. The converse is immediate. The same
packing argument excludes a strictly larger margin; hence `r(v)=beta`.

For a unit `k`, the nearest coset point has representative

    a_i^k=1/2-fract(k*i/N).

It lies in `c+Lambda` after quotienting out `(k/N)v`. These are all
nearest points, one per maximizing time modulo one. For a fixed time the
representative inside the contracted cube is unique because its side
length `beta` is below one; for a fixed point the optimal common lift is
unique as above. Primitive normalization makes integer changes along the
velocity line exactly integer multiples of `v`, so the time ambiguity
is precisely modulo one.

Since every indicated fractional part is nonzero,
`a^(N-k)=-a^k`. No unit is fixed by this pairing when `N>=4`.
The span of *all* nearest coset points therefore has dimension at most

    phi(N)/2 <= (N-1)/2 < N-2 = dim E.                       (5)

Thus global minimization, even at the sharp boundary, does not imply
spanning of the nearest set. This does not refute a spanning assertion
whose additional hypothesis is strict failure `r(v)>beta`; such an
assertion still needs a proof. No exact rank or finite enumeration is used.

This approach supplies no new restrictive inequality forcing `r(v)<=beta`.
Equations (2)--(4) are useful exact formulations, not progress on that bound.

## Approach two: saturated-plane basis change and all competitors

Let `n=s_0*v+e` be a globally closest odd lift, so `||e||_infty=r(v)`.
Consider the root-proposed integer change

    w=a*v+2*b*n,       n'=2*c*v+d_0*n,
    a,d_0 odd,        a*d_0-4*b*c=+1 or -1.                 (6)

It preserves the rank-two lattice, `w=v mod 2`, `n'=1_d mod 2`, and
the absolute two-by-two minors of the two columns. In the saturated plane
both new columns are primitive. Assume all `w_i` are nonzero. Apply the
same coordinate signs to `w,n'` to obtain positive speeds `|w_i|` and
an odd candidate. These sign changes preserve the minimum and the absolute
minors. Deduplicating nonzero equal absolute speeds and dividing a common
gcd preserve the circle optimization, but the canonical count margin must
be updated. A zero entry cannot simply be dropped as a norm-preserving
operation. The family below needs no deduplication, gcd division or zero
removal.

The preserved candidate has the same numerators as (3) and new denominators
`|w_i|+|w_j|`. Its gauge is an *upper* bound for the new minimum. Raising
that upper bound does not prove new failure.

There is an exact comparison retaining arbitrary competitors. For any odd
`m`, any real `s`, write

    m=s*w+e',    R=||e'||_infty.

For every integer `k`, the old vector `m-2*k*n` remains odd, and

    m-2*k*n - [s*(a+2*b*s_0)-2*k*s_0]*v
       = e'+2*(b*s-k)*e.

Old *global* optimality, followed by the triangle inequality and a nearest
integer choice of `k`, proves

    R >= (1-2*||b*s||)*r(v).                                (7)

This includes all odd competitors, not only those in the preserved plane.
The factor is nonnegative but may be zero. In particular, if `r(v)>beta`
and a new competitor has `R<=beta`, the necessary phase condition is only

    ||b*s|| >= (1-beta/r(v))/2.                              (8)

No premise supplies the reverse strict inequality at a new witness.
The closed case in (8) is deliberate: equality in (7) does not exclude
`R=beta`. A useful transport proof needs a justified choice of a supplied
witness in the excluded phase region, or stronger control of the actual
residuals than this triangle inequality. Minimality supplies neither here.

### Exact uniform obstruction to determinant-and-height monotonicity

For every moving count `d>=6`, start with

    v=(1,2,12,18,21,27),       n=(1,1,7,11,13,17),

and append, for `h=1,...,d-6`, the entries

    v_h=39*h+1,               n_h=24*h+1.

The positive speeds are distinct and primitive. The first two rows of
`[v n]` have determinant `-1`, proving saturation without an unrecorded
lattice index. Every entry of `n` is odd. At `s_0=8/13` the residuals are

    n-s_0*v=(5,-3,-5,-1,1,5)/13,
    n_h-s_0*v_h=5/13.                                      (9)

This is globally closest, with `r(v)=5/13`. Here is the complete all-real
verification, without a time grid. At ordinary time `4/13`, (9) gives
`mu(v)>=4/13`. If the subtuple `(1,2,12)` had a larger minimum, integer
periodicity and reflection would put its time `t` in `[0,1/2]` with

    4/13 < t < 9/26.

The first bound is forced by speed 1, the second by speed 2. But then

    4-4/13 < 12*t < 4+2/13,

so `||12*t||<4/13`, a contradiction. This proves the matching upper
bound for every real time and every appended tuple.

Choose in (6) `a=d_0=3`, `b=-2`, `c=-1`; its determinant is `9-8=1`.
Then

    w=3*v-4*n=(-1,2,8,10,11,13),       w_h=21*h-1,
    n'=-2*v+3*n=(1,-1,-3,-3,-3,-3),    n'_h=1-6*h.

Flip the first coordinate and denote the resulting positive tuple by `V`
and odd vector by `z`. The tuple `V` is distinct and primitive. Its base
sum is `45<81`; every appended old/new sum difference is `18*h+2>0`.
All its speeds are nonzero modulo 3. Therefore ordinary time `1/3` has
minimum norm `1/3`. The pair `(1,2)` prevents a larger minimum: after
reflection to `[0,1/2]`, either `t<=1/3` or `||2*t||=1-2*t<=1/3`.
Consequently

    r(V)=1/3 < 5/13=r(v).                                   (10)

Nevertheless the *preserved* candidate `z` has gauge exactly `5/7`.
At lift time `-2/7` its residual is

    z-(-2/7)*V=(-5,-3,-5,-1,1,5)/7,
    z_h-(-2/7)*V_h=5/7.

The pair of speeds `1,13` forces the same lower bound in (3), namely
`|13*(-1)-1*(-3)|/(1+13)=5/7`. Thus its gauge increases from `5/13`
to `5/7` while the global minimum decreases to `1/3`.

The better competitor really is outside the preserved plane. Before the
sign flip, its first six odd entries can be

    m=(-1,1,5,7,7,9),

at new lift time `s=2/3`, with residual norm `1/3`; for an appended speed
`21*h-1`, take `m_h=14*h-1`, also with residual `-1/3`.
If `m=A*v+B*n`, its first two entries force `A=2,B=-3`, but the third
entry of `2*v-3*n` is `3`, not `5`. This excludes even real-plane
membership. In this example `||b*s||=1/3`, consistent with the weak
comparison (7).

This family disproves minimum monotonicity inferred solely from a globally
closest odd lift, saturated parity basis change, invariant minors, positive
distinct primitive output, and strictly smaller natural sum. It does **not**
refute a descent theorem with the further strict-failure and minimality
hypotheses: here `r(v)=5/13<beta` for every `d>=6`, so the original tuples
already satisfy LRC. It also does not claim that every basis change fails.
Its role is to exhibit the missing outside-plane competition, uniformly
in dimension, rather than to prove successive runner counts.

## Remaining mathematical obligation and checks

Neither approach obtains the target upper bound or preserved failure.
The new concrete method obstruction is (9)--(10), together with the exact
all-competitor comparison (7). Contact balance and primitive minors remain
reformulations. A successful basis descent still must prove that *every*
odd competitor for an actually smaller tuple exceeds its canonical radius
under original failure, or transport a supplied good competitor to an old
one. Preserving one plane cannot establish that quantifier. Projecting
along the closest primitive `2x` does not repair it: put `u=2x`; the central
target fibre has `u`-coordinate interval `[-beta/(2*r(v)),beta/(2*r(v))]`,
whereas the affine coset coordinates are `1/2+Z`. Under strict failure
that fibre misses the coset, even though the projected centre itself is
already an integral witness.

These conclusions retain the ordinary central coset, stationary zero,
closed threshold, full global competitor set and the actual image lattice.
No unrestricted proof/disproof, new failing tuple, Q resolution, arbitrary
phase theorem, or Lean implementation is claimed or queued.

The complete accepted projection author/review, the relevant pair-sum
contract and actual source proofs, and the consecutive-family and minimum
arguments were read. Current byte bindings are:

| Input | SHA-256 |
| --- | --- |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |
| `research/astra-center-preserving-projection-audit.md` | `0efe2d8bfb272f194249e6201491a64165d6a102900a71c8953618253f18c60e` |
| `research/astra-center-preserving-projection-review.md` | `a1402e6545dd2de6a2d4b2f832b2ff13ec52f759a1ae5fb183122d1ad3d0c7e6` |
| `research/astra-pair-sum-cell-contract.md` | `1b441ec0b0145007cf18bce59482396d175634cdd34d3ba4edba8c0376cb7c8f` |
| `LonelyRunner/PairSumGeometry.lean` | `3bc47a6f1a77950577edc54b571e9809bb03bffd37575ebc10bae0fcfcab9384` |
| `LonelyRunner/PairSumCompleteness.lean` | `838a3bcec806b0e9d01cd117e64e5348de58a05127a3f7bef5dbe2d879ff292f` |
| `research/astra-uniform-global-seed-geometry.md` | `3a4a825f3f801282eb39b469571bbd4cac3a4e1f768d58542b7c1555cd725524` |
| `research/astra-minimal-height-audit.md` | `40e59ba4539eb931a07612e9b972999d3b48006d39ef4760c0e493d08e734325` |

Actual administrative command, working directory
`/home/joshua/lonely-runner-formalization`:

    python3 -B scripts/validate_workflow.py

Exit status 0; full output:

    workflow structural validation passed; it cannot certify mathematical validity.

The displayed equalities and all-real interval arguments are the complete
mathematical reproduction; no solver, enumeration or executable mathematical
checker is required or claimed. Input hashes were read with `sha256sum`;
owned-file trailing-whitespace/final-newline and hash checks accompany the
handoff. No external mathematical result beyond the bound local sources
was invoked, so no new literature retrieval was needed. No Git, shared
state, Lean, dependency or cache mutation was performed. There are no
running owned processes and this task requires no `.lake` or dependency
source. Runtime model/effort observations, elapsed time and token usage are
unexposed and recorded as null, not inferred from the manuscript.
