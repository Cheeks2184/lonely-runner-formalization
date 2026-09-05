# The proposed strict-witness control enters the enlarged grid union

Status: exact positive normalization and uniform manuscript derivation,
2026-09-05. Owned file: this note only. No Lean source, shared state, or Git
was changed. Current project policy/state were read; workflow validation
passed. This is a bounded supply audit, not an LRC proof or disproof.

**Result.** The tuple `(1,2,3,4,7,14)` enters the robust multiple-zero
contract with the identity multiplier and its original speeds as bases.
The modulus is just 66. The proposed family
`(1,...,N-3,N,2N)` also enters that contract for every odd prime `N>=7`.
Thus neither is an obstruction to A/B/coarse C/multiple-zero. A useful next
question must address global supply or its logical strength, not add another
formal specialization for these tuples.

## 1. An exact six-coordinate certificate

Take

```text
N=7, M=66, b=c=1, all signs positive, no speed lifts,
ordinary bases/speeds: (1,2,3,4),
zero bases/speeds:     (7,14),
L=7, H=14.
```

There are exactly six original speeds. Both zero bases and their actual
speeds are divisible by 7; ordinary bases are positive, smaller than 7,
and nonzero modulo 7. Congruences modulo 66 are equalities. The common
multiplier is a unit modulo 66 and is not divisible by 7. The size bounds
are

```text
H=14 < 42=(N-1)*L,
((N-1)*L-H)*M = 28*66 = 1848 >= 686 = N*H*L,
(L-4)*M       =  3*66 =  198 >= 196 = N*4*L.
```

The ordinary inequality becomes easier as the base decreases, so the last
line also covers 1, 2, and 3. This is a certificate for the full robust
contract, not merely necessary residue bounds.

An explicit affine pair and shifted grid are

```text
r0=2, s=6,
r=ceil(2*66/7 + 66/(7*7))=21,
beta=7*21-2*66=15,
n=s*M+N*r=543,       D=N*M=462.
```

For ordinary speed `i`, the affine residue is `(r0+s)*i=i mod 7`, in
`{1,2,3,4}`. All six exact grid residues, in original tuple order, are

```text
(81,162,243,324,105,210) modulo 462.
```

They lie strictly between 66 and 396. The reduced original time is
`543/462 mod 1 = 27/154`, with minimum circle distance `27/154>1/7`.
The simpler time `1/5` has minimum distance `1/5`; the grid certificate
does not improve that existing elementary witness.

The earlier obstruction proof for the core `(2,3,4,N,2N)` applies to this
tuple and rules out A, B, and coarse one-zero C individually. Multiple-zero
handling is exactly what supplies the missing case here.

## 2. A uniform sufficient class using the speeds themselves as bases

Let `N` be an odd prime and let `V` have `N-1` positive coordinates.
Suppose some original speeds are divisible by `N`. Let

```text
Z={i : N divides V_i},        O={i : N does not divide V_i},
L=min_{i in Z} V_i,          H=max_{i in Z} V_i,
B=max({V_i : i in O} union {0}).
```

Assume

```text
B<L,       H<(N-1)*L.                                      (I)
```

**Proposition 1.** These inputs have a robust multiple-zero normalization
with `b=1`, positive signs, and every base equal to its original speed.
It suffices to choose an integer `M>0` satisfying

```text
M >= N*H*L / ((N-1)*L-H),
M >= N*B*L / (L-B).                                        (3)
```

Both denominators are positive. The first inequality is the zero-row size
bound. The function `a -> a/(L-a)` is increasing for `0<=a<L`, so the
second implies every ordinary bound `N*a*L <= (L-a)*M`. The congruences
and zero-offset conditions are equalities and divisibilities of the
original inputs. If strict output is wanted, choose `M` not divisible by
`N`; arbitrarily large integers `N*K+1` suffice. No approximation, external
prime theorem, signs, or nontrivial common lift is needed.

This is a useful sufficient input because it is checked directly from the
original speeds. It is not uniform supply for arbitrary tuples: either
inequality in (I) can fail. Nor does applying the existing conditional
bridge to this class create another missing step toward the canonical LRC
proof. The point of recording it is to rule out unsuitable obstruction
candidates before more searches or formalization.

## 3. The entire proposed family has such certificates

For every odd prime `N>=7`, let

```text
V_N=(1,2,...,N-3,N,2N).
```

This is a primitive, distinct tuple of `N-1` positive speeds. It has
`B=N-3,L=N,H=2N`, so (I) holds. The sufficient modulus bounds (3) become

```text
M >= 2*N^2/(N-3),       M >= N^2*(N-3)/3.
```

The second dominates the first because `(N-3)^2>=6`. Thus the explicit
integer

```text
M=ceil(N^2*(N-3)/3)                                      (4)
```

works. It is coprime to `N`: since prime `N>=7` is not 3, the numerator
`N^2*(N-3)` has remainder 1 or 2 modulo 3. Therefore
`3*M=N^2*(N-3)+delta`, with `delta in {1,2}`. If `N|M`, then `N|delta`,
which is impossible. Primality gives the asserted coprimality.

For a uniform explicit affine pair choose `r0=2,s=N-1`. Every ordinary
speed `i in {1,...,N-3}` has affine residue
`(r0+s)*i=i mod N`, avoiding both 0 and -1. With modulus (4), set

```text
r=ceil(2*M/N + M/N^2),
beta=N*r-2*M,
n=(N-1)*M+N*r.
```

The robust inequalities give the full closed witness; because `N` does
not divide `M` and `L=N`, the integer `beta` cannot equal `M/L`, so every
coordinate is strictly inside its permitted band. The `N=7` case is
exactly Section 1.

There is also the stated elementary witness at `t=1/(N-2)`: ordinary
residues are `1,...,N-3`, and the final two residues are 2 and 4 modulo
`N-2`. For `N>=7` these are nonzero and their distances from the nearest
multiple of `N-2` are at least 1. Hence the minimum distance of the full
tuple is exactly `1/(N-2)>1/N`.

## 4. A precise global question with the lift restrictions eliminated

The positive example suggests no new universal mechanism. The next supply
question can, however, be stated exactly as an integer residue problem,
without hidden assumptions on a common lift or on the external modulus.
This is a contract simplification, not a proof of supply.

Fix an odd prime `N`, a primitive positive tuple `V` of length `N-1`, an
integer `M>=2`, and a unit `c modulo M`. Write

```text
d_i=min(c*V_i mod M, (-c*V_i) mod M),
Small(i) := 0<d_i and (N-1)*d_i<M and N does not divide d_i.
```

Define the three finite predicates:

* `A_N(V;M,c)`: `Small(i)` for every label.
* `B_N(V;M,c)`: there is a label `p` with `M|V_p`, `N` not dividing
  `V_p`, and `Small(i)` for every `i != p`.
* `R_N(V;M,c)`: choose for every label a positive residue
  `z_i in {c*V_i mod M, (-c*V_i) mod M}`. Let
  `Z={i : N|z_i}` be nonempty, let `L=min_{Z} z_i`, `H=max_{Z} z_i`,
  and let `O` be its complement. Require

  ```text
  H<(N-1)*L,
  N*H*L <= ((N-1)*L-H)*M,
  0<z_i<L and N*z_i*L <= (L-z_i)*M       for every i in O.   (5)
  ```

**Proposition 2.** Existence of any permitted normalization in the union
A/B/coarse C/robust multiple-zero is equivalent to

```text
exists M>=2, exists c with 1<=c<M and gcd(c,M)=1,
  A_N(V;M,c) or B_N(V;M,c) or R_N(V;M,c).                   (G)
```

Here is the full reason, including the two external-modulus regimes.

For A and B, the small bases are less than `M/2`, so they are forced to be
the absolute residues `d_i`. A common multiplier which is a unit modulo
`M` makes a transformed pivot divisible by `M` exactly when `M|V_p`.
Its nonzero offset modulo `N` implies `N` does not divide `V_p`.
Conversely, if `N` does not divide `M`, CRT supplies a lift `b==c (mod M)`
with `b==1 (mod N)`. If `N|M`, the unit condition already forces any lift
of `c` to be nonzero modulo `N`. Since primitive `V` has a coordinate not
divisible by `N`, A's required nonzero offset is then automatic. For B,
the chosen pivot is also nonzero modulo `N`. Signs realize the small
bases; independent multiples of `N*M` make all actual speeds positive.
The actual pivot remains a positive multiple of `M`.

For R, the coarse bounds imply every zero base is less than
`(N-1)*M/N<M` and every ordinary base is less than `M/N`. Hence the
positive bases must be precisely residues of the displayed signed forms.
If a compiled application used auxiliary bounds `L0<=A_j<=H0` instead of
the attained minimum and maximum, replace them by `L=min A_j` and
`H=max A_j`. This improves the inequalities: decreasing `H` improves
`L*((N-1)M-NH)>=HM`; increasing `L` improves it because its coefficient
is positive. Likewise every ordinary inequality is
`L*(M-N*a_i)>=a_i*M`, with positive coefficient. The span and `a_i<L`
requirements are preserved. Thus (5) is necessary even for that more
general presentation of the compiled theorem.

Conversely, given R when `N` does not divide `M`, CRT supplies a lift
`b==c (mod M)` with `N|b`. This makes all transformed offsets zero,
which is allowed; it does not require ordinary bases to be zero slopes.
When `N|M`, the unit condition and the congruence
`z_j == +/-c*V_j (mod M)` imply `N|V_j` for each zero label. Taking
`b=c` therefore gives the required zero offsets in this regime too.
Positive Nat representatives again come from adding multiples of `N*M`.
The circle distances transport back at the exact grid time, with the
independent signs harmless. This proves sufficiency in both regimes and
does not exclude large signed zero bases.

Finally, coarse C is exactly R with one zero label: put `L=H=A` in (5),
and cancel positive `A` in the zero inequality to obtain
`N*A<=(N-2)*M`. Hence it needs no separate branch in (G). Modulus `M=1`
cannot satisfy any branch, by the positive small-base bounds or the
strict upper bound on zero bases, so excluding it loses no normalization.

The mathematically exact **global supply question** is:

```text
For every odd prime N and every pairwise distinct primitive
V in (positive integers)^(N-1), does (G) hold?
```

This is falsifiable by an all-modulus obstruction for one such tuple,
or provable by a uniform construction of `M,c` satisfying one of its
finite predicates. A failed bounded search is not a negative answer.
The present note answers it positively only for the class in Section 2;
it neither establishes global supply nor converts the reformulation into
mathematical progress on the conjecture. Even a global affirmative result
would still concern these odd-prime runner counts and would need a checked
bridge before any claim about the full canonical conjecture.

A complementary exact **strength question** is whether every strict
original witness implies `R_N(V;M,c)` for some `M` not divisible by `N`.
The reverse implication is already proved in the preceding value audit.
Thus proving this direction would establish equivalence with strict witness
existence for that branch, rather than an easier independent supply lemma.
A strict tuple with an all-modulus obstruction to this R branch would
refute the equivalence. Neither question is settled here; unlike adding
another family specialization, each directly audits the missing global step.

## 5. Source binding and exact reproduction

The source contracts A, B, and multiple-zero were read directly. The source
hashes relevant to this audit are:

```text
LonelyRunner/AffineGridMultipleZero.lean
  225d6c6adcaa1d85309325b2bb4712a48f0adb13019c8e645d4a6699a73f1aca
research/astra-multiple-zero-value.md
  ef3619bfdf74e5b2794f8d4737623e8d3e9cedf62dd21039f9169465e4dd8090
research/astra-grid-supply-audit.md
  7caa2b660942cacb92382bc9cd661b83647af85f212b71589d162e6734bb22c1
```

A diagnostic scan of moduli in increasing order, allowing every positive
signed zero residue and ordinary absolute residue, found the Section 1
certificate at `M=66,c=1` after 655 common-unit candidates and 64 full
row assignments. The planned cap was 2500 and the scan stopped immediately
on success. No nonexistence result is inferred from this scan. The exact
certificate and uniform proof make its search order immaterial.

The following compact `Fraction` check passed for eight prime controls.
It is supplementary arithmetic evidence; the uniform result is proved in
Section 3 and does not depend on these finitely many values. No full build
or source change was needed for this manuscript audit.

```python
from fractions import Fraction as F
from math import ceil, gcd

for N in (7, 11, 13, 17, 19, 23, 29, 31):
    V = tuple(range(1, N-2)) + (N, 2*N)
    M = ceil(F(N*N*(N-3), 3))
    L, H, B = N, 2*N, N-3
    assert len(V) == N-1 and gcd(M, N) == 1
    assert H < (N-1)*L
    assert ((N-1)*L-H)*M >= N*H*L
    assert (L-B)*M >= N*B*L
    r0, s = 2, N-1
    assert all((r0+s)*i % N == i for i in range(1, N-2))
    r = ceil(F(M*r0, N) + F(M, N*L))
    beta, D = N*r-M*r0, N*M
    n = s*M+N*r
    residues = tuple(v*n % D for v in V)
    assert all(M < x < (N-1)*M for x in residues)
    assert min(min(F(v, N-2) % 1, F(-v, N-2) % 1)
               for v in V) == F(1, N-2)
    if N == 7:
        assert (M, r, beta, n, D) == (66, 21, 15, 543, 462)
        assert residues == (81, 162, 243, 324, 105, 210)
        assert F(n % D, D) == F(27, 154)
        assert F(min(min(x, D-x) for x in residues), D) == F(27, 154)
print("8 exact family controls passed")
```
