import LonelyRunner.PivotCounts

namespace LonelyRunner

/-- The normalized cardinality expression for a pivot bad-residue set after
factoring `gcd d p` from both speeds. -/
def normalizedBadCount (N k P : Nat) : Nat :=
  k * (2 * ((P - 1) / k) + 1) -
    (2 * ((P - 1) / N) + 1)

private theorem ceilDiv_mul_left_cancel (a b c : Nat)
    (hb : 0 < b) (hc : 0 < c) :
    (c * a) ⌈/⌉ (c * b) = a ⌈/⌉ b := by
  apply Nat.le_antisymm
  · apply (ceilDiv_le_iff_le_mul (Nat.mul_pos hc hb)).2
    calc
      c * a ≤ c * (b * (a ⌈/⌉ b)) :=
        Nat.mul_le_mul_left c ((ceilDiv_le_iff_le_mul hb).1 le_rfl)
      _ = (c * b) * (a ⌈/⌉ b) := by ac_rfl
  · apply (ceilDiv_le_iff_le_mul hb).2
    apply Nat.le_of_mul_le_mul_left (c := c) _ hc
    calc
      c * a ≤ (c * b) * ((c * a) ⌈/⌉ (c * b)) :=
        (ceilDiv_le_iff_le_mul (Nat.mul_pos hc hb)).1 le_rfl
      _ = c * (b * ((c * a) ⌈/⌉ (c * b))) := by ac_rfl

private theorem ceilDiv_eq_pred_div_add_one (a b : Nat)
    (ha : 0 < a) (hb : 0 < b) :
    a ⌈/⌉ b = (a - 1) / b + 1 := by
  rw [Nat.ceilDiv_eq_add_pred_div]
  have hnum : a + b - 1 = (a - 1) + b := by omega
  rw [hnum, Nat.add_div_right _ hb]

/-- Exact one-bad-set cardinality in the normalized variables used by the
Prompt100 two-owner counting program. This is only a normalization of
`card_pivotBadResidues_exact`; it supplies no two-owner overlap bound. -/
theorem card_pivotBadResidues_normalized
    (N p d h P D k : Nat)
    (hN : 2 <= N) (hp : 0 < p) (hd : 0 < d) (hdp : d < p)
    (hh : h = Nat.gcd d p)
    (hpP : p = h * P) (hdD : d = h * D)
    (hDP : Nat.Coprime D P) (hk : k = Nat.gcd D N) :
    (pivotBadResidues N p d).card = h * normalizedBadCount N k P := by
  have hNpos : 0 < N := by omega
  have hhpos : 0 < h := by
    rw [hh]
    exact Nat.gcd_pos_of_pos_left p hd
  have hPpos : 0 < P := by
    by_contra hP
    have : P = 0 := Nat.eq_zero_of_not_pos hP
    simp [this] at hpP
    omega
  have hkpos : 0 < k := by
    rw [hk]
    exact Nat.gcd_pos_of_pos_right D hNpos
  have hgcdBig : Nat.gcd d (N * p) = h * k := by
    rw [hdD, hpP]
    calc
      Nat.gcd (h * D) (N * (h * P)) =
          Nat.gcd (h * D) (h * (N * P)) := by congr 1 <;> ac_rfl
      _ = h * Nat.gcd D (N * P) := Nat.gcd_mul_left h D (N * P)
      _ = h * Nat.gcd D N := by rw [hDP.symm.gcd_mul_right_cancel_right N]
      _ = h * k := by rw [hk]
  have hgcdSmall : Nat.gcd d p = h := hh.symm
  have hceilBig : p ⌈/⌉ Nat.gcd d (N * p) = P ⌈/⌉ k := by
    rw [hgcdBig, hpP]
    exact ceilDiv_mul_left_cancel P k h hkpos hhpos
  have hceilSmall : p ⌈/⌉ (N * Nat.gcd d p) = P ⌈/⌉ N := by
    rw [hgcdSmall, hpP]
    rw [Nat.mul_comm N h]
    exact ceilDiv_mul_left_cancel P N h hNpos hhpos
  rw [card_pivotBadResidues_exact N p d hN hp]
  rw [hceilBig, hceilSmall, hgcdBig, hgcdSmall]
  rw [ceilDiv_eq_pred_div_add_one P k hPpos hkpos]
  rw [ceilDiv_eq_pred_div_add_one P N hPpos hNpos]
  have hfirst : 2 * ((P - 1) / k + 1) - 1 =
      2 * ((P - 1) / k) + 1 := by omega
  have hsecond : 2 * ((P - 1) / N + 1) - 1 =
      2 * ((P - 1) / N) + 1 := by omega
  rw [hfirst, hsecond]
  simp only [normalizedBadCount, Nat.mul_sub_left_distrib]
  ac_rfl

end LonelyRunner
