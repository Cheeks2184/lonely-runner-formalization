# Lonely Runner formalization

Machine-assisted mathematical research and Lean 4 formalization concerning
the Lonely Runner Conjecture (LRC).

> **Unrestricted LRC has not been proved or disproved.** A declaration named
> `Conjecture` is a formal statement under investigation, not a completed
> proof. See [STATUS.md](STATUS.md) for the current boundary of knowledge.

Current research pipeline: Prompt76--78 are completed, recovered, and audited
at exact bridge-rejection scope. Prompt79--81 are completed and awaiting
recovery; Prompt81's captured response is an `INPUT-NOT-FROZEN` operational
failure, not a mathematical result. Prompt82 remains active Sol Pro research.
The accepted manuscript-level counterexamples reject only the frozen
private-deficit, signed-Gram, and sparse-cover bridge statements; each tuple
still has an exact pivot certificate, so none is an LRC counterexample.
Prompt76's recovered scans, Prompt77's 6,330-record scan, and Prompt78's
recovered computation remain unexecuted or independently unreplayed and are
not computed finite evidence. The machine-readable lifecycle source is
[`research/task-ledger.json`](research/task-ledger.json), whose PI decisions
are frozen at registry commit
`4fcc1d5614852fc609fd5b6dbbace4b5f835b14b`.

## Verified results

The project uses the standard closed circular-distance threshold. For `n`
moving runners, a witness time `t` must satisfy

```text
1/(n+1) <= ‖t*v_i‖_(R/Z)   for every i.
```

Fully Lean-verified results include:

- the canonical unrestricted real-speed statement and its nonnegative-time,
  relative-speed, stationary-runner, rational, and positive-integer
  formulations;
- the complete real-to-positive-integer reduction
  `conjecture_iff_positiveIntegerConjecture`;
- equivalence of the positive-integer conjecture with the exact finite
  pivot-certificate proposition;
- the one- and two-moving-runner base cases;
- several insertion, normalization, congruence, overlap, and structured-class
  theorems recorded in the [formal modules](LonelyRunner/);
- the bounded-height theorem `boundedHeight_stationary_witness`, covering
  positive injective integer speeds of maximum at most `n+2`;
- the stronger logarithmic bounded-height theorem: for `N=n+1` and `t>=1`,

  ```text
  (4*(Nat.log 2 N+1)+1)*t <= N
  ```

  and maximum speed at most `N+t` imply a common witness at the closed `1/N`
  threshold. `logarithmicHeightGain_positiveInteger_witness` supplies the
  explicit gain `N div (4*(Nat.log 2 N+1)+1)` using exactly the canonical
  `UnitCircle` norm.

`PrimorialHeight.lean` proves an exact unconditional bounded-height theorem.
Let `P_N` be the largest primorial at most `N` and `Q_N=phi(P_N)`. Lean proves
that `P_N/Q_N` is the maximum of `c/phi(c)` for `1<=c<=N`, in exact
cross-multiplied natural arithmetic. Therefore

```text
(4*P_N-Q_N)*t < N*Q_N
```

and maximum speed at most `N+t` imply a common closed `1/N` witness. The exact
largest integer gain is `(N*Q_N-1) div (4*P_N-Q_N)`. This is a verified
bounded-height result, not a proof of unrestricted LRC.

`KanoldVandermonde.lean` first gives the unconditional linear bound
`17*t<=3*N`; the coefficient-five and coefficient-four modules improve it;
`CoefficientThreeHeight.lean` is currently strongest. For
`speeds : Fin n -> Nat`, assume `n+1=N`, `t>0`, every speed is positive,
the speeds are injective, every speed is at most `N+t`, and

```text
3*t <= N.
```

Then `threeHeight_family_witness` gives one real time at which every speed has
closed circular distance at least `1/N`. The proof uses the Lean-verified
Kanold interval theorem. Under a hypothetical failure, every missing height
`c` in `[1,N]` must force the distinct occupied extra height `2*c`; the set of
missing base heights has cardinality one larger than the set of extra heights,
so this injection is impossible. Three small parameter pairs are repaired by
explicit reciprocal or complementary-hole witnesses. No number-theoretic
premise is assumed as an axiom. This remains a bounded-height theorem and does
not prove or disprove unrestricted LRC.

`CommonPivotBadCount.lean` verifies a separate nonsaturated top-two special
class. If the two top speeds are coprime-to-`N` multiples `alpha*g` and
`beta*g`, and the exact sum of lower-speed strict bad-set cardinalities on the
common `g`-grid is less than `g*(N-1)`, Lean constructs scaled canonical
certificates at both top pivots representing the same real time. This is a
conditional sufficient class, not the unrestricted top-two conjecture. The
declaration does not itself require the lower family to be distinct or below
those two speeds; a literal sorted top-two application must supply those outer
family facts separately.

`CoefficientTwoRectangle.lean` and `CoefficientTwoReversal.lean` verify the
elementary crossed-rectangle core of the coefficient-two Gamma strategy. For
`t>=16` and `2*t<=N`, the first module covers every generic candidate by two
left rectangles, preserves the strict lower and closed upper Gamma sum bands,
and splices two supplied coprime injections into an SDR. The second proves the
fixed least-start reversal map is such an SDR when every actual candidate is
coprime to its reversal total. These hypotheses are conditional: Lean does
not assume Pomerance's theorem or prove the coprimality premise uniformly.

`CoefficientTwoArbitraryReversal.lean` strengthens the fixed-total result to
every exact feasible start: if all actual candidates are coprime to
`Q_s=N+s+2*ell`, the named map `c |-> Q_s-c` is an injective Gamma SDR.
`GammaTwoTranslation.lean` independently verifies the conditional J1 map,
under its branchwise gcd and cross-collision hypotheses. Neither theorem
asserts that its coprimality hypotheses hold uniformly.

`MatchingDependency.lean` proves an exact finite graph theorem: relative to
any fixed left-saturating matching, a subset is Hall-tight exactly when it is
successor-closed and contains no vertex seeing an unmatched right neighbor.
Strict Hall for every nonempty subset is equivalent to every left vertex
reaching such a vertex. This makes fixed finite audits efficient, but it does
not construct the missing uniform arithmetic matching.

Three further modules formalize the surviving Response 55 structure.
`CoefficientTwoFeasibleStarts.lean` proves the exact interval of every
rectangle start satisfying coverage and the strict/closed Gamma bands, under
`16 <= t`, `2*t <= N`, and nonemptiness of the generic band.
`PartialMatchingDichotomy.lean` proves that after a left vertex is inserted,
the enlarged left set either admits a saturating matching, possibly after
rematching the old set, or exposes an exact deficiency-one subset. If the
vertex was already present, the enlarged set is unchanged.
`MatchingContraction.lean` proves that the full non-reaching region is tight
and that deleting it and its matched image leaves a strict-Hall residual.
`CriticalCoreContraction.lean` proves that every co-singleton of a nontrivial
critical deficiency-one set is tight, so unrestricted contraction to an
"atomic" core always collapses to one left vertex and is not a proof route.
All are finite structural theorems; none constructs the original Gamma
matching or proves the all-dimension selector.

`DeletionPivotLifting.lean` verifies a separate unrestricted induction
bridge: a lower-dimensional deletion certificate plus the exact
exceptional-coordinate inequality produces the explicit full witness time
`r/(n*p)` at the closed `1/(n+1)` threshold. Its wrapper preserves the
`forall deletion, exists certificate` quantifier order. The module does
**not** prove that the required lifting certificate exists; DPLP remains
conjectural.

The proposed union of all feasible reversal diagonals is now **rejected**, not
open: at `(N,t)=(36,16)` every candidate has a diagonal neighbor, but
`{20,22,24}` has only `{41,43}`. The full Gamma graph is nevertheless
Hall-good by an explicit SDR, so this refutes only `DIAGONAL-HALL`, not the
coefficient-two selector or LRC. The exact certificate is reproducible with
`python3 scripts/audit_gamma_diagonal_obstruction.py`.

The strongest additional computer-assisted manuscript theorem covers maximum
speed `n+5`. Its 134,568-case finite core and uniform arithmetic proof have
been independently audited, but the combined theorem is not yet one Lean
declaration.

Claims are labelled throughout as:

- **proved-lean** — kernel-checked under the pinned dependencies;
- **proved-math** — complete manuscript proof independently audited but not
  fully assembled in Lean;
- **computed** — reproducible finite evidence only;
- **conditional**, **open**, or **rejected** — exactly as stated.

Counterexamples and failed approaches reject only their named sufficient
conditions. In particular, the exact tuple `(1,3,5,6,7)` rejects the quadratic
Chebyshev shortcut, not the full Chebyshev score and not LRC.

## Repository map

- [STATUS.md](STATUS.md): concise authoritative status and open bottleneck.
- [full-proof-roadmap.md](docs/full-proof-roadmap.md): unrestricted A/B/C
  bridge contracts, dependencies, budgets, and abandonment criteria.
- [LonelyRunner/](LonelyRunner/): Lean definitions, equivalences, lemmas, and
  verified partial theorems.
- [proof-obligations.md](docs/proof-obligations.md): live obligation ledger.
- [manuscript.md](docs/manuscript.md): human-readable argument mapped to Lean.
- [approaches.md](docs/approaches.md) and
  [failed-approaches.md](docs/failed-approaches.md): surviving and refuted
  strategies.
- [height-logarithmic.md](docs/height-logarithmic.md): proof and audit of the
  earlier elementary logarithmic-height theorem.
- [response45-audit.md](docs/response45-audit.md): exact primorial-height
  manuscript theorem and reproducible Sol Pro artifacts.
- [response46-audit.md](docs/response46-audit.md): independently audited
  and Lean-verified roots-of-unity/Vandermonde proof of Kanold's interval
  bound.
- [response47-audit.md](docs/response47-audit.md): Lean-verified
  coefficient-five improvement, audited saturated top-two class, and
  recovered verifier.
- [top-two-pivot-search.md](docs/top-two-pivot-search.md): a sharp conjectural
  pivot restriction and its reproducible bounded stress search.
- [top-two-fractional-dual.md](docs/top-two-fractional-dual.md): a fixed exact
  fractional certificate whose proposed global extension is now refuted.
- [top-two-fractional-obstruction.md](docs/top-two-fractional-obstruction.md):
  exact weak-duality obstruction to that global fractional invariant; the
  integral top-two conjecture remains open.
- [response50-audit.md](docs/response50-audit.md): independently reproduced
  finite affine-transversal certificate for the fixed hard top pair.
- [response51-audit.md](docs/response51-audit.md): accepted conditional
  special classes, the exact affine counterexample, and the corrected
  coefficient-two frontier.
- [response52-audit.md](docs/response52-audit.md): critical Gamma cores, the
  verified common-grid class, and the asymptotic coefficient-two theorem.
- [response53-audit.md](docs/response53-audit.md): formal rectangle bridge,
  effective-cutoff audit, and the rejected strict energy target.
- [response54-audit.md](docs/response54-audit.md): fixed-matching
  reachability, reversal totals, exact compiler objections, and remaining
  arithmetic gaps.
- [affine-transversal-frontier.md](docs/affine-transversal-frontier.md): the
  Lean-formalized abstract bridge, empty-grid counterexample, and corrected
  disjunctive frontier.
- [coefficient-two-gamma.md](docs/coefficient-two-gamma.md): complementary
  coprime forcing, exact Hall bottleneck, finite repairs, and reproducible
  evidence.
- [gamma-dependency-sweep.md](docs/gamma-dependency-sweep.md): hardened finite
  matching grids, the separate `N=20000` reachability audit, exact domains,
  hashes, and interpretation.
- [response55-audit.md](docs/response55-audit.md): exact diagonal
  counterexamples, tight-block contraction, compiler results, and surviving
  arithmetic gaps.
- [response56-audit.md](docs/response56-audit.md): atomic-collapse correction,
  coatomic necessary conditions, two-total chains, and fixed-shift failures.
- [response57-audit.md](docs/response57-audit.md): puncture/slack identities,
  exact chain criteria, and the final bounded coefficient-two audit.
- [response58-audit.md](docs/response58-audit.md): unrestricted strategy
  generation, literature correction, prime-forcing contract, and rejected
  third-order criterion.
- [response59-audit.md](docs/response59-audit.md): corrected deletion-pivot
  and prime-forcing dispositions with a reproducible finite verifier.
- [response60-audit.md](docs/response60-audit.md): independent mathematical
  review, mandatory replay failure, and stopped low-order shortcuts.
- [response61-audit.md](docs/response61-audit.md): nonreproducible height sweep,
  signed-divisor transport audit, signature defect, and frozen descent route.
- [computation.md](docs/computation.md): computational scope and interpretation.
- [publication-audit.md](docs/publication-audit.md): public-release privacy,
  secret-scanning, and redistribution audit.
- [certificates/](certificates/): canonical deterministic outputs.
- [scripts/](scripts/): certificate generators and exact audit commands.
- [research/sol-pro/session-001.md](research/sol-pro/session-001.md): archived
  GPT-5.6 Pro prompts, responses, objections, and revisions.
- [research/lean-build-log.md](research/lean-build-log.md): clean-build history.

## Reproduce the project

The repository pins Lean and mathlib to `v4.32.1`. The committed Lake manifest
pins mathlib commit `520045ab14e26149ee970e2e617ca04b09bde5d6`.
The authoritative formal source checkpoint is
`586b4858cd1b1c513566f3b33d7b5141640e7865`. Merged main commit
`99a78c15ad0a55e96cffbc5dadf4f3afd99cfa1c` contains the same Lean source
tree; its other parent contributes documentation and research records. The
new ReverseGrid verification used an isolated native-WSL warm-cache worktree,
not a fresh detached clean checkout. The earlier detached clean replay at
`263a1cb8b68d8ea1d8b6333cd1e72f258b01bafa` remains the latest complete
clean-checkout record for the older source tree. Resolve the exact repository
snapshot containing this text with `git rev-parse HEAD`.
See [STATUS.md](STATUS.md) for the exact environment, timings, warnings, and
historical CI results.

Install [Elan](https://github.com/leanprover/elan), clone the repository, and
run from its root:

```bash
lake exe cache get
lake build
python3 scripts/audit_lean_trust.py
python3 -m unittest discover -s tests -v
./scripts/audit_public_release.sh
```

At formal checkpoint `586b485`, direct compilation of
`LonelyRunner/ReverseGrid.lean`, its 3,001-job target build, the 3,590-job root
build, direct compilation of `LonelyRunner.lean`, and the expanded
`AxiomAudit.lean` all passed. Every new declaration uses only the permitted
standard foundations. This verifies the integrated ReverseGrid source in the
recorded warm-cache worktree; it is not represented as a fresh clean replay.

The earlier detached ext4 replay at `263a1cb` was tracked-clean
before and after all commands. It restored 8,638 cache files in 884.08
seconds, built 3,589 jobs in 577.21 seconds, audited 289 theorem reports in
10.37 seconds, and passed all 160 regression tests in 428.520 seconds (429.14
seconds wall time). The direct Response 59 and DPLP certificate comparisons
also matched exactly in 0.75 and 6.46 seconds, respectively. Those checks
remain historical verification of that older formal source tree.

The trust audit runs `LonelyRunner/AxiomAudit.lean`, rejects placeholder or
unsafe source constructs, and permits only Lean's standard `propext`,
`Classical.choice`, and `Quot.sound` axioms.

Important individual certificates can also be replayed directly:

```bash
bash scripts/audit_logarithmic_height.sh
bash scripts/audit_height_n_plus_5.sh
bash scripts/audit_quadratic_chebyshev_failure.sh
bash scripts/audit_response44.sh
bash scripts/audit_response45.sh
bash scripts/audit_response46.sh
bash scripts/audit_response47.sh
bash scripts/audit_response50.sh
bash scripts/audit_coefficient_two_gamma.sh
bash scripts/audit_gamma_dependency_sweep.sh
python3 scripts/audit_gamma_diagonal_obstruction.py
python3 scripts/audit_gamma_translation_shifts.py
python3 scripts/audit_deletion_pivot_lift.py
python3 scripts/audit_response59_claims.py
bash scripts/audit_top_two_pivot_search.sh
bash scripts/audit_top_two_fractional_dual.sh
bash scripts/audit_top_two_fractional_obstruction.sh
bash scripts/audit_response42_cheb_multi.sh
bash scripts/audit_residual_compatibility_family.sh
```

The optional several-minute lower-dimensional calibration is:

```bash
bash scripts/audit_quadratic_chebyshev_calibration.sh
```

The optional full high-dimensional Gamma sweep is:

```bash
GAMMA_DEPENDENCY_FULL=1 bash scripts/audit_gamma_dependency_sweep.sh
```

The integrated Prompt64 finite evidence can be replayed directly from its
canonical recovered sources:

```bash
g++ -O3 -std=c++20 -Wall -Wextra -pedantic \
  research/sol-pro/artifacts/prompt64/p64_top_two_sweep_v1.cpp \
  -o /tmp/p64_top_two_sweep_v1
/tmp/p64_top_two_sweep_v1
python3 research/sol-pro/artifacts/prompt64/p64_targeted_stress_v1.py
rm -f /tmp/p64_top_two_sweep_v1
```

GitHub Actions runs a cached Lean build, the trust audit, and the complete
deterministic Python regression suite. The authoritative local standard remains
a clean ext4 checkout with the commands above; latest recorded results and
tool versions are in [STATUS.md](STATUS.md).

The current authoritative integrated research checkpoint is
`a4cd1242a0a58c22b6407b95256bd96cadc428e8`. The latest authoritative clean
full-project Lean/trust/regression replay is lifecycle checkpoint
`fc004e5bddc06e2b7b035cc9cce20a675bbbc2f7`: 3,591 Lean jobs, 302 trust
reports, and all 172 deterministic tests passed in a fresh native-WSL clone.
See `STATUS.md` for timings and the distinction between the verified source
tree, recovered Prompt67 evidence, active downstream work, and open
conjectures.

## Current research frontier

Research is in **FULL-PROOF PRIORITY MODE**. The exact unrestricted
bottleneck remains the Lean-verified finite pivot-certificate proposition:
for every positive injective integer tuple, some pivot candidate must escape
all strict modular bad sets. The rolling pipeline currently has three
independent active Pro cells: Prompt86 (local-dimensional pivot
multiplicity), Prompt87 (adversarial synthesis), and Prompt89
(balanced-junction cover deficit). Prompt90 and Prompt91 are Medium-level
waiting-contract preparations, not active Pro results. Prompt85's proposed
literal replay remains `MEDIUM-SPEC-REQUIRED`; no Luna task is currently
admitted. These lifecycle facts promote no theorem or finite evidence.
Prompt66's
`ALL-PIVOT-MODULAR-WHOLE-BLOCK-PACKING` turn completed at STOP/OPEN, leaving
that packing lemma open. Prompt64's `TOP-TWO-LARGE-RATIO-EXCLUSION` also
completed/recovered at STOP/OPEN and its exact route is frozen. Prompt67's
major `UNIFORM-PRIME-FORCING-SUPPLY` turn completed and its response plus four
canonical downloads were recovered in commit `1294514`. Provenance reviews
accepted the package, the mathematical audit gave a qualified ACCEPT only at
its enumerated `proved-math` scopes, and computational preflight accepted five
finite domains as **computed finite evidence only**. The response's **PIVOT**
self-disposition is not a theorem. The original response citations `[1]` and
`[2]` are corrected by commit `e514ef5`; audit 109 ACCEPTS WITH QUALIFICATIONS
only as a **verified citation-correction record; external literature remains
unformalized; no mathematical status promotion**. The audited external sources
are the MSS DOI/arXiv `2411.06903v2` and Rosenfeld arXiv `2512.01912v1`.
The attempted top-level Luna clean-room replay produced candidate commit
`27876765`, but its remaining process was terminated when Narrow Verification
Mode took effect. Final audit 112 classifies it `MEDIUM-SPEC-REQUIRED`: the
output is rejected, salvage is abandoned or indefinitely deferred, and sole
accepted finite evidence remains audit 104. Prompt68's corrected cofinite
forcing contract passed review 117 and is integrated at `2d9b2bb`, but remains
unlaunched and promotes no result. C2 prime-forcing product induction
remains the open first-ranked route; `UniformPrimeForcingSupply`, both Prompt67
attack lemmas, the assembled C2 bridge, and unrestricted LRC remain open.
Bridge B packing remains open, while C1 and A remain frozen. DPLP remains open:
together with lower-dimensional LRC, the verified coefficient-three height
theorem, and the direct `q=N` branch, it would prove unrestricted
positive-integer LRC. An exact finite audit found no DPLP failure in 243,973
premise-satisfying tuples, but this is **computed finite evidence only**.

The supplied packing adapter at checkpoint `fadc65d` is independently
replayed and `proved-lean` only for
`exists_avoiding_of_overlapCapacity` and
`exists_pivot_certificate_of_overlapPacking`. These adapters consume explicit
capacity/packing hypotheses; they do not prove uniform packing existence,
`PACK-09`, pivot noncoverage, or unrestricted LRC. Prompt preparation and
desktop launch likewise promote no research result.

The separate Response 59 finite claim audit is reproducible with
`python3 scripts/audit_response59_claims.py`. Its deterministic output is
computed finite evidence only; it does not prove uniform DPLP, positive-
integer LRC, unrestricted LRC, or uniform prime supply. See the
[Response 59 audit](docs/response59-audit.md) for its exact dispositions and
reproduction metadata.

The independent [Response 60 audit](docs/response60-audit.md) accepts local
D1--D6/P1/P2 mathematics at exact strength but rejects the proposed universal
low-order and cycle shortcuts. Its whole-output artifact replay fails even
though a narrower deterministic payload matches. The
[Response 61 audit](docs/response61-audit.md) records a nonreproducible
compiler/host/timing-bound sweep and freezes the exact minimal-counterexample
height-compression route. Neither audit promotes finite evidence or adds a
Lean theorem.

The [Response 62 audit](docs/response62-audit.md) independently replays the
8,108-row sweep and the hard `(N,A,B)=(7,98,187)` transversal number `5` as
computed finite evidence, while returning an overall **FAIL** for the proposed
project-level residual chain. Local lemmas survive only as `proved-math` at
their exact hypotheses; uniform scalar criteria are rejected. The first
missing project edge is `2*B<=N*A`, and the owner-aware multi-shift
transversal remains conjectural/open. No implementation or Lean theorem is
authorized by that audit.

The [Response 63 audit](docs/response63-audit.md) conditionally accepts an
independent lead replay of the 4,694-record deletion/correlation census as
computed finite evidence. Its historical disposition accepted A1, B1--B5,
and C1 as `proved-math` and rejected the response's pseudo-Lean block.
Subsequent independent formalization now makes the exact C1 reverse-grid
arithmetic `proved-lean` in `ReverseGrid.lean`: rational signed identity,
positive deep deficit, canonical residue range and congruence, mod-one phase,
signed cyclic-distance adapters, deleted-boundary equality, pivot congruence,
and final distance transport all compile under explicit `ReverseGridData`
hypotheses. C2 still requires the encoded deep premise `N*d<n*p`; no theorem
supplies it for a first blocker or proves strict smaller-Delta descent. The
corrected DPLP selector and unrestricted LRC remain conjectural/open.

Prompt66's all-pivot whole-block-packing turn is completed/recovered at its
self-disposition **STOP/OPEN**. The recovery preserves the exact clipboard,
21-entry safe ZIP, separate SHA list, and newline reconciliation. Independent
audits accept the mathematics/computation only at qualified scope and the
recovery mechanically with path/packaging corrections; no response claim or
finite evidence is promoted. The Luna implementation commit
`5cf8abd04b40b26183eb3839d3d7a7f8d68a82ab` was independently ACCEPTED by
`VER-LUNA-P66-REPLAY-SUPERVISE-070` and integrated by `/root` in merge
`fc2d023e9df1c554cc67fadedece1325e72694b1`. The independent verifier checks
all `4,149` modular instances: `3,714` witness rows and `435` certified
fixed-pivot failures, split `421` rational-dual and `14` branch-tree failures;
there are `472` tuple bundles and zero tuple-level all-pivot hits. Exact-optimum
promotion is limited to `380` cases. The `55` supplied `exact_optimum` flags
whose feasible lower and certified upper bounds do not coincide are explicitly
not promoted.

For `F=(8,15,35,40,48,56,75,132,147)`, pivot `48` has `R=432`, `S=706`,
strict required credit `>274`, feasible credit `262`, rational upper bound
`1314/5`, and integer optimum `262`. This is fixed-pivot evidence only. The
radial-descent and signed-phase-cell uniform criteria are refuted as sufficient
conditions on all nine pivots of `F`; only those criteria are rejected. The
evidence label is **computed finite evidence, independently replayed**. Unit
tests `5/5` pass. Verification Lead full replay: `PASS` in `13.59s`; `/root`
independent full replay: `PASS` in `18.516s`; deterministic semantic outputs
differ only in runtime and the consequent report/manifest hashes. No
`proved-math` or `proved-lean` promotion follows. The main all-pivot packing
lemma `PACK-09`, the exact pivot selector, and unrestricted LRC remain open.
The two rejected uniform criteria are frozen as a research milestone, not a
formalization target.

Prompt64's exact response and three canonical attachments are integrated under
merge `ca8f4c55b3baa7ea29e1e595ce1bb564904ecf70` from recovery commit
`12922204bdf1ea1c0271767a461d9324a6b40a4f`, after ACCEPT reviews
`FORM-P64-PACKAGE-REVIEW-086` and `VER-P64-PACKAGE-REVIEW-087`. The normalized
response is 41,788 bytes with SHA-256
`f273ee340066c42dc4f3cb8224e35b4df028ebdd47b4dda1bb4879f515f5698d`.
The complete sweep covers 247,020 primitive rows, skips 5,597 nonprimitive
rows, checks 98,271,563 candidates in each implementation, and finds zero
two-top counterexamples. The targeted replay covers 61 cases, 45 strict, with
zero strict failures. These are computed finite evidence only.

`FORM-P64-RESPONSE-MATH-AUDIT-081` accepts the contrapositive equivalence,
scaling, reindexing, `n=2`, `kB±d` formulas, and conditional `1/(m+2)`
reduction as `proved-math` only at exact corrected scope.
`FORM-P64-SCALING-EDGE-083` replaces the response's literal false `r<M<dM`
edge at `d=1` with `r<M<=dM`; canonical response bytes remain unchanged. The
first unsupported branch is an open equivalent reformulation. The target,
owner-transversal, exact pivot selector, and unrestricted LRC remain open; no
new Lean theorem is promoted. See [the Response64 audit](docs/response64-audit.md).

The fresh top-level Luna/xhigh formalization route had persisted runtime
metadata matching the requested model, effort, and working directory, but its
worker exited without a report or commit. The Formalization Lead independently
reviewed the target, made one routine proof repair, and committed the accepted
source as `586b485`. The worker termination supplies no claim endorsement.

The remaining active major routes are corrected deletion-pivot/prime forcing
and an unrestricted top-two/all-pivot certificate. Their exact contracts,
implication chains, falsification suites, budgets, and abandonment criteria
are in the [full-proof roadmap](docs/full-proof-roadmap.md). The
coefficient-two Gamma selector and the audited height-compression route are
frozen unless materially new evidence meets their restart conditions.

## Public-release safety

The publication checkpoint was scanned with history-aware Gitleaks v8.30.1
and a separate manual history/current-tree audit. Local Lake builds, Python
caches, virtual environments, scratch work, credentials, browser/session data,
and verification clones are excluded by `.gitignore` and are not part of the
repository.

## License

No software or documentation license has been selected. No permission beyond
what applicable law already grants should be inferred from publication.
