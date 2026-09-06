# Independent review of wall exchanges and fractional incidence

**Accepted as manuscript results, with no algebraic correction required.**
The simultaneous wall rule, both actual-midpoint count controls, the exact
capped fractional optimum N/2, and the additive-score obstruction are valid.
For precision, section 2 below fixes the periodic convention at endpoint
walls. Cell indices, rather than necessarily different incidence sets,
are the objects subject to distinctness and the cap one.

Review date: 2026-09-06. Task `/root/ideal_row_carry_review`, in the requested
existing Astra/xhigh session. Review checkpoint:
`17ca4ebd817534c5fbba0d36b024a0f69e189ed4`.
The complete frozen author file reviewed is
`research/astra-ideal-row-carry-exclusion.md`, SHA-256
`689c3255596a4fb9dfc8935d0bf6ac40775415e1782dc7c09ccbfdb3b30df286`.
Its recorded author checkpoint is
`15ef35a75c255f3fcdaafe8fb289f1fe6d97ee30`.

The finite-cell definitions and first-section equivalence were read in
`research/astra-ideal-row-finite-cell-reduction.md`, SHA-256
`44aca4f3cff905074d315515fb88a08b0957b9b200d016c34f55dce3701ac1fb`.
The other contextual source remains
`research/astra-ideal-row-selection-audit.md`, SHA-256
`20752d3a362a153d4cdaa2f30373c01002fa0dd3ed708b3bf1d1b4a4d67c77b7`.
No integer-transfer claim or numerical result in those sources is a premise
of this review, and the separate pending integer-feasibility task was neither
read nor used.

## 1. Objects, boundaries, and the finite-cell obligation

Fix an integer `N>=5` and `b=N-2`. The pair universe is the b regular rows
with all N integer centres, together with the single exceptional pair
`(N-1,0)`. A slope x covers a pair `(k,h)` exactly when `d_N(kx,h)<1`.
Thus distance one is good. Replacing the ordinary digit ell by `h=-ell`
preserves the full regular universe and leaves the exceptional centre zero.

The cuts are all `j/k in [0,N]` for integral j and `1<=k<=N-1`.
Within each consecutive open cell I, every strict bad predicate is
constant: its boundary requires `kx=Nz+h+1` or `Nz+h-1`, which is integral.
At the midpoint x_I, `kx_I` is nonintegral for all those k, since otherwise
the midpoint would itself be a cut inside its cell.

The used finite-cell equivalence is valid. A hypothetical real-slope cover
has, for each of finitely many pairs, at least one strict bad owner. These
selected inequalities survive a sufficiently small simultaneous perturbation
of the slopes off all cuts. Periodicity permits representatives in `(0,N)`,
including a small positive move from zero. Midpoint replacement then preserves
the masks. Repeated cell choices can be discarded and the list padded to b
distinct cells, since the integer cuts alone guarantee at least N cells.
Adding masks preserves a cover. Conversely, a midpoint-cell cover is an
actual real-slope cover.

Here two different cells are allowed to produce equal subsets of pairs.
There is one variable or choice for each cell index I. The phrases
"distinct midpoint masks" and "distinct masks" in this context are read as
distinct midpoint-cell choices, consistently with the author's later explicit
"distinct-cell" wording and the finite-cell source. No claim of pairwise
different incidence sets is needed.

## 2. Simultaneous wall exchange, including endpoint walls

For an interior reduced wall `x_0=a/q` with q positive, `kx_0` is integral
if and only if `q|k`. For each changing regular row put `m=ka/q`. Just
before, at, and just after the wall, the bad integer centres are respectively

`{m-1,m}`, `{m}`, `{m,m+1}` modulo N.

At the wall both neighbours have distance exactly one and are good. Rows
not divisible by q have no predicate boundary there. Constancy on the
adjacent open cells extends the local description to their midpoints.

The endpoint convention is as follows: either restrict this statement to
`0<x_0<N`, or extend the cut pattern periodically to the real line, as
permitted by the source's stated `B(x+N)=B(x)`. In the periodic interpretation,
the cell just left of zero is the last cell of `(0,N)` translated by minus
N, and the cell just right of N is the first cell translated by N. An
ordinary interval endpoint has no second adjacent cell inside `[0,N]`;
the periodic convention supplies the intended one. At both endpoint walls,
q=1 and every regular row has `m=0 mod N`, so the displayed change is
`{-1,0}` to `{0,1}`, with `{0}` at the wall. All formulas remain valid.

For the exceptional row, a change is possible only if `q|(N-1)`. Its
integer wall value m gives the following membership of centre zero:

| m modulo N | Before | At wall | After |
| --- | --- | --- | --- |
| 1 | bad | good | good |
| -1 | good | good | bad |
| 0 | bad | bad | bad |
| any other residue | good | good | good |

These cases follow directly from the open radius-one arc. In particular,
the exceptional pair remains bad at the periodic endpoint walls.

Let L consist of all outgoing pairs and G of all incoming pairs, including
the exceptional changes in the table. They are disjoint: different regular
rows have different pair labels, and within a row the two centres differ
by two, which is nonzero modulo `N>=5`. The exceptional pair cannot be
both outgoing and incoming. In fact `L=B(x_-)\B(x_+)` and
`G=B(x_+)\B(x_-)`. Therefore

```
B(x_+) = (B(x_-) minus L) union G,
B(x_0) = B(x_-) intersect B(x_+).
```

For fixed other-owner union U, the only newly covered pairs are `G\U`
and the only lost covered pairs are `L\U`. Hence the exact difference is

`|U union B(x_+)|-|U union B(x_-)|=|G\U|-|L\U|`.

If the old union already covers the whole pair universe, every incoming
pair, absent from the old moving mask, must already belong to U. The new
union is a cover if and only if `L subset U`. This is also the condition
for the wall mask itself to preserve the cover, because the wall loses
exactly L from the old mask. This is a conditional criterion for a proposed
move, not a supply of such a move in every hypothetical cover.

## 3. Actual controls for both signs of the count change

At `x_0=1/b`, only the regular row k=b changes: no smaller positive regular
k is divisible by b, and `b` does not divide the exceptional row `b+1`.
The changing mask is `{0,1}` before and `{1,2}` after, in row b.

For each `1<=r<=b-1`, the interval

`(Nr/b,(Nr+1)/b)`

has cut endpoints and positive length, so it contains a whole open cell
and that cell's midpoint. The intervals are disjoint and lie in `(0,N)`.
They start beyond one, whereas the two cells adjacent to `1/b` lie below
one because one is a cut. Thus choosing one midpoint in each interval
and the moving midpoint gives exactly b distinct cell choices in either
state. Multiplying a fixed midpoint by b places it strictly between Nr
and Nr+1, so its row-b mask is exactly `{0,1}`. The outgoing centre zero
is already covered by U, and the incoming centre two is not. The covered
pair count increases by exactly one.

Replacing these intervals by

`((Nr+1)/b,(Nr+2)/b)`

gives b-1 disjoint fixed midpoints with row-b masks `{1,2}`. They are again
beyond one and below N; the last upper endpoint is
`(N(b-1)+2)/b=N-1`, using `b=N-2`. Now zero is privately covered by the
moving mask before the wall, while two is already in U. The count decreases
by exactly one. Other rows and the exceptional pair do not change.

Each choice is an actual shared slope, so no independent row-mask assignment
enters these examples. Their row-b unions contain at most the three centres
`{0,1,2}`, which is fewer than N. Neither configuration is a full cover.
The controls refute unconditional monotonicity of this count potential,
not the existence of a more constrained cover-preserving exchange argument.

## 4. Exact fractional optimum with caps one

Index variables by actual cells and use constraints

`sum_(I: p in B(x_I)) z_I>=1` for every pair p, `0<=z_I<=1`.

For each `(k,h)`, including the exceptional pair, the bad set of slopes in
`[0,N]` has total length two. Under the change of variable y=kx, the y
interval traverses k full circumference-N periods, each with an open bad
arc of length two; division by k gives total x-length two. The finitely
many cuts have length zero. Thus, by cell constancy,

`sum_(I: p in B(x_I)) length(I)=2`.

The vector `z_I=length(I)/2` satisfies every cover constraint with equality
and has total cost N/2. The cut set includes every `j/(N-1)` from zero
to N, so `length(I)<=1/(N-1)`. Hence the vector also respects the cap one.

Conversely, every midpoint has a nonintegral point in every regular row,
whose open radius-one arc contains exactly two integer centres. Each mask
therefore contains exactly 2b regular pairs. Summing the bN regular cover
constraints gives

`2b sum_I z_I >= bN`, and consequently `sum_I z_I>=N/2`.

The exceptional constraint need not be used for this lower bound because
the explicit upper-bound vector satisfies it. The optimum is exactly N/2,
including the caps and the exceptional pair.

Since `b=N-2>N/2` for `N>=5`, this fractional cover can be padded to cost
exactly b. If J is the number of cells, `J>=N>b`. The remaining total
coordinate capacity is `J-N/2>=b-N/2`, so increasing coordinates up to one
can reach sum b. Nonnegative incidence coefficients preserve every covering
constraint during this increase. This is a fractional vector, not a
selection of b cells.

## 5. Nonnegative additive pair weights

For nonnegative weights w_p of positive total W, define
`s_I=sum_(p in B(x_I)) w_p`. Multiplying cover constraints by w_p and
summing shows that the padded vector satisfies

`sum_I z_I s_I>=W`.

Order all J cell scores as `s_1>=...>=s_J`. For any vector with caps one
and sum b, the difference between the top-b total and its weighted score is

```
sum_(i<=b) s_i - sum_i z_i s_i
 = sum_(i<=b) (1-z_i)(s_i-s_b)
   + sum_(i>b) z_i(s_b-s_i) >= 0.
```

The identity uses `sum_i z_i=b`; both displayed sums are nonnegative.
The top b distinct-cell scores therefore total at least W. In particular,
no such nonnegative weighting can prove that every b-cell subset has
additive score strictly less than the amount W required by a cover.
This also defeats the refinement from b times the largest score to the
sum of the b largest scores.

Nonnegative weights are essential when summing the cover inequalities.
The bound says nothing against overlap-sensitive or other integral
arguments. Nor does the high-scoring b-cell subset necessarily cover:
overlapping coverage can contribute the same pair weight repeatedly.
The entire fractional construction uses masks of actual common slopes;
only the integral choice of whole cells is relaxed, not their individual
row behavior.

## 6. Verdict and verification

The author establishes the claimed method limits with the endpoint and
cell-index conventions made explicit above. There is no necessary
mathematical correction or change to the frozen source. Neither an actual
cover by b slopes nor its impossibility is established. The integer covering
number would need to exceed b to prove the ideal principle, and the value
N/2 of this fractional relaxation does not establish that. Unrestricted LRC
and finite-M witness supply remain outside these conclusions.

Verification consisted of hand circle geometry, finite-set identities,
interval arithmetic, exact incidence summation, and the displayed finite
linear inequality. No mathematical solver, enumeration, replay, pending
integer-control output, or domain expansion was used. Current project
configuration, workflow, policy, and focused active state were read.
`python3 -B scripts/validate_workflow.py` exited 0 with complete output:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

Source hashes were checked with `sha256sum`; the author and review passed
trailing-whitespace and final-newline checks. Only this owned review file
was written. There was no Git, shared-state, cache, or Lean change and no
delegation. Administrative file checks are distinct from mathematical
verification. Per-task elapsed time, token usage, and independently observed
runtime model metadata are unavailable and remain null. No owned process
or dependency-cache requirement remains.
