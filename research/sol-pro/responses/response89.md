## 1. **Disposition**

**PIVOT**

The finite construction theorem and generic junction theorem are proved below at the level of exact mathematical reasoning. The frozen fixtures and all (811) tuples in (D_{\mathrm{pre}}) were reproduced by two algorithmically distinct response-authored evaluators.

The unrestricted statement

[
\texttt{BALANCED-JUNCTION-COVER-DEFICIT}
]

was neither proved nor refuted. Attack A admits an exact expectation calculation, but that expectation fails at every pivot of the mandatory P85 tuple. Attacks B and C do not close the remaining pivot-and-construction selection.

A strictly narrower, non-tautological successor survives every mandatory fixture and the complete frozen domain:

[
\texttt{ROOT-STAR-BALANCED-DEFICIT}.
]

It restricts the balanced construction to one (b)-owner root and root-attached children. Its junction score reduces to one explicit core-selection functional. This restriction is genuine: at the P85 pivot of speed (13), the unrestricted balanced minimum is (96), while the root-star minimum is (98). Both are below (|R_j|=104), but the optimizer classes are not equivalent.

No theorem or computation is promoted by this response.

---

## 2. **Exact definitions**

For (m\in\mathbb N), define

[
\operatorname{ceilSqrt}(m)
=\min{s\in\mathbb N:m\le s^2}.
]

The defining set is nonempty: (0) works for (m=0), and (m) works for (m\ge1). Well-ordering of (\mathbb N) gives existence of the minimum. It satisfies

[
m\le \operatorname{ceilSqrt}(m)^2
]

and

[
m\le s^2\Longrightarrow \operatorname{ceilSqrt}(m)\le s.
]

Set

[
b(m)=\min\bigl(m,1+\operatorname{ceilSqrt}(m)\bigr).
]

Fix (n\ge3), put (N=n+1), and let

[
a:\operatorname{Fin}n\to\mathbb N
]

be positive and injective. For a pivot (j), write

[
p=a_j,\qquad M=Np,\qquad O_j={i:i\ne j}.
]

For (x\in\mathbb Z), define

[
\rho_M(x)=\min(x\bmod M,;M-(x\bmod M)).
]

The candidate grid and labelled strict bad sets are

[
R_j={r\in\operatorname{Fin}M:N\nmid r},
]

[
B_i^j={r\in R_j:\rho_M(ra_i)<p},
\qquad i\in O_j.
]

The owner labels remain distinct even if the underlying subsets coincide. Exactly (p) residues modulo (Np) are divisible by (N), so

[
|R_j|=Np-p=np.
]

For (S\subseteq O_j), define

[
U_j(S)=\bigcup_{i\in S}B_i^j.
]

Let (m=|O_j|=n-1) and (b=b(m)).

A normalized balanced construction consists of the following data.

When (m=b), there is one root bag (O_j), with no separator or nonroot parent.

When (m>b):

1. A bijection
   [
   \sigma:\operatorname{Fin}m\to O_j
   ]
   whose first (b) labels are increasing in the ambient coordinate order.

2. Root bag
   [
   Q_0={\sigma(0),\ldots,\sigma(b-1)}.
   ]

3. For each (k=b,\ldots,m-1), a separator
   [
   S_k\subset O_j,\qquad |S_k|=b-1,
   ]
   contained in at least one earlier bag.

4. The new bag
   [
   Q_{k-b+1}=S_k\cup{\sigma(k)}.
   ]

5. The parent of (Q_{k-b+1}) is the least earlier bag index containing (S_k).

Since (\sigma(k)) is new, it is absent from all earlier bags and from (S_k).

All cardinalities in the junction functional are cast to (\mathbb Z):

[
J_j(D)
======

## \sum_v \operatorname{Int}|U_j(Q_v)|

\sum_{c\ne0}
\operatorname{Int}|U_j(S_c)|.
]

Write

[
C_r={i\in O_j:r\in B_i^j}
]

for the owner set of a covered residue, and

[
G_j=\left|R_j\setminus\bigcup_{i\in O_j}B_i^j\right|.
]

---

## 3. **Finite construction theorem**

### Square-root bag bound

For (m\ge4),

[
(m-2)^2-m=(m-1)(m-4)\ge0.
]

Thus (m\le(m-2)^2), so leastness gives

[
\operatorname{ceilSqrt}(m)\le m-2.
]

Consequently,

[
b(m)=1+\operatorname{ceilSqrt}(m)\le m-1<m.
]

The exact controls are

[
b(2)=2,\quad b(3)=3,\quad b(4)=3,
]

[
b(5)=\cdots=b(9)=4,\qquad b(10)=5.
]

Also (b(m)\le \sqrt m+2), so (b(m)/m\to0).

### Rooted-tree structure

Each nonroot bag has one parent of strictly smaller index. Repeatedly following parents therefore strictly decreases the index and terminates at the root. Parent edges are acyclic and every vertex reaches the root, so they form a finite rooted tree.

### Coverage

The root contains (\sigma(0),\ldots,\sigma(b-1)). At introduction stage (k), the bag (Q_{k-b+1}) contains the new owner (\sigma(k)). Hence every owner label occurs in at least one bag.

### Running intersection

Proceed by introduction induction for each owner (x).

Before adding a child (Q_c=S_c\cup{\sigma(k)}):

* If (x=\sigma(k)), its bag set is initially ({c}), hence connected.
* If (x\in S_c), then (x) lies in both (Q_c) and its parent, so attaching (Q_c) preserves connectedness.
* If (x\notin Q_c), its previous bag subtree is unchanged.

Thus the bags containing each owner induce a connected subtree.

### Exact separator intersection

Let (p(c)) be the parent of (c). Since (S_c\subseteq Q_{p(c)}) and the introduced owner is absent from every earlier bag,

[
Q_c\cap Q_{p(c)}
================

# (S_c\cup{\sigma(k)})\cap Q_{p(c)}

S_c.
]

### Exact construction count

The normalized root contributes

[
\binom mb
]

choices. The remaining owners can be introduced in

[
(m-b)!
]

orders.

Initially the root has exactly (b) distinct ((b-1))-faces. Suppose (t) owners have already been introduced. A new bag shares the selected separator face with an earlier bag. Its other (b-1) faces all contain the newly introduced owner, so none occurred earlier. Therefore the number of available separator faces before introduction (t) is exactly

[
b+t(b-1).
]

The least-parent rule is deterministic and contributes no factor. Hence

[
\boxed{
#\mathcal D(m)
==============

\binom mb(m-b)!
\prod_{t=0}^{m-b-1}\bigl(b+t(b-1)\bigr)
}.
]

The empty product gives (1) when (m=b).

Exact controls:

[
#\mathcal D(2)=1,\qquad
#\mathcal D(3)=1,
]

[
#\mathcal D(4)=12,\qquad
#\mathcal D(5)=20,
]

[
#\mathcal D(6)=840,\qquad
#\mathcal D(7)=58{,}800.
]

---

## 4. **Generic junction theorem**

### Leaf induction

Use the following tree-indexed finite-set statement. Let (A_v) be a finite set at each tree vertex, and let (E_{uv}\subseteq A_u\cap A_v) for each edge. Then

[
\operatorname{Int}\left|\bigcup_v A_v\right|
\le
\sum_v\operatorname{Int}|A_v|
-----------------------------

\sum_{uv}\operatorname{Int}|E_{uv}|.
]

For one vertex this is equality. For a nonroot leaf (c), let

[
W=\bigcup_{v\ne c}A_v.
]

If (p(c)) is its parent, then

[
E_{c,p(c)}\subseteq A_c\cap W.
]

Exact finite inclusion-exclusion gives

[
\operatorname{Int}|W\cup A_c|
=============================

\operatorname{Int}|W|
+\operatorname{Int}|A_c|
-\operatorname{Int}|W\cap A_c|
]

and therefore

[
\operatorname{Int}|W\cup A_c|
\le
\operatorname{Int}|W|
+\operatorname{Int}|A_c|
-\operatorname{Int}|E_{c,p(c)}|.
]

Apply induction to the remaining tree.

For the balanced construction, take

[
A_v=U_j(Q_v),\qquad E_{c,p(c)}=U_j(S_c).
]

Bag coverage implies

[
\bigcup_vU_j(Q_v)=\bigcup_{i\in O_j}B_i^j.
]

Thus

[
\boxed{
\operatorname{Int}\left|\bigcup_{i\in O_j}B_i^j\right|
\le J_j(D)
}.
]

Since the left side is nonnegative,

[
0\le J_j(D).
]

### Component identity

For a covered residue (r), each owner (i\in C_r) has a connected bag subtree (T_i). Define (H_r) as the graph union

[
H_r=\bigcup_{i\in C_r}T_i.
]

This is not the induced subgraph on the active bags. An ambient tree edge belongs to (H_r) exactly when its separator contains at least one owner from (C_r).

The contribution of (r) to the bag sum in (J_j(D)) is the number of vertices of (H_r). Its contribution to the separator sum is the number of edges of (H_r). Since (H_r) is a forest,

[
|V(H_r)|-|E(H_r)|=\kappa_D(r),
]

where (\kappa_D(r)) is its number of connected components. Finite interchange of sums gives

[
\boxed{
J_j(D)
======

\sum_{r\in\bigcup_iB_i^j}\kappa_D(r)
}.
]

Consequently,

[
\boxed{
J_j(D)
------

# \operatorname{Int}\left|\bigcup_iB_i^j\right|

\sum_{r\in\bigcup_iB_i^j}\bigl(\kappa_D(r)-1\bigr)
}.
]

Because

[
|R_j|
=====

\left|\bigcup_iB_i^j\right|+G_j,
]

one obtains the exact criterion

[
\boxed{
J_j(D)<\operatorname{Int}|R_j|
\iff
\sum_{r\in\bigcup_iB_i^j}\bigl(\kappa_D(r)-1\bigr)<G_j
}.
]

### Strict-deficit implication

If (J_j(D)<|R_j|), then

[
\left|\bigcup_iB_i^j\right|<|R_j|,
]

so some (r\in R_j) avoids every owner bad set.

Write (s=r\bmod N). Since (r\in R_j),

[
1\le s\le N-1.
]

At the pivot,

[
\rho_{Np}(rp)
=============

p\min(s,N-s)\ge p.
]

For (i\ne j), avoidance of (B_i^j) gives

[
\rho_{Np}(ra_i)\ge p.
]

At time

[
t=\frac r{Np},
]

every coordinate therefore satisfies

[
|ta_i|_{\mathbb R/\mathbb Z}
============================

\frac{\rho_{Np}(ra_i)}{Np}
\ge\frac1N.
]

Equality (\rho=p) is retained as safe.

---

## 5. **Anti-tautology and route separation**

For (m\ge4), (b(m)<m). Neither the sole target nor the pivot successor below permits the full-owner bag.

For the four-owner pair-incidence system, let the six points be (e_{uv}), one for each unordered pair, with (e_{uv}) covered exactly by owners (u,v). Every (b(4)=3) construction has one root triple and one child triple. Each triple covers all six points. Their two-owner separator covers five points. Hence

[
J=6+6-5=7
]

while the exact union has size (6). Thus the junction functional can overcount genuinely.

For (m=2,3), (b=m), and the one-bag construction gives equality. This low-dimensional degeneration does not affect the non-tautological (m\ge4) statement.

The route remains distinct from:

* **Prompt66:** token-parent block packing uses residue capacities, not an owner running-intersection tree or component count.
* **Prompt85:** the bag size was fixed at (3) for all dimensions. Here (b(7)=4) follows from a single pre-frozen formula.
* **Prompt86:** its local owner-multiplicity score does not choose bags, separators, or a core, and does not control (\kappa_D(r)).

### Scaling law

For a common factor (q>0), put (a'_i=qa_i). Then for the corresponding pivot,

[
p'=qp,\qquad M'=qM.
]

Reduction modulo (M),

[
\pi:\mathbb Z/(qM)\mathbb Z\to\mathbb Z/M\mathbb Z,
]

has exactly (q) elements in each fiber. Since (N\mid M),

[
N\nmid r\iff N\nmid\pi(r).
]

Also

[
\rho_{qM}(q x)=q\rho_M(x).
]

Therefore

[
B_i^{\prime j}=\pi^{-1}(B_i^j),
]

and for every owner subset (S),

[
|U'_j(S)|=q|U_j(S)|.
]

The normalized construction domain is unchanged, so

[
J'_j(D)=qJ_j(D),\qquad |R'_j|=q|R_j|.
]

Coordinate permutation merely relabels owners and pivots. It preserves all corresponding cardinalities and minimum junction values.

---

## 6. **Falsification report**

All results in this section have status **unverified computation**. They were produced inside this response and have not received an external audit.

Two evaluators were used:

1. Literal enumeration of every normalized construction using integer bit sets.
2. A memoized recursion over remaining owner labels and available ((b-1))-faces using independently formed `frozenset` residue unions.

They agreed on every fixture pivot and every pivot in (D_{\mathrm{pre}}).

### Mandatory fixture rows

| Fixture | (m) | (b) | Pivot speed | (|R_j|) | Exact union | Minimum (J) | Root-star minimum |
|---|---:|---:|---:|---:|---:|---:|---:|
| P76 ((1,4,5,6,7,11)) | 5 | 4 | 6 | 36 | 34 | 34 | 34 |
| P77 ((6,7,168)) | 2 | 2 | 168 | 504 | 378 | 378 | 378 |
| P78 ((6,7,12,24,144)) | 4 | 3 | 144 | 720 | 560 | 560 | 560 |
| P79 ((1,3,4)) | 2 | 2 | 3 | 9 | 7 | 7 | 7 |
| P79 ((1,3,4,5)) | 3 | 3 | 4 | 16 | 14 | 14 | 14 |
| P80 ((1,3,16)) | 2 | 2 | 3 | 9 | 7 | 7 | 7 |
| P82 ((1,4,5,6,7,11,32)) | 6 | 4 | 7 | 49 | 47 | 47 | 47 |
| P85 ((1,2,5,7,9,11,12,13)) | 7 | 4 | 7 | 56 | 50 | 50 | 50 |

### Every P85 pivot

| Pivot speed | (|R_j|) | Union | (G_j) | Minimum (J) | Root-star (J) | Strict margin |
|---:|---:|---:|---:|---:|---:|---:|
| 1 | 8 | 8 | 0 | 8 | 8 | 0 |
| 2 | 16 | 16 | 0 | 16 | 16 | 0 |
| 5 | 40 | 40 | 0 | 40 | 40 | 0 |
| 7 | 56 | 50 | 6 | 50 | 50 | 6 |
| 9 | 72 | 64 | 8 | 66 | 66 | 6 |
| 11 | 88 | 82 | 6 | 84 | 84 | 4 |
| 12 | 96 | 90 | 6 | 92 | 92 | 4 |
| 13 | 104 | 96 | 8 | 96 | 98 | 6 |

The five strict pivots are therefore (7,9,11,12,13). No Prompt85 response-authored minimum was used.

### Complete frozen domain

The CSV contains (3914) pivot rows:

[
109\cdot3+205\cdot4+251\cdot5+210\cdot6+36\cdot7=3914.
]

Enumeration order was tuple lexicographic, pivot increasing, root lexicographic, introduction-owner lexicographic, and separator tuple-lexicographic.

|       (n) | (H) | Primitive tuples | Balanced passed | Root-star passed | Failures |
| --------: | --: | ---------------: | --------------: | ---------------: | -------: |
|         3 |  10 |              109 |             109 |              109 |        0 |
|         4 |  10 |              205 |             205 |              205 |        0 |
|         5 |  10 |              251 |             251 |              251 |        0 |
|         6 |  10 |              210 |             210 |              210 |        0 |
|         7 |   9 |               36 |              36 |               36 |        0 |
| **Total** |     |          **811** |         **811** |          **811** |    **0** |

The smallest best strict margin over the domain was (2).

### Additional mandatory controls

* Construction counts reproduced:
  [
  1,1,12,20,840,58{,}800
  ]
  for (m=2,\ldots,7).
* Root-star construction counts:
  [
  1,1,12,20,480,13{,}440.
  ]
* Abstract four-owner pair incidence:
  [
  |U|=6,\qquad \min J=7.
  ]
  The altered expectation (\min J=6) was rejected.
* One-bag tests:
  [
  m=2:\ J=|U|=4,\qquad
  m=3:\ J=|U|=6.
  ]
* Five distinct labels with identical bad sets were retained as five owners. All (20) constructions had
  [
  |U|=J=3.
  ]
* Boundary test used (N=5,p=4,M=20):

  * (\rho=3=p-1) was bad on both cyclic sides.
  * (\rho=4=p) was safe on both sides.
  * Zero was in the strict target interval.
  * The antipode (10) was safe.
  * Residues (0,5,10,15) were excluded as (N)-multiples.
  * (|R|=16).
* P77 nonunit control:
  [
  M=672,\quad \gcd(6,M)=6,\quad \gcd(7,M)=7,
  ]
  and the two bad sets intersected in (126) residues.
* P78 nonunit control:
  [
  M=864,
  ]
  with owner gcds (6,1,12,24). Pair-intersection sizes were
  [
  80,120,60,80,80,120.
  ]
* Common scaling by (3) reproduced exact factor-(3) scaling of every (|R_j|), union size, and minimum (J_j) for all pivots of P76.
* The permutation
  [
  (3,0,5,1,4,2)
  ]
  preserved all corresponding pivot values.
* Repeated owner, missing owner, wrong separator size, unavailable separator, nonleast parent, broken running intersection, and wrong bag-size controls were all rejected.

### Frozen artifacts and hashes

* [Verifier source](sandbox:/mnt/data/balanced_junction_verify.py)
  SHA-256: `661934cfdc952c4b7c602fe6a7e14e3f79dba85676a2a55cf89b7e8283949473`
* [Complete JSON report](sandbox:/mnt/data/balanced_junction_verification_report.json)
  SHA-256: `79b62b56c923e35de9535f83daa0bda5494da0d1f4aca26e418a0fa1ff0d4fb4`
* [All (D_{\mathrm{pre}}) pivot rows](sandbox:/mnt/data/balanced_junction_D_pre_all_pivots.csv)
  SHA-256: `a0e7b925967226eb5893a551924eb090f506226304e21e06f0fc21f83d9d2659`
* [SHA-256 manifest](sandbox:/mnt/data/balanced_junction_sha256.txt)
  SHA-256: `98d908407e49e831c016c9b477a11108c557a24d6c541958faf4748f0df2d701`

---

## 7. **Attack A**

Define a probability distribution on normalized balanced constructions as follows:

1. Choose the root (b)-subset uniformly.
2. Write it in increasing order.
3. Choose the introduction order of the other (m-b) labels uniformly.
4. At introduction stage (t), choose uniformly from the
   [
   b+t(b-1)
   ]
   currently available separator faces.
5. Record the deterministic least parent.

Every normalized construction has probability

[
\left[
\binom mb(m-b)!
\prod_{t=0}^{m-b-1}(b+t(b-1))
\right]^{-1},
]

so this is the uniform distribution.

Fix a nonempty owner set (C\subseteq O_j). Adding a child changes the component count of the graph union of the (C)-owner subtrees by

[
1_{{\text{child active}}}
-------------------------

1_{{\text{parent edge active}}}.
]

For the child introducing (x) through separator (S), this increment is exactly

[
1_{{x\in C,\ S\cap C=\varnothing}}.
]

Therefore

[
\boxed{
\kappa_D(C)
===========

1_{{Q_0\cap C\ne\varnothing}}
+
\sum_{k=b}^{m-1}
1_{{\sigma(k)\in C,\ S_k\cap C=\varnothing}}
}.
]

Let (c=|C|). The root-intersection probability is

[
1-\frac{\binom{m-c}{b}}{\binom mb}.
]

At a fixed introduction position, owner symmetry implies that the chosen separator is marginally uniform among all ((b-1))-subsets of the previously available labels. Conditional on the introduced owner belonging to (C), its separator is marginally uniform among the ((b-1))-subsets of the other (m-1) labels. Hence

[
\Pr\bigl(\sigma(k)\in C,\ S_k\cap C=\varnothing\bigr)
=====================================================

\frac cm
\frac{\binom{m-c}{b-1}}{\binom{m-1}{b-1}}.
]

There are (m-b) introduction positions. Thus

[
\mathbb E[\kappa_D(C)]
======================

1-\frac{\binom{m-c}{b}}{\binom mb}
+
(m-b)\frac cm
\frac{\binom{m-c}{b-1}}{\binom{m-1}{b-1}}.
]

Using

[
\frac{\binom{m-c}{b}}{\binom mb}
================================

\frac{m-c-b+1}{m}
\frac{\binom{m-c}{b-1}}{\binom{m-1}{b-1}},
]

one obtains

[
\boxed{
\mathbb E[\kappa_D(C)-1]
========================

# \phi_{m,b}(c)

\frac{(c-1)(m-b+1)}m
\frac{\binom{m-c}{b-1}}{\binom{m-1}{b-1}}
}.
]

The convention is (\binom uv=0) for (u<v).

For a fixed pivot,

[
\mathbb E_D
\left[
J_j(D)-\left|\bigcup_iB_i^j\right|
\right]
=======

\sum_{r\text{ covered}}\phi_{m,b}(|C_r|).
]

All sums and denominators are finite and nonnegative. Therefore the exact sufficient condition

[
\sum_{r\text{ covered}}\phi_{m,b}(|C_r|)<G_j
]

would select at least one (D) at that fixed pivot.

### First fatal arrow

For the P85 tuple, the exact energies are:

| Pivot | Expected component penalty | (G_j) |
| ----: | -------------------------: | ----: |
|     1 |                      (4/7) |     0 |
|     2 |                     (12/7) |     0 |
|     5 |                   (136/35) |     0 |
|     7 |                   (248/35) |     6 |
|     9 |                   (314/35) |     8 |
|    11 |                   (348/35) |     6 |
|    12 |                   (338/35) |     6 |
|    13 |                   (404/35) |     8 |

The expectation is not below (G_j) at any pivot. At speed (7), for example,

[
\frac{248}{35}>6,
]

although an optimized construction has penalty (0). Attack A therefore fails at the averaging-to-pivot arrow. This rejects the uniform balanced-construction average, not the sole theorem.

Uniform averaging over root-star constructions yields the same (\phi_{m,b}(c)), so merely restricting to stars without arithmetically biasing the core does not repair the failure.

---

## 8. **Attack B**

### Exact singleton arithmetic

Fix an owner speed (q=a_i), pivot speed (p), and (M=Np). Put

[
d=\gcd(q,M),\qquad
g=\gcd(q,p),\qquad
h=\left\lfloor\frac{p-1}{N}\right\rfloor.
]

In the complete residue grid modulo (M), the strict target interval is

[
T_p={x:\rho_M(x)<p}.
]

The number of multiples of (d) in (T_p) is

[
1+2\left\lfloor\frac{p-1}{d}\right\rfloor.
]

Each such image has (d) preimages under multiplication by (q).

For an excluded candidate (r=Nu), one has

[
\rho_{Np}(qNu)
==============

N,\rho_p(qu).
]

Strict badness is therefore equivalent to

[
\rho_p(qu)\le h.
]

The number of image multiples of (g) in this reduced strict target is

[
1+2\left\lfloor\frac hg\right\rfloor,
]

with (g) preimages each. Consequently, as an integer identity,

[
\boxed{
\operatorname{Int}|B_i^j|
=========================

## d\left(1+2\left\lfloor\frac{p-1}{d}\right\rfloor\right)

g\left(1+2\left\lfloor\frac hg\right\rfloor\right)
}.
]

This includes zero targets, both cyclic sides, nonunits, and candidate subtraction.

### Exact higher intersections

For owners (q_\ell), let

[
d_\ell=\gcd(q_\ell,M),\qquad M_\ell=M/d_\ell.
]

For a target image (x_\ell\in T_p) divisible by (d_\ell), divide

[
q_\ell r\equiv x_\ell\pmod M
]

by (d_\ell). Since (q_\ell/d_\ell) is invertible modulo (M_\ell), this gives one congruence

[
r\equiv
\left(q_\ell/d_\ell\right)^{-1}
\left(x_\ell/d_\ell\right)
\pmod {M_\ell}.
]

A collection of such congruences is solvable exactly when the generalized-CRT compatibility conditions hold modulo every (\gcd(M_\ell,M_{\ell'})). Each compatible target tuple contributes

[
\frac{M}{\operatorname{lcm}*\ell M*\ell}
]

solutions modulo (M).

The candidate subtraction is the analogous computation modulo (p), using

[
g_\ell=\gcd(q_\ell,p)
]

and the reduced target (\rho_p(v)\le h). Each compatible candidate-target tuple contributes

[
\frac{p}{\operatorname{lcm}*\ell(p/g*\ell)}.
]

Thus every finite intersection, and hence every (U_j(S)), is exactly computable without coprime cancellation.

### First fatal arrow

These formulas provide exact cardinalities but not the required sign. In particular,

[
\sum_r|C_r|=\sum_i|B_i^j|
]

and pairwise additive energies do not determine how the labelled sets (C_r) intersect a proposed (b)-owner core. The component penalty distinguishes the events

[
C_r\cap Q=\varnothing,\qquad
C_r\cap Q={y},\qquad
|C_r\cap Q|\ge2.
]

Those are label-specific cells, not functions only of (|C_r|), singleton totals, or pair totals.

The P85 fixture demonstrates the obstruction concretely. Its multiplicity-only symmetric average fails at all pivots, but at pivot speed (7) the core

[
Q={1,5,11,12}
]

with the outside-owner drop choices

[
2\mapsto5,\qquad
9\mapsto1,\qquad
13\mapsto1
]

has component penalty (0). Thus a successful arithmetic argument must select an asymmetric core and face choices. No generalized-CRT or cross-pivot inequality proving that selection was obtained.

---

## 9. **Attack C**

Assume hypothetically that the sole target is false. Scaling and permutation invariance permit selection of a counterexample that is:

1. primitive,
2. strictly increasing,
3. lexicographically least by
   [
   (n,\max a_i,\sum_i a_i,a).
   ]

For such a tuple, the exact obstruction is

[
\forall j\ \forall D,\qquad
\sum_{r\text{ covered}}\bigl(\kappa_D(r)-1\bigr)\ge G_j.
]

For the root-star subclass, it would imply that every permitted core has root-star penalty at least (G_j).

No valid descent follows from coordinate deletion. Deleting one speed changes all of the following simultaneously:

[
N=n+1\longrightarrow n,
]

[
M=(n+1)p\longrightarrow np,
]

[
R_j={N\nmid r}\longrightarrow{n\nmid r},
]

and

[
b(n-1)\longrightarrow b(n-2).
]

A lower-dimensional witness

[
t'=\frac{r'}{np}
]

does not canonically produce a residue modulo ((n+1)p), and it provides no safety condition for the deleted coordinate. The strict bad boundaries and candidate exclusions are not preserved by the identity map on residues or by a fixed linear rescaling.

Therefore the first missing descent arrow is:

[
\boxed{
\text{lower-dimensional pivot witness}
\ \not\Longrightarrow
\text{original-dimensional pivot witness with the deleted owner restored}
}.
]

No exact counterexample occurred in the permitted frozen domain, and no second bounded search was performed. Attack C therefore supplies neither a refutation nor a valid minimal-counterexample descent.

---

## 10. **Sole theorem proof or STOP certificate**

There is no proof of every quantifier of `BALANCED-JUNCTION-COVER-DEFICIT`, and there is no exact tuple refuting it. The pivot certificate is the following narrower successor.

### `ROOT-STAR-BALANCED-DEFICIT`

Fix a pivot (j). For a (b)-owner core (Q\subseteq O_j), define

[
A_j(Q)
======

\sum_{\substack{r\text{ covered}\C_r\cap Q=\varnothing}}
(|C_r|-1).
]

For (x\in O_j\setminus Q) and (y\in Q), define

[
w_j(Q;x,y)
==========

\left|
\left{
r:
x\in C_r,\ C_r\cap Q={y}
\right}
\right|.
]

Define the root-star core penalty

[
P_j^\star(Q)
============

A_j(Q)
+
\sum_{x\in O_j\setminus Q}
\min_{y\in Q}w_j(Q;x,y).
]

The successor theorem is

[
\boxed{
\begin{aligned}
&\forall n\ge3\ \forall a\text{ positive injective},\
&\exists j\ \exists Q\subseteq O_j,\quad
|Q|=b(n-1)
\quad\text{and}\quad
P_j^\star(Q)<G_j.
\end{aligned}
}
]

### Implication to the sole target

For each (x\notin Q), choose a minimizer (y_x\in Q). Form a normalized construction with:

[
Q_0=Q,
]

[
S_x=Q\setminus{y_x},
]

[
Q_x=S_x\cup{x},
]

and parent (0) for every child. Order (Q) increasingly and introduce the other owners increasingly.

Every separator has size (b-1), is contained in the root, and has least parent (0). Every bag has size (b). Running intersection is immediate.

For a covered owner set (C=C_r):

* If (C\cap Q=\varnothing), its (|C|) active leaves are isolated, contributing (|C|-1).
* If (C\cap Q={y}), an outside owner (x\in C) creates a new component exactly when (y_x=y).
* If (|C\cap Q|\ge2), every active leaf separator retains a core owner from (C), so the penalty is (0).

Therefore

[
J_j(D)
======

\left|\bigcup_iB_i^j\right|
+
P_j^\star(Q).
]

If (P_j^\star(Q)<G_j), then

[
J_j(D)
<
\left|\bigcup_iB_i^j\right|+G_j
===============================

|R_j|.
]

Thus

[
\texttt{ROOT-STAR-BALANCED-DEFICIT}
\Longrightarrow
\texttt{BALANCED-JUNCTION-COVER-DEFICIT}.
]

This is not a full-bag repair, does not change (b(m)), and is not exact union noncoverage. It is a proper construction subclass whenever (m-b\ge2). The P85 speed-(13) values

[
\min_DJ=96,\qquad \min_{\text{root-star }D}J=98
]

show an actual modular distinction.

The response computation found the root-star successor at every mandatory fixture and all (811) frozen tuples. The first open edge is now the explicit arithmetic core-selection statement

[
\exists j,Q,\qquad P_j^\star(Q)<G_j.
]

That statement remains **open**.

---

## 11. **Complete implication chain**

Assume `ROOT-STAR-BALANCED-DEFICIT`.

1. Select (j,Q) with
   [
   P_j^\star(Q)<G_j.
   ]
   Status: **open premise**.

2. Choose minimizing drop labels and form the normalized root-star construction. Then
   [
   J_j(D)
   ======

   \left|\bigcup_iB_i^j\right|+P_j^\star(Q)
   <
   |R_j|.
   ]
   Status: **response reasoning**.

3. Apply the generic junction bound:
   [
   \left|\bigcup_iB_i^j\right|
   \le J_j(D)<|R_j|.
   ]
   Status: **response reasoning**, consistent with the accepted `proved-math-qualified` Prompt85 generic scope.

4. Select
   [
   r\in R_j\setminus\bigcup_iB_i^j.
   ]
   Status: **response reasoning**.

5. Candidate exclusion makes the pivot safe, and strict bad-set avoidance makes every other coordinate safe:
   [
   \rho_{Np}(ra_i)\ge p.
   ]

6. At
   [
   t=\frac r{Np},
   ]
   every positive-integer speed has distance at least (1/N). This gives the exact positive-integer pivot certificate.

7. Apply the accepted positive-integer pivot-certificate equivalence.
   Status: **proved-lean**.

8. Apply the accepted positive-integer to real-speed equivalence, preserving positivity, injectivity, quantifiers, and the closed threshold.
   Status: **proved-lean**.

Hence

[
\texttt{ROOT-STAR-BALANCED-DEFICIT}
\Longrightarrow
\text{unrestricted real Lonely Runner}.
]

The chain is **conditional** because its first statement remains open.

---

## 12. **Proof-obligation ledger**

| Claim                                       | Dependency                                     | Status                 | Falsification performed                        | First open edge                   | Recommended owner             |
| ------------------------------------------- | ---------------------------------------------- | ---------------------- | ---------------------------------------------- | --------------------------------- | ----------------------------- |
| Existence and leastness of `ceilSqrt`       | Well-ordering of (\mathbb N)                   | response reasoning     | Exact controls (m=2,\ldots,10)                 | Lean encoding only                | Lean arithmetic audit         |
| (b(m)<m) for (m\ge4)                        | ((m-2)^2\ge m)                                 | response reasoning     | Boundary (m=4) checked                         | None mathematically               | Independent proof audit       |
| Rooted tree, coverage, running intersection | Introduction rules                             | response reasoning     | All enumerated constructions validated         | None mathematically               | Independent proof audit       |
| Exact construction count                    | New-face count                                 | response reasoning     | Counts through (m=7) reproduced                | Formal finite-cardinality proof   | Lean combinatorics            |
| Local junction bound                        | Tree leaf induction                            | response reasoning     | Component identity checked on every minimizer  | None mathematically               | Independent proof audit       |
| Component identity                          | Running intersection and forest Euler identity | response reasoning     | Direct per-residue verification                | None mathematically               | Independent proof audit       |
| Scaling and permutation laws                | Fiber projection and relabelling               | response reasoning     | Factor-(3) and permutation tests               | Formalization                     | Lean arithmetic audit         |
| Fixture and (D_{\mathrm{pre}}) minima       | Literal finite algorithms                      | unverified computation | Two evaluator architectures agree              | External independent reproduction | Separate verifier owner       |
| Uniform component expectation               | Uniform finite distribution                    | response reasoning     | Exhaustive checks through (m=7)                | None for the formula              | Independent probability audit |
| Uniform-average selection                   | Expected penalty (<G_j)                        | rejected               | Fails every P85 pivot                          | Cannot select (j,D)               | Closed                        |
| Exact singleton and CRT formulas            | Linear congruences                             | response reasoning     | P77/P78 nonunit controls                       | Cross-pivot sign inequality       | Arithmetic specialist         |
| Root-star score identity                    | Pointwise component cases                      | response reasoning     | Closed-form and literal-star enumeration agree | Universal core selection          | Sol Pro arithmetic selection  |
| `ROOT-STAR-BALANCED-DEFICIT`                | Core-selection inequality                      | open                   | Survives all frozen fixtures/domain            | Prove (\exists j,Q)               | Sol Pro                       |
| Sole balanced target                        | Arbitrary balanced construction selection      | open                   | No frozen failure                              | Prove target or refute tuple      | Sol Pro                       |
| LRC implication                             | Accepted equivalences plus target              | conditional            | Exact generic chain reconstructed              | Open target premise               | `/root` review                |

---

## 13. **Verifier and Lean plan**

### Frozen verifier architecture

The response-created verifier has four literal layers:

1. Direct construction enumeration with deterministic ordering and structural validation.
2. Exact bit-set evaluation of (R_j), every labelled (B_i^j), all bag unions, separators, (J_j(D)), and component identities.
3. An independent memoized face-state evaluator using `frozenset` residue unions.
4. A closed-form root-star evaluator cross-checked against literal enumeration of every star construction.

An external checker should be implemented without importing the response source. A suitable independent architecture is:

* sorted residue vectors rather than integer bit masks,
* recursive generation of bags rather than cached construction objects,
* arbitrary-precision signed integer accumulation,
* independent generation of (R_j) by looping over residue classes (s+Nk),
* comparison of full per-pivot minima and minimizer certificates against the CSV hashes.

### Proposed Lean declaration signatures

These should not be added to a repository until the mathematics and finite architecture receive independent approval.

```lean
def ceilSqrt (m : ℕ) : ℕ

theorem ceilSqrt_spec (m : ℕ) :
  m ≤ (ceilSqrt m)^2 ∧
  ∀ s : ℕ, m ≤ s^2 → ceilSqrt m ≤ s

def bagBound (m : ℕ) : ℕ :=
  min m (1 + ceilSqrt m)

theorem bagBound_lt {m : ℕ} (hm : 4 ≤ m) :
  bagBound m < m
```

```lean
structure NormalizedBalancedConstruction
    (Owner : Type) [Fintype Owner] [LinearOrder Owner] where
  sigma       : Fin (Fintype.card Owner) ≃ Owner
  bags        : Finset (Finset Owner)
  separators  : ...
  parent      : ...
  root_normalized      : ...
  introduction_rules   : ...
  least_parent_rule    : ...
```

```lean
theorem balanced_parent_tree ...
theorem balanced_bag_cover ...
theorem balanced_running_intersection ...
theorem balanced_separator_eq_intersection ...
```

```lean
theorem normalizedBalanced_card (m : ℕ) :
  Fintype.card (NormalizedBalancedConstruction (Fin m)) =
    Nat.choose m (bagBound m) *
    Nat.factorial (m - bagBound m) *
    ∏ t in Finset.range (m - bagBound m),
      (bagBound m + t * (bagBound m - 1))
```

```lean
def junctionInt ...
def componentCount ...

theorem local_junction_bound ...
theorem junction_eq_sum_components ...
theorem junction_strict_iff_component_penalty_lt_gap ...
```

```lean
def rootStarPenalty ...
def RootStarBalancedDeficit : Prop
def BalancedJunctionCoverDeficit : Prop

theorem rootStar_junction_identity ...
theorem rootStar_implies_balanced :
  RootStarBalancedDeficit → BalancedJunctionCoverDeficit
```

No declaration asserting either unrestricted existential should receive a proof term from the finite scan.

---

## 14. **Final evidence boundary**

* **proved-lean**

  * Positive-integer pivot-certificate equivalence, as accepted in the prompt.
  * Positive-integer to real-speed equivalence, as accepted in the prompt.

* **proved-math-qualified**

  * Only the previously accepted Prompt85 generic scopes listed in the contract.
  * No new unrestricted existential is added.

* **response reasoning**

  * Existence and leastness properties of `ceilSqrt`.
  * The sublinear bag bound.
  * Tree, coverage, running-intersection, separator, and construction-count proofs.
  * Leaf-induction junction bound.
  * Component identity and strictness criterion.
  * Scaling and permutation laws.
  * Uniform component expectation formula.
  * Exact singleton and generalized-CRT counting formulas.
  * Root-star score identity and root-star implication to the sole target.

* **unverified computation**

  * Every reproduced fixture minimum.
  * Every P85 pivot minimum.
  * The complete (811)-tuple, (3914)-pivot (D_{\mathrm{pre}}) scan.
  * Root-star survival of all fixtures and the frozen domain.
  * All hashes and malformed controls.

* **conditional**

  * Balanced target (\Rightarrow) positive-integer LRC (\Rightarrow) real LRC.
  * Root-star successor (\Rightarrow) balanced target (\Rightarrow) LRC.

* **rejected**

  * The symmetric uniform balanced-construction component-energy route.
  * The same symmetric expectation over root-star constructions.
  * The altered abstract expectation (\min J=6).

* **open**

  * `ROOT-STAR-BALANCED-DEFICIT`.
  * `BALANCED-JUNCTION-COVER-DEFICIT`.
  * The required cross-pivot arithmetic core-selection inequality.
  * Unrestricted Lonely Runner.

**Final disposition: PIVOT.**
