# Independent review of local slack-energy fluxes

Task `/root/slack_energy_phase_cell_review`; review checkpoint
`24dcc214a08e860ce12127011865c591a332b02c`. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed task time and usage:
null. Only this review is owned; other work and shared state are preserved.

**Disposition: accepted at the stated manuscript scope, without mathematical
correction.** The complete frozen author is
`research/astra-slack-energy-phase-cell-charging.md`, SHA-256
`c87e03e848261ceae8355a564bb7be3b2b5b8914048d7bfcb40ee44bba0c1c73`.
The distributional weights, exact negative cell and obstruction for the
specified BV flux class are correct. This rejects a nonnegative residual-
measure certificate on an actual LRC-good tuple; it neither refutes the
global energy inequality E nor excludes general nonlocal charging.

## Full predicate and product identity

Retain distinct positive primitive integer speeds of count d>=2,
0<a<alpha=1/(d+1), f_i(t)=||v_i t||, h_i=(f_i-a)_+, P=product h_i,
P_i=product_(j!=i) h_j, and G={t: every f_i(t)>a}. The density is

    K=(d+1)P-(alpha-a)1_G sum_i P_i.

The bound energy sources correctly give H=-dI/da=integral_G sum_i P_i
and Delta=integral K. For fixed a the threshold times form a finite set.
Off that set, either all factors are active and the ordinary threshold
derivative applies, or some factor stays zero in a threshold neighborhood
and the derivative of P is zero. Bounded difference quotients justify
integration. In particular, on a region with exactly one bad label its
deletion product P_i may be positive, while the derivative of the full P
is zero. The indicator 1_G cannot be omitted. This also preserves every
multiply-bad region and does not substitute a deletion-witness domain.

On an affine norm piece inside G, f_i=sigma_i v_i t+b_i, with the actual
integer branch constant b_i. Since sum_i h_i P_i=dP,

    K-(tau P)'=(1-tau')P
                  +sum_i(f_i-alpha-tau sigma_i v_i)P_i.

Direct expansion gives the author's coefficient d+1 and the sign of each
term. Taking tau=t-c leaves the affine branch extrapolated to c, minus
alpha; it gives no sign estimate. At a jump of tau, continuity of P gives
the additional derivative atom P(t)(tau_+-tau_-). All such jumps must
be retained in a distributional or cellwise summation.

## Time derivatives and every atomic contribution

Because 0<a<1/2, the three changes for an individual slack are distinct
within each period of that coordinate: slope 0 to v_i at (k+a)/v_i,
v_i to -v_i at (k+1/2)/v_i, and -v_i to 0 at (k+1-a)/v_i.
Thus the time measure D_t h_i' has weights v_i, -2v_i, v_i at those
points, respectively. The weight is v_i, not v_i^2: differentiating in
phase would introduce v_i^2, but converting a phase delta to a delta
at the actual time divides its mass by v_i.

Since every h_i and P_i is continuous, differentiating
P'=sum_i h_i' P_i gives

    D_t P' = 2 sum_(i<j) h_i' h_j' product_(l!=i,j)h_l dt
       +sum_i v_i sum_k [ P_i(t^-)*delta_(t^-)
                        +P_i(t^+)*delta_(t^+)
                        -2P_i(p)*delta_p ].

The factor two comes from the two orders of distinct differentiated
factors. There is no product of Dirac distributions: the cross terms
are products of almost-everywhere first derivatives and contribute an
ordinary density. Away from the finitely many cuts, each differentiated
factor is active whenever its derivative is nonzero, and every remaining
factor must be positive. Hence that density vanishes outside G up to a
null set.

The atomic products use their continuous point values. At two simultaneous
thresholds each relevant P_i contains another zero slack, so all their
atomic weights vanish. Simultaneous active peaks add their negative
weights. If a threshold and a different coordinate's peak coincide, the
peak term contains the threshold's zero factor and vanishes; the threshold
term retains its stated weight when all other slacks are positive. These
cases agree with the direct jump of P'; there is no missing mixed atom.

For continuous piecewise C1 nu, the distributional product rule is
D_t(nu P')=nu D_t P'+nu'P' dt. The residual subtracts this measure.
Consequently a simple active threshold requires nu<=0 for nonnegative
residual mass there, whereas an active peak requires nu>=0. The continuous
lambda P part contributes no atom. These are necessary local signs, not
existence of a multiplier. If either multiplier jumps, the correct atom
is F_+-F_- for the complete flux, with both one-sided values; one cannot
use the continuous-multiplier formula and discard that extra jump.

At EVERY original integer-phase cut q=k/v_i, h_i is identically zero in
an open neighborhood because a>0. Thus P and P' vanish there, and D_t P'
has no atom at q. For an original cell between consecutive such cuts,
its total D_t P' mass is zero. The ordinary pair-density integral plus
all threshold masses minus all peak masses is therefore exactly zero,
as claimed in (5). Internal threshold masses do not become a net supply
to another original cell.

## Exact negative cell and positive full energy

For v=(1,2,3), alpha=1/4 and 0<a<1/5, C=[1/3,1/2] is an actual
integer-phase cell. Its norm branches are t, 1-2t and 3t-1. The speed-one
constraint is automatic here; the other two give precisely

    L=(1+a)/3 < t < R=(1-a)/2.

No half-phase peak lies in the interior of C. With x=t-L,
w=R-L=(1-5a)/6 and A=L-a=(1-2a)/3, the three slacks are
A+x, 2(w-x), 3x. Consequently

    P=6(A+x)x(w-x) on (L,R), and zero elsewhere in C;
    P'(L+)=6Aw, P'(R-)=-6(A+w)w;
    P''(L+x)=12(w-A)-36x=-2(1+a)-36x.

All signs are strict in the stated range. The exterior derivative traces
are zero, so the two threshold atoms are POSITIVE: 6Aw at L and
6(A+w)w at R. The first equals the speed-three jump times P_3(L);
the second equals the speed-two jump times P_2(R). The ordinary interior
integral is -6w(2A+w), precisely minus their sum. Omitting these atoms
would falsely turn the second derivative into a strictly negative measure
with nonzero total mass on this cell.

Integrating the cubic gives I_C=Aw^3+w^4/2. Write epsilon=1/5-a>0.
Then w=5epsilon/6, A=1/5+2epsilon/3, and

    I_C=(25/216)epsilon^3+(1625/2592)epsilon^4,
    H_C=(25/72)epsilon^2+(1625/648)epsilon^3.

Moving endpoints introduce no additional derivative term because P=0
there. Since alpha-a=epsilon+1/20, direct subtraction gives

    Delta_C=4I_C-(epsilon+1/20)H_C
           =-(5/288)epsilon^2-(25/2592)epsilon^3<0.

This is one actual cell, not the full-circle defect. I checked its match
to the accepted complete (1,2,3) calculation. Put delta=1/4-a,
epsilon=(1/5-a)_+ and u=(1/6-a)_+. That complete calculation has

    Delta/2=(8/27)delta^3-(5/288)epsilon^2
                    -(25/2592)epsilon^3+u^2(1/24-u/6).

For epsilon>0 its first three terms are
(743/2592)epsilon^3+(13/480)epsilon^2+epsilon/450+1/27000>0.
The u term is nonnegative since 0<=u<1/6. For epsilon=0, u=0 and the
remaining (8/27)delta^3 is positive. Thus full Delta>0 for every
0<a<1/4, including the switching thresholds. Time 1/4 is also an explicit
native witness with norms (1/4,1/2,1/4). Neither the negative cell nor
its derivative atoms is a falsifier to E or a strict-failure example.

## Exact multiplier class and first unresolved implication

The stated multipliers have finitely many pieces, C1 extensions on the
closed pieces, bounded one-sided traces, and periodic interpretation on
T. Their derivatives on each piece are integrable and their finitely
many jumps are finite. After refining by the phase cuts, both
lambda P and nu P' are BV, so F=lambda P+nu P' is BV and D_t F is a
finite signed measure. Values assigned at isolated points to the
almost-everywhere P' do not change its distribution; one-sided traces
determine its jumps.

The multipliers may depend on all tuple data and phase indices. The
obstruction does not assume that their choice itself uses only local
information. It uses their specified multiplicative form: near each
integer cut, both factors P and P' vanish, so F=0 there. For every
original cell, including a cell crossing the chosen circle representative,
the BV boundary formula gives (D_t F)(C)=0 after all internal jumps are
included. K also vanishes near the cell endpoints because G is empty
there. Open, closed or half-open cell conventions therefore give the
same mass.

In particular, for the cell above EVERY admissible multiplier pair gives

    [K dt-D_t F](C)=Delta_C<0.

A nonnegative measure cannot have this mass. Periodicity would make a
nonnegative residual imply Delta>=0, but the converse certificate fails
on this good tuple even though its full Delta is positive. A discontinuous
multiplier cannot evade the argument by moving an uncounted atom across
a cut where its whole flux is identically zero nearby.

This refutes the proposed certificate class on its universal domain.
It does not establish impossibility for a flux outside that class, for
arithmetic pairing between separate cells, or for a construction imposing
additional actual strict-failure hypotheses absent from this control.
The first missing implication is a quantitative comparison that moves
or bounds deficit between separated integer cells using their shared
arithmetic. The displayed local identities supply no such comparison.
E remains unproved and unrefuted here; unrestricted LRC remains unresolved.
No further derivative-order search or Lean claim is part of this review.

## Source and verification receipts

Complete frozen-author readback: `9262fa`; all eight actual input hashes:
`5cb077`, passed. Current instructions were read in `de4f85`, `f354bc`;
focused active state and explicit research authorization in `c79a03`.
Startup validator `9e46db` exited 0 with full output

    workflow structural validation passed; it cannot certify mathematical validity.

The unchanged energy proposal and accepted derivative/full-control review
were inspected at their invoked scopes, and the full exact-support review
was read in `824740`. Its termwise Fourier obstruction was preserved,
not used as a sign premise for this new calculation. All calculations in
this review were by hand. Final owned full readback, nine source bindings,
whitespace/newline checks and workflow validation accompany the separately
reported frozen review hash. No mathematical program, enumeration, solver,
local build, cache/dependency operation, new agent, external model,
Git/shared-state/memory write or other-file edit was performed. Only
administrative Python checks were used. Runtime accounting remains null.

| Bound source | SHA-256 |
| --- | --- |
| `research/astra-slack-energy-phase-cell-charging.md` | `c87e03e848261ceae8355a564bb7be3b2b5b8914048d7bfcb40ee44bba0c1c73` |
| `research/astra-uniform-strategy-after-fold.md` | `e569596af4ebab9f9d5e1c796d8da435bc433c1c238bc10f9901e644f9f49871` |
| `research/astra-slack-energy-review.md` | `1c526b214e7772088555642447d5fa2f93030f40195fd4aaca7a79bb1f6bd573` |
| `research/astra-slack-energy-global-compensation.md` | `8032d020e4beccc1112b025c8b85f6be6c2ec5cb67cdd763d4ae62a029627cb9` |
| `research/astra-slack-energy-global-review.md` | `c6416983efcbeeb909449a372be2ff316647f0ab6d92ba4d199429bd35e75e79` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |
