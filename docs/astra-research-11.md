# Pass 11: exact bad residues and the limit of grouped supply

`LonelyRunner/AffineCyclicBadResidues.lean` formalizes the exact forbidden
residues of a corrected affine phase. Write `a*beta=M*k+e`, with `0<=e<M`.
The bad set is `{-k}` modulo `N` when `e=0`, and `{-k,-k-1}` otherwise.
The singleton case preserves the closed upper endpoint. The local equivalence
works for every `N>=2`, positive `M`, and arbitrary natural `a,beta,h`, including
complete wraps, even composite counts, and `M=1`. A separate theorem transports
this criterion to the actual speed under the existing congruence, rounding
identity, and `a<M` hypotheses. It retains the actual offset `s*u+r0*a`.

Independent source review accepted all three public lemmas without correction.
Root reproduced the review's 13 Lean examples, 39,312 local arithmetic cases,
11,907 actual-phase cases and three mutation controls. The integrated full build
passes 3,610 jobs, and the trust audit accepts 354 theorem reports using only
`propext`, `Classical.choice`, and `Quot.sound`. These are arithmetic equivalences;
they supply no good affine parameters by themselves.

The constant-correction audit corrects a proposed obstruction. For the identity
model at `p=5` with speeds `(1,6,11,5)`, the exact ungrouped weighted condition
has precisely six solutions modulo five:

```text
5/11, 1/2, 8/11, 47/11, 9/2, 50/11.
```

An analytic argument excludes every nonintegral open cell; a complete exceptional
point table handles integral corrections, including zero-weight compensation.
Checking only generic two-residue corrections would miss every solution.

Grouping proportional coefficient pairs gives a stronger sufficient condition:
charge the union of their inverse-scaled forbidden sets once per class. The
manuscript proof follows from the existing weighted avoidance theorem, preserves
all original rows and bad directions, and takes whole rounding envelopes before
selecting parameters. For the prototype, the grouped condition holds throughout
`theta in [5/11,1/2]`, whereas the ungrouped condition holds only at isolated
points. At `theta=19/40`, time `59/200` has minimum distance `23/100>1/5`.
A prescribed ceiling formula supplies strictly good times for every `M>=200`,
with corrections allowed to vary. These grouping and interval results are
independently reviewed manuscript mathematics, not new Lean declarations.

The audit also establishes a precise limit on this route. For any fixed positive
integer tuple of size `p-1`, at an odd prime `p`, allowing arbitrary rational
constant corrections in the grouped identity model makes existence of the
certificate equivalent to existence of an ordinary closed LRC witness. The
reverse construction rationalizes a witness using its closed floor intervals,
including singleton intersections, and retains all zero rows, even those
divisible by `p^2`. Thus the unrestricted grouped existence premise does not
resolve the witness problem. A useful continuation needs an a priori bound or
another existence argument, not this equivalence alone.

The independent manuscript replay checks 181 classification atoms, 23 table
entries, 2,016 prescribed roundings, 41,472 proportional systems and 113 reverse
constructions, including 20 singleton floor intersections. Both the source and
manuscript reviews, exact hashes and root reproduction results are bound in
`research/astra-pass11-verification.json`. The only requested manuscript correction
was wording: the ceiling corrections are constant when `5|M` and otherwise vary.

The general grouped whole-envelope theorem has not been formalized in Lean.
Unrestricted witness supply and the canonical Lonely Runner Conjecture remain
unresolved. The subsequent single-step grid-escape audit is not included here.
