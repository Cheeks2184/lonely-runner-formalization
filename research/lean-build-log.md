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

## 2026-08-02: deterministic witness bridge and soft-chain frontier

The clean ext4 checkout was advanced to commit `e4ece99`. The root build,
including the completed modular witness bridge and the new threshold-layer
module, reported:

```text
Build completed successfully (3530 jobs).
```

`lake env lean LonelyRunner/AxiomAudit.lean` completed successfully. The new
order-credit avoidance/witness declarations, threshold-layer loss identities,
budgeted peeling theorem, and critical-core contrapositive all report only
`[propext, Classical.choice, Quot.sound]`.

The complete exact Python regression suite reported:

```text
Ran 104 tests in 249.672s
OK
```

The added chain-block regression exhaustively recomputes the nested
`B_1,B_2,B_3` values and all stress rows. Separately, the complete primitive
ten-speed scan through maximum `22` enumerated `646,646` increasing tuples,
retained `646,635` primitive tuples, and found no unrestricted all-pivot
failure; its minimum best margin was `+4` on fourteen tuples. The independent
run took 1,690.90 seconds and matched the committed expected output exactly.

A source scan found no `sorry`, `admit`, custom `axiom`, `opaque`, `unsafe`,
`extern`, `implemented_by`, `partial_fixpoint`, `native_decide`, or disabled
checks. Both the main worktree and clean checkout were empty after
verification.

## 2026-08-02: block peeling and the exact CHAIN3 scope guard

The clean ext4 checkout was fast-forwarded to commit `d7b897a`. Scoped checks
first compiled `BlockPeeling.lean` and `Chain3Counterexample.lean` separately.
The concrete witness module initially exposed a syntactic rewrite mismatch
between two elaborated rational denominators; replacing it with an explicit
`calc` normalization repaired the goal without adding an assumption. The root
build then reported:

```text
Build completed successfully (3532 jobs).
```

The complete axiom audit passed. In particular, the four new repeated-block
theorems and `chain3Counterexample_directWitness` each report exactly:

```text
[propext, Classical.choice, Quot.sound]
```

The full exact Python regression suite, including the independent CHAIN3
counterexample verifier, reported:

```text
Ran 107 tests in 133.152s
OK
```

The clean-room counterexample script separately reproduced all nine pivot
rows, every `B3=b3(8)+b3(5)+b2(2)` component, the pivot-`15` optimum, strict
endpoints, candidate exclusion, and the exact `13/80` witness. A tracked Lean
scan found no `sorry`, `admit`, custom `axiom`, `opaque`, `unsafe`, `extern`,
`implemented_by`, `partial_fixpoint`, `native_decide`, or disabled checks.
Both the main worktree and the verification checkout were clean after these
commands.

## 2026-08-02: Bellman duality and rejection of optimized additive uniformity

The clean ext4 checkout was fast-forwarded to commit `f4da966`. Scoped builds
first checked `BellmanPeeling.lean` and `OptAddCounterexample.lean`; the root
build then reported:

```text
Build completed successfully (3534 jobs).
```

`BellmanPeeling.lean` kernel-checks weak duality for arbitrary finite states,
the exact recursive optimum, feasibility, attainment, minimum-order
characterization, and greatest-feasible-potential characterization.
`OptAddCounterexample.lean` independently proves the exact `13/160` witness
for the all-pivot additive counterexample. All new axiom probes report exactly

```text
[propext, Classical.choice, Quot.sound].
```

The complete exact regression suite, now including the clean-room exhaustive
OPT-ADD counterexample oracle and whole-overlap capacity certificate, reported:

```text
Ran 112 tests in 158.036s
OK
```

The counterexample test compares the subset DP with all `362,880` pivot-order
pairs. The capacity test reconstructs all 24 whole token-parent blocks and
every used residue capacity. A tracked Lean scan found no `sorry`, `admit`,
custom `axiom`, `opaque`, `unsafe`, `extern`, `implemented_by`,
`partial_fixpoint`, `native_decide`, or disabled checks. Both the main
worktree and clean checkout were empty after verification.

## 2026-08-02: correlation polynomial, weighted bridge, and obstruction audits

The cached clean ext4 checkout was fast-forwarded to commit `c8377d3`. The
root build, now including `CorrelationPolynomial.lean` and
`WeightedZeroCount.lean`, reported:

```text
Build completed successfully (3537 jobs).
```

The complete axiom audit passed. The polynomial prefix identity, cleared
nonpositivity theorem, rational zero-indicator bound, candidate-slice double
count, positive-weight guarded summation theorem, and combined weighted bridge
all report only:

```text
[propext, Classical.choice, Quot.sound]
```

The full exact regression suite, including the common-LCM histogram audit,
direct generalized-CRT low-moment evaluator, consecutive-speed infinite-
obstruction checks, and whole-block packing replays, reported:

```text
Ran 124 tests in 171.716s
OK
```

The direct CRT evaluator reproduces `G`'s first five moments without
constructing a safe set or full multiplicity histogram. The obstruction tests
check every admissible depth for `4<=n<=35` as finite regression evidence;
the documented infinite conclusions use separate proved inequalities. A Lean
source scan found no `sorry`, `admit`, custom `axiom`, `opaque`, `unsafe`,
`extern`, `implemented_by`, `partial_fixpoint`, `native_decide`, or disabled
checks. Both the main worktree and the clean verification checkout were empty
at commit `c8377d3179584301c0061b4c1eb9d76481189c29` before this log update.

## 2026-08-02: optimized moments and consecutive adaptive depth

The clean ext4 checkout was fast-forwarded through source commit `192f601`.
The root build, including the new abstract consecutive-obstruction kernel,
reported:

```text
Build completed successfully (3538 jobs).
```

`ConsecutiveCorrelationObstruction.lean` proves the ordinary and weighted
hockey-stick identities, denominator-cleared correlation debt, and the
abstract histogram bound

```text
sum_k D_k W_(n,d)(k)
  <= (n-1)D_0 - 2*C(n-1,2d+1)
```

under explicit zero-mass and two-incidence hypotheses. The new axiom probes
report only `[propext, Classical.choice, Quot.sound]`; no arithmetic histogram
or LRC assertion is encoded.

The enlarged exact regression suite includes rational primal/dual moment-LP
certificates, the infinite fixed-order obstruction checks, and the exact
adaptive-depth scan. It reported:

```text
Ran 133 tests in 169.732s
OK
```

Independent adversarial audits accepted the LP vertex classification,
low-totient fixed-order theorem, high-layer rigidity, depth-one debt constants,
near-cutoff evaluations, and infinite cutoff-gap branches. Source files after
`192f601` changed documentation only; the formal and computational artifacts
tested here are identical at the subsequent integration commit.
