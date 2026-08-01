# Modular pivot certificates

This note records the fifth GPT-5.6 Sol Pro research round and the independent
audit that followed it.  Everything here is restricted to a fixed tuple of
positive integers; no reduction from arbitrary real speeds is assumed.

Let `a = (a_1,...,a_n)`, put `N = n+1`, and choose a pivot `j`.  Set

\[
M_j=Na_j,\qquad
R_j=\{r\pmod {M_j}:N\nmid r\}.
\]

There are `(N-1)a_j` pivot-good residues.  At `t=r/M_j`, runner `i` is good
exactly when

\[
  \rho_{M_j}(ra_i)\ge a_j,
  \qquad \rho_M(x)=\min(\bar x,M-\bar x).
\]

For `i != j`, define the strictly bad set

\[
B_{ij}=\{r\in R_j:\rho_{M_j}(ra_i)<a_j\}.
\]

The strict inequality is essential: its complement gives the closed Lonely
Runner boundary `>= 1/N`.

## Exact single-set count and union certificate

Write

\[
g_{ij}=\gcd(a_i,Na_j),\qquad h_{ij}=\gcd(a_i,a_j).
\]

Then the exact cardinality is

\[
|B_{ij}|=
g_{ij}\left(2\left\lceil\frac{a_j}{g_{ij}}\right\rceil-1\right)
-h_{ij}\left(2\left\lceil\frac{a_j}{Nh_{ij}}\right\rceil-1\right).
\]

Indeed, multiplication by `a_i` modulo `Na_j` has kernel size `g_ij` and
image the multiples of `g_ij`.  Exactly
`2 ceil(a_j/g_ij)-1` image residues have cyclic distance strictly below
`a_j`.  The excluded residues `r=Ns` are counted modulo `a_j`; multiplication
there has kernel size `h_ij`, and the corresponding strict radius is `a_j/N`.
Subtracting gives the formula, including every boundary case.

Consequently, if for some pivot

\[
  \sum_{i\ne j}|B_{ij}| < (N-1)a_j,
\]

then an `r` outside the bad union remains and `r/(Na_j)` is a witness.  The
finite-union implication is kernel-checked as
`exists_mem_avoiding_of_sum_card_lt_card`; the number-theoretic cardinality
formula is presently proved on paper and exhaustively regression-tested, but
not yet formalized in Lean.

This criterion and the minimum-scale residue-band theorem are incomparable.
The pivot grids allow many more candidate numerators, but the union bound may
lose all useful overlap.  The band-covered tuples `(4,5,9)`, `(2,3,5,7)`, and
`(2,3,4,5,6)` fail this cardinality inequality at every pivot.  The
tuple `(1,2,4)` satisfies the simple union criterion at pivot `2` but fails the
band condition, proving the reverse non-implication. The
single-set union certificate implies the two-parent condition by taking
zero credited overlap. The simple union criterion does not subsume fast
insertion or the band theorem. No general implication between the two-parent
condition and either of those criteria has been proved; for three and four
moving runners, however, two parents can recover the exact bad union and hence
recognize every band witness.

## Ordered two-parent overlap certificate

Order the non-pivot indices as `i_1,...,i_(n-1)`.  At step `k >= 2`, choose
one or two earlier indices `P_k` and put

\[
L_k=\left|B_{i_kj}\cap\bigcup_{p\in P_k}B_{pj}\right|.
\]

If

\[
 |B_{i_1j}|+\sum_{k=2}^{n-1}(|B_{i_kj}|-L_k)<(N-1)a_j,
\]

then a good numerator remains.  Each selected-parent union is contained in
the full union already processed, so `L_k` is a lower bound on the actual
overlap at that step.  The final displayed expression is therefore an upper
bound on the complete bad union.  This abstract induction is kernel-checked
by `card_union_le_card_add_selected_remainder` and
`card_ordered_union_le_sum_selected_remainders`; the strict existential step
is `exists_mem_avoiding_ordered_of_sum_lt_card`.

## Exact bounded audit

All strictly increasing primitive tuples with largest speed at most 30 were
enumerated with exact integer bitsets.  Fast insertion was applied first, then
the minimum-scale band test, and the certificate tests were applied only to
the residual tuples.

| moving runners | primitive tuples | fast | band after non-fast | residual | union certificate | two-parent certificate |
|---:|---:|---:|---:|---:|---:|---:|
| 3 | 3,472 | 355 | 1,981 | 1,136 | 992 | 1,136 |
| 4 | 25,819 | 241 | 15,281 | 10,297 | 4,819 | 10,297 |
| 5 | 139,246 | 45 | 84,885 | 54,316 | 12,565 | 54,316 |

Reproduce the rows with:

```sh
python3 scripts/search_residual.py --runners 3 --max-speed 30 --primitive-only --sol-pivot-counts
python3 scripts/search_residual.py --runners 4 --max-speed 30 --primitive-only --sol-pivot-counts
python3 scripts/search_residual.py --runners 5 --max-speed 30 --primitive-only --sol-pivot-counts
```

The tight stress tuple `(1,9,10,11,12)` has pivot `9`, an ordered two-parent
upper bound `43 < 45`, and surviving numerator `r=26`.  Thus `t=13/27`, with
distances `13/27, 1/3, 5/27, 8/27, 2/9`, all above `1/6`.

The same checker includes a separate sufficient test at fastest-runner
half-periods `t=(2k+1)/(2V)`: if the sum of the other runners' exact bad-set
counts is below `V`, an uncovered `k` exists.  This certifies respectively
467, 735, and 2,792 of the residual tuples above; literal half-period witnesses
exist for 1,075, 10,094, and 52,306.  It is useful evidence but weaker than
the two-parent computation.

## Remaining obligations

The bounded audit is not a theorem for unbounded speeds.  A Lean end-to-end
certificate layer still needs: finite cyclic residue definitions; the exact
`|R_j|` and `|B_ij|` formulas; a checked encoding of pair/triple intersection
counts; parsing or generation of per-tuple certificates; and a theorem
connecting an uncovered residue to `circleNorm (t*a_i) >= 1/N`.

No uniform theorem ensuring a successful pivot and two-parent ordering is
known.  In particular, the computation does not supply a height bound for a
minimal counterexample, so exhaustive success through speed 30 has no
all-speed consequence.

A proposed adjacent-anchor strengthening was tested and rejected. The
primitive residual tuple `(1,2,3,4,5,7)` makes its proposed bound at least
`|R_j|` for every pivot, although exact bad-union sizes at two pivots are
strictly smaller than `|R_j|`. See `docs/failed-approaches.md`. Thus a uniform
proof must retain more flexible or higher-order overlap structure.
