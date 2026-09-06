# Structural coupling of deletion seed components

Date: 2026-09-06. Task `/root/uniform_seed_coupling`; requested Astra/xhigh.
Supplied and read-back source checkpoint:
`e45793996d7ab435ad93822b068ef489edf52f53`.
Runtime model, effort, elapsed time and token usage are not independently exposed.
Only this report is owned. Project config, workflow, policy and focused state
were read; startup workflow validation passed. The memory quick pass found no
relevant project entry. No Lean build, dependency restoration, cache operation,
shared-state edit or Git mutation was performed.

**Result: a uniform endpoint-owner monotonicity lemma is proved below at
manuscript level. Two precise local relabelling rules are obstructed by actual
integer speeds and common times. The claim Q under simultaneous trapping of
all deletion components remains unresolved.** In particular, the controls do
not satisfy simultaneous trapping: they have explicit successful seeds elsewhere.
They refute local transition premises, not Q or a transition that additionally
uses a proved consequence of global trapping.

This task explored two structural approaches: margin continuation within a
fixed phase cell, and time continuation to another deletion seed. It did not
expand any old discovery search or use successive runner counts as milestones.

## Input and exact contract

The accepted starting reduction is bound to these bytes:

| Input | SHA-256 |
| --- | --- |
| `research/astra-uniform-all-deletion-seed-screen.md` | `b2b6acd00dae3c8ed777bc3da4227fab0254016eec035c2c100f8d346a398f1b` |
| `research/astra-uniform-seed-screen-review.md` | `11f738862f1302dda62e2f0fcd7c8cdff0b3dad9462297b79cd1769371c70522` |

Let `N>=4`, with `N-1` distinct positive integer speeds `v_i`, and set

```
delta = 1/N,   gamma = 1/(N-1),   eta = gamma-delta > 0,
S_p = {s : ||v_i*s|| >= gamma for every i != p},
rho_p(s) = min_(i!=p) (||v_i*s||-delta)/v_i,
F_p(s) = ||v_p*s|| + v_p*rho_p(s).
```

Q assumes **each** `S_p` is nonempty and asks whether some `s in S_p` has
`F_p(s)>=delta`. For a strong component `[l,r]` of `S_p` in the old weak
component `[L,R]`, the accepted exact protected union is

```
B_p([l,r]) = [max(L,2*l-R), min(R,2*r-L)].
```

Failure of Q is equivalent to all these protected intervals lying strictly
inside bad intervals of their respective deleted speeds. More precisely,
each connected protected interval lies in one open interval
`((k-delta)/v_p,(k+delta)/v_p)` for some integer `k`. Its positive radius
comes from `rho_p(s)>=eta/max_(i!=p) v_i>0`. Disconnected seed components
may use different integers `k`.

## Approach 1: the endpoint owner becomes faster when the margin decreases

The following is a genuine coupling between different active constraint
labels. It is uniform in the number and magnitudes of the velocities.

Fix one deletion and one nonempty strong phase cell. For each remaining
label choose the **actual** integer `k_i=floor(v_i*s)` at any strong seed
in the cell. For `delta<=alpha<=gamma` its band and intersection are

```
A_i(alpha) = (k_i+alpha)/v_i,
C_i(alpha) = (k_i+1-alpha)/v_i,
L(alpha) = max_i A_i(alpha),
R(alpha) = min_i C_i(alpha).
```

All these intersections contain the original strong seed. The integers are
fixed during this argument; they are not independently chosen phases.

**Lemma 1 (same-side owner monotonicity).** Let `a` own the left endpoint
at margin `gamma` and `q` own the left endpoint at margin `delta`. Then

```
eta/v_q <= L(gamma)-L(delta) <= eta/v_a,
v_q >= v_a.
```

If instead `a` and `q` own the corresponding right endpoints, then

```
eta/v_q <= R(delta)-R(gamma) <= eta/v_a,
v_q >= v_a.
```

Ties are allowed at both margins. Since the speeds are distinct, different
owner labels imply `v_q>v_a`.

Proof for the left side. Maximality at the two margins gives

```
L(delta) >= A_a(delta) = L(gamma)-eta/v_a,
L(delta) = A_q(delta) = A_q(gamma)-eta/v_q
                         <= L(gamma)-eta/v_q.
```

For the right side, minimality gives

```
R(delta) <= C_a(delta) = R(gamma)+eta/v_a,
R(delta) = C_q(delta) = C_q(gamma)+eta/v_q
                         >= R(gamma)+eta/v_q.
```

Division by positive `eta` and positivity of the speeds finish both claims.
The same proof applies to any two different margins in `[delta,gamma]`.

**Corollary 2 (no owner cycle during one margin continuation).** Along a
strictly decreasing sequence of margins in this fixed cell and on one fixed
side, each change of owner strictly increases its speed. An owner cannot
reappear after another owner, and there are at most `N-3` changes among the
`N-2` remaining labels. A tie at a single margin is not an interval of
oscillation; arbitrary tie choices at that same margin are not counted as
distinct margin steps.

This establishes the hoped-for velocity direction only for **endpoint
ownership**, not for a change of deleted label. It compares `q` with `a`,
not with the deleted label `p`. There is also no assertion that a weak
endpoint owned by `q` supplies a member of `S_q`: at that endpoint,
`||v_q*t||=delta`, while the old deleted speed can still be below `delta`.
Thus replacing `p` by `q` need not produce a strong seed. Changing the
deletion, the phase cell, or the side destroys the hypotheses needed to
chain this speed comparison. Approach 2 gives concrete failures of the
missing transitions.

## Approach 2: first-entry and adjacent-component relabelling

Here is a precise natural first-entry proposal. Start at a trapped seed
`s in S_p` with `||v_p*s||<delta`. Let `k` be the unique pivot collision
whose gamma-bad interval contains `s`, and set

```
t_minus = (k-gamma)/v_p,
t_plus  = (k+gamma)/v_p.
```

These are the first times in the two directions at which the pivot becomes
gamma-good. A proposed local transition is:

> At one of these two common times, at most one old speed is gamma-bad.
> Delete that label and obtain the next strong seed.

The exact survivor condition is

```
#{i != p : ||v_i*t_epsilon|| < gamma} <= 1.
```

If it is zero, the endpoint itself is a full gamma witness. If it is one,
its unique bad label `q` satisfies `t_epsilon in S_q`. This implication is
valid; the assertion that some direction satisfies the condition is false.
The strict bad inequality is necessary because strong seeds use the closed
threshold.

### An unbounded common-time obstruction

Write `m=N-1`. For every `m>=9`, take the `m` distinct positive speeds

```
V_m = {1,2,...,m-4} union {m-1,m,m+1,2*m-1}.
```

The pivot speed is `m`, the strong seed is `s=1/m`, and the margins are
`gamma=1/m`, `delta=1/(m+1)`, `eta=1/[m*(m+1)]`.

Every other speed is gamma-good at `s`: the four relevant boundary speeds
have residues `+1,+1,-1,-1`, supplied respectively by `1,m+1,m-1,2*m-1`.
The speed `1` imposes the left strong endpoint and `m-1` the right one, so
this strong component is the singleton `{s}`. All old speeds are at most
`2*m-1`, whose norm equals gamma, hence

```
rho_m(s) = eta/(2*m-1),
F_m(s) = 1/[(m+1)*(2*m-1)] < delta.
```

At the two first pivot-gamma times `t_plus=s+1/m^2` and
`t_minus=s-1/m^2`, the pivot norm equals gamma. However,

```
||(m-1)*t_plus||   = 1/m^2              < gamma,
||(2*m-1)*t_plus|| = (m-1)/m^2          < gamma,
||1*t_minus||     = (m-1)/m^2          < gamma,
||(m+1)*t_minus|| = 1/m^2              < gamma.
```

For example, `(m-1)*t_plus=1-1/m^2` and
`(2*m-1)*t_plus=2+(m-1)/m^2`; the other two identities follow by the same
integer subtraction. The displayed distances are at most `1/2`. Each
direction has two distinct old bad labels, so neither time belongs to
**any** `S_q`. This obstruction uses no independently assigned phases.

All deletion sets in this family really are nonempty. The single common
time `w=1/(m-3)` is gamma-good for every speed: putting `d=m-3>=6`, the
small block has residues `1,...,d-1`, and the other four speeds have
residues `2,3,4,5` modulo `d`. Thus every norm is at least `1/d>gamma`.
This also proves Q for the family. The family refutes the first-entry
transition from **a locally trapped component**, even with all deletion
sets nonempty; it does not refute a globally conditioned version that uses
simultaneous trapping of all components.

### Boundary owners need not be the next deleted label

A small exact control exposes the further problem with relabelling at a
later component. It is not a next-count milestone. Take

```
N=6,  V=(1,4,5,6,9),  gamma=1/5,  delta=1/6,  eta=1/30,
a=2/15,  b=1/5.
```

The strong component of `S_1` containing `a` is `{a}`: speed `9` is at
its rising gamma boundary and speed `6` at its falling gamma boundary.
The component of `S_5` containing `b` is `{b}`: speeds `1,6` are at rising
boundaries and `4,9` at falling boundaries. Exact weak components and
protected intervals are

| Deleted speed | Seed | Old weak component | Protected interval | Score |
| --- | --- | --- | --- | --- |
| `1` | `2/15` | `[7/54,5/36]` | `[7/54,37/270]` | `37/270 < 1/6` |
| `5` | `1/5` | `[7/36,11/54]` | `[53/270,11/54]` | `1/54 < 1/6` |

Both radii are `1/270`. In fact each **whole** weak component is trapped
by its deleted speed here, so the issue does not depend on symmetric
radius loss.

For every `a<t<b`, both speed `1` and speed `6` are strictly gamma-bad:
`0<t<1/5` and `4/5<6*t<6/5`. Consequently there is no strong deletion seed
of any label in this open gap. These two singleton components are adjacent
in the union of all deletion seed sets, in the indicated directions.

The right weak endpoint of the first is owned by speed `6`, and the left
weak endpoint of the second is also owned by speed `6`. Nevertheless the
next deleted labels across this gap are `5` and `1`, respectively, not `6`.
Thus the rule “continue to the adjacent strong component and delete the
weak endpoint's owner” is false under the displayed local hypotheses.

The possible directed adjacent-component moves also include

```
(deleted 1, seed a) --right--> (deleted 5, seed b)
(deleted 5, seed b) --left-->  (deleted 1, seed a).
```

In each departure direction the departing pivot norm initially increases.
The velocities change `1 -> 5 -> 1`, so this rule, when it permits either
pivot-improving direction, has no strict velocity potential. This is not a
counterexample to a fixed-orientation rule or to a rule proved using global
trapping; neither is claimed here.

Every deletion seed set is nonempty, since `w=3/10` is simultaneously
gamma-good for all five speeds, with norms `(3,2,5,2,3)/10`. The other
components cannot therefore be omitted in assessing Q. For comparison,
the first-entry times from the trapped pivot-5 seed are `4/25` and `6/25`:
their bad old labels are exactly `{1,6}` and `{4,9}`, respectively.

## Exact residual obligation and Lean relevance

The surviving global problem is still to prove or refute

```
(every S_p is nonempty)
  -> exists p, exists s in S_p, F_p(s) >= delta.
```

Lemma 1 gives a real acyclic owner relation while one varies only the
margin within one deletion cell. To turn it into a contradiction under
simultaneous trapping, an additional theorem must supply actual new strong
seeds after changing the deletion and must preserve an ordered quantity
across those changes. Neither first pivot entry nor local adjacency
supplies that theorem. The unbounded example shows exactly why a proof
cannot use only one component's trapping plus the existence of all seed
sets. It must use more of the **global simultaneous** trapping hypothesis.
No assertion that an arbitrary full witness implies Q is used.

Lemma 1 is suitable for Lean as a finite-family real interval lemma. Its
hypotheses are explicit active-owner equalities at two margins, positive
speeds, and fixed integer phase labels; its proof is ordered-field
arithmetic after `Finset` maximum/minimum bounds. The no-cycle corollary
also requires injectivity of velocities and strictly decreasing margins.
The circle interpretation requires the actual shared phase cell. Existing
`abs_circleNorm_sub_circleNorm_le` in `LonelyRunner/FastRunnerInsertion.lean`
was read as context; it does not supply the missing relabelling theorem.
No new Lean declaration or kernel check is claimed. Formalizing the
endpoint lemma would preserve a correct tool but would not close Q.

## One targeted rational control and reproducibility

The following complete standard-library script checks only the displayed
`N=6` control demanded by the two local transition assertions. It contains
no tuple search, no all-component enumeration, and no sampling of the
unbounded family. It checks local components from the actual integer
phases and the open-gap obstruction from exact inequalities. The
arbitrary-`m` arguments above are manuscript proofs, not computational
inferences from this control.

```python
from fractions import Fraction as F

v = (1, 4, 5, 6, 9)
delta, gamma = F(1, 6), F(1, 5)
a, b = F(2, 15), F(1, 5)

def norm(x):
    x %= 1
    return min(x, 1-x)

def local_component(old, s, margin):
    phases = [(d, (d*s).numerator // (d*s).denominator) for d in old]
    lo = max((k+margin)/d for d, k in phases)
    hi = min((k+1-margin)/d for d, k in phases)
    assert lo <= s <= hi
    return lo, hi

rows = [
    (1, a, (F(7,54), F(5,36)), (F(7,54), F(37,270)), F(37,270)),
    (5, b, (F(7,36), F(11,54)), (F(53,270), F(11,54)), F(1,54)),
]
for pivot, s, weak, protected, expected_score in rows:
    old = tuple(d for d in v if d != pivot)
    assert local_component(old, s, gamma) == (s, s)
    assert local_component(old, s, delta) == weak
    rho = min((norm(d*s)-delta)/d for d in old)
    assert rho == F(1,270)
    assert (s-rho, s+rho) == protected
    score = norm(pivot*s)+pivot*rho
    assert score == expected_score < delta
    assert all(norm(pivot*t) < delta for t in weak)
    print(f'pivot={pivot} seed={s} strong=[{s},{s}] '
          f'weak=[{weak[0]},{weak[1]}] '
          f'protected=[{protected[0]},{protected[1]}] score={score}')

# Both weak components lie inside a single open pivot-bad interval.
assert 0 < F(7,54) <= F(5,36) < delta
assert (1-delta)/5 < F(7,36) <= F(11,54) < (1+delta)/5
# Every point in the open gap is bad for 1 and 6, by these endpoint bounds.
assert 0 < a < b == gamma
assert 6*a == 1-gamma and 6*b == 1+gamma
assert 6*F(5,36) == 1-delta and 6*F(7,36) == 1+delta
print('open gap (2/15,1/5): strict gamma-bad labels 1 and 6; '
      'facing weak endpoint owner 6')

for t, expected in [(F(4,25), (1,6)), (F(6,25), (4,9))]:
    bad = tuple(d for d in v if norm(d*t) < gamma)
    assert norm(5*t) == gamma and bad == expected
    print(f'first pivot-5 gamma time={t} bad labels={bad}')

w = F(3,10)
norms = tuple(norm(d*w) for d in v)
assert norms == (F(3,10), F(1,5), F(1,2), F(1,5), F(3,10))
assert all(x >= gamma for x in norms)
print('all deletion sets nonempty: full gamma witness 3/10; '
      'norms=(3/10,1/5,1/2,1/5,3/10)')
print('PASS: one exact local transition control; no search or Lean check.')
```

The control was run exactly once. Root was notified immediately before and
afterward. From the repository root, the complete actual command was:

```sh
python3 -B - <<'PY'
from pathlib import Path
from hashlib import sha256
report = Path('research/astra-uniform-seed-coupling.md')
source = report.read_text()
block = source.split('```python\n',1)[1].split('\n```',1)[0]
exec(compile(block, str(report)+':targeted-control', 'exec'), {})
print('CONTROL_BLOCK_BYTES', len(block.encode()))
print('CONTROL_BLOCK_SHA256', sha256(block.encode()).hexdigest())
PY
```

Python process exit status: `0`. Complete bounded output:

```text
pivot=1 seed=2/15 strong=[2/15,2/15] weak=[7/54,5/36] protected=[7/54,37/270] score=37/270
pivot=5 seed=1/5 strong=[1/5,1/5] weak=[7/36,11/54] protected=[53/270,11/54] score=1/54
open gap (2/15,1/5): strict gamma-bad labels 1 and 6; facing weak endpoint owner 6
first pivot-5 gamma time=4/25 bad labels=(1, 6)
first pivot-5 gamma time=6/25 bad labels=(4, 9)
all deletion sets nonempty: full gamma witness 3/10; norms=(3/10,1/5,1/2,1/5,3/10)
PASS: one exact local transition control; no search or Lean check.
CONTROL_BLOCK_BYTES 2160
CONTROL_BLOCK_SHA256 5df812fb3cceb68e6162087ad280ba79913289cd60ab064b01301a008b973bc4
```

The script hash excludes fences and the newline immediately before the
closing fence. Source-bound input hashes above were checked before writing;
no existing discovery code was rerun. The one bounded control validates only
its displayed rational assertions. The general lemma and obstruction family
have author manuscript proofs and await independent semantic review. No
research process remains running.
