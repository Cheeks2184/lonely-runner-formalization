import Mathlib.Algebra.BigOperators.Field
import Mathlib.Data.Nat.ModEq
import Mathlib.Tactic

/-!
# Residual-variation energy identities

This module records algebraic facts used in the residual-variation audit.
They are independent of the unresolved arithmetic assertion `RV-UNIF`.

The first identity is the pointwise polynomial calculation behind the exact
pair-multiplicity formula.  It is deliberately stated without division, so it
remains valid at the constant and otherwise degenerate parameter values.

The second group isolates the integer balancing mechanism.  The quantity
`a * (K - a)` is subadditive when residues are merged modulo `K`.  Iterating
that fact says that a collection of cut sizes has at least the energy of its
total residue.  A concrete profile may use this lemma after expressing its
pairwise `L1` dispersion as the sum of its cut energies.
-/

namespace LonelyRunner

open scoped BigOperators

/-- Denominator-free pointwise identity behind `PAIR-MULT`.

Here `m` is the number of masks and `k` is the multiplicity of one universe
point.  No range assumptions are needed for this polynomial identity. -/
theorem pairMultiplicityContribution_num (m k : ℤ) :
    k * (k - 1) * (2 * m - k - 1) - m * (m - 1) * (k - 1) =
      -((k - 1) * (m - k) * (m - k - 1)) := by
  ring

/-- Finite-sum form of the exact pair-multiplicity contribution identity.
It can be instantiated with the multiplicity function of a finite mask
system.  Because the theorem is denominator-free, uncovered points (`k=0`),
constant profiles, and full multiplicity require no special treatment. -/
theorem sum_pairMultiplicityContribution_num
    {α : Type*} [DecidableEq α]
    (points : Finset α) (m : ℤ) (multiplicity : α → ℤ) :
    points.sum (fun x =>
        (multiplicity x) * (multiplicity x - 1) *
            (2 * m - multiplicity x - 1) -
          m * (m - 1) * (multiplicity x - 1)) =
      -points.sum (fun x =>
        (multiplicity x - 1) * (m - multiplicity x) *
          (m - multiplicity x - 1)) := by
  calc
    points.sum (fun x =>
        (multiplicity x) * (multiplicity x - 1) *
            (2 * m - multiplicity x - 1) -
          m * (m - 1) * (multiplicity x - 1)) =
        points.sum (fun x => -((multiplicity x - 1) *
          (m - multiplicity x) * (m - multiplicity x - 1))) := by
            apply Finset.sum_congr rfl
            intro x _hx
            exact pairMultiplicityContribution_num m (multiplicity x)
    _ = -points.sum (fun x =>
        (multiplicity x - 1) * (m - multiplicity x) *
          (m - multiplicity x - 1)) := by
            simpa only [Finset.sum_neg_distrib]

/-- The pointwise deficit numerator vanishes at multiplicity one. -/
@[simp] theorem pairMultiplicityDeficit_at_one (m : ℤ) :
    ((1 : ℤ) - 1) * (m - 1) * (m - 1 - 1) = 0 := by
  ring

/-- The pointwise deficit numerator vanishes one below full multiplicity. -/
@[simp] theorem pairMultiplicityDeficit_at_pred (m : ℤ) :
    ((m - 1) - 1) * (m - (m - 1)) * (m - (m - 1) - 1) = 0 := by
  ring

/-- The pointwise deficit numerator vanishes at full multiplicity. -/
@[simp] theorem pairMultiplicityDeficit_at_full (m : ℤ) :
    (m - 1) * (m - m) * (m - m - 1) = 0 := by
  ring

/-- Before division by `m(m-1)`, an uncovered point contributes exactly the
denominator.  This becomes the `u₀` term in normalized `PAIR-MULT`. -/
@[simp] theorem pairMultiplicityContributionNum_at_zero (m : ℤ) :
    0 * (0 - 1) * (2 * m - 0 - 1) - m * (m - 1) * (0 - 1) =
      m * (m - 1) := by
  ring

/-- Energy of one integer residue representative in a modulus `K`.
Integer subtraction is intentional: it avoids silently truncating `K - a`. -/
def residueEnergy (K a : ℤ) : ℤ := a * (K - a)

/-- Low-sum branch of the residue merge calculation. -/
theorem residueEnergy_add_le
    (K a b : ℤ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hab : a + b ≤ K) :
    residueEnergy K (a + b) ≤ residueEnergy K a + residueEnergy K b := by
  unfold residueEnergy
  nlinarith

/-- Wrapped branch of the residue merge calculation. -/
theorem residueEnergy_add_sub_le
    (K a b : ℤ) (ha : a ≤ K) (hb : b ≤ K) (hab : K ≤ a + b) :
    residueEnergy K (a + b - K) ≤
      residueEnergy K a + residueEnergy K b := by
  unfold residueEnergy
  nlinarith

/-- Merging two natural representatives modulo `K` cannot increase their
total integer residue energy. -/
theorem residueEnergy_nat_add_mod_le
    (K a b : ℕ) (hK : 0 < K) (ha : a < K) (hb : b < K) :
    residueEnergy (K : ℤ) (((a + b) % K : ℕ) : ℤ) ≤
      residueEnergy (K : ℤ) (a : ℤ) + residueEnergy (K : ℤ) (b : ℤ) := by
  by_cases hab : a + b < K
  · rw [Nat.mod_eq_of_lt hab]
    push_cast
    apply residueEnergy_add_le
    · positivity
    · positivity
    · exact_mod_cast Nat.le_of_lt hab
  · have habLe : K ≤ a + b := Nat.le_of_not_gt hab
    have hsubLt : a + b - K < K := by omega
    have hmod : (a + b) % K = a + b - K := by
      rw [Nat.mod_eq_sub_mod habLe, Nat.mod_eq_of_lt hsubLt]
    rw [hmod, Nat.cast_sub habLe]
    push_cast
    apply residueEnergy_add_sub_le
    · exact_mod_cast Nat.le_of_lt ha
    · exact_mod_cast Nat.le_of_lt hb
    · exact_mod_cast habLe

/-- Iterated integer balancing bound for a list of cut sizes.  If each cut
size is strictly below `K`, their total cut energy dominates the energy of
the total size modulo `K`. -/
theorem residueEnergy_sum_mod_le
    (K : ℕ) (cuts : List ℕ) (hK : 0 < K)
    (hcuts : ∀ a ∈ cuts, a < K) :
    residueEnergy (K : ℤ) (((cuts.sum) % K : ℕ) : ℤ) ≤
      (cuts.map (fun a => residueEnergy (K : ℤ) (a : ℤ))).sum := by
  induction cuts with
  | nil => simp [residueEnergy]
  | cons a cuts ih =>
      have ha : a < K := hcuts a (by simp)
      have htail : ∀ b ∈ cuts, b < K := by
        intro b hb
        exact hcuts b (by simp [hb])
      have ih' := ih htail
      have hrem : cuts.sum % K < K := Nat.mod_lt _ hK
      have hmerge := residueEnergy_nat_add_mod_le
        K a (cuts.sum % K) hK ha hrem
      calc
        residueEnergy (K : ℤ) ((((a :: cuts).sum) % K : ℕ) : ℤ) =
            residueEnergy (K : ℤ)
              ((((a + cuts.sum % K) % K : ℕ)) : ℤ) := by
                simp only [List.sum_cons]
                rw [Nat.add_mod]
                simp [Nat.mod_eq_of_lt ha]
        _ ≤ residueEnergy (K : ℤ) (a : ℤ) +
              residueEnergy (K : ℤ) ((cuts.sum % K : ℕ) : ℤ) := hmerge
        _ ≤ residueEnergy (K : ℤ) (a : ℤ) +
              (cuts.map (fun b => residueEnergy (K : ℤ) (b : ℤ))).sum := by
                gcongr
        _ = ((a :: cuts).map
              (fun b => residueEnergy (K : ℤ) (b : ℤ))).sum := by simp

/-- The balancing bound is sharp for a single nonzero cut.  In the usual
layer-cake representation, this is the equality case in which the integer
profile takes only two consecutive values. -/
@[simp] theorem residueEnergy_singleton (K a : ℕ) (ha : a < K) :
    residueEnergy (K : ℤ) (((([a] : List ℕ).sum) % K : ℕ) : ℤ) =
      (([a] : List ℕ).map
        (fun b => residueEnergy (K : ℤ) (b : ℤ))).sum := by
  simp [Nat.mod_eq_of_lt ha]

/-- Equality/constant edge case for residue balancing: if every cut is zero,
both the exact cut energy and the modular lower bound vanish. -/
@[simp] theorem residueEnergy_replicate_zero (K numberOfCuts : ℕ) :
    residueEnergy (K : ℤ)
        ((((List.replicate numberOfCuts 0).sum) % K : ℕ) : ℤ) = 0 ∧
      ((List.replicate numberOfCuts 0).map
        (fun a => residueEnergy (K : ℤ) (a : ℤ))).sum = 0 := by
  simp [residueEnergy]

end LonelyRunner
