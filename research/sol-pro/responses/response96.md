## 1. **Disposition**

`SEPARATION`

The scope is symbolic for every integer (E\ge 3):

[
a_E=(1,q,C-1,C+1,H-1,H)
]

has a completely covered (q)-pivot with zero unit deficit, but the other four nontrivial pivots each have an explicit uncovered unit residue. Consequently,

[
\OmegaUnit(a_E)>0
]

for every (E\ge3), so this family is not a Prompt94 counterexample.

For Prompt95, the exact all-(E) covered-pivot set is

[
F(a_E)={1,q},
\qquad j_\star=q.
]

The only possible internal owner at (j_\star) is speed (1), and that owner does not cover the (q)-row. Thus no internal complete cover exists for this family. The known five-owner fixed-grid cover is independently proved inclusion-minimal, but four of its five owners are outside (F(a_E)).

Prompt94 and Prompt95 remain `open`. All new reasoning below is `proved-math-response`, pending independent audit.

---

## 2. **Evidence boundary**

The accepted comparison target is audit301 at commit

```text
79c4549f52ffdc95e06fb3a27a4bd5ecaf7acafa
```

with audit-file SHA-256

```text
21c738a00bb277f873e8c98762d95b1cd9d8d889a0f3042512e59c08ce6fc69f
```

Its all-(E) canonical family, deletion-gcd calculation, full strict cover, product valuation, (E_6=117), and Prompt87/Prompt92 aggregate refutation remain `proved-math-qualified`.

The remaining recovery identities and hashes in the contract are treated as frozen `input-accepted` launch inputs. No repository, attachment, ZIP, manifest payload, or quarantined scan was opened or used. Those materials remain `unverified response input`.

The earlier response-authored private-residue and inclusion-minimality claims retain their original unverified provenance. Section 11 gives a separate proof of the same mathematical statements, classified only as `proved-math-response`.

No statement about unrestricted Lonely Runner is made.

---

## 3. **Concise independent replication**

Let

[
q=2^E,\qquad M=7q,\qquad C=\frac{M}{4}=\frac{7q}{4},
\qquad H=\frac M2=\frac{7q}{2},
]

and

[
v=(1,1,C-1,C+1,H-1,H).
]

This is a deliberate independence check against audit301.

### Canonicality, deletion gcds, and valuation

Since (E\ge3), (8\mid q). Therefore (4\mid M), (H) is even, and all displayed coordinates are integers. Moreover,

[
C\ge 14,\qquad 0<1<C-1<C+1<H-1<H<M.
]

Hence every coordinate is canonical.

Every deletion leaves at least one of the two separately labelled coordinates equal to (1). Consequently,

[
\Delta_k(v)=1\qquad(k=0,\ldots,5).
]

The numbers (C-1,C+1,H-1) are odd because (C) and (H) are even, while

[
H=7\cdot 2^{E-1},
\qquad \nu_2(H)=E-1.
]

Thus, for the labelled product,

[
\nu_2!\left(\prod_{i=0}^5v_i\right)=E-1,
]

and therefore

[
q=2^E\nmid\prod_{i=0}^5v_i.
]

This is product nondivisibility, not coordinatewise nondivisibility.

### Strict full cover

For odd (r),

[
rH\equiv H\pmod M,
\qquad
r(H-1)\equiv H-r\pmod M.
]

Also, since (M=4C),

[
rC\equiv
\begin{cases}
C \pmod M,&r\equiv1\pmod4,\
3C\pmod M,&r\equiv3\pmod4.
\end{cases}
]

The seven disjoint cases are therefore:

| Canonical case               | Owner | Exact strict calculation                                                    |       |                                          |     |      |
| ---------------------------- | ----: | --------------------------------------------------------------------------- | ----- | ---------------------------------------- | --- | ---- |
| (r) even                     |   (H) | (rH=(r/2)M), so (\rho_M(rH)=0<q).                                           |       |                                          |     |      |
| (r) odd, (\rho_M(r)<q)       |   (1) | (\rho_M(r\cdot1)<q) by the case hypothesis.                                 |       |                                          |     |      |
| (r) odd, (                   |   r-H | <q)                                                                         | (H-1) | (r(H-1)\equiv H-r), so the distance is ( | r-H | <q). |
| (q<r<H-q,\ r\equiv1\pmod4)   | (C-1) | (r(C-1)\equiv C-r), and (                                                   | C-r   | <3q/4<q).                                |     |      |
| (q<r<H-q,\ r\equiv3\pmod4)   | (C+1) | (r(C+1)\equiv r-C), and (                                                   | C-r   | <3q/4<q).                                |     |      |
| (H+q<r<M-q,\ r\equiv3\pmod4) | (C-1) | Put (s=M-r). Then (q<s<H-q), (s\equiv1\pmod4), and (\rho_M(rv)=\rho_M(sv)). |       |                                          |     |      |
| (H+q<r<M-q,\ r\equiv1\pmod4) | (C+1) | Put (s=M-r). Then (q<s<H-q), (s\equiv3\pmod4), and use the lower case.      |       |                                          |     |      |

The boundary points

[
q,\quad H-q,\quad H+q,\quad M-q
]

are even. They belong to the first row, not to an open odd interval. The cases are exhaustive because an odd residue outside the endpoint arcs and center arc lies in exactly one of the two open annuli.

Hence

[
\bigcup_{i=0}^{5}B_i=\operatorname{Fin}M.
]

Deleting either duplicate owner (1) leaves the five-owner full-grid cover

[
w=(1,C-1,C+1,H-1,H).
]

### Literal (E=3) control

Here

[
q=8,\quad M=56,\quad C=14,\quad H=28,
\quad v=(1,1,13,15,27,28).
]

The six deletion gcds are

[
(1,1,1,1,1,1).
]

Also,

[
\nu_2(1\cdot1\cdot13\cdot15\cdot27\cdot28)=\nu_2(28)=2=E-1.
]

A literal disjoint covering partition is:

[
\begin{aligned}
&\text{all 28 even residues} &&\longrightarrow 28,\
&{1,3,5,7,49,51,53,55} &&\longrightarrow 1,\
&{21,23,25,27,29,31,33,35} &&\longrightarrow 27,\
&{9,13,17,39,43,47} &&\longrightarrow 13,\
&{11,15,19,37,41,45} &&\longrightarrow 15.
\end{aligned}
]

This covers every residue (0,\ldots,55) under strict (<8) badness.

At (r=8) and (r=48), the distance vector in labelled owner order is

[
(8,8,8,8,8,0).
]

Thus strict membership is

[
(0,0,0,0,0,1),
]

whereas a malformed weak implementation using (\le8) gives

[
(1,1,1,1,1,1).
]

The cover union remains full, but the labelled membership vectors differ.

At (r=0), all six products are zero. The sets (B_0) and (B_1) coincide, while their labels and product factors remain distinct. For (H=28=M/2),

[
rH\equiv0\pmod M\iff r\text{ is even},
]

so all 28 zero fibers of this nonunit coordinate are retained.

Reflection satisfies

[
\rho_M((M-r)v_i)=\rho_M(-rv_i)=\rho_M(rv_i)
]

for every labelled owner and exchanges the lower and upper odd annuli.

### Literal (E=4) control

Here

[
q=16,\quad M=112,\quad v=(1,1,27,29,55,56).
]

The deletion gcds are again all (1), and

[
\nu_2(1\cdot1\cdot27\cdot29\cdot55\cdot56)=3=E-1.
]

The same seven-case proof applies. In particular, at (r=16) and (r=96), the first five distances equal (16), while owner (56) has distance zero.

Noninteger (E), (E<3), a changed modulus, a tuple of another length, a noncanonical coordinate, a deleted label, weak badness, a total-gcd substitution, or omission of (r=0) is outside the admitted statement and is not silently normalized.

### Exact (E_6) arithmetic and route impact

Specializing Prompt92’s frozen natural-number definitions gives

[
C^{\mathrm{P92}}_6=\binom72=21,
\qquad
A_6=21^{30}
=4640650289117164100520051333566036654601.
]

Since (6^6=46656),

[
\begin{aligned}
A_6={}&46656\cdot
99465241107620972662038137293510730\
&+35721.
\end{aligned}
]

Therefore

[
T_6=\left\lceil\frac{A_6}{6^6}\right\rceil
=99465241107620972662038137293510731.
]

The bounding powers are

[
2^{116}
=83076749736557242056487941267521536,
]

and

[
2^{117}
=166153499473114484112975882535043072.
]

Thus

[
2^{116}\le T_6<2^{117},
\qquad E_6=117.
]

Instantiating the family with (E=E_6) gives exactly

[
q=q_6=2^{117},
\qquad M=M_6=7\cdot2^{117}.
]

All aggregate premises hold, while (q_6) does not divide the labelled product. Therefore:

* `AGGREGATE-DYADIC-C2-COVER-DIVISIBILITY` is `refuted-exact`.
* Its exact contrapositive is also refuted: product nondivisibility holds, while the fixed grid has no common safe residue.
* The conditional C2 chain fails at the arrow asserting (q_n\mid\prod_i v_i).
* The Prompt87 aggregate-dyadic surviving edge and the corresponding aggregate branch of C2 are killed at their frozen quantifiers.

These are the accepted audit301 consequences. The separate distinct-prime route, deletion-gcd lifting, modular lifting lemmas whose premises hold, the MSS theorem, and unrestricted LRC are unaffected. The earlier four-coordinate Prompt87 family had aggregate product divisibility and remains logically separate.

---

## 4. **Derived injective tuple**

Put

[
t=\frac q4=2^{E-2}.
]

Then (t\ge2) is even, and

[
q=4t,\qquad C=7t,\qquad H=14t.
]

The derived tuple is

[
a_E=(1,4t,7t-1,7t+1,14t-1,14t).
]

Its entries satisfy

[
1<4t<7t-1<7t+1<14t-1<14t.
]

Indeed, (4t<7t-1) is equivalent to (3t>1), and (7t+1<14t-1) is equivalent to (7t>2). Both hold for (t\ge2). Thus (a_E) is positive and injective for every (E\ge3).

Writing

[
A=7t-1,\qquad B=7t+1,\qquad D=14t-1,
]

the six pivot moduli are

[
\begin{array}{c|c}
\text{pivot speed}&\text{pivot modulus}\ \hline
1&7\
q=4t&28t=7q\
A=7t-1&49t-7\
B=7t+1&49t+7\
D=14t-1&98t-7\
H=14t&98t.
\end{array}
]

---

## 5. **Exact q-row transfer**

At the pivot with speed (q),

[
M_q=7q=M.
]

Removing the pivot speed (q) leaves exactly the five labelled owners

[
(1,C-1,C+1,H-1,H)=w.
]

Section 3 proves that these five owners cover every residue in (\operatorname{Fin}M). Prompt94 and Prompt95 use the restricted candidate row

[
R_q={r\bmod M:7\nmid r}.
]

Since (R_q\subseteq\operatorname{Fin}M), the full-grid cover restricts to a complete candidate cover. Therefore

[
Q_q(a_E)=\varnothing.
]

Consequently,

[
\DefUnit_q(a_E)=0.
]

This is an exact transfer for every (E\ge3). It does not imply that the all-pivot sum vanishes.

The speed-(1) row is also covered. Its modulus is (7), and

[
H=14t\equiv0\pmod7.
]

Thus owner (H) has zero product at all six candidates, so

[
Q_1(a_E)=\varnothing,
\qquad \DefUnit_1(a_E)=0.
]

---

## 6. **Prompt94 E=3 control**

For a pivot speed (m), write

[
Q_m=\left{
r\in{0,\ldots,7m-1}:
7\nmid r,\
\rho_{7m}(rb)\ge m\ \text{for every nonpivot speed }b
\right}.
]

Then

[
\DefUnit_m
==========

#{r\in Q_m:\gcd(r,7m)=1}.
]

For (a_3=(1,8,13,15,27,28)), reflection (r\mapsto7m-r) preserves (Q_m). Let (S_m) be its positive-half representatives and (U_m\subseteq S_m) the unit representatives. Direct reduction of every product modulo (7m) gives:

| Pivot (m) | (S_m), with (Q_m=S_m\sqcup(7m-S_m))        | (U_m)                          | (\lvert Q_m\rvert) | (\DefUnit_m) |
| --------: | ------------------------------------------ | ------------------------------ | -----------------: | -----------: |
|       (1) | (\varnothing)                              | (\varnothing)                  |                (0) |          (0) |
|       (8) | (\varnothing)                              | (\varnothing)                  |                (0) |          (0) |
|      (13) | ({15,32,38,41})                            | same set                       |                (8) |          (8) |
|      (15) | ({18,20,29,36,44,46,50})                   | ({29,44,46})                   |               (14) |          (6) |
|      (27) | ({32,36,53,55,65,66,78,79,80,82,83,85,90}) | ({32,53,55,65,79,80,82,83,85}) |               (26) |         (18) |
|      (28) | ({33,34,55,57,68,69,81,82,83,85,86})       | ({33,55,57,69,81,83,85})       |               (22) |         (14) |

For example, on the (m=15) row the candidate condition already excludes factors of (7); the additional unit filter removes residues divisible by (3) or (5), leaving the three positive-half representatives (29,44,46) and their reflections.

Thus, in increasing speed order,

[
(\DefUnit_1,\DefUnit_8,\DefUnit_{13},
\DefUnit_{15},\DefUnit_{27},\DefUnit_{28})
=(0,0,8,6,18,14),
]

and

[
\OmegaUnit(a_3)=0+0+8+6+18+14=46.
]

---

## 7. **Prompt94 synthesis**

The remaining four pivot rows admit a uniform symbolic uncovered-unit certificate.

For

[
m\in{A,B,D,H}
=============

{7t-1,7t+1,14t-1,14t},
]

define

[
r_m=4m+1.
]

Since (0<4m+1<7m), this is a canonical pivot residue. Also,

[
\gcd(4m+1,m)=1.
]

Modulo (7),

[
r_m\equiv
\begin{cases}
4,&m=A\text{ or }D,\
5,&m=B,\
1,&m=H.
\end{cases}
]

Hence

[
\gcd(r_m,7m)=1,
]

so (r_m) is a unit and belongs to the candidate row.

Let

[
\sigma=t\bmod7\in{1,2,4},
]

because (t) is a power of (2). Direct modular reduction gives the following exact distance vectors, with owners listed in the indicated nonpivot order:

[
\begin{array}{c|c}
\text{pivot}&
\text{distances }\rho_{7m}(r_m b)\ \hline
A&
(21t-4,\ d_A(\sigma),\ 14t-4,\ 14t-3,\ 14t)
[-1mm]
&\hspace{8mm}\text{owners }(1,q,B,D,H)
[1mm]
B&
(21t+2,\ d_B(\sigma),\ 21t+5,\ 14t+5,\ 14t)
[-1mm]
&\hspace{8mm}\text{owners }(1,q,A,D,H)
[1mm]
D&
(42t-4,\ d_D(\sigma),\ 49t-4,\ 35t-4,\ 14t)
[-1mm]
&\hspace{8mm}\text{owners }(1,q,A,B,H)
[1mm]
H&
(42t-1,\ d_H(\sigma),\ 49t-1,\ 35t-1,\ 42t+1)
[-1mm]
&\hspace{8mm}\text{owners }(1,q,A,B,D).
\end{array}
]

The (q)-owner entries are

[
\begin{array}{c|ccc}
&\sigma=1&\sigma=2&\sigma=4\ \hline
d_A&18t-2&17t-3&11t-1\
d_B&18t+2&17t+3&11t+1\
d_D&32t-2&38t-3&18t-1\
d_H&32t&38t&18t.
\end{array}
]

For the (q)-column, this follows from

[
(4m+1)q=(4m+1)4t
\equiv km+4t\pmod{7m},
]

where

[
k\equiv16t\equiv2\sigma\pmod7.
]

The remaining columns follow directly from (m^2\equiv-m\pmod{7m}) when (m\equiv-1\pmod7), (m^2\equiv m\pmod{7m}) when (m\equiv1\pmod7), and direct substitution for (m=14t).

Every displayed distance is at least its pivot speed:

[
\begin{aligned}
d_A(\sigma)&\ge 11t-1\ge7t-1=A,\
d_B(\sigma)&\ge 11t+1\ge7t+1=B,\
d_D(\sigma)&\ge18t-1\ge14t-1=D,\
d_H(\sigma)&\ge18t\ge14t=H.
\end{aligned}
]

The other entries satisfy the same inequalities immediately for (t\ge2). Therefore (r_m) is safe for every nonpivot owner and

[
r_m\in Q_m(a_E)\cap(\mathbb Z/7m\mathbb Z)^\times.
]

Consequently,

[
\DefUnit_A(a_E)\ge1,\quad
\DefUnit_B(a_E)\ge1,\quad
\DefUnit_D(a_E)\ge1,\quad
\DefUnit_H(a_E)\ge1.
]

Together with the two zero rows,

[
\OmegaUnit(a_E)\ge4>0
\qquad\text{for every }E\ge3.
]

Thus this entire family satisfies Prompt94’s operative conclusion. It does not prove that conclusion for arbitrary positive injective tuples.

The stronger assertion that every pivot row has positive unit deficit is `refuted-exact`, already because

[
\DefUnit_1(a_E)=\DefUnit_q(a_E)=0.
]

Its evidence in this turn is `proved-math-response`.

---

## 8. **Prompt95 E=3 control**

For (a_3=(1,8,13,15,27,28)), Section 6 gives the exact uncovered-set sizes

[
(0,0,8,14,26,22)
]

in increasing speed order. Therefore the six pivot cover statuses are:

| Pivot speed | Fully covered? |
| ----------: | :------------: |
|         (1) |       Yes      |
|         (8) |       Yes      |
|        (13) |       No       |
|        (15) |       No       |
|        (27) |       No       |
|        (28) |       No       |

Hence

[
F(a_3)={1,8}.
]

The unique maximum-speed covered pivot is

[
j_\star=8.
]

This establishes every (F)-membership premise used at the mandatory instance.

---

## 9. **Prompt95 internality audit**

At (E=3), the known five-owner cover of the (q=8) pivot is

[
w=(1,13,15,27,28).
]

But

[
F(a_3)\setminus{8}={1}.
]

Thus only owner speed (1) is internal. The owners (13,15,27,28) are not covered pivots.

Owner (1) alone does not cover the candidate row. At

[
r=q=8,
]

we have (7\nmid8), so (r\in R_8), but

[
\rho_{56}(8\cdot1)=8.
]

Strict badness requires a distance (<8), so owner (1) is safe there. Consequently the singleton internal owner set is not a complete cover.

The same argument works for every (E\ge3):

[
7\nmid q,\qquad \rho_{7q}(q\cdot1)=q.
]

---

## 10. **Prompt95 synthesis**

The covered-pivot set can be determined symbolically for the entire family.

The pivots (1) and (q) are fully covered by Section 5. For each of

[
m\in{A,B,D,H},
]

Section 7 provides an explicit candidate residue

[
r_m=4m+1\in Q_m(a_E).
]

Therefore none of these four pivots is fully covered. Hence, for every (E\ge3),

[
F(a_E)={1,q}.
]

Since (q>1),

[
j_\star=q.
]

It follows that

[
F(a_E)\setminus{j_\star}={1}.
]

As established in Section 9, owner (1) does not cover the candidate (r=q). Thus there is no internal complete cover at (j_\star) for any member of this family.

Prompt95’s redundancy assertion is consequently not falsified. Its internal-cover premise is absent. The family also does not close the unrestricted theorem, because it establishes this structure only for the special tuples (a_E).

The exact all-(E) separation is:

[
\boxed{
F(a_E)={1,q},\quad j_\star=q,\quad
\text{no internal complete cover exists at }j_\star.
}
]

---

## 11. **Fixed-grid minimal-cover audit**

Retain the owner order

[
w=(1,C-1,C+1,H-1,H)
=(1,7t-1,7t+1,14t-1,14t)
]

at modulus (M=28t), with strict threshold (q=4t).

At the proposed private residues, the exact distance vectors in this owner order are:

[
\begin{array}{c|ccccc}
r&
1&C-1&C+1&H-1&H\ \hline
1&
1&7t-1&7t+1&14t-1&14t\
q+1=4t+1&
4t+1&3t-1&11t+1&10t-1&14t\
q+3=4t+3&
4t+3&11t+3&3t-3&10t-3&14t\
H-1=14t-1&
14t-1&7t+1&7t-1&1&14t\
q=4t&
4t&4t&4t&4t&0.
\end{array}
]

Because (t\ge2):

* In the first row, only distance (1) is below (4t).
* In the second row, only (3t-1) is below (4t).
* In the third row, only (3t-3) is below (4t).
* In the fourth row, only distance (1) is below (4t).
* In the fifth row, the four distances equal to (4t) are safe, while only distance (0) is bad.

Thus the private-owner badness vectors are exactly

[
\begin{aligned}
r=1 &: (1,0,0,0,0),\
r=q+1 &: (0,1,0,0,0),\
r=q+3 &: (0,0,1,0,0),\
r=H-1 &: (0,0,0,1,0),\
r=q &: (0,0,0,0,1).
\end{aligned}
]

Every owner has a private residue, so the five-owner full-grid cover is inclusion-minimal for every (E\ge3).

At (E=3), the numerical distance rows are

[
\begin{aligned}
r=1 &: (1,13,15,27,28),\
r=9 &: (9,5,23,19,28),\
r=11 &: (11,25,3,17,28),\
r=27 &: (27,15,13,1,28),\
r=8 &: (8,8,8,8,0).
\end{aligned}
]

This proves the fixed-grid private-residue claim as `proved-math-response`. It does not provide Prompt95 internality. Four owners of this minimal cover lie outside (F(a_E)), and some private residues may also be excluded from a pivot candidate row for particular congruence classes of (E).

---

## 12. **Dependency graph**

```text
audit301 accepted family v
    |
    | independent canonicality, gcd, cover, valuation replication
    |
    +--> E = E_6 = 117
    |       |
    |       +--> Prompt87/92 aggregate divisibility refuted-exact
    |
    +--> delete one duplicate labelled owner 1
            |
            +--> five-owner full-grid cover w
            |       |
            |       +--> independent private-residue table
            |       |       |
            |       |       +--> fixed-grid inclusion-minimality
            |       |               |
            |       |               +--> no Prompt95 implication
            |       |
            |       +--> derived injective tuple a_E
            |               |
            |               +--> q-pivot owner row equals w
            |                       |
            |                       +--> Q_q = empty
            |                       +--> DefUnit_q = 0
            |
            +--> speed-1 pivot covered by H modulo 7
                    |
                    +--> Q_1 = empty
                    +--> DefUnit_1 = 0

derived tuple a_E
    |
    +--> common unit witnesses r_m = 4m+1
            |
            +--> four other unit deficits are positive
            |       |
            |       +--> OmegaUnit(a_E) >= 4
            |       +--> no Prompt94 counterexample
            |
            +--> four other pivots are not covered
                    |
                    +--> F(a_E) = {1,q}
                    +--> j_star = q
                    +--> only internal owner is speed 1
                            |
                            +--> r=q is safe for owner 1
                            +--> no internal complete cover
                            +--> no Prompt95 counterexample
```

---

## 13. **Optional artifact ledger**

| Item                           | Status                      | Evidence treatment                                                                                              |
| ------------------------------ | --------------------------- | --------------------------------------------------------------------------------------------------------------- |
| Response code attachment       | `not-run`                   | No source file supplied.                                                                                        |
| Response result attachment     | `not-run`                   | No result file supplied.                                                                                        |
| Manifest or ZIP                | `not-run`                   | No attachment opened or generated.                                                                              |
| Quarantined Prompt92 artifacts | `unverified response input` | Not used.                                                                                                       |
| (E=3) row tables               | `proved-math-response`      | Established by the displayed exact modular criterion and residue sets; no finite-computation claim is promoted. |

Any unaudited arithmetic cross-check without a source, manifest, and replayable result has no evidentiary status beyond `not-run`.

---

## 14. **Proof-obligation ledger**

| Claim                                                                                             | Dependency                                    | Evidence class                                                           | Exact falsifier                                                                       | Owner                 |
| ------------------------------------------------------------------------------------------------- | --------------------------------------------- | ------------------------------------------------------------------------ | ------------------------------------------------------------------------------------- | --------------------- |
| Audit301 family has canonical coordinates, all deletion gcds (1), full cover, and valuation (E-1) | Frozen definitions                            | `proved-math-qualified` input; independently `proved-math-response` here | One noncanonical coordinate, deletion gcd (>1), uncovered residue, or wrong valuation | audit301 / response96 |
| (E_6=117)                                                                                         | Exact (A_6,T_6) arithmetic                    | `proved-math-qualified`; replicated as `proved-math-response`            | Failure of the displayed quotient or power-of-two inequalities                        | audit301 / response96 |
| Prompt87/92 aggregate bridge fails                                                                | Accepted family at (E=117)                    | `refuted-exact`, `proved-math-qualified`                                 | Product divisible by (2^{117}), or existence of a safe grid residue                   | audit301              |
| (a_E) is positive and injective                                                                   | (t=2^{E-2}\ge2)                               | `proved-math-response`                                                   | Failure of one strict inequality in the ordered tuple                                 | response96            |
| (Q_q(a_E)=\varnothing)                                                                            | Full-grid cover by (w)                        | `proved-math-response`                                                   | Candidate residue safe for all five nonpivot owners                                   | response96            |
| (\DefUnit_q(a_E)=0)                                                                               | (Q_q=\varnothing)                             | `proved-math-response`                                                   | An uncovered unit candidate                                                           | response96            |
| Four other pivots have uncovered unit residues                                                    | (r_m=4m+1) distance table                     | `proved-math-response`                                                   | One table entry below its pivot threshold, or (\gcd(r_m,7m)>1)                        | response96            |
| (\OmegaUnit(a_E)>0) for all (E\ge3)                                                               | Four positive deficits                        | `proved-math-response`                                                   | Any failure of the common unit-witness lemma                                          | response96            |
| Every-pivot positive-deficit strengthening fails                                                  | Zero rows at (1) and (q)                      | `refuted-exact`, supported by `proved-math-response`                     | Positive deficit at both rows                                                         | response96            |
| (F(a_E)={1,q})                                                                                    | Two covered rows and four uncovered witnesses | `proved-math-response`                                                   | Additional covered pivot or failure of the (1/q) covers                               | response96            |
| (j_\star=q)                                                                                       | Exact (F(a_E))                                | `proved-math-response`                                                   | A covered speed larger than (q)                                                       | response96            |
| No internal cover exists at (j_\star)                                                             | (F\setminus{q}={1}), (r=q) safe for owner (1) | `proved-math-response`                                                   | Owner (1) covering every (q)-candidate                                                | response96            |
| Five-owner fixed-grid cover is inclusion-minimal                                                  | Private-distance table                        | `proved-math-response`                                                   | One named private residue bad for another owner or safe for its named owner           | response96            |
| Prompt94 operative target for arbitrary tuples                                                    | None supplied                                 | `open`                                                                   | Exact unrestricted proof or exact domain-valid counterexample                         | Prompt94              |
| Prompt95 operative target for arbitrary tuples                                                    | None supplied                                 | `open`                                                                   | Exact unrestricted proof or exact domain-valid counterexample                         | Prompt95              |
| Unrestricted LRC                                                                                  | Out of scope                                  | `open`                                                                   | Independent complete proof or counterexample                                          | out-of-scope          |

---

## 15. **Final evidence boundary**

`input-accepted` consists of the frozen provenance identities and audit301 dependency stated in the contract.

`proved-math-qualified` remains limited to audit301’s accepted Prompt92 family, (E_6) arithmetic, and exact Prompt87/Prompt92 aggregate-route refutation.

`proved-math-response` in this turn consists of:

[
\begin{gathered}
a_E\text{ positive and injective},\
Q_q(a_E)=Q_1(a_E)=\varnothing,\
\DefUnit_q(a_E)=\DefUnit_1(a_E)=0,\
\DefUnit_m(a_E)\ge1
\quad(m=C-1,C+1,H-1,H),\
\OmegaUnit(a_E)\ge4,\
F(a_E)={1,q},\qquad j_\star=q,\
\text{absence of an internal complete cover at }j_\star,\
\text{and inclusion-minimality of the five-owner fixed-grid cover.}
\end{gathered}
]

No `computed finite evidence` is promoted. No artifact is evidentiary. Quarantined response material remains `unverified response input`.

The exact Prompt94 and Prompt95 unrestricted targets remain `open`. The completed result is an all-(E) family `SEPARATION`, not a transfer, unrestricted narrowing lemma, or Lonely Runner conclusion.
