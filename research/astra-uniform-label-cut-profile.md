# Label-cut witness condition versus the arithmetic profile

Date: 2026-09-06. Task `/root/uniform_label_cut_profile`, using the existing
`/root/uniform_seed_coupling` session with requested Astra/xhigh routing.
Source checkpoint: `15a34041b72e17734d746fea005c83130a7e41fb`.
Only this report is worker-owned. Status: manuscript proof and exact hand
control, requiring independent mathematical review; no Lean declaration.

**Result.** The disconnected-label-graph condition adds information beyond
the specified arithmetic profile for composite N. The exact control

```text
N=8,  v=(1,2,4,6,8,15,42)
```

has an isolated label 6 while satisfying full primitivity, every deletion gcd
one, every denominator `2..N` covered, every reciprocal-orbit capacity
inequality, both stated height bounds, and the stated fast-speed exclusion.
It even has a full own-margin witness. Thus the arithmetic profile does not
imply graph connectedness. This is a counterexample to that proposed
implication, not to LRC, and is not a runner-count milestone.

A direct uniform isolated-anchor lemma also gives explicit common witness
times without constructing the arc graph. These are the two bounded
arguments in this report; no classification of composite N is attempted.

## Exact inherited scope and source bindings

For positive distinct integer speeds `v_1,...,v_(N-1)`, let

```text
H = {t mod 1 : ||t v_i|| >= 1/N for every i},
C:  i--j iff v_i+v_j > N gcd(v_i,v_j).
```

The independently reviewed circle-arc argument supplies

```text
H=empty implies C connected;
C disconnected implies H nonempty.
```

No deletion-seed assumption is needed: every speed `v>1` retains its arc at
the center `1/v` after coincident-center merging, since another integer grid
contains that center only if its speed is a multiple of v. Speed 1, if
present, retains its widest arc at zero. This intrinsic survival observation
is due to the independent reviewer and strengthens the original author's
seed-conditional proof. It does not assert survival under further containment
pruning. The strict graph edge test comes from open bad arcs; equality is a
nonedge and retains a closed-margin witness.

For prime N, the prior report already proves redundancy under primitivity
and the presence of a speed divisible by N. Across a nonedge, unequal
N-adic valuations would make one reduced quotient at least N and the other
at least one. If C were disconnected, this forces a common valuation across
all vertices, contradicting those two assumptions. That prime argument does
not establish composite-N redundancy.

The profile tested here, with `n=N-1`, is precisely:

```text
gcd(v_i : all i)=1;
gcd(v_i : i != p)=1 for every p;
for each 2<=q<=N, some v_i is divisible by q;
for every ell>=2,
  sum_(ell does not divide v_i) ceil(2 r_i/N)/r_i >= 1,
  where r_i=ell/gcd(ell,v_i);                         (O)
max(v) <= B_N = choose(N,2)^(N-2);
F(v) <= B_N,
  where F(v)=sum_(nonempty index subsets S) gcd(v_i : i in S);
v_p < (N-1) max_(i!=p) v_i for every p.
```

The deletion-gcd condition also gives the all-divisor count bound
`#{i:d divides v_i}<=N-3` for every `d>=2`, so that bound is checked as well.
These are listed necessary arithmetic conditions, not a characterization of
a minimal counterexample. No assumption is transferred to a different
distinguished runner or to pairwise speed differences.

The following current files were read and bound by SHA-256:

| Source | SHA-256 | Use |
| --- | --- | --- |
| `research/astra-uniform-colour-critical-cover.md` | `84b7f417a73dd8e580300390a3e1081f61904ad1860215487f03f7c1a51e578f` | Original label graph and prime redundancy |
| `research/astra-uniform-colour-critical-review.md` | `49e42ed76159de73c3e2fd568021c82942913f76d976a596544323e1ef1caed9` | Accepted graph proof; intrinsic survival removes seeds |
| `research/astra-uniform-divisor-minimality.md` | `8c4b6ee094f0f311f360d3abf371e95f731e28cee997d3810dd3218ff6f25746` | Exact deletion, denominator, orbit, maximum-height and fast-speed profile |
| `research/astra-subset-gcd-profile-screen.md` | `979fb69005f60f4e0f4b350a272ac7234917695b7df085ab858a7bf9324456f9` | Additional subset-gcd definition and bound |
| `research/astra-subset-gcd-profile-review.md` | `f9826bab2d9810e6ff8427fcc57eaf12c0dcf5ff0d346d1a9ebdb182ab35cf81` | Accepted scope of the subset-gcd refinement |

The last two files carry their original primary-source scope review. No new
external literature assertion or external retrieval is used here.

## Approach 1: an isolated anchor gives two explicit common times

Fix an integer `N>=2`, a positive integer anchor m, and a finite collection
of positive integer speeds. Assume, for every speed a in the collection,

```text
a+m <= N gcd(a,m).                                   (A)
```

Neither membership of m, distinctness, nor a prescribed number of speeds is
needed. If `a=m` occurs, its condition is automatic from `N>=2`. When m is
a speed in the original graph setting, (A) says that its label is isolated.

**Lemma.** Each of the two times

```text
t_minus = (N-1)/(Nm),        t_plus = (N+1)/(Nm)
```

has `||t a||>=1/N` for every speed a. Either formula supplies one common
time for the entire collection, with the same sign for every coordinate.

**Proof.** For a fixed a, write `g=gcd(a,m)`, `a=gd`, `m=ge`, where d,e are
positive coprime integers. Assumption (A) becomes `d+e<=N`, and

```text
t_plus a = d/e + d/(Ne),
t_minus a = d/e - d/(Ne).
```

If `e=1`, then `1<=d<=N-1`. Periodicity of the circle norm gives

```text
||t_plus a|| = ||t_minus a|| = ||d/N|| >= 1/N.
```

If `e>=2`, coprimality gives a nonzero residue of d modulo e. Therefore
`||d/e||>=1/e`. The circle norm is 1-Lipschitz, so for either sign,

```text
||d/e +/- d/(Ne)|| >= ||d/e|| - d/(Ne)
                    >= (N-d)/(Ne)
                    >= 1/N,
```

where the last step is `d+e<=N`. This also treats boundary equality correctly.
For the anchor itself, `t m=1 +/- 1/N` has norm exactly `1/N`. QED.

Equivalently, allowable reduced ratios to an isolated anchor have the form
`a/m=d/e`, with `(d,e)=1` and `d+e<=N`. This directly motivates a hand
construction by selecting such ratios. The lemma's proof does not allow
independently assigned phases, and it requires an actual anchor obeying (A).
It does not supply such an anchor for an arbitrary tuple or for connected C.

The minus formula was derived during this screen; root independently checked
the same argument and supplied the equally valid plus version.

## Approach 2: a control satisfying the entire listed profile

Set `N=8`, `n=7`, and use the distinct positive integers

```text
v=(1,2,4,6,8,15,42),        m=6.
```

**Disconnected graph.** The six reduced-ratio checks are:

| a | gcd(a,6) | a/gcd(a,6) | 6/gcd(a,6) | Reduced sum |
| --- | --- | --- | --- | --- |
| 1 | 1 | 1 | 6 | 7 |
| 2 | 2 | 1 | 3 | 4 |
| 4 | 2 | 2 | 3 | 5 |
| 8 | 2 | 4 | 3 | 7 |
| 15 | 3 | 5 | 2 | 7 |
| 42 | 6 | 7 | 1 | 8 |

Every sum is at most N. Thus label 6 is isolated and C is disconnected. In
particular the last equality is important: turning the strict edge test into
a weak one would change this graph.

**Every deletion gcd is one.** Every deletion except that of speed 1 leaves
speed 1. Deleting speed 1 leaves the coprime pair 2,15. Hence every deletion
gcd is one, as is the full gcd. The all-divisor upper bound `C_d<=5=N-3`
follows: six divisible coordinates would be a deletion complement of gcd
greater than one. No particular deleted coordinate has been omitted.

**Every small denominator is covered.** The following table covers every
integer in the required range, not just the prime powers:

| q | 2 | 3 | 4 | 5 | 6 | 7 | 8 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| A speed divisible by q | 6 | 6 | 8 | 15 | 6 | 42 | 8 |

**Every orbit inequality (O), including unbounded ell.** For any orbit size
`r>=2`,

```text
ceil(2r/8)/r >= (2r/8)/r = 1/4.                    (2)
```

For `ell=2`, the only nondivisible speeds are 1 and 15. Each has orbit size
2 and contributes `ceil(1/2)/2=1/2`. The sum is exactly one.

For every `ell>=3`, at most three of the seven speeds are divisible by ell.
Here is an exhaustive structural proof without scanning divisors:

* If ell is odd, it divides none of `1,2,4,8`; only `6,15,42` are possible.
* If ell is even and a power of two, then `ell>=4`. It divides at most `4,8`:
  speeds 6 and 42 have 2-adic valuation one, and 15 is odd.
* If ell is even and not a power of two, it has an odd prime factor and
  divides none of `1,2,4,8`. It also cannot divide 15 because it is even.
  Only `6,42` remain possible.

Thus at least four nondivisible speeds contribute to (O) for every `ell>=3`.
Inequality (2) makes their sum at least one. Together with the exact ell=2
case, this proves all infinitely many orbit inequalities. No finite cutoff,
prime-only replacement, or extrapolation is involved.

**Both height bounds and the fast-speed exclusion.** Here
`B_8=choose(8,2)^6=28^6`. Clearly `max(v)=42<B_8`. There are `2^7-1=127`
nonempty index subsets and each subset gcd is at most 42. Consequently

```text
F(v) <= 127*42 = 5334 < 28^3 < 28^6 = B_8.
```

This uses the full nonempty-subset sum, not just singleton terms. Root
supplied this deliberately loose bound; no subset enumeration is needed.
The largest coordinate satisfies `42<7*15=105`. For every other coordinate,
the complementary maximum is 42 and `v_p<=15<7*42`. This proves every stated
fast-speed necessary inequality as well.

**Explicit positive witnesses and all deletion seeds.** Approach 1 gives
`t_minus=7/48`. In the displayed speed order its exact norms are

```text
(7,14,20,6,8,9,6)/48,
```

whose minimum is `6/48=1/8`. Root additionally supplied the simpler strong
common time `s=3/10`, at which the norms are

```text
(3/10, 2/5, 1/5, 1/5, 2/5, 1/2, 2/5).
```

Their minimum is `1/5>1/7=gamma`. Thus the same s supplies every single
deletion's own-margin seed. This verifies seed compatibility directly and
does not invoke any unproved higher-count lower-count theorem. In fact Q
also holds immediately for this control, since a full strong witness is
itself a seed and a full target witness. The control has no simultaneous
trapping or full-cover property.

## What is established, and implementation relevance

The universal implication from the entire displayed arithmetic profile to
connected C is false. The control supplies every listed hypothesis and a
disconnected graph; the earlier prime-N redundancy therefore cannot extend
to all composite N under that profile. No claim is made for every composite
N individually, or about independence from every sufficient theorem in the
repository. The positive example is fully compatible with ordinary LRC.

The isolated-anchor lemma is a reasonable small arithmetic implementation
candidate after independent review, if an existing lemma does not already
subsume its contract. It provides explicit rational common times and needs
only gcd reduction, circle-norm periodicity, and the Lipschitz bound. Full
arc-graph infrastructure is unnecessary for that subcase. No implementation
or cache restoration is part of this task, and formalizing this conditional
lemma alone would leave the unrestricted supply gap intact.

The genuinely unresolved obligation is a uniform witness argument covering
tuples for which the label graph is connected, or an additional theorem that
forces a suitable cut or anchor under stronger justified hypotheses. This
screen supplies neither. It also makes no inference from general H nonemptiness
to Q: outside this explicitly strong-witness control, that implication remains
unproved.

## Verification receipt and limits

Current project configuration, workflow, policy and focused active state were
read, with the task in `research / in_progress`. The structural validator
was run using

```sh
python3 -B scripts/validate_workflow.py
```

Its complete output was

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

The new mathematics consists entirely of the displayed hand proofs and exact
rational identities. No mathematical program, enumeration, external model,
external literature retrieval, Lean invocation or dependency restoration was
used. Source bindings were read with `sha256sum`; documentation whitespace
was checked separately. No state, Git data, cache, or other source was edited
by this worker. Independent mathematical review remains required before
promotion. This bounded screen is complete; the unrestricted project goal
remains open.
