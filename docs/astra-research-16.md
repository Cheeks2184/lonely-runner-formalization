# Sixteenth Astra research checkpoint

The denominator-nine four-owner result is now formalized in Lean. For every
natural-number tuple `0<a<b<c<d<p`,
`LonelyRunner.fourLowerOwner_noncover_nine` supplies a candidate on the actual
pivot row outside all four strict bad sets. Its companion
`fourLowerOwner_circleNorm_witness_nine` supplies the same closed `1/9`
witness for `p,a,b,c,d`. Both declarations have arbitrary speed height and
use only the permitted standard axioms. Independent Astra review accepted
the complete source and its exact hypotheses.

The proof separates four exceptional normalized slopes, proves a finite
classification of all 68 required pairs, checks each base remainder in Lean,
and scales pivot and owners together through arbitrary positive multiples.
The actual pivot may share factors with nine. Candidate residues need only
be nonzero modulo nine; they need not be units. When no owner is exceptional,
the four raw counts and a shared bad candidate make the union strictly smaller
than the candidate row. No bounded search replaces the unbounded quantifier.

The full integrated Lean build passed 3,615 jobs, and the trust audit accepted
369 reports with only the permitted standard axioms. It includes five
new public reports: two for the four-owner result and three for the separate
conditional bridge described below. The verification record binds the sources,
reviews, and exact replay counts.

## Conditional canonical bridge

`LonelyRunner.conjecture_of_maxCoveredPivotInternalCoverRedundancy` proves
`MaxCoveredPivotInternalCoverRedundancy → Conjecture`. The premise remains
explicit and unproved. The intermediate positive-integer theorem chooses a
maximum covered pivot under failure of every pivot certificate; all other
owners are then internal. Finite deletion of redundant owners contradicts a
complete cover of its nonempty candidate row. The existing real/integer
reduction supplies the final canonical bridge.

The accompanying finite equivalence states that, on a nonempty candidate
row, internal-cover redundancy is equivalent to the absence of an internal
complete cover. Independent review checked the induction, singleton case,
arbitrary tuple sizes, and the canonical transport. Nonemptiness is sufficient
for the stated equivalence; the review explains that the equivalence itself
can also hold when the row is empty. None of these declarations supplies the
missing redundancy hypothesis or a converse from bare LRC.

## General sparse configurations: manuscript result

For `N>=3`, pivot `p>0`, and `c` lower speeds with `c+1<=N`, set
`H_v(z)=2-z^v-z^(-v)`, `Q=H_p*product(H_d)`, and let `Q_i` omit only the
ith lower factor. Write `A=CT(Q)` and `S=sum_i CT(Q_i)`. The independently
reviewed criterion

```text
A > (2-2*cos(2*pi/N))*S
```

supplies a safe candidate on the actual `Np` grid. The entirely rational
sufficient inequality is `N^2*A>40*S`. The proof uses exact finite Fourier
averaging: the degree bound excludes aliasing, and the pivot factor vanishes
on excluded multiples of `N`. A covered candidate has at least one small
lower factor. This is a manuscript proof, not a new Lean declaration.

The signed-relation expansion yields a uniform class with `q` independent
additive triples `(x,2x,3x)` among the lower speeds, all remaining lower speeds
and the pivot being independent singletons. Under the precise no-cross-block
signed-relation hypothesis, `S/A=(c+q)/2`. For every `c>=5` with `2*c<N`, the
rational criterion follows. Powers of seven realize arbitrarily large such
configurations; no claim is made that arbitrary tuples admit this structure.

At `N=15`, pivot `2303`, and lower speeds
`(1,705,735,1410,1470,2115,2205)`, the exact constants are `A=144`, `S=648`.
The new rational margin is `6480>0`, while the earlier numerical owner-budget
criterion fails. Independent literal enumeration finds 13,204 safe candidates.
Conversely, `N=9`, pivot `5`, and lower speeds `(1,2,3,4)` have `A=12`, `S=44`:
even the exact trigonometric criterion fails, despite an explicit safe candidate.
Thus this sufficient condition does not establish general sparse noncover.
Even a proof for every `2*c<N` would still leave the dense internal-cover
regime needed by the conditional canonical bridge.

## Source trust and reproducibility

The four-owner finite checks use `set_option Elab.async false` to limit peak
memory. Direct inspection of pinned Lean source confirms that this selects
synchronous elaboration while retaining declaration checking. The project's
source filter now allows this exact scheduling option and checks forbidden
constructs throughout comment-masked source. It conservatively rejects ambiguous
interpolated strings and unterminated lexical structures. This is a supplemental
source-policy guard, not a complete Lean parser or a replacement for the kernel
and transitive axiom audit.

Independent review found same-line and interpolated-string failures in two
intermediate implementations; both were corrected before acceptance. The final
candidate passed 540 option cases, 33 forbidden layouts, 16 compiled legal
literal/name controls with 32 rejected appended payloads, and direct positive
and negative `decide +kernel` controls. Root replayed the reported regressions,
kernel controls, 58 focused tests, and all 369 axiom reports. Forcing Lean to be
unavailable ran all ten source-filter tests with only the runtime control skipped.
After verification, coordinated safe cleanup removed 8,151,782,106 bytes of
rebuildable caches while preserving the pinned toolchain and all source/evidence.


- [Four-owner implementation](../LonelyRunner/FourLowerOwnerNine.lean),
  [author record](../research/astra-four-owner-formalization.md), and
  [independent formal review](../research/astra-four-owner-formal-review.md).
- [Conditional bridge](../LonelyRunner/Prompt95CanonicalBridge.lean),
  [implementation record](../research/astra-prompt95-bridge-implementation.md),
  and [independent review](../research/astra-prompt95-bridge-review.md).
- [General sparse manuscript](../research/astra-general-sparse-route.md) and
  [independent review](../research/astra-general-sparse-review.md).
- [Source-filter correction](../research/astra-trust-option-fix.md) and
  [independent review](../research/astra-trust-option-review.md).
- [Verification manifest](../research/astra-pass16-verification.json).

The fixed-denominator theorem protects precisely four lower speeds and their
pivot. The manuscript's structural class and the conditional bridge do not
constitute a full proof or disproof of unrestricted LRC.
