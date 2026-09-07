# Minimal-failure deletion: independent final source review

Accepted without a semantic correction. The entire final Lean source, including
all private helpers, was read against the accepted contract and its independent
review. The retained-maximum definition and all three public theorem signatures
are unchanged in meaning and preserve every required strictness and quantifier.
The successful root compile and three focused axiom reports bind this exact
source. These remain conditional necessary properties, not an LRC proof.

Task: `/root/minimal_failure_deletion_final_review`. Assigned checkpoint:
`1e4a89034bcab452949734f0d0d689d7de5e27f2`. Requested route: existing in-session
`gpt-6-astra`, `xhigh`; observed model, effort, task elapsed time and usage:
`null`. Only this review is owned and written by the reviewer.

## Exact source and mathematical checks

`retainedMaxSpeed v i` is exactly the natural finite supremum of `v` on
`Finset.univ.erase i`. It excludes the distinguished index and is zero for an
empty complement. Its finite-supremum meaning gives the sharp retained maximum;
the proof does not replace it by the maximum of the full tuple. The private
`retained_le_max` uses actual erased-set membership and `Finset.le_sup` before
casting the comparison to the reals.

`MinimalPositiveIntegerFailure.two_le_count` has only the accepted `hv` premise.
Its explicit use of `hv.count_pos` and a contrary bound reduces the count to
one. The positive speed `v 0` has the existing antipodal closed `1/2` witness;
the bad coordinate supplied by `hv.failure` equals zero by `Fin.eq_zero`.
The closed witness contradicts the strict bad inequality. Neither a stronger
count assumption nor a higher-count theorem has been added.

`deletion_seed_interval` retains the exact let-bound parameters
`alpha=1/(n+1)`, `Q=(retainedMaxSpeed v i:Real)` and
`epsilon=(1/n-alpha)/Q`. It proves positive `Q`, positive `epsilon`, a common
closed `1/n` witness for all retained original labels, and inclusion of the
whole open interval `(s-epsilon,s+epsilon)` in the full closed deletion set.

The actual proof first obtains `n=d+1` and `d>=1`. The restricted tuple
`old j=v(i.succAbove j)` is a positive injection on `Fin d`. The stored
previous-count statement is applied at exactly `d`, whose native threshold is
`1/(d+1)=1/n`. `Fin.exists_succAbove_eq` transports the same seed time to every
original index different from `i`. This is a proof-level count rewrite; the
conclusion still concerns the original `v : Fin n -> Nat`.

The speed at `i.succAbove 0` is positive and bounded by the retained supremum.
The repaired proof explicitly converts this positive real bound back to a
positive natural supremum before using its real cast as a denominator. The
reciprocal comparison correctly gives `1/(d+2)<1/(d+1)`. For any point `u` in
the stated open interval, the proof derives `|u-s|<epsilon` and then

`alpha < beta-Q*|u-s| <= ||v_j*s||-v_j*|u-s| <= ||v_j*u||`,

where `beta=1/n` and `j!=i`. The middle comparison subtracts the correctly
oriented speed-product bound. The last comparison is the source's one-sided
Lipschitz helper, whose absolute-value factorization uses natural-speed
nonnegativity. Strict retained safety is thus derived on the open interval;
the public subset conclusion correctly uses closed `ComplementSafe`. No time
is restricted to `[0,1]` and no strict endpoint claim is inserted.

The common-margin theorem fixes the caller's arbitrary anchor and calls
`exists_attained_strict_failure_margin` exactly once, before introducing any
target index. It returns the same `mu,tau` with `tau in [0,1]`,
`0<mu<alpha`, `F(tau)=mu`, and `F(t)<=mu` for every real `t`. The tuple and
its original minimal-failure hypothesis are preserved. The bound `alpha<=1/2`
is justified with positive denominators and the already proved count bound.

For each target, its positive retained maximum, target positivity, retained
bounds and that same all-real `hglobal` specialize the compiled generic
contraction at width `alpha`. This yields

`||v_i*t|| + v_i*(alpha-mu)/Q_i <= mu`

at every full deletion-safe real time, including closed endpoints. The seed
time may vary with `i`; `mu`, `tau`, `F`, the anchor and the original tuple do
not. The proof does not substitute a deletion-restricted maximum.

## Positive radius helper and all maximizing times

The root-supplied private helper proves that a positive natural speed has
positive circle norm somewhere in any given positive-radius open interval.
If the center norm is positive, the center itself works. Otherwise the exact
round formula implies `s*a=round(s*a)` as real numbers. The source chooses
`b=min(epsilon,1/(2*a))` and `h=b/2`. It proves `0<h<epsilon` and
`0<h*a<1/2`, so `s+h` lies strictly inside the interval. The explicit `calc`
with `congrArg` substitutes the zero-center phase once, giving
`(s+h)*a=round(s*a)+h*a`. Periodicity and the half-interval norm formula then
give norm `h*a>0`. This avoids changing the argument inside the rounded term.
It works for negative centers and shifts crossing an integer time.

The common-margin proof applies this helper to the deletion seed interval,
obtains an actually safe point `u` with target norm `q>0`, and applies contraction
there. Hence `m*(alpha-mu)/Q_i<mu`, where `m=v_i>0`. Dividing by `m` in the
correct direction gives the signature's strictly positive radius

`0 < mu/m-(alpha-mu)/Q_i`.

The final explicit ring calculation only reassociates the product; strictness
comes from the positive target norm. No weak-radius replacement, assumption of
nonzero norm at every safe point, or assumption about interior of each collision
portion occurs. The full deletion interval is what supplies the needed point.

Finally, the proof introduces an arbitrary real `t` with `F(t)=mu` and then an
arbitrary index. It invokes the actual exported
`not_complementSafe_of_global_maximum` with the same tuple, anchor and margin,
and the positive sharp retained bound. This excludes **every** maximizing real
time from **every** single-deletion set, not only the selected `tau`. Reobtaining
the seed theorem to prove positivity of `Q_i` does not reselect the global
margin. No equality between two coordinate norms is claimed.

## Receipts, correction history and scope

The root receipt embeds the final source twice; both copies equal current bytes
and their declared digest. Its successful focused compile, chunk `e82ece`, exits
`0` with empty stdout and stderr. The actual axiom-probe source names exactly
the three public theorems above. Chunk `cf46a7` exits `0`, and all three reports
contain exactly `propext`, `Classical.choice`, and `Quot.sound`. The reported
in-cgroup peaks are 486,891,520 bytes for compilation and 460,120,064 bytes for
the probe, each with zero swap. Both are below 0.5 GiB and were run under the
recorded 4 GiB memory/512 MiB swap cap and shared-cache lock. These are receipt
measurements, not model-task accounting. No compile or probe was repeated here.

The helper receipt preserves one failed root attempt and its successful repair;
both embedded source snapshots match their digests. The repaired helper prefix
is identical to the one in the final module. The worker receipt separately
preserves three failed assembly attempts, with all three source snapshots and
their hashes matching. Their recorded raw diagnostics were read; none is treated
as a successful worker delivery. Root's successful artifact follows these failures.

The recorded root diff exactly equals the diff between the embedded final worker
snapshot and current source. It repairs the natural/real positivity conversion,
two reciprocal comparisons, and the last radius calculation without changing
the three signatures. Its 16 changed-line count is the sum of maximum old/new
lengths over the four replacement blocks; the unified diff adds 15 and removes
11 lines. Root's separate helper contribution is recorded as 46 lines. During
review this metric basis was clarified in the receipt: original receipt
`911bc990fff98e43e42713ae4499ad1b6d8a09e78f4ec2081e73ae7df27b83a3`
was superseded by the bound `fc536be3...` receipt. Source, compile and axiom
evidence were unchanged. The earlier correction of worker output provenance
remains recorded; the independent successful evidence is root's captured output.

No semantic correction or falsifier was found for the exact source. The accepted
singleton control at a larger working width still explains why mere safe-set
nonemptiness cannot replace the interval argument. This module supplies neither
a new beta-ratio wrapper nor an unconditional failure/contradiction theorem.
The first unresolved mathematical implication remains the uniform selection or
descent step needed to rule out the hypothetical minimal failure. Root's full
integration/publication checks remain separate from these focused receipts;
unrestricted LRC remains unresolved.

## Readback and frozen bindings

Current configuration, workflow, policy and the focused active state were read;
research is authorized and the full goal remains in progress. Workflow validation
passed at startup and handoff. Full final-source/review readback, all twenty-one
direct bindings below, all fifteen contract inputs, all nineteen contract-review
inputs, embedded receipt/source/diff checks, the exact three axiom reports, and
source/review whitespace and final-newline checks passed. A direct source scan
found no admitted proof, custom axiom, unsafe declaration or computational trust
shortcut. The reviewer wrote only this file and used no Lean run, mathematical
program, additional agent, Git/state/memory edit, build or cache change.

| Input | SHA-256 |
| --- | --- |
| `LonelyRunner/MinimalFailureDeletion.lean` | `2c9b11be2996fec5ef56278d6df0acda3723669a30f4003be374300d4a10342c` |
| `research/astra-minimal-failure-deletion-root-verification.json` | `fc536be37b38e9d3ad8b981af15936a95085c2a404416ed0faf0e0c4631df669` |
| `research/astra-deletion-helper-root-verification.json` | `c414bc30cee35beaf5d16a09e329783a46fdc0542b28b0da0c573dcbfda9e04f` |
| `research/astra-minimal-failure-deletion-implementation.json` | `025f7fb7256b9ba5ff7de788641d342e21996746e06e623a823534c1b7099e2b` |
| `research/astra-minimal-failure-deletion-contract.md` | `76bdf41ee81543c9251f3f5c3236082c20a0d62afd81d854a0f44be5227ba880` |
| `research/astra-minimal-failure-deletion-contract-review.md` | `991255a339c8c0be9164422879d5ba66e6ca332beb8acd43d405677c0b4a0f6e` |
| `LonelyRunner/MinimalCounterexample.lean` | `b0c13b2212abd6bca49fe59f16b0c9d5b124e07e85226e35c14378baa1ffd539` |
| `LonelyRunner/StrictCoreContraction.lean` | `b26dbff907c02e5874dbf635fdd5f9406e7d080045238818090d6b7149c91daf` |
| `LonelyRunner/BaseCases.lean` | `31e2c328e060c077c6c9928e3fb431601326e4e54a949ee5148aed5cd3687d1f` |
| `LonelyRunner/ConstrainedMaximizer.lean` | `2ef07e6b83b8675a22184571c31d2a71dab9d5c072e3cd165cb8382957b46e92` |
| `LonelyRunner/PivotBoundary.lean` | `0e56cab74d30ef8b537ed4ec24503aae875bd8aadc369d26da99ba882cc3603f` |
| `LonelyRunner/FastRunnerInsertion.lean` | `dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5` |
| `research/astra-minimal-counterexample-final-review.md` | `ea2ecd4b04cf2f5db060be84087619bdc9b6712ed2c8fd508bbe48fdc1a7ddbf` |
| `research/astra-strict-core-final-review.md` | `1fcb97cf90eeacc4d4d5765d1310e255fb146efa4f7e2fd01827a3aac3b62834` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |
| `lean-toolchain` | `8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af` |
| `lakefile.toml` | `bdcbaaa18d518409619215e8acf7892452c1fa5c6e80ba742ce67f7380682a26` |
| `lake-manifest.json` | `887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218` |
