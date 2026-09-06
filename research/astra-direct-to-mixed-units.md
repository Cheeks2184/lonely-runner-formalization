# Direct reciprocal witnesses and mixed margins via modular units

2026-09-05. Requested Astra/xhigh task `/root/direct_to_mixed_unit_audit`,
source checkpoint `fd99b6f550bcb931f101ef2186168f1fc09aec4d`. Project workflow,
configuration, policy and current state were read; the structural validator
passed. Research is authorized and canonical LRC is unresolved. Observed runtime
model/effort were not independently exposed. Only this manuscript is owned;
no state, Git, Lean source, other file or cache is changed.

## Exact direct-to-mixed theorem

Let N>=3, let W consist of N-1 sorted distinct positive integers, and H=max W.
D means some integer 2<=d<=N divides no w in W. M means that at one positive
real time T every ||wT||>=1/N and ||HT||>=1/(N-1). No primitiveness is assumed.

**For N=5 and every N>=7, D implies M.** More generally, at any N>=3:
an admissible d<N suffices; an admissible d=N also suffices if gcd(H,N)>1,
or if N has a unit residue other than 1 and -1.

Indeed, if d<N then every nonzero residue w modulo d has circular distance
at least 1/d at T=1/d. Since d<=N-1, all coordinates meet even 1/(N-1).
The time is positive, and equality d=N-1 causes no difficulty.

Otherwise take an admissible d=N. At T=1/N every original norm is >=1/N.
If g=gcd(H,N)>1, the residue r=H mod N satisfies 0<r<N and both r and N-r
are positive multiples of g. Therefore ||H/N||>=g/N>=2/N>=1/(N-1).
The strict exclusion N not dividing H follows from admissibility; it is needed.

If gcd(H,N)=1, choose a unit residue r distinct from +/-1 and let
`k = H^{-1}*r (mod N)`, represented by 1<=k<=N-1. This k is a unit, so
each w*k remains nonzero modulo N. At T=k/N, all original norms remain
>=1/N, while the fastest residue is r. Its least positive representative is
between 2 and N-2, giving ||HT||>=2/N>=1/(N-1). The chosen time is in (0,1).
The norm of an arbitrary ordinary coordinate need not be preserved, but its
nonzero residue and required lower bound are preserved. All coordinates use
the same multiplier k and time T.

## Why the exceptional counts are exactly 3,4,6

For a prime power p^e, exactly p^e-p^(e-1) residues are units. For coprime
moduli the Chinese remainder bijection identifies their unit groups, giving
`phi(N)=product_{p^e || N} p^(e-1)*(p-1)`.
The bijection follows from Bezout inverses and preserves invertibility in
both directions, so this count does not use a computational classification.

If phi(N)<=2, every prime divisor p has p-1<=2; hence N=2^a*3^b.
The same formula forces a<=2 and b<=1, and excludes a=2,b=1 because phi(12)=4.
Thus N is one of 1,2,3,4,6. Conversely their unit counts are 1,1,2,2,2.
For N>=3 the residues +/-1 are distinct units. It follows that a unit besides
them exists exactly when N is not 3,4,6, proving the stated count restriction.

There is also a closed formula for a suitable unit, avoiding any unit search:

```
r_N = (N-1)/2       if N is odd,
r_N = N/2-1         if 4 divides N,
r_N = N/2-2         if N == 2 (mod 4), N>=6.
```

In the odd case gcd((N-1)/2,N)=1. Writing N=2m, if m is even then m-1
is odd and coprime to 2m; if m is odd then m-2 is odd and its gcd with 2m
divides 4, hence is 1. These candidates are the largest units <=N/2: in the
even cases the intervening integers m, and also m-1 when m is odd, are nonunits.
Thus for a unit H the construction can attain the exact largest possible
fastest norm among unit times, `r_N/N`. The value r_N is 1 exactly at N=3,4,6
and at least 2 at every other N>=3. This independently makes the exceptional
count boundary constructive; none of these formulas asserts a global maximum
over all real mixed times.

## Exact modular criterion for several upgraded coordinates

There is a stronger statement inside the unit-reciprocal family. Suppose no
w in a finite collection W is divisible by N, and designate any subset A of
coordinates for the larger threshold 1/(N-1). Neither the collection size nor
the designation of a largest coordinate is needed for this modular claim.
Let U be the units modulo N. For each designated w which is a unit modulo N,
exclude the two multipliers `+w^{-1},-w^{-1}`. Let F be their union.
Designated nonunits exclude nothing: multiplication by a unit keeps their gcd
with N, so their circular residue distance is automatically at least 2.

For k in U, every coordinate already has norm >=1/N. Its norm is an integer
multiple of 1/N, and `1/N < 1/(N-1) <= 2/N`. A designated unit misses the
larger threshold exactly when its product residue is +/-1. Consequently
**one unit-reciprocal time upgrades all designated coordinates iff U\F is
nonempty**. The inverse sign-pairs are identical or disjoint, each of size 2.
If c is their number of distinct pairs, the exact criterion is `2c<phi(N)`.
In particular, fewer than phi(N)/2 designated unit sign-classes can always be
upgraded simultaneously. This criterion is only for T=k/N with k a unit;
its failure is not a proof of global mixed failure.

## Global counterexamples at the three exceptional counts

For the consecutive tuple W={1,...,N-1}, its ordinary good times modulo one
are exactly `T=k/N` with gcd(k,N)=1. To prove necessity, the N points
0,T,...,(N-1)T have pairwise circular distances >=1/N: every nonzero index
difference is a retained speed. Their N cyclic gaps are therefore each >=1/N
and sum to 1, so all equal 1/N. Since 0 is one point, they form the regular
N-grid. Thus T=k/N, and their distinctness forces gcd(k,N)=1. Conversely,
every such unit time makes all retained residues nonzero and is ordinary.

At H=N-1 the fastest norm is ||k/N||. Hence the mixed times for this tuple
are exactly the unit times with k not congruent to +/-1; there are phi(N)-2.
For N=3,4,6 this set is empty, despite the direct witness d=N and the ordinary
positive witness T=1/N. Each tuple is primitive. This proves D does not imply
M at each exceptional count, globally over all real times, not merely within
the reciprocal family. Every ordinary time has at least one norm exactly 1/N,
so these examples have no strict ordinary point and do not refute K.

For the scaled consecutive family `W={a,2a,...,(N-1)a}`, a>=1, scaling time
shows that M exists exactly when N is outside 3,4,6. Every d<N already divides
the retained speed d*a. The remaining d=N is admissible iff gcd(a,N)=1:
if the gcd is 1, N dividing j*a would force N dividing j; if the gcd is g>1,
the index j=N/g lies in 1,...,N-1 and N divides j*a. Therefore, for this entire
family, D-or-M fails exactly when N is 3,4,6 and gcd(a,N)>1. This classifies
the raw-union failures in the stated family, including all positive scales;
it does not classify arbitrary tuples at those counts.

## What changes, and what remains open

For N=5 and N>=7, `D or M` is exactly M, pointwise for every admissible tuple.
The same holds with exact S in place of M after the reviewed stationary S/M
equivalence. A mixed-empty tuple at these counts must have every d=2,...,N
dividing a retained speed. Thus the direct branch supplies no additional
existence theorem at these counts; the remaining global target is uniform M.
This is a reformulation and a restricted construction, not uniform M or LRC.

At N=3,4,6, a tuple with D but without M must have every d=2,...,N-1 covered,
have N divide no retained speed, and have gcd(H,N)=1. These conditions are
necessary, not sufficient. For example N=4,W=(1,2,9) satisfies all of them
but is mixed at T=5/18, with norms (5/18,4/9,1/2). At N=6, W=(1,3,4,5,7)
also satisfies them but is mixed at T=11/24, with norms
(11/24,3/8,1/6,7/24,5/24). No full classification at the exceptions is assumed.

For the still-unresolved strict-to-mixed implication K, any counterexample
with N=5 or N>=7 must lie in the divisor-covered domain. The modular theorem
does not assert that every covered tuple is mixed. Consecutive tuples also
show that M need not imply strict ordinary existence, for example N=5,T=2/5.

## Sole fixed-control reproducer

The S/M reference is `research/astra-mixed-supply-equivalence-review.md`,
SHA-256 `f340c0a311ed6e04d802ee8edfb407a84bc329145bc7e9b446d692cd4e52430a`.
The program guards it, verifies eleven direct conversions, checks the unit
formula at twelve named moduli, and checks six consecutive tuples by complete
closed-band intersection. Seven fixed designated-coordinate controls include
repeated sign-classes, nonunits, and an exhausted unit family. Three positive
exceptional-count controls prevent mistaking necessary conditions for a full
obstruction. Eleven named scaled-consecutive cases check the scaling corollary.
There is no tuple discovery or expanding finite search domain.

```python
from fractions import Fraction as Q
from math import gcd,floor
from pathlib import Path
from hashlib import sha256
import json
assert sha256(Path('research/astra-mixed-supply-equivalence-review.md').read_bytes()).hexdigest()=='f340c0a311ed6e04d802ee8edfb407a84bc329145bc7e9b446d692cd4e52430a'
def norm(x):
 f=x-floor(x)
 return min(f,1-f)
def units(N):return [k for k in range(1,N) if gcd(k,N)==1]
def rmax(N):return (N-1)//2 if N%2 else N//2-1 if N%4==0 else N//2-2
def check(W,T):
 N=len(W)+1
 assert 0<T and all(norm(w*T)>=Q(1,N) for w in W)
 assert norm(W[-1]*T)>=Q(1,N-1)
branches={'small_d':0,'nonunit_H':0,'unit_H':0}
def convert(W,d):
 N=len(W)+1;H=W[-1]
 assert tuple(sorted(set(W)))==W and min(W)>0 and 2<=d<=N and all(w%d for w in W)
 if d<N:T=Q(1,d);kind='small_d'
 elif gcd(H,N)>1:T=Q(1,N);kind='nonunit_H'
 else:
  r=rmax(N);assert r>=2 and gcd(r,N)==1
  k=(pow(H,-1,N)*r)%N
  assert 1<=k<N and gcd(k,N)==1
  T=Q(k,N);kind='unit_H'
  assert norm(H*T)==Q(r,N)
 check(W,T);branches[kind]+=1
 return str(T)
times=[convert(W,d) for W,d in (((1,3),2),((1,2,3,5),4),((1,3,6),4),((1,2,3,4,8),6),((2,4,6,8),5))]
times += [convert(tuple(range(1,N)),N) for N in (5,7,8,10,12,14)]
assert branches=={'small_d':2,'nonunit_H':2,'unit_H':7}
moduli=(3,4,5,6,7,8,9,10,12,14,18,30)
for N in moduli:
 U=units(N);r=rmax(N)
 assert r in U and r<=Q(N,2) and r==max(min(k,N-k) for k in U)
 assert (len(U)==2)==(N in (3,4,6)) and (r==1)==(N in (3,4,6))
def good(W,mixed):
 N=len(W)+1;cells=[(Q(0),Q(1))]
 for w in W:
  d=Q(1,N-1) if mixed and w==W[-1] else Q(1,N)
  bands=[((j+d)/w,(j+1-d)/w) for j in range(w)]
  cells=[(max(l,a),min(r,b)) for l,r in cells for a,b in bands if max(l,a)<=min(r,b)]
 return cells
for N in (3,4,5,6,7,8):
 W=tuple(range(1,N));U=units(N)
 assert good(W,False)==[(Q(k,N),Q(k,N)) for k in U]
 assert good(W,True)==[(Q(k,N),Q(k,N)) for k in U if k not in (1,N-1)]
 assert len(good(W,True))==len(U)-2
 assert all(min(norm(w*Q(k,N)) for w in W)==Q(1,N) for k in U)
 if N in (3,4,6):assert not good(W,True)
designated=((7,tuple(range(1,7)),(1,2)),(7,tuple(range(1,7)),(1,2,3)),(5,tuple(range(1,5)),(1,4)),(5,tuple(range(1,5)),(1,2)),(6,tuple(range(1,6)),(2,3)),(6,tuple(range(1,6)),(5,)),(4,(1,3,6),(6,)))
allowed_counts=[]
for N,W,A in designated:
 assert set(A)<=set(W) and all(w%N for w in W)
 U=set(units(N));pairs={frozenset((pow(w,-1,N),(-pow(w,-1,N))%N)) for w in A if gcd(w,N)==1}
 F=set().union(*pairs) if pairs else set()
 good_units={k for k in U if all(norm(Q(w*k,N))>=Q(1,N-1) for w in A)}
 assert good_units==U-F and len(F)==2*len(pairs)
 assert bool(good_units)==(2*len(pairs)<len(U))
 assert all(norm(Q(w*k,N))>=Q(1,N) for w in W for k in U)
 allowed_counts.append(len(good_units))
assert allowed_counts==[2,0,2,0,2,0,2]
for W,T in (((2,5),Q(3,10)),((1,2,9),Q(5,18)),((1,3,4,5,7),Q(11,24))):
 N=len(W)+1
 assert N in (3,4,6) and gcd(W[-1],N)==1
 assert [d for d in range(2,N+1) if all(w%d for w in W)]==[N]
 check(W,T)
scaled=((3,1),(3,2),(3,3),(4,1),(4,2),(4,3),(6,1),(6,2),(6,5),(5,2),(5,5))
for N,a in scaled:
 W=tuple(a*j for j in range(1,N))
 D=any(all(w%d for w in W) for d in range(2,N+1));M=bool(good(W,True))
 assert D==(gcd(a,N)==1) and M==(N not in (3,4,6))
 assert (not(D or M))==(N in (3,4,6) and gcd(a,N)>1)
print(json.dumps({'status':'PASS','conversion_branches':branches,'converted_times':times,'fixed_moduli':list(moduli),'consecutive_counts':[3,4,5,6,7,8],'designated_allowed_counts':allowed_counts,'positive_exception_controls':3,'scaled_cases':list(scaled)},sort_keys=True,separators=(',',':')))
```

The saved block exited 0 and all controls passed. Its SHA-256 is
`8697cbd8e3828b06e69acc66ba3d366f1ef95a330543f562190d4a6712b24161`.
Exact stdout SHA-256 is
`1730cce7193a1a642637df61ea90f736d2a9f72b80bab1c578101f54cfab15af`.
Both hashes include the final newline. Replay from the repository root:

```sh
python3 -B - <<'DIRECT_MIXED_UNIT_REPLAY'
from pathlib import Path
from hashlib import sha256
from contextlib import redirect_stdout
import io,re
b=re.findall(r'^```python\n(.*?)^```[ \t]*$',Path('research/astra-direct-to-mixed-units.md').read_text(),re.M|re.S)
assert len(b)==1 and sha256(b[0].encode()).hexdigest()=='8697cbd8e3828b06e69acc66ba3d366f1ef95a330543f562190d4a6712b24161'
out=io.StringIO()
with redirect_stdout(out):exec(compile(b[0],'direct-to-mixed-unit-controls','exec'),{})
assert sha256(out.getvalue().encode()).hexdigest()=='1730cce7193a1a642637df61ea90f736d2a9f72b80bab1c578101f54cfab15af'
print(out.getvalue(),end='')
DIRECT_MIXED_UNIT_REPLAY
```

Proof and scope were saved before their fixed controls. Final saved-block
replay, readback and workflow structural validation passed. All owned commands
are stopped at handoff. Only this manuscript was written; no Git, state, other
source, Lean build output or cache was changed. Its final artifact hash is
reported separately. Independent manuscript review remains required; the
unrestricted canonical proof/disproof objective is still unresolved.
