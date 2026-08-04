## 1. Disposition

**OPEN**

All mandatory support identities are valid:

[
\operatorname{CoveredUnit}_j=G_j(1),\qquad
\operatorname{DefUnit}_j
=#{r\in U(M_j):\mu_j(r)=0},
]

the Möbius inversion is correctly oriented and must be evaluated in `Int`, the scaling formula is exact with a pivot-dependent positive factor, and permutation invariance holds.

Two independent implementations reproduced every mandatory hand table, the complete prescribed primitive domain of 12,168 tuples, and 6,000 additional deterministic structured mutations. They found no tuple with (\Omega_{\rm Unit}=0).

No argument in Lanes A–D establishes the required cross-pivot strict positivity. No proved unrestricted theorem produced here is strong enough to qualify as `PIVOT`. The first open arrow remains

[
\sum_j\left(\phi(Na_j)-G_j(1)\right)>0.
]

Finite zero failures do not promote this statement.

---

## 2. Independent boundary audit

The arithmetic audit used only the frozen definitions in the prompt. The accepted Lean results are used only in Section 16 for the final conditional implication chain. They were not used to infer the unit-stratum lemma.

The following routes were not used as premises:

* common-clock scores, denominators, occupancy, or Prompt93 reciprocity;
* Fejér kernels, common-clock Fourier smoothing, or selected translates;
* obstruction-prime supply or product bounds;
* balanced junction bags or separators;
* fastest-covered-row redundancy or cover deletion;
* dyadic product divisibility;
* packing tokens, phase cells, LP duality, or radial descent;
* height compression, minimal counterexamples, divisor-block deletion, or unchanged multishifts;
* an ordinary pivot certificate or unrestricted Lonely Runner as an input.

Evidence classes used below are:

* **proved-math-qualified** for the elementary finite identities proved here;
* **computed finite evidence** for the two implementation outputs;
* **conditional** for the implication from the sole lemma to integer and real Lonely Runner;
* **rejected** for the fixed-pivot ordinary-to-unit implication, first-moment positivity, CRT factorization of strict arcs, and signed sums in `Nat`;
* **open** for all-pivot unit-stratum positivity.

No unspecified repository tuple or repository result was treated as an immutable input. The concrete stress tuples appearing in the frozen prompt and the two concrete packing tuples identified in the surrounding research context were evaluated directly.

---

## 3. Pivot definitions

Fix (n\ge2), (N=n+1), and a positive injective tuple (a). At pivot (j), put

[
p=a_j,\qquad M=Np.
]

Representatives are always the canonical integers (0\le r<M). The candidate set is

[
R_j={r:0\le r<M,\ N\nmid r}.
]

Exactly (p) representatives are multiples of (N), so

[
|R_j|=M-p=np.
]

For (r\in R_j), write uniquely

[
r=Nq+s,\qquad 1\le s\le N-1.
]

Then

[
r a_j=(Nq+s)p\equiv sp\pmod{Np},
]

and therefore

[
\rho_M(r a_j)
=p\min(s,N-s)\ge p.
]

Equality occurs when (s=1) or (s=N-1), and is safe because badness is strict.

For each labelled owner (i\ne j),

[
B_i^j={r\in R_j:\rho_M(r a_i)<p}.
]

The multiplicity

[
\mu_j(r)=#{i:i\ne j,\ r\in B_i^j}
]

counts labels. If two owners induce identical modular bad sets, they still contribute two to (\mu_j(r)). Repeated products, noninjective multiplication maps modulo (M), zero products, and coincident bad sets are retained.

The threshold predicate (1\le\mu_j(r)) is nevertheless a residue predicate. Consequently, (K_j(d)) counts a covered residue once, not once per covering label.

Finally,

[
\mu_j(r)=0
]

is equivalent to

[
\rho_M(r a_i)\ge p
\quad\text{for every }i\ne j.
]

Together with the separate pivot calculation above, this is exactly the canonical pivot-safety condition.

---

## 4. Divisor lattice

For fixed (j), abbreviate

[
C(r)=1_{[r\in R_j,\ \mu_j(r)\ge1]}.
]

Then, for (d\mid M),

[
K_j(d)=\sum_{r=0}^{M-1} C(r),1_{[d\mid r]}.
]

For (g\mid M),

[
G_j(g)=\sum_{r=0}^{M-1}
C(r),1_{[\gcd(r,M)=g]}.
]

### Exact strict-interval formula for (K_j(d))

Put

[
L=\frac Md,\qquad
\nu=\frac{N}{\gcd(N,d)}.
]

Writing (r=du), (0\le u<L), gives

[
N\nmid r\iff \nu\nmid u.
]

For an owner (i\ne j), define

[
c_i=\gcd(a_i,L),\qquad
m_i=\frac{L}{c_i},\qquad
b_i=\frac{a_i}{c_i},
]

so that (\gcd(b_i,m_i)=1). Then

[
\begin{aligned}
\rho_M(du,a_i)
&=d,\rho_L(u a_i)\
&=d c_i,\rho_{m_i}(u b_i).
\end{aligned}
]

Thus, with

[
H_i=\left\lfloor\frac{p-1}{d c_i}\right\rfloor,
]

the strict bad condition is

[
\rho_{m_i}(u b_i)\le H_i.
]

Since (p=dL/N),

[
H_i<\frac{m_i}{N}\le\frac{m_i}{3},
]

so the two cyclic sides are disjoint and the owner arc is exactly

[
A_i={0,\ldots,H_i}
\cup
{m_i-H_i,\ldots,m_i-1}.
]

For a nonempty owner-label set (S), choose (y_i\in A_i) and put

[
x_i\equiv b_i^{-1}y_i\pmod{m_i}.
]

The congruences (u\equiv x_i\pmod{m_i}), (i\in S), are compatible exactly when

[
x_i\equiv x_k
\pmod{\gcd(m_i,m_k)}
\quad\text{for all }i,k\in S.
]

If compatible and

[
\ell_S=\operatorname{lcm}_{i\in S}m_i,
]

they have (L/\ell_S) solutions modulo (L). The solutions that must be removed because (\nu\mid u) exist exactly when additionally

[
x_i\equiv0\pmod{\gcd(m_i,\nu)}
\quad\text{for every }i\in S,
]

and then there are

[
\frac{L}{\operatorname{lcm}(\ell_S,\nu)}
]

such solutions.

Consequently, the exact intersection count (T_j(d,S)) is the sum over the finite choices (y_i\in A_i) of

[
1_{\rm compat}\frac L{\ell_S}
-----------------------------

1_{\rm compat\ with\ \nu},
\frac{L}{\operatorname{lcm}(\ell_S,\nu)}.
]

The covered layer is therefore exactly

[
K_j(d)=
\sum_{\varnothing\ne S\subseteq{i:i\ne j}}
(-1)^{|S|+1}T_j(d,S).
]

This formula retains noncoprime moduli, (\gcd(d,N)>1), all cyclic sides, zero products, and duplicate labelled sets.

### Zeta identity

If (\gcd(r,M)=g) and (d\mid M), then

[
d\mid r\iff d\mid g.
]

Partitioning the covered residues by exact gcd therefore gives

[
K_j(d)=\sum_{\substack{g\mid M\d\mid g}}G_j(g).
]

### Möbius inversion

For (g\mid M), define in `Int`

[
H(g)=
\sum_{\substack{d\mid M\g\mid d}}
\operatorname{mob}(d/g)K_j(d).
]

Substituting the zeta identity and exchanging the two finite sums,

[
\begin{aligned}
H(g)
&=
\sum_{\substack{d\mid M\g\mid d}}
\operatorname{mob}(d/g)
\sum_{\substack{e\mid M\d\mid e}}G_j(e)\
&=
\sum_{\substack{e\mid M\g\mid e}}
G_j(e)
\sum_{\substack{d:g\mid d\mid e}}
\operatorname{mob}(d/g).
\end{aligned}
]

Writing (q=d/g) and (m=e/g), the inner sum is

[
\sum_{q\mid m}\operatorname{mob}(q)
===================================

\begin{cases}
1,&m=1,\
0,&m>1.
\end{cases}
]

Only (e=g) remains, proving

[
G_j(g)=
\sum_{\substack{d\mid M\g\mid d}}
\operatorname{mob}(d/g)K_j(d).
]

In particular,

[
G_j(1)=\sum_{d\mid M}\operatorname{mob}(d)K_j(d).
]

The divisor order in the implementations is ascending numerical order. The algebra is order-independent only because the sum is evaluated in `Int`.

---

## 5. Unit deficit support

Let

[
U(M)={r:0\le r<M,\ \gcd(r,M)=1}.
]

Because (N\mid M), any multiple of (N) has gcd at least (N>1) with (M). Therefore

[
U(M)\subseteq R_j.
]

Also (0\notin U(M)), and

[
|U(M)|=\phi(M).
]

By Section 4,

[
\operatorname{CoveredUnit}_j
============================

# \sum_{d\mid M}\operatorname{mob}(d)K_j(d)

G_j(1).
]

Since (G_j(1)) is the number of covered unit residues,

[
\begin{aligned}
\operatorname{DefUnit}_j
&=\phi(M)-G_j(1)\
&=#{r:0\le r<M,\ \gcd(r,M)=1,\ \mu_j(r)=0}.
\end{aligned}
]

Hence

[
\operatorname{DefUnit}_j\ge0.
]

It follows that

[
\Omega_{\rm Unit}(a)>0
]

is equivalent to the existence of (j,r) satisfying

[
\gcd(r,M_j)=1,\qquad \mu_j(r)=0.
]

No signed sum is being used as a concealed uncovered count; the signed sum has been proved equal to the exact-gcd count first.

There is also a useful parity fact. The map (r\mapsto M-r) preserves unit status and every strict bad predicate. It has no fixed unit point for (M\ge3). Thus

[
\operatorname{DefUnit}_j\equiv0\pmod2.
]

This explains why every positive row deficit in the controls is at least two, but it does not prove that any row deficit is positive.

---

## 6. Scaling and permutation

Let (A_i=h a_i), with (h\ge1). At pivot (j),

[
M'=N A_j=hM.
]

For a residue (r\pmod M), its (h) lifts are

[
r+tM,\qquad 0\le t<h.
]

For every owner label (i),

[
\begin{aligned}
(r+tM)(h a_i)
&\equiv h r a_i\pmod{hM},\
\rho_{hM}((r+tM)(h a_i))
&=h,\rho_M(r a_i).
\end{aligned}
]

The scaled threshold is (h p), so every lift has exactly the same labelled badness pattern as (r).

Define

[
s(h,M)=
\prod_{\substack{\ell\text{ prime}\\ell\mid h,\ \ell\nmid M}}\ell.
]

This is a squarefree divisor of (h). A prime (\ell\mid h) that already divides (M) never divides a lift (r+tM), because (r) is a unit modulo (M). For each new prime (\ell\mid s(h,M)), exactly one class of (t\pmod\ell) makes (r+tM\equiv0\pmod\ell). Therefore the number of unit lifts is

[
h\prod_{\ell\mid s(h,M)}
\left(1-\frac1\ell\right)
=========================

\frac{h}{s(h,M)}\phi(s(h,M)).
]

Thus

[
\lambda(h,M)
============

\frac{h}{s(h,M)}\phi(s(h,M))
]

is a positive integer independent of the chosen base unit (r), and

[
\boxed{
\operatorname{DefUnit}_j(h a)
=============================

\lambda(h,M_j(a))
\operatorname{DefUnit}_j(a).
}
]

The factor is pivot-dependent.

For (a=(1,3,4)), whose deficits are ((0,2,2)):

| (h) | Base moduli (M) | (s(h,M)) | (\lambda(h,M)) | Scaled deficits |
| --: | --------------- | -------- | -------------- | --------------- |
|   2 | (4,12,16)       | (1,1,1)  | (2,2,2)        | ((0,4,4))       |
|   5 | (4,12,16)       | (5,5,5)  | (4,4,4)        | ((0,8,8))       |
|   6 | (4,12,16)       | (3,1,3)  | (4,6,4)        | ((0,12,8))      |

The (h=6) control explicitly rejects the false formula
(\Omega_{\rm Unit}(h a)=h\Omega_{\rm Unit}(a)).

Because all (\lambda(h,M)) are positive,

[
\Omega_{\rm Unit}(h a)>0
\iff
\Omega_{\rm Unit}(a)>0.
]

A label permutation (\sigma) sends the row labelled (k) to the old row labelled (\sigma(k)). Its modulus, owner predicates, multiplicities, and exact-gcd layers are unchanged after relabelling. Hence the row deficits are permuted and

[
\Omega_{\rm Unit}(a\circ\sigma)
===============================

\Omega_{\rm Unit}(a).
]

For example,

[
\begin{array}{c|c}
a&(\operatorname{DefUnit}_j)_j\ \hline
(1,3,4)&(0,2,2)\
(4,1,3)&(2,0,2)\
(3,4,1)&(2,2,0)
\end{array}
]

with (\Omega_{\rm Unit}=4) in all three orders.

---

## 7. Anti-equivalence

For

[
a=(1,2,3),\qquad N=4,
]

consider the pivot (p=3), (M=12). The complete safe candidate set in that row is

[
{3,9}.
]

Both are nonunits:

[
\gcd(3,12)=\gcd(9,12)=3.
]

At (r=3),

[
\rho_{12}(3\cdot1)=3=p,
]

so the endpoint is safe. Nevertheless, every unit (r\in{1,5,7,11}) is covered, and

[
\operatorname{DefUnit}_{p=3}=0.
]

Thus an ordinary certificate at a fixed pivot does not imply a unit certificate at that pivot.

For the abstract two-row fixture:

* row (0), modulo (3): both units (1,2) are covered;
* row (1), modulo (6): units (1,5) are covered, while nonunits (2,4) are uncovered.

The system has ordinary uncovered candidates and zero total unit deficit. It respects reflection symmetry and the distinction between candidates and units. Therefore ordinary existence plus the row definitions does not definitionally imply the unit-stratum target.

No ordinary certificate, Lonely Runner witness, or counterexample assumption is used anywhere in Sections 3–15 to establish unit-stratum positivity.

---

## 8. Symbolic families

For the consecutive tuple

[
a=(1,2,\ldots,n),
\qquad N=n+1,
]

take the pivot (p=1), (M=N). If (r\in U(N)), multiplication by (r) permutes all residue classes modulo (N). For every owner (k\in{2,\ldots,n}),

[
rk\not\equiv0\pmod N,
]

and hence

[
\rho_N(rk)\ge1=p.
]

Classes at distance exactly one are safe. Therefore every unit is a certificate in the (p=1) row:

[
\operatorname{DefUnit}*{p=1}
=\phi(N),
\qquad
\Omega*{\rm Unit}(1,2,\ldots,n)\ge\phi(N)>0.
]

By Section 6, every common scale (h(1,2,\ldots,n)) also has positive total unit deficit.

The following additional controls are exact finite evaluations, not universal evidence:

| Tuple                               | Row deficits                  | (\Omega_{\rm Unit}) |
| ----------------------------------- | ----------------------------- | ------------------: |
| ((2,3,5,7,11))                      | ((0,0,2,2,4))                 |                   8 |
| ((1,5,25,125,625))                  | ((2,6,18,54,162))             |                 242 |
| ((6,12,18,24,30))                   | ((12,0,0,0,0))                |                  12 |
| ((1,4,16,64))                       | ((4,4,8,16))                  |                  32 |
| ((6,7,12,24,144))                   | ((0,0,0,0,64))                |                  64 |
| ((1,2,3,4,5,7))                     | ((0,0,0,0,2,2))               |                   4 |
| ((1,2,5,7,9,11,12,13))              | ((0,0,0,6,6,6,0,8))           |                  26 |
| ((1,5,7,8,9,11,13,15))              | ((0,0,4,6,4,6,10,10))         |                  40 |
| ((15,21,40,48,56,105,126,280,1200)) | ((0,10,0,0,34,52,38,170,452)) |                 756 |
| ((1,3,4))                           | ((0,2,2))                     |                   4 |

These cover pairwise-coprime, prime-power, highly shared-factor, nonprimitive, packing-stress, route-failure, and Prompt93 anti-reuse cases.

---

## 9. Hand controls

In the following table, the final column lists every squarefree Möbius term. Divisors with (\operatorname{mob}(d)=0) do not contribute.

| Tuple           | (p) | (M) | (\phi(M)) | Covered | Deficit | Möbius sum                               |
| --------------- | --: | --: | --------: | ------: | ------: | ---------------------------------------- |
| ((1,2))         |   1 |   3 |         2 |       0 |       2 | (K_1(0)-K_3(0)=0)                        |
|                 |   2 |   6 |         2 |       2 |       0 | (K_1(2)-K_2(0)-K_3(0)+K_6(0)=2)          |
| ((1,3))         |   1 |   3 |         2 |       2 |       0 | (K_1(2)-K_3(0)=2)                        |
|                 |   3 |   9 |         6 |       4 |       2 | (K_1(4)-K_3(0)=4)                        |
| ((1,2,3))       |   1 |   4 |         2 |       0 |       2 | (K_1(1)-K_2(1)=0)                        |
|                 |   2 |   8 |         4 |       4 |       0 | (K_1(4)-K_2(0)=4)                        |
|                 |   3 |  12 |         4 |       4 |       0 | (K_1(7)-K_2(3)-K_3(1)+K_6(1)=4)          |
| ((1,3,4))       |   1 |   4 |         2 |       2 |       0 | (K_1(3)-K_2(1)=2)                        |
|                 |   3 |  12 |         4 |       2 |       2 | (K_1(7)-K_2(3)-K_3(3)+K_6(1)=2)          |
|                 |   4 |  16 |         8 |       6 |       2 | (K_1(10)-K_2(4)=6)                       |
| ((1,3,13))      |   1 |   4 |         2 |       0 |       2 | (K_1(0)-K_2(0)=0)                        |
|                 |   3 |  12 |         4 |       2 |       2 | (K_1(4)-K_2(2)-K_3(0)+K_6(0)=2)          |
|                 |  13 |  52 |        24 |      20 |       4 | (K_1(30)-K_2(10)-K_{13}(0)+K_{26}(0)=20) |
| ((4,5,9))       |   4 |  16 |         8 |       6 |       2 | (K_1(10)-K_2(4)=6)                       |
|                 |   5 |  20 |         8 |       6 |       2 | (K_1(13)-K_2(5)-K_5(3)+K_{10}(1)=6)      |
|                 |   9 |  36 |        12 |      10 |       2 | (K_1(23)-K_2(9)-K_3(7)+K_6(3)=10)        |
| ((1,2,3,4,5,7)) |   1 |   7 |         6 |       6 |       0 | (K_1(6)-K_7(0)=6)                        |
|                 |   2 |  14 |         6 |       6 |       0 | (K_1(12)-K_2(6)-K_7(0)+K_{14}(0)=6)      |
|                 |   3 |  21 |        12 |      12 |       0 | (K_1(18)-K_3(6)-K_7(0)+K_{21}(0)=12)     |
|                 |   4 |  28 |        12 |      12 |       0 | (K_1(24)-K_2(12)-K_7(0)+K_{14}(0)=12)    |
|                 |   5 |  35 |        24 |      22 |       2 | (K_1(28)-K_5(6)-K_7(0)+K_{35}(0)=22)     |
|                 |   7 |  49 |        42 |      40 |       2 | (K_1(40)-K_7(0)=40)                      |
| ((2,6,8))       |   2 |   8 |         4 |       4 |       0 | (K_1(6)-K_2(2)=4)                        |
|                 |   6 |  24 |         8 |       4 |       4 | (K_1(14)-K_2(6)-K_3(6)+K_6(2)=4)         |
|                 |   8 |  32 |        16 |      12 |       4 | (K_1(20)-K_2(8)=12)                      |

Thus the required totals are exactly:

[
\begin{aligned}
\Omega(1,2)&=2,\
\Omega(1,3)&=2,\
\Omega(1,2,3)&=2,\
\Omega(1,3,4)&=4,\
\Omega(1,3,13)&=8,\
\Omega(4,5,9)&=6,\
\Omega(1,2,3,4,5,7)&=4,\
\Omega(2,6,8)&=8.
\end{aligned}
]

The two full divisor controls are:

[
\begin{array}{c|rrrrrr}
a=(1,3,4),\ p=3&M=12\ \hline
d&1&2&3&4&6&12\
K(d)&7&3&3&0&1&0
\end{array}
]

and

[
7-3-3+1=2,
\qquad
\text{unit certificates }={5,7}.
]

For (a=(1,2,3)), (p=3),

[
\begin{array}{c|rrrrrr}
d&1&2&3&4&6&12\ \hline
K(d)&7&3&1&0&1&0
\end{array}
]

and

[
7-3-1+1=4=\phi(12),
\qquad
\operatorname{DefUnit}=0.
]

Its ordinary safe candidates are exactly ({3,9}).

Additional controls:

1. (\rho_{12}(3)=3). The strict predicate returns safe; replacing `<` by `<=` returns bad.
2. For (a=(1,3)), pivot (1), the unit candidates are (1,2), and the owner speed (3) has zero product modulo (3) at both.
3. For (a=(1,3,13)), pivot (3), owners (1) and (13) both have bad set
   [
   {1,2,10,11}.
   ]
   At each of these residues (\mu=2), while (K(1)) counts each residue once.
4. For (a=(4,5,9)), pivot (9), the complete safe candidates are
   [
   {3,5,31,33}.
   ]
   The unit certificates are (5,31); the nonunit fibers (3,33) are retained in the candidate arithmetic.
5. (r=0) and every multiple of (N) are excluded from (R_j). Units require no additional exclusion convention.
6. Inputs with (n<2), zero or negative speeds, nonintegers, repeated speeds, wrong length, or noncanonical residue representatives are rejected for the (n\ge2) target. The (n=1) case is handled separately in Section 16.
7. Omitting the squarefree divisor (6) in the ((1,3,4)), (p=3) table gives (7-3-3=1), not (2).
8. Reversing the divisor order in the inversion at (g=2) gives (-4) on that row, whereas the correct value is (G(2)=2).
9. A truncating `Nat` evaluation is order-dependent. Reordering the correct terms as (1-3+7-3) gives
   [
   ((1\mathbin{\dot-}3)+7)\mathbin{\dot-}3=4,
   ]
   not (2). The sum must be in `Int`.
10. The nontrivial permutations and scales in Section 6 reproduce the predicted row permutations and (\lambda)-factors exactly.

---

## 10. Independent falsification

### Implementations

**Implementation A** is Python 3.13.5. It directly enumerates only residues satisfying

[
\gcd(r,M_j)=1
]

and tests every labelled strict bad predicate. It contains no divisor-layer or Möbius code.

**Implementation B** is independently written C++20, compiled with `g++ 14.2.0`. It never filters covered residues by (\gcd(r,M_j)=1). It enumerates (R_j), constructs every (K_j(d)), independently factors (M_j), computes the arithmetic Möbius function, and evaluates

[
\sum_{d\mid M_j}\operatorname{mob}(d)K_j(d).
]

The two implementations share only the input tuple manifest.

### Complete prescribed domain

Tuples were ordered first by (n), then lexicographically.

|       (n) | Raw increasing tuples | Primitive tuples | Minimum observed (\Omega) | First minimum |
| --------: | --------------------: | ---------------: | ------------------------: | ------------- |
|         2 |                   153 |              101 |                         2 | ((1,2))       |
|         3 |                   816 |              712 |                         2 | ((1,2,3))     |
|         4 |                 3,060 |            2,919 |                         4 | ((1,2,3,4))   |
|         5 |                 8,568 |            8,436 |                         2 | ((1,2,3,4,5)) |
| **Total** |            **12,597** |       **12,168** |                           |               |

Both implementations completed all 12,168 primitive tuples. There was no first failure and no disagreement.

### Structured mutations

Seed:

```text
940283
```

A complete manifest of exactly 750 tuples in each dimension (2\le n\le9) was generated, for 6,000 tuples total. It includes the exact bases, common scales by (2,3,5,7), nontrivial permutations, one-to-three-coordinate arithmetic mutations, pairwise-coprime families, prime powers, shared-factor families, and every concrete stress tuple listed above.

| (n) | Completed tuples | Minimum observed (\Omega) |
| --: | ---------------: | ------------------------: |
|   2 |              750 |                         2 |
|   3 |              750 |                         2 |
|   4 |              750 |                         4 |
|   5 |              750 |                         2 |
|   6 |              750 |                         4 |
|   7 |              750 |                         4 |
|   8 |              750 |                         6 |
|   9 |              750 |                         4 |

Completion markers are `true` in both outputs. There was no partial prefix, zero target failure, or implementation disagreement.

### Hashes

```text
generator source:
cd56b576cfb377f2b79ea32c2d947ca4dc8c2c449473a0f066e503f36fe05124

structured manifest:
025983d8f94cb70bee50e9f60fe946ab5b026b04864297b64928ceeeaeee7152

Implementation A source:
5068c437e07e5f85c194f0ee34c852bb69db233c25fee133b61573f5b9f46beb

Implementation A output:
229a9064747c1e6a873b6f1a6932598ddc027fb18874bf3943ce9d64b76d18e5

Implementation B source:
c103883c1f232cdd62eaf0f7796e90d5241b52dbefb9f5cc47a85435fd638069

Implementation B executable:
8ddeb131f88b5347536af45f2f65522fc5af49baec00ae111a60a04c9dfba1a3

Implementation B output:
00bfa22dfd0fa20bffd76d5526382bc7d171caaadf931dc1d869087cf8e5e469

comparison output:
9be6aff793daba1b5331d083ae8368e9f6528b162201fa6a56d82fd26640c3e1

diagnostic output:
23fab3abe3121954fe406fc86becd7685bc284afcd150e6cff61dc8f9203d7b7

artifact bundle:
5d2e16bc120fa84e8cb58319b903700cecf8cd1d431b19adf77f2712c22d49d2
```

The comparison output is

```json
{"all_pass":true,"checks":{"hand_stress_scalars":true,"no_failures":true,"preflight_counts":true,"preflight_minima":true,"structured_complete":true,"structured_groups":true,"structured_total":true}}
```

[Download the complete Prompt 94 computation bundle](sandbox:/mnt/data/p94_artifacts.tar.gz)

Because no counterexample was found, no counterexample record with a first-failure row was emitted.

---

## 11. Lane A

The exact (K_j(d)) formula is proved in Section 4. Substituting it into the Möbius sum gives a finite, exact expression for every row involving:

* squarefree divisor weights;
* all labelled owner subsets;
* strict two-sided arcs;
* noncoprime CRT compatibility;
* exclusion of the (N)-multiple sublattice.

What is missing is a cross-pivot conservation law.

The first-order unit union bound is already unusable. If

[
C_{ij}
======

#{r\in U(M_j):r\in B_i^j},
]

then

[
\operatorname{DefUnit}*j
\ge
\phi(M_j)-\sum*{i\ne j}C_{ij}.
]

For (a=(1,2,3,4,5,7)), the rowwise right sides are

[
(0,0,-4,-4,-8,-18),
]

with total

[
-34.
]

For

[
a=(15,21,40,48,56,105,126,280,1200),
]

the total is

[
-3038.
]

Thus exact-gcd restriction does not repair the false first-moment route.

Expanding the covered union gives

[
\begin{aligned}
\operatorname{DefUnit}*j
={}&\phi(M_j)
-\sum_i |U_j\cap B_i^j|
+\sum*{i<k}|U_j\cap B_i^j\cap B_k^j|\
&-\sum_{i<k<\ell}|U_j\cap B_i^j\cap B_k^j\cap B_\ell^j|
+\cdots.
\end{aligned}
]

The first phase-sensitive term is the pair intersection. Even exact pair formulas do not close a lower bound because the negative first moment can be large and the next required Bonferroni correction introduces triple intersections. Their CRT phases depend on

[
b_i^{-1}A_i\pmod{m_i}
]

at a pivot-specific collection of noncoprime moduli. No involution or Fubini exchange was found that matches these phases across different (M_j=N a_j).

**First unsupported term:** a sign-controlled all-pivot identity for the alternating higher-order unit intersections, beginning with the pair correction and, for a valid lower bound, the subsequent triple term.

Lane A therefore supplies exact arithmetic but no strict positivity theorem.

---

## 12. Lane B

Use the Fourier convention on (\mathbb Z/M\mathbb Z)

[
\widehat f(k)
=============

\sum_{r=0}^{M-1}
f(r)e^{-2\pi i kr/M}.
]

Let

[
u_M(r)=1_{[\gcd(r,M)=1]},
\qquad
b_i(r)=1_{[\rho_M(r a_i)<p]},
\qquad
h_i=1-b_i.
]

Because unit residues automatically lie in (R_j),

[
\operatorname{DefUnit}_j
========================

\sum_{r\bmod M}
u_M(r)\prod_{i\ne j}h_i(r).
]

The unit transform is the Ramanujan sum

[
\widehat u_M(k)=c_M(k)
======================

\sum_{r\in U(M)}e^{-2\pi i kr/M}.
]

With (n-1) owner factors, Fourier inversion gives the exact normalization

[
\operatorname{DefUnit}_j
========================

\frac{1}{M^{n-1}}
\sum_{\substack{k_0+\sum_{i\ne j}k_i\equiv0\(\bmod M)}}
c_M(k_0)
\prod_{i\ne j}\widehat h_i(k_i).
]

For a single owner, put

[
g_i=\gcd(a_i,M),\qquad
m_i=M/g_i,\qquad
a_i'=a_i/g_i,
]

and

[
H_i=\left\lfloor\frac{p-1}{g_i}\right\rfloor.
]

Then (\widehat b_i(k)=0) unless (g_i\mid k). If (k=g_i\ell), and (\bar a_i) is the inverse of (a_i') modulo (m_i),

[
\widehat b_i(g_i\ell)
=====================

g_i D_{H_i}(\ell\bar a_i;m_i),
]

where

[
D_H(t;m)
========

# \sum_{v=-H}^{H}e^{-2\pi i tv/m}

1+2\sum_{v=1}^{H}\cos(2\pi tv/m).
]

This accounts exactly for the multiplication fibers and the strict endpoint.

The all-zero frequency tuple is positive, but the remaining constrained frequency sum has no fixed sign. Already for (M=12),

[
c_{12}(4)=-2,\qquad c_{12}(6)=-4.
]

The Dirichlet factors also take both signs. The expression is not a positive-semidefinite quadratic form; it is an (n)-linear constrained convolution with signed Ramanujan coefficients.

**First unsupported coefficient:** the total nonzero-frequency contribution

[
\sum_{\substack{k_0+\sum k_i=0\\text{not all }k=0}}
c_M(k_0)\prod_i\widehat h_i(k_i).
]

No exact-gcd character identity found here bounds it strictly above the negative of the zero-frequency term.

Lane B therefore reproduces the unit stratum exactly but does not prove nonvanishing.

---

## 13. Lane C

Assume a fixed unit row is fully covered and choose an inclusion-minimal labelled owner cover

[
U(M)=\bigcup_{i\in C}\left(B_i^j\cap U(M)\right).
]

Finite inclusion-minimality gives, for each (i\in C), a private unit residue (r_i) such that

[
r_i\in B_i^j
\quad\text{and}\quad
r_i\notin B_k^j
\ \text{for every }k\in C\setminus{i}.
]

Every bad set is reflection invariant:

[
r\in B_i^j\iff -r\in B_i^j.
]

Therefore (-r_i) is also private for owner (i). A unit cannot satisfy (r_i=-r_i\pmod M) when (M\ge3). Private unit points thus occur in disjoint pairs, proving the local necessary condition

[
2|C|\le\phi(M).
]

This is an unrestricted local theorem, but it does not narrow the cross-pivot existential enough to qualify as `PIVOT`.

The obstruction is that unit multiplication does not preserve the labelled family. For (v\in U(M)),

[
r\mapsto vr
]

sends the bad set generated by (a_i) to the bad set generated by the modular coefficient (v^{-1}a_i\pmod M), which generally is not another speed label. Thus transitivity of (U(M)) cannot transport private residues between labelled owners.

There is also no canonical transfer from a private residue modulo

[
M_j=N a_j
]

to a unit residue modulo

[
M_i=N a_i.
]

The congruence witnessing that owner (i) covers a private point at row (j),

[
r a_i\equiv y\pmod{N a_j},
\qquad |y|<a_j,
]

does not force (r), (y), or its quotient to be a unit modulo (N a_i), and it gives no safety information for the remaining owners in row (i).

**First open edge:** a label-preserving cross-pivot incompatibility theorem for minimal full unit covers.

---

## 14. Lane D

Let

[
M=\prod_\ell \ell^{e_\ell}.
]

The generalized CRT identifies (U(M)) with the product of the prime-power unit groups. However, the strict circular arc

[
{r:\rho_M(r a_i)<p}
]

is not a product of local subsets.

For example, at (M=12), (p=3), owner coefficient (1), the unit points are

[
{1,5,7,11}.
]

Under

[
U(12)\cong U(4)\times U(3),
]

they map as

[
\begin{array}{c|c}
r&(r\bmod4,r\bmod3)\ \hline
1&(1,1)\
5&(1,2)\
7&(3,1)\
11&(3,2).
\end{array}
]

The strict unit bad set is

[
{1,11},
]

which becomes the diagonal pair

[
{(1,1),(3,2)}.
]

Its projection to each prime-power factor is the entire local unit group, but its product of projections has four points. Local projection data therefore loses exactly the correlation needed for coverage.

More generally, CRT reconstructs congruences, but it does not reconstruct the linear order used by (\rho_M). The reduced owner moduli

[
m_i=\frac{M}{\gcd(a_i,M)}
]

also need not be pairwise coprime, so their pullbacks require the full compatibility conditions from Section 4.

Endpoint equality creates an additional global condition: the residues at distance exactly (p) must remain outside the bad arc. This equality is not recognizable from separate coarse local projections.

**First incompatibility failure:** strict arcs on (U(M)) are diagonally coupled CRT subsets, not cylinders over prime-power quotients. No local full-cover contradiction assembles without retaining the complete mixed residue correlation, which reconstructs the original row problem.

---

## 15. Sole lemma

The exact statement

[
\forall n\ge2,\ \forall a:\operatorname{Fin}n\to\mathbb N,
\quad
\text{positive and injective}
\Longrightarrow
\Omega_{\rm Unit}(a)>0
]

remains **open at every frozen quantifier**.

What has been proved is the exact identity

[
\Omega_{\rm Unit}(a)
====================

#{(j,r):
0\le r<N a_j,\
\gcd(r,N a_j)=1,\
\mu_j(r)=0}.
]

What has not been proved is that this finite set is nonempty.

No exact positive injective tuple with (\Omega_{\rm Unit}=0) was found. Conversely, no bounded computation, Möbius identity, Fourier expansion, private-residue statement, or CRT decomposition establishes universal positivity.

Therefore:

* `PROVE` is unavailable;
* `STOP` is unavailable because no exact failure was found;
* `PIVOT` is unavailable because the surviving theorems do not cross the all-pivot positivity edge;
* the correct disposition is `OPEN`.

---

## 16. Complete implication chain

Assume first (n\ge2) and the sole lemma.

Because every row deficit is a nonnegative integer,

[
\Omega_{\rm Unit}(a)>0
]

implies that some (j) satisfies

[
\operatorname{DefUnit}_j(a)>0.
]

By Section 5, there is a canonical residue (0\le r<M_j) with

[
\gcd(r,M_j)=1,
\qquad
\mu_j(r)=0.
]

Since (N\mid M_j), unit status implies (N\nmid r), so

[
r\in R_j.
]

For every owner (i\ne j),

[
r\notin B_i^j
]

and hence

[
\rho_{M_j}(r a_i)\ge a_j.
]

For the pivot coordinate, writing (r=Nq+s), (1\le s\le N-1), gives

[
\rho_{M_j}(r a_j)
=================

a_j\min(s,N-s)
\ge a_j.
]

Set

[
t=\frac{r}{N a_j}.
]

Then for every (i),

[
|t a_i|_{\mathbb R/\mathbb Z}
=============================

\frac{\rho_{M_j}(r a_i)}{N a_j}
\ge
\frac1N
=======

\frac1{n+1}.
]

The inequality is closed. Equality is retained.

Thus a unit pivot certificate is an ordinary canonical pivot certificate, and the accepted directions give

[
\begin{aligned}
&\text{unit pivot certificate}\
&\Longrightarrow
\text{PositiveIntegerPivotCertificateConjecture}\
&\Longrightarrow
\text{PositiveIntegerConjecture}\
&\Longrightarrow
\text{unrestricted positive-real Lonely Runner}.
\end{aligned}
]

The last implication is the accepted positive-integer/positive-real equivalence, not a density assertion.

For (n=1), (N=2). Given the unique positive speed (a_0), take the unique pivot and (r=1). Then

[
\gcd(1,2a_0)=1,
\qquad
\rho_{2a_0}(a_0)=a_0,
]

and at

[
t=\frac1{2a_0}
]

the circle distance is exactly (1/2).

Consequently, conditional on the sole lemma, for every (n\ge1) and every injective (n)-tuple of positive real speeds, there exists a real time (t) such that every runner has circle distance at least

[
\frac1{n+1}.
]

---

## 17. Proof-obligation ledger

| Claim                            | Dependency                               | Evidence class               | Falsification control                        | First open edge                  | Recommended downstream owner |
| -------------------------------- | ---------------------------------------- | ---------------------------- | -------------------------------------------- | -------------------------------- | ---------------------------- |
| Pivot safety, including equality | Canonical representatives                | proved-math-qualified        | (\rho_{12}(3)=3)                             | None                             | Lean formalizer after freeze |
| Zeta identity                    | Exact gcd partition                      | proved-math-qualified        | All hand (K/G) tables                        | None                             | Lean formalizer              |
| Möbius inversion                 | Integer finite sums                      | proved-math-qualified        | Omitted divisor, reversed order, `Nat` tests | None                             | Lean formalizer              |
| Unit support identity            | Units lie in (R_j)                       | proved-math-qualified        | Direct oracle versus Möbius oracle           | None                             | Lean formalizer              |
| Nonnegativity and evenness       | Exact uncovered-unit count, reflection   | proved-math-qualified        | Every hand row                               | None                             | Lean formalizer              |
| Scaling formula                  | Unit-lift counting                       | proved-math-qualified        | (h=2,5,6) controls                           | None                             | Lean formalizer              |
| Permutation invariance           | Label bijection                          | proved-math-qualified        | Three orders of ((1,3,4))                    | None                             | Lean formalizer              |
| Consecutive and scaled families  | Pivot (p=1)                              | proved-math-qualified        | Symbolic proof and computations              | None                             | Sol/Luna replay              |
| Exact (K_j(d)) interval formula  | Noncoprime CRT                           | proved-math-qualified        | Hand divisor layers                          | None                             | Arithmetic formalizer        |
| First-moment positivity          | Unit owner counts                        | rejected                     | Totals (-34,-3038)                           | Higher intersections             | No downstream promotion      |
| Fourier positivity               | Ramanujan/Dirichlet expansion            | open                         | Negative (c_{12}(4),c_{12}(6))               | Nonzero-frequency cancellation   | Sol High                     |
| Minimal-cover incompatibility    | Private unit pairs                       | open                         | Reflection/private-pair theorem              | Cross-pivot label transfer       | Sol High                     |
| Prime-power assembly             | CRT factorization                        | rejected as currently stated | Diagonal subset in (U(12))                   | Mixed local correlation          | Sol High                     |
| Prescribed finite domain         | Implementations A and B                  | computed finite evidence     | Hash-locked comparison                       | Unbounded height/dimension       | Luna replay only             |
| Sole unit-stratum lemma          | All previous arithmetic                  | open                         | No finite failure                            | Universal cross-pivot positivity | Sol High                     |
| Integer and real conclusion      | Sole lemma plus accepted Lean directions | conditional                  | Chain in Section 16                          | Sole lemma                       | Top-level orchestrator       |

---

## 18. Final evidence boundary

**proved-lean, accepted but not re-audited here**

* positive-integer pivot-certificate equivalence;
* positive-integer/positive-real equivalence;
* candidate cardinality and ordinary pivot safety;
* strict bad-set and intersection results at their accepted hypotheses.

**proved-math-qualified in this response**

* pivot-coordinate safety with the closed endpoint;
* exact strict-layer parameterization for every (K_j(d));
* divisor-zeta identity and correctly oriented Möbius inversion;
* (\operatorname{CoveredUnit}_j=G_j(1));
* exact uncovered-unit interpretation and nonnegativity;
* reflection parity of every unit deficit;
* exact common-scaling formula with pivot-dependent (\lambda);
* permutation invariance;
* consecutive and common-scale family theorem;
* Fourier/Ramanujan normalization;
* private-unit reflection-pair theorem;
* the CRT diagonal obstruction.

**response reasoning, not promoted**

* the identification of the first unsupported higher-intersection term;
* the identification of nonzero-frequency cancellation as the Lane B obstruction;
* the absence of a label-preserving private-residue transfer;
* the failure of prime-power projections to retain strict-arc correlations.

**computed finite evidence**

* every mandatory hand row;
* 12,168 primitive tuples in the complete prescribed domain;
* 6,000 completed structured mutations;
* exact agreement of two independently written implementations;
* zero target failures in those finite sets.

**conditional**

[
\text{ALL-PIVOT-UNIT-STRATUM-MOBIUS-DEFICIT}
\Longrightarrow
\text{integer Lonely Runner}
\Longrightarrow
\text{positive-real Lonely Runner}.
]

**rejected**

* ordinary fixed-pivot certificate (\Rightarrow) unit fixed-pivot certificate;
* abstract row symmetry (\Rightarrow) positive total unit deficit;
* unit first-moment positivity;
* signed Möbius evaluation in `Nat`;
* reversed divisor order;
* omission of squarefree divisors;
* independent prime-power projection assembly;
* common scaling by a uniform factor (h) at the (\Omega) level;
* bounded zero failures as a universal proof.

**open**

* `ALL-PIVOT-UNIT-STRATUM-MOBIUS-DEFICIT`;
* any unrestricted cross-pivot conservation law strong enough to prove it;
* unrestricted integer pivot existence;
* unrestricted positive-real Lonely Runner.
