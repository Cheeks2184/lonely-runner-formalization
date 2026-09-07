# Rank-three coordinate cancellation: exact arithmetic obstruction

Recovered task `/root/rank_three_coordinate_cancellation`, author handle
`/root/rank_three_coordinate_resume`, requested Astra/xhigh. Recovery assignment
checkpoint: `fddfa9b202967e8b8c58f864e5c38aecbc36622a`. The focused state retains
the inherited task source `93cdc554c4b15337aa6aa29450e88e7a628251d5` and records
this replacement handle. Only this manuscript is owned. Root supplied the
preserved base example and its all-dimension extension; their complete exact
derivations are recovered below, with an additional height-dependent width
calculation. This is an author manuscript awaiting independent review.

**Result.** Actual coordinate cancellation can exist in a real interval while
every admissible old odd lattice point fails to improve. A uniform family has
both saturated nearest-point planes and rank-three index `C=2`; at every fixed
dimension `d>=5`, the real improvement interval and its depth tend to zero as
one velocity tends to infinity. Thus bounded index and a strict contact
direction do not by themselves justify an integer step or a height-independent
rounding margin. All examples satisfy LRC. No implication under strict minimal
failure is refuted or proved, and no preserved failure is supplied.

## Target hypotheses and the exact coordinate test

The target remains a hypothetical positive distinct integer failure, minimal
by moving count `d=N-1>=6` and then by natural sum. It is primitive and mixed
parity. Use

    beta_d=(d-1)/(d+1),
    r=min_(q odd, s real) ||q-s*v||_infty > beta_d,
    n=s_0*v+e,  0<s_0<1,  ||e||_infty=r,  1<=n_i<=v_i.

Assume the first fold `w=v-2n` has no zero coordinate. The accepted predecessor
uses count/sum minimality on its positive deduplication, of count `ell<=d`, to
supply a global nearest odd lift

    m=tau*w+e',  0<tau<1,
    R=||e'||_infty<=beta_ell<=beta_d<r.

It proves that `m` is outside `P=span_R(v,n)`, that both `Zv+Zn` and `Zw+Zm`
are saturated, and that the saturated rank-three lattice
`Gamma=span_R(v,n,m) intersect Z^d` has a basis `(v,n,u)` with

    m=A*v-n+C*u,   A even,   C even,
    2<=C<R*d*(d+1)<=d*(d-1),   gcd(C,2A-1)=1,
    theta=2tau-1,   R>=r*|theta|.

These are conditional manuscript inputs, not new formal declarations. The
first-fold zero case is outside this task.

For positive `v`, define the actual quotient gauge

    g_v(x)=min_(s real) max_i |x_i-s*v_i|.

The closed intervals `[(x_i-rho)/v_i,(x_i+rho)/v_i]` have common intersection
exactly when every pair intersects. Consequently

    g_v(x)=max_(i<j) |v_j*x_i-v_i*x_j|/(v_i+v_j).           (1)

This also handles strict improvement: a finite maximum below `rho` supplies
a smaller closed radius and hence one common real time. No coordinate gets
an independently chosen time.

Saturation and oddness give every old odd point in `Gamma` as

    q=2j*v+D*n+2k*u,   j,k integers,   D odd.

Put `p_ij=v_j*n_i-v_i*n_j` and `t_ij=v_j*u_i-v_i*u_j`. Then

    g_v(q)=max_(i<j) |D*p_ij+2k*t_ij|/(v_i+v_j).            (2)

Thus the sought contradiction requires one integer `k` and odd `D` with
every numerator in (2) strictly below `r*(v_i+v_j)`. The accepted scalar
triangle envelope has minimum exactly `r`; here the complete coordinate
test (2) is retained instead.

## Exact control: genuine nearest lifts and both saturated planes

Take four moving coordinates

    v=(1,3,4,7),   n=(1,3,3,5),   u=(0,1,1,2),
    w=(-1,-3,-2,-3),   m=(-1,-1,-1,-1)=-n+2u.

The original vector is positive, distinct, primitive and mixed parity, and
the fold has no zero. Rows 1,2,3 of `[v n u]` have determinant `1`, so this
triple is a basis of its saturated rank-three lattice. The `(v,n)` minor
on rows 1,3 has absolute value `1`; the `(w,m)` minor on those rows is `-1`.
Both nearest-point planes are therefore saturated. In particular `m` is
outside `span(v,n)`, and the normalized coefficients are `A=0,C=2`.

At `s_0=4/5`,

    n-s_0*v=(1/5,3/5,-1/5,-3/5).

This is globally nearest, not merely a locally minimizing lift. To check it,
write `mu(v)=max_t min_i ||t*v_i||_(R/Z)`, so the odd-coset radius is
`r=1-2mu(v)` with lift parameter `s=2t`. Periodicity and reflection reduce
the upper bound to `0<=t<=1/2`. If the speeds `1,3` both have distance
strictly above `1/5`, then

    t in (1/5,4/15) union (2/5,1/2].

Speed `4` excludes the first interval and restricts the second to
`(2/5,9/20)`. There `7t` lies in `(14/5,63/20)`, at distance strictly below
`1/5` from an integer. Thus `mu(v)<=1/5`. At `t=2/5` the four distances
are `(2/5,1/5,2/5,1/5)`, giving

    mu(v)=1/5,   r=3/5.

The positive folded deduplication is `(1,2,3)`. Its value is `1/4`: the
time `1/4` attains it; if all three distances exceeded `1/4` in `[0,1/2]`,
speeds `1,2` would force `1/4<t<3/8`, where speed `3` has distance below
`1/4`. At `tau=1/2`,

    m-tau*w=(-1/2,1/2,0,1/2),
    R=1/2<r,   theta=0.

All displayed bounds on signs, normalized times and coordinate magnitudes
hold. Here the original total count is `N=5` and `r=beta_4`: this is a
sharp good tuple, not a strict failure.

## Real improvement, but no old odd lattice improvement

For the base tuple, the six triples `(p_ij,t_ij,v_i+v_j)` are

    (1,2): (0,-1,4)     (1,3): (1,-1,5)
    (1,4): (2,-2,8)     (2,3): (3,1,7)
    (2,4): (6,1,10)     (3,4): (1,-1,11).

Consequently, for every real `a`,

    g_v(n+a*u)=max(|a|/4, |1-a|/4, |3+a|/7, |6+a|/10).

Intersecting these four strict inequalities gives exactly

    g_v(n+a*u)<3/5  iff  -7/5<a<0.                         (3)

Its minimum is `1/2`, attained at `a=-1`. Indeed the two inequalities
`4g>=1-a` and `10g>=6+a` imply `14g>=7`, and the displayed maximum at
`a=-1` is `1/2`. No allowed coefficient `a=2k` belongs to (3).

Changing the odd coefficient `D` does not evade the obstruction. A putative
`g_v(D*n+2k*u)<3/5` would satisfy just from pairs `(2,4)` and `(1,4)`

    |6D+2k|<6,   |2D-4k|<24/5.

The first implies the integer bound `|3D+k|<=2`. In the second,
`D-2k` is odd and has absolute value below `12/5`, hence
`D-2k=epsilon` for `epsilon in {-1,1}`. Substitution gives

    |7D-epsilon|<=4.

But odd `D` is nonzero, so `|7D-epsilon|>=6`, a contradiction. This is an
exact certificate excluding every `j,k,D` in (2), not a finite search.

## Uniform extension and shrinking width at fixed dimension

Append any finite set of distinct positive integers `h` as rows

    (v_h,n_h,u_h,m_h)=(20h+1,16h+1,5h,-6h-1),
    w_h=-12h-1.

The original speeds remain positive and distinct. The same determinant and
two unit minors in the first rows preserve both saturated planes, the basis,
and `A=0,C=2`. At the same times the new residuals are

    n_h-(4/5)v_h=1/5,   m_h-(1/2)w_h=-1/2.

The base coordinates give the converse global bounds, so for every such
extension

    r=3/5,   R=1/2,   mu(v)=1/5,   mu(w)=1/4.

The two-pair integer obstruction above also survives unchanged. This gives
all moving dimensions `d>=4`. For `d>4`, `r<beta_d`, so every higher
extension is again good; none satisfies the target strict-failure premise.

Let at least one row be appended and put `H=max h`. For the pair joining
base row `i` to row `h`, the triples in (1) are

    i=1: (4h,-5h,20h+2)       i=2: (12h,5h+1,20h+4)
    i=3: (-4h-1,1,20h+5)      i=4: (-12h-2,5h+2,20h+8).

Between two appended rows `h<l`, they are

    (4(l-h),-5(l-h),20(h+l)+2).

Within the necessary base interval `-7/5<a<0`, the strict inequalities
from rows `1,2,3` and from two appended rows hold automatically. For row
`4` against `h`, the numerator is negative and its inequality is exactly

    a>-14/[5(5h+2)].

The most restrictive row is `H`. Thus the full actual gauge satisfies

    g_v(n+a*u)<3/5  iff  -14/[5(5H+2)]<a<0.                (4)

For completeness, the exact minimum and its time can also be recovered:

    a_*=-2/(5H+2),
    min_a g_v(n+a*u)=(3H+1)/(5H+2),
    s_*=4/5+3a_*/10.                                     (5)

For the lower bound at any real `a`, the signed expressions of pairs
`(2,4)` and `(4,H)` yield

    g >= (6+a)/10,
    g >= [12H+2-(5H+2)a]/(20H+8).

These increasing and decreasing affine functions meet at `a_*` and the
value in (5); their maximum is everywhere at least that value. At `s_*`
the residuals in the first four coordinates are

    (1/5-3a_*/10, 3/5+a_*/10, -1/5-a_*/5, -3/5-a_*/10),

and the appended residual is `1/5-(h+3/10)a_*`. Their maximum absolute
value is the value in (5), attained at base rows `2,4` and row `H`.
This proves the upper bound using a single common time.

At every fixed `d>=5`, keep the other appended rows fixed and send `H` to
infinity. The interval width in (4) is `14/[5(5H+2)]` and the improvement
depth is

    3/5-(3H+1)/(5H+2)=1/[5(5H+2)].

Both tend to zero while `C=2` and both global radii stay fixed. At `a=0`
the unique active pair remains `(2,4)`, with positive slope `1/10`;
there is always a strict improving direction toward negative `a`. The
height-sensitive obstruction comes from another pair approaching contact,
so strict first-order contact information alone supplies no uniform width.

## First unresolved implication and branch disposition

The refuted auxiliary inference is that the displayed global nearest-point
structure, both saturated planes, `R<r`, bounded even index and a real
improving contact direction force an admissible old odd integer improvement,
or a positive width/depth bound depending only on the fixed count and index.
The exact examples satisfy that retained structural package but not
`r>beta_d` or minimality as a failure.

The first unresolved implication remains: **under the full strict minimal
failure hypotheses**, show that the open coordinate region

    |D*p_ij+2k*t_ij|<r*(v_i+v_j)  for every i<j

contains an integer pair `(D,k)` with odd `D`, or derive a genuinely smaller
failing tuple by an explicitly proved alternative invariant. The current
branch yields neither. In particular, the good control family cannot refute
such a strict-failure-only theorem, and real interpolation cannot replace
the missing parity-constrained integer selection. The two-pair obstruction
also survives all extensions, so treating additional dimension alone as a
source of integer cancellation would discard actual coordinate constraints.

This completes one analytic coordinate-cancellation attempt. No uniform
witness, preserved failure, or unrestricted LRC resolution is claimed. The
remaining problem is not relabeled as a finite equivalence or proposed for
a runner-count ladder. No Lean implementation follows from this obstruction.

## Input bindings and administrative checks

The current config, workflow, policy and focused state were read. The state
was `research` / `in_progress`, with explicit start authorization recorded
on 2026-09-05; the setup gate therefore permitted this bounded task. The
complete accepted rank-three author and review were read. Input SHA-256:

| Input | SHA-256 |
| --- | --- |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |
| `research/astra-parity-rank-three-transport.md` | `7dd4d626a3efb1d2b8061261a9b286240f5207ac8655827079a0f887ef3a5048` |
| `research/astra-parity-rank-three-review.md` | `9051141c4e70f62b8192e01dc00d82c97849ba6c2fda0aca936cfcedcaa95140` |

Actual command in `/home/joshua/lonely-runner-formalization`:

    python3 -B scripts/validate_workflow.py

Exit status `0`; full output:

    workflow structural validation passed; it cannot certify mathematical validity.

The mathematical reproduction is the displayed exact hand derivation.
Final readback checks the six input hashes, owned-file final newline and
trailing whitespace, and reports the owned-file SHA-256. There was no
mathematical program, numerical search, solver, browser model, Lean check,
dependency/cache operation, Git mutation, shared-state edit, predecessor edit
or extra agent. No owned background process remains. Runtime-observed model,
effort, worker elapsed time and per-task token usage are unexposed and null;
implementation check/repair metrics are not applicable and null.
