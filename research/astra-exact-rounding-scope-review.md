# Independent review of exact-rounding supply scope

2026-09-05. Requested Astra xhigh, task
`/root/guard_internal_cover_audit-exact-rounding-review`, assigned main
`a4c395827100593500747904a1a11f4251fdb271`. Current project configuration,
workflow, policy, and state were read; research is authorized and workflow
structural validation passed. Runtime model/effort metadata was not independently
exposed. Only this review and small temporary controls were written.

**Accepted as a manuscript result, with no mathematical correction required.**
The frozen source is `research/astra-exact-rounding-scope-audit.md`, SHA-256
`ba16410bdd0ca08262573fbfa36d6e46078a7b3910f68e7593318dea63d78c3c`.
Its exact rounding identity, free-time equivalence for every original chosen
label, and universal obstruction to retaining the collision's own-count
margin are valid with the stated distinct scopes. None is a new Lean theorem,
a solution of the finite-family obligation, or an unrestricted LRC result.

## Contract and exact transport

The input is a sorted distinct integer tuple `0=s0<...<s_(N-1)=H`, N>=3,
and an original chosen label r. Positive integer q and integral u have endpoints
u0=0 and u_last=q. Put p=H/q and v=s-p*u. No approximation-error budget is
included in E_r or S_r. For each of the N-1 original comparisons, use

```text
sigma_i=sign(s_i-s_r), W_i=|s_i-s_r|,
U_i=sigma_i*(u_i-u_r), V_i=sigma_i*(v_i-v_r),
W_i=p*U_i+V_i, q*V_i integral.
```

For distinct comparison labels a,b, `beta=W_a+W_b>0`,
`alpha=-(U_a+U_b)`, and `w_i=beta*U_i+alpha*W_i` are integral. The
nowhere-zero requirement is explicit. Since w_a=-w_b, the number c of
distinct positive absolute magnitudes satisfies `1<=c<=N-2`. Original
comparison labels and the canonical denominator N are retained even when
some W_i or some |w_i| repeat.

I independently expanded the phase definitions. For any real tau and
`x=(alpha*p+beta)*tau`, `y0=alpha*tau`, set
`n=1-floor(y0/q)`, `y=y0+q*n`. Then q<=y<2q and

```text
p*y-x = H*n-beta*tau.
```

H*n is an integer. Thus any nearest integer j has
`|j-(p*y-x)|=norm(beta*tau)`, including both tie choices and negative
arguments. For `t=(j+x)/p`, this proves the exact equality

```text
|t-y|=norm(beta*tau)/p.
```

Also `t>=q-1/(2p)=q*(1-1/(2H))>0`, using H>=2, so p<1 is allowed.
The relevant common period is q: V_i*q is integral, whereas V_i need not
be integral. Expanding the comparison at t gives

```text
W_i*t = U_i*j + w_i*tau + V_i*q*n + V_i*(t-y).
```

The first and third terms are integers. Sign invariance and the circle
norm's Lipschitz inequality therefore give exactly

```text
norm((s_i-s_r)*t) >= norm(w_i*tau)
                       - |v_i-v_r|*norm(beta*tau)/p.          (E-bound)
```

There is no omitted simultaneous-phase or relation-compatibility assumption.
The construction explicitly produces the single common time t. Negative or
zero y0, nonmonotone integral u, and nearest-integer equalities are covered.

E_r existentially requires all E-bound right sides to be at least 1/N.
S_r requires the same packet and the same tau additionally to satisfy
`norm(w_i*tau)>=1/(c+1)` for every comparison. Thus
`S_r => E_r => original witness`. Applying H_N to the distinct positive
magnitudes of w gives a time with the latter own-count property only. It
does not put that time in the E_r inequalities. This quantifier distinction
is essential; the source maintains it correctly.

## Pair-sum completeness and all-chosen free equivalence

I checked section 2 of `docs/round6-strategies.md` and independently supplied
the following details of its paper argument. Let W be any finite family of
at least two positive integer magnitudes, with repetitions allowed. The
continuous period-one function `F(T)=min_i norm(W_i*T)` attains a maximum M
on [0,1]. At `T=1/(4*max_i W_i)` every term is positive, so M>0. Any
maximizer T lies strictly between 0 and 1 because both endpoints have value 0.

If M=1/2, every phase is half-integral; any two distinct labels yield
`(W_a+W_b)*T` integral. This includes repeated speeds, such as (1,1).
If 0<M<1/2, every active wave is locally affine with slope either +W_i
or -W_i: its phase is neither an integer nor a half-integer. There are
finitely many inactive waves and each has strict slack above M, so one common
neighborhood preserves all their strict inequalities. If all active slopes
had one sign, moving slightly in that sign's increasing direction would
increase the whole minimum, contradicting maximality. Consequently two
distinct active labels have opposite slopes. Their fractional phases are
M and 1-M, and their sum gives `(W_a+W_b)*T` integral. This proves the
needed pair-sum witness whenever an original witness exists. No historical
finite scan or unproved Lean completeness declaration is needed.

Apply this argument to all `W_i=|s_i-s_r|`, without deduplicating their
original labels. Obtain `T=k0/beta` with 0<T<1 and beta=W_a+W_b. The
monotone binary cut

```text
q=1; u_j=0 for j<=min(a,b), and u_j=1 otherwise
```

has both required endpoints and separates a and b. For every comparison,
monotonicity of s and u implies
`sigma_i*(u_i-u_r)=|u_i-u_r|` in {0,1}. Regardless of which side contains
r, exactly one of a,b has binary value different from u_r. Thus
`U_a+U_b=1`, alpha=-1, and `w_i=beta*U_i-W_i`.

If U_i=0, w_i is negative and nonzero. If U_i=1 and w_i=0, then
W_i=beta and the supplied witness has W_i*T=k0 integral, contradicting
its positive threshold. Hence the packet is nowhere zero. This verifies
the cut for lower, upper, and internal chosen labels, including both signs
and repeated relative magnitudes. It does not assume r lies outside the
two selected labels in the speed order; it needs only r!=a,b.

With tau=-T, direct substitution yields

```text
beta*tau=-k0, y0=T, y=T+1, x=(H-beta)*T,
D=j=H+k0, t=T+1, w_i*tau=W_i*T-k0*U_i.
```

Thus rounding is zero, original norms are exactly preserved, and E_r holds.
Conversely E_r yields an original witness by the already proved transport.
This establishes the pointwise equivalence for every chosen r, with time,
pair, and packet allowed to depend on r. An added rank-two requirement on
the anchored rows (u,v) is also met: an internal coordinate has nonzero
v_i=s_i-H*u_i, while the last coordinate is (u,v)=(1,0). That fact is not
used to drop any other premise.

The encoded collision margin is only the original margin, at least 1/N;
it need not be 1/(c+1). Therefore this proof concerns E_r and does not
establish witness => S_r. It does not prove an equivalence for a packet
class retaining an additional worst-case approximation-error budget either.
There is no claim of a common witness time for all runners, a same-count
real-speed reduction, or a theorem for N=2.

## Universal retained-margin obstruction and separate fixtures

For r=0, the last comparison satisfies U_last=q and V_last=0. Hence
`w_last=beta*q+alpha*H`. Multiplication of `t=(j+x)/p` by H gives

```text
H*t=q*j+w_last*tau, so norm(H*t)=norm(w_last*tau).
```

This identity holds for every integer j and every q>0, independent of
nearest rounding, tau's sign, or any finite parameter restriction. An S_0
packet would therefore produce an original witness at which the last speed
has norm at least `1/(c+1)>=1/(N-1)`.

For N=4 and s=(0,1,2,3), I recomputed the full closed-band intersections.
The first two constraints restrict T modulo one to
`[1/4,3/8] union [5/8,3/4]`. Speed 3 has bands
`[1/12,1/4]`, `[5/12,7/12]`, and `[3/4,11/12]`. The intersection is
exactly the two singleton points `{1/4,3/4}`. At both, norm(3*T)=1/4.
But c<=2 would require that same norm to be at least 1/3. This excludes
every q,u,pair,tau satisfying S_0, not just the tested rational parameters.
Closed endpoints are indispensable and are retained. The tuple itself has
a witness, is primitive, and has H=3<=12^2 in the retained finite family.

The source's two additional fixtures have different scopes:

- For N=4, s=(0,1,3,4), r=0, q=1, u=(0,0,1,1), label pair (1,3),
  tau=1/3, the collision is (-1,2,1), c=2. The exact shift is 1/12,
  the returned time is 19/12, and the E-bound values are (1/4,1/4,1/3).
  Both E and the own-count margin hold. The actual norms are
  (5/12,1/4,1/3). The worst-case loss 1/8 would fail the available 1/12
  slack. This is an actual success of the stronger conditional criterion.
- For the fixed N=5 packet s=(0,1,2,3,4), u=(0,0,0,1,1), q=1, r=0,
  label pair (1,4), the collision is (-1,-2,2,1), c=2. At tau=1/5,
  E holds and the own-count margin fails. Its own-count good set is exactly
  tau congruent to 1/3 or 2/3 modulo one. At either, the speed-2 E-bound
  is 1/6<1/5. This rejects all own-count times for this packet only; the
  N=4 consecutive endpoint argument, not this fixed packet, proves the
  universal obstruction.

No example refutes LRC or a covering disjunction with other direct-modulus,
height, or insertion theorems. In particular these small tuples are already
handled by existing methods and cannot stand in for legitimate minimal
counterexamples. The remaining problem is a justified sufficient supply on
the unresolved families, rather than removal of a premise from S_r.

## Independent reproduction

The author manuscript was read in full, including the full control program;
the relevant historical pair-sum section and actual source interfaces
`AffinePhaseTransfer.lean`, `AffinePhasePeriod.lean`, and
`LowerCountSupply.lean` were inspected. The author replay checks their frozen
hashes and the adaptive-note hash. I extracted its sole Python block using
line-anchored Markdown fences and ran it unchanged with `python3 -B`.
Its program SHA-256 was
`574ed2179ecdbb72e6a87edba04b3de604b3e235dceece0a55fa4bf4fd6eee19`
and its output SHA-256 was
`b173bc182367da50400fa5407ed8ba97ad8aaf3f77fe4ba4eaa3c93821f95963`,
both matching the source. It passed 14 rounding instances, 50 comparison
checks, 11 endpoint identities, both tie choices, five binary cuts, and
both complete interval certificates.

The separate program below uses only fixed supplied data: nonmonotone rows
with negative U; internal and upper chosen labels; q=10 with p=9/10;
negative, zero, and positive tau; alpha=0 and c=1; both nearest choices
at ties; all chosen labels on N=3 and N=4 binary-cut fixtures; and the two
source fixtures and exact interval intersections. The N=3 central runner
explicitly tests repeated magnitudes (1,1) and the maximum-1/2 case. It
performs no discovery search. Universal statements above are justified by
the independent arguments, not these finite controls.

Save the following sole Python block, retaining its trailing newline, as
`/tmp/astra-exact-rounding-review-controls.py`. Run
`python3 -B /tmp/astra-exact-rounding-review-controls.py > /tmp/astra-exact-rounding-review-controls.json`.
The complete program SHA-256 is
`f964a47b7d6767465676919da17d1c6317c8a0c363965bcd02e7ff21ff199915`;
the full single-line JSON output, including its trailing newline, has SHA-256
`46715a3ec6eb6a27d84ff5908803d0f254d5c7215f5b78b6ec55d148dbafc5c3`.

```python
from fractions import Fraction as F
from math import floor
from collections import Counter
import json

# Fixed supplied fixtures only. No tuple/packet/witness discovery search.
counts = Counter()
records = []

def norm(x):
    z = x - floor(x)
    return min(z, 1 - z)

def verify(name, s, q, u, r, pair, tau):
    N, H = len(s), s[-1]
    assert N >= 3 and s[0] == u[0] == 0 and u[-1] == q > 0
    assert all(s[i] < s[i+1] for i in range(N-1))
    I = [i for i in range(N) if i != r]
    a, b = pair
    assert a in I and b in I and a != b
    p = F(H, q)
    v = [F(si) - p*ui for si, ui in zip(s, u)]
    W = {i: abs(s[i]-s[r]) for i in I}
    U = {i: (1 if s[i] > s[r] else -1)*(u[i]-u[r]) for i in I}
    V = {i: W[i] - p*U[i] for i in I}
    alpha, beta = -U[a]-U[b], W[a]+W[b]
    w = {i: beta*U[i]+alpha*W[i] for i in I}
    assert all(w.values()) and w[a] == -w[b]
    c = len(set(abs(z) for z in w.values()))
    assert 1 <= c <= N-2
    x, y0 = (alpha*p+beta)*tau, alpha*tau
    n = 1-floor(y0/q)
    y, D = y0+q*n, H*n-beta*tau
    assert D == p*y-x and q <= y < 2*q
    lower = {i: norm(w[i]*tau)-abs(v[i]-v[r])*norm(beta*tau)/p for i in I}
    own = min(norm(z*tau) for z in w.values()) >= F(1, c+1)
    free = min(lower.values()) >= F(1, N)
    # The two neighboring integers are an independent nearest-point control;
    # retain both when they tie, including for negative D.
    nearby = (floor(D), floor(D)+1)
    error = min(abs(F(j)-D) for j in nearby)
    nearest = [j for j in nearby if abs(F(j)-D) == error]
    assert error == norm(beta*tau)
    if len(nearest) == 2:
        counts['tie_packets'] += 1
    times = []
    for j in nearest:
        t = (j+x)/p
        assert abs(t-y) == norm(beta*tau)/p
        assert t >= q-F(1, 2)/p > 0
        for i in I:
            assert abs(V[i]) == abs(v[i]-v[r])
            assert (q*V[i]).denominator == 1
            assert w[i]*tau == U[i]*x+V[i]*y0
            assert W[i]*t == U[i]*j+w[i]*tau+q*V[i]*n+V[i]*(t-y)
            assert norm((s[i]-s[r])*t) >= lower[i]
            if free:
                assert norm((s[i]-s[r])*t) >= F(1, N)
            counts['phase_checks'] += 1
        if r in (0, N-1):
            endpoint = N-1 if r == 0 else 0
            assert H*t == q*j+w[endpoint]*tau
            assert norm(H*t) == norm(w[endpoint]*tau)
            counts['endpoint_checks'] += 1
        counts['nearest_choices'] += 1
        times.append(str(t))
    counts['packet_instances'] += 1
    records.append(dict(name=name, r=r, q=q, alpha=alpha, beta=beta,
                        w=[w[i] for i in I], c=c, tau=str(tau),
                        rounding=str(error), times=times, free=free, own=own,
                        lower=[str(lower[i]) for i in I]))
    return records[-1]

# Nonmonotone endpoint rows test unrestricted integer U and both signs.
s, u = (0, 2, 5, 9), (0, -1, 2, 1)
for name, q, row, r, pair, tau in [
    ('nonmonotone negative tau', 1, u, 0, (1,2), F(-7,20)),
    ('nonmonotone zero tau', 1, u, 0, (1,2), F(0)),
    ('nonmonotone tie', 1, u, 0, (1,2), F(1,14)),
    ('nonminimal period p below one', 10, tuple(a+b for a,b in zip(s,u)),
        0, (1,2), F(11,21)),
    ('internal chosen sign normalization', 1, u, 1, (0,2), F(2,15)),
    ('upper chosen sign normalization', 1, u, 3, (0,1), F(-5,18)),
]:
    verify(name, s, q, row, r, pair, tau)
z = verify('alpha zero tie', (0,1,3,4), 1, (0,-1,1,1), 0, (1,2), F(1,8))
assert z['alpha'] == 0 and z['c'] == 1 and z['own'] and not z['free']

# Literal source fixtures remain separate from the universal obstruction.
z = verify('N4 actual exact-loss success', (0,1,3,4), 1, (0,0,1,1),
           0, (1,3), F(1,3))
assert z['free'] and z['own'] and z['times'] == ['19/12']
assert z['lower'] == ['1/4','1/4','1/3']
assert [norm(F(19,12)*a) for a in (1,3,4)] == [F(5,12), F(1,4), F(1,3)]
assert F(1,8) > F(1,3)-F(1,4)

def closed_good(magnitudes, delta):
    # Intersect exact closed bands on one full period; singleton bands survive.
    out = [(F(0), F(1))]
    for a in magnitudes:
        new = []
        for lo, hi in out:
            for k in range(a):
                left, right = max(lo, (k+delta)/a), min(hi, (k+1-delta)/a)
                if left <= right:
                    new.append((left,right))
        out = sorted(set(new))
    return out

G4 = closed_good((1,2,3), F(1,4))
assert G4 == [(F(1,4),F(1,4)), (F(3,4),F(3,4))]
assert all(norm(3*a) == F(1,4) < F(1,3) for a,b in G4)
own_times = closed_good((1,2), F(1,3))
assert own_times == [(F(1,3),F(1,3)),(F(2,3),F(2,3))]
counts['complete_closed_intersections'] = 2

s5, u5 = (0,1,2,3,4), (0,0,0,1,1)
z = verify('N5 free without own margin', s5, 1, u5, 0, (1,4), F(1,5))
assert z['free'] and not z['own'] and z['times'] == ['9/5']
for a,b in own_times:
    assert a == b
    z = verify('N5 fixed own-margin rejection '+str(a), s5, 1, u5, 0, (1,4), a)
    assert z['own'] and not z['free'] and z['lower'][1] == '1/6'

# Different fixed binary-cut controls: all labels for N=3 and N=4.
# N=3, r=1 has repeated magnitudes (1,1), realizing the M=1/2 branch.
for s, r, pair, T in [
    ((0,1,2), 0, (1,2), F(1,3)),
    ((0,1,2), 1, (0,2), F(1,2)),
    ((0,1,2), 2, (0,1), F(1,3)),
    ((0,1,3,4), 0, (2,3), F(3,7)),
    ((0,1,3,4), 1, (0,3), F(1,4)),
    ((0,1,3,4), 2, (0,3), F(1,4)),
    ((0,1,3,4), 3, (0,1), F(3,7)),
]:
    N, H = len(s), s[-1]
    beta = sum(abs(s[i]-s[r]) for i in pair)
    assert 0 < T < 1 and (beta*T).denominator == 1
    assert all(norm((si-s[r])*T) >= F(1,N) for i,si in enumerate(s) if i != r)
    row = tuple(int(i > min(pair)) for i in range(N))
    z = verify('binary cut N'+str(N)+' r'+str(r), s, 1, row, r, pair, -T)
    assert z['alpha'] == -1 and z['free'] and z['rounding'] == '0'
    assert z['times'] == [str(T+1)]
    counts['binary_cut_controls'] += 1

assert counts['packet_instances'] == 18 and counts['nearest_choices'] == 20
assert counts['phase_checks'] == 60 and counts['endpoint_checks'] == 16
assert counts['tie_packets'] == 2 and counts['binary_cut_controls'] == 7
print(json.dumps(dict(counts=dict(sorted(counts.items())), records=records,
                     quarter_good=[[str(a),str(b)] for a,b in G4],
                     fixed_own_good=[[str(a),str(b)] for a,b in own_times]),
                 sort_keys=True))
```

Actual independent outcome: all 18 fixed packet instances passed their asserted
identities and classifications, with 20 nearest-integer choices, 60 signed
comparison checks, 16 endpoint identities, seven binary-cut controls, and two
complete closed-band intersections. Two packets exercised both tie choices.
The original author replay and workflow validation also passed. No corrected
manuscript, new mathematical search, source edit, Lean execution, dependency
restoration, cache operation, state edit, or Git mutation was needed.

The review accepts precisely the frozen manuscript's three stated results.
The exact-rounding identity and binary-cut/pair-sum equivalence remain paper
proofs, and the all-parameter retained-margin obstruction is independent of
any search cutoff. Formalization and a useful supply for the unresolved
finite families remain unsupplied. Full LRC is unresolved. All review commands
were completed at freeze; no background process remains from this review.
