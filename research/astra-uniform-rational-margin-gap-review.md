# Independent review of the rational margin gap

Date: 2026-09-06. Task `/root/uniform_rational_margin_gap_review`, executed by
`/root/uniform_screen_review`; requested Astra/xhigh. Runtime model, effort
and usage are not independently exposed. Source checkpoint supplied by root:
`665a35f68d468be388e4bc3a7538ff3e8c8a9cd3`. Only this review file is owned.

**Accepted after one scope wording correction.** The lifting lemma, its
strict-threshold formulation, and the positive-length equivalence and lower
bound are mathematically valid under the stated assumptions. No further
correction is required in the final frozen manuscript. These are conditional
witness-conversion results; the uniform witness supply remains unresolved.

The manuscript was read in full. The final scope correction was read back,
and these actual SHA-256 bindings matched:

```text
bf6e76bc38608d0255b3567ce1d67c26ac474f02e010f20a13c6601a1997e980  research/astra-uniform-rational-margin-gap.md
838a3bcec806b0e9d01cd117e64e5348de58a05127a3f7bef5dbe2d879ff292f  LonelyRunner/PairSumCompleteness.lean
0e3f10f64daf41bedebf31bb71cb6b93ffa5358615c6c30ec941b01fc97b9d57  LonelyRunner/EndpointCompleteness.lean
3a4a825f3f801282eb39b469571bbd4cac3a4e1f768d58542b7c1555cd725524  research/astra-uniform-global-seed-geometry.md
```

The prior manuscript hash was
`0d83ae89d78e59e5cf45b5497f2d12d0768b5f8927ca1e514895cda8c921845d`.
Review identified that its sentence about a fixed proportional loss could
overstate the limitation of this particular estimate. Root corrected it to
say that this denominator-gap estimate does not justify such a loss uniformly,
and explicitly disclaimed optimal or necessary precision and impossibility
of other conversions. The algebra and source dependencies were unchanged.

**Exact source contract.** The inspected
`exists_pairSum_time_of_witness` takes `n>=2`, a natural-speed tuple with
every speed positive, a positive real margin, and one supplied real witness
at that closed margin. It returns distinct labels `p,q` and a natural `r`
with `0<r<v_p+v_q`, preserving the supplied margin for every coordinate at
`r/(v_p+v_q)`. It requires neither injectivity nor primitivity, a lower-count
theorem, seed nonemptiness, or a global time maximizer. The implementation
reduces the supplied time modulo one and uses a finite floor-cell peak.
Its handling of coincident active labels supplies two distinct labels rather
than weakening that conclusion.

The manuscript uses this common-margin theorem, not the later reciprocal-
integer-margin specialization. Thus applying it at the real margin alpha,
or at a newly chosen real beta, is licensed by the actual declaration.
`EndpointCompleteness.lean` was also inspected: its endpoint has the form
`(k+margin_p)/v_p`. That separate result is not needed for the lifting proof
and alone would not give the claimed pair-sum denominator bound.

**Gap arithmetic and its boundary.** Here `n=N-1>=2`, so `N>=3`. Distinct
positive integer speeds give two largest values `M>M_2>=1`, with
`S=M+M_2>=3`. In particular

```text
epsilon = 1/[N(S+1)] > 0,
alpha = 1/N-epsilon = S/[N(S+1)] > 0.
```

The source theorem applies to an alpha witness. Its distinct labels imply
`D=v_p+v_q<=M+M_2=S`, and positivity gives `D>0`. No reduced-denominator
claim is necessary. If `a_i` is the residue of `v_i*r` modulo D, then
`0<=a_i<D` and the coordinate norm is exactly
`b_i/D`, where `b_i=min(a_i,D-a_i)` is a nonnegative integer. This includes
zero residues and antipodal residues when D is even.

If `b_i/D<1/N`, the integer `D-N*b_i` is positive, hence at least one. Thus

```text
1/N-b_i/D >= 1/(N D) >= 1/(N S) > 1/[N(S+1)] = epsilon.
```

The preserved inequality `b_i/D>=alpha` makes the same difference at most
epsilon, a contradiction. Every coordinate at the returned pair-sum time
is therefore delta-good. Equality with delta is retained; no strict target
witness is being claimed. This proof supplies a possibly different time
from the original alpha witness.

For the strict formulation put `c=delta-1/(N S)`. Since `S>=3`, `c>0`.
If every norm at some t exceeds c, their finite minimum m also exceeds c.
Choose, for example, `beta=(c+m)/2`. Then `0<beta<=m` and `beta>c`.
Pair-sum completeness supplies a candidate with every norm at least beta.
Any norm below delta would, by the same integer argument, be at most c,
which is impossible. Conversely every delta witness has every norm strictly
greater than c. This proves the asserted equivalence.

At the excluded closed boundary `b_i/D=c`, that last contradiction would
disappear. The strict sign is therefore necessary for this displayed
argument. The report correctly asserts neither an actual failing tuple at
that boundary nor optimality of the gap. The chosen closed alpha lies
strictly above c, explaining why closed alpha is sufficient.

**Positive length and periodicity.** The inclusions of margins and the
lifting lemma first give `H_delta` nonempty iff `H_alpha` nonempty. If u
is a delta witness and `a=epsilon/M`, then for every `|h|<=a`,

```text
||v_i(u+h)|| >= ||v_i u||-v_i |h|
             >= delta-M a = alpha.
```

Thus the entire closed interval `[u-a,u+a]` is alpha-good. Its image on the
circle has length `2a=2/[N M(S+1)]<1`; if represented across a period cut,
the pieces have that same total length. Integer-speed periodicity justifies
working modulo one, and endpoints have zero length. Each alpha-good set is
a finite union of closed phase bands on one period; their finite intersection
is measurable even when some components are singletons.

Consequently nonemptiness implies the stated quantitative lower bound on
`mu(H_alpha)`, and positive measure implies nonemptiness. If the starting
information is merely an alpha witness, this expansion is applied at the
delta witness obtained by lifting. It does not assume the original alpha
point already has a two-sided alpha-good neighborhood. In particular a
nonempty null `H_delta` is allowed, whereas `H_alpha` cannot be nonempty
and null at this chosen precision.

**Remaining obligation and limits.** To use this conversion for a uniform
result, one still needs to prove, for every admissible tuple, the existence
of an alpha witness or equivalently `mu(H_alpha)>0` at the tuple-dependent
alpha above. The quantitative lower bound is conditional on such existence;
it supplies no unconditional positive measure. A conditional finite-height
bound can give a common sufficient precision within its bounded family,
but does not supply witnesses there.

Nor is Q implied: the returned delta witness is not shown to lie in any
protected deletion-seed union. The source theorem preserves the common
margin, not membership in that additional union. This is an alternative
ordinary-witness target, not a proof of the stronger protected-seed claim.
Replacing delta by alpha in the earlier coarse extension accounting scales
both its shell budget and extension bound by `gamma-alpha`; cancellation
still leaves no positive-length supply. Additional information could change
that situation; no impossibility claim about other arguments is established.

**Actual checks.** Current project config, workflow, policy and focused task
state were read. The standalone command
`python3 -B scripts/validate_workflow.py` exited 0 with complete output:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

All source-hash checks exited 0. The displayed deductions were checked
algebraically against the actual source contracts. No mathematical program,
enumeration, Lean command, dependency/cache operation, Git command, or
shared-state mutation was performed. No other file was edited and no worker
was delegated. This is manuscript acceptance with a plausible route to a
Lean corollary; it is not a newly kernel-checked declaration.
