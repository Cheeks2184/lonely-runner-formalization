# Speed-complement descent: exact phase obstruction

Requested role: Astra xhigh research, 2026-09-05. Source binding:
`b246af6f15198b5aee95ad5c5b4d84f4cc6ffd83`.
The current configuration, workflow, policy, and state were read; workflow
structural validation passed. Research is authorized and the unrestricted
canonical goal remains unresolved. Only this manuscript is owned. No Lean,
cache, Git, shared-state, or publication change is part of this audit.

**Disposition:** the count/sum decrease is valid, but the proposed transfer of
failure through complementation is not supplied by the original-failure phase
inequalities. A sharp scalar identity isolates the missing condition. Fixed
controls demonstrate both failed and successful reuse at the correctly counted
thresholds. No contradiction to an actual minimum, new witness supply, or
refutation of every strategically selected complement exchange is claimed.

## 1. Actual minimum and decreasing operation

Use the global canonical-to-positive-integer equivalence first, then choose
a hypothetical positive injective integer failure of least moving count n
and, among that count, least natural speed sum H. This is the minimum from
`research/astra-minimal-height-audit.md`, accepted at its stated scope in
`research/astra-minimal-height-review.md`. No prescribed real counterexample
is assumed to convert to integers while retaining its count. Write

```text
A = V union {p},     p = max(A),     n = |A|,     N = n+1 >= 4,
H(A) = sum_(a in A) a,              delta = 1/N,
G_beta(W) = {t in R : ||w*t|| >= beta for every w in W}.
```

Here `G_delta(A)` is empty, with a closed good threshold. The stationary speed
is zero and stays fixed. Count minimality gives each smaller distinct positive
set of size m<n a witness at `1/(m+1)`; same-count sum minimality gives a
smaller-sum set a witness at delta. Neither premise transfers that witness to A.

For a selected old subset `D subset V`, define

```text
Q_D = {p-a : a in D},       B_D = (A minus D) union Q_D,
C_D = Q_D intersect (A minus D).
```

All new speeds are positive and below p, which remains the maximum. Since
`a -> p-a` is injective, exact deduplication gives

```text
|B_D| = n - |C_D|,
H(B_D) = H(A) + sum_(a in D)(p-2*a) - sum_(c in C_D)c.             (1)
```

Every nonempty subset of `{a in V : 2*a>p}` strictly lowers the natural sum
and never raises the count. These candidate steps preserve positivity and
stationary zero. A hypothetical minimum need not have a high old speed;
this audit does not infer that the eligible set is nonempty.

Put `m=|B_D|` and `alpha_D=1/(m+1)`. Minimality supplies
`G_(alpha_D)(B_D)` nonempty. A duplicate complement invokes the stronger
smaller-count threshold, not an injective theorem for a repeated tuple.
For a general D containing low speeds, (1) determines whether descent occurs.

## 2. Sharp scalar identity for one complement

This calculation assumes neither minimality nor global failure. Let `0<a<p`,
`q=p-a`, and `0<delta<=alpha<=1/2`. Suppose at a real time t that

```text
||a*t|| < delta,                 ||p*t|| >= alpha.
```

Choose the unique integer j with `x=a*t-j` in `(-delta,delta)`, and write
`y={p*t}` in `[alpha,1-alpha]`. Uniqueness follows from the strict bound and
`delta<=1/2`. Then

```text
alpha-delta < y-x < 1-alpha+delta,
alpha-delta >= 0,               1-alpha+delta <= 1.              (2)
```

Thus `0<y-x<1`, including when alpha=delta. There is no wrap in the fractional
part of `q*t=p*t-a*t`. Consequently

```text
||q*t|| >= alpha   iff   y-1+alpha <= x <= y-alpha,               (3)
||q*t|| <  alpha   iff   x>y-alpha or x<y-1+alpha.                (4)
```

The endpoints in (3) are closed; those in (4) are strict. The first alternative
in (4) requires `y<alpha+delta`; the second requires `y>1-alpha-delta`.
In particular, if

```text
alpha+delta <= y <= 1-alpha-delta,                              (5)
```

then q is strictly alpha-good, even though a is delta-bad. The interval in
(5) can be empty; no existence of such a time is asserted. At alpha=delta,
a central p-phase in `[2*delta,1-2*delta]` makes every delta-bad label's
complement strictly delta-good. This exact scalar behavior does not preserve
failure automatically, and does not say that a minimum has such a witness.

## 3. Exact missing inference under original failure

Fix one eligible a>p/2. Let `S=A minus {a}`, `B=S union {p-a}`, and
`alpha=1/(|B|+1)>=delta`. Every t in `G_alpha(S)` makes all retained original
speeds delta-good. Original failure forces `||a*t||<delta`, and the retained
p is alpha-good. Applying the identity gives

```text
t in G_alpha(B)
  iff t in G_alpha(S) and y-1+alpha <= x <= y-alpha.              (6)
```

Failure of the transformed B at its own canonical threshold would require
**every** retained-good time to lie in the strict wedges (4). Original failure
only puts x in `(-delta,delta)`; it does not put x outside the closed strip
in (6). Minimality actually supplies a point in that strip. Recording this
consequence alone reformulates the available smaller-tuple witness; it does
not supply new progress toward a contradiction.

For general D, every transformed witness makes all unchanged original speeds
good. Original failure therefore forces at least one original label in D to
be bad. Its good complement is compatible with (3). Other selected labels
may be good or bad independently. There is no general identity interpreting
an arbitrary partial complement as a change of distinguished runner;
coincidences for special sets are not excluded.

The accepted endpoint selector applies at the weaker original threshold after
deleting a: failure covers the a-row, and q=p-a<a meets the selector's bound.
It selects an endpoint from an already supplied weak witness. This is an
instance of the accepted theorem, not a new transfer mechanism; the selected
endpoint need not retain the stronger alpha margin.

## 4. Full complement changes the distinguished runner

For D=V, the full configuration including zero is reflected by `s -> p-s`.
Its new positive moving set satisfies

```text
F = {p} union {p-a : a in V},
|F|=n,                         H(F)=N*p-H(A).                    (7)
```

This lowers the sum exactly when `2*H(A)>N*p`. At any time t,

```text
t in G_delta(F)
  iff ||(p-s)*t|| >= delta for every original s != p,
```

where original s ranges over `{0} union A`. This says that original runner p
is lonely. It does not say original runner zero is lonely. Thus even when
(7) allows a minimality witness, there is no contradiction. Original runner
zero has become runner p in the reflected configuration; its relative
absolute speed set is A again, at the original height, so applying minimality
to that distinguished runner does not provide descent.

## 5. Fixed controls: failed and successful reuse

Use only the authorized fixed tuple `A=(1,4,5,6,7,11)`, p=11, N=7, H(A)=34.
Its high old speeds are 6 and 7; their complements 5 and 4 are retained.
All three nonempty selections therefore involve deduplication.

| D | Distinct B_D | Canonical margin | Failed reuse time | Original bad norm |
| --- | --- | --- | --- | --- |
| {6} | (1,4,5,7,11) | 1/6 | 69/100 | `||6t||=7/50<1/7` |
| {7} | (1,4,5,6,11) | 1/6 | 3/10 | `||7t||=1/10<1/7` |
| {6,7} | (1,4,5,11) | 1/5 | 3/10 | `||7t||=1/10<1/7` |

Each time satisfies its transformed tuple's actual canonical threshold.
The first has p-phase `59/100` in the central interval `[13/42,29/42]`
from (5) for alpha=1/6 and delta=1/7.

Successful reuse also occurs: D={6} has time 29/42, transformed-good at 1/6
and original-good at 1/7. D={6,7} has time 4/13, transformed-good at 1/5
and original-good at 1/7; the original 6 and 7 norms are both 2/13.

The negative controls prove only that **every listed D has some correctly
counted witness that fails reuse**. They do not say all witnesses fail or
refute an existential selection of a complement and a successful witness.
A itself has full witnesses, so it is not an actual minimum. These points
invalidate an inference from the displayed local phase inequalities alone;
they do not falsify an implication using additional global consequences of
original failure. They also do not test fresh-complement tuples.

The exact replay below checks only these fixed rational points. It performs
no tuple or witness discovery.

```python
from fractions import Fraction as F

def norm(x):
    return min(x % 1, (-x) % 1)

def good(W, beta, t):
    return all(norm(w*t) >= beta for w in W)

A = {1,4,5,6,7,11}
p, N = 11, 7
delta = F(1,N)
negative = [({6},F(69,100),6,F(7,50)),
            ({7},F(3,10),7,F(1,10)),
            ({6,7},F(3,10),7,F(1,10))]
for D,t,a,want in negative:
    Q = {p-v for v in D}
    C = Q & (A-D)
    B = (A-D) | Q
    alpha = F(1,len(B)+1)
    assert len(B) == len(A)-len(C)
    assert sum(B) == sum(A)+sum(p-2*v for v in D)-sum(C)
    assert sum(B) < sum(A)
    assert good(B,alpha,t) and not good(A,delta,t)
    assert norm(a*t) == want < delta
    x = a*t-round(a*t)
    y = (p*t) % 1
    assert -delta < x < delta and alpha <= y <= 1-alpha
    assert 0 < y-x < 1 and ((p-a)*t) % 1 == y-x
    assert (norm((p-a)*t)>=alpha) == (y-1+alpha<=x<=y-alpha)

for D,t in [({6},F(29,42)),({6,7},F(4,13))]:
    B = (A-D) | {p-v for v in D}
    assert good(B,F(1,len(B)+1),t)
    assert good(A,delta,t)

t = F(69,100)
alpha = F(1,6)
assert alpha+delta <= (p*t)%1 <= 1-alpha-delta
assert norm(5*t) > alpha
assert norm(6*F(4,13)) == norm(7*F(4,13)) == F(2,13)
print('3 failed-reuse and 2 successful-reuse fixed controls passed')
```

Exact replay from the repository root:

```bash
python3 -B - <<'COMPLEMENT_REPLAY'
from pathlib import Path
import re
p=Path('research/astra-complement-descent-audit.md')
blocks=re.findall(r'^```python\n(.*?)^```[ \t]*$',p.read_text(),re.M|re.S)
assert len(blocks)==1
exec(compile(blocks[0],str(p),'exec'),{})
COMPLEMENT_REPLAY
```

The replay exited zero with `3 failed-reuse and 2 successful-reuse fixed
controls passed`. Manuscript whitespace and `python3 -B
scripts/validate_workflow.py` also passed. No project module, external solver,
or large dependency was imported. These finite checks supplement the scalar
derivation; they are not an independent review or kernel verification.

## Frozen remaining step

This branch produced no new necessary condition beyond the scalar identity
and applications of the accepted minimality/endpoint contracts. A genuine
complement descent still needs a global argument forcing a decreasing B_D
to fail, or a justified selection/transport of one of its witnesses to the
original stationary-runner tuple. Strict badness of a removed speed,
availability of the stronger count witness, and complementation itself do
not supply that argument. The bounded attempt stops at this precise gap;
strategically selected complement exchanges remain open.
