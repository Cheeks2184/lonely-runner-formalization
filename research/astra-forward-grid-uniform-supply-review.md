# Independent review of forward supply under a reciprocal-tail bound

**Verdict: accepted as a manuscript theorem for the stated separated class,
and as a counterexample to the specified one-pass repair rule.** The greedy
construction supplies an actual forward-good adapted-grid assignment. The
ordinary counterfamily does not refute forward supply, and no argument
reduces arbitrary tuples to the sufficient separation hypothesis.

Date: 2026-09-06. Task `/root/forward_grid_supply_review`, in the existing
`/root/uniform_screen_review` session with requested Astra/xhigh routing.
The reviewer authored neither the supply manuscript nor its insertion
dependency. Observed runtime model/effort, total task time and token usage
are not independently exposed and remain null. Parent-supplied current
checkpoint: `3434ef30b7b3031c9883e976cbc076ab33afefe1`; the author's earlier
task checkpoint is preserved in its source. Only this review is owned.

## Actual source bindings

The entire supply manuscript and insertion manuscript were read, together
with the independent insertion review. The existing Lean declaration was
read for the precise single-fast threshold, without invoking Lean.

| Artifact | SHA-256 |
| --- | --- |
| `research/astra-forward-grid-uniform-supply.md` | `1a13ab3fab7652987d2494d1a799d8ee21857a5faca972d687b0c99c9017e8e2` |
| `research/astra-forward-grid-insertion.md` | `b1185bc69414dbb6dfa36bc04ed2a80f92b75856867190015b19c53216babb33` |
| `research/astra-forward-grid-insertion-review.md` | `ba90a5a4fa2cb6e767a2c85d8b6d6c4a9d0d1a54bdc47e5f4c870591138adb82` |
| `LonelyRunner/FastRunnerInsertion.lean` | `dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5` |

All bindings matched actual files. Current project config, workflow, policy
and focused active state were read; structural validation passed. This
acceptance is tied to the hashes, not to an assumption that all input
checkpoint labels denote the current checkout.

## Greedy construction and exact endpoint budget

The main contract permits N>=3, any finite arity m>=1, positive real
frequencies v_i and arbitrary fixed real phases theta_i. No integrality,
distinctness or arity relation to N is assumed. The displayed order must
satisfy, for every i,

`(N-1)*sum_(j>i) v_i/v_j <= N-3`.                     (S)

The candidate times are exactly `sum_i k_i/(N*v_i)` with digits
0<=k_i<N and zero added time offset. The phases are fixed inputs; they
are never selected independently to repair different labels.

At stage i, put x=fract(theta_i+v_i*t_(i-1)), write N*x=a+r with integer
0<=a<N and 0<=r<1, and choose k_i as the representative of 1-a modulo N
in 0,...,N-1. Then a+k_i is congruent to one modulo N, so the new
fractional phase is exactly `(1+r)/N`. It lies in `[1/N,2/N)`.
Uniqueness follows either from the same residue calculation or from the
partition into half-open intervals of length 1/N. This remains true at
r=0 and for arbitrary, including negative, original phases.

All future digit contributions increase the common time. For this label,
their total phase increment is

`e_i=sum_(j>i) k_j*v_i/(N*v_j)`.

The full allowed digit range, not a two-step assumption, proves
`0<=e_i<=((N-1)/N)*sum_(j>i) v_i/v_j<=(N-3)/N`.
Thus its final phase, before any hypothetical wrap, satisfies

`1/N <= (1+r)/N+e_i < 2/N+(N-3)/N = 1-1/N < 1`.

It does not wrap, and this expression is the actual final fractional
phase. The argument simultaneously preserves every processed label at
the one final time. The upper inequality remains strict even when (S)
is equality, because r<1. The lower face is included. It proves the
claimed forward-good band `[1/N,1-1/N)` and therefore also the closed
norm bound. It does not promise strictness at the lower face.

For N=3, (S) has zero right side. Positivity excludes every nonempty
later tail, so only m=1 can satisfy it. For that case the selected band
`[1/3,2/3)` is already the required final band. The theorem claims no
separated construction for multiple positive frequencies at N=3. Arbitrary
finite arity is otherwise legitimate: neither the digit choice nor the
tail argument uses m=N-2 or m=N-1.

## Ratio corollary, order and comparison

For N>3 define `R_N=2+2/(N-3)>1`. If successive ratios are at least R_N,
then `v_i/v_(i+h)<=R_N^(-h)`. A finite nonempty tail is strictly smaller
than its infinite geometric majorant

`1/(R_N-1)=(N-3)/(N-1)`.

Empty tails are zero, so (S) follows in all positions, including exact
equality in a successive-ratio hypothesis. There is no infinite-arity
claim: the theorem uses only finite lists.

Also, (S) itself implies for every j>i that
`v_i/v_j<=sum_(h>i) v_i/v_h<1`. Any admissible nontrivial ordering must
therefore be strictly increasing. Reordering a tuple cannot conceal a
failure of its increasing-order tail bound. This observation supplies no
partition theorem and no guarantee that arbitrary tuples satisfy (S).

The actual declaration `fastRunnerInsertion` uses n old moving speeds,
an old closed margin 1/(n+1), and a new speed whose absolute value is at
least (n+1) times every old absolute speed; its new target is 1/(n+2).
For the full N-runner target, n=N-2, so its speed threshold is N-1 times
the old maximum. The source accepts equality and either sign for the
new speed, whereas this manuscript assumes positive frequencies.

For N>=5, `R_N<N-1` since `(N-3)^2>2`. A geometric list with common
ratio R_N satisfies (S), while its largest speed has ratio below N-1
to the next largest. This correctly compares the sufficient speed
hypotheses for that direct insertion application. It does not establish
dominance over every insertion argument or other witness construction;
the old-witness premise of the Lean theorem must also be retained.

## Composition with the integer insertion contract

For ordinary positive integer speeds at m=N-2, the greedy conclusion is
the exact forward-good predicate of the bound insertion manuscript.
Condition (S) already forces distinctness when there is more than one
speed. Let L=lcm(v), M=max(v), D=N*L and choose w=N*L*M=D*M.
Then D divides w, w>M, and

`w>(N-1)*D*M/N`.

The insertion contract applies without rounding or representing a new
arbitrary real witness: old candidate phases lie on the denominator-D
lattice, and each new nonzero digit gives displacement
`0<ell/(N*w)<1/(D*M)`. Its new phase is ell/N; the old forward-good
phases remain closed-good by that contract. Thus appending w supplies
a full adapted-grid witness. This specialization requires ordinary
integer speeds; the arbitrary fixed-phase version is not silently
passed through the integer commensurability argument.

Alternatively m=N-1 in the new greedy lemma already supplies the full
closed-grid witness under (S). Both uses are valid uniform sufficient
results, and both retain that condition. Neither is an unrestricted
adapted-grid theorem or a kernel-checked implementation.

## Failure of the specified local repair

The different repair algorithm visits labels once, in increasing order,
starting with every digit zero. A visit increments its own digit only
until the current phase enters the forward band, then never returns to
that label. On an N-grid, the complement of `[1/N,1-1/N)` is a half-open
circular arc of length 2/N, containing exactly two consecutive residues.
For N>=3, at most two forward steps exit it. Because a coordinate is
unvisited before its single turn, two steps respect its digit budget.
This is a local statement about that visit, not about preservation later.

For every N>=5 the tuple

`V_N={1,...,N-4,N-2,N-1}`

has exactly N-2 distinct positive speeds, including speed one. The first
visit sets t=1/N. All intermediate labels are already forward-good, so
their digits stay zero. The last phase is (N-1)/N, the excluded upper
face. One step takes it to zero and another to 1/N. The final time is
`1/N+2/[N*(N-1)]`, with legal digits one and two at the two changed
coordinates. The earlier speed N-2 has phase

`1-2/[N*(N-1)] > 1-1/N`,

strictly below one and strictly above the good band since N>3. Its norm
is therefore below 1/N. This proves failure even of the closed common
target, without violating any local repair rule.

When 3 does not divide N, take the unique nonzero k modulo N with
3*k=1. It is a unit. The grid contains t=k/N using only the speed-one
digit. No speed in V_N is sent to residue zero, and the unique speed
residue sent to -1 is -3, namely the omitted N-3. Every actual phase
is consequently among 1/N,...,(N-2)/N, all forward-good. This proves
forward supply for that unbounded subfamily, even though the one-pass
algorithm fails. No alternative witness is asserted by this calculation
when 3 divides N.

At the penultimate speed, the left side of (S) is N-2, exceeding N-3.
Thus the positive subfamily also proves (S) is not necessary for forward
supply. The construction refutes neither repair with revisits nor all
repair algorithms; termination and digit-budget control for such methods
remain separate questions.

## Disposition and actual checks

No correction is required. General ordinary forward supply for arbitrary
m=N-2 positive integer tuples remains unresolved. The settled separation
contract supplies no reduction of every tuple to its domain, and the
failed repair supplies no old tuple lacking a forward-good assignment.
No mathematical program or control search was executed or enlarged here.
No Lean invocation, Git or cache action, shared-state mutation or other-file
edit was performed.

Commands ran in `/home/joshua/lonely-runner-formalization`. The structural
check was:

```sh
python3 -B scripts/validate_workflow.py
```

Exit 0; full output:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

Actual source readback commands:

```sh
sha256sum research/astra-forward-grid-uniform-supply.md
sha256sum research/astra-forward-grid-insertion.md research/astra-forward-grid-insertion-review.md LonelyRunner/FastRunnerInsertion.lean
```

Both exited 0, with full outputs respectively:

```text
1a13ab3fab7652987d2494d1a799d8ee21857a5faca972d687b0c99c9017e8e2  research/astra-forward-grid-uniform-supply.md
```

```text
b1185bc69414dbb6dfa36bc04ed2a80f92b75856867190015b19c53216babb33  research/astra-forward-grid-insertion.md
ba90a5a4fa2cb6e767a2c85d8b6d6c4a9d0d1a54bdc47e5f4c870591138adb82  research/astra-forward-grid-insertion-review.md
dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5  LonelyRunner/FastRunnerInsertion.lean
```

Mathematical verification consisted of the hand digit/residue derivation,
tail and geometric inequalities, exact phase checks and source-contract
comparison above. These are manuscript checks, not a new Lean proof.

Owned-file whitespace check:

```sh
rg -n '[ \t]+$' research/astra-forward-grid-uniform-supply-review.md
```

Exit 1 with empty output: no trailing-whitespace matches. The frozen review
SHA-256 is returned separately, avoiding a self-referential hash claim.
