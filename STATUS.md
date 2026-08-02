# Project status

Status date: 2026-08-02. Authoritative branch: `main`.

Unrestricted Lonely Runner Conjecture: **open**. This repository contains no
claim that it has been proved or disproved.

## Strongest verified theorem

The strongest fully Lean-verified bounded-height result is
`LonelyRunner.boundedPrimorialHeight_family_witness`. Let `P_N` be the largest
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

This theorem does not prove unrestricted LRC.

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
- **Conditional Lean theorem:**
  `seventeenThirdsHeight_family_witness_of_kanold` proves that
  `17*t<=3*N` and maximum speed at most `N+t` give the same closed `1/N`
  witness, assuming the exact half-open interval proposition
  `KanoldIntervalBound`. Lean verifies the `c<=6` cases, the estimate
  `5*2^omega(c)<=2*c` for `c>=7`, and every endpoint. A self-contained Lean
  proof of the interval bound remains open. The coefficient-six declaration
  is retained as a corollary.
- **Audited manuscript proof:** Response 46 proves the Kanold interval bound
  independently by a roots-of-unity expansion and an invertible Vandermonde
  system, and sharpens the conditional height arithmetic to `17*t<=3*N`.
  The proof has passed mathematical audit but its algebraic core is not yet
  kernel-checked; [the audit](docs/response46-audit.md) records the boundary.
- **Finite evidence only:** targeted full Chebyshev/CRT score searches and the
  top-two pivot stress certificate. The latter checks 878,245 primitive box
  tuples plus 86,745 structured mutations without a failure; it is a proposed
  strengthening that would imply LRC, not a proved reduction or theorem. No
  finite search implies a uniform result.
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

1. formalize the audited roots-of-unity/Vandermonde proof of Kanold's
   Jacobsthal bound; the conditional `17*t<=3*N` bounded-height theorem, its
   coefficient-six corollary, and interval arithmetic compile in
   `KanoldHeight.lean`;
2. control or refute the full Chebyshev/CRT pivot score, after rejection of
   the quadratic shortcut;
3. strengthen the least-counterexample residual class until its conditions
   become incompatible;
4. formalize surviving statements and adversarially test every bridge.

## Latest verification

Last clean mathematical source checkpoint:
`6b100209c6078579ae0660b6479743eaefbab9ec`.

Pinned environment:

- Lean and mathlib `v4.32.1`;
- mathlib commit `520045ab14e26149ee970e2e617ca04b09bde5d6`;
- local authoritative replay: Python `3.14.4`, GCC `15.2.0`, Ubuntu 26.04
  under WSL2;
- public CI: Ubuntu hosted runner and Python 3.14.

Clean ext4 verification at that source checkpoint:

```text
Build completed successfully (3562 jobs).
Ran 147 tests in 272.894s
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

The current combined primorial/Kanold Lean integration also builds cleanly in
the ext4 verification checkout: `Build completed successfully (3571 jobs)`.
The trust audit accepts 225 theorem reports and finds only `propext`,
`Classical.choice`, and `Quot.sound`. These source changes do not alter the
Python certificate computations; a new full-suite replay is required at the
next committed checkpoint.

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
