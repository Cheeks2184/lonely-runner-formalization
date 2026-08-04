## 1. Disposition

**STOP**

`OBSTRUCTION-EXTRACTION-DISTINCT-PRIME-SUPPLY` remains **open**. It is neither proved nor refuted here.

The exact fatal arrow is the transition from canonical private-point data to a finite, (p)-independent obstruction set. Private points do give explicit nonzero integers divisible by (p), but those integers are constructed from centered lifts whose values depend on (p). They therefore cannot serve as a fixed (\Delta_\sigma).

Two natural attempts fail on the first lexicographic mandatory fixtures:

1. The full private-point determinant is exactly (0).
2. A bounded modular annihilator lifts to an exact integer relation with value (0).

A universally nonzero (2\times2) private-point minor survives, but its divisibility by (p) comes from the modulus (M=Np) itself. This is the prohibited “prime-dependent determinant” case. It does not restrict the possible primes and does not produce a finite set (\Sigma_n).

The distinct-prime divisor-graph extraction is valid once the frozen obstruction lemma is assumed.

---

## 2. Status table

| Claim                                                                    | Status                     | Exact dependency                                                                                                                                                |
| ------------------------------------------------------------------------ | -------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Strict-boundary symmetry under independent signs and common unit scaling | `proved-math`              | Directly from (\rho_M(-x)=\rho_M(x)) and multiplication by a unit permuting (\mathbb Z/M\mathbb Z)                                                              |
| Every owner in an inclusion-minimal cover has a private residue          | `proved-math`              | Minimality                                                                                                                                                      |
| Selected owners in a minimal cover have distinct bad sets                | `proved-math`              | Coincident sets make one selected owner removable                                                                                                               |
| (p\le N) implies `PrimeForcing(n,p)` via (r=N)                           | `proved-math`              | Exact calculation below                                                                                                                                         |
| Every failure cover contains an owner divisible by (N)                   | `proved-math`              | Evaluate the cover at (r=p)                                                                                                                                     |
| A selected (N)-divisible owner can be normalized exactly to (N)          | `proved-math`              | CRT, using (p>N)                                                                                                                                                |
| Exact CRT fiber description of every normalized bad set                  | `proved-math`              | Direct CRT calculation                                                                                                                                          |
| Every pair of private owners gives a nonzero (p)-divisible cross-minor   | `proved-math`              | Strict diagonal/off-diagonal inequalities and rank-one reduction modulo (N) and (p)                                                                             |
| The cross-minor is a fixed (\Delta_\sigma)                               | `rejected`                 | It depends on (p) through private residues and centered lifts                                                                                                   |
| Full private-point determinant as (\Delta_\sigma)                        | `rejected`                 | It equals (0) on both first mandatory failures                                                                                                                  |
| Exact normalized annihilator as (\Delta_\sigma)                          | `rejected`                 | It equals (0) on both first mandatory failures                                                                                                                  |
| Exhaustive searches for ((n,p)=(3,5),(4,7))                              | `computed finite evidence` | Fresh exact CPython enumeration, hashes below                                                                                                                   |
| Uniform (H_n) for all nonanchor projective residues                      | `open`                     | No (p)-independent bound was obtained                                                                                                                           |
| Finite (p)-independent (\Sigma_n) and nonzero (\Delta_\sigma)            | `open`                     | This is the frozen obstruction lemma                                                                                                                            |
| Abstract divisor-graph matching and threshold extraction                 | `proved-math`              | Assumes a fixed (D_n>0) satisfying the obstruction lemma                                                                                                        |
| Matched primes satisfy `PrimeForcing`                                    | `conditional`              | Frozen obstruction lemma                                                                                                                                        |
| MSS product wrapper                                                      | `external-unformalized`    | Published MSS theorem and Rosenfeld product corollary                                                                                                           |
| Complete route to positive-integer LRC                                   | `conditional`              | Obstruction lemma, induction, and external MSS wrapper                                                                                                          |
| Existing real/integer equivalence                                        | `proved-lean`              | Accepted project boundary                                                                                                                                       |
| Unrestricted real LRC                                                    | `open`                     | The obstruction lemma remains open; a July 2026 primary source describes the general conjecture as widely open, with cases through (n\le13) known. ([arXiv][1]) |

The audited MSS article is the 2025 Forum of Mathematics, Sigma publication with DOI `10.1017/fms.2025.10107`. ([Cambridge University Press][2]) Rosenfeld restates MSS Theorem A, the exact product corollary, and the modular prime-divisibility implication used by this route. ([arXiv][3])

---

## 3. Frozen definitions

Fix (n\ge3), (N=n+1), a prime (p), and (M=Np). All residues below use their representatives in ({0,\ldots,M-1}).

[
\rho_M(x)=\min(x\bmod M,;M-(x\bmod M)).
]

For an owner value (v_i),

[
B_i(v)={r\in\mathbb Z/M\mathbb Z:\rho_M(rv_i)<p}.
]

The inequality is strict. Thus (\rho_M(rv_i)=p) is safe.

A tuple (v=(v_0,\ldots,v_{n-1})) is admissible when

[
p\nmid v_i\quad\text{for every }i,
]

and

[
\gcd!\left(M,{v_i:i\ne k}\right)=1
\quad\text{for every }k.
]

Repeated values, coincident bad sets, nonunits, and values sharing factors with (N) remain in the domain.

A failure is an admissible tuple satisfying

[
\bigcup_{i<n}B_i(v)=\mathbb Z/M\mathbb Z.
]

The canonical selected owners are obtained by minimizing cover cardinality and then choosing the lexicographically least increasing owner list. If this list is

[
\iota(0)<\cdots<\iota(m-1),
]

the private set of selected owner (s) is

[
P_s=B_{\iota(s)}
\setminus\bigcup_{t\ne s}B_{\iota(t)}.
]

Every (P_s) is nonempty. The canonical private residue (r_s) used below is the least representative of (P_s) in ({0,\ldots,M-1}).

### Exact symmetry audit

For independent signs (\varepsilon_i\in{-1,1}),

[
B_i(\varepsilon_i v_i)=B_i(v_i),
]

and all gcd premises are unchanged.

For a common unit (u\in(\mathbb Z/M\mathbb Z)^\times),

[
B_i(uv_i)=u^{-1}B_i(v_i).
]

Consequently, every fixed owner subset covers before scaling exactly when it covers afterward. Minimum cardinality, the lexicographic owner list, private-set nonemptiness, (p)-nondivisibility, and deletion gcd premises are preserved.

An owner permutation preserves the unlabeled covering and gcd statements, but it need not preserve the frozen lexicographic tie-break in the same literal labels. No owner permutation is used before canonical selection in this audit.

### Anchor normalization

At (r=p), writing (a_i=v_i\bmod N),

[
\rho_M(pv_i)=p\min(a_i,N-a_i).
]

Therefore

[
p\in B_i(v)\quad\Longleftrightarrow\quad N\mid v_i.
]

Every complete cover, including the canonical selected cover, therefore contains an (N)-divisible owner.

Also, every bad prime has (p>N), by the small-prime proof in Section 5. Hence (\gcd(N,p)=1). If the selected anchor is

[
v_j=Nw,\qquad p\nmid w,
]

choose the unique unit (u) satisfying

[
u\equiv1\pmod N,\qquad u\equiv w^{-1}\pmod p.
]

Then

[
uv_j\equiv N\pmod{Np}.
]

Thus one selected coordinate can always be frozen as

[
c_j=0,\qquad z_j=N.
]

After this normalization, no further common scaling modulo (p) is available: a unit preserving the anchor (N) must be (1\bmod p).

---

## 4. Anti-tautology audit

Assume the frozen obstruction lemma and define

[
D_n=\prod_{\sigma\in\Sigma_n}|\Delta_\sigma|,
]

with the empty product interpreted as (1). Every bad prime divides at least one (\Delta_\sigma), hence divides (D_n). Therefore

[
{p:\operatorname{BadPrime}(n,p)}
\subseteq{q:q\text{ prime and }q\mid D_n}.
]

The target immediately implies cofinite prime forcing.

It is strictly stronger than cofinite forcing because it additionally demands:

* one finite owner-labelled bounded normalization fixed before (p);
* realization of every failure by that normalization;
* a displayed nonzero integer attached to each signature.

Uniform prime supply is weaker. It only needs sufficiently many distinct good primes whose product crosses the threshold; it does not require every prime outside a finite divisor set to be good.

The target is not a restatement of LRC, but target plus induction and the external MSS product wrapper proves LRC. Consequently:

* defining (\Sigma_n) after first proving that bad primes are finite is circular;
* defining (\Delta_\sigma=p) is forbidden;
* defining (D_n) as the product of all bad primes is forbidden;
* using unrestricted LRC to rule out an infinite family of bad primes is circular in the requested implication chain;
* a (p)-dependent determinant that is automatically a multiple of (Np) gives no finite-prime obstruction.

The surviving private-minor construction below falls into the last category.

---

## 5. Exact fixtures and falsification

### Reproducible attachment

* [Exact audit source](sandbox:/mnt/data/p79_falsification.py)
* [Exact audit output](sandbox:/mnt/data/p79_falsification_output.txt)

Source SHA-256:

```text
c30bc95c943b7f97aa8d3ff33ff781e9d39b0934d840fd53f7dbeabc6096b7e9
```

Output SHA-256:

```text
81cbbc7adefe721eceec3f7548986c6227df01b1f1708118c78128d0f0ca6f4a
```

Execution contract:

```text
Interpreter: CPython 3.13.5
Command:     python3 p79_falsification.py
Input:       none
Ordering:    tuple lexicographic, then cover cardinality,
             then increasing owner list, then increasing private residues
Arithmetic:  exact integers only
Randomness:  none
Packages:    Python standard library only
Extra arg:   stderr "usage: p79_falsification.py", exit status 64
```

A repeated execution produced byte-identical output.

### Exhaustive domains

| (n,p) | Candidate residues | Ordered repeated tuples | Premise-satisfying | Failures | First failure |
| ----- | -----------------: | ----------------------: | -----------------: | -------: | ------------- |
| (3,5) |                 16 |                   4,096 |              2,048 |      192 | ((1,3,4))     |
| (4,7) |                 30 |                 810,000 |            787,968 |   13,824 | ((1,3,4,5))   |

Every failure in the first domain has canonical cover size (3). Every failure in the second has canonical cover size (4).

### Fixture (n=3,p=5,v=(1,3,4))

Here (N=4), (M=20).

Deletion gcds:

[
(1,1,1).
]

Bad-set sizes:

[
(9,9,12).
]

Canonical owners:

[
(0,1,2).
]

Private sets:

[
\begin{aligned}
P_0&={2,3,17,18},\
P_1&={7,8,12,13},\
P_2&={5,9,10,11,15}.
\end{aligned}
]

Least private residues:

[
(r_0,r_1,r_2)=(2,7,5).
]

The nonunit owner is (4), with (\gcd(20,4)=4); it is retained and is the anchor.

The deterministic anchor-normalized signature is

[
\varepsilon=(1,-1,1),\qquad
c=(1,1,0),\qquad
z=(1,2,4).
]

The centered private-point matrix is

[
H=
\begin{pmatrix}
2&6&8\
7&1&8\
5&-5&0
\end{pmatrix}.
]

It satisfies

[
\det H=0.
]

Its first nonzero (2\times2) minor is

[
2\cdot1-6\cdot7=-40,
]

and

[
\frac{-40}{N}=-10,
\qquad 5\mid-10.
]

A bounded exact annihilator is

[
-2z_0-z_1+z_2=-2-2+4=0.
]

Thus using that annihilator value as (\Delta) gives the forbidden (\Delta=0).

### Fixture (n=4,p=7,v=(1,3,4,5))

Here (N=5), (M=35).

Deletion gcds:

[
(1,1,1,1).
]

Bad-set sizes:

[
(13,13,13,15).
]

Canonical owners:

[
(0,1,2,3).
]

Private sets:

[
\begin{aligned}
P_0&={3,4,5,30,31,32},\
P_1&={11,12,23,24},\
P_2&={9,16,17,18,19,26},\
P_3&={7,14,15,20,21,28}.
\end{aligned}
]

Least private residues:

[
(r_0,r_1,r_2,r_3)=(3,11,9,7).
]

The nonunit owner is (5), with (\gcd(35,5)=5); it is retained and is the anchor.

The deterministic anchor-normalized signature is

[
\varepsilon=(1,1,-1,1),\qquad
c=(1,3,1,0),\qquad
z=(1,3,3,5).
]

The centered private-point matrix is

[
H=
\begin{pmatrix}
3&9&12&15\
11&-2&9&-15\
9&-8&1&10\
7&-14&-7&0
\end{pmatrix}.
]

Again,

[
\det H=0.
]

Its first nonzero (2\times2) minor is

[
3(-2)-9(11)=-105,
]

and

[
\frac{-105}{N}=-21,
\qquad 7\mid-21.
]

A bounded exact annihilator is

[
-z_0+z_1+z_2-z_3=-1+3+3-5=0.
]

### Repeated and coincident sets

Repeated tuples and coincident bad sets were not removed from either search.

| Domain  | Premise tuples with repeated coordinates | Failure tuples among them | Premise tuples with coincident bad sets | Failure tuples among them |
| ------- | ---------------------------------------: | ------------------------: | --------------------------------------: | ------------------------: |
| ((3,5)) |                                      368 |                         0 |                                     704 |                         0 |
| ((4,7)) |                                  142,128 |                         0 |                                 268,416 |                         0 |

The first premise-satisfying examples in both categories are ((1,1,1)) and ((1,1,1,1)). Their absence among these finite failure sets is finite evidence only. Universally, coincident selected sets cannot both occur in an inclusion-minimal selected cover.

### Small primes and equality

For any (p\le N), any residue (v_i) with (p\nmid v_i), and (b_i=v_i\bmod p\in{1,\ldots,p-1}),

[
\rho_{Np}(Nv_i)
=N\min(b_i,p-b_i)
\ge N
\ge p.
]

Thus (r=N) proves `PrimeForcing(n,p)` for every prime (p\le N), without using deletion gcds or unit assumptions.

This includes all primes dividing (N).

For (n=4,p=5,M=25,r=5,v=1),

[
\rho_{25}(5)=5=p.
]

It is safe because badness is strict.

The search also explicitly rejected the deletion-edge tuples

[
(1,2,4)\pmod{20},
\qquad
(1,5,10,15)\pmod{35},
]

whose deletion-gcd lists are respectively

[
(2,1,1),\qquad(5,1,1,1).
]

---

## 6. Attack A: private-point normalization

Let the normalized selected values be

[
x_t=u\varepsilon_t v_{\iota(t)}\pmod M.
]

For each selected owner (s), choose its least private residue (r_s). Define the unique centered lift

[
h_{st}\in\mathbb Z,\qquad
-\frac M2<h_{st}\le\frac M2,
]

by

[
r_sx_t=Mq_{st}+h_{st}.
]

Private-point strictness gives

[
|h_{ss}|<p
]

and, for (t\ne s),

[
|h_{st}|\ge p.
]

No nonunit has been cancelled.

### Rank-one congruences

Modulo (p),

[
h_{st}\equiv r_sx_t\pmod p.
]

Hence the matrix (H=(h_{st})) satisfies

[
H\equiv
\begin{pmatrix}r_0\ \vdots\ r_{m-1}\end{pmatrix}
\begin{pmatrix}x_0&\cdots&x_{m-1}\end{pmatrix}
\pmod p,
]

so (H\bmod p) has rank at most (1).

The same argument modulo (N) gives rank at most (1) modulo (N).

Since every bad prime has (p>N), (\gcd(N,p)=1). Therefore every (2\times2) minor of (H) is divisible by (M=Np).

### A universal nonzero cross-minor

For distinct selected owners (s,t), define

[
D_{st}=h_{ss}h_{tt}-h_{st}h_{ts}.
]

Then

[
Np\mid D_{st}.
]

Moreover,

[
|h_{ss}h_{tt}|<p^2
]

while

[
|h_{st}h_{ts}|\ge p^2.
]

Therefore

[
D_{st}\ne0.
]

Consequently,

[
\Theta_{st}=\frac{D_{st}}N
]

is an explicit nonzero integer satisfying

[
p\mid\Theta_{st}.
]

This is unrestricted and exact.

### Why this does not prove the frozen lemma

The values (r_s), (h_{st}), and (\Theta_{st}) vary with (p) and with the particular failure. Their available bounds are proportional to (M):

[
|r_s|<Np,\qquad |h_{st}|\le\frac{Np}{2}.
]

Thus (\Theta_{st}) ranges over an a priori unbounded family. Its (p)-divisibility follows from the fact that it was constructed using lifts modulo (Np). It supplies no fixed integer whose prime divisors contain all bad primes.

After normalizing an anchor (v_j) to (N), the remaining normalized (p)-components are the projective invariants

[
\lambda_s
\equiv N,v_{\iota(s)},v_j^{-1}\pmod p,
]

up to independent sign. A bounded-signature proof must establish an (H_n) such that every (\lambda_s) has a signed lift (z_s) with

[
|z_s|\le H_n.
]

No such bound follows from the private-point equations. Once the anchor is fixed, common unit scaling cannot change the (\lambda_s).

### Exact CRT fiber form

For completeness, write a normalized owner as

[
\alpha=x\bmod p\in\mathbb F_p^\times,
\qquad
\beta=x\bmod N\in\mathbb Z/N\mathbb Z.
]

Write a residue (r) in CRT coordinates as ((a,b)), and let

[
y=[\alpha b]_p\in{0,\ldots,p-1}.
]

Then (r\in B_x) exactly when one of the following congruences is solvable:

[
\beta a\equiv y\pmod N,
]

or, when (y>0),

[
\beta a\equiv y-p\pmod N.
]

This description retains nonunits: if (d=\gcd(\beta,N)), each congruence has either no solutions or exactly (d) solutions.

For the anchor (x=N), (\beta=0). It therefore covers an entire (N)-point CRT fiber for certain (b), and no points in the other fibers.

This exact fiber normal form still contains the unbounded permutation (b\mapsto\alpha b) of (\mathbb F_p). Private-point minimality does not bound (\alpha).

### First fatal arrow

The attempted implication

[
\text{minimal complete cover}
\Longrightarrow
\text{bounded projective lifts }z_s
]

is not proved.

The alternative determinant route gives only the (p)-dependent (\Theta_{st}). The full determinant and the bounded annihilator both specialize to (0) on the first mandatory fixtures. Therefore Attack A stops before a finite, nonzero (\Delta_\sigma) is obtained.

---

## 7. Attack B: obstruction divisor/minor graph

A natural proposed graph would have:

* left vertices: private-point equations or selected minors;
* right vertices: irreducible integer factors of their lifted values;
* adjacency: factor divisibility.

The construction fails at the definition of a fixed right-hand universe.

For the universal cross-minor,

[
p\mid\Theta_{st},
]

but (\Theta_{st}) is generated only after (p), the failure tuple, the canonical cover, and the private residues are known. Its factorization may introduce a new prime (p) at every instance. Freezing those factors afterward would amount to listing the bad primes after seeing them.

For the full determinant, the two first mandatory matrices have

[
\det H=0.
]

Assigning all primes as factors of zero produces no finite divisor set. Assigning no factors gives a left vertex with empty neighborhood and immediately violates Hall.

More generally, rank deficiency over (\mathbb F_p) proves only that certain minors vanish modulo (p). To obtain a valid obstruction one must additionally prove a rank gap:

[
\operatorname{rank}_{\mathbb Q} A

>

\operatorname{rank}_{\mathbb F_p} A
]

for a matrix (A) whose integer entries are themselves selected from a finite (p)-independent set. Neither private-point minimality nor the modular-annihilator relation supplies that rank gap.

The fixture relations

[
-2(1)-1(2)+1(4)=0
]

and

[
-1(1)+1(3)+1(3)-1(5)=0
]

show the competing possibility: the modular dependence can already be an exact rational dependence, leaving no nonzero integer obstruction.

A Hall argument can select among existing nonzero fixed integers. It cannot turn zero relations or an unbounded (p)-dependent family of minors into a finite fixed divisor set.

This is the first fatal arrow for Attack B.

---

## 8. Distinct-prime extraction

This section is `proved-math` assuming the frozen obstruction lemma.

Let

[
D=D_n=\prod_{\sigma\in\Sigma_n}|\Delta_\sigma|>0
]

and

[
C=C_n=\binom{n+1}{2}.
]

Define

[
T=\min{Q\in\mathbb N:Q>0,\ n^nQ\ge C^{n(n-1)}}.
]

The defining set is nonempty, for example by taking (Q=C^{n(n-1)}).

Set (R_0=1), and recursively define

[
E_j=DR_j+1.
]

### 1. Least prime divisors exist

Since (D,R_j\ge1),

[
E_j\ge2.
]

The set of divisors of (E_j) greater than (1) is nonempty because it contains (E_j). Let (q_j) be its least member. If (q_j=ab) with (1<a,b<q_j), then (a\mid E_j), contradicting minimality. Therefore (q_j) is prime.

### 2. Coprimality with (D)

Any common divisor of (D) and (E_j) divides

[
E_j-DR_j=1.
]

Hence

[
\gcd(D,E_j)=1.
]

In particular,

[
q_j\nmid D.
]

### 3. Injectivity of the greedy primes

Define

[
R_{j+1}=R_jq_j.
]

For (i<j),

[
q_i\mid R_{i+1}\mid R_j.
]

If (q_i=q_j), then (q_i) divides both (DR_j) and

[
E_j=DR_j+1,
]

so (q_i\mid1), impossible. Thus

[
i\ne j\Longrightarrow q_i\ne q_j.
]

### 4. Existence of (m_n)

Since every (q_j\ge2),

[
R_j\ge2^j.
]

Therefore some (R_j) is at least (T). By well-ordering, there is a least such index (m_n).

### 5. Matching and Hall inequality

Let

[
L=\operatorname{Fin}m_n
]

and let (R) be the finite set of primes dividing some (E_j), (j<m_n). Put an edge (j\sim q) when (q\mid E_j).

The map

[
f(j)=q_j
]

is an edge-respecting injection. Hence it is a matching saturating the left side.

For any (S\subseteq L),

[
f(S)\subseteq\Gamma(S),
]

and injectivity gives

[
|\Gamma(S)|\ge|f(S)|=|S|.
]

This is Hall’s neighborhood inequality. Each demand is assigned a distinct prime, not a prime power.

### 6. Matched primes are good

If (q_j) were bad, the frozen obstruction lemma would give a signature (\sigma) such that

[
q_j\mid\Delta_\sigma.
]

Then (q_j\mid D), contradicting (q_j\nmid D). Therefore

[
\operatorname{PrimeForcing}(n,q_j)
]

holds for every matched prime.

### 7. Exact product

Induction on (m) gives

[
R_m=\prod_{j<m}q_j.
]

The factors are distinct primes. At (m=m_n),

[
R_{m_n}\ge T
]

and therefore

[
n^nR_{m_n}\ge C^{n(n-1)}.
]

The extraction contains no repeated primes and counts no prime power more than once.

---

## 9. Complete implication chain

Fix (n\ge3) and assume the Lonely Runner statement in every smaller moving dimension.

1. The one- and two-moving-speed base cases are `proved-lean`.

2. Assume a positive, injective (n)-speed counterexample exists.

3. Divide by the common gcd to obtain a primitive counterexample.

4. By the accepted deletion-gcd reduction under the lower-dimensional induction hypothesis,

   [
   \gcd{a_i:i\ne k}=1
   \quad\text{for every }k.
   ]

5. Apply the frozen obstruction lemma and Section 8 to obtain distinct primes

   [
   q_0,\ldots,q_{m_n-1}
   ]

   satisfying `PrimeForcing(n,q_j)` and

   [
   R_{m_n}=\prod_{j<m_n}q_j\ge T_n.
   ]

6. Let

   [
   P=\prod_{i<n}a_i.
   ]

   For a matched prime (q=q_j), suppose (q\nmid P). Put (M=Nq) and reduce each (a_i) modulo (M). Then:

   * (q\nmid a_i) for every (i);
   * every modular deletion gcd is (1);
   * `PrimeForcing(n,q)` gives (0\le r<M) satisfying

     [
     \rho_M(ra_i)\ge q
     \quad\text{for every }i.
     ]

   At time

   [
   t=\frac rM,
   ]

   this gives

   [
   |ta_i|
   =\frac{\rho_M(ra_i)}M
   \ge\frac q{Nq}
   =\frac1N,
   ]

   contradicting the counterexample. Therefore

   [
   q_j\mid P
   \quad\text{for every }j.
   ]

   This is the same modular prime-divisibility mechanism stated in Rosenfeld’s Lemma 3. ([arXiv][3])

7. Since the (q_j) are distinct,

   [
   R_{m_n}\mid P.
   ]

8. Consequently,

   [
   n^nP
   \ge n^nR_{m_n}
   \ge C_n^{n(n-1)}.
   ]

9. Rosenfeld’s stated product corollary to MSS says that, under the lower-dimensional LRC hypothesis, the weak inequality

   [
   P\ge
   \left[
   \frac{C_n^{,n-1}}n
   \right]^n
   =========

   \frac{C_n^{n(n-1)}}{n^n}
   ]

   is sufficient for the LR property. Thus a primitive counterexample must satisfy the strict reverse inequality. ([arXiv][3]) The project-level use of this published result remains `external-unformalized`.

10. This contradiction proves the positive-integer (n)-speed statement, conditional on the frozen obstruction lemma and the external MSS wrapper.

11. Induction gives positive-integer LRC for every (n), under those dependencies.

12. The existing `proved-lean` real/integer equivalence then transfers the result to real speeds.

The complete chain is therefore `conditional`, not `proved-lean`. The unrestricted conjecture remains open. ([arXiv][1])

---

## 10. Proof-obligation ledger and evidence boundary

| Obligation                                                         | Result                                             | Boundary                                   |
| ------------------------------------------------------------------ | -------------------------------------------------- | ------------------------------------------ |
| Preserve strict badness and equality safety                        | Completed                                          | `proved-math`                              |
| Preserve full cover and deletion premises under signs              | Completed                                          | `proved-math`                              |
| Preserve owner-subset covering under common unit scaling           | Completed                                          | `proved-math`                              |
| Handle coordinate permutations without corrupting canonical labels | Completed by not permuting before canonicalization | `proved-math`                              |
| Prove every selected owner has a private point                     | Completed                                          | `proved-math`                              |
| Prove a failure has an (N)-divisible selected owner                | Completed                                          | `proved-math`                              |
| Normalize that owner exactly to (N)                                | Completed                                          | `proved-math`                              |
| Retain repeated values and coincident sets                         | Completed in definitions and search                | `proved-math` / `computed finite evidence` |
| Retain nonunits without cancellation                               | Completed                                          | `proved-math`                              |
| Produce exact centered private equations                           | Completed                                          | `proved-math`                              |
| Produce an explicit nonzero (p)-divisible integer per failure      | Completed using (\Theta_{st}=D_{st}/N)             | `proved-math`                              |
| Make that integer independent of (p) and the failure               | Not completed                                      | `open`                                     |
| Bound every nonanchor projective residue by (H_n)                  | Not completed                                      | `open`                                     |
| Freeze a finite (\Sigma_n) before (p)                              | Not completed                                      | `open`                                     |
| Prove every (\Delta_\sigma\ne0)                                    | Not completed                                      | `open`                                     |
| Use the full private determinant                                   | Fails on both first fixtures                       | `rejected`                                 |
| Use a bounded exact annihilator                                    | Fails with exact value (0) on both first fixtures  | `rejected`                                 |
| Build a finite factor graph from the (p)-dependent minors          | Circular or prime-dependent                        | `rejected`                                 |
| Exhaustively search the two mandatory finite domains               | Completed                                          | `computed finite evidence`                 |
| Prove the distinct-prime matching and Hall inequality              | Completed conditionally                            | `proved-math`                              |
| Prove the threshold product calculation                            | Completed conditionally                            | `proved-math`                              |
| Integrate the MSS product theorem in Lean                          | Not performed                                      | `external-unformalized`                    |
| Prove unrestricted LRC                                             | Not achieved                                       | `open`                                     |

No tracked repository was edited. No recovered attachment was executed. The two linked files were generated independently for this audit. The finite searches do not promote any unrestricted claim.

[1]: https://arxiv.org/html/2607.16082v2 "Lonely runners in real life: Sharp bounds for time-dependent velocities"
[2]: https://www.cambridge.org/core/journals/forum-of-mathematics-sigma/article/linearly-exponential-checking-is-enough-for-the-lonely-runner-conjecture-and-some-of-its-variants/A51A991DE89B8C9C2E2FF13FBD4501DA "Linearly exponential checking is enough for the lonely runner conjecture and some of its variants | Forum of Mathematics, Sigma | Cambridge Core"
[3]: https://arxiv.org/html/2512.01912v2 "The lonely runner conjecture holds for nine runners"
