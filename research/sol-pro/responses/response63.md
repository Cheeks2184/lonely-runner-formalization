# PRO-C result

**Unrestricted LRC remains `open`.** A July 2026 paper still describes the conjecture as “widely open”; nothing below changes that status. ([arXiv][1])

The corrected DPLP selector also remains `conjectural` and `open`. This turn produced:

1. an exact incidence reformulation of DPLP failure;
2. two exact rejected synchronization mechanisms;
3. five new `proved-math` bridge lemmas;
4. one surviving reverse-grid descent route;
5. a single first unsupported implication, strictly narrower than `DELETION-CERTIFICATE-CORRELATION`;
6. a two-implementation exact audit over 4,694 targeted tuples.

No height-compression, all-pivot/top-two/Fourier, coefficient-two, prime-forcing, or unrestricted-LRC claim was developed.

---

## 1. Correct formal status

I did not have the local Lean checkout in this cell and did not replay commit `e5a353397008e0d2fcbbb6213972b952055c4dbf`. The Lean statuses in the first four rows are therefore the reviewed baseline supplied in the prompt, not a new kernel audit.

| Item                                                                                                     | Exact status                 | Qualification                                                                        |
| -------------------------------------------------------------------------------------------------------- | ---------------------------- | ------------------------------------------------------------------------------------ |
| Selected exceptional-good certificate gives the full witness time (r/(np))                               | `proved-lean`                | Integrated baseline, according to the supplied status                                |
| Corrected DPLP contract and conditional wrapper at commit `e5a353...`                                    | `proved-lean`, `conditional` | Isolated reviewed commit; pending main integration                                   |
| `threeHeight_family_witness` bounded-height branch                                                       | `proved-lean`                | Supplied integrated baseline                                                         |
| Endpoint-safe positive-integer-to-real reduction                                                         | `proved-lean`                | Supplied integrated baseline                                                         |
| D4, D5, repaired D6                                                                                      | `proved-math`                | Accepted inputs; not Lean                                                            |
| Exact row classification and incidence identities below                                                  | `proved-math`                | New this turn                                                                        |
| Oriented active-blocker lemma                                                                            | `proved-math`                | New this turn                                                                        |
| Canonical one-sided residue and quotient identities                                                      | `proved-math`                | New this turn                                                                        |
| Reverse-grid identity                                                                                    | `proved-math`                | New this turn                                                                        |
| Lipschitz reverse-lifting criterion and speed-gap corollary                                              | `proved-math`                | New this turn                                                                        |
| Component-successor synchronization and gap bound                                                        | `proved-math`                | New this turn                                                                        |
| Fixed-pivot deep-to-shell exchange                                                                       | `rejected`                   | Counterexample `(1,2,3,60)`                                                          |
| “A maximizing active cycle must meet an (N)-divisible coordinate” under the bare corrected-DPLP premises | `rejected`                   | Counterexample `(1,2,6,8,10)`                                                        |
| Common-time/common-grid identification around an active cycle                                            | `rejected`                   | Same tuple; the two cycle vertices use disjoint maximizing sets and moduli 50 and 40 |
| Minimum-escape first-blocker descent                                                                     | `conjectural`, `open`        | Chosen continuation                                                                  |
| Corrected DPLP selector                                                                                  | `conjectural`, `open`        | Not proved                                                                           |
| Full least-bad-dimension induction                                                                       | `conditional`, `open`        | Blocked at the selector/descent step                                                 |
| Finite audit                                                                                             | `computed finite evidence`   | Exact arithmetic, independently reproduced                                           |

---

## 2. Fully quantified definitions

Let (n\ge 2), (N=n+1), and let

[
a:[n]\to \mathbb Z_{>0}
]

be injective. For (m>0), let ([x]_m\in{0,\ldots,m-1}) be the least residue and put

[
\rho_m(x)=\min([x]_m,m-[x]_m).
]

Thus

[
\left|\frac{x}{m}\right|_{\mathbb R/\mathbb Z}
=\frac{\rho_m(x)}{m}.
]

### Certificate set

For a deleted coordinate (k), define

[
\begin{aligned}
C_k(a)={(j,r):;&j\ne k,\quad 0\le r<n a_j,\quad n\nmid r,\
&\rho_{n a_j}(r a_i)\ge a_j
\quad\text{for every }i\ne k}.
\end{aligned}
]

For (c=(k,j,r)), put (p=a_j) and (m=np).

### Exceptional-good predicate

[
\operatorname{Good}*a(k,j,r)
\iff
np\le N,\rho*{np}(r a_k).
]

The shell lower boundary is therefore closed.

### Corrected DPLP

`CorrectedDeletionPivotLiftingPrinciple` is the statement:

> For every (n\ge2) and every primitive positive injective (a:[n]\to\mathbb Z_{>0}), if
>
> [
> \max_i a_i>N+\left\lfloor\frac N3\right\rfloor,
> ]
>
> some (a_q) is divisible by (N), and (C_k(a)\ne\varnothing) for every (k), then
>
> [
> \exists k,j,r,\qquad
> (j,r)\in C_k(a)
> \quad\text{and}\quad
> \operatorname{Good}_a(k,j,r).
> ]

This remains `conjectural`.

---

## 3. Attack A: exact empty/shell/deep incidence

### Lemma A1: exact row classification

Fix a pivot (j), put (p=a_j), (m=np), and choose (r) with (0\le r<m) and (n\nmid r). Define

[
u_i=\rho_m(r a_i),
\qquad
B_{j,r}={i:u_i<p}.
]

Then:

1. (j\notin B_{j,r}).
2. The row ((j,r)) certifies deletion (k) exactly when
   [
   B_{j,r}\subseteq{k}
   \quad\text{and}\quad k\ne j.
   ]
3. If (B_{j,r}=\varnothing), the row is exceptional-good for every deletion (k\ne j).
4. If (B_{j,r}={k}), the row is exceptional-good exactly when
   [
   N u_k\ge m.
   ]

**Status:** `proved-math`.

#### Proof

Since (a_j=p),

[
\rho_{np}(rp)=p,\rho_n(r).
]

Because (n\nmid r), (\rho_n(r)\ge1), so (u_j\ge p). Hence (j\notin B_{j,r}).

The certificate conditions require (u_i\ge p) for every (i\ne k). This is exactly (B_{j,r}\subseteq{k}).

If (B_{j,r}=\varnothing), then (u_k\ge p), and

[
N u_k\ge Np>np=m,
]

so every permitted deletion is exceptional-good.

If (B_{j,r}={k}), the survivor conditions hold, and the remaining exceptional-good condition is precisely (Nu_k\ge m). ∎

### Exact incidence matrices

Let:

[
\begin{aligned}
e_j
&=#{r:B_{j,r}=\varnothing},\
d_{jk}
&=#{r:B_{j,r}={k},;N u_k<m},\
s_{jk}
&=#{r:B_{j,r}={k},;N u_k\ge m}.
\end{aligned}
]

Then

[
|C_k(a)|
========

\sum_{j\ne k}e_j+\sum_j(d_{jk}+s_{jk}),
]

and the number of exceptional-good certificates for deletion (k) is

[
|G_k(a)|
========

\sum_{j\ne k}e_j+\sum_j s_{jk}.
]

Consequently, an exact DPLP failure must satisfy

[
e_j=0\quad\text{for every }j,
\qquad
s_{jk}=0\quad\text{for every }j,k,
]

while simultaneously

[
\sum_j d_{jk}>0
\quad\text{for every deletion }k.
]

This preserves the quantifier order. It says that every deletion must occur as a deep singleton in the complete row incidence structure, while no empty or shell singleton may occur anywhere.

### Rejected exchange: fixed-pivot deep rows do not force shell rows

For (a=(1,2,3,60)), (n=4), (N=5), take pivot (p=60), so (m=240).

| Deleted speed | Deep singleton rows | Shell singleton rows |
| ------------: | ------------------: | -------------------: |
|             1 |                  28 |                   18 |
|             2 |                  30 |                    0 |
|             3 |                  40 |                    6 |

For deleted speed 2, all 30 deep numerators are

[
\begin{aligned}
101,102,103,105,106,107,109,110,111,113,114,115,117,118,119,\
121,122,123,125,126,127,129,130,131,133,134,135,137,138,139.
\end{aligned}
]

There is no shell row for this fixed pivot/deletion pair. Representative literal rows are:

| (r) | ((\rho_{240}(r),\rho_{240}(2r),\rho_{240}(3r),\rho_{240}(60r))) |
| --: | --------------------------------------------------------------- |
| 101 | `(101,38,63,60)`                                                |
| 102 | `(102,36,66,120)`                                               |
| 103 | `(103,34,69,60)`                                                |
| 105 | `(105,30,75,60)`                                                |
| 106 | `(106,28,78,120)`                                               |
| 119 | `(119,2,117,60)`                                                |
| 121 | `(119,2,117,60)`                                                |
| 139 | `(101,38,63,60)`                                                |

Therefore any proposed injection, exchange, or local count inequality

[
{\text{deep rows for fixed }(j,k)}
\longrightarrow
{\text{shell rows for the same }(j,k)}
]

is `rejected`.

The complete 124-row pivot-60 incidence table is in the linked literal audit.

**Decision for Attack A:** `stop`. The exact incidence reformulation is retained, but a selector cannot be obtained from fixed-row monotonicity or a deep-to-shell injection. Any future incidence argument would need genuine cross-pivot, high-order overlap control.

---

## 4. Attack B: active maximizers and cycles

Put

[
f_i(t)=|a_i t|_{\mathbb R/\mathbb Z},
\qquad
K_k={t:f_i(t)\ge 1/n\text{ for all }i\ne k},
]

and

[
\eta_k=\max_{t\in K_k}f_k(t).
]

A deletion certificate immediately gives a point of (K_k), so:

### Lemma B1: certificate completeness gives active-set nonemptiness

[
C_k(a)\ne\varnothing\quad\Longrightarrow\quad K_k\ne\varnothing.
]

**Status:** `proved-math`.

#### Proof

If ((j,r)\in C_k(a)), then (t=r/(n a_j)) satisfies

[
f_i(t)=\frac{\rho_{n a_j}(r a_i)}{n a_j}\ge\frac1n
]

for every (i\ne k). Hence (t\in K_k). ∎

### Exact use of D4, D5, and repaired D6

The accepted hypotheses are essential:

* D4 requires **no full (1/N) witness**.
* D5 requires **no full witness and (K_k\ne\varnothing)**.
* Repaired D6 requires **no full witness and every (K_k\ne\varnothing)**.

D6 cannot be invoked merely from failure of corrected DPLP.

### Lemma B2: oriented active blocker

Assume there is no full (1/N) witness, (K_k\ne\varnothing), and (t\in K_k) maximizes (f_k).

Choose a direction (\varepsilon\in{-1,+1}) in which (f_k) locally increases. If (f_k(t)=0), either direction may be chosen.

Then some (j\ne k) satisfies

[
f_j(t)=\frac1n
]

and (f_j(t+\varepsilon\delta)) locally decreases for positive (\delta).

**Status:** `proved-math`.

#### Proof

No full witness implies

[
f_k(t)<\frac1N<\frac12,
]

so at least one one-sided direction locally increases (f_k).

Suppose no active survivor decreases in the chosen direction. Every survivor with value strictly greater than (1/n) has positive slack. There are finitely many coordinates, so for sufficiently small (\delta>0):

* every strict survivor remains above (1/n);
* every survivor active at (1/n) remains at or above (1/n);
* (f_k(t+\varepsilon\delta)>f_k(t)).

Thus (t+\varepsilon\delta\in K_k), contradicting maximality.

For (n=2), the active value is (1/2), a cusp at which both one-sided motions decrease the active norm. The same conclusion follows. ∎

This gives D5 with orientation information.

### Lemma B3: one-sided canonical numerator

Let (j) be the blocker from Lemma B2, put (p=a_j), and choose (s\in{-1,+1}) so that the signed active phase is

[
a_jt=\frac{s}{n}\pmod 1.
]

The direction increasing the deleted coordinate is then

[
\varepsilon=-s.
]

There are integers (z,r) such that

[
t=\frac{r}{np}\pmod1,
\qquad
r=nz+s,
\qquad
0\le r<np.
]

Let

[
d=\rho_{np}(r a_k).
]

Then:

[
N d<np,
]

[
r a_k\equiv -s d\pmod{np},
]

[
d\equiv-a_k\pmod n,
]

and hence

[
b:=\frac{a_k+d}{n}\in\mathbb Z_{>0}.
]

Finally,

[
p\mid z a_k+s b.
]

**Status:** `proved-math`.

#### Proof

The active equality gives

[
pt=z+\frac{s}{n}\pmod1,
]

and therefore (t=(nz+s)/(np)).

Since the direction (-s) increases (f_k), the signed deleted residue is (-sd), giving

[
r a_k\equiv-sd\pmod{np}.
]

Reducing modulo (n), using (r\equiv s\pmod n), gives

[
s a_k\equiv-sd\pmod n.
]

Multiplication by (s) yields (a_k+d\equiv0\pmod n), proving integrality of (b).

Substituting (r=nz+s) and (a_k+d=nb) into the signed congruence gives

[
n(z a_k+s b)\equiv0\pmod{np},
]

so (p\mid z a_k+s b).

No full witness and (t\in K_k) give (d/(np)<1/N), hence (Nd<np). ∎

Thus every oriented active edge has the required individual canonical numerator (nz\pm1), exact pivot grid, and literal signed residue. Nothing here synchronizes different edges.

---

## 5. Exact active-cycle obstruction

For

[
a=(1,2,6,8,10),\qquad n=5,\quad N=6,
]

the tuple is primitive, satisfies the residual-height inequality, has the (N)-divisible speed 6, and every deletion is certifiable.

Every maximizing choice was enumerated. At each deletion, the active target is forced:

| Deleted speed | (\eta_k) | All maximizing times     | Active pivot at every maximum | Representative canonical row                         |
| ------------: | -------: | ------------------------ | ----------------------------: | ---------------------------------------------------- |
|             1 |   (7/25) | (7/25,18/25)             |                            10 | (r=14=5\cdot3-1), residues `(14,22,16,12,10)` mod 50 |
|             2 |   (9/20) | (9/40,11/40,29/40,31/40) |                             8 | (r=9=5\cdot2-1), residues `(9,18,14,8,10)` mod 40    |
|             6 |   (7/20) | (9/40,11/40,29/40,31/40) |                             8 | (r=9=5\cdot2-1), residues `(9,18,14,8,10)` mod 40    |
|             8 |   (6/25) | (11/50,7/25,18/25,39/50) |                            10 | (r=11=5\cdot2+1), residues `(11,22,16,12,10)` mod 50 |
|            10 |    (1/4) | (9/40,11/40,29/40,31/40) |                             8 | (r=9=5\cdot2-1), residues `(9,18,14,8,10)` mod 40    |

The functional graph in speed labels is

[
1\to10,\qquad
2\to8,\qquad
6\to8,\qquad
8\to10,\qquad
10\to8.
]

Its only directed cycle is

[
8\leftrightarrow10,
]

which excludes the (N)-divisible speed 6.

Moreover, the two cycle vertices have:

* different maximizing times;
* disjoint maximizing-time sets;
* different pivots;
* different moduli, 50 and 40;
* different canonical numerators.

Therefore:

* “the active cycle must contain an (N)-divisible coordinate” under the bare corrected-DPLP premises is `rejected`;
* “times or grids can be identified around the cycle” is `rejected`.

This tuple has full witnesses and exceptional-good certificates, so it does **not** refute a strengthened cycle-capture statement that explicitly assumes no full witness. It shows that such a statement cannot follow from D6’s finite-graph conclusion or from corrected-DPLP’s structural premises alone.

### Divisible-pivot obstruction

The pivot speed 6 has 16 certificates and no exceptional-good one:

| Deleted speed | Canonical numerators for pivot 6 |
| ------------: | -------------------------------- |
|             2 | (13,14,16,17)                    |
|             8 | (7,8,11,19,22,23)                |
|            10 | (6,9,12,18,21,24)                |

Thus “some lift must use an (N)-divisible pivot” is also `rejected`.

**Decision for the D6 active-cycle mechanism:** `stop`.

---

## 6. A synchronized component cycle that does include every deletion

The preceding obstruction concerns the functional graph obtained by choosing one active edge per deletion. D4 permits a different synchronization.

### Lemma B4: global component-successor cycle

Assume:

1. there is no full (1/N) witness;
2. every (K_k) is nonempty.

Each (K_k) is a finite union of compact connected components. By D4, components belonging to distinct (K_k) are disjoint.

Let (\mathcal P) be the finite set of all components of all (K_k), cyclically ordered around (\mathbb R/\mathbb Z). Sending each component to the next component in this cyclic order is one directed cycle through every member of (\mathcal P).

Consequently, this component cycle contains at least one component labelled by every deletion index, including every index (q) with (N\mid a_q).

**Status:** `proved-math`.

#### Proof

Each constraint (f_i(t)\ge1/n) is a finite union of closed arcs, so each (K_k) is a finite union of compact arcs or points. D4 makes components with different labels disjoint. A finite cyclically ordered set has a successor permutation consisting of one cycle through all its members. Since every (K_k) is nonempty, every label occurs. ∎

### Lemma B5: exact inter-component gap

Let consecutive components in this cycle have distinct labels (k\ne\ell), and let (g) be the positively oriented gap between them. Then

[
g>
\max\left{
\frac1{nN a_k},
\frac1{nN a_\ell}
\right}.
]

**Status:** `proved-math`.

#### Proof

At the endpoint (x) of the (K_k)-component, no full witness gives

[
f_k(x)<\frac1N.
]

At the first point (y) of the (K_\ell)-component, (k\ne\ell), so

[
f_k(y)\ge\frac1n.
]

Since (f_k) is (a_k)-Lipschitz,

[
a_k g\ge f_k(y)-f_k(x)>\frac1n-\frac1N=\frac1{nN}.
]

This gives (g>1/(nN a_k)). Interchanging (k) and (\ell) gives the other bound. ∎

This is genuine common-circle synchronization and forces the divisible deletion label onto the component cycle. It does **not** synchronize the maximizing active edges or their (n a_j)-grids. No implication from a component successor to a canonical active successor was found.

**Decision:** retain as `proved-math` geometry, but `stop` it as a standalone selector mechanism.

---

## 7. Attack C: reverse-grid lifting and minimum escape

This was the only mechanism that survived the falsification stage.

### Lemma C1: exact reverse-grid identity

Continue with an oriented active edge from Lemma B3. Define

[
Q=\frac{z a_k+s b}{p}\in\mathbb Z,
\qquad
R\equiv NQ-s\pmod{N a_k},
\quad 0\le R<N a_k,
]

and

[
\Delta
======

# \frac{1/N-d/(np)}{a_k}

\frac{np-Nd}{Nnp,a_k}.
]

Then

[
t-s\Delta
=========

\frac{NQ-s}{N a_k}
\pmod1
======

\frac{R}{N a_k}\pmod1.
]

At the reverse point

[
u=\frac{R}{N a_k},
]

the deleted coordinate is exactly on the closed (1/N) boundary:

[
\rho_{N a_k}(R a_k)=a_k.
]

For every coordinate (h),

[
f_h(u)\ge\frac1N
\iff
\rho_{N a_k}(R a_h)\ge a_k.
]

For the original active pivot (p),

[
\rho_{N a_k}(R p)
=================

\rho_{N a_k}(N b-p).
]

**Status:** `proved-math`.

#### Proof

Using (t=(nz+s)/(np)),

[
\begin{aligned}
t-s\Delta
&=
\frac{nz+s}{np}
---------------

s\frac{np-Nd}{Nnp,a_k}\
&=
\frac{N a_k(nz+s)-s(np-Nd)}
{Nnp,a_k}\
&=
\frac{n\bigl(N(z a_k+s b)-sp\bigr)}
{Nnp,a_k}\
&=
\frac{NQ-s}{N a_k}.
\end{aligned}
]

Because (R\equiv-s\pmod N),

[
\rho_{N a_k}(R a_k)
===================

# a_k\rho_N(R)

a_k.
]

The full-witness equivalence follows by dividing residues by (N a_k).

Finally,

[
Rp=(NQ-s)p
=N(z a_k+s b)-sp
\equiv s(Nb-p)\pmod{N a_k}.
]

Cyclic distance is invariant under sign, giving the pivot identity. ∎

This bridge explicitly changes from the original grid (np) to the reverse grid (N a_k). No common-grid identification is used.

---

## 8. A direct reverse-lifting criterion

The reverse-grid arithmetic suggests a more general metric lemma that does not require active equality.

### Lemma C2: Lipschitz escape criterion

Let ((k,j,r)) be any deep deletion certificate. Put

[
p=a_j,\qquad
d=\rho_{np}(r a_k),
\qquad
A_{-k}=\max_{h\ne k}a_h.
]

If

[
A_{-k}(np-Nd)\le p a_k,
]

then moving from (t=r/(np)) in a direction that increases the deleted norm produces a full closed (1/N) witness.

**Status:** `proved-math`.

#### Proof

The required displacement is

[
\Delta=\frac{np-Nd}{Nnp,a_k}.
]

Every survivor begins at distance at least (1/n). Since (f_h) is (a_h)-Lipschitz,

[
f_h(t+\varepsilon\Delta)
\ge
\frac1n-a_h\Delta.
]

The assumed inequality implies, for every (h\ne k),

[
a_h\Delta
\le
\frac1{nN}.
]

Therefore

[
f_h(t+\varepsilon\Delta)
\ge
\frac1n-\frac1{nN}
==================

\frac1N.
]

The deleted coordinate reaches exactly (1/N). ∎

Hence, in any no-full-witness tuple, every deep certificate must obey the strict obstruction

[
A_{-k}(np-Nd)>p a_k.
]

### Speed-gap corollary for oriented active edges

Define

[
\lambda_n(x)=(-x\bmod n)\in{0,\ldots,n-1}.
]

For an oriented active edge, Lemma B3 gives

[
d\equiv-a_k\pmod n,
]

so (d\ge\lambda_n(a_k)). Since (p\le A_{-k}), the no-full obstruction implies

[
a_k+N\lambda_n(a_k)<n A_{-k}.
]

In particular, if (a_k=A) is the unique maximum and (B) is the second-largest speed, then a hypothetical no-full tuple must satisfy

[
A+N\lambda_n(A)<nB.
]

Thus the complementary speed-gap regime

[
A+N\lambda_n(A)\ge nB
]

is excluded by a complete `proved-math` argument. This produces a genuine reverse-lifting subcase of the least-bad induction, but does not prove the corrected DPLP selector.

---

## 9. Chosen correlation/descent lemma

Let (M_k) be the full set of maximizers of (f_k) on (K_k). Define (\mathcal E(a)) to contain **all** oriented active edges

[
e=(k,t,\varepsilon,j),
]

where:

1. (t\in M_k);
2. (\varepsilon) locally increases (f_k);
3. (j\ne k);
4. (f_j(t)=1/n);
5. direction (\varepsilon) locally decreases (f_j).

Each edge carries the exact derived data

[
p_e,r_e,s_e,d_e,b_e,z_e,Q_e,R_e,\Delta_e
]

from Lemmas B3 and C1.

Under no-full-witness and (K_k\ne\varnothing), (\mathcal E(a)\ne\varnothing). It is finite: a maximizer below (1/N<1/2) cannot lie in the interior of a component of (K_k), so it lies at one of finitely many active boundary points.

Choose

[
e\in\operatorname*{argmin}*{e'\in\mathcal E(a)}\Delta*{e'}.
]

Write

[
\gamma_e(\delta)=t_e-s_e\delta,
\qquad
0\le\delta\le\Delta_e.
]

The reverse endpoint (\gamma_e(\Delta_e)) places the deleted coordinate exactly at (1/N).

### `MINIMUM-ESCAPE-FIRST-BLOCKER-DESCENT`

Under:

* all corrected-DPLP premises;
* no full (1/N) witness;
* no exceptional-good member of (\bigcup_k C_k(a));

let (e) be a global minimum-escape oriented edge.

No full witness implies some survivor is below (1/N) at the reverse endpoint. Define

[
\tau_e
======

\min\left{
\delta\in[0,\Delta_e]:
\min_{h\ne k_e} f_h(\gamma_e(\delta))
\le\frac1N
\right}.
]

Then (0<\tau_e<\Delta_e). Choose the least index (h_e\ne k_e) satisfying

[
f_{h_e}(\gamma_e(\tau_e))=\frac1N.
]

The proposed conclusion is:

[
\exists e'\in\mathcal E(a),
\qquad
\Delta_{e'}<\Delta_e.
]

**Status:** `conjectural`, `open`.

This is the chosen correlation lemma. It is not a renamed DPLP conclusion. Its input already contains:

* one globally justified minimizing edge;
* one explicit oriented path;
* one exact first blocker;
* one exact (N a_{h_e})-grid crossing.

Its output is only a strict descent in a concrete scalar cost.

If proved, it immediately contradicts the definition of (e) as a global minimizer. Hence it would rule out the residual least-bad configuration directly, without proving corrected DPLP for tuples that already possess some unrelated full witness.

### Single first unsupported implication

The first unsupported step is exactly

[
(e,h_e,\tau_e)
\quad\Longrightarrow\quad
\exists e'\in\mathcal E(a),\ \Delta_{e'}<\Delta_e.
]

Everything before this implication is `proved-math`.

At the first blocker,

[
\gamma_e(\tau_e)
================

\frac{Nw\pm1}{N a_{h_e}}
\pmod1
]

for some integer (w). This is an (N a_{h_e})-grid point. A new oriented active edge for deletion (h_e), however, must arise from a maximizer of (K_{h_e}) and lie on an (n a_j)-grid for some active pivot (j). Neither D4, the component-successor cycle, nor the original active cycle supplies that grid conversion. This is the precise remaining synchronization problem.

**Decision:** `continue` only on this implication.

---

## 10. Targeted adversarial sweep

The deterministic audit domain contained 4,694 distinct primitive positive injective tuples. Membership counts overlap because duplicate tuples were merged.

| Family                             | Membership count |
| ---------------------------------- | ---------------: |
| Mandatory tuples                   |                5 |
| Consecutive (n=2,\ldots,30)        |               29 |
| Known tight records                |                7 |
| (N)-spikes                         |               81 |
| Affine-residue constructions       |            1,105 |
| Large (N)-multiples                |               54 |
| Mutations around raw-lift failures |              221 |
| Forced-(N) mutations               |            1,650 |
| CRT-structured tuples              |               81 |
| Seeded deterministic mutations     |            1,623 |

The tuples labelled as tight include the standard consecutive family and the nonconsecutive tight instances recorded in the survey literature. ([arXiv][2])

Exact census:

* 4,694 of 4,694 had nonempty certificate sets for every deletion.
* 4,296 satisfied all corrected-DPLP premises.
* 0 corrected-DPLP failures were found.
* 36 tuples had zero exceptional-good certificates.
* Those 36 were the consecutive family through (n=30) and the nonconsecutive tight records in the domain.
* For all 36, every maximizing choice and every oriented active blocker was enumerated.
* The global minimum-(\Delta) layer always contained exactly two oriented edges.
* Both minimizing edges were reverse-full in every one of the 36 cases.
* Selector failures: 0.

This is `computed finite evidence`, not a proof. In particular, the minimum-layer evidence does not test the first-blocker descent branch, because the minimizing reverse endpoint was already full in every zero-exceptional record.

### Mandatory tuples

| Tuple                               | Certificate counts by deletion                | Exceptional-good counts                       | (K_k) component counts               | (\eta_k)                                       |
| ----------------------------------- | --------------------------------------------- | --------------------------------------------- | ------------------------------------ | ---------------------------------------------- |
| `(1,3,4,7)`                         | `8,8,11,4`                                    | `0,0,0,0`                                     | `4,2,3,2`                            | `3/16,5/28,1/7,1/12`                           |
| `(1,2,3,60)`                        | `48,30,48,6`                                  | `18,0,6,0`                                    | `16,10,16,2`                         | `59/240,19/120,19/80,0`                        |
| `(1,3,4,5,18)`                      | `26,18,22,22,4`                               | `0,0,2,2,0`                                   | `4,4,4,4,2`                          | `7/45,1/10,8/45,1/6,1/10`                      |
| `(1,2,6,8,10)`                      | `8,22,16,16,26`                               | `8,8,8,4,4`                                   | `4,6,6,4,6`                          | `7/25,9/20,7/20,6/25,1/4`                      |
| `(15,21,40,48,56,105,126,280,1200)` | `2400,2448,2406,2316,2368,2428,2412,1942,882` | `1842,1846,1828,1808,1810,1756,1776,1588,708` | `274,280,290,268,286,288,280,244,96` | `359/720,13/27,67/135,1/2,1/2,1/2,1/2,1/2,1/2` |

For the large tuple, the numbers of maximizing choices were

[
8,2,16,2,14,8,12,38,136.
]

For coordinates with (\eta_k=1/2), there is no direction locally increasing the deleted norm and no oriented active edge. This directly demonstrates why D5 and D6 cannot be applied without the no-full-witness hypothesis.

### Closed lifts for `(1,3,4,5,18)`

All four exceptional-good rows use pivot 18, modulus 90:

| Deleted speed | (r) | Residues           |
| ------------: | --: | ------------------ |
|             5 |  39 | `(39,27,24,15,18)` |
|             4 |  41 | `(41,33,16,25,18)` |
|             4 |  49 | `(41,33,16,25,18)` |
|             5 |  51 | `(39,27,24,15,18)` |

The closed endpoint (6\rho_{90}(r a_k)\ge90) is preserved exactly.

---

## 11. Deterministic audit record

| Field                              | Value                                                                                      |
| ---------------------------------- | ------------------------------------------------------------------------------------------ |
| Audit version                      | `PRO-C-AUDIT-1.0.0`                                                                        |
| Date                               | `2026-08-03`                                                                               |
| Domain size                        | 4,694 tuples                                                                               |
| Maximum speed                      | 2,600                                                                                      |
| Ordering                           | First insertion by generator family order; tuple sorted ascending; exact duplicates merged |
| Implementation A                   | Python 3.13.5, exact integers/Fractions, `hashlib` SHA-256                                 |
| Implementation B                   | C++20, g++ 14.2.0, independent rational type, OpenSSL 3.5.5 SHA-256                        |
| Generator runtime                  | 0.80 s                                                                                     |
| Implementation A runtime           | 20.75 s                                                                                    |
| Implementation B runtime           | 3.01 s                                                                                     |
| Combined source SHA-256            | `312743385da9a3ccc53db4b5ce17a2d75c0595317e321d2b617c41f388e19ca9`                         |
| Core output SHA-256                | `8eb8ad610e55c24170034cf634ea77fcd207cc5fc327efc9af155737beb6de2d`                         |
| Active output SHA-256              | `68708b833c996071cdee8a0f59b197ef4ea2bdab15d0a150d1ff1a0f9ae44aa9`                         |
| Combined normalized output SHA-256 | `4a60dbca971cfc1edc65984b5d26ba2960f3fcfe2d85986c90e5dabdec502dc8`                         |
| Manifest SHA-256                   | `26b477e46b982f3170f99bf277319efdc107e50f1fd0ead5c241d28c708bfacd`                         |
| Independent agreement              | Core and active outputs byte-identical                                                     |
| Bundle SHA-256                     | `5832a26d51410dd661c545be4490e39dadc445a65fc80590917dc4e1474a0f8b`                         |

Both implementations enumerate every certificate member, not one selected certificate per deletion. The active audit enumerates every connected component, every maximizing time, every active index, and every oriented canonical edge in its tested population.

---

## 12. Audit of the induction arrows

| Arrow                                                                                                           | Status                                                                                                                   |
| --------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| Hypothetical least bad moving dimension (\Rightarrow) all lower moving dimensions satisfy the closed conjecture | `proved-math` by definition of least bad dimension                                                                       |
| Primitive normalization                                                                                         | `proved-math`; scaling preserves the orbit after reciprocal time rescaling                                               |
| (\max a\le N+\lfloor N/3\rfloor\Rightarrow) witness                                                             | `proved-lean` supplied baseline                                                                                          |
| No (a_i) divisible by (N\Rightarrow t=1/N) is a witness                                                         | `proved-math`: (\rho_N(a_i)\ge1)                                                                                         |
| Some (a_q) divisible by (N) and lower-dimensional completeness (\Rightarrow C_k(a)\ne\varnothing) for every (k) | `conditional` on the supplied lower-dimensional pivot equivalence; mathematically the deletion tuple has threshold (1/n) |
| Corrected DPLP premises (\Rightarrow) exceptional-good certificate                                              | `conjectural`, `open`                                                                                                    |
| Exceptional-good certificate (\Rightarrow t=r/(np)) full witness                                                | `proved-lean` supplied baseline                                                                                          |
| Positive-integer conclusion (\Rightarrow) unrestricted real-speed LRC                                           | `proved-lean` supplied endpoint-safe reduction                                                                           |
| Entire chain                                                                                                    | `conditional`, not `proved-lean`                                                                                         |

For the selected-certificate implication, the arithmetic is:

* survivors:
  [
  \frac{\rho_{np}(r a_i)}{np}\ge\frac p{np}=\frac1n>\frac1N;
  ]
* deleted coordinate:
  [
  np\le N\rho_{np}(r a_k)
  \Longrightarrow
  \frac{\rho_{np}(r a_k)}{np}\ge\frac1N.
  ]

The unresolved selector arrow remains indispensable for the corrected DPLP route.

---

## 13. Sole next Lean declaration

No Lean prototype was compiled in this cell. The only declaration currently worth adding is the arithmetic bridge, not the conjectural descent:

```lean
theorem orientedActiveCert_reverseGrid
    -- r = n*z + s, s ∈ {−1,1}
    -- r*ak ≡ −s*d (mod n*p)
    -- ak + d = n*b
    -- z*ak + s*b = p*Q
    :
    let N := n + 1
    let Δ := (n*p - N*d) / (N*n*p*ak)
    let R := (N*Q - s) % (N*ak)
    (r / (n*p) - s*Δ = R / (N*ak) mod 1)
      ∧ rho (N*ak) (R*ak) = ak
      ∧ rho (N*ak) (R*p) = rho (N*ak) (N*b - p)
```

Intended status: `open` as a proposed declaration. Its proof is elementary ring and modular arithmetic and would kernel-check the entire reverse-grid bridge before work resumes on first-blocker descent.

---

## 14. Stop/continue decisions

| Mechanism                                                 | Decision                                         | Status                                    |
| --------------------------------------------------------- | ------------------------------------------------ | ----------------------------------------- |
| Exact empty/deep/shell row classification                 | Retain                                           | `proved-math`                             |
| Fixed-pivot or fixed-deletion deep-to-shell exchange      | Stop                                             | `rejected`                                |
| Low-order incidence inequality without full overlap terms | Stop                                             | Known mandatory obstructions remain       |
| Arbitrary one-certificate-per-deletion averaging          | Stop                                             | Quantifier error                          |
| D6 cycle forced through divisible coordinate              | Stop                                             | `rejected` under bare structural premises |
| Common time or common pivot grid around D6 cycle          | Stop                                             | `rejected`                                |
| Global component-successor cycle                          | Retain as auxiliary geometry                     | `proved-math`, insufficient               |
| Lipschitz reverse-lifting subcase                         | Continue as a closed subcase                     | `proved-math`                             |
| Minimum-escape reverse-grid selector                      | Continue                                         | `computed finite evidence`                |
| First-blocker-to-smaller-edge transition                  | Continue as sole target                          | `conjectural`, `open`                     |
| Corrected DPLP overall                                    | Continue only through the selected local descent | `conjectural`, `open`                     |
| Unrestricted LRC                                          | No claim                                         | `open`                                    |

### Audit artifacts

* [Complete PRO-C audit bundle](sandbox:/mnt/data/pro_c_audit/pro_c_audit_bundle.zip)
* [Audit manifest](sandbox:/mnt/data/pro_c_audit/audit_manifest.json)
* [Literal residue and counterexample tables](sandbox:/mnt/data/pro_c_audit/literal_tables.md)
* [Normalized audit summary](sandbox:/mnt/data/pro_c_audit/audit_summary.json)
* [Implementation A core output](sandbox:/mnt/data/pro_c_audit/impl_a_core.tsv)
* [Implementation A active-set output](sandbox:/mnt/data/pro_c_audit/impl_a_active.tsv)
* [Implementation B source](sandbox:/mnt/data/pro_c_audit/impl_b.cpp)
* [Implementation A source](sandbox:/mnt/data/pro_c_audit/impl_a.py)

[1]: https://arxiv.org/pdf/2607.16082 "Lonely runners in real life: Sharp bounds for time-dependent velocities"
[2]: https://arxiv.org/pdf/2409.20160 "The Lonely Runner Conjecture turns 60"
