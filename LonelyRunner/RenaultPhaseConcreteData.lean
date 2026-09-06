import LonelyRunner.RenaultPhaseBandFacts
import LonelyRunner.RenaultPhaseMasks

namespace LonelyRunner

/-- Literal cuts from frozen certificate c1374409. -/
def renaultPhaseCuts : Nat → Nat := fun i =>
  [0, 12, 15, 20, 24, 30, 36, 40, 45, 48, 60, 72, 75, 80, 84, 90, 96, 100,
   105, 108, 120, 132, 135, 140, 144, 150, 156, 160, 165, 168, 180, 192,
   195, 200, 204, 210, 216, 220, 225, 228, 240, 252, 255, 260, 264, 270,
   276, 280, 285, 288, 300, 312, 315, 320, 324, 330, 336, 340, 345, 348,
   360].getD i 0

/-- Literal atom masks from frozen certificate c1374409. -/
def renaultPhaseAtomMasks : Fin 120 → Nat :=
  ![7340031,7847407,7847407,7585263,7585263,7577071,7577071,7576815,8101103,7970031,
    7986415,7982311,8244455,8178919,8179431,8179303,8187495,8185447,8316519,8283751,
    4159351,4158259,4191027,3666739,3668787,3668787,3668915,3668883,3668883,3406739,
    3407771,3391385,3915673,3784601,3784665,3784665,3784665,3776473,4038617,3973081,
    4120573,4083196,4148732,4148732,4156924,4154876,4154876,4154620,4187388,3663100,
    3667198,3666174,3666174,3404030,3404542,3404414,3406462,3406462,3930750,3799678,
    1965951,6078255,6209327,6176559,6176559,6168367,6168495,6168463,6233999,6233999,
    6250383,6246279,6279047,5754759,5754823,5754823,5763015,5760967,5760967,5498823,
    4978679,4846067,5108211,5042675,5044723,5044723,5044723,5044467,5175539,5142771,
    5143803,5127417,5192953,5192953,5193465,5193337,5193337,5185145,5217913,4693625,
    4710269,6541116,7065404,6934332,6942524,6940476,6940604,6940572,7202716,7137180,
    7141278,7140254,7271326,7238558,7238622,7238622,7240670,7240670,7306206,7306206]

/-- `class_reps[minimal_classes[i]]` in the frozen certificate order. -/
def renaultPhaseCoreAtoms : Fin 41 → Fin 120 :=
  ![7,9,11,13,15,17,19,21,23,29,31,33,37,39,41,47,49,53,55,59,60,61,65,67,
    71,73,79,81,83,87,89,91,97,99,101,103,105,107,109,111,113]

/-- Supplied domination indices in frozen atom order. -/
def renaultPhaseDominators : Fin 120 → Fin 41 :=
  ![27,0,0,0,0,0,0,0,0,1,1,2,2,3,3,4,4,5,5,6,7,7,7,8,8,8,8,9,9,9,9,10,
    10,11,11,11,11,12,12,13,13,14,14,14,14,15,15,15,15,16,16,17,17,17,17,
    18,18,18,18,19,20,21,21,22,22,22,22,23,23,23,23,24,24,25,25,25,25,26,
    26,26,27,27,27,28,28,28,28,29,29,30,30,31,31,31,31,32,32,32,32,33,33,
    34,34,35,35,36,36,37,37,38,38,39,39,40,40,40,40,40,40,40]


set_option maxHeartbeats 1000000
set_option maxRecDepth 4096

private abbrev AtomBandRow (a : Fin 120) : Prop :=
  (∀ k : Fin 23, a.val % 2 = 0 → (renaultPhaseAtomMasks a).testBit k.val = true →
    if k.val < 20 then
      120 ≤ phaseNumerator renaultPhaseCuts a k % 720 ∧
        phaseNumerator renaultPhaseCuts a k % 720 ≤ 600
    else
      120 < phaseNumerator renaultPhaseCuts a k % 720 ∧
        phaseNumerator renaultPhaseCuts a k % 720 < 600) ∧
  (∀ k : Fin 23, a.val % 2 ≠ 0 → (renaultPhaseAtomMasks a).testBit k.val = true →
    360 * phaseQuotient renaultPhaseCuts a k + 60 ≤
      phaseSlope k * renaultPhaseCuts (a.val / 2) + 60 * phaseShift k ∧
    phaseSlope k * renaultPhaseCuts (a.val / 2 + 1) + 60 * phaseShift k ≤
      360 * phaseQuotient renaultPhaseCuts a k + 300)

private theorem renaultPhaseAtomBandRow_0 : AtomBandRow 0 := by decide
private theorem renaultPhaseAtomBandRow_1 : AtomBandRow 1 := by decide
private theorem renaultPhaseAtomBandRow_2 : AtomBandRow 2 := by decide
private theorem renaultPhaseAtomBandRow_3 : AtomBandRow 3 := by decide
private theorem renaultPhaseAtomBandRow_4 : AtomBandRow 4 := by decide
private theorem renaultPhaseAtomBandRow_5 : AtomBandRow 5 := by decide
private theorem renaultPhaseAtomBandRow_6 : AtomBandRow 6 := by decide
private theorem renaultPhaseAtomBandRow_7 : AtomBandRow 7 := by decide
private theorem renaultPhaseAtomBandRow_8 : AtomBandRow 8 := by decide
private theorem renaultPhaseAtomBandRow_9 : AtomBandRow 9 := by decide
private theorem renaultPhaseAtomBandRow_10 : AtomBandRow 10 := by decide
private theorem renaultPhaseAtomBandRow_11 : AtomBandRow 11 := by decide
private theorem renaultPhaseAtomBandRow_12 : AtomBandRow 12 := by decide
private theorem renaultPhaseAtomBandRow_13 : AtomBandRow 13 := by decide
private theorem renaultPhaseAtomBandRow_14 : AtomBandRow 14 := by decide
private theorem renaultPhaseAtomBandRow_15 : AtomBandRow 15 := by decide
private theorem renaultPhaseAtomBandRow_16 : AtomBandRow 16 := by decide
private theorem renaultPhaseAtomBandRow_17 : AtomBandRow 17 := by decide
private theorem renaultPhaseAtomBandRow_18 : AtomBandRow 18 := by decide
private theorem renaultPhaseAtomBandRow_19 : AtomBandRow 19 := by decide
private theorem renaultPhaseAtomBandRow_20 : AtomBandRow 20 := by decide
private theorem renaultPhaseAtomBandRow_21 : AtomBandRow 21 := by decide
private theorem renaultPhaseAtomBandRow_22 : AtomBandRow 22 := by decide
private theorem renaultPhaseAtomBandRow_23 : AtomBandRow 23 := by decide
private theorem renaultPhaseAtomBandRow_24 : AtomBandRow 24 := by decide
private theorem renaultPhaseAtomBandRow_25 : AtomBandRow 25 := by decide
private theorem renaultPhaseAtomBandRow_26 : AtomBandRow 26 := by decide
private theorem renaultPhaseAtomBandRow_27 : AtomBandRow 27 := by decide
private theorem renaultPhaseAtomBandRow_28 : AtomBandRow 28 := by decide
private theorem renaultPhaseAtomBandRow_29 : AtomBandRow 29 := by decide
private theorem renaultPhaseAtomBandRow_30 : AtomBandRow 30 := by decide
private theorem renaultPhaseAtomBandRow_31 : AtomBandRow 31 := by decide
private theorem renaultPhaseAtomBandRow_32 : AtomBandRow 32 := by decide
private theorem renaultPhaseAtomBandRow_33 : AtomBandRow 33 := by decide
private theorem renaultPhaseAtomBandRow_34 : AtomBandRow 34 := by decide
private theorem renaultPhaseAtomBandRow_35 : AtomBandRow 35 := by decide
private theorem renaultPhaseAtomBandRow_36 : AtomBandRow 36 := by decide
private theorem renaultPhaseAtomBandRow_37 : AtomBandRow 37 := by decide
private theorem renaultPhaseAtomBandRow_38 : AtomBandRow 38 := by decide
private theorem renaultPhaseAtomBandRow_39 : AtomBandRow 39 := by decide
private theorem renaultPhaseAtomBandRow_40 : AtomBandRow 40 := by decide
private theorem renaultPhaseAtomBandRow_41 : AtomBandRow 41 := by decide
private theorem renaultPhaseAtomBandRow_42 : AtomBandRow 42 := by decide
private theorem renaultPhaseAtomBandRow_43 : AtomBandRow 43 := by decide
private theorem renaultPhaseAtomBandRow_44 : AtomBandRow 44 := by decide
private theorem renaultPhaseAtomBandRow_45 : AtomBandRow 45 := by decide
private theorem renaultPhaseAtomBandRow_46 : AtomBandRow 46 := by decide
private theorem renaultPhaseAtomBandRow_47 : AtomBandRow 47 := by decide
private theorem renaultPhaseAtomBandRow_48 : AtomBandRow 48 := by decide
private theorem renaultPhaseAtomBandRow_49 : AtomBandRow 49 := by decide
private theorem renaultPhaseAtomBandRow_50 : AtomBandRow 50 := by decide
private theorem renaultPhaseAtomBandRow_51 : AtomBandRow 51 := by decide
private theorem renaultPhaseAtomBandRow_52 : AtomBandRow 52 := by decide
private theorem renaultPhaseAtomBandRow_53 : AtomBandRow 53 := by decide
private theorem renaultPhaseAtomBandRow_54 : AtomBandRow 54 := by decide
private theorem renaultPhaseAtomBandRow_55 : AtomBandRow 55 := by decide
private theorem renaultPhaseAtomBandRow_56 : AtomBandRow 56 := by decide
private theorem renaultPhaseAtomBandRow_57 : AtomBandRow 57 := by decide
private theorem renaultPhaseAtomBandRow_58 : AtomBandRow 58 := by decide
private theorem renaultPhaseAtomBandRow_59 : AtomBandRow 59 := by decide
private theorem renaultPhaseAtomBandRow_60 : AtomBandRow 60 := by decide
private theorem renaultPhaseAtomBandRow_61 : AtomBandRow 61 := by decide
private theorem renaultPhaseAtomBandRow_62 : AtomBandRow 62 := by decide
private theorem renaultPhaseAtomBandRow_63 : AtomBandRow 63 := by decide
private theorem renaultPhaseAtomBandRow_64 : AtomBandRow 64 := by decide
private theorem renaultPhaseAtomBandRow_65 : AtomBandRow 65 := by decide
private theorem renaultPhaseAtomBandRow_66 : AtomBandRow 66 := by decide
private theorem renaultPhaseAtomBandRow_67 : AtomBandRow 67 := by decide
private theorem renaultPhaseAtomBandRow_68 : AtomBandRow 68 := by decide
private theorem renaultPhaseAtomBandRow_69 : AtomBandRow 69 := by decide
private theorem renaultPhaseAtomBandRow_70 : AtomBandRow 70 := by decide
private theorem renaultPhaseAtomBandRow_71 : AtomBandRow 71 := by decide
private theorem renaultPhaseAtomBandRow_72 : AtomBandRow 72 := by decide
private theorem renaultPhaseAtomBandRow_73 : AtomBandRow 73 := by decide
private theorem renaultPhaseAtomBandRow_74 : AtomBandRow 74 := by decide
private theorem renaultPhaseAtomBandRow_75 : AtomBandRow 75 := by decide
private theorem renaultPhaseAtomBandRow_76 : AtomBandRow 76 := by decide
private theorem renaultPhaseAtomBandRow_77 : AtomBandRow 77 := by decide
private theorem renaultPhaseAtomBandRow_78 : AtomBandRow 78 := by decide
private theorem renaultPhaseAtomBandRow_79 : AtomBandRow 79 := by decide
private theorem renaultPhaseAtomBandRow_80 : AtomBandRow 80 := by decide
private theorem renaultPhaseAtomBandRow_81 : AtomBandRow 81 := by decide
private theorem renaultPhaseAtomBandRow_82 : AtomBandRow 82 := by decide
private theorem renaultPhaseAtomBandRow_83 : AtomBandRow 83 := by decide
private theorem renaultPhaseAtomBandRow_84 : AtomBandRow 84 := by decide
private theorem renaultPhaseAtomBandRow_85 : AtomBandRow 85 := by decide
private theorem renaultPhaseAtomBandRow_86 : AtomBandRow 86 := by decide
private theorem renaultPhaseAtomBandRow_87 : AtomBandRow 87 := by decide
private theorem renaultPhaseAtomBandRow_88 : AtomBandRow 88 := by decide
private theorem renaultPhaseAtomBandRow_89 : AtomBandRow 89 := by decide
private theorem renaultPhaseAtomBandRow_90 : AtomBandRow 90 := by decide
private theorem renaultPhaseAtomBandRow_91 : AtomBandRow 91 := by decide
private theorem renaultPhaseAtomBandRow_92 : AtomBandRow 92 := by decide
private theorem renaultPhaseAtomBandRow_93 : AtomBandRow 93 := by decide
private theorem renaultPhaseAtomBandRow_94 : AtomBandRow 94 := by decide
private theorem renaultPhaseAtomBandRow_95 : AtomBandRow 95 := by decide
private theorem renaultPhaseAtomBandRow_96 : AtomBandRow 96 := by decide
private theorem renaultPhaseAtomBandRow_97 : AtomBandRow 97 := by decide
private theorem renaultPhaseAtomBandRow_98 : AtomBandRow 98 := by decide
private theorem renaultPhaseAtomBandRow_99 : AtomBandRow 99 := by decide
private theorem renaultPhaseAtomBandRow_100 : AtomBandRow 100 := by decide
private theorem renaultPhaseAtomBandRow_101 : AtomBandRow 101 := by decide
private theorem renaultPhaseAtomBandRow_102 : AtomBandRow 102 := by decide
private theorem renaultPhaseAtomBandRow_103 : AtomBandRow 103 := by decide
private theorem renaultPhaseAtomBandRow_104 : AtomBandRow 104 := by decide
private theorem renaultPhaseAtomBandRow_105 : AtomBandRow 105 := by decide
private theorem renaultPhaseAtomBandRow_106 : AtomBandRow 106 := by decide
private theorem renaultPhaseAtomBandRow_107 : AtomBandRow 107 := by decide
private theorem renaultPhaseAtomBandRow_108 : AtomBandRow 108 := by decide
private theorem renaultPhaseAtomBandRow_109 : AtomBandRow 109 := by decide
private theorem renaultPhaseAtomBandRow_110 : AtomBandRow 110 := by decide
private theorem renaultPhaseAtomBandRow_111 : AtomBandRow 111 := by decide
private theorem renaultPhaseAtomBandRow_112 : AtomBandRow 112 := by decide
private theorem renaultPhaseAtomBandRow_113 : AtomBandRow 113 := by decide
private theorem renaultPhaseAtomBandRow_114 : AtomBandRow 114 := by decide
private theorem renaultPhaseAtomBandRow_115 : AtomBandRow 115 := by decide
private theorem renaultPhaseAtomBandRow_116 : AtomBandRow 116 := by decide
private theorem renaultPhaseAtomBandRow_117 : AtomBandRow 117 := by decide
private theorem renaultPhaseAtomBandRow_118 : AtomBandRow 118 := by decide
private theorem renaultPhaseAtomBandRow_119 : AtomBandRow 119 := by decide

private theorem renaultPhaseAtomBandRows (a : Fin 120) : AtomBandRow a := by
  fin_cases a
  · exact renaultPhaseAtomBandRow_0
  · exact renaultPhaseAtomBandRow_1
  · exact renaultPhaseAtomBandRow_2
  · exact renaultPhaseAtomBandRow_3
  · exact renaultPhaseAtomBandRow_4
  · exact renaultPhaseAtomBandRow_5
  · exact renaultPhaseAtomBandRow_6
  · exact renaultPhaseAtomBandRow_7
  · exact renaultPhaseAtomBandRow_8
  · exact renaultPhaseAtomBandRow_9
  · exact renaultPhaseAtomBandRow_10
  · exact renaultPhaseAtomBandRow_11
  · exact renaultPhaseAtomBandRow_12
  · exact renaultPhaseAtomBandRow_13
  · exact renaultPhaseAtomBandRow_14
  · exact renaultPhaseAtomBandRow_15
  · exact renaultPhaseAtomBandRow_16
  · exact renaultPhaseAtomBandRow_17
  · exact renaultPhaseAtomBandRow_18
  · exact renaultPhaseAtomBandRow_19
  · exact renaultPhaseAtomBandRow_20
  · exact renaultPhaseAtomBandRow_21
  · exact renaultPhaseAtomBandRow_22
  · exact renaultPhaseAtomBandRow_23
  · exact renaultPhaseAtomBandRow_24
  · exact renaultPhaseAtomBandRow_25
  · exact renaultPhaseAtomBandRow_26
  · exact renaultPhaseAtomBandRow_27
  · exact renaultPhaseAtomBandRow_28
  · exact renaultPhaseAtomBandRow_29
  · exact renaultPhaseAtomBandRow_30
  · exact renaultPhaseAtomBandRow_31
  · exact renaultPhaseAtomBandRow_32
  · exact renaultPhaseAtomBandRow_33
  · exact renaultPhaseAtomBandRow_34
  · exact renaultPhaseAtomBandRow_35
  · exact renaultPhaseAtomBandRow_36
  · exact renaultPhaseAtomBandRow_37
  · exact renaultPhaseAtomBandRow_38
  · exact renaultPhaseAtomBandRow_39
  · exact renaultPhaseAtomBandRow_40
  · exact renaultPhaseAtomBandRow_41
  · exact renaultPhaseAtomBandRow_42
  · exact renaultPhaseAtomBandRow_43
  · exact renaultPhaseAtomBandRow_44
  · exact renaultPhaseAtomBandRow_45
  · exact renaultPhaseAtomBandRow_46
  · exact renaultPhaseAtomBandRow_47
  · exact renaultPhaseAtomBandRow_48
  · exact renaultPhaseAtomBandRow_49
  · exact renaultPhaseAtomBandRow_50
  · exact renaultPhaseAtomBandRow_51
  · exact renaultPhaseAtomBandRow_52
  · exact renaultPhaseAtomBandRow_53
  · exact renaultPhaseAtomBandRow_54
  · exact renaultPhaseAtomBandRow_55
  · exact renaultPhaseAtomBandRow_56
  · exact renaultPhaseAtomBandRow_57
  · exact renaultPhaseAtomBandRow_58
  · exact renaultPhaseAtomBandRow_59
  · exact renaultPhaseAtomBandRow_60
  · exact renaultPhaseAtomBandRow_61
  · exact renaultPhaseAtomBandRow_62
  · exact renaultPhaseAtomBandRow_63
  · exact renaultPhaseAtomBandRow_64
  · exact renaultPhaseAtomBandRow_65
  · exact renaultPhaseAtomBandRow_66
  · exact renaultPhaseAtomBandRow_67
  · exact renaultPhaseAtomBandRow_68
  · exact renaultPhaseAtomBandRow_69
  · exact renaultPhaseAtomBandRow_70
  · exact renaultPhaseAtomBandRow_71
  · exact renaultPhaseAtomBandRow_72
  · exact renaultPhaseAtomBandRow_73
  · exact renaultPhaseAtomBandRow_74
  · exact renaultPhaseAtomBandRow_75
  · exact renaultPhaseAtomBandRow_76
  · exact renaultPhaseAtomBandRow_77
  · exact renaultPhaseAtomBandRow_78
  · exact renaultPhaseAtomBandRow_79
  · exact renaultPhaseAtomBandRow_80
  · exact renaultPhaseAtomBandRow_81
  · exact renaultPhaseAtomBandRow_82
  · exact renaultPhaseAtomBandRow_83
  · exact renaultPhaseAtomBandRow_84
  · exact renaultPhaseAtomBandRow_85
  · exact renaultPhaseAtomBandRow_86
  · exact renaultPhaseAtomBandRow_87
  · exact renaultPhaseAtomBandRow_88
  · exact renaultPhaseAtomBandRow_89
  · exact renaultPhaseAtomBandRow_90
  · exact renaultPhaseAtomBandRow_91
  · exact renaultPhaseAtomBandRow_92
  · exact renaultPhaseAtomBandRow_93
  · exact renaultPhaseAtomBandRow_94
  · exact renaultPhaseAtomBandRow_95
  · exact renaultPhaseAtomBandRow_96
  · exact renaultPhaseAtomBandRow_97
  · exact renaultPhaseAtomBandRow_98
  · exact renaultPhaseAtomBandRow_99
  · exact renaultPhaseAtomBandRow_100
  · exact renaultPhaseAtomBandRow_101
  · exact renaultPhaseAtomBandRow_102
  · exact renaultPhaseAtomBandRow_103
  · exact renaultPhaseAtomBandRow_104
  · exact renaultPhaseAtomBandRow_105
  · exact renaultPhaseAtomBandRow_106
  · exact renaultPhaseAtomBandRow_107
  · exact renaultPhaseAtomBandRow_108
  · exact renaultPhaseAtomBandRow_109
  · exact renaultPhaseAtomBandRow_110
  · exact renaultPhaseAtomBandRow_111
  · exact renaultPhaseAtomBandRow_112
  · exact renaultPhaseAtomBandRow_113
  · exact renaultPhaseAtomBandRow_114
  · exact renaultPhaseAtomBandRow_115
  · exact renaultPhaseAtomBandRow_116
  · exact renaultPhaseAtomBandRow_117
  · exact renaultPhaseAtomBandRow_118
  · exact renaultPhaseAtomBandRow_119

theorem renaultPhaseBandFacts :
    PhaseBandFacts renaultPhaseCuts renaultPhaseAtomMasks := by
  refine ⟨by decide, by decide, ?_, ?_⟩
  · intro a k ha hb
    exact (renaultPhaseAtomBandRows a).1 k ha hb
  · intro a k ha hb
    exact (renaultPhaseAtomBandRows a).2 k ha hb

theorem renaultPhaseCoreAtoms_masks : ∀ i : Fin 41,
    renaultPhaseAtomMasks (renaultPhaseCoreAtoms i) = renaultPhaseCoreMasks i := by decide

theorem renaultPhaseDominators_and : ∀ a : Fin 120,
    renaultPhaseCoreMasks (renaultPhaseDominators a) &&& renaultPhaseAtomMasks a =
      renaultPhaseCoreMasks (renaultPhaseDominators a) := by decide

end LonelyRunner
