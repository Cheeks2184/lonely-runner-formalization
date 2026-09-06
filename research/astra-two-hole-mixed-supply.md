# Direct-or-mixed supply through height N+1

2026-09-05. Author task `/root/two_hole_constructor`, requested Astra/xhigh;
runtime model/effort metadata is not independently exposed. Assigned source
checkpoint: `5e7d690e6606ad096bf4a2319be0328f9c6d2e68`. This task owns only
this note and is excluded from Pass29. Research is authorized; unrestricted
LRC remains unresolved. **Disposition: the proposed claim is true by the
self-contained manuscript proof below. Author audit is complete; independent
semantic review and the separately specified routine controls are pending.**

Let N>=4, and let W contain exactly N-1 distinct positive integer moving
speeds, with H=max(W)<=N+1. The chosen runner is stationary at speed zero.
Write ||x|| for distance to the nearest integer. The proposed
claim is true by the manuscript argument below: either some integer
2<=d<=N divides no member of W, or a positive rational T satisfies

```text
||kT||>=1/N for every k in W, and ||HT||>=1/(N-1).
```

All inequalities are closed. The first branch itself gives an ordinary
witness T=1/d. This is a stronger-margin supply result on an already covered
structured domain: `BoundedHeight.lean` already proves the ordinary 1/N
witness for every W here. No new ordinary coverage, Lean proof, unrestricted
supply, or novelty is claimed.

## Compact complete case split

Distinctness and positivity give H>=N-1. If H=N-1, then
W={1,...,N-1}, and d=N is direct.

If H=N, write W={1,...,N} minus {a}, where 1<=a<N. If a=1, use
T=1/(2N): all retained phases lie in [1/N,1/2], and ||NT||=1/2.
If 2a>N, use d=a: its only positive multiple at most N is omitted.
Otherwise 2<=a and 2a<=N. For N>=2a+1 use
T=1/a-1/(2aN); for N=2a use T=1/a-1/[N(N-1)].
These are the one-deletion formulas from the frozen earlier manuscript;
a self-contained verification is included below.

Suppose H=N+1. Then W={1,...,N+1} minus {c,d}, with 1<=c<d<=N.
If 2d>N+1, use d directly. Otherwise 2d<=N+1 and 2c<=N-1.

If N>=2c+3, the interval [N+2,2N-c-2] contains at least c consecutive
integers. Choose u in this interval congruent to 1 modulo c and put q=c+u.
Then gcd(c,q)=1, q-c=u>H, H<q<=2(N-1), and c is omitted. Take the
inverse r of c modulo q with 1<=r<q and set T=r/q. For a retained k,
0<k<q and k is neither c nor q-c. Therefore rk modulo q is neither 0,
1 nor q-1; hence ||kT||>=2/q>=1/(N-1). This proves even the stronger
margin for every retained coordinate.

In the remaining case, N<2c+3 together with 2c<=N-1 implies
N=2c+1 or N=2c+2. In either case c<d and 2d<=N+1 force d=c+1.
Thus the remaining parameter constraints give exactly two families:

- Even N=2a: c=a-1,d=a. For a=2, W={3,4,5} and T=1/10 gives
  norms 3/10,2/5,1/2. For a>=3 put c=a-1 and
  epsilon=1/(2cN), T=1/c-epsilon. Retained multiples k of c have
  k>=2c and ||kT||=k*epsilon>=1/N. Nonmultiples satisfy
  ||kT||>=1/c-H*epsilon=(N-1)/[N(N-2)]>=1/(N-1).
  If H is itself a multiple of c, its exact norm H*epsilon is also
  >=1/(N-1). All shifts k*epsilon are below 1/2.
- Odd N=2a+1: c=a,d=a+1, with a>=2. Put epsilon=1/(2aN),
  T=1/a-epsilon. Retained multiples have k>=2a and exact norm
  k*epsilon>=1/N, while nonmultiples have
  ||kT||>=1/a-H*epsilon=1/N. For the fastest speed,
  HT=2+f, where f=(3a+1)/[a(2a+1)]. At a=2 the endpoint norm is
  3/10>=1/4. For a>=3, 0<f<=1/2 and f>=1/(2a)=1/(N-1).

All returned times are rational and strictly between zero and one, as checked
below. The nonmultiple estimates use the universal norm inequality
||x+y||>=||x||-|y| and ||k/c||>=1/c whenever c does not divide k.
The exact multiple estimates require the shift range checked above, not
an unjustified assumption about a linear piece of the circle norm.

## Complete range and inequality checks

For the direct branch, if d divides no retained k, the nonzero integer
residue of k modulo d has cyclic distance at least one. Therefore
||k/d||>=1/d>=1/N. Each selected d lies in [2,N]: d=N in the first
case; the omitted a>N/2 when H=N; and the larger omitted d>(N+1)/2
when H=N+1. In the latter two cases, the first positive multiple is
omitted and the second exceeds H, so no larger multiple can be retained.
Also 0<1/d<1. This branch does not assert the fastest margin.

For the height-N one-deletion case with N>=2a+1, put
epsilon=1/(2aN). Every retained multiple k of a has k>=2a, and
k*epsilon<=N*epsilon=1/(2a)<=1/4<1/2. Hence

```text
||kT||=k*epsilon>=1/N                        (a divides k),
||kT||>=1/a-N*epsilon=1/(2a)>=1/(N-1)        (a does not divide k).
```

If a divides H=N, the exact endpoint norm N*epsilon=1/(2a)
also meets the stronger threshold. When N=2a, the only retained multiple
is H=N, whose shift is N*epsilon=1/(N-1)<=1/3<1/2. Every other
retained k is at most N-1 and is a nonmultiple, giving

```text
||NT||=1/(N-1),
||kT||>=1/a-(N-1)/[N(N-1)]=1/N.
```

Both choices have 0<epsilon<1/a, so 0<T<1/a<=1/2<1. This proves
the used formulas directly without relying on the earlier manuscript's
review disposition or on its larger epsilon interval.

In the modular branch, the inclusive interval has

```text
(2N-c-2)-(N+2)+1=N-c-3>=c
```

integers. Every c consecutive integers meet every residue class modulo
c; this also covers c=1, for which congruence to one is congruence to
zero. To make the choice fully explicit, use

```text
L=N+2, e=(1-L) mod c with 0<=e<c, u=L+e, q=c+u.
```

Then u<=L+c-1<=2N-c-2 and gcd(c,q)=gcd(c,u)=1. The standard inverse
representative 0<=r<q cannot be zero because cr is congruent to one
modulo q and q>1. Thus 0<T=r/q<1. For y=rk mod q, multiplication by
c shows that y=0,1,q-1 would give k congruent to 0,c,-c respectively.
The strict ranges 0<k<q and 0<c<q identify these possibilities as
k=0,c,q-c, all excluded. Consequently 2<=y<=q-2 and
||kT||=min(y,q-y)/q>=2/q. Because q<=2(N-1) and q>0, this is at
least 1/(N-1)>1/N for every k in W, including H.

In the even central family with a>=3, c=a-1>=2 and N=2c+2>=6.
The largest perturbation has the required strict range because

```text
0<k*epsilon<=H*epsilon=(N+1)/(2cN)<1/2,
cN-(N+1)=(c-1)N-1>0.
```

The removed speed c is the only positive multiple below 2c. For a
retained multiple the exact norm is therefore k*epsilon>=1/N, as
stated. For every nonmultiple, the displayed stronger bound follows from
2c=N-2 and the identity

```text
(N-1)^2-N(N-2)=1>0.
```

If H is a multiple, comparison of its exact norm with 1/(N-1) follows
from

```text
H*(N-1)-2cN=(N+1)(N-1)-N(N-2)=2N-1>0.
```

This conditional comparison covers every possible endpoint multiple;
no unproved claim that H must be a nonmultiple is used. Here
0<epsilon<1/c, giving 0<T<1/c<=1/2. At the separately handled N=4,
T=1/10 is positive, every listed norm exceeds 1/4, and 1/2>=1/3.

In the odd central family, a>=2 and H=2a+2<=3a. Therefore

```text
0<k*epsilon<=H*epsilon<=3/(2N)<=3/10<1/2.
```

The exact multiple and nonmultiple estimates in the case split apply.
For the endpoint, direct algebra gives

```text
HT=2+(3a+1)/[a(2a+1)]=2+f.
```

At a=2, f=7/10 and ||HT||=1-f=3/10>=1/4. For a>=3,
f>0, and the comparisons needed to identify the norm and its margin are

```text
a(2a+1)-2(3a+1)=2a^2-5a-2=(a-3)(2a+1)+1>0,
2(3a+1)-(2a+1)=4a+1>0.
```

Thus f<1/2 and f>1/(2a), so ||HT||=f>=1/(N-1).
Again 0<epsilon<1/a, hence 0<T<1/a<=1/2. These estimates include
the a=3 boundary and do not assume that f<=1/2 at a=2.

The positivity, exact shift ranges, inverse range, and closed inequalities
above establish the disjunction for every tuple in the stated domain.

## Source observations

The actual `twoHoleDenominator_family_witness` proof requires a positive
target parameter, positive c<q, target<q<=2*target, coprimality, positive
speeds strictly below q, and avoidance of both c and q-c. Its displayed
conclusion is ordinary 1/target. For the modular branch here set its target
to N-1, not N: all those full hypotheses hold. The earlier residue lemma
also directly proves the 2/q lower bound used above. No proof of an
unrestricted mixed-margin supply statement is inferred from this local reuse.

Read-only sources:

| File | SHA-256 |
| --- | --- |
| `LonelyRunner/BoundedHeight.lean` | `681c38dae0158ffd4162fa471c429dea4e8b90e27ee6e3a6fdf7b3cbd6e47ecc` |
| `research/astra-direct-mixed-supply.md` | `a619c863d2d4c10c90f21572caee371bf1b55d6ebfdaf81d9e4f24aeec4fd818` |

The full existing `boundedHeight_stationary_witness` theorem takes n>=3
positive injective natural speeds bounded by n+2, and returns a common
closed 1/(n+1) witness. Our substitution is n=N-1, so its domain contains
every tuple considered here. The conclusion here distinguishes a direct
reciprocal certificate from a witness with a stronger fastest-coordinate
margin; it makes no assertion about the same margin in the direct branch.

## Settled fixed routine-control contract

The root may assign these controls separately to Terra/medium. No control
program has been run by this author, and the controls do not replace the
quantified proof. Use Python standard-library `Fraction` arithmetic only;
no floating point, broad tuple search, sampled times, optimization, Lean,
dependencies, or cache work. Define W literally as {1,...,H} minus the
listed holes, and use exactly the following sixteen positive controls.

| ID | N | H | Holes in {1,...,H} | Branch | Prescribed certificate |
| --- | --- | --- | --- | --- | --- |
| C01 | 4 | 3 | none | consecutive | direct d=4 |
| C02 | 4 | 4 | 1 | first hole | T=1/8 |
| C03 | 5 | 5 | 3 | large single hole | direct d=3 |
| C04 | 4 | 4 | 2 | one-deletion boundary | T=5/12 |
| C05 | 5 | 5 | 2 | one-deletion nonboundary | T=9/20 |
| C06 | 4 | 5 | 1,3 | large second hole | direct d=3 |
| C07 | 5 | 6 | 1,2 | modular c=1 | u=7,q=8,r=1,T=1/8 |
| C08 | 7 | 8 | 2,3 | modular tight interval | u=9,q=11,r=6,T=6/11 |
| C09 | 10 | 11 | 3,4 | modular longer interval | u=13,q=16,r=11,T=11/16 |
| C10 | 4 | 5 | 1,2 | even exception | T=1/10 |
| C11 | 6 | 7 | 2,3 | even central first | T=11/24 |
| C12 | 8 | 9 | 3,4 | even endpoint multiple | T=5/16 |
| C13 | 10 | 11 | 4,5 | even central nonmultiple | T=19/80 |
| C14 | 5 | 6 | 2,3 | odd central a=2 | T=9/20 |
| C15 | 7 | 8 | 3,4 | odd central a=3 | T=13/42 |
| C16 | 9 | 10 | 4,5 | odd central a=4 | T=17/72 |

For each row check the literal domain, cardinality N-1, positivity,
distinctness, maximum H and H<=N+1. Compute its certificate using the
displayed formulas in the proof and verify agreement with the table; the
table is an expected result, not permission to silently substitute a new
formula. In each direct row verify 2<=d<=N and k mod d !=0 for every
retained k, then use T=1/d. For every row check 0<T<1 and every ordinary
closed 1/N inequality. In each of the thirteen mixed rows check the
fastest closed 1/(N-1) inequality at the same T.

Additionally verify these branch-specific proof quantities:

- For C04-C05 and C11-C16, exact norms k*epsilon and shifts strictly
  below 1/2 for retained multiples of the perturbation denominator;
  check the stated nonmultiple lower bound. C04 uses its boundary bound,
  C05 and C11-C13 use the stronger bound, and C14-C16 use 1/N.
- For C07-C09, use the explicit least-residue formula for u, and verify
  all interval inequalities, gcd(c,q)=1, inverse range and congruence,
  speed<q, avoidance of c and q-c, cyclic distances at least 2, and
  all stronger coordinate bounds 2/q>=1/(N-1).
- For C12 verify the endpoint is a retained multiple and its exact norm
  is H*epsilon. For C14-C16 check HT=2+f, the correct norm at a=2,
  and 0<f<1/2 at a=3,4.

Use two additional named range guards, not purported counterexamples to
the theorem:

- G01: For N=4, H=5, holes {1,2}, blindly extending the c=1 even
  perturbation gives epsilon=1/8 and T=7/8. At k=5 the shift is
  5/8>1/2 but its norm is 3/8, so the exact identity norm=k*epsilon
  is false. This altered T still happens to meet the mixed target;
  the guard exposes the invalid range inference, not witness failure.
- G02: At C14, the endpoint phase correction is f=7/10>1/2 and the
  actual norm is 3/10, not f. This is why the a=2 endpoint is separate.

Emit every certificate, all exact norms and checked auxiliary values in
deterministic order, with actual counts and pass/fail results. Save the
program, output, hashes, exact invocation and source manuscript hash in a
separately owned artifact. These sixteen positive rows and two range guards
are the entire finite domain; there is no request to search other tuples.

## Commands and freeze boundary

The startup instructions, configuration, policy, relevant current state and
validator source were read; `python3 -B scripts/validate_workflow.py` passed.
Other commands were focused file listings, source/manuscript `rg` and `sed`
reads, read-only `git rev-parse HEAD` and `git status --short`, source SHA-256
checks, and writing/readback of this sole owned manuscript. A quick memory
registry search found no relevant Lonely Runner entry; no prior memory fact
is used. An initially overlarge state read was output-truncated; a subsequent
focused JSON read retrieved authorization, current assignments and the full
candidate derivation. One finalization patch failed its exact-context check
before writing; the corrected patch was applied successfully. No command
was interrupted or left running.

This audit confirms the root's candidate formulas after supplying their
missing range and endpoint justifications. No numerical search or control
program, Lean build, cache operation, Git mutation, state edit, or modification
of another manuscript occurred. The one-deletion source remains frozen.
The final manuscript hash is reported separately to the root so this file
does not contain a self-referential hash. Next actions are independent
semantic review and the separately owned fixed routine controls; all owned
commands are stopped at freeze. The canonical research goal is unresolved.
