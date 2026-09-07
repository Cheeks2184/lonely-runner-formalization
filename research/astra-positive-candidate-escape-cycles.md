# Positive-candidate escape cycles: compatible carries and the seed-domain gap

Task `/root/positive_candidate_escape_cycles`; assigned checkpoint
`2dca882840ede6444cca50aeda81c72f283de1c4`. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed time and usage: null.
Only this manuscript is owned. New hand deductions require independent
review; no kernel theorem or unrestricted LRC resolution is claimed.

Neither of the two tested mechanisms closes the globally trapped positive
branch. Keeping the complete integer phase carries gives an exact cycle
inequality, but its varying parent labels prevent cancellation. Deleting
a parent as well as the maximum produces a stronger lower-count seed;
that seed can occupy a multiply-bad stratum outside every original deletion
set. The accepted native-good control checks both limitations, with its
failure of global trapping kept explicit. No actual strict failure or
counterexample to the intended uniform implication is constructed.

## 1. Full setting and the inherited escape relation

Let V be a hypothetical canonical strict failure of n>=3 positive distinct
primitive integer speeds, least by moving count and then primitive sum.
Use the fixed original labels and the actual global maximum:

    N=n+1, alpha=1/N, beta=1/n, m=max V, S=V\{m}, Q=max S,
    0<mu=max_t min_(v in V)||vt||<alpha,
    epsilon=alpha-mu, mu_m=mu-m*epsilon/Q,
    W={t:||vt||>=alpha for all v in S}.

The accepted whole-set contraction gives `0<mu_m<alpha` and the unique
nearest integer `k(t)` with `|mt-k(t)|<=mu_m` on ALL W. Let K be all
attained residues modulo m and W_k their complete portions. Every such
portion is inside its actual original open m-alpha arc A_k. Include every
closed endpoint and singleton portion. All original endpoint covers and
their compatible numerator lifts are retained.

For left/right endpoint labels a,b<m with original indices l,r at k, put

    gamma=a+b-m, u=|gamma|.

When u>0, the accepted cancellation makes u fresh, less than m, and bad on
the whole W_k. More precisely, on that lifted portion,

    z=gamma*t-(l+r-k),
    |z|<alpha-delta_(a,b),
    delta_(a,b)=(1-max(a,b)/m)*(alpha-mu_m)
                =epsilon*(1-max(a,b)/m)*(1+m/Q)>0.            (1)

This explicit strict margin is already in the cancellation source; it is
not new coherence. Let C_k contain all such positive candidates. The
present branch assumes every C_k nonempty and their total intersection
empty. Minimum sum supplies an alpha-witness after each one-slot replacement
m->u, hence a point of the whole W where u is good. Its collision h has
u not in C_h. A common candidate would instead give the accepted full-time
descent: outside W a retained original label is bad, and on W the new
label would be bad. These are inputs, not the new result of this task.

## 2. First mechanism: carry every original integer label around an escape cycle

For ANY fixed distinct retained labels a,b and any real lift t of a point
of W, define

    J_v(t)=floor(v*t), f_v(t)=v*t-J_v(t), e(t)=mt-k(t),
    H_(a,b)(t)=J_a(t)+J_b(t)+1-k(t),
    z_(a,b)(t)=(a+b-m)*t-H_(a,b)(t)
               =f_a(t)+f_b(t)-1-e(t).

Every retained fractional phase lies in the closed interval
`[alpha,1-alpha]`. Global trapping therefore gives, on the ENTIRE W,

    |z_(a,b)(t)|<=1-2alpha+mu_m<1-alpha.                      (2)

Since z differs from `(a+b-m)*t` by an integer, (2) gives the exact test

    ||(a+b-m)*t||>=alpha  iff  |z_(a,b)(t)|>=alpha.            (3)

No alternative integer near +1 or -1 has been omitted: the upper bound
in (2) lies strictly below 1-alpha. For an endpoint pair at its source
portion, this definition agrees with (1). Indeed `at-l` and `r-bt` are
between alpha and 3alpha<1, by the strict endpoint overlap bounds; hence
J_a=l and J_b=r-1 there. The strict upper bound remains valid at N=4.

Use the inherited finite escape relation to take a simple directed cycle
with successive collisions k_0,...,k_(r-1),k_r=k_0. For its edge i select an
actual endpoint pair (a_i,b_i) at k_i and a witness in W_(k_(i+1)) at which
u_i=|a_i+b_i-m| is alpha-good. Let t_i be the incoming witness at vertex i.
Outgoing repair (1) holds at t_i because it holds on the entire portion.
Choose increasing lifts tau_i of these witnesses with each step less than
one. Then `tau_r=tau_0+w` for a positive integer w. This ordering lifts the
given edges; it does not assert that they visit consecutive W components.

Retain the compatible counts for every original label:

    q_i=k(tau_(i+1))-k(tau_i)>0,
    d_(v,i)=J_v(tau_(i+1))-J_v(tau_i)>=0.

Different vertices give different maximum indices modulo m, so q_i is
positive. Full periodic closure gives the exact integer constraints

    sum_i q_i=m*w, sum_i d_(v,i)=v*w for each fixed v in S.   (4)

These are counts from one actual sequence of real times, not independent
residue choices. With `gamma_i=a_i+b_i-m`, put

    p_i=d_(a_i,i)+d_(b_i,i)-q_i in Z,
    sigma_i=sign(z_(a_i,b_i)(tau_(i+1))) in {-1,1}.

The target is good, so the sign is nonzero. The exact phase increment and
the source margin now give

    z_(a_i,b_i)(tau_(i+1))-z_(a_i,b_i)(tau_i)
       =gamma_i*(tau_(i+1)-tau_i)-p_i,
    sum_i sigma_i*[gamma_i*(tau_(i+1)-tau_i)-p_i]
       >sum_i delta_(a_i,b_i)>0.                            (5)

This retains both signs of the target phase and every integer carry.
The attempted contradiction would make the left side vanish, or force
it nonpositive, using closed-cycle compatibility. Equations (4) do not
perform that cancellation: the counts for each fixed v telescope only
when given constant weights, whereas (5) uses the varying weights
`sigma_i*(1_(v=a_i)+1_(v=b_i))`. The q_i also have varying signs sigma_i.
With one fixed pair and sign, both terms would sum to gamma*w and cancel;
that situation is already incompatible with simultaneous incoming goodness
and outgoing repair by that same candidate.

Equivalently, if `Z_i(t)=sigma_i*z_(a_i,b_i)(t)`, the left side is exactly
the vertex-switch sum

    sum_i [Z_(i-1)(tau_i)-Z_i(tau_i)],                       (6)

using periodic lifts at the last vertex. Incoming Z is at least alpha
there, while outgoing Z is strictly below alpha-delta_i. These are
different functions. Treating (6) as a telescoping sum would delete the
very changes of parent pair and orientation that permit an escape cycle.

### Exact check against the existing control

No new tuple or sweep is needed. Use the accepted native-good
`V_*=(1,5,6,7,8)`, alpha=1/6, with its actual private portions
`I_1=[7/30,11/42]` at k=2 and `I_2=[13/36,11/30]` at k=3.
Their complete endpoint pairs are (5,7) and (6,5), giving candidates 4
and 3. Lift the already established escape cycle using

    tau_0=7/30, tau_1=13/36, tau_2=37/30=tau_0+1.

For pair (5,7), H has value 1 at both tau_0 and tau_1, and the z values
are `-1/15` and `4/9`. Thus p_0=0, sigma_0=+1, and the oriented phase
increment is `4*(23/180)=23/45`. For pair (6,5), H changes from 1 to 4,
and the z values are `1/12` and `-3/10`. Thus p_1=3, sigma_1=-1, and
the oriented increment is `-[3*(157/180)-3]=23/60`. The maximum index
increments are 1 and 7, summing to 8; every fixed original J_v increases
by v over this period. The left side of (5), evaluated with these actual
data, is `23/45+23/60=161/180>0`, not zero.

Only the stated phase values and strict private repairs are being used in
this check; no hypothetical mu_m is assigned to this good tuple. Its full
W_* also contains `[19/42,17/36]` and its reflection, outside the m-alpha
bad set. At 11/24 the five original norms are
`(11/24,7/24,1/4,5/24,1/3)`, all above alpha. Thus it does NOT satisfy
global trapping or mu<alpha. The check refutes cancellation from the
closed-cycle counts and selected private data alone, not a claim using
the missing global hypothesis essentially.

The precise limitation of this mechanism is that, although (2) is valid
on all W under the full hypotheses, the cycle sum only samples its chosen
vertices. No derived relation couples the intervening original components
to the variable weights in (5). An untrapped component is not forced by
this calculation. No claim that all compatible native trapped cycles
exist, or that the desired contradiction is impossible, follows either.

## 3. Second mechanism: delete a source parent to obtain a stronger seed

Fix an actual candidate u=|a+b-m|>0 at one source portion and form

    T=(V\{m,a}) union {u}.

Freshness makes this an admissible tuple of exactly n-1 distinct positive
labels. Least count, with gcd normalization and time rescaling if needed,
supplies a closed beta=1/n witness for T. At such a time every original
label except m,a is beta-good, and u is beta-good. Original strict failure
gives `min(||mt||,||at||)<=mu<alpha`. The exact exhaustive alternatives are:

* If a is alpha-good, the time belongs to W_m and is a stronger u-good
  escape in an original maximum portion.
* If a is alpha-bad and m is alpha-good, it belongs to W_a. The all-coordinate
  contraction applies to a there. The original label m remains present,
  so the maximum-owner endpoint argument cannot be recursively applied
  with a as though the larger labels had vanished.
* If both a and m are alpha-bad, the time belongs to NO original W_j:
  deleting either one leaves the other bad. At least one has norm at most
  mu; it is not justified to give that bound to both individually.

Closed equalities at alpha belong to the good cases. The candidate relation
does not remove the third alternative. If `sigma=sign(a+b-m)`, its exact
identity is

    sigma*u-b=a-m.

In the third case this only yields
`||sigma*u*t-b*t||<alpha+mu`. Two beta-good phases can be this close; a
lower bound on their separate norms is not a separation bound.

The same accepted control checks this domain issue directly. At its k=2
take a=5,b=7,u=4. The tuple T is (1,4,6,7), with beta=1/5. At t=3/8 its
norms are `(3/8,1/2,1/4,3/8)`, all strictly above beta. The original
5- and 8-norms are 1/8 and 0, both below alpha=1/6. This lower-count
witness is outside every original W_j, and the displayed difference norm
is 1/8. The control remains globally good, as checked above.

This falsifies automatic deletion-domain transfer of EVERY stronger seed,
not existence of a favorable selectable seed under full failure. Indeed
the same control has a favorable T witness at t=11/30 in I_2: its norms
are `(11/30,7/15,1/5,13/30)`, while the deleted 5-norm equals alpha.
No assertion that all T witnesses are multiply bad is being made.

The attempted amplification therefore still needs a justified choice that
avoids the latter two alternatives, or full transport across their
multiply-bad strata. The lower-count existence theorem supplies neither
choice. No simultaneous replacement or all-time repair has been inferred
from the source candidate's repair on W_k alone.

## 4. Bounded disposition and source bindings

The valid bookkeeping consequences are (2)--(6) and the exact stronger-seed
partition. Neither constitutes a new uniform coherence or descent theorem.
The cycle method supplies no contradicting bound on its changing-label
carry correction; the seed method has no supplied control of the other
deletion and multiply-bad
domains. Their precise missing implications remain under the original
native threshold, global trapping and full minimality hypotheses. The
control is used only for the explicitly weaker inferences just identified.

This branch stops after those two checks. It produces no new sharp supply,
untrapped-component theorem, admissible smaller failure, or counterexample
to full LRC. It neither revisits a bounded-height frontier nor proposes a
successive-count program. Unrestricted LRC remains unresolved.

| Input | SHA-256 |
| --- | --- |
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

Current instructions, policy and focused state were read; the gate was
research/in_progress with the recorded explicit authorization and this
sole owned file. `python3 -B scripts/validate_workflow.py` exited 0 with
`workflow structural validation passed; it cannot certify mathematical validity.`
The positive-candidate author/review were fully read and the needed accepted
input portions checked at the bound hashes. All new mathematics and the
displayed fractions were checked by hand. Full owned-file readback, source
bindings, final newline/whitespace, final workflow validation and frozen
hash are reported at handoff. Only administrative checks were run: no
mathematical program, search, solver, build, cache/dependency operation,
new agent, external model, Git/state/memory write or other-file edit.
