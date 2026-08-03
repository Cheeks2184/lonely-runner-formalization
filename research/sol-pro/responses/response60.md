# PRO-E independent adversarial audit

Unrestricted Lonely Runner remains `open`. This audit does not establish a corrected DPLP induction, uniform prime forcing, or an unrestricted theorem.

No result is assigned `proved-lean` by this cell. No pinned project checkout, revision, or exact declaration was available for replay, so the two neutral Lean soundness facts stated in the prompt remain `conditional` on the supplied project audit.

Prompt 60 also does not define the phrase “the height branch” as a mathematical predicate. Positivity, injectivity, primitivity, (N)-divisibility, deletion gcds, and deletion-certificate existence were checked. Membership in an additional unstated height subbranch cannot be independently certified.

## 1. Exact status table

| Statement                                                                            | Status                                                 | Independent audit result                                                                                                                                                                 |
| ------------------------------------------------------------------------------------ | ------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Selected deletion certificate plus exact exceptional inequality gives a full witness | `proved-math`; supplied as `conditional` Lean baseline | Direct arithmetic proof given below. No independent kernel replay.                                                                                                                       |
| Neutral wrapper from certificate existence plus a supplied selector implication      | `conditional`                                          | Accepted only at the stated neutral strength. It does not prove the selector or structural DPLP contract.                                                                                |
| Full corrected DPLP bridge already kernel-checked                                    | `rejected`                                             | No exact declaration with positivity, injectivity, primitivity, height hypothesis, (N)-divisibility, all deletion certificates, selector, and induction chain was exhibited or replayed. |
| D1 exact complement identity                                                         | `proved-math`                                          | Correct, including the closed lower shell boundary.                                                                                                                                      |
| D2 pointwise lower bound                                                             | `proved-math`                                          | Correct.                                                                                                                                                                                 |
| Uniform strict positivity of the D2 bound                                            | `rejected` on the explicitly stated arithmetic domain  | ((1,2,3,60)) has no positive D2 lower bound at any pivot but has exact lifts.                                                                                                            |
| D3 third-order lower bound                                                           | `proved-math`                                          | Correct third-order Bonferroni upper bound on the deep union.                                                                                                                            |
| Uniform strict positivity of the D3 bound                                            | `rejected` on the explicitly stated arithmetic domain  | ((1,3,4,5,18)) has D3 lower bound at most zero at every pivot but has exact closed-boundary lifts.                                                                                       |
| Raw deletion lifting without an (N)-divisible speed                                  | `rejected`                                             | ((1,3,4,7)): every deletion has a certificate, no certificate lifts, but (t=1/5) is a direct full witness.                                                                               |
| Compactness of (K_k) and attainment of (\eta_k)                                      | `proved-math`                                          | Correct.                                                                                                                                                                                 |
| D4 pairwise disjointness of deletion-safe sets under no full witness                 | `proved-math`                                          | Correct because (1/n>1/(n+1)).                                                                                                                                                           |
| D5 active coordinate at every chosen maximizer                                       | `proved-math`                                          | Correct. The quantifier is over every maximizing choice.                                                                                                                                 |
| D6 functional-graph cycle                                                            | `proved-math`                                          | Every allowed active-coordinate selection has a directed cycle; the actual cycle may depend on the selection.                                                                            |
| Active maximizer yields a canonical deletion certificate                             | `proved-math`                                          | Stronger than mere coexistence: every active equality produces a numerator (r\equiv\pm1\pmod n).                                                                                         |
| Every active cycle must include an (N)-divisible coordinate                          | `rejected` without additional hypotheses               | Smallest witness in ((n,\text{height},\text{lex})) order is ((1,2,4)); the cycle (1\leftrightarrow2) avoids speed (4).                                                                   |
| `NDivisibleActiveCycleBreak`                                                         | `conjectural`                                          | All named (N)-divisible tests satisfy its conclusion, but the active-cycle-to-lift implication is unsupported.                                                                           |
| Corrected DPLP                                                                       | `conjectural`                                          | Low-order counts and the active graph do not complete the selector implication.                                                                                                          |
| P1 large-prime almost-forcing inequality                                             | `proved-math`                                          | Correct exact fiber count and inequality. Deletion gcds are not needed for P1.                                                                                                           |
| P1 plus deletion gcds forces an empty residue                                        | `rejected`                                             | (n=3,p=5,v=(1,3,4)\pmod{20}) has (Z_0=0), (Z_1=13).                                                                                                                                      |
| (\mathrm{PrimeForcing}(3,5))                                                         | `rejected`                                             | Same residue tuple.                                                                                                                                                                      |
| P2 strict sign-class condition                                                       | `proved-math`                                          | Correct, and it strengthens from (<) to (\le).                                                                                                                                           |
| Deletion gcds imply (2s<N)                                                           | `rejected`                                             | Smallest witness: (n=2,N=3,p=3,v=(1,2)\pmod9), with (s=2).                                                                                                                               |
| Published product reduction                                                          | `conditional`                                          | Primary-source statement verified. Its use remains external to the Lean project audit.                                                                                                   |
| Exact integer product comparison                                                     | `proved-math`                                          | (n^nQ\ge \binom{n+1}{2}^{n(n-1)}). No floor is present.                                                                                                                                  |
| Uniform prime-forcing supply for (n=3)                                               | `computed finite evidence`                             | (P_3={2,3,7,11,13}), product (6006>1728).                                                                                                                                                |
| Uniform prime-forcing supply for every induction dimension                           | `conjectural`                                          | No general construction or proof.                                                                                                                                                        |
| Unrestricted Lonely Runner                                                           | `open`                                                 | No unrestricted proof claim.                                                                                                                                                             |

---

## 2. Corrected fully quantified statements

Throughout, (n\ge2), (N=n+1), (a:\operatorname{Fin}n\to\mathbb N_{>0}), and (j\in\operatorname{Fin}n). Put (p=a_j), (M=np), and (I_j={i:i\ne j}).

### D1. Exact complement identity

For every such (a,j),

[
R_j\setminus G_j
================

\left(\bigcup_{i\in I_j}D_{ji}\right)
\cup
\left{
r\in R_j:
#{i\in I_j:r\in H_{ji}}\ge2
\right}.
]

Equivalently,

[
R_j\setminus G_j
================

\left(\bigcup_{i\in I_j}D_{ji}\right)
\cup
\left(\bigcup_{\substack{i,k\in I_j\i<k}}
H_{ji}\cap H_{jk}\right).
]

Status: `proved-math`.

### D2. First-order shell-surplus bound

For every such (a,j),

[
|G_j|
\ge
|R_j|
-\sum_{i\in I_j}|D_{ji}|
-\sum_{\substack{i,k\in I_j\i<k}}
|H_{ji}\cap H_{jk}|.
]

If the right side is positive, then (G_j\ne\varnothing), hence there is a selected deletion certificate that lifts to a full (1/N) witness.

Status: `proved-math`.

The assertion that this right side is positive for some pivot under all explicitly stated DPLP arithmetic premises is `rejected`.

### D3. Third-order deep Bonferroni bound

Define

[
\begin{aligned}
D1_j&=\sum_{i\in I_j}|D_{ji}|,\
D2_j&=\sum_{\substack{i,k\in I_j\i<k}}
|D_{ji}\cap D_{jk}|,\
D3_j&=\sum_{\substack{i,k,\ell\in I_j\i<k<\ell}}
|D_{ji}\cap D_{jk}\cap D_{j\ell}|,\
H2_j&=\sum_{\substack{i,k\in I_j\i<k}}
|H_{ji}\cap H_{jk}|.
\end{aligned}
]

Then

[
|G_j|
\ge
|R_j|-(D1_j-D2_j+D3_j)-H2_j.
]

Status: `proved-math`.

Uniform strict positivity for some pivot is `rejected`.

### Continuous definitions

Let (T=\mathbb R/\mathbb Z) and

[
f_i(t)=|a_i t|.
]

For (k\in\operatorname{Fin}n),

[
K_k={t\in T:\forall i\ne k,\ f_i(t)\ge1/n}.
]

When (K_k\ne\varnothing),

[
\eta_k=\max_{t\in K_k}f_k(t),
\qquad
\operatorname{Max}_k
====================

{t\in K_k:f_k(t)=\eta_k}.
]

Define

[
\operatorname{NoFull}_N(a)
\iff
\forall t\in T,\ \exists i,\ f_i(t)<1/N.
]

### D4. Pairwise disjoint deletion-safe sets

For all distinct (k,\ell),

[
\operatorname{NoFull}*N(a)
\Longrightarrow
K_k\cap K*\ell=\varnothing.
]

Status: `proved-math`.

### D5. Active coordinate at every chosen maximizer

For every (k), if (\operatorname{NoFull}_N(a)), (K_k\ne\varnothing), and (t_k\in\operatorname{Max}_k), then

[
\exists i\ne k,\qquad f_i(t_k)=1/n.
]

The quantifier is

[
\forall t_k\in\operatorname{Max}_k,\ \exists i\ne k,
]

not merely the existence of one favorable maximizer.

A stronger form also holds: the no-full-witness assumption may be replaced by the direct hypothesis (\eta_k<1/2).

Status: `proved-math`.

### D6. Active functional graph

Assume (\operatorname{NoFull}_N(a)) and every (K_k) is nonempty. Choose arbitrarily:

[
t_k\in\operatorname{Max}_k
]

and then choose arbitrarily an active coordinate

[
\sigma(k)\ne k,
\qquad
f_{\sigma(k)}(t_k)=1/n.
]

Then every such function (\sigma:\operatorname{Fin}n\to\operatorname{Fin}n) has a directed cycle of length (m\ge2):

[
k_0,k_1,\ldots,k_{m-1},
\qquad
\sigma(k_s)=k_{s+1\bmod m},
]

with the (k_s) pairwise distinct. On this cycle,

[
|a_{k_{s+1}}t_{k_s}|=1/n,
\qquad
|a_{k_s}t_{k_s}|<1/N.
]

Every allowed selection has at least one cycle. The theorem does not produce a single cycle common to all selections, and the times (t_{k_s}) remain different variables.

Status: `proved-math`.

### Active equality to canonical deletion certificate

For (k\ne j), suppose

[
t\in K_k,
\qquad
|a_jt|=1/n.
]

Then there exists (r) with

[
0\le r<na_j,
\qquad
r\equiv 1\ \text{or}\ -1\pmod n,
\qquad
t=\frac{r}{na_j}\quad\text{in }T,
]

such that

[
\rho_{na_j}(ra_i)\ge a_j
\quad
\text{for every }i\ne j,k.
]

Thus (t) is a canonical pivot-(j) deletion certificate for deletion (k).

If additionally (|a_kt|<1/N), then

[
N\rho_{na_j}(ra_k)<na_j,
]

so its exceptional deleted coordinate is deep-bad and the certificate does not lift.

Status: `proved-math`.

### `NDivisibleActiveCycleBreak`

The literal corrected target is:

[
\begin{aligned}
&\forall n\ge2,\ \forall a:\operatorname{Fin}n\to\mathbb N_{>0},\
&\quad
\operatorname{Injective}(a)
\land \gcd_i a_i=1
\land \bigl(\exists q,\ N\mid a_q\bigr)
\land \bigl(\forall k,\ K_k\ne\varnothing\bigr)\
&\qquad\Longrightarrow
\exists k,\ \eta_k\ge1/N.
\end{aligned}
]

Equivalently, it forbids

[
\forall k,\quad \eta_k<1/N.
]

Under the contrary assumption, the strengthened D5 supplies active coordinates for every maximizing selector, and D6 supplies a cycle for every active selector.

This target is stronger than merely proving that some unrelated full witness exists: it asserts that one full witness is found as a deletion-safe maximizer.

Status: `conjectural`.

### P1. Large-prime almost forcing

Let (n\ge2), (N=n+1), (p) prime, (M=Np), and let

[
v:\operatorname{Fin}n\to{0,\ldots,M-1}
]

satisfy (p\nmid v_i) for every (i). Repeated residues are allowed. Put

[
A_i={r\bmod M:\rho_M(rv_i)<p},
\qquad
\mu(r)=#{i:r\in A_i}.
]

Let (Z_m=#{r:\mu(r)=m}). Then

[
2Z_0+Z_1
\ge
2p-(N-1)(N-2).
]

Deletion-gcd assumptions are unnecessary for this inequality.

Status: `proved-math`.

### P2. Corrected sign-class theorem

Let (s) be the number of classes represented among the (v_i) under

[
v\sim w
\iff
v\equiv w\ \text{or}\ v\equiv-w\pmod M.
]

Then the following stronger sufficient condition holds:

[
s(2p+N-2)\le Np
\quad\Longrightarrow\quad
\exists r<M,\ \forall i,\ \rho_M(rv_i)\ge p.
]

The strict inequality proposed in Response 59 is valid but unnecessarily strong.

The condition automatically implies (2s<N). When (2s<N), it is equivalent to

[
p\ge \frac{s(N-2)}{N-2s},
]

or, in exact integer form,

[
p\ge
\left\lceil
\frac{s(N-2)}{N-2s}
\right\rceil.
]

Status: `proved-math`.

### `PrimeForcing(n,p)`

For (n\ge2), prime (p), (N=n+1), and (M=Np),

[
\operatorname{PrimeForcing}(n,p)
]

means that every residue tuple

[
v:\operatorname{Fin}n\to{0,\ldots,M-1}
]

satisfying

[
\forall i,\quad p\nmid v_i
]

and

[
\forall k,\quad
\gcd!\left(M,{v_i:i\ne k}\right)=1
]

has some (r\in{0,\ldots,M-1}) such that

[
\forall i,\quad \rho_M(rv_i)\ge p.
]

No injectivity or distinct-residue condition is present.

### `UniformPrimeForcingSupply`

For an induction range (I\subseteq{n\in\mathbb N:n\ge3}), the corrected supply statement is

[
\forall n\in I,\quad
\exists P_n\subseteq{\text{primes}}
]

with (P_n) finite and consisting of distinct primes, such that

[
\forall p\in P_n,\quad
\operatorname{PrimeForcing}(n,p)
]

and

[
n^n\prod_{p\in P_n}p
\ge
\binom{n+1}{2}^{n(n-1)}.
]

Equivalently,

[
\prod_{p\in P_n}p
\ge
\left\lceil
\frac{\binom{n+1}{2}^{n(n-1)}}{n^n}
\right\rceil.
]

Status: `conjectural` in general; `computed finite evidence` for (n=3).

---

## 3. Proofs of the accepted mathematical statements

### Proof of D1

For (r\in R_j),

[
r\in G_j
\iff
\delta_j(r)=0\ \land\ s_j(r)\le1.
]

Because (\delta_j(r)) counts deep memberships,

[
\delta_j(r)=0
\iff
r\notin\bigcup_{i\ne j}D_{ji}.
]

Likewise,

[
s_j(r)\le1
]

holds exactly when there do not exist two distinct nonpivot indices (i,k) for which

[
r\in H_{ji}\cap H_{jk}.
]

Negating the conjunction gives

[
r\in R_j\setminus G_j
\iff
r\in\bigcup_{i\ne j}D_{ji}
\quad\text{or}\quad
r\in H_{ji}\cap H_{jk}
\text{ for some }i<k.
]

This is the asserted identity.

The endpoint convention is preserved: if

[
N\rho_M(ra_i)=np,
]

then (r\notin D_{ji}). If also (\rho_M(ra_i)<p), then (r\in H_{ji}).

### Proof of D2

By D1,

[
|R_j\setminus G_j|
\le
\left|\bigcup_{i\ne j}D_{ji}\right|
+
\left|
\bigcup_{i<k}
(H_{ji}\cap H_{jk})
\right|.
]

Applying the elementary union bound separately,

[
|R_j\setminus G_j|
\le
\sum_{i\ne j}|D_{ji}|
+
\sum_{i<k}|H_{ji}\cap H_{jk}|.
]

Since (G_j\subseteq R_j),

[
|G_j|=|R_j|-|R_j\setminus G_j|,
]

which proves D2.

### Proof of D3

For (r\in R_j), put (m=\delta_j(r)). Pointwise,

[
m-\binom m2+\binom m3
=====================

\begin{cases}
0,&m=0,[2mm]
1+\binom{m-1}{3},&m\ge1.
\end{cases}
]

Therefore

[
\mathbf 1_{{m\ge1}}
\le
m-\binom m2+\binom m3.
]

Summing over (r\in R_j) gives

[
\left|\bigcup_{i\ne j}D_{ji}\right|
\le
D1_j-D2_j+D3_j.
]

The set of residues lying in at least two shell sets is contained in

[
\bigcup_{i<k}(H_{ji}\cap H_{jk}),
]

whose cardinality is at most (H2_j). D1 now gives

[
|R_j\setminus G_j|
\le
D1_j-D2_j+D3_j+H2_j.
]

Subtracting from (|R_j|) proves D3.

### Why (G_j\ne\varnothing) gives a lift

Take (r\in G_j), (p=a_j), and (t=r/(np)).

For the pivot coordinate,

[
|a_jt|
======

\left|\frac r n\right|
\ge\frac1n

> \frac1N,
> ]

because (n\nmid r).

There are no deep-bad nonpivot coordinates. Hence every nonpivot coordinate satisfies

[
|a_it|\ge1/N.
]

There is at most one shell coordinate.

If there is one shell coordinate (k), delete (k). Every other nonpivot coordinate lies outside (B_{ji}), so

[
|a_it|\ge1/n
\qquad(i\ne j,k),
]

while the shell definition gives the closed exceptional inequality

[
|a_kt|\ge1/N.
]

If there is no shell coordinate, choose any (k\ne j). Every nonpivot coordinate is outside (B_{ji}), so the same conclusion holds.

Thus (r) is a selected deletion certificate whose exceptional coordinate satisfies the exact lift inequality.

### Compactness and attainment

The circle (T=\mathbb R/\mathbb Z) is compact. Each map

[
t\longmapsto|a_it|
]

is continuous. Therefore

[
K_k
===

\bigcap_{i\ne k}
f_i^{-1}!\left([1/n,1/2]\right)
]

is closed in (T), hence compact.

When (K_k\ne\varnothing), the continuous function (f_k) attains its maximum on (K_k). Thus (\eta_k) is an actual maximum, not merely a supremum.

### Proof of D4

Suppose (t\in K_k\cap K_\ell) with (k\ne\ell).

Membership in (K_k) gives

[
f_i(t)\ge1/n
\quad(i\ne k),
]

and membership in (K_\ell) additionally gives

[
f_k(t)\ge1/n.
]

Thus every coordinate is at least (1/n). Since

[
\frac1n>\frac1{n+1}=\frac1N,
]

(t) is a full (1/N) witness, contradicting (\operatorname{NoFull}_N(a)).

### Proof of D5

Let (t_k\in\operatorname{Max}_k). Under no full witness, every (i\ne k) satisfies

[
f_i(t_k)\ge1/n>1/N.
]

Consequently,

[
f_k(t_k)<1/N<1/2.
]

Suppose every constraint is strict:

[
f_i(t_k)>1/n
\qquad(i\ne k).
]

By continuity and finiteness of the index set, some neighborhood (U) of (t_k) satisfies

[
U\subseteq K_k.
]

Hence (t_k) is a local maximum of (f_k(t)=|a_kt|) on the entire circle.

The triangular-wave function (t\mapsto|a_kt|) has no local maximum at a value below (1/2):

* At phase (0), the value is a local minimum.
* At phase (x\in(0,1/2)), a sufficiently small perturbation in the positive phase direction increases the value.
* At phase (x\in(1/2,1)), a sufficiently small perturbation in the negative phase direction increases the value.
* The only local maxima occur at antipodes, where the value is (1/2).

This contradicts (f_k(t_k)<1/2). Therefore at least one constraint is active:

[
f_i(t_k)=1/n
]

for some (i\ne k).

The same argument proves the strengthened version under the direct hypothesis (\eta_k<1/2).

### Proof of D6

For a fixed permitted choice of maximizers and active coordinates, (\sigma) is a function on a finite (n)-element set with

[
\sigma(k)\ne k.
]

Starting from any vertex and repeatedly applying (\sigma), some vertex repeats within (n+1) steps. Taking the first repeated segment produces a directed cycle. The absence of self-loops forces its length to be at least two.

The active equality gives

[
|a_{\sigma(k)}t_k|=1/n.
]

Under no full witness, all coordinates other than (k) are already (>1/N), so

[
|a_kt_k|<1/N.
]

Applying these facts to each cycle edge gives the stated relations.

### Proof of the canonical active-certificate bridge

Let (j\ne k), (t\in K_k), and

[
|a_jt|=1/n.
]

Choose a real representative (\tau) of (t). There are (m\in\mathbb Z) and (\varepsilon\in{1,-1}) such that

[
a_j\tau=m+\frac{\varepsilon}{n}.
]

Therefore

[
\tau=\frac{nm+\varepsilon}{na_j}.
]

Reduce (nm+\varepsilon) modulo (na_j) to its unique representative (r) in ([0,na_j)). Then

[
r\equiv\varepsilon\pmod n,
]

so (n\nmid r), and

[
t=\frac r{na_j}
\quad\text{in }T.
]

For every (i\ne j,k), membership in (K_k) gives

[
\left|\frac{ra_i}{na_j}\right|\ge1/n.
]

Multiplying by (na_j),

[
\rho_{na_j}(ra_i)\ge a_j.
]

Thus (r) is a canonical deletion certificate with pivot (j) and deleted coordinate (k).

If (f_k(t)<1/N), then

[
\frac{\rho_{na_j}(ra_k)}{na_j}<\frac1N,
]

equivalently

[
N\rho_{na_j}(ra_k)<na_j.
]

So the certificate is deep-bad at its exceptional coordinate.

### Proof of P1

Fix (i) and put

[
d_i=\gcd(M,v_i).
]

Because (p\nmid v_i), also (p\nmid d_i). Since (d_i\mid Np) and (p) is prime,

[
d_i\mid N.
]

Multiplication by (v_i) on (\mathbb Z/M\mathbb Z) has image the subgroup of multiples of (d_i), and every image point has exactly (d_i) preimages.

The target residues satisfying (\rho_M(x)<p) are

[
0,\pm1,\ldots,\pm(p-1).
]

Exactly

[
1+2\left\lfloor\frac{p-1}{d_i}\right\rfloor
]

of these are multiples of (d_i). Hence the exact fiber count is

[
|A_i|
=====

d_i\left(
1+2\left\lfloor\frac{p-1}{d_i}\right\rfloor
\right).
]

Therefore

[
|A_i|
\le
2p+d_i-2
\le
2p+N-2.
]

Now

[
\sum_r\mu(r)=\sum_i|A_i|.
]

Also,

[
\begin{aligned}
2M-\sum_i|A_i|
&=\sum_r(2-\mu(r))\
&=2Z_0+Z_1-\sum_{\mu(r)\ge3}(\mu(r)-2)\
&\le2Z_0+Z_1.
\end{aligned}
]

Using (M=Np) and (n=N-1),

[
\begin{aligned}
2Z_0+Z_1
&\ge2Np-(N-1)(2p+N-2)\
&=2p-(N-1)(N-2).
\end{aligned}
]

This proves P1.

### Proof of the strengthened P2 condition

Residues in the same sign class have identical bad sets because

[
\rho_M(rv)=\rho_M(-rv).
]

Choose one representative from each represented sign class. The union of all bad sets is therefore the union of (s) sets, each of size at most

[
B=2p+N-2.
]

If (sB<Np=M), the union has cardinality less than (M), giving a safe residue.

It remains to handle equality:

[
sB=M.
]

Suppose the bad sets nevertheless covered all (M) residues. Since their total cardinality is at most (sB=M), every representative bad set would have to attain the upper bound (B).

For a representative with (d=\gcd(M,v)), equality

[
d\left(
1+2\left\lfloor\frac{p-1}{d}\right\rfloor
\right)
=

2p+N-2
]

forces both

[
d=N
\qquad\text{and}\qquad
N\mid p-1.
]

Write

[
p=1+qN,
\qquad q\ge1.
]

Then

[
B=2p+N-2=N(2q+1).
]

The equality (sB=Np) becomes

[
s(2q+1)=p.
]

Since (p) is prime and (q\ge1), the only possible factorization would be

[
s=1,\qquad 2q+1=p.
]

Combining this with (p=1+qN) gives

[
q(N-2)=0,
]

contradicting (N\ge3) and (q\ge1).

Thus equality cannot produce a complete cover. Hence

[
s(2p+N-2)\le Np
]

is sufficient.

Finally, if (2s\ge N), then

[
s(2p+N-2)-Np
============

p(2s-N)+s(N-2)>0,
]

so the sufficient inequality cannot hold. When (2s<N), rearrangement gives

[
p(N-2s)\ge s(N-2),
]

which is the stated eventual form.

### Local prime-forcing-to-divisor lemma

Let (a_1,\ldots,a_n) be integer speeds. Assume:

1. (\operatorname{PrimeForcing}(n,p));
2. (p\nmid a_i) for every (i);
3. (\gcd(M,{a_i:i\ne k})=1) for every deleted (k).

Reduce each (a_i) modulo (M=Np), obtaining (v_i). Reduction preserves the gcd with (M), so the PrimeForcing premises hold.

Choose the forced residue (r). Then

[
\rho_M(ra_i)=\rho_M(rv_i)\ge p.
]

At time (t=r/M),

[
|ta_i|
======

\frac{\rho_M(ra_i)}M
\ge
\frac p{Np}
===========

\frac1N.
]

Thus a tuple with no full witness cannot satisfy (p\nmid a_i) for every (i). Therefore

[
p\mid\prod_i a_i.
]

The additional lower-dimensional argument needed to establish every deletion gcd for a primitive counterexample is external to this local lemma.

---

## 4. Clean-room finite audit

### Implementation record

The audit was implemented independently in Python 3.13.5 using only the standard library.

Deterministic order:

* indices zero-based;
* pivots and deleted indices ascending;
* residues ascending;
* residue tuples lexicographic;
* primes in the stated ascending lists;
* no randomness or heuristic pruning.

Exact computational domain:

* every (r\in R_j) for every pivot of ((1,2,3,60)), ((1,3,4,5,18)), and ((1,3,4,7));
* every deletion, every available pivot, and every numerator for all deletion certificates of those tuples;
* every residue (r\pmod{20}) for (v=(1,3,4));
* every premise-satisfying residue tuple for (n=3) and (p=2,3,5,7,11,13), with repeated residues allowed;
* exact rational continuous maximization at all constraint endpoints and objective antipodes for the named continuous tests;
* all strict and closed shell endpoints directly.

Runtime:

* internal deterministic audit: (3.073587) seconds;
* measured wall time: (4.47) seconds;
* maximum RSS: (116472) KB.

Hashes:

```text
source_sha256
4de31ba9a75788312dc37f36187db2820668ad5d3c2e4cc9720a3e1f9ac4067b

stdout_file_sha256
d950ff20dbbcf3aeb61d236657fb3b81ec07fc5c3ba2f06416ebf0270618f809

deterministic_payload_sha256
de67407d215f9b55b7db86d80baf1d8dfc1f3eefa893a7068d86df0e9dddcb27

literal_tables_sha256
d28b4f5477b98c9305399866fcc9d1a281b1b3c86b8a278252760740069dd69b
```

The literal table file contains 433 lines. For every DPLP pivot and residue it records the full (\rho)-vector, all (D)-indices, all (H)-indices, (\delta), (s), and (G)-membership.

### D2 uniform-positivity rejection: ((1,2,3,60))

Here

[
n=4,\qquad N=5.
]

Explicit structural arithmetic:

```text
positive        true
injective       true
primitive       gcd(1,2,3,60)=1
N-divisible     speed 60
deletion gcds   (1,1,1,1)
certificate counts by deleted index   (48,30,48,6)
lift counts by deleted index          (18,0,6,0)
```

Pivot counts:

| Pivot speed | (|R_j|) | (|G_j|) | (D1_j) | (D2_j) | (D3_j) | (H2_j) | D2 bound | D3 bound |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| 1 | 3 | 0 | 4 | 1 | 0 | 0 | (-1) | 0 |
| 2 | 6 | 0 | 6 | 0 | 0 | 0 | 0 | 0 |
| 3 | 9 | 0 | 18 | 11 | 2 | 0 | (-9) | 0 |
| 60 | 180 | 24 | 216 | 84 | 24 | 0 | (-36) | 24 |

Thus every D2 lower bound is nonpositive.

For pivot (60),

```text
G_60 =
(49,50,51,53,54,55,57,58,59,61,62,63,
 177,178,179,181,182,183,185,186,187,189,190,191)
```

An exact lift is obtained by deleting speed (1), using pivot (60) and (r=49):

[
t=\frac{49}{240}.
]

The residue-distance vector modulo (240) is

[
(49,98,93,60).
]

Hence

[
5(49,98,93,60)=(245,490,465,300)\ge(240,240,240,240).
]

This rejects the proposed uniform D2 strict-positivity selector. It is not a counterexample to DPLP or LRC.

### D3 uniform-positivity rejection: ((1,3,4,5,18))

Here

[
n=5,\qquad N=6.
]

Explicit structural arithmetic:

```text
positive        true
injective       true
primitive       gcd(1,3,4,5,18)=1
N-divisible     speed 18
deletion gcds   (1,1,1,1,1)
certificate counts by deleted index   (26,18,22,22,4)
lift counts by deleted index          (0,0,2,2,0)
```

Pivot counts:

| Pivot speed | (|R_j|) | (|G_j|) | (D1_j) | (D2_j) | (D3_j) | (H2_j) | D2 bound | D3 bound |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| 1 | 4 | 0 | 4 | 0 | 0 | 0 | 0 | 0 |
| 3 | 12 | 0 | 12 | 0 | 0 | 0 | 0 | 0 |
| 4 | 16 | 0 | 20 | 6 | 2 | 0 | (-4) | 0 |
| 5 | 20 | 0 | 32 | 16 | 4 | 0 | (-12) | 0 |
| 18 | 72 | 4 | 92 | 38 | 18 | 0 | (-20) | 0 |

All D3 bounds are at most zero, but

[
G_{18}={39,41,49,51}.
]

The closed lower shell boundary is used exactly. With pivot (18), (r=39), and deleted speed (5),

[
t=\frac{39}{90}=\frac{13}{30},
]

and the residue-distance vector is

[
(39,27,24,15,18).
]

For the deleted speed (5),

[
6\cdot15=90=5\cdot18.
]

Thus equality lies in (H), not (D), and the certificate lifts on the closed boundary.

The second boundary lift occurs at (r=51). The strict-shell lifts deleting speed (4) occur at (r=41,49).

This rejects uniform strict positivity of the D3 expression, not DPLP.

### Raw deletion lifting: ((1,3,4,7))

Here

```text
n=4, N=5
positive        true
injective       true
primitive       true
N-divisible     none
deletion gcds   (1,1,1,1)
certificate counts   (8,8,11,4)
lift counts          (0,0,0,0)
```

Every deletion has a certificate, but no deletion certificate lifts.

At the direct time

[
t=\frac15,
]

the distance numerators modulo (5) are

[
(1,2,1,2),
]

so every coordinate is at least (1/5).

This tuple is not an LRC counterexample. It demonstrates that an arbitrary continuous full witness need not come from a canonical deletion certificate. Indeed, (t=1/5) belongs to none of the (K_k), and no denominator (na_j=4a_j) represents (1/5) for these speeds.

### Prime-forcing rejection: (v=(1,3,4)\pmod{20})

Here

[
n=3,\quad N=4,\quad p=5,\quad M=20.
]

Premises:

[
5\nmid1,3,4,
]

and

[
\gcd(20,3,4)
============

# \gcd(20,1,4)

# \gcd(20,1,3)

1.

]

Exact bad-set information:

```text
gcd fibers d_i          (1,1,4)
bad-set sizes           (9,9,12)
Z0                      0
Z1                      13
P1 right side           2*5 - 3*2 = 4
```

Literal residue table:

```text
r  rho-vector   bad indices   mu
0  (0,0,0)      (0,1,2)       3
1  (1,3,4)      (0,1,2)       3
2  (2,6,8)      (0)           1
3  (3,9,8)      (0)           1
4  (4,8,4)      (0,2)         2
5  (5,5,0)      (2)           1
6  (6,2,4)      (1,2)         2
7  (7,1,8)      (1)           1
8  (8,4,8)      (1)           1
9  (9,7,4)      (2)           1
10 (10,10,0)    (2)           1
11 (9,7,4)      (2)           1
12 (8,4,8)      (1)           1
13 (7,1,8)      (1)           1
14 (6,2,4)      (1,2)         2
15 (5,5,0)      (2)           1
16 (4,8,4)      (0,2)         2
17 (3,9,8)      (0)           1
18 (2,6,8)      (0)           1
19 (1,3,4)      (0,1,2)       3
```

There is no empty residue. P1 nevertheless holds strongly:

[
2Z_0+Z_1=13\ge4.
]

Thus P1 does not imply PrimeForcing, even with all deletion gcd premises.

In the declared deterministic (n=3) search with primes (2,3,5), this was the first failure:

```text
p=5
v=(1,3,4)
348 premise-satisfying tuples visited cumulatively
```

No global minimality over every dimension and every prime is claimed.

### P2 checks

The deletion-gcd premises do not force (2s<N). The smallest example in increasing (n), then increasing prime (p), is

[
n=2,\quad N=3,\quad p=3,\quad M=9,\quad v=(1,2).
]

Each deletion leaves a unit modulo (9), but the two residues represent different sign classes:

[
s=2,\qquad 2s=4>N.
]

The strengthened nonstrict endpoint is realized at

[
n=7,\quad N=8,\quad p=3,\quad
v=(1,1,1,1,1,1,2)\pmod{24}.
]

Here (s=2) and

[
s(2p+N-2)=2(6+6)=24=M.
]

Nevertheless there are 16 safe residues:

```text
(3,4,5,6,7,8,9,10,14,15,16,17,18,19,20,21)
```

### Exact (n=3) prime supply

Full repeated-residue enumeration verified:

| Prime (p) | Premise-satisfying tuples | PrimeForcing failure |
| --------: | ------------------------: | -------------------- |
|         2 |                        64 | none                 |
|         3 |                       256 | none                 |
|         7 |                      6912 | none                 |
|        11 |                     32000 | none                 |
|        13 |                     55296 | none                 |

Thus

[
P_3={2,3,7,11,13}
]

is a computed supply, with

[
\prod_{p\in P_3}p
=================

6006.

]

For (n=3),

[
\left(
\frac{\binom42^2}{3}
\right)^3
=========

# \left(\frac{36}{3}\right)^3

1728.

]

Therefore

[
6006>1728.
]

This is `computed finite evidence` for (n=3), not a general uniform theorem.

---

## 5. Continuous maximizers, canonical compatibility, and active cycles

The exact maximization code used the following finite reduction. The boundaries of (K_k) occur at

[
t=\frac{nm\pm1}{na_i}
\qquad(i\ne k),
]

and the only interior breakpoints at which the objective (f_k) can attain a local maximum are its antipodes

[
t=\frac{2m+1}{2a_k}.
]

On every remaining interval, (f_k) is affine. Therefore checking all feasible constraint endpoints and objective antipodes gives the exact maximum.

### Named tuples

| Speeds                              | (N)-divisible indices | Exact ((\eta_k))                                 | Audit finding                                                                                                    |
| ----------------------------------- | --------------------- | ------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------- |
| ((1,3,4,7))                         | none                  | ((3/16,5/28,1/7,1/12))                           | All (<1/5), yet (t=1/5) is an unrelated full witness.                                                            |
| ((1,2,3,60))                        | speed (60)            | ((59/240,19/120,19/80,0))                        | Target conclusion holds since some (\eta_k>1/5).                                                                 |
| ((1,3,4,5,18))                      | speed (18)            | ((7/45,1/10,8/45,1/6,1/10))                      | One (\eta_k>1/6), one equals (1/6).                                                                              |
| ((1,2,4))                           | speed (4)             | ((1/3,1/3,1/3))                                  | Cycle (1\leftrightarrow2) avoids speed (4).                                                                      |
| ((1,2,6,8,10))                      | speed (6)             | ((7/25,9/20,7/20,6/25,1/4))                      | Cycle (8\leftrightarrow10) avoids speed (6).                                                                     |
| ((15,21,40,48,56,105,126,280,1200)) | speeds (40,280,1200)  | ((359/720,13/27,67/135,1/2,1/2,1/2,1/2,1/2,1/2)) | Antipodal maxima occur; several maximizers have no active constraint. D5’s sub-antipode hypothesis is essential. |

For the cycle avoiding the divisible speed in ((1,2,6,8,10)), the selected edge times can be

[
t_8=\frac{11}{50},
\qquad
t_{10}=\frac9{40}.
]

They are different maximizing times. No equation identifying them is valid.

The smaller tuple ((1,2,4)) is the first possible cycle-avoidance witness in increasing ((n,\text{height},\text{lex})) order:

* (n=2) cannot have a cycle after deleting the divisible coordinate, because only one vertex remains and self-loops are forbidden.
* For (n=3), (N=4), height below (4) has no (N)-divisible positive speed.
* At height (4), ((1,2,4)) is lexicographically first and has the cycle (0\leftrightarrow1).

This rejects any proof step that assumes global (N)-divisibility alone forces an active cycle through the divisible coordinate. It does not refute the full target under the additional assumption (\eta_k<1/N) for all (k).

### Consecutive family

For speeds ((1,\ldots,m)), the exact values through (m=8) were:

```text
m=2: (1/4,0)
m=3: (2/9,1/9,0)
m=4: (3/16,1/6,1/8,0)
m=5: (4/25,3/25,1/10,1/15,0)
m=6: (5/36,2/15,1/8,1/9,1/12,0)
m=7: (6/49,5/49,4/35,3/35,2/21,1/35,0)
m=8: (7/64,3/28,5/56,1/10,3/32,1/20,1/16,0)
```

All are strictly below (1/(m+1)). None contains a speed divisible by (m+1).

### Exact endpoint reached by the active route

Under the contrary assumption

[
\eta_k<1/N
\quad\text{for every }k,
]

every selected maximizer has an active coordinate. For an active edge (k\to j), the canonical bridge gives a residue

[
r_k\equiv\pm1\pmod n
]

at modulus

[
M_j=na_j
]

such that

[
\rho_{M_j}(r_ka_i)\ge a_j
\qquad(i\ne j,k)
]

and

[
N\rho_{M_j}(r_ka_k)<na_j.
]

Thus the active cycle becomes a cycle of canonical deletion certificates, each with a deep-bad exceptional coordinate.

This is a genuine discrete-continuous bridge. It does not produce an empty or shell-singleton residue. It produces the opposite type: a deep nonlift.

### First unsupported DPLP implication

The exact first unsupported implication is:

> Convert a cycle of canonical deep nonlifting deletion certificates, at distinct moduli and generally distinct maximizing times, into one shell or empty lift by using the existence of a globally (N)-divisible speed.

No accepted relation combines the different numerators (r_k) or times (t_k).

When the active cycle avoids the divisible coordinate (q), the divisibility (N\mid a_q) appears only inside one of the ordinary safe-coordinate inequalities for each edge. It supplies no equation linking two cycle edges. Any proof that uses (N)-divisibility solely by assuming (q) lies on the cycle is invalid.

Status of this implication: `open`.

---

## 6. Primary-source product audit

Malikiosis, Santos, and Schymura’s published Theorem A uses the following convention. Their (n) is the number of moving positive speeds in the target instance, so the target has (n+1) total runners after adjoining speed (0). Assuming LRC for (n) total runners, they prove the target instance whenever the moving speeds are primitive and

[
\sum_{S\subseteq[n]}v_S

>

\binom{n+1}{2}^{n-1},
\qquad
v_S=\gcd(v_i:i\in S).
]

The paper explicitly sets (v_\varnothing=0). There is no floor or ceiling in Theorem A. ([Cambridge University Press][1])

Rosenfeld’s Corollary 3 derives the product sufficient condition

[
\prod_{i=1}^n v_i
\ge
\left[
\frac{\binom{n+1}{2}^{n-1}}{n}
\right]^n.
]

The square brackets are grouping delimiters, not a floor operation. The proof immediately applies AM-GM to the real quantity ((\prod_i v_i)^{1/n}). Rosenfeld’s prime-divisor lemma also uses the exact repeated-residue, deletion-gcd formulation corresponding to `PrimeForcing`. ([arXiv][2])

Let

[
C_n=\binom{n+1}{2},
\qquad
P=\prod_{i=1}^n v_i.
]

For (n\ge2),

[
\sum_{S\subseteq[n]}v_S

>

\sum_{i=1}^n v_i
\ge
nP^{1/n}.
]

Therefore

[
P\ge
\left(\frac{C_n^{n-1}}n\right)^n
]

implies the strict hypothesis of Theorem A.

The exact contrapositive is that a primitive counterexample must satisfy

[
P<
\left(\frac{C_n^{n-1}}n\right)^n
================================

\frac{C_n^{n(n-1)}}{n^n}.
]

The outer exponent applies to the entire quotient.

For an integer prime product (Q), the exact sufficient comparison is

[
Q\ge
\left\lceil
\frac{C_n^{n(n-1)}}{n^n}
\right\rceil.
]

Equivalently, without rational powers, floors, or ceilings,

[
\boxed{
n^nQ\ge C_n^{n(n-1)}
}.
]

Equality is sufficient because a counterexample has strict product inequality (P<T_n). A requirement that the prime product strictly exceed the real threshold is stronger than necessary.

### External dependencies not replayed in Lean

The following remain external relative to this audit:

1. the reduction from arbitrary real relative speeds to positive distinct primitive integer speeds;
2. the lower-dimensional LRC induction hypothesis;
3. Malikiosis-Santos-Schymura Theorem A and its equivalence to the project’s runner formulation;
4. the deletion-gcd reduction for primitive minimal counterexamples;
5. the full prime-forcing-to-prime-divisor induction lemma;
6. the finite PrimeForcing certificates for each selected prime;
7. the finite-set product divisibility step for distinct primes;
8. the final equivalence chain from the bounded product contradiction to the project’s main theorem.

The AM-GM product arithmetic and the local residue-to-witness implication were independently proved above, but no corresponding Lean declarations were replayed.

---

## 7. Proof-obligation ledger and route decisions

| Route                    | Last accepted endpoint                                                                          | First unsupported implication                                                                                                | Decision                                                                                                                                                                 |
| ------------------------ | ----------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Low-order DPLP counting  | D1, D2, D3 pointwise bounds                                                                     | Prove that the exact structural DPLP hypotheses force a positive D2 or D3 lower bound for some pivot                         | **STOP** as a universal selector route. Retain the identities as local estimates.                                                                                        |
| Active-maximizer cycle   | Every sub-antipodal active edge is a canonical deep nonlift; every active selection has a cycle | Combine distinct-time, distinct-modulus deep nonlifts with global (N)-divisibility to produce one shell/empty lift           | **STOP** as the primary proof route. Retain and formalize the canonical bridge. Resume only after an explicit cross-edge invariant is found.                             |
| P1 singleton elimination | (2Z_0+Z_1\ge2p-(N-1)(N-2))                                                                      | Eliminate all singleton-only covers using deletion gcds                                                                      | **STOP** in its current general form. The implication is directly false at ((1,3,4)\pmod{20}).                                                                           |
| P2 sign classes          | Safe residue whenever (s(2p+N-2)\le Np)                                                         | Derive a sufficiently small (s) for enough primes from structural counterexample hypotheses                                  | **CONTINUE** only as a special-case sieve or computational reduction. Deletion gcds alone give no useful (s)-bound.                                                      |
| Uniform prime supply     | Exact conditional divisor and product chain; complete (n=3) supply                              | Establish `PrimeForcing(n,p)` for enough primes in every required dimension and formalize the external product theorem chain | **CONTINUE**. This is the only audited route here with a complete conditional implication once the finite prime supply and external induction dependencies are supplied. |

The exact under-specified DPLP obligation preceding all counting claims is the missing mathematical definition of the “height branch.”

---

## 8. Single recommended next Lean declaration

The one declaration that materially shortens a surviving chain is the active-to-canonical bridge:

```lean
theorem active_eq_to_canonical_deletion_cert
    {n : Nat} (hn : 2 ≤ n)
    (a : Fin n → Nat) (hpos : ∀ i, 0 < a i)
    {k j : Fin n} (hjk : j ≠ k)
    {t : Circle}
    (htK : t ∈ deletionSafeSet a k)
    (hactive : circleNorm (t * a j) = (n : Real)⁻¹) :
    ∃ r : Nat,
      r < n * a j ∧
      (r % n = 1 ∨ r % n = n - 1) ∧
      t = canonicalTime n (a j) r ∧
      (∀ i, i ≠ j → i ≠ k →
        a j ≤ cyclicResidueDistance (n * a j) (r * a i)) ∧
      (NoFullWitness a →
        (n + 1) *
          cyclicResidueDistance (n * a j) (r * a k) <
        n * a j)
```

The exact project names and circle representation would need adaptation, but the mathematical declaration should include the numerator congruence, canonical-time equality, all deletion-safe coordinates, and the deep exceptional inequality.

## Audit artifacts

[Clean-room Python source](sandbox:/mnt/data/prompt60_cleanroom_audit.py)

[Complete deterministic output](sandbox:/mnt/data/prompt60_cleanroom_audit.out)

[Full 433-line literal residue tables](sandbox:/mnt/data/prompt60_literal_tables.txt)

[Runtime and resource record](sandbox:/mnt/data/prompt60_timing.txt)

[1]: https://www.cambridge.org/core/services/aop-cambridge-core/content/view/A51A991DE89B8C9C2E2FF13FBD4501DA/S2050509425101072a.pdf/linearly_exponential_checking_is_enough_for_the_lonely_runner_conjecture_and_some_of_its_variants.pdf "https://www.cambridge.org/core/services/aop-cambridge-core/content/view/A51A991DE89B8C9C2E2FF13FBD4501DA/S2050509425101072a.pdf/linearly_exponential_checking_is_enough_for_the_lonely_runner_conjecture_and_some_of_its_variants.pdf"
[2]: https://arxiv.org/html/2509.14111v2 "https://arxiv.org/html/2509.14111v2"
