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

## Exact open bottleneck

Lean proves that the positive-integer conjecture is equivalent to a uniform
finite pivot-certificate proposition. The unresolved arithmetic step is to
show that every positive injective integer tuple has at least one pivot whose
strict modular bad sets do not cover all candidates—or to refute that exact
proposition. Current overlap, correlation, Chebyshev, descent, and residual
restrictions do not force such a pivot.

Active research branches are:

1. determine whether the coefficient-three bounded-height theorem can be
   improved further; the coefficient-two short-hole cases are classified,
   but the natural missing-to-extra Hall argument is refuted and no
   internal-blocker charging theorem is known;
2. construct uniform multi-shift affine transversals for arbitrary top pairs,
   or find a pair for which the required transversal inequality fails;
3. control or refute the full Chebyshev/CRT pivot score, after rejection of
   the quadratic shortcut;
4. strengthen the least-counterexample residual class until its conditions
   become incompatible;
5. formalize surviving statements and adversarially test every bridge.

## Latest verification

Last clean mathematical source checkpoint:
`9d45be484cb7dd91b4228e44ded7e66a9006e616`.

Pinned environment:

- Lean and mathlib `v4.32.1`;
- mathlib commit `520045ab14e26149ee970e2e617ca04b09bde5d6`;
- local authoritative replay: Python `3.14.4`, GCC `15.2.0`, Ubuntu 26.04
  under WSL2;
- public CI: Ubuntu hosted runner and Python 3.14.

Clean no-local-clone ext4 verification at that source checkpoint:

```text
Build completed successfully (3577 jobs) in 264.41 seconds.
Trust audit: 256 theorem reports; only propext, Classical.choice, Quot.sound
Ran 153 tests in 415.166s
OK
```

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
coefficient-three verification record and all 153 tests. The newer
fastest-interval checkpoint above awaits publication after this local audit
record.

This replay includes the unconditional Kanold interval, `17*t<=3*N`,
`5*t<=N`, `4*t<=N`, and `3*t<=N` height theorems; the primorial theorem;
both fastest-pivot restrictions; the saturated top-two class; the Response
45--49 audits and Prompt 50 record; the top-two searches; and both the fixed
fractional dual and its exact global obstruction.
The source was cloned with `git clone --no-local` into a fresh ext4 checkout;
the checkout was clean and its HEAD matched the checkpoint above before any
build or test ran.

The current replay fetched the pinned cache and ran with
`lake -Kjobs=2 build`; all 3,577 jobs completed in 264.41 seconds. The trust
audit then accepted 256 reports, and the unchanged full regression/certificate
suite ran 153 tests in 415.166 seconds. The checkout remained untouched and
clean throughout. The separately added Response 50 artifact plus independent
audit passed in 12.43 seconds with maximum RSS 19,252 KB.

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
