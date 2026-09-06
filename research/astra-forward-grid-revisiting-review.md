# Independent review of the revisiting-repair failure family

**Verdict: accepted as a manuscript counterexample to the specified
least-index revisiting algorithm.** Every bounded state in the claimed
region has a strictly bad fast label. The algorithm enters that region,
cannot succeed or leave it while respecting its rules, and exhausts a
digit budget after finitely many increments. The explicit alternate
assignment is forward-good in the same adapted grid. General forward
supply and unrestricted LRC are therefore not refuted.

Date: 2026-09-06. Task `/root/forward_grid_revisiting_review`, in the existing
`/root/uniform_screen_review` session, requested Astra/xhigh. The reviewer
authored neither the new manuscript nor its insertion dependency. Observed
runtime model/effort, total elapsed time and token usage are not independently
exposed and remain null. Parent-supplied current checkpoint:
`737ac0634c02c21025bcafebacc97c9152f04bf4`; the author's earlier task
checkpoint is retained in its file. Only this review is worker-owned.

## Source bindings and exact scope

The entire new manuscript was read. The three earlier sources were already
read in this review session, and their current hashes were rechecked:

| Artifact | SHA-256 |
| --- | --- |
| `research/astra-forward-grid-revisiting-repair.md` | `701d79271d329f4a37ccf52a649d224e7c15238f71a282446762d591403527c8` |
| `research/astra-forward-grid-uniform-supply.md` | `1a13ab3fab7652987d2494d1a799d8ee21857a5faca972d687b0c99c9017e8e2` |
| `research/astra-forward-grid-insertion.md` | `b1185bc69414dbb6dfa36bc04ed2a80f92b75856867190015b19c53216babb33` |
| `research/astra-forward-grid-insertion-review.md` | `ba90a5a4fa2cb6e767a2c85d8b6d6c4a9d0d1a54bdc47e5f4c870591138adb82` |

The algorithm starts with ordinary zero phases and all digits zero on
increasing positive integer speeds. It chooses the least-index label whose
fractional phase is outside `[1/N,1-1/N)`, increments that label's digit
until it becomes good, and restarts the scan. An increment past N-1 is
failure. Digits are never decreased or reset. The counterfamily is for
every odd N>=7, not all counts allowed in the algorithm's general definition.
This review does not depend on the concurrent narrow-cluster rescue work.

## Actual family, arity and the weighted bound

Put C=N^4, M=N^8 and R={0,...,N-1} minus {2,4,6}. Since N>=7 the three
omitted residues are distinct members of that set. There are N-3 fast
speeds: w_0=M and w_r=M+C+r for each nonzero r in R. Together with speed
one this gives exactly N-2 positive distinct integer speeds, already
ordered with 1 and M first. The tuple is primitive. Since N divides both
C and M, every fast speed is congruent to its index r modulo N.

For the asserted region, the speed-one digit is a=1, the w_0 digit satisfies
1<=k_0<=N-1, and every other digit is between zero and N-1. Write

`u=sum_r k_r/(N*w_r)`, `A=N*u`, `K=sum_r k_r`,

`c_0=0`, `c_r=C+r` for r!=0, and
`cbar=(sum_r k_r*c_r/w_r)/A`.

The mandatory k_0 gives A>0 and u>0. Thus cbar is a genuine nonnegative
weighted mean. Subtracting C+1 before taking this mean gives

`A*(cbar-C-1)=-k_0*(C+1)/M + sum_(r!=0) k_r*(r-1)/(M+C+r)`.

There are N-4 terms in the positive sum. All their numerators are
nonnegative, so replacing each denominator by M is an upper bound.
Using k_0>=1 and the digit limits bounds the whole expression above by

`[-(C+1)+(N-4)*(N-1)*(N-2)]/M < 0`.

The strict inequality follows from `(N-4)*(N-1)*(N-2)<N^3<N^4=C`.
Consequently cbar<C+1 throughout the full region, including cases in
which some or all other digits are zero. No positive lower bound on those
other digits is assumed.

## Uniform error bounds and exact phases

Since there are N-3 fast labels and every w_r>=M,

`0<u< N/M`, more precisely `u<=(N-3)*(N-1)/(N*M)`.

All c_r and their mean lie in [0,C+N-1]. For
`e_r=(c_r-cbar)*u` this gives

`|e_r| <= (C+N-1)*u < (C+N)*N/M`

`=1/N^3+1/N^6 <= 2/N^3 < 1/N`.

The last strict inequality holds for N>=7. Also N/M=1/N^7<1/N, so the
actual slow phase 1/N+u lies in (1/N,2/N), without wrapping. This is
contained in the forward-good band at the stated counts.

The identity is exact, rather than an approximation for a tight cluster.
Expanding the definitions yields

`K=sum_r k_r*(M+c_r)/w_r=(M+cbar)*A`.

Therefore `M*u=K/N-cbar*u`, and at the one common time t=1/N+u,

`w_r*t = (r+K)/N+e_r mod 1`.

Let h=-K modulo N, represented in 0,...,N-1. If h is in R, label w_h
has an integer base phase. Its norm is at most |e_h|<1/N, including either
sign and e_h=0. If h is absent, then h is 2, 4 or 6. Its predecessor
r=h-1 is respectively 1, 3 or 5, present in R even at N=7. This label's
base fractional phase is (N-1)/N. Moreover c_r>=C+1>cbar and u>0, so
`0<e_r<1/N`. The actual fractional phase lies strictly between (N-1)/N
and one, with no wrap. It too is strictly bad for the closed target.

These cases exhaust every possible K residue. Thus every bounded assignment
in the region has a strictly bad fast label, while the slow label is
forward-good. A boundary equality is never treated as a negative margin:
the zero-base case uses an absolute error strictly below 1/N, and the
upper-base case uses an error strictly above zero and below 1/N.

## Forced entry, invariance and finite failure

At the initial zero time the least bad label is speed one. Its first own
increment gives a=1 and t=1/N, which is forward-good for that label.
On restarting, the next label M is bad because M/N is an integer.
One own increment makes k_0=1 and its phase 1/N. These two repairs are
mandatory under the specified least-index rule and respect both budgets.
Before entering the region there was a bad label at each of the initial
two states, so no earlier success is overlooked.

After entry, the slow label is good at every bounded state, including
intermediate states within a repair. It is never selected again, hence
a remains one. The digits never decrease, so k_0 remains at least one.
Every legal later increment therefore keeps the state in the region.
The region theorem rules out success after any number of revisits.

The sum of fast digits increases by one at each completed increment and
is at most `(N-3)*(N-1)`. A finite scan always finds a bad label, whose
repair either makes another increment or attempts to exceed its budget.
Thus infinite repair with valid budgets is impossible. Failure occurs
after at most `1+(N-3)*(N-1)` completed increments, counting the original
slow increment. A repair needing two steps can fail on its second step;
the same bound covers that intermediate state.

The familiar local bound of one or two steps is correct: the forward-bad
arc is half-open of length 2/N, containing exactly two consecutive points
of any translated N-grid. Its validity does not prove global preservation
or sufficient total digit budget. Least-index selection is needed to force
the initial region entry; once there, every bad-label-only repair policy
with the same monotone bounded digits faces the same exclusion. This is
a revisiting failure proof, not a single-pass trace.

## Alternate witness for every odd N>=7

Set a*=(N-1)/2, k_0*=1 and all other fast digits zero. These are permitted
integer digits because N is odd, and a*>1. At

`t*=a*/N+1/(N*M)`

the slow phase is strictly between 1/N and 1/2: its base is
`1/2-1/(2N)`, and M>2 makes the positive correction smaller than 1/(2N).
Since N divides M, label M has fractional phase exactly 1/N, an included
lower boundary.

For every other fast label, the exact phase modulo one is

`(a* r+1)/N+(C+r)/(N*M)`.

The relation `2a*=N-1` implies that a* is a unit modulo N, including
when N is composite. The affine map r -> a*r+1 therefore permutes all
residues. Directly, its values at 2, 4 and 6 are respectively 0, -1 and
-2 modulo N. These are their unique preimages, and all three were omitted.
Every remaining base residue belongs to 1,...,N-3. For r!=0 the correction
is strictly positive and less than 1/N, because `C+r<=N^4+N-1<N^8=M`.
Hence the actual fractional phase lies in `(1/N,(N-2)/N)`, with no wrap,
and is forward-good. The r=0 label was treated separately, so its zero
correction is not incorrectly claimed positive.

This proves an actual assignment in the very same grid, outside the region
because a*>1. In particular, the tuple has an ordinary closed LRC witness.
The algorithm's failure comes from its permitted trajectory and digit rules,
not from absence of forward-good assignments.

## Limits and receipts

No source correction is required. This result does not refute algorithms
that change an already good slow digit, decrease/reset digits, choose a
different initialization or use another witness construction. It supplies
no universal replacement algorithm. General forward supply, the full
adapted-grid candidate and unrestricted LRC remain unresolved.

The complete new source was read with:

```sh
cat research/astra-forward-grid-revisiting-repair.md
```

It exited 0 and returned the full source bound above. The earlier input
files had already been fully read in this session; their unchanged bindings
were verified below. No separate cluster-rescue report was used.

Current project config, workflow, policy and focused state were read.
The following command ran in `/home/joshua/lonely-runner-formalization`:

```sh
python3 -B scripts/validate_workflow.py
```

Exit 0; complete output:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

Actual source readback commands:

```sh
sha256sum research/astra-forward-grid-revisiting-repair.md
sha256sum research/astra-forward-grid-uniform-supply.md research/astra-forward-grid-insertion.md research/astra-forward-grid-insertion-review.md
```

Both exited 0, with complete outputs respectively:

```text
701d79271d329f4a37ccf52a649d224e7c15238f71a282446762d591403527c8  research/astra-forward-grid-revisiting-repair.md
```

```text
1a13ab3fab7652987d2494d1a799d8ee21857a5faca972d687b0c99c9017e8e2  research/astra-forward-grid-uniform-supply.md
b1185bc69414dbb6dfa36bc04ed2a80f92b75856867190015b19c53216babb33  research/astra-forward-grid-insertion.md
ba90a5a4fa2cb6e767a2c85d8b6d6c4a9d0d1a54bdc47e5f4c870591138adb82  research/astra-forward-grid-insertion-review.md
```

All new mathematical verification was by the hand algebra, inequalities,
finite-budget reasoning and exact alternate assignment above. No numerical
trace, simulation, mathematical program, enumeration, Lean, Git, cache
action, shared-state mutation or other-file edit was performed. This
review accepts a manuscript proof, not a new kernel-checked theorem.

Owned-file whitespace check:

```sh
rg -n '[ \t]+$' research/astra-forward-grid-revisiting-review.md
```

Exit 1 with empty output: no trailing-whitespace matches. The final review
SHA-256 is returned separately after freezing the file.
