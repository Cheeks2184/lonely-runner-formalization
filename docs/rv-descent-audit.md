# Residual-variation normalization and descent audit

This note isolates two exact invariances of `DISPERSION-STAR` (called
`RV-UNIF` in Sol Pro's response) and a precise obstruction to deletion
induction.  It does **not** prove `DISPERSION-STAR`, `ANCHOR-STAR`, the
three-anchor premise, or the Lonely Runner Conjecture.

## Notation and strict condition

Fix `n >= 4` positive integer speeds `a=(a_1,...,a_n)`, put `N=n+1`, choose
a pivot `j`, and write `A=a_j`, `M=N A`.  For `i != j`, let

```text
B_i = {0 <= r < M : N does not divide r,
       dist_M(a_i r,0) < A}.
```

The inequality is strict: residues at cyclic distance exactly `A` are good.
For a first anchor `h != j`, define the signed residual-variation surplus

```text
R_a(j,h) = D_j(h)
  + 1/(n-2) * sum_{q != j,h} E_j(q|h)
  + Delta_j(h) - (S_j - n A),
```

where `S_j=sum_{i != j}|B_i|`, and `Delta` is exactly the cellwise dispersion
in `gamma-arithmetic-audit.md`, with denominator `(n-2)(n-3)`.
`DISPERSION-STAR` succeeds exactly when `R_a(j,h)>0` for some ordered pair
`j != h`.  Equality is not a certificate.

## Common-scale homogeneity

**Lemma.** For every positive integer `g`, every pivot `j`, and every first
anchor `h != j`,

```text
R_(g a)(j,h) = g R_a(j,h).                                  (1)
```

In fact `S_j`, `D_j(h)`, every second-anchor gain, the numerator of `Delta`,
and `S_j-nA` are each multiplied by `g`.

**Proof.** Reduction modulo `M` gives a `g`-to-one map

```text
Phi : {0,...,gM-1} -> {0,...,M-1},   Phi(r)=r mod M.
```

Because `M=N A`, `N|r` if and only if `N|Phi(r)`.  Moreover

```text
(g a_i r) mod (g M) = g ((a_i Phi(r)) mod M),
dist_(gM)(g x,0) = g dist_M(x,0).
```

Consequently the scaled bad set is exactly `Phi^{-1}(B_i)`.  Every Boolean
combination of bad sets therefore has `g` times its old cardinality.  For
`Delta`, the scaled child and distinguished-anchor image cells have labels
`g x,g y`; each is the inverse image of the corresponding old cell and each
count `c_q(C)` is multiplied by `g`.  Absolute differences are homogeneous,
so the numerator of `Delta` is also multiplied by `g`.  The denominators only
depend on `n`.  Finally `n(gA)=g(nA)`, proving (1).  Notice that strictness and
the two good boundary targets are preserved exactly.

**Minimal-failure consequence.** If an all-pivot `DISPERSION-STAR` failure
exists, one exists with

```text
gcd(a_1,...,a_n)=1.
```

Indeed, divide a failure by its positive common gcd and apply (1) in the
reverse direction.  Positivity and pairwise distinctness survive the
division, and the sign (including equality) of every row is unchanged.  Thus
primitive normalization is a rigorous reduction, not merely a search
convention.

## A stronger fixed-pivot normalization

For one fixed pivot only, `R_a(j,h)` depends on every nonpivot coefficient
`a_i` through its signed residue class modulo `M=N A`:

```text
a_i' = plus-or-minus a_i (mod M) for every i != j
  implies R_(a')(j,h)=R_a(j,h) for every h != j.             (2)
```

The bad masks are unchanged because cyclic distance is periodic and even.
Changing the sign of the child coefficient or distinguished anchor merely
relabels its full image by `x -> M-x`; changing a comparison anchor leaves
its bad mask unchanged.  Hence the cell counts, their absolute differences,
and all pair terms are invariant.

This permits least-absolute-residue normalization when studying a single
pivot.  It is **not** a descent on valid global instances: signed reduction
can identify two distinct speeds, and changing one speed changes the modulus
when that speed is used as a different pivot.

## Deletion does not preserve a certificate row

A direct induction by deleting a runner would also have to cope with the
change from `N=n+1` to `N-1`.  The obstruction already occurs on the recorded
RF tuple.  Delete speed `2`, which is neither the displayed pivot nor anchor:

```text
full tuple:    (2,3,7,9,10,12,15,16,19),  N=10,
deleted tuple:   (3,7,9,10,12,15,16,19),  N=9.
```

For the same speed-valued pivot `A=15` and first anchor `h=19`, exact integer
evaluation gives

```text
R_deleted(15,19) = 42/5  > 0,
R_full(15,19)    = -41/7 < 0.                               (3)
```

Thus even a strict fixed-row certificate need not lift after inserting one
nonpivot, nonanchor runner.  Equation (3) does not refute a more elaborate
induction that changes pivot or anchor, but it rules out deletion monotonicity
as the missing lemma.

## Reproduction

`scripts/audit_rv_descent.py` checks the pullback of every bad mask residue by
residue, then checks every component of (1) for factors `2` and `3`.  It also
checks (2) after independently negating each nonpivot residue class and
recomputes the exact fractions in (3).

```sh
python3 scripts/audit_rv_descent.py
python3 -m unittest tests.test_rv_descent -v
```

The remaining unbounded problem is unchanged: prove that some primitive tuple
has a positive row, or construct a primitive positive distinct tuple on which
all rows are nonpositive.
