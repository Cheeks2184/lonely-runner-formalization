import LonelyRunner.SmallSixthSeeds
import LonelyRunner.ThirdShiftRescues
import LonelyRunner.StructuredClasses

/-!
# Two small labels and two divisible labels

The two selected small labels stay strictly bad at both proposed seed times.
The reciprocal ratio bounds ensure that one seed makes both divisible labels
safe. A common third shift then supplies a positive witness for every label.
-/

namespace LonelyRunner

theorem three_exceptions_of_two_divisible_labels
    (v : Fin 5 → ℕ) (a b : Fin 5) (hab : a ≠ b)
    (hdiv : ∀ i, 3 ∣ v i ↔ i = a ∨ i = b) :
    ((Finset.univ : Finset (Fin 5)).filter (fun i => ¬ 3 ∣ v i)).card = 3 := by
  classical
  have hfilter : (Finset.univ : Finset (Fin 5)).filter (fun i => 3 ∣ v i) =
      {a, b} := by
    ext i
    simp only [Finset.mem_filter, Finset.mem_univ, true_and,
      Finset.mem_insert, Finset.mem_singleton]
    exact hdiv i
  have hcount := Finset.card_filter_add_card_filter_not
    (s := (Finset.univ : Finset (Fin 5))) (fun i => 3 ∣ v i)
  rw [hfilter] at hcount
  simp [hab] at hcount
  omega

theorem two_divisible_pair_small_witness
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (a b : Fin 5) (hab : a ≠ b)
    (hdiv : ∀ i, 3 ∣ v i ↔ i = a ∨ i = b)
    (hAB : v a < 5 * v b) (hBA : v b < 5 * v a)
    (u w : Fin 5) (huw : u ≠ w)
    (hu : 6 * v u ≤ v a) (hw : 6 * v w ≤ v a) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)) := by
  have hA : (0 : ℝ) < v a := by exact_mod_cast hpos a
  have hB : (0 : ℝ) < v b := by exact_mod_cast hpos b
  have hABR : (v a : ℝ) < 5 * (v b : ℝ) := by exact_mod_cast hAB
  have hBAR : (v b : ℝ) < 5 * (v a : ℝ) := by exact_mod_cast hBA
  let t₀ : ℝ := 1 / (6 * (v a : ℝ))
  have ht₀ : 0 < t₀ := by dsimp [t₀]; positivity
  have hbadU := small_sixth_seed_norms (v a : ℝ) (v u : ℝ) hA
    (by exact_mod_cast hpos u) (by exact_mod_cast hu)
  have hbadW := small_sixth_seed_norms (v a : ℝ) (v w : ℝ) hA
    (by exact_mod_cast hpos w) (by exact_mod_cast hw)
  have hex : ((Finset.univ : Finset (Fin 5)).filter (fun i => ¬ 3 ∣ v i)).card ≤ 3 :=
    (three_exceptions_of_two_divisible_labels v a b hab hdiv).le
  have band (x : ℝ) (hl : (1 : ℝ) / 6 ≤ x) (hh : x ≤ (5 : ℝ) / 6) :
      (1 : ℝ) / 6 ≤ circleNorm x := by
    apply circleNorm_ge_of_int_band 0 x ((1 : ℝ) / 6) <;>
      norm_num at * <;> linarith
  have rescue (s : ℝ) (hs : 0 < s)
      (ha : (1 : ℝ) / 6 ≤ circleNorm (s * (v a : ℝ)))
      (hb : (1 : ℝ) / 6 ≤ circleNorm (s * (v b : ℝ)))
      (hu' : circleNorm (s * (v u : ℝ)) < (1 : ℝ) / 6)
      (hw' : circleNorm (s * (v w : ℝ)) < (1 : ℝ) / 6) :
      ∃ t : ℝ, 0 < t ∧ ∀ i, (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)) := by
    have hseed : ∀ i, 3 ∣ v i → (1 : ℝ) / 6 ≤ circleNorm (s * (v i : ℝ)) := by
      intro i hi
      rcases (hdiv i).mp hi with rfl | rfl
      · exact ha
      · exact hb
    obtain ⟨k, hk⟩ := exists_third_shift_of_two_bad_seeded_divisible
      v s hseed hex u w huw hu' hw'
    refine ⟨s + (k.val : ℝ) / 3, ?_, hk⟩
    have hk0 : (0 : ℝ) ≤ (k.val : ℝ) / 3 := by positivity
    linarith
  have hphaseA : t₀ * (v a : ℝ) = (1 : ℝ) / 6 := by
    dsimp [t₀]
    field_simp
  have hsafeA : (1 : ℝ) / 6 ≤ circleNorm (t₀ * (v a : ℝ)) := by
    rw [hphaseA]
    exact band _ (by norm_num) (by norm_num)
  by_cases hsafeB : (1 : ℝ) / 6 ≤ circleNorm (t₀ * (v b : ℝ))
  · exact rescue t₀ ht₀ hsafeA hsafeB hbadU.1 hbadW.1
  · let x : ℝ := t₀ * (v b : ℝ)
    have hden : 0 < 6 * (v a : ℝ) := by positivity
    have hxden : x * (6 * (v a : ℝ)) = (v b : ℝ) := by
      dsimp [x, t₀]
      field_simp
    have hxhi : x < (5 : ℝ) / 6 := by
      apply (mul_lt_mul_iff_left₀ hden).mp
      rw [hxden]
      nlinarith
    have hxlo : (1 : ℝ) / 30 < x := by
      apply (mul_lt_mul_iff_left₀ hden).mp
      rw [hxden]
      nlinarith
    have hxsmall : x < (1 : ℝ) / 6 := by
      by_contra! h
      exact hsafeB (band x h hxhi.le)
    have hphaseA5 : (5 * t₀) * (v a : ℝ) = (5 : ℝ) / 6 := by
      nlinarith [hphaseA]
    have hsafeA5 : (1 : ℝ) / 6 ≤ circleNorm ((5 * t₀) * (v a : ℝ)) := by
      rw [hphaseA5]
      exact band _ (by norm_num) (by norm_num)
    have hsafeB5 : (1 : ℝ) / 6 ≤ circleNorm ((5 * t₀) * (v b : ℝ)) := by
      rw [show (5 * t₀) * (v b : ℝ) = 5 * x by dsimp [x]; ring]
      exact band _ (by linarith) (by linarith)
    exact rescue (5 * t₀) (by positivity) hsafeA5 hsafeB5 hbadU.2 hbadW.2

end LonelyRunner
