# An elementary obstruction to the enlarged coarse grid union

Status: complete manuscript derivation, 2026-09-05; final independent review
pending. The proof below is independent of the all-modulus engine's negative
answer. A small exact rational computation checks the displayed linear table;
the final contradictions are elementary inequalities.

**Theorem.** For `N=7`, the distinct primitive six-speed tuple

```text
V=(2,3,4,7,14,9)
```

has no normalization in A, B, coarse one-zero C, or robust multiple-zero R,
for any positive external modulus, common modular unit and its permitted
integer lift, coordinate permutation, or independent coordinate signs.

Nevertheless `t=1/5` is a strict original witness, with minimum circle
distance `1/5>1/7`. This is an obstruction to the stated coarse
normalization contracts, not a disproof of LRC or of all affine methods.

## 1. Exact scope and two useful consequences of R

Use the A/B/R residue predicates in `research/astra-union-supply-audit.md`.
For R, every selected positive signed residue is either an ordinary base
`a_i` not divisible by 7, or a zero base `A_j` divisible by 7. There is
at least one zero row. Put `L=min A_j,H=max A_j`. The required conditions
include

```text
0<a_i<L,       H<6*L,
7*H*L <= (6*L-H)*M,
7*a_i*L <= (L-a_i)*M.                                    (R)
```

The corresponding actual zero-row speeds must also be divisible by 7.
The proof will already exclude the residue conditions, so it imposes no
additional restriction on these actual offsets or on common lifts.
In particular it does not assume that the common lift is a unit modulo 7.

Every zero base satisfies the stronger bound

```text
A_j/M <= H/M <= 5/7.                                     (10)
```

Indeed `H>=L>0`, so
`7HL <= (6L-H)M <= 5LM`; cancel `L`. Write `lambda=L/M>0` and
`rho=a_i/M`. The ordinary inequality says
`rho*(1+7lambda)<=lambda`. Since `lambda<=5/7`,

```text
rho <= lambda/(1+7lambda) <= 5/42.                         (11)
```

The final comparison is exactly `7lambda<=5` after multiplication by
positive denominators. Set `Z=5/7` and `E=5/42` for these two bounds.
They are non-strict: all permitted equality cases remain in the argument.

All bases are less than `M`, so `M=1` is impossible. For a modular unit
`c`, replace it by `M-c` and flip all signs if necessary, leaving the set
of signed residue options unchanged. Put

```text
w=min(c,M-c),       x=w/M.
```

Then `0<x<=1/2`, and `gcd(w,M)=1`. The endpoint `x=1/2` has zero residue
at speed 2 and is impossible. More generally any `x` with some `v*x` an
integer is impossible: both signed residues for that coordinate vanish.
In the rest of the proof `0<x<1/2`, excluding all such velocity boundaries.

## 2. Eight arithmetic classes and a five-row lookup

If `7` does not divide `M`, let

```text
kappa = (w mod 7)*(M mod 7)^(-1) in F_7,
```

represented by `0,1,...,6`. If `7|M`, write `kappa=infinity`; then
`7` does not divide `w`. This represents every possible pair of numerator
and denominator classes of a modular unit, including a numerator divisible
by 7 and a denominator divisible by 7.

For a speed `v`, let `q=floor(v*x)`. Its positive and negative normalized
residue options are

```text
f_plus=v*x-q,       f_minus=q+1-v*x.
```

Both lie in `(0,1)` away from velocity boundaries. For finite `kappa`,
the positive option is a zero base exactly when `v*kappa=q mod 7`;
the negative option is zero exactly when `v*kappa=q+1 mod 7`.
In the infinity class, either sign is zero exactly when `7|v`.

Thus a necessary row test is simply: a zero option must be at most `Z`,
and an ordinary option must be at most `E`. These are linear inequalities
in `x`. For the three core speeds 2,3,4 the zero-option lookup is:

| Speed | Range of x | q | kappa making + zero | kappa making - zero |
| --- | --- | --- | --- | --- |
| 2 | `(0,1/2)` | 0 | 0 | 4 |
| 3 | `(0,1/3)` | 0 | 0 | 5 |
| 3 | `(1/3,1/2)` | 1 | 5 | 3 |
| 4 | `(0,1/4)` | 0 | 0 | 2 |
| 4 | `(1/4,1/2)` | 1 | 2 | 4 |

Every option not marked zero is ordinary. In the infinity class all
options in this table are ordinary. No projective scaling of the actual
real ratio is performed: only the divisibility test is normalized by the
nonzero denominator class.

## 3. The small core table

Intersecting the row bounds for 2,3,4 yields the following enclosures.
All velocity boundaries remain excluded even if they lie in a displayed
closed interval. The table states necessary enclosures, so it need not
list those excluded points repeatedly.

| kappa | After rows 2 and 3 | After row 4 as well |
| --- | --- | --- |
| 0 | `(0,5/21]` or `[37/126,5/14]` | `(0,5/28]` or `[37/168,5/21]` |
| 1,2,6,infinity | `(0,5/126]` | `(0,5/168]` |
| 3,5 | `(0,5/126]` or `[37/84,1/2)` | `(0,5/168]` or `[79/168,1/2)` |
| 4 | `(0,5/126]` or `[37/126,47/126]` | `(0,5/168]` or `[9/28,47/126]` |

Here are explicit checks of the interval arithmetic, in addition to the
lookup itself. Ordinary bounds for a speed `v` are the intervals within
`E/v` of the points `j/v`. A zero option instead extends its corresponding
one-sided interval to length `Z/v`.

For `kappa=0`, row 2 permits `x<=5/14` or `x>=37/84`. Row 3 permits
`x<=5/21` or `37/126<=x<=47/126`; the upper row-2 interval is therefore
lost. Row 4 permits

```text
(0,5/28] union [37/168,47/168] union [79/168,1/2),
```

which gives the first row of the table by intersection.

For `kappa=1,2,6,infinity`, rows 2 and 3 are ordinary. The inequalities
`||2x||,||3x||<=E`, with `E<1/6`, force `x<=E/3=5/126`:
the alternative from row 2 is `x>5/12`, where `3x` has distance at least
`1/4>E` from the integers. In the small interval, row 3 is unwrapped.
Row 4 is ordinary except for possible zero options in class 2; that
class's first zero interval starts at `1/14>5/126`. Thus row 4 sharpens
the bound to `x<=E/4=5/168` in all four classes.

For `kappa=3,5`, row 2 is ordinary. Applying the row-3 lookup leaves
`x<=5/126` or `x>=37/84`. Row 4 is ordinary and its two remaining
intervals give `x<=5/168` or `x>=79/168`.

For `kappa=4`, row 2 permits `x<=5/84` or `x>=1/7`; row 3 is ordinary.
Their intersection is the displayed two-interval enclosure. Row 4 permits

```text
(0,5/168] union [37/168,47/168] union [9/28,1/2),
```

giving the last row of the table. This derives the entire table using
linear inequalities with rational endpoints, including non-strict bounds.

## 4. Every nonzero class is impossible

First remove the extra intervals in classes 3,5,4 using speed 7.
For any finite `kappa`, its zero-option test depends only on
`q=floor(7x)`, because `7*kappa=0 mod 7`.

If `79/168<=x<1/2`, then
`79/24<=7x<7/2`, so `q=3`. Both signs are ordinary and their distances
are at least `7/24>E` or greater; neither option can satisfy the bound.
If `9/28<=x<=47/126`, then `9/4<=7x<=47/18`, so `q=2`.
Both options are ordinary; the positive fractional part is at least
`1/4>E` and the negative at least `7/18>E`. This removes the class-4
extra interval as well.

Consequently every finite nonzero `kappa`, and the infinity class, is
forced into

```text
0<x<=5/168.                                               (12)
```

Speed 7 must now use its positive zero option `7x`. For finite classes
the negative option is ordinary and is at least `19/24>E`; for the
infinity class it is zero but still at least `19/24>Z`. Hence that
negative sign is excluded in both external-modulus regimes.

Speed 9, on the other hand, must be ordinary with positive option `9x`.
For a finite nonzero class, `9*kappa=2*kappa` is nonzero, so the positive
option is ordinary. The negative option is at least

```text
1-9*(5/168)=41/56 > 5/7=Z,
```

and is excluded whether its slope is zero or nonzero. In the infinity
class speed 9 is also ordinary and its negative sign fails the same bound.
But (R) requires every ordinary base to be smaller than every zero base.
It would require `9x < L/M <= 7x`, impossible for `x>0`.

This treats every class other than `kappa=0`, in particular `7|M`.

## 5. The remaining class kappa=0

Start from the first row of the core table. In its secondary interval
`37/168<=x<=5/21`, speed 7 has `37/24<=7x<=5/3` and `q=1`.
Both options are ordinary, each larger than `E`, so that interval fails.
In the remaining interval `0<x<=5/28`, the speed-7 row test leaves

```text
J7=(0,5/49] union [37/294,47/294].                          (13)
```

Indeed the positive zero option below `x=1/7` gives `7x<=5/7`;
the ordinary options near `7x=1` give `|7x-1|<=5/42`.

Apply speed 9. On the second interval of (13),
`111/98<=9x<=141/98`, so `q=1`; both ordinary options exceed `E`
(the smaller possible lower bound is `13/98>E`). On the first interval,
`0<9x<1`; its positive option is zero and its negative option ordinary.
The resulting enclosure is

```text
J79=(0,5/63] union [37/378,5/49].                           (14)
```

Apply speed 14. On the secondary interval of (14),
`37/27<=14x<=10/7`, so `q=1`, both options are ordinary, and both
exceed `E`. On its first interval, the row-14 positive zero option below
`x=1/14` gives `x<=5/98`. The ordinary options around `14x=1` give
`|14x-1|<=5/42`. After intersecting with `x<=5/63`, only

```text
I:   0<x<=5/98;
II:  37/588<=x<=5/63,       x!=1/14                         (15)
```

remain. The missing central point has actual residue zero, so it cannot
be supplied by choosing the other sign.

In I every speed has `0<v*x<=5/7<1`. Every positive option is zero and
every negative option is at least `2/7>E`, so every sign is forced positive
and every row is zero. Therefore

```text
L/M=2x,       H/M=14x,       H/L=7,
```

contradicting the required strict span `H<6L`.

In II, speeds `2,3,4,7,9` all have positive zero options; their negative
options are at least `2/7>E`. These five options are forced, while speed
14 is ordinary, with negative sign below `1/14` and positive sign above
it. In particular

```text
L/M=2x,       H/M=9x.
```

The genuine zero size inequality in (R), beyond the linear relaxation,
then gives

```text
9x*(1+14x) <= 12x,
1+14x <= 4/3,
x <= 1/42=14/588.
```

This contradicts `x>=37/588`. It excludes the closed endpoints of II as
well as its interior. All real possibilities in every arithmetic class
are now excluded; there is no remaining rational-lifting or isolated-point
case. This completes the independent all-modulus obstruction for R.

## 6. Completing the union statement and its exact limitation

A and B are already obstructed by the smaller core `(2,3,7)`; here is
the short specialization of the accepted earlier proof. Under A's bound,
the normalized absolute residues for speeds 2 and 3 are less than `1/6`.
Reflection and the speed-2 bound put `x<1/12` or `x>5/12`; the latter
contradicts speed 3. The speed-3 bound then gives `x<1/18`. Thus `7x<1/2`
and the speed-7 absolute base is `7w`, contrary to its required
nondivisibility by 7.

For B, the positive ordinary-base bound implies `M>6`. Taking actual
pivot 2 or 3 would require `M|2` or `M|3`, impossible. Taking pivot 7
violates the pivot's required nondivisibility by 7. Every other pivot
leaves the core `(2,3,7)` ordinary and is excluded as above. These
arguments already allow signs, common unit multipliers, and positive
Nat representatives after permitted `7M` additions. Coarse C is exactly
R with one zero label, so the R obstruction includes it.

This rules out the enlarged coarse union uniformly in `M`. It also
refutes the proposed implication that every strict original witness
supplies a robust mixed R normalization: this tuple has a strict witness
but no R normalization even when `7|M` is allowed. It does not obstruct
arbitrary exact residue-band arguments or later wrapped zero bands.

For a concrete exact-band escape, keep the original speeds and bases and
take

```text
N=7, M=35, b=1, all signs positive,
s=1, r=2, r0=0, beta=7*r-M*r0=14,
t=s/N+r/M=1/5.
```

In tuple order, `h=(s*V+r0*V) mod 7=(2,3,4,0,0,2)` and

```text
h*M+V*beta=(98,147,196,98,196,196),
```

all within `[M,6M]=[35,210]`. The coarse certificate loses this simple
witness because the ordinary base 9 exceeds the zero minimum 7, and
the displayed representation also uses `r0=0`. This verifies a precise
limit of the coarse sufficient inequalities; it is not an independent
new supply mechanism from arbitrary exact-band assumptions.

## 7. Small independent rational table checker

The following verifier does not import the engine or fixed checker. It
checks all `3*8*8=192` choices of core cell, arithmetic class, and signs
for speeds 2,3,4. Each case is a real interval intersected with linear
inequalities using exact rational endpoints and strictness flags. Its
conclusion is containment in the small core table, not a bounded search
over moduli. The rest of the proof above eliminates the table's entire
real enclosures algebraically.

```python
from fractions import Fraction as F
from itertools import product

def intersect(I, a, b, strict=False):
    # Intersect I with a*x+b >= 0 (or >0), preserving closed endpoints.
    lo, lo_open, hi, hi_open = I
    if a == 0:
        return None if b < 0 or (strict and b == 0) else I
    endpoint = -b/a
    if a > 0:
        if endpoint > lo:
            lo, lo_open = endpoint, strict
        elif endpoint == lo:
            lo_open |= strict
    else:
        if endpoint < hi:
            hi, hi_open = endpoint, strict
        elif endpoint == hi:
            hi_open |= strict
    if lo > hi or (lo == hi and (lo_open or hi_open)):
        return None
    return lo, lo_open, hi, hi_open

enclosures = {
    0: [(F(0),F(5,28)), (F(37,168),F(5,21))],
    1: [(F(0),F(5,168))],
    2: [(F(0),F(5,168))],
    3: [(F(0),F(5,168)), (F(79,168),F(1,2))],
    4: [(F(0),F(5,168)), (F(9,28),F(47,126))],
    5: [(F(0),F(5,168)), (F(79,168),F(1,2))],
    6: [(F(0),F(5,168))],
    None: [(F(0),F(5,168))],
}
cuts = (F(0), F(1,4), F(1,3), F(1,2))
checked = 0
for left, right in zip(cuts, cuts[1:]):
    for kappa in enclosures:
        rows = []
        for v in (2,3,4):
            q = (v*(left+right)/2).__floor__()
            plus_zero = v % 7 == 0 if kappa is None else (v*kappa-q) % 7 == 0
            minus_zero = v % 7 == 0 if kappa is None else (v*kappa-q-1) % 7 == 0
            rows.append(((F(v),F(-q),plus_zero), (F(-v),F(q+1),minus_zero)))
        for assignment in product(*rows):
            checked += 1
            interval = (left, True, right, True)
            for a, b, zero in assignment:
                interval = intersect(interval, -a, (F(5,7) if zero else F(5,42))-b)
                if interval is None:
                    break
            if interval is not None:
                lo, _, hi, _ = interval
                assert any(L <= lo and hi <= H for L,H in enclosures[kappa])
assert checked == 192

V=(2,3,4,7,14,9)
assert min(min(F(v,5)%1,F(-v,5)%1) for v in V) == F(1,5)
h=tuple(v%7 for v in V)
bands=tuple(k*35+v*14 for k,v in zip(h,V))
assert bands == (98,147,196,98,196,196)
assert all(35 <= z <= 210 for z in bands)
print("192 exact core cases, strict witness, and exact-band escape passed")
```

## 8. Provenance and remaining formalization

Current project workflow/policy/state were read; workflow structural
validation passed. Only this manuscript was edited. No Lean cache was
restored, no source engine was changed, and no new family search was run.

Source evidence read:

```text
research/astra-grid-supply-audit.md
  7caa2b660942cacb92382bc9cd661b83647af85f212b71589d162e6734bb22c1
research/astra-normalization-decision.md
  6e3a76646f4f93dec9420a4285ffbdc8848b4437dc607a6485a555f7c7c4d89f
scripts/grid_normalization_decision.py (frozen motivating computation)
  393cdc38eee2fdead8a3ef47bdad599917a5319e407d768b197c5997ffd8e5d1
```

The engine's negative motivated this one-candidate audit but is not a premise
of the proof. Formalization can follow the eight arithmetic classes, the
five-row zero-sign lookup, the small linear core table, and the three final
contradictions (`9x<7x`, `14x<12x`, and `x<=1/42<37/588`). None requires a
general algebraic-number backend or enumeration over external moduli.
This manuscript is not itself a Lean theorem of the obstruction, and the
canonical LRC completion gate remains unmet.
