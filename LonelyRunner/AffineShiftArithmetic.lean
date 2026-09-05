import LonelyRunner.AffineGrid

/-!
# Integral bounds for shifted affine grids

The shift makes a formerly zero residue reach the lower good boundary.
The two scalar estimates keep that residue and all smaller bases below the
upper boundary. Reusing ordinary grid rounding avoids a second ceiling model.
-/

namespace LonelyRunner

/-- Round after a shift of `M/(N*A)` and retain its exact scaled error. -/
theorem exists_affine_shift_rounding (N M A r0 : ℕ)
    (hN : 0 < N) (hA : 0 < A) (hM : 0 < M) :
    ∃ r beta, N * r = M * r0 + beta ∧ M ≤ A * beta ∧ A * beta < M + N * A := by
  obtain ⟨r, err, herr, herrBound⟩ :=
    exists_affine_grid_rounding (A * N) (A * M * r0 + M) 1 (mul_pos hA hN)
  have hscaled : A * (N * r) = A * (M * r0) + (M + err) := by
    simpa [Nat.mul_assoc, Nat.mul_left_comm, Nat.mul_comm, Nat.add_assoc] using herr
  have hbase : M * r0 ≤ N * r := by
    apply Nat.le_of_mul_le_mul_left (c := A) _ hA
    rw [hscaled]
    omega
  let beta := N * r - M * r0
  have hb : N * r = M * r0 + beta := by dsimp [beta]; omega
  have hband : A * beta = M + err := by
    dsimp [beta]
    rw [Nat.mul_sub_left_distrib, hscaled]
    omega
  refine ⟨r, beta, hb, ?_, ?_⟩
  · rw [hband]; omega
  · rw [hband]
    have hAN : 0 < A * N := Nat.mul_pos hA hN
    have : err < A * N := by omega
    nlinarith

/-- The distinguished base fits below the modulus, and its shifted residue
stays strictly below the upper closed good boundary. -/
theorem affine_shift_large_scalar_bounds (N M A beta : ℕ)
    (hN : 3 ≤ N) (hA : 0 < A) (hM : 0 < M)
    (hsize : N * A ≤ (N - 2) * M) (hupper : A * beta < M + N * A) :
    A < M ∧ A * beta < (N - 1) * M := by
  have hAM : A < M := by
    apply Nat.lt_of_mul_lt_mul_left
    calc N * A ≤ (N - 2) * M := hsize
         _ < N * M := (Nat.mul_lt_mul_right hM).mpr (by omega : N - 2 < N)
  constructor
  · exact hAM
  · calc A * beta < M + N * A := hupper
         _ ≤ M + (N - 2) * M := Nat.add_le_add_left hsize _
         _ = (N - 1) * M := by
           have h : N - 1 = (N - 2) + 1 := by omega
           rw [h, Nat.add_mul]; omega

/-- A smaller base consumes less than one residue interval under the shift.
The size inequality is kept integral so its boundary cases remain exact. -/
theorem affine_shift_ordinary_correction_bound (N M A a beta : ℕ)
    (hN : 3 ≤ N) (hA : 0 < A) (hM : 0 < M) (ha : 0 < a) (haA : a < A)
    (hsize : N * a * A ≤ (A - a) * M) (hupper : A * beta < M + N * A) :
    a * beta < M := by
  have hsplit : A = (A - a) + a := by omega
  have hsum : N * a * A + a * M ≤ A * M := by
    calc
      N * a * A + a * M ≤ (A - a) * M + a * M := Nat.add_le_add_right hsize _
      _ = A * M := by
        rw [← Nat.add_mul]
        congr 1
        omega
  have hmul := (Nat.mul_lt_mul_left ha).mpr hupper
  have hfinal : A * (a * beta) < A * M := by
    calc
    A * (a * beta) = a * (A * beta) := by ring
    _ < a * (M + N * A) := hmul
    _ = a * M + N * a * A := by ring
    _ ≤ A * M := by simpa [Nat.add_comm] using hsum
  exact Nat.lt_of_mul_lt_mul_left hfinal

end LonelyRunner
