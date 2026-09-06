# Closed endpoints and the limits of protected-length accounting

Pass61 merged through PR60 at `665a35f68d468be388e4bc3a7538ff3e8c8a9cd3`.
Both required CI jobs passed and fetched main contains the exact reviewed head.
This pass continues uniform arbitrary-N research after the canonical N=6
milestone. No new Lean theorem or successor-runner milestone is claimed.

The global deletion-seed argument now has an independently reviewed exact
identity. It accounts for protected extension, the uniquely bad region outside
that extension, and surplus threshold-shell multiplicity. All three terms are
nonnegative. The resulting weighted component-count bound is weaker than a
direct charge to rising endpoint events, so it adds no count obstruction.

The same identities hold when the full-good set has length zero. Protected
sets can then intersect at isolated full witnesses, even though they are
disjoint almost everywhere. For every prime N>=5, consecutive speeds
1,...,N-1 explicitly supply every deletion seed and a protected witness at
closed equality; their full-good set consists exactly of primitive N-grid
points. Thus the aggregate estimates do not distinguish these successful
tight examples from strict trapping. The remaining seed obligation is a
full witness inside the protected union, not simply a length identity.

A separate corollary of the existing pair-sum completeness theorem makes an
alternative endpoint-sensitive target quantitative. Let M and M_2 be the two
largest speeds, S=M+M_2, and alpha=1/N-1/[N(S+1)]. Any alpha witness can be
converted to a pair-sum time with denominator D<=S. At that time a norm below
1/N would miss it by at least 1/(ND), more than the allowed loss. Therefore
an alpha witness supplies a full 1/N witness. Equivalently, the alpha-good set
has positive length precisely when the closed full-margin set is nonempty.
This is a reformulation with explicit precision, not a new supply theorem,
and it does not imply that the recovered witness lies in a deletion-seed ball.

The manuscript and its independent review records distinguish algebraic
arguments, existing kernel facts, and the remaining uniform supply gap.
No mathematical enumeration or unchanged local Lean build was run for this
pass. The source bindings, workflow validation, diff check and storage report
are retained in `research/astra-pass62-verification.json`. Rebuildable dependency
and build artifacts remain absent. Endpoint-event counting is a separate
active investigation; its unfinished output is excluded from this checkpoint.
