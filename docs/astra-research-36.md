# Thirty-sixth Astra checkpoint: generic rational-margin certificates

This checkpoint provides exact certificate interfaces for supplied witnesses.
It does not supply witnesses uniformly, classify the remaining five-runner
tuples, or resolve unrestricted LRC.

## Exact rational row checks

For natural `p,q`, a speed `w`, and margin `A/B`, put `r=(w*p)%q`.
When `q>0` and `B>0`, the closed circle inequality at time `p/q` is
equivalent to the two natural inequalities

```text
A*q <= B*r
B*r + A*q <= B*q.
```

`RationalMarginCertificates` proves this equivalence and packages it into a
Boolean checker for any `Fin n` row with separate margin numerators and
denominators. Its arithmetic and real-circle characterizations are exact.
Numerators and speeds may be zero, speed values may repeat, and the checker
does not assume the margins are at most one half. Impossible margins fail
the check. The checker rejects zero denominators; `p=0` is allowed for a
pointwise assertion. The positive-time corollary separately assumes `p>0`.

## Nonuniform endpoints and strict pair sums

`exists_endpoint_time_of_witness` takes a nonempty family of positive natural
speeds, real margins `0<d_i<=1/2`, and any supplied real witness. It returns
an owner `p` and a natural `k<(w_p+1)/2` such that

```text
T = (k+d_p)/w_p,     0 < T <= 1/2
```

meets every original margin. Sorting and injectivity are unnecessary.
The proof first folds the supplied time into the half period by periodicity
and reflection. Every floor band contains that seed; their largest left
endpoint remains inside every band. This includes singleton intersections,
ties, negative starting times, and the half-period boundary. Natural speeds
are essential to the periodic folding used here.

`exists_strictWitness_iff_pairSum` treats a different question. For at least
two positive natural speeds and a positive common real margin `delta`, a
strict witness exists exactly when some positive pair-sum time
`r/(w_p+w_q)`, with `p!=q` and `r<w_p+w_q`, meets all margins strictly.
The forward proof applies existing closed pair-sum completeness to the
attained minimum norm of a strict witness. The indices are distinct labels;
their speed values may coincide. This theorem does not claim that an ordinary
pair-sum witness preserves an additional fastest-runner margin.

## Five-runner use and resource boundary

For margins `1/5,1/5,1/5,1/4`, the endpoint construction gives candidates
`(5k+1)/(5w)` for each of the first three speeds and `(4k+1)/(4H)` for
the fastest. Reflection leaves `ceil(w/2)` candidates per speed. At the
current primitive inclusive cutoff `H<=1000`, there are at most 1,998
candidates with denominators at most 4,995. These numerical specializations
are reviewed mathematical consequences; an N5-specific total decision
procedure and its finite-domain coverage certificate are not added here.

The resource investigation counts 41,417,124,750 increasing quadruples before
primitivity. A literal four-coordinate `Fin 1001` check instead visits
1,004,006,004,001 keys. Separate divisor and geometric counts do not give the
size of the fully filtered residual. The exact counts use finite arithmetic
sums, not a speed-tuple scan.

The proposed next experiment is a small partition-certificate pilot, where
a rational witness proves an entire box from coordinate endpoint inequalities.
The proposed caps are 256 leaves, 64 KiB of proof data, 60 seconds per kernel
check and 4 GiB process RSS. They are unmeasured stop conditions, not evidence
that a small certificate for the whole domain exists. No pilot or large search
has been run in this checkpoint.

A strict-to-mixed certificate may reject a row by proving it has no strict
ordinary witness. That does not supply a closed ordinary witness. A complete
ordinary stationary five-runner certificate would be more useful at comparable
cost: together with the existing lower-count supply, it would feed the bounded
real bridge and prove the canonical five-runner specialization. Both finite
coverage obligations remain open.

## Verification

The full `lake build LonelyRunner` passed with 3,649 jobs reported, including
cached targets. The trust audit accepted 470 reports using only the permitted
axioms `propext`, `Classical.choice`, and `Quot.sound`. The design and its
independent review passed guarded root replays. The final independent source
review and root replay passed 23 kernel examples, nine axiom reports and
15 source/report/dependency guards. No source correction was required.

See the [design](../research/astra-five-runner-certificate-design.md),
[design review](../research/astra-five-runner-certificate-design-review.md),
[row-checker report](../research/astra-rational-margin-certificates-implementation.md),
[endpoint report](../research/astra-endpoint-completeness-implementation.md),
and [strict pair-sum report](../research/astra-strict-pair-sum-implementation.md).

The [final source review](../research/astra-rational-margin-formal-review.md)
and [verification record](../research/astra-pass36-verification.json) preserve
exact source hashes, commands and reproducible edge controls.
