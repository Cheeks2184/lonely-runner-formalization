# A uniform aggregate certificate for actual pivot grids

Task `/root/vanishing_slope-general-sparse-route`, requested Astra/xhigh,
2026-09-05, source checkpoint `8a3a407f729163316a11ffbb863ca9dddf249d36`.
The current configuration, workflow, policy, and active state were read and
the structural validator passed. Only this note was edited. No Lean, Git,
shared-state, dependency, or cache changes and no additional agents were used.

**Disposition:** the unrestricted sparse-owner claim remains open. This pass
derives an exact constant-term sufficient certificate on the **actual
maximum-pivot grid**, including an all-dimension sufficient class with multiple
independent additive relations. The certificate fails on a small genuinely
safe sparse tuple, so no universal supply is asserted. An exact dependent
N=15 example passes this certificate while the old zero-kernel budget and
raw-count bound fail. The manuscript proofs below await independent review;
no new Lean declaration or canonical completion is claimed.

## 1. What the sparse theorem would supply

For N>=3, p>0, and c distinct positive owners d_i<p, write

```text
R={0<=r<Np : N does not divide r},
B_i={r in R : min(rd_i mod Np,-rd_i mod Np)<p}.
```

The proposed uniform assertion is `2c<N => union_i B_i != R`. A surviving
r gives a closed 1/N witness at r/(Np) for the listed owners and the actual
pivot p. It says nothing about unlisted speeds. Existing `OwnerKernelCover`
already gives a sufficient domain

```text
2(N+1)c+(N-2)q <= N(N+1),
```

where q zero-kernel representatives dominate all nonempty kernels. The
accepted N=7 and N=9 arithmetic extends this domain but does not establish
the uniform assertion.

Even the complete uniform sparse theorem would not by itself discharge the
current maximum-covered-pivot bridge. At a maximum covered pivot, every
internal owner has a distinct smaller speed. It would therefore imply that
every internal complete cover has at least `ceil(N/2)` owners. If the number
f of covered original labels satisfies `2(f-1)<N`, there can be no internal
complete cover, and coverwise redundancy is vacuous. In general, however,
there are N-1 moving labels and up to N-2 internal owners. In a hypothetical
all-covered tuple the numerical maximum has exactly that entire pool; for
N>=4, `2(N-2)<N` fails. A minimal internal cover with
`ceil(N/2)<=c<=N-2` is not ruled out.

Counting outside labels makes the remaining bottleneck explicit. A cover
with c owners leaves `o=N-2-c` other nonpivot labels. The sparse theorem
would imply `c-o=2c-(N-2)>=2`. It does not supply an injection from owners
to outside labels, a removable owner, or a new safe residue for the entire
original tuple. Such an exchange or additional existence theorem is the
missing mathematical statement; assuming it would repeat the older supply
gap. This is a limit of the displayed implication, not a proof that no
deeper implication could ever be found.

## 2. Literature motivation and distinct local contribution

Bedert's [Lemma 4.1 in arXiv:2511.16636v1](https://arxiv.org/html/2511.16636v1#S4)
uses the nonnegative product of `1-cos(2 pi v t)` and dissociation to control
its constant term and single-factor deletions. That is the source of the
weighted-product idea, not a new claim of this audit. The exact finite-grid
adapter, pivot-retaining deletion sum, signed-relation accounting, and
independent-triple calculation below are derived here. No literature-priority
claim is made. Rifford's [one-round bound](https://arxiv.org/html/2111.13688v2)
was also checked as a possible lead; a real-time bound alone does not prescribe
the actual grid required here. Neither paper is treated as an unrestricted
LRC proof.

## 3. Exact constant-term certificate, without a field assumption

The following sufficient theorem works beyond the sparse range. Let N>=3,
p>0, and `0<d_i<p` for c labels, with `c+1<=N`. Put
`V=(d_1,...,d_c,p)`, and use the integer Laurent polynomial

```text
H_v(z)=2-z^v-z^(-v),
Q(z)=H_p(z) product_i H_(d_i)(z),
Q_i(z)=H_p(z) product_(j != i) H_(d_j)(z),
A=CT(Q),  S=sum_i CT(Q_i),
gamma_N=2-2 cos(2 pi/N)=4 sin^2(pi/N).
```

**Sufficient theorem.** If `A>gamma_N*S`, then some r in R avoids every
B_i. In particular, the exact integer condition

```text
N^2 A > 40 S                                               (C)
```

suffices. Positivity, lower-owner ordering, the actual pivot, the original
threshold, and the closed boundary all remain in the conclusion. Primality,
oddness, coprimality, zero-slope restrictions, and supplied witnesses are
unnecessary. The polynomial argument even allows repeated lower labels;
the sparse target under investigation keeps them distinct.

**Proof of the exact averaging step.** At `z=exp(2 pi i t)`, every H_v is
`4 sin^2(pi v t)`, hence nonnegative. Every Laurent exponent of Q or Q_i
has absolute value at most `p+sum_i d_i`. For c>0,

```text
p+sum_i d_i < (c+1)p <= Np;
```

for c=0 its degree is p<Np directly. The average of `z^k` over the Np-th
roots of unity is zero unless Np divides k. Since no nonzero exponent in
these polynomials can be a multiple of Np, their averages over the literal
points `t=r/(Np), 0<=r<Np` are exactly their constant terms. There is no
approximation, limiting modulus, or concealed frequency alias.

**Proof of avoidance.** Suppose all r in R were covered. If N divides r,
the pivot factor H_p vanishes; Q and every Q_i vanish there. Otherwise some
lower row has circle distance strictly less than 1/N, so its factor is at
most gamma_N. Nonnegativity gives, pointwise on every grid point,

```text
Q <= gamma_N Q_i <= gamma_N sum_j Q_j.
```

Average this finite inequality using the preceding paragraph to obtain
`A<=gamma_N*S`, a contradiction. For the surviving r, all lower circle
distances are at least 1/N. The pivot has distance at least 1/N because
`r mod N` is in `1,...,N-1`. This preserves equality as safe. Finally
`gamma_N<4 pi^2/N^2<40/N^2`, while S>=0, so (C) implies the exact condition.
All divisions used in this proof have positive denominators.

The ordinary full tuple of N-1 moving speeds also satisfies the degree
hypothesis when its actual largest speed is p. Consequently this adapter is
not intrinsically limited to a sparse family. Its limitation is the supply
of the constant-term inequality, examined below.

## 4. Complete signed-relation formula

Let n=c+1. For each
`epsilon in {-1,0,1}^n` with `sum_j epsilon_j V_j=0`, let k be its total
support size and l the number of supported **lower** labels. Define

```text
w_epsilon = (-1)^k 2^(n-k).
```

Expanding each factor by its three possible exponents gives exactly

```text
A = sum_(zero relations epsilon) w_epsilon,
2S = sum_(zero relations epsilon) (c-l) w_epsilon,
N^2 A-40S = sum_(zero relations epsilon)
                  [N^2-20(c-l)] w_epsilon.                 (R)
```

For the second equality, a relation occurs in the deletion of lower label i
precisely when epsilon_i=0. Its coefficient in that deletion is half its
coefficient in Q. This explains both the factor two and why support on the
pivot must not be counted among the c deletion choices. The formulas include
the zero relation and all possible signs, and do not presume dissociation.

One quantitative sufficient specialization is obtained by putting

```text
Delta = sum_(nonzero signed zero relations) 2^(-k).
```

Then `A>=2^n(1-Delta)` and `S<=c 2^(n-1)(1+Delta)`. Thus

```text
N^2>20c and Delta < (N^2-20c)/(N^2+20c)                    (D)
```

imply (C). This is a sufficient arithmetic restriction, not a conclusion
about the additive relations of arbitrary speed sets. The exact signed
formula (R) is often substantially sharper than this absolute-value bound.

For a dissociated full V, A=2^(c+1) and S=c 2^c, so `N^2>20c` suffices.
Under `2c<N` this inequality holds for every c>=4: at c=4 the smallest
N is 9 and `81>80`; the gap increases thereafter. This is a restricted
all-dimension corollary, not a replacement for the unresolved general sparse
claim or for the stronger literature results on dissociated sets.

## 5. A uniform family with many additive relations

Here is a precise structural hypothesis under which (R) can be evaluated
without assuming full dissociation. Partition the lower speeds into q triples

```text
(x_j, 2x_j, 3x_j),
```

and c-3q singletons, with the pivot also a singleton. Assume every signed
zero relation among all c+1 speeds has zero coefficients on the singletons
and, separately in each triple, coefficients satisfying
`epsilon_1+2epsilon_2+3epsilon_3=0`. This is the **entire hypothesis**:
there are no cross-block signed relations. Within a triple the only choices
are `(0,0,0)`, `(1,1,-1)`, and `(-1,-1,1)`.

The contribution of a complete triple to the constant term is `8-2=6`.
Deleting any one of its factors leaves two distinct frequencies and constant
term 4. Singleton factors contribute 2. The hypothesis ensures these
constant terms multiply across the blocks, giving

```text
A = 6^q 2^(c+1-3q),
CT(Q_i)/A = 2/3  for a lower label in a triple,
CT(Q_i)/A = 1/2  for a lower singleton,
S/A = (c+q)/2.
```

Consequently `N^2>20(c+q)` proves actual-pivot noncover for this class. For
every c>=5, `2c<N` guarantees that inequality for every `q<=floor(c/3)`.
At c=5 the worst q is 1, and `11^2>20*6`. For c>=6,

```text
(2c+1)^2-20(c+c/3)=4c^2-(68/3)c+1>0;
```

its value at c=6 is 9 and it increases for larger c. This proves a uniform
restricted sparse theorem with an unbounded number of allowed additive
relations, rather than a list of new fixed-N cases.

The hypothesis is realizable for arbitrary c and q. Put one triple
`(7^j,2*7^j,3*7^j)` at each of q consecutive digit positions, then put the
remaining singleton lower speeds and finally the pivot at consecutive higher
powers of 7. In a putative signed relation, each digit coefficient has
absolute value at most 6. A nonzero highest digit cannot be canceled by all
lower digits, whose combined absolute value is at most `7^j-1`. Hence every
digit coefficient is zero, proving the stated independence. All lower speeds
are positive, distinct, and below the actual pivot. Common positive scaling
retains the relations and the grid conclusion.

### Exact dependent example beyond the old budget

Take

```text
N=15, p=2303=47*49,
lower owners=(1,705,735,1410,1470,2115,2205).
```

The triples are `(705,1410,2115)=15*47*(1,2,3)` and
`(735,1470,2205)=15*49*(1,2,3)`, with 1 and p isolated. A signed relation
has form `epsilon_0+15*47*a+15*49*b+2303*epsilon_p=0`, where
`|a|,|b|<=6`. Modulo 15 it forces `epsilon_0+8epsilon_p=0`, hence both
coefficients are zero. Dividing by 15 and using coprimality of 47 and 49
then forces a=b=0. There are exactly nine signed zero relations in total.

Here c=7, q=2, A=144, S=648, and

```text
N^2 A-40S = 6480 > 0.
```

This certifies the whole actual pivot grid without searching its points.
The independent literal check supplies the following corroborating values:

```text
bad counts=(4298,4606,4802,4606,4802,4606,4802),
sum=32522, |R|=32242, safe count=13204, first safe r=2307,
distances for the seven owners and pivot at r=2307:
(2307,2820,2940,5640,5880,8460,8820,6909).
```

All eight distances are strictly greater than p. The nonempty zero kernels
have periods 49 and 47; candidates 49 and 47 witness their incomparability,
so two representatives are necessary. The old budget reads
`2*16*7+13*2=250>240`. The raw sum, even after the common-pair saving
`2(c-1)=12`, still exceeds |R|. These are failures of those specified
sufficient tests, not a claim that every older method fails on this tuple.

## 6. Exact obstructions and scope controls

The earlier N=15 single-star remainder bound remains retired. At
`p=272`, star 255 and other 240, the exact remainder is 546, with
`546/p=273/136>91/48`. This is not an integral cover. Pairwise positive
correlation cannot simply replace that bound: at `N=7,p=5,d=1,3`, the two
bad sets have counts 8,8 and intersection 2 in a universe of size 30, so
`30*2<8*8`. A product-of-complements estimate cannot be presumed for arbitrary
literal bad sets. The polynomial certificate instead computes the complete
signed relation structure.

That certificate is itself not universal. The parent supplied the following
control, independently checked here:

```text
N=9, p=5, lower owners=(1,2,3,4), A=12, S=44.
```

Concavity of sine between 0 and pi/6 gives `sin(pi/9)>=1/3`, hence
`gamma_9>=4/9`. Therefore `gamma_9*S>=176/9>12`; even the exact cosine
condition fails, not only the rational bound (C). Yet r=6 modulo 45 is a
strict actual-grid witness with distances `(6,12,18,21,15)`, all greater
than 5. The failure is of the simple factor estimate, not of sparse noncover.
Replacing that estimate by a directly computed weighted good-set indicator
would give a witness-equivalent test, not a new unconditional supply theorem.

The inherited top-two fractional obstruction was also read. Its exact mass
962/241<4 concerns a different two-grid universe and four-owner budget at
N=7. It must not be advertised as a refutation of a single-pivot sparse
dual at c=3. Exploratory single-pivot fractional-cover calculations on twelve
small instances supplied no proof or counterexample and are not promoted
as optimality or negative evidence. No broader search was launched.

## 7. Exact reproducer and input bindings

The code below uses integer Laurent arithmetic and literal finite residues.
It checks the signed-relation identity independently by enumeration on the
two central examples, four small representatives of the all-c family, both
obstructions, the exact dependent certificate, and the strict-degree endpoint
needed for the averaging argument. It imports no project checker and uses
no floating-point approximation.

```python
from collections import defaultdict
from fractions import Fraction as F
from itertools import product, combinations
from math import gcd

def polynomial(V):
    P={0:1}
    for v in V:
        Q=defaultdict(int)
        for exponent,coefficient in P.items():
            Q[exponent] += 2*coefficient
            Q[exponent+v] -= coefficient
            Q[exponent-v] -= coefficient
        P={e:a for e,a in Q.items() if a}
    return P

def constants(V):
    A=polynomial(V).get(0,0)
    S=sum(polynomial(V[:i]+V[i+1:]).get(0,0) for i in range(len(V)-1))
    return A,S

def relation_constants(V):
    n=len(V);c=n-1;A=twiceS=relations=0
    for eps in product((-1,0,1),repeat=n):
        if sum(e*v for e,v in zip(eps,V)):
            continue
        support=sum(e!=0 for e in eps)
        lower_support=sum(e!=0 for e in eps[:-1])
        coefficient=(-1)**support*2**(n-support)
        A+=coefficient
        twiceS+=(c-lower_support)*coefficient
        relations+=1
    assert twiceS%2==0
    return A,twiceS//2,relations

def distance(M,x):
    r=x%M
    return min(r,M-r)

def bad(N,p,d):
    return {r for r in range(N*p) if r%N and distance(N*p,r*d)<p}

for c in range(5,9):
    q=c//3
    lower=[a*7**j for j in range(q) for a in (1,2,3)]
    lower += [7**j for j in range(q,q+c-3*q)]
    p=7**(q+c-3*q)
    V=tuple(lower)+(p,);N=2*c+1
    A,S=constants(V)
    assert len(V)==c+1 and len(set(V))==c+1 and max(lower)<p
    assert A==6**q*2**(c+1-3*q) and 2*S==(c+q)*A
    assert N*N*A>40*S and sum(V)<N*p

N=15
V=(1,705,735,1410,1470,2115,2205,2303)
p=V[-1];c=len(V)-1
assert 2*c<N and 0<min(V) and len(set(V))==len(V)
assert constants(V)==(144,648)
assert relation_constants(V)==(144,648,9)
assert N*N*144-40*648==6480
P=polynomial(V)
assert max(map(abs,P))==sum(V)<N*p
# Root-of-unity averaging keeps precisely exponents divisible by the modulus.
assert sum(a for e,a in P.items() if e%(N*p)==0)==P[0]
R={r for r in range(N*p) if r%N}
B=[bad(N,p,d) for d in V[:-1]]
assert tuple(map(len,B))==(4298,4606,4802,4606,4802,4606,4802)
safe=R-set().union(*B)
assert (sum(map(len,B)),len(R),len(safe),min(safe))==(32522,32242,13204,2307)
assert tuple(distance(N*p,2307*v) for v in V)==(
    2307,2820,2940,5640,5880,8460,8820,6909)
assert min(distance(N*p,2307*v) for v in V)>p
Z=[{r for r in R if r*d%(N*p)==0} for d in V[:-1]]
minimum_q=min(len(J) for q in range(c+1) for J in combinations(range(c),q)
              if all(not X or any(X<=Z[j] for j in J) for X in Z))
assert minimum_q==2 and 2*(N+1)*c+(N-2)*minimum_q==250>N*(N+1)
assert sum(map(len,B))-2*(c-1)>len(R)

V=(1,2,3,4,5)
assert constants(V)==(12,44) and relation_constants(V)==(12,44,15)
assert F(4,9)*44>12
assert tuple(distance(45,6*v) for v in V)==(6,12,18,21,15)
assert min(distance(45,6*v) for v in V)>5
B1,B3=bad(7,5,1),bad(7,5,3)
assert (len(B1),len(B3),len(B1&B3))==(8,8,2)
assert 30*len(B1&B3)<len(B1)*len(B3)
Bs,Bd=bad(15,272,255),bad(15,272,240)
assert (len(Bs),len(Bd),len(Bd-Bs))==(714,672,546)
assert F(546,272)-F(91,48)==F(91,816)>0

# Without strict degree < modulus, the constant term need not equal the grid mean.
M=45
alias={0:2,M:-1,-M:-1}
assert alias[0]==2 and sum(a for e,a in alias.items() if e%M==0)==0
print({'independent_triple_family_controls':4,
       'dependent_certificate':(144,648), 'dependent_margin':6480,
       'dependent_safe_count':len(safe), 'criterion_countercontrol':(12,44),
       'signed_relation_identities':'passed', 'uniform_sparse':'unresolved'})
```

Frozen local mathematical inputs were rechecked at these SHA-256s:

```text
bf4c025bcdcc178f4e9c94884314635e3d26697fe105a9a9a6a55ca1aa60f139  LonelyRunner/OwnerKernelCover.lean
4a9e242429e601f07559a1482031d84f0cc5677a3c128a15481f4003d4f5333e  LonelyRunner/OwnerKernelBound.lean
49131a7f9690042d1b16cbc876417f9d9ce1b53cc6565f87b6d1b53c4e3340cd  LonelyRunner/Prompt99Scaling.lean
a51e581cdf4dc7b37a9b7481e930af00f0605fb4aa0a8aa06d848845fdb99f8f  research/astra-sparse-owner-supply-audit.md
0aacc39cf9dba3147b8002c2b0266309d0a2c57214b38645b246e20718f27684  research/astra-sparse-owner-supply-review.md
4c8459c6629c93f8c98327d5362791bfa86ffd3ca087b74554186db7b2be7844  docs/top-two-fractional-obstruction.md
```

The next substantive problem is not another single-star bound: it is a
uniform treatment of speed sets whose additive relations defeat the simple
factor inequality, together with a bridge that handles the majority-sized
internal covers left by sparse noncover. The displayed N=9 control prevents
assuming that this one constant-term condition supplies that missing step.
The canonical unrestricted conjecture remains unresolved.
