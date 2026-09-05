# Independent Astra pass 4 review

**Accept both reviewed artifacts at their exact stated scopes. No mathematical
or theorem-contract correction is required.** The all-modulus supply obstruction
is manuscript mathematics. The explicit dense-family distance theorem is
kernel checked. These are different speed families, and neither resolves the
canonical unrestricted conjecture.

Reviewed 2026-09-05 under the recorded Astra Extra High review assignment.
Separate runtime model metadata is unavailable. The assignment's source
checkpoint was `231dc52`; the checkout read during review was
`5f6c37ecf8c38fd0677f52aa8b88dfe7b4bcc391`, while the parent separately
published its prior verified checkpoint. The scoped source hashes below remained
unchanged. Current configuration, workflow, policy and state were read;
`python3 scripts/validate_workflow.py` passed. This worker wrote only this
report and did not alter source, shared state, Git, or publication state.

## 1. Exact normalization scope

The manuscript correctly audits the union of these existing sufficient
contracts and their described normalization transports:

- A: all `N-1` original speeds have positive bases nonzero modulo `N`,
  `(N-1)*a_i<M`, the speed/base congruences, and at least one transformed
  speed nonzero modulo `N`.
- B: one actual original speed is divisible by `M` and not divisible by `N`;
  the other `N-2` bases meet A's small nonzero-base requirements.
- Coarse C: one actual distinguished speed and its positive base `A` are
  divisible by `N`, while `0<a_i<A`, `N` does not divide any ordinary base,
  and `N*A<=(N-2)*M`, `N*a_i*A<=(A-a_i)*M`.

All three contracts retain their congruences modulo the same external `M`.
For C, the ordinary size condition implies the **strict** consequence
`N*a_i<M`: its right side is strictly below `A*M`, because `a_i,M>0`,
and positive `A` cancels. This does not impose the same bound on the
distinguished base, which may be much larger. The audit preserves this
distinction and does not accidentally restrict that exceptional coordinate.

A normalization consists of any positive `M`, a common unit residue `c`
modulo `M`, an arbitrary common integer lift `b`, independent signs, and
coordinate permutations. Adding independent multiples of `N*M` to the
transformed speeds preserves their grid phases and modulo-`N` offsets, and
can make their Nat representatives positive.

The treatment of multipliers divisible by `N` is correct. A and B force
`N` not to divide `b` through their respective nonzero-offset conditions.
C does not: for prime `N` not dividing `M`, CRT permits a lift divisible
by `N`, making **all transformed offsets zero**. The C obstruction below
places no nonzero-modulo-`N` restriction on the multiplier. Unit status is
used where required to preserve `M|w` for a proposed original pivot; the
stronger five-coordinate C obstruction itself even allows nonunit multipliers.

## 2. Independent all-modulus obstruction proof

Let `w` be the nonnegative absolute residue of the multiplier and put
`x=w/M` in `[0,1/2]`. An ordinary positive base below `M/2` must equal
the corresponding absolute residue, independently of the sign choice.
The case `w=0`, including the modulus-one case, makes positive ordinary
bases impossible. Thus the nontrivial arguments may assume `x>0`.

The manuscript's three small-arc facts are valid with their exact endpoint
hypotheses:

- For `epsilon<=1/6`, small distances for speeds 2 and 3 imply
  `x<epsilon/3`. The possible interval near `1/2` is excluded because
  the speed-3 distance there exceeds `1/4`.
- For `epsilon<=1/7`, small distances for speeds 3 and 4 imply
  `x<epsilon/4`. In the alternative interval near `1/3`, both distances
  from `4*x` to its neighboring integers exceed `epsilon`; the strict
  interval inequalities still give a contradiction at `epsilon=1/7`.
- For `epsilon<=1/7`, small distances for speeds 2 and 4 imply
  `x<epsilon/4` or `1/2-x<epsilon/4`.

For A, apply the first fact to `(2,3,N)` with
`epsilon=1/(N-1)`. Then `N*x<7/18<1/2`, so the speed-`N` base must
equal `N*w` and is divisible by `N`, contradicting A. This proof is
uniform in the external modulus and sign/multiplier choices.

For B, positive small bases imply `M>N-1`. A pivot 2 or 3 cannot then
be divisible by `M`. A pivot `N` remains divisible by `N` after any
allowed transformation and fails B's nondivisibility condition. Every
other pivot leaves `(2,3,N)` among the ordinary coordinates. These cases
exhaust the actual-pivot choices, without assuming a maximal pivot.

For coarse C, the manuscript proves the stronger fact that, for every odd
integer `N>=7`, positive modulus `M` and **every integer multiplier**, at
least two coordinates of `(2,3,4,N,2N)` fail

```text
0<rho_M(c*v), N*rho_M(c*v)<M, N does not divide rho_M(c*v).
```

The proof covers every possible exceptional label:

1. If 2 is exceptional, ordinary 3 and 4 force `x<1/(4*N)`; the ordinary
   speed-`N` base is `N*w` and fails nondivisibility.
2. If 3 is exceptional, ordinary 2 and 4 force that same small interval
   or an interval near `1/2`. The first fails as above. In the second,
   oddness gives `||N*x||>1/4>1/N`, contradicting the ordinary size bound.
3. If `N` is exceptional, ordinary 2 and 3 force `x<1/(3*N)`. The
   ordinary `2N` phase lies strictly below `2/3` and cannot be in the
   small arc near 1. Its base must therefore be `2N*w`, again forbidden.
4. If 4, `2N`, or any coordinate outside the core is exceptional, ordinary
   `(2,3,N)` give the same divisibility contradiction directly.

No condition has been imposed on the exceptional base, so the proof is
stronger than needed for C. In particular it remains valid when the common
lift is divisible by `N` and every transformed offset vanishes. The result
excludes exactly the stated A/B/coarse-C normalization union; it says nothing
about the pair-dependent exact-size or simultaneous multiple-zero contracts.

## 3. Four-coordinate negative control and complete escaping tuple

The smaller proposed core `(2,3,N,2N)` does **not** suffice to obstruct C.
The `N=11,M=336,b=c=121,A=242` control is accepted. The multiplier is a
unit modulo 336 and divisible by 11. With distinguished original speed 2,
ordinary bases `(27,13,26)` for `(3,11,22)` and signs `(+,-,-)`, every
coarse C inequality holds. The positive transformed speeds
`(242,363,2365,1034)` have exactly these residues, and all offsets vanish
modulo 11. This possibility must not be excluded by requiring a unit
multiplier modulo the runner denominator.

The complete original control

```text
(2,3,11,22,339,675,1011,1347,1683,2019)
```

has exactly ten distinct positive speeds and is primitive. The six appended
speeds are `3+j*336`, so their transformed ordinary bases are all 27.
There are consequently exactly nine ordinary labels plus the actual
distinguished label, as required by C for eleven runners including the
stationary one. This is not a four-coordinate application at the wrong count.

For `r0=s=1`, shifted rounding gives `r=31,beta=5,n=677` on denominator
3696. Transport back to the original speeds gives

```text
121*677 mod 3696 = 605,
605/3696 = 55/336.
```

The original distances are `(110,165,67,134,165,165,165,165,165,165)/336`.
Their minimum is exactly `67/336>1/11`. The second `N=17` smaller-core
control is also arithmetically consistent; the complete first control is
already sufficient to reject the proposed smaller-core obstruction.

The actual escaping family is

```text
V_N=(2,3,...,N-3,(N-2)*(N-1),N,2N),
```

for odd prime `N>=7`. Its initial interval has `N-4` entries, followed
by three more, so the moving-coordinate count is exactly `N-1`. The
entries are positive and distinct: the product row exceeds `2N`, and
the initial interval ends below `N`. Speeds 2 and 3 imply primitivity.
Every denominator 2 through `N` divides an entry, and the five-coordinate
obstruction core occurs as a subset. Thus all A/B/coarse-C normalizations
are excluded for this **complete** tuple.

Its ordinary LRC witnesses were independently checked:

- At prime `N=7` and every prime `N>=13`, `t=1/(N+2)` gives minimum
  distance exactly `2/(N+2)>1/N`. The product row is 12 modulo `N+2`;
  its distance is 3 at `N=7`, and at least 3 for `N>=13`.
- At the remaining prime `N=11`, the given `t=1/14` gives distances
  `(2,3,4,5,6,7,6,6,3,6)/14`, with minimum `1/7>1/11`.

The rejected normalization union therefore misses instances with elementary
other-grid witnesses. These examples are not LRC counterexamples, and their
explicit times do not establish a supply theorem for arbitrary residual tuples.

## 4. Exact compiled dense-family contract

`LonelyRunner/AffineDenseFamily.lean` concerns the **different** family

```text
M=N^2*(N-1)+1,
H=1+M*(1+N*z),
U_(N,z)=(2,3,N,4H,5H,...,(N-1)H),
t=(N^3-2)/(N*M).
```

Its public `affine_dense_family_witness` quantifies over all natural
`N,z` with only `N>=7`. There is no primality, oddness, bounded-lift,
supplied-affine-pair, or external-normalization hypothesis. The conclusion
contains the closed `1/N` norm inequalities at that exact time for speeds
2, 3, `N`, and **every natural `j` with `4<=j<N`** at speed `j*H`.
Hence it covers even and composite counts, arbitrary nonnegative lifts,
and all `3+(N-4)=N-1` displayed moving coordinates relative to stationary
speed zero. It is not a theorem about every runner choice or every speed tuple.

The source uses direct phase decompositions rather than invoking a prime-field
theorem. Let `n=N^3-2`, `b=N^2-3`; then `n=M+b` and
`(N-1)*b<M`. For fixed speeds 2 and 3, the numerator is `a*M+a*b`.
For speed `N`, the phase is an integer plus `N*b/(N*M)`, with
`M<=N*b<=(N-1)*M`. For a lifted speed, the exact identity is

```text
t*j*H = k + ((N-j)*M+j*b)/(N*M),
k=j*(N^2+z*n)-1  in the integers.
```

Thus all lift dependence is retained in the integer phase. With `4<=j<N`,
the remaining numerator lies in the closed band `[M,(N-1)*M]`. The
private real fraction-band lemma correctly derives the circle norm from
that band. The proof handles natural subtractions under explicit bounds
from `N>=7`, and it does not require prime arithmetic at any step.

The construction's positivity, distinctness, primitivity and count are
mathematically verified: `H>N`, multiplication by positive `H` preserves
distinct indices, and speeds 2 and 3 have gcd 1. The public Lean declaration
exports the coordinatewise distance inequalities, **not separate theorems
asserting those structural properties or a canonical `LonelyAt` wrapper**.
That is faithful to its requested interface. It must not be confused with
a Lean proof of the manuscript's escaping-family obstruction for `V_N`.

## 5. Verification and evidence status

Independent checks completed:

| Check | Result |
| --- | --- |
| Direct source compilation: `lake env lean LonelyRunner/AffineDenseFamily.lean` | Passed, exit 0 |
| Separate imported `#check` and `#print axioms` for `affine_dense_family_witness` | Exact all-natural `N,z` contract confirmed; only `propext`, `Classical.choice`, `Quot.sound` |
| Full fenced manuscript reproducer, independently executed | All checks passed: 1,520,955 unit normalizations, stated bad-count histogram, 27,610 compressed cores, 22 complete escaping prime tuples, and the full eleven-runner control |
| Additional core check over every odd `7<=N<=35`, `1<=M<=120`, every residue multiplier `0<=c<M` | 108,900 cases, including nonunits and zero multipliers; all had at least two bad core coordinates |
| Histogram in the additional all-multiplier check | `{2:2660, 3:9048, 4:21122, 5:76070}` |
| Additional dense-family check for every integer `7<=N<=80` and `z` in `{0,1,2,17,10^12}` | 370 instances; exact integer-phase identities, closed inequalities, count, distinctness and gcd passed |
| Complete `N=11` control arithmetic checked independently | `r=31,beta=5,n=677`, transported numerator 605, all zero offsets, and all ten original distances verified |

All computations used exact integers or fractions and produced no large
artifacts. They corroborate the independent proofs; the all-modulus result
does not depend on the finite bounds in these checks.

The parent separately ran a full integrated source build and trust audit.
This reviewer read the final log lines in
`/tmp/lrc-astra-pass4-build.log` and `/tmp/lrc-astra-pass4-trust.log`:
the build completed successfully with 3,605 jobs, and the trust audit accepted
344 reports, including the new theorem with only the permitted axioms.
These are parent-run integration checks; the reviewer ran only the targeted
source compilation and imported probe. Publication of the earlier checkpoint
was not part of this review.

## 6. Frozen source hashes and disposition

SHA-256 fingerprints read independently before and after the checks:

```text
7caa2b660942cacb92382bc9cd661b83647af85f212b71589d162e6734bb22c1  research/astra-grid-supply-audit.md
20c27df2612953b67ed110694dbec27935cbfa41adbbe6dc0ee9cf6f7bda7dcf  LonelyRunner/AffineDenseFamily.lean
9badca0a324c37a2f9a57c860ab83f9da6e7b8aac922f52e4985352ec57bee54  LonelyRunner/AffineGridFullSize.lean
ea7f4c3058f486dd29c3624d914251d37b9f85d24cca2a7152e0e796a9dc46a8  LonelyRunner/AffineGrid.lean
7bcec521f38f065e03c2f112e4af91f20b3e05b0cedcbc1e6f8f49cca350d5c4  LonelyRunner/AffineGridVanishing.lean
0be8553d88fed2346895abcaeb961d0fb2967ee8db356feff8877ceb8b49b079  LonelyRunner/AffineGridArithmetic.lean
8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af  lean-toolchain
887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218  lake-manifest.json
```

Pinned Lean is `leanprover/lean4:v4.32.1`; pinned mathlib revision is
`520045ab14e26149ee970e2e617ca04b09bde5d6`.

The dense-family norm theorem is accepted as a kernel proof. The all-modulus
A/B/coarse-C exclusion, complete escaping tuples, and smaller-core controls
are accepted manuscript mathematics, not new Lean declarations. No concrete
source defect, omitted coordinate, boundary error, or hidden multiplier
restriction was found. The remaining global gap is a mechanism beyond the
audited normalization union that applies to arbitrary original speed tuples.
The simultaneous multiple-zero and pair-dependent exact-size contracts were
not investigated here. No unrestricted proof or disproof of
`LonelyRunner.Conjecture` follows.
