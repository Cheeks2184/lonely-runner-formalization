# Project status

Status date: 2026-08-02. Authoritative branch: `main`.

Unrestricted Lonely Runner Conjecture: **open**. This repository contains no
claim that it has been proved or disproved.

## Strongest verified theorem

The strongest fully Lean-verified bounded-height result is
`LonelyRunner.threeHeight_family_witness`. If `n+1=N`, `t>0`, and
an injective family of `n` positive integer speeds is bounded by `N+t`, then

```text
3*t <= N
```

implies one common real time at closed circular distance at least `1/N` for
every speed. `kanoldIntervalBound_vandermonde` proves, rather than assumes,
that every half-open interval of `2^omega(c)` consecutive natural numbers
contains a number coprime to positive `c`. Its proof uses an exact
roots-of-unity powerset expansion and a Vandermonde system with pairwise
distinct nodes. `three_short_interval_large_or_exception` proves that every
unrepaired short missing height lies strictly above `N/2`, apart from five
small triples. If no common witness existed, every missing height `c` would
therefore force the occupied extra height `2*c`. The missing-height set has
cardinality one larger than the extra-height set, contradicting injectivity of
`c |-> 2*c`. Explicit arguments close `(N,t)=(6,2),(12,4),(13,4)`; the two
remaining triples use the coefficient-four theorem. These results do not
prove unrestricted LRC.

The exact coefficient-three source has passed an isolated ext4 target build,
a separate standalone compile, targeted axiom probes, independent adversarial
review, and the authoritative clean full-project build, trust audit, and
regression replay recorded below.

The exact primorial result remains fully verified. Let `P_N` be the largest
primorial at most `N`, and let `Q_N=phi(P_N)`. Lean proves the exact maximum

```text
max_(1<=c<=N) c/phi(c) = P_N/Q_N
```

in cross-multiplied natural arithmetic. If `N,t>=1` and

```text
(4*P_N-Q_N)*t < N*Q_N,
```

then every injective family of `N-1` positive integer speeds bounded by `N+t`
has one common real time at closed circular distance at least `1/N` for every
speed. `boundedPrimorialHeightGain_family_witness` gives the exact largest
integer gain

```text
(N*Q_N-1) div (4*P_N-Q_N).
```

This theorem is useful independently but is weaker as a uniform height bound
than the coefficient-three theorem above.

The real-speed conjecture has also been formally reduced to the
positive-integer conjecture:

```text
LonelyRunner.conjecture_iff_positiveIntegerConjecture
```

This equivalence does not prove either side.

## Evidence labels

- **Lean-verified:** the canonical formulation/equivalence layer, the full
  real-to-positive-integer reduction, the finite pivot-certificate
  equivalence, base cases through two moving runners, the `n+2`
  bounded-height theorem, the logarithmic bounded-height theorem, and the
  exact primorial-ratio bounded-height theorem above.
- **Audited manuscript plus reproducible finite certificate:** every integer
  speed family of maximum at most `n+5` is lonely. Its finite core covers
  134,568 configurations; it is not yet one Lean theorem.
- **Lean-verified after manuscript audit:** the exact primorial-ratio theorem
  from [the Response 45 audit](docs/response45-audit.md). The finite-prime
  exchange proof, maximum characterization and attainment, strict height
  algebra, closed-boundary witness, and exact gain all compile without an
  extra arithmetic premise.
- **Lean-verified:** Response 46's independent roots-of-unity/Vandermonde
  proof of the Kanold interval bound is fully assembled in
  `KanoldVandermonde.lean`. Combined with the already verified interval
  arithmetic, `seventeenThirdsHeight_family_witness` proves the unconditional
  `17*t<=3*N` bounded-height theorem. The original conditional declarations
  are retained to expose the dependency boundary. See
  [the audit](docs/response46-audit.md).
- **Lean-verified:** Response 47 improves the bounded-height
  hypothesis to `5*t<=N` by classifying three short-interval exceptions and
  repairing them at the family level. The height theorem is fully assembled
  in `CoefficientFiveHeight.lean`. The separate top-two pivot property for
  `(1,2,...,N-2,B)` is also Lean-verified for every `N>=4` and `B>N-2` by
  `saturatedTopTwo_avoids_pivotBadResidues`; it is only a structured class,
  not the unrestricted top-two conjecture.
  See [the audit](docs/response47-audit.md).
- **Lean-verified:** `CoefficientFourHeight.lean` strengthens the same
  bounded-height architecture to `4*t<=N`. It proves an exact twelve-triple
  exception classification, closes nine cases by explicit above-height
  moduli, and repairs three complementary-boundary cases by a second missing
  value. A fresh adversarial audit reproduced every case and returned
  `ACCEPT`. This remains bounded-height progress only.
- **Lean-verified:**
  `CoefficientThreeHeight.lean` proves `threeHeight_family_witness` under
  `3*t<=N`. Its missing-versus-extra cardinality proof, doubling injection,
  three exceptional-pair repairs, exact final quantifiers, and axiom reports
  passed standalone compilation and independent audit. It is still only a
  bounded-height theorem.
- **Lean-verified fastest-pivot restriction:** if the maximum positive integer
  speed `B` satisfies `B<=(N-1)*s` for every speed `s`, the explicit numerator
  `r=N-1` is a fastest-pivot certificate and gives a common closed `1/N`
  witness. Consequently, failure at the fastest pivot forces
  `(N-1)*a_min<a_max`. This is only a necessary condition for a failed
  fastest/top-two strategy, not a proof that a top pivot always succeeds.
- **Lean-verified:** the more general
  `exists_fastestPivotCertificate_of_extremal_band` accepts any numerator
  mapping explicit lower and upper nonpivot bounds into the closed fastest-
  pivot safe band. `exists_fastestPivotCertificate_of_mem_extremal_interval`
  proves that every nonmultiple in the exact closed ceiling/floor interval is
  such a certificate, and
  `extremal_interval_compression_of_no_fastestPivotCertificate` proves that
  failure leaves only an empty interval or a divisible singleton. The new
  declarations passed standalone compilation, an ext4 target build, and the
  authoritative clean full-project build, trust audit, and regression suite.
  None of these statements forces the other top pivot in the residual regime.
- **Finite evidence only:** targeted full Chebyshev/CRT score searches and the
  top-two pivot stress certificate. The latter checks 878,245 primitive box
  tuples plus 86,745 structured mutations without a failure; it is a proposed
  strengthening that would imply LRC, not a proved reduction or theorem. No
  finite search implies a uniform result.
- **Reproducible finite evidence:** for the fixed hard pair
  `(N,A,B)=(7,98,187)`, fourteen explicit affine shifts produce 64 robust-pair
  constraints. The recovered Sol Pro verifier and an independent direct
  two-coordinate implementation reject all 3,464,840 four-speed sets and
  accept `{7,63,70,77,84}`, proving `tau_H=5` for this fixed shift family.
  No uniform construction of such a family is known. See
  [the Response 50 audit](docs/response50-audit.md).
- **Lean-verified abstract bridge:** `TopTwoTransversal.lean` proves that a
  lower-speed set covering both robust top grids spoils every selected robust
  pair, while failure of two-sided transversality extracts a complete
  certificate at one top pivot. The unconditional paired-shift premise is
  false at `(N,A,B)=(4,2,8)` because one robust grid is empty. The surviving
  frontier is disjunctive; no uniform top-two theorem follows.
- **Lean-verified common-grid special class:**
  `simultaneousTopTwo_of_commonPivotBadCount` uses the exact gcd/ceiling bad
  counts on a positive `g`-pivot grid. When both normalized top speeds are
  units modulo `N` and the strict lower bad-count sum is below `g*(N-1)`, it
  returns canonical candidates at both top pivots, mutual top safety, lower
  safety, and exact equality of the represented real time. The strict count
  premise is sufficient, not uniform. Its hypotheses do not encode that the
  lower family is distinct or numerically below those pivots, so those facts
  remain external in a literal sorted top-two instantiation.
- **Lean-verified Gamma rectangle classes:**
  `CoefficientTwoRectangle.lean` proves generic-band coverage, disjoint extra
  rectangles, both exact strict/closed crossed sum bands, and the conditional
  splice of two supplied coprime injections. `CoefficientTwoReversal.lean`
  proves that the fixed least-start reversal is an SDR when every actual
  generic candidate is coprime to its reversal total. Neither theorem assumes
  Pomerance or proves its arithmetic premise uniformly.
  `CoefficientTwoArbitraryReversal.lean` proves the same named-map SDR for
  every exact feasible start under candidatewise coprimality to its total.
  `GammaTwoTranslation.lean` proves the separate conditional J1 map under
  branchwise gcd hypotheses and explicit exclusion of cross collisions.
- **Lean-verified fixed-matching Hall criterion:**
  `MatchingDependency.lean` characterizes tight subsets as
  successor-closed, unmatched-neighbor-free sets and proves that strict Hall
  on every nonempty subset is equivalent to reachability of an
  unmatched-neighbor vertex from every left vertex. The theorem accepts a
  supplied saturating matching; it does not construct one arithmetically.
- **Lean-verified feasible starts, rematching dichotomy, and contraction:**
  `CoefficientTwoFeasibleStarts.lean` proves the exact natural-number interval
  of starts satisfying rectangle coverage, right inclusion, and both exact
  Gamma sum bands under `16 <= t`, `2*t <= N`, and nonemptiness of the generic
  band. `PartialMatchingDichotomy.lean` shows that after insertion the enlarged
  left set either has a saturating matching, possibly after rematching all old
  vertices, or has an exact deficiency-one subset; insertion may be a no-op.
  Given a saturating
  matching, `MatchingContraction.lean` proves its complete non-reaching region
  tight and its induced residual strict-Hall. These are structural reductions,
  not a construction of the missing Gamma matching.
- **Lean-verified atomic-collapse correction:**
  `CriticalCoreContraction.lean` proves every co-singleton of a nontrivial
  critical deficiency-one set tight and proves that a core with no nonempty
  proper tight subset has exactly one left vertex. Unrestricted tight-block
  contraction is therefore vacuous as an arithmetic exclusion strategy.
- **Audited mathematics plus finite evidence:** coefficient-two no-witness
  assumptions force every coprime complementary extra in `Gamma(c)` to be
  occupied. Exact degree bounds and a complete bounded classification reduce
  any new Hall failure to a connected deficiency-one core with `N>=20`, at
  least three left vertices, and minimum incidence degree two on both sides.
  Pomerance's primary coprime-interval theorem plus an exact rectangle
  decomposition proves the active generic selector for all sufficiently
  large `N`, but with an existential cutoff. Exact tests through `N=300`
  leave four repaired small pairs. Hardened fixed-grid computations also find
  no matching failure on every endpoint graph with `1001<=N<=20000` and sparse
  active grids through `N<100000`; these are finite evidence only. The exact
  all-`N` selector remains open.
  See [the Gamma audit](docs/coefficient-two-gamma.md).
- **Refuted strategy:** the proposed global fractional two-grid dual
  invariant fails exactly at top speeds `(98,187)` for `N=7`. A feasible
  fractional cover of mass `962/241<4` rules out the required dual mass by
  weak duality. Exhaustive search finds no four-speed integral cover in that
  instance, so the integral top-two conjecture remains open. See
  [the obstruction](docs/top-two-fractional-obstruction.md).
- **Conditional:** declarations whose theorem statements retain an explicit
  arithmetic or analytic premise.
- **Refuted strategy:** files under the failed-approach and counterexample
  records reject only the named sufficient conditions, not LRC.
- **Refuted strategy:** `RELOC-UNIF` is also closed negatively. The exact
  all-pivot OPT-ADD counterexample has a global minimum additive order at or
  above threshold at every pivot; a global minimum is automatically a
  two-sided relocation-local minimum. The generic Lean descent and block
  identity remain valid, but this arithmetic uniform premise is false.

## Exact open bottleneck

Lean proves that the positive-integer conjecture is equivalent to a uniform
finite pivot-certificate proposition. The unresolved arithmetic step is to
show that every positive injective integer tuple has at least one pivot whose
strict modular bad sets do not cover all candidates—or to refute that exact
proposition. Current overlap, correlation, Chebyshev, descent, and residual
restrictions do not force such a pivot.

Research is now in **FULL-PROOF PRIORITY MODE**. Tracked unrestricted branches
and their current dispositions, in priority order, are:

1. prove or refute the corrected deletion-pivot lifting principle (DPLP),
   whose exact induction chain uses lower-dimensional pivot certificates,
   the verified coefficient-three endpoint, and the direct `q=N` branch;
2. prove a uniform supply of prime-forcing moduli whose product exceeds the
   published minimal-counterexample product bound; this route is backed by
   recent finite-dimensional proofs but retains an external unformalized
   product-bound dependency;
3. prove or refute the unrestricted top-two pivot property, then fall back to
   the exact all-pivot certificate; the immediate target is an integral
   affine-fiber/transversal theorem, not the rejected fractional dual;
4. keep the least-primitive-counterexample height route frozen after Response
   61; restart it only with a genuinely new replacement operation or a proof
   of signed-divisor eligibility, not more iterations of the stopped descent.

Each branch has an exact theorem contract, implication chain, falsification
suite, budget, and abandonment criterion in
[the full-proof roadmap](docs/full-proof-roadmap.md). Coefficient two receives
one final audit sprint and is otherwise frozen unless it yields an all-`N`
selector, an effective cutoff plus complete finite verification, a genuine
selector counterexample, or an unrestricted reusable lemma.

DPLP is **conjectural**. A deterministic exact audit found no failure in
243,973 premise-satisfying primitive tuples above the coefficient-three
cutoff, but no uniform cross-deletion correlation theorem is known. Raw
deletion lifting is false at `(1,3,4,7)`; that tuple lies in the separate
direct `q=N` branch and is not an LRC counterexample. The earlier
`RELOC-UNIF` branch is rejected: the existing all-pivot OPT-ADD example has a
global, hence two-sided relocation-local, minimum above threshold at every
pivot.

The sound part of DPLP is now **Lean-verified** in
`DeletionPivotLifting.lean`: a selected deletion certificate satisfying the
exceptional-coordinate inequality yields the explicit full witness, and the
wrapper preserves the exact selector quantifiers. This does not prove the
selector. Exact `proved-math` deep-hole and shell cardinalities reduce the
current arithmetic obstruction to overlap-sensitive singleton counting.

## Response 60--63 verification audits

`VER-R60-AUDIT-004` records `FAIL / nonreproducible` for Response 60's
mandatory whole-output replay. Python `3.14.4` reproduces the deterministic
payload hash but not the committed Python `3.13.5` version and runtime footer.
The audit accepts D1--D6, the active-to-canonical bridge, P1, strengthened P2,
and the exact product inequality as `proved-math`; it rejects universal D2/D3
positivity, the active-cycle divisibility shortcut, P1 singleton elimination,
and `PrimeForcing(3,5)`. Cycle-to-shell lifting and uniform prime supply remain
conjectural/open. See [the Response 60 audit](docs/response60-audit.md).

`VER-R61-AUDIT-005` records `FAIL / nonreproducible` for Response 61's
mandatory finite sweep. The required Debian G++ 14.2.0 toolchain is absent;
`-march=native` makes the binary host-specific and embedded `steady_clock`
output makes stdout timing-specific. Signed-divisor transport is accepted only
as `proved-math`, not `proved-lean`; replacement eligibility and
`MinimalCounterexampleHeightCompression` remain open. The proposed Lean
signature also leaves `N` independent after appending to `Fin (n+1)`, where
contract fidelity requires `N=n+2`. The exact height-compression route is
**STOPPED and frozen**. See [the Response 61 audit](docs/response61-audit.md).

`VER-R62-AUDIT-010` replays Response 62's 8,108-row sweep and the hard
`(N,A,B)=(7,98,187)` transversal number `5` as verified computed finite
evidence. Its local lemmas are accepted only as `proved-math` at exact
hypotheses, while every tested uniform scalar criterion is rejected.
`FORM-R62-RESIDUAL-SPEC-012` finds no current project-level declaration chain
for the response's combined residual: the first genuinely missing edge is
`2*B<=N*A`. `B<n*A` and the terminal interval are routine only after their
explicit lower-dimensional witness/reindexing and no-full-witness premises are
bound. Overall disposition is **FAIL / mixed**; the owner-aware multi-shift
bridge, top-two/all-pivot targets, corrected DPLP, and unrestricted LRC remain
conjectural/open. See [the Response 62 audit](docs/response62-audit.md).

`VER-R63-AUDIT-013` is conditionally accepted from the supervising lead, not
endorsed by a Luna claim review. The lead exactly reproduces all 21 archive
hashes, all 13 manifest hashes, and the 4,694-record deterministic census:
4,296 corrected-DPLP-premise records, zero finite failures, 36 zero-good
records, and 36 minimum-escape selector cases with zero finite failures. A1,
B1--B5, and reverse-grid identity C1 are `proved-math`; C2 requires the deep
premise `N*d<n*p`. The `(1,2,6,8,10)` cycle obstruction is verified, while
strict smaller-Delta first-blocker descent and the DPLP selector remain
conjectural/open. The pseudo-Lean declaration is invalid as written, and no
cold-cache kernel replay occurred. See
[the Response 63 audit](docs/response63-audit.md).

These are documentation and research-artifact audits after source checkpoint
`263a1cb8b68d8ea1d8b6333cd1e72f258b01bafa`. They add no source theorem,
promote no finite evidence, and change no unrestricted open claim.

## Latest verification

Last clean Lean source checkpoint:
`263a1cb8b68d8ea1d8b6333cd1e72f258b01bafa`.

Every later commit through current base
`4b6ee54a1c64e847c505b632a46c326616678d1c` adds documentation, operations
records, or research artifacts only. The `263a1cb` detached replay is
therefore the authoritative source verification for the current repository
snapshot.

Pinned environment:

- Python `3.14.4`;
- Lean `4.32.1` (`f054605a`);
- Lake `5.0.0-src+f054605`;
- mathlib commit `520045ab14e26149ee970e2e617ca04b09bde5d6`;
- GCC and G++ `15.2.0`;
- local authoritative replay: Ubuntu 26.04 under WSL2;
- public CI: Ubuntu hosted runner and Python 3.14.

Authoritative detached ext4 verification at that source checkpoint:

```text
Pinned cache restoration: 8,638 files; PASS; 884.08s
Build: 3,589 jobs; PASS; 577.21s
Trust audit: 289 theorem reports; PASS; 10.37s
Unit tests: 160/160 PASS; 428.520s (429.14s wall)
Response 59 direct exact comparison: PASS; 0.75s
DPLP direct exact comparison: PASS; 6.46s
```

The direct comparisons used the documented repository-root commands:

```bash
python3 scripts/audit_response59_claims.py | cmp - certificates/response59_claims_expected.txt
python3 scripts/audit_deletion_pivot_lift.py | cmp - certificates/deletion_pivot_lift_expected.txt
```

The detached checkout's HEAD exactly matched the checkpoint, and its tracked
tree was clean both before and after cache restoration, build, trust audit,
the complete regression suite, and both direct certificate comparisons. Every
trust report used only `propext`, `Classical.choice`, and `Quot.sound`, or a
subset. The build emitted only nonfatal linter/style warnings: unused section
variables or variables, unnecessary `simpa`, and `simp` suggestions in
`AcyclicFiberSelector`, `SoftFeedbackLayers`, `ResidualVariationEnergy`,
`FastestPivot`, `ModularAcyclicSelector`, and `CoefficientThreeHeight`. The
test suite emitted one nonfatal compiler warning for the unused helper
`str128(i128)` in `research/sol-pro/artifacts/prompt45_cheb_grid.cpp:35`.
There were no verification errors. In particular, these warnings do not
belong to the DPLP or Response 59 verifier results.

### Historical verification and public CI records

The expanded `audit_coefficient_two_gamma.sh` replay passed separately in
8.50 seconds at computational source commit `4cf1199`; it checks the guarded
`4<=N<=300` selector evidence plus the globally bounded empty/singleton
neighborhood classification. This finite replay does not prove a uniform
theorem.

The same full 147-test suite passed again at public-release commit
`854567aa8e05ff05714ed5de4a1353d57b4fd105` in 401.780 seconds. The first
hosted run passed the Lean build and trust audit; it also exposed that the
certificate job needs the Boost C++ headers used by the Response 42 replay.
The workflow now installs `libboost-dev` before running the unchanged complete
suite. Follow-up run 30755579476 passed both jobs at commit `b8b047e`: the
cached Lean build, trust audit, and all 147 certificate tests are green. This
was a CI environment repair, not a reduced verification target.
Public run 30758736845 then passed both jobs at commit `a95fc5f`, including
the 3,571-job Lean checkpoint, trust audit, and all 151 tests. Public run
30760626494 passed both jobs at commit `c12c3a5`, including the 3,572-job
unconditional Kanold build, 235-report trust audit, and all 153 tests. Public
run 30761838846 passed both jobs at commit `b302212`, including the 3,573-job
coefficient-five build, 240-report trust audit, and all 153 tests. Public run
30764615804 passed both jobs at commit `0f0f9a6`, including the 3,576-job
coefficient-four/pivot build, 249-report trust audit, and all 153 tests. Public
run 30766497706 passed both jobs at commit `a6041e3`, including the
coefficient-three verification record and all 153 tests.
Public run 30768884839 passed both jobs at commit `4b31c22`, including the
fastest-interval theorem, Response 50 artifact replay, trust audit, and all
153 tests.

Public workflow run 30774426834 passed both jobs at release commit
`5d4ca24064ff563a5c79f1692fe67741d5398990`: the Lean build and trust audit,
and the complete exact certificate suite, are green. The local `e88207b`
checkpoint adds the conditional rectangle splice, matching-dependency
equivalences, and fixed-reversal theorem and has the exact clean replay
recorded above. The expanded Gamma dependency sweep is finite evidence and
does not alter the formal theorem boundary.

The verified source plus the current research record includes the
unconditional Kanold interval, `17*t<=3*N`,
`5*t<=N`, `4*t<=N`, and `3*t<=N` height theorems; the primorial theorem;
both fastest-pivot restrictions; the saturated and abstract transversal
top-two modules; the Response 45--51 audits and Prompt 52 record; the top-two
searches; the Gamma evidence; and both the fixed fractional dual and its exact
global obstruction.
The verified research record now also includes the Response 52--54 audits,
the compiled conditional rectangle and fixed-reversal modules, the exact
matching-dependency theorem, the rejected strict energy target, and the
hardened finite Gamma dependency sweeps. None changes the unrestricted-open
status.

Every explicit axiom probe reports only subsets of `propext`,
`Classical.choice`, and `Quot.sound`. See
[the build log](research/lean-build-log.md) and
[proof-obligation ledger](docs/proof-obligations.md).

## Interpretation

`proved-lean` means Lean checked the stated declaration under the pinned
dependencies. `proved-math` means a manuscript proof passed independent audit
but has not been completely assembled in Lean. `computed` means reproducible
finite evidence only. `conditional`, `open`, and `rejected` have their literal
meanings. None of these labels may be promoted merely because a weaker theorem
compiles.
