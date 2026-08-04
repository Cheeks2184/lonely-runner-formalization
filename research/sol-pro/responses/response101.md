## 1. Disposition

**STOP**

`COVERED-PIVOT-SUBCRITICAL-WEIGHTS` is **refuted**. In fact, there is a uniform theorem-domain counterfamily in every dimension (n\ge 4):

[
a_k=c(n+1)^k,\qquad 0\le k<n,\qquad c\in \mathbb Z_{>0}.
]

For this family, exactly the first (n-1) pivots are covered, but their induced normalized bad-incidence matrix has spectral radius at least one. The primitive (n=4) instance is

[
(1,5,25,125).
]

---

## 2. Frozen statement audit

Fix (n\ge2), set (N=n+1), and let (a:\operatorname{Fin}n\to\mathbb N) be positive and injective.

For pivot (j),

[
p_j=a_j,\qquad M_j=Np_j.
]

The candidate set is literally

[
R_j={0\le r<M_j:N\nmid r}.
]

There are (p_j) multiples of (N) in ({0,\ldots,Np_j-1}), including zero, so

[
|R_j|=Np_j-p_j=np_j>0.
]

For (i\ne j),

[
B_i^j={r\in R_j:\rho_{Np_j}(ra_i)<p_j}.
]

The inequality is strict. Both points with circular distance exactly (p_j) are safe. Zero modular products, nonunits, antipodes, repeated multiplication fibers, and coincident labelled bad sets are retained.

The pivot label is excluded from the owner set. Independently,

[
rp_j\bmod Np_j=p_j(r\bmod N),
]

and because (r\in R_j), (r\bmod N\in{1,\ldots,N-1}). Hence

[
\rho_{Np_j}(rp_j)
=================

p_j\min(r\bmod N,N-(r\bmod N))
\ge p_j.
]

Thus the pivot coordinate is always safe, including equality.

Therefore

[
Q_j=R_j\setminus\bigcup_{i\ne j}B_i^j
]

is exactly the canonical pivot-certificate set at row (j), and

[
F(a)={j:Q_j=\varnothing}.
]

For (j,i\in F(a)),

[
A_F(j,i)=
\begin{cases}
0,&i=j,[2mm]
|B_i^j|/(np_j),&i\ne j.
\end{cases}
]

Equal owner sets remain separate labelled matrix entries. Rows and columns are restricted to (F(a)), not all labels.

For any finite nonnegative rational matrix (A), the following are equivalent:

[
\exists x\in\mathbb Q_{>0}^m,\quad Ax<x,
]

[
\rho(A)<1.
]

Indeed, if (Ax<x), set

[
\theta=\max_j\frac{(Ax)_j}{x_j}<1.
]

For (D=\operatorname{diag}(x)), every row sum of (D^{-1}AD) is at most (\theta), so

[
\rho(A)=\rho(D^{-1}AD)\le|D^{-1}AD|_\infty\le\theta<1.
]

Conversely, if (\rho(A)<1), then

[
(I-A)^{-1}=\sum_{k\ge0}A^k
]

is entrywise nonnegative. Since (A) is rational,

[
x=(I-A)^{-1}\mathbf1
]

is rational, (x\ge\mathbf1>0), and

[
Ax=x-\mathbf1<x.
]

Thus the rational formulation and the spectral formulation are exactly equivalent.

---

## 3. Anti-tautology and overlap audit

Consider three abstract labels with singleton candidate sets (R_1,R_2,R_3).

In the first abstract system, let

[
B_3^1=R_1,\qquad B_3^2=R_2,
]

and let every other bad set be empty. Then

[
F={1,2},
\qquad
A_F=
\begin{pmatrix}
0&0\
0&0
\end{pmatrix}.
]

Thus a proper covered set can have a subcritical induced matrix.

In a second abstract system, let

[
B_2^1=R_1,\qquad B_1^2=R_2,
]

and leave row (3) uncovered. Then again (F={1,2}), but now

[
A_F=
\begin{pmatrix}
0&1\
1&0
\end{pmatrix},
]

whose spectral radius is one. Hence subcriticality can fail even though not all rows are covered.

The matrix theorem is therefore not a set-theoretic reformulation of (F(a)\ne\operatorname{Fin}n).

The counterfamily below preserves this separation arithmetically. Its final, uncovered speed is omitted from (A_F), while that same speed completely covers every preceding pivot. The resulting internal matrix on (F(a)) is supercritical even though a pivot certificate exists at the omitted final pivot.

No canonical cover, private point, Hall transport, sparse selected cover, maximum-pivot exchange, local scalar score, optimized margin, unit-stratum argument, deletion, descent, prime forcing, packing, or cross-modulus transport is used.

---

## 4. Exact cardinality formula

Fix a pivot speed (p>0), an owner speed (q>0), and put

[
M=Np,\qquad
g=\gcd(q,Np),\qquad
d=\gcd(q,p).
]

Then

[
\boxed{
|B_q^p|
=======

## g\left(1+2\left\lfloor\frac{p-1}{g}\right\rfloor\right)

d\left(1+2\left\lfloor\frac{p-1}{Nd}\right\rfloor\right).
}
]

Here (B_q^p) denotes the bad set at pivot (p) owned by (q), before attaching coordinate labels.

### Count over all residues modulo (Np)

Multiplication by (q) on (\mathbb Z/(Np)) has image consisting of the multiples of (g), and every image point has exactly (g) preimages.

Because (N\ge3), the strict bad arc is the disjoint union

[
{0,1,\ldots,p-1}
\cup
{Np-p+1,\ldots,Np-1}.
]

The image multiples of (g) in this arc are zero and the two reflections of

[
g,2g,\ldots,
\left\lfloor\frac{p-1}{g}\right\rfloor g.
]

Thus the number of bad residues before removing (N)-multiples is

[
T
=

g\left(1+2\left\lfloor\frac{p-1}{g}\right\rfloor\right).
]

The use of (p-1), rather than (p), is the strict-endpoint correction.

### Remove the excluded (N)-multiples

Every excluded residue has the form (r=Ns), with (s) running modulo (p). For (z) modulo (p),

[
\rho_{Np}(Nz)=N\rho_p(z).
]

Consequently,

[
\rho_{Np}(Nqs)<p
\iff
\rho_p(qs)<\frac pN.
]

Multiplication by (q) modulo (p) has image the multiples of (d), each with (d) preimages. A positive image point (d\ell) lies in the strict short arc exactly when

[
Nd\ell<p,
]

or equivalently

[
1\le\ell\le
\left\lfloor\frac{p-1}{Nd}\right\rfloor.
]

Hence the number of excluded (N)-multiples that were counted as bad is

[
E
=

d\left(1+2\left\lfloor\frac{p-1}{Nd}\right\rfloor\right).
]

Subtracting (E) from (T) gives the boxed formula.

### Reduced form

Write

[
p=dP,\qquad q=dQ,\qquad \gcd(P,Q)=1,
]

and set

[
h=\gcd(Q,N).
]

Then

[
g=dh,
]

and

[
\left\lfloor\frac{dP-1}{dh}\right\rfloor
========================================

\left\lceil\frac Ph\right\rceil-1,
\qquad
\left\lfloor\frac{dP-1}{Nd}\right\rfloor
========================================

\left\lceil\frac PN\right\rceil-1.
]

Therefore

[
\boxed{
|B_q^p|
=======

d\left[
h\left(2\left\lceil\frac Ph\right\rceil-1\right)
------------------------------------------------

\left(2\left\lceil\frac PN\right\rceil-1\right)
\right].
}
]

The normalized entry is

[
\boxed{
\frac{|B_q^p|}{np}
==================

\frac{
h(2\lceil P/h\rceil-1)
----------------------

(2\lceil P/N\rceil-1)
}{
nP
}.
}
]

This form incorporates all gcd fibers, zero products, nonunits, both cyclic sides, and strict endpoint corrections.

---

## 5. Uniform attack

Let (n\ge4), put (N=n+1), and fix any (c\in\mathbb Z_{>0}). Define

[
a_k=cN^k,\qquad 0\le k<n.
]

These speeds are positive and injective.

### Exact covered set

For (0\le j<n-1),

[
p_j=cN^j,\qquad M_j=Np_j=cN^{j+1}=a_{j+1}.
]

The owner (j+1) therefore satisfies

[
ra_{j+1}\equiv0\pmod{M_j}
]

for every candidate (r). Hence

[
B_{j+1}^j=R_j,
]

so every pivot (j<n-1) is covered.

Now consider the last pivot

[
p=cN^{n-1},\qquad M=cN^n.
]

Set

[
r_*=\sum_{t=0}^{n-1}N^t=\frac{N^n-1}{N-1}.
]

Since (r_*\equiv1\pmod N), it belongs to (R_{n-1}).

For a lower owner (a_k=cN^k), put (m=n-k\ge2) and

[
s_m=\sum_{t=0}^{m-1}N^t.
]

Reduction modulo (cN^n) gives

[
r_*a_k\bmod cN^n=cN^ks_m.
]

Moreover,

[
s_m\ge N^{m-1},
]

and

[
\frac{s_m}{N^{m-1}}
===================

1+\frac1N+\cdots+\frac1{N^{m-1}}
<
\frac{N}{N-1}
\le N-1.
]

Therefore

[
s_m\le N^m-N^{m-1}.
]

Both cyclic distances are consequently at least (N^{m-1}), and

[
\rho_{cN^n}(r_*a_k)
===================

cN^k\rho_{N^m}(s_m)
\ge
cN^kN^{m-1}
===========

# cN^{n-1}

p.
]

Thus (r_*) is safe for every lower owner. The pivot coordinate is safe by the direct pivot calculation. Hence

[
r_*\in Q_{n-1},
]

and

[
\boxed{F(a)={0,1,\ldots,n-2}.}
]

### Exact induced matrix

Let (j,k\in F(a)), (j\ne k).

If (k>j), then for (p=cN^j), (q=cN^k),

[
d=p,\qquad P=1,\qquad h=N.
]

The cardinality formula gives

[
|B_q^p|=p(N-1)=np,
]

so

[
A_F(j,k)=1.
]

If (k<j), then

[
d=cN^k,\qquad P=N^{j-k},\qquad h=1.
]

Since (N\mid P),

[
|B_q^p|
=======

# d\left[(2P-1)-\left(2\frac PN-1\right)\right]

\frac{2np}{N},
]

and therefore

[
A_F(j,k)=\frac2N.
]

Thus, with (m=n-1=N-2),

[
\boxed{
A_F(j,k)=
\begin{cases}
0,&j=k,\
1,&k>j,\
2/N,&k<j.
\end{cases}
}
]

### Failure for (n=4)

Here (N=5), (m=3), and

[
A_F=
\begin{pmatrix}
0&1&1[1mm]
2/5&0&1[1mm]
2/5&2/5&0
\end{pmatrix}.
]

For the positive row vector

[
w^{\mathsf T}=(2,3,4),
]

one obtains

[
w^{\mathsf T}A_F-w^{\mathsf T}
==============================

\left(\frac45,\frac35,1\right)>0.
]

If (x>0) and (A_Fx<x), then positivity of (w) gives

[
w^{\mathsf T}A_Fx<w^{\mathsf T}x.
]

But the displayed dual identity gives

[
w^{\mathsf T}A_Fx
=================

w^{\mathsf T}x
+
\frac45x_0+\frac35x_1+x_2

>

w^{\mathsf T}x,
]

a contradiction.

### Failure for every (n\ge5)

Now (N\ge6). The sum of column (k), (0\le k\le m-1), is

[
c_k
===

# k+\frac2N(m-1-k)

k+\frac2N(N-3-k).
]

Therefore

[
c_k-1
=====

\frac{(N-2)k+N-6}{N}.
]

This is nonnegative for every (k), and it is strictly positive for every (k\ge1). Hence

[
\mathbf1^{\mathsf T}A_F\ge\mathbf1^{\mathsf T}
]

coordinatewise, with at least one strict coordinate.

For every (x>0),

[
\mathbf1^{\mathsf T}A_Fx

>

\mathbf1^{\mathsf T}x.
]

This contradicts (A_Fx<x), which would imply the reverse strict inequality after summing all rows.

Therefore no positive real, and hence no positive rational, strict-superharmonic vector exists for this family in any dimension (n\ge4).

The frozen theorem is **refuted** uniformly.

---

## 6. Dual/counterexample audit

Take the primitive counterexample

[
n=4,\qquad N=5,\qquad a=(1,5,25,125).
]

### Exact determination of (F(a))

At pivot (1), the owner (5=M_1) has zero product on every candidate, so (B_5^1=R_1).

At pivot (5), the owner (25=M_5) gives (B_{25}^5=R_5).

At pivot (25), the owner (125=M_{25}) gives (B_{125}^{25}=R_{25}).

Thus (1,5,25\in F(a)).

At pivot (125), (M=625). Choose

[
r=156.
]

Since (5\nmid156), (r\in R_{125}). For the three nonpivot owners,

[
\rho_{625}(156\cdot1)=156,
]

[
\rho_{625}(156\cdot5)
=====================

# \rho_{625}(780)

155,
]

[
\rho_{625}(156\cdot25)
======================

# \rho_{625}(3900)

150.

]

All three values are at least (125). The pivot coordinate has distance exactly (125). Therefore

[
156\in Q_{125},
]

and

[
F(a)={1,5,25}.
]

### Matrix and exact dual certificate

In increasing speed order,

[
A_F=
\begin{pmatrix}
0&1&1\
2/5&0&1\
2/5&2/5&0
\end{pmatrix}.
]

The exact positive left certificate is

[
w=(2,3,4),
\qquad
w^{\mathsf T}A_F-w^{\mathsf T}
==============================

\left(\frac45,\frac35,1\right).
]

This directly proves infeasibility of (A_Fx<x) for every (x>0).

The (M)-matrix obstruction is also exact:

[
I-A_F=
\begin{pmatrix}
1&-1&-1\
-2/5&1&-1\
-2/5&-2/5&1
\end{pmatrix}.
]

Every (2\times2) principal minor is

[
1-\frac25=\frac35>0,
]

but

[
\det(I-A_F)=-\frac{19}{25}<0.
]

Expanding by labelled closed walks gives

[
\det(I-A_F)
===========

## 1

## 3\left(\frac25\right)

## \frac25

# \frac4{25}

-\frac{19}{25}.
]

The three terms (2/5) in the first subtraction are the labelled two-cycles. The remaining (2/5) and (4/25) are the two oriented three-cycles. No residue is transported between moduli in this calculation.

An exact canonical enumeration of increasing (n=4) tuples through maximum speed (125), ordered by maximum speed and then lexicographically, returned ((1,5,25,125)) as the first failing tuple in that (n=4) segment. It occurred at ordinal (9{,}381{,}634). Coverage was checked from the literal candidate sets, and feasibility was checked through exact integer principal minors after multiplying each row of (I-A_F) by (4p_j). This minimality observation is **computed finite evidence** and is not needed for the analytic refutation.

---

## 7. Mandatory fixtures

The fixture-set identifications below were recomputed from the literal finite sets. Those finite replays are **computed finite evidence**. Every displayed matrix entry and weight slack is exact rational arithmetic using the formula in Section 4.

### 1. Known-success tuple

For

[
a=(1,4,5,6,7,11),
\qquad n=6,\quad N=7,
]

the recomputed covered-speed set is

[
F={1,4,5,11}.
]

In this order,

[
A_F=
\begin{pmatrix}
0&0&0&0\
1/4&0&1/4&1/4\
4/15&4/15&0&4/15\
3/11&3/11&3/11&0
\end{pmatrix}.
]

The exact weight vector

[
x=(1,3,3,3)
]

has slack

[
x-A_Fx
======

\left(
1,\frac54,\frac{17}{15},\frac{12}{11}
\right)>0.
]

For the two uncovered pivots, exact witnesses are (r=13) at pivot (6) and (r=15) at pivot (7).

### 2. Stopped-score success

For

[
a=(1,4,5,6,7,11,32),
\qquad n=7,\quad N=8,
]

the recomputed covered-speed set is

[
F={1,4,5,6}.
]

The induced matrix is

[
A_F=
\begin{pmatrix}
0&3/7&0&1/7\
3/14&0&3/14&1/7\
8/35&11/35&0&9/35\
5/21&5/21&5/21&0
\end{pmatrix}.
]

With (x=\mathbf1),

[
x-A_Fx
======

\left(
\frac37,\frac37,\frac15,\frac27
\right)>0.
]

Exact noncovered witnesses are (r=17) at pivot (7), (r=27) at pivot (11), and (r=78) at pivot (32).

### 3. Sparse-cover obstruction

For

[
a=(6,7,12,24,144),
\qquad n=5,\quad N=6,
]

the recomputed covered-speed set is

[
F={6,7,12,24}.
]

The induced matrix is

[
A_F=
\begin{pmatrix}
0&1/3&1/5&1/5\
3/7&0&3/7&3/7\
1/5&1/3&0&1/5\
3/10&1/3&1/5&0
\end{pmatrix}.
]

The row at pivot (7) has sum (9/7>1), so ordinary row-substochasticity is unavailable. Nevertheless,

[
x=(3,4,3,3)
]

has exact slack

[
x-A_Fx
======

\left(
\frac7{15},\frac17,\frac7{15},\frac16
\right)>0.
]

At pivot (144), (r=25) is an exact safe witness.

### 4. Restriction failure

For all labels of

[
a=(1,2,3,5),
\qquad n=4,\quad N=5,
]

the all-label matrix is

[
A_{\mathrm{all}}=
\begin{pmatrix}
0&0&0&1\
1/4&0&1/4&1/2\
1/3&1/3&0&1/3\
2/5&2/5&2/5&0
\end{pmatrix}.
]

Its row sums are exactly

[
\left(1,1,1,\frac65\right).
]

Thus

[
A_{\mathrm{all}}\mathbf1\ge\mathbf1,
]

so it is not subcritical. The actual covered set is only ({1,2}); restricting to it gives

[
A_F=
\begin{pmatrix}
0&0\
1/4&0
\end{pmatrix},
]

which is subcritical. The deliberate all-label strengthening is **refuted**.

### 5. Strict boundary

At (N=4), (p=3), (M=12), owner (q=1),

[
\rho_{12}(3)=3=p,
\qquad
\rho_{12}(9)=3=p.
]

Both reflected endpoints are safe. The literal candidate set is

[
R={1,2,3,5,6,7,9,10,11},
]

and the strict bad set is

[
B={1,2,10,11}.
]

Replacing (<p) by (\le p) would incorrectly enlarge the count from (4) to (6).

### 6. Coincident labelled bad sets

For

[
a=(1,3,13),
]

at pivot (3), (N=4) and (M=12). Since

[
13\equiv1\pmod{12},
]

the two distinct owners satisfy

[
B_1^3=B_{13}^3={1,2,10,11}.
]

They remain two labelled owner sets.

At (r=3),

[
3\cdot1\equiv3\pmod{12},
\qquad
3\cdot13\equiv3\pmod{12},
]

and both products collide at the safe equality (\rho=3=p). Neither owner is merged or deleted.

### 7. Nonunit and zero-product fibers

Take (N=6), pivot (p=7), owner (q=6), so (M=42). Then

[
g=\gcd(6,42)=6,\qquad d=\gcd(6,7)=1.
]

The formula gives

[
|B_6^7|
=======

## 6\left(1+2\left\lfloor\frac66\right\rfloor\right)

# \left(1+2\left\lfloor\frac6{6}\right\rfloor\right)

# 18-3

15.

]

Thus the normalized entry is

[
\frac{15}{35}=\frac37.
]

The nonunit candidate (r=7) satisfies

[
6r=42\equiv0\pmod{42},
]

so a zero modular product is retained in the bad set. The other nonzero zero-product fibers (14,21,28,35) are retained as well.

### 8. Common scaling

Scale every speed by (c>0). For a pivot (p), projection

[
\pi:\mathbb Z/(cNp)\longrightarrow\mathbb Z/(Np)
]

has exactly (c) points in every fiber. Because (Np) is divisible by (N),

[
N\mid r\iff N\mid\pi(r).
]

Furthermore,

[
\rho_{cNp}(r\cdot cq)
=====================

c,\rho_{Np}(\pi(r)q).
]

Therefore the scaled candidate set, every scaled labelled bad set, and every scaled (Q_j) are the full inverse images under (\pi) of their unscaled counterparts. Consequently,

[
|R_j|\mapsto c|R_j|,
\qquad
|B_i^j|\mapsto c|B_i^j|,
]

while (F), every normalized matrix entry, and feasibility are unchanged.

### 9. Coordinate permutation

For a coordinate permutation (\sigma),

[
F(\sigma a)=\sigma(F(a)).
]

If (P_\sigma) is the corresponding permutation matrix on the covered labels, then

[
A_{F(\sigma a)}
===============

P_\sigma A_F P_\sigma^{-1}.
]

A certificate (x) transports to (P_\sigma x), since

[
A_{F(\sigma a)}P_\sigma x
=========================

P_\sigma A_Fx
<
P_\sigma x.
]

### 10. Malformed-input rejection

The following are **rejected**:

* A zero speed, such as ((0,1)), because positivity fails.
* A repeated speed, such as ((1,1)), because injectivity fails.
* (n<2) in the frozen theorem.
* Including (i=j) as an owner. The schema requires (i\ne j), even though direct pivot safety makes the resulting strict self-bad set empty.
* Any candidate list not exactly (R_j). For (N=4,p=3), the required size is (9), and (r=3) cannot be omitted.
* Weak-boundary badness (\rho\le p).
* Deduplicating the owners (1) and (13) in the collision fixture.
* Replacing the exact entry (A(7,6)=3/7) in the sparse fixture by any altered value.
* Treating zero products or nonunit candidates as absent.

### 11. Synthetic negative matrix

The rational nonnegative matrix

[
C=
\begin{pmatrix}
0&2\
1/2&0
\end{pmatrix}
]

has spectral radius exactly (1). Its strict inequalities would be

[
2x_2<x_1,
\qquad
\frac12x_1<x_2,
]

which respectively imply

[
x_1>2x_2,
\qquad
x_1<2x_2.
]

Thus the exact feasibility checker rejects it. This matrix is not asserted to arise from a theorem-domain tuple.

---

## 8. Implication chain

The following logical implication remains valid as a **conditional** statement.

Assume the frozen weight theorem for a fixed positive injective tuple and suppose every pivot is covered. Then

[
F(a)=\operatorname{Fin}n.
]

Let (x>0) satisfy (A_Fx<x), and choose (j) minimizing (x_j).

Coverage gives

[
R_j=\bigcup_{i\ne j}B_i^j.
]

The union bound yields

[
|R_j|
\le
\sum_{i\ne j}|B_i^j|,
]

so

[
1
\le
\sum_{i\ne j}\frac{|B_i^j|}{|R_j|}.
]

Since (x_i\ge x_j),

[
\sum_{i\ne j}
\frac{|B_i^j|}{|R_j|}x_i
\ge
x_j
\sum_{i\ne j}
\frac{|B_i^j|}{|R_j|}
\ge x_j.
]

This contradicts the strict row inequality. Therefore not all pivots are covered, so some (Q_j) is nonempty.

Choose (r\in Q_j). Then:

[
N\nmid r,
]

[
\rho_{Np_j}(rp_j)\ge p_j
]

by direct pivot safety, and for every (i\ne j),

[
r\notin B_i^j
\implies
\rho_{Np_j}(ra_i)\ge p_j.
]

Thus (r) is the exact positive-integer pivot certificate.

For (n=1), take (N=2) and (r=1). Then

[
\rho_{2p}(p)=p,
]

so the one-coordinate case is immediate.

Using the accepted equivalences only at this final stage:

[
\text{exact positive-integer pivot certificate}
\iff
\text{positive-integer LRC},
]

and

[
\text{positive-integer LRC}
\iff
\text{unrestricted positive-real LRC}.
]

Every arrow in this implication is valid. However, its initial weight theorem is **refuted**, so this route does not prove unrestricted LRC.

---

## 9. Claim table

| Claim                                                               | Hypotheses                                                  |             Status label | Proof/evidence location |             |           |
| ------------------------------------------------------------------- | ----------------------------------------------------------- | -----------------------: | ----------------------- | ----------- | --------- |
| Exact formula for (                                                 | B_i^j                                                       |                        ) | (n\ge2), positive (p,q) | proved-math | Section 4 |
| Rational strict weights are equivalent to (\rho(A_F)<1)             | finite nonnegative rational (A_F)                           |              proved-math | Section 2               |             |           |
| (F(cN^k)={0,\ldots,n-2}) for the power family                       | (n\ge4), (c>0)                                              |              proved-math | Section 5               |             |           |
| Power-family matrix has upper entries (1) and lower entries (2/N)   | same                                                        |              proved-math | Section 5               |             |           |
| No positive strict-superharmonic weights exist for the power family | (n\ge4)                                                     |              proved-math | Section 5               |             |           |
| `COVERED-PIVOT-SUBCRITICAL-WEIGHTS`                                 | frozen unrestricted quantifiers                             |                  refuted | Sections 5–6            |             |           |
| ((1,5,25,125)) is an exact theorem-domain counterexample            | (n=4)                                                       |                  refuted | Section 6               |             |           |
| First failure in the exact (n=4), maximum-(\le125) canonical scan   | increasing tuples                                           | computed finite evidence | Section 6               |             |           |
| Three required positive fixtures admit exact rational weights       | literal finite definitions                                  | computed finite evidence | Section 7               |             |           |
| All-label strengthening for ((1,2,3,5))                             | use all labels instead of (F(a))                            |                  refuted | Section 7.4             |             |           |
| Scaling and permutation invariance                                  | common positive scaling or coordinate permutation           |              proved-math | Sections 7.8–7.9        |             |           |
| Weight theorem implies pivot certificate and unrestricted LRC       | assuming the weight theorem and accepted final equivalences |              conditional | Section 8               |             |           |
| This matrix route proves unrestricted LRC                           | no valid premise remains                                    |                 rejected | Section 8               |             |           |

---

## 10. Single next obligation

none

