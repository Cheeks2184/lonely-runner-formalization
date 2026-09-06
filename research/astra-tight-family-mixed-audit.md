# Published tight-family screen for fastest mixed witnesses

Assigned source: `7e1b4073cfd0095a3e514df975313562feb82688`.
This Astra/xhigh research task owns only this manuscript. Project instructions,
configuration, policy, and active state were read; `python3 -B
scripts/validate_workflow.py` passed. The full LRC goal remains active and
unresolved. This is a manuscript derivation, not a new Lean theorem.

**Screen complete:** none of the three classes screened below
provides a new mixed obstruction. The acceleration class is already covered by
the accepted modular argument. Kravitz's near-tight class has a simple mixed
witness even in an infinite subfamily for which every direct denominator fails.
That subfamily already satisfies the elementary fast-insertion bound, so this
does not enlarge the remaining comparable-height coverage. The derivations
were saved before controls; all 21 fixed fixtures now pass.

## Primary sources and count convention

Exactly two research papers were retrieved on 2026-09-05:

1. Luis Goddyn and Erick B. Wong, *Tight Instances of the Lonely Runner*,
   **Integers 6 (2006), A38**, published 12 December 2006, pp. 1–14.
   The title does not end in “conjecture”. The journal's
   [primary repository record](https://zenodo.org/records/8275490) and
   [published PDF](https://zenodo.org/records/8275490/files/g38.pdf?download=1)
   give the bibliography. The PDF was read in memory, 272456 bytes, SHA-256
   `dc9b2a9a8fd9849ee5f05664b83899df83b8ab23a622300625e50465cf463197`.
   Relevant locations: p. 2, Theorem 2.3 (pp. 4–6), Theorem 3.1 and its proof
   (pp. 7–9), and Corollary 3.3 (pp. 9–10). Here their `n` equals our `N`.
2. Noah Kravitz, *Barely lonely runners and very lonely runners: a refined
   approach to the Lonely Runner Problem*, **Combinatorial Theory 1 (2021),
   #17**, published 15 December 2021, DOI
   [10.5070/C61055383](https://doi.org/10.5070/C61055383).
   The [published paper](https://escholarship.org/content/qt3wx931fh/qt3wx931fh.pdf)
   has the relevant family in Theorem 3.1, pp. 5–6. It is Theorem 5.1 in
   [arXiv:1912.06034v1](https://arxiv.org/html/1912.06034v1#S5), dated
   12 December 2019. Here `n` counts moving speeds, so our `N=n+1`.

Write `||x||` for distance to the nearest integer. For `N>=3`, `W` has `N-1`
distinct positive integer speeds and `H=max W`. Mixed `M` means one `T>0`
with every `||wT||>=1/N` and `||HT||>=1/(N-1)`. Direct `D` means some integer
`2<=d<=N` divides no speed. Sorting does not change either condition. For any
positive integer scale `a`, a witness for `W` at `T` gives a witness for `aW`
at `T/a`; fastest identity is preserved. All base classes below have gcd one.

The accepted local modular review is
`research/astra-direct-to-mixed-units-review.md`, SHA-256
`c424fc7970ade6a65e5388e0b3f60a34e091c01f2603f154646301bb5b9c96f5`,
read and hash-checked here. It proves `D=>M` outside `N=3,4,6`. No result from
the separate four-runner implementation is used.

## Class A: the GCD-conditioned acceleration family

Take `N>=3` and positive integer multipliers `m_r`, `1<=r<N`, satisfying

`gcd(r,b)>1` for every integer `N-r <= b < m_r*(N-r)`.

The published family is `W={m_r*r:1<=r<N}`. Goddyn–Wong Theorem 3.1 proves
its ordinary maximum is `1/N`; its converse for several accelerations is not
claimed. Theorem 2.3 gives the single-acceleration characterization, including
a separate `N=3,r=1,m=4` exception. We use only the displayed family definition
and prove its mixed result directly, without importing a tight-set classification.

For a proper acceleration `m=m_r>=2`, put `s=N-r`. First `s>=2`, since an
interval starting at one violates the GCD condition. Also `s<r`: otherwise
the interval has at least `r` consecutive integers and contains a number
congruent to one modulo `r`. Finally `m*s<r`: if `m*s>=r`, the same interval
contains `r-1`, again coprime to `r`. Thus

`0 < m*(N-r) < r < N`, and `m*r = m*N-m*(N-r)` is nonzero modulo `N`.

Unaccelerated entries are also nonzero modulo `N`, so `d=N` witnesses `D`.
There is no sorting or collision loophole: a properly accelerated entry with
multiplier `m` lies strictly between `(m-1)*N` and `m*N`, because
`r>m*N/(m+1)`. Different multipliers therefore give disjoint value intervals;
equal multipliers preserve distinctness of `r`. Speed one is unaccelerated,
so the tuple is primitive. The actual fastest speed is `H=max_r(m_r*r)`,
not the old label `N-1`.

If any acceleration is proper, `m*s<r` implies `N=r+s>3s>=6`. Consequently
`N` avoids all three exceptional counts, and `M` follows. Explicitly, if
`gcd(H,N)>1`, use `T=1/N`. Otherwise choose a unit `u` modulo `N` with
`2<=u<=N-2`, let `k` be the positive representative of `H^(-1)*u mod N`,
and use `T=k/N`. All original residues stay nonzero, while the fastest has
cyclic residue distance at least two. Thus its norm is at least
`2/N>=1/(N-1)`. This uses the reviewed existence of such a unit.

If every multiplier is one, this is the consecutive family, discussed below.
The extra single-acceleration exception `(N,r,m)=(3,1,4)` gives sorted speeds
`(2,4)`, merely a scale of `(1,2)`, so introduces no new obstruction.

## Class B: the three sporadic examples printed by Goddyn–Wong

The paper's p. 2 table lists the following examples. We do not promote its
computer table into an exhaustive classification or use tightness as a premise.
Each displayed positive time itself proves mixed existence:

| `N` | Normalized `W`; actual `H` | `T` | `||HT||` |
| --- | --- | --- | --- |
| 5 | `(1,3,4,7)`; 7 | `1/5` | `2/5` |
| 6 | `(1,3,4,5,9)`; 9 | `1/6` | `1/2` |
| 8 | `(1,4,5,6,7,11,13)`; 13 | `1/8` | `3/8` |

Every residue is nonzero at the indicated denominator, giving the ordinary
margin. Even the exceptional count six escapes because its actual fastest
speed is a nonunit modulo six. All positive integer scales inherit these times
after division by the scale. No further list enumeration is needed.

## Class C: Kravitz's entire explicit near-tight spectrum family

For integers `n>=2`, `s>=1`, the family is

`W=(1,2,...,n-1,n*s)`, `N=n+1`, `H=n*s`.

Kravitz's theorem proves the ordinary maximum `s/(n*s+1)`. Its proof checks
possible maximizing denominators from sums of two speeds; the statement does
not assert anything about the fastest coordinate at all ordinary-good times.
The spectrum conjecture elsewhere in the paper is not needed here.

For every `s>=2`, take the explicit positive time

`T = 1/n - 1/(n*H) = (n*s-1)/(n*n*s)`.

Then `H*T=s-1/n`, so `||H*T||=1/n=1/(N-1)`, including the half-integer case
`n=2`. For each lower speed `1<=j<=n-1`, its fractional part is exactly `j*T`.
Moreover `T>1/(n+1)` because `H=n*s>n+1`, and

`0 < j*T <= (n-1)*T < (n-1)/n < n/(n+1)`.

Thus every original norm is strictly greater than `1/N` at this same time,
and the fastest has the required closed stronger margin. This independent
calculation proves `M` for the whole `s>=2` family, even though the published
ordinary maximum stays below `1/n`.

This actually reaches the domain left by the modular screen. Every `d` from
two through `n-1` divides its own retained speed, and `d=n` divides `H`.
The only possible direct denominator is `N=n+1`, and it divides `H=n*s`
exactly when it divides `s`. Therefore `D` fails exactly when `N|s`.
For example, every `s=(n+1)*q`, `q>=1`, supplies a primitive, divisor-covered
tuple with the displayed mixed witness. This is an infinite covered-domain
calculation, not a finite-search inference. Scaling preserves the mixed conclusion.

Its overlap with existing methods matters. Put `b=max(lower)=n-1`.
If `D` fails, then `s>=N=n+1`, so `H=n*s>=N*n>N*b`.
At `T0=1/n` the lower consecutive speeds have margin `1/n`, and `H*T0=s`
is integral. Moving by `1/(n*H)` places the fastest at margin `1/n`; each
lower norm loses at most `b/(n*H)<=1/(n*N)`. Its remaining margin is at least
`1/n-1/(n*N)=1/N`. This is precisely the elementary fast-insertion argument
under an explicit lower witness. Thus every divisor-covered member here was
already covered by that argument. The directional formula works also below
`H=N*b`, but those members necessarily have `D`, so the accepted modular
route covers them, including the nonunit-fastest cases at exceptional counts.
This comparison concerns the primitive base family and the remaining normalized
regime `not D` and `H<N*b`. Positive scaling preserves mixed existence and H/b,
but it can destroy D: scaling `(1,2,6)` by 12 gives `(12,24,72)`, which covers
every direct denominator at N=4 and has `72<4*24`. It inherits the mixed time
`5/216` from its primitive core, so it supplies no new normalized coverage.
The stronger assertion that no scaled member enters the raw comparable-height,
divisor-covered domain is false and is not claimed. This calibration was added
after root and independent review flagged the overlap; the formula itself and
all fixed controls are unchanged.

## Global exception boundary and relevance

For `s=1` in Class C, or no proper acceleration in Class A, the speeds are
consecutive. Ordinary goodness forces the `N` points `0,T,...,(N-1)T` to have
all cyclic gaps at least `1/N`: every nonzero index difference is a retained
speed. The gaps sum to one, so they all equal `1/N`. Hence necessarily
`T=k/N mod 1` with `gcd(k,N)=1`; conversely every such time is ordinary.
The fastest residue is `-k`, which can reach `1/(N-1)` exactly when a unit
other than `+/-1` exists. By the accepted modular classification, failure is
exactly `N=3,4,6`. This is a global real-time argument, and positive scaling
preserves it. It is the already-known exception, not a new obstruction.

The bounded screen therefore yields no new negative family. It removes the
published acceleration family as a promising obstruction source and provides
an explicit formula for a near-tight class already covered by modular or fast
insertion arguments. It does not
classify arbitrary tight tuples, establish the spectrum conjecture, prove a
global strict-to-mixed implication, or prove unrestricted mixed supply/LRC.
The remaining obstruction would have to lie outside these screened classes;
at nonexceptional counts it must still cover every direct denominator.

## Fixed exact controls

The sole program below checks five named acceleration fixtures, the three
printed sporadics, seven named near-tight parameter pairs, four consecutive
boundary fixtures, and two positive scales. There is no search over tuples or
unbounded parameter range. The largest acceleration fixture is the paper's
`N=74`, with labels 70 and 72 both doubled; the other fixtures are
`(N,r,m)=(8,6,2),(14,12,2),(20,18,2),(32,30,3)`.
All computations are integer arithmetic or exact rational arithmetic.

Run from the repository root with `python3 -B`, extracting this one block.
It only reads the accepted review and prints output.

```python
from fractions import Fraction as F
from math import gcd
from hashlib import sha256
from pathlib import Path

p = Path('research/astra-direct-to-mixed-units-review.md')
assert sha256(p.read_bytes()).hexdigest() == (
    'c424fc7970ade6a65e5388e0b3f60a34e091c01f2603f154646301bb5b9c96f5')

def norm(x):
    x -= x.numerator // x.denominator
    return min(x, 1-x)

def check(W, t, strict=False):
    N = len(W)+1
    assert tuple(sorted(set(W))) == W and min(W)>0 and t>0
    vals = tuple(norm(w*t) for w in W)
    assert min(vals) >= F(1,N) and vals[-1] >= F(1,N-1)
    if strict: assert min(vals) > F(1,N)
    return str(min(vals)), str(vals[-1])

def unit_time(N,H):
    if gcd(H,N)>1: return F(1,N)
    u = (N-1)//2 if N%2 else N//2-(1 if N%4==0 else 2)
    assert gcd(u,N)==1 and 2<=u<=N-2
    return F((pow(H,-1,N)*u)%N,N)

accelerations = [(8,{6:2}), (14,{12:2}), (20,{18:2}),
                 (32,{30:3}), (74,{70:2,72:2})]
saved = []
for N, changes in accelerations:
    for r,m in changes.items():
        s = N-r
        assert m>=2 and all(gcd(r,b)>1 for b in range(s,m*s))
        assert 0<m*s<r<N
    W = tuple(sorted(changes.get(r,1)*r for r in range(1,N)))
    assert 1 in W and all(w%N for w in W)
    T = unit_time(N,W[-1])
    print('acceleration',N,changes,'H',W[-1],'T',T,'margins',check(W,T))
    saved.append((W,T))

for W in [(1,3,4,7), (1,3,4,5,9), (1,4,5,6,7,11,13)]:
    N = len(W)+1
    T = F(1,N)
    print('sporadic',W,'T',T,'margins',check(W,T))

near = [(2,2),(2,3),(3,2),(4,5),(5,6),(7,8),(11,12)]
for n,s in near:
    N,H = n+1,n*s
    W = tuple(range(1,n))+(H,)
    T = F(H-1,n*H)
    ds = [d for d in range(2,N+1) if all(w%d for w in W)]
    assert ds == ([] if s%N==0 else [N])
    assert norm(H*T)==F(1,n)
    print('near-tight',(n,s),'H',H,'T',T,'margins',check(W,T,True),'direct',ds)
    if (n,s)==(4,5): saved.append((W,T))

for N in [3,4,6]:
    units = [k for k in range(1,N) if gcd(k,N)==1]
    assert units==[1,N-1]
    assert all(norm(F((N-1)*k,N))<F(1,N-1) for k in units)
    print('consecutive boundary',N,'units',units,'no mixed unit time')
print('consecutive positive',5,'T',F(2,5),'margins',check((1,2,3,4),F(2,5)))
for a,(W,T) in [(6,saved[0]),(5,saved[-1])]:
    print('scale',a,'H',a*W[-1],'T',T/a,'margins',check(tuple(a*w for w in W),T/a))
print('PASS: 5 acceleration, 3 sporadic, 7 near-tight, 4 consecutive, 2 scale fixtures')
```

## Executed evidence and handoff

The fixed program completed with exit code zero. Its exact hashes, including
the final newline, are:

| Evidence | SHA-256 |
| --- | --- |
| Sole Python block | `56bc4f0b72ffcadac9ec4e02437e5fe897b3752a1f2965d1a1da983c1c7203ab` |
| Program stdout | `8e01feefa0786193cbb92aa8a935859e31a55baa9b8c720db06970c373935010` |

The observed terminal summary was `PASS: 5 acceleration, 3 sporadic, 7 near-tight,
4 consecutive, 2 scale fixtures`. Five near-tight fixtures had no direct
denominator, as predicted; all seven had strict ordinary margins and fastest
norm exactly `1/n`. The controls only confirm named inputs. The quantified
proofs above, including the global consecutive negative proof, do not depend
on a finite-domain completeness assertion.

The execution command was:

```sh
python3 -B - <<'TIGHT_FAMILY_REPLAY'
from pathlib import Path
from hashlib import sha256
from contextlib import redirect_stdout
import io
p=Path('research/astra-tight-family-mixed-audit.md')
program=p.read_text().split('```python\n',1)[1].split('```',1)[0]
out=io.StringIO()
with redirect_stdout(out):
    exec(compile(program,'<tight-family-fixed-controls>','exec'),{})
print(out.getvalue(),end='')
print('Program SHA256:',sha256(program.encode()).hexdigest())
print('Output SHA256:',sha256(out.getvalue().encode()).hexdigest())
TIGHT_FAMILY_REPLAY
```

Other commands were scoped project reads/hash checks and the workflow validator.
For Goddyn–Wong, the web PDF decoder failed, so its primary journal-repository
PDF was fetched with `urllib.request.urlopen` into memory and passed on stdin
to `pdftotext -layout - -`; its successful byte hash is recorded above.
Kravitz's publication and theorem were read through the primary journal web
PDF and corroborated by the arXiv HTML; an optional direct Python retrieval
returned an empty response, which was rejected and is not treated as evidence.
No PDF or extracted-paper file was retained. No third paper, broad tuple
search, Lean command, Git mutation, workflow edit, or cache operation was run.

All commands have stopped. Only this manuscript was written. Its raw file hash
is reported separately at handoff. The next action is independent root review
of these bounded conclusions. This lead supplies positive covered-domain
evidence and rules out these particular published classes as sources of a
new mixed obstruction. After checking the fast-insertion overlap, no expansion
of the remaining comparable-height, divisor-covered domain is claimed. The
screen provides no obstruction lemma for arbitrary tuples.
