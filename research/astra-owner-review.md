# Independent review of the owner zero-kernel argument

Review task: `/root/owner_review`, 2026-09-05. Requested routing: Astra xhigh;
runtime model metadata is not independently exposed. Source HEAD:
`ec30e172d792e51ee9712a3f204336f7bee8724c`. Only this evidence file was edited.
The current workflow policy/state were read and
`python3 scripts/validate_workflow.py` passed. No Lean build, source edit,
shared-state write, external model session, or new agent was used.

**Disposition: ACCEPT the mathematics and the four compiled contracts.**
The single-row family theorem, equality classifications, and labelled-dominator
argument are sound at manuscript scope; the four compiled declarations have
the narrower scopes recorded separately below.
The normalized interpolation and its equality condition have the stronger
domain `P > 0`; that generalization does not extend to the zero-capacity bound.
The dense residual regime remains open. These conclusions do not prove LRC,
maximum-covered-pivot redundancy, or universal certificate existence.

Reviewed manuscript SHA-256:
`d1b1b9d775465d8bf6122eb9d26e9190734362af42d2422cd7b5eafe189d0946`
for `research/astra-owner-route.md`. The existing normalized-count source
`LonelyRunner/Prompt100TwoOwnerCounts.lean` has SHA-256
`ac24bb6cfcf524a08c0ceb2a728b2febf826c595d4aaa72eb7f10d2e5baa96dd`.
The final `OwnerKernelBound.lean` source was statically inspected after the
orchestrator reported its successful compilation and standard-only axiom
audit. Its SHA-256 was
`4a9e242429e601f07559a1482031d84f0cc5677a3c128a15481f4003d4f5333e`.
The two public declarations are `normalizedBadCount_ownerKernel_bound`, with
exactly the stronger `P>0` domain reviewed below, and
`pivotBadResidues_ownerKernel_bound`, with `N>=2`, `p>0`, `0<d<p`, and
conclusion

```text
N * card(pivotBadResidues N p d)
 <= 2*(N-1)*p + (N-2)*(gcd(d,N*p)-gcd(d,p)).
```

Its transport constructs the gcd quotients, proves their coprimality, applies
the existing strict bad-count normalization, proves `gcd(d,N*p)=h*k`, and
multiplies the normalized bound by `h`. This exact statement/transport is
accepted; it contains no cover or witness premise. Compilation and axiom
checks were reported by the orchestrator, not duplicated by this reviewer.
The zero-set cardinality adapter as a finite-set theorem, equality theorems,
zero-capacity theorem, and labelled family noncover criterion remain distinct
manuscript/formalization obligations; the two compiled declarations do not
silently establish all of them.

## Arithmetic and generalized normalized contract

Let `N >= 2`, `k > 0`, `k | N`, and **`P > 0`**. Write
`N = k*l`, `P-1 = k*q+s`, and `q=l*Q+e`, with `0<=s<k`, `0<=e<l`.
Since `l>=1`, the second quotient satisfies `Q<=q`. Therefore
`2*Q+1 <= k*(2*q+1)`, so the subtraction in the actual Nat definition of
`normalizedBadCount` is an ordinary nonnegative subtraction. Also

```text
P-1 = N*Q + k*e+s,        0 <= k*e+s < N,
b = 2*(N-1)*Q + 2*k*e + k-1,
2*(N-1)*P + (N-2)*(k-1) - N*b
  = 2*((N-1)*s + N-k*(e+1)).
```

Both terms inside the final parentheses are nonnegative. Since `N-1>0`,
the gap is zero exactly when `s=0` and `e=l-1`, equivalently
`(P-1)%N=N-k`. No step uses `k<P`, `D`, coprimality, or LRC. In particular,
the `q=0` cases remain valid. The precise stronger normalized inequality is

```lean
(N k P : Nat) (hN : 2 <= N) (hP : 0 < P)
(hk : 0 < k) (hkN : k ∣ N) :
N * normalizedBadCount N k P <=
  2 * (N-1) * P + (N-2) * (k-1)
```

The equality companion has the same hypotheses. Positivity of `P` matters:
at `N=2,k=2,P=0`, Nat-normalized count is 1, and the asserted inequality
would be `2<=0`.

For the actual lower-owner adapter, `h=gcd(d,p)>0`, `p=h*P`, `d=h*D`,
`gcd(D,P)=1`, and `0<d<p` give `1<=k=gcd(D,N)<=D<P`.
There are `gcd(d,Np)=h*k` unrestricted zero products. The excluded points
`r=N*s`, `0<=s<p`, contribute exactly `gcd(d,p)=h` zero products. Thus
`|Z|=h*(k-1)` without any unit or injectivity assumption. Combining this
with the existing exact bad-count formula gives

```text
N*|B| <= 2*A + (N-2)*|Z|,
N*|T| <= 2*(A-|Z|),       A=(N-1)*p, T=B\Z.
```

For the separate zero-capacity step, `k<P` really is required:

```text
(N-1)*P - (N+1)*(k-1)
  = (N-1)*(P-k-1) + 2*(N-k) >= 0.
```

Equality holds exactly at `k=N,P=N+1`. Dropping `k<P` here is false:
`N=3,k=3,P=1` gives `8>2`. For `N>=3`, combining the two bounds yields
`(N+1)|B|<=3A`; positivity of `N-2` makes equality force both individual
equalities. The lower-owner condition then forces `D=N`, hence precisely
`(N+1)|p` and `d=N*(p/(N+1))`. Conversely those values attain equality.
This independently derives the Task366 numerical assertion and its equality
classification; Task366 is not used as a premise. The extension to `N>=3`
is mathematically valid but should not silently replace its frozen contract.

## Labelled family argument and endpoint audit

Let `C` be the original finite label set and `E` a subset of those labels,
with every nonempty `Z_i` contained in some `Z_j`, `j in E`. Put
`c=|C|`, `q=|E|`, `S_E=sum_E |Z_j|`, and `S_C=sum_C |Z_i|`.
Then `union_C Z_i = union_E Z_j`, so `|union Z_i|<=S_E`, while
`S_E<=S_C` follows from the actual subset of labels. Duplicate numerical
speeds do not invalidate either inequality; labels must not be silently
quotiented during the finite sums.

For a nonempty lower-owner family, `p>=2`; both `1` and `Np-1` belong to
every `T_i` and are distinct. Their distances are the strictly positive
speeds `d_i<p`, so neither is a zero product. Removing these two common
points before taking the union proves, for `c>=1`,

```text
|union T_i| <= sum_C |T_i| - 2*(c-1).
```

For `c>=2`, multiplication by `N` and the individual interpolation give

```text
N*|union B_i|
 <= 2*c*A + N*|union Z_i| - 2*S_C - 2*N*(c-1)
 <= 2*c*A + (N-2)*S_E - 2*N*(c-1).
```

The second inequality is justified by the two separately directed bounds
`N*|union Z_i|<=N*S_E` and `-2*S_C<=-2*S_E`. No assumption that different
zero kernels are disjoint is present. Finally `(N+1)*S_E<=q*A` gives the
claimed sufficient condition

```text
2*(N+1)*c + (N-2)*q <= N*(N+1).
```

At equality in this condition, the strictly positive correction
`2*N*(c-1)` still prevents cover. Endpoint cases are as follows:

- `c=0`: the union is empty and `A>0`, including `p=1`.
- `c=1`: `3/(N+1)<1` for every `N>=3`, so the single bad set cannot cover.
- `c=2`: the correction is `2*N>0`; duplicate labels are allowed. This
  criterion does not claim every pair qualifies at `N=3` or `N=4`.
- An empty `E` is valid exactly when every zero kernel is empty. Choosing
  `E=C` gives precisely the sparse condition `3*c<=N+1`.

The divisibility construction of `E` is sound: for `g_i=gcd(d_i,Np)`, the
full zero kernel is the multiples of `Np/g_i`, and `g_i|g_j` implies
containment even after the common candidate filter. One representative for
each maximal distinct `g_i` among nonempty kernels suffices. This is an
upper bound on the optimal domination number, not an identification with it.

Strict badness is essential. At `N=5,p=6,d=1,r=6`, the candidate distance
equals 6, so it is safe. Replacing `<p` by `<=p` changes the contract. No
reflection fixed point, nonunit, or zero product was removed in this review.

## Independent exact checks

Fresh standard-library Python calculations used literal residues; they did
not import the manuscript's reproducer or a historical/quarantined verifier.

| Check domain | Result |
| --- | --- |
| `2<=N<=60`, every positive divisor `k` of `N`, `1<=P<=300` | 78,000 normalized triples; interpolation, nonnegative Nat subtraction, and equality iff all passed; 3,771 equalities |
| `3<=N<=8`, `1<=p<=18`, all ordered lower-speed tuples of lengths 0 through 3 | 152,190 labelled families; all 60,943 admitted families noncover, including 12,361 with duplicate speeds |
| Four indispensable row fixtures and the strict endpoint | All literal expected values reproduced |

The main strict-improvement fixture gave

```text
N=11, p=72, C=(22,33,55,66,70), A=720,
|B_i|=(140,150,130,180,128), |Z_i|=(20,30,10,60,0),
|T_i|=(120,120,120,120,128), E={the speed-66 label}, q=1,
|union B_i|=464, |union Z_i|=60, |union T_i|=412,
|(union Z_i) intersect (union T_i)|=8,
safe count=256, first eight=(4,5,6,7,8,9,10,16).
```

The criterion reads `129<=132`; ordinary exact owner counts plus the common
two-point correction give only `728-8=720`. Every denominator `2,...,11`
divides one of the displayed speeds or the pivot, so that simple escape test
does not settle this fixture. The additional fixtures reproduced 56 safe
candidates for `(7,24,(7,10,14))` and 48 for `(6,24,(6,7,12))`.

The indispensable negative control gave

```text
N=7, p=11, C=(1,4,5,6,7), A=66,
|B_i|=(18,18,18,18,18), |Z_i|=(0,0,0,0,6), q=1,
|union B_i|=66, |union Z_i|=6, |union T_i|=60,
safe count=0, criterion fails: 85>56.
```

Independent enumeration of every pivot for the full tuple
`(1,4,5,6,7,11)` found covered pivot speeds exactly `{1,4,5,11}`. Therefore
owners 6 and 7 are external. This refutes unrestricted noncover from `q=1`
alone, without refuting the theorem, Prompt95, or LRC.

## Residual gap and a bounded next mathematical test

The first unresolved issue is unchanged: the maximal-covered-pivot/internal
conditions have not been shown to constrain `c,q` enough to satisfy the
criterion, or to force enough additional nonzero overlap. For `2*c>N`, even
`q=0` cannot make the new numerical test hold. Replacing this missing step by
an assertion that a good row exists would be circular.

A nonzero-overlap tree provides a valid local certificate:

```text
|union B_i| <= |union Z_i| + sum |T_i|
                - sum_(ij in tree) |T_i intersect T_j|.
```

It is a specialization of the **existing** ordered-union machinery in
`LonelyRunner/ModularCertificates.lean:81`, not a new generic inequality.
For example, the dense fixture `N=6,p=12,C=(1,2,3,5)` has `q=0`, `A=60`,
bad counts `(20,20,18,20)`, and tree edges of weights
`(1,2):10`, `(2,3):6`, `(3,5):6`. This yields `78-22=56<60`, whereas the
common-two-point bound is 72 and the zero criterion fails `56>42`.
Literal enumeration gives 6 safe candidates. All denominators `2,...,6`
divide a listed speed or the pivot. This is useful finite mechanism evidence,
but an existing original-set two-parent certificate already covers it.

There is a stronger reason not to promote zero-separated trees as a new
route in the `q=1` regime. Let `j` dominate every zero kernel. Root any
overlap tree at `j`, process parents before children, and assign the existing
two-parent step for `i!=j` the parents `j` and its tree parent `t(i)`. Then

```text
B_i \ (B_j union B_t(i)) subset T_i \ T_t(i),
|B_j| = |Z_j| + |T_j|.
```

Consequently the original-set two-parent total is at most the split-tree
total. Thus **every `q=1` split-tree certificate is subsumed** by existing
full two-parent machinery; no exhaustive search is needed for this dominance.

The precise next falsification test is therefore in dense families with
`q>=2`: compare the best zero-separated tree bound against the best original
two-parent ordered bound, retaining labelled maximal-gcd dominators. Keep
the exact-zero-union bound and the weaker representative-sum bound separate.
For the latter, add dependency edges from each nonrepresentative's chosen
zero dominator to that label. Whenever this graph together with the rooted
tree edges is acyclic, the same two-parent dominance proof works against
`S_E+sum|T_i|-tree_weight`; representatives pay their own zero-kernel sizes.
Incompatible dependency orders can potentially separate this version.
Additional savings from `|union Z_i|<S_E` are a separate possible mechanism
in the exact-union version and must not be conflated with order incompatibility.
Determine whether actual modular sets force a domination-compatible tree of
equally good weight, or find a literal fixture where they do not and existing
full two-parent certificates fail. This tests an arithmetic ordering property
rather than reintroducing private-owner matching or restating witness existence.
If no separation survives, return to existing certificate machinery and seek
a proved arithmetic rule supplying its order/parents from internal coveredness.
Neither separation nor a uniform supply rule is asserted here.

## Additional review: removing affine premises with one fewer coordinate

At the orchestrator's request, the following corollary of the independently
reviewed affine lemma was scrutinized. Let `p` be an odd prime, `I` a labelled
set of size `p-2`, `a_i` arbitrary nonzero elements of `F_p`, and `v_i`
arbitrary elements. Then there exist nonzero `r,s` such that
`s*v_i+r*a_i` avoids both `0` and `-1` for every `i`.

**ACCEPT at manuscript scope, conditional only on the reviewed affine lemma.**
Let `A=product a_i`, which is nonzero, and append one new labelled coordinate
`a_*=-A^(-1), v_*=0`. There are now `p-1` nonzero slopes and their product
is `-1`. If an original `v_i` is nonzero, the augmented vector contains both
a zero and a nonzero entry, so every hypothesis of the reviewed lemma holds;
discard its dummy-coordinate conclusion. If all original `v_i` vanish,
exclude at most `p-2` forbidden values `r=-a_i^(-1)` from the `p-1` nonzero
values of `r` and take `s=1`. Products `r*a_i` cannot be zero. Repeated slopes
and repeated forbidden values only make the latter count easier.

Direct independent enumeration for `p=3,5` checked all 8,006 slope/vector
pairs and found witnesses. This finite check supports the separately given
uniform argument; it is not its proof. No integer-speed grid translation,
general-prime supply theorem, or LRC consequence has been established.

After the manuscript review, the orchestrator reported compilation and
standard-only axiom checks for both `affine_avoidance_of_slope_product` and
`affine_avoidance_card_sub_two`. I independently inspected their final source
statements and proof adapters in `LonelyRunner/AffineAvoidance.lean` at
SHA-256 `9fb78dc2b12694f096ac423c04835f3f961e0769dc6d5ae6180033d6004f22c0`.
The first retains prime/odd `p`, exactly `p-1` labelled coordinates, nonzero
slopes of product `-1`, and both zero/nonzero offset witnesses. The second
retains prime/odd `p` and exactly `p-2` coordinates with nonzero slopes, and
has no offset or product premise. Both conclusions require **both** `r` and
`s` nonzero and avoid **both** `0` and `-1` at every coordinate. The second
uses `Option I` for the dummy label and the correct finite-unit count in its
all-zero branch. Their source contracts and adapters match the reviewed
mathematics without weakened quantifiers or added existence assumptions.

Thus the four reported kernel-checked declarations are the two named owner
inequalities and these two affine theorems. This review performed independent
source-level semantic matching, not a duplicate build or independent axiom
run. The labelled noncover criterion and its equality/zero-set support layers
remain manuscript results unless separately formalized. No declaration of
unrestricted `LonelyRunner.Conjecture` or its negation has been supplied.
