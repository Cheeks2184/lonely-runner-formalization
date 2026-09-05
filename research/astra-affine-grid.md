# Exact integer-grid consequences and the missing supply mechanism

Status: complete manuscript derivations and exact bounded checks. The Nat
actual-pivot Theorem B and its arithmetic bridge are now formalized in
`LonelyRunner/AffineGrid.lean` and `LonelyRunner/AffineGridArithmetic.lean`.
The Nat product-free Theorem A is also compiled in
`LonelyRunner/AffineGridFullSize.lean`. Signed transport and the explicit family
specialization remain manuscript results.
Independent Astra review is recorded in `research/astra-pass2-review.md`. This note
does not prove or disprove unrestricted LRC. Worker `/root/affine_grid` owns
only this file; requested routing Astra xhigh, independently observed runtime
metadata unavailable. Source checkpoint: `ed94a47`. Workflow policy/state were
read and `python3 scripts/validate_workflow.py` passed before research.

The input finite-field declarations are
`LonelyRunner.affine_avoidance_of_slope_product` and
`LonelyRunner.affine_avoidance_card_sub_two` in
`LonelyRunner/AffineAvoidance.lean`, SHA-256
`9fb78dc2b12694f096ac423c04835f3f961e0769dc6d5ae6180033d6004f22c0`.

The comparison source was read directly: Sungkawichai–Trakulthongchai,
[Section 4 of arXiv:2604.23906v2](https://arxiv.org/html/2604.23906v2#S4).
Their argument treats bases `(1,...,N-1)`, with the runner denominator `N`
and a separate large external prime. The exact integer calculation below
extends that rounding step to arbitrary positive bases, slightly improves
the sufficient size bound, and removes the external primality requirement.
The full-size consequence does not ultimately need the new repeated-slope
product generalization: repeated slopes have a simpler zero-scale branch.
The actual-pivot consequence instead uses the nonzero scale in the `N-2`
corollary. No literature novelty claim is made.

## 1. Integer rounding lemma, independent of LRC

Let `N>=2`, `M>0`, `a_i>0` be integers, and `u_i` integers with
`u_i ≡ a_i (mod M)`. Assume

```text
(N-1)*a_i < M             for every i.                         (size)
```

Given integers `0<=s<N`, `1<=r0<N`, set

```text
r = ceil(M*r0/N),
beta = N*r-M*r0,
n0 = s*M+N*r,       n = n0 mod (N*M),
h_i = (s*u_i+r0*a_i) mod N.
```

Suppose `1<=h_i<=N-2` for every i. Then

```text
0 <= beta <= N-1,
0 <= a_i*beta < M,
(n*u_i) mod (N*M) = h_i*M+a_i*beta,
M <= (n*u_i) mod (N*M) < (N-1)*M.                              (grid)
```

Proof: the ceiling gives `0<=N*r-M*r0<N`; integrality improves the upper
bound to `N-1`. Multiplication and (size) give `a_i*beta<M`. Congruence
`u_i≡a_i (mod M)` gives

```text
n*u_i ≡ s*M*u_i+N*r*a_i
      = M*(s*u_i+r0*a_i)+a_i*beta
      ≡ h_i*M+a_i*beta                       (mod N*M).
```

The displayed representative lies between `M` and `(N-1)*M`, so it is
already the least nonnegative representative. This proves every assertion.
In particular, for `t=n/(N*M)`, `circleNorm(t*u_i)>=1/N`. The lower
endpoint can be attained and remains good. The upper inequality is strict
only because this particular construction avoids the top floor interval.
There is no change to LRC's closed distance boundary.

Equivalently, this preserves the floor pattern at `r0/N` by choosing the
first `M`-grid point to its right. No prime assumption on `N` or `M` was
used in this lemma. The sufficient bound is `M>(N-1)*max a`, a weaker size
requirement than `M>N*max a`; the exact condition for a particular affine pair is
merely `a_i*beta<M` for all i.

## 2. Product-free full-size consequence

**Theorem A.** Let `N` be an odd prime and `I` a labelled set of size
`N-1`. Let `a_i` be positive integers with `N` not dividing `a_i`, and
let `M` be a positive integer satisfying (size). Let `u_i` be integers
congruent to `a_i` modulo `M`. If at least one `u_i` is not divisible by
`N`, then

```text
there exists 0<=n<N*M such that
  cyclicResidueDistance(N*M, n*u_i) >= M       for every i.       (A)
```

Here the cyclic residue distance of an integer is defined using its least
nonnegative residue, so negative speeds present no ambiguity. Thus the
`N-1` nonstationary speeds have the correct `N`-runner bound `1/N` at an
explicit finite grid. `M` need not be prime or coprime to `N`. No product,
distinctness, or gcd-one assumption on the bases is needed.

Proof. Write `v_i=u_i mod N` and `alpha_i=a_i mod N`.

* If every `v_i` is nonzero, take `t=1/N`, hence `n=M`. All residues of
  `u_i/N` lie in `{1/N,...,(N-1)/N}`. This branch legitimately includes
  the upper closed boundary and does not use the rounding lemma.
* Otherwise `v` has both a zero and a nonzero coordinate. If the slope
  map `alpha:I -> F_N^×` is surjective, equal cardinalities make it a
  bijection. Its product is therefore the product of all field units,
  namely `-1`. The established affine theorem supplies nonzero `r0,s`
  with every `s*v_i+r0*alpha_i` outside `{0,-1}`. Use their standard
  representatives in the rounding lemma.
* If the slope map is not surjective, choose a missing unit `x`. Set
  `r0=-x^(-1)` and **`s=0`**. Every `r0*alpha_i` is nonzero; equality
  with `-1` would imply `alpha_i=x`, a contradiction. The rounding lemma
  again applies. This branch needs no offset hypothesis at all.

These cases exhaust the possibilities. In the non-surjective branch,
repeated slopes, not a prescribed product, create the missing unit. This
explains why retaining a slope-product condition in Theorem A would be
unnecessarily restrictive.

A formalization-ready intermediate field contract is:

```text
N odd prime, |I|=N-1, alpha_i!=0,
(exists i, v_i=0), (exists i, v_i!=0)
  ==> exists r,s in F_N, r!=0 and
        forall i, s*v_i+r*alpha_i notin {0,-1}.
```

There is intentionally **no `s!=0`** in this intermediate contract. The
surjective-slope case may invoke the compiled product theorem; the other
case explicitly chooses `s=0`.

## 3. One fewer coordinate plus an actual pivot speed

**Theorem B.** Let `N` be an odd prime, and let the original speed tuple
have one distinguished speed `w` and `N-2` remaining labelled speeds
`u_i`. Assume:

```text
M>0,  M divides w,  N does not divide w,
a_i>0,  N does not divide a_i,  (N-1)*a_i<M,
u_i ≡ a_i (mod M)                             for every i.
```

Then there is `0<=n<N*M` such that all `N-1` original speeds, **including
the actual distinguished speed**, have cyclic residue distance at least
`M` on the `N*M` grid. Thus all satisfy the required `1/N` bound.

Proof. Apply `affine_avoidance_card_sub_two` to the `N-2` slopes `a_i mod N`
and offsets `u_i mod N`. It supplies both `r0!=0` and **`s!=0`**, without
any restriction on the offsets or slope product. Apply the rounding lemma
to the remaining speeds. Write `w=c*M`. At its constructed time,

```text
w*(s/N+r/M) = s*w/N+c*r.
```

Since the prime `N` divides neither `s` nor `w`, its fractional part is
one of `1/N,...,(N-1)/N`. Reducing the time modulo one does not change
the phase of an integer speed. This proves the distinguished speed good.

The hypotheses already force `N` not to divide `M`. They are preserved
for arbitrary positive `c` with `N` not dividing `c*M`. If `w=c*M>0`, the
time is also on the ordinary pivot grid `1/(N*w)`: its numerator there is
`c*n`. This numerator is a pivot candidate, because

```text
c*n ≡ c*s*M = s*w != 0 (mod N).
```

Thus this result supplies an actual pivot-residue certificate, even when
some remaining speeds exceed `M`. It does not require the distinguished
speed to be maximal; examples below additionally make it maximal.

The dummy used **inside** the finite-field proof is purely algebraic. It
cannot silently replace an original speed. Applying the `N-2` theorem to
`N-2` original speeds alone proves a `1/N` bound, while their canonical
LRC bound is `1/(N-1)`. Restoring the actual speed `w` is the step that
makes Theorem B's runner count and denominator correct.

For example, `N=5,M=13,a=u=(1,2,3)` meets the one-fewer-coordinate input,
but **no** time on the `1/65` grid attains `1/4` for all three speeds.
Their only `1/4` witness times modulo one are `1/4` and `3/4`: reflect
to `0<=t<=1/2`; the first two inequalities give `1/4<=t<=3/8`, and
the speed-3 inequality then forces `t=1/4`. Neither time is a `1/65`
grid point. Exact enumeration gives maximum minimum distance `16/65`.

## 4. Signed representatives and modular multipliers

Both theorems extend to bases obtained by independent coordinate signs:
apply the integer version to `epsilon_i*u_i`, where `epsilon_i` is `1`
or `-1`, and use `circleNorm(-x)=circleNorm(x)`. There is no claim that
a signed base is itself positive before this choice; `a_i` denotes its
chosen positive representative after the sign change.

A common unit multiplier modulo `M` also transports the conclusion to
the original tuple. Given `gcd(c0,M)=1`, choose an integer `b` with
`b≡c0 (mod M)` and `N` not dividing `b`. If `N|M`, every such lift is
already a unit modulo `N`; otherwise choose `b≡1 (mod N)` by CRT.
Apply the theorem to `epsilon_i*b*u_i`. Nondivisibility of at least one
speed by `N`, or of the actual pivot, is preserved. A resulting time
`n/(N*M)` for these transformed speeds gives time `b*n/(N*M)` for the
original speeds, because the coordinate signs do not affect circle norm.
The transformed time remains on the same grid.

This is a conditional transport. It does **not** prove that any admissible
positive bases exist for an arbitrary speed tuple. The next obstruction
allows every such sign and multiplier.

## 5. Universal normalization into this class is false

Fix `N=5` and the primitive tuple `U=(2,3,4,5)`. For **every** integer
modulus `M`, there is no common unit multiplier and independent coordinate
signs producing positive representatives satisfying simultaneously

```text
0<a_i<M/4,     5 does not divide a_i,     a_i ≡ ±c0*U_i (mod M).
```

Proof. If such representatives existed, let `w` be the nonnegative absolute
residue `min(c0 mod M, M-(c0 mod M))` and put `x=w/M`. The positive
representative hypotheses force `w>0`, so `0<x<=1/2`. Because
`a_i<M/4`, each `a_i/M` must be exactly `circleNorm(U_i*x)`. The conditions
for speeds 2 and 4 imply

```text
circleNorm(2*x)<1/4  ==> x in (0,1/8) union (3/8,1/2],
circleNorm(4*x)<1/4  ==> x in (0,1/16) union (7/16,1/2]
                         within that previous set.
```

On the upper interval, `3*x` lies in `(21/16,3/2]`; its distance to the
nearest integer is greater than `5/16`, hence greater than `1/4`.
Consequently `x<1/16`. Now `5*x<5/16<1/2`, so the speed-5 representative
is exactly `a_5=5*w`. It is divisible by 5, a contradiction. In fact the
speed-5 size condition further implies `x<1/20`.

Permutations do not affect the argument. This proves the obstruction for
all moduli, and therefore for every external prime, not merely up to a
finite height. Every denominator `2,...,5` already divides a speed of
`U`; the simple denominator-escape test does not eliminate this fixture.
Nevertheless `t=1/7` is an LRC witness, with distances
`(2/7,3/7,3/7,2/7)`. This is **not** an LRC counterexample.

The parent supplied a related obstruction `U=(1,2,3,5)`, which also
survives the improved `M/4` bound: successively the speed-1, speed-2,
and speed-3 conditions force `w<M/4`, `w<M/8`, and `w<M/12`, with no
wrap in these representatives; then `5*w<5*M/12<M/2`, so the speed-5
representative is again divisible by 5. Its witness `t=1/4` is immediate.

Theorem B can of course handle tuples having an actual suitable divisor
`M` of one speed, but neither obstruction tuple has such an application
at the stated positive size bound: all possible divisors of their speeds
are at most 5, whereas `M>4*max a` requires `M>=5`; the sole possibility
`M=5` contradicts Theorem B's requirement that `N` not divide the pivot.
This last finite observation is not needed for the all-modulus
normalization obstruction itself.

## 6. The all-zero offset exclusion is necessary on this fixed grid

Take `N=5`, `M=17`, bases `a=(1,2,3,4)`, and

```text
u=(35,70,105,140).
```

All inputs of Theorem A except its nonzero-offset condition hold:
`4*max a=16<17`, all slopes are nonzero, their product is even `-1 mod 5`,
and `35*i ≡ i (mod 17)`. But all speeds are divisible by 5. At a grid
time `n/85`, the phases reduce to `7*n*(1,2,3,4)/17`. Since 7 is a unit
modulo 17, the possible numerators reduce to `q=0,...,16`. Their minimum
cyclic distances modulo 17 are exactly

```text
q:       0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
minimum: 0 1 2 3 1 2 1 3 1 1  3  1  2  1  3  2  1.
```

Thus the best minimum distance on this grid is `3/17=15/85<1/5`.
The original tuple still has the ordinary LRC witness `1/175`.
This rejects only deleting the all-zero-offset exclusion from the fixed
grid theorem. A primitive positive tuple has at least one speed not
divisible by `N`, so Theorem A needs no additional exclusion in that case.

## 7. A uniform dense family supplied by Theorem B

For every odd prime `N>=5`, define

```text
M = N*(N-2)+2,
b = (N-3)^2/2,
choose c>b with N not dividing c,
p = c*M.
```

The integer `b` is a multiple of `N-3`. Such a `c` always exists; for
example `c=b+N` works because `2*b≡9 (mod N)` and `N>=5` is prime.
For base indices `1<=i<=N-2`, put

```text
a_i = i,
u_i = i                       if i<=N-4,
u_(N-3) = N-3+b*M,
u_(N-2) = M+N-2 = N*(N-1).
```

Use the actual speed `p=c*M` as the remaining coordinate. These are
`N-1` distinct positive speeds, all other speeds strictly below `p`.
They are primitive because speed 1 occurs. The bases are nonzero modulo
`N`, and

```text
M-(N-1)*(N-2) = N > 0.
```

All congruences in Theorem B hold, and `N` divides neither `M` nor `p`.
Therefore it supplies a correct `1/N` witness for this entire family.

Every simple denominator from 2 through N is blocked. Values `2,...,N-4`
occur as speeds. The next speed is divisible by `N-3`, since `N-3|b`.
It is also divisible by `N-2`: writing the odd number `m=N-2`,
`M≡2 (mod m)` and `2*b=(m-1)^2≡1 (mod m)`, so

```text
u_(N-3) ≡ -1+2*b = 0 (mod N-2).
```

Finally `u_(N-2)=N*(N-1)` blocks both `N-1` and `N`. This proof includes
`N=5`, when the initial interval `2,...,N-4` is empty.

An explicit witness avoids even an affine-pair search for this family.
For `N>=7`, choose

```text
r0=1,    s=(N-1)/2,    r=N-1,
t=s/N+(N-1)/M                  reduced modulo one if desired.
```

Modulo `N`, the ordinary rows have `h_i=i/2` (field division), and the
two exceptional rows have `h_(N-3)=-6` and `h_(N-2)=-2`. For the first
identity use `u_(N-3)≡6`; for the second use `u_(N-2)≡0`. The ordinary
indices are at most `N-4`, so none of these values is 0 or -1; the only
prime exclusions needed for `-6` are 2, 3, and 5. Also
`ceil(M/N)=N-1` and `beta=N-2`, so Section 1 proves the witness.
For `N=5`, use `r0=s=1`, still `r=4`; the three values of h are `(2,3,3)`.

This family is outside the current owner-kernel **numeric sufficient
condition** at its displayed maximal pivot. Its owner count is `C=N-2`.
For every possible zero-dominator count `q>=0`,

```text
2*(N+1)*C+(N-2)*q >= 2*(N+1)*(N-2) > N*(N+1)
```

because `N>4`. Thus the condition fails even with `q=0`. This is a
uniform comparison of two sufficient mechanisms, not a claim that existing
full ordered/two-parent certificates fail, or that every pivot fails the
numeric condition.

Two exact fixtures, using the smallest `c>b` not divisible by `N`, are:

| N | M | b | c | Speeds, in labelled base order then pivot | Grid numerator/denominator | Minimum grid distance |
|---|---|---|---|---|---|---|
| 5 | 17 | 2 | 3 | `(1,36,20,51)` | `37/85` | `17/85=1/5` |
| 7 | 37 | 8 | 9 | `(1,2,3,300,42,333)` | `153/259` | `47/259>1/7` |

At the first maximal pivot, the candidate count is 204; lower-owner bad
counts are `(80,78,84)`, zero counts `(0,0,4)`, bad union size 162, and
safe count 42. Thus `q=1`; the kernel numeric test reads `39>30`.
At the second pivot, the candidate count is 1998; bad counts are
`(570,570,570,570,558)`, zero counts `(0,0,0,0,18)`, bad union size
1604, and safe count 394. Here `q=1` and the numeric test reads `85>56`.
Both calculations retain the strict badness boundary and all labelled rows.

A smaller additional fixture with repeated slopes is
`N=5,M=17,a=(1,1,3),u=(1,18,20),p=34`. Pair `(r0,s)=(1,2)` gives
`n=54`, denominator 85, and distances for `(p,u)` equal
`(34,31,37,25)/85`. At pivot 34, the candidate count is 136, bad counts
`(54,52,56)`, zero counts `(0,0,8)`, bad union size 112, and safe count
24. The same `39>30` numeric failure occurs. No tree or two-parent
novelty is asserted; the existing `q=1` dominance result remains intact.

### Explicit-family extension to odd composite runner counts

The parent and independent reviewer checked that the explicit construction
above works for **every odd `N>=7`**, as well as the separate `N=5` case.
This extends this displayed family only; Theorems A and B still require a
prime runner count. For the composite extension choose any `c>b` with
`N` not dividing `c`; the unconditional choice `c=N*(b+1)+1` works.
The earlier convenient choice `c=b+N` was justified only in the prime case.

Indeed, 2 is invertible modulo every odd `N`. Ordinary indices still give
`h_i=i/2`, and `1<=i<=N-4` excludes both 0 and -1. The exceptional values
are still -6 and -2, neither 0 nor -1 for `N>=7`. Since `M=2 (mod N)`
and `2*s=-1 (mod N)`, the pivot's phase numerator is `s*c*M=-c (mod N)`,
which is nonzero by the chosen condition on `c`. All rounding, lower-speed,
distinctness, and denominator-cover calculations are unchanged. Thus the
same explicit time proves the full closed `1/N` bound, without using the
prime-field theorem.

The parent repeated 1,912 exact instances for every odd `N` from 7 through
199 and `b<c<=b+20` excluding multiples of `N`. The independent reviewer
checked another 142 instances through 101, including the unconditional
choice of `c`. These checks corroborate the uniform argument; they are not
a formal proof of this family extension.

## 8. Formalization-ready targets and exact remaining gap

The suggested Lean order is:

1. A generic integer rounding/residue identity as in Section 1; it has no
   prime or cardinality input.
2. The finite-field `N-1` avoidance contract permitting `s=0`, proved by
   the slope-image split, with both zero/nonzero offset hypotheses.
3. Theorem A over `I` with `Fintype.card I=N-1`, positive Nat bases,
   integer speeds, `Int.ModEq (M : Int)`, and
   `exists i, Not ((N : Int) divides u_i)`. Conclude a numerator in
   `Fin (N*M)` with residue distances at least `M`, then use the existing
   circleNorm bridge to obtain the real witness.
4. Theorem B over `I` with `Fintype.card I=N-2` plus a separately labelled
   original speed `w`, `M|w`, `Not (N|w)`. Its full conclusion includes
   `w`. Positive Nat inputs are sufficient for the main project adapter;
   the signed multiplier extension can use integer speeds separately.
5. The displayed dense family and explicit pair as a conditional family
   corollary; no unrestricted statement is licensed by it.

The following high-level Nat interface for the actual-pivot theorem is now
compiled as `LonelyRunner.affine_grid_pivot_witness`:

```lean
theorem affine_grid_pivot_witness
    (N M c : ℕ) [Fact N.Prime] (hodd : Odd N)
    {I : Type*} [Fintype I] (hcard : Fintype.card I = N - 2)
    (a u : I → ℕ) (hM : 0 < M)
    (ha : ∀ i, 0 < a i)
    (haN : ∀ i, ¬ N ∣ a i)
    (hu : ∀ i, Nat.ModEq M (u i) (a i))
    (hsize : ∀ i, (N - 1) * a i < M)
    (hpivot : ¬ N ∣ c * M) :
    ∃ s r : ℕ, 0 < s ∧ s < N ∧
      (N : ℝ)⁻¹ ≤ circleNorm
        (((s : ℝ) / N + (r : ℝ) / M) * (c * M : ℕ)) ∧
      ∀ i, (N : ℝ)⁻¹ ≤ circleNorm
        (((s : ℝ) / N + (r : ℝ) / M) * (u i : ℝ))
```

The construction supplies `r=ceil(M*r0/N)` for the standard representative
of a nonzero affine value `r0`. One may additionally prove `0<r<M`:
the nonempty index set and size condition give `M>=N`, while `hpivot`
excludes `N|M`, hence `M>N`; now `1<=r0<=N-1` gives the ceiling bounds.
Those extra bounds are not necessary for the displayed witness contract.
To expose a bounded grid numerator afterward, reduce `s*M+N*r` modulo
`N*M`. The existing arithmetic helper can be invoked with
`N*r=M*r0+beta`, `beta<=N-1`, and the field-value representatives
`1 <= (s*u_i+r0*a_i)%N <= N-2`, proved before any circleNorm conversion.

The lack of an arbitrary-prime supply mechanism is now concrete. For a
prime-gate proof one would need to handle *every* residual speed class,
possibly after other sound sieves or a genuinely broader rounding theorem.
Theorems A and B do not do so: a single primitive, divisor-covering tuple
already defeats their small-base normalization for every external modulus.
Merely increasing the external prime or checking more heights cannot fix
that obstruction. Further work must cover such omitted classes, allow
vanishing slopes with additional structure, use a substantially larger
floor-pattern region, or supply another certificate mechanism. No one of
these missing steps is proved here. Field primes with `N` equal to a
composite runner count are also outside both affine input theorems.

## 9. Exact check record and compact reproducer

Fresh standard-library Python checks performed on 2026-09-05:

| Check | Domain and outcome |
|---|---|
| Theorem A | 390,072 exhaustive tuples: `N=3,5`, each base in `1,...,N+1` excluding multiples of N, `M` the first integer above `(N-1)*max a` coprime to N, every lift coefficient in `0,...,N-1`, excluding all-zero offsets. 160,036 direct and 230,036 affine constructions passed. |
| Theorem B | 32,012 exhaustive tuples: `N=3,5`, bases in `1,...,N-1`, all lift coefficients modulo N, every pivot coefficient `1,...,N-1`. All passed. |
| Large lifts | 1,000 Theorem A and 1,000 Theorem B tuples for `N=7,11,13,17`, random seed `20260905`, lift coefficients below `10^12`. All passed with exact integer arithmetic. |
| Supply obstruction | Each of `(1,2,3,5)` and `(2,3,4,5)`, every modulus `2<=M<=1000` and every unit multiplier: 304,191 multipliers, 30,414 compressed cases, zero admissible cases. Every compressed speed-5 base was divisible by 5. |
| Uniform family | Nine primes `5,7,11,13,17,19,23,29,31`: all size, distinctness, lower-owner, divisor-cover, and grid assertions passed. Literal full pivot bad sets were additionally enumerated for N=5,7. |
| Negative controls | Maximum minimum distance `16/65<1/4` for `(1,2,3)` and `15/85<1/5` for `(35,70,105,140)` on their specified grids. |

These computations support the preceding independent uniform derivations;
they are not their proofs and are not kernel evidence. No full build was
run for this documentation-only task. The following compact reproducer
rechecks the construction, the uniform explicit family, and the decisive
negative controls. It uses no floating-point arithmetic:

```python
from itertools import product
from math import gcd

def rho(m, x):
    return min(x % m, (-x) % m)

def construct(N, M, a, u, pivot=None):
    if pivot is None and all(x % N for x in u):
        n = M
    else:
        r0, s = next((r, s) for r in range(1, N)
            for s in range(1 if pivot is not None else 0, N)
            if all((s*x+r*y) % N not in (0, N-1)
                   for x, y in zip(u, a)))
        r = (M*r0+N-1)//N
        beta = N*r-M*r0
        n = (s*M+N*r) % (N*M)
        assert 0 <= beta < N
        for x, y in zip(u, a):
            h = (s*x+r0*y) % N
            assert 1 <= h <= N-2 and y*beta < M
            assert n*x % (N*M) == h*M+y*beta
    U = u if pivot is None else u+[pivot]
    assert all(rho(N*M, n*x) >= M for x in U)
    return n

A_count = B_count = 0
for N in (3, 5):
    bases = [x for x in range(1, N+2) if x % N]
    for a in product(bases, repeat=N-1):
        M = (N-1)*max(a)+1
        while gcd(M, N) > 1: M += 1
        for q in product(range(N), repeat=N-1):
            u = [x+M*y for x, y in zip(a, q)]
            if any(x % N for x in u):
                construct(N, M, a, u)
                A_count += 1
    for a in product(range(1, N), repeat=N-2):
        M = (N-1)*max(a)+1
        while gcd(M, N) > 1: M += 1
        for q in product(range(N), repeat=N-2):
            u = [x+M*y for x, y in zip(a, q)]
            for c in range(1, N):
                construct(N, M, a, u, c*M)
                B_count += 1
assert (A_count, B_count) == (390072, 32012)

for N in (5, 7, 11, 13, 17, 19, 23, 29, 31):
    M = N*(N-2)+2
    b = (N-3)**2//2
    c = b+1 if (b+1) % N else b+2
    a = list(range(1, N-1))
    u = [i+b*M if i == N-3 else M+i if i == N-2 else i for i in a]
    p = c*M
    assert len(set(u+[p])) == N-1 and all(x < p for x in u)
    assert all(any(x % d == 0 for x in u+[p]) for d in range(2, N+1))
    s = 1 if N == 5 else (N-1)//2
    n = (s*M+N*(N-1)) % (N*M)
    assert all(rho(N*M, n*x) >= M for x in u+[p])

assert max(min(rho(65, n*x) for x in (1, 2, 3)) for n in range(65)) == 16
assert max(min(rho(85, n*x) for x in (35, 70, 105, 140))
           for n in range(85)) == 15
for U in ((1, 2, 3, 5), (2, 3, 4, 5)):
    units = compressed = 0
    for M in range(2, 1001):
        for c in range(1, M):
            if gcd(c, M) != 1: continue
            units += 1
            a = [rho(M, c*x) for x in U]
            if min(a) > 0 and 4*max(a) < M:
                compressed += 1
                assert a[U.index(5)] % 5 == 0
    assert (units, compressed) == (304191, 30414)
print('All compact affine-grid checks passed.')
```
