## 1. **Disposition** - `STOP`

This is a semantic-contract stop. It does not supply a theorem-domain counterexample.

The unrestricted Prompt99 statement is **not genuinely narrower than full Prompt95**. For every tuple (a), common scaling by (N=n+1) preserves every canonical pivot row up to disjoint sheets, preserves (F(a)), preserves (j_\star), and preserves all labelled complete, minimal, internal, and private-cover data. The scaled tuple (Na) always satisfies
[
N\mid (Na_{j_\star}).
]

Consequently,
[
\boxed{\text{MAX-COVERED-DIVISIBLE-PIVOT-REDUNDANCY}
\iff
\text{full MAX-COVERED-PIVOT-INTERNAL-COVER-REDUNDANCY}.}
]

Therefore the frozen claims

[
\text{“Prompt99 closes only the (N\mid p) branch”}
]
and
[
\text{“Prompt99 alone does not prove full Prompt95”}
]

are `refuted-exact`.

The exact Prompt99 theorem itself remains `open`. No internal complete cover was found, and no unrestricted proof was obtained.

---

## 2. **Evidence boundary**

The canonical-row definitions in the prompt are `input-accepted`. No assertion from Prompt95, Prompt98, Prompt94, an ordinary pivot certificate, or unrestricted Lonely Runner was used.

The following are `proved-math-response`:

1. Candidate counting and pivot-owner safety.
2. Reflection parity and private-pair structure.
3. The exact (N)-sheet quotient.
4. Exact phase multiplicities.
5. The full-fiber formula for (N)-divisible owners.
6. A sharper phase-layer cardinality theorem.
7. Common-scaling invariance of all rows, (Q), (F), (j_\star), covers, minimality, internality, and privacy.
8. The equivalence of universal Prompt99 and full Prompt95 redundancy.

The fixtures and bounded search are `computed finite evidence`. Lean work is `not-run`.

Prompt98, full Prompt95, the pivot-certificate theorem, positive-integer LRC, and positive-real LRC remain `open` or `out-of-scope` as indicated below.

---

## 3. **Exact definitions**

Let (n\ge 2), (N=n+1), and let
[
a=(a_0,\ldots,a_{n-1})
]
be positive and injective.

For pivot label (j), put
[
p_j=a_j,\qquad M_j=Np_j,
]
[
\rho_M(z)=\min(z\bmod M,M-(z\bmod M)),
]
[
R_j={0\le r<M_j:N\nmid r},
]
and for (i\ne j),
[
B_i^j={r\in R_j:\rho_{M_j}(ra_i)<p_j}.
]
Strict equality (\rho_{M_j}(ra_i)=p_j) is safe.

Then
[
Q_j=R_j\setminus\bigcup_{i\ne j}B_i^j,
\qquad
F(a)={j:Q_j=\varnothing}.
]

Exactly
[
0,N,2N,\ldots,(p_j-1)N
]
are excluded, so
[
|R_j|=Np_j-p_j=np_j>0.
]

If (r=Nq+s), (1\le s\le N-1), then
[
rp_j\equiv sp_j\pmod{Np_j},
]
and hence
[
\rho_{Np_j}(rp_j)
=p_j\min(s,N-s)\ge p_j.
]
Thus the pivot label itself never covers a candidate, including equality cases.

When (F(a)\ne\varnothing), injectivity gives a unique label (j_\star\in F(a)) satisfying
[
p=a_{j_\star}=\max{a_j:j\in F(a)}.
]

For
[
C\subseteq \operatorname{Fin}n\setminus{j_\star},
]
write
[
U_C=\bigcup_{i\in C}B_i^{j_\star}.
]
Then (C) is complete exactly when (U_C=R_{j_\star}), internal exactly when
[
C\subseteq F(a)\setminus{j_\star},
]
and inclusion-minimal exactly when every
[
\operatorname{Priv}(C,i)
========================

B_i^{j_\star}\setminus
\bigcup_{\substack{h\in C\h\ne i}}B_h^{j_\star}
]
is nonempty.

For finite work, tuples were ordered first by dimension and then lexicographically. Labels and residues were increasing. Subsets were ordered first by cardinality and then lexicographically.

### Reflection parity

Let (M=Np) and suppose (N\mid p). Reflection
[
\iota(r)=(-r)\bmod M
]
preserves (R) and every (B_i^{j_\star}).

Its possible fixed residues are (0) and, when (M) is even, (M/2). The residue (0) is excluded. If (M) is even, then (p) is even:

* if (N) is even, (p=Nd) is even;
* if (N) is odd, (M=Np) even forces (p) even.

Therefore
[
M/2=N(p/2)
]
is also excluded. Reflection has no fixed candidate.

Every private set is therefore a disjoint union of pairs
[
{r,M-r}.
]
A nonempty private set has even cardinality and a unique least representative in the canonical lower half.

---

## 4. **Branch equivalences**

Let
[
I=F(a)\setminus{j_\star}.
]

The following are equivalent:

1. Every complete (C\subseteq I) has a deletable label.
2. No inclusion-minimal complete (C\subseteq I) exists.
3. No complete (C\subseteq I) exists.
4. The full internal owner union is incomplete:
   [
   \bigcup_{i\in I}B_i^{j_\star}\ne R_{j_\star}.
   ]

Proof:

* (3\Rightarrow1) and (3\Rightarrow2) are vacuous.
* If a complete internal (C) exists, repeatedly delete a redundant label whenever possible. Finiteness produces an inclusion-minimal complete internal subset. Thus (2\Rightarrow3).
* If every complete (C) had a deletion, repeated deletion would eventually make the empty set complete. This is impossible because (|R_{j_\star}|=np>0). Thus (1\Rightarrow3).
* Every internal subset is contained in (I). Hence some internal subset covers exactly when the full internal union covers.

The coverwise quantifier and both no-internal-cover forms are therefore exactly equivalent.

---

## 5. **Quotient structure**

Assume
[
p=Nd,\qquad M=Np=N^2d.
]
Define
[
S={0\le x<p:N\nmid x}.
]

### Unique fibers and candidate preservation

Every (0\le r<M) has a unique representation
[
r=x+kp,\qquad 0\le x<p,\quad 0\le k<N.
]

Since (N\mid p),
[
N\mid(x+kp)\iff N\mid x.
]
Therefore
[
R=\bigsqcup_{x\in S}{x,x+p,\ldots,x+(N-1)p},
]
and
[
\pi:R\to S,\qquad \pi(x+kp)=x
]
is exactly (N)-to-one.

### Phase identity and multiplicity

For an owner speed (b),
[
(x+kp)b=xb+pkb.
]
Changing (kb) by a multiple of (N) changes the right side by a multiple of (Np=M), so
[
(x+kp)b\equiv xb+p(kb\bmod N)\pmod M.
]

Let
[
h=\gcd(N,b).
]
The homomorphism
[
k\mapsto kb\pmod N
]
has kernel of cardinality (h), and its image consists of the (N/h) multiples of (h). Each image phase occurs exactly (h) times.

### Full-fiber owners

If (b=Nc), then
[
(x+kp)b=Nxc+kNcp
\equiv Nxc\pmod{Np}.
]
For every integer (y),
[
\rho_{Np}(Ny)=N\rho_p(y),
]
because reduction modulo (Np) of a multiple of (N) is (N) times reduction modulo (p). Hence
[
\rho_M((x+kp)b)=N\rho_p(xc).
]
Therefore
[
x+kp\in B_b^{j_\star}
\iff
\rho_p(xc)<d.
]

This is independent of (k). An (N)-divisible owner is a union of complete (\pi)-fibers.

Equality
[
\rho_p(xc)=d
]
gives
[
\rho_M((x+kp)b)=Nd=p,
]
so every lift remains safe.

### Exact phase-layer cardinality

For fixed (x\in S), write
[
xb\equiv u+pq\pmod{Np},
\qquad
0\le u<p,\quad q\in\mathbb Z/N\mathbb Z.
]
For lift (k), the phase sector is
[
q+kb\pmod N.
]

If (u=0), strict badness occurs only in sector (0). Sector (N-1) has distance exactly (p) and is safe.

If (0<u<p), strict badness occurs exactly in sectors (0) and (N-1). Thus, with
[
K_b(x)={k\in\mathbb Z/N\mathbb Z:x+kp\in B_b^{j_\star}},
]
one has
[
K_b(x)=
\begin{cases}
{k:kb\equiv-q\pmod N},&u=0,[1mm]
{k:kb\equiv-q\text{ or }-q-1\pmod N},&0<u<p.
\end{cases}
]

Consequently:

[
|K_b(x)|=
\begin{cases}
1\text{ or }2,&h=1,\
0\text{ or }h,&1<h<N,\
0\text{ or }N,&h=N.
\end{cases}
]

For (1<h<N), the two target phases are consecutive, while two distinct multiples of (h) cannot be consecutive.

In particular:

[
\boxed{\text{No non-(N)-divisible owner contains a complete (\pi)-fiber.}}
]

Only an owner with (N\mid b) can cover all (N) lifts of one base point.

---

## 6. **Fixture ledger**

### Covered pivots and maximum rows

Here (m(q)) denotes ((|Q_q|,\min Q_q)), with the minimum omitted when (Q_q=\varnothing).

| Tuple                   | Literal (Q)-audit                                                                        | (F(a)), (j_\star)             | Maximum-row result                                                                 |
| ----------------------- | ---------------------------------------------------------------------------------------- | ----------------------------- | ---------------------------------------------------------------------------------- |
| ((1,6,11,12,13))        | (m(1)=(0),m(6)=(0),m(11)=(8,13),m(12)=(8,15),m(13)=(10,16))                              | (F={1,6}), (j_\star=6)        | Unique minimal cover ({1,11,12,13}); internal set ({1}); 20 gaps, least (7)        |
| ((6,7,12,24,144))       | (Q_6=Q_7=Q_{12}=Q_{24}=\varnothing); (m(144)=(160,25))                                   | (F={6,7,12,24}), (j_\star=24) | Unique minimal cover ({144}); internal set ({6,7,12}); 48 gaps, least (4)          |
| ((1,8,13,15,27,28))     | (Q_1=Q_8=\varnothing); (m(13)=(8,15),m(15)=(14,18),m(27)=(26,32),m(28)=(22,33))          | (F={1,8}), (j_\star=8)        | Outside Prompt99; unique minimal cover ({1,13,15,27,28}); internal gap (8)         |
| ((7,56,91,105,189,196)) | (Q_7=Q_{56}=\varnothing); (m(91)=(56,15),m(105)=(98,18),m(189)=(182,32),m(196)=(154,33)) | (F={7,56}), (j_\star=56)      | Unique minimal cover ({7,91,105,189,196}); internal set ({7}); 252 gaps, least (8) |

### Small divisible maximum

At (p=6), (M=36),
[
R={0\le r<36:6\nmid r}.
]
The labelled bad sets are
[
B_1={1,2,3,4,5,31,32,33,34,35},
]
[
B_{11}={3,7,10,13,16,20,23,26,29,33},
]
[
B_{12}={3,9,15,21,27,33},
]
[
B_{13}={3,8,11,14,17,19,22,25,28,33}.
]

Their private sets relative to the full cover are respectively
[
{1,2,4,5,31,32,34,35},
]
[
{7,10,13,16,20,23,26,29},
]
[
{9,15,21,27},
]
[
{8,11,14,17,19,22,25,28}.
]
Thus every label is necessary and the cover is unique and inclusion-minimal.

The internal owner (1) misses (7). It is phase-dependent. For every (x\in{1,2,3,4,5}), owner (1) covers only lifts (k=0,5).

### Stress fixture

At (p=24), (M=144),
[
B_{144}=R
]
because (144r\equiv0\pmod{144}). Therefore ({144}) is complete.

The full internal set is incomplete at (r=4):
[
\rho_{144}(4\cdot6)=24,
]
[
\rho_{144}(4\cdot7)=28,
]
[
\rho_{144}(4\cdot12)=48.
]
The first value is equality and is safe. Since all remaining owners are internal, no cover excluding (144) is complete. Thus ({144}) is the unique minimal cover.

The residue (r=p=24) is excluded because (6\mid24).

### Scaling pair

For the base pivot (8), (M=56), the private sets of the unique cover are
[
\operatorname{Priv}(1)={1,3,5,51,53,55},
]
[
\operatorname{Priv}(13)={9,13,17,39,43,47},
]
[
\operatorname{Priv}(15)={11,15,19,37,41,45},
]
[
\operatorname{Priv}(27)={23,25,27,29,31,33},
]
[
\operatorname{Priv}(28)=
{8,10,12,16,18,20,24,32,36,38,40,44,46,48}.
]

After scaling by (7), every bad set and private set is the union of its seven translates by (56). This proves the stated unique cover at (p=56) and the unchanged least internal gap (8).

### Quotient bases and all lifts

For ((1,6,11,12,13)):
[
S=(1,2,3,4,5),
]
and for every listed (x),
[
L_x=(x,x+6,x+12,x+18,x+24,x+30).
]

For ((6,7,12,24,144)):
[
S=(1,2,3,4,5,7,8,9,10,11,13,14,15,16,17,19,20,21,22,23),
]
and
[
L_x=(x,x+24,x+48,x+72,x+96,x+120).
]

For ((7,56,91,105,189,196)):
[
\begin{aligned}
S={}&(1,2,3,4,5,6,8,9,10,11,12,13,15,16,17,18,19,20,\
&22,23,24,25,26,27,29,30,31,32,33,34,36,37,38,39,40,41,\
&43,44,45,46,47,48,50,51,52,53,54,55),
\end{aligned}
]
and
[
L_x=(x,x+56,x+112,x+168,x+224,x+280,x+336).
]

### Phase controls

For (N=6):

[
b=1:\quad (kb\bmod6)_{k=0}^5=(0,1,2,3,4,5),
]
[
b=11:\quad (0,5,4,3,2,1),
]
[
b=12:\quad (0,0,0,0,0,0),
]
[
b=13:\quad (0,1,2,3,4,5).
]

At (p=24):
[
b=6,12,144
]
have constant zero phases, while
[
b=7
]
visits all six phases.

An intermediate-gcd control is (N=4,p=4,b=2,x=1):
[
L_1=(1,5,9,13),
]
[
(kb\bmod4)=(0,2,0,2),
]
[
\rho_{16}(2L_1)=(2,6,2,6),
]
so the bad pattern is
[
(\mathrm{true},\mathrm{false},\mathrm{true},\mathrm{false}).
]

### Strict quotient equality

For (N=6,p=24,d=4,b=6=N\cdot1,x=4),
[
\rho_{24}(4)=4=d.
]
All six lifts (4+24k) have distance (24=p), so all are safe.

### Projection-only false positive

For full-fiber owner (6),
[
A_6={x\in S:\rho_{24}(x)<4}
={1,2,3,21,22,23}.
]

Owner (7) has projection equal to all of (S), so
[
A_6\subseteq\pi(B_7).
]
But at (x=1,k=1),
[
r=25,\qquad
\rho_{144}(25\cdot7)=31\ge24.
]
Thus
[
25\in\pi^{-1}(A_6)\setminus B_7.
]
Projection inclusion does not lift phasewise.

### Strictness, collision, nonunit, and malformed controls

* For ((1,3,4,5)), pivot (3), (M=15), candidate (r=3):
  [
  \rho_{15}(3\cdot1)=3,
  ]
  so it is safe.
* For ((1,4,17)), pivot (4), (M=16):
  [
  B_1=B_{17}={1,2,3,13,14,15},
  ]
  while the two labels remain distinct.
* For ((1,2,3)), pivot (3), (M=12), candidates (3) and (9) are retained nonunits.
* Antipodes (18,72,196) in the three divisible fixtures are multiples of (6,6,7), respectively, and are excluded.
* ((0,1,2)), ((1,1,2)), a pivot owner in its own cover, an invalid pivot label, a wrong (j_\star), weak badness, and altered phase or gap expectations were rejected.
* The pivot (7) of ((6,7,12,24,144)) was classified as transport-only and not as a Prompt99 maximum pivot.

---

## 7. **Lane A**

For each owner (b) and base (x\in S), define its phase layer
[
K_b(x)={k:x+kp\in B_b^{j_\star}}.
]

The phase-layer theorem gives the uniform weight
[
w_N(b)=
\begin{cases}
2,&\gcd(N,b)=1,\
\gcd(N,b),&1<\gcd(N,b)<N,\
N,&N\mid b,
\end{cases}
]
with
[
|K_b(x)|\le w_N(b).
]

Therefore, for any owner set (C),
[
\left|\bigcup_{b\in C}K_b(x)\right|
\le
\sum_{b\in C}w_N(b).
]

A proved divisor-layer obstruction is:

[
\boxed{
\sum_{b\in C}w_N(b)<N
\quad\Longrightarrow\quad
C\text{ is incomplete}.
}
]

This applies independently in every fiber. In particular, any complete cover with no (N)-divisible owner must satisfy
[
\sum_{b\in C}w_N(b)\ge N.
]

For a full-fiber owner (f=Nc), put
[
A_f={x\in S:\rho_p(xc)<d}.
]
Deleting (f) is valid exactly when
[
\forall x\in A_f,\qquad
\bigcup_{b\in C\setminus{f}}K_b(x)=\mathbb Z/N\mathbb Z.
]
Equivalently,
[
\pi^{-1}(A_f)
\subseteq
\bigcup_{b\in C\setminus{f}}B_b^{j_\star}.
]

The first unsupported inclusion is precisely this all-phase statement. Minimality only supplies one private lift for (f); it does not force another owner to cover every phase of that fiber. Projection coverage
[
A_f\subseteq\bigcup_b\pi(B_b)
]
is insufficient, as the explicit (b=6), (b=7), (x=1), (k=1) control proves.

When (C) has no (N)-divisible owner, the full-fiber quotient gives no owner that can be peeled. The unresolved case starts at phase-capacity saturation
[
\sum_{b\in C}w_N(b)\ge N.
]

---

## 8. **Lane B**

### Common-scaling theorem

For an integer (t\ge1), define
[
a^{(t)}_i=t a_i.
]

Fix pivot (j), and abbreviate
[
p=a_j,\qquad M=Np.
]
The scaled pivot has
[
p^{(t)}=tp,\qquad M^{(t)}=tM.
]

Every scaled residue is uniquely
[
r'=qM+r,
\qquad
0\le q<t,\quad 0\le r<M.
]
Since (N\mid M),
[
N\mid r'\iff N\mid r.
]
Thus
[
R_j(a^{(t)})
============

\bigsqcup_{q=0}^{t-1}
\bigl(qM+R_j(a)\bigr).
]

For owner (i),
[
r',a_i^{(t)}
=(qM+r)t a_i
=q a_i(tM)+t r a_i
\equiv t r a_i\pmod{tM}.
]

If (u=ra_i\bmod M), then
[
t r a_i\bmod tM=tu,
]
and
[
\rho_{tM}(tu)
=t\rho_M(u).
]
Therefore
[
\rho_{tM}(r'a_i^{(t)})<tp
\iff
\rho_M(ra_i)<p.
]

Hence, label by label,
[
B_i^j(a^{(t)})
==============

\bigsqcup_{q=0}^{t-1}
\bigl(qM+B_i^j(a)\bigr),
]
and
[
Q_j(a^{(t)})
============

\bigsqcup_{q=0}^{t-1}
\bigl(qM+Q_j(a)\bigr).
]

It follows immediately that
[
F(a^{(t)})=F(a)
]
as a set of labels. Multiplication by (t>0) preserves the order of speeds, so the maximum covered label is unchanged:
[
j_\star(a^{(t)})=j_\star(a).
]

For every labelled owner subset (C),
[
C\text{ covers the original row}
\iff
C\text{ covers the scaled row}.
]
The same sheet identity gives equivalence of inclusion-minimality, internality, and private sets:
[
\operatorname{Priv}_{a^{(t)}}(C,i)
==================================

\bigsqcup_{q=0}^{t-1}
\left(qM+\operatorname{Priv}_a(C,i)\right).
]

### Scope collapse

Let (\mathsf{Red}(a)) denote the no-internal-complete-cover conclusion at the maximum covered pivot.

Full Prompt95 is
[
\forall a,\quad F(a)\ne\varnothing\Longrightarrow\mathsf{Red}(a).
]

Prompt99 is
[
\forall a,\quad
F(a)\ne\varnothing\ \land\ N\mid a_{j_\star}
\Longrightarrow
\mathsf{Red}(a).
]

Full Prompt95 trivially implies Prompt99.

Conversely, assume Prompt99 and take an arbitrary (a) with (F(a)\ne\varnothing). Set
[
a'=a^{(N)}=Na.
]
Then
[
F(a')=F(a),\qquad
j_\star(a')=j_\star(a),
]
and
[
a'*{j*\star}=N a_{j_\star},
]
so (N\mid a'*{j*\star}). Prompt99 applied to (a') gives (\mathsf{Red}(a')). Scaling invariance gives
[
\mathsf{Red}(a')\iff\mathsf{Red}(a).
]
Thus full Prompt95 follows.

Therefore
[
\boxed{\text{Prompt99}\iff\text{full Prompt95}.}
]

This uses no result from Prompt98.

### Actual (p/N) descent

If every speed is divisible by a common integer (g), division by (g) is the inverse of common scaling and preserves all cover data. This gives a valid descent to a primitive tuple.

Dividing only (p) and selected (N)-divisible owners is invalid in general. The formal pivot (d=p/N) need not be present, quotient coefficients can collide with existing speeds, and no equality of (F) or (j_\star) follows. The first failed premise is therefore tuple-domain preservation, before any lift-back argument.

---

## 9. **Lane C**

For
[
a=(6,7,12,24,144),
]
consider the lower pivot (7), where (M=42).

The relevant bad sets are
[
B_6=
{1,7,8,13,14,15,20,21,22,27,28,29,34,35,41},
]
[
B_{12}=
{3,4,7,10,11,14,17,21,25,28,31,32,35,38,39},
]
and
[
B_{24}=B_{144}
==============

{2,5,7,9,14,16,19,21,23,26,28,33,35,37,40}.
]

Both
[
{6,12,24}
\quad\text{and}\quad
{6,12,144}
]
are complete and inclusion-minimal.

For the first cover, the private sets are
[
\operatorname{Priv}(6)=
{1,8,13,15,20,22,27,29,34,41},
]
[
\operatorname{Priv}(12)=
{3,4,10,11,17,25,31,32,38,39},
]
[
\operatorname{Priv}(24)=
{2,5,9,16,19,23,26,33,37,40}.
]

Thus the maximum-pivot label (24) is essential in a legitimate lower-pivot cover and cannot be silently deleted.

At the actual maximum covered pivot (24), the internal owners (6,7,12) fail on (r=4). Hence coveredness of pivot (7) supplies no literal inclusion
[
B_7^{24}
\subseteq
B_6^{24}\cup B_{12}^{24}
]
or any replacement inclusion derived from its lower-row covers.

The first failed transport is therefore exact: a lower-pivot cover can require (j_\star), while (j_\star) is forbidden as an owner at its own row. No residue map preserving labels, exclusions, strictness, and both cyclic sides was obtained.

---

## 10. **Lane D**

The proposed branch-specific well-founded descent is obstructed by common scaling.

Any full-Prompt95 counterexample (a), whether or not (N\mid a_{j_\star}), produces the Prompt99-domain counterexample
[
Na.
]
Conversely, every Prompt99 counterexample is already a full-Prompt95 counterexample. Thus a descent that purports to resolve only the divisible branch must, under the current unnormalized quantifiers, resolve the full theorem.

A genuinely narrower divisibility split would first have to normalize by
[
\gcd(a_0,\ldots,a_{n-1})=1.
]
No such premise occurs in Prompt99.

### Independent finite replay

Two independent CPython 3.13.5 implementations completed the frozen domain

[
2\le n\le7,\qquad
1\le a_0<\cdots<a_{n-1}\le20.
]

Counts:

| Quantity                                |     Result |
| --------------------------------------- | ---------: |
| Raw tuples                              |    137,959 |
| Primitive tuples                        |    136,938 |
| Raw tuples with (F\ne\varnothing)       |     35,168 |
| Primitive tuples with (F\ne\varnothing) |     34,855 |
| Raw Prompt99-domain tuples              |         65 |
| Primitive Prompt99-domain tuples        |         49 |
| First theorem-domain failure            |       none |
| Completion marker                       | `COMPLETE` |

Implementation A enumerated canonical rows, labelled bad sets, (Q), (F), (j_\star), all internal subsets, minimality, and private sets. It checked 94 internal subsets in the theorem domain.

Implementation B independently constructed quotient bases, every lift, every owner phase, and the internal union directly on lifted residues. It checked 1,974 theorem-domain lifted candidates.

Both produced the identical branch-trace hash

```text
30bf46729172a1763ad2038008d7212510e6e244bd1229a911479df38cc54834
```

There was no first disagreement and no first malformed failure. Identical replay outputs were obtained.

Source and output hashes:

```text
82162f3855c8f4ff57499d87ec8ea8307dac99476a4cfdd47837cb7693d2af8f  prompt99_verifier_a.py
fbf15a2e6f10b29e330a292659d72a3732d4496c0a76f06a709fa7e39a43d08e  prompt99_verifier_a.json
43d2c8d841e7d34a609778214151c24012e6426845b7eef1252abaa2689605fd  prompt99_verifier_b.py
2d72bdc10cdf8e4b365f5d457bad9aa3021d62565bbdcedb0bdd3b1fd149f82c  prompt99_verifier_b.json
```

Artifacts:

[Implementation A](sandbox:/mnt/data/prompt99_verifier_a.py)
[Implementation A output](sandbox:/mnt/data/prompt99_verifier_a.json)
[Implementation B](sandbox:/mnt/data/prompt99_verifier_b.py)
[Implementation B output](sandbox:/mnt/data/prompt99_verifier_b.json)

The zero-failure result is `computed finite evidence` only.

---

## 11. **Sole theorem**

The exact theorem

[
\text{MAX-COVERED-DIVISIBLE-PIVOT-REDUNDANCY}
]

remains `open` at every frozen quantifier. No theorem-domain internal complete cover was found, but bounded zero failures do not prove it.

The following uniform theorem is fully proved in this response:

[
\boxed{
\begin{aligned}
&F(a^{(t)})=F(a),\
&j_\star(a^{(t)})=j_\star(a),\
&C\text{ is complete/minimal/internal for }a\
&\qquad\iff
C\text{ is complete/minimal/internal for }a^{(t)}.
\end{aligned}}
]

As a consequence,
[
\boxed{\text{universal Prompt99}\iff\text{full Prompt95 redundancy}.}
]

Therefore the required assertion that a proof of Prompt99 would have only a divisible-branch consequence cannot be maintained. This is the semantic defect triggering `STOP`.

---

## 12. **Dependency map**

The corrected dependency map is

```text
Prompt99 theorem
  <-> full MAX-COVERED-PIVOT-INTERNAL-COVER-REDUNDANCY.
```

The reverse implication is restriction. The forward implication is common scaling by (N).

Therefore Prompt98 is not needed to derive full Prompt95 from Prompt99. The proposed conjunction

```text
Prompt98 + Prompt99 -> full Prompt95
```

is true but nonminimal, because Prompt99 alone would already imply full Prompt95.

No such theorem has been proved here. The downstream chain remains only `conditional`:

```text
full Prompt95, if independently proved
  -> canonical pivot certificate
  -> positive-integer LRC
  -> unrestricted positive-real LRC.
```

Prompt99, full Prompt95, the pivot theorem, and both LRC statements remain `open`.

---

## 13. **Proof-obligation ledger**

| Claim                                   | Dependencies                    | Evidence class             | Direct falsifier                              | First open edge                   | Downstream owner                 |      |                   |
| --------------------------------------- | ------------------------------- | -------------------------- | --------------------------------------------- | --------------------------------- | -------------------------------- | ---- | ----------------- |
| (                                       | R_j                             | =np_j>0)                   | Canonical definitions                         | `proved-math-response`            | Incorrect count of (N)-multiples | none | row formalization |
| Pivot owner is safe                     | (r=Nq+s) decomposition          | `proved-math-response`     | Candidate with strict distance (<p_j)         | none                              | pivot-certificate identification |      |                   |
| Reflection has no candidate fixed point | (N\mid p)                       | `proved-math-response`     | Retained (0) or (M/2)                         | none                              | private-pair formalization       |      |                   |
| Exact (N)-sheet quotient                | (p=Nd)                          | `proved-math-response`     | Nonunique (x+kp), changed candidate exclusion | none                              | quotient formalization           |      |                   |
| Phase multiset                          | Elementary cyclic homomorphism  | `proved-math-response`     | Wrong image or multiplicity                   | none                              | divisor layers                   |      |                   |
| Full-fiber owner identity               | (b=Nc)                          | `proved-math-response`     | Fiber-dependent membership                    | none                              | quotient peeling                 |      |                   |
| Phase-layer cardinality                 | Phase-sector analysis           | `proved-math-response`     | Nondivisible owner covering all (N) lifts     | none                              | capacity obstruction             |      |                   |
| Weight-sum obstruction                  | Phase-layer cardinality         | `proved-math-response`     | Complete fiber with total weight (<N)         | none                              | Lane A                           |      |                   |
| Projection-only lifting                 | None                            | `refuted-exact`            | (N=6,p=24,b=6,7,x=1,k=1)                      | all-phase inclusion               | Lane A                           |      |                   |
| Formal quotient is a valid tuple row    | None                            | `open`                     | Missing speed (d), collision, changed (F)     | tuple construction                | Lane B                           |      |                   |
| Lower-pivot cover exchange              | Coveredness of owner pivot      | `open`                     | Stress fixture (r=4) and essential owner (24) | literal residue transport         | Lane C                           |      |                   |
| Common-scaling invariance               | Canonical rows                  | `proved-math-response`     | Failure of sheet identities                   | none                              | scope audit                      |      |                   |
| Prompt99 is narrower than Prompt95      | Frozen dependency claim         | `refuted-exact`            | Scaling by (N)                                | none                              | contract owner                   |      |                   |
| Prompt99 theorem                        | All preceding definitions       | `open`                     | Internal complete cover                       | saturated phase exchange/full P95 | Prompt99                         |      |                   |
| Fixture values                          | Literal enumeration             | `computed finite evidence` | Verifier mismatch                             | none in fixtures                  | preflight                        |      |                   |
| Bounded zero failures                   | Two independent implementations | `computed finite evidence` | First domain failure                          | unrestricted quantifier           | none                             |      |                   |
| Lean formalization                      | Arithmetic proof first          | `not-run`                  | compilation or theorem defect                 | declaration implementation        | Lean owner                       |      |                   |
| Prompt98                                | Separate contract               | `open`                     | independent proof/counterexample              | separate work                     | Prompt98                         |      |                   |
| Pivot certificate and LRC chain         | Full Prompt95                   | `conditional`              | failure of upstream implication               | full Prompt95                     | downstream                       |      |                   |
| Unrestricted LRC proof                  | None supplied                   | `out-of-scope`             | N/A                                           | full upstream program             | separate program                 |      |                   |

---

## 14. **Declaration-level plan**

Only the following statements survive this response and are suitable for later formalization:

1. `candidate_cardinality`:
   [
   |R_j|=np_j.
   ]

2. `pivot_owner_not_bad`:
   [
   r\in R_j\Longrightarrow
   \rho_{Np_j}(rp_j)\ge p_j.
   ]

3. `divisible_antipode_excluded` and `private_reflection_pairs`.

4. `quotient_unique_lift`:
   [
   R\simeq S\times\operatorname{Fin}N.
   ]

5. `quotient_phase_identity` and `phase_multiset_count`.

6. `divisible_owner_full_fiber`:
   [
   x+kp\in B_{Nc}
   \iff
   \rho_p(xc)<d.
   ]

7. `fiber_bad_phase_characterization`:
   the one-sector/two-sector formula for (K_b(x)).

8. `nondivisible_owner_not_full_fiber`.

9. `phase_weight_obstruction`:
   [
   \sum_{b\in C}w_N(b)<N
   \Longrightarrow
   C\text{ incomplete}.
   ]

10. `scale_row_equiv`, `scale_Q_equiv`, `scale_F_eq`,
    `scale_cover_iff`, `scale_minimal_iff`, and `scale_private_eq`.

11. `prompt99_iff_full_prompt95`.

A genuinely narrower successor must normalize common scaling, for example by adding
[
\gcd(a_0,\ldots,a_{n-1})=1
]
before splitting according to (N\mid p). Without such normalization, the divisible branch is universal up to scaling.

---

## 15. **Final evidence table**

| Item                                                 | Final label                |
| ---------------------------------------------------- | -------------------------- |
| Frozen canonical definitions                         | `input-accepted`           |
| Candidate count and pivot-owner safety               | `proved-math-response`     |
| Reflection/private-pair theorem                      | `proved-math-response`     |
| Exact quotient and phase identities                  | `proved-math-response`     |
| Full-fiber formula                                   | `proved-math-response`     |
| Phase-layer cardinality and weight obstruction       | `proved-math-response`     |
| Common-scaling invariance                            | `proved-math-response`     |
| Prompt99 (\iff) full Prompt95 redundancy             | `proved-math-response`     |
| Claim that Prompt99 closes only the divisible branch | `refuted-exact`            |
| Projection-only lift rule                            | `refuted-exact`            |
| Mandatory fixtures                                   | `computed finite evidence` |
| Exhaustive domain (2\le n\le7,\ \max a_i\le20)       | `computed finite evidence` |
| Prompt99 theorem                                     | `open`                     |
| Full Prompt95                                        | `open`                     |
| Prompt98                                             | `open`                     |
| Lean proof                                           | `not-run`                  |
| Downstream pivot/LRC implications                    | `conditional`              |
| Unrestricted LRC                                     | `out-of-scope`             |
