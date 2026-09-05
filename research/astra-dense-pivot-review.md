# Independent review of dense insertion and trapped components

Reviewer task `/root/nearest_grid_audit`, reassigned to review the other
author's dense manuscript, requested in-session Astra/xhigh, 2026-09-05.
Base source: `808595cf7615d01f849eb071648d8a82ee7c97c1`.
Current configuration, workflow, policy, and active state were read;
`python3 scripts/validate_workflow.py` passed. This reviewer owns only this
review file for this task and did not modify the author manuscript, Lean,
shared state, Git, dependencies, or build cache. No Lean build or broad scan
was run. The reviewer authored the separate nearest-grid manuscript, but
did not author the dense manuscript reviewed here.

**Disposition: accepted as a manuscript proof and exact finite obstruction;
no blocking mathematical finding.** The pair insertion theorem, its closed
harmonic corollary, the necessary minimal-count conditions, and the claimed
failure of the fastest-deletion component strategy are sound with their
displayed hypotheses. None is a kernel proof or an unconditional LRC proof.

Reviewed immutable inputs, SHA-256:

```text
6267ff6fb165ba01d5f982fd4931342c3e594d1ca1ca765d0aa41f0813598446  research/astra-dense-pivot-induction.md
362da5ab923f22e900ae7ac821dd4cf4aab91dfe70889987bc9e5a05d19c276a  LonelyRunner/PivotResidues.lean
0e56cab74d30ef8b537ed4ec24503aae875bd8aadc369d26da99ba882cc3603f  LonelyRunner/PivotBoundary.lean
dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5  LonelyRunner/FastRunnerInsertion.lean
49131a7f9690042d1b16cbc876417f9d9ce1b53cc6565f87b6d1b53c4e3340cd  LonelyRunner/Prompt99Scaling.lean
```

## 1. Component semantics, including negative and isolated times

The theorem's count is correct: N>=4, N-2 distinct positive old moving
speeds, one supplied old witness at `h=1/(N-1)`, and a new integer speed
p larger than every old speed. The full moving count is N-1, and its target
is `delta=1/N`. The supplied stronger witness remains an explicit premise.

For any real seed t, including a negative seed, put `k_a=floor(at)`. The
condition `||at||>=h>0` places at in the unique phase band
`[k_a+h,k_a+1-h]`. The corresponding weak band is
`[(k_a+delta)/a,(k_a+1-delta)/a]`. All weak bands contain t in their
interior because h>delta. Their finite intersection is `[L,R]` with the
displayed maximum and minimum endpoints, and L<t<R.

This is the entire connected weak-good component containing t, not merely
a protected subinterval: an endpoint owner is bad immediately beyond that
endpoint, before its next band starts. On the real line a connected subset
is an interval, so a component cannot cross that gap and return to a later
band. Band gaps are positive because delta>0. No assumption that all good
components have positive length is needed. A component containing a stronger
seed does have positive length; other components can be isolated points.

A decisive control is

```text
G_4({1,3}) intersect [0,1]
 = {1/4} union [5/12,7/12] union {3/4},
G_3({1,3}) intersect [0,1] = [4/9,5/9].
```

Thus isolated components exist even with the theorem's old count, but none
contains a stronger seed. At t=-1/2 the seeded weak component is
`[-7/12,-5/12]`; both endpoint owners are speed 3. Negative floors give the
same component formula without absolute-value or sign corrections.

## 2. Determinant, gcd, ceiling, and closed insertion

For distinct endpoint owners a,b, write `k=floor(at)`,
`l=floor(bt)+1`, and `H=al-bk`. The stronger band inequalities imply

```text
H >= (a+b)/(N-1),
gcd(a,b) divides H,
R-L = (NH-a-b)/(Nab).
```

These identities hold with negative k,l. In particular H is positive.
Writing g=gcd(a,b), divisibility and the lower bound give

```text
H >= g*ceil((a+b)/((N-1)g)).
```

Consequently the manuscript's integer
`D=N*g*ceil((a+b)/((N-1)g))-(a+b)` satisfies
`D >= (a+b)/(N-1)>0`, and

```text
R-L >= D/(Nab) >= (1/a+1/b)/(N(N-1)).
```

The ceiling is non-strict even when its argument is integral. The gcd is
valid and materially useful: `D_7(6,12)=24`, whereas replacing g by 1 gives
only 3. The formula is symmetric in a,b and obeys
`D_N(ta,tb)=t D_N(a,b)` for positive integer t.

If the same speed a owns both endpoints, the component width is exactly
`(N-2)/(Na)>2/(Np)`. Here N>=4 and p>a are essential: the distinct-pair
condition must not be used to skip this case.

If all points of `[L,R]` failed only at p, that connected closed interval
would lie in a single open p-bad arc. These arcs have length `2/(Np)` and
positive separating gaps, so the component width would be strictly less
than `2/(Np)`. The pair assumptions `pD_N(a,b)>=2ab` contradict this in
the distinct-owner case; the preceding width contradicts it in the
same-owner case. **Equality in the pair assumption is valid.** No strict
good inequality, rounding shortcut, or finite grid replacement is being used.

The control `N=4,V={2,3},p=4` has `D_4(2,3)=3` and
`pD=2ab=12`. Its stronger witness t=1/6 lies in the weak component
`[1/8,1/4]` of width `2/(Np)=1/8`; t=1/8 is a full closed witness.

The two manuscript examples were replayed exactly: the maximal pair bounds
are respectively 20/3 and 10, their stated old and full witnesses work,
and both lie outside the claimed coarser speed conditions.

## 3. Harmonic attribution and induction scope

For positive a,b the function `ab/(a+b)` is increasing in each coordinate.
Thus the largest two distinct old speeds q>s dominate every unordered pair.
The lower bound on D proves that
`p(q+s)>=2(N-1)qs` implies every pair inequality. Since
`2qs/(q+s)<q`, this weakens the existing sufficient hypothesis
`p>=(N-1)q` in `FastRunnerInsertion.lean` while retaining a supplied old
witness.

The linked primary PDF was retrieved. Its unnumbered proposition on printed
page 2 explicitly states the strict harmonic condition with the full
smaller-count LRC hypothesis. The manuscript correctly acknowledges that
precedent and derives its own closed endpoint and determinant details.
No other proposition in the paper is used in this review or treated as
verified. [Primary PDF, page 2](https://rxiverse.org/pdf/2509.0023v4.pdf)

Under a hypothetical *least moving-count positive-integer* failure, deleting
the fastest speed legitimately supplies the old witness at `1/(N-1)`.
Contraposition of the insertion theorem then proves both strict necessary
bounds. For every stronger old seed its endpoint owners must be distinct and
must satisfy `pD_N(a,b)<2ab`; otherwise that one seed alone constructs a full
witness. It is not necessary, and is not claimed, that every old pair violates
the test. This induction does not require a count-preserving real-to-integer
bridge beyond choosing a least positive-integer failure in the stated domain.

Under that hypothetical failure, at each component endpoint all old labels
are good and p is strictly bad. If the left endpoint belongs to owner a,
its signed numerator on the actual a-grid is `Nk+1`; if the right belongs
to owner b, it is `Nl-1`. Reduction modulo the respective positive modulus
Na or Nb preserves the residues +1 or -1 modulo N. Therefore these really
are candidate points on the original owners' grids, with p the unique bad
original label. Normalization preserves all original integer-speed norms.

## 4. Exhaustive obstruction and actual cover labels

An independent method below enumerates every phase boundary, tests each
open cell's midpoint and every boundary point, and merges the resulting
closed good pieces. It differs from the author's iterative band-intersection
code. Both exact methods produce, for `N=7,V={1,4,5,6,7},p=11`, precisely
four strong components, six weak components, and two full components.

The four weak components meeting the entire stronger witness set are the
four trapped intervals printed in the manuscript. Their endpoint-owner pairs
in increasing time order are `(6,5),(7,4),(4,7),(5,6)`. Each interval is
strictly inside its displayed open 11-bad arc, including both endpoints.
The remaining two weak components are exactly the two full-good intervals;
neither meets the stronger witness set. Hence *every* choice of a stronger
fastest-deletion witness is trapped in its own weak-good component. A
strategy confined to such components fails on this tuple even if it may
exhaustively choose among all stronger witnesses.

The full tuple nevertheless has the displayed witness 13/42, with all six
distances exactly as stated. The largest row has 66 candidates and is
completely covered; the five owners' least private residues are
`(3,18,15,13,11)`. Independently computing every original pivot's coverage
gives exactly `{1,4,5,11}`. Thus 6 and 7 are not internal owners at pivot 11.

For an additional direct scope check, the entire internal owner set
`{1,4,5}` leaves **22** candidates of the 11-row uncovered, the first being
11. Every subset leaves these candidates uncovered too. Thus this example
has no internal complete cover at its maximum covered pivot. It does not
refute internal redundancy, any all-covered implication, or LRC. It refutes
only the explicitly described fastest-deletion component strategy.

The finite inventory is exhaustive on [0,1] because phases are periodic with
period one and all interval boundaries of every old speed are included.
The closed boundary tests preserve isolated witnesses. Integer translation
extends the inventory and trapped inclusions to all real times; the code also
checks a negative translated copy and the signed private numerators directly.

## 5. Reproduction and checks

The author's sole Python block was executed unchanged and passed. The
following independent exact control block also passed; it imports no project
checker and performs no floating-point computations. Parent-reported larger
checks were not counted as this reviewer's verification.

```python
from fractions import Fraction as F
from math import gcd, floor

def norm(t):
    r=t%1
    return min(r,1-r)

def good(V,N,t):
    return all(norm(a*t)>=F(1,N) for a in V)

# Independent boundary-cell inventory; includes isolated good points.
def cells(V,N):
    points={F(0),F(1)}
    for a in V:
        for j in range(a):
            points.update((F(N*j+1,N*a),F(N*(j+1)-1,N*a)))
    xs=sorted(points)
    pieces=[(x,x) for x in xs if good(V,N,x)]
    for x,y in zip(xs,xs[1:]):
        if good(V,N,(x+y)/2):
            assert good(V,N,x) and good(V,N,y)
            pieces.append((x,y))
    out=[]
    for x,y in sorted(pieces):
        if out and x<=out[-1][1]:
            out[-1]=(out[-1][0],max(y,out[-1][1]))
        else:
            out.append((x,y))
    return out

def D(N,a,b):
    g=gcd(a,b);s=a+b;den=(N-1)*g
    return N*g*((s+den-1)//den)-s

def local(V,N,t):
    k={a:floor(a*t) for a in V}
    ls={a:(F(k[a])+F(1,N))/a for a in V}
    rs={a:(F(k[a])+1-F(1,N))/a for a in V}
    L=max(ls.values());R=min(rs.values())
    return L,R,tuple(a for a in V if ls[a]==L),tuple(a for a in V if rs[a]==R),k

assert cells((1,3),4)==[(F(1,4),F(1,4)),(F(5,12),F(7,12)),(F(3,4),F(3,4))]
assert cells((1,3),3)==[(F(4,9),F(5,9))]
assert local((1,3),4,F(-1,2))[:4]==(F(-7,12),F(-5,12),(3,),(3,))
assert D(7,6,12)==24 and 7*((18+5)//6)-18==3
assert D(4,2,3)==3 and 4*D(4,2,3)==2*2*3
assert good((2,3),3,F(1,6)) and good((2,3,4),4,F(1,8))
assert local((2,3),4,F(1,6))[:2]==(F(1,8),F(1,4))

V=(1,4,5,6,7);N=7;p=11
S=cells(V,6);W=cells(V,7);A=cells(V+(p,),7)
expectedS=[(F(13,36),F(11,30)),(F(19,42),F(11,24)),
           (F(13,24),F(23,42)),(F(19,30),F(23,36))]
expectedW=[(F(15,49),F(13,42)),(F(5,14),F(13,35)),
           (F(22,49),F(13,28)),(F(15,28),F(27,49)),
           (F(22,35),F(9,14)),(F(29,42),F(34,49))]
assert S==expectedS and W==expectedW and A==[W[0],W[-1]]
seeded=[I for I in W if any(max(I[0],J[0])<=min(I[1],J[1]) for J in S)]
assert seeded==W[1:-1]
endpoint_pairs=[]
for J in S:
    t=sum(J)/2
    L,R,aa,bb,k=local(V,N,t)
    assert (L,R) in seeded
    for translate in (0,-1):
        l,r,left,right,ks=local(V,N,t+translate)
        assert (l,r)==(L+translate,R+translate)
        m=floor(p*(l+r)/2+F(1,2))
        assert F(N*m-1,N*p)<l<r<F(N*m+1,N*p)
        for a in left:
            for b in right:
                assert a!=b and p*D(N,a,b)<2*a*b
                H=a*(ks[b]+1)-b*ks[a]
                assert H%gcd(a,b)==0 and H>=F(a+b,N-1)
                assert r-l==F(N*H-a-b,N*a*b)>=F(D(N,a,b),N*a*b)
        for end,owners,sign in ((l,left,1),(r,right,-1)):
            assert good(V,N,end) and norm(p*end)<F(1,N)
            for owner in owners:
                numerator=end*(N*owner)
                assert numerator.denominator==1 and numerator%N==sign%N
                residue=int(numerator)%(N*owner)
                assert residue%N
                assert all(norm(F(residue*v,N*owner))>=F(1,N) for v in V)
                assert norm(F(residue*p,N*owner))<F(1,N)
    endpoint_pairs.append((aa,bb))
assert endpoint_pairs==[((6,),(5,)),((7,),(4,)),((4,),(7,)),((5,),(6,))]

# Norm-based cover computation is separate from the author's modular test.
def bad(p,a):
    return {r for r in range(7*p) if r%7 and norm(F(r*a,7*p))<F(1,7)}
B={a:bad(p,a) for a in V}
R={r for r in range(7*p) if r%7}
assert set().union(*B.values())==R and len(R)==66
private=tuple(min(B[a]-set().union(*(B[b] for b in V if b!=a))) for a in V)
assert private==(3,18,15,13,11)
U=V+(p,)
covered={a for a in U if set().union(*(bad(a,b) for b in U if b!=a))
         =={r for r in range(7*a) if r%7}}
assert covered=={1,4,5,11}
internal_safe=R-set().union(*(bad(11,a) for a in (1,4,5)))
assert len(internal_safe)==22 and min(internal_safe)==11
assert tuple(norm(F(13*a,42)) for a in U)==(
    F(13,42),F(5,21),F(19,42),F(1,7),F(1,6),F(17,42))
print({'interval_counts':(len(S),len(W),len(A)),
       'endpoint_pairs':endpoint_pairs,'private':private,
       'internal_safe_count':len(internal_safe),
       'closed_equality_gcd_isolated_negative_controls':'passed'})
```

## 6. Promotion limits and next action

This review accepts the manuscript at the bound SHA; it does not review or
approve a future Lean implementation. A formal implementation should first
prove the closed weak-band intersection from a supplied stronger witness,
then separate same-owner and distinct-owner endpoints, prove D positive
before natural-number subtraction/division, and retain signed endpoint
indices until actual residue normalization. Its final insertion statement
must retain the stronger witness and every pair inequality explicitly.

The meaningful unresolved step is an unrestricted argument for dense,
all-covered configurations. The pair inequalities are not necessary for
witness existence, and the trapped-component example establishes that even
exhaustive selection of all fastest-deletion stronger witnesses does not
make its component-following strategy universal. Other deletion choices,
relations between different original pivot rows, or a justified transition
to unseeded good components remain additional work. None is supplied by
the reviewed manuscript. No global Prompt95 inhabitant, canonical proof,
canonical disproof, or completion claim is approved.
