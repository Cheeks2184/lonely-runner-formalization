# Project status

Status date: 2026-08-02. Authoritative branch: `main`.

Unrestricted Lonely Runner Conjecture: **open**. This repository contains no
claim that it has been proved or disproved.

## Strongest verified theorem

The strongest fully Lean-verified bounded-height result is
`LonelyRunner.logarithmicHeight_family_witness`. Let `N,t>=1`. If

```text
(4*(Nat.log 2 N+1)+1)*t <= N,
```

then every injective family of `N-1` positive integer speeds bounded by `N+t`
has one common real time at closed circular distance at least `1/N` for every
speed. `logarithmicHeightGain_positiveInteger_witness` gives the explicit gain

```text
N div (4*(Nat.log 2 N+1)+1)
```

using exactly the `UnitCircle` norm in the positive-integer formulation.

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
  bounded-height theorem, and the logarithmic bounded-height theorem above.
- **Audited manuscript plus reproducible finite certificate:** every integer
  speed family of maximum at most `n+5` is lonely. Its finite core covers
  134,568 configurations; it is not yet one Lean theorem.
- **Finite evidence only:** targeted full Chebyshev/CRT score searches. No
  finite search implies a uniform theorem.
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

1. improve the logarithmic bounded-height gain using sharper explicit
   `c/phi(c)` estimates;
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
suite. This is a CI environment repair, not a reduced verification target.

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
