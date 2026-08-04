## 1. Outcome

# PROVE

`proved-math`: For every (N\ge 4), (p\ge 1), and distinct positive integers (b<c<p),
[
B_b(N,p)\cup B_c(N,p)\ne R(N,p).
]

The complete (|F(a)|\le 3) consequence for the Prompt95 route also follows.

---

## 2. Frozen definitions and equivalence

Let
[
M=Np,\qquad
u_M(x)\in{0,\ldots,M-1},
\qquad
\rho_M(x)=\min(u_M(x),M-u_M(x)).
]
Define
[
R(N,p)={r\in{0,\ldots,M-1}:N\nmid r}
]
and
[
B_d(N,p)={r\in R(N,p):\rho_M(rd)<p}.
]

There are exactly (p) multiples of (N) modulo (Np), namely
[
0,N,2N,\ldots,(p-1)N,
]
so
[
|R(N,p)|=Np-p=(N-1)p.
]

For (r\in R(N,p)),
[
r\notin B_d(N,p)
\iff \neg(\rho_M(rd)<p)
\iff \rho_M(rd)\ge p.
]
The last inequality is closed. In particular, the equality points
[
\rho_M(rd)=p
]
are safe.

Therefore
[
B_b(N,p)\cup B_c(N,p)\ne R(N,p)
]
is literally equivalent to the existence of (r) such that
[
0\le r<Np,\qquad N\nmid r,
]
and
[
\rho_{Np}(rb)\ge p,\qquad \rho_{Np}(rc)\ge p.
]

`proved-math`.

---

## 3. Fixture audit

No fixture mismatch occurred.

### 3.1 Arithmetic controls

| Parameters    | Recomputed result                                                                    |   |         |     |         |        |                                                  |
| ------------- | ------------------------------------------------------------------------------------ | - | ------- | --- | ------- | ------ | ------------------------------------------------ |
| ((4,3,1,2))   | (R={1,2,3,5,6,7,9,10,11}), (B_1={1,2,10,11}), (B_2={1,5,6,7,11}), uncovered (={3,9}) |   |         |     |         |        |                                                  |
| ((4,4,1,3))   | (                                                                                    | R | =12), ( | B_1 | =       | B_3    | =6), uncovered (={7,9})                          |
| ((4,5,2,3))   | (                                                                                    | R | =15), ( | B_2 | =7), (  | B_3    | =6), uncovered (={3,5,15,17})                    |
| ((4,15,5,10)) | (                                                                                    | R | =45), ( | B_5 | =20), ( | B_{10} | =25), uncovered (={3,9,15,21,27,33,39,45,51,57}) |

At ((N,p,b,c,r)=(4,6,1,5,6)),
[
u_{24}(6\cdot1)=u_{24}(6\cdot5)=6,
\qquad
\rho_{24}(6)=6=p.
]
Thus (r=6) is a retained nonunit candidate, both labelled products collide, and equality is safe.

At (N=4,p=5,d=2),
[
u_{20}(1\cdot2)=u_{20}(11\cdot2)=2,
]
and both (r=1,11) are retained bad candidates in the same multiplication fiber.

For the deliberately altered expected uncovered set ({3}) at ((4,3,1,2)), both exact-list verifiers rejected the record.

### 3.2 Exact scaling control

For every positive integer (\lambda),
[
u_{\lambda M}(\lambda x)=\lambda u_M(x),
\qquad
\rho_{\lambda M}(\lambda x)=\lambda\rho_M(x).
]
Also, membership for the scaled coefficient (\lambda d) is periodic in (r) modulo (M=Np):
[
(\lambda d)(r+M)\equiv \lambda dr\pmod{\lambda M}.
]
Because (N\mid M),
[
N\mid r+qM\iff N\mid r.
]

Consequently,
[
B_{\lambda d}(N,\lambda p)
==========================

\bigcup_{q=0}^{\lambda-1}
\bigl(B_d(N,p)+qNp\bigr),
]
and the same copy relation holds for uncovered residues.

Applying (\lambda=5) to ((4,3,1,2)) produces
[
{3,9}+12{0,1,2,3,4}
===================

{3,9,15,21,27,33,39,45,51,57}.
]

`proved-math`.

### 3.3 False (N=3) extension

For ((N,p,b,c)=(3,3,1,2)),
[
R={1,2,4,5,7,8},
]
[
B_1={1,2,7,8},
\qquad
B_2={1,4,5,8},
]
and (B_1\cup B_2=R).

For ((N,p,b,c)=(3,5,2,3)),
[
R={1,2,4,5,7,8,10,11,13,14},
]
[
B_2={1,2,7,8,13,14},
]
[
B_3={1,4,5,10,11,14},
]
and again (B_2\cup B_3=R).

Thus the proposed arithmetic theorem with (N\ge3) is `refuted`. These controls are outside the (N\ge4) target.

### 3.4 Prompt95 route controls

The full labelled pivot calculation gives:

| Tuple             | Covered speeds | Maximum covered pivot | Internal-cover checks                                                                      |
| ----------------- | -------------- | --------------------- | ------------------------------------------------------------------------------------------ |
| ((1,6,11,12,13))  | ({1,6})        | (6)                   | Owner ({1}) leaves 20 candidates uncovered                                                 |
| ((6,7,12,24,144)) | ({6,7,12,24})  | (24)                  | Pairs ({6,7},{6,12},{7,12}) leave respectively (56,72,64) candidates; ({6,7,12}) leaves 48 |
| ((1,4,5,6,7,11))  | ({1,4,5,11})   | (11)                  | Pairs ({1,4},{1,5},{4,5}) leave respectively (34,34,36) candidates; ({1,4,5}) leaves 22    |

All (960) label permutations of the three base tuples, and their (960) corresponding scale-by-five versions, preserved the speed-labelled covered sets and the stated subset-cover failures.

`computed finite evidence`.

---

## 4. Main theorem

### 4.1 Exact one-owner count

Let
[
A_d={r\in{0,\ldots,Np-1}:\rho_{Np}(rd)<p},
]
so (B_d=A_d\setminus N\mathbb Z).

Put
[
g=\gcd(d,Np),\qquad h=\gcd(d,p),
\qquad s=\left\lfloor\frac{p-1}{N}\right\rfloor.
]

The strict target residues are exactly
[
0,1,\ldots,p-1,Np-p+1,\ldots,Np-1.
]
Equivalently, they are represented by the integers
[
-(p-1),\ldots,-1,0,1,\ldots,p-1.
]

Multiplication by (d) modulo (Np) has image consisting of the multiples of (g), with exactly (g) preimages per image residue. Hence
[
|A_d|
=====

g\left(2\left\lfloor\frac{p-1}{g}\right\rfloor+1\right).
]

For a multiple (r=Nt),
[
\rho_{Np}(Ntd)=N\rho_p(td).
]
Therefore it is bad exactly when
[
\rho_p(td)<\frac pN,
]
or, since the left side is integral,
[
\rho_p(td)\le s.
]
Multiplication by (d) modulo (p) has kernel size (h), giving
[
|A_d\cap N\mathbb Z|
====================

h\left(2\left\lfloor\frac{s}{h}\right\rfloor+1\right).
]

Thus
[
\boxed{
|B_d(N,p)|
==========

## g\left(2\left\lfloor\frac{p-1}{g}\right\rfloor+1\right)

h\left(2\left\lfloor\frac{s}{h}\right\rfloor+1\right).
}
\tag{4.1}
]

All multiplication fibers and zero products are retained in this formula.

### 4.2 Normalized form

Write
[
p=hP,\qquad d=hD,\qquad \gcd(D,P)=1,\qquad D<P,
]
and put
[
k=\gcd(D,N).
]
Then
[
\gcd(d,Np)=hk,
]
because (\gcd(D,P)=1).

The floor identities
[
\left\lfloor\frac{hP-1}{hk}\right\rfloor
========================================

\left\lfloor\frac{P-1}{k}\right\rfloor,
\qquad
\left\lfloor
\frac{\lfloor(hP-1)/N\rfloor}{h}
\right\rfloor
=============

\left\lfloor\frac{P-1}{N}\right\rfloor
]
give
[
|B_d|=hA_{N,k}(P),
\tag{4.2}
]
where
[
A_{N,k}(P)
==========

## k\left(2\left\lfloor\frac{P-1}{k}\right\rfloor+1\right)

\left(2\left\lfloor\frac{P-1}{N}\right\rfloor+1\right).
\tag{4.3}
]

Here (k\mid N) and (k<P).

### 4.3 Uniform bound for (N\ge5)

Write uniquely
[
P-1=qN+\ell k+s_0,
]
where
[
q\ge0,\qquad
0\le\ell<\frac Nk,\qquad
0\le s_0<k.
]
Then
[
A_{N,k}(P)=2q(N-1)+2k\ell+k-1.
]

Direct expansion gives
[
\begin{aligned}
&3(N-1)P-(N+1)A_{N,k}(P)\
&\quad=
q(N-1)(N-2)
+k\ell(N-5)
+3(N-1)(s_0+1)
-(N+1)(k-1).
\end{aligned}
\tag{4.4}
]

If (q\ge1), then for (N\ge5),
[
\begin{aligned}
\text{right side of (4.4)}
&\ge
(N-1)(N-2)+3(N-1)-(N+1)(k-1)\
&=(N+1)(N-k)\ge0.
\end{aligned}
]

If (q=0), then (P>k) forces (\ell\ge1). Also (k<N), and since (k\mid N),
[
k\le\frac N2.
]
Consequently,
[
\begin{aligned}
\text{right side of (4.4)}
&\ge
k(N-5)+3(N-1)-(N+1)(k-1)\
&=4N-2-6k\
&\ge N-2>0.
\end{aligned}
]

Therefore, for every (N\ge5),
[
\boxed{
|B_d(N,p)|
\le
\frac{3(N-1)}{N+1},p.
}
\tag{4.5}
]

#### The case (N\ge6)

For two owners,
[
|B_b\cup B_c|
\le |B_b|+|B_c|
\le
\frac{6(N-1)}{N+1}p.
]
Since (N+1>6),
[
\frac{6(N-1)}{N+1}p<(N-1)p=|R(N,p)|.
]
Hence the two owners cannot cover (R(N,p)).

#### The case (N=5)

Equation (4.5) gives
[
|B_d|\le2p.
]

Equality in (4.5) can occur only in the (q\ge1) branch, with
[
q=1,\qquad k=5,\qquad P=6.
]
Because (D<P) and (\gcd(D,5)=5), this forces
[
D=5.
]
Thus, for a fixed (p), the only possible equality owner is
[
d=\frac{5p}{6},
]
when (6\mid p). There is at most one such labelled speed.

Since (b\ne c), at least one of (|B_b|,|B_c|) is strictly below (2p). Therefore
[
|B_b\cup B_c|
\le |B_b|+|B_c|<4p=|R(5,p)|.
]

This proves the theorem for every (N\ge5).

### 4.4 A small-multiplier lemma

The remaining case is (N=4). The following lemma supplies the hard-case witness.

**Lemma.** Let (m) be a positive integer and let
[
0<x<y<\frac m4.
]
Then there exists (r\in{0,\ldots,m-1}) such that
[
\rho_m(rx)\ge\frac m4,
\qquad
\rho_m(ry)\ge\frac m4.
]

**Proof.** Work on (\mathbb R/\mathbb Z), writing (|z|) for distance to the nearest integer.

Choose an odd positive integer (q) such that
[
\left|\frac{qx}{2y}\right|\ge\frac14.
]

Such a (q) always exists:

* If (x\ge y/2), take (q=1). Then
  [
  \frac14\le\frac{x}{2y}<\frac12.
  ]
* If (x<y/2), choose an odd integer (q) with
  [
  \left|q-\frac yx\right|\le1.
  ]
  Then
  [
  |qx-y|\le x<\frac y2,
  ]
  so
  [
  \frac14<\frac{qx}{2y}<\frac34.
  ]

Put
[
t_0=\frac{q}{2y}.
]
Then
[
|yt_0|=\frac12,
\qquad
|xt_0|\ge\frac14.
]

The (y)-safe component around (t_0) extends a distance (1/(4y)) in each direction. The (x)-safe component has total length (1/(2x)>1/(2y)). Therefore at least one side of (t_0) remains (x)-safe for more than (1/(4y)). Hence there is a closed interval of length
[
\frac1{4y}>\frac1m
]
on which both runners are safe.

Any closed real interval of length (>1/m) contains a point (r/m) with integer (r). Reducing (r) modulo (m) gives
[
\left|\frac{rx}{m}\right|\ge\frac14,
\qquad
\left|\frac{ry}{m}\right|\ge\frac14,
]
which is the stated conclusion. (\square)

`proved-math`.

### 4.5 Exact (N=4) residue-class counts

First remove a common scaling factor. Let
[
\lambda=\gcd(p,b,c).
]
By the scaling relation in Section 3.2, a witness for
[
\left(4,\frac p\lambda,\frac b\lambda,\frac c\lambda\right)
]
is also a witness for ((4,p,b,c)). It suffices to assume
[
\gcd(p,b,c)=1.
\tag{4.6}
]

For one owner (d<p), write
[
p=hP,\qquad d=hD,\qquad \gcd(D,P)=1,
]
and put
[
k=\gcd(D,4).
]
For (s=1,2,3), define
[
C_s={r\in R(4,p):r\equiv s\pmod4}.
]
Each (C_s) has (p) elements.

Membership is periodic modulo (4P), so each reduced count is repeated (h) times. The exact class counts are
[
|B_d\cap C_s|=\frac{p+\varepsilon_s h}{2},
\tag{4.7}
]
with the following table:

| (k) | (P\bmod4) | ((\varepsilon_1,\varepsilon_2,\varepsilon_3)) | Pattern |
| --: | --------: | --------------------------------------------: | ------- |
|   1 |         0 |                                     ((0,0,0)) | (Z)     |
|   1 |         1 |                                  ((-1,-1,-1)) | (N_-)   |
|   1 |         2 |                                    ((0,-2,0)) | (C)     |
|   1 |         3 |                                  ((-1,+1,-1)) | (D)     |
|   2 |         1 |                                  ((-1,+1,-1)) | (D)     |
|   2 |         3 |                                  ((+1,-1,+1)) | (F)     |
|   4 |         1 |                                  ((+1,+1,+1)) | (G)     |
|   4 |         3 |                                  ((-1,-1,-1)) | (N_-)   |

The table follows as follows.

* If (k=1), multiplication by (D) permutes the residues modulo (4P) and maps a fixed mod-(4) class bijectively to another fixed mod-(4) class. Counting the signed strict targets
  [
  -P+1,\ldots,P-1
  ]
  by residue modulo (4) gives the first four rows.
* If (k=2), write (D=2E). Then (E) is a unit modulo (2P), and badness becomes
  [
  \rho_{2P}(Er)<P/2.
  ]
  Counting odd and even points in
  [
  -\frac{P-1}{2},\ldots,\frac{P-1}{2}
  ]
  gives the next two rows.
* If (k=4), write (D=4E). Then (E) is a unit modulo (P), and badness becomes
  [
  \rho_P(Er)<P/4.
  ]
  This gives ((P+1)/2) bad values when (P\equiv1\pmod4), and ((P-1)/2) when (P\equiv3\pmod4), independently of the candidate class.

All strict endpoints are counted correctly; equality at (P/4) or its lifted equivalent remains safe.

### 4.6 Why a hypothetical (N=4) cover must contain a (G)-type owner

For every pattern, the first and third offsets coincide. Call this the side offset, and call (\varepsilon_2) the center offset. The possible pairs are
[
\begin{array}{c|c}
\text{pattern}&(\varepsilon_{\rm side},\varepsilon_2)\ \hline
Z&(0,0)\
N_-&(-1,-1)\
C&(0,-2)\
D&(-1,+1)\
F&(+1,-1)\
G&(+1,+1).
\end{array}
]

Suppose (B_b\cup B_c) covered (R(4,p)).

If the weighted side-offset sum were negative, then
[
|B_b\cap C_1|+|B_c\cap C_1|<p,
]
so (C_1) could not be covered.

If the side-offset sum were zero, the two class counts would sum to (p). But (r=1) belongs to both bad sets because
[
b<p,\qquad c<p.
]
Thus their union in (C_1) would have at most (p-1) elements. Again (C_1) could not be covered.

Hence a cover requires the side-offset sum to be positive. It also requires the center-offset sum to be nonnegative.

Assume neither owner has pattern (G). The only remaining pattern with positive side offset is (F=(+1,-1)). Therefore at least one owner must be (F).

* (F+F) has negative center sum.
* (F+Z), (F+C), and (F+N_-) have negative center sum.
* For (F+D), positivity of the side sum says (h_F>h_D), while the center sum is
  [
  -h_F+h_D<0.
  ]

All possibilities contradict the necessary class capacities. Thus any hypothetical cover must have a (G)-type owner.

### 4.7 Eliminating the (G)-type hard case

Let the (G)-type owner be (d). Then
[
p=hP,\qquad
d=4hE,
]
where
[
P\equiv1\pmod4,\qquad
4E<P,\qquad
\gcd(E,P)=1.
]
Let the other owner be (e).

By the primitive condition (4.6),
[
\gcd(h,e)=1.
\tag{4.8}
]

Write (P=4q+1), and choose (z\pmod P) such that
[
Ez\equiv q+1\pmod P.
]
For every
[
r_k=z+kP,\qquad 0\le k<4h,
]
the (d)-product is independent of (k):
[
d r_k
\equiv 4hEz\pmod{4hP}.
]
Moreover,
[
\rho_{4hP}(d r_k)
=================

4h\rho_P(Ez)
\ge4h(q+1)>hP=p.
]
Thus every (r_k) is safe for the (G)-type owner.

It remains to select a candidate lift safe for (e).

#### Case 1: (e) is odd

By (4.8),
[
\gcd(e,4h)=1.
]
As (k) runs modulo (4h),
[
j\equiv ek\pmod{4h}
]
runs through every residue. Also
[
e r_k\equiv ez+Pj\pmod{4hP}.
]

After division by (P), the safe arc is a closed interval of length (2h) in a circle of circumference (4h). It contains at least two consecutive integer values of (j).

The excluded condition
[
4\mid z+kP
]
selects one residue class of (k\pmod4), hence one residue class of (j\pmod4). Two consecutive (j)'s cannot both lie in that one excluded class. Therefore one safe lift is a candidate.

#### Case 2: (e\equiv2\pmod4)

Write
[
e=2e_0.
]
Equation (4.8) forces (h) odd, and
[
\gcd(e_0,2h)=1.
]
As (k) varies,
[
j\equiv e_0k\pmod{2h}
]
runs through all residues modulo (2h). The safe arc after division by (2P) has length (h), so it contains at least one integer (j).

Each such (j) has two lifts modulo (4h), differing by (2h). The corresponding (r_k)'s differ modulo (4) by
[
2hP\equiv2\pmod4,
]
because (h) and (P) are odd. At most one of the two lifts is divisible by (4). The other is the required candidate.

#### Case 3: (4\mid e)

Write
[
e=4C.
]
Equation (4.8) implies (h) is odd. Put
[
A=hE=\frac d4.
]
Since (d,e<p),
[
0<A<\frac p4,
\qquad
0<C<\frac p4.
]
Also (A\ne C).

Apply the small-multiplier lemma with modulus (p) and multipliers (A,C). It gives (r_0\pmod p) such that
[
\rho_p(Ar_0)\ge\frac p4,
\qquad
\rho_p(Cr_0)\ge\frac p4.
]
Therefore
[
\rho_{4p}(d r_0)
================

4\rho_p(Ar_0)\ge p,
]
and similarly
[
\rho_{4p}(e r_0)\ge p.
]

Because (p=hP) is odd, the four lifts
[
r_0,\quad r_0+p,\quad r_0+2p,\quad r_0+3p
]
occupy all four residue classes modulo (4). Their products under both (d) and (e) are unchanged modulo (4p), since both coefficients are divisible by (4). Choose any lift not divisible by (4).

Every possible parity of (e) has now been covered. Thus a (G)-type owner cannot participate in a complete two-owner cover.

Combining Sections 4.6 and 4.7 proves the theorem for (N=4).

### 4.8 Conclusion

The theorem holds for (N=4) by the residue-class argument and for every (N\ge5) by the exact cardinality bound. Hence:

[
\boxed{
\forall N\ge4,\ \forall p\ge1,\ \forall,0<b<c<p,\quad
B_b(N,p)\cup B_c(N,p)\ne R(N,p).
}
]

`proved-math`.

---

## 5. Common-overlap analysis

### 5.1 Exact single-set counts

Equation (4.1) is the exact gcd-sensitive formula:
[
|B_d|
=====

## g_d\left(2\left\lfloor\frac{p-1}{g_d}\right\rfloor+1\right)

h_d\left(2\left\lfloor
\frac{\lfloor(p-1)/N\rfloor}{h_d}
\right\rfloor+1\right),
]
where
[
g_d=\gcd(d,Np),
\qquad
h_d=\gcd(d,p).
]

The first term retains all (g_d)-fold multiplication fibers. The second term removes precisely the bad fibers whose candidates are excluded multiples of (N).

### 5.2 Exact intersection formula

Let
[
I_{M,p}={x\in\mathbb Z/M\mathbb Z:\rho_M(x)<p},
]
and define
[
\phi_L:\mathbb Z/L\mathbb Z\longrightarrow
(\mathbb Z/L\mathbb Z)^2,
\qquad
\phi_L(r)=(br,cr).
]
Its kernel has size
[
\delta_L=\gcd(b,c,L).
]

Put
[
s=\left\lfloor\frac{p-1}{N}\right\rfloor,
\qquad
J_{p,s}={x\in\mathbb Z/p\mathbb Z:\rho_p(x)\le s}.
]

Every image point of (\phi_L) has exactly (\delta_L) preimages. Therefore
[
\boxed{
\begin{aligned}
|B_b\cap B_c|
&=
\delta_{Np}
\left|
\operatorname{im}\phi_{Np}
\cap
(I_{Np,p}\times I_{Np,p})
\right|\
&\quad-
\delta_p
\left|
\operatorname{im}\phi_p
\cap
(J_{p,s}\times J_{p,s})
\right|.
\end{aligned}
}
\tag{5.1}
]

The second term is exactly the intersection lying over excluded candidates (r=Nt).

For a target pair ((x,y)) modulo (L), membership in (\operatorname{im}\phi_L) can be checked without cancellation:

1. Put
   [
   g_b=\gcd(b,L),\qquad g_c=\gcd(c,L).
   ]
2. Require (g_b\mid x) and (g_c\mid y).
3. Define
   [
   r_b\equiv
   (b/g_b)^{-1}(x/g_b)
   \pmod{L/g_b},
   ]
   and similarly (r_c).
4. Require
   [
   r_b\equiv r_c
   \pmod{\gcd(L/g_b,L/g_c)}.
   ]

When compatible, the system has exactly
[
\gcd(g_b,g_c)=\gcd(b,c,L)
]
canonical solutions.

This is an exact fiber formula. Distinct target pairs and distinct canonical candidates remain distinct.

### 5.3 Lattice formulation

Define
[
\Lambda_{b,c,L}
===============

{(x,y)\in\mathbb Z^2:
(x\bmod L,y\bmod L)\in\operatorname{im}\phi_L}.
]
A fundamental domain is ([0,L)^2). Since the image has (L/\delta_L) points,
[
\det\Lambda_{b,c,L}=L\delta_L.
]

The strict target square can be represented as
[
[-p+1,p-1]^2.
]
The boundary lines (x=\pm p) and (y=\pm p) are excluded from badness. Formula (5.1) is precisely the corresponding lattice-point count, with multiplicity (\delta_L), minus the excluded (N)-multiple fibers.

### 5.4 How overlap closes the proof

For (N\ge6), forced overlap is unnecessary because the sum of the exact one-owner bounds is already below (|R|).

For (N=5), the only equality owner is unique, so distinct labelled owners again have total bad capacity below (|R|).

For (N=4), the class table retains the necessary overlap information:

* If the two side-class counts sum to (p), (r=1) is a common bad point, so the union has size at most (p-1) in that class.
* If the class capacities could otherwise support a cover, one owner must have pattern (G).
* The (G)-type lifting argument constructs a common safe candidate, including the cases with nontrivial gcd fibers and coefficients divisible …389 tokens truncated…r that owner.

For example, at
[
(N,p,b,c)=(4,5,1,4),
]
no (tp\pm1) slice gives a simultaneous witness, while the complete uncovered set is
[
{7,13}.
]

Thus a universal proof based only on (tp) and (tp\pm1) is `rejected`. The exact slice identities remain valid and useful local statements.

---

## 7. Adversarial review

| Stress regime                 | Resolution                                                                                                                                          |
| ----------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| (b=1,c=p-1)                   | Included without a special assumption. For (N\ge5), the exact count bound applies. For (N=4), the complete class table and (G)-type argument apply. |
| Adjacent owners (c=b+1)       | No separation or coprimality is used.                                                                                                               |
| (N\mid b), (N\mid c), or both | The count formula retains these gcds. For (N=4), coefficients divisible by (4) enter the (G), (N_-), or common-scaling branches.                    |
| Large common gcd with (p)     | Retained through (h=\gcd(d,p)). For (N=4), a common factor of (p,b,c) is removed only by the proved exact scaling correspondence.                   |
| (N\mid p)                     | The (tp) slice may contain no candidates, but the main proof does not require that slice.                                                           |
| (\gcd(N,p)=1)                 | No special treatment is required.                                                                                                                   |
| Equality-only witnesses       | All complements are closed. The proof uses closed arcs, and the fixtures (r=3) at ((4,3,1,2)) and (r=6) at ((4,6,1,5)) retain equality.             |
| Nonunit candidates            | Retained throughout. The exact formulas count all multiplication fibers.                                                                            |
| Product collisions            | Distinct owner labels remain distinct even when their product residues coincide.                                                                    |
| (N=4) edge                    | Proved separately by exact mod-(4) class counts and the small-multiplier lemma.                                                                     |
| (N=3)                         | The arithmetic extension is `refuted` by two complete covers.                                                                                       |
| Common scaling                | Proved by the exact projection and copy relation; the moduli are not identified.                                                                    |

---

## 8. Prompt95 consequence

Fix (n\ge2), put (N=n+1), and let
[
a:\operatorname{Fin}n\to\mathbb N
]
be positive and injective.

### Step 1

For every pivot (j),
[
|R_j|=(N-1)a_j.
]
Since (N\ge3) and (a_j>0),
[
R_j\ne\varnothing.
]

`proved-math`.

### Step 2

Let (j_\star) be the maximum-speed label in (F(a)). Injectivity makes it unique.

If (i) is an internal owner, then
[
i\in F(a)\setminus{j_\star}.
]
Positivity gives (a_i>0), and maximality plus injectivity gives
[
a_i<a_{j_\star}.
]

`proved-math`.

### Step 3: singleton rigidity

Let (N\ge3) and (0<d<p).

For (N\ge4), before excluding multiples of (N),
[
|A_d|
=====

g\left(2\left\lfloor\frac{p-1}{g}\right\rfloor+1\right)
\le 2p-2+g.
]
Since
[
g=\gcd(d,Np)\le d\le p-1,
]
[
|B_d|\le|A_d|\le3p-3<3p\le(N-1)p=|R|.
]

For (N=3), use the normalized formula with (k=\gcd(D,3)).

If (k=1),
[
\frac{|B_d|}{h}
===============

2\left(P-1-\left\lfloor\frac{P-1}{3}\right\rfloor\right)
<2P.
]

If (k=3), putting (q=\lfloor(P-1)/3\rfloor),
[
\frac{|B_d|}{h}=4q+2
\le\frac{4P+2}{3}<2P.
]

Thus
[
|B_d|<(N-1)p
]
for every (N\ge3), so a positive owner (d<p) cannot singleton-cover (R(N,p)).

`proved-math`.

### Step 4

Assume (N\ge4). Let (C) be an internal inclusion-minimal complete cover at (j_\star).

* (|C|=0) is impossible because (R_{j_\star}\ne\varnothing).
* (|C|=1) is impossible by singleton rigidity.
* If (|C|=2), injectivity and Step 2 let the two speeds be ordered
  [
  0<b<c<a_{j_\star}.
  ]
  TWO-LOWER-OWNER-NONCOVER says their two bad sets do not cover the row.

Therefore
[
|C|\ge3.
]

`proved-math`.

### Step 5

If (N=3), then (n=2). There is at most one nonpivot label. Hence every internal owner set has size at most one, and Steps 1 and 3 exclude an internal complete cover.

This is an owner-count argument. It does not extend the two-owner arithmetic theorem to (N=3).

`proved-math`.

### Step 6

Assume
[
|F(a)|\le3.
]
Suppose an internal complete cover (C) existed. Since (C) is finite, repeatedly delete owners while completeness is retained, or equivalently choose a complete subset of minimum cardinality. This produces an internal inclusion-minimal complete cover (C_{\min}).

Because
[
C_{\min}\subseteq F(a)\setminus{j_\star},
]
[
|C_{\min}|\le |F(a)|-1\le2.
]

For (N\ge4), this contradicts Step 4. For (N=3), it contradicts Step 5. Therefore no internal complete cover exists when
[
|F(a)|\le3.
]

`proved-math`.

### Step 7

The Prompt95 redundancy statement restricted to (|F(a)|\le3) says:

> For every internal complete cover (C), some owner can be deleted while retaining completeness.

Step 6 proves that there is no internal complete cover (C) in this range. Therefore the universal redundancy statement is true vacuously. No particular redundant owner has been constructed.

`proved-math`.

For (|F(a)|\ge4), the present theorem proves only that an internal inclusion-minimal cover has at least three owners. Prompt95 in that range remains `open`.

---

## 9. Finite falsifiers

The scans are supporting `computed finite evidence`. They are not premises of the proof.

### 9.1 Falsifier A pseudocode

```text
run all exact fixtures
fail immediately on any mismatch

for N = 4,...,18:
  for p = 1,...,160:
    M = N*p

    construct R literally:
      for r = 0,...,M-1:
        retain r exactly when N does not divide r

    for each d = 1,...,p-1:
      construct labelled B_d literally:
        for r = 0,...,M-1:
          set bit r exactly when
            N does not divide r
            and min((r*d) mod M, M-((r*d) mod M)) < p

    for b = 1,...,p-1:
      for c = b+1,...,p-1:
        compute R minus (B_b union B_c)
        scan canonical bits from r=0 upward
        record the least uncovered r
        stop on the first empty result
```

Prebuilding (B_d) is equivalent to reconstructing it for each pair because (B_d) depends only on (N,p,d). The final bit scan uses increasing machine words and increasing bit positions, so it returns the least canonical (r).

Result:

[
10{,}048{,}800
]
ordered owner pairs completed, with
[
\texttt{first_failure=null}.
]

### 9.2 Falsifier B pseudocode

```text
run all exact fixtures
fail immediately on any mismatch

for N = 4,...,24:
  for p = 1,...,240:
    M = N*p

    construct R

    for each owner d:
      g = gcd(d,M)
      initialize empty labelled bitset B_d

      enumerate target residues in order:
        0,1,...,p-1,
        M-p+1,...,M-1

      for each target x:
        if g does not divide x:
          continue

        m = M/g
        solve
          (d/g)*r = x/g mod m
        using the inverse of d/g modulo m

        enumerate the g canonical solutions
          r = r_0 + k*m, k=0,...,g-1

        retain precisely the solutions with N not dividing r
        deduplicate only by setting the output bit

    enumerate b,c in lexicographic order
    record the least uncovered canonical residue
```

The two target intervals are exactly (\rho_M(x)<p):

* (0\le x\le p-1) is the lower strict neighborhood;
* (M-p+1\le x\le M-1) is the upper strict neighborhood;
* (x=p) and (x=M-p) are omitted and therefore safe;
* (x=0) is included.

Result:

[
47{,}780{,}880
]
ordered owner pairs completed, with
[
\texttt{first_failure=null}.
]

On the common domain, the fiber bitsets were compared pointwise against the literal predicate for
[
225{,}271{,}200
]
owner-residue records, with zero mismatches. The two scans produced the same common-domain digest
[
\texttt{0e430dd2e7f1b766}.
]

### 9.3 Reproducibility record

Both programs compiled with:

```text
gcc (Debian 14.2.0-19) 14.2.0
-O3 -std=c11 -Wall -Wextra -Werror
```

Both exited with status (0).

| Artifact           | SHA-256                                                            |
| ------------------ | ------------------------------------------------------------------ |
| Falsifier A source | `8eb381637769cf3981163c7c2be1438c696fc21300b7aba239095cdd113c6f35` |
| Falsifier A result | `514a267c3959bd49a3288201c281f2b976c7dedb5118c7d63548c7f7ec02a739` |
| Falsifier B source | `8d302770222002a4ab9ef17f64b18762dc836ecbe84102d5a3fe8f6f703376ab` |
| Falsifier B result | `76c08f87964ee3a89d13957faed86a29c05cb66b298266c69771173246d8ba8d` |
| Manifest           | `b58b80d1a991c44ea001853e07d2421116cff59d56eaed9dbb7357bd9970a01e` |

Files:

* [Falsifier A source](sandbox:/mnt/data/p100_falsifiers/falsifier_a_literal.c)
* [Falsifier A machine-readable result](sandbox:/mnt/data/p100_falsifiers/falsifier_a_result.json)
* [Falsifier B source](sandbox:/mnt/data/p100_falsifiers/falsifier_b_fibers.c)
* [Falsifier B machine-readable result](sandbox:/mnt/data/p100_falsifiers/falsifier_b_result.json)
* [Machine-readable manifest](sandbox:/mnt/data/p100_falsifiers/manifest.json)

---

## 10. Proof-obligation ledger

| Claim                                        | Dependencies                                            | Label         | Falsifier                                                     | First open edge              | Downstream owner                      |                                |                                |
| -------------------------------------------- | ------------------------------------------------------- | ------------- | ------------------------------------------------------------- | ---------------------------- | ------------------------------------- | ------------------------------ | ------------------------------ |
| Strict/closed complement equivalence         | Frozen definitions                                      | `proved-math` | Equality fixtures                                             | None                         | Main theorem                          |                                |                                |
| Exact (                                      | B_d                                                     | ) formula     | Multiplication fibers; excluded (N)-multiples                 | `proved-math`                | A/B pointwise comparison              | None                           | (N\ge5) bound                  |
| Uniform bound for (N\ge5)                    | Normalized formula; divisor (k\mid N)                   | `proved-math` | Both scans                                                    | None                         | Main theorem                          |                                |                                |
| Equality classification at (N=5)             | Equality analysis in (4.4)                              | `proved-math` | Both scans                                                    | None                         | Main theorem                          |                                |                                |
| Small-multiplier lemma                       | Continuous safe intervals; grid spacing                 | `proved-math` | (N=4) scans                                                   | None                         | (G)-type elimination                  |                                |                                |
| Exact (N=4) class table                      | Mod-(4) target counts and gcd fibers                    | `proved-math` | Both scans                                                    | None                         | (N=4) theorem                         |                                |                                |
| Hypothetical (N=4) cover forces (G)          | Class capacities; common point (r=1)                    | `proved-math` | Both scans                                                    | None                         | (G)-type elimination                  |                                |                                |
| (G)-type elimination                         | Primitive scaling; parity lifts; small-multiplier lemma | `proved-math` | Both scans                                                    | None                         | Main theorem                          |                                |                                |
| TWO-LOWER-OWNER-NONCOVER                     | (N=4) and (N\ge5) branches                              | `proved-math` | Both scans                                                    | None                         | Prompt95 bridge                       |                                |                                |
| Singleton rigidity for (N\ge3)               | Exact count and full-preimage bound                     | `proved-math` | Route fixtures                                                | None                         | Prompt95 bridge                       |                                |                                |
| No internal cover for (                      | F(a)                                                    | \le3)         | Owner count; finite minimalization                            | `proved-math`                | Route fixtures                        | None                           | Restricted Prompt95 redundancy |
| Prompt95 for (                               | F(a)                                                    | \ge4)         | Requires control of minimal covers with at least three owners | `open`                       | Three-owner fixtures do not settle it | Three-or-more-owner redundancy | Prompt95                       |
| Unrestricted pivot theorem and Lonely Runner | Not implied by the local two-owner theorem              | `open`        | None claimed                                                  | Unrestricted pivot selection | Separate research route               |                                |                                |

---

## 11. Declaration-level plan

The following dependency order contains only statements established above.

1. `strict_bad_target_characterization`
   The residues with (\rho_{Np}(x)<p) are exactly the two displayed strict target intervals.
   `proved-math`.

2. `bad_set_cardinality_exact`
   Establish equation (4.1), including subtraction of excluded (N)-multiple fibers.
   `proved-math`.

3. `bad_set_cardinality_normalized`
   Establish equations (4.2) and (4.3).
   `proved-math`.

4. `bad_set_bound_N_ge_5`
   Establish equation (4.5) and the (N=5) equality classification.
   `proved-math`.

5. `quarter_safe_small_multipliers`
   Formalize the small-multiplier interval lemma.
   `proved-math`.

6. `N4_candidate_class_counts`
   Formalize the eight-row mod-(4) class table.
   `proved-math`.

7. `N4_cover_forces_G_type`
   Formalize the weighted class-capacity argument.
   `proved-math`.

8. `N4_G_type_has_common_safe_candidate`
   Formalize the odd, twice-odd, and divisible-by-four lift cases.
   `proved-math`.

9. `two_lower_owner_noncover`
   Combine the (N=4), (N=5), and (N\ge6) branches.
   `proved-math`.

10. `singleton_lower_owner_noncover`
    Establish singleton rigidity for (N\ge3).
    `proved-math`.

11. `internal_cover_cardinality_ge_three`
    Apply the two-owner theorem at an internal maximum covered pivot.
    `proved-math`.

12. `no_internal_cover_when_F_card_le_three`
    Apply finite deletion and the (N=3) owner-count case.
    `proved-math`.

---

## 12. Final evidence table

| Evidence class                               | Statement                                                           | Status                     |                                                        |               |
| -------------------------------------------- | ------------------------------------------------------------------- | -------------------------- | ------------------------------------------------------ | ------------- |
| Response proof                               | TWO-LOWER-OWNER-NONCOVER for all frozen (N\ge4,p,b,c)               | `proved-math`              |                                                        |               |
| Response proof                               | Exact (                                                             | B_d                        | ) count and normalized (N\ge5) bound                   | `proved-math` |
| Response proof                               | Separate unrestricted (N=4) argument                                | `proved-math`              |                                                        |               |
| Response proof                               | Singleton rigidity for (N\ge3)                                      | `proved-math`              |                                                        |               |
| Response proof                               | Prompt95 consequence when (                                         | F(a)                       | \le3)                                                  | `proved-math` |
| Finite computation                           | Literal scan of (10{,}048{,}800) pairs                              | `computed finite evidence` |                                                        |               |
| Finite computation                           | Fiber scan of (47{,}780{,}880) pairs                                | `computed finite evidence` |                                                        |               |
| Finite computation                           | Zero mismatches in (225{,}271{,}200) common-domain pointwise checks | `computed finite evidence` |                                                        |               |
| Boundary extension                           | Same two-owner statement with (N=3)                                 | `refuted`                  |                                                        |               |
| Altered fixture                              | Uncovered set ({3}) at ((4,3,1,2))                                  | `rejected`                 |                                                        |               |
| Slice-only proof route                       | Universal witness restricted to (tp,tp\pm1)                         | `rejected`                 |                                                        |               |
| Conditional claims                           | None used in the proof                                              | `proved-math`              |                                                        |               |
| Prompt95 with (                              | F(a)                                                                | \ge4)                      | Two-owner theorem gives only a three-owner lower bound | `open`        |
| Unrestricted pivot theorem and Lonely Runner | No conclusion supplied by this proof                                | `open`                     |                                                        |               |


