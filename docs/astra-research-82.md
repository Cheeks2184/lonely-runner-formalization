# Pass 82: scope of the cover-selection shortcut

The energy route is shelved as an active research target until a new sharp
ingredient is available. Its inequality remains unproved and unrefuted.
The accepted support, chamber and cyclic calculations rule out particular
ways of establishing it; they do not rule out every energy argument.

This pass also checks an attempted replacement based on choosing inexpensive
arcs from an actual bad-set cover. For n moving speeds, a subcover whose
sum of reciprocal speeds is at most `(n+1)/2` would have total length less
than one at a width below `1/(n+1)`. A structural theorem forcing that
selection would therefore prove the desired contradiction. Merely asking
for the selection supplies no such theorem.

Label essentiality and all deletion witnesses are insufficient. For every
prime `p>=7`, the progression `(1,...,p-1)` has explicit deletion witnesses
at margin `1/(p-1)`. Its full maximum is exactly `1/p`. At width `1/p`, a
closed subcover of cost at most `p/2` would have to tile the circle without
overlap. Matching adjacent rational endpoints forces their speed labels
to sum to p, so the tiling could use only one complementary pair. Two
labels cannot cover at that width, giving a contradiction.

There are finitely many arc subsets for each fixed p. Each cheap subset
misses a point by a positive amount at the closed width. A common positive
enlargement therefore preserves failure of every cheap subset. On this
enlargement range, the full open family covers, every label is essential,
and every subcover costs more than `p/2`. This is a single family at
unbounded counts, not a sequence of runner-count milestones. A separate
three-speed calculation gives the exact minimum cost `13/6>2`.

These examples have maximum equal to the canonical threshold and use open
covers at widths above it. They do not satisfy strict failure below that
threshold. Thus the result rejects only the weaker selection shortcut;
it does not refute a statement using the complete failure hypotheses or
disprove LRC. Neither the energy comparison nor this selection attempt
currently supplies a uniform positive mechanism.

The checkpoint uses exact manuscript geometry and arithmetic. No numerical
search, local Lean build or cache restoration is needed. Independent review
accepted both manuscripts without corrections. Root read both authors and
the complete review; the integration receipt records source bindings and
administrative checks separately from the mathematical review.

Pass 81 merged through PR80 at
`9aa78b83ad709d611fc0100fa8cb4f8f33b89223`, after both required checks passed
and the fetched main revision passed fourteen hash checks and ancestry checks.
The unrestricted canonical proof/disproof goal remains active and unresolved.
