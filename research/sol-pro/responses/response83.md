## 1. **Disposition**

`STOP`

No surviving Prompt76-80 lemma satisfies all four selection criteria.

The strongest reusable result is `DIVISOR-BLOCK-WITNESS-LIFT`, but it is conditional on the existence of a strict divisor block and a survivor witness. The proposed universal block-existence theorem is false, already on ((1,3,16)), and in fact on the stated infinite family. Thus the local lifting theorem leaves the same missing existential decomposition premise.

The Prompt79 cross-minor lemma is also nontrivial, but it produces only a nonzero integer (\Theta(p,v)) divisible by the current prime (p), with size and definition depending on (p) and the failure tuple. It does not narrow the required uniform edge

[
\exists H_n,\Sigma_n\text{ fixed before }p,v.
]

The remaining survivors are finite-cover bookkeeping, route-specific counterexample structure, or necessary obstructions without a positive selector. There is no implementation candidate.

---

## 2. **Evidence-scope audit**

| Evidence class                | Material admitted at that class                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| ----------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `proved-lean`                 | Real LRC (\leftrightarrow) positive-integer LRC; positive-integer LRC (\leftrightarrow) exact pivot-certificate existence; one- and two-speed cases; common-gcd normalization; coefficient-three bounded-height theorem; selected deletion-certificate lifting at its stated exceptional inequality.                                                                                                                                                                |
| `proved-math-qualified`       | Prompt76 counterexample and local canonical-cover facts; Prompt77 infinite signed-Gram counterfamily and its two stated local facts; Prompt78 sparse-cover counterexample and its cover/private/blocker facts.                                                                                                                                                                                                                                                      |
| `response-authored/rederived` | Prompt79 evaluation at (r=p), the bound (p>N), CRT normalization, modular rank-one minors, nonzero (Np)-divisible cross-minors, and the conditional Euclidean prime extraction. Prompt80 canonical failures for ((1,3,16)), all six divisor-block checks, the stated infinite family, orbit-capacity counting, and `DIVISOR-BLOCK-WITNESS-LIFT`. These are independently rederived below but remain `external-unformalized` until separately audited or formalized. |
| Unverified computation        | Every response-authored scan, first-failure claim, source/output hash claim, timing claim, and attachment claim. None is used. The displayed hashes are not treated as mathematical evidence.                                                                                                                                                                                                                                                                       |
| `rejected`                    | Prompt76 global demand-capacity inequality; Prompt77 primitive six-mode positive-gap theorem; Prompt78 sparse/canonical owner escape; Prompt80 universal strict-divisor-block existence.                                                                                                                                                                                                                                                                            |
| `open`                        | Prompt79 finite (p)-independent obstruction set or fixed bad-prime divisor (D); every repaired global pivot-selection lemma; exact unrestricted pivot-certificate existence; unrestricted LRC.                                                                                                                                                                                                                                                                      |

No finite scan is promoted. All arithmetic checks below are direct calculations from the definitions.

---

## 3. **Counterexample verification**

### Prompt76: global private-demand transport

For

[
a=(1,4,5,6,7,11),\qquad n=6,\qquad N=7,
]

the exact pivot data are:

| Pivot (p_j) | (M_j) | (Q_j)         | (G_j) | Canonical owners | Private sizes   | Demand | Capacity row |
| ----------: | ----: | ------------- | ----: | ---------------- | --------------- | -----: | -----------: |
|           1 |     7 | (\varnothing) |     0 | ({7})            | (6)             |      6 |           26 |
|           4 |    28 | (\varnothing) |     0 | ({1,5,6,7,11})   | (6,4,2,6,4)     |     22 |           20 |
|           5 |    35 | (\varnothing) |     0 | ({1,4,6,7,11})   | (4,4,4,6,4)     |     22 |           26 |
|           6 |    42 | ({13,29})     |     2 | none             | none            |   none |         none |
|           7 |    49 | ({15,34})     |     2 | none             | none            |   none |         none |
|          11 |    77 | (\varnothing) |     0 | ({1,4,5,6,7})    | (12,8,10,10,10) |     50 |           26 |

Thus

[
\operatorname{PrivateDemand}=6+22+22+50=100.
]

The external-capacity rows come from the two good pivots 6 and 7:

[
\begin{aligned}
C_1&=\frac6{\gcd(1,6)}2+\frac7{\gcd(1,7)}2=12+14=26,\
C_4&=\frac6{\gcd(4,6)}2+\frac7{\gcd(4,7)}2=3\cdot2+7\cdot2=20,\
C_5&=6\cdot2+7\cdot2=26,\
C_{11}&=6\cdot2+7\cdot2=26.
\end{aligned}
]

Therefore

[
\operatorname{ExternalCapacity}=26+20+26+26=98,
]

so the asserted inequality fails:

[
100>98.
]

The local row failure is already

[
22>20
]

at pivot (4). The nonunit owner is retained correctly:

[
w(4,6)=\frac6{\gcd(4,6)}=3.
]

For the pivot-6 certificate (r=13), (7\nmid13), and modulo (42),

[
\begin{array}{c|rrrrrr}
a_i&1&4&5&6&7&11\ \hline
\rho_{42}(13a_i)&13&10&19&6&7&17
\end{array}
]

Every value is at least (6). The pivot coordinate has equality (6=p_j), which is safe because badness is strict.

**Premise:** (F(a)\neq\varnothing).
**Rejected conclusion:** (\operatorname{PrivateDemand}\le\operatorname{ExternalCapacity}).
**Actual conclusion:** (100>98), while (Q_6) and (Q_7) are nonempty.

---

### Prompt77: primitive six-mode signed-Gram gap

Let

[
a=(u,v,4uv),\qquad 6\le u<v,\qquad \gcd(u,v)=1.
]

It is primitive because the total gcd is (1), although it is not pairwise coprime.

At pivot (u), the modulus is (4u), and (4u\mid4uv). Hence

[
B_{4uv}^{,u}=R_u.
]

Therefore

[
w_u=1_{R_u}-1_{B_v^u}-1_{R_u}=-1_{B_v^u},
]

and

[
K_u=-\frac1{4u}V(B_v^u)^*V(B_v^u)\preceq0.
]

Likewise,

[
K_v=-\frac1{4v}V(B_u^v)^*V(B_u^v)\preceq0.
]

At the third pivot, (p_3=4uv) and

[
M_3=16uv.
]

The indicator of (R_3) has period (4), hence repetition count (4uv). The indicator of (B_u^3) has period (16v), hence repetition count (u). The indicator of (B_v^3) has period (16u), hence repetition count (v). All three repetition counts exceed the largest retained nonzero literal frequency (5).

For every nonzero difference (d=l-m) with (|d|\le5), each periodic Fourier sum vanishes because its repetition count does not divide (d).

The zero-frequency counts are

[
|R_3|=12uv,\qquad |B_u^3|=6uv,\qquad |B_v^3|=6uv.
]

For example, after dividing the (u)-coordinate condition by (u), one period has modulus (16v). The strict arc

[
\rho_{16v}(r)<4v
]

contains (6v) residues not divisible by (4). Repetition over (u) periods gives (6uv).

Consequently the zero-frequency signed weight is

[
12uv-6uv-6uv=0.
]

All matrix entries vanish:

[
K_3=0.
]

For the first member ((6,7,168)):

* At pivot (6),

  [
  B_7^6={3,7,10,11,13,14,17,21}.
  ]

* At pivot (7),

  [
  B_6^7={1,5,9,10,13,14,15,18,19,23,27}.
  ]

Each support contains at least six distinct roots of unity. The corresponding six-column Vandermonde matrix has full rank, so (K_1) and (K_2) are negative definite, not merely nonpositive.

The first two good sets are empty because speed (168) covers their complete candidate sets.

For pivot (168), write (r=s+16t), with (s\in{0,\ldots,15}) and (4\nmid s). CRT separates (t\bmod6) and (t\bmod7). The intersection count is:

| Allowed (s\bmod16) | Choices for the modulus-(7) condition | Choices for the modulus-(6) condition |  Contribution |
| ------------------ | ------------------------------------: | ------------------------------------: | ------------: |
| (1,2,3,13,14,15)   |                                     3 |                                     3 |  (6\cdot9=54) |
| (5,6,7,9,10,11)    |                                     4 |                                     3 | (6\cdot12=72) |

Thus

[
|B_6^{168}\cap B_7^{168}|=54+72=126.
]

Since

[
|Q_3|
=|R_3|-|B_6^3|-|B_7^3|+|B_6^3\cap B_7^3|
=|B_6^3\cap B_7^3|,
]

the exact vector is

[
G=(0,0,126).
]

For (r=29), modulo (672),

[
\bigl(\rho(29\cdot6),\rho(29\cdot7),\rho(29\cdot168)\bigr)
=(174,203,168).
]

All are at least (168), and (4\nmid29). Again the pivot coordinate is exactly at the safe boundary.

**Premise:** positive, injective, primitive tuple.
**Rejected conclusion:** some six-mode block has a positive signed-energy direction.
**Actual conclusion:** (K_1\prec0), (K_2\prec0), and (K_3=0) for the first member; the whole family satisfies (K_1,K_2\preceq0) and (K_3=0).

---

### Prompt78: sparse minimal-cover owner escape

For

[
a=(6,7,12,24,144),\qquad n=5,\qquad N=6,
]

consider pivot (7), with modulus (42). Writing each divisible speed as (6d), strict badness is equivalent to

[
rd\bmod7\in{0,1,6}.
]

This gives:

| Owner speed | Bad residue classes modulo (7) |
| ----------: | ------------------------------ |
|           6 | ({0,1,6})                      |
|          12 | ({0,3,4})                      |
|          24 | ({0,2,5})                      |
|         144 | ({0,2,5})                      |

Classes (1,6) force owner (6); classes (3,4) force owner (12); and classes (2,5) require at least one of (24,144). Therefore the complete covers are exactly

[
{6,12,24},\qquad
{6,12,144},\qquad
{6,12,24,144}.
]

The first two are inclusion-minimal. The canonical least cover is

[
C={6,12,24}.
]

For each fixed class modulo (7), there are six residues modulo (42), exactly one of which is excluded as a multiple of (6). Each owner has two private classes, so every owner-labelled private set has size

[
2\cdot5=10.
]

Nevertheless,

[
36=6\cdot6\mid144,\qquad
72=6\cdot12\mid144,\qquad
144=6\cdot24\mid144.
]

Thus at each owner pivot (p\in{6,12,24}),

[
B_{144}^{p}=R_p,
]

and

[
Q_6=Q_{12}=Q_{24}=\varnothing.
]

Pivot (7) is covered by the displayed three-owner cover, so (Q_7=\varnothing).

At pivot (144), the first three nonpivot divisibility conditions reduce to

[
\rho_{144}(r)\ge24,\qquad
\rho_{72}(r)\ge12,\qquad
\rho_{36}(r)\ge6,
]

with (6\nmid r). Their intersection modulo (144) consists of the 40 residues

[
\begin{aligned}
&25!:!29,\quad43!:!47,\quad49!:!53,\quad55!:!59,\
&85!:!89,\quad91!:!95,\quad97!:!101,\quad115!:!119.
\end{aligned}
]

For each such residue (s), the six lifts are (s+144k), (0\le k<6). Multiplication by (7) gives six phases spaced by (144). Since (7s\not\equiv0\pmod{144}), exactly two phases lie in the strict bad arc (\rho_{864}<144), leaving four safe lifts.

Hence

[
G_{144}=40\cdot4=160,
]

and

[
G=(0,0,0,0,160).
]

For (r=25),

[
\begin{array}{c|rrrrr}
a_i&6&7&12&24&144\ \hline
\rho_{864}(25a_i)&150&175&300&264&144
\end{array}
]

so (r=25) is a valid pivot-144 certificate.

**Premise:** qualifying sparse inclusion-minimal canonical cover.
**Rejected conclusion:** some selected owner has a nonempty good set at its own pivot.
**Actual conclusion:** all three canonical owners have empty good sets, blocked by the omitted speed (144).

---

### Prompt79: prime-independent obstruction extraction

Let (M=Np).

#### General local arguments

At (r=p),

[
\rho_{Np}(p v_i)
=p,\rho_N(v_i).
]

This is strictly below (p) exactly when (N\mid v_i). Therefore every complete bad-set cover contains at least one (N)-divisible owner.

At (r=N),

[
\rho_{Np}(Nv_i)
=N,\rho_p(v_i).
]

Since (p\nmid v_i), this is at least (N). If (p\le N), it is at least (p), producing a safe residue. Thus every bad prime satisfies

[
p>N.
]

Suppose a selected (N)-divisible owner has value (Nt), with (p\nmid t). Since (\gcd(N,p)=1), choose a common unit (u) satisfying

[
u\equiv t^{-1}\pmod p,\qquad u\equiv1\pmod N.
]

Then

[
uNt\equiv N\pmod{Np}.
]

Multiplication by the common unit only reparametrizes the residue variable, while independent signs preserve every bad set because (\rho_M(-x)=\rho_M(x)).

A one-owner complete cover is impossible. If (g=\gcd(M,x)), then (p\nmid x) implies (g\mid N). The image of multiplication by (x) contains a point at cyclic distance

[
g\left\lfloor\frac{M/g}{2}\right\rfloor\ge p
]

because (N\ge4) and (p>N). Hence the canonical minimal cover has at least two owners.

For least private residues (r_s) and selected values (x_t), define centered representatives by

[
r_sx_t=Np,q_{st}+h_{st},
\qquad -\frac{Np}{2}<h_{st}\le\frac{Np}{2}.
]

Modulo (N) and modulo (p),

[
h_{st}\equiv r_sx_t,
]

so (H=(h_{st})) has rank at most one over each modulus. Every (2\times2) minor is therefore divisible by both (N) and (p), hence by (Np).

Privacy gives

[
|h_{ss}|<p,\qquad |h_{st}|\ge p\quad(s\ne t).
]

For distinct (s,t),

[
D_{st}=h_{ss}h_{tt}-h_{st}h_{ts}.
]

The first product has absolute value below (p^2), while the second has absolute value at least (p^2). Therefore (D_{st}\ne0). Also,

[
Np\mid D_{st}.
]

Consequently

[
\Theta_{st}=\frac{D_{st}}N
]

is nonzero and divisible by (p).

This is a valid local obstruction, but (h_{st}), (D_{st}), and (\Theta_{st}) all depend on (p) and on the failure tuple. It gives no fixed finite obstruction domain.

#### Fixture 1

[
(n,p,v)=(3,5,(1,3,4)),\qquad N=4,\qquad M=20.
]

The domain conditions hold:

* (5\nmid1,3,4);
* deleting any coordinate leaves values whose joint gcd with (20) is (1).

The strict bad-set sizes are (9,9,12), their union has size (20), and all three owners are necessary. Their least private residues are (2,7,5). This gives

[
H=
\begin{pmatrix}
2&6&8\
7&1&8\
5&-5&0
\end{pmatrix}.
]

Its columns satisfy

[
C_3=C_1+C_2,
]

so

[
\det H=0.
]

The first cross-minor is

[
2\cdot1-6\cdot7=-40.
]

Thus

[
Np=20\mid-40,\qquad
\Theta=-40/4=-10,\qquad
5\mid-10.
]

The displayed bounded scalar relation also vanishes:

[
-2\cdot1-1\cdot2+1\cdot4=0.
]

#### Fixture 2

[
(n,p,v)=(4,7,(1,3,4,5)),\qquad N=5,\qquad M=35.
]

Again the divisibility and deletion-gcd hypotheses hold. The strict bad-set sizes are (13,13,13,15), their union has size (35), and all four owners are necessary. Their least private residues are (3,11,9,7). Hence

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
C_3=C_1+C_2,
]

so

[
\det H=0.
]

The first cross-minor is

[
3(-2)-9(11)=-105.
]

Thus

[
Np=35\mid-105,\qquad
\Theta=-105/5=-21,\qquad
7\mid-21.
]

The displayed bounded relation is also zero:

[
-1+3+3-5=0.
]

**Premise:** genuine bad-prime fixtures with canonical private data.
**Attempted conclusion:** fixed (p)-independent nonzero obstruction data.
**Actual conclusion:** full determinants and displayed bounded annihilators vanish; nonzero minors exist but are proportional to the current prime and arise from unbounded centered lifts. The finite-obstruction theorem remains open, not refuted.

---

### Prompt80: universal strict divisor-block existence

Take

[
a=(1,3,16),\qquad n=3,\qquad N=4.
]

#### Canonical deletion certificates

| Deleted speed | Canonical pivot | (r) | Modulus | Survivor checks                          | Exceptional centered residue | Failure     |
| ------------: | --------------: | --: | ------: | ---------------------------------------- | ---------------------------: | ----------- |
|             1 |               3 |   2 |       9 | (\rho_9(2\cdot3)=3,\ \rho_9(2\cdot16)=4) |          (2\cdot1=0\cdot9+2) | (4\cdot2<9) |
|             3 |               1 |   1 |       3 | (\rho_3(1)=1,\ \rho_3(16)=1)             |          (1\cdot3=1\cdot3+0) | (4\cdot0<3) |
|            16 |               3 |   4 |       9 | (\rho_9(4)=4,\ \rho_9(4\cdot3)=3)        |         (4\cdot16=7\cdot9+1) | (4\cdot1<9) |

The canonical order is correct:

* After deleting (1), pivot (3) with (r=1) fails on speed (16), while (r=2) succeeds.
* After deleting (3), pivot (1), (r=1), is immediately valid.
* After deleting (16), pivot (1) is impossible because the survivor speed (3) is always zero modulo (3); at pivot (3), (r=1,2) fail on speed (1), and (r=4) is first.

Thus every canonical lift fails strictly.

#### All nonempty proper exceptional sets

| Exceptional (S) | Survivor (T) | (d) | Capacities | Sum versus (d) |
| --------------- | ------------ | --: | ---------- | -------------- |
| ({1})           | ({3,16})     |   1 | (1)        | (1=d)          |
| ({3})           | ({1,16})     |   1 | (1)        | (1=d)          |
| ({16})          | ({1,3})      |   1 | (1)        | (1=d)          |
| ({1,3})         | ({16})       |  16 | (8+8)      | (16=d)         |
| ({1,16})        | ({3})        |   3 | (2+2)      | (4>d)          |
| ({3,16})        | ({1})        |   1 | (1+1)      | (2>d)          |

No row satisfies the required strict inequality.

For example, with (S={1,3}), both exceptional speeds are coprime to (d=16), so each capacity is

[
\left\lceil\frac{2\cdot16}{4}\right\rceil=8.
]

The sum is exactly (16), not strictly below (16).

The tuple nevertheless has a witness at (t=5/11):

[
\operatorname{dist}(5/11)=5/11,\qquad
\operatorname{dist}(15/11)=4/11,\qquad
\operatorname{dist}(80/11)=3/11,
]

all strictly above (1/4).

#### Infinite family rederivation

Let

[
a=(1,3,L),\qquad L>5,\qquad4\mid L,\qquad
L\bmod36\in{4,16,20,32}.
]

Then

[
L\bmod9\in{4,7,2,5},\qquad 3\nmid L.
]

After deleting (1), canonical pivot (3) uses:

[
r=
\begin{cases}
1,&L\bmod9\in{4,5},\
2,&L\bmod9\in{7,2}.
\end{cases}
]

The exceptional centered residue is (r), and (4r<9).

After deleting (3), pivot (1), (r=1), is canonical because (L\not\equiv0\pmod3). The exceptional residue from speed (3) is zero.

After deleting (L), pivot (1) is impossible because the survivor speed (3) is zero modulo (3). Pivot (3), (r=4), is canonical. The centered values of (4L\bmod9) for the four residue classes are

[
-2,\quad1,\quad-1,\quad2,
]

whose absolute values are (2,1,1,2). In every case,

[
4|h|<9.
]

For singleton exceptional sets, the two survivors have gcd (1), giving capacity exactly (1). For (S={1,3}), the survivor gcd is (L); both exceptions are coprime to (L), and since (L) is divisible by (4),

[
2\left\lceil\frac L2\right\rceil=L.
]

The other two-element exceptional sets give sums strictly above (d). Thus no family member has a strict divisor block.

This independently rederives the stated infinite counterfamily, but it remains `external-unformalized` until audited.

**Premise:** primitive hard canonical-failure tuple.
**Rejected conclusion:** existence of a strict divisor block.
**Actual conclusion:** all canonical lifts fail, but every proper exceptional set has capacity at least (d).

---

## 4. **Dependency map**

| ID   | Surviving local lemma                                                                                                                               | Dependencies                                 | Immediate consumer                      | First nonclosed downstream arrow                                                            |
| ---- | --------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------- | --------------------------------------- | ------------------------------------------------------------------------------------------- |
| 76-A | A covered pivot has a finite nonempty complete-cover family.                                                                                        | Finite (R_j), (G_j=0).                       | Canonical-cover definition.             | Global comparison between local cover data and another pivot.                               |
| 76-B | Injective speeds make the least cover under cardinality and increasing speed list unique.                                                           | 76-A, injectivity.                           | Canonical owner selection.              | Same as 76-A.                                                                               |
| 76-C | Least cardinality implies inclusion-minimality.                                                                                                     | Finite cover family.                         | Private-set nonemptiness.               | Same as 76-A.                                                                               |
| 76-D | Every selected owner in an inclusion-minimal labelled cover has nonempty relative privacy.                                                          | Owner-labelled finite sets.                  | `PrivateDemand`.                        | `PrivateDemand <= ExternalCapacity`, which is `rejected`.                                   |
| 76-E | The two finite reindexings of `ExternalCapacity` agree.                                                                                             | Finite-sum reindexing.                       | Accounting only.                        | No inequality follows.                                                                      |
| 77-A | For the family ((u,v,4uv)), the third-pivot good count equals the bad-set overlap and is positive.                                                  | Exact cardinality balance.                   | Family-specific certificate existence.  | Extension from this explicit family to arbitrary tuples is `open`.                          |
| 77-B | A zero-total signed periodic support with repetition count above the largest retained nonzero frequency has zero truncated Gram block.              | Geometric-series cancellation.               | Detects failure of fixed literal modes. | A positive scale-adaptive spectral selector is `open`; the six-mode selector is `rejected`. |
| 78-A | A finite labelled cover is inclusion-minimal iff every relative owner-labelled private set is nonempty.                                             | Elementary finite-set argument.              | Sparse-cover structure.                 | Owner escape is `rejected`.                                                                 |
| 78-B | Canonical least covers exist uniquely and are inclusion-minimal.                                                                                    | Same as 76-A-C.                              | Canonical sparse-cover strategies.      | Canonical owner escape is `rejected`.                                                       |
| 78-C | If (Np\mid c), then (B_c^p=R_p) and (Q_p=\varnothing). The same omitted (c) can block every owner satisfying (Na_i\mid c).                          | Direct modular divisibility.                 | Necessary blocker exclusion.            | A blocker-free positive owner selector is `open`; blocker absence is not sufficient.        |
| 79-A | Every bad-prime cover contains an (N)-divisible owner.                                                                                              | Evaluation at (r=p).                         | CRT normalization.                      | Uniform bounded projective data is `open`.                                                  |
| 79-B | Every bad prime has (p>N).                                                                                                                          | Evaluation at (r=N).                         | Separates (N) and (p) arithmetically.   | Same uniformity edge.                                                                       |
| 79-C | One selected (N)-divisible owner can be normalized exactly to (N).                                                                                  | 79-A, 79-B, CRT, unit invariance.            | Centered-lift matrix.                   | Same uniformity edge.                                                                       |
| 79-D | Private centered lifts produce nonzero (Np)-divisible cross-minors.                                                                                 | Inclusion-minimal privacy, modular rank one. | Candidate bad-prime obstruction.        | A fixed (p)-independent bound or finite (\Sigma_n) is `open`.                               |
| 79-E | Given a fixed (D) divisible by every bad prime, Euclidean extraction supplies distinct primes avoiding (D) and crosses any fixed product threshold. | Elementary divisibility and induction.       | Good-prime supply.                      | Construction of such a fixed (D) is `open`.                                                 |
| 80-A | Among (d) shifts, exceptional coordinate (k) excludes at most (g_k\lceil2q_k/N\rceil) shifts.                                                       | Equally spaced phases, open bad arc.         | Divisor-block lift.                     | Existence of sufficient strict capacity slack.                                              |
| 80-B | A strict divisor block plus a survivor witness lifts to a full witness.                                                                             | 80-A and survivor phase invariance.          | Full LRC witness.                       | Universal strict-block-and-survivor selection is false as stated and otherwise `open`.      |

The Prompt76 and Prompt78 canonical-cover facts overlap. Their duplication does not create a new cross-route inference.

---

## 5. **Equivalence and tautology audit**

### Exact pivot unfolding

For (r\in R_j),

[
\rho_{Na_j}(ra_j)=a_j,\rho_N(r)\ge a_j
]

because (N\nmid r). Therefore

[
r\in Q_j
]

is exactly the condition that every nonpivot coordinate is safe, while the pivot coordinate is automatically safe.

Hence

[
\exists j,\ Q_j\ne\varnothing
]

is the exact finite pivot certificate. By the accepted Lean equivalences,

[
\exists j,\ Q_j\ne\varnothing
\iff
\text{positive-integer LRC for }a
\iff
\text{real LRC}.
]

Any purported lemma whose conclusion is only (\exists j,Q_j\ne\varnothing), without a strictly stronger independently checkable premise, merely restates the open theorem.

### Private-set circularity

Relative privacy is

[
B_i^j\setminus\bigcup_{\substack{h\in C\h\ne i}}B_h^j.
]

It excludes only the other selected owners. An omitted owner can cover every such point. Treating relative privacy as global safety is invalid. Prompt78 gives an exact realization: omitted speed (144) blocks every canonical owner pivot.

### Prime-dependent obstruction circularity

The valid Prompt79 quantifiers are

[
\forall p,v\text{ failure},\quad
\exists\Theta(p,v)\ne0,\quad p\mid\Theta(p,v).
]

The needed quantifiers are of the form

[
\exists H_n,\Sigma_n\text{ fixed first},\quad
\forall p,v\text{ failure},\quad
\exists\sigma\in\Sigma_n\text{ realized by }(p,v).
]

Defining (\Delta) from (p), from the failure tuple, from an unbounded centered lift, or from the collection of all bad primes reverses the required quantifiers. It does not construct a finite obstruction.

### Divisor-block circularity

`DIVISOR-BLOCK-WITNESS-LIFT` is valid after a strict block has been supplied. Assuming such a block for every hard tuple is unavailable and false in the proposed form. Defining the exceptional set from a previously known full witness would invoke the desired conclusion backward.

### Gcd controls

Primitive common gcd one does not imply pairwise coprimality. For example,

[
\gcd(6,7,168)=1,
]

but

[
\gcd(6,168)=6,\qquad \gcd(7,168)=7.
]

No argument may replace common-gcd normalization by pairwise invertibility.

### Strict boundary

The bad predicate is

[
\rho<p.
]

Thus:

[
\rho=p-1\quad\text{is bad},\qquad
\rho=p\quad\text{is safe}.
]

The supplied certificates repeatedly use equality at the pivot. Replacing `<` by `<=` would destroy valid certificates and change the theorem.

### Owner labels and multiplicity

At Prompt78 pivot (7),

[
B_{24}^7=B_{144}^7
]

as unlabelled subsets, but they are different owner-labelled sets. The two minimal covers

[
{6,12,24},\qquad{6,12,144}
]

must remain distinct. Collapsing coincident sets changes private ownership and canonical selection.

Prompt79 also permits repeated residue values. Its tie-breaking therefore cannot be quotiented to an unlabelled residue multiset.

### Shared missing selection edges

| Proposed repair phrase          | Actual remaining statement                                                         | Audit                                                                                                                                 |
| ------------------------------- | ---------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| “Transport all private demand”  | Prove a global inequality strong enough to force some (G_k>0).                     | Exact proposed inequality is false: (100>98).                                                                                         |
| “Exclude the divisible blocker” | After removing blocked owners, prove some remaining owner has (Q_i\ne\varnothing). | Blocker absence is not sufficient. Prompt78 pivot (7) and Prompt76 pivots (4,5,11) are covered without a divisible singleton blocker. |
| “Bound the projective residues” | Produce (H_n,\Sigma_n) independent of (p,v).                                       | This is exactly Prompt79’s first open uniformity arrow.                                                                               |
| “Find a strict divisor block”   | Select (S) with strict capacity and a survivor witness for every tuple.            | The stated universal selector is false on ((1,3,16)) and the rederived family.                                                        |
| “Choose a good cover owner”     | Prove one selected owner already satisfies (Q_i\ne\varnothing).                    | The sparse and canonical versions are false.                                                                                          |

These routes are not all syntactically equivalent, but after their valid local lemmas they retain the same kind of unresolved global quantifier: select uniformly, from arbitrary simultaneous coverage data, a pivot or auxiliary structure that forces noncoverage. None of the surviving declarations supplies that selection.

---

## 6. **Ranked survivor table**

Ranking is by distance to a full unrestricted witness first, then likelihood of closing a genuine remaining edge, then formalizability and independent value.

| Rank | Survivor                                            | Distance to unrestricted LRC                                         | Probability of closing a genuine edge without a new theorem                                           | Formalizability | Falsification status                                                     | Disposition  |
| ---: | --------------------------------------------------- | -------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- | --------------- | ------------------------------------------------------------------------ | ------------ |
|    1 | 80-B `DIVISOR-BLOCK-WITNESS-LIFT`                   | Very close conditionally: its conclusion is already a full witness.  | Low. The universal strict-block premise is false; a replacement selector is wholly new.               | High            | Local theorem survives; universal consumer rejected.                     | No selection |
|    2 | 79-D nonzero (Np)-divisible private cross-minor     | Auxiliary arithmetic route, still before fixed bad-prime control.    | Low. It supplies no (p)-independent bound or finite domain.                                           | High            | Survives both fixtures; full determinants and bounded annihilators fail. | No selection |
|    3 | 79-E Euclidean extraction from fixed (D)            | Potentially useful after all bad primes are already confined to (D). | Very low as progress on the missing edge, because construction of (D) is the entire unresolved input. | High            | Correct conditionally.                                                   | No selection |
|    4 | 78-C divisible singleton blocker                    | Directly concerns exact pivot grids.                                 | Very low. It only rules owners out and has no positive converse.                                      | High            | Survives; insufficiency shown by Prompt76 and Prompt78.                  | No selection |
|    5 | 76-A-E / 78-A-B canonical-cover and privacy package | Directly on the exact pivot bottleneck.                              | Very low. The proposed quantitative transport and owner escape are both false.                        | High            | Local bookkeeping survives.                                              | No selection |
|    6 | 77-B periodic annihilation                          | Fixed (n=3), spectral obstruction only.                              | Very low. It explains why finite literal modes fail rather than selecting a pivot.                    | High            | Survives entire counterfamily.                                           | No selection |
|    7 | 77-A balanced overlap                               | Certifies one explicit infinite family.                              | None for unrestricted tuples without a new classification theorem.                                    | High            | Survives exactly at family scope.                                        | No selection |

No rank satisfies all four selection criteria.

---

## 7. **Exact surviving lemma or no-selection certificate**

### No-selection certificate

Every surviving declaration falls into one of the following exhaustive classes:

1. **Elementary finite-set infrastructure:** 76-A-E and 78-A-B. These fail criterion (i).
2. **Family-specific positive information:** 77-A. It proves certificates only for the explicit ((u,v,4uv)) family and fails criterion (iv).
3. **Negative structural obstructions:** 77-B and 78-C. They identify failed methods or blocked owners but do not imply any positive pivot choice, so they fail criterion (iv).
4. **Prime-dependent arithmetic necessity:** 79-A-D. The first open edge remains the same (p)-independent finite-obstruction quantifier, so criterion (iv) fails.
5. **Conditional extraction after the missing object is supplied:** 79-E. It assumes the fixed integer (D) that the route was required to construct, so criterion (iii) fails.
6. **Conditional full-witness infrastructure:** 80-A-B. It assumes a strict divisor block and survivor witness, while universal strict-block existence is rejected. It therefore fails criterion (iii).

Accordingly, there is no exact unrestricted declaration-level lemma that materially narrows the open pivot-selection edge.

The best reusable infrastructure is `DIVISOR-BLOCK-WITNESS-LIFT`, but it leaves the same existential premise and is not selected.

---

## 8. **Complete implication chain**

### Prompt76 route

[
\begin{aligned}
&\text{canonical-cover/private-set facts}\
&\quad [\text{independently reproved here; source proved-math-qualified}]\
&\longrightarrow
\boxed{\text{GLOBAL-CANONICAL-PRIVATE-DEFICIT-HALL}}\
&\quad [\textbf{rejected: }100>98]\
&\longrightarrow
\exists j,\ Q_j\ne\varnothing
\quad[\text{conditional elementary implication}]\
&\longleftrightarrow
\text{positive-integer LRC}
\quad[\text{proved-lean}]\
&\longleftrightarrow
\text{unrestricted real LRC}
\quad[\text{proved-lean}].
\end{aligned}
]

The first nonclosed arrow is rejected, not merely open.

### Prompt77 route

[
\begin{aligned}
&\text{periodic-annihilation lemma}\
&\quad[\text{independently reproved here; source proved-math-qualified}]\
&\longrightarrow
\boxed{\text{positive scale-adaptive spectral selector}}\
&\quad[\textbf{open};\ \text{literal six-mode version rejected}]\
&\longrightarrow
\exists j,\ Q_j\ne\varnothing\text{ for }n=3
\quad[\text{conditional}]\
&\longleftrightarrow
\text{positive-integer LRC for }n=3
\quad[\text{proved-lean at fixed dimension}]\
&\longleftrightarrow
\text{real LRC for }n=3
\quad[\text{proved-lean at fixed dimension}]\
&\longrightarrow
\text{unrestricted all-dimensional real LRC}
\quad[\text{open dimension extension}].
\end{aligned}
]

The first open arrow is the positive spectral selector. Periodic annihilation points in the opposite direction.

### Prompt78 route

[
\begin{aligned}
&\text{divisible-singleton blocker}\
&\quad[\text{independently reproved here; source proved-math-qualified}]\
&\longrightarrow
\boxed{\text{blocker-free owner-escape selector}}\
&\quad[\textbf{open};\ \text{original sparse and canonical selectors rejected}]\
&\longrightarrow
\exists j,\ Q_j\ne\varnothing
\quad[\text{conditional}]\
&\longleftrightarrow
\text{positive-integer LRC}
\quad[\text{proved-lean}]\
&\longleftrightarrow
\text{unrestricted real LRC}
\quad[\text{proved-lean}].
\end{aligned}
]

The first open arrow is still a global owner/pivot selector. Merely excluding divisibility does not make it more specific enough to be solvable from the local lemma.

### Prompt79 route

[
\begin{aligned}
&\text{(N)-divisible owner, normalization, private cross-minor}\
&\quad[\text{independently reproved here}]\
&\longrightarrow
\boxed{\text{fixed (p)-independent finite (\Sigma_n) or divisor (D)}}\
&\quad[\textbf{open}]\
&\longrightarrow
\text{distinct primes avoiding all bad-prime divisors}\
&\quad[\text{conditional; extraction independently reproved here}]\
&\longrightarrow
\text{prime-product threshold implies pivot certificate}\
&\quad[\text{external-unformalized within this self-contained prompt}]\
&\longrightarrow
\exists j,\ Q_j\ne\varnothing
\quad[\text{conditional}]\
&\longleftrightarrow
\text{positive-integer LRC}
\quad[\text{proved-lean}]\
&\longleftrightarrow
\text{unrestricted real LRC}
\quad[\text{proved-lean}].
\end{aligned}
]

The first open arrow is exactly the original uniformity problem. The cross-minor lemma does not alter it.

### Prompt80 route

[
\begin{aligned}
&\text{exceptional orbit-capacity bound}\
&\quad[\text{independently reproved here}]\
&\longrightarrow
\text{DIVISOR-BLOCK-WITNESS-LIFT}\
&\quad[\text{independently reproved here}]\
&\longrightarrow
\boxed{\text{unrestricted strict-block-and-survivor selector}}\
&\quad[\textbf{rejected as stated};\ \text{any replacement open}]\
&\longrightarrow
\text{full witness}\
&\quad[\text{conditional}]\
&\longrightarrow
\exists j,\ Q_j\ne\varnothing
\quad[\text{proved-lean equivalence}]\
&\longleftrightarrow
\text{positive-integer LRC}
\quad[\text{proved-lean}]\
&\longleftrightarrow
\text{unrestricted real LRC}
\quad[\text{proved-lean}].
\end{aligned}
]

The first nonclosed arrow is the strict-block selector, whose proposed universal version is false.

### Global first open arrow after synthesis

Because no local lemma is selected, the project-level chain remains

[
\boxed{
\forall a\text{ positive injective},\
\exists j,\ Q_j\ne\varnothing
}
\quad[\textbf{open}]
]

[
\longleftrightarrow
\text{positive-integer LRC}
\quad[\text{proved-lean}]
]

[
\longleftrightarrow
\text{unrestricted real LRC}
\quad[\text{proved-lean}].
]

No new first open arrow replaces the boxed one.

---

## 9. **Falsification suite**

### Route-level results

| Test                      | Exact target                                     | Result                                                                                                                                             |
| ------------------------- | ------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| Prompt76 tuple            | Global demand-capacity transport                 | (100>98); pivot-4 row (22>20); (r=13) certifies pivot (6).                                                                                         |
| Prompt77 family           | Positive six-mode signed-energy gap              | (K_1,K_2\preceq0), (K_3=0); first member has (K_1,K_2\prec0), (G=(0,0,126)), certificate (r=29).                                                   |
| Prompt78 tuple            | Sparse/canonical owner escape                    | Canonical cover ({6,12,24}); every owner pivot empty; (G_{144}=160), certificate (r=25).                                                           |
| Prompt79 fixtures         | Fixed nonzero determinant or bounded annihilator | Both full determinants are zero; both displayed bounded relations are zero; cross-minors are nonzero multiples of (Np) but remain prime-dependent. |
| Prompt80 tuple and family | Universal strict divisor block                   | All canonical lifts fail; all six proper (S) have capacity sum (\ge d); equality occurs and is insufficient.                                       |

### Cross-route candidate testing

| Candidate mechanism                                         | Decisive fixture | Failure                                              |
| ----------------------------------------------------------- | ---------------- | ---------------------------------------------------- |
| Transport all private demand                                | Prompt76         | Exact inequality false.                              |
| Fixed literal spectral modes                                | Prompt77         | Two blocks negative and one zero.                    |
| Select a private cover owner                                | Prompt78         | Omitted divisible owner blocks all canonical owners. |
| Use a determinant or short annihilator as fixed obstruction | Prompt79         | Determinants and displayed bounded relations vanish. |
| Use any nonzero private minor as fixed obstruction          | Prompt79         | Minor depends on (p,v) and has no uniform bound.     |
| Select a strict divisor block from hard deletion failure    | Prompt80         | No strict block exists.                              |

### Boundary and degeneracy controls

1. **Strict boundary**

   [
   \rho=p-1\Rightarrow\text{bad},\qquad
   \rho=p\Rightarrow\text{safe}.
   ]

   The certificates at pivots (6), (168), and (144) use equality.

2. **Nonunit owner**

   Prompt76 pivot (4), owner (6), has

   [
   \gcd(28,6)=2.
   ]

   Its weight is (6/\gcd(4,6)=3), not (6), and no inverse modulo (28) is used.

3. **Coincident labelled bad sets**

   At Prompt78 pivot (7),

   [
   B_{24}^7=B_{144}^7,
   ]

   but the labelled minimal covers using (24) and (144) remain distinct.

4. **Repeated residues where permitted**

   In the Prompt79 domain, take

   [
   n=3,\quad N=4,\quad p=5,\quad v=(1,1,1).
   ]

   Every deletion-gcd condition is satisfied, and repeated owner labels are retained. At (r=5),

   [
   \rho_{20}(5\cdot1)=5=p
   ]

   for all coordinates, so the tuple is prime-forced. Equality cannot be declared bad.

5. **Common scaling**

   For (a'_i=d a_i),

   [
   \rho_{dM}(d x)=d,\rho_M(x).
   ]

   Pivot bad-set membership repeats with period (M), so

   [
   G'_j=dG_j.
   ]

   Private counts and both sides of the Prompt76 inequality scale by (d). Divisibility blockers are preserved:

   [
   Na_i\mid c\iff N(da_i)\mid dc.
   ]

   Primitive-only hypotheses must be normalized separately; scaling generally destroys primitivity.

6. **Permutation and canonical order**

   For injective speeds, the canonical cover ordered by increasing speed list is equivariant under relabelling. The Prompt80 key ((a_j,j,r)) is also equivariant because distinct speed values decide the pivot before the index tie-breaker.

   In Prompt79, repeated residue values are allowed. Canonical owner-index tie-breaking is therefore label-sensitive and cannot be replaced by an unlabelled residue multiset.

7. **Common gcd versus pairwise gcd**

   The primitive Prompt77 family explicitly demonstrates that total gcd one does not imply pairwise coprimality.

8. **Reflection fixed point**

   In the centered convention

   [
   -M/2<h\le M/2,
   ]

   the fixed point is represented by (+M/2). Its cyclic distance is (M/2), which is at least (p) for (N\ge2), so it is never strictly bad.

9. **Capacity equality**

   Prompt80’s set (S={1,3}) has total capacity exactly (d=16). The union bound then permits all shifts to be excluded. Only strict inequality proves a surviving shift.

No new finite verifier or scan is introduced.

---

## 10. **Implementation candidate**

**Count: 0**

No Lean declaration and no deterministic verifier is frozen.

`DIVISOR-BLOCK-WITNESS-LIFT` is suitable reusable infrastructure for a separate audit or formalization task, but selecting it here would misclassify a conditional lifting theorem as progress on the refuted strict-block existence edge.

The Prompt79 cross-minor lemma is also formalizable, but without a uniform (p)-independent bound it does not implement the required obstruction theorem.

---

## 11. **Proof-obligation ledger**

| Statement                                  | Current evidence                                       | Dependency                                       | First open or failed arrow                               | Stop condition                                                   | Recommended owner                                   |
| ------------------------------------------ | ------------------------------------------------------ | ------------------------------------------------ | -------------------------------------------------------- | ---------------------------------------------------------------- | --------------------------------------------------- |
| Exact unrestricted pivot selector          | `open`                                                 | Positive injectivity and exact pivot definitions | The selector itself                                      | Any proof that merely restates (\exists j,Q_j\ne\varnothing)     | `/root`, Sol High research only                     |
| Prompt76 global demand-capacity inequality | `rejected`                                             | 76-A-E                                           | Counterexample (100>98)                                  | Stop permanently at stated quantifiers                           | None                                                |
| Alternative private-demand transport       | `open` only if materially different                    | Canonical covers and global owner interactions   | Uniform transport not contradicted by Prompt76           | Stop if it implies (100\le98) or treats privacy as global        | Separate Sol High contract                          |
| Prompt77 literal six-mode gap              | `rejected`                                             | Signed Gram construction                         | Counterfamily ((u,v,4uv))                                | Stop at (K_1,K_2\preceq0,\ K_3=0)                                | None                                                |
| Scale-adaptive or full-spectrum selector   | `open`                                                 | A new spectral theorem                           | Positive spectral direction implying (Q_j\ne\varnothing) | Stop if it reduces to finitely many fixed literal modes          | Separate Sol High contract                          |
| Prompt78 sparse/canonical owner escape     | `rejected`                                             | Minimal labelled covers                          | Divisible omitted owner                                  | Stop at ((6,7,12,24,144))                                        | None                                                |
| Blocker-free owner selector                | `open`                                                 | 78-C plus additional global structure            | Absence of blocker does not imply (Q_i\ne\varnothing)    | Stop if conclusion is merely renamed simultaneous noncoverage    | Separate Sol High contract                          |
| Prompt79 local cross-minor lemma           | `response-authored/rederived`, `external-unformalized` | Private residues and modular rank one            | Uniform boundedness                                      | Stop if (\Delta) depends on (p,v) or unbounded lifts             | Independent arithmetic audit if separately approved |
| Prompt79 finite (\Sigma_n) or fixed (D)    | `open`                                                 | A genuinely (p)-independent obstruction          | Construction of (H_n,\Sigma_n,D)                         | Stop on prime-dependent determinants or zero annihilators        | `/root`, Sol High                                   |
| Conditional Euclidean extraction           | `conditional`, independently rederived                 | Fixed (D) containing all bad-prime divisors      | Existence of (D)                                         | Stop if (D) is defined using all bad primes after the fact       | No implementation under this contract               |
| Prompt80 universal strict-block existence  | `rejected`                                             | Hard canonical deletion failures                 | Counterexample and infinite family                       | Stop at capacity equality or excess                              | None                                                |
| Prompt80 divisor-block lift                | `response-authored/rederived`, `external-unformalized` | Strict block and survivor witness                | Strict-block-and-survivor selector                       | Stop if formalization is presented as unrestricted progress      | Independent Lean audit only under separate approval |
| Unrestricted real LRC                      | `open`                                                 | Exact pivot selector plus accepted equivalences  | Exact pivot selector                                     | No status change without a complete proof and audited Lean chain | `/root`                                             |

---

## 12. **Final evidence boundary**

* `proved-lean`: the accepted real/integer and pivot-certificate equivalences, together with the other explicitly accepted formal dependencies.
* `proved-math-qualified`: the exact Prompt76-78 counterexamples and surviving local facts at their stated scopes.
* `response-authored/rederived`: the Prompt79 local arithmetic and fixtures; the Prompt80 counterexample, infinite family, orbit count, and lifting theorem. These have been independently hand-rederived here but are not project-promoted.
* `computed finite evidence`: none newly produced. Prior response scans and attachment claims remain unverified.
* `conditional`: Euclidean extraction after a fixed (D) is supplied; divisor-block lifting after a strict block and survivor witness are supplied.
* `rejected`: Prompt76 global private-demand inequality; Prompt77 primitive six-mode gap; Prompt78 sparse/canonical owner escape; Prompt80 universal strict-divisor-block existence.
* `open`: Prompt79’s (p)-independent finite obstruction, every replacement global selector, exact unrestricted pivot-certificate existence, positive-integer LRC, and unrestricted real LRC at the theorem level.

**Final status: `STOP`. No declaration is selected, no implementation candidate is admitted, and no unrestricted evidence status changes.**
