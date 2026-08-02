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

## 2026-08-01: structured classes and modular certificates

The audited changes were committed as
`c58f4fc8885a5abbd9f4aabf0399313b04dac25f` and cloned into the previously
absent Linux-native directory
`/home/joshu/code/lonely-runner-clean-checkout-round5-c58f4fc`. No build output
was inherited from the working tree. After `lake update` and
`lake exe cache get`, the authoritative command reported:

```text
Build completed successfully (1847 jobs).
```

`lake env lean LonelyRunner/AxiomAudit.lean` checked the new residue-band and
five modular finite-set declarations in addition to the existing development.
Every printed declaration used exactly:

```text
[propext, Classical.choice, Quot.sound]
```

The clean checkout also passed all 16 Python tests. The three primitive
speed-30 commands reproduced all table entries with zero bad-count formula
mismatches. A tracked-Lean-source scan found no `sorry`, `admit`, custom
`axiom`, explicit `opaque`, `unsafe`, `extern`, `implemented_by`,
`partial_fixpoint`, disabled check, or `native_decide`. `git status --short`
was empty.

A preliminary build on `/mnt/c` was deliberately terminated after final source
edits made its already-running dependency pass stale. The clean Linux-native
clone above is the authoritative result.

## 2026-08-01: exact boundary-to-pivot equivalence

The Linux-native verification checkout was advanced to commit
`9e3c5c2` and checked from
`/home/joshu/code/lonely-runner-clean-checkout-round5-c58f4fc`. The root build
reported:

```text
Build completed successfully (1857 jobs).
```

`lake env lean LonelyRunner/AxiomAudit.lean` included the new exact residue
lemmas, boundary witness, canonical pivot reduction, and global
positive-integer certificate equivalence. Every probe reported only:

```text
[propext, Classical.choice, Quot.sound]
```

The subsequent full `lake build` also completed successfully. After adding the
independent Fourier regression audit, all 23 Python tests passed and the
default Fourier script checked 120,060 coefficients. The tracked Lean scan found no `sorry`, `admit`,
custom axiom, or disabled check, and the verification checkout remained clean.
An independent formal audit separately checked `n=0` exclusion, `N=n+1`, the
`N=2` signed endpoint, strict bad-set boundaries, Euclidean normalization, and
the forward/reverse quantifiers without finding a gap.

## 2026-08-01: pivot counts, normalization, and divisor insertion

The clean Linux-native checkout was advanced to
`601bb4b6483939c8751f8b0afc1a4e3e4068ec45`. From
`/home/joshu/code/lonely-runner-clean-checkout-round5-c58f4fc`, the final
commands reported:

```text
Build completed successfully (1856 jobs).
Ran 22 tests in 5.815s
OK
```

The new audited Lean layer includes fixed-instance sign/common-scale
normalization, the full two-moving-runner case, the modular pivot residue
bridge, the exact strict bad-set gcd/ceiling formula, and conditional
codimension-one divisor insertion. `AxiomAudit.lean` printed exactly

```text
[propext, Classical.choice, Quot.sound]
```

for every declaration, including `card_pivotBadResidues_exact` and
`codimensionOneDivisorInsertion`. An adversarial audit compared the former
against 45,450 literal modular sets with zero mismatches and separately checked
the latter's factorization, Bézout signs, casts, old-phase preservation,
threshold indices, and equality endpoint.

The Python suite independently compares the bounded-parent dynamic program
with exhaustive permutation search, the pair-sum spectrum with the exact
piecewise-linear optimizer on 784 tuples, and both eight-speed two-parent
failures with their three-parent witnesses. A tracked Lean-source scan found no
`sorry`, `admit`, custom `axiom`, or disabled checks. The verification checkout
had empty `git status --short` after all commands.

## Earlier 2026-08-01 baseline clean-checkout verification

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

## 2026-08-01: pivot target fibers and rejected GCD-clock uniformity

The Linux-native clean checkout was fast-forwarded to commit `06b0358` and
verified from
`/home/joshu/code/lonely-runner-clean-checkout-round5-c58f4fc`. The root build
reported:

```text
Build completed successfully (3520 jobs).
```

`lake env lean LonelyRunner/AxiomAudit.lean` included the strict pivot-target
decomposition, transferred natural simultaneous-congruence count, and exact
pair-overlap sum. Every probe again reported only
`[propext, Classical.choice, Quot.sound]`. An independent adversarial audit
also compiled the module at `--trust=0`, checked the principal identities
exhaustively in small boxes, and found no endpoint, canonical-target, or
multiplication-order gap.

All 49 exact Python regressions passed. The new regression independently
recomputed all nine negative GCD-clock margins for
`(8,15,35,40,48,56,63,75,78)`, its strict additive pivot-8 certificate, and
the explicit `t=13/80` circle distances. A project-source scan found no
`sorry`, `admit`, `unsafe`, or custom `axiom`; the clean checkout status was
empty after verification.

## 2026-08-01: completed pair-fiber subtraction bridge

The clean checkout was advanced to `48f4dee`. The authoritative commands
reported:

```text
Build completed successfully (3520 jobs).
Ran 50 tests in 5.255s
OK
```

The expanded axiom audit covers the explicit `q -> N*q` image bijection,
conditional divisible count, exact candidate count, raw-minus-divisible
overlap sum, and closed exact overlap sum. Every declaration reports only
`[propext, Classical.choice, Quot.sound]`.

An independent adversarial audit also compiled the completed module and the
full audit with `--trust=0`. Direct exhaustive checks covered 1,002,001
canonical pair-fiber/count instances, 247,779 scaling-image instances, and
the corresponding strict-ball overlap sums. They found no modular-
cancellation, truncated-subtraction, target-bound, zero-modulus, endpoint, or
summation gap. A noncanonical-target mismatch was exhibited separately,
confirming that the bounds present in the formal theorems are necessary.

## 2026-08-01: relocation, two-level, and triple-congruence frontier

The Linux-native clean checkout was advanced to commit `0009cf0` and verified
from `/home/joshu/code/lonely-runner-clean-checkout-round5-c58f4fc`. The root
build reported:

```text
Build completed successfully (3523 jobs).
Ran 61 tests in 15.612s
OK
```

The new kernel-checked layer includes generic finite relocation descent and
its exact prefix-dependent block identity; selected-earlier-parent two-level
ordered-union avoidance; exact raw three-equation compatibility/cardinality;
and the complete pivot-candidate triple subtraction and target-cell interface.
The expanded `AxiomAudit.lean` covers all of these declarations, and every
probe reports only `[propext, Classical.choice, Quot.sound]`.

Independent exact tests reproduce the two-sided relocation local minima,
reject left-only descent, verify every repaired three-anchor cost vector,
exhibit the minimal clause/triangle LP integrality gap, and reproduce every
anchor-star rational value and divisor identity. Complete anchor-star scans
cover 479 primitive four-speed tuples through 12, 2,981 five-speed tuples
through 15, and 923 six-speed tuples through 12, with no bounded failure and
no unbounded inference. A project-source scan found no `sorry`, `admit`,
custom `axiom`, `opaque`, `unsafe`, `extern`, `implemented_by`,
`partial_fixpoint`, `native_decide`, or disabled checks. The verification
checkout remained clean.

## 2026-08-01: residual-profile, bounded-anchor, and acyclic-selector frontier

The Linux-native clean checkout was advanced through commit `12be8ff` and
verified from
`/home/joshu/code/lonely-runner-clean-checkout-round5-c58f4fc`. The root build
reported:

```text
Build completed successfully (3528 jobs).
```

The new kernel-checked layer includes fixed-anchor strict-average selection,
abstract cellwise dispersion algebra, pair-multiplicity and modular residue
energy identities, a conditional range-profile cut decomposition, the
fixed-row debt/loss polynomial decomposition, bounded-anchor cost monotonicity,
and both directions of the finite acyclic fiber-selector/order optimization
equivalence. `AxiomAudit.lean` covers the new declarations; every probe again
reports only `[propext, Classical.choice, Quot.sound]`.

The full exact Python suite reported:

```text
Ran 89 tests in 282.335s
OK
```

Independent literal oracles reproduce all rows of the exact counterexamples
to `RANGE-SUM-STAR`, `DISPERSION-STAR`, `ANCHOR-STAR`, and
`3-ANCHOR-UNIF`; each tuple retains a later certificate or direct lonely-time
witness. A separate implementation reconstructs the top-parent feedback-cycle
criterion and all eight reported stress rows. A project-source scan found no
`sorry`, `admit`, custom declaration `axiom`, `opaque`, `unsafe`, `extern`,
`implemented_by`, `partial_fixpoint`, or `native_decide`. The clean ext4
checkout remained clean after Lean verification.

## 2026-08-02: concrete modular selector and top-cycle rejection

The concrete modular selector commit `be9064f` was copied to the Linux-native
ext4 checkout and verified before any later documentation or Python-only
commits. The scoped module build completed 1,851 jobs, the full root build
completed 3,529 jobs, and `lake env lean LonelyRunner/AxiomAudit.lean` passed.
The two new selector probes reported only
`[propext, Classical.choice, Quot.sound]`. An independent adversarial Lean
review rebuilt the same 3,529-job root and reproduced those axiom reports.

After advancing the clean checkout through documentation commit `6dbd999`, a
fresh root build reported:

```text
Build completed successfully (3529 jobs).
```

The complete exact Python suite, now including the two independent
`TOP-CYCLE-UNIF` audits, reported:

```text
Ran 103 tests in 406.746s
OK
```

The new tuple `(5,28,35,40,68,88,108,148,165)` was additionally reconstructed
by a third clean-room oracle which exhaustively enumerated all `8!` orders at
all nine pivots. It reproduced every top-only and unrestricted optimum,
strict endpoint convention, and the direct `t=3/140` witness. A project-source
scan again found no `sorry`, `admit`, custom `axiom`, `opaque`, `unsafe`,
`extern`, `implemented_by`, `partial_fixpoint`, `native_decide`, or disabled
checks. Commits after `be9064f` changed only documentation and exact Python
audit material, not Lean source.
