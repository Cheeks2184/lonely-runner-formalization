# A uniform failure family for revisiting forward repair

Date: 2026-09-06. Task `/root/forward_grid_revisiting_repair`, in the
requested Astra/xhigh session `/root/uniform_seed_coupling`.
Task source checkpoint: `3434ef30b7b3031c9883e976cbc076ab33afefe1`.
Only this report is worker-owned. No mathematical program was run.

**Result.** The specified least-index revisiting algorithm can exhaust a
digit budget before finding a forward-good assignment. An explicit family
of ordinary, distinct positive integer speeds proves this for every odd
N>=7. The proof covers every bounded state reachable after its forced first
two repairs, rather than relying on a sampled or truncated execution trace.
The same family has an explicit forward-good adapted-grid assignment outside
that region. Thus the algorithm is refuted, while general forward-grid
supply and unrestricted LRC remain unresolved.

## 1. Algorithm and actual integer family

The audited algorithm has N>=5 and m=N-2 sorted positive integer speeds.
All starting phases and digits are zero. A phase is forward-good exactly
when its fractional part lies in `[1/N,1-1/N)`. If some label is bad, choose
the least-index bad label and increase its digit by own-coordinate steps
`1/(N v_i)` until that label becomes good. Restart scanning from the first
label after each repair. If any proposed increment would exceed digit
N-1, the algorithm reports failure. Digits are never decreased or reset.

A repair needs one or two increments when there is no budget obstruction:
the forward-bad residues in a translated N-grid are two consecutive
residues. That local observation is retained and is not the source of the
failure below. The failure occurs despite arbitrary allowed revisits.

Fix any odd integer N>=7 and define

```text
C=N^4,                M=N^8,
H={2,4,6},
R={0,...,N-1} minus H,
w_0=M,
w_r=M+C+r             for r in R minus {0}.
```

Use the old speed tuple

```text
V_N={1} union {w_r:r in R},
```

in increasing order. There are `1+(N-3)=N-2` speeds. They are positive,
distinct integers, and the tuple is primitive because it contains 1.
The first two speeds are 1 and M. Both M and C are multiples of N, so
`w_r=r mod N` for every r in R. All phases below come from these actual
velocities at one common time; there are no independent starting offsets.

Write a for the speed-1 digit and k_r for the w_r digit. The candidate time is

```text
t=a/N+u,       u=sum_(r in R) k_r/(N w_r).
```

The region that will trap the algorithm is exactly

```text
a=1,           1<=k_0<=N-1,
0<=k_r<=N-1    for every other r.                    (T)
```

The alternate witness in section 4 changes a; it does not satisfy (T).

## 2. Every bounded state in the region has a strictly bad label

For a state satisfying (T), put

```text
c_0=0,             c_r=C+r for r!=0,
K=sum_r k_r,
A=sum_r k_r/w_r=N u>0,
cbar=(sum_r k_r c_r/w_r)/A.
```

Thus `w_r=M+c_r` and cbar is the weighted mean of the c_r with nonnegative
weights k_r/w_r. The following two bounds hold throughout the entire region.

First, the mandatory digit k_0>=1 forces

```text
cbar<C+1.                                             (1)
```

Indeed, multiplying the desired comparison by A>0 gives the expression

```text
sum_r k_r(c_r-(C+1))/w_r
 = -k_0(C+1)/M
   +sum_(r!=0) k_r(r-1)/(M+C+r)
 <= [-(C+1)+(N-4)(N-1)(N-2)]/M
 < 0.
```

There are N-4 terms in the positive sum, each digit is at most N-1,
and `0<=r-1<=N-2`. The strict final inequality follows from
`(N-4)(N-1)(N-2)<N^3<N^4=C`. This is why the large offset C is included.

Second, put `e_r=(c_r-cbar)u`. All c_r and their mean lie between zero
and `C+N-1`. Also

```text
0<u <= (N-3)(N-1)/(N M) < N/M.
```

Consequently

```text
|e_r| <= (C+N-1)u
      < (C+N)N/M
      <= 2/N^3
      < 1/N.                                         (2)
```

Here M=N^8 and C=N^4. This is why M is taken much larger than C.
The same bound on u gives `u<1/N`, so the slow phase t=1/N+u lies
strictly between 1/N and 2/N, and is forward-good since N>=7.

There is an exact common-time phase identity

```text
w_r t = (r+K)/N + e_r   mod 1.                       (3)
```

To verify it, `w_r/N=r/N mod 1`. Moreover

```text
M u=K/N-cbar u,
w_r u=K/N+(c_r-cbar)u.
```

These follow directly by expanding u and the weighted mean; no asymptotic
replacement of the actual frequencies by equal frequencies is used.

Let h be the residue `-K mod N` in `{0,...,N-1}`. There are two cases.

* If h belongs to R, label w_h has integer base phase in (3). By (2)
  its norm is less than 1/N, regardless of the sign of e_h. It is strictly
  bad for the closed target and hence forward-bad.
* Otherwise `h in H={2,4,6}`. Then `r=h-1 in {1,3,5}` belongs to R.
  Its base fractional phase in (3) is `(N-1)/N`. Its offset obeys
  `c_r=C+r>=C+1>cbar` by (1), so `e_r>0`. By (2) the actual fractional
  phase is strictly between `(N-1)/N` and 1, with no wrap. This label
  is again strictly bad even for the closed target.

This proves that **every assignment in (T) has a strictly bad fast label**,
while its speed-1 label stays forward-good. The argument quantifies over
all bounded digits in the region, not just over a proposed sequence of
repairs. The large numerical powers are explicit and need no optimization.

## 3. The deterministic algorithm enters and cannot leave the region

At the initial time zero every label is bad. The least index is speed 1,
so its first repair sets a=1 and t=1/N, using one increment. On the next
scan speed 1 is good and speed M is bad, because M/N is an integer. Its
first repair sets k_0=1, again using exactly one increment. The algorithm
has now entered (T), and it has not exceeded either digit budget.

While all budgets remain valid, section 2 ensures that speed 1 stays good.
It is therefore never selected again, so a remains 1. No fast digit can
decrease, so k_0 remains at least one. Thus every later bounded state stays
in (T). There is always a strictly bad fast label, so the algorithm cannot
report success, including after any revisit or intermediate increment.

Every successful increment increases a bounded fast digit. There are only
`(N-3)(N-1)` possible fast increments in total from zero. Consequently
the algorithm must eventually attempt an increment that exceeds N-1 and
report budget failure. This happens after at most
`1+(N-3)(N-1)` completed increments including the slow initial increment;
the exact first exhausted label need not be predicted for this proof.

The argument uses the prescribed least-index rule to force entry into (T).
Once there, it rules out success for any sequence of permitted bad-label
repairs that preserves these digit constraints. This is a failure of the
revisiting algorithm itself, not the earlier one-pass failure reasserted
without a termination analysis.

## 4. An explicit alternate forward-good assignment

Set

```text
a*=(N-1)/2,       k_0*=1,       k_r*=0 for r!=0,
t*=a*/N+1/(N M).                                    (4)
```

All digits are integers in the required range because N is odd. The slow
phase lies between 1/N and 1/2: `a*/N=1/2-1/(2N)` and M>2. Thus it is
forward-good. Label M has fractional phase exactly 1/N.

For every other r in R the fractional phase is represented by

```text
(a* r+1)/N + (C+r)/(N M)   mod 1.                    (5)
```

Since `2a*=-1 mod N` and 2 is invertible modulo odd N, multiplication by
a* is a permutation of the residues. Under `r -> a*r+1 mod N`, the unique
preimages of the three residues `0,N-1,N-2` are respectively `2,4,6`.
All three were omitted from R. Therefore the base residue in (5) lies
in `{1,...,N-3}`. The correction is positive and strictly less than 1/N,
because `C+r<M`. There is no wrap, and the final phase lies strictly
between 1/N and `(N-2)/N`, hence is forward-good.

Thus (4) is an actual forward-good assignment in the same old adapted grid,
and in particular an ordinary closed 1/N witness for the tuple. It lies
outside (T) because `a*=(N-1)/2>1`. The algorithm never changes its already
good speed-1 digit from 1 to this value. No contradiction with section 2
or the ordinary common-origin hypotheses occurs.

## Scope and remaining dependency

The exact deterministic revisiting algorithm is not a uniform forward-grid
supply method. Its claimed digit-budget sufficiency is disproved by the
family above for unbounded N, without any numerical search. These tuples
explicitly satisfy forward-grid supply; they refute neither that existential
candidate nor the commensurate insertion theorem nor LRC.

The earlier separated-frequency construction remains valid under its own
reciprocal-tail hypothesis. General forward supply outside such hypotheses
is still open. A different procedure would have to avoid or leave regions
such as (T), or use another witness argument; merely allowing further
revisits of the currently bad labels cannot repair this algorithm within
the same budgets. No replacement algorithm or unrestricted theorem is
claimed. This bounded branch needs no disconnected Lean implementation.

## Source and verification receipt

The earlier one-pass discussion was reread to distinguish its scope from
the present revisiting algorithm. The forward predicate and insertion scope
remain those of the previously reviewed sources, bound here by hash:

| Artifact | SHA-256 |
| --- | --- |
| `research/astra-forward-grid-uniform-supply.md` | `1a13ab3fab7652987d2494d1a799d8ee21857a5faca972d687b0c99c9017e8e2` |
| `research/astra-forward-grid-insertion.md` | `b1185bc69414dbb6dfa36bc04ed2a80f92b75856867190015b19c53216babb33` |
| `research/astra-forward-grid-insertion-review.md` | `ba90a5a4fa2cb6e767a2c85d8b6d6c4a9d0d1a54bdc47e5f4c870591138adb82` |

The new obstruction and alternate witness are proved by the displayed
integer construction, inequalities, and common-time phase identity. No
mathematical program, simulation, solver, enumeration, domain expansion,
external literature claim, Lean invocation or cache restoration was used.
No shared state, Git data, or other source was edited.

Current project config, workflow, policy and focused state were read.
`python3 -B scripts/validate_workflow.py` exited 0 with the complete output

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

Only this report was written. The result is a manuscript proof requiring
independent mathematical review, not a kernel-checked theorem.
