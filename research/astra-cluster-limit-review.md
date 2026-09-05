# Independent review of the conditional fixed-cluster limit theorem

2026-09-05. Requested role: GPT-6 Astra, xhigh, in-session independent
mathematical review. Runtime model/effort metadata was not independently
exposed to this worker. Assigned worker: `/root/cluster_limit_review`.
Base checkpoint: `7a5d0d69520a1d290c1dd6c85902488283394d1e`.

**Disposition: accepted as a conditional manuscript theorem.** The frozen
argument has no identified mathematical gap under its stated hypotheses.
This is not a Lean proof, a proof of its hypothesis H_N, a novelty claim,
or a resolution of unrestricted LRC. No corrections to the frozen theorem
are required. The separate count-two case and the precise minimum-count
interpretation below must be retained when consuming it.

The current project configuration, workflow document, policy and state were
read. The state authorizes research and records this worker's ownership of
this file only. `python3 scripts/validate_workflow.py` passed; this is a
structural check, not mathematical evidence. No relevant prior memory was
used. Author/root/other-worker replay results were not used as proof or as
the source of the independent checker below.

## Frozen inputs and actual source interfaces

All hashes below were read from the working-tree bytes. The review is bound
to these bytes, rather than to possibly changing shared workflow state.

| File | SHA-256 |
| --- | --- |
| `research/astra-cluster-limit-audit.md` | `24579e2572d5d9c37737e44b5d7ee1278bbe4f54a6138c171b57ad034da1e94b` |
| `LonelyRunner/Definitions.lean` | `5f0258a6ab99950fc7045b2200d6708fe7603d3caa4d62855ef2b19a330c95aa` |
| `LonelyRunner/Formulations.lean` | `0c3328e975bee236ff66862d3a5cadeb58fbc7c804fa953e53701ba466b9d788` |
| `LonelyRunner/BHKAdjacentRatios.lean` | `677c365618fc612a5ee7d3d9e9696273da2d9e775b77487d0b3e208cea9d6733` |
| `LonelyRunner/BHKBridgeCore.lean` | `43d0371d3fa213daa895d5431e9cfdd28d79d2de4ba89e02d9a9da93273678a3` |
| `LonelyRunner/BHKPositiveCollision.lean` | `7569f6798bc42be6ffd5ae04e0f8110f386f941aa58f02a2f168d597a17a514e` |
| `LonelyRunner/BHKCollisionToWitness.lean` | `42e7665af7981ef336ab4e1826ff3f096e6d6855b50440f76e2ede7a538f7f87` |
| `LonelyRunner/BHKRealReduction.lean` | `98d7c878eef7e4a3b7f7c504c882cf35191c1343816a59d731193ac8a207ed26` |
| `LonelyRunner/IntegerInduction.lean` | `7b315fe9ea7f8639eb45e376365f1c3795c52e2f93e608db578390c1083a5753` |

`PositiveIntegerConjecture` quantifies over distinct positive natural
moving speeds and unrestricted real time, with threshold `1/(n+1)`.
Enumerating a nonempty finite positive integer set D produces exactly this
contract at n=|D|. H_N assumes it only for 1<=n<=N-2. The ordinary integer
period permits the positive representative used below without a stronger
time-domain hypothesis.

The inspected BHK interfaces agree with the manuscript's comparison:
`bhk_adjacentRatioCombination` produces a nowhere-zero rational vector
with opposite selected coordinates from adjacent ratios and a positive
reference vector. `exists_bhk_relationCompatible_collision` additionally
requires two vectors that annihilate every integer relation of the original
real vector. `exists_bhk_collisionWitness_of_irrational` obtains these data
from a positive real vector having an irrational coordinate ratio.
`exists_stationaryWitness_of_rational_collision` explicitly consumes both
relation compatibility and an all-dimensional `PositiveRationalConjecture`.
It deduplicates magnitudes, gets strict slack, and transfers through orbit
closure. Finally, `conjecture_iff_positiveIntegerConjecture` is a global
equivalence. None of these declarations is a proof of H_N or a public
same-count implication for minimum real counterexamples.

The present collision vector is not generally relation compatible at a
fixed integer p. For example, with A=B={0,1}, r=0 and p=7, the labelled
original moving vector is (1,7,6), while c=2 gives (1,2,1). The relation
(7,-1,0) annihilates the original vector but gives 5 on the auxiliary one.
The manuscript uses explicit approximation in place of this absent
compatibility, correctly. This comparison uses local source interfaces,
not a claim about a literature novelty or an uninspected external theorem.

## Independent derivation and hypothesis audit

Write ||x|| for distance to the nearest integer. Fix r in A, assuming
|A|>=2. Choose a1 in A other than r, and set d=a1-r. Taking the endpoint
b0=max B for d>0 and b0=min B for d<0 ensures c=b0+d lies strictly outside
B. Thus neither of the lists `(a-r)_(a!=r)` and `(c-b)_b` contains zero.
Each list is internally injective, and both contain d, in different
comparison slots. There are N-1 labelled comparisons, so their union E
has 1<=|E|<=N-2. Passing to D={|e|:e in E} cannot increase cardinality
and creates a nonempty set of positive integers. In particular, no appeal
to LRC at N total runners has been hidden by keeping duplicate labels.

If d is positive, every c-b equals d+(max B-b)>0 and is at most
diam(A)+diam(B). If d is negative, every c-b is negative with absolute
value at most that same bound. The lower comparisons have absolute value
at most diam(A). This proves the optional auxiliary height bound even for
negative c and offsets. H_N itself has no speed-height restriction.

Apply H_N to D. Sign invariance gives ||e*w||>=1/(|D|+1)>=1/(N-1)
for all e in E. Integer periodicity preserves these inequalities at
t0=w-floor(w)+1 in [1,2). With y0=c*t0, both groups of comparisons
simultaneously have margin at least

`1/(N-1) = 1/N + epsilon`, where `epsilon=1/[N(N-1)]>0`.

This is one lower-count application to a constructed speed set. It does
not require separate sets of witness times to intersect. No original
N-runner witness, relation-compatibility assertion, or limit exchange is
used in its supply.

For |A|=1, the anchor 0 in A forces A={0} and r=0. Set t0=1, y0=1/2.
Every opposite phase has norm 1/2, which is at least 1/(N-1) for N>=3.
This avoids the invalid application of H_N to |B|=N-1 moving speeds.

For either supply, put P=p-r and choose a nearest integer q to P*t0-y0.
Then t=(q+y0)/P obeys |t-t0|<=1/(2P), including either choice at a tie.
The upper comparison is exactly

`(P-b)*t = q + (y0-b*t0) - b*(t-t0)`.

After removing the integer q, the perturbation has coefficient b, not
P-b. The quotient norm is 1-Lipschitz because the circle metric is a
quotient of the Euclidean metric. Consequently each lower norm loses at
most |a-r|/(2P), and each upper norm loses at most |b|/(2P). Real lifts
of y0 of any magnitude, negative b, and negative d make no difference.

The anchor 0 in each set implies |b|<=diam(B), |a-r|<=diam(A), and
0<=R<=K. Since N>=3 and offsets are distinct integers within their sets,
K>=1. With C=N(N-1)/2>=3, the bound p>=R+C*K gives

`P>=p-R>=C*K>=3`, and `K/(2P)<=1/[N(N-1)]`.

Thus t>=1-1/(2P)>=5/6>0 and every target norm is at least 1/N.
Equality is allowed; a strict target has not been substituted. The
disjointness assertion is also justified:

`p-max(A)-max(B) >= C*K-R >= (C-1)*K > 0`.

So the two cluster sets really give N different original speeds. For a
chosen upper runner p-b, reflection x->p-x identifies the configuration
with the swapped clusters, with unchanged N,K,R. It sends each original
relative speed to its negative, preserving its norm. This proves the
all-chosen-runner quantifier; a single common witnessing time is not claimed.

At N=2 both sets are {0}, and p>0 is separately necessary for two distinct
runners. The time 1/(2p) gives distance exactly 1/2. Extending the displayed
N>=3 bound to N=2 would allow p=0, so that extension must not be made.

## Minimum-counterexample scope

Use a least failing **integer total-runner count**, either for all chosen
runners of integer configurations or for the positive stationary integer
formulation. In the first interpretation, each smaller positive D with its
stationary zero is an integer configuration, so minimality supplies H_N.
In the second interpretation, minimality directly supplies H_N; translation
to the chosen runner and absolute-value deduplication explain the usual
connection with all-chosen integer configurations. No minimum real count
needs to be preserved by BHK.

For a normalized sorted integer configuration 0=x1<...<xN=p, a nontrivial
split 1<=j<=N-1 has A={x1,...,xj}, B={p-xN,...,p-x(j+1)} and
K=R=max(xj,p-x(j+1)). Hence under H_N it cannot be a counterexample if
p>=(C+1)*K. A least-count integer counterexample must have
p<(C+1)*K at every split. The word "integer" and all the lower-count
premises are essential here.

This is a conditional exclusion, not an exhaustive induction step. There
is no reason every tuple must admit such a split: even {0,2,4,6} fails
the sufficient inequality at all three splits. Growing p while keeping
cluster offsets fixed is different from normalizing arbitrary tuples whose
internal widths also grow. No height finiteness or general cover follows.

## Independent fixed rational controls

These controls were independently authored from the derivation. They do
not import or execute the author's checker. The domain is exactly four
literal cluster pairs with a literal auxiliary time for every chosen
runner in either orientation, at the three separations `bound`, `bound+2`,
and `bound+1000001`. Each non-singleton literal time satisfies even the
stronger `1/(|D|+1)` hypothesis for its actual D. Both nearest integers are
checked whenever a tie occurs. There is no witness search, tuple discovery,
random sampling, exhaustive family enumeration, floating-point arithmetic,
Lean invocation, or dependency-cache access.

The pairs cover unequal sizes, signed offsets, negative c, R=0, a strict
absolute-value cardinality drop, singleton supply, the displayed bound
itself, and large p. The N=3 pair A={-5,0}, B={0} attains the closed
target 1/3 at p=15 for an upper chosen runner: the two tie choices give
t=29/30 and t=31/30. Thus equality is checked at the actual uniform bound,
not merely inferred from strict examples. Small controls also check
integer-period normalization, phase-lift independence, invalid c producing
a zero, the two supplied free-phase obstructions, the failed BHK relation,
three uncertified splits, and N=2 exact endpoints.

```python
from fractions import Fraction as Q
from collections import Counter
from hashlib import sha256
from pathlib import Path
import json

assert sha256(Path('research/astra-cluster-limit-audit.md').read_bytes()).hexdigest() == \
    '24579e2572d5d9c37737e44b5d7ee1278bbe4f54a6138c171b57ad034da1e94b'

def circle(x):
    f = Q(x) % 1
    return min(f, 1-f)

def diameter(S):
    return max(S)-min(S)

def nearest_choices(x):
    x = Q(x)
    lo = x.numerator // x.denominator
    side = 2*(x-lo)
    return (lo,) if side < 1 else ((lo+1,) if side > 1 else (lo, lo+1))

counts = Counter()
fixture_digest_rows = []

# A, B, literal t0 by each r in A, literal t0 by each r in B.
fixtures = [
    ({0, 2}, {-3, 0}, {0: Q(4,3), 2: Q(4,3)},
     {-3: Q(9,8), 0: Q(9,8)}),
    ({-2, 0, 2}, {0, 3}, {-2: Q(9,8), 0: Q(4,3), 2: Q(19,16)},
     {0: Q(5,4), 3: Q(5,4)}),
    ({0}, {-4, 0, 4}, {0: Q(1)},
     {-4: Q(13,12), 0: Q(9,8), 4: Q(13,12)}),
    ({-5, 0}, {0}, {-5: Q(11,10), 0: Q(11,10)}, {0: Q(1)}),
]

def auxiliary(A, B, r, t0):
    N = len(A)+len(B)
    assert r in A and 0 in A and 0 in B and N >= 3 and 1 <= t0 < 2
    if len(A) == 1:
        assert A == {0} and r == 0 and t0 == 1 and len(B) == N-1
        counts['singleton_supplies'] += 1
        return Q(1,2)
    a1 = min(A-{r})
    d = a1-r
    b0 = max(B) if d > 0 else min(B)
    c = b0+d
    E1, E2 = {a-r for a in A-{r}}, {c-b for b in B}
    E, D = E1 | E2, {abs(e) for e in E1 | E2}
    assert d != 0 and c not in B and 0 not in E and d in E1 & E2
    assert len(E1) == len(A)-1 and len(E2) == len(B)
    assert 1 <= len(D) <= len(E) <= N-2
    assert max(D) <= diameter(A)+diameter(B)
    assert all(circle(v*t0) >= Q(1,len(D)+1) for v in D)
    for k in [-7, -1, 0, 8]:
        w = t0+k
        normalized = w-(w.numerator//w.denominator)+1
        assert normalized == t0
        assert all(circle(e*w) == circle(e*normalized) for e in E)
        counts['normalizations'] += 1
    counts['collision_supplies'] += 1
    counts['negative_c_supplies'] += c < 0
    counts['absolute_cardinality_drops'] += len(D) < len(E)
    return c*t0

endpoint_times = set()
for A, B, timesA, timesB in fixtures:
    N = len(A)+len(B)
    K, R = max(diameter(A),diameter(B)), max(max(A),max(B))
    C = N*(N-1)//2
    bound = R+C*K
    delta, eps = Q(1,N), Q(1,N*(N-1))
    assert set(timesA) == A and set(timesB) == B
    assert 0 <= R <= K and K >= 1 and C >= 3
    fixture_digest_rows.append([sorted(A), sorted(B), bound])
    for p in [bound, bound+2, bound+1000001]:
        T = A | {p-b for b in B}
        assert len(T) == N
        assert p-max(A)-max(B) >= C*K-R >= (C-1)*K > 0
        certified = set()
        for U, V, times, reflected in [(A,B,timesA,False),(B,A,timesB,True)]:
            assert ({p-s for s in T} if reflected else T) == U | {p-v for v in V}
            for r in sorted(U):
                t0 = times[r]
                y0 = auxiliary(U,V,r,t0)
                P = p-r
                assert P >= C*K >= 3
                assert all(circle((a-r)*t0) >= delta+eps for a in U-{r})
                assert all(circle(y0-b*t0) >= delta+eps for b in V)
                qs = nearest_choices(P*t0-y0)
                lifted_times = {(q+y0)/P for q in qs}
                for shift in [-1000000, 1000000]:
                    y1 = y0+shift
                    assert {(q+y1)/P for q in nearest_choices(P*t0-y1)} == lifted_times
                    counts['phase_lift_controls'] += 1
                original_runner = p-r if reflected else r
                counts['chosen_runner_inputs'] += 1
                counts['tie_inputs'] += len(qs) == 2
                for q in qs:
                    t = (q+y0)/P
                    error = t-t0
                    assert abs(error) <= Q(1,2*P)
                    assert t >= Q(5,6) > 0 and Q(K,2*P) <= eps
                    for a in U-{r}:
                        before, after = circle((a-r)*t0), circle((a-r)*t)
                        assert abs(a-r) <= K
                        assert after >= before-abs(a-r)*abs(error) >= delta
                    for b in V:
                        assert abs(b) <= K
                        assert (P-b)*t == q+y0-b*t0-b*error
                        before, after = circle(y0-b*t0), circle((P-b)*t)
                        assert after >= before-abs(b)*abs(error) >= delta
                    for s in T-{original_runner}:
                        actual = circle((s-original_runner)*t)
                        assert actual >= delta
                        counts['signed_comparisons'] += 1
                        counts['closed_equalities'] += actual == delta
                    if A == {-5,0} and B == {0} and p == bound and reflected:
                        endpoint_times.add(t)
                    counts['rounding_lifts'] += 1
                certified.add(original_runner)
        assert certified == T
        counts['configuration_separations'] += 1
    counts['fixed_cluster_pairs'] += 1

assert endpoint_times == {Q(29,30),Q(31,30)}
assert counts['negative_c_supplies'] > 0 and counts['absolute_cardinality_drops'] > 0
assert counts['tie_inputs'] > 0 and counts['closed_equalities'] > 0

# Non-extreme c can coincide with an opposite label and create speed zero.
B, d, b0 = {-2,0,2}, 2, 0
c = b0+d
assert c in B and 0 in {c-b for b in B}
assert circle(0*Q(4,3)) == 0 < Q(1,4)
counts['invalid_zero_collision_controls'] += 1

def best_free_distance(B,t):
    points = sorted({Q(b)*t % 1 for b in B})
    gaps = [v-u for u,v in zip(points,points[1:])]
    gaps.append(points[0]+1-points[-1])
    return max(gaps)/2

assert best_free_distance({0,1},Q(1,2)) == Q(1,4)
assert circle(4*Q(1,8)) == Q(1,2)
assert best_free_distance(set(range(8)),Q(1,8)) == Q(1,16) < Q(1,10)
counts['free_phase_obstruction_controls'] += 2

relation, original, auxiliary_vector = (7,-1,0), (1,7,6), (1,2,1)
assert sum(a*v for a,v in zip(relation,original)) == 0
assert sum(a*v for a,v in zip(relation,auxiliary_vector)) == 5
counts['BHK_incompatibility_controls'] += 1

xs = [0,2,4,6]
N, p = len(xs), xs[-1]
for j in [1,2,3]:
    A, B = set(xs[:j]), {p-x for x in xs[j:]}
    K, R = max(diameter(A),diameter(B)), max(max(A),max(B))
    assert K == R == max(xs[j-1],p-xs[j])
    assert p < (1+N*(N-1)//2)*K
    counts['uncertified_split_controls'] += 1

for p in [1,5,100003]:
    T, t = {0,p}, Q(1,2*p)
    for r in T:
        assert all(circle((s-r)*t) == Q(1,2) for s in T-{r})
        counts['N2_endpoint_controls'] += 1
assert len({0,0}) == 1  # N=2 cannot admit p=0 as two distinct runners.
assert counts['fixed_cluster_pairs'] == 4
assert counts['configuration_separations'] == 12
assert counts['chosen_runner_inputs'] == 48
assert counts['N2_endpoint_controls'] == 6
print(json.dumps({'counts': dict(sorted(counts.items())),
                  'fixtures': fixture_digest_rows,
                  'endpoint_times': sorted(map(str,endpoint_times))},sort_keys=True))
```

Reproduce from the repository root:

```bash
python3 -B - <<'CLUSTER_LIMIT_INDEPENDENT_REVIEW'
from pathlib import Path
import re
p=Path('research/astra-cluster-limit-review.md')
blocks=re.findall(r'^```python\n(.*?)^```[ \t]*$',p.read_text(),re.M|re.S)
assert len(blocks)==1
exec(compile(blocks[0],str(p),'exec'),{})
CLUSTER_LIMIT_INDEPENDENT_REVIEW
```

Observed result: exit zero on the first execution of this saved block.
The exact extracted Python block has SHA-256
`c8af94b0d7cb7b03c0238dc9047926bc01d4f63290e4bc998f3c41bbe4ec57bc`.

```text
fixed_cluster_pairs: 4
configuration_separations: 12
chosen_runner_inputs: 48
rounding_lifts: 59
signed_comparisons: 181
tie_inputs: 11
closed_equalities: 2
collision_supplies: 42
singleton_supplies: 6
negative_c_supplies: 24
absolute_cardinality_drops: 6
normalizations: 168
phase_lift_controls: 96
invalid_zero_collision_controls: 1
free_phase_obstruction_controls: 2
BHK_incompatibility_controls: 1
uncertified_split_controls: 3
N2_endpoint_controls: 6
endpoint_times: 29/30, 31/30
fixture_bounds_in_displayed_order: 20, 43, 52, 15
```

All review commands completed normally; no background process was launched,
no search was interrupted, and no owned command remains running at handoff.
The commands were source/configuration reads, hashes, the workflow validator,
the exact reproduction above, and edits to this owned review file. No Lean
build, trust audit, dependency/cache operation, Git operation, or shared-state
write was performed. The main theorem acceptance rests on the independent
derivation; the finite controls check implementation of its identities and
edge cases only. Formalization of this conditional theorem is a separate
possible task, and H_N remains explicit. Unrestricted LRC is unresolved.
