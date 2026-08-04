## 1. Disposition

**STOP**

The frozen lemma is false.

For (n=3), (N=4), and

[
a=(6,12,48)=6(1,2,8),
]

the three exact degree-(6) Gram blocks are

[
K_{6}=-\frac14 I_6,\qquad
K_{12}=-\frac14 I_6,\qquad
K_{48}=0_6.
]

Consequently, for every block vector (Z=(z_6,z_{12},z_{48})),

[
E_a(Z)
======

-\frac14\lVert z_6\rVert_2^2
-\frac14\lVert z_{12}\rVert_2^2
\le 0.
]

This remains true when (\lVert Z\rVert=1), so the required strict positive gap does not exist. The third pivot nevertheless has (G_{48}=36) uncovered candidates. Thus certificate existence does not imply the frozen low-degree signed-Gram gap.

More generally, every tuple

[
(c,2c,8c),\qquad c\ge 6,
]

has the same three Gram blocks.

---

## 2. Status table

| Claim or dependency                                                                                   | Status                     | Exact boundary                                                                                           |
| ----------------------------------------------------------------------------------------------------- | -------------------------- | -------------------------------------------------------------------------------------------------------- |
| `exists_witness_iff_exists_pivot_certificate`                                                         | `proved-lean`              | Accepted exactly as supplied.                                                                            |
| `positiveIntegerConjecture_iff_pivotCertificateConjecture`                                            | `proved-lean`              | Accepted exactly as supplied.                                                                            |
| `conjecture_iff_positiveIntegerConjecture`                                                            | `proved-lean`              | Accepted exactly as supplied.                                                                            |
| `PART-12` candidate filter, strict Dirichlet kernel, multiplication pullback, and bad-set convolution | `proved-math`              | Not used to infer the spectral gap.                                                                      |
| Fixture counts and multiplicity distributions below                                                   | `computed finite evidence` | Bounded arithmetic only.                                                                                 |
| Common-scaling cancellation identity and the matrices for ((6,12,48))                                 | `conjectural`              | An exact derivation is given below, but this response does not self-promote it before independent audit. |
| Recommended mathematical disposition of `GLOBAL-DEGREE-2N-SIGNED-GRAM-GAP`                            | `rejected`                 | Refuted by the displayed counterexample if the arithmetic replay succeeds.                               |
| Positive signed form implies a pivot certificate and then real LRC                                    | `conditional`              | The implication is valid under the spectral hypothesis, but the spectral hypothesis fails.               |
| Factorwise absolute main-term domination                                                              | `rejected`                 | Frozen existing boundary; not reused.                                                                    |
| Unrestricted Lonely Runner Conjecture                                                                 | `open`                     | The counterexample refutes only the stronger spectral bridge.                                            |
| A primitive-only or scale-normalized replacement                                                      | `open`                     | It is a different statement and is not established here.                                                 |

---

## 3. Exact target

Let

[
d=2n,\qquad
\zeta_j=\exp(2\pi i/M_j),\qquad
\chi_{j,m}(r)=\zeta_j^{mr},
]

with literal frequencies (m=0,\ldots,d-1). No quotient is taken when characters alias.

For (u\in\mathbb C),

[
|u|^2:=u\overline u\in\mathbb R_{\ge 0}.
]

For (z\in\mathbb C^d),

[
P_{j,z}(r)=\sum_{m=0}^{d-1}z_m\chi_{j,m}(r).
]

Write

[
w_j(r)=1-\mu_j(r)\in\mathbb Z.
]

Then

[
E_j(z)=\frac1{M_j}\sum_{r\in R_j}w_j(r)|P_{j,z}(r)|^2.
]

The matrix entries are

[
K_j[m,\ell]
===========

\frac1{M_j}\sum_{r\in R_j}
w_j(r),
\overline{\chi_{j,m}(r)}\chi_{j,\ell}(r).
]

Using the Hermitian inner product

[
\langle u,v\rangle=\sum_m \overline{u_m}v_m,
]

one obtains exactly

[
\begin{aligned}
\overline z^{,T}K_jz
&=
\frac1{M_j}\sum_{r\in R_j}w_j(r)
\left(\sum_m\overline{z_m\chi_{j,m}(r)}\right)
\left(\sum_\ell z_\ell\chi_{j,\ell}(r)\right)\
&=
\frac1{M_j}\sum_{r\in R_j}w_j(r)|P_{j,z}(r)|^2\
&=E_j(z).
\end{aligned}
]

Because (w_j(r)) is real,

[
K_j[\ell,m]=\overline{K_j[m,\ell]},
]

so (K_j) is Hermitian. It need not be positive semidefinite because its Gram summands have signed coefficients.

For (Z=(z_j)_j),

[
\lVert Z\rVert^2=\sum_j\sum_m|z_j(m)|^2,\qquad
E_a(Z)=\sum_j\overline{z_j}^{,T}K_jz_j.
]

The block matrix is (\bigoplus_jK_j). By the finite-dimensional Hermitian spectral theorem, it has a positive eigenvalue exactly when its quadratic form is positive on some nonzero vector. Normalizing that vector gives (\lVert Z\rVert=1).

The strict arithmetic boundary remains

[
\rho_{M_j}(r a_i)<p_j
]

for badness. Equality (\rho_{M_j}(r a_i)=p_j) is safe.

---

## 4. Non-tautology audit

Since (\mu_j(r)) is a natural number,

[
w_j(r)=
\begin{cases}
1,&\mu_j(r)=0,\
0,&\mu_j(r)=1,\
-(\mu_j(r)-1),&\mu_j(r)\ge 2.
\end{cases}
]

Therefore

[
E_j(z)
======

\frac1{M_j}
\left(
\sum_{r\in Q_j}|P_{j,z}(r)|^2
-----------------------------

\sum_{\substack{r\in R_j\\mu_j(r)\ge2}}
(\mu_j(r)-1)|P_{j,z}(r)|^2
\right).
]

The first genuinely new inequality required by the bridge is thus:

[
\sum_{r\in Q_j}|P_{j,z}(r)|^2

>

\sum_{\mu_j(r)\ge2}
(\mu_j(r)-1)|P_{j,z}(r)|^2
]

for at least one pivot and one polynomial supported on the fixed modes (0,\ldots,2n-1).

This is stronger than (Q_j\ne\varnothing). In the counterexample below, the pivot of speed (48) has (36) good candidates, but

[
\sum_{r\in Q_{48}}|P(r)|^2
==========================

\sum_{\mu_{48}(r)=2}|P(r)|^2
]

for every polynomial using the six frozen modes. Hence (E_{48}\equiv0).

No good-indicator identity is used to construct a positive form. Instead, the calculation shows that no such positive form exists.

---

## 5. Attack A

### 5.1 Exact common-scaling cancellation

Let (b=(b_i)_i) be any positive injective tuple and put

[
a_i=c,b_i.
]

For a fixed pivot (j), set

[
M_j^0=N b_j,\qquad M_j=cM_j^0.
]

Every residue (r\in{0,\ldots,cM_j^0-1}) has a unique expression

[
r=s+kM_j^0,
\qquad
0\le s<M_j^0,\quad 0\le k<c.
]

Because (N\mid M_j^0),

[
N\mid r\quad\Longleftrightarrow\quad N\mid s.
]

Thus the candidate set for the scaled tuple is the disjoint union of (c) copies of the base candidate set.

For every owner (i),

[
r(c b_i)\equiv c(s b_i)\pmod{cM_j^0}.
]

For (0\le u<M_j^0),

[
\rho_{cM_j^0}(cu)=c,\rho_{M_j^0}(u).
]

Therefore

[
\rho_{cM_j^0}(r c b_i)<c b_j
\quad\Longleftrightarrow\quad
\rho_{M_j^0}(s b_i)<b_j.
]

Consequently,

[
\mu_j^{,cb}(s+kM_j^0)=\mu_j^{,b}(s),
\qquad
w_j^{,cb}(s+kM_j^0)=w_j^{,b}(s).
]

For (q=\ell-m),

[
\begin{aligned}
K_j^{,cb}[m,\ell]
&=
\frac1{cM_j^0}
\sum_{s\in R_j^b}
w_j^b(s)
e^{2\pi iqs/(cM_j^0)}
\sum_{k=0}^{c-1}e^{2\pi iqk/c}.
\end{aligned}
]

The inner sum is

[
\sum_{k=0}^{c-1}e^{2\pi iqk/c}
==============================

\begin{cases}
c,&c\mid q,\
0,&c\nmid q.
\end{cases}
]

If the mode set is (0,\ldots,2n-1) and (c\ge2n), then

[
|q|\le2n-1<c.
]

Hence (c\mid q) occurs only for (q=0), equivalently (m=\ell). Define

[
\sigma_j(b)=\sum_{s\in R_j^b}(1-\mu_j^b(s)).
]

The exact scaled block is therefore

[
\boxed{
K_j^{,cb}=\frac{\sigma_j(b)}{N b_j},I_{2n}
}
\qquad(c\ge2n).
]

This is the fatal scaling arrow. Any base tuple for which every (\sigma_j(b)\le0) yields counterexamples after sufficiently large common scaling.

### 5.2 Base tuple ((1,2,8))

Take (n=3), (N=4), and

[
b=(1,2,8).
]

At the three pivots:

| Pivot | (M_j^0) | Exact nonzero weights       | (G_j) | (\sigma_j(b)) |
| ----: | ------: | --------------------------- | ----: | ------------: |
|   (1) |     (4) | (w(2)=-1)                   |   (0) |          (-1) |
|   (2) |     (8) | (w(1)=w(7)=-1)              |   (0) |          (-2) |
|   (8) |    (32) | (w=1) on (A), (w=-1) on (O) |   (6) |           (0) |

Here

[
A={9,10,11,21,22,23},
]

and

[
O={1,2,3,29,30,31}.
]

At the third pivot, (A=Q_8), while every residue in (O) has multiplicity (2). All other candidates have multiplicity (1).

Equivalently, the three exact weight polynomials are

[
W_1(X)=-X^2,
]

[
W_2(X)=-(X+X^7),
]

and

[
\begin{aligned}
W_8(X)
={}&X^9+X^{10}+X^{11}+X^{21}+X^{22}+X^{23}\
&-(X+X^2+X^3+X^{29}+X^{30}+X^{31}).
\end{aligned}
]

Their values at (X=1) are (-1,-2,0).

### 5.3 Exact counterexample

Set (c=6=2n). Then

[
a=6b=(6,12,48),
]

with

[
(M_6,M_{12},M_{48})=(24,48,192).
]

The exact candidate multiplicity data are:

| Pivot | (|R_j|) | (#{\mu=0}) | (#{\mu=1}) | (#{\mu=2}) | (\sum_{r\in R_j}(1-\mu_j(r))) |
|---:|---:|---:|---:|---:|---:|
| (6) | (18) | (0) | (12) | (6) | (-6) |
| (12) | (36) | (0) | (24) | (12) | (-12) |
| (48) | (144) | (36) | (72) | (36) | (0) |

The good candidates at the third pivot are exactly

[
Q_{48}
======

{9,10,11,21,22,23}+32{0,1,2,3,4,5}.
]

For (m,\ell\in{0,\ldots,5}), the frequency difference satisfies
(-5\le\ell-m\le5). The six-fiber character sum therefore annihilates every off-diagonal entry.

Using the scaling identity,

[
K_6=\frac{-1}{4}I_6,
]

[
K_{12}=\frac{-2}{8}I_6=-\frac14I_6,
]

and

[
K_{48}=\frac0{32}I_6=0_6.
]

These are the requested exact cyclotomic matrices, simplified to rational matrices. Their direct sum has eigenvalues

[
-\frac14\quad\text{with multiplicity }12,
\qquad
0\quad\text{with multiplicity }6.
]

Thus its largest eigenvalue is exactly (0), not strictly positive.

The same calculation applies to every (c\ge6):

[
K_c=-\frac14I_6,\qquad
K_{2c}=-\frac14I_6,\qquad
K_{8c}=0_6,
]

while

[
G=(0,0,6c).
]

---

## 6. Attack B

Let

[
L=\operatorname{lcm}_j M_j
]

and define

[
\pi_j:\mathbb Z/L\mathbb Z\longrightarrow\mathbb Z/M_j\mathbb Z
]

by reduction modulo (M_j).

Because (M_j\mid L), every residue (r\pmod{M_j}) has precisely

[
\frac{L}{M_j}
]

preimages:

[
r,\ r+M_j,\ \ldots,\ r+\left(\frac{L}{M_j}-1\right)M_j.
]

For any function (F_j) on (\mathbb Z/M_j\mathbb Z),

[
\frac1L
\sum_{x\in\mathbb Z/L\mathbb Z}
F_j(\pi_j(x))
=============

\frac1L\frac{L}{M_j}
\sum_{r\in\mathbb Z/M_j\mathbb Z}F_j(r)
=======================================

\frac1{M_j}\sum_rF_j(r).
]

Pulling back the polynomial gives

[
\widetilde P_j(x)
=================

# \sum_m z_j(m)e^{2\pi i m x/M_j}

\sum_m z_j(m)
e^{2\pi i(mL/M_j)x/L}.
]

Extend the signed candidate weight by zero outside (R_j). Then exactly

[
E_j(z_j)
========

\frac1L
\sum_{x\in\mathbb Z/L\mathbb Z}
w_j(\pi_j(x))
|\widetilde P_j(x)|^2.
]

There is no missing factor.

For the counterexample,

[
L=\operatorname{lcm}(24,48,192)=192,
]

and the three projection fiber sizes are

[
8,\quad4,\quad1.
]

The exact pulled-back sum is still

[
E_a(Z)
======

-\frac14\lVert z_6\rVert^2
-\frac14\lVert z_{12}\rVert^2.
]

The common group does not introduce cross-block terms into (E_a). Any proposed global sum-of-squares expression equal to (E_a) must have all cross terms cancel identically and must evaluate to the same nonpositive quadratic form.

The first fatal cancellation is therefore already inside each scaled pivot: averaging over the six scaling fibers kills every nonzero frequency difference available to the frozen mode set. A common carrier cannot recover information that those exact fiber averages have annihilated.

---

## 7. Falsification

Define

[
\sigma_j=\sum_{r\in R_j}(1-\mu_j(r)).
]

The required fixtures give:

| Tuple            | Pivot moduli (M_j)   | (G)             | (\sigma)               |
| ---------------- | -------------------- | --------------- | ---------------------- |
| ((1,2,8))        | ((4,8,32))           | ((0,0,6))       | ((-1,-2,0))            |
| ((1,2,3,4,5,7))  | ((7,14,21,28,35,49)) | ((0,0,0,0,2,2)) | ((0,0,-4,-4,-8,-18))   |
| ((1,6,11,12,13)) | ((6,36,66,72,78))    | ((0,0,8,8,10))  | ((-5,-6,-11,-12,-25))  |
| ((4,5,9))        | ((16,20,36))         | ((2,2,4))       | ((0,0,0))              |
| ((1,2,3))        | ((4,8,12))           | ((2,2,2))       | ((2,2,0))              |
| ((1,3,5))        | ((4,12,20))          | ((3,3,5))       | ((3,1,3))              |
| ((1,3,13))       | ((4,12,52))          | ((3,5,9))       | ((3,1,3))              |
| ((1,3,4,5,7,11)) | ((7,21,28,35,49,77)) | ((0,0,0,0,2,2)) | ((0,-4,-6,-8,-18,-24)) |

For completeness, let

[
h_j=(h_{j,0},h_{j,1},\ldots),
\qquad
h_{j,k}=#{r\in R_j:\mu_j(r)=k}.
]

The exact multiplicity histograms are:

```text
(1,2,8):
  (0,2,1); (0,4,2); (6,12,6)

(1,2,3,4,5,7):
  (0,6); (0,12); (0,14,4); (0,22,0,2);
  (2,22,4,0,2); (2,28,8,2,0,2)

(1,6,11,12,13):
  (0,0,5); (0,28,0,0,2); (8,32,11,4);
  (8,36,12,4); (10,28,21,4,2)

(4,5,9):
  (2,8,2); (2,11,2); (4,19,4)

(1,2,3):
  (2,1); (2,4); (2,5,2)

(1,3,5):
  (3); (3,4,2); (5,8,2)

(1,3,13):
  (3); (5,0,4); (9,24,6)

(1,3,4,5,7,11):
  (0,6); (0,14,4); (0,18,6); (0,24,4,2);
  (2,24,14,0,2); (2,48,12,0,2,2)
```

Specific regression checks:

1. For ((1,2,8)), only the speed-(8) pivot has good candidates. Common scaling preserves that one-pivot concentration while destroying its frozen low-degree positive direction.

2. For ((1,2,3,4,5,7)),

[
Q_5={6,29}\pmod{35},\qquad
Q_7={8,41}\pmod{49}.
]

The negative signed totals remain (-8) and (-18).

3. For ((1,6,11,12,13)), the first two rows are completely covered. The other three rows have (8,8,10) good residues, respectively.

4. For ((4,5,9)), all three zero-frequency totals are (0). The exact nonzero signed supports are

[
\begin{aligned}
p=4:&\quad +{1,15}-{7,9},\
p=5:&\quad +{3,17}-{9,11},\
p=9:&\quad +{3,5,31,33}-{1,7,29,35}.
\end{aligned}
]

Thus these blocks depend on nonzero cyclotomic coefficients, not on factorwise absolute domination.

5. For ((1,2,3)), at the speed-(3) pivot,

[
Q_3={3,9}\pmod{12}.
]

At (r=3), the owner of speed (1) has

[
\rho_{12}(3)=3=p_j,
]

so equality is correctly treated as safe.

6. For ((1,3,5)), each pivot modulus is (4p_j). The reflection-fixed antipode is (r=2p_j). Since every speed is odd,

[
r a_i\equiv2p_j\pmod{4p_j},
]

and

[
\rho_{4p_j}(r a_i)=2p_j\ge p_j.
]

The antipode is one good candidate, counted once. This explains the odd values (G=(3,3,5)).

7. For ((1,3,13)), at the speed-(3) pivot, (M=12) and

[
13\equiv1\pmod{12}.
]

The owners of speeds (1) and (13) therefore have coincident bad sets

[
{1,2,10,11}.
]

Each residue there has (\mu=2), not (\mu=1). The good set is

[
{3,5,6,7,9}.
]

8. The tuple ((1,3,4,5,7,11)) was kept distinct at cutoffs (6) and (12). The smaller cutoff does not replace the contract. The full (12)-mode matrices have positive numerical directions at the final pivots, whereas the (6)-mode matrices do not show such a direction. Those spectral signs are diagnostic here and are not needed for the exact counterexample.

9. The edge conditions are retained:

   * (r=0) and every (N)-multiple are excluded.
   * (\rho=p_j-1) is bad and (\rho=p_j) is safe.
   * Reflection-fixed antipodes are counted once.
   * Nonunit multiplication and gcd fibers are retained.
   * In the (n=6), (p=1) fixture, (M=7<12), so literal character aliasing occurs and is not quotiented away.
   * Permuting speeds merely permutes the pivot blocks.
   * Common scaling is exactly the operation that produces the counterexample.

10. The counterexample matrices were derived from the full signed multiplicity function (1-\mu_j). The good sets were identified only afterward to interpret the result. No (1_{Q_j}) term or presumed good residue entered the construction of a positive direction.

No optional primitive bounded scan was needed. The analytic infinite family already refutes the universally quantified frozen lemma.

---

## 8. Complete implication chain

### The case (n=1)

Here (N=2). There is one positive speed (p), no nonpivot owners, and

[
M=2p.
]

Choose (r=1). Then (2\nmid1), so (r\in R). There are no owner bad sets, hence (\mu(r)=0).

For the pivot coordinate,

[
\rho_{2p}(rp)=\rho_{2p}(p)=p.
]

Therefore the normalized cyclic distance is

[
\frac{p}{2p}=\frac12=\frac1N.
]

Thus (r=1) is directly a canonical certificate. No invocation of (D_n), a second pivot, or a signed Gram form is required.

### The conditional (n\ge2) implication

Assume the frozen strict gap for a fixed tuple. Then some normalized block vector satisfies

[
E_a(Z)>0.
]

Because (E_a) is a finite sum, at least one summand

[
\frac{1-\mu_j(r)}{M_j}|P_{j,z_j}(r)|^2
]

must be strictly positive. Since (M_j>0) and the norm-square is nonnegative, this implies

[
1-\mu_j(r)>0.
]

As (\mu_j(r)\in\mathbb N),

[
\mu_j(r)=0.
]

Thus (r) belongs to no strict owner bad set:

[
\rho_{M_j}(r a_i)\ge p_j
\qquad(i\ne j).
]

For the pivot coordinate, write the residue of (r) modulo (N) as

[
u\in{1,\ldots,N-1},
]

using (N\nmid r). Since (M_j=Np_j),

[
r p_j\equiv u p_j\pmod{Np_j},
]

and therefore

[
\rho_{Np_j}(r p_j)
==================

p_j\min(u,N-u)
\ge p_j.
]

At the time

[
t=\frac{r}{Np_j},
]

every coordinate consequently satisfies

[
\lVert t a_i\rVert_{\mathbb R/\mathbb Z}
========================================

\frac{\rho_{Np_j}(r a_i)}{Np_j}
\ge\frac1N.
]

This is the closed Lonely Runner boundary.

At the supplied Lean theorem orientations, the intended reverse directions are:

```text
(exists_witness_iff_exists_pivot_certificate ...).2
```

from a pivot certificate to a fixed-instance witness,

```text
(positiveIntegerConjecture_iff_pivotCertificateConjecture).2
```

from the global pivot-certificate statement to `PositiveIntegerConjecture`, and

```text
(conjecture_iff_positiveIntegerConjecture).2
```

from `PositiveIntegerConjecture` to `Conjecture`.

This implication chain is complete as a conditional argument. It cannot be instantiated with the frozen spectral lemma because that lemma fails at ((6,12,48)).

---

## 9. Artifacts and replay

No optional source file, machine-readable output, or Lean prototype was created.

The counterexample replay requires only:

1. the three explicitly listed base weight functions for ((1,2,8));
2. the decomposition (r=s+kM_j^0);
3. the exact geometric sum over (k=0,\ldots,5); and
4. the resulting rational matrices
   [
   -\tfrac14I_6,\ -\tfrac14I_6,\ 0_6.
   ]

---

## 10. Final boundary

`proved-lean`: only the three supplied repository equivalences.

`proved-math`: the supplied `PART-12` Fourier material and standard finite-dimensional Hermitian linear algebra.

`computed finite evidence`: the displayed fixture counts and multiplicity histograms.

`conditional`: a positive frozen block form would yield a canonical pivot certificate, then the positive-integer statement, then unrestricted real LRC.

`conjectural`: the new common-scaling cancellation derivation and counterexample remain unpromoted pending independent audit, despite being given as exact finite algebra.

`rejected`: the factorwise absolute criterion; the common-group rewrite as a source of positivity by itself; and, subject to replay of the displayed arithmetic, `GLOBAL-DEGREE-2N-SIGNED-GRAM-GAP`.

`open`: unrestricted LRC, and any modified primitive-only or scale-invariant spectral bridge.
