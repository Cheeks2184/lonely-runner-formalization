import LonelyRunner.Prompt100TwoOwnerCounts

namespace LonelyRunner

/-- The normalized strict bad-residue count is controlled by its zero kernel.
The proof retains the two Euclidean remainders so that no natural-number
subtraction is treated as an integer subtraction implicitly. -/
theorem normalizedBadCount_ownerKernel_bound
    (N k P : Nat) (hN : 2 ≤ N) (hP : 0 < P) (hk : 0 < k) (hkN : k ∣ N) :
    N * normalizedBadCount N k P ≤
      2 * (N - 1) * P + (N - 2) * (k - 1) := by
  obtain ⟨l, hl⟩ := hkN
  have hlpos : 0 < l := by
    by_contra h
    have : l = 0 := Nat.eq_zero_of_not_pos h
    simp [this] at hl
    omega
  let q := (P - 1) / k
  let r := (P - 1) % k
  let Q := q / l
  let e := q % l
  have hPk : P - 1 = k * q + r := by
    rw [← Nat.div_add_mod (P - 1) k]
  have hql : q = l * Q + e := by
    rw [← Nat.div_add_mod q l]
  have hrlt : r < k := by
    simp only [r]
    exact Nat.mod_lt _ hk
  have helt : e < l := by
    simp only [e]
    exact Nat.mod_lt _ hlpos
  have hdivk : (P - 1) / k = q := rfl
  have hdivN : (P - 1) / N = Q := by
    rw [hl]
    apply Nat.div_eq_of_lt_le
    · rw [hPk, hql]
      nlinarith
    · rw [hPk, hql]
      nlinarith
  rw [normalizedBadCount, hdivk, hdivN]
  have hkone : 1 ≤ k := hk
  have hKone : k = (k - 1) + 1 := by omega
  have hB : k * (2 * q + 1) - (2 * Q + 1) =
      2 * (N - 1) * Q + 2 * k * e + k - 1 := by
    apply Nat.sub_eq_of_eq_add
    rw [hql]
    have hNminus : N - 1 = k * l - 1 := congrArg (fun x => x - 1) hl
    rw [hNminus]
    calc
      k * (2 * (l * Q + e) + 1) = 2 * (k * l) * Q + 2 * k * e + k := by ring
      _ = 2 * ((k * l - 1) + 1) * Q + 2 * k * e + k := by
        rw [Nat.sub_add_cancel (by nlinarith : 1 ≤ k * l)]
      _ = (2 * (k * l - 1) * Q + 2 * k * e + k - 1) + (2 * Q + 1) := by
        have hexpand :
            2 * ((k * l - 1) + 1) * Q + 2 * k * e + k =
              2 * (k * l - 1) * Q + 2 * Q + 2 * k * e + k := by ring
        rw [hexpand, hKone]
        omega
  rw [hB]
  have hPdecomp : P = k * (l * Q + e) + r + 1 := by
    rw [← Nat.sub_add_cancel (show 1 ≤ P by omega), hPk, hql]
  have heone : e + 1 ≤ l := by omega
  have hkernel : k * (e + 1) ≤ N := by
    rw [hl]
    exact Nat.mul_le_mul_left k heone
  rw [hPdecomp]
  have hgap :
      2 * (N - 1) * (k * (l * Q + e) + r + 1) + (N - 2) * (k - 1) =
        N * (2 * (N - 1) * Q + 2 * k * e + k - 1) +
          2 * ((N - 1) * r + N - k * (e + 1)) := by
    have hinner : k * (e + 1) ≤ (N - 1) * r + N := by omega
    have honeB : 1 ≤ 2 * (N - 1) * Q + 2 * k * e + k := by omega
    apply (Nat.cast_injective : Function.Injective (fun n : Nat => (n : Int)))
    push_cast [Nat.cast_sub (show 1 ≤ N by omega), Nat.cast_sub hN,
      Nat.cast_sub hkone, Nat.cast_sub hinner, Nat.cast_sub honeB]
    have hlZ : (N : Int) = (k : Int) * (l : Int) := by exact_mod_cast hl
    rw [hlZ]
    ring
  omega

/-- Factoring `gcd d p` transports the normalized zero-kernel estimate to the
actual strict pivot bad-residue set. -/
theorem pivotBadResidues_ownerKernel_bound
    (N p d : Nat) (hN : 2 ≤ N) (hp : 0 < p) (hd : 0 < d) (hdp : d < p) :
    N * (pivotBadResidues N p d).card ≤
      2 * (N - 1) * p +
        (N - 2) * (Nat.gcd d (N * p) - Nat.gcd d p) := by
  let h := Nat.gcd d p
  let P := p / h
  let D := d / h
  let k := Nat.gcd D N
  have hhpos : 0 < h := by
    simp only [h]
    exact Nat.gcd_pos_of_pos_left p hd
  have hPmul : p = h * P := by
    rw [show P = p / h by rfl]
    rw [Nat.mul_comm, Nat.div_mul_cancel (Nat.gcd_dvd_right d p)]
  have hDmul : d = h * D := by
    rw [show D = d / h by rfl]
    rw [Nat.mul_comm, Nat.div_mul_cancel (Nat.gcd_dvd_left d p)]
  have hDP : Nat.Coprime D P := by
    rw [show D = d / h by rfl, show P = p / h by rfl]
    exact Nat.coprime_div_gcd_div_gcd hhpos
  have hkpos : 0 < k := by
    rw [show k = Nat.gcd D N by rfl]
    exact Nat.gcd_pos_of_pos_right D (by omega)
  have hkN : k ∣ N := by
    rw [show k = Nat.gcd D N by rfl]
    exact Nat.gcd_dvd_right D N
  have hnorm := normalizedBadCount_ownerKernel_bound N k P hN
    (by
      by_contra hP
      have hPzero : P = 0 := Nat.eq_zero_of_not_pos hP
      simp [hPzero] at hPmul
      omega) hkpos hkN
  have hcard := card_pivotBadResidues_normalized N p d h P D k hN hp hd hdp
    (by rfl) hPmul hDmul hDP (by rfl)
  have hgcdBig : Nat.gcd d (N * p) = h * k := by
    rw [hDmul, hPmul]
    calc
      Nat.gcd (h * D) (N * (h * P)) =
          Nat.gcd (h * D) (h * (N * P)) := by congr 1 <;> ac_rfl
      _ = h * Nat.gcd D (N * P) := Nat.gcd_mul_left h D (N * P)
      _ = h * Nat.gcd D N := by rw [hDP.symm.gcd_mul_right_cancel_right N]
      _ = h * k := by rfl
  have hsmall : Nat.gcd d p = h := rfl
  rw [hcard]
  have hmul := Nat.mul_le_mul_left h hnorm
  calc
    N * (h * normalizedBadCount N k P) = h * (N * normalizedBadCount N k P) := by ac_rfl
    _ ≤ h * (2 * (N - 1) * P + (N - 2) * (k - 1)) := hmul
    _ = 2 * (N - 1) * p +
        (N - 2) * (Nat.gcd d (N * p) - Nat.gcd d p) := by
      have hksub : h * (k - 1) = h * k - h := by
        simpa using Nat.mul_sub_left_distrib h k 1
      rw [hgcdBig, hsmall, hPmul, ← hksub]
      ring

end LonelyRunner
