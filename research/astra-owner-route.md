# Astra owner route: zero-kernel domination obstruction

Source checkpoint: `ec30e17`. Research authorized in the current workflow on
2026-09-05. Owned evidence file: this file only. No shared state or Lean source
was edited by this worker, and no Lean build was run by this worker.

Status: **proved-math-response**, with exact finite checks below; independent
review and Lean implementation remain separate. The result is a uniform,
arithmetic sufficient condition for a **single lower-owner row** to be
uncovered. It neither proves maximum-covered-pivot redundancy nor resolves LRC.

## Exact setting and inherited evidence

Let `N>=3`, `p>0`, and let `C` be a finite labelled family with speeds
`0<d_i<p`. Put `M=N*p` and use exactly

```text
R = pivotCandidates N p = {0<=r<M : N does not divide r},
B_i = pivotBadResidues N p d_i
    = {r in R : min(r*d_i mod M, M-(r*d_i mod M)) < p},
Z_i = {r in R : r*d_i mod M = 0},   T_i = B_i \ Z_i,
A = |R| = (N-1)*p,   c=|C|.
```

Badness is strict; equality at distance `p` is safe. No owner labels, zero
products, nonunits, collisions, or reflection fixed points are discarded.
Injectivity is **not** required by the new lemmas. In the internal-cover
application positivity, injectivity, and maximum-covered-pivot status imply
the required strict inequality `d_i<p`; that application adds no extra
conclusion to the row theorem.

Relevant accepted inputs, distinguished from this new derivation:

- `LonelyRunner/Prompt100TwoOwnerCounts.lean:37` kernel-checks the exact
  normalized cardinality used below. `PivotCounts.lean:441` is its exact
  unnormalized predecessor. Neither previously proves a multiowner bound.
- `research/sol-pro/audits/response100-mathematical-audit-355.md` accepts the
  two-distinct-lower-owner noncover result for `N>=4` only at mathematical
  scope. Its `N=4` class argument is independent of this note.
- `docs/task366-owner-count-formalization-contract.md:86` freezes the accepted
  **not-yet-Lean** bound `(N+1)|B_i|<=3A` and its unique equality speed for
  `N>=5`. Its family consequence gives `N+1<3c` for internal complete covers.
  The new argument below rederives that bound, rather than assuming it.
- `docs/anchor-star-audit.md:88` already records gcd formulas for simultaneous
  zero targets. Zero-target arithmetic itself is not claimed as novel here.
- `research/sol-pro/audits/response95-mathematical-audit-321.md:25` accepts
  common `+/-1` overlap and records the failed direct change-of-modulus
  transport and the missing decreasing exchange invariant. This note uses no
  change of pivot modulus and no private-set matching assertion.
- Prompt104 remains on hold: density plus `c+o<=N-2` contradicts its
  cosingleton requirement `2(c-1)<=o`. This note does not reuse that contract.

## 1. A sharp interpolation between ordinary and zero-product capacity

For one owner write

```text
h=gcd(d,p), p=h*P, d=h*D, gcd(D,P)=1, k=gcd(D,N).
```

Then `h>0`, `1<=k<=D<P`, and `k|N`. The existing normalized theorem says

```text
|B| = h * [ k*(2*floor((P-1)/k)+1)
                  - (2*floor((P-1)/N)+1) ].
```

Also `|Z|=gcd(d,Np)-gcd(d,p)=h*(k-1)`: the first gcd counts all zero
products, while `r=N*s` accounts for exactly the second gcd excluded points.
Thus, writing the normalized count as `b`,

```text
b-(k-1) = 2*[k*floor((P-1)/k)-floor((P-1)/N)].
```

For an explicit nonnegative gap, write `N=k*l` and divide twice:

```text
P-1 = k*q+s,   0<=s<k,
q = l*Q+e,    0<=e<l.
```

Consequently `floor((P-1)/N)=Q` and

```text
b = 2*(N-1)*Q + 2*k*e + k-1,

2*(N-1)*P + (N-2)*(k-1) - N*b
  = 2*[(N-1)*s + N-k*(e+1)] >= 0.                 (1)
```

The right side vanishes exactly when `s=0` and `e=l-1`, equivalently
`(P-1) mod N = N-k`. This proves the new sharp bound

```text
N*|B| <= 2*A + (N-2)*|Z|,                         (2)
N*|T| <= 2*(A-|Z|),                               (3)
```

with equality exactly at that normalized residue condition. The calculation
itself holds already for `N>=2`; `N>=3` is retained for the family conclusions.
Only `k>0`, `k|N`, and `k<P` are needed for the normalized arithmetic lemma;
coprimality is needed for its adapter to the existing actual bad-set count.

There is also an elementary independent upper bound for zero capacity:

```text
A-(N+1)*|Z|
  = h*[(N-1)*(P-k-1)+2*(N-k)] >= 0.              (4)
```

Equality in (4) holds exactly when `k=N` and `P=N+1`. Combining (2) and (4)
gives `(N+1)|B|<=3A`, valid for `N>=3`. Equality forces both equalities because
`N-2>0`; then `k=N`, `P=N+1`, and `k<=D<P` force `D=N`. Conversely these
values give equality. Thus the Task366 equality classification follows:

```text
(N+1)|B|=3A iff (N+1)|p and d=N*(p/(N+1)).
```

This provides a short formalization route for the existing Task366 contract;
the stronger `N>=3` domain is new manuscript scope and not a silent edit of
its frozen declarations. The equality classification would fail at `N=2`:
for example `p=2,d=1` covers its entire two-point candidate row.

## 2. Multiowner obstruction from dominated zero kernels

Choose a labelled subset `E subset C` of size `q` such that every nonempty
`Z_i` is contained in some `Z_j` with `j in E`. Empty kernels need no
representative; `q=0` is allowed. This condition concerns exact zero-product
sets in this one row, not whole bad sets or selected private residues.

For `c>=2`, all `T_i` contain the two distinct candidates `1` and `M-1`:
their cyclic distances are `d_i`, which lie strictly between `0` and `p`.
Therefore

```text
|union T_i| <= sum |T_i| - 2*(c-1).
```

This is valid for labelled duplicates as well. Combining it with (3), and
putting `S_E=sum_(j in E)|Z_j|`, gives the genuine overlap-sensitive estimate

```text
N*|union B_i|
 <= N*|union Z_i| + 2*c*A - 2*sum_(i in C)|Z_i| - 2*N*(c-1)
 <= 2*c*A + (N-2)*S_E - 2*N*(c-1)
 <= [2*c + (N-2)*q/(N+1)]*A - 2*N*(c-1).         (5)
```

The second step uses both `|union Z_i|<=S_E` and `S_E<=sum_C|Z_i|`.
The bound preserves the overlap of zero kernels; replacing their union by
the sum over all owners would discard precisely the improvement.

**Uniform row theorem.** For every family above, if such an `E` exists and

```text
2*(N+1)*c + (N-2)*q <= N*(N+1),                  (6)
```

then `union B_i != R`. For `c>=2`, (5) is strictly below `N*A` by the common
two-point correction. For `c=0`, the union is empty and `A>0`; for `c=1`,
the individual bound `|B|<=3A/(N+1)<A` handles the case. No injectivity,
minimality, coveredness of other pivots, or witness-existence assumption is
used. Taking `E=C` recovers the old sparse threshold `3c<=N+1`, and shows
that injectivity is unnecessary for that particular noncover consequence.

A convenient weaker corollary is `2c+q<=N` implies noncover. The exact
condition (6) should be retained when possible. In particular every complete
lower-owner cover obeys

```text
2*(N+1)*c + (N-2)*q > N*(N+1).                  (7)
```

This is a structural restriction on a hypothetical internal cover as well,
without the impossible proper-subset expansion requirement.

### Finding E by divisibility

Let `g_i=gcd(d_i,Np)`. The unrestricted zero kernel consists of multiples of
`Np/g_i`; hence `g_i|g_j` implies `Z_i subset Z_j`, after retaining the same
candidate filter. Choose one labelled representative for each
divisibility-maximal *distinct* `g_i` among nonempty `Z_i`. This is a valid
`E`. Labels remain present in `C`; only a subset of dominators is selected.

Thus `q` can be the number of maximal elements of this finite divisor family.
It is not asserted to equal the minimum possible set-containment domination
number, since candidate filtering can create additional containments.

When the kernels form a divisibility chain, `q<=1`. The useful surviving
restriction is then roughly `c>N/2`, compared with the old `c>(N+1)/3`.
When `N` and `p` are primes with `p>N`, every lower owner has `h=1` and
`k in {1,N}`, so all nonempty kernels agree and `q<=1` automatically.
The result is not limited to prime pivots or small speeds.

## 3. Exact positive fixtures and failed strengthening

The main strict-improvement fixture is

```text
N=11, p=72, C=(22,33,55,66,70).
|R|=720,
|B_i|=(140,150,130,180,128), sum=728,
|Z_i|=(20,30,10,60,0),
nonempty g_i=(22,33,11,66), maximal family={66}, q=1.
```

Here old density gives `3c=15>N+1=12`, so it does not apply. Even exact
single-owner capacity plus the usual common `+/-1` correction gives only
`728-2*(5-1)=720`, which does not establish strict noncover. But (6) reads
`129<=132`, proving noncover uniformly by zero-kernel domination. Direct
enumeration gives 256 safe candidates, beginning `4,5,6,7,8,9,10,16`.
Moreover every integer denominator `2,...,11` divides one of
`(22,33,55,66,70,72)`, so the existing simple `t=1/q`, `q<=N` divisibility
shortcut does not already settle this fixture. It is a local row example;
it is not represented as an internal cover or an LRC counterexample.

Additional controls:

- `N=7,p=24,C=(7,10,14)`: `A=144`, bad counts `(42,40,36)`, zero counts
  `(6,0,12)`, and maximal gcd `{14}`. The new test is `53<=56`; 56 candidates
  are safe. Again no denominator `2,...,7` avoids all these speeds and `p`.
- `N=6,p=24,C=(6,7,12)`: all reduced `k=1`, so `q=0` and `2c=N`.
  There are 48 safe candidates. Raw speeds `6` and `12` are divisible by
  `N`; testing raw `gcd(d,N)` instead of `gcd(d/gcd(d,p),N)` is incorrect.
- `N=5,p=6,d=1,r=6`: cyclic distance is exactly 6, so this residue is safe.
  A mutation to weak badness would include it and violate the fixed contract.

**Refuted strengthening:** a single maximal zero kernel alone does not imply
noncover. The exact lower-owner family

```text
N=7,p=11,C=(1,4,5,6,7)
```

has `q=1`, `A=66`, five bad-set cardinalities all 18, zero cardinalities
`(0,0,0,0,6)`, and **zero safe candidates**. This is the known maximum-speed
pivot failure for tuple `(1,4,5,6,7,11)`, reproduced literally. Its condition
(6) fails (`85>56`). It is not an internal complete cover: the accepted
covered speeds are `{1,4,5,11}`, so owners `6,7` are external. Consequently it
refutes only dropping the cardinality bound, not Prompt95 or LRC.

## 4. Finite verification and compact reproduction

Standard-library integer checks completed on the current source checkpoint:

| Domain | Exact check | Outcome |
| --- | --- | --- |
| `3<=N<=24, 2<=p<=300, 1<=d<p` | (1)--(4), both equality characterizations, and recovered Task366 equality | 986,700 cases passed; 127,363 interpolation equalities |
| `3<=N<=12, 2<=p<=60, 1<=d<p` | Literal residue counts vs normalized bad and zero formulas | 17,700 cases passed |
| `3<=N<=10, 2<=p<=24, 1<=c<=min(4,p-1)`; all increasing owner tuples | Divisibility-maximal `q`, condition (6), literal union | 443,440 families; all 158,199 admitted families noncover |
| Three displayed fixtures and the covered negative control | Literal sets, zero union, safe count, denominator checks | Passed with values above |

These are finite audit checks, not uniform proof or kernel evidence. No
quarantined verifier or browser model was used; no generated cache or large
artifact is required. The following short independent reproducer checks the
main identities and indispensable fixtures:

```python
from math import gcd

for N in range(3, 25):
    for p in range(2, 301):
        for d in range(1, p):
            h = gcd(d, p)
            P, k = p // h, gcd(d // h, N)
            A, Z = (N - 1) * p, h * (k - 1)
            B = h * (k * (2 * ((P - 1) // k) + 1)
                     - (2 * ((P - 1) // N) + 1))
            gap = 2 * A + (N - 2) * Z - N * B
            assert gap >= 0
            assert (gap == 0) == ((P - 1) % N == N - k)
            assert (N + 1) * Z <= A
            assert ((N + 1) * Z == A) == (P == N + 1 and k == N)
            assert (N + 1) * B <= 3 * A
            assert ((N + 1) * B == 3 * A) == (
                p % (N + 1) == 0 and d == N * (p // (N + 1)))

for N, p, C, expected in [
    (11, 72, (22, 33, 55, 66, 70), 256),
    (7, 24, (7, 10, 14), 56),
    (6, 24, (6, 7, 12), 48),
    (7, 11, (1, 4, 5, 6, 7), 0),
]:
    M = N * p
    R = {r for r in range(M) if r % N}
    B = [{r for r in R if min(r*d % M, M-r*d % M) < p} for d in C]
    assert len(R - set().union(*B)) == expected
```

## 5. First formal obligations and the genuine remaining gap

A formalization-ready first lemma uses the existing definition directly:

```lean
theorem normalizedBadCount_zero_interpolation
    (N k P : Nat) (hN : 2 <= N) (hk : 0 < k)
    (hkN : k ∣ N) (hkP : k < P) :
    N * normalizedBadCount N k P <=
      2 * (N - 1) * P + (N - 2) * (k - 1)
```

Its equality companion has conclusion

```lean
N * normalizedBadCount N k P =
    2 * (N - 1) * P + (N - 2) * (k - 1) ↔
  (P - 1) % N = N - k
```

The displayed quotient decomposition proves both, including the needed
nonnegativity before natural subtraction. These signatures are a proposed
new contract, not existing declarations. A second elementary helper proves
`(N+1)*(k-1)<=(N-1)*P` with the equality classification from (4). Combining
them with the existing normalization yields the old frozen Task366 A
declarations without relying on any unformalized density premise.

The family layer additionally needs exact `Z_i` cardinality, divisibility
containment, the common-two-point finite-union inequality for `T_i`, and the
labelled subset sum inequality. They are finite arithmetic/set obligations;
the mathematical argument does not need a speculative matching lemma.

**First unresolved uniform mathematical gap:** hypothetical internal covers
whose cardinality and zero-kernel domination number violate (6) remain.
Neither internal coveredness nor maximum-covered-pivot status has yet been
shown to bound that domination number or force enough additional nonzero
overlap. For large `c` (in particular `2c>N`) even `q=0` cannot make (6) hold.
An eventual argument must control those nonzero targets or use a genuinely
proved change-of-pivot mechanism. The covered negative control above shows
why zero-kernel structure alone cannot be promoted to universal noncover.

This route makes a nonvacuous arithmetic slice available for formalization
and isolates a narrower obstruction; it leaves unrestricted LRC open.

## Formalization checkpoint, 2026-09-05

The scalar bound is now proved in `LonelyRunner/OwnerKernelBound.lean`.
`LonelyRunner/PivotZeroKernel.lean` proves the literal zero-set cardinality,
gcd-divisor containment, capacity, and common nonzero bad pair.
`LonelyRunner/KernelCoverCertificates.lean` proves the generic family argument,
including empty and singleton families. `LonelyRunner/OwnerKernelCover.lean`
instantiates it with actual pivot residues and supplies the closed real
circle-distance witness. The exact family theorem is
`exists_pivotCandidate_avoiding_ownerKernel_family`; its gcd wrapper and
`exists_ownerKernel_circleNorm_witness` use the same numerical condition (6).

The full integrated build passes (3,599 jobs), and the trust audit accepts all
332 reports using only the permitted standard axioms. These declarations
resolve the formal obligations above; they do not supply the missing uniform
dense-case premise. In particular, an example with fewer than `N-2` owners
does not control unlisted coordinates of a full `N`-runner instance.
