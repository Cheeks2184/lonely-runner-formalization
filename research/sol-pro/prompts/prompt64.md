# Prompt 64: PRO-B exact large-ratio top-two implication

Start a **new GPT-5.6 Sol conversation with Pro effort**. This is a narrowly
scoped PRO-B research cell. Attack only the first missing project-level edge
identified by the Response 62 verification and residual-spec audits. Do not
resume the owner-aware multi-shift transversal, DPLP, height compression,
coefficient two, or a broad all-pivot search in this turn.

Unrestricted Lonely Runner remains open. Preserve the labels `proved-lean`,
`proved-math`, `computed finite evidence`, `conditional`, `conjectural`,
`rejected`, and `open`. A finite sweep, a plausible pseudo-Lean declaration,
or a response self-label does not promote a claim.

## Canonical definitions

Let `n>=2`, put `N=n+1`, and let

```text
speeds : Fin n -> Nat
```

be positive and injective. For distinct indices `jA,jB`, put

```text
A = speeds jA,
B = speeds jB.
```

Use the following explicit top-two predicate:

```text
TopTwo(speeds,jA,jB) :<->
  jA != jB
  and A < B
  and for every i != jB, speeds i <= A.
```

Injectivity then makes `jB` the unique largest index and `jA` the unique
second-largest index. Do not assume the input is sorted or replace this with
an indexing convention.

For `P>0`, define

```text
rho_M(x) = min(x mod M, M - (x mod M)),
C(P) = { r : Nat | r < N*P and N does not divide r }.
```

A complete canonical certificate at pivot index `j` with `P=speeds j` is

```text
TopCert(speeds,j) :<->
  exists r : Nat,
    r < N*P
    and N does not divide r
    and for every i : Fin n, P <= rho_(N*P)(r*speeds i).
```

Strict badness is `<P`; safety includes equality. The pivot-coordinate
inequality is automatic for `r in C(P)`, but it must remain in the theorem
statement or be removed only by invoking the audited pivot-coordinate lemma.

## Single primary unresolved lemma

Prove or refute exactly this theorem:

```text
TOP-TWO-LARGE-RATIO-EXCLUSION:
For every n>=2, N=n+1, positive injective speeds : Fin n -> Nat,
and jA,jB satisfying TopTwo(speeds,jA,jB),

  N*A < 2*B
    -> TopCert(speeds,jA) or TopCert(speeds,jB).
```

The exactly equivalent contrapositive is

```text
not TopCert(speeds,jA)
and not TopCert(speeds,jB)
  -> 2*B <= N*A.
```

All inequalities are natural-number inequalities; equality `2*B=N*A`
belongs to the residual side. State and justify the equivalence rather than
switching silently between strict and non-strict forms.

This is the sole research lemma for Prompt 64. Do not rename the conclusion
as a "large-gap lemma" and count that as progress. Do not assume
`2*B<=N*A`, the absence of a full witness, the existence of lower-dimensional
witnesses, primitivity, minimal-counterexample status, a saturated lower
interval, coprimality conditions, or nonempty robust grids. Those are not
hypotheses of the target.

If the exact theorem is false, return the smallest exact counterexample under
your declared deterministic order. You may then state a repaired theorem,
but every added hypothesis must be explicit, independently motivated, and
traced to a currently available project premise. A repaired theorem does not
close the audited edge unless its hypotheses are supplied by the chain below.

## Classification

`TOP-TWO-LARGE-RATIO-EXCLUSION` is **unbounded and dimension-uniform**: it
quantifies over every `n>=2` and arbitrary positive integer heights. It is a
ratio-branch top-two theorem, not a bounded-height theorem, not a finite
classification, and not unrestricted LRC by itself.

The Response 62 hard pair `(N,A,B)=(7,98,187)` satisfies
`2*B<=N*A`, so its 14-shift certificate is downstream residual evidence and
cannot prove or test this large-ratio implication.

## Exact project implication chain

The reason this theorem is first is the following contradiction chain. Every
premise and open arrow must remain visible.

```text
hypothetical least bad positive-integer dimension n
  -> divide by the common gcd and choose explicit numerical top indices
     jA,jB
  -> no full witness implies no canonical certificate at either top pivot
     (by the proved-Lean pivot-certificate-to-witness bridge)
  -> TOP-TWO-LARGE-RATIO-EXCLUSION
  -> 2*B <= N*A
  -> lower-dimensional LRC supplies a witness for the tuple deleting B;
     explicit reindexing plus FastRunnerInsertion contraposition gives B<n*A
  -> no-full-witness plus divisor_cover_of_no_small_witness, positivity,
     top-two ordering, and B<2*q gives:
       for every q with 1<=q<=N and B<2*q, some speed equals q
  -> the complete Response 62 Residual predicate is assembled
  -> RESIDUAL-2N-SHIFT-OWNER-TRANSVERSAL
     [still conjectural/open; not a Prompt 64 input or target]
  -> TOP-TWO-INTEGRAL-TRANSVERSAL
  -> a canonical certificate at A or B
  -> full closed 1/N witness, contradiction
  -> PositiveIntegerPivotCertificateConjecture
  -> proved-Lean PositiveIntegerConjecture equivalence
  -> verified endpoint-safe real reduction
  -> unrestricted LRC.
```

Prompt 64 is successful if it proves the exact first missing inequality edge,
even though the named owner-transversal arrow remains open downstream. It
must not report that proving the present lemma alone proves top-two or LRC.

The neighboring residual steps are not free assumptions:

- `B<n*A` needs an actual witness for the deleted, explicitly reindexed lower
  family before `FastRunnerInsertion` can be used.
- The terminal interval needs the explicit no-full-witness premise before
  `divisor_cover_of_no_small_witness` can be used, plus positivity and
  top-two ordering to turn divisibility into equality.
- Primitive normalization is homogeneous bookkeeping; it does not imply the
  target inequality.

## Existing inputs at exact strength

- Canonical pivot candidates, strict bad sets, the pivot-coordinate lemma,
  and the certificate-to-real-witness bridge are `proved-lean`.
- The fastest-pivot ratio certificate and exact extremal-interval compression
  dichotomy are `proved-lean` at their stated positivity, lower-bound,
  upper-bound, and no-fastest-certificate hypotheses.
- Exact single bad-set cardinalities and pair/triple generalized-CRT
  intersections are `proved-lean`.
- Affine common-LCM fiber identities and quotient lifts are audited
  `proved-math` only.
- The Response 62 replay verified 8,108 finite rows with no two-top-grid
  cover. This is `computed finite evidence` only and most rows are outside
  the strict large-ratio branch.

## Known obstructions and forbidden shortcuts

- `FastRunnerInsertion` supports the different comparison `B<n*A` only after
  a deleted-family witness is supplied. It does not yield `2*B<=N*A`.
- Fastest-pivot interval compression controls the `B` grid through a selected
  positive lower speed and an upper bound on all nonfastest speeds. Its
  empty-or-divisible-singleton alternative does not by itself produce an
  `A`-grid certificate.
- At `(N,A,B)=(4,2,8)`, the `A`-robust grid is empty, but speeds `(1,2,8)`
  have the valid `B`-pivot numerator `9`. Thus one-sided robust nonemptiness
  and unconditional paired-transversal claims are false; a proof must retain
  the disjunction between the two top pivots.
- Coarse divisibility flags do not determine which top pivot succeeds.
- The fractional two-grid dual fails at `(7,98,187)` despite an integral
  top-two certificate. Fractional mass is not an integer numerator.
- Fixed scalar moment, one-shift union, quotient-slice dual, random/additive,
  GCD-clock, anchor-star, TOP-CYCLE, and CHAIN3 criteria already have exact
  failures. Do not recycle them without resolving their recorded
  counterexamples.
- A proof by contradiction may assume the negation of both `TopCert`
  conclusions. It may not assume the desired `2*B<=N*A`, a full residual
  predicate containing that inequality, or unrestricted LRC.

## Mandatory falsification program

Before promoting any proof idea:

1. Exhaust a declared primitive box restricted to `N*A<2*B`; for every row,
   enumerate every canonical numerator on both top grids with a literal
   implementation and an independently structured optimized implementation.
2. Test `n=2`, `N*A+1=2*B` when arithmetically possible, the boundary
   `N*A=2*B`, `B` just above the boundary, very large `B/A`, common scaling,
   nonprimitive tuples, and all explicit top-index reindexings.
3. Include structured CRT, large-gap, sparse-lower, near-saturated,
   divisibility, affine-residue, and deletion mutations in the strict branch.
4. Recheck `(1,2,8)` and any one-sided-empty robust-grid row to ensure the
   surviving top-pivot disjunction is not discarded.
5. Evaluate every proposed inequality literally on its equality cases and on
   all previously tracked RF, GCD-clock, OPT-ADD, anchor-star, TOP-CYCLE,
   CHAIN3, and consecutive-family stresses that enter `N*A<2*B`.

An exact falsifier must contain:

```text
positive injective speeds, explicit jA,jB and TopTwo verification,
N*A < 2*B,
and, for every canonical numerator on each top grid,
an explicit strict-bad spoiler index and cyclic distance.
```

Such a tuple refutes only this large-ratio top-two theorem (and, because both
top grids are covered, refutes TOP-TWO-PIVOT). It does not refute the
all-pivot certificate or LRC unless every pivot grid is independently covered.

## Stop condition and maximum budget

Maximum budget:

- one major Sol Pro turn;
- one targeted complete strict-large-ratio sweep with finite bounds declared
  before results are inspected;
- at most one Lean prototype, only for the exact theorem or a strictly
  narrower surviving arithmetic lemma that genuinely implies it.

Stop immediately if an exact two-top-grid cover in `N*A<2*B` is found. If no
counterexample is found but the argument ends at a fractional relaxation,
the extremal-interval dichotomy, a reformulation of two-grid noncoverage, or
an added hypothesis not supplied by the project chain, mark the theorem
`open` and freeze this large-ratio route at the turn cap. Do not spend the
turn on larger bounds or switch to the downstream owner-transversal.

Continue beyond this turn only if the exact theorem is proved, refuted, or
the first unsupported implication is replaced by a strictly narrower lemma
whose implication to `TOP-TWO-LARGE-RATIO-EXCLUSION` is fully proved.

## Required output format

Return, in this order:

1. an exact status table distinguishing project inputs, new results, finite
   evidence, rejected ideas, and open claims;
2. the fully quantified target theorem, its contrapositive, and a proof of
   their equivalence in natural arithmetic;
3. at least two materially different attacks before selecting one, with an
   obligation ledger for each;
4. complete proofs of every new `proved-math` claim, with no omitted
   quantifier, endpoint, divisibility, or reindexing step;
5. the mandatory falsification results and literal certificates for every
   rejected strengthening;
6. for computation: deterministic domain and order, version, exact commands,
   case count, runtime, source/output SHA-256, and literal/optimized agreement;
7. the single first unsupported implication remaining after the turn;
8. at most one repository-compatible Lean 4.32.1 declaration, labeled only
   as proposed until independently compiled and audited;
9. the complete implication chain above, annotated to show exactly which
   arrows are proved, conditional, or still open;
10. a `PROVE`, `REFUTE`, or `STOP/OPEN` decision for this exact lemma, and a
    separate statement that the downstream owner-transversal and unrestricted
    LRC remain open unless independently closed.

Do not silently strengthen hypotheses, assume the target, or present a
weaker special class as closing the audited project-level edge.

## Lifecycle state

This prompt is **completed/recovered at STOP/OPEN** under sole owner
`GPT-5.6 Sol High top-level desktop orchestrator`, supervising authority
`/root`, and launch runtime `original browser-capable desktop Codex session`.
After Prompt66 completed/recovered at STOP/OPEN, `/root` selected
`TOP-TWO-LARGE-RATIO-EXCLUSION` as the closest Bridge-B thin API and launched
this exact tracked prompt at 2026-08-03 15:24:40 CDT. Direct UI readback showed
Chat true, Work false, `GPT-5.6 Sol` true, `Pro` true, and `Stop answering`
true. Tracked prompt SHA-256 is
`8d76932982c27de5477cead9b081520651f757aae75e14f9e1f4d2826475d20b`;
exact UI payload/readback SHA-256 is
`cb7adeaa3b7ad1a2aea3c63b91e86a180b83e6ef8343cc5432639e504d9d8555`.
No URL or session ID is recorded. The normalized recovered response has
41,788 bytes, 1,367 LF separators with trailing LF, and SHA-256
`f273ee340066c42dc4f3cb8224e35b4df028ebdd47b4dda1bb4879f515f5698d`.
Three canonical attachments are recovered and independently audited.
`FORM-P64-RESPONSE-MATH-AUDIT-081` gives qualified manuscript ACCEPT;
`FORM-P64-SCALING-EDGE-083` corrects the response's literal `r<M<dM` to
`r<M<=dM`; and `VER-P64-COMPUTE-REPLAY-082` accepts the declared sweeps only
as computed finite evidence. The response remains canonical and unchanged.
The target, owner-transversal, exact pivot selector, and unrestricted LRC
remain open, with no new Lean theorem. This route is frozen under its stop
contract.
