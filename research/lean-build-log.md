# Lean build log

## 2026-08-01: statement foundation

Environment inspection found no `elan`, `lean`, or `lake` in Ubuntu 26.04.
The user-local official elan installer produced `elan 4.2.3`; the project then
selected Lean `4.32.1` and Lake `5.0.0-src+f054605` from `lean-toolchain`.
Mathlib is pinned by tag and resolved in `lake-manifest.json` to commit
`520045ab14e26149ee970e2e617ca04b09bde5d6`.

The first build found these source errors:

1. Lean 4.32 rejected an `import` following a module documentation command.
   Imports were moved to the first commands in all project Lean files.
2. `circleDistance` uses a noncomputable quotient metric instance. It was
   marked `noncomputable` explicitly.
3. A generic `map_neg` rewrite did not match a coerced real in `AddCircle`.
   It was replaced by the specific theorem `AddCircle.coe_neg`, followed by
   `norm_neg`.

After those repairs, a clean Linux-native verification mirror under
`/home/joshu/code/lonely-runner-verification` reported:

```text
✔ [1843/1845] Built LonelyRunner.RepeatedStationaryEquivalence
✔ [1844/1845] Built LonelyRunner
Build completed successfully (1845 jobs).
```

The axiom audit reported:

```text
LonelyRunner.lonelyAt_iff_relativeLonelyAt:
  [propext, Classical.choice, Quot.sound]
LonelyRunner.conjecture_iff_nonnegativeTimeConjecture:
  [propext, Classical.choice, Quot.sound]
LonelyRunner.conjecture_iff_relativeConjecture:
  [propext, Classical.choice, Quot.sound]
LonelyRunner.conjecture_iff_distinctStationaryConjecture:
  [propext, Classical.choice, Quot.sound]
LonelyRunner.distinctStationaryConjecture_iff_stationaryConjecture:
  [propext, Classical.choice, Quot.sound]
LonelyRunner.conjecture_iff_stationaryConjecture:
  [propext, Classical.choice, Quot.sound]
LonelyRunner.oneMovingRunner:
  [propext, Classical.choice, Quot.sound]
LonelyRunner.StationaryConjecture:
  [propext, Classical.choice, Quot.sound]
LonelyRunner.DistinctStationaryConjecture:
  [propext, Classical.choice, Quot.sound]
LonelyRunner.PositiveIntegerConjecture:
  [propext, Classical.choice, Quot.sound]
LonelyRunner.abs_circleNorm_sub_circleNorm_le:
  [propext, Classical.choice, Quot.sound]
LonelyRunner.exists_small_shift_circleNorm_ge:
  [propext, Classical.choice, Quot.sound]
LonelyRunner.fastRunnerInsertion:
  [propext, Classical.choice, Quot.sound]
```

These are standard Lean/mathlib logical foundations, not project-specific
axioms. The commands used for final verification were:

```sh
lake build
lake env lean LonelyRunner/AxiomAudit.lean
```

The first dependency setup directly under `/mnt/c` was exceptionally slow
while unpacking 8,639 cached mathlib artifacts. A subsequent authoritative
workspace build attempt hit the command's 124-second external timeout without
emitting a compiler error. The Linux-native mirror was used to distinguish
filesystem latency from source correctness.

The integrated 1845-job build above was rerun after adding both stationary
equivalence files and the composed canonical-to-repeated-stationary theorem.
The full axiom command succeeded again with exactly the three standard entries
shown above for every audited declaration. One orphaned `/mnt/c` Lake build was
terminated with `SIGTERM` after its working directory and process tree were
verified; it was only a redundant slow-filesystem compilation and no source
files were removed.

## 2026-08-01: clean-checkout verification

The staged repository was committed locally and cloned, rather than copied,
to `/home/joshu/code/lonely-runner-clean-checkout`. From that checkout, with no
project build directory inherited from the working tree, dependency hydration
was followed by:

```sh
lake build
lake env lean LonelyRunner/AxiomAudit.lean
python3 -m unittest discover -s tests -v
```

The clean checkout built all 1845 jobs. The axiom output was unchanged, all
nine Python tests passed, and `git status --short` was empty because the local
build directory is ignored. A forbidden-declaration scan found no source use
of `sorry`, `admit`, custom `axiom`, explicit `opaque`, `unsafe`, `extern`,
`implemented_by`, `partial_fixpoint`, or disabled `set_option`; the only text
match was the explanatory phrase "project-specific axiom" in the audit file's
module comment.
