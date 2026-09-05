# Nearest actual-pivot grid formalization

Task `/root/nearest_grid_formal`, 2026-09-05.  This file records the
kernel-checked implementation of the settled Section 1 transport contract in
`research/astra-nearest-grid-induction.md`, frozen source checkpoint
`1f6d97ac0eda4683fccb1b815f58621bfc9bd3c9fc0c477fd16bbcecf67f6997`.
It is an auxiliary conditional transport lemma only; it does not assert an
unconditional Lonely Runner Conjecture result, a cardinality bound, or an
induction premise.

## Checked declaration

`LonelyRunner.exists_nearestPivotGrid_residue` has the following checked type:

```lean
{ι : Type u} → [Fintype ι] →
(N p : Nat) → 2 ≤ N → 0 < p → (d : ι → Nat) → (t alpha : Real) →
alpha ≤ circleNorm (t * p) →
(∀ i, alpha ≤ circleNorm (t * d i)) →
(2 * (N : Real))⁻¹ < alpha →
(∀ i, (N : Real)⁻¹ ≤ alpha - d i / (2 * (N * p : Nat))) →
∃ r ∈ pivotCandidates N p,
  (∀ i, r ∉ pivotBadResidues N p (d i)) ∧
  (N : Real)⁻¹ ≤ circleNorm ((r / (N * p)) * p) ∧
  ∀ i, (N : Real)⁻¹ ≤ circleNorm ((r / (N * p)) * d i)
```

All displayed naturals inside real expressions are coerced to `Real`; the
exact elaborated type was obtained with `#check`.  The formal theorem is
stronger than Section 1's lower-owner specialization: no `0 < d i < p`
assumption is needed.  Its finite index type remains explicit, and every
coordinate margin remains an explicit hypothesis.

The proof rounds the signed real `N*p*t`, proves the rounded integer is not
divisible by `N` from the strict pivot margin, reduces it with `Int.natMod`,
and uses `Int.ediv_mul_add_emod` plus `circleNorm_add_int` to transfer each
coordinate.  It then invokes the existing strict-bad-set conversion
`not_mem_pivotBadResidues_iff_circleNorm_ge` and the pivot conversion
`pivot_circleNorm_ge`.  Thus equality in a coordinate margin yields the
closed target boundary as required.

## Reproducibility

The source file is `LonelyRunner/NearestPivotGrid.lean`.  The exact commands
used with the project-pinned Lean 4.32.1 toolchain were:

```bash
PATH=/home/joshua/.elan/bin:$PATH lake build LonelyRunner.NearestPivotGrid
printf '%s\n' 'import LonelyRunner.NearestPivotGrid' \
  '#check LonelyRunner.exists_nearestPivotGrid_residue' \
  '#print axioms LonelyRunner.exists_nearestPivotGrid_residue' | \
  PATH=/home/joshua/.elan/bin:$PATH lake env lean /dev/stdin
rg -n '\bsorry\b|\badmit\b|native_decide|axiom' LonelyRunner/NearestPivotGrid.lean
sha256sum LonelyRunner/NearestPivotGrid.lean
```

The build passed.  The axiom report for the public declaration was exactly
`[propext, Classical.choice, Quot.sound]`.  The source-trust scan returned no
matches.  Final SHA-256 of `LonelyRunner/NearestPivotGrid.lean`:

```text
ca5f8c1eb511a5be14d3eb50c887421ac7efa96426beb5135c0693a76b4f497b
```

## Scope boundary

This artifact neither imports the root aggregator nor `AxiomAudit`, and it
does not alter shared workflow state or Git metadata.  It supplies no witness
for arbitrary speed families: callers must provide the original witness,
strict pivot margin, and every coordinate's quantitative margin.
