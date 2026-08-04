## 1. **Disposition**: `PIVOT`

The symbolic counterfamily is valid for every (q\ge 8) with (4\mid q). It disproves `PowerForcing(4,q)` throughout that range and therefore disproves Prompt84’s exact `DYADIC-VALUATION-FORCING` target.

One proposed consequence is too strong. The family satisfies

[
\prod_{i=0}^{3}v_i
=4\left(\frac{5q}{2}-1\right)\frac{5q}{2}
=10q\left(\frac{5q}{2}-1\right),
]

so (q\mid\prod_i v_i). It refutes the stronger conclusion that a full bad cover forces (q) into one coordinate, but it does not refute the weaker conclusion that a full bad cover forces (q) into the total coordinate product.

The sole admitted pivot is therefore the aggregate dyadic cover-divisibility lemma stated in Section 7. That lemma is open, not proved here. It is strictly weaker than `PowerForcing`, is satisfied by the counterfamily, has no LRC-counterexample premise, and has a complete conditional implication to the exact pivot certificate through the external MSS product bound.

---

## 2. **Independent counterfamily proof**

Write

[
q=4h,\qquad h\ge 2.
]

Then

[
N=5,\qquad M=5q=20h,
]

and the four coordinates are

[
v_0=1,\qquad
v_1=4,\qquad
v_2=10h-1,\qquad
v_3=10h.
]

### Domain

Since (h\ge 2),

[
0<1<4<10h-1<10h<20h=M.
]

Thus every (v_i) is an integer in ({0,\ldots,M-1}).

The divisions by two in the original notation are legitimate because (4\mid q), so (q/2=2h) is an integer and (M/2=10h).

### Whole-(q) nondivisibility

For (v_0) and (v_1),

[
0<1<q,\qquad 0<4<q,
]

because (q\ge 8). Hence (q\nmid v_0,v_1).

For the remaining coordinates,

[
v_2=10h-1=2q+(2h-1),
]

with

[
0<2h-1<4h=q,
]

and

[
v_3=10h=2q+2h,
]

with

[
0<2h<4h=q.
]

Therefore (q) divides none of (v_0,v_1,v_2,v_3).

### Every deletion gcd

The four deletion gcds are separately:

[
\gcd(M,v_1,v_2,v_3)
=\gcd(20h,4,10h-1,10h).
]

Any common divisor on the right divides (4) and (10h-1). Since (10h-1) is odd,

[
\gcd(4,10h-1)=1,
]

so

[
\gcd(M,v_1,v_2,v_3)=1.
]

For the other deletions, (v_0=1) survives:

[
\gcd(M,v_0,v_2,v_3)=1,
]

[
\gcd(M,v_0,v_1,v_3)=1,
]

[
\gcd(M,v_0,v_1,v_2)=1.
]

This is exactly the common deletion gcd required by the definition. No pairwise-coprimality assertion is used.

### Strict cover: even residues

Let (x\in{0,\ldots,M-1}) be the representative of (r).

Because (M=20h) is even, parity is well-defined on (\mathbb Z/M\mathbb Z).

If (r) is even, write (r=2s). Then

[
rv_3=r\frac M2=2s\frac M2=sM\equiv0\pmod M.
]

Thus

[
\rho_M(rv_3)=0<q.
]

Every even residue is strictly bad for owner (v_3).

### Strict cover: odd residues

Suppose now that (r), and therefore (x), is odd. Assume for contradiction that all four coordinates are safe.

Safety for (v_0=1) gives

[
\rho_M(x)\ge q=4h.
]

For (0\le x<M=20h), this is equivalent to

[
4h\le x\le16h.
\tag{2.1}
]

Since (r) is odd,

[
r\frac M2\equiv\frac M2\pmod M.
]

Consequently,

[
rv_2
=r\left(\frac M2-1\right)
\equiv\frac M2-x
=10h-x
\pmod M.
]

On the interval in (2.1),

[
-6h\le10h-x\le6h.
]

Because (6h<M/2=10h), no antipodal wrap changes the distance, and therefore

[
\rho_M(rv_2)=|10h-x|.
]

Safety for (v_2) is

[
|10h-x|\ge4h.
]

Intersecting this with (4h\le x\le16h) leaves exactly

[
x\in[4h,6h]\cup[14h,16h].
\tag{2.2}
]

These are the intervals

[
[q,3q/2]\cup[7q/2,4q].
]

### The first cyclic side and the split at (5q/4)

On

[
4h\le x\le6h,
]

split at

[
5h=\frac{5q}{4}.
]

For (4h\le x\le5h),

[
16h\le4x\le20h,
]

and

[
\rho_M(4x)=20h-4x.
]

Hence

[
\rho_M(4x)\ge4h
\iff 20h-4x\ge4h
\iff x\le4h.
]

Within the interval, this occurs only at

[
x=4h=q.
]

For (5h\le x\le6h),

[
0\le4x-20h\le4h,
]

and

[
\rho_M(4x)=4x-20h.
]

Thus

[
\rho_M(4x)\ge4h
\iff 4x-20h\ge4h
\iff x\ge6h.
]

Within this interval, this occurs only at

[
x=6h=\frac{3q}{2}.
]

At the split (x=5h),

[
4x=20h\equiv0\pmod M,
]

so the distance is (0), not (q).

Therefore, on the entire first interval,

[
\rho_M(4x)\ge q
\iff x=q\ \text{or}\ x=\frac{3q}{2}.
\tag{2.3}
]

At both endpoints in (2.3), the distance is exactly (q), so those endpoints are safe for (v_1).

### The reflected cyclic side and the split at (15q/4)

On

[
14h\le x\le16h,
]

split at

[
15h=\frac{15q}{4}.
]

For (14h\le x\le15h), reduction modulo (20h) gives a residue in ([16h,20h]), and

[
\rho_M(4x)=60h-4x.
]

Thus

[
\rho_M(4x)\ge4h
\iff 60h-4x\ge4h
\iff x\le14h.
]

This occurs only at

[
x=14h=\frac{7q}{2}.
]

For (15h\le x\le16h),

[
0\le4x-60h\le4h,
]

and

[
\rho_M(4x)=4x-60h.
]

Therefore

[
\rho_M(4x)\ge4h
\iff 4x-60h\ge4h
\iff x\ge16h,
]

which occurs only at

[
x=16h=4q.
]

At (x=15h), (4x=60h\equiv0\pmod M), so the distance is (0).

Equivalently, put (x'=M-x). Then (x'\in[4h,6h]) and

[
4x\equiv-4x'\pmod M,
\qquad
\rho_M(4x)=\rho_M(4x'),
]

which reflects the first-side calculation exactly.

Hence on the second interval,

[
\rho_M(4x)\ge q
\iff x=\frac{7q}{2}\ \text{or}\ x=4q.
\tag{2.4}
]

Again, equality (\rho_M(4x)=q) holds at all listed endpoints.

### Endpoint parity and strictness

The only possible values of an all-safe odd residue are therefore

[
4h,\quad6h,\quad14h,\quad16h.
]

All four are even integers. They cannot equal the odd representative (x).

Thus no odd residue is safe for all four coordinates.

More explicitly, for an odd (x):

* outside ([4h,16h]), owner (v_0) is strictly bad;
* inside ((6h,14h)), owner (v_2) is strictly bad;
* in the two outer intervals of (2.2), excluding the four even endpoints, owner (v_1) is strictly bad.

The four equality endpoints are safe for (v_0,v_1,v_2), but they are even, and owner (v_3) has distance zero there. Therefore the weak/strict boundary is handled correctly:

[
\rho=q\quad\text{is safe},
]

and the complete cover still uses only strict badness (\rho<q).

It follows that

[
\forall,0\le r<M,\quad
\exists,i<4:\ \rho_M(rv_i)<q.
]

Together with the domain, deletion-gcd, and nondivisibility checks, this proves

[
\neg\operatorname{PowerForcing}(4,q)
]

for every (q\ge8) divisible by four.

For every (E\ge3), (q=2^E) satisfies these hypotheses, giving the dyadic corollary.

---

## 3. **Literal (q=8) and ordinary-pivot audit**

For

[
q=8,\qquad M=40,
]

the tuple is

[
v=(1,4,19,20).
]

### Four deletion gcds

Deleting coordinate (0):

[
\gcd(40,4,19,20)=1.
]

Deleting coordinate (1):

[
\gcd(40,1,19,20)=1.
]

Deleting coordinate (2):

[
\gcd(40,1,4,20)=1.
]

Deleting coordinate (3):

[
\gcd(40,1,4,19)=1.
]

Also,

[
8\nmid1,\qquad8\nmid4,\qquad8\nmid19,\qquad8\nmid20.
]

### Complete exact residue-owner compression

The following four classes partition all (40) residues.

| Residues (r)              | Chosen bad owner |     Exact distance |      |                   |
| ------------------------- | ---------------: | -----------------: | ---- | ----------------- |
| Every even (r)            |         (v_3=20) | (\rho_{40}(20r)=0) |      |                   |
| (1,3,5,7,33,35,37,39)     |          (v_0=1) |  (1,3,5,7,7,5,3,1) |      |                   |
| (9,11,29,31)              |          (v_1=4) |  (\rho_{40}(4r)=4) |      |                   |
| (13,15,17,19,21,23,25,27) |         (v_2=19) |   (\rho_{40}(19r)= | 20-r | =7,5,3,1,1,3,5,7) |

For the last row, since (r) is odd,

[
19r=(20-1)r\equiv20-r\pmod{40}.
]

Every displayed owner distance is strictly below (8).

### Four equality endpoints

The four residues at which (v_1) has distance exactly (8) are even:

|  (r) | (\rho_{40}(r)) | (\rho_{40}(4r)) | (\rho_{40}(19r)) | (\rho_{40}(20r)) |
| ---: | -------------: | --------------: | ---------------: | ---------------: |
|  (8) |            (8) |             (8) |              (8) |              (0) |
| (12) |           (12) |             (8) |             (12) |              (0) |
| (28) |           (12) |             (8) |             (12) |              (0) |
| (32) |            (8) |             (8) |              (8) |              (0) |

Thus equality at (8) remains safe for the first three relevant coordinates. The cover at these residues comes from (v_3), with strict distance (0<8).

### Independent ordinary pivot at modulus (95)

Now use the ordinary pivot speed

[
p=19,
\qquad
Np=5\cdot19=95,
\qquad
r=31.
]

The candidate exclusion holds:

[
5\nmid31.
]

Coordinate by coordinate:

[
31\cdot1=31,
\qquad
\rho_{95}(31)=31.
]

[
31\cdot4=124\equiv29\pmod{95},
\qquad
\rho_{95}(124)=29.
]

[
31\cdot19=589=6\cdot95+19,
\qquad
\rho_{95}(589)=19.
]

[
31\cdot20=620=6\cdot95+50,
\qquad
\rho_{95}(620)=\min(50,45)=45.
]

Therefore the four distances are

[
(31,29,19,45),
]

all at least (19), with equality retained at the pivot coordinate.

At time

[
t=\frac{31}{95},
]

the normalized circle distances are

[
\left(
\frac{31}{95},
\frac{29}{95},
\frac{19}{95},
\frac{45}{95}
\right)
\ge
\left(
\frac15,\frac15,\frac15,\frac15
\right).
]

Thus ((1,4,19,20)) is not an LRC counterexample. This ordinary modulus-(95) witness does not produce a safe residue at the unrelated fixed modulus (40), so it does not repair `PowerForcing(4,8)`.

### Symmetries

Let (u) be a unit modulo (M), and let (\sigma) be a coordinate permutation. Define

[
w_i\equiv u,v_{\sigma(i)}\pmod M
]

using representatives in ({0,\ldots,M-1}).

Multiplication by (u) preserves all deletion gcds because it is an automorphism modulo (M). It also preserves whole-(q) nondivisibility: if (q\mid w_i), then (q\mid u v_{\sigma(i)}), and (\gcd(u,q)=1) gives (q\mid v_{\sigma(i)}), a contradiction.

For coverage, (r\mapsto ru) is a permutation of (\mathbb Z/M\mathbb Z). Hence the complete strict bad cover for (v) transports to one for (w). Coordinate permutation only relabels owners.

These operations produce the same fixed-modulus symmetry orbit. They do not establish a counterfamily for other dimensions, odd moduli, or unrelated (q).

---

## 4. **Prompt84 impact table**

| Statement                                                  | Disposition                                   | Exact consequence                                                                                                                                                                        |
| ---------------------------------------------------------- | --------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1. `PowerForcing(4,q)` for (q\ge8), (4\mid q)              | **Killed**                                    | The symbolic family satisfies every premise and has a complete strict bad cover. The maximal proved counterfamily is all sufficiently large multiples of four, not merely powers of two. |
| 2. Prompt84 `DYADIC-VALUATION-FORCING`                     | **Killed**                                    | Its universal dimension quantifier includes (n=4), and (q_4=2^{32}) lies in the counterfamily.                                                                                           |
| 3. Eventual dyadic or eventual (4)-multiple `PowerForcing` | **Killed**                                    | The failure occurs for every (2^E), (E\ge3), and every (q\ge8) with (4\mid q).                                                                                                           |
| 4. One-large-dyadic replacement for C2                     | **Split**                                     | The exact `PowerForcing` implementation is killed. The stronger claim that the family prevents forcing (q\mid\prod_i v_i) is not valid: the family already has (q\mid\prod_i v_i).       |
| 5. `PowerForcing(4,4) -> PowerForcing(4,8)`                | **Untouched unless the antecedent is proved** | The consequent is false. The implication is refuted only if `PowerForcing(4,4)` is independently established. A zero-failure scan is not such a proof.                                   |
| 6. Odd prime powers and odd primes                         | **Surviving**                                 | They are outside the theorem. For odd (q), (M=5q) is odd, (M/2) is not an integer residue, and there is no nonzero element of order two supporting the even/odd cover.                   |
| 7. Prompt79 prime-independent obstruction supply           | **Surviving and open**                        | The family concerns composite moduli (5q) with (4\mid q). It supplies no new bad odd prime and no fixed nonzero obstruction integer controlling failures at varying prime moduli.        |
| 8. Repairs based on counterexample origin                  | **Rejected when circular**                    | Excluding the family because the exact representative tuple has an ordinary pivot does not prove that all lifts or all counterexample reductions avoid the same residue pattern.         |
| Aggregate dyadic product divisibility                      | **Surviving open edge**                       | The counterfamily satisfies the conclusion (q\mid\prod_i v_i). It therefore cannot falsify the aggregate lemma in Section 7.                                                             |

For (q=4), the same displayed tuple would contain (v_1=4), so premise (ii) fails. Consequently the family theorem says nothing about `PowerForcing(4,4)`.

A failure at (q=2^E) also does not descend to a failure at (q=2). Both the modulus and safety threshold change, and no monotonicity theorem has been proved.

---

## 5. **Prompt67/Prompt79/C2 synthesis**

Let (T_n) denote the exact strict MSS product threshold used by C2.

### Accepted logical spine

[
\boxed{
\text{real-speed LRC}
\Longleftrightarrow
\text{positive-integer LRC}
\Longleftrightarrow
\text{exact positive-integer pivot certificate}
}
]

This spine is `proved-lean` at the frozen quantifiers and closed threshold.

For a primitive minimal positive-integer counterexample (A=(a_i)), the accepted C2 normalization provides

[
\gcd{a_i:i\ne k}=1
\quad\text{for every }k.
]

Reducing modulo (M=Np) preserves the required deletion gcds. Indeed, any common divisor of (M) and the surviving residues also divides the corresponding surviving (a_i).

### PrimeForcing arrow

For a prime (p), assume `PrimeForcing(n,p)`. If a hypothetical LRC counterexample had (p\nmid a_i) for every (i), the reduced tuple would satisfy the nondivisibility and deletion-gcd premises. `PrimeForcing` would then supply a fixed-grid witness, contradicting counterexamplehood.

Therefore

[
\text{counterexample}
+\operatorname{PrimeForcing}(n,p)
\Longrightarrow
p\mid\prod_i a_i.
]

For a finite set (P_n) of distinct good primes,

[
Q_n:=\prod_{p\in P_n}p
]

then satisfies

[
Q_n\mid\prod_i a_i.
]

If

[
Q_n>T_n,
]

the positive speed product is at least (Q_n), contradicting the external MSS strict upper bound

[
\prod_i a_i<T_n
]

for a primitive minimal counterexample.

This yields the exact pivot certificate and then real-speed LRC through the accepted Lean equivalences.

### Prompt67 status

The accepted small-prime result gives `PrimeForcing(n,p)` for primes

[
p\le N=n+1.
]

That finite prime product remains below the required MSS threshold, so it does not complete C2.

The known failures

[
(n,p)=(3,5),\qquad(n,p)=(4,7)
]

show that a theorem declaring every prime good is false. They do not rule out a sufficiently large finite set of distinct good primes.

### Prompt79 obstruction branch

The desired Prompt79 implication is:

[
\boxed{
p\text{ is a bad prime}
\Longrightarrow
p\mid D_n
}
]

for one fixed nonzero integer (D_n) independent of (p).

Conditional on such a (D_n), the accepted Euclidean and factorial-interval extraction produces sufficiently many distinct primes not dividing (D_n). Those primes are good, and their product can cross (T_n).

Prompt79 currently has:

* accepted anchor/CRT normalization;
* accepted private-point cross-minor identities;
* rejected proposed full determinant and annihilator constructions;
* no accepted fixed prime-independent (D_n).

Thus `OBSTRUCTION-EXTRACTION-DISTINCT-PRIME-SUPPLY` remains open.

### Effect of the four-divisible family on this graph

The family gives

[
\neg\operatorname{PowerForcing}(4,2^E)
]

for every (E\ge3), but it gives no failure of `PrimeForcing(4,p)` for any new prime (p). Its only prime base is (2), repeated through higher powers. C2 requires distinct primes.

It also supplies no fixed speed tuple failing at infinitely many primes and no prime-independent obstruction integer. Therefore it does not invalidate the Prompt79 obstruction-extraction objective.

### Surviving dyadic arrow

The killed arrow was

[
\text{complete bad cover}
\Longrightarrow
\exists i:\ 2^E\mid v_i.
]

The family disproves this.

The strictly weaker arrow

[
\text{complete bad cover}
\Longrightarrow
2^E\mid\prod_i v_i
]

is not disproved. For the family,

[
\nu_2!\left(\prod_i v_i\right)
==============================

\nu_2(4)+\nu_2(5\cdot2^{E-1})+\nu_2(5\cdot2^{E-1}-1)
=2+(E-1)+0
=E+1.
]

It therefore contains more than the required total (2)-adic multiplicity.

---

## 6. **Circularity audit**

| Proposed repair                                                                                  | Family test                                       | Independent status                                                                                                        | Verdict                 |
| ------------------------------------------------------------------------------------------------ | ------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- | ----------------------- |
| Require distinct residues                                                                        | The family already has four distinct coordinates  | No exclusion                                                                                                              | Fails to repair         |
| Forbid repeated residues                                                                         | The family has no repetitions                     | No exclusion                                                                                                              | Fails to repair         |
| Require (\gcd(N,q)=1)                                                                            | For dyadic (q), (\gcd(5,q)=1)                     | Family remains inside                                                                                                     | Fails to repair         |
| Require every coordinate to be a unit modulo (M)                                                 | Excludes (v_1) and (v_3)                          | No proved reduction theorem gives coordinatewise units; nonunits are explicitly allowed                                   | Unsupported restriction |
| Require pairwise-coprime coordinates                                                             | Excludes the family                               | Deletion gcd does not imply pairwise coprimality, and no minimal-counterexample theorem supplies it                       | Unsupported restriction |
| Forbid the half-modulus residue (M/2)                                                            | Excludes (v_3)                                    | No independent theorem shows that arbitrary counterexample reductions avoid the order-two residue                         | Unsupported restriction |
| Require (q) odd or prime                                                                         | Excludes the family                               | Abandons the dyadic route and returns to the open distinct-prime program                                                  | Not a dyadic salvage    |
| Add a candidate-residue exclusion                                                                | The family has no safe residue at all             | Restricting the candidate set cannot create a witness                                                                     | Cannot repair           |
| Change badness from (\rho<q) to (\rho\le q)                                                      | Changes endpoint ownership                        | Violates the exact closed LRC threshold, where equality is safe                                                           | Invalid reformulation   |
| Assert that (v) comes from a hypothetical LRC counterexample and therefore cannot be this family | The exact tuple has an ordinary pivot             | The pivot of the representative tuple does not transfer to arbitrary lifts congruent modulo (40)                          | Circular or invalid     |
| Add “there is no ordinary pivot” as a premise                                                    | Excludes the exact tuple                          | This is counterexamplehood itself; using it to derive the missing pivot without an independent bridge restates the target | Circular                |
| Require (q\nmid\prod_i v_i)                                                                      | The family is excluded because (q\mid\prod_i v_i) | This yields the noncircular aggregate lemma below                                                                         | Admissible sole pivot   |

The fact that ((1,4,19,20)) has a modulus-(95) pivot proves only that this exact positive tuple is not a counterexample. A different tuple with the same residues modulo (40) need not retain that modulus-(95) calculation.

The aggregate product condition is different. It does not assume that the tuple comes from a counterexample. It gives a standalone modular assertion over all residue tuples. Its contrapositive would derive, rather than assume, the large dyadic divisor of the product.

---

## 7. **Optional sole salvage lemma**

### `AGGREGATE-DYADIC-C2-COVER-DIVISIBILITY`

Let (T_n) be the exact MSS strict-product threshold used by C2. For every (n\ge3), define

[
N=n+1,
]

[
E_n=\min{E\ge3:2^E>T_n},
]

[
q_n=2^{E_n},
\qquad
M_n=Nq_n.
]

The sole open lemma is:

> For every possibly repeated
> [
> v:\operatorname{Fin}n\to{0,\ldots,M_n-1},
> ]
> if
> [
> \forall k<n,\quad
> \gcd!\left(M_n,{v_i:i\ne k}\right)=1,
> ]
> and the owner-labelled strict bad sets cover the full grid,
> [
> \forall,0\le r<M_n,\quad
> \exists,i<n:\ \rho_{M_n}(rv_i)<q_n,
> ]
> then
> [
> q_n\mid\prod_{i<n}v_i.
> ]

Its exact contrapositive is:

> Under the deletion-gcd premises, if
> [
> q_n\nmid\prod_{i<n}v_i,
> ]
> then there exists (0\le r<M_n) such that
> [
> q_n\le\rho_{M_n}(rv_i)
> \quad\text{for every }i<n.
> ]

There is no candidate-residue exclusion. Coordinates may repeat, collide, be nonunits, or share factors with (N). Equality (\rho=q_n) is safe.

### Why it is strictly narrower than `PowerForcing`

The contrapositive of `PowerForcing` would conclude

[
\exists i:\ q_n\mid v_i.
]

The aggregate lemma concludes only

[
q_n\mid\prod_i v_i.
]

For (E_n\ge2),

[
q_n\nmid\prod_i v_i
]

is strictly stronger than coordinatewise

[
q_n\nmid v_i\quad\text{for every }i.
]

The four-divisible counterfamily demonstrates the difference: no individual coordinate is divisible by (q), but their product is divisible by (q).

### Counterfamily test

For the exact family,

[
\prod_i v_i
=10q\left(\frac{5q}{2}-1\right),
]

so the conclusion (q\mid\prod_i v_i) holds. The family therefore lies inside the cover-form domain and satisfies the proposed conclusion.

### Prompt67 and Prompt79 tests

The known failures at ((3,5)) and ((4,7)) do not apply because the lemma is restricted to powers of two. An extension to arbitrary (q) would be immediately incompatible with those prime failures.

The lemma uses no Prompt79 determinant or annihilator. Prompt79’s prime-dependent defect therefore neither proves nor refutes it.

Repeated residues and nonunits remain allowed. No coprimality between (N) and (q_n) is assumed, so dimensions with even (N) remain genuine obligations. The strict endpoint and owner quantifiers are frozen exactly.

### Conditional implication chain

Let (A=(a_i)) be a hypothetical primitive minimal positive-integer counterexample.

1. The accepted minimality result gives every deletion gcd equal to one.
2. Reduce (A) modulo (M_n=Nq_n), obtaining (v_i).
3. The deletion gcds remain one after reduction.
4. Counterexamplehood implies that every grid residue (r/M_n) has a strict bad owner:
   [
   \forall r\ \exists i:\rho_{M_n}(rv_i)<q_n.
   ]
5. The aggregate lemma gives
   [
   q_n\mid\prod_i v_i.
   ]
6. Since (a_i\equiv v_i\pmod{q_n}),
   [
   q_n\mid\prod_i a_i.
   ]
7. Positivity gives
   [
   \prod_i a_i\ge q_n>T_n,
   ]
   contradicting the external MSS strict upper bound for a primitive minimal counterexample.
8. Hence no positive-integer counterexample exists; the accepted Lean equivalences yield the exact pivot certificate and real-speed statement.

The only unresolved mathematical edge in this chain is `AGGREGATE-DYADIC-C2-COVER-DIVISIBILITY`. No iteration of `PrimeForcing(n,2)` is asserted. Any proposed proof by such an iteration would require a separate valid argument showing that the full (2)-adic valuation accumulates under the fixed modulus; that argument is not presently available.

---

## 8. **Proof-obligation ledger**

| Statement                                                | Dependency                                              | Evidence class                                                          | Direct falsification                                                       | Owner                                        |
| -------------------------------------------------------- | ------------------------------------------------------- | ----------------------------------------------------------------------- | -------------------------------------------------------------------------- | -------------------------------------------- |
| Domain and integrality of the family                     | (q=4h,\ h\ge2)                                          | Response-derived exact arithmetic, unpromoted                           | One coordinate outside ([0,M)) or a nonintegral half modulus               | Prompt87 response, `/root` audit             |
| Whole-(q) nondivisibility                                | Explicit remainders (1,4,2h-1,2h)                       | Response-derived exact arithmetic, unpromoted                           | One remainder equal to zero                                                | Prompt87 response, `/root` audit             |
| Four deletion gcds                                       | Survivor (1), or (\gcd(4,10h-1)=1)                      | Response-derived exact proof, unpromoted                                | Any deletion gcd (>1)                                                      | Prompt87 response, `/root` audit             |
| Full strict cover                                        | Parity, (v_2) interval reduction, (v_1) cyclic splits   | Response-derived exact proof, unpromoted                                | One residue with all four distances (\ge q)                                | Prompt87 response, `/root` audit             |
| Literal (q=8) cover                                      | Exact four-class residue partition                      | Exact finite replay in this response, not promoted as computed evidence | One missing residue or non-strict chosen owner                             | Independent verifier                         |
| Modulus-(95) pivot                                       | Four modular products                                   | Response-derived exact arithmetic, unpromoted                           | (5\mid31) or one distance (<19)                                            | Independent verifier                         |
| `PowerForcing(4,q)` failure                              | Family plus definition                                  | Response-derived mathematical consequence, unpromoted                   | Failure of any family premise or existence of a safe (r)                   | Prompt87 response, `/root`                   |
| Prompt84 universal target failure                        | Specialization (n=4,\ q=2^{32})                         | Response-derived logical consequence, unpromoted                        | Prompt84 target not containing that specialization                         | Prompt84 adjudication owner                  |
| Aggregate product identity                               | (4(5q/2)(5q/2-1))                                       | Response-derived exact arithmetic, unpromoted                           | Product not divisible by (q)                                               | Prompt87 response                            |
| Aggregate dyadic salvage lemma                           | Full strict cover implies (q_n\mid\prod v_i)            | `open`                                                                  | One tuple satisfying deletion gcds and full cover with (q_n\nmid\prod v_i) | Dedicated future proof or falsification cell |
| Small-prime forcing                                      | Frozen Prompt67 scope                                   | `proved-math-qualified`                                                 | Counterexample at a prime (p\le N)                                         | Existing audit scope                         |
| Fixed-obstruction extraction                             | Bad prime implies (p\mid D_n) for fixed (D_n\ne0)       | `open`                                                                  | Bad primes escaping every fixed obstruction                                | Prompt79                                     |
| Euclidean distinct-prime extraction conditional on (D_n) | Fixed nonzero obstruction                               | `proved-math-qualified`, conditional                                    | Failure of the exact finite divisor/product argument                       | Existing audit scope                         |
| MSS strict-product edge                                  | Exact C2 threshold (T_n)                                | `literature`, `external-unformalized`                                   | Source theorem does not imply the frozen strict upper bound                | Independent literature/formal audit          |
| C2 assembly                                              | Good distinct primes or aggregate dyadic lemma plus MSS | `open`                                                                  | Broken normalization, divisibility, or threshold arrow                     | C2 synthesis owner                           |
| Unrestricted LRC                                         | All preceding required edges                            | `open`                                                                  | Genuine counterexample or failure of claimed proof chain                   | Unrestricted research program                |

---

## 9. **Verifier plan**

### Literal (q=8) replay

Use exact integer arithmetic only, with no repository edit:

```text
M = 40
q = 8
v = [1, 4, 19, 20]

rho(x):
    a = x mod 40
    return min(a, 40-a)

For k = 0,1,2,3:
    assert gcd(40, all v_i with i != k) == 1

For r = 0,...,39:
    d = [rho(r*v_i) for i = 0,...,3]
    assert min(d) < 8
```

The replay should additionally assert the compressed owner partition:

```text
even r                         -> owner 3, distance 0
r in {1,3,5,7,33,35,37,39}    -> owner 0
r in {9,11,29,31}             -> owner 1, distance 4
r in {13,15,17,19,21,23,25,27}-> owner 2
```

It should separately record the four equality rows (r=8,12,28,32), and verify

```text
rho_95(31 * [1,4,19,20]) = [31,29,19,45].
```

This replay is a check of the displayed proof, not independent theorem evidence by itself.

### Independent symbolic checklist

1. Substitute (q=4h), (h\ge2), before every use of (M/2), (q/2), (5q/4), or (15q/4).
2. Verify the coordinate order and the two nonzero remainders (2h-1) and (2h).
3. Check each deletion gcd separately.
4. Establish that parity is well-defined because (M=20h) is even.
5. For even (r), verify owner (v_3) has residue zero.
6. For odd (r), derive
   [
   rv_2\equiv10h-x\pmod{20h}.
   ]
7. Justify
   [
   \rho_M(rv_2)=|10h-x|
   ]
   from (|10h-x|\le6h<M/2).
8. Derive exactly
   [
   x\in[4h,6h]\cup[14h,16h].
   ]
9. Recompute all four formulas for (\rho_M(4x)) on the intervals split at (5h) and (15h).
10. Check that the only safe (v_1) endpoints are (4h,6h,14h,16h), all even.
11. Retain equality (\rho=q) as safe and assign those even endpoints to owner (v_3).
12. Independently verify
    [
    \prod_i v_i=10q(5q/2-1).
    ]
13. Do not promote the aggregate salvage lemma from any finite scan. Its proof or falsification requires a separate symbolic argument or an explicit exact counterexample.

---

## 10. **Final evidence boundary**

**Accepted prior scopes:** The positive-integer and real-speed equivalences and the exact pivot-certificate equivalence remain `proved-lean`. Small-prime forcing, the bad-cover equivalence, exact single-coordinate counts, the conditional Euclidean extraction, and the accepted Prompt79 normalization and cross-minors retain their stated `proved-math-qualified` scopes.

**This response’s reasoning:** The four-divisible counterfamily, the (q=8) residue compression, the modulus-(95) pivot, and the product-divisibility distinction have been independently rederived here. They remain response-derived and unpromoted until separately audited.

**Unverified computation:** No response-authored scan is used to prove the symbolic theorem or the aggregate salvage. The literal (q=8) replay is transparent finite arithmetic, not promoted computed evidence.

**Rejected route:** `PowerForcing(4,q)` is false for every (q\ge8) divisible by four. Prompt84’s exact universal dyadic target is therefore rejected. Eventual coordinatewise forcing at large dyadic powers or large multiples of four is also rejected under the frozen premises.

**Surviving open routes:** The distinct-prime C2 route, `UniformPrimeForcingSupply`, Prompt79’s prime-independent obstruction extraction, and C2 assembly remain logically open. The aggregate dyadic cover-divisibility lemma is a separate exact open pivot that is not refuted by the counterfamily.

**External edge:** The MSS strict-product consequence remains `literature`, `external-unformalized`. No claim here upgrades its evidence status.

**Unrestricted LRC:** Open.
