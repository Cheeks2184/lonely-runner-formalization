# Final six-total-runner assembly boundary

Root source-derived integration plan, not a completed theorem. This freezes the
last assembly target while the remaining two-even and three-even implementations
are developed. Do not replace unrestricted LRC completion by this milestone.

1. Supply the unique-three-divisible branch for positive v : Fin 5 -> Nat:
   pivot p with 6 dividing v p, every three-divisible label equal to p, and
   even-label count equal to one, two or three. The one-even contract is already
   compiled; two and three remain outstanding. Each returns the same positive
   time with all five closed 1/6 inequalities, without speed injectivity or gcd.
2. For primitive v, assume no all-real witness. The checked divisor-count bounds
   at ell=3 give count in [1,3]. If count>=2, use the compiled primitive
   at-least-two branch. Otherwise the filter has exactly one label p. The lower
   bound at ell=6 gives a six-divisible label, and 3|6 identifies it with p.
   The bounds at ell=2 give even count in [1,3], so one of the three parity
   contracts contradicts the all-real absence. Convert the resulting nonzero
   real witness to positive time by negation when needed.
3. For arbitrary positive v, let g=Finset.univ.gcd v, w i=v i/g. Positivity
   proves g>0, w i>0, and Finset.gcd_div_eq_one gives the primitive hypothesis.
   The exact factorization v i=g*w i transports the common witness to t/g.
   Unlike the earlier exact-two normalization, no divisibility-count preservation
   lemma is needed, because the primitive theorem now covers every branch.
4. Extend lowerCountPositiveIntegerHypothesis_six (H_6, through FOUR moving
   speeds) to H_7, through FIVE moving speeds. Split d<=4 versus d=5; the
   new unrestricted positive-natural Fin5 theorem handles only the latter.
   H_7 is the bounded hypothesis needed for the canonical SIX total runners;
   the suffix seven here is not a seven-runner milestone.
5. Declare sixRunners (speeds : Fin 6 -> Real) (hinj : Function.Injective speeds)
   (runner : Fin 6) : exists t : Real, LonelyAt speeds runner t, by the checked
   lonelyAt_of_lowerCount with m=5 and H_7. That existing bridge handles arbitrary
   real speed ratios, negative relative speeds and each selected label.

Before the transition is considered established: root integration build, source
trust and axiom audit, and independent exact-scope review of the canonical Fin6
declaration and its dependency chain must pass. Then pivot to a uniform arbitrary-N
mechanism; do not pursue successive runner counts as milestones.

## Source bindings

- `LonelyRunner/SixTotalDivisorCounts.lean`: `0b62ef724eb8c24db4085e247e9f16f650ec450291c7ccac2b0ad0981f148727`
- `LonelyRunner/TwoDivisibleNormalization.lean`: `d812237f06d63e67c8739122c76a5e67daa470402575ccafcdcee4c41d950286`
- `LonelyRunner/OneEvenRunners.lean`: `5bf5f01d7b31b410b680d646a832b273890cc267dc7a4775fea37eac5c58b810`
- `LonelyRunner/FiveRunnerOrdinary.lean`: `662d0116f13971bce85e76c503e2f3be4fdc6291ba8113aeda43957e38354ffe`
- `LonelyRunner/LowerCountSupply.lean`: `0705291adc53011fb72fc718a7260876512b092741442d6a6cceb4b76eb5ccf4`
- `LonelyRunner/BoundedRealReduction.lean`: `7eae68d2c46041b39c3e18f9a1e105c75680352f8e4b4edf65e0dd2a92becb72`
- `LonelyRunner/FiveRunnerCanonical.lean`: `a78cdaafcc359110535422d1967676610587a69be8f2bf8810e0ba65be1c8946`
