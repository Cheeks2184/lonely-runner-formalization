# Prompt68 bounded-annihilator Lean specification

Task: `FORM-P68-BOUNDED-ANNIHILATOR-SPEC-166`

Base commit: `52486cd8632d813fbdd137798b43d6e475de18a8`

Status: frozen declaration plan; no Lean implementation or status promotion.

Mathematical source of truth:
`docs/response68-audit.md`. This specification covers only the audited bounded
modular-annihilator theorem and its fixed-integer rational-hyperplane
consequence. It does not state or imply cofinite prime forcing or unrestricted
Lonely Runner.

## 1. Module boundary

The implementation target is one new module:

```text
LonelyRunner/BoundedAnnihilator.lean
```

with exactly these imports initially:

```lean
import LonelyRunner.Formulations
import LonelyRunner.PivotResidues
import Mathlib.Data.Nat.Prime.Infinite
import Mathlib
```

`Mathlib` is deliberately broad for the first analytic implementation. It is
still a pinned standard dependency and avoids guessing a narrower Fourier
import set before the analytic architecture has been reviewed. Import
minimization is a later mechanical task and may not change declarations.

All declarations are in:

```lean
namespace LonelyRunner

open scoped BigOperators
open Finset
```

The module is imported by `LonelyRunner.lean` only after its target build and
axiom audit pass. The authoritative toolchain is `leanprover/lean4:v4.32.1`
with the `mathlib` revision pinned in `lake-manifest.json`.

## 2. Frozen definitions

### 2.1 Circular residue on `ZMod`

```lean
/-- The canonical shorter distance from a nonzero-modulus residue to zero. -/
def zmodCyclicDistance {p : ℕ} [NeZero p] (x : ZMod p) : ℕ :=
  cyclicResidueDistance p x.val
```

`NeZero p` is explicit because `ZMod.val` requires a nonzero modulus. In every
theorem below, `Nat.Prime p` supplies the mathematical fact `p ≠ 0`; the proof
must install or receive the `NeZero p` instance explicitly rather than rely on
an unstated coercion.

This definition reuses `LonelyRunner.cyclicResidueDistance` from
`LonelyRunner/PivotResidues.lean`. It must not be replaced by an `ℝ`-valued
circle norm or by a representative chosen only up to sign.

### 2.2 Height

```lean
/-- The exact audited Prompt68 coefficient bound. -/
def boundedAnnihilatorHeight (n : ℕ) : ℕ :=
  2 * n * 5 ^ (n - 1) * 4 ^ n + 1
```

This parses in `ℕ`. In particular,
`boundedAnnihilatorHeight 3 = 9601` and
`boundedAnnihilatorHeight 4 = 256001`. No asymptotic replacement or smaller
experimental bound is allowed.

### 2.3 Strict field cover

```lean
/-- Every field point is strictly bad in at least one coordinate. -/
def IsStrictZModCover {n p : ℕ} [NeZero p]
    (N : ℕ) (b : Fin n → ZMod p) : Prop :=
  ∀ x : ZMod p, ∃ i : Fin n,
    N * zmodCyclicDistance (x * b i) < p
```

The main theorem always instantiates `N` definitionally as `n + 1`; there is
no independently quantified denominator and hence no possible mismatch
between `N` and the moving dimension. The inequality is the exact
integer-only version of
`rho_p(x*b_i) < p/(n+1)`. Equality
`(n+1) * rho = p` is safe and does not satisfy the predicate. The quantifier
includes `x=0`.

### 2.4 Bounded modular annihilator

```lean
/-- A nonzero, pointwise bounded integer relation modulo `p`. -/
def IsBoundedZModAnnihilator {n p : ℕ}
    (H : ℕ) (b : Fin n → ZMod p) (c : Fin n → ℤ) : Prop :=
  c ≠ 0 ∧
  (∀ i, (c i).natAbs ≤ H) ∧
  ∑ i, (c i : ZMod p) * b i = 0
```

The coefficient bound is pointwise and uses `Int.natAbs`; this avoids an
ambiguous norm/coercion. The modular sum is in `ZMod p` over `Finset.univ`.
The order of the factors is frozen as displayed, although commutativity makes
it mathematically immaterial.

## 3. Frozen theorem statements

### 3.1 Bounded-annihilator theorem

```lean
/-- A strict cover by nonzero field directions has a uniformly bounded
nonzero integer annihilator. -/
theorem exists_boundedZModAnnihilator
    {n p : ℕ} [NeZero p]
    (hn : 3 ≤ n) (hp : Nat.Prime p)
    (b : Fin n → ZMod p)
    (hb : ∀ i, b i ≠ 0)
    (hcover : IsStrictZModCover (n + 1) b) :
    ∃ c : Fin n → ℤ,
      IsBoundedZModAnnihilator (boundedAnnihilatorHeight n) b c
```

`Nat.Prime p` makes `ZMod p` a field. Thus `hb` is exactly the nonzero/unit
domain from the audited theorem: every `b i` is a unit, but the public
signature uses nonzeroness so that integer reductions do not require wrapping
coordinates in `Units`. Repetitions among the `b i` are allowed. There is no
injectivity, deletion-gcd, `p>N`, primitivity, or distinct-residue hypothesis.

### 3.2 Support-at-least-two theorem

```lean
/-- Above the coefficient bound, a bounded nonzero annihilator cannot have
singleton support. -/
theorem boundedZModAnnihilator_support_card
    {n p : ℕ} [NeZero p]
    (hp : Nat.Prime p)
    (b : Fin n → ZMod p)
    (hb : ∀ i, b i ≠ 0)
    (c : Fin n → ℤ)
    (hc : IsBoundedZModAnnihilator (boundedAnnihilatorHeight n) b c)
    (hpLarge : boundedAnnihilatorHeight n < p) :
    2 ≤ (Finset.univ.filter fun i => c i ≠ 0).card
```

This is separate from the Fourier theorem. Its proof may use only the
annihilator equation, pointwise bound, primality, and `hb`. It must not rerun
Fourier analysis. The strict hypothesis is `H_n < p`; replacing it by
`H_n ≤ p` or changing the conclusion to mere nonempty support is prohibited.

The derived existential theorem may be added only as a thin composition:

```lean
theorem exists_boundedZModAnnihilator_support_two
    {n p : ℕ} [NeZero p]
    (hn : 3 ≤ n) (hp : Nat.Prime p)
    (b : Fin n → ZMod p) (hb : ∀ i, b i ≠ 0)
    (hcover : IsStrictZModCover (n + 1) b)
    (hpLarge : boundedAnnihilatorHeight n < p) :
    ∃ c : Fin n → ℤ,
      IsBoundedZModAnnihilator (boundedAnnihilatorHeight n) b c ∧
      2 ≤ (Finset.univ.filter fun i => c i ≠ 0).card
```

### 3.3 Fixed-integer hyperplane corollary

```lean
/-- Every positive-integer LRC counterexample in moving dimension at least
three lies on a bounded mixed-sign rational hyperplane. -/
theorem positiveIntegerCounterexample_exists_boundedRelation
    {n : ℕ} (hn : 3 ≤ n)
    (a : Fin n → ℕ)
    (hinjective : Function.Injective a)
    (hpositive : ∀ i, 0 < a i)
    (hcounterexample :
      ¬ ∃ time : ℝ, ∀ i,
        (((n + 1 : ℕ) : ℝ)⁻¹) ≤
          ‖((time * (a i : ℝ) : ℝ) : UnitCircle)‖) :
    ∃ c : Fin n → ℤ,
      c ≠ 0 ∧
      (∀ i, (c i).natAbs ≤ boundedAnnihilatorHeight n) ∧
      (∑ i, c i * (a i : ℤ) = 0) ∧
      (∃ i, c i < 0) ∧
      (∃ i, 0 < c i)
```

The failed-witness premise is copied verbatim from the fixed-`n` body of
`PositiveIntegerConjecture`. Injectivity is retained so the corollary matches
the standard positive-integer counterexample domain, although the analytic
argument may not use it. Positivity is used both to make reductions nonzero
for sufficiently large primes and to derive both coefficient signs from a
nonzero exact zero sum.

The conclusion is an exact integer equality, not merely congruence modulo one
prime. It makes no claim that the relation is unique, primitive, or excludes
all covers on that hyperplane.

## 4. Existing reusable declarations

The implementation should reuse rather than duplicate:

- `LonelyRunner.cyclicResidueDistance` and its basic arithmetic lemmas from
  `LonelyRunner/PivotResidues.lean`;
- `LonelyRunner.circleNorm_nat_div_ge`, the existing closed-boundary bridge
  from natural cyclic distance to `circleNorm`;
- `LonelyRunner.PositiveIntegerConjecture` from
  `LonelyRunner/Formulations.lean` for exact quantifier and boundary shape;
- `ZMod.val`, `ZMod.val_lt`, integer/natural cast lemmas, and the field
  instance supplied by `Nat.Prime p` from mathlib;
- `Nat.exists_infinite_primes` from
  `Mathlib/Data/Nat/Prime/Infinite.lean`;
- `Finset.univ`, `Finset.filter`, `Finset.card`, and finite-function
  cardinality/pigeonhole results from mathlib; and
- the repository's `LonelyRunner/AxiomAudit.lean` convention for final trust
  probes.

`conjecture_iff_positiveIntegerConjecture` is not needed to prove this fixed
integer corollary and must not be invoked to overstate its scope.

## 5. Declaration-level dependency graph

```text
zmodCyclicDistance
boundedAnnihilatorHeight
IsStrictZModCover
IsBoundedZModAnnihilator
        │
        ├── Fourier/tent/root-average implementation
        │       └── exists_boundedZModAnnihilator
        │
        ├── elementary support-one contradiction
        │       └── boundedZModAnnihilator_support_card
        │
        └── counterexample rational-sampling bridge
                + infinitely many primes
                + finite bounded coefficient pigeonhole
                + divisibility by infinitely many primes
                        └── positiveIntegerCounterexample_exists_boundedRelation
```

The first substantive missing declaration is
`exists_boundedZModAnnihilator`. Its statement is frozen, but its Fourier
implementation architecture is not. In particular, no reviewed Lean choices
yet exist for the periodic tent, its Fourier coefficients, absolute
summability, the product-tail union bound, or root-of-unity averaging.

After the hyperplane corollary, the mathematical route still stops at the
`RESEARCH-UNRESOLVED` edge identified by the audit: exclude strict covers for
all but finitely many primes on every bounded mixed-sign exact hyperplane, or
produce a counterexample family. None of the declarations above supplies that
edge.

## 6. One-layer task decomposition and admission decisions

### `P68-BA-DEF-01` — definitions and boundary simp lemmas

Admission: **`LUNA-READY`**

- Supervising lead: Formalization/Specification Lead.
- Base: the integration commit containing this specification.
- Allowed implementation files:
  `LonelyRunner/BoundedAnnihilator.lean` only.
- Exact deliverable: the four definitions in Section 2 plus only these local
  lemmas:

```lean
@[simp] theorem zmodCyclicDistance_zero {p : ℕ} [NeZero p] :
    zmodCyclicDistance (0 : ZMod p) = 0

theorem zmodCyclicDistance_eq_min_val {p : ℕ} [NeZero p]
    (x : ZMod p) :
    zmodCyclicDistance x = min x.val (p - x.val)

@[simp] theorem boundedAnnihilatorHeight_three :
    boundedAnnihilatorHeight 3 = 9601

@[simp] theorem boundedAnnihilatorHeight_four :
    boundedAnnihilatorHeight 4 = 256001
```

- Dependencies: the exact imports in Section 1.
- Acceptance command:
  `lake env lean LonelyRunner/BoundedAnnihilator.lean`.
- Evidence on success: infrastructure only; no mathematical status promotion.
- Stop/escalate: any need to alter a definition, use real division, change a
  strict inequality, or add an unlisted lemma.

Mandatory preflight:

1. Known success cover: `n=3`, `p=5`, `b=(1,3,4)` satisfies
   `IsStrictZModCover 4 b`; all five `x` values must be checked.
2. Known failure/collision cover: the repeated tuple
   `b=(1,1,1) : Fin 3 → ZMod 5` fails at `x=2`.
3. `zmodCyclicDistance (0 : ZMod 5) = 0` and
   `zmodCyclicDistance (2 : ZMod 5) = 2` succeed.
4. Equality fixture `5 * zmodCyclicDistance (1 : ZMod 5) = 5` succeeds and
   the corresponding strict `< 5` proposition is refuted.
5. Premise-violating modulus `p=0` must fail to obtain the required `NeZero`
   instance in a theorem-domain example.
6. Deliberately altered expectation
   `boundedAnnihilatorHeight 3 = 9600` must fail.

### `P68-BA-SUPPORT-02` — support-at-least-two lemma

Admission: **`LUNA-READY`**

- Supervising lead: Formalization/Specification Lead.
- Base/dependency: accepted `P68-BA-DEF-01` commit.
- Allowed file: `LonelyRunner/BoundedAnnihilator.lean` only.
- Exact deliverable: `boundedZModAnnihilator_support_card` with the signature
  in Section 3.2; no existential Fourier theorem.
- Acceptance command:
  `lake env lean LonelyRunner/BoundedAnnihilator.lean`.
- Evidence on success: local `proved-lean` arithmetic lemma only after lead
  review and axiom audit.
- Stop/escalate: any strengthening of hypotheses, weakening to support
  nonempty, replacement of `<` by `≤`, or difficulty proving that a
  singleton-supported modular sum forces `p ∣ c_i`.

Mandatory preflight uses `p=10009`, the repeated nonzero tuple
`b=(1,1,1)`, and `c=(1,-1,0)` as a valid support-two annihilator. A synthetic
support-one vector `(10009,0,0)` must be recognized as modularly zero but must
fail the pointwise height bound. A vector with a zero `b` coordinate is a
premise-violating fixture. The strict large-prime boundary must also be tested
synthetically at `p=boundedAnnihilatorHeight 3`, where `hpLarge` is false;
this is a hypothesis-boundary test, not an assertion that this value is prime.
An altered expected support cardinality of one must be rejected. These
fixtures test the lemma machinery; they are not cover counterexamples.

### `P68-BA-FOURIER-03` — bounded-annihilator theorem

Admission: **`MEDIUM-SPEC-REQUIRED`**

The final theorem signature is frozen, but the proof architecture is not.
Before any Luna task, Sol Medium must separately freeze:

- the periodic tent representation on `AddCircle 1` or an equivalent
  canonical interval;
- the exact Fourier coefficient declaration and normalization convention;
- absolute summability and the termwise finite-root average interface;
- the product Fourier coefficient and tail norm;
- the root-of-unity orthogonality lemma over `ZMod p`; and
- the exact chain of constants proving the tail is `< w^(n)`.

This must be decomposed into separate lemma tasks. Luna may not infer these
objects from the prose proof or implement the entire Fourier pipeline in one
task.

Required mathematical preflight, once specified:

- success cover: `n=3`, `p=5`, `b=(1,3,4)`; a valid output relation is
  `c=(1,0,1)`;
- failure of the cover premise: `n=3`, `p=5`, `b=(1,1,1)`, witnessed at
  `x=2`;
- strict-boundary fixture: `n=4`, `p=5`, `x=1`, `b_i=1`, where
  `(n+1)*rho=p` is safe and not bad;
- repeated-residue fixture: repeats are accepted by the input type;
- malformed fixture: one coordinate `b_i=0` violates `hb`; and
- altered expected bound `H_3=9600` must fail.

### `P68-BA-SAMPLING-04` — integer counterexample to prime cover

Admission: **`MEDIUM-SPEC-REQUIRED`**

The lead must freeze a one-prime bridge from `hcounterexample` to
`IsStrictZModCover (n+1) (fun i => (a i : ZMod p))`, including the exact lower
bound on `p` used to prove all casts are nonzero. The bridge must explicitly
derive the strict integer inequality from failure of the closed circle-norm
inequality. Existing `circleNorm_nat_div_ge` should be reused where its
contrapositive has the correct direction. No Luna worker may choose a nearby
real-valued formulation.

### `P68-BA-HYPERPLANE-05` — fixed-integer corollary

Admission: **`MEDIUM-SPEC-REQUIRED`**

The final signature in Section 3.3 is frozen. The lead must first specify
separate local lemmas for:

1. arbitrarily large prime selection above all speeds and `H_n`;
2. finiteness of pointwise-bounded coefficient functions;
3. infinite repetition of one coefficient function;
4. conversion of each modular annihilator to prime divisibility of the fixed
   integer sum;
5. an integer divisible by arbitrarily large primes is zero; and
6. positivity plus a nonzero zero-sum relation gives both coefficient signs.

Only after `P68-BA-FOURIER-03` and `P68-BA-SAMPLING-04` are accepted may these
be split into Luna-sized implementation tasks.

### `P68-BA-COFINITE-06` — exclude covers on bounded hyperplanes

Admission: **`RESEARCH-UNRESOLVED`**

This is the first missing mathematical bridge toward cofinite prime forcing.
It is not a formalization task and must not be assigned to Luna.

## 7. Axiom and implementation policy

Permitted trust dependencies are Lean's kernel and standard pinned mathlib
theorems. Final `#print axioms` output may contain only standard logical
foundations already accepted by this repository, such as `propext`,
`Classical.choice`, and `Quot.sound` when actually introduced by mathlib.
No project-specific axiom or unreviewed theorem is permitted.

The implementation must not use or introduce:

- `axiom` or `constant` as a proof substitute;
- `sorry`, `admit`, `by_contra!` with an unresolved goal, or placeholder
  declarations;
- `unsafe`;
- `native_decide`;
- disabled termination, linter, or kernel checks;
- theorem-local assumptions that strengthen `hb`, require distinct `b`, add
  deletion gcd, require `p>N` for the main theorem, or weaken strictness;
- a smaller or asymptotic replacement for `boundedAnnihilatorHeight`; or
- a conclusion merely congruent for the hyperplane theorem instead of exact
  equality in `ℤ`.

`classical` and ordinary `decide` are allowed when they elaborate to standard
kernel-checked proof terms.

## 8. Acceptance commands and audit output

For definition/support tasks, the targeted checkpoint is:

```bash
lake env lean LonelyRunner/BoundedAnnihilator.lean
lake build LonelyRunner.BoundedAnnihilator
git diff --check
```

After the substantive theorems are implemented and reviewed, add their module
import and these probes to `LonelyRunner/AxiomAudit.lean`:

```lean
#print axioms LonelyRunner.exists_boundedZModAnnihilator
#print axioms LonelyRunner.boundedZModAnnihilator_support_card
#print axioms LonelyRunner.positiveIntegerCounterexample_exists_boundedRelation
```

Then run:

```bash
lake env lean LonelyRunner/AxiomAudit.lean
lake build LonelyRunner
rg -n "sorry|admit|native_decide|unsafe|^axiom |^constant " \
  LonelyRunner/BoundedAnnihilator.lean LonelyRunner/AxiomAudit.lean
```

The expected axiom report must contain no project-specific or untrusted axiom.
A complete clean Level 3 replay is deferred until Sol High selects the source
change for an authoritative integration checkpoint; it is not required for
this documentation-only specification.

## 9. Implication and evidence scope

If the main bounded-annihilator theorem compiles without prohibited constructs
and passes independent review, it earns `proved-lean` only for the necessary
modular relation stated in Section 3.1. The support theorem earns that label
only for its separate large-prime consequence. If the hyperplane corollary
also compiles and is audited, it earns `proved-lean` only as a necessary
condition on fixed positive-integer counterexamples.

None of these labels would prove:

- that a strict cover cannot lie on such a hyperplane;
- that only finitely many obstruction primes exist;
- `COFINITE-PRIME-FORCING`;
- the positive-integer Lonely Runner Conjecture; or
- unrestricted real Lonely Runner.

The route materially narrows the obstruction class but stops at
`P68-BA-COFINITE-06`.
