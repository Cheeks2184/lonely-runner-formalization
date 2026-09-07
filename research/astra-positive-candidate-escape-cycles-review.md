# Independent review of positive-candidate escape cycles

Task `/root/positive_candidate_escape_cycles_review`; reviewer session
`/root/coordinate_cancellation_review`; assigned checkpoint
`2dca882840ede6444cca50aeda81c72f283de1c4`. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed time and usage: `null`.
Only this review is owned.

**Accept the complete frozen manuscript below without correction.** Its
whole-deletion-set phase representative, compatible carry identities and
stronger-seed partition are valid at their stated hypotheses. The exact
control defeats two weaker shortcuts, while lacking the global trapping
and strict-failure hypotheses needed for the intended contradiction.
The inherited repair depth is not new supply. No kernel theorem or
unrestricted LRC proof or disproof is established.

## Exact domain and phase representative

Assume a hypothetical strict failure V of n>=3 distinct positive primitive
integer speeds, minimal first by moving count and then primitive sum.
Write N=n+1, alpha=1/N, beta=1/n, m=max V, S=V\{m}, Q=max S, and let
`0<mu=max_t min_(v in V)||vt||<alpha` be the actual global maximum.
Retain the entire closed set W where every speed in S is alpha-good.
Least count supplies a beta-witness and hence an interval in W.

The accepted contraction on every point of W gives
`|mt-k(t)|<=mu_m=mu-m(alpha-mu)/Q<mu<alpha`. Its radius is positive:
otherwise W modulo one would be confined to finitely many collision centers,
contradicting that interval. Since alpha<=1/4, k(t) is unique. Its residues
form the full finite K; W_k includes every point assigned that residue,
with closed endpoints and any additional singleton components retained.
Under these hypotheses every W_k lies inside its actual open m-alpha arc.

For any fixed distinct a,b in S and any real lift t in W, put
`J_v=floor(vt)`, `f_v=vt-J_v`, `e=mt-k(t)` and
`H=J_a+J_b+1-k(t)`. Then the exact identity is

`z=(a+b-m)t-H=f_a+f_b-1-e`.

Each retained fractional part belongs to the closed interval
[alpha,1-alpha], so `|z|<=1-2alpha+mu_m<1-alpha`. As z represents the
same circle phase as (a+b-m)t, this proves

`||(a+b-m)t||>=alpha` if and only if `|z|>=alpha`.

Indeed |z|<alpha is strictly bad; if alpha<=|z|<1-alpha, both distances
|z| and 1-|z| are at least alpha. This explicitly handles representatives
beyond 1/2 and excludes a missed good/bad change near either adjacent
integer. The equivalence includes equality at alpha and holds on ALL W.

At a source collision, let the original left/right endpoint arcs have
labels a,b<m and compatible numerator lifts l,r. The inherited endpoint
geometry gives `x=at-l>=alpha`, `y=r-bt>=alpha`, with
`x<alpha+(a/m)(alpha+e)<3alpha` and
`y<alpha+(b/m)(alpha-e)<3alpha`. Since 3alpha<=3/4<1,
`J_a=l`, `J_b=r-1`. Thus H=l+r-k and this global representative agrees
with the inherited cancellation representative on the entire source
portion, even at closed private endpoints. That cancellation gives

`|z|<alpha-delta_(a,b)`,
`delta_(a,b)=(1-max(a,b)/m)(alpha-mu_m)`
`           =(alpha-mu)(1-max(a,b)/m)(1+m/Q)>0`.

Every positive u=|a+b-m| is below m and fresh: otherwise its original
retained label would be alpha-good on the nonempty W_k. All original
endpoint choices enter C_k; no selected cover replaces the full families.
Minimum sum supplies a closed alpha-witness for a one-slot replacement
m->u. If it did not, its compact continuous minimum would have maximum
below alpha; dividing by its gcd preserves that maximum and reduces its
primitive sum. Its witness lies in W and cannot lie in any portion where
u is a candidate. Conversely a common candidate repairs all W, and outside
W a retained speed is strictly bad, giving the accepted global descent.
These are previously reviewed inputs, not new conclusions of this task.

## Compatible cycles and the changing weights

When every C_k is nonempty, choose candidate-and-witness escape edges.
They have no self-loops. A finite directed graph with such an outgoing
edge at each vertex contains a simple cycle. Choose an incoming witness
t_i at each vertex. Its outgoing candidate repairs that time because
repair holds throughout W_(k_i), not just at an initially selected point.

Successive vertices have distinct residues and therefore distinct circle
times. Lift along the directed cycle with increments in (0,1), ending at
`tau_r=tau_0+w` for an integer w>0. This does not impose the spatial order
of the components. Nearest-integer indices are nondecreasing along
increasing real times; distinct residues make
`q_i=k(tau_(i+1))-k(tau_i)>0`. The fixed-label floor counts
`d_(v,i)=J_v(tau_(i+1))-J_v(tau_i)` are nonnegative. Periodicity gives

`sum_i q_i=mw`, `sum_i d_(v,i)=vw` for EVERY fixed original v in S.

For the selected pair on edge i, set gamma_i=a_i+b_i-m and
`p_i=d_(a_i,i)+d_(b_i,i)-q_i`. Subtracting H at the two endpoints gives
exactly `z_i(tau_(i+1))-z_i(tau_i)=gamma_i*Delta_tau_i-p_i`.
Target goodness makes `sigma_i=sign(z_i(tau_(i+1)))` nonzero. Hence

`sigma_i*(gamma_i*Delta_tau_i-p_i)>delta_(a_i,b_i)`,

because the first signed phase is at least alpha and the outgoing source
phase is strictly below alpha-delta_i. Summing proves the manuscript's
strict oriented inequality.

The fixed-label totals do not cancel its weighted counts: the coefficient
of d_(v,i) is `sigma_i*(1_(v=a_i)+1_(v=b_i))`, varying by edge, and q_i
also has the varying coefficient sigma_i. With a single constant pair
and sign, both summed terms would equal gamma*w and cancel; that special
case already contradicts incoming goodness and outgoing repair.

Writing `Z_i=sigma_i*z_i`, every Z_i is periodic under integer time
translations: its H increases by gamma_i times the translation. Reindexing
the finite sum therefore gives the exact vertex-switch identity

`sum_i[Z_i(tau_(i+1))-Z_i(tau_i)]`
` =sum_i[Z_(i-1)(tau_i)-Z_i(tau_i)]`.

The two functions at a vertex have different parent pairs or orientations.
The right side is not a telescoping sum of one potential. No monotone
weighted-carry principle or intervening-component constraint was proved.

## Exact cycle control, including its full deletion set

For V_*=(1,5,6,7,8), alpha=1/6, speed 1 restricts [0,1/2] to
[1/6,1/2]. Direct closed-band intersection there gives
`I_1=[7/30,11/42]`, `I_2=[13/36,11/30]`,
`I_3=[19/42,17/36]`; reflection gives the other half of the FULL W_*.
For example the relevant 5-good bands are [1/30,1/6], [7/30,11/30],
[13/30,17/30], the 6-good bands [7/36,11/36], [13/36,17/36], and
the 7-good bands [1/6,11/42], [13/42,17/42], [19/42,23/42].
Speed 6 removes the isolated potential point 1/6. These intersections
leave exactly the three intervals displayed.

The actual private portions are I_1, I_2 and their reflections, with
indices 2,3,6,5. At their original m-arc endpoints 11/48,13/48,17/48,19/48,
the retained norm numerators, in order (1,5,6,7) and denominator 48, are
`(11,7,18,19)`, `(13,17,18,5)`, `(17,11,6,23)`, `(19,1,18,11)`.
Threshold alpha is 8/48; thus the COMPLETE endpoint pairs are (5,7)
at 2 and (6,5) at 3, with candidates 4 and 3. Reflection supplies the
other two. On all I_1, `||4t||<=1/15`; on all I_2, `||3t||<=1/10`.

At the lifted times 7/30,13/36,37/30, the data are:

| Quantity | First time | Second time | Third time |
| --- | --- | --- | --- |
| k(t) | 2 | 3 | 10 |
| J_1 | 0 | 0 | 1 |
| J_5 | 1 | 1 | 6 |
| J_6 | 1 | 2 | 7 |
| J_7 | 1 | 2 | 8 |

Thus q=(1,7), and the two edge counts for fixed labels 1,5,6,7 are
(0,1), (0,5), (1,5), (1,6). Every total is its original speed.
For edge (5,7), H=1 at both ends, z=-1/15 and 4/9, p=0, sigma=+1.
Its increment is `4*(23/180)=23/45`. For edge (6,5), H changes 1->4,
z changes 1/12->-3/10, p=3, sigma=-1. Its oriented increment is
`-[3*(157/180)-3]=23/60`. Their sum is exactly `161/180>0`.
Independently the vertex-switch contributions are 11/30 and 19/36,
with the same sum. The fixed-label counts are fully compatible.

This control uses those exact selected phases and direct private repairs;
it is not assigned a hypothetical mu_m. On I_3 the nearest m-index is 4
but the m-norm ranges from 2/9 to 8/21, wholly above alpha. Its reflection
is also untrapped. At 11/24 the five original norms are
`(11/24,7/24,1/4,5/24,1/3)`, whose minimum is 5/24>1/6.
Thus V_* is native-good and does not satisfy global trapping or strict
failure. The arithmetic falsifies cancellation from closed-cycle counts
and the selected private data alone, not from every full failure premise.

## Stronger lower-count seeds and their exact domains

For a source pair a,b and its fresh positive u=|a+b-m|, the tuple
`T=(V\{m,a}) union {u}` contains exactly n-1 distinct positive labels.
Least count supplies a closed beta=1/n witness. If a primitive formulation
is used, divide T by its gcd g, obtain a witness at s, and use t=s/g
for the original T. Every original label except m,a is then beta-good,
and the actual global bound forces `min(||mt||,||at||)<=mu<alpha`.
The two removed labels cannot both be alpha-good. Exactly three cases remain:

1. a is alpha-good: m is bad and t belongs to W_m.
2. a is alpha-bad and m is alpha-good: t belongs to W_a.
3. Both are alpha-bad: t belongs to no original W_j.

In the last case, deletion of either bad label leaves the other bad;
deletion of any different label leaves both. Equalities at alpha belong
to the good cases. In case two, original all-coordinate contraction for
a applies, but m remains a larger retained label; the maximum-owner
endpoint theorem is not an automatic recursive theorem for a.

If sigma=sign(a+b-m), then `sigma*u-b=a-m`. In case three, the triangle
inequality gives `||sigma*u*t-b*t||<=||at||+||mt||<alpha+mu`, since
one summand is <=mu and the other is <alpha. It does not bound both by
mu, or contradict separate beta-goodness of u and b.

For the same control, a=5,b=7,u=4 and T=(1,4,6,7). At t=3/8 its norms
are `(3/8,1/2,1/4,3/8)`, all >beta=1/5; the removed original norms
are 1/8 and 0. This witness lies outside every original W_j. The phase
difference is `||(4-7)*3/8||=1/8`. Conversely at t=11/30 in I_2, T has
norms `(11/30,7/15,1/5,13/30)`, and the removed 5-norm is exactly
1/6. It is a favorable closed-boundary witness in W_m. Both checks use
all retained original labels, with no inference from selected local repair
to all-time repair.

The first control time refutes automatic domain transfer of every such
seed under the weaker tested data; the second rules out interpreting
the example as having no favorable selectable seed. Neither disproves
existence of a suitable seed under full canonical minimal failure.

## Scope, bindings and actual checks

The first unresolved implications are a contradiction or valid descent
from the varying-label cycle under the full native globally trapped
hypotheses, and a justified favorable seed selection or transport through
the other deletion and multiply-bad strata. The manuscript establishes
neither. Its full-W bound does not become an unsupplied relation between
the sampled cycle vertices and intervening components. The controls do
not refute the full positive-incoherent strict-failure branch. This bounded
branch can be closed as inconclusive while unrestricted LRC remains open.

The complete frozen author and the positive-coherence author/review were
read. The cancellation source was fully reread; invoked minimal-frequency
and contraction portions were checked, reusing the unchanged earlier full
reviews. All twelve author input bindings matched their current bytes.
The table below binds the author and those complete inputs. New identities
and every displayed control fraction were checked by hand, without a
mathematical program or enumeration.

| Input | SHA-256 |
| --- | --- |
| `research/astra-positive-candidate-escape-cycles.md` | `d7c8ff0d24f43ce30c272b4eed93686eeaad8b7dfca41449d1f1b22781e7ad49` |
| `research/astra-positive-candidate-coherence.md` | `a5c01c2ebbaa8b008787f61e9ec51aa1fcc2e01c7865409d775af0a5e5b8beea` |
| `research/astra-positive-candidate-coherence-review.md` | `5624364765087862f67f41b24e8c5ea0c7d5a08fa7ff449a00b799f9707bbc67` |
| `research/astra-forced-cycle-frequency-exchange.md` | `4ac28414ec9043c9ed11d69b7cc8520a2a1acc3b74168147acfc38091959046f` |
| `research/astra-maximum-frequency-exchange-review.md` | `9cd1282b49034073ad59e8df183df7e7b2cc65ce359d8ec8b088c6c032ab9515` |
| `research/astra-minimal-frequency-synthesis.md` | `03cf038021f0bc1a2328bb77a02f6ab4fe649f5d3626d7bc368a67cd6c7b0000` |
| `research/astra-minimal-frequency-review.md` | `b26182c2e482e7f83480eab9904779b958eb8b8b753c70bc45c6fabec55b747d` |
| `research/astra-strict-core-shell-supply.md` | `5cc9866b3c8a516494ad998355265335a5edd15158cf9701c7d814843b97210e` |
| `research/astra-strict-core-shell-review.md` | `dd733c2910f1f4579846c1c945ecac8e83d140eb29917b81dc11d2b1b119b95f` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Current config, workflow, policy and focused live state were read. The gate
was research/in_progress with recorded explicit start authorization
`2026-09-05T04:12:25.208107+00:00`; the active record matched this route,
checkpoint and sole owned file. `python3 -B scripts/validate_workflow.py`
exited 0 with `workflow structural validation passed; it cannot certify
mathematical validity.` Full review readback, thirteen final source bindings,
final newline/whitespace and final workflow checks were completed before
the separately reported frozen hash. Only administrative checks ran; no
Lean execution, mathematical program, solver, build, cache/dependency
operation, new agent, external model, Git/shared-state/memory write or
other-file edit occurred. No author correction was required.
