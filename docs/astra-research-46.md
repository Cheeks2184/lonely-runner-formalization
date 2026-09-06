# Forty-sixth Astra checkpoint: the three-divisible branch

The seven reviewed third-shift contracts now have Lean proofs. In particular,
five positive natural speeds have a positive time at closed margin 1/6 when
exactly three or four labelled speeds are divisible by three. A separate
corollary covers a gcd-one tuple with at least three divisible labels.
Repeated speed values are allowed. The explicit count upper bound or
primitive hypothesis excludes the unresolved all-five-divisible case.

## One shift for every exceptional label

The quotient-circle triangle inequality implies that, in a family separated
by at least twice a threshold, at most one label can have norm strictly below
that threshold. For a speed not divisible by three, distinct third-grid
shifts are separated by at least 1/3. The proof orders the natural indices
before subtracting them, uses primality of three to exclude divisibility of
the product, and invokes the existing small-denominator norm bound. Reversing
the order uses symmetry of the circle norm.

Consequently each exceptional label forbids at most one of the three shifts
at the strict badness threshold 1/6. At most two exceptional labels cannot
forbid all three candidates. The existing finite union bound selects a single
shift safe for every exception, including empty families or repeated speeds
and phases. Equality at distance 1/6 is safe throughout.

The seeded adapter applies this result to the finite subtype of nondivisible
labels. Divisible labels retain their exact norm under the same shift by
integer periodicity. The adapter requires a supplied seed for every divisible
label and imposes no positivity assumption on that seed or its speeds.

## Positive witnesses and the primitive boundary

When three or four labels are divisible, select a nondivisible label and apply
the checked four-moving theorem to all the other labels. This supplies a
positive seed at margin 1/5 for every divisible label. There are at most two
exceptions, so the common shift makes all five safe at margin 1/6. Adding a
nonnegative third shift preserves positive time.

For a primitive tuple, five divisible labels would force three to divide the
finite gcd, which is one. The resulting count upper bound permits application
of the three-or-four theorem. No no-witness hypothesis or unproved
five-moving sixth-margin theorem enters this proof.

This formalizes the stated Renault Lemma 2.3 branch with its global primitive
scope made explicit. It does not handle arbitrary nonprimitive all-five-
divisible tuples by scaling: after removing the common factor, the tuple may
lose the required three divisible labels. The two-divisible case and the full
five-moving sixth-margin theorem remain separate work.

## Verification

Root read the complete source drafts and corrected elaboration issues without
changing the seven contracts. The corrections concerned set-membership
unfolding, ordered natural casts, direct filter membership, the exact subtype
cardinality identity, and literal casts in the periodicity rewrite. Initial
failed sources and complete compiler records are preserved in the verification
JSON. The final new modules compile without warnings; older dependencies
continue to replay their existing warnings.

The full project build passed with 3,682 jobs. The trust audit accepted 602
dependency reports and eight axiom-free declarations; all seven new theorems
use only the permitted axioms. Independent source review accepted all seven
complete proofs and exact universal contracts. Its single import probe passed;
root read the complete frozen report and replayed its exact Bash entry once.
That replay exited zero in 1.97 seconds, retained all 816 stdout bytes and
empty stderr, and preserved all 26 source, olean, manuscript and pin guards.
The separately reviewed manuscript and its primary-source scope are in the
preceding checkpoint.

The preceding divisor-insertion checkpoint merged through PR44 after both
required CI checks passed, at main commit
`354b5106ba34d0f92a2c991ea708d04ec34cfe22`. Root verified its reviewed head
is an ancestor of fetched main and synchronized local main.

The shared pinned cache remains needed for active review and immediately
queued work. The unrestricted conjecture is active and unresolved; no new
canonical runner-count theorem is claimed.
