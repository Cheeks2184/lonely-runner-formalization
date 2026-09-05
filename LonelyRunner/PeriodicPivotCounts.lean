import LonelyRunner.PivotCounts

/-!+# Periodic subsets of a pivot row

The exceptional-owner overlap arguments use a small period dividing the pivot.
When that period is coprime to the distance denominator, deleting the forbidden
multiples of the denominator removes exactly one sheet. The result below counts
literal candidate residues, including arbitrary common factors in the pivot.
-/

namespace LonelyRunner

open Finset

/-- Multiplication by a unit modulo `L` preserves the size of any literal
subset of the complete residue period. -/
theorem card_filter_range_mul_mod_coprime (L a : ℕ) (hL : 0 < L)
    (hcop : Nat.Coprime L a) (S : Finset ℕ) (hS : S ⊆ range L) :
    ((range L).filter fun r => (r * a) % L ∈ S).card = S.card := by
  classical
  let f : ℕ → ℕ := fun r => (r * a) % L
  have himage : (range L).image f = range L := by
    simpa [f, hcop.gcd_eq_one] using image_mul_mod_eq_filter_gcd L a hL
  have hinj : Set.InjOn f (range L) := by
    intro r hr s hs hrs
    have hm : r * a ≡ s * a [MOD L] := hrs
    have hc := hm.cancel_right_div_gcd hL
    have he : r ≡ s [MOD L] := by simpa [hcop.gcd_eq_one] using hc
    exact he.eq_of_lt_of_lt (mem_range.mp hr) (mem_range.mp hs)
  have hfiltered : ((range L).filter fun r => r ∈ S) = S := by
    ext r
    simp only [mem_filter]
    exact ⟨fun h => h.2, fun h => ⟨hS h, h⟩⟩
  have hfi :
      (((range L).filter fun r => f r ∈ S).image f) = S := by
    rw [← (filter_image (s := range L) (f := f) (p := fun r => r ∈ S)),
      himage, hfiltered]
  have hcard := congrArg Finset.card hfi
  rw [card_image_iff.mpr (hinj.mono (filter_subset _ _))] at hcard
  exact hcard

/-- A residue subset of period `L` has the same count in each complete block. -/
theorem card_filter_range_mod_mem (g L : ℕ) (hL : 0 < L)
    (S : Finset ℕ) (hS : S ⊆ range L) :
    ((range (g * L)).filter fun r => r % L ∈ S).card = g * S.card := by
  have hcount := card_filter_range_mul_of_block_periodic g L hL
    (fun r => r % L ∈ S) (by
      intro k hk q hq
      simp [Nat.add_mod, Nat.mod_eq_of_lt hq])
  have hbase : ((range L).filter fun r => r % L ∈ S) = S := by
    ext r
    simp only [mem_filter]
    constructor
    · rintro ⟨hr, hs⟩
      simpa [Nat.mod_eq_of_lt (mem_range.mp hr)] using hs
    · intro hs
      have hr := hS hs
      exact ⟨hr, by simpa [Nat.mod_eq_of_lt (mem_range.mp hr)] using hs⟩
  simpa [hbase] using hcount

/-- Exact candidate multiplicity for a small period dividing the pivot.
The coprimality is with the period, not with the possibly much larger pivot. -/
theorem card_filter_pivotCandidates_mod_mem (N p L : ℕ)
    (hN : 0 < N) (hL : 0 < L) (hLp : L ∣ p)
    (hcop : Nat.Coprime L N) (S : Finset ℕ) (hS : S ⊆ range L) :
    ((pivotCandidates N p).filter fun r => r % L ∈ S).card =
      (N - 1) * (p / L) * S.card := by
  classical
  let m := p / L
  have hp : p = m * L := (Nat.div_mul_cancel hLp).symm
  let A := (range (N * p)).filter fun r => r % L ∈ S
  let D := A.filter fun r => N ∣ r
  let Q := (range p).filter fun q => (q * N) % L ∈ S
  have hA : A.card = N * m * S.card := by
    dsimp [A]
    rw [hp, ← Nat.mul_assoc]
    exact card_filter_range_mod_mem (N * m) L hL S hS
  have hQ : Q.card = m * S.card := by
    have hc := card_filter_range_mul_of_block_periodic m L hL
      (fun q => (q * N) % L ∈ S) (by
        intro k hk q hq
        simp [Nat.add_mul, Nat.add_mod, Nat.mul_assoc, Nat.mul_mod])
    dsimp [Q]
    rw [hp]
    rw [hc, card_filter_range_mul_mod_coprime L N hL hcop S hS]
  have hDimage : D = Q.image (fun q => N * q) := by
    ext r
    simp only [D, A, Q, mem_filter, mem_range, mem_image]
    constructor
    · rintro ⟨⟨hr, hs⟩, hNr⟩
      obtain ⟨q, rfl⟩ := hNr
      refine ⟨q, ⟨(Nat.mul_lt_mul_left hN).mp hr, ?_⟩, rfl⟩
      simpa [Nat.mul_comm] using hs
    · rintro ⟨q, ⟨hq, hs⟩, rfl⟩
      exact ⟨⟨(Nat.mul_lt_mul_left hN).mpr hq,
        by simpa [Nat.mul_comm] using hs⟩, dvd_mul_right N q⟩
  have hD : D.card = m * S.card := by
    rw [hDimage, card_image_iff.mpr]
    · exact hQ
    · intro a ha b hb hab
      exact Nat.mul_left_cancel hN hab
  have hsub : D ⊆ A := filter_subset _ _
  have hset : (pivotCandidates N p).filter (fun r => r % L ∈ S) = A \ D := by
    ext r
    simp only [pivotCandidates, A, D, mem_filter, mem_range, mem_sdiff]
    tauto
  rw [hset, card_sdiff_of_subset hsub, hA, hD]
  simp [m, Nat.sub_mul]

end LonelyRunner
