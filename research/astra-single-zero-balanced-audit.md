# A balanced cover gives a one-zero endpoint obstruction

Status: complete manuscript construction and exact certificate, 2026-09-05;
independent review pending. The single-step escape candidate is **false even
with exactly one prime-divisible speed**. The example below retains the strict
witness `1/9`, so this is an obstruction to the proposed method, not to LRC.

The root conditional construction was independently checked at
`research/astra-single-zero-escape-followup.md`, SHA-256
`8f25a66d0da002b4cf942016f9584244ed62d390115a3d3800f54d1809f481bd`.
Its mathematical argument is accepted, and its missing cover premise is now
supplied. The earlier local search note was read at
`research/astra-balanced-p13-cover-search.md`, SHA-256
`a9288fc3585a0bce7fbc3caf370d57f7d1d5f7f322078306751a3eb282b9f0d1`.
Its stated near-cover and finite-neighborhood failures concern a different
starting set and do not exclude the new cover. Both embedded root reproducers
were independently rerun: the specified set misses 79 and 90, its 328 allowed
single replacements all fail, and its 28,744 exactly-two-new-row replacements
all fail with at least two uncovered units. These exact local claims pass;
their scope excludes more distant sets such as the new certificate.

Project workflow/policy/state were read and structural validation passed.
Only this file was written; no Lean, source, cache, state, or Git edits were
performed. No comprehensive literature novelty claim is made.

## 1. Conditional construction, with all endpoints retained

Let `p` be an odd prime. Suppose `A` consists of `p-3` positive speeds,
includes 1, and has pairwise distinct nonzero residues modulo `p`. Suppose
its strict bad sets cover every unit numerator modulo `p²`:

`∀ n∈(ℤ/p²ℤ)ˣ, ∃ a∈A, d_{p²}(a*n)<p`,

where `d_m(x)=min(x mod m, -x mod m)`. Put

`D=lcm(A)`, `C=p*D`.

Each `a` divides `D`, and `p∤D`. Therefore `a<C`, `p|C`, and `p²∤C`.
At a unit grid point `n/p²`, row `C` is good. The cover premise guarantees
that a bad row in `A` is present.

At a nonzero prime-grid point `k/p`, `1≤k<p`, the unit rows are good and
`C` is bad. Consider its right endpoint

`t_k^+=k/p+1/(p*C)`.

For `a∈A`, its fractional phase is

`(h+a/C)/p`, where `h=k*a mod p∈{1,...,p-1}`.

There is no wrap because `0<a/C<1`. This phase is bad exactly when `h=p-1`:
then its distance is `1/p-a/(p*C)<1/p`. Otherwise it lies in the closed good
band. Thus `A` blocks precisely the `p-3` distinct indices
`k=-a⁻¹ mod p`. Let the two remaining nonzero indices be `x,y`.

Choose natural representatives

`b=(x-y)⁻¹ mod p∈{1,...,p-1}`,

`q=-b*x mod p∈{1,...,p-1}`, and `B=q*C+b`.

Here `q≠0` because `b,x` are units. Also `B>C`, `p∤B`, and `0<b/C<1`.
At `t_k^+`, the fractional phase for `B` is

`(((b*k+q) mod p)+b/C)/p`.

For `k=x` the residue is zero, so the distance is `b/(p*C)<1/p`.
For `k=y`, the identity `b*y+q=-1 mod p` gives distance
`1/p-b/(p*C)<1/p`. Hence `B` blocks both remaining right endpoints.
Reflection maps `k/p-1/(p*C)` to `(p-k)/p+1/(p*C)` and preserves every
integer-speed distance. It therefore blocks every left endpoint as well.

Now use the full tuple `V=A+(B,C)`. It has `p-1` positive distinct speeds,
gcd one, exactly one speed divisible by `p`, and no speed divisible by `p²`.
Every grid point fails. The possible unique bad owners are exhausted as follows:

* At unit numerators, `A` already contains a bad row, so a unique owner must
  belong to `A`, never to `B` or `C`. For every integer `m` and either sign,
  `C*((m±1/p)/a)=(D/a)*(p*m±1)` is integral. Thus `C` blocks both endpoints
  of every such owner's bad interval.
* At `n=p*k`, `1≤k<p`, every unit row, including `B`, is good, and `C` is
  the unique bad row. Both endpoints have just been blocked.
* At `n=0`, all rows fail, so there is no unique owner.

Periodicity reduces every integer numerator to these cases. A bad row has a
unique nearest integer because its distance is strictly below `1/p<1/2`.
The endpoints above are exactly those of that containing strict bad interval,
and its own distance at either endpoint is exactly `1/p`. No sign or closed
boundary has been omitted.

## 2. The balanced cover is present at p=13

Replace speed 9 in the previous unbalanced ten-row cover by 80. The result is

`S=(1,7,8,10,17,33,36,64,69,80)`.

The exact finite certificate checks all 156 unit numerators modulo 169 and
finds each covered. Its signed modulo-13 class occupancies, in classes 1
through 6, are

`(2,1,2,2,1,2)`.

This supplies the previously missing capacity condition. The root near-cover
was `(1,3,5,7,8,9,11,69,72,76)`; its failures under local replacements were
not failures throughout the space of balanced ten-row sets.

For an odd prime, signed representatives can be oriented to distinct nonzero
residues precisely when each unordered class `{r,-r}` has occupancy at most
two. A double class uses its two opposite residues; a single class uses either.
Different classes do not collide. A common unit multiplier modulo `p²`
permutes both the unit numerators and the signed modulo-`p` classes, so it
preserves covering and the occupancy condition. Multiplying by the inverse
of a selected row first allows it to be 1; that row can retain its orientation.
All signed choices have positive representatives in `1,...,p²-1`.

Here 1 is already present. Replace 33, 36, and 69 by their negatives modulo
169 to obtain

`A=(1,7,8,10,17,136,133,64,100,80)`.

The distinct residues are `1,7,8,10,4,6,3,12,9,2`; the missing speed residues
are 5 and 11. Consequently the two unblocked right-endpoint indices are
`x=5,y=7`. The construction gives

`D=3,617,600`, `C=47,028,800`, `b=6`, `q=9`,

`B=423,259,206=9*C+6`.

The explicit counterexample to the one-zero endpoint assertion is therefore

`V=(1,7,8,10,17,136,133,64,100,80,423259206,47028800)`.

There are 86 unique-bad points on the complete 169-grid and 172 signed
endpoint occurrences; all fail. The owner counts in tuple order are

`(10,8,8,6,8,8,6,8,8,4,0,12)`.

The general proof in Section 1 establishes the endpoint failure. This scan
also verifies the exact original speeds, both signs, and every numerator.
In particular, the auxiliary fast row `B` is never a unique owner.

At the ordinary time `1/9`, the twelve distances are

`(1,2,1,1,1,1,2,1,1,1,3,2)/9`.

Their minimum is `1/9>1/13`. Thus the example is plainly not an LRC
counterexample. The known maximal-zero positive case is consistent with it:
here the sole divisible row `C` is smaller than `B`.

## 3. An unbounded one-zero family with the same strict witness

For every nonnegative integer `h`, put

`C_h=47028800*(1+117*h)`, `B_h=9*C_h+6`, `V_h=A+(B_h,C_h)`.

Since `117=13*9`, the guard retains its residue modulo 169 and modulo 9.
The same holds for `B_h`. Moreover, `C_h/13` is a multiple of every speed in
`A` and is nonzero modulo 13. The construction in Section 1 therefore applies
unchanged, with the same `x,y,b,q`. All admissibility hypotheses hold, and
`B_h>C_h>max(A)` preserves distinctness. Every `V_h` has exactly one
13-divisible speed and no 169-divisible speed.

Each tuple has the same complete grid pattern, hence the same 86 unique-bad
grid points, but all their endpoint attempts fail by the divisibility and
two-residue argument. The distance list at `1/9` is unchanged. This establishes
an unbounded family analytically; testing a few values of `h` is only a control.

## 4. Discovery provenance and exact reproduction

The positive certificate was found by local replacement of the old unbalanced
cover. Its essential discovery step is fully reproducible: keep the other nine
rows, try the signed representatives `1≤a≤84` with `13∤a` in increasing order,
retain capacity-respecting distinct choices, and the 24th tested choice is 80,
which completes the cover. Earlier exploratory work around the separate
near-cover is not used to claim exhaustion or impossibility; its larger search
history is unnecessary to verify this certificate. The unpersisted historical
100,000-proposal report is not relied upon.

The following standard-library block independently checks that discovery step,
the balanced cover, the full construction, all endpoints, the strict witness,
and five controls of the proved family. No project solver or floating-point
arithmetic is used. The cover check is a complete finite-group certificate;
the all-height statement follows from Section 3, not from those five tests.

```python
from collections import Counter
from fractions import Fraction as Q
from math import gcd, lcm

def distance(m, x):
    return min(x % m, (-x) % m)

def norm(t):
    return min(t % 1, (-t) % 1)

p = 13
units = tuple(n for n in range(p*p) if n % p)
columns = tuple(a for a in range(1,85) if a % p)
bad = {a:{n for n in units if distance(169,a*n)<p} for a in columns}
fixed = (1,7,8,10,17,33,36,64,69)
trials = 0
for a in columns:
    if a in fixed:
        continue
    S = tuple(sorted(fixed+(a,)))
    if max(Counter(min(s%p,(-s)%p) for s in S).values()) > 2:
        continue
    trials += 1
    if set.union(*(bad[s] for s in S)) == set(units):
        break
assert trials == 24 and a == 80
assert S == (1,7,8,10,17,33,36,64,69,80)
assert [Counter(min(s%p,(-s)%p) for s in S)[r]
        for r in range(1,7)] == [2,1,2,2,1,2]
A = (1,7,8,10,17,136,133,64,100,80)
assert all(min(a,169-a)==s for a,s in zip(A,S))
assert len({a % p for a in A}) == p-3
assert all(any(distance(169,a*n)<p for a in A) for n in units)
D = lcm(*A)
C = p*D
x,y = [k for k in range(1,p) if all(k*a%p != p-1 for a in A)]
b = pow((x-y)%p,-1,p)
q = (-b*x)%p
B = q*C+b
assert (D,C,B,x,y,b,q) == (3617600,47028800,423259206,5,7,6,9)
expected = [1,2,1,1,1,1,2,1,1,1,3,2]

def check(V):
    assert len(V)==len(set(V))==p-1 and gcd(*V)==1
    assert all(v>0 and v%169 for v in V)
    assert [i for i,v in enumerate(V) if v%13==0] == [11]
    assert [distance(9,v) for v in V] == expected
    assert min(norm(Q(v,9)) for v in V) == Q(1,9) > Q(1,13)
    unique, endpoints = [], 0
    for n in range(169):
        owners = [i for i,v in enumerate(V) if distance(169,n*v)<p]
        assert owners
        if len(owners)!=1:
            continue
        i = owners[0]
        assert i!=10
        unique.append(i)
        m = (2*n*V[i]+169)//338
        assert abs(Q(n*V[i],169)-m)<Q(1,p)
        for sign in (-1,1):
            t = Q(p*m+sign,p*V[i])
            assert norm(V[i]*t)==Q(1,p)
            assert any(norm(v*t)<Q(1,p) for v in V)
            if i<10:
                assert norm(V[-1]*t)==0
            endpoints += 1
    assert len(unique)==86 and endpoints==172
    assert [Counter(unique)[i] for i in range(12)] == \
           [10,8,8,6,8,8,6,8,8,4,0,12]

for h in (0,1,2,13,1000000):
    Ch = C*(1+117*h)
    Bh = 9*Ch+6
    assert Ch%169==C%169 and Bh%169==B%169
    assert all((Ch//13)%a==0 for a in A)
    check(A+(Bh,Ch))
print({'balanced_cover_units':156, 'discovery_trials':trials,
       'unique_per_tuple':86, 'failed_endpoints_per_tuple':172,
       'family_controls':5, 'strict_witness':'1/9 > 1/13'})
```

The block passed with exit status zero. The root conditional proof is sound,
its finite balanced-cover premise is now certified, and the general one-zero
single-step assertion is refuted. No further weakening or search is needed
to settle this particular proposal. A replacement global supply mechanism
and the canonical unrestricted LRC conclusion remain absent.
