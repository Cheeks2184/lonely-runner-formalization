# Independent review of the mirrored-block witness

Reviewer: requested Astra xhigh, 2026-09-05. Source checkpoint:
`8db7eb32fb0aec5f1a62d18f93a72c5096d76743`.
Reviewed author artifact: `research/astra-mirrored-block-witness.md`, SHA-256
`70b5545b8b7af311324967c7272a07f8d714eeabac2b21c381ae168326847e21`.
The hash was verified before review. Current configuration, workflow, policy,
and state were read, and workflow structural validation passed. Research is
authorized; the unrestricted canonical goal remains unresolved.

**Disposition: accepted at the exact manuscript contract.** For every integer
m>=1 and p>=2m+1, the displayed formula gives a positive real time at which
every moving speed in `{1,...,m} union {p-m,...,p-1} union {p}` is at circle
distance at least `1/(2m+2)` from the designated stationary runner zero.
There is no missing number-theoretic or induction premise. This acceptance
is a manuscript review, not a Lean build or axiom audit.

## Cardinality, division, and quantifiers

The low block has m elements. The high block `{p-m,...,p-1}` also has m
elements, since p>=2m+1 implies p-m>=m+1>0. Its minimum exceeds the low
block's maximum m, and its maximum is below p. Thus the union has exactly
2m+1 distinct positive moving speeds. Adding stationary zero gives exactly
N=2m+2 total runners, with delta=1/N>0.

N is a positive integer, so Euclidean division gives unique integers k,r
with p=N*k+r and 0<=r<N. Here p>0, so k>=0. Integrality makes the two
branches r>=m+1 and r<=m exhaustive and disjoint. The denominator p-m is
positive. All divisions defining t, delta, and the phases are in the rationals
or reals; they are not truncated integer divisions. A Lean implementation
must retain that distinction and justify any cast of the natural difference
p-m using p>=m.

The theorem directly concerns the original moving speeds relative to fixed
zero. It does not prove that every chosen runner in the same configuration
is lonely by this formula. Such a statement would require checking the
chosen runner's relative speeds separately. The family has unbounded odd
moving counts 2m+1 and even total counts N; it is not an unrestricted-count
or arbitrary-speed theorem.

## Independent direct proof of both formulas

Suppose first that r>=m+1 and let t=delta. For 1<=i<=m, the low-speed
representative i/N lies in `[delta,1-delta]`. For the original high speed
p-i, subtract integer k to obtain `(r-i)/N`. Since

```text
1 <= r-i <= N-2,
```

that representative also lies in the closed good band. For p itself the
representative r/N lies between `(m+1)/N` and `(N-1)/N=1-delta`.
Thus this case checks every original speed directly.

Now suppose r<=m. Put q=p-m>0 and define the proposed real time

```text
t = (N*k+1)/(N*q) = (k+delta)/q.
```

Using p=N*k+r gives the exact identity

```text
t-delta = (m+1-r)/(N*(p-m)).                                    (1)
```

The numerator is between 1 and m+1, while p-m>=m+1. Hence
`0<t-delta<=delta`, so `delta<t<=2*delta` and t>0. The formula's essential
identity is

```text
(p-m)*t = k+delta.                                              (2)
```

For each original high speed p-i with 1<=i<=m, (2) gives representative

```text
(p-i)*t-k = delta+(m-i)*t.
```

It is at least delta and at most `(2m-1)*delta<=1-delta`. For p itself,
the representative is `delta+m*t`, between delta and
`(2m+1)*delta=1-delta`. Finally, for each low i the representative i*t is
at least delta and at most `2m*delta=1-2*delta<1-delta`. Every displayed
representative is in the actual closed unit good band; subtracting integer
k for the high block and p preserves circle distance.

This proves the formula without assuming a witness for any smaller or
complemented tuple. It independently confirms the author's sufficient cell:
in the first case y=r/N, and in the second y=delta+m*t. In both cases
`p*t=k+y`, `delta<=t<=2*delta`, and `m*t+delta<=y<=1-delta`. Since
0<y<1, the Euclidean quotient k is also the floor of p*t. No hidden phase
wrap or change of distinguished runner occurs.

## Boundaries and limits

At the minimal p=2m+1=N-1, k=0 and r=N-1; the first branch gives t=1/N
for the consecutive family `{1,...,N-1}`. The r=0 case uses the second
branch with a nonzero denominator. Both sides of the split, r=m and r=m+1,
are included. The proof works for m=1, without needing a smaller nonempty
interior high block.

The closed threshold is essential to this formula: in the first branch
speed 1 has norm exactly delta, and in the second branch speed p-m has
norm exactly delta by (2). Thus replacing the conclusion by strict
distance greater than delta would reject the displayed witness. This does
not claim that no other time can have a larger minimum for the same tuple.

There are no restrictions on gcd, primality, or the size of k. The argument
does not replace m by the maximum of an arbitrary sparse block while
retaining the count, nor promote the bound to the stronger canonical margin
of a smaller subfamily. No literature-novelty claim is reviewed or made.

## Independent exact replay

The following fixed list checks the actual original speed norms, not just
the sufficient phase inequalities. It covers both branches, minimal p,
zero quotient, r=0, both split boundaries, and four large fixtures. These
are deterministic controls of the specified formula, not discovery over
speed tuples. No author or root verification program was imported.

```python
from fractions import Fraction as F
from math import floor

fixtures=[(1,3),(1,4),(1,5),(1,6),
          (2,5),(2,6),(2,8),(2,9),
          (3,11),(3,12),
          (17,35),(17,36),(17,53),(17,54),
          (997,1996*10**12+997),(997,1996*10**12+998),
          (4096,8194*10**20),(4096,8194*10**20+8193)]
c={'fixtures':0,'first_branch':0,'second_branch':0,'original_speed_checks':0,
   'boundary_minima':0,'minimal_p':0,'zero_quotient':0}

def norm(x):
    z=x-floor(x)
    return min(z,1-z)

for m,p in fixtures:
    assert m>=1 and p>=2*m+1
    N=2*m+2
    k,r=divmod(p,N)
    d=F(1,N)
    first=r>=m+1
    t=d if first else F(N*k+1,N*(p-m))
    # Verify actual speeds, cardinality, and canonical closed distances.
    A=tuple(range(1,m+1))+tuple(range(p-m,p+1))
    assert len(A)==len(set(A))==2*m+1
    assert min(A)>0 and max(A)==p
    values=[norm(a*t) for a in A]
    assert all(z>=d for z in values)
    assert min(values)==d
    assert t>0 and d<=t<=2*d
    assert p*t-k==p*t-floor(p*t)
    y=p*t-k
    assert m*t+d<=y<=1-d
    if first:
        assert t==d and y==F(r,N)
    else:
        adjustment=F(m+1-r,N*(p-m))
        assert 0<adjustment<=d and t==d+adjustment
        assert (p-m)*t==k+d and norm((p-m)*t)==d
    if p==2*m+1:
        assert A==tuple(range(1,N)) and first and t==d
    c['fixtures']+=1
    c['first_branch' if first else 'second_branch']+=1
    c['original_speed_checks']+=len(A)
    c['boundary_minima']+=min(values)==d
    c['minimal_p']+=p==2*m+1
    c['zero_quotient']+=k==0
assert c=={'fixtures':18,'first_branch':9,'second_branch':9,
           'original_speed_checks':20562,'boundary_minima':18,
           'minimal_p':3,'zero_quotient':3}
print(c)
```

Exact replay from the repository root:

```bash
python3 -B - <<'MIRRORED_REVIEW'
from pathlib import Path
from hashlib import sha256
import re
author=Path('research/astra-mirrored-block-witness.md')
assert sha256(author.read_bytes()).hexdigest()== \
    '70b5545b8b7af311324967c7272a07f8d714eeabac2b21c381ae168326847e21'
p=Path('research/astra-mirrored-block-review.md')
blocks=re.findall(r'^```python\n(.*?)^```[ \t]*$',p.read_text(),re.M|re.S)
assert len(blocks)==1
exec(compile(blocks[0],str(p),'exec'),{})
MIRRORED_REVIEW
```

Observed result: exit zero; 18 fixtures, nine per branch, 20,562 actual-speed
checks, 18 attained boundary minima, three minimal-p cases, and three zero
quotients. These finite checks support the review but are not the universal
proof; the parameter-uniform derivation above supplies that manuscript proof.

Only this review file was written. No author, Lean, cache, state, or Git
changes were made, and no build or dependency restoration ran. The next step
may be a faithful Lean implementation and separate trust/contract review.
No unrestricted LRC resolution follows from this acceptance.
