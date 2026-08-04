## 1. Disposition

**STOP.**

The frozen universal lemma is false. An exact primitive counterexample is

[
a=(1,4,5,6,7,11,32),\qquad n=7,\qquad N=8,\qquad \gcd(a)=1,
]

for which

[
S_8(a)=-\frac{5,245,398}{1,878,415}<0.
]

The tuple nevertheless has canonical pivot certificates, for example pivot speed (7) with residue (r=17). Therefore this is a counterexample to the stronger saturated-multiplicity invariant, not to the Lonely Runner Conjecture.

The scaling theorem is valid. The generating-function and common-clock identities are also valid. Neither can establish the frozen strict positivity statement because the displayed tuple violates it exactly.

---

## 2. Status table

| Claim                                                          | Status                     | Dependency or evidence                                                         | First open or failed arrow                              |                                                            |      |
| -------------------------------------------------------------- | -------------------------- | ------------------------------------------------------------------------------ | ------------------------------------------------------- | ---------------------------------------------------------- | ---- |
| (                                                              | R_j                        | =n a_j)                                                                        | `proved-math`                                           | Direct count of representatives and excluded (N)-multiples | None |
| Strict-boundary and pivot-coordinate safety                    | `proved-math`              | Exact centered-residue calculation                                             | None                                                    |                                                            |      |
| Common-scaling theorem (S_8(ca)=cS_8(a))                       | `proved-math`              | Exact fiber and centered-distance proof in Section 5                           | None                                                    |                                                            |      |
| (S_8>0) implies a pivot certificate                            | `proved-math`              | (\phi_8(m)\le 0) for every (m\ge 1)                                            | None                                                    |                                                            |      |
| A pivot certificate implies (S_8>0)                            | `rejected`                 | Countermodel ((1,4,5,6,7,11,32))                                               | Fails directly                                          |                                                            |      |
| Frozen domain (2\le n\le6), maximum speed (14)                 | `computed finite evidence` | Two exact implementations, 6,330 primitive tuples                              | Unrestricted extrapolation would be unsupported         |                                                            |      |
| Exact counterexample arithmetic                                | `proved-math`              | Displayed complete histograms and reduced rational sum, independently replayed | None                                                    |                                                            |      |
| Owner-incidence generating-function identity                   | `proved-math`              | Exact differentiation and integration                                          | Required universal integral inequality is false         |                                                            |      |
| Common-clock embedding and interpretation of (\mu_j)           | `proved-math`              | Exact injectivity and time-coordinate calculation                              | Required universal additive-energy lower bound is false |                                                            |      |
| `GLOBAL-ALL-PIVOT-SATURATED-MULTIPLICITY-AVERAGE`              | `rejected`                 | Primitive exact counterexample                                                 | No open arrow remains for this statement                |                                                            |      |
| Conditional bridge from the frozen lemma to pivot certificates | `conditional`              | Scaling theorem plus sign argument                                             | Blocked by the rejected frozen lemma                    |                                                            |      |
| Existing pivot-certificate implication chain                   | `proved-lean` dependency   | Accepted exactly as supplied in the contract; not replayed here                | Its input is not obtained from Prompt 82                |                                                            |      |
| Unrestricted Lonely Runner Conjecture                          | `open`                     | No LRC counterexample and no unrestricted proof                                | Unchanged                                               |                                                            |      |

---

## 3. Frozen definitions and boundary

For (m\in\mathbb N), the transform is interpreted in (\mathbb Q) as

[
\phi_8(m)
=========

\frac{(1-m:\mathbb Z)}{(8m+1:\mathbb N)}.
]

The denominator is positive. Hence

[
\phi_8(0)=1,\qquad
\phi_8(1)=0,
]

and for (m\ge2),

[
-\frac18<\phi_8(m)<0.
]

Indeed, negativity is immediate from (1-m<0), while

[
\frac{1-m}{8m+1}>-\frac18
\iff
8(1-m)>-(8m+1)
\iff
8>-1.
]

For pivot (j), write

[
p=a_j,\qquad M=Np,\qquad
R_j={0\le r<M:N\nmid r}.
]

There are (Np) representatives in (0,\ldots,Np-1). Exactly

[
0,N,2N,\ldots,(p-1)N
]

are divisible by (N), so exactly (p) representatives are removed. Therefore

[
|R_j|=Np-p=(N-1)p=np.
]

For each owner (i\ne j),

[
B_i^j
=====

{r\in R_j:\rho_M(ra_i)<p}.
]

The multiplicity is owner-indexed:

[
\mu_j(r)=
#{i:i\ne j,\ r\in B_i^j}.
]

Two owners with the same modular bad set are still counted twice. Nonunits, repeated residue classes, fixed points of reflection, and antipodes are retained literally.

Badness is strictly (\rho_M(ra_i)<p). Thus:

[
\rho_M(ra_i)=p-1
\quad\Longrightarrow\quad
r\in B_i^j,
]

while

[
\rho_M(ra_i)=p
\quad\Longrightarrow\quad
r\notin B_i^j.
]

Both cyclic sides are included through

[
\rho_M(x)=\min(x\bmod M,\ M-(x\bmod M)).
]

The local and global scores are

[
S_j(a)=\sum_{r\in R_j}\phi_8(\mu_j(r)),
\qquad
S_8(a)=\sum_jS_j(a).
]

### Pivot-coordinate safety

Let (r\in R_j). Write

[
r=qN+s,\qquad 1\le s\le N-1.
]

Then

[
ra_j\equiv sa_j\pmod{Na_j},
]

and therefore

[
\rho_{Na_j}(ra_j)
=================

a_j\min(s,N-s)
\ge a_j.
]

Equality occurs when (s=1) or (s=N-1) and is safe. Thus the pivot coordinate is automatically safe for every canonical candidate.

---

## 4. Anti-tautology and route-overlap audit

### Forward sign implication

Suppose (S_8(a)>0). If every pivot candidate were covered, then every multiplicity would satisfy (\mu_j(r)\ge1). Since

[
\phi_8(1)=0
\quad\text{and}\quad
\phi_8(m)<0\ \text{for }m\ge2,
]

every summand would be nonpositive, yielding (S_8(a)\le0), a contradiction. Hence some (j,r) satisfies

[
\mu_j(r)=0.
]

Expanding the definition gives

[
r\in R_j,\qquad
\rho_{Na_j}(ra_i)\ge a_j
\quad\text{for every }i\ne j.
]

Together with pivot-coordinate safety, this is a canonical pivot certificate.

### Converse failure by an exact model

For

[
a=(1,4,5,6,7,11,32),
]

take pivot speed (p=7), modulus (M=56), and (r=17). Since (8\nmid17), (r\in R_j). The centered distances, including the pivot coordinate, are

| Speed | Centered distance modulo (56) |
| ----: | ----------------------------: |
|   (1) |                          (17) |
|   (4) |                          (12) |
|   (5) |                          (27) |
|   (6) |                          (10) |
|   (7) |                           (7) |
|  (11) |                          (19) |
|  (32) |                          (16) |

Every distance is at least (7), so this is a certificate. Nevertheless,

[
S_8(1,4,5,6,7,11,32)
====================

-\frac{5,245,398}{1,878,415}.
]

Thus the positive contributions from uncovered candidates can be outweighed by multiply covered candidates. A certificate supplies no algebraic derivation of the global inequality.

The counterexample and its score were computed solely from the literal owner multiplicities. No selected cover, private point, deletion certificate, prime obstruction, good-set weighting, Fourier mode, Gram matrix, PSD argument, height hypothesis, or coefficient selector was used. Good residues are displayed only after the score calculation to verify the anti-tautology requirement.

---

## 5. Scaling theorem

Let (c\ge1), let (A_i=ca_i), and fix pivot (j). Put

[
M=Na_j,\qquad M'=NA_j=cM.
]

Define

[
\pi:R_j(A)\longrightarrow R_j(a),
\qquad
\pi(r')=r'\bmod M.
]

### Representatives, surjectivity, and fiber size

For every (r\in{0,\ldots,M-1}), its representatives in
({0,\ldots,cM-1}) reducing to (r) are exactly

[
r,\ r+M,\ \ldots,\ r+(c-1)M.
]

Because (M=Na_j) is divisible by (N),

[
N\mid(r+kM)\iff N\mid r.
]

Consequently, (r\in R_j(a)) if and only if every (r+kM) lies in
(R_j(A)). The map is surjective and every fiber has exactly (c) elements.

### Centered-distance scaling

For every integer (x),

[
\rho_{cM}(cx)=c,\rho_M(x).
]

To prove this, write (q=x\bmod M), with (0\le q<M). Then

[
cx\bmod cM=cq,
]

so

[
\rho_{cM}(cx)
=============

# \min(cq,cM-cq)

# c\min(q,M-q)

c\rho_M(x).
]

Now let (r'=r+kM) lie above (r). For each owner (i),

[
r'A_i
=====

(r+kM)ca_i
\equiv cra_i
\pmod{cM}.
]

Therefore

[
\rho_{cM}(r'A_i)
================

c\rho_M(ra_i).
]

It follows that

[
\rho_{cM}(r'A_i)<ca_j
\iff
\rho_M(ra_i)<a_j.
]

Equality is also preserved:

[
\rho_{cM}(r'A_i)=ca_j
\iff
\rho_M(ra_i)=a_j.
]

Thus both cyclic sides, strict badness, equality safety, and every owner label are preserved. Hence

[
\mu_j^A(r')=\mu_j^a(\pi(r')).
]

Each base candidate appears in (c) fibers with the same multiplicity, so

[
S_j(A)=cS_j(a).
]

Summing over pivots gives

[
\boxed{S_8(A)=cS_8(a)}.
]

### Primitive normalization

For an arbitrary positive injective tuple (A), let

[
d=\gcd(A_i:i\in\operatorname{Fin}n),
\qquad
a_i=A_i/d.
]

Then (a) remains positive and injective, is primitive, and (A=da). Therefore

[
S_8(A)=dS_8(a).
]

A pivot certificate for (a) also lifts to (A). For example, the same numerator (r) is in the scaled candidate grid and satisfies

[
\rho_{dNa_j}(r,da_i)
====================

d\rho_{Na_j}(ra_i).
]

The scaling theorem is therefore complete, although it cannot rescue the false primitive positivity statement.

---

## 6. Exact fixtures and deterministic falsification

### Independent implementations

| Implementation         | Exact method                                                                                                 | Source and output hashes                                                                                                                                                                                                        |
| ---------------------- | ------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Python, CPython 3.13.5 | Literal (r=0,\ldots,M-1) enumeration; exclude (N)-multiples; `Fraction`; arbitrary-precision integers        | Source `cd5e428b2f1bdbb78385e438b244b919bd4b812c06026354a9c98cd83ab806c0`; output `618cf7480c44f7d992b0a8fda0de493bfd70e8d276cfa278862e5d2517813225`                                                                            |
| C++20, g++ 14.2.0      | Independent enumeration (r=bN+s), (0\le b<p), (1\le s<N); two-sided strict test; reduced `cpp_int` rationals | Source `5894f3f25bfb6ded7df3b66d7212c27d253e15592be97b612a00957a13f911b8`; binary `596919341ca88c855f5a1f538451991172853e0705bddb5c2f74950f7b15b10b`; output `eb6c17227f9c5c66d6922c342d286e932cdfbc31613068587bb7ac21d8e62266` |

Both programs were rerun from fresh copied sources. Their output files were byte-identical to the retained outputs.

Malformed command-line input exits with status (2) in Python and (64) in C++. Internal malformed-data tests reject empty tuples, zero or negative values where representable, duplicate speeds, noninteger Python values, and non-increasing scan inputs. Python uses arbitrary-precision integers. C++ uses arbitrary-precision rational numerators and denominators and 128-bit modular products for the declared data.

Artifacts:

* [Python exact verifier](sandbox:/mnt/data/p82_exact_python.py)
* [Python exact output](sandbox:/mnt/data/p82_exact_python.json)
* [C++ exact verifier](sandbox:/mnt/data/p82_exact_cpp.cpp)
* [C++ exact output](sandbox:/mnt/data/p82_exact_cpp.json)
* [Dual-execution manifest](sandbox:/mnt/data/p82_execution_manifest.json), SHA-256 `2ed10b1a521e4a38edf3f2747a4bc21e676537f34b931a0d90cdcea736c0b03c`

### Frozen domain

The domain was exhausted in the required order: dimension first, then lexicographic tuple order.

| (n) | Primitive tuple count | Minimizing tuple |   Exact minimum |
| --: | --------------------: | ---------------- | --------------: |
| (2) |                  (63) | ((1,3))          |             (2) |
| (3) |                 (325) | ((1,4,5))        |         (64/17) |
| (4) |                 (965) | ((1,2,3,5))      |      (1532/425) |
| (5) |                (1981) | ((1,5,6,7,8))    |    (26683/4675) |
| (6) |                (2996) | ((1,4,5,6,7,11)) | (165878/191675) |

Total primitive tuples:

[
63+325+965+1981+2996=6330.
]

No nonpositive score occurred in this bounded domain. This is `computed finite evidence` only.

### Exact fixture scores

The two implementations agreed on all 23 distinct named tuples.

| Fixture group                   | Tuple                               |               Exact (S_8) |
| ------------------------------- | ----------------------------------- | ------------------------: |
| Mandatory                       | ((1,2,8))                           |                   (93/17) |
| Mandatory                       | ((1,3,4))                           |                   (66/17) |
| Mandatory                       | ((1,2,3,5))                         |                (1532/425) |
| Mandatory                       | ((4,5,9))                           |                  (128/17) |
| Mandatory                       | ((1,4,5,6,7,11))                    |           (165878/191675) |
| Mandatory                       | ((1,2,3,4,5,7))                     |           (452714/191675) |
| Mandatory                       | ((1,6,11,12,13))                    |             (101887/4675) |
| Mandatory                       | ((6,7,168))                         |                 (1997/17) |
| Mandatory and Prompt78 terminal | ((6,7,12,24,144))                   |             (617587/4675) |
| Mandatory (F)                   | ((8,15,35,40,48,56,75,132,147))     | (900274298524/2319842525) |
| Mandatory (G)                   | ((15,21,40,48,56,105,126,280,1200)) |    (32973892321/19494475) |
| Prompt78 additional             | ((1,3,4,5))                         |                (1532/425) |
| Prompt78 additional             | ((4,5,8))                           |                  (195/17) |
| Prompt78 additional             | ((4,5,32))                          |                  (375/17) |
| Prompt78 additional             | ((1,3,4,9,12))                      |               (12007/935) |
| Prompt78 additional             | ((1,3,13))                          |                  (279/17) |
| Prompt80                        | ((2,5,6))                           |                  (199/17) |
| Prompt80                        | ((2,4,6))                           |                  (200/17) |
| Prompt80                        | ((1,2,3,10))                        |                (2996/425) |
| Prompt80                        | ((1,3,4,7))                         |                (6432/425) |
| Prompt80                        | ((1,2,3,60))                        |               (11844/425) |
| Prompt80                        | ((1,2,6,8,10))                      |                (4743/275) |
| Top-two hard control            | ((7,63,70,77,98,187))               |         (76589044/191675) |

The Prompt78 fixture list was taken from its hash-locked verifier source, SHA-256 `45c664918d25ec5213836c9eca420df7616483f3c67fd4b67d8e014bb8f933f4`, with output hash `e006eab7a6cff892127d6019bc4c1b3da80e418f480df4cc53b91b8b8194f7df`.

### Deterministic structured mutation

The declared mutation stream was:

[
(1,4,5,6,7,11)\cup{x},
\qquad x=1,2,\ldots,120,
]

with collisions and nonprimitive tuples skipped, sorting applied, and termination at the first exact (S_8\le0).

The first failure occurred at emitted mutation ordinal (26), with (x=32). The immediately preceding tuple, with (x=31), had

[
S_8(1,4,5,6,7,11,31)
====================

\frac{327,600,099}{9,392,075}>0.
]

No mutation after (x=32) was evaluated.

### Full counterexample certificate

For

[
a=(1,4,5,6,7,11,32),
]

write (h_m^{(j)}=#{r\in R_j:\mu_j(r)=m}). Each histogram below is
((h_0,h_1,\ldots,h_6)).

| Pivot (p) | (M=8p) | (|R_j|=7p) | Multiplicity histogram | Local score (S_j) | Good residues | Hits (\rho=p-1) / (\rho=p) |
|---:|---:|---:|---|---:|---|---:|
| (1) | (8) | (7) | ((0,4,2,1,0,0,0)) | (-84/425) | none | (11/6) |
| (4) | (32) | (28) | ((0,8,12,8,0,0,0)) | (-572/425) | none | (8/12) |
| (5) | (40) | (35) | ((0,22,10,3,0,0,0)) | (-352/425) | none | (18/6) |
| (6) | (48) | (42) | ((0,26,10,6,0,0,0)) | (-454/425) | none | (8/8) |
| (7) | (56) | (49) | ((2,34,8,3,2,0,0)) | (5178/4675) | (17,39) | (10/6) |
| (11) | (88) | (77) | ((2,50,18,5,0,2,0)) | (1206/3485) | (27,61) | (10/6) |
| (32) | (256) | (224) | ((4,150,46,14,2,4,4)) | (-7571024/9392075) | (78,79,177,178) | (8/0) |

Thus

[
\begin{aligned}
S_8(a)
={}&-\frac{84}{425}
-\frac{572}{425}
-\frac{352}{425}
-\frac{454}{425}\
&+\frac{5178}{4675}
+\frac{1206}{3485}
-\frac{7571024}{9392075}\
={}&-\frac{5,245,398}{1,878,415}.
\end{aligned}
]

The fraction is reduced and strictly negative.

Additional exact checks:

[
\sum_j|R_j|=462
===============

7(1+4+5+6+7+11+32),
]

and there are exactly (8) uncovered candidates globally.

Across all owner-pivot-candidate triples, there are (73) occurrences of
(\rho=p-1), all treated as bad, and (44) occurrences of (\rho=p), all treated as safe.

Reflection invariance holds at every pivot. The antipodes are candidates exactly for the odd pivots (p=1,5,7,11); each has multiplicity (3). The antipodes at (p=4,6,32) are excluded (N)-multiples.

The nonunit-owner counts for pivots (1,4,5,6,7,11,32) are respectively

[
(3,2,3,2,3,3,2).
]

The collision fixture ((1,3,13)) was also replayed: at pivot speed (3), owners (1) and (13) have the same nonempty bad set

[
{1,2,10,11},
]

but contribute as two separate owners.

Both programs verified scaling by (2) and (3) on all 23 named fixtures. Both explicitly checked all (7!=5040) permutations of the counterexample. General permutation invariance also follows by relabeling pivot and owner indices, so every tuple permutation has the same global score.

---

## 7. Attack A

Define

[
P_a(x)=\sum_j\sum_{r\in R_j}x^{8\mu_j(r)}.
]

Termwise,

[
\int_0^1x^{8m},dx=\frac1{8m+1}
]

and

[
\frac{x}{8}\frac{d}{dx}x^{8m}=m x^{8m}.
]

Therefore

[
\begin{aligned}
S_8(a)
&=
\int_0^1
\left(P_a(x)-\frac{x}{8}P_a'(x)\right),dx\
&=
\frac98\int_0^1P_a(x),dx-\frac18P_a(1).
\end{aligned}
]

Equivalently,

[
\phi_8(m)=\frac{9}{8(8m+1)}-\frac18,
]

so, with (T=P_a(1)),

[
S_8(a)>0
\iff
\sum_{j,r}\frac1{8\mu_j(r)+1}>\frac{T}{9}.
]

For the counterexample, aggregating the seven pivot histograms gives

[
P_a(x)
======

8+294x^8+106x^{16}+40x^{24}
+4x^{32}+6x^{40}+4x^{48}.
]

Hence

[
P_a(1)=462
]

and

[
\int_0^1P_a(x),dx
=================

\frac{275,288,182}{5,635,245}.
]

But

[
\frac{P_a(1)}9=\frac{154}{3},
]

and exactly

[
\int_0^1P_a(x),dx-\frac{154}{3}
===============================

-\frac{4,662,576}{1,878,415}<0.
]

Thus the required universal owner-incidence inequality

[
9\int_0^1P_a(x),dx>P_a(1)
]

is false. The generating-function identity is valid, but there can be no universal compression, convexity, or owner-labelled double count proving its positive sign at the frozen constant.

Under the stop rule, no further Attack A inequality was pursued.

---

## 8. Attack B

Let

[
\ell=\operatorname{lcm}(a_i:i\in\operatorname{Fin}n),
\qquad
L=N\ell,
]

and for pivot (j) define

[
d_j=\frac{L}{Na_j}=\frac{\ell}{a_j}.
]

The common-clock map is

[
\iota_j:R_j\longrightarrow\mathbb Z/L\mathbb Z,
\qquad
\iota_j(r)=d_jr.
]

Because (0\le r<Na_j),

[
0\le d_jr<L,
]

so no modular wrap occurs in the chosen representatives.

If (d_jr_1\equiv d_jr_2\pmod L), then

[
L\mid d_j(r_1-r_2).
]

Since (L=Na_jd_j),

[
Na_j\mid r_1-r_2.
]

Both representatives lie in (0,\ldots,Na_j-1), so (r_1=r_2). Thus the map is injective.

Its image is exactly

[
{d_jr:0\le r<Na_j,\ N\nmid r}.
]

At the represented time (t=u/L),

[
t=\frac{d_jr}{L}=\frac{r}{Na_j}.
]

For every coordinate (i),

[
\left|\frac{ra_i}{Na_j}\right|
==============================

\frac{\rho_{Na_j}(ra_i)}{Na_j}.
]

Consequently,

[
\left|\frac{ra_i}{Na_j}\right|<\frac1N
\iff
\rho_{Na_j}(ra_i)<a_j.
]

Therefore (\mu_j(r)) is exactly the number of nonpivot coordinates strictly bad at common-clock time (u/L).

For the counterexample,

[
\ell=\operatorname{lcm}(1,4,5,6,7,11,32)=36,960,
\qquad
L=295,680.
]

Despite the exact common-clock interpretation, its global score is negative. Therefore any proposed arithmetic orbit decomposition or additive-energy estimate whose conclusion is (S_8(a)>0) for every primitive tuple is false at the frozen constant.

The common-clock embedding is `proved-math`. The first genuinely new sign inequality required by Attack B is rejected by the same exact tuple. No Fourier, Gram, private-cover, or deletion machinery was introduced.

---

## 9. Sole unrestricted lemma

The statement

[
\forall n\ge2,\ \forall\text{ positive injective primitive }a,
\qquad S_8(a)>0
]

is **rejected**.

The tuple

[
a=(1,4,5,6,7,11,32)
]

satisfies every premise:

[
n=7\ge2,\qquad
a_i>0,\qquad
a_i\ne a_k\text{ for }i\ne k,\qquad
\gcd(a_i)=1.
]

Its exact score is

[
S_8(a)
======

-\frac{5,245,398}{1,878,415}<0.
]

No change of constant, weighting, sign, tuple class, or positive-part transform is made. No nearby inequality is promoted. Common scalings produce additional nonprimitive failures by

[
S_8(ca)=cS_8(a),
]

but the displayed primitive tuple already decisively refutes the frozen theorem.

---

## 10. Complete implication chain, proof-obligation ledger, and final evidence boundary

### Conditional implication chain

For (n=1), primitive normalization gives (a=(1)), (N=2), (R={1}), and there are no nonpivot owners. Hence

[
\mu(1)=0,\qquad S_8(a)=1,
]

and (r=1) is a direct certificate.

For (n\ge2), the intended chain would be:

[
\begin{aligned}
&\text{arbitrary positive injective }A\
&\quad\longrightarrow
a=A/\gcd(A)\text{ primitive}\
&\quad\longrightarrow
S_8(a)>0\
&\quad\longrightarrow
\exists j,r,\ \mu_j(r)=0\
&\quad\longrightarrow
\text{one canonical pivot certificate for }a\
&\quad\longrightarrow
\text{one canonical pivot certificate for }A\
&\quad\longrightarrow
\texttt{PositiveIntegerPivotCertificateConjecture}\
&\quad\longrightarrow
\texttt{PositiveIntegerConjecture}\
&\quad\longrightarrow
\texttt{Conjecture}\
&\quad\longrightarrow
\text{unrestricted real LRC}.
\end{aligned}
]

The normalization, score scaling, sign implication, pivot-coordinate safety, and certificate lift are valid. The chain fails at

[
\text{primitive }a
\longrightarrow
S_8(a)>0,
]

because the primitive counterexample has negative score.

### Proof-obligation ledger

| Obligation                                  | Status                   | Result                                                 |     |        |
| ------------------------------------------- | ------------------------ | ------------------------------------------------------ | --- | ------ |
| (n=1) base case                             | `proved-math`            | Direct certificate (r=1) after primitive normalization |     |        |
| Candidate cardinality                       | `proved-math`            | (                                                      | R_j | =na_j) |
| Primitive gcd normalization                 | `proved-math`            | Positivity and injectivity preserved                   |     |        |
| Exact scaling fibers                        | `proved-math`            | Exactly (c) fibers per candidate                       |     |        |
| Strict badness under scaling                | `proved-math`            | Preserved owner by owner, including equality safety    |     |        |
| Score scaling                               | `proved-math`            | (S_8(ca)=cS_8(a))                                      |     |        |
| Universal primitive positivity              | `rejected`               | Fails on ((1,4,5,6,7,11,32))                           |     |        |
| Positive score to zero multiplicity         | `proved-math`            | Follows from (\phi_8(m)\le0) for (m\ge1)               |     |        |
| Zero multiplicity to nonpivot safety        | `proved-math`            | Direct expansion of (\mu_j(r)=0)                       |     |        |
| Pivot-coordinate safety                     | `proved-math`            | (\rho_{Na_j}(ra_j)\ge a_j) for (r\in R_j)              |     |        |
| Certificate lift through common scaling     | `proved-math`            | Centered distances scale by the gcd                    |     |        |
| Existing integer and real implication chain | `proved-lean` dependency | Not replayed because its Prompt 82 input failed        |     |        |
| Unrestricted LRC                            | `open`                   | No status change                                       |     |        |

Current literature continues to treat the unrestricted conjecture as open, while recent results establish additional fixed runner counts rather than an unrestricted theorem. ([arXiv][1])

No tracked repository was edited. No Lean prototype was attempted. No adaptive constant or replacement theorem was introduced. The exact evidence boundary is:

[
\boxed{\text{Prompt 82 invariant rejected; unrestricted LRC unchanged and open.}}
]

[1]: https://arxiv.org/abs/2409.20160?utm_source=chatgpt.com "The Lonely Runner Conjecture turns 60"
