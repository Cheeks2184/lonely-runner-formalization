# Thirty-second Astra checkpoint: zero-residual mixed-height strengthening

Pass 32 records a kernel-checked strengthening of the affine large-height
pipeline and an accepted, separate strict-to-mixed necessary-condition audit.
It does not prove unrestricted LRC, arbitrary-runner cutoff coverage, or a
uniform finite-family supply theorem. The modular-unit manuscript and the
separate N=4 finite-classification plan are outside this checkpoint.

## Zero-residual affine and stationary contract

The frozen plan
[`astra-zero-residual-mixed-height.md`](../research/astra-zero-residual-mixed-height.md)
has SHA-256
`91f2bfee846f2c682976e3476e8c3e3214c163661945957bdef8bdb6cecbb8a7`.
Its implementation record is
[`astra-zero-residual-implementation.md`](../research/astra-zero-residual-implementation.md).

The six additive theorems preserve all older public theorem types as projection
wrappers. The strengthened transfer keeps the full `delta + epsilon` margin
when a residual is zero at the same positive time; its positive, signed, and
relative forms propagate that fact while the relative form excludes the chosen
label. Writing `N=m+2>=3` and

```text
B = choose(N,2)^(N-2),
```

`primitive_sorted_largeHeight_stationary_mixed` proves that `B<H` yields one
positive stationary `LonelyAt` time with every ordinary norm at least `1/N`
and the fastest norm at least `1/(N-1)` at that same time. Under exactly the
same lower-count, sorted, stationary, and primitive hypotheses,
`primitive_sorted_noMixed_height_le` proves the conditional inclusive converse
`H<=B` from absence of this mixed witness. No ordinary witness premise is
added to that converse.

This is a stationary, primitive-sorted theorem under its listed lower-count
hypothesis. It neither establishes an arbitrary-runner height reduction nor
removes the unresolved inclusive primitive finite-family supply needed for
the canonical reduction.

The final implementation refactored the coordinatewise phase/norm equality
before the ordinary and zero-residual branches, and likewise factored the
sign-normalized norm equality before both signed branches. The retained shared
cache was used for the final full source build, which completed with 3,638 jobs
reported. The trust audit accepted 438 permitted-only reports; the six exact
API probes used only `propext`, `Classical.choice`, and `Quot.sound`.

The independent exact-patch semantic review was accepted at
[`astra-zero-residual-review.md`](../research/astra-zero-residual-review.md).
Its SHA-256 is
`2d280adc4e51068db4b2c5fdb6684dc3e507d9027b522b332849891387d2fdff`.
The root read the full review and replayed its guarded program: six kernel
compatibility checks against the old signatures, four conditional boundary
checks, and fourteen permitted-only axiom reports passed. The verification
record is [`astra-pass32-verification.json`](../research/astra-pass32-verification.json).

## Accepted strict-to-mixed narrowing

The frozen author audit
[`astra-strict-to-mixed-audit.md`](../research/astra-strict-to-mixed-audit.md)
has SHA-256
`c7559719cc61d715a47958ab8d1a844faf021c53e08ee3e87c1d0d54e0fb5f2f`.
Its independent Astra review is accepted at SHA-256
`6f0ba11b6640b662eb72a86326a1b7d429444e61a1a78b60a8d1b8b8e06a466d` in
[`astra-strict-to-mixed-review.md`](../research/astra-strict-to-mixed-review.md).
The root replayed both guarded exact-control blocks.

The audited global question K starts from a strict ordinary witness and asks
for a possibly different time with every norm at least `1/N` and the fastest
norm at least `1/(N-1)` at that same time. The audit proves necessary
restrictions only. A counterexample must have primitive lower core. For
`N=4`, writing its speeds as `a<b<H`, it must additionally be pairwise
coprime, satisfy `b>=4`, and lie in the strict range `b<H<4b`. The exact
diagnostic covers 2,330 narrowly direct-eligible tuples; it is finite evidence
and has no global classification force.

Neither the audit nor its review proves K, a global mixed-supply theorem, a
finite-family supply theorem, or LRC.
