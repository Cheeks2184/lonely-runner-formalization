import Mathlib.Data.Nat.Choose.Basic
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Algebra.Ring.Parity
import Mathlib.Tactic

/-!
# An alternating-binomial correlation polynomial

This file verifies the reusable algebraic inequality arising in the
correlation route.  The main identity is stated over the integers after
clearing the positive denominator `n - 1`; no division or modular uniformity
claim is involved.
-/

namespace LonelyRunner

open scoped BigOperators

/-- The first `length` terms of the alternating binomial sum. -/
def alternatingChoosePrefix (k length : Nat) : Int :=
  (Finset.range length).sum fun q => (-1 : Int) ^ q * (Nat.choose k q : Int)

/-- Standard alternating-prefix identity, stated with `k+1` so no truncated
predecessor occurs. -/
theorem alternatingChoosePrefix_succ (k m : Nat) :
    alternatingChoosePrefix (k + 1) (m + 1) =
      (-1 : Int) ^ m * (Nat.choose k m : Int) := by
  induction m with
  | zero => simp [alternatingChoosePrefix]
  | succ m ih =>
      rw [show m + 1 + 1 = (m + 1) + 1 by omega,
        alternatingChoosePrefix, Finset.sum_range_succ]
      change alternatingChoosePrefix (k + 1) (m + 1) +
          (-1 : Int) ^ (m + 1) * (Nat.choose (k + 1) (m + 1) : Int) = _
      rw [ih, Nat.choose_succ_succ']
      push_cast
      rw [pow_succ]
      ring_nf

/-- For a positive half-degree, the `2d`-term alternating prefix has the
claimed negative binomial closed form. -/
theorem alternatingChoosePrefix_two_mul
    (k d : Nat) (hd : 0 < d) :
    alternatingChoosePrefix (k + 1) (2 * d) =
      -(Nat.choose k (2 * d - 1) : Int) := by
  have hlength : 2 * d = (2 * d - 1) + 1 := by omega
  have hodd : Odd (2 * d - 1) := by
    refine ⟨d - 1, ?_⟩
    omega
  calc
    alternatingChoosePrefix (k + 1) (2 * d) =
        alternatingChoosePrefix (k + 1) ((2 * d - 1) + 1) :=
          congrArg (alternatingChoosePrefix (k + 1)) hlength
    _ = (-1 : Int) ^ (2 * d - 1) *
        (Nat.choose k (2 * d - 1) : Int) :=
          alternatingChoosePrefix_succ k (2 * d - 1)
    _ = -(Nat.choose k (2 * d - 1) : Int) := by rw [Odd.neg_one_pow hodd]; ring

/-- Adjacent binomial coefficients satisfy the denominator-clearing identity
used by the correlation polynomial. -/
theorem two_mul_mul_choose_eq
    (k d : Nat) (hd : 0 < d) :
    (2 * d : Int) * (Nat.choose (k + 1) (2 * d) : Int) =
      (k + 1 : Int) * (Nat.choose k (2 * d - 1) : Int) := by
  have hpred : 2 * d = (2 * d - 1) + 1 := by omega
  have hnat := Nat.add_one_mul_choose_eq k (2 * d - 1)
  rw [← hpred] at hnat
  exact_mod_cast (by simpa [Nat.mul_comm] using hnat.symm)

/-- Denominator-free closed form for Sol's correlation polynomial.  The
hypotheses make `n-1-k` ordinary subtraction and ensure the alternating range
is nonempty. -/
theorem correlationPolynomial_cleared_eq
    (n d k : Nat) (hd : 0 < d) (hk : 1 <= k) (hkn : k <= n - 1) :
    ((n - 1 : Nat) : Int) * alternatingChoosePrefix k (2 * d) +
        (2 * d : Int) * (Nat.choose k (2 * d) : Int) =
      -(((n - 1 - k : Nat) : Int) *
        (Nat.choose (k - 1) (2 * d - 1) : Int)) := by
  obtain ⟨k', rfl⟩ := Nat.exists_eq_succ_of_ne_zero (by omega : k ≠ 0)
  rw [alternatingChoosePrefix_two_mul k' d hd,
    two_mul_mul_choose_eq k' d hd]
  have hsub : ((n - 1 - (k' + 1) : Nat) : Int) =
      ((n - 1 : Nat) : Int) - ((k' + 1 : Nat) : Int) := by
    rw [Nat.cast_sub hkn]
  rw [hsub]
  simp only [Nat.succ_sub_one, Nat.cast_add, Nat.cast_one]
  ring

/-- The cleared correlation polynomial is nonpositive on
`1 <= k <= n-1`. -/
theorem correlationPolynomial_cleared_nonpos
    (n d k : Nat) (hd : 0 < d) (hk : 1 <= k) (hkn : k <= n - 1) :
    ((n - 1 : Nat) : Int) * alternatingChoosePrefix k (2 * d) +
        (2 * d : Int) * (Nat.choose k (2 * d) : Int) <= 0 := by
  rw [correlationPolynomial_cleared_eq n d k hd hk hkn]
  apply neg_nonpos.mpr
  positivity

/-- At `k=0` the alternating sum is exactly one and the higher binomial term
vanishes. -/
theorem correlationPolynomial_zero (d : Nat) (hd : 0 < d) :
    alternatingChoosePrefix 0 (2 * d) = 1 /\
      Nat.choose 0 (2 * d) = 0 := by
  have htwo : 0 < 2 * d := by omega
  constructor
  · rw [alternatingChoosePrefix]
    calc
      (Finset.range (2 * d)).sum
          (fun q => (-1 : Int) ^ q * (Nat.choose 0 q : Int)) =
          (-1 : Int) ^ 0 * (Nat.choose 0 0 : Int) := by
            apply Finset.sum_eq_single 0
            · intro q hq hqne
              have hqpos : 0 < q := Nat.pos_of_ne_zero hqne
              rw [Nat.choose_eq_zero_of_lt hqpos]
              simp
            · simp [htwo]
      _ = 1 := by norm_num
  · exact Nat.choose_eq_zero_of_lt htwo

/-- The zero-indicator majorizes the rational correlation polynomial.  This
is a division-safe corollary of the cleared identity. -/
theorem correlationPolynomial_le_zeroIndicator
    (n d k : Nat) (_hn : 2 <= n) (hd : 0 < d) (hkn : k <= n - 1) :
    (alternatingChoosePrefix k (2 * d) : Rat) +
        (((2 * d : Nat) : Rat) / ((n - 1 : Nat) : Rat)) * Nat.choose k (2 * d) <=
      if k = 0 then 1 else 0 := by
  by_cases hkzero : k = 0
  · subst k
    norm_num [correlationPolynomial_zero d hd]
  · have hk : 1 <= k := by omega
    simp only [if_neg hkzero]
    have hcleared := correlationPolynomial_cleared_nonpos n d k hd hk hkn
    have hden : (0 : Rat) < ((n - 1 : Nat) : Rat) := by
      exact_mod_cast (by omega : 0 < n - 1)
    have hrearrange :
        (alternatingChoosePrefix k (2 * d) : Rat) +
            (((2 * d : Nat) : Rat) / ((n - 1 : Nat) : Rat)) *
              Nat.choose k (2 * d) =
          ((((n - 1 : Nat) : Int) * alternatingChoosePrefix k (2 * d) +
              (2 * d : Int) * (Nat.choose k (2 * d) : Int) : Int) : Rat) /
            ((n - 1 : Nat) : Rat) := by
      field_simp
      push_cast
      ring
    rw [hrearrange]
    apply div_nonpos_of_nonpos_of_nonneg
    · exact_mod_cast hcleared
    · exact hden.le

end LonelyRunner
