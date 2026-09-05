import LonelyRunner.Prompt100TwoOwnerCounts

namespace LonelyRunner

/-- At N=7 and kernel 7, the normalized count has a direct quotient form. -/
theorem normalizedBadCount_seven_seven (P : Nat) :
    normalizedBadCount 7 7 P = 6 * (2 * ((P - 1) / 7) + 1) := by
  simp [normalizedBadCount]
  omega

/-- The kernel-one N=7 count obeys its uniform linear budget. -/
theorem normalizedBadCount_seven_one_bound (P : Nat) (hP : 0 < P) :
    7 * normalizedBadCount 7 1 P ≤ 12 * P := by
  simp [normalizedBadCount]
  omega

/-- The kernel-seven count has the reviewed coarse N=7 bound. -/
theorem normalizedBadCount_seven_seven_bound (P : Nat) (hP : 8 ≤ P) :
    4 * normalizedBadCount 7 7 P ≤ 9 * P := by
  rw [normalizedBadCount_seven_seven]
  omega

/-- Above the first exceptional denominator, the kernel-seven count is at most twice P. -/
theorem normalizedBadCount_seven_seven_le_two (P : Nat) (hP : 9 ≤ P) :
    normalizedBadCount 7 7 P ≤ 2 * P := by
  rw [normalizedBadCount_seven_seven]
  omega

/-- Away from the listed reduced-denominator exceptions, the strict remainder budget holds. -/
theorem normalizedBadCount_seven_seven_lt_remainder_budget (P : Nat)
    (hP : 9 ≤ P) (h9 : P ≠ 9) (h15 : P ≠ 15) (h16 : P ≠ 16) (h22 : P ≠ 22) :
    8 * normalizedBadCount 7 7 P < 15 * P := by
  rw [normalizedBadCount_seven_seven]
  omega

end LonelyRunner
