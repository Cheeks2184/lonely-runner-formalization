## 1. **Disposition**

`STOP`.

`DYADIC-VALUATION-FORCING` is false at the exact target dimension (n=4). More strongly, for every power of two (q\ge 8),

[
\operatorname{PowerForcing}(4,q)
]

fails for the explicit tuple modulo (5q)

[
v=\left(1,;4,;\frac{5q}{2}-1,;\frac{5q}{2}\right).
]

For the contract’s exact target

[
q_4=2^{32}=4{,}294{,}967{,}296,
]

this gives

[
M=5q_4=21{,}474{,}836{,}480
]

and

[
v=(1,;4,;10{,}737{,}418{,}239,;10{,}737{,}418{,}240).
]

The tuple satisfies every deletion-gcd premise and every (q_4)-nondivisibility premise, but its four strict bad sets cover all (r\bmod M). The counterexample is proved symbolically below and does not depend on finite computation.

---

## 2. **Exact definitions and threshold arithmetic**

Put

[
A_n=C_n^{,n(n-1)},\qquad C_n=\binom{n+1}{2}.
]

Because (n\ge3), (n+1\ge4), so (C_n>0) and hence (A_n>0).

### Existence and minimality of (T_n)

Consider

[
S_n={T\in\mathbb N:n^nT\ge A_n}.
]

This set is nonempty. Taking (T=A_n),

[
n^nA_n\ge A_n
]

because (n^n\ge1). By well-ordering, (S_n) has a least element (T_n). Therefore:

[
n^nT_n\ge A_n,
]

and for every (T\in\mathbb N),

[
n^nT\ge A_n\quad\Longrightarrow\quad T_n\le T.
]

Also (T_n>0). If (T_n=0), then its defining membership would give

[
0=n^n\cdot0\ge A_n>0,
]

which is impossible.

### Existence and minimality of (E_n)

For every (m\in\mathbb N),

[
m\le2^m.
]

Proof is by induction. The base case is (0\le1). If (m\le2^m), then (1\le2^m), so

[
m+1\le2^m+1\le2^m+2^m=2^{m+1}.
]

Applying this to (m=T_n) shows

[
T_n\le2^{T_n}.
]

Thus

[
R_n={e\in\mathbb N:T_n\le2^e}
]

is nonempty. By well-ordering it has a least element (E_n). Hence

[
T_n\le2^{E_n}
]

and

[
T_n\le2^e\quad\Longrightarrow\quad E_n\le e.
]

With

[
q_n=2^{E_n},
]

one has

[
0<q_n,\qquad T_n\le q_n.
]

### Exact product comparison

Suppose (P\ge q_n). Natural-number monotonicity gives

[
n^nP\ge n^nq_n\ge n^nT_n\ge C_n^{,n(n-1)}.
]

No natural subtraction is used.

If (q_n\mid a_j) and (a_j>0), write (a_j=q_nm). Positivity implies (m\ge1), so (a_j\ge q_n). All other positive speeds are at least (1), hence

[
\prod_i a_i\ge a_j\ge q_n.
]

Combining these gives the required weak product inequality.

### Exact (n=3) control

Here

[
N=4,\qquad C_3=\binom42=6,
]

and

[
A_3=6^{3\cdot2}=6^6=46{,}656.
]

Since

[
3^3=27,\qquad 27\cdot1{,}728=46{,}656,
]

we have (T_3\le1{,}728). For every (T<1{,}728),

[
T\le1{,}727
]

and therefore

[
27T\le27\cdot1{,}727=46{,}629<46{,}656.
]

Thus

[
T_3=1{,}728.
]

Furthermore,

[
2^{10}=1{,}024<1{,}728\le2{,}048=2^{11},
]

so monotonicity of powers of two gives

[
E_3=11,\qquad q_3=2{,}048.
]

### Exact (n=4) control

Here

[
N=5,\qquad C_4=\binom52=10,
]

and

[
A_4=10^{4\cdot3}=10^{12}=1{,}000{,}000{,}000{,}000.
]

Since

[
4^4=256
]

and

[
256\cdot3{,}906{,}250{,}000
=1{,}000{,}000{,}000{,}000,
]

we have (T_4\le3{,}906{,}250{,}000). For every smaller (T),

[
T\le3{,}906{,}249{,}999,
]

so

[
256T\le999{,}999{,}999{,}744
<1{,}000{,}000{,}000{,}000.
]

Therefore

[
T_4=3{,}906{,}250{,}000.
]

Finally,

[
2^{31}=2{,}147{,}483{,}648
<3{,}906{,}250{,}000
<4{,}294{,}967{,}296=2^{32}.
]

Hence

[
E_4=32,\qquad q_4=4{,}294{,}967{,}296.
]

---

## 3. **Logical-strength audit**

### Comparison with the positive-integer pivot equivalence

The accepted pivot equivalence has the following form. For positive injective speeds (a_i), a safe time exists if and only if there are a pivot index (j) and a numerator (r) modulo (Na_j) such that

[
\rho_{Na_j}(r a_i)\ge a_j
]

for every (i). The modulus and threshold depend on one actual speed (a_j).

`PowerForcing(n,q)` is materially different:

* (q) is an externally fixed number, not necessarily one of the speeds.
* The modulus is the fixed grid (Nq).
* Every coordinate divisible by (q) is excluded.
* Repeated and noninjective residue tuples are allowed.
* The conclusion must occur on that one fixed (Nq)-grid.

It is therefore not merely the pivot equivalence rewritten. It is a stronger fixed-denominator assertion, and the counterexample shows that this added strength is false.

The counterexample family is already positive, injective and primitive. Thus adding those three conditions would not repair the theorem.

### Explicit pivot witness for the counterexample family

The fixed (5q)-grid fails, but the same speeds have a valid ordinary pivot certificate.

Write (q=4m), with (m\ge2) for dyadic (q\ge8). Then the speeds are

[
a=(1,4,10m-1,10m).
]

Choose pivot speed

[
a_j=10m-1,
]

pivot modulus

[
P=5(10m-1)=50m-5,
]

and numerator

[
r=15m+1.
]

The four cyclic distances modulo (P) are:

[
\rho_P(r)=15m+1,
]

[
\rho_P(4r)=\rho_P(60m+4)=10m+9,
]

[
\rho_P(r(10m-1))=10m-1,
]

because (r\equiv1\pmod5), and

[
r(10m)=150m^2+10m
\equiv25m\pmod P,
]

so

[
\rho_P(r(10m))=P-25m=25m-5.
]

Every one of these is at least (10m-1). Consequently these speeds have a valid closed-threshold (1/5) witness, despite having no safe numerator on the (5q)-grid.

This directly separates `PowerForcing` from ordinary LRC and from the pivot-certificate theorem.

### Comparison with Prompts 67 and 79

Prompts 67 and 79 attempted to obtain many distinct prime divisors. Each prime-forcing contrapositive yielded only

[
p\mid\prod_i a_i.
]

Repeating the same prime did not increase its valuation.

The present target would have supplied the stronger conclusion

[
2^E\mid a_i
]

for one coordinate in a single step. That is logically new and is not an iteration of `PrimeForcing(n,2)`.

No such iteration was used in the counterexample. The full prime-power forcing assertion itself is false.

### Anti-circularity conclusion

Lower-dimensional LRC does not give a fixed (Nq)-grid witness. Assuming the (n)-dimensional LRC conclusion would still only provide some safe time or some speed-dependent pivot grid, not necessarily the prescribed dyadic grid.

Any repaired theorem restricted to “residues of an actual (n)-dimensional counterexample” would require a new structural property excluding the family above. Merely inserting counterexamplehood as a premise without independently deriving such a property would move the LRC difficulty into the premise.

---

## 4. **Attack A: dyadic lift**

Let the lower scale be (q=2^E), with lower modulus

[
L=Nq,
]

and let the upper scale be (2q), with upper modulus

[
2L=N(2q).
]

Because (E\ge1), (L) is even.

### Reduction preserves the deletion gcds

Write each upper residue uniquely as

[
v_i=w_i+\delta_iL,
\qquad
0\le w_i<L,\quad \delta_i\in{0,1}.
]

Suppose

[
\gcd(2L,{v_i:i\ne k})=1.
]

If a positive integer (d) divides (L) and every (w_i) with (i\ne k), then (d) divides (2L) and

[
v_i=w_i+\delta_iL
]

for every surviving coordinate. Hence (d=1). Therefore

[
\gcd(L,{w_i:i\ne k})=1.
]

This argument retains all primes dividing (N) and uses no unit cancellation.

### Exact valuation classes

Define (\nu_2(0)=\infty). The upper premise excludes

[
2q\mid v_i,
]

but it does not exclude (q\mid v_i).

Since (q\mid L),

[
q\mid w_i\quad\Longleftrightarrow\quad q\mid v_i.
]

The classes are therefore:

[
\nu_2(v_i)<E:
\quad q\nmid v_i,\quad q\nmid w_i;
]

[
\nu_2(v_i)=E:
\quad 2q\nmid v_i,\quad q\mid w_i;
]

[
\nu_2(v_i)\ge E+1,
\quad\text{including }v_i=0:
\quad 2q\mid v_i,
]

so the last class is excluded at the upper scale.

The exact-(E) class is allowed upstairs but invalidates the lower `PowerForcing(n,q)` premise.

In particular, (v_i=L=Nq) reduces to (0). It is upper-admissible exactly when (N) is odd, since

[
2q\nmid Nq\quad\Longleftrightarrow\quad 2\nmid N.
]

The (n=4) counterexample uses (N=5) and contains precisely this obstruction when reduced one dyadic level.

### Exact numerator-fiber formula

Write an upper numerator as

[
r=s+\varepsilon L,
\qquad
0\le s<L,\quad\varepsilon\in{0,1}.
]

Let

[
s w_i=y_i+k_iL,
\qquad
0\le y_i<L.
]

Expanding modulo (2L),

[
\begin{aligned}
r v_i
&=(s+\varepsilon L)(w_i+\delta_iL)\
&=s w_i+s\delta_iL+\varepsilon Lw_i+\varepsilon\delta_iL^2.
\end{aligned}
]

Because (L) is even, (2L\mid L^2). Thus

[
r v_i
\equiv
y_i+L\bigl(k_i+s\delta_i+\varepsilon w_i\bigr)
\pmod{2L}.
]

Define

[
b_i(\varepsilon)
\equiv k_i+s\delta_i+\varepsilon w_i\pmod2.
]

Then the upper phase is exactly

[
y_i+b_i(\varepsilon)L.
]

Its upper cyclic distance is

[
D_i(\varepsilon)=
\begin{cases}
y_i,&b_i(\varepsilon)=0,[2mm]
L-y_i,&b_i(\varepsilon)=1.
\end{cases}
]

This includes the fixed points:

* (y_i=0,b_i=0) gives phase (0) and distance (0);
* (y_i=0,b_i=1) gives the antipode (L) and distance (L).

Changing (\varepsilon) flips (b_i) exactly when (w_i), equivalently (v_i), is odd. Thus all odd coordinates flip simultaneously; even coordinates do not change.

### Strict and closed boundaries

At the upper scale, badness is

[
D_i(\varepsilon)<2q.
]

Thus:

[
b_i=0
\quad\Longrightarrow\quad
\text{bad exactly when }y_i<2q;
]

[
b_i=1
\quad\Longrightarrow\quad
\text{bad exactly when }y_i>L-2q.
]

The boundary values

[
y_i=2q,\qquad y_i=L-2q
]

are safe.

A lower-scale witness only guarantees

[
q\le y_i\le L-q.
]

For an odd coordinate:

* (q\le y_i<2q) requires one value of (\varepsilon);
* (L-2q<y_i\le L-q) requires the opposite value;
* (2q\le y_i\le L-2q) permits both values.

Different odd coordinates can demand opposite binary lifts. An even coordinate may be fixed on the bad upper side for both (\varepsilon).

Therefore the first unsupported lift arrow is:

[
\boxed{\text{A lower safe numerator }s
\text{ admits one common }\varepsilon
\text{ making every upper distance }\ge2q.}
]

Lower safety does not imply this simultaneous binary condition.

### Exact obstruction in the counterexample

Take an upper scale (Q=2q) with (N=5), and set

[
v=\left(1,4,\frac{5Q}{2}-1,\frac{5Q}{2}\right).
]

The upper half-modulus coordinate is

[
\frac{5Q}{2}=5q=L.
]

It reduces to (0) modulo (L), and because (N=5) is odd it is not divisible by (Q=2q). Thus it is legal upstairs but illegal for the lower `PowerForcing(n,q)` premise.

For the smallest failing member (Q=8), reduction modulo (20) gives

[
(1,4,19,20)\longmapsto(1,4,19,0),
]

and both (4) and (0) are divisible by the lower (q=4).

### Base case

`PowerForcing(n,1)` is vacuous because (1) divides every coordinate, so premise (ii) has no instances. It supplies no information about (q=2).

A dyadic induction would require a genuine uniform theorem `PowerForcing(n,2)` for every (n), followed by a valid lift. Neither the vacuous (q=1) statement nor the supplied finite scans provide such a base. In any event, the exact (n=4) target counterexample prevents a successful induction.

---

## 5. **Attack B: minimal cover/CRT**

### Exact noncoprime CRT decomposition

Write

[
N=2^sN_{\mathrm{odd}},
\qquad N_{\mathrm{odd}}\text{ odd}.
]

Then

[
N2^E=2^{s+E}N_{\mathrm{odd}},
]

with coprime factors (2^{s+E}) and (N_{\mathrm{odd}}). The valid direct product is

[
\mathbb Z/(N2^E)
\cong
\mathbb Z/2^{s+E}
\times
\mathbb Z/N_{\mathrm{odd}}.
]

The map to

[
\mathbb Z/N\times\mathbb Z/2^E
]

is not a direct-product isomorphism unless (\gcd(N,2^E)=1).

If

[
g=\gcd(N,2^E)=2^{\min(s,E)},
]

its image consists of compatible pairs satisfying equality modulo (g), and every compatible pair has exactly (g) preimages modulo (N2^E).

No incorrect coprime split is needed below. The counterexample has (N=5), so it survives even in the clean coprime case.

### Prime-wise meaning of the deletion premise

For a prime (p\mid M), every deletion gcd is one if and only if at least two coordinates are not divisible by (p).

If fewer than two are nondivisible, deleting the only nondivisible coordinate leaves all survivors divisible by (p). Conversely, if at least two are nondivisible, deleting one coordinate leaves at least one survivor not divisible by (p).

This does not make every coordinate a unit.

For the counterexample modulo (5q),

[
v=\left(1,4,h-1,h\right),
\qquad h=\frac{5q}{2},
]

the (2)-adic valuations are

[
0,;2,;0,;E-1.
]

There are two odd coordinates. For the prime (5), the first three coordinates are nonzero modulo (5).

### Exact bad-set cover

Assume (q=2^E) with (E\ge3). Let

[
M=5q,\qquad h=\frac M2=\frac{5q}{2}.
]

The four labelled bad sets correspond to owners

[
1,\quad4,\quad h-1,\quad h.
]

For the half-modulus owner (h),

[
hr\equiv
\begin{cases}
0\pmod M,&r\text{ even},\
h\pmod M,&r\text{ odd}.
\end{cases}
]

Since (h>q),

[
B_h={r:r\text{ is even}}.
]

For (h-1),

[
(h-1)r\equiv
\begin{cases}
-r\pmod M,&r\text{ even},\
h-r\pmod M,&r\text{ odd}.
\end{cases}
]

Thus on odd residues, (B_{h-1}) is the strict interval of points within distance (q) of the antipode (h).

The owner (1) covers the strict interval around zero. The owner (4) covers the remaining odd intervals, as proved fully in Section 7.

### Inclusion-minimality and relative private residues

All four selected labels are necessary. The following residues are private relative to the four-owner cover:

| Owner | Relative private residue |
| ----- | -----------------------: |
| (1)   |                  (q/4+1) |
| (4)   |                    (q+1) |
| (h-1) |                 (3q/2+1) |
| (h)   |                      (q) |

Because (q) is divisible by (8), the first three displayed residues are odd and (q) is even.

For (r=q/4+1):

[
\rho_M(r)<q,
]

while

[
\rho_M(4r)=q+4\ge q,
]

(r) is odd, and its distance from (h) is at least (q). Thus it belongs only to (B_1).

For (r=q+1):

[
\rho_M(4r)=\rho_M(4q+4)=q-4<q,
]

while it is safe for the other three owners.

For (r=3q/2+1):

[
\rho_M((h-1)r)=q-1<q,
]

while

[
\rho_M(4r)=\rho_M(q+4)=q+4\ge q,
]

and it is safe for owners (1) and (h).

For (r=q), owner (h) gives phase (0), while the other three distances are exactly (q):

[
\rho_M(q)=q,
]

[
\rho_M(4q)=q,
]

[
\rho_M((h-1)q)=q.
]

Thus equality is correctly safe for those three labels.

The least-cardinality selected cover therefore uses all four labels, and its lexicographically least owner list is the complete list

[
(1,4,h-1,h).
]

Each owner has a relative private residue, but there is no residue outside all four sets. Relative privacy supplies no global safety.

Translation by the half-modulus, reflection, valuation classes and private fibers are all present in this cover, yet they do not force an uncovered residue. Attack B therefore yields an explicit counterexample rather than a contradiction.

---

## 6. **Falsification report**

### Enumeration specification

The literal enumeration used:

1. (M=(n+1)q).
2. Tuples (v\in{0,\ldots,M-1}^n) in ordinary lexicographic order.
3. For each tuple, all deletion gcds were checked first.
4. Premise (ii) was checked only after all deletion gcds passed.
5. Numerators (r) were checked in increasing order (0,\ldots,M-1).
6. Badness was the literal strict test
   [
   \min(y,M-y)<q,\qquad y=(rv_i)\bmod M.
   ]
7. A failure was recorded exactly when every numerator had at least one labelled bad owner.

A second checker used prime-support deletion tests and precomputed bad-set bitmasks. It agreed with the literal checker on every tuple in every reported domain.

### Reproduction of the supplied controls

| ((n,q))  | Premise count | Failure count |
| -------- | ------------: | ------------: |
| ((3,2))  |            64 |             0 |
| ((3,4))  |         1,280 |             0 |
| ((3,8))  |        13,312 |             0 |
| ((3,16)) |       118,784 |             0 |
| ((4,2))  |           608 |             0 |
| ((4,4))  |        43,776 |             0 |

The reported preflight counts were reproduced exactly.

### Sole added domain

The single added domain was selected as

[
(n,q)=(4,8).
]

It is the first untested dyadic doubling after the reported ((4,4)) domain and directly distinguishes the proposed lift.

The result was:

| ((n,q)) | Premise count | Failure count | Lexicographically first failure |
| ------- | ------------: | ------------: | ------------------------------- |
| ((4,8)) |     1,147,904 |         2,304 | ((1,4,19,20))                   |

For (M=40), the four owner sets of the first failure are:

[
B_{1}=
{0,1,2,3,4,5,6,7,33,34,35,36,37,38,39},
]

[
B_{4}=
{0,1,9,10,11,19,20,21,29,30,31,39},
]

[
B_{19}=
{0,2,4,6,13,15,17,19,21,23,25,27,34,36,38},
]

[
B_{20}=
{0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38}.
]

Their union is all of ({0,\ldots,39}).

### Mandatory fixtures

| Fixture                              | Exact result                                                                                                                  |
| ------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------- |
| Repeated coordinates                 | (n=3,q=2,M=8,v=(1,1,3)) satisfies both premises. Numerator (r=2) gives distances ((2,2,2)).                                   |
| Coincident labelled bad sets         | (v=(1,7,3)) modulo (8) satisfies the premises, and the labelled sets for owners (1) and (7=-1) coincide.                      |
| Exactly one deletion-gcd failure     | (n=3,q=4,M=16,v=(1,2,2)). Deleting index (0) gives gcd (2); the other two deletions give gcd (1). Premise (ii) itself passes. |
| Zero rejected by premise (ii)        | (n=3,q=2,v=(0,1,3)) passes every deletion gcd but is rejected because (2\mid0).                                               |
| Nonzero (q)-multiple rejected        | (n=3,q=2,v=(2,1,3)) passes every deletion gcd but is rejected because (2\mid2).                                               |
| Nonunits and factors shared with (N) | ((1,4,19,20)\bmod40) contains nonunits (4,20), and (20) shares the factor (5) with (N=5), while all premises still hold.      |
| Strict boundary                      | For (M=8,q=2), phase (1=q-1) is bad and phase (2=q) is safe.                                                                  |
| Both cyclic sides                    | Phases (1,7) are bad; phases (2,6) are safe at equality.                                                                      |
| Antipode                             | Phase (4=M/2) has distance (4), hence is safe.                                                                                |
| Common unit scaling                  | Multiplying the failure by the unit (3\bmod40) gives ((3,12,17,20)), again a failure.                                         |
| Permutation                          | ((20,19,4,1)) is again a failure.                                                                                             |
| Reduction of positive speeds         | (a=(41,84,99,100)) has every deletion gcd equal to (1), no speed divisible by (8), and reduces modulo (40) to ((1,4,19,20)).  |
| Malformed arity                      | A tuple with fewer or more than (n) entries is rejected before arithmetic.                                                    |
| Out-of-range coordinate              | An entry equal to (M) is rejected rather than silently reduced.                                                               |

Common unit scaling is valid because multiplication by a unit permutes all numerators and preserves gcd and (q)-divisibility conditions.

### Odd-modulus warning

For

[
n=3,\quad q=5,\quad M=20,\quad v=(1,3,4),
]

all deletion gcds are (1), and no coordinate is divisible by (5). Its strict bad sets are

[
B_1={0,1,2,3,4,16,17,18,19},
]

[
B_3={0,1,6,7,8,12,13,14,19},
]

[
B_4={0,1,4,5,6,9,10,11,14,15,16,19}.
]

They cover every residue modulo (20). The supplied odd-modulus warning is therefore reproduced.

### Deliberately altered expected count

The assertion

[
\text{premise-count}(3,2)=65
]

was used as a negative control. Both checkers returned (64), so the altered assertion failed as required.

All enumerations in this section are `computed finite evidence`. They are not needed for the symbolic target counterexample.

---

## 7. **Sole theorem proof or STOP certificate**

### Counterexample lemma

For every power of two (q\ge8),

[
\operatorname{PowerForcing}(4,q)
]

is false.

#### Construction

Set

[
N=5,\qquad M=5q,\qquad h=\frac{M}{2}=\frac{5q}{2}
]

and

[
v=(1,4,h-1,h).
]

Because (q\ge8), all four coordinates lie in ({0,\ldots,M-1}).

#### Premise (i): every deletion gcd is one

If any coordinate other than (1) is deleted, the surviving list still contains (1), so its gcd with (M) is (1).

If (1) is deleted, the surviving coordinates include (h-1) and (h). Any common divisor of

[
M,;4,;h-1,;h
]

must divide both consecutive integers (h-1) and (h), hence must be (1).

Thus every deletion gcd is exactly (1).

#### Premise (ii): no coordinate is divisible by (q)

Since (q>4),

[
q\nmid1,\qquad q\nmid4.
]

Also

[
h=\frac{5q}{2}=2q+\frac q2,
]

so

[
h\bmod q=\frac q2\ne0.
]

Similarly,

[
(h-1)\bmod q=\frac q2-1\ne0.
]

Therefore (q) divides none of the four coordinates.

#### Full strict bad-set cover

Take an arbitrary

[
0\le r<M.
]

If (r) is even, then

[
hr=\frac M2r=M\frac r2\equiv0\pmod M,
]

so

[
\rho_M(hr)=0<q.
]

Thus every even (r) is bad for owner (h).

Now suppose (r) is odd.

If

[
\rho_M(r)<q,
]

then owner (1) is bad.

Assume instead that

[
\rho_M(r)\ge q.
]

For the representative (0\le r<M=5q), this means

[
q\le r\le4q.
]

Because (r) is odd,

[
hr\equiv h\pmod M,
]

and hence

[
(h-1)r\equiv h-r\pmod M.
]

If

[
\rho_M(h-r)<q,
]

then owner (h-1) is bad.

Assume that this distance is also at least (q). On the interval (q\le r\le4q),

[
|h-r|\le\frac{3q}{2}<\frac M2,
]

so no wraparound changes the distance. Therefore

[
|h-r|\ge q.
]

Since (h=5q/2), this gives

[
r\in
\left[q,\frac{3q}{2}\right]
\cup
\left[\frac{7q}{2},4q\right].
]

For the first interval,

[
4r\in[4q,6q].
]

The nearest multiple of (5q) is (5q), so

[
\rho_M(4r)\le q.
]

Equality can occur only at

[
r=q
\quad\text{or}\quad
r=\frac{3q}{2}.
]

Because (q) is divisible by (4), both endpoints are even. The present (r) is odd, so equality is impossible and

[
\rho_M(4r)<q.
]

For the second interval,

[
4r\in[14q,16q].
]

The nearest multiple of (5q) is (15q), again giving

[
\rho_M(4r)\le q.
]

Equality can occur only at

[
r=\frac{7q}{2}
\quad\text{or}\quad
r=4q.
]

Both are even. Since (r) is odd,

[
\rho_M(4r)<q.
]

Thus every odd (r) not already covered by owners (1) or (h-1) is covered by owner (4).

Every residue (r\bmod M) is therefore strictly bad for at least one owner. No safe numerator exists.

### Exact target instantiation

For (n=4),

[
q_4=2^{32}\ge8.
]

The lemma gives a failure of `PowerForcing(4,q_4)`. Therefore

[
\boxed{\text{DYADIC-VALUATION-FORCING is false.}}
]

This is the exact `STOP` certificate.

---

## 8. **Complete implication chain**

The proposed implication chain is logically valid only under the false forcing hypothesis.

1. **Primitive normalization.**
   By the accepted `proved-lean` common-scaling result, divide a positive injective speed tuple by its common gcd.

2. **Deletion gcds.**
   Under lower-dimensional LRC, the accepted `proved-math` deletion result gives
   [
   \gcd({a_i:i\ne k})=1
   ]
   for every (k).

3. **Reduction modulo (M=Nq_n).**
   Put
   [
   v_i=a_i\bmod M.
   ]
   Suppose (d) divides (M) and every surviving (v_i). Since
   [
   a_i=v_i+M\ell_i,
   ]
   (d) divides every surviving (a_i). Their gcd is (1), so (d=1). Hence
   [
   \gcd(M,{v_i:i\ne k})=1
   ]
   for every deletion.

4. **Transfer of (q_n)-nondivisibility.**
   Since (q_n\mid M),
   [
   q_n\mid v_i\quad\Longrightarrow\quad q_n\mid a_i.
   ]
   Therefore, if no speed is divisible by (q_n), no residue is divisible by (q_n).

5. **Hypothetical forcing step.**
   If `PowerForcing(n,q_n)` were true, there would be (0\le r<M) such that
   [
   \rho_M(rv_i)\ge q_n
   ]
   for all (i). Congruence gives
   [
   \rho_M(ra_i)=\rho_M(rv_i).
   ]
   At
   [
   t=\frac rM,
   ]
   the circle distance is
   [
   \left|\frac{ra_i}{M}\right|
   =\frac{\rho_M(ra_i)}{M}
   \ge\frac{q_n}{Nq_n}
   =\frac1N.
   ]
   Equality is safe. This would contradict counterexamplehood.

6. **Contrapositive divisibility.**
   Consequently, under the hypothetical forcing theorem, some positive speed would satisfy
   [
   q_n\mid a_j.
   ]
   Positivity would imply
   [
   \prod_i a_i\ge q_n\ge T_n.
   ]

7. **Weak product inequality.**
   By monotonicity and the defining property of (T_n),
   [
   n^n\prod_i a_i
   \ge n^nT_n
   \ge C_n^{,n(n-1)}.
   ]

8. **MSS strict reverse.**
   The contract-supplied MSS consequence, with status `literature`, `external-unformalized`, states that under lower-dimensional LRC a primitive (n)-speed counterexample satisfies
   [
   n^n\prod_i a_i
   <
   C_n^{,n(n-1)}.
   ]
   This is strictly incompatible with the preceding weak inequality.

9. **Strong induction and real transfer.**
   If the forcing premise were valid in every dimension, the accepted one- and two-speed `proved-lean` bases would start strong induction, and the accepted `proved-lean` real/integer equivalence would transfer the result to real speeds.

The chain is therefore a correct conditional wrapper:

[
\text{DYADIC forcing}+\text{MSS consequence}
\Longrightarrow
\text{unrestricted LRC}.
]

It does not prove LRC because its new forcing premise is `rejected` by the exact (n=4) counterexample.

---

## 9. **Proof-obligation ledger**

| Exact obligation                                                                                      | Dependency                        | Status                                       | Falsification or proof                                                               | First failed/open arrow                        | Recommended owner                           |
| ----------------------------------------------------------------------------------------------------- | --------------------------------- | -------------------------------------------- | ------------------------------------------------------------------------------------ | ---------------------------------------------- | ------------------------------------------- |
| The set defining (T_n) is nonempty                                                                    | Nat arithmetic                    | `proved-math` in this response               | (T=A_n) is a member                                                                  | None                                           | `/root` audit                               |
| (T_n>0) and is least                                                                                  | Well-ordering, (A_n>0)            | `proved-math`                                | (T=0) cannot satisfy the inequality                                                  | None                                           | `/root` audit                               |
| The set defining (E_n) is nonempty                                                                    | (m\le2^m)                         | `proved-math`                                | Direct induction                                                                     | None                                           | `/root` audit                               |
| (0<q_n), (T_n\le q_n)                                                                                 | Definition of (E_n)               | `proved-math`                                | Immediate from least-element membership                                              | None                                           | `/root` audit                               |
| Exact (n=3,4) controls                                                                                | Integer multiplication and powers | `proved-math`                                | Exact equalities and adjacent lower powers                                           | None                                           | `/root` audit                               |
| Reduction preserves each deletion gcd                                                                 | Divisor argument                  | `proved-math`                                | Any common divisor lifts to the original speeds                                      | None                                           | `/root` audit                               |
| (q)-nondivisibility transfers to residues                                                             | (q\mid M)                         | `proved-math`                                | Contrapositive divisibility                                                          | None                                           | `/root` audit                               |
| Lower dyadic premise follows from upper premise                                                       | Valuation classification          | `rejected`                                   | Exact class (\nu_2(v)=E) is allowed upstairs and (q)-divisible downstairs            | This is the first lift obstruction             | No further proof search on this formulation |
| One common binary numerator lift works                                                                | Fiber-distance formula            | `rejected` as an unsupported universal arrow | Even coordinates are fixed; odd coordinates can demand conflicting lift bits         | Simultaneous lift selector                     | No promotion                                |
| Uniform dyadic base from (q=1)                                                                        | Premise (ii)                      | `rejected`                                   | (q=1) is vacuous                                                                     | Genuine (q=2) theorem would still be needed    | Separate contract only                      |
| Minimal selected cover forces global safety                                                           | Owner privacy                     | `rejected`                                   | Explicit four-owner inclusion-minimal cover has private residues and covers the ring | Privacy-to-uncovered inference                 | No promotion                                |
| `PowerForcing(4,q)` for dyadic (q\ge8)                                                                | Explicit tuple                    | `rejected`                                   | Symbolic family ((1,4,5q/2-1,5q/2))                                                  | No open arrow; statement is false              | `/root` counterexample audit                |
| `DYADIC-VALUATION-FORCING`                                                                            | Previous row, (q_4=2^{32})        | `rejected`                                   | Exact target instance at (n=4)                                                       | Target itself fails                            | `/root` counterexample audit                |
| Supplied finite counts                                                                                | Literal and bitset checkers       | `computed finite evidence`                   | Counts agree on every reported domain                                                | Independent external replay not yet done       | Luna verifier                               |
| MSS strict product consequence                                                                        | External literature               | `literature`, `external-unformalized`        | Taken only at contract-stated scope                                                  | Formalization and source audit remain separate | Literature auditor                          |
| Full forcing-to-LRC implication                                                                       | Accepted reductions, forcing, MSS | `conditional`                                | Quantifiers and endpoints audited above                                              | False forcing antecedent                       | No promotion                                |
| A structural restriction satisfied by every primitive minimal counterexample and excluding the family | New theory                        | `open`                                       | Positivity, injectivity, primitivity and deletion gcds are insufficient              | First possible successor edge                  | New `/root` contract only                   |
| Unrestricted LRC                                                                                      | Full project                      | `open`                                       | Not affected by this modular counterexample                                          | Remains open                                   | Existing project governance                 |

---

## 10. **Verifier plan**

### Frozen literal architecture

Use exact finite types:

[
M=(n+1)q,
]

[
v:\operatorname{Fin}n\to\operatorname{Fin}M,
]

[
r:\operatorname{Fin}M.
]

Tuple order is the lexicographic order corresponding to the base-(M) index

[
\sum_{i=0}^{n-1} v_iM^{n-1-i}.
]

For each tuple:

```text
deletion_ok := true
for k = 0,...,n-1:
    g := M
    for i = 0,...,n-1:
        if i != k:
            g := gcd(g, v[i])
    if g != 1:
        deletion_ok := false
        break

if not deletion_ok:
    continue

if any(v[i] mod q == 0):
    continue

premise_count += 1

covered := false for every r
for r = 0,...,M-1:
    owners[r] := []
    for i = 0,...,n-1:
        y := (r*v[i]) mod M
        d := min(y, M-y)
        if d < q:
            append i to owners[r]

failure := every owners[r] is nonempty
```

The checker must record:

* premise count;
* failure count;
* lexicographically first failure;
* all labelled owner sets for the first failure;
* the first safe numerator for each successful fixture;
* exact distances at that numerator.

It must continue after finding the first failure so the total failure count is complete.

### Frozen domains

The complete domains are exactly:

[
(3,2),(3,4),(3,8),(3,16),(4,2),(4,4),(4,8).
]

No further domain is included.

The literal termination bound for a domain is finite:

[
M^n
]

tuples, at most (M) numerators per premise tuple, and (n) distance checks per numerator.

### Independent checker

The independent checker must not reuse the literal gcd and numerator loops internally.

It should:

1. factor (M);
2. replace all-deletion gcd checks by the proved equivalent condition
   [
   \forall p\mid M,\quad
   #{i:p\nmid v_i}\ge2;
   ]
3. precompute one (M)-bit bad mask for each coordinate value;
4. OR the (n) masks;
5. identify a failure when the result is the all-ones (M)-bit mask;
6. compare the premise and failure booleans tuple-by-tuple with the literal checker, not merely aggregate counts.

### Frozen fixtures

The fixture file must include:

* successful repeated tuple ((3,2,(1,1,3)));
* coincident-set tuple ((3,2,(1,7,3)));
* exact failure ((4,8,(1,4,19,20)));
* one-deletion failure ((3,4,(1,2,2)));
* zero rejection ((3,2,(0,1,3)));
* nonzero (q)-multiple rejection ((3,2,(2,1,3)));
* equality phases (q-1) and (q);
* antipode (M/2);
* unit-scaled failure ((4,8,(3,12,17,20)));
* permuted failure ((4,8,(20,19,4,1)));
* positive-speed reduction ((41,84,99,100)\bmod40);
* odd warning ((3,5,(1,3,4)));
* wrong arity;
* one coordinate equal to (M).

The deliberately incorrect assertion

[
\text{premise-count}(3,2)=65
]

must fail.

### Deterministic hashes

Both implementations must use:

* UTF-8 source encoding;
* LF line endings;
* no timestamps, random seeds or environment-dependent paths;
* SHA-256 of the exact source bytes;
* sorted-key canonical JSON Lines output;
* decimal integer encoding;
* tuple and owner arrays in canonical order;
* SHA-256 of the exact output bytes.

The report must record four hashes:

```text
literal_source_sha256
literal_output_sha256
optimized_source_sha256
optimized_output_sha256
```

No repository modification or implementation is performed in this turn.

---

## 11. **Final evidence boundary**

**`proved-lean`**

Only the accepted project inputs:

* one- and two-moving-speed LRC;
* common positive-integer scaling and gcd normalization;
* positive-integer pivot-certificate equivalence;
* real-speed and positive-integer equivalence.

No new Lean theorem was produced.

**`proved-math`**

At the contract’s accepted scope:

* the lower-dimensional deletion-gcd reduction.

Response-authored elementary proofs:

* existence, positivity and minimality of (T_n);
* existence and minimality of (E_n);
* exact (n=3,4) arithmetic;
* deletion-gcd preservation under modular reduction;
* the dyadic fiber formulas and noncoprime CRT decomposition;
* the explicit counterexample family for every dyadic (q\ge8).

These response-authored proofs are not a claim of repository promotion.

**`literature`, `external-unformalized`**

The MSS strict product consequence exactly as supplied in the contract. No Lean status or additional theorem identifier is asserted.

**Response-authored computation**

Literal tuple/numerator enumeration and an independent prime-support/bitmask comparison were performed for the six supplied domains and the single declared domain ((4,8)).

**`computed finite evidence`**

The reproduced counts, the (2{,}304) failures at ((4,8)), the lexicographically first failure, and all finite fixtures. These computations are not used to prove the target false.

**`conditional`**

The primitive-counterexample-to-MSS implication chain is valid conditional on the forcing theorem and the external MSS consequence.

**`rejected`**

* `DYADIC-VALUATION-FORCING`;
* `PowerForcing(4,q)` for every dyadic (q\ge8);
* the unrestricted dyadic lift route;
* any inference from inclusion-minimal owner privacy to an uncovered residue;
* use of vacuous `PowerForcing(n,1)` as a dyadic base.

**`open`**

* unrestricted Lonely Runner;
* any new structural theorem characterizing residue tuples of genuine primitive minimal counterexamples strongly enough to exclude the explicit family;
* `PowerForcing(3,q_3)` considered in isolation, which is irrelevant to the rejection of the universally quantified target.

The final disposition is `STOP`.
