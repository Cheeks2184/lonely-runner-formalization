# Balanced p=13 near-cover: limited reproducible evidence

Status: exploratory follow-up, no balanced cover found or ruled out. The Terra
worker reported a deterministic 100,000-proposal search with seed 20260905,
but did not persist its discovery code after two requests. Consequently that
search history is not independently reproducible and is not used as evidence
for a lower bound or for exhaustion of the stated domain.

The worker supplied the particular candidate
`(1,3,5,7,8,9,11,69,72,76)`. Root independently verified that it misses exactly
unit numerators 79 and 90 modulo 169. Its signed modulo-13 class occupancies
are `{1:1,2:2,3:1,4:2,5:2,6:2}`, so the capacity restriction does hold. Root
also exhausted the 328 admissible one-row replacements around this specified
candidate; none is a cover. This is a complete statement about that finite
neighborhood only. Other ten-row sets, multi-row moves, and other primes are
not excluded. The discovery candidate is not a positive cover certificate.

The following complete root reproducer imports no project solver.

```python
from collections import Counter

A=(1,3,5,7,8,9,11,69,72,76)
U={n for n in range(169) if n%13}
def bad(v):
    return {n for n in U if min(n*v%169,(-n*v)%169)<13}
sets={a:bad(a) for a in range(1,85) if a%13}
assert sorted(U-set.union(*(sets[a] for a in A))) == [79,90]
assert dict(sorted(Counter(min(a%13,(-a)%13) for a in A).items())) == \
       {1:1,2:2,3:1,4:2,5:2,6:2}
count=0
for i in range(10):
    for v in sets:
        if v in A: continue
        T=A[:i]+(v,)+A[i+1:]
        if max(Counter(min(x%13,(-x)%13) for x in T).values())>2: continue
        count+=1
        assert set.union(*(sets[a] for a in T)) != U
assert count==328
print('specified candidate misses79,90; all328 admissible single replacements fail')
```

The potential mathematical use and its unproved antecedent are described in
`astra-single-zero-escape-followup.md`, a separate draft awaiting Astra review.
No canonical Lonely Runner result follows.

## Root follow-up: exact two-row neighborhood

Root also checked every admissible replacement of exactly two selected rows
by two distinct candidates outside the original set. There are 28,744 such
capacity-respecting sets in the signed domain. None covers all units; the
minimum number of uncovered units in this neighborhood is two. This does not
exclude more distant sets. The complete extra reproducer is:

```python
from itertools import combinations
from collections import Counter
A=(1,3,5,7,8,9,11,69,72,76)
U=[n for n in range(169) if n%13]
mask=sum(1<<n for n in U)
B={a:sum(1<<n for n in U if min(a*n%169,(-a*n)%169)<13)
   for a in range(1,85) if a%13}
cls={a:min(a%13,(-a)%13) for a in B}
new=[a for a in B if a not in A]
count=0
best=156
for rem in combinations(A,2):
    base=tuple(a for a in A if a not in rem)
    cc=Counter(cls[a] for a in base)
    bm=0
    for a in base: bm|=B[a]
    for x,y in combinations(new,2):
        if cc[cls[x]]+1+(cls[x]==cls[y])>2: continue
        if cc[cls[y]]+1+(cls[x]==cls[y])>2: continue
        count+=1
        missing=mask&~(bm|B[x]|B[y])
        assert missing
        best=min(best,missing.bit_count())
assert count==28744 and best==2
print('all28744 exactly-two-new-row replacements fail; localbestmissing2')
```
