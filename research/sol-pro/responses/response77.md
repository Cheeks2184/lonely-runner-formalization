## 1. Disposition

**STOP.**

The frozen lemma `PRIMITIVE-DEGREE-2N-SIGNED-GRAM-GAP` is **`rejected`**.

There is an infinite family of primitive counterexamples already at (n=3):

[
a(u,v)=(u,v,4uv),\qquad 6\le u<v,\qquad \gcd(u,v)=1.
]

For every such tuple, the first two degree-six blocks are negative semidefinite and the third block is identically zero. The smallest member of this proved family is

[
a=(6,7,168).
]

For this tuple,

[
(M_1,M_2,M_3)=(24,28,672),\qquad
(G_1,G_2,G_3)=(0,0,126),
]

and

[
K_1\prec0,\qquad K_2\prec0,\qquad K_3=0.
]

Hence (E_a(Z)\le0) for every block vector (Z), including every unit vector. This is a primitive exact counterexample to the spectral bridge. It is not a Lonely Runner counterexample because (G_3=126>0).

---

## 2. Status table

| Claim or dependency                                                                           | Status                     | Exact disposition                                                      |
| --------------------------------------------------------------------------------------------- | -------------------------- | ---------------------------------------------------------------------- |
| Strict bad-set definitions, owner multiplicity, aliasing, and complex embeddings              | `proved-math`              | Used exactly as frozen.                                                |
| (K_j) is Hermitian and (E_j(z)=z^*K_jz)                                                       | `proved-math`              | Direct finite expansion.                                               |
| Block-diagonal equivalence between a positive block eigenvalue and a unit (Z) with (E_a(Z)>0) | `proved-math`              | Finite-dimensional Hermitian spectral theorem.                         |
| Prompt74 common-scaling transform                                                             | `proved-math`              | Accepted input, rederived below.                                       |
| Prompt74 family ((c,2c,8c)), (c\ge6)                                                          | `proved-math`              | Accepted input, not a new result here.                                 |
| Exact blocks for ((1,2,8))                                                                    | `proved-math`              | Recomputed below, including aliasing.                                  |
| Primitive family ((u,v,4uv)), coprime (u,v\ge6), has (K_1,K_2\preceq0), (K_3=0)               | `proved-math`              | New exact counterexample family.                                       |
| Specific tuple ((6,7,168)), including (G=(0,0,126)) and exact matrices                        | `proved-math`              | Exact Gram and periodic-fiber certificate.                             |
| `PRIMITIVE-DEGREE-2N-SIGNED-GRAM-GAP`                                                         | `rejected`                 | False at (n=3).                                                        |
| Primitive trace/minor separation proposed in Section 5                                        | `rejected`                 | Fails on ((6,7,168)).                                                  |
| Attack A universal primitive Hermitian separation                                             | `rejected`                 | Exact counterexample blocks are all nonpositive.                       |
| Attack B simultaneous all-pivot additive-energy bridge                                        | `rejected`                 | Common-(L) pullback preserves the nonpositive direct sum.              |
| Required search for (2\le n\le6), maximum speed (14)                                          | `computed finite evidence` | 6,330 tuples, zero failures, all certified by exact outward intervals. |
| Gcd normalization, scale lift, and pivot-safety implication                                   | `proved-math`              | Remains a valid conditional chain.                                     |
| Existing certificate-to-LRC directions named in the contract                                  | `proved-lean`              | Used only at their accepted scope.                                     |
| Unrestricted Lonely Runner Conjecture                                                         | `open`                     | Unchanged.                                                             |

---

## 3. Frozen target

Let

[
\zeta_M=e^{2\pi i/M},
\qquad
w_j(r)=
\begin{cases}
1-\mu_j(r),&r\in R_j,\
0,&N\mid r.
\end{cases}
]

For any integer difference (d), define

[
\kappa_j(d)=\frac1{M_j}\sum_{r=0}^{M_j-1}w_j(r)\zeta_{M_j}^{dr}.
]

Then, for literal modes (m,\ell\in{0,\ldots,2n-1}),

[
K_j[m,\ell]=\kappa_j(\ell-m).
]

Differences are interpreted modulo (M_j) by the character itself. No mode is deleted when (M_j<2n), so all aliasing remains.

The integer (1-\mu_j(r)) is embedded through

[
\mathbb Z\hookrightarrow\mathbb R\hookrightarrow\mathbb C.
]

For (z\in\mathbb C^{2n}),

[
|P_{j,z}(r)|^2
==============

\overline{P_{j,z}(r)}P_{j,z}(r)
\in\mathbb R_{\ge0}.
]

Because (w_j(r)\in\mathbb R),

[
\overline{K_j[m,\ell]}
======================

K_j[\ell,m],
]

so (K_j) is Hermitian. Expanding the square gives

[
\begin{aligned}
E_j(z)
&=\frac1{M_j}\sum_r w_j(r)
\left|\sum_m z_m\chi_{j,m}(r)\right|^2\
&=\sum_{m,\ell}\overline{z_m}K_j[m,\ell]z_\ell
=z^*K_jz.
\end{aligned}
]

Thus

[
E_a(Z)=Z^*\operatorname{diag}(K_1,\ldots,K_n)Z.
]

Consequently, the following are equivalent:

[
\exists Z,\ |Z|=1,\ E_a(Z)>0,
]

[
\operatorname{diag}(K_1,\ldots,K_n)
\text{ has a positive eigenvalue},
]

[
\exists j,\ K_j\text{ has a positive eigenvalue}.
]

The boundary remains strict:

[
r\in B_i^j
\iff
\rho_{M_j}(ra_i)<a_j.
]

Therefore (\rho_{M_j}(ra_i)=a_j) is safe. Multiples of (N) are excluded before evaluating the energy.

---

## 4. Prompt74 accepted theorem

### Common-scaling transform

Let (b=ca), (c\ge1). At pivot (j),

[
M_{b,j}=cM_{a,j}.
]

Writing (r=s+qM_{a,j}), with (0\le s<M_{a,j}), gives

[
N\mid r\iff N\mid s
]

because (M_{a,j}) is a multiple of (N), and

[
\rho_{cM_{a,j}}(r,c a_i)
========================

c,\rho_{M_{a,j}}(s a_i).
]

Hence the scaled weight is constant along the (c)-element projection fibers:

[
w_{b,j}(s+qM_{a,j})=w_{a,j}(s).
]

It follows immediately that

[
G_{b,j}=cG_{a,j}.
]

For the Fourier coefficient,

[
\begin{aligned}
\kappa_{b,j}(d)
&=\frac1{cM_j}
\sum_{s=0}^{M_j-1}
w_{a,j}(s)e^{2\pi ids/(cM_j)}
\sum_{q=0}^{c-1}e^{2\pi idq/c}\
&=
\begin{cases}
0,&c\nmid d,[2mm]
\kappa_{a,j}(d/c),&c\mid d.
\end{cases}
\end{aligned}
]

This is the accepted common-scaling theorem at its exact scope.

### Exact primitive base ((1,2,8))

Here (n=3), (N=4), and the literal modes are (0,\ldots,5).

Let (T_6(c_0,\ldots,c_5)) denote the real symmetric Toeplitz matrix

[
T_6(c_0,\ldots,c_5)[m,\ell]=c_{|m-\ell|}.
]

The good counts are

[
G=(0,0,6),
]

with

[
Q_3={9,10,11,21,22,23}.
]

At pivot (1), (M_1=4). The speed (8) covers all of (R_1), and the remaining bad set is ({2}). Therefore

[
K_1=-\frac14uu^*,
\qquad
u=(1,-1,1,-1,1,-1)^T.
]

This retains the (M_1=4<6) aliasing.

At pivot (2), (M_2=8), and the remaining bad set is ({1,7}). Hence

[
K_2=T_6(c_0,\ldots,c_5),
\qquad
c_d=-\frac14\cos\frac{\pi d}{4}.
]

Equivalently,

[
K_2=-\frac18V_8({1,7})^*V_8({1,7}).
]

At pivot (3), (M_3=32). The nonzero weight is

[
w_3(r)=
\begin{cases}
-1,&r\equiv\pm1,\pm2,\pm3\pmod{32},\
1,&r\equiv\pm9,\pm10,\pm11\pmod{32},\
0,&\text{otherwise}.
\end{cases}
]

Thus

[
K_3=T_6(\gamma_0,\ldots,\gamma_5),
]

where

[
\gamma_d=
\frac1{16}
\left(
\sum_{s=9}^{11}\cos\frac{\pi ds}{16}
------------------------------------

\sum_{s=1}^{3}\cos\frac{\pi ds}{16}
\right).
]

In particular,

[
\gamma_0=\gamma_4=0
]

and

[
\gamma_1<0,
]

because the three cosines in the first sum are negative and the three in the second sum are positive. Therefore

[
z=\frac1{\sqrt2}(1,-1,0,0,0,0)
]

satisfies

[
z^*K_3z=-\gamma_1>0.
]

So the primitive base tuple does satisfy the gap.

### The accepted nonprimitive family

For ((c,2c,8c)) with (c\ge6), every nonzero literal difference satisfies

[
1\le |m-\ell|\le5<c,
]

so common scaling kills every off-diagonal coefficient. The three zero-frequency coefficients inherited from ((1,2,8)) are

[
-\frac14,\qquad-\frac14,\qquad0.
]

Hence

[
K_1=-\frac14I_6,\qquad
K_2=-\frac14I_6,\qquad
K_3=0.
]

Also,

[
G=(0,0,6c).
]

At (c=6),

[
(6,12,48),\qquad
G=(0,0,36),
]

and

[
K_1=-\frac14I_6,\qquad
K_2=-\frac14I_6,\qquad
K_3=0.
]

This remains the accepted Prompt74 `proved-math` result.

It does not itself decide the primitive target because

[
\gcd(c,2c,8c)=c.
]

Normalization divides the tuple back to ((1,2,8)), shrinks all moduli by (c), removes the common (c)-fiber annihilation, and restores the nonzero coefficient (\gamma_1).

However, gcd normalization removes only a **global common fiber**. It does not remove separate pivot-local fibers. The counterexample below exploits precisely those surviving local fibers.

---

## 5. Anti-tautology audit

The first non-tautological spectral separation tested was the sufficient condition

[
\tag{H(_{\mathrm{sep}})}
\gcd(a)=1
\quad\Longrightarrow\quad
\exists j,\
\operatorname{tr}(K_j^2)>
\operatorname{tr}(K_j)^2.
]

This condition mentions neither (Q_j), a known good residue, a delta basis, an eigenvector selected after seeing (G_j), nor additional frequencies.

It is sufficient because, if a Hermitian matrix (K) is negative semidefinite with eigenvalues (\lambda_s\le0), then

[
\operatorname{tr}(K)^2
======================

# \left(\sum_s\lambda_s\right)^2

\sum_s\lambda_s^2+
2\sum_{s<t}\lambda_s\lambda_t
\ge
\sum_s\lambda_s^2
=================

\operatorname{tr}(K^2).
]

Therefore the strict reverse inequality forces a positive eigenvalue.

For the exact primitive counterexample ((6,7,168)),

[
K_1\prec0,\qquad K_2\prec0,\qquad K_3=0.
]

Consequently,

[
\operatorname{tr}(K_1^2)-\operatorname{tr}(K_1)^2<0,
]

[
\operatorname{tr}(K_2^2)-\operatorname{tr}(K_2)^2<0,
]

and

[
\operatorname{tr}(K_3^2)-\operatorname{tr}(K_3)^2=0.
]

Thus ((H_{\mathrm{sep}})) is **`rejected`**.

The identity

[
E_j(z)
======

\frac1{M_j}
\left(
\sum_{\mu_j(r)=0}|P(r)|^2
-------------------------

\sum_{\mu_j(r)\ge2}(\mu_j(r)-1)|P(r)|^2
\right)
]

was not promoted as a new inequality. It is merely a rewriting of the signed weight using (Q_j), and therefore falls inside the excluded tautological carrier route.

---

## 6. Exact falsification

### Infinite primitive counterexample family

Let

[
6\le u<v,\qquad \gcd(u,v)=1,
\qquad
a=(u,v,4uv).
]

Then (a) is positive, injective, and primitive:

[
\gcd(u,v,4uv)=1.
]

Here (n=3), (N=4), and

[
(M_1,M_2,M_3)=(4u,4v,16uv).
]

At pivot (1),

[
4uv=vM_1,
]

so for every (r\in R_1),

[
\rho_{M_1}(r\cdot4uv)=0<u.
]

Thus the third owner covers all of (R_1), and

[
1-\mu_1(r)=-1_{B_v^1}(r).
]

Therefore

[
K_1=-\frac1{M_1}V_{M_1}(B_v^1)^*V_{M_1}(B_v^1)\preceq0.
]

Similarly, (4uv=uM_2), so

[
K_2=-\frac1{M_2}V_{M_2}(B_u^2)^*V_{M_2}(B_u^2)\preceq0.
]

At pivot (3),

[
M_3=16uv.
]

The candidate set (R_3) has period (4), repeated (4uv) times.

For owner (u),

[
\rho_{16uv}(ru)
===============

u,\rho_{16v}(r),
]

so

[
r\in B_u^3
\iff
4\nmid r
\quad\text{and}\quad
\rho_{16v}(r)<4v.
]

Thus (B_u^3) has period (16v), repeated (u) times. Similarly, (B_v^3) has period (16u), repeated (v) times.

For a periodic set of period (P\mid M), repeated (h=M/P) times, its Fourier sum at difference (d) contains

[
\sum_{q=0}^{h-1}e^{2\pi idq/h},
]

which is zero unless (h\mid d).

Every literal block difference satisfies

[
0<|d|\le5.
]

Since

[
u\ge6,\qquad v\ge6,\qquad 4uv>5,
]

the nonzero Fourier coefficients of each of (R_3), (B_u^3), and (B_v^3) vanish throughout the literal difference range.

At zero frequency,

[
|R_3|=12uv.
]

Within one period (16v), the strict condition

[
\rho_{16v}(r)<4v
]

and exclusion (4\nmid r) give (6v) residues. Repeating over (u) fibers gives

[
|B_u^3|=6uv.
]

Likewise,

[
|B_v^3|=6uv.
]

Hence

[
|R_3|-|B_u^3|-|B_v^3|
=====================

# 12uv-6uv-6uv

0.

]

All entries of (K_3) therefore vanish:

[
K_3=0.
]

This proves, for every coprime (u,v\ge6),

[
K_1\preceq0,\qquad K_2\preceq0,\qquad K_3=0.
]

The universal primitive gap is false.

### First member of the proved family: ((6,7,168))

For

[
a=(6,7,168),
]

the moduli and good counts are

[
(M_1,M_2,M_3)=(24,28,672),
]

[
(G_1,G_2,G_3)=(0,0,126).
]

For a set (S\subseteq\mathbb Z/M\mathbb Z), let

[
V_M(S)[r,m]=\zeta_M^{mr},
\qquad r\in S,\quad 0\le m\le5.
]

At pivot (1),

[
S_{24}=B_7^1
============

{3,7,10,11,13,14,17,21},
]

and

[
K_1=-\frac1{24}V_{24}(S_{24})^*V_{24}(S_{24}).
]

Equivalently,

[
K_1=T_6(\alpha_0,\ldots,\alpha_5),
]

where

[
\begin{aligned}
\alpha_0&=-\frac13,\
\alpha_1&=\frac{-\sqrt2+\sqrt3+\sqrt6}{24},\
\alpha_2&=-\frac1{24},\
\alpha_3&=\frac{\sqrt2}{24},\
\alpha_4&=\frac1{24},\
\alpha_5&=\frac{\sqrt2-\sqrt3+\sqrt6}{24}.
\end{aligned}
]

At pivot (2),

[
S_{28}=B_6^2
============

{1,5,9,10,13,14,15,18,19,23,27},
]

and

[
K_2=-\frac1{28}V_{28}(S_{28})^*V_{28}(S_{28}).
]

Equivalently,

[
K_2=T_6(\beta_0,\ldots,\beta_5),
]

with the exact real cyclotomic coordinates

[
\beta_d
=======

-\frac1{28}
\left(
(-1)^d+
2\sum_{s\in{1,5,9,10,13}}
\cos\frac{\pi ds}{14}
\right),
\qquad 0\le d\le5.
]

The term ((-1)^d) is the contribution of the reflection-fixed antipode (r=14), counted once.

Both Vandermonde matrices have full column rank: a polynomial of degree at most (5) cannot vanish at respectively (8) or (11) distinct roots of unity unless it is zero. Hence

[
K_1\prec0,\qquad K_2\prec0.
]

At pivot (3),

[
K_3=0_{6\times6}.
]

The exact multiplicity distribution is

[
#{\mu_3=0}=126,\qquad
#{\mu_3=1}=252,\qquad
#{\mu_3=2}=126.
]

One exact count uses (r=16q+s), (0\le q<42):

| (s\bmod16)       | (#(\mu=0)) | (#(\mu=1)) | (#(\mu=2)) |
| ---------------- | ---------: | ---------: | ---------: |
| (1,2,3,13,14,15) |    12 each |    21 each |     9 each |
| (5,6,7,9,10,11)  |     9 each |    21 each |    12 each |

This totals ((126,252,126)).

### Mandatory fixture audit

1. **((6,12,48)).** Recovered exactly as in Section 4:

   [
   G=(0,0,36),\quad
   K_1=K_2=-I_6/4,\quad K_3=0.
   ]

2. **((1,2,8)).** Every exact block is given in Section 4. The first two are negative semidefinite, while (K_3) has the exact positive direction ((1,-1,0,0,0,0)/\sqrt2).

3. **((1,2,3,4,5,7)).**

   [
   G=(0,0,0,0,2,2).
   ]

   At pivot (5), the multiplicity distribution is

   [
   \mu: 0^2,1^{22},2^4,4^2,
   ]

   so weights (-1) and (-3) are retained. At pivot (7),

   [
   \mu:0^2,1^{28},2^8,3^2,5^2,
   ]

   retaining weights (-1,-2,-4).

   The integer vector

   [
   (1,0,-1,-1,0,1,1,0,-1,-1,0,1)
   ]

   gives the exact certified bound

   [
   E_5>2.7357453077110244.
   ]

   Negative overlaps were therefore included rather than discarded.

4. **((1,6,11,12,13)).**

   [
   G=(0,0,8,8,10).
   ]

   The first two rows are covered and have pointwise nonpositive weights. At pivot (11),

   [
   q=(-1,1,-1,1,0,0,1,-1,1,-1)
   ]

   gives

   [
   E_3>1.2056673255379381.
   ]

5. **((4,5,9)).**

   [
   G=(2,2,4).
   ]

   Exact positive directions exist at all three pivots:

   [
   \begin{array}{c|c|c}
   \text{pivot}&q&\text{certified }E_j(q)\ \hline
   4&(1,1,1,1,1,1)&>2.6923822636433066\
   5&(0,-1,0,0,1,0)&>0.0726542528005360\
   9&(1,0,0,0,0,-1)&>0.3150712122009838
   \end{array}
   ]

   The accepted rejection of factorwise Fourier domination is retained. Individual owner transforms have incompatible signs and do not provide a termwise domination proof.

6. **((1,2,3)).**

   [
   G=(2,2,2).
   ]

   At pivot (3), (M=12), and (r=3,9) satisfy

   [
   \rho_{12}(r\cdot1)=3=p_3.
   ]

   They are safe and belong to (Q_3). By contrast, (r=2) has

   [
   \rho_{12}(2\cdot1)=2=p_3-1
   ]

   and is strictly bad.

7. **((1,3,5)).**

   [
   G=(3,3,5).
   ]

   At the three pivots, the reflection-fixed antipodes are respectively

   [
   2,\quad6,\quad10.
   ]

   Each lies in (R_j), is safe, belongs to (Q_j), and is counted once rather than doubled.

8. **((1,3,13)).**

   [
   G=(3,5,9).
   ]

   At pivot (3), meaning pivot speed (3) and modulus (12),

   [
   B_1^2=B_{13}^2={1,2,10,11}.
   ]

   These are two distinct owners with coincident sets. Hence (\mu=2), not (1), on those residues and the weight is (-1). No deduplication was performed.

9. **((1,3,4,5,7,11)).**

   [
   G=(0,0,0,0,2,2).
   ]

   At pivot (1), (M_1=7<12), so literal modes satisfy

   [
   \chi_m=\chi_{m+7},\qquad 0\le m\le4.
   ]

   These modes were retained separately. The pivot-(7) vector

   [
   (-2,3,-2,3,-1,-1,-1,-1,3,-2,3,-2)
   ]

   gives

   [
   E_5>0.1350046878325126.
   ]

10. **Boundary and symmetry diagnostics.**

Multiples of (N) were assigned zero weight before all matrix sums. Equality (\rho=p_j) was safe; (\rho=p_j-1) was bad. Reflection antipodes were counted once. Nonunit maps and gcd fibers were retained.

Permuting a tuple merely permutes the pivot blocks and owner labels, so the block multiset and gap disposition are invariant.

Common scaling of ((1,2,8)) by (2) and (3) gives

[
G(2,4,16)=(0,0,12),\qquad
G(3,6,24)=(0,0,18).
]

The exact scaling formula kills differences not divisible by (2) or (3), respectively, but surviving differences still give a positive third block. Scalar matrices appear only once the scale is at least (6).

### Required bounded search

The deterministic domain was:

[
2\le n\le6,\qquad
1\le a_1<\cdots<a_n\le14,\qquad
\gcd(a_1,\ldots,a_n)=1.
]

Ordering was by (n), then lexicographically. Exact certified counts were:

|       (n) | Primitive tuples |
| --------: | ---------------: |
|         2 |               63 |
|         3 |              325 |
|         4 |              965 |
|         5 |            1,981 |
|         6 |            2,996 |
| **Total** |        **6,330** |

Every tuple received an integer Rayleigh vector whose value had a strictly positive rigorous outward-rounded lower endpoint. There were no unresolved tuples and

```json
"first_failure": null
```

within the required maximum-speed-(14) domain.

This remains only **`computed finite evidence`**. The exact counterexample family begins outside that domain; its first member has maximum speed (168). No claim is made that ((6,7,168)) is the globally lexicographically first primitive counterexample.

---

## 7. Attack A

Attack A fails at the first primitive separation arrow:

[
\gcd(a)=1
\quad\Longrightarrow\quad
\text{some nonzero literal low-frequency moment survives with positive sign}.
]

The tuple

[
(6,7,168)
]

has the particularly strong Bézout identity

[
7-6=1.
]

Thus the failure cannot be attributed to large Bézout coefficients.

Nevertheless:

[
K_1\prec0,\qquad K_2\prec0,\qquad K_3=0.
]

At the first two pivots, the speed (168) is an exact multiple of the corresponding pivot modulus and covers every candidate. At the third pivot, the two owner sets have repeat counts (6) and (7), which annihilate every nonzero literal difference (1,\ldots,5).

Primitivity constrains common divisors across the entire tuple. It does not prevent:

* one speed from being a multiple of another pivot’s complete modulus;
* separate owner maps from having large pivot-local gcd fibers;
* all literal low-frequency coefficients from vanishing simultaneously.

Therefore no trace, principal-minor, Schur-complement, minimax, or Bézout-coupled inequality can force a positive eigenvalue from the frozen matrices at every primitive tuple. The exact counterexample already has the opposite matrix signs.

Attack A disposition: **`rejected`**.

---

## 8. Attack B

For ((6,7,168)),

[
L=\operatorname{lcm}(24,28,672)=672.
]

Pulling a function from (\mathbb Z/M_j\mathbb Z) to (\mathbb Z/L\mathbb Z) preserves normalization:

[
\frac1L\sum_{x\bmod L}
f(x\bmod M_j)
=============

\frac1{M_j}\sum_{r\bmod M_j}f(r).
]

The literal characters become characters on (\mathbb Z/672\mathbb Z) at frequencies

[
{0,28,56,84,112,140}
]

for pivot (1),

[
{0,24,48,72,96,120}
]

for pivot (2), and

[
{0,1,2,3,4,5}
]

for pivot (3).

The Bézout relation (7-6=1) may suggest relations such as (28-24=4), but the frozen energy is a direct sum:

[
E_a(Z)=E_1(z_1)+E_2(z_2)+E_3(z_3).
]

It contains no cross terms between the three frequency sets. Adding such terms would change the frozen quadratic form.

After exact pullback,

[
E_1(z_1)<0\quad(z_1\ne0),
]

[
E_2(z_2)<0\quad(z_2\ne0),
]

and

[
E_3(z_3)=0
]

for every (z_3). Hence

[
E_a(Z)\le0
]

on the common group as well.

The first fatal arrow is therefore

[
\text{common-(L) representation plus Bézout data}
\quad\Longrightarrow\quad
\text{positive cross-pivot interference}.
]

There is no such interference in the defined block-diagonal energy. The projection fibers supply annihilation, not sign control.

Attack B disposition: **`rejected`**.

---

## 9. Complete implication chain

The implication chain requested in the contract remains valid **conditionally on the now-rejected gap lemma**.

### Gcd normalization

Let (A:\operatorname{Fin}n\to\mathbb N) be positive and injective, and let

[
d=g(A).
]

Because all (A_i>0), their iterated gcd satisfies

[
d>0.
]

By the defining divisor property,

[
d\mid A_i
]

for every (i). Define the exact quotient

[
a_i=A_i/d,
\qquad
A_i=da_i.
]

Then (a_i>0). If (a_i=a_k), multiplication by the positive integer (d) gives (A_i=A_k), so (a) is injective.

Let (e=g(a)). Since (e\mid a_i) for every (i),

[
de\mid da_i=A_i
]

for every (i). Thus (de) is a common divisor of all (A_i), and the gcd property gives (de\mid d). Cancelling the positive factor (d) yields (e=1). Therefore

[
g(a)=1.
]

### Gap to an uncovered candidate

Suppose the primitive gap were true and provided (Z) with

[
|Z|^2=1,\qquad E_a(Z)>0.
]

If every candidate at every pivot were covered, then

[
\mu_j(r)\ge1
]

for all (j) and (r\in R_j). Therefore

[
1-\mu_j(r)\le0,
]

and each summand in

[
E_j(z_j)=
\frac1{M_j}\sum_{r\in R_j}
(1-\mu_j(r))|P_{j,z_j}(r)|^2
]

would be nonpositive. This would imply

[
E_a(Z)\le0,
]

a contradiction. Hence some (j,r) would satisfy

[
\mu_j(r)=0.
]

This means

[
\rho_{Na_j}(ra_i)\ge a_j
]

for every (i\ne j), with equality allowed.

### Primitive pivot safety

Set

[
t_0=\frac{r}{Na_j}.
]

For (i\ne j),

[
\left|t_0a_i\right|_{\mathbb R/\mathbb Z}
=========================================

\frac{\rho_{Na_j}(ra_i)}{Na_j}
\ge
\frac1N.
]

For the pivot coordinate,

[
t_0a_j=\frac rN.
]

Since (N\nmid r), write (r\equiv s\pmod N) with (1\le s\le N-1). Then

[
\left|\frac rN\right|
=====================

\frac{\min(s,N-s)}N
\ge
\frac1N.
]

### Scale lift

Let

[
M=Na_j,\qquad A_i=da_i.
]

The same integer (r) satisfies

[
0\le r<M\le dM=NA_j
]

and (N\nmid r).

For any integer (x), write

[
x=qM+s,\qquad 0\le s<M.
]

Then

[
dx=dqM+ds,
\qquad
(dx)\bmod(dM)=ds.
]

Therefore

[
\rho_{dM}(dx)
=============

# \min(ds,dM-ds)

# d\min(s,M-s)

d\rho_M(x).
]

Applying this to (x=ra_i) gives

[
\rho_{NA_j}(rA_i)
=================

# \rho_{dNa_j}(rd a_i)

d,\rho_{Na_j}(ra_i).
]

Hence

[
\rho_{NA_j}(rA_i)\ge da_j=A_j.
]

Equality remains equality, so the strict boundary is preserved.

The lifted time is

[
t=\frac{r}{NA_j}
================

# \frac{r}{dNa_j}

# \frac1d\left(\frac{r}{Na_j}\right)

\frac{t_0}{d}.
]

### (n=1)

For a single positive speed (A_0), (N=2). Taking

[
t=\frac1{2A_0}
]

gives

[
tA_0=\frac12,
]

whose cyclic distance is exactly (1/2=1/N).

### Existing formal directions

Once one positive-integer pivot certificate exists, the accepted directions are:

```text
one pivot certificate
  -> PositiveIntegerPivotCertificateConjecture
  -> PositiveIntegerConjecture
  -> Conjecture
  -> unrestricted real LRC
```

These directions remain **`proved-lean`** at their accepted scope.

The first premise supplied by the proposed signed-Gram gap is false. Therefore this conditional chain does not prove unrestricted LRC.

---

## 10. Artifacts and final evidence boundary

### Exact bounded search

* [Bounded-search source](sandbox:/mnt/data/prompt77_exact_search.py)
  SHA-256: `c416c9fcc192b57d038801f32342b7ad1a48d6e641f3aa47dc40590872bbec51`

* [Machine-readable search summary](sandbox:/mnt/data/prompt77_search_summary.json)
  SHA-256: `8cb881ec154faa556cdf6c92693f7f680dfc15f582c3cab2b1ee9bb8ef2c3ad0`

* [All 6,330 exact Rayleigh certificates](sandbox:/mnt/data/prompt77_search_certificates.jsonl)
  SHA-256: `0a00e2f1ff08ddcf726dfb777e2d0edd823d299d14d01e95862ac2c1b5c16010`

The search used CPython `3.13.5` and NumPy `2.3.5`. Floating eigensolvers proposed integer vectors only. Acceptance used outward-rounded decimal enclosures of exact cyclotomic Rayleigh sums. The (\pi) interval came from exact rational Machin-series bounds, and cosine intervals used degree-140 Taylor expansions with rigorous remainder bounds. Any command-line argument produces exit status `2`. The summary binds the source and canonical JSONL output by SHA-256.

### Exact counterexample

* [Exact counterexample verifier](sandbox:/mnt/data/prompt77_counterexample_verify.py)
  SHA-256: `6d48456ccfee6323371beb4f8c4a46b89de3e228fa12e1bd5c7784aa83f3971c`

* [Machine-readable counterexample certificate](sandbox:/mnt/data/prompt77_counterexample_certificate.json)
  SHA-256: `c9713f16644acb1f562823b93135cd1d12fbc3f3350c4c8fa3d4ca09723b72d9`

The counterexample verifier uses no floating-point arithmetic. It checks exact integer bad-set membership, strict boundaries, multiplicities, periods, counts, geometric-fiber divisibility, and the two negative cyclotomic Gram factorizations.

Final boundary:

* Primitive signed-Gram gap: **`rejected`**.
* Infinite primitive obstruction family: **`proved-math`**.
* Required bounded search: **`computed finite evidence`**.
* Existing formal implication directions: **`proved-lean`**.
* Unrestricted Lonely Runner Conjecture: **`open`**.
* No recovered attachment was executed.
* No tracked repository file was edited.
