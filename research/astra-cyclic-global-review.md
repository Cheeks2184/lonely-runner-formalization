# Independent review of the cyclic compensation budget

Task `/root/cyclic_global_review`; requested `gpt-6-astra/xhigh` on the
existing reviewer session. Observed model, effort, elapsed time and usage:
`null`. Assignment checkpoint `67855fbcf3e7f8ba4a072374d41d5c541166caee`.
Only this review is owned. The complete frozen author is
`research/astra-cyclic-global-compensation.md`, SHA-256
`06b3eabe5f9b8031801faa9d8f6aedd5a7d43f048bbd90656b0804943f8b3088`.

**Accept without corrections at the stated manuscript scope.** The full
cyclic formulas, baseline identity, progression asymptotics and exact
four-speed integration check. The proposed estimate (G) is false on the
entire stated rational threshold interval; the full defect there is positive.
Neither (E) nor unrestricted LRC is refuted or proved by this result.

## Complete cyclic integration and common residues

Retain distinct positive primitive speeds `(v_1,...,v_(d-1),M)`, with M
largest, `d>=2`, and `0<a<alpha=1/(d+1)`. Write `L=1/2-a`, and use the
author's full slow product F, derivative integrand Q, and means J and H_s.
For `T_M F(x)=M^(-1) sum_{k=0}^{M-1} F((k+x)/M)`, substitution on the M
actual time intervals gives exactly

    I_v=integral h_a A_M,
    H_v=integral [chi_a A_M+h_a D_M],
    integral A_M=J,   integral D_M=H_s,

where `A_M=T_M F` and `D_M=T_M Q`. Off finitely many threshold equations,
`-partial_a F=Q`. The finite average preserves that identity off finitely
many x values. Bounded product difference quotients justify integration;
the derivative of the fast factor is the required `chi_a A_M` term.
No independent-residue choice or missing derivative is present.

Cyclic reindexing proves periodicity. For an integer ell, substituting
`x=Mt-k` in the Fourier integral cancels `exp(2pi i ell k)`, giving
`(T_M F)_hat(ell)=F_hat(M ell)`. Applying the finite geometric sum to the
absolutely summable tent product retains exactly the vectors with
`M divides sum_{i<d} v_i r_i`, with sign `(-1)^(sum_i r_i)` and exponential
`exp(2pi i x sum_i v_i r_i/M)`. This verifies every alias term in the
author's formula (3), including the zero relation. The operator identity
also applies to the integrable Q; no differentiated Fourier series is needed.

The common-residue example is exact. At `(1,2,3)`, `a=1/5`, `x=1/2`, the
three original times are `1/6,1/2,5/6`. Speed one is above a only at the
middle time; speed two is above a only at the other two. Hence their product
average is zero, while their separate slack averages are `1/10` and `4/45`.
Keeping all residues does not make those rows independent.

## Baseline, lower-count hypothesis and exact extra reserve

Put `epsilon=alpha-a`, `beta=1/d`, and

    I_bar=L^2 J,   H_bar=2LJ+L^2 H_s,
    Delta_s=dJ-(beta-a)H_s,
    B_actual=(d+1)I_bar-epsilon H_bar,
    R=Delta_v-B_actual.

These definitions use the slow tuple's native coefficient d and margin
beta, while the full defect uses d+1 and alpha. Direct substitution proves

    C_d=d+1-2epsilon/L-d epsilon/(beta-a),
    B_low=L^2 J C_d,
    B_actual=B_low+epsilon L^2 Delta_s/(beta-a).             (1)

The derivative and endpoint are exactly

    C_d'=2(1/2-alpha)/L^2+d(beta-alpha)/(beta-a)^2>0,
    C_d(0)=(2d-3)/(d+1)>0.

Thus lower-count (E), if assumed, supplies `Delta_s>=0` and `J>0` on this
range, so `B_actual>=B_low>0`. Removing a gcd from the slow tuple preserves
both means by integer time scaling. For `d=2`, the one-speed identity
`J=L^2`, `H_s=2L`, `Delta_s=0` directly supplies the stated base case.

The proposed inequality `R>=-B_low` is exactly

    Delta_v >= epsilon L^2 Delta_s/(beta-a).                (2)

Under the lower-count hypothesis it would imply full (E). It demands more
than the nonnegative full defect itself. The author correctly retains the
complete R and identifies the additional actual slow defect as the reserve
that its coarse budget tries to leave unused.

## Progression maxima and both asymptotics

For `(1,...,d)`, let `N=d+1`. If two of `0,t,...,dt` coincide, one of the
required norms is zero. Otherwise a shortest cyclic gap is at most 1/N
and comes from a speed difference in `{1,...,d}`, proving the upper bound.
At maximum 1/N every cyclic gap must be at least 1/N, hence all are equal.
It follows that `t=k/N` and `gcd(k,N)=1`; conversely each such time attains
the bound. This proves the complete maximizing set used by the author.

Let r be the inverse of k modulo N in `{1,...,N-1}`, and `s=N-r`.
The only two minimal coordinates have residues 1 and -1 modulo N. Their
slacks near this time are `epsilon+ru` and `epsilon-su`; all other slacks
remain strictly positive. Their common interval is
`-epsilon/r<u<epsilon/s`. Its width is `epsilon N/(rs)`, so integration
of the quadratic gives `epsilon^3 N^3/(6r^2s^2)`.

Multiplication by the remaining slacks contributes their positive limiting
product plus `O(epsilon)`. The limiting product is independent of k because
multiplication by k permutes all nonzero residues. It is precisely

    product_{m=2}^{N-2} (min(m,N-m)-1)/N.

Compactness excludes the complement of neighborhoods of the finitely many
maxima when epsilon is small. Summing the local integrals proves the stated
positive coefficient c_d and `I=c_d epsilon^3+O(epsilon^4)` at each fixed d.
For H, the sum of the two active deletion products has leading integral
`3 c_d epsilon^2`; replacing the other factors by their limiting constants
costs `O(epsilon^3)`, as do all deletions of a nonactive coordinate. This
justifies `H=3c_d epsilon^2+O(epsilon^3)` directly, including possible
half-phase corners among nonactive coordinates. No derivative of an
unspecified big-O remainder is being inferred. The constants reduce to
`c_2=9/4`, `c_3=16/27`, and `c_4=65/432`.

The slow progression has a 1/d witness strictly above alpha, so continuity
gives `J(alpha)>0`. Its energy and derivative remain finite there. Therefore
`K=I/(L^2J)` is a positive constant times `epsilon^3(1+O(epsilon))`, and
`-K'/K=3/epsilon+O(1)`. This refutes the proposed *nondecreasing* K in a;
it is not a claim refuting every possible monotonicity of K.
Also `B_actual` tends to a positive constant and `Delta_v` tends to zero,
so `R/B_actual -> -1`. Every fixed fractional bound
`R>=-eta B_actual`, `eta<1`, fails near this endpoint.
The expansion `Delta_v=(d-2)c_d epsilon^3+O(epsilon^4)` has the stated scope;
at d=2 its leading coefficient vanishes and does not assert a new sign.

## Exhaustive four-speed integration and slow defect

For `(1,2,3,4)` and `1/6<a<1/5`, intersecting the row conditions in
`[0,1/2]` gives exactly `(a,(1-a)/4)` and
`((1+a)/3,(1-a)/2)`, up to endpoints. The potential middle interval
`((1+a)/4,(1-a)/3)` would require `a<1/7` and is absent. The branches
on the two surviving intervals give precisely the two products displayed
in the author. Reflection accounts for the other half of the period.

Around 1/5, the active interval is `[-epsilon,epsilon/4]`; its quadratic
weight has mass `125epsilon^3/96`, mean `-3epsilon/8`, and second moment
`7epsilon^2/32`. Averaging the other product `b^2-bu-6u^2`,
`b=1/5+epsilon`, gives the author's first integral. Around 2/5 the active
interval is `[-epsilon/3,epsilon/2]`; the corresponding mass, mean and
second moment are `125epsilon^3/216`, `epsilon/12`, and `epsilon^2/24`.
These give its second integral from `b^2-3bu-4u^2`.

The two remaining averaged polynomials expand respectively as

    1/25+(19/40)epsilon+(1/16)epsilon^2,
    1/25+(7/20)epsilon+(7/12)epsilon^2.

Combining their masses and reflecting proves

    I=(65/432)epsilon^3+(5675/3456)epsilon^4
                              +(17375/20736)epsilon^5,
    Delta_v=(65/216)epsilon^3+(5675/3456)epsilon^4>0.         (3)

Indeed `H=dI/d epsilon`; the degree-five term cancels in `5I-epsilon H`.
There is no omitted positive component or endpoint derivative term.

For the slow tuple `(1,2,3)`, the accepted full formula on this range has
`delta=1/4-a=1/20+epsilon` and no `(1/6-a)_+` term. Its defect is

    2[(8/27)delta^3-(5/288)epsilon^2-(25/2592)epsilon^3].

Expanding gives exactly
`1/13500+epsilon/225+(13/240)epsilon^2+(743/1296)epsilon^3`.
Substitution in its energy and derivative at `a=1/5` independently gives
`J=101/1296000`, `H_s=77/16200`, `Delta_s=1/13500`.

## Rational interval, precise falsification and remaining implication

For `0<epsilon<=1/100`, use `L>=3/10`, `beta-a<=3/50`, and
`Delta_s>=1/13500`. The extra reserve in (2) is at least `epsilon/9000`.
Meanwhile `65/216+(5675/3456)epsilon<1/3`, so (3) is less than
`epsilon^3/3<=epsilon/30000`. Thus

    B_low+R=Delta_v-epsilon L^2 Delta_s/(beta-a)
       < epsilon/30000-epsilon/9000 < 0.

This proves the failure of (G) on every `19/100<=a<1/5`, including the
left endpoint, while (3) proves a strictly positive full defect there.
At the excluded right endpoint epsilon is zero and this strict conclusion
is not asserted. The linear coefficient of the reserve is
`(3/10)^2(1/13500)/(1/20)=1/7500`, verifying the stated endpoint comparison
`B_low+R=-epsilon/7500+O(epsilon^2)` with a cubic positive full defect.

The missing implication remains a bound on the *coupled* complete correction
and actual slow-defect contribution, or another proved global estimate.
The cyclic identity by itself supplies no such bound. The counterexample
rejects (G) and the stated stronger monotonicity/fractional-reserve shortcuts;
it leaves (E) and the unrestricted canonical goal unresolved. No new approach
or formal implementation is introduced by this review.

## Complete bindings and actual checks

The author was read completely and all calculations above checked by hand.
All four bound mathematical inputs were fully read in this session and
checked unchanged; the relevant full slow-energy formula was verified at
the scope used here. Current config, workflow, policy and focused active
state were read. The gate was `research/in_progress`, with recorded explicit
2026-09-05 start authorization and this review task active.

| Complete source | SHA-256 |
| --- | --- |
| `research/astra-cyclic-global-compensation.md` | `06b3eabe5f9b8031801faa9d8f6aedd5a7d43f048bbd90656b0804943f8b3088` |
| `research/astra-uniform-strategy-after-fold.md` | `e569596af4ebab9f9d5e1c796d8da435bc433c1c238bc10f9901e644f9f49871` |
| `research/astra-slack-energy-review.md` | `1c526b214e7772088555642447d5fa2f93030f40195fd4aaca7a79bb1f6bd573` |
| `research/astra-rational-cell-compensation.md` | `3304bb071092c71e6516b5c1e16b0d47d918f1c21042f7c47592865d2ac10076` |
| `research/astra-rational-cell-review.md` | `d6f17b4cb2188aa2b552fa30ac7643822dadf45c50dec63479737cc58decf62d` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

`python3 -B scripts/validate_workflow.py` exited zero:
`workflow structural validation passed; it cannot certify mathematical validity.`
Administrative checks bind these nine inputs and the owned file and check
the final newline and trailing whitespace. No mathematical program, sweep,
build, cache operation, external model, additional agent, Git operation,
shared-state write or other-file edit was used. No mathematical correction
to the frozen author was needed; this is a manuscript review, not a kernel proof.
