# Forty-eighth Astra checkpoint: folded phases and seeded rescues

Nine declarations provide the scalar and common-shift ingredients of the
reviewed two-divisible-three argument. They preserve arbitrary real phases,
closed sixth-margin safety, and the explicit distinction between divisible
labels and exceptional labels. The full two-divisible proposition is still
an assembly obligation.

## Folded scalar geometry

Every real phase is an integer plus or minus its circle norm. Natural
multiplication preserves this folding when the added shift is an integer
multiple of one half, including negative integer shifts and multiplier zero.
A half-turn complements the circle norm to one half, with both endpoints
included. The proofs use the nearest integer, exact integer periodicity,
and norm reflection.

If 0<a<1/6, a≤b≤1/2, and both the triple and quintuple norms of b are at most
a, their nearest integers must be one and two respectively. Linear inequalities
then give a≥1/8 and 11/30<b<7/18. The closed lower bound and strict outer
bounds follow directly from the original hypotheses, without a rounding tie
assumption or an executed search.

## One shift for seeded divisible labels

The first seeded rescue permits at most three exceptions when two distinct
labels are initially strictly bad. Their badness excludes divisibility and
the generic collision theorem chooses a common safe third shift. Integer
periodicity preserves every divisible label at its supplied seed.

The second rescue removes an exceptional label known to be safe at every
third shift. A strict subtype-cardinality bound leaves at most two exceptions,
which the existing avoidance theorem handles simultaneously. The seed and
uniform-safety premises remain explicit; these adapters do not manufacture
an all-runner seed.

## Special sixth phases

A phase whose fractional part is 1/6, 1/2 or 5/6 remains in that safe set after
any natural-speed third shift, including speed zero. If the speed is not
divisible by three, one of the three shifts moves the phase to exactly 5/6.
The proofs reduce a natural numerator modulo three and use the exact
fractional-part formula for a rational number. The two nonzero residue classes
supply explicit shifts for transport. Negative initial phases are covered by
an integer-difference identity.

A final wrapper combines uniform special-phase safety with the seeded rescue.
It returns one shift working for every label, under the same seed and
at-most-three-exceptions premises. All boundary equalities stay safe.

## Verification and remaining work

The complete source build passed 3,690 jobs. The trust audit accepted 614
dependency reports and eight axiom-free declarations. Root read the complete
drafts and retained initial compiler failures beside their corrected passes.
Corrections included explicit real casts of integer equalities, rewriting only
the intended real occurrence, preserving natural quotients before casting,
normalizing literal casts in periodicity, and applying the exact rational
fractional-part lemma instead of recursively unfolding the definition.
No theorem hypothesis or conclusion was weakened.

Independent review and exact root replay accepted the four scalar/folded
contracts. Independent review and root replay also accepted all five rescue
and special-phase contracts. The final replay passed in 1.870303216 seconds,
with all 28 guards unchanged, five allowed-axiom reports, and empty stderr.
Its complete stdout retains 16 harmless unused proof-binder warnings. The verification JSON retains complete build,
trust, and replay output. All new source modules compile without warnings;
older dependencies still replay their existing warnings.

The signed affine residue formulas, safe-band consequences, boundary-minimum
argument, and final divisor-cover contradiction are the next components.
This checkpoint does not supply an unconditional five-moving sixth-margin
witness, a new canonical runner count, or a solution of unrestricted LRC.
The shared pinned cache remains needed for active and immediately queued work.

The preceding anchored-pair checkpoint merged through PR46 after both required
checks passed, at main commit `987c53dd276ec239273fc8f91b8309a900828985`.
Root fetched main, checked reviewed-head ancestry, and synchronized local main.
