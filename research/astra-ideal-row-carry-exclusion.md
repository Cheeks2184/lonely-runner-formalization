# Exact wall exchanges and a fractional incidence barrier

This bounded audit does not exclude all ideal mask covers and does not
produce an actual cover by N-2 slopes. Its two results are an exact
simultaneous wall-exchange rule, including the exceptional pair, and an
exact fractional-cover optimum N/2. The latter rules out a pure additive
pair-weight counting proof of the desired exclusion. Neither result supplies
the missing integral selection theorem.

Task: `/root/ideal_row_carry_exclusion`, requested Astra/xhigh.
Source checkpoint: `15ef35a75c255f3fcdaafe8fb289f1fe6d97ee30`.
Only this manuscript is owned; concurrent files are preserved.

The source read for the finite-cell contract was
`research/astra-ideal-row-finite-cell-reduction.md`, SHA-256
`44aca4f3cff905074d315515fb88a08b0957b9b200d016c34f55dce3701ac1fb`.
Its first-section periodicity, strict perturbation, cell constancy, duplicate
removal and padding steps were checked for the uses below. Its integer
transfer bounds and retained numerical result are not premises here. The
preceding restricted-selection manuscript is unchanged at
`research/astra-ideal-row-selection-audit.md`, SHA-256
`20752d3a362a153d4cdaa2f30373c01002fa0dd3ed708b3bf1d1b4a4d67c77b7`.

## 1. Objects and closed endpoints

Fix N>=5 and b=N-2. Replace a column ell by its integer centre h=-ell
modulo N, so the pair universe is

    P = ({1,...,b} x Z/NZ) union {(*):=(N-1,0)}.

For a real slope x, a pair (k,h) is bad precisely when

    d_N(kx,h) < 1,

where d_N is circle distance on R/(N Z). Thus a distance equal to 1 is
closed-good. The exceptional pair uses only the centre 0 in row N-1.
Write B(x) for this finite bad mask. All row points are multiples of the
same x, and B(x+N)=B(x).

The cuts are all j/k in [0,N] with 1<=k<=N-1 and integral j. Let J index
their consecutive open cells I, and let x_I be each midpoint. A mask is
constant on an open cell: every possible boundary of a bad predicate has
kx integral and is therefore a cut. At a midpoint, kx_I is nonintegral for
every 1<=k<=N-1.

The source's reduction preserves possible failure: failure uses finitely
many strict bad inequalities, which survive a small simultaneous
perturbation off the cuts. Midpoint replacement preserves every resulting
mask. Removing duplicate cells and padding with other cells preserves a
cover. Thus excluding covers by b distinct midpoint masks is exactly the
ideal selection obligation, including real boundary inputs and repeated
slopes. This equivalence is used only to specify the obligation; it supplies
no exclusion by itself.

## 2. Approach one: all changes at a wall

Let x_0=a/q be a reduced cut, with q>=1. Choose x_- and x_+ in its adjacent
open cells. For each regular row k divisible by q, set m=ka/q. The three
masks in that row are, in integer-centre coordinates,

    before: {m-1,m},    at the wall: {m},    after: {m,m+1},  (1)

all modulo N. For a row not divisible by q, kx_0 is nonintegral, so no bad
predicate changes there. This accounts for every regular row changing at
the wall; it is not a move affecting only one arbitrarily chosen row.

To verify (1), sufficiently close to the wall the point kx lies just below,
at, or just above m. Its open radius-one arc contains exactly the listed
integer centres. Cell constancy extends this description to the adjacent
midpoints. Reducedness gives kx_0 integral exactly when q divides k.

For the exceptional row there is no change unless q divides N-1. In that
case put m=(N-1)a/q and reduce m modulo N. If m=1, the exceptional pair is
bad before the wall, good at it, and good after it. If m=-1, it is good
before, good at, and bad after. If m=0, it is bad in all three positions.
For every other residue it is good in all three positions. These cases
follow from the strict radius-one inequality at centre 0.

Let L be the collection of outgoing pairs: (k,m-1) from every regular row
in (1), together with the exceptional pair if m=1 in its row. Let G be
the corresponding incoming pairs (k,m+1), together with the exceptional
pair if m=-1. Then L and G are disjoint and

    B(x_+) = (B(x_-) minus L) union G,
    B(x_0) = B(x_-) intersect B(x_+).                       (2)

The intersection assertion is where closed endpoint ownership matters:
both departing and arriving neighbours are good at the wall itself.

Keep every other slope fixed and let U be the union of their bad masks.
Equation (2) gives the exact covered-pair count change

    |U union B(x_+)| - |U union B(x_-)|
      = |G minus U| - |L minus U|.                         (3)

In particular, if U union B(x_-) already covers P, every incoming pair
is already in U. The move preserves that cover if and only if L is a
subset of U. This is also exactly the condition that the wall itself
still covers P. Preserving the size of one label's regular-row mask does
not establish this condition: a departing pair can have that label as
its only bad owner.

### Bare covered-pair monotonicity fails on actual distinct cells

There is a uniform control for each sign of (3), using exactly b distinct
cell midpoints and their actual shared slopes. It concerns the count
potential, not a full mask cover.

Move one slope across x_0=1/b. Its reduced denominator is b, so the only
changing regular row is k=b. The exceptional row does not change, since
b does not divide b+1=N-1. In the changing row the moving mask is
{0,1} before the wall and {1,2} after it.

For r=1,...,b-1 choose one cell midpoint in each interval

    (N r/b, (N r+1)/b).                                   (4)

The endpoints are cuts, so each nonempty interval contains at least one
whole open cell and a midpoint. The intervals are disjoint, lie inside
(0,N), and are separate from the two cells next to 1/b. Hence these choices
and the moving midpoint form b distinct cell midpoints. Each fixed slope
has row-b bad centres exactly {0,1}. In (3), the departure 0 is already
covered but the arrival 2 is not. The count therefore increases by 1.

Instead choose the b-1 fixed midpoints in the disjoint intervals

    ((N r+1)/b, (N r+2)/b),    r=1,...,b-1.                (5)

Now all their row-b masks are {1,2}, so the same increasing wall move
decreases the covered count by 1. All other rows, including the exceptional
pair, are unchanged in both constructions. The final upper endpoint in
(5) is N-1, so all chosen slopes remain in (0,N).

Thus no unconditional monotonicity in the direction of increasing slopes
holds for this count potential, even with distinct actual midpoint cells.
These controls cover at most three centres in row b, which is less than N;
they do not assert that a full cover exists or that a cover-preserving
exchange rule is impossible.

The exact remaining exchange issue is whether a hypothetical b-mask full
cover must admit appropriate moves with L contained in U, in a way that
forces a global contradiction. Formula (3) and per-label cardinality do
not imply the existence of such a move. No invariant or terminating
sequence establishing that implication was obtained in this approach.

## 3. Approach two: the actual-mask fractional optimum is N/2

Consider the finite linear relaxation with a nonnegative variable z_I for
each actual midpoint mask, subject to

    sum_(I: p in B(x_I)) z_I >= 1    for every p in P,
    0 <= z_I <= 1.

The objective is to minimize sum_I z_I. The cap 1 retains the linear part
of the distinct-cell restriction, but does not make z_I integral.

This relaxation has optimum exactly N/2 for every N>=5. No solver or
independently assigned row masks are involved in the proof.

For the upper bound, set

    z_I = length(I)/2.                                    (6)

For any pair (k,h), the subset of x in [0,N] satisfying d_N(kx,h)<1 has
total length 2. Indeed x -> kx traverses exactly k periods of circumference
N; each period contains a bad arc of length 2, and division by the positive
slope k gives total length k*(2/k)=2. This applies also to k=N-1,h=0.

The removed cut points have length zero, and masks are constant inside
each cell. It follows that for every pair p,

    sum_(I: p in B(x_I)) length(I) = 2.

Thus (6) satisfies every covering constraint with equality. The cells
partition [0,N] up to their endpoints, so its cost is N/2. Since the cut
set includes the entire grid j/(N-1), every cell has length at most
1/(N-1), and (6) also satisfies the upper cap 1.

For the lower bound, each midpoint mask has exactly two bad integer
centres in each regular row, because its row point is nonintegral. Hence
it contains exactly 2b regular pairs. Summing just the bN regular-pair
constraints of any fractional cover gives

    2b sum_I z_I >= bN,

and therefore sum_I z_I>=N/2. Together with (6), this proves the exact
optimum, including the exceptional constraint and the individual caps.

Since b=N-2>N/2, the relaxation cannot exclude b cells. More explicitly,
there are at least N cells. Starting with (6), increase some coordinates
without exceeding 1 until their sum is b. There is enough total capacity,
and increasing nonnegative coordinates preserves all covering constraints.
This gives a feasible fractional vector with sum exactly b and caps 1.
It is not an actual b-element subset.

### Consequence for all additive nonnegative pair weights

Assign arbitrary nonnegative weights w_p to the pairs, with total W>0,
and give a mask the score s_I=sum_(p in B(x_I)) w_p. For the feasible
fractional vector of sum b just constructed,

    sum_I z_I s_I >= W.

The sum of the b largest mask scores is at least sum_I z_I s_I whenever
0<=z_I<=1 and sum_I z_I=b. This follows by shifting weight from a smaller
score to a larger score until b coordinates have weight 1, or directly
by ordering the scores and comparing with the b-th one. Consequently

    sum of the b largest distinct-cell scores >= W.       (7)

No choice of these pair weights can make the total additive score of
every b distinct masks smaller than the weight W that a cover requires.
This includes the improvement of taking the best b distinct mask scores
instead of b times the largest single score. Overlap-sensitive or other
integral inequalities are outside this negative conclusion.

The fractional construction uses masks generated by the same real slope
in every row. It does not relax individual rows independently. What it
relaxes is the integer choice of whole slope masks. Uniform ideal selection
would require an integral covering number at least b+1=N-1, whereas this
basic fractional covering number is exactly N/2. No such integral lower
bound is established here.

## 4. Disposition and verification

The wall formulas and the fractional optimum are proved manuscript results.
The first approach isolates the private departures that prevent an exchange;
the second shows why even optimally chosen additive pair weights cannot
exclude the required number of distinct masks. These are limits of the two
specified arguments, not proofs or counterexamples for the full ideal
selection principle. The closed exceptional pair was retained throughout.

No additional restricted selection family, numerical domain, mathematical
program, enumeration, LP solver, Lean theorem, or cache restoration was
introduced. Verification was hand circle geometry, finite set algebra,
interval lengths and finite linear inequalities. The project config,
workflow, policy and focused state were read; context hashes matched.
`python3 -B scripts/validate_workflow.py` exited 0 with:

    workflow structural validation passed; it cannot certify mathematical validity.

The owned file was checked for trailing whitespace and a final newline.
There were no Git/state/cache or other-source changes. Independent semantic
review remains required. This branch result does not block or complete the
unrestricted LRC goal.
