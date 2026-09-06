# Pass 53: two-divisible branch and gcd normalization

The primitive five-speed case with exactly two speeds divisible by three now
has a positive-time closed sixth-margin witness. Two wrappers extend this to
primitive families with at least two three-divisible speeds and to arbitrary
positive natural families with exactly two three-divisible speeds.

For a supposed primitive counterexample, the checked divisor-count bounds
supply an even-label count at most three and at least one speed divisible by
six. The latter must be one of the two three-divisible labels. For each other
label, the boundary theorem gives zero pair minimum at every real 5/6 anchor;
the checked divisibility implication then supplies the factor-six cover.
The cover finisher produces a positive witness, contradicting nonexistence.

The existence wrapper initially obtains an arbitrary real witness and moves
it to fract(t)+1. Natural-speed periodicity preserves every norm at that one
positive time. No positive-time assumption is substituted for the all-real
nonexistence hypothesis used inside the boundary proof.

The primitive at-least-two wrapper splits the cardinality into exactly two or
at least three and invokes the corresponding checked branch. The arbitrary
exact-two wrapper divides by the positive joint gcd. That gcd cannot be
divisible by three: otherwise all five original labels would be divisible by
three. Primality of three therefore preserves the exact divisible-label set
under normalization. The normalized family is positive and primitive, and
dividing its witness time by the gcd preserves all original phases.

The original manuscript used the shorter primitive-two name for its at-least-two
scope; the final source gives that scope the explicit at-least-two name and
retains a separate exactly-two intermediate.

These scopes are deliberately different. The nonprimitive result requires
exactly two labels; replacing this by at least two would include every family
after scaling all speeds by three and would assert the still-missing general
five-moving theorem. Repeated speed values are allowed in the proved branches.

## Verification record

The two source modules passed focused Lean builds and the full integrated build
passed 3,710 jobs. The trust audit accepted 643 axiom-list reports and eight
axiom-free declarations. Initial compilation failures
were confined to exposing a local finite-set definition for rewriting and
casting a natural product before simplifying a scaled real phase. The complete
failed sources and logs, corrected source hashes and successful outputs are
retained in the pass verification JSON. Independent source review accepted all four exact contracts. Root fully read
the frozen report and replayed its exact import probe: exit zero, 29 unchanged
guards, four complete allowed-only axiom reports and empty stderr.

The primitive case with exactly one speed divisible by three remains. Its
published proof separates by even-label count and needs additional arguments;
these branch theorems do not establish a new unconditional runner count or
resolve unrestricted LRC.

## User-directed research transition

The user instructed that, once the canonical N=6 theorem is working and verified,
research must focus on a uniform arbitrary-N mechanism for unrestricted LRC.
The project config, workflow document, policy and resumable state now persist
that transition. Successive higher runner counts are not the future roadmap.
Finite-count work after this milestone must have an explicit supporting role
in a uniform mechanism. The unrestricted completion gate is unchanged.

The preceding checkpoint merged through PR51 after both required checks passed,
at main commit 4fb7a02aa39e9aeffe69cea3fd9b8a23501da6d7. Root verified
reviewed-head ancestry and synchronized local main with fetched origin/main.
