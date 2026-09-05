# A guard speed defeats single-step escape

Status: complete manuscript counterexample and exact controls, 2026-09-05;
independent review pending. The proposed universal single-step escape is
**false**, even with a strict ordinary witness retained. The obstruction is
symbolic and applies to an unbounded family. It is not a bounded nonfinding or
an LRC counterexample. No Lean formalization is claimed.

Current project policy/state were read and structural validation passed. Only
this file was written; no Lean, state, Git, or cache edits were performed.
The source comparisons used these frozen checkpoints:

| File | SHA-256 |
| --- | --- |
| `research/astra-constant-correction-audit.md` | `0b70fecaf49a7be91da0c49609e35ee56d3603222ac5d20efba9e3339707e9c0` |
| `research/astra-weighted-supply-audit.md` | `64939cae6b8d1019970feb91a4906595e2f0c30472f6485c0d6ae0235da48ee6` |
| `research/astra-prime-square-cover-search.md` | `e6564412dab8c0a112b8f88b1f515da72ce158693c0988cf951df8608d9858bf` |
| `research/astra-vanishing-slope.md` | `f3e2c58177b5f3033afd0d164fbb688eacd30e5f42f39a7bc6ccaec5e82f599e` |
| `LonelyRunner/AffineGridVanishing.lean` | `7bcec521f38f065e03c2f112e4af91f20b3e05b0cedcbc1e6f8f49cca350d5c4` |
| `LonelyRunner/AffineGridFullSize.lean` | `9badca0a324c37a2f9a57c860ab83f9da6e7b8aac922f52e4985352ec57bee54` |

## 1. Exact candidate and the incidence fact

Let `p` be an odd prime and let `V` consist of `p-1` distinct positive speeds
with gcd one. Assume no speed is divisible by `p²`, at least one is divisible
by `p`, and every time `n/p²`, `n∈ℤ`, fails the closed threshold `1/p`.
Call row `i` bad at `t` when `||V_i*t||<1/p`.

The candidate asks whether some grid point with exactly one bad row `i`
has a good endpoint of that row's bad interval. More precisely, let `k` be
the nearest integer to `n*V_i/p²`. Since this row is bad and `1/p<1/2`, `k`
is unique. The interval containing the point is

`((k-1/p)/V_i, (k+1/p)/V_i)`.

Both endpoints are allowed. The candidate asserts that for some such `n,i`,
one of these endpoints has `||V_j*t||≥1/p` for every original row `j`.
Integer-speed periodicity reduces all `n∈ℤ` to `0≤n<p²`; translating `n` by
`p²` translates these endpoints by one. There is no nearest-integer tie or
choice of a different bad component hidden in the criterion.

Write `z` for the number of `p`-divisible rows and `m=p-1-z` for the unit
rows. Fix a nonzero strip `n=pk+j`, `1≤j<p`. The divisible rows are good at
all `p` points, and each unit row is bad at exactly two points. If the strip
is covered, let `U` be the number of points with exactly one bad row. Counting
bad incidences gives

`2m ≥ U+2(p-U)`, hence `U≥2p-2m=2(z+1)`.

This is a valid a priori incidence bound. It does not constrain how quickly a
row that is good on the grid moves off the good region between grid points.

## 2. General guard lemma

Let `A` be positive speeds not divisible by `p` whose bad sets cover every
unit numerator modulo `p²`. Choose a positive integer `L` such that

`a | L` for every `a∈A`, and `p ∤ L`.

Include the speed `C=p*L` and at least one further speed `p*q` with `p∤q`.
Other added divisible rows are permitted, provided none is divisible by `p²`.
Then the complete prime-square grid fails, and **no endpoint in the candidate
can be a witness**.

Indeed, at a unit numerator, every divisible row is good; any unique bad row
must belong to `A`. For any such row `a`, any integer `k`, and either sign,

`C * ((k ± 1/p)/a) = (L/a)*(p*k ± 1) ∈ ℤ`.

Thus `C` is bad, with distance exactly zero, at both endpoints. This statement
covers all bad-interval endpoints of all unit rows, not just the ones nearest
the selected grid. At a nonunit numerator `n=p*k`, both `C` and the second
divisible row are integral, so there is no unique bad row there. These two
cases exhaust every grid point. The unit cover and the divisible rows also
establish complete grid failure.

The obstruction needs only these stated divisibilities. `L` need not be
squarefree; `p∤L` ensures `p²∤C`. Primitivity and distinctness are not used in
the lemma's proof and are checked separately in the admissible example below.
The reason the incidence inference fails is precise: a divisible row which
is good at **every** nonzero strip can still block **every** candidate endpoint.

## 3. An admissible exact counterexample with a strict witness

Use the accepted complete unit cover at `p=13`:

`A=(1,7,8,9,10,17,33,36,64,69)`.

Its least common multiple and a convenient multiple are

`D=lcm(A)=86,708,160`,

`D≡45 (mod 247)`, `45*11≡1 (mod 247)`,

`L=11*D=953,789,760≡1 (mod 247)`.

Take

`V=(1,7,8,9,10,17,33,36,64,69,12399266880,26)`,

where the penultimate coordinate is `C=12,399,266,880=13*L`.

There are exactly twelve distinct positive speeds. The first speed gives gcd
one. The ten rows of `A` are units modulo 13, while `C` and 26 have 13-adic
valuation exactly one. Therefore none is divisible by 169. The new guard is
an allowed independent lift of the old speed 13:

`C = 13 + 3211*3,861,497`, where `3211=169*19`.

The complete 169-grid pattern is unchanged. An exact complete scan gives
98 unique-bad points, all with unit numerators, and 196 signed endpoint
occurrences. The unique-point counts by owner, in the order of `A`, are

`(16,10,10,6,8,14,10,6,8,10)`.

The unique-point counts in strips `j=1,...,12` are

`(10,8,8,8,8,7,7,8,8,8,8,10)`.

Every one of the 196 endpoint occurrences is blocked by `C`, as the general
guard lemma proves without enumeration. At each of the thirteen nonunit
numerators, both divisible rows fail. Thus the failure is not caused by an
absence of unique-bad points, by missing one sign, or by rejecting equality.

The strict original witness `5/19` is preserved. In tuple order the distances
are

`(5,3,2,7,7,9,6,9,3,3,8,3)/19`,

whose minimum `2/19` exceeds `1/13`. Every
`L_h=D*(11+247*h)`, `h∈ℕ`, gives the same obstruction and strict witness after
replacing `C` by `13*L_h`. All unit rows divide `L_h`, and `L_h≡1 (mod 247)`.
This is an unbounded proved family, not an inference from finitely many lifts.

## 4. One-zero controls and a restriction already covered by the old route

For `p=7`, the initial tuple `(1,3,4,5,18,7)` has 36 unique-bad grid points.
Ten signed endpoint occurrences succeed, representing four distinct times
modulo one; one is `19/42`. The guard-like replacement of 7 by
`3780=7+539*7`, divisible by seven times every unit speed, blocks all unit-row
endpoints. Nevertheless, exactly four endpoints owned by the sole divisible
row succeed. For example, `3781/26460` succeeds from `n=7`. There is no second
divisible row to remove these unique-bad nonunit grid points.

For independently lifted coordinates
`(1,3+539*z1,4+539*z2,5+539*z3,18+539*z4,7+539*z5)`, the additional controls
`z=(1,0,2,0,0)` and `z=(2,3,1,4,0)` have respectively 20 and 18 successful
endpoint occurrences. These four exact controls do not prove the candidate
for arbitrary independent lifts.

There is an elementary positive restriction: if there are at most `p-2` unit
rows `a_i` and exactly one divisible row `C` satisfying `a_i≤C` for every `i`,
then an endpoint of a unique-bad prime-grid point works. Choose a nonzero
residue `r` omitted by the `a_i mod p`, and let `k=r⁻¹ mod p`, `1≤k<p`.
Then `a_i*k mod p` lies in `{2,...,p-1}`. At `k/p`, only `C` is bad. At its
left endpoint

`t=k/p-1/(p*C)`,

each unit fractional phase decreases by `a_i/(p*C)≤1/p`. Its new fractional
phase remains in `[1/p,(p-1)/p]`; the divisible phase has distance exactly
`1/p`. No grid-failure assumption is needed. Neither primitivity, distinctness,
nor `p²∤C` is needed for this restricted argument.

This is **not new supply** relative to the project. It is the time reflection
of the unlifted one-zero argument in `research/astra-vanishing-slope.md`,
Section 3. In the `p-1`-row case, existence also follows from compiled
`affine_grid_one_zero_witness` using identity bases `A=U=C`, `a=u=a_i` and
`M=p*C²`. Here `a_i<C` follows from their differing divisibility by `p`.
The coarse hypotheses `p*C≤(p-2)*M` and
`p*a_i*C≤(C-a_i)*M` follow immediately from `C≥1` and `C-a_i≥1`.
The full-size theorem `affine_grid_full_size_witness` does not apply directly
to these identity bases, because its nonzero-slope condition excludes `C`.

The candidate with exactly one divisible row of arbitrary relative height
remains unresolved by this audit. That is a precise narrower question, not an
assumed replacement theorem. The existing maximal-zero result and four controls
do not justify extending it. With multiple divisible rows the unrestricted
single-step proposal is now refuted; any further endpoint-based route needs
a separate reason that a blocking row cannot act as the guard above.

## 5. Independent exact reproduction

This standard-library block verifies the complete counterexample, both signs,
closed endpoints, all 169 numerator classes, the strict witness, four p=7
controls, and 852 controls of the established maximal-zero argument. It imports
no project checker and uses no floating-point decisions. Execute from the repo
root. The bounded positive controls supplement, and do not establish, the
symbolic assertions.

```python
from collections import Counter
from fractions import Fraction as Q
from itertools import combinations
from math import gcd, lcm

def distance(m, x):
    return min(x % m, (-x) % m)

def norm(t):
    return min(t % 1, (-t) % 1)

def endpoint_scan(p, V):
    unique, endpoints, winners = [], [], []
    for n in range(p*p):
        bad = [i for i, v in enumerate(V) if distance(p*p, n*v) < p]
        assert bad, ('grid witness', p, V, n)
        if len(bad) != 1:
            continue
        i = bad[0]
        k = (2*n*V[i]+p*p)//(2*p*p)
        assert abs(Q(n*V[i],p*p)-k) < Q(1,p)
        unique.append((n,i))
        for sign in (-1,1):
            t = Q(p*k+sign, p*V[i])
            assert norm(V[i]*t) == Q(1,p)
            blockers = [j for j,w in enumerate(V) if norm(w*t) < Q(1,p)]
            endpoints.append((n,i,sign,t,blockers))
            if not blockers:
                winners.append((n,i,sign,t % 1))
    return unique, endpoints, winners

p = 13
A = (1,7,8,9,10,17,33,36,64,69)
D = lcm(*A)
L = D*pow(D,-1,247)
C = p*L
V = A+(C,26)
assert (D,L,C) == (86708160,953789760,12399266880)
assert L % 247 == 1 and all(L % a == 0 for a in A)
assert C == 13+3211*3861497
assert len(V) == len(set(V)) == p-1 and gcd(*V) == 1
assert all(v > 0 and v % (p*p) != 0 for v in V)
assert all(any(distance(p*p,a*n) < p for a in A)
           for n in range(p*p) if n % p)
unique, endpoints, winners = endpoint_scan(p,V)
assert len(unique) == 98 and len(endpoints) == 196 and winners == []
assert all(n % p and i < len(A) for n,i in unique)
assert all(10 in blockers and (C*t).denominator == 1
           for n,i,sign,t,blockers in endpoints)
assert [Counter(i for n,i in unique)[i] for i in range(10)] == \
       [16,10,10,6,8,14,10,6,8,10]
assert [Counter(n%p for n,i in unique)[j] for j in range(1,p)] == \
       [10,8,8,8,8,7,7,8,8,8,8,10]
assert [distance(19,5*v) for v in V] == [5,3,2,7,7,9,6,9,3,3,8,3]
assert min(norm(Q(5,19)*v) for v in V) == Q(2,19) > Q(1,p)

base = (1,3,4,5,18,7)
controls = [((0,0,0,0,0),10), ((0,0,0,0,7),4),
            ((1,0,2,0,0),20), ((2,3,1,4,0),18)]
for z, expected_wins in controls:
    V = (1,)+tuple(v+539*k for v,k in zip(base[1:],z))
    unique, endpoints, winners = endpoint_scan(7,V)
    assert len(unique) == 36 and len(winners) == expected_wins
    assert min(norm(Q(5,11)*v) for v in V) == Q(2,11) > Q(1,7)
    if z == (0,0,0,0,0):
        assert len({x[3] for x in winners}) == 4
        assert any(x[3] == Q(19,42) for x in winners)
    if z == (0,0,0,0,7):
        assert all(i == 5 for n,i,sign,t in winners)
        assert any(x[3] == Q(3781,26460) for x in winners)

count = 0
for p in (3,5,7):
    units = [a for a in range(1,2*p) if a % p]
    for A in combinations(units,p-2):
        C = ((max(A)+p-1)//p)*p
        missing = next(r for r in range(1,p) if all(a % p != r for a in A))
        k = pow(missing,-1,p)
        t = Q(k,p)-Q(1,p*C)
        assert [i for i,v in enumerate(A+(C,))
                if norm(v*Q(k,p)) < Q(1,p)] == [len(A)]
        assert all(norm(v*t) >= Q(1,p) for v in A+(C,))
        assert norm(C*t) == Q(1,p)
        count += 1
assert count == 852
print({'counterexample_unique':98, 'counterexample_endpoints':196,
       'counterexample_winners':0, 'p7_controls':4,
       'maximal_zero_controls':count, 'strict_witness':'2/19 > 1/13'})
```

The exact block passed with exit status zero. All universal claims in this
note follow from the displayed divisibility or missing-residue proofs; no
random-lift nonfinding is used. The counterexample prunes one proposed supply
step. It does not resolve the unrestricted conjecture or replace the missing
a priori supply behind the grouped-correction equivalence.
