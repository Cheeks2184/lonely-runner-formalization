# PRO-B Turn 1 result

No exact two-grid cover was found. `TOP-TWO-PIVOT`, the all-pivot certificate, and unrestricted Lonely Runner all remain `open`.

Every fixed scalar criterion tested was refuted. The only route surviving adversarial review is a **multi-shift, owner-aware integral affine transversal**. It has a sharp exact certificate for the hard pair ((N,A,B)=(7,98,187)), but no uniform theorem.

The project artifacts confirm the strict endpoint convention, exact generalized-CRT machinery, and a kernel-checked saturated top-two class.   The previously reported 14-shift certificate for ((7,98,187)) was independently reproduced. 

## 1. Exact status table

| Item                                                             | Status                     | Exact result                                                                                                                                   |
| ---------------------------------------------------------------- | -------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| Positive-integer pivot-certificate equivalence                   | `proved-lean`              | Accepted at the supplied exact strength                                                                                                        |
| Endpoint-safe real reduction                                     | `proved-lean`              | Accepted at the supplied exact strength                                                                                                        |
| Exact single, pair, and triple target-intersection formulas      | `proved-lean`              | Accepted at the supplied exact strength                                                                                                        |
| Fastest-pivot ratio, large-gap, and extremal-interval reductions | `proved-lean`              | Accepted individually at their stated hypotheses                                                                                               |
| Combined residual regime used below                              | `conditional`              | Exact for the explicit conjunction stated in §2; identification with a single project-level residual theorem still requires declaration replay |
| Saturated lower-interval top-two class                           | `proved-lean`              | Exact theorem gives a canonical certificate at one of the two largest speeds                                                                   |
| Canonical pivot coordinate is automatic                          | `proved-math`              | Complete proof below                                                                                                                           |
| Explicit top-two maximality normalization                        | `proved-math`              | Complete proof below                                                                                                                           |
| `TOP-TWO-PIVOT →` all-pivot target                               | `proved-math`              | Includes the (n=1) base case                                                                                                                   |
| Exact affine-fiber cardinality                                   | `proved-math`              | Complete formula and proof below                                                                                                               |
| Same-owner affine-shift exclusion                                | `proved-math`              | Complete proof below                                                                                                                           |
| One-shift affine union implication                               | `proved-math`              | Valid implication, but its proposed uniform positivity is rejected                                                                             |
| Quadratic multiplicity inequality                                | `proved-math`              | Valid implication, but uniform positivity is rejected                                                                                          |
| Cubic Bonferroni inequality                                      | `proved-math`              | Valid implication, but uniform positivity is rejected                                                                                          |
| Quotient-slice integer dual implication                          | `proved-math`              | Valid implication, but uniform positivity is rejected                                                                                          |
| Uniform full quadratic criterion                                 | `rejected`                 | Finite-sweep minimum ((1,2,3,4,5))                                                                                                             |
| Uniform full cubic criterion                                     | `rejected`                 | Finite-sweep minimum ((1,2,3,4,5,7))                                                                                                           |
| Uniform robust quadratic criterion                               | `rejected`                 | Finite-sweep minimum ((1,2,3,4,5,7))                                                                                                           |
| Uniform robust cubic criterion                                   | `rejected`                 | Finite-sweep minimum ((1,3,4,5,7,11)); residual failure at ((1,4,5,6,7,11))                                                                    |
| Uniform quotient-slice dual                                      | `rejected`                 | Finite-sweep minimum ((5,10,11,12))                                                                                                            |
| Uniform one-shift affine union                                   | `rejected`                 | Residual failure ((1,2,3,4,5,6,7,18)); margin (-104) on OPT-ADD                                                                                |
| Hard ((7,98,187)) 14-shift transversal number (5)                | `computed finite evidence` | All (3,464,840) four-element lower sets rejected; a five-element hitting set exists                                                            |
| Declared 8,108-row sweep                                         | `computed finite evidence` | No exact top-two cover                                                                                                                         |
| `RESIDUAL-2N-SHIFT-OWNER-TRANSVERSAL`                            | `conjectural`              | First unsupported implication after this turn                                                                                                  |
| `TOP-TWO-INTEGRAL-TRANSVERSAL`                                   | `open`                     | No proof and no counterexample                                                                                                                 |
| `TOP-TWO-PIVOT`                                                  | `open`                     | No proof and no counterexample                                                                                                                 |
| `PositiveIntegerPivotCertificateConjecture`                      | `open`                     | No proof and no counterexample                                                                                                                 |
| Unrestricted Lonely Runner                                       | `open`                     | No claim                                                                                                                                       |

The “finite-sweep minimum” terminology means minimum under the declared finite ordering. It is not a claim of global mathematical minimality.

---

## 2. Fully quantified statements

Let

[
\rho_M(x)=\min(x\bmod M,\ M-(x\bmod M)).
]

For (P>0), define the canonical grid

[
C(P)={r\in\mathbb N: r<NP\ \wedge\ N\nmid r}.
]

For a speed (c), its strict bad set on the (P)-grid is

[
D_P(c)={r\in C(P):\rho_{NP}(rc)<P}.
]

### 2.1 All-pivot target

[
\begin{aligned}
\forall n\ge 1,\quad &N=n+1,\
\forall a:\operatorname{Fin}n\to\mathbb N,\quad
&(\forall i,\ 0<a_i)\to \operatorname{Injective}(a)\to\
&\exists j:\operatorname{Fin}n,\ \exists r\in\mathbb N,\
&\qquad r<Na_j\ \wedge\ N\nmid r\ \wedge
\forall i:\operatorname{Fin}n,\quad
a_j\le \rho_{Na_j}(ra_i).
\end{aligned}
]

This is the exact canonical form of `PositiveIntegerPivotCertificateConjecture`.

### 2.2 Explicit top-two maximality

For (j_A,j_B:\operatorname{Fin}n), put (A=a_{j_A}) and (B=a_{j_B}). Define

[
\operatorname{TopTwo}(a,j_A,j_B)
]

to mean

[
j_A\ne j_B,\qquad A<B,\qquad
\forall i\ne j_B,\quad a_i\le A.
]

Under injectivity, (j_B) is the unique largest-speed index and (j_A) is the unique second-largest-speed index.

### 2.3 `TOP-TWO-PIVOT`

For every (n\ge2), every positive injective (a), and every (j_A,j_B) satisfying `TopTwo`,

[
\begin{aligned}
&\left[
\exists r<NA,\ N\nmid r,\
\forall i,\ A\le \rho_{NA}(ra_i)
\right]\
&\qquad\lor\
&\left[
\exists s<NB,\ N\nmid s,\
\forall i,\ B\le \rho_{NB}(sa_i)
\right].
\end{aligned}
]

This formulation does not assume the original indexing is sorted.

### 2.4 Explicit residual regime used in this turn

The manifest normalizes each tuple primitively. The residual predicate used by both exact implementations is:

[
\begin{aligned}
\operatorname{Residual}(n,a,j_A,j_B):\Longleftrightarrow\quad
&n\ge2,\quad N=n+1,\
&\forall i,\ 0<a_i,\quad \operatorname{Injective}(a),\
&\gcd(a_0,\ldots,a_{n-1})=1,\
&\operatorname{TopTwo}(a,j_A,j_B),\
&B<nA,\
&2B\le NA,\
&\forall q\in\mathbb N,\
\bigl(1\le q\le N\ \wedge\ B<2q\bigr)
\Longrightarrow \exists i,\ a_i=q.
\end{aligned}
]

The last condition says that every integer in

[
\left(\frac B2,N\right]\cap\mathbb Z
]

occurs among the speeds. It is vacuous when (B\ge2N).

The inequalities (B<nA) and (2B\le NA), and the terminal-interval condition, match the accessible exact verifier assertions.   The assertion that this conjunction is definitionally the project’s final combined residual declaration remains `conditional`.

### 2.5 Robust top grids

Let

[
I=\operatorname{Fin}n\setminus{j_A,j_B}.
]

Define

[
R_A={r\in C(A):\rho_{NA}(rB)\ge A},
]

and

[
R_B={s\in C(B):\rho_{NB}(sA)\ge B}.
]

These remove candidates already spoiled by the other top speed.

### 2.6 `TOP-TWO-INTEGRAL-TRANSVERSAL`

For every residual instance,

[
\begin{aligned}
&\left[
\exists r\in R_A,\quad
\forall i\in I,\quad \rho_{NA}(ra_i)\ge A
\right]\
&\qquad\lor\
&\left[
\exists s\in R_B,\quad
\forall i\in I,\quad \rho_{NB}(sa_i)\ge B
\right].
\end{aligned}
]

The conclusion supplies an actual integer numerator on an actual canonical grid. It is not an LP or fractional statement.

---

## 3. New `proved-math` lemmas

### Lemma 1. The pivot coordinate is automatic

Let (P>0) and (r\in C(P)). Then

[
\rho_{NP}(rP)\ge P.
]

#### Proof

Write

[
r=Nq+t,\qquad 0\le t<N.
]

Because (N\nmid r),

[
1\le t\le N-1.
]

Modulo (NP),

[
rP=(Nq+t)P\equiv tP\pmod{NP}.
]

Since (0<tP<NP),

[
\rho_{NP}(rP)
=\min(tP,NP-tP)
=P\min(t,N-t).
]

Both (t) and (N-t) are at least (1), so

[
\rho_{NP}(rP)\ge P.
]

Therefore safety for every coordinate is equivalent to safety for every nonpivot coordinate, but only after this lemma is invoked. ∎

### Lemma 2. The maximality predicate really identifies the top two

Assume (a) is injective and `TopTwo(a,j_A,j_B)` holds. Then (B) is the unique largest value and (A) is the unique second-largest value.

#### Proof

For every (i\ne j_B),

[
a_i\le A<B=a_{j_B}.
]

Thus (j_B) is the unique maximum.

Among indices other than (j_B), (A=a_{j_A}) is maximal. If some (i\ne j_A,j_B) had (a_i=A), injectivity would imply (i=j_A), a contradiction. Hence (j_A) is the unique second maximum. ∎

### Lemma 3. `TOP-TWO-PIVOT` implies the all-pivot target

#### Proof

For (n=1), let the only speed be (P>0), so (N=2). Choose (r=1). Then

[
1<2P,\qquad 2\nmid1,
]

and Lemma 1 gives

[
\rho_{2P}(P)=P.
]

For (n\ge2), a finite injective tuple has a unique largest and unique second-largest value. Choose their indices (j_B,j_A). Lemma 2 gives the quantified maximality conditions, so `TOP-TWO-PIVOT` supplies the required canonical certificate. ∎

### Lemma 4. Exact canonical affine-fiber cardinality

Write

[
A=g\alpha,\qquad B=g\beta,\qquad \gcd(\alpha,\beta)=1,
]

and put

[
L=Ng\alpha\beta,\qquad
d_A=\gcd(N,\alpha),\qquad
d_B=\gcd(N,\beta).
]

For (h\in\mathbb Z/L\mathbb Z), define

[
P_h=\left{
(r,s)\in C(A)\times C(B):
\beta r-\alpha s\equiv h\pmod L
\right}.
]

Then

[
|P_h|
=====

g\left(
N
-d_A,\mathbf 1_{d_A\mid h}
-d_B,\mathbf 1_{d_B\mid h}
+\mathbf 1_{N\mid h}
\right).
]

#### Proof

Consider

[
\Phi:
\mathbb Z/(NA)\times\mathbb Z/(NB)
\longrightarrow
\mathbb Z/L,
\qquad
\Phi(r,s)=\beta r-\alpha s.
]

This is well-defined because

[
\beta NA=L,\qquad \alpha NB=L.
]

Since (\gcd(\alpha,\beta)=1), integers (u,v) exist with

[
\beta u-\alpha v=1.
]

Thus (\Phi) is surjective. The domain has cardinality

[
(NA)(NB)=N^2g^2\alpha\beta,
]

while the codomain has cardinality (L=Ng\alpha\beta). Every unrestricted fiber therefore has size (Ng).

Now exclude pairs with (N\mid r). Writing (r=Nu), the restricted image is generated by (N\beta) and (\alpha). Its gcd with (L) is

[
\gcd(N\beta,\alpha)=\gcd(N,\alpha)=d_A.
]

Hence the equation is solvable exactly when (d_A\mid h). In that case the restricted fiber has size (gd_A).

Similarly, the pairs with (N\mid s) contribute (gd_B) exactly when (d_B\mid h).

If both (N\mid r) and (N\mid s), the image is the subgroup of multiples of (N). Compatibility is exactly (N\mid h), and every compatible fiber has size (g).

Inclusion-exclusion gives

[
Ng-gd_A\mathbf1_{d_A\mid h}
-gd_B\mathbf1_{d_B\mid h}
+g\mathbf1_{N\mid h}.
]

Factoring out (g) gives the formula. ∎

### Lemma 5. Same-owner affine-shift exclusion

Suppose ((r,s)\in P_h), and a lower speed (c) is bad at both endpoints:

[
\rho_{NA}(cr)<A,\qquad
\rho_{NB}(cs)<B.
]

Then

[
\rho_L(ch)<2g\alpha\beta.
]

Consequently,

[
\rho_L(ch)\ge2g\alpha\beta
]

prevents (c) from covering both endpoints of the affine pair.

#### Proof

Because

[
\frac{\beta r}{L}=\frac r{NA},
\qquad
\frac{\alpha s}{L}=\frac s{NB},
]

the affine congruence implies

[
\frac hL\equiv
\frac r{NA}-\frac s{NB}\pmod1.
]

The two strict bad inequalities are equivalent to

[
\left|\frac{cr}{NA}\right|<\frac1N,
\qquad
\left|\frac{cs}{NB}\right|<\frac1N.
]

By the triangle inequality for circle norm,

[
\left|\frac{ch}{L}\right|
<
\frac2N.
]

Multiplying by (L),

[
\rho_L(ch)<\frac{2L}{N}=2g\alpha\beta.
]

∎

### Lemma 6. One-shift affine union certificate

For lower speeds (c,d), define

[
E_{c,d}^h=
\left{
(r,s)\in P_h\cap(R_A\times R_B):
r\in D_A(c),\ s\in D_B(d)
\right}.
]

Let (S={a_i:i\in I}). If both robust grids are covered by (S), then

[
\left|P_h\cap(R_A\times R_B)\right|
\le
\sum_{c,d\in S}|E_{c,d}^h|.
]

Therefore the strict inequality

[
\left|P_h\cap(R_A\times R_B)\right|

>

\sum_{c,d\in S}|E_{c,d}^h|
\tag{A}
]

produces an actual uncovered candidate on one of the two grids.

#### Proof

Assume both robust grids are covered. For every (r\in R_A), choose a lower speed (c\in S) with (r\in D_A(c)). For every (s\in R_B), choose (d\in S) with (s\in D_B(d)).

Thus every robust affine pair ((r,s)) belongs to at least one (E_{c,d}^h). Hence the robust affine fiber is contained in the union of the (E_{c,d}^h), and its cardinality is at most the sum of their cardinalities.

The strict reverse inequality contradicts simultaneous coverage. ∎

Strict inequality is essential. Equality gives no conclusion.

### Lemma 7. Exact robust-moment subtraction

For a pivot (P), let (Q) be the other top speed and (I) the lower indices. For (q\ge0), define

[
H_q^R(P)
========

\sum_{r\in R_P}
\binom{k_P(r)}q,
]

where (k_P(r)) is the number of lower bad sets containing (r).

Then

[
H_q^R(P)
========

\sum_{\substack{J\subseteq I\|J|=q}}
\left(
\left|\bigcap_{i\in J}D_P(a_i)\right|
-------------------------------------

\left|D_P(Q)\cap\bigcap_{i\in J}D_P(a_i)\right|
\right).
]

#### Proof

For a fixed (q)-element subset (J), its intersection restricted to (R_P=C(P)\setminus D_P(Q)) is

[
\bigcap_{i\in J}D_P(a_i)
\setminus D_P(Q).
]

Its cardinality is the displayed difference. Summing over all (J) counts each (r\in R_P) exactly (\binom{k_P(r)}q) times. ∎

Consequences:

* (H_0^R) uses a single bad set.
* (H_1^R) uses pair intersections.
* (H_2^R) uses triple intersections.
* (H_3^R) requires fourfold intersections.

Thus the robust quadratic criterion fits the existing exact single/pair/triple CRT tables. Robust cubic does not.

### Lemma 8. Quadratic multiplicity inequality

Let a finite grid have (m\ge1) bad sets. Let (k(x)\in{0,\ldots,m}) be the multiplicity, (Z=|{x:k(x)=0}|), and

[
H_q=\sum_x\binom{k(x)}q.
]

Then

[
mZ\ge mH_0-mH_1+2H_2.
\tag{Q}
]

#### Proof

Pointwise, for (k=0), both sides contribute (m). For (1\le k\le m), the right-hand contribution is

[
m-mk+2\binom k2
===============

# m-mk+k(k-1)

(k-1)(k-m)\le0.
]

The left-hand contribution is zero. Summing proves the result. ∎

A certificate requires

[
mH_0-mH_1+2H_2>0.
]

Nonstrict nonnegativity is insufficient.

### Lemma 9. Cubic Bonferroni inequality

With the same notation,

[
Z\ge H_0-H_1+H_2-H_3.
\tag{C}
]

#### Proof

For (k=0), the right-hand contribution is (1). For (k\ge1),

[
1-k+\binom k2-\binom k3
=======================

-\binom{k-1}{3}\le0.
]

Summing gives the inequality. ∎

A certificate requires strict positivity of the right-hand side.

### Lemma 10. Quotient-slice integer dual

For (1\le j<N), define

[
R_P(j)={r\in R_P:r\equiv j\pmod N}.
]

For a lower speed (c), let

[
b_{P,c}(j)=|D_P(c)\cap R_P(j)|.
]

Define the combined deficit

[
\delta_j=
|R_A(j)|+|R_B(j)|
-----------------

\sum_{c\in S}
\bigl(b_{A,c}(j)+b_{B,c}(j)\bigr).
]

If both robust grids are covered, then (\delta_j\le0) for every (j).

More generally, for any nonnegative integer slice prices (w_j),

[
\sum_{j=1}^{N-1}w_j\delta_j\le0.
]

Thus strict positivity produces an actual top-grid candidate.

#### Proof

Under coverage, every point of (R_A(j)) is counted by at least one lower bad-set incidence. Therefore

[
|R_A(j)|\le\sum_{c\in S}b_{A,c}(j).
]

The corresponding inequality holds for (R_B(j)). Adding them gives (\delta_j\le0). Multiplication by (w_j\ge0) and summation preserves the inequality. ∎

The dual variables have the explicit arithmetic meaning “prices on nonzero residue classes modulo (N).” Because there is no coupling between slices, the existence of a strict nonnegative price certificate is equivalent to (\max_j\delta_j>0).

---

## 4. Three integral approaches and adversarial selection

### Approach A. Cross-pivot affine fibers

**Objects.** Exact fibers (P_h), robust fibers (P_h^*=P_h\cap(R_A\times R_B)), lower blocker sets, and same-owner exclusions from Lemma 5.

**One-shift sufficient inequality.**

[
|P_h^*|>\sum_{c,d\in S}|E_{c,d}^h|.
]

Strict inequality is required.

**Outcome.** The implication is `proved-math`, but the uniform criterion is `rejected`.

* On the residual tuple

  [
  (1,2,3,4,5,6,7,18),
  ]

  its best exact margin is (0), with

  [
  h=61,\qquad |P_h^*|=6,\qquad
  \sum_{c,d}|E_{c,d}^h|=6.
  ]

* On OPT-ADD,

  [
  (15,21,40,48,56,105,126,280,1200),
  ]

  its best exact margin is

  [
  -104,
  ]

  at

  [
  h=13089,\qquad |P_h^*|=280,\qquad
  \sum_{c,d}|E_{c,d}^h|=384.
  ]

**Surviving subroute.** Multiple shifts, with integral owner consistency across all selected affine pairs. This survives because the same lower-speed set must hit both endpoints of every selected pair, rather than merely paying its multiplicity independently on each pair.

For ((N,A,B)=(7,98,187)), 14 shifts give 64 robust affine-pair constraints. Every four-element subset of ({1,\ldots,97}) fails at least one constraint, while

[
{7,63,70,77,84}
]

hits every constraint. Thus the exact transversal number of that finite constraint system is (5). The original project verifier records the same 14 shifts and transversal number. 

**Adversarial judgment.** Selected, but only in bounded multi-shift integral form. Single-shift cardinality is dead.

### Approach B. Forced overlap from exact CRT moments

Four criteria were tested:

[
\begin{aligned}
\mathrm{FQ2}(P)&=(n-1)H_0-(n-1)H_1+2H_2,\
\mathrm{FQ3}(P)&=H_0-H_1+H_2-H_3,\
\mathrm{RQ2}(P)&=(n-2)H_0^R-(n-2)H_1^R+2H_2^R,\
\mathrm{RQ3}(P)&=H_0^R-H_1^R+H_2^R-H_3^R.
\end{aligned}
]

A criterion certifies a top pivot only when its score is **strictly positive**.

* `FQ2` and `FQ3` use full candidate grids.
* `RQ2` and `RQ3` first remove candidates spoiled by the other top speed.
* `RQ2` is exactly expressible using the existing single, pair, and triple intersection formulas.
* `RQ3` needs fourfold intersections after robust subtraction.

**Outcome.** Every fixed criterion is `rejected`.

The strongest, `RQ3`, passes all recovered named stress rows but fails exactly at

[
(1,3,4,5,7,11),
]

and already fails inside the explicit residual at

[
(1,4,5,6,7,11).
]

The project’s exact stress artifacts use the same strict bad endpoint, including CHAIN3 and OPT-ADD.  

**Adversarial judgment.** Rejected as a uniform route. A fixed third-order inequality is insufficient. Increasing fixed depth would also re-enter the already known nonuniform moment obstruction.

### Approach C. Quotient-slice integer LP dual

The dual prices the (N-1) nonzero classes modulo (N). It is integral, arithmetic, and does not use one variable per candidate.

**Criterion.**

[
\max_{1\le j<N}\delta_j>0.
]

Strict positivity is required.

**Outcome.** `rejected` at

[
(5,10,11,12),
]

where

[
(\delta_1,\delta_2,\delta_3,\delta_4)=(-1,0,0,-1).
]

Both top grids nevertheless contain eight safe residues.

**Adversarial judgment.** Rejected. Any useful LP dual must couple different quotient slices or encode affine ownership. Independent slice prices are too weak.

---

## 5. Exact stress evaluations

Notation:

* `S` is the pair of exact safe counts.
* `F2`, `F3`, `R2`, `R3` are the two top-pivot scores.
* `sl` is the best quotient-slice deficit.
* `af` is the best one-shift affine margin.
* Every criterion requires a strictly positive value.
* For paired values, at least one component must be positive.

```text
name          top(A,B)    S          F2                 F3
                                      R2                 R3          sl    af
RF            (16,19)     (12,10)    (-348,-400)       (-32,-69)
                                      (-134,-190)       (-32,4)      -9     3

GCD_CLOCK_1   (75,78)     (70,72)    (-1716,-1888)     (-24,-62)
                                      (-644,-680)       (6,44)       -28    8

GCD_CLOCK_2   (48,75)     (44,82)    (-1316,-1720)     (-18,-38)
                                      (-578,-780)       (0,60)       -36    7

HARD_A        (12,13)     (6,8)      (-168,-178)       (-16,-32)
                                      (-48,-72)         (-14,8)      -3     5

HARD_B        (13,15)     (10,12)    (-198,-174)       (-10,-28)
                                      (-44,-44)         (-10,12)     -5     4

SMALL         (3,5)       (2,2)      (4,4)             (2,2)
                                      (4,4)             (2,2)         1     2

STRESS_C      (75,78)     (74,74)    (-1750,-1904)     (-24,-78)
                                      (-650,-688)       (0,32)       -28    6

STRESS_D      (71,91)     (80,92)    (-1766,-2198)     (10,-46)
                                      (-740,-1016)      (28,82)      -34    5

STRESS_E      (148,165)   (146,152)  (-3580,-3766)     (-12,-216)
                                      (-1410,-1644)     (26,82)      -94    8

CHAIN3        (132,147)   (128,144)  (-3048,-3520)     (-88,-76)
                                      (-1194,-1350)     (24,54)      -65   15

OPT_ADD       (280,1200)  (382,1518) (-5496,-28504)    (152,178)
                                      (-2486,-10932)    (196,842)   -470 -104

AFFINE_HARD   (98,187)    (90,168)   (-232,-528)       (30,60)
                                      (220,384)         (70,132)     -30    5
```

The recovered verifier exposes the three tuples `C`, `D`, and `E`, but the accessible artifact did not bind them unambiguously to the labels anchor-star, dispersion-star, and TOP-CYCLE. All three exact tuples were tested; I did not guess the alias assignment. The exact tuple list is preserved in the source artifact. 

### Consecutive family, complete (n=2,\ldots,30)

Each row is

```text
n: safe | F2 | F3 | R2 | R3 | slice | affine
```

```text
 2: (2,2)   | (2,2)         | (2,2)         | (2,2)         | (2,2)         |   2 |  2
 3: (2,2)   | (4,4)         | (2,2)         | (2,2)         | (2,2)         |   2 |  2
 4: (4,4)   | (8,12)        | (4,4)         | (8,8)         | (4,4)         |   2 |  4
 5: (2,2)   | (0,-2)        | (2,0)         | (6,4)         | (2,2)         |   0 |  4
 6: (6,6)   | (-2,18)       | (4,-2)        | (20,16)       | (4,6)         |   2 |  6
 7: (4,4)   | (-16,-38)     | (-4,-16)      | (8,6)         | (-4,4)        |   0 |  4
 8: (6,6)   | (-92,-60)     | (-16,-34)     | (-16,-28)     | (-14,6)       |  -1 |  7
 9: (4,4)   | (-96,-136)    | (-36,-71)     | (-14,-50)     | (-36,2)       |   0 |  8
10: (10,10) | (-182,-154)   | (-70,-106)    | (-52,-60)     | (-62,6)       |  -1 | 10
11: (4,4)   | (-368,-380)   | (-112,-184)   | (-218,-190)   | (-112,-4)     |  -2 |  8
12: (12,12) | (-520,-312)   | (-188,-244)   | (-200,-204)   | (-164,-4)     |  -2 | 12
13: (6,6)   | (-508,-822)   | (-250,-380)   | (-324,-428)   | (-250,-16)    |   0 | 12
14: (8,8)   | (-1110,-984)  | (-392,-480)   | (-712,-760)   | (-352,-40)    | -10 |  5
15: (8,8)   | (-1124,-1242) | (-490,-670)   | (-616,-814)   | (-474,-38)    |  -4 | 12
16: (16,16) | (-1360,-1448) | (-678,-816)   | (-816,-900)   | (-604,-72)    |  -5 | 16
17: (6,6)   | (-1920,-2232) | (-834,-1119)  | (-1452,-1532) | (-834,-100)   |   0 |  6
18: (18,18) | (-2702,-2146) | (-1138,-1274) | (-1768,-1728) | (-986,-154)   | -10 | 18
19: (8,8)   | (-3048,-3336) | (-1286,-1704) | (-2446,-2270) | (-1286,-136)  |  -6 | 16
20: (12,12) | (-4136,-3542) | (-1754,-1932) | (-2816,-2984) | (-1562,-300)  | -14 |  3
21: (10,10) | (-3828,-4470) | (-1956,-2450) | (-2676,-3084) | (-1876,-236)  |  -8 | 20
22: (22,22) | (-4878,-5274) | (-2442,-2766) | (-3792,-3948) | (-2202,-406)  | -17 | 22
23: (8,8)   | (-6212,-6530) | (-2818,-3462) | (-5140,-5172) | (-2818,-442)  |  -8 | -3
24: (20,20) | (-7756,-6538) | (-3510,-3706) | (-5444,-5668) | (-2996,-626)  | -13 | 23
25: (12,12) | (-7004,-8860) | (-3734,-4689) | (-5526,-6352) | (-3702,-468)  |  -4 | 24
26: (18,18) | (-9684,-9948) | (-4728,-5110) | (-7976,-8236) | (-4288,-1030) | -27 | 25
27: (12,12) | (-11044,-11624)| (-5168,-6054) | (-8798,-9728) | (-4944,-794)  | -16 | 24
28: (28,28) | (-12116,-11664)| (-6044,-6546) | (-9292,-9468) | (-5380,-1122) | -22 | 28
29: (8,8)   | (-14144,-14702)| (-6670,-7968) | (-12392,-11548)|(-6670,-1168) |  -8 | -6
30: (30,30) | (-16898,-13870)| (-7996,-8232) | (-12756,-12360)|(-6836,-1680) | -24 | 30
```

This family kills every fixed moment criterion tested while retaining exact top-two witnesses throughout.

---

## 6. Smallest exact failures returned by the declared sweep

### 6.1 Finite-order minima

| Criterion              | First failure in full sweep | First failure inside explicit residual |
| ---------------------- | --------------------------- | -------------------------------------- |
| Full quadratic         | ((1,2,3,4,5))               | ((1,4,5,6,7))                          |
| Full cubic             | ((1,2,3,4,5,7))             | ((1,3,4,5,6,7))                        |
| Robust quadratic       | ((1,2,3,4,5,7))             | ((1,2,5,6,7,8))                        |
| Robust cubic           | ((1,3,4,5,7,11))            | ((1,4,5,6,7,11))                       |
| Quotient-slice dual    | ((5,10,11,12))              | same                                   |
| One-shift affine union | ((1,3))                     | ((1,2,3,4,5,6,7,18))                   |

### 6.2 Full quadratic failure

Tuple:

[
(1,2,3,4,5),\qquad N=6,\quad A=4,\quad B=5.
]

Pivot (4):

[
\operatorname{Safe}_4=(4,20),
]

and at (r=4),

[
(\rho_{24}(4a_i))_i=(4,8,12,8,4).
]

Moments:

[
(H_0,H_1,H_2,H_3)=(20,24,8,2),
]

so

[
\mathrm{FQ2}(4)=0.
]

Pivot (5):

[
\operatorname{Safe}_5=(5,25),
]

and at (r=5),

[
(\rho_{30}(5a_i))_i=(5,10,15,10,5).
]

Moments:

[
(H_0,H_1,H_2,H_3)=(25,34,17,8),
]

so

[
\mathrm{FQ2}(5)=-2.
]

Neither top score is strictly positive, despite both top grids having safe candidates.

### 6.3 Full cubic and robust quadratic failure

Tuple:

[
(1,2,3,4,5,7),\qquad N=7,\quad A=5,\quad B=7.
]

Pivot (5):

[
\operatorname{Safe}_5=(6,29),
]

with first-witness distances

[
(6,12,17,11,5,7).
]

[
H=(30,38,16,8),\qquad
\mathrm{FQ3}(5)=0.
]

The robust moments are

[
H^R=(24,32,16,8),
]

so

[
\mathrm{RQ2}(5)=0.
]

Pivot (7):

[
\operatorname{Safe}_7=(8,41),
]

with first-witness distances

[
(8,16,24,17,9,7).
]

[
H=(42,60,34,22),\qquad
\mathrm{FQ3}(7)=-6.
]

[
H^R=(30,38,12,2),\qquad
\mathrm{RQ2}(7)=-8.
]

### 6.4 Robust cubic failure

Full-sweep minimum:

[
(1,3,4,5,7,11),\qquad N=7,\quad A=7,\quad B=11.
]

Pivot (7):

[
\operatorname{Safe}_7=(8,41),\qquad
H^R=(30,38,16,8),\qquad
\mathrm{RQ3}(7)=0.
]

Pivot (11):

[
\operatorname{Safe}_{11}=(13,64),\qquad
H^R=(48,58,18,8),\qquad
\mathrm{RQ3}(11)=0.
]

The criterion fails by equality on both top grids.

The first residual failure is sharper:

[
(1,4,5,6,7,11).
]

Pivot (7):

[
\operatorname{Safe}_7=(15,34),
]

with first-witness distances

[
(15,11,23,8,7,18),
]

and

[
H^R=(30,38,16,8),\qquad \mathrm{RQ3}(7)=0.
]

Pivot (11) is fully covered:

[
\operatorname{Safe}_{11}=\varnothing,
]

but

[
H^R=(48,58,12,2),\qquad \mathrm{RQ3}(11)=0.
]

Thus top-two is true through pivot (7), while robust cubic certifies neither top grid.

### 6.5 Quotient-slice dual failure

Tuple:

[
(5,10,11,12),\qquad N=5.
]

The deficits are

[
(-1,0,0,-1).
]

Nevertheless,

[
\operatorname{Safe}_{11}
=(3,7,8,26,29,47,48,52),
]

and

[
\operatorname{Safe}_{12}
=(3,4,8,9,51,52,56,57).
]

At (r=3), the pivot-(11) distances are

[
(15,25,22,19),
]

and the pivot-(12) distances are

[
(15,30,27,24).
]

### 6.6 One-shift affine failure

The absolute finite minimum is

[
(1,3),\qquad N=3.
]

The (A=1) robust grid is empty, so the affine score has no nonempty fiber. Pivot (3) has

[
\operatorname{Safe}_3=(4,5),
]

and at (r=4),

[
(\rho_9(4),\rho_9(12))=(4,3).
]

The first meaningful residual failure is

[
(1,2,3,4,5,6,7,18),\qquad N=9.
]

Pivot (7):

[
\operatorname{Safe}_7=(8,55),
]

with first-witness distances

[
(8,16,24,31,23,15,7,18).
]

Pivot (18):

[
\operatorname{Safe}_{18}
=(19,20,60,61,101,102,142,143),
]

with first-witness distances

[
(19,38,57,76,67,48,29,18).
]

The best affine row is

[
h=61,\qquad |P_h^*|=6,\qquad U_h=6.
]

The required strict inequality fails by equality.

OPT-ADD gives the stronger negative margin

[
|P_h^*|-U_h=280-384=-104.
]

All complete canonical-grid rows, including every safe residue and every score component, are retained in the literal output.

---

## 7. Deterministic sweep and independent agreement

### Domain

| Category                                      |     Count |
| --------------------------------------------- | --------: |
| Recovered stress tuples                       |        12 |
| Primitive sorted (n=2), maximum (30)          |       277 |
| Primitive sorted (n=3), maximum (24)          |     1,747 |
| Primitive sorted (n=4), maximum (18)          |     2,919 |
| Primitive sorted (n=5), maximum (14)          |     1,981 |
| Primitive sorted (n=6), maximum (12)          |       923 |
| Consecutive families (n=2,\ldots,30)          |        29 |
| Structured CRT mutations                      |        93 |
| Affine-fiber mutations                        |         8 |
| Large-gap boundary mutations                  |        48 |
| Saturated mutations                           |        53 |
| Deletion mutations used only as stress inputs |        18 |
| **Total**                                     | **8,108** |

The mutation results were:

| Mutation class  | Rows | Top-two covers | FQ2 fails | FQ3 fails | RQ2 fails | RQ3 fails | Slice fails | Affine fails |
| --------------- | ---: | -------------: | --------: | --------: | --------: | --------: | ----------: | -----------: |
| Structured CRT  |   93 |              0 |        91 |        54 |        91 |         2 |          91 |            2 |
| Affine-fiber    |    8 |              0 |         8 |         0 |         0 |         0 |           7 |            0 |
| Large-gap       |   48 |              0 |        25 |        28 |        13 |        22 |          33 |            5 |
| Saturated       |   53 |              0 |        34 |        33 |        27 |        18 |          32 |           21 |
| Deletion stress |   18 |              0 |        18 |        11 |        18 |         1 |          18 |            0 |

Here “top-two covers” means exact tuples whose two top grids were both covered. None were found.

### Exact implementation agreement

* Version: `PROB-62-v1.0.0`
* Python: `3.13.5`
* Compiler: `g++ 14.2.0`
* Platform: `Linux 6.12.13 x86_64, glibc 2.41`
* Literal implementation: direct scan of every canonical residue and literal robust affine-pair enumeration
* Optimized implementation: independent C++ implementation using grouped circular cross-correlation for affine fibers
* Output agreement: **byte-identical**
* Exact CRT formula versus literal enumeration: **2,340 intersections checked**
* Ordering:

  1. recovered stress rows in declared order;
  2. primitive boxes by increasing (n), then lexicographic combinations;
  3. consecutive rows;
  4. structured CRT mutations;
  5. affine mutations;
  6. large-gap mutations;
  7. saturated mutations;
  8. deletion stress mutations.
* Finite-minimum key: ((n,\max a,\text{lexicographic tuple}))

### Runtime

| Component                        |    Wall |    User | System | Maximum RSS |
| -------------------------------- | ------: | ------: | -----: | ----------: |
| Literal Python sweep             | 15.30 s | 15.41 s | 0.28 s |  116,344 KB |
| Optimized C++ sweep              |  1.13 s |  0.83 s | 0.29 s |   15,208 KB |
| Independent hard-affine verifier |  5.83 s |  6.01 s | 0.20 s |  109,960 KB |

### Hashes

```text
source_bundle_sha256
af4733165e80c51217e1c8f1e52a9259b948071770578aca7df0f84ad5b43756

manifest_sha256
585c2237f294908f8a5d396c8859abf3b07b283f15b204db984ee3e240394411

literal_output_sha256
233b2d03c6289d151d00355827b0994b766028a43ba4fb3c602945d0e0851236

optimized_output_sha256
233b2d03c6289d151d00355827b0994b766028a43ba4fb3c602945d0e0851236

hard_affine_output_sha256
8d130da9b82d1833009cd901d01805e44760af6a85e06a1d8da1f462e4d0b73f

hard_affine_constraint_sha256
6b9c45fcd1abe2e0eb5c157b243ceb4b3276211e5df824e0be85e9a791bd4246

report_sha256
f9810398efbb676f4c59bdfa1385d936ceed99963494758d726baa8f2d16c75a

reproducibility_bundle_sha256
5676307f590cf37a9545a3d324abbe988779dad3d668acafbe0e6079bf146e36
```

---

## 8. Single first unsupported implication

Define, for (r\in R_A) and (s\in R_B),

[
X_A(r)=
{c\in{1,\ldots,A-1}:\rho_{NA}(rc)<A},
]

[
X_B(s)=
{c\in{1,\ldots,A-1}:\rho_{NB}(sc)<B}.
]

For a set of shifts (H\subseteq\mathbb Z/L\mathbb Z), define (\tau_H(N,A,B)) to be the least cardinality of a set

[
S\subseteq{1,\ldots,A-1}
]

such that, for every (h\in H) and every ((r,s)\in P_h^*),

[
S\cap X_A(r)\ne\varnothing
\quad\text{and}\quad
S\cap X_B(s)\ne\varnothing.
]

If no such (S) exists, put (\tau_H=\infty).

### `RESIDUAL-2N-SHIFT-OWNER-TRANSVERSAL`

For every residual top pair,

[
\exists H\subseteq\mathbb Z/L\mathbb Z,\qquad
|H|\le2N,\qquad
\tau_H(N,A,B)>n-2.
\tag{T}
]

Status: `conjectural`.

### Why (T) suffices

The actual lower-speed set has exactly (n-2) elements and is contained in ({1,\ldots,A-1}). If it covered both robust grids, it would hit both endpoints of every robust affine pair for every shift set (H). Therefore it would witness

[
\tau_H\le n-2.
]

This contradicts (T), so one robust grid contains an actual lower-safe integer candidate. Lemma 1 supplies the pivot coordinate, and membership in (R_A) or (R_B) supplies safety against the other top speed.

### Exact hard-row evidence

For

[
(N,A,B)=(7,98,187),
]

the independently checked shift set has

[
|H|=14=2N,
]

with 64 robust affine-pair constraints and

[
\tau_H=5>4=n-2.
]

This is `computed finite evidence` for one top pair. It is not evidence that an arbitrary search-selected (H) has a uniform arithmetic construction.

The next turn must produce either:

1. an arithmetic rule selecting the at most (2N) shifts, or
2. a CRT/energy/Hall-type lower bound proving (\tau_H>n-2).

A generic solver that searches the entire cover instance and then reports (H) would be too close to a cover restatement.

---

## 9. Next Lean declaration

None.

The affine-fiber cardinality formula is formalization-ready, but formalizing it alone would not shorten the first unsupported implication. Every fixed inequality close enough to formalize was refuted. No Lean-prototype budget was spent on a rejected or tautological statement.

---

## 10. Stop and continue decisions

### Top-two route

**Continue narrowly for one additional major turn.**

The permitted target is only `RESIDUAL-2N-SHIFT-OWNER-TRANSVERSAL`, with an arithmetic shift selector or a genuine owner-capacity inequality. Fixed moments, independent slice prices, and one-shift union bounds are frozen as `rejected`.

If the next turn yields only unrestricted search-generated transversals, fractional relaxations, or full-cover encodings, the top-two route should be frozen at the route cap.

### All-pivot route

**Hold.**

No exact top-two cover was found, so there is no reason yet to abandon the strengthening and switch to all pivots. The all-pivot proposition remains `open` and untouched by this turn.

## Artifacts

* [Exact sweep report](sandbox:/mnt/data/pro_b62/pro_b_sweep_report.txt)
* [Complete reproducibility bundle](sandbox:/mnt/data/pro_b62/pro_b62_bundle.tar.gz)
* [Deterministic manifest](sandbox:/mnt/data/pro_b62/pro_b_manifest.txt)
* [Literal exact output](sandbox:/mnt/data/pro_b62/pro_b_literal.out)
* [Optimized exact output](sandbox:/mnt/data/pro_b62/pro_b_optimized.out)
* [Independent hard-affine transcript](sandbox:/mnt/data/pro_b62/pro_b_affine_hard.out)
* [SHA-256 manifest](sandbox:/mnt/data/pro_b62/SHA256SUMS)
