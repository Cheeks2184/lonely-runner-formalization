import Mathlib.Analysis.Normed.Group.AddCircle
import Mathlib.Data.Fin.Basic

/-!
# Canonical statements of the Lonely Runner Conjecture

We model the track as `AddCircle 1 = ℝ / ℤ`, equipped with mathlib's quotient
metric.  Thus one lap has length one and `dist x y` is the shorter circular
distance, including the antipodal boundary at distance `1 / 2`.

The canonical conjecture below quantifies over every finite family of at least
two runners, every injective real-valued speed assignment, and every chosen
runner.  Time ranges over all reals, as in the direct dynamical statement, and
equality at the `1 / n` boundary counts as lonely.  A separate theorem proves
equivalence to the frequently used nonnegative-time convention.
-/

namespace LonelyRunner

/-- The unit-circumference running track `ℝ / ℤ`. -/
abbrev UnitCircle := AddCircle (1 : ℝ)

/-- A runner's point on the unit circle at a given time.  All runners start at
the same point at time zero. -/
def position (speed time : ℝ) : UnitCircle :=
  ((time * speed : ℝ) : UnitCircle)

/-- Shorter-arc distance on the unit circle, expressed using real lifts. -/
noncomputable def circleDistance (x y : ℝ) : ℝ :=
  dist (x : UnitCircle) (y : UnitCircle)

/-- Runner `runner` is lonely at `time` when every other runner is at circular
distance at least `1 / n`, where `n` is the total number of runners. -/
def LonelyAt {n : ℕ} (speeds : Fin n → ℝ) (runner : Fin n) (time : ℝ) : Prop :=
  ∀ other : Fin n, other ≠ runner →
    (n : ℝ)⁻¹ ≤ dist (position (speeds runner) time) (position (speeds other) time)

/-- The canonical, labelled-runner formulation of the Lonely Runner
Conjecture.  `Function.Injective speeds` is exactly the distinct-speed
assumption. -/
def Conjecture : Prop :=
  ∀ (n : ℕ), 2 ≤ n →
    ∀ speeds : Fin n → ℝ, Function.Injective speeds →
      ∀ runner : Fin n, ∃ time : ℝ, LonelyAt speeds runner time

/-- The convention in which witnessing times must be nonnegative. -/
def NonnegativeTimeConjecture : Prop :=
  ∀ (n : ℕ), 2 ≤ n →
    ∀ speeds : Fin n → ℝ, Function.Injective speeds →
      ∀ runner : Fin n, ∃ time : ℝ, 0 ≤ time ∧ LonelyAt speeds runner time

/-- The same loneliness condition after subtracting the chosen runner's
speed, so that the chosen runner is stationary at the origin. -/
def RelativeLonelyAt {n : ℕ} (speeds : Fin n → ℝ) (runner : Fin n)
    (time : ℝ) : Prop :=
  ∀ other : Fin n, other ≠ runner →
    (n : ℝ)⁻¹ ≤
      ‖((time * (speeds other - speeds runner) : ℝ) : UnitCircle)‖

/-- Conjecture stated entirely in relative velocities.  Keeping the original
index type makes the equivalence with `Conjecture` transparent and avoids any
hidden reindexing or cardinality assumption. -/
def RelativeConjecture : Prop :=
  ∀ (n : ℕ), 2 ≤ n →
    ∀ speeds : Fin n → ℝ, Function.Injective speeds →
      ∀ runner : Fin n, ∃ time : ℝ, RelativeLonelyAt speeds runner time

theorem position_neg_time (speed time : ℝ) :
    position speed (-time) = -position speed time := by
  simp [position]

theorem lonelyAt_neg_time {n : ℕ} (speeds : Fin n → ℝ) (runner : Fin n)
    (time : ℝ) : LonelyAt speeds runner (-time) ↔ LonelyAt speeds runner time := by
  simp only [LonelyAt, position_neg_time, dist_neg_neg]

theorem conjecture_iff_nonnegativeTimeConjecture :
    Conjecture ↔ NonnegativeTimeConjecture := by
  constructor
  · intro h n hn speeds hspeeds runner
    obtain ⟨time, hlonely⟩ := h n hn speeds hspeeds runner
    by_cases htime : 0 ≤ time
    · exact ⟨time, htime, hlonely⟩
    · exact ⟨-time, neg_nonneg.mpr (le_of_not_ge htime),
        (lonelyAt_neg_time speeds runner time).mpr hlonely⟩
  · intro h n hn speeds hspeeds runner
    obtain ⟨time, _htime, hlonely⟩ := h n hn speeds hspeeds runner
    exact ⟨time, hlonely⟩

theorem lonelyAt_iff_relativeLonelyAt {n : ℕ} (speeds : Fin n → ℝ)
    (runner : Fin n) (time : ℝ) :
    LonelyAt speeds runner time ↔ RelativeLonelyAt speeds runner time := by
  unfold LonelyAt RelativeLonelyAt position
  apply forall_congr'
  intro other
  apply imp_congr_right
  intro _
  rw [dist_eq_norm]
  rw [← AddCircle.coe_sub]
  rw [show time * speeds runner - time * speeds other =
      -(time * (speeds other - speeds runner)) by ring]
  rw [AddCircle.coe_neg, norm_neg]

theorem conjecture_iff_relativeConjecture : Conjecture ↔ RelativeConjecture := by
  constructor
  · intro h n hn speeds hspeeds runner
    obtain ⟨time, hlonely⟩ := h n hn speeds hspeeds runner
    exact ⟨time, (lonelyAt_iff_relativeLonelyAt speeds runner time).mp hlonely⟩
  · intro h n hn speeds hspeeds runner
    obtain ⟨time, hlonely⟩ := h n hn speeds hspeeds runner
    exact ⟨time, (lonelyAt_iff_relativeLonelyAt speeds runner time).mpr hlonely⟩

end LonelyRunner
