# Independent review of the finite-grid product certificate

Task `/root/affine_grid-general-sparse-review`, requested Astra/xhigh,
2026-09-05. The current project configuration, workflow, policy, and active
research state were read; structural validation passed. Only this review
note was edited. No Lean, Git, shared state, imports, cache operations, or
additional agents were used.

**ACCEPT without correction** the complete frozen manuscript
`research/astra-general-sparse-route.md`, SHA-256
`37aac6b4b044504d5ef8c456baa734de1db314edc7e526a0d08080d489c34036`.
I independently derived its product, relation, and family arguments, read its
source bindings, and replayed its sole reproducer. This is acceptance of a
mathematical manuscript, not a Lean theorem or unrestricted supply result.

## 1. Exact finite-grid proof

Fix natural N>=3 and p>0, with c labelled positive lower speeds d_i<p and
c+1<=N. Distinctness is not needed for this sufficient theorem. Set M=Np,
V=(d_1,...,d_c,p), and

```text
H_v(z)=2-z^v-z^(-v),
Q=H_p product_i H_(d_i),
Q_i=H_p product_(j!=i) H_(d_j),
A=CT(Q), S=sum_i CT(Q_i), gamma=4 sin^2(pi/N).
```

The actual original pivot p, every lower row, and the closed target 1/N are
retained. There is no primality, oddness, coprimality, primitive-family,
zero-kernel, or preexisting-witness premise.

Every exponent in Q and Q_i has absolute value at most sum(V). For c>0,
sum(V)<(c+1)p<=Np; for c=0, sum(V)=p<Np. Thus the finite geometric-sum
identity on the M-th roots of unity selects only exponent zero, and the
literal M-point means equal A and the deletion constant terms. This is an
exact finite calculation. A nonzero multiple of M is not silently averaged
away: the strict degree bound excludes it. The aliasing control below shows
why replacing that bound by a non-strict one would be invalid.

At z=exp(2 pi i t), H_v=4 sin^2(pi vt)>=0. All products and their means are
nonnegative, in particular S>=0. On a point r with N|r the pivot factor is
zero, so Q and **every** Q_i vanish. Only lower factors are deleted. On a
candidate r, a strictly bad lower row has circle distance below 1/N. Since
1/N<=1/3<1/2 and sin is increasing on [0,pi/2], that row's factor is at
most gamma. Therefore a complete cover would give pointwise

```text
Q <= gamma*Q_i <= gamma*sum_j Q_j
```

and, after exact averaging, A<=gamma*S. Hence A>gamma*S supplies an actual
candidate avoiding all lower bad sets. The pivot is good because r mod N
lies in 1,...,N-1. Equality at distance 1/N remains good; no time perturbation
or strict-witness premise is used.

The rational sufficient bound N^2*A>40*S is justified without a numerical
approximation: sin(x)<x for x>0 and pi<22/7 give
`gamma<4*pi^2/N^2<40/N^2`, since 1936<1960. For completeness, the standard
bound pi<22/7 itself follows from the positive integral
`integral_0^1 x^4(1-x)^4/(1+x^2) dx=22/7-pi`.
Multiplication by S>=0 is enough, including S=0. The sufficient theorem
also applies to an ordinary N-1-speed tuple at its genuine largest pivot,
but does not prove its constant-term inequality universally.

An independent algebraic check is useful: put P(z)=product_v(1-z^v).
Then Q(z)=P(z)P(z^(-1)), so if P=sum a_e z^e, A=sum a_e^2. The same identity
applies to each deletion. On a finite grid the mean is the sum of squares
of coefficients folded modulo M; the strict degree bound makes that folding
injective on the support of P. The reproducer uses this different expansion
to check the author's Laurent/relation computations.

## 2. Relations, the Delta estimate, and the uniform class

For a signed zero relation epsilon on all n=c+1 labels, let k be total
support, l its lower-label support, and w=(-1)^k 2^(n-k). Expansion gives

```text
A=sum w,   2S=sum (c-l)w,
N^2*A-40*S=sum [N^2-20(c-l)]w.                    (1)
```

The deletion identity is exact: a relation survives deletion i precisely
when epsilon_i=0; its coefficient then loses a factor two. Counting pivot
support as a possible deletion would be wrong. The zero relation, both sign
orientations, relations using the pivot, and repeated labelled speeds are
all included by (1).

Writing Delta=sum_(nonzero relations)2^(-k), absolute values yield
`A>=2^n(1-Delta)` and `S<=c*2^(n-1)(1+Delta)`.
The displayed hypothesis
`N^2>20c` and `Delta<(N^2-20c)/(N^2+20c)` gives
`N^2(1-Delta)>20c(1+Delta)` and therefore N^2*A>40*S.
No assertion that arbitrary tuples satisfy this Delta bound is made.

For q triples (x,2x,3x), with every remaining lower speed and the pivot a
singleton, the no-cross-block hypothesis is explicit and sufficient. It
asserts that **every** signed zero relation vanishes on singletons and has
zero weighted sum within each triple. Conversely, any combination of those
within-triple relations is automatically a full relation. The three choices
in a triple are zero and the two signs of (1,1,-1). Thus the full constant
term factor is 8-2=6. Deleting a triple member leaves factor 4, while deleting
a singleton removes factor 2. It follows exactly that

```text
A=6^q 2^(c+1-3q),  S/A=(c+q)/2.
```

For c>=5, q<=floor(c/3), and 2c<N, N^2>20(c+q). At c=5 the worst case is
121>120. For c>=6, replacing q by c/3 gives the positive quadratic
`4c^2-(68/3)c+1`; its value at six is nine and its successive difference is
`8c-56/3>0`. This is a proof for unbounded c, not an extrapolated small scan.

The base-seven construction realizes the exact hypothesis. Each occupied
digit has a signed coefficient of absolute value at most six. At the highest
nonzero digit j, the term has magnitude at least 7^j, whereas every lower
digit together has magnitude at most `6 sum_(i<j)7^i=7^j-1`. Hence all digit
coefficients vanish. Singleton signs are zero; each triple is internally one
of the three allowed choices. The construction has positive distinct lower
speeds below the final pivot, including q=0, and common positive scaling
preserves its relations. The number of admitted relations, 3^q, is unbounded.
This is a proved restricted existence class, not an assumed decomposition
for arbitrary input speeds.

## 3. Exact fixtures and limits

For N=15 and V=(1,705,735,1410,1470,2115,2205,2303), the lower triples are
705*(1,2,3) and 735*(1,2,3). Modulo 15, a signed relation forces the
coefficients of 1 and p to satisfy epsilon_0+8 epsilon_p=0, which forces both
to vanish. The remaining equation is 47a+49b=0 with |a|,|b|<=6, so coprimality
forces a=b=0. There are nine relations: one empty, four of support three,
and four of support six. Their contributions give A=144, S=648, and rational
margin 6480. Independent subset-square and signed enumeration agree.

Literal bad sets reproduce counts
`(4298,4606,4802,4606,4802,4606,4802)`, candidate count 32242, safe count
13204, and first safe r=2307. The eight distances are exactly
`(2307,2820,2940,5640,5880,8460,8820,6909)`, all strictly larger than p=2303.
The nonempty zero kernels are precisely the candidate multiples of 49 and
of 47. Residues 49 and 47 are actual incomparable-kernel witnesses, so the
minimum number of representatives is two. The old budget exceeds its limit
by ten; the raw sum after the common-pair saving exceeds |R| by 268. These
are exact failures of those particular sufficient tests, not a claim about
every previous method.

For N=9, V=(1,2,3,4,5), independent calculations give A=12 and S=44.
Concavity on [0,pi/6] gives
`sin(pi/9)>= (2/3)sin(pi/6)=1/3`; thus gamma_9*S>=176/9>12. Even the exact
cosine criterion fails. Nevertheless r=6 in the actual 45-grid has distances
`(6,12,18,21,15)`, all strictly above five. This refutes universality of the
displayed criterion, not sparse noncover.

The negative-correlation control also passes: at N=7,p=5 the d=1 and d=3
bad sets have sizes 8,8 and intersection two in a universe of size 30.
Since 60<64, positive correlation and the corresponding product lower bound
for complement intersection cannot be presumed. The N=15 single-star
remainder control and its deliberately limited interpretation agree with the
earlier accepted review. The two-grid fractional example is not repurposed
as a counterexample on this different universe.

### Weighted-good mass versus a weighted-bad sum

The manuscript's witness-equivalence warning is correct for the **good-set
indicator**. Let G be the actual closed-good candidates and let
W_good=M^(-1) sum_G Q. Every Q value on G is strictly positive, including
closed boundary points. Hence W_good>0 is exactly G nonempty.

This must be distinguished from a strengthened weighted-bad union bound.
Let m(r) count bad lower rows and T_bad=M^(-1) sum_r m(r)Q(r). Because Q
vanishes outside the candidate row,

```text
A-T_bad = W_good - M^(-1) sum_(r covered) (m(r)-1)Q(r).   (2)
```

Thus T_bad<A suffices, but requires good mass to exceed the overlap overcount.
It is not the same formula as W_good>0; no converse is asserted here. The
factor argument bounds T_bad by gamma*S. Improving that upper estimate could
add a sufficient domain, while simply evaluating W_good>0 would re-encode
the witness. This distinction does not require changing the author's claims.

## 4. Canonical bridge and primary-source scope

The actual repository owner budget and maximum-covered-pivot definitions
match the manuscript's scope. A uniform sparse theorem would force every
internal complete cover to have c>=ceil(N/2). It would make redundancy
vacuous when 2(f-1)<N for f covered labels. It does not address all possible
c between ceil(N/2) and N-2: for N>=4 the entire nonpivot internal pool of an
all-covered tuple is outside the sparse premise. With o=N-2-c outside labels,
`c-o=2c-(N-2)>=2` is correct (and at least three for odd N). No exchange,
removable-owner, or full-tuple witness follows just from this count.

The attribution to [Bedert, Lemma 4.1](https://arxiv.org/html/2511.16636v1#S4)
was checked in the primary source: it uses a nonnegative Riesz product,
constant terms under dissociation, and single-factor deletions. The present
finite-grid and relation calculations were independently audited above.
The cited [Rifford paper](https://arxiv.org/html/2111.13688v2) concerns real
time bounds; the manuscript correctly does not infer a prescribed pivot grid
from that motivation. No external proof or numerical approximation supplies
the local theorem, and no literature-priority claim is accepted or needed.

## 5. Independent reproducibility and bindings

The author's sole standard-library block was replayed successfully, including
all literal N=15 residues and the prior remainder control. All six hashes in
its input-binding section matched. The independent block below uses
subset-polynomial squares, exhaustive signed relations, literal grids, and
the structural digit test. It covers 792 labelled multisets, 6590 admissible
grids, 3548 successful rational certificates, 348 Delta admissions, and 18
block constructions. Finite controls corroborate, rather than prove, the
unbounded arguments above. No floating-point decisions or project checker
imports are used.

```python
from itertools import product,combinations_with_replacement
from collections import defaultdict
from fractions import Fraction as F
from math import gcd
from pathlib import Path
from hashlib import sha256

path=Path('research/astra-general-sparse-route.md')
assert sha256(path.read_bytes()).hexdigest()==(
    '37aac6b4b044504d5ef8c456baa734de1db314edc7e526a0d08080d489c34036')

def subset_poly(V):
    a={0:1}
    for v in V:
        nxt=defaultdict(int,a)
        for e,w in a.items():
            nxt[e+v]-=w
        a={e:w for e,w in nxt.items() if w}
    return a
def norm2(V):
    return sum(a*a for a in subset_poly(V).values())
def cs(V):
    return norm2(V),sum(norm2(V[:i]+V[i+1:]) for i in range(len(V)-1))
def rel(V):
    n=len(V); c=n-1; A=S2=0; delta=F(0); rs=[]
    for eps in product((-1,0,1),repeat=n):
        if sum(e*v for e,v in zip(eps,V)):
            continue
        k=sum(e!=0 for e in eps); l=sum(e!=0 for e in eps[:-1])
        w=(-1)**k*2**(n-k)
        A+=w; S2+=(c-l)*w; rs.append(eps)
        if k:
            delta+=F(1,2**k)
    assert S2%2==0
    return A,S2//2,delta,rs
def dist(M,x):
    return min(x%M,(-x)%M)

cases=grids=admitted=delta_cases=0
for p in range(1,9):
    for c in range(5):
        for ds in combinations_with_replacement(range(1,p),c):
            V=ds+(p,); A,S=cs(V); ar,sr,delta,rs=rel(V)
            assert (A,S)==(ar,sr)
            assert A>=2**len(V)*(1-delta) and S<=c*2**c*(1+delta)
            P=subset_poly(V)
            for N in range(max(3,c+1),2*c+6):
                M=N*p; assert sum(V)<M
                folded=defaultdict(int)
                for e,w in P.items():
                    folded[e%M]+=w
                assert sum(w*w for w in folded.values())==A
                if N*N>20*c and delta<F(N*N-20*c,N*N+20*c):
                    assert N*N*A>40*S
                    delta_cases+=1
                if N*N*A>40*S:
                    assert any(r%N and all(dist(M,r*v)>=p for v in V)
                               for r in range(M))
                    admitted+=1
                grids+=1
            cases+=1
assert (cases,grids,admitted,delta_cases)==(792,6590,3548,348)

blocks=0
for c in range(9):
    for q in range(c//3+1):
        ds=tuple(a*7**j for j in range(q) for a in (1,2,3))
        ds+=tuple(7**j for j in range(q,q+c-3*q))
        p=7**(q+c-3*q); V=ds+(p,); A,S,delta,rs=rel(V)
        assert len(set(V))==c+1 and all(0<d<p for d in ds)
        assert len(rs)==3**q
        for eps in rs:
            assert all(e==0 for e in eps[3*q:])
            assert all(eps[3*j]+2*eps[3*j+1]+3*eps[3*j+2]==0 for j in range(q))
        assert cs(V)==(A,S)==(6**q*2**(c+1-3*q),F(c+q,2)*6**q*2**(c+1-3*q))
        if c>=5:
            assert (2*c+1)**2*A>40*S
        blocks+=1
assert blocks==18

N=15; V=(1,705,735,1410,1470,2115,2205,2303); p=V[-1]
A,S,delta,rs=rel(V)
assert cs(V)==(A,S)==(144,648) and len(rs)==9
hist=defaultdict(int)
for eps in rs:
    hist[sum(e!=0 for e in eps)]+=1
assert dict(hist)=={6:4,3:4,0:1} and N*N*A-40*S==6480
R={r for r in range(N*p) if r%N}
B=[{r for r in R if dist(N*p,r*d)<p} for d in V[:-1]]
Z=[{r for r in R if r*d%(N*p)==0} for d in V[:-1]]
assert not Z[0]
assert all(Z[i]=={r for r in R if r%49==0} for i in (1,3,5))
assert all(Z[i]=={r for r in R if r%47==0} for i in (2,4,6))
assert 49 in Z[1]-Z[2] and 47 in Z[2]-Z[1]
safe=R-set().union(*B)
assert tuple(map(len,B))==(4298,4606,4802,4606,4802,4606,4802)
assert (len(safe),min(safe))==(13204,2307)
assert sum(map(len,B))-12-len(R)==268
assert 2*16*7+13*2-15*16==10
assert tuple(dist(N*p,2307*v) for v in V)==(2307,2820,2940,5640,5880,8460,8820,6909)
assert cs((1,2,3,4,5))==(12,44)
assert F(4,9)*44>12 and min(dist(45,6*v) for v in (1,2,3,4,5))>5
B1={r for r in range(35) if r%7 and dist(35,r)<5}
B3={r for r in range(35) if r%7 and dist(35,3*r)<5}
assert (len(B1),len(B3),len(B1&B3))==(8,8,2)
assert 30*len(B1&B3)<len(B1)*len(B3)
# Non-strict degree would allow aliasing even for a single nonnegative factor.
P=subset_poly((45,)); folded=defaultdict(int)
for e,w in P.items():
    folded[e%45]+=w
assert sum(w*w for w in P.values())==2 and sum(w*w for w in folded.values())==0
print(dict(multisets=cases,grids=grids,rational_admissions=admitted,
           Delta_admissions=delta_cases,block_controls=blocks,
           dependent_constants=(A,S),dependent_safe=len(safe)))
```

The accepted manuscript and its six local input bindings were rechecked
after all verification. The primary pages were read only for the limited
attribution statements in Section 4. No full literature survey, Lean
formalization, universal constant-term supply, or canonical bridge theorem
is claimed. The precise remaining issues are relation structures defeating
this factor estimate and the majority-sized internal covers left by sparse
noncover. Neither is assumed away in the accepted manuscript.
