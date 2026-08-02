# Affine common-LCM fibers for the top two pivots

Status: **independently audited mathematics; not Lean-verified**.

This note records an exact enlargement of the common top-grid slice and an
exact obstruction in the principal hard row.  It is a sufficient-certificate
framework only.  It does not prove the top-two pivot conjecture and does not
prove or disprove unrestricted Lonely Runner.

## 1. Affine fibers

Fix `N>=2` and positive top speeds `A,B`.  Write

```text
g=gcd(A,B),  A=g*alpha,  B=g*beta,
H=g*alpha*beta=lcm(A,B),  Q=N*H.
```

Then `gcd(alpha,beta)=1`.  For a sign `epsilon` in `{+1,-1}`, define

```text
Phi_epsilon(r_A,r_B)=beta*r_A-epsilon*alpha*r_B mod Q
```

on `Z/(N*A) x Z/(N*B)`.  This is well-defined: changing `r_A` by
`N*A` or `r_B` by `N*B` changes the displayed integer by a multiple of
`Q`.  It is surjective because `alpha` and `beta` are coprime.  The domain
has `(N*A)*(N*B)` elements and the codomain has `Q` elements, so every fiber

```text
F_(epsilon,k)={ (r_A,r_B) : Phi_epsilon(r_A,r_B)=k }
```

has exactly

```text
|F_(epsilon,k)|=N*g
```

elements.

## 2. Exact candidate count

Put

```text
d_A=gcd(N,alpha),  d_B=gcd(N,beta).
```

Within a fiber, the number of points with `N|r_A` is `g*d_A` when
`d_A|k`, and zero otherwise.  The analogous number for `r_B` is `g*d_B`
when `d_B|k`, and zero otherwise.  Both divisibilities hold at exactly `g`
points when `N|k`, and at no points otherwise.  Inclusion-exclusion gives
the number at which both top-grid numerators are candidates:

```text
g*(N - 1_[d_A|k]*d_A - 1_[d_B|k]*d_B + 1_[N|k]).
```

Here `1_[P]` is one when `P` holds and zero otherwise.  The divisibility
conditions are independent of the representative chosen for `k mod Q`,
because `d_A`, `d_B`, and `N` all divide `Q`.

An initial audit draft incorrectly wrote the last indicator as
`1_[N|k]*N`. That would count the both-divisible intersection as `g*N`
instead of `g` and would falsely give six candidates on the known empty
`k=0` hard row. Two independent checks caught the error before commit; the
displayed formula is the corrected one.

## 3. Phase transport

For a lower speed `s`, strict badness at pivot `A` is

```text
rho_(N*A)(s*r_A)<A,
```

where `rho_M(x)=min(x mod M, M-(x mod M))`.  Since
`beta*(N*A)=Q`, `beta*A=H`, and
`rho_Q(beta*x)=beta*rho_(N*A)(x)`, the affine-fiber equation gives the exact
transport

```text
A-bad(s)  iff  rho_Q(s*(epsilon*alpha*r_B+k))<H.
```

Similarly, since `alpha*(N*B)=Q` and `alpha*B=H`,

```text
B-bad(s)  iff  rho_Q(s*alpha*r_B)<H.
```

These are strict equivalences, so equality with the boundary remains good.

## 4. A sound double-intersection certificate

Restrict a fiber to the points at which both top numerators are candidates.
For the full speed-index set `I`, with distinguished top indices `p_A,p_B`,
let

```text
D^A_i={x in F : runner i is strict-bad at pivot A},  i != p_A,
D^B_j={x in F : runner j is strict-bad at pivot B},  j != p_B.
```

The first family includes the other top runner `p_B`; the second includes
`p_A`.  Put `E_A=union_i D^A_i` and `E_B=union_j D^B_j`.  Distributivity and
the finite union bound give

```text
|E_A intersect E_B|
 <= sum_(i!=p_A,j!=p_B) |D^A_i intersect D^B_j|.
```

Consequently, if the right side is strictly less than `|F|`, some point is
outside `E_A intersect E_B`.  It is therefore outside `E_A` or outside
`E_B`, and supplies a complete certificate at at least one of the two top
pivots.  This criterion is sound but is not known to hold uniformly.

## 5. Exact hard row

Take

```text
N=7, A=98, B=187, epsilon=+1, k=1.
```

Then `g=1`, `alpha=98`, `beta=187`, `H=18326`, `Q=128282`,
`d_A=7`, and `d_B=1`.  The candidate-count formula gives six.  Direct exact
enumeration gives precisely

```text
(r_A,r_B)
(87,166)
(185,353)
(283,540)
(381,727)
(479,914)
(577,1101)
```

The cross-top strict-residue distances are

```text
speed B on the A-grid (mod 686):
195, 295, 99, 97, 293, 197

speed A on the B-grid (mod 1309):
560, 560, 560, 560, 560, 560.
```

The `B`-grid cross-top condition is good at every listed point.  On the
`A`-grid, five cross-top distances are good, while the fourth is
`97<98` and hence strict-bad.  This distinction does not affect the stronger
obstruction: the lower speed `s=63` has distances

```text
on the A-grid: 7, 7, 7, 7, 7, 7;
on the B-grid: 14, 14, 14, 14, 14, 14.
```

Both are strictly below the corresponding pivot thresholds `98` and `187`.
Hence all six points lie in `D^A_63 intersect D^B_63`.  In particular, the
strict double-intersection sum criterion cannot succeed on this affine row.
This is not a top-two counterexample: it only rejects using this hard row as
the missing cross-pivot rescue.

## 6. Quotient lifts and the boundary

For a modulus `P`, write a grid numerator uniquely as

```text
r=u+j*P,  0<=u<P,  0<=j<N.
```

For a speed `s`, divide

```text
u*s=q*P+v,  0<=v<P,
h=(q+j*s) mod N.
```

The residue modulo `N*P` is `h*P+v`.  For `N>=2`, exact inspection of the
two ends of the residue circle proves

```text
rho_(N*P)((u+j*P)*s)<P
  iff h=0 or (v>0 and h=N-1).
```

The `v>0` guard is essential: when `v=0` and `h=N-1`, the distance is
exactly `P`, which is good under the closed Lonely Runner boundary.  The
equivalence itself also remains true at `N=1`, but the preceding
"upper endpoint is not bad" explanation does not, because then `h=N-1=0`
and the first disjunct applies.  All top-two applications here have `N>=2`.

The candidate condition is `N` not dividing `u+j*P`.  If
`d=gcd(N,P)`, the congruence `u+j*P=0 mod N` has `d` solutions in
`j mod N` when `d|u`, and none otherwise.  Thus the exact number of candidate
lifts over a fixed base `u` is

```text
N-d  if d|u,
N    otherwise.
```

For the hard bases `u_A=87`, `u_B=166` and speed `63`,

```text
87*63  =55*98 +91,
166*63 =55*187+173.
```

Here `55=6 mod 7`, `63=0 mod 7`, and both remainders are positive.  Therefore
`h=6=N-1` for every lift on both grids, so every lift remains strict-bad.
This quotient calculation explains the constant distances in the hard row.

## 7. Surviving obligation

The affine construction enlarges the empty common slice at
`(N,A,B)=(7,98,187)` and gives exact phase and intersection formulas, but the
lower speed `63` jointly covers the entire `k=1` candidate fiber.  Any global
top-two proof must select and combine other affine phases, exploit structure
beyond the raw double-intersection union bound, or introduce another
arithmetic mechanism.  No such uniform transition is presently proved.
