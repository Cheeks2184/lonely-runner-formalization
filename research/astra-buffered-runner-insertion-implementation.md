# Buffered runner insertion implementation

Source checkpoint: `5a621b8065fdbc69694168e6d406824b1fa23cff`.

Implemented `bufferedRunnerInsertion` in
`LonelyRunner/BufferedRunnerInsertion.lean` at the reviewed generic contract.
The theorem accepts arbitrary positive real old speeds and arbitrary positive
new speed, with coordinatewise old margins and the stated same-owner/pair-owner
width hypotheses.  It returns a positive time retaining the closed old margin
`δ` while making the new phase meet the closed target `β`.

The proof forms the finite floor bands
`[(floor(seed*w_i)+δ)/w_i, (floor(seed*w_i)+1-δ)/w_i]`, chooses a maximum
left owner and minimum right owner, proves their intersection has the required
width from the reviewed same/different owner inequalities, and applies the
existing small-shift lemma at the midpoint.  Positivity follows from the
nonnegative floor of each positive seed phase.

Focused verification after root completed the one shared base build:

* `lake env lean LonelyRunner/BufferedRunnerInsertion.lean` — terminal exit
  `0` (session `78577`);
* `lake build LonelyRunner.BufferedRunnerInsertion` — terminal exit `0`,
  target `[2977/2977]` built (session `15059`);
* an in-memory Lean exact-contract and `n = 1` boundary-instantiation probe —
  terminal exit `0` (session `46531`).

The axiom probe reports only `propext`, `Classical.choice`, and `Quot.sound`.

Final source hash:

* `LonelyRunner/BufferedRunnerInsertion.lean`:
  `a135f5c41ead308a2a4250f07535bf3e32f78c88599497bf79bb632cd1e05f0a`.

This is the generic buffered insertion lemma only.  No N5 specialization,
determinant refinement, root import, audit addition, or broader count claim was
implemented in this task.
