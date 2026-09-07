# After the energy route: assessment and one cover-selection check

Task `/root/uniform_strategy_after_energy`; requested `gpt-6-astra/xhigh`.
Observed model, effort, elapsed time and usage: `null`. Assignment checkpoint:
`55df0b86d08964d2927000435006ac14a53c51a3`. Only this manuscript is owned.
Status: bounded assessment and new exact hand countercheck, awaiting review.

**Disposition: shelve the all-threshold energy inequality as the active
research target.** No new sharp ingredient overcoming the recorded obstacles
was derived. One actual-cover selection attempt was examined below. Its
essentiality-only version is false, and no version using strict failure
essentially was established. Do not promote that attempted replacement to
a proved mechanism or an active stronger shortcut. This is a bounded branch
stop; the unrestricted proof/disproof goal remains unresolved.

## What the energy evidence justifies

For n moving speeds, put `alpha=1/(n+1)`. The proposed inequality remains

    (alpha-a)H(a) <= (n+1)I(a),   every 0<a<alpha.            (E)

The accepted derivative and local homothety show that (E) would imply LRC.
No converse is known here. Its quantifiers also concern good tuples and
thresholds strictly below their actual maxima, where the bad sets do not
cover. This is more than the actual-cover contradiction needed for LRC.

The recorded obstacles have distinct, limited scopes:

* Exact odd-support blocks can have negative defects even at positive
  thresholds. Termwise nonnegativity cannot close the full sum.
* At fixed n and fixed a, actual rational chambers can form arbitrarily
  long runs of negative defects whose aggregate stays bounded away from
  zero. A bound on pairing distance in chamber index cannot close the sum.
* The frozen cyclic author reports that its coarse induction budget fails
  for `(1,2,3,4)` despite a positive full defect: discarding the actual
  lower-count reserve loses the necessary cancellation. Its independent
  review was running separately at assignment; this assessment does not
  duplicate or certify that audit.

None of these refutes (E). Their combination also does not prove that every
possible energy method fails. The reason to stop pursuing (E) now is narrower:
there is no derived sharp comparison to serve as the next proof step.
Requiring the remaining full compensation sum to be nonnegative would merely
rename (E). The decision does not depend on promoting the pending cyclic
review: the previously reviewed obstacles and absence of a replacement
ingredient already warrant it.

The earlier phase calculations do not fill that gap. Full normalized products
preserve phase averages, but their actual coefficients replace the simple
dissociated weights. The first-order signal bound and the fixed density
family's failure to detect every subthreshold hole do not exclude all
actual-cover arguments; they also provide no sharp one. The prior deletion
seed radius proposal was inspected to avoid presenting its already recorded
open supply obligation as a new ingredient. No earlier computation was rerun.

## One attempted route using an actual hypothetical failure

Assume there exists a positive distinct primitive integer tuple
`v=(v_1,...,v_n)`, with `n>=2`, whose actual maximum satisfies

    mu=max_t min_i ||v_i t|| < alpha.

Choose one with least moving count n, then least sum of speeds among failures
at that count. Count minimality supplies, for every label i, a time s_i with

    ||v_j s_i|| >= beta=1/n   for every j!=i.                (1)

If a deletion tuple has a common divisor, divide it out and rescale time;
this preserves ordinary margins. Height minimality is retained as a hypothesis
but supplies no further step in this attempt. There is no assumption that
changing the distinguished runner preserves a failure.

Select a width `delta` with `mu<delta<alpha`. This is not an arbitrary energy
threshold: strict failure guarantees that the **open** bad sets at this width
cover the entire original time circle. Write their individual arcs as

    A_(i,k)={t mod 1: dist_T(t,k/v_i)<delta/v_i},
    0<=k<v_i.

Every arc has length `2delta/v_i`. At the seed s_i in (1), no other label
is bad, since `beta>delta`; hence at least one arc of label i is indispensable
to covering that point. Every subcover must retain each label. This is an
elementary consequence of full failure and count minimality, not a new
uniform witness theorem.

The concrete proposed structural step was to select a subcover S with

    C(S)=sum_((i,k) in S) 1/v_i <= (n+1)/2.                 (S)

If such a selection followed from justified structural information, its
total length would be

    sum_(S) |A_(i,k)|=2delta C(S) <= delta(n+1)<1,

contradicting its being a cover. Thus (S) specifies a checkable selection
claim, but supplies no progress by itself: under strict failure it asks
for a subcover of impossible total length. A new structural selection
theorem is essential. The following check shows that label essentiality
and all own-margin deletion seeds alone do not give it.

## Exact failure of the essentiality-only selection step

Take `n=3`, `v=(1,2,3)`, and

    1/4 < delta < 1/3.                                    (2)

All arcs in this section remain OPEN. The complete family has six arcs.
The two centered at zero from speeds 2 and 3 lie inside the speed-one arc.
The following four arcs are each forced in every subcover:

| Arc center | Speed | A point covered by this arc alone |
| --- | --- | --- |
| 0 | 1 | `1/6` |
| `1/3` | 3 | `1/3` |
| `1/2` | 2 | `1/2` |
| `2/3` | 3 | `2/3` |

At `1/6`, the three norms are `(1/6,1/3,1/2)`. At the other three points,
the indicated speed has norm zero while both other norms are at least
`1/3`. This proves indispensability throughout (2), with strict inequalities
in the required directions.

These same four arcs form a cover. In their cyclic order, the successive
center gaps are `1/3,1/6,1/6,1/3`. Their sums of radii are respectively
`4delta/3,5delta/6,5delta/6,4delta/3`, each strictly larger than the gap
under (2). Thus there are no uncovered endpoints. Consequently the exact
minimum cost of a subcover of the original arc family is

    min_S C(S)=1+1/3+1/2+1/3=13/6 > 2=(n+1)/2.            (3)

The tuple is positive, distinct, primitive, and has the smallest possible
sum of three positive distinct speeds. All deletion margins in (1) are
verified by actual times: use `1/5` for `(2,3)`, `1/2` for `(1,3)`, and
`1/3` for `(1,2)`. Their respective minimum norms are `2/5`, `1/2`, `1/3`.
Thus the failure of the selection bound cannot be attributed to absent
own-margin witnesses, repeated velocities, or independently assigned phases.

Its actual full maximum, however, is `mu=1/4=alpha`. For the upper bound,
reflection reduces to `[0,1/2]`: speed 1 bounds `[0,1/4]`, speed 3 bounds
`[1/4,5/12]`, and speed 2 bounds `[5/12,1/2]` by `1/4`. Time `1/4` attains
the minimum `1/4`. At `delta=1/4` the OPEN arcs leave maximizing times
uncovered, so that endpoint is deliberately excluded from (2).

This is a counterexample to (S) under actual open coverage, label
essentiality and all the displayed deletion margins. It is not a
counterexample satisfying `mu<alpha` or the complete minimal-failure
profile. No example with those failure hypotheses was found or claimed.
In particular, the positive-height statement above must not be confused
with height minimality *among failures*.

## Stop and first unresolved implication

The inexpensive-subcover shortcut is false at the tested structural scope.
Restricting it to a hypothetical strict failure does not turn it into a new
proved ingredient; the strict subcritical information would have to do
essential additional work. No such selection theorem was derived. Replacing
the selection cost by total cost minus exact overlap would only re-express
the cover measure, and is not proposed as progress.

Accordingly, (E) should be shelved as the active target, and this attempted
replacement also stops. The precise outstanding mathematical requirement
is an implication using an actual subcritical cover and justified minimality
to obtain information inconsistent with that cover. This task supplies an
exact falsifier to one stronger shortcut, not that missing implication.
No surviving sharp positive ingredient, full proof or disproof, or narrower
formalization is delivered.

## Sources and checks

The cyclic author was read completely at its frozen hash, without duplicating
its separate review. Prior energy and phase results were retained at their
existing scope, with hashes checked; the two older seed/profile manuscripts
below were read to check overlap with existing approaches.

| Mathematical input | SHA-256 |
| --- | --- |
| `research/astra-cyclic-global-compensation.md` | `06b3eabe5f9b8031801faa9d8f6aedd5a7d43f048bbd90656b0804943f8b3088` |
| `research/astra-uniform-strategy-after-fold.md` | `e569596af4ebab9f9d5e1c796d8da435bc433c1c238bc10f9901e644f9f49871` |
| `research/astra-slack-energy-review.md` | `1c526b214e7772088555642447d5fa2f93030f40195fd4aaca7a79bb1f6bd573` |
| `research/astra-slack-energy-global-compensation.md` | `8032d020e4beccc1112b025c8b85f6be6c2ec5cb67cdd763d4ae62a029627cb9` |
| `research/astra-slack-energy-global-review.md` | `c6416983efcbeeb909449a372be2ff316647f0ab6d92ba4d199429bd35e75e79` |
| `research/astra-rational-cell-compensation.md` | `3304bb071092c71e6516b5c1e16b0d47d918f1c21042f7c47592865d2ac10076` |
| `research/astra-rational-cell-review.md` | `d6f17b4cb2188aa2b552fa30ac7643822dadf45c50dec63479737cc58decf62d` |
| `research/astra-phase-riesz-global-contract.md` | `66c83f09a66f169ef9e212d5e5d4ca32acc2fa3732c94def184d4015061ef848` |
| `research/astra-normalized-phase-signal.md` | `55f23f7eaed77263ef713783ef4d3083fd444f6b1c4f3ea398974afd81ef3a4e` |
| `research/astra-uniform-all-deletion-seed-screen.md` | `b2b6acd00dae3c8ed777bc3da4227fab0254016eec035c2c100f8d346a398f1b` |
| `research/astra-uniform-label-cut-profile.md` | `05b89f854f5076ffcfb139a19ea34a8ed6d9481c893211560aa443881bc89326` |

Current setup sources and focused state were read. The state was
`research/in_progress`, with explicit 2026-09-05 start authorization and this
task recorded. Unchanged setup hashes were checked:

| Setup input | SHA-256 |
| --- | --- |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

`python3 -B scripts/validate_workflow.py` exited zero with
`workflow structural validation passed; it cannot certify mathematical validity.`
The new check uses exact hand geometry only. No mathematical program, repeated
finite control, build, cache operation, Git operation, shared-state edit,
additional agent, external model, external source retrieval or memory write
was used. Only this manuscript changed. New claims await independent review.
