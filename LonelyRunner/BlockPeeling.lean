import LonelyRunner.SoftFeedbackLayers

/-!
# Fixed-length block peeling

This file isolates the finite combinatorics of deleting several vertices at a
time.  A block is evaluated in its actual ambient remaining set: after each
entry is deleted, the next loss is computed in the erased set.  In particular,
the last block is allowed to have length strictly smaller than the requested
block size.

Nothing in this file asserts that the modular Lonely Runner data satisfy a
particular block bound.
-/

namespace LonelyRunner

section Prefixes

variable {V : Type*} [DecidableEq V]

/-- The remaining set after deleting a list from an ambient finite set. -/
def remainingAfter (Q : Finset V) : List V -> Finset V
  | [] => Q
  | vertex :: rest => remainingAfter (Q.erase vertex) rest

/-- A deletion list is valid when every entry is still present when deleted. -/
def ValidPeelingPrefix (Q : Finset V) : List V -> Prop
  | [] => True
  | vertex :: rest => vertex ∈ Q /\ ValidPeelingPrefix (Q.erase vertex) rest

/-- Loss of a deletion prefix in its actual ambient remaining set. -/
def prefixPeelingLoss (deficit : Finset V -> V -> Nat) (Q : Finset V) :
    List V -> Nat
  | [] => 0
  | vertex :: rest =>
      deficit Q vertex + prefixPeelingLoss deficit (Q.erase vertex) rest

theorem remainingAfter_append (Q : Finset V) (left right : List V) :
    remainingAfter Q (left ++ right) = remainingAfter (remainingAfter Q left) right := by
  induction left generalizing Q with
  | nil => rfl
  | cons vertex rest ih =>
      simp [remainingAfter, ih]

theorem validPeelingPrefix_append_iff (Q : Finset V) (left right : List V) :
    ValidPeelingPrefix Q (left ++ right) <->
      ValidPeelingPrefix Q left /\ ValidPeelingPrefix (remainingAfter Q left) right := by
  induction left generalizing Q with
  | nil => simp [ValidPeelingPrefix, remainingAfter]
  | cons vertex rest ih =>
      simp [ValidPeelingPrefix, remainingAfter, ih, and_assoc]

theorem prefixPeelingLoss_append (deficit : Finset V -> V -> Nat)
    (Q : Finset V) (left right : List V) :
    prefixPeelingLoss deficit Q (left ++ right) =
      prefixPeelingLoss deficit Q left +
        prefixPeelingLoss deficit (remainingAfter Q left) right := by
  induction left generalizing Q with
  | nil => simp [prefixPeelingLoss, remainingAfter]
  | cons vertex rest ih =>
      simp [prefixPeelingLoss, remainingAfter, ih, Nat.add_assoc]

theorem remainingAfter_subset (Q : Finset V) (vertices : List V) :
    remainingAfter Q vertices ⊆ Q := by
  induction vertices generalizing Q with
  | nil => exact Finset.Subset.rfl
  | cons vertex rest ih =>
      exact Finset.Subset.trans (ih (Q.erase vertex)) (Finset.erase_subset vertex Q)

theorem validPeelingPrefix_toFinset_subset {Q : Finset V} {vertices : List V}
    (hvalid : ValidPeelingPrefix Q vertices) :
    vertices.toFinset ⊆ Q := by
  induction vertices generalizing Q with
  | nil => simp
  | cons vertex rest ih =>
      rw [ValidPeelingPrefix] at hvalid
      intro x hx
      simp only [List.toFinset_cons, Finset.mem_insert] at hx
      rcases hx with rfl | hx
      · exact hvalid.1
      · exact (Finset.erase_subset vertex Q) (ih hvalid.2 hx)

theorem validPeelingPrefix_nodup {Q : Finset V} {vertices : List V}
    (hvalid : ValidPeelingPrefix Q vertices) : vertices.Nodup := by
  induction vertices generalizing Q with
  | nil => exact List.nodup_nil
  | cons vertex rest ih =>
      rw [ValidPeelingPrefix] at hvalid
      apply List.nodup_cons.mpr
      refine ⟨?_, ih hvalid.2⟩
      intro hmem
      have hsubset := validPeelingPrefix_toFinset_subset hvalid.2
      have : vertex ∈ Q.erase vertex := hsubset (List.mem_toFinset.mpr hmem)
      exact (Finset.mem_erase.mp this).1 rfl

theorem card_remainingAfter_add_length {Q : Finset V} {vertices : List V}
    (hvalid : ValidPeelingPrefix Q vertices) :
    (remainingAfter Q vertices).card + vertices.length = Q.card := by
  induction vertices generalizing Q with
  | nil => simp [remainingAfter]
  | cons vertex rest ih =>
      rw [ValidPeelingPrefix] at hvalid
      have hcard := Finset.card_erase_add_one hvalid.1
      have hrest := ih hvalid.2
      simp only [remainingAfter, List.length_cons]
      omega

theorem toFinset_eq_of_validPeelingPrefix_of_remainingAfter_eq_empty
    {Q : Finset V} {vertices : List V}
    (hvalid : ValidPeelingPrefix Q vertices)
    (hempty : remainingAfter Q vertices = ∅) :
    vertices.toFinset = Q := by
  have hnodup := validPeelingPrefix_nodup hvalid
  have hcard := card_remainingAfter_add_length hvalid
  rw [hempty] at hcard
  have heqcard : vertices.toFinset.card = Q.card := by
    simpa [List.toFinset_card_of_nodup hnodup] using hcard
  exact Finset.eq_of_subset_of_card_le
    (validPeelingPrefix_toFinset_subset hvalid) (by simp [heqcard])

theorem prefixPeelingLoss_eq_peelingLoss_of_complete
    (deficit : Finset V -> V -> Nat) (Q : Finset V) (vertices : List V)
    (hnodup : vertices.Nodup) (hcomplete : vertices.toFinset = Q) :
    prefixPeelingLoss deficit Q vertices = peelingLoss deficit vertices := by
  induction vertices generalizing Q with
  | nil => simp [prefixPeelingLoss, peelingLoss]
  | cons vertex rest ih =>
      rw [List.nodup_cons] at hnodup
      have hQ : Q = insert vertex rest.toFinset := by
        simpa using hcomplete.symm
      have herase : Q.erase vertex = rest.toFinset := by
        rw [hQ]
        simp [hnodup.1]
      simp only [prefixPeelingLoss, peelingLoss]
      rw [← hQ, ih (Q := Q.erase vertex) hnodup.2 herase.symm]

end Prefixes

section BlockBudget

/-- Sum of the budgets at the successive block-start cardinalities.  The zero
block size is defined separately only to make the function total; all peeling
theorems assume a positive block size. -/
def blockPeelingBudget (budget : Nat -> Nat) (blockSize : Nat) (n : Nat) : Nat :=
  if _hblock : 0 < blockSize then
    if _hn : 0 < n then
      budget n + blockPeelingBudget budget blockSize (n - min blockSize n)
    else 0
  else 0
termination_by n
decreasing_by
  have hmin : 0 < min blockSize n := by omega
  omega

theorem blockPeelingBudget_zero (budget : Nat -> Nat) (blockSize : Nat) :
    blockPeelingBudget budget blockSize 0 = 0 := by
  simp [blockPeelingBudget]

theorem blockPeelingBudget_of_pos (budget : Nat -> Nat) {blockSize n : Nat}
    (hblock : 0 < blockSize) (hn : 0 < n) :
    blockPeelingBudget budget blockSize n =
      budget n + blockPeelingBudget budget blockSize (n - min blockSize n) := by
  rw [blockPeelingBudget]
  simp [hblock, hn]

theorem blockPeelingBudget_mono {lower upper : Nat -> Nat}
    (hbudget : forall n, lower n <= upper n) (blockSize n : Nat) :
    blockPeelingBudget lower blockSize n <= blockPeelingBudget upper blockSize n := by
  induction n using Nat.strong_induction_on with
  | h n ih =>
      by_cases hblock : 0 < blockSize
      · by_cases hn : 0 < n
        · rw [blockPeelingBudget_of_pos lower hblock hn,
            blockPeelingBudget_of_pos upper hblock hn]
          apply Nat.add_le_add (hbudget n)
          apply ih
          have hmin : 0 < min blockSize n := by omega
          omega
        · have : n = 0 := by omega
          subst n
          simp [blockPeelingBudget_zero]
      · have : blockSize = 0 := by omega
        subst blockSize
        simp [blockPeelingBudget]

theorem blockPeelingBudget_lt_of_top_lt {lower upper : Nat -> Nat}
    (hbudget : forall n, lower n <= upper n) {blockSize n : Nat}
    (hblock : 0 < blockSize) (hn : 0 < n) (htop : lower n < upper n) :
    blockPeelingBudget lower blockSize n < blockPeelingBudget upper blockSize n := by
  rw [blockPeelingBudget_of_pos lower hblock hn,
    blockPeelingBudget_of_pos upper hblock hn]
  exact Nat.add_lt_add_of_lt_of_le htop
    (blockPeelingBudget_mono hbudget blockSize (n - min blockSize n))

/-- The sum of `length` one-step cardinality budgets, starting at core size
`n` and descending by one after each deletion. -/
def cardinalitySegmentBudget (budget : Nat -> Nat) (n : Nat) : Nat -> Nat
  | 0 => 0
  | length + 1 =>
      budget n + cardinalitySegmentBudget budget (n - 1) length

/-- A descending segment and the ordinary budget of the residual core exactly
partition the ordinary one-step budget. -/
theorem cardinalitySegmentBudget_add_peelingBudget
    (budget : Nat -> Nat) {n length : Nat} (hlength : length <= n) :
    cardinalitySegmentBudget budget n length +
        peelingBudget budget (n - length) = peelingBudget budget n := by
  induction length generalizing n with
  | zero => simp [cardinalitySegmentBudget]
  | succ length ih =>
      have hn : 0 < n := by omega
      have htail : length <= n - 1 := by omega
      have ih' := ih (n := n - 1) htail
      have hsub : n - (length + 1) = (n - 1) - length := by omega
      rw [cardinalitySegmentBudget]
      calc
        budget n + cardinalitySegmentBudget budget (n - 1) length +
              peelingBudget budget (n - (length + 1)) =
            budget n + (cardinalitySegmentBudget budget (n - 1) length +
              peelingBudget budget ((n - 1) - length)) := by
                rw [hsub, Nat.add_assoc]
        _ = budget n + peelingBudget budget (n - 1) := by rw [ih']
        _ = peelingBudget budget (n - 1) + budget n := Nat.add_comm _ _
        _ = peelingBudget budget n := by
          have hs := peelingBudget_succ budget (n - 1)
          have hpred : n - 1 + 1 = n := by omega
          rw [hpred] at hs
          exact hs.symm

/-- The block allowance obtained by merely summing the available one-step
cardinality bounds inside one block. -/
def oneStepBlockBudget (budget : Nat -> Nat) (blockSize n : Nat) : Nat :=
  cardinalitySegmentBudget budget n (min blockSize n)

/-- Grouping one-step cardinality budgets into positive-size blocks changes no
total allowance.  Thus a genuinely sharper block lemma must improve on at
least one `oneStepBlockBudget`, not just regroup the same terms. -/
theorem blockPeelingBudget_oneStepBlockBudget
    (budget : Nat -> Nat) {blockSize n : Nat} (hblock : 0 < blockSize) :
    blockPeelingBudget (oneStepBlockBudget budget blockSize) blockSize n =
      peelingBudget budget n := by
  induction n using Nat.strong_induction_on with
  | h n ih =>
      by_cases hn : n = 0
      · subst n
        simp [blockPeelingBudget_zero, peelingBudget]
      · have hnpos : 0 < n := by omega
        let length := min blockSize n
        have hlengthPos : 0 < length := by dsimp [length]; omega
        have hresidual : n - length < n := by omega
        rw [blockPeelingBudget_of_pos (oneStepBlockBudget budget blockSize)
          hblock hnpos]
        change oneStepBlockBudget budget blockSize n +
            blockPeelingBudget (oneStepBlockBudget budget blockSize) blockSize
              (n - length) = peelingBudget budget n
        rw [ih (n - length) hresidual]
        exact cardinalitySegmentBudget_add_peelingBudget budget (min_le_right _ _)

end BlockBudget

section BlockPeeling

variable {V : Type*} [Fintype V] [DecidableEq V]

omit [Fintype V] in
/-- Repeatedly applying a one-vertex cardinality bound constructs a valid
block whose allowance is the corresponding descending segment. -/
theorem exists_validPeelingBlock_of_localVertexBudget
    (deficit : Finset V -> V -> Nat) (budget : Nat -> Nat)
    (hlocal : forall Q : Finset V, Q.Nonempty ->
      exists vertex, vertex ∈ Q /\ deficit Q vertex <= budget Q.card)
    {Q : Finset V} {length : Nat} (hlength : length <= Q.card) :
    exists block : List V,
      ValidPeelingPrefix Q block /\ block.length = length /\
        prefixPeelingLoss deficit Q block <=
          cardinalitySegmentBudget budget Q.card length := by
  classical
  induction length generalizing Q with
  | zero =>
      exact ⟨[], by simp [ValidPeelingPrefix, prefixPeelingLoss,
        cardinalitySegmentBudget]⟩
  | succ length ih =>
      have hQnonempty : Q.Nonempty := Finset.card_pos.mp (by omega)
      obtain ⟨vertex, hvertex, hdeficit⟩ := hlocal Q hQnonempty
      have hcard := Finset.card_erase_add_one hvertex
      have htailLength : length <= (Q.erase vertex).card := by omega
      obtain ⟨tail, htailValid, htailLengthEq, htailLoss⟩ :=
        ih (Q := Q.erase vertex) htailLength
      refine ⟨vertex :: tail, ⟨hvertex, htailValid⟩, by simp [htailLengthEq], ?_⟩
      simp only [prefixPeelingLoss, cardinalitySegmentBudget]
      have heraseCard : (Q.erase vertex).card = Q.card - 1 := by omega
      rw [← heraseCard]
      exact Nat.add_le_add hdeficit htailLoss

/-- Repeating locally budgeted blocks gives a complete peeling.  The required
length is `min blockSize Q.card`, so the final nonempty block has its exact
remaining length even when it is shorter than `blockSize`. -/
theorem exists_blockPeelingList_of_localBudget
    (deficit : Finset V -> V -> Nat) (budget : Nat -> Nat) (blockSize : Nat)
    (hblockSize : 0 < blockSize)
    (hlocal : forall Q : Finset V, Q.Nonempty ->
      exists block : List V,
        ValidPeelingPrefix Q block /\
          block.length = min blockSize Q.card /\
          prefixPeelingLoss deficit Q block <= budget Q.card) :
    exists order : List V,
      order.Nodup /\ order.toFinset = Finset.univ /\
        peelingLoss deficit order <=
          blockPeelingBudget budget blockSize (Fintype.card V) := by
  classical
  have build : forall Q : Finset V, exists order : List V,
      ValidPeelingPrefix Q order /\ remainingAfter Q order = ∅ /\
        prefixPeelingLoss deficit Q order <=
          blockPeelingBudget budget blockSize Q.card := by
    intro Q
    induction Q using Finset.strongInduction with
    | H Q ih =>
        by_cases hempty : Q = ∅
        · subst Q
          exact ⟨[], by simp [ValidPeelingPrefix, remainingAfter,
            prefixPeelingLoss, blockPeelingBudget_zero]⟩
        · have hnonempty : Q.Nonempty := Finset.nonempty_iff_ne_empty.mpr hempty
          obtain ⟨block, hvalid, hlength, hloss⟩ := hlocal Q hnonempty
          let R := remainingAfter Q block
          have hcard := card_remainingAfter_add_length hvalid
          have hRcard : R.card = Q.card - min blockSize Q.card := by
            dsimp [R]
            omega
          have hlengthpos : 0 < block.length := by
            rw [hlength]
            have : 0 < Q.card := Finset.card_pos.mpr hnonempty
            omega
          have hRlt : R.card < Q.card := by
            dsimp [R]
            omega
          have hRsubset : R ⊆ Q := remainingAfter_subset Q block
          have hRssubset : R ⊂ Q := by
            rw [Finset.ssubset_iff_subset_ne]
            exact ⟨hRsubset, fun heq => by
              have := congrArg Finset.card heq
              omega⟩
          obtain ⟨tail, htailvalid, htailempty, htailloss⟩ := ih R hRssubset
          refine ⟨block ++ tail, ?_, ?_, ?_⟩
          · exact (validPeelingPrefix_append_iff Q block tail).2 ⟨hvalid, htailvalid⟩
          · rw [remainingAfter_append]
            exact htailempty
          · rw [prefixPeelingLoss_append]
            have hQpos : 0 < Q.card := Finset.card_pos.mpr hnonempty
            rw [blockPeelingBudget_of_pos budget hblockSize hQpos, ← hRcard]
            exact Nat.add_le_add hloss htailloss
  obtain ⟨order, hvalid, hempty, hloss⟩ := build Finset.univ
  have hnodup := validPeelingPrefix_nodup hvalid
  have hcomplete :=
    toFinset_eq_of_validPeelingPrefix_of_remainingAfter_eq_empty hvalid hempty
  refine ⟨order, hnodup, hcomplete, ?_⟩
  rwa [prefixPeelingLoss_eq_peelingLoss_of_complete deficit Finset.univ order
    hnodup hcomplete] at hloss

/-- Strict local block bounds give a strict total bound when there is at least
one vertex.  The nonemptiness assumption is necessary: for an empty type both
the complete peeling loss and every block-start budget sum are zero. -/
theorem exists_blockPeelingList_of_strictLocalBudget
    (deficit : Finset V -> V -> Nat) (budget : Nat -> Nat) (blockSize : Nat)
    (hblockSize : 0 < blockSize) (hV : 0 < Fintype.card V)
    (hlocal : forall Q : Finset V, Q.Nonempty ->
      exists block : List V,
        ValidPeelingPrefix Q block /\
          block.length = min blockSize Q.card /\
          prefixPeelingLoss deficit Q block < budget Q.card) :
    exists order : List V,
      order.Nodup /\ order.toFinset = Finset.univ /\
        peelingLoss deficit order <
          blockPeelingBudget budget blockSize (Fintype.card V) := by
  classical
  let lower : Nat -> Nat := fun n => budget n - 1
  have hlocalLower : forall Q : Finset V, Q.Nonempty ->
      exists block : List V,
        ValidPeelingPrefix Q block /\
          block.length = min blockSize Q.card /\
          prefixPeelingLoss deficit Q block <= lower Q.card := by
    intro Q hQ
    obtain ⟨block, hvalid, hlength, hloss⟩ := hlocal Q hQ
    exact ⟨block, hvalid, hlength, by dsimp [lower]; omega⟩
  obtain ⟨order, hnodup, hcomplete, hloss⟩ :=
    exists_blockPeelingList_of_localBudget deficit lower blockSize
      hblockSize hlocalLower
  have huniv : (Finset.univ : Finset V).Nonempty := by
    exact Finset.card_pos.mp (by simpa using hV)
  obtain ⟨topBlock, -, -, htopLoss⟩ := hlocal Finset.univ huniv
  have htopBudget : 0 < budget (Fintype.card V) := by
    rw [Finset.card_univ] at htopLoss
    omega
  have hlower : forall n, lower n <= budget n := by
    intro n
    dsimp [lower]
    omega
  have htop : lower (Fintype.card V) < budget (Fintype.card V) := by
    dsimp [lower]
    omega
  refine ⟨order, hnodup, hcomplete, lt_of_le_of_lt hloss ?_⟩
  exact blockPeelingBudget_lt_of_top_lt hlower hblockSize hV htop

/-- The block theorem recovers the ordinary one-step result exactly when each
block allowance is only the sum of its constituent one-step bounds. -/
theorem exists_blockPeelingList_of_localVertexBudget
    (deficit : Finset V -> V -> Nat) (budget : Nat -> Nat) (blockSize : Nat)
    (hblockSize : 0 < blockSize)
    (hlocal : forall Q : Finset V, Q.Nonempty ->
      exists vertex, vertex ∈ Q /\ deficit Q vertex <= budget Q.card) :
    exists order : List V,
      order.Nodup /\ order.toFinset = Finset.univ /\
        peelingLoss deficit order <= peelingBudget budget (Fintype.card V) := by
  have hblocks : forall Q : Finset V, Q.Nonempty ->
      exists block : List V,
        ValidPeelingPrefix Q block /\
          block.length = min blockSize Q.card /\
          prefixPeelingLoss deficit Q block <=
            oneStepBlockBudget budget blockSize Q.card := by
    intro Q _
    simpa [oneStepBlockBudget] using
      (exists_validPeelingBlock_of_localVertexBudget deficit budget hlocal
        (Q := Q) (length := min blockSize Q.card) (min_le_right _ _))
  obtain ⟨order, hnodup, hcomplete, hloss⟩ :=
    exists_blockPeelingList_of_localBudget deficit
      (oneStepBlockBudget budget blockSize) blockSize hblockSize hblocks
  refine ⟨order, hnodup, hcomplete, ?_⟩
  rwa [blockPeelingBudget_oneStepBlockBudget budget hblockSize] at hloss

end BlockPeeling

end LonelyRunner
