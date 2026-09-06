# FiveRunnerMixed exceptional-family implementation

`LonelyRunner/FiveRunnerMixed.lean` now proves the settled public theorem:

```lean
theorem fiveRunnerMixed_exceptional (a H : ℕ)
    (ha : 0 < a) (hH : 3 * a < H) :
    FiveRunnerMixed a (2 * a) (3 * a) H
```

The proof divides by `gcd a H`, proves the reduced coprime family with the
integer coprime grid when the reduced lower speed is at least two, reuses the
normalized `(1,2,3,K)` family at reduced speed one, and normalizes every
witness to positive time.  It introduces no public gcd, divisibility, or
lower-count premise.

Final source SHA-256:
`1e27f19d8906ee0d71b452758a38a7c44fff54e0b1b3c1e08dd5354921eb1eb0`.

Verification completed with actual terminal success:

- `lake env lean LonelyRunner/FiveRunnerMixed.lean`, session `54186`, exit `0`.
- `lake build LonelyRunner.FiveRunnerMixed`, session `94215`, exit `0`, 3002 jobs.
- Final stdin probe, session `13530`, exit `0`: exact theorem type and only
  `propext`, `Classical.choice`, and `Quot.sound`; scaled controls
  `(6,12,18,21)` and `(4,8,12,20)` compiled.

## Historical A1 checkpoint

Before the final wrapper, the normalized theorem
`fiveRunnerMixed_one_two_three (K) (3 < K)` was completed and verified.  Its
case split uses denominator four when available, denominator five residue
classes otherwise, and a direct shifted quarter witness when `20 ∣ K`.
An earlier source-only draft failed while its A1 residue helper was unfinished;
that draft was superseded before the final source and named build above.  No
such incomplete declaration remains in the frozen module.
