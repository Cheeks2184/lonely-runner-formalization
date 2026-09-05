# Independent review: the unique-bad endpoint guard

Accepted at manuscript and exact-computation scope, 5 September 2026.
Reviewed source: [astra-unique-bad-escape-audit.md](astra-unique-bad-escape-audit.md),
SHA-256 `ba5a7cadfa259e4a1c4a9928a4986c11a883d35f158f8c121ee3fa0858c0b4d5`.
The complete source, its sole reproducer, and the existing one-zero theorem's
source contract were inspected. All six comparison hashes in its opening table
match the corresponding files. No substantive correction is required. During
review, the two count-vector introductions were clarified to say that they
count unique points. Reversing exactly those two wording changes recovers the
initial frozen hash `4786e39ab8e91e8d14cac654edfac8fead39fad3d7ff7745f7768508f4dfb674`;
all mathematics and executable code are unchanged. Acceptance binds to the
superseding hash above.

This review accepts a counterexample to the specified single-step candidate.
It does not establish an LRC counterexample, a Lean theorem, or a general
endpoint supply principle. The question with exactly one divisible row of
arbitrary relative height remains unresolved **by this frozen audit**. No
assumption or result from a subsequent research note is used here.

## 1. Quantifiers, components, and closed boundaries

The candidate covers every integer numerator, not just a preferred strip.
For integer speeds, replacing `n` by `n+p²` preserves the bad-row labels and
increments the nearest integer for row `v` by `v`. Both component endpoints
therefore increase by one. Checking `0≤n<p²` covers all integer grid points,
including negative ones, without discarding endpoints outside `[0,1)`.

For an odd prime, a bad phase is strictly within `1/p<1/2` of a unique integer
`k`. The two points `(p*k-1)/(p*v)` and `(p*k+1)/(p*v)` are exactly the two
ends of its containing bad component. Both give owner distance `1/p`; equality
is admissible. The manuscript neither chooses another component nor mistakes
an open witness condition for the required closed threshold.

At a nonzero strip `n=p*k+j`, a unit speed takes each of the `p` residues in
one nonzero class modulo `p` as `k` varies. Exactly one lies in `[1,p-1]` and
one in `[p²-p+1,p²-1]`. Thus it has exactly two bad points. A speed `p*q` with
`p∤q` instead has fractional phase `(q*j mod p)/p`, which is always good.
If the strip is covered, counting incidences gives
`2m≥U+2(p-U)` and hence `U≥2(z+1)`. This counting statement is valid but
contains no information about motion away from those grid points.

## 2. The guard proof and the admissible counterexample

For every unit-row speed `a|L`, at either endpoint and for every integer `k`,

`(p*L)*(p*k±1)/(p*a) = (L/a)*(p*k±1)`

is an integer. Consequently the guard has distance zero, strictly below
`1/p`, even though the owner is exactly on the allowed boundary. This blocks
every such endpoint, whether or not its component contains a unique-bad grid
point. At unit numerators a unique bad owner must be a unit row. At nonunit
numerators both divisible rows are integral, so uniqueness is impossible.
Together these cases prove the stated general guard lemma.

The concrete tuple has exactly 12 distinct positive speeds, gcd one, and no
169-divisible speed. Independent arithmetic confirms

`D=86708160`, `D mod247=45`, `45*11 mod247=1`,
`L=953789760`, `C=13*L=12399266880`,
`C=13+3211*3861497`.

The ten unit rows cover all 156 unit numerators modulo 169. The two divisible
rows fail on the 13 remaining numerators. A separately written integer-only
endpoint scan confirms 98 unique-bad grid points, 196 signed endpoint
occurrences, and zero successful occurrences. All 196 are blocked by `C`
with exactly zero guard distance. Both manuscript count vectors are correct:
they count **unique grid points** and sum to 98; the corresponding signed
endpoint counts are twice those vectors.

At `5/19`, the distance numerators are
`(5,3,2,7,7,9,6,9,3,3,8,3)`. Their minimum is `2/19`, exceeding `1/13` by
`7/247`. This directly prevents conflating the candidate's failure with an
ordinary witness failure.

For every `h≥0`, `L_h=D*(11+247*h)` is positive, divisible by every unit
speed, and congruent to 1 modulo 247. Thus `13*L_h` is congruent to 13 modulo
both 169 and 19. It remains larger than the other speeds and has 13-adic
valuation one. The grid pattern, primitivity, distinctness, guard divisibility,
and strict witness all persist for every `h`. The unbounded-family claim
follows algebraically; the five independently evaluated values of `h` are
controls, not the basis of that claim.

## 3. Positive cases and exact scope

The four `p=7` controls independently produce 36 unique-bad grid points each
and respectively `10,4,20,18` successful signed endpoint occurrences. For the
base tuple these are four distinct times, including `19/42`. After replacing
7 by 3780, all four winners belong to the sole divisible row; one is the
endpoint `3781/26460` from numerator 7. The missing second divisible row is
therefore essential to this guard construction. These controls are not a proof
for all one-zero tuples.

The maximal-zero positive lemma is sound. At most `p-2` unit rows leave an
omitted nonzero residue `r`. With `k*r=1 modp`, every unit residue `k*a` lies
in `2,...,p-1`. At `k/p` only the divisible row is bad. Moving left by
`1/(p*C)` decreases each unit phase by at most `1/p`, keeping it in the closed
good interval without wraparound, while the divisible row lands exactly at
distance `1/p`. Empty ordinary families also cause no problem; neither
primitivity nor a grid-failure assumption is needed for this argument.

This is precisely the time reflection of the existing unlifted one-zero
construction: replace its residue by `p-k` and reflect the witness through
`t→1-t`. The compiled `affine_grid_one_zero_witness` contract, inspected without
rebuilding, also applies in the `p-1`-row case with identity bases and
`M=p*C²`. Different divisibility forces `a<C`; therefore

`p*C≤(p-2)*p*C²`,
`p*a*C≤(C-a)*p*C²`

follow from `p≥3`, `C≥1`, and `a≤C-1`. The full-size theorem's all-nonzero
slope hypothesis excludes the distinguished identity base. The author's
classification as existing conditional scope, rather than new unrestricted
supply, is correct. All 852 positive controls and both size inequalities were
independently checked.

## 4. Independent compact reproducer

Unlike the author's nearest-integer formula, this program identifies the
component from integer quotient/remainder and the two strict bad residue
intervals. Endpoint decisions use integer cross-products. `Fraction` only
normalizes reported successful times. No project checker is imported.

```python
from collections import Counter
from fractions import Fraction
from itertools import combinations
from math import gcd, lcm


def distance_numerator(v, n, d):
    r = v*n % d
    return min(r, d-r)


def scan(p, V):
    q = p*p
    patterns, owners, strips = [], Counter(), Counter()
    endpoints, winners = [], []
    for n in range(q):
        bad = tuple(i for i, v in enumerate(V)
                    if p*distance_numerator(v, n, q) < q)
        patterns.append(bad)
        assert bad
        if len(bad) != 1:
            continue
        i = bad[0]
        v = V[i]
        whole, residue = divmod(n*v, q)
        assert residue < p or residue > q-p
        k = whole if residue < p else whole+1
        assert p*abs(n*v-k*q) < q
        owners[i] += 1
        strips[n % p] += 1
        for sign in (-1, 1):
            num, den = p*k+sign, p*v
            assert p*distance_numerator(v, num, den) == den
            blockers = tuple(j for j, w in enumerate(V)
                             if p*distance_numerator(w, num, den) < den)
            endpoints.append((n, i, num, den, blockers))
            if not blockers:
                winners.append((n, i, Fraction(num, den) % 1))
    return patterns, owners, strips, endpoints, winners


A = (1, 7, 8, 9, 10, 17, 33, 36, 64, 69)
D = lcm(*A)
assert D == 86708160 and D % 247 == 45 and 45*11 % 247 == 1
original_pattern = scan(13, A+(13, 26))[0]
for h in (0, 1, 2, 17, 10**9):
    L = D*(11+247*h)
    C = 13*L
    V = A+(C, 26)
    assert len(set(V)) == 12 and gcd(*V) == 1
    assert all(v > 0 and v % 169 for v in V)
    assert L % 247 == 1 and all(L % a == 0 for a in A)
    pattern, owners, strips, endpoints, winners = scan(13, V)
    assert pattern == original_pattern
    assert sum(owners.values()) == 98 and len(endpoints) == 196 and not winners
    assert tuple(owners[i] for i in range(10)) == (16,10,10,6,8,14,10,6,8,10)
    assert tuple(strips[j] for j in range(1,13)) == (10,8,8,8,8,7,7,8,8,8,8,10)
    assert all(n % 13 and i < 10 and C*num % den == 0 and 10 in bad
               for n, i, num, den, bad in endpoints)
    assert all(10 in pattern[n] and 11 in pattern[n] for n in range(0,169,13))
    assert tuple(distance_numerator(v,5,19) for v in V) == \
           (5,3,2,7,7,9,6,9,3,3,8,3)
    assert 13*min(distance_numerator(v,5,19) for v in V) > 19

base = (1,3,4,5,18,7)
for z, count in [((0,0,0,0,0),10), ((0,0,0,0,7),4),
                 ((1,0,2,0,0),20), ((2,3,1,4,0),18)]:
    V = (1,)+tuple(v+539*k for v,k in zip(base[1:],z))
    _, owners, _, _, winners = scan(7,V)
    assert sum(owners.values()) == 36 and len(winners) == count
    assert min(distance_numerator(v,5,11) for v in V) == 2
    if z == (0,0,0,0,0):
        assert len({t for n,i,t in winners}) == 4
        assert any(t == Fraction(19,42) for n,i,t in winners)
    if z == (0,0,0,0,7):
        assert all(i == 5 for n,i,t in winners)
        assert any(n == 7 and t == Fraction(3781,26460) for n,i,t in winners)

count = 0
for p in (3,5,7):
    units = [a for a in range(1,2*p) if a % p]
    for A in combinations(units,p-2):
        C = p*((max(A)+p-1)//p)
        r = next(x for x in range(1,p) if all(a % p != x for a in A))
        k = next(x for x in range(1,p) if x*r % p == 1)
        V = A+(C,)
        assert [i for i,v in enumerate(V)
                if p*distance_numerator(v,k,p) < p] == [len(A)]
        num, den = k*C-1, p*C
        assert all(p*distance_numerator(v,num,den) >= den for v in V)
        assert p*distance_numerator(C,num,den) == den
        M = p*C*C
        assert p*C <= (p-2)*M
        assert all(a < C and p*a*C <= (C-a)*M for a in A)
        count += 1
assert count == 852
print("passed: five guard-family scans each 98/196/0; four p7 controls; "
      "852 maximal-zero cases and formal size conditions")
```

Run with
`python3 -c 'from pathlib import Path; s=Path("research/astra-unique-bad-escape-review.md").read_text(); exec(s.split("```python\n",1)[1].split("```",1)[0])'`.

Both this independent block and the author's block passed, as did
`python3 scripts/validate_workflow.py`. Only this review note was written.
No Lean compilation, cache operation, theorem/source modification, or shared
state/Git edit was performed. The accepted result rules out this particular
single-step supply proposal with multiple divisible rows; it leaves the
unrestricted canonical conjecture unresolved.
