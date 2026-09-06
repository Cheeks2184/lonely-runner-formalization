# Forty-first Astra checkpoint: general-prime anchored compression

The reviewed general-prime two-target and triple-compression statements now
have Lean proofs, including the exact signed Euclidean-residue adapter. The
full root build and trust audit passed. Independent frozen-source review and
its root replay also passed; the checkpoint is ready to publish.

## Implemented statements

`PrimeAdicArithmetic.lean` supplies eleven public arithmetic lemmas. Corrections
below the top level are units; their selected digit uses the current multiplier
in its coefficient, and all higher product residues are preserved. Top-level
selection uses a nonzero scalar instead. Positive bounded residues have a live
valuation decomposition, and every prime unit has a positive bounded representative.

`PrimeAdicCompression.lean` adds nine public lemmas, including these exact targets:

* `primeAdic_two_distinct_targets`: prescribe both digits at two different live
  levels, with nonzero targets at the top, using a positive unit below p^(m+1).
* `primeAdic_triple_compression`: if either oriented difference from coordinate 2
  collapses, or the two live levels differ, place all three digits in the anchor
  digit and its cyclic predecessor.
* `primeAdic_triple_compression_int`: the same conclusion for signed integer
  inputs, using the unchanged natural separation premise on Euclidean residues.

The triple proof uses an exact additive form of the manuscript argument.
Adding a last-digit difference to its anchor has carry zero or one, so the
resulting digit is the predecessor or the anchor. Equality endpoints and both
collapsed differences are included. No pairwise-all-differences claim or
same-level compression is introduced. There is no primality restriction beyond
`Nat.Prime p`, including p=2; m=0 and unreduced original inputs are retained.

The two new modules are imported by the root, and all twenty public theorems
are printed in `AxiomAudit.lean`. Existing FiveAdic and canonical proof files
are unchanged. These supporting arithmetic results alone do not supply any
new runner count or an unrestricted Lonely Runner proof.

## Verification and worker recovery

The final focused compression build exited 0 (3002 jobs). The full root source
build exited 0 (3659 jobs). The source trust scan and explicit axiom audit exited
0 with 552 dependency reports plus three axiom-free declarations, using only
`propext`, `Classical.choice`, and `Quot.sound`. Exact source and execution-log
hashes and proof methods are in `research/astra-prime-adic-compression-implementation.md`.
Independent exact source/type/boundary review and root replay passed. The
probe retained fifteen frozen guards and twenty-eight allowed axiom reports,
including Fin4/Fin5 compatibility and a symbolic same-level obstruction.

Terra implemented the arithmetic prerequisites. Two subsequent worker attempts
returned without the assembly proof; root preserved the compiled work, confirmed
the overall goal was active, and completed the F/C/integer integration locally.
No worker interruption was treated as a mathematical result or overall blockage.

## Separately accepted six-total manuscript

The new constrained-maximizer manuscript and its independent review prove, at
manuscript scope, a forward perturbation lemma P, an oriented global maximizer
lemma M, and reciprocal dilation/shift improvement D. The generic margin and
finite label type stay separate. A strict complement seed is essential for the
positive maximum; a merely closed feasible seed does not suffice.

The maximizer exists by compactness of the closed complement-safe set in [0,1],
is globally maximal by period-one normalization, and is oriented by the
**distinguished phase**. A forward perturbation then forces an actual other label
onto the upper boundary. The reviewed proof handles arbitrary positive natural
speeds and retains all closed endpoints. No kernel implementation of P/M/D is
claimed in this checkpoint.

The review also checks the exact mixed strict/closed scopes of Renault's phase
lemmas 5.1, 6.1 and 6.4. For 5.1, the proposed 60 cuts and 120 atoms support a
23-predicate mask model; its finite coverage remains unexecuted in these two
manuscripts. The other two lemmas have different candidate roles and cannot be
inferred from a future 5.1 result. Gcd/divisibility/parity assembly remains separate.

The existing four-moving theorem at 1/5 supplies a strict four-label seed at 1/6.
A full five-moving theorem at 1/6 is still required for the next canonical count;
H8 additionally requires six moving speeds at 1/7. Neither the maximizer nor the
prime-adic compression theorem fills these missing cases by itself.

## Publication and storage

Pass40 was merged as PR39 at f1d45fdf95af26f31cffcc92485fc5951c4b0169 after both
required checks passed. Remote main ancestry and local main were verified.
The shared pinned dependency cache remains necessary for the active source
review and immediately queued maximizer implementation. No duplicate cache,
global configuration change or unrelated cleanup was performed.

Pass41 is verified and ready for its authorized commit, push, PR and exact-head
merge after required CI checks. The subsequent maximizer source and phase
certificate work remain separate, unfinished checkpoints.
