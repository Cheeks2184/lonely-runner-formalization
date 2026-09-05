# Independent review of dense two-cluster witnesses

Requested reviewer: Astra xhigh, 2026-09-05. Review base:
`7a5d0d69520a1d290c1dd6c85902488283394d1e`.
Frozen author manuscript: `research/astra-dense-paired-blocks.md`, SHA-256
`004ef46bce4e9062fff7e0a78fbba97ea7c732d134214249a04ac993a344c16e`.
The complete manuscript was read and its hash verified. Current project
configuration, workflow, policy, and state were read; workflow structural
validation passed. Research is active; unrestricted LRC remains unresolved.

**Disposition: accepted at the stated manuscript scope, without correction.**
The general integer-interval equivalence, its exact residue specialization,
and the sufficient all-chosen-runner theorem for arbitrary unequal clusters
are sound. This review supplies independent derivations and fixed rational
controls, not Lean compilation, literature novelty, or unrestricted LRC.

## Exact cell equivalence

Let N>=4 and 1<=a0<=M<p be integers. Set delta=1/N,
`L=delta/a0`, `U=(1-2*delta)/M`,
`ell=p*L-(1-delta)`, and `h=p*U-(1-delta)`.
For fixed integer k, eliminating y from the proposed cell gives precisely

```text
t >= L,       t <= U,
t >= (k+delta)/(p-M),       t <= (k+1-delta)/p.                  (1)
```

All denominators are positive. Necessity of ell<=k follows from the first
and last inequalities. Necessity of k<=h follows from the middle lower
bound and t<=U, using `M*U=1-2*delta`.

Conversely, ell<=k<=h implies L<=U because p>0. Write the second lower
bound in (1) as a and the second upper bound as b. Then ell<=k gives
L<=b; k<=h gives a<=U; and direct multiplication by p(p-M)>0 gives

```text
a<=b  iff M*k<=p*(1-2*delta)-M*(1-delta) iff k<=h.
```

Thus all four lower/upper comparisons hold. The proposed
`t=max(L,(k+delta)/(p-M))` satisfies (1), and `y=p*t-k` satisfies the
original cell. This proves the iff, including reversed or singleton
intervals, and validates the formula for every admitted integer k.
Time is positive because t>=L>0. Moreover y>=M*t+delta>delta>0 and
y<=1-delta<1, so k is the actual floor of p*t. Since ell>-1, admitted
integer k cannot be negative.

The low-speed bound holds for every real a in [a0,M], because
`delta<=a*t<=M*t<=1-2*delta`. For every real b in [0,M], the high phase
has representative `y-b*t` in `[delta,1-delta]`. This includes b=0,
hence p. These are closed bands; no speed-count premise is used here.

The width is exactly `((N-2)*a0-M)/(N*M*a0)`. If positive, the stated
condition p(U-L)>=1 suffices: ceil(ell) belongs to the closed interval
of length at least one. At zero width, M=(N-2)*a0, the only time is
1/(N*a0), y must equal 1-delta, and the exact condition is

```text
p congruent to (N-1)*a0 modulo N*a0.                            (2)
```

For M>(N-2)*a0 the cell is empty. This is a statement about this cell,
not absence of every possible lonely-runner witness.

## Exact residue specialization and closed bounds

For a0=1, write p=N*q+rho, 0<=rho<N. Then
`ell=q+(rho-N+1)/N` is strictly above q-1 and at most q. Hence the
least candidate integer is exactly q, even at rho=0 or rho=N-1.
Multiplying q<=h by N*M>0 gives exactly

```text
p*(N-2-M) >= M*(N-1-rho).                                     (3)
```

This remains a correct iff when M=N-2 or M>N-2: the former reduces to
rho=N-1 and the latter is impossible. Under (3), the time is
`max(1/N,(q+1/N)/(p-M))`. Its first entry dominates exactly when
rho>=M+1, including equality. The residue-independent condition
`p*(N-2-M)>=M*(N-1)` is sufficient when M<N-2 and is weaker than the
interval-length condition with N*M on the right. Neither is necessary.
No strict inequality replaces any displayed closed boundary.

## Every chosen runner and the exact original count

Let A,B be arbitrary finite subsets of `{1,...,M}`, with

```text
N=|A|+|B|+2>=4,     M<N-2,     p>=2M+1,
(p-M)*(N-2-M)>=M*(N-1).
```

The lower cluster `{0} union A` lies in [0,M]. The upper cluster lies in
[p-M,p], above M. The map b->p-b is injective on B, since b<=M<p,
and it never produces p because b>=1. Both internal disjointness and
cross-cluster disjointness therefore hold, proving |T|=N exactly.
A and B are not required to be disjoint as sets of offsets. Empty A or B
is already impossible under the hypotheses: the other set has size at most
M, contradicting `M<|A|+|B|`. There is no extra nonemptiness assumption.

For lower r, put P=p-r. Then `P>=p-M>=M+1`, so the cell's P>M premise
holds. Other lower labels have nonzero integer absolute differences in
[1,M]; upper differences are positive and equal P-b with b in `{0} union B`.
Since D=N-2-M>0,

```text
P*D >= (p-M)*D >= M*(N-1).
```

Thus (3) holds at this P, and the cell controls every required magnitude
at the original delta=1/N. Negation preserves circular norm. Repeated
absolute magnitudes retain the same original N; they justify no stronger
denominator.

For upper r, reflection s->p-s maps T(A,B) bijectively onto T(B,A).
It sends the chosen label to a lower label in the swapped configuration
and every distinct comparison label to a distinct one. The pair (B,A)
satisfies the same hypotheses, including its original N. Its lower-runner
witness transfers through
`(p-s)-(p-r)=-(s-r)`. This is valid even when A!=B and the reflected set
is different. Assuming same-set symmetry in that case would be wrong;
the manuscript does not do so. All signed differences are real/integer
differences, and any natural reflection subtraction is justified by s,r<=p.

The explicit rule using u=r for lower r, u=p-r for upper r, P=p-u,
and the cell time at P follows directly. Testing (3) at every
`u in {0} union A union B` is a valid weaker sufficient hypothesis than
the uniform bound: those are exactly the reflected lower choices. Failed
tests merely leave this construction unavailable.

The every-total-count example is exact. For any N>=4, let M=N-3,
A={1,...,M}, B={1}, and p>=N*(N-3)=N*M. The actual count is
M+1+2=N, D=1, and p-M>=M*(N-1). Also p>=2M+1 since
N*M-(2M+1)=(N-2)*M-1>=0. Thus this supplies a specified family at
every such count, including odd counts. The conclusion remains
`for every chosen runner, some positive time`, not one common time
and not arbitrary speed configurations of that count.

## Comparison and limitation checks

The paired specialization A=B=S substitutes N=2|S|+2 correctly. For
designated zero the general a0=min(S) cell is available, but this does not
automatically handle the smaller differences around a different chosen
runner. Zero-width availability at one reference P does not assert the
all-runner theorem.

The empty-cell example `{0,1,5,6,10,11}` at N=6 has L=1/6>U=2/15,
yet time 1/4 satisfies the designated-zero bound. Its exact norms were
checked below. This refutes necessity of that cell only.

The relevant current Lean contract statements were read without building:
`threeHeight_family_witness`, `fastRunnerInsertion`, and
`minimumScaleResidueBands`, along with the already reviewed mirrored files.
The height theorem requires height at most N+t, t>0, and 3t<=N; its cap
is N+floor(N/3), not 3N. The author's N=7,M=4,p=28 example satisfies
the new bound and exceeds cap 9. No assertion about every bounded-height
theorem or every possible normalization is inferred from that comparison.

Using the complete mirrored block of length M would yield threshold
1/(2M+2), generally weaker than the required 1/N when there are holes.
Conversely the old complete-block result already covers some heights
excluded by this uniform bound. The new sufficient condition does not
improve every old case. The residue-band interfaces still require their
band premises. Fast insertion still requires an old witness and its
factor separation; two high speeds in [p-M,p] have ratio less than two
under p>2M, so inserting one after another does not directly meet its
factor of at least two. These are scoped source comparisons, not a
literature-novelty claim or a proof that every possible composed route fails.

## Independent fixed rational controls

The following program was authored independently. It intersects generic
linear inequalities in t, rather than importing either the author or root
cell checker. The scalar list is explicit and its fixed k-domain includes
every admitted integer. The family list is also explicit. No tuple
discovery, optimization, or Lean work is performed.

```python
from fractions import Fraction as F
from math import ceil, floor
from collections import Counter

c=Counter()
def norm(x):
    return min(x-floor(x),ceil(x)-x)

def feasible_interval(inequalities):
    lower,upper=None,None
    for coefficient,rhs in inequalities:
        assert coefficient!=0
        bound=rhs/coefficient
        if coefficient>0:
            upper=bound if upper is None else min(upper,bound)
        else:
            lower=bound if lower is None else max(lower,bound)
    return lower,upper

cells=[(4,1,1,3),(5,1,2,5),(5,1,2,6),(5,1,2,7),
       (5,1,2,8),(5,1,3,8),(5,1,3,9),(5,2,3,7),
       (5,2,6,8),(5,2,6,9),(5,2,6,18),(5,2,7,8),
       (8,3,4,13),(7,2,7,19),(4,3,3,4),(4,3,3,5)]
for N,a0,M,p in cells:
    assert N>=4 and 1<=a0<=M<p
    d=F(1,N); L=d/a0; U=(1-2*d)/M
    ell,h=p*L-(1-d),p*U-(1-d)
    assert ell>-2 and h<8
    admitted=[]
    for k in range(-2,9):
        left,right=feasible_interval([(-F(1),-L),(F(1),U),
                                      (F(M-p),-k-d),(F(p),k+1-d)])
        assert (left<=right)==(ell<=k<=h)
        if left<=right:
            admitted.append(k)
            assert k>=0
            t=max(L,(k+d)/(p-M))
            assert left==t and L<=t<=U
            y=p*t-k
            assert M*t+d<=y<=1-d and floor(p*t)==k
            lows=[F(a0),F(M),F(a0+M,2)]
            highs=[F(0),F(M),F(M,2)]
            assert all(norm(a*t)>=d for a in lows)
            assert all(norm((p-b)*t)>=d for b in highs)
            c['admitted_integer_checks']+=1
        c['fixed_k_checks']+=1
    exists=bool(admitted)
    assert exists==(ceil(ell)<=h)
    if a0==1:
        assert exists==(p*(N-2-M)>=M*(N-1-p%N))
        if exists: assert min(admitted)==p//N
        c['residue_checks']+=1
    if M==(N-2)*a0:
        assert L==U
        assert exists==((p-(N-1)*a0)%(N*a0)==0)
        c['zero_width_checks']+=1
    if M>(N-2)*a0:
        assert U<L and not exists
        c['negative_width_checks']+=1
    c['cell_present' if exists else 'cell_absent']+=1
    c['scalar_fixtures']+=1

# Exact residue equality can work with integer interval length below one.
N,M,p=5,2,6
assert p*(N-2-M)==M*(N-1-p%N)
assert p*(F(N-2,N*M)-F(1,N))==F(3,5)<1
assert max(F(1,N),(F(p//N)+F(1,N))/(p-M))==F(3,10)
assert norm(p*F(3,10))==F(1,5)

families=[(N-3,set(range(1,N-2)),{1},N*(N-3)) for N in (4,5,9,10,37)]
families += [(3,{1,2},{1,2,3},12),
             (4,{1,3,4},{2,3},28),
             (4,{1,2,3,4},{2,4},18),
             (4,{1,3,4},{2,3},7*10**20+6)]

def config(A,B,p):
    return {0}|A|{p-b for b in B}|{p}

def witness(N,M,p,A,r):
    u=r if r in ({0}|A) else p-r
    P=p-u
    assert 0<=u<=M and P>M
    assert P*(N-2-M)>=M*(N-1-P%N)
    k=P//N
    t=F(1,N) if P%N>=M+1 else (F(k)+F(1,N))/(P-M)
    return t

for M,A,B,p in families:
    N=len(A)+len(B)+2; d=F(1,N)
    assert N>=4 and all(1<=a<=M for a in A|B)
    assert M<N-2 and p>=2*M+1
    assert (p-M)*(N-2-M)>=M*(N-1)
    T,swapped=config(A,B,p),config(B,A,p)
    assert len(T)==N and {p-s for s in T}==swapped
    if A!=B:
        assert T!=swapped
        c['reflection_swap_fixtures']+=1
    for r in T:
        t=witness(N,M,p,A,r)
        assert t>0 and witness(N,M,p,B,p-r)==t
        for s in T-{r}:
            assert norm(t*(s-r))>=d
            assert norm(t*((p-s)-(p-r)))==norm(t*(s-r))
            c['signed_comparisons']+=1
            c['negative_comparisons']+=s<r
            c['closed_equalities']+=norm(t*(s-r))==d
        c['chosen_runners']+=1
        c['duplicate_magnitude_runners']+=len({abs(s-r) for s in T-{r}})<N-1
    c['family_fixtures']+=1
    c['odd_count_fixtures']+=N%2
    c['uniform_equalities']+=(p-M)*(N-2-M)==M*(N-1)

# Original count remains five despite repeated magnitude one around runner1.
T=config({1,2},{1},10); t=witness(5,2,10,{1,2},1)
assert t==F(1,5)
assert {abs(s-1) for s in T-{1}}=={1,8,9}
assert min(norm((s-1)*t) for s in T-{1})==F(1,5)<F(1,4)
# All exact tests can pass even though the uniform sufficient bound fails.
assert (3-1)*(4-2-1)<1*(4-1)
for r in range(4):
    t=witness(4,1,3,{1},r)
    assert t==F(1,4)
    assert all(norm((s-r)*t)>=F(1,4) for s in set(range(4))-{r})
# Empty first-band cell, but an original designated-zero witness exists.
assert F(1,6)>F(4,6*5)
assert all(norm(F(a,4))>=F(1,6) for a in (1,5,6,10,11))
expected={'fixed_k_checks':176,'admitted_integer_checks':12,'residue_checks':7,
          'cell_present':11,'scalar_fixtures':16,'cell_absent':5,
          'zero_width_checks':5,'negative_width_checks':1,
          'signed_comparisons':1708,'negative_comparisons':854,
          'closed_equalities':66,'chosen_runners':94,
          'duplicate_magnitude_runners':52,'family_fixtures':9,
          'odd_count_fixtures':6,'uniform_equalities':8,
          'reflection_swap_fixtures':8}
assert dict(c)==expected
assert c['negative_comparisons']*2==c['signed_comparisons']
print(dict(c))
```

Exact replay from the repository root:

```bash
python3 -B - <<'TWO_CLUSTER_REVIEW'
from pathlib import Path
from hashlib import sha256
import re
author=Path('research/astra-dense-paired-blocks.md')
assert sha256(author.read_bytes()).hexdigest()== \
    '004ef46bce4e9062fff7e0a78fbba97ea7c732d134214249a04ac993a344c16e'
p=Path('research/astra-two-cluster-review.md')
blocks=re.findall(r'^```python\n(.*?)^```[ \t]*$',p.read_text(),re.M|re.S)
assert len(blocks)==1
exec(compile(blocks[0],str(p),'exec'),{})
TWO_CLUSTER_REVIEW
```

The independent controls exited zero: 16 scalar fixtures, 176 fixed-k
equivalences, 12 admitted integers, seven residue checks, five zero-width
congruence checks, and one negative-width fixture. Nine full configurations
gave 94 chosen runners and 1,708 signed comparisons, including 854 negative
differences and 66 attained closed equalities. Eight configurations used
genuinely swapped unequal clusters, eight attained the uniform-bound
equality, and six had odd total count. Fifty-two chosen runners had repeated
absolute magnitudes. The residue-equality, exact-versus-uniform, and
empty-cell controls also passed. These counts are independent of the
author's and root's programs; they support, but do not replace, the proofs.

Only this review manuscript was written. No author, Lean, cache, Git, or
state changes, build, dependency restoration, or discovery search ran.
Formalization is a separate next step. The accepted sufficient theorem
does not reduce arbitrary configurations to these clusters, and failing
its cell or density premises is not an LRC counterexample.
