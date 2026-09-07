# Minimal positive-integer failure: kernel contract and proof plan

Task `/root/minimal_failure_kernel_contract`; assignment checkpoint
`598f969732186d9ee39641d343d5e79ddeb1eb77`. Requested route: Astra/xhigh.
Observed model, effort, elapsed time and usage: null. Only this manuscript
is owned. This is a source-checked mathematical contract, not Lean code,
an elaborated declaration, or an independently accepted new proof.

The requested normal form follows by two natural-number minima and direct
gcd division. Minimize the sum among ALL positive injective failures at the
least failed moving count; primitivity then follows automatically. No
sorting, stationary-zero append, finite-height theorem, or conjectural
uniform mechanism is needed. A separate short analytic theorem supplies
the attained global margin assumed by the research manuscripts. Neither
the conditional normal form nor its implementation would resolve LRC.

## Exact proposed public contract

Use one proposed module `LonelyRunner/MinimalCounterexample.lean`, inside
`namespace LonelyRunner`, with `open scoped BigOperators`. The following
are proposed declaration signatures, not files created or compiled here.

```lean
def PositiveIntegerFailure {n : ℕ} (v : Fin n → ℕ) : Prop :=
  ∀ t : ℝ, ∃ i : Fin n,
    circleNorm (t * (v i : ℝ)) < (((n + 1 : ℕ) : ℝ)⁻¹)

structure MinimalPositiveIntegerFailure {n : ℕ}
    (v : Fin n → ℕ) : Prop where
  count_pos : 1 ≤ n
  positive : ∀ i, 0 < v i
  injective : Function.Injective v
  failure : PositiveIntegerFailure v
  previous_counts : ∀ d : ℕ, 1 ≤ d → d < n → PositiveIntegerAtCount d
  sum_minimal : ∀ w : Fin n → ℕ,
    Function.Injective w → (∀ i, 0 < w i) →
    PositiveIntegerFailure w →
    (∑ i : Fin n, v i) ≤ (∑ i : Fin n, w i)
  primitive : Finset.univ.gcd v = 1

theorem exists_minimalPositiveIntegerFailure
    (hnot : ¬ Conjecture) :
    ∃ (n : ℕ) (v : Fin n → ℕ), MinimalPositiveIntegerFailure v

theorem MinimalPositiveIntegerFailure.witness_of_sum_lt
    {n : ℕ} {v : Fin n → ℕ} (hv : MinimalPositiveIntegerFailure v)
    (w : Fin n → ℕ) (hinj : Function.Injective w)
    (hpos : ∀ i, 0 < w i)
    (hlt : (∑ i : Fin n, w i) < (∑ i : Fin n, v i)) :
    ∃ t : ℝ, ∀ i : Fin n,
      (((n + 1 : ℕ) : ℝ)⁻¹) ≤ circleNorm (t * (w i : ℝ))
```

The count is the number of moving speeds; total count is `N=n+1`.
Every threshold casts the natural total count before taking its real
inverse. The competitor `w` has the SAME `Fin n` domain; it need not be
primitive, sorted, or obtained by changing one coordinate. The direction
of minimality is `sum v ≤ sum w`, including equal-sum competitors.
The last theorem is its closed-witness contrapositive, not a stronger
claim about noninjective competitors.

Two small helper contracts make the logic and scaling explicit:

```lean
theorem positiveIntegerFailure_iff_no_witness
    {n : ℕ} (v : Fin n → ℕ) :
    PositiveIntegerFailure v ↔
      ¬ ∃ t : ℝ, ∀ i : Fin n,
        (((n + 1 : ℕ) : ℝ)⁻¹) ≤ circleNorm (t * (v i : ℝ))

theorem positiveIntegerFailure_factor_iff
    {n : ℕ} (v w : Fin n → ℕ) (g : ℕ) (hg : 0 < g)
    (hfactor : ∀ i, v i = g * w i) :
    PositiveIntegerFailure v ↔ PositiveIntegerFailure w
```

These helpers need neither positivity nor injectivity of the tuples.
Classical quantifier negation gives the first equivalence, using
`¬ alpha ≤ x ↔ x < alpha`. All times remain real. In the second, evaluate
failure of `v` at `t/(g:ℝ)` to get failure of `w` at `t`; evaluate failure
of `w` at `(g:ℝ)*t` for the reverse implication. In both directions the
phases agree exactly, not only modulo one. No change of threshold occurs.

## Selection and primitivity: complete mathematical proof

**First minimum.** The source equivalence
`conjecture_iff_positiveIntegerConjecture` turns `hnot` into
`¬ PositiveIntegerConjecture`. Unfolding that definition and the existing
`PositiveIntegerAtCount` produces an inhabitant of

    ∃ d : ℕ, 1 ≤ d ∧ ¬ PositiveIntegerAtCount d.

Choose `n` as the least such natural number using `Nat.find`. Its
specification yields `1≤n` and failure of the count statement. For
`1≤d<n`, a failure of `PositiveIntegerAtCount d` would satisfy the same
predicate below its minimum; therefore that count statement holds.
The supplied lower-count margin is `1/(d+1)`, not `1/(n+1)` and not a
statement at arbitrary shifted phases.

**Second minimum.** Negating the failed count statement gives some
`v : Fin n → ℕ` with injectivity, positivity and no closed witness.
Use the first helper to express this as `PositiveIntegerFailure v`.
Consider the inhabited predicate on natural numbers

    Q(s) := ∃ w : Fin n → ℕ,
      Function.Injective w ∧ (∀ i, 0 < w i) ∧
      PositiveIntegerFailure w ∧ (∑ i, w i) = s.

Let `s0=Nat.find (exists s, Q(s))` and select a realizing tuple. Every
positive injective same-count failing competitor has sum at least `s0`,
because otherwise it witnesses `Q` below its minimum. Rewriting the
chosen sum as `s0` gives precisely `sum_minimal` above. Both minima range
over natural numbers, not an implicitly well-ordered family of functions.
Only existence and classical choice are required; this is not an algorithm
for deciding failure or searching tuples. `Nat.find_spec` and `Nat.find_min`
are the expected standard well-order APIs; their installed mathlib source
and elaboration are unavailable in this pass. The proof needs exactly
their existence/specification/no-smaller-instance properties.

**Automatic primitivity.** This argument uses the selected tuple but does
not yet assume the proposed structure's `primitive` field. Choose
`anchor=⟨0, count_pos⟩ : Fin n` with the bound converted to `0<n`.
Put

    g=Finset.univ.gcd v,       w i=v i/g.

`Finset.gcd_dvd` gives `g ∣ v i`. Positivity at the anchor and
`Finset.gcd_ne_zero_iff` give `0<g`. Exact natural division yields

    v i = g * w i.                                           (1)

Each `w i` is positive: a positive multiple `v i` of positive `g` has
positive quotient. In the existing source this is
`Nat.div_pos (Nat.le_of_dvd (positive i) (hgdvd i)) hgpos`.
If `w i=w j`, (1) gives `v i=v j`, and original injectivity gives `i=j`.
Thus division preserves every label, positivity, distinctness, and count.

If `g>1`, then `0<w i` implies `w i<g*w i=v i` at EVERY coordinate.
The nonempty finite sum is strictly smaller: `sum w<sum v`.
The scaling helper makes `w` a failure at the SAME native threshold,
contradicting `sum_minimal`. Since `g>0`, it follows that `g=1`.

The quotient's own gcd need not be computed for this contradiction.
`Finset.gcd_div_eq_one` is available in the analogous normalization source,
but invoking it here is optional and unnecessary. In particular the proof
does not weaken minimization to primitive competitors and then silently
apply it to an unverified quotient. There is no circular use of the
structure's final `primitive` field: build that field only after this proof.

Finally, `witness_of_sum_lt` follows because failure of a smaller-sum
admissible `w` contradicts `sum_minimal`; negate the first helper again.
For a fresh positive one-coordinate replacement below the old speed,
the unchanged index type and strict sum decrease make this corollary
applicable once injectivity is proved. A duplicated retained speed does
NOT meet this corollary's injectivity premise; deletion/lower-count
reindexing must handle that case separately. No duplicate exception is
hidden in the public statement.

## Attained global margin: a tightly coupled analytic addition

The following separate public theorem is mathematically settled and small
enough to include after the selection theorem in the same implementation
unit. It needs no minimum-count, minimum-sum, injectivity or primitivity
assumption. The anchor supplies the only nonemptiness requirement.

```lean
theorem exists_attained_strict_failure_margin
    {n : ℕ} (v : Fin n → ℕ) (anchor : Fin n)
    (hpos : ∀ i, 0 < v i) (hfail : PositiveIntegerFailure v) :
    ∃ (mu tau : ℝ), tau ∈ Set.Icc (0 : ℝ) 1 ∧
      0 < mu ∧ mu < (((n + 1 : ℕ) : ℝ)⁻¹) ∧
      minimumCircleNorm (fun i => (v i : ℝ)) anchor tau = mu ∧
      ∀ t : ℝ,
        minimumCircleNorm (fun i => (v i : ℝ)) anchor t ≤ mu
```

Here `mu` is the ACTUAL global maximum, certified by an attained value
and a bound at every real time. It is not an arbitrary upper bound,
an unattained supremum, or the maximum of one distinguished coordinate.
Use the following proof, with `F(t)` the displayed `minimumCircleNorm`.

1. Put `S=∑ i, v i`. By positivity and the anchor, `S>0`; also
   `1≤v i≤S` for every coordinate. Set `t0=1/(2*(S:ℝ))`. Then
   `0<t0≤1/2` and `t0≤t0*(v i:ℝ)≤1/2`. The existing half-interval
   norm lemma gives `circleNorm(t0*v i)=t0*v i≥t0`.
   Therefore `F(t0)≥t0>0` by `le_minimumCircleNorm`, with `t0∈[0,1]`.
   This explicit finite-family time is not an LRC lower bound at native
   margin; its denominator is twice the SUM OF SPEEDS.
2. `continuous_minimumCircleNorm` and `isCompact_Icc.exists_isMaxOn`
   give an attainer `tau∈[0,1]`; take `mu=F(tau)`. The interval is
   nonempty, for example because it contains zero. Step 1 gives `mu>0`.
3. For arbitrary real `t`, `Int.fract t∈[0,1]` and the existing
   `circleNorm_fract_mul_nat` identifies every coordinate norm at those
   two times. Hence `F(Int.fract t)=F(t)` by finite-minimum congruence,
   and the compact maximum bounds `F(t)` globally. A private helper for
   this equality is enough; no quotient-circle maximum infrastructure
   or new general periodicity API is required.
4. `hfail tau` supplies an actual coordinate whose norm is strictly
   below `alpha`. `minimumCircleNorm_le` gives `mu<alpha` at once.
   Taking the supremum of pointwise strict inequalities without an
   attainer would not justify this strict conclusion.

Only a short positive-time lemma and assembly of existing finite-minimum
APIs are missing. If useful during implementation, its private signature is
`∃ t : ℝ, t ∈ Set.Icc (0:ℝ) 1 ∧
  0 < minimumCircleNorm (fun i => (v i:ℝ)) anchor t`, under `hpos`.
The proof above supplies it without a new search or analytic estimate.

The exact downstream deletion predicate is already `ComplementSafe v i alpha t`.
At such a time, obtain a minimizing coordinate `j` using
`exists_eq_minimumCircleNorm`. Since its norm is at most `mu<alpha`,
it cannot be a retained label `j≠i`. Thus `j=i` and

    circleNorm (t*(v i:ℝ)) = F(t) ≤ mu.                      (2)

This identifies the full deletion-set trap needed by the research. It
does not use a separately constrained coordinate maximum, nor assert
that one deletion seed is the whole deletion set. Equation (2) can remain
a downstream lemma; importing `ConstrainedMaximizer` solely to export it
is unnecessary for the first selection-and-margin module.

## Source reuse, missing work and implementation boundary

The following line evidence was read in the bound source, including the
relevant proof bodies. The line ranges describe repository source evidence,
not imports or kernel elaboration verified in this pass.

| Source and lines | Reuse / exact limitation |
| --- | --- |
| `Definitions.lean:20-44` | Unit circle and canonical all-real, closed-boundary, labelled conjecture. |
| `Formulations.lean:47-60` | Positive distinct natural formulation at all nonempty moving counts. |
| `BHKRealReduction.lean:111-118` | Existing exact canonical-to-positive-integer equivalence, in both directions. |
| `FiniteFamilyEquivalence.lean:18-30` | Reuse `PositiveIntegerAtCount`; existing lower-count adapter requires `2≤n`. |
| `FiniteFamilyEquivalence.lean:79-109` | Count-one proof pattern and exact conversion between count statements and the all-count formulation. This is induction under a finite-family premise, NOT a minimal-counterexample theorem. |
| `PrimitiveTupleNormalization.lean:38-57` | Finite gcd, positivity, exact factorization and quotient gcd APIs. Its public theorem additionally sorts/translates a full integer tuple with a zero; that broader normalization is not invoked. |
| `TwoDivisibleNormalization.lean:30-47,75-84` | Positive natural gcd quotient and exact time `t/g` restoration. Its public theorem is fixed `Fin 5`; reuse the elementary proof pattern, not its finite-count claim. |
| `FastRunnerInsertion.lean:14-23` | `circleNorm` definition and its exact half-interval absolute-value formula. |
| `PivotBoundary.lean:24-87,166-178` | Finite minimum, continuity, upper/lower comparisons, minimizing coordinate, integer-speed fractional-part periodicity. |
| `ConstrainedMaximizer.lean:46-47,164-188` | EXACT deletion-safe predicate; compactness/globalization pattern. Its public maximizer is a distinguished-coordinate objective under complement constraints and cannot substitute for the global minimum objective. |
| `LowerCountSupply.lean:18-26` | `H_N` uses nonempty counts `d≤N-2`, at each own native margin. |
| `BaseCases.lean:15-22` | Count one has a closed antipodal witness, so a later short corollary gives `2≤n`. |
| `SixRunnerOrdinary.lean:125-136` | Existing `H_7` covers every moving count through five; a separate later adapter gives `6≤n` for any failure. This is reuse of the completed milestone, not a count ladder. |
| `WeightedConditionalExpectation.lean:29-36,54-58` | Repository usage of nonempty positive sums and strictly increasing finite sums. |
| `OverlapCapacity.lean:75-80` | Repository usage of `Finset.single_le_sum` over natural values. |

Focused searches for least-count/least-sum failure, `Nat.find`, sum/gcd
normalization and finite/global minimum declarations were followed by these
source-body reads. No reusable minimal-counterexample selection theorem
was located. This is a scoped inventory finding, not a claim of semantic
absence based solely on names. The labelled transport theorem in
`LonelyAtTransport.lean:13-56` is also valid but would force avoidable
label/relative-speed machinery; exact stationary phase algebra suffices.

Recommended direct imports are `LonelyRunner.FiniteFamilyEquivalence`,
`LonelyRunner.PivotBoundary`, `Mathlib.Algebra.GCDMonoid.Finset` and the
usual tactic import. Any explicit natural well-order import needed for
`Nat.find` must be resolved against the pinned dependencies at implementation
time. Do not import the root module or `SixRunnerOrdinary` merely to set up
the uniform normal form. A separately proved `2≤n` enables the existing
`lowerCount_of_previous_counts`; alternatively derive `H_(n+1)` directly
from the stored `previous_counts` by elementary natural arithmetic.

This is one cohesive proposed Terra/high unit: failure equivalence and
scaling; the two selections and automatic gcd-one result; smaller-sum
witness corollary; then the separate attained-margin theorem. The first
part has no topological proof obligation. The last adds only the positive
time and compact-minimum assembly just specified. No collision indices,
forced arcs, parent candidates or new geometric invariants belong in it.

Implementation is NOT authorized by this manuscript. After independent
contract review and a root-granted resource/verification slot, an implementer
should preserve all these signatures or report a precise semantic blocker;
own the focused compile/repair cycle; and return exact source hashes, full
bounded command output and axiom inspection for the new public theorems.
No `sorry`, custom axiom, computational trust shortcut, missing injectivity
premise, primitive-only minimum, changed time domain, or weak bad inequality
can replace this contract. Parent owns integration and any root/audit edits.

## Hand falsification checks and remaining status

- For `n=0`, the failure predicate is false: at time zero there is no
  coordinate to witness it. Count selection explicitly retains `1≤n`.
  The anchor used by the analytic theorem independently prevents an empty
  finite minimum.
- For a single speed `1`, time `1/2` attains the closed native margin.
  Replacing strict `<alpha` by `≤alpha` in failure would incorrectly make
  this good tuple a failure, since every circle norm is at most `1/2`.
- Scaling `(1,2)` to `(2,4)` transfers a time `1/3` for the quotient to
  `1/6` for the original. This checks the inverse direction `t/g` used
  in the contradiction; `g*t` belongs to the reverse transfer.
- No uniform gap follows just by minimizing sums. The strict global
  `mu<alpha` uses compact attainment plus the pointwise failure at the
  attainer. The positive bound uses actual speed sum and no lower-count
  conjecture.

No mathematical falsifier was found for the stated contract; the hand
derivation has no remaining mathematical lemma beyond routine well-order,
finite-sum and compactness assembly identified above. Its implementation,
kernel/trust checks and independent semantic review remain outstanding.
Even once checked, the next unresolved mathematical implication is a
contradiction from the resulting minimal failure, or an actual such failure.
This normal-form bridge by itself establishes neither and leaves the
unrestricted canonical conjecture unresolved.

## Bindings and actual checks

All paths below are repository-relative. Hashes bind the exact inspected
inputs, not a fresh compilation receipt.

| Input | SHA-256 |
| --- | --- |
| `LonelyRunner/Definitions.lean` | `5f0258a6ab99950fc7045b2200d6708fe7603d3caa4d62855ef2b19a330c95aa` |
| `LonelyRunner/Formulations.lean` | `0c3328e975bee236ff66862d3a5cadeb58fbc7c804fa953e53701ba466b9d788` |
| `LonelyRunner/BHKRealReduction.lean` | `98d7c878eef7e4a3b7f7c504c882cf35191c1343816a59d731193ac8a207ed26` |
| `LonelyRunner/FiniteFamilyEquivalence.lean` | `475a46b9e10226f3de30628e595073a9765a8c03cb0ab071bdcc10acb6446be3` |
| `LonelyRunner/PrimitiveTupleNormalization.lean` | `cac3351bf8c755c0bd354d0330e766f49c255d7ef21637d0975a8d8633cd94b0` |
| `LonelyRunner/TwoDivisibleNormalization.lean` | `d812237f06d63e67c8739122c76a5e67daa470402575ccafcdcee4c41d950286` |
| `LonelyRunner/FastRunnerInsertion.lean` | `dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5` |
| `LonelyRunner/PivotBoundary.lean` | `0e56cab74d30ef8b537ed4ec24503aae875bd8aadc369d26da99ba882cc3603f` |
| `LonelyRunner/ConstrainedMaximizer.lean` | `2ef07e6b83b8675a22184571c31d2a71dab9d5c072e3cd165cb8382957b46e92` |
| `LonelyRunner/LowerCountSupply.lean` | `0705291adc53011fb72fc718a7260876512b092741442d6a6cceb4b76eb5ccf4` |
| `LonelyRunner/BaseCases.lean` | `31e2c328e060c077c6c9928e3fb431601326e4e54a949ee5148aed5cd3687d1f` |
| `LonelyRunner/SixRunnerOrdinary.lean` | `8da5bb6f35373ab4da8d0ab8e2a1040376a74b028efdc7e00d006ee91eb25755` |
| `LonelyRunner/LonelyAtTransport.lean` | `6596481a6087174f7f7bb7d5140e339d0a571b05bc369fd3a9f0c432875ee1ee` |
| `LonelyRunner/WeightedConditionalExpectation.lean` | `72745fdfb1d779d9956b9bd0e515b1b3a971ddebe4c217db862fddffa6dcfe8b` |
| `LonelyRunner/OverlapCapacity.lean` | `2048568e30b8754b5a6d2807860105e957b8c2b353daa0ec6c72d8c895ca8ca6` |
| `lean-toolchain` | `8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af` |
| `lakefile.toml` | `bdcbaaa18d518409619215e8acf7892452c1fa5c6e80ba742ce67f7380682a26` |
| `lake-manifest.json` | `887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Current configuration, workflow, policy and focused live state were read.
Gate: `research/in_progress`, explicit start authorization
`2026-09-05T04:12:25.208107+00:00`; the live task record names only this file.
`python3 -B scripts/validate_workflow.py` exited 0 with exactly
`workflow structural validation passed; it cannot certify mathematical validity.`
`test ! -e .lake` exited 0: dependency source/build cache is absent.
Pinned versions read from source are Lean `v4.32.1` and mathlib revision
`520045ab14e26149ee970e2e617ca04b09bde5d6`.

Reads and searches were source-only. Two guessed source names,
`CircleMetric.lean` and `lakefile.lean`, were absent; focused file discovery
resolved the actual metric and configuration sources above. The read-only
installed Lean-core search did not locate `Nat.find` definitions; no
mathlib source was restored, and the expected well-order API was not
elaborated. These are lookup limits, not failed compilation diagnostics.
Final full owned readback, all bound hashes, newline/whitespace and workflow
validation are checked at handoff. No Lean file, other manuscript, shared
state, Git history, dependency/cache or memory was changed; no build,
mathematical program, solver, extra agent or external model was used.
