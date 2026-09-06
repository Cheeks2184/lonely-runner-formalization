# Five-adic filter arithmetic implementation

This frozen arithmetic milestone in `LonelyRunner/FiveAdicFiltering.lean`
defines the five-adic digit, good-digit predicate, and below-top correction.
It proves the complete assigned nine-declaration set: correction positivity and
unit residue; Euclidean digit decomposition and good-digit distance; selected
product and selected digit shift with the actual coefficient `(A*u)%5`;
higher-level residue preservation; and top residue/distance for every unit,
including top digit four.

Final source SHA-256:
`806ce4292128bf912b7a5a1c4cf6efd8f649868602e8d81611b2133d8304e7c4`.

The current source was named-built after the arithmetic identities in terminal
session `5307`, exit `0`, with 3001 jobs.  The complete final runnable probe is embedded below so it survives temporary-file cleanup. It prints all nine theorem types with `#check`, prints all nine axiom reports, and compiles four supplied controls.

```lean
import LonelyRunner.FiveAdicFiltering
namespace LonelyRunner
#check fiveAdicCorrection_pos
#check fiveAdicCorrection_mod_five
#check fiveAdic_residue_decomposition
#check fiveAdicGoodDigit_distance
#check fiveAdicCorrection_selected_product
#check fiveAdicCorrection_selected_digit
#check fiveAdicCorrection_higher_residue
#check fiveAdic_top_residue
#check fiveAdic_top_distance
#print axioms fiveAdicCorrection_pos
#print axioms fiveAdicCorrection_mod_five
#print axioms fiveAdic_residue_decomposition
#print axioms fiveAdicGoodDigit_distance
#print axioms fiveAdicCorrection_selected_product
#print axioms fiveAdicCorrection_selected_digit
#print axioms fiveAdicCorrection_higher_residue
#print axioms fiveAdic_top_residue
#print axioms fiveAdic_top_distance
example : fiveAdicDigit 3 (fiveAdicCorrection 3 1 3 * (2 * (5 ^ 1 * 7))) =
    (fiveAdicDigit 3 (2 * (5 ^ 1 * 7)) + 3 * ((2 * 7) % 5)) % 5 := by
  exact fiveAdicCorrection_selected_digit 3 1 3 2 7 (by omega)
example : (fiveAdicCorrection 3 1 3 * (2 * (5 ^ 2 * 3))) % (5 * 5 ^ 3) =
    (2 * (5 ^ 2 * 3)) % (5 * 5 ^ 3) := by
  exact fiveAdicCorrection_higher_residue 3 1 2 3 2 3 (by omega) (by omega)
example : 5 ^ 3 ≤ cyclicResidueDistance (5 * 5 ^ 3) (4 * (5 ^ 3 * 1)) := by
  apply fiveAdic_top_distance
  norm_num
example : fiveAdicDigit 0 14 = 4 := by norm_num [fiveAdicDigit]
end LonelyRunner
```

Replay it from the repository root with:

```sh
export PATH="$HOME/.elan/bin:$PATH"
cat > /tmp/five_adic_final_probe.lean <<'EOF'
import LonelyRunner.FiveAdicFiltering
namespace LonelyRunner
#check fiveAdicCorrection_pos
#check fiveAdicCorrection_mod_five
#check fiveAdic_residue_decomposition
#check fiveAdicGoodDigit_distance
#check fiveAdicCorrection_selected_product
#check fiveAdicCorrection_selected_digit
#check fiveAdicCorrection_higher_residue
#check fiveAdic_top_residue
#check fiveAdic_top_distance
#print axioms fiveAdicCorrection_pos
#print axioms fiveAdicCorrection_mod_five
#print axioms fiveAdic_residue_decomposition
#print axioms fiveAdicGoodDigit_distance
#print axioms fiveAdicCorrection_selected_product
#print axioms fiveAdicCorrection_selected_digit
#print axioms fiveAdicCorrection_higher_residue
#print axioms fiveAdic_top_residue
#print axioms fiveAdic_top_distance
example : fiveAdicDigit 3 (fiveAdicCorrection 3 1 3 * (2 * (5 ^ 1 * 7))) =
    (fiveAdicDigit 3 (2 * (5 ^ 1 * 7)) + 3 * ((2 * 7) % 5)) % 5 := by
  exact fiveAdicCorrection_selected_digit 3 1 3 2 7 (by omega)
example : (fiveAdicCorrection 3 1 3 * (2 * (5 ^ 2 * 3))) % (5 * 5 ^ 3) =
    (2 * (5 ^ 2 * 3)) % (5 * 5 ^ 3) := by
  exact fiveAdicCorrection_higher_residue 3 1 2 3 2 3 (by omega) (by omega)
example : 5 ^ 3 ≤ cyclicResidueDistance (5 * 5 ^ 3) (4 * (5 ^ 3 * 1)) := by
  apply fiveAdic_top_distance
  norm_num
example : fiveAdicDigit 0 14 = 4 := by norm_num [fiveAdicDigit]
end LonelyRunner
EOF
lake env lean /tmp/five_adic_final_probe.lean
sha256sum LonelyRunner/FiveAdicFiltering.lean /tmp/five_adic_final_probe.lean
```

It completed in terminal session `27591`, exit `0`.  The probe printed exact
types and axiom reports for all nine declarations.  Each report uses only the
permitted subset of `propext`, `Classical.choice`, and `Quot.sound`.  It also
compiled fixed controls for the `A=2` selected coefficient, higher residue,
top-digit-four closed boundary, and `m=0`.  Probe SHA-256:
`a31d4360c794b74f15f6f6b94fd490a6ba021dc70c9f6740fd2c1e5e537f8b6a`.

Historical recovery: the initial first-four draft failed because it used an
unavailable `Nat.dvd_pow` name and attempted the Euclidean decomposition with
`omega`.  The repaired proof uses `dvd_pow_self`, `Nat.mod_mul`, and
`le_min_iff`.  The later higher-residue draft required a power-product
normalization before the final successful build.  These drafts were replaced
before the frozen source above.

This milestone intentionally excludes finite two-label avoidance, seeded
descent, carry work, decomposition adapters, and any five-runner assembly.

## Two-label avoidance completion

The frozen source now also proves `fiveAdic_avoid_two` by a symbolic `ZMod 5`
finite-union argument: each row contributes its two affine bad points, so the
union has cardinal at most four and a fifth residue remains.  The proof allows
empty and repeated labels and explicitly requires nonzero slopes modulo five.

Final source SHA-256 after this addition:
`d7924f06b0dcd9108e02a39beaea9ce089b64be97014819bb1dbc5ef38919e4d`.

`lake env lean LonelyRunner/FiveAdicFiltering.lean && lake build
LonelyRunner.FiveAdicFiltering` completed in terminal session `20703`, exit
`0`, with 3001 jobs.  The final probe below completed in session `63645`, exit
`0`; it prints the exact type and permitted axiom report, and compiles empty,
singleton, repeated-two-row, and zero-coefficient rejection controls.

```lean
import LonelyRunner.FiveAdicFiltering
namespace LonelyRunner
#check fiveAdic_avoid_two
#print axioms fiveAdic_avoid_two
example : ∃ k : Fin 5, ∀ i : Empty, 1 ≤ (0 + k.val * 0) % 5 ∧ (0 + k.val * 0) % 5 ≤ 3 := by
  exact fiveAdic_avoid_two (fun _ : Empty => 0) (fun _ => 0) (by simp) (by intro i; exact nomatch i)
example : ∃ k : Fin 5, ∀ i : Fin 1, 1 ≤ (0 + k.val * 1) % 5 ∧ (0 + k.val * 1) % 5 ≤ 3 := by
  exact fiveAdic_avoid_two (fun _ => 0) (fun _ => 1) (by norm_num) (by intro i h; norm_num at h)
example : ∃ k : Fin 5, ∀ i : Fin 2, 1 ≤ (![0,2] i + k.val * ![1,1] i) % 5 ∧ (![0,2] i + k.val * ![1,1] i) % 5 ≤ 3 := by
  exact fiveAdic_avoid_two ![0,2] ![1,1] (by norm_num) (by intro i h; fin_cases i <;> norm_num at h)
example : ¬ ∃ k : Fin 5, 1 ≤ (0 + k.val * 0) % 5 ∧ (0 + k.val * 0) % 5 ≤ 3 := by
  rintro ⟨k, hk⟩
  norm_num at hk
end LonelyRunner
```

Replay with `export PATH="$HOME/.elan/bin:$PATH"; lake env lean
/tmp/five_adic_avoid_probe.lean` after copying the embedded block to that path.
Earlier avoider drafts failed on the local `ZMod 5` field instance,
parenthesization of the second bad point, and card-sum normalization; all were
replaced before this successful build.

## Residue representative preparation

The frozen module adds `fiveAdicDigit_of_mod_eq` and
`fiveAdic_unit_representative`.  They show selected digits depend only on the
next-power residue and normalize any five-adic unit while preserving its
modulo-five class and every product residue.

The named module build completed in session `46689`, exit `0`, with 3001 jobs.
The exact universal-type/axiom/control probe completed in session `25491`,
exit `0`; all three checked declarations use only `propext`,
`Classical.choice`, and `Quot.sound`.  It covers raw `A=127,m=2`, `m=0`,
identical two rows `(q,s)=(0,1),(0,1)`, and distinct-q same-slope rows
`(0,1),(2,1)`.  The latter is not described as repeated rows.

```lean
import LonelyRunner.FiveAdicFiltering
namespace LonelyRunner
#check fiveAdic_avoid_two
#check fiveAdicDigit_of_mod_eq
#check fiveAdic_unit_representative
#print axioms fiveAdic_avoid_two
#print axioms fiveAdicDigit_of_mod_eq
#print axioms fiveAdic_unit_representative
example : fiveAdicDigit 2 127 = fiveAdicDigit 2 (127 % (5 * 5 ^ 2)) := by
  apply fiveAdicDigit_of_mod_eq
  simp
example : 0 < 127 % (5 * 5 ^ 2) ∧ 127 % (5 * 5 ^ 2) < 5 * 5 ^ 2 ∧
    ¬ 5 ∣ 127 % (5 * 5 ^ 2) ∧ (127 % (5 * 5 ^ 2)) % 5 = 127 % 5 ∧
      ∀ d : ℕ, ((127 % (5 * 5 ^ 2)) * d) % (5 * 5 ^ 2) = (127 * d) % (5 * 5 ^ 2) := by
  exact fiveAdic_unit_representative 2 127 (by norm_num)
example : fiveAdicDigit 0 4 = 4 := by norm_num [fiveAdicDigit]
example : ∃ k : Fin 5, ∀ i : Fin 2, 1 ≤ (![0,0] i + k.val * ![1,1] i) % 5 ∧ (![0,0] i + k.val * ![1,1] i) % 5 ≤ 3 := by
  exact fiveAdic_avoid_two ![0,0] ![1,1] (by norm_num) (by intro i h; fin_cases i <;> norm_num at h)
example : ∃ k : Fin 5, ∀ i : Fin 2, 1 ≤ (![0,2] i + k.val * ![1,1] i) % 5 ∧ (![0,2] i + k.val * ![1,1] i) % 5 ≤ 3 := by
  exact fiveAdic_avoid_two ![0,2] ![1,1] (by norm_num) (by intro i h; fin_cases i <;> norm_num at h)
end LonelyRunner
```

Replay by copying the embedded block to `/tmp/five_adic_prep_probe.lean` and
running `export PATH="$HOME/.elan/bin:$PATH"; lake env lean
/tmp/five_adic_prep_probe.lean`.

Final source SHA-256 after this preparation:
`9d189c14a0b1f9fe47bac8fea52954436bf98cca7b8f5136e8e8dd26e76ff6b7`.
Probe SHA-256: `c9d5450decaf0afb61c30ff0119668b7d7f219e61db14dbeb88e046091f306c4`.

## Layer filling adapter

`fiveAdic_fill_level` applies the symbolic two-label avoider to the subtype of
labels at a fixed level and transports its good residue pair through the
selected-digit identity.  It is the preparatory finite-label step only; no
seeded induction or bounded multiplier is introduced.

## Seeded unbounded descent

The source now adds the accepted, exact theorem
`fiveAdic_seeded_unbounded`.  It inducts on the unbounded cutoff `h`, keeping
the positive unit seed general.  At successor `r + 1`, it fills precisely
level `r` with `fiveAdic_fill_level`, applies the induction hypothesis at
cutoff `r` to `fiveAdicCorrection m r k * A`, and composes the resulting
residue equalities.  Levels above `r` use
`fiveAdicCorrection_higher_residue`; the newly filled level uses
`fiveAdicDigit_of_mod_eq`; the base case returns the seed.  No bounded
representative, `Fin 4` adapter, carry theorem, or claim about five total
runners is included.

The unused positivity hypothesis `hd` is deliberately retained because it is
part of the settled public contract and later adapters need that exact data.

Final source SHA-256:

```text
83bddfd3dd8b1874b5d54f3a96cc8f19cc59634c576f8ccac130b9ca33495df9  LonelyRunner/FiveAdicFiltering.lean
```

The complete reproducible probe is below.  It checks the declaration, prints
its axiom report, proves the full universal target type rather than only
checking its name, and compiles both an empty `h = 0` application with seed
`A = 2` and a nonempty seeded `A = 2` lower-level application.

```lean
import LonelyRunner.FiveAdicFiltering
namespace LonelyRunner
#check fiveAdic_seeded_unbounded
#print axioms fiveAdic_seeded_unbounded
example {I : Type*} [Fintype I] [DecidableEq I] (d ell u : I → Nat) (m h A : Nat)
    (hd : ∀ i, 0 < d i) (hdecomp : ∀ i, d i = 5 ^ (ell i) * u i)
    (hu : ∀ i, ¬ 5 ∣ u i) (hell : ∀ i, ell i ≤ m) (hh : h ≤ m)
    (hApos : 0 < A) (hAunit : ¬ 5 ∣ A)
    (hcard : ∀ j, j < h → (Finset.univ.filter fun i => ell i = j).card ≤ 2)
    (hhigh : ∀ i, h ≤ ell i → 5 ^ m ≤ cyclicResidueDistance (5 * 5 ^ m) (A * d i)) :
    ∃ B : Nat, 0 < B ∧ ¬ 5 ∣ B ∧ B % 5 = A % 5 ∧
      (∀ i, h ≤ ell i → (B * d i) % (5 * 5 ^ m) = (A * d i) % (5 * 5 ^ m)) ∧
      (∀ i, ell i < h → FiveAdicGoodDigit m (B * d i)) ∧
      (∀ i, 5 ^ m ≤ cyclicResidueDistance (5 * 5 ^ m) (B * d i)) :=
  fiveAdic_seeded_unbounded d ell u m h A hd hdecomp hu hell hh hApos hAunit hcard hhigh
example := fiveAdic_seeded_unbounded (fun i : Empty => nomatch i) (fun i => nomatch i)
  (fun i => nomatch i) 0 0 2 (by intro i; exact nomatch i)
  (by intro i; exact nomatch i) (by intro i; exact nomatch i)
  (by intro i; exact nomatch i) (by omega) (by norm_num) (by norm_num)
  (by intro j hj; omega) (by intro i; exact nomatch i)
example : ∃ B : Nat, 0 < B ∧ ¬ 5 ∣ B ∧ B % 5 = 2 % 5 ∧
    (∀ i : Fin 1, 1 ≤ (![0] i : Nat) → (B * (![1] i : Nat)) % (5 * 5 ^ 1) = (2 * (![1] i : Nat)) % (5 * 5 ^ 1)) ∧
    (∀ i : Fin 1, (![0] i : Nat) < 1 → FiveAdicGoodDigit 1 (B * (![1] i : Nat))) ∧
    (∀ i : Fin 1, 5 ^ 1 ≤ cyclicResidueDistance (5 * 5 ^ 1) (B * (![1] i : Nat))) := by
  apply fiveAdic_seeded_unbounded ![1] ![0] ![1] 1 1 2
  · intro i; fin_cases i; norm_num
  · intro i; fin_cases i; norm_num
  · intro i h; fin_cases i; norm_num at h
  · intro i; fin_cases i; norm_num
  · omega
  · norm_num
  · norm_num
  · intro j hj
    have hj0 : j = 0 := by omega
    subst j
    decide
  · intro i hi
    fin_cases i
    norm_num at hi
end LonelyRunner
```

Replay it as `/tmp/five_adic_seeded_probe.lean` with:

```sh
export PATH="$HOME/.elan/bin:$PATH"
lake env lean /tmp/five_adic_seeded_probe.lean
lake build LonelyRunner.FiveAdicFiltering
sha256sum LonelyRunner/FiveAdicFiltering.lean /tmp/five_adic_seeded_probe.lean
```

Actual terminal outcome: the probe exited `0`; `#print axioms` reported only
`propext`, `Classical.choice`, and `Quot.sound`.  The named module build also
exited `0` (3001 jobs).  Its sole warning is Lean's unused-variable linter for
the contract-preserved `hd` hypothesis.  Probe SHA-256:

```text
832598f5a9a75c28caa6a4656822d8660aa71aace3614b7c9c34e3bbd36a90f0  /tmp/five_adic_seeded_probe.lean
```

Saved source checked in session `58248`, exit `0`; named build completed in
session `4295`, exit `0` with 3001 jobs.  The final universal explicit-type,
axiom, empty-domain, and two-label application probe completed in session
`37890`, exit `0`.  The axiom report is exactly `propext`,
`Classical.choice`, and `Quot.sound`.

```lean
import LonelyRunner.FiveAdicFiltering
namespace LonelyRunner
#check fiveAdic_fill_level
#print axioms fiveAdic_fill_level
example {I : Type*} [Fintype I] [DecidableEq I] (d ell u : I → ℕ) (m r A : ℕ)
    (hr : r ≤ m) (hdecomp : ∀ i, d i = 5 ^ ell i * u i)
    (hu : ∀ i, ¬ 5 ∣ u i) (hA : ¬ 5 ∣ A)
    (hcard : (Finset.univ.filter fun i => ell i = r).card ≤ 2) :
    ∃ k : Fin 5, ∀ i, ell i = r → FiveAdicGoodDigit m (fiveAdicCorrection m r k.val * (A * d i)) :=
  fiveAdic_fill_level d ell u m r A hr hdecomp hu hA hcard
example := fiveAdic_fill_level (fun i : Empty => nomatch i) (fun i => nomatch i) (fun i => nomatch i) 0 0 1 (by omega) (by intro i; exact nomatch i) (by intro i; exact nomatch i) (by norm_num) (by simp)
example : ∃ k : Fin 5, ∀ i : Fin 2, (![0,0] i : ℕ) = 0 → FiveAdicGoodDigit 1 (fiveAdicCorrection 1 0 k.val * (1 * (![1,1] i : ℕ))) := by
  exact fiveAdic_fill_level ![1,1] ![0,0] ![1,1] 1 0 1 (by omega) (by intro i; fin_cases i <;> norm_num) (by intro i h; fin_cases i <;> norm_num at h) (by norm_num) (by decide)
end LonelyRunner
```

Replay by copying the embedded block to `/tmp/five_adic_fill_probe.lean` and
running `export PATH="$HOME/.elan/bin:$PATH"; lake env lean
/tmp/five_adic_fill_probe.lean`.

Final source SHA-256: `ad686ffdeba6eb545530b8f2eb673a6f87a3ea1709ed9942acfc9822a9424a5b`.
Probe SHA-256: `584aee3b11eb762eaa7c07417bcc11206cc13150f7fe657a6582dde607dae5cd`.

## Bounded wrappers

`fiveAdic_seeded_multiplier` reduces the unbounded seed witness modulo
`5 * 5^m` using `fiveAdic_unit_representative`; product residues compose,
selected digits transfer through `fiveAdicDigit_of_mod_eq`, and the distance
statement follows by unfolding its residue definition.  The public
`exists_five_adic_filtered_multiplier` instantiates it at `h=m,A=1`; labels
at the top are discharged by `fiveAdic_top_distance`.  These wrappers add no
Fin 4, maximum-attainment, nonempty, injectivity, gcd, or ordering premise.

Final source SHA-256: `1a210e70383e9b00d1a3aec321e9e1a838efcd26c24ca180101964e8c6e71429`.
The complete probe is `/tmp/five_adic_bounded_probe.lean` below; it includes
full universal type examples for both declarations, their axiom reports, an
empty `h=0,A=2` seeded application, and an `m=0` repeated three-top-label
application.

```lean
import LonelyRunner.FiveAdicFiltering
namespace LonelyRunner
#check fiveAdic_seeded_multiplier
#check exists_five_adic_filtered_multiplier
#print axioms fiveAdic_seeded_multiplier
#print axioms exists_five_adic_filtered_multiplier
example {I : Type*} [Fintype I] [DecidableEq I] (d ell u : I → Nat) (m h A : Nat)
    (hd : ∀ i, 0 < d i) (hdecomp : ∀ i, d i = 5 ^ (ell i) * u i)
    (hu : ∀ i, ¬ 5 ∣ u i) (hell : ∀ i, ell i ≤ m) (hh : h ≤ m)
    (hApos : 0 < A) (hAunit : ¬ 5 ∣ A)
    (hcard : ∀ j, j < h → (Finset.univ.filter fun i => ell i = j).card ≤ 2)
    (hhigh : ∀ i, h ≤ ell i → 5 ^ m ≤ cyclicResidueDistance (5 * 5 ^ m) (A * d i)) :
    ∃ lam : Nat, 0 < lam ∧ lam < 5 * 5 ^ m ∧ ¬ 5 ∣ lam ∧ lam % 5 = A % 5 ∧
      (∀ i, h ≤ ell i → (lam * d i) % (5 * 5 ^ m) = (A * d i) % (5 * 5 ^ m)) ∧
      (∀ i, ell i < h → FiveAdicGoodDigit m (lam * d i)) ∧
      (∀ i, 5 ^ m ≤ cyclicResidueDistance (5 * 5 ^ m) (lam * d i)) :=
  fiveAdic_seeded_multiplier d ell u m h A hd hdecomp hu hell hh hApos hAunit hcard hhigh
example {I : Type*} [Fintype I] [DecidableEq I] (d ell u : I → Nat) (m : Nat)
    (hd : ∀ i, 0 < d i) (hdecomp : ∀ i, d i = 5 ^ ell i * u i)
    (hu : ∀ i, ¬ 5 ∣ u i) (hell : ∀ i, ell i ≤ m)
    (hcard : ∀ j, j < m → (Finset.univ.filter fun i => ell i = j).card ≤ 2) :
    ∃ lam : Nat, 0 < lam ∧ lam < 5 * 5 ^ m ∧ lam % 5 = 1 ∧ ¬ 5 ∣ lam ∧
      (∀ i, ell i < m → FiveAdicGoodDigit m (lam * d i)) ∧
      (∀ i, ell i = m → (lam * d i) % (5 * 5 ^ m) = d i % (5 * 5 ^ m)) ∧
      (∀ i, 5 ^ m ≤ cyclicResidueDistance (5 * 5 ^ m) (lam * d i)) :=
  exists_five_adic_filtered_multiplier d ell u m hd hdecomp hu hell hcard
example := fiveAdic_seeded_multiplier (fun i : Empty => nomatch i) (fun i => nomatch i)
  (fun i => nomatch i) 0 0 2 (by intro i; exact nomatch i) (by intro i; exact nomatch i)
  (by intro i; exact nomatch i) (by intro i; exact nomatch i) (by omega) (by norm_num)
  (by norm_num) (by intro j hj; omega) (by intro i; exact nomatch i)
example : ∃ lam : Nat, 0 < lam ∧ lam < 5 * 5 ^ 0 ∧ lam % 5 = 1 ∧ ¬ 5 ∣ lam ∧
    (∀ i : Fin 3, (![0,0,0] i : Nat) < 0 → FiveAdicGoodDigit 0 (lam * (![1,1,1] i : Nat))) ∧
    (∀ i : Fin 3, (![0,0,0] i : Nat) = 0 → (lam * (![1,1,1] i : Nat)) % (5 * 5 ^ 0) = (![1,1,1] i : Nat) % (5 * 5 ^ 0)) ∧
    (∀ i : Fin 3, 5 ^ 0 ≤ cyclicResidueDistance (5 * 5 ^ 0) (lam * (![1,1,1] i : Nat))) := by
  apply exists_five_adic_filtered_multiplier ![1,1,1] ![0,0,0] ![1,1,1] 0
  · intro i; fin_cases i <;> norm_num
  · intro i; fin_cases i <;> norm_num
  · intro i h; fin_cases i <;> norm_num at h
  · intro i; fin_cases i <;> norm_num
  · intro j hj; omega
end LonelyRunner
```

Replay: `export PATH="$HOME/.elan/bin:$PATH"; lake env lean
/tmp/five_adic_bounded_probe.lean; lake build LonelyRunner.FiveAdicFiltering`.
Actual outcome: both commands exited 0; both axiom reports were exactly
`[propext, Classical.choice, Quot.sound]`.  The named build retained only the
existing unused-`hd` contract warning.  Probe SHA-256:
`d3c549bf059da1c4c684d160ed9cc6d7d9ba95225382af8eba2e13975623449d`.
