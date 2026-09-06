# Rational-margin certificate implementation

Verified 2026-09-05 under the approved generic contract. The owned module
implements an exact generic rational-margin residue equivalence, a Boolean
finite `Fin n` row checker, its arithmetic and real-circle equivalences,
soundness, and a separately positive-time corollary. It uses
`PivotResidues.circleNorm_nat_div_eq`; it has no N5-specific threshold,
enumeration, `native_decide`, placeholder proof, or restriction on zero
numerators, repeated speeds, or zero speeds.

## Verified result

The module now kernel-checks the approved generic equivalence
`rationalMargin_circleNorm_iff`, the Boolean row arithmetic equivalence,
`rationalMarginRowOK_sound`, the exact real row equivalence
`rationalMarginRowOK_circleNorm_iff`, and the positive-time corollary. The
row checker uses `decide` over a finite `Fin n` proposition; it does not use
`native_decide`. Numerators may be zero and no speed positivity, injectivity,
or margin upper bound is assumed.

Verification completed with:

```text
lake env lean LonelyRunner/RationalMarginCertificates.lean
# exit 0, direct source check
lake build LonelyRunner.RationalMarginCertificates
# exit 0, 3001 jobs
lake env lean /tmp/rational_margin_controls.lean
# exit 0, kernel examples plus type/axiom probes
```

The probe kernel-checks six fixed Boolean examples with `by decide`: mixed
`(4,5,11,24)` at `13/96` and margins `(1/5,1/5,1/5,1/4)`; accepted
zero-margin/zero-speed; rejected genuine above-half margin `3/4` at phase
`1/2`; accepted closed equality at phase `1/4`; and rejected `q = 0` and a
zero denominator. Exact type probes reported only `propext`,
`Classical.choice`, and `Quot.sound` for both core and real-row equivalences.
Source SHA-256 after verification:
`ffe31ce9636281f6c4b8fc2cdf618043a6c02b0195bf75ff6e0aee65c317c1d9`.
