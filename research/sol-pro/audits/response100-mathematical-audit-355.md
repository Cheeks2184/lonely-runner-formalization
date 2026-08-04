# Prompt100 mathematical and computational audit

Tasks: `FORM-P100-MATHEMATICAL-AUDIT-355`,
`VER-P100-INDEPENDENT-REPLAY-356`

Recovery commit: `48bbfcbddde2d4d8e5b9c279eb991aa613a1ebdc`

Supervising authority: `/root`

## Sol High disposition

The following exact-scope results are accepted:

- `proved-math-qualified`: `TWO-LOWER-OWNER-NONCOVER` for every integer
  `N >= 4`, `p >= 1`, and distinct integers `0 < b < c < p`.
- `proved-math-qualified`: the restriction of Prompt95 to tuples with at most
  three covered pivots. This conclusion is explicitly vacuous: in that range
  no internal complete cover exists, so no removable owner is constructed.
- `refuted-exact`: only the proposed extension of the two-owner arithmetic
  theorem from `N >= 4` to `N >= 3`.
- `computed finite evidence`, independently replayed: both response-supplied
  bounded scans, at their exact declared domains only.

Unrestricted Prompt95, the positive-integer pivot-certificate conjecture, the
positive-integer conjecture, and unrestricted Lonely Runner remain `open`.
Neither the proof nor the computation establishes any of those statements.

## Exact theorem audited

For natural numbers `N,p,d`, put `M=N*p` and define

```text
rho_M(x) = min(x mod M, M - (x mod M)),
R(N,p) = {r : 0 <= r < N*p and N does not divide r},
B_d(N,p) = {r in R(N,p) : rho_(N*p)(r*d) < p}.
```

Badness is strict. Equality `rho_(N*p)(r*d)=p` is safe. The accepted theorem
is exactly

```text
for all integers N>=4, p>=1, and 0<b<c<p,
  B_b(N,p) union B_c(N,p) != R(N,p).
```

Owner labels remain distinct even when product residues or bad sets collide.
The theorem is symmetric in `b,c`; the order merely selects a canonical
presentation of two distinct positive owners.

## Mathematical proof audit

### Exact one-owner count

For `0<d<p`, let

```text
g = gcd(d,N*p),
h = gcd(d,p),
s = floor((p-1)/N).
```

Counting the strict target residues through every multiplication fiber and
then removing exactly the excluded `N`-multiple candidates gives

```text
|B_d(N,p)| =
  g * (2*floor((p-1)/g) + 1)
  - h * (2*floor(s/h) + 1).
```

This retains zero products, nonunits, collisions, and both cyclic sides. The
strict target is represented by the signed integers from `-(p-1)` through
`p-1`; the endpoints at distance `p` are not counted.

Writing

```text
p=h*P, d=h*D, gcd(D,P)=1, k=gcd(D,N)
```

gives `g=h*k` and the normalized count used in the proof. The floor identities
in the response were checked at the exact natural-number boundaries.

### The range `N>=5`

The normalized count proves

```text
|B_d(N,p)| <= 3*(N-1)*p/(N+1).
```

For `N>=6`, the sum of the two owner bounds is strictly below
`|R(N,p)|=(N-1)*p`. For `N=5`, equality in the single-owner bound can occur
only for the unique speed `d=5*p/6` when `6` divides `p`. Two distinct owners
therefore cannot both attain equality, so their total capacity is again
strictly below `|R(5,p)|`.

### The range `N=4`

After removing the proved common scale `gcd(p,b,c)`, the response counts every
bad set in the three nonzero residue classes modulo four. The normalized owner
types are the exact patterns `Z`, `N-`, `C`, `D`, `F`, and `G`.

The class-capacity argument is sound: a negative side-class offset cannot
cover that class; a zero total offset still cannot cover it because `r=1` is
a common bad point. The remaining capacity possibilities force one owner to
have type `G`.

The type-`G` owner is then eliminated in three exhaustive cases for the other
owner: odd, congruent to two modulo four, or divisible by four. The first two
cases use exact lift classes and retain one nonmultiplicative candidate. The
last uses the small-multiplier lemma on the divided coefficients.

There is one minor presentation repair. In section 4.7, Case 3, the response
applies a lemma stated for ordered multipliers `0<x<y<p/4` directly to
`d/4,e/4`, after proving only that they are distinct. Apply the lemma instead
to

```text
min(d/4,e/4), max(d/4,e/4),
```

and use symmetry to recover the two original conclusions. This repairs the
order without adding a hypothesis or changing the theorem.

### Recovered Markdown defects

The immutable response has operator corruption in several displayed formulas
and tables: subtraction or equality symbols became Markdown headings or
separator rows. It also contains a truncated fragment in the later overlap
discussion. The exact theorem and formulas above are normalized from the
surviving prose and mutually consistent derivations. The raw response is not
edited. The accepted proof uses the complete main proof through section 4.8;
it does not depend on the corrupted optional overlap fragment.

## Exact `N=3` refutation

The extension to `N>=3` is false. Literal enumeration gives two controls:

```text
(N,p,b,c)=(3,3,1,2)
R  = {1,2,4,5,7,8}
B1 = {1,2,7,8}
B2 = {1,4,5,8}
B1 union B2 = R
```

and

```text
(N,p,b,c)=(3,5,2,3)
R  = {1,2,4,5,7,8,10,11,13,14}
B2 = {1,2,7,8,13,14}
B3 = {1,4,5,10,11,14}
B2 union B3 = R.
```

This refutes only that arithmetic extension. Neither tuple is an LRC
counterexample.

## Prompt95 consequence

Let `N=n+1`, let `j*` be the maximum-speed covered pivot, and let an internal
owner set use only covered labels other than `j*`. Positivity, injectivity, and
maximality make every internal owner speed strictly between zero and the pivot
speed.

- A singleton cannot cover a positive pivot row for any `N>=3`; the audited
  one-owner count is strictly smaller than `|R|`.
- Two owners cannot cover when `N>=4`, by the accepted theorem.
- When `N=3`, there are only `n=2` labels, hence at most one nonpivot owner.

If `|coveredPivots|<=3` and an internal complete cover existed, finite
cardinality minimization would produce an inclusion-minimal internal complete
cover with at most two owners. The preceding cases contradict that. Thus no
internal complete cover exists in this range, and the coverwise redundancy
statement holds vacuously. This proves no case with four or more covered
pivots and supplies no redundant-owner selector.

## Independent replay preflight

Before either full scan, the replay independently checked:

- the exact success fixture `(4,3,1,2)`, including uncovered `{3,9}`;
- rejection of the deliberately altered uncovered set `{3}`;
- equality-safe boundary points at distance exactly `p`;
- a repeated-product-residue collision modulo `20`;
- the two `N=3` out-of-domain controls;
- malformed inputs `N=3`, `p=0`, `b=0`, `b>=c`, and `c>=p`; and
- all response-embedded permutation and scale controls.

The programs abort before scanning if an embedded fixture fails. Both fresh
runs report `fixtures_passed=true` and 1,920 permutation-and-scale checks.

## Independent full replay

The exact tracked sources were copied to a disposable WSL directory and built
with the documented warning policy:

```bash
gcc -O3 -std=c11 -Wall -Wextra -Werror \
  '-DSOURCE_SHA256="8eb381637769cf3981163c7c2be1438c696fc21300b7aba239095cdd113c6f35"' \
  falsifier_a_literal.c -o falsifier_a_literal
./falsifier_a_literal > fresh_a.json

gcc -O3 -std=c11 -Wall -Wextra -Werror \
  '-DSOURCE_SHA256="8d302770222002a4ab9ef17f64b18762dc836ecbe84102d5a3fe8f6f703376ab"' \
  falsifier_b_fibers.c -o falsifier_b_fibers
./falsifier_b_fibers > fresh_b.json
```

Actual environment: Ubuntu GCC `15.2.0-16ubuntu1`, x86-64.

### Source and supplied-result hashes

| File | SHA-256 |
| --- | --- |
| `falsifier_a_literal.c` | `8eb381637769cf3981163c7c2be1438c696fc21300b7aba239095cdd113c6f35` |
| `falsifier_a_result.json` | `514a267c3959bd49a3288201c281f2b976c7dedb5118c7d63548c7f7ec02a739` |
| `falsifier_b_fibers.c` | `8d302770222002a4ab9ef17f64b18762dc836ecbe84102d5a3fe8f6f703376ab` |
| `falsifier_b_result.json` | `76c08f87964ee3a89d13957faed86a29c05cb66b298266c69771173246d8ba8d` |
| `manifest.json` | `b58b80d1a991c44ea001853e07d2421116cff59d56eaed9dbb7357bd9970a01e` |

The manifest binds these values exactly. Both fresh outputs print the exact
source hash compiled into their binaries; no stale or unbound result was
detected.

### Completed domains

Implementation A completed `N=4..18`, `p=1..160`:

```text
10,048,800 owner pairs
190,800 owner rows
225,271,200 literal residue-predicate checks
common digest 0e430dd2e7f1b766
first failure null
exit status 0
```

Implementation B completed `N=4..24`, `p=1..240`:

```text
47,780,880 owner pairs
602,280 owner rows
192,930,360 fiber-target visits
112,661,448 soluble targets
192,284,478 solution visits
10,048,800 common-domain owner pairs
225,271,200 common-domain pointwise checks
0 pointwise mismatches
all-domain digest 55a9a8f24ef40789
common digest 0e430dd2e7f1b766
first failure null
exit status 0
```

Closed-form recounting independently reproduced the pair, owner-row, and
pointwise-check totals.

### Fresh hashes and cross-version comparison

| Fresh GCC 15.2 output | SHA-256 |
| --- | --- |
| A binary | `a2e2b7590613fc655f2346121756cfd7f3d32643b5cea0c7e95740059d4a53e1` |
| B binary | `badfbadd063c5873f1b661f481fd1de1d7c798dd6ca2ba17761c56fd362785c6` |
| A JSON | `f1dcf20517c172095ca5eaebee89129c01e2cf1aed2c6d3b4b2a25e7932eff98` |
| B JSON | `3856aa71f19c154de118e50c4d440fefdaaa3bb835d406b8ce867f97ddaa95b5` |

The fresh JSON files are not byte-identical to the supplied GCC 14.2 results
because their `compiler` field is `gcc 15.2.0`. Object comparison after
removing only that field is exact for both implementations. The original
GCC 14.2 binary hashes are therefore not expected to reproduce under GCC
15.2 and are not promoted as cross-compiler invariants.

An independently written direct literal checker scanned `N=4..8`, `p=1..30`,
all `0<b<c<p`: 20,300 cases and 119,722 candidate tests, with no failure. Its
deterministic FNV-1a64 digest was `4e419bc20372b58d`.

## Additional disposable audit scans

A separate literal C++ checker used during the mathematical audit had source
SHA-256
`2d17c5eb0a95c67bab0992e09004db4aba690fc165eb45ecf98bd78113551546`.
Its fixtures passed, and it completed `N=4..12`, `p<=100` together with
`N=25..60`, `p<=80`: 4,413,060 owner pairs and 40,615,388 literal residue
trials, with no failure. The checker and a hash-bound report were not retained,
so this run is audit support only and is not promoted as a computational
certificate.

An initially frozen larger scan over `N=4..12`, `p<=300` and `N=25..60`,
`p<=120` exceeded 120 seconds and emitted no report. Its exact command was not
retained. It is `rejected operational output`, not partial finite evidence;
no prefix or unstored outcome is used.

## Evidence boundary

The two retained, independently replayed scans are accepted only as
`computed finite evidence` over their declared finite domains. They are not
premises of the mathematical proof and provide no unbounded inference. The
mathematical theorem is accepted separately as `proved-math-qualified`; it is
not yet a Lean theorem. Formalization, independent kernel checking, and the
remaining `|coveredPivots|>=4` Prompt95 cases are still open.
