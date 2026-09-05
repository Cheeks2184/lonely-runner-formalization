# One-anchor exact-loss packets retain the full witness obligation

2026-09-05. Requested Astra xhigh semantic task
`/root/endpoint_label_audit-single-anchor-completeness`, source checkpoint
`a4c395827100593500747904a1a11f4251fdb271`. Runtime model/effort metadata is
not independently attested. Current project configuration, workflow, policy,
and state were read; `python3 -B scripts/validate_workflow.py` passed. Research
is active and canonical completion remains null. Only this manuscript and
small temporary deterministic controls were written. No Lean/source, cache,
Git, shared-state, or other project files were modified. This worker artifact
is explicitly outside Pass27 pending its own review.

**Result: the proposed reverse constructor is sound, with explicit simultaneous
bounds.** For a fixed positive integer stationary tuple with at least two
moving comparisons, ordinary witness existence is equivalent to existence of
a generalized **one-anchor** packet satisfying both the exact-loss inequalities
and the collision's true own-count margin. This is a manuscript equivalence,
not a new Lean theorem or uniform supply result. Its reverse direction starts
from an existing witness. It neither selects the required time from `H_N`
alone nor contradicts the accepted obstruction for **two-anchor** packets.
Separate independent review remains required.

## Inputs and the changed contract

The frozen previous manuscript
`research/astra-exact-rounding-scope-audit.md` has SHA-256
`ba16410bdd0ca08262573fbfa36d6e46078a7b3910f68e7593318dea63d78c3c`.
Its accepted independent review
`research/astra-exact-rounding-scope-review.md` has SHA-256
`37c5d7c39c24e3153d29008ebcccaa6e6141756b6ae0138f61d9c7c548840435`.
Their exact-rounding and pair-sum arguments were read. The underlying
`docs/round6-strategies.md` section 2 remains a paper proof, not an assumed
Lean pair-sum completeness declaration.

Let `W_1,...,W_m` be positive integers, `m>=2`, and `N=m+1`. All original
comparison labels are retained; the proof does not need the positive speeds
to be pairwise distinct, and applies in particular to the injective tuples
relevant to canonical LRC. There is one stationary original runner of speed
zero. The only anchored coefficients are `u_0=v_0=0`; index zero is **not**
a member of the collision row or its magnitude count.

A packet now consists of arbitrary integers `u_i`, positive rational `p`,
and positive integer `q`, with `L=p*q` a positive integer, and
`v_i=W_i-p*u_i`. Then `q*v_i=q*W_i-L*u_i` is integral. There is **no**
condition on the final moving coordinate `u_last` or `v_last`, and `L`
is not required to equal the largest original speed.

For two distinct moving labels `a,b`, put

```text
beta=W_a+W_b>0, alpha=-(u_a+u_b),
w_i=beta*u_i+alpha*W_i,
c=card { |w_i| : 1<=i<=m }.
```

Require all `w_i!=0`. The algebraic identity `w_a=-w_b` gives
`1<=c<=m-1=N-2`. At a single real time `tau`, the retained conditions are

```text
norm(w_i*tau) - (|v_i|/p)*norm(beta*tau) >= 1/N,       (E)
norm(w_i*tau) >= 1/(c+1),                            (C)
```

for every moving label. The count in (C) is the **actual** number of distinct
positive collision magnitudes, rather than an assumed upper bound used as
if it were an equality.

## Forward implication, including positivity

The previous metric argument extends under precisely the new product-period
assumption. Set

```text
x=(alpha*p+beta)*tau, y0=alpha*tau,
n=1-floor(y0/q), y=y0+q*n,
j a nearest integer to p*y-x, t=(j+x)/p.
```

Then `q<=y<2q` and

```text
p*y-x=L*n-beta*tau,
|t-y|=norm(beta*tau)/p,
W_i*t=u_i*j+w_i*tau+q*v_i*n+v_i*(t-y).
```

The terms `u_i*j` and `q*v_i*n` are integers. Circle-norm invariance and
its 1-Lipschitz property prove `norm(W_i*t)` at least the left side of (E).
Also

```text
t >= q-1/(2p) = q*(1-1/(2L)) >= q/2 > 0,
```

since `L` is a positive integer. Thus (E) supplies one positive original
stationary witness, including closed boundaries and either nearest-integer
tie. Condition (C) is retained in the packet definition but is not needed
for this forward inference.

## Balanced pair-sum input for the reverse direction

Suppose the original tuple already has a witness. The continuous, period-one
function `F(T)=min_i norm(W_i*T)` attains a positive maximum `M>=1/N`.
If `M<1/2`, active waves at a maximum have slopes of both signs: otherwise
all active constraints increase in one direction while the finitely many
inactive constraints retain slack. Reorder two such active labels as `a,b`
so their fractional phases are `M` and `1-M`. If `M=1/2`, all phases are
half-integral and any distinct pair may be used. In either case

```text
beta=W_a+W_b, T=k/beta, 0<k<beta,
d_i=norm(W_i*T)>=M,
frac(W_a*T)=M, frac(W_b*T)=1-M.                       (1)
```

This is the audited pair-sum maximizer argument. Only the balanced relations
(1), rather than global maximality itself, are used below. They cannot be
asserted without the supplied original witness or another witness theorem.
No call to an unproved Lean completeness statement is made.

Write `r_i` for the least nonnegative residue of `k*W_i` modulo `beta`.
All residues are nonzero because `d_i>=M>0`. Thus

```text
r_i in {1,...,beta-1},
d_i=min(r_i,beta-r_i)/beta.
```

Choose nonzero integers `w_i` satisfying

```text
w_i == -k*W_i (mod beta), w_a=-w_b.                  (2)
```

Once these are supplied, set

```text
u_i=(w_i+k*W_i)/beta, p=beta/k, q=k.
```

The `u_i` are integers, `u_a+u_b=k`, `alpha=-k`, and the collision row
computed from this packet is exactly the chosen row `w`. Moreover

```text
p*q=beta, v_i=-w_i/k, q*v_i=-w_i, x=0.              (3)
```

The construction therefore satisfies every one-anchor arithmetic condition.
Notice that all moving `v_i` are nonzero; this deliberately does not construct
a packet in the old last-anchor class.

## Half-integral maximum

If `M=1/2`, every `r_i=beta/2`, so `beta` is even. Take
`w_i=beta/2` for every label except `b`, and `w_b=-beta/2`. These choices
satisfy (2), are nowhere zero, and have **true count `c=1`**, even if `N>=4`.
Use `tau=-1/beta`. Every collision norm equals `1/2`, satisfying (C)
exactly; `norm(beta*tau)=0`, so (E) also holds. The phase construction has

```text
y0=T, y=T+k, j=beta+1, t=k+T>0.
```

No perturbation or lower bound `c>=2` is needed in this branch.

## Explicit simultaneous construction when M<1/2

Put `h=1/2-M>0`. Orient the active pair as in (1), so `r_a=beta*M` and
`r_b=beta-r_a`. Define

```text
rho_a=beta-r_a,
A=rho_a+6*beta^2,
epsilon=h/A,
w_a=A, w_b=-A,
tau=-1/beta+epsilon.                                (4)
```

The pair already satisfies (2). The following strict estimates hold at once:

```text
A>6*beta^2>2*beta,
0<epsilon<1/(12*beta^2),
0<beta*epsilon<1/(12*beta)<1/2.                      (5)
```

For every non-half-integral coordinate, `D_i=1/2-d_i` is positive, with

```text
D_i=(beta-2*min(r_i,beta-r_i))/(2*beta)>=1/(2*beta).
```

Since all `d_i>=M`, we also have `D_i<=h`. Hence its target magnitude

```text
B_i=D_i/epsilon
```

satisfies `6*beta<B_i<=A`. This gives a single explicit `A` large enough
for all coordinates; no sequential choice or unevaluated infinitary bound
is hidden in the construction.

For each label other than `a,b` with `d_i<1/2`, set

```text
eta_i=+1 if r_i<beta/2, and eta_i=-1 if r_i>beta/2,
rho_i=beta-min(r_i,beta-r_i),
z_i=rho_i+beta*floor((B_i-rho_i)/beta).
```

Then `eta_i*rho_i == -r_i (mod beta)`, and `z_i` is the greatest
representative of that positive magnitude residue class not exceeding `B_i`.
It obeys `0<=B_i-z_i<beta` and `z_i>5*beta`. If `z_i=A`, replace it by
`z_i-beta`; otherwise leave it alone. The result satisfies

```text
0<z_i<A, z_i<=B_i,
0<=D_i-z_i*epsilon<2*beta*epsilon.                   (6)
```

Indeed before the optional subtraction `z_i<=B_i<=A`; subtraction preserves
the congruence and leaves it positive. It also makes an equality with `A`
strict. Set `w_i=eta_i*z_i`. This proves (2) for that coordinate, and its
phase moves toward the antipode without crossing it:

```text
w_i*(-1/beta) == W_i*T (mod Z),
norm(w_i*tau)=d_i+z_i*epsilon.
```

For a remaining half-integral coordinate, take `w_i=beta/2`; the residue
condition implies `beta` is even. This value is positive and less than `A`,
satisfies (2), and

```text
norm(w_i*tau)=1/2-(beta/2)*epsilon.                  (7)
```

The phase stays below one by (5), so (7) uses the correct side of the
triangular wave.

## Verification of E, C, the returned time, and actual cardinality

The active pair lands exactly at the antipode because `A*epsilon=h`:
its two collision norms are `1/2`. Every other non-half-integral collision
norm, using (6), is strictly greater than

```text
1/2-2*beta*epsilon > 1/2-1/(6*beta) >= 5/12 > 1/3.
```

Every half-integral coordinate in (7) also has norm strictly greater than
`1/3`. Thus all collision norms are at least `1/3`, with the active pair
exactly `1/2`.

If `N=3`, there are only the two active comparison labels: the true count is
`c=1` and the norms are exactly `1/(c+1)=1/2`. If `N>=4`, there is an extra
comparison label. Every extra magnitude has been proved positive and strictly
less than the pair magnitude `A`. Therefore `c>=2`, while the opposite pair
still gives `c<=N-2`. In this case `1/(c+1)<=1/3`, so (C) follows using the
**true count**. Extra magnitudes may repeat each other; no distinctness of
all collision entries is asserted or needed.

By (3)-(5), `norm(beta*tau)=beta*epsilon` and the exact loss is

```text
(|v_i|/p)*norm(beta*tau)=|w_i|*epsilon.
```

For each non-half-integral coordinate, including the active pair, subtracting
this loss leaves exactly `d_i>=M`. For a half-integral coordinate it leaves

```text
1/2-beta*epsilon > 1/2-h = M,
```

because `A>beta`. Thus (E) holds for every original moving comparison,
with the original closed threshold `1/N`.

Finally (5) gives `0<y0=T-k*epsilon<q=k`. Consequently

```text
y=k+T-k*epsilon,
p*y=beta+1-beta*epsilon,
j=beta+1 (uniquely nearest),
t=j/p=k+T.                                         (8)
```

The returned time is fixed throughout the perturbation and is positive.
Its difference from the original `T` is the integer `k`, so it preserves
all original integer-speed phases. There is one common time in (8), not
separate comparison times. This completes the reverse construction.

## Equivalence and its limits

For the fixed stationary positive integer tuple of length `N-1>=2`, we have
proved at manuscript level

```text
exists ordinary original witness
  <=> exists one-anchor packet satisfying both E and C.
```

Forward transfer uses no LRC premise. Reverse construction uses the supplied
witness to obtain the balanced pair, `T`, `M`, and the congruence data; it does
not produce those from `H_N`. Even though `H_N` supplies an own-count witness
for any fixed collision magnitude set, it does not supply the required joint
choice of packet and time. This equivalence does not discharge the uniform
finite-family obligation.

The previous two-anchor obstruction remains intact. Its endpoint invariant
used `v_last=0` and `u_last=q`, with `p*q` equal to the original maximum.
None of those three last-endpoint requirements is imposed here. Removing
them is a stated change of contract, not a repair to the previous theorem.
No extension to arbitrary real speeds, signed chosen-label normalizations,
or a formal canonical equivalence is claimed in this manuscript.

## Fixed controls

The supplied repair of the old endpoint failure is

```text
W=(1,2,3), p=4, q=1, u=(2,1,-1), v=(-7,-2,7),
pair speeds (1,3), alpha=-1, beta=4,
w=(7,2,-7), c=2, tau=-3/14,
x=0, y=17/14, j=5, t=5/4.
```

Its collision norms are `(1/2,3/7,1/2)` and the exact bounds are
`(1/4,5/14,1/4)`. Both (E) and (C) hold. Its final moving coefficients
`u_last=-1`, `v_last=7` explicitly violate the old last-anchor condition.

The deterministic program below additionally applies the stated uniform bound
to that same tuple, obtaining `w=(99,2,-99)`, `u=(25,1,-24)`, and the same
returned time `5/4`. The `N=3` control `W=(1,2)`, `T=1/3` gives
`w=(56,-56)`, true `c=1`, exact collision norms `1/2`, and exact lower
bounds `1/3`. The half-integral control `W=(1,3,5)`, `T=1/2` gives
`p=q=2`, `w=(2,-2,2)`, true `c=1`, and collision norms `1/2`.
There are four packet controls and eleven original comparison checks, using
only these fixed supplied-witness inputs. The general congruence/floor and
cardinality claims are established by (5)-(7), rather than inferred from
these examples. No tuple, time, packet, or denominator search was run.

## Complete deterministic replay

The program verifies five frozen inputs, including both the previous manuscript
and its accepted review. Additional inspected source identities are enforced
in the code below. Its SHA-256 is `6ca37f19035643b2591f14833d648cd4afc5f417c6142188a8d8542ac4077f56`; its single-line JSON output,
including the trailing newline, has SHA-256 `9a01362df1883306496507e37b44200a0402c903433442587e903db194ab8111`.
The first run passed without changing any assertion or fixture.

```python
from fractions import Fraction as F
from math import floor
from collections import Counter
from hashlib import sha256
from pathlib import Path
import json

bindings={
 'research/astra-exact-rounding-scope-audit.md':'ba16410bdd0ca08262573fbfa36d6e46078a7b3910f68e7593318dea63d78c3c',
 'research/astra-exact-rounding-scope-review.md':'37c5d7c39c24e3153d29008ebcccaa6e6141756b6ae0138f61d9c7c548840435',
 'docs/round6-strategies.md':'962fbce708f3c21ca4c2d745b2ebe789c48fc1081520d763447809dcd4d287e9',
 'LonelyRunner/AffinePhaseTransfer.lean':'069d7f05229f517639284a58d9bb10f6fd6ee8d949efc3d377361424e7381776',
 'LonelyRunner/AffinePhasePeriod.lean':'340c4dd29276544566175cf791307ca42753ddc964345aa793d33abef1e9b176',
}
for path,wanted in bindings.items():
    assert sha256(Path(path).read_bytes()).hexdigest()==wanted,path
counts=Counter(); records=[]
def norm(x):
    z=F(x)%1
    return min(z,1-z)

def check_packet(name,W,u,p,q,pair,tau,expected_T):
    N=len(W)+1; p=F(p); tau=F(tau)
    assert N>=3 and all(x>0 and isinstance(x,int) for x in W)
    assert q>0 and isinstance(q,int) and p>0
    L=p*q
    assert L.denominator==1 and L>=1
    v=tuple(F(a)-p*b for a,b in zip(W,u))
    assert all(isinstance(z,int) for z in u)
    assert all((q*z).denominator==1 for z in v)
    a,b=pair; beta=W[a]+W[b]; alpha=-(u[a]+u[b])
    w=tuple(beta*z+alpha*a for z,a in zip(u,W))
    assert a!=b and w[a]==-w[b] and all(w)
    c=len(set(map(abs,w)))
    assert 1<=c<=N-2
    x=(alpha*p+beta)*tau; y0=alpha*tau
    n=1-floor(y0/q); y=y0+q*n; D=p*y-x
    assert q<=y<2*q and D==L*n-beta*tau
    j=floor(D+F(1,2)); t=(j+x)/p; rounding=norm(beta*tau)
    assert abs(D-j)==rounding and abs(t-y)==rounding/p
    assert t>=q-F(1,2)/p>0
    margins=tuple(norm(z*tau) for z in w)
    loss=tuple(abs(z)/p*rounding for z in v)
    lower=tuple(a-b for a,b in zip(margins,loss))
    for i in range(N-1):
        assert margins[i]>=F(1,c+1)
        assert lower[i]>=F(1,N)
        assert norm(W[i]*t)>=lower[i]
        assert W[i]*t==u[i]*j+w[i]*tau+v[i]*(y-y0)+v[i]*(t-y)
        counts['comparison_checks']+=1
    assert t==q+expected_T and all(norm(z*expected_T)>=F(1,N) for z in W)
    # The retained anchor is only the stationary coordinate.
    full_u=(0,)+tuple(u); full_v=(F(0),)+v
    assert full_u[0]==full_v[0]==0 and full_v[-1]!=0
    counts['packets']+=1
    record=dict(name=name,W=W,u=u,v=list(map(str,v)),p=str(p),q=q,
                alpha=alpha,beta=beta,w=w,c=c,tau=str(tau),time=str(t),
                collision_norms=list(map(str,margins)),exact_bounds=list(map(str,lower)))
    records.append(record)
    return record

def construct(name,W,pair,T):
    N=len(W)+1; a,b=pair; beta=W[a]+W[b]; T=F(T)
    kt=beta*T
    assert kt.denominator==1
    k=int(kt)
    assert 0<k<beta and 0<T<1
    r=tuple((k*z)%beta for z in W)
    d=tuple(F(min(z,beta-z),beta) for z in r)
    M=min(d)
    assert M>=F(1,N) and all(r)
    assert F(r[a],beta)==M and F(r[b],beta)==1-M
    w=[None]*len(W)
    if M==F(1,2):
        assert beta%2==0 and all(z==beta//2 for z in r)
        w=[beta//2]*len(W);w[b]=-beta//2
        epsilon=F(0)
        counts['half_maximum_constructors']+=1
    else:
        h=F(1,2)-M; rho=beta-r[a]
        A=rho+6*beta**2; epsilon=h/A
        assert A>6*beta**2 and 0<epsilon<F(1,12*beta**2)
        assert beta*epsilon<F(1,2)
        w[a]=A;w[b]=-A
        for i in range(len(W)):
            if d[i]<F(1,2):
                gap=F(1,2)-d[i]
                assert gap>=F(1,2*beta) and gap/epsilon>6*beta
            if i in pair: continue
            if d[i]==F(1,2):
                assert beta%2==0
                w[i]=beta//2
                counts['half_coordinate_choices']+=1
            else:
                gap=F(1,2)-d[i]
                sign=1 if 2*r[i]<beta else -1
                residue=beta-min(r[i],beta-r[i])
                target=gap/epsilon
                z=residue+beta*floor((target-residue)/beta)
                if z==A: z-=beta
                assert 0<z<A and z<=target and 0<=gap-z*epsilon<2*beta*epsilon
                w[i]=sign*z
                counts['nonhalf_coordinate_choices']+=1
        assert all(abs(w[i])<A for i in range(len(W)) if i not in pair)
        counts['subhalf_constructors']+=1
    assert all((wi+k*Wi)%beta==0 for wi,Wi in zip(w,W))
    u=tuple((wi+k*Wi)//beta for wi,Wi in zip(w,W))
    assert u[a]+u[b]==k
    tau=-F(1,beta)+epsilon
    v=tuple(-F(wi,k) for wi in w)
    assert all(norm(wi*tau)>=F(1,3) for wi in w)
    if M<F(1,2):
        if N==3:
            assert len(set(map(abs,w)))==1 and all(norm(wi*tau)==F(1,2) for wi in w)
            counts['count_one_subhalf_constructors']+=1
        else: assert len(set(map(abs,w)))>=2
        for i,wi in enumerate(w):
            actual=norm(wi*tau)-abs(wi)*epsilon
            if d[i]<F(1,2): assert actual==d[i]
            else: assert actual==F(1,2)-beta*epsilon>M
    z=check_packet(name,W,u,F(beta,k),k,pair,tau,T)
    assert tuple(map(F,z['v']))==v and z['w']==tuple(w)
    assert z['alpha']==-k and z['beta']==beta
    counts['constructed_from_supplied_witness']+=1
    return z

# Supplied repair, without imposing the previous last-endpoint condition.
z=check_packet('supplied endpoint repair',(1,2,3),(2,1,-1),4,1,(0,2),F(-3,14),F(1,4))
assert z['v']==['-7','-2','7'] and z['w']==(7,2,-7) and z['c']==2
assert z['collision_norms']==['1/2','3/7','1/2']
assert z['exact_bounds']==['1/4','5/14','1/4'] and z['time']=='5/4'
assert z['u'][-1]!=z['q']
counts['supplied_repair']=1
# Only these fixed existing-witness inputs are used; no tuple or time search.
z=construct('uniform bound on supplied tuple',(1,2,3),(0,2),F(1,4))
assert z['w']==(99,2,-99) and z['u']==(25,1,-24) and z['c']==2
z=construct('N3 exact count one',(1,2),(0,1),F(1,3))
assert z['w']==(56,-56) and z['c']==1 and z['exact_bounds']==['1/3','1/3']
z=construct('half-integral maximum',(1,3,5),(0,1),F(1,2))
assert z['w']==(2,-2,2) and z['c']==1 and z['collision_norms']==['1/2']*3
assert counts['packets']==4 and counts['comparison_checks']==11
assert counts['constructed_from_supplied_witness']==3
print(json.dumps(dict(counts=dict(sorted(counts.items())),records=records),sort_keys=True))
```

Run the saved block exactly from the repository root:

```sh
python3 -B - <<'SINGLE_ANCHOR_REPLAY'
from pathlib import Path
from hashlib import sha256
import re
text = Path('research/astra-single-anchor-completeness-audit.md').read_text()
blocks = re.findall(r'^```python\n(.*?)^```[ \t]*$', text, re.M | re.S)
assert len(blocks) == 1
assert sha256(blocks[0].encode()).hexdigest() == '6ca37f19035643b2591f14833d648cd4afc5f417c6142188a8d8542ac4077f56'
exec(compile(blocks[0], 'single-anchor-controls', 'exec'))
SINGLE_ANCHOR_REPLAY
```

The saved-block replay exits zero and reproduces the output hash. It checks
four packets and eleven original comparisons, with three deterministic
constructions from already supplied witnesses: two sub-half cases, including
the `N=3` count-one case, and one half-integral case. No broad finite search
or Lean execution is part of this evidence.

The equivalence and explicit simultaneous bounds are manuscript results awaiting
independent review. The existing two-anchor theorem and its counterexample
retain their original hypotheses and status. No `H_N` time selector, uniform
one-anchor supply, `F_N`, or unrestricted LRC proof is supplied here. All owned
commands have stopped at handoff.
