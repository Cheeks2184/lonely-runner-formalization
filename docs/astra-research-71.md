# Pass 71: integer-mask method limits and return to direct induction

The exact ideal-mask formulation has not yielded either a uniform exclusion
or a verified integer cover. This checkpoint preserves two independently
reviewed method limits and the outcome of one fixed integer-feasibility test.
The two-digit route is deprioritized until a new integral mechanism is supplied;
this is a branch decision, not a blocker or completion of the LRC goal.

## What the carry audit establishes

At a rational slope wall a/q, every regular row divisible by q changes
simultaneously. The bad pair on one side departs, another arrives, and both
are good at the wall itself. The exceptional row has its own exact contact
cases. Periodic adjacent cells are used at the endpoints 0 and N. With the
other slopes fixed, a full cover survives a move exactly when every departing
pair already has another bad owner. Actual distinct midpoint-cell examples
show that the covered-pair count can increase or decrease in the same slope
direction. Bare monotonicity therefore supplies no exchange theorem.

The fractional cover of these actual midpoint masks has optimum exactly N/2,
even with each cell variable capped at one. Cell length divided by two
supplies a feasible vector covering each pair with equality; summing regular
rows gives the matching lower bound. It can be padded fractionally to cost
N-2. Thus no nonnegative additive pair weighting can rule out N-2 distinct
cells, even when it uses the sum of the best N-2 distinct-cell scores.
Distinctness here concerns cell indices, not necessarily different incidence
sets. The result does not rule out overlap-sensitive or other integer arguments.

## The single integer test

The reviewed finite-cell reduction justified one fixed N=11 instance:
353 cuts, 352 midpoint cells, 100 row-column pairs, and a budget of at most
nine distinct cells. Terra High generated exact Fraction masks and invoked
Z3 once with a 60,000 ms limit and seed zero. The result was `unknown`, with
solver statistics reporting 60.0 seconds and one check. There was no SAT
certificate, UNSAT result, second solve or expanded domain.

The receipt retains all masks, the exact executed source and its hash, the
actual invocation and environment, observed terminal completion with exit
zero and empty combined output, and the solver statistics. Source-emitted
stdout/stderr/exit fields are explicitly distinguished from the external
terminal observation. The latter did not expose a separate stderr stream.
No absence-of-cover conclusion follows from this timeout.

The SAT branch was unexercised. Its nine-slot reporting list would have
used `None` placeholders rather than adding actual extra distinct cells.
That limitation is disclosed without rewriting the executed source. No
witness, padding validation or independent witness recomputation ran.

The temporary official PyPI wheel was `z3_solver-5.1.0.0` for Linux x86_64,
with download bytes checked against its published SHA-256. The engine reports
version 5.1.0. The task-specific extracted library, wheel and temporary metadata
were removed after execution; root verified the dependency directory is absent.
The small evidence needed to reproduce and interpret the attempt is retained.

Root requested one metadata correction: successful execution of the bounded
check is distinct from finding SAT, and measured program time is distinct from
total worker time. The final delivery metrics record first-check success,
zero executable repair rounds, one Astra clarification, zero direct Astra
code lines, and unknown total worker time and usage. The measured program
duration remains in execution timings. There are now 24 closed Terra High
deliveries; the next aggregate review remains at 30.

## Research direction and verification

The next bounded Astra investigation returns to the all-deletion protected-seed
mechanism under a hypothetical counterexample minimal in moving count and then
speed sum. Count minimality supplies every deletion's strong seeds. The proposed
argument must use the maximum score over all labels and all such seeds, or
combine it with the existing fixed-endpoint descent invariant. Failed local
relabel rules, raw Euclidean witness reuse and endpoint-insensitive length
accounting are not sufficient substitutes. This new task remains unaccepted
work in progress and is excluded from this checkpoint.

The carry manuscript received independent Astra hand review and root full
review. Root read the exact solver source and corrected receipt, without
repeating the unchanged solver or mask computation. Final source/dependency
bindings and workflow, whitespace and storage checks are retained in
`research/astra-pass71-verification.json`. No Lean source or dependency build
changed. The canonical N=6 milestone remains intact; unrestricted LRC remains
unresolved. Required CI and exact-head merge verification govern publication.
