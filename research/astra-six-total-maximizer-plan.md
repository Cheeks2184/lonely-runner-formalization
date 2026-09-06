# Constrained maximizers for the six-total route

Status: complete author manuscript proofs of the general maximizer and scalar
improvement lemmas below. The six-total theorem, phase lemmas, and their
kernel implementations are not supplied by this report.

Assigned source checkpoint: `312158239315a3488cb522695b58c0a2fece7621`.
The current project configuration, workflow, policy, and focused state were
read, and the workflow validator passed. Only this report is owned. No
enumeration, solver, arithmetic control, resource pilot, Lean execution,
cache restoration, source/state edit, or Git mutation was performed. Counts
below are manuscript calculations, not measured computational results.

## Source provenance and scope

The motivating paper is Jérôme Renault, *View-obstruction: a shorter proof for
6 lonely runners*, Discrete Mathematics 287 (2004), 93–101. Its title,
author, journal, and pagination agree with the
[institutional record](https://www.tse-fr.eu/articles/view-obstruction-shorter-proof-6-lonely-runners).
Sections 1–6 of the actual research paper were read through this
[hosted PDF copy](https://compmath.wordpress.com/wp-content/uploads/2008/08/view-obstruction_a_shorter_proof_for_6_lonely-runners.pdf).
The PDF header gives DOI `10.1016/j.disc.2004.06.008`. The orchestrator's
publisher retrieval returned 403; no byte identity with an independently
retrieved publisher PDF is asserted.

Renault uses a maximum over times safe for the other four inputs, reflection,
and an upper endpoint in Propositions 5.4 and 6.6. The following is a separate
general derivation that exposes the compactness, positive maximum, and
one-sided endpoint obligations. See the
[paper, pp. 98 and 100](https://compmath.wordpress.com/wp-content/uploads/2008/08/view-obstruction_a_shorter_proof_for_6_lonely-runners.pdf#page=6)
for the originating application.

## Definitions and exact maximizer theorem

Let I be a finite type, i an element of I, and v : I -> positive integers.
No distinctness or gcd assumption is made. For a real time t put

    x_j(t) = frac(t*v_j) in [0,1),
    f_j(t) = circleNorm(t*v_j) = min(x_j(t), 1-x_j(t)).

Fix `0 < delta < 1/2`, independently of both the number of labels and any
denominator. Define

    T = { t in R : for every j != i, f_j(t) >= delta }.

Assume a **strict complement seed**: some real s satisfies
`f_j(s) > delta` for every j != i. Assume also that there is no full closed
witness, meaning no real t satisfies `f_j(t) >= delta` for every j in I.

**Theorem M.** There is a real tau such that:

1. `0 < tau < 1` and `tau in T`;
2. `f_i(t) <= f_i(tau)` for every real `t in T`;
3. `0 < x_i(tau) = f_i(tau) < delta`;
4. some actual label `j != i` has `x_j(tau) = 1-delta`.

The maximization is over the closed complement-safe set, not its strict
interior. The upper endpoint conclusion is an oriented fractional-phase
equality, not merely the unoriented norm equality `f_j(tau)=delta`.
The output has a global maximum over all real times, so a later perturbation
does not have to stay in the interval used for compactness.

## A forward perturbation lemma

The following elementary lemma will be used twice. It also handles the
strict alternatives of the later phase lemmas.

**Lemma P.** Suppose `0 <= x_i(s) < 1/2`, and for every `j != i`,

    delta <= x_j(s) < 1-delta.

Then there is `epsilon > 0` such that `s+epsilon in T` and
`f_i(s+epsilon) > f_i(s)`.

For every j define a positive capacity

    c_i = (1/2-x_i(s))/v_i,
    c_j = (1-delta-x_j(s))/v_j,  j != i.

All denominators are positive. Since I is finite and contains i, its finite
minimum `c=min_j c_j` exists and is positive. Choose `epsilon=c/2`.
For the distinguished label,

    0 <= x_i(s) < x_i(s)+epsilon*v_i < 1/2.

For every other label,

    delta <= x_j(s) < x_j(s)+epsilon*v_j < 1-delta < 1.

Consequently no phase crosses an integer. To see this without assuming
continuity of fractional part at integers, set `z_j=floor(s*v_j)` and use
the exact equality

    (s+epsilon)*v_j = z_j + x_j(s) + epsilon*v_j.

The displayed bounds place the final summand in `[0,1)`, proving its
fractional part directly. The distinguished norm therefore increases by
exactly `epsilon*v_i`; all other phases stay in the closed safe band.
This proves P. A complement label at its **lower** endpoint delta causes no
problem: a positive speed moves it into the interior. An upper endpoint is
the obstruction to this direction of motion.

## Complete proof of Theorem M

### Positive feasible objective

The strict seed supplies `s in T`. If `f_i(s)>0`, it already has positive
objective. Otherwise `f_i(s)=0`, by nonnegativity. Since fractional parts
are in `[0,1)`, the identity `f_i(s)=min(x_i(s),1-x_i(s))` implies
`x_i(s)=0`. The strict complement inequalities imply

    delta < x_j(s) < 1-delta  for j != i.

Thus P applies at s and produces a feasible point with positive objective.
Equivalently, the strict complement inequalities define an open neighborhood
of s by continuity of the finitely many norms; the explicit capacities in P
give the needed positive interval without a hidden uniform-slack assumption.

### Period-one compact maximum and its global meaning

Each f_j is continuous. Because every v_j is an integer,

    f_j(t+n)=f_j(t) for every integer n,
    f_j(frac(t))=f_j(t).

The set T is closed: it is the finite intersection of inverse images of
`[delta,infinity)` under these continuous functions. Hence
`S=T intersect [0,1]` is compact. Normalize the positive feasible point by
its fractional time; it lies in S with unchanged positive objective. Thus S
is nonempty, and continuity gives a maximizer u in S with value M>0.

For any real t in T, `frac(t)` also lies in T and belongs to `[0,1)`.
Therefore `f_i(t)=f_i(frac(t))<=M`. This proves global maximality over T.
Neither endpoint 0 nor 1 can be u, since all integer-speed norms there are
zero. Thus `0<u<1`.

The no-full-witness assumption implies `M<delta`: at a point of T, only
the distinguished inequality can fail. In particular, equality M=delta
would already be a full **closed** witness and is excluded.

### Reflection into the increasing phase branch

Put r=x_i(u). From `min(r,1-r)=M`, with `0<M<delta<1/2`, either r=M or
r=1-M. In the first case take tau=u. In the second take tau=1-u.

For every label j,

    (1-u)*v_j = v_j-u*v_j,

so integer periodicity and evenness of circleNorm give
`f_j(1-u)=f_j(u)`. Hence tau remains in T, has objective M, and is still
a global maximizer. In the reflected case, r is nonzero and less than one;
writing `u*v_i=z+r` gives

    (1-u)*v_i = (v_i-z-1) + (1-r),

with `0<1-r<1`. Thus the reflected fractional phase is exactly 1-r=M.
In both cases `0<tau<1` and `0<x_i(tau)=M<delta`.

This reflection is chosen according to the distinguished **phase**, not
according to whether time itself lies below one half. A normalization that
reflects only the time into `[0,1/2]` does not establish the orientation
required here.

### An actual upper endpoint

Suppose no j != i has `x_j(tau)=1-delta`. Complement safety gives

    delta <= x_j(tau) <= 1-delta.

By the supposition the upper inequality is strict for every such label.
The distinguished phase is below delta and hence below one half. Lemma P
then gives a positive epsilon with `tau+epsilon in T` and objective larger
than M, contradicting the global maximum. Therefore some actual complement
label is at phase 1-delta. This completes M.

No assumption that the complement is nonempty was slipped into a minimum:
the capacity minimum always includes i. If I has only one label, the strict
seed is vacuous but the no-full-witness assumption is impossible; the same
proof obtains that contradiction before demanding an actual other label.

### Why the strict seed cannot be weakened silently

For the fixed speeds `(3,1,2)`, distinguish speed 3 and take delta=1/3.
The complement-safe times modulo one are exactly `{1/3,2/3}`: intersect
`[1/3,2/3]` with `[1/6,1/3] union [2/3,5/6]`. The distinguished norm is
zero on both points, and no full closed witness exists at this delta.
Thus closed nonemptiness of T does not imply the positive maximum required
by M. This is a handwritten boundary example; it was not executed as a test.

## Scalar improvement at a reciprocal integer margin

**Lemma D.** Let N>=3 be an integer and `0<x<1/N`. For any integer alpha
with `2<=alpha<=N-1`,

    circleNorm(alpha*x) > circleNorm(x) = x.

Indeed `0<alpha*x<1`, so its norm is `min(alpha*x,1-alpha*x)`.
The first term exceeds x because alpha>=2 and x>0. The second exceeds x
because `(alpha+1)*x <= N*x < 1`. This handles the case where alpha*x
passes one half without assuming monotonicity of circleNorm on the whole
unit interval. Both endpoints of `0<x<1/N` matter for strictness.

If N divides a distinguished integer speed d, write d=Nq. For any real t,
any integer beta (positive, zero, or negative), and x=frac(t*d),

    (alpha*t+beta/N)*d
      = alpha*floor(t*d) + beta*q + alpha*x.

The first two terms are integers. If `0<x<1/N` and `2<=alpha<N`, D
therefore implies

    circleNorm((alpha*t+beta/N)*d) > circleNorm(t*d).

No prime, gcd, or sign restriction on beta is used. For alpha=1 the
distinguished norm is unchanged by the rational shift; it is P, together
with suitable complement phases, that supplies a strict improvement.

## Proposed Lean contracts and existing APIs

The following declarations are proposed types with proof terms omitted;
none is asserted to exist or to have been checked. The generic finite label
type makes the separation between runner count and margin explicit.

```lean
def ComplementSafe {I : Type*} (v : I → ℕ) (i : I)
    (δ t : ℝ) : Prop :=
  ∀ j, j ≠ i → δ ≤ circleNorm (t * (v j : ℝ))

theorem exists_forward_complement_improvement
    {I : Type*} [Fintype I] [DecidableEq I]
    (v : I → ℕ) (i : I) (hv : ∀ j, 0 < v j)
    (δ s : ℝ) (hδ : 0 < δ) (hδhalf : δ < (1 : ℝ) / 2)
    (hi : Int.fract (s * (v i : ℝ)) < (1 : ℝ) / 2)
    (hbands : ∀ j, j ≠ i →
      δ ≤ Int.fract (s * (v j : ℝ)) ∧
      Int.fract (s * (v j : ℝ)) < 1 - δ) :
    ∃ ε : ℝ, 0 < ε ∧ ComplementSafe v i δ (s + ε) ∧
      circleNorm (s * (v i : ℝ)) <
        circleNorm ((s + ε) * (v i : ℝ))

theorem exists_oriented_complement_maximizer
    {I : Type*} [Fintype I] [DecidableEq I]
    (v : I → ℕ) (i : I) (hv : ∀ j, 0 < v j)
    (δ : ℝ) (hδ : 0 < δ) (hδhalf : δ < (1 : ℝ) / 2)
    (hstrict : ∃ s : ℝ, ∀ j, j ≠ i →
      δ < circleNorm (s * (v j : ℝ)))
    (hno : ¬ ∃ t : ℝ, ∀ j, δ ≤ circleNorm (t * (v j : ℝ))) :
    ∃ τ : ℝ, 0 < τ ∧ τ < 1 ∧ ComplementSafe v i δ τ ∧
      (∀ t : ℝ, ComplementSafe v i δ t →
        circleNorm (t * (v i : ℝ)) ≤ circleNorm (τ * (v i : ℝ))) ∧
      0 < Int.fract (τ * (v i : ℝ)) ∧
      Int.fract (τ * (v i : ℝ)) < δ ∧
      Int.fract (τ * (v i : ℝ)) = circleNorm (τ * (v i : ℝ)) ∧
      ∃ j, j ≠ i ∧ Int.fract (τ * (v j : ℝ)) = 1 - δ

theorem reciprocal_dilate_shift_improves
    (N d α : ℕ) (β : ℤ) (t : ℝ) (hN : 3 ≤ N)
    (hdiv : N ∣ d) (hα : 2 ≤ α) (hαN : α < N)
    (hx : 0 < Int.fract (t * (d : ℝ)))
    (hxN : Int.fract (t * (d : ℝ)) < (N : ℝ)⁻¹) :
    circleNorm (t * (d : ℝ)) <
      circleNorm (((α : ℝ) * t + (β : ℝ) / (N : ℝ)) * (d : ℝ))
```

Add a small elementary lemma identifying circleNorm with
`min (Int.fract x) (1-Int.fract x)`. Its proof follows from
`Int.floor_add_fract`, integer periodicity, and the existing half-unit
norm identity, splitting at one half. That lemma yields the closed-band
equivalence and its strict form without pretending fractional part is
globally continuous.

| Source API | Use and limitation |
| --- | --- |
| `PivotBoundary.lean:16`, `continuous_circleNorm` | Continuity of each objective and closedness of T; maximize the continuous norm, not the fractional-part function |
| `PivotBoundary.lean:169`, `circleNorm_fract_mul_nat` | Transfer all natural-speed norms from any real time into `[0,1)` |
| `FastRunnerInsertion.lean:21`, `:25`, `:34` | Half-unit norm identity, integer periodicity, and Lipschitz estimate; existing source declarations, with no new kernel run in this pass |
| `StructuredClasses.lean:14`, `circleNorm_neg` | Reflection of all constraints and objective |
| `PairSumCompleteness.lean:26`, `int_band_of_circleNorm_ge` | Recover closed floor bands from norm safety |
| `StructuredClasses.lean:28`, `circleNorm_ge_of_int_band` | Convert the forward-perturbed floor bands back into safety |
| `BufferedRunnerInsertion.lean:30`–`:90` | Existing finite floor endpoints and explicit slack division by positive speeds; adapt this method for P, not its stronger width assumptions |
| `EndpointCompleteness.lean:26`–`:43` | Existing integer-period/reflection algebra; its choice based on time is not the phase-based choice needed by M |
| `FiveRunnerOrdinary.lean:120`, `:152` | Four positive natural inputs have margin 1/5, and H6 is available; reindex the complement of a Fin5 label to obtain strict margin 1/6 |
| `FastRunnerInsertion.lean:92` | At n=4, the existing fast-input theorem supplies the factor-five branch at closed margin 1/6 |

The remaining topological library step is the compact extreme-value theorem
for a continuous real function on the nonempty closed subset of `[0,1]`.
Its exact pinned-library invocation should be checked during implementation;
no `.lake` inspection or guessed compiled API is claimed here. This is a
standard compactness dependency, not an unresolved mathematical implication.

## Exact future phase obligations

Write `G(y)` for `circleNorm(y)>=1/6` and `H(y)` for `circleNorm(y)>1/6`.
For a triple x, write `All Q(alpha,beta;w)` for
`Q(alpha*x_j+w_j*beta/6)` at every coordinate. The unresolved kernel targets
can be recorded compactly as follows; `1` denotes weights `(1,1,1)`.
Arbitrary real phases may be used because replacing each x by its fractional
part preserves these predicates when alpha is an integer.

| Paper target | Input | Required disjunction |
| --- | --- | --- |
| Lemma 5.1 | arbitrary phases x | `exists alpha in {2,3,4,5}, beta in {1,2,3,4,5}: All G(alpha,beta;1)` OR `exists beta in {1,2,4}: All H(1,beta;1)` |
| Lemma 6.1 | arbitrary phases x | the same closed alternative with weights `(2,1,1)` OR `exists beta in {1,2,3,4}: All H(1,beta;(2,1,1))` |
| Lemma 6.4 | `All G(1,0;1)` | `All H(2,0;1)` OR `exists beta in {1,5}: All H(1,beta;1)` OR `exists alpha in {3,5}, beta in {0,1,2,3,4,5}: All G(alpha,beta;1)` |

These correspond to the actual mixed strict/closed statements in
[Renault, pp. 97–100](https://compmath.wordpress.com/wp-content/uploads/2008/08/view-obstruction_a_shorter_proof_for_6_lonely-runners.pdf#page=5).
For signed residue classes, normalize `epsilon_j*x_j` by fractional part
before applying a lemma on `[0,1)`, and use norm symmetry. Reflecting beta
to `6-beta` changes the strict beta sets to `{2,4,5}` and `{2,3,4,5}`
respectively. This supplies the interfaces of 5.2–5.3, 6.2–6.3, and 6.5.
Do not pass a negative unnormalized phase to a stated `[0,1)` hypothesis.

The three displayed unsigned phase theorems remain implementation and review
obligations; this task has not substituted a finite search for their proofs.
At alpha>=2 use D. At alpha=1 the signed beta restrictions deliberately
make the singled-out boundary input lie below the upper endpoint; the
other phase constraints are strict, so P applies.

## Divisibility and assembly obligations

For arbitrary five positive natural speeds, first normalize their common gcd
and provide an exact time-rescaling bridge. The following branches and
transfers still need source proofs or independently reviewed implementations:

1. Under no witness, for each l in `{2,3,4,5,6}`, at least one and at most
   three of the five speeds are divisible by l. The lower bound follows
   from time `1/l`; the upper bound uses gcd normalization, the four-input
   theorem, and a nontrivial shift orbit of the remaining input. Composite
   l does not justify assuming every nonzero residue is invertible.
2. Discharge at least two multiples of three, including the three-multiple
   shift branch and the two-multiple boundary/divisibility argument. This
   is the substantive obligation of Proposition 3.1; M alone does not
   replace that separate constrained two-coordinate argument.
3. Discharge at least three even speeds, the separate divisibility branch
   of Proposition 4.1. The integer phase preimage computations used there,
   including Claim 2.4, need exact endpoint lemmas.
4. The remaining patterns have exactly one multiple of six and no other
   multiple of three. With one even speed, use M plus signed Lemma 5.1.
   With two even speeds, the upper-face label from M may have residue
   `+/-2` or `+/-1`: use signed 6.4 for the former, and signed 6.1 after
   moving the latter to phase zero. Record the rational-time phase
   identities explicitly in each branch. See the
   [paper, Sections 2–6](https://compmath.wordpress.com/wp-content/uploads/2008/08/view-obstruction_a_shorter_proof_for_6_lonely-runners.pdf#page=2).
5. Assemble the unrestricted five-moving positive-integer conclusion at
   margin 1/6, with repeated inputs allowed. Only then extend H6 with this
   new case and use the existing separately checked real/canonical bridges
   for six total runners. H8 additionally needs the six-moving integer
   case at margin 1/7; this report supplies neither missing count.

The factor-five domination subcase is already supported by
`fastRunnerInsertion` and the four-input margin 1/5 theorem; its complement
reindexing still needs assembly. Gcd, parity, divisibility, and label
reindexing are mathematical hypotheses to prove, not informal normalizations
to hide in the final canonical statement.

## Audit of the proposed finite atom model; no execution

For Lemma 5.1 there are twenty closed candidates `(alpha,beta)` and three
strict candidates, hence 23 coordinate predicates. A change in any predicate
can occur only when

    alpha*x+beta/6 is congruent to 1/6 or 5/6 modulo one.

For alpha in `{2,3,4,5}`, these boundaries belong to the grids with
denominators `12,18,24,30`. The alpha=1 strict boundaries lie on the sixth
grid. The twelfth grid is contained in the twenty-fourth, and the sixth
is contained in all three remaining grids. Thus it suffices to use

    C = U18 union U24 union U30,
    Ud = {k/d : 0<=k<d} on the circle.

Each pairwise intersection and the triple intersection is U6. By
inclusion–exclusion,

    |C| = 18+24+30-6-6-6+6 = 60.

There are 60 singleton cut atoms and 60 open intervals between successive
cuts, hence exactly 120 atoms. On `[0,1)`, the final interval ends at one;
zero is its own singleton atom. Candidate wrap points also lie in these
grids. Every one of the 23 predicates is constant on each open atom;
endpoint atoms must be evaluated separately because closed and strict
membership differ there. Rational midpoints represent intervals, while the
cut itself represents each singleton. This proves the model and count
symbolically, not the phase lemma's finite coverage assertion.

A bounded future certificate plan can avoid the raw `120^3=1,728,000`
ordered-triple traversal:

* Evaluate the 23 predicates on the 120 fixed representatives: at most
  2,760 exact rational predicate evaluations. These are **good-candidate**
  masks, with strict bits evaluated using strict inequalities.
* Quotient equal masks and retain the inclusion-minimal masks. A smaller
  good mask is harder to satisfy; discarding supersets is sound because
  every discarded mask contains a retained minimal one. At most 14,280
  ordered distinct-pair inclusion comparisons suffice at the raw bound.
* Check intersections of three retained masks, allowing repetition.
  Permutation symmetry reduces the maximum to
  `binomial(122,3)=295,240` unordered triples with repetition. A nonempty
  intersection supplies a candidate; an empty intersection requires an
  exact fixed phase counterexample and a contract review, not theorem
  promotion. The actual number of minimal masks is unknown here.
* A Lean certificate must separately prove atom coverage and predicate
  constancy, and then kernel-check the finite mask-intersection claim.
  Python success alone would not certify the continuum theorem.

The same cut set also suffices for the stated 6.1 and 6.4 coordinate
predicates: their boundary numerators change but their denominators do not
add a new grid. Their masks and symmetries are different; the 5.1 coverage
result would not by itself establish those targets. No atom table, masks,
triples, or resource measurement was generated in this task.

## Minimal next implementation sequence and evidence

First implement the fractional-band helper, P, M, and D in a dedicated small
module, preserving their independent margin and label-count parameters.
Use finite positive capacities for perturbations and continuous norms for
compactness. Independently review these exact contracts before acceptance.
Then settle the phase lemmas and the divisibility branches as distinct
tasks; the already proved M is supporting infrastructure for those tasks.
Run focused kernel and axiom checks only when source is actually implemented.
Do not restore a build cache for this manuscript-only pass.

Inspected source SHA-256 values:

```text
0e56cab74d30ef8b537ed4ec24503aae875bd8aadc369d26da99ba882cc3603f  LonelyRunner/PivotBoundary.lean
a135f5c41ead308a2a4250f07535bf3e32f78c88599497bf79bb632cd1e05f0a  LonelyRunner/BufferedRunnerInsertion.lean
838a3bcec806b0e9d01cd117e64e5348de58a05127a3f7bef5dbe2d879ff292f  LonelyRunner/PairSumCompleteness.lean
662d0116f13971bce85e76c503e2f3be4fdc6291ba8113aeda43957e38354ffe  LonelyRunner/FiveRunnerOrdinary.lean
```

Disposition: M, P, and D have complete author manuscript proofs and proposed
exact interfaces. The atom model is sound at manuscript level; its finite
coverage has not been computed or proved here. The listed six-total and
higher-count obligations remain. No automatic canonical promotion follows.
