# Independent review: fifth Bonferroni relation detection

Task `/root/global_bonferroni_independent_review`; review checkpoint
`76a0ee0f467161e1b6a14794381333fdf2b95850`. The author's assigned checkpoint
was `3c71f4dc668896ff37169570f81bb9c87c899627`. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed task time and usage:
null. Only this review is owned.

**Disposition: accept the complete frozen manuscript at the scope below;
no mathematical correction requested.** The absence of a bounded relation
on at most five labels implies a strict native-good set of Haar measure
greater than 1/30. An almost-everywhere bad cover forces both a primitive
bounded relation and the stated negative aggregate Fourier correction.
These are manuscript results, not kernel results or a global descent.
The exact good controls refute universal positivity of this fifth
functional and show that its failure signatures do not characterize LRC
failure. Unrestricted LRC remains unresolved.

## Exact hypotheses and hand verification

Let n>=6, N=n+1, alpha=1/N, and let all v_i be positive integers. All
integrals below use Haar probability on R/Z and one common actual time.
Put

    A=n*sum_(j=0)^4 binom(n-1,j), M=45*A,
    D=2*(M-1)=90*A-2<=90*n^5-2.

Padding increasing lists of subsets of {1,...,n-1} with initial zeros
injects the subsets of size at most four into {0,...,n-1}^4. This proves
A<=n^5 for every allowed n. The precise hypothesis is absence of a nonzero
integer vector r satisfying

    sum_i r_i*v_i=0, |support(r)|<=5, max_i |r_i|<=D.

Absence with the larger bound 90*n^5-2 is sufficient as advertised in the
introduction. Distinctness, primitive speeds and either minimality are
unnecessary for this implication. Repeated positive speeds violate its
hypothesis via a two-coordinate relation with coefficients 1 and -1.

**The fifth-order baseline and boundaries.** For g(x)=1_{||x||<alpha},
p=2/N, b_i(t)=g(v_i*t), and B=sum_i b_i, Pascal cancellation gives

    P_5(b)=sum_(j=0)^5 (-1)^j binom(B,j)
          =1 if B=0, and -binom(B-1,5) if B>=1.

The binomial coefficient is zero beyond range. Thus P_5(b)<=1_good
pointwise, with good meaning every norm >=alpha. Open bad arcs are
essential to this exact identification at the closed witness boundary.
Every multiplicity is retained; in particular B>=6 contributes negatively.
A bad cover almost everywhere already implies integral P_5(b)<=0.

I checked the falling-factorial expansion

    S_5=sum_(j=0)^5 (-1)^j binom(n,j)*(2/N)^j
       =1/15+4/(3N)-10/N^2+104/(3N^3)-856/(15N^4)+32/N^5.

For an independent positivity check, multiplying S_5-1/15 by 15*N^5
gives

    20*N^4-150*N^3+520*N^2-856*N+480
    =20*(N-7)^4+410*(N-7)^3+3250*(N-7)^2
       +11814*(N-7)+16538 > 0.

The author's shorter grouping is also correct: 856/(5N)<30 for N>=7,
and 4N^2-30N+74=4(N-6)^2+18(N-6)+38>0. Consequently S_5>1/15 is strict
uniformly; no numerical screen or asymptotic substitution is needed.

**Normalized square kernel.** For

    K_M(x)=|sum_(j=0)^(M-1) exp(2*pi*i*j*x)|^2/M,

the Fourier coefficients are a_r=1-|r|/M for |r|<M and zero otherwise.
Orthogonality and the sum of squares give

    c_M=integral K_M^2=1+(2/M^2)*sum_(j=1)^(M-1) j^2
       =(2*M^2+1)/(3*M)>=2*M/3.

Hence J_M=K_M^2/c_M is nonnegative, has mean one and has degree exactly
2(M-1). The last assertion follows from its positive coefficient
a_(M-1)^2/c_M at frequency 2(M-1). Strict positivity at every point is
not needed or asserted by the displayed kernel properties.

The trivial bound K_M<=M and the geometric-sum bound, using
sin(pi*q)>=2q for q=||x|| in (0,1/2], give

    J_M(x)<=min(3*M/2, 3/(32*M^3*q^4)).

At q=0 the first bound applies. Splitting the first moment at
delta=1/(2M), its near part is at most 3/(8M), and its tail is at most

    2*integral_delta^(1/2) 3/(32*M^3*q^3) dq
       =3/(32*M^3)*(delta^(-2)-4)<=3/(8M).

Thus integral ||x||*J_M(x)<=3/(4M). A shortest circular translation changes
an arc indicator only in its two endpoint strips, so
||g(.-x)-g||_1<=2*||x||, including wraparound and measure-zero endpoints.
Convolution f=J_M*g therefore satisfies

    0<=f<=1, integral f=p, ||f-g||_1<=3/(2M).

It is a finite trigonometric polynomial of degree at most D. Expanding
the finite kernel before integration proves f_hat(r)=J_hat_M(r)*g_hat(r),
where g_hat(0)=p and g_hat(r)=sin(2*pi*alpha*r)/(pi*r) for r!=0.
No infinite Fourier convergence claim is required.

**Finite moments and exact total error.** Expanding a product of f(v_i*t)
on a subset J of at most five labels gives only frequencies
sum_(i in J) r_i*v_i with |r_i|<=D. Under the absence hypothesis only the
all-zero frequency contributes to its integral. Its moment is therefore
p^|J|. This is a consequence of the actual frequency equation, not an
assumption that the runner phases are independent.

For products in [0,1], telescoping bounds the absolute difference by the
sum of the individual absolute differences. Integer multiplication of
time preserves Haar probability for every positive v_i, regardless of
injectivity of that map. Hence the corresponding product integrals differ
by at most |J|*3/(2M). Summing all the terms of P_5 gives

    total error <= (3/(2M))*sum_(j=1)^5 j*binom(n,j)
                = (3/(2M))*A=1/30.

It follows in the correct inequality direction that

    measure(good)>=integral P_5(b)>=S_5-1/30>1/30.

Each positive speed has finitely many times modulo one with
||v_i*t||=alpha. Removing their finite union changes no Haar measure and
leaves every norm strictly greater than alpha. Thus the strict version
has the same measure bound and the attained global maximum exceeds alpha.
There is no loss of the shared time or of an original label.

**Contrapositive and the signed total.** Under a bad cover almost
everywhere, the absence hypothesis is impossible. Positive speeds rule
out support one and rule out coefficients of only one sign. Dividing the
resulting nonzero vector by its positive coefficient gcd preserves the
relation, support and bound, yielding the stated primitive relation on
2..5 labels. This normalization does not assert preservation of Fourier
weights. Finitely many bounded coefficient patterns at fixed n do not
bound the magnitudes of their integer-speed solutions.

Without the absence hypothesis, finite expansion gives exactly

    integral P_5(f(v*t))=S_5+Gamma_v.

The manuscript's Gamma includes every nonzero relation vector within
each nonempty subset J of size at most five, with its coefficient product
and sign (-1)^|J|. Allowing zero entries and repeated occurrences across
different J is correct: those occurrences are separate terms of P_5.
Conjugate symmetry makes the sum real. The same total error and an
almost-everywhere cover imply

    S_5+Gamma_v<=1/30,
    Gamma_v<=1/30-S_5<-1/30.

This aggregate inequality does not assign a useful sign to each relation
or identify a primitive term with the same weight. The argument remains
valid for full strict failure, which supplies an everywhere cover.

The no-relation hypothesis is nonvacuous: for B=D+1, the largest nonzero
term of a bounded-coefficient relation among 1,B,...,B^(n-1) has magnitude
at least B^q. All earlier terms together have magnitude at most
(B-1)*sum_(j<q) B^j=B^q-1. They cannot cancel it. This applies for all n
in the theorem's range, and is only a scope check.

## Falsification status and first unresolved implication

For the exact new control n=10, V={1,3,...,19}, alpha=1/11, the arc
E={||t||<1/209} has measure 2/209. Every speed is strictly bad throughout E:
in a centered lift |v*t|<19/209=1/11, without wrapping. Thus P_5=-126
there, and P_5<=1 everywhere else. Consequently

    integral P_5(b)<=-126*(2/209)+1-2/209=-45/209<0.

The same smoothed functional has integral at most
-45/209+1/30=-1141/6270<0. At t=1/2 every speed has norm 1/2, and
continuity supplies an open interval of strict native witnesses. This
refutes universal positivity of this precise fifth functional even on
strictly good tuples. It does not refute the relation-absence theorem or
a mechanism using genuine minimum-failure hypotheses. No such hypotheses
hold for this control.

The sharper logical limitation from V={1,...,n} also checks. A shortest
gap among 0,t,...,nt gives some norm <=1/(n+1), while t=1/(n+1) attains
that margin. Coincident points only make the upper bound immediate. Every
closed native witness must have an equality, so all such witnesses belong
to a finite union of boundary times. The open bad arcs cover almost
everywhere although LRC holds. The relation 1+2-3=0 meets the primitive
bounded-support conclusion, and the negative Gamma bound applies too.
Neither certificate distinguishes strict failure from equality witnesses.

I read the earlier complete weighted Bonferroni audit and accepted review.
Their hold concerns a particular product-weighted sparse pivot-grid
criterion whose mass concentrates on h+1 bad owners. Its refutation is
preserved. It neither disproves this conditional unweighted Haar theorem
nor becomes a proof of universal positivity. Earlier pair, private-repair,
escape-cycle and mixed-sink inputs are used only at their already reviewed
scope; their good controls supply no fully trapped minimal failure. The
energy and normalized phase-Riesz inputs likewise supply no missing sharp
compensation. Their unchanged bindings were checked; no prior mathematical
program was rerun.

The first unresolved implication is from a forced bounded relation,
together with full minimum count and minimum sum, to a smaller admissible
tuple failing at every time or a common original witness. A witness for
the relation's at-most-five-label subtuple does not synchronize the other
labels. The proposed further extraction of a coefficient +1 or -1 is
explicitly unproved; even that coefficient would only remove a division
ambiguity, not supply the missing witness transport. No universal
relation-to-descent lemma, finite height reduction or LRC contradiction is
accepted here. Deferring Lean infrastructure until such an application is
available is a strategic disposition, not a mathematical refutation.

## Source bindings and check receipt

The complete frozen author was read, including both controls, the signed
certificate and the final limitations. All displayed constants and
inequality directions above were derived by hand. The current config,
workflow, policy and focused state were read, including after compaction;
the gate is research/in_progress with explicit start authorization
`2026-09-05T04:12:25.208107+00:00`. The validator
`python3 -B scripts/validate_workflow.py` exited zero with
`workflow structural validation passed; it cannot certify mathematical validity.`

The table binds the frozen author and all sixteen of its bound inputs.
Full owned readback, all table hashes, final newline, absence of trailing
whitespace/CR characters and a final workflow validation are checked at
handoff; the frozen review hash is returned separately. Only administrative
text/hash/workflow checks were executed. There was no mathematical program,
solver, enumeration, Lean run, build/cache operation, new agent, browser
model, Git/shared-state/memory write or other-file edit. The author's
frozen text was preserved; no correction history is being suppressed.

| Bound source | SHA-256 |
| --- | --- |
| `research/astra-uniform-global-transport-strategy.md` | `c6d433ea553cc5507a0faa97387fba75108d15bece45ac14489c879c2078d618` |
| `research/astra-same-parity-pair-descent.md` | `9ccb99d3ef297b5e1e3bb1f0dd6bc20234ff895ebcbe40d362098aaf72903a35` |
| `research/astra-same-parity-pair-descent-review.md` | `4e4d1345ad7ac9cd0a5b027f8ca197d77b394c4ff07fce08487b8ecb6a2a69fb` |
| `research/astra-private-repair-review.md` | `a8aaec8468969723207dc12e9ff2c112a4560c1f51e97f13b43f4e342c849512` |
| `research/astra-positive-candidate-escape-cycles.md` | `d7c8ff0d24f43ce30c272b4eed93686eeaad8b7dfca41449d1f1b22781e7ad49` |
| `research/astra-positive-candidate-escape-cycles-review.md` | `b458336f8e4ce912259d356fcc7971e73400b88838824e2372a5e2163a4f62b7` |
| `research/astra-mixed-candidate-zero-sinks.md` | `c51b493cadda81760e221b8bc747df465d3865e8aa39361e581c3de1672c18eb` |
| `research/astra-mixed-candidate-zero-sinks-review.md` | `4fa7964cdbf91b618cefdf959dda5158274c5872f80b344e168f1309647040a3` |
| `research/astra-slack-energy-global-compensation.md` | `8032d020e4beccc1112b025c8b85f6be6c2ec5cb67cdd763d4ae62a029627cb9` |
| `research/astra-uniform-strategy-after-energy.md` | `ee253b7ade891196bdf213250badac0ddf5992937eba32b625dbc9adb79f506e` |
| `research/astra-phase-riesz-global-contract.md` | `66c83f09a66f169ef9e212d5e5d4ca32acc2fa3732c94def184d4015061ef848` |
| `research/astra-bonferroni-weight-audit.md` | `9116444bc4b55f976a148ecd0431c3032ec4b4d62b7396bd4ed420cc477cfaa0` |
| `research/astra-bonferroni-weight-review.md` | `35a5db5bad8a895743491ac2f84dc45d2d25cc1c18c6b50680144dcf15f7f625` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |
