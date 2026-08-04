## 1. Disposition

**STOP**

The frozen inequality is false.

For the primitive strictly increasing tuple

[
a=(1,4,5,6,7,11),\qquad n=6,\qquad N=7,
]

the covered pivots are

[
F(a)={1,4,5,11},
]

where pivots are identified by speed value. The exact good-count vector is

[
(G_1,G_4,G_5,G_6,G_7,G_{11})=(0,0,0,2,2,0).
]

The canonical owner-labelled private mass is

[
\operatorname{PrivateDemand}(a)=6+22+22+50=100,
]

while the exact external weighted capacity is

[
\operatorname{ExternalCapacity}(a)=98.
]

Therefore

[
100\le 98
]

is false. This is a tuple with (F(a)) nonempty and proper, so it is a route-stopping counterexample under the contract’s explicit STOP rule.

No `BRIDGE` or `PIVOT` survives. Unrestricted Lonely Runner remains `open`.

---

## 2. Status table

| Claim or dependency                                                                                          | Status                     | Exact scope                                                                                             |
| ------------------------------------------------------------------------------------------------------------ | -------------------------- | ------------------------------------------------------------------------------------------------------- |
| Strict modular boundary, candidate grid, owner-labelled bad sets, and scaling facts admitted from Response69 | `proved-math`              | Frozen audited scope only                                                                               |
| Response69 nearest-boundary transport                                                                        | `rejected`                 | Not revived or renamed here                                                                             |
| Response69 per-covered-row inequality (2a_j\le\sum_{k\ne j}w(j,k)G_k)                                        | `open`                     | The new counterexample satisfies all four relevant rows, so it does not refute that separate conjecture |
| Canonical covers and boundary-grid facts admitted from Response72                                            | `proved-math`              | Frozen audited scope only                                                                               |
| Response72 circuit escape                                                                                    | `open`                     | Audited as equivalent to LRC and not used here                                                          |
| Complete-cover family finite and nonempty for (j\in F(a))                                                    | `proved-math`              | Direct finite-set argument below                                                                        |
| Uniqueness of the canonical cover (C_j)                                                                      | `proved-math`              | Uses injectivity and the declared strict total order                                                    |
| Minimum cardinality implies inclusion-minimality                                                             | `proved-math`              | Direct deletion contradiction                                                                           |
| Every selected owner has a nonempty relative private set                                                     | `proved-math`              | Direct deletion contradiction                                                                           |
| Finite Fubini/reindexing identity for `ExternalCapacity`                                                     | `proved-math`              | Exact equality of finite natural-number sums                                                            |
| Explicit tuple ((1,4,5,6,7,11)) has demand (100) and capacity (98)                                           | `proved-math`              | Full residue, cover, and private-set certificate below; independently replayed                          |
| It is the first failure in the declared deterministic bounded ordering                                       | `computed finite evidence` | Primitive increasing tuples, (2\le n\le6), maximum speed at most (14), scales (1,2,3)                   |
| Frozen all-but-one symbolic family satisfies the inequality                                                  | `proved-math`              | Uniform proof for every permitted (n,m)                                                                 |
| `GLOBAL-CANONICAL-PRIVATE-DEFICIT-HALL`                                                                      | `rejected`                 | Refuted by the explicit tuple                                                                           |
| Attack A universal injection or Hall relation                                                                | `rejected`                 | Source cardinality (100), destination cardinality (98)                                                  |
| Attack B universal uncrossing or telescoping argument ending at `ExternalCapacity`                           | `rejected`                 | Such an argument would prove the false inequality on the counterexample                                 |
| Implication from the frozen inequality to a pivot certificate and LRC                                        | `conditional`              | Logically valid if the false inequality were assumed                                                    |
| Existing pivot-certificate implication directions specified in the contract                                  | `proved-lean`              | Frozen repository boundary; not recompiled in this turn                                                 |
| Any new Lean theorem from this turn                                                                          | `open`                     | None proposed or compiled                                                                               |
| Unrestricted real Lonely Runner Conjecture                                                                   | `open`                     | No status change                                                                                        |

---

## 3. Frozen definitions

For (n\ge2), let (N=n+1), and let (a:\operatorname{Fin}n\to\mathbb N) be positive and injective. At pivot (j),

[
p_j=a_j,\qquad M_j=Np_j,
]

and every residue is represented uniquely by an integer (0\le r<M_j). Define

[
\rho_{M_j}(x)=\min(x\bmod M_j,\ M_j-(x\bmod M_j)).
]

The finite candidate type is

[
R_j={r:0\le r<M_j,\ N\nmid r}.
]

For each owner (i\ne j),

[
B_i^j={r\in R_j:\rho_{M_j}(ra_i)<p_j}.
]

The strict inequality is essential. Equality (\rho_{M_j}(ra_i)=p_j) is safe.

The good set and good count are

[
Q_j=R_j\setminus\bigcup_{i\ne j}B_i^j,\qquad G_j=|Q_j|,
]

and

[
F(a)={j:G_j=0}.
]

Owner identities are retained even if two bad sets coincide.

### Canonical cover existence and uniqueness

Fix (j\in F(a)).

The owner ground set

[
O_j={i\in\operatorname{Fin}n:i\ne j}
]

has (n-1) elements, so its power set is finite. Hence the family of complete covers

[
\mathcal C_j=
\left{
C\subseteq O_j:
\bigcup_{i\in C}B_i^j=R_j
\right}
]

is finite.

Because (G_j=0), every (r\in R_j) belongs to at least one (B_i^j). Therefore (O_j\in\mathcal C_j), so (\mathcal C_j) is nonempty.

Map each owner subset (C) to

[
\kappa(C)=
\left(
|C|,
\text{increasing list of }{a_i:i\in C}
\right).
]

The first coordinate has the usual strict total order on natural numbers. Among equal-cardinality subsets, the second coordinate has the lexicographic strict total order on equal-length lists. Injectivity of (a) implies that distinct owner subsets have distinct increasing speed lists. Thus (\kappa) induces a strict total order on the finite family (\mathcal C_j), which therefore has a unique least element (C_j).

Since (C_j) has minimum cardinality, it is inclusion-minimal. If (i\in C_j) and (C_j\setminus{i}) remained complete, it would have smaller cardinality.

For (i\in C_j), define

[
\operatorname{Priv}(j,i)=
B_i^j\setminus
\bigcup_{\substack{h\in C_j\h\ne i}}B_h^j.
]

If this set were empty, then

[
B_i^j\subseteq
\bigcup_{\substack{h\in C_j\h\ne i}}B_h^j,
]

and deleting (i) would preserve completeness, contradicting inclusion-minimality. Hence every selected owner has a nonempty relative private set. This privacy is only relative to (C_j); an omitted owner may still cover those residues.

### Source and destination types

The exact source type is

[
\operatorname{Source}
=====================

\Sigma_{j\in F(a)}
\Sigma_{i\in C_j}
\operatorname{Priv}(j,i).
]

Therefore

[
|\operatorname{Source}|
=======================

\sum_{j\in F(a)}
\sum_{i\in C_j}
|\operatorname{Priv}(j,i)|
==========================

\operatorname{PrivateDemand}(a).
]

For (j\in F(a)) and (k\notin F(a)),

[
w(j,k)=\frac{a_k}{\gcd(a_j,a_k)}.
]

The exact destination type is

[
\operatorname{Dest}
===================

\Sigma_{j\in F(a)}
\Sigma_{k\notin F(a)}
\left(\operatorname{Fin}(w(j,k))\times Q_k\right).
]

Since all speeds are positive, (w(j,k)>0), and

[
|\operatorname{Dest}|
=====================

\sum_{j\in F(a)}
\sum_{k\notin F(a)}
w(j,k)G_k
=========

\operatorname{ExternalCapacity}(a).
]

### Finite Fubini identity

Let (E=F(a)\times F(a)^c). Swapping the two finite coordinates gives a bijection

[
E\longleftrightarrow F(a)^c\times F(a).
]

Therefore finite-sum reindexing and distributivity give

[
\begin{aligned}
\sum_{j\in F(a)}
\sum_{k\notin F(a)}
w(j,k)G_k
&=
\sum_{k\notin F(a)}
\sum_{j\in F(a)}
w(j,k)G_k\
&=
\sum_{k\notin F(a)}
G_k\sum_{j\in F(a)}w(j,k).
\end{aligned}
]

No pivot or owner multiplicity is removed.

### Pivot safety and strict endpoints

Write any (r\in R_j) uniquely as

[
r=qN+s,\qquad 1\le s\le N-1.
]

Then

[
rp_j\bmod Np_j=sp_j,
]

and therefore

[
\rho_{Np_j}(rp_j)
=================

p_j\min(s,N-s)
\ge p_j.
]

Thus the pivot coordinate is always safe, including equality.

At a reflection-fixed antipode (r=M_j/2), when it exists and is a candidate, there is one residue representative, not two. No nonunit is cancelled anywhere.

### Common scaling

For a common factor (c\ge1), replace every speed by (ca_i). Then the new pivot modulus is (cM_j), and

[
\rho_{cM_j}(c x)=c,\rho_{M_j}(x).
]

Because (M_j) is divisible by (N), every old candidate, bad incidence, good residue, and private residue has exactly (c) lifts separated by (M_j). Consequently:

[
G_j(ca)=cG_j(a),
]

the canonical owner index sets are unchanged,

[
\operatorname{PrivateDemand}(ca)
================================

c,\operatorname{PrivateDemand}(a),
]

and

[
w_{ca}(j,k)
===========

# \frac{ca_k}{\gcd(ca_j,ca_k)}

w_a(j,k).
]

Hence

[
\operatorname{ExternalCapacity}(ca)
===================================

c,\operatorname{ExternalCapacity}(a).
]

---

## 4. Anti-tautology audit

### Comparison with pivot equivalence

The pivot equivalence only distinguishes

[
F(a)=\operatorname{Fin}n
]

from the existence of at least one uncovered pivot.

The frozen inequality instead asserts a numerical bound for every tuple with (F(a)\ne\varnothing), including tuples with several uncovered pivots. The counterexample has

[
F(a)={1,4,5,11}
\subsetneq
{1,4,5,6,7,11},
]

and explicit good sets

[
Q_6={13,29},\qquad Q_7={15,34}.
]

It therefore already has pivot certificates, yet the inequality fails. Thus the inequality is neither an unfolding of pivot equivalence nor equivalent to “some (G_j>0).” It is a genuine, false strengthening.

### Comparison with Response69 compensation

At the counterexample, the four Response69-style row bounds all hold:

[
\begin{array}{c|c|c}
\text{covered pivot }a_j&
2a_j&
\displaystyle\sum_{k\ne j}w(j,k)G_k\
\hline
1&2&26\
4&8&20\
5&10&26\
11&22&26
\end{array}
]

Their aggregate source size is only

[
2+8+10+22=42.
]

The canonical private demands are instead

[
6,\ 22,\ 22,\ 50,
]

with total (100). Thus the new statement is not the per-row compensation conjecture in aggregate notation, and the latter does not supply the missing private mass.

### Comparison with Response72 circuit escape

Every canonical cover in the counterexample contains an owner outside (F(a)):

[
\begin{aligned}
C_1&={7},\
C_4&={1,5,6,7,11},\
C_5&={1,4,6,7,11},\
C_{11}&={1,4,5,6,7}.
\end{aligned}
]

Therefore no nonempty subset of (F(a)) is closed under these canonical covers. The direct circuit-escape obstruction is absent, but the quantitative inequality still fails. Circuit escape supplies an external edge, not enough destination capacity to absorb every private token.

The anti-tautology audit therefore passes in the relevant sense: the proposed inequality is genuinely stronger than pivot noncoverage. It is nevertheless false.

---

## 5. Exact falsification

### Deterministic bounded search

The exact search order was:

1. (n=2,3,4,5,6);
2. primitive strictly increasing tuples from `itertools.combinations(range(1,15), n)`;
3. lexicographic tuple order within each (n);
4. common scales (1,2,3) for each primitive base;
5. pivot, owner, subset, and residue orders all increasing;
6. canonical covers ordered by ((|C|,\text{increasing speed list})).

The ordered scan stopped at its first failure.

| Quantity                             |      Exact value |
| ------------------------------------ | ---------------: |
| Primitive bases before failure       |            4,162 |
| First failing primitive-base ordinal |            4,163 |
| Ordinal within (n=6)                 |              829 |
| Scaled tuple records through failure |           12,487 |
| First failing scale                  |                1 |
| First failing tuple                  | ((1,4,5,6,7,11)) |

Counts through the stopping point were:

| (n) | Primitive bases examined | Scaled records examined |
| --: | -----------------------: | ----------------------: |
|   2 |                       63 |                     189 |
|   3 |                      325 |                     975 |
|   4 |                      965 |                   2,895 |
|   5 |                    1,981 |                   5,943 |
|   6 |                      829 |                   2,485 |

The immediately preceding bases in the same lexicographic branch were

[
(1,4,5,6,7,8),\quad
(1,4,5,6,7,9),\quad
(1,4,5,6,7,10).
]

Bounded firstness is `computed finite evidence`. The counterexample itself is given as a complete exact certificate below.

### First failure: ((1,4,5,6,7,11))

Here (N=7). The pivot data are

[
Q_1=Q_4=Q_5=Q_{11}=\varnothing,
]

[
Q_6={13,29},\qquad
Q_7={15,34}.
]

Hence

[
F(a)={1,4,5,11},
\qquad
G=(0,0,0,2,2,0).
]

For compactness, write (\operatorname{Priv}_p(s)) for the private set at pivot speed (p) owned by speed (s).

#### Pivot (1)

[
C_1={7},
]

[
\operatorname{Priv}_1(7)=
{1,2,3,4,5,6}.
]

Row demand:

[
D_1=6.
]

#### Pivot (4)

[
C_4={1,5,6,7,11},
]

[
\begin{aligned}
\operatorname{Priv}_4(1)
&={1,2,3,25,26,27},\
\operatorname{Priv}_4(5)
&={6,11,17,22},\
\operatorname{Priv}_4(6)
&={9,19},\
\operatorname{Priv}_4(7)
&={4,8,12,16,20,24},\
\operatorname{Priv}_4(11)
&={10,13,15,18}.
\end{aligned}
]

Row demand:

[
D_4=6+4+2+6+4=22.
]

#### Pivot (5)

[
C_5={1,4,6,7,11},
]

[
\begin{aligned}
\operatorname{Priv}_5(1)
&={2,4,31,33},\
\operatorname{Priv}_5(4)
&={8,9,26,27},\
\operatorname{Priv}_5(6)
&={11,12,23,24},\
\operatorname{Priv}_5(7)
&={5,10,15,20,25,30},\
\operatorname{Priv}_5(11)
&={13,16,19,22}.
\end{aligned}
]

Row demand:

[
D_5=4+4+4+6+4=22.
]

#### Pivot (11)

[
C_{11}={1,4,5,6,7},
]

[
\begin{aligned}
\operatorname{Priv}*{11}(1)
&={3,4,5,6,8,9,68,69,71,72,73,74},\
\operatorname{Priv}*{11}(4)
&={18,19,20,36,41,57,58,59},\
\operatorname{Priv}*{11}(5)
&={15,16,29,30,31,46,47,48,61,62},\
\operatorname{Priv}*{11}(6)
&={13,24,25,26,27,50,51,52,53,64},\
\operatorname{Priv}_{11}(7)
&={11,22,23,33,34,43,44,54,55,66}.
\end{aligned}
]

Row demand:

[
D_{11}=12+8+10+10+10=50.
]

Therefore

[
\operatorname{PrivateDemand}(a)
===============================

# 6+22+22+50

100.

]

#### External capacity

Only pivots (6) and (7) are outside (F(a)), and both have good count (2).

| Source pivot (j) | (w(j,6)) | Contribution through (Q_6) | (w(j,7)) | Contribution through (Q_7) | Source-labelled capacity |
| ---------------: | -------: | -------------------------: | -------: | -------------------------: | -----------------------: |
|                1 |        6 |                         12 |        7 |                         14 |                       26 |
|                4 |        3 |                          6 |        7 |                         14 |                       20 |
|                5 |        6 |                         12 |        7 |                         14 |                       26 |
|               11 |        6 |                         12 |        7 |                         14 |                       26 |

Thus

[
\operatorname{ExternalCapacity}(a)
==================================

# 26+20+26+26

98.

]

Equivalently, after regrouping by destination,

[
\begin{aligned}
\operatorname{ExternalCapacity}(a)
&=
G_6(6+3+6+6)
+
G_7(7+7+7+7)\
&=
2\cdot21+2\cdot28\
&=98.
\end{aligned}
]

Hence

[
\boxed{
\operatorname{PrivateDemand}(a)=100

>

98=\operatorname{ExternalCapacity}(a)
}.
]

The nonunit (\gcd(4,6)=2) is retained, producing (w(4,6)=3). No cancellation of a nonunit occurred.

#### Common-scaled failures

The scaling identity gives two additional exact failures:

[
(2,8,10,12,14,22):
\qquad
200>196,
]

and

[
(3,12,15,18,21,33):
\qquad
300>294.
]

The good-count vectors are respectively

[
(0,0,0,4,4,0)
]

and

[
(0,0,0,6,6,0).
]

### Mandatory fixture 1: ((1,3,4))

[
F={1},\qquad G=(0,2,2),
]

[
Q_3={5,7},\qquad Q_4={7,9}.
]

The canonical cover is

[
C_1={4},
\qquad
\operatorname{Priv}_1(4)={1,2,3}.
]

Therefore

[
\operatorname{PrivateDemand}=3,
]

while

[
\operatorname{ExternalCapacity}
===============================

# 3\cdot2+4\cdot2

14.

]

The aggregate inequality holds.

For the centered equations of the sole private owner,

[
r\cdot4=q\cdot4+e,
]

the three private residues give

[
(r,q,e)=(1,1,0),(2,2,0),(3,3,0).
]

None of (q=1,2,3) belongs to either (Q_3) or (Q_4). Thus the raw quotient transport does not land in an external good residue. The full Response69 nearest-boundary target rule is not restated in the frozen Prompt76 text, so no stronger unnamed transport claim is inferred; its audited status remains `rejected`.

### Mandatory fixture 2: ((1,3,4,5))

[
F={1,3},\qquad G=(0,0,2,2),
]

[
Q_4={9,11},\qquad Q_5={11,14}.
]

At pivot (1),

[
C_1={5},
\qquad
\operatorname{Priv}_1(5)={1,2,3,4}.
]

At pivot (3),

[
C_3={1,4,5},
]

[
\begin{aligned}
\operatorname{Priv}_3(1)&={1,2,13,14},\
\operatorname{Priv}_3(4)&={4,7,8,11},\
\operatorname{Priv}_3(5)&={3,6,9,12}.
\end{aligned}
]

Thus

[
\operatorname{PrivateDemand}=4+12=16,
]

and

[
\operatorname{ExternalCapacity}
===============================

(4\cdot2+5\cdot2)
+
(4\cdot2+5\cdot2)
=================

36.

]

Two exact centered-equation failures occur:

1. At pivot (3), owner (1), private residue (r=1),

   [
   1\cdot1=0\cdot15+1.
   ]

   The quotient (q=0) is excluded because (5\mid0).

2. At private residue (r=13),

   [
   13\cdot1=1\cdot15-2.
   ]

   The quotient (q=1) is a candidate at pivot (1), and owner (5) is bad there because

   [
   1\cdot5\equiv0\pmod5.
   ]

   But owner (5) is safe at the original source residue:

   [
   \rho_{15}(13\cdot5)=5\ge3.
   ]

   Target badness therefore does not transport back to the source modulus.

### Mandatory fixture 3: ((1,2,3,5))

[
F={1,2},\qquad G=(0,0,2,2),
]

[
Q_3={4,11},\qquad Q_5={6,19}.
]

At pivot (1),

[
C_1={5},
\qquad
\operatorname{Priv}_1(5)={1,2,3,4}.
]

At pivot (2),

[
C_2={1,3,5},
]

and the three private sets are

[
\operatorname{Priv}_2(1)={1,9},
]

[
\operatorname{Priv}_2(3)={3,7},
]

[
\operatorname{Priv}_2(5)={2,4,6,8}.
]

They are pairwise disjoint and exactly partition

[
R_2={1,2,3,4,6,7,8,9}.
]

Every selected owner is coprime to the pivot speed (2):

[
\gcd(1,2)=\gcd(3,2)=\gcd(5,2)=1.
]

Thus private points do not force a nontrivial owner-pivot gcd.

The two sides are

[
\operatorname{PrivateDemand}=4+8=12,
]

[
\operatorname{ExternalCapacity}
===============================

(3\cdot2+5\cdot2)
+
(3\cdot2+5\cdot2)
=================

32.

]

### Mandatory fixture 4: ((1,6,11,12,13))

[
F={1,6},\qquad G=(0,0,8,8,10).
]

The external good sets are

[
Q_{11}={13,14,19,29,37,47,52,53},
]

[
Q_{12}={15,21,29,31,41,43,51,57},
]

[
Q_{13}={16,17,23,31,34,44,47,55,61,62}.
]

At pivot (1),

[
C_1={6},
\qquad
\operatorname{Priv}_1(6)={1,2,3,4,5}.
]

At pivot (6),

[
C_6={1,11,12,13},
]

[
\begin{aligned}
\operatorname{Priv}_6(1)
&={1,2,4,5,31,32,34,35},\
\operatorname{Priv}_6(11)
&={7,10,13,16,20,23,26,29},\
\operatorname{Priv}_6(12)
&={9,15,21,27},\
\operatorname{Priv}_6(13)
&={8,11,14,17,19,22,25,28}.
\end{aligned}
]

Thus

[
\operatorname{PrivateDemand}=5+28=33.
]

The external capacity is

[
\begin{aligned}
&11\cdot8+12\cdot8+13\cdot10\
&\quad+
11\cdot8+2\cdot8+13\cdot10\
&=548.
\end{aligned}
]

The least-owner selector gives

[
1\longmapsto6,\qquad6\longmapsto1,
]

forming a cycle. The canonical keys are

[
\kappa(C_1)=(1,[6]),
]

[
\kappa(C_6)=(4,[1,11,12,13]).
]

Following the least owner decreases from the second key to the first, then increases back. There is no strict cyclic key decrease and no uncrossing proof.

### Mandatory fixture 5: ((1,2,8))

[
F={1,2},\qquad G=(0,0,6),
]

[
Q_8={9,10,11,21,22,23}.
]

The canonical covers are

[
C_1=C_2={8}.
]

Their private sets are

[
\operatorname{Priv}_1(8)={1,2,3},
]

[
\operatorname{Priv}_2(8)={1,2,3,5,6,7}.
]

Therefore

[
\operatorname{PrivateDemand}=3+6=9,
]

and the sole uncovered pivot has enough labelled capacity:

[
\operatorname{ExternalCapacity}
===============================

# 8\cdot6+4\cdot6

72.

]

Both covered pivots feed the same sole uncovered pivot. Any requirement for two distinct uncovered pivots is false.

### Mandatory fixture 6: ((1,2,3,4,5,7))

[
F={1,2,3,4},\qquad G=(0,0,0,0,2,2),
]

[
Q_5={6,29},\qquad Q_7={8,41}.
]

At pivot (1),

[
C_1={7},
\qquad
\operatorname{Priv}_1(7)={1,2,3,4,5,6}.
]

At pivot (2),

[
C_2={1,3,5,7},
]

[
\begin{aligned}
\operatorname{Priv}_2(1)&={1,13},\
\operatorname{Priv}_2(3)&={5,9},\
\operatorname{Priv}_2(5)&={3,11},\
\operatorname{Priv}_2(7)&={2,4,6,8,10,12}.
\end{aligned}
]

At pivot (3),

[
C_3={1,4,5,7},
]

[
\begin{aligned}
\operatorname{Priv}_3(1)&={1,2,19,20},\
\operatorname{Priv}_3(4)&={5,10,11,16},\
\operatorname{Priv}_3(5)&={4,8,13,17},\
\operatorname{Priv}_3(7)&={3,6,9,12,15,18}.
\end{aligned}
]

At pivot (4),

[
C_4={1,2,3,5,7},
]

[
\begin{aligned}
\operatorname{Priv}_4(1)&={2,3,25,26},\
\operatorname{Priv}_4(2)&={13,15},\
\operatorname{Priv}_4(3)&={9,10,18,19},\
\operatorname{Priv}_4(5)&={5,6,11,17,22,23},\
\operatorname{Priv}_4(7)&={4,8,12,16,20,24}.
\end{aligned}
]

The row demands are

[
6,\ 12,\ 18,\ 22,
]

so

[
\operatorname{PrivateDemand}=58.
]

Every covered pivot contributes

[
5\cdot2+7\cdot2=24
]

to external capacity. Hence

[
\operatorname{ExternalCapacity}=4\cdot24=96.
]

Also,

[
\sum_jG_j=4<6=n,
]

so both (\sum_jG_j\ge n) and any majority-uncovered-pivot assertion are false.

### Mandatory fixture 7: ((1,3,13))

[
F=\varnothing,\qquad G=(3,5,9).
]

At pivot speed (3),

[
B_1^3=B_{13}^3={1,2,10,11}.
]

The bad sets coincide extensionally, but they are attached to two distinct owner indices and remain two distinct incidences. Since (F=\varnothing), this tuple contributes no source tokens:

[
\operatorname{PrivateDemand}
============================

# \operatorname{ExternalCapacity}

0.

]

### Symbolic all-but-one family

Let

[
\ell=\operatorname{lcm}(1,\ldots,n-1),
]

[
L=mN\ell,\qquad m\ge1,
]

and take

[
a=(1,2,\ldots,n-1,L).
]

For each small pivot (p\in{1,\ldots,n-1}),

[
Np\mid L.
]

Therefore the owner (L) has

[
rL\equiv0\pmod{Np}
]

for every (r), so

[
B_L^p=R_p.
]

No small owner (s\ne p) is a singleton complete cover: the candidate (r=p) satisfies

[
\rho_{Np}(ps)
=============

p\min(s,N-s)
\ge p.
]

Thus the canonical cover is exactly

[
C_p={L},
]

and

[
\operatorname{Priv}_p(L)=R_p.
]

Since (|R_p|=np),

[
\operatorname{PrivateDemand}
============================

# \sum_{p=1}^{n-1}np

\frac{n^2(n-1)}2.
]

At the final pivot (L), put

[
T=\frac{L}{n-1}.
]

Because (n-1\mid\ell), (T) is an integer divisible by (N). Consider

[
A=
{L+t:1\le t\le T,\ N\nmid t}.
]

For every small owner (1\le s\le n-1),

[
s(L+t)\ge L,
]

and, using (st\le L) and (N-s\ge2),

[
NL-s(L+t)
=========

(N-s)L-st
\ge L.
]

Thus every (L+t\in A) is safe against every small owner and belongs to (Q_L). Moreover,

[
|A|
===

# T-\frac TN

\frac{mn\ell}{n-1}.
]

Hence

[
G_L\ge\frac{mn\ell}{n-1}.
]

The capacity includes at least the contribution from source pivot (1):

[
\operatorname{ExternalCapacity}
\ge G_Lw(1,L)
=============

G_LL.
]

Therefore

[
\operatorname{ExternalCapacity}
\ge
\frac{mn\ell}{n-1}\cdot mN\ell
==============================

\frac{m^2nN\ell^2}{n-1}.
]

Since (\ell\ge n-1), (m\ge1), and (N=n+1\ge n/2),

[
\frac{m^2nN\ell^2}{n-1}
\ge
nN(n-1)
\ge
\frac{n^2(n-1)}2.
]

Thus the frozen inequality holds on this entire symbolic family. This family does not rescue the universal statement because the unrelated tuple ((1,4,5,6,7,11)) refutes it.

### Boundary, antipode, nonunit, and (n=2) checks

The exact boundary convention was preserved:

[
\rho=p-1\quad\Rightarrow\quad\text{bad},
]

[
\rho=p\quad\Rightarrow\quad\text{safe}.
]

Both cyclic sides were included. Multiples of (N), including (0), were excluded. Reflection-fixed antipodes were counted once.

For the exact (n=2) fixture ((1,3)), (N=3),

[
F={1},\qquad G=(0,2),
]

[
C_1={3},
\qquad
\operatorname{Priv}_1(3)={1,2},
]

and

[
2\le 3\cdot2=6.
]

Nonunits were retained in the computations, including

[
\gcd(4,6)=2
]

in the counterexample and

[
\gcd(12,36)=12
]

in the ((1,6,11,12,13)) fixture.

---

## 6. Attack A

For the counterexample, the exact source cardinality is

[
|\operatorname{Source}|=100.
]

The destination slots decompose as follows:

[
\begin{aligned}
j=1 &: 6|Q_6|+7|Q_7|=12+14=26,\
j=4 &: 3|Q_6|+7|Q_7|=6+14=20,\
j=5 &: 6|Q_6|+7|Q_7|=12+14=26,\
j=11&: 6|Q_6|+7|Q_7|=12+14=26.
\end{aligned}
]

Therefore

[
|\operatorname{Dest}|=98.
]

No injection

[
\operatorname{Source}\longrightarrow\operatorname{Dest}
]

exists.

More generally, for any proposed Hall relation (\mathcal R\subseteq\operatorname{Source}\times\operatorname{Dest}), take the source subset

[
S=\operatorname{Source}.
]

Its neighbor set satisfies

[
|N_{\mathcal R}(S)|
\le|\operatorname{Dest}|
=98
<100
=|S|.
]

Thus the Hall inequality already fails on the full source set. The first unsupported arrow is exactly

[
\forall S\subseteq\operatorname{Source},
\quad
|S|\le|N_{\mathcal R}(S)|.
]

This failure occurs before candidate membership, collision control, reflection fixed points, CRT choices, or endpoint verification can matter. Any post-hoc selection of good residues cannot repair a two-slot cardinality deficit.

Attack A is `rejected`.

---

## 7. Attack B

Any complete modular uncrossing proof of the permitted kind would have to establish one of the following:

1. every private token is discharged into an exact external good-residue slot, without exceeding slot multiplicities; or
2. a strictly decreasing global potential telescopes to a terminal quantity bounded by `ExternalCapacity`.

Applied to the counterexample, either conclusion would imply

[
100
===

\operatorname{PrivateDemand}(a)
\le
\operatorname{ExternalCapacity}(a)
==================================

98,
]

which is false.

Therefore every proposed universal uncrossing must fail at least one of these exact obligations:

* some source tokens remain undischarged;
* multiple tokens consume the same destination slot beyond its declared multiplicity;
* a replacement fails to preserve coverage or strict endpoints;
* a purported potential decrease admits a cycle;
* or the terminal expression is not bounded by `ExternalCapacity`.

The first global unsupported arrow is the claimed terminal domination by `ExternalCapacity`. It is already numerically impossible.

The fixture ((1,6,11,12,13)) supplies an independent local warning: the least-owner selector cycles

[
1\to6\to1,
]

and the canonical key does not strictly decrease around that cycle. Generic set-cover submodularity does not remove this arithmetic obstruction.

Attack B is `rejected`.

---

## 8. Complete implication chain

The implication chain is logically valid only under the now-rejected frozen inequality.

### Case (n=1)

Let the sole positive speed be (p). Then (N=2), there are no nonpivot owners, and choose (r=1). Since (2\nmid1),

[
r\in R_0.
]

The pivot coordinate has

[
\rho_{2p}(p)=p,
]

which is safe at equality. Thus the (n=1) instance has a pivot certificate directly.

### Conditional argument for (n\ge2)

Assume hypothetically that the frozen inequality held for every positive injective tuple.

Suppose a tuple had no pivot certificate. By the exact cover equivalence,

[
F(a)=\operatorname{Fin}n.
]

For every pivot (j), (R_j) is nonempty because (1\in R_j). Therefore a complete cover (C_j) cannot be empty. Every selected owner has a nonempty private set, so each pivot contributes at least one private token:

[
\operatorname{PrivateDemand}(a)
\ge
\sum_{j\in\operatorname{Fin}n}1
===============================

n

>

0.

]

But there is no (k\notin F(a)), so

[
\operatorname{ExternalCapacity}(a)=0.
]

The hypothetical inequality would give a contradiction. Hence some (Q_j) would be nonempty.

Take (r\in Q_j). For every nonpivot owner (i\ne j),

[
r\notin B_i^j,
]

so

[
\rho_{Np_j}(ra_i)\ge p_j.
]

As proved in Section 3, the pivot coordinate also satisfies

[
\rho_{Np_j}(rp_j)\ge p_j.
]

Therefore (r) is a complete pivot certificate, corresponding to the rational time

[
t=\frac{r}{Np_j}.
]

The frozen repository directions specified by the contract are

[
\text{one pivot certificate}
\Longrightarrow
\texttt{PositiveIntegerPivotCertificateConjecture},
]

[
\texttt{PositiveIntegerPivotCertificateConjecture}
\Longrightarrow
\texttt{PositiveIntegerConjecture},
]

[
\texttt{PositiveIntegerConjecture}
\Longrightarrow
\texttt{Conjecture},
]

followed by the audited real/integer equivalence to unrestricted real Lonely Runner.

Those directions remain `proved-lean` at their frozen scopes. The argument above is only `conditional` because its first hypothesis, `GLOBAL-CANONICAL-PRIVATE-DEFICIT-HALL`, is `rejected`.

No unrestricted LRC proof follows.

---

## 9. Proof-obligation ledger

| Statement                                         | Status                     | Dependency                                      | Falsification or verification                         | First open edge                                      | Recommended next owner                             |
| ------------------------------------------------- | -------------------------- | ----------------------------------------------- | ----------------------------------------------------- | ---------------------------------------------------- | -------------------------------------------------- |
| Complete-cover family is finite                   | `proved-math`              | Finite owner set                                | Power set has at most (2^{n-1}) members               | None                                                 | Formalization owner only if integration is desired |
| Complete-cover family is nonempty for (j\in F(a)) | `proved-math`              | (Q_j=\varnothing)                               | Full nonpivot owner set covers (R_j)                  | None                                                 | Formalization owner                                |
| Canonical key is a strict total order             | `proved-math`              | Injectivity of speeds                           | Distinct subsets have distinct sorted speed lists     | None                                                 | Formalization owner                                |
| (C_j) is unique                                   | `proved-math`              | Previous row and finite nonempty family         | Unique finite minimum                                 | None                                                 | Formalization owner                                |
| (C_j) is inclusion-minimal                        | `proved-math`              | Minimum cardinality                             | Deletion would lower cardinality                      | None                                                 | Formalization owner                                |
| Every selected owner has nonempty `Priv`          | `proved-math`              | Inclusion-minimality                            | Empty private set permits deletion                    | None                                                 | Formalization owner                                |
| Fubini/reindexing identity                        | `proved-math`              | Finite product indexing                         | Coordinate-swap bijection and distributivity          | None                                                 | Formalization owner                                |
| Strict boundary and pivot safety                  | `proved-math`              | Centered cyclic distance                        | (r=qN+s), (1\le s<N)                                  | None                                                 | Existing modular formalization owner               |
| Common scaling identity                           | `proved-math`              | (M_j) divisible by (N)                          | Every old residue has (c) identical lifts             | None                                                 | Existing modular formalization owner               |
| Mandatory finite fixtures                         | `computed finite evidence` | Frozen definitions                              | Literal exact enumeration and assertions              | Independent repository audit if promotion is desired | `/root` audit owner                                |
| All-but-one symbolic family inequality            | `proved-math`              | Divisibility of (L), explicit good block        | Uniform algebraic proof in Section 5                  | None                                                 | `/root` audit owner                                |
| First bounded failure is ((1,4,5,6,7,11))         | `computed finite evidence` | Declared deterministic ordering                 | 12,487 ordered scaled records through failure         | Independent audit of bounded firstness               | `/root` audit owner                                |
| Exact tuple has demand (100) and capacity (98)    | `proved-math`              | Explicit covers, private sets, (Q), and weights | Two structurally separate exact implementations agree | Repository promotion only                            | `/root` audit owner                                |
| `GLOBAL-CANONICAL-PRIVATE-DEFICIT-HALL`           | `rejected`                 | Previous row                                    | (100>98)                                              | None; statement is false                             | Specification owner should close the cell          |
| Attack A injection                                | `rejected`                 | Source and destination cardinalities            | (100>98)                                              | None; injection impossible                           | No proof owner                                     |
| Attack A Hall relation                            | `rejected`                 | Full-source Hall subset                         | Neighbor set has at most 98 slots                     | None; Hall fails globally                            | No proof owner                                     |
| Attack B terminal-capacity uncrossing             | `rejected`                 | Exact counterexample                            | Would imply (100\le98)                                | None; target conclusion false                        | No proof owner                                     |
| Hypothetical implication to pivot coverage        | `conditional`              | Frozen inequality                               | Correct contradiction when (F=\operatorname{Fin}n)    | False premise                                        | No promotion                                       |
| Existing pivot-to-integer-to-real directions      | `proved-lean`              | Frozen repository theorems                      | Accepted only at supplied scope                       | No new replay in this turn                           | `/root` status owner                               |
| Unrestricted real LRC                             | `open`                     | Independent of rejected strengthening           | Counterexample already has good pivots                | Unrestricted certificate existence                   | Separate authorized research cell only             |

---

## 10. Artifacts and final evidence boundary

The authoritative exact search used CPython 3.13.5 on Linux 6.12.13 with standard-library-only arbitrary-precision integer arithmetic. No compiler was applicable. Both programs use deterministic ordering. Missing required command-line arguments produce `argparse` exit status 2.

| Artifact                                 | SHA-256                                                            |
| ---------------------------------------- | ------------------------------------------------------------------ |
| `p76_global_private_deficit_scan.py`     | `844355ab056343f67f45ae3caa6094366e4aba8bc214b04d544299e7d68c499a` |
| `p76_global_private_deficit_scan.json`   | `535bce9372e69a0478c4bc0870dde4938c8732fae8f4f0b6017692692c4f5fdc` |
| `p76_global_private_deficit_replay.py`   | `cddfd82eb4e67c82842b91c4539ab56bb35256d5944345be132b1ec34a3e58da` |
| `p76_global_private_deficit_replay.json` | `94fe0cacd26a7db6dfb4b20363cf157e9c312f31f9bb2c40b0947b633ebee66e` |
| `p76_SHA256SUMS.txt`                     | `fa7bfdfc8feae4d1d4e0b5fc61d8984a8791a3ca6208a15825b8ff9851b215aa` |

Artifacts:

* [Deterministic exact scanner](sandbox:/mnt/data/p76_global_private_deficit_scan.py)
* [Machine-readable full scan, fixtures, bad sets, private sets, and first-failure record](sandbox:/mnt/data/p76_global_private_deficit_scan.json)
* [Structurally separate bit-mask replay](sandbox:/mnt/data/p76_global_private_deficit_replay.py)
* [Independent replay certificate](sandbox:/mnt/data/p76_global_private_deficit_replay.json)
* [SHA-256 manifest](sandbox:/mnt/data/p76_SHA256SUMS.txt)

The scanner imported and executed no recovered attachment. The replay imports none of the scanner implementation and independently reconstructs every candidate set, owner bad mask, canonical cover, private set, good count, weight, and side of the counterexample.

The bounded assertion that this is the first failure in the declared ordering remains `computed finite evidence` pending independent project audit. The displayed finite counterexample is a self-contained `proved-math` refutation of the frozen universal inequality. No repository file was edited, no new Lean declaration was proposed, and no unrestricted Lonely Runner status was promoted.
