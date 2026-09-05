# Independent review of endpoint-packet folding and height obstructions

**Disposition: accepted at the manuscript's stated scope, without correction.**
The denominator-folding lemma, sharp lower bound for a global endpoint
packet, parity-sensitive equality construction, and consecutive-family
obstruction are valid. None proves uniform F_N, a bound in the opposite
direction on counterexample height, or an LRC counterexample.

Requested role: Astra xhigh. Runtime model/effort metadata was not independently
exposed. Registered task: `/root/cluster_limit_review-uniform-finite-supply`.
Assignment checkpoint: `bf31ea82629c4101755e950faeb6e406fae7c1c9`.
The frozen author's earlier assignment checkpoint is recorded in its file.
Current configuration, workflow document, policy, and state were read;
`python3 -B scripts/validate_workflow.py` passed. Research is active and
the unrestricted goal is unresolved. Only this review and a small temporary
exact-control log are written; no Lean or cache operation is needed.

## Frozen evidence and actual formal interfaces

| File | SHA-256 |
| --- | --- |
| `research/astra-uniform-finite-supply-audit.md` | `ab8838edae5de0e1b08fabb72a091f141387ba84ecb37ce7c3465c992c5320f5` |
| `LonelyRunner/FiniteHeightReduction.lean` | `61a5ac9e27c58db10bf014bd91346769665038ebb3c05689237870de49279be1` |
| `LonelyRunner/AffineLonelyAt.lean` | `19ef8e3e8b5cc0364b74d13cfb93b608adf176ffdbb1a7e020e2d5f1b484ec7b` |
| `research/astra-affine-finite-height-audit.md` | `6b676a05eb3a0036cd69e779150a5f1a868024d089ea75c142daeddccede938f` |
| `research/astra-finite-height-formal-review.md` | `723e52d4ba10a5e8976c301c2f94e312d77c8d1afb42d4ce37b4082892fd0375` |

The current frozen Lean bodies were reread. `rational_affine_lonelyAt`
requires p>1, a positive natural common period, zero anchors, rank two,
actual-speed injectivity, H_N, and the relative error bound for the chosen
runner. It does not itself require a global spread bound. The manuscript
supplies the former hypotheses by folding and obtains every chosen runner's
relative bound from the stronger single global packet condition.

`primitive_sorted_largeHeight_lonelyAt` still takes primitive sorted natural
speeds, H_N, and the strict height inequality H>[N(N-1)]^(N-2). It makes
no assertion that any retained tuple supplies an endpoint packet. Its type
does not turn failure to find such a packet into failure of loneliness.
The previously reviewed denominator clearing, phase normalization, signed
comparison, and canonical-label contracts remain unchanged. The new three
structural claims are manuscript results, not additional kernel declarations.

## Independent derivation

Let N>=3, Q=N(N-1), and 0=s0<...<s_(N-1)=H be the actual integer speeds.
An endpoint packet has integer q>0, integer u with u0=0 and u_last=q,
p=H/q, and v=s-p*u. Put R_i=q*s_i-H*u_i=q*v_i, and let
K=max R-min R. Both endpoint residuals are zero. The endpoint minor with
coordinate i is -q*v_i=-R_i; hence rank two is equivalent to some R_i
being nonzero. It is also equivalent to K>0, since a constant residual row
containing zero is zero. No primitivity is needed for these equivalences.

The global condition is exactly K<=2H/Q. It is equivalent to the relative
condition for every pair of labels from that one packet, because a finite
real row's maximum pairwise difference equals its spread. The relative
condition about one specified runner is weaker and will remain distinct.

### Folding

Since Q>=6, the global condition gives K<=2H/Q<H. Zero is among the
residuals, so every |R_i|<=K<H. If H divides q, every R_i is divisible
by H. The strict absolute bound would force all residuals to vanish,
contradicting rank two. Therefore q0=q mod H satisfies 0<q0<H.

Write q=kH+q0 and set u'_i=u_i-k*s_i. Then
q0*s_i-H*u'_i=R_i exactly. Define p'=H/q0 and v'_i=R_i/q0.
The endpoints become u'_0=0, u'_last=q0, v'_0=v'_last=0; each original
speed is still p'*u'_i+v'_i=s_i. The same nonzero residual gives a nonzero
minor, and q0*v'_i is the integer R_i. Also
osc(v')=K/q0<=2H/(Q*q0)=2p'/Q and p'>1.

When q<H this is the identity change; when q>=H it strictly reduces q
and reaches the desired range in one step. It never reduces H, N, or any
actual original speed. In particular, a witness for the auxiliary integer
row u' has not been supplied or transported. Applying the existing affine
theorem to the folded packet requires H_N, exactly as the manuscript states.
The arithmetic folding lemma itself needs no LRC hypothesis.

### Necessary height for a global packet

Let g=gcd(q,H)>0. All residuals are multiples of g. Since K>0 is itself
a multiple of g, K>=g. The closed interval between the extreme residuals
contains K/g+1 multiples of g, including both endpoints.

Only s0,...,s_(N-2) give distinct classes modulo H: the final speed H
duplicates the zero class. Thus there are exactly N-1 input residue classes
for the counting argument. Multiplication by q modulo H has fibers of
size at most g. To verify this independently, divide q and H by g; the
reduced q is invertible modulo H/g, so a soluble congruence fixes one
class modulo H/g and has exactly g representatives modulo H. An insoluble
congruence has none.

Every group of original speeds with a fixed residual value is contained in
one such fiber. Hence

`N-1 <= g*(K/g+1) = K+g <= 2K`.

Since K is integral, K>=ceil((N-1)/2)=floor(N/2). Combining this with
K<=2H/Q proves H>=(Q/2)*floor(N/2). Counting N rather than N-1, discarding
an interval endpoint, or assuming g=1 would be incorrect. The bound is
necessary for successful global packets even for nonprimitive tuples.

### Equality and parity

Put L=floor(N/2), h=Q/2, H=Lh. The set of pairs jh,jh+1 for 0<=j<L,
together with H, has 2L+1 distinct speeds because h>=3. For odd N this
is already the required count. For even N>=4, deleting the author's stated
(L-1)h+1 leaves N speeds and retains zero, one, and H; L>=2 guarantees
these are different from the deleted speed. Presence of one gives primitivity.

At q=L and p=h, the floor row u(s)=floor(s/h) gives v(s) in {0,1},
including both values. The endpoint and speed one provide rank two, and
osc(v)=1=2p/Q exactly. This proves sharpness for every N>=3, with the
closed error boundary essential. It means that at least one tuple attains
the minimum possible successful-packet height for each N. It is not a
packet-existence theorem for every tuple above that height.

### Consecutive family and exact scope

For the actual tuple {0,1,...,N-1}, H=N-1. A packet satisfying the error
condition around any chosen r would have integer residual differences
|R_i-R_r|<=2H/Q=2/N<1. These differences must all be zero. An endpoint
residual is zero, so every residual is zero and rank two fails. This
argument quantifies over every integer q>0 and every integer u with the
endpoint constraints; no denominator search is being substituted for it.

Nevertheless t=1/N is a simultaneous witness for all actual chosen runners:
the nonzero signed differences are integers k with 1<=|k|<=N-1, and
||k/N||>=1/N. The primitive consecutive tuple is inside the retained
finite regime. Thus even separately selected packets for each runner in
this exact error class cannot be a universal supply for F_N. This is a
counterexample to the auxiliary mechanism, not to LRC.

An additional exact control makes the distinction between global and
individual packets concrete. For S=(0,1,5,6), q=1, u=(0,0,1,1), p=6,
the residual and v rows are (0,1,-1,0). The allowable relative radius is
2p/Q=1. The chosen runners 0 and 6 satisfy that radius, whereas the full
spread is 2 and violates the global condition. Here H=6 is below the
global-packet lower bound 12. The direct time 1/4 witnesses those two
chosen runners. This does not contradict the manuscript; it demonstrates
why its sharp global height bound must not be applied to individual packets.

Under H_N, failure at a fixed primitive original runner is still confined
by the formal large-height theorem to H<=Q^(N-2). A global successful
packet would exclude such a failure. The converse does not hold: absence
of a packet does not imply failure, impose a lower bound on counterexample
height, or supply a smaller-height actual tuple. The consecutive witnesses
show why packet absence alone is consistent. The manuscript correctly
leaves F_N and unrestricted LRC unresolved. No novelty claim is made.

## Independent exact controls

The sole Python block below is independently authored and does not execute
the author's program. Six sharp constructions use N=(3,4,9,10,13,14).
For even N the checker deletes h, a different permissible internal speed
from the author's deletion, while retaining the same proved equality.
Two further fixed global packets have signed residuals and K>g; one is
nonprimitive. Each of these eight packets is lifted and folded at the three
literal denominator offsets k=(0,3,19).

The residue-fiber check evaluates exactly the H residue classes for each
of these fixed instances; its largest H is 637. This verifies a fixed
modular multiplication identity, not a search over speed tuples, witnesses,
denominators, or F_N. Remaining controls check consecutive witnesses, both
kinds of q divisible by H excluded by the premises, duplicated speed labels,
the required N-1 residue count, and the individual/global scope distinction.
All arithmetic uses exact integers or fractions.

```python
from fractions import Fraction as F
from math import gcd
from collections import Counter
from pathlib import Path
from hashlib import sha256
import json

bindings = {
 'research/astra-uniform-finite-supply-audit.md':'ab8838edae5de0e1b08fabb72a091f141387ba84ecb37ce7c3465c992c5320f5',
 'LonelyRunner/FiniteHeightReduction.lean':'61a5ac9e27c58db10bf014bd91346769665038ebb3c05689237870de49279be1',
 'LonelyRunner/AffineLonelyAt.lean':'19ef8e3e8b5cc0364b74d13cfb93b608adf176ffdbb1a7e020e2d5f1b484ec7b',
 'research/astra-affine-finite-height-audit.md':'6b676a05eb3a0036cd69e779150a5f1a868024d089ea75c142daeddccede938f',
 'research/astra-finite-height-formal-review.md':'723e52d4ba10a5e8976c301c2f94e312d77c8d1afb42d4ce37b4082892fd0375',
}
for path,expected in bindings.items():
    assert sha256(Path(path).read_bytes()).hexdigest() == expected,path

def norm(x):
    f = F(x) % 1
    return min(f,1-f)

def rank_two(u,v):
    return any(u[i]*v[j] != u[j]*v[i] for i in range(len(u)) for j in range(i))

def data(s,q,u):
    assert q > 0 and len(s) == len(u) and s[0] == u[0] == 0 and u[-1] == q
    H = s[-1]
    p = F(H,q)
    R = tuple(q*a-H*b for a,b in zip(s,u))
    v = tuple(F(a,q) for a in R)
    assert R[0] == R[-1] == 0
    assert all(p*b+c == a for a,b,c in zip(s,u,v))
    assert rank_two(u,v) == any(R)
    return p,R,v,max(R)-min(R)

counts = Counter()
certificates = []

def global_and_fold(s,q,u):
    N,H = len(s),s[-1]
    Q = N*(N-1)
    assert N >= 3 and all(a < b for a,b in zip(s,s[1:]))
    p,R,v,K = data(s,q,u)
    assert rank_two(u,v) and 0 < K <= F(2*H,Q) < H
    assert max(v)-min(v) == F(K,q) <= 2*p/Q
    g = gcd(q,H)
    assert g > 0 and all(a % g == 0 for a in R) and K % g == 0 and K >= g
    assert len({a % H for a in s[:-1]}) == N-1
    assert all(a % H == q*b % H for a,b in zip(R,s))
    # This fixed finite map has exactly g preimages of each attained residue.
    fibers = Counter(q*x % H for x in range(H))
    assert set(fibers.values()) == {g} and len(fibers) == H//g
    groups = Counter(R[:-1])
    assert all(c <= fibers[a % H] == g for a,c in groups.items())
    assert len(groups) <= K//g+1
    assert N-1 <= g*len(groups) <= K+g <= 2*K
    assert K >= N//2 and H >= F(Q*(N//2),2)
    counts['residue_function_evaluations'] += H
    k,q0 = divmod(q,H)
    assert 0 < q0 < H and gcd(q0,H) == g
    up = tuple(b-k*a for a,b in zip(s,u))
    pp,Rp,vp,Kp = data(s,q0,up)
    assert Rp == R and Kp == K and pp > 1 and rank_two(up,vp)
    assert max(vp)-min(vp) <= 2*pp/Q
    assert tuple(pp*b+c for b,c in zip(up,vp)) == s
    assert all((q0*a).denominator == 1 for a in vp)
    for i in range(N):
        for r in range(N):
            assert abs(v[i]-v[r]) <= 2*p/Q
            assert abs(vp[i]-vp[r]) <= 2*pp/Q
            counts['relative_pair_checks'] += 1
    if q >= H:
        assert q0 < q and p < 1
        counts['strict_denominator_descents'] += 1
    else:
        assert q0 == q and up == u and vp == v and pp == p
        counts['identity_folds'] += 1
    counts['global_packet_instances'] += 1
    counts['coefficient_identity_slots'] += N
    counts['closed_global_boundary_instances'] += K == F(2*H,Q)
    return R,K,g,q0,up

parameters = (3,4,9,10,13,14)
packets = []
for N in parameters:
    Q,L = N*(N-1),N//2
    h = Q//2
    H = h*L
    S = {j*h+e for j in range(L) for e in [0,1]} | {H}
    assert len(S) == 2*L+1
    if N % 2 == 0:
        assert L >= 2 and h not in {0,1,H}
        S.remove(h)  # independent even-count deletion; retain speed one.
    s = tuple(sorted(S))
    u = tuple(a//h for a in s)
    p,R,v,K = data(s,L,u)
    assert len(s) == N and s[1] == 1 and gcd(*s) == 1
    assert H == F(Q*L,2) <= Q**(N-2)
    assert set(v) == {F(0),F(1)} and rank_two(u,v)
    assert K == L and max(v)-min(v) == 2*p/Q == 1
    packets.append((s,L,u))
    certificates.append(dict(N=N,H=H,q=L,s=s,u=u))
    counts['sharp_families'] += 1
    counts['odd_sharp_families' if N%2 else 'even_sharp_families'] += 1

mixed = ((0,1,34,67,101),3,(0,0,1,2,3))
doubled = ((0,2,68,134,202),3,(0,0,1,2,3))
assert gcd(*mixed[0]) == 1 and gcd(*doubled[0]) == 2
for s,q,u in [mixed,doubled]:
    p,R,v,K = data(s,q,u)
    assert min(R) < 0 < max(R) and K > gcd(q,s[-1])
    packets.append((s,q,u))
    counts['mixed_sign_global_fixtures'] += 1

for s,q,u in packets:
    for k in [0,3,19]:
        lifted_q = q+k*s[-1]
        lifted_u = tuple(b+k*a for a,b in zip(s,u))
        R,K,g,q0,up = global_and_fold(s,lifted_q,lifted_u)
        assert q0 == q and up == u

# Endpoint H duplicates zero: using N in the fiber count would be false.
s,q,u = packets[0]
p,R,v,K = data(s,q,u)
assert s == (0,1,3) and len(s)-1 == 2*K < len(s)
assert len({a % s[-1] for a in s}) == len(s)-1
assert Counter(R)[0] == 2 > gcd(q,s[-1])
counts['endpoint_duplicate_count_controls'] += 1

# Rank-one exact data satisfy the error bound but cannot be folded to q0>0.
s = (0,1,5,6)
H = s[-1]
q = 2*H
u = tuple(2*a for a in s)
p,R,v,K = data(s,q,u)
assert q % H == 0 and K == 0 <= F(2*H,12) and not rank_two(u,v)
counts['missing_rank_controls'] += 1

# A nonzero H-multiple residual restores rank but breaks the global budget.
q = H
u = (0,0,5,6)
p,R,v,K = data(s,q,u)
assert q % H == 0 and rank_two(u,v) and K == H > F(2*H,12)
counts['missing_budget_controls'] += 1

# Repeating labels would invalidate the N-1 distinct-input premise.
s,q,u = (0,1,1,1,10),1,(0,0,0,0,1)
p,R,v,K = data(s,q,u)
Q = len(s)*(len(s)-1)
assert rank_two(u,v) and K == F(2*s[-1],Q)
assert s[-1] < F(Q*(len(s)//2),2)
assert len(set(s)) < len(s) and len({a % s[-1] for a in s[:-1]}) < len(s)-1
counts['missing_distinctness_controls'] += 1

# One-runner error can hold even below the global minimum packet height.
s,q,u = (0,1,5,6),1,(0,0,1,1)
p,R,v,K = data(s,q,u)
Q = len(s)*(len(s)-1)
assert R == (0,1,-1,0) and rank_two(u,v)
assert K > F(2*s[-1],Q) and s[-1] < F(Q*(len(s)//2),2)
admissible = {r for r in range(len(s)) if all(abs(v[i]-v[r]) <= 2*p/Q for i in range(len(s)))}
assert admissible == {0,3}
for r in admissible:
    for i in range(len(s)):
        if i != r:
            assert norm((s[i]-s[r])*F(1,4)) >= F(1,4)
            counts['individual_packet_witness_comparisons'] += 1
counts['individual_global_scope_controls'] += 1

# Direct original witnesses, separately from any auxiliary packet.
for N in parameters:
    s = tuple(range(N))
    Q,H = N*(N-1),N-1
    radius = F(2*H,Q)
    assert radius == F(2,N) < 1 and H <= Q**(N-2)
    for d in [-2,-1,1,2]:
        assert abs(d) >= 1 > radius
        counts['nonzero_integer_radius_controls'] += 1
    for r in range(N):
        for i in range(N):
            if i != r:
                value = norm(F(s[i]-s[r],N))
                assert value >= F(1,N)
                counts['consecutive_signed_comparisons'] += 1
                counts['consecutive_closed_equalities'] += value == F(1,N)
    counts['consecutive_families'] += 1

assert len(packets) == 8 and counts['global_packet_instances'] == 24
assert counts['sharp_families'] == 6 and counts['consecutive_families'] == 6
assert counts['odd_sharp_families'] == counts['even_sharp_families'] == 3
assert counts['strict_denominator_descents'] == 16 and counts['identity_folds'] == 8
assert counts['closed_global_boundary_instances'] == 18
print(json.dumps(dict(counts=dict(sorted(counts.items())),
                     sharp_certificates=certificates,
                     mixed_sign_packets=[mixed,doubled]),sort_keys=True))
```

Reproduce from the repository root:

```bash
python3 -B - <<'UNIFORM_SUPPLY_INDEPENDENT_REVIEW' > /tmp/astra-uniform-finite-supply-review.log
from pathlib import Path
import re
p=Path('research/astra-uniform-finite-supply-review.md')
blocks=re.findall(r'^```python\n(.*?)^```[ \t]*$',p.read_text(),re.M|re.S)
assert len(blocks)==1
exec(compile(blocks[0],str(p),'exec'),{})
UNIFORM_SUPPLY_INDEPENDENT_REVIEW
```

Observed result: exit zero on the first execution of the saved block.
Program SHA-256:
`06cc57ae12235e93fb5e3c611e3f07b1289ead9dcd6c8cf7335c6045a658ed94`.
The single-line JSON output, including its trailing newline, is saved in
`/tmp/astra-uniform-finite-supply-review.log`, SHA-256
`7cc1bec542cb000ca61ab65b7e506a8e4a7a705b83efdea0df020fe7668ec16b`.

```text
sharp_families: 6 (3 odd, 3 even)
mixed_sign_global_fixtures: 2 (one nonprimitive)
global_packet_instances: 24
strict_denominator_descents: 16
identity_folds: 8
closed_global_boundary_instances: 18
coefficient_identity_slots: 189
relative_pair_checks: 1863
residue_function_evaluations: 5376
consecutive_families: 6
consecutive_signed_comparisons: 518
consecutive_closed_equalities: 106
nonzero_integer_radius_controls: 24
endpoint_duplicate_count_controls: 1
missing_rank_controls: 1
missing_budget_controls: 1
missing_distinctness_controls: 1
individual_global_scope_controls: 1
individual_packet_witness_comparisons: 6
```

The six independently constructed sharp heights are respectively
3, 12, 144, 225, 468, and 637. The positive mixed-sign examples have heights
101 and 202, denominator 3, and integer row (0,0,1,2,3). The scope-separation
example has height 6 and witnesses only the two specified endpoint runners
at the stated time 1/4. Its role is not a claim that other runners lack
loneliness witnesses.

No test failure, background job, or interrupted search occurred. Every owned
command completed; no owned process remains running at handoff. The commands
were current-policy/source reads, workflow validation, the exact rational
replay, hashes, and writes to this review and its temporary log. No Lean,
source, shared-state, Git, dependency/cache, or full-build operation was
performed. The proofs are manuscript arguments supported by these controls;
no finite control is promoted to a universal theorem. The reviewed result
remains an exact obstruction and normalization for the specified auxiliary
packet mechanism. Uniform F_N and unrestricted LRC remain unresolved.
