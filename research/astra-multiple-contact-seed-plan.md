# One structurally motivated control for the uniform seed question

The all-deletion question Q concerns arbitrary N, not a new finite-runner
theorem. This plan gives one fixed control prompted by a specific obstruction.
No range or random search is authorized by this task.

At a full witness t with delta=1/N, suppose at least two distinct speeds have
actual fractional phase delta and at least two other speeds have actual phase
1-delta. All velocities are positive. After deleting any one label, at least
one of each kind remains. In a sufficiently small interval, the former blocks
the left side of t and the latter blocks the right side. Thus t is an isolated
point of that deletion's weak good set. A protected ball about a strong seed
has positive radius and is entirely weak-good, so it cannot contain t.
Consequently, if EVERY full witness has this contact pattern, none is reachable
by any protected seed ball. With all deletion strong sets nonempty this would
refute Q while still allowing actual full witnesses. This is a proposed
uniform obstruction argument, not yet an independently reviewed theorem.

Duplicating the unit residues modulo 12 suggests the ONE input

    v = (1,5,7,8,10,11,13,17,18,19,23),       N=12.

The eight unit speeds are 1,5,7,11 and their translates by 12. At each primitive
grid point a/12 there are two contacts in each direction. The remaining speeds
8,10,18 cover the nonunit small denominators; every q=2,...,11 divides some
speed. This rules out the trivial all-strong witness t=1/q from a missing small
denominator, but does not imply that all full witnesses are on this grid.
Other full components may invalidate the proposed obstruction, which is the
purpose of this control.

Terra High owns ONLY `research/astra-multiple-contact-seed-control.json`.
Read the previously reviewed exact checker in
`research/astra-uniform-all-deletion-seed-screen.md`, SHA256
`b2b6acd00dae3c8ed777bc3da4227fab0254016eec035c2c100f8d346a398f1b`.
Extract its definition prefix before the literal newline followed by
`v=(1,4,5,6,7,11)` (prefix SHA256
`470ad7aa7f0e6ab12ca65e404493b150f0d471ce684ac1bb87b9b2fb96128d48`).
Use that exact prefix in a fresh namespace, plus a frozen reporting driver:

* Check all eleven labels using audit(v,p,True); retain all exact seed
  intervals, score maxima and attaining times, weak seeded components, whole
  component maxima and protected-ball unions. Report all-S-nonempty separately
  from existence of a score >=1/12. Do not stop at the first positive pivot.
* Compute bands(v,1/12), retaining the entire exact full good set over [0,1].
  Report singleton versus positive-length component counts. For every singleton
  record the exact indices whose actual phases are 1/12 and 11/12. Determine
  whether every full witness is a singleton with at least two contacts of each
  sign. Preserve any positive-length component as the precise failure of that
  intended pattern. If the full set is empty, flag it for independent review;
  do not announce a conjecture counterexample.
* Check and retain the divisibility cover for q=2,...,11 and the contact
  patterns at a/12 for a=1,5,7,11. If Q is positive, construct and directly
  verify one full witness inside its selected protected ball, as in the
  preceding twelve-input plan. If negative, retain every label for Astra review.

Use exact integers/Fractions and the reviewed closed interval reduction. No
external source, Lean build, cache restoration, edits outside the owned receipt,
Git operation, shared-state edit, or second input. Bound the command to 60s
wall, 59s CPU, 512MiB address space. Freeze the COMPLETE actual child driver,
parent harness and real command/argv before execution; retain their bytes,
source and input hashes, complete stdout/stderr, exit status and failure
history. Avoid the earlier placeholder-command receipt error. Initial check
plus at most two mechanical repairs; semantic ambiguity goes to Astra at once.
Record first-check success, worker repairs, Astra guidance/direct lines, and
measured command duration separately from unknown total task time/token usage.
