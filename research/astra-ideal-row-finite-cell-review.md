# Independent review of the ideal-row finite-cell reduction

**Verdict: accepted as a manuscript equivalence and explicit conditional
transfer bound.** The reduction covers arbitrary real slopes, including
cut-boundary inputs, repeated slopes and repeated cells. Combined with the
unchanged N=5 receipt, it supports ideal closed selection for every three
real slopes at computational/manuscript level. It establishes no result
for all N, no finite-M cluster success theorem and no new LRC cutoff.

Date: 2026-09-06. Task `/root/ideal_row_finite_cell_review`, in the existing
`/root/uniform_screen_review` session, requested Astra/xhigh. This reviewer
authored neither the new reduction nor the transfer manuscript or control.
Observed runtime model/effort, total task time and token usage are not
independently exposed and remain null. Parent-supplied source checkpoint:
`15ef35a75c255f3fcdaafe8fb289f1fe6d97ee30`. Only this review is worker-owned.

## Bound inputs and verified scope

The complete new manuscript was read. The transfer, its earlier independent
review, the full control receipt and decoded control source were already
read in this session. Their hashes were checked again, without repeating
the mathematical execution or the earlier receipt-decoding checks:

| Artifact | SHA-256 |
| --- | --- |
| `research/astra-ideal-row-finite-cell-reduction.md` | `44aca4f3cff905074d315515fb88a08b0957b9b200d016c34f55dce3701ac1fb` |
| `research/astra-ideal-row-integer-transfer.md` | `a8e53ac960a0cd0907437a38042ed574498259a472dc92cf223e4568f1124ebc` |
| `research/astra-ideal-row-transfer-review.md` | `6ff5010979d42c2ebfacf98c7e33a2e599a80c13c8caec1ec42f7b269f599921` |
| `research/astra-general-slow-row-control.json` | `fbef3674ec3c30719325cfc91d0fc15c1a347377d0b4e8bd114e487059363d0c` |

The unchanged receipt retains the previously verified 3,776-byte program
with SHA-256 `6b951fede947acc0791bc8f2ab46a0011717d81bd77d0dc0278756c3f49afbe3`.
Current config, workflow, policy and focused state were read; structural
validation passed. No other agent's current selection review is an input.

## Openness, cuts and exact masks

Fix N>=5 and b=N-2. The pair set includes all k=1,...,N-2 with
ell=0,...,N-1, and the exceptional pair (N-1,0). For each slope x, its
mask consists of precisely those pairs with `norm((k*x+ell)/N)<1/N`.
Failure of ideal closed selection is exactly coverage of this finite pair
set by the b masks. In particular its negation uses strict bad inequalities;
failure of an upper-strict forward target would be a different contract.

The mask is periodic in x with period N: changing x by N*z changes the
phase by the integer k*z. Thus every real input can first be represented
in [0,N), without altering any mask. At a failing tuple select one bad
index for every pair. All selected deficits are positive, and their finite
minimum is positive. Continuity, or the Lipschitz bound with coefficient
k/N<1, preserves all selected inequalities in a common neighborhood.
One need not preserve the pairs for which an individual slope was good.

The normalized inputs can therefore be perturbed off all cuts while
remaining in (0,N). If an input is zero, choose a sufficiently small
positive perturbation; any other input has an interior neighborhood after
shrinking the allowed perturbation. Repeated slopes present no obstacle,
and the perturbed slopes are allowed to occupy the same cell. Periodicity
handles original negative inputs and multiples of N. Thus a failing tuple
at a boundary cannot be lost by restricting to open cells.

For a fixed pair, crossing between good and bad requires

`k*x+ell=N*z+1` or `k*x+ell=N*z-1`.

Any such x in [0,N] equals j/k for an integer j with 0<=j<=N*k.
Since every permitted k is between one and N-1, all these boundaries are
among the stated cuts C_N. The exceptional pair is included in that
range. On any consecutive open cut interval the continuous norm never
equals 1/N, so its sign relative to that threshold is constant. Integer
wraps do not invalidate continuity of the norm; their locations are also
cuts. Each complete bad-pair mask is therefore constant on the open cell.

## Duplicate removal, padding and both directions

Replace every perturbed slope by its cell midpoint. All masks, and hence
their union, remain unchanged. When two slopes use the same midpoint,
discarding one removes no covered pair. This leaves at most b distinct
midpoints still covering the whole pair set.

C_N contains the N+1 integers from zero through N, so it has at least
N consecutive intervals and at least N different midpoints. As N>b,
one can add unused midpoints until exactly b are present. Adding a mask
cannot destroy coverage. This step is about failure, where an additional
bad label preserves the obstruction; it does not assume that adding a
label preserves a good pair.

Thus every failing real b-tuple yields a failing b-element midpoint
subset. Conversely every such subset is itself a real tuple, so the
equivalence is exact. No separate enumeration of boundary inputs or
repeated-cell tuples is necessary. The argument does not assume the
perturbation keeps the original slopes distinct or their original cells.

## Denominator gap and explicit integer parameters

If neighboring cuts are j/k and l/h, their midpoint is
`(j*h+l*k)/(2*k*h)`. Its reduced positive denominator is at most
`D=2*(N-1)^2`. Distinct failing midpoints therefore supply b distinct
rationals r_i in (0,N), each with denominator q_i<=D. Their product
q is a positive common denominator satisfying q<=D^b. Consequently
`d_i=q*r_i` are distinct positive integers below N*q, and
`H=max d_i-min d_i<N*q`.

At a chosen bad pair, the phase at r_i has denominator dividing N*q_i.
Its circle norm can be written m/(N*q_i) with a nonnegative integer m.
Strict badness is m<q_i, so its deficit is

`(q_i-m)/(N*q_i) >= 1/(N*q_i) >= 1/(N*D)`.

This proves the claimed lower bound for the finite minimum eta, including
wrapped phases and the exceptional pair. No numerical tolerance or
unproved lower bound on distances between adjacent cuts is used.

Choose exactly `T=D*(N-1)+1`, then set

`a=q`, `M=N*q*T+min d_i`, `c_i=d_i-min d_i`.

The offset set contains zero, has maximum H and contains b distinct
nonnegative integers. Since max(H,q)<N*q and T>N-1,

`M>=N*q*T>(N-1)*max(H,q)`.

The transfer error is bounded strictly by

`H*(N-1)/(N*M)<(N-1)/(N*T)<1/(N*D)<=eta`.

The second strict inequality uses T>D*(N-1); the added one is material
when the selected deficit attains its denominator lower bound. Thus the
previously accepted transfer applies with its full strict hypotheses.
It yields N-1 distinct positive integer speeds and failure of every
proposed two-digit assignment. No primitive-speed assumption is needed.

For this chosen T each fast speed is

`M+c_i=N*q*T+d_i<N*q*(T+1)<=N*D^b*(T+1)`.

The slow speed q is smaller as well. Substituting b=N-2 and D gives
the bound exactly as written:

`N*[2*(N-1)^2]^(N-2)*[2*(N-1)^3+2]`.

The first strict inequality ensures the final height bound is strict even
if q=D^b. Larger T also satisfy the transfer, but need not obey this one
height bound. The bound is conditional on ideal selection failing and
applies to the resulting auxiliary two-digit counterexample. It is not
a completeness bound for arbitrary finite-M failures, full adapted-grid
failure, or all-real LRC failure. No actual failing midpoint subset is
provided in this manuscript.

## New meaning of the same N=5 evidence

The unchanged program uses precisely C_5: its separately inserted endpoint
five is already in the defined cut set and adds no different sample. It
forms all consecutive midpoints and all three-element subsets. The retained
31 cuts, 30 cells and 4,060 subsets therefore match the exact finite family
of this theorem. Its tested labels are exactly the 16 pairs in P. The
previously reviewed Fraction predicates treat both good endpoints as closed.

The recorded nonfinding means that every tested subset has at least one
pair good for all its slopes. Combining this finite fact with the new
equivalence gives the precise statement:

For every three real numbers r_1,r_2,r_3, there is a pair among k=1,2,3
with ell=0,...,4 or the exceptional pair (4,0), for which all three
norms `norm((k*r_i+ell)/5)` are at least 1/5.

This includes equal slopes, slopes at cuts and slopes outside [0,5).
It is a justified extension of the interpretation through a new proof,
not an alteration of the old execution domain. The earlier review required
an additional argument before making such an extension; this manuscript
now supplies it. The recorded single run remains unchanged, and its
found-witness modular-recomputation branch remains unexercised.

Acceptance has the evidentiary status stated by the author: a manuscript
theorem supported by the retained exact computation, not a kernel proof.
It does not imply actual success after positive finite-M corrections,
which can spoil an ideal upper endpoint. It also supplies no result for
other N. The uniform unresolved obligation is exclusion of full mask covers
by b midpoints for arbitrary N, or an actual failing subset. This review
does not turn individual larger counts into a research roadmap.

## Actual receipts and disposition

No correction is required. The complete new source was read with
`cat research/astra-ideal-row-finite-cell-reduction.md` (exit 0).
All new mathematical checking was by continuity, connected-interval
reasoning, finite set operations, rational arithmetic and ordered bounds.
No new mathematical program, enumeration, numerical domain, receipt replay,
Lean invocation, Git or cache action, shared-state mutation or other-file
edit was performed.

Commands ran in `/home/joshua/lonely-runner-formalization`. Source readback:

```sh
sha256sum research/astra-ideal-row-finite-cell-reduction.md research/astra-general-slow-row-control.json research/astra-ideal-row-integer-transfer.md research/astra-ideal-row-transfer-review.md
```

Exit 0; complete output:

```text
44aca4f3cff905074d315515fb88a08b0957b9b200d016c34f55dce3701ac1fb  research/astra-ideal-row-finite-cell-reduction.md
fbef3674ec3c30719325cfc91d0fc15c1a347377d0b4e8bd114e487059363d0c  research/astra-general-slow-row-control.json
a8e53ac960a0cd0907437a38042ed574498259a472dc92cf223e4568f1124ebc  research/astra-ideal-row-integer-transfer.md
6ff5010979d42c2ebfacf98c7e33a2e599a80c13c8caec1ec42f7b269f599921  research/astra-ideal-row-transfer-review.md
```

Workflow check:

```sh
python3 -B scripts/validate_workflow.py
```

Exit 0; complete output:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

Owned-file whitespace check:

```sh
rg -n '[ \t]+$' research/astra-ideal-row-finite-cell-review.md
```

Exit 1 with empty output: no trailing-whitespace matches. The frozen review
SHA-256 is returned separately after the final readback.
