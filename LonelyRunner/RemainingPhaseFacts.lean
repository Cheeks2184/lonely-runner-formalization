import LonelyRunner.RemainingPhaseData
import LonelyRunner.AffinePhaseCertificate
import LonelyRunner.FiniteMaskCertificates
import LonelyRunner.FiniteMaskSubset
import Mathlib.Tactic

/-!
# Checked finite facts for the fixed remaining phase data

Every finite row below is a literal ordinary-kernel `decide` proof.  This
module supplies data facts only; it does not assert a real phase theorem or a
new runner-count theorem.
-/

namespace LonelyRunner

set_option maxHeartbeats 1000000
set_option maxRecDepth 4096

/-- Every fixed 6.1 candidate slope is positive. -/
theorem remainingSixOneSlope_pos : ∀ k : Fin 24, 0 < remainingSixOneSlopes k := by decide
/-- Every fixed initially-safe 6.4 candidate slope is positive. -/
theorem remainingSixFourSlope_pos : ∀ k : Fin 15, 0 < remainingSixFourSlopes k := by decide

/-- All weight-two 6.1 atom masks fit in their 24 candidate bits. -/
theorem remainingSixOneWeightTwoAtomMasks_lt : ∀ a : Fin 120,
    remainingSixOneWeightTwoAtomMasks a < 2 ^ 24 := by decide
/-- All weight-one 6.1 atom masks fit in their 24 candidate bits. -/
theorem remainingSixOneWeightOneAtomMasks_lt : ∀ a : Fin 120,
    remainingSixOneWeightOneAtomMasks a < 2 ^ 24 := by decide
/-- All initially-safe 6.4 atom masks fit in their 15 candidate bits. -/
theorem remainingSixFourAtomMasks_lt : ∀ a : Fin 81,
    remainingSixFourAtomMasks a < 2 ^ 15 := by decide
/-- All weight-two 6.1 core masks fit in their 24 candidate bits. -/
theorem remainingSixOneWeightTwoCoreMasks_lt : ∀ i : Fin 42,
    remainingSixOneWeightTwoCoreMasks i < 2 ^ 24 := by decide
/-- All weight-one 6.1 core masks fit in their 24 candidate bits. -/
theorem remainingSixOneWeightOneCoreMasks_lt : ∀ i : Fin 42,
    remainingSixOneWeightOneCoreMasks i < 2 ^ 24 := by decide
/-- All initially-safe 6.4 core masks fit in their 15 candidate bits. -/
theorem remainingSixFourCoreMasks_lt : ∀ i : Fin 26,
    remainingSixFourCoreMasks i < 2 ^ 15 := by decide

/-- Each retained weight-two 6.1 core is its listed representative atom mask. -/
theorem remainingSixOneWeightTwoCoreAtoms_masks : ∀ i : Fin 42,
    remainingSixOneWeightTwoAtomMasks (remainingSixOneWeightTwoCoreAtoms i) =
      remainingSixOneWeightTwoCoreMasks i := by decide
/-- Each retained weight-one 6.1 core is its listed representative atom mask. -/
theorem remainingSixOneWeightOneCoreAtoms_masks : ∀ i : Fin 42,
    remainingSixOneWeightOneAtomMasks (remainingSixOneWeightOneCoreAtoms i) =
      remainingSixOneWeightOneCoreMasks i := by decide
/-- Each retained 6.4 core is its listed representative atom mask. -/
theorem remainingSixFourCoreAtoms_masks : ∀ i : Fin 26,
    remainingSixFourAtomMasks (remainingSixFourCoreAtoms i) = remainingSixFourCoreMasks i := by decide

/-- Every listed weight-two core is a bitwise subset of its dominated atom. -/
theorem remainingSixOneWeightTwoDominators_and : ∀ a : Fin 120,
    remainingSixOneWeightTwoCoreMasks (remainingSixOneWeightTwoDominators a) &&&
        remainingSixOneWeightTwoAtomMasks a =
      remainingSixOneWeightTwoCoreMasks (remainingSixOneWeightTwoDominators a) := by decide
/-- Every listed weight-one core is a bitwise subset of its dominated atom. -/
theorem remainingSixOneWeightOneDominators_and : ∀ a : Fin 120,
    remainingSixOneWeightOneCoreMasks (remainingSixOneWeightOneDominators a) &&&
        remainingSixOneWeightOneAtomMasks a =
      remainingSixOneWeightOneCoreMasks (remainingSixOneWeightOneDominators a) := by decide
/-- Every listed 6.4 core is a bitwise subset of its dominated atom. -/
theorem remainingSixFourDominators_and : ∀ a : Fin 81,
    remainingSixFourCoreMasks (remainingSixFourDominators a) &&& remainingSixFourAtomMasks a =
      remainingSixFourCoreMasks (remainingSixFourDominators a) := by decide

private abbrev RemainingSixOneWeightTwoAtomBandRow (a : Fin 120) : Prop :=
  (∀ k : Fin 24, a.val % 2 = 0 → (remainingSixOneWeightTwoAtomMasks a).testBit k.val = true →
    if remainingSixOneStrict k then
      120 < affineSixthNumerator renaultPhaseCuts a (remainingSixOneSlopes k) (remainingSixOneWeightTwoShift k) % 720 ∧
        affineSixthNumerator renaultPhaseCuts a (remainingSixOneSlopes k) (remainingSixOneWeightTwoShift k) % 720 < 600
    else
      120 ≤ affineSixthNumerator renaultPhaseCuts a (remainingSixOneSlopes k) (remainingSixOneWeightTwoShift k) % 720 ∧
        affineSixthNumerator renaultPhaseCuts a (remainingSixOneSlopes k) (remainingSixOneWeightTwoShift k) % 720 ≤ 600) ∧
  (∀ k : Fin 24, a.val % 2 ≠ 0 → (remainingSixOneWeightTwoAtomMasks a).testBit k.val = true →
    360 * affineSixthQuotient renaultPhaseCuts a (remainingSixOneSlopes k) (remainingSixOneWeightTwoShift k) + 60 ≤
      remainingSixOneSlopes k * renaultPhaseCuts (a.val / 2) + 60 * remainingSixOneWeightTwoShift k ∧
    remainingSixOneSlopes k * renaultPhaseCuts (a.val / 2 + 1) + 60 * remainingSixOneWeightTwoShift k ≤
      360 * affineSixthQuotient renaultPhaseCuts a (remainingSixOneSlopes k) (remainingSixOneWeightTwoShift k) + 300)

private abbrev RemainingSixOneWeightOneAtomBandRow (a : Fin 120) : Prop :=
  (∀ k : Fin 24, a.val % 2 = 0 → (remainingSixOneWeightOneAtomMasks a).testBit k.val = true →
    if remainingSixOneStrict k then
      120 < affineSixthNumerator renaultPhaseCuts a (remainingSixOneSlopes k) (remainingSixOneWeightOneShift k) % 720 ∧
        affineSixthNumerator renaultPhaseCuts a (remainingSixOneSlopes k) (remainingSixOneWeightOneShift k) % 720 < 600
    else
      120 ≤ affineSixthNumerator renaultPhaseCuts a (remainingSixOneSlopes k) (remainingSixOneWeightOneShift k) % 720 ∧
        affineSixthNumerator renaultPhaseCuts a (remainingSixOneSlopes k) (remainingSixOneWeightOneShift k) % 720 ≤ 600) ∧
  (∀ k : Fin 24, a.val % 2 ≠ 0 → (remainingSixOneWeightOneAtomMasks a).testBit k.val = true →
    360 * affineSixthQuotient renaultPhaseCuts a (remainingSixOneSlopes k) (remainingSixOneWeightOneShift k) + 60 ≤
      remainingSixOneSlopes k * renaultPhaseCuts (a.val / 2) + 60 * remainingSixOneWeightOneShift k ∧
    remainingSixOneSlopes k * renaultPhaseCuts (a.val / 2 + 1) + 60 * remainingSixOneWeightOneShift k ≤
      360 * affineSixthQuotient renaultPhaseCuts a (remainingSixOneSlopes k) (remainingSixOneWeightOneShift k) + 300)

private abbrev RemainingSixFourAtomBandRow (a : Fin 81) : Prop :=
  (∀ k : Fin 15, a.val % 2 = 0 → (remainingSixFourAtomMasks a).testBit k.val = true →
    if remainingSixFourStrict k then
      120 < affineSixthNumerator remainingSixFourCuts a (remainingSixFourSlopes k) (remainingSixFourShifts k) % 720 ∧
        affineSixthNumerator remainingSixFourCuts a (remainingSixFourSlopes k) (remainingSixFourShifts k) % 720 < 600
    else
      120 ≤ affineSixthNumerator remainingSixFourCuts a (remainingSixFourSlopes k) (remainingSixFourShifts k) % 720 ∧
        affineSixthNumerator remainingSixFourCuts a (remainingSixFourSlopes k) (remainingSixFourShifts k) % 720 ≤ 600) ∧
  (∀ k : Fin 15, a.val % 2 ≠ 0 → (remainingSixFourAtomMasks a).testBit k.val = true →
    360 * affineSixthQuotient remainingSixFourCuts a (remainingSixFourSlopes k) (remainingSixFourShifts k) + 60 ≤
      remainingSixFourSlopes k * remainingSixFourCuts (a.val / 2) + 60 * remainingSixFourShifts k ∧
    remainingSixFourSlopes k * remainingSixFourCuts (a.val / 2 + 1) + 60 * remainingSixFourShifts k ≤
      360 * affineSixthQuotient remainingSixFourCuts a (remainingSixFourSlopes k) (remainingSixFourShifts k) + 300)

private theorem remainingSixOneWeightTwoAtomBandRow_0 : RemainingSixOneWeightTwoAtomBandRow 0 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_1 : RemainingSixOneWeightTwoAtomBandRow 1 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_2 : RemainingSixOneWeightTwoAtomBandRow 2 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_3 : RemainingSixOneWeightTwoAtomBandRow 3 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_4 : RemainingSixOneWeightTwoAtomBandRow 4 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_5 : RemainingSixOneWeightTwoAtomBandRow 5 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_6 : RemainingSixOneWeightTwoAtomBandRow 6 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_7 : RemainingSixOneWeightTwoAtomBandRow 7 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_8 : RemainingSixOneWeightTwoAtomBandRow 8 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_9 : RemainingSixOneWeightTwoAtomBandRow 9 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_10 : RemainingSixOneWeightTwoAtomBandRow 10 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_11 : RemainingSixOneWeightTwoAtomBandRow 11 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_12 : RemainingSixOneWeightTwoAtomBandRow 12 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_13 : RemainingSixOneWeightTwoAtomBandRow 13 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_14 : RemainingSixOneWeightTwoAtomBandRow 14 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_15 : RemainingSixOneWeightTwoAtomBandRow 15 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_16 : RemainingSixOneWeightTwoAtomBandRow 16 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_17 : RemainingSixOneWeightTwoAtomBandRow 17 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_18 : RemainingSixOneWeightTwoAtomBandRow 18 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_19 : RemainingSixOneWeightTwoAtomBandRow 19 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_20 : RemainingSixOneWeightTwoAtomBandRow 20 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_21 : RemainingSixOneWeightTwoAtomBandRow 21 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_22 : RemainingSixOneWeightTwoAtomBandRow 22 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_23 : RemainingSixOneWeightTwoAtomBandRow 23 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_24 : RemainingSixOneWeightTwoAtomBandRow 24 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_25 : RemainingSixOneWeightTwoAtomBandRow 25 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_26 : RemainingSixOneWeightTwoAtomBandRow 26 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_27 : RemainingSixOneWeightTwoAtomBandRow 27 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_28 : RemainingSixOneWeightTwoAtomBandRow 28 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_29 : RemainingSixOneWeightTwoAtomBandRow 29 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_30 : RemainingSixOneWeightTwoAtomBandRow 30 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_31 : RemainingSixOneWeightTwoAtomBandRow 31 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_32 : RemainingSixOneWeightTwoAtomBandRow 32 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_33 : RemainingSixOneWeightTwoAtomBandRow 33 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_34 : RemainingSixOneWeightTwoAtomBandRow 34 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_35 : RemainingSixOneWeightTwoAtomBandRow 35 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_36 : RemainingSixOneWeightTwoAtomBandRow 36 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_37 : RemainingSixOneWeightTwoAtomBandRow 37 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_38 : RemainingSixOneWeightTwoAtomBandRow 38 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_39 : RemainingSixOneWeightTwoAtomBandRow 39 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_40 : RemainingSixOneWeightTwoAtomBandRow 40 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_41 : RemainingSixOneWeightTwoAtomBandRow 41 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_42 : RemainingSixOneWeightTwoAtomBandRow 42 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_43 : RemainingSixOneWeightTwoAtomBandRow 43 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_44 : RemainingSixOneWeightTwoAtomBandRow 44 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_45 : RemainingSixOneWeightTwoAtomBandRow 45 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_46 : RemainingSixOneWeightTwoAtomBandRow 46 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_47 : RemainingSixOneWeightTwoAtomBandRow 47 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_48 : RemainingSixOneWeightTwoAtomBandRow 48 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_49 : RemainingSixOneWeightTwoAtomBandRow 49 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_50 : RemainingSixOneWeightTwoAtomBandRow 50 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_51 : RemainingSixOneWeightTwoAtomBandRow 51 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_52 : RemainingSixOneWeightTwoAtomBandRow 52 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_53 : RemainingSixOneWeightTwoAtomBandRow 53 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_54 : RemainingSixOneWeightTwoAtomBandRow 54 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_55 : RemainingSixOneWeightTwoAtomBandRow 55 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_56 : RemainingSixOneWeightTwoAtomBandRow 56 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_57 : RemainingSixOneWeightTwoAtomBandRow 57 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_58 : RemainingSixOneWeightTwoAtomBandRow 58 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_59 : RemainingSixOneWeightTwoAtomBandRow 59 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_60 : RemainingSixOneWeightTwoAtomBandRow 60 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_61 : RemainingSixOneWeightTwoAtomBandRow 61 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_62 : RemainingSixOneWeightTwoAtomBandRow 62 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_63 : RemainingSixOneWeightTwoAtomBandRow 63 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_64 : RemainingSixOneWeightTwoAtomBandRow 64 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_65 : RemainingSixOneWeightTwoAtomBandRow 65 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_66 : RemainingSixOneWeightTwoAtomBandRow 66 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_67 : RemainingSixOneWeightTwoAtomBandRow 67 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_68 : RemainingSixOneWeightTwoAtomBandRow 68 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_69 : RemainingSixOneWeightTwoAtomBandRow 69 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_70 : RemainingSixOneWeightTwoAtomBandRow 70 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_71 : RemainingSixOneWeightTwoAtomBandRow 71 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_72 : RemainingSixOneWeightTwoAtomBandRow 72 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_73 : RemainingSixOneWeightTwoAtomBandRow 73 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_74 : RemainingSixOneWeightTwoAtomBandRow 74 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_75 : RemainingSixOneWeightTwoAtomBandRow 75 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_76 : RemainingSixOneWeightTwoAtomBandRow 76 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_77 : RemainingSixOneWeightTwoAtomBandRow 77 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_78 : RemainingSixOneWeightTwoAtomBandRow 78 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_79 : RemainingSixOneWeightTwoAtomBandRow 79 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_80 : RemainingSixOneWeightTwoAtomBandRow 80 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_81 : RemainingSixOneWeightTwoAtomBandRow 81 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_82 : RemainingSixOneWeightTwoAtomBandRow 82 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_83 : RemainingSixOneWeightTwoAtomBandRow 83 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_84 : RemainingSixOneWeightTwoAtomBandRow 84 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_85 : RemainingSixOneWeightTwoAtomBandRow 85 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_86 : RemainingSixOneWeightTwoAtomBandRow 86 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_87 : RemainingSixOneWeightTwoAtomBandRow 87 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_88 : RemainingSixOneWeightTwoAtomBandRow 88 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_89 : RemainingSixOneWeightTwoAtomBandRow 89 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_90 : RemainingSixOneWeightTwoAtomBandRow 90 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_91 : RemainingSixOneWeightTwoAtomBandRow 91 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_92 : RemainingSixOneWeightTwoAtomBandRow 92 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_93 : RemainingSixOneWeightTwoAtomBandRow 93 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_94 : RemainingSixOneWeightTwoAtomBandRow 94 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_95 : RemainingSixOneWeightTwoAtomBandRow 95 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_96 : RemainingSixOneWeightTwoAtomBandRow 96 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_97 : RemainingSixOneWeightTwoAtomBandRow 97 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_98 : RemainingSixOneWeightTwoAtomBandRow 98 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_99 : RemainingSixOneWeightTwoAtomBandRow 99 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_100 : RemainingSixOneWeightTwoAtomBandRow 100 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_101 : RemainingSixOneWeightTwoAtomBandRow 101 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_102 : RemainingSixOneWeightTwoAtomBandRow 102 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_103 : RemainingSixOneWeightTwoAtomBandRow 103 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_104 : RemainingSixOneWeightTwoAtomBandRow 104 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_105 : RemainingSixOneWeightTwoAtomBandRow 105 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_106 : RemainingSixOneWeightTwoAtomBandRow 106 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_107 : RemainingSixOneWeightTwoAtomBandRow 107 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_108 : RemainingSixOneWeightTwoAtomBandRow 108 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_109 : RemainingSixOneWeightTwoAtomBandRow 109 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_110 : RemainingSixOneWeightTwoAtomBandRow 110 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_111 : RemainingSixOneWeightTwoAtomBandRow 111 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_112 : RemainingSixOneWeightTwoAtomBandRow 112 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_113 : RemainingSixOneWeightTwoAtomBandRow 113 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_114 : RemainingSixOneWeightTwoAtomBandRow 114 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_115 : RemainingSixOneWeightTwoAtomBandRow 115 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_116 : RemainingSixOneWeightTwoAtomBandRow 116 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_117 : RemainingSixOneWeightTwoAtomBandRow 117 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_118 : RemainingSixOneWeightTwoAtomBandRow 118 := by decide

private theorem remainingSixOneWeightTwoAtomBandRow_119 : RemainingSixOneWeightTwoAtomBandRow 119 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_0 : RemainingSixOneWeightOneAtomBandRow 0 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_1 : RemainingSixOneWeightOneAtomBandRow 1 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_2 : RemainingSixOneWeightOneAtomBandRow 2 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_3 : RemainingSixOneWeightOneAtomBandRow 3 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_4 : RemainingSixOneWeightOneAtomBandRow 4 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_5 : RemainingSixOneWeightOneAtomBandRow 5 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_6 : RemainingSixOneWeightOneAtomBandRow 6 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_7 : RemainingSixOneWeightOneAtomBandRow 7 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_8 : RemainingSixOneWeightOneAtomBandRow 8 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_9 : RemainingSixOneWeightOneAtomBandRow 9 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_10 : RemainingSixOneWeightOneAtomBandRow 10 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_11 : RemainingSixOneWeightOneAtomBandRow 11 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_12 : RemainingSixOneWeightOneAtomBandRow 12 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_13 : RemainingSixOneWeightOneAtomBandRow 13 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_14 : RemainingSixOneWeightOneAtomBandRow 14 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_15 : RemainingSixOneWeightOneAtomBandRow 15 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_16 : RemainingSixOneWeightOneAtomBandRow 16 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_17 : RemainingSixOneWeightOneAtomBandRow 17 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_18 : RemainingSixOneWeightOneAtomBandRow 18 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_19 : RemainingSixOneWeightOneAtomBandRow 19 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_20 : RemainingSixOneWeightOneAtomBandRow 20 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_21 : RemainingSixOneWeightOneAtomBandRow 21 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_22 : RemainingSixOneWeightOneAtomBandRow 22 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_23 : RemainingSixOneWeightOneAtomBandRow 23 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_24 : RemainingSixOneWeightOneAtomBandRow 24 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_25 : RemainingSixOneWeightOneAtomBandRow 25 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_26 : RemainingSixOneWeightOneAtomBandRow 26 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_27 : RemainingSixOneWeightOneAtomBandRow 27 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_28 : RemainingSixOneWeightOneAtomBandRow 28 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_29 : RemainingSixOneWeightOneAtomBandRow 29 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_30 : RemainingSixOneWeightOneAtomBandRow 30 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_31 : RemainingSixOneWeightOneAtomBandRow 31 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_32 : RemainingSixOneWeightOneAtomBandRow 32 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_33 : RemainingSixOneWeightOneAtomBandRow 33 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_34 : RemainingSixOneWeightOneAtomBandRow 34 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_35 : RemainingSixOneWeightOneAtomBandRow 35 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_36 : RemainingSixOneWeightOneAtomBandRow 36 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_37 : RemainingSixOneWeightOneAtomBandRow 37 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_38 : RemainingSixOneWeightOneAtomBandRow 38 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_39 : RemainingSixOneWeightOneAtomBandRow 39 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_40 : RemainingSixOneWeightOneAtomBandRow 40 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_41 : RemainingSixOneWeightOneAtomBandRow 41 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_42 : RemainingSixOneWeightOneAtomBandRow 42 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_43 : RemainingSixOneWeightOneAtomBandRow 43 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_44 : RemainingSixOneWeightOneAtomBandRow 44 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_45 : RemainingSixOneWeightOneAtomBandRow 45 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_46 : RemainingSixOneWeightOneAtomBandRow 46 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_47 : RemainingSixOneWeightOneAtomBandRow 47 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_48 : RemainingSixOneWeightOneAtomBandRow 48 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_49 : RemainingSixOneWeightOneAtomBandRow 49 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_50 : RemainingSixOneWeightOneAtomBandRow 50 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_51 : RemainingSixOneWeightOneAtomBandRow 51 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_52 : RemainingSixOneWeightOneAtomBandRow 52 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_53 : RemainingSixOneWeightOneAtomBandRow 53 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_54 : RemainingSixOneWeightOneAtomBandRow 54 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_55 : RemainingSixOneWeightOneAtomBandRow 55 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_56 : RemainingSixOneWeightOneAtomBandRow 56 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_57 : RemainingSixOneWeightOneAtomBandRow 57 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_58 : RemainingSixOneWeightOneAtomBandRow 58 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_59 : RemainingSixOneWeightOneAtomBandRow 59 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_60 : RemainingSixOneWeightOneAtomBandRow 60 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_61 : RemainingSixOneWeightOneAtomBandRow 61 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_62 : RemainingSixOneWeightOneAtomBandRow 62 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_63 : RemainingSixOneWeightOneAtomBandRow 63 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_64 : RemainingSixOneWeightOneAtomBandRow 64 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_65 : RemainingSixOneWeightOneAtomBandRow 65 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_66 : RemainingSixOneWeightOneAtomBandRow 66 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_67 : RemainingSixOneWeightOneAtomBandRow 67 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_68 : RemainingSixOneWeightOneAtomBandRow 68 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_69 : RemainingSixOneWeightOneAtomBandRow 69 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_70 : RemainingSixOneWeightOneAtomBandRow 70 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_71 : RemainingSixOneWeightOneAtomBandRow 71 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_72 : RemainingSixOneWeightOneAtomBandRow 72 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_73 : RemainingSixOneWeightOneAtomBandRow 73 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_74 : RemainingSixOneWeightOneAtomBandRow 74 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_75 : RemainingSixOneWeightOneAtomBandRow 75 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_76 : RemainingSixOneWeightOneAtomBandRow 76 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_77 : RemainingSixOneWeightOneAtomBandRow 77 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_78 : RemainingSixOneWeightOneAtomBandRow 78 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_79 : RemainingSixOneWeightOneAtomBandRow 79 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_80 : RemainingSixOneWeightOneAtomBandRow 80 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_81 : RemainingSixOneWeightOneAtomBandRow 81 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_82 : RemainingSixOneWeightOneAtomBandRow 82 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_83 : RemainingSixOneWeightOneAtomBandRow 83 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_84 : RemainingSixOneWeightOneAtomBandRow 84 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_85 : RemainingSixOneWeightOneAtomBandRow 85 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_86 : RemainingSixOneWeightOneAtomBandRow 86 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_87 : RemainingSixOneWeightOneAtomBandRow 87 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_88 : RemainingSixOneWeightOneAtomBandRow 88 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_89 : RemainingSixOneWeightOneAtomBandRow 89 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_90 : RemainingSixOneWeightOneAtomBandRow 90 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_91 : RemainingSixOneWeightOneAtomBandRow 91 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_92 : RemainingSixOneWeightOneAtomBandRow 92 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_93 : RemainingSixOneWeightOneAtomBandRow 93 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_94 : RemainingSixOneWeightOneAtomBandRow 94 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_95 : RemainingSixOneWeightOneAtomBandRow 95 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_96 : RemainingSixOneWeightOneAtomBandRow 96 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_97 : RemainingSixOneWeightOneAtomBandRow 97 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_98 : RemainingSixOneWeightOneAtomBandRow 98 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_99 : RemainingSixOneWeightOneAtomBandRow 99 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_100 : RemainingSixOneWeightOneAtomBandRow 100 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_101 : RemainingSixOneWeightOneAtomBandRow 101 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_102 : RemainingSixOneWeightOneAtomBandRow 102 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_103 : RemainingSixOneWeightOneAtomBandRow 103 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_104 : RemainingSixOneWeightOneAtomBandRow 104 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_105 : RemainingSixOneWeightOneAtomBandRow 105 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_106 : RemainingSixOneWeightOneAtomBandRow 106 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_107 : RemainingSixOneWeightOneAtomBandRow 107 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_108 : RemainingSixOneWeightOneAtomBandRow 108 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_109 : RemainingSixOneWeightOneAtomBandRow 109 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_110 : RemainingSixOneWeightOneAtomBandRow 110 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_111 : RemainingSixOneWeightOneAtomBandRow 111 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_112 : RemainingSixOneWeightOneAtomBandRow 112 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_113 : RemainingSixOneWeightOneAtomBandRow 113 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_114 : RemainingSixOneWeightOneAtomBandRow 114 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_115 : RemainingSixOneWeightOneAtomBandRow 115 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_116 : RemainingSixOneWeightOneAtomBandRow 116 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_117 : RemainingSixOneWeightOneAtomBandRow 117 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_118 : RemainingSixOneWeightOneAtomBandRow 118 := by decide

private theorem remainingSixOneWeightOneAtomBandRow_119 : RemainingSixOneWeightOneAtomBandRow 119 := by decide

private theorem remainingSixFourAtomBandRow_0 : RemainingSixFourAtomBandRow 0 := by decide

private theorem remainingSixFourAtomBandRow_1 : RemainingSixFourAtomBandRow 1 := by decide

private theorem remainingSixFourAtomBandRow_2 : RemainingSixFourAtomBandRow 2 := by decide

private theorem remainingSixFourAtomBandRow_3 : RemainingSixFourAtomBandRow 3 := by decide

private theorem remainingSixFourAtomBandRow_4 : RemainingSixFourAtomBandRow 4 := by decide

private theorem remainingSixFourAtomBandRow_5 : RemainingSixFourAtomBandRow 5 := by decide

private theorem remainingSixFourAtomBandRow_6 : RemainingSixFourAtomBandRow 6 := by decide

private theorem remainingSixFourAtomBandRow_7 : RemainingSixFourAtomBandRow 7 := by decide

private theorem remainingSixFourAtomBandRow_8 : RemainingSixFourAtomBandRow 8 := by decide

private theorem remainingSixFourAtomBandRow_9 : RemainingSixFourAtomBandRow 9 := by decide

private theorem remainingSixFourAtomBandRow_10 : RemainingSixFourAtomBandRow 10 := by decide

private theorem remainingSixFourAtomBandRow_11 : RemainingSixFourAtomBandRow 11 := by decide

private theorem remainingSixFourAtomBandRow_12 : RemainingSixFourAtomBandRow 12 := by decide

private theorem remainingSixFourAtomBandRow_13 : RemainingSixFourAtomBandRow 13 := by decide

private theorem remainingSixFourAtomBandRow_14 : RemainingSixFourAtomBandRow 14 := by decide

private theorem remainingSixFourAtomBandRow_15 : RemainingSixFourAtomBandRow 15 := by decide

private theorem remainingSixFourAtomBandRow_16 : RemainingSixFourAtomBandRow 16 := by decide

private theorem remainingSixFourAtomBandRow_17 : RemainingSixFourAtomBandRow 17 := by decide

private theorem remainingSixFourAtomBandRow_18 : RemainingSixFourAtomBandRow 18 := by decide

private theorem remainingSixFourAtomBandRow_19 : RemainingSixFourAtomBandRow 19 := by decide

private theorem remainingSixFourAtomBandRow_20 : RemainingSixFourAtomBandRow 20 := by decide

private theorem remainingSixFourAtomBandRow_21 : RemainingSixFourAtomBandRow 21 := by decide

private theorem remainingSixFourAtomBandRow_22 : RemainingSixFourAtomBandRow 22 := by decide

private theorem remainingSixFourAtomBandRow_23 : RemainingSixFourAtomBandRow 23 := by decide

private theorem remainingSixFourAtomBandRow_24 : RemainingSixFourAtomBandRow 24 := by decide

private theorem remainingSixFourAtomBandRow_25 : RemainingSixFourAtomBandRow 25 := by decide

private theorem remainingSixFourAtomBandRow_26 : RemainingSixFourAtomBandRow 26 := by decide

private theorem remainingSixFourAtomBandRow_27 : RemainingSixFourAtomBandRow 27 := by decide

private theorem remainingSixFourAtomBandRow_28 : RemainingSixFourAtomBandRow 28 := by decide

private theorem remainingSixFourAtomBandRow_29 : RemainingSixFourAtomBandRow 29 := by decide

private theorem remainingSixFourAtomBandRow_30 : RemainingSixFourAtomBandRow 30 := by decide

private theorem remainingSixFourAtomBandRow_31 : RemainingSixFourAtomBandRow 31 := by decide

private theorem remainingSixFourAtomBandRow_32 : RemainingSixFourAtomBandRow 32 := by decide

private theorem remainingSixFourAtomBandRow_33 : RemainingSixFourAtomBandRow 33 := by decide

private theorem remainingSixFourAtomBandRow_34 : RemainingSixFourAtomBandRow 34 := by decide

private theorem remainingSixFourAtomBandRow_35 : RemainingSixFourAtomBandRow 35 := by decide

private theorem remainingSixFourAtomBandRow_36 : RemainingSixFourAtomBandRow 36 := by decide

private theorem remainingSixFourAtomBandRow_37 : RemainingSixFourAtomBandRow 37 := by decide

private theorem remainingSixFourAtomBandRow_38 : RemainingSixFourAtomBandRow 38 := by decide

private theorem remainingSixFourAtomBandRow_39 : RemainingSixFourAtomBandRow 39 := by decide

private theorem remainingSixFourAtomBandRow_40 : RemainingSixFourAtomBandRow 40 := by decide

private theorem remainingSixFourAtomBandRow_41 : RemainingSixFourAtomBandRow 41 := by decide

private theorem remainingSixFourAtomBandRow_42 : RemainingSixFourAtomBandRow 42 := by decide

private theorem remainingSixFourAtomBandRow_43 : RemainingSixFourAtomBandRow 43 := by decide

private theorem remainingSixFourAtomBandRow_44 : RemainingSixFourAtomBandRow 44 := by decide

private theorem remainingSixFourAtomBandRow_45 : RemainingSixFourAtomBandRow 45 := by decide

private theorem remainingSixFourAtomBandRow_46 : RemainingSixFourAtomBandRow 46 := by decide

private theorem remainingSixFourAtomBandRow_47 : RemainingSixFourAtomBandRow 47 := by decide

private theorem remainingSixFourAtomBandRow_48 : RemainingSixFourAtomBandRow 48 := by decide

private theorem remainingSixFourAtomBandRow_49 : RemainingSixFourAtomBandRow 49 := by decide

private theorem remainingSixFourAtomBandRow_50 : RemainingSixFourAtomBandRow 50 := by decide

private theorem remainingSixFourAtomBandRow_51 : RemainingSixFourAtomBandRow 51 := by decide

private theorem remainingSixFourAtomBandRow_52 : RemainingSixFourAtomBandRow 52 := by decide

private theorem remainingSixFourAtomBandRow_53 : RemainingSixFourAtomBandRow 53 := by decide

private theorem remainingSixFourAtomBandRow_54 : RemainingSixFourAtomBandRow 54 := by decide

private theorem remainingSixFourAtomBandRow_55 : RemainingSixFourAtomBandRow 55 := by decide

private theorem remainingSixFourAtomBandRow_56 : RemainingSixFourAtomBandRow 56 := by decide

private theorem remainingSixFourAtomBandRow_57 : RemainingSixFourAtomBandRow 57 := by decide

private theorem remainingSixFourAtomBandRow_58 : RemainingSixFourAtomBandRow 58 := by decide

private theorem remainingSixFourAtomBandRow_59 : RemainingSixFourAtomBandRow 59 := by decide

private theorem remainingSixFourAtomBandRow_60 : RemainingSixFourAtomBandRow 60 := by decide

private theorem remainingSixFourAtomBandRow_61 : RemainingSixFourAtomBandRow 61 := by decide

private theorem remainingSixFourAtomBandRow_62 : RemainingSixFourAtomBandRow 62 := by decide

private theorem remainingSixFourAtomBandRow_63 : RemainingSixFourAtomBandRow 63 := by decide

private theorem remainingSixFourAtomBandRow_64 : RemainingSixFourAtomBandRow 64 := by decide

private theorem remainingSixFourAtomBandRow_65 : RemainingSixFourAtomBandRow 65 := by decide

private theorem remainingSixFourAtomBandRow_66 : RemainingSixFourAtomBandRow 66 := by decide

private theorem remainingSixFourAtomBandRow_67 : RemainingSixFourAtomBandRow 67 := by decide

private theorem remainingSixFourAtomBandRow_68 : RemainingSixFourAtomBandRow 68 := by decide

private theorem remainingSixFourAtomBandRow_69 : RemainingSixFourAtomBandRow 69 := by decide

private theorem remainingSixFourAtomBandRow_70 : RemainingSixFourAtomBandRow 70 := by decide

private theorem remainingSixFourAtomBandRow_71 : RemainingSixFourAtomBandRow 71 := by decide

private theorem remainingSixFourAtomBandRow_72 : RemainingSixFourAtomBandRow 72 := by decide

private theorem remainingSixFourAtomBandRow_73 : RemainingSixFourAtomBandRow 73 := by decide

private theorem remainingSixFourAtomBandRow_74 : RemainingSixFourAtomBandRow 74 := by decide

private theorem remainingSixFourAtomBandRow_75 : RemainingSixFourAtomBandRow 75 := by decide

private theorem remainingSixFourAtomBandRow_76 : RemainingSixFourAtomBandRow 76 := by decide

private theorem remainingSixFourAtomBandRow_77 : RemainingSixFourAtomBandRow 77 := by decide

private theorem remainingSixFourAtomBandRow_78 : RemainingSixFourAtomBandRow 78 := by decide

private theorem remainingSixFourAtomBandRow_79 : RemainingSixFourAtomBandRow 79 := by decide

private theorem remainingSixFourAtomBandRow_80 : RemainingSixFourAtomBandRow 80 := by decide

private theorem remainingSixOneWeightTwoAtomBandRows (a : Fin 120) : RemainingSixOneWeightTwoAtomBandRow a := by
  fin_cases a
  · exact remainingSixOneWeightTwoAtomBandRow_0
  · exact remainingSixOneWeightTwoAtomBandRow_1
  · exact remainingSixOneWeightTwoAtomBandRow_2
  · exact remainingSixOneWeightTwoAtomBandRow_3
  · exact remainingSixOneWeightTwoAtomBandRow_4
  · exact remainingSixOneWeightTwoAtomBandRow_5
  · exact remainingSixOneWeightTwoAtomBandRow_6
  · exact remainingSixOneWeightTwoAtomBandRow_7
  · exact remainingSixOneWeightTwoAtomBandRow_8
  · exact remainingSixOneWeightTwoAtomBandRow_9
  · exact remainingSixOneWeightTwoAtomBandRow_10
  · exact remainingSixOneWeightTwoAtomBandRow_11
  · exact remainingSixOneWeightTwoAtomBandRow_12
  · exact remainingSixOneWeightTwoAtomBandRow_13
  · exact remainingSixOneWeightTwoAtomBandRow_14
  · exact remainingSixOneWeightTwoAtomBandRow_15
  · exact remainingSixOneWeightTwoAtomBandRow_16
  · exact remainingSixOneWeightTwoAtomBandRow_17
  · exact remainingSixOneWeightTwoAtomBandRow_18
  · exact remainingSixOneWeightTwoAtomBandRow_19
  · exact remainingSixOneWeightTwoAtomBandRow_20
  · exact remainingSixOneWeightTwoAtomBandRow_21
  · exact remainingSixOneWeightTwoAtomBandRow_22
  · exact remainingSixOneWeightTwoAtomBandRow_23
  · exact remainingSixOneWeightTwoAtomBandRow_24
  · exact remainingSixOneWeightTwoAtomBandRow_25
  · exact remainingSixOneWeightTwoAtomBandRow_26
  · exact remainingSixOneWeightTwoAtomBandRow_27
  · exact remainingSixOneWeightTwoAtomBandRow_28
  · exact remainingSixOneWeightTwoAtomBandRow_29
  · exact remainingSixOneWeightTwoAtomBandRow_30
  · exact remainingSixOneWeightTwoAtomBandRow_31
  · exact remainingSixOneWeightTwoAtomBandRow_32
  · exact remainingSixOneWeightTwoAtomBandRow_33
  · exact remainingSixOneWeightTwoAtomBandRow_34
  · exact remainingSixOneWeightTwoAtomBandRow_35
  · exact remainingSixOneWeightTwoAtomBandRow_36
  · exact remainingSixOneWeightTwoAtomBandRow_37
  · exact remainingSixOneWeightTwoAtomBandRow_38
  · exact remainingSixOneWeightTwoAtomBandRow_39
  · exact remainingSixOneWeightTwoAtomBandRow_40
  · exact remainingSixOneWeightTwoAtomBandRow_41
  · exact remainingSixOneWeightTwoAtomBandRow_42
  · exact remainingSixOneWeightTwoAtomBandRow_43
  · exact remainingSixOneWeightTwoAtomBandRow_44
  · exact remainingSixOneWeightTwoAtomBandRow_45
  · exact remainingSixOneWeightTwoAtomBandRow_46
  · exact remainingSixOneWeightTwoAtomBandRow_47
  · exact remainingSixOneWeightTwoAtomBandRow_48
  · exact remainingSixOneWeightTwoAtomBandRow_49
  · exact remainingSixOneWeightTwoAtomBandRow_50
  · exact remainingSixOneWeightTwoAtomBandRow_51
  · exact remainingSixOneWeightTwoAtomBandRow_52
  · exact remainingSixOneWeightTwoAtomBandRow_53
  · exact remainingSixOneWeightTwoAtomBandRow_54
  · exact remainingSixOneWeightTwoAtomBandRow_55
  · exact remainingSixOneWeightTwoAtomBandRow_56
  · exact remainingSixOneWeightTwoAtomBandRow_57
  · exact remainingSixOneWeightTwoAtomBandRow_58
  · exact remainingSixOneWeightTwoAtomBandRow_59
  · exact remainingSixOneWeightTwoAtomBandRow_60
  · exact remainingSixOneWeightTwoAtomBandRow_61
  · exact remainingSixOneWeightTwoAtomBandRow_62
  · exact remainingSixOneWeightTwoAtomBandRow_63
  · exact remainingSixOneWeightTwoAtomBandRow_64
  · exact remainingSixOneWeightTwoAtomBandRow_65
  · exact remainingSixOneWeightTwoAtomBandRow_66
  · exact remainingSixOneWeightTwoAtomBandRow_67
  · exact remainingSixOneWeightTwoAtomBandRow_68
  · exact remainingSixOneWeightTwoAtomBandRow_69
  · exact remainingSixOneWeightTwoAtomBandRow_70
  · exact remainingSixOneWeightTwoAtomBandRow_71
  · exact remainingSixOneWeightTwoAtomBandRow_72
  · exact remainingSixOneWeightTwoAtomBandRow_73
  · exact remainingSixOneWeightTwoAtomBandRow_74
  · exact remainingSixOneWeightTwoAtomBandRow_75
  · exact remainingSixOneWeightTwoAtomBandRow_76
  · exact remainingSixOneWeightTwoAtomBandRow_77
  · exact remainingSixOneWeightTwoAtomBandRow_78
  · exact remainingSixOneWeightTwoAtomBandRow_79
  · exact remainingSixOneWeightTwoAtomBandRow_80
  · exact remainingSixOneWeightTwoAtomBandRow_81
  · exact remainingSixOneWeightTwoAtomBandRow_82
  · exact remainingSixOneWeightTwoAtomBandRow_83
  · exact remainingSixOneWeightTwoAtomBandRow_84
  · exact remainingSixOneWeightTwoAtomBandRow_85
  · exact remainingSixOneWeightTwoAtomBandRow_86
  · exact remainingSixOneWeightTwoAtomBandRow_87
  · exact remainingSixOneWeightTwoAtomBandRow_88
  · exact remainingSixOneWeightTwoAtomBandRow_89
  · exact remainingSixOneWeightTwoAtomBandRow_90
  · exact remainingSixOneWeightTwoAtomBandRow_91
  · exact remainingSixOneWeightTwoAtomBandRow_92
  · exact remainingSixOneWeightTwoAtomBandRow_93
  · exact remainingSixOneWeightTwoAtomBandRow_94
  · exact remainingSixOneWeightTwoAtomBandRow_95
  · exact remainingSixOneWeightTwoAtomBandRow_96
  · exact remainingSixOneWeightTwoAtomBandRow_97
  · exact remainingSixOneWeightTwoAtomBandRow_98
  · exact remainingSixOneWeightTwoAtomBandRow_99
  · exact remainingSixOneWeightTwoAtomBandRow_100
  · exact remainingSixOneWeightTwoAtomBandRow_101
  · exact remainingSixOneWeightTwoAtomBandRow_102
  · exact remainingSixOneWeightTwoAtomBandRow_103
  · exact remainingSixOneWeightTwoAtomBandRow_104
  · exact remainingSixOneWeightTwoAtomBandRow_105
  · exact remainingSixOneWeightTwoAtomBandRow_106
  · exact remainingSixOneWeightTwoAtomBandRow_107
  · exact remainingSixOneWeightTwoAtomBandRow_108
  · exact remainingSixOneWeightTwoAtomBandRow_109
  · exact remainingSixOneWeightTwoAtomBandRow_110
  · exact remainingSixOneWeightTwoAtomBandRow_111
  · exact remainingSixOneWeightTwoAtomBandRow_112
  · exact remainingSixOneWeightTwoAtomBandRow_113
  · exact remainingSixOneWeightTwoAtomBandRow_114
  · exact remainingSixOneWeightTwoAtomBandRow_115
  · exact remainingSixOneWeightTwoAtomBandRow_116
  · exact remainingSixOneWeightTwoAtomBandRow_117
  · exact remainingSixOneWeightTwoAtomBandRow_118
  · exact remainingSixOneWeightTwoAtomBandRow_119

private theorem remainingSixOneWeightOneAtomBandRows (a : Fin 120) : RemainingSixOneWeightOneAtomBandRow a := by
  fin_cases a
  · exact remainingSixOneWeightOneAtomBandRow_0
  · exact remainingSixOneWeightOneAtomBandRow_1
  · exact remainingSixOneWeightOneAtomBandRow_2
  · exact remainingSixOneWeightOneAtomBandRow_3
  · exact remainingSixOneWeightOneAtomBandRow_4
  · exact remainingSixOneWeightOneAtomBandRow_5
  · exact remainingSixOneWeightOneAtomBandRow_6
  · exact remainingSixOneWeightOneAtomBandRow_7
  · exact remainingSixOneWeightOneAtomBandRow_8
  · exact remainingSixOneWeightOneAtomBandRow_9
  · exact remainingSixOneWeightOneAtomBandRow_10
  · exact remainingSixOneWeightOneAtomBandRow_11
  · exact remainingSixOneWeightOneAtomBandRow_12
  · exact remainingSixOneWeightOneAtomBandRow_13
  · exact remainingSixOneWeightOneAtomBandRow_14
  · exact remainingSixOneWeightOneAtomBandRow_15
  · exact remainingSixOneWeightOneAtomBandRow_16
  · exact remainingSixOneWeightOneAtomBandRow_17
  · exact remainingSixOneWeightOneAtomBandRow_18
  · exact remainingSixOneWeightOneAtomBandRow_19
  · exact remainingSixOneWeightOneAtomBandRow_20
  · exact remainingSixOneWeightOneAtomBandRow_21
  · exact remainingSixOneWeightOneAtomBandRow_22
  · exact remainingSixOneWeightOneAtomBandRow_23
  · exact remainingSixOneWeightOneAtomBandRow_24
  · exact remainingSixOneWeightOneAtomBandRow_25
  · exact remainingSixOneWeightOneAtomBandRow_26
  · exact remainingSixOneWeightOneAtomBandRow_27
  · exact remainingSixOneWeightOneAtomBandRow_28
  · exact remainingSixOneWeightOneAtomBandRow_29
  · exact remainingSixOneWeightOneAtomBandRow_30
  · exact remainingSixOneWeightOneAtomBandRow_31
  · exact remainingSixOneWeightOneAtomBandRow_32
  · exact remainingSixOneWeightOneAtomBandRow_33
  · exact remainingSixOneWeightOneAtomBandRow_34
  · exact remainingSixOneWeightOneAtomBandRow_35
  · exact remainingSixOneWeightOneAtomBandRow_36
  · exact remainingSixOneWeightOneAtomBandRow_37
  · exact remainingSixOneWeightOneAtomBandRow_38
  · exact remainingSixOneWeightOneAtomBandRow_39
  · exact remainingSixOneWeightOneAtomBandRow_40
  · exact remainingSixOneWeightOneAtomBandRow_41
  · exact remainingSixOneWeightOneAtomBandRow_42
  · exact remainingSixOneWeightOneAtomBandRow_43
  · exact remainingSixOneWeightOneAtomBandRow_44
  · exact remainingSixOneWeightOneAtomBandRow_45
  · exact remainingSixOneWeightOneAtomBandRow_46
  · exact remainingSixOneWeightOneAtomBandRow_47
  · exact remainingSixOneWeightOneAtomBandRow_48
  · exact remainingSixOneWeightOneAtomBandRow_49
  · exact remainingSixOneWeightOneAtomBandRow_50
  · exact remainingSixOneWeightOneAtomBandRow_51
  · exact remainingSixOneWeightOneAtomBandRow_52
  · exact remainingSixOneWeightOneAtomBandRow_53
  · exact remainingSixOneWeightOneAtomBandRow_54
  · exact remainingSixOneWeightOneAtomBandRow_55
  · exact remainingSixOneWeightOneAtomBandRow_56
  · exact remainingSixOneWeightOneAtomBandRow_57
  · exact remainingSixOneWeightOneAtomBandRow_58
  · exact remainingSixOneWeightOneAtomBandRow_59
  · exact remainingSixOneWeightOneAtomBandRow_60
  · exact remainingSixOneWeightOneAtomBandRow_61
  · exact remainingSixOneWeightOneAtomBandRow_62
  · exact remainingSixOneWeightOneAtomBandRow_63
  · exact remainingSixOneWeightOneAtomBandRow_64
  · exact remainingSixOneWeightOneAtomBandRow_65
  · exact remainingSixOneWeightOneAtomBandRow_66
  · exact remainingSixOneWeightOneAtomBandRow_67
  · exact remainingSixOneWeightOneAtomBandRow_68
  · exact remainingSixOneWeightOneAtomBandRow_69
  · exact remainingSixOneWeightOneAtomBandRow_70
  · exact remainingSixOneWeightOneAtomBandRow_71
  · exact remainingSixOneWeightOneAtomBandRow_72
  · exact remainingSixOneWeightOneAtomBandRow_73
  · exact remainingSixOneWeightOneAtomBandRow_74
  · exact remainingSixOneWeightOneAtomBandRow_75
  · exact remainingSixOneWeightOneAtomBandRow_76
  · exact remainingSixOneWeightOneAtomBandRow_77
  · exact remainingSixOneWeightOneAtomBandRow_78
  · exact remainingSixOneWeightOneAtomBandRow_79
  · exact remainingSixOneWeightOneAtomBandRow_80
  · exact remainingSixOneWeightOneAtomBandRow_81
  · exact remainingSixOneWeightOneAtomBandRow_82
  · exact remainingSixOneWeightOneAtomBandRow_83
  · exact remainingSixOneWeightOneAtomBandRow_84
  · exact remainingSixOneWeightOneAtomBandRow_85
  · exact remainingSixOneWeightOneAtomBandRow_86
  · exact remainingSixOneWeightOneAtomBandRow_87
  · exact remainingSixOneWeightOneAtomBandRow_88
  · exact remainingSixOneWeightOneAtomBandRow_89
  · exact remainingSixOneWeightOneAtomBandRow_90
  · exact remainingSixOneWeightOneAtomBandRow_91
  · exact remainingSixOneWeightOneAtomBandRow_92
  · exact remainingSixOneWeightOneAtomBandRow_93
  · exact remainingSixOneWeightOneAtomBandRow_94
  · exact remainingSixOneWeightOneAtomBandRow_95
  · exact remainingSixOneWeightOneAtomBandRow_96
  · exact remainingSixOneWeightOneAtomBandRow_97
  · exact remainingSixOneWeightOneAtomBandRow_98
  · exact remainingSixOneWeightOneAtomBandRow_99
  · exact remainingSixOneWeightOneAtomBandRow_100
  · exact remainingSixOneWeightOneAtomBandRow_101
  · exact remainingSixOneWeightOneAtomBandRow_102
  · exact remainingSixOneWeightOneAtomBandRow_103
  · exact remainingSixOneWeightOneAtomBandRow_104
  · exact remainingSixOneWeightOneAtomBandRow_105
  · exact remainingSixOneWeightOneAtomBandRow_106
  · exact remainingSixOneWeightOneAtomBandRow_107
  · exact remainingSixOneWeightOneAtomBandRow_108
  · exact remainingSixOneWeightOneAtomBandRow_109
  · exact remainingSixOneWeightOneAtomBandRow_110
  · exact remainingSixOneWeightOneAtomBandRow_111
  · exact remainingSixOneWeightOneAtomBandRow_112
  · exact remainingSixOneWeightOneAtomBandRow_113
  · exact remainingSixOneWeightOneAtomBandRow_114
  · exact remainingSixOneWeightOneAtomBandRow_115
  · exact remainingSixOneWeightOneAtomBandRow_116
  · exact remainingSixOneWeightOneAtomBandRow_117
  · exact remainingSixOneWeightOneAtomBandRow_118
  · exact remainingSixOneWeightOneAtomBandRow_119

private theorem remainingSixFourAtomBandRows (a : Fin 81) : RemainingSixFourAtomBandRow a := by
  fin_cases a
  · exact remainingSixFourAtomBandRow_0
  · exact remainingSixFourAtomBandRow_1
  · exact remainingSixFourAtomBandRow_2
  · exact remainingSixFourAtomBandRow_3
  · exact remainingSixFourAtomBandRow_4
  · exact remainingSixFourAtomBandRow_5
  · exact remainingSixFourAtomBandRow_6
  · exact remainingSixFourAtomBandRow_7
  · exact remainingSixFourAtomBandRow_8
  · exact remainingSixFourAtomBandRow_9
  · exact remainingSixFourAtomBandRow_10
  · exact remainingSixFourAtomBandRow_11
  · exact remainingSixFourAtomBandRow_12
  · exact remainingSixFourAtomBandRow_13
  · exact remainingSixFourAtomBandRow_14
  · exact remainingSixFourAtomBandRow_15
  · exact remainingSixFourAtomBandRow_16
  · exact remainingSixFourAtomBandRow_17
  · exact remainingSixFourAtomBandRow_18
  · exact remainingSixFourAtomBandRow_19
  · exact remainingSixFourAtomBandRow_20
  · exact remainingSixFourAtomBandRow_21
  · exact remainingSixFourAtomBandRow_22
  · exact remainingSixFourAtomBandRow_23
  · exact remainingSixFourAtomBandRow_24
  · exact remainingSixFourAtomBandRow_25
  · exact remainingSixFourAtomBandRow_26
  · exact remainingSixFourAtomBandRow_27
  · exact remainingSixFourAtomBandRow_28
  · exact remainingSixFourAtomBandRow_29
  · exact remainingSixFourAtomBandRow_30
  · exact remainingSixFourAtomBandRow_31
  · exact remainingSixFourAtomBandRow_32
  · exact remainingSixFourAtomBandRow_33
  · exact remainingSixFourAtomBandRow_34
  · exact remainingSixFourAtomBandRow_35
  · exact remainingSixFourAtomBandRow_36
  · exact remainingSixFourAtomBandRow_37
  · exact remainingSixFourAtomBandRow_38
  · exact remainingSixFourAtomBandRow_39
  · exact remainingSixFourAtomBandRow_40
  · exact remainingSixFourAtomBandRow_41
  · exact remainingSixFourAtomBandRow_42
  · exact remainingSixFourAtomBandRow_43
  · exact remainingSixFourAtomBandRow_44
  · exact remainingSixFourAtomBandRow_45
  · exact remainingSixFourAtomBandRow_46
  · exact remainingSixFourAtomBandRow_47
  · exact remainingSixFourAtomBandRow_48
  · exact remainingSixFourAtomBandRow_49
  · exact remainingSixFourAtomBandRow_50
  · exact remainingSixFourAtomBandRow_51
  · exact remainingSixFourAtomBandRow_52
  · exact remainingSixFourAtomBandRow_53
  · exact remainingSixFourAtomBandRow_54
  · exact remainingSixFourAtomBandRow_55
  · exact remainingSixFourAtomBandRow_56
  · exact remainingSixFourAtomBandRow_57
  · exact remainingSixFourAtomBandRow_58
  · exact remainingSixFourAtomBandRow_59
  · exact remainingSixFourAtomBandRow_60
  · exact remainingSixFourAtomBandRow_61
  · exact remainingSixFourAtomBandRow_62
  · exact remainingSixFourAtomBandRow_63
  · exact remainingSixFourAtomBandRow_64
  · exact remainingSixFourAtomBandRow_65
  · exact remainingSixFourAtomBandRow_66
  · exact remainingSixFourAtomBandRow_67
  · exact remainingSixFourAtomBandRow_68
  · exact remainingSixFourAtomBandRow_69
  · exact remainingSixFourAtomBandRow_70
  · exact remainingSixFourAtomBandRow_71
  · exact remainingSixFourAtomBandRow_72
  · exact remainingSixFourAtomBandRow_73
  · exact remainingSixFourAtomBandRow_74
  · exact remainingSixFourAtomBandRow_75
  · exact remainingSixFourAtomBandRow_76
  · exact remainingSixFourAtomBandRow_77
  · exact remainingSixFourAtomBandRow_78
  · exact remainingSixFourAtomBandRow_79
  · exact remainingSixFourAtomBandRow_80

/-- Every true weight-two 6.1 mask bit has the specified affine band fact. -/
theorem remainingSixOneWeightTwoAtomBandFact (a : Fin 120) (k : Fin 24)
    (hbit : (remainingSixOneWeightTwoAtomMasks a).testBit k.val = true) :
    AffineSixthBandFact renaultPhaseCuts a (remainingSixOneSlopes k)
      (remainingSixOneWeightTwoShift k) (remainingSixOneStrict k) :=
  ⟨fun ha => (remainingSixOneWeightTwoAtomBandRows a).1 k ha hbit,
   fun ha => (remainingSixOneWeightTwoAtomBandRows a).2 k ha hbit⟩

/-- Every true weight-one 6.1 mask bit has the specified affine band fact.
Atom 119 is an open atom; it is not a singleton. -/
theorem remainingSixOneWeightOneAtomBandFact (a : Fin 120) (k : Fin 24)
    (hbit : (remainingSixOneWeightOneAtomMasks a).testBit k.val = true) :
    AffineSixthBandFact renaultPhaseCuts a (remainingSixOneSlopes k)
      (remainingSixOneWeightOneShift k) (remainingSixOneStrict k) :=
  ⟨fun ha => (remainingSixOneWeightOneAtomBandRows a).1 k ha hbit,
   fun ha => (remainingSixOneWeightOneAtomBandRows a).2 k ha hbit⟩

/-- Every true initially-safe 6.4 mask bit has the specified affine band fact.
Atom 80 is the final singleton at 5/6. -/
theorem remainingSixFourAtomBandFact (a : Fin 81) (k : Fin 15)
    (hbit : (remainingSixFourAtomMasks a).testBit k.val = true) :
    AffineSixthBandFact remainingSixFourCuts a (remainingSixFourSlopes k)
      (remainingSixFourShifts k) (remainingSixFourStrict k) :=
  ⟨fun ha => (remainingSixFourAtomBandRows a).1 k ha hbit,
   fun ha => (remainingSixFourAtomBandRows a).2 k ha hbit⟩

private theorem remainingMixedCoreRow_0 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 0 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_1 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 1 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_2 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 2 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_3 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 3 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_4 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 4 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_5 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 5 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_6 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 6 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_7 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 7 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_8 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 8 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_9 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 9 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_10 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 10 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_11 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 11 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_12 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 12 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_13 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 13 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_14 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 14 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_15 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 15 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_16 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 16 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_17 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 17 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_18 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 18 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_19 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 19 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_20 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 20 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_21 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 21 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_22 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 22 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_23 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 23 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_24 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 24 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_25 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 25 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_26 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 26 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_27 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 27 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_28 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 28 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_29 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 29 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_30 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 30 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_31 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 31 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_32 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 32 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_33 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 33 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_34 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 34 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_35 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 35 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_36 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 36 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_37 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 37 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_38 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 38 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_39 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 39 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_40 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 40 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

private theorem remainingMixedCoreRow_41 : ∀ j k : Fin 42, j ≤ k → (remainingSixOneWeightTwoCoreMasks 41 &&& remainingSixOneWeightOneCoreMasks j &&& remainingSixOneWeightOneCoreMasks k) ≠ 0 := by decide

theorem remainingMixedCoreIntersections : ∀ i j k : Fin 42, j ≤ k →
    (remainingSixOneWeightTwoCoreMasks i &&& remainingSixOneWeightOneCoreMasks j &&&
      remainingSixOneWeightOneCoreMasks k) ≠ 0 := by
  intro i
  fin_cases i
  · exact remainingMixedCoreRow_0
  · exact remainingMixedCoreRow_1
  · exact remainingMixedCoreRow_2
  · exact remainingMixedCoreRow_3
  · exact remainingMixedCoreRow_4
  · exact remainingMixedCoreRow_5
  · exact remainingMixedCoreRow_6
  · exact remainingMixedCoreRow_7
  · exact remainingMixedCoreRow_8
  · exact remainingMixedCoreRow_9
  · exact remainingMixedCoreRow_10
  · exact remainingMixedCoreRow_11
  · exact remainingMixedCoreRow_12
  · exact remainingMixedCoreRow_13
  · exact remainingMixedCoreRow_14
  · exact remainingMixedCoreRow_15
  · exact remainingMixedCoreRow_16
  · exact remainingMixedCoreRow_17
  · exact remainingMixedCoreRow_18
  · exact remainingMixedCoreRow_19
  · exact remainingMixedCoreRow_20
  · exact remainingMixedCoreRow_21
  · exact remainingMixedCoreRow_22
  · exact remainingMixedCoreRow_23
  · exact remainingMixedCoreRow_24
  · exact remainingMixedCoreRow_25
  · exact remainingMixedCoreRow_26
  · exact remainingMixedCoreRow_27
  · exact remainingMixedCoreRow_28
  · exact remainingMixedCoreRow_29
  · exact remainingMixedCoreRow_30
  · exact remainingMixedCoreRow_31
  · exact remainingMixedCoreRow_32
  · exact remainingMixedCoreRow_33
  · exact remainingMixedCoreRow_34
  · exact remainingMixedCoreRow_35
  · exact remainingMixedCoreRow_36
  · exact remainingMixedCoreRow_37
  · exact remainingMixedCoreRow_38
  · exact remainingMixedCoreRow_39
  · exact remainingMixedCoreRow_40
  · exact remainingMixedCoreRow_41

private theorem remainingSafeCoreRow_0 : ∀ j k : Fin 26, j ≤ k → (remainingSixFourCoreMasks 0 &&& remainingSixFourCoreMasks j &&& remainingSixFourCoreMasks k) ≠ 0 := by decide

private theorem remainingSafeCoreRow_1 : ∀ j k : Fin 26, j ≤ k → (remainingSixFourCoreMasks 1 &&& remainingSixFourCoreMasks j &&& remainingSixFourCoreMasks k) ≠ 0 := by decide

private theorem remainingSafeCoreRow_2 : ∀ j k : Fin 26, j ≤ k → (remainingSixFourCoreMasks 2 &&& remainingSixFourCoreMasks j &&& remainingSixFourCoreMasks k) ≠ 0 := by decide

private theorem remainingSafeCoreRow_3 : ∀ j k : Fin 26, j ≤ k → (remainingSixFourCoreMasks 3 &&& remainingSixFourCoreMasks j &&& remainingSixFourCoreMasks k) ≠ 0 := by decide

private theorem remainingSafeCoreRow_4 : ∀ j k : Fin 26, j ≤ k → (remainingSixFourCoreMasks 4 &&& remainingSixFourCoreMasks j &&& remainingSixFourCoreMasks k) ≠ 0 := by decide

private theorem remainingSafeCoreRow_5 : ∀ j k : Fin 26, j ≤ k → (remainingSixFourCoreMasks 5 &&& remainingSixFourCoreMasks j &&& remainingSixFourCoreMasks k) ≠ 0 := by decide

private theorem remainingSafeCoreRow_6 : ∀ j k : Fin 26, j ≤ k → (remainingSixFourCoreMasks 6 &&& remainingSixFourCoreMasks j &&& remainingSixFourCoreMasks k) ≠ 0 := by decide

private theorem remainingSafeCoreRow_7 : ∀ j k : Fin 26, j ≤ k → (remainingSixFourCoreMasks 7 &&& remainingSixFourCoreMasks j &&& remainingSixFourCoreMasks k) ≠ 0 := by decide

private theorem remainingSafeCoreRow_8 : ∀ j k : Fin 26, j ≤ k → (remainingSixFourCoreMasks 8 &&& remainingSixFourCoreMasks j &&& remainingSixFourCoreMasks k) ≠ 0 := by decide

private theorem remainingSafeCoreRow_9 : ∀ j k : Fin 26, j ≤ k → (remainingSixFourCoreMasks 9 &&& remainingSixFourCoreMasks j &&& remainingSixFourCoreMasks k) ≠ 0 := by decide

private theorem remainingSafeCoreRow_10 : ∀ j k : Fin 26, j ≤ k → (remainingSixFourCoreMasks 10 &&& remainingSixFourCoreMasks j &&& remainingSixFourCoreMasks k) ≠ 0 := by decide

private theorem remainingSafeCoreRow_11 : ∀ j k : Fin 26, j ≤ k → (remainingSixFourCoreMasks 11 &&& remainingSixFourCoreMasks j &&& remainingSixFourCoreMasks k) ≠ 0 := by decide

private theorem remainingSafeCoreRow_12 : ∀ j k : Fin 26, j ≤ k → (remainingSixFourCoreMasks 12 &&& remainingSixFourCoreMasks j &&& remainingSixFourCoreMasks k) ≠ 0 := by decide

private theorem remainingSafeCoreRow_13 : ∀ j k : Fin 26, j ≤ k → (remainingSixFourCoreMasks 13 &&& remainingSixFourCoreMasks j &&& remainingSixFourCoreMasks k) ≠ 0 := by decide

private theorem remainingSafeCoreRow_14 : ∀ j k : Fin 26, j ≤ k → (remainingSixFourCoreMasks 14 &&& remainingSixFourCoreMasks j &&& remainingSixFourCoreMasks k) ≠ 0 := by decide

private theorem remainingSafeCoreRow_15 : ∀ j k : Fin 26, j ≤ k → (remainingSixFourCoreMasks 15 &&& remainingSixFourCoreMasks j &&& remainingSixFourCoreMasks k) ≠ 0 := by decide

private theorem remainingSafeCoreRow_16 : ∀ j k : Fin 26, j ≤ k → (remainingSixFourCoreMasks 16 &&& remainingSixFourCoreMasks j &&& remainingSixFourCoreMasks k) ≠ 0 := by decide

private theorem remainingSafeCoreRow_17 : ∀ j k : Fin 26, j ≤ k → (remainingSixFourCoreMasks 17 &&& remainingSixFourCoreMasks j &&& remainingSixFourCoreMasks k) ≠ 0 := by decide

private theorem remainingSafeCoreRow_18 : ∀ j k : Fin 26, j ≤ k → (remainingSixFourCoreMasks 18 &&& remainingSixFourCoreMasks j &&& remainingSixFourCoreMasks k) ≠ 0 := by decide

private theorem remainingSafeCoreRow_19 : ∀ j k : Fin 26, j ≤ k → (remainingSixFourCoreMasks 19 &&& remainingSixFourCoreMasks j &&& remainingSixFourCoreMasks k) ≠ 0 := by decide

private theorem remainingSafeCoreRow_20 : ∀ j k : Fin 26, j ≤ k → (remainingSixFourCoreMasks 20 &&& remainingSixFourCoreMasks j &&& remainingSixFourCoreMasks k) ≠ 0 := by decide

private theorem remainingSafeCoreRow_21 : ∀ j k : Fin 26, j ≤ k → (remainingSixFourCoreMasks 21 &&& remainingSixFourCoreMasks j &&& remainingSixFourCoreMasks k) ≠ 0 := by decide

private theorem remainingSafeCoreRow_22 : ∀ j k : Fin 26, j ≤ k → (remainingSixFourCoreMasks 22 &&& remainingSixFourCoreMasks j &&& remainingSixFourCoreMasks k) ≠ 0 := by decide

private theorem remainingSafeCoreRow_23 : ∀ j k : Fin 26, j ≤ k → (remainingSixFourCoreMasks 23 &&& remainingSixFourCoreMasks j &&& remainingSixFourCoreMasks k) ≠ 0 := by decide

private theorem remainingSafeCoreRow_24 : ∀ j k : Fin 26, j ≤ k → (remainingSixFourCoreMasks 24 &&& remainingSixFourCoreMasks j &&& remainingSixFourCoreMasks k) ≠ 0 := by decide

private theorem remainingSafeCoreRow_25 : ∀ j k : Fin 26, j ≤ k → (remainingSixFourCoreMasks 25 &&& remainingSixFourCoreMasks j &&& remainingSixFourCoreMasks k) ≠ 0 := by decide

theorem remainingSafeCoreIntersections : ∀ i j k : Fin 26, j ≤ k →
    (remainingSixFourCoreMasks i &&& remainingSixFourCoreMasks j &&&
      remainingSixFourCoreMasks k) ≠ 0 := by
  intro i
  fin_cases i
  · exact remainingSafeCoreRow_0
  · exact remainingSafeCoreRow_1
  · exact remainingSafeCoreRow_2
  · exact remainingSafeCoreRow_3
  · exact remainingSafeCoreRow_4
  · exact remainingSafeCoreRow_5
  · exact remainingSafeCoreRow_6
  · exact remainingSafeCoreRow_7
  · exact remainingSafeCoreRow_8
  · exact remainingSafeCoreRow_9
  · exact remainingSafeCoreRow_10
  · exact remainingSafeCoreRow_11
  · exact remainingSafeCoreRow_12
  · exact remainingSafeCoreRow_13
  · exact remainingSafeCoreRow_14
  · exact remainingSafeCoreRow_15
  · exact remainingSafeCoreRow_16
  · exact remainingSafeCoreRow_17
  · exact remainingSafeCoreRow_18
  · exact remainingSafeCoreRow_19
  · exact remainingSafeCoreRow_20
  · exact remainingSafeCoreRow_21
  · exact remainingSafeCoreRow_22
  · exact remainingSafeCoreRow_23
  · exact remainingSafeCoreRow_24
  · exact remainingSafeCoreRow_25

#print axioms remainingSixOneWeightTwoAtomBandFact
#print axioms remainingSixOneWeightOneAtomBandFact
#print axioms remainingSixFourAtomBandFact
#print axioms remainingMixedCoreIntersections
#print axioms remainingSafeCoreIntersections

end LonelyRunner
