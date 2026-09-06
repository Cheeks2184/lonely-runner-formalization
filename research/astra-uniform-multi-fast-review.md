# Independent review of multiple-fast insertion and the critical horizon

Date: 2026-09-06. Task `/root/uniform_multi_fast_review`, executed by
`/root/uniform_screen_review`; requested Astra/xhigh. Runtime model, effort
and usage are not independently exposed. Parent-supplied checkpoint:
`8b9ea58d8a477a0fad733c3cf6674c307c1f9782`. Only this review file is owned.
The reviewer did not author either mathematical input.

**Both manuscripts are accepted without correction.** The discrepancy
criterion is sound with equality, and the period-sum horizon supplies the
additional critical case `2b=N`. The first report's unresolved boundary
describes the limitation of its estimator; the second report resolves that
local-supply issue under a stated separation condition. Uniform selection
of a suitable partition and seed remains unproved. The A=84 control remains
a residual for both displayed reciprocal-sum tests.

Both complete manuscripts, the existing one-fast Lean source and its
documentation were read. The prior orbit/profile contracts were checked
against their unchanged bindings. Actual SHA-256 readback:

```text
2c5c9b37758cd5e7c52d6db986bde5a11b77ea3cb95a3d09671563b5c527dd03  research/astra-uniform-multi-fast-gluing.md
5a9e17c215fba90074d06cd48c09084f0a08a310a17290d182496df43b95e87a  research/astra-critical-interval-horizon.md
dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5  LonelyRunner/FastRunnerInsertion.lean
10222dc0a29a6674d45ae42512074afca50c5f322ec6dfbfd44151ecf55403aa  docs/fast-runner-insertion.md
8c4b6ee094f0f311f360d3abf371e95f731e28cee997d3810dd3218ff6f25746  research/astra-uniform-divisor-minimality.md
979fb69005f60f4e0f4b350a272ac7234917695b7df085ab858a7bf9324456f9  research/astra-subset-gcd-profile-screen.md
05b89f854f5076ffcfb139a19ea34a8ed6d9481c893211560aa443881bc89326  research/astra-uniform-label-cut-profile.md
```

**The one-pulse estimate, including wraparound.** After scaling by w,
decompose the interval length as `h+u`, `0<=u<1`. The h consecutive unit
pieces each contribute exactly `alpha=2delta`. The residual interval maps
injectively, apart from irrelevant endpoints, to a circular arc of measure u.
Its intersection with the bad pulse therefore has measure at most
`min(u,alpha)`, even when it intersects two adjacent pulse pieces in a real
line representation. There is no loss or extra pulse at the period cut.
Translation can place the shorter arc inside the longer, attaining that
maximum. The excess over `alpha*u` is maximized exactly at `u=alpha`,
with value `alpha(1-alpha)`. Thus the phase-uniform additive constant
`alpha(1-alpha)/w` is sharp over lengths and phases.

For the insertion setting, `m,b>=1` implies `N>=3`, so
`C=(2/N)(1-2/N)>0` and `R=sum_i 1/w_i>0`. The proposed coverage budget
forces `2b/N<1`. If the open fast bad union covered the entire closed
protected interval I, neighborhoods of its two endpoints would also cover
a slightly enlarged interval. Applying the same estimate there gives

```text
L+2epsilon <= (2b/N)(L+2epsilon)+C R
            <= L+(4b/N)epsilon < L+2epsilon.
```

This contradiction validates equality in the budget. No slow safety outside
I, positive measure of the good set, or strict endpoint slack is assumed.

**Algebra, tail optimization and the existing contract.** The slow margin
and radius are exactly
`gamma=1/(N-b)`, `eta=b/[N(N-b)]`, `r=eta/M`, with `L=2r`.
The norm's Lipschitz inequality preserves every slow coordinate at the
closed target `1/N` throughout I. Substitution into the coverage budget
gives

```text
M R <= D_(N,b)=b(N-2b)/[(N-b)(N-2)],  1<=b, 2b<N.
```

The harmonic-mean and minimum-speed reformulations have the stated factor
`K_(N,b)=(N-b)(N-2)/(N-2b)`. The identity
`K_(N,b)-(N-1)=N(b-1)/(N-2b)` has the correct sign.

For b=1 the threshold is `w>=(N-1)M`. The actual
`LonelyRunner.fastRunnerInsertion` consumes the closed old margin and
coordinatewise absolute-speed inequalities, permits signed real speeds,
and returns displacement at most `1/(N|w|)`. Its `n=N-2` specialization
has exactly this speed threshold. The new interval proof gives only
`eta/M`; it does not strengthen that displacement or the one-fast scope.
This is a source-contract comparison, not a new compilation receipt.

For fixed b and `m=N-1-b`, any m-element slow set has maximum at least
`v_m`, while any b-element fast set has reciprocal sum at least the sum
over the b largest speeds. Both factors are positive; the tail partition
attains both minima simultaneously. Under lower-count seed supply and
absence of a full witness, each resulting tail inequality must fail
strictly. The necessary profile is therefore `M R>D_(N,b)`, not its
opposite and not a weak failure at equality.

**The two hand controls and the arithmetic profile.** For
`N=7, V_A=(1,6,10,21,A,A+1)`, the slow seed `1/4` gives norms
`(1/4,1/2,1/2,1/4)>1/5`. For b=2, the sufficient minimum fast speed is
`(25/3)*21=175`. Thus A=420 passes the group criterion while its optimal
one-fast tail fails because `421<6*420`. This establishes additional scope
over that particular one-fast speed test.

At A=84, the three permitted tail products are respectively

```text
84/85 > 1/6,
21(1/84+1/85) > 1/4 > 6/25,
10(1/21+1/84+1/85) > 10/21 > 3/20.
```

These are all b with `1<=b<7/2`; tail optimality rules out every partition
for this sufficient test. Direct residue calculations also verify the full
positive controls, in the displayed speed order:

| A | Time | Norm numerators and common denominator |
| --- | --- | --- |
| 420 | `211/840` | `(211,414,410,231,420,209)/840` |
| 84 | `43/168` | `(43,78,74,63,84,41)/168` |

Their minima exceed `1/7`. They are not no-witness examples.

Every deletion leaves 1 or the consecutive pair A,A+1, proving all deletion
gcds and primitivity. Divisibility by 2 through 7 is supplied respectively
by `6,6,A,10,6,21`. The orbit-capacity sums are exactly `3/2` at ell=2
and 1 at ell=3. For ell>=4, three divisible speeds without A+1 would
include two of 6,10,21, whose pair gcd is at most 3. With A+1, only 10
can share a divisor of that size, since A+1 is coprime to 6,21,A.
Thus at least four nondivisible terms remain, each at least `2/7`.
This proves the orbit profile for all unbounded ell, not a finite sample.

There are 63 nonempty index subsets. Each subset gcd is at most A+1, so
`F<=63(A+1)<=26523<21^5`; the height condition follows too. Every speed
obeys the strict one-fast exclusion, and both max/min ratios exceed 6.
The label graph has the claimed star at A+1: its relevant gcds are one,
except possibly gcd with 10, which is at most 5 and satisfies `A+11>35`.
Hence A=420 separates the new necessary tail profile from the old profile;
A=84 shows their conjunction remains compatible. Neither implication
may be reversed into a characterization of counterexamples.

**The ordinary one-seed obstruction for `2b>N`.** Here `m>=1` also
forces `b<=N-2`, and the admissible range has at least two fast speeds.
An arbitrarily large M in the stated residue class exists. The slow
speeds `M-2bj` are distinct positive integers and all have phase one-half
at `s=1/(2b)`, satisfying their own margin. Odd W>M separates the groups;
the two fast speeds W,W+2 are coprime, so the full tuple is primitive.

The imposed M inequality is exactly what gives

```text
2(b-1)r < 2/N-1/b < 1/b.
```

Consequently the proposed fast cyclic gaps remain positive for every
`|u|<=r`, including the closing gap. Their maximum is strictly below
`2/N`; every point of the circle is within half such a gap of a fast
phase. The common translation by `W(s+u)` preserves these gaps, so at
every time in I some actual fast coordinate is strictly bad. W can grow
arbitrarily while the same estimate remains valid. No independently
assigned starting phases have been substituted for ordinary velocities.

This blocks the chosen seed interval only. For m=1, the own-margin seeds
and protected intervals are exactly the centers and entire closed good
bands of the single slow speed. Existence of an escape from at least one
such band is equivalent to a full witness, and is not supplied by the
lower-count seed alone. The obstruction does not refute that assertion.

**The critical horizon uses one shared time.** On the finite product of
uniform intervals `[0,1/w_i]`, put `T=A+sum_i U_i`. For each i, fixing all
other increments makes `theta_i+w_i T` traverse one complete phase period.
Normalized integration in that coordinate gives bad-event probability
exactly 2d. Endpoint choices have measure zero. Finite product integration
then preserves this marginal after integrating the other coordinates.
Only the auxiliary increments are independent; the runner phases need not
be. All events are evaluated at this same T, which always lies in the
same compact interval `[A,A+sum_i 1/w_i]`.

For `0<d<1/(2b)`, the union bound leaves positive probability of a common
d-good time. The finite minimum of the b continuous norm functions has
an attained maximum G on that fixed interval. If `G<1/(2b)`, its midpoint
with `1/(2b)` is a strictly larger positive subcritical d, contradicting
the preceding existence result. This proves the closed critical margin
without assuming positive probability or strict surplus at the boundary.
It works for every translated interval, arbitrary real phases, and positive
real frequencies, including repetitions and incommensurable frequencies.

The period sum P is at most `b/W` when each frequency is at least W.
Equal frequencies with equally spaced phases verify the exact sharp-margin
control and temporal good-point spacing `1/(bW)`. They justify only the
horizon lower bound `C_b>=1/b`, not optimality of the sufficient `C_b=b`.
The stronger shifted margin `1/(b+1)` is not obtained.

For b=2, each interval of length `3/(2w_min)` contains one complete slow
good band of length `1/(2w_min)`. If that closed connected band had no
common witness, it would lie in one open bad component of the other
frequency, whose length is at most that same value. Such containment is
impossible even at equality. Thus the separate `C_2=3/2` control is valid;
it does not dominate the parameter-dependent P bound in every case.

**Critical insertion and comparison.** If `N>=2b`, the period-sum
condition is exactly

```text
M P <= A_(N,b)=2b/[N(N-b)].
```

It puts a length-P interval inside the protected slow interval. One time
then satisfies the fast margin `1/(2b)>=1/N` and all slow margins.
Equality is retained. At `N=2b`, this becomes `M P<=1/b`, and the
minimum-speed condition `w_i>=b^2 M` suffices. This resolves the frozen
first report's critical local issue. There is no contradiction with its
`2b>N` obstruction, where `1/(2b)` is below the desired margin `1/N`.

For `2b<N`, the exact ratio is
`A_(N,b)/D_(N,b)=2(N-2)/[N(N-2b)]`. With b>=2 and integer N, A is larger
precisely when `N-2b=1`; when `N-2b>=2`, D is strictly larger. There is
no single criterion dominating the other throughout the subcritical range.
At N=7 the new b=2 threshold is `4/35<6/25`, while the new b=3 threshold
is `3/14`, still below the A=84 tail's lower bound `10/21`. Thus A=84
continues to fail both displayed reciprocal-sum tests.

Both results remain conditional on a slow seed and a partition meeting a
quantitative separation inequality. No argument supplies such a partition
uniformly, covers all potential counterexamples, or proves that every full
witness lies in these protected intervals. They are manuscript insertion
results, not an unrestricted induction or a new kernel-checked theorem.

**Actual checks.** Current configuration, workflow, policy and focused state
were read. The binding command was:

```sh
sha256sum research/astra-uniform-multi-fast-gluing.md research/astra-critical-interval-horizon.md LonelyRunner/FastRunnerInsertion.lean docs/fast-runner-insertion.md research/astra-uniform-divisor-minimality.md research/astra-subset-gcd-profile-screen.md research/astra-uniform-label-cut-profile.md
```

It exited 0 with the complete output reproduced above. The required command
`python3 -B scripts/validate_workflow.py` exited 0 with complete output:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

The documentation scan
`rg -n '[ \t]+$' research/astra-uniform-multi-fast-review.md`
returned no output and exit 1: no trailing whitespace was found.

All mathematical checks were the displayed hand arguments and exact source
contract reads. No mathematical program, enumeration, external literature
inference, Lean invocation or cache operation was performed. No other source,
shared state or Git data was edited. The validator verifies workflow only.
