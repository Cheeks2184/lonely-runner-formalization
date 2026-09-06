import LonelyRunner.RationalMarginBoxes

namespace LonelyRunner

def rationalMarginBoxPilotRoot : NatSpeedBox 4 :=
  ⟨![2, 3, 5, 6], ![3, 4, 5, 8]⟩

def rationalMarginBoxPilotNum : Fin 4 → ℕ := ![1, 1, 1, 1]
def rationalMarginBoxPilotDen : Fin 4 → ℕ := ![5, 5, 5, 4]

def rationalMarginBoxPilotTree : RationalMarginBoxTree 4 :=
  .split 3 7
    (.leaf ⟨1, 10, ![0, 0, 0, 0]⟩)
    (.leaf ⟨5, 32, ![0, 0, 0, 1]⟩)

theorem rationalMarginBoxPilot_accepts : rationalMarginBoxTreeOK rationalMarginBoxPilotRoot
    rationalMarginBoxPilotNum rationalMarginBoxPilotDen rationalMarginBoxPilotTree = true := by
  decide

theorem rationalMarginBoxPilot_unsplit_rejects : rationalMarginBoxTreeOK rationalMarginBoxPilotRoot
    rationalMarginBoxPilotNum rationalMarginBoxPilotDen
    (.leaf ⟨1, 10, ![0, 0, 0, 0]⟩) = false := by
  decide

theorem rationalMarginBoxPilot_cut_below_rejects : rationalMarginBoxTreeOK rationalMarginBoxPilotRoot
    rationalMarginBoxPilotNum rationalMarginBoxPilotDen
    (.split 3 5 (.leaf ⟨1, 10, ![0, 0, 0, 0]⟩) (.leaf ⟨5, 32, ![0, 0, 0, 1]⟩)) = false := by
  decide

theorem rationalMarginBoxPilot_cut_at_upper_rejects : rationalMarginBoxTreeOK rationalMarginBoxPilotRoot
    rationalMarginBoxPilotNum rationalMarginBoxPilotDen
    (.split 3 8 (.leaf ⟨1, 10, ![0, 0, 0, 0]⟩) (.leaf ⟨5, 32, ![0, 0, 0, 1]⟩)) = false := by
  decide

theorem rationalMarginBoxPilot_failed_child_rejects : rationalMarginBoxTreeOK rationalMarginBoxPilotRoot
    rationalMarginBoxPilotNum rationalMarginBoxPilotDen
    (.split 3 7 (.leaf ⟨1, 10, ![0, 0, 0, 0]⟩) (.leaf ⟨1, 10, ![0, 0, 0, 0]⟩)) = false := by
  decide

theorem rationalMarginBoxPilot_wrong_band_rejects : rationalMarginBoxTreeOK rationalMarginBoxPilotRoot
    rationalMarginBoxPilotNum rationalMarginBoxPilotDen
    (.split 3 7 (.leaf ⟨1, 10, ![0, 0, 0, 0]⟩) (.leaf ⟨5, 32, ![0, 0, 0, 0]⟩)) = false := by
  decide

theorem rationalMarginBoxPilot_row (w : Fin 4 → ℕ)
    (hw : rationalMarginBoxPilotRoot.Contains w) :
    ∃ p q : ℕ, 0 < p ∧ rationalMarginRowOK w rationalMarginBoxPilotNum
      rationalMarginBoxPilotDen p q = true :=
  rationalMarginBoxTreeOK_row rationalMarginBoxPilotRoot rationalMarginBoxPilotNum
    rationalMarginBoxPilotDen rationalMarginBoxPilotTree rationalMarginBoxPilot_accepts w hw

theorem rationalMarginBoxPilot_exists_positive_time (w : Fin 4 → ℕ)
    (hw : rationalMarginBoxPilotRoot.Contains w) :
    ∃ t : ℝ, 0 < t ∧ ∀ i, (rationalMarginBoxPilotNum i : ℝ) /
      (rationalMarginBoxPilotDen i : ℝ) ≤ circleNorm (t * (w i : ℝ)) :=
  rationalMarginBoxTreeOK_exists_positive_time rationalMarginBoxPilotRoot rationalMarginBoxPilotNum
    rationalMarginBoxPilotDen rationalMarginBoxPilotTree rationalMarginBoxPilot_accepts w hw

theorem rationalMarginBoxPilot_repeated_coordinates :
    ∃ p q : ℕ, 0 < p ∧ rationalMarginRowOK ![3, 3, 5, 8]
      rationalMarginBoxPilotNum rationalMarginBoxPilotDen p q = true :=
  rationalMarginBoxPilot_row ![3, 3, 5, 8] (by
    intro i
    fin_cases i <;> decide)

theorem rationalMarginBoxPilot_left_boundary_row :
    ∃ p q : ℕ, 0 < p ∧ rationalMarginRowOK ![2, 3, 5, 7]
      rationalMarginBoxPilotNum rationalMarginBoxPilotDen p q = true :=
  rationalMarginBoxPilot_row ![2, 3, 5, 7] (by
    intro i
    fin_cases i <;> decide)

theorem rationalMarginBoxPilot_right_boundary_row :
    ∃ p q : ℕ, 0 < p ∧ rationalMarginRowOK ![2, 3, 5, 8]
      rationalMarginBoxPilotNum rationalMarginBoxPilotDen p q = true :=
  rationalMarginBoxPilot_row ![2, 3, 5, 8] (by
    intro i
    fin_cases i <;> decide)

def rationalMarginBoxPilotLeafCount {n : ℕ} : RationalMarginBoxTree n → ℕ
  | .leaf _ => 1
  | .split _ _ left right => rationalMarginBoxPilotLeafCount left + rationalMarginBoxPilotLeafCount right

theorem rationalMarginBoxPilot_two_leaves : rationalMarginBoxPilotLeafCount rationalMarginBoxPilotTree = 2 := by
  decide

theorem rationalMarginBoxPilot_zero_margin_integer_upper_accepts :
    rationalMarginBoxTreeOK ⟨![1], ![1]⟩ ![0] ![1] (.leaf ⟨1, 1, ![0]⟩) = true := by
  decide

theorem rationalMarginBoxPilot_zero_speed_zero_margin_accepts :
    rationalMarginBoxTreeOK ⟨![0], ![0]⟩ ![0] ![1] (.leaf ⟨1, 1, ![0]⟩) = true := by
  decide

theorem rationalMarginBoxPilot_half_closed_accepts :
    rationalMarginBoxTreeOK ⟨![1], ![1]⟩ ![1] ![2] (.leaf ⟨1, 2, ![0]⟩) = true := by
  decide

theorem rationalMarginBoxPilot_above_half_rejects :
    rationalMarginBoxTreeOK ⟨![1], ![1]⟩ ![2] ![3] (.leaf ⟨1, 2, ![0]⟩) = false := by
  decide

theorem rationalMarginBoxPilot_zero_den_rejects :
    rationalMarginBoxTreeOK ⟨![1], ![1]⟩ ![0] ![0] (.leaf ⟨1, 1, ![0]⟩) = false := by
  decide

theorem rationalMarginBoxPilot_zero_q_rejects :
    rationalMarginBoxTreeOK ⟨![1], ![1]⟩ ![0] ![1] (.leaf ⟨1, 0, ![0]⟩) = false := by
  decide

theorem rationalMarginBoxPilot_zero_p_rejects :
    rationalMarginBoxTreeOK ⟨![1], ![1]⟩ ![0] ![1] (.leaf ⟨0, 1, ![0]⟩) = false := by
  decide

theorem rationalMarginBoxPilot_raw_empty_accepts :
    rationalMarginBandLeafOK ⟨![1], ![0]⟩ ![0] ![1] ⟨1, 1, ![0]⟩ = true := by
  decide

theorem rationalMarginBoxPilot_public_empty_rejects :
    rationalMarginBoxTreeOK ⟨![1], ![0]⟩ ![0] ![1] (.leaf ⟨1, 1, ![0]⟩) = false := by
  decide

theorem rationalMarginBoxPilot_fin_zero_accepts :
    rationalMarginBoxTreeOK
      ⟨(fun i => Fin.elim0 i), (fun i => Fin.elim0 i)⟩
      (fun i => Fin.elim0 i) (fun i => Fin.elim0 i)
      (.leaf ⟨1, 1, fun i => Fin.elim0 i⟩) = true := by
  decide

end LonelyRunner
