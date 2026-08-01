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
linear algebra, and `Fin.succAbove`. The missing central theorem is the
multidimensional character form of Kronecker approximation:

```lean
x in closure (Set.range (fun t : Real =>
      fun i => ((t * u i : Real) : UnitCircle))) <->
  forall a : Fin m -> Int,
    (sum i, (a i : Real) * u i = 0) ->
      sum i, a i • x i = 0
```

The pinned tree contains the one-circle theorem
`AddCircle.denseRange_zsmul_coe_iff`, but no suitable simultaneous theorem was
located. This theorem must be proved rather than introduced as a project axiom.
After it is available, the remaining work is rational-subspace algebra, finite
reindexing, topology, and reciprocal-bound arithmetic.
