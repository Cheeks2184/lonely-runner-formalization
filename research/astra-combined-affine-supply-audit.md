# Small reciprocal times do not complete adaptive endpoint-packet supply

2026-09-05. Requested Astra xhigh, task
`/root/guard_internal_cover_audit-combined-packet-supply`, source checkpoint
`cdfe75237327e3cc87671de30ca579f3a6fb8612`. Current project configuration,
workflow, policy, and state were read and workflow validation passed, including
after context compaction. Runtime model/effort metadata was not independently
exposed. Only this manuscript and small temporary exact controls were written.

**The proposed two-branch supply statement is false.** The primitive sorted
tuple `N=4, s=(0,1,3,4)`, chosen runner `r=0`, has neither a reciprocal witness
`t=1/d` with `2<=d<=N` nor a cardinality-adaptive endpoint packet of the precise
class below. The packet impossibility covers every positive integer denominator,
every integer endpoint row, and every qualifying collision pair. It reduces
exactly to six rows and 18 pairs, not an arbitrary denominator cutoff.

Nevertheless `t=5/12` and `t=3/7` are original witnesses. This tuple is also
covered by an existing formal bounded-height theorem. The result refutes only
the specified two-branch contract, including its restriction to the retained
finite family. It does not refute a disjunction that also uses existing
height/insertion results, the finite-family obligation F_N, or LRC. This is an
author manuscript awaiting separate independent review, not a new Lean proof.

## The exact contract and what divisor coverage implies

Fix `N>=3`, distinct sorted integers `0=s0<...<s_(N-1)=H`, and a chosen label r.
Let `Delta_i=s_i-s_r`, for `i!=r`. The first branch is

```text
there exists an integer d with 2<=d<=N such that d divides no Delta_i.
```

A nonzero residue modulo d has circle norm at least `1/d>=1/N`, so this
branch supplies the literal time `1/d`. Signs do not affect divisibility or
circle norm. Therefore absence of any chosen-runner witness implies

```text
for every d in {2,...,N}, there exists i!=r such that d divides Delta_i.  (C)
```

This is only a necessary condition. The existing
`LonelyRunner.divisor_cover_of_no_small_witness` in
`SmallDenominatorWitness.lean` records its positive natural-speed version.
That result applies to the absolute comparisons at the original threshold N,
without changing the count by deduplication.

The second branch is the exact class from the frozen adaptive audit:

```text
q>0 is an integer; all u_i are integers; u0=0 and u_last=q;
p=H/q; v_i=s_i-p*u_i; R_i=q*s_i-H*u_i=q*v_i;
sigma_i=sign(Delta_i); W_i=|Delta_i|; U_i=sigma_i*(u_i-u_r).

Choose distinct a,b different from r and set
w_i=(W_a+W_b)*U_i-(U_a+U_b)*W_i.
Require every w_i != 0, and put c=card {|w_i| : i!=r}.
Require |R_i-R_r|/(2H) <= epsilon(c,N)=1/(c+1)-1/N for every i.       (A)
```

Since `w_a=-w_b`, nonvanishing gives `1<=c<=N-2`. All unordered distinct
pairs are permitted; no adjacency restriction or extra rank assumption is
inserted. Reversing a pair leaves w unchanged, and a diagonal pair has a zero
coordinate. A separate q,u,pair may be selected for each chosen runner.

Under H_N (LRC for at most N-2 positive distinct integer moving speeds at
their own count), this remains a valid sufficient branch. Apply H_N directly
to the c distinct positive magnitudes of the integral row w, obtaining tau
with margin `1/(c+1)`. With `alpha=-(U_a+U_b)`, `beta=W_a+W_b`, take
`x=(alpha*p+beta)*tau`, `y_raw=alpha*tau`. Then

```text
tau*w_i = sigma_i*((u_i-u_r)*x+(v_i-v_r)*y_raw).
```

Replace y_raw by `y=y_raw-q*floor(y_raw/q)+q` in `[q,2q)`. The relative
phases change by integers because `q*(v_i-v_r)=R_i-R_r` is integral. Choose
j nearest to `p*y-x` and let `t=(j+x)/p`. The exact identity

```text
Delta_i*t = (u_i-u_r)*j + (u_i-u_r)*x + (v_i-v_r)*y
            + (v_i-v_r)*(t-y),     |t-y|<=1/(2p)
```

and circle norm's Lipschitz inequality give the closed threshold 1/N by (A).
Also `t>=q-1/(2p)=q*(1-1/(2H))>0`. This supplies compatible free phases
explicitly, retains the actual collision count, and covers q>=H as well as
q<H. The present collision row is integral; no denominator-clearing premise
or witness-time rescaling is required here. This conditional construction is
not a proof that the packet exists.

There is a modest exact interaction between (C) and (A). Write
`E_i=R_i-R_r=q*Delta_i-H*(u_i-u_r)` and `T_i=sigma_i*E_i`.
If `d|Delta_i`, then `gcd(d,H)|E_i`, hence also `gcd(d,H)|T_i`.
Consequently `2H*epsilon(c,N)<gcd(d,H)` forces this E_i to be zero for a
valid packet. Eliminating U also gives

```text
H*w_i = W_i*(T_a+T_b)-(W_a+W_b)*T_i.
```

These are local residual constraints, not supply or nonvanishing assertions.
Condition (C) has quantifiers `forall d, exists i`; the same endpoint may
block several denominators. It does not determine the joint residual row or
its collision cardinality. No-witness together with H_N would imply failure
of both sufficient branches; the converse is precisely what this example
disproves.

## Why the finite denominator range is exhaustive

For any packet satisfying (A), c>=1 implies

```text
|R_i-R_r| <= 2H*(1/2-1/N) < H.                              (E)
```

If H divides q, all these integer differences are multiples of H, so they
vanish. R0=0 then gives all R_i=0. Writing q=kH yields u_i=k*s_i, hence
U_i=k*W_i and all w_i=0, a contradiction.

Otherwise write `q=kH+q0` with `0<q0<H` and set `u'_i=u_i-k*s_i`.
The endpoint conditions persist and `q0*s_i-H*u'_i=R_i`. Moreover
`U'_i=U_i-k*W_i`, which leaves every collision vector w exactly unchanged.
Its nonvanishing, cardinality c, and normalized error `|R_i-R_r|/(2H)`
are unchanged. Thus a qualifying packet for any q>0 would give one with
`1<=q0<=H-1`. This uses neither primitivity nor an assumed rank condition;
it does not change the original tuple, count, height, or chosen label.

## The complete counterexample to the supply disjunction

Set `N=4, H=4, s=(0,1,3,4), r=0`. The tuple is primitive and strictly
increasing. It is in the retained inclusive family since `4<=12^2=144`.
Its three comparison magnitudes are `(1,3,4)`. The last label blocks d=2
and d=4; the speed-3 label blocks d=3. Thus the first branch fails. In the
local residual observation above, the d=2,4 restrictions involve an endpoint
whose residual is already zero, while `gcd(3,4)=1` imposes no extra restriction
on the integral residual of speed 3.

For the second branch, c is either 1 or 2, with respective budgets 1/4 and
1/12. Its weaker universal envelope is `|q*s_i-4*u_i|<=2`, since r=0.
The folding proof reduces q to 1,2,3. The exact integer pools are

| q | u1 (speed 1) | u2 (speed 3) | u3 (speed 4) |
| ---: | --- | --- | ---: |
| 1 | 0 | 1 | 1 |
| 2 | 0 or 1 | 1 or 2 | 2 |
| 3 | 1 | 2 | 3 |

Here u0=0. Each pool follows from
`ceil((q*s_i-2)/4)<=u_i<=floor((q*s_i+2)/4)`; in particular the boundary
residuals of absolute value 2 are included. There are exactly six rows.
For the following full collision certificate, comparison coordinates occur
in original label order `(1,2,3)`, with speeds `(1,3,4)`. Column names are
original label pairs, not speeds. `Z` denotes a zero coordinate; every other
entry has exactly c=2 distinct absolute magnitudes.

| q | u=(u0,u1,u2,u3) | R=(R0,R1,R2,R3) | error | w for (1,2) | w for (1,3) | w for (2,3) |
| ---: | --- | --- | --- | --- | --- | --- |
| 1 | (0,0,1,1) | (0,1,-1,0) | 1/8 | (-1,1,0) Z | (-1,2,1) | (-2,1,-1) |
| 2 | (0,0,1,2) | (0,2,2,0) | 1/4 | (-1,1,4) | (-2,-1,2) | (-3,-2,2) |
| 2 | (0,0,2,2) | (0,2,-2,0) | 1/4 | (-2,2,0) Z | (-2,4,2) | (-4,2,-2) |
| 2 | (0,1,1,2) | (0,-2,2,0) | 1/4 | (2,-2,0) Z | (2,-4,-2) | (4,-2,2) |
| 2 | (0,1,2,2) | (0,-2,-2,0) | 1/4 | (1,-1,-4) | (2,1,-2) | (3,2,-2) |
| 3 | (0,1,2,3) | (0,-1,1,0) | 1/8 | (1,-1,0) Z | (1,-2,-1) | (2,-1,1) |

Four pairs fail nonvanishing. The other 14 all have c=2, but their errors
1/8 or 1/4 strictly exceed the required 1/12. No c=1 collision occurs.
Thus no adaptive endpoint packet exists for this chosen runner, over all
positive integer q and all integer u. In particular, allowing separate
packets for different chosen runners cannot repair this instance.

The original comparisons at `t=5/12` have norms `(5/12,1/4,1/3)`, including
the closed boundary. At `t=3/7` they have norms `(3/7,2/7,2/7)`, all strictly
above 1/4. These verify original witnesses independently of H_N.
Moreover `LonelyRunner.boundedHeight_stationary_witness` already covers
the positive injective moving tuple `(1,3,4)`: n=3 and each speed is at most
n+2=5. The example is therefore excluded by an existing proved class.

The specific remaining gap is a justified supply argument on tuples not
already handled by other proved results. Failure of this two-branch statement
alone does not settle its restriction to genuine minimal counterexamples,
and this audit asserts nothing about that stronger restriction. No additional
branch is proposed or tested here, and no unrestricted conclusion follows.

## Exact reproduction and scope

The tuple was obtained analytically, not by a discovery enumeration. The
parent independently obtained it and supplied the strict witness 3/7; the
author supplied 5/12 and checked the full packet certificate. The only
enumeration below is the single fixed tuple, q in 1..3, its six exact envelope
rows, and all three unordered comparison pairs per row. The folding proof
above, rather than computation beyond this domain, establishes universality
in q. No large tuple search, time search, Lean run, dependency restoration,
cache operation, source change, state edit, or Git mutation was performed.

Frozen inputs read:

- `research/astra-cardinality-adaptive-affine-audit.md`, SHA-256
  `a71e55b71e6e6a8a7893c5b3523859d9e51255078c2b17de0ea5cb6b5439a101`.
- `LonelyRunner/SmallDenominatorWitness.lean`, SHA-256
  `1570a359100594f4a5589588e3b32674dc2d54d60e500df1d47aca64c2faf95f`.
- `LonelyRunner/BoundedHeight.lean`, SHA-256
  `681c38dae0158ffd4162fa471c429dea4e8b90e27ee6e3a6fdf7b3cbd6e47ecc`.

Save the following sole Python block, with its trailing newline, as
`/tmp/astra-combined-affine-controls.py`. Run
`python3 -B /tmp/astra-combined-affine-controls.py > /tmp/astra-combined-affine-controls.json`.
The program and JSON SHA-256 values are respectively
`43cecf2e26addcf7d8178c8a746b77b522ef2b0327ccac76ef5ec6b939219df9` and
`ab40c9d3a06fe818f434cc83b678fdd4f2883c3c273557374982148270569340`.

```python
from fractions import Fraction as F
from itertools import combinations, product
from math import ceil, floor, gcd
import json

# One fixed analytical fixture, with the denominator range proved complete
# in the manuscript. This program performs no tuple-discovery search.
N, H, r = 4, 4, 0
s = (0, 1, 3, 4)
I = tuple(i for i in range(N) if i != r)
pairs = tuple(combinations(I, 2))
assert s[0] == 0 and s[-1] == H
assert all(s[i] < s[i + 1] for i in range(N - 1))
assert gcd(*s) == 1 and H <= (N * (N - 1)) ** (N - 2)

divisors = {d: [i for i in I if (s[i] - s[r]) % d == 0]
            for d in range(2, N + 1)}
assert divisors == {2: [3], 3: [2], 4: [3]}
radius = 2 * H * (F(1, 2) - F(1, N))
assert radius == 2

expected = [
    (1, (0, 0, 1, 1), [(-1, 1, 0), (-1, 2, 1), (-2, 1, -1)]),
    (2, (0, 0, 1, 2), [(-1, 1, 4), (-2, -1, 2), (-3, -2, 2)]),
    (2, (0, 0, 2, 2), [(-2, 2, 0), (-2, 4, 2), (-4, 2, -2)]),
    (2, (0, 1, 1, 2), [(2, -2, 0), (2, -4, -2), (4, -2, 2)]),
    (2, (0, 1, 2, 2), [(1, -1, -4), (2, 1, -2), (3, 2, -2)]),
    (3, (0, 1, 2, 3), [(1, -1, 0), (1, -2, -1), (2, -1, 1)]),
]
rows, vector_rows = [], []
zero_count = budget_fail_count = 0
for q in range(1, H):
    pools = [range(ceil((q * s[i] - radius) / H),
                   floor((q * s[i] + radius) / H) + 1)
             for i in range(1, N - 1)]
    for internal in product(*pools):
        u = (0,) + internal + (q,)
        R = tuple(q * si - H * ui for si, ui in zip(s, u))
        error = max(F(abs(R[i] - R[r]), 2 * H) for i in I)
        assert error <= F(1, 2) - F(1, N)
        W = {i: abs(s[i] - s[r]) for i in I}
        U = {i: (1 if s[i] > s[r] else -1) * (u[i] - u[r]) for i in I}
        entries, vectors = [], []
        for a, b in pairs:
            w = tuple((W[a] + W[b]) * U[i] - (U[a] + U[b]) * W[i]
                      for i in I)
            assert w[I.index(a)] == -w[I.index(b)]
            vectors.append(w)
            if 0 in w:
                zero_count += 1
                entries.append({'pair': (a, b), 'w': w, 'result': 'zero'})
            else:
                c = len(set(map(abs, w)))
                margin = F(1, c + 1) - F(1, N)
                assert c == 2 and error > margin == F(1, 12)
                budget_fail_count += 1
                entries.append({'pair': (a, b), 'w': w, 'c': c,
                                'margin': str(margin), 'result': 'budget_fail'})
        vector_rows.append((q, u, vectors))
        rows.append({'q': q, 'u': u, 'R': R, 'error': str(error),
                     'pairs': entries})
assert vector_rows == expected
assert len(rows) == 6 and zero_count == 4 and budget_fail_count == 14

def norm(x):
    f = x - floor(x)
    return min(f, 1 - f)

witnesses = []
for t, wanted in [(F(5, 12), (F(5, 12), F(1, 4), F(1, 3))),
                  (F(3, 7), (F(3, 7), F(2, 7), F(2, 7)))]:
    values = tuple(norm((s[i] - s[r]) * t) for i in I)
    assert values == wanted and min(values) >= F(1, N) and t > 0
    witnesses.append({'t': str(t), 'norms': list(map(str, values))})

# Exact arithmetic premises of the existing bounded-height stationary theorem.
n = N - 1
assert n >= 3 and len(set(s[1:])) == n
assert all(0 < a <= n + 2 for a in s[1:])

print(json.dumps({'fixture': s, 'N': N, 'chosen': r, 'divisor_labels': divisors,
                  'envelope_radius': str(radius), 'rows': rows,
                  'summary': {'endpoint_rows': len(rows), 'pair_checks': 18,
                              'zero_rejections': zero_count,
                              'adaptive_budget_rejections': budget_fail_count,
                              'accepted_packets': 0},
                  'original_witnesses': witnesses}, indent=2, sort_keys=True))
```

Actual outcome: the exact program passed with six endpoint rows and 18 pair
checks: four zero rejections, 14 adaptive-budget rejections, and zero accepted
packets. All three small-denominator obstruction checks, both original rational
witnesses, and the arithmetic hypotheses of the existing bounded-height theorem
passed. Workflow structural validation passed. These are exact finite controls
and a manuscript universality argument, not a Lean verification or an LRC result.

All commands were completed at author freeze. Independent semantic review is
the next required step before accepting this manuscript into a checkpoint.
