## 1. Disposition

**PIVOT**

## 2. Status table

The new claims below are not promoted into the repository by this memo. Claims marked `conditional` have complete derivations supplied here but remain pending independent audit and `/root` approval.

| Claim or dependency                                                                                                          | Status                     | Exact basis                                                                         |
| ---------------------------------------------------------------------------------------------------------------------------- | -------------------------- | ----------------------------------------------------------------------------------- |
| `exists_witness_iff_exists_pivot_certificate`                                                                                | `proved-lean`              | Existing repository theorem, as stipulated.                                         |
| `positiveIntegerConjecture_iff_pivotCertificateConjecture`                                                                   | `proved-lean`              | Existing repository theorem, as stipulated.                                         |
| `conjecture_iff_positiveIntegerConjecture`                                                                                   | `proved-lean`              | Existing repository theorem, as stipulated.                                         |
| Normalized candidate filter, strict Dirichlet kernel, multiplication pullback, and actual-bad-set convolution from `PART-12` | `proved-math`              | Existing audited document boundary.                                                 |
| `FullCover_j(a) ↔ G_j(a)=0 ↔ ⋃_{i≠j}B_i^j=R_j`                                                                               | `conditional`              | Direct finite-set proof in §3.                                                      |
| Coarse-grid divisor-cover lemma at residues (r=k p_j)                                                                        | `conditional`              | Direct cyclic-distance identity in §4.                                              |
| Singleton-cover rigidity: (B_i^j=R_j) iff (N p_j\mid a_i), for (n\ge2)                                                       | `conditional`              | Complete cyclic-group proof in §5.                                                  |
| Under simultaneous full covers, at least one pivot has no singleton subcover                                                 | `conditional`              | Strict-growth functional-digraph consequence of singleton rigidity.                 |
| “At least (n-1) full pivots force a common prime”                                                                            | `rejected`                 | Explicit infinite primitive family in §7.                                           |
| “A private point forces a prime shared by its owner and pivot”                                                               | `rejected`                 | Exact partition at pivot (2) of ((1,2,3,5)), with every owner coprime to the pivot. |
| “A full pivot requires a nonunit owner modulo its pivot modulus”                                                             | `rejected`                 | Pivot (7) of ((1,3,4,5,7,18)), where all five owners are units modulo (49).         |
| Ten mandatory fixtures                                                                                                       | `computed finite evidence` | Replayed by the artifact in §9.                                                     |
| Primitive scan for (n=3,4,5,6), largest speed at most (12)                                                                   | `computed finite evidence` | No all-pivot full-cover tuple found.                                                |
| `SIMULTANEOUS-FULL-COVER-COMMON-PRIME`                                                                                       | `open`                     | Neither attack supplies the required persistent prime.                              |
| Unrestricted positive-integer and real Lonely Runner conclusions                                                             | `conditional`              | Follow from the open common-prime lemma by the complete wrapper in §8.              |

## 3. Exact target

Let (n\ge1), set (N=n+1), and let
[
a:\operatorname{Fin} n\to\mathbb N
]
be positive and injective. For pivot (j), write
[
p_j=a_j,\qquad M_j=Np_j.
]
For (x\in\mathbb Z), define
[
\rho_M(x)=\min(x\bmod M,;M-(x\bmod M)).
]

The candidate set is
[
R_j={r\in{0,\ldots,M_j-1}:N\nmid r}.
]
It has cardinality
[
|R_j|=M_j-p_j=(N-1)p_j=np_j.
]

For (i\ne j),
[
B_i^j={r\in R_j:\rho_{M_j}(r a_i)<p_j}.
]
The boundary is strict:

* (\rho=p_j-1) is bad.
* (\rho=p_j) is safe.
* Both cyclic representatives are included through (\rho).
* Multiplicity is owner-indexed even when two sets coincide.

Define
[
\mu_j(r)=#{i\ne j:r\in B_i^j}
]
and
[
G_j(a)=#{r\in R_j:\mu_j(r)=0}.
]

Because (R_j) is finite,
[
\begin{aligned}
G_j(a)=0
&\iff {r\in R_j:\mu_j(r)=0}=\varnothing\
&\iff \forall r\in R_j,\ \mu_j(r)>0\
&\iff \forall r\in R_j,\ \exists i\ne j,\ r\in B_i^j\
&\iff \bigcup_{i\ne j}B_i^j=R_j.
\end{aligned}
]
Thus the frozen equivalence is valid:
[
\operatorname{FullCover}*j(a)
\iff G_j(a)=0
\iff \bigcup*{i\ne j}B_i^j=R_j.
]

The sole target is
[
\forall n\ge1;\forall a,\quad
\left(\forall j,\operatorname{FullCover}_j(a)\right)
\Longrightarrow
\exists q,\ \operatorname{Prime}(q)\land\forall i,\ q\mid a_i.
]

For (n=1), there are no owners and (G_j(a)=a_j>0), so the antecedent is always false. The substantive range is (n\ge2), hence (N\ge3).

## 4. Regression and non-tautology audit

### Mandatory fixtures

| Fixture                |                  Recomputed result | Boundary or structural point                                                                                                              |     |                                                           |
| ---------------------- | ---------------------------------: | ----------------------------------------------------------------------------------------------------------------------------------------- | --- | --------------------------------------------------------- |
| ((1)), (N=2)           |                            (G=(1)) | The sole candidate is uncovered.                                                                                                          |     |                                                           |
| ((1,3)), (N=3)         |                          (G=(0,2)) | One complete pivot does not force a common divisor.                                                                                       |     |                                                           |
| ((1,2,3)), (N=4)       |                        (G=(2,2,2)) | At pivot (3), (r=3) is good and (\rho_{12}(3\cdot1)=3), exactly the safe boundary.                                                        |     |                                                           |
| ((4,5,9)), (N=4)       |                        (G=(2,2,4)) | At every pivot the total bad-set mass equals (                                                                                            | R_j | ), but overlaps leave gaps. First moments do not suffice. |
| ((1,2,3,5)), (N=5)     |                      (G=(0,0,2,2)) | Two complete pivots do not force a common divisor.                                                                                        |     |                                                           |
| ((1,2,3,4,5,7)), (N=7) |                  (G=(0,0,0,0,2,2)) | Four of six pivots are complete while the tuple is primitive.                                                                             |     |                                                           |
| ((1,3,5)), (N=4)       |                        (G=(3,3,5)) | Each half-time antipode is a single reflection-fixed good point.                                                                          |     |                                                           |
| ((1,3,13)), pivot (3)  |                            (G_3=5) | Speeds (1) and (13) coincide modulo (12), with identical bad sets ({1,2,10,11}), but remain two owners.                                   |     |                                                           |
| Scaling by (2)         | (G(2a)=2G(a)) for the tested pairs | Membership and candidate status are preserved under reduction; the time direction is (t\mapsto t/2) from base to scaled tuple.            |     |                                                           |
| Boundary suite         |                  All checks passed | (r=0) and (N\mid r) excluded; (\rho=p-1) bad; (\rho=p) safe; both cyclic sides handled; (N=2) antipode safe; permutations relabel counts. |     |                                                           |

For the six-speed obstruction,
[
G=(0,0,0,0,2,2),
]
with
[
\operatorname{Good}*{p=5}={6,29}\pmod{35},
\qquad
\operatorname{Good}*{p=7}={8,41}\pmod{49}.
]
It therefore defeats any argument that uses only a majority or (n-2) complete pivots.

### First genuinely new implication: coarse divisor covers

Fix a pivot (j), put (p=p_j), and take (1\le k\le N-1). Set
[
r=kp.
]
Then (0<r<M=Np), and
[
r\in R_j\iff N\nmid kp.
]

For any owner (i\ne j),
[
\rho_{Np}(r a_i)
=\rho_{Np}(p k a_i)
=p,\rho_N(k a_i).
]
Consequently,
[
r\in B_i^j
\iff p,\rho_N(k a_i)<p
\iff \rho_N(k a_i)=0
\iff N\mid k a_i.
]

Therefore:
[
\boxed{
\operatorname{FullCover}_j(a)
\Longrightarrow
\forall k\in{1,\ldots,N-1},
N\nmid k a_j
\Longrightarrow
\exists i\ne j,\ N\mid k a_i.
}
]

At (k=1), any full pivot whose speed is not divisible by (N) forces another speed divisible by (N). Hence simultaneous full covers imply:

1. either every speed is divisible by (N), in which case any prime divisor of (N) proves the target immediately; or
2. the tuple has a mixed divisibility pattern, with at least one (N)-divisible speed and at least one speed not divisible by (N).

This is non-tautological arithmetic information, but one (N)-divisible coordinate blocks every coarse candidate (kp_j) at all other pivots. The coarse grid therefore cannot propagate divisibility into the remaining coordinates.

## 5. Attack A: canonical minimal covers and prime propagation

### 5.1 Canonical covers and private candidates

For pivot (j), let
[
O_j={i:i\ne j}.
]
Under `FullCover_j`, the family
[
\mathcal F_j=
\left{C\subseteq O_j:
\bigcup_{i\in C}B_i^j=R_j\right}
]
is nonempty.

Delete redundant owners until an inclusion-minimal cover is obtained. Among all inclusion-minimal covers, choose the one minimizing
[
\bigl(|C|,\text{ increasing index list of }C\bigr)
]
lexicographically. This gives a canonical (C_j), including when several minimal covers exist.

For each (i\in C_j), minimality gives a private candidate
[
r_i\in B_i^j\setminus\bigcup_{\ell\in C_j\setminus{i}}B_\ell^j.
]
Equivalently, for some integer (z_i),
[
|r_i a_i-z_iM_j|<p_j,
]
while for every (\ell\in C_j\setminus{i}) and every integer (z),
[
|r_i a_\ell-zM_j|\ge p_j.
]
Equality is correctly classified as safe.

This privacy is only relative to (C_j). An owner omitted from (C_j) can still cover (r_i).

For example, at pivot (1) of ((1,4,8)), (N=4), (M=4), and
[
B_4=B_8=R={1,2,3}.
]
The canonical minimum-cardinality cover selects one owner, but every one of its “private” candidates has original multiplicity (2).

### 5.2 Singleton-cover rigidity

The following exact local theorem supplies a genuine divisibility edge.

**Singleton-cover rigidity.** Let (N\ge3), (p\ge1), (M=Np), and (A\in\mathbb N). Then
[
{r:N\nmid r,\ \rho_M(Ar)<p}
===========================

{r:N\nmid r}
]
if and only if
[
M\mid A.
]

The reverse implication is immediate. Assume the cover holds. Let
[
d=\gcd(A,M),\qquad m=M/d,
]
and consider multiplication
[
\phi:\mathbb Z/M\mathbb Z\to\mathbb Z/M\mathbb Z,\qquad
x\mapsto Ax.
]
Its image has order (m), and its kernel (K) has order (d) and is generated by the residue (m).

Suppose (m>1). The image contains a safe point. Indeed,
[
y=d\left\lfloor\frac m2\right\rfloor
]
belongs to the image and
[
\rho_M(y)
=d\left\lfloor\frac m2\right\rfloor
\ge \frac{dm}{N}
=\frac MN
=p.
]
For (m=2), the ratio is (1/2); for (m\ge3),
(\lfloor m/2\rfloor/m\ge1/3), and (N\ge3).

Every point in the fiber (\phi^{-1}(y)) is safe. Since all nonmultiples of (N) are assumed bad, the entire fiber must lie in the excluded subgroup
[
H=N\mathbb Z/M\mathbb Z,\qquad |H|=p.
]
A fiber is a coset of (K), so this forces (K\subseteq H), hence
[
N\mid m.
]
Write
[
m=Nu.
]
Since (M=dm=Np), this gives
[
p=du.
]

An image point (dk) is bad exactly when
[
d\rho_m(k)<du
\iff \rho_m(k)<u.
]
Because (m=Nu) and (N\ge3), exactly (2u-1) image points are bad. The number of safe preimages is therefore
[
d\bigl(m-(2u-1)\bigr)
=d\bigl((N-2)u+1\bigr)
=(N-2)p+d.
]
This is strictly greater than (p=|H|), contradicting the fact that every safe preimage lies in (H).

Thus (m=1), so (d=M) and (M\mid A).

Applied to the original sets:
[
\boxed{
B_i^j=R_j
\iff N a_j\mid a_i
\qquad(n\ge2).
}
]

### 5.3 Cross-pivot strict-growth theorem

Suppose every pivot has a singleton subcover. Choose its unique covering owner (f(j)). Singleton rigidity gives
[
N a_j\mid a_{f(j)},
]
so
[
a_{f(j)}\ge N a_j>a_j.
]

The map (f:\operatorname{Fin}n\to\operatorname{Fin}n) is a functional digraph on a finite set. Iterating (f) must eventually produce a directed cycle, but the speeds strictly increase on every edge. A strict increase around a cycle is impossible.

Therefore:
[
\boxed{
\left(\forall j,\operatorname{FullCover}_j(a)\right)
\Longrightarrow
\exists j\text{ such that no single owner covers }R_j.
}
]

Equivalently, at least one canonical minimal cover satisfies
[
|C_j|\ge2.
]

This is genuinely cross-pivot, height-independent, and prime-independent. It also proves the target vacuously for (n=2), because each pivot then has only one possible owner.

### 5.4 First fatal prime-propagation arrow

Singleton edges provide exact divisibility:
[
N a_j\mid a_i.
]
Multiowner private points do not.

At pivot speed (2) of ((1,2,3,5)), (N=5), (M=10), and
[
R={1,2,3,4,6,7,8,9}.
]
The three owner sets are
[
B_1={1,9},\qquad
B_3={3,7},\qquad
B_5={2,4,6,8}.
]
They form an exact partition of (R). Every point has multiplicity one, every owner has global private points, and yet
[
\gcd(1,2)=\gcd(3,2)=\gcd(5,2)=1.
]

Thus even the strongest possible private-point multiplicity statement does not produce a prime shared by the owner and pivot. The unsupported arrow is:
[
\text{private strict congruence interval}
;\not\Longrightarrow;
\text{nontrivial owner-pivot gcd}.
]

No argument was found that turns a multiowner minimal cover into a persistent prime, and the singleton prime factors need not agree across different pivot moduli.

## 6. Attack B: exact Fourier annihilation and gcd support

Fix pivot (j), abbreviating
[
p=p_j,\qquad M=M_j=Np.
]

Define
[
c_j(r)=\mathbf 1_{N\nmid r},
]
the strict raw arc
[
A_p(x)=\mathbf 1_{\rho_M(x)<p},
]
and
[
g_{ij}(r)=A_p(a_i r),\qquad
\beta_{ij}(r)=c_j(r)g_{ij}(r).
]
Finally,
[
h_j(r)=c_j(r)\prod_{i\ne j}(1-g_{ij}(r)).
]

Because all factors are (0)-(1) valued,
[
h_j(r)=1
\iff r\in R_j\text{ and }\mu_j(r)=0.
]
Therefore
[
G_j(a)=\sum_{r\bmod M}h_j(r)
]
and
[
\boxed{
\operatorname{FullCover}_j(a)
\iff h_j\equiv0.
}
]

### 6.1 Fourier convention and candidate filter

Use the normalized transform
[
\widehat f(k)=\frac1M\sum_{r\bmod M}
f(r)e^{-2\pi i kr/M},
]
with inversion
[
f(r)=\sum_{k\bmod M}\widehat f(k)e^{2\pi i kr/M}.
]

The excluded residues form the subgroup
[
{0,N,2N,\ldots,(p-1)N}.
]
Hence
[
\widehat c_j(k)
===============

\mathbf 1_{k=0}
-\frac1N\mathbf 1_{p\mid k}.
]
In particular,
[
\widehat c_j(0)=1-\frac1N=\frac nN.
]
This remains valid for (N=2).

### 6.2 Strict arc and multiplication pullback

The strict arc consists of
[
-(p-1),\ldots,-1,0,1,\ldots,p-1,
]
so
[
\widehat A_p(k)
===============

\frac1M
\sum_{x=-(p-1)}^{p-1}e^{-2\pi i kx/M}.
]
This is the strict Dirichlet kernel divided by (M). At (N=2), the antipode (p=M/2) is excluded because equality is safe.

For an owner speed (A=a_i), let
[
d=\gcd(A,M),\qquad m=M/d.
]
If (m=1), then (M\mid A), (g_{ij}\equiv1), and
[
\widehat g_{ij}=\delta_0.
]

Assume (m>1). Put
[
A'=A/d,\qquad
\nu=(A')^{-1}\pmod m,\qquad
L=\left\lfloor\frac{p-1}{d}\right\rfloor.
]
Then
[
\widehat g_{ij}(k)=0
\quad\text{unless }d\mid k,
]
and, writing (k=d\kappa),
[
\widehat g_{ij}(d\kappa)
========================

\frac1m
\sum_{x=-L}^{L}
e^{-2\pi i\kappa\nu x/m}.
]
The inequality (L<m/2) follows from
[
L<\frac pd=\frac mN\le\frac m2,
]
so no antipodal double counting occurs. The case (m=1) is already separated.

Pointwise multiplication becomes convolution:
[
\widehat{\beta}*{ij}
=\widehat c_j*\widehat g*{ij},
]
and
[
\boxed{
\widehat h_j
============

\widehat c_j*
\mathop{*}*{i\ne j}
(\delta_0-\widehat g*{ij}).
}
]

Thus
[
\operatorname{FullCover}_j(a)
\iff
\widehat h_j(k)=0
\quad\text{for every }k\bmod M_j.
]

The zero coefficient is
[
\widehat h_j(0)=\frac{G_j(a)}{M_j},
]
so using only that coefficient is exactly the forbidden good-count restatement.

### 6.3 Full cover without any nonunit owner

A pivot-local gcd-support claim is false. Consider
[
a=(1,3,4,5,7,18),\qquad n=6,\quad N=7,
]
at pivot (p=7), so (M=49).

Every owner is a unit modulo (49):
[
\gcd(1,49)=\gcd(3,49)=\gcd(4,49)
=\gcd(5,49)=\gcd(18,49)=1.
]

Writing each symmetric bad set by representatives in ({1,\ldots,24}),
[
\begin{aligned}
B_1&=\pm{1,2,3,4,5,6},\
B_3&=\pm{1,2,15,16,17,18},\
B_4&=\pm{1,11,12,13,23,24},\
B_5&=\pm{1,9,10,11,19,20},\
B_{18}&=\pm{3,8,11,16,19,22}.
\end{aligned}
]
Their union contains every nonmultiple of (7) modulo (49). Therefore the pivot is fully covered despite every multiplication pullback having (d=1).

So spectral annihilation can occur entirely through coefficient cancellation and overlap. It need not expose any prime through proper gcd-supported frequency subgroups.

### 6.4 Common-modulus pullbacks do not couple the pivots

Let
[
Q=\operatorname{lcm}_j(M_j),\qquad
s_j=Q/M_j.
]
For (f_j:\mathbb Z/M_j\mathbb Z\to\mathbb C), pull back along reduction:
[
\widetilde f_j(x)=f_j(x\bmod M_j).
]
Then
[
\widehat{\widetilde f_j}(k)=0
\quad\text{unless }s_j\mid k,
]
and
[
\widehat{\widetilde f_j}(s_j\ell)=\widehat f_j(\ell).
]

This embeds each pivot identity into a separate frequency subgroup of
(\mathbb Z/Q\mathbb Z). It preserves the annihilation equations but creates no relation between them. Multiplying or averaging these pulled-back equations adds a new operation not justified by the original covers.

The missing cross-pivot arrow is:
[
\text{some prime in one pivot's support data}
;\Longrightarrow;
\text{the same prime divides every speed}.
]
Neither the support formula nor the coefficient values provide such a selection.

## 7. Falsification

### 7.1 An infinite all-but-one family

The strengthening
[
\text{“at least (n-1) full pivots imply a common prime”}
]
is false in every dimension (n\ge2).

Fix (n\ge2), put (N=n+1), and let
[
L_0=N\operatorname{lcm}(1,2,\ldots,n-1).
]
For any integer (m\ge1), set
[
L=mL_0
]
and define the (n)-tuple
[
a=(1,2,\ldots,n-1,L).
]

It is positive and injective because
[
L\ge N>n-1,
]
and it is primitive because one coordinate is (1).

For a pivot (p\in{1,\ldots,n-1}),
[
M_p=Np\mid L.
]
Therefore the owner (L) satisfies
[
rL\equiv0\pmod{M_p}
]
for every candidate (r), and
[
B_L^p=R_p.
]
Thus the first (n-1) pivots are fully covered, each by a singleton owner.

At the last pivot (p=L), take
[
r=L+1.
]
Since (N\mid L),
[
N\nmid r,
]
so (r) is a candidate modulo (NL).

For an owner speed (s\in{1,\ldots,n-1}={1,\ldots,N-2}),
[
x=s(L+1).
]
It satisfies
[
x\ge L+1>L
]
and
[
NL-x=(N-s)L-s
\ge2L-(N-2)
\ge L.
]
Hence
[
\rho_{NL}(s(L+1))\ge L.
]
Equality is safe, so (r=L+1) is good at the last pivot. Its reflection (NL-(L+1)) is a second distinct good candidate.

Therefore
[
G_p=0\quad(p=1,\ldots,n-1),
\qquad
G_L\ge2,
]
while
[
\gcd(1,2,\ldots,n-1,L)=1.
]

Permuting coordinates places the sole uncovered pivot at any prescribed index. Thus every individual pivot hypothesis in the target is indispensable. This family also shows that (n-1) independent spectral annihilations may all arise from the same owner (L), with no common prime entering the speed (1).

### 7.2 Bounded primitive scan

The mandatory scan domain was:

* (n=3,4,5,6);
* strictly increasing positive tuples;
* largest speed at most (12);
* gcd equal to (1);
* order by (n), then lexicographically;
* global early stop at the first tuple with all pivot counts zero.

Results:

| (n) | Primitive tuples scanned | First all-pivot full tuple |
| --: | -----------------------: | -------------------------- |
|   3 |                      196 | none                       |
|   4 |                      479 | none                       |
|   5 |                      786 | none                       |
|   6 |                      923 | none                       |

This is only `computed finite evidence`. It proves neither the common-prime lemma nor unrestricted LRC.

## 8. Complete implication chain

Assume `SIMULTANEOUS-FULL-COVER-COMMON-PRIME`.

Let (a:\operatorname{Fin}n\to\mathbb N) be positive and injective and suppose it has no pivot certificate.

### 8.1 Full covers

By §3, absence of a certificate means that no pivot has a good candidate. Therefore
[
\forall j,\quad G_j(a)=0,
]
hence
[
\forall j,\quad\operatorname{FullCover}_j(a).
]

### 8.2 Primitive normalization

Let
[
d=\gcdAll(a).
]
Because the family is finite, nonempty, and every (a_i>0),
[
d>0.
]
Define
[
b_i=a_i/d.
]

Then:

* (b_i>0), since (a_i=d b_i>0) and (d>0).
* (b) is injective: if (b_i=b_k), then (a_i=db_i=db_k=a_k), hence (i=k).
* (\gcdAll(b)=1): if (e) divides every (b_i), then (de) divides every (a_i). By maximality of (d), (de\mid d), so (e=1).

### 8.3 Exact scaling of bad-set membership

For pivot (j), put
[
M_b=Nb_j,\qquad M_a=Na_j=dM_b.
]
For (r\bmod M_a), let
[
s=r\bmod M_b.
]
Because (M_b) is divisible by (N),
[
N\mid r\iff N\mid s.
]
Moreover,
[
\rho_{dM_b}(r,d b_i)
====================

d,\rho_{M_b}(s b_i).
]
Hence
[
\rho_{M_a}(r a_i)<a_j
\iff
\rho_{M_b}(s b_i)<b_j.
]

Each residue (s\bmod M_b) has exactly (d) lifts modulo (M_a). Therefore the exact count identity is
[
G_j(a)=d,G_j(b).
]
This is proved here rather than assumed. In particular,
[
\operatorname{FullCover}_j(a)
\iff
\operatorname{FullCover}_j(b).
]

The equivalent witness-time direction is also exact. If (t) is a real witness for (b), then
[
t_a=\frac td
]
is a witness for (a), because
[
a_i t_a=(d b_i)\frac td=b_i t.
]
Conversely, a witness (s) for (a) gives the witness (ds) for (b).

Thus, using `exists_witness_iff_exists_pivot_certificate` in the directions

1. pivot certificate for (b) (\Rightarrow) real witness for (b);
2. scaled real witness for (a) (\Rightarrow) pivot certificate for (a),

absence of a certificate for (a) also implies absence of one for (b).

### 8.4 Contradiction from the target

Every pivot of (b) is fully covered. The common-prime lemma yields a prime (q) satisfying
[
\forall i,\quad q\mid b_i.
]
Then
[
q\mid\gcdAll(b)=1,
]
which is impossible because (q\ge2).

Therefore every positive injective integer tuple has a pivot certificate. This establishes `PositiveIntegerPivotCertificateConjecture` conditionally on the common-prime lemma.

Use the existing equivalences in these directions:
[
\texttt{PositiveIntegerPivotCertificateConjecture}
\Longrightarrow
\texttt{PositiveIntegerConjecture},
]
from the reverse direction of
`positiveIntegerConjecture_iff_pivotCertificateConjecture`, and then
[
\texttt{PositiveIntegerConjecture}
\Longrightarrow
\texttt{Conjecture},
]
from the reverse direction of
`conjecture_iff_positiveIntegerConjecture`.

The runner indexing and closed (1/N) boundary are unchanged throughout.

This also shows the logical strength of the target. Given the proved equivalences and the normalization above:

* the common-prime lemma implies unrestricted LRC;
* unrestricted LRC would make its antecedent impossible and hence imply it vacuously.

That equivalence is a dependency analysis, not a proof of either statement.

## 9. Artifacts and replay

The audit used one Python source file and one JSON output.

* [Source: p70_falsification.py](sandbox:/mnt/data/p70_falsification.py)
* [Machine-readable output: p70_falsification.json](sandbox:/mnt/data/p70_falsification.json)

Runtime:

```text
CPython 3.13.5
standard library only
```

Replay command:

```bash
python3 /mnt/data/p70_falsification.py /mnt/data/p70_falsification.json
```

Schema:

```text
PIPE-P70-RESPEC-123/falsification-v1
```

SHA-256:

```text
0b9c3dc443c1fc1689736edf1b860e149d9c8eb8d7efe8a68dc02d7dc2520e46  p70_falsification.py
32d1fdc80dd68744912f6d11b552b6f826c0f500841960ec40820a871a5bd4f3  p70_falsification.json
```

The source is 10,544 bytes. The output is 8,792 bytes. No Lean artifact was created.

## 10. Final boundary

### `proved-lean`

Only the stipulated repository equivalences:

```text
exists_witness_iff_exists_pivot_certificate
positiveIntegerConjecture_iff_pivotCertificateConjecture
conjecture_iff_positiveIntegerConjecture
```

### `proved-math`

Only the already audited `PART-12` Fourier material.

### `computed finite evidence`

The ten fixtures, scaling tests, permutation tests, boundary checks, unit-owner full-pivot example, and the primitive scan through largest speed (12).

### `conditional`

Pending independent audit:

1. the exact `FullCover` finite-set equivalence;
2. the coarse-grid divisor-cover lemma;
3. singleton-cover rigidity;
4. the strict-growth digraph corollary that some simultaneous full cover must have a genuinely multiowner pivot;
5. the all-but-one family proof;
6. normalization, exact count scaling, and certificate descent.

### `rejected`

1. The former (U(a)\ge n) target.
2. Factorwise absolute main-term domination.
3. Any common-prime theorem based on only (n-1) full pivots.
4. Private-point-to-owner-pivot-gcd propagation.
5. The claim that a full pivot must contain a nonunit owner.

### `open`

The first unresolved arrow is now exact:

[
\boxed{
\text{multiowner complete covers at the remaining pivots}
\Longrightarrow
\text{one prime persistent across every pivot modulus and every speed}.
}
]

Attack A reaches exact divisibility only for singleton covers and stops at multiowner private points. Attack B reaches exact separate-modulus annihilation but has no justified operation selecting the same prime from different convolution systems. The simultaneous-full-cover common-prime lemma and unrestricted Lonely Runner remain `open`.
