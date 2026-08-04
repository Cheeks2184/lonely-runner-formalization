# Prompt100 `N = 4` owner-class specification

Task: 365

Base commit: `0605cdf1b2a6288aaa6cf3a0cedb5883ef5b410d`

Status: frozen Sol Medium sub-specification; no Lean implementation or theorem
promotion is included

## 1. Scope and fixed semantics

This document refines the `N = 4` layer of
`docs/prompt100-two-owner-formalization-contract.md`. It does not change that
contract's public theorem:

```lean
theorem four_twoLowerOwner_noncover
    (p b c : Nat)
    (hp : 0 < p) (hb : 0 < b) (hbc : b < c) (hc : c < p) :
    ∃ r : Nat,
      r ∈ pivotCandidates 4 p ∧
      r ∉ pivotBadResidues 4 p b ∧
      r ∉ pivotBadResidues 4 p c
```

All residues remain canonical, `0 <= r < 4*p`, with `4 ∤ r`. Badness is
exactly the existing strict predicate
`cyclicResidueDistance (4*p) (r*d) < p`. Its complement is closed, so equality
at distance `p` is safe. Owner labels are never merged when their bad subsets
coincide. No primitive, gcd, parity, or divisibility premise may be added to
the displayed public theorem.

All declarations below are in `namespace LonelyRunner`.

## 2. Proposed modules and imports

| Module | Exact imports |
| --- | --- |
| `LonelyRunner/Prompt100FourClasses.lean` | `LonelyRunner.PivotCounts`, `Mathlib.Data.Finset.Card`, `Mathlib.Data.Int.Basic` |
| `LonelyRunner/Prompt100FourLift.lean` | `LonelyRunner.Prompt100FourClasses`, `LonelyRunner.Prompt99Scaling`, `LonelyRunner.DivisorInsertion`, `Mathlib.Data.Nat.ModEq` |
| `LonelyRunner/Prompt100Four.lean` | `LonelyRunner.Prompt100FourLift` |

The first implementation may consolidate files, but declaration names and
signatures are frozen. Root imports and `AxiomAudit.lean` are reserved for a
separate integration task.

## 3. Total finite data model

### 3.1 Candidate residue classes

Use a finite type rather than an unchecked natural residue:

```lean
inductive FourCandidateClass
  | sideOne
  | center
  | sideThree
  deriving DecidableEq, Fintype

def FourCandidateClass.residue : FourCandidateClass → Nat
  | .sideOne => 1
  | .center => 2
  | .sideThree => 3

def fourCandidateClass (p : Nat) (s : FourCandidateClass) : Finset Nat :=
  (pivotCandidates 4 p).filter fun r => r % 4 = s.residue
```

The cardinality and partition declarations are:

```lean
theorem card_fourCandidateClass
    (p : Nat) (s : FourCandidateClass) (hp : 0 < p) :
    (fourCandidateClass p s).card = p

theorem pivotCandidates_four_eq_biUnion_classes (p : Nat) :
    pivotCandidates 4 p =
      Finset.univ.biUnion (fourCandidateClass p)

theorem fourCandidateClass_pairwiseDisjoint (p : Nat) :
    ∀ ⦃s t : FourCandidateClass⦄, s ≠ t →
      Disjoint (fourCandidateClass p s) (fourCandidateClass p t)
```

The last two statements may be expressed using an equivalent standard
`Finset` pairwise-disjoint API if elaboration requires it; their quantified
content may not change.

### 3.2 Six effective patterns

```lean
inductive FourOwnerPattern
  | Z | Nminus | C | D | F | G
  deriving DecidableEq, Fintype

def FourOwnerPattern.sideEpsilon : FourOwnerPattern → Int
  | .Z => 0
  | .Nminus => -1
  | .C => 0
  | .D => -1
  | .F => 1
  | .G => 1

def FourOwnerPattern.centerEpsilon : FourOwnerPattern → Int
  | .Z => 0
  | .Nminus => -1
  | .C => -2
  | .D => 1
  | .F => -1
  | .G => 1

def FourOwnerPattern.epsilon
    (pattern : FourOwnerPattern) : FourCandidateClass → Int
  | .sideOne => pattern.sideEpsilon
  | .center => pattern.centerEpsilon
  | .sideThree => pattern.sideEpsilon
```

These functions are total. There is no wildcard default and no partial table.

### 3.3 The eight possible normalized rows

```lean
inductive FourOwnerRow
  | k1p0 | k1p1 | k1p2 | k1p3
  | k2p1 | k2p3
  | k4p1 | k4p3
  deriving DecidableEq, Fintype

def FourOwnerRow.k : FourOwnerRow → Nat
  | .k1p0 | .k1p1 | .k1p2 | .k1p3 => 1
  | .k2p1 | .k2p3 => 2
  | .k4p1 | .k4p3 => 4

def FourOwnerRow.pModFour : FourOwnerRow → Nat
  | .k1p0 => 0
  | .k1p1 | .k2p1 | .k4p1 => 1
  | .k1p2 => 2
  | .k1p3 | .k2p3 | .k4p3 => 3

def FourOwnerRow.pattern : FourOwnerRow → FourOwnerPattern
  | .k1p0 => .Z
  | .k1p1 => .Nminus
  | .k1p2 => .C
  | .k1p3 => .D
  | .k2p1 => .D
  | .k2p3 => .F
  | .k4p1 => .G
  | .k4p3 => .Nminus
```

Impossible combinations are excluded by this eight-constructor type, not
mapped to an arbitrary pattern. The completeness theorem proves that every
mathematically valid normalized pair has one row:

```lean
theorem exists_unique_fourOwnerRow
    (P D : Nat) (hP : 0 < P) (hD : 0 < D)
    (hDP : Nat.Coprime D P) :
    ∃! row : FourOwnerRow,
      Nat.gcd D 4 = row.k ∧ P % 4 = row.pModFour
```

The proof must derive, rather than assume:

- `Nat.gcd D 4` is one of `1`, `2`, `4`;
- if that gcd is `2` or `4`, then `P` is odd by coprimality;
- hence rows `(2,0)`, `(2,2)`, `(4,0)`, and `(4,2)` are impossible.

No `Option FourOwnerPattern`, partial function, proof-irrelevant fallback, or
unreachable default is permitted.

## 4. Normalization data

Every lower owner has an explicit normalization package:

```lean
structure FourOwnerNormalization (p d : Nat) where
  hp : 0 < p
  hd : 0 < d
  hdp : d < p
  h : Nat
  P : Nat
  D : Nat
  k : Nat
  h_eq : h = Nat.gcd d p
  h_pos : 0 < h
  p_eq : p = h * P
  d_eq : d = h * D
  P_pos : 0 < P
  D_pos : 0 < D
  D_lt_P : D < P
  coprime : Nat.Coprime D P
  k_eq : k = Nat.gcd D 4
  row : FourOwnerRow
  row_k : k = row.k
  row_pModFour : P % 4 = row.pModFour
```

Construction and proof irrelevance at the observable row are frozen:

```lean
theorem exists_fourOwnerNormalization
    (p d : Nat) (hp : 0 < p) (hd : 0 < d) (hdp : d < p) :
    Nonempty (FourOwnerNormalization p d)

theorem fourOwnerNormalization_row_unique
    {p d : Nat} (x y : FourOwnerNormalization p d) :
    x.row = y.row
```

Downstream statements consume a supplied normalization. They may not silently
recompute `h`, `P`, `D`, or `k` with a different division convention.

For compatibility with the earlier public predicate:

```lean
def IsFourGOwner (p d : Nat) : Prop :=
  let h := Nat.gcd d p
  Nat.gcd (d / h) 4 = 4 ∧ (p / h) % 4 = 1

theorem isFourGOwner_iff_normalization_pattern_G
    {p d : Nat} (norm : FourOwnerNormalization p d) :
    IsFourGOwner p d ↔ norm.row.pattern = .G
```

## 5. Exact class-count theorem

The count is stated integrally. There is no natural division by two:

```lean
theorem two_mul_card_bad_inter_fourCandidateClass
    {p d : Nat} (norm : FourOwnerNormalization p d)
    (s : FourCandidateClass) :
    2 * ((fourCandidateClass p s ∩
        pivotBadResidues 4 p d).card : Int) =
      (p : Int) +
        norm.row.pattern.epsilon s * (norm.h : Int)
```

The parity consequence is explicit:

```lean
theorem two_dvd_pattern_class_numerator
    {p d : Nat} (norm : FourOwnerNormalization p d)
    (s : FourCandidateClass) :
    (2 : Int) ∣
      (p : Int) + norm.row.pattern.epsilon s * (norm.h : Int)
```

Equality at the strict endpoint is excluded from the left-hand bad set. A
proof through a signed target interval must use exactly `-P+1,...,P-1`, not
closed endpoints `-P,...,P`.

## 6. Independently regenerated table

The following literal computation enumerated every `r < 4*p` with `r % 4` in
`{1,2,3}` and tested `rho_(4*p)(r*d) < p`. The displayed representatives have
`h=1`; the epsilon triple is `2*count-p`. Scales `h=2` and `h=5` reproduced
the same epsilon triple in every row.

| Row | Representative `(P,D)` | `k` | `P % 4` | Literal class counts `(1,2,3)` | Epsilon triple | Pattern |
| --- | --- | ---: | ---: | --- | --- | --- |
| `k1p0` | `(4,1)` | 1 | 0 | `(2,2,2)` | `(0,0,0)` | `Z` |
| `k1p1` | `(5,1)` | 1 | 1 | `(2,2,2)` | `(-1,-1,-1)` | `Nminus` |
| `k1p2` | `(6,1)` | 1 | 2 | `(3,2,3)` | `(0,-2,0)` | `C` |
| `k1p3` | `(7,1)` | 1 | 3 | `(3,4,3)` | `(-1,1,-1)` | `D` |
| `k2p1` | `(5,2)` | 2 | 1 | `(2,3,2)` | `(-1,1,-1)` | `D` |
| `k2p3` | `(3,2)` | 2 | 3 | `(2,1,2)` | `(1,-1,1)` | `F` |
| `k4p1` | `(5,4)` | 4 | 1 | `(3,3,3)` | `(1,1,1)` | `G` |
| `k4p3` | `(7,4)` | 4 | 3 | `(3,3,3)` | `(-1,-1,-1)` | `Nminus` |

As a separate non-evidentiary guard, literal arithmetic checked all 3,043
coprime pairs `1 <= D < P <= 100` at scales 1 and 2. Every pair classified
into exactly one of these rows and every class count satisfied the integral
formula. These checks validate the frozen table but are not project
`computed finite evidence`.

## 7. Class capacity and `cover forces G`

Define the exact two-owner coverage premise:

```lean
def FourTwoOwnerCover (p d e : Nat) : Prop :=
  pivotCandidates 4 p ⊆
    pivotBadResidues 4 p d ∪ pivotBadResidues 4 p e
```

Because both bad sets are already subsets of the candidate set, this is
equivalent to equality of their union with the candidate set.

The common-point lemma is:

```lean
theorem one_mem_sideOne_and_lowerOwner_bad
    (p d : Nat) (hp : 0 < p) (hd : 0 < d) (hdp : d < p) :
    1 ∈ fourCandidateClass p .sideOne ∩
      pivotBadResidues 4 p d
```

For supplied normalizations define total integral weights:

```lean
def fourSideWeight
    {p d e : Nat}
    (nd : FourOwnerNormalization p d)
    (ne : FourOwnerNormalization p e) : Int :=
  nd.row.pattern.sideEpsilon * (nd.h : Int) +
    ne.row.pattern.sideEpsilon * (ne.h : Int)

def fourCenterWeight
    {p d e : Nat}
    (nd : FourOwnerNormalization p d)
    (ne : FourOwnerNormalization p e) : Int :=
  nd.row.pattern.centerEpsilon * (nd.h : Int) +
    ne.row.pattern.centerEpsilon * (ne.h : Int)
```

The capacity lemmas are exactly:

```lean
theorem fourSideWeight_pos_of_cover
    {p d e : Nat}
    (nd : FourOwnerNormalization p d)
    (ne : FourOwnerNormalization p e)
    (hcover : FourTwoOwnerCover p d e) :
    0 < fourSideWeight nd ne

theorem fourCenterWeight_nonneg_of_cover
    {p d e : Nat}
    (nd : FourOwnerNormalization p d)
    (ne : FourOwnerNormalization p e)
    (hcover : FourTwoOwnerCover p d e) :
    0 <= fourCenterWeight nd ne
```

The strict side conclusion must use `r=1` in both labelled bad sets. If the
two side-class cardinalities sum to exactly `p`, that common point makes their
union have at most `p-1` elements. A mere union bound proves only the negative
weight case and is insufficient.

The finite pattern conclusion is:

```lean
theorem fourTwoOwnerCover_forces_G
    {p d e : Nat}
    (nd : FourOwnerNormalization p d)
    (ne : FourOwnerNormalization p e)
    (hcover : FourTwoOwnerCover p d e) :
    nd.row.pattern = .G ∨ ne.row.pattern = .G
```

Its proof is an exhaustive theorem over the six patterns and positive natural
weights. Without `G`, positive side weight forces an `F`; the center weight is
then negative for `F+F`, `F+Z`, `F+C`, and `F+Nminus`. For `F+D`, positive
side weight gives `h_F > h_D`, while the center weight is `-h_F+h_D < 0`.

## 8. Primitive `G` lift

### 8.1 Shared parameter and base-lift declarations

The normalized `G` parameters are exposed without partial division:

```lean
theorem fourG_normalized_parameters
    {p d : Nat} (norm : FourOwnerNormalization p d)
    (hG : norm.row.pattern = .G) :
    ∃ q E : Nat,
      norm.P = 4 * q + 1 ∧
      norm.D = 4 * E ∧
      0 < E ∧ 4 * E < norm.P ∧ Nat.Coprime E norm.P
```

The common base lift is:

```lean
theorem exists_fourG_safe_lift_family
    {p d : Nat} (norm : FourOwnerNormalization p d)
    (hG : norm.row.pattern = .G) :
    ∃ z q E : Nat,
      norm.P = 4 * q + 1 ∧
      norm.D = 4 * E ∧
      z < norm.P ∧
      E * z % norm.P = q + 1 ∧
      ∀ k < 4 * norm.h,
        p < cyclicResidueDistance (4 * p)
          ((z + k * norm.P) * d)
```

The final inequality is intentionally strict and therefore more than the
closed safety needed downstream.

All three parity sublemmas have the same exact conclusion:

```lean
∃ r : Nat,
  r ∈ pivotCandidates 4 p ∧
  r ∉ pivotBadResidues 4 p d ∧
  r ∉ pivotBadResidues 4 p e
```

They take a supplied `norm : FourOwnerNormalization p d`,
`hG : norm.row.pattern = .G`, positive `e < p`, `e ≠ d`, and the explicit
primitive premise `Nat.gcd (Nat.gcd p d) e = 1`.

### 8.2 Odd other owner

```lean
theorem fourG_oddOther_has_commonSafeCandidate
    {p d e : Nat} (norm : FourOwnerNormalization p d)
    (he : 0 < e) (hep : e < p) (hne : e ≠ d)
    (hprimitive : Nat.gcd (Nat.gcd p d) e = 1)
    (hG : norm.row.pattern = .G) (heOdd : e % 2 = 1) :
    ∃ r : Nat,
      r ∈ pivotCandidates 4 p ∧
      r ∉ pivotBadResidues 4 p d ∧
      r ∉ pivotBadResidues 4 p e
```

Required internal facts: `Nat.Coprime e (4*norm.h)`, permutation of all lift
indices by multiplication with `e`, a closed safe arc of length `2*norm.h`
in circumference `4*norm.h`, two consecutive safe integer indices, and the
fact that one excluded residue class modulo four cannot contain both.

### 8.3 Twice-odd other owner

```lean
theorem fourG_twoModFourOther_has_commonSafeCandidate
    {p d e : Nat} (norm : FourOwnerNormalization p d)
    (he : 0 < e) (hep : e < p) (hne : e ≠ d)
    (hprimitive : Nat.gcd (Nat.gcd p d) e = 1)
    (hG : norm.row.pattern = .G) (heTwo : e % 4 = 2) :
    ∃ r : Nat,
      r ∈ pivotCandidates 4 p ∧
      r ∉ pivotBadResidues 4 p d ∧
      r ∉ pivotBadResidues 4 p e
```

Required internal facts: write `e=2*e0`; primitivity makes `norm.h` odd and
`e0` coprime to `2*norm.h`; the closed safe arc has length `norm.h` in
circumference `2*norm.h`; the two lifts of a safe index differ by
`2*norm.h*norm.P`, which is `2 mod 4`, so at most one is excluded.

### 8.4 Other owner divisible by four

The mandatory reorder is a separate theorem:

```lean
theorem fourG_fourDivOther_reordered_bounds
    {p d e : Nat} (norm : FourOwnerNormalization p d)
    (he : 0 < e) (hep : e < p) (hne : e ≠ d)
    (hG : norm.row.pattern = .G) (heFour : 4 ∣ e) :
    let x := min (d / 4) (e / 4)
    let y := max (d / 4) (e / 4)
    0 < x ∧ x < y ∧ 4 * y < p
```

Then:

```lean
theorem fourG_fourDivOther_has_commonSafeCandidate
    {p d e : Nat} (norm : FourOwnerNormalization p d)
    (he : 0 < e) (hep : e < p) (hne : e ≠ d)
    (hprimitive : Nat.gcd (Nat.gcd p d) e = 1)
    (hG : norm.row.pattern = .G) (heFour : 4 ∣ e) :
    ∃ r : Nat,
      r ∈ pivotCandidates 4 p ∧
      r ∉ pivotBadResidues 4 p d ∧
      r ∉ pivotBadResidues 4 p e
```

This proof must invoke `exists_quarterSafe_smallMultipliers` with exactly
`x=min(d/4,e/4)` and `y=max(d/4,e/4)`. It may not assume `d < e`. Primitivity
makes `norm.h` odd; since `norm.P` is odd, `p` is odd. The four lifts modulo
`4*p` then occupy all four residue classes, while multiplication by both
four-divisible owners is unchanged.

### 8.5 Parity assembly

```lean
theorem fourGOwner_has_commonSafeCandidate_of_primitive
    (p d e : Nat)
    (hp : 0 < p) (hd : 0 < d) (he : 0 < e)
    (hdp : d < p) (hep : e < p) (hne : d ≠ e)
    (hprimitive : Nat.gcd (Nat.gcd p d) e = 1)
    (hG : IsFourGOwner p d) :
    ∃ r : Nat,
      r ∈ pivotCandidates 4 p ∧
      r ∉ pivotBadResidues 4 p d ∧
      r ∉ pivotBadResidues 4 p e
```

The assembly uses the exhaustive alternatives `e % 2 = 1`, `e % 4 = 2`, or
`4 ∣ e`. It introduces no fourth parity case and no weakened conclusion.

## 9. Primitive noncover and unrestricted scaling

The primitive pair theorem combines `cover forces G` with the corresponding
`G` lift:

```lean
theorem four_primitive_twoLowerOwner_noncover
    (p b c : Nat)
    (hp : 0 < p) (hb : 0 < b) (hbc : b < c) (hc : c < p)
    (hprimitive : Nat.gcd (Nat.gcd p b) c = 1) :
    ∃ r : Nat,
      r ∈ pivotCandidates 4 p ∧
      r ∉ pivotBadResidues 4 p b ∧
      r ∉ pivotBadResidues 4 p c
```

The common-factor adapter is frozen explicitly:

```lean
theorem exists_primitive_threeFactor
    (p b c : Nat) (hp : 0 < p) (hb : 0 < b) (hc : 0 < c) :
    ∃ g p0 b0 c0 : Nat,
      0 < g ∧ 0 < p0 ∧ 0 < b0 ∧ 0 < c0 ∧
      Nat.gcd (Nat.gcd p0 b0) c0 = 1 ∧
      p = g * p0 ∧ b = g * b0 ∧ c = g * c0
```

The final wrapper is the unchanged public theorem from Section 1. It must
derive `b0<c0<p0`, apply the primitive theorem, and lift the first-sheet
residue with `mem_pivotCandidates_scale_reduce_iff` and
`mem_pivotBadResidues_scale_reduce_iff`. It may alternatively use a labelled
`Fin 3` family with `exists_scaleSpeeds_primitive`, but it must prove that the
same pivot and two distinct owner labels are recovered. No normalization
assumption survives in the public signature.

## 10. Dependency DAG

```text
finite class/row/pattern types and total functions
  + gcd/parity classification
      -> FourOwnerNormalization and unique row
          -> exact integral class counts
              -> side/center capacity lemmas
                  + common point r=1
                      -> cover forces G

G normalized parameters
  -> common d-safe lift family
      -> odd-owner lift
      -> twice-odd-owner lift
      -> four-divisible-owner reordered bounds
           + quarter-safe small-multiplier lemma
              -> four-divisible-owner lift
      -> primitive G assembly

cover forces G + primitive G assembly
  -> primitive two-owner noncover
      + primitive three-factor adapter
      + existing common-scaling membership equivalences
          -> unrestricted N=4 two-owner noncover
```

## 11. Mandatory preflight fixtures

Each implementation layer must run only its applicable frozen fixtures before
a broad proof attempt:

- all eight representative rows and literal counts from Section 6;
- scaled repetitions at `h=2` and `h=5`;
- malformed normalized combinations `(k,P%4)=(2,0),(2,2),(4,0),(4,2)` must be
  unconstructible under coprimality, not assigned a fallback pattern;
- `k` values other than `1`, `2`, `4` must be impossible as `gcd(D,4)`;
- equality-safe case `(p,d)=(3,1)`: residues `3,9` remain outside the strict
  bad set, which is `{1,2,10,11}`;
- common point: `r=1` belongs to both bad sets whenever `0<d,e<p`;
- collision/nonunit case `(p,d,e)=(6,1,5)`, retaining candidate `r=6` and
  equality safety;
- odd `G` case `(p,d,e)=(5,4,1)`;
- twice-odd `G` case `(5,4,2)`;
- four-divisible `G` case `(9,4,8)`, where reordered multipliers are `1,2`;
- common-scale case `(p,b,c)=(15,5,10)` must reproduce the five sheets of the
  `(3,1,2)` row;
- malformed `p=0`, owner zero, repeated owners, owner at least `p`,
  noncanonical residue, and residue divisible by four must fail premises or
  candidate guards;
- mutation kill: replacing `<p` by `<=p` must change the `(3,1)` class counts
  and reject the equality witnesses.

A synthetic failure for an expected table entry must be included: alter one
epsilon, for example `k4p1.center` from `1` to `-1`; the literal table checker
must reject it.

## 12. Luna Narrow Verification admission

| One-layer task | Admission | Evidence on success |
| --- | --- | --- |
| Implement the three finite inductive types and total lookup functions | `LUNA-READY` | Declaration-scoped `proved-lean` definitions after review |
| Implement representative table regression tests only | `LUNA-READY` | Accepted audit deliverable, not a theorem or finite universal result |
| Implement `exists_unique_fourOwnerRow` | `LUNA-READY` after a one-file Medium contract | `proved-lean` local classification |
| Implement `FourOwnerNormalization` construction and row uniqueness | `LUNA-READY` after classification compiles | `proved-lean` local normalization |
| Implement one exact class-count row | `LUNA-READY` | Local proved-lean lemma only; no extrapolation to other rows |
| Implement the complete class-count theorem | `MEDIUM-SPEC-REQUIRED` | Split into `k=1`, `k=2`, and `k=4` proof tasks first |
| Implement common point `r=1` | `LUNA-READY` | `proved-lean` local lemma |
| Implement side or center capacity | `LUNA-READY` as separate tasks after counts | `proved-lean` local lemmas |
| Implement finite `cover forces G` | `LUNA-READY` after a truth-table preflight and capacity review | `proved-lean` exact combinatorial theorem |
| Implement common `G` parameter/base-lift family | `MEDIUM-SPEC-REQUIRED` | Split modular inverse and distance calculation first |
| Implement each odd/twice-odd/four-divisible lift | `LUNA-READY` only as three separate tasks after the base lift and arc lemmas compile | `proved-lean` at the exact parity premise |
| Implement primitive parity assembly | `LUNA-READY` after all three lift lemmas | `proved-lean` integration wrapper |
| Implement primitive pair noncover | `LUNA-READY` after reviewed class and lift branches | `proved-lean` integration wrapper |
| Implement primitive-factor adapter | `LUNA-READY` | `proved-lean` local arithmetic factorization |
| Implement unrestricted scaling wrapper | `MEDIUM-SPEC-REQUIRED` until the exact first-sheet adapter is separately frozen | `proved-lean` only for the exact public theorem |

No layer is `RESEARCH-UNRESOLVED`; the mathematics is independently accepted
at `proved-math-qualified` scope. Broad multi-layer implementation remains
inadmissible under Luna Narrow Verification Mode.

## 13. Commands, trust, and stop rules

Targeted commands after the corresponding files exist:

```text
lake env lean LonelyRunner/Prompt100FourClasses.lean
lake env lean LonelyRunner/Prompt100FourLift.lean
lake env lean LonelyRunner/Prompt100Four.lean
lake build LonelyRunner.Prompt100Four
```

Integration must add and execute:

```lean
#print axioms LonelyRunner.two_mul_card_bad_inter_fourCandidateClass
#print axioms LonelyRunner.fourSideWeight_pos_of_cover
#print axioms LonelyRunner.fourCenterWeight_nonneg_of_cover
#print axioms LonelyRunner.fourTwoOwnerCover_forces_G
#print axioms LonelyRunner.fourG_oddOther_has_commonSafeCandidate
#print axioms LonelyRunner.fourG_twoModFourOther_has_commonSafeCandidate
#print axioms LonelyRunner.fourG_fourDivOther_has_commonSafeCandidate
#print axioms LonelyRunner.fourGOwner_has_commonSafeCandidate_of_primitive
#print axioms LonelyRunner.four_primitive_twoLowerOwner_noncover
#print axioms LonelyRunner.four_twoLowerOwner_noncover
```

Permitted trust is the Lean kernel, pinned mathlib, standard classical logic,
and already audited repository declarations. Prohibited: `sorry`, `admit`, a
new `axiom`, `unsafe`, `native_decide`, disabled checks, theorem weakening,
extra public gcd/primitivity hypotheses, changed strictness, quotienting owner
labels, or replacement of the unrestricted proof by a finite table scan.

Stop and escalate on any class-count mismatch, impossible row reaching a
fallback, parity ambiguity, natural-subtraction/division weakening, lost
candidate guard, equality treated as bad, failure to order `min/max` in the
four-divisible branch, or requested signature change. Routine imports, syntax,
type annotations, and arithmetic elaboration may be repaired locally.

Successful declarations receive `proved-lean` only at their exact signatures
after independent review. The response table and present specification retain
`proved-math-qualified`/documentation status until then. Prompt95 outside the
`coveredPivots.card <= 3` fragment, the uniform pivot theorem, integer LRC,
and real LRC remain `open`.
