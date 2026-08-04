## 1. Disposition

**SEPARATION**

`MAX-COVERED-NONDIVISIBLE-PIVOT-REDUNDANCY` is neither proved nor refuted at its unrestricted quantifiers.

The mandatory (t p) slice is proved. Beyond it, the following uniform results are proved:

1. an exact whole-fiber description of every (N)-divisible owner at the maximum row;
2. an exact position formula for nondivisible owners inside those fibers;
3. an explicit map from a bad maximum-row residue to a strict boundary candidate of the lower (N)-divisible pivot;
4. an injective augmentation of that boundary map;
5. a strict margin inequality that literally transports a lower-row covering label back to the maximum row.

The first unsupported edge is the existence of suitable **internal, monotone boundary carriers**. Coveredness of the lower pivot alone does not provide them. A precise carrier-peeling lemma is stated in Section 9 and proved sufficient to close the branch.

---

## 2. Evidence boundary

| Item                                                               | Status                     |
| ------------------------------------------------------------------ | -------------------------- |
| Frozen definitions and theorem quantifiers                         | `input-accepted`           |
| Self-safety of the canonical pivot row                             | `proved-math-response`     |
| Branch equivalences                                                | `proved-math-response`     |
| Mandatory (t p) slice lemma                                        | `proved-math-response`     |
| (N)-divisible-owner fiber decomposition                            | `proved-math-response`     |
| Nondivisible-owner position formula within a fiber                 | `proved-math-response`     |
| Boundary map, augmented injectivity, and margin transport          | `proved-math-response`     |
| Static peeling under an explicit carrier hypothesis                | `proved-math-qualified`    |
| Naïve row-to-row transport implication                             | `refuted-exact`            |
| Monotone boundary-carrier existence lemma                          | `conjectural`              |
| Carrier lemma implies the branch theorem                           | `conditional`              |
| Height-(30), (2\le n\le7) exhaustive replay                        | `computed finite evidence` |
| Main branch theorem                                                | `open`                     |
| Lean formalization                                                 | `not-run`                  |
| Prompt94, Prompt95 response, Prompt96, and excluded route families | `out-of-scope`             |

No prior response-authored theorem, search, attachment, or unrestricted Lonely Runner statement is used.

---

## 3. Exact definitions

Let (n\ge2), (N=n+1), and let (a_0,\dots,a_{n-1}) be positive and pairwise distinct. Labels are retained even when two labelled bad sets coincide.

For a pivot label (j), put
[
p_j=a_j,\qquad M_j=Np_j,
]
and
[
\rho_M(x)=\min(x\bmod M,;M-(x\bmod M)).
]

The canonical candidate row is
[
R_j={r\in{0,\dots,M_j-1}:N\nmid r}.
]
The excluded representatives are
[
0,N,2N,\dots,(p_j-1)N,
]
so there are exactly (p_j) of them, including zero, and
[
|R_j|=Np_j-p_j=np_j>0.
]

For (i\ne j),
[
B_i^j={r\in R_j:\rho_{M_j}(r a_i)<p_j},
]
with strict badness. Equality is safe. Define
[
Q_j=R_j\setminus\bigcup_{i\ne j}B_i^j,\qquad
F(a)={j:Q_j=\varnothing}.
]

For (r=Nq+s), (1\le s\le N-1),
[
rp_j\equiv sp_j\pmod{Np_j},
]
and hence
[
\rho_{Np_j}(rp_j)
=p_j\min(s,N-s)\ge p_j.
]
Thus the pivot label is safe at every (r\in R_j), including equality cases, and (Q_j) is exactly the canonical pivot-certificate set.

When (F(a)\ne\varnothing), (j_*) is the unique label in (F(a)) having maximum speed. Write
[
p=a_{j_*},\qquad M=Np,\qquad R=R_{j_*}.
]
Every other covered pivot has speed strictly below (p).

A labelled set (C\subseteq\operatorname{Fin}n\setminus{j_*}) is complete when
[
R=\bigcup_{i\in C}B_i^{j_*}.
]
It is internal when
[
C\subseteq F(a)\setminus{j_*},
]
and inclusion-minimal when no proper labelled subset remains complete.

For a minimal complete cover,
[
\operatorname{Priv}(C,i)
=B_i^{j_*}\setminus\bigcup_{\substack{h\in C\h\ne i}}B_h^{j_*}
]
is nonempty for every (i\in C).

Reflection (r\mapsto M-r) preserves all strict bad predicates. The only possible fixed reflection point is (M/2). It belongs to (R) exactly when (N) is even and (p) is odd. No lower-half representative is assumed for a private set.

The finite computation used increasing (n), lexicographically increasing tuples, increasing pivot labels, increasing canonical residues, increasing owner labels, and owner subsets ordered first by cardinality and then lexicographically.

---

## 4. Branch equivalences

Consider the following three statements for a fixed theorem-domain tuple:

1. Every internal complete (C) contains (i) such that (C\setminus{i}) is complete.
2. No inclusion-minimal internal complete cover exists.
3. No internal complete cover exists.

They are equivalent.

**(1\Rightarrow3).** Suppose (C) were internal and complete. It is nonempty because (R\ne\varnothing). By statement 1, delete a redundant label. The resulting set is still internal and complete, so statement 1 applies again. Finiteness eventually produces the empty complete cover, impossible because (R\ne\varnothing).

**(3\Rightarrow1).** The antecedent “(C) is internal and complete” never occurs, so the redundancy assertion holds vacuously.

**(2\Leftrightarrow3).** From any finite internal complete cover, repeatedly delete a label whenever completeness is preserved. The process terminates at an inclusion-minimal internal complete cover. Conversely, a minimal internal cover is itself an internal complete cover.

For the same reason,
[
\text{an internal complete cover exists}
\iff
\bigcup_{i\in F(a)\setminus{j_*}}B_i^{j_*}=R.
]

---

## 5. (t p) slice proof

Fix (1\le t\le N-1) and let
[
r_t=tp.
]
Then
[
0<tp<Np,
]
so (r_t) is already a canonical representative. It belongs to (R) exactly when
[
N\nmid tp.
]

Let an owner have speed (b). If (u) is the residue of (tb) modulo (N), then
[
r_t b=ptb\equiv pu\pmod{Np}.
]
Therefore
[
\rho_{Np}(r_t b)
=p\min(u,N-u)
=p\rho_N(tb).
]

Whenever (r_t\in R),
[
r_t\in B_b^{j_*}
\iff
p\rho_N(tb)<p
\iff
\rho_N(tb)<1.
]
The quantity (\rho_N(tb)) is a nonnegative integer, so
[
r_t\in B_b^{j_*}\iff \rho_N(tb)=0
\iff N\mid tb.
]

If (\gcd(t,N)=1), then
[
N\mid tb\iff N\mid b.
]
If additionally (N\nmid p), then (N\nmid tp), so (r_t\in R). Hence
[
r_t\in B_b^{j_*}\iff N\mid b.
]

Taking (t=1), the candidate (r=p) can be covered only by an owner whose speed is divisible by (N). Consequently, every complete cover (C) contains some (i) satisfying
[
N\mid a_i.
]

If (C) is internal, then (i\in F(a)\setminus{j_*}), and maximality plus injectivity give
[
0<a_i<p,\qquad N\mid a_i.
]

This proves the mandatory slice lemma but does not make (i) redundant.

---

## 6. Fixture ledger

### Fixture 1: ((6,7,12,24,144))

Here (n=5), (N=6). The row data, indexed by pivot speed, are:

[
\begin{array}{c|ccccc}
p_j&6&7&12&24&144\ \hline
|Q_j|&0&0&0&0&160
\end{array}
]

Thus
[
F(a)={6,7,12,24},\qquad j_*=24,
]
and (6\mid24). The branch theorem is inapplicable at (j_*).

At the separate pivot (p=7),
[
M=42,\qquad |R|=35.
]
Every labelled bad set has size (15). The inclusion-minimal complete covers are exactly
[
{6,12,24},\qquad {6,12,144}.
]

For ({6,12,24}), the private sets are
[
\begin{aligned}
\operatorname{Priv}(6)
&={1,8,13,15,20,22,27,29,34,41},\
\operatorname{Priv}(12)
&={3,4,10,11,17,25,31,32,38,39},\
\operatorname{Priv}(24)
&={2,5,9,16,19,23,26,33,37,40}.
\end{aligned}
]
For ({6,12,144}), the first two private sets are unchanged and the last set belongs to label (144).

The candidate (r=p=7) is covered by all four owners (6,12,24,144), all of which are divisible by (6). The set ({6,12}) misses exactly
[
{2,5,9,16,19,23,26,33,37,40},
]
whose least element is (2).

The cover ({6,12,24}) is internal relative to pivot (7), but (7\ne j_*). This verifies that the maximum-covered-pivot condition is essential.

### Fixture 2: ((1,8,13,15,27,28))

Here (n=6), (N=7), and
[
(|Q_1|,|Q_8|,|Q_{13}|,|Q_{15}|,|Q_{27}|,|Q_{28}|)
=(0,0,8,14,26,22).
]
Therefore
[
F(a)={1,8},\qquad j_*=8,\qquad 7\nmid8.
]

At pivot (8),
[
M=56,\qquad |R|=48.
]
The labelled bad-set sizes are
[
|B_1|=|B_{13}|=|B_{15}|=|B_{27}|=12,\qquad |B_{28}|=24.
]
The five-owner set
[
{1,13,15,27,28}
]
is complete. The only internal owner is speed (1), and (B_1) leaves (36) candidates uncovered, beginning with (8).

At (r=p=8),
[
\rho_{56}(8\cdot 28)=0<8,
]
while
[
\rho_{56}(8\cdot1)=8.
]
Thus (r=8) is covered only by speed (28), and speed (1) is safe by equality. The known complete cover is not internal.

### Fixture 3: ((1,6,11,12,13))

Here (n=5), (N=6), and
[
(|Q_1|,|Q_6|,|Q_{11}|,|Q_{12}|,|Q_{13}|)
=(0,0,8,8,10).
]
Hence
[
F(a)={1,6},\qquad j_*=6,\qquad 6\mid p.
]
At pivot (6), the unique minimum cover is
[
{1,11,12,13}.
]
This tuple lies exactly on the excluded divisibility boundary and gives no evidence about the (N\nmid p) branch.

### Strict boundary, collision, and nonunit controls

For ((1,3,4,5)), (N=5), pivot (3), (M=15):
[
B_1={1,2,13,14},\quad
B_4={4,7,8,11},\quad
B_5={3,6,9,12}.
]
Thus (r=3) is a candidate, speed (1) is safe because
[
\rho_{15}(3)=3,
]
and speed (5) covers it by the zero product
[
\rho_{15}(15)=0.
]
Both cyclic sides occur in (B_1).

For ((1,3,13)), (N=4), pivot (3),
[
B_1=B_{13}={1,2,10,11},
]
but the two labels remain distinct.

For ((1,2,3)), (N=4), pivot (3), the nonunits (r=3,9) remain in (R). Speed (1) is safe at both by equality:
[
\rho_{12}(3)=\rho_{12}(9)=3.
]

The tuple ((1,1,2)) is rejected before computing (F). Owner sets containing the pivot label are rejected. Weak badness, deletion of a cyclic side, or deletion of nonunit candidates changes the recorded controls and is detected.

### Scaling control

For any positive integer (d), scale (a) to (a'=da). At row (j),
[
p'*j=dp_j,\qquad M'*j=dM_j.
]
For (r\in{0,\dots,dM_j-1}), put (s=r\bmod M_j). Since (M_j) is divisible by (N),
[
N\nmid r\iff N\nmid s.
]
Also
[
\rho*{dM_j}(d x)=d\rho*{M_j}(x),
]
so
[
\rho_{dM_j}(r,d a_i)
=d\rho_{M_j}(s a_i).
]
Consequently, every scaled row, bad set, (Q)-set, cover, and private set consists of (d) canonical lifts of its unscaled counterpart. In particular, (F) is preserved as a label set.

For
[
(1,8,13,15,27,28)
]
the covered speeds are ({1,8}). For its scale by (7),
[
(7,56,91,105,189,196),
]
the covered speeds are ({7,56}). The distinguished speeds are (8) and (56), respectively:
[
7\nmid8,\qquad 7\mid56.
]
Thus the branch predicate is not scale invariant.

The deliberately claimed (j_*=7) in Fixture 1, the deliberately altered first uncovered residue (3), and the synthetic claim (F(1,3,13)\ne\varnothing) were all rejected.

---

## 7. Lane A: private-slice and fiber structure

Assume, only for structural analysis, that an internal inclusion-minimal complete cover (C) exists. Let
[
D(C)={i\in C:N\mid a_i}.
]
The slice lemma gives (D(C)\ne\varnothing). Select the least owner label (i\in D(C)), as required, and write
[
b=a_i=Nc,\qquad 0<b<p.
]

For brevity in this section, write (B_h^p=B_h^{j_*}).

### 7.1 Exact privacy on the (t p) slice

For every (t) with (1\le t\le N-1) and (N\nmid tp),
[
tp\in B_h^p\iff N\mid t a_h.
]
Therefore
[
tp\in\operatorname{Priv}(C,i)
\iff
N\mid tb
\quad\text{and}\quad
N\nmid t a_h\ \text{for every }h\in C\setminus{i}.
]

Since (N\mid b), the first condition is automatic.

If (\gcd(t,N)=1), then
[
tp\in B_h^p\iff N\mid a_h.
]
Hence:

* if (D(C)={i}), every unit-slice candidate (tp) belongs to (\operatorname{Priv}(C,i));
* if (|D(C)|\ge2), no unit-slice candidate is private to any member of (D(C)).

When (N) is even and (p) is odd, (t=N/2) gives the fixed antipode
[
tp=M/2\in R.
]
It is private to (i) precisely when no other owner (h\in C) satisfies
[
N\mid (N/2)a_h.
]
This explicitly retains the possible fixed antipode and shows why a private set need not have a lower-half member.

### 7.2 Whole-fiber theorem for an (N)-divisible owner

Let
[
d=\gcd(N,p).
]
For (u\in{0,\dots,p-1}), define its candidate fiber
[
P_u={u+kp:0\le k<N,\ N\nmid u+kp}.
]

The congruence
[
u+kp\equiv0\pmod N
]
is solvable exactly when (d\mid u). When it is solvable, it has exactly (d) solutions (k\bmod N). Therefore
[
|P_u|=
\begin{cases}
N-d,&d\mid u,\
N,&d\nmid u.
\end{cases}
]
Because (N\nmid p), one has (d<N), so every (P_u) is nonempty.

For (b=Nc),
[
\rho_{Np}(r b)
=\rho_{Np}(Nrc)
=N\rho_p(rc).
]
This follows by writing (rc=qp+v):
[
Nrc\equiv Nv\pmod{Np},
\qquad
\rho_{Np}(Nv)=N\rho_p(v).
]

Define
[
A_c={u\in\mathbb Z/p\mathbb Z:N\rho_p(cu)<p}.
]
Since (rc\bmod p) depends only on (u=r\bmod p),
[
\boxed{
B_i^p=\bigsqcup_{u\in A_c}P_u.
}
]
Thus an (N)-divisible owner covers either the entire candidate fiber (P_u) or none of it.

If (e=\gcd(c,p)), multiplication by (c) modulo (p) has kernel size (e), and its image consists of multiples of (e). The strict inequality selects
[
0,\ \pm e,\ \pm2e,\dots,\pm m e,
\qquad
m=\left\lfloor\frac{p-1}{Ne}\right\rfloor.
]
Therefore
[
|A_c|
=e\left(1+2\left\lfloor\frac{p-1}{Ne}\right\rfloor\right),
]
and
[
|B_i^p|
=N|A_c|-d,|{u\in A_c:d\mid u}|.
]

### 7.3 Exact positions occupied by a nondivisible owner

Let (h) be any other speed. For fixed (u), write
[
u h=pq+v,\qquad 0\le v<p.
]
For the lift (r_k=u+kp),
[
r_kh=v+p(q+kh).
]
Let
[
\ell_k\equiv q+kh\pmod N,\qquad 0\le\ell_k<N.
]
The canonical product residue is
[
v+p\ell_k.
]

A direct examination of the strict distance from (0) modulo (Np) gives
[
r_k\in B_h^p
\iff
\begin{cases}
\ell_k=0,&v=0,\
\ell_k\in{0,N-1},&1\le v<p.
\end{cases}
]
Indeed, (\ell=0) gives residue (v<p); (\ell=N-1) gives distance (p-v<p) exactly when (v>0); every interior value gives distance at least (p).

If (g_h=\gcd(h,N)), each attainable value of (\ell_k) has (g_h) preimages among all (k\bmod N). Thus, before excluded candidates are removed, a nondivisible owner occupies at most

[
g_h\quad\text{positions when }v=0,
\qquad
2g_h\quad\text{positions when }v>0
]
inside a fiber. By contrast, an (N)-divisible owner occupies an entire candidate fiber or none.

### 7.4 Exact private-fiber criterion

For (u\in A_c),
[
\operatorname{Priv}(C,i)\cap P_u
================================

P_u\setminus
\bigcup_{h\in C\setminus{i}}
(B_h^p\cap P_u).
]
For (u\notin A_c), this intersection is empty.

A second (N)-divisible owner (h=Nc_h) removes the whole fiber (P_u) from the private set exactly when (u\in A_{c_h}). Nondivisible owners remove only the positions specified by the (\ell_k)-criterion above.

This completely determines which residue classes can contain private points. It does **not** prove
[
B_i^p\subseteq\bigcup_{h\in C\setminus{i}}B_h^p.
]
In an assumed minimal cover that inclusion is false by definition. The missing argument would have to derive a contradiction from (i\in F(a)), not from the maximum-row fiber structure alone.

---

## 8. Lane B: boundary projection and the first failed transport

The row (i) has modulus
[
M_i=Nb=N^2c.
]

### 8.1 Explicit boundary map

For (r\in B_i^p), let (z=z(r)) be the signed remainder of (cr) modulo (p), chosen in ((-p/2,p/2]). Since
[
N|z|=N\rho_p(cr)<p,
]
there is no antipodal ambiguity. Put
[
k(r)=\frac{cr-z}{p}\in\mathbb Z.
]
Then
[
br=Ncr=Npk+Nz.
]

Define
[
\varepsilon(r)=
\begin{cases}
1,&z\ge0,\
-1,&z<0,
\end{cases}
]
with the deterministic choice (+1) when (z=0), and define
[
\beta(r)=(Nk+\varepsilon)\bmod Nb.
]

Because
[
\beta(r)\equiv\pm1\pmod N,
]
one has
[
\beta(r)\in R_i.
]
Moreover,
[
\rho_{Nb}(\beta(r)b)=b.
]
Thus (\beta(r)) is exactly a strict-boundary candidate of pivot (b); the pivot is safe there by equality.

Define the positive boundary gap
[
\Delta(r)=p-N|z(r)|.
]
Strict badness gives
[
1\le\Delta(r)\le p.
]

### 8.2 Fibers and collisions

The map (\beta) need not be injective. For example, with
[
N=4,\quad p=5,\quad b=4,
]
both (r=5) and (r=6) lie in (B_b^p) and satisfy
[
\beta(5)=\beta(6)=5,
]
with signed remainders (z(5)=0) and (z(6)=1).

However, the augmented map
[
r\longmapsto(\beta(r),z(r))
]
is injective.

To prove this, suppose (r_1,r_2) have the same (\beta) and (z). They have the same (\varepsilon), and
[
N(k_1-k_2)\equiv0\pmod{Nb},
]
so
[
k_1-k_2=bq
]
for some integer (q). Since
[
c(r_1-r_2)=p(k_1-k_2)=pbq=pNc,q,
]
it follows that
[
r_1-r_2=Npq.
]
Both are canonical representatives modulo (Np), so (r_1=r_2).

Equivalently, a boundary fiber consists of the residues obtained as follows:

1. choose (z) with (N|z|<p) and sign compatible with the boundary class (s\equiv\pm1\pmod N);
2. choose (k\equiv(s-\varepsilon(z))/N\pmod b);
3. require (c\mid pk+z);
4. set (r=(pk+z)/c\bmod Np);
5. retain (N\nmid r).

Different (z)-values can collide at the same boundary residue, so a carrier must be selected per (r), not merely per (\beta).

### 8.3 Exact strict-margin transport lemma

Let
[
t=\frac{r}{Np},\qquad
u=\frac{Nk+\varepsilon}{Nb}.
]
The second expression may use the unreduced integer (Nk+\varepsilon), since changing it by (Nb) changes (u) by an integer.

Using (br=Npk+Nz),
[
|u-t|
=\frac{|p\varepsilon-Nz|}{Npb}
=\frac{\Delta(r)}{Npb}.
]

Suppose a label (h\ne i) covers the boundary candidate at row (i):
[
\rho_{Nb}(\beta(r)a_h)<b.
]
Its strict lower-row margin is
[
m_h(r)=b-\rho_{Nb}(\beta(r)a_h)>0.
]

If
[
\boxed{
a_h\Delta(r)<p,m_h(r),
}
]
then (h) also covers (r) at the maximum row.

Indeed,
[
|a_h t|*{\mathbb R/\mathbb Z}
\le
|a_h u|*{\mathbb R/\mathbb Z}
+a_h|u-t|
]
and hence
[
|a_h t|
\le
\frac{\rho_{Nb}(\beta a_h)}{Nb}
+\frac{a_h\Delta}{Npb}.
]
The displayed margin inequality makes the right side strictly less than (1/N). Therefore
[
\rho_{Np}(r a_h)<p,
]
so (r\in B_h^p).

Equality in the margin inequality is insufficient, because it yields only the safe boundary value (1/N).

### 8.4 Exact failure of automatic transport

Consider
[
a=(5,11,20,25),\qquad n=4,\qquad N=5.
]
The exact row computation gives
[
F(a)={5,11},\qquad j_*=11,\qquad 5\nmid11.
]
Thus this is a theorem-domain branch tuple, although its full internal owner set ({5}) is not complete.

Let (p=11), (b=5=N), and (r=1). Then
[
\rho_{55}(1\cdot5)=5<11,
]
so (r\in B_5^{11}).

For the boundary construction,
[
z=1,\qquad k=0,\qquad \beta=1,\qquad \Delta=11-5=6.
]
At the lower row (b=5), whose modulus is (25), owner speed (25) covers every candidate by a zero product:
[
\rho_{25}(1\cdot25)=0<5.
]
But at the maximum row,
[
\rho_{55}(1\cdot25)=25\ge11.
]
The margin inequality fails:
[
25\cdot6=150
\not<
11(5-0)=55.
]

Therefore the implication
[
\beta(r)\in B_h^i
\quad\Longrightarrow\quad
r\in B_h^{j_*}
]
is `refuted-exact`.

This example also exhibits the label obstruction: speed (25) is not in (F(a)). Coveredness of row (i) may be supplied entirely by a noninternal high owner, and the resulting cover cannot simply replace (i) at row (j_*).

---

## 9. Lane C: well-founded descent and the exact next edge

For any hypothetical internal complete cover (C), the slice lemma defines
[
\nu(C)=\min{a_i:i\in C,\ N\mid a_i}.
]
Because every such speed is below (p),
[
1\le p-\nu(C)\le p-1.
]

Freeze the lexicographic key
[
K(C)=\bigl(p-\nu(C),\ |C|,\ \text{increasing owner-label list of }C\bigr).
]
The first coordinate alone is well founded.

### Monotone boundary-carrier peeling lemma

The precise next arithmetic edge is:

> **MBCP.**
> Under the theorem hypotheses, let (C) be an internal inclusion-minimal complete cover. Let (i\in C) be the unique owner of minimum speed among those satisfying (N\mid a_i), and write
> [
> b=a_i=Nc.
> ]
> For every (r\in B_i^{j_*}), form
> [
> z(r),\quad k(r),\quad\varepsilon(r),\quad
> \beta(r),\quad\Delta(r)
> ]
> exactly as in Section 8. Then there exists a function
> [
> \kappa:B_i^{j_*}\longrightarrow
> F(a)\setminus{j_*,i}
> ]
> such that, for every (r):
> [
> \beta(r)\in B_{\kappa(r)}^i,
> ]
> [
> a_{\kappa(r)}\Delta(r)
> <
> p\Bigl(
> b-\rho_{Nb}(\beta(r)a_{\kappa(r)})
> \Bigr),
> ]
> and
> [
> N\mid a_{\kappa(r)}
> \quad\Longrightarrow\quad
> a_{\kappa(r)}>b.
> ]
> The carrier is selected per element of the augmented fiber ((\beta(r),z(r))); no constancy across a colliding (\beta)-fiber is assumed.

This statement specifies the map, its domain, its collisions, the lower-row boundary condition, the strict transport margin, the allowed labels, internality, and the monotonicity condition.

### MBCP would close the branch

Assume MBCP. Let
[
H=\operatorname{range}(\kappa),\qquad
C'=(C\setminus{i})\cup H.
]

If (r\notin B_i^{j_*}), completeness of (C) implies that (r) is already covered by an owner in (C\setminus{i}).

If (r\in B_i^{j_*}), the strict-margin transport lemma gives
[
r\in B_{\kappa(r)}^{j_*}.
]
Therefore (C') is complete.

Every member of (C') lies in (F(a)\setminus{j_*}), so (C') is internal. The tuple, (F(a)), (j_*), (p), candidate row, labels, strict boundaries, and bad sets are unchanged.

All (N)-divisible speeds already in (C\setminus{i}) are greater than (b), by the choice of (i). The MBCP monotonicity condition gives the same conclusion for newly inserted carriers. Since (C') is complete, the slice lemma ensures that it still contains at least one (N)-divisible owner. Hence
[
\nu(C')>b=\nu(C),
]
and therefore
[
p-\nu(C')<p-\nu(C).
]

Delete redundant labels from (C'), using least-label deletion and restarting, to obtain an inclusion-minimal internal complete cover (D\subseteq C'). The slice lemma still guarantees an (N)-divisible owner in (D), and
[
\nu(D)>b.
]
Thus
[
K(D)<K(C).
]

Repeated application would create a strictly descending sequence of positive integers (p-\nu(C)), impossible. Therefore no internal complete cover exists. Section 4 would then give the exact redundancy theorem.

The existence of (\kappa) is the first open edge. It does not follow from (i\in F(a)): the tuple ((5,11,20,25)) shows that a boundary can be covered only by an external noncovered owner and with insufficient transport margin. No preservation or decrease follows from the lower-row cover alone.

---

## 10. Lane D: finite method

The audited finite domain was frozen as
[
2\le n\le7,\qquad
1\le a_0<a_1<\cdots<a_{n-1}\le30.
]

Both implementations used GCC
[
\texttt{g++ 14.2.0}
]
with C++20 and completed the entire domain.

### Independent implementations

**Implementation A** constructs all canonical (R_j), every labelled (B_i^j), every (Q_j), (F), and (j_*). For every branch tuple it enumerates every internal owner subset in cardinality-then-lexicographic order, classifies completeness and minimality, and constructs every private set for any minimal cover found.

**Implementation B** independently represents safe sets rather than bad-set unions. It computes the union of all internal owners through the complementary intersection of their safe sets. If equality with (R_{j_*}) occurs, it starts with the increasing internal label list, deletes the least removable label, and restarts until minimal.

No row or cover source code is shared.

|       (n) |    Raw tuples | Primitive tuples | Branch tuples | Primitive branch tuples | A subsets tested |
| --------: | ------------: | ---------------: | ------------: | ----------------------: | ---------------: |
|         2 |           435 |              277 |            22 |                      10 |               22 |
|         3 |         4,060 |            3,472 |           394 |                     319 |              405 |
|         4 |        27,405 |           25,819 |         4,364 |                   3,936 |            4,757 |
|         5 |       142,506 |          139,246 |        27,861 |                  27,053 |           30,432 |
|         6 |       593,775 |          588,559 |       135,661 |                 133,775 |          155,402 |
|         7 |     2,035,800 |        2,029,245 |       418,677 |                 417,187 |          466,540 |
| **Total** | **2,803,981** |    **2,786,618** |   **586,979** |             **582,280** |      **657,558** |

Additional totals:

[
587,648
]
tuples had (F(a)\ne\varnothing).

Implementation A found:

[
0\ \text{complete internal covers},\qquad
0\ \text{minimal internal covers}.
]

Implementation B found:

[
0\ \text{full-internal-union equalities}.
]

The two canonical record streams contain (2,803,981) lines and are byte-identical. Their common SHA-256 is

```text
ebca04f8f85f653d444fd2ffaa4aae59f4ad9e48f440a17bb25115652e6b1e66
```

Source and summary hashes:

```text
Implementation A source:
f0c999dd846a6d49239abc2f2094b585bdb4ca065fbe4c979f73d2f41708f24c

Implementation B source:
3998587e8239aa0bc4ac98922f855753820568ba8c7552308bfca84fb73a4f69

Implementation A summary:
5e81c7e583d435145f7dc9ea1252e7546f847f69a125212ad8b8f33bf73ad2b0

Implementation B summary:
400ef29b92c427a1a01ea28abbbd7ece935376c5731bbf26f34d5cfd87bb9788
```

Completion markers:

```text
SOL_P98_IMPL_A_COMPLETE
SOL_P98_IMPL_B_COMPLETE
```

First disagreement: `NONE`.

First theorem-domain failure: `NONE`.

First malformed input:

```text
(1,1,2): repeated speed
```

The preflight independently detected the wrong (j_*=7), the altered first-uncovered residue (3), and the synthetic premise violation for ((1,3,13)).

Artifacts:

* [Implementation A source](sandbox:/mnt/data/sol_p98_impl_a.cpp)
* [Implementation B source](sandbox:/mnt/data/sol_p98_impl_b.cpp)
* [Implementation A summary](sandbox:/mnt/data/sol_p98_summary_a_checked.txt)
* [Implementation B summary](sandbox:/mnt/data/sol_p98_summary_b.txt)
* [Computation manifest](sandbox:/mnt/data/sol_p98_computation_manifest.txt)

This is `computed finite evidence`, not an unrestricted proof.

---

## 11. Sole theorem

The exact theorem
[
\texttt{MAX-COVERED-NONDIVISIBLE-PIVOT-REDUNDANCY}
]
remains `open`.

No semantic defect was found. No theorem-domain internal inclusion-minimal cover was found. No uniform proof was obtained.

The strongest unconditional response theorem is the combination of:

1. the forced lower covered (N)-divisible owner;
2. the whole-fiber formula
   [
   B_{Nc}^p=\bigsqcup_{u\in A_c}P_u;
   ]
3. the exact nondivisible-owner position criterion inside each (P_u);
4. the explicit boundary map (r\mapsto\beta(r));
5. injectivity of (r\mapsto(\beta(r),z(r)));
6. the strict-margin transport implication.

The exact gap is the existence of monotone internal carriers satisfying the margin inequality. Lower-row coveredness does not supply that conclusion without further arithmetic.

---

## 12. Branch consequence

There is no unconditional branch closure from this response.

Conditionally on MBCP, and therefore conditionally on the branch theorem, one obtains exactly:

[
N\nmid p
\quad\Longrightarrow\quad
\text{no internal complete cover at }j_*.
]

Equivalently, every internal complete cover would contain a redundant owner.

For a hypothetical tuple with every pivot covered, all labels other than (j_*) form an internal complete cover at (j_*). Therefore, under the branch theorem,
[
N\nmid\max_i a_i
]
would be impossible. Any hypothetical all-covered tuple would have to satisfy
[
N\mid\max_i a_i.
]

The following remain open:

* the complementary (N\mid p) branch;
* full `MAX-COVERED-PIVOT-INTERNAL-COVER-REDUNDANCY`;
* unrestricted canonical pivot existence;
* positive-integer Lonely Runner;
* unrestricted positive-real Lonely Runner.

Common scaling does not remove the distinction because it can change (N\nmid p) into (N\mid dp).

---

## 13. Proof-obligation ledger

| Claim                                                          | Dependencies                                             | Evidence class             | Exact falsifier or open edge                                                     | Downstream owner      |
| -------------------------------------------------------------- | -------------------------------------------------------- | -------------------------- | -------------------------------------------------------------------------------- | --------------------- |
| Canonical pivot self-safety                                    | Definitions only                                         | `proved-math-response`     | An (r=Nq+s) violating (p\min(s,N-s)\ge p)                                        | Closed in response    |
| Three branch forms are equivalent                              | Finiteness and (R\ne\varnothing)                         | `proved-math-response`     | A finite complete cover with no minimal subcover                                 | Closed in response    |
| (t p) slice formula                                            | Modular multiplication by (p)                            | `proved-math-response`     | A residue with (\rho_{Np}(tpb)\ne p\rho_N(tb))                                   | Closed in response    |
| Complete branch cover forces lower covered (N)-divisible owner | Slice at (t=1), internality, maximality                  | `proved-math-response`     | Complete internal (C) with no (N)-divisible speed                                | Closed in response    |
| (N)-divisible owner is whole-fiber                             | (b=Nc), reduction modulo (p)                             | `proved-math-response`     | Two lifts over one (u) with different badness                                    | Closed in response    |
| Nondivisible fiber-position formula                            | (uh=pq+v), (\ell=q+kh\bmod N)                            | `proved-math-response`     | Badness at an interior (\ell\notin{0,N-1})                                       | Closed in response    |
| Augmented boundary map is injective                            | Diophantine relation (cr=pk+z)                           | `proved-math-response`     | Distinct canonical (r) with identical ((\beta,z))                                | Closed in response    |
| Strict-margin lower-to-upper transport                         | Circle triangle inequality                               | `proved-math-response`     | Margin holds but upper-row badness fails                                         | Closed in response    |
| Lower-row badness automatically transports                     | None sufficient                                          | `refuted-exact`            | ((5,11,20,25)), (r=1), (h=25)                                                    | Closed as false       |
| Row (i) supplies internal monotone carriers                    | Maximum hypothesis, internal minimality, row (i) covered | `conjectural`              | A theorem-domain minimal internal cover with no admissible (\kappa)              | Next arithmetic edge  |
| MBCP closes the branch                                         | Carrier map and descent key                              | `conditional`              | Failure of completeness, internality, or key decrease in the proved construction | Closed conditionally  |
| Branch theorem                                                 | MBCP or another uniform replacement argument             | `open`                     | Exact theorem-domain internal minimal cover                                      | Future branch work    |
| Height-(30) domain has no failure                              | Two independent exact verifiers                          | `computed finite evidence` | First differing or failing canonical record                                      | Finite audit complete |
| Full Prompt95 and LRC consequences                             | Complementary branch and other missing bridges           | `open`                     | Unresolved (N\mid p) case                                                        | Out of this branch    |

---

## 14. Declaration-level plan

Only the following statements survive this response as valid targets.

1. **CanonicalSlice**

   * Status: `proved-math-response`
   * Statement: exact formula for (r_t=tp), candidate membership, and (N\mid tb).

2. **DivisibleOwnerFiberDecomposition**

   * Status: `proved-math-response`
   * Statement:
     [
     B_{Nc}^p=\bigsqcup_{u\in A_c}P_u,
     ]
     with exact candidate-fiber cardinalities.

3. **OwnerPositionInPivotFiber**

   * Status: `proved-math-response`
   * Statement: the (\ell_k=0) or (\ell_k\in{0,N-1}) criterion.

4. **BoundaryProjection**

   * Status: `proved-math-response`
   * Statement: construction of (z,k,\varepsilon,\beta,\Delta), candidate preservation, and pivot-boundary equality.

5. **AugmentedBoundaryProjectionInjective**

   * Status: `proved-math-response`
   * Statement: (r\mapsto(\beta(r),z(r))) is injective, while (\beta) alone may collide.

6. **BoundaryMarginTransport**

   * Status: `proved-math-response`
   * Statement:
     [
     a_h\Delta<p\bigl(b-\rho_{Nb}(\beta a_h)\bigr)
     \Longrightarrow
     r\in B_h^{j_*}.
     ]

7. **MonotoneBoundaryCarrierPeeling**

   * Status: `conjectural`
   * Statement: MBCP exactly as stated in Section 9.

8. **MonotoneBoundaryCarrierPeelingImpliesBranch**

   * Status: `conditional`
   * Statement: MBCP yields a strictly descending (p-\nu(C)), hence no internal cover and therefore the branch redundancy theorem.

No Lean declaration should be promoted before MBCP itself survives an arithmetic audit.

---

## 15. Final evidence table

| Category                  | Object                                                                  | Status                     | Result                               |
| ------------------------- | ----------------------------------------------------------------------- | -------------------------- | ------------------------------------ |
| Accepted input            | Frozen canonical rows, covers, and theorem quantifiers                  | `input-accepted`           | Used exactly                         |
| Response proof            | Pivot self-safety and branch equivalences                               | `proved-math-response`     | Complete                             |
| Response proof            | (t p) slice and forced lower (N)-divisible owner                        | `proved-math-response`     | Complete                             |
| Response proof            | Whole-fiber and position formulas                                       | `proved-math-response`     | Complete                             |
| Response proof            | Boundary map, augmented injectivity, strict-margin transport            | `proved-math-response`     | Complete                             |
| Qualified proof           | Explicit carrier hypothesis permits peeling/replacement                 | `proved-math-qualified`    | Complete under stated hypotheses     |
| Exact refutation          | Automatic transport from row (i) to row (j_*)                           | `refuted-exact`            | Counterexample ((5,11,20,25))        |
| Finite computation        | (2\le n\le7), height (30)                                               | `computed finite evidence` | 586,979 branch tuples, zero failures |
| Conditional result        | MBCP implies the branch theorem                                         | `conditional`              | Proved                               |
| Proposed next edge        | MBCP carrier existence                                                  | `conjectural`              | Unproved                             |
| Main theorem              | `MAX-COVERED-NONDIVISIBLE-PIVOT-REDUNDANCY`                             | `open`                     | Neither proved nor refuted           |
| Lean                      | Formal declarations                                                     | `not-run`                  | No Lean attempted                    |
| Excluded programs         | Prompt94/95 responses, Prompt96, prime/product routes, unrestricted LRC | `out-of-scope`             | Not used                             |
| Complementary mathematics | (N\mid p), full Prompt95, pivot theorem, integer and real LRC           | `open`                     | Unchanged                            |

