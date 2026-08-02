import LonelyRunner.CorrelationPolynomial
import Mathlib.Data.Nat.Choose.Sum
import Mathlib.Tactic

/-!
# Algebraic kernel for the consecutive-speed correlation obstruction

This file deliberately starts from a histogram of bad-counts.  It does not
claim the arithmetic facts that, for the tuple `(1, ..., n)`, the zero bin has
mass `n * phi (n + 1)` or that the two extreme pivot residues land in the
specified bins.  Once those facts are supplied, the theorem below gives the
exact denominator-cleared score bound used in the obstruction argument.
-/

namespace LonelyRunner

open scoped BigOperators

/-- The ordinary vertical hockey-stick identity, including the zero terms
below `m`. -/
theorem sum_range_choose_vertical (R m : Nat) :
    (Finset.range (R + 1)).sum (fun x => Nat.choose x m) =
      Nat.choose (R + 1) (m + 1) := by
  induction R with
  | zero =>
      by_cases hm : m = 0
      · subst m
        simp
      · have hmpos : 0 < m := Nat.pos_of_ne_zero hm
        have hm1 : 1 < m + 1 := by omega
        simp [Nat.choose_eq_zero_of_lt hmpos, Nat.choose_eq_zero_of_lt hm1]
  | succ R ih =>
      rw [Finset.sum_range_succ, ih]
      calc
        Nat.choose (R + 1) (m + 1) + Nat.choose (R + 1) m =
            Nat.choose (R + 1) m + Nat.choose (R + 1) (m + 1) := by omega
        _ = Nat.choose ((R + 1) + 1) (m + 1) :=
          (Nat.choose_succ_succ' (R + 1) m).symm

/-- A weighted hockey-stick identity.  The weight counts how many terminal
indices `y` satisfy `x <= y <= R`. -/
theorem weighted_hockey_stick (R m : Nat) :
    (Finset.range (R + 1)).sum
        (fun x => (R + 1 - x) * Nat.choose x m) =
      Nat.choose (R + 2) (m + 2) := by
  induction R with
  | zero =>
      by_cases hm : m = 0
      · subst m
        simp
      · have hmpos : 0 < m := Nat.pos_of_ne_zero hm
        have hm2 : 2 < m + 2 := by omega
        simp [Nat.choose_eq_zero_of_lt hmpos, Nat.choose_eq_zero_of_lt hm2]
  | succ R ih =>
      rw [Finset.sum_range_succ]
      have hsplit :
          (Finset.range (R + 1)).sum
              (fun x => (R + 2 - x) * Nat.choose x m) =
            (Finset.range (R + 1)).sum
                (fun x => (R + 1 - x) * Nat.choose x m) +
              (Finset.range (R + 1)).sum (fun x => Nat.choose x m) := by
        rw [← Finset.sum_add_distrib]
        apply Finset.sum_congr rfl
        intro x hx
        have hxle : x <= R := by simpa using Finset.mem_range.mp hx
        rw [show R + 2 - x = (R + 1 - x) + 1 by omega]
        simp [add_mul]
      rw [hsplit, ih]
      rw [show R + 2 - (R + 1) = 1 by omega, one_mul]
      rw [add_assoc, ← Finset.sum_range_succ,
        sum_range_choose_vertical (R + 1) m]
      calc
        Nat.choose (R + 2) (m + 2) + Nat.choose (R + 2) (m + 1) =
            Nat.choose (R + 2) (m + 1) + Nat.choose (R + 2) (m + 2) := by omega
        _ = Nat.choose ((R + 2) + 1) ((m + 1) + 1) :=
          (Nat.choose_succ_succ' (R + 2) (m + 1)).symm

/-- The denominator-cleared correlation weight attached to bad-count `k`. -/
def clearedCorrelationWeight (n d k : Nat) : Int :=
  ((n - 1 : Nat) : Int) * alternatingChoosePrefix k (2 * d) +
    (2 * d : Int) * (Nat.choose k (2 * d) : Int)

/-- At bad-count zero, the cleared weight is exactly the denominator. -/
theorem clearedCorrelationWeight_zero (n d : Nat) (hd : 0 < d) :
    clearedCorrelationWeight n d 0 = (n - 1 : Nat) := by
  rw [clearedCorrelationWeight]
  obtain ⟨hpref, hchoose⟩ := correlationPolynomial_zero d hd
  rw [hpref, hchoose]
  norm_num

/-- On a positive admissible bad-count, the cleared weight is the explicit
nonpositive binomial debt. -/
theorem clearedCorrelationWeight_eq_debt
    (n d k : Nat) (hd : 0 < d) (hk : 1 <= k) (hkn : k <= n - 1) :
    clearedCorrelationWeight n d k =
      -(((n - 1 - k : Nat) : Int) *
        (Nat.choose (k - 1) (2 * d - 1) : Int)) := by
  exact correlationPolynomial_cleared_eq n d k hd hk hkn

/-- Exact shifted form of `weighted_hockey_stick` needed by the histogram
argument. -/
theorem consecutive_extreme_debt_sum (n m : Nat) (hn : 3 <= n) :
    (Finset.range (n - 2)).sum
        (fun x => (n - 1 - (x + 1)) * Nat.choose x m) =
      Nat.choose (n - 1) (m + 2) := by
  have h := weighted_hockey_stick (n - 3) m
  rw [show n - 3 + 1 = n - 2 by omega,
    show n - 3 + 2 = n - 1 by omega] at h
  rw [← h]
  apply Finset.sum_congr rfl
  intro x hx
  have hxlt : x < n - 2 := Finset.mem_range.mp hx
  congr 1
  omega

/-- Abstract histogram bound.  `D k` is the multiplicity of bad-count `k`.
The sole structural hypothesis says that each interior bin contains at least
the two extreme-residue incidences.  No claim about why that hypothesis holds
is made here. -/
theorem clearedCorrelationHistogram_le
    (n d : Nat) (D : Nat -> Nat) (hn : 3 <= n) (hd : 0 < d)
    (hTwo : forall k, 1 <= k -> k <= n - 2 -> 2 <= D k) :
    (Finset.range n).sum
        (fun k => (D k : Int) * clearedCorrelationWeight n d k) <=
      ((n - 1 : Nat) : Int) * D 0 -
        2 * (Nat.choose (n - 1) (2 * d + 1) : Int) := by
  have hlast : clearedCorrelationWeight n d (n - 1) = 0 := by
    rw [clearedCorrelationWeight_eq_debt n d (n - 1) hd (by omega) (by omega)]
    simp
  have hsplitLast :
      (Finset.range n).sum
          (fun k => (D k : Int) * clearedCorrelationWeight n d k) =
        (Finset.range (n - 1)).sum
            (fun k => (D k : Int) * clearedCorrelationWeight n d k) +
          (D (n - 1) : Int) * clearedCorrelationWeight n d (n - 1) := by
    calc
      _ = (Finset.range ((n - 1) + 1)).sum
          (fun k => (D k : Int) * clearedCorrelationWeight n d k) := by
            congr 2
            omega
      _ = _ := Finset.sum_range_succ _ _
  rw [hsplitLast, hlast, mul_zero, add_zero]
  have hsplitZero :
      (Finset.range (n - 1)).sum
          (fun k => (D k : Int) * clearedCorrelationWeight n d k) =
        (D 0 : Int) * clearedCorrelationWeight n d 0 +
          (Finset.range (n - 2)).sum
            (fun x => (D (x + 1) : Int) *
              clearedCorrelationWeight n d (x + 1)) := by
    calc
      _ = (Finset.range ((n - 2) + 1)).sum
          (fun k => (D k : Int) * clearedCorrelationWeight n d k) := by
            congr 2
            omega
      _ = _ := by
        rw [Finset.sum_range_succ']
        ac_rfl
  rw [hsplitZero]
  rw [clearedCorrelationWeight_zero n d hd]
  have hpoint : ∀ x ∈ Finset.range (n - 2),
      (D (x + 1) : Int) * clearedCorrelationWeight n d (x + 1) <=
        -2 * (((n - 1 - (x + 1) : Nat) : Int) *
          (Nat.choose x (2 * d - 1) : Int)) := by
    intro x hx
    have hxlt : x < n - 2 := Finset.mem_range.mp hx
    have hkpos : 1 <= x + 1 := by omega
    have hkint : x + 1 <= n - 2 := by omega
    have hktop : x + 1 <= n - 1 := by omega
    rw [clearedCorrelationWeight_eq_debt n d (x + 1) hd hkpos hktop]
    simp only [Nat.add_sub_cancel]
    have hmass : (2 : Int) <= D (x + 1) := by
      exact_mod_cast hTwo (x + 1) hkpos hkint
    have hdebt :
        (0 : Int) <= ((n - 1 - (x + 1) : Nat) : Int) *
          (Nat.choose x (2 * d - 1) : Int) := by positivity
    nlinarith
  have htail := Finset.sum_le_sum hpoint
  calc
    (D 0 : Int) * (n - 1 : Nat) +
        (Finset.range (n - 2)).sum
          (fun x => (D (x + 1) : Int) *
            clearedCorrelationWeight n d (x + 1)) <=
      (D 0 : Int) * (n - 1 : Nat) +
        (Finset.range (n - 2)).sum
          (fun x => -2 * (((n - 1 - (x + 1) : Nat) : Int) *
            (Nat.choose x (2 * d - 1) : Int))) :=
        add_le_add_right htail _
    _ = ((n - 1 : Nat) : Int) * D 0 -
        2 * (Nat.choose (n - 1) (2 * d + 1) : Int) := by
      rw [← Finset.mul_sum]
      have hdebtNat := consecutive_extreme_debt_sum n (2 * d - 1) hn
      have hdebtInt :
          (Finset.range (n - 2)).sum
              (fun x => ((n - 1 - (x + 1) : Nat) : Int) *
                (Nat.choose x (2 * d - 1) : Int)) =
            (Nat.choose (n - 1) ((2 * d - 1) + 2) : Int) := by
        exact_mod_cast hdebtNat
      rw [hdebtInt]
      have hidx : 2 * d - 1 + 2 = 2 * d + 1 := by omega
      rw [hidx]
      ring

/-- The same bound with an externally established exact zero-bin mass. -/
theorem clearedCorrelationHistogram_le_of_zeroMass
    (n d zeroMass : Nat) (D : Nat -> Nat) (hn : 3 <= n) (hd : 0 < d)
    (hZero : D 0 = zeroMass)
    (hTwo : forall k, 1 <= k -> k <= n - 2 -> 2 <= D k) :
    (Finset.range n).sum
        (fun k => (D k : Int) * clearedCorrelationWeight n d k) <=
      ((n - 1 : Nat) : Int) * zeroMass -
        2 * (Nat.choose (n - 1) (2 * d + 1) : Int) := by
  simpa [hZero] using clearedCorrelationHistogram_le n d D hn hd hTwo

end LonelyRunner
