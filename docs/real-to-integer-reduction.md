# Exact real-to-rational reduction

This note records the dependency-safe reduction used in Section 4, Lemma 8 of
Bohman--Holzman--Kleitman, *Six Lonely Runners*
(<https://www.combinatorics.org/ojs/index.php/eljc/article/download/v8i2r3/pdf/>),
pp. 12--13. It is a literature theorem and has not yet been formalized in this
repository.

For a positive real `m`-tuple `v`, write

\[
 G_{\ge}(v,c)\iff
 \exists t\in\mathbb R\ \forall i,\quad
 \lVert tv_i\rVert_{\mathbb R/\mathbb Z}\ge c,
\]

and define `G_>(v,c)` analogously.

## Fixed-dimensional theorem schema

Let `m >= 2` and `0 < c < d <= 1/2`. Assume:

1. every positive rational `m`-tuple `q` satisfies `G_>=(q,c)`;
2. every positive rational `(m-1)`-tuple `q` satisfies `G_>=(q,d)`.

Then every positive real `m`-tuple satisfies `G_>=(v,c)`. If the tuple has a
pair with irrational ratio, the conclusion actually has strict slack:
`G_>(v,c)`.

For LRC take

\[
 c=\frac1{m+1},\qquad d=\frac1m.
\]

Thus the exact fixed-dimensional dependency is

\[
 \operatorname{RatLRC}(m)\land\operatorname{RatLRC}(m-1)
 \Longrightarrow \operatorname{RealLRC}(m).
\]

It is not the same-dimensional instruction "clear denominators." Globally,
induction over `m`, followed by clearing denominators only for rational tuples,
gives the usual integer equivalence.

The denominator-clearing component is now kernel-checked in
`LonelyRunner/RationalReduction.lean`. The definition
`rationalCommonDenominator` takes the product of the positive reduced
denominators, and `clearRationalSpeed` constructs the corresponding positive
natural speed. The theorems `clearRationalSpeed_cast`,
`clearRationalSpeed_pos`, and `clearRationalSpeed_injective` prove the cast,
positivity, and distinctness obligations. Consequently

```text
PositiveIntegerConjecture ↔ DistinctPositiveRationalConjecture
                           ↔ PositiveRationalConjecture
```

The first equivalence is
`positiveIntegerConjecture_iff_distinctPositiveRationalConjecture`, with the
forward witness time multiplied by the common denominator. The second is
`distinctPositiveRationalConjecture_iff_positiveRationalConjecture`: it
enumerates the finite range of a repeated tuple, applies the all-dimensional
distinct statement in cardinality `m ≤ n`, and weakens the stronger
`1/(m+1)` bound to `1/(n+1)`. The composed theorem is
`positiveIntegerConjecture_iff_positiveRationalConjecture`. These are the
elementary rational-to-integer and repetition steps only; they do not address
irrational real ratios.

## Irrational-ratio branch

BHK Lemma 8, reindexed, says that for `0 < delta < 1/2`, if every positive
rational `(m-1)`-tuple has a strict `delta`-good time, then every positive real
`m`-tuple containing an irrational speed ratio has a strict `delta`-good time.

For `u in R^m`, define

\[
 M(u)=\{tu-k:t\in\mathbb R,\ k\in\mathbb Z^m\}.
\]

Choose a rational matrix `A` whose rows form a basis of all homogeneous
rational relations among the coordinates of `u`. Generalized Kronecker
approximation gives

\[
 \overline{M(u)}=\ker(A_\mathbb R)+\mathbb Z^m.
\]

The rational subspace `K=ker(A_R)` contains a strictly positive rational vector
`r`, since it contains the strictly positive vector `u` and rational points are
dense in a rational subspace. An irrational coordinate ratio implies
`dim K >= 2`; choose a rational `s in K` not proportional to `r`.

Choose adjacent distinct values among the finite set `s_k/r_k`, say

\[
 \frac{s_i}{r_i}<\frac{s_j}{r_j},
\]

with no ratio strictly between them, and put

\[
 w=(r_i+r_j)s-(s_i+s_j)r.
\]

Then `w_i=-w_j != 0`, and every coordinate of `w` is nonzero. Indeed,
`w_k=0` would force `s_k/r_k` to equal the strictly intermediate weighted
average `(s_i+s_j)/(r_i+r_j)`.

Consequently the `m` values `|w_k|` contain at most `m-1` distinct positive
rationals. Delete coordinate `j`; coordinate `i` still represents `|w_j|`.
The lower-dimensional strict hypothesis supplies a time placing every signed
coordinate of `w` in the open good cube `(delta,1-delta)^m`.

Because `w in K`, this cube meets `closure(M(u))`. The cube is open, so it also
meets `M(u)` itself. This last openness step is what converts orbit closure into
an actual witnessing time without losing the boundary.

For the LRC constants, choose any

\[
 \frac1{m+1}<\delta<\frac1m.
\]

The closed lower-dimensional `1/m` theorem supplies the required strict
`delta` hypothesis, and the resulting strict `delta` witness is stronger than
the current `1/(m+1)` target.

## Rational-collinear branch

If no pair has irrational ratio, choose a base coordinate `u_j`. Every
`u_i/u_j` is a positive rational, so `u=u_j q` for a positive rational tuple
`q`. Apply the current-dimensional rational theorem to `q` and rescale time by
`1/u_j`.

Negative speeds are handled coordinatewise by
`circleNorm_neg`; repetitions are handled by the already formalized
lower-dimensional deduplication theorem. For the repository's distinct
positive-natural formulation, a fixed `m`-dimensional real instance can
therefore depend on integer statements in several lower dimensions, not just
dimension `m`.

There is one interface distinction that must remain explicit. The BHK
fixed-dimensional schema uses arbitrary positive rational tuples, including
repetitions, while `DistinctPositiveRationalConjecture` is injective. The
all-dimensional Lean theorem bridges this by deduplicating and invoking the
distinct conjecture in the smaller cardinality; it therefore uses the global
quantification over every dimension. If one instead assumes an injective
statement only at one fixed cardinality and wants the same-cardinality BHK
hypothesis, a separate padding lemma is still required. The current global
reduction needs no such lemma. Sign normalization can create repetitions, so
the repeated formulation remains essential.

## Closure-only warning

Henze--Malikiosis, Theorem 2.2 and Lemmas 2.3 and 5.3
(<https://arxiv.org/pdf/1609.01939>), give a clean character description of the
orbit closure and an integer vector whose orbit closure is contained in the
original one. This suffices for equality of universal supremal loneliness
constants. By itself it yields witnesses at every strictly smaller threshold,
or a supremum bound at the closed threshold; it does not automatically produce
an attained witness on a nonclosed orbit. BHK's lower-dimensional slack and
open-cube argument is the endpoint-safe route for the repository's existential
statement.

## Lean dependency map

Mathlib v4.32.1 already provides finite tori, compact topological groups,
closure/open-set lemmas, dense rational casts, finite-dimensional rational
linear algebra, and `Fin.succAbove`. The missing central theorem is the reverse
direction of the multidimensional character form of Kronecker approximation:

```lean
x in closure (Set.range (fun t : Real =>
      fun i => ((t * u i : Real) : UnitCircle))) <->
  forall a : Fin m -> Int,
    (sum i, (a i : Real) * u i = 0) ->
      sum i, a i • x i = 0
```

The pinned tree contains the one-circle theorem
`AddCircle.denseRange_zsmul_coe_iff`, but no suitable simultaneous theorem was
located. The full equivalence is stronger than BHK needs. It suffices to prove
the following one-way, pointwise form: whenever every integer relation
annihilating `u` also annihilates `w`, the point `tau*w mod 1` belongs to the
closure of the continuous orbit `t*u mod 1`, for every real `tau`. This is
still the hard generalized Kronecker direction.

A plausible proof route is closed-subgroup character separation. If `H` is a
closed subgroup of a finite unit torus and `x` is not in `H`, Haar-average a
continuous function separating `H` and `x+H`, approximate it by the dense
multivariate Fourier algebra, and use character orthogonality on `H` to find
an integer character trivial on `H` but nontrivial at `x`. Mathlib contains
finite tori and `UnitAddTorus.mFourierSubalgebra_closure_eq_top`, but the
subgroup-averaging and separation-character theorem are not packaged and have
not yet been compiled here. They must be proved rather than introduced as a
project axiom.
