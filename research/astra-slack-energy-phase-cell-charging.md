# Local product and derivative fluxes cannot supply cell compensation

Task `/root/slack_energy_phase_cell_charging`; assigned checkpoint
`ece90ad9f84e50f0158946daf329bb67341105fe`. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed time and usage: null.
Only this manuscript is owned. These are hand derivations requiring
independent review, not a Lean result or unrestricted LRC conclusion.

**Outcome.** Differentiating the first-derivative flux produces genuine
threshold atoms; they cannot be dropped. Retaining all atoms and jumps, every flux
of the form lambda*P+nu*P' with bounded piecewise regular multipliers
preserves the defect of EACH original integer-phase cell. An actual
negative cell therefore rules out a globally nonnegative residual-measure
certificate of this class. This is a specific obstruction to local
differential charging, not an impossibility theorem for all time-domain
charging. No positive global estimate or counterexample to E emerges.

## 1. Full common-time predicate and the tested certificate

Let v_1,...,v_d be distinct positive primitive integers, d>=2, and fix
0<a<alpha=1/(d+1). On T=R/Z, with normalized Haar measure, put

    f_i(t)=||v_i*t||, h_i(t)=(f_i(t)-a)_+,
    P(t)=product_i h_i(t), P_i(t)=product_(j!=i)h_j(t),
    G={t: all f_i(t)>a},
    K(t)=(d+1)P(t)-(alpha-a)*1_G(t)*sum_i P_i(t).

The indicator in K is essential: the second term is integrated only on
the full original good set, not on deletion-witness domains. The accepted
energy derivative says

    I(a)=integral P, H(a)=-I'(a)=integral_G sum_i P_i,
    Delta(a)=integral K=(d+1)I(a)-(alpha-a)H(a).

E is the assertion Delta(a)>=0 for every such tuple and threshold. Its
validity is not assumed. The earlier exact-support Fourier obstruction
is retained; no Fourier sign budget is used in this note.

The concrete integration-by-parts candidate tested here is to find
periodic multipliers lambda,nu such that the signed measure

    R=K(t)dt-D_t F,       F=lambda*P+nu*P',                (1)

is nonnegative on T. Here P' is the almost-everywhere time derivative.
The multipliers may depend on the full tuple, threshold and all actual
phase indices. Assume finitely many pieces, bounded one-sided values,
and C^1 regularity on the closed pieces, so F has bounded variation.
All jumps are included in D_t F. Nonnegativity of R would imply E by
periodicity. Neither the existence of these multipliers nor the sign of
R is being silently assumed.

## 2. Product multipliers: the exact common-time identity

Refine the actual cuts k/v_i by every half-phase and threshold crossing.
On a regular piece inside G, each original norm has the affine form
f_i(t)=sigma_i*v_i*t+b_i with sigma_i in {+1,-1} and b_i an integer
determined by its original grid. Thus

    P'=sum_i sigma_i*v_i*P_i,
    K-(tau*P)'=(1-tau')P
                  +sum_i(f_i-alpha-tau*sigma_i*v_i)P_i.  (2)

This follows from sum_i h_i*P_i=dP and ordinary differentiation.
Choosing tau=t-c on a piece makes each coefficient the actual affine
branch extrapolated to c, minus alpha. That does not supply their sign.
If tau jumps, its product flux has the jump P(t)*(tau_+-tau_-);
omitting it would invalidate the summed identity.

At every ORIGINAL integer cut q=k/v_i, the factor h_i vanishes on an
open neighborhood because a>0. Hence P and P' both vanish near q.
Product multipliers consequently have zero boundary flux between the
original integer cells. Internal half-phase or multiplier cuts cancel
when their correctly oriented traces are summed. This explains why the
first-derivative term in (1), whose threshold traces need not vanish,
is the meaningful second test.

## 3. All threshold and peak atoms of the first derivative

For each original speed v_i and k=0,...,v_i-1 define, modulo one,

    t_(i,k)^-=(k+a)/v_i,
    t_(i,k)^+=(k+1-a)/v_i,
    p_(i,k)=(k+1/2)/v_i.

These are actual grid crossings, not independently chosen phases.
The slope of h_i jumps from 0 to v_i at t^-, from -v_i to 0 at t^+,
and from v_i to -v_i at p. Therefore, as measures on T,

    D_t h_i'=v_i*sum_k(delta_(t^-)+delta_(t^+)-2delta_p).

The product is continuous and piecewise polynomial. The distributional
product rule, or directly its one-sided derivative jumps, gives

    D_t P'=2*sum_(i<j) h_i'*h_j'*product_(l!=i,j)h_l dt
       +sum_i v_i*sum_k[
          P_i(t^-)*delta_(t^-)+P_i(t^+)*delta_(t^+)
                         -2P_i(p)*delta_p].              (3)

The ordinary density is supported on G, up to null sets, because both
differentiated factors and all remaining factors must be active. No
multiply-bad region is counted as a good region. Products multiplying
atoms use their continuous point values. Simultaneous threshold crossings
of two or more factors give zero atomic weight, since another zero factor
occurs in each P_i. Coincident peaks contribute the indicated sum of
weights. There is no atom at an integer cut: P is identically zero nearby.

Threshold atoms in (3) are nonnegative and peak atoms nonpositive, while
the ordinary pair terms have their actual signed slopes. For continuous
multipliers, the derivative part of the flux has

    D_t(nu*P')=nu*D_t P'+nu'*P' dt.                       (4)

Its contribution to R in (1) has the OPPOSITE sign. Thus a nonnegative
R necessarily has nu<=0 at a simple active threshold and nu>=0 at a
peak where the other slacks are positive. These are necessary local
signs, not a supplied choice of nu or a global bound. If a multiplier
jumps, the atom must instead be computed from the exact jump of F;
(1) always retains that complete jump.

For every original integer-phase cell C, (3) gives the exact balance

    integral_C 2*sum_(i<j) h_i'*h_j'*product_(l!=i,j)h_l dt
      +[all threshold masses in C]-[all peak masses in C]=0. (5)

This is because the exterior traces of P' at both ends of C are zero.
The positivity of the threshold masses does not turn (5) into a positive
budget available to a different integer cell.

## 4. An actual negative component, with every derivative flux counted

Use the ordinary tuple V=(1,2,3), alpha=1/4, and ANY 0<a<1/5.
The original integer cell C=[1/3,1/2] has exactly one good component

    (L,R)=((1+a)/3,(1-a)/2).

There the original phases are t, 1-2t, and 3t-1. No half-phase peak
lies inside C. Put x=t-L and

    w=R-L=(1-5a)/6, A=(1-2a)/3.

The complete product on this component and its zero continuation in C are

    P(t)=6(A+x)*x*(w-x),    0<x<w;
    P(t)=0 otherwise in C.                               (6)

The speed-one slack is A+x>0; the other two are 2(w-x) and 3x.
Thus no original constraint or extra component is omitted. The exact
one-sided derivatives and ordinary second derivative are

    P'(L+)=6Aw, P'(R-)=-6(A+w)w,
    P''(L+x)=12(w-A)-36x=-2(1+a)-36x<0.                  (7)

The exterior derivative traces are zero. Accordingly the full measure
D_t P' on C has POSITIVE atoms 6Aw at L and 6(A+w)w at R, as required
by the speed-three and speed-two threshold jumps respectively. Its
interior integral is -6w(2A+w), exactly the negative of their sum.
This verifies (5) with every endpoint atom and orientation retained.

The cell energy is a direct cubic-product integral:

    I_C=6*integral_0^w (A+x)*x*(w-x) dx=A*w^3+w^4/2.

Set epsilon=1/5-a>0. Substituting w=5epsilon/6 and
A=1/5+2epsilon/3 gives

    I_C=(25/216)epsilon^3+(1625/2592)epsilon^4,
    H_C=-dI_C/da=dI_C/d epsilon.

Moving component endpoints introduce no extra energy-derivative term,
since P vanishes there. As alpha-a=epsilon+1/20, the cell defect is

    Delta_C=4I_C-(epsilon+1/20)H_C
           =-(5/288)epsilon^2-(25/2592)epsilon^3<0.        (8)

This is the same negative secondary-component contribution in the
accepted full (1,2,3) calculation. That review proves the FULL Delta
strictly positive throughout 0<a<1/4. The tuple also has its explicit
native witness t=1/4. Neither (8) nor the flux obstruction below is a
counterexample to E or an actual canonical strict failure.

## 5. Precise obstruction to the tested differential certificate

For EVERY admissible pair of multipliers in (1), F vanishes near the two
integer endpoints of C, because P and P' do. Summing all its ordinary
derivatives and jumps therefore gives

    (D_t F)(C)=0,      R(C)=integral_C K=Delta_C<0.        (9)

The boundary convention is harmless: F, K and their derivatives vanish
in neighborhoods of both integer endpoints. A nonnegative measure cannot
have the negative mass (9). Consequently the certificate (1) does not
exist for this actual tuple and these thresholds, even with freely chosen
periodic multipliers using every compatible integer phase label.
Discontinuous multipliers do not evade (9) when their jumps are retained.

This conclusion specifically covers bounded local fluxes built from P
and its first time derivative, including the nonzero threshold atoms
in the distributional derivative of that flux. It does not discard them because the
product vanishes at a threshold. The new point beyond the known negative
cell is that the full differential flux cannot move ANY of its net
defect across an original integer cut. Positive threshold atoms are
balanced inside the same cell before any global summation.

**First unresolved implication.** General charging could compare distinct
cells arithmetically or use a nonlocal flux that traverses the open gaps
where the full product is zero. Neither is excluded by (9). Such a rule
would need an actual quantitative bound coupling those separated cells;
the exact local identities (2)-(5) supply no such sign or transfer.
No uniform estimate emerged in this bounded attempt. E remains unproved
and unrefuted. The branch stops here, without a derivative-order screen,
count ladder, conditional Lean infrastructure, or claim against all
possible time-domain methods.

## 6. Checks and frozen inputs

The current instructions and focused active state were read; the setup
gate is `research` / `in_progress` with explicit start authorization.
Startup workflow validation passed (`91923d`), certifying structure only.
The accepted energy proposal, exact calculations and reviews below were
read. No unreviewed scalar-phase claim is used. New derivations are by
hand. Full readback (`05772b`, `a00efc`), all eight input bindings and
format checks (`d6f36f`), and workflow validation (`8c1c49`) passed before
freezing. Only this manuscript was written. No
mathematical program, enumeration, build/cache operation, external model,
new agent, Git or shared-state edit was performed. Unknown runtime
metadata remains null; independent mathematical review is required.

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
