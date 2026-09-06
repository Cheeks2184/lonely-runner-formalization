# Pass 51: boundary phase and divisibility helpers

Seven kernel-checked declarations provide the phase identities and boundary
implications needed by the two-divisible branch. An independently reviewed
manuscript specifies the remaining selector, even-anchor fallback and maximum
assembly. That assembly is not claimed as implemented by this checkpoint.

The affine folded-norm identity handles arbitrary signed integer sixth shifts
for speeds written as 6z+3ε. The residue certificate chooses ε in {0,1} and
proves that ε=0 exactly when the natural speed is divisible by six. The common
two-phase lemma supplies one of three paired choices at the closed 1/6 margin;
it has no restrictions on the real phases.

The boundary helpers show that zero norm at a rational phase forces natural
divisibility, and that a pair minimum which vanishes at every real 5/6 anchor
forces one pair speed to be divisible by six times the anchor speed. The latter
has an explicit all-real boundary-zero premise; it does not supply that premise.
Two further identities remove the sign of a half-turn norm shift and compute
the exact affine anchor fractional part for arbitrary natural dilation and
residue magnitude, with sign ±1.

## Verification

The full source build passed 3,703 jobs. The trust audit accepted 634 dependency
reports and eight axiom-free declarations. Independent reviews accepted all
seven exact universal types and complete source proofs. Root read both frozen
reports and replayed each exact capped import check successfully. The four-
contract replay retained 23 source/artifact guards and the three-contract replay
retained 20; both had empty stderr and allowed-only axiom reports.

The boundary assembly manuscript and its independent review were fully read.
Root replayed the exact static check: all 18 bindings, eight contract blocks,
the original boundary target and all five table rows matched. This is a
manuscript review, distinct from kernel verification of the remaining assembly.

The verification record retains unsuccessful source drafts and complete compiler
output, followed by the corrected passes. Corrections concern natural quotient
casts, exact fractional-part API names and rewriting the proper hypothesis.
The special-anchor module's successful build emits two informational ring
suggestions; these are retained and are not compile failures. No theorem was
weakened and no additional axiom was introduced.

## Remaining work and publication

The maximum may be zero, both residue signs must be handled, and the even-anchor
case needs a common three-time choice. These obligations remain explicit in the
reviewed assembly. This checkpoint proves no new unconditional runner count
and does not resolve the unrestricted conjecture. The shared pinned cache is
still needed by the active implementation and source review.

The preceding checkpoint merged through PR49 after both required checks passed.
Its reviewed head was c538c85a8172822917135ac5665951dcdb649150; main contains it
at merge 865b96f66682599965694868505d8b5a0c1f67e8. Root verified ancestry and
synchronized local main with fetched origin/main.
