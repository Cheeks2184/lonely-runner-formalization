# Independent Astra review: zero-kernel family and affine-grid contracts

Source base: `ed94a47061aa03167fa430d20368dc4684235932`. Review performed
2026-09-05 under the authorized `research` / `in_progress` workflow. Requested
routing is Astra Extra High; separate runtime model metadata is not exposed.
This worker owns this report only, has not edited Lean sources or shared state,
and has not run a full build or cache cleanup.

Status: **review complete** for the frozen sources below. Accepted compiled
contracts and accepted manuscript-only extensions are distinguished explicitly.
This is an auxiliary-results review, not a canonical completion review.

The current workflow files were read and
`python3 scripts/validate_workflow.py` passed. That validator is structural
evidence, not mathematical certification.

## 1. Zero-kernel and family verdict

**Accepted at the exact compiled declaration scope.** The three new modules
faithfully implement the reviewed lower-owner argument in
`research/astra-owner-route.md`. No mathematical correction is required in the
reviewed Lean source. These are conditional certificates for one pivot row;
they are not unrestricted Lonely Runner theorems.

Write `M=N*p`,

```text
R = {r : 0 <= r < M and N does not divide r},
B_i = {r in R : min(r*d_i mod M, M-(r*d_i mod M)) < p},
Z_i = {r in R : r*d_i mod M = 0},
A = |R| = (N-1)*p, c=|C|, q=|E|.
```

The boundary is strict in `B_i`; equality at cyclic distance `p` remains safe.
Labels are arbitrary and the speed map need not be injective. Both repeated
speed values and repeated bad/zero sets retain their original labels in `c`.

### Exact zero arithmetic

- `card_range_mul_mod_eq_zero` counts `gcd(M,d)` zero products in a complete
  period for `M>0`, including `d=0`.
- `card_pivotZeroResidues` states exactly
  `|Z|=gcd(d,N*p)-gcd(d,p)` under `N>0,p>0`, with no positivity or lower-speed
  requirement on `d`. The removed residues are precisely `r=N*s`, `0<=s<p`,
  for which the zero condition becomes `s*d=0 mod p`. Their cardinality is
  `gcd(d,p)`. This also establishes that the natural subtraction is legitimate.
  For `N=1` the whole candidate set is empty, as the formula requires.
- `pivotZeroResidues_subset_pivotBadResidues` uses `p>0` to put the zero kernel
  inside the **strict** bad set.
- `pivotZeroResidues_subset_of_gcd_dvd` correctly uses
  `gcd(d,N*p) | gcd(e,N*p)` to infer `Z_d subset Z_e`. Both kernels are filtered
  by the same `R`. Its lack of positivity premises is sound: if `N*p=0`, the
  candidate row is empty. This is a sufficient containment criterion, not an
  assertion that the criterion is necessary after candidate filtering.
- `normalizedZeroKernel_capacity` assumes `N>=2`, `0<k<=N`, and `k<P`; it
  proves `(N+1)(k-1)<=(N-1)P`. Divisibility `k|N` is unnecessary here. The gap
  is `(N-1)(P-k-1)+2(N-k)`, so every term has the required sign.
- `pivotZeroResidues_capacity` normalizes by `h=gcd(d,p)`, obtaining
  `p=hP`, `d=hD`, `k=gcd(D,N)`, and `|Z|=h(k-1)`. Its premises `N>=2` and
  `0<d<p` ensure `1<=k<=D<P`, and it proves `(N+1)|Z|<=A`. The strict
  lower-speed premise has not been dropped or replaced by an assumption on
  the raw `gcd(d,N)`.
- `one_and_last_mem_pivotBadResidues_sdiff_pivotZeroResidues` proves that the
  two **distinct** residues `1,M-1` lie in `B_d \ Z_d`, for `N>=3`, `p>0`,
  and `0<d<p`. Their product residues are `d` and `M-d`; they are nonzero and
  have cyclic distance at most `d<p`. Both are candidates because `N` divides
  neither `1` nor `M-1`.

### Generic family certificate, including empty and singleton families

`exists_candidate_avoiding_kernel_family` has the reviewed numerical premise

```text
2*(N+1)*c + (N-2)*q <= N*(N+1).
```

It also retains `N>=3`, `A=|R|>0`, `E subset C`, `B_i subset R`,
`Z_i subset B_i`, the pointwise interpolation
`N|B_i|<=2A+(N-2)|Z_i|`, the capacity `(N+1)|Z_i|<=A`, and domination of
every **nonempty** `Z_i` by some `Z_j` with `j in E`. Two distinct common
points are required in every `B_i \ Z_i`. Domination selects a subset of
the labelled family, so `sum_E |Z_i| <= sum_C |Z_i|` is valid without any
injectivity assumption.

For `c>=2`, set `T_i=B_i \ Z_i` and `S_E=sum_E |Z_i|`. The proof retains

```text
N*|union B_i| + 2*N*(c-1) <= 2*c*A + (N-2)*S_E,
(N+1)*S_E <= q*A.
```

Scaling and applying the numerical premise leaves a strictly positive
`2*N*(c-1)` correction, hence `|union B_i|<A`, including numerical equality
in the displayed hypothesis. There is no hidden conversion of a weak union
bound into strict noncover.

For `c=0`, `R` is nonempty and avoidance is vacuous. For `c=1`, interpolation
and capacity imply `(N+1)|B_i|<=3A`; `N+1>=4` and `A>0` give `|B_i|<A`.
The common-pair correction is not used to claim strictness when `c-1=0`.
The unified interface retains the common-pair hypotheses even in these cases;
that harmless extra interface requirement is discharged by the literal adapter.

### Literal adapters and quantifier boundary

All three public declarations in `OwnerKernelCover.lean` are accepted:

1. `exists_pivotCandidate_avoiding_ownerKernel_family` supplies a candidate
   outside every bad set indexed by `C` under literal zero-kernel domination.
2. `exists_pivotCandidate_avoiding_ownerKernel_family_of_gcd_dvd` replaces
   domination by the sufficient gcd-divisibility condition.
3. `exists_ownerKernel_circleNorm_witness` supplies `r in R` and time
   `t=r/(N*p)` with `circleNorm(t*p)>=1/N` and
   `circleNorm(t*d_i)>=1/N` for every `i in C`.

The third declaration preserves the closed boundary and explicitly controls
the pivot itself, using the already formalized `PivotResidues` bridge. It
controls **exactly the listed family plus the pivot**. It does not assert that
`C` contains all other runners, nor that `|C|=N-2`, nor that arbitrary speeds
admit this certificate. For example the `N=11`, five-owner fixture controls
six moving coordinates at threshold `1/11`; it leaves four moving coordinates
of a full eleven-runner instance unspecified.

The manuscript's equality classifications for the scalar capacity/interpolation
are not exported by these new files and must not be reported as newly compiled
declarations. Likewise, choosing representatives among divisibility-maximal
gcd values is a valid mathematical construction; the adapter accepts an explicit
`E` and domination proof rather than constructing that representative set.

## 2. Independent zero-family verification

An independent `lake env lean --stdin` import of `LonelyRunner.OwnerKernelCover`
and `#print axioms` for the following ten declarations exited successfully:

```text
card_range_mul_mod_eq_zero
card_pivotZeroResidues
pivotZeroResidues_subset_of_gcd_dvd
pivotZeroResidues_capacity
one_and_last_mem_pivotBadResidues_sdiff_pivotZeroResidues
exists_candidate_avoiding_kernel_family_two_or_more
exists_candidate_avoiding_kernel_family
exists_pivotCandidate_avoiding_ownerKernel_family
exists_pivotCandidate_avoiding_ownerKernel_family_of_gcd_dvd
exists_ownerKernel_circleNorm_witness
```

Every result contained only `propext`, `Classical.choice`, and `Quot.sound`.
`#check LonelyRunner.Conjecture` also succeeded, confirming that the canonical
statement remains a distinct proposition in the imported environment. This
worker's probe is an independent imported-declaration check, not a fresh full
source build. The orchestrator separately reported a completed 3,599-job
integrated source build and 332 passing trust reports; that is attributed
orchestrator evidence, not a build run by this reviewer.

Independent exact Python checks completed without generated artifacts:

| Domain | Check | Result |
| --- | --- | --- |
| `1<=N<=9, 1<=p<=18, 0<=d<=p+1` | Literal zero count versus gcd difference | 1,863 triples passed |
| Same `N,p`, all `d,e` in `0..p+1` satisfying gcd divisibility | Literal kernel containment | 15,517 pairs passed |
| `3<=N<=9, 1<=p<=18, 1<=d<p` | Literal capacity, interpolation, and common pair | All passed |
| `3<=N<=8, 1<=p<=10, 0<=c<=3`, all ordered tuples with entries `1..p-1` | Labelled families including empty, singleton, and duplicate labels | 14,190 families; all 6,010 admitted families noncover |

For the family check, `q` was calculated as the number of distinct maximal
`gcd(d,N*p)` values under divisibility among owners with nonempty zero kernels;
one original label represents each maximum. Literal unions were independently
enumerated, not estimated from the formula under test.

All indispensable fixtures were reproduced:

| `N,p,C` | Bad counts | Zero counts | Safe candidates |
| --- | --- | --- | --- |
| `11,72,(22,33,55,66,70)` | `140,150,130,180,128` | `20,30,10,60,0` | 256 |
| `7,24,(7,10,14)` | `42,40,36` | `6,0,12` | 56 |
| `6,24,(6,7,12)` | `36,40,24` | `0,0,0` | 48 |
| `7,11,(1,4,5,6,7)` | `18,18,18,18,18` | `0,0,0,0,6` | 0 |

The first has `q=1` and `129<=132`; the last has `q=1` but `85>56`.
Thus a single maximal zero kernel does not by itself imply row noncover.
At `N=5,p=6,d=1,r=6`, the residue distance is exactly `p`; the candidate
is safe, as the strict badness contract requires.

## 3. Affine-grid manuscript verdict

**Accepted as manuscript mathematics at the stated restricted scope**, including
the later explicit-family extension to odd composite runner counts. The small
wording correction requested during review has been incorporated: the
normalization obstruction now takes the nonnegative absolute residue of the
multiplier, rather than an ambiguously signed least-absolute representative.
Positive representatives below `M/4` themselves force `M>0` and a nonzero
absolute residue. No other mathematical correction was required.

The independent review concerns the derivations and contracts. It makes no
literature novelty judgment and does not independently certify the manuscript's
comparison with the cited external paper.

### Exact rounding bridge

Let `N>=2`, `M>0`, integer speeds `u_i`, positive bases `a_i`, congruences
`u_i=a_i mod M`, and `(N-1)*a_i<M`. For `0<=s<N`, `1<=r0<N`, set

```text
r = ceil(M*r0/N), beta=N*r-M*r0,
n0=s*M+N*r, n=n0 mod (N*M),
h_i=(s*u_i+r0*a_i) mod N.
```

If every `h_i` lies in `1..N-2`, then `0<=beta<=N-1`,
`0<=a_i*beta<M`, and the exact least residue is
`n*u_i mod (N*M)=h_i*M+a_i*beta`. It lies in
`[M,(N-1)*M)`, proving the closed circle-distance bound `1/N` at
`n/(N*M)`. Congruence of the speed to the base is used with the factor
`N*r`, so it supplies a multiple of the **whole** modulus `N*M`.
The numerator is `s*M+N*r`, not `s*M+r`. Negative integer lifts are harmless
in this congruence argument. This scalar bridge uses neither primality nor
cardinality; the affine theorems supply the band premise separately.

### Product-free theorem A

The accepted contract has odd prime `N`, exactly `N-1` labels, positive bases
nonzero modulo `N`, the preceding size/congruence hypotheses, and at least one
speed nonzero modulo `N`. Its conclusion is a closed grid witness for all
`N-1` speeds. Product, distinctness, and external-prime assumptions are absent.

The three proof branches are valid and materially different:

1. When all speeds are nonzero modulo `N`, `n=M` directly gives `t=1/N`.
   It may attain the upper closed endpoint and need not satisfy the stronger
   two-value affine-avoidance condition.
2. For mixed zero/nonzero offsets and surjective slopes, the `N-1` slopes
   enumerate the field units. Their product is `-1`; the compiled affine
   product theorem supplies nonzero `r0,s`.
3. For nonsurjective slopes, choose a missing nonzero slope `x`, use
   `r0=-1/x`, and set `s=0`. The affine values then avoid `0,-1` regardless
   of the offsets. This branch explains the product-free strengthening but
   **does not** establish an everywhere-nonzero scale.

Consequently the product-free mixed-offset intermediate field contract may
assert `r0!=0`, but must permit `s=0`. Nor can it drop the mixed-offset premise
merely because theorem A has a direct-grid branch. The exact control
`N=3`, `a=(1,2)`, `v=(1,2)` has no field pair avoiding `0,-1` in both
coordinates, although `t=1/3` is a valid closed witness. This failed stronger
field test was identified and excluded during review; it does not refute the
manuscript, which already uses the correct branch split.

### Actual-pivot theorem B and transport

The accepted theorem B uses exactly `N-2` remaining labels **plus an actual
distinguished speed** `w`, where `M|w` and `N` does not divide `w`. The bases
obey the same positive, nonzero-slope, small-base and congruence conditions.
Here the compiled `affine_avoidance_card_sub_two` yields `s!=0` as well as
`r0!=0`, with no offset or slope-product restriction. Writing `w=c*M`,
the pivot phase is `s*w/N+c*r`. Its residue is nonzero modulo the prime
`N`, so its circle distance is at least `1/N`. Thus all `N-1` original
moving coordinates are controlled, with the correct runner denominator.

For positive `w=c*M`, reducing `n0` modulo `N*M` gives an ordinary pivot
candidate numerator `c*n<N*w`, because `c*n=s*w mod N` is nonzero.
The distinguished speed need not be maximal. The proof does not treat its
algebraic dummy row as an original runner. Without the distinguished speed,
an `N-2` result at `1/N` is weaker than the canonical `1/(N-1)` bound.
The control `(1,2,3)` on denominator 65 has maximum minimum distance
`16/65<1/4`; its only `1/4` times modulo one are `1/4,3/4`.

The signed-coordinate transport is sound by circle-norm invariance under
negation. The unit-multiplier transport is also sound: a unit modulo `M`
has a lift `b` nonzero modulo the prime `N`, automatically if `N|M`, and
by CRT if `N` does not divide `M`. Applying the theorem to signed `b*u_i`
and multiplying the resulting rational time by `b` returns a witness for
the original speeds. This remains a conditional transport and constructs no
small-base normalization for an arbitrary tuple.

### Necessary exclusions and uniform normalization obstruction

The all-zero offset exclusion in theorem A cannot simply be removed.
For `N=5,M=17`, bases `(1,2,3,4)` and speeds `(35,70,105,140)` meet its other
hypotheses. On the `1/85` grid their best minimum distance is `15/85`,
strictly below `1/5`; their ordinary witness `1/175` still exists. The
manuscript's exact 17-entry reduced-grid table was independently reproduced.
This is a fixed-grid obstruction, not a disproof of LRC. A primitive integer
tuple automatically has at least one speed nonzero modulo `N`.

The all-modulus obstruction for `N=5`, `(2,3,4,5)` is accepted, including
arbitrary independent signs and every common unit multiplier. Reflect the
multiplier's phase to `x in [0,1/2]`. The strict small-residue conditions for
speeds 2 and 3 give
`x in [0,1/12) union (3/8,5/12)`; the speed-4 condition removes the second
interval and gives `x<1/16`. The speed-5 condition then gives `x<1/20`.
For an integer absolute multiplier residue `w=M*x`, the small positive
speed-5 base must equal `5*w`, contradicting nondivisibility by 5.
The zero value of `w` is incompatible with positive bases. In fact this
argument needs no unit hypothesis on the multiplier.

Thus increasing the external modulus or allowing signs cannot repair this
normalization scheme. The tuple is primitive, every denominator 2 through 5
divides one of its speeds, and it still has the exact witness `t=1/7`, with
distances `(2/7,3/7,3/7,2/7)`. The related `(1,2,3,5)` obstruction and its
witness `1/4` are also accepted. For either tuple an actual-pivot application
would need a divisor `M` of an original speed with `M>4*max a>=4`; the only
possible divisor is 5, which makes the distinguished speed divisible by 5
and violates theorem B. A unit multiplier does not enlarge the set of
possible divisors `M`.

### Dense positive family and the odd-composite extension

For odd prime `N>=5`, use

```text
M=N*(N-2)+2, b=(N-3)^2/2, c>b with N not dividing c, p=c*M,
a_i=i for 1<=i<=N-2,
u_i=i for i<=N-4,
u_(N-3)=N-3+b*M, u_(N-2)=M+N-2=N*(N-1).
```

All `N-1` moving speeds are distinct, positive and primitive; all owners
are below the actual pivot. The small-base margin is exactly `N`, and every
denominator 2 through `N` divides one of the speeds. The owner count `N-2`
violates the zero-kernel numerical sufficient condition even with `q=0`.
This establishes a valid comparison of two sufficient mechanisms; it does
not establish failure of every existing certificate or every pivot.

For `N>=7`, the explicit pair `r0=1,s=(N-1)/2,r=N-1` gives ordinary affine
values `i/2` and exceptional values `-6,-2` modulo `N`. The parent correctly
observed that this proof works for **every odd `N>=7`**: 2 is invertible,
`1<=i<=N-4` excludes the ordinary forbidden values, and neither 0 nor -1
is congruent to -6 or -2. The pivot residue is `-c mod N`, nonzero by
hypothesis. No primality is used in this explicit-family argument. Choose
`c=N*(b+1)+1` for an unconditional admissible value; the prime-only convenient
choice `c=b+N` fails, for example, at `N=9`. The separate `N=5` pair
`r0=s=1,r=4` has affine values `(2,3,3)` and is accepted.

Theorems A and B themselves remain prime-count statements. This composite
extension applies only to the displayed family and explicit times.

## 4. Independent affine checks and compiled-helper boundary

All arithmetic checks used exact integers or rational numbers, without new
artifacts or generated caches:

| Check | Independent outcome |
| --- | --- |
| All mixed-offset field data for `N=3,5`, `N-1` labels, nonzero slopes | 94,224 cases admitted an affine pair with nonzero `r0` and possibly zero `s` |
| Scalar bridge for `N=3,5,7`, `1<=M<=80`, all allowed bases, lifts `u=a+k*M` with `-2<=k<=2`, all field representatives | 143,790 admitted cases satisfied the exact residue identity and closed band, including negative lifts and zero parameters |
| Dense prime family, nine primes 5 through 31 and several admissible `c` choices | 24 complete speed-family instances passed |
| Explicit odd family, every odd `7<=N<=101`, selected `c=b+1,b+2,N*(b+1)+1` excluding multiples of `N` | 142 complete speed-family instances passed, including composite `N` |
| Author's entire final fenced Python reproducer, executed independently from the manuscript | Passed: 390,072 theorem A cases, 32,012 theorem B cases, nine family fixtures, both negative controls, and 304,191 unit multipliers for each obstruction tuple |

The three literal maximal-pivot examples were independently enumerated:

| `N,p,owners` | Candidate count | Bad counts | Zero counts | Union / safe count |
| --- | --- | --- | --- | --- |
| `5,51,(1,36,20)` | 204 | `80,78,84` | `0,0,4` | `162 / 42` |
| `7,333,(1,2,3,300,42)` | 1998 | `570,570,570,570,558` | `0,0,0,0,18` | `1604 / 394` |
| `5,34,(1,18,20)` | 136 | `54,52,56` | `0,0,8` | `112 / 24` |

The corresponding grid numerators and distances in the manuscript are correct.
These checks corroborate the uniform arguments; they do not prove their
unrestricted mathematical claims or create kernel evidence for manuscript-only
parts.

### Compiled scalar helper

`LonelyRunner/AffineGridArithmetic.lean` is independently accepted. Its public
`circleNorm_ge_of_affine_grid_band` has natural-number parameters and assumes
`N>=2`, `M>0`, `u=a mod M`, `N*r=M*r0+beta`, `beta<=N-1`,
`(N-1)*a<M`, and `1<=(s*u+r0*a)%N<=N-2`. It concludes the closed norm bound
at `(s/N+r/M)*u`.

The helper legitimately needs no primality, cardinality, positive-base,
or upper bounds on `s,r0`: its explicit hypotheses suffice. It decomposes
`u=M*(u/M)+a`, then the phase as an integer plus
`h/N+a*beta/(N*M)`, and invokes the closed integer-band lemma. It exports
the norm consequence, not the full integer-speed residue identity or a
bounded grid numerator. The signed integer extension in the manuscript is
still a separate formal obligation. It does not construct an affine pair or
prove that the band hypotheses are universally obtainable.

An independent import / `#print axioms` probe for
`circleNorm_ge_of_affine_grid_band` passed with only `propext`,
`Classical.choice`, and `Quot.sound`.

### Compiled actual-pivot theorem

`LonelyRunner/AffineGrid.lean` is independently accepted at its complete Nat
interface. `affine_grid_pivot_witness` matches the manuscript's proposed
high-level target: odd prime `N`, `|I|=N-2`, `M>0`, positive natural bases,
`N` not dividing any base, `u_i=a_i mod M`, `(N-1)*a_i<M`, and
`N` not dividing `c*M`. It concludes natural `s,r`, `0<s<N`, and the closed
`1/N` circle-distance inequalities at the same time `s/N+r/M` for both
the actual distinguished speed `c*M` and every `u_i`.

The proof obtains both field parameters from the already compiled `N-2`
affine theorem, converts their values to natural representatives, constructs
the rounding error, proves the exact residue band, and applies the arithmetic
helper. Primality is used correctly to pass from `N` dividing neither `s`
nor `c*M` to nondivisibility of their product. The private pivot helper
removes the integer phase `r*c`. The unused positivity proof argument is
harmless: nondivisibility of a natural base already excludes zero.
No extra offset, product, injectivity, maximal-pivot, external-primality, or
supplied-witness hypothesis has entered the declaration.

The two public support declarations are also accepted:

- `exists_affine_grid_rounding` needs only `N>0` to construct natural
  `r,beta` with `N*r=M*r0+beta` and `beta<=N-1`.
- `nat_mod_band_of_zmod_avoidance` converts avoidance of `0,-1` in `ZMod N`
  into `1<=x%N<=N-2` for `N>=2`; it needs no field or primality assumption.

An independent import / `#print axioms` / `#check` probe passed for all three
public declarations. The rounding lemma uses `[propext, Quot.sound]`; the
other two use exactly `[propext, Classical.choice, Quot.sound]`. Their author
separately reported successful direct Lean compilation and targeted module
build. The previously cited 3,599-job integrated build predates these two
grid modules and must not be counted as their full-root integration evidence.
The orchestrator owns any later full integration build and trust checkpoint.

Theorem A's product-free full-size implementation, the general signed/integer
extensions, an exported bounded-numerator/pivot-candidate wrapper for theorem B,
and the uniform explicit dense family remain **manuscript-only** here. The
compiled theorem B already proves the full real witness conclusion under its
stated Nat hypotheses; a bounded-grid wrapper is a representation convenience,
not an unresolved mathematical premise of that conclusion. The manuscript's
initial blanket "not yet Lean formalized" status and target label should be
updated to reflect this newer accepted Nat theorem B checkpoint.

## 5. Frozen source fingerprints

SHA-256 values independently read for the accepted zero-family source and its
immediate reviewed arithmetic inputs:

```text
6487d679e2f8d84657827f01f1c98e232c997c62cb48dad5ac9c22db897df3b1  LonelyRunner/PivotZeroKernel.lean
0298105bda5d7af5beb7bdc1cab32880e170979ab5b611dcb706b9409777685a  LonelyRunner/KernelCoverCertificates.lean
bf4c025bcdcc178f4e9c94884314635e3d26697fe105a9a9a6a55ca1aa60f139  LonelyRunner/OwnerKernelCover.lean
4a9e242429e601f07559a1482031d84f0cc5677a3c128a15481f4003d4f5333e  LonelyRunner/OwnerKernelBound.lean
9fb78dc2b12694f096ac423c04835f3f961e0769dc6d5ae6180033d6004f22c0  LonelyRunner/AffineAvoidance.lean
09586c73becd90c49966eed06eac8700acf91a3ce68327403a6a557ffed3eb95  LonelyRunner/AffineGridArithmetic.lean
ea7f4c3058f486dd29c3624d914251d37b9f85d24cca2a7152e0e796a9dc46a8  LonelyRunner/AffineGrid.lean
cbe464269186e6704849ee16fd965db02856e0e86d5616b4d45bc05ad38a91cc  research/astra-owner-route.md
c18054e376db537a44b9ec3015404d5d8f3b4bc1fbd7104ca0084e521f407c44  research/astra-affine-grid.md
8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af  lean-toolchain
887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218  lake-manifest.json
```

Pinned toolchain: `leanprover/lean4:v4.32.1`. Pinned mathlib revision:
`520045ab14e26149ee970e2e617ca04b09bde5d6`.

## 6. Global boundary

The canonical declaration quantifies over every `n>=2`, every injective
real-valued speed map on `Fin n`, and every chosen runner, with a closed
`1/n` threshold. The new row certificates prove neither that all moving
coordinates can be included in an admitted lower-owner family nor that a
hypothetical internal cover has sufficiently small cardinality and domination
number. Dense covers violating the numerical condition remain unresolved;
for `2c>N`, even `q=0` cannot satisfy it. No change-of-pivot mechanism is
supplied by these files. There is no new proof or disproof of
`LonelyRunner.Conjecture` here. The grid results cover additional restricted
families, but the uniform normalization obstruction prevents treating them as
a supply theorem for arbitrary residual tuples. The manuscript's fixed-grid
negative examples and failed normalization classes remain ordinary LRC
instances with witnesses, not counterexamples to the canonical conjecture.

Final reviewer checks: workflow structural validation and `git diff --check`
passed again. All seven reviewed Lean source hashes were reread and remained
unchanged. The owner-route manuscript changed only by the appended formalization
checkpoint, which was reviewed; its final hash is recorded above. This worker
made no edits outside this report.
