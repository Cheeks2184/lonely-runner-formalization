## 1. Disposition

**STOP**

The frozen weighted compensation inequality was not refuted by the permitted finite scan, but neither modular attack produced the required cross-modulus transport. The first fatal arrow is destination safety: source-row private points and quotient/remainder data do not determine a residue in any (Q_k). The canonical nearest-boundary exchange already fails on ((1,3,4)). Finite zero-failure evidence cannot promote the lemma.

---

## 2. Status table

| Claim or dependency                                                                        | Status                     | Exact basis                                                             |
| ------------------------------------------------------------------------------------------ | -------------------------- | ----------------------------------------------------------------------- |
| `exists_witness_iff_exists_pivot_certificate`                                              | `proved-lean`              | Frozen repository dependency supplied in the contract                   |
| `positiveIntegerConjecture_iff_pivotCertificateConjecture`                                 | `proved-lean`              | Frozen repository dependency supplied in the contract                   |
| `conjecture_iff_positiveIntegerConjecture`                                                 | `proved-lean`              | Frozen repository dependency supplied in the contract                   |
| (Q_j=R_j\setminus\bigcup_{i\ne j}B_i^j), hence `Covers(j)` iff (\bigcup_{i\ne j}B_i^j=R_j) | `conditional`              | Complete elementary derivation below, pending independent audit         |
| Reflection and all-odd half-time fixed-point classification                                | `conditional`              | Complete derivation below, pending independent audit                    |
| Common-scaling law (G_j(ca)=cG_j(a)) and weight invariance                                 | `conditional`              | Complete derivation and finite regression, pending independent audit    |
| One-owner cover characterization (B_i^j=R_j\iff N a_j\mid a_i)                             | `conditional`              | Complete derivation below, pending independent audit                    |
| Frozen compensation lemma for (n=2)                                                        | `conditional`              | Complete exact special-case derivation below, pending independent audit |
| Mandatory fixture counts and weighted sides                                                | `computed finite evidence` | Exact integer replay from the frozen definitions                        |
| Primitive scan through largest speed (12)                                                  | `computed finite evidence` | 2,429 tuples and 806 covered rows, zero failures                        |
| (\sum_jG_j\ge n)                                                                           | `rejected`                 | ((1,2,3,4,5,7)) has total (4<6)                                         |
| Canonical private-point nearest-boundary exchange                                          | `rejected`                 | Explicit failure on ((1,3,4))                                           |
| A general explicit injection (T_j\to D_j)                                                  | `open`                     | Destination-goodness and collision transport remain unsupported         |
| A weighted charge-conservation law with the frozen capacities                              | `open`                     | No local identity transports covered-row incidence to (Q_k)             |
| `CROSS-PIVOT-WEIGHTED-DEFICIT-COMPENSATION`                                                | `open`                     | No counterexample in the permitted scan, no unrestricted proof          |
| Complete implication from the frozen lemma to unrestricted LRC                             | `conditional`              | Exact logical chain below; depends on the open lemma                    |
| Unrestricted real LRC                                                                      | `open`                     | No promotion                                                            |

No new claim is promoted to `proved-math` before independent audit.

---

## 3. Exact target

Let (n\ge2), (N=n+1), and let (a:\mathrm{Fin}\ n\to\mathbb N) be positive and injective. For each pivot (j), write

[
p_j=a_j,\qquad M_j=Np_j.
]

For (0\le x<M),

[
\rho_M(x)=\min(x\bmod M,;M-(x\bmod M)).
]

The candidate set is

[
R_j={r:0\le r<M_j,\ N\nmid r}.
]

It has cardinality

[
|R_j|=M_j-p_j=(N-1)p_j=np_j,
]

because the excluded representatives are exactly

[
0,N,2N,\ldots,(p_j-1)N.
]

For (i\ne j),

[
B_i^j={r\in R_j:\rho_{M_j}(ra_i)<p_j}.
]

Coincident bad sets retain separate owner indices. Define

[
\mu_j(r)=#{i\ne j:r\in B_i^j},
\qquad
Q_j={r\in R_j:\mu_j(r)=0},
\qquad
G_j=|Q_j|.
]

### Covers equivalence

For every (r\in R_j),

[
\mu_j(r)=0
\iff
\forall i\ne j,\ r\notin B_i^j
\iff
r\notin\bigcup_{i\ne j}B_i^j.
]

Therefore

[
Q_j=R_j\setminus\bigcup_{i\ne j}B_i^j.
]

Since every (B_i^j\subseteq R_j),

[
Q_j=\varnothing
\iff
R_j\subseteq\bigcup_{i\ne j}B_i^j
\iff
\bigcup_{i\ne j}B_i^j=R_j.
]

Thus finite-set subtraction is legitimate only after this equivalence.

### Strict boundary

Badness is exactly

[
\rho_{M_j}(ra_i)<p_j.
]

Its complement inside (R_j) is

[
\rho_{M_j}(ra_i)\ge p_j.
]

In particular, equality (\rho=p_j) is safe. No one-sided interval replacement is used.

### Reflection

The involution is

[
\iota_j(r)=(-r)\bmod M_j.
]

Because

[
\rho_{M_j}(-ra_i)=\rho_{M_j}(ra_i),
]

both (R_j) and (Q_j) are reflection invariant.

A fixed representative satisfies (2r\equiv0\pmod{M_j}). The zero residue is excluded. The only possible remaining fixed point is (r=M_j/2).

It belongs to (R_j) precisely when (N) is even and (a_j) is odd. At this point:

* if some (a_i) is even, then ((M_j/2)a_i\equiv0\pmod{M_j}), so the point is bad;
* if every (a_i) is odd, then ((M_j/2)a_i\equiv M_j/2\pmod{M_j}), whose cyclic distance is (M_j/2\ge p_j).

Hence the only reflection-fixed good point is the all-odd half-time point. It must be counted once.

### Weights

For (j\ne k),

[
d_{jk}=\gcd(a_j,a_k)>0,
\qquad
d_{jk}\mid a_k,
\qquad
w(j,k)=\frac{a_k}{d_{jk}}\in\mathbb N_{>0}.
]

The destination type has cardinality

[
\begin{aligned}
D_j
&=
\Sigma\left(k:{k:\mathrm{Fin}\ n\mid k\ne j}\right)
\left(\mathrm{Fin}(w(j,k))\times Q_k\right),\
|D_j|
&=
\sum_{k\ne j}w(j,k)G_k.
\end{aligned}
]

The frozen target is

[
\boxed{
\mathrm{Covers}(j)
\Longrightarrow
2a_j\le
\sum_{k\ne j}
\frac{a_k}{\gcd(a_j,a_k)}G_k
}.
]

This does not definitionally rename (\exists k,\ G_k>0). It imposes a fixed numerical demand for every covered source row and uses weights fixed before the good rows are known.

### Common scaling

For (c>0), put (a_i'=ca_i). Then (M_j'=cM_j). If (s=r\bmod M_j),

[
\rho_{cM_j}(r,ca_i)=c,\rho_{M_j}(s a_i).
]

Because (M_j) is divisible by (N), (r) and (s) have the same divisibility status modulo (N). Every residue (s) has exactly (c) lifts modulo (cM_j). Consequently,

[
G_j(ca)=cG_j(a).
]

Also,

[
\frac{ca_k}{\gcd(ca_j,ca_k)}
============================

\frac{a_k}{\gcd(a_j,a_k)}.
]

Both sides of the compensation inequality scale by (c).

---

## 4. Regression and non-tautology audit

All counts below were recomputed directly from the unique representatives (0\le r<N a_j).

| Tuple           |      (G)-vector | Covered-row demands and weighted sides                   | Additional checks                                                                       |
| --------------- | --------------: | -------------------------------------------------------- | --------------------------------------------------------------------------------------- |
| ((1,3,4))       |       ((0,2,2)) | speed (1): (2\le3\cdot2+4\cdot2=14)                      | (Q_3={5,7}), (Q_4={7,9})                                                                |
| ((1,3,4,5))     |     ((0,0,2,2)) | speed (1): (2\le18); speed (3): (6\le18)                 | The two covered rows remain separately indexed                                          |
| ((1,2,3,4,5,7)) | ((0,0,0,0,2,2)) | speeds (1,2,3,4): weighted side (24); demands (2,4,6,8)  | (Q_5={6,29}\pmod{35}), (Q_7={8,41}\pmod{49})                                            |
| ((1,2,8))       |       ((0,0,6)) | speed (1): (2\le8\cdot6=48); speed (2): (4\le4\cdot6=24) | Exactly one good pivot                                                                  |
| ((1,3))         |         ((0,2)) | speed (1): (2\le3\cdot2=6)                               | (Q_3={4,5}\pmod9), a reflection pair                                                    |
| ((1,2,3))       |       ((2,2,2)) | No covered row                                           | At speed (3), (r=3) has (\rho_{12}(3\cdot1)=3), exactly safe                            |
| ((4,5,9))       |       ((2,2,4)) | No covered row                                           | The stated Fourier failure is not used or rederived                                     |
| ((1,3,5))       |       ((3,3,5)) | No covered row                                           | Fixed half-time residues (2,6,10), each counted once                                    |
| ((1,3,13))      |       ((3,5,9)) | No covered row                                           | At speed (3), owners (1) and (13) both have (B={1,2,10,11}), but remain separate owners |

For ((1,2,3,4,5,7)),

[
\sum_jG_j=4<6.
]

This decisively rejects (\sum_jG_j\ge n). It does not reject the frozen weighted inequality.

The audit also checked:

* (r=0) and an in-range multiple of (N) are excluded;
* (\rho=p_j-1) is bad and (\rho=p_j) is safe;
* reflection invariance for every computed (Q_j);
* the half-modulus antipode and its fixed-point handling;
* the pair (4,9), where neither divides the other;
* the pair (2,4), with nontrivial gcd;
* all (6+24+720=750) permutations of fixtures 1 through 3;
* common scaling by (2), including (G_j(2a)=2G_j(a)), invariant weights, and scaling of both sides.

### Exact (n=2) audit candidate

Let (N=3), with source speed (p) and the only other speed (q). If the source row is covered, then the single owner satisfies

[
B_q^p=R_p.
]

More generally, for (N\ge3),

[
B_q^p=R_p
\iff
Np\mid q.
]

For the nontrivial direction, assume (B_q^p=R_p). Since (1\in R_p),

[
\rho_{Np}(q)<p.
]

Write (q\equiv\pm u\pmod{Np}) with (0\le u<p). If (u>0):

* when (2u\ge p), choose (r=2), which is not divisible by (N);
* when (2u<p), put (c=\lceil p/u\rceil), and choose (r=c) unless (N\mid c), in which case choose (r=c+1).

In either case (N\nmid r) and

[
p\le ru<2p.
]

Since (Np-ru\ge p) for (N\ge3),

[
\rho_{Np}(rq)\ge p,
]

contradicting complete coverage. Thus (u=0), so (Np\mid q). The converse is immediate.

For (n=2), therefore,

[
q=3mp
]

for some (m\ge1). At the (q)-pivot,

[
M_q=3q=9mp.
]

The owner-(p) safety condition reduces to

[
\rho_{9m}(r)\ge3m.
]

Modulo (9m), this selects the interval (3m\le r\le6m). It contains (3m+1) residues, of which (m+1) are divisible by (3). Thus there are (2m) candidates per lift and (p) lifts:

[
G_q=2mp.
]

The weight is

[
w(p,q)=\frac q{\gcd(p,q)}=3m.
]

Hence

[
w(p,q)G_q
=========

# 3m\cdot2mp

6m^2p
\ge2p.
]

Thus the frozen compensation inequality has an exact special-case derivation for (n=2), pending independent audit.

---

## 5. Attack A

### Canonical minimal cover and private points

Fix a covered pivot (j). Order owner subsets lexicographically by their natural index bit-vectors, and choose the first inclusion-minimal subset (I_j) satisfying

[
\bigcup_{i\in I_j}B_i^j=R_j.
]

For each (i\in I_j), inclusion minimality gives

[
\bigcup_{\substack{h\in I_j\h\ne i}}B_h^j\ne R_j.
]

Choose the least representative outside that smaller union. Since the full union covers (R_j), this representative lies in (B_i^j). Therefore a canonical private point exists:

[
r_{j,i}\in
B_i^j\setminus
\bigcup_{\substack{h\in I_j\h\ne i}}B_h^j.
]

This fact alone is source-row information. A private point can still belong to bad sets owned by indices outside (I_j).

### Natural (2a_j)-token set

The (2a_j) source-boundary candidates are

[
E_j=
{Nm+1,;Nm+(N-1):0\le m<a_j}.
]

They are distinct because (N\ge3), and each has pivot-coordinate distance exactly (a_j). Thus (E_j) is canonically bijective with (T_j=\mathrm{Fin}(2a_j)).

Since the row is covered, every element of (E_j) has at least one blocking owner.

### Nearest-boundary exchange rule

For a source token (e\in E_j) blocked by (i), write the centered quotient/remainder equation

[
ea_i=qM_j+s,
\qquad
-a_j<s<a_j.
]

The most direct owner exchange sends it to pivot (i) at one of the nearest boundary residues

[
u_\pm=(Nq\pm1)\bmod(Na_i).
]

These are valid pivot-(i) candidate representatives, but they need not avoid the other destination owners.

### First fatal token

Take

[
a=(1,3,4),\qquad n=3,\qquad N=4,
]

with source pivot (j) of speed (1). Then

[
M_j=4,\qquad R_j={1,2,3}.
]

The speed-(3) owner has empty bad set. The speed-(4) owner has

[
B_4^j=R_j.
]

Hence the canonical minimal cover is the singleton ({4}), and its least private point is (r=1).

For the first source boundary token (e=1),

[
e\cdot4=4=1\cdot M_j+0.
]

Thus (q=1), (s=0), and the two nearest destination boundaries at the speed-(4) pivot are

[
u_-=3,\qquad u_+=5
]

modulo (16).

They are both bad:

[
\rho_{16}(3\cdot1)=3<4,
]

so (3\notin Q_4), while

[
\rho_{16}(5\cdot3)=\rho_{16}(15)=1<4,
]

so (5\notin Q_4).

The reflected source token (e=3) gives (q=3) and destination residues (11,13). Again,

[
\rho_{16}(11\cdot3)=1<4,
\qquad
\rho_{16}(13\cdot1)=3<4.
]

The actual good destination residues are

[
Q_4={7,9}.
]

No choice of sign in the nearest-boundary rule reaches either one. The slot range is not the obstruction:

[
w(1,4)=4,
]

so four slots are available for each good residue. The failure occurs earlier, at destination membership in (Q_4).

This rejects the canonical private-point nearest-boundary exchange. It does not refute every possible arithmetic injection and does not refute the frozen lemma.

The first unsupported unrestricted arrow remains

[
(e,i,q,s)
\longmapsto
(k,\text{slot},r_k)
\quad\text{with}\quad
r_k\in Q_k,
]

where (k) and (r_k) must be determined without first inspecting which (Q_k) are nonempty.

---

## 6. Attack B

Define the owner-indexed incidence object

[
\mathcal I=
{(j,i,r):
j\ne i,\ r\in R_j,\ r\in B_i^j}.
]

Coincident bad sets produce distinct triples because the owner coordinate is retained.

For a fixed destination row (k), the exact first-moment identity is

[
\sum_{i\ne k}|B_i^k|
====================

\sum_{r\in R_k}\mu_k(r).
]

However,

[
G_k=#{r\in R_k:\mu_k(r)=0}
]

is not controlled from below by that first moment. Large overlap can increase the incidence total while leaving uncovered residues.

In ((1,2,3,4,5,7)):

* at the speed-(5) pivot, (|R_5|=30), the total owner incidence is (38), yet (G_5=2);
* at the speed-(7) pivot, (|R_7|=42), the total owner incidence is (60), yet (G_7=2).

The raw union-bound estimates are therefore

[
G_5\ge30-38=-8,
\qquad
G_7\ge42-60=-18,
]

which provide no positive capacity.

A canonical charge can assign each source boundary token to its least blocking owner. That accounts for (2a_j) units of covered-row demand, but the charge lands on a bad incidence ((j,i,r)), not on an uncovered residue at another pivot.

Transporting the charge through the centered quotient/remainder equation encounters exactly the Attack A failure. For ((1,3,4)), every source-boundary token is blocked by speed (4), yet all nearest transported boundary residues at the speed-(4) modulus are bad. There is no local conservation identity converting these incidences into the actual good residues (7,9).

A rule that first enumerates the sets (Q_k), then chooses (7) or (9), is post hoc. Its capacity condition is

[
2a_j\le\sum_{k\ne j}w(j,k)G_k,
]

which is the target inequality itself. Invoking finite cardinality to obtain an injection after assuming this inequality is circular.

Thus the first fatal charge arrow is

[
\text{covered-row incidence}
;\not\Longrightarrow;
\text{explicit uncovered destination residue}.
]

No nonnegative integer charge law with the frozen capacities was established.

---

## 7. Falsification

### Implementation

* Language: Python
* Implementation: CPython 3.13.5
* Dependencies: standard library only
* Command:

```text
python3 p69_compensation_audit.py p69_compensation_audit.json
```

* Schema:

```text
p69-cross-pivot-weighted-deficit-compensation-audit/v1
```

### Domain and ordering

The program first ran all mandatory regressions. It then enumerated:

[
n=2,3,4,5,6,
]

with primitive strictly increasing positive integer tuples whose largest speed is at most (12).

Ordering was:

1. (n) ascending;
2. tuples in lexicographic `itertools.combinations` order;
3. source pivots in natural index order;
4. residues by their unique natural representatives.

The stop rule was the first covered pivot satisfying

[
2a_j>
\sum_{k\ne j}w(j,k)G_k.
]

### Results

|       (n) | Primitive tuples | Covered rows |
| --------: | ---------------: | -----------: |
|         2 |               45 |            4 |
|         3 |              196 |           43 |
|         4 |              479 |          137 |
|         5 |              786 |          351 |
|         6 |              923 |          271 |
| **Total** |        **2,429** |      **806** |

No violating covered row was found.

The closest relative case was

[
(1,4,5,6,7,11),
]

with

[
G=(0,0,0,2,2,0).
]

For the covered source speed (11),

[
2a_j=22,
]

while

[
6\cdot2+7\cdot2=26.
]

Thus

[
\frac{\mathrm{RHS}}{\mathrm{LHS}}=\frac{13}{11}.
]

This is `computed finite evidence` only. It neither proves the unrestricted inequality nor earns `PIVOT`.

No exact counterexample to the frozen inequality was obtained.

---

## 8. Complete implication chain

This section is `conditional` on the frozen compensation lemma.

### (n=1)

Let the unique speed be (p>0). Then (N=2), (M=2p), and there are no nonpivot bad owners.

The candidate set consists of the odd residues modulo (2p), so it is nonempty. For example, (r=1) gives

[
\rho_{2p}(1\cdot p)=p.
]

Therefore the unique coordinate is safe at the closed threshold (1/2). No second pivot is invoked.

### (n\ge2)

Fix any pivot (j).

If (Q_j\ne\varnothing), choose (r\in Q_j). This is already a canonical pivot certificate.

Otherwise (Q_j=\varnothing), hence `Covers(j)`. Apply the frozen lemma:

[
2a_j
\le
\sum_{k\ne j}w(j,k)G_k.
]

Since (a_j>0),

[
2a_j>0.
]

Therefore the finite natural-number sum on the right is positive. A finite sum of nonnegative naturals is positive only if some summand is positive, so there exists (k\ne j) with

[
w(j,k)G_k>0.
]

Because (w(j,k)>0), natural-number product positivity gives

[
G_k>0.
]

Hence (Q_k\ne\varnothing). Choose (r\in Q_k).

For every (i\ne k),

[
\mu_k(r)=0
\Longrightarrow
r\notin B_i^k
\Longrightarrow
\rho_{Na_k}(ra_i)\ge a_k.
]

For the pivot coordinate, write

[
r=Nq+s,
\qquad
1\le s\le N-1,
]

using (N\nmid r). Then

[
(ra_k)\bmod(Na_k)=s a_k,
]

and therefore

[
\rho_{Na_k}(ra_k)
=================

a_k\min(s,N-s)
\ge a_k.
]

At the time

[
t=\frac{r}{Na_k},
]

every coordinate satisfies

[
|a_i t|
=======

\frac{\rho_{Na_k}(ra_i)}{Na_k}
\ge
\frac1N.
]

Thus (r) supplies the exact canonical pivot certificate and the fixed-instance integer witness.

### Repository arrows

With the equivalences oriented as named:

1. From a canonical pivot certificate, use

   ```text
   exists_witness_iff_exists_pivot_certificate.mpr
   ```

   to obtain the corresponding fixed-instance integer witness.

2. Since (n) and the positive injective integer tuple were arbitrary, obtain

   ```text
   PositiveIntegerPivotCertificateConjecture.
   ```

3. Apply

   ```text
   positiveIntegerConjecture_iff_pivotCertificateConjecture.mpr
   ```

   to obtain

   ```text
   PositiveIntegerConjecture.
   ```

4. Apply

   ```text
   conjecture_iff_positiveIntegerConjecture.mpr
   ```

   to obtain

   ```text
   Conjecture.
   ```

5. By the frozen repository interpretation of `Conjecture`, obtain unrestricted real LRC.

The finite-sum and product-positivity steps are explicit. The chain remains conditional because the frozen compensation lemma remains open.

---

## 9. Artifacts and replay

* [Python audit source](sandbox:/mnt/data/p69_compensation_audit.py)
  SHA-256: `d8362aec4061ac06d91bb693b132a0b8399978cbc283b024bfa2a88dbd7fb9f7`

* [Machine-readable audit output](sandbox:/mnt/data/p69_compensation_audit.json)
  SHA-256: `3fe8d4b0eabce987f418c8e0d60881a1af6fd27f1aa79a70e611da1492ec2952`

No Lean prototype was created.

---

## 10. Final boundary

**`proved-lean`**

Only the three frozen repository equivalences supplied in the contract.

**`proved-math`**

No new promotion. The elementary arguments in this memo require independent audit before receiving that label.

**`computed finite evidence`**

All mandatory regressions, all 750 required permutations, scaling checks, and the primitive scan of 2,429 tuples and 806 covered rows. No frozen-inequality failure was found.

**`conditional`**

The Covers equivalence, reflection classification, scaling law, one-owner cover characterization, the (n=2) special case, and the implication chain from the frozen lemma to unrestricted LRC, pending independent audit and, for the final chain, the open lemma.

**`rejected`**

* (\sum_jG_j\ge n);
* the canonical private-point nearest-boundary exchange;
* any promotion from the bounded zero-failure scan;
* any injection obtained solely by assuming the desired cardinal inequality;
* any charge rule that selects a destination after inspecting which (Q_k) are nonempty.

**`open`**

* `CROSS-PIVOT-WEIGHTED-DEFICIT-COMPENSATION`;
* a noncircular explicit map (T_j\to D_j);
* a weighted charge-conservation identity with the frozen capacities;
* unrestricted real LRC.

The `STOP` disposition rejects the present exchange and charge routes at their first unsupported destination-safety arrow. It does not refute the frozen compensation lemma and does not refute LRC.
