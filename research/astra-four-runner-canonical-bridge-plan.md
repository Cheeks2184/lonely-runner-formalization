# Bounded bridges from the pending four-runner mixed classification

Assigned base: `7e1b4073cfd0095a3e514df975313562feb82688`.
Only this plan is owned. Current project configuration, workflow, policy, and
active state were read; `python3 -B scripts/validate_workflow.py` passed.
Other workers remain active. No Lean, shared-state, Git, or cache edit is
authorized by this planning task. The unrestricted canonical goal is unresolved.

**Recommendation:** the three downstream bridges are sound and useful, once
the pending classification is completed, built, and independently accepted.
The real-speed bridge needs one small topological extraction plus a bounded
wrapper. It does not require an all-dimensional conjecture premise or a new
deduplication implementation. This derivation is saved before final provenance
checks, which have now passed; it is a plan, not a report that these new
declarations exist.

## Pending premise and exact count scope

Write `C4` only as a manuscript abbreviation for the pending proposition

```lean
∀ (a b H : ℕ), 0 < a → a < b → b < H →
  (FourRunnerMixed a b H ↔ ¬ (b = 2 * a ∧ H = 3 * a))
```

The inspected working definition of `FourRunnerMixed` is precisely a single
`t>0` with the `a,b` norms at least `1/4` and the `H` norm at least `1/3`.
It is not assumed frozen or fully verified here. Every unconditional natural
count-four or `H5` signature proposed below is conditional on later discharging
`C4`; an intermediate implementation can instead retain `hC4 : C4` explicitly.
The eventual public names may follow the implementer's naming convention.

`LowerCountPositiveIntegerHypothesis 5` covers exactly one, two, or three
distinct positive natural moving speeds, at their own margins `1/2,1/3,1/4`.
It does not assert the five-total-runner theorem, which has four moving speeds.

## 1. Sorted and unordered ordinary natural triples

Proposed sorted helper, after `C4` is available:

```lean
theorem threeMovingNaturalSpeeds (a b H : ℕ)
    (ha : 0 < a) (hab : a < b) (hbH : b < H) :
    ∃ t : ℝ, 0 < t ∧
      (4 : ℝ)⁻¹ ≤ circleNorm (t * (a : ℝ)) ∧
      (4 : ℝ)⁻¹ ≤ circleNorm (t * (b : ℝ)) ∧
      (4 : ℝ)⁻¹ ≤ circleNorm (t * (H : ℝ))
```

Split on `b=2*a ∧ H=3*a`. Off the exception, use the reverse direction of
`C4`, retain its positive time, and weaken only the fastest bound using
`1/4<=1/3`. On the exception, set `t=(4*(a:ℝ))⁻¹>0`. The phases are exactly
`1/4,1/2,3/4`. `circleNorm_eq_abs_of_abs_le_half` handles the first two;
`circleNorm_add_int 1 (-1/4)` and `circleNorm_neg` give the third norm `1/4`.
This uses positivity of `a`; no gcd normalization, high-height premise, or
classification of real triples is needed.

The desired unordered interface is then

```lean
theorem threeMovingNaturalRunners (speeds : Fin 3 → ℕ)
    (hinj : Function.Injective speeds) (hpos : ∀ i, 0 < speeds i) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (4 : ℝ)⁻¹ ≤ circleNorm (t * (speeds i : ℝ))
```

Call `exists_strictMono_reindex speeds hinj` from `FiniteTupleSorting`.
Its equivalence points from sorted positions back to original labels.
Apply the sorted helper to `speeds(e 0),speeds(e 1),speeds(e 2)` and transport
the three bounds to each original `i` through `e.symm i`. `fin_cases` on the
sorted index suffices. Do not transport the mixed designation to an arbitrary
original label: the ordinary theorem needs only the common quarter margin.

## 2. Bounded supply H5

```lean
theorem lowerCountPositiveIntegerHypothesis_five :
    LowerCountPositiveIntegerHypothesis 5
```

Unfold the definition and derive `1<=d<=3`. For `d=1`, use `oneMovingRunner`
on the positive natural speed cast to real; `Fin.eq_zero` handles the single
coordinate. For `d=2`, use `twoMovingRunners`, whose actual interface accepts
arbitrary nonzero real speeds, including equal magnitudes. For `d=3`, use
`threeMovingNaturalRunners` and discard the extra positivity field of its
witness. All three conclusions have their own exact `1/(d+1)` margin.

The pending `FourRunnerMixed.lean` currently includes an `H4` theorem built
from the same first two cases. Once accepted, it can shorten this proof for
`d<=2`. The plan does not treat that working file as established source.

## 3. Minimal bounded real-speed bridge

The public `BHKRealReduction` interface really is global:
`positiveRationalConjecture_implies_positiveRealWitness` assumes
`PositiveRationalConjecture`, and the conjecture-equivalence wrappers retain
that all-dimensional quantifier. A fixed count-three natural theorem cannot
be supplied to any of those global premises. No such wrapper should be used
to hide the missing higher-dimensional hypotheses.

There is a smaller additive route using existing fixed-tuple interfaces.

### 3a. Extract only the strict topological transfer

Proposed general helper (all sums use the finite index set):

```lean
theorem exists_stationaryStrictWitness_of_relations {m : ℕ}
    (u z : Fin m → ℝ) (δ τ : ℝ)
    (hrelations : ∀ a : Fin m → ℤ,
      (∑ i, (a i : ℝ) * u i = 0) →
        ∑ i, (a i : ℝ) * z i = 0)
    (hstrict : ∀ i, δ < circleNorm (τ * z i)) :
    ∃ t : ℝ, ∀ i, δ < circleNorm (t * u i)
```

This is the final open-set argument already present in
`exists_stationaryWitness_of_rational_collision`, after it establishes a
strict target. Let `good={x : UnitAddTorus (Fin m) | ∀i, δ<‖x i‖}`.
Finite intersection and coordinate norm continuity make it open. The existing
`orbitHom_mem_closure_range_of_relations u z τ hrelations` places the target
in the orbit closure. `mem_closure_iff` applied to `good` gives an actual orbit
point in `good`, hence the same `t` for every coordinate. No rationality,
positivity, injectivity, or count-supply assumption is needed for this helper.
Its conclusion is strict; project to closed bounds only at the caller.

Add the helper in `BHKCollisionToWitness.lean` and optionally replace that
file's existing final block by a call to it, preserving the old theorem type.
No new Kronecker or BHK finite-algebra argument is required.

### 3b. Reuse the existing bounded rational lemma in both branches

Proposed bounded positive-real interface:

```lean
theorem positiveRealWitness_of_lowerCount {m : ℕ} (hm : 1 ≤ m)
    (hLower : LowerCountPositiveIntegerHypothesis (m + 2))
    (u : Fin m → ℝ) (hu : ∀ i, 0 < u i) :
    ∃ t : ℝ, ∀ i,
      (((m + 1 : ℕ) : ℝ)⁻¹) ≤ circleNorm (t * u i)
```

The count-local assumption includes only distinct natural tuples of sizes
`1,...,m`. Follow the irrational/rational split in `BHKRealReduction`:

* If some `u p/u q` is irrational, the existing
  `exists_bhk_collisionWitness_of_irrational` gives a nowhere-zero rational
  `w`, real relation compatibility in exactly the required direction, and
  `card(image |w|)<m`. It imposes no injectivity on `u`. The same branch proves
  `m>=2` because an irrational self-ratio is impossible.
  Restrict `hLower` to `H_(m+1)` by decreasing its cardinality bound. Apply
  `exists_lowerCount_rational_collision` with `N=m+1`: the actual magnitude
  count is at most `m-1`, so it gives one `τ` with all `w` norms at least
  `1/m`. Since `1/(m+1)<1/m`, use 3a with `z=(fun i => (w i : ℝ))` and
  `δ=1/(m+1)`, then weaken strict to closed.
* Otherwise choose a positive rational tuple `q_i=u_i/u_first`, as the current
  real reduction does using `exists_rat_of_not_irrational`. Repetitions in
  this tuple are permitted. Apply `exists_lowerCount_rational_collision`
  with `N=m+2`, original row length `m`, and `w=q`. Its hypotheses require
  only nonzero coordinates and `card(image |q|)<=m`, not a strict collision.
  That cardinality inequality is automatic from `Finset.card_image_le`.
  The existing lemma deduplicates internally, clears denominators, uses the
  actual smaller count from `hLower`, and returns the requested `1/(m+1)`
  margin to every original coordinate. Rescale the resulting time by
  `1/u_first`; positivity makes `u_first` nonzero, and the phase identity is
  `(τ/u_first)*u_i=τ*q_i` exactly.

Despite its name, `exists_lowerCount_rational_collision` has no hypothesis
asserting two coordinates collide. The weak cardinality bound in its actual
type is sufficient in the rational branch. This avoids extracting a separate
repeated-positive-rational conjecture, duplicating denominator clearing, or
reimplementing finite deduplication.

For `m=3`, the irrational branch uses `H4`, actual magnitude count at most two,
and target margin `1/3>1/4`; the rational branch uses `H5`, actual magnitude
count at most three, and closed margin `1/4`. Using `H5` at its default
`1/4` collision margin in the irrational branch would lose the strict slack
needed for the open-set transfer. The explicit `N=m+1` call prevents that bug.

### 3c. Signs, labels, and the canonical count-four declaration

First add the sign-normalized bounded wrapper:

```lean
theorem stationaryWitness_of_lowerCount {m : ℕ} (hm : 1 ≤ m)
    (hLower : LowerCountPositiveIntegerHypothesis (m + 2))
    (v : Fin m → ℝ) (hv : ∀ i, v i ≠ 0) :
    ∃ t : ℝ, ∀ i,
      (((m + 1 : ℕ) : ℝ)⁻¹) ≤ circleNorm (t * v i)
```

Use 3b on `|v_i|` and rewrite with `circleNorm_mul_abs_right`. Absolute values
can coincide even for distinct signed relative speeds; this is why 3b must
allow repeats. For example the chosen runner of speed one in `(0,1,2,3)` has
relative magnitudes `(1,1,2)`. No count is silently reduced without adjusting
the supplied margin; the existing rational lemma handles all occurrences.

The exact canonical specialization can then be stated either conditionally
before H5 is discharged or unconditionally afterward:

```lean
theorem fourRunners_of_lowerCount
    (hLower : LowerCountPositiveIntegerHypothesis 5)
    (speeds : Fin 4 → ℝ) (hinj : Function.Injective speeds)
    (runner : Fin 4) : ∃ t : ℝ, LonelyAt speeds runner t

theorem fourRunners (speeds : Fin 4 → ℝ)
    (hinj : Function.Injective speeds) (runner : Fin 4) :
    ∃ t : ℝ, LonelyAt speeds runner t
```

Set `v_i=speeds(runner.succAbove i)-speeds runner` on `Fin 3`.
`relative_succAbove_ne_zero hinj runner` supplies nonzero relative speeds.
Apply `stationaryWitness_of_lowerCount` at `m=3`, then enumerate any other
label using `Fin.exists_succAbove_eq`. Finally use
`lonelyAt_iff_relativeLonelyAt` to recover the actual quotient-circle distance
and original label. Relative injectivity is available in
`injective_relative_succAbove`, but this proof no longer needs it.

All real original speeds, arbitrary signs, arbitrary translations, arbitrary
chosen runners, and closed quarter boundaries are included. The time domain
matches the canonical definition exactly: all real times. If positive time is
desired separately, any such witness is nonzero (evaluate one other runner
at time zero); reflect a negative witness with `lonelyAt_neg_time`. This small
optional strengthening is not needed for the literal canonical specialization.

No fixed five-total-runner result follows. Such a real tuple has four moving
coordinates. The bounded wrapper would require `H6`, including a four-moving
natural witness that the pending three-moving classification does not supply.

## Work packaging and acceptance scope

Suggested additive files: `FourRunnerOrdinary.lean` for steps 1–2,
`BoundedRealReduction.lean` for 3b–3c's generic sign wrapper, and
`FourRunnerCanonical.lean` for the count-four labelled specialization. The
strict-transfer helper belongs alongside its existing body in
`BHKCollisionToWitness.lean`. Import direction should keep `LowerCountSupply`
independent of `FourRunnerMixed`; do not introduce a cycle through affine
height arguments. Global reduction and finite-family theorem types stay intact.
In particular, the bounded module imports `LowerCountSupply`,
`BHKPositiveCollision`, and `BHKCollisionToWitness`; it does not import the
four-runner classification. The canonical module imports that bounded module,
`FourRunnerOrdinary`, and `StationaryEquivalence`.

Steps 1–2 are small settled implementation tasks. Step 3a is a direct extraction
of roughly the final 30 lines of an existing proof; 3b follows roughly the
existing 60-line real reduction with two bounded supply calls; sign and label
wrappers are short. Generic count arithmetic and the `Fin` reindexing are the
main elaboration work, not new mathematical obligations. These are rough
source-size descriptions, not completion-time promises.

This is useful supporting work: it turns the pending classification into an
ordinary count-four API, an exact H5 input for later conditional arguments,
and a genuine canonical real count-four theorem. It does not advance the
unrestricted count bound by itself. Root should first accept the pending
classification, then assign these additive bridges. Required implementation
checks are focused/full source builds, standard-axiom probes for the final
unconditional declarations, and preservation of existing global public types.
No proof, build, or axiom result for these proposed declarations is claimed here.

The semantic acceptance cases should include the scaled natural exception,
an unsorted natural triple, signed repeated magnitudes, and a nonstationary
chosen label. They need no additional numerical search. The real theorem
asserts the canonical ordinary quarter bound; no fastest-third bound for
arbitrary real tuples is promoted through the closure argument.

## Stable source provenance and performed checks

The following 15 inspected interface files were independently compared
byte-for-byte with the assigned base using read-only `git show`; all matched.
The in-progress `FourRunnerMixed.lean` was read only to confirm its definition
and observe pending work. It is deliberately not a frozen dependency of this
plan, and no not-yet-existing classification declaration was probed or imported.

```text
5f0258a6ab99950fc7045b2200d6708fe7603d3caa4d62855ef2b19a330c95aa  LonelyRunner/Definitions.lean
0c3328e975bee236ff66862d3a5cadeb58fbc7c804fa953e53701ba466b9d788  LonelyRunner/Formulations.lean
31e2c328e060c077c6c9928e3fb431601326e4e54a949ee5148aed5cd3687d1f  LonelyRunner/BaseCases.lean
e4933da3551792130eebf1ede4701bff3296f59eb696dfb7b6276e16d940d699  LonelyRunner/SmallDimensions.lean
71b47c20282d091129fe9990b2d1bbdfdebff45e49dea2bfbd7d4425fe89f775  LonelyRunner/FiniteTupleSorting.lean
0705291adc53011fb72fc718a7260876512b092741442d6a6cceb4b76eb5ccf4  LonelyRunner/LowerCountSupply.lean
c707227a24eb53d06b20ff00e2e86ce52c158ba7eed55c1d8eba32cf9c457a4e  LonelyRunner/RationalReduction.lean
20193ad984f308ce8512930fe683d3118a2b3b5c18636a6a1f4454aa6df43797  LonelyRunner/Normalization.lean
12dce8930c34b211bc01e2dc21e932087270726bce2bf127fa2d8d6594544b49  LonelyRunner/StationaryEquivalence.lean
98d7c878eef7e4a3b7f7c504c882cf35191c1343816a59d731193ac8a207ed26  LonelyRunner/BHKRealReduction.lean
7569f6798bc42be6ffd5ae04e0f8110f386f941aa58f02a2f168d597a17a514e  LonelyRunner/BHKPositiveCollision.lean
42e7665af7981ef336ab4e1826ff3f096e6d6855b50440f76e2ede7a538f7f87  LonelyRunner/BHKCollisionToWitness.lean
50e0ff4babbe451598f84ada0907180bb17b0a8f8ae5aa84d7cb923d227c4198  LonelyRunner/KroneckerSeparation.lean
dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5  LonelyRunner/FastRunnerInsertion.lean
5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c  LonelyRunner/StructuredClasses.lean
```

The small source-provenance replay is the sole Python block below. Run it
with `python3 -B` from the repository root; it has no filesystem writes.

```python
from pathlib import Path
from hashlib import sha256
import re, subprocess
base = '7e1b4073cfd0095a3e514df975313562feb82688'
p = Path('research/astra-four-runner-canonical-bridge-plan.md')
guards = re.findall(r'^([a-f0-9]{64})  (LonelyRunner/[^\n]+\.lean)$', p.read_text(), re.M)
assert len(guards) == 15
for expected, path in guards:
    current = Path(path).read_bytes()
    assert sha256(current).hexdigest() == expected, path
    assert current == subprocess.check_output(['git','show',base+':'+path]), path
print('PASS: 15 stable interface hashes and assigned-base byte comparisons')
```

The replay exited zero with exactly the printed PASS line. SHA-256 of the
sole Python block, including its final newline, is
`6e5ecddab2f0bfe3781ac219d8300726eb5daf3dd90ffb0d67167751561efd92`;
SHA-256 of its stdout, including the final newline, is
`56b4f981f84181586e284f41628874900bf74a8178ca2bac34f4e2327ae21aa8`.

The other performed checks were source/interface reads and workflow structural
validation. Exploratory reads using guessed `Defs.lean`, `TimeWitness*`, and
`CircleNorm*` paths found no such files; the actual definitions and norm lemmas
were then read from the paths recorded above. No mathematical computation,
external retrieval, Lean command, build, source mutation, or cache operation
was run. Only this plan was written. Its raw hash and the replay hashes are
reported at handoff. All planning commands are stopped before handoff.
