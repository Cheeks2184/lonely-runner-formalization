# Independent review of first-fold zero restoration

Task `/root/fold_zero_restoration_review`, reviewer handle
`/root/coordinate_cancellation_review`; requested `gpt-6-astra` / `xhigh`.
Assignment source: `a1bb6a4196ef55d46b81846d767a887c747b15d9`.
Only this review is owned. The complete frozen author was read.

**Verdict: accepted at the stated manuscript scope, without corrections.**
The quarter-cell ceiling, strict ratio restriction and active-zero contact
identities are sound. The `K=2` conclusion is a conditional obstruction to
restoration inside that cell, not an existing failure or a contradiction
to failure. The exact uniform good family refutes unconditional selection
of the smaller fold's own canonical witness in the protection interval.

## Exact hypotheses and the protected cell

The application assumes a positive distinct primitive mixed-parity integer
failure, minimal by moving count `d=N-1>=6` and then natural sum, with

    alpha=1/(d+1),  mu<alpha,
    beta_d=(d-1)/(d+1)<r=1-2mu<1,
    n=s_0*v+e,  0<s_0<1,  ||e||_infty=r,  1<=n_i<=v_i.

Here `n` is globally nearest in the full odd coset and `t_*=s_0/2`
is an actual global ordinary maximizing time. The accepted joint-fold
input supplies a saturated plane `Zv+Zn`, primitive `w=v-2n` and
strict absolute-sum decrease. This branch requires nonempty
`Z={i:w_i=0}`; put `z=max_(i in Z) v_i`.

Every deleted coordinate satisfies `v_i=2n_i congruent 2 mod 4`.
Conversely that congruence alone does not identify a deleted coordinate.
The nonzero positive deduplication is an actual smaller primitive tuple,
so minimality supplies its own canonical margin. The full raw fold has
odd residual radius exactly one because of its zero coordinates. The
accepted rank-three transport theorem requires no zeros and is not applied
to this raw tuple. These predecessor contracts are preserved correctly.

Since `v_i=w_i+2n_i` and `n_i` is odd,

    v_i(1/4+u) = w_i/4+v_i*u+n_i/2,
    ||v_i(1/4+u)|| = 1/2-||w_i/4+v_i*u||

for every real `u`. This uses the exact circle identity
`||x+1/2||=1/2-||x||`, including endpoints. Restoration therefore
requires simultaneous upper bounds `||w_i/4+v_i*u||<=1/2-alpha`.
A lower-distance witness for the smaller folded speeds at their own time
does not imply these upper bounds.

On `J_z={1/4+u: |u|<=1/(2z)}`, every deleted coordinate has
`|v_i*u|<=1/2`, hence norm `1/2-v_i|u|`. Their exact minimum is
`1/2-z|u|`. Their simultaneous closed `alpha`-good portion within this
cell is consequently exactly

    I_Z(alpha)={1/4+u: |u|<=(1/2-alpha)/z}.

This describes one component, not all possible good times for the zeros.
The deleted residual identity `e_i=v_i(1/2-s_0)` gives
`|t_*-1/4|<=r/(2z)<1/(2z)`. Thus an actual global optimum is in
the interior of `J_z`; this is the reason a local ceiling can bound `mu`.

At quarter time all odd speeds have norm `1/4`, while valuation-one speeds
have norm `1/2`. Because `alpha<=1/4`, strict failure forces at least one
speed divisible by four. Such a speed has fold congruent to two modulo
four, so it is retained and even. Together with the nonzero odd folded
coordinates, this also rules out an all-odd first retained fold.

## Exact pair ceiling and the strict elementary lower bound

For any positive `z congruent 2 mod 4` and `b congruent 0 mod 4`,
write `x=|t-1/4|` on `J_z`. Then

    ||zt||=1/2-zx,  ||bt||<=bx.

The minimum of the two affine bounds is maximized at
`x=1/[2(z+b)]`, with value `b/[2(z+b)]`. This point lies in the
cell; also `bx<1/2`, so both norm bounds are attained there. Hence

    max_(t in J_z) min(||zt||,||bt||)=b/[2(z+b)]

with no speed-ratio restriction. Using the actual `t_* in J_z` proves
`mu<=b/[2(z+b)]` for every original multiple of four `b`. Equivalently,
`mu<=||bt_*||<=b|t_*-1/4|<=br/(2z)` rearranges to the same bound.
Neither argument constructs an original witness.

The elementary lower bound is genuinely strict. For `d>=2`, put
`a=1/(2d)`, `M=max_i v_i`, and let
`A_i={t mod 1: ||v_i*t||<=a}`. Each closed set has measure `2a`,
as a union of `v_i` equally spaced circle intervals. The common circle
interval of radius `a/M` around zero lies in every `A_i` and has measure
`2a/M`. Subtracting this known repeated overlap gives

    measure(union A_i)<=sum measure(A_i)-(d-1)*2a/M
                      =1-(d-1)/(dM)<1.

A point outside the union has all distances strictly above `a`, proving
`mu>1/(2d)`. Closed bad sets are essential to the stated strict conclusion;
there is no assumed LRC theorem in this argument. Combining with the pair
ceiling gives exactly `z<(d-1)b`.

A witness at margin `alpha` anywhere in `J_z` necessarily satisfies
`alpha<=b/[2(z+b)]`, or
`z<=((1-2alpha)/(2alpha))*b`. At the canonical margin this becomes
`z<=(d-1)b/2`, with equality allowed. Violation for one such pair
excludes an original witness from the entire cell, and thus from its
protection interval. Meeting all pairwise necessary inequalities does not
prove a simultaneous witness for the remaining coordinates.

## Active-zero contact, both signs and the value two

Quarter time cannot be the old optimum: a required multiple of four would
give zero margin there, whereas `mu>0`. Hence `s_0!=1/2`. All deleted
residuals share a nonzero sign, and their magnitudes are proportional to
their positive speeds. Only the largest deleted speed can be active.

Assume such activity, and put
`sigma=sign(1/2-s_0)`, `h=|t_*-1/4|`. Then `e_z=sigma*r` and
`r=2zh`. A fixed globally closest lift must also have an active coordinate
with opposite sign. If every active residual had sign `sigma`, a small
change of lift time in that sign's direction would decrease every active
absolute residual; finiteness and the strict gaps at inactive coordinates
would decrease their full maximum below `r`, a contradiction.

Choose an opposite active coordinate `j`, set `b=v_j`, and use
`e_j=-sigma*r`. It is retained, because no deleted residual has that sign.
The sign calculation is exact:

    w_j=(1-2s_0)b+2sigma*r
       =sigma*4h(b+z).

Thus `K=sigma*w_j=|w_j|` is a positive integer and

    h=K/[4(z+b)],  r=zK/[2(z+b)],
    mu=[2(z+b)-zK]/[4(z+b)],
    2beta_d(1+b/z)<K<2(1+b/z).

These identities include both signs of `s_0-1/2`; no reflection about
quarter time is assumed. If `K=1`, the radius would be less than `1/2`,
contradicting `r>beta_d>1/2`. Hence two is the first integer value not
uniformly excluded; a particular speed ratio can still exclude it.

For `K=2`, `w_j=+/-2` and oddness of `n_j` force `b congruent 0 mod 4`.
The formulas then yield

    mu=b/[2(z+b)],  (d-1)b/2<z<(d-1)b.

The lower strict bound is precisely `mu<1/(d+1)`; the upper comes from
the elementary strict lower bound. The pair's exact maximum over `J_z`
equals this `mu`, so under strict failure the whole cell misses the
canonical target. This is a valid conditional local obstruction. It does
not establish existence of that configuration or eliminate it globally.

## Uniform good controls and complete real-time verification

For integer `k>=2`, the tuple
`{1,3,4k} union {4j+2:0<=j<=k}` is positive, distinct, primitive and
mixed parity, of count `d=k+4`. Put `D=4k+1`, `gamma=k/D`.
We have `1/5<gamma<1/4` and `gamma>1/6`.

On `[1/3,1/2]`, speeds `2,3` have minimum at most `1/5`: on
`[1/3,2/5]` speed `3` has norm at most `1/5`, and on
`[2/5,1/2]` speed `2` does. On `[0,1/3]`, a `gamma`-good time
must satisfy `gamma<=t<=(1-gamma)/3` from speeds `1,3`. Here
`3t in (1/2,1]`, so its norm is indeed `1-3t`. The resulting interval
for `4k(t-1/4)` is exactly `[-gamma,gamma/3]`. Since its absolute
values are below one half and `4k/4` is integral, the speed `4k` is
`gamma`-good only at the left endpoint `t=gamma`.

At that endpoint speeds `1,4k` have norm `gamma`, speed `3` has norm
`(k+1)/D`, and the other speeds have norms
`1/2-(2j+1)/(2D)>=gamma`, with equality exactly at `j=k`.
Thus the global margin is `gamma` and the normalized global maximizer
is uniquely `gamma`. Periodicity and reflection extend this verification
to every real time; no numerical enumeration is used.

At `s_0=2gamma`, the author's odd lift has residuals

    e_1=(2k+1)/D,  e_3=(1-2k)/D,
    e_(4k)=-(2k+1)/D,  e_(4j+2)=(2j+1)/D.

Their maximum absolute value is `r=(2k+1)/D=1-2gamma<1`, so this
is globally closest and has the stated normalized coordinate bounds.
The minors from rows of speeds `1,3` and `1,4k` are `-2` and
`-(2k+1)`, with gcd one, proving the saturated rank-two plane.

Exactly the `k+1` valuation-one coordinates fold to zero; the retained
signed values are `(-1,1,2)`, giving the primitive positive fold `(1,2)`.
The largest zero `z=4k+2` is active positively, while `b=4k` is active
negatively with fold two. The local ceiling equals `gamma`. These are
good controls: `gamma>1/(k+5)`, so they do not instantiate strict failure.

The complete canonical `1/3`-witness set for `(1,2)` modulo one is
`{1/3,2/3}`, by the same exact two-distance intersection. The deleted
speed `6` is present and has zero distance at both times. Also the
protection radius is `(1/2-1/(k+5))/(4k+2)<1/12`; the nearer folded
witness is at distance exactly `1/12` from quarter time. Neither witness
belongs to the protected interval. This refutes selection of the fold's
own canonical time there, without assuming any shifted or rescaled reverse
transfer. It does not refute a statement using strict-failure information.

## Remaining implication and exact receipts

The first explicit uncovered contact case is active-zero `K=2`: to use
this local route, additional global information must exclude that case,
or a witness must be constructed in other good components of the deleted
speeds. Cases with no active zero and higher `K` remain too. No reverse
invariant, smaller failing tuple, unrestricted witness or formal resolution
is established. No new approach or implementation is proposed here.

The author, joint-fold input and its review were read in full. The
rank-three input, its review and validator were fully read earlier in this
same review session and remain byte-identical. Current config, workflow,
policy and focused active state were read. The state is `research` /
`in_progress`, with explicit start authorization dated 2026-09-05 and this
exact review task active. All nine frozen bindings matched:

| File | SHA-256 |
| --- | --- |
| `research/astra-fold-zero-restoration.md` | `70bbf19a595c63f7940c02ae62b815125731131f27aeade818c9a1fa1ab3507a` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |
| `research/astra-parity-plane-joint-descent.md` | `2b9a2350701206bd4bf5af0589cb607b545afe5a96258239a5ad77a031f58472` |
| `research/astra-parity-plane-joint-review.md` | `eafc2a8545ffe8ab2eae1014be5c40ddb8b955723658e3bf0aeb00fc9a497e88` |
| `research/astra-parity-rank-three-transport.md` | `7dd4d626a3efb1d2b8061261a9b286240f5207ac8655827079a0f887ef3a5048` |
| `research/astra-parity-rank-three-review.md` | `9051141c4e70f62b8192e01dc00d82c97849ba6c2fda0aca936cfcedcaa95140` |

Actual command in `/home/joshua/lonely-runner-formalization`:

    python3 -B scripts/validate_workflow.py

Exit status `0`; complete output:

    workflow structural validation passed; it cannot certify mathematical validity.

The mathematical verification is the exact hand derivation above. Final
administrative readback checks all nine bindings, the earlier two frozen
reviews, final newline and trailing whitespace, then reports this review's
SHA separately. No mathematical or command errors occurred. An oversized
combined administrative-file display was truncated; those unchanged files
had already been fully read in this session. No mathematical program,
search, solver, Lean/cache/dependency operation, external/browser model,
extra agent, Git/shared-state write or other-file edit was used. No owned
process remains. Requested route is Astra/xhigh; observed model, effort,
elapsed time and per-task usage remain null.
