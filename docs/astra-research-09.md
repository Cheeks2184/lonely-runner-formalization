# Pass 9: weighted avoidance and a complete one-outlier family

Two new Lean modules strengthen the affine-grid development without assuming
an unrestricted Lonely Runner witness.

`LonelyRunner/WeightedAffineAvoidance.lean` proves a finite-field counting
lemma. If at most `p-2` nonzero directions make a form vanish and the total
number of forbidden nonzero values is at most `p-2`, a nonzero parameter
pair avoids every forbidden set. The theorem allows arbitrary finite index
sets, repeated forms, zero coefficients and the prime 2. A wrapper exposes
the alternate coefficient convention. These are sufficient hypotheses;
there is no claim that every velocity tuple supplies them.

`LonelyRunner/AffineOneOutlierFamily.lean` proves a common closed `1/N`
witness for the speeds

```text
2, 3, ..., N-3, v, N, 2N
```

for every odd integer `N>=5` and every positive integer `v`. The public
integer-indexed version retains the entire interval `2<=a<=N-3`. The proof
works over odd composite residue rings as well as prime fields. It chooses
one of three times when `N` does not divide `v`, a fixed time when only `N`
divides `v`, and a small positive perturbation when `N^2` divides `v`.
Repeated speeds are allowed; distinctness is needed only when presenting
this as a distinct-speed instance of LRC. The family has `N-1` indexed
moving speeds and uses the closed boundary, which is attained in some cases.
Its elementary proof is independent of the weighted field lemma.

The accompanying manuscript `research/astra-exact-band-route.md` also
proves an exact cyclic bad-residue description and a sufficient rounding
construction with forbidden sets fixed before selecting the parameter
pair. It accounts for large corrections that wrap around the circle,
actual lifted speeds, and original-speed transport modulo `p*M`. Those
general bridge statements remain manuscript proofs in this checkpoint.
The older unwrapped Lean band theorem is not an exact cyclic equivalence.

The new sufficient construction handles `(2,3,4,7,14,9)` for every modulus
`M>=89`, despite the previously proved obstruction to the coarse A/B/R
union. At `M=101` it gives the strict witness `116/707`, with minimum
distance `15/101`. At `M=98` it gives `8/49`, with minimum `1/7`.
The manuscript and independent review retain exact arithmetic reproductions
and counterexamples to overly broad shifted-pair or composite-ring claims.

The full Lean build passed 3,608 jobs. The trust audit accepts 350 theorem
reports, including the four new declarations, using only `propext`,
`Classical.choice` and `Quot.sound`. Root also reran both manuscript
reproduction blocks: the author checks 53,848 weighted instances, 9,504
cyclic cases and 1,335 family cases; the independent reviewer checks
148,848 weighted instances, 35,000 cyclic cases and 10,892 family cases.
Source hashes, exact review scope and verification commands are recorded in
`research/astra-pass9-verification.json`.

The unrestricted canonical `LonelyRunner.Conjecture` remains unresolved.
No arbitrary-tuple supply theorem for the new weighted envelopes is proved.
The next pass evaluates that gap and formalizes the general cyclic bridge;
unfinished work from that pass is excluded from this checkpoint.
