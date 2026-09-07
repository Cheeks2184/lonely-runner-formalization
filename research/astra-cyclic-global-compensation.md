# Full cyclic averaging: an exact failed compensation budget

Task `/root/cyclic_global_compensation`; requested `gpt-6-astra/xhigh`.
Observed model, effort, elapsed time and usage: `null`. Assignment checkpoint:
`52dcb44f9d4dfe5d398089193d71a2dd3ed1aa0b`. Only this manuscript is owned.
Status: new hand derivations awaiting independent review; no kernel theorem.

**Outcome.** Keeping the entire cyclic average gives exact energy and derivative
identities, but does not justify charging its full correction against the
positive baseline guaranteed by lower-count (E). That concrete proposed budget
is false for `(1,2,3,4)` throughout `19/100<=a<1/5`, even though the full defect
is strictly positive there. The lost term is the actual lower-count defect;
its contribution is of order `1/5-a`, while the full defect is of order
`(1/5-a)^3`. No sharp coupled compensation estimate was obtained. This bounded
attempt stops at that obstruction, without claiming to refute (E) or LRC.

## The entire cyclic average and its derivative

Let `d>=2`, let `v=(v_1,...,v_(d-1),M)` be distinct positive primitive integer
speeds with `M` largest, and let `0<a<alpha=1/(d+1)`. Put

    h_a(x)=(||x||-a)_+,  chi_a(x)=1_{||x||>a},  L=1/2-a,
    F_a(t)=product_(i<d) h_a(v_i t),
    Q_a(t)=1_{all i<d: ||v_i t||>a}
               sum_(i<d) product_(j<d,j!=i)(||v_j t||-a),
    J=integral F_a,  H_s=integral Q_a=-J'.

For any integrable `F` define the full averaging operator

    T_M F(x)=(1/M) sum_(k=0)^(M-1) F((k+x)/M),
    A_M=T_M F_a,  D_M=T_M Q_a.

The substitution `t=(k+x)/M` partitions the original time period into `M`
disjoint intervals up to endpoints. Every residue has weight exactly `1/M`;
no source interval or surplus is reused. Since `h_a(Mt)=h_a(x)`, the complete
identities are

    I_v(a)=integral_0^1 h_a(x) A_M(x,a) dx,
    H_v(a)=integral_0^1 [chi_a(x) A_M(x,a)+h_a(x) D_M(x,a)] dx,
    integral A_M=J,  integral D_M=H_s.                       (1)

For fixed `a`, `-partial_a A_M=D_M` off finitely many x values. Bounded
difference quotients justify differentiation under the integral, so (1)
retains every derivative term. In particular the derivative of the fast
slack does not disappear when passing to the cyclic average.

Both averages are periodic in x by cyclic reindexing. With Fourier convention
`F_hat(r)=integral F(t) exp(-2pi i r t)dt`, direct substitution gives

    A_M_hat(ell)=F_a_hat(M ell).                            (2)

For `q_0=L^2`, `q_r=(sin(pi r L)/(pi r))^2` at `r!=0`, this is equivalently

    A_M(x)=sum_(r in Z^(d-1), M divides sum_(i<d) v_i r_i)
        (-1)^(sum_i r_i) product_i q_(r_i)
        exp(2pi i x (sum_i v_i r_i)/M).                     (3)

Absolute summability of the tent series justifies (3). It contains every
alias relation and every original slow label, including the zero relation.
No partial Fourier allocation is used below. The common residue k cannot be
chosen independently for different rows: for example, at `v=(1,2,3)`,
`a=1/5`, `x=1/2`, the first slow row has positive slack only at `k=1`, and
the second only at `k=0,2`. Thus `A_3(1/2)=0` although both separate row
averages are positive. Full residue averaging does not assert independence.

## The tested global induction budget

Set `epsilon=alpha-a`, `beta=1/d`, and form the independent baseline only
as a comparison object:

    I_bar=L^2 J,  H_bar=2LJ+L^2 H_s,
    B_actual=(d+1)I_bar-epsilon H_bar,
    Delta_s=dJ-(beta-a)H_s,
    Delta_v=(d+1)I_v-epsilon H_v,
    R=Delta_v-B_actual.                                    (4)

Here R is the complete correction from the actual cyclic average, not a
truncation or a sum whose adverse terms have been omitted. The orchestrator
supplied the baseline comparison; its algebra was independently checked here:

    C_d(a)=d+1-2epsilon/L-d epsilon/(beta-a),
    B_low=L^2 J C_d(a),
    B_actual=B_low+epsilon L^2 Delta_s/(beta-a).             (5)

Indeed `C_d'(a)=2(1/2-alpha)/L^2+d(beta-alpha)/(beta-a)^2>0` and
`C_d(0)=(2d-3)/(d+1)>0`. Assuming lower-count (E) gives `Delta_s>=0`, hence
`B_actual>=B_low>0`; its accepted conditional implication gives `J>0` since
`a<alpha<beta`. The lower tuple need not be primitive: common integer
scaling preserves J and H_s. For `d=2`, its one-speed identity is direct.

The concrete global estimate tested in this attempt was

    R >= -B_low.                                          (G, false)

Together with the lower-count inequality, it would prove `Delta_v>=0`
while retaining every residue and charging the full correction only once.
It is stronger than (E), rather than a reformulation of it. The exact identity

    B_low+R=Delta_v-epsilon L^2 Delta_s/(beta-a)              (6)

exposes the extra reserve demanded by (G). The following actual sharp good
tuples show why that reserve is unavailable. Root identified the sharpened
comparison (6); the explicit polynomial counterfamily below was derived here.

## Complete progression asymptotics, at arbitrary count

For the tuple `(1,...,d)`, write `N=d+1` and `epsilon=1/N-a`. The maximum is
`1/N`. A shortest cyclic gap among `0,t,...,dt` proves the upper bound, and
`t=1/N` attains it. At any maximizing time all `N` cyclic gaps must equal
`1/N`. Thus the maximizing times are exactly `k/N` with `gcd(k,N)=1`.

At such a time let `r k=1 mod N` with `1<=r<N`, and `s=N-r`. These two speeds
have norm `1/N` with opposite slopes; all other speeds have strictly larger
norm. In local coordinate u the common-positive interval is exactly
`-epsilon/r<u<epsilon/s` for sufficiently small epsilon. The active factors
are `epsilon+r u` and `epsilon-s u`; their integral is

    epsilon^3 N^3/(6 r^2 s^2).

The product of the remaining slacks is a positive constant plus `O(epsilon)`.
Compactness excludes all other time regions for sufficiently small epsilon.
Consequently, at every fixed d,

    I_(1,...,d)=c_d epsilon^3+O(epsilon^4),
    H_(1,...,d)=3c_d epsilon^2+O(epsilon^3),
    c_d=[product_(m=2)^(N-2) ((min(m,N-m)-1)/N)]
           * (N^3/6) sum_(1<=r<N, gcd(r,N)=1) 1/[r^2(N-r)^2] >0.  (7)

The product is empty and equals one when `d=2`. For H, direct differentiation
of the two active slacks gives the leading term in (7); differentiation of
other factors contributes `O(epsilon^3)`. This avoids inferring a derivative
estimate from an undifferentiated remainder. In particular `c_2=9/4` and
`c_3=16/27`, agreeing with the accepted exact calculations.

The slow tuple `(1,...,d-1)` has a `1/d` witness, strictly above alpha, so
`J(alpha)>0`.
Therefore the full correlation `K=I_v/(L^2 J)` tends to zero as
`constant * epsilon^3`, and `-K'/K=3/epsilon+O(1)`. Nondecreasing monotonicity
of K in a would be a stronger route through the independent baseline, but is false.
Also `B_actual` tends to a positive constant while `Delta_v` tends to zero;
thus `R/B_actual -> -1`. No fixed fractional reserve
`R>=-eta B_actual`, `eta<1`, can hold uniformly. These are good tuples and
`Delta_v=(d-2)c_d epsilon^3+O(epsilon^4)`, consistent with (E), not against it.

## Exact failure of (G), with a rational threshold interval

Take `d=4`, `v=(1,2,3,4)`, `alpha=1/5`, `beta=1/4`, and
`epsilon=1/5-a`. For `1/6<a<1/5`, the only positive components in `[0,1/2]`
are `[a,(1-a)/4]` and `[(1+a)/3,(1-a)/2]`, up to endpoints. The possible component between
the zeros `1/4` and `1/3` is absent already for `a>1/7`. Reflection gives
the other two components. On the first two, the actual products are respectively

    (t-a)(2t-a)(1-3t-a)(1-4t-a),
    (t-a)(1-2t-a)(3t-1-a)(2-4t-a).

For a short exact integration, put `b=1/5+epsilon`. Around `t=1/5`, the
active product is `(epsilon+u)(epsilon-4u)`, and the remaining product is
`b^2-bu-6u^2`. Its integral is

    (125 epsilon^3/96) [b^2+3b epsilon/8-21epsilon^2/16].

Around `t=2/5`, the active product is `(epsilon+3u)(epsilon-2u)`, and the
remaining product is `b^2-3bu-4u^2`. Its integral is

    (125 epsilon^3/216) [b^2-b epsilon/4-epsilon^2/6].

These follow by the zeroth, first and second moments of the displayed
quadratic active products on their complete positive intervals. Adding both
and reflecting proves the exact formulas

    I_v=(65/432)epsilon^3+(5675/3456)epsilon^4
                              +(17375/20736)epsilon^5,
    Delta_v=(65/216)epsilon^3+(5675/3456)epsilon^4 >0.         (8)

The full H follows by `H_v=-I_v'`; the fifth-degree energy term cancels
exactly in the defect. The accepted complete slow-tuple formula gives

    Delta_s=1/13500+epsilon/225+(13/240)epsilon^2
                                      +(743/1296)epsilon^3. (9)

In particular at `a=1/5`, its values are `J=101/1296000`, `H_s=77/16200`,
and `Delta_s=1/13500`. Both (8) and (9) are exact on `0<epsilon<1/30`.

For `0<epsilon<=1/100`, `L>=3/10` and `beta-a<=3/50`, so

    epsilon L^2 Delta_s/(beta-a) >= epsilon/9000.

On the same interval `65/216+(5675/3456)epsilon<1/3`, so (8) gives
`Delta_v<epsilon^3/3<=epsilon/30000`. Equation (6) now proves

    B_low+R < epsilon/30000-epsilon/9000 <0.                 (10)

Thus (G) fails throughout the explicit rational interval
`19/100<=a<1/5`, including the single admissible test `a=19/100`. The full
defect is positive throughout that interval by (8). Equivalently, near the
endpoint `B_low+R=-epsilon/7500+O(epsilon^2)`, whereas the full defect is
`(65/216)epsilon^3+O(epsilon^4)`. This is an exact obstruction to discarding
the actual lower-count defect in the budget, not a finite-count milestone.

## First unresolved implication and checks

The complete cyclic representation supplies no sign or sufficient lower bound
for R. Bounding it by the independent baseline's coarse guaranteed surplus
is false even on the explicit good tuple above. A successful comparison would
have to control R together with the actual term
`epsilon L^2 Delta_s/(beta-a)`, allowing their cancellation to the smaller
scale of the full defect, or supply a different arithmetic global estimate.
No such coupled control was derived. Formula (1) alone and this restatement
of the remaining budget are not progress closing (E). No separated-fast-speed
theorem, numerical screen, or disconnected formal lemma replaces that step.

All four assigned mathematical inputs were read completely. Current setup
sources and focused state were read; the gate was `research/in_progress`
with explicit 2026-09-05 start authorization and this task recorded.

| Input | SHA-256 |
| --- | --- |
| `research/astra-uniform-strategy-after-fold.md` | `e569596af4ebab9f9d5e1c796d8da435bc433c1c238bc10f9901e644f9f49871` |
| `research/astra-slack-energy-review.md` | `1c526b214e7772088555642447d5fa2f93030f40195fd4aaca7a79bb1f6bd573` |
| `research/astra-rational-cell-compensation.md` | `3304bb071092c71e6516b5c1e16b0d47d918f1c21042f7c47592865d2ac10076` |
| `research/astra-rational-cell-review.md` | `d6f17b4cb2188aa2b552fa30ac7643822dadf45c50dec63479737cc58decf62d` |

`python3 -B scripts/validate_workflow.py` exited zero:
`workflow structural validation passed; it cannot certify mathematical validity.`
All new mathematics was derived or independently checked by hand. Hashes were
checked with `sha256sum`. No mathematical program, numerical sweep, solver,
build, cache operation, external model, additional agent, Git operation,
shared-state edit or other-file write was used. Earlier manuscripts remain
frozen. This new bounded result awaits independent mathematical review.
