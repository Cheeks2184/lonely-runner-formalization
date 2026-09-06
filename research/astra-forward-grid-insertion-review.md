# Independent review of forward-grid insertion

Accepted as a manuscript theorem with the stated hypotheses and scope.
No correction to the author file is required. The exact equivalence gives
a sound finite falsification contract for the adapted grid, while the
counting argument supplies forward-good assignments only when `2m<=N`.
Neither assertion supplies unrestricted LRC or a general forward-grid theorem.

Review date: 2026-09-06. Requested route: Astra/xhigh, in the existing
independent reviewer session. Source checkpoint:
`600287d55a01d3c8c2d3bf4e4114eee4f9c1271e`.
The complete root-authored file reviewed was
`research/astra-forward-grid-insertion.md`, SHA-256
`b1185bc69414dbb6dfa36bc04ed2a80f92b75856867190015b19c53216babb33`.
This review binds that exact file. It does not incorporate a later numerical
control, rely on the outcome of an adapted-grid search, or certify a Lean proof.

The project configuration, workflow, policy, and focused current state were
read; state records research in progress and this review's owned path.
Only this review is written. Root owns the author file and shared state.

## 1. Exact integer setting and the displacement equivalence

Let `N>=3` and `m>=1` be integers and let `v_1,...,v_m` be distinct positive
integers. Define

```
L = lcm(v_1,...,v_m),   M = max(v_1,...,v_m),   D = N L,
K = {0,...,N-1}^m,
g(k) = sum_i k_i/(N v_i).
```

Positivity gives positive integers L, M, and D. For every k, `D g(k)` is
an integer, because `L/v_i` is an integer for every i. Hence each old phase
has a unique representative

`fract(v_i g(k)) = r_i/D`, with `r_i` an integer and `0<=r_i<D`.

Fix **any** `0<tau<1/(D M)`. For every i the phase increment `e_i=v_i tau`
satisfies `0<e_i<1/D`. In particular,

`0 <= r_i/D < r_i/D+e_i < (r_i+1)/D <= 1`.

The last inequality is non-strict only before the preceding strict
comparison, so the moved phase is strictly below 1 even when `r_i=D-1`.
There is no wrap. The three exhaustive cases are:

* If `r_i<L`, then `r_i<=L-1`, and the moved phase is strictly less than
  `L/D=1/N`. It is bad.
* If `L<=r_i<D-L`, then `r_i<=D-L-1`. The moved phase is strictly greater
  than `L/D` and strictly less than `(D-L)/D`. It is good.
* If `r_i>=D-L`, the positive increment puts the moved phase strictly above
  `(D-L)/D=1-1/N`, while it remains below 1. It is bad.

Thus, coordinatewise and simultaneously,

```
all i: ||v_i(g(k)+tau)|| >= 1/N
    iff
all i: L <= r_i < D-L.                              (R1)
```

The right side is exactly the author's forward-good predicate
`fract(v_i g(k)) in [1/N,1-1/N)` for every i. Both occurrences of
strictness matter: `tau>0` rejects an old upper-face phase, and
`tau<1/(D M)` prevents an old bad phase from reaching a lower face or
wrapping back toward a good band. The lower old face is included, and the
upper old face is excluded. The resulting moved good phases are actually
interior; the author correctly states the weaker closed conclusion.

This also proves the claimed right-interval interpretation. A forward-good
assignment stays closed-good for every displacement in the displayed
nontrivial interval, and is itself closed-good at displacement zero.
If it is not forward-good, (R1) makes every sufficiently small positive
displacement fail. It therefore cannot be a closed target witness throughout
an interval immediately to its right, regardless of whether that interval
includes its initial endpoint. Later recovery is not excluded or needed.

The equivalence uses the common integer lattice of the phases and target
endpoints. Arbitrary real speeds do not inherit this particular denominator
argument or its uniform displacement scale. Distinctness is harmless and
matches the intended tuple contract; the proof of (R1) itself uses positivity
and integrality, not distinctness.

## 2. Commensurate insertion and the exact count

Let w be a positive integer with `D|w` and

`w > (N-1) D M/N = (N-1) L M`.                       (R2)

Since `N>=3` and `L>=1`, this implies `w>M`, so appending w preserves
distinctness and positivity. For every k, `w g(k)` is an integer: it is
`(w/D)` times the integer `D g(k)`.

The complete adapted N-grid for the appended tuple has assignments
`(k,ell) in K x {0,...,N-1}` and times

`t(k,ell)=g(k)+ell/(N w)`.

Its new-runner phase is exactly `ell/N` modulo one. For `ell=0` that phase
is zero and fails the positive closed target. For every `1<=ell<=N-1`,
it is in the closed good band, including both `ell=1` and `ell=N-1`.
Moreover, (R2) controls the largest permitted displacement:

`0 < ell/(N w) <= (N-1)/(N w) < 1/(D M)`.

Applying (R1) to every old label gives the exact assignmentwise statement

```
(k,ell) is closed-good for every appended-tuple label
    iff
k is forward-good and 1 <= ell <= N-1.               (R3)
```

Consequently

`#full-good assignments = (N-1) * #old forward-good assignments`.

This identity counts assignments, with their multiplicities. Different
assignments can produce the same time, and their possible collisions have
no bearing on the identity. A zero assignment count is nevertheless
equivalent to absence of good times from the entire finite image of this
particular assignment map.

The explicit specialization `w=D M=N L M` satisfies `D|w`, `w>M`, and
the strict inequality (R2), since `(N-1)/N<1`. No limiting argument or
unquantified choice of a sufficiently large speed is involved.

At `m=N-2`, an old tuple with no forward-good assignment therefore embeds
into an actual tuple of `N-1` distinct positive integer speeds whose entire
ordinary, zero-offset adapted N-grid has no closed `1/N` witness.
Conversely, any old forward-good assignment yields `N-1` full-good
assignments for every w satisfying (R2) and `D|w`.

This establishes the author's necessary implication: a universal claim that
this adapted grid always contains a canonical-margin witness would force
every such old tuple to have a forward-good assignment. Neither that
universal premise nor the forward condition for all old tuples is proved
here. Arbitrary added speeds, translated grids, and independent phase
offsets are not covered by the insertion claim.

## 3. Half-open fiber counts and the boundary case

For a fixed label i and fixed digits other than `k_i`, varying `k_i` gives
the translated circle grid `c+k_i/N`, `0<=k_i<N`. The forward-good band
is half-open and has length `(N-2)/N`. After scaling by N, it corresponds
to a half-open interval of integer length `N-2`. Such an interval contains
exactly `N-2` points of any translate of the integer lattice, including
when an endpoint is itself a lattice point. Since this length is less than
N, reduction modulo N does not identify two counted points.

Every coordinate fiber thus has **exactly two** forward-bad assignments,
for every translation. Each label has exactly `2 N^(m-1)` bad assignments.
This is different from a strict open bad-arc count at a closed target:
the present asymmetric boundary convention must be retained.

For completeness, let `r(k)` be the number of labels for which k is
forward-bad, and define the actual overlap redundancy

`R = sum_(k in K) max(r(k)-1,0)`.

Then

`#forward-good = N^m - 2m N^(m-1) + R`.

The ordinary zero assignment has phase zero for all m labels, so it
contributes `m-1` to R. All other contributions are nonnegative. Therefore

`#forward-good >= (N-2m) N^(m-1) + m-1`.              (R4)

If `2m<N`, the first term is positive and the second is nonnegative.
If `2m=N`, then `N>=3` forces `m>=2`, and `m-1>0`. Hence the asserted
positive supply for `2m<=N` is valid, including its density boundary.
For `m=1`, the lower bound is exactly `N-2>=1`.

The counting proof remains valid for positive real speeds with ordinary
phases, because each own-coordinate step still advances its own phase by
`1/N`, and the zero assignment is still a common zero. It uses no common
integer denominator. With independent phase shifts, the exact fiber count
survives, but the common-zero overlap need not; the author correctly keeps
that distinction. There is no assumed independence of the bad events.

Substituting `m=N-2` gives `2m<=N` exactly when `N<=4`. For `N>=5`, the
displayed lower bound becomes

`(4-N) N^(N-3) + N-3 < 0`,

since `(N-4) N^(N-3) >= N > N-3`. Thus (R4) supplies no positive bound
in the unresolved range, although it of course remains a valid lower
bound. The references to N=3 and N=4 are boundary controls for this one
uniform argument, not a sequence of runner-count proof milestones.

## 4. Settled exact predicate for a later bounded control

No program was run in this review. If root separately authorizes a bounded
control, the following integer formulation implements the reviewed contract
without floating-point phases or an endpoint tolerance.

For each old assignment, compute

```
A(k) = sum_i k_i * (L/v_i),
r_i(k) = (v_i * A(k)) mod D, with 0 <= r_i(k) < D.
```

Because `g(k)=A(k)/D`, the forward test is precisely

`all i: L <= r_i(k) < (N-1)L`.

An old-tuple failure certificate must exhaust all `N^m` assignments, or
provide another complete exact certificate of their coverage. Testing a
subset, reporting a small numerical margin, or merely missing a supplied
witness time does not certify failure. A positive control needs an exact
successful assignment but proves only that tuple or the explicitly checked
domain. Assignment counts must not silently become distinct-time counts.

On a certified old failure, construct `w=D M`; (R3) already proves full-grid
failure for the appended tuple. If an independent direct replay is desired,
write `E=N w` and

`B(k,ell)=(N w/D) A(k)+ell=(w/L) A(k)+ell`.

All displayed coefficients are integers. The appended time is `B/E` and
its closed-good test for every speed u in the appended tuple is exactly

`w <= (u B mod E) <= (N-1) w`.

Here both inequalities are non-strict. In particular the new speed gives
residue `w ell`, since `N|(w/L)` and `0<=ell<N`. This is an independent
integer expression of the already accepted endpoint behavior, not a new
search or a demand to enumerate the larger appended grid.

A failure would refute this finite candidate family. It would not imply
that no all-real LRC witness exists. A separate explicit full witness is a
useful control for any numerical example; it is not part of the finite-grid
failure equivalence itself. No such negative example is claimed here.

## 5. Verification and recommendation

The complete source was independently checked by hand: integer hypotheses,
the no-wrap inequality, both phase endpoints, strict displacement at
`ell=N-1`, the explicit w, finite assignment multiplicities, translated
half-open counts, and the common-origin overlap. No defect or required
correction was found. The exact integer predicate above is settled for a
separately bounded mechanical control. There is no reason to implement a
general forward-supply theorem or begin Lean work from this equivalence alone.

The source hash was read back with `sha256sum`. The required command
`python3 scripts/validate_workflow.py` exited 0 with complete output:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

No numerical program, mathematical search, literature assertion, Lean check,
Git operation, cache mutation, delegation, or shared-state edit was performed.
The read-only workflow validator and file/hash inspection are administrative
checks, separate from the manuscript proof. Only this review file was written.
Per-task elapsed time, model token usage, and independently observed runtime
model metadata are unmeasured and remain null. No owned process remains;
this task needs neither `.lake` nor dependency sources.
