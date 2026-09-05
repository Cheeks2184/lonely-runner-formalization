# Independent Astra pass 3 review

Base: `5c24b7719ef1d399a32363791f3038283747fc97`. Reviewed 2026-09-05 under
the authorized research workflow. Requested routing: Astra Extra High;
independent runtime model metadata is unavailable. This worker owns this
report only. Pass 2, Lean sources, and shared workflow state were not edited;
no full build, cache cleanup, new agent, or browser-model session was run.
The configuration, project workflow, policy and state were reread, and
`python3 scripts/validate_workflow.py` passed.

**Verdict: accepted at the exact scopes below.** The full-size theorem and
general arithmetic helper are compiled declarations. The shifted-rounding,
multiple-zero, normalization-exclusion and explicit-family results are
accepted manuscript mathematics. They do not establish unrestricted LRC.

## 1. Compiled product-free full-size theorem

`LonelyRunner/AffineGridFullSize.lean` matches the previously accepted theorem A.

`affine_avoidance_allow_zero_scale` assumes odd prime `N`, exactly `N-1`
labels, nonzero field slopes, at least one zero offset, and at least one
nonzero offset. It concludes `r!=0` and avoidance of both `0` and `-1` in
every affine coordinate `s*v_i+r*a_i`. It intentionally does **not** assert
`s!=0` and has no slope-product hypothesis.

The source proof correctly splits the slope map into units. Surjectivity plus
equal cardinalities gives a bijection and unit product `-1`, allowing the
existing product theorem. Otherwise a missing unit `x` gives `r=-x^-1,s=0`.
Neither labels nor slopes have silently become injective in the second branch.
Both mixed-offset hypotheses remain explicit in the public field interface.

`affine_grid_full_size_witness` assumes odd prime `N`, exactly `N-1` labels,
natural bases and speeds, `M>0`, positive bases, `N` not dividing any base,
`u_i=a_i mod M`, `(N-1)*a_i<M`, and **at least one original speed not
divisible by `N`**. It concludes natural `s,r` with `s<N` and, for every
original label,

```text
circleNorm((s/N+r/M)*u_i) >= 1/N.
```

All `N-1` original moving coordinates are present. There is no omitted pivot,
dummy runner, weakened threshold, slope-product premise, nonzero-scale
premise, external-primality premise, or hidden supplied-witness assumption.
The all-nonzero-offset branch uses `s=1,r=0`, which legitimately reaches
the closed boundary. The mixed branch uses the new field theorem, the existing
rounding construction, and the preserved arithmetic helper.

The exported time is on the `N*M` rational grid, but the declaration does not
export a reduced numerator `0<=n<N*M`. Such reduction is a separate convenient
wrapper, not a missing premise of its real witness conclusion. Original speeds
are natural here; the manuscript's general signed/integer transport is not
part of this declaration. The unused explicit base-positivity proof argument
is harmless because nondivisibility of a natural base already excludes zero.

Two exact controls confirm the branch distinctions:

- At `N=5`, slopes `(1,1,1,1)` and offsets `(0,1,2,3)` admit avoidance only
  with `s=0`: every nonzero scale gives four distinct values but only three
  field values avoid `0,-1`. Bases all 1, `M=6`, and original speeds
  `(25,1,7,13)` realize these offsets and have the witness `1/3`.
- For all-zero offsets, the earlier `(35,70,105,140)` example at `N=5,M=17`
  still forbids a `1/85` grid witness at `1/5`. The retained nonzero-offset
  premise is essential for the full-size fixed-grid claim.

An independent import / `#check` / `#print axioms` probe passed for both
new public declarations. Both use only `propext`, `Classical.choice`, and
`Quot.sound`.

## 2. General combined-band arithmetic and compatibility refactor

The final `AffineGridArithmetic.lean` contains one phase proof in
`circleNorm_ge_of_affine_grid_residue_band` and a compatibility wrapper for
the earlier `circleNorm_ge_of_affine_grid_band`. The duplicate legacy proof
has been removed. The earlier public signature was compared directly with
the source at `5c24b77`, ignoring whitespace, and is unchanged.

The accepted new contract uses natural parameters and assumes

```text
N>=2, M>0, u=a mod M, a<M, N*r=M*r0+beta,
M <= ((s*u+r0*a)%N)*M+a*beta <= (N-1)*M.
```

It concludes the closed circle-distance bound at `(s/N+r/M)*u`. It does
not assume `beta<=N-1`, nonzero slopes, positive bases, prime moduli,
label cardinalities, or nonzero field values. In particular the residue
`h=(s*u+r0*a)%N` may be zero and the correction may supply the entire
lower bound.

The exact phase identity is

```text
u=M*(u/M)+a,
H=s*u+r0*a, h=H%N, k=H/N+(u/M)*r,
(s/N+r/M)*u = k + (h*M+a*beta)/(N*M).
```

Here `a<M` makes the chosen natural base the actual remainder; it is used,
not an accidental extra assumption. The closed combined band puts the last
fraction in `[1/N,1-1/N]`. Both endpoints and the `N=2` antipodal case are
handled by the existing closed integer-band lemma.

The compatibility wrapper derives `a<M`, `a*beta<M`, and the combined band
from its former hypotheses. Its upper estimate is actually at most
`(N-1)*M-1`, so it does not misuse strictness or natural subtraction.

Independent imported-declaration and axiom probes passed for the new generic
theorem and the original wrapper, using only the three permitted standard
axioms. The author separately reported targeted builds of the arithmetic
module, `AffineGrid`, and `AffineGridFullSize` after the refactor. No full
root integration build is claimed by this reviewer.

## 3. One vanishing slope: exact full-coordinate proof

The accepted manuscript theorem has odd prime `N`, one distinguished original
integer speed `U`, and exactly `N-2` ordinary original integer speeds `u_i`.
Positive integer bases `A,a_i` and positive `M` obey

```text
N|A, N|U, U=A mod M,
0<a_i<A, N does not divide a_i, u_i=a_i mod M,
(N-2)*M >= N*A,
(A-a_i)*M >= N*A*a_i  for every ordinary label.
```

No nonzero-offset or external-prime assumption is needed. The finite-field
`N-2` theorem supplies representatives `1<=r0,s<=N-1` with ordinary affine
values `h_i=(s*u_i+r0*a_i)%N` in `1..N-2`. Define

```text
r=ceil(M*r0/N+M/(N*A)),
beta=N*r-M*r0,
n0=s*M+N*r, n=n0 mod (N*M).
```

The independent derivation starts from the actual ceiling inequalities,
not from assumed desired phase margins:

```text
M/A <= beta < M/A+N,
M <= A*beta < M+N*A <= (N-1)*M,
0 <= a_i*beta < a_i*M/A+N*a_i <= M.
```

The second displayed size hypothesis is exactly what proves the last weak
inequality after multiplying by positive `A`. Even equality in either size
hypothesis leaves a **strict** upper phase bound, because the ceiling error
is strictly below the next integer. No lower or upper endpoint is discarded
from the final closed LRC criterion.

For any integer congruent pair, regardless of the sign of the original speed,

```text
n*u = M*(s*u+r0*a)+a*beta mod (N*M).
```

Ordinary least residues are `h_i*M+a_i*beta` and lie in
`[M,(N-1)*M)`. The distinguished field value is zero because both `U`
and `A` are divisible by `N`; its least residue is `A*beta`, in the
same interval. Consequently **all `N-1` original moving coordinates**
have circle distance at least `1/N` at `n/(N*M)`. The distinguished
coordinate is not replaced by a dummy. Keeping `r` integral ensures that
the quotient terms from arbitrary integer lifts still contribute integer
phases; an arbitrary real perturbation would not justify this step.

The coarse size hypothesis forces `A<M`, since
`N*A< N*M` follows from `N*A<=(N-2)*M`. Therefore the forthcoming Nat
formalization can use the compiled combined-band helper for the distinguished
and ordinary bases. The manuscript's looser `C-exact` variant need not force
`a<M`: its valid boundary fixture `N=3,M=2,A=3,a=2` lies outside the current
Nat helper's remainder hypothesis. That fixture is manuscript evidence and
must not be advertised as already covered by the compiled helper.

### Exact error improvements and necessary upper bound

For a chosen pair, `a_i*beta<=M` and
`M<=A*beta<=(N-1)*M` suffice. Ordinary equality can place an `h_i=N-2`
row exactly on the upper good boundary. With `L=ceil(M/A)`, the exact error is

```text
beta(r0)=L+((-M*r0-L) mod N).
```

For nonzero `r0` modulo prime `N`, its maximum is accepted as stated:
if `N|M`, it is `N*ceil(M/(N*A))`; otherwise take the greatest nonmultiple
of `N` in `[L,L+N-1]`. This last assertion uses invertibility of `M`
modulo the prime `N`. It cannot be copied to a composite modulus merely
assuming `N` does not divide `M`: at `N=9,M=3,A=9` the actual maximum is
9, whereas that erroneous extension would predict 8.

The omitted-upper-bound control is valid: `N=5,M=20,A=U=100`, ordinary
bases/speeds `(1,2,3)`, and `r0=2,s=4` give `beta=5,n=25 mod 100`.
The cyclic distances are `(25,50,25,0)`. Large `A*beta` may wrap to zero;
the lower bound alone does not suffice. This rejects the omitted premise,
not LRC. The unlifted special case's elementary witness
`k/N+1/(N*A)` is also sound under the stated nonzero-slope and dominance
conditions; arbitrary lifts are the reason for the integral shifted grid.

## 4. Uniform family and all-modulus exclusions

For prime `N>=7`, the manuscript family

```text
M>=N^2*(N-1), H=1+M*ell with ell>=1,
(2,3,N,4H,5H,...,(N-1)H)
```

meets the one-zero hypotheses with distinguished base/speed `A=U=N` and
ordinary bases `2,3,4,...,N-1`. The largest ordinary size requirement is
exactly `M>=N^2*(N-1)`. There are exactly `N-1` distinct positive moving
speeds, and the family is primitive because it contains 2 and 3. Every
denominator 2 through `N` divides a displayed speed. At the maximal pivot
there are `N-2` lower owners, so the former zero-kernel numerical sufficient
condition fails even if its domination count is zero. No failure of other
certificate mechanisms or every pivot follows.

The stronger explicit subfamily works for **every integer `N>=7`**, including
even and composite counts:

```text
M=N^2*(N-1)+1, ell=1+N*z (z>=0), H=1+M*ell,
r0=3, s=N-2, r=N*(3*N-2), beta=N^2-3,
n=N^3-2, denominator=N*M.
```

Since `M=1 mod N` and `H=2 mod N`, the fixed ordinary affine values are
2 and 3; the other values are `N-j` for `4<=j<=N-1`. They all lie in
`1..N-2`. The ceiling formula and reduced numerator identity are correct.
All the scalar inequalities are valid without primality; the supplied
explicit pair replaces the prime-field existence step. The theorem for
arbitrary lifted data remains an odd-prime theorem.

### What "beyond every A/B normalization" proves

For any `N>=7`, any external modulus `K>0`, any common modular unit, and
any independent coordinate signs, positive representatives of the core
`(2,3,N)` satisfying `b_j<K/(N-1)` force `N|b_N`. To verify this uniformly,
take the absolute multiplier phase `x in (0,1/2]` and
`epsilon=1/(N-1)<=1/6`. Small distance for speed 2 forces either
`x<epsilon/2` or `x>(1-epsilon)/2>=5/12`. The latter gives speed-3 distance
greater than `1/4`, so is impossible. In the first interval, the speed-3
condition gives `x<epsilon/3`. Thus `N*x< N/(3*(N-1))<=7/18<1/2`, and
the unique small absolute speed-`N` residue is exactly `N*w` for the
integer absolute multiplier residue `w`.

This proves theorem A's nonvanishing-base normalization fails for the whole
family for **every** modulus, not merely those in a search. The core argument
actually needs no unit condition; unit status matters for the pivot transport.

Theorem B cannot avoid the core by changing its pivot within this family.
Its positive small bases require `K>N-1`. A pivot 2 or 3 cannot be divisible
by such `K`; a pivot `N` violates its nondivisibility condition; every other
pivot leaves the entire `(2,3,N)` core among the ordinary coordinates. Unit
transport preserves `K|w` for a proposed original pivot `w`. These exhaust
the proposed pivots and prove the asserted A/B normalization exclusion.

This is strict enlargement beyond those exact sufficient contracts, even
after their signs and modular-unit transport. It is not exclusion from all
known LRC methods, nor a proof of literature novelty. The external-paper
comparison was not independently audited in this review.

## 5. Several zero rows and limits of iteration

The simultaneous extension is accepted with the inherited odd-prime `N`,
positive `M`, exactly `N-1` original coordinates, and `1<=k<=N-1` zero
coordinates. Their positive bases `A_j` and original integer speeds `U_j`
are divisible by `N` and congruent modulo `M`; each ordinary speed is
congruent to its base `a_i`. Put `L=min A_j`, `H=max A_j`, and assume

```text
0<a_i<L, N does not divide a_i, H<(N-1)*L,
((N-1)*L-H)*M >= N*H*L,
(L-a_i)*M >= N*L*a_i.
```

Padding the at most `N-2` ordinary field rows to exactly `N-2`, then
restricting the affine conclusion, is legitimate. The dummies are algebraic
only; the real conclusion still covers exactly the original `N-1` speeds.
This includes the case of no ordinary rows. Shift from the **smallest**
zero base, giving `M/L<=beta<M/L+N`. Then every zero correction lies
between `M` and `(N-1)*M`, while every ordinary correction is below `M`.
The first size bound is exactly what supplies the largest zero row's upper
bound. This proves a simultaneous full witness, not an unsupported sequential
insertion argument.

At `H=(N-1)*L`, the common first good interval reduces to `beta=M/L`.
Because `N|L`, integrality and the residue congruence force `N*L|M`;
conversely that divisibility makes the shifted ceiling attain the point for
every `r0`. Both zero endpoints are good. The exact instance
`N=5,M=25`, zero bases `(5,20)`, ordinary bases `(1,2)`, `r0=1,s=2`
has `beta=5,n=80 mod 125` and distances `(45,35,25,25)/125`.

Both failed-extension controls are accepted:

- At `N=5,M=1001`, rounding first from zero base 10 with `r0=1,s=2`
  gives `r=221,beta=104,n=3107`. Speeds `(1,2,5,10)` have integer cyclic
  distances `(1898,1209,520,1040)` modulo 5005. The smaller zero row fails.
- For ordinary bases `(1,9)` and zero bases `(10,50)` at `N=5`, the uniform
  ordinary correction rule gives `0<=tau=beta/M<=1/9`. The first zero
  phase `2*tau` can be good only if `tau>=1/10`, but then the other phase
  `10*tau` lies in `[1,10/9]` and has distance at most `1/9<1/5`.
  No real correction inside this whole allowed interval works, even with
  wrap permitted. Increasing `M` or changing the affine pair cannot repair
  this particular uniform-correction contract.

The last obstruction does not refute use of actual `h_i`-dependent margins,
different floor patterns, different representatives, or another method.
The tuple `(1,9,10,50)` itself has the ordinary LRC witness `1/4`.

## 6. Verification and source fingerprints

Independent exact checks used no floating-point arithmetic or generated files:

| Check | Outcome |
| --- | --- |
| Generic combined band: `2<=N<=9`, `1<=M<=16`, all `0<=a<M`, three natural lifts, every `0<=s<N`, `r0` in `{0,1,N-1}`, `0<=r<=2M` | 105,789 admitted cases satisfied the exact residue and closed distance inequalities |
| Features among those admitted cases | 21,560 zero affine residues; 73,649 errors greater than `N-1`; 11,867 upper endpoint equalities; 8,870 lower endpoint equalities; 36,550 zero bases |
| Shifted ceiling and exact worst-error formulas: `N=3,5,7,11`, `A=N,2N,3N`, `1<=M<=120`, all nonzero `r0` | 7,920 rounding cases and all 1,440 parameter-triple maxima passed |
| Manuscript's complete fenced reproducer, independently executed | 94,560 one-zero constructions; 776 explicit family cases for every integer `7<=N<=200`; 304,460 modular units with 6,334 compressed cores; 5,200 multiple-zero constructions; all controls passed |
| Compiled declarations | Independent import, statement and axiom probes passed for both full-size public declarations, the combined-band helper, and the preserved wrapper |
| Original helper signature | Identical to `5c24b77` after whitespace normalization; duplicated legacy proof absent |

These checks corroborate the independent algebra; they are not unrestricted
proofs or kernel evidence for the manuscript-only results. All probed Lean
declarations use only `propext`, `Classical.choice`, and `Quot.sound`.

Frozen SHA-256 source values:

```text
9badca0a324c37a2f9a57c860ab83f9da6e7b8aac922f52e4985352ec57bee54  LonelyRunner/AffineGridFullSize.lean
0be8553d88fed2346895abcaeb961d0fb2967ee8db356feff8877ceb8b49b079  LonelyRunner/AffineGridArithmetic.lean
89deb703b3a753d8973defbe47324b2a54330150449bdfa81860e7a9c0127d8d  research/astra-vanishing-slope.md
```

The arithmetic file's separate Git blob identifier is
`510aa635d7d78a250a030c6345f1c8eaa12d03b3`; that is not its SHA-256.
Pinned Lean is `leanprover/lean4:v4.32.1`, with mathlib revision
`520045ab14e26149ee970e2e617ca04b09bde5d6`.

## 7. Remaining gap and disposition

No substantive mathematical correction is needed in the reviewed source or
manuscript proofs. Section 5's inherited assumptions should be explicit when
the simultaneous theorem is restated: odd-prime `N`, `M>0`, the original
total `N-1`, the number of zero rows, and all congruences. The standalone
contract above retains each of them.

The one-zero and multiple-zero theorems, integer/sign extensions, closed
borderline refinements and explicit all-count family remain manuscript-only
at this checkpoint. They are suitable bounded formalization targets. This
review does not wait for or claim a later one-zero implementation.

The global gap remains the existence of admissible representations for
arbitrary original speed tuples. The new one-zero route requires one multiple
of `N` to dominate every other base plus quantitative size bounds. The
multiple-zero route requires a shared correction interval, and its negative
control prevents asserting automatic iteration with the same protected
ordinary interval. General affine existence still uses a prime runner count;
the explicit every-integer family is a separate special case. None of these
results proves or disproves the canonical unrestricted
`LonelyRunner.Conjecture`.

## 8. Final source-review addendum: compiled one-zero theorem

This follow-up source review was completed on 2026-09-05 at base
`5c24b7719ef1d399a32363791f3038283747fc97` plus the frozen sources below.
It supersedes the earlier checkpoint's statement that the **Nat coarse-size
one-zero theorem** remained manuscript-only. The other manuscript-only
limitations remain in force. The project workflow files were reread and
structural validation passed again. The reviewer appended only this addendum;
the root's concurrent full build was not duplicated.

**Accepted:** `LonelyRunner/AffineShiftArithmetic.lean` and
`LonelyRunner/AffineGridVanishing.lean` implement the previously reviewed
coarse one-zero proof without strengthening its hypotheses or dropping any
original coordinate. No correction is required.

### Exact public theorem contract

`affine_grid_one_zero_witness` has natural-number parameters `N,M,A,U`,
odd-prime `N`, a finite index type with exactly `N-2` labels, and natural
maps `a,u`. Its hypotheses are precisely

```text
M>0, A>0,
N|A, N|U, U=A mod M,
for each i: 0<a_i<A, N does not divide a_i, u_i=a_i mod M,
N*A <= (N-2)*M,
for each i: N*a_i*A <= (A-a_i)*M.
```

It concludes natural `s,r`, `0<s<N`, and the simultaneous inequalities

```text
circleNorm((s/N+r/M)*U) >= 1/N,
for every i: circleNorm((s/N+r/M)*u_i) >= 1/N.
```

Thus the distinguished **original** speed `U` and all `N-2` ordinary original
labels are included at the closed `1/N` threshold. The distinguished speed
is not an algebraic dummy, and the theorem is not just a conclusion about
the ordinary coordinates. The speed maps need not be injective. No product
condition, ordinary-offset restriction, coprimality of `M,N`, external-prime
assumption, explicit `A<M`, explicit `a_i<M`, or supplied-witness premise
appears in the public interface.

The natural subtraction `A-a_i` occurs only alongside `a_i<A`, so the
coarse condition is the intended integer inequality. The field theorem is
invoked on exactly `N-2` nonzero slopes; its nonzero scale supplies `0<s<N`.
The source derives `N>=3` from primality and oddness rather than silently
assuming it.

### Review of the three shifted arithmetic helpers

`exists_affine_shift_rounding` assumes positive `N,A,M` and constructs
natural `r,beta` with

```text
N*r=M*r0+beta,
M<=A*beta<M+N*A.
```

It reuses ordinary integral rounding with denominator `A*N` and numerator
`A*M*r0+M`. The resulting error `err<A*N` satisfies
`A*beta=M+err`. The proof establishes `M*r0<=N*r` before introducing
the natural difference `beta=N*r-M*r0`, so no truncated subtraction is
treated as a signed one. This is exactly the scaled form of the reviewed
shifted ceiling, and it places no incorrect `beta<=N-1` bound on the new
error.

`affine_shift_large_scalar_bounds` derives both `A<M` and
`A*beta<(N-1)*M`. The first follows by the strict chain

```text
N*A <= (N-2)*M < N*M.
```

The second follows from
`A*beta<M+N*A<=M+(N-2)*M=(N-1)*M`. This is the precise derivation needed
to use the generic helper's remainder hypothesis for the distinguished row.

`affine_shift_ordinary_correction_bound` multiplies the strict scaled-error
bound by positive `a_i` and uses the coarse ordinary size condition to obtain

```text
A*(a_i*beta) < a_i*M+N*a_i*A <= A*M,
```

hence `a_i*beta<M`. The theorem then derives every `a_i<M` from
`a_i<A<M`. Neither remainder bound has been added as a new normalization
assumption.

### Combination with the compiled band theorem

For the distinguished row, the source explicitly proves
`(s*U+r0*A)%N=0` using both divisibility hypotheses. Its combined residue
is therefore `A*beta`; the shifted lower and upper bounds give the generic
closed band. For an ordinary row, the compiled field-to-natural conversion
gives `1<=h_i<=N-2`. Then

```text
M<=h_i*M+a_i*beta<=(N-2)*M+M=(N-1)*M.
```

Both branches invoke the same previously reviewed
`circleNorm_ge_of_affine_grid_residue_band`. The ordinary strict correction
bound is weakened only in the valid direction when closing the final weak
upper inequality. The final declaration preserves the closed distance
boundary throughout.

The returned real time is explicitly `s/N+r/M`, hence lies on the rational
`N*M` grid. The declaration does not export a reduced numerator or an
equivalence to the canonical unrestricted statement. An exported bounded
numerator remains a representation wrapper, not an unresolved premise of
the proved real-witness conclusion.

### Independent checks, final hashes, and remaining limitations

An independent `lake env lean --stdin` import of
`LonelyRunner.AffineGridVanishing`, with `#print axioms` for all four new
public declarations and `#check affine_grid_one_zero_witness`, passed.
Every axiom report contained exactly `propext`, `Classical.choice`, and
`Quot.sound`. A direct source-signature check also confirmed the original
coarse inequalities, label count, both groups of conclusions, and absence
of any added `A<M` or `a_i<M` hypothesis. `git diff --check` passed.

The root module's imports and `AxiomAudit.lean` probes were read back and
include the new full-size, shift-arithmetic and one-zero declarations.
This is integration-wiring evidence. The full source build and full trust
audit running in the parent task belong to its separate integration record;
this reviewer ran no full build and makes no completion claim for that run.

The root's manuscript update now explicitly states every inherited Section 5
assumption requested earlier: odd-prime `N`, `M>0`, the full `N-1` labelled
tuple, `1<=k<=N-1`, and all congruences modulo the same `M`. That documentation
follow-up is resolved. Its mathematical statements are unchanged. The generic
combined-band and full-size source hashes also remain unchanged from the
earlier review.

Final SHA-256 fingerprints for this source checkpoint:

```text
a883b84e19096d0a1b3a007216c42edcbce72f1d527969d0f88ff41a52a37a0d  LonelyRunner/AffineShiftArithmetic.lean
7bcec521f38f065e03c2f112e4af91f20b3e05b0cedcbc1e6f8f49cca350d5c4  LonelyRunner/AffineGridVanishing.lean
0be8553d88fed2346895abcaeb961d0fb2967ee8db356feff8877ceb8b49b079  LonelyRunner/AffineGridArithmetic.lean
9badca0a324c37a2f9a57c860ab83f9da6e7b8aac922f52e4985352ec57bee54  LonelyRunner/AffineGridFullSize.lean
f3e2c58177b5f3033afd0d164fbb688eacd30e5f42f39a7bc6ccaec5e82f599e  research/astra-vanishing-slope.md
7243033e4560ed8911e06725e6c7cee45279d477cf03cbaf48eb907185b9ec3c  LonelyRunner.lean
8c14c645dbd53660e4ebd10c41eef65f392cda43469c0f17ebe8f0deaa6565eb  LonelyRunner/AxiomAudit.lean
```

The one-zero theorem is now accepted at its compiled **Nat coarse-size**
scope. The more general integer/sign variants, exact-size/borderline variants,
multiple-zero extension and explicit every-integer family specialization
remain manuscript-only. The unrestricted normalization/supply gap remains:
no theorem gives every arbitrary speed tuple the required dominant vanishing
base and size conditions. The compiled result is an additional conditional
full-coordinate witness theorem, not a proof or disproof of
`LonelyRunner.Conjecture`.
