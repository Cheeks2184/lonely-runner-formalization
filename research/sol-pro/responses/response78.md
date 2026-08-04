## 1. Disposition: `STOP`

`SPARSE-MINIMAL-COVER-OWNER-ESCAPE` is **rejected**.

A primitive unrestricted counterexample is

[
n=5,\qquad N=6,\qquad a=(6,7,12,24,144).
]

Select the pivot (j) with (a_j=7), and select the owner-labelled set

[
C={6,12,24}.
]

Then:

[
|C|=3=\left\lfloor\frac52\right\rfloor+1=\operatorname{SparseBound}(5),
]

(C) is inclusion-minimal complete at pivot (7), but

[
Q_6=Q_{12}=Q_{24}=\varnothing.
]

Indeed, speed (144) is a singleton complete owner at each selected owner pivot because

[
6\cdot6=36\mid144,\qquad
6\cdot12=72\mid144,\qquad
6\cdot24=144\mid144.
]

Thus for every candidate (s\in R_i), where (i\in{6,12,24}),

[
\rho_{6a_i}(144s)=0<a_i.
]

No explicit (s\in Q_i) exists for any (i\in C). The counterexample also uses the canonical cover at pivot (7), so a canonical-cover weakening is false as well.

---

## 2. Status table

| Claim                                                                                 | Status                     | Exact dependency                                                                               |
| ------------------------------------------------------------------------------------- | -------------------------- | ---------------------------------------------------------------------------------------------- |
| Inclusion-minimality is equivalent to every owner-labelled private set being nonempty | `proved-math`              | Direct finite-set deletion equivalence                                                         |
| Canonical covers exist, are unique, and are inclusion-minimal for covered pivots      | `proved-math`              | Finiteness of the owner powerset, injectivity of speeds, and minimum cardinality               |
| Exact singleton cardinality formula                                                   | `proved-math`              | Kernel/image counting for multiplication modulo (Np), followed by subtraction of (N)-multiples |
| Permutation invariance                                                                | `proved-math`              | Relabelling of indices                                                                         |
| Common-scaling lift, including private-set cardinalities                              | `proved-math`              | The (c)-fiber map (r'\mapsto r'\bmod Np)                                                       |
| Mandatory fixture records                                                             | `computed finite evidence` | Fresh C++20 verifier, source SHA-256 `45c664…933f4`, output SHA-256 `e006ea…f7df`              |
| Prescribed primitive sorted search through maximum speed (24)                         | `computed finite evidence` | 532,412 tuples and 4,946 applicable covers, no bounded failure                                 |
| Explicit tuple ((6,7,12,24,144)) is a counterexample                                  | `proved-math`              | Direct residue-class classification modulo (7) and exact singleton divisibility                |
| `SPARSE-MINIMAL-COVER-OWNER-ESCAPE`                                                   | `rejected`                 | Explicit counterexample above                                                                  |
| The stated dense-canonical-core derivation, assuming the frozen theorem               | `conditional`              | Rejected sparse theorem plus the accepted Response70 singleton argument                        |
| `DENSE-CANONICAL-CORE` as an unconditional theorem                                    | `open`                     | The counterexample is not a simultaneous-full-cover tuple                                      |
| All-but-one family behavior for every (n\ge2) and (m\ge1)                             | `proved-math`              | Explicit singleton divisibility and witness (r=P+1)                                            |
| Existing downstream Lean implication chain                                            | `proved-lean`              | Frozen repository input only; this contract does not reach it                                  |

---

## 3. Frozen target

For (n\ge3), put (N=n+1). For a positive injective tuple (a), pivot (j), and (p_j=a_j),

[
M_j=Na_j,
\qquad
R_j={0\le r<M_j:N\nmid r}.
]

For (i\ne j),

[
B_i^j
=====

{r\in R_j:\rho_{M_j}(ra_i)<a_j},
]

with

[
\rho_M(x)=\min(x\bmod M,M-(x\bmod M)).
]

The inequality is strictly (<a_j). Equality (\rho_{M_j}(ra_i)=a_j) is safe. Both cyclic sides, all nonunits, gcd fibers, repeated owner sets, and reflection-fixed candidates remain present.

The good set and covered-pivot set are

[
Q_j=R_j\setminus\bigcup_{i\ne j}B_i^j,
\qquad
G_j=|Q_j|,
\qquad
F(a)={j:G_j=0}.
]

An owner-labelled (C\subseteq{i:i\ne j}) is complete when

[
\bigcup_{i\in C}B_i^j=R_j.
]

For (i\in C),

[
\operatorname{Priv}(j,C,i)
==========================

B_i^j\setminus\bigcup_{\substack{h\in C\h\ne i}}B_h^j.
]

The following are equivalent:

[
C\text{ is inclusion-minimal complete}
]

and

[
\operatorname{Priv}(j,C,i)\ne\varnothing
\quad\text{for every }i\in C.
]

An omitted owner may still cover every element of an owner-labelled private set. That permitted behavior is exactly what the counterexample exploits.

The sparse bound is

[
\operatorname{SparseBound}(n)=n/2+1
===================================

\left\lfloor\frac n2\right\rfloor+1.
]

The rejected conclusion was that every inclusion-minimal complete (C) satisfying

[
2\le |C|\le\operatorname{SparseBound}(n)
]

contains some (i\in C) and some (s) such that

[
s\in R_i
]

and

[
\rho_{Na_i}(sa_h)\ge a_i
\quad\text{for every }h\ne i.
]

### Canonical cover facts

For (j\in F(a)), the complete-cover family is nonempty because the full owner set is complete. It is finite because it is a subfamily of a finite powerset.

The key

[
\left(|C|,\text{ increasing list of }{a_i:i\in C}\right)
]

is a total order on complete owner-labelled subsets. Injectivity implies that two distinct subsets cannot have the same speed list. Therefore the least cover (C_j) is unique.

If an owner could be removed from (C_j) while preserving completeness, the resulting cover would have smaller cardinality. Hence (C_j) is inclusion-minimal.

### Common-scaling lift

Let (a'_i=ca_i), with (c\ge1). For a pivot (j),

[
M'_j=cM_j.
]

Every residue (r\pmod {M_j}) has exactly the (c) lifts

[
r+kM_j,\qquad 0\le k<c.
]

Since (N\mid M_j),

[
N\nmid(r+kM_j)\iff N\nmid r.
]

Also,

[
(r+kM_j)ca_i\equiv cra_i\pmod{cM_j}
]

and

[
\rho_{cM_j}(cra_i)=c,\rho_{M_j}(ra_i).
]

Consequently,

[
\rho_{cM_j}((r+kM_j)ca_i)<ca_j
\iff
\rho_{M_j}(ra_i)<a_j.
]

Thus candidate membership, owner-labelled badness, goodness, completeness, and inclusion-minimality are preserved fiberwise. In particular,

[
G'_j=cG_j
]

and

[
|\operatorname{Priv}'(j,C,i)|
=============================

c,|\operatorname{Priv}(j,C,i)|.
]

This proves the primitive common-scaling reduction but does not rescue the rejected theorem.

---

## 4. Anti-tautology audit

The rejected target did not assume that a sparse cover exists. It quantified over sparse inclusion-minimal covers only when one was supplied.

The counterexample is not obtained from LRC, one-pivot certificate existence, circuit escape, a Hall-capacity inequality, Fourier energy, prime forcing, bounded height, or a post hoc enumeration of good residues. It directly satisfies the frozen antecedent and falsifies the frozen conclusion.

It also preserves all sensitive features:

* Badness remains strict.
* (N)-multiples remain excluded.
* Owner labels are not deduplicated.
* The coincident sets (B_{24}^7=B_{144}^7) remain separately labelled.
* No nonunit is cancelled.
* Tuple primitivity is ordinary tuple gcd (1), not pairwise coprimality.
* The cover is inclusion-minimal even though an omitted owner covers one selected owner’s entire private set.
* The cover is canonical, so restricting the theorem to canonical covers would not help.

The tuple has

[
(G_6,G_7,G_{12},G_{24},G_{144})=(0,0,0,0,160).
]

It is therefore not a simultaneous-full-cover tuple. It does not refute `DENSE-CANONICAL-CORE` as a separate statement; it refutes the proposed route to that statement.

---

## 5. Exact fixtures

Write (P_b=\operatorname{Priv}(p,C,b)), where (p) is the displayed pivot speed. The full (R_j), every owner-labelled (B_i^j), every (Q_j), all complete minimal covers, and all canonical covers are serialized in the exact output artifact.

### 5.1 ((1,2,8))

[
G=(0,0,6),\qquad C_1=C_2={8}.
]

Both covers are singletons and are outside the antecedent. The covered set is (F={1,2}), while both canonical relations point to speed (8\notin F). Thus no nonempty subset of (F) is relation-closed.

### 5.2 ((1,3,4))

[
G=(0,2,2),\qquad C_1={4}.
]

The only covered pivot has a singleton cover.

Strict equality is retained. At pivot speed (3), modulus (12), residue (r=3) satisfies

[
\rho_{12}(3\cdot1)=3,
]

so (r\notin B_1^3). Equality is safe.

### 5.3 ((1,3,4,5))

[
G=(0,0,2,2),\qquad C_1={5},\qquad C_3={1,4,5}.
]

At pivot (3), the applicable cover has:

[
\begin{aligned}
P_1&={1,2,13,14}, & Q_1&=\varnothing,\
P_4&={4,7,8,11}, & Q_4&={9,11},\
P_5&={3,6,9,12}, & Q_5&={11,14}.
\end{aligned}
]

The conclusion selects owner (4) or (5), never owner (1).

### 5.4 ((1,2,3,5))

[
G=(0,0,2,2),\qquad C_1={5},\qquad C_2={1,3,5}.
]

At pivot (2),

[
\begin{aligned}
P_1&={1,9}, & Q_1&=\varnothing,\
P_3&={3,7}, & Q_3&={4,11},\
P_5&={2,4,6,8}, & Q_5&={6,19}.
\end{aligned}
]

All three owner labels are retained.

### 5.5 ((4,5,8))

[
G=(4,0,8),\qquad C_5={4,8}.
]

The binary cover is nonvacuous:

[
\begin{aligned}
P_4&={1,6,9,11,14,19},&
Q_4&={1,5,11,15},\
P_8&={2,3,7,13,17,18},&
Q_8&={2,3,10,11,21,22,29,30}.
\end{aligned}
]

### 5.6 ((4,5,32))

[
G=(0,0,24),\qquad C_4={32},\qquad C_5={4,32}.
]

At the applicable binary cover:

[
\begin{aligned}
P_4&={1,6,9,11,14,19},&
Q_4&=\varnothing,\
P_{32}&={2,3,7,13,17,18},&
Q_{32}&={9,10,11,13,14,15,17,18,19,41,42,43,\
&&&\qquad 85,86,87,109,110,111,113,114,115,117,118,119}.
\end{aligned}
]

This refutes the strengthening that every selected owner must be uncovered.

### 5.7 ((1,3,4,9,12))

[
G=(0,2,0,6,8),\qquad C_1={12},\qquad C_4={3,9,12}.
]

At pivot (4),

[
\begin{aligned}
P_3&={1,7,9,15,17,23},&
Q_3&={7,11},\
P_9&={3,5,11,13,19,21},&
Q_9&={10,11,21,33,43,44},\
P_{12}&={2,4,10,14,20,22},&
Q_{12}&={13,14,28,29,43,44,58,59}.
\end{aligned}
]

### 5.8 ((1,6,11,12,13))

[
G=(0,0,8,8,10).
]

At pivot (1), both ({6}) and ({12}) are inclusion-minimal singleton covers, with canonical cover

[
C_1={6}.
]

At pivot (6),

[
C_6={1,11,12,13},
]

whose size (4) is above (\operatorname{SparseBound}(5)=3). Its exact record is

[
\begin{aligned}
P_1&={1,2,4,5,31,32,34,35},&
Q_1&=\varnothing,\
P_{11}&={7,10,13,16,20,23,26,29},&
Q_{11}&={13,14,19,29,37,47,52,53},\
P_{12}&={9,15,21,27},&
Q_{12}&={15,21,29,31,41,43,51,57},\
P_{13}&={8,11,14,17,19,22,25,28},&
Q_{13}&={16,17,23,31,34,44,47,55,61,62}.
\end{aligned}
]

### 5.9 ((1,2,3,4,5,7))

[
G=(0,0,0,0,2,2).
]

All canonical covers are

[
\begin{aligned}
C_1&={7},\
C_2&={1,3,5,7},\
C_3&={1,4,5,7},\
C_4&={1,2,3,5,7}.
\end{aligned}
]

The covers at pivots (2) and (3) have size (4=\operatorname{SparseBound}(6)).

At pivot (2):

[
\begin{aligned}
P_1&={1,13}, & Q_1&=\varnothing,\
P_3&={5,9}, & Q_3&=\varnothing,\
P_5&={3,11}, & Q_5&={6,29},\
P_7&={2,4,6,8,10,12}, & Q_7&={8,41}.
\end{aligned}
]

At pivot (3):

[
\begin{aligned}
P_1&={1,2,19,20}, & Q_1&=\varnothing,\
P_4&={5,10,11,16}, & Q_4&=\varnothing,\
P_5&={4,8,13,17}, & Q_5&={6,29},\
P_7&={3,6,9,12,15,18}, & Q_7&={8,41}.
\end{aligned}
]

The size-five cover at pivot (4) is above the threshold. Its private sets are

[
\begin{aligned}
P_1&={2,3,25,26},\
P_2&={13,15},\
P_3&={9,10,18,19},\
P_5&={5,6,11,17,22,23},\
P_7&={4,8,12,16,20,24}.
\end{aligned}
]

### 5.10 ((1,3,13))

[
G=(3,5,9).
]

No pivot is covered. Coincident owner sets are retained with separate labels:

[
B_3^1=B_{13}^1=\varnothing,
]

and

[
B_1^3=B_{13}^3={1,2,10,11}.
]

### 5.11 All-but-one family

Let

[
P=mN\operatorname{lcm}(1,\ldots,n-1)
]

and consider

[
(1,2,\ldots,n-1,P).
]

For every small pivot (k\le n-1),

[
Nk\mid P,
]

so

[
B_P^k=R_k.
]

Thus every covered small pivot has a singleton cover and lies outside the sparse theorem’s lower bound.

At the large pivot (P), choose

[
r=P+1.
]

Since (N\mid P),

[
N\nmid r.
]

For (1\le k\le N-2),

[
rk=kP+k,
]

and the two cyclic distances are

[
kP+k\ge P
]

and

[
NP-(kP+k)=(N-k)P-k\ge2P-(N-2)\ge P.
]

Therefore (r\in Q_P). This proves the family statement for every (n\ge2) and every (m\ge1), including (m=1,2,3).

### 5.12 Boundary, permutation, and scaling checks

The exact regression suite passed:

* 1,038 fixture permutations.
* 3,114 permutation-and-scaling cases for (c=1,2,3).
* 6,812 strict membership checks.
* 405 excluded (N)-multiple checks.
* 265 realized (\rho=p-1) cases, all bad.
* 192 realized (\rho=p) cases, all safe.
* 6,812 reflection checks.
* 15 candidate antipode fixed points.
* 144 exact gcd-fiber cases.
* 15 coincident owner-set pairs.

These are `computed finite evidence`; the general permutation and scaling statements have the direct proofs given above.

---

## 6. Deterministic falsification

A fresh verifier was written in C++20 and compiled with:

```text
g++ -O3 -std=c++20 -Wall -Wextra -pedantic \
  -DSOURCE_SHA256=\"45c664918d25ec5213836c9eca420df7616483f3c67fd4b67d8e014bb8f933f4\" \
  p78_sparse_minimal_cover_verifier.cpp \
  -o p78_sparse_minimal_cover_verifier
```

It was executed with:

```text
./p78_sparse_minimal_cover_verifier \
  > p78_sparse_minimal_cover_verifier_output.json
```

Compiler:

```text
g++ (Debian 14.2.0-19) 14.2.0
```

The verifier accepts no command-line input. Any argument produces the exact error

```text
malformed input: this deterministic verifier accepts no command-line arguments
```

and exit code `64`.

Sets are serialized as strictly increasing JSON integer arrays. Every owner has both an index and a speed label. Arithmetic is integer-only. The bounded search order is:

1. (n) ascending;
2. strictly increasing tuple lexicographically;
3. pivot index ascending;
4. owner-subset bit mask ascending.

The search stops at the first failing owner subset. The machine-readable field was

```json
"first_failure": null
```

because the entire required bounded domain was exhausted.

|       (n) | All increasing tuples | Primitive tuples | Covered pivots | Applicable minimal covers | Cover sizes |
| --------: | --------------------: | ---------------: | -------------: | ------------------------: | ----------- |
|         3 |                 2,024 |            1,747 |            231 |                         6 | (2:6)       |
|         4 |                10,626 |           10,061 |          1,697 |                       133 | (3:133)     |
|         5 |                42,504 |           41,656 |         11,087 |                       152 | (3:152)     |
|         6 |               134,596 |          133,644 |         35,500 |                     2,624 | (4:2624)    |
|         7 |               346,104 |          345,304 |        121,944 |                     2,031 | (4:2031)    |
| **Total** |           **535,854** |      **532,412** |    **170,459** |                 **4,946** |             |

Thus the prescribed height-(24) domain gives zero failures, but only as `computed finite evidence`.

The same fresh output contains a separate machine-readable unrestricted counterexample field for

```json
[6, 7, 12, 24, 144]
```

with the exact (R_j), every (B_i^j), every (Q_j), all canonical and minimal covers, private sets, and singleton divisibility certificates.

Hashes:

```text
source:
45c664918d25ec5213836c9eca420df7616483f3c67fd4b67d8e014bb8f933f4

output:
e006eab7a6cff892127d6019bc4c1b3da80e418f480df4cc53b91b8b8194f7df

binary:
b32ab0c511a9ebbd6d5416fc17e351710197d5d6e2c377ee3ce52370b3c4d8f7

manifest:
ddb73c8c2e283a6a015125bdb06d797ca5048f3867929690ee0e9cd97abd1898
```

---

## 7. Attack A

### Exact singleton cardinality

Let

[
p=a_j,\qquad b=a_i,\qquad M=Np,
]

and put

[
g=\gcd(b,Np),\qquad d=\gcd(b,p),\qquad
L=\left\lfloor\frac{p-1}{N}\right\rfloor.
]

Multiplication by (b) on (\mathbb Z/M\mathbb Z) has kernel size (g) and image the subgroup of multiples of (g).

The strict centered arc is represented by

[
-(p-1),\ldots,p-1.
]

It contains exactly

[
2\left\lfloor\frac{p-1}{g}\right\rfloor+1
]

multiples of (g). Therefore the number of all residues (r\pmod M), before excluding (N)-multiples, that satisfy strict badness is

[
g\left(
2\left\lfloor\frac{p-1}{g}\right\rfloor+1
\right).
]

Now write an excluded residue as (r=Nt), with (t\pmod p). Then

[
\rho_{Np}(Ntb)=N\rho_p(tb).
]

The strict inequality becomes

[
N\rho_p(tb)<p
\iff
\rho_p(tb)\le
\left\lfloor\frac{p-1}{N}\right\rfloor=L.
]

Multiplication by (b) modulo (p) has kernel size (d), so the number of excluded bad (N)-multiples is

[
d\left(
2\left\lfloor\frac{L}{d}\right\rfloor+1
\right).
]

Hence

[
\boxed{
|B_i^j|
=======

g\left(
2\left\lfloor\frac{p-1}{g}\right\rfloor+1
\right)
-------

d\left(
2\left\lfloor\frac{L}{d}\right\rfloor+1
\right).
}
]

No overlap information follows from this marginal count.

### Fatal counterexample classification

For the counterexample pivot (p=7),

[
M=42,\qquad R_7={0\le r<42:6\nmid r}.
]

For an owner speed (b=6u),

[
\rho_{42}(rb)=\rho_{42}(6ur)=6\rho_7(ur).
]

Thus

[
r\in B_{6u}^7
\iff
\rho_7(ur)\le1
\iff
ur\bmod7\in{0,\pm1}.
]

For the three owners:

[
u=1,2,4.
]

Their permitted residue classes modulo (7) are

[
\begin{aligned}
B_6^7 &: r\bmod7\in{0,1,6},\
B_{12}^7 &: r\bmod7\in{0,3,4},\
B_{24}^7 &: r\bmod7\in{0,2,5}.
\end{aligned}
]

Let

[
T={7,14,21,28,35}.
]

These are precisely the candidate residues with (r\equiv0\pmod7). The three exact private sets are

[
\begin{aligned}
P_6&={1,8,13,15,20,22,27,29,34,41},\
P_{12}&={3,4,10,11,17,25,31,32,38,39},\
P_{24}&={2,5,9,16,19,23,26,33,37,40}.
\end{aligned}
]

Moreover,

[
B_6^7=T\sqcup P_6,
\qquad
B_{12}^7=T\sqcup P_{12},
\qquad
B_{24}^7=T\sqcup P_{24},
]

and

[
R_7=T\sqcup P_6\sqcup P_{12}\sqcup P_{24}.
]

Therefore ({6,12,24}) is complete. Each private set has ten elements, so it is inclusion-minimal.

Speed (144) satisfies

[
B_{144}^7=B_{24}^7,
]

but remains a distinct omitted owner label.

At the selected owner pivots,

[
B_{144}^6=R_6,\qquad
B_{144}^{12}=R_{12},\qquad
B_{144}^{24}=R_{24}.
]

Consequently,

[
Q_6=Q_{12}=Q_{24}=\varnothing.
]

The first fatal arrow for Attack A is therefore exact:

> Local sparse-cover classification and nonempty owner-labelled private sets do not control an omitted owner that singleton-covers every selected owner pivot.

No deterministic rule can construct the required (s\in Q_i) at every displayed quantifier because those sets are empty on this instance.

---

## 8. Attack B

For the same tuple, the exact canonical second-level covers are

[
C_6={144},\qquad
C_{12}={144},\qquad
C_{24}={144}.
]

Thus every second-level incidence from the selected owners terminates at the same omitted label (144).

At the original pivot (7),

[
B_{144}^7=B_{24}^7.
]

Replacing owner (24) by owner (144) produces

[
{6,12,144},
]

which is another inclusion-minimal complete three-owner cover. It is not a proper subset of the original (C), and its canonical key is larger because (144>24).

Replacing owner (6) or (12) by (144) does not preserve completeness, since (B_{144}^7) duplicates the (24)-owner class and leaves one nonzero residue-class pair uncovered.

Therefore both required exchange outcomes fail:

1. No explicit (s\in Q_i) exists for (i\in{6,12,24}).
2. No proper subset of ({6,12,24}) covers (R_7).

The first fatal arrow for Attack B is the unsupported claim that second-level canonical covers must either expose a good owner residue or reduce the original owner set. A coincident omitted owner can instead produce an equal-cardinality replacement with no decrease and no good residue.

---

## 9. Cross-pivot consequence

The proposed implication is logically valid only under the rejected sparse theorem.

Assume a tuple has no pivot certificate. Then the exact cover equivalence gives

[
F(a)=\operatorname{Fin}n.
]

The accepted Response70 singleton-rigidity and strict-growth argument supplies a pivot (j) whose canonical cover is not a singleton, so

[
|C_j|\ge2.
]

Canonical minimality gives nonempty owner-labelled private sets.

If the rejected sparse theorem were available and

[
|C_j|\le\operatorname{SparseBound}(n),
]

it would provide an owner (i\in C_j) with (Q_i\ne\varnothing), contradicting (F(a)=\operatorname{Fin}n). Therefore the conditional conclusion would be

[
|C_j|
\ge
\operatorname{SparseBound}(n)+1
===============================

\left\lfloor\frac n2\right\rfloor+2.
]

For (n=3,4), that exceeds the (n-1) available owners. For (n\ge5), it gives only a dense-core obstruction.

Because the sparse theorem is rejected, this is not an unconditional proof of `DENSE-CANONICAL-CORE`. The explicit counterexample does not itself refute that dense-core statement because its pivot (144) is uncovered.

No new Lean theorem was produced. The existing chain

[
\text{one pivot certificate}
\to
\text{PositiveIntegerPivotCertificateConjecture}
\to
\text{PositiveIntegerConjecture}
\to
\text{Conjecture}
\to
\text{real LRC}
]

is not reached.

---

## 10. Artifacts and final evidence boundary

* [Fresh C++20 verifier source](sandbox:/mnt/data/p78_sparse_minimal_cover_verifier.cpp)
* [Complete machine-readable output](sandbox:/mnt/data/p78_sparse_minimal_cover_verifier_output.json)
* [Build, run, hash, and malformed-input manifest](sandbox:/mnt/data/p78_sparse_minimal_cover_manifest.json)

Final boundary:

* The height-(24), (3\le n\le7) sweep has zero failures and remains `computed finite evidence`.
* The tuple ((6,7,12,24,144)) is an unrestricted exact counterexample and is `proved-math`.
* `SPARSE-MINIMAL-COVER-OWNER-ESCAPE` is `rejected`.
* The theorem remains false even when restricted to canonical covers.
* The unconditional dense-canonical-core statement remains `open`.
* No unrestricted LRC claim, repository edit, attachment execution, or status promotion was made.
