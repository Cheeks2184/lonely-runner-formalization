# Independent review of seed coupling and multiple contacts

Date: 2026-09-06. Task `/root/uniform_seed_coupling_review`, executed by
`/root/uniform_screen_review`; requested Astra/xhigh. The reviewer did not
author either mathematical input. Runtime model/effort and token usage are
not independently exposed. Only this review file is owned; other reviews,
shared state, Git and caches are unchanged.

**Accepted at manuscript scope.** The endpoint-owner monotonicity theorem,
its precisely restricted no-cycle corollary, both local relabelling
obstructions, and the conditional multiple-contact lemma are valid. Neither
the local counterexamples nor the proposed N12 construction refutes Q.
There is no blocking mathematical finding under the stated hypotheses.

## Frozen inputs and method

| Input | SHA-256 |
| --- | --- |
| `research/astra-uniform-seed-coupling.md` | `b52f92b8dca3de5b0ba9f41c24c2dc6bd83a27329a035d40a1273a0401f215ea` |
| `research/astra-multiple-contact-seed-plan.md` | `25b9b2010b944694de40757e79dee14ba37a8d4edc9440793b80ee9e8eeff7a5` |
| `research/astra-multiple-contact-seed-control.json` | `adcfb74938b39dc6264ad78ee622860102d08e461487a114347224de910480c0` |
| `research/astra-uniform-all-deletion-seed-screen.md` | `b2b6acd00dae3c8ed777bc3da4227fab0254016eec035c2c100f8d346a398f1b` |
| `research/astra-uniform-seed-screen-review.md` | `11f738862f1302dda62e2f0fcd7c8cdff0b3dad9462297b79cd1769371c70522` |

The complete coupling report, its retained exact control script/command/output,
and the multiple-contact plan's mathematical argument were read. The bound
N12 receipt was inspected for its retained component summary and explicit
witness. Current config/workflow/policy and focused state were read; startup
`python3 -B scripts/validate_workflow.py` exited 0.

This is an independent algebraic review. The retained tiny control was not
replayed, because its rational assertions can be checked directly below and
root already holds its exit-0 receipt. Its reported script hash is
`5df812fb3cceb68e6162087ad280ba79913289cd60ab064b01301a008b973bc4`.
No all-real enumeration, enlarged search, Lean command, or cache operation
was run. Root's separate review of the N12 execution driver is not presented
as work repeated by this reviewer.

## Fixed-cell endpoint owners

The count convention is consistent: N total runners, N-1 moving speeds,
and N-2 retained speeds per deletion. For a fixed actual phase cell, decreasing
the margin from gamma to delta expands every band, preserving the supplied
strong seed. Left endpoints are maxima of the affine functions
`(k_i+alpha)/v_i`; right endpoints are minima of `(k_i+1-alpha)/v_i`.

If a is an owner at the larger margin and q an owner on the same side at
the smaller margin, the stated two extremal inequalities give

```text
eta/v_q <= endpoint expansion <= eta/v_a,
eta=gamma-delta>0.
```

Positivity gives `v_q>=v_a`. Every step remains valid when either endpoint
has multiple owners. Distinct velocities turn a change of label into a
strict speed increase. Thus a sequence of strictly decreasing margins has
at most N-3 owner changes on a fixed side, and an owner cannot return after
another owner. Selecting different tied owners repeatedly at one unchanged
margin is outside this corollary.

The comparison is between two endpoint owners, not between an owner and the
deleted speed. Changing the deletion, cell or side loses the common affine
family used in the proof. In particular the lemma does not supply a new
strong deletion seed at an endpoint, nor a potential for arbitrary relabelling.
Its proposed Lean use is appropriate as a finite-family extremum lemma with
explicit active-owner equalities. Formalization would not supply the missing
cross-deletion transition.

## The two local transition obstructions

For the unbounded family, put `m=N-1>=9`. The block `1,...,m-4` and four
labels `m-1,m,m+1,2m-1` are disjoint and give exactly m distinct positive
speeds. With pivot m and seed `s=1/m`, all retained norms are at least
`gamma=1/m`. Speed 1 imposes the strong lower endpoint and speed m-1 the
strong upper endpoint, making the strong component a singleton. The largest
retained speed `2m-1` attains norm gamma; hence its normalized slack is the
minimum `rho=eta/(2m-1)`, and

```text
F_m(s)=1/[(m+1)(2m-1)] < delta.
```

At `s+1/m^2`, speeds m-1 and 2m-1 have respective norms `1/m^2` and
`(m-1)/m^2`; at `s-1/m^2`, speeds 1 and m+1 have those norms in reverse
order. These are two distinct bad retained labels in either direction,
while the pivot norm is exactly gamma. Neither first-entry time is therefore
in any deletion's strong set. The bad inequalities are strict, as required
by the closed strong threshold.

All deletion sets are nevertheless nonempty. At `w=1/(m-3)`, writing
`d=m-3>=6`, the small block has residues `1,...,d-1` and the four other
speeds have residues `2,3,4,5`. Every norm is at least `1/d>gamma`.
This common full gamma witness also proves Q for the family. Therefore the
family refutes first-entry supply from a locally trapped component even when
all seed sets exist; it does not satisfy simultaneous trapping of every
component and cannot refute a theorem using that global premise.

The N6 control also checks exactly. For `(1,4,5,6,9)`, deletion 1 at `a=2/15`
has opposite tight strong constraints from 9 and 6; deletion 5 at `b=1/5`
has lower constraints from 1 and 6 and upper constraints from 4 and 9.
The weak components, symmetric intervals and scores are respectively

```text
p=1: [7/54,5/36],  [7/54,37/270],  37/270 < 1/6;
p=5: [7/36,11/54], [53/270,11/54], 1/54 < 1/6.
```

Both radii are `1/270`. Each whole weak interval is contained in one open
bad interval of its deleted speed, so these are not merely artifacts of
using symmetric intervals. For every `a<t<b`, speeds 1 and 6 are both
strictly gamma-bad. Hence no deletion seed lies in the open gap. Only
deletion 1 is available at a, and only deletion 5 at b.

Both facing weak endpoints are owned by speed 6, while the next deleted
labels across the gap are 5 and 1. The proposed endpoint-owner relabelling
rule is therefore false. The permitted moves right from a and left from b
initially improve their departing pivot norms and give the speed cycle
`1 -> 5 -> 1`. This defeats a strict speed potential for that two-direction
rule. It does not defeat a fixed-orientation rule or a rule that supplies
additional information from global simultaneous trapping.

The first pivot-5 entry times `4/25` and `6/25` have bad label sets `{1,6}`
and `{4,9}`. The common gamma witness `3/10`, with norms
`(3,2,5,2,3)/10`, establishes every deletion's nonemptiness and Q elsewhere.
These direct rational identities agree with the retained author's control.

## Multiple-contact lemma and the failed N12 construction

The local lemma is valid for positive speeds and `0<delta<1/2`. If a full
witness t has at least two distinct lower contacts with fractional phase
delta and two distinct upper contacts with phase `1-delta`, deleting any
one label leaves at least one contact of each kind. A remaining lower
contact is bad immediately to the left of t, and a remaining upper contact
is bad immediately to its right. Taking a sufficiently small neighborhood
before either phase wraps proves that t is isolated in every deletion's
weak-good set. Positivity of velocities supplies the directions.

Every strong seed has strictly positive radius, since its old norms exceed
delta by at least `gamma-delta>0`. Its protected interval is nondegenerate
and entirely weak-good. Such an interval cannot contain an isolated point
of that weak-good set: even an endpoint of a nondegenerate interval has
other interval points arbitrarily close on one side. Thus the isolation
argument excludes protected-ball endpoints as well as their interiors.

Consequently, if **every** full witness has the stated contact pattern,
no protected interval can reach any full witness. Together with nonempty
strong sets for all deletions, that would refute Q. The universal contact
premise does not itself guarantee existence of a full witness; that requires
a separate assumption or explicit witness if the proposed example is to be
known to refute only Q rather than possibly LRC. No claim that all full
witnesses can be classified this way has been proved.

The N12 input fails that global premise. Its frozen receipt reports four
isolated primitive grid witnesses and six positive-length full-good
components. These counts were read from the bound receipt, not independently
reenumerated here. More decisively, its explicit time `45/88` has norm vector

```text
(43,39,37,8,10,33,31,27,18,25,21)/88.
```

Direct modular multiplication verifies these numerators. The minimum is
`8/88=1/11=gamma>delta=1/12`, so this is a full gamma witness, contradicts
the all-witness contact pattern, and proves all strong sets nonempty and Q
immediately. The four grid points with doubled contacts remain valid local
obstructions. Their presence does not imply that all full witnesses have
the same pattern.

## Verification boundaries and remaining gap

Input bindings were checked with the following exact read-only command from
`/home/joshua/lonely-runner-formalization`:

```sh
sha256sum research/astra-uniform-seed-coupling.md research/astra-multiple-contact-seed-plan.md research/astra-multiple-contact-seed-control.json research/astra-uniform-all-deletion-seed-screen.md research/astra-uniform-seed-screen-review.md
```

Exit 0, complete output:

```text
b52f92b8dca3de5b0ba9f41c24c2dc6bd83a27329a035d40a1273a0401f215ea  research/astra-uniform-seed-coupling.md
25b9b2010b944694de40757e79dee14ba37a8d4edc9440793b80ee9e8eeff7a5  research/astra-multiple-contact-seed-plan.md
adcfb74938b39dc6264ad78ee622860102d08e461487a114347224de910480c0  research/astra-multiple-contact-seed-control.json
b2b6acd00dae3c8ed777bc3da4227fab0254016eec035c2c100f8d346a398f1b  research/astra-uniform-all-deletion-seed-screen.md
11f738862f1302dda62e2f0fcd7c8cdff0b3dad9462297b79cd1769371c70522  research/astra-uniform-seed-screen-review.md
```

No new mathematical program was executed, so there is no reviewer search
or control-run receipt to infer from the author's existing receipt. The
accepted results give a correct fixed-cell tool and exact failures of two
local transition rules. What remains missing is a valid transition or other
argument using global simultaneous trapping, or an actual construction in
which every full witness satisfies the isolating contact pattern. Q and
unrestricted LRC remain unresolved; no new Lean result is claimed.
