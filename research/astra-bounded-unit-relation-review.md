# Independent review: bounded unit-relation diagnostic

Task `/root/bounded_unit_relation_review`; source checkpoint
`76a0ee0f467161e1b6a14794381333fdf2b95850`. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed task time and usage:
null. Only this review is owned.

**Disposition: accept the complete frozen manuscript without correction.**
The control refutes extraction of a count-bounded unit relation from the
full fifth Fourier signature, even with every one-deletion gcd equal to
one. It does not refute extraction from actual strict failure and full
minimality. This is an independently checked manuscript obstruction,
not a kernel result or a resolution of unrestricted LRC.

## Independent hand derivation

Fix r=2500, n=2r=5000, N=n+1, alpha=1/N, and the accepted global
manuscript's exact A_n, M_n=45*A_n and D=D_n=2(M_n-1). For any integer
H>=D put B=30H+1 and

    V={2B^j,3B^j:0<=j<r}.

The two bounds have different roles: D is the unchanged smoothing degree
at this fixed n; H is the arbitrarily large coefficient bound excluded
for unit relations. Since B>=2, the successive blocks satisfy
2B^j<3B^j<2B^(j+1). The n speeds are positive and distinct, and their gcd
is one because the first block contains 2 and 3.

**Exact integer relations and gcds.** Write a relation as
sum_j B^j(2a_j+3b_j)=0, with |a_j|,|b_j|<=H. Each digit has absolute
value at most 5H<B-1. If q is the largest nonzero digit, its contribution
has magnitude at least B^q, whereas the earlier digits together have
magnitude at most

    5H*sum_(j<q) B^j=(B^q-1)/6 < B^q.

This is impossible. Thus every digit vanishes and
a_j=3h_j, b_j=-2h_j for integers h_j. Every nonzero coefficient has
absolute value at least two. This excludes coefficients +1 and -1 in
the entire H box, without any restriction on the relation's support.
It does not exclude nonzero bounded relations: within a block the
primitive pair (3,-2) is available.

B is 1 modulo 6. Deleting any label beyond the first block leaves 2
and 3. Deleting 2 leaves 3 and 2B, whose gcd is one; deleting 3 leaves
2 and 3B, whose gcd is one. Hence every single-deletion gcd is one.
B is also 1 modulo 5, so at the common actual time t=1/5 every norm is
2/5>alpha. Its actual maximum is exactly 2/5: the first speed imposes
||2t||>=2/5 only on [1/5,3/10] union [7/10,4/5] modulo one, and
||3t||>=2/5 holds on [2/15,1/5], [7/15,8/15], [4/5,13/15]. Their
intersection consists exactly of 1/5 and 4/5. Both times work for all
blocks, so these are also all global maximizing times modulo one. The
tuple is strictly native-good and has no actual strict failure or
minimum-failure property.

There is no claim that unbounded unit relations are absent. In fact

    2+(20H)*3-2B=0

is a relation on three distinct labels, with coefficients 1,20H,-1.
It lies outside the H box, as required.

**The product-torus fifth moment.** Let g(x)=1_{||x||<alpha}, p=2alpha.
On a single circle the bad sets for 2x and 3x have centers on their
respective rational grids and radii alpha/2 and alpha/3. Distinct centers
from the two grids have circular distance at least 1/6. Since
5alpha/6<1/6, their arcs can intersect only at the common center zero.
That intersection has radius alpha/3 and measure

    q=integral g(2x)g(3x)=2alpha/3=p/3.

Open endpoints cause no measure change. Both individual means are p,
so one block has the exact generating polynomial

    integral (1-z*g(2x))*(1-z*g(3x))=1-2p*z+(p/3)*z^2.

On the independent r-dimensional torus, the integral T_r of P_5 on
these 2r labels is the sum of coefficients through degree five in
(1-2p*z+(p/3)*z^2)^r, evaluated at z=1. This independence is used only
for this auxiliary product-torus calculation.

Choose s blocks contributing the linear term and d blocks contributing
the quadratic term, with s+2d<=5, and set k=s+d. The corresponding
contribution is exactly

    C_sd*eta_k,
    C_sd=(-2)^s/(3^d*s!*d!),
    eta_k=product_(h=0)^(k-1)(1-h/r)*(2r/(2r+1))^k.

This follows from the multinomial factor (r)_k/(s!*d!) and rp=2r/(2r+1).
All k lie in 0..5. Combining the factors also gives the source's exact
form eta_k=product_(h=0)^(k-1)[1-(2h+1)/(2r+1)]. Its factors lie in
[0,1], so the elementary product-complement bound gives

    0<=1-eta_k<=sum_(h=0)^(k-1) (2h+1)/(2r+1)
                 =k^2/(2r+1)<=25/(2r+1).

The limiting signed sum can be grouped by d=0,1,2:

    sum C_sd=1/15-1/9-1/18=-1/10.

Independently summing the absolute coefficients in those same groups gives

    sum |C_sd|=109/15+19/9+1/6=859/90<10.

Thus |T_r+1/10|<250/(2r+1)=250/5001<1/20 and T_r<-1/20. The strict
sign follows from the explicit finite-r error; there is no limiting
substitution or numerical enumeration.

**Finite smoothing and the actual one-time signature.** Use exactly the
previous manuscript's nonnegative mean-one normalized-square kernel and
f=J_M*g of degree at most D, satisfying 0<=f<=1 and
||f-g||_1<=3/(2M). On the product torus, telescope each product through
order five. Each individual 2x_j or 3x_j map preserves circle measure.
The total error is at most

    (3/(2M))*sum_(j=1)^5 j*binom(n,j)=3*A_n/(2M)=1/30.

Therefore its smoothed P_5 integral is less than -1/60.

For a finite Fourier term of P_5 on the actual tuple V, the one-time
zero-frequency condition is

    sum_j B^j(2a_j+3b_j)=0, |a_j|,|b_j|<=D.

Because D<=H, the same digit argument makes this equivalent to the
individual block equations 2a_j+3b_j=0. These are precisely the
zero-frequency conditions on the independent product torus. The
coefficients agree term by term, so the two smoothed P_5 integrals are
equal. This uses finite Fourier expansion only; it does not identify
the unsmoothed one-time indicators with independent variables.

Using the accepted exact identity integral P_5(f(v*t))=S_5+Gamma_v gives

    S_5+Gamma_v<-1/60,
    Gamma_v<-1/60-S_5<1/30-S_5,
    Gamma_v<-1/12<-1/30.

The second line verifies the full cover-derived signed inequality,
not merely its weaker consequence Gamma_v<-1/30. The third uses
S_5>1/15. D, the error budget and this bound remain fixed as H grows.

**The separate deletion-gcd necessity.** A primitive least-count failure
at native width alpha<=1/4 must have every one-deletion gcd equal to one.
Indeed, suppose all survivors share gcd d>1. A smaller-count witness
has all survivor norms at least beta=1/n>alpha. Shifts t+k/d preserve
these survivor phases. The removed speed is coprime to d by full
primitivity, so its shifted phases visit a translate of the complete
d-point grid. One grid point lies within 1/(2d) of a half-integer;
its norm is at least

    1/2-1/(2d)=(d-1)/(2d)>=1/4>=alpha.

Together with the preserved survivor bounds this is an original closed
witness, a contradiction. The stated setting n>=6 satisfies the width
condition. The argument neither requires a centered grid nor promises
floor(d/2)/d for an arbitrary translate. It uses genuine smaller-count
witness supply and primitivity; those are not consequences of Gamma.

This is already the primitive specialization of Proposition 1 and
Corollary 2 in the bound divisor manuscript, not a new consequence of
the Fourier computation. The actual generic Lean declarations match
their cited roles. `exists_nat_shift_preserving_divisible_family` takes
an arbitrary retained index type, a divisor ell>=2, an exceptional speed
not divisible by ell, divisibility of every retained speed, and any real
t. It preserves all retained norms and supplies a quarter-margin at the
same shift. `exists_nat_rational_shift_circleNorm_ge_mesh` gives the
exact reduced orbit margin for ell/gcd(ell,d). In the present primitive
specialization that orbit size equals the deletion gcd. Neither source
invocation substitutes a fixed-count wrapper for lower-count supply.
These declarations and their source proofs were read, not recompiled.

Conversely, gcd one for each deletion complement lets Bezout express
the negative of any chosen speed using integer multiples of the others.
Putting coefficient one on that speed produces a unit relation, with
no magnitude or support bound supplied by Bezout. This is consistent
with the explicit relation and the absence result inside the H box.

## Precise scope

The family simultaneously has positive distinct primitive speeds, every
single-deletion gcd one, the full signed bound from an almost-everywhere
cover, and no unit relation within the H box. As H can exceed any proposed
coefficient bound at the fixed count n=5000, those hypotheses alone
cannot force a unit relation with any bound depending only on n, even
if the support restriction is removed. The explicit three-label relation
above confirms the distinction from absence of all unit relations.

The control's strict witness rules out actual cover and actual minimal
failure. It therefore refutes the signature-only extraction proposal,
including its deletion-gcd strengthening, but does not refute an
extraction using the full strict-failure/minimality assumptions. It also
does not refute the accepted bounded nonzero-relation detector.
The first unresolved implication remains a justified use of full
minimum count and minimum sum, beyond these necessary signatures, to
construct a failure-preserving smaller tuple or a common original
witness. No such global transport or unrestricted LRC result is proved.

## Source bindings and check receipt

The frozen author was read completely, including its sharper eta bound,
actual maximum, full signed inequality, unbounded unit relation and scope
paragraph. All its mathematical claims were checked by hand. The accepted
global manuscript and its review are unchanged and their evidence is
reused at the displayed kernel/moment scope. The divisor manuscript was
read in full; its embedded historical computation was not executed.
The two bound Lean files were read, including the cited declarations and
proofs; this is a source-scope check, not a new trust or compilation run.

Current config, workflow, policy and focused state were read. The setup
gate is research/in_progress with explicit start authorization
`2026-09-05T04:12:25.208107+00:00`. The command
`python3 -B scripts/validate_workflow.py` passed with
`workflow structural validation passed; it cannot certify mathematical validity.`
The table binds the frozen author and all nine of its inputs. Final full
review readback, exact hash comparison, final newline, absence of trailing
whitespace/CR characters and workflow validation are checked at handoff;
the frozen review hash is reported separately.

Only administrative text/hash/workflow checks were executed. No
mathematical program, enumeration, solver, build, dependency/cache
operation, new agent, external model, Git/shared-state/memory write or
other-file edit was performed. The author was not edited. No correction
was requested or omitted from the review history. Runtime accounting
remains null.

| Bound source | SHA-256 |
| --- | --- |
| `research/astra-bounded-unit-relation-diagnostic.md` | `5c68faac8901bde8e82cb564b3c4ff8dc4918bd08240873e6bbd1047a72c1ba7` |
| `research/astra-uniform-global-transport-strategy.md` | `c6d433ea553cc5507a0faa97387fba75108d15bece45ac14489c879c2078d618` |
| `research/astra-uniform-global-transport-strategy-review.md` | `5eb21ae36164e68f29ac1ce0f70ca897cbfe558165cc90d8a2de3ee982ca98f7` |
| `research/astra-uniform-divisor-minimality.md` | `8c4b6ee094f0f311f360d3abf371e95f731e28cee997d3810dd3218ff6f25746` |
| `LonelyRunner/RationalShiftGcd.lean` | `6e9d1e3e084188a651e4c875cf36fd5d6fc7cbd5f1914784019a207a0cec01f4` |
| `LonelyRunner/RationalShiftInsertion.lean` | `6ab6e77e8f5edcdc2a2d242fb2616327004b376496616f46896303a06876db23` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |
