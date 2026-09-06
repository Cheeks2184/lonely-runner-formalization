# Independent review of the five-runner mixed structure manuscript

2026-09-05. Reviewer `/root/mss_published_bound_audit`, assigned Astra/xhigh;
requested routing is not an independent runtime attestation. Review checkpoint:
`e3e13a0d2a4f0ed76f5bbdd10305130ad079e505`. Project configuration, workflow,
policy and current active state were read; the structural validator passed.
Only this review is owned. Other workers' manuscripts, Lean, state, Git,
dependencies and cache are preserved. No Lean execution or tuple search is used.

**Accepted: the stated sufficient criteria and fixed obstruction are sound
with their displayed quantifiers, and the exact frozen program passed. No
mathematical correction is required.** The four moving speeds mean five total runners.
The conclusion uses one positive time, with lower margins at least one fifth
and the actual maximum's margin at least one quarter. It does not require an
ordinary strict seed. Global K5 and unrestricted LRC remain unresolved.

## Derivation and boundary review

For a nonexceptional lower triple, the exact public theorem
`LonelyRunner.fourRunnerMixed_iff` supplies a positive seed with margins
`d_a=d_b=1/4`, `d_c=1/3`; no primitive assumption is hidden in this input.
For each positive speed w and integer floor k_w, the seed belongs to the
interior of the weak band `[(k_w+1/5)/w,(k_w+4/5)/w]`. Their intersection
`[L,R]` is nonempty and closed. A left owner u and right owner v give

    t0-L >= (d_u-1/5)/u,   R-t0 >= (d_v-1/5)/v.

The buffers are exactly `1/(20a),1/(20b),2/(15c)`. For different owners,
the width is at least their sum. Since the a-buffer is at least the b-buffer,
the pair (a,c) is bounded below by (b,c), so checking (a,b) and (b,c)
suffices. This gives exactly

    H >= max(10ab/(a+b), 30bc/(3c+8b)).

For a common owner w the width is `3/(5w)>1/(2H)` because `w<H`.
Ties do not require unique owners: select any maximizer/minimizer and use
the corresponding same-owner or distinct-owner argument. A closed interval
missing every fastest-quarter time must lie in one open bad arc of length
`1/(2H)` and therefore has strictly smaller width. Equality in the sufficient
height bound is valid. No replacement of a closed threshold by a strict one,
or of global failure by failure at one seed, occurs.

The coarse implication is correct: `10ab/(a+b)<5b<22b/3`, and
`H(3c+8b)-30bc >= 8b(H-c)>0` if `3H>=22b`. Thus its displayed non-strict
hypothesis suffices, although the resulting comparisons are strict.

For a distinct pair u,v, independently subtracting the actual floor-band
endpoints gives `R-L=(5K-u-v)/(5uv)`, where
`K=u(k_v+1)-v k_u`. The stronger seed bounds imply
`K>=v*d_u+u*d_v`, and `gcd(u,v)` divides K even for negative floors.
The manuscript's ceiling expression for D and all three conditions
`2H*D_uv>=5uv` follow. Positivity follows from
`D_uv/(5uv)>=(d_u-1/5)/u+(d_v-1/5)/v>0`.
The weight sum is symmetric under exchanging the endpoint owners; the
different prescribed margins remain attached to their original speeds.
Common positive scaling multiplies D and H by the scale, preserves each
comparison, and divides a witness time by that scale.

## Exceptional lower triple and prior coverage

For `(a,2a,3a,H)`, normalization by `G=gcd(a,H)` produces coprime A,K.
If A>1, the explicit lower seed `1/(4A)` and shifts by j/A preserve all
three lower quarter margins. The effective outside grid has A points and
attains at least `(A-1)/(2A)>=1/4`. If A=1, denominator 4 or 5 is admissible
unless both divide K. The previously accepted N5 direct-to-mixed result
applies in precisely that normalized domain. When `20|K`, the manuscript's
explicit time `1/4+1/(4K)` has fastest norm exactly one quarter and lower
norms `1/4+1/(4K),1/2-1/(2K),1/4-3/(4K)`, all at least one fifth.
Rescaling by 1/G proves the entire raw exceptional family mixed. No assertion
that raw direct divisibility is invariant under scaling is needed.

The new criterion refines the existing component-width method by retaining
the third margin from C4. The older ordinary determinant criterion and its
adaptation to mixed must be distinguished. For `(4,5,11,30)`, the old mixed
determinant bound is `275/8>30`, but the old ordinary determinant bound is
`55/2<30`. This fixture distinguishes mixed sufficient tests; it does not
establish new ordinary coverage. The new two bounds are `200/9,1650/73`.
The alternative `(9,10,40,67)` has old mixed determinant bound `225/4<67`
and is correctly excluded as evidence of improvement over that refined test.
Neither comparison excludes all other preexisting ways to find a witness.

After the author's freeze, root supplied the additional fixed tuple
`(4,5,11,24)`. It passes the same new bounds, and `13/96` is mixed with
norms `(11/24,31/96,47/96,1/4)`. It is primitive, has gcd one after every
deletion, and covers every denominator 2 through 5. The older uniform-quarter
ordinary harmonic and determinant tests both require `H>=55/2`, while
ordinary basic insertion requires `H>=44` and ordinary first-lap coverage
requires `H<=16`; none passes at H=24. Thus the new sufficient parameter
criterion also covers an ordinary instance outside those particular tests.
This separately reviewed control strengthens the coverage assessment without
altering the frozen author's H=30 discussion. It is still the same interval
method, and does not exclude other existing constructions or imply a global
novelty claim. A favorable explicitly chosen ordinary seed can itself have a
larger component than the old worst-case parameter estimate guarantees.

The elementary first-lap condition is also correct. With
`T=max(1/(5a),1/(4H))`, every lower phase is at least one fifth. If
`4H<=15a`, the fastest phase is between one quarter and three quarters,
and every lower phase is at most three quarters. This supplies one positive
mixed time. The basic small-shift mixed bound `H>=5c` loses at most one
twentieth from each lower quarter margin; the public ordinary insertion
theorem alone does not state the required fastest-quarter conclusion.

## Finite remainder and the integer-multiple obstruction

The actual `primitive_sorted_noMixed_height_le` accepts positive-time
mixed failure. With m=3, the sorted tuple `(0,a,b,c,H)`, full gcd one,
and `lowerCountPositiveIntegerHypothesis_five`, it gives `H<=10^3=1000`.
The stationary circle distances are exactly the original four norms.
This is a finite reduction for primitive mixed failure, not finite evidence
that the remaining region is empty. H5 supplies ordinary three-moving-runner
witnesses; it is not itself a five-total-runner theorem.

The manuscript's other restrictions on a putative primitive K5 failure
follow from accepted direct, deletion-gcd and positive-width endpoint results.
The strict premise is needed for the ordinary-interior/endpoint restriction;
the sufficient mixed constructions themselves do not need it. Necessary
filters, including failure of at least one determinant comparison, are not
a characterization of the remaining tuples.

For `(3,4,5,11)` the seed `1/9` is strictly ordinary. All integer multiples,
including negative ones, reduce modulo 9. The fastest quarter condition
allows exactly residue classes 2,3,6,7; speed 4 fails at 2,7 and speed 3
fails at 3,6. This is a complete analytic exclusion for that orbit. The
positive mixed time `1/8` refutes any interpretation as global mixed failure.

## Compositional Lean plan, without implementation

The mathematical contracts are ready for a bounded implementation task.
It is sufficient to use the closed floor-band intersection, with finite
max/min owners; a general connected-component library is unnecessary.
For a general closed interval of width at least `2*beta/H`, apply
`exists_small_shift_circleNorm_ge` at its midpoint phase with threshold beta.
The resulting phase shift has magnitude at most beta, so division by positive
H stays inside the interval and supplies the fastest margin. A band-to-norm
lemma restores every lower margin there. In this application beta=1/4 and
the lower threshold is 1/5. Since the original seed is positive, its natural
positive-speed floors are nonnegative and L>0; the constructed time is positive.

This suggests a reusable finite band/owner lemma plus a floor-cell norm
bridge, followed by the two concrete arithmetic corollaries. Existing public
APIs can remain unchanged. The exceptional-family wrapper need not formalize
the entire modular manuscript: after normalization, use time 1/4 if `4∤K`;
otherwise use 1/5 for K residues 2,3 modulo 5 and 2/5 for residues 1,4.
If `20|K`, use the explicit time above or the small-shift lemma. For A>=2,
the existing coprime-grid lemma supplies the preserved-seed construction.
All phase transport and gcd divisions must remain explicit Lean obligations.

A suitable final wrapper takes natural `0<a<b<c<H` and the integer
comparisons `10ab<=H(a+b)` and `30bc<=H(3c+8b)`, and returns a positive
mixed time. It can hide the lower-exception split internally and needs no
primitive, strict-ordinary, or additional lower-count premise. The coarse
`22b<=3H` wrapper follows by arithmetic. The determinant refinement can be
added from its separately reviewed three-pair contract; its gcd/ceiling proof
should not be silently replaced by the weaker harmonic criterion.

## Frozen inputs and reproducible fixed controls

The exact frozen author is `research/astra-five-runner-mixed-structure.md`,
SHA-256 `8e82088a40db9104237ece65d86900e9cf50b6ffe8e5ec39164fbf8b808473ac`.
Its sole program is
`a3ce150750a3bed484dbfb49db945916dec76b4c107fc14402edfb7a74925ff1`,
and its raw stdout is
`e07bfc14aa3e408b54da5646a5fd59fd0fe73bbde147d27dd9bea0d88a6c0021`.
I read the full frozen manuscript and code before executing its guarded block.
The block binds sixteen original source/manuscript hashes, including the four
Lean interfaces read here. The additional grid source is guarded below.

The following sole Python block replays those six named author tuples,
then checks five explicitly named reviewer controls. The H=24 comparison
is root's fixed follow-up request after author freeze; it changes no author
claim or byte. Negative floors, a common endpoint owner, exact closed-width
equality, and nonprimitive direct-coverage loss are independently checked.
There is no tuple discovery or expanding domain, and the author program
checks only the nine residues needed by its single modular obstruction.
This block reads source and executes standard-library exact arithmetic in
memory. It writes nothing and starts no child process.

```python
from contextlib import redirect_stdout
from fractions import Fraction as Q
from hashlib import sha256
from itertools import combinations
from math import ceil, floor, gcd
from pathlib import Path
import io, json, re

author_path = 'research/astra-five-runner-mixed-structure.md'
author_hash = '8e82088a40db9104237ece65d86900e9cf50b6ffe8e5ec39164fbf8b808473ac'
author_program_hash = 'a3ce150750a3bed484dbfb49db945916dec76b4c107fc14402edfb7a74925ff1'
author_stdout_hash = 'e07bfc14aa3e408b54da5646a5fd59fd0fe73bbde147d27dd9bea0d88a6c0021'
raw = Path(author_path).read_bytes()
assert sha256(raw).hexdigest() == author_hash
fence = chr(96) * 3
blocks = re.findall(rf'^{fence}python\n(.*?)^{fence}[ \t]*$', raw.decode(), re.M | re.S)
assert len(blocks) == 1
assert sha256(blocks[0].encode()).hexdigest() == author_program_hash
captured = io.StringIO()
with redirect_stdout(captured):
    exec(compile(blocks[0], 'guarded-five-runner-author-controls', 'exec'), {})
assert sha256(captured.getvalue().encode()).hexdigest() == author_stdout_hash
assert captured.getvalue().endswith('PASS: 16 source guards; 6 named tuples; no tuple search\n')
assert sha256(Path('LonelyRunner/DivisorInsertion.lean').read_bytes()).hexdigest() == \
    '212fa6d879bab6d70f09a4a43b2027b96724b5e5ac4a22cdf4b368509973166f'

def norm(x):
    f = x - floor(x)
    return min(f, 1-f)

def is_mixed(W, t):
    return t > 0 and all(norm(w*t) >= Q(1,5) for w in W[:-1]) and norm(W[-1]*t) >= Q(1,4)

def interval(V, t):
    left = [(floor(w*t)+Q(1,5))/w for w in V]
    right = [(floor(w*t)+Q(4,5))/w for w in V]
    L, R = max(left), min(right)
    return L, R, tuple(w for w,l in zip(V,left) if l == L), tuple(w for w,r in zip(V,right) if r == R)

def old_D(u,v):
    g = gcd(u,v)
    return 5*g*ceil(Q(u+v,4*g))-u-v

# A fixed comparison requested by root after the author's freeze.
W = (4,5,11,24)
a,b,c,H = W
assert gcd(*W) == 1
assert all(gcd(*(W[:i]+W[i+1:])) == 1 for i in range(4))
assert all(any(w%d == 0 for w in W) for d in range(2,6))
new = max(Q(10*a*b,a+b), Q(30*b*c,3*c+8*b))
old_ordinary = max(Q(2*u*v,old_D(u,v)) for u,v in combinations(W[:-1],2))
assert new == Q(1650,73) <= H < old_ordinary == Q(55,2)
assert H > 4*a and H < 4*c and Q(8*b*c,b+c) == old_ordinary
assert [norm(w*Q(13,96)) for w in W] == [Q(11,24),Q(31,96),Q(47,96),Q(1,4)]
assert is_mixed(W,Q(13,96))

# Negative floors reflect the same full seeded interval.
W = (4,5,11,30)
L,R,lo,ro = interval(W[:-1],Q(2,15))
assert (L,R,lo,ro) == (Q(6,55),Q(4,25),(11,),(5,))
Ln,Rn,lon,ron = interval(W[:-1],-Q(2,15))
assert (Ln,Rn,lon,ron) == (-R,-L,ro,lo)
assert R-L == Q(14,275)
S = -Q(17,120)
T = S+1-floor(S)
assert 1 <= T < 2 and is_mixed(W,T)
assert all(norm(w*S) == norm(w*T) for w in W)

# Both endpoints belong to one speed; the pair criterion is not necessary.
W = (1,3,5,7)
L,R,lo,ro = interval(W[:-1],Q(1,2))
assert (L,R,lo,ro) == (Q(11,25),Q(14,25),(5,),(5,))
assert R-L == Q(3,5*5) > Q(1,2*W[-1])
assert is_mixed(W,Q(1,2))
assert max(Q(10*1*3,1+3),Q(30*3*5,3*5+8*3)) > W[-1]

# Closed width equality; the endpoints of the fastest bad arc are excluded.
W = (12,20,24,75)
L,R,lo,ro = interval(W[:-1],Q(3,16))
assert (L,R,lo,ro) == (Q(11,60),Q(19,100),(12,),(20,))
assert R-L == Q(1,2*W[-1])
assert (W[-1]*L,W[-1]*R) == (Q(55,4),Q(57,4))
assert is_mixed(W,L) and is_mixed(W,R)
assert norm(W[-1]*(L+R)/2) == 0
assert Q(10*12*20,12+20) == 75

# A raw scaled exceptional family can lose every direct denominator.
W = (4,8,12,20)
G = gcd(*W)
normalized = tuple(w//G for w in W)
assert G == 4 and normalized == (1,2,3,5)
assert all(any(w%d == 0 for w in W) for d in range(2,6))
assert all(w%4 for w in normalized)
assert is_mixed(normalized,Q(1,4)) and is_mixed(W,Q(1,16))
assert all(norm(w*Q(1,16)) == norm(v*Q(1,4)) for w,v in zip(W,normalized))

print(json.dumps({
    'author_sha256': author_hash,
    'author_program_sha256': author_program_hash,
    'author_stdout_sha256': author_stdout_hash,
    'author_replay': '16 guards and 6 named tuples passed',
    'additional_source_guards': 1,
    'independent_named_tuples': 5,
    'ordinary_comparison_24': {
        'new_bound': str(new),
        'old_ordinary_bound': str(old_ordinary),
        'mixed_time': '13/96'
    },
    'negative_floor_component': ['-4/25','-6/55'],
    'same_owner_component': ['11/25','14/25'],
    'closed_equality_width': '1/150',
    'scaled_exception_time': '1/16',
    'result': 'PASS'
}, sort_keys=True))

```

The principal current source hashes are recorded explicitly as well as
transitively guarded by the frozen author program:

| Source | SHA-256 |
| --- | --- |
| LonelyRunner/FourRunnerMixed.lean | ae47b419c5b4cebfa72a325bdb50cd32e03444c39850a74b885037d83e312a5c |
| LonelyRunner/FourRunnerOrdinary.lean | 2fb2f5c9c0742daa3278ee0ddeacd8643e1e22f8c885de95f5f38e10734b29f6 |
| LonelyRunner/FiniteHeightReduction.lean | cb41059260b943411e2ab5360b84b59cd13f2ddf352c3c50a0b3715b9b9987d6 |
| LonelyRunner/FastRunnerInsertion.lean | dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5 |
| LonelyRunner/DivisorInsertion.lean | 212fa6d879bab6d70f09a4a43b2027b96724b5e5ac4a22cdf4b368509973166f |
| research/astra-dense-pivot-induction.md | 6267ff6fb165ba01d5f982fd4931342c3e594d1ca1ca765d0aa41f0813598446 |
| research/astra-dense-pivot-review.md | 151b0cdb8c701610e2c2e2e0508e11a9a630ae93f7c57e1d5010227b7187887b |

The sole review program was extracted and executed with the following
standard-library command, terminating with exit 0. Its first execution passed;
there was no failed fixed-control run or subsequent program edit.

```bash
python3 -B - <<'PY'
from pathlib import Path
from hashlib import sha256
from contextlib import redirect_stdout
import io,re
p=Path('research/astra-five-runner-mixed-structure-review.md')
fence=chr(96)*3
blocks=re.findall(rf'^{fence}python\n(.*?)^{fence}[ \t]*$',p.read_text(),re.M|re.S)
assert len(blocks)==1
out=io.StringIO()
with redirect_stdout(out):
 exec(compile(blocks[0],'five-runner-independent-review','exec'),{})
print(out.getvalue(),end='')
print('review_program_sha256='+sha256(blocks[0].encode()).hexdigest())
print('review_stdout_sha256='+sha256(out.getvalue().encode()).hexdigest())
PY
```

Review program SHA-256:
`a27319964cdc5b582a2cf5b23fd381b561c063b86946bcd96a71144555079d91`.
Raw review stdout SHA-256, including its final newline:
`8695a214ecde113b192580f0cee9e4f81b46a3fa81b6714d0183b32c00ab66b2`.
The stdout contains this exact JSON line:

```text
{"additional_source_guards": 1, "author_program_sha256": "a3ce150750a3bed484dbfb49db945916dec76b4c107fc14402edfb7a74925ff1", "author_replay": "16 guards and 6 named tuples passed", "author_sha256": "8e82088a40db9104237ece65d86900e9cf50b6ffe8e5ec39164fbf8b808473ac", "author_stdout_sha256": "e07bfc14aa3e408b54da5646a5fd59fd0fe73bbde147d27dd9bea0d88a6c0021", "closed_equality_width": "1/150", "independent_named_tuples": 5, "negative_floor_component": ["-4/25", "-6/55"], "ordinary_comparison_24": {"mixed_time": "13/96", "new_bound": "1650/73", "old_ordinary_bound": "55/2"}, "result": "PASS", "same_owner_component": ["11/25", "14/25"], "scaled_exception_time": "1/16"}
```

An earlier temporary in-memory arithmetic check verified only the two named
comparison tuples, the positive seeded component, and
the modulus-nine example; it passed. Those same controls are subsumed by the
saved guarded reproducer. The workflow validator passed at startup and final
handoff. No Lean or dependency process was launched, and the only written file
is this review. The shared cache was absent at startup. A final bookkeeping
assertion that it was still absent failed after the directory appeared during
concurrent work; all preceding source/program/output guards passed. That
irrelevant persistent-state assumption is removed from the final readback;
the saved reproducer has no dependency on cache presence. This reviewer did
not read cache contents or alter it. All reviewer commands stopped
after the final source/hash readback; the final review hash is reported at
handoff rather than embedded self-referentially.

This accepts a manuscript proof and a settled implementation plan. It does
not claim a new kernel-checked N5 theorem, universal mixed supply, K5, or
unrestricted LRC. The fixed H=24 control proves only the explicitly compared
parameter-test improvement, and the finite H<=1000 reduction does not verify
the remaining finite domain.
