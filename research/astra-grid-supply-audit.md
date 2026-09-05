# The three proved grid normalizations do not cover every primitive tuple

Status: complete manuscript obstruction, exact negative control, and bounded
checks; independent review pending. No Lean theorem of this obstruction is
claimed. Worker `/root/affine_grid`, requested Astra xhigh; independently
observed runtime model metadata is unavailable. Owned file: this note only.
Base checkpoint: `5c24b77` plus the compiled pass-3 grid modules. Current
project policy/state were read and workflow structural validation passed.

**Result.** For every odd prime `N>=7`, the primitive, distinct `N-1`-speed
tuple

```text
V_N = (2,3,...,N-3, (N-2)*(N-1), N, 2*N)
```

has no normalization covered by Theorem A, Theorem B, or the compiled coarse
one-zero Theorem C, even after arbitrary coordinate permutations, independent
signs, any positive external modulus, and any common modular unit. The
obstruction is uniform in the modulus. Nevertheless this family has elementary
explicit LRC witnesses, given below. This rejects universality of those three
normalization contracts, **not LRC** or all affine-grid methods.

The proposed smaller core `(2,3,N,2*N)` is **not** sufficient to obstruct C.
A valid `N=11` normalization uses a multiplier divisible by `N`; excluding
such lifts would have hidden this counterexample. Adding speed 4 supplies the
uniform obstruction.

## 1. Exact contracts being audited

The imported compiled declarations were inspected with a read-only
`lake env lean --stdin` probe containing their `#check` commands. Their source
contracts were also read directly. No build or Lean source edit was performed.

| Name | Source SHA-256 |
|---|---|
| `affine_grid_full_size_witness` (A) | `9badca0a324c37a2f9a57c860ab83f9da6e7b8aac922f52e4985352ec57bee54` |
| `affine_grid_pivot_witness` (B) | `ea7f4c3058f486dd29c3624d914251d37b9f85d24cca2a7152e0e796a9dc46a8` |
| `affine_grid_one_zero_witness` (coarse C) | `7bcec521f38f065e03c2f112e4af91f20b3e05b0cedcbc1e6f8f49cca350d5c4` |

The mathematical premises relevant to normalization are:

* **A:** all `N-1` speeds have positive bases `a_i`, with `N` not dividing
  any base, `(N-1)*a_i<M`, and congruent speeds modulo `M`. At least one
  transformed speed is not divisible by `N`.
* **B:** one original speed is a multiple of `M` and is not divisible by
  `N`; the other `N-2` speeds have bases satisfying A's same small-base
  conditions.
* **C:** one original distinguished speed and its positive base `A` are
  both divisible by `N` and congruent modulo `M`. The other `N-2` bases
  satisfy `0<a_i<A`, `N` not dividing `a_i`, and

  ```text
  N*A <= (N-2)*M,
  N*a_i*A <= (A-a_i)*M.
  ```

The last inequality and `a_i,M,A>0` imply

```text
N*a_i*A <= (A-a_i)*M < A*M,       hence a_i < M/N.          (1)
```

This strict ordinary-base consequence is essential. The distinguished base
may be much larger: `A<=(N-2)*M/N`. It must not be subjected to (1).
All three conclusions concern the full original `N-1` speeds at threshold
`1/N`. The stronger pair-dependent and multiple-zero manuscript variants
are outside this audit.

### Common multipliers and actual offsets

Let `c` be any unit modulo `M`. Choose a common integer lift `b≡c (mod M)`
and signs `epsilon_i` in `{1,-1}`. Bases must be congruent to
`epsilon_i*b*V_i` modulo `M`. Adding independent multiples of `N*M` to
these transformed speeds preserves their grid phases and allows positive Nat
representatives when a sign gives a negative integer.

A's nonzero-offset premise forces `N` not to divide `b`. B's actual pivot
nondivisibility likewise forces `N` not to divide `b`. In C this restriction
is absent: when `N` does not divide `M`, one may choose `b` divisible by
`N` by CRT, making **every** transformed offset zero. The C obstruction
below uses only ordinary-base geometry and imposes no extra condition on b.

For B, a transformed original coordinate is divisible by `M` exactly when
the original coordinate is divisible by `M`, because c is a unit modulo M.
Signs and additions of `N*M` do not change this fact.

## 2. Three elementary small-arc facts

Write `||y||` for distance to the nearest integer. For a given multiplier
define the nonnegative absolute residue

```text
w = min(c mod M, (-c) mod M),      x=w/M in [0,1/2].
```

If an ordinary base is positive and smaller than `M/2`, it is forced to be
the unique absolute residue: `a_v/M=||v*x||`, regardless of its sign choice.
If `w=0`, no coordinate can have a positive ordinary base, so all cases
requiring such bases already fail. Below assume `w>0`, hence `x>0`.

**Fact 23.** If `0<epsilon<=1/6` and
`||2*x||,||3*x||<epsilon`, then `x<epsilon/3`.

Proof. The speed-2 condition puts x either below `epsilon/2` or above
`(1-epsilon)/2`. In the upper branch, `3*x` lies in `(5/4,3/2]`, so its
distance to the nearest integer is greater than `1/4`, a contradiction.
In the lower branch `3*x<3*epsilon/2<=1/4`, so the speed-3 condition is
exactly `3*x<epsilon`.

**Fact 34.** If `0<epsilon<=1/7` and
`||3*x||,||4*x||<epsilon`, then `x<epsilon/4`.

Proof. Since `0<3*x<=3/2`, its good small arcs are `3*x<epsilon` or
`|3*x-1|<epsilon`. In the second branch

```text
4*(1-epsilon)/3 < 4*x < 4*(1+epsilon)/3,
4*x-1 > (1-4*epsilon)/3 >= epsilon,
2-4*x > (2-4*epsilon)/3 >= epsilon.
```

Here `1<4*x<2`, so both potential nearest integers are too far away.
Thus `x<epsilon/3`; now `4*x<4/21<1/2`, and its small-arc condition
forces `x<epsilon/4`.

**Fact 24.** If `0<epsilon<=1/7` and
`||2*x||,||4*x||<epsilon`, then

```text
x<epsilon/4       or       x>1/2-epsilon/4.
```

Proof. Speed 2 first gives `x<epsilon/2` or
`delta=1/2-x<epsilon/2`. In the first branch `4*x<2*epsilon<1/2`;
in the second branch `4*x=2-4*delta` with `0<=4*delta<1/2`.
The speed-4 condition therefore sharpens the corresponding quantity to
`4*x<epsilon` or `4*delta<epsilon`.

Every inequality here treats endpoints correctly. In particular the strict
ordinary-base bounds in (1) are what permit strict small-arc inequalities.

## 3. A and B are blocked by the smaller core `(2,3,N)`

Assume `N>=7` and that all three core bases satisfy A's requirements.
Put `epsilon=1/(N-1)<=1/6`. Fact 23 gives `x<epsilon/3`, so

```text
N*x < N/(3*(N-1)) <= 7/18 < 1/2.
```

There is no wrap in the absolute residue for speed N. Consequently
`a_N=N*w`, contrary to its required nondivisibility by N. This proves the
A obstruction for every external modulus and every allowed normalization.

For B, the positive ordinary bases imply `M>N-1`, hence `M>=N>=7`.
Selecting speed 2 or 3 as the actual pivot would force `M|2` or `M|3`,
which is impossible. Selecting speed N violates the actual pivot's
nondivisibility by N, even after signs and a common multiplier. Every
other pivot choice leaves `(2,3,N)` among the ordinary coordinates, where
the preceding argument applies. Thus B is also blocked. This reasoning
does not require the pivot to be the largest speed.

## 4. Adding speed 4 blocks C for every distinguished label

**Core obstruction.** For every odd integer `N>=7`, every positive modulus
M and every integer multiplier c, the five distinct speeds

```text
S_N = (2,3,4,N,2*N)
```

cannot have all but one coordinate represented by bases satisfying

```text
0<a_v<M/N,     N does not divide a_v,
a_v == +/-c*v (mod M).                                    (O)
```

This statement is stronger than needed for C. It does not constrain the
exceptional base at all, and it even allows nonunit c. If `w=0`, every
ordinary absolute residue vanishes, immediately contradicting (O).
Otherwise put `epsilon=1/N<=1/7`. Consider the exceptional label:

1. **Label 2.** Speeds 3,4,N are ordinary. Fact 34 gives
   `x<1/(4*N)`. Thus `N*x<1/4` and `a_N=N*w`, contradicting (O).
2. **Label 3.** Speeds 2,4,N are ordinary. Fact 24 gives either
   `x<1/(4*N)` or `delta=1/2-x<1/(4*N)`. The first case again gives
   `a_N=N*w`. In the second case, oddness of N makes `N/2` a half-integer;
   since `0<=N*delta<1/4`,

   ```text
   ||N*x|| = 1/2-N*delta > 1/4 > 1/N,
   ```

   contradicting the speed-N small-base condition.
3. **Label N.** Speeds 2,3,2N are ordinary. Fact 23 gives `x<1/(3*N)`,
   hence `0<2*N*x<2/3`. The condition `||2*N*x||<1/N` cannot put
   this value near 1, because `1-1/N>=6/7>2/3`. It therefore requires
   `2*N*x<1/N<1/2`, so `a_(2N)=2*N*w`, again divisible by N.
4. **Any other exceptional label**, including 4, 2N, or a label outside
   the core. Then 2,3,N remain ordinary. Fact 23 gives `N*x<1/3<1/2`,
   so `a_N=N*w` contradicts (O).

All distinguished labels are covered. In particular, no assumption that
the common lift is a unit modulo N occurs in this proof.

A compact exact arithmetic formulation is useful for future formalization.
For `rho_M(y)=min(y mod M,(-y) mod M)`, define a core coordinate bad when

```text
rho_M(c*v)=0  or  N*rho_M(c*v)>=M  or  N divides rho_M(c*v).
```

For odd `N>=7`, positive M, and every integer c, at least **two** of the
five core coordinates are bad. Otherwise the unique bad coordinate, or
any coordinate when none is bad, could be designated exceptional, contrary
to the argument above. This is an obstruction to the coarse C contract;
the pair-dependent exact-size and multiple-zero versions need separate audits.

## 5. Negative control: the four-speed core can enter C

Take

```text
N=11,  M=336,  c=b=121,  distinguished original speed=2,
A=242,  ordinary bases for (3,11,22)=(27,13,26),
signs for (2,3,11,22)=(+,+,-,-).
```

The multiplier is a unit modulo 336 but is divisible by 11. Its signed
residues are exactly the displayed bases. The coarse inequalities hold:

```text
N*A = 2662 <= 3024 = (N-2)*M,
N*27*A = 71874 <= 72240 = (A-27)*M,
N*13*A = 34606 <= 76944 = (A-13)*M,
N*26*A = 69212 <= 72576 = (A-26)*M.
```

The distinguished base is a positive multiple of 11; every ordinary base
is positive, smaller than A, and nonzero modulo 11. Because b is divisible
by 11, every original transformed offset is zero, including the distinguished
one. This is allowed by C.

To make the coordinate count exact, this core embeds in the following
distinct primitive `N-1=10`-speed original tuple:

```text
(2,3,11,22,339,675,1011,1347,1683,2019).
```

The last six speeds are `3+j*M`, `j=1,...,6`; after multiplication by b
each has ordinary base 27. Positive Nat representatives for the first four
transformed speeds are

```text
(242,363,2365,1034)
 = (121*2,121*3,-121*11+11*336,-121*22+11*336).
```

The last six transformed speeds are simply their positive multiples by 121.
All ten offsets are zero modulo 11, and the exact compiled Nat C contract
applies to these representatives.

An explicit affine pair is `r0=s=1`. Shifted rounding gives
`r=31`, `beta=5`, `n=677`, denominator `3696`. Returning through the
common multiplier gives original time

```text
121*677/3696 mod 1 = 605/3696 = 55/336.
```

Its minimum circle distance on the original ten-speed tuple is `67/336`,
which exceeds `1/11`. Thus this is an actual full-size positive control,
not an application with too few coordinates or a discarded dummy.

A second smaller-core control found by the exact scan is
`N=17,M=387,c=136,A=272`, distinguished speed 2 and ordinary bases
`(21,10,20)` for `(3,17,34)` with signs `(+,-,-)`. The first control
already suffices to refute the proposed uniform four-speed obstruction.

## 6. Full escaping family, with explicit ordinary witnesses

For every odd prime `N>=7`, `V_N` has exactly `N-1` distinct positive
entries: `2,...,N-3` contribute `N-4` entries, followed by three more.
The product row `(N-2)*(N-1)` is greater than `2*N` for `N>=7`.
The presence of speeds 2 and 3 makes the tuple primitive.

Every denominator `2,...,N` is blocked in the simple denominator-escape
test: values up to N-3 occur as speeds, N-2 and N-1 divide the product
row, and N divides two speeds. The full tuple contains the five-speed core,
so Sections 3 and 4 exclude all A/B/coarse-C normalizations.

Nonetheless, for prime N=7 and every prime `N>=13`, take

```text
t=1/(N+2).
```

Modulo `Q=N+2`, the ordinary speeds `2,...,N-3` stay at least 2 away
from either endpoint. Speed N has distance 2 and speed 2N has distance 4.
The product row is congruent to 12. For N=7 its residue modulo 9 is 3;
for N>=13, `Q>=15`, so its distance is `min(12,Q-12)>=3`.
The minimum distance is therefore exactly `2/(N+2)>1/N`.

The only remaining prime is N=11. There the tuple is
`(2,3,4,5,6,7,8,90,11,22)` and `t=1/14` works: the residue distances
are `(2,3,4,5,6,7,6,6,3,6)`, with minimum `1/7>1/11`.
This independently verifies the explicit witnesses also supplied by the
parent during the audit.

For instance, the smallest escaping family member is

```text
N=7,  V_7=(2,3,4,30,7,14),  t=1/9,
distances=(2,3,4,3,2,4)/9.
```

Hence the new obstruction detects a limitation of the normalization classes,
not an intrinsically difficult LRC instance. These simple other-grid witnesses
must not be presented as a proof that every residual tuple has such a witness.

## 7. Verification and precise disposition

Fresh exact Python checks used only integers and rational fractions:

* For `N=7,11,13,17,19`, every modulus `2<=M<=1000`, and every common
  unit multiplier: **1,520,955** core normalizations checked. The five-speed
  core always had at least two bad ordinary coordinates. Bad-count histogram:
  `{2:90030, 3:224880, 4:413374, 5:792671}`.
* In that same domain, **27,610** `(2,3,N)` cores met the strictly compressed
  A bound. Every one had its speed-N base divisible by N.
* The complete escaping family was checked at all **22** primes from 7 to 97:
  exact length, distinctness, primitivity, every small-denominator block,
  and the displayed rational witness all passed.
* The full ten-coordinate N=11 positive control passed every coarse C input,
  the transformed-grid inequalities, and the original witness readback.

These checks corroborate the uniform proofs; no all-modulus statement here
depends on a finite search. A read-only import/#check probe inspected the three
compiled contracts. No Lean source edits, workflow edits, full builds, cache
cleanup, external model sessions, or new agents were used in this audit.

**Disposition:** the union of A, B, and compiled coarse C is not a uniform
supply mechanism. Enlarging the external modulus, choosing another distinguished
label, changing coordinate signs, or permitting the zero-offset common lift
does not repair the displayed escaping family. The missing step must handle
representations outside these contracts or introduce another witness mechanism.
No conclusion is drawn about the simultaneous multiple-zero class, the exact
pair-dependent correction contract, or arbitrary tuples beyond this proved
obstruction. Those are separate bounded research questions.

## 8. Compact reproducer

```python
from math import gcd
from collections import Counter
from fractions import Fraction as F

def rho(M, x): return min(x % M, (-x) % M)

counts = Counter()
histogram = Counter()
compressed = 0
for N in (7, 11, 13, 17, 19):
    for M in range(2, 1001):
        for c in range(1, M):
            if gcd(c, M) != 1: continue
            counts[N] += 1
            a = [rho(M, c*v) for v in (2, 3, 4, N, 2*N)]
            bad = sum(not (0 < x and N*x < M and x % N) for x in a)
            assert bad >= 2
            histogram[bad] += 1
            core = [a[0], a[1], a[3]]
            if min(core) > 0 and (N-1)*max(core) < M:
                compressed += 1
                assert core[2] % N == 0
assert sum(counts.values()) == 1520955
assert histogram == {2:90030, 3:224880, 4:413374, 5:792671}
assert compressed == 27610

primes = (7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97)
for N in primes:
    U = list(range(2, N-2)) + [(N-2)*(N-1), N, 2*N]
    Q = 14 if N == 11 else N+2
    assert len(U) == len(set(U)) == N-1 and gcd(*U) == 1
    assert all(any(x % d == 0 for x in U) for d in range(2, N+1))
    assert N*min(rho(Q, x) for x in U) >= Q

N, M, c, A = 11, 336, 121, 242
U = [2, 3, 11, 22] + [3+j*M for j in range(1, 7)]
a = [27, 13, 26] + [27]*6
V = [242, 363, 2365, 1034] + [c*x for x in U[4:]]
assert len(U) == len(set(U)) == N-1 and gcd(*U) == 1
assert gcd(c, M) == 1 and c % N == 0 and A % N == 0
assert N*A <= (N-2)*M
assert all(0 < x < A and x % N and N*x*A <= (A-x)*M for x in a)
assert all(x % N == 0 for x in V)
assert [x % M for x in V] == [A]+a
n, D = 677, N*M
assert all(rho(D, n*x) >= M for x in V)
original_n = c*n % D
assert F(original_n, D) == F(55, 336)
assert min(F(rho(D, original_n*x), D) for x in U) == F(67, 336)
print('All grid-supply audit checks passed.')
```
