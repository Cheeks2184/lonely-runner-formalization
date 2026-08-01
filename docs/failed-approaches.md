# Failed approaches and counterexamples

## 2026-08-01: audit of a claimed CRT/LCM proof

Source audited: Bhaskar Kumar, *A Complete Proof of the Lonely Runner
Conjecture*, March 2026, <https://vixra.org/pdf/2603.0086v1.pdf>.

This argument is rejected for several independent reasons.

### Explicit counterexample to Lemma 5.1

Use the paper's strict "good" interval with `n = 6`. Let the existing moduli be
`a1 = 2`, `a2 = 3`, and let `r = 1`. Then

- `1 mod 2 = 1` lies in `(2/6, 10/6) = (1/3, 5/3)`;
- `1 mod 3 = 1` lies in `(3/6, 15/6) = (1/2, 5/2)`.

Thus `r` is good for both old moduli. Their LCM is `B2 = 6`. Add the new,
distinct modulus `a3 = 6`, which divides `B2`. Every permitted update is
`r' = 1 + 6y`, so `r' mod 6 = 1`. But the new good interval is `(1,5)`, and
the residue `1` is not in it. Therefore the induction lemma is false.

The paper's Case 1 observes that the residue is fixed and then silently reasons
about other "compatible residues" that cannot be reached while preserving the
old residue classes.

### Invalid time discretization

For relative integer speeds `b_i` and `D = lcm(b_i)`, putting
`a_i = D/b_i` and `r = Dt` gives `||b_i t|| = ||r/a_i||`. Nothing permits
restricting the real variable `r` to integers. Indeed, if an `a_i` is `1`, no
integer residue can lie in its strict good interval. The claim that multiplying
speeds by a least common denominator makes reciprocal periods integral also has
the scaling direction wrong.

### Wrong boundary

The conjecture uses `>=`, but the manuscript replaces it by strict interior
conditions. The stronger statement is false: the tuple `(1,2)` has maximum
minimum distance exactly `1/3`, never strictly greater than `1/3`.

### Conclusion

The claimed proof cannot be repaired locally: its central induction lemma,
time reduction, and target inequality all fail independently.
