## 1. **Disposition** — `PIVOT`

`LOCAL-DIMENSIONAL-MULTIPLICITY-PIVOT` remains `open`.

No tuple with (S_j\le 0) at every pivot was found. In particular, the Prompt82 calibration tuple is not a counterexample: its rows at pivot speeds (7) and (11) have positive local scores.

The surviving narrower target is:

[
\boxed{
\text{LOCAL-ZERO-EXCESS-DEFICIT-PIVOT}
}
]

For some pivot (j),

[
I_j-|R_j|<2N h_{j,0},
\qquad
I_j:=\sum_{r\in R_j}\mu_j(r).
]

Equivalently, writing

[
E_j:=\sum_{r\in R_j}(\mu_j(r)-1)*+
=\sum*{m\ge2}(m-1)h_{j,m},
]

the condition is

[
E_j<(2N+1)h_{j,0}.
]

This condition implies (S_j>0) by a uniform local estimate proved below. It is strictly stronger than local score positivity: for Prompt82 at pivot speed (11),

[
S_j=\frac{1206}{3485}>0,
\qquad
2Nh_{j,0}-(I_j-|R_j|)=-2.
]

The new selector survived every mandatory fixture and all (56{,}762) primitive tuples in the completed exact domains, including the one preselected new domain (n=8,\max a_i\le15). Its universal existence is not proved.

---

## 2. **Frozen definitions and boundary audit**

Fix (n\ge3), put (N=n+1), and let (a:\operatorname{Fin}n\to\mathbb N) be positive and injective. For pivot (j), write

[
p=a_j,\qquad M=Np.
]

The canonical candidate set is

[
R_j={r\in{0,\ldots,M-1}:N\nmid r}.
]

For (i\ne j),

[
B_i^j
=====

{r\in R_j:\rho_M(ra_i)<p},
\qquad
\rho_M(x)=\min(x\bmod M,M-(x\bmod M)).
]

The owner multiplicity is

[
\mu_j(r)=#{i\in\operatorname{Fin}n:i\ne j,\ r\in B_i^j}.
]

Owners are never deduplicated. If two owners produce identical sets, identical remainders, or identical modular maps, both labels contribute separately.

### Candidate cardinality

The multiples of (N) in ([0,Np)) are exactly

[
0,N,2N,\ldots,(p-1)N.
]

There are (p) of them. Hence

[
|R_j|=Np-p=(N-1)p=np.
]

This includes no coprimality assumption.

### Pivot-coordinate safety

Let (r\in R_j), and write

[
q=r\bmod N.
]

Then (1\le q\le N-1). Since (r=Nk+q),

[
rp=Nkp+qp,
]

with (0<qp<Np), so

[
(rp)\bmod Np=pq.
]

Therefore

[
\rho_{Np}(rp)
=\min(pq,Np-pq)
=p\min(q,N-q)
\ge p.
]

Equality occurs precisely when (q=1) or (q=N-1). These equality cases are safe. If (N) is even and (q=N/2), the pivot is at the antipode and its distance is (Np/2\ge p).

No weak badness inequality is used.

---

## 3. **Local algebra**

Define

[
\phi_N(m)=\frac{1-m}{Nm+1}.
]

All expressions are formed in (\mathbb Z) and then interpreted in (\mathbb Q).

### Transform identity

For every (m\ge0),

[
\begin{aligned}
\frac{N+1}{N(Nm+1)}-\frac1N
&=\frac{N+1-(Nm+1)}{N(Nm+1)}\
&=\frac{N(1-m)}{N(Nm+1)}\
&=\frac{1-m}{Nm+1}.
\end{aligned}
]

Thus

[
\boxed{
\phi_N(m)
=========

\frac{N+1}{N(Nm+1)}-\frac1N.
}
]

Consequently,

[
\phi_N(0)=1,\qquad
\phi_N(1)=0,
]

and for (m\ge2),

[
-\frac1N<\phi_N(m)<0.
]

The left inequality follows after multiplication by the positive number (N(Nm+1)):

[
N(1-m)>-(Nm+1)
\iff N>-1.
]

### Histogram form

Let

[
h_{j,m}=#{r\in R_j:\mu_j(r)=m}.
]

Then

[
\boxed{
S_j
===

## h_{j,0}

\sum_{m\ge2}
h_{j,m}\frac{m-1}{Nm+1}.
}
]

The (m=1) contribution vanishes exactly.

### Reciprocal form

Applying the transform identity candidate by candidate gives

[
S_j
===

\frac{N+1}{N}
\sum_{r\in R_j}\frac1{N\mu_j(r)+1}
----------------------------------

\frac{|R_j|}{N}.
]

Therefore

[
\boxed{
S_j>0
\iff
\sum_{r\in R_j}\frac1{N\mu_j(r)+1}

>

\frac{|R_j|}{N+1}.
}
]

### Harmonic mean form

Let

[
d_r=N\mu_j(r)+1
]

and

[
H_j
===

\frac{|R_j|}
{\displaystyle\sum_{r\in R_j}d_r^{-1}}.
]

All (d_r) are positive and (|R_j|>0). Hence

[
\sum_r d_r^{-1}>\frac{|R_j|}{N+1}
\iff
H_j<N+1.
]

Thus

[
\boxed{S_j>0\iff H_j<N+1.}
]

### Generating-function integral

Set

[
F_j(z)=\sum_{r\in R_j}z^{\mu_j(r)}.
]

After casting to (\mathbb R),

[
\int_0^1x^{Nm},dx=\frac1{Nm+1}.
]

Finite summation and integration commute, giving

[
\int_0^1F_j(x^N),dx
===================

\sum_{r\in R_j}\frac1{N\mu_j(r)+1}.
]

Therefore

[
\boxed{
S_j
===

\frac{N+1}{N}
\int_0^1F_j(x^N),dx
-------------------

\frac{|R_j|}{N}.
}
]

### Variance correction

A second useful exact identity is

[
\boxed{
\phi_N(m)
=========

\frac{1-m}{N+1}
+
\frac{N(m-1)^2}{(N+1)(Nm+1)}.
}
]

Consequently, with

[
I_j=\sum_{r\in R_j}\mu_j(r),
]

one has

[
\boxed{
S_j
===

\frac{|R_j|-I_j}{N+1}
+
\frac{N}{N+1}
\sum_{r\in R_j}
\frac{(\mu_j(r)-1)^2}{N\mu_j(r)+1}.
}
]

This identifies the exact positive correction missed by first-moment or Jensen arguments.

---

## 4. **Scaling, permutation, and logical-strength audit**

### Common scaling

Let (c\ge1), and put

[
A_i=ca_i.
]

For pivot (j), let (M=Np). The scaled modulus is

[
M'=N(cp)=cM.
]

Define

[
\pi:R_j(A)\longrightarrow R_j(a),
\qquad
\pi(r)=r\bmod M.
]

Every (0\le r<cM) has a unique representation

[
r=s+kM,
\qquad
0\le s<M,\quad 0\le k<c.
]

Because (M=Np) is divisible by (N),

[
N\mid r\iff N\mid s.
]

Thus (\pi) preserves candidate membership. Every (s\in R_j(a)) has exactly the (c) lifts

[
s,\ s+M,\ldots,s+(c-1)M.
]

For every owner (i),

[
rA_i=(s+kM)ca_i
=csa_i+k(cM)a_i.
]

Therefore

[
(rA_i)\bmod(cM)
===============

c\bigl((sa_i)\bmod M\bigr)
]

and

[
\rho_{cM}(rA_i)
===============

c,\rho_M(sa_i).
]

Hence

[
\rho_{cM}(rA_i)<cp
\iff
\rho_M(sa_i)<p,
]

while equality on either side is preserved as equality. Owner multiplicities satisfy

[
\mu_j^A(r)=\mu_j^a(\pi(r)).
]

Every base residue has (c) fibers, so

[
\boxed{S_j(A)=cS_j(a).}
]

Thus positivity, zero, and nonpositivity are each preserved in both directions.

If (g=\gcd_i a_i), positivity of all speeds gives (g\ge1). Writing (a_i=gb_i), the tuple (b) remains positive and injective and has common gcd one. The scaling theorem proves that the primitive normalization and lifting steps are exact.

### Permutations

Let (\sigma:\operatorname{Fin}n\simeq\operatorname{Fin}n), and define

[
A_i=a_{\sigma(i)}.
]

The pivot row at (i) for (A) is the pivot row at (\sigma(i)) for (a). The map (\sigma) bijects nonpivot owners and preserves every badness predicate. Therefore it preserves:

* every owner-labelled multiplicity;
* the complete histogram;
* the score;
* the zero set;
* the least zero after the same residue ordering; and
* every canonical certificate.

Only the pivot labels are permuted.

### Local sign implication

If every candidate has (\mu_j(r)\ge1), every summand satisfies

[
\phi_N(\mu_j(r))\le0.
]

Therefore

[
S_j>0
\implies
\exists r\in R_j,\quad \mu_j(r)=0.
]

For such an (r), owner by owner,

[
\mu_j(r)=0
\implies
r\notin B_i^j
\implies
\rho_{Np}(ra_i)\ge p
\quad(i\ne j).
]

The pivot-coordinate calculation gives the same closed inequality for (i=j). Thus (r) is a complete canonical pivot certificate. Equality (\rho=p) remains valid.

### Converse boundary

Neither converse holds.

Prompt82 at pivot speed (32) has four uncovered candidates,

[
78,\ 79,\ 177,\ 178,
]

but

[
S_j=-\frac{7571024}{9392075}<0.
]

Prompt82 at pivot speed (11) has

[
S_j=\frac{1206}{3485}>0,
]

but fails the selected zero-excess condition by margin (-2). Thus the narrower condition is not an algebraic restatement of score positivity.

For the complete Prompt82 tuple,

[
\sum_jS_j
=========

-\frac{5245398}{1878415}<0,
]

while the rows at speeds (7) and (11) are positive. The rejected Prompt82 global sum is therefore irrelevant to the local existential conclusion.

---

## 5. **Attack A: cross-pivot balance**

### Exact owner-incidence count

Fix pivot speed (p) and another owner speed (a). Put

[
g=\gcd(a,p),\qquad
u=\frac ag,\qquad
v=\frac pg,\qquad
d=\gcd(u,N).
]

Then

[
\gcd(a,Np)=gd.
]

On the full group (\mathbb Z/(Np)), multiplication by (a) has image the multiples of (gd), and each image point has (gd) preimages. The strict centered target contains exactly

[
1+2\left\lfloor\frac{p-1}{gd}\right\rfloor
==========================================

1+2\left\lfloor\frac{v-1}{d}\right\rfloor
]

such image points.

The excluded residues are (r=Ns), (0\le s<p). Their badness condition is

[
N\rho_p(as)<p.
]

Multiplication by (a) modulo (p) has kernel size (g). The number of allowed centered image points is

[
1+2\left\lfloor\frac{v-1}{N}\right\rfloor.
]

Subtracting the excluded contribution gives

[
\boxed{
|B_a^p|
=======

g\left[
d\left(2\left\lfloor\frac{v-1}{d}\right\rfloor+1\right)
-------------------------------------------------------

\left(2\left\lfloor\frac{v-1}{N}\right\rfloor+1\right)
\right].
}
]

No unit, pairwise-coprime, or noncollision premise appears. The total local incidence is therefore exactly

[
I_j=\sum_{i\ne j}|B_i^j|,
]

with coincident owner sets still summed by label.

### First-moment harmonic attempt

Cauchy’s inequality gives

[
\sum_{r\in R_j}\frac1{N\mu_j(r)+1}
\ge
\frac{|R_j|^2}{N I_j+|R_j|}.
]

For this lower bound to cross the required threshold, one needs

[
\frac{|R_j|^2}{NI_j+|R_j|}

>

\frac{|R_j|}{N+1},
]

which is equivalent to

[
I_j<|R_j|.
]

That requirement is too strong. The vectors (I_j-|R_j|) in the mandatory fixtures are:

[
\begin{array}{c|l}
\text{fixture}&I_j-|R_j|\text{ in pivot order}\ \hline
P76&(0,4,8,8,18,24)\
P77&(8,11,0)\
P78&(22,25,44,100,240)\
P80&(0,-2,0)\
P82&(4,28,16,22,18,34,112).
\end{array}
]

Thus P76, P77, P78, and P82 have no pivot satisfying the strict first-moment condition, although each has a positive local row. At P77’s speed-(168) pivot, (I_j=|R_j|=504), but nonconstant multiplicity gives (S_j=112). This is exactly the positive variance correction in Section 3.

Jensen, average-degree, and any argument retaining only (I_j) stop here.

### Boundary-projection transfer and fiber failure

A bad incidence ((j,r,i)) has a unique centered integer remainder (\delta) satisfying

[
a_i r=Np_jq+\delta,
\qquad
-p_j<\delta<p_j.
]

Uniqueness holds because (N\ge4), so the strict interval lies well inside a half-period.

Set

[
\varepsilon=
\begin{cases}
1,&\delta\ge0,\
-1,&\delta<0,
\end{cases}
]

and define the canonical representative

[
s\equiv Nq+\varepsilon\pmod{Na_i},
\qquad
0\le s<Na_i.
]

Since (s\equiv\pm1\pmod N), one has (s\in R_i), and the new pivot coordinate is exactly on the safe equality boundary.

This gives an exact incidence-to-candidate map, but it has no uniform fiber bound. In the primitive family

[
(1,2,K),\qquad N=4,
]

the speed-(K) row and owner speed (1) have

[
|B_1^K|
=======

2\left(
K-1-\left\lfloor\frac{K-1}{4}\right\rfloor
\right),
]

while the target row for speed (1) has only

[
|R_1|=3
]

candidates. Any map from these incidences to (R_1) therefore has a fiber of size at least

[
\left\lceil
\frac{
2(K-1-\lfloor(K-1)/4\rfloor)
}{3}
\right\rceil,
]

which is unbounded in (K).

Weighting fibers by speed ratios would no longer prove the equally weighted local reciprocal inequality. The first unsupported arrow is therefore:

[
\text{exact unsigned cross-pivot incidences}
\longrightarrow
\text{one unweighted row below harmonic mean }N+1.
]

No signed cross-row score sum is used.

---

## 6. **Attack B: local cover or energy**

For a fixed pivot define

[
Z_j={r\in R_j:\mu_j(r)=0},
\qquad
z_j=|Z_j|=h_{j,0},
]

and

[
C_j=R_j\setminus Z_j
=\bigcup_{i\ne j}B_i^j.
]

### Canonical minimal cover

Choose the lexicographically first inclusion-minimal labelled owner subfamily whose union is (C_j). Every selected owner has a private point relative to the selected subfamily.

However, a private point for the selected subcover need not have full multiplicity one. Every unused owner remains present in (\mu_j), and an unused owner may cover that private point. Coincident sets also retain distinct labels. For example, in P78 at pivot speed (6), the labelled owners with speeds (12) and (24) induce coincident nonempty bad sets, each of cardinality (6).

Thus minimal-cover private incidence alone does not control the full overlap penalty.

### Exact zero-excess estimate

Define the overcoverage excess

[
E_j
===

\sum_{m\ge2}(m-1)h_{j,m}.
]

Since

[
I_j
===

\sum_m mh_{j,m},
\qquad
|C_j|=|R_j|-z_j,
]

one has

[
\boxed{
E_j=I_j-(|R_j|-z_j).
}
]

For (m\ge2),

[
Nm+1\ge2N+1,
]

so

[
\frac{m-1}{Nm+1}
\le
\frac{m-1}{2N+1}.
]

Therefore

[
\boxed{
S_j
\ge
z_j-\frac{E_j}{2N+1}.
}
]

Define the local deficit margin

[
D_j
===

(2N+1)z_j-E_j.
]

Then

[
\boxed{
S_j\ge\frac{D_j}{2N+1}.
}
]

Using the identity for (E_j),

[
\boxed{
D_j
===

2Nz_j-(I_j-|R_j|).
}
]

Consequently,

[
\boxed{
I_j-|R_j|<2Nz_j
\implies
S_j>0.
}
]

This estimate is sharp for histograms supported on multiplicities (0,1,2).

### Labelled pair energy

Define

[
Q_j
===

\sum_{\substack{i<k\i,k\ne j}}
|B_i^j\cap B_k^j|
=================

\sum_{r\in R_j}\binom{\mu_j(r)}2.
]

This counts labelled owner pairs. Coincident sets contribute all corresponding pairs.

Since

[
\binom m2\ge m-1
\qquad(m\ge2),
]

one has

[
E_j\le Q_j.
]

Hence the stronger local criterion

[
Q_j<(2N+1)z_j
]

also implies (S_j>0). It is not selected as the final pivot because it is strictly stronger than the zero-excess condition.

### Exact all-order intersection expansion

For (k\ge0), define

[
T_{j,k}
=======

\sum_{\substack{K\subseteq{i:i\ne j}\|K|=k}}
\left|\bigcap_{i\in K}B_i^j\right|
==================================

\sum_{r\in R_j}\binom{\mu_j(r)}k.
]

Thus

[
T_{j,0}=|R_j|,
\qquad
T_{j,1}=I_j,
\qquad
T_{j,2}=Q_j.
]

Expanding (F_j(x^N)) owner by owner gives

[
F_j(x^N)
========

\sum_{k=0}^{N-2}
(-1)^k(1-x^N)^kT_{j,k}.
]

Let

[
c_{N,k}
=======

\int_0^1(1-x^N)^k,dx.
]

The beta-function recurrence, or direct integration by parts, gives

[
c_{N,k}
=======

\prod_{\ell=1}^k\frac{N\ell}{N\ell+1}.
]

Consequently,

[
\boxed{
S_j
===

|R_j|-I_j
+
\sum_{k=2}^{N-2}
(-1)^k\alpha_{N,k}T_{j,k},
}
]

where

[
\alpha_{N,k}
============

\prod_{\ell=2}^k\frac{N\ell}{N\ell+1}.
]

This is an exact owner-labelled additive-energy expansion, with every collision term retained.

Odd Bonferroni truncations give lower bounds. The cubic lower bound is

[
S_j
\ge
|R_j|-I_j
+
\frac{2N}{2N+1}T_{j,2}
----------------------

\frac{2N}{2N+1}\frac{3N}{3N+1}T_{j,3}.
]

It fails to detect the positive speed-(7) row of P82, where that lower bound is (-274/425). Restoring all intersection orders recovers (S_j) exactly and therefore ceases to be a narrower argument.

### First unsupported arrow

The surviving open step is

[
\forall a,\quad
\exists j,\quad D_j>0.
]

Neither minimal subcovers nor low-order additive energy currently supply the required pivot selection. A global sum cannot close it:

[
\sum_jD_j=-6
\quad\text{for P76},
\qquad
\sum_jD_j=-106
\quad\text{for P82}.
]

These negative totals are used only to reject global cancellation, not to establish a local row.

---

## 7. **Falsification report**

### Control fixtures and strict-boundary diagnostics

The known success control was

[
(1,2,3).
]

Its three histograms and scores are

[
\begin{array}{c|c|c}
p&h_m&S_j\ \hline
1&{0:2,1:1}&2\
2&{0:2,1:4}&2\
3&{0:2,1:5,2:2}&16/9.
\end{array}
]

The synthetic negative-row control was

[
(1,2,8).
]

At pivot speed (1),

[
h={1:2,2:1},
\qquad
S=-\frac19.
]

At pivot speed (2),

[
h={1:4,2:2},
\qquad
S=-\frac29.
]

Its speed-(8) row remains positive, so this is not a target counterexample.

The literal verifier checked the following exact representatives:

* (\rho=p-1) bad: tuple ((1,2,3)), pivot (p=2), (M=8), (r=1), owner speed (1), residue (1).
* (\rho=p) safe: the same row, (r=2), owner speed (1), residue (2).
* Both cyclic sides: residues (1) and (7) in modulus (8).
* Antipode: tuple ((1,2,3)), pivot (p=3), modulus (12), owner speed (2), (r=3), residue (6).
* Excluded (N)-multiple: (r=0) was excluded in every row.
* Nonunit and gcd-degenerate fiber: tuple ((1,2,3)), pivot (p=1), modulus (4), owner speed (2); both (r=1) and (r=3) map to residue (2), with (\gcd(2,4)=2).
* Repeated owner residues: tuple ((1,2,8)), pivot (p=1), (r=2); owners of speeds (2) and (8) both map to residue (0).
* Coincident labelled bad sets: P78, pivot speed (6), owners of speeds (12) and (24), each with bad-set size (6).
* Common scaling: P76 and (3\cdot P76), with every histogram and score multiplied by (3).
* Permutation: reversal of all owner labels in P82, with rows matched by pivot speed.
* Malformed inputs: empty, zero, negative, repeated, noninteger, string, and decreasing enumeration input were all rejected.
* A deliberately altered P80 histogram was rejected.
* Supplying an unexpected command-line argument produced exit status (2).

### Mandatory fixture rows

Here

[
D_j=2Nh_{j,0}-(I_j-|R_j|).
]

| Fixture | (j) | (p) | Histogram (m:h_{j,m})                   |              (S_j) | Least zero | (D_j) |
| ------- | --: | --: | --------------------------------------- | -----------------: | ---------: | ----: |
| P76     |   0 |   1 | `1:6`                                   |                (0) |       none |     0 |
| P76     |   1 |   4 | `1:22, 3:2`                             |            (-2/11) |       none |    -4 |
| P76     |   2 |   5 | `1:22, 2:8`                             |            (-8/15) |       none |    -8 |
| P76     |   3 |   6 | `0:2, 1:26, 2:6, 3:2`                   |            (78/55) |         13 |    20 |
| P76     |   4 |   7 | `0:2, 1:26, 2:10, 3:2, 4:2`             |          (904/957) |         15 |    10 |
| P76     |   5 |  11 | `1:50, 2:12, 3:2, 5:2`                  |         (-596/495) |       none |   -24 |
| P77     |   0 |   6 | `1:10, 2:8`                             |             (-8/9) |       none |    -8 |
| P77     |   1 |   7 | `1:10, 2:11`                            |            (-11/9) |       none |   -11 |
| P77     |   2 | 168 | `0:126, 1:252, 2:126`                   |              (112) |         29 |  1008 |
| P78     |   0 |   6 | `1:16, 2:8, 3:4, 4:2`                   |       (-7882/6175) |       none |   -22 |
| P78     |   1 |   7 | `1:20, 2:10, 4:5`                       |           (-89/65) |       none |   -25 |
| P78     |   2 |  12 | `1:24, 2:28, 3:8`                       |         (-740/247) |       none |   -44 |
| P78     |   3 |  24 | `1:48, 2:48, 3:20, 4:4`                 |      (-38764/6175) |       none |  -100 |
| P78     |   4 | 144 | `0:160, 1:280, 2:180, 3:80, 4:20`       |      (167136/1235) |         25 |  1680 |
| P80     |   0 |   1 | `1:3`                                   |                (0) |       none |     0 |
| P80     |   1 |   3 | `0:2, 1:7`                              |                (2) |          5 |    18 |
| P80     |   2 |  16 | `0:8, 1:32, 2:8`                        |             (64/9) |         27 |    64 |
| P82     |   0 |   1 | `1:4, 2:2, 3:1`                         |          (-84/425) |       none |    -4 |
| P82     |   1 |   4 | `1:8, 2:12, 3:8`                        |         (-572/425) |       none |   -28 |
| P82     |   2 |   5 | `1:22, 2:10, 3:3`                       |         (-352/425) |       none |   -16 |
| P82     |   3 |   6 | `1:26, 2:10, 3:6`                       |         (-454/425) |       none |   -22 |
| P82     |   4 |   7 | `0:2, 1:34, 2:8, 3:3, 4:2`              |        (5178/4675) |         17 |    14 |
| P82     |   5 |  11 | `0:2, 1:50, 2:18, 3:5, 5:2`             |        (1206/3485) |         27 |    -2 |
| P82     |   6 |  32 | `0:4, 1:150, 2:46, 3:14, 4:2, 5:4, 6:4` | (-7571024/9392075) |         78 |   -48 |

Every mandatory fixture has both a positive-score row and a positive-(D_j) row.

### Completed domains

Enumeration order was:

1. dimension;
2. exact maximum speed;
3. primitive increasing tuple, lexicographically;
4. pivot index;
5. residue representative.

| (n) | Maximum speed | Primitive tuples | Target fail | (D_j>0) fail | Minimum tuplewise maximum (S_j)                            |
| --: | ------------: | ---------------: | ----------- | ------------ | ---------------------------------------------------------- |
|   3 |            30 |            3,472 | none        | none         | (16/9), tuple ((1,4,5)), pivot speed (5)                   |
|   4 |            30 |           25,819 | none        | none         | (20/11), tuple ((1,2,3,5)), pivot speed (3)                |
|   5 |            20 |           15,246 | none        | none         | (385/247), tuple ((1,5,6,7,8)), pivot speed (5)            |
|   6 |            15 |            4,998 | none        | none         | (374/435), tuple ((1,3,4,5,7,11)), pivot speed (7)         |
|   7 |            12 |              792 | none        | none         | (666/425), tuple ((1,2,3,4,5,7,8)), pivot speed (3)        |
|   8 |            15 |            6,435 | none        | none         | (2957/1463), tuple ((1,4,5,6,7,9,11,13)), pivot speed (11) |

Total completed primitive tuples:

[
56{,}762.
]

The first five observations were independently reproduced. The sixth domain was the single preselected new domain.

The literal checker retained complete owner-labelled data for every mandatory-fixture residue. For every exhaustive-domain row, both implementations hashed every tuple, pivot, candidate residue, and ordered bad-owner list before comparing the aggregate row digest.

### Checker artifacts

* [Literal checker](sandbox:/mnt/data/p86_literal.py)
* [Literal full output, including every mandatory-fixture residue](sandbox:/mnt/data/p86_literal.json)
* [Independent optimized checker](sandbox:/mnt/data/p86_optimized.py)
* [Independent comparison output](sandbox:/mnt/data/p86_optimized.json)
* [Artifact manifest](sandbox:/mnt/data/p86_manifest.txt)

SHA-256:

| Artifact         | SHA-256                                                            |
| ---------------- | ------------------------------------------------------------------ |
| Literal source   | `767e28f4db406bf554d8b8cf4f86e8b33f54e3bbc8f0b0a8a985ef34440d0076` |
| Literal output   | `20845b7f4d7586be2326033f9ee76163978ee6041ccfaa9917e0d666ab91bd70` |
| Optimized source | `1bf06a3f6c71c3ba71a8c78ab5b2d1af5d76429b405216dd698a351e2dd4b368` |
| Optimized output | `672bd5045c45a47ea8f8426dde219044242e915385f5d47b30c4a6e5e5eb50ed` |

Both implementations completed all six domains and matched exactly on every domain digest and every owner-labelled mandatory-fixture residue.

---

## 8. **Sole target proof, narrower pivot, or fail certificate**

The selected narrower statement is:

### `LOCAL-ZERO-EXCESS-DEFICIT-PIVOT`

For every (n\ge3) and every positive injective tuple (a:\operatorname{Fin}n\to\mathbb N), there exists a pivot (j) such that

[
\boxed{
I_j-|R_j|<2Nh_{j,0}.
}
]

Equivalently,

[
\boxed{
E_j<(2N+1)h_{j,0}.
}
]

This is strictly stronger than the sole target at the local-row level. Its implication is complete:

[
I_j-|R_j|<2Nh_{j,0}
]

implies

[
D_j=(2N+1)h_{j,0}-E_j>0,
]

and hence

[
S_j\ge\frac{D_j}{2N+1}>0.
]

It is not a certificate restatement. It quantitatively compares uncovered mass with all owner-labelled excess incidences. Prompt82’s speed-(11) row proves that (S_j>0) does not imply the condition.

Status:

* local zero-excess estimate: `proved-math`;
* all fixture and bounded-domain tests: `computed finite evidence`;
* universal existence of a positive-(D_j) row: `open`;
* original local-score target: `open`.

No exact fail certificate was found. No unrestricted conclusion is promoted.

---

## 9. **Complete implication chain**

Assume `LOCAL-ZERO-EXCESS-DEFICIT-PIVOT` for every (n\ge3).

### Moving dimension (n\ge3)

For a positive injective integer tuple:

[
\exists j,\quad I_j-|R_j|<2Nh_{j,0}
]

gives

[
S_j>0.
]

Then

[
\exists r\in R_j,\quad \mu_j(r)=0.
]

For every (i\ne j),

[
r\notin B_i^j
\implies
\rho_{Na_j}(ra_i)\ge a_j.
]

For (i=j),

[
\rho_{Na_j}(ra_j)\ge a_j
]

by canonical pivot safety. Therefore

[
t=\frac{r}{Na_j}
]

satisfies

[
\frac1N
\le
\operatorname{circleNorm}(ta_i)
\qquad\text{for every }i.
]

The accessible current-main `PivotResidues.lean` defines the strict bad sets and contains `card_pivotCandidates`, `pivot_circleNorm_ge`, `outside_pivotBadResidues_circleNorm_ge`, and the packaged theorem `pivotResidueWitness`.

### Moving dimension (n=1)

Put (N=2). For the unique positive pivot speed (p), choose

[
r=1.
]

Then (1<2p), (2\nmid1), and there are no nonpivot owners. This is a direct canonical certificate.

The existing real base theorem `oneMovingRunner` supplies the equivalent antipodal witness as well.

### Moving dimension (n=2)

The existing theorem `twoMovingRunners` supplies a simultaneous closed (1/3)-witness for two nonzero real speeds.

For positive natural speeds, the fixed-instance equivalence in `PivotBoundary.lean` converts that witness to a canonical pivot certificate. The same file defines `PositiveIntegerPivotCertificateConjecture` and proves

```text
positiveIntegerConjecture_iff_pivotCertificateConjecture :
  PositiveIntegerConjecture ↔
    PositiveIntegerPivotCertificateConjecture
```

together with `exists_witness_iff_exists_pivot_certificate`.

### All-dimensional proposition chain

Combining (n=1), (n=2), and the conditional (n\ge3) result gives

```text
PositiveIntegerPivotCertificateConjecture.
```

Use the reverse direction

```text
positiveIntegerConjecture_iff_pivotCertificateConjecture.mpr
```

to obtain

```text
PositiveIntegerConjecture.
```

The rational layer is exact common-denominator clearing, not density. Current-main `RationalReduction.lean` proves the equivalences among positive integers, distinct positive rationals, and arbitrary positive rational tuples.

Current-main `BHKRealReduction.lean` proves the real reduction and packages it as

```text
conjecture_iff_positiveIntegerConjecture :
  Conjecture ↔ PositiveIntegerConjecture.
```

Thus the direction used is

```text
conjecture_iff_positiveIntegerConjecture.mpr.
```

The proof passes through the exact positive-rational and stationary-real reductions, including the irrational-ratio branch, rather than an informal density statement.

Finally, `Conjecture` is the unrestricted labelled real Lonely Runner statement with the closed loneliness inequality.

The complete conditional chain is therefore

[
\begin{aligned}
&\text{LOCAL-ZERO-EXCESS-DEFICIT-PIVOT}\
&\Longrightarrow
\text{LOCAL-DIMENSIONAL-MULTIPLICITY-PIVOT}\
&\Longrightarrow
\exists r,\ \mu_j(r)=0\
&\Longrightarrow
\text{owner-by-owner strict bad-set complement}\
&\Longrightarrow
\text{closed pivot safety}\
&\Longrightarrow
\text{canonical pivot certificate}\
&\Longrightarrow
\texttt{pivotResidueWitness}\
&\Longrightarrow
\texttt{PositiveIntegerPivotCertificateConjecture}\
&\Longrightarrow
\texttt{PositiveIntegerConjecture}\
&\Longrightarrow
\texttt{Conjecture}\
&\Longrightarrow
\text{unrestricted real LRC}.
\end{aligned}
]

Only the first universal arrow remains open.

---

## 10. **Proof-obligation ledger**

| Statement                                | Dependency                         | Status                                           | Falsification test                             | First open arrow / stop condition                  | Recommended owner        |                |           |
| ---------------------------------------- | ---------------------------------- | ------------------------------------------------ | ---------------------------------------------- | -------------------------------------------------- | ------------------------ | -------------- | --------- |
| (                                        | R_j                                | =(N-1)p=np)                                      | Multiples of (N) below (Np)                    | `proved-math`; existing current-main Lean analogue | Zero and (p=1) rows      | None           | Luna/Lean |
| Pivot-coordinate safety                  | (r\bmod N\ne0)                     | `proved-math`; existing current-main real bridge | Equality (q=1,N-1), antipode                   | None                                               | Luna/Lean                |                |           |
| Local transform and histogram identities | Rational algebra                   | `proved-math`                                    | Literal score versus histogram                 | None                                               | Luna/Lean                |                |           |
| Reciprocal and harmonic equivalence      | Positive denominators              | `proved-math`                                    | Exact fractions on all rows                    | None                                               | Luna/Lean                |                |           |
| Generating integral                      | Finite sum and monomial integral   | `proved-math`                                    | Symbolic coefficient replay                    | None                                               | Luna/Lean                |                |           |
| Common scaling                           | (r=s+kNp)                          | `proved-math`                                    | P76 versus (3P76)                              | None                                               | Luna/Lean                |                |           |
| Permutation law                          | Owner-label bijection              | `proved-math`                                    | Reversed P82                                   | None                                               | Luna/Lean                |                |           |
| (S_j>0\Rightarrow h_{j,0}>0)             | (\phi(m)\le0) for (m\ge1)          | `proved-math`                                    | Synthetic negative/full-cover rows             | None                                               | Luna/Lean                |                |           |
| Zero multiplicity gives certificate      | Strict complement and pivot safety | `proved-math`; existing Lean bridge              | Every zero in fixtures                         | None                                               | Luna/Lean                |                |           |
| Exact (                                  | B_a^p                              | ) formula                                        | Cyclic homomorphism and excluded (N)-multiples | `proved-math`                                      | Literal owner-set counts | None           | Luna/Lean |
| First-moment harmonic selection          | Cauchy/Jensen                      | `rejected`                                       | P76, P77, P78, P82                             | Requires (I_j<                                     | R_j                      | ), which fails | Stop      |
| Uniform boundary-transfer fiber          | Incidence projection               | `rejected`                                       | Family ((1,2,K))                               | Fibers unbounded in (K)                            | Stop                     |                |           |
| Minimal-subcover private incidence       | Labelled set system                | `proved-math` locally                            | Coincident and unused owners                   | Does not control full (\mu_j)                      | Sol Pro                  |                |           |
| Zero-excess estimate (S_j\ge D_j/(2N+1)) | (Nm+1\ge2N+1)                      | `proved-math`                                    | All fixture histograms                         | None                                               | Luna/Lean                |                |           |
| Pair-energy expansion                    | Owner-labelled intersections       | `proved-math`                                    | Direct histogram identity                      | Fixed truncations miss P82                         | Sol Pro                  |                |           |
| Existence of (j) with (D_j>0)            | New arithmetic selection           | `open`                                           | Mandatory fixtures and 56,762 tuples           | First open arrow                                   | Sol Pro                  |                |           |
| Sole local-score target                  | Positive (D_j) would suffice       | `open`                                           | No fail fixture found                          | Depends on previous row                            | Sol Pro                  |                |           |
| Positive-integer certificate equivalence | Existing repository declarations   | current-main `proved-lean`                       | `#print axioms` still required at hash lock    | Supplied base commit not inspected                 | `/root`                  |                |           |
| Integer-to-real reduction                | Existing BHK chain                 | current-main `proved-lean`                       | Build and axiom probes at hash lock            | Supplied base commit not inspected                 | `/root`                  |                |           |
| Unrestricted LRC                         | All preceding universal arrows     | `open`                                           | None                                           | Universal (D_j>0) selector                         | `/root`                  |                |           |

---

## 11. **Verifier and Lean plan**

### Frozen Lean data

A new file should define, without changing existing badness semantics:

```lean
def pivotOwner (j : Fin n) := {i : Fin n // i ≠ j}

def pivotMultiplicity
    (N : Nat) (a : Fin n → Nat) (j : Fin n)
    (r : Nat) : Nat :=
  Finset.univ.filter
    (fun i => i ≠ j ∧
      r ∈ pivotBadResidues N (a j) (a i)) |>.card

def localPhi (N m : Nat) : Rat :=
  ((1 : Int) - m) / (N * m + 1)

def localScore
    (N : Nat) (a : Fin n → Nat) (j : Fin n) : Rat := ...

def localZeroCount ... : Nat := ...

def localTotalIncidence ... : Nat := ...

def localExcess ... : Nat := ...

def LocalZeroExcessDeficitPivot : Prop := ...
```

`localPhi` must construct the numerator in `Int` before the rational division.

### Proposed theorem signatures

```lean
theorem card_localCandidates ...

theorem pivotCoordinate_cyclicDistance_ge ...

theorem localPhi_decomposition ...

theorem localScore_eq_histogram ...

theorem localScore_pos_iff_reciprocal ...

theorem localScore_pos_iff_harmonicMean ...

theorem localScore_eq_generatingIntegral ...

theorem localScore_commonScale ...

theorem localScore_permutation ...

theorem localScore_pos_imp_exists_zero ...

theorem localZero_gives_pivotCertificate ...

theorem localScore_ge_zeroCount_sub_excess ...

theorem localZeroExcessDeficit_imp_localScore_pos ...

theorem localDimensionalMultiplicityPivot_of_zeroExcessPivot ...

theorem positiveIntegerPivotCertificateConjecture_of_localDimensional ...
```

The integral theorem should state an equality after casting the rational score to (\mathbb R).

### Existing declarations to reuse

On the accessible current branch:

* `pivotCandidates`
* `pivotBadResidues`
* `card_pivotCandidates`
* `pivot_circleNorm_ge`
* `outside_pivotBadResidues_circleNorm_ge`
* `pivotResidueWitness`
* `exists_witness_iff_exists_pivot_certificate`
* `PositiveIntegerPivotCertificateConjecture`
* `positiveIntegerConjecture_iff_pivotCertificateConjecture`
* `positiveIntegerConjecture_iff_positiveRationalConjecture`
* `conjecture_iff_positiveIntegerConjecture`

The supplied ref `b083994f6cf2e54f5129f3dc211365ca2a1b8c66` was not available through the connected repository interface. These declaration names were therefore checked on accessible `main`, not compiled against the supplied hash. No base-commit `proved-lean` promotion is made.

### Target commands

```text
lake env lean LonelyRunner/LocalDimensionalMultiplicity.lean
lake build
```

Axiom probes:

```lean
#print axioms LonelyRunner.localScore_pos_imp_exists_zero
#print axioms LonelyRunner.localZeroExcessDeficit_imp_localScore_pos
#print axioms LonelyRunner.localScore_commonScale
#print axioms LonelyRunner.localDimensionalMultiplicityPivot_of_zeroExcessPivot
```

Repository hygiene:

```text
grep -R "sorry" LonelyRunner/LocalDimensionalMultiplicity.lean
grep -R "^axiom\\|^constant" LonelyRunner/LocalDimensionalMultiplicity.lean
```

The literal and optimized Python checkers should be replayed without arguments, their four hashes compared with the manifest, and all `full_domain_completion` and `all_comparisons_exact` markers required to be true.

No Lean implementation or compilation was performed in this turn.

---

## 12. **Final evidence boundary**

### `proved-lean`

Existing accessible current-main declarations only:

* strict modular candidate and bad-set definitions;
* candidate cardinality theorem;
* pivot and nonpivot real safety bridges;
* `pivotResidueWitness`;
* fixed-instance witness/certificate equivalence;
* `PositiveIntegerConjecture ↔ PositiveIntegerPivotCertificateConjecture`;
* exact rational and real reduction theorems;
* one- and two-moving-runner base cases.

The supplied base commit was not available for hash-locked compilation.

### Generic `proved-math`

* (|R_j|=np);
* natural pivot-coordinate safety, including equality;
* all local score identities;
* variance correction;
* common scaling and permutation laws;
* (S_j>0\Rightarrow h_{j,0}>0);
* zero multiplicity implies an explicit certificate;
* exact owner bad-set cardinality formula;
* zero-excess lower bound;
* labelled all-order intersection expansion;
* failure of the first-moment and uniform-fiber attacks.

These are response-authored proofs and have not received independent mathematical audit.

### Response-authored calculation

* all control and mandatory-fixture histograms;
* all reduced rational scores;
* all least zero candidates;
* all (I_j), (E_j), and (D_j) values;
* Prompt82 global score sum;
* P76 and P82 global deficit-margin sums;
* strict-boundary, antipode, collision, scaling, and permutation diagnostics.

### Independently reproduced `computed finite evidence`

Two structurally separate exact implementations matched on:

* every owner-labelled residue in the seven control/mandatory tuples;
* every pivot-row digest in six completed domains;
* (56{,}762) primitive increasing tuples;
* no local-score fail fixture;
* no zero-excess-selector fail fixture.

No floating-point arithmetic was used.

### `conditional`

[
\text{LOCAL-ZERO-EXCESS-DEFICIT-PIVOT}
\Longrightarrow
\text{LOCAL-DIMENSIONAL-MULTIPLICITY-PIVOT}
\Longrightarrow
\text{unrestricted real LRC}.
]

Every downstream arrow is supplied; the universal zero-excess pivot is the sole new open premise.

### `rejected`

* Prompt82 global signed-score revival;
* deriving a local conclusion from (\sum_jS_j);
* first-moment Cauchy or Jensen selection;
* a dimension-only incidence-transfer fiber bound;
* certificate (\Rightarrow S_j>0);
* minimal-cover private points without unused-owner control;
* fixed cubic additive-energy truncation;
* finite-domain extrapolation.

### `open`

* `LOCAL-ZERO-EXCESS-DEFICIT-PIVOT`;
* `LOCAL-DIMENSIONAL-MULTIPLICITY-PIVOT`;
* unrestricted Lonely Runner;
* hash-locked Lean compilation at the supplied base commit.

No theorem, computation, or unrestricted status is promoted beyond these boundaries.
