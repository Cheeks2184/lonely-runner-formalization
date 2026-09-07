# Full-relation compensation attempt: no global bound obtained

Task `/root/slack_energy_global_compensation`, executed by
`/root/uniform_strategy_after_fold`, requested Astra/xhigh; observed routing
and usage null. Assignment checkpoint
`5aecd6775dd9480e3e4eaa8e8ec7fe76ebd80665`. Only this file is owned.
The preceding strategy manuscript remains frozen at
`e569596af4ebab9f9d5e1c796d8da435bc433c1c238bc10f9901e644f9f49871`.

**Outcome.** This bounded attempt did not prove or refute the proposed
global inequality (E). It tested compensation through the complete integer
relation lattice, grouped by exact coordinate support. On an actual tuple,
the full three-coordinate contribution repairs the negative defect left
by the constant and every two-coordinate contribution. However, complete
higher-support contributions have no uniform positive sign: an exact
parity calculation gives negative odd-support contributions, including
at strictly positive subcritical thresholds. No estimate controlling their
combined size emerged. These calculations expose the failure of the
attempted termwise budget; they are not progress establishing (E).

## Full lattice and the attempted compensation mechanism

Keep distinct positive primitive integer speeds `v_1,...,v_d`, `d>=2`,
`alpha=1/(d+1)`, and `0<a<alpha`. Write `L=1/2-a` and

    I_v(a)=integral_0^1 product_i (||v_i t||-a)_+ dt,
    H_v(a)=-I'_v(a),
    Delta_v(a)=(d+1)I_v(a)-(alpha-a)H_v(a).

The target is `Delta_v(a)>=0` for all these inputs. The known derivative
and local-cell identities are retained as inputs, not reproved or used to
claim global compensation.

Set `q_0(L)=L^2`, `q_k(L)=(sin(pi k L)/(pi k))^2` for `k!=0`, and
`Lambda_v={k in Z^d:sum_i v_i k_i=0}`. For each support `S` define

    R_S(L)=sum_{k in Lambda_v, support(k)=S}
                         (-1)^(sum_i k_i) product_i q_(k_i)(L).

These are complete sums, with all harmonics and all compatible integer
relations included. Absolute convergence follows from the squared Fourier
decay. There are no support-one terms, and `R_empty=L^(2d)`.

The attempted mechanism was to bound the negative blocks by the positive
blocks and the constant term, using positivity of the one-dimensional
tent convolution on each relation. The exact-support grouping avoids
counting a shared zero term once for every primitive relation ray.
Nevertheless the calculations below show that compensation must involve
blocks of different support sizes, whose signs themselves vary.

Derivatives of these blocks need no unjustified differentiated Fourier
series. For `U subset {1,...,d}`, let `I_U` be the energy for that subset,
with `I_empty=1`, and put `J_U(L)=L^(2(d-|U|)) I_U(1/2-L)`. Then

    J_U=sum_{S subset U} R_S,
    R_S=sum_{U subset S} (-1)^(|S|-|U|) J_U.              (1)

The energy derivative supplies every derivative on the right. In
particular `R_S` and its one-sided derivative at `a=0` are continuous
limits from positive `a`. Define

    Delta_S=(d+1)R_S-(alpha-a) dR_S/dL.

The full defect is exactly `sum_S Delta_S`. Any bound used in this
mechanism must control that full sum; a negative subsum does not refute E.

## Actual higher-support compensation, computed completely

Use `v=(1,2,4)`, `a=6/25`, `alpha=1/4`, `L=13/50`. This tuple is good:
time `1/3` gives every distance `1/3`, and the pair `(1,2)` bounds its
maximum by `1/3`. The example tests the proposed compensation mechanism,
not a new runner-count theorem.

Here are complete integral formulas that verify the contributions without
sampling or truncating Fourier series. Put `a=1/4-epsilon`,
`0<=epsilon<1/20`, and `M=1-3a=1/4+3epsilon`. Let `P=I_(1,2)=I_(2,4)`
and `Q=I_(1,4)`, the first equality following by integer time scaling.
Reflection and integration of the actual linear norm pieces give

    P=M^3/12-(4/3)epsilon^3,
    Q=L^2(L-1/8)/2,
    I_(1,2,4)=M^4/64-M epsilon^3/3+epsilon^4/6.           (2)

For P, use the half-period good interval `[a,(1-a)/2]`, split at `1/4`.
For Q, only the interval centred at `3/8` survives when `a>1/5`;
its radius is `L/4`, and the odd part of the factor `t-a` integrates
to zero. For the triple, the half-period good interval is
`[(1+a)/4,(1-a)/2]`, split at `3/8`. Treating the speed-four norm as
rising on the whole interval gives `M^4/64`; its actual falling end
contributes the correction `-M epsilon^3/3+epsilon^4/6`.
These intervals exhaust the common good set at these thresholds.

At `epsilon=1/100`, differentiating these polynomials gives

    P=457/250000,        dP/dL=73/1250,
    Q=4563/1000000,      dQ/dL=689/10000,
    I=57569/600000000,   H=12263/3000000,
    Delta=4I-(1/100)H=823/2400000 > 0.                   (3)

Every complete two-coordinate block is accounted for by
`R_{i,j}=L^2(I_(i,j)-L^4)`. Thus the constant and all pair blocks sum to
`J=L^2(2P+Q)-2L^6`. Their defect, and the remaining full-support defect,
are exactly

    (4-epsilon d/dL)J = -4290689/15625000000 < 0,
    Delta_{1,2,3}    = 115785143/187500000000 > 0.        (4)

The second number is the full value (3) minus the first, not an inferred
sign from a partial frequency list. It repairs the entire deficit in (4).
The pair relations `(2,-1,0)` and `(0,2,-1)` already generate the full
relation lattice: their cross product is primitive `(1,2,4)`. Their integer
combinations supply the indispensable coupled three-coordinate terms.
Independent one-ray budgets do not account for these combinations.

## Why a positive higher-support repair is unavailable termwise

There is an exact general sign rule at `a=0`, where `L=1/2`. Every
nonzero even Fourier index has `q_k=0`; every surviving nonzero index is
odd. Consequently, for support size `s`,

    R_S(1/2)=(-1)^s A_S,       A_S>=0.                   (5)

The inequality is strict whenever the relation lattice contains a vector
with exactly that support and every supported entry odd. In particular,
any distinct positive tuple containing `1,2,3` has the odd relation
`(1,1,-1)` on those coordinates, hence a strictly negative support-three
block. Extra coordinates only multiply it by their zero-frequency factors.

The derivative at this endpoint can be justified directly from (1).
The right derivative in a of each subset energy is the negative sum of
the deletion energies: all nonzero-speed phases vanish only at finitely
many times. Therefore, with derivatives in L,

    J'_U(1/2)=4(d-|U|)J_U(1/2)+4 sum_{i in U}J_(U minus i)(1/2).

In the inclusion-exclusion sum (1), the second term contributes
`-4(s-|U|)J_U` to the coefficient of each `J_U`. It follows that

    R'_S(1/2)=4(d-s)R_S(1/2),
    Delta_S(0)=[((d-1)^2+4s)/(d+1)]R_S(1/2).            (6)

The bracket is positive. Thus the negative odd-support blocks have
negative defect as well. This argument avoids termwise differentiation of
an infinite series; it also accounts for the vanishing derivatives of
the even modes at `L=1/2`. Continuity of the finite expression (1) and
of its energy derivatives implies `Delta_S(a)<0` for every sufficiently
small positive a. Intersecting that neighbourhood with `(0,1/(d+1))`
gives the required subcritical scope in every such dimension.

As an exact three-coordinate normalization check, for `(1,2,3)` at zero,

    I=145/10368,        H=41/216,
    R_{1,2,3}=-23/10368,    R'_{1,2,3}=0,
    Delta_{1,2,3}=-23/2592,  Delta_v=11/1296 > 0.

The pair integrals are `1/16,7/108,1/16`. The full integral is twice
the integral of `6t^3`, `2t^2-6t^3`, `t-5t^2+6t^3`, and
`5t^2-t-6t^3` on the successive intervals cut by
`0,1/6,1/4,1/3,1/2`. These give the displayed fractions directly.
Thus positive other blocks compensate a negative full-support block
here, reversing the direction of compensation in (4).

## First unresolved implication and branch disposition

Neither origin-centred phase compatibility nor summing every harmonic on
an individual relation supplies a sign for the complete support blocks.
The exact first missing estimate in this attempted mechanism is a bound
on their **combined** negative defect by their combined positive defect,
with the common zero term counted once, for every actual relation lattice
and `0<a<1/(d+1)`. Equations (4)--(6) show why the attempted independent
budgets and a nonnegative higher-support repair do not prove that estimate.
No replacement global inequality was obtained.

This bounded analytical branch stops here. E remains unproved and
unrefuted; the hand controls do not increase its evidence status. No
successive support-size screen, count expansion, positivity reformulation,
conditional Lean implementation or further partial-sum programme is
proposed. The calculations are new manuscript derivations pending review.

## Administrative receipt

The current workflow files and focused active state were read; phase was
`research`, goal status `in_progress`, with recorded start authorization
and this task active. The unchanged configuration and workflow documents
had already been read fully earlier in this session. Actual command
`python3 -B scripts/validate_workflow.py` exited 0 with:

    workflow structural validation passed; it cannot certify mathematical validity.

Frozen inputs and readback hashes:

| Path | SHA-256 |
| --- | --- |
| `research/astra-uniform-strategy-after-fold.md` | `e569596af4ebab9f9d5e1c796d8da435bc433c1c238bc10f9901e644f9f49871` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

All mathematics above was hand-derived. No mathematical program, numerical
search, solver, build/cache/dependency operation, external/browser model,
extra agent, Git mutation, shared-state write or other-file edit was used.
The separate finite-control source and receipt were not executed or used
as proof. Final administrative checks bind inputs and the owned file and
check newline/whitespace. No owned process remains; unexposed elapsed time
and per-task usage remain null. No unrestricted result is claimed.
