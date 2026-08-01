import LonelyRunner.Definitions

/-!
# Conventional stationary and integer formulations

This file records commonly used formulations as propositions.  It deliberately
does **not** assert equivalence with `Conjecture`:

* passing from the labelled-runner statement to an injective stationary tuple
  requires a finite reindexing after subtracting the chosen runner's speed;
* allowing repetitions in a stationary tuple requires deduplication together
  with the stronger bound supplied by the conjecture in lower dimensions;
* reducing arbitrary real speeds to positive integers is not "clearing
  denominators" and requires a Kronecker-approximation/lower-dimensional
  argument.

Those dependencies must be formalized before any equivalence theorem is added.
-/

namespace LonelyRunner

/-- The conventional stationary-runner formulation with `n` nonzero moving
speeds and one stationary runner, hence total-runner threshold `1 / (n + 1)`.

Repetitions are intentionally allowed.  This is the formulation often stated
for an arbitrary nonzero tuple, but its equivalence to an injective tuple is a
genuine all-dimensions deduction, not a fixed-dimension tautology. -/
def StationaryConjecture : Prop :=
  ∀ (n : ℕ), 1 ≤ n →
    ∀ speeds : Fin n → ℝ, (∀ i, speeds i ≠ 0) →
      ∃ time : ℝ, ∀ i,
        (((n + 1 : ℕ) : ℝ)⁻¹) ≤
          ‖((time * speeds i : ℝ) : UnitCircle)‖

/-- The stationary-runner formulation in which the moving relative speeds are
also pairwise distinct.  Subtracting a chosen runner's speed from an injective
labelled speed family produces data of this shape, modulo an explicit finite
reindexing from the complement of that runner to `Fin (N - 1)`. -/
def DistinctStationaryConjecture : Prop :=
  ∀ (n : ℕ), 1 ≤ n →
    ∀ speeds : Fin n → ℝ,
      Function.Injective speeds → (∀ i, speeds i ≠ 0) →
        ∃ time : ℝ, ∀ i,
          (((n + 1 : ℕ) : ℝ)⁻¹) ≤
            ‖((time * speeds i : ℝ) : UnitCircle)‖

/-- The positive-integer formulation: `n` pairwise distinct positive integer
speeds move relative to one stationary runner, with threshold `1 / (n + 1)`.

Natural numbers encode positivity without a sign-normalization convention.
Time is kept unrestricted here.  Integer speeds make the predicate periodic
modulo one, but restricting the witness to `[0, 1]` requires a separate lemma.
-/
def PositiveIntegerConjecture : Prop :=
  ∀ (n : ℕ), 1 ≤ n →
    ∀ speeds : Fin n → ℕ,
      Function.Injective speeds → (∀ i, 0 < speeds i) →
        ∃ time : ℝ, ∀ i,
          (((n + 1 : ℕ) : ℝ)⁻¹) ≤
            ‖((time * (speeds i : ℝ) : ℝ) : UnitCircle)‖

end LonelyRunner
