# Thirty-fourth Astra checkpoint: canonical four-runner theorem

This checkpoint proves the four-total-runner specialization for arbitrary
real speeds and any chosen runner. Unrestricted LRC remains unresolved.

## Exact canonical statement

```lean
theorem LonelyRunner.fourRunners
    (speeds : Fin 4 → ℝ) (hinj : Function.Injective speeds)
    (runner : Fin 4) : ∃ t : ℝ, LonelyRunner.LonelyAt speeds runner t
```

The closed distance threshold is 1/4. There is no natural-speed, rational-speed,
sorting, stationary-label, gcd, height, or lower-count hypothesis in this
statement. Speeds may have arbitrary signs and a common translation. The
chosen runner is arbitrary, and the witness time may depend on that runner.
This does not assert simultaneous loneliness of all four runners at one time.

## Mathematical and formal construction

The natural triple theorem uses the earlier mixed classification off its
exceptional family. The family `(a,2*a,3*a)` has the ordinary positive witness
`1/(4*a)`, with phases `1/4,1/2,3/4`. Sorting and reindexing give the result
for any injective positive natural `Fin 3` tuple. Together with the existing
smaller cases, this proves `LowerCountPositiveIntegerHypothesis 5` (H5),
which supplies dimensions one through three, not a five-total-runner theorem.

`BoundedRealReduction` exposes a reusable result: for `m>=1`, H_(m+2)
gives a witness for any nowhere-zero real stationary `Fin m` row. It permits
repeated absolute values. In the irrational-ratio branch, BHK constructs a
compatible rational row with fewer than m distinct magnitudes. The bounded
lower-count supply gives margin 1/m, strictly larger than the desired
1/(m+1). A strict orbit-closure helper transfers that open condition to an
actual point of the original real orbit.

In the rational-ratio branch, division by the first positive speed produces
a rational row with at most m distinct magnitudes. H_(m+2) gives exactly
1/(m+1), and rescaling the time preserves phases. This branch requires no
strict improvement. Coordinatewise absolute values handle signs; the
original-label bridge uses the m other runners' relative speeds. Repeated
relative magnitudes, such as those around an interior chosen runner, remain
covered. Specializing the generic labelled bridge at m=3 and using H5 gives
`fourRunners`.

The strict orbit helper is extracted from `BHKCollisionToWitness`; the old
public rational-collision theorem retains its type and calls the helper.
The bounded result has no all-dimensional rational or real conjecture premise.
Three new modules are imported by the root, and eight public declarations
are added to the axiom audit.

## Research disposition

The accompanying reviewed deletion-gcd argument says that for N>=5, under
H_N, a deletion gcd D larger than the full gcd G supplies one positive time
with all original norms at least 1/(N-1). The effective orbit size is D/G,
and its mesh estimate gives the closed quarter boundary when N=5 and D/G=2.
Thus a primitive no-mixed row must have gcd one after every deletion.
This specializes existing divisor-grid and endpoint-label machinery. It adds
no new ordinary coverage and is closed as a redundant research branch;
no unused formal wrapper was added. Its fixed controls distinguish failure
of a stronger all-coordinate margin from failure of ordinary or mixed LRC.

## Verification

The full `lake build LonelyRunner` completed with 3,643 jobs reported,
including cached targets. `python3 -B scripts/audit_lean_trust.py` accepted
457 theorem reports with only `propext`, `Classical.choice`, and `Quot.sound`.
The root read all changed mathematical sources and replayed the manuscript
review controls. Independent Astra Extra High source review and root guarded
replay passed 18 Lean examples, eight new exact types, the old compatibility
type, and nine permitted-only axiom reports. Fixed controls include negative
speeds, repeated magnitudes, an irrational tuple and an interior chosen runner.
The completed batch was followed by guarded cleanup of 8,006,076,991 bytes
of rebuildable cache; the pinned toolchain and unique evidence were retained.

See the [formal review](../research/astra-four-runner-canonical-formal-review.md),
[verification record](../research/astra-pass34-verification.json),
[bounded reduction report](../research/astra-bounded-real-reduction-implementation.md),
[canonical implementation report](../research/astra-four-runner-canonical-implementation.md),
[accepted bridge plan](../research/astra-four-runner-canonical-bridge-review.md),
and [deletion-gcd review](../research/astra-mixed-codimension-one-gcd-review.md).
