# Concrete real-phase bridge for the frozen Renault 5.1 certificate

2026-09-06. Manuscript implementation contract, not a Lean implementation or
new computation. Requested route: Astra/xhigh; runtime model/effort are not
independently attested. Task `/root/renault_phase_concrete_bridge_plan`, assigned
to `/root/seven_adic_expanded_falsifier`, at recorded checkpoint
`a39edc784be728b127aac6387277205136407c01`. Only this report is owned. Root
owns workflow state and other workers own their sources.

**The real bridge reduces to two generic band lemmas, one finite-cut coverage
lemma, and integer periodicity.** The finite checker need only establish the
given mask's true-bit implications. Exact false-bit semantics, reconstruction
of the cut-grid union, and proof of class minimality are unnecessary for this
implication. The existing `phase_certificate_sound` contract can remain intact.

The accepted certificate has 120 atoms, 98 distinct masks, 41 retained masks,
and 12,341 supplied sorted triple witnesses over 23 candidate bits. Those are
previously checked finite facts, not a new run in this task. The new core-mask
source was read as a concurrent, unfrozen source snapshot; its build and full
finite checks are root's separate task. This report does not assert those
checks have completed, or assert a concrete Lean Renault phase theorem.

## 1. Exact interface and candidate order

For each `k : Fin 23`, use the following proposed definitions. These and all
declaration signatures below are specifications, unelaborated in this task;
they are not excerpts of new checked declarations.

```lean
def phaseSlope (k : Fin 23) : ℕ :=
  if k.val < 20 then 2 + k.val / 5 else 1

def phaseShift (k : Fin 23) : ℕ :=
  if k.val < 20 then 1 + k.val % 5
  else if k.val = 20 then 1 else if k.val = 21 then 2 else 4

def phaseBits (M : ℕ) : Finset (Fin 23) :=
  Finset.univ.filter (fun k => M.testBit k.val = true)
```

Thus bits 0–19 mean closed safety for `a = 2 + k / 5`, `b = 1 + k % 5`;
bits 20,21,22 mean strict safety for `(a,b) = (1,1),(1,2),(1,4)`.
The existing `PhaseGood` is exactly

```lean
if k.val < 20 then
  (1 : ℝ) / 6 ≤ circleNorm
    ((phaseSlope k : ℝ) * x + (phaseShift k : ℝ) / 6)
else
  (1 : ℝ) / 6 < circleNorm
    ((phaseSlope k : ℝ) * x + (phaseShift k : ℝ) / 6)
```

Prove this rewriting identity by splitting on `k.val < 20`, with `1 * x = x`
in the second branch. Also prove `0 < phaseSlope k` symbolically. There is no
need to split into 23 real arithmetic cases. The literal candidate order must
agree with the frozen JSON and the core-mask bit positions.

The existing `phase_certificate_sound` takes `AtomMem`, a `Finset (Fin 23)`
mask for each atom, core representatives `core : Fin m → Fin 120`, a dominator
map `dom : Fin 120 → Fin m`, and four hypotheses:

1. Every `x ∈ [0,1)` belongs to some atom.
2. Every true atom-mask bit implies `PhaseGood` at every point of that atom.
3. `mask (core (dom a)) ⊆ mask a` for each atom `a`.
4. Every sorted core triple, including repeated indices, has a common bit.

It supplies one common candidate for any three phases in `[0,1)`. Coverage is
all it requires from the partition; neither uniqueness nor disjointness is
an additional hidden premise. The adapters below establish exactly these
four hypotheses with `m = 41`, then remove phase normalization.

## 2. Reusable strict band and affine interval lemmas

`StructuredClasses.lean` already proves

```lean
circleNorm_ge_of_int_band (q : ℤ) (x δ : ℝ)
  (hδ0 : 0 ≤ δ) (hδhalf : δ ≤ (1 : ℝ) / 2)
  (hlower : (q : ℝ) + δ ≤ x)
  (hupper : x ≤ (q : ℝ) + 1 - δ) :
  δ ≤ circleNorm x
```

Use it to establish this strict companion:

```lean
theorem circleNorm_gt_of_int_band (q : ℤ) (y δ : ℝ)
    (hδ0 : 0 ≤ δ)
    (hlower : (q : ℝ) + δ < y)
    (hupper : y < (q : ℝ) + 1 - δ) :
    δ < circleNorm y
```

Complete derivation: let `ε = min (y - q) (q + 1 - y)`. Both arguments
exceed `δ`, so `δ < ε` and `0 ≤ ε`. Since `ε` is at most either argument,
`2 * ε ≤ (y - q) + (q + 1 - y) = 1`, hence `ε ≤ 1/2`. The same two
inequalities give `q + ε ≤ y ≤ q + 1 - ε`. Apply the existing closed-band
lemma at margin `ε` and compose `δ < ε ≤ circleNorm y`. This handles negative
`q` or `y`. No separately assumed `δ < 1/2` is needed: the strict band already
forces it. No continuity argument or limit passage can substitute for this
strict conclusion.

The required affine lemma is then:

```lean
theorem circleNorm_gt_of_affine_open_band
    (q : ℤ) (A B L U x δ : ℝ)
    (hA : 0 < A) (hδ0 : 0 ≤ δ)
    (hlower : (q : ℝ) + δ ≤ A * L + B)
    (hupper : A * U + B ≤ (q : ℝ) + 1 - δ)
    (hxL : L < x) (hxU : x < U) :
    δ < circleNorm (A * x + B)
```

Indeed `A * L + B < A * x + B < A * U + B`, by `A > 0`. Compose with
the two endpoint bounds and apply the strict-band lemma. The positivity of
`A` is essential: the same non-strict endpoint certificates would not force
a strict interior inequality for a constant affine function. The proposed
signature retains it. An inconsistent or empty interval causes no issue;
membership supplies both strict comparisons needed by the argument.

For the certificate, instantiate `δ = 1/6`, `A = phaseSlope k`,
`B = phaseShift k / 6`, and the natural quotient cast to an integer. This
proves strict safety on every good open atom, which can be weakened to closed
safety for bits 0–19. The singleton argument below preserves the distinction.

## 3. Generic finite-cut coverage without real case enumeration

A convenient reusable natural-indexed atom definition is:

```lean
def CutAtomMem (C : ℕ → ℕ) (D a : ℕ) (x : ℝ) : Prop :=
  if a % 2 = 0 then
    x = (C (a / 2) : ℝ) / (D : ℝ)
  else
    (C (a / 2) : ℝ) / (D : ℝ) < x ∧
      x < (C (a / 2 + 1) : ℝ) / (D : ℝ)

theorem exists_adjacent_cut_interval
    (C : ℕ → ℝ) (n : ℕ) (x : ℝ)
    (hleft : C 0 ≤ x) (hright : x < C n) :
    ∃ i : ℕ, i < n ∧ C i ≤ x ∧ x < C (i + 1)

theorem cutAtomMem_covers_unit_interval
    (n D : ℕ) (hn : 0 < n) (hD : 0 < D) (C : ℕ → ℕ)
    (hfirst : C 0 = 0) (hlast : C n = D) :
    ∀ x : ℝ, 0 ≤ x → x < 1 →
      ∃ a : Fin (2 * n), CutAtomMem C D a.val x
```

The first theorem has a short induction on `n`. The zero case contradicts
`C 0 ≤ x < C 0`. In the successor case, if `x < C n`, use the induction
hypothesis. Otherwise `C n ≤ x`, so `i = n` supplies the required interval,
using the given upper comparison with `C (n+1)`. This argument needs no
monotonicity assumption: it finds an upward adjacent crossing. Consequently
the coverage theorem stated here is valid even for an unsorted cut list.
The actual frozen list is strictly increasing, but uniqueness/disjointness
and their extra hypotheses need not enter this proof or the trusted contract.

For the second theorem, apply the first to `C i / D`. The endpoint equalities
and `D > 0` transform `0 ≤ x < 1` into its premises. Obtain `i < n` with
`C i / D ≤ x < C (i+1) / D`. If equality holds at the lower endpoint, choose
atom `2*i`; otherwise choose atom `2*i+1`. The two index bounds and the
quotient/remainder identities by 2 are universal natural arithmetic, not
enumerations of the 120 atoms.

Take `n = 60`, `D = 360`, and the exact 61 frozen cut numerators. Define
`AtomMem a x := CutAtomMem C 360 a.val x`. The required finite endpoint facts
are `C 0 = 0` and `C 60 = 360`. A stored `Fin 61 → ℕ` vector may be extended
to `ℕ → ℕ` by any total default outside the range; prove once that every
index used here is in range. For `a : Fin 120`, `a.val / 2 < 60`, so both
`a.val / 2` and its successor lie below 61. The two chosen atom indices are
below 120 because `i < 60`. No out-of-range default participates in the proof.

At zero, the singleton atom is selected. At an interior cut, a singleton
contains the point; open atoms exclude their endpoints. At the upper boundary,
the last open atom ends at 1, while the partition premise excludes 1 itself.
Later periodic normalization sends phase 1, and every other integer phase,
to the singleton at zero. Nothing is discarded as a set of measure zero.

## 4. Exact finite arithmetic facts required for true-bit soundness

Let `M : Fin 120 → ℕ` be the supplied atom masks. The following definitions
match the accepted checker, using natural arithmetic only:

```lean
def phaseRepresentative (C : ℕ → ℕ) (a : Fin 120) : ℕ :=
  if a.val % 2 = 0 then 2 * C (a.val / 2)
  else C (a.val / 2) + C (a.val / 2 + 1)

def phaseNumerator (C : ℕ → ℕ) (a : Fin 120) (k : Fin 23) : ℕ :=
  phaseSlope k * phaseRepresentative C a + 120 * phaseShift k

def phaseQuotient (C : ℕ → ℕ) (a : Fin 120) (k : Fin 23) : ℕ :=
  phaseNumerator C a k / 720

structure PhaseBandFacts (C : ℕ → ℕ) (M : Fin 120 → ℕ) : Prop where
  first : C 0 = 0
  last : C 60 = 360
  singleton : ∀ (a : Fin 120) (k : Fin 23),
    a.val % 2 = 0 → (M a).testBit k.val = true →
      if k.val < 20 then
        120 ≤ phaseNumerator C a k % 720 ∧
          phaseNumerator C a k % 720 ≤ 600
      else
        120 < phaseNumerator C a k % 720 ∧
          phaseNumerator C a k % 720 < 600
  interval : ∀ (a : Fin 120) (k : Fin 23),
    a.val % 2 ≠ 0 → (M a).testBit k.val = true →
      360 * phaseQuotient C a k + 60 ≤
          phaseSlope k * C (a.val / 2) + 60 * phaseShift k ∧
        phaseSlope k * C (a.val / 2 + 1) + 60 * phaseShift k ≤
          360 * phaseQuotient C a k + 300
```

This structure deliberately asks only for the singleton remainder tests;
open atoms instead use the endpoint implications directly. An existing checker
which proves the remainder test for every true bit, including open ones,
provides more than required. It must still provide the displayed interval
bounds, unless a separate cut-grid argument is implemented. The accepted
Python checker already checked those bounds, so checking the same fixed
integer predicates in Lean is the shorter interface.

No real-valued `floor` computation occurs in these finite facts. All
numerators, quotients and masks are natural numbers; all denominator constants
are explicit positive integers. In particular, the upper endpoint is expressed
as `360*q+300`, not with truncated natural subtraction such as `q+1-1/6`.
The true-bit checks are finite implications; they do not inspect any real x.

The proposed universal transfer lemma is:

```lean
theorem phaseBandFacts_sound (C : ℕ → ℕ) (M : Fin 120 → ℕ)
    (h : PhaseBandFacts C M) :
    ∀ (a : Fin 120) (k : Fin 23), k ∈ phaseBits (M a) →
      ∀ x : ℝ, CutAtomMem C 360 a.val x → PhaseGood k x
```

Its proof splits only on atom parity and candidate kind. For a singleton put
`c = C (a.val/2)`, `A = phaseSlope k`, `B = phaseShift k`,
`N = A*(2*c)+120*B`, `Q = N/720`, `R = N%720`. Natural division gives
`N = 720*Q + R`. Cast this identity into `ℝ`; since `x = c/360`, ordinary
field algebra gives

    A*x + B/6 = N/720 = Q + R/720.

If the bit is closed, `120 ≤ R ≤ 600` places this phase in
`[Q+1/6,Q+5/6]`; apply the existing closed-band lemma. If the bit is strict,
`120 < R < 600` puts the phase in the corresponding open band; apply the
strict-band lemma. The Euclidean identity can use `Nat.div_add_mod` or its
commuted/multiplied normalization. No claim that `Q` is a real floor is
needed. The quotient identity and the supplied inequalities suffice.

For an open atom put `c=C(a.val/2)`, `d=C(a.val/2+1)` and
`Q=phaseQuotient C a k`. Cast its two natural endpoint inequalities to reals
and divide by 360. They become

    Q+1/6 ≤ A*(c/360)+B/6,
    A*(d/360)+B/6 ≤ Q+5/6.

Use `q = (Q : ℤ)` in the generic affine-open lemma. The cast identity
`(((Q : ℤ) : ℝ)) = (Q : ℝ)` is explicit. Its strict conclusion is precisely
the required strict bit assertion, or yields the closed assertion by
`le_of_lt`. The proof does not need to show that `Q` is constant as the real
floor throughout the atom, identify which floor band was chosen, or exclude
a safety boundary using a separate combinatorial argument. The displayed
endpoint facts already choose a valid integer band.

Equality of an open interval endpoint with `Q+1/6` or `Q+5/6` is allowed.
Equality at a singleton is allowed only for a closed candidate. At phase zero,
the strict `(1,1)` candidate is correctly false; `(1,2)` and `(1,4)` are
strictly safe. This is a direct symbolic endpoint check, not a new executed
fixture. Treating the last three singleton tests as closed would invalidate
the transfer contract.

Finite `decide` proofs must establish `PhaseBandFacts` about the actual
definitions used by the theorem. A source hash or a Python success message
cannot replace these propositions. Whether they are checked in one declaration
or bounded rows is a performance choice for root, with no change of semantics.
The integer domain remains the frozen 120 atoms × 23 candidates; this report
does not authorize executing a new run or widening a domain.

## 5. Bitmask and retained-core connection to the existing kernel module

Set `mask a := phaseBits (M a)`. The finite-set membership lemma is exactly
`k ∈ phaseBits N ↔ N.testBit k.val = true`. Natural mask representation does
not itself grant a bound on candidate indices; membership restricts them to
`Fin 23` by definition.

Useful universal bitwise contracts are:

```lean
theorem phaseBits_subset_of_and_eq (small large : ℕ)
    (h : small &&& large = small) :
    phaseBits small ⊆ phaseBits large

theorem phaseBits_common_of_and_ne_zero (M0 M1 M2 : ℕ)
    (hbound : M0 < 2 ^ 23)
    (hcommon : (M0 &&& M1 &&& M2) ≠ 0) :
    ∃ c : Fin 23,
      c ∈ phaseBits M0 ∧ c ∈ phaseBits M1 ∧ c ∈ phaseBits M2
```

The first follows by applying `testBit` to the equality and using bitwise-and
semantics. For the second, a nonzero natural number has a true bit. A true bit
of the intersection is true in each factor. The first-mask bound forces that
bit's index below 23: a true bit at index `r` implies `2^r ≤ M0`, contradicting
`M0 < 2^23` when `r ≥ 23`. Package the index as `Fin 23`. The proof may use
existing mathlib bit lemmas or establish this generic fact from binary
decomposition; these theorem signatures do not assert guessed library names.
Only the first-mask bound is logically needed here; the root source supplies
it for every core mask. Without a bit-index bound, a nonzero intersection
alone would not establish a witness among the 23 candidate bits.

The concurrent `RenaultPhaseMasks.lean` snapshot defines
`renaultPhaseCoreMasks : Fin 41 → ℕ` and proposes/proves in its source

```lean
renaultPhaseCoreMasks_all_rows : ∀ i j k : Fin 41, j ≤ k →
  (renaultPhaseCoreMasks i &&& renaultPhaseCoreMasks j &&&
    renaultPhaseCoreMasks k) ≠ 0

renaultPhaseCoreMasks_lt : ∀ i : Fin 41,
  renaultPhaseCoreMasks i < 2 ^ 23
```

These declarations' mathematical contracts are sufficient for the triple
adapter. The first is stronger than the generic theorem needs, since it does
not require `i ≤ j`. This report did not run or verify their Lean build.

To connect those bare core masks with `phase_certificate_sound`, root still
needs the following finite typed data and equalities:

```lean
core : Fin 41 → Fin 120
dom : Fin 120 → Fin 41

hcore : ∀ i : Fin 41, M (core i) = renaultPhaseCoreMasks i
hdomNat : ∀ a : Fin 120,
  renaultPhaseCoreMasks (dom a) &&& M a =
    renaultPhaseCoreMasks (dom a)
```

The canonical supplied choice of `core i` is the JSON atom
`class_reps[minimal_classes[i]]`; the dominators are the JSON `dom` entries,
which are retained-index positions, not raw class IDs or atom IDs. The finite
range checks used to construct these `Fin` values are essential. The class
map and least-representative/minimal-antichain metadata need not be carried
into the theorem once `hcore` and `hdomNat` are checked.

Rewrite `hcore`, use the subset adapter on `hdomNat`, and obtain the exact
`hdom` hypothesis. For a sorted `i ≤ j ≤ k`, apply `all_rows i j k` to
`j ≤ k`, then the common-bit adapter using the first-mask bound, and rewrite
the three occurrences of `hcore`. This gives the exact `htriples` hypothesis.
Repeated retained indices are included by the non-strict comparisons. A bare
table of nonempty intersections without `hcore` and atom domination would
leave a genuine gap to the real-phase theorem.

Alternatively, kernel-checking the frozen supplied witness byte for each
sorted triple can directly establish `htriples`. In that route every supplied
byte must be proved below 23 and present in all three linked masks. The accepted
12,341-byte witness sequence and root's row nonzeroness proof are two ways to
establish the same existential hypothesis. No least-bit convention, witness
search, fresh candidate family, or proof of minimality is needed by this
bridge. The row theorem is a separate root task, not an experiment proposed
or executed here.

## 6. Arbitrary real phases and exact external statement

The existing `circleNorm_fract_mul_nat` in `PivotBoundary.lean` handles no
additive offset. Rather than silently assuming it handles `B`, prove the
following reusable offset version from `circleNorm_add_int`:

```lean
theorem circleNorm_nat_affine_fract (A : ℕ) (B x : ℝ) :
    circleNorm ((A : ℝ) * Int.fract x + B) =
      circleNorm ((A : ℝ) * x + B)

theorem phaseGood_fract (k : Fin 23) (x : ℝ) :
    PhaseGood k (Int.fract x) ↔ PhaseGood k x
```

Write `x = (⌊x⌋ : ℝ) + Int.fract x`, using `Int.floor_add_fract`. Then

    A*x+B = (((A : ℤ)*⌊x⌋ : ℤ) : ℝ) + (A*Int.fract x+B).

Apply integer periodicity and orient the equality as stated. This is valid
for every real `x`, including negative values and integer endpoints; the
offset `B` is arbitrary and `A` may be zero in this generic lemma. No natural
cast of the potentially negative floor occurs. Applying the equality to
each candidate's affine expression proves `phaseGood_fract` for both strict
and closed comparisons, by one candidate-kind split.

After the four concrete hypotheses have been established, apply
`phase_certificate_sound` to `u j := Int.fract (x j)`. The premises are
`Int.fract_nonneg` and `Int.fract_lt_one`. Transfer the resulting common
candidate by `phaseGood_fract` for each `j`. Thus the intended concrete
declaration, once all finite facts and bridges are checked, is

```lean
theorem renault_phase_common_candidate (x : Fin 3 → ℝ) :
    ∃ c : Fin 23, ∀ j, PhaseGood c (x j)
```

Its exact decoded target is:

```lean
theorem renault_phase_five_one (x : Fin 3 → ℝ) :
    (∃ a b : ℕ, 2 ≤ a ∧ a ≤ 5 ∧ 1 ≤ b ∧ b ≤ 5 ∧
      ∀ j, (1 : ℝ) / 6 ≤
        circleNorm ((a : ℝ) * x j + (b : ℝ) / 6)) ∨
    (∃ b : ℕ, (b = 1 ∨ b = 2 ∨ b = 4) ∧
      ∀ j, (1 : ℝ) / 6 < circleNorm (x j + (b : ℝ) / 6))
```

Decode the one selected `c` once for all three phases. If `c.val < 20`,
natural division/remainder by 5 give `2 ≤ a ≤ 5` and `1 ≤ b ≤ 5` for the
displayed formulas. Otherwise the `Fin 23` bound gives `c.val = 20`, 21 or
22, and the shift is respectively 1,2 or 4. The theorem does not assume the
phases are rational, ordered, distinct, nonnegative or different from zero.
It does not select a different candidate for each phase.

The normalized statement is the exact mixed scope of Renault Lemma 5.1
documented in the accepted independent review; the arbitrary-real statement
is its proved periodic extension. The primary-paper scope and hosted-copy
provenance are inherited from that frozen review, not a fresh PDF retrieval
in this task. The bridge proof here is self-contained given the stated
circle-norm APIs and finite hypotheses.

## 7. Dependency order and acceptance boundary

Recommended implementation order:

1. Generic strict-band and affine-open lemmas, importing
   `StructuredClasses.lean`; generic cut coverage by induction.
2. Candidate formulas, bit-set interpretation, natural representative/quotient
   definitions and `PhaseBandFacts`; prove `phaseBandFacts_sound` once.
3. Offset periodicity and `phaseGood_fract`, using `FastRunnerInsertion.lean`.
   These do not require importing the pivot or maximizer modules.
4. Root's finite literal cuts, atom masks, representatives and dominators;
   check `PhaseBandFacts`, `hcore`, and `hdomNat` about those literals.
5. Root's fixed core-intersection facts and generic bit extraction; feed the
   four resulting hypotheses to the already checked generic phase theorem.
6. Normalize arbitrary real phases and decode the common candidate, producing
   the two exact final declarations above. Perform independent universal type
   and axiom checks when implemented, under the project verification policy.

The finite predicates and the generic real argument can be implemented and
reviewed separately. There is no need for 120 handwritten real cases, a real
floor-case split for every midpoint, a proof that all false bits are false on
the whole atom, or a reimplementation of the class-minimalization algorithm.
Finite arithmetic normalization is sufficient at the checker boundary, but
the final declarations must retain ordinary kernel proof terms and only the
project's allowed axioms.

The remaining work is concrete Lean implementation and certification of these
specified premises. This manuscript does not discharge Renault 6.1 or 6.4,
the six-total speed argument, the five-moving closed 1/6 witness supply, H7/H8
assembly, or unrestricted LRC. A hypothetical `Fin 6` natural 1/7 theorem would
also not supply the five-moving 1/6 result needed at the stated canonical gap.

## 8. Provenance and actual checks in this task

Configuration, workflow documentation, policy and focused current state were
read. The actual command `python3 scripts/validate_workflow.py` exited 0 with:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

The accepted detailed plan and generic kernel source were read, including
the cut endpoint implications; the fixed review's mathematical scope and
prior finite receipts were inspected. Relevant checked local circle-norm
API bodies were read. The concurrent `RenaultPhaseMasks.lean` snapshot was
read for interface alignment only and is not included in the frozen source
guards below. No Lean execution, probe, build, arithmetic experiment,
enumeration, solver, witness search, cache access or Git/state mutation was
performed. Only this manuscript was written. No proposed Lean signature here
is described as tested or elaborated.

The actual read-only command below exited 0 and produced these hashes:

```bash
sha256sum research/astra-renault-phase-certificate-plan.md research/astra-renault-phase-fixed-certificate-review.md research/astra-renault-phase-five-one-certificate.json LonelyRunner/RenaultPhaseCertificates.lean LonelyRunner/StructuredClasses.lean LonelyRunner/FastRunnerInsertion.lean LonelyRunner/PivotBoundary.lean
```

```text
7f9d296d61db16467e7b7bf34e5070b7497f3b6a0be939e2e8fa273887ecf4af  research/astra-renault-phase-certificate-plan.md
e0771ca34ce9c0d484b72da43c444bd37dd02dd8173442d2dde7251b64c37211  research/astra-renault-phase-fixed-certificate-review.md
c1374409d4f6804487179fe9765695a2f0d756ccd2a79b5ee8616e919acbb7b1  research/astra-renault-phase-five-one-certificate.json
36b58c04e0c755d462f32bae3388c30d744d97ccb20a3bc27aa0daa99b7e49f0  LonelyRunner/RenaultPhaseCertificates.lean
5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c  LonelyRunner/StructuredClasses.lean
dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5  LonelyRunner/FastRunnerInsertion.lean
0e56cab74d30ef8b537ed4ec24503aae875bd8aadc369d26da99ba882cc3603f  LonelyRunner/PivotBoundary.lean
```

These guards identify the reviewed mathematical inputs; they do not certify
the proposed new declarations. Root should review this manuscript and preserve
the exact contract while assigning implementation. The next useful action is
the bounded generic real-bridge implementation above alongside the already
assigned fixed-table kernel work.
