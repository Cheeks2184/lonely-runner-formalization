# Canonical statement

Research cutoff: 2026-08-01.

For a real number `x`, write

\[
  \lVert x\rVert_{\mathbb R/\mathbb Z}
  = \inf_{m\in\mathbb Z}|x-m|
  = \min(\operatorname{fract}(x),1-\operatorname{fract}(x)).
\]

This is the shorter-arc distance between `x mod 1` and the origin on a unit
circle. Its values lie in `[0, 1/2]`.

## Runner formulation

For every integer `N >= 2`, every injective speed vector
`s : Fin N -> R`, and every runner `i : Fin N`, there exists a time `t : R`
such that

\[
  \forall j\ne i,\qquad
  \lVert t(s_j-s_i)\rVert_{\mathbb R/\mathbb Z}\ge \frac1N.
\]

Important conventions:

- All runners start at the same point at time zero.
- Speeds are arbitrary real numbers and are pairwise distinct. Zero and
  negative speeds are allowed.
- The quantifiers are `for every runner, there exists a time`; different
  runners may have different witness times.
- The boundary is closed (`>=`), not strict. This is forced by tight examples.
- The conjecture concerns circular distance, not an oriented fractional part.

## Stationary-runner formulation

After subtracting the chosen runner's speed, put `n = N - 1`. The stationary
form is

\[
  \forall n\ge1\;\forall v_1,\ldots,v_n\in\mathbb R\setminus\{0\},\;
  \exists t\in\mathbb R\;\forall i,\quad
  \lVert tv_i\rVert_{\mathbb R/\mathbb Z}\ge\frac1{n+1}.
\]

The tuple is often allowed to contain repetitions. Removing repetitions and
using the stronger lower-dimensional bound justifies this only for the global
all-dimensions conjecture; it is a dependency that must not be hidden in a
fixed-dimension theorem.

## Integer formulation

The standard integer formulation quantifies over finite sets of distinct
positive integers. A common factor can be divided out. For integer speeds the
time variable is periodic modulo one, so a maximum on `[0,1]` is attained.

The reduction from arbitrary real speeds to integers is not a direct
"clear denominators" step. It uses Kronecker approximation and, in a standard
proof, lower-dimensional cases. The formal development must either prove this
reduction with its induction hypotheses or keep the real and integer statements
separate.

## Primary formulation sources

- Bohman, Holzman, and Kleitman, *Six Lonely Runners*, especially the closed
  interval formulation and real-to-rational reduction:
  <https://doi.org/10.37236/1602>
- Perarnau and Serra, *The Lonely Runner Conjecture turns 60*, Conjectures 1,
  2, and 4 (modern survey used to locate the primary chain):
  <https://arxiv.org/abs/2409.20160>
- Malikiosis, Santos, and Schymura, *Linearly-exponential checking is enough
  for the Lonely Runner Conjecture and some of its variants*, Conjecture A:
  <https://doi.org/10.1017/fms.2025.10107>
