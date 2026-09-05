# Prompt95 conditional bridge implementation

Source checkpoint: `8a3a407f729163316a11ffbb863ca9dddf249d36`.

`LonelyRunner/Prompt95CanonicalBridge.lean` formalizes the accepted finite
wrapper: on a nonempty pivot row, internal cover redundancy is equivalent to
the absence of an internal complete cover.  Its forward direction uses strong
induction on the finite owner set and the supplied redundancy witness to erase
one owner at each step; the empty-cover case is excluded by a candidate from
the nonempty row.

It then proves only the stated conditional implication from
`MaxCoveredPivotInternalCoverRedundancy` to `PositiveIntegerConjecture`, and
from there to `Conjecture`.  For a hypothetical counterexample to the pivot
certificate statement, every pivot is covered.  A maximum-speed pivot exists
in the finite family; its full nonpivot owner set is internal and complete,
contradicting the finite wrapper and the explicit premise.  The singleton
case uses pivot `0` and candidate residue `1` directly.

No theorem in this module asserts the Prompt95 premise itself, a converse, or
the canonical conjecture without that hypothesis.
