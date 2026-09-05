# The retained finite regime and endpoint affine packets

Status: **bounded structural result, not uniform witness supply**. The
denominator-folding lemma, sharp packet-height obstruction, and consecutive
family control below are proved at manuscript level. They have exact rational
controls but no new Lean formalization; independent review is still required.
No proof of general `H_N`, `F_N`, or unrestricted LRC is supplied.

Requested role: Astra xhigh. Runtime model/effort metadata is not independently
attested. Assignment checkpoint:
`52eb99ea7d4cdd428dadd544c10f247a8a90d3e5`. Project configuration, workflow,
policy, and state were read; workflow structural validation passed. State
remains `research` / `in_progress`, without canonical completion. Only this
manuscript and its small temporary exact program were written. No Lean,
Git, state, source, dependency/cache, or build changes were made.

## Foundation and scope

The following frozen inputs were read:

| File | SHA-256 |
| --- | --- |
| `LonelyRunner/FiniteHeightReduction.lean` | `61a5ac9e27c58db10bf014bd91346769665038ebb3c05689237870de49279be1` |
| `LonelyRunner/AffineLonelyAt.lean` | `19ef8e3e8b5cc0364b74d13cfb93b608adf176ffdbb1a7e020e2d5f1b484ec7b` |
| `research/astra-affine-finite-height-audit.md` | `6b676a05eb3a0036cd69e779150a5f1a868024d089ea75c142daeddccede938f` |
| `research/astra-finite-height-formal-review.md` | `723e52d4ba10a5e8976c301c2f94e312d77c8d1afb42d4ce37b4082892fd0375` |

`docs/astra-research-25.md`, the modular/height sections of `docs/approaches.md`,
and the fixed-dimension and missing-height failures in `docs/failed-approaches.md`
were also consulted. This audit does not retry raw same-time speed replacement,
transport preserving every old phase, or a restricted missing-height certificate
already known to fail. No external literature or novelty claim is used.

Fix `N≥3`, `Q=N(N-1)`, and an actual integer configuration

\[
0=s_0<s_1<\cdots<s_{N-1}=H.
\]

The verified theorem assumes `H_N`: every nonempty positive injective integer
tuple with at most `N-2` moving speeds has a stationary witness at its own
closed threshold. It proves every original chosen runner lonely at a positive
time when the configuration is primitive and `H>Q^(N-2)`. The retained
inclusive assertion `F_N` remains unsupplied.

An **endpoint packet** here means an integer `q>0`, integer row `u`, rational
`p=H/q>0`, and rational row `v=s-pu`, with `u_0=0`, `u_(N-1)=q`. Thus
`v_0=v_(N-1)=0`, and `q*v` is integral. Require rank two for `u,v`. The
global sufficient error condition under examination is

\[
\operatorname{osc}(v):=\max_i v_i-\min_i v_i\le\frac{2p}{Q}.       \tag{G}
\]

It supplies `|v_i-v_r|≤2p/Q` for every chosen runner from a **single packet**;
witness times may still depend on the runner. The existing height construction
satisfies (G) through the stronger symmetric bound `|v_i|≤p/Q`. This does not
cover all affine representations without the endpoint constraints, improved
auxiliary margins, or separately chosen packets for individual runners.

Define integer residuals and their spread by

\[
R_i=q s_i-Hu_i=qv_i,\qquad K=\max_i R_i-\min_i R_i.
\]

Both endpoint residuals vanish. Since the final endpoint is `(u,v)=(q,0)`
with `q>0`, rank two is equivalent to some `R_i≠0`: that coordinate and the
endpoint give a nonzero minor. Hence `K>0`, and (G) is exactly `K≤2H/Q`.

## Descent of the auxiliary denominator

**Lemma 1.** Every endpoint packet satisfying (G) has a representation with
`0<q<H`, preserving the original speed tuple and integer residual row. When
initially `q≥H`, the new natural denominator is strictly smaller.

Because `Q≥6`, `K≤2H/Q<H`. Since zero is a residual, every `|R_i|≤K`.
If `H|q`, every residual is divisible by `H`; its absolute value is less
than `H`, so it must be zero, contradicting rank two. Thus in the Euclidean
division `q=kH+q0`, we have `0<q0<H`.

Set

\[
u'_i=u_i-ks_i,\qquad p'=H/q_0,\qquad v'_i=R_i/q_0.
\]

Direct algebra proves

\[
u'_0=0,\quad u'_{N-1}=q_0,\quad v'_0=v'_{N-1}=0,
\]
\[
q_0s_i-Hu'_i=R_i,\qquad p'u'_i+v'_i=s_i.
\]

The same nonzero residual and endpoint `u'_(N-1)=q0>0` prove rank two.
The common period is honest because `q0*v'_i=R_i` is integral. Moreover

\[
\operatorname{osc}(v')=K/q_0\le2H/(Qq_0)=2p'/Q.
\]

All original speeds and labels, including the stationary runner zero, are
unchanged. The error budget and rank are retained. The natural measure `q`
decreases whenever `q≥H`, and one step reaches `q0<H`, hence `p'>1`.
This restores the existing affine theorem's slope hypothesis.

This is an **auxiliary** descent. Neither the original height `H` nor the
count `N` decreases. Relaxing `p>1` or allowing larger denominators cannot
create new endpoint packets in this error class: any such packet folds back
to one in the existing range. No smaller-height original-tuple witness has
been produced by the reparametrization.

Under `H_N`, a packet satisfying (G) therefore gives a positive closed `1/N`
witness for every original runner: apply the reviewed
`rational_affine_lonelyAt` to the folded packet. Its actual-speed injectivity,
zero anchor, rank, period, and relative error hypotheses are all supplied
above. One common time serves all comparisons of the chosen original runner.
The descent lemma itself uses no LRC assumption.

## Sharp obstruction to a global packet

**Theorem 2.** A rank-two endpoint packet satisfying (G) must have

\[
H\ge\frac Q2\left\lceil\frac{N-1}{2}\right\rceil
 =\frac{N(N-1)}2\left\lfloor\frac N2\right\rfloor.               \tag{1}
\]

Primitivity is unnecessary for this lower bound. The bound is attained for
every `N≥3`, even by primitive configurations.

Let `g=gcd(q,H)>0`. Every residual belongs to `gℤ`, so `K` is a positive
multiple of `g` and `K≥g`. The `N-1` speeds `s_0,...,s_(N-2)` represent
distinct classes modulo `H`, and `R_i≡q*s_i (mod H)`.

Multiplication by `q` modulo `H` has at most `g` preimages of any fixed
residue. Indeed, write `q=gq1`, `H=gH1`. A residue not divisible by `g` has
none. Otherwise cancel `g` and use `gcd(q1,H1)=1` to obtain one class modulo
`H1`, which has exactly `g` representatives modulo `H`.

The closed integer interval `[min R,max R]` contains at most `K/g+1` members
of `gℤ`. Counting the original distinct input residues therefore gives

\[
N-1\le g(K/g+1)=K+g\le2K.
\]

This keeps both interval endpoints; it does not replace a closed bound by
a strict one. Since `K` is integral, `K≥ceil((N-1)/2)`. Combining this with
`K≤2H/Q` proves (1).

For sharpness put

\[
L=\lfloor N/2\rfloor=\lceil(N-1)/2\rceil,\quad h=Q/2,\quad H=Lh,
\]
\[
S_* = \{jh,jh+1:0\le j<L\}\cup\{H\}.
\]

Since `h≥3`, these elements are distinct and `|S_*|=2L+1`. For odd `N`,
use `S=S_*`. For even `N≥4`, remove `(L-1)h+1`, leaving exactly `2L=N`
elements. In the even case `L≥2`, so the removed element is neither zero,
one, nor `H`. Both cases thus give exactly `N` sorted original speeds with
endpoints `0,H` and speed `1`, proving primitivity.

Take `q=L`, `p=h`, `u(s)=floor(s/h)`. Then `v(s)=s-h*u(s)∈{0,1}`.
The endpoint gives `(u,v)=(L,0)` and speed `1` gives `(0,1)`, a nonzero
minor. The period `q*v` is integral, and

\[
\operatorname{osc}(v)=1=2h/Q=2p/Q.
\]

Thus equality in (1) is attained. This identifies the least height at which
**some** global packet can occur for each `N`; it does not claim that every
tuple at or above that height admits a packet. The theorem is only about
(G), not separately chosen packets with error controlled around one runner.

## A witnessed family missed even by individual-runner packets

**Proposition 3.** For `S={0,1,...,N-1}`, no rank-two endpoint packet can
satisfy

\[
|v_i-v_r|\le2p/Q\quad\text{for all }i                         \tag{R}
\]

for any chosen original runner `r`, even with arbitrary integer `q>0`.
Nevertheless the actual tuple has the direct witness `t=1/N`.

Here `H=N-1`. Multiplying (R) by `q` yields integer differences

\[
|R_i-R_r|\le2H/Q=2/N<1.
\]

All residuals equal `R_r`; the zero endpoint residual then forces every
residual to vanish, contradicting rank two. No denominator or coefficient
search enters this proof.

This configuration is primitive, sorted, has exactly `N` original labels,
and lies in the retained finite regime. For the original stationary runner,
every moving phase `i/N` lies in `[1/N,1-1/N]`. At the same positive time
`t=1/N`, any two distinct original labels have phase difference `k/N` with
`1≤|k|≤N-1`, so their circle distance is at least `1/N`. Equality is allowed
and attained. No time is borrowed from another runner or a deduplicated tuple.

Hence the proposed universal claim that every retained configuration admits
this kind of favorable endpoint packet is false, even allowing a different
packet for each runner. This is a mechanism counterexample, not an LRC
counterexample. Other affine decompositions, improved free-phase margins,
and unrelated witness constructions are not excluded.

## Meaning for minimality and the remaining gap

Assume `H_N` explicitly and consider a hypothetical primitive sorted failure
at a fixed original runner. The verified theorem already puts it in the
inclusive regime `H≤Q^(N-2)`. A global packet satisfying (G) would contradict
that failure by Lemma 1 and the existing affine witness theorem.

Even if least-count and least-height arguments have legitimately provided
smaller-count and smaller-height witnesses, denominator folding does not
consume the latter: it reparametrizes an unchanged actual tuple. Without a
packet there is no input for that descent. Proposition 3 shows that packet
failure is not an inconsistent arithmetic condition that can simply be
excluded without a separate witness argument.

**Do not reverse (1).** It bounds successful packet heights, not
counterexample heights. It gives no lower height bound for a counterexample
and no packet guarantee above its threshold. Below (1), global packet failure
is automatic for every configuration. Existing small-height theorems cover
part of this range; no coverage of the remaining finite region is proved here.

The precise missing step remains a shared-time witness for primitive retained
tuples not already handled by a sufficient construction, or a justified
descent of those **actual** tuples together with a witness-transfer theorem.
Assuming that supply under a new name would restate the unsupplied obligation.
This audit supplies neither such a descent nor uniform `F_N`; it stops at
the exact obstruction to the selected endpoint-packet mechanism.

## Fixed exact controls and replay

The program uses only `N=(3,4,5,6,7,8,11,12)`. It constructs the proved sharp
families and checks count, primitivity, actual-speed identity, rank minor,
residual fibres, closed error bounds, and folds of `q=L+kH` for `k=0,1,2`.
It checks the original consecutive family at `t=1/N` separately. No tuples,
times, or denominators are searched for.

There are eight sharp families (four odd, four even), 24 packet instances,
16 strict auxiliary descents, 168 coefficient identity checks, 1,392 relative
error checks, and 408 actual consecutive-family comparisons, including 48
against the original stationary runner. Sharp-family checks certify packets,
not general `H_N`. The consecutive witnesses are unconditional.

The first execution reached reporting assertions after all mathematical
checks and caught two hand-tallied count typos. Correcting the expected
counts to 1,392 and 408 produced exit zero; no fixture, inequality, or
mathematical assertion was weakened. The complete corrected program follows.

```python
from fractions import Fraction as F
from math import gcd
from collections import Counter
from pathlib import Path
from hashlib import sha256
import json

bindings={
 'LonelyRunner/AffineLonelyAt.lean':'19ef8e3e8b5cc0364b74d13cfb93b608adf176ffdbb1a7e020e2d5f1b484ec7b',
 'research/astra-finite-height-formal-review.md':'723e52d4ba10a5e8976c301c2f94e312d77c8d1afb42d4ce37b4082892fd0375',
 'LonelyRunner/FiniteHeightReduction.lean':'61a5ac9e27c58db10bf014bd91346769665038ebb3c05689237870de49279be1',
 'research/astra-affine-finite-height-audit.md':'6b676a05eb3a0036cd69e779150a5f1a868024d089ea75c142daeddccede938f'}
for path,wanted in bindings.items():
    assert sha256(Path(path).read_bytes()).hexdigest()==wanted,path

# Fixed parameters of the proved construction, not a tuple search.
parameters=(3,4,5,6,7,8,11,12)
counts=Counter()
certificates=[]
def norm(x):
    x=F(x)%1
    return min(x,1-x)

def inspect_packet(s,q,u):
    N,H=len(s),s[-1]
    Q=N*(N-1)
    p=F(H,q)
    R=tuple(q*a-H*b for a,b in zip(s,u))
    v=tuple(F(r,q) for r in R)
    assert q>0 and s[0]==0 and u[0]==0 and u[-1]==q
    assert R[0]==R[-1]==0 and any(R)
    assert all(p*b+c==a for a,b,c in zip(s,u,v))
    assert any(q*c!=0 for c in v)  # endpoint minor with (u_last,v_last)=(q,0)
    K=max(R)-min(R)
    g=gcd(q,H)
    assert all(r%g==0 for r in R) and K%g==0 and K>=g>0
    assert len({a%H for a in s[:-1]})==N-1
    groups=Counter(R[:-1])
    assert max(groups.values())<=g
    assert len(groups)<=K//g+1
    assert N-1<=g*len(groups)<=K+g<=2*K
    assert F(K)<=F(2*H,Q)<H
    assert H>=Q*(N//2)//2
    for i in range(N):
        for r in range(N):
            assert abs(v[i]-v[r])<=2*p/Q
            counts['relative_error_checks']+=1
    # A multiple of H cannot survive rank two and this error bound.
    q0=q%H
    assert 0<q0<H
    k=q//H
    up=tuple(b-k*a for a,b in zip(s,u))
    pp=F(H,q0)
    vp=tuple(F(r,q0) for r in R)
    assert up[0]==0 and up[-1]==q0 and pp>1
    assert all(pp*b+c==a for a,b,c in zip(s,up,vp))
    assert tuple(q0*a-H*b for a,b in zip(s,up))==R
    assert any(q0*c!=0 for c in vp)
    assert max(vp)-min(vp)<=2*pp/Q
    if q>=H:
        assert q0<q and p<1
        counts['strict_auxiliary_descents']+=1
    else:
        assert q0==q and up==u and vp==v
    counts['packet_instances']+=1
    counts['coefficient_identity_checks']+=N
    return R,K,g,q0,up

for N in parameters:
    Q=N*(N-1)
    h=Q//2
    L=N//2  # ceil((N-1)/2)
    H=L*h
    full={j*h+e for j in range(L) for e in (0,1)}|{H}
    if N%2==0:
        assert L>=2
        full.remove((L-1)*h+1)
    s=tuple(sorted(full))
    assert len(s)==N and s[0]==0 and s[1]==1 and s[-1]==H
    assert gcd(*s)==1 and all(a<b for a,b in zip(s,s[1:]))
    assert H==F(Q*L,2) and H<=Q**(N-2)
    u=tuple(a//h for a in s)
    v=tuple(F(a)-h*b for a,b in zip(s,u))
    assert set(v)=={F(0),F(1)} and max(v)-min(v)==F(2*h,Q)
    assert u[0]==0 and u[-1]==L and u[1]==0 and v[1]==1
    for lift in (0,1,2):
        q=L+lift*H
        ulift=tuple(b+lift*a for a,b in zip(s,u))
        R,K,g,q0,up=inspect_packet(s,q,ulift)
        assert K==g==L and q0==L and up==u
    certificates.append(dict(N=N,H=H,q=L,s=list(s),u=list(u),v=list(map(str,v))))
    counts['sharp_families']+=1
    counts['odd_sharp_families' if N%2 else 'even_sharp_families']+=1

    # Consecutive speeds: integer relative residual error <1 forces rank one.
    c=tuple(range(N))
    radius=F(2*(N-1),Q)
    assert radius==F(2,N)<1
    assert c[-1]<H and gcd(*c)==1
    t=F(1,N)
    for r in range(N):
        for i in range(N):
            if i!=r:
                assert norm(t*(c[i]-c[r]))>=F(1,N)
                counts['consecutive_original_comparisons']+=1
                counts['consecutive_stationary_comparisons']+=r==0
    counts['consecutive_families']+=1

assert counts['packet_instances']==24 and counts['strict_auxiliary_descents']==16
assert counts['sharp_families']==8 and counts['consecutive_families']==8
assert counts['odd_sharp_families']==counts['even_sharp_families']==4
assert counts['relative_error_checks']==1392
assert counts['consecutive_original_comparisons']==408
assert counts['consecutive_stationary_comparisons']==48
print(json.dumps(dict(counts=dict(sorted(counts.items())),sharp_certificates=certificates),sort_keys=True))
```

Run from the repository root. The sole Python block above is the complete
reproducer; it checks the four frozen foundation hashes before its controls.
The following extraction command avoids depending on a surviving temporary file.

```sh
python3 -B - <<'UNIFORM_SUPPLY_REPLAY'
import re
from pathlib import Path
from hashlib import sha256
text = Path('research/astra-uniform-finite-supply-audit.md').read_text()
blocks = re.findall(r'^```python\n(.*?)^```[ \t]*$', text, re.M | re.S)
assert len(blocks) == 1
program = blocks[0]
assert sha256(program.encode()).hexdigest() == 'c51414578f21bb121ca0bdf50f6f26c0271e3930a27907be87c999250ce62301'
exec(compile(program, 'uniform-finite-supply-controls', 'exec'))
UNIFORM_SUPPLY_REPLAY
```

Observed replay: exit zero. Reproducer SHA-256:
`c51414578f21bb121ca0bdf50f6f26c0271e3930a27907be87c999250ce62301`. Its single-line JSON output (including trailing newline)
has SHA-256 `01af7ac7db4b1216ee456a0904d46fa87cb448568f231cf103ac646c712649ae`.
The parameter/count record above matches that output. Workflow structural
validation also passed; no Lean compilation or finite search was performed.

The three results are self-contained manuscript proofs with fixed rational
controls, pending independent semantic review. The existing conditional affine
and large-height theorems remain the only kernel results invoked. The retained
uniform supply is still missing. This bounded branch is frozen for review;
no author commands remain running at handoff.
