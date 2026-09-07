# Joint parity-plane descent: the smaller fold and missing transport

Task `/root/parity_plane_joint_descent`, requested Astra/xhigh in the
established `/root/uniform_affine_phase_screen` session. Assignment source:
`4818e5916e57697f83e842ca642f4e7599bbd32c`, with the frozen predecessor
bound below. Only this manuscript is owned. The current project config,
workflow, policy and focused state were read; workflow validation passed.

**Result.** A normalized globally closest odd lift gives an actual strict
speed-sum decrease by the fold `w=v-2n`. If the fold has no zero entries,
count/sum minimality supplies a smaller-tuple witness, and strict original
failure forces every such witness's odd lift outside `span(v,n)`. If there
are zero entries, deleting them supplies a smaller positive tuple but
changes the relevant odd coset: the full folded residual minimum is exactly
one. The exact ray-distance identity below retains all competitors and
exposes the common-time constraint in both cases. These statements do not
transport a witness back or produce a smaller counterexample.

This is one analytic branch. Root proposed the ray identity and fractional
candidate formula; this audit checks them and derives the fold and
outside-plane conclusions. No numerical search or mathematical program was
used, and the frozen predecessor was not edited.

## Ordinary normalization and the exact ray identity

Assume an ordinary positive distinct integer failure has least moving count
`d=N-1>=6`, then least natural sum `H=sum_i v_i`. Its velocity `v` is
primitive and has both odd and even coordinates; the all-odd primitive
case has the witness `1/2`. Put

    beta_d=(d-1)/(d+1),    r=1-2*max_t min_i ||t*v_i||.

Full closed-margin failure is `r>beta_d`, and `r<1`. As in the accepted
predecessor, choose an odd integer vector `n` attaining this global
minimum. Use the doubled-cube normalization throughout this report:

    E=R^d/Rv,       U:R^d->E,       Lambda=U(Z^d),
    B_0=U([-1,1]^d),               C=U(1_d+2Z^d),
    y=U(n),        ||y||_(B_0)=dist(0,C)=r.

Thus `y` is the predecessor's `2x`, with the cube also doubled; `r`
has not changed. The accepted global-minimum argument gives

    P=span_R(v,n),     P intersect Z^d=Zv+Zn.                (1)

In particular this rank-two lattice is saturated in the actual ambient
integer lattice. No finite competitor set replaces `C`.

**Exact ray lemma.** For every real `s`,

    dist(s*y,C)=r*dist(s,2Z+1),                              (2)

where distance on the left uses `B_0` and distance on the right is ordinary
absolute distance to the odd integers. For `|s|<=1`, reverse triangle
gives `||z-s*y||>=r-|s|r` for every `z in C`. Equality is attained at
`z=y` when `s>=0` and at `z=-y` when `s<=0`. Also `C+2y=C`, because
`2y in 2Lambda`; this makes the left side periodic with period two in
`s`. The right side has the same period, proving (2), including `s=0`
and the odd endpoints. This proof is valid for the specified central coset;
it does not give an arbitrary shifted LRC bound.

Define the actual two-parameter residual

    F(t,s)=min_(m in (2Z+1)^d) ||m-t*v-s*n||_infty.

The coordinate version of (2) is exactly

    min_t F(t,s)=r*dist(s,2Z+1).                             (3)

The common lift parameter `t` is optimized freely here. The minimum is
attained. For `s in [-1,1]`, writing `n=s_0*v+e` with
`||e||_infty=r`, equality is exhibited by `m=epsilon*n` and
`t=(epsilon-s)*s_0`, where `epsilon` is the sign chosen in the proof of
(2). Periodicity extends it to all `s`. Thus (3) is an equality, not a
loose triangle estimate that can be improved without using more information.

## A nearest lift always supplies a strict fold decrease

Choose an ordinary maximizing time and use integer periodicity and
reflection to put it at `t_* in (0,1/2)`. Neither endpoint is possible:
the zero time has minimum norm zero, and at `1/2` any even speed does too,
whereas the maximum is positive. Set

    s_0=2*t_* in (0,1),    n=s_0*v+e,
    n_i odd,              ||e||_infty=r<1.                 (4)

This is a choice of a globally closest odd lift, not an assumption about
an arbitrary unnormalized representative. For every coordinate,

    -1<n_i<v_i+1,   hence   1<=n_i<=v_i.

The strict first inequalities use `0<s_0*v_i<v_i` and `|e_i|<1`.
Odd integrality supplies the lower bound one; integrality supplies the
upper bound `v_i`.

Now define

    w=v-2n,    Z={i:w_i=0}.

Then

    |w_i|<=v_i for all i,        sum_i |w_i|<H.              (5)

Indeed `0<n_i<=v_i` gives the weak coordinate bound. At any even speed,
oddness forces `1<=n_i<=v_i-1`, giving a strict bound. Mixed parity
ensures at least one such speed. The coefficient vector `(1,-2)` is
primitive in the saturated plane (1), so `w` is a primitive nonzero
ambient integer vector. It has the required parity `w=v mod 2`.

Let `V` be the set of distinct positive values `|w_i|` with zeros removed,
and let `m=|V|`. It is nonempty, primitive, has `m<=d`, and its sum is
strictly below `H` by (5). Count minimality when `m<d`, or sum minimality
when `m=d`, therefore supplies an ordinary witness for `V` at its own
closed margin `1/(m+1)`. This is an actual smaller positive tuple, including
the possible deletion and duplicate cases. It is not a smaller failure.

When `Z` is empty, signs and repeated absolute coordinates preserve the
full residual optimization. Hence this witness lifts, with its single
doubled ordinary time `tau`, to an odd vector `m' in Z^d` satisfying

    ||m'-tau*w||_infty <= beta_m=(m-1)/(m+1)<=beta_d<r.       (6)

Different duplicate coordinates may be filled with the same representative
after their sign changes. No independent phase times are introduced.

### Under strict failure every such lifted witness leaves the plane

For a nonzero-coordinate signed speed vector `w`, let

    G_w(z)=min_tau ||z-tau*w||_infty.

Its exact gauge formula, after simultaneous coordinate sign changes, is

    G_w(z)=max_(i<j) |w_j*z_i-w_i*z_j|/(|w_i|+|w_j|).

By (1), an integer vector in `P` has unique integer coefficients in
`v,n`. Such a vector is odd in every coordinate exactly when it is
`2c*v+D*n`, with `c integer` and `D odd`: an even coordinate of `v`
forces the coefficient of `n` odd, and an odd coordinate of `v` then
forces the coefficient of `v` even. Modulo `Rw`, these vectors become

    2c*v+D*n = 2c*w+(4c+D)*n.

Since `4c+D` ranges over odd integers, homogeneity gives the exact
restricted minimum

    min_(z in P intersect (2Z+1)^d) G_w(z)
      =G_w(n)
      =max_(i<j) |v_j*n_i-v_i*n_j|/(|w_i|+|w_j|)
      >=max_(i<j) |v_j*n_i-v_i*n_j|/(v_i+v_j)
      =r.                                                  (7)

The inequality uses (5), with all displayed denominators positive because
`Z` is empty. Thus **every** vector `m'` in (6) lies outside the real
plane `P`. This is a strict-failure consequence for an actually smaller
fold, stronger than observing growth of one candidate. The minimum in
(7) deliberately ranges over *all* odd competitors in the plane; the
ambient minimum still includes the additional competitors needed by (6).

This does not establish iterative rank growth. A supplied `m'` need not
be globally closest for the original `v`, and the smaller tuple `V` is
good. No failure invariant is retained for applying a new failure-only
step to `V`, or for repeatedly declaring independent new directions.

### Zero coordinates require a separate restoration argument

For `i in Z`, the relation `v_i=2n_i` forces `v_i=2 mod 4`. At every
real `tau` and for every full odd vector `m'`,

    |m'_i-tau*w_i|=|m'_i|>=1.

Consequently the raw folded residual minimum is exactly one: the lower
bound is attained globally at `tau=0` with all coordinates of `m'`
equal to one. The smaller positive tuple obtained by deleting zeros has
a different optimization and can satisfy its own margin. Its witness
cannot be inserted into (6) on all original coordinates.

In terms of (3), this exposes the lift-parameter mismatch quantitatively:

    F(tau,-2tau)>=1,
    min_t F(t,-2tau)=r*dist(-2tau,2Z+1)<=r<1.                (8)

Thus along this tied direction the full residual never attains the
projected minimum, at any time. Deleting a zero is a legitimate way to
form a smaller positive tuple, but not a preservation of the original
odd-coset witness problem.

There is a useful location fact, suggested by root, without a restoration
theorem. At original ordinary time `1/4`, every coordinate in `Z` is
exactly half-integral and every odd speed has norm `1/4`; only multiples
of four can be bad. The zero coordinates remain `1/N`-good when
`|t-1/4|<=(1/2-1/N)/max_(i in Z) v_i`. Large zero speeds can make this
interval small, and no common correction of the remaining multiples of
four inside it has been established. A lower-tuple witness need not lie
in this interval.

## What joint minimality says, with the times still tied

For all parity-preserving primitive directions

    w_(a,b)=a*v+2b*n,    a odd,    gcd(a,2b)=1,

consider those with no zero entries whose positive deduplication has
smaller count or the same count and smaller sum. Joint count/sum
minimality supplies, for **each** such direction, some real `tau` with

    F(a*tau,2b*tau)<=beta_m.                                (9)

Normalization by a common integer factor would only rescale `tau`;
saturation and the displayed gcd already make the raw vector primitive.
The exact projection (3) forces every supplied time to obey

    dist(2b*tau,2Z+1)<=beta_m/r,
    ||b*tau|| >= (1-beta_m/r)/2 > 0.                        (10)

The inequalities are closed at their boundaries. For nonzero `b`, these
allowed phase bands are nonempty. In particular, passing from one direction
to all smaller directions does not change the quantifiers in (9) to a
common time or a freely selectable phase. To recover an old witness by
an integral subtraction of `n`, the second coordinate must be even
integral; (10) excludes exactly that at every supplied witness under the
hypothetical failure. A different transport might use additional residual
information, but no such jointly forced choice was derived.

The proposed fractional expression respects the same distinction. If

    n'=2c*v+D*n,     D odd,
    A=a+2b*s_0 != 0,
    tau=(2c+D*s_0)/A,

then direct substitution into (4) gives

    n'-tau*w_(a,b) = [(aD-4bc)/A]*e.                        (11)

For determinant `aD-4bc=+/-1` this bounds the candidate residual by
`r/|A|`. It is a particular valid common time, but gives only an upper
bound for the candidate's gauge and hence the new global minimum. If
`A=0`, the formula is undefined and no conclusion is drawn from it.
Formula (11) does not control the outside-plane competitors required by
(7), and increasing its value does not preserve failure. The predecessor's
exact family already refutes that latter inference without the extra
strict-failure premise; it has not been replayed or expanded here.

## Disposition and exact receipts

This branch obtains the genuine smaller-fold lemma (5) and the conditional
outside-plane necessity (7). The ray identity (2)--(3) and fractional
formula (11) are exact, but neither supplies a successful lift. The joint
minimality attempt stops at two precise gaps: restore the deleted zero
coordinates, or transport one of the necessarily outside-plane witnesses
for a nonzero fold. No retained invariant forces either operation from
strict failure. The full uniform inequality `r<=beta_d` and the existence
of a smaller failing tuple remain unproved. This bounded branch is exhausted
at that transport obligation; it does not end the unrestricted project.

There is no proposed disconnected Lean implementation, count ladder,
arbitrary-phase theorem, or new search. All statements retain stationary
zero and the closed canonical margin. The complete predecessor and its
accepted review were read, alongside the existing projection contracts.
Current input bindings are:

| Input | SHA-256 |
| --- | --- |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |
| `research/astra-parity-coset-minimum-audit.md` | `b5dd0bbc3ef5d27a986a47b144e225637e338d81c6abceedc2d05d37d392a942` |
| `research/astra-parity-coset-minimum-review.md` | `fda600dd2cdbf2f470bc18e24baeab0bb4b9a90616f34b10d160ba3fa86b3360` |
| `research/astra-center-preserving-projection-audit.md` | `0efe2d8bfb272f194249e6201491a64165d6a102900a71c8953618253f18c60e` |
| `research/astra-center-preserving-projection-review.md` | `a1402e6545dd2de6a2d4b2f832b2ff13ec52f759a1ae5fb183122d1ad3d0c7e6` |

Actual check in `/home/joshua/lonely-runner-formalization`:

    python3 -B scripts/validate_workflow.py

Exit status 0; full raw output:

    workflow structural validation passed; it cannot certify mathematical validity.

The displayed proofs are the complete mathematical reproduction. Input
readback used `sha256sum`; the final handoff checks all eight bindings,
the owned file's final newline and trailing whitespace, and reports its
SHA-256. These are administrative checks, not mathematical programs.
No numerical search, solver, Lean invocation, dependency/cache work,
Git/shared-state mutation, extra agent or external mathematical source
was used. No owned process remains, and no `.lake` or dependency source
is required by this task. Observed runtime model/effort, elapsed time and
token usage are unavailable and remain null.
