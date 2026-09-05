# Finite-field polynomial and pivot-count interface inventory

**Scope.** Mechanical API inventory for the accepted prime-field affine-avoidance
auxiliary lemma in `research/astra-affine-avoidance.md`, plus the existing strict
pivot-cardinality layer.  This is not a Lean proof, does not assert the
auxiliary lemma, and does not alter any formalization source.

**Pinned source.** `ec30e172d792e51ee9712a3f204336f7bee8724c`; Lean
`v4.32.1`; manifest mathlib commit
`520045ab14e26149ee970e2e617ca04b09bde5d6`.

## Restored shared cache

* Precheck: `df -h .` reported 111G free (41% used).  There was no existing
  project `.lake` cache.
* The only intended restore was
  `export PATH="$HOME/.elan/bin:$PATH"; lake exe cache get`.
  Tool session `48787`, chunks `e3316c` and `3a9081`, exited `0`; it fetched
  and decompressed all 8,639 mathlib cache artifacts.
* An exploratory `lake exe cache --help` first initialized the same manifest
  dependency and compiled the cache helper; it completed before the restore
  and created no second checkout or cache.  The pinned mathlib HEAD is
  `520045ab14e26149ee970e2e617ca04b09bde5d6`.
* Postcheck: `.lake` is 7.4G, filesystem has 103G free, and no `.ltar` files
  remain under `.lake` (count `0`).  The cache is deliberately retained while
  formalization is queued.  No source, manifest, pins, or workflow state was
  edited.

## Prime-field polynomial interfaces

All types below were mechanically checked with `lake env lean --stdin` after
the restore.

* `FiniteField.sum_pow_lt_card_sub_one` in
  `Mathlib/FieldTheory/Finite/Basic.lean:315`:

  ```lean
  (K : Type u) [Field K] [Fintype K] (i : ℕ)
    (h : i < Fintype.card K - 1) : ∑ x : K, x ^ i = 0
  ```

  For `K = ZMod p`, rewrite the cardinality with `ZMod.card p` from
  `Mathlib/Data/ZMod/Defs.lean:166`.

* `FiniteField.sum_pow_units` at
  `Mathlib/FieldTheory/Finite/Basic.lean:294`:

  ```lean
  (K : Type u) [Field K] [Fintype K] [DecidableEq K] (i : ℕ) :
    (∑ x : Kˣ, (x ^ i : K)) =
      if Fintype.card K - 1 ∣ i then -1 else 0
  ```

  This is the available top-power component.  There is no ready-made theorem
  for the sum of evaluations of a monic degree-`q - 1` univariate polynomial.
  A project lemma should expand evaluation, dispatch all lower powers with
  `sum_pow_lt_card_sub_one`, and obtain the top power from this units theorem
  after separating the zero term.  It must retain the positive-exponent fact
  needed for `0 ^ (q - 1) = 0`.

* `FiniteField.prod_univ_units_id_eq_neg_one` at
  `Mathlib/FieldTheory/Finite/Basic.lean:110`:

  ```lean
  [CommRing K] [IsDomain K] [Fintype Kˣ] :
    ∏ x : Kˣ, x = (-1 : Kˣ)
  ```

  To use the product in `K`, apply `congrArg (Units.coeHom K)` and rewrite by
  `map_prod`; `Units.coeHom_apply` identifies each mapped unit with its field
  value.  This is the exact product-of-nonzero-elements fact used in the
  affine-avoidance derivation.

* Polynomial expansion and monicity:

  ```lean
  Polynomial.eval_eq_sum_range
    (x : R) : p.eval x = ∑ i ∈ Finset.range (p.natDegree + 1),
      p.coeff i * x ^ i

  Polynomial.Monic.coeff_natDegree
    (hp : p.Monic) : p.coeff p.natDegree = 1
  ```

  These are at `Mathlib/Algebra/Polynomial/Eval/Degree.lean:63` and
  `Mathlib/Algebra/Polynomial/Degree/Defs.lean:73` respectively.  The
  coefficient split at `p - 1` is therefore an implementation obligation,
  rather than a missing library capability.

* Evaluation of a product is directly available:

  ```lean
  Polynomial.eval_mul : (p * q).eval x = p.eval x * q.eval x
  Polynomial.eval_prod (s : Finset ι) (p : ι → R[X]) (x : R) :
    eval x (∏ j ∈ s, p j) = ∏ j ∈ s, eval x (p j)
  ```

  at `Mathlib/Algebra/Polynomial/Eval/Defs.lean:612,675`.  This fits the
  product polynomial `P(X) = ∏ i, (X + C (v i / a i))` and the product step in
  the manuscript argument.

* Field/cardinality casts:

  ```lean
  ZMod.card (p : ℕ) [Fintype (ZMod p)] : Fintype.card (ZMod p) = p
  Nat.cast_card_eq_zero (R) [AddGroupWithOne R] [Fintype R] :
    (Fintype.card R : R) = 0
  FiniteField.cast_card_eq_zero : (Fintype.card K : K) = 0
  ```

  The first is at `Mathlib/Data/ZMod/Defs.lean:166`; the latter two support
  the zero-power/cardinality reductions used by the lower-power proof.

## Zero-product kernel and strict pivot interfaces

For a finite product used to encode an affine bad locus, mathlib has:

```lean
Finset.prod_eq_zero_iff :
  (∏ x ∈ s, f x = 0) ↔ ∃ a ∈ s, f a = 0
Finset.prod_ne_zero_iff :
  (∏ x ∈ s, f x ≠ 0) ↔ ∀ a ∈ s, f a ≠ 0
```

under `[CommMonoidWithZero] [Nontrivial] [NoZeroDivisors]`.  Thus the formal
zero-product kernel is propositionally equivalent to the union of coordinate
zero loci.  It does **not** supply a cardinality of that union: overlaps still
need a disjointness argument, explicit fibers, or an inequality.

The project already expresses the corresponding strict natural-residue layer:

* `pivotBadResidues N pivot other` is a filtered `pivotCandidates` set with
  strict predicate
  `cyclicResidueDistance (N * pivot) (r * other) < pivot`
  (`LonelyRunner/PivotResidues.lean:30`).  Membership and containment are
  `mem_pivotBadResidues` (line 38) and `pivotBadResidues_subset` (line 44).
* A nonmember turns into the closed geometric target inequality using
  `not_mem_pivotBadResidues_iff_circleNorm_ge`
  (`PivotResidues.lean:185`), so a finite-field lemma needs a separate exact
  bridge before it can yield a pivot certificate.
* Exact one-owner cardinality is
  `card_pivotBadResidues_exact` (`LonelyRunner/PivotCounts.lean:441`), with
  the full gcd/ceiling formula in lines 443--447.  It preserves strictness;
  no equality-boundary residue is counted bad.
* Its normalized version is the proved
  `card_pivotBadResidues_normalized` at
  `LonelyRunner/Prompt100TwoOwnerCounts.lean:37`, with conclusion
  `(pivotBadResidues N p d).card = h * normalizedBadCount N k P`.  The
  definition is at lines 7--9.  Its hypotheses explicitly include the
  factorization and coprimality premises, so they cannot be inferred from a
  finite-field slope argument.
* The existing exact overlap expansion is target-fiber based, not a
  zero-product-kernel cardinality: `biUnion_pivotTargetFiber_eq_pivotBadResidues`
  (`LonelyRunner/PivotPairFiberCounts.lean:45`) and
  `card_pivotTargetFiber_inter_pivotBadResidues_exact` (line 438).  The latter
  is a sum of `exactCandidateSimultaneousCongruenceCount` terms.  It is the
  relevant project API if later work needs pair overlaps after an arithmetic
  bridge.

`Finset.card_biUnion_le` gives only the usual union upper bound; the project
wrapper `LonelyRunner.card_biUnion_le_sum_card` and its avoidance corollary
are in `LonelyRunner/ModularCertificates.lean:20,33`.  No current declaration
identifies a polynomial zero-product kernel with a cardinality equal to one of
these strict pivot bad-residue sets.

## Recommended first implementation boundary

Create a dedicated finite-field module for the exact accepted affine lemma.
First prove a reusable monic degree-`q - 1` evaluation-sum lemma from the APIs
above, then encode `P`, its zero set, and the good-set cardinal argument.
Keep the result independent of `pivotBadResidues`; add any integer/grid or
strict-residue bridge only after its exact hypotheses have been stated and
reviewed.  This avoids silently treating the proposed finite-field condition
as an already available LRC pivot-count theorem.

## Implemented checked support (2026-09-05)

`LonelyRunner/AffineAvoidance.lean` now contains two private, compiled support
lemmas: `zmod_sum_pow_card_sub_one` and
`sum_eval_monic_degree_card_sub_one`.  The first performs the zero/unit split
and invokes `FiniteField.sum_pow_units`; the second expands a monic polynomial
with `Polynomial.eval_eq_sum_range` and eliminates lower powers using
`FiniteField.sum_pow_lt_card_sub_one`.  Targeted verification command:

```bash
export PATH="$HOME/.elan/bin:$PATH"
lake env lean LonelyRunner/AffineAvoidance.lean
```

This passed after cache restoration.  The public affine-avoidance theorem and
its good-set/cardinality argument remain to be formalized; these helpers do
not claim that result.
