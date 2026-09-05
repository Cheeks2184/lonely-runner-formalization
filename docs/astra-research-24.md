# Twenty-fourth Astra checkpoint: unequal endpoint clusters

This checkpoint proves the specified unequal two-cluster family in Lean and
records a separately reviewed conditional extension to arbitrary fixed
clusters. Unrestricted LRC remains unresolved.

## The precise family

Let A and B be finite subsets of the positive integers through M, and put
N = |A| + |B| + 2. Assume

```text
N >= 4, M >= 1, M < N-2, p >= 2M+1,
(p-M)(N-2-M) >= M(N-1).
```

The speed set is `{0} union A union {p-b : b in B} union {p}`. The
separated ranges give exactly N distinct runners. The accepted manuscript
supplies a positive time for each chosen runner, at the original closed
distance threshold 1/N. The two sets may have holes, different members,
and different cardinalities. In particular, this includes odd total counts.

For a lower chosen speed r, put P=p-r, q=floor(P/N), and delta=1/N. The
constructed time is

```text
t = max(delta, (q+delta)/(P-M)).
```

The integer quotient and remainder, together with the displayed growth
bound, place every required phase in a closed good band. Negative lower
differences use invariance of circular distance under negation. An upper
chosen runner is handled by reflecting all speeds, which swaps A and B.
The reflected set need not equal the original set.

For every N>=4 there is a specified example of this form: take M=N-3,
A={1,...,M}, B={1}, and p>=N(N-3). This statement about a family at each
count does not quantify over all configurations of that count.

## Manuscript and formalization boundaries

The [manuscript](../research/astra-dense-paired-blocks.md) and its
[independent review](../research/astra-two-cluster-review.md) also prove an
exact integer-interval criterion for the particular phase cell. Its residue
specialization can succeed when the uniform growth bound fails. A failed
cell test is not an LRC counterexample: the review includes an empty-cell
configuration with an ordinary designated-zero witness.

The Lean result is the unconditional sufficient family above. Its
arithmetic core uses a real phase-band lemma, a real interval-existence
lemma, and an integer quotient/remainder wrapper. The finite-set layer
verifies exact cardinality and the explicitly swapped reflection map. The
all-runner bridge retains signed real differences and the original N under
arbitrary injective labelling. The final declaration is
`LonelyRunner.twoClusterLonelyAt`.

The earlier complete mirrored-block theorem has a stronger height range
for its own family. The new construction broadens the allowed shapes; it
does not improve every case of the earlier theorem. No reduction of an
arbitrary configuration or minimum counterexample to these hypotheses has
been established.

## Verification

The root replayed both independently written manuscript programs. The
author's controls checked 429 fixed-k comparisons and 532 signed relative
comparisons. The independent review checked 176 fixed-k comparisons and
1,708 signed comparisons, including equality, zero-width congruence,
unequal reflection, and odd-count cases. These computations support the
manuscript audit; they do not replace its derivation or kernel checking.

The full build passed 3,620 jobs, the trust audit accepted 389 reports using
only `propext`, `Classical.choice`, and `Quot.sound`, and all 58 focused tests
passed. The [independent source review](../research/astra-two-cluster-formal-review.md)
accepted both frozen source files. The root replayed its exact generators and
both fresh-source Lean probes successfully. The core probe checks ten fixed
instances, 45 phase bounds, and six invalid-hypothesis exclusions. The
combined probe checks 56 runners, 310 signed comparisons, and 65 equality
contacts across nine configurations, plus a complete canonical labelling of
an N=1001 example. A generic enumeration proof establishes that the labelling
contract is nonvacuous and covers the entire original finite set.

## A conditional extension to arbitrary fixed clusters

A separate [manuscript](../research/astra-cluster-limit-audit.md) removes
the density restriction for sufficiently separated fixed clusters, under an
explicit smaller-count hypothesis. Here A and B include zero and may have
negative integer offsets. Put N=|A|+|B|>=3,
K=max(diam(A),diam(B)), and R=max(max(A),max(B)). Assuming the positive
integer stationary conjecture for at most N-2 distinct moving speeds, every
integer p>=R+N(N-1)K/2 gives an N-runner configuration A union (p-B)
with a positive witness for each chosen runner.

The proof makes two comparison speeds coincide without colliding with the
chosen stationary runner. Deduplicating absolute speeds permits use of the
smaller-count hypothesis with a strict margin. A nearest integer then adjusts
the time to match the large separating speed. The resulting phase error is
controlled by the fixed internal widths. Singleton clusters and two total
runners have separate arguments. Reflection again swaps the clusters.

This conditional result excludes a sufficiently narrow two-cluster split of
a least-count counterexample. It supplies no reason that every configuration
has such a split. Its [independent review](../research/astra-cluster-limit-review.md)
accepted the argument, and the root replay passed 59 lifts and 181 signed
comparisons, including both rounding choices and two exact boundary
witnesses. The separate implementation controls passed 120 runner checks
and 528 signed comparisons. An initial checker bug returned the unadjusted
time; root review identified it, and the corrected durable reproducer passed.
This conditional result is not yet a Lean theorem, and the smaller-count
hypothesis remains explicit.

After all verification commands stopped, safe cleanup removed 7,720,771,757
bytes of rebuildable `.lake` contents. The pinned toolchain, source, Git
history, and compact reproductions remain. Exact hashes and commands are in
the [verification record](../research/astra-pass24-verification.json).
