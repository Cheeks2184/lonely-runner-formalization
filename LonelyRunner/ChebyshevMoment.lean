import Mathlib.Analysis.SpecialFunctions.Trigonometric.Chebyshev.RootsExtrema
import Mathlib.Tactic

/-!
# Chebyshev moment-score kernel

This module formalizes the finite, algebraic core of a proposed Chebyshev
moment argument for a consecutive-speed histogram.  It deliberately separates
three ingredients:

* an abstract nonnegative histogram `D`;
* a test function which is `1` at the zero bin and lies in `[-eta, 0]`
  on every positive bin;
* the numerical moment hypotheses `D 0 >= n`, `H = n * X / 2`, and
  `eta <= 2 / (2 * X - 1)`.

Under these hypotheses the score is strictly positive.  The module also
constructs the bounded test values by normalizing a genuine rational
Chebyshev polynomial, including the recurrence, degree, and `[-1, 1]` bound.

No claim is made here that the required histogram identities hold for a
particular Lonely Runner configuration, nor that positivity of this score by
itself proves the Lonely Runner Conjecture.  Those are separate obligations.
-/

namespace LonelyRunner

open scoped BigOperators

/-- Total mass in bins `0, ..., m`, written with the zero bin split off so the
score estimate can expose it directly. -/
def momentHistogramTotal (m : Nat) (D : Nat -> Rat) : Rat :=
  D 0 + (Finset.Icc 1 m).sum D

/-- Score of a histogram against a test function, again with the zero bin
split off explicitly. -/
def momentHistogramScore (m : Nat) (D P : Nat -> Rat) : Rat :=
  D 0 * P 0 + (Finset.Icc 1 m).sum (fun k => D k * P k)

/-- A test function is feasible when it equals one at the zero bin and all
positive-bin values lie in `[-eta, 0]`. -/
def BoundedZeroTest (m : Nat) (eta : Rat) (P : Nat -> Rat) : Prop :=
  P 0 = 1 /\
    forall k, k ∈ Finset.Icc 1 m -> -eta <= P k /\ P k <= 0

/-- The score of a feasible test is bounded below by the zero-bin mass minus
`eta` times the positive-bin mass. -/
theorem momentHistogramScore_ge_zero_sub_tail
    (m : Nat) (D P : Nat -> Rat) (eta : Rat)
    (hD : forall k, k ∈ Finset.Icc 1 m -> 0 <= D k)
    (hP : BoundedZeroTest m eta P) :
    D 0 - eta * (momentHistogramTotal m D - D 0) <=
      momentHistogramScore m D P := by
  rcases hP with ⟨hP0, hP⟩
  have htail :
      (Finset.Icc 1 m).sum (fun k => -eta * D k) <=
        (Finset.Icc 1 m).sum (fun k => D k * P k) := by
    apply Finset.sum_le_sum
    intro k hk
    have hkLower := (hP k hk).1
    have hkMass := hD k hk
    nlinarith
  unfold momentHistogramTotal momentHistogramScore
  rw [hP0]
  simp only [mul_one]
  have htail' :
      -eta * (Finset.Icc 1 m).sum D <=
        (Finset.Icc 1 m).sum (fun k => D k * P k) := by
    calc
      -eta * (Finset.Icc 1 m).sum D =
          (Finset.Icc 1 m).sum (fun k => -eta * D k) := by
            rw [Finset.mul_sum]
      _ <= _ := htail
  nlinarith

/-- The matching upper bound: positive bins cannot increase a feasible
score. -/
theorem momentHistogramScore_le_zeroMass
    (m : Nat) (D P : Nat -> Rat) (eta : Rat)
    (hD : forall k, k ∈ Finset.Icc 1 m -> 0 <= D k)
    (hP : BoundedZeroTest m eta P) :
    momentHistogramScore m D P <= D 0 := by
  rcases hP with ⟨hP0, hP⟩
  have htail :
      (Finset.Icc 1 m).sum (fun k => D k * P k) <= 0 := by
    rw [← Finset.sum_const_zero]
    apply Finset.sum_le_sum
    intro k hk
    have hkUpper := (hP k hk).2
    have hkMass := hD k hk
    nlinarith
  unfold momentHistogramScore
  rw [hP0]
  simp only [mul_one]
  linarith

/-- Pure numerical core of the moment argument.  The parameter `n` is kept
rational here so this lemma can be reused after any desired casting layer. -/
theorem positive_of_score_ge_zeroMass_sub_etaTotal
    (score zeroMass total n X eta : Rat)
    (hscore : zeroMass - eta * (total - zeroMass) <= score)
    (hzero : n <= zeroMass)
    (htotal : total = n * X / 2)
    (hn : 0 < n) (hX : 1 < X) (hetaNonneg : 0 <= eta)
    (heta : eta <= 2 / (2 * X - 1)) :
    0 < score := by
  have hden : 0 < 2 * X - 1 := by linarith
  have hzeroNonneg : 0 <= zeroMass := le_trans (le_of_lt hn) hzero
  have htotalNonneg : 0 <= n * X / 2 := by positivity
  have hetaTotal :
      eta * (n * X / 2) <= (2 / (2 * X - 1)) * (n * X / 2) :=
    mul_le_mul_of_nonneg_right heta htotalNonneg
  have hnormalize :
      (2 / (2 * X - 1)) * (n * X / 2) = n * X / (2 * X - 1) := by
    field_simp
  have hgap : 0 < n - n * X / (2 * X - 1) := by
    rw [sub_pos]
    apply (div_lt_iff₀ hden).2
    nlinarith
  rw [htotal] at hscore
  rw [hnormalize] at hetaTotal
  have hzeroCorrection : 0 <= eta * zeroMass :=
    mul_nonneg hetaNonneg hzeroNonneg
  nlinarith

/-- Full abstract histogram theorem.  This is the independently reusable
result corresponding to the inequalities `D0 >= n`, `H0 = nX/2`, and
`eta <= 2/(2X-1)`. -/
theorem momentHistogramScore_pos
    (m : Nat) (D P : Nat -> Rat) (n X eta : Rat)
    (hD : forall k, k ∈ Finset.Icc 1 m -> 0 <= D k)
    (hP : BoundedZeroTest m eta P)
    (hzero : n <= D 0)
    (htotal : momentHistogramTotal m D = n * X / 2)
    (hn : 0 < n) (hX : 1 < X) (hetaNonneg : 0 <= eta)
    (heta : eta <= 2 / (2 * X - 1)) :
    0 < momentHistogramScore m D P := by
  apply positive_of_score_ge_zeroMass_sub_etaTotal
    (score := momentHistogramScore m D P)
    (zeroMass := D 0) (total := momentHistogramTotal m D)
    (n := n) (X := X) (eta := eta)
  · exact momentHistogramScore_ge_zero_sub_tail m D P eta hD hP
  · exact hzero
  · exact htotal
  · exact hn
  · exact hX
  · exact hetaNonneg
  · exact heta

/-- Rational value of the degree-`r` Chebyshev polynomial of the first kind. -/
noncomputable def rationalChebyshevValue (r : Nat) (x : Rat) : Rat :=
  (Polynomial.Chebyshev.T Rat (r : Int)).eval x

@[simp] theorem rationalChebyshevValue_zero (x : Rat) :
    rationalChebyshevValue 0 x = 1 := by
  simp [rationalChebyshevValue]

@[simp] theorem rationalChebyshevValue_one (x : Rat) :
    rationalChebyshevValue 1 x = x := by
  simp [rationalChebyshevValue]

/-- The rational values use the standard Chebyshev recurrence. -/
theorem rationalChebyshevValue_add_two (r : Nat) (x : Rat) :
    rationalChebyshevValue (r + 2) x =
      2 * x * rationalChebyshevValue (r + 1) x -
        rationalChebyshevValue r x := by
  simp only [rationalChebyshevValue, Nat.cast_add, Nat.cast_ofNat]
  rw [Polynomial.Chebyshev.T_add_two]
  simp

/-- The polynomial used by `rationalChebyshevValue r` really has degree
`r`; the recurrence above is not an opaque function recurrence. -/
theorem rationalChebyshev_degree (r : Nat) :
    (Polynomial.Chebyshev.T Rat (r : Int)).degree = r := by
  simp [Polynomial.Chebyshev.degree_T]

/-- A normalization sending the external Chebyshev value `T0` to `1` and
every value `Tk <= 1` to a nonpositive number. -/
def normalizedZeroValue (T0 Tk : Rat) : Rat :=
  (Tk - 1) / (T0 - 1)

theorem normalizedZeroValue_self (T0 : Rat) (hT0 : T0 ≠ 1) :
    normalizedZeroValue T0 T0 = 1 := by
  unfold normalizedZeroValue
  exact div_self (sub_ne_zero.mpr hT0)

/-- Normalizing an input in `[-1,1]` against `T0 > 1` gives precisely the
feasible interval `[-2/(T0-1), 0]`. -/
theorem normalizedZeroValue_bounds
    (T0 Tk : Rat) (hT0 : 1 < T0) (hLower : -1 <= Tk) (hUpper : Tk <= 1) :
    -2 / (T0 - 1) <= normalizedZeroValue T0 Tk /\
      normalizedZeroValue T0 Tk <= 0 := by
  have hden : 0 < T0 - 1 := by linarith
  constructor
  · unfold normalizedZeroValue
    apply (div_le_div_iff₀ hden hden).2
    nlinarith
  · unfold normalizedZeroValue
    exact div_nonpos_of_nonpos_of_nonneg (sub_nonpos.mpr hUpper) (le_of_lt hden)

/-- Chebyshev values at rational points of `[-1,1]` remain in `[-1,1]`.
The proof transports mathlib's real Chebyshev bound back across the canonical
embedding of the rationals. -/
theorem rationalChebyshevValue_bounds
    (r : Nat) (x : Rat) (hLower : -1 <= x) (hUpper : x <= 1) :
    -1 <= rationalChebyshevValue r x /\
      rationalChebyshevValue r x <= 1 := by
  have hxReal : |(x : Real)| <= 1 := by
    rw [abs_le]
    constructor
    · exact_mod_cast hLower
    · exact_mod_cast hUpper
  have hcast :
      ((rationalChebyshevValue r x : Rat) : Real) =
        (Polynomial.Chebyshev.T Real (r : Int)).eval (x : Real) := by
    unfold rationalChebyshevValue
    calc
      (((Polynomial.Chebyshev.T Rat (r : Int)).eval x : Rat) : Real) =
          (Polynomial.Chebyshev.T Rat (r : Int)).eval₂
            (Rat.castHom Real) (x : Real) :=
        (Polynomial.eval₂_at_apply
          (p := Polynomial.Chebyshev.T Rat (r : Int))
          (Rat.castHom Real) x).symm
      _ = ((Polynomial.Chebyshev.T Rat (r : Int)).map
          (Rat.castHom Real)).eval (x : Real) :=
        Polynomial.eval₂_eq_eval_map (Rat.castHom Real)
      _ = (Polynomial.Chebyshev.T Real (r : Int)).eval (x : Real) := by
        rw [Polynomial.Chebyshev.map_T]
  have hReal :=
    Polynomial.Chebyshev.abs_eval_T_real_le_one (r : Int) hxReal
  have hSides := abs_le.mp hReal
  rw [← hcast] at hSides
  constructor
  · exact_mod_cast hSides.1
  · exact_mod_cast hSides.2

/-- Pointwise Chebyshev construction of a bounded zero test.  The only
remaining hypotheses are the transparent grid facts: the distinguished point
has Chebyshev value above one and every positive-bin grid point lies in
`[-1,1]`. -/
theorem chebyshev_boundedZeroTest
    (m r : Nat) (x0 : Rat) (x : Nat -> Rat)
    (hT0 : 1 < rationalChebyshevValue r x0)
    (hx : forall k, k ∈ Finset.Icc 1 m -> -1 <= x k /\ x k <= 1) :
    BoundedZeroTest m
      (2 / (rationalChebyshevValue r x0 - 1))
      (fun k => normalizedZeroValue
        (rationalChebyshevValue r x0)
        (rationalChebyshevValue r (if k = 0 then x0 else x k))) := by
  constructor
  · simp [normalizedZeroValue_self, ne_of_gt hT0]
  · intro k hk
    have hk0 : k ≠ 0 := by
      have := (Finset.mem_Icc.mp hk).1
      omega
    simp only [if_neg hk0]
    rcases hx k hk with ⟨hxLower, hxUpper⟩
    rcases rationalChebyshevValue_bounds r (x k) hxLower hxUpper with
      ⟨hLower, hUpper⟩
    simpa only [neg_div] using
      normalizedZeroValue_bounds _ _ hT0 hLower hUpper

/-- Affine grid used in the moment proposal.  For `m >= 2`, bin zero is sent
to a point strictly beyond `1`, while bins `1, ..., m` fill `[-1,1]`. -/
def chebyshevMomentGrid (m k : Nat) : Rat :=
  1 + 2 * (1 - k) / (m - 1)

/-- Every positive-bin grid point lies in the Chebyshev control interval. -/
theorem chebyshevMomentGrid_bounds
    (m k : Nat) (hm : 2 <= m) (hk : k ∈ Finset.Icc 1 m) :
    -1 <= chebyshevMomentGrid m k /\ chebyshevMomentGrid m k <= 1 := by
  have hmRat : (2 : Rat) <= m := by exact_mod_cast hm
  have hkLower : (1 : Rat) <= k := by
    exact_mod_cast (Finset.mem_Icc.mp hk).1
  have hkUpper : (k : Rat) <= m := by
    exact_mod_cast (Finset.mem_Icc.mp hk).2
  have hden : (0 : Rat) < m - 1 := by linarith
  unfold chebyshevMomentGrid
  constructor <;> field_simp [ne_of_gt hden] <;> nlinarith

/-- The actual affine-grid Chebyshev values form a feasible test. -/
theorem chebyshevMomentGrid_boundedZeroTest
    (m r : Nat) (hm : 2 <= m)
    (hT0 : 1 < rationalChebyshevValue r (chebyshevMomentGrid m 0)) :
    BoundedZeroTest m
      (2 / (rationalChebyshevValue r (chebyshevMomentGrid m 0) - 1))
      (fun k => normalizedZeroValue
        (rationalChebyshevValue r (chebyshevMomentGrid m 0))
        (rationalChebyshevValue r (chebyshevMomentGrid m k))) := by
  constructor
  · exact normalizedZeroValue_self _ (ne_of_gt hT0)
  · intro k hk
    rcases chebyshevMomentGrid_bounds m k hm hk with ⟨hxLower, hxUpper⟩
    rcases rationalChebyshevValue_bounds r _ hxLower hxUpper with
      ⟨hLower, hUpper⟩
    simpa only [neg_div] using
      normalizedZeroValue_bounds _ _ hT0 hLower hUpper

/-- The growth threshold `T0 >= 2X` implies exactly the eta bound needed by
the abstract score theorem. -/
theorem chebyshevEta_le_of_two_mul_le
    (T0 X : Rat) (hX : 1 < X) (hGrowth : 2 * X <= T0) :
    2 / (T0 - 1) <= 2 / (2 * X - 1) := by
  have hdenLeft : 0 < T0 - 1 := by nlinarith
  have hdenRight : 0 < 2 * X - 1 := by linarith
  apply (div_le_div_iff₀ hdenLeft hdenRight).2
  nlinarith

/-- End-to-end finite Chebyshev moment kernel.  Once the histogram identities
and the explicit growth estimate `2X <= T_r(x0)` are supplied, the normalized
Chebyshev score is positive. -/
theorem chebyshevMomentHistogramScore_pos
    (m r : Nat) (D : Nat -> Rat) (n X : Rat)
    (hm : 2 <= m)
    (hD : forall k, k ∈ Finset.Icc 1 m -> 0 <= D k)
    (hzero : n <= D 0)
    (htotal : momentHistogramTotal m D = n * X / 2)
    (hn : 0 < n) (hX : 1 < X)
    (hGrowth :
      2 * X <= rationalChebyshevValue r (chebyshevMomentGrid m 0)) :
    0 < momentHistogramScore m D
      (fun k => normalizedZeroValue
        (rationalChebyshevValue r (chebyshevMomentGrid m 0))
        (rationalChebyshevValue r (chebyshevMomentGrid m k))) := by
  let T0 := rationalChebyshevValue r (chebyshevMomentGrid m 0)
  let eta := 2 / (T0 - 1)
  have hT0 : 1 < T0 := by
    dsimp [T0]
    nlinarith
  have hetaNonneg : 0 <= eta := by
    dsimp [eta]
    positivity
  apply momentHistogramScore_pos
    (m := m) (D := D)
    (P := fun k => normalizedZeroValue T0
      (rationalChebyshevValue r (chebyshevMomentGrid m k)))
    (n := n) (X := X) (eta := eta)
  · exact hD
  · exact chebyshevMomentGrid_boundedZeroTest m r hm hT0
  · exact hzero
  · exact htotal
  · exact hn
  · exact hX
  · exact hetaNonneg
  · exact chebyshevEta_le_of_two_mul_le T0 X hX hGrowth

end LonelyRunner
