# A conditional construction for exact two-anchor supply

2026-09-05. Requested Astra/xhigh task
`/root/cluster_limit_review-exact-affine-union-audit`, assigned source base
`367a9dc22e093a0347a776f988cac67335bab379`. Runtime model/effort metadata is
not independently exposed. Current configuration, workflow, policy and state
were read, including after compaction; `python3 -B
scripts/validate_workflow.py` passed. Research is authorized and the canonical
goal remains unresolved. This artifact is excluded from Pass28.

**Disposition: a proposed conditional manuscript theorem and fixed exact
controls, requiring independent review.** A rational ordinary witness with
sufficient fastest-coordinate margin and an explicit second-anchor inequality
admits an exact retained-margin packet. The construction forces the true
collision count, and uses neither a worst-case error budget nor a lower-count
witness oracle. It is a sufficient theorem with an additional anchor premise.
It does not prove the converse of the necessary mixed-margin condition, prove
uniform supply for the direct-or-exact union, or refute that union. It is not a
new Lean theorem or an unrestricted LRC result. No novelty claim is made.

## Frozen contract and the necessary endpoint condition

The precise old two-anchor contract is taken from these unchanged inputs:

| Input | SHA-256 |
| --- | --- |
| `research/astra-exact-rounding-scope-audit.md` | `ba16410bdd0ca08262573fbfa36d6e46078a7b3910f68e7593318dea63d78c3c` |
| `research/astra-exact-rounding-scope-review.md` | `37c5d7c39c24e3153d29008ebcccaa6e6141756b6ae0138f61d9c7c548840435` |
| `LonelyRunner/AffinePhaseTransfer.lean` | `069d7f05229f517639284a58d9bb10f6fd6ee8d949efc3d377361424e7381776` |
| `LonelyRunner/AffinePhasePeriod.lean` | `340c4dd29276544566175cf791307ca42753ddc964345aa793d33abef1e9b176` |
| `LonelyRunner/LowerCountSupply.lean` | `0705291adc53011fb72fc718a7260876512b092741442d6a6cceb4b76eb5ccf4` |

Write `||x||` for distance to the nearest integer. Fix `N>=3`, distinct sorted
positive integers `W_1<...<W_(N-1)=H`, and stationary chosen runner zero. Put
`delta=1/N` and `delta0=1/(N-1)`. A packet has positive integer `q`, integral
`u`, endpoint `u_H=q`, `p=H/q`, and residuals `v_i=W_i-p*u_i`. The stationary
coordinate is always `u_0=v_0=0`. For two distinct moving labels `a,b`, set

```text
beta=W_a+W_b, alpha=-(u_a+u_b), w_i=beta*u_i+alpha*W_i,
R_i=q*W_i-H*u_i, c=card {|w_i|}.
```

Require every `w_i!=0`. The pair has `w_a=-w_b`, so `1<=c<=N-2`. At one
shared time `tau`, exact supply S requires BOTH

```text
E_i: ||w_i*tau|| - (|R_i|/H)*||beta*tau|| >= delta,
C_i: ||w_i*tau|| >= 1/(c+1).
```

There is no upper bound on the individual integers `u_i` or residuals in
this contract. In particular, its exact-error form must not be replaced by
the previously refuted worst-case budget. The construction below uses large,
possibly nonmonotone integral `u`, which is permitted. It also has `p=H>1`.

The old transport normalizes `y0=alpha*tau` modulo `q` into `[q,2q)`, takes
`x=(alpha*p+beta)*tau`, a nearest integer `j` to `p*y-x`, and returns
`t=(j+x)/p>0`. Exact expansion at the fastest endpoint gives

```text
H*t = q*j + w_H*tau.
```

Thus S implies, at its single returned time, all ordinary inequalities and

```text
||H*t|| = ||w_H*tau|| >= 1/(c+1) >= delta0.             (M)
```

This implication includes every positive integer q, every allowed integral
u, every comparison pair, and every real tau. No folding or error estimate
is needed for it. A primitive tuple with every `d=2,...,N` dividing some
speed and an empty mixed good set would therefore refute the specified union
for all packet choices. No such tuple is established here. The union includes
only direct reciprocal witnesses and S; this discussion says nothing about
the union of all existing height or insertion methods.

## Conditional second-anchor theorem

Suppose a rational `T` satisfies

```text
||W_i*T|| >= delta for every i,
h := ||H*T|| >= delta0,
0 < ||(a+H)*T|| <= h-delta                            (A)
```

for one speed `a` different from H. Then an S packet exists with anchors
`a,H`, `q=1`, and **true** `c=N-2`. Its positive returned time is congruent
to T modulo one. No primitiveness or individual coprimality is needed for
this conditional theorem. The sorted distinct hypothesis is retained from
the audited union; the theorem concerns only the stationary chosen runner.

Here is a complete finite-choice construction. Let `beta=a+H`, choose the
nearest integer `ell` to `beta*T`, and put `b=beta*T-ell`. By (A),
`0<|b|<=h-delta<1/2`, so this nearest integer is unique. Choose positive
integers `m=1+beta*L`, with L sufficiently large, and define

```text
q=1, p=H, u_a=m-1, u_H=1,
d=H*m-beta>0, k=-ell,
alpha=-m, e=-H*b/d, tau=(k+e)/beta.                   (4)
```

As L grows, `e!=0` and `e` tends to zero. Take L large enough that
`|e|<1/2`, so k is the unique nearest integer to `beta*tau`. For the old
normalization, write `n=1-floor(-m*tau)`. Then

```text
y=-m*tau+n in [1,2), D=H*n-k-e, j=H*n-k,
t=y+e/H>0.
```

The positivity follows already from `t>=1-1/(2H)>0`. Since
`m*k+ell=(1-m)*ell` is divisible by beta, direct substitution proves

```text
t == -m*tau+e/H
  = -m*k/beta - d*e/(H*beta)
  = -m*k/beta + b/beta
  = T-(m*k+ell)/beta                 (mod Z).
```

The displayed equality uses an integer n only in its initial congruence.
In particular, the construction returns exactly the original phases.
Also `w_a=d` and `w_H=-d`. The endpoint identity gives both anchor collision
norms equal to h. Their exact error coefficients give

```text
E_H=h,
E_a=h-(d/H)*|e|=h-|b|>=delta.
```

Their own-count inequalities will follow from `c=N-2` and `h>=delta0`.

It remains to choose the N-3 other integral coordinates and prove that
count, without assuming it. For each such coordinate define its desired
real shift

```text
h_i=(W_i/H-u_i)*e.
```

The exact transport identity and `t==T (mod Z)` imply

```text
w_i*tau == W_i*T-h_i (mod Z),
(|R_i|/H)*||beta*tau||=|h_i|.                        (5)
```

For N>=4 there is a nonempty open interval J_i of shifts on which

```text
||W_i*T-h_i||>delta0,
||W_i*T-h_i||-|h_i|>=delta.                          (6)
```

To see this explicitly, take the signed principal phase `z_i`, with
`g_i=|z_i|=||W_i*T||>=delta`. If `g_i<1/2`, use

```text
h_i=-sign(z_i)*r,
max(0,delta0-g_i) < r < 1/2-g_i.
```

The interval has positive width because `delta0<1/2` and `g_i<1/2`.
Here the collision norm is `g_i+r`, and subtracting the exact loss r leaves
`g_i>=delta`, including when the original coordinate is exactly tight.
If `g_i=1/2`, use

```text
|h_i|<min((1/2-delta)/2, 1/2-delta0).
```

This is again a nonempty open interval. The collision norm is
`1/2-|h_i|>delta0`, and its exact bound is `1/2-2*|h_i|>delta`.
For N=3 there are no remaining coordinates, so no positive-width assertion
at `delta0=1/2` is needed.

Each J_i is fixed before L is chosen. Its inverse image under
`u_i -> (W_i/H-u_i)*e` has length `length(J_i)/|e|`, tending to infinity.
Choose L so every such interval has length greater than `4N`. It therefore
contains at least `2N` consecutive integers strictly inside it. Pick these
coordinates one at a time, excluding

```text
w_i=0, w_i=+d, w_i=-d,
w_i=+w_j or w_i=-w_j for previously chosen free j.
```

Since `w_i=beta*u_i-m*W_i` has nonzero coefficient beta, each prohibited
value excludes at most one integer. With j previous free coordinates the
number excluded is at most `3+2j`, and `j<=N-4`, so it is at most `2N-5`.
Thus the 2N candidates suffice. All free magnitudes are nonzero, mutually
distinct, and different from d. Exactly the anchor pair shares a magnitude,
and `c=1+(N-3)=N-2`. Now (6) supplies C at its **actual** threshold
`1/(c+1)=delta0`, and (5)-(6) supply E. This finishes the conditional proof.

This also proves rank two if one retains that extra premise: the anchor
determinant `H*u_a-a*u_H=d` is nonzero. The construction fixes q=1 and does
not assert an auxiliary denominator descent or a smaller actual tuple.

## Fixed controls and the remaining gap

The three required primitive, distinct positive controls all satisfy (A):

| W; N | T | h | selected a | signed b | h-delta |
| --- | --- | --- | --- | --- | --- |
| `(1,3,4)`; 4 | `5/12` | `1/3` | 3 | `-1/12` | `1/12` |
| `(1,3,4,5)`; 5 | `9/20` | `1/4` | 4 | `1/20` | `1/20` |
| `(1,4,5,6,7,11)`; 7 | `15/49` | `18/49` | 5 | `-5/49` | `11/49` |

Every d from 2 through N divides a speed in each row. Thus their direct
branch fails, while this conditional construction supplies the exact branch.
The last row's original norms are `15/49,11/49,23/49,8/49,7/49,18/49`.
It is not a mixed-target counterexample. The program also constructs a
two-moving-coordinate N=3 packet at `(1,4), T=3/8`, checking the case with
no free coordinates. The additional fixed control `(3,6,8), T=1/12`, with
anchor a=3, has endpoint h=1/3, anchor equality, and a free coordinate of
phase exactly 1/2; it checks the separate half-phase interval construction.

For `(1,3,4,5)` the complete ordinary good set on `[0,1/2]` is
`[11/25,9/20]`. This can be derived by successive closed-band intersections:

```text
speed 1: [1/5,1/2],
then 3: [1/5,4/15] union [2/5,1/2],
then 4: {1/5} union [2/5,9/20],
then 5: [11/25,9/20].
```

On that last interval `||5T||=5T-2`, ranging from `1/5` to `1/4`.
Consequently the mixed good set on `[0,1/2]` is exactly `{9/20}`. Integer
periodicity and reflection give exactly `{9/20,11/20}` modulo one. Any S
packet on this tuple must therefore have `c=3`, endpoint equality in C,
and one of those returned phases. This is only a necessity statement;
the construction above and the following literal supplied packet prove
success separately.

The root-supplied independent positive control has
`q=4, p=5/4, u=(1,3,3,4)`, anchors 4 and 5, `alpha=-7, beta=9`,
`w=(2,6,-1,1)`, `c=3`, `tau=1/4`, and `v=(-1/4,-3/4,1/4,0)`.
Its collision norms are `(1/2,1/2,1/4,1/4)`, losses
`(1/20,3/20,1/20,0)`, and E bounds `(9/20,7/20,1/5,1/4)`.
The exact old normalization gives
`x=1/16, y0=-7/4, y=25/4, D=31/4, j=8, t=129/20`.
The program verifies every displayed quantity using rational arithmetic.

By contrast, consecutive `(1,2,3)`, N=4, has ordinary good set `{1/4}`
on `[0,1/2]` and empty mixed good set. Its original full witness survives,
and d=4 divides no speed, so it does not refute the union. It is also an
invalid-premise control for the conditional constructor. Selecting a=1 at
the otherwise valid `(1,3,4,5), T=9/20` is a second invalid-premise control:
`||6T||=3/10>1/20=h-delta`. Failure for that anchor does not imply failure
for other anchors. A half-phase zero-rounding binary-cut control on
`(1,3,5), T=1/2` checks success outside the theorem's nonzero-b premise.

The new structural result is the explicit conditional construction, not a
newly discovered tuple or an automatic weakening of S. The missing universal
step is still to supply suitable witnesses and anchors, or to prove an exact
obstruction, on every primitive tuple where all small divisors are covered.
No converse `mixed witness => S` is asserted here. No H_N time selector,
finite-family supply, assertion about actual minimal counterexamples, or
canonical proof follows from these fixed examples.

## Sole deterministic reproducer

Run from the repository root using Python's standard library. This is an
explicit constructor on five fixed inputs, one supplied literal packet,
one zero-rounding boundary packet, three invalid-premise checks, and complete
interval intersections on three named tuples. It performs no tuple discovery,
floating-point calculation, Lean invocation, cache operation, or file write.
The finite selection over at most 2N integers per free coordinate implements
the proved collision-avoidance step; it is not a search for a new tuple.

```python
from fractions import Fraction as F
from hashlib import sha256
from pathlib import Path
import json
from math import gcd
from functools import reduce

SOURCES = {
    'research/astra-exact-rounding-scope-audit.md': 'ba16410bdd0ca08262573fbfa36d6e46078a7b3910f68e7593318dea63d78c3c',
    'research/astra-exact-rounding-scope-review.md': '37c5d7c39c24e3153d29008ebcccaa6e6141756b6ae0138f61d9c7c548840435',
    'LonelyRunner/AffinePhaseTransfer.lean': '069d7f05229f517639284a58d9bb10f6fd6ee8d949efc3d377361424e7381776',
    'LonelyRunner/AffinePhasePeriod.lean': '340c4dd29276544566175cf791307ca42753ddc964345aa793d33abef1e9b176',
    'LonelyRunner/LowerCountSupply.lean': '0705291adc53011fb72fc718a7260876512b092741442d6a6cceb4b76eb5ccf4',
}
for path, expected in SOURCES.items():
    assert sha256(Path(path).read_bytes()).hexdigest() == expected

def floor(x):
    x = F(x)
    return x.numerator // x.denominator

def ceil(x):
    return -floor(-x)

def nearest(x):
    return floor(x + F(1, 2))

def norm(x):
    return abs(x - nearest(x))

def principal(x):
    return x - nearest(x)

def strs(xs):
    return [str(x) for x in xs]

def packet(W, q, u, a, b, tau):
    N, H = len(W) + 1, W[-1]
    assert q > 0 and u[-1] == q and len(u) == len(W)
    assert 0 <= a < len(W) and 0 <= b < len(W) and a != b
    assert all(isinstance(x, int) for x in u)
    p = F(H, q)
    alpha, beta = -(u[a] + u[b]), W[a] + W[b]
    w = [beta * ui + alpha * Wi for Wi, ui in zip(W, u)]
    assert all(wi != 0 for wi in w) and w[a] == -w[b]
    c = len(set(map(abs, w)))
    assert 1 <= c <= N - 2
    v = [Wi - p * ui for Wi, ui in zip(W, u)]
    R = [q * Wi - H * ui for Wi, ui in zip(W, u)]
    x, y0 = (alpha * p + beta) * tau, alpha * tau
    n = 1 - floor(y0 / q)
    y = y0 + q * n
    D = p * y - x
    j = nearest(D)
    t = (j + x) / p
    assert q <= y < 2 * q and t > 0
    assert D == H * n - beta * tau
    assert abs(t - y) == norm(beta * tau) / p
    assert H * t == q * j + w[-1] * tau
    C = [norm(wi * tau) for wi in w]
    loss = [F(abs(Ri), H) * norm(beta * tau) for Ri in R]
    E = [Ci - li for Ci, li in zip(C, loss)]
    actual = [norm(Wi * t) for Wi in W]
    for Wi, wi, vi, Ei, Ci, ai in zip(W, w, v, E, C, actual):
        assert (Wi * t - wi * tau - vi * (t - y)).denominator == 1
        assert ai >= Ei >= F(1, N)
        assert Ci >= F(1, c + 1)
    assert norm(H * t) >= F(1, N - 1)
    return dict(N=N, W=list(W), q=q, u=list(u), alpha=alpha,
                beta=beta, w=w, c=c, tau=str(tau), p=str(p),
                v=strs(v), x=str(x), y0=str(y0), y=str(y),
                D=str(D), j=j, t=str(t), C=strs(C),
                loss=strs(loss), E=strs(E), actual=strs(actual))

def anchor_hypotheses(W, T, a):
    N, H = len(W) + 1, W[-1]
    h = norm(H * T)
    z = norm((W[a] + H) * T)
    return (all(norm(Wi * T) >= F(1, N) for Wi in W)
            and h >= F(1, N - 1)
            and 0 < z <= h - F(1, N))

def construct(W, T, anchor_speed):
    W = tuple(W)
    N, H = len(W) + 1, W[-1]
    a = W.index(anchor_speed)
    assert list(W) == sorted(set(W)) and W[0] > 0 and a != len(W) - 1
    assert anchor_hypotheses(W, T, a)
    delta, delta0 = F(1, N), F(1, N - 1)
    beta = anchor_speed + H
    ell = nearest(beta * T)
    b = beta * T - ell
    free = [i for i in range(len(W)) if i not in (a, len(W) - 1)]
    intervals = {}
    for i in free:
        z = principal(W[i] * T)
        g = abs(z)
        assert g >= delta
        if g < F(1, 2):
            rlo, rhi = max(F(0), delta0 - g), F(1, 2) - g
            sign = 1 if z > 0 else -1
            lo, hi = sorted((-sign * rlo, -sign * rhi))
        else:
            radius = min((F(1, 2) - delta) / 2, F(1, 2) - delta0)
            lo, hi = -radius, radius
        assert lo < hi
        intervals[i] = (lo, hi)
    eta = min([F(1, 4)] + [(hi-lo)/(4*N) for lo, hi in intervals.values()])
    L = 1 + ceil((beta + H * abs(b) / eta) / (H * beta))
    m, k = 1 + beta * L, -ell
    d = H * m - beta
    e = -H * b / d
    assert 0 < abs(e) < eta <= F(1, 4)
    assert (m * k + ell) % beta == 0
    u = [None] * len(W)
    u[a], u[-1] = m - 1, 1
    used = {d}
    examined = 0
    for i in free:
        lo, hi = intervals[i]
        ulo, uhi = sorted((F(W[i], H) - lo/e, F(W[i], H) - hi/e))
        assert uhi - ulo > 4 * N
        first = floor(ulo) + 1
        chosen = None
        for ui in range(first, first + 2 * N):
            examined += 1
            assert ulo < ui < uhi
            wi = beta * ui - m * W[i]
            if wi != 0 and abs(wi) not in used:
                chosen = ui
                break
        assert chosen is not None
        u[i] = chosen
        used.add(abs(beta * chosen - m * W[i]))
        shift = (F(W[i], H) - chosen) * e
        assert lo < shift < hi
        assert norm(W[i] * T - shift) > delta0
        assert norm(W[i] * T - shift) - abs(shift) >= delta
    tau = (k + e) / beta
    out = packet(W, 1, u, a, len(W) - 1, tau)
    assert out['c'] == N - 2
    assert (F(out['t']) - T).denominator == 1
    assert F(out['t']) - F(out['y']) == e / H
    assert out['w'][a] == d and out['w'][-1] == -d
    out.update(T=str(T), anchor_speed=anchor_speed, m=m, d=d,
               e=str(e), free_coordinates=len(free), examined=examined)
    return out

def merge(intervals):
    out = []
    for lo, hi in sorted(intervals):
        if lo > hi:
            continue
        if out and lo <= out[-1][1]:
            out[-1] = (out[-1][0], max(hi, out[-1][1]))
        else:
            out.append((lo, hi))
    return out

def good_intervals(W, thresholds):
    out = [(F(0), F(1, 2))]
    for Wi, threshold in zip(W, thresholds):
        bands = [((z+threshold)/Wi, (z+1-threshold)/Wi) for z in range(Wi)]
        out = merge([(max(lo, a), min(hi, b))
                     for lo, hi in out for a, b in bands])
    return out

fixtures = [
    ((1, 4), F(3, 8), 1),
    ((1, 3, 4), F(5, 12), 3),
    ((1, 3, 4, 5), F(9, 20), 4),
    ((1, 4, 5, 6, 7, 11), F(15, 49), 5),
    ((3, 6, 8), F(1, 12), 3),
]
constructed = [construct(*fixture) for fixture in fixtures]
coverage = []
for W, T, a in fixtures[1:4]:
    assert reduce(gcd, W) == 1
    N = len(W) + 1
    divisors = {str(d): next(Wi for Wi in W if Wi % d == 0)
                for d in range(2, N + 1)}
    assert all(norm(Wi * T) >= F(1, N) for Wi in W)
    assert norm(W[-1] * T) >= F(1, N - 1)
    coverage.append(dict(W=list(W), divisors=divisors,
                         T=str(T), norms=strs(norm(Wi*T) for Wi in W)))

literal = packet((1, 3, 4, 5), 4, (1, 3, 3, 4), 2, 3, F(1, 4))
assert literal['w'] == [2, 6, -1, 1] and literal['c'] == 3
assert literal['v'] == ['-1/4', '-3/4', '1/4', '0']
assert literal['C'] == ['1/2', '1/2', '1/4', '1/4']
assert literal['loss'] == ['1/20', '3/20', '1/20', '0']
assert literal['E'] == ['9/20', '7/20', '1/5', '1/4']
assert (literal['x'], literal['y0'], literal['y'], literal['D'], literal['j'], literal['t']) == ('1/16', '-7/4', '25/4', '31/4', 8, '129/20')
half = packet((1, 3, 5), 1, (0, 1, 1), 0, 2, F(-1, 2))
assert half['loss'] == ['0', '0', '0']
assert half['C'] == ['1/2', '1/2', '1/2']
assert not anchor_hypotheses((1, 3, 5), F(1, 2), 0)
assert not anchor_hypotheses((1, 3, 4, 5), F(9, 20), 0)
assert not anchor_hypotheses((1, 2, 3), F(1, 4), 0)

interval_controls = []
expected = {
    (1, 3, 4): ([(F(5, 12), F(7, 16))], [(F(5, 12), F(5, 12))]),
    (1, 3, 4, 5): ([(F(11, 25), F(9, 20))], [(F(9, 20), F(9, 20))]),
    (1, 2, 3): ([(F(1, 4), F(1, 4))], []),
}
for W, (ordinary_expected, mixed_expected) in expected.items():
    N = len(W) + 1
    ordinary = good_intervals(W, [F(1, N)] * len(W))
    mixed = good_intervals(W, [F(1, N)] * (len(W)-1) + [F(1, N-1)])
    assert ordinary == ordinary_expected and mixed == mixed_expected
    interval_controls.append(dict(W=list(W), ordinary=[strs(x) for x in ordinary],
                                  mixed=[strs(x) for x in mixed]))
assert all(Wi % 4 != 0 for Wi in (1, 2, 3))

result = dict(source_hashes=SOURCES, constructed=constructed,
              small_divisor_coverage=coverage, literal_q4_packet=literal,
              half_phase_packet=half, interval_controls=interval_controls,
              counts=dict(constructed_packets=5, constructor_free_coordinates=8,
                          all_verified_packets=7, signed_packet_coordinates=25,
                          divisor_coverage_facts=13, invalid_premise_controls=3,
                          complete_fixed_interval_controls=3))
print(json.dumps(result, sort_keys=True, separators=(',', ':')))
```

## Execution and freeze record

The sole program was extracted with exactly one trailing newline and run as
`python3 -B -c <extracted-program>` from the repository root. The first run
completed with exit code 0, no stderr, and 4,274 stdout bytes. Its hashes are:

| Evidence | SHA-256 |
| --- | --- |
| Extracted program, including final newline | `5aef75b40a1cbb1a175ee98c0b349c0fc2ddee21da1c82812c270f23b763cc8f` |
| Exact stdout, including final newline | `cba49a167680aa29ef8d92f676103c27d9fcad39ef89e4437813bdb580b45400` |

The constructed q=1 packets are preserved here as compact replay records:

| W | u | tau | returned t | true c |
| --- | --- | --- | --- | --- |
| `(1,4)` | `(10,1)` | `-31/78` | `11/8` | 1 |
| `(1,3,4)` | `(1,28,1)` | `-140/327` | `17/12` | 2 |
| `(1,3,4,5)` | `(-34,-104,36,1)` | `-313/704` | `29/20` | 3 |
| `(1,4,5,6,7,11)` | `(1,1,48,-156,12,1)` | `-8005/25627` | `64/49` | 5 |
| `(3,6,8)` | `(22,-31,1)` | `-47/519` | `13/12` | 2 |

All five returned phases equal their respective supplied T modulo one. Eight
free coordinates were chosen, each from the proved interval; in these controls
the first integer considered already avoids the prohibited magnitudes. The
proof, rather than that favorable outcome, supplies the finite avoidance bound.
Together with the literal q=4 packet and zero-rounding packet, the program
checks seven packets and 25 original comparison coordinates. It also checks
13 divisibility facts, three invalid-premise cases, and the three complete
fixed interval certificates. These are fixed controls, not an exhaustive
finite-family computation or a proof of the quantified constructor.

The following shell command reproduces the recorded program and output hashes
without creating temporary files:

```bash
python3 -B - <<'PY'
from pathlib import Path
from hashlib import sha256
import subprocess
p=Path('research/astra-exact-affine-union-audit.md').read_text()
assert p.count('```python\n') == 1
code=p.split('```python\n',1)[1].split('\n```',1)[0]+'\n'
r=subprocess.run(['python3','-B','-c',code],capture_output=True)
assert r.returncode == 0 and not r.stderr
assert sha256(code.encode()).hexdigest() == '5aef75b40a1cbb1a175ee98c0b349c0fc2ddee21da1c82812c270f23b763cc8f'
assert sha256(r.stdout).hexdigest() == 'cba49a167680aa29ef8d92f676103c27d9fcad39ef89e4437813bdb580b45400'
assert len(r.stdout) == 4274
print('fixed constructor and interval replay passed')
PY
```

Other commands were the required instruction/state reads, successful workflow
structural validator, focused frozen-input reads, source SHA-256 checks, and
edits/readback of this owned manuscript. No tuple search, external research,
Lean process, cache restoration, Git mutation, or other-file write was run.
The shared-cache cleanup barrier was acknowledged and obeyed; commands resumed
only after the root's explicit cleanup-complete message. Final readback and
byte-exact replay passed; all owned commands are stopped at freeze. The final
manuscript SHA-256 is reported to the orchestrator separately, avoiding a
self-referential hash. This proposed manuscript theorem still requires an
independent semantic review before promotion.
