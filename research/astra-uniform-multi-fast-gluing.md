# Multiple-fast insertion from one protected slow interval

Date: 2026-09-06. Task `/root/uniform_multi_fast_gluing`, using the existing
`/root/uniform_seed_coupling` session with requested Astra/xhigh routing.
Source checkpoint: `8b9ea58d8a477a0fad733c3cf6674c307c1f9782`.
Only this report is worker-owned. Status: manuscript derivation and exact
hand controls, requiring independent review. No novelty or Lean claim.

**Result.** Root's sharp discrepancy bound is valid. It gives the closed
insertion criterion

```text
M sum_(i=1)^b 1/w_i <= b(N-2b)/[(N-b)(N-2)],          (H)
```

for `1<=b`, `2b<N`, from the supplied slow seed specified below. For fixed b,
the optimal partition for this test puts the b largest speeds in the fast
group. The b=1 threshold is exactly the existing one-fast speed threshold.
The new tail conditions add a necessary profile, but even that enlarged
profile remains compatible. For `2b>N`, an actual ordinary integer-speed
family defeats a guarantee around every supplied slow seed despite arbitrarily
large fast speeds. The boundary `2b=N` is left unresolved beyond the failure
of this sufficient estimate.

## 1. Sharp one-color discrepancy on a finite interval

Let `0<delta<1/2`, `alpha=2delta`, `w>0`, and let J be a closed real interval
of positive length L. For an arbitrary fixed phase theta, put

```text
B={t : ||wt+theta||<delta},
x=wL=h+u,       h=floor(x),       0<=u<1.
```

Write `length(B intersect J)` for ordinary length; on a bounded interval this
is a finite union of intervals. After scaling by w, each full unit period
contributes alpha. The remaining interval has length u and intersects a
single periodic pulse of measure alpha in at most `min(u,alpha)`. Thus

```text
length(B intersect J)
  <= [h alpha+min(u,alpha)]/w
   = alpha L + [min(u,alpha)-alpha u]/w
  <= alpha L + alpha(1-alpha)/w.                     (1)
```

The intermediate expression is the exact maximum over translations: align
the shorter of the residual interval and pulse inside the longer. The
discrepancy is `(1-alpha)u` for `u<=alpha` and `alpha(1-u)` otherwise, whose
maximum is `alpha(1-alpha)` at `u=alpha`. Hence the final additive constant
is sharp uniformly over phases and lengths. Closed interval endpoints do
not affect these lengths; the strict bad-set topology will matter below.

For the LRC threshold, (1) is exactly

```text
length(B intersect J)
  <= 2delta L + 2delta(1-2delta)/w.
```

This phase-uniform estimate is only an interval calculation. Applying it with
theta=0 to ordinary speeds assumes no shifted form of LRC.

## 2. Protected interval and the equality case

Partition `N-1=m+b` distinct positive integer speeds into m slow speeds
`u_1,...,u_m` and b fast speeds `w_1,...,w_b`, with `m>=1`, `b>=1`. Let
`M=max_j u_j>0` and assume one common slow seed s satisfying

```text
||s u_j|| >= gamma=1/(m+1)=1/(N-b)  for every j.
```

Set

```text
delta=1/N,
eta=gamma-delta=b/[N(N-b)],
r=eta/M,
I=[s-r,s+r],             L=2r=2b/[N(N-b)M].
```

The circle norm is 1-Lipschitz. For every `t in I`,

```text
||t u_j|| >= ||s u_j|| - u_j |t-s|
           >= gamma-Mr = delta.                     (2)
```

Let the fast bad sets be `B_i={t:||w_i t||<delta}`. More generally they may
have fixed phases theta_i; the following proof remains valid. Put
`alpha=2/N`, `C=alpha(1-alpha)>0`, and `R=sum_i 1/w_i`. The union bound and
(1) imply

```text
length((union_i B_i) intersect I) <= b alpha L + C R. (3)
```

**Closed insertion lemma.** If

```text
b alpha L + C R <= L,                               (4)
```

then some t in I avoids every strict fast bad set. Together with (2), this
is a full closed delta witness. Condition (4) itself forces `b alpha<1`,
because `C R>0`.

To include equality rigorously, suppose instead that the open union
`U=union_i B_i` covers I. Since its two endpoints are interior points of U,
there is an epsilon>0 such that the enlarged interval
`I_epsilon=[s-r-epsilon,s+r+epsilon]` is also contained in U. Apply (1) on
this enlarged interval, of length `L+2epsilon`. Then

```text
L+2epsilon
  <= b alpha(L+2epsilon)+C R
  <= L+2b alpha epsilon
   < L+2epsilon,
```

a contradiction. Slow safety outside I is irrelevant: enlargement is used
only to contradict full fast coverage. Thus (4) needs no strict inequality,
no positive measure of good times, and no choice of endpoint owner.

Substituting the displayed values into (4) gives exactly (H). Equivalently,
the harmonic mean of the fast speeds obeys

```text
b/R >= K_(N,b) M,
K_(N,b)=(N-b)(N-2)/(N-2b).                            (5)
```

It suffices that every fast speed be at least `K_(N,b)M`; this simpler
minimum-speed condition is stronger than (H). The proof supplies one common
time in I and does not select a different phase adjustment for each label.

## 3. Existing b=1 contract and the necessary tail profile

The actual declaration `LonelyRunner.fastRunnerInsertion` was inspected in
`LonelyRunner/FastRunnerInsertion.lean`. For n_old old real speeds it consumes
their common margin `1/(n_old+1)`, `newSpeed != 0`, and

```text
|newSpeed| >= (n_old+1)|oldSpeed_i|  for every i,
```

and supplies margin `1/(n_old+2)` with displacement at most
`1/[(n_old+2)|newSpeed|]`. Its signs and inequalities are closed. The metric
lemma `abs_circleNorm_sub_circleNorm_le` gives the Lipschitz step used in (2).

For b=1 here, `n_old=N-2`, and (H) reduces to

```text
w >= (N-1)M.
```

Thus there is no b=1 speed-threshold improvement. The existing declaration
also gives the finer displacement `1/(Nw)` and permits signed speeds; the
new interval argument only promises displacement at most `eta/M`. Its new
scope is simultaneous insertion of a group that can have comparable speeds.

Under the lower-count hypothesis, every nonempty slow subtuple of size
`m<=N-2` has the required own-margin seed. Therefore a hypothetical
minimal-count counterexample must fail (H) strictly for every admissible
partition and every integer `1<=b<N/2`.

Sort its speeds as `0<v_1<...<v_(N-1)` and put `m=N-1-b`. For fixed b,
the minimum of the left side of (H) over partitions is

```text
v_m sum_(i=m+1)^(N-1) 1/v_i.
```

Indeed, every m-element slow set has maximum at least `v_m`, and every
b-element fast set has reciprocal sum at least that of the b largest speeds.
Both factors are positive, and the tail partition attains both minima.
Consequently the exact necessary tail profile supplied by this test is

```text
v_(N-1-b) sum_(i=N-b)^(N-1) 1/v_i
   > b(N-2b)/[(N-b)(N-2)]       for every 1<=b<N/2.    (T)
```

This eliminates a combinatorial partition search, not the mathematical
supply gap. Also

```text
K_(N,b)-(N-1)=N(b-1)/(N-2b)>=0,
```

so the criterion still requires substantial scale separation. There is no
universal assertion that some tail passes (H); the control below shows that
even the earlier arithmetic profile together with all of (T) stays compatible.

## 4. One hand template checks both additional scope and the residual

These two values in one template were supplied by root and independently
checked here, specifically to test the uniform criterion and its residual:

```text
N=7,       V_A=(1,6,10,21,A,A+1),       A in {84,420}.
```

For b=2, the slow maximum is 21. The time `s=1/4` has slow norms
`(1/4,1/2,1/2,1/4)`, exceeding the required `1/5`. Here `K_(7,2)=25/3`,
so the sufficient minimum fast speed is `175`.

* At A=420, this condition holds. The largest-speed b=1 hypothesis fails,
  since `421<6*420`. Thus the group condition has additional scope over
  that single-insertion speed test.
* At A=84, every permitted tail fails (H). For b=1 its left side is
  `84/85>1/6`. For b=2 it is `21(1/84+1/85)>1/4>6/25`. For b=3 it is
  `10(1/21+1/84+1/85)>10/21>3/20`. These are exactly all `1<=b<7/2`.
  Tail optimality therefore excludes every partition from passing this test.

Both are positive controls with explicit common witnesses:

| A | Time | Exact norms in the displayed speed order |
| --- | --- | --- |
| 420 | `211/840` | `(211,414,410,231,420,209)/840` |
| 84 | `43/168` | `(43,78,74,63,84,41)/168` |

Their minima exceed `1/7`. No runner-count theorem or failure of other
sufficient witness methods is claimed.

Both controls also satisfy the earlier listed arithmetic restrictions:

* Every deletion retains speed 1, except deletion of 1, which retains the
  consecutive pair A,A+1. Thus all deletion gcds, and the full gcd, are one.
* The integers 2,3,4,5,6,7 divide respectively `6,6,A,10,6,21`.
* For the orbit condition, put `r_i=ell/gcd(ell,v_i)` at nondivisible speeds.
  The sum of `ceil(2r_i/7)/r_i` is `3/2` for ell=2 and 1 for ell=3.
  For ell>=4, at most two speeds are divisible: without A+1, any three
  among `6,10,21,A` contain two of `6,10,21`, whose pair gcd is at most 3;
  with A+1, the only other possible divisible speed is 10, since A+1 is
  coprime to `6,21,A`. Thus at least four terms remain, each at least `2/7`,
  proving every remaining orbit inequality, including unbounded ell.
* The full nonempty-subset gcd sum F obeys
  `F<=63(A+1)<=26523<21^5=choose(7,2)^5`; the maximum-height bound follows
  as well. Every speed satisfies the earlier necessary inequality
  `v_p<6 max_(i!=p)v_i`. Both global spreads exceed 6.
* The label graph with edges `x+y>7 gcd(x,y)` has a star at A+1. Its gcd
  with `1,6,21,A` is one; with 10 the gcd is at most 5, and `A+11>35`.

Thus A=420 shows that adding (T) genuinely restricts that earlier profile,
whereas A=84 shows that the enlarged profile still cannot contradict a
minimal counterexample by arithmetic compatibility alone. Neither control
satisfies a no-full-witness hypothesis. The unresolved cases require a
different mechanism, rather than a false claim of universal tail selection.

## 5. Actual one-seed obstruction when 2b>N

Assume `m=N-1-b>=1` and `2b>N`. Choose a positive integer M satisfying

```text
M = b mod 2b,
M > 2b(m-1),
M > 2b^2(b-1)/[(N-b)(2b-N)].
```

Set slow speeds `u_j=M-2bj`, `0<=j<m`, and seed `s=1/(2b)`. They are
distinct and positive, have maximum M, and each has norm `1/2` at s, hence
satisfies the slow own-margin hypothesis. Use the same protected radius
`r=b/[N(N-b)M]` as above.

For any odd integer W>M, set fast speeds `w_i=W+2i`, `0<=i<b`. These are
ordinary positive integer velocities with zero initial phases, and their
minimum divided by M can be made arbitrarily large. Two consecutive odd
fast speeds have gcd one, so the full tuple is primitive.

At `t=s+u`, with `|u|<=r`, the fast phases are

```text
w_i(s+u) = W(s+u) + i/b + 2iu  mod 1.
```

Before the common translation by `W(s+u)`, consecutive gaps are
`1/b+2u`, with closing gap `1/b-2(b-1)u`. The chosen M ensures

```text
2(b-1)r < 2/N-1/b < 1/b.
```

Thus every gap is positive, so this is indeed their cyclic ordering, and
their maximum gap is at most `1/b+2(b-1)r<2/N`. Every point of the circle,
in particular zero after the common translation, is within less than `1/N`
of one of these fast phases. Therefore some fast speed is strictly bad at
every time in the entire protected interval I, independently of W.

This refutes only a local guarantee around every supplied slow seed for
`2b>N`, even at arbitrarily strong separation. It uses actual common-time
ordinary integer velocities, not independently assigned starting phases.
It says nothing against full witnesses elsewhere or escape from another seed.

At `2b=N`, (4) is impossible because its right-side budget is already
exhausted by `b alpha L=L` and `C R>0`. This shows that the current estimate
does not apply; the strict-coverage construction above does not extend to
that boundary, and no general impossibility result there is claimed.

The seed quantifier matters especially when m=1, b=N-2. The slow own-margin
seeds are exactly `s_k=(2k+1)/(2M)`. Their protected intervals have radius
`(1/2-1/N)/M` and are precisely every closed delta-good band of the sole
slow speed. Asking whether at least one such interval contains a full fast
escape is therefore equivalent to full witness existence for that tuple.
It is not an already supplied lower-count induction step. The one-seed
obstruction does not refute that all-seed assertion.

## Source bindings and verification

The existing insertion source and its documentation were read in full;
the earlier profile's orbit contract was reread. Relevant hashes are:

| File | SHA-256 |
| --- | --- |
| `LonelyRunner/FastRunnerInsertion.lean` | `dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5` |
| `docs/fast-runner-insertion.md` | `10222dc0a29a6674d45ae42512074afca50c5f322ec6dfbfd44151ecf55403aa` |
| `research/astra-uniform-divisor-minimality.md` | `8c4b6ee094f0f311f360d3abf371e95f731e28cee997d3810dd3218ff6f25746` |
| `research/astra-subset-gcd-profile-screen.md` | `979fb69005f60f4e0f4b350a272ac7234917695b7df085ab858a7bf9324456f9` |
| `research/astra-uniform-label-cut-profile.md` | `05b89f854f5076ffcfb139a19ea34a8ed6d9481c893211560aa443881bc89326` |

Current project instructions, policy and focused state were read. The
command `python3 -B scripts/validate_workflow.py` passed with output

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

All new mathematics and both hand controls were checked by the displayed
exact arguments. No mathematical program, enumeration, external literature
inference, Lean invocation or cache restoration was used. No other file,
shared state or Git data was edited by this worker. Independent review of
this manuscript remains required; no build or implementation is queued.
The multigroup lemma is a potential reusable insertion contract, but the
controls demonstrate that implementing it alone leaves uniform supply open.
