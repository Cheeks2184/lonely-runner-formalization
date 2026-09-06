import LonelyRunner.FiniteMaskCertificates

namespace LonelyRunner

/-- If a mask is unchanged by intersection with another mask, every bounded
candidate selected by the first mask is also selected by the second. -/
theorem maskCandidates_subset_of_and_eq (B small large : Nat)
    (h : small &&& large = small) :
    maskCandidates B small ⊆ maskCandidates B large := by
  intro k hk
  have hsmall : small.testBit k.val = true := mem_maskCandidates.mp hk
  apply mem_maskCandidates.mpr
  have hbit := congrArg (fun n : Nat => n.testBit k.val) h
  simpa [Nat.testBit_land, hsmall] using hbit

end LonelyRunner
