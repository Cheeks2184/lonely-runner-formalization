# Independent review: balanced-cover single-zero obstruction

Accepted at manuscript and exact-certificate scope, 5 September 2026.
The entire frozen [author manuscript](astra-single-zero-balanced-audit.md) was
reviewed at SHA-256
`7b47f0748b21708b74c84eddc0a5934cb13f0624174e506c4fc2bd8b0b831d76`.
The root conditional draft at
`8f25a66d0da002b4cf942016f9584244ed62d390115a3d3800f54d1809f481bd`
was treated as a proposal and its argument independently checked. Its missing
cover premise is now supplied by a complete finite certificate. No substantive
correction is required.

This proves the specified single-step endpoint assertion false even with
exactly one prime-divisible row. It settles the narrower question left open
by the preceding frozen two-zero audit; that earlier record was correctly
scoped to its own evidence. It does not disprove LRC, rule out other times or
other grids, or provide a Lean formalization. The canonical unrestricted goal
remains unresolved.

## 1. General conditional argument

For a covered unit numerator `n mod p²`, the guard `C=p*D` is good because
`p∤D*n`. Some row of `A` is strictly bad, so any unique bad owner must belong
to `A`: the additional row `B` cannot be unique there. At either endpoint of
an `A`-owned component, for any integer `m`,

`C*(p*m±1)/(p*a) = (D/a)*(p*m±1)`

is integral. Thus both endpoints are blocked with guard distance zero.

The remaining grid points are `k/p`. For `1≤k<p`, every unit row is good
and `C` alone is bad. At the right endpoint `t=k/p+1/(p*C)`, an `A`-row has
representative `(h+a/C)/p`, where `h=k*a mod p`. Since `0<a/C<1`, it is bad
exactly when `h=p-1`; no phase wraps or meets an ambiguous strict boundary.
Distinct `A` residues therefore block exactly `p-3` of the `p-1` nonzero
indices, leaving two distinct nonzero values `x,y`.

With `b=(x-y)⁻¹` and `q=-b*x` in their stated natural residue ranges,
`b*y+q=-1 mod p`. The term `q` is nonzero. In fact `q≠p-1` too, since
otherwise `b*y=0`; that stronger observation is not needed as an extra
hypothesis. We have `C≥p>b>0`, `B=q*C+b>C`, and `p∤B`. Its endpoint phase is

`(((b*k+q) mod p)+b/C)/p`.

For `x` and `y`, respectively, its distance is `b/(p*C)` and
`1/p-b/(p*C)`. Both are strictly below `1/p`. The residue expression stays
below 1 because `b/C<1`. All other nonzero `k` give a good `B` phase; this
last fact is also checked in the independent controls.

Reflection is simultaneous for every original integer speed:
`||v*(1-t)||=||v*t||`. It sends the left endpoint at `k` to the right
endpoint at `p-k`, so it blocks all left endpoints, with no assumption about
the identity of their blocking row. At the zero grid point every row is bad.
This exhausts all numerator classes. Adding `p²` to a numerator translates
the original time, the nearest-integer component, and both endpoints by one;
negative numerators are covered as well. The nearest integer is unique
because badness is strict and `1/p<1/2`. The owner itself has distance exactly
`1/p` at each tested endpoint, which is allowed.

The construction satisfies all candidate hypotheses: `A` has `p-3` distinct
positive unit rows and includes 1; `C>max(A)` and `B>C`; hence the full tuple
has `p-1` distinct positive speeds, gcd one, exactly one divisible row, and
no `p²`-divisible speed. These conclusions require the balanced-cover premise;
there is no assertion that it exists for every prime.

## 2. Signed normalization and the explicit certificate

For odd `p`, each unit signed class `{r,-r}` has exactly two members. Distinct
oriented residues are possible precisely when every class has at most two
rows: necessity is pigeonhole, and sufficiency assigns opposite signs to a
double class. A prescribed selected row can retain its orientation. A common
unit modulo `p²` permutes unit grid numerators and signed residue classes;
inverting a selected row first makes that row 1. Taking positive modular
representatives produces the required positive integer input.

These operations preserve the **prime-square grid cover**. They do not claim
that changing an actual speed by a multiple of `p²` preserves arbitrary
continuous-time endpoint behavior. The construction and strict witness are
checked on the newly oriented integer tuple itself.

The signed set `(1,7,8,10,17,33,36,64,69,80)` covers all 156 unit numerators
modulo 169 and has signed-class counts `(2,1,2,2,1,2)`. Negating 33, 36, and
69 modulo 169 gives

`A=(1,7,8,10,17,136,133,64,100,80)`.

Its residues are `(1,7,8,10,4,6,3,12,9,2)`, all distinct. The two missing
right-endpoint indices are 5 and 7, so `(b,q)=(6,9)`. Independently evaluated
least-common-multiple arithmetic gives

`D=3617600`, `C=47028800`, `B=423259206=9*C+6`.

For `V=A+(B,C)`, every one of the 169 grid points fails. There are 86
unique-bad points: 74 owned by `A`, 12 by `C`, and none by `B`. All 172
signed endpoint occurrences fail. The manuscript owner vector
`(10,8,8,6,8,8,6,8,8,4,0,12)` counts the 86 unique points; signed endpoint
counts are twice these values. At the right `C` endpoints, `A` blocks ten
indices and `B` blocks exactly the remaining 5 and 7. Independent integer
checks confirmed the reflection identity for every row and every nonzero
index.

At `1/9`, the twelve distance numerators are
`(1,2,1,1,1,1,2,1,1,1,3,2)`. Their minimum is `1/9`, exceeding `1/13` by
`4/117`. Thus the construction has a strict ordinary witness.

## 3. Unbounded family, old positive case, and provenance

For every integer `h≥0`, the factor `1+117*h` is 1 modulo both 13 and 9.
Consequently `C_h=C*(1+117*h)` remains congruent to `C` modulo 169 and 9,
and `B_h=9*C_h+6` remains congruent to `B` modulo both moduli. Moreover,
`C_h/13` is still a positive common multiple of `A`, coprime to 13.
Every step of the conditional proof uses these properties of `D`, not its
minimality as an lcm. The same proof therefore applies to `C_h`, and all
admissibility, endpoint obstruction, and strict-witness properties persist
for every `h`. Equality of grid patterns alone would not prove equality of
endpoint behavior; the guard and two-residue argument supply that step.

The maximal-one-zero positive theorem remains consistent: it requires every
unit speed to be at most the sole divisible speed, whereas `B_h>C_h` here.
The new example addresses the arbitrary-height extension that this older
theorem did not cover. It does not refute the older theorem.

The source's small discovery procedure was replayed: with the stated nine
fixed rows, 80 is the 24th admissible tested representative and supplies a
cover. Both finite-neighborhood controls in
[the earlier near-cover note](astra-balanced-p13-cover-search.md), hash
`a9288fc3585a0bce7fbc3caf370d57f7d1d5f7f322078306751a3eb282b9f0d1`,
were also inspected and replayed. Its particular set misses 79 and 90;
all 328 specified one-row and 28,744 exactly-two-new-row replacements fail.
Those local domains concern a different set. The unpersisted historical
100,000-proposal report is not proof and is not used in this acceptance.

## 4. Independent exact reproducer

This program uses quotient/remainder to choose the actual containing bad
component, independently of the author's nearest-integer formula. All
distance and endpoint decisions use integer cross-products. It imports no
project checker. In addition to five full family scans, it checks the
two-missing-index mapping in 1,012 finite cases and the normalization argument
with each of the ten selected rows. The general conclusions rely on the
proof above, not the finite range of these controls.

```python
from collections import Counter
from math import gcd, lcm


def distance(v, num, den):
    r = v*num % den
    return min(r, den-r)


def scan(p, V):
    modulus = p*p
    pattern, owners, endpoints = [], Counter(), []
    for n in range(modulus):
        bad = tuple(i for i, v in enumerate(V)
                    if p*distance(v,n,modulus) < modulus)
        assert bad
        pattern.append(bad)
        if len(bad) != 1:
            continue
        i = bad[0]
        whole, residue = divmod(n*V[i],modulus)
        assert residue < p or residue > modulus-p
        nearest = whole if residue < p else whole+1
        assert p*abs(n*V[i]-nearest*modulus) < modulus
        owners[i] += 1
        for sign in (-1,1):
            num, den = p*nearest+sign, p*V[i]
            assert p*distance(V[i],num,den) == den
            blockers = tuple(j for j,v in enumerate(V)
                             if p*distance(v,num,den) < den)
            assert blockers
            endpoints.append((n,i,num,den,blockers))
    return pattern, owners, endpoints


p = 13
signed = (1,7,8,10,17,33,36,64,69,80)
A = (1,7,8,10,17,136,133,64,100,80)
assert all(a % 169 in (s % 169,-s % 169) for a,s in zip(A,signed))
assert len({a % 13 for a in A}) == 10
assert tuple(Counter(min(a % 13,-a % 13) for a in signed)[r]
             for r in range(1,7)) == (2,1,2,2,1,2)
for n in range(169):
    if n % 13:
        assert [distance(a,n,169) for a in A] == \
               [distance(a,n,169) for a in signed]
        assert min(distance(a,n,169) for a in A) < 13
D = lcm(*A)
C, B = 13*D, 9*13*D+6
assert (D,C,B) == (3617600,47028800,423259206)
assert [k for k in range(1,13) if all(k*a % 13 != 12 for a in A)] == [5,7]
assert (pow((5-7) % 13,-1,13),(-6*5) % 13) == (6,9)
original_pattern = None
for h in (0,1,2,19,10**9):
    Ch = C*(1+117*h)
    Bh = 9*Ch+6
    V = A+(Bh,Ch)
    assert len(set(V)) == 12 and gcd(*V) == 1
    assert all(v > 0 and v % 169 for v in V)
    assert [i for i,v in enumerate(V) if v % 13 == 0] == [11]
    assert Ch % 169 == C % 169 and Ch % 9 == C % 9
    assert Bh % 169 == B % 169 and Bh % 9 == B % 9
    assert all((Ch//13) % a == 0 for a in A)
    pattern, owners, endpoints = scan(13,V)
    if original_pattern is None:
        original_pattern = pattern
    assert pattern == original_pattern
    assert sum(owners.values()) == 86 and len(endpoints) == 172
    assert tuple(owners[i] for i in range(12)) == (10,8,8,6,8,8,6,8,8,4,0,12)
    for n,i,num,den,bad in endpoints:
        if i < 10:
            assert n % 13 and 11 in bad and Ch*num % den == 0
        else:
            assert i == 11 and n % 13 == 0
    for k in range(1,13):
        num, den = k*Ch+1, 13*Ch
        bad = tuple(i for i,v in enumerate(V) if 13*distance(v,num,den) < den)
        expected = tuple(i for i,a in enumerate(A) if k*a % 13 == 12)
        assert bad == (expected or (10,))
        assert bool(expected) == (k not in (5,7))
        assert all(distance(v,k*Ch-1,den) == distance(v,(13-k)*Ch+1,den)
                   for v in V)
    assert [distance(v,1,9) for v in V] == [1,2,1,1,1,1,2,1,1,1,3,2]
    assert 13*min(distance(v,1,9) for v in V) > 9

mapping_checks = 0
for p in (3,5,7,11,13,17):
    for x in range(1,p):
        for y in range(1,p):
            if x == y:
                continue
            b = pow((x-y) % p,-1,p)
            q = -b*x % p
            assert 1 <= b < p and 1 <= q <= p-2
            assert (b*x+q) % p == 0 and (b*y+q) % p == p-1
            for guard in (p,7*p):
                fast = q*guard+b
                assert fast > guard and 0 < b < guard
                bad = [k for k in range(1,p)
                       if p*distance(fast,k*guard+1,p*guard) < p*guard]
                assert bad == sorted((x,y))
                mapping_checks += 1
assert mapping_checks == 1012

for selected in range(len(signed)):
    multiplier = pow(signed[selected],-1,169)
    changed = [a*multiplier % 169 for a in signed]
    chosen, used = [None]*len(signed), set()
    for i in [selected]+[j for j in range(len(signed)) if j != selected]:
        chosen[i] = next(a for a in (changed[i],169-changed[i])
                         if a % 13 not in used)
        used.add(chosen[i] % 13)
    assert chosen[selected] == 1 and len(used) == 10
    assert all(min(distance(a,n,169) for a in chosen) < 13
               for n in range(169) if n % 13)
print("passed: five family scans each 86 unique/172 blocked; "
      "1012 conditional mappings; 10 normalization/orientation controls")
```

Run with
`python3 -c 'from pathlib import Path; s=Path("research/astra-single-zero-balanced-review.md").read_text(); exec(s.split("```python\n",1)[1].split("```",1)[0])'`.

The author block, this independent block, the two prior local-neighborhood
blocks, and `python3 scripts/validate_workflow.py` all passed. No new search,
Lean/cache operation, shared state/Git edit, or modification outside this
review note was performed. Acceptance is for the exact source hash above and
its stated one-step obstruction, not an unrestricted mathematical resolution.
