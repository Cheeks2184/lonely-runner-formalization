# Joint seed extremality and the remaining induction step

Pass71 merged through PR70 at
`ca9d2d7f20f66cceb7db3b440d0378203624aa39`. Both required CI jobs passed.
Root verified the exact reviewed head on fetched main, four frozen source
hashes, two dependency hashes, and the previous main's ancestry.

The new argument assumes an actual positive integer LRC counterexample,
minimal first by moving count and then by speed sum. Count minimality supplies
strong seeds for every original deletion. Their protected scores have an
attained joint maximum strictly below the desired closed margin. This strict
gap gives a quantitative separation between different deletion seed sets
and a necessary inequality for a transfer at the deleted runner's first
strong-margin entry time.

If the maximizing deleted runner is fastest, that first entry must leave at
least two other runners below the strong margin. Thus extremality constrains
possible transitions; it does not supply one. The maximum need not belong to
the fastest deletion. A successful uniform induction still needs an actual
original deletion seed at a time where the score comparison is strict.

The existing fixed-endpoint minimality invariant applies to every deletion,
including slower pivots. At an outward weak endpoint from a fastest-deletion
seed, subtracting the endpoint owner's speed from the fastest speed gives
an explicit stronger-margin witness for the smaller replacement tuple.
This is consistent with minimality. It produces a good replacement endpoint,
whereas descent requires one smaller speed that is bad at every endpoint of
the same fixed set. Weak endpoints are outside all original strong seed sets;
their uniform separation uses the maximum speed of the full tuple.

These statements are manuscript consequences under a hypothetical minimum.
They neither supply a smaller counterexample nor resolve unrestricted LRC.
The author and independent review are retained separately, with exact source
bindings and the root verification receipt in
`research/astra-pass72-verification.json`. No numerical experiment, new Lean
declaration, dependency restoration, or unchanged local full build is part of
this checkpoint.

A separate active investigation considers centre-preserving lattice
projections and whether a failed witness lift can yield a genuine smaller
counterexample. That unfinished work is excluded from this checkpoint.
The canonical six-runner milestone remains established; the research target
continues to be an arbitrary-N mechanism, not successive runner counts.
