# Uniform strategy after the closest-odd fold

Task `/root/uniform_strategy_after_fold`, requested Astra/xhigh; observed
model, effort and usage null. Assignment checkpoint:
`5aecd6775dd9480e3e4eaa8e8ec7fe76ebd80665`. Only this file is owned.
This is an independent strategic assessment and a proposed next contract,
not an accepted mathematical advance or a formal theorem.

**Assessment.** The recent work chiefly closes stronger shortcuts. Its
conditional index and zero-contact restrictions are real information, but
there is still no uniform mechanism carrying a smaller tuple's witness
back, or carrying failure forward. I would stop extending that descent
without a new invariant. I recommend one bounded analytic attempt at the
global slack-energy inequality (E) below. It is stronger than witness
existence, has an exact falsification test on ordinary good tuples, and
retains all labels at one actual time. Its essential global step is unproved.
This recommendation is grounds for one mathematical test, not confidence
that a new route to the conjecture has been established.

## What the accepted constraints establish

Write `d=N-1`, `alpha=1/(d+1)`, `mu(v)=max_t min_i ||v_i t||`.
For a hypothetical positive distinct primitive failure minimal by count
and then sum, `r=1-2mu(v)>beta_d=(d-1)/(d+1)`. A normalized globally
nearest odd lift `n=s_0 v+e` has `0<s_0<1`, `||e||_infty=r`, and
`1<=n_i<=v_i`. These global and strict hypotheses cannot be discarded.

* The nonzero fold `w=v-2n` has smaller absolute sum. Its actual global
  nearest odd lift is outside `span(v,n)`; in the saturated rank-three
  basis its index is even and `2<=C<R d(d+1)<=d(d-1)`. This restricts
  a possible failure. It does not bound every velocity or transport failure.
* The complete two-residual triangle envelope has minimum exactly `r`.
  Actual coordinate cancellation does not repair integer selection by
  itself: the accepted `C=2` family has a real improving interval with no
  admissible odd integer point, and width/depth tending to zero with height
  at fixed dimension. Its members satisfy LRC, so the strict-failure-only
  implication remains open.
* The harmonic fold recurrence fails for both maximizing choices of
  `(1,6,12)` with arbitrary appended speeds `198h+1`. Every count `d>=3`
  occurs, without coordinate loss. This refutes that recurrence, not LRC.
* With first-fold zeros, the actual optimum lies in a quarter cell with
  pair ceiling `mu<=b/[2(z+b)]` and `z<(d-1)b`. An active zero and opposite
  folded value two give equality and `(d-1)b/2<z<(d-1)b` under failure.
  The entire central cell then misses the target. Local restoration cannot
  be the missing step in this case.

The orchestrator's current common-centre extension reports a further
blocker involving an original speed `4g`; that draft was not frozen for
this task and is not used as accepted evidence. Even successful control
of the deleted rows and one retained row would still need a common choice
for every remaining row. This is the same quantifier that is missing from
the accepted fold arguments.

The earlier audits explain why familiar repairs are insufficient: ordinary
projection needs its actual integer fibre; the short-fibre estimate gives
only its proved range. Integral affine maps of whole contracted cubes have
the stated selector rigidity. Changing a parity basis can improve the new
global minimum despite worsening the tracked candidate. Joint deletion
maxima do not supply a new original-label seed. Exact seed lengths survive
on sharp good tuples. Ideal two-digit masks have fractional covering
optimum `N/2`, so additive nonnegative pair weights cannot prove the desired
integral exclusion. None of these is an impossibility theorem for all
global methods.

The assigned formal frontier remains unchanged: canonical six-total-runner
LRC and the real/integer and finite-height bridges are established project
inputs; uniform arbitrary-count integer witness supply is unresolved.
Another finite equivalence or a sequence of higher individual counts
would not address this gap.

## One proposed mechanism: global slack energy

Fix any `d>=2` distinct positive primitive integer speeds. No hypothetical
failure, chosen maximizing time, deleted label or fold is an input. Let

    f_i(t)=||v_i t||,     h_a(x)=(||x||-a)_+,
    I_v(a)=integral_0^1 product_i h_a(v_i t) dt,
    H_v(a)=integral_{all f_i(t)>a}
                 sum_i product_{j!=i}(f_j(t)-a) dt.

For `0<a<1/2`, differentiation under the integral gives
`I'_v(a)=-H_v(a)`. At each fixed `a` the exceptional equations `f_i(t)=a`
have finitely many solutions, and the difference quotients are bounded by
`d(1/2)^(d-1)`, justifying this derivative. The integrals retain every
overlap of the actual phase bands, rather than counting separately chosen
row witnesses. `I_v(a)>0` means an actual common time with all distances
strictly above `a`, by continuity of the nonnegative integrand.

**Proposed next lemma (E), not established:** for every such tuple and
every `0<a<alpha=1/(d+1)`,

    (alpha-a) H_v(a) <= (d+1) I_v(a).                     (E)

Equivalently, `I_v(a)/(alpha-a)^(d+1)` is nondecreasing. This is a concrete
quantitative prediction about good tuples as well as hypothetical failures;
LRC by itself does not supply this monotonicity. No equivalence in the
reverse direction is asserted.

The conditional implication to the desired theorem is complete. The
integral `I_v(0)` is positive: choose a time outside the finite set of
integer phases and then a small neighbourhood of it. Integrating (E),
or differentiating the displayed normalized energy, gives

    I_v(a) >= I_v(0) ((alpha-a)/alpha)^(d+1) > 0
                     for 0<=a<alpha.                     (1)

Thus `mu(v)>=a` for every `a<alpha`, and hence `mu(v)>=alpha`.
Equivalently, compactness of the period and continuity give a limit of
subcritical witnesses at the closed endpoint. Scaling removes the gcd
normalization, and the existing canonical bridge would apply only after
this all-count integer theorem and its proof were checked. The constant
`I_v(0)` may depend on height; no unsupported uniform interval width or
positive volume at the sharp endpoint is required.

## Local derivation and the exact first unresolved implication

Cut `[0,1]` at every actual integer phase `k/v_i`. For each resulting
closed cell `C`, the integers `k_i` are fixed and

    f_i(t)=min(v_i t-k_i, k_i+1-v_i t),
    mu_C=max_{t in C} min_i f_i(t).

Let `I_C,H_C` be the preceding integrals restricted to `C`. Cell endpoints
have measure zero. The region

    D_C(a)={(t,y):t in C, y_i>=0, y_i+a<=f_i(t) for all i}

is a convex polytope in dimension `d+1` with volume `I_C(a)`. Choose
`t_C` attaining `mu_C`. For `0<=a<b<mu_C`, the homothety about `(t_C,0)`
with ratio `lambda=(mu_C-b)/(mu_C-a)` maps `D_C(a)` into `D_C(b)`:
concavity of each `f_i` gives

    f_i(lambda t+(1-lambda)t_C)
        >= lambda(y_i+a)+(1-lambda)mu_C = lambda y_i+b.

Consequently `I_C(b)>=lambda^(d+1)I_C(a)` and

    Q_C(a):=(d+1)I_C(a)-(mu_C-a)H_C(a) >= 0.              (2)

If `a>=mu_C`, both integrals vanish, so the same conclusion holds.
This proof is elementary volume scaling, with no geometric theorem from
an unverified external source. It is a new derivation here, pending review.

Summing yields the exact identity

    (d+1)I_v(a)-(alpha-a)H_v(a)
        = sum_C [Q_C(a)+(mu_C-alpha)H_C(a)].              (3)

**The first unresolved implication is that (3) is nonnegative for the
actual integer-speed cell system, uniformly in `d` and `a<alpha`.**
Local convexity only gives `Q_C>=0`. Cells with `mu_C<alpha` make the
second summand negative; an argument must control their total contribution
using compatibility across all cells. No such control is proved here.
The integer phase equations and their common period are essential data;
replacing the cells by arbitrary independently positioned polytopes loses
the premise on which any proposed compensation must depend.

This explains why (E) is more than a new expression for positivity: it
requires an explicit bound on the rate at which the full simultaneous
slack disappears as the threshold increases. It also identifies exactly
where the easy local volume proof stops. There is no recommendation to
formalize that local calculation without a global caller.

Two exact hand checks calibrate the target. For `v=(1,2)` and
`1/4<=a<1/3`, reflection leaves the interval
`[a,(1-a)/2]` and its reflected copy, giving

    I_v(a)=2 integral_a^((1-a)/2) (t-a)(1-2t-a) dt
          =(1-3a)^3/12 = (9/4)(1/3-a)^3.

Thus (E) is equality throughout this interval; an exponent smaller than
`d+1` in this same monotonicity would fail. Conversely, cellwise replacement
of `mu_C` by `alpha` is false. For `v=(1,2,3)`, the cell `[1/3,1/2]`
has peak `mu_C=1/5` at `2/5`, below `alpha=1/4`. Its integral is positive
below `1/5` and zero at `1/5`. A cellwise version of (1) would force it
to remain positive there. These controls support the exponent and expose
the necessary global coupling; they do not verify (E) in general.

An optional exact encoding of the same global object retains all integer
relations. Put `L=1/2-a`, `q_0=L^2`, and
`q_k=(sin(pi k L)/(pi k))^2` for nonzero integer `k`. The tent `h_a` is
the convolution of two centred length-`L` interval indicators, translated
by `1/2`. Its Fourier coefficients are `(-1)^k q_k`; hence

    I_v(a)=sum_{k in Z^d, sum_i v_i k_i=0}
                     (-1)^(sum_i k_i) product_i q_(k_i). (4)

The series is absolutely convergent since `q_k=O(k^-2)`. Formula (4) is
a signed multilinear relation sum, outside the exact fixed-sign
single-polynomial certificate classes screened earlier. Their barriers
therefore do not establish a barrier to (E). No derivative of this series,
resonance estimate, sign-pairing theorem or new Fourier inequality is
assumed; (3) remains the first required global estimate.

## Falsification and stopping rule for the next bounded task

The next task should prove or refute (E), first attacking the contribution
of cells below `alpha` in (3). A single ordinary good tuple and rational
`0<a<alpha` with negative defect in (3) refutes the proposed monotonicity;
no LRC failure is needed. For rational data the integrals are exactly
piecewise polynomial and can be evaluated by hand on their actual cells.
An explicit parameter family with this negative defect is equally decisive.

If such a control refutes (E), preserve that exact scope and abandon this
specific monotonicity. Do not quietly weaken it to `I_v(a)>0`, which merely
returns the original supply obligation. If it survives elementary checks,
the next deliverable must be a proved global compensation estimate using
the compatible phase labels, not more individual counts, a finite
equivalence, a numerical positivity table, or additional local cell lemmas.
No falsifier to (E) was obtained in this assessment; no sweep was run.

## Evidence and administrative receipt

Current config, workflow, policy and focused state were read. The gate was
`research / in_progress` with recorded explicit start authorization. The
memory quick pass found no relevant project memory. Oversized combined
reads were replaced by focused/separate reads for the assigned mathematics.
The eight main fold author/review files were read in full. Historical
audits were read at the scopes used above. Actual readback SHA-256 values:

| Input under `research/` unless stated otherwise | SHA-256 |
| --- | --- |
| `astra-parity-rank-three-transport.md` | `7dd4d626a3efb1d2b8061261a9b286240f5207ac8655827079a0f887ef3a5048` |
| `astra-parity-rank-three-review.md` | `9051141c4e70f62b8192e01dc00d82c97849ba6c2fda0aca936cfcedcaa95140` |
| `astra-rank-three-coordinate-cancellation.md` | `f95f4e72452cd12d775b496d8fb3d585f204d71fff608f1ba505841e96c154de` |
| `astra-rank-three-coordinate-review.md` | `9d53e7f9426a9ae828462e66f045a35ef39580b519bf3910ac3070d484d0b258` |
| `astra-harmonic-fold-obstruction.md` | `a5037d4b8f33d493b26ee1a7854bd654d7ea373e500c364cad10070954e2ca9a` |
| `astra-harmonic-fold-obstruction-review.md` | `a29f8ca92677cf175cf2567ecaf978e3234b5e0e9a5049dd4fe93f1929bbdb36` |
| `astra-fold-zero-restoration.md` | `70bbf19a595c63f7940c02ae62b815125731131f27aeade818c9a1fa1ab3507a` |
| `astra-fold-zero-restoration-review.md` | `559deadd612ca99a4ebc99d8fba104f2e5243ae412785d3572b70633af7ac59e` |
| `astra-center-preserving-projection-audit.md` | `0efe2d8bfb272f194249e6201491a64165d6a102900a71c8953618253f18c60e` |
| `astra-parity-coset-minimum-audit.md` | `b5dd0bbc3ef5d27a986a47b144e225637e338d81c6abceedc2d05d37d392a942` |
| `astra-joint-seed-maximum-audit.md` | `ac73e29474e272167403c91db34331236bb3832f7ce916b2997d7c2f0d6b46ac` |
| `astra-ideal-row-carry-exclusion.md` | `689c3255596a4fb9dfc8935d0bf6ac40775415e1782dc7c09ccbfdb3b30df286` |
| `astra-uniform-seed-coupling.md` | `b52f92b8dca3de5b0ba9f41c24c2dc6bd83a27329a035d40a1273a0401f215ea` |
| `astra-uniform-global-seed-geometry.md` | `3a4a825f3f801282eb39b469571bbd4cac3a4e1f768d58542b7c1555cd725524` |
| `astra-fourier-lp-source-contract.md` | `cf3ea5b08fbaee07e56b34d295632f7c67a35cc80679055a74725b0596b96043` |
| `astra-uniform-fourier-upper-barrier.md` | `d3ba7474730fb2c17ba5118ee9753367336673eb175bf00080493e7e74a37bb1` |
| `.codex/config.toml` (repository root) | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` (repository root) | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` (repository root) | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Actual command `python3 -B scripts/validate_workflow.py` exited 0 with:

    workflow structural validation passed; it cannot certify mathematical validity.

The new calculations above are manuscript derivations, not independently
accepted results. No mathematical program, numerical sweep, solver,
Lean/build/cache/dependency action, browser model, external agent, extra
agent, Git mutation or shared-state write was used. Final readback checks
the owned file's newline/whitespace and hash. No owned process remains.
No unrestricted proof/disproof or finite-family supply has been established.
