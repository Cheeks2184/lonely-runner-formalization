# Project status

Status date: 2026-08-02. Authoritative branch: `main`.

Unrestricted Lonely Runner Conjecture: **open**. This repository contains no
claim that it has been proved or disproved.

## Strongest verified theorem

The strongest fully Lean-verified bounded-height result is
`LonelyRunner.fourHeight_family_witness`. If `n+1=N`, `t>0`, and
an injective family of `n` positive integer speeds is bounded by `N+t`, then

```text
4*t <= N
```

implies one common real time at closed circular distance at least `1/N` for
every speed. `kanoldIntervalBound_vandermonde` proves, rather than assumes,
that every half-open interval of `2^omega(c)` consecutive natural numbers
contains a number coprime to positive `c`. Its proof uses an exact
roots-of-unity powerset expansion and a Vandermonde system with pairwise
distinct nodes. `four_short_interval_exception_classification` proves that a
selected missing modulus can have a short interval only at twelve exact
triples. Nine explicit coprime denominators and three complementary-hole
repairs at `(4,1,2)`, `(11,2,6)`, and `(20,5,12)` close every family. These
results do not prove unrestricted LRC.

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
than the `17/3` theorem above.

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
- **Lean-verified fastest-pivot restriction:** if the maximum positive integer
  speed `B` satisfies `B<=(N-1)*s` for every speed `s`, the explicit numerator
  `r=N-1` is a fastest-pivot certificate and gives a common closed `1/N`
  witness. Consequently, failure at the fastest pivot forces
  `(N-1)*a_min<a_max`. This is only a necessary condition for a failed
  fastest/top-two strategy, not a proof that a top pivot always succeeds.
- **Finite evidence only:** targeted full Chebyshev/CRT score searches and the
  top-two pivot stress certificate. The latter checks 878,245 primitive box
  tuples plus 86,745 structured mutations without a failure; it is a proposed
  strengthening that would imply LRC, not a proved reduction or theorem. No
  finite search implies a uniform result.
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

1. determine whether the coefficient-four bounded-height theorem can be
   improved further; the coefficient-three arbitrary-hole selector has an
   infinite zero-length regime whose possible family repairs are under audit;
2. control or refute the full Chebyshev/CRT pivot score, after rejection of
   the quadratic shortcut;
3. strengthen the least-counterexample residual class until its conditions
   become incompatible;
4. formalize surviving statements and adversarially test every bridge.

## Latest verification

Last clean mathematical source checkpoint:
`56d00efcf75b916c474609648fd23a83ad8ea33d`.

Pinned environment:

- Lean and mathlib `v4.32.1`;
- mathlib commit `520045ab14e26149ee970e2e617ca04b09bde5d6`;
- local authoritative replay: Python `3.14.4`, GCC `15.2.0`, Ubuntu 26.04
  under WSL2;
- public CI: Ubuntu hosted runner and Python 3.14.

Clean no-local-clone ext4 verification at that source checkpoint:

```text
Build completed successfully (3573 jobs).
Trust audit: 240 theorem reports; only propext, Classical.choice, Quot.sound
Ran 153 tests in 308.615s
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
unconditional Kanold build, 235-report trust audit, and all 153 tests. The
coefficient-five source checkpoint above awaits publication after this local
audit record.

This replay includes the unconditional Kanold interval, `17*t<=3*N`, and
`5*t<=N` height theorems, the primorial theorem, the Response 45--48 audits,
the top-two searches, and both the fixed fractional dual and its exact global
obstruction.
The source was cloned with `git clone --no-local` into a fresh ext4 checkout;
the checkout was clean and its HEAD matched the checkpoint above before any
build or test ran.

The coefficient-five replay fetched the pinned cache and ran with
`lake -Kjobs=2 build`; all 3,573 jobs completed. A preceding timing-wrapper
invocation did not start Lean because its arguments were lost at the
PowerShell-to-WSL boundary, and is not counted as a build attempt. The trust
audit and full test suite above ran only after the successful direct build.

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
