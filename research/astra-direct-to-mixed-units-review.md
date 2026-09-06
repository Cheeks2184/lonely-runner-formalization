# Independent review of direct-to-mixed supply through units

Requested Astra/xhigh manuscript review by `/root/mss_published_bound_audit`,
assigned checkpoint `fd99b6f550bcb931f101ef2186168f1fc09aec4d`. Only this review
is owned. Current project instructions, policy, configuration and active state
were inspected; `python3 -B scripts/validate_workflow.py` passed. Research is
authorized, observed runtime model/effort were not independently exposed, and
the unrestricted canonical goal remains unresolved.

**Verdict: accept the complete stated manuscript scope. No mathematical
correction is required.** Its main construction has no primitive hypothesis.
Its global negative conclusions for consecutive tuples have an analytic proof
independent of any finite search. Its designated-coordinate criterion is exact
only within the unit-reciprocal family. These are reviewed manuscript results,
not new Lean declarations or a proof of uniform mixed supply, K, or LRC.

## Direct conversion and exact count boundary

The main domain is N>=3 and N-1 distinct positive integer moving speeds W,
sorted with maximum H, relative to the stationary chosen runner. Direct means
that some d in 2,...,N divides no speed. Mixed requires every original norm
at least 1/N and the fastest norm at least 1/(N-1), at one positive time.

If d<N, T=1/d makes every circular residue distance at least 1/d>=1/(N-1).
This upgrades all coordinates simultaneously and includes equality d=N-1.
If d=N, T=1/N is ordinary. When g=gcd(H,N)>1, the fastest residue and its
complement are positive multiples of g, so its norm is at least
g/N>=2/N>=1/(N-1). Their positivity uses the indispensable admissibility
condition N not dividing H; a zero residue cannot be used in this argument.

In the remaining case H is a unit modulo N. A unit r other than +/-1 has
cyclic distance at least two. Set k=H^(-1)*r modulo N, represented in
1,...,N-1. Multiplication by this unit preserves nonvanishing of every original
residue, including those of nonunit speeds. Hence T=k/N is ordinary and its
fastest norm is at least 2/N>=1/(N-1). Every inequality holds at that same
positive time. The individual ordinary norms need not remain numerically
equal to their norms at 1/N. No step uses gcd(W)=1.

The explicit maximum-unit formula is valid on all N>=3:

| Case | Largest unit r<=N/2 | Reason |
| --- | --- | --- |
| N odd | (N-1)/2 | Any common divisor with N divides `N-2r=1`; this is the largest possible integer below N/2. |
| N=2m, m even | m-1 | It is odd and its common divisors with 2m divide 2. The only larger integer <=m is the nonunit m. |
| N=2m, m odd (N>=6) | m-2 | It is odd and its common divisors with 2m divide 4. The intervening m-1 and m are nonunits. |

These values are positive, equal one exactly at N=3,4,6, and at least two
otherwise. Reflection k -> N-k preserves units, so the displayed r also
maximizes the circular residue distance over all units. For unit H,
multiplication by H permutes the unit residues; consequently r/N is the exact
maximum fastest norm among unit times k/N. It is not asserted to maximize that
norm among all real mixed times.

The separate totient derivation is also correct. Prime-power counting and the
coprime-modulus Chinese remainder bijection give
`phi(N)=product p^(e-1)*(p-1)`. If this is <=2, every prime divisor is 2 or 3;
the exponents permit only 1,2,3,4,6,12, and 12 is excluded by phi(12)=4.
Thus, for N>=3, the only groups consisting of the two distinct units +/-1
occur at N=3,4,6. Either the totient argument or the explicit r formula proves
the claimed count boundary without treating a finite check as a classification.

Therefore D implies M for N=5 and every N>=7. At every N>=3 an admissible
d<N, or an admissible d=N with nonunit H, still supplies the stated sufficient
case. The three exceptional counts concern the unrestricted implication D=>M,
not failure of mixed existence for every tuple at those counts.

## Several designated margins and the restriction to unit times

For the generalized modular claim, retain N>=3 and assume no speed in the
finite collection is divisible by N. The collection need not have N-1 entries,
and no maximum-speed or primitivity premise is used. At any unit time k/N all
coordinates are ordinary at threshold 1/N.

A designated nonunit speed retains a nonzero residue with gcd at least two,
so it automatically has norm at least 2/N. For a designated unit w, the larger
bound fails exactly when the product residue is +/-1: the positive circular
residue distance is an integer, and
`1/N < 1/(N-1) <= 2/N`. The forbidden multipliers are precisely +/-w^(-1).
For N>=3 these are two distinct units. Two such pairs either coincide or are
disjoint, because an intersection gives equality up to sign of their generators.

Thus if c counts the distinct forbidden inverse sign-pairs, their union F has
exactly 2c elements, and the set of successful unit multipliers is exactly
U minus F. It is nonempty exactly when `2c<phi(N)`. Counting designated labels
instead of distinct sign-pairs would not give the exact criterion. Empty
designated sets and repeated sign-classes cause no exception. The N>=3 boundary
is necessary for this particular two-element-pair argument.

Failure of this criterion says nothing by itself about nonunit multipliers or
other positive real times. For example, at N=8 the collection (1,2,3), all
designated, exhausts the unit pairs but is upgraded at the nonunit reciprocal
time 2/8=1/4. In the original N=4, three-moving-speed domain, (1,2,5) has no
unit-time fastest upgrade but is mixed at 1/3. These are fixed controls on the
family restriction, not new global classifications.

## Consecutive tuples: global necessity and scaling

For W=(1,...,N-1), ordinary goodness makes the N points
0,T,...,(N-1)T pairwise separated by at least 1/N: the absolute difference of
any two indices is a retained speed, and circle norm is invariant under sign.
The points are distinct. Sort them cyclically; every consecutive circular gap
is at least 1/N because its shorter distance is at least 1/N. The N gaps sum
to one, so every gap equals 1/N. Since zero is a point, the whole set is the
regular N-grid. In particular T=k/N modulo one, and gcd(k,N)=1 is necessary
for N distinct orbit points. Conversely every such unit time is ordinary.
This proves necessity for every real time, not merely for a chosen grid search.

At a unit time the fastest residue (N-1)k is -k. Its norm reaches the larger
threshold precisely when k is not +/-1. Hence the mixed times modulo one are
exactly those phi(N)-2 unit times. The consecutive tuple is primitive and has
the direct witness d=N. At N=3,4,6 it nevertheless has no mixed time anywhere,
which proves that D=>M fails at each exceptional count. Every ordinary time
has some coordinate norm exactly 1/N, since multiplication by a unit permutes
all nonzero residues. Therefore no consecutive tuple has a strict ordinary
point; these counterexamples do not refute K.

For W=(a,2a,...,(N-1)a), a>=1, the positive time substitutions s=aT and
T=s/a preserve all norms simultaneously. Mixed existence is thus exactly the
same as in the unscaled consecutive tuple: it holds precisely when N is not
3,4,6. Every d<N divides the retained speed d*a. The only possible direct
denominator is N, and it is admissible exactly when gcd(a,N)=1. If the gcd is
g>1, the index j=N/g is in 1,...,N-1 and N divides j*a; if the gcd is one,
N dividing j*a would force N dividing j, which is impossible in that range.

It follows that D-or-M fails in this entire scaled consecutive family exactly
when N is 3,4,6 and gcd(a,N)>1. This is a classification of that family at all
positive scales. It is not a classification of arbitrary tuples at those counts,
and it does not say scaled primitivity is equivalent to gcd(a,N)=1.

## Remaining scope and imported equivalence

At N=5 or N>=7, the pointwise identity `(D or M) <-> M` follows directly from
the reviewed implication. Hence a mixed-empty tuple, and therefore any K
counterexample at these counts, must have every d=2,...,N divide a retained
speed. No mixed witness for such covered tuples follows from this construction.

At N=3,4,6, D together with absence of M forces every d<N to be covered,
N to divide no retained speed, and gcd(H,N)=1. These are only necessary
conditions. The manuscript's positive examples (2,5), (1,2,9), and
(1,3,4,5,7) meet them and have their displayed mixed times. Also M does not
imply strict ordinary existence: the consecutive N=5 tuple is mixed at 2/5
but has no strict ordinary time anywhere by the preceding regular-grid proof.
No proof or refutation of K or uniform M is inferred from these facts.

I read the referenced S/M review at its guarded hash. Its accepted manuscript
contract is for every N>=3, sorted distinct positive integer speeds, stationary
chosen runner, full exact two-anchor S with no added q/u/tau bounds, and actual
collision count. It imposes no primitive hypothesis, retains the closed
coordinate and fastest margins at one time, and proves positive-time transport.
It includes the N=3 zero-loss case. Thus replacing M by that exact S in the
pointwise logical reformulation is legitimate. This reference is an independently
reviewed manuscript equivalence, not a newly checked Lean theorem; it is not
needed for the direct modular construction itself.

## Fixed verification and source guards

I read and independently replayed the entire frozen program. Source, program,
stdout and root-replay hashes matched. The controls comprise exactly eleven
direct conversions (two d<N, two nonunit H, seven unit H), twelve named moduli
3,4,5,6,7,8,9,10,12,14,18,30, six consecutive tuples at N=3,...,8, seven
designated-coordinate controls, three positive exceptional-count controls and
eleven named scaled-consecutive cases. The designated allowed counts were
`[2,0,2,0,2,0,2]`. The closed-band program handles singleton intersections and
the N=3 fastest half-threshold using `<=`; it does not replace the analytic
global negative proof. No tuple discovery or broad enumeration was run.

The independent replay command was the following, from the repository root:

```sh
python3 -B - <<'DIRECT_MIXED_INDEPENDENT_REPLAY'
from pathlib import Path
from hashlib import sha256
from contextlib import redirect_stdout
import io,re
p=Path('research/astra-direct-to-mixed-units.md')
assert sha256(p.read_bytes()).hexdigest()=='a9ac1da5754a1ef8921ad22f3f28785a4dc841e2a2cfa1bd3a04f338224fcb01'
b=re.findall(r'^```python\n(.*?)^```[ \t]*$',p.read_text(),re.M|re.S)
assert len(b)==1 and sha256(b[0].encode()).hexdigest()=='8697cbd8e3828b06e69acc66ba3d366f1ef95a330543f562190d4a6712b24161'
out=io.StringIO()
with redirect_stdout(out):exec(compile(b[0],'direct-to-mixed-independent-fixed-replay','exec'),{})
assert sha256(out.getvalue().encode()).hexdigest()=='1730cce7193a1a642637df61ea90f736d2a9f72b80bab1c578101f54cfab15af'
assert sha256(Path('/tmp/astra-direct-to-mixed-units-root-replay.json').read_bytes()).hexdigest()=='1730cce7193a1a642637df61ea90f736d2a9f72b80bab1c578101f54cfab15af'
print(out.getvalue(),end='')
DIRECT_MIXED_INDEPENDENT_REPLAY
```

Separate exact `Fraction` controls checked the three maximum-unit branches at
N=21,16,22, obtaining r=10,7,9; the collection-size-independent designated claim
at N=8 with W=A=(1,2,7,10), whose allowed units are {3,5}; the exhausted-unit
collection (1,2,3) and its nonunit escape 1/4; the genuine three-speed mixed
escape (1,2,5),T=1/3; and the nonprimitive direct conversion
(3,6,9,12),N=5,T=1/5. All passed. This checks the new claim's absence of a
collection-size or primitive premise without expanding a tuple search.

| Artifact | SHA-256 |
| --- | --- |
| Frozen author manuscript | `a9ac1da5754a1ef8921ad22f3f28785a4dc841e2a2cfa1bd3a04f338224fcb01` |
| Author sole program, final newline included | `8697cbd8e3828b06e69acc66ba3d366f1ef95a330543f562190d4a6712b24161` |
| Independently reproduced stdout, final newline included | `1730cce7193a1a642637df61ea90f736d2a9f72b80bab1c578101f54cfab15af` |
| S/M equivalence review | `f340c0a311ed6e04d802ee8edfb407a84bc329145bc7e9b446d692cd4e52430a` |
| `.codex/config.toml` | `3d723356048f445685a6b4b977e755c3a2e60c70a134195b7cf39897ec9f9d4e` |
| `docs/project-workflow.md` | `49a1ca496880b250377bd0b61ab6deefc0036865dbe545169527eee2bf7439f7` |
| `research/workflow-policy.json` | `7b25a1b28b0c8cc45228fd7241cdb73ed6267d4f229773d1210a175f730f1242` |
| `scripts/validate_workflow.py` | `899cdf0b58eec8b960286565778b381b80ca07661516cce99c75156c35b4fc04` |

Other commands were scoped `cat` reads, Python JSON/hash inspection, the small
rational controls above, and the workflow validator. Only this review was
written. No Lean, Git, shared-state, dependency or cache operation was performed.
Final source guards/readback precede freezing; the review hash is reported
separately. All reviewer commands are stopped at handoff. This manuscript review
belongs to a future checkpoint and does not enlarge the current Pass32 scope.
