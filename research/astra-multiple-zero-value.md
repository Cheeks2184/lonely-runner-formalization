# Value audit of simultaneous zero-row normalization

Status: bounded manuscript audit, 2026-09-05. This note proves implications
and counterexamples for the robust simultaneous contract in Section 5 of
`research/astra-vanishing-slope.md`. It does not prove or disprove unrestricted
LRC, and does not assert an equivalence that has not been established.

The contract has concrete additional reach: a mixed certificate handles
`V7=(2,3,4,30,7,14)`, which escapes A, B, and coarse one-zero C. Nevertheless,
the robust multiple-zero contract alone cannot cover all primitive tuples.
Allowing every row to be zero does not turn it into an equivalent formulation
of strict witness existence: that subclass misses `V7` despite its strict
witness. Sufficiency of a strict witness for the full mixed contract remains
unproved. Universality of the union A/B/C/multiple-zero also remains unproved.

## 1. Exact normalization and certificate being audited

Let `N` be an odd prime and `V=(V_i)` a primitive tuple of `N-1` positive
integer speeds. Distinctness may also be required for the LRC application;
all examples below have distinct entries. Write `||x||=dist(x,Z)`.

A normalization may choose any positive integer `M`, a common integer `b`
with `gcd(b,M)=1`, independent signs `e_i in {1,-1}`, and integers `k_i`
such that

```text
W_i=e_i*b*V_i+N*M*k_i > 0.
```

Thus `b` is an arbitrary lift of a common unit modulo `M`. It need not be
a unit modulo `N`. At every grid time `t=n/(N*M)`, these positive Nat
representatives satisfy `||W_i*t||=||V_i*(b*t)||`. This phase equality need
not hold off that grid.

Partition all labels into a nonempty zero set `Z` and the ordinary set `O`.
For `j in Z`, choose bases `A_j>0` with `N|A_j`, `N|W_j`, and
`W_j == A_j (mod M)`. Set `L=min A_j`, `H=max A_j`. For `i in O`, require
`0<a_i<L`, `N` does not divide `a_i`, and `W_i == a_i (mod M)`. The robust
size requirements are exactly

```text
H < (N-1)*L,
((N-1)*L-H)*M >= N*H*L,
(L-a_i)*M >= N*a_i*L                    for every i in O.       (R)
```

There can be no ordinary rows. The affine argument pads their number to
`N-2`, chooses `r0,s` nonzero modulo `N`, and uses

```text
r=ceil(M*r0/N + M/(N*L)),
beta=N*r-M*r0,
n=s*M+N*r,       t=n/(N*M).
```

Then `M/L <= beta < M/L+N`. Zero-row residues are `A_j*beta` in
`[M,(N-1)*M)`. Ordinary residues are `h_i*M+a_i*beta`, with
`1<=h_i<=N-2` and `0<a_i*beta<M`. The resulting witness has the closed
threshold `1/N` for every original speed after multiplication of time by
`b`. There are exactly `N-1` original coordinates throughout.

Useful consequences of (R) are

```text
N*H < (N-1)*M,      N*a_i < M.                              (1)
```

For the first, bound `((N-1)L-H)M` strictly above by `(N-1)LM` and cancel
`L`. For the second, use `(L-a_i)M<LM`. Consequently every base is less
than `M`: these are actual positive signed residues, not arbitrary large
lifts of the bases.

This audit concerns (R). It does not identify (R) with the more permissive
exact-rounding inequalities, later wrapped bands, or the separately discussed
zero-width case `H=(N-1)L`.

## 2. Forward implications, including the boundary restriction

**Proposition 1.** Every certificate (R) gives a closed LRC witness for the
original tuple. If `N` does not divide `M`, it gives a strict witness:
`||V_i*T||>1/N` for every label.

The closed implication is the simultaneous grid argument above. For strictness,
the only possibly closed endpoint is the lower endpoint of a zero row. Since
`N|L`, `N` does not divide `M`, and `beta` is integral, `L*beta=M` is
impossible. Hence `beta>M/L`, all zero residues lie strictly between
`M` and `(N-1)M`, and the ordinary residues already do so. Transport at the
same exact grid time preserves strictness. Taking the fractional part of
`b*n/(N*M)` gives a time in `(0,1)`; it cannot be zero because all distances
are positive.

**Corollary 2.** For primitive input, an all-zero certificate always gives a
strict original witness, without separately assuming `N` does not divide `M`.

If all rows are zero, then `N|b*V_i` for every `i`. Primality and primitivity
give an index with `N` not dividing `V_i`, so `N|b`. The unit condition
`gcd(b,M)=1` then forces `N` not to divide `M`, and Proposition 1 applies.
More generally, when `N` does not divide `b`, every zero label must be an
original speed divisible by `N`.

When `N|M`, the present proof establishes only a closed original witness.
An off-grid perturbation of the positive `W_i` is insufficient: independent
additions of `N*M` preserve phases only on the grid. Here is an exact control:

```text
N=5, M=25, b=1,
V=(1,2,5,20), signs=(+,+,+,-),
W=(1,2,5,105), ordinary bases=(1,2), zero bases=(5,5),
L=H=5, r0=1, s=2, r=6, beta=5, t=16/25.
```

All (R) inequalities hold. Original speeds 5 and 20 have phases `1/5` and
`4/5` respectively. A small positive change of original time makes speed 20
bad; a small negative change makes speed 5 bad. Both positive transformed
zero speeds instead have phase `1/5`, so their forward perturbation is good.
This disproves that perturbation argument. It is not a counterexample to
existence of another strict original witness: this tuple has one at `1/3`.
Whether every primitive mixed (R) certificate with `N|M` implies some other
strict original witness is not settled here.

## 3. The tight-tuple obstruction is to this contract alone

**Proposition 3.** For every odd prime `N`, the primitive tuple
`T_N=(1,2,...,N-1)` has no normalization satisfying (R), even with arbitrary
mixed zero sets, signs, modular units, and common lifts.

None of its speeds is divisible by `N`. Since a zero row is required, its
zero-row condition forces `N|b`. Thus `N` does not divide `M`, and
Proposition 1 would give a strict witness. But no such witness exists:
the `N` circle points `0,t,...,(N-1)t` have a cyclic gap at most `1/N`.
The two endpoints differ by a speed in `1,...,N-1`, whose circle distance
is at most that gap. Coincident points give distance zero and cause no
exception. At `t=1/N` all distances are at least `1/N`, so these tuples
are closed-threshold controls, not LRC counterexamples.

**This does not obstruct the union with A/B/C.** Theorem A already handles
`T_N`, using its all-offsets-nonzero branch at `s=1,r=0`, with any sufficiently
large external modulus and bases `a_i=V_i`. A claim that Proposition 3 refutes
universality of A/B/C/multiple-zero would be incorrect.

The borderline `H=(N-1)L` is excluded by (R), not accidentally forgotten.
The Section 5 borderline mechanism requires `N*L|M`. In an all-zero
normalization of primitive input, `N|b` and the modular-unit restriction
instead require `N` not to divide `M`, so that particular all-zero repair
is unavailable.

## 4. The all-zero subclass is stronger than strict witness existence

There is a useful exact characterization, with the modular constraints
retained. For positive residues let

```text
d_i=min(q*V_i mod M, (-q*V_i) mod M),
l=min d_i,       h=max d_i.
```

**Proposition 4.** A primitive tuple has an all-zero normalization satisfying
(R) if and only if there are `M>0` and a unit `q modulo M` with

```text
N does not divide M,      every d_i>0,
((N-1)*l-h)*M >= N^2*h*l.                                  (2)
```

Forward proof: Corollary 2 supplies `b=N*q` and `N` not dividing `M`.
Write `A_i=N*B_i`. Cancellation of the invertible `N modulo M` gives
`B_i == e_i*q*V_i (mod M)`. By (1),
`0<B_i/M<(N-1)/N^2<1/2`, so `B_i` is precisely the absolute residue `d_i`.
Substituting `L=N*l,H=N*h` into (R) and cancelling `N` gives (2).

Reverse proof: (2) implies `h<(N-1)l` and
`h/M<(N-1)/N^2`. Set `b=N*q`, choose the signs realizing `d_i`, and set
`A_i=N*d_i`. Then `gcd(b,M)=1`, all congruences and divisibilities hold,
and (2) is exactly the required zero-row size inequality. Add sufficiently
large independent multiples of `N*M` to the signed transformed speeds to
obtain positive Nat representatives. There are no ordinary conditions.

This equivalence is a description of a simultaneous small-residue recurrence
with a ratio bound. It is not a supply proof. In particular the following
strict witness does not imply (2).

**Proposition 5.** `V7=(2,3,4,30,7,14)` has a strict `1/7` witness but no
all-zero normalization (R), for any external modulus, signs, or common unit.

At time `1/9`, its six distances are respectively
`(2,3,4,3,2,4)/9`, all greater than `1/7`.
Suppose (2) holds. Put `epsilon=6/49`,
`w=min(q mod M,(-q) mod M)>0`, and `x=w/M` in `(0,1/2]`.
Every `||V_i*x||<epsilon`.

For `0<epsilon<=1/6`, the two inequalities
`||2*x||,||3*x||<epsilon` force `x<epsilon/3`: the first puts
`x<epsilon/2` or `x>(1-epsilon)/2>=5/12`. In the latter interval,
`3*x` lies between `5/4` and `3/2`, at distance at least `1/4` from the
integers, a contradiction. In the former, `3*x<1/4`, so the second gives
the claimed refinement.

Now `7*x<2/7<1/2`, and `14*x<4/7<1-epsilon`. Thus the speed-14
condition can only use the interval near zero, and gives `14*x<epsilon`.
It follows that `30*x<90/343<1/2`. Every speed in `V7` is at most 30,
so all six absolute residues are unwrapped: `d_i=V_i*w`. Hence
`h/l=30/2=15`, contradicting the required `h/l<6`.

This is an all-modulus proof, not a finite search conclusion. It disproves
the reverse `strict witness => all-zero (R)`, including any attempt to obtain
that reverse merely by rational approximation with increasingly large moduli.

## 5. Mixed rows do add reach: an exact V7 certificate

Although all-zero certificates fail for `V7`, a mixed one works:

```text
N=7, M=257, b=35, gcd(35,257)=1,
original speeds:  2    3    4     30      7      14
signs:           +    +    +      +      -       -
Nat speeds W:   70  105  140   1050   1554    1309
bases:          70  105  140     22     12      24
row kind:        Z    Z    Z      O      O       O
```

The last two Nat representatives add `N*M=1799` to the signed speeds.
All six offsets are zero modulo 7 because the allowed common lift `b=35`
is divisible by 7. The ordinary bases nevertheless have nonzero slopes.
Here `L=70,H=140`, and

```text
((6*70)-140)*257 = 71960 >= 68600 = 7*140*70,
(70-24)*257     = 11822 >= 11760 = 7*24*70.
```

The ordinary inequality becomes easier as `a` decreases, so the second
line also covers 22 and 12. Choosing `r0=s=1` gives ordinary affine
residues `(1,5,3)` modulo 7; none is 0 or -1. Shifted rounding yields

```text
r=38, beta=9, n=523, N*M=1799,
W_i*n mod 1799 = (630,945,1260,455,1393,987).
```

All six residues lie strictly between 257 and 1542. Transport gives the
original time `35*523/1799 == 45/257 (mod 1)`, whose minimum distance is
`58/257>1/7`.

The prior all-modulus audit proves `V7` escapes A/B/coarse C. Thus this
fixture proves that simultaneous mixed rows enlarge their union, as well
as the all-zero subclass. It does not prove that the enlargement is
universal. The simple pre-existing witness `1/9` also prevents interpreting
this more elaborate certificate as a new proof of a previously inaccessible
LRC instance. It is an exact regression fixture for the new contract.

## 6. An easy sufficient input, and its limited value

Let `m=min V_i`, `h=max V_i`. If

```text
h < (N-1)*m,                                               (3)
```

then an all-zero certificate is immediate: set `b=N`, `A_i=N*V_i`,
`L=N*m,H=N*h`, and choose any sufficiently large `M` coprime to `N` with

```text
M >= N^2*h*m / ((N-1)*m-h).
```

For example choose `M=N*K+1` with `K` large; no prime-distribution or
approximation result is needed. The size bound is exactly (R), all speeds
are already positive, and all congruences are equalities.

This is a specific, readily checked sufficient input, but it provides no
new LRC mechanism: (3) also says the real interval

```text
1/(N*m) < t < (N-1)/(N*h)
```

is nonempty. Every product `V_i*t` then lies strictly between `1/N` and
`1-1/N`. This elementary first-band proof is simpler than normalization.

For `N` not dividing `M`, there is also no obstruction to the common lift
being divisible by `N`: given any unit `c modulo M`, CRT supplies
`b == c (mod M)` and `b == 0 (mod N)`. This preserves the unit condition
and makes every transformed offset zero. It does not make every base
divisible by `N`, and does not supply the residue sizes or partition (R).
Those are the unresolved arithmetic requirements.

## 7. Conclusions and precise residual questions

The established logical relationships are:

| Input | Established consequence |
| --- | --- |
| Robust mixed (R) | Closed original witness |
| Robust mixed (R), `N` not dividing `M` | Strict original witness |
| Primitive all-zero (R) | Strict original witness and exact recurrence criterion (2) |
| Strict original witness | Does **not** imply all-zero (R), by `V7` |
| Ratio condition (3) | All-zero (R), and a simpler elementary strict witness |
| Arbitrary primitive tuple | Does **not** always have robust mixed (R), by `T_N` |

The last line concerns the multiple-zero contract alone. Theorem A covers
`T_N`, and the new mixed example covers the previous escaping control `V7`.
No example here escapes the entire enlarged union.

The unresolved supply questions are exact: does every strictly lonely
primitive tuple admit a mixed normalization (R), perhaps with `N` not
dividing `M`? Does every primitive tuple admit A, B, C, or mixed (R)?
Neither question is answered by the present implications. Strictness of
original witnesses arising from arbitrary `N|M` mixed certificates is
also left open here. A proof of equivalence in any of these cases must
handle the integer residue constraints, coprimality, positive Nat lifts,
and closed-boundary cases, not merely density of rational times.

The mixed extension is therefore a proved broader sufficient criterion
with a useful fixture, but it currently has no demonstrated uniform supply
mechanism. This audit gives neither a circularity theorem for the full
mixed contract nor a new reduction resolving unrestricted LRC.

## 8. Evidence, source binding, and compact reproduction

Source snapshot read for this audit:

```text
research/astra-vanishing-slope.md
  f3e2c58177b5f3033afd0d164fbb688eacd30e5f42f39a7bc6ccaec5e82f599e
LonelyRunner/AffineGridVanishing.lean
  7bcec521f38f065e03c2f112e4af91f20b3e05b0cedcbc1e6f8f49cca350d5c4
research/astra-grid-supply-audit.md
  7caa2b660942cacb92382bc9cd661b83647af85f212b71589d162e6734bb22c1
```

The simultaneous contract was manuscript-only in this source snapshot;
concurrent formalization is outside this note's evidence claim. Current
project workflow/config/state were read and `python3 scripts/validate_workflow.py`
passed. This documentation-only audit changed no Lean source and ran no
full build. The fixed arithmetic checks below passed using Python integers
and `Fraction`; analytic all-modulus claims above do not depend on scans.

```python
from fractions import Fraction as F
from math import ceil, gcd

N, M, b = 7, 257, 35
V = (2, 3, 4, 30, 7, 14)
signs = (1, 1, 1, 1, -1, -1)
A = (70, 105, 140, 22, 12, 24)
D = N*M
W = tuple(e*b*v if e*b*v > 0 else e*b*v+D
          for e, v in zip(signs, V))
L, H = min(A[:3]), max(A[:3])
assert gcd(b, M) == 1
assert all(w > 0 and w % N == 0 and (w-a) % M == 0
           for w, a in zip(W, A))
assert ((N-1)*L-H)*M >= N*H*L
assert all(0 < a < L and a % N and (L-a)*M >= N*a*L
           for a in A[3:])
r0 = s = 1
assert all((r0*a+s*w) % N not in (0, N-1)
           for a, w in zip(A[3:], W[3:]))
r = ceil(F(M*r0, N) + F(M, N*L))
beta, n = N*r-M*r0, s*M+N*r
residues = tuple(w*n % D for w in W)
assert (r, beta, n) == (38, 9, 523)
assert residues == (630, 945, 1260, 455, 1393, 987)
assert all(M < x < (N-1)*M for x in residues)
t = F(b*n % D, D)
assert t == F(45, 257)
assert min(min(v*t % 1, -v*t % 1) for v in V) == F(58, 257)
assert min(min(F(v, 9) % 1, F(-v, 9) % 1) for v in V) == F(2, 9)

# Boundary transport control; this does not deny another strict witness.
N, M = 5, 25
V, W, A = (1, 2, 5, 20), (1, 2, 5, 105), (1, 2, 5, 5)
L = H = 5
assert ((N-1)*L-H)*M >= N*H*L
assert all((L-a)*M >= N*a*L for a in A[:2])
assert all((w-a) % M == 0 for w, a in zip(W, A))
r0, s = 1, 2
r = ceil(F(M*r0, N) + F(M, N*L))
t = F(s, N) + F(r, M)
assert (r, N*r-M*r0, t) == (6, 5, F(16, 25))
assert (5*t) % 1 == F(1, 5) and (20*t) % 1 == F(4, 5)
for delta in (F(1, 10000), F(-1, 10000)):
    assert min(min(v*(t+delta) % 1, -v*(t+delta) % 1)
               for v in V) < F(1, 5)
assert min(min(F(v, 3) % 1, F(-v, 3) % 1) for v in V) == F(1, 3)
print("V7 mixed certificate and boundary transport controls passed")
```
