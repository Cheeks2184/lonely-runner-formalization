# A complete finite target for the four-runner mixed classification

2026-09-06. Root mathematical follow-up at main checkpoint
`fd99b6f550bcb931f101ef2186168f1fc09aec4d`. This note is separate from the
frozen strict-to-mixed audit and its independent review. It proposes a small
complete classification target, rather than extending an arbitrary search
cutoff. No new Lean theorem is claimed here.

For three distinct positive integer speeds `a<b<H`, define mixed existence
as one positive real time at which all three norms are at least `1/4` and
the fastest norm is at least `1/3`.

## Reduction and proposed theorem

The accepted zero-residual source audit gives the prospective mixed-height
theorem under `LowerCountPositiveIntegerHypothesis 4`. That lower-count
hypothesis follows from the existing `BaseCases.oneMovingRunner` and
`SmallDimensions.twoMovingRunners`: its moving counts are exactly one and two.
The sharper height cutoff specializes to

```text
choose(4,2)^(4-2) = 6^2 = 36.
```

Thus, after the new height theorem is checked, every primitive triple with
H>36 has a mixed witness. Only the 6,079 primitive triples among the 7,140
increasing triples in `{1,...,36}` remain. An exact root diagnostic of this
entire finite domain found that `(1,2,3)` is the only primitive exception.
This is computational evidence pending a kernel certificate and independent
semantic review, not an already formalized classification.

The natural proposed integer theorem is:

```text
For 0<a<b<H, mixed existence holds if and only if
it is not the case that b=2a and H=3a.
```

To pass from primitive to arbitrary integer speeds, divide by the common gcd.
Norms at the resulting time are transported back by dividing time by this
positive gcd. Mixed existence, and failure of mixed existence, are invariant
under this scaling. A primitive sorted triple proportional to `(1,2,3)` is
exactly `(1,2,3)`.

The exceptional triple has no strict ordinary witness either. By period one
and reflection it suffices to take `t` in `[0,1/2]`. The first two ordinary
inequalities constrain `t` to `[1/4,3/8]`. On `[1/4,1/3]`, the third inequality
forces `3t<=3/4`, hence `t=1/4`. On `[1/3,3/8]` its norm is at most `1/8`,
so there are no further points. At `t=1/4` all ordinary bounds hold but the
fastest norm is `1/4<1/3`. Thus the complete ordinary half-period good set is
`{1/4}`. Scaling gives the corresponding statement for every `(a,2a,3a)`.
Consequently the proposed classification would also establish K at N=4.
It would not settle K at larger counts or unrestricted LRC.

## Prospective kernel certificate

A small natural-number certificate can verify the bounded branch. For a
rational candidate `t=p/q`, with `q>0`, let
`r_w=(w*p)%q`. The exact closed inequalities are

```text
q <= 4*r_a,  4*r_a <= 3*q;
q <= 4*r_b,  4*r_b <= 3*q;
q <= 3*r_H,  3*r_H <= 2*q.
```

These imply the mixed norm bounds through the existing circle-norm residue
bridge. The third pair already implies the ordinary fastest bound. A nonempty
closed band intersection has a rational left endpoint with denominator dividing
one of `4a`, `4b`, or `3H`, so the reduced denominator is at most `4H<=144`.
The diagnostic independently checks each returned endpoint by exact norms and
by all six integer inequalities; it also checks this denominator bound.

Implementation should choose a compact explicit witness table or a deterministic
finite witness function, then verify its arithmetic with kernel reduction and
a proved exhaustive-domain coverage lemma. No `native_decide`, custom axiom,
or trust in Python's negative output is allowed. The lone negative primitive
case has the analytic proof above. A finite table is proof data, not an external
oracle; its verification and the real-time bridge must both be checked.

Do not launch this additional Lean implementation before the current affine
strengthening is frozen and independently reviewed. Preserve the current
worker's six-file ownership and use one shared dependency cache.

## Exact diagnostic reproducer

This runs the full finite domain dictated by the height theorem. It imports no
external code and creates no large artifact. The complete ordered witness-row
digest is emitted so independent replays can compare every positive row.

```python
from fractions import Fraction as Q
from itertools import combinations
from math import gcd, floor
from hashlib import sha256
import json

def norm(x):
    f = x - floor(x)
    return min(f, 1-f)

def good(W, mixed):
    cells = [(Q(0), Q(1, 2))]
    for w in W:
        d = Q(1, 3) if mixed and w == W[-1] else Q(1, 4)
        bands = [((j+d)/w, (j+1-d)/w) for j in range(w//2+1)]
        out = []
        i = j = 0
        while i < len(cells) and j < len(bands):
            l, r = cells[i]
            a, b = bands[j]
            if max(l, a) <= min(r, b):
                out.append((max(l, a), min(r, b)))
            if r < b:
                i += 1
            elif b < r:
                j += 1
            else:
                i += 1
                j += 1
        cells = out
        if not cells:
            break
    return cells

rows = []
empty = []
primitive = 0
for W in combinations(range(1, 37), 3):
    if gcd(*W) != 1:
        continue
    primitive += 1
    cells = good(W, True)
    if not cells:
        empty.append((W, good(W, False)))
        continue
    t = cells[0][0]
    p, q = t.numerator, t.denominator
    assert 0 < t <= Q(1, 2) and q <= 4*W[-1] <= 144
    assert all(norm(w*t) >= Q(1, 4) for w in W)
    assert norm(W[-1]*t) >= Q(1, 3)
    ra, rb, rh = [(w*p) % q for w in W]
    assert q <= 4*ra <= 3*q and q <= 4*rb <= 3*q
    assert q <= 3*rh <= 2*q
    rows.append([*W, p, q])

assert primitive == 6079 and len(rows) == 6078
assert empty == [((1, 2, 3), [(Q(1, 4), Q(1, 4))])]
encoded = json.dumps(rows, separators=(',', ':')).encode() + b'\n'
print(json.dumps({
    'status': 'PASS', 'cutoff': 36, 'positive_triples': 7140,
    'primitive_triples': primitive, 'mixed_witnesses': len(rows),
    'mixed_empty': [[1, 2, 3]], 'ordinary_exception_half_cells': [['1/4', '1/4']],
    'witness_rows_sha256': sha256(encoded).hexdigest(),
    'maximum_witness_denominator': max(row[-1] for row in rows),
}, sort_keys=True, separators=(',', ':')))
```

The saved block exited 0. All 6,078 positive rows passed exact norm and integer
residue checks. The largest reduced witness denominator was 140. Its ordered
witness-row SHA-256 was
`08e98062af51e2c5e5e5c7d45caaa0cb166d19caa8e55f1ca370d55fef6bdbd3`.
Program SHA-256, including final newline:
`233831abc5b5fa246012c05d4ac8ee84738520529c6bf320f1a88d0aec83c845`.
Exact stdout SHA-256:
`1b39847584961da45a366d2bfc8035c5be82ef0a7d179927a1297016e6f70aa9`.
The small root replay output is at
`/tmp/astra-four-runner-mixed-finite-root-replay.json`.
The bounded computation and proposed analytic bridge need independent review
before any promotion.
