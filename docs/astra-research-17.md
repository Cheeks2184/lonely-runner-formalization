# Seventeenth Astra research checkpoint

An exact counterexample rules out universal availability of the weighted
bad-incidence condition introduced after the constant-term criterion. This
closes a sufficient-condition branch. It does not refute sparse noncover or
the Lonely Runner Conjecture, and it adds no Lean theorem.

For the nonnegative product `Q=H_p*product(H_d)`, let `A=CT(Q)` and let
`T_bad` be its actual-grid average weighted by the number of strictly bad
lower owners at each point. The implication `T_bad<A => noncover` remains
valid. The converse fails because a point with two bad owners contributes
twice to incidence, while a point with no bad owner contributes nothing.
The exact difference is positive good-set mass minus the extra multiplicity
mass at covered points.

The new condition first improves on the previous factor bound. At `N=9`,
pivot `5`, and lower speeds `(1,2,3,4)`, a rational calculation proves
`T_bad<4<12=A`, although the earlier trigonometric factor criterion fails.
This is a strict extension of the sufficient domain, not a universal supply
argument.

The counterexample has `N=35`, pivot `31`, and all moving speeds
`{2,4} union {1,3,5,...,31}`. There are seventeen distinct genuine lower
owners, so `2c=34<35`. Integer polynomial multiplication gives `A=860`.
At the sixteen candidates `(1085 +/- j)/2`, with odd `j` from one through
fifteen, exactly speeds `2` and `4` are bad. Rational sine and cosine lower
bounds certify that these points alone give `T_bad>(101/100)A>A`.
No floating-point comparison is used in this certificate.

The tuple has an immediate closed witness at candidate `r=31`, time `1/35`,
and a strict witness at `r=33`, where every residue distance is at least
`33>31`. Common positive scaling preserves the constant term and normalized
weighted grid average, giving arbitrary pivot heights at this same fixed
`N`. The failure concerns the auxiliary criterion even on a configuration
with explicit witnesses; it supplies no counterexample to LRC.

The author used a finite numerical family to select the fixture, then
replaced the proposed inequality with an integer/Fraction-only certificate.
Root independently computed `A=860` by direct Laurent convolution and
obtained a weaker rational central-mass bound exceeding `434>860/2`, which
already proves `T_bad>A`. Root also replayed the author's stronger exact
certificate. Independent review accepted the exact manuscript without correction.
Root replayed its separate lower sum, twelve boundary perturbations, and
136,710 exact distance identities across seven scales. The proof itself
retains every positive scale; finite controls do not supply that quantifier.
No local Lean rebuild is needed for this manuscript-only checkpoint; the
formal source and its prior verification remain unchanged.

- [Exact audit and certificate](../research/astra-weighted-sparse-audit.md).
- [Independent review](../research/astra-weighted-sparse-review.md).
- [Verification manifest](../research/astra-pass17-verification.json).
- [Previous formal checkpoint](astra-research-16.md).

The remaining mathematical gap requires a different sufficient argument or
a way to control covered points without this multiplicity overcount. Directly
asserting positive good-set mass is equivalent to witness existence and does
not supply that missing proof. Unrestricted LRC remains unresolved.
