# Bounded real reduction implementation

Source checkpoint: `0e49249d9fcbba5e4a8312d845224bc11466db76`.

Implemented the accepted plan's generic steps 3a--3c:

* `exists_stationaryStrictWitness_of_relations` extracts the open-set and
  orbit-closure argument from the existing BHK collision theorem.  It assumes
  only relation compatibility and a strict target orbit point.
* The unchanged public theorem
  `exists_stationaryWitness_of_rational_collision` now invokes that helper
  after its existing strict-margin derivation.
* `positiveRealWitness_of_lowerCount` derives the closed `1/(m+1)` witness
  from the bounded `H_(m+2)` hypothesis.  Its irrational branch restricts
  supply to `H_(m+1)`, retains strict `1/m` slack, and invokes the extracted
  helper.  Its rational branch uses the existing bounded collision lemma with
  the weak image-cardinality bound, allowing repeated rational coordinates.
* `stationaryWitness_of_lowerCount` handles arbitrary nonzero signs using
  coordinatewise absolute values.
* `lonelyAt_of_lowerCount` transports that signed stationary result through
  `runner.succAbove` to an arbitrary selected runner in an injective family of
  size `m+1`.

No all-dimensional conjecture premise is used by the new bounded declarations.
No fixed count-four specialization or broader canonical declaration was added.

Focused verification, all with terminal exit `0`:

* `lake env lean LonelyRunner/BHKCollisionToWitness.lean` (session `89007`);
* `lake env lean LonelyRunner/BoundedRealReduction.lean` followed by
  `lake build LonelyRunner.BoundedRealReduction`, with `[2971/2971]` built
  (session `59552`);
* an in-memory Lean probe (session `34349`) checked exact signatures and
  standard axioms for the four new declarations and instantiated the preserved
  `exists_stationaryWitness_of_rational_collision` type unchanged.

Every printed new theorem depends only on `propext`, `Classical.choice`, and
`Quot.sound`.

Final hashes:

* `LonelyRunner/BHKCollisionToWitness.lean`:
  `e5175b1f55a2d73e850ffd3e5a5dab140b6e4d84f0cefd94ebf6d7663d3a0d6a`;
* `LonelyRunner/BoundedRealReduction.lean`:
  `7eae68d2c46041b39c3e18f9a1e105c75680352f8e4b4edf65e0dd2a92becb72`.

The unrestricted conjecture remains unresolved.  Integrating a fixed-count
specialization is intentionally left to the separately assigned next phase.
