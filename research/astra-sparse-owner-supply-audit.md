# Sparse lower-owner supply: N=9 proved, uniform contract open

Task `/root/affine_grid-sparse-owner-supply-audit`, requested Astra/xhigh,
2026-09-05, source main `7a3ea75d1221b815a46b97f2b487807e48375649`.
The current workflow, policy, and active state were read and the structural
validator passed. Only this note was edited. No Lean/cache/Git/state changes,
external model session, or background search were used.

**Disposition:** the proposed all-N contract is neither proved nor refuted.
It is not already supplied by the compiled owner budget. This audit proves
the complete first new case, **four distinct lower owners at N=9, at arbitrary
pivot height**, by exact arithmetic. The manuscript proof awaits independent
review and Lean formalization. A tempting uniform extrapolation of its
one-owner remainder bound is false at N=15; that failure does not refute the
original sparse noncover contract. No LRC or literature-priority claim follows.

## 1. Exact target and inherited coverage

Let `N>=4`, `p>0`, and C be a finite labelled set with an injective map
`d:C -> {1,...,p-1}`. Write `c=|C|` and use the repository's literal sets

```text
R={0<=r<Np : N does not divide r}, |R|=(N-1)p,
B_d={r in R : min(rd mod Np, -rd mod Np)<p},
Z_d={r in R : rd=0 mod Np}.
```

The audited target is `2c<N => union_C B_d != R`, equivalently a residue good
for these owners and the **actual pivot p**. The strict `<p` definition retains
the closed good boundary. It protects c+1 moving speeds at threshold 1/N;
it does not protect unlisted speeds or change N to match the partial family.

`OwnerKernelCover.lean` already supplies noncover when a labelled zero-kernel
dominating set has size q satisfying

```text
(N-2)q <= (N+1)(N-2c).                                  (1)
```

This is just its existing budget rearranged. Thus the proposed condition
already works whenever all zero kernels have one common dominator; for even
N it works with at most two dominators at the maximal allowed c. Taking all
owners as representatives recovers `3c<=N+1`. No new supply is claimed for
these cases. In contrast, `N=9,c=4,q=2` already fails (1).

The independently accepted N=7 three-owner manuscript plus (1) treats every
admitted owner count for N<=8. N=9,c=4 is the first unresolved case of this
particular extension; the proof below settles it. At N>=11, four owners already
pass the old all-representatives budget. N=10,c=4 and increasing owner counts
remain outside this audit's proof. A fixed-pivot noncover statement at this
weaker threshold is not supplied just by the kernel equivalence between an
ordinary witness and **some** pivot certificate. No equivalence between the
present sparse contract and unrestricted LRC is asserted.

## 2. N=9: complete arbitrary-height proof

**Theorem.** If `0<a<b<c<d<p`, then some `r in R(9,p)` avoids all four
sets `B_a,B_b,B_c,B_d`. There is no supplied-witness, gcd, divisibility,
maximum-covered-pivot, primitive-family, or height hypothesis.

For any owner put `h=gcd(d,p)`, `P=p/h`, `D=d/h`, `k=gcd(D,9)`.
The existing exact formula gives

```text
|B_d|/p = b(k,P)/P,
b(k,P)=k*(2*floor((P-1)/k)+1)-(2*floor((P-1)/9)+1),
|Z_d|=h*(k-1),   gcd(D,P)=1,   0<D<P.                   (2)
```

Here k is 1, 3, or 9. For k=1, the compiled scalar bound gives
`|B_d|/p<=16/9<2`. For k=3, write `P-1=9q+s`, `0<=s<9`,
and `j=floor(s/3)`. Then `b=16q+6j+2<=2P`, because
`s>=3j`. For k=9 we have `P>=10`, `3 does not divide P`, and
`b=8(2q+1)`, with `q=floor((P-1)/9)>=1`.
Since `P>=9q+1`, the only possibilities for `b>2P` are

```text
(P,D) = (10,9), (11,9), (19,9), (19,18).                 (3)
```

Indeed `q>=3` gives `8(2q+1)<=2(9q+1)`; for q=1 the only
possible P are 10,11, and for q=2 only P=19. The allowed D are
the positive multiples of 9 below P coprime to P. The respective densities
are `12/5`, `24/11`, and `40/19` (twice). All owner densities are at most
`12/5`, either from these calculations or the existing scalar/capacity bounds.

If (3) is absent, each of the four bad sets has size at most 2p. They share
the distinct candidates `1` and `9p-1`, so their union has size at most
their sum minus six, strictly less than `8p=|R|`.

Otherwise choose any owner in (3), call it the star, and put

```text
S=P_star, E=D_star/9, beta=|B_star|/p,
T=(8-beta)/3.
```

We prove that every **other** owner satisfies

```text
|B_d \ B_star| < T*p.                                  (4)
```

The three possible T values are `28/15`, `64/33`, and `112/57`.
Each exceeds 16/9, so zero-free owners satisfy (4) without any overlap.

### Exhaustive list of remaining arithmetic exceptions

Only owners with `b(k,P)/P>=T` require further analysis. The compiled scalar
inequality implies

```text
b(k,P)/P <= 16/9 + 7(k-1)/(9P),
P <= 7(k-1)/(9*(T-16/9)) when b(k,P)/P>=T.               (5)
```

In particular k=3 and k=9 have the respective integer P bounds
`(17,70)`, `(9,38)`, `(8,33)` for the three T values. Evaluating the exact
floor expression (2) in these finite intervals gives the following complete
table. Each listed P permits **every** D with
`0<D<P`, `gcd(D,P)=1`, `gcd(D,9)=k`; the star's identical `(P,D)` is excluded.
There are 37,13,9,9 ordered other-owner cases for the four stars, 68 in total.

| Star (S,E) | k=3 exceptional P | k=9 exceptional P |
| --- | --- | --- |
| (10,1) | 4,7,16 | 11,19,20,28,29,37,38,46,47,55,64 |
| (11,1) | 4,7 | 10,19,20,28,37 |
| (19,1) | 4,7 | 10,11,19,20,28 |
| (19,2) | 4,7 | 10,11,19,20,28 |

The table is small integer arithmetic, not a pivot-height cutoff. The sole
reproducer below regenerates it from (5) and checks every normalized D.
Alternatively divide P-1 by 9 in each of the bounded ranges and solve the
displayed rational comparison on its nine residues. At P=19 the other star
with the same denominator remains in the table and must not be dropped.

### Exact common-period argument, including powers of 3

For a nonempty-zero other owner, let `g=3^v3(p)`. Nonempty Z means
`v3(d)>v3(p)`, so g divides p, d, and the star. Divide this pair of owner
speeds and the pivot by g. Reduction modulo the smaller `9p` preserves
candidate/bad decisions and has g equal fibers, multiplying each remainder
cardinality by g. Thus the pair estimate can be proved assuming `3 does not
divide p`. This argument does not divide an arbitrary zero-free owner: that
case was already handled directly by its scalar bound.

The star's badness now depends only on `r mod S`. For S=10 or 11 it is
`r in {0,1,-1}`; for S=19,E=1 it is `{0,1,-1,2,-2}`; and for
S=19,E=2 it is `{0,1,-1,9,-9}`.

For an other owner write `D=k e`; its badness depends on `r mod(9P/k)`.
Together with the candidate test `9 does not divide r`, it is determined by
`r mod(9P)`. For each such bad candidate class, the lifts modulo `9p` run
uniformly through precisely those star classes modulo S congruent to it
modulo `gcd(S,P)`; this follows by CRT, since `gcd(S,9)=1` and
`lcm(S,P)` divides p. In particular:

- If `gcd(S,P)=1`, the remainder is exactly the star's complementary
  fraction times `|B_d|`.
- If S=10 and `gcd(S,P)=2`, at most four of the five classes of the fixed
  parity avoid the star. Thus the remainder is at most `(4/5)|B_d|`.

These facts count the actual candidate filter. They do not replace it by all
residues or assume p is coprime to anything except 3 after the justified
scaling step.

Now verify (4), grouping all 68 cases by that exact arithmetic structure:

* **Star S=10.** Coprime P give remainder at most
  `(7/10)*(12/5)p=42p/25<28p/15`. Gcd-two exceptions are
  P=4,16 for k=3 and P=28,38,46,64 for k=9. Each has `|B_d|<=2p`,
  so the remainder is at most `8p/5<28p/15`.
  The only other denominators are 20 and 55. At P=20, k=9 forces e=1;
  the bad classes modulo 20 are `0,1,2,18,19`, and only 2,18 avoid the
  star. Each class has `8p/20` candidates, giving remainder `4p/5`.
  At P=55, the zero target `r=0 mod55` already contributes `4p/55`
  candidates inside the star: among its lifts, exactly half have `r=0 mod10`,
  and exactly eight ninths of those survive the candidate exclusion. As
  `|B_d|=104p/55`, its remainder is at most `100p/55=20p/11<28p/15`.
  This last bound holds for every admissible e, because e is a unit modulo 55.
* **Star S=11.** Every other exceptional P is coprime to 11, so the remainder
  is at most `(8/11)*(12/5)p=96p/55<64p/33`.
* **Either star S=19.** For P different from 19, the remainder is at most
  `(14/19)*(12/5)p=168p/95<112p/57`. The two stars of denominator 19
  have three common bad classes, `0,1,-1`, and only two remainder classes.
  The same-period remainder is therefore `16p/19<112p/57`.

This proves (4) for every other owner, at every original p. Consequently

```text
|union B_d| <= |B_star| + sum_(other three) |B_d\B_star|
             < beta*p + 3*T*p = 8p.
```

The candidate complement is nonempty. The full N=9 theorem follows.

## 3. Added supply and the limitation of the mechanism

The proposed Lean interface, not yet present in the repository, is

```lean
theorem fourLowerOwner_noncover_nine
    (p a b c d : Nat) (ha : 0 < a) (hab : a < b)
    (hbc : b < c) (hcd : c < d) (hdp : d < p) :
    ∃ r ∈ pivotCandidates 9 p,
      r ∉ pivotBadResidues 9 p a ∧
      r ∉ pivotBadResidues 9 p b ∧
      r ∉ pivotBadResidues 9 p c ∧
      r ∉ pivotBadResidues 9 p d
```

For N=9 a maximum-covered-pivot internal complete cover therefore needs at
least five owners, and redundancy is vacuous when at most five labels are
covered. Only four owners plus the pivot are protected by this theorem,
not eight arbitrary moving speeds at threshold 1/9.

This extends an a priori sufficient domain of `OwnerKernelCover`. For example

```text
N=9,p=6160, owners=(1,2640,5040,5544),
bad counts=(10950,12320,13440,14784), total=51494,
|R|=49280, safe count=14636, first safe numerator=6162.
```

The three nonempty zero kernels are pairwise undominated, so q=3 and the old
budget reads `101>90`. Even the raw sum minus the common-six-point saving
does not prove noncover. Every denominator 2 through 9 divides a listed
speed or p, so the simple denominator-avoidance test does not settle it.
The owner speeds also need not be a saturated interval or far below p;
existing `SaturatedTopTwo` and `fastRunnerInsertion` do not have the new
statement's hypotheses/conclusion. The final union inequality is existing
certificate machinery; the new arithmetic supply is the uniform proof of (4).

There is a useful but limited general reduction. For fixed odd N>=5 and
`c=(N-1)/2`, any hypothetical cover has an owner with `|B_d|>2p`, since
otherwise the common-pair saving makes `|union B_d|<(N-1)p`. Writing
`Q=floor((P-1)/N)`, the exact formula satisfies

```text
b(k,P) <= 2P+k-3-2Q.
```

Thus a density above 2 forces `k>=4`, `Q<=floor((k-4)/2)`, and
`P<=N*(floor((k-4)/2)+1)`. There are finitely many normalized potential stars
for each fixed N, since `k|N`, `k<=D<P`, and `gcd(D,P)=1`.

The general scalar/capacity bound is
`|B_d|/p<=beta_N=3(N-1)/(N+1)`. A uniform bound for each other remainder
that would suffice for this particular method has threshold

```text
T_N=2(N-1)(N-2)/((N+1)(N-3)),
T_N - 2(N-1)/N = 6(N-1)/(N(N+1)(N-3)) > 0.
```

By the scalar interpolation, rows whose raw density is at least T_N have

```text
P <= (N-2)(k-1)(N+1)(N-3)/(6(N-1)).                     (6)
```

So testing this **sufficient pair-estimate strategy** involves finitely many
reduced pairs for each N. It is not a finite decision procedure for the
original all-owner union claim, nor does it remove the unbounded N quantifier.
The pair estimate itself already fails:

```text
N=15, p=272=lcm(16,17), star=255=15p/16, other=240=15p/17,
|B_star|=714, |B_other|=672, |B_other\B_star|=546,
546/p=273/136 > T_15=91/48.
```

The two coprime periods have three bad star classes out of sixteen, so the
remainder ratio is exactly `(42/17)*(13/16)`. The excess is `91/816`.
The star attains beta_15, so using its actual density instead of the worst
density does not repair this per-other bound. This obstruction was supplied
by the parent and independently verified here.

It does **not** refute `2c<N`: even completing this pair to seven lower owners
`(1,2,3,4,5,240,255)` at p=272 gives the explicit safe candidate r=583
modulo 4080, with distances

```text
(583,1166,1749,1748,1165,1200,1785,544)
```

for those owners and the pivot. Its ordinary time 1/7 is also a strict
1/15 witness. Other rows can compensate for a large individual remainder;
no uniform aggregate-overlap or adaptive-order estimate is proved here.
The original sparse contract remains open, including composite N=10 and
unbounded dimensions. The bounded scans below do not alter that status.

## 4. Reproduction and exact evidence scope

The first complete scan used N=4..16, maximal allowed `c=floor((N-1)/2)`,
`c+1<=p<=28`, and every c-subset of `1,...,p-1`: 9,582,210 cases, no cover,
about 4.3 seconds. It was a finite-domain control, not an infinite-height
argument. No search remained running. The block below also regenerates all
68 normalized N=9 exceptional pairs from the proved bounds, checks eight
nontrivial common-3-power lifts, the separating fixture, and the N=15 failure
of the attempted stronger bound. All comparisons use integers/Fraction.

```python
from fractions import Fraction as F
from itertools import combinations
from math import gcd, lcm

def dist(M, x):
    return min(x % M, (-x) % M)

def badset(N, p, d):
    return {r for r in range(N*p) if r % N and dist(N*p, r*d) < p}

scanned = 0
for N in range(4, 17):
    c = (N-1)//2
    for p in range(c+1, 29):
        R = [r for r in range(N*p) if r % N]
        full = (1 << len(R))-1
        masks = {d: sum(1 << j for j, r in enumerate(R)
                        if dist(N*p, r*d) < p) for d in range(1, p)}
        for ds in combinations(masks, c):
            union = 0
            for d in ds:
                union |= masks[d]
            assert union != full
            scanned += 1
assert scanned == 9582210

expected_P = {
    (10, 9): {3: [4,7,16], 9: [11,19,20,28,29,37,38,46,47,55,64]},
    (11, 9): {3: [4,7], 9: [10,19,20,28,37]},
    (19, 9): {3: [4,7], 9: [10,11,19,20,28]},
    (19,18): {3: [4,7], 9: [10,11,19,20,28]},
}
pair_counts = []
pair_maxima = []
power_checks = 0
for S, Dstar in expected_P:
    density = F(8*(2*((S-1)//9)+1), S)
    T = (8-density)/3
    found = {3: set(), 9: set()}
    ratios = []
    for k in (3, 9):
        bound = F(7*(k-1), 9)/(T-F(16,9))
        Pmax = bound.numerator//bound.denominator
        for P in range(k+1, Pmax+1):
            if P % 3 == 0:
                continue
            b = k*(2*((P-1)//k)+1)-(2*((P-1)//9)+1)
            if F(b,P) < T:
                continue
            for D in range(1, P):
                if gcd(D,9) != k or gcd(D,P) != 1 or (P,D) == (S,Dstar):
                    continue
                found[k].add(P)
                p = lcm(S,P)
                star, d = Dstar*(p//S), D*(p//P)
                Bstar, Bd = badset(9,p,star), badset(9,p,d)
                assert F(len(Bstar),p) == density
                assert F(len(Bd),p) == F(b,P)
                ratio = F(len(Bd-Bstar),p)
                assert ratio < T
                ratios.append(ratio)
    assert {k: sorted(ps) for k, ps in found.items()} == expected_P[S,Dstar]
    pair_counts.append(len(ratios))
    pair_maxima.append(max(ratios))
    # Include k=3 and non-coprime original pivots; this is not a vacuous lift.
    p = lcm(S,7)
    star, d = Dstar*(p//S), 3*(p//7)
    reference = len(badset(9,p,d)-badset(9,p,star))
    for g in (3,9):
        assert len(badset(9,g*p,g*d)-badset(9,g*p,g*star)) == g*reference
        power_checks += 1
assert pair_counts == [37,13,9,9] and sum(pair_counts) == 68
assert pair_maxima == [F(84,55),F(96,55),F(168,95),F(168,95)]
assert power_checks == 8

p, ds = 6160, (1,2640,5040,5544)
R = {r for r in range(9*p) if r % 9}
Bs = [badset(9,p,d) for d in ds]
assert tuple(map(len,Bs)) == (10950,12320,13440,14784)
safe = R-set().union(*Bs)
assert len(safe) == 14636 and min(safe) == 6162
assert all(any(d % q == 0 for d in ds+(p,)) for q in range(2,10))
nonzero_gcds = [gcd(d,9*p) for d in ds if gcd(d,9*p)>gcd(d,p)]
assert len(nonzero_gcds) == 3
assert all(a % b and b % a for a,b in combinations(nonzero_gcds,2))

N,p,star,d = 15,272,255,240
Bstar, Bd = badset(N,p,star), badset(N,p,d)
assert (len(Bstar),len(Bd),len(Bd-Bstar)) == (714,672,546)
assert F(546,p)-F(91,48) == F(91,816) > 0
V = (1,2,3,4,5,240,255,272)
assert 583 % N and all(dist(N*p,583*v)>=p for v in V)
assert min(min(F(v,7)%1,(-F(v,7))%1) for v in V) == F(1,7) > F(1,15)
print({'finite_owner_subsets': scanned, 'N9_exception_pairs': pair_counts,
       'common_three_power_controls': power_checks,
       'N9_safe_fixture': len(safe), 'N15_pair_bound': 'refuted only'})
```

## 5. Source bindings and next boundary

The arithmetic inputs and prior new case were inspected at these SHA-256s:

```text
bf4c025bcdcc178f4e9c94884314635e3d26697fe105a9a9a6a55ca1aa60f139  LonelyRunner/OwnerKernelCover.lean
4a9e242429e601f07559a1482031d84f0cc5677a3c128a15481f4003d4f5333e  LonelyRunner/OwnerKernelBound.lean
6487d679e2f8d84657827f01f1c98e232c997c62cb48dad5ac9c22db897df3b1  LonelyRunner/PivotZeroKernel.lean
ac24bb6cfcf524a08c0ceb2a728b2febf826c595d4aaa72eb7f10d2e5baa96dd  LonelyRunner/Prompt100TwoOwnerCounts.lean
49131a7f9690042d1b16cbc876417f9d9ce1b53cc6565f87b6d1b53c4e3340cd  LonelyRunner/Prompt99Scaling.lean
f6130fd8ed2bda6b50aa73b64a6fcbdbacb27efb478163d0b6e4e9e12d69dc50  research/astra-next-bridge-audit.md
```

The immediate settled target is review/formalization of the complete N=9
four-owner theorem, retaining every arithmetic exception above. The actual
all-N supply gap remains a multiowner overlap/existence assertion; finite
normalized pair classification does not settle it, and the N=15 control blocks
the simplest uniform pair bound. No new assumption equating an arbitrary
certificate format with witness existence has been introduced. The canonical
completion gate is unchanged.
