## 1. **Disposition**

**STOP**

`CANONICAL-DELETION-FAILURE-FORCES-DIVISOR-BLOCK` is false.

The first hard-premise tuple in the mandated deterministic search is

[
a=(1,3,16),\qquad n=3,\qquad N=4.
]

It satisfies every frozen hard-canonical-failure premise, but none of its six nonempty proper exceptional sets is a strict divisor block. This is an exact arithmetic counterexample, not merely bounded negative evidence.

`DIVISOR-BLOCK-WITNESS-LIFT` is valid as stated and is proved below. It does not rescue the route because the structural lemma needed to produce a block is rejected. No narrower positive theorem satisfying the `PIVOT` standard was obtained. Unrestricted Lonely Runner remains `open`.

---

## 2. **Status table**

| Claim                                                                                                                                                         | Status                     | Exact dependency or boundary                                                   |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------- | ------------------------------------------------------------------------------ |
| Real-to-positive-integer reduction, gcd normalization, pivot-certificate equivalence, coefficient-three height theorem, selected-certificate lift implication | `proved-lean`              | Accepted tracked dependencies; not replayed or strengthened here               |
| One-speed and two-speed base cases                                                                                                                            | `proved-lean`              | Accepted induction bases                                                       |
| Deletion-gcd bridge and elementary one-omitted-coordinate shift argument                                                                                      | `proved-math`              | Accepted prior scope only                                                      |
| `DIVISOR-BLOCK-WITNESS-LIFT`                                                                                                                                  | `proved-math`              | Direct finite-orbit proof in Section 5                                         |
| The orbit capacity (g_k\lceil 2q_k/N\rceil)                                                                                                                   | `proved-math`              | Valid with the open bad arc and closed safe boundary                           |
| (a=(1,3,16)) is hard-canonical-failure data with no strict divisor block                                                                                      | `proved-math`              | Direct canonical-minimality and six-subset calculation                         |
| Infinite family ((1,3,L)) described in Section 7                                                                                                              | `proved-math`              | Exact congruence analysis                                                      |
| Mandated (3\le n\le6), maximum (24) search                                                                                                                    | `computed finite evidence` | Exact deterministic scan, stopped at the first failure                         |
| Targeted one-coordinate mutations through speed (120)                                                                                                         | `computed finite evidence` | Exact declared finite domains                                                  |
| `CANONICAL-DELETION-FAILURE-FORCES-DIVISOR-BLOCK`                                                                                                             | `rejected`                 | Counterexample ((1,3,16)), with further counterexamples including ((1,2,3,60)) |
| Universal divisor-lattice extraction in Attack A                                                                                                              | `rejected`                 | Pairwise-coprime hard family has no nontrivial survivor divisor block          |
| Universal centered-remainder-to-divisibility implication in Attack B                                                                                          | `rejected`                 | Exact failure equations at ((1,3,16))                                          |
| Proposed strong-induction proof of positive-integer LRC                                                                                                       | `conditional`              | Every branch is sound except the rejected structural implication               |
| Unrestricted real Lonely Runner Conjecture                                                                                                                    | `open`                     | No status change                                                               |

---

## 3. **Frozen definitions**

For a positive injective (n)-tuple (a), put (N=n+1) and

[
\rho_M(x)=\min(x\bmod M,;M-(x\bmod M)).
]

For deletion (k), surviving pivot (j\ne k), and (0\le r<n a_j),

[
\operatorname{DelCert}(a;k,j,r)
]

means:

[
n\nmid r
]

and

[
\rho_{n a_j}(r a_i)\ge a_j
\quad\text{for every }i\ne k.
]

The pivot coordinate is included. Certificates are ordered lexicographically by

[
(a_j,j,r).
]

Because the speeds are injective, the first key is strict. The canonical certificate for deletion (k) is the least certificate in this order.

For that canonical pair ((j_k,r_k)),

[
\operatorname{CanonicalLift}(a,k)
\iff
N\rho_{n a_{j_k}}(r_k a_k)\ge n a_{j_k}.
]

Equality is safe. Canonical failure is the strict reverse inequality.

For a nonempty proper exceptional set (S), write (T=\operatorname{Fin}n\setminus S) and

[
d=\gcd(a_i:i\in T),\qquad
g_k=\gcd(d,a_k),\qquad
q_k=\frac d{g_k},
]

[
\operatorname{cap}_N(d,a_k)
===========================

g_k\left\lceil\frac{2q_k}{N}\right\rceil.
]

The block condition is strictly

[
\sum_{k\in S}\operatorname{cap}_N(d,a_k)<d.
]

Capacity equality is not a block. Repeated orbit phases count with multiplicity (g_k).

For deterministic reporting, subsets were ordered first by cardinality and then lexicographically by their zero-based index tuples. This ordering is computational metadata, not an additional theorem hypothesis.

---

## 4. **Anti-tautology and route-overlap audit**

The fatal tuple ((1,3,16)) is not a hypothetical Lonely Runner counterexample. It has the explicit full witness

[
t=\frac5{11},
]

with distances

[
\left|\frac5{11}\right|=\frac5{11},\qquad
\left|\frac{15}{11}\right|=\frac4{11},\qquad
\left|\frac{80}{11}\right|=\frac3{11},
]

all strictly above (1/4).

Thus:

* no assumption of counterexamplehood was used;
* no assumption that a full witness is absent was used;
* no exceptional set was defined from a known witness;
* all six permissible (S) were evaluated independently from the divisor-block definition;
* the counterexample applies to the exact universal quantifier in the frozen lemma.

The argument uses no prime forcing, divisor graph, private-token Hall matching, Fourier or signed Gram form, sparse-cover exchange, DPLP selector, owner shift, first blocker, reverse-grid descent, pairwise certificate intersection, or whole-block packing from Prompt 66. The finite shift-orbit argument in Section 5 is the explicitly required local lifting theorem, not Prompt 66’s modular packing edge.

No tracked repository was edited. No Lean declaration was added or compiled.

---

## 5. **Local lifting theorem**

### `DIVISOR-BLOCK-WITNESS-LIFT`

Let (S) be a strict divisor block, (T) its nonempty complement, and

[
d=\gcd(a_i:i\in T).
]

Write (a_i=d b_i) for (i\in T). Suppose that at time (t),

[
|t b_i|\ge \frac1{|T|+1}
\qquad(i\in T).
]

For (h=0,\ldots,d-1), define

[
\tau_h=\frac{t+h}{d}.
]

Then some (\tau_h) is a full (1/N)-witness for (a).

### Proof

Let (m=|T|).

#### 1. Survivor phases are unchanged

For (i\in T),

[
a_i\tau_h
=========

# d b_i\frac{t+h}{d}

b_i t+h b_i.
]

Since (h b_i\in\mathbb Z),

[
a_i\tau_h\equiv b_i t\pmod 1.
]

Therefore every survivor has exactly the same circle phase, and hence the same circle distance, at every (\tau_h).

#### 2. Exact exceptional orbit structure

Fix (k\in S). Put

[
g=g_k=\gcd(d,a_k),\qquad
d=gq,\qquad
a_k=gc.
]

Then (\gcd(c,q)=1). Modulo one,

[
a_k\tau_h
=========

\frac{a_k t}{d}+\frac{h a_k}{d}
\equiv
\alpha+\frac{hc}{q},
\qquad
\alpha=\frac{a_k t}{d}.
]

As (h) runs modulo (q), multiplication by (c) permutes all residues modulo (q). Hence there are exactly (q) distinct phases,

[
\alpha,\ \alpha+\frac1q,\ldots,\alpha+\frac{q-1}{q},
]

up to permutation. Since the full range (0\le h<d=gq) consists of (g) complete periods, each distinct phase occurs exactly (g) times.

#### 3. Number of distinct phases in the bad arc

The bad set for the (1/N) threshold is the open circular arc

[
B_N={x\in\mathbb R/\mathbb Z:|x|<1/N},
]

of length (2/N).

Suppose (u) of the (q) equally spaced orbit phases lie in an open arc of length (L=2/N). Lift that arc to an open real interval and order the selected grid points. The distance from the first to the last is at least

[
\frac{u-1}{q},
]

while both points lie in an open interval of length (L), so

[
\frac{u-1}{q}<L.
]

Thus

[
u-1<\frac{2q}{N}.
]

Because (u) is integral,

[
u\le \left\lceil\frac{2q}{N}\right\rceil.
]

This remains valid when (2q/N) is integral: openness gives a strict inequality before rounding. A phase at distance exactly (1/N) is safe and is not counted.

#### 4. Number of excluded shift indices

Each distinct exceptional phase occurs for exactly (g) values of (h). Therefore coordinate (k) excludes at most

[
g\left\lceil\frac{2q}{N}\right\rceil
====================================

\operatorname{cap}_N(d,a_k)
]

of the (d) shift indices.

#### 5. Strict union bound

The union of all exceptional bad-shift sets has cardinality at most

[
\sum_{k\in S}\operatorname{cap}_N(d,a_k)<d.
]

Hence at least one (h\in{0,\ldots,d-1}) is not excluded by any exceptional coordinate.

#### 6. Survivor threshold comparison

Because (S) is nonempty and (T) is proper,

[
m+1\le n<N=n+1.
]

Consequently,

[
\frac1{m+1}\ge\frac1n>\frac1N.
]

The survivors are therefore safe at the required (1/N) threshold, while the selected (h) makes every exceptional coordinate safe. Thus (\tau_h) is a full witness. ∎

---

## 6. **Exact fixtures and deterministic falsification**

### First structural failure: ((1,3,16))

Here

[
n=3,\qquad N=4,\qquad \gcd(1,3,16)=1,
]

[
16>4+\left\lfloor\frac43\right\rfloor=5,
\qquad
4\mid16.
]

The frozen canonical rows are:

| Deleted speed | Canonical pivot, numerator | Modulus | Residues in tuple order | Certificate count |       Failure |
| ------------: | -------------------------: | ------: | ----------------------- | ----------------: | ------------: |
|           (1) |                (p=3,\ r=2) |     (9) | ((2,3,4))               |                12 | (4\cdot2=8<9) |
|           (3) |                (p=1,\ r=1) |     (3) | ((1,0,1))               |                14 | (4\cdot0=0<3) |
|          (16) |                (p=3,\ r=4) |     (9) | ((4,3,1))               |                 2 | (4\cdot1=4<9) |

Canonical minimality is direct:

* deleting (1), pivot (3), (r=1) fails on speed (16), while (r=2) works;
* deleting (3), pivot (1), (r=1) is the first allowed certificate;
* deleting (16), pivot (1) is impossible because surviving speed (3) is zero modulo (3); at pivot (3), (r=1,2) fail on speed (1), while (r=4) works.

Every nonempty proper (S) fails strict capacity:

| (S) by speeds | (T) by speeds | (d) | Capacity terms |    Sum |
| ------------- | ------------- | --: | -------------: | -----: |
| ({1})         | ({3,16})      |   1 |            (1) |  (1=d) |
| ({3})         | ({1,16})      |   1 |            (1) |  (1=d) |
| ({16})        | ({1,3})       |   1 |            (1) |  (1=d) |
| ({1,3})       | ({16})        |  16 |          (8+8) | (16=d) |
| ({1,16})      | ({3})         |   3 |          (2+2) |  (4>d) |
| ({3,16})      | ({1})         |   1 |          (1+1) |  (2>d) |

There is no strict divisor block.

The centered exceptional equations are

[
2\cdot1=0\cdot9+2,\qquad 4|2|=8<9,
]

[
1\cdot3=1\cdot3+0,\qquad 4|0|=0<3,
]

[
4\cdot16=7\cdot9+1,\qquad 4|1|=4<9.
]

This proves the frozen structural lemma `rejected`.

### Required local fixtures

**1. Local success ((2,4,5)).**
Take (T={2,4}), (S={5}). Then

[
d=2,\quad g=\gcd(2,5)=1,\quad q=2,
]

[
\operatorname{cap}_4(2,5)=\left\lceil\frac{4}{4}\right\rceil=1<2.
]

The divided tuple is ((1,2)). At (t=1/3), both divided survivors have distance (1/3).

The shifts are

[
\tau_0=\frac16,\qquad \tau_1=\frac23.
]

For speed (5), the phases are (5/6) and (1/3), two distinct phases, each occurring once. At (\tau_0), speed (5) has distance (1/6). At (\tau_1),

[
(|2\tau_1|,|4\tau_1|,|5\tau_1|)
===============================

\left(\frac13,\frac13,\frac13\right).
]

Thus (h=1) is an explicit lifted shift.

**2. Boundary failure ((2,4,6)).**
With the same survivors,

[
d=2,\quad g=\gcd(2,6)=2,\quad q=1,
]

[
\operatorname{cap}_4(2,6)
=========================

# 2\left\lceil\frac24\right\rceil

2=d.
]

The exceptional orbit has one distinct phase, repeated twice. At both (\tau_0=1/6) and (\tau_1=2/3), speed (6) has phase zero. Equality in the capacity sum does not leave a shift.

**3. Coarse premises ((1,2,3,10)).**
Here (n=4), (N=5), the cutoff is (6), and (10) is (N)-divisible. Direct evaluation gives no strict divisor block. For example,

[
S={1,3},\quad T={2,10},\quad d=2,
]

has capacities (1+1=2=d), while every other subset has sum at least (d).

The canonical-failure premise is false. Deleting speed (2), the canonical certificate is pivot (1), (r=1), residues

[
(1,2,1,2),
]

and

[
5\cdot2=10\ge4.
]

Thus the coarse height and divisibility premises alone do not force a block.

**4. Raw deletion failure ((1,3,4,7)).**
The deletion-certificate counts are

[
(8,8,11,4),
]

and the total lifting-certificate counts are

[
(0,0,0,0).
]

The canonical rows are respectively

[
(3,1),\quad(4,6),\quad(1,1),\quad(3,5),
]

and all fail. The prior literal audit independently records the same complete no-lift certificate rows. 

This tuple is excluded from the hard branch because (N=5) divides no speed. Indeed,

[
t=\frac15
]

is the direct witness, with distances

[
\left(\frac15,\frac25,\frac15,\frac25\right).
]

**5. Pairwise phase-set failure ((1,2,3,60)).**
The certificate counts are

[
(48,30,48,6),
]

and the total lift counts are

[
(18,0,6,0).
]

All four canonical certificates fail. The tuple is itself hard-canonical-failure data and has no strict divisor block, so it is a second structural counterexample.

At the deletion threshold (1/4), the exact simultaneous safe set for speeds (1,2,3) is

[
\left{\frac14,\frac34\right}\pmod1.
]

At both times, (60t\in\mathbb Z), so speed (60) has distance zero. Hence no time makes all four speeds safe at threshold (1/4).

If (K_k) denotes the phase set making every coordinate except (k) safe, then for (k\ne \ell),

[
K_k\cap K_\ell
]

would make all four coordinates safe. Therefore every pairwise intersection is empty even though every individual deletion-certificate set is nonempty.

**6. An (N)-divisible pivot need not lift: ((1,2,6,8,10)).**
Here (n=5), (N=6), and speed (6) is (N)-divisible. The deletion-certificate counts are

[
(8,22,16,16,26),
]

with total lift counts

[
(8,8,8,4,4).
]

At fixed pivot (6), there are exactly 16 deletion-certificate rows, with numerators

[
6,7,8,9,11,12,13,14,16,17,18,19,21,22,23,24,
]

and none lifts.

Nevertheless, deleting speed (1), pivot (8), (r=9), modulus (40), gives residues

[
(9,18,14,8,10),
]

and

[
6\cdot9=54\ge5\cdot8=40.
]

Thus a lifting certificate need not use an (N)-divisible pivot.

### Endpoint and malformed-data checks

* Shell equality is safe. For ((1,3,4)), deleting speed (3), pivot (4), (r=5), modulus (12), gives residues ((5,3,4)) and
  [
  4\cdot3=12=3\cdot4.
  ]
* Strict capacity equality is insufficient, as ((2,4,6)) demonstrates.
* Orbit collisions are counted with multiplicity (g_k).
* (S=\varnothing) is excluded; (T=\varnothing) is excluded by properness.
* Singleton (T) is valid and appears in the fatal subset table.
* Since (T) is nonempty and all speeds are positive, (d>0), (g_k>0), and (q_k=d/g_k) is well-defined.
* The verifier rejects empty tuples, nonpositive speeds, duplicate speeds, nonpositive moduli, empty gcd inputs, and malformed command lines.

### Mandated deterministic search

Domain:

[
3\le n\le6,\qquad \max a_i\le24,
]

primitive strictly increasing tuples, ordered first by (n), then lexicographically. The scan stopped globally at the first hard-premise tuple with no block.

| Executed-prefix category          | Count |
| --------------------------------- | ----: |
| Tuples examined                   |    35 |
| Primitive                         |    35 |
| Above coefficient-three cutoff    |    30 |
| Containing an (N)-divisible speed |     8 |
| Every deletion nonempty           |     8 |
| Hard-canonical-failure premise    |     1 |
| Hard rows with a strict block     |     0 |
| Hard rows without a strict block  |     1 |

The sole premise row in the executed prefix is ((1,3,16)). Therefore the result is nonvacuous. Dimensions (4,5,6) were not entered because the required early-stop condition fired in dimension (3).

### Targeted mutations through speed 120

The declared mutation operation replaces exactly one coordinate by each integer (1,\ldots,120), sorts the tuple, discards collisions and the unchanged tuple, deduplicates, and then uses lexicographic order.

| Base fixture   | Mutations | Primitive | Hard rows | With block | Without block | First hard row without block |
| -------------- | --------: | --------: | --------: | ---------: | ------------: | ---------------------------- |
| ((1,2,3,10))   |       464 |       464 |        24 |          2 |            22 | ((1,2,3,20))                 |
| ((1,3,4,7))    |       464 |       464 |        23 |          2 |            21 | ((1,3,4,10))                 |
| ((1,2,3,60))   |       464 |       464 |        32 |         12 |            20 | ((1,2,3,20))                 |
| ((1,2,6,8,10)) |       575 |       519 |        26 |         25 |             1 | ((1,6,7,8,10))               |

These mutation totals are `computed finite evidence`; they are not needed for the exact rejection.

### Execution and hashes

Runtime:

```text
CPython 3.13.5
Linux 6.12.13 x86_64
exact arbitrary-precision integers and fractions.Fraction
```

Commands:

```text
python3 /mnt/data/prompt80_exact_search.py
python3 /mnt/data/prompt80_replay.py
```

Any command-line argument produces a diagnostic and exit status `2`.

| Artifact                     |   Bytes | SHA-256                                                            |
| ---------------------------- | ------: | ------------------------------------------------------------------ |
| `prompt80_exact_search.py`   |  19,695 | `c680b9c3c621b0f6d14bb1d5eb0b93b0263d25db454dc29d51709eab576551ea` |
| `prompt80_exact_search.json` | 106,586 | `07db2f92bcd86e4d9ba4b8370b1b1c01055f44323f69136127725ff683262bef` |
| `prompt80_replay.py`         |  13,365 | `d5dfaf22f520ab9a97aece4980e9a03e125c02b5c53353ec73957399be8659ed` |
| `prompt80_replay.json`       |   4,205 | `b7ba34f436d8a323238fb4fdfb34bdfd0e1097fc3e7185af64f038d58ad6b9d2` |

The main output embeds its exact source hash and the canonical-results digest

```text
6871fc032454dd8031739131d3865f758472e67598cbf61800837b12c28355ca
```

The independent replay imports none of the search implementation. It reconstructs the ordered prefix, canonical rows, subset capacities, mutation summaries, lift counts, and endpoint fixtures, and verifies the main source/output binding.

---

## 7. **Attack A: divisor lattice**

Attack A is stopped by an exact infinite pairwise-coprime family.

### Infinite counterfamily

Let

[
a=(1,3,L),
]

where

[
L>5,\qquad 4\mid L,\qquad
L\bmod9\in{2,4,5,7}.
]

Equivalently,

[
L\bmod36\in{4,16,20,32},
]

subject to (L>5). The first member is (L=16).

These tuples are pairwise coprime, hence primitive, and every two-speed deletion has gcd one.

For deletion of speed (1):

* if (L\bmod9\in{4,5}), the canonical certificate is pivot (3), (r=1);
* if (L\bmod9\in{2,7}), (r=1) fails and the canonical certificate is pivot (3), (r=2).

The exceptional residue is respectively (1) or (2), so

[
4\rho<9.
]

For deletion of speed (3), pivot (1), (r=1) is canonical, and the exceptional residue of speed (3) is zero.

For deletion of speed (L), pivot (1) is impossible because surviving speed (3) is zero modulo (3). At pivot (3), (r=1,2) fail on surviving speed (1), and (r=4) is canonical. Moreover,

[
\rho_9(4L)=
\begin{cases}
1,&L\bmod9\in{2,7},\
2,&L\bmod9\in{4,5},
\end{cases}
]

so again (4\rho<9).

Thus every member is hard-canonical-failure data.

For a singleton (S), the two survivors are coprime, so (d=1) and the sole capacity is (1=d).

For a two-element (S), (T={d}) is a singleton survivor. Both exceptional speeds are coprime to (d), so each contributes

[
\left\lceil\frac d2\right\rceil.
]

Hence

[
\sum_{k\in S}\operatorname{cap}_4(d,a_k)
========================================

2\left\lceil\frac d2\right\rceil
\ge d.
]

No member has a strict divisor block.

This family also contains infinitely many prime-power examples. For example, (L=2^m) works whenever (m\ge4) and

[
m\bmod6\in{1,2,4,5}.
]

### Consequences for the divisor lattice

* Pairwise-coprime hard data can have no nontrivial common prime-power survivor hyperedge of size at least two.
* Primitivity and even all-deletion gcd one do not provide the required block.
* Choosing the largest speed as a singleton survivor does not help. At (L=16), (T={16}) gives capacities (8+8=16), exactly saturating (d).
* Large (g_k) is adverse rather than automatically helpful. If (g_k=d), then (q_k=1) and
  [
  \operatorname{cap}_N(d,a_k)=d,
  ]
  so one exceptional coordinate consumes the entire shift orbit.
* Common scaling preserves the strict-block truth value. Under (a\mapsto ca),
  [
  d\mapsto cd,\qquad g_k\mapsto cg_k,\qquad q_k\mapsto q_k,\qquad
  \operatorname{cap}\mapsto c,\operatorname{cap}.
  ]
  Primitivity merely removes nontrivial common scales; it does not create strict capacity.
* The CRT classes modulo (36) above show that the failure is arithmetically structured, not an isolated accidental tuple.

The first unsupported arrow in Attack A is therefore:

[
\text{hard canonical failure}
\Longrightarrow
\text{a nontrivial maximal-gcd survivor block with strict capacity}.
]

That implication is `rejected`.

---

## 8. **Attack B: canonical-failure arithmetic**

At the fatal tuple, the complete centered equations are

| Deleted speed | Centered equation    | Strict failure |   |       |
| ------------: | -------------------- | -------------: | - | ----- |
|           (1) | (2\cdot1=0\cdot9+2)  |             (4 | 2 | =8<9) |
|           (3) | (1\cdot3=1\cdot3+0)  |             (4 | 0 | =0<3) |
|          (16) | (4\cdot16=7\cdot9+1) |             (4 | 1 | =4<9) |

All survivor inequalities hold, and each row is canonical by the explicit minimality checks in Section 6. Nevertheless,

[
\gcd(1,3)=\gcd(1,16)=\gcd(3,16)=1.
]

The small remainders (2,0,1) produce no nontrivial common survivor divisor.

The fatal arithmetic issue is exact:

[
r a_k=q'(n a_j)+e
]

with small (e) is a near-congruence, not a divisibility statement. When (e\ne0), no exact divisor follows. When (e=0), cancellation of (r) is valid only after retaining

[
\gcd(r,n a_j).
]

At most one obtains a divisibility statement modulo

[
\frac{n a_j}{\gcd(r,n a_j)},
]

and it concerns the exceptional speed and that pivot. It does not imply a common divisor of a selected survivor block.

The middle row has (e=0), but it only records the tautological local divisibility (3\mid3). Its survivor set is ({1,16}), whose gcd is one.

Therefore the first unsupported arrow in Attack B is

[
\begin{array}{c}
\text{canonical minimality}\
+\ \text{survivor safety}\
+\ N|e_k|<n a_{j_k}
\end{array}
\Longrightarrow
\text{nontrivial common survivor divisibility}.
]

The tuple ((1,3,16)) rejects that arrow while preserving every antecedent. No nonunit cancellation, first-blocker transfer, or post-inspection certificate choice repairs it.

---

## 9. **Complete implication chain**

The intended induction is sound only conditionally on the rejected structural lemma.

1. **Strong induction hypothesis.** Assume positive-integer LRC for every positive dimension (m<n), not only (n-1). This permits deletion of an arbitrary nonempty block.

2. **Base dimensions.** Use the accepted `proved-lean` one-speed and two-speed cases.

3. **Primitive normalization.** Normalize a hypothetical (n)-speed integer counterexample by its common gcd using the accepted scaling equivalence.

4. **Bounded-height branch.** If
   [
   \max_i a_i\le N+\left\lfloor\frac N3\right\rfloor,
   ]
   apply the accepted coefficient-three theorem.

5. **No (N)-divisible speed branch.** If no (a_i) is divisible by (N), then (t=1/N) is a direct witness. For every (i), the nonzero residue (a_i\bmod N) has cyclic distance at least one from zero, hence
   [
   \left|\frac{a_i}{N}\right|\ge\frac1N.
   ]

6. **Deletion certificates.** In the remaining branch, the height is above the cutoff and some speed is (N)-divisible. For every deletion (k), the strong induction hypothesis supplies a (1/n)-witness for the ((n-1))-speed deletion. The accepted pivot-certificate equivalence therefore makes its `DelCert` set nonempty.

7. **Canonical lift branch.** If some frozen canonical certificate satisfies
   [
   N\rho_{n a_{j_k}}(r_k a_k)\ge n a_{j_k},
   ]
   apply the accepted selected-certificate lift implication to obtain a full (1/N)-witness.

8. **All canonical certificates fail.** At this point the proposed proof requires
   [
   \text{hard canonical failure}
   \Longrightarrow
   \text{strict divisor block}.
   ]
   This implication is false at ((1,3,16)), and also at ((1,2,3,60)). The induction stops here.

9. **Conditional block branch.** Had a strict block (S) existed, (T) would satisfy (1\le|T|<n). Dividing by
   [
   d=\gcd(a_i:i\in T)
   ]
   produces a primitive injective (|T|)-tuple. Strong induction, including the one-speed base when (|T|=1), would supply its (1/(|T|+1))-witness. Section 5 would then lift it to a full witness.

10. **Final bridge.** If every preceding branch closed, positive-integer LRC would follow, followed by unrestricted real LRC through the accepted real/integer equivalence.

Thus the wrapper is `conditional`, but its sole new unrestricted premise is not merely unproved. It is `rejected`.

---

## 10. **Proof-obligation ledger and final evidence boundary**

| Obligation                                             | Outcome                                      | Status                     |
| ------------------------------------------------------ | -------------------------------------------- | -------------------------- |
| Survivor phases unchanged under (\tau_h)               | Proved exactly                               | `proved-math`              |
| (q_k) distinct phases, each repeated (g_k) times       | Proved exactly                               | `proved-math`              |
| Open-arc count (\le\lceil2q_k/N\rceil)                 | Proved exactly, including integral endpoints | `proved-math`              |
| Exceptional excluded-shift bound                       | Proved exactly                               | `proved-math`              |
| Strict union bound leaves a shift                      | Proved exactly                               | `proved-math`              |
| Survivor threshold comparison                          | Proved exactly                               | `proved-math`              |
| Local success and capacity-equality fixtures           | Recomputed exactly                           | `proved-math`              |
| Frozen structural lemma                                | Counterexample ((1,3,16))                    | `rejected`                 |
| Pairwise-coprime and prime-power divisor-lattice route | Infinite counterfamily                       | `rejected`                 |
| Canonical small-remainder divisibility route           | Fatal equations at ((1,3,16))                | `rejected`                 |
| Mandated bounded search                                | First premise row is a failure               | `computed finite evidence` |
| Targeted mutations                                     | Many additional failures                     | `computed finite evidence` |
| Complete induction to LRC                              | Breaks at rejected structural arrow          | `conditional`              |
| Unrestricted LRC                                       | Unaffected                                   | `open`                     |

The exact structural counterexample, infinite family, and local lifting theorem are mathematical arguments independent of the finite search. The search and mutation results remain `computed finite evidence`. No result was promoted to `proved-lean`.

Artifacts:

* [Exact search source](sandbox:/mnt/data/prompt80_exact_search.py)
* [Exact search output](sandbox:/mnt/data/prompt80_exact_search.json)
* [Independent replay source](sandbox:/mnt/data/prompt80_replay.py)
* [Independent replay output](sandbox:/mnt/data/prompt80_replay.json)
