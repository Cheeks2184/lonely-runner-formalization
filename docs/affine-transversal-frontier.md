# Affine-transversal frontier after the empty-grid audit

Status: the abstract certificate implication is Lean-formalized; the proposed
unconditional paired-transversal existence theorem is **refuted**. This note
does not refute the top-two pivot conjecture or Lonely Runner.

## Canonical robust grids

For top speeds `0<A<B`, define

```text
R_A={r in pivotCandidates(N,A): r notin pivotBadResidues(N,A,B)},
R_B={r in pivotCandidates(N,B): r notin pivotBadResidues(N,B,A)}.
```

Thus the other top runner is good at every robust residue. Because the bad
sets are strict, equality at cyclic distance `A` or `B` remains in the robust
set.

For any finite pair family `C subset R_A x R_B` and lower-speed set `S`, say
that `S` is a two-sided transversal when every `(r_A,r_B) in C` has some
speed of `S` bad at `r_A` and some, possibly different, speed of `S` bad at
`r_B`.

`LonelyRunner/TopTwoTransversal.lean` defines these objects without assuming
that the pairs arise from affine fibers. It proves two exact implications:

1. if `S` covers both complete robust grids, then it is a two-sided
   transversal for every selected robust pair family;
2. if `S` is not a two-sided transversal, one selected endpoint is a pivot
   candidate, is good for the other top runner, and avoids the strict bad set
   of every speed in `S`.

The second endpoint is therefore a complete modular certificate at one of the
two top pivots. The unproved arithmetic work is entirely in constructing a
pair family that forces nontransversality for every admissible lower set.

## Exact refutation of unconditional paired existence

The target

```text
for every N,A,B there is H with tau_H(A,B)>N-3
```

is false for the paired-robust definition. Take

```text
N=4, A=2, B=8.
```

Every `A`-candidate satisfies

```text
rho_8(8*r)=0<2.
```

Hence `R_A` is empty. Every robust affine pair family is empty for every
shift set `H`, so the empty lower set is vacuously a transversal and
`tau_H=0<=1=N-3`.

This is not a top-two or LRC counterexample. The three-speed family

```text
(1,2,8)
```

has a certificate at pivot `B=8` with numerator `r=9`: modulo `32`, the
cyclic distances for speeds `1,2,8` are respectively `9,14,8`, all at least
the closed threshold `8`.

The counterexample rejects only the unconditional paired bridge. A usable
uniform frontier must be disjunctive. With `k=N-3`, it is sufficient to prove
one of:

```text
kappa_A>k,
kappa_B>k,
both robust grids are nonempty and some selected pair family has tau>k.
```

The first two branches give a certificate at one pivot directly. The third
uses the Lean-formalized nontransversal bridge.

## All shifts are tautological

When both robust grids are nonempty, taking every affine shift selects their
entire Cartesian product: each robust pair lies in its unique affine fiber.
A lower set is then a two-sided transversal exactly when it covers both
complete robust grids. Thus the all-shift transversal number is merely the
minimum size of a common cover. It restates the fixed-top top-two question and
does not provide a new proof mechanism.

## Remaining obligation

Find an arithmetic disjunction of the form above for every admissible top pair,
or produce a genuine fixed-top common cover showing the top-two strengthening
false. Any paired-fiber theorem must handle empty robust grids explicitly and
must choose its shift family from `N,A,B` before seeing the lower-speed set.
