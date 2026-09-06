# A rational margin gap makes endpoint detection quantitative

Date: 2026-09-06. Root manuscript at main checkpoint
`665a35f68d468be388e4bc3a7538ff3e8c8a9cd3`. No new Lean theorem or mathematical
computation is claimed. This is a corollary and scope check of the existing
pair-sum completeness theorem, not a new witness-supply mechanism.

Read source bindings:

| Source | SHA-256 |
| --- | --- |
| `LonelyRunner/PairSumCompleteness.lean` | `838a3bcec806b0e9d01cd117e64e5348de58a05127a3f7bef5dbe2d879ff292f` |
| `LonelyRunner/EndpointCompleteness.lean` | `0e3f10f64daf41bedebf31bb71cb6b93ffa5358615c6c30ec941b01fc97b9d57` |
| `research/astra-uniform-global-seed-geometry.md` | `3a4a825f3f801282eb39b469571bbd4cac3a4e1f768d58542b7c1555cd725524` |

Let `n=N-1>=2`, let the speeds be distinct positive integers, and let `M>M_2`
be the largest two. Write `S=M+M_2`, `delta=1/N`, and

```
epsilon=1/[N(S+1)],
alpha=delta-epsilon=S/[N(S+1)] > 0,
H_beta={t mod 1 : every i has ||v_i*t||>=beta}.
```

**Exact lifting lemma.** If `H_alpha` is nonempty, then `H_delta` is nonempty.
Apply the existing `exists_pairSum_time_of_witness` to the supplied alpha
witness. It supplies distinct labels `p,q`, `D=v_p+v_q<=S`, and an integer
`r` with `0<r<D`, such that every norm at `r/D` is at least alpha. Each
coordinate norm at this time is `b_i/D` for a nonnegative integer `b_i`:
reduce `v_i*r` modulo D and take the smaller of its residue and its complement.
If one of these norms were less than delta, then

```
delta-b_i/D = (D-N*b_i)/(N*D) >= 1/(N*D)
                                      >= 1/(N*S)
                                       > 1/[N(S+1)] = epsilon.
```

The first inequality uses a strictly positive integer numerator. It contradicts
`b_i/D>=delta-epsilon`. Thus the very same pair-sum time is fully delta-good.
This proof does not assume a positive-measure original witness set, a simple
contact, lower-count LRC, seed nonemptiness, or the existence of a global
maximizer. The distinct-speed assumption is used for the bound by the two
largest speeds; the pair-sum theorem itself does not need that assumption.

There is also an exact strict formulation:

```
exists t, every norm at t > delta-1/(N*S)
    iff H_delta is nonempty.                         (1)
```

For the forward direction choose a positive common margin beta between
`delta-1/(N*S)` and the minimum norm at t, and apply the same pair-sum theorem.
The strict inequality is essential to this numerical argument. The chosen
alpha lies strictly above that boundary, so closed alpha suffices in the
lifting lemma. No actual counterexample at the excluded boundary is asserted.

**Length formulation with controlled precision.** The lifting lemma gives

```
H_delta nonempty  iff H_alpha nonempty
                 iff mu(H_alpha)>0.                 (2)
```

Only the last implication back to nonemptiness is tautological. For the
other direction, take a delta witness and use the circle-norm Lipschitz bound.
Every time within epsilon/M of it is alpha-good. This is a circular interval
of length `2*epsilon/M<1`; it may cross the chosen unit-period cut. In fact,
nonemptiness in (2) implies the quantitative lower bound

```
mu(H_alpha) >= 2/[N*M*(S+1)].                         (3)
```

All sets are finite unions of intervals over one period. No probabilistic
independence or measure-theoretic approximation of isolated endpoints is
being assumed. If no closed delta witness exists, H_alpha is exactly empty,
not merely null. Conversely, a null but nonempty H_delta becomes a genuine
positive-length set at the specified alpha. This resolves the endpoint-loss
issue only by asking for a tuple-dependent approximation precision.

**What this does and does not improve.** Applying an argument at the unchanged
delta and ignoring null sets cannot detect tight isolated witnesses. Equations
(2)--(3) provide a precise alternative target for a length argument. They do
not supply any positive lower bound on H_alpha without a witness assumption.
The loss used here is of order `1/[N(M+M_2)]`; this denominator-gap estimate
does not justify a fixed proportional loss uniformly as speeds grow. No
optimal or necessary precision, or impossibility of another conversion, is
claimed. Conditional finite
height bounds could replace S by a uniform upper bound within that finite
family; that still gives a reformulation of finite supply, not its proof.

Nor does this establish Q: the recovered delta witness need not belong to a
protected deletion-seed union B. It therefore offers a possible way around
that stronger auxiliary target, while leaving the full positive-length supply
in (2) unresolved. Merely replacing delta by alpha in the earlier shell
accounting does not produce such supply: its elementary extension lower bound
and total shell budget both scale with `gamma-alpha`, which cancels in the
same coarse component-count comparison.

The Lean lifting proof can reuse `exists_pairSum_time_of_witness`, rational
residue arithmetic, and elementary inequalities; the optional length statement
would additionally need finite-interval length or measure facts. No dependency
cache restoration or implementation is justified until a new argument can
supply the alpha witness or its positive-length equivalent. This report is
submitted for independent mathematical review, not promoted as a formal result.
