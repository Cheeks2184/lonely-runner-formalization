# Rational chambers: obstruction to bounded-index compensation

Task `/root/rational_cell_compensation`, requested `gpt-6-astra/xhigh` on
the existing researcher session. Observed model, effort, elapsed time and
usage: `null`. Assignment checkpoint:
`92d567677620fec37008cff35a70092339a87fd3`. Only this file is owned.
Status: new hand derivation, awaiting independent review.

**Outcome.** Pairing chambers within a uniformly bounded number of rational
endpoint cuts cannot provide a nonnegative compensation budget per pair.
The same obstruction applies to positive weighted groups of bounded
chamber-index diameter. At every fixed dimension an explicit good tuple
family has arbitrarily long runs of active chambers with negative defects.
Their neighboring endpoint translations even increase the cell energies.
No global compensation estimate or falsifier to the proposed inequality
(E) is obtained. This bounded pairing branch stops at the obstruction.

## Exact attempted budget

For `d>=2` distinct positive primitive integer speeds put `alpha=1/(d+1)`.
Cut the period at every rational zero `k/v_i`; endpoints do not affect
integrals. On each resulting chamber C let

    P_a(t)=product_i (||v_i t||-a)_+,
    I_C(a)=integral_C P_a(t) dt,
    H_C(a)=integral_{C, all ||v_i t||>a}
               P_a(t) sum_i 1/(||v_i t||-a) dt,
    Delta_C(a)=(d+1)I_C(a)-(alpha-a)H_C(a).

The accepted inputs give `H_C=-I_C'` and
`(d+1)I_C-(mu_C-a)H_C>=0` for the actual local maximum `mu_C`.
They do not give `Delta_C>=0`. The global proposed (E) is
`sum_C Delta_C>=0` for all tuples and `0<a<alpha`.

The concrete endpoint attempt is to pair a deficient chamber with a nearby
chamber, compare the integrals by the affine map between their rational
endpoints, and certify a nonnegative budget for each pair. Allow even
arbitrary positive weights in this proposed local budget. More generally,
allow groups of chamber-index diameter at most R, where R may depend on
dimension and threshold but is independent of the speed height. A partition
with nonnegative ordinary pair budgets would prove the global bound;
arbitrary weights are allowed below only to make the obstruction stronger.

The following family refutes this bounded-index step, including pairing
across an adjacent rational zero. It does not refute unrestricted groups,
a height-dependent range, or flows that can relay credit through many cells.

## Actual denominator-compatible family and consecutive chambers

Fix any `d>=2` and integer `K>=2`. Define

    A=(d+1)(4d+5),   a=1/A,   M=AK+1,
    v=(1,2,...,d-1,M),   alpha-a=4(d+1)a.

The speeds are positive and distinct and their gcd is one. This is an
LRC-good family: at the actual common time `t=alpha`, each slow speed i
has distance at least alpha, while `M alpha=K(4d+5)+alpha` has distance
exactly alpha. No assertion about the tuple's full maximum or (E) follows
from this witness alone.

For every integer

    2K+1 <= j <= 3K-1,

consider `C_j=[j/M,(j+1)/M]`. These are `K-1` consecutive actual chambers.
Indeed `2a M=2K+2/A` and `3a M=3K+3/A`, so the whole closed chamber lies
strictly in `(2a,3a)`. Also `3(d-1)/A<1/2`, so throughout this interval

    ||it||=it  for 1<=i<=d-1.

There is no slow zero there (in fact none in `(0,3a]`), hence no omitted
rational cut between the successive `M`-grid endpoints. All slow slacks
are strictly positive, and the fast runner is above a on the nonempty
open interval `((j+a)/M,(j+1-a)/M)`. Thus `I_{C_j}(a)>0`.

The actual local maximum is also exact. The minimum of all slow norms is
t, so the chamber's simultaneous minimum is `min(t,||Mt||)`. It is bounded
above by `min(t,j+1-Mt)`, whose unique maximum occurs at

    t_j=(j+1)/(M+1).

Since the chamber midpoint is below `1/2`, `M>2j+1`. Therefore `t_j` lies
inside the chamber on the descending fast branch and attains that bound:

    mu_{C_j}=(j+1)/(M+1) in (2a,3a),   mu_{C_j}<alpha.

The denominator M+1 arises from the actual contact equation; it supplies
no sharp lower bound for these local maxima.

## Exact cell integrals and strict negative budgets

Let `c=(j+1/2)/M`, `L=1/2-a`, and
`F_a(t)=product_{i=1}^{d-1}(it-a)`. On the positive part of this chamber,
write `u=t-c`. The fast slack is `L-M|u|`, with `|u|<=L/M`, and all other
slacks remain on their rising branches. Expand the actual polynomial

    F_a(c+u)=sum_{r=0}^{d-1} b_r(c,a) u^r,
    b_r(c,a)=sum_{S subset {1,...,d-1}, |S|=r}
                product_{i in S} i product_{i notin S}(ic-a).

All `b_r` are positive. Odd moments vanish, while for even r,

    integral_{-L/M}^{L/M} u^r(L-M|u|) du
       =2 L^(r+2)/[M^(r+1)(r+1)(r+2)].

Consequently the complete cell integral, without a truncated phase or
Fourier expansion, is the rational finite expression

    I_{C_j}(a)=sum_{0<=r<=d-1, r even}
                  2 b_r(c,a) L^(r+2)
                     /[M^(r+1)(r+1)(r+2)].                (1)

Let `u_r(c,a)=-partial_a b_r(c,a)>=0`. The same formula holds in an open
threshold neighborhood of the chosen a, with C and c fixed: the slow
slacks stay strictly positive throughout C. Finite differentiation gives

    H_{C_j}(a)=sum_{0<=r<=d-1, r even}
        2 [u_r(c,a)L^(r+2)+(r+2)b_r(c,a)L^(r+1)]
          /[M^(r+1)(r+1)(r+2)].                           (2)

This includes every slack and both sides of the fast tent. Its moving
integration endpoints introduce no extra energy term because the fast
slack is zero there. Formulas (1)--(2) are exact cell integrals for the
whole parameter family, not numerical evidence.

Their needed sign comparison is simpler directly in the integrands. At
every common-positive point in C, speed one has slack `t-a<2a`. Hence

    H-density = P_a sum_i 1/(||v_i t||-a) > P_a/(2a).

Integrating over a positive-length interval gives `H_C>I_C/(2a)`, and so

    Delta_{C_j}
      < (d+1)I_{C_j}-4(d+1)a I_{C_j}/(2a)
      = -(d+1)I_{C_j} < 0.                               (3)

This strict inequality holds in every chamber of the entire run at the
same threshold. It is stronger than merely observing subcritical peaks.
The aggregate deficit does not vanish as the number of chambers grows:
every slow slack exceeds a, and the fast slack has integral `L^2/M`, so

    sum_run Delta_C < -(d+1) a^(d-1) L^2 (K-1)/M,
    limsup_{K -> infinity} sum_run Delta_C
       <= -(d+1) a^d L^2 < 0.                            (4)

Here d, a and L stay fixed; only the speed M and the chamber count grow.

There is nonetheless an exact favorable endpoint transport inside the
run. For successive chambers, `T(t)=t+1/M` maps their rational endpoints
and preserves the fast norm. Every slow norm increases by `i/M`, with
unit Jacobian. The positive fast interval is carried to its successor,
and every slow slack increases there. Thus

    I_{C_{j+1}}(a)>I_{C_j}(a),

while (3) makes both defects negative. A pointwise increase of slacks and
energy under this genuine denominator-compatible map does not provide
the proposed local compensation budget.

## Quantified obstruction and first unresolved implication

Fix any nonnegative integer radius R. Choose `K>=2R+2` and
`j_*=2K+R+1`. Then

    j_*-R=2K+1,   j_*+R<=3K-1.

Every chamber within R consecutive endpoint crossings of `C_{j_*}` is
therefore in the negative run. Any pair or group of index diameter at
most R containing this chamber has a strictly negative budget with
positive weights, by (3). Such groups cannot partition the actual cell
system into nonnegative budgets. At fixed d, both alpha and a are fixed
while K is unbounded, ruling out any finite index bound independent of
height, even if it depends on d and a.

This is specifically an obstruction in ordered chamber INDEX. The run's
physical time length is `(K-1)/(AK+1)`, tending to `1/A`; no claim excludes
every transport bounded in physical time. Remote pairings, groups whose
index diameter grows with M, and arbitrary multihop flows remain unrefuted.
Reflection `t -> 1-t` also cannot by itself compensate the run: it gives
identical integrals and identical negative defects in the reflected cells.

The first unresolved step for a broader endpoint approach is to identify
actual distant cells with sufficient positive budget, then control their
capacity under a common assignment so no surplus is spent repeatedly.
Shared endpoint denominators, chamber widths and the explicit improving
neighbor translation above do not supply that estimate. No such global
arithmetic assignment was derived. This branch stops without replacing
(E) by witness positivity or presenting another local identity as its proof.
The family is admissible and good, but its full defect was not evaluated:
neither (E) nor unrestricted LRC is proved or refuted here.

## Frozen inputs and checks

All four assigned mathematical inputs were read completely. Their local
homothety and derivative contracts are retained; no termwise Fourier sign
test or numerical control was repeated. Current workflow/configuration,
policy and focused state were read; phase was `research/in_progress` with
the recorded 2026-09-05 start authorization and this task active.

| Input | SHA-256 |
| --- | --- |
| `research/astra-uniform-strategy-after-fold.md` | `e569596af4ebab9f9d5e1c796d8da435bc433c1c238bc10f9901e644f9f49871` |
| `research/astra-slack-energy-review.md` | `1c526b214e7772088555642447d5fa2f93030f40195fd4aaca7a79bb1f6bd573` |
| `research/astra-slack-energy-global-compensation.md` | `8032d020e4beccc1112b025c8b85f6be6c2ec5cb67cdd763d4ae62a029627cb9` |
| `research/astra-slack-energy-global-review.md` | `c6416983efcbeeb909449a372be2ff316647f0ab6d92ba4d199429bd35e75e79` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

`python3 -B scripts/validate_workflow.py` exited zero with:

    workflow structural validation passed; it cannot certify mathematical validity.

The formulas, integrals and inequalities were derived by hand. Administrative
checks bind the eight complete inputs and the owned file. No mathematical
program, sweep, solver, build, cache/dependency operation, external model,
extra agent, Git operation, shared-state write or other-file edit was used.
Earlier owned manuscripts and reviews remain frozen. Independent review of
this new derivation is still required; no formal implementation is proposed.
