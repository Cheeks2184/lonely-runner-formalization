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

This residue layer is now kernel-checked in `LonelyRunner/PivotResidues.lean`:
`pivotCandidates`, `pivotBadResidues`, and `card_pivotCandidates` implement the
finite model; `circleNorm_nat_div_ge` proves the exact natural-residue to real
circle-distance step; `mem_pivotBadResidues_iff_circleNorm_lt` and
`not_mem_pivotBadResidues_iff_circleNorm_ge` identify the strict bad set and
its closed complement exactly; and `pivotResidueWitness` handles the pivot and
every non-pivot coordinate at the explicit time `r/(Na_j)`.

The converse is also kernel-checked in `LonelyRunner/PivotBoundary.lean`.
For every fixed nonempty positive-natural speed family and every `N≥2`,
`exists_witness_iff_exists_pivot_certificate` proves the exact equivalence

```text
(∃ t, ∀ i, N⁻¹ ≤ circleNorm (t * speeds i))
  ↔
∃ pivot r,
  r ∈ pivotCandidates N (speeds pivot) ∧
  ∀ i ≠ pivot,
    r ∉ pivotBadResidues N (speeds pivot) (speeds i).
```

Its forward direction takes a boundary point of the finite minimum-distance
function, extracts the tight coordinate's signed grid numerator, and reduces
that numerator to a natural candidate modulo `N a_j`; integral time shifts
preserve all natural-speed phases. The proof includes `N=2`. Globally,
`PositiveIntegerPivotCertificateConjecture` is the corresponding finite
certificate proposition, and
`positiveIntegerConjecture_iff_pivotCertificateConjecture` proves

```text
PositiveIntegerConjecture ↔ PositiveIntegerPivotCertificateConjecture.
```

This is an exact reformulation, not a proof that the required finite
certificate always exists. It also makes no reduction from arbitrary real
relative velocities to positive integers.

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
`exists_mem_avoiding_of_sum_card_lt_card`. The number-theoretic formula is
kernel-checked as `card_pivotBadResidues_exact` in
`LonelyRunner/PivotCounts.lean`; its proof includes strict cyclic-ball counts,
uniform multiplication fibers, the residues divisible by `N`, and the natural
subtraction step. The executable formula is also regression-tested against
literal bitsets.

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
| 6 | 588,559 | 1 | 348,630 | 239,928 | 97,395 | 239,928 |

Reproduce the rows with:

```sh
python3 scripts/search_residual.py --runners 3 --max-speed 30 --primitive-only --sol-pivot-counts
python3 scripts/search_residual.py --runners 4 --max-speed 30 --primitive-only --sol-pivot-counts
python3 scripts/search_residual.py --runners 5 --max-speed 30 --primitive-only --sol-pivot-counts
python3 scripts/search_residual.py --runners 6 --max-speed 30 --primitive-only --sol-pivot-counts
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

The six-runner row was added by an independent complete enumeration. Smaller
cutoffs `15,20,25` have respectively `2,240`, `14,120`, and `65,066` residual
tuples, all two-parent certified. A deterministic sample (seed `20260801`) of
5,000 primitive six-tuples from speeds through 200 contained 2,281 residual
tuples, all two-parent certified. The sample is evidence only.

The parent hierarchy is not cosmetic. `(1,2,3,5,7,8)` is the first tuple in
the complete speed-15 enumeration for which every one-parent certificate
fails. At pivot `5`, a two-parent ordering gives the exact bound `26<30`; the
surviving residue `r=6` gives `t=6/35`. For `(1,2,7,10,11,14)` at pivot `14`,
the best simple, one-parent, two-parent, three-parent, and full-history bounds
are respectively `110,78,70,66,64` against universe size `84`. Thus even three
parents need not recover the exact union.

Negation of residues preserves every candidate and bad set and has no fixed
point among candidates. Hence all bad unions and witness complements have even
cardinality; every successful strict certificate has slack at least two. This
explains, but does not force, the minimum slack observed in the six-runner
search.

The next exact boxes test where the fixed two-parent choice stops being
universal. For seven moving runners through speed 20, all 28,259 primitive
residual tuples are two-parent certified. For eight moving runners through
speed 15, 1,714 of 1,716 residual tuples are two-parent certified. The two
failures are

```text
(1,2,5,7,9,11,12,13)
(1,5,7,8,9,11,13,15)
```

Both pass a three-parent certificate at pivot `7`, with bound `50<56`.
Surviving residues `8` and `20` give witnesses `8/63` and `20/63`. Thus the
round-6 half-parent rule remains compatible with this finite box, but the
stronger claim that two parents always suffice is false even at speed 15.

## Remaining obligations

The bounded audit is not a theorem for unbounded speeds. The finite cyclic
residue definitions, exact `|R_j|` and `|B_ij|`, both directions of the
fixed-instance witness/certificate equivalence, and the global equivalence
with `PositiveIntegerConjecture` are now in Lean. A checked layer for the
stronger *compressed overlap certificates* would still need encodings of
pair/triple/higher intersection counts and reproducible parsing or generation
of per-tuple certificate data.

No uniform theorem ensures that the bad-set union is proper for some pivot,
or even that a successful half-parent ordering exists. In particular, the
computation supplies no speed-height bound for a minimal counterexample, so
exhaustive success through speed 30 has no all-speed consequence. The exact
global equivalence merely identifies this certificate-existence statement as
the positive-integer LRC itself.

Finally, none of this proves the separate reduction from arbitrary real
relative velocities to positive integers. The required simultaneous
approximation/Kronecker argument and its preservation of the closed threshold
remain outside the current Lean development.

A proposed adjacent-anchor strengthening was tested and rejected. The
primitive residual tuple `(1,2,3,4,5,7)` makes its proposed bound at least
`|R_j|` for every pivot, although exact bad-union sizes at two pivots are
strictly smaller than `|R_j|`. See `docs/failed-approaches.md`. Thus a uniform
proof must retain more flexible or higher-order overlap structure.
