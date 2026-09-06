# Independent review of the tight-family mixed screen

Assigned Astra/xhigh review by `/root/mss_published_bound_audit`, source
checkpoint `7e1b4073cfd0095a3e514df975313562feb82688`. Only this review is owned.
Current configuration, project workflow, policy and active state were read;
`python3 -B scripts/validate_workflow.py` passed. Research is authorized and the
canonical goal remains unresolved. Requested routing is recorded; observed
runtime model/effort were not independently exposed.

**Verdict: accept the clarified quantified constructions, source attributions
and normalized coverage conclusion.** The initially required normalization
clarification is now explicit in the author's Class C overlap paragraph.
The non-expansion claim concerns the primitive base family and the normalized
remaining domain; a stronger raw reading across all scales is false and is
explicitly excluded, as the fixed countercontrol below shows. The exceptional
counts also require the explicit modular reasoning recorded below. With that
scope, this screen covers the three stated classes and their positive scales,
with the already-known consecutive exceptions. It does not classify all
published tight tuples or resolve LRC.

## Verification of the two primary works

I retrieved only the two specified works, including the specified earlier
version of Kravitz's paper for theorem-number and boundary comparison.

The [Goddyn–Wong published PDF](https://zenodo.org/records/8275490/files/g38.pdf)
confirms the title *Tight Instances of the Lonely Runner*, Integers 6 (2006),
A38, published 12 December 2006. Their n counts the stationary runner as well,
so n=N here. Theorem 2.3, pp. 4–6, characterizes equality for one integer
acceleration, including the separate (n,r,m)=(3,1,4) case (and the n=2 case,
outside this screen's N>=3 domain). Theorem 3.1, pp. 7–9, gives the displayed
GCD condition as a sufficient condition for simultaneous accelerations to
have ordinary maximum 1/n. Its unrestricted converse is explicitly absent.
Corollary 3.3, pp. 9–10, constructs infinitely many such examples with prescribed
multiplier subsequences. The p. 2 table and the N=74 double-acceleration example
match the manuscript. No exhaustiveness claim is imported from that table.

The [Kravitz published paper](https://escholarship.org/content/qt3wx931fh/qt3wx931fh.pdf)
confirms Combinatorial Theory 1 (2021), #17, DOI 10.5070/C61055383, published
15 December 2021. The family and ordinary-maximum formula occur in Theorem 3.1,
printed pp. 5–6. His n is the number of moving speeds, so N=n+1.
The given [arXiv v1, Theorem 5.1](https://arxiv.org/html/1912.06034v1#S5)
explicitly confirms the n>=2 boundary and the same formula; the manuscript
restricts to s>=1 to retain positive speeds. Neither version asserts the
manuscript's fastest-coordinate mixed conclusion. That conclusion is separately
proved by its elementary time formula, not extracted from the spectrum
conjecture or from an assertion about every maximizing time.

Goddyn–Wong was fetched into memory from the query-free URL above and piped
as bytes to `pdftotext -layout - -`; selected pages were read from stdout.
The 272456-byte PDF matched SHA-256
`dc9b2a9a8fd9849ee5f05664b83899df83b8ab23a622300625e50465cf463197`.
The web decoder could not decode that PDF, and initial queried requests
returned 429/403 before the query-free memory retrieval succeeded.
Kravitz's primary published PDF and arXiv HTML were read through the web tool.
An optional Python PDF request returned 403, and another returned a non-PDF
response; both were rejected. No byte hash is claimed for those unsuccessful
responses. No PDF or extracted-paper file was retained, and no third work or
broader literature search was used.

## Acceleration family: residues, actual maximum and distinctness

For a proper multiplier m>=2 at label r, put s=N-r. The GCD condition covers
every integer in [s,ms). If s=1, its first entry is coprime to r, impossible.
Hence s>=2. If s>=r, that interval contains at least r consecutive integers,
including one congruent to one modulo r, again impossible. Thus s<r.
If ms>=r, the integer r-1 lies in [s,ms) and is coprime to r. Consequently

```
0 < ms < r < N.
```

It follows directly that `mr=mN-ms` has nonzero residue modulo N.
Unaccelerated labels also have nonzero residue, so d=N is admissible.
Moreover a properly accelerated value lies strictly between (m-1)N and mN,
because 0<ms<N. Values from different multipliers lie in disjoint open
intervals; for the same multiplier multiplication preserves distinct labels.
The multiplier-one values lie in (0,N). Hence sorting produces exactly N-1
distinct positive speeds. Label one cannot be properly accelerated, so speed
one remains and the tuple is primitive. Mixed must use the actual maximum of
the accelerated values, as the manuscript does; it is not tied to label N-1.

The inequalities also give `N=r+s>(m+1)s>=3s>=6`. Thus any proper acceleration
forces N>=7. The accepted modular theorem therefore applies to the admissible
d=N and supplies a common positive mixed time, regardless of whether the
actual maximum H is a unit modulo N. The displayed nonunit/unit branches
correctly realize that time and preserve every ordinary residue bound.

When no multiplier is proper the tuple is consecutive. The separate
single-acceleration exception (3,1,4) is sorted (2,4), of gcd two, and is the
already-known scale of (1,2). It is outside the displayed GCD-conditioned
class, whose base tuples are primitive; it must not be treated as a proper
acceleration satisfying that condition.

For the three sporadics, the printed vectors, maxima and times all match the
primary source. At their respective denominators 5,6,8 every residue is nonzero.
The fastest norms are 2/5,1/2,3/8, each at least 1/(N-1). The N=6 case uses
the nonunit fastest residue 9 modulo 6 and does not rely on an invalid universal
D=>M implication at that exceptional count. Scaling the tuple by a>0 and
dividing its time by a preserves the maximum label and every norm simultaneously.

## Kravitz family and the n=2 boundary

For n>=2 and s>=1, W=(1,...,n-1,ns) has n moving speeds, total count N=n+1,
actual maximum H=ns, distinct positive entries and gcd one. For s>=2 the
proposed time is

```
T=(H-1)/(nH)=1/n-1/(nH)>0.
```

Since H=ns>=2n>n+1, we have
`T-1/(n+1)=(H-n-1)/(nH(n+1))>0`. For every lower j in 1,...,n-1,

```
1/(n+1) < T <= jT <= (n-1)T < (n-1)/n < n/(n+1).
```

These are actual fractional parts, lying strictly between zero and one.
Thus each lower circle norm is strictly above 1/N. At the fastest speed,
`HT=s-1/n`, whose norm is exactly 1/n because n>=2. For n=2 this is exactly
the antipodal norm 1/2, still strictly above the ordinary threshold 1/3.
Therefore every original coordinate has a strict ordinary margin at the same
positive time, while H has its closed stronger margin 1/(N-1). This does not
conflict with the published ordinary maximum below 1/n, since the stronger
margin is required only at the fastest coordinate.

Every d in 2,...,n-1 divides its retained speed, and d=n divides H. This also
handles n=2, when the first range is empty. The remaining candidate N=n+1
divides none of the lower speeds and divides H=ns exactly when it divides s,
using gcd(n,n+1)=1. Hence D fails exactly when N divides s, for the base family.
For such s, `s>=N` gives

```
H=ns >= nN > (n-1)N = N*b,     b=n-1.
```

At T0=1/n the lower coordinates have norm at least 1/n and H is at an integer
phase. The change of time -1/(nH) puts the fastest at norm 1/n. Whenever
H>=N*b, the norm loss of every lower speed is at most
`b/(nH)<=1/(nN)`, leaving at least `1/n-1/(nN)=1/N`. This is the elementary
mixed fast-insertion calculation with an explicit lower witness. It is not a
claim that the ordinary `fastRunnerInsertion` conclusion alone already states
the stronger fastest margin. Every divisor-covered member of this family lies
strictly within the range of that elementary calculation.

The members below H=N*b necessarily have D, but invoking D=>M at all counts
would be insufficient without checking N=3,4,6. Here that check succeeds:
`ns<(n+1)(n-1)` is equivalent to the integer restriction `s<=n-1`. Among s>=2,
the exceptional possibilities are exactly:

| N | n | s with H<N*b | gcd(H,N) |
| --- | --- | --- | --- |
| 3 | 2 | none | not applicable |
| 4 | 3 | 2 | 2 |
| 6 | 5 | 2,3,4 | 2,3,2, respectively |

Each listed member is covered by the accepted nonunit-fastest modular branch
at time 1/N. Other counts use the general D=>M theorem. Equality H=N*b is
impossible in this integer family because n would have to divide n^2-1.
This verifies the manuscript's whole-class modular-or-insertion calibration,
including the exceptional counts. Positive scaling preserves the mixed result
and the height ratio H/b; it does not preserve D in general, and the manuscript
does not claim that it does. The implication `not D -> H>N*b` above is about
the primitive base family. A raw scaled tuple can be covered below that bound:
scaling (1,2,6) by 12 gives N=4, W=(12,24,72), with every direct denominator
covered and H=72<4*24. It inherits the mixed time 5/216 from its primitive
core, with norms (5/18,4/9,1/3). Thus the correct calibration is that no new
normalized comparable-height, divisor-covered case is reached; it is not an
assertion that such raw scaled tuples do not exist. The revised Class C overlap
paragraph now explicitly states this scope and includes this countercontrol.
That resolves the required clarification. Promotion and checkpoint descriptions
must retain this normalized scope; this review does not certify the stronger
raw-family sentence.

## Global consecutive boundary and final scope

For s=1, or no proper acceleration, ordinary goodness makes
0,T,...,(N-1)T pairwise separated by at least 1/N. Their N cyclic gaps sum to
one and are each at least 1/N, so they form the regular N-grid. Necessarily
T=k/N modulo one with gcd(k,N)=1, and conversely these times are ordinary.
The fastest residue is -k. Its norm reaches 1/(N-1) exactly when that unit
is not +/-1, which is possible exactly outside N=3,4,6. This is a global
real-time argument; the program's finite unit checks are only controls on it.
Positive scaling preserves both existence and failure by the time bijection.

Apart from these established consecutive exceptions, the screened acceleration,
sporadic and near-tight classes have the claimed mixed witnesses. This does not
classify arbitrary tight sets, prove a spectrum conjecture, prove K, or supply
uniform mixed witnesses. The infinite divisor-covered near-tight subfamily is
already covered by the elementary insertion argument, so its new explicit
formula is not an expansion of the remaining normalized comparable-height
domain.

## Reproducible controls, hashes and handoff

I independently replayed the frozen sole Python block after verifying both its
manuscript and program hashes. It exited zero and reproduced stdout SHA-256
`8e01feefa0786193cbb92aa8a935859e31a55baa9b8c720db06970c373935010`.
After the root clarified only the Class C overlap paragraph, I read the revised
paragraph and replayed the unchanged sole block against the new manuscript hash.
The author changed from
`f6cd2d351226e36cf0bb2a283ca4ac002ebf151bb970e6379f9dbd034e2d25d2`
to `717995d2f3adfdea64d09f8022493c31e2a606262c5361fee37ca1fc9879a7c4`.
The program and stdout hashes stayed identical, and the scaled countercontrol
was checked again. Acceptance is bound to the clarified manuscript.
Exactly the named 21 fixtures were checked: five accelerations, three sporadics,
seven near-tight pairs, four consecutive cases and two scales. All seven
near-tight fixtures have strict ordinary margins; five have no direct
denominator. The program uses exact integer/rational arithmetic and verifies
positivity, sorting/distinctness, all original margins and the actual maximum.
It does not establish a completeness claim from these named fixtures.

The independent replay command, from the repository root, was:

```sh
python3 -B - <<'TIGHT_FAMILY_INDEPENDENT_REPLAY'
from pathlib import Path
from hashlib import sha256
from contextlib import redirect_stdout
import io,re
p=Path('research/astra-tight-family-mixed-audit.md')
assert sha256(p.read_bytes()).hexdigest()=='717995d2f3adfdea64d09f8022493c31e2a606262c5361fee37ca1fc9879a7c4'
b=re.findall(r'^```python\n(.*?)^```[ \t]*$',p.read_text(),re.M|re.S)
assert len(b)==1 and sha256(b[0].encode()).hexdigest()=='56bc4f0b72ffcadac9ec4e02437e5fe897b3752a1f2965d1a1da983c1c7203ab'
out=io.StringIO()
with redirect_stdout(out):exec(compile(b[0],'tight-family-independent-fixed-controls','exec'),{})
assert sha256(out.getvalue().encode()).hexdigest()=='8e01feefa0786193cbb92aa8a935859e31a55baa9b8c720db06970c373935010'
print(out.getvalue(),end='')
TIGHT_FAMILY_INDEPENDENT_REPLAY
```

Separate fixed `Fraction` checks verified all four exceptional-count nonunit
conversions in the table above, the immediately-above-bound cases s=n at
n=2,3,5 (where H=N*b+1), the absence of any N=3,s>=2 case below the bound,
and the scaled N=3 exception identity. These all passed, with no tuple search.
For reproduction, the four nonunit rows are `(n,s,gcd(H,N))=(3,2,2),
(5,2,2),(5,3,3),(5,4,2)` at T=1/(n+1); the three insertion controls use
T=(n^2-1)/n^3. The exceptional pair (2,4) at T=1/6 has both norms 1/3.
The additional raw-scale control (12,24,72),T=5/216 verified the normalization
distinction above, including gcd 12, failure of D, H<4*b, and all three norms.

| Frozen artifact | SHA-256 |
| --- | --- |
| Clarified author manuscript, accepted | `717995d2f3adfdea64d09f8022493c31e2a606262c5361fee37ca1fc9879a7c4` |
| Initial author manuscript, before scope clarification | `f6cd2d351226e36cf0bb2a283ca4ac002ebf151bb970e6379f9dbd034e2d25d2` |
| Author sole program, final newline included | `56bc4f0b72ffcadac9ec4e02437e5fe897b3752a1f2965d1a1da983c1c7203ab` |
| Independently reproduced stdout, final newline included | `8e01feefa0786193cbb92aa8a935859e31a55baa9b8c720db06970c373935010` |
| Accepted modular review | `c424fc7970ade6a65e5388e0b3f60a34e091c01f2603f154646301bb5b9c96f5` |
| In-memory Goddyn–Wong published PDF | `dc9b2a9a8fd9849ee5f05664b83899df83b8ab23a622300625e50465cf463197` |

Other commands were scoped project reads, Python JSON/hash inspection, primary
web retrieval, the memory-only PDF/text pipeline described above, and the
workflow validator. No PDF artifact, third-party dependency, Lean source,
workflow state, Git data or cache was written or modified. Only this owned
review was written. Source guards/readback precede freezing; its final hash is
reported separately. All reviewer processes are stopped at handoff. These are
manuscript findings only, and unrestricted LRC remains unresolved.
