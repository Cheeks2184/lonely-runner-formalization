# Thirty-third Astra checkpoint: four-runner mixed classification

This checkpoint records the complete natural-speed four-runner mixed
classification and two independently reviewed research screens. The unrestricted
Lonely Runner Conjecture remains unresolved.

## Complete natural triple classification

For positive natural speeds `0<a<b<H`, `FourRunnerMixed a b H` means that
one positive real time satisfies

```text
||a t|| >= 1/4,  ||b t|| >= 1/4,  ||H t|| >= 1/3.
```

The new classification is

```text
FourRunnerMixed a b H  <->  not (b=2*a and H=3*a).
```

It concerns four total runners with the chosen runner stationary and the
stronger margin assigned to the fastest of the three positive moving speeds.
The final statement has no primitive, finite-height, or lower-count premise.
A separate corollary accepts a strict ordinary quarter witness at any real
time and supplies a positive mixed witness, possibly at a different time.

The primitive finite branch uses the sharper bound `choose(4,2)^2=36`.
Thirty-four fixed rational candidates cover every eligible triple in `Fin 37`.
The proof checks the full quantified finite domain by ordinary kernel `decide`,
split into 37 private fixed-height declarations in one module. It retains
positive numerator and denominator tests and all six closed residue bands.
The exact controls counted 6,079 primitive increasing triples, with 6,078
positive cases and only the exception `(1,2,3)`.

For heights above 36, the existing mixed-height theorem applies to
`![0,a,b,H]`. Its lower-count hypothesis is discharged using the existing one-
and two-moving-runner results. Positive gcd division then transports the
primitive result to every positive increasing natural triple.

The exceptional-family proof folds an arbitrary real phase into its distance
from the nearest integer. The first two quarter bounds force that distance
into `[1/4,3/8]`, so the third norm is at most `1/4`, below the mixed third
threshold. Strict ordinary bounds make the third norm strictly below `1/4`.
This treats every real time and every natural scale. It does not refute LRC:
the exceptional family has an ordinary closed witness at `1/(4*a)` for `a>0`.

## Reviewed research accompanying the formal result

The modular-unit audit proves at manuscript scope that a direct denominator
implies a fastest mixed witness when the total count is five or at least seven.
It handles nonunit fastest residues separately and explains why counts three,
four, and six need exceptions. The global consecutive-family failures at those
counts do not have strict ordinary witnesses.

The two-paper tight-family screen found no additional mixed obstruction in
the stated Goddyn–Wong acceleration and sporadic classes or Kravitz near-tight
class. Its coverage comparison is explicitly about primitive bases and the
normalized remaining domain. Positive scaling can destroy the direct condition
while preserving the height ratio: `(12,24,72)` is a covered comparable-height
raw example, but inherits its mixed witness from `(1,2,6)`. The screen therefore
does not expand the remaining normalized comparable-height coverage.

These manuscripts neither prove uniform mixed supply nor settle arbitrary
tight configurations. Proposed ordinary and canonical real count-four bridges
are separate future work, outside this checkpoint's formal claim.

## Verification

The final full source build passed with 3,640 jobs reported, including cached
targets. The trust audit accepted 449 reports using only `propext`,
`Classical.choice`, and `Quot.sound`. The independent formal review and root
replay passed 20 Lean examples, 11 exact declaration and axiom checks, source
compatibility guards, and the comparison with all 34 frozen candidate times.
A direct source compilation of the final certificate passed in 28.49 seconds
with peak RSS 3,985,760 KiB and no persistent compiler output.

Earlier false worker success reports were withdrawn after root observed actual
source errors. The final evidence above comes from terminal checks after those
errors and the strict-time contract were corrected.

See the [formal review](../research/astra-four-runner-mixed-formal-review.md),
[verification record](../research/astra-pass33-verification.json), and
[implementation report](../research/astra-four-runner-mixed-implementation.md).
The [modular review](../research/astra-direct-to-mixed-units-review.md) and
[clarified tight-family review](../research/astra-tight-family-mixed-review.md)
record the separate manuscript results and their exact scope.
