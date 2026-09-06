# Uniform forward supply under a reciprocal-tail bound

Date: 2026-09-06. Task `/root/forward_grid_uniform_supply`, in the requested
Astra/xhigh session `/root/uniform_seed_coupling`.
Task source checkpoint: `600287d55a01d3c8c2d3bf4e4114eee4f9c1271e`.
Only this report is worker-owned. No mathematical program was run.

**Result.** A greedy digit construction proves a forward-good adapted-grid
witness under the explicit reciprocal-tail condition below. The result
works for any finite arity, so it applies both to the requested old arity
m=N-2 and directly to the full closed-grid candidate with N-1 speeds.
It is a uniform sufficient separation condition, not general forward supply.
A second, exact ordinary family refutes the simpler two-increment one-pass
repair rule while exhibiting another forward grid witness. No actual tuple
lacking every forward-good assignment was established.

## 1. Greedy lower-band construction with an exact tail budget

Let N>=3 be an integer and let `v_1,...,v_m>0` be any finite list of real
frequencies, m>=1. Fixed real starting phases `theta_i` are allowed in this
lemma. Suppose the displayed order satisfies

```text
(N-1) sum_(j>i) v_i/v_j <= N-3   for every i.          (S)
```

Then there exist digits `k_i in {0,...,N-1}` such that the one common time

```text
t=sum_i k_i/(N v_i)
```

obeys

```text
fract(theta_i+v_i t) in [1/N,1-1/N)   for every i.     (F)
```

No integrality, distinctness, or relation between m and N is needed for
this implication. Positivity and (S) are the essential hypotheses. The
ordinary adapted grid is the specialization `theta_i=0`.

Start with `t_0=0`. At stage i, choose the unique digit k_i in
`{0,...,N-1}` that puts the current i-th phase in `[1/N,2/N)` after
setting `t_i=t_(i-1)+k_i/(N v_i)`. Such a digit always exists: a translated
N-grid meets this half-open interval of length 1/N exactly once.
More explicitly, if `a=floor(N fract(theta_i+v_i t_(i-1)))`, take the
residue `k_i=1-a mod N` in the specified digit range. Writing the residual
fractional part of `N fract(theta_i+v_i t_(i-1))` as r in [0,1), the
new phase is `(1+r)/N`, which is in the required interval.

Write this phase as c_i. Later stages increase time by the nonnegative
amount

```text
Delta_i=sum_(j>i) k_j/(N v_j).
```

The complete digit budget, rather than an assumed two-digit budget, gives

```text
0<=v_i Delta_i
  <= ((N-1)/N) sum_(j>i) v_i/v_j
  <= (N-3)/N.
```

Consequently

```text
1/N <= c_i+v_i Delta_i
    < 2/N+(N-3)/N = (N-1)/N < 1.
```

There is no wrap, and (F) follows for every label at the final common time.
The strict upper bound comes from `c_i<2/N`, so equality in (S) is allowed.
The lower boundary remains included. This proof does not assume that
entering the lower band always requires at most two increments; the chosen
digit can be N-1, and its full value was used in the tail estimate.

The construction is an actual supply argument on the specified finite
grid. It supplies neither an independently chosen time for each label nor
a freely chosen offset of the final grid. Allowing fixed phases is only
the stronger scope of this separated-frequency lemma; no unrestricted
shifted form of LRC is assumed.

### A simple uniform separation consequence

For N>3, successive ratios at least

```text
v_(i+1)/v_i >= R_N=2+2/(N-3)
```

suffice. Indeed the finite geometric tail satisfies

```text
sum_(j>i) v_i/v_j < 1/(R_N-1)=(N-3)/(N-1)
```

whenever it is nonempty; an empty tail is zero. Thus (S) holds. For N=3,
(S) permits m=1 but cannot hold with a nonempty positive tail; the main
lemma remains correct at that boundary.

For N>=5, `R_N<N-1`. Thus this construction can handle whole geometric
lists whose final adjacent ratio is below the existing single-fast
threshold for the full N-runner target. This comparison concerns the
stated sufficient hypotheses and does not claim that the resulting tuples
lack other ordinary witnesses or other established sufficient arguments.
No novelty claim or finite-count milestone is made.

For distinct speeds, (S) leaves no hidden freedom to repair a failed bound
by reordering: each later ratio v_i/v_j is at most the nonnegative tail,
which is bounded by `(N-3)/(N-1)<1`. Hence any order satisfying (S) must
already be strictly increasing. There is no theorem here that every tuple
satisfies (S) in some order, or that a suitable partition always exists.

### Relation to the requested insertion dependency

At m=N-2 with ordinary positive integer speeds, (F) is exactly the old
forward-good assignment required by the reviewed commensurate insertion
theorem. With `L=lcm(v)` and `M=max(v)`, appending `w=NLM` therefore gives
a full closed adapted-grid witness. The source theorem supplies this
composition; no approximation or additional digit representation is needed.

Alternatively, take m=N-1 in the present lemma itself. Under (S), the same
greedy construction directly proves the full ordinary closed 1/N grid
claim, without appending a speed. These are concrete uniform uses of the
sufficient separation condition. Neither use removes condition (S).

## 2. The two-increment one-pass repair rule is not sufficient

Consider this different proposed algorithm on ordinary phases. Process
speeds in increasing order, starting at time zero. If the current label
is forward-bad, increase its digit by successive own-coordinate steps
`1/(N v_i)` until its phase is in `[1/N,1-1/N)`; do not revisit earlier
labels. A single visit requires at most two increments, since a forward-bad
fiber consists of two consecutive residues of its translated N-grid.
That local fact does not ensure that later visits preserve earlier labels.

For every N>=5 take the actual old tuple of m=N-2 positive integers

```text
V_N={1,2,...,N-4,N-2,N-1}.                            (A)
```

The first visit, at speed 1, produces `t=1/N`. Every subsequent label
except N-1 is already forward-good there: its phase is v/N with
`1<=v<=N-2`. The last label has phase `(N-1)/N`, the excluded upper
endpoint. Its first increment puts it at phase zero and its second at
phase 1/N. Thus the one-pass algorithm ends at

```text
t=1/N+2/[N(N-1)].
```

The earlier label N-2 now has phase

```text
(N-2)t = 1-2/[N(N-1)] > 1-1/N,
```

where the comparison uses N>3. It is strictly bad even for the closed
target. Every individual repair obeyed its claimed two-increment limit,
but the final assignment is not a common witness.

To distinguish this failure from failure of forward supply, restrict the
same family to `3 does not divide N`. Choose `k in {1,...,N-1}` with
`3k=1 mod N`; k is a unit modulo N. Then `t=k/N` is an adapted-grid time
using only the speed-1 digit. Multiplication by k sends no speed in (A)
to residue zero. The unique residue sent to -1 is `-3=N-3 mod N`, which
is precisely the omitted speed. All actual phases are therefore among

```text
1/N,2/N,...,(N-2)/N,
```

so this is a forward-good assignment. This is an unbounded algebraic
family of positive controls for one proposed uniform algorithm, not an
enumerated domain or a sequence of runner-count theorems.

Family (A) also fails (S): for its penultimate speed the left side is
`(N-1)(N-2)/(N-1)=N-2>N-3`. On the subfamily with `3` not dividing N,
this proves that the tail condition is not necessary for forward supply.
These calculations do not refute a repair
algorithm that revisits labels; termination within the digit budgets for
such an algorithm has not been proved or disproved here.

## Remaining dependency and evidence limits

The first approach gives a uniform, phase-independent sufficient condition
on the actual ordered frequency ratios and an explicit finite construction.
The second identifies a precise failure of using local two-step repair as
a replacement for that global preservation budget. It also shows why a
universal choice of order cannot be inferred from the separated case.

General forward supply for every positive integer m=N-2 tuple remains
unresolved. No actual old tuple without a forward assignment was found
analytically. In particular, the reviewed equivalence with a commensurate
appended speed has not become an unrestricted adapted-grid theorem.
The remaining input is a different common-time mechanism for tuples
outside (S), or a complete actual obstruction to forward supply.

This task stops after these two approaches. No standalone Lean work is
queued: the separation theorem is a settled manuscript contract for its
stated class, but no argument reduces arbitrary tuples to that class.
The separate bounded Terra control was not run, replicated or enlarged
by this worker and plays no role in the displayed proofs.

## Source bindings and verification

The complete author manuscript and independent review were read; the existing
single-fast declaration was also read back for the threshold comparison:

| Artifact | SHA-256 |
| --- | --- |
| `research/astra-forward-grid-insertion.md` | `b1185bc69414dbb6dfa36bc04ed2a80f92b75856867190015b19c53216babb33` |
| `research/astra-forward-grid-insertion-review.md` | `ba90a5a4fa2cb6e767a2c85d8b6d6c4a9d0d1a54bdc47e5f4c870591138adb82` |
| `LonelyRunner/FastRunnerInsertion.lean` | `dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5` |

Project config, workflow, policy and focused state were read. The command
`python3 -B scripts/validate_workflow.py` exited 0 with the complete output

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

New claims were checked by the displayed algebra and exact hand family.
No mathematical program, solver, enumeration, external literature claim,
Lean invocation, dependency restoration, Git mutation or shared-state edit
was performed. Only this report was written. It requires independent
mathematical review and is not a kernel-checked proof.
