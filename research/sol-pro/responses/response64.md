# 1. Exact status table

| Class                         | Item                                                                                                                  |                                             Status | Exact scope                                                                                                                         |
| ----------------------------- | --------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------: | ----------------------------------------------------------------------------------------------------------------------------------- |
| Project input                 | Canonical pivot candidates, strict bad sets, pivot-coordinate safety, certificate-to-real-witness bridge              |                                      `proved-lean` | Existing project results at the closed (1/N) endpoint.                                                                              |
| Project input                 | Fastest-pivot ratio certificate                                                                                       |                                      `proved-lean` | The numerator (N-1) works under its stated pointwise ratio hypotheses.                                                              |
| Project input                 | Exact fastest-pivot extremal-interval certificate and compression dichotomy                                           |                                      `proved-lean` | If no fastest-pivot certificate exists, the ceiling/floor interval is empty or is a divisible singleton. The endpoints are closed.  |
| Project input                 | Exact single bad-set cardinalities and pair/triple generalized-CRT intersections                                      |                                      `proved-lean` | Existing project scope only.                                                                                                        |
| Project input                 | Affine common-LCM fiber identities and quotient lifts                                                                 |                                      `proved-math` | Audited mathematics, not promoted to Lean status here.                                                                              |
| Project input                 | Response 62 finite replay                                                                                             |                         `computed finite evidence` | 8,108 rows, most outside (NA<2B).                                                                                                   |
| New                           | Equivalence of the target implication and its natural-number contrapositive                                           |                                      `proved-math` | Fully proved in Section 2.                                                                                                          |
| New                           | Common positive scaling invariance of `TopTwo`, the strict ratio, and `TopCert`                                       |                                      `proved-math` | Both directions, including reduction of a scaled numerator modulo the unscaled pivot modulus.                                       |
| New                           | Invariance under arbitrary reindexing of `Fin n`                                                                      |                                      `proved-math` | Transfers explicit (j_A,j_B), `TopTwo`, and both pivot certificates.                                                                |
| New                           | `TOP-TWO-LARGE-RATIO-EXCLUSION` for (n=2)                                                                             |                                      `proved-math` | In fact, the (B)-pivot alone always succeeds when (3A<2B).                                                                          |
| New                           | Exact (kB\pm d) residue-block formulas under (NA<2B)                                                                  |                                      `proved-math` | These formulas do not supply a uniform selector.                                                                                    |
| New                           | The target would imply a (1/(m+2)) witness for every positive injective (m)-tuple                                     | `proved-math` reduction; `conditional` consequence | Obtained by appending (B=(m+2)A). This is weaker than the (1/(m+1)) Lonely Runner threshold.                                        |
| Finite audit                  | Complete declared primitive box (2\le n\le8), (B\le64), (NA<2B)                                                       |                         `computed finite evidence` | 247,020 primitive rows; no two-top-grid cover. The (B)-pivot succeeded on every row.                                                |
| Finite audit                  | Fixed equality, scaling, reindexing, CRT, sparse, divisibility, affine, deletion, consecutive, and named-stress suite |                         `computed finite evidence` | 61 cases, 45 in the strict branch; no two-top-grid cover.                                                                           |
| Rejected strengthening        | The (A)-pivot grid is always nonempty in the strict branch                                                            |                                         `rejected` | Exact failure at ((1,2,8)).                                                                                                         |
| Rejected strengthening        | The fastest-pivot extremal interval is always nonexceptional in the strict branch                                     |                                         `rejected` | Exact failure at ((1,3,8)).                                                                                                         |
| Rejected strengthening        | Some (B)-pivot certificate always lies in the bounded family (kB\pm d), (0\le k<N), (1\le d\le\lfloor N/2\rfloor)     |                                         `rejected` | Exact failure at ((4,5,12)), although a full (B)-pivot certificate exists at (r=3).                                                 |
| Remaining arithmetic transfer | No (B)-pivot certificate under (NA<2B) forces an (A)-pivot certificate                                                |                                             `open` | This is the exact first unsupported branch after the proved fastest-pivot compression.                                              |
| Primary target                | `TOP-TWO-LARGE-RATIO-EXCLUSION`                                                                                       |                                             `open` | No counterexample in the declared domains, but no dimension-uniform proof.                                                          |
| Downstream                    | `RESIDUAL-2N-SHIFT-OWNER-TRANSVERSAL`                                                                                 |                             `conjectural` / `open` | Not used as a Prompt 64 hypothesis.                                                                                                 |
| Global                        | Unrestricted Lonely Runner                                                                                            |                                             `open` | No status change.                                                                                                                   |

There is no new `proved-lean` result in this turn.

---

# 2. Target theorem, contrapositive, and exact equivalence

Let (n,N\in\mathbb N), let (2\le n), and put (N=n+1). Let

[
\mathrm{speeds}:\operatorname{Fin} n\to\mathbb N
]

be positive and injective. For (j_A,j_B:\operatorname{Fin} n), put

[
A=\mathrm{speeds}(j_A),\qquad B=\mathrm{speeds}(j_B).
]

The top-two hypothesis is exactly

[
\begin{aligned}
\operatorname{TopTwo}(\mathrm{speeds},j_A,j_B)\iff{}&
j_A\ne j_B\
&\land A<B\
&\land \forall i:\operatorname{Fin}n,\ i\ne j_B\to \mathrm{speeds}(i)\le A.
\end{aligned}
]

For (P>0), define

[
\rho_M(x)=\min(x\bmod M,\ M-(x\bmod M)).
]

The complete certificate predicate is

[
\begin{aligned}
\operatorname{TopCert}(\mathrm{speeds},j)\iff
\exists r\in\mathbb N,\quad&
r<N\cdot \mathrm{speeds}(j)\
&\land N\nmid r\
&\land \forall i:\operatorname{Fin}n,\
\mathrm{speeds}(j)\le
\rho_{N\cdot\mathrm{speeds}(j)}
(r\cdot\mathrm{speeds}(i)).
\end{aligned}
]

The pivot coordinate remains in the universal quantifier.

## Target

[
\boxed{
NA<2B\quad\Longrightarrow\quad
\operatorname{TopCert}(\mathrm{speeds},j_A)
\lor
\operatorname{TopCert}(\mathrm{speeds},j_B).
}
]

All ambient positivity, injectivity, dimension, and `TopTwo` hypotheses are universally quantified.

## Contrapositive

[
\boxed{
\neg\operatorname{TopCert}(\mathrm{speeds},j_A)
\land
\neg\operatorname{TopCert}(\mathrm{speeds},j_B)
\quad\Longrightarrow\quad
2B\le NA.
}
]

## Equivalence proof in natural arithmetic

Write

[
C_A=\operatorname{TopCert}(\mathrm{speeds},j_A),\qquad
C_B=\operatorname{TopCert}(\mathrm{speeds},j_B).
]

Assume first the target implication. Suppose (\neg C_A\land\neg C_B). Were (2B\le NA) false, linearity of the natural-number order would give

[
NA<2B.
]

The target would then give (C_A\lor C_B), contradicting (\neg C_A\land\neg C_B). Hence (2B\le NA).

Conversely, assume the contrapositive and suppose (NA<2B). If (C_A\lor C_B) were false, De Morgan's law would give

[
\neg C_A\land\neg C_B.
]

The contrapositive would then imply (2B\le NA), contradicting (NA<2B). Therefore (C_A\lor C_B).

The arithmetic conversion used in both directions is

[
\neg(x<y)\iff y\le x
]

for (x,y\in\mathbb N). In particular,

[
2B=NA
]

satisfies the residual inequality (2B\le NA). Equality is not part of the strict large-ratio premise.

---

# 3. Two materially different attacks and their obligation ledgers

## Attack I: fastest-pivot extremal compression followed by cross-pivot transfer

This is the selected route.

Choose a slowest nonfastest index (j_{\min}). It exists because (n\ge2), so deleting (j_B) leaves a nonempty finite set. Put

[
m=\mathrm{speeds}(j_{\min}).
]

By `TopTwo`,

[
0<m\le \mathrm{speeds}(i)\le A
\qquad(i\ne j_B).
]

For the (B)-pivot, define the exact interval

[
L=\left\lceil\frac{B}{m}\right\rceil,\qquad
U=\left\lfloor\frac{(N-1)B}{A}\right\rfloor.
]

The existing extremal-band theorem proves that every (r) satisfying

[
L\le r\le U,\qquad N\nmid r
]

is a complete (B)-pivot certificate. Its proved contrapositive gives

[
\neg\operatorname{TopCert}(\mathrm{speeds},j_B)
\Longrightarrow
\left[
U<L
\ \lor
(U=L\land N\mid L)
\right].
]

### Obligation ledger

| Obligation                                                                                                          |        Status | Exact role                                                                |
| ------------------------------------------------------------------------------------------------------------------- | ------------: | ------------------------------------------------------------------------- |
| Choose (j_{\min}) among the nonfastest indices                                                                      | `proved-math` | Finite nonempty minimum; no sorting assumption.                           |
| Verify (m\le\mathrm{speeds}(i)\le A) for (i\ne j_B)                                                                 | `proved-math` | Lower inequality by the selected minimum; upper inequality from `TopTwo`. |
| Any nonmultiple in ([L,U]) gives a (B)-certificate                                                                  | `proved-lean` | Existing extremal-interval theorem.                                       |
| No (B)-certificate compresses the interval to empty or a divisible singleton                                        | `proved-lean` | Existing exact dichotomy.                                                 |
| Use the complete (B)-grid cover, including wrap-around numerators outside ([L,U]), to uncover an (A)-grid numerator |        `open` | First unsupported implication.                                            |

The compression alternative alone is insufficient. For

[
(\mathrm{speeds},N,A,B)=((1,3,8),4,3,8),
]

one has

[
L=U=8,\qquad 4\mid8,
]

but the (B)-pivot still has the certificate (r=14). Thus the compressed alternative does not imply failure of the (B)-pivot. Any successful transfer must retain the full no-(B)-certificate premise, not only the interval alternative.

## Attack II: bounded (kB\pm d) residue blocks

For

[
1\le d\le\left\lfloor\frac N2\right\rfloor,
]

the strict ratio implies

[
dA<B.
]

For a lower speed (s\le A), put

[
c\equiv ks\pmod N,\qquad 0\le c<N.
]

For valid (B)-grid numerators of the forms (r=kB+d) and (r=kB-d), the cyclic-distance condition reduces to avoiding two residues of (c):

[
\begin{aligned}
r=kB+d:\quad&
\rho_{NB}(rs)\ge B
\iff c\notin{0,N-1},\
r=kB-d:\quad&
\rho_{NB}(rs)\ge B
\iff c\notin{0,1}.
\end{aligned}
]

These are proved in Section 4.

### Obligation ledger

| Obligation                                                                               |                             Status | Exact role                                                            |
| ---------------------------------------------------------------------------------------- | ---------------------------------: | --------------------------------------------------------------------- |
| Derive (dA<B) from (2d\le N) and (NA<2B)                                                 |                      `proved-math` | Prevents overlap with more than the two terminal bad residue classes. |
| Derive the exact plus/minus residue formulas                                             |                      `proved-math` | Retains strict badness and closed safety.                             |
| Select one (k,d,\pm) simultaneously avoiding every lower speed and satisfying (N\nmid r) | `rejected` for this bounded family | The required selector fails at ((4,5,12)).                            |
| Enlarge the family using arbitrary wraps or another structured selector                  |                `open`, not pursued | Would become a new route beyond the turn cap.                         |

At ((4,5,12)), every member of the declared (kB\pm d) family is spoiled by speed (4), but (r=3), outside that family, is a valid (B)-pivot certificate. Therefore the bounded block family cannot prove the target.

## Selection

Attack I was retained because it uses an existing `proved-lean` no-certificate consequence and preserves the exact no-(B)-certificate premise. Attack II was terminated by a literal counterexample to its proposed numerator family.

Neither attack proves the target.

---

# 4. Complete proofs of the new `proved-math` claims

## 4.1 Common positive scaling invariance

Let (d>0), and define

[
\mathrm{speeds}_d(i)=d,\mathrm{speeds}(i).
]

Fix a pivot (j), put

[
P=\mathrm{speeds}(j),\qquad M=NP.
]

The scaled pivot and modulus are (dP) and (dM).

### Scaling identity for cyclic distance

For every (x\in\mathbb N),

[
\rho_{dM}(dx)=d,\rho_M(x).
]

Write

[
x=qM+s,\qquad 0\le s<M.
]

Then

[
dx=q(dM)+ds,\qquad 0\le ds<dM,
]

so

[
(dx)\bmod(dM)=ds.
]

Consequently,

[
\begin{aligned}
\rho_{dM}(dx)
&=\min(ds,dM-ds)\
&=\min(ds,d(M-s))\
&=d\min(s,M-s)\
&=d,\rho_M(x).
\end{aligned}
]

This includes (s=0), where both sides equal zero.

### Forward certificate transport

Suppose (r) certifies the original pivot. Then

[
r<M<dM
]

and (N\nmid r) remains unchanged. For every (i),

[
\begin{aligned}
\rho_{dM}\bigl(r\cdot d,\mathrm{speeds}(i)\bigr)
&=\rho_{dM}\bigl(d(r\cdot\mathrm{speeds}(i))\bigr)\
&=d,\rho_M(r\cdot\mathrm{speeds}(i))\
&\ge dP.
\end{aligned}
]

Thus the same numerator certifies the scaled pivot.

### Reverse certificate transport

Suppose (r'<dM), (N\nmid r'), and (r') certifies the scaled pivot. Define

[
q=r'\bmod M.
]

Then (q<M). Because (M=NP), one has (N\mid M). If (N\mid q), then writing (r'=hM+q) would give (N\mid r'), contrary to the scaled candidate condition. Hence

[
N\nmid q.
]

For every (i),

[
r'\mathrm{speeds}(i)\equiv q,\mathrm{speeds}(i)\pmod M,
]

and therefore

[
\rho_M(r'\mathrm{speeds}(i))
============================

\rho_M(q,\mathrm{speeds}(i)).
]

The scaled certificate gives

[
\begin{aligned}
dP
&\le
\rho_{dM}\bigl(r'\cdot d,\mathrm{speeds}(i)\bigr)\
&=
d,\rho_M(r'\mathrm{speeds}(i))\
&=
d,\rho_M(q,\mathrm{speeds}(i)).
\end{aligned}
]

Since (d>0), cancellation in (\mathbb N) gives

[
P\le\rho_M(q,\mathrm{speeds}(i)).
]

Thus (q) certifies the original pivot.

Therefore

[
\operatorname{TopCert}(\mathrm{speeds},j)
\iff
\operatorname{TopCert}(\mathrm{speeds}_d,j).
]

Multiplication by a positive (d) also preserves and reflects

[
A<B,\qquad
\mathrm{speeds}(i)\le A,\qquad
NA<2B.
]

Hence the complete target is homogeneous. Dividing a tuple by its positive common gcd preserves the exact truth value of every hypothesis and conclusion.

## 4.2 Reindexing invariance

Let

[
e:\operatorname{Fin}n\simeq\operatorname{Fin}n
]

be a bijection, and define

[
\mathrm{speeds}^e(i)=\mathrm{speeds}(e(i)).
]

Set

[
j_A^e=e^{-1}(j_A),\qquad
j_B^e=e^{-1}(j_B).
]

Then

[
\mathrm{speeds}^e(j_A^e)=A,\qquad
\mathrm{speeds}^e(j_B^e)=B.
]

Because (e) is injective,

[
j_A^e\ne j_B^e.
]

For any (i\ne j_B^e), injectivity of (e) gives (e(i)\ne j_B). Therefore

[
\mathrm{speeds}^e(i)
=\mathrm{speeds}(e(i))
\le A.
]

Thus `TopTwo` transfers in the forward direction. Applying the same argument to (e^{-1}) gives the converse.

For a pivot (j), the pivot speed and modulus are unchanged after replacing (j) with (e^{-1}(j)). If (r) is an original certificate, then for every (i),

[
P\le\rho_{NP}\bigl(r\mathrm{speeds}(e(i))\bigr)
=\rho_{NP}\bigl(r\mathrm{speeds}^e(i)\bigr).
]

Hence the same (r) certifies the reindexed pivot. The converse again follows by applying (e^{-1}).

Therefore the theorem is independent of any sorted indexing convention. The sorted finite enumeration used below is only a canonical representative of each reindexing class.

## 4.3 Exact proof for (n=2)

Here (N=3). There are exactly two speeds, (A<B), and the premise is

[
3A<2B.
]

Let

[
q=\left\lceil\frac BA\right\rceil.
]

Since (A>0), the defining ceiling properties give

[
(q-1)A<B\le qA.
]

Because (B>A), one has (q\ge2).

We construct a (B)-pivot numerator.

### Case 1: (3\nmid q)

Set (r=q). Then

[
B\le rA=qA.
]

Also,

[
rA=qA<B+A<2B,
]

because (A<B). Thus

[
B\le rA<2B.
]

Since (A\ge1),

[
r\le rA<2B<3B,
]

so (r<3B). By assumption (3\nmid r).

At modulus (3B), the (A)-coordinate product already lies in ([B,2B)), so

[
\rho_{3B}(rA)\ge B.
]

For the pivot coordinate, (3\nmid r), so (r\bmod3) is (1) or (2). Hence

[
rB\bmod3B\in{B,2B},
]

and therefore

[
\rho_{3B}(rB)=B.
]

Thus (r) is a complete (B)-pivot certificate.

### Case 2: (3\mid q)

Then (q\ge3). Set

[
r=q+1.
]

Now (3\nmid r). Since (q\ge3),

[
q+1\le2(q-1).
]

Therefore

[
rA=(q+1)A
\le2(q-1)A
<2B.
]

Also,

[
rA\ge qA\ge B.
]

Thus again

[
B\le rA<2B.
]

As before, (A\ge1) gives (r<3B), the (A)-coordinate has cyclic distance at least (B), and (3\nmid r) gives

[
\rho_{3B}(rB)=B.
]

Hence (r) is a complete (B)-pivot certificate.

This proves:

[
n=2,\quad 3A<2B
\quad\Longrightarrow\quad
\operatorname{TopCert}(\mathrm{speeds},j_B).
]

No sorting of the original two indices is assumed; reindexing invariance transports the argument to the explicit (j_A,j_B).

## 4.4 Exact (kB\pm d) block formulas

Assume

[
NA<2B,\qquad
1\le d\le\left\lfloor\frac N2\right\rfloor.
]

Then (2d\le N), so

[
2dA\le NA<2B.
]

If (dA\ge B), then (2dA\ge2B), a contradiction. Hence

[
dA<B.
]

Let (0<s\le A), and define (c\in{0,\ldots,N-1}) by

[
ks\equiv c\pmod N.
]

Then for some (h),

[
ks=Nh+c.
]

### Plus numerator

Suppose

[
r=kB+d,\qquad 0\le r<NB.
]

Then

[
\begin{aligned}
rs
&=kBs+ds\
&=B(Nh+c)+ds\
&\equiv Bc+ds\pmod{NB}.
\end{aligned}
]

Since (0<ds\le dA<B):

* If (c=0), the remainder is (ds<B), so the coordinate is strictly bad.
* If (c=N-1), the remainder is ((N-1)B+ds<NB), and its complementary distance is
  [
  NB-\bigl((N-1)B+ds\bigr)=B-ds<B.
  ]
* If (1\le c\le N-2), then
  [
  B<Bc+ds<(N-1)B,
  ]
  so both the remainder and its complement are greater than (B).

Therefore

[
\rho_{NB}((kB+d)s)\ge B
\iff
c\notin{0,N-1}.
]

### Minus numerator

Suppose

[
r=kB-d,\qquad 0\le r<NB.
]

Then

[
rs\equiv Bc-ds\pmod{NB}.
]

* If (c=0), the canonical remainder is (NB-ds), whose cyclic distance is (ds<B).
* If (c=1), the remainder is (B-ds), which is strictly less than (B).
* If (2\le c\le N-1), then
  [
  B<Bc-ds<(N-1)B,
  ]
  and the complementary distance is also greater than (B).

Therefore

[
\rho_{NB}((kB-d)s)\ge B
\iff
c\notin{0,1}.
]

These formulas do not themselves ensure that (r) lies in the canonical grid. The separate requirements

[
0\le r<NB,\qquad N\nmid r
]

must still be verified.

## 4.5 Consequence obtained by appending a maximal multiple

Assume the target theorem. Let (m\ge1), and let

[
v:\operatorname{Fin}m\to\mathbb N
]

be positive and injective. Choose (k_A) attaining the maximum

[
A=v(k_A).
]

Set

[
n=m+1,\qquad N=n+1=m+2,\qquad B=NA.
]

Define an appended family (S:\operatorname{Fin}(m+1)\to\mathbb N) by

[
S(\operatorname{Fin.castSucc}(i))=v(i),\qquad
S(\operatorname{Fin.last}(m))=B.
]

Let

[
j_A=\operatorname{Fin.castSucc}(k_A),\qquad
j_B=\operatorname{Fin.last}(m).
]

Every old speed is at most (A), while

[
B=NA>A
]

because (N\ge3) and (A>0). Thus (S) is positive and injective, and `TopTwo(S,jA,jB)` holds.

Furthermore,

[
NA<2NA=2B.
]

At the (A)-pivot, the modulus is

[
NA=B.
]

For every candidate numerator (r), the appended coordinate satisfies

[
rB\equiv0\pmod B,
]

so

[
\rho_B(rB)=0<A.
]

Thus the (A)-pivot has no certificate. The assumed target must therefore supply a (B)-pivot certificate (r).

Its modulus is (NB). For every original speed (v(i)),

[
B\le\rho_{NB}(r,v(i)).
]

At the real time

[
t=\frac r{NB},
]

this gives

[
\left|t,v(i)\right|
===================

\frac{\rho_{NB}(r,v(i))}{NB}
\ge
\frac{B}{NB}
============

# \frac1N

\frac1{m+2}.
]

Hence the target would imply a uniform (1/(m+2)) witness for every positive injective (m)-tuple. This reduction is `proved-math`; the resulting universal statement remains `conditional` because the target remains `open`.

---

# 5. Mandatory falsification results and literal rejected-strengthening certificates

## 5.1 Exact target falsification result

No exact falsifier was found.

The complete declared primitive box contained:

[
247{,}020
]

strict-large-ratio rows. For every row, both canonical top grids were tested literally and by a separate recurrence implementation. There was no row on which both top grids were covered.

The observed certificate counts were:

[
\begin{aligned}
\text{(A)-certificate rows}&=246{,}281,\
\text{(B)-certificate rows}&=247{,}020,\
\text{both-certificate rows}&=246{,}281.
\end{aligned}
]

Thus the (A)-pivot failed on 739 rows, while the (B)-pivot succeeded on every row in the declared box. This is `computed finite evidence` only. No dimension-uniform fastest-pivot theorem is asserted.

## 5.2 Required boundary and mutation coverage

The fixed suite tested:

| Required class                                                               | Exact coverage                                                                                            |
| ---------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| (n=2) and (NA+1=2B) when possible                                            | ((1,2)), ((3,5))                                                                                          |
| Equality (NA=2B)                                                             | ((2,3)), ((1,2,4)), ((1,2,4,10)), ((1,2,3,4,12))                                                          |
| Immediately above the boundary                                               | Consecutive lower families for (4\le N\le20), with (B=\lfloor NA/2\rfloor+1)                              |
| Very large (B/A)                                                             | ((1,1000)), ((3,10,29,87,5000))                                                                           |
| Common scaling and nonprimitive tuples                                       | ((2,4)), ((2,4,16)), ((6,18,48)), plus 24 scaling equivalence checks                                      |
| Explicit top-index placements                                                | 6,923,288 `TopTwo` placement checks in the complete box; 18 independent reindex checks in the fixed suite |
| Sparse lower speeds                                                          | ((1,11,23,47,89,313))                                                                                     |
| Divisibility stress                                                          | ((1,7,14,21,35,245))                                                                                      |
| Affine-residue stress                                                        | ((7,63,70,77,98,344))                                                                                     |
| RF, GCD-clock, anchor-star, TOP-CYCLE, CHAIN3, OPT-ADD, affine-hard stresses | Original rows and deterministic boundary-plus mutations entering (NA<2B)                                  |
| Deletion mutations                                                           | Three explicit deletions of the CHAIN3 family, followed by boundary-plus replacement                      |
| ((1,2,8))                                                                    | Rechecked exactly                                                                                         |

There were 61 fixed cases, of which 45 satisfied the strict premise. No strict case covered both top grids.

The original RF, GCD-clock, anchor-star, TOP-CYCLE, CHAIN3, OPT-ADD, and affine-hard rows mostly lie on the residual side. Their deterministic boundary-plus mutations were used to place the same lower structure immediately inside the strict branch.

## 5.3 Rejected strengthening: the (A)-grid is always nonempty

Take

[
\mathrm{speeds}=(1,2,8),\qquad n=3,\quad N=4,\quad A=2,\quad B=8.
]

The explicit top indices are

[
j_A=1,\qquad j_B=2.
]

`TopTwo` holds, and

[
NA=8<16=2B.
]

The (A)-pivot modulus is (8). Its complete candidate set is

[
C(A)={1,2,3,5,6,7}.
]

Every candidate has an explicit strict-bad spoiler:

| (r) | Spoiler index | Spoiler speed | (\rho_8(r,s)) |
| --: | ------------: | ------------: | ------------: |
|   1 |             0 |             1 |             1 |
|   2 |             2 |             8 |             0 |
|   3 |             2 |             8 |             0 |
|   5 |             2 |             8 |             0 |
|   6 |             2 |             8 |             0 |
|   7 |             0 |             1 |             1 |

Each distance is (<A=2), so the (A)-grid is completely covered.

The (B)-pivot survives at

[
r=9,\qquad 9<32,\qquad 4\nmid9.
]

The distance vector in speed order ((1,2,8)) is

[
\bigl(\rho_{32}(9),\rho_{32}(18),\rho_{32}(72)\bigr)
=(9,14,8),
]

which is coordinatewise at least (B=8).

Therefore one-sided (A)-grid nonemptiness is `rejected`, while the required top-pivot disjunction survives.

## 5.4 Rejected strengthening: the extremal interval is always nonexceptional

Take

[
\mathrm{speeds}=(1,3,8),\qquad
N=4,\quad A=3,\quad B=8.
]

The selected slowest nonfastest speed is (m=1). Therefore

[
L=\left\lceil\frac81\right\rceil=8,
]

and

[
U=\left\lfloor\frac{3\cdot8}{3}\right\rfloor=8.
]

Thus

[
U=L=8,\qquad 4\mid L.
]

The exact exceptional singleton alternative occurs despite the strict ratio

[
12=NA<16=2B.
]

Nevertheless, the (B)-pivot has the certificate

[
r=14,\qquad 14<32,\qquad 4\nmid14,
]

with distance vector

[
\bigl(\rho_{32}(14),\rho_{32}(42),\rho_{32}(112)\bigr)
=(14,10,16).
]

Every coordinate is at least (B=8).

Hence the claim that strict large ratio always makes the extremal interval contain a nonmultiple is `rejected`. This does not refute the proved compression theorem, whose hypothesis is failure of the complete fastest-pivot grid.

## 5.5 Rejected strengthening: bounded (kB\pm d) certificates suffice

Take

[
\mathrm{speeds}=(4,5,12),\qquad
N=4,\quad A=5,\quad B=12.
]

Then

[
NA=20<24=2B.
]

Consider all canonical numerators of the form

[
kB\pm d,\qquad
0\le k<N,\qquad
1\le d\le\left\lfloor\frac N2\right\rfloor=2.
]

After imposing (0\le r<NB=48) and (4\nmid r), the exact restricted set is

[
{1,2,10,11,13,14,22,23,25,26,34,35,37,38}.
]

Speed (4) spoils every restricted numerator:

| Restricted numerators  | Corresponding (\rho_{48}(4r)) |
| ---------------------- | ----------------------------- |
| (1,2,10,11,13,14,22)   | (4,8,8,4,4,8,8)               |
| (23,25,26,34,35,37,38) | (4,4,8,8,4,4,8)               |

Every displayed distance is strictly less than (B=12).

The complete (B)-safe set is nevertheless

[
{3,5,6,7,15,33,41,42,43,45}.
]

In particular,

[
r=3,\qquad 3<48,\qquad 4\nmid3,
]

has distance vector

[
\bigl(\rho_{48}(12),\rho_{48}(15),\rho_{48}(36)\bigr)
=(12,15,12).
]

Thus the bounded (kB\pm d) family is `rejected`; arbitrary wrap-around numerators cannot be discarded.

---

# 6. Computation specification, commands, counts, runtimes, hashes, and agreement

## 6.1 Complete strict-large-ratio box

### Declared domain

The bounds were fixed before inspecting the results:

[
2\le n\le8,\qquad B\le64.
]

Enumerated tuples were positive, strictly increasing canonical representatives

[
a_1<\cdots<a_{n-2}<A<B,
]

subject to

[
\gcd(a_1,\ldots,a_{n-2},A,B)=1,\qquad
(n+1)A<2B.
]

The deterministic order was:

1. (n) ascending;
2. (B) ascending;
3. (A) ascending;
4. lower tuple lexicographic.

Had a counterexample occurred, this would have been the deterministic smallest counterexample order.

For each canonical tuple, every ordered placement (j_A\ne j_B) of the two top values was explicitly reconstructed and checked against the unsorted `TopTwo` predicate. Lower speeds retained increasing order in the remaining slots. Reindexing invariance proves that the certificate result is unchanged by those placements.

### Independent implementations

The literal implementation:

1. enumerated every (r<NP) with (N\nmid r);
2. computed every product (r,\mathrm{speeds}(i));
3. reduced it modulo (NP);
4. evaluated the literal cyclic distance;
5. retained (r) only when every distance was at least (P).

The optimized implementation:

1. initialized the complete canonical grid;
2. constructed each strict bad set by the modular recurrence
   [
   y_{r+1}\equiv y_r+\mathrm{speeds}(i)\pmod{NP};
   ]
3. unioned the strict bad masks;
4. took the complement.

The two implementations compared their entire safe masks, rather than only their first witnesses or cardinalities.

### Commands

```bash
g++ -O3 -std=c++20 -Wall -Wextra -pedantic \
  /mnt/data/p64_top_two_sweep_v1.cpp \
  -o /mnt/data/p64_top_two_sweep_v1
```

```bash
/usr/bin/time \
  -f 'wall_seconds=%e\nmax_rss_kb=%M\nexit_status=%x' \
  -o /mnt/data/p64_top_two_sweep_v1.time \
  /mnt/data/p64_top_two_sweep_v1 \
  > /mnt/data/p64_top_two_sweep_v1.out
```

Compiler:

```text
g++ (Debian 14.2.0-19) 14.2.0
```

Program version:

```text
p64_top_two_sweep_v1
```

### Results

| Quantity                                   |     Exact value |
| ------------------------------------------ | --------------: |
| Primitive strict-ratio rows                |         247,020 |
| Nonprimitive rows skipped after gcd test   |           5,597 |
| Literal canonical numerators examined      |      98,271,563 |
| Optimized canonical numerators represented |      98,271,563 |
| Complete safe-mask agreements              |         494,040 |
| Explicit top-index placement checks        |       6,923,288 |
| Rows with (A)-certificate                  |         246,281 |
| Rows with (B)-certificate                  |         247,020 |
| Rows with both                             |         246,281 |
| Exact two-grid covers                      |               0 |
| Internal runtime                           | 2.37701 seconds |
| Recorded wall time                         |    2.38 seconds |
| Peak RSS                                   |        3,860 KB |
| Exit status                                |               0 |

The 5,597 nonprimitive rows were not counted as primitive executions. The proved scaling invariance reduces each of them to a primitive tuple without changing the truth of either top certificate. Explicit nonprimitive examples were also included in the fixed stress suite.

### SHA-256

| Artifact        | SHA-256                                                            |
| --------------- | ------------------------------------------------------------------ |
| C++ source      | `9c8bdb908bd37c9a9a13a20f023c50b3121def34ffc5c7dfbe9e1f20038e7b37` |
| Compiled binary | `8ec4abed163943139409620bbed999cbede3a030219907fb710b6e313b346769` |
| Standard output | `2122d5631feac7dbac8bdf93c966819eb973cb4dc7c83eb931750a3625d322e6` |
| Timing output   | `45e73fa3180aa1fd13127a0484f7fd09a6cff954df99c48f9e5b7c2e8efa66b3` |

Artifacts:

* [Complete sweep source](sandbox:/mnt/data/p64_top_two_sweep_v1.cpp)
* [Complete sweep output](sandbox:/mnt/data/p64_top_two_sweep_v1.out)
* [Complete sweep timing](sandbox:/mnt/data/p64_top_two_sweep_v1.time)

## 6.2 Fixed targeted stress replay

Program version:

```text
P64-TARGETED-STRESS-v1.0.0
```

Python version:

```text
3.13.5
```

Command:

```bash
/usr/bin/time \
  -f 'wall_seconds=%e\nmax_rss_kb=%M\nexit_status=%x' \
  -o /mnt/data/p64_targeted_stress_v1.time \
  python3 /mnt/data/p64_targeted_stress_v1.py \
  > /mnt/data/p64_targeted_stress_v1.out
```

### Results

| Quantity                                |      Exact value |
| --------------------------------------- | ---------------: |
| Fixed cases                             |               61 |
| Strict-ratio cases                      |               45 |
| Literal numerators examined             |          148,530 |
| Recurrence numerators represented       |          148,530 |
| Full literal/recurrence grid agreements |              122 |
| Strict two-top-grid covers              |                0 |
| Scaling checks                          |               24 |
| Reindex checks                          |               18 |
| Internal runtime                        | 0.230685 seconds |
| Recorded wall time                      |     0.76 seconds |
| Peak RSS                                |       111,636 KB |
| Exit status                             |                0 |

### SHA-256

| Artifact           | SHA-256                                                            |
| ------------------ | ------------------------------------------------------------------ |
| Python source      | `6b42c80fe54bda78bd56aabc0c340e22b8cf21c574a94d6279a4fab82e46557a` |
| Standard output    | `07d2a31677fb9e3d8276e572febcb2985a2789ed733461843e22cc1d4ac7914f` |
| Timing output      | `b8029a60dfefe0037718b9e93eeaf28b2f24e125eb1a7f8784c834bd76cde32a` |
| Execution manifest | `d839bcc52ce003aba795aad09e619158dc5b98feb43b76074d606320a56aec03` |

Artifacts:

* [Targeted stress source](sandbox:/mnt/data/p64_targeted_stress_v1.py)
* [Targeted stress output](sandbox:/mnt/data/p64_targeted_stress_v1.out)
* [Targeted stress timing](sandbox:/mnt/data/p64_targeted_stress_v1.time)
* [Execution manifest](sandbox:/mnt/data/p64_execution_manifest_v1.json)

All computational conclusions remain `computed finite evidence`.

---

# 7. Single first unsupported implication

After applying the existing fastest-pivot theorem, the first unsupported implication is:

[
\boxed{
\begin{aligned}
&\text{all target ambient hypotheses}\
&\land\ NA<2B\
&\land\neg\operatorname{TopCert}(\mathrm{speeds},j_B)\
&\Longrightarrow
\operatorname{TopCert}(\mathrm{speeds},j_A).
\end{aligned}
}
]

Equivalently, after selecting the slowest nonfastest speed (m) and defining

[
L=\left\lceil\frac Bm\right\rceil,\qquad
U=\left\lfloor\frac{(N-1)B}{A}\right\rfloor,
]

the proved compression supplies

[
U<L\quad\lor\quad(U=L\land N\mid L).
]

The unsupported arithmetic arrow is:

```text
complete coverage of the B-pivot grid
plus the strict ratio
plus the empty-or-divisible-singleton extremal alternative
  -> an uncovered numerator on the A-pivot grid.
```

A proof of this branch would prove the exact target by excluded middle:

* if `TopCert(speeds,jB)`, the target disjunction holds;
* otherwise, the branch implication supplies `TopCert(speeds,jA)`.

This branch statement is an exact reformulation of the remaining two-grid obligation. It is not promoted as a new theorem or as independent progress. Neither the interval dichotomy, the finite sweep, nor the block formulas prove it.

---

# 8. Lean 4.32.1 declaration

None proposed.

The exact target remains `open`. The (n=2) theorem is a genuine `proved-math` special case, but it does not imply the dimension-uniform target and therefore does not satisfy the contract condition for the sole allowed Lean prototype. Formalizing the unsupported no-(B)-to-(A) transfer as a proposition would only encode the remaining obligation.

---

# 9. Complete project implication chain with statuses

```text
hypothetical least bad positive-integer dimension n
  -> divide by the common gcd and choose explicit numerical top indices
     jA,jB
     [conditional setup;
      common positive scaling invariance is proved-math here;
      finite maximum/second-maximum selection is proved-math]

  -> no full witness implies no canonical certificate at either top pivot
     [proved-lean:
      contraposition of the pivot-certificate-to-full-witness bridge]

  -> TOP-TWO-LARGE-RATIO-EXCLUSION
     [open:
      exact Prompt 64 target]

  -> 2*B <= N*A
     [proved-math consequence conditional on the open target:
      exact contrapositive proved in Section 2]

  -> lower-dimensional LRC supplies a witness for the tuple deleting B;
     explicit reindexing plus FastRunnerInsertion contraposition gives
       B < n*A
     [conditional on least-bad-dimension induction;
      reindexing is proved-math here;
      the deleted-family witness must actually be supplied;
      FastRunnerInsertion does not yield 2*B <= N*A]

  -> no-full-witness plus divisor_cover_of_no_small_witness,
     positivity, top-two ordering, and B < 2*q gives:
       for every q with 1 <= q <= N and B < 2*q,
       some speed equals q
     [conditional;
      the no-full-witness premise is essential;
      divisibility is converted to equality using positivity and
      top-two ordering]

  -> the complete Response 62 Residual predicate is assembled
     [conditional on all preceding residual premises]

  -> RESIDUAL-2N-SHIFT-OWNER-TRANSVERSAL
     [conjectural / open;
      not an input to Prompt 64]

  -> TOP-TWO-INTEGRAL-TRANSVERSAL
     [conditional on the open owner-transversal]

  -> a canonical certificate at A or B
     [conditional on the integral-transversal conclusion]

  -> full closed 1/N witness
     [proved-lean certificate-to-witness bridge]

  -> contradiction to the hypothetical least bad family
     [conditional because two preceding arrows remain open]

  -> PositiveIntegerPivotCertificateConjecture
     [conditional until the open Prompt 64 and owner-transversal arrows
      are both closed]

  -> PositiveIntegerConjecture
     [proved-lean equivalence of formulations]

  -> verified endpoint-safe real reduction
     [proved-lean]

  -> unrestricted Lonely Runner
     [open overall].
```

The Prompt 64 target alone would supply only the inequality branch

[
2B\le NA
]

under failure of both top certificates. It does not by itself prove the downstream top-two theorem, the owner-transversal, or unrestricted Lonely Runner.

---

# 10. Decision

## `STOP/OPEN`

`TOP-TWO-LARGE-RATIO-EXCLUSION` is neither proved nor refuted.

The mandatory complete primitive sweep and the fixed structured replay found no exact two-top-grid cover. The evidence is unusually one-sided, since the (B)-pivot succeeded on every one of the 247,020 primitive box rows, but no argument converts that finite observation into an unbounded, dimension-uniform theorem.

The selected proof route stops at the unsupported transfer

[
\neg\operatorname{TopCert}(j_B)
\Longrightarrow
\operatorname{TopCert}(j_A)
]

under the strict ratio and `TopTwo` hypotheses. The existing extremal-interval dichotomy loses the wrap-around information needed for that transfer. The alternative bounded (kB\pm d) route is `rejected` by ((4,5,12)).

Therefore:

* `TOP-TWO-LARGE-RATIO-EXCLUSION`: `open`.
* `RESIDUAL-2N-SHIFT-OWNER-TRANSVERSAL`: `conjectural` / `open`.
* Unrestricted Lonely Runner: `open`.

Recent work has extended computer-assisted verification to the integer-speed cases (k\in{10,11,12}), but it does not provide a dimension-uniform proof. Current 2026 sources continue to describe the general conjecture as unresolved and the subject of future research directions. ([arXiv][1])

[1]: https://arxiv.org/abs/2604.23906 "https://arxiv.org/abs/2604.23906"
