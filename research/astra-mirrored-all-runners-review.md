# Independent review of the mirrored-block all-runner extension

Requested reviewer: Astra xhigh, 2026-09-05. Source checkpoint:
`8db7eb32fb0aec5f1a62d18f93a72c5096d76743`.
Current project configuration, workflow, policy, and state were read; workflow
structural validation passed. Research is authorized and the unrestricted
canonical LRC goal remains unresolved.

Frozen artifacts read in full and hash-checked:

- `research/astra-mirrored-block-all-runners.md`:
  `1253cae99e31ff66f66eea170307296f8b3a4c181661ea0e91e5d2d5c9f27e98`.
- Dependency `research/astra-mirrored-block-witness.md`:
  `70b5545b8b7af311324967c7272a07f8d714eeabac2b21c381ae168326847e21`.
- Its independent review `research/astra-mirrored-block-review.md`:
  `05d75866a7c71bf10e34252545d726e4dd3f4910de6ce5795e4ce85b39a299d2`.

**Disposition: accepted as a manuscript theorem, with no correction required.**
For every integer m>=1 and p>=2m+1, every chosen runner r in
`T={0,...,m} union {p-m,...,p}` has a positive real time t at which all other
original runners have relative circle distance at least `1/(2m+2)`.
The time is allowed to depend on r. This is an unconditional structured-family
result; this review neither certifies a Lean implementation nor resolves
unrestricted LRC.

## Independent derivation and exact denominator

Since p-m>=m+1, the two original blocks are disjoint. Each has m+1 distinct
integer labels, so T has exactly N=2m+2 runners. Put delta=1/N. Signed
differences below are in the integers or reals, never truncated natural
subtraction.

For a lower chosen runner 0<=r<=m, let P=p-r. Then

```text
P >= p-m >= m+1,
1 <= |s-r| <= m                   (0<=s<=m, s!=r),
1 <= P-m <= s-r <= P              (p-m<=s<=p).
```

The second line is integral, so a nonzero absolute difference is at least
one. In the third line s>r and P-m=p-r-m is positive. Thus every nonzero
absolute relative speed is in
`{1,...,m} union {P-m,...,P}`. In fact the lower differences occupy
`{1,...,max(r,m-r)}`, possibly with repetitions from opposite sides of r,
but the weaker containing set is sufficient.

If P<=2m+1=N-1, the displayed positive differences are all at most N-1.
At t=1/N each absolute phase is between delta and 1-delta, including its
endpoints; its circular norm is therefore at least delta. Norm invariance
under negation gives the same conclusion for the original signed phases.
No cardinality of the set of absolute differences enters this inference.

If P>=2m+1, the accepted designated-zero theorem at the parameters m,P
gives a positive time good for the entire containing set at delta=1/(2m+2).
Its low and high blocks are disjoint under this hypothesis. Taking a subset
preserves that same bound. The original chosen-runner problem still has
N-1 other labelled runners even if absolute magnitudes repeat; deduplicating
magnitudes neither changes N nor justifies a stronger threshold.

These two cases exhaust P and legitimately overlap at P=2m+1. There the
containing family is `{1,...,N-1}` and the accepted formula also gives 1/N.
The manuscript's deterministic rule chooses the small branch at equality.
At the minimal original p=2m+1 the whole configuration is `{0,...,N-1}`,
and every chosen runner is handled by the small branch. This includes m=1.

For an upper chosen runner p-m<=r<=p, the map f(s)=p-s sends the lower
block bijectively onto the upper block and vice versa. Every s in T lies
between 0 and p, so these natural subtractions coincide with integer ones.
The map is an involution, f(r)=p-r lies in the lower block, and s!=r implies
f(s)!=f(r). The exact signed identity is

```text
f(s)-f(r) = r-s = -(s-r).
```

The lower-runner witness for f(r) therefore checks every original s!=r by
norm invariance. Here reflection is a symmetry of the same full set T, and
the distinguished label and every comparison label are mapped together.
This avoids the earlier full-complement error of transferring a witness
for one distinguished runner to a different one without this argument.

For implementation, casts of P=p-r and P-m require r<=p and m<=P; both
were proved above. Lower-block signed differences must use integer/real
subtraction or an explicit absolute-distance operation. A labelled
formulation also needs an actual enumeration of T with cardinality N and
injectivity. These are finite-set translation obligations, not additional
mathematical hypotheses. There is no supplied induction witness, unit/gcd
assumption, or strict-distance conclusion hidden in the proof.

## Independent fixed exact controls

The following standard-library program implements the explicit per-runner
formula independently and checks every original ordered comparison on a
fixed list. It includes both formula branches, both original blocks, small
P, equality P=2m+1, negative phases, repeated absolute magnitudes, m=1,
and four large-height fixtures. It performs no tuple discovery and does not
import an author or root test program. Finite checks support the proof above;
they are not the proof of its universal parameters.

```python
from fractions import Fraction as F
from collections import Counter
from pathlib import Path
from hashlib import sha256
import json

hashes = {
    'research/astra-mirrored-block-all-runners.md':
        '1253cae99e31ff66f66eea170307296f8b3a4c181661ea0e91e5d2d5c9f27e98',
    'research/astra-mirrored-block-witness.md':
        '70b5545b8b7af311324967c7272a07f8d714eeabac2b21c381ae168326847e21',
    'research/astra-mirrored-block-review.md':
        '05d75866a7c71bf10e34252545d726e4dd3f4910de6ce5795e4ce85b39a299d2',
}
for path, expected in hashes.items():
    assert sha256(Path(path).read_bytes()).hexdigest() == expected

def norm(x):
    return min(x % 1, (-x) % 1)

def witness(m, p, r):
    N = 2*m+2
    u = r if r <= m else p-r
    assert 0 <= u <= m
    P = p-u
    if P <= 2*m+1:
        return F(1, N), P, 'small'
    k, rem = divmod(P, N)
    if rem >= m+1:
        return F(1, N), P, 'large_first'
    return F(N*k+1, N*(P-m)), P, 'large_adjusted'

fixtures = [(1,3),(1,4),(1,5),(1,6),
            (2,5),(2,6),(2,7),(2,8),(2,9),
            (3,7),(3,8),(3,10),(3,11),(3,12),(3,13),(3,14),
            (17,35),(17,36),(17,52),(17,53),(17,54),
            (17,36*10**20),(17,36*10**20+17),
            (17,36*10**20+18),(17,36*10**20+35)]
c = Counter()
for m, p in fixtures:
    assert m >= 1 and p >= 2*m+1
    N, delta = 2*m+2, F(1, 2*m+2)
    T = tuple(range(m+1)) + tuple(range(p-m, p+1))
    assert len(T) == len(set(T)) == N
    assert {p-s for s in T} == set(T)
    for r in T:
        t, P, branch = witness(m, p, r)
        assert t > 0 and P >= m+1
        assert witness(m, p, p-r)[0] == t
        u = min(r, p-r)
        mags = [abs(s-u) for s in T if s != u]
        assert all(1 <= a <= m or P-m <= a <= P for a in mags)
        if branch == 'small':
            assert all(1 <= a <= N-1 for a in mags)
        if P == 2*m+1:
            assert branch == 'small' and t == delta
        for s in T:
            if s == r:
                continue
            assert (p-s)-(p-r) == -(s-r)
            assert norm((s-r)*t) == norm(((p-s)-(p-r))*t) >= delta
            c['signed_comparisons'] += 1
            c['negative_phases'] += s < r
            c['closed_equalities'] += norm((s-r)*t) == delta
        c['chosen_runners'] += 1
        c[branch] += 1
        c['upper_chosen'] += r >= p-m
        c['P_at_boundary'] += P == 2*m+1
        c['duplicate_magnitudes'] += len(set(mags)) < N-1
    c['fixtures'] += 1

# Repeated magnitudes do not promote the original six-runner threshold.
T = tuple(range(6))
assert {abs(s-2) for s in T if s != 2} == {1,2,3}
assert min(norm((s-2)*F(1,6)) for s in T if s != 2) == F(1,6) < F(1,4)
# A zero-runner witness is not automatically a witness for another runner.
t0 = witness(1,4,0)[0]
assert t0 == F(5,12)
assert all(norm(s*t0) >= F(1,4) for s in (1,3,4))
assert norm((3-1)*t0) == F(1,6) < F(1,4)
assert witness(1,4,1)[0] == F(1,4)
assert c['fixtures'] == len(fixtures) == 25
assert c['chosen_runners'] == sum(2*m+2 for m,p in fixtures)
assert c['signed_comparisons'] == sum((2*m+2)*(2*m+1) for m,p in fixtures)
assert c['negative_phases']*2 == c['signed_comparisons']
assert c['upper_chosen']*2 == c['chosen_runners']
assert all(c[k] > 0 for k in ['small','large_first','large_adjusted',
                            'P_at_boundary','duplicate_magnitudes','closed_equalities'])
print(json.dumps(dict(c), sort_keys=True))
```

Reproduce from the repository root:

```bash
python3 -B - <<'ALL_RUNNERS_REVIEW'
from pathlib import Path
import re
p=Path('research/astra-mirrored-all-runners-review.md')
blocks=re.findall(r'^```python\n(.*?)^```[ \t]*$',p.read_text(),re.M|re.S)
assert len(blocks)==1
exec(compile(blocks[0],str(p),'exec'),{})
ALL_RUNNERS_REVIEW
```

Observed result: exit zero. There were 25 fixed configurations, 426 chosen
runners (213 upper), and 11,930 signed comparisons, including 5,965 negative
phases. The branches contributed 106 small cases, 90 large first cases, and
230 large adjusted cases. There were 22 instances of P=2m+1, 340 chosen
runners with repeated absolute magnitudes, and 622 attained closed-distance
equalities. Both explicit denominator/time-reuse controls passed. These counts
are the output of this review's independent replay, not author-reported data.

Only this review file was written. All review commands completed, with no
background process started. No author, Lean, cache, state, or Git changes,
builds, dependency restoration, or discovery searches were performed. The
next separate step is faithful formalization and independent review of the
resulting source and exact labelled contract. This accepted family extension
leaves unrestricted LRC unresolved.
