import LonelyRunner.RenaultPhaseConcreteData
import LonelyRunner.AffinePhaseCertificate

/-!
# Fixed ordinary-kernel pilot for the supplied remaining phase data

This file transcribes five fixed finite rows from the independently checked
metadata. It is a compiler pilot only: it does not assert a phase theorem or
any coverage, minimality, or containment claim.
-/

namespace LonelyRunner.RemainingPhaseKernelPilot

set_option maxHeartbeats 1000000
set_option maxRecDepth 4096

/-- The 24 supplied 6.1 candidate decoders, in their frozen metadata order. -/
private def sixOneSlopes : Fin 24 → Nat :=
![
  2, 2, 2, 2, 2, 3, 3, 3, 3, 3,
  4, 4, 4, 4, 4, 5, 5, 5, 5, 5,
  1, 1, 1, 1
]
private def sixOneShifts : Fin 24 → Nat :=
![
  1, 2, 3, 4, 5, 1, 2, 3, 4, 5,
  1, 2, 3, 4, 5, 1, 2, 3, 4, 5,
  1, 2, 3, 4
]
private def sixOneStrict : Fin 24 → Bool :=
![
  false, false, false, false, false, false, false, false, false, false,
  false, false, false, false, false, false, false, false, false, false,
  true, true, true, true
]

/-- The 15 supplied 6.4 candidate decoders, in their frozen metadata order. -/
private def sixFourSlopes : Fin 15 → Nat :=
![
  2, 1, 1, 3, 3, 3, 3, 3, 3, 5,
  5, 5, 5, 5, 5
]
private def sixFourShifts : Fin 15 → Nat :=
![
  0, 1, 5, 0, 1, 2, 3, 4, 5, 0,
  1, 2, 3, 4, 5
]
private def sixFourStrict : Fin 15 → Bool :=
![
  true, true, true, false, false, false, false, false, false, false,
  false, false, false, false, false
]

/-- All supplied core masks are retained to make each fixed lookup literal. -/
private def sixOneWeightTwoCores : Fin 42 → Nat :=
![
  12447611, 11988859, 11974523, 11974075, 11974061, 12268973, 12278189, 10476525, 14539469, 14544589,
  14085837, 14085846, 14086006, 14071670, 14366582, 14530422, 14539638, 14539190, 14539195, 14080443,
  14085563, 5238779, 7040731, 7026395, 7190235, 7190221, 7190381, 7199597, 6740845, 7035757,
  7040877, 7040429, 7040438, 7204278, 7189942, 3127286, 11974358, 11983574, 12278486, 12278491,
  12278651, 12283771
]
private def sixOneWeightOneCores : Fin 42 → Nat :=
![
  15965423, 16358639, 16370919, 16567527, 16567911, 16574055, 16672359, 8352563, 7861043, 7601043,
  7585689, 7978905, 7970777, 8167385, 4083196, 4154620, 3663100, 3404030, 3404414, 3799678,
  1965951, 10272559, 10362671, 10362767, 10440583, 9949063, 9693127, 9172983, 13234675, 13431283,
  13433075, 13531379, 13516025, 13573753, 13082233, 14929724, 15322940, 15329084, 15329180, 15525788,
  15528862, 15627166
]
private def sixFourCores : Fin 26 → Nat :=
![
  31131, 15771, 15819, 8139, 20427, 20451, 26595, 29431, 30967, 15486,
  7806, 7998, 20286, 26526, 29598, 29646, 31182, 15847, 8167, 20213,
  26357, 26237, 29309, 30845, 31037, 15677
]

/-- All supplied atom masks are retained to make each fixed lookup literal. -/
private def sixOneWeightTwoAtoms : Fin 120 → Nat :=
![
  12447611, 12447611, 12578683, 11988859, 11992955, 11974523, 11974651, 11974075, 11974075, 11974075,
  11974079, 11974061, 12563885, 12268973, 12268973, 12268973, 12287405, 12278189, 12278189, 12278189,
  10476525, 14539469, 14539469, 14539469, 14548685, 14544589, 14544589, 14544589, 14675661, 14085837,
  14085855, 14085846, 14085846, 14085846, 14086134, 14086006, 14090102, 14071670, 14661494, 14366582,
  14366582, 14366582, 14661494, 14530422, 14548854, 14539638, 14539766, 14539190, 14539190, 14539190,
  14539199, 14539195, 14670267, 14080443, 14080443, 14080443, 14089659, 14085563, 14085563, 14085563,
  5238779, 7040731, 7040731, 7040731, 7044827, 7026395, 7026395, 7026395, 7321307, 7190235,
  7190239, 7190221, 7190221, 7190221, 7190509, 7190381, 7208813, 7199597, 7330669, 6740845,
  6740845, 6740845, 7330669, 7035757, 7044973, 7040877, 7041005, 7040429, 7040429, 7040429,
  7040447, 7040438, 7335350, 7204278, 7204278, 7204278, 7208374, 7189942, 7189942, 7189942,
  3127286, 11974358, 11974358, 11974358, 11992790, 11983574, 11983574, 11983574, 12573398, 12278486,
  12278495, 12278491, 12278491, 12278491, 12278779, 12278651, 12287867, 12283771, 12578683, 12447611
]
private def sixOneWeightOneAtoms : Fin 120 → Nat :=
![
  15728639, 16236015, 16236015, 15973871, 15973871, 15965679, 15965679, 15965423, 16489711, 16358639,
  16375023, 16370919, 16633063, 16567527, 16568039, 16567911, 16576103, 16574055, 16705127, 16672359,
  8353655, 8352563, 8385331, 7861043, 7863091, 7863091, 7863219, 7863187, 7863187, 7601043,
  7602075, 7585689, 8109977, 7978905, 7978969, 7978969, 7978969, 7970777, 8232921, 8167385,
  4120573, 4083196, 4148732, 4148732, 4156924, 4154876, 4154876, 4154620, 4187388, 3663100,
  3667198, 3666174, 3666174, 3404030, 3404542, 3404414, 3406462, 3406462, 3930750, 3799678,
  1965951, 10272559, 10403631, 10370863, 10370863, 10362671, 10362799, 10362767, 10428303, 10428303,
  10444687, 10440583, 10473351, 9949063, 9949127, 9949127, 9957319, 9955271, 9955271, 9693127,
  9172983, 13234675, 13496819, 13431283, 13433331, 13433331, 13433331, 13433075, 13564147, 13531379,
  13532411, 13516025, 13581561, 13581561, 13582073, 13581945, 13581945, 13573753, 13606521, 13082233,
  13098877, 14929724, 15454012, 15322940, 15331132, 15329084, 15329212, 15329180, 15591324, 15525788,
  15529886, 15528862, 15659934, 15627166, 15627230, 15627230, 15629278, 15629278, 15694814, 15694814
]
private def sixFourAtoms : Fin 81 → Nat :=
![
  31675, 31131, 32155, 15771, 15771, 15771, 15835, 15819, 16331, 8139,
  8139, 8139, 24523, 20427, 20459, 20451, 20451, 20451, 28643, 26595,
  30707, 29431, 31479, 30967, 30967, 30967, 30975, 30847, 31871, 15487,
  15486, 15486, 15998, 7806, 8062, 7998, 7998, 7998, 24382, 20286,
  28606, 26526, 30622, 29598, 29598, 29598, 29662, 29646, 31694, 31182,
  31182, 31183, 32207, 15823, 15855, 15847, 15847, 15847, 16359, 8167,
  24565, 20213, 28405, 26357, 26357, 26357, 26365, 26237, 30333, 29309,
  29309, 29309, 31357, 30845, 31101, 31037, 31037, 31037, 32061, 15677,
  16317
]

/-- The 6.4 cut interval starts at 1/6; its last singleton is 5/6. -/
private def sixFourCuts : Nat → Nat := fun i => renaultPhaseCuts (i + 10)

private abbrev SixOneWeightTwoAtomBandRow (a : Fin 120) : Prop :=
  (∀ k : Fin 24, a.val % 2 = 0 → (sixOneWeightTwoAtoms a).testBit k.val = true →
    if sixOneStrict k then
      120 < affineSixthNumerator renaultPhaseCuts a (sixOneSlopes k) (2 * sixOneShifts k) % 720 ∧
        affineSixthNumerator renaultPhaseCuts a (sixOneSlopes k) (2 * sixOneShifts k) % 720 < 600
    else
      120 ≤ affineSixthNumerator renaultPhaseCuts a (sixOneSlopes k) (2 * sixOneShifts k) % 720 ∧
        affineSixthNumerator renaultPhaseCuts a (sixOneSlopes k) (2 * sixOneShifts k) % 720 ≤ 600) ∧
  (∀ k : Fin 24, a.val % 2 ≠ 0 → (sixOneWeightTwoAtoms a).testBit k.val = true →
    360 * affineSixthQuotient renaultPhaseCuts a (sixOneSlopes k) (2 * sixOneShifts k) + 60 ≤
      sixOneSlopes k * renaultPhaseCuts (a.val / 2) + 60 * (2 * sixOneShifts k) ∧
    sixOneSlopes k * renaultPhaseCuts (a.val / 2 + 1) + 60 * (2 * sixOneShifts k) ≤
      360 * affineSixthQuotient renaultPhaseCuts a (sixOneSlopes k) (2 * sixOneShifts k) + 300)

private abbrev SixOneWeightOneAtomBandRow (a : Fin 120) : Prop :=
  (∀ k : Fin 24, a.val % 2 = 0 → (sixOneWeightOneAtoms a).testBit k.val = true →
    if sixOneStrict k then
      120 < affineSixthNumerator renaultPhaseCuts a (sixOneSlopes k) (sixOneShifts k) % 720 ∧
        affineSixthNumerator renaultPhaseCuts a (sixOneSlopes k) (sixOneShifts k) % 720 < 600
    else
      120 ≤ affineSixthNumerator renaultPhaseCuts a (sixOneSlopes k) (sixOneShifts k) % 720 ∧
        affineSixthNumerator renaultPhaseCuts a (sixOneSlopes k) (sixOneShifts k) % 720 ≤ 600) ∧
  (∀ k : Fin 24, a.val % 2 ≠ 0 → (sixOneWeightOneAtoms a).testBit k.val = true →
    360 * affineSixthQuotient renaultPhaseCuts a (sixOneSlopes k) (sixOneShifts k) + 60 ≤
      sixOneSlopes k * renaultPhaseCuts (a.val / 2) + 60 * sixOneShifts k ∧
    sixOneSlopes k * renaultPhaseCuts (a.val / 2 + 1) + 60 * sixOneShifts k ≤
      360 * affineSixthQuotient renaultPhaseCuts a (sixOneSlopes k) (sixOneShifts k) + 300)

private abbrev SixFourAtomBandRow (a : Fin 81) : Prop :=
  (∀ k : Fin 15, a.val % 2 = 0 → (sixFourAtoms a).testBit k.val = true →
    if sixFourStrict k then
      120 < affineSixthNumerator sixFourCuts a (sixFourSlopes k) (sixFourShifts k) % 720 ∧
        affineSixthNumerator sixFourCuts a (sixFourSlopes k) (sixFourShifts k) % 720 < 600
    else
      120 ≤ affineSixthNumerator sixFourCuts a (sixFourSlopes k) (sixFourShifts k) % 720 ∧
        affineSixthNumerator sixFourCuts a (sixFourSlopes k) (sixFourShifts k) % 720 ≤ 600) ∧
  (∀ k : Fin 15, a.val % 2 ≠ 0 → (sixFourAtoms a).testBit k.val = true →
    360 * affineSixthQuotient sixFourCuts a (sixFourSlopes k) (sixFourShifts k) + 60 ≤
      sixFourSlopes k * sixFourCuts (a.val / 2) + 60 * sixFourShifts k ∧
    sixFourSlopes k * sixFourCuts (a.val / 2 + 1) + 60 * sixFourShifts k ≤
      360 * affineSixthQuotient sixFourCuts a (sixFourSlopes k) (sixFourShifts k) + 300)

/-- Fixed row 41 of the supplied mixed-core witness table. -/
private theorem mixedCoreRow41 : ∀ j k : Fin 42, j ≤ k →
    (sixOneWeightTwoCores 41 &&& sixOneWeightOneCores j &&& sixOneWeightOneCores k) ≠ 0 := by
  decide

/-- Fixed row 0 of the supplied 6.4 core witness table. -/
private theorem safeCoreRow0 : ∀ j k : Fin 26, j ≤ k →
    (sixFourCores 0 &&& sixFourCores j &&& sixFourCores k) ≠ 0 := by
  decide

/-- Fixed final singleton row of the supplied weight-two 6.1 atoms. -/
private theorem mixedWeightTwoAtom119 : SixOneWeightTwoAtomBandRow 119 := by
  decide

/-- Fixed final singleton row of the supplied weight-one 6.1 atoms. -/
private theorem weightOneAtom119 : SixOneWeightOneAtomBandRow 119 := by
  decide

/-- Fixed final singleton row at 5/6 of the supplied 6.4 atoms. -/
private theorem safeAtom80 : SixFourAtomBandRow 80 := by
  decide

#print axioms mixedCoreRow41
#print axioms safeCoreRow0
#print axioms mixedWeightTwoAtom119
#print axioms weightOneAtom119
#print axioms safeAtom80

end LonelyRunner.RemainingPhaseKernelPilot
