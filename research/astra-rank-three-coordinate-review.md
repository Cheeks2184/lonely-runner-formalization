# Independent review of rank-three coordinate cancellation

Task `/root/coordinate_cancellation_review`; requested `gpt-6-astra` /
`xhigh`, source checkpoint `27309c7e0a0d93c8f9ce90245cec013a3ffcd5d8`.
Only this review is owned. The complete author and its six bound inputs
were read; the two mathematical inputs retain their accepted manuscript
status. Runtime-observed model, effort, elapsed time and usage are null.

**Verdict: accepted at the stated manuscript scope, without corrections.**
The exact family disproves the stated structural inference from real
cancellation to parity-admissible integer cancellation, and disproves a
positive height-independent width or depth bound from that same package.
Every example satisfies LRC. This is neither a counterexample under strict
minimal failure nor an unrestricted proof or disproof. Acceptance follows
from the hand checks below, not from the administrative validator or hashes.

## Hypotheses, quotient gauge and parity

The proposed application retains a positive distinct primitive mixed-parity
integer failure, minimal by moving count `d=N-1>=6`, then natural sum.
Its global odd-coset radius is `beta_d<r<1`, where
`beta_d=(d-1)/(d+1)`. The old nearest odd lift has
`n=s_0*v+e`, `0<s_0<1`, `||e||_infty=r`, `1<=n_i<=v_i`.
The branch assumes every coordinate of `w=v-2n` is nonzero.

The accepted predecessor supplies the full signed fold's global nearest
odd lift `m=tau*w+e'`, `0<tau<1`, and
`0<R=||e'||_infty<=beta_ell<=beta_d<r`, where `ell` counts its
positive deduplication. Global optimality, saturation and the absence of
deleted zero coordinates are essential. In particular `m` lies outside
`span(v,n)`; both nearest-point planes are saturated. In a basis `(v,n,u)`
of saturated `Gamma=span(v,n,m) intersect Z^d`, the predecessor gives

    m=A*v-n+C*u,  A even, C even,
    2<=C<R*d*(d+1)<=d*(d-1),  gcd(C,2A-1)=1,
    theta=2tau-1,  R>=r*|theta|.

The author's summary preserves this contract. In particular, the strict
index bound remains conditional on the accepted primitive short-fibre
criterion and minimal-failure supply; the factor-two normalization checked
in the bound predecessor review is retained. It is not a formal declaration.

For positive `v`, a common lift time at radius `rho>=0` exists exactly when
the finitely many intervals `[(x_i-rho)/v_i,(x_i+rho)/v_i]` intersect.
Pairwise intersection is equivalent to
`|v_j*x_i-v_i*x_j|<=rho*(v_i+v_j)`. Consequently the actual quotient
gauge is the finite maximum in author (1); attainment and the strict
version follow from this same common-interval criterion.

If an ambient odd integer vector `q` belongs to `Gamma`, then
`q-n in Gamma intersect 2Z^d=2Gamma`. Conversely every vector in
`n+2Gamma` is odd. The basis therefore gives exactly
`q=2j*v+D*n+2k*u`, with integers `j,k` and odd `D`.
The velocity component disappears from every pair numerator, yielding
author (2) for all competitors in `Gamma`. No independent coordinate
times or unproved parity choice occur here.

## Global controls and every maximizing time

For the base `(v,n,u)=((1,3,4,7),(1,3,3,5),(0,1,1,2))`, the first
three rows have determinant `1`. Thus the triple generates its full
saturated rank-three lattice. Rows `1,3` give minors `-1` for each of
`[v n]` and `[w m]`; both planes are saturated. Directly,
`w=(-1,-3,-2,-3)`, `m=(-1,-1,-1,-1)=-n+2u`, so `A=0,C=2`.

The global maximum check can be made inclusive. In `0<=t<=1/2`,
distances for speeds `1,3` at least `1/5` require

    t in [1/5,4/15] union [2/5,1/2].

Adding speed `4` leaves `{1/5} union [2/5,9/20]`, and speed `7`
leaves precisely `{1/5,2/5}`. Both times attain minimum distance `1/5`;
there is no time with a larger minimum. Periodicity and reflection give
all global maximizing ordinary times modulo one:
`1/5,2/5,3/5,4/5`. Thus `mu(v)=1/5` and `r=1-2mu(v)=3/5`.
The author's chosen `s_0=4/5` is twice ordinary time `2/5` and has
exact residual `(1/5,3/5,-1/5,-3/5)`.

For the positive folded deduplication `(1,2,3)`, distances at least `1/4`
first require `t in [1/4,3/8]` from speeds `1,2`; speed `3` leaves
only `t=1/4` in the normalized half-period. Hence all folded maximizers
modulo one are `1/4,3/4`, `mu(w)=1/4`, and `R=1/2`.
The author's doubled time `tau=1/2` has residual
`(-1/2,1/2,0,1/2)` and `theta=0`.

Append any finite set of distinct positive integers `h`, with rows

    (v_h,n_h,u_h,m_h)=(20h+1,16h+1,5h,-6h-1),
    w_h=-12h-1.

The fixed unit determinant and minors preserve both saturated planes,
the full basis and index `C=2`. The new residuals are `1/5` and `-1/2`
at the same chosen lift times. Appended original speeds also have ordinary
distances `1/5,2/5` at times `1/5,2/5`, respectively; appended folded
speeds have distance `1/4` at time `1/4`. Therefore every extension
preserves exactly the above global maximizing time sets and both radii.
No new maximizer can appear, because the base coordinates remain present.

The extended original tuple has `d>=4` moving speeds and margin `1/5`;
the folded positive deduplication has `ell=d-1` and margin `1/4`.
Both satisfy their LRC thresholds. For the original tuple `r=beta_4`
at `d=4`, and `r<beta_d` at every `d>4`. The examples in dimensions
`d>=6` still fail the essential strict-failure premise.

## Real cancellation and all odd integer competitors

All six base pair triples in the author check. Their redundant terms
reduce to

    g_v(n+a*u)=max(|a|/4,|1-a|/4,|3+a|/7,|6+a|/10).

Intersecting the four strict `3/5` bounds gives precisely `-7/5<a<0`.
The inequalities `4g>=1-a` and `10g>=6+a` give `14g>=7` for every
real `a`; at `a=-1` the actual maximum equals `1/2`. This also proves
the unique minimizing parameter, since the two affine lower bounds meet
only there. No even integer `a=2k` lies in the improving interval.

For arbitrary odd `D`, pairs `(2,4)` and `(1,4)` alone would require

    |6D+2k|<6,   |2D-4k|<24/5.

Integrality gives `|3D+k|<=2`; oddness gives
`D-2k=epsilon in {-1,1}`. Hence `|7D-epsilon|<=4`, contrary to
`|7D-epsilon|>=6` for every odd `D`. This excludes every old odd
integer competitor in `Gamma`, including every `j`. The base-pair
certificate survives all extensions. Global optimality proved above
separately excludes improvement by ambient odd vectors outside `Gamma`;
the two-pair certificate does not purport to parameterize those vectors.

## Exact width, depth and one common lift

All four base-to-appended pair triples and the appended-to-appended
triple check by direct expansion. Inside the necessary interval
`-7/5<a<0`, their numerators for base rows `1,2,3` satisfy respectively

    0<h(4-5a)<11h<3(20h+2)/5,
    0<12h+(5h+1)a<12h<3(20h+4)/5,
    |-4h-1+a|<4h+12/5<3(20h+5)/5.

For `h<l`, the remaining numerator is positive and below `11(l-h)`,
which is below `3(20(h+l)+2)/5`. Thus only row `4` can restrict
this base interval. Its numerator is negative, and its exact condition is
`a>-14/[5(5h+2)]`. If an appended row exists and `H=max h`, this proves

    g_v(n+a*u)<3/5 iff -14/[5(5H+2)]<a<0.

The endpoints are excluded: the base pair `(2,4)` is at radius `3/5`
at zero, and pair `(4,H)` is at radius `3/5` at the left endpoint.

For every real `a`, the increasing affine lower bound `(6+a)/10`
and decreasing affine lower bound
`[12H+2-(5H+2)a]/(20H+8)` intersect at

    a_*=-2/(5H+2),   G=(3H+1)/(5H+2).

Their maximum is at least `G` everywhere and strictly greater away from
`a_*`. To check attainment with one actual lift, put `K=5H+2` and
`s_*=4/5+3a_*/10`. The residuals simplify exactly to

    base: ((H+1)/K, G, -H/K, -G),
    appended h: (H+2h+1)/K.

For every `1<=h<=H`, all absolute values are at most `G`, with equality
at base rows `2,4` and appended row `H`. This proves the actual global
minimum over real `a`, with a single common time, and verifies author (5).

Consequently the width is `14/[5(5H+2)]` and the depth is
`3/5-G=1/[5(5H+2)]`. At fixed `d>=5`, keeping the other appended
indices fixed and increasing `H` preserves dimension and sends both to
zero. At `a=0` all other pair values are strictly below the unique active
value `3/5` from `(2,4)`; its slope is `1/10`. The direction toward
negative `a` is genuinely improving for each fixed tuple. The approaching
contact from `(4,H)` explains why this supplies no uniform positive width.

## Falsification status and first unresolved implication

The retained global-nearest structure, both saturated planes, `R<r`,
bounded even index and a strict real contact direction do not force an
odd integer improvement. They also do not force positive width or depth
depending only on fixed dimension and index. These auxiliary inferences
are refuted by the exact good controls.

Under the full strict minimal-failure hypotheses, the first missing
implication is still the existence of integers `k` and odd `D` satisfying
`|D*p_ij+2k*t_ij|<r*(v_i+v_j)` simultaneously for every pair, or a
proved alternative that transports failure to a genuinely smaller tuple.
This review establishes neither. First-fold zero restoration is separate;
no unrestricted conclusion or disconnected Lean implementation follows.

## Frozen bindings and actual checks

All seven SHA-256 values matched the supplied author and its input table:

| File | SHA-256 |
| --- | --- |
| `research/astra-rank-three-coordinate-cancellation.md` | `f95f4e72452cd12d775b496d8fb3d585f204d71fff608f1ba505841e96c154de` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |
| `research/astra-parity-rank-three-transport.md` | `7dd4d626a3efb1d2b8061261a9b286240f5207ac8655827079a0f887ef3a5048` |
| `research/astra-parity-rank-three-review.md` | `9051141c4e70f62b8192e01dc00d82c97849ba6c2fda0aca936cfcedcaa95140` |

The focused workflow state was `research` / `in_progress`, with explicit
start authorization dated 2026-09-05 and this exact review task active.
Actual command in `/home/joshua/lonely-runner-formalization`:

    python3 -B scripts/validate_workflow.py

Exit status `0`; complete output:

    workflow structural validation passed; it cannot certify mathematical validity.

The mathematical checks were the exact hand derivations above; no numerical
sweep, mathematical program, Lean build, dependency/cache work, external
model, browser model, extra agent, author edit, Git operation or shared-state
edit was used. The initial combined state read exceeded the output budget;
focused state extraction and separate complete file reads resolved that
display truncation. No mathematical or command error was encountered.
Final administrative readback checks frozen input hashes, final newline
and trailing whitespace, and reports this review's SHA separately. No owned
background process remains. Observed route and usage remain null; no
implementation check/repair metrics are applicable.
