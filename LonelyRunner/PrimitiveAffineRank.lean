import LonelyRunner.RationalPairRank
import Mathlib.Algebra.GCDMonoid.Finset

namespace LonelyRunner

theorem primitive_dvd_of_scaled_dvd {ι : Type*} [Fintype ι]
    (s : ι → ℕ) (hprimitive : Finset.univ.gcd s = 1) (H q : ℕ)
    (hdiv : ∀ i, H ∣ q * s i) : H ∣ q := by
  have hgcd : H ∣ Finset.univ.gcd (fun i => q * s i) :=
    Finset.dvd_gcd_iff.mpr (fun i _ => hdiv i)
  have hscale : Finset.univ.gcd (fun i => q * s i) = q * Finset.univ.gcd s := by
    simpa using (Finset.gcd_mul_left (s := (Finset.univ : Finset ι))
      (f := s) (a := q))
  rw [hscale, hprimitive] at hgcd
  simpa using hgcd

theorem rankTwo_of_primitive_approximation {m : ℕ}
    (s : Fin (m + 2) → ℕ) (H q : ℕ) (hq : 0 < q) (hqH : q < H)
    (hprimitive : Finset.univ.gcd s = 1)
    (u : Fin (m + 2) → ℤ) (v : Fin (m + 2) → ℚ)
    (huH : u (Fin.last (m + 1)) = (q : ℤ))
    (hvH : v (Fin.last (m + 1)) = 0)
    (hidentity : ∀ i, (q : ℚ) * v i =
      (q : ℚ) * (s i : ℚ) - (H : ℚ) * (u i : ℚ)) :
    RationalPairRankTwo u v := by
  by_contra hrank
  unfold RationalPairRankTwo at hrank
  push Not at hrank
  let last : Fin (m + 2) := Fin.last (m + 1)
  have hvzero : ∀ i, v i = 0 := by
    intro i
    have h := hrank i last
    dsimp [last] at h
    rw [huH, hvH] at h
    have : (q : ℚ) * v i = 0 := by simpa using h.symm
    exact (mul_eq_zero.mp this).resolve_left (by exact_mod_cast hq.ne')
  have hdiv : ∀ i, H ∣ q * s i := by
    intro i
    have hi := hidentity i
    rw [hvzero i] at hi
    have hrat : (H : ℚ) * (u i : ℚ) = (q : ℚ) * (s i : ℚ) := by linarith
    have hint : (H : ℤ) * u i = (q * s i : ℕ) := by
      exact_mod_cast hrat
    apply Int.natCast_dvd_natCast.mp
    refine ⟨u i, ?_⟩
    simpa [Int.natCast_mul] using hint.symm
  have hHq := primitive_dvd_of_scaled_dvd s hprimitive H q hdiv
  exact (not_le_of_gt hqH) (Nat.le_of_dvd hq hHq)

end LonelyRunner
