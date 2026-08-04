## 1. Disposition

**PIVOT**

`COFINITE-PRIME-FORCING` is neither proved nor decisively refuted. No fixed (n) infinite family of obstruction primes was found.

Two prime-independent necessary theorems are proved:

1. Every obstruction has an (N)-divisible coordinate, has at most (n-2) such coordinates, and satisfies an exact CRT column-capacity formula.
2. Every sufficiently large-prime obstruction has a nonzero modular annihilator with coefficients bounded solely by (n). Consequently, every positive-integer LRC counterexample would lie in one of finitely many rational hyperplanes with coefficients bounded solely by (n).

Neither theorem implies cofiniteness. Both materially narrow the remaining obstruction class.

---

## 2. Status table

| Claim or dependency                                                     | Status                     | Exact scope                                                                               |
| ----------------------------------------------------------------------- | -------------------------- | ----------------------------------------------------------------------------------------- |
| Cofinite, finite-bad-set, finite-exception, and cutoff equivalences     | `proved-math`              | Exact fixed-(n) quantifiers, including empty exceptional set                              |
| Inclusion-minimal selected-cover existence and private points           | `proved-math`              | Repetitions allowed; selected coincident bad sets eliminated only by minimality           |
| Exact bad-set cardinality in terms of (d_i=\gcd(Np,v_i))                | `proved-math`              | Strict inequality (\rho<p); equality safe                                                 |
| Primewise form of every-deletion gcd one                                | `proved-math`              | For each prime divisor of (Np), at least two coordinates are not divisible by it          |
| Witness (r=N) for every prime (p\le N)                                  | `proved-math`              | Includes every case (p\mid N)                                                             |
| Product of all primes (p\le N) is strictly below (T_n)                  | `proved-math`              | All (n\ge3)                                                                               |
| Attack A rigidity and exact CRT fiber theorem                           | `proved-math`              | Every admissible failure tuple                                                            |
| Attack B bounded-annihilator theorem                                    | `proved-math`              | Bound depends only on (n); deletion hypotheses not needed                                 |
| Bounded rational-hyperplane theorem for integer counterexamples         | `proved-math`              | Necessary condition only                                                                  |
| Exact natural-number threshold equivalence                              | `proved-math`              | No real ceiling or floor argument                                                         |
| Euclidean extraction from a supplied (D_n>0)                            | `proved-math`              | Conditional theorem whose only hypothesis is the stated cofinite certificate              |
| Primitive reduction, deletion-gcd bridge, and prime-divisibility bridge | `proved-math`              | The deletion bridge assumes the lower-dimensional LRC statement                           |
| (n=3,p=5,v=(1,3,4)) full-cover certificate                              | `computed finite evidence` | Independently replayed                                                                    |
| (n=4,p=7,v=(1,3,4,5)) full-cover certificate                            | `computed finite evidence` | Independently replayed                                                                    |
| Exhaustive repeated-tuple sweep for (n=3) and eight declared primes     | `computed finite evidence` | No cutoff inference                                                                       |
| Post hoc choice (\Delta=p)                                              | `rejected`                 | Merely restates the exceptional prime                                                     |
| Inferring cofiniteness from a finite prime interval                     | `rejected`                 | Logically invalid                                                                         |
| Reduction to distinct residues                                          | `rejected`                 | The quantified tuples permit repetitions                                                  |
| Unqualified CRT splitting when (p\mid N)                                | `rejected`                 | The small-prime branch must be discharged first                                           |
| `COFINITE-PRIME-FORCING`                                                | `open`                     | Exact unrestricted quantifiers                                                            |
| A fixed-(n) infinite-prime obstruction family                           | `open`                     | None produced or ruled out                                                                |
| Canonical finite signatures with a predeclared nonzero (\Delta_n)       | `open`                     | Neither attack reaches this                                                               |
| MSS Theorem A                                                           | `literature`               | Exact runner indexing, primitive hypothesis, and strict subset-gcd threshold ([arXiv][1]) |
| Rosenfeld Theorem 1, Corollary 2, Lemmas 3 and 4                        | `literature`               | Product bound, prime divisibility, and deletion-gcd roles ([arXiv][2])                    |
| Repository Lean interface for MSS and Rosenfeld                         | `external-unformalized`    | No corresponding Lean theorem is present                                                  |
| `oneMovingRunner`                                                       | `proved-lean`              | One nonzero moving speed at threshold (1/2)                                               |
| `twoMovingRunners`                                                      | `proved-lean`              | Two nonzero moving speeds at threshold (1/3)                                              |
| `conjecture_iff_positiveIntegerConjecture`                              | `proved-lean`              | Exact all-dimensional equivalence                                                         |
| Full cofinite-to-LRC implication chain                                  | `conditional`              | Depends on the open cofinite theorem and the external MSS/Rosenfeld interface             |
| Unrestricted Lonely Runner Conjecture                                   | `open`                     | No status promotion                                                                       |

---

## 3. Exact cofinite theorem

Fix (n\ge3), put (N=n+1), and let (p) be prime. Set (M=Np). For a residue (x\in\mathbb Z/M\mathbb Z), define

[
\rho_M(x)=\min(\bar x,M-\bar x),
]

where (0\le\bar x<M) is the canonical representative.

A tuple (v=(v_1,\ldots,v_n)\in(\mathbb Z/M\mathbb Z)^n) is admissible when

[
p\nmid v_i\quad\text{for every }i,
]

and

[
\gcd\bigl(M,{v_i:i\ne k}\bigr)=1
\quad\text{for every }k.
]

Repetitions are allowed. Define

[
B_i(v)={r\in\mathbb Z/M\mathbb Z:\rho_M(rv_i)<p}.
]

Then `PrimeForcing(n,p)` is the assertion that every admissible tuple has some (r) satisfying

[
\rho_M(rv_i)\ge p
\quad\text{for all }i.
]

Equivalently,

[
\bigcup_{i=1}^n B_i(v)\ne\mathbb Z/M\mathbb Z
]

for every admissible (v).

Define the bad-prime set

[
\mathcal B_n={p:p\text{ prime and }\neg\operatorname{PrimeForcing}(n,p)}.
]

### Cofinite equivalence theorem (`proved-math`)

For each fixed (n\ge3), the following are equivalent:

1. There exists (D_n>0) such that every prime (p\nmid D_n) satisfies `PrimeForcing(n,p)`.
2. (\mathcal B_n) is finite.
3. There is a finite set (E_n) of primes such that every prime outside (E_n) is prime-forcing.
4. There is a natural (P_n) such that every prime (p>P_n) is prime-forcing.

**Proof.**

From 1 to 2, every bad prime divides (D_n). A positive integer has only finitely many prime divisors.

From 2 to 3, take (E_n=\mathcal B_n).

From 3 to 1, let

[
D_n=\prod_{p\in E_n}p,
]

using each prime once. For (E_n=\varnothing), set (D_n=1). If a prime does not divide (D_n), it is outside (E_n), hence is prime-forcing.

From 2 to 4, if (\mathcal B_n=\varnothing), take (P_n=0). Otherwise take its largest element.

From 4 to 2, every bad prime lies in the finite set of primes at most (P_n).

This equivalence supplies no signature classification. An arbitrary (D_n), exceptional set, or cutoff is equivalent data for cofiniteness.

### Minimal selected covers (`proved-math`)

Suppose (v) is a failure tuple. Among all subsets of coordinates whose bad sets cover (\mathbb Z/M\mathbb Z), choose one of least cardinality. If its cardinality is (m), an enumeration gives an injection

[
\iota:\operatorname{Fin}m\longrightarrow\operatorname{Fin}n,
\qquad 1\le m\le n.
]

Deleting any selected coordinate destroys coverage.

For each selected (j), there is a private point

[
r_j\in B_{\iota(j)}
\setminus\bigcup_{\ell\ne j}B_{\iota(\ell)}.
]

The selected bad sets are therefore pairwise distinct, even though the original tuple may contain repetitions or coincident bad sets.

In fact (m\ge2). The cardinality formula below shows every individual (B_i) is a proper subset. Since (0\in B_i) for every (i), every private point of a minimal selected cover is nonzero.

### Exact bad-set cardinality (`proved-math`)

Put

[
d_i=\gcd(M,v_i).
]

Because (p\nmid v_i), also (p\nmid d_i). Since (d_i\mid Np), this implies

[
d_i\mid N,
]

including when (p\mid N).

Multiplication by (v_i) on (\mathbb Z/M\mathbb Z) has kernel size (d_i). After factoring by (d_i), multiplication by (v_i/d_i) permutes (\mathbb Z/(M/d_i)\mathbb Z). Moreover,

[
\rho_M(d_i x)=d_i,\rho_{M/d_i}(x).
]

Hence

[
\boxed{
|B_i|
=====

d_i\left(2\left\lfloor\frac{p-1}{d_i}\right\rfloor+1\right).
}
]

The count has no endpoint ambiguity because (d_i\rho<p) is equivalent to

[
\rho\le\left\lfloor\frac{p-1}{d_i}\right\rfloor.
]

Since (N\ge4), the counted positive and negative residues cannot overlap.

Also,

[
|B_i|
\le 2(p-1)+d_i
\le 2p+N-2
<Np,
]

because

[
Np-(2p+N-2)=(N-2)(p-1)>0.
]

Thus no single bad set covers the group.

### Primewise deletion restriction (`proved-math`)

For a prime (\ell\mid M), every-deletion gcd one is equivalent to:

[
\boxed{\text{At least two coordinates }v_i\text{ are not divisible by }\ell.}
]

Indeed, if at most one coordinate is not divisible by (\ell), deleting that coordinate leaves every survivor divisible by (\ell). Conversely, if at least two are not divisible by (\ell), every deletion leaves at least one nondivisible survivor.

For (\ell=p), all coordinates are already nondivisible. For every (\ell\mid N), at least two (d_i) are not divisible by (\ell).

---

## 4. Attack A

### 4.1 Small primes and (p\mid N)

For every (x),

[
\boxed{\rho_{Np}(Nx)=N\rho_p(x).}
]

This follows because the canonical residue of (Nx) modulo (Np) is (N) times the canonical residue of (x) modulo (p).

Take (r=N). Since (p) is prime, (p\ge2), and therefore (0<N<Np). For every admissible coordinate,

[
p\nmid v_i
\quad\Longrightarrow\quad
\rho_p(v_i)\ge1.
]

Consequently,

[
\rho_{Np}(Nv_i)=N\rho_p(v_i)\ge N.
]

Thus, whenever (p\le N),

[
\rho_{Np}(Nv_i)\ge N\ge p
]

for every (i). Equality is safe.

Therefore:

[
\boxed{p\le N\Longrightarrow\operatorname{PrimeForcing}(n,p).}
]

Every prime dividing (N) is included in this branch. No CRT decomposition is needed or used there.

### 4.2 The small-prime product cannot reach (T_n)

Let

[
S_N=\prod_{\substack{p\le N\p\text{ prime}}}p.
]

There are at most (N) factors and each is at most (N), so

[
S_N\le N^N.
]

For (n=3), (N=4) and (C_n=6), and

[
3^3,4^4=6912<46656=6^6.
]

For (n\ge4),

[
C_n=\frac{nN}{2}\ge2n,
\qquad
N\le2n.
]

Also (n(n-1)\ge2n+1). Hence

[
n^nN^N
\le n^n(2n)^N
<(2n)^{n+N}
=(2n)^{2n+1}
\le(2n)^{n(n-1)}
\le C_n^{n(n-1)}.
]

Therefore

[
n^nS_N<C_n^{n(n-1)}.
]

By the exact threshold equivalence proved in Section 7,

[
\boxed{S_N<T_n.}
]

The automatic small primes do not provide a sufficient prime product.

### 4.3 An (N)-divisible coordinate is mandatory

A second exact identity is

[
\boxed{\rho_{Np}(px)=p\rho_N(x).}
]

At the particular residue (r=p),

[
r\in B_i
\iff p\rho_N(v_i)<p
\iff \rho_N(v_i)=0
\iff N\mid v_i.
]

Every full cover must cover (r=p). Therefore:

[
\boxed{
\text{Every admissible failure tuple has at least one coordinate }v_i
\text{ divisible by }N.
}
]

The same conclusion holds in every inclusion-minimal selected cover.

Choose a prime (\ell\mid N). Every (N)-divisible coordinate is divisible by (\ell), while the deletion condition requires at least two coordinates not divisible by (\ell). Therefore:

[
\boxed{
1\le #{i:N\mid v_i}\le n-2
}
]

for every obstruction.

This conclusion handles repetitions and does not use (p>N).

### 4.4 Exact compatible CRT normalization for (p>N)

Now assume (p>N). Since (p) is prime,

[
\gcd(p,N)=1.
]

Write a group element as its CRT pair

[
r\longleftrightarrow(x,y)
\in\mathbb Z/p\mathbb Z\times\mathbb Z/N\mathbb Z.
]

For coordinate (i), put

[
b_i=v_i\bmod p\in(\mathbb Z/p\mathbb Z)^\times,
\qquad
c_i=v_i\bmod N,
\qquad
d_i=\gcd(N,c_i).
]

For a fixed (x), let (z_i(x)\in{0,\ldots,p-1}) be the canonical representative of (xb_i\bmod p).

A residue is strictly bad precisely when its signed representative lies in

[
{-(p-1),\ldots,p-1}.
]

For (x=0), the only possible signed representative is (0). Therefore the number of (y)-values in the (x=0) fiber of (B_i) is

[
d_i.
]

For (x\ne0), the two possible signed representatives are

[
z_i(x)
\quad\text{and}\quad
z_i(x)-p.
]

The congruence

[
c_i y\equiv a\pmod N
]

has exactly (d_i) solutions when (d_i\mid a), and none otherwise. Thus:

[
\boxed{
|B_i\cap({x}\times\mathbb Z/N\mathbb Z)|
========================================

d_i\left(
\mathbf 1_{d_i\mid z_i(x)}
+
\mathbf 1_{d_i\mid z_i(x)-p}
\right)
}
]

for (x\ne0).

The two solution classes are disjoint. If both divisibilities held, then (d_i\mid p). Since (d_i\mid N) and (\gcd(p,N)=1), this forces (d_i=1); for (d_i=1), the two right-hand sides are still distinct modulo (N).

When (d_i=N), a fiber is either the entire (N)-point column or empty. When (d_i<N), it contains at most (2d_i) points.

Consequently, for every CRT column (x) that is not wholly covered by an (N)-divisible coordinate,

[
\boxed{
N
\le
\sum_{i:d_i<N}
d_i\left(
\mathbf 1_{d_i\mid z_i(x)}
+
\mathbf 1_{d_i\mid z_i(x)-p}
\right)
\le
2\sum_{i:d_i<N}d_i.
}
]

This is an exact necessary capacity condition, not an averaged estimate.

### 4.5 Valid symmetries and normalization limits

The following operations preserve admissibility and obstruction status:

* Coordinate permutation.
* Independent sign changes (v_i\mapsto-v_i), because (\rho_M(-x)=\rho_M(x)).
* Replacement by another representative modulo (M).
* Multiplication of every coordinate by a common unit (u\in(\mathbb Z/M\mathbb Z)^\times), with the corresponding permutation (r\mapsto ru) of witness residues.

For (p>N), if (v_k=Na) with (a\in(\mathbb Z/p\mathbb Z)^\times), CRT gives a common unit satisfying

[
u\equiv a^{-1}\pmod p,
\qquad
u\equiv1\pmod N.
]

It normalizes (v_k) to (N).

This does not produce a finite prime-independent normal form. The remaining ratios (b_i/b_k) range through (\mathbb F_p), and private-point CRT coordinates also vary with (p). Different minimal subcovers need not select the same (N)-divisible coordinate.

### 4.6 First fatal arrow

The proved CRT formula does not yield either:

[
p\le P_n
]

for a fixed (P_n), or a predeclared finite signature map with a nonzero integer (\Delta_n).

The missing arrow would have to convert the varying field ratios and column indicators into a fixed nonzero integer determinant. No such determinant was obtained. Assigning (\Delta=p) after observing the obstruction is `rejected`.

Attack A therefore stops after the rigidity and exact fiber theorems.

---

## 5. Attack B

### 5.1 Bounded-annihilator theorem

Put

[
w_N=\frac{N-2}{2N}.
]

For (N\ge4),

[
\frac14\le w_N<\frac12.
]

Define the explicit integer

[
\boxed{
H_n=2n,5^{,n-1}4^n+1.
}
]

### Theorem (`proved-math`)

For every (n\ge3), every prime (p), and every

[
b=(b_1,\ldots,b_n)\in(\mathbb F_p^\times)^n,
]

suppose

[
\forall x\in\mathbb F_p,\quad
\exists i,\quad
\rho_p(xb_i)<\frac pN.
]

Then there is a nonzero vector (c\in\mathbb Z^n) such that

[
|c|_\infty\le H_n
]

and

[
\boxed{
\sum_{i=1}^n c_i b_i\equiv0\pmod p.
}
]

For (p>H_n), the support of (c) has at least two coordinates.

Every failure tuple for `PrimeForcing(n,p)` satisfies the hypothesis by restricting the putative cover to residues (r=Nx), because

[
\rho_{Np}(Nxv_i)=N\rho_p(xb_i).
]

The theorem does not need the deletion-gcd hypothesis.

### 5.2 Fourier proof

Let (\mathbb T=\mathbb R/\mathbb Z). Define the periodic tent function

[
g(t)=
\max\left(
0,,
1-\frac{|t-\frac12|}{w_N}
\right).
]

Its support is exactly

[
\left[\frac1N,1-\frac1N\right],
]

with value zero at both endpoints.

Its Fourier coefficients are

[
\widehat g(0)=w_N,
]

and, for (k\ne0),

[
\widehat g(k)
=============

(-1)^k\frac1{w_N}
\left(\frac{\sin(\pi k w_N)}{\pi k}\right)^2.
]

Thus

[
|\widehat g(k)|
\le\frac1{4w_Nk^2}.
]

Using (\sum_{k\ge1}k^{-2}<2),

[
\sum_{k\in\mathbb Z}|\widehat g(k)|
<
w_N+\frac1{w_N}
<5.
]

For every positive integer (H),

[
\sum_{|k|>H}|\widehat g(k)|
<
\frac1{2w_NH}.
]

Now define

[
F(t_1,\ldots,t_n)=\prod_{i=1}^n g(t_i).
]

Its constant coefficient is

[
\widehat F(0)=w_N^n.
]

By a union bound on the Fourier indices,

[
\sum_{|c|_\infty>H}
|\widehat F(c)|
<
\frac{n5^{n-1}}{2w_NH}.
]

With (H=H_n), and using (w_N\ge1/4),

[
\frac{n5^{n-1}}{2w_NH_n}
<
\frac{2n5^{n-1}}{H_n}
<
4^{-n}
\le w_N^n.
]

The obstruction hypothesis says that for every (x), at least one coordinate (xb_i/p) is outside the closed safe interval. Hence

[
F\left(\frac{xb_1}{p},\ldots,\frac{xb_n}{p}\right)=0.
]

Absolute Fourier convergence permits termwise averaging. Root-of-unity orthogonality gives

[
0
=

\frac1p\sum_{x\in\mathbb F_p}
F\left(\frac{xb_1}{p},\ldots,\frac{xb_n}{p}\right)
==================================================

\sum_{\substack{c\in\mathbb Z^n\c\cdot b\equiv0\pmod p}}
\widehat F(c).
]

If no nonzero annihilator existed inside the cube
(|c|_\infty\le H_n), every nonconstant term in the last sum would lie in the Fourier tail. Its absolute value would be strictly less than the constant term (w_N^n), so cancellation to zero would be impossible.

Therefore a bounded nonzero annihilator exists.

If (p>H_n) and the annihilator had support one, then

[
c_i b_i\equiv0\pmod p.
]

Since (b_i\ne0), (p\mid c_i). But (|c_i|<p), forcing (c_i=0), a contradiction.

The proof uses complex roots of unity rather than reducing Fourier coefficients modulo (p). There is no characteristic collapse and no denominator is interpreted in (\mathbb F_p). Strict badness and safe equality are handled by the tent function’s exact support and zero boundary.

### 5.3 Rational-hyperplane consequence

### Corollary (`proved-math`)

Every positive-integer counterexample

[
a=(a_1,\ldots,a_n)
]

to LRC in moving dimension (n\ge3) satisfies an exact relation

[
\boxed{
\sum_{i=1}^n c_i a_i=0
}
]

for some nonzero (c\in\mathbb Z^n) with

[
|c|_\infty\le H_n.
]

Because all (a_i>0), the vector (c) has both positive and negative coefficients.

**Proof.**

Take infinitely many primes

[
p>\max{N,H_n,a_1,\ldots,a_n}.
]

At every time (x/p), the counterexample has a bad coordinate. The bounded-annihilator theorem produces (c_p) in the fixed finite set

[
[-H_n,H_n]^n\setminus{0}.
]

One vector (c) therefore occurs for infinitely many primes. For those primes,

[
p\mid\sum_i c_i a_i.
]

A fixed nonzero integer has only finitely many prime divisors, so the sum is zero.

Thus all positive-integer counterexamples lie in a fixed finite union of rational hyperplanes determined before seeing their speeds.

This is a necessary condition only. It is not a bounded-coefficient selector theorem, a signature classification, or a proof of LRC.

### 5.4 First fatal arrow

For a varying modular obstruction tuple, the congruence

[
c\cdot b\equiv0\pmod p
]

does not imply that (p) divides a fixed nonzero integer depending only on (c). A rational hyperplane such as

[
b_1+b_2-b_3=0
]

has points over every prime field. Additional independent relations, or a theorem excluding every resulting rational subtorus from supporting a cover, would be required.

No predeclared nonzero determinant or resultant was obtained. Zero-determinant hyperplane cases cannot be discarded.

Attack B stops at this arrow.

---

## 6. Falsification

All computations in this section have status `computed finite evidence`.

### 6.1 Fixture (n=3,p=5,v=(1,3,4))

Here

[
N=4,\qquad M=20.
]

Admissibility:

[
5\nmid1,3,4,
]

and the deletion gcds are

[
\gcd(20,3,4)=
\gcd(20,1,4)=
\gcd(20,1,3)=1.
]

The strict bad sets are

[
\begin{aligned}
B_1={}&{0,1,2,3,4,16,17,18,19},\
B_3={}&{0,1,6,7,8,12,13,14,19},\
B_4={}&{0,1,4,5,6,9,10,11,14,15,16,19}.
\end{aligned}
]

Their union is all of ({0,\ldots,19}).

Deleting coordinates leaves the following uncovered residues:

[
\begin{array}{c|c}
\text{Deleted set}&\text{Uncovered residues}\ \hline
B_1&{2,3,17,18}\
B_3&{7,8,12,13}\
B_4&{5,9,10,11,15}.
\end{array}
]

Thus the displayed cover is inclusion-minimal.

The equality points are safe:

[
\begin{array}{c|c}
v_i&{r:\rho_{20}(rv_i)=5}\ \hline
1&{5,15}\
3&{5,15}\
4&\varnothing.
\end{array}
]

These points correspond to both cyclic endpoint residues (5) and (15). The residue (r=0) lies in every bad set.

### 6.2 Fixture (n=4,p=7,v=(1,3,4,5))

Here

[
N=5,\qquad M=35.
]

No coordinate is divisible by (7), and every deletion gcd is (1).

The strict bad sets are

[
\begin{aligned}
B_1={}&{0,1,2,3,4,5,6,29,30,31,32,33,34},\
B_3={}&{0,1,2,10,11,12,13,22,23,24,25,33,34},\
B_4={}&{0,1,8,9,10,16,17,18,19,25,26,27,34},\
B_5={}&{0,1,6,7,8,13,14,15,20,21,22,27,28,29,34}.
\end{aligned}
]

Their union is all of ({0,\ldots,34}).

Deleting coordinates leaves:

[
\begin{array}{c|c}
\text{Deleted set}&\text{Uncovered residues}\ \hline
B_1&{3,4,5,30,31,32}\
B_3&{11,12,23,24}\
B_4&{9,16,17,18,19,26}\
B_5&{7,14,15,20,21,28}.
\end{array}
]

Thus this cover is also inclusion-minimal.

Equality points are:

[
\begin{array}{c|c}
v_i&{r:\rho_{35}(rv_i)=7}\ \hline
1&{7,28}\
3&{14,21}\
4&{7,28}\
5&\varnothing.
\end{array}
]

Again, equality is excluded from every strict bad set.

### 6.3 Repetitions and coincident bad sets

For every (n\ge3) and every prime (p), the repeated tuple

[
v=(1,1,\ldots,1)
]

is admissible:

[
p\nmid1,
\qquad
\gcd(Np,1,\ldots,1)=1
]

after every deletion. All bad sets coincide.

It is not a failure tuple. At (r=p),

[
\rho_{Np}(p)=p,
]

which is safe. Therefore repetition cannot be removed from the quantified domain, even though coincident sets cannot both survive in an inclusion-minimal selected cover.

### 6.4 Fixed-(n) prime sweep

The declared exhaustive sweep used (n=3), all nondecreasing triples of allowed residues, and therefore included repetitions while quotienting only by coordinate permutation.

| (p) | Canonical tuples | Admissible tuples | Failure tuples |
| --: | ---------------: | ----------------: | -------------: |
|   5 |              816 |               408 |             32 |
|   7 |            2,600 |             1,300 |              0 |
|  11 |           11,480 |             5,740 |              0 |
|  13 |           19,600 |             9,800 |              0 |
|  17 |           45,760 |            22,880 |              0 |
|  19 |           64,824 |            32,412 |              0 |
|  23 |          117,480 |            58,740 |              0 |
|  29 |          240,464 |           120,232 |              0 |

The (p=5) fixture occurs among the 32 canonical failures. No extension was found at the other seven declared primes.

This does not prove that (p=5) is the only bad prime in dimension (3), nor does it establish any cutoff.

### 6.5 Normalization audit

* Coordinate permutation is valid and was used only to enumerate nondecreasing tuples.
* Independent signs preserve each bad set exactly.
* Common units preserve coverage by permuting the witness domain.
* Residue-representative changes have no effect.
* Different minimal subcovers remain possible and were not identified.
* No distinct-coordinate reduction was used.
* Every (p\mid N) is covered by the proved (p\le N) witness.
* No finite-prime density or cutoff inference was made.
* No signature universe or (\Delta_n) was chosen after inspecting the sweep.

No fixed-(n) infinite-prime counterexample was produced.

---

## 7. Complete implication chain

### 7.1 Exact threshold comparison

Let

[
C_n=\binom{n+1}{2}
]

and define

[
\mathcal T_n=
{T\in\mathbb N:n^nT\ge C_n^{n(n-1)}}.
]

This set is nonempty. For example,

[
C_n^{n(n-1)}\in\mathcal T_n
]

because (n^n\ge1).

Let

[
T_n=\min\mathcal T_n.
]

By definition,

[
n^nT_n\ge C_n^{n(n-1)}.
]

For every natural (Q),

[
\boxed{
Q\ge T_n
\iff
n^nQ\ge C_n^{n(n-1)}.
}
]

If (Q\ge T_n), multiplication by the positive natural (n^n) preserves the inequality.

Conversely, if (n^nQ\ge C_n^{n(n-1)}), then (Q\in\mathcal T_n), so minimality gives (T_n\le Q).

No real-valued ceiling or floor is involved.

### 7.2 Euclidean prime extraction

Assume `COFINITE-PRIME-FORCING` in dimension (n), and fix the supplied (D=D_n>0).

Define

[
R_0=1,
]

and recursively let (q_j) be the least prime divisor of

[
DR_j+1,
]

with

[
R_{j+1}=R_jq_j.
]

Because (DR_j+1>1), a prime divisor exists.

For every (j):

1. (q_j) is prime.
2. (q_j\nmid D). Otherwise (q_j\mid DR_j) and (q_j\mid DR_j+1), forcing (q_j\mid1).
3. (q_j\nmid R_j), by the same argument.
4. `PrimeForcing(n,q_j)` holds because (q_j\nmid D).
5. The primes are distinct. For (k<j), (q_k\mid R_j), whereas (q_j\nmid R_j).
6. Since (q_j\ge2),

[
R_j\ge2^j.
]

The last assertion follows by induction.

Define

[
m_n=\min{m:R_m\ge T_n}.
]

This set is nonempty because

[
R_{T_n}\ge2^{T_n}\ge T_n.
]

Induction on (m) gives

[
R_m=\prod_{j<m}q_j.
]

Therefore

[
\boxed{
\prod_{j<m_n}q_j=R_{m_n}\ge T_n.
}
]

Thus the finite set

[
{q_j:j<m_n}
]

is a `UniformPrimeForcingSupply`: it consists of distinct prime-forcing primes and its product is at least (T_n).

### 7.3 Primitive reduction

Let

[
a:\operatorname{Fin}n\to\mathbb N
]

be positive and injective, and suppose it is a counterexample.

Set

[
g=\gcd(a_1,\ldots,a_n),
\qquad
b_i=a_i/g.
]

The tuple (b) remains positive and injective, has full gcd (1), and is also a counterexample. Indeed, a witness time (t) for (b) would give witness time (t/g) for (a).

It is therefore sufficient to consider primitive counterexamples.

### 7.4 Every-deletion gcd one

Assume the LRC statement for (n-1) positive moving speeds, meaning (n) total runners.

Let (a) be a primitive counterexample with (n) positive moving speeds, meaning (n+1) total runners. Fix a deleted coordinate (k), and put

[
d=\gcd(a_i:i\ne k).
]

Suppose (d>1), and write (a_i=db_i) for (i\ne k).

The lower-dimensional hypothesis gives a time (t) such that

[
|tb_i|\ge\frac1n
]

for every survivor.

Consider

[
t_j=\frac{t+j}{d},
\qquad 0\le j<d.
]

For every survivor,

[
a_it_j
======

b_it+b_ij,
]

so its phase is unchanged and remains at distance at least (1/n>1/(n+1)).

Primitivity implies

[
\gcd(a_k,d)=1.
]

Therefore the omitted coordinate’s phases at the (d) times (t_j) are (d) equally spaced points.

The strict bad arc at threshold (1/(n+1)) has length

[
\frac2{n+1}=\frac2N.
]

For (N\ge4) and (d\ge2),

[
\frac2N\le1-\frac1d,
]

equivalently (2d\le N(d-1)). An open arc of this length cannot contain all (d) equally spaced points. Hence some (t_j) is safe for the omitted coordinate and for every survivor, contradicting the counterexample.

Thus

[
\boxed{
\gcd(a_i:i\ne k)=1
\quad\text{for every }k.
}
]

This is the direct mathematical form of Rosenfeld Lemma 4. The paper states that a primitive tuple with a nonprimitive deletion is already good under the lower-dimensional hypothesis. ([arXiv][2])

### 7.5 Reduction modulo (Nq) and prime divisibility

Let (q) be one of the supplied prime-forcing primes. Suppose

[
q\nmid\prod_i a_i.
]

Reduce the speeds modulo

[
M=Nq.
]

The resulting residues may repeat. This is permitted.

Since (q\nmid a_i), no residue is divisible by (q). For every deletion (k),

[
\gcd(M,{a_i\bmod M:i\ne k})
===========================

\gcd(M,{a_i:i\ne k})
=1,
]

using the every-deletion result.

Thus the residue tuple is admissible. `PrimeForcing(n,q)` supplies (0\le r<M) with

[
q\le\rho_M(ra_i)
]

for every (i).

At time

[
t=\frac rM,
]

[
|ta_i|
======

\frac{\rho_M(ra_i)}M
\ge
\frac q{Nq}
===========

\frac1N.
]

This contradicts the counterexample. Therefore

[
\boxed{
q\mid\prod_i a_i.
}
]

This is the exact role of Rosenfeld Lemma 3. Its quantified finite residue condition and divisibility conclusion match this bridge. ([arXiv][2])

No CRT assumption is used in this divisibility argument, so supplied primes dividing (N) would cause no compatibility issue. In the present extraction, all automatically small primes were already separated.

### 7.6 Product assembly

Let

[
P=\prod_i a_i.
]

Every supplied (q_j) divides (P), and the (q_j) are distinct primes. Hence they are pairwise coprime and

[
R_{m_n}=\prod_{j<m_n}q_j\mid P.
]

Since all speeds are positive, (P>0). Therefore

[
P\ge R_{m_n}\ge T_n.
]

The exact threshold equivalence gives

[
\boxed{
n^nP\ge C_n^{n(n-1)}.
}
]

### 7.7 Strict external product upper bound

MSS Theorem A states, with the relevant indexing, that assuming LRC for (n) total runners, an (n)-positive-speed primitive tuple for (n+1) total runners is good when its subset-gcd sum exceeds

[
C_n^{n-1}.
]

Rosenfeld’s Theorem 1 restates this role, and Corollary 2 derives the product criterion

[
P\ge
\left(\frac{C_n^{n-1}}n\right)^n
\quad\Longrightarrow\quad
\text{the tuple is good}.
]

Therefore a primitive counterexample must satisfy the strict inequality

[
P<
\left(\frac{C_n^{n-1}}n\right)^n,
]

equivalently,

[
\boxed{
n^nP<C_n^{n(n-1)}.
}
]

This contradicts the weak lower bound from the supplied-prime product. The exact source roles and indexing are stated in MSS Theorem A and Rosenfeld Theorem 1 and Corollary 2. ([arXiv][1])

These results remain `literature`; their repository Lean interface is `external-unformalized`.

### 7.8 Induction and real reduction

Assume `COFINITE-PRIME-FORCING` for every (n\ge3).

The repository declaration `oneMovingRunner` proves the one-positive-speed base at threshold (1/2). The declaration `twoMovingRunners` proves the two-positive-speed base at threshold (1/3). Their specializations to positive natural speeds give the induction bases.

At induction step (n\ge3):

* the full tuple has (n) positive moving speeds and (n+1) total runners;
* deletion leaves (n-1) positive moving speeds and (n) total runners;
* the induction hypothesis proves every deletion-level instance;
* the cofinite theorem supplies the prime-forcing product;
* the preceding chain rules out a primitive full counterexample.

Thus the all-dimensional positive-integer formulation follows conditionally.

The repository theorem

[
\texttt{conjecture_iff_positiveIntegerConjecture}
]

is an exact `proved-lean` equivalence between the unrestricted real formulation and the positive-integer formulation.

Therefore the full conclusion is:

[
\boxed{
\text{COFINITE-PRIME-FORCING in every dimension}
\Longrightarrow
\text{unrestricted real LRC},
}
]

with status `conditional`, because the cofinite premise is `open` and the MSS/Rosenfeld product interface is `external-unformalized`.

---

## 8. Artifacts and replay

The verifier used exactly one source file and one machine-readable output.

**Declared exhaustive domain**

* Fixed sweep dimension: (n=3).
* Primes: (5,7,11,13,17,19,23,29).
* Tuples: all nondecreasing triples of residues not divisible by (p), exhaustive modulo coordinate permutation.
* Repetitions included.
* Strict condition: (\rho_M(rv_i)<p).
* Equality (\rho_M(rv_i)=p) safe.
* Order: increasing prime, then lexicographic combinations with replacement.
* Stop rule: complete every declared prime domain; no adaptive expansion.
* Additional check: only the fixed (n=4,p=7,v=(1,3,4,5)) certificate, with no surrounding search.

**Replay**

```bash
python3 cofinite_prime_forcing_verifier.py
```

**Hashes**

```text
Source SHA-256:
ffcadeab525c63faee8548389b8460c1730ee7ea51039ba8dcb1463d16ef9004

Output SHA-256:
b85677d9487220a2b7f0c5438dcb021372a30b6e75761f8fc972b8b7001375f9
```

[Verifier source](sandbox:/mnt/data/cofinite_prime_forcing_verifier.py)

[Machine-readable output](sandbox:/mnt/data/cofinite_prime_forcing_verifier_output.json)

No Lean prototype was used.

---

## 9. Final boundary

**`proved-math`**

* The exact cofinite equivalences.
* Minimal-cover existence, private points, and properness of every individual bad set.
* The exact cardinality formula for (B_i).
* The primewise deletion-gcd characterization.
* The (p\le N) witness (r=N), including all (p\mid N).
* Strict insufficiency of the product of these small primes.
* Mandatory existence, and upper bound (n-2), for (N)-divisible coordinates in any obstruction.
* The exact (p>N) CRT fiber formula and column-capacity inequality.
* The explicit bounded-annihilator theorem with
  [
  H_n=2n5^{n-1}4^n+1.
  ]
* The finite rational-hyperplane necessary condition for integer counterexamples.
* The exact natural-number threshold equivalence.
* Euclidean extraction from a supplied (D_n).
* Primitive reduction, every-deletion gcd one, modular divisibility, and pairwise-prime product assembly.

**`computed finite evidence`**

* Both mandatory full-cover fixtures.
* The exhaustive (n=3), eight-prime repeated-tuple sweep.

**`rejected`**

* Post hoc (\Delta=p).
* Finite-interval cutoff inference.
* Distinct-coordinate reduction.
* CRT splitting before discharging (p\mid N).
* Treating an arbitrary exceptional set as structural compression.

**`literature`**

* MSS Theorem A.
* Rosenfeld Theorem 1, Corollary 2, Lemma 3, and Lemma 4.

**`external-unformalized`**

* The MSS/Rosenfeld product-bound interface in the repository.

**`proved-lean`**

* `oneMovingRunner`.
* `twoMovingRunners`.
* `conjecture_iff_positiveIntegerConjecture`.

**`conditional`**

* The complete cofinite-prime-forcing to unrestricted-LRC implication chain.

**`open`**

* `COFINITE-PRIME-FORCING`.
* A decisive fixed-dimension infinite-prime refutation.
* A canonical predeclared finite signature system with nonzero (\Delta_n).
* Unrestricted Lonely Runner.

[1]: https://arxiv.org/html/2411.06903v2 "https://arxiv.org/html/2411.06903v2"
[2]: https://arxiv.org/html/2512.01912v1 "https://arxiv.org/html/2512.01912v1"
