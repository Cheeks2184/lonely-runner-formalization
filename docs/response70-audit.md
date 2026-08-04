# Response 70 mathematical audit

## Scope and disposition

This document independently audits the mathematical claims in immutable
Response70 at commit `7ca41ed3b537d6270ad07de52fdaf44e80b73f7d`.
It does not execute or inspect the contents of the recovered Python or JSON
attachments. Their provenance is recorded separately in
`docs/response70-provenance-audit.md`.

Response70's self-disposition `PIVOT` is not accepted as evidence. The audit
finds:

- the full-cover equivalence, coarse divisor-cover identity, singleton-cover
  rigidity, strict-growth functional-digraph theorem, and all-but-one infinite
  family are mathematically valid and recommended for `proved-math`;
- the explicit pivot-two partition of `(1,2,3,5)` validly refutes the proposed
  private-point-to-common-factor step;
- the common-modulus Fourier pullback formula is valid, but it only embeds
  separate pivot equations and supplies no cross-pivot coupling operation;
- the proposed `SIMULTANEOUS-FULL-COVER-COMMON-PRIME` statement is logically
  equivalent to unrestricted LRC given the verified pivot and real/integer
  equivalences, not a genuinely narrower bridge; and
- the local structural lemmas are genuine unrestricted necessary conditions,
  but none proves that some pivot has an uncovered candidate.

The route-level recommendation is **STOP** for the common-prime target as an
independent proof route: it is an equivalent reformulation and both proposed
prime-propagation mechanisms hit exact counterexamples. Preserve the accepted
local structural lemmas for reuse, and freeze any further propagation work
unless a new lemma is stated strictly below the full-cover contradiction.

All attachment-derived fixture batches and bounded scan counts remain
**unaccepted in this audit**, pending independent artifact audit 153. No result
about unrestricted Lonely Runner is promoted.

## Exact definitions

Let `n>=1`, put `N=n+1`, and let

```text
a : Fin n -> Nat
```

be positive and injective. For pivot `j`, put

```text
p_j = a_j,
M_j = N*p_j,
rho_M(x) = min(x mod M, M-(x mod M)),
R_j = {r in {0,...,M_j-1} : N does not divide r},
B_i^j = {r in R_j : rho_(M_j)(r*a_i) < p_j}  for i != j,
mu_j(r) = #{i : i != j and r in B_i^j},
Q_j = {r in R_j : mu_j(r)=0},
G_j(a) = |Q_j|.
```

Badness is strict `<p_j`; equality is safe. Both cyclic representatives are
included through `rho`. Repeated modular residues and coincident bad sets are
allowed, while owner indices remain distinct in `mu_j`.

Define

```text
FullCover_j(a) :<-> union_{i!=j} B_i^j = R_j.
```

The Response70 target is

```text
SIMULTANEOUS-FULL-COVER-COMMON-PRIME:

For every n>=1 and every positive injective a : Fin n -> Nat,
if FullCover_j(a) for every j, then
there exists a prime q such that q divides a_i for every i.
```

The `n=1` antecedent is false because there are no owners and `R_j` is
nonempty. The structural range is `n>=2`, hence `N>=3`.

## Exact claim table

| Response lines | Exact claim | Independent result | Recommended label | Exact boundary |
| --- | --- | --- | --- | --- |
| 27--96 | Frozen definitions, `|R_j|=n*p_j`, and `G_j=0` iff `FullCover_j(a)` | Valid | `proved-math` | Finiteness turns cardinal zero into emptiness; coincident owners remain indexed. |
| 127--169 | At `r=k*p_j`, badness by owner `i` is equivalent to `N` dividing `k*a_i` | Valid | `proved-math` | Applies only when `1<=k<=N-1` and `r` is a candidate, i.e. `N` does not divide `k*p_j`. |
| 164--169 | Simultaneous full covers force either all speeds `N`-divisible or a mixed pattern with at least one `N`-divisible speed | Valid necessary condition | `proved-math` | One such speed covers every coarse candidate at every other pivot, so the identity does not propagate to all coordinates. |
| 173--213 | Canonical inclusion-minimal covers have private candidates | Valid | `proved-math` | Privacy is relative to the selected cover; an omitted owner may also cover the candidate. |
| 215--295 | Singleton-cover rigidity: one owner covers `R_j` iff `N*a_j` divides its speed | Valid | `proved-math` | Requires `N>=3`; equality at distance `p_j` is safe. |
| 298--325 | Under simultaneous full covers, some pivot has no singleton subcover | Valid after wording correction | `proved-math` | Choose a covering owner; it need not be unique. The resulting strict-growth cycle is impossible. |
| 327--357 | Private strict intervals force a nontrivial owner/pivot gcd | False | `rejected` | Pivot two of `(1,2,3,5)` is an exact partition by three coprime owners. |
| 359--511 | Pivot-local indicator/Fourier equations restate full cover exactly | Locally valid at the stated convention; no global bridge follows | `proved-math` only for the exact identities | The zero coefficient is exactly `G_j/M_j`; using it alone is the forbidden good-count restatement. |
| 513--539 | A full pivot must contain a nonunit owner modulo its pivot modulus | False | `rejected` | Pivot seven of `(1,3,4,5,7,18)` is fully covered by owners all coprime to 49. |
| 541--571 | Pullback to `Q=lcm_j M_j` preserves each normalized Fourier transform on its own frequency subgroup | Valid | `proved-math` | The rewrite creates no relation between different pulled-back equations. It does not prove that no future coupling theorem exists. |
| 575--657 | `n-1` full pivots force a global common prime | False in every `n>=2` | `rejected` | The explicit primitive family `(1,...,n-1,mN*lcm(1,...,n-1))` has exactly the first `n-1` pivots full. |
| 659--679 | Primitive scan through largest speed 12 finds no simultaneous full cover | Not checked here | unaccepted pending audit 153 | Recovered computation only; even successful replay would be finite evidence. |
| 681--805 | Common-prime target implies pivot-certificate conjecture and unrestricted LRC | Valid conditional implication | `proved-math` implication with open/equivalent premise | Primitive normalization and exact common scaling are required. |
| 807--812 | Unrestricted LRC implies the common-prime target vacuously | Valid | `proved-math` logical implication | Simultaneous full cover is exactly absence of every pivot certificate. |
| 888--900 | A persistent prime can be selected from multiowner covers using the supplied attacks | Not established | `open` arrow; route stopped | Private points and separate Fourier support do not choose the same prime across pivots. |

## Full-cover equivalence and strict boundary

For every candidate `r in R_j`,

```text
mu_j(r)=0
  iff r is in no B_i^j
  iff r is not in union_{i!=j} B_i^j.
```

Therefore

```text
Q_j = R_j \ union_{i!=j} B_i^j.
```

Since all sets are finite and every bad set is contained in `R_j`,

```text
G_j=0
  iff Q_j is empty
  iff union_{i!=j} B_i^j = R_j
  iff FullCover_j(a).
```

This is an exact finite-set equivalence, not an existence theorem. The
complement of strict badness is the closed condition `rho>=p_j`; no step may
replace it by `rho>p_j`.

## Coarse divisor-cover identity

Fix pivot `j`, write `p=p_j`, and choose `1<=k<=N-1`. For the residue
`r=k*p`,

```text
rho_(N*p)(p*x)=p*rho_N(x),
```

because the canonical distance on the subgroup of multiples of `p` scales by
`p`. Hence

```text
r in B_i^j
  iff p*rho_N(k*a_i)<p
  iff rho_N(k*a_i)=0
  iff N divides k*a_i.
```

This conclusion may be used only if `r` is in `R_j`, equivalently if `N` does
not divide `k*p_j`. Therefore

```text
FullCover_j(a) ->
  for every k in {1,...,N-1},
  N does not divide k*a_j ->
  there exists i!=j with N dividing k*a_i.
```

At `k=1`, if not every speed is divisible by `N`, choose a pivot whose speed is
not divisible by `N`; its full cover supplies a different `N`-divisible speed.
Thus simultaneous full covers imply either:

1. every speed is divisible by `N`, in which case any prime divisor of `N` is
   already common; or
2. at least one speed is `N`-divisible and at least one is not.

This is genuine, height-independent necessary arithmetic information. It does
not iterate: once `a_i` is divisible by `N`, owner `i` covers every valid
coarse candidate `k*p_j` at each other pivot `j`, so those candidates cannot
force new divisible coordinates.

## Singleton-cover rigidity

Let `N>=3`, `p>=1`, `M=Np`, and `A` be a natural number. Consider

```text
B_A={r mod M : N does not divide r and rho_M(A*r)<p}.
```

The exact theorem is

```text
B_A=R  iff  M divides A.
```

The reverse implication is immediate. For the forward implication, put

```text
d=gcd(A,M),  m=M/d.
```

Multiplication by `A` on `Z/MZ` has image the subgroup of multiples of `d`, of
order `m`, and kernel the subgroup generated by `m`, of order `d`.

Suppose `m>1`. The image element

```text
y=d*floor(m/2)
```

is safe because

```text
rho_M(y)=d*floor(m/2)>=d*m/N=M/N=p.
```

For `m=2`, `floor(m/2)/m=1/2`; for `m>=3` it is at least `1/3`, and
`N>=3`. Every point in the fiber over `y` is safe. Under the full-cover
assumption every safe preimage must lie in the excluded subgroup

```text
H=N*(Z/MZ),  |H|=p.
```

A fiber is a coset of the kernel. If one entire kernel coset lies in subgroup
`H`, differences show that the kernel lies in `H`. Its generator `m` is
therefore divisible by `N`; write `m=N*u`. From `M=d*m=N*p`, obtain `p=d*u`.

An image point `d*k` is bad exactly when

```text
d*rho_m(k)<d*u,
```

so exactly `2u-1` of the `m=N*u` image points are bad. Each image point has
`d` preimages. The number of safe preimages is therefore

```text
d*(m-(2u-1))=(N-2)*p+d>p=|H|,
```

contradicting containment in `H`. Hence `m=1`, so `M` divides `A`.

Applied at pivot `j`, this gives

```text
B_i^j=R_j  iff  N*a_j divides a_i.
```

The theorem is genuinely local and narrower than LRC. It classifies singleton
covers but says nothing directly about multiowner covers.

## Strict-growth functional digraph

Assume every pivot is fully covered and every pivot has some singleton
subcover. For each pivot `j`, choose one owner `f(j)!=j` that covers all of
`R_j`. Response70 calls this owner “unique,” but uniqueness is neither proved
nor needed; choosing the least such owner makes the selection canonical.

Singleton rigidity gives

```text
N*a_j divides a_(f(j)),
a_(f(j))>=N*a_j>a_j.
```

Iteration of the function `f : Fin n -> Fin n` eventually enters a directed
cycle. Speeds strictly increase along every edge, which is impossible around a
cycle. Therefore simultaneous full covers force at least one pivot with no
singleton subcover. Equivalently, at least one inclusion-minimal owner cover
has at least two owners.

This is an unrestricted, genuinely cross-pivot necessary condition. It does
not rule out simultaneous multiowner covers and therefore does not prove LRC.
For `n=2`, each pivot has only one possible owner, so it does rule out
simultaneous full covers in that dimension.

## Exact multiowner partition at pivot two

Take `a=(1,2,3,5)`, so `n=4`, `N=5`, and pivot speed two has modulus ten. Its
candidate set is

```text
R={1,2,3,4,6,7,8,9}.
```

Direct multiplication with strict threshold two gives

```text
B_1={1,9},
B_3={3,7},
B_5={2,4,6,8}.
```

These owner-indexed sets form an exact partition of `R`. Every point is private
and has multiplicity one, yet

```text
gcd(1,2)=gcd(3,2)=gcd(5,2)=1.
```

Thus even global privacy inside this pivot does not imply a nontrivial common
factor between an owner and the pivot. The counterexample rejects that exact
propagation arrow, not the possibility of some different cross-pivot theorem.

## Full cover by unit owners

The separate claim that a full pivot requires a nonunit owner is also false.
For `a=(1,3,4,5,7,18)`, take pivot seven, so `N=7` and `M=49`. All owners are
coprime to 49. On positive representatives `1,...,24`, the symmetric bad sets
are

```text
B_1  = +/-{1,2,3,4,5,6},
B_3  = +/-{1,2,15,16,17,18},
B_4  = +/-{1,11,12,13,23,24},
B_5  = +/-{1,9,10,11,19,20},
B_18 = +/-{3,8,11,16,19,22}.
```

Their displayed positive halves cover every number from 1 through 24 except
the excluded multiples `7,14,21`; reflection covers the other half. This is an
independent finite proof for this explicit pivot, not acceptance of the
attachment's batch computations.

## Common-modulus Fourier pullback

For each pivot modulus `M_j`, let `Q=lcm_j M_j` and `s_j=Q/M_j`. Given
`f_j : Z/M_jZ -> C`, define

```text
f_tilde_j(x)=f_j(x mod M_j)
```

on `Z/QZ`. Under the normalized transform, split `x=y+tM_j`, with
`0<=t<s_j`. The inner geometric sum is zero unless `s_j` divides the frequency
`k`. When `k=s_j*l`, normalization gives

```text
hat(f_tilde_j)(k)=hat(f_j)(l).
```

Thus the exact formula is

```text
hat(f_tilde_j)(k)=0                if s_j does not divide k,
hat(f_tilde_j)(s_j*l)=hat(f_j)(l).
```

This faithfully embeds each pivot identity into a separate frequency subgroup
of `Z/QZ`. It does not multiply, average, or otherwise relate identities from
different pivots. Any such operation is a new lemma requiring proof; it does
not follow from sharing the carrier group. The audit therefore accepts the
pullback formula and the negative assessment of the supplied argument, but it
does not claim that every possible Fourier coupling theorem is impossible.

## All-but-one infinite family

For every `n>=2`, put `N=n+1` and

```text
L_0=N*lcm(1,2,...,n-1),
L=m*L_0  for any m>=1,
a=(1,2,...,n-1,L).
```

This tuple is positive and injective because `L>=N>n-1`. It is primitive
because it contains speed one. For pivot `p` in `{1,...,n-1}`,

```text
N*p divides L.
```

Therefore owner `L` annihilates every residue modulo `N*p`, so each of the
first `n-1` pivots is fully covered by a singleton owner.

At pivot `L`, take `r=L+1`. Because `N` divides `L`, this is a candidate. For
owner `s` with `1<=s<=N-2`, put `x=s(L+1)`. It lies between zero and `NL`, and

```text
x>=L+1>L,
NL-x=(N-s)L-s>=2L-(N-2)>=L.
```

Hence `rho_(NL)(s(L+1))>=L`, with equality safe. The last pivot is not fully
covered. Its reflected good candidate is distinct: equality of the two would
force `(N-2)L=2`, impossible because `L>=N>=3`.

Consequently this primitive family has exactly `n-1` full pivots and no common
prime divisor. Permutation places the unique non-full pivot at any chosen
index. This proves that every pivot hypothesis in the simultaneous target is
essential and decisively rejects any common-prime theorem assuming only
`n-1` full pivots.

## Logical strength of the common-prime statement

### Common-prime statement implies LRC

Assume the common-prime statement and suppose a positive injective integer
tuple `a` has no pivot certificate. The full-cover equivalence gives
`FullCover_j(a)` for every pivot.

Let `d=gcdAll(a)>0` and define `b_i=a_i/d`. Then `b` is positive, injective,
and primitive. For every pivot, common scaling gives the exact identities

```text
G_j(a)=d*G_j(b),
FullCover_j(a) iff FullCover_j(b).
```

The common-prime statement applied to `b` gives a prime dividing every `b_i`,
contradicting `gcdAll(b)=1`. Hence every positive injective integer tuple has a
pivot certificate. The existing verified equivalences then give the
positive-integer conjecture and the canonical real LRC statement.

The scaling identity can also be checked at membership level: if
`M_a=d*M_b` and `s=r mod M_b`, then

```text
N divides r iff N divides s,
rho_(d*M_b)(r*d*b_i)=d*rho_(M_b)(s*b_i),
```

and every residue modulo `M_b` has exactly `d` lifts.

### LRC implies the common-prime statement

Conversely assume unrestricted LRC, equivalently the positive-integer pivot-
certificate conjecture. If a positive injective tuple had every pivot fully
covered, the full-cover equivalence would say that every `Q_j` is empty, so no
pivot certificate exists. This contradicts LRC. Therefore the antecedent of
the common-prime implication is always false, and the implication holds
vacuously.

Thus, in the presence of the existing formal equivalences,

```text
SIMULTANEOUS-FULL-COVER-COMMON-PRIME
  iff unrestricted Lonely Runner.
```

This is an exact dependency classification, not a proof of either side. The
common-prime statement is not a genuinely narrower bridge. Its conclusion is
arithmetically stronger than needed on a hypothetical cover, but LRC removes
all such covers, making the universal propositions equivalent.

The repository directions were checked directly:

- `LonelyRunner/PivotBoundary.lean:454` gives fixed-instance witness existence
  iff pivot-certificate existence;
- `LonelyRunner/PivotBoundary.lean:479` defines the unrestricted positive-
  integer pivot-certificate proposition;
- `LonelyRunner/PivotBoundary.lean:491` gives
  `PositiveIntegerConjecture <-> PositiveIntegerPivotCertificateConjecture`;
  and
- `LonelyRunner/BHKRealReduction.lean:114` gives
  `Conjecture <-> PositiveIntegerConjecture`.

The `n=1` case causes no exception: `R_j` contains odd residues and there are
no owners, so simultaneous full cover is impossible.

## Structural progress versus equivalent target

The accepted local claims are genuinely narrower than LRC in the following
sense:

- coarse candidates force an `N`-divisibility pattern;
- singleton covers are completely classified by divisibility; and
- a hypothetical simultaneous cover must contain a genuinely multiowner
  pivot.

Each is an unconditional theorem about arbitrary tuples or hypothetical cover
systems and does not assert the existence of a certificate. They are useful
necessary constraints. Their complete implication chain stops at

```text
simultaneous full cover
  -> at least one multiowner pivot
  -> [missing cross-pivot selection]
  -> one prime dividing every normalized speed.
```

The last arrow is not narrower as presently stated: demanding a common prime
under all simultaneous covers is the equivalent target just audited. A future
route must formulate and prove a strictly intermediate property before the
final contradiction, rather than rename the common-prime assertion.

## Artifact boundary

This audit did not execute or inspect the contents of
`p70_falsification.py` or `p70_falsification.json`. It therefore does not
accept:

- the ten mandatory fixtures as a batch;
- the reported scaling and permutation regressions;
- the primitive scan for dimensions two through six and maximum speed twelve;
- the tuple counts or zero simultaneous-cover result; or
- any source/output-binding assertion reserved for artifact audit 153.

The two explicit negative examples and the all-but-one family above are
accepted as `proved-math` because their complete calculations are independently
reconstructed here. They are not promoted as attachment-derived computation.

## Proof-obligation ledger

| ID | Exact obligation | Status after audit | First open or false edge | Disposition |
| --- | --- | --- | --- | --- |
| P70-S1 | Coarse divisor-cover identity and mixed `N`-divisibility consequence | independently valid | One divisible owner blocks further coarse propagation | Accept as structural theorem |
| P70-S2 | Singleton-cover rigidity | independently valid | Applies only to singleton covers | Accept as structural theorem |
| P70-S3 | Simultaneous full covers force a multiowner pivot | independently valid | No theorem controls a multiowner cover | Accept as structural theorem |
| P70-R1 | Private point implies nontrivial owner/pivot gcd | false | `(1,2,3,5)` pivot two | Stop |
| P70-R2 | Full pivot implies a nonunit owner modulo its modulus | false | `(1,3,4,5,7,18)` pivot seven | Stop |
| P70-R3 | `n-1` full pivots imply a common prime | false in every `n>=2` | All-but-one primitive family | Stop |
| P70-F1 | Common-group pullback itself couples pivot equations | not established | Separate supported frequency subgroups have no supplied relation | Stop current argument |
| P70-O1 | Select one persistent prime from simultaneous multiowner covers | `open`, but equivalent-target endpoint | No valid cross-pivot selector | Do not promote as narrower bridge |
| P70-EQ | Simultaneous-full-cover common-prime statement | equivalent to unrestricted LRC | LRC makes antecedent impossible | Stop as independent route |
| P70-V1 | Replay recovered bounded evidence | pending audit 153 | Independent execution and source/output binding | Verification lane |

## Route recommendation and evidence boundary

Overall route disposition: **STOP** the common-prime route in its present form.

- Preserve and formalize the coarse divisor-cover, singleton-rigidity, and
  strict-growth lemmas if their declaration-level cost is modest; they are
  unrestricted reusable structure.
- Do not retry private-point gcd propagation, pivot-local nonunit support, or
  an `n-1`-pivot weakening; each has an exact counterexample.
- Do not allocate a new Pro cell to the full simultaneous-cover common-prime
  target merely under a different name; it is equivalent to LRC.
- Reopen only for a strictly narrower multiowner structural lemma with an
  independently stated implication and falsification suite.

Evidence labels after this audit:

- `proved-lean`: only the existing repository declarations and equivalences
  cited above.
- Recommended `proved-math`: full-cover equivalence, coarse divisor-cover
  theorem, private-point existence at exact scope, singleton-cover rigidity,
  strict-growth theorem with the non-uniqueness correction, common scaling,
  normalized Fourier pullback, both explicit negative examples, the
  all-but-one family, and the two logical implications establishing target
  equivalence.
- `computed finite evidence`: none accepted by this audit; audit 153 remains
  pending.
- `rejected`: private-point-to-gcd propagation, full-pivot nonunit necessity,
  and any common-prime theorem from only `n-1` full pivots.
- `open`: unrestricted LRC and any genuinely new multiowner coupling lemma.
