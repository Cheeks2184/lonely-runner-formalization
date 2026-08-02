# Global top-two fractional-dual obstruction

## Status

**Exact rejection of a proposed proof invariant, not a counterexample to the
top-two pivot conjecture or LRC.** For `n=6`, `N=7`, and numerical top speeds
`B=98<A=187`, an exact rational fractional cover has mass strictly below the
four-lower-speed budget. Weak set-cover duality therefore makes the proposed
global fractional-dual certificate impossible for this pair. Exhaustive
enumeration separately proves that no four actual lower speeds cover the
two-grid candidate set, so the corresponding integral top-two claim survives
this test.

## Two-grid instance

For pivot `p` and residue `r` modulo `7p`, retain `r` precisely when

```text
r mod 7 != 0
rho_(7p)(r * other_top) >= p.
```

These are the pivot candidates that are safe for the pivot and the other top
speed. The disjoint union contains exactly 1,224 vertices: 420 in the
`p=98` grid and 804 in the `p=187` grid. A possible lower speed is any
`x=1,...,97`; it covers a vertex `(p,r)` when

```text
rho_(7p)(r*x) < p.
```

## Exact fractional-cover certificate

Give lower speed `x` weight `q_x/241`, where the numerators in order
`x=1,...,97` are

```text
12,14,17,13,17,22,13,15,21,17,11,19,17,12,18,10,
11,14,10,16,9,11,10,20,12,18,6,13,7,18,4,12,11,6,
11,21,9,15,13,10,8,16,9,7,10,8,5,16,4,14,5,12,4,
16,8,6,10,7,3,24,7,7,6,0,15,12,4,7,8,7,5,11,5,
6,15,4,4,17,5,11,5,5,5,6,7,3,3,6,2,12,5,2,4,1,
8,4,1
```

Their sum is `962`, whereas four units have scaled numerator
`4*241=964`. At every one of the 1,224 vertices, the sum of numerators for
covering lower speeds is at least `248`, hence at least `241`. This is a
feasible fractional cover of exact mass

```text
962/241 < 4.
```

For any proposed nonnegative vertex-dual weights whose total bad weight is at
most one for each lower speed, finite weak duality gives

```text
total vertex weight <= total fractional-cover weight = 962/241 < 4.
```

Thus no dual of the proposed global form can have the required mass greater
than `n-2=4`. The global fractional-dual invariant is refuted.

## What remains open

Fractional lower-speed weights are not a family of four distinct integer
speeds. The verifier exhausts all

```text
choose(97,4) = 3,464,840
```

four-speed subsets and finds no integral cover. The best subset in enumeration
order is `(3,89,92,95)`; it covers 1,142 vertices and leaves 82. Therefore
this certificate does **not** refute the integral top-two pivot conjecture,
which remains open, and it says nothing negative about LRC itself.

The earlier fixed pair `(n,N,B,A)=(7,8,14,16)` still has its exact successful
dual certificate in [top-two-fractional-dual.md](top-two-fractional-dual.md).
One successful instance is compatible with failure of the proposed uniform
invariant.

## Reproduction

Run:

```bash
bash scripts/audit_top_two_fractional_obstruction.sh
python3 -m unittest tests.test_top_two_fractional_obstruction -v
```

The verifier uses Python integer arithmetic only. It checks every fractional
constraint and every four-speed subset, compares canonical output byte for
byte, and validates hashes of both the verifier and expected output:

```text
output  205912a1148c3d3a1d4c1b86e7f4ec3a67cd7440e8410ab4f1ffaeccf77e96bb
source  ef1bf255ec6874d287f1c9b2ed50ff9913a0d65dd06d780739992402a5ff9a52
```
