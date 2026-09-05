# Prime-square cover search

Bounded deterministic pure-Python bitset search, seed `20260905+p`, with at
most 30,000 proposed one-set swaps per prime. The discovery search was reported by the routine worker; its algorithm is
not retained. The exact positive certificate and reported best p=11 set are
independently reproducible below; no search-wide negative conclusion is used.

For `p=11`, the 30,000-swap budget found no cover; best uncovered unit residues
was 4, with selected signed representatives `[1,2,3,5,6,7,8,9]`. This is only a
bounded-search nonfinding.

For `p=13`, the search found a ten-set (`p-3`) cover after 3,456 attempts:

```text
[1,7,8,9,10,17,33,36,64,69]
```

The resulting distinct primitive tuple is

```text
[1,7,8,9,10,17,33,36,64,69,13,26].
```

The search's target bitset is every `n=0..p²-1` with `p ∤ n`; each target bit
is covered by a selected `a` with `min(a*n mod p², -a*n mod p²)<p`. Therefore
for every unit residue there is at least one tuple speed whose phase fails the
closed `1/p` bound; the verification is a full residue scan, not a sampling
claim. This is an exact counterexample in the specified finite model. It makes no
claim about other primes and is not an LRC disproof.

## Independent certificate and consequence

Root checked every residue independently. The ten displayed unit rows cover
every unit numerator modulo 169. Adding speeds 13 and 26 covers the remaining
numerators. Thus `tau_13<=10<11=13-2`, refuting the universal covering lower
bound proposed as an unproved question in the preceding supply audit. It also
refutes universal prime-square-grid supply for tuples with at least two
prime-divisible rows and no prime-square-divisible row.

This is not a counterexample to LRC. At `t=5/19`, the twelve distances in the
displayed order are `(5,3,2,7,7,9,6,9,3,3,8,3)/19`; their minimum `2/19` is
strictly greater than `1/13`. Adding arbitrary nonnegative multiples of
`169*19=3211` to any of the last eleven speeds preserves both this witness
and the complete grid obstruction. Keeping speed1 unchanged preserves gcd1;
the distinct residues modulo169 preserve distinctness.

```python
from fractions import Fraction as Q
from math import gcd
p=13
A=(1,7,8,9,10,17,33,36,64,69)
V=A+(13,26)
def dist(m,x): return min(x % m,(-x) % m)
assert len(set(V))==p-1 and gcd(*V)==1 and all(v % (p*p) for v in V)
assert all(any(dist(p*p,a*n)<p for a in A)
           for n in range(p*p) if n % p)
assert all(any(dist(p*p,v*n)<p for v in V) for n in range(p*p))
assert [dist(19,5*v) for v in V]==[5,3,2,7,7,9,6,9,3,3,8,3]
assert Q(2,19)>Q(1,13)
B=(1,2,3,5,6,7,8,9)
assert [n for n in range(121) if n % 11 and
        all(dist(121,a*n)>=11 for a in B)]==[12,32,89,109]
print('p13 complete cover and strict witness verified; p11 specific-set control verified')
```

Root executed this exact block successfully. The unbounded lift statement
follows from divisibility of3211 by169 and19; finite tests are not used to
infer its quantifiers. Independent Astra review is still required before
this counterexample checkpoint is published.
