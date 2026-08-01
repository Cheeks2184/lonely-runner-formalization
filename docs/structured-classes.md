# Two structured comparable-speed classes

These are audited partial results obtained in Sol Pro session 001, round 4.
The first is now formalized in `LonelyRunner/StructuredClasses.lean`; the
second remains a human-checked mathematical proof. Neither resolves the
general comparable-speed regime. Write

\[
  d(x)=\lVert x\rVert_{\mathbb R/\mathbb Z},\qquad N=n+1.
\]

## Minimum-scale residue bands

Let `n >= 2`, let `v_1,...,v_n` be nonzero real speeds, and order their
absolute values as `0 < a_1 <= ... <= a_n`. Suppose that for every `i` there
is an integer `q_i >= 0` such that

\[
 q_iN+1\le \frac{a_i}{a_1}\le q_iN+n.
\]

Then the explicit time `t=1/(Na_1)` satisfies `d(tv_i) >= 1/N` for every `i`.
Indeed, after ignoring the sign of `v_i`,

\[
 q_i+\frac1N\le |tv_i|\le q_i+1-\frac1N,
\]

which is precisely the closed good interval between the consecutive integers
`q_i` and `q_i+1`. Equivalently, every normalized ratio avoids the open gaps

\[
 (qN+n,\;qN+n+2),\qquad q=0,1,2,\ldots.
\]

Closed endpoints are essential. The tight tuple `(1,...,n)` lies in the first
band and attains the target at `t=1/(n+1)`. For `n=3`, `(1,2,5)` lies in two
bands and has distances `(1/4,1/2,1/4)` at `t=1/4`. Irrational ratios are
allowed whenever they lie in the bands.

## Two irrational rational-rank-one blocks

Let `n >= 2` and partition the indices into two nonempty sets `I` and `J`.
Suppose

\[
 v_i=\alpha m_i\quad(i\in I),\qquad
 v_j=\beta \ell_j\quad(j\in J),
\]

where all multipliers are nonzero integers and `alpha/beta` is irrational.
Define the smallest and largest absolute multiplier in each block by `m_-`,
`m_+`, `ell_-`, and `ell_+`. If

\[
 m_+<nm_-,\qquad \ell_+<n\ell_-,
\]

then there is a real time `t` for which every coordinate satisfies the strict
inequality `d(tv_k)>1/(n+1)`.

For the first block, start at `x_0=1/((n+1)m_-)`. The strict spread condition
allows an `epsilon>0` with

\[
 \frac1{n+1}<|m_i|(x_0+\epsilon)<\frac n{n+1}
\]

for every `i in I`; explicitly it is enough that

\[
 0<\epsilon<
 \frac{nm_- -m_+}{(n+1)m_-m_+}.
\]

Thus the simultaneous good set for the first block contains a nonempty open
arc. The same construction gives a nonempty open good arc for the second
block. Irrationality of `alpha/beta` is exactly the character criterion making
the continuous orbit `t -> (t alpha,t beta) mod Z^2` dense in the two-torus.
Concretely, choose `x` in the first open arc and take
`t_k=(x+k)/alpha`. The first coordinate is always `x mod 1`, while the second
coordinates form an irrational rotation because `beta/alpha` is irrational;
they therefore enter the second open arc. This is the one-dimensional
irrational-rotation case of Weyl's equidistribution theorem
(<https://doi.org/10.1007/BF01475864>). Hence the continuous orbit enters the
product of the two good arcs.

For example, `(1,2,3 sqrt(2))` with `n=3` is not covered by the first result:
`3 sqrt(2)` lies in the forbidden normalized gap `(3,5)`. It is covered here
using multipliers `(1,2)` in the first block and `(3)` in the second.

## Residual obstruction

These lemmas leave tuples having a normalized ratio in a forbidden band gap
and no partition into two irrationally related rational rank-one blocks with
internal multiplier spread strictly below `n`. This includes genuinely higher
rational-rank tuples, rational tuples with poorly placed ratios, and equality
cases where the displayed `x_0+epsilon` construction loses its guaranteed
positive margin. Equality does not imply that no other open good arc exists;
it simply requires a separate argument.

The first lemma is kernel-checked as
`LonelyRunner.minimumScaleResidueBands`. The second additionally requires a
formal two-torus density theorem. Neither may be used as a hidden
real-to-integer reduction.
