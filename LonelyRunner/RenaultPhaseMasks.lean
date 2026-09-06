import LonelyRunner.FiniteMaskCertificates
import Mathlib.Data.Nat.Bitwise
import Mathlib.Data.Fin.VecNotation
import Mathlib.Tactic

set_option maxHeartbeats 1000000
set_option maxRecDepth 4096

namespace LonelyRunner

/-- The 41 frozen minimal-core masks from the Renault 5.1 certificate. -/
def renaultPhaseCoreMasks : Fin 41 → Nat := ![7576815, 7970031, 7982311, 8178919, 8179303, 8185447, 8283751, 4158259, 3666739, 3406739, 3391385, 3784601, 3776473, 3973081, 4083196, 4154620, 3663100, 3404030, 3404414, 3799678, 1965951, 6078255, 6168367, 6168463, 6246279, 5754759, 5498823, 4846067, 5042675, 5044467, 5142771, 5127417, 5185145, 4693625, 6541116, 6934332, 6940476, 6940572, 7137180, 7140254, 7238558]

private theorem renaultPhaseCoreMask_row_0 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 0 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_1 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 1 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_2 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 2 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_3 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 3 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_4 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 4 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_5 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 5 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_6 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 6 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_7 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 7 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_8 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 8 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_9 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 9 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_10 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 10 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_11 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 11 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_12 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 12 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_13 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 13 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_14 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 14 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_15 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 15 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_16 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 16 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_17 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 17 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_18 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 18 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_19 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 19 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_20 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 20 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_21 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 21 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_22 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 22 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_23 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 23 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_24 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 24 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_25 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 25 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_26 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 26 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_27 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 27 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_28 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 28 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_29 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 29 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_30 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 30 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_31 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 31 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_32 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 32 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_33 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 33 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_34 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 34 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_35 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 35 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_36 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 36 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_37 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 37 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_38 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 38 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_39 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 39 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

private theorem renaultPhaseCoreMask_row_40 : ∀ j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks 40 &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by decide

/-- Every sorted triple of frozen core masks has a common candidate bit. -/
theorem renaultPhaseCoreMasks_all_rows : ∀ i j k : Fin 41, j ≤ k →
    (renaultPhaseCoreMasks i &&& renaultPhaseCoreMasks j &&& renaultPhaseCoreMasks k) ≠ 0 := by
  intro i
  fin_cases i
  · exact renaultPhaseCoreMask_row_0
  · exact renaultPhaseCoreMask_row_1
  · exact renaultPhaseCoreMask_row_2
  · exact renaultPhaseCoreMask_row_3
  · exact renaultPhaseCoreMask_row_4
  · exact renaultPhaseCoreMask_row_5
  · exact renaultPhaseCoreMask_row_6
  · exact renaultPhaseCoreMask_row_7
  · exact renaultPhaseCoreMask_row_8
  · exact renaultPhaseCoreMask_row_9
  · exact renaultPhaseCoreMask_row_10
  · exact renaultPhaseCoreMask_row_11
  · exact renaultPhaseCoreMask_row_12
  · exact renaultPhaseCoreMask_row_13
  · exact renaultPhaseCoreMask_row_14
  · exact renaultPhaseCoreMask_row_15
  · exact renaultPhaseCoreMask_row_16
  · exact renaultPhaseCoreMask_row_17
  · exact renaultPhaseCoreMask_row_18
  · exact renaultPhaseCoreMask_row_19
  · exact renaultPhaseCoreMask_row_20
  · exact renaultPhaseCoreMask_row_21
  · exact renaultPhaseCoreMask_row_22
  · exact renaultPhaseCoreMask_row_23
  · exact renaultPhaseCoreMask_row_24
  · exact renaultPhaseCoreMask_row_25
  · exact renaultPhaseCoreMask_row_26
  · exact renaultPhaseCoreMask_row_27
  · exact renaultPhaseCoreMask_row_28
  · exact renaultPhaseCoreMask_row_29
  · exact renaultPhaseCoreMask_row_30
  · exact renaultPhaseCoreMask_row_31
  · exact renaultPhaseCoreMask_row_32
  · exact renaultPhaseCoreMask_row_33
  · exact renaultPhaseCoreMask_row_34
  · exact renaultPhaseCoreMask_row_35
  · exact renaultPhaseCoreMask_row_36
  · exact renaultPhaseCoreMask_row_37
  · exact renaultPhaseCoreMask_row_38
  · exact renaultPhaseCoreMask_row_39
  · exact renaultPhaseCoreMask_row_40

/-- All frozen masks fit in the twenty-three candidate bits. -/
theorem renaultPhaseCoreMasks_lt : ∀ i : Fin 41, renaultPhaseCoreMasks i < 2 ^ 23 := by decide

/-- The checked intersection supplies an actual candidate among the23 bits.
Only j and k need ordering; a fully sorted triple is a special case. -/
theorem renaultPhaseCoreMasks_common_candidate (i j k : Fin 41) (hjk : j ≤ k) :
    ∃ c : Fin 23, c ∈ maskCandidates 23 (renaultPhaseCoreMasks i) ∧
      c ∈ maskCandidates 23 (renaultPhaseCoreMasks j) ∧
      c ∈ maskCandidates 23 (renaultPhaseCoreMasks k) :=
  exists_common_mask_candidate 23 _ _ _ (renaultPhaseCoreMasks_lt i)
    (renaultPhaseCoreMasks_all_rows i j k hjk)

end LonelyRunner
