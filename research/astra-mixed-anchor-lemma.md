# Mixed witness to a nonzero anchor: exact count boundary

The statement as posed for every `N≥3` is **false**. The counterexample is
`N=3`, speeds `(1,3)`: its only mixed good time modulo one is `1/2`, where the
only pair-sum norm is zero. The corrected statement for **every `N≥4` is true**,
with a rational construction inside one ordinary good cell, followed only in
the all-half case by an explicit rational perturbation. The strict zero-norm
exclusion is preserved throughout the proof.

This is a manuscript proof and exact rational control artifact, not a Lean
formalization. Its premise remains the existence of a mixed witness. It does
not supply that premise uniformly, prove a lower-count time selector, verify
another worker's packet constructor, or resolve the canonical conjecture.

Assigned source checkpoint: `1412a65421d2b0898f7dc28fd1b6f3b736131d33` (Pass28,
PR27 CI). This manuscript is excluded from Pass28. Task:
`/root/endpoint_label_audit-mixed-anchor-lemma`; requested Astra/xhigh routing,
with observed runtime identity/effort not independently exposed. The project
configuration, workflow, policy and current state were read. The state recorded
active research and an unresolved canonical objective;
`python3 -B scripts/validate_workflow.py` exited 0 with structural validation
passed. Only this owned manuscript and small temporary exact controls were
written; no state, Git, Lean source or cache was changed.

Write `||x||=min(fract(x),1−fract(x))`, the circle distance to an integer.
The original hypotheses are

```
N ≥ 3,
0 < W_1 < ... < W_(N−1) = H, all W_i integers,
delta = 1/N, alpha = 1/(N−1),
T rational,
||W_i T|| ≥ delta for every original moving label i,
||H T|| ≥ alpha.
```

The desired conclusion asks for a rational `T'` satisfying those same ordinary
and largest-speed margins, together with an original speed `a<H` such that

```
0 < ||(a+H)T'|| ≤ ||HT'|| − delta.
```

At `N=3`, `alpha=1/2`, so the mixed condition for `(1,3)` forces
`3T≡1/2 (mod 1)`. All possibilities modulo one are `1/6,1/2,5/6`. Their speed-1
norms are `1/6,1/2,1/6`; only `T=1/2` meets `delta=1/3`. Both moving speeds then
have norm `1/2`, and `(1+3)T` is integral. Thus every admissible `T'` has anchor
norm zero. The input `T=1/2` is rational and satisfies every stated premise.
This is an exact counterexample to the auxiliary lemma, not to LRC; the tuple
already has an ordinary witness. In general at `N=3`, the half-phase identity
below shows precisely why an admissible largest-speed half phase also needs
the other phase to be nonhalf if the anchor norm is required to be nonzero.

For `N≥4`, we have

```
0 < delta < alpha < 1/2.
```

Normalize the supplied time modulo one. If its largest-speed fractional phase
is above `1/2`, replace the normalized time by its reflection `1−T`. Integer
speeds preserve all original norms under either operation, so this keeps the
stationary runner, all comparisons and both margins. The resulting rational
`t` has

```
f_H = Ht − floor(Ht) = ||Ht|| ∈ [alpha,1/2].
```

For every original moving speed set `z_i=floor(W_i t)` and form the closed cell

```
L = max_i (z_i+delta)/W_i,
R = min_i (z_i+1−delta)/W_i,
I = [L,R],
K = (z_H+1/2)/H.
```

These are rational endpoints and `L≤t≤R`, `t≤K`. At every `s∈I`, all original
phases stay in the closed bands `[z_i+delta,z_i+1−delta]`, hence all original
norms remain at least `delta`. This direct intersection is enough; no global
maximizer of the good set is assumed. Because `delta>0`, a connected good
component cannot cross an integer phase, so it is also the whole good
component containing `t`. The argument retains singleton cells and tied
endpoint owners.

**Case `R≤K`, including equality.** Choose any index attaining the finite
minimum defining `R`. At `s=R`, its fractional phase is `1−delta`. Meanwhile
the largest-speed fractional phase is

```
h' = HR−z_H ∈ [f_H,1/2] ⊆ [alpha,1/2].
```

The selected upper owner cannot be `H`, since `1−delta>1/2`. Therefore its
original speed is some `a<H`. Its pair-sum phase satisfies

```
(a+H)R = z_a+z_H+1+(h'−delta).
```

Here `0<alpha−delta≤h'−delta≤1/2−delta<1/2`. Consequently
`||(a+H)R||=h'−delta>0`, exactly the desired inequality. Set `T'=R`.
This proof applies without movement if the supplied time was already the
right endpoint; ties and zero-width cells cause no exception.

**Case `K<R`.** Set `s=K∈I`, so the largest-speed norm is exactly `1/2`.
For every real phase `x`,

```
||x+1/2|| = 1/2−||x||.
```

This follows separately from `fract(x)≤1/2` and `fract(x)≥1/2`, and includes
both closed boundaries. If any original `a<H` has `||as||<1/2`, the identity
implies

```
0 < ||(a+H)s|| = 1/2−||as|| ≤ 1/2−delta.
```

Thus `T'=s` works. A norm different from `1/2` is necessarily below it; all
original norms at `s` are already at least `delta`.

It remains to treat the case where **every original phase is half** at `s`.
No such unperturbed pair is allowed: every `(a+H)s` is integral. Define

```
b = 1/2−alpha > 0,
epsilon = b/(4H) > 0,
T' = s+epsilon.
```

Both `epsilon` and `T'` are rational. Since `0<W_i≤H`,
`0<W_i epsilon≤b/4<1/2`. Every fractional phase becomes
`1/2+W_i epsilon`, without an integer crossing, so

```
||W_i T'|| = 1/2−W_i epsilon
           ≥ 1/2−H epsilon
           = 1/2−b/4
           > alpha > delta.
```

In particular the mixed largest-speed margin survives. Choose any original
`a<H`, which exists under the given count and strict ordering. The old
pair-sum phase was integral, and

```
0 < (a+H)epsilon < 2H epsilon = b/2 < 1/2.
```

Hence its new norm is precisely `(a+H)epsilon`, not zero. Finally,

```
(a+2H)epsilon < 3H epsilon = 3b/4 < 1/2−delta,
```

where the last inequality uses `0<b=1/2−alpha<1/2−delta`. Rearranging gives

```
||(a+H)T'|| = (a+H)epsilon
           < (1/2−H epsilon)−delta
           = ||HT'||−delta.
```

This completes every case for every `N≥4`. The only step requiring strict
`alpha<1/2` is this all-half perturbation; at `N=3` it has `epsilon=0`, exactly
the obstruction exhibited above. For the corrected theorem, no extra margin,
new speed, changed label count, reselected distinguished runner or real-time
approximation has been introduced. All returned times and the perturbation
are explicitly rational.

Six fixed constructor inputs were checked with Python `Fraction` arithmetic;
there was no tuple discovery or broad enumeration. Three are the supplied
examples. The other three were chosen directly to exercise the half/nonhalf,
all-half and tied-singleton branches of this proof.

| Original speeds; total N | Input | Returned time; anchor | Anchor norm | Largest norm minus delta |
| --- | --- | --- | --- | --- |
| `(1,3,4)`; 4 | `5/12` | `7/12`; 3 | `1/12` | `1/12` |
| `(1,3,4,5)`; 5 | `9/20` | `9/20`; 4 | `1/20` | `1/20` |
| `(1,4,5,6,7,11)`; 7 | `15/49` | `13/42`; 6 | `11/42` | `11/42` |
| `(1,2,5)`; 4 | `3/10` | `3/10`; 1 | `1/5` | `1/4` |
| `(1,3,5)`; 4 | `1/2` | `61/120`; 1 | `1/20` | `5/24` |
| `(1,3,6)`; 4 | `1/4` | `1/4`; 3 | `1/4` | `1/4` |

The last row has the singleton cell `I={1/4}` and `R=K=1/4`. The `(1,3,5)` row
has zero pair-sum norms at its input and genuinely needs a different time.
All 22 actual original-speed output inequalities passed, as did the six
largest-speed margins and six strict anchor inequalities. Independently, the
three supplied anchors at the supplied original times were verified: their
norms are `1/12`, `1/20`, `5/49`, respectively, with margins `1/12`, `1/20`,
`11/49`. Complete finite closed-band intersection additionally certified
that the `(1,3)` mixed set is exactly `{1/2}` and the `(1,3,4,5)` mixed set is
exactly `{9/20,11/20}` modulo one. Those inventories include singleton
intersections rather than discarding zero-width cells.

The following complete program reproduces the controls. Save it as
`/tmp/astra-mixed-anchor-controls.py` and run
`python3 -B /tmp/astra-mixed-anchor-controls.py > /tmp/astra-mixed-anchor-controls.json`.
That exact command exited 0. The controls are supplemental to the general
proof above; they are not the basis for the universal `N≥4` conclusion.

```python
#!/usr/bin/env python3
from fractions import Fraction as F
from hashlib import sha256
from pathlib import Path
import json

def norm(x):
    f=x-x.numerator//x.denominator
    return min(f,1-f)

def intervals(W, margins):
    out=[(F(0),F(1))]
    for w,d in zip(W,margins):
        out=sorted(set((max(l,F(k,w)+d/w),min(r,F(k+1,w)-d/w))
            for l,r in out for k in range(w)
            if max(l,F(k,w)+d/w)<=min(r,F(k+1,w)-d/w)))
    return out

def construct(W,T):
    N=len(W)+1; H=W[-1]; delta=F(1,N); alpha=F(1,N-1)
    assert N>=4 and all(0<a<b for a,b in zip(W,W[1:]))
    assert all(norm(w*T)>=delta for w in W) and norm(H*T)>=alpha
    T=T-T.numerator//T.denominator
    if H*T-(H*T).numerator//(H*T).denominator>F(1,2):
        T=1-T
    z=[(w*T).numerator//(w*T).denominator for w in W]
    L=max((k+delta)/w for k,w in zip(z,W))
    R=min((k+1-delta)/w for k,w in zip(z,W))
    K=(z[-1]+F(1,2))/H
    assert L<=T<=R and T<=K
    if R<=K:
        T1=R
        a=next(w for w,k in zip(W,z) if (k+1-delta)/w==R)
        assert a<H
        branch='upper endpoint (tie included)'
        assert norm((a+H)*T1)==norm(H*T1)-delta
    else:
        T1=K
        nonhalf=[w for w in W[:-1] if norm(w*T1)!=F(1,2)]
        if nonhalf:
            a=nonhalf[0]
            branch='half with a nonhalf old phase'
            assert norm((a+H)*T1)==F(1,2)-norm(a*T1)
        else:
            a=W[0]
            epsilon=(F(1,2)-alpha)/(4*H)
            assert epsilon>0
            T1+=epsilon
            branch='all-half rational perturbation'
            assert all(norm(w*T1)==F(1,2)-w*epsilon for w in W)
            assert norm((a+H)*T1)==(a+H)*epsilon
    h=norm(H*T1); s=norm((a+H)*T1)
    assert all(norm(w*T1)>=delta for w in W)
    assert h>=alpha and 0<s<=h-delta
    return {'W':W,'N':N,'oriented_input':str(T),'cell':[str(L),str(R)],
            'next_H_half':str(K),'branch':branch,'output':str(T1),'a':a,
            'ordinary_norms':[str(norm(w*T1)) for w in W],
            'h':str(h),'anchor_norm':str(s),'h_minus_delta':str(h-delta)}

# Six fixed inputs: the supplied three plus explicitly constructed branch controls.
fixtures=[([1,3,4],F(5,12)),([1,3,4,5],F(9,20)),
          ([1,4,5,6,7,11],F(15,49)),([1,2,5],F(3,10)),
          ([1,3,5],F(1,2)),([1,3,6],F(1,4))]
rows=[construct(W,T) for W,T in fixtures]
assert [r['output'] for r in rows]==['7/12','9/20','13/42','3/10','61/120','1/4']
assert rows[-1]['cell']==['1/4','1/4']
assert rows[-1]['next_H_half']=='1/4'

# Verify the three supplied anchors at their supplied original times as well.
supplied=[]
for (W,T),a in zip(fixtures[:3],[3,4,5]):
    delta=F(1,len(W)+1); h=norm(W[-1]*T); s=norm((a+W[-1])*T)
    assert 0<s<=h-delta
    supplied.append({'T':str(T),'a':a,'h':str(h),'anchor_norm':str(s),
                     'h_minus_delta':str(h-delta)})
assert [r['anchor_norm'] for r in supplied]==['1/12','1/20','5/49']

# Complete finite mixed-good inventories for the two asserted singleton controls.
W3=[1,3]
mixed3=intervals(W3,[F(1,3),F(1,2)])
assert mixed3==[(F(1,2),F(1,2))]
assert norm(4*F(1,2))==0
assert all(norm(w*F(1,2))>=F(1,3) for w in W3)
W5=[1,3,4,5]
mixed5=intervals(W5,[F(1,5)]*3+[F(1,4)])
assert mixed5==[(F(9,20),F(9,20)),(F(11,20),F(11,20))]
result={'status':'PASS','constructor_inputs':len(fixtures),
 'actual_original_speed_checks':sum(len(W) for W,T in fixtures),
 'supplied_anchor_checks':len(supplied),
 'constructed':rows,'supplied':supplied,
 'N3_counterexample_mixed_set':[[str(l),str(r)] for l,r in mixed3],
 'N5_fixed_mixed_set':[[str(l),str(r)] for l,r in mixed5],
 'script_sha256':sha256(Path(__file__).read_bytes()).hexdigest()}
print(json.dumps(result,indent=2))
```

Script SHA-256: `3d4e14d19998fa34aaa9625cfcf2a3eb1754351a540b667d120f610578e50118`.

Output SHA-256: `e4dcdf769f446acf52e8154415daa6759bda9ef7b8ea0b2fe071bed37f940a4e`.

Complete deterministic output:

```json
{
  "status": "PASS",
  "constructor_inputs": 6,
  "actual_original_speed_checks": 22,
  "supplied_anchor_checks": 3,
  "constructed": [
    {
      "W": [
        1,
        3,
        4
      ],
      "N": 4,
      "oriented_input": "7/12",
      "cell": [
        "9/16",
        "7/12"
      ],
      "next_H_half": "5/8",
      "branch": "upper endpoint (tie included)",
      "output": "7/12",
      "a": 3,
      "ordinary_norms": [
        "5/12",
        "1/4",
        "1/3"
      ],
      "h": "1/3",
      "anchor_norm": "1/12",
      "h_minus_delta": "1/12"
    },
    {
      "W": [
        1,
        3,
        4,
        5
      ],
      "N": 5,
      "oriented_input": "9/20",
      "cell": [
        "11/25",
        "9/20"
      ],
      "next_H_half": "1/2",
      "branch": "upper endpoint (tie included)",
      "output": "9/20",
      "a": 4,
      "ordinary_norms": [
        "9/20",
        "7/20",
        "1/5",
        "1/4"
      ],
      "h": "1/4",
      "anchor_norm": "1/20",
      "h_minus_delta": "1/20"
    },
    {
      "W": [
        1,
        4,
        5,
        6,
        7,
        11
      ],
      "N": 7,
      "oriented_input": "15/49",
      "cell": [
        "15/49",
        "13/42"
      ],
      "next_H_half": "7/22",
      "branch": "upper endpoint (tie included)",
      "output": "13/42",
      "a": 6,
      "ordinary_norms": [
        "13/42",
        "5/21",
        "19/42",
        "1/7",
        "1/6",
        "17/42"
      ],
      "h": "17/42",
      "anchor_norm": "11/42",
      "h_minus_delta": "11/42"
    },
    {
      "W": [
        1,
        2,
        5
      ],
      "N": 4,
      "oriented_input": "3/10",
      "cell": [
        "1/4",
        "7/20"
      ],
      "next_H_half": "3/10",
      "branch": "half with a nonhalf old phase",
      "output": "3/10",
      "a": 1,
      "ordinary_norms": [
        "3/10",
        "2/5",
        "1/2"
      ],
      "h": "1/2",
      "anchor_norm": "1/5",
      "h_minus_delta": "1/4"
    },
    {
      "W": [
        1,
        3,
        5
      ],
      "N": 4,
      "oriented_input": "1/2",
      "cell": [
        "9/20",
        "11/20"
      ],
      "next_H_half": "1/2",
      "branch": "all-half rational perturbation",
      "output": "61/120",
      "a": 1,
      "ordinary_norms": [
        "59/120",
        "19/40",
        "11/24"
      ],
      "h": "11/24",
      "anchor_norm": "1/20",
      "h_minus_delta": "5/24"
    },
    {
      "W": [
        1,
        3,
        6
      ],
      "N": 4,
      "oriented_input": "1/4",
      "cell": [
        "1/4",
        "1/4"
      ],
      "next_H_half": "1/4",
      "branch": "upper endpoint (tie included)",
      "output": "1/4",
      "a": 3,
      "ordinary_norms": [
        "1/4",
        "1/4",
        "1/2"
      ],
      "h": "1/2",
      "anchor_norm": "1/4",
      "h_minus_delta": "1/4"
    }
  ],
  "supplied": [
    {
      "T": "5/12",
      "a": 3,
      "h": "1/3",
      "anchor_norm": "1/12",
      "h_minus_delta": "1/12"
    },
    {
      "T": "9/20",
      "a": 4,
      "h": "1/4",
      "anchor_norm": "1/20",
      "h_minus_delta": "1/20"
    },
    {
      "T": "15/49",
      "a": 5,
      "h": "18/49",
      "anchor_norm": "5/49",
      "h_minus_delta": "11/49"
    }
  ],
  "N3_counterexample_mixed_set": [
    [
      "1/2",
      "1/2"
    ]
  ],
  "N5_fixed_mixed_set": [
    [
      "9/20",
      "9/20"
    ],
    [
      "11/20",
      "11/20"
    ]
  ],
  "script_sha256": "3d4e14d19998fa34aaa9625cfcf2a3eb1754351a540b667d120f610578e50118"
}
```

Disposition: the originally quantified `N≥3` lemma is refuted; its exact `N≥4` version is proved at manuscript level. Uniform mixed-witness existence and the unrestricted canonical conjecture remain unsupplied. All owned commands have stopped at freeze.
