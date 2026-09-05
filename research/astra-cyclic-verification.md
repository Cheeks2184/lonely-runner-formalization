# Cyclic affine-band verification

Frozen source: `LonelyRunner/AffineGridCyclic.lean`, SHA-256
`b4b42a0dd0f00730c2fbd45814a362a7e30248c97c234fd4d7ed72c7bf521e4b`.

Root completed the routine worker's partial draft by correcting the staged
numerator rewrites and denominator/cast normalization. No theorem hypothesis
or conclusion changed. Fresh source compilation passed, followed by a targeted
1,842-job build. The independent mathematical source review is separate.

Root completed and executed the entire seven-example block below with
`PATH="$HOME/.elan/bin:$PATH" lake env lean --stdin` on 2026-09-05; exit code 0.
It checks the public type and prints exactly the permitted axiom set:
`[propext, Classical.choice, Quot.sound]`. All finite hypotheses use ordinary
kernel-checked `decide`; there is no external computational trust shortcut.

The examples cover a wrapped numerator 54 (remainder 19 modulo 35), a
multiple-wrap numerator 194 (the same remainder), closed lower and upper
endpoints 98 and 588 for N=7,M=98, composite N=9 with numerator146/remainder47,
a negative example below the lower threshold, and the exact N=2 half-distance
endpoint. Every displayed numeral is cast from Nat to avoid ambiguous
elaboration in the concrete goals.

```lean
import LonelyRunner.AffineGridCyclic
open LonelyRunner
#check circleNorm_affine_grid_iff_modular_band
#print axioms circleNorm_affine_grid_iff_modular_band

example : ((5 : ℕ) : ℝ)⁻¹ ≤ circleNorm ((((3 : ℕ) : ℝ) / ((5 : ℕ) : ℝ) + ((4 : ℕ) : ℝ) / ((7 : ℕ) : ℝ)) * ((9 : ℕ) : ℝ)) := by
  exact (circleNorm_affine_grid_iff_modular_band 5 7 3 1 4 13 2 9
    (by decide) (by decide) (by decide) (by decide) (by decide)).mpr (by decide)

example : ((5 : ℕ) : ℝ)⁻¹ ≤ circleNorm ((((3 : ℕ) : ℝ) / ((5 : ℕ) : ℝ) + ((18 : ℕ) : ℝ) / ((7 : ℕ) : ℝ)) * ((9 : ℕ) : ℝ)) := by
  exact (circleNorm_affine_grid_iff_modular_band 5 7 3 1 18 83 2 9
    (by decide) (by decide) (by decide) (by decide) (by decide)).mpr (by decide)

example : ((7 : ℕ) : ℝ)⁻¹ ≤ circleNorm ((((6 : ℕ) : ℝ) / ((7 : ℕ) : ℝ) + ((30 : ℕ) : ℝ) / ((98 : ℕ) : ℝ)) * ((7 : ℕ) : ℝ)) := by
  exact (circleNorm_affine_grid_iff_modular_band 7 98 6 2 30 14 7 7
    (by decide) (by decide) (by decide) (by decide) (by decide)).mpr (by decide)

example : ((7 : ℕ) : ℝ)⁻¹ ≤ circleNorm ((((6 : ℕ) : ℝ) / ((7 : ℕ) : ℝ) + ((30 : ℕ) : ℝ) / ((98 : ℕ) : ℝ)) * ((42 : ℕ) : ℝ)) := by
  exact (circleNorm_affine_grid_iff_modular_band 7 98 6 2 30 14 42 42
    (by decide) (by decide) (by decide) (by decide) (by decide)).mpr (by decide)

example : ((9 : ℕ) : ℝ)⁻¹ ≤ circleNorm ((((2 : ℕ) : ℝ) / ((9 : ℕ) : ℝ) + ((5 : ℕ) : ℝ) / ((11 : ℕ) : ℝ)) * ((14 : ℕ) : ℝ)) := by
  exact (circleNorm_affine_grid_iff_modular_band 9 11 2 1 5 34 3 14
    (by decide) (by decide) (by decide) (by decide) (by decide)).mpr (by decide)

example : ¬ (((5 : ℕ) : ℝ)⁻¹ ≤ circleNorm ((((0 : ℕ) : ℝ) / ((5 : ℕ) : ℝ) + ((1 : ℕ) : ℝ) / ((7 : ℕ) : ℝ)) * ((1 : ℕ) : ℝ))) := by
  intro h
  have q := (circleNorm_affine_grid_iff_modular_band 5 7 0 0 1 5 1 1
    (by decide) (by decide) (by decide) (by decide) (by decide)).mp h
  norm_num at q

example : ((2 : ℕ) : ℝ)⁻¹ ≤ circleNorm ((((1 : ℕ) : ℝ) / ((2 : ℕ) : ℝ) + ((0 : ℕ) : ℝ) / ((3 : ℕ) : ℝ)) * ((1 : ℕ) : ℝ)) := by
  exact (circleNorm_affine_grid_iff_modular_band 2 3 1 0 0 0 1 1
    (by decide) (by decide) (by decide) (by decide) (by decide)).mpr (by decide)
```

These checks validate the fixed equivalence source. They establish no family
supply theorem, explicit forbidden-set characterization or unrestricted LRC
conclusion. This note replaces the incomplete two-example worker draft; all
seven examples above were actually compiled together by root.
