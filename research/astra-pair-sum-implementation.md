# Pair-sum completeness implementation record

2026-09-05. Terra-medium implementation of the settled finite floor-cell
contract in `LonelyRunner/PairSumCompleteness.lean`. The module proves the
fixed-instance witness/certificate equivalence and its positive-integer and
canonical formulation corollaries. It does not prove either conjecture or a
uniform certificate supply.

The focused verification command was:

```text
PATH=/home/joshua/.elan/bin:$PATH lake build LonelyRunner.PairSumCompleteness
```

It exited successfully. The accompanying probe checks every public declaration
introduced by this module and prints its axiom dependencies. Source SHA-256:
`e8b20bf505022f7b098d913d86277134e48e437daa1a1b95913f9f4d194a6708`.
The focused build log is `/tmp/astra-pass28-pair-sum-build.log` and records
exit status zero.

The executed probe was:

```text
#print axioms LonelyRunner.circleNorm_le_abs_sub_int
#print axioms LonelyRunner.int_band_of_circleNorm_ge
#print axioms LonelyRunner.exists_balanced_pairSum_cell_peak
#print axioms LonelyRunner.exists_pairSum_time_of_witness
#print axioms LonelyRunner.pairSumCertificate_of_witness
#print axioms LonelyRunner.exists_witness_iff_pairSumCertificate
#print axioms LonelyRunner.positiveIntegerConjecture_iff_pairSumCertificateConjecture
#print axioms LonelyRunner.conjecture_iff_pairSumCertificateConjecture
```

The probe exited zero. Each of these eight declarations actually reported only
`propext`, `Classical.choice`, and `Quot.sound`.

The implementation keeps all ordered pairs while selecting a finite cell
minimum, including diagonal pairs. A diagonal minimizer is converted to the
distinct original labels `0` and `1`; no speed values are deduplicated. The
floor normalization uses `Int.fract`, and the final certificate numerator is
positive and strictly below its retained pair-sum denominator.
