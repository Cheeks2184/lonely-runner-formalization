# Thirty-fifth Astra checkpoint: buffered insertion and five-runner classes

This checkpoint formalizes insertion with unequal witness margins and applies
it to sufficient five-total-runner classes. It does not prove the universal
five-runner mixed assertion or unrestricted LRC.

## Exact five-runner conclusions

For positive natural speeds `0 < a < b < c < H`, `FiveRunnerMixed a b c H`
means that one positive real time gives the first three moving speeds distance
at least `1/5` from the stationary runner, and gives speed `H` distance at
least `1/4`. All four thresholds are closed.

The new parameter theorem supplies this witness whenever both

```text
10*a*b <= H*(a+b)
30*b*c <= H*(3*c+8*b)
```

hold. The simpler sufficient condition `22*b <= 3*H` implies both inequalities.
Separately, the entire lower exceptional family `(a,2*a,3*a,H)` is covered
for every `a>0` and `H>3*a`. None of these public statements assumes
primitivity, a supplied strict ordinary witness, or a lower-count hypothesis.
These statements concern the chosen stationary runner and ordered natural
speeds. They do not assert the canonical arbitrary-real, arbitrary-chosen-label
five-runner theorem.

## Reusable insertion theorem

For a nonempty finite family of positive real speeds `w_i`, take a positive
seed time with margins `mu_i > delta`, where `0 < delta < 1/2`. A new positive
speed `V` receives target margin `beta`, with `0 <= beta <= 1/2`. It suffices
that each old speed satisfies

```text
2*beta/V <= (1-2*delta)/w_i
```

and each pair of distinct labels satisfies

```text
2*beta/V <= (mu_i-delta)/w_i + (mu_j-delta)/w_j.
```

`bufferedRunnerInsertion` then gives one positive time meeting all old
`delta` margins and the new `beta` margin. It allows repeated speeds,
unequal margins, and a new speed smaller than an old speed.

The proof uses the integer bands around the supplied seed. The labels
attaining the largest left endpoint and smallest right endpoint either agree,
giving a full band width, or differ, giving the sum of their two buffers.
The midpoint phase-correction lemma fits the new speed inside the common
closed interval. Positivity follows from the old bands and the positive seed;
no integer shift of an arbitrary-real-speed family is assumed to preserve
its phases.

For five runners, the earlier four-runner classification supplies seed margins
`1/4,1/4,1/3` off its exceptional family. Reducing the old targets to `1/5`
gives the displayed two inequalities; the third pair follows from `a<b`.
The exceptional family uses explicit denominator-four/five witnesses after
normalization, or the coprime grid when the normalized lower speed is at least
two. The final time is made positive and scaled back by the positive gcd.

## Coverage and remaining work

The fixed tuple `(4,5,11,24)` satisfies the new parameter test and has mixed
witness `13/96`. The previously compared uniform-quarter harmonic and
determinant ordinary tests require `H >= 55/2`, so fail on this tuple.
This is a comparison with those specific tests, not a claim of new coverage
relative to all known constructions or the mathematical literature.

The accepted manuscript also derives an integer-ceiling refinement using
endpoint determinants and pair gcds. That refinement is not formalized in
this checkpoint. Its closed-width example `(12,20,24,75)` shows why strict
endpoints cannot replace the closed target in the implementation.

The manuscript rejects integer dilation of an arbitrary strict seed as a
uniform conversion method: for `(3,4,5,11)` and seed `1/9`, no integer
multiple is mixed, although the separate time `1/8` is mixed. This does not
refute the global strict-to-mixed implication. A bounded certificate-design
investigation is assessing the remaining five-runner domain without a large
tuple enumeration.

## Verification

The full `lake build LonelyRunner` passed with 3,646 jobs reported, including
cached targets. The trust audit accepted 462 reports using only `propext`,
`Classical.choice`, and `Quot.sound`. The generic core has an independent
source review and a successful guarded root replay. Final independent source
review and root replay passed 17 kernel examples, six allowed-axiom reports,
and 15 immutable guards. The probes cover the five new public types, the
exact mixed predicate, unchanged canonical four-runner compatibility, and ten
fixed applications. No source correction was required by the final review.
After the verification batch, guarded cleanup removed 7,762,815,050 bytes of
rebuildable cache. The pinned toolchain and all unique evidence were retained.

See the [mathematical manuscript](../research/astra-five-runner-mixed-structure.md),
[independent manuscript review](../research/astra-five-runner-mixed-structure-review.md),
[generic core review](../research/astra-buffered-runner-insertion-formal-review.md),
[final source review](../research/astra-five-runner-buffered-formal-review.md),
[verification record](../research/astra-pass35-verification.json),
[exceptional-family report](../research/astra-five-runner-exception-implementation.md),
and [five-runner implementation report](../research/astra-five-runner-buffered-implementation.md).
