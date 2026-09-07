# Pass 93: parent-center replacements across zero-only gaps

This pass investigates a positive replacement mechanism for a maximum-speed
gap whose original endpoint parents sum to the maximum speed. The manuscript
and independent review establish the calculations below at manuscript level.
They do not constitute a new Lean theorem.

For an actual parent with speed p and center j/p, let q=p/gcd(p,j). Every
positive multiple u of q has a grid center at that same point. The
exact condition for its open threshold arc to cover the entire closed
maximum-speed arc is

`u*(D+alpha*p) < alpha*p*m`.

This includes proper-divisor reductions but can also include frequencies
that do not divide p. Under the existing gap inequalities, every such
replacement is smaller than m/2 and is absent from the retained tuple.

Choosing one parent in every attained maximum-speed gap gives reduced
denominators q_k. The exact common-replacement criterion compares their
least common multiple with every bound

`B_k=alpha*p_k*m/(D_k+alpha*p_k)`.

A common candidate in this family exists exactly when some parent choice
has `lcm(q_k)<min(B_k)`. It would transport failure for the full tuple and
contradict minimum primitive sum. Neither the existence of an appropriate
parent choice nor the required inequalities are presently established.
Primitive parent fractions can leave this candidate family empty. These
conditions address a specified family of whole-arc repairs, not every
possible smaller replacement on the deletion-good set.

The broader proper-parent-divisor family has a separate exact residual
test. If its division factor does not divide the parent numerator, a
whole-arc repair at the native threshold requires that factor to be at
least N. Neither this test nor the lcm criterion supplies a successful
global choice. The complete working-width example with speeds 1, 3, 4, 7
does admit the common parent reduction 2; the native local example with
speeds 1, 4, 5, 11, 16 has primitive parents and no candidate in either
family at the displayed gap. Both examples are LRC-good at their native
thresholds and remain explicitly scoped controls.

The Lean API inventory separates the algebraic contact envelope from the
geometric argument needed to apply it. `ComplementSafe` already expresses
membership in the full deletion-good set and should be reused. The attained
collision indices, forced-arc decomposition, synchronized original lifts,
and nonparent separation still need formal proofs. The inventory is source
analysis, not successful Lean elaboration or compilation.

The preceding contact checkpoint was delivered in PR #91, merged at
`f102e7ec81958ef064555f1b470499b5a075fe72`. Both required CI checks passed
on head `040badb71f62085915279651b86094e1676a32df`; remote-main verification
checked sixteen hashes and the head and parent ancestry. No local build
cache was restored during this pass. The unrestricted conjecture remains
unresolved.
