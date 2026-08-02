import LonelyRunner.SoftFeedbackLayers

/-!
# Bellman potentials for finite peeling

This file proves the elementary weak-duality statement for the subset peeling
DAG.  A feasible potential telescopes below the loss of every complete
deletion order.  The result is purely finite and assumes no modular or
cross-pivot uniformity statement.
-/

namespace LonelyRunner

variable {V : Type*} [Fintype V] [DecidableEq V]

omit [Fintype V] in
/-- A Bellman-feasible potential is bounded by every complete peeling of an
arbitrary supplied finite set. -/
theorem bellmanPotential_le_peelingLoss_of_complete
    (deficit : Finset V -> V -> Nat) (potential : Finset V -> Nat)
    (hempty : potential ∅ = 0)
    (hstep : forall (Q : Finset V) (vertex : V), vertex ∈ Q ->
      potential Q <= deficit Q vertex + potential (Q.erase vertex))
    (Q : Finset V) (order : List V)
    (hnodup : order.Nodup) (hcomplete : order.toFinset = Q) :
    potential Q <= peelingLoss deficit order := by
  induction order generalizing Q with
  | nil =>
      have hQ : Q = ∅ := by simpa using hcomplete.symm
      subst Q
      simpa [peelingLoss] using hempty.le
  | cons vertex rest ih =>
      rw [List.nodup_cons] at hnodup
      have hQ : Q = insert vertex rest.toFinset := by
        simpa using hcomplete.symm
      have hvertex : vertex ∈ Q := by simp [hQ]
      have herase : Q.erase vertex = rest.toFinset := by
        rw [hQ]
        simp [hnodup.1]
      calc
        potential Q <= deficit Q vertex + potential (Q.erase vertex) :=
          hstep Q vertex hvertex
        _ <= deficit Q vertex + peelingLoss deficit rest :=
          Nat.add_le_add_left (ih (Q.erase vertex) hnodup.2 herase.symm) _
        _ = peelingLoss deficit (vertex :: rest) := by
          simp [peelingLoss, hQ]

/-- Weak duality at the full set: every feasible Bellman potential is below
the loss of every complete order. -/
theorem bellmanPotential_univ_le_peelingLoss
    (deficit : Finset V -> V -> Nat) (potential : Finset V -> Nat)
    (hempty : potential ∅ = 0)
    (hstep : forall (Q : Finset V) (vertex : V), vertex ∈ Q ->
      potential Q <= deficit Q vertex + potential (Q.erase vertex))
    (order : List V) (hnodup : order.Nodup)
    (hcomplete : order.toFinset = Finset.univ) :
    potential Finset.univ <= peelingLoss deficit order :=
  bellmanPotential_le_peelingLoss_of_complete
    deficit potential hempty hstep Finset.univ order hnodup hcomplete

section OptimalPotential

variable {W : Type*} [DecidableEq W]

/-- The exact Bellman value: on a nonempty remaining set, minimize the current
deletion loss plus the value of the erased residual. -/
noncomputable def optimalPeelingPotential
    (deficit : Finset W -> W -> Nat) (Q : Finset W) : Nat :=
  if hQ : Q.Nonempty then
    Q.attach.inf' (by simpa using hQ) (fun vertex =>
      deficit Q vertex + optimalPeelingPotential deficit (Q.erase vertex))
  else 0
termination_by Q.card
decreasing_by
  have hcard := Finset.card_erase_add_one vertex.property
  omega

theorem optimalPeelingPotential_empty (deficit : Finset W -> W -> Nat) :
    optimalPeelingPotential deficit ∅ = 0 := by
  simp [optimalPeelingPotential]

theorem optimalPeelingPotential_of_nonempty
    (deficit : Finset W -> W -> Nat) {Q : Finset W} (hQ : Q.Nonempty) :
    optimalPeelingPotential deficit Q =
      Q.attach.inf' (by simpa using hQ) (fun vertex =>
        deficit Q vertex + optimalPeelingPotential deficit (Q.erase vertex)) := by
  rw [optimalPeelingPotential]
  simp [hQ]

/-- The exact value function is Bellman feasible. -/
theorem optimalPeelingPotential_le_step
    (deficit : Finset W -> W -> Nat) (Q : Finset W) (vertex : W)
    (hvertex : vertex ∈ Q) :
    optimalPeelingPotential deficit Q <=
      deficit Q vertex + optimalPeelingPotential deficit (Q.erase vertex) := by
  have hQ : Q.Nonempty := ⟨vertex, hvertex⟩
  rw [optimalPeelingPotential_of_nonempty deficit hQ]
  simpa using
    (Finset.inf'_le
      (fun candidate : {x // x ∈ Q} =>
        deficit Q candidate + optimalPeelingPotential deficit (Q.erase candidate))
      (show (⟨vertex, hvertex⟩ : {x // x ∈ Q}) ∈ Q.attach by simp))

/-- Some complete order attains the recursively defined Bellman value on any
finite set. -/
theorem exists_peelingLoss_eq_optimalPeelingPotential
    (deficit : Finset W -> W -> Nat) (Q : Finset W) :
    exists order : List W,
      order.Nodup /\ order.toFinset = Q /\
        peelingLoss deficit order = optimalPeelingPotential deficit Q := by
  classical
  induction Q using Finset.strongInduction with
  | H Q ih =>
      by_cases hempty : Q = ∅
      · subst Q
        exact ⟨[], by simp [peelingLoss, optimalPeelingPotential_empty]⟩
      · have hQ : Q.Nonempty := Finset.nonempty_iff_ne_empty.mpr hempty
        let value : {x // x ∈ Q} -> Nat := fun vertex =>
          deficit Q vertex + optimalPeelingPotential deficit (Q.erase vertex)
        have hattach : Q.attach.Nonempty := by simpa using hQ
        obtain ⟨chosen, -, hchosen⟩ :=
          Finset.exists_mem_eq_inf' hattach value
        have hchosenQ : (chosen : W) ∈ Q := chosen.property
        obtain ⟨tail, htailNodup, htailComplete, htailLoss⟩ :=
          ih (Q.erase chosen) (Finset.erase_ssubset hchosenQ)
        have hchosenNotTail : (chosen : W) ∉ tail := by
          intro hmem
          have : (chosen : W) ∈ Q.erase chosen := by
            rw [← htailComplete]
            exact List.mem_toFinset.mpr hmem
          exact (Finset.mem_erase.mp this).1 rfl
        refine ⟨chosen :: tail, List.nodup_cons.mpr ⟨hchosenNotTail, htailNodup⟩,
          ?_, ?_⟩
        · simp [htailComplete, Finset.insert_erase hchosenQ]
        · have hrecurrence := optimalPeelingPotential_of_nonempty deficit hQ
          change peelingLoss deficit ((chosen : W) :: tail) = _
          calc
            peelingLoss deficit ((chosen : W) :: tail) =
                deficit Q chosen + peelingLoss deficit tail := by
                  simp [peelingLoss, htailComplete, Finset.insert_erase hchosenQ]
            _ = deficit Q chosen +
                optimalPeelingPotential deficit (Q.erase chosen) := by rw [htailLoss]
            _ = value chosen := rfl
            _ = Q.attach.inf' hattach value := hchosen.symm
            _ = optimalPeelingPotential deficit Q := hrecurrence.symm

/-- Exact characterization: the recursive value is below every complete
peeling loss and is attained by at least one complete order. -/
theorem optimalPeelingPotential_characterization
    (deficit : Finset W -> W -> Nat) (Q : Finset W) :
    (forall order : List W, order.Nodup -> order.toFinset = Q ->
      optimalPeelingPotential deficit Q <= peelingLoss deficit order) /\
    (exists order : List W, order.Nodup /\ order.toFinset = Q /\
      peelingLoss deficit order = optimalPeelingPotential deficit Q) := by
  constructor
  · intro order hnodup hcomplete
    exact bellmanPotential_le_peelingLoss_of_complete deficit
      (optimalPeelingPotential deficit) (optimalPeelingPotential_empty deficit)
      (optimalPeelingPotential_le_step deficit) Q order hnodup hcomplete
  · exact exists_peelingLoss_eq_optimalPeelingPotential deficit Q

/-- The exact value is the greatest Bellman-feasible potential normalized to
zero at the empty set. -/
theorem bellmanPotential_le_optimalPeelingPotential
    (deficit : Finset W -> W -> Nat) (potential : Finset W -> Nat)
    (hempty : potential ∅ = 0)
    (hstep : forall (Q : Finset W) (vertex : W), vertex ∈ Q ->
      potential Q <= deficit Q vertex + potential (Q.erase vertex))
    (Q : Finset W) :
    potential Q <= optimalPeelingPotential deficit Q := by
  obtain ⟨order, hnodup, hcomplete, hloss⟩ :=
    exists_peelingLoss_eq_optimalPeelingPotential deficit Q
  have hweak := bellmanPotential_le_peelingLoss_of_complete
    deficit potential hempty hstep Q order hnodup hcomplete
  rwa [hloss] at hweak

end OptimalPotential

end LonelyRunner
