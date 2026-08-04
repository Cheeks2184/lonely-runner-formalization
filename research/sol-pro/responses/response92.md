## 1. **Disposition**

**STOP.**

The sole lemma is false. For every dyadic (q=2^E) with (E\ge 3), set

[
n=6,\qquad N=7,\qquad M=7q,\qquad
a=\frac M4,\qquad b=\frac M2
]

and take the labelled tuple

[
v=(1,1,a-1,a+1,b-1,b).
]

Then:

[
\Delta_k(v)=1\quad\text{for every }k,
]

the six strict bad sets cover every (r\in\mathbb Z/M\mathbb Z), but

[
\nu_2!\left(\prod_i v_i\right)=E-1,
]

so (q=2^E) does not divide the labelled product.

For the frozen target at (n=6), the definition gives (E_6=117). Thus this family supplies an exact target-domain counterexample with (q_6=2^{117}). It refutes only the aggregate dyadic route. It does not alter the status of unrestricted Lonely Runner, which remains a conjecture in current literature. ([arXiv][1])

---

## 2. **Independent boundary audit**

| Input                                                 | Classification under the contract           | Use in this response                                  |
| ----------------------------------------------------- | ------------------------------------------- | ----------------------------------------------------- |
| Positive-integer pivot-certificate equivalence        | `proved-lean`                               | Used only when describing the counterfactual C2 chain |
| Positive-integer versus real-speed equivalence        | `proved-lean`                               | Used only in the counterfactual final reduction       |
| (n=1,2) induction bases                               | `proved-lean`                               | Preserved                                             |
| Primitive/deletion-gcd C2 wrapper                     | `proved-math-qualified`                     | Stated with its hypotheses in Section 12              |
| Threshold arithmetic and conditional C2 lifting facts | `proved-math-qualified`                     | Independently rederived where elementary              |
| MSS indexing and strict-product audit                 | `verified external dependency audit`        | Kept separate from repository-proved mathematics      |
| MSS finite-checking theorem                           | `literature`, `external-unformalized`       | Not used to refute the finite modular lemma           |
| Prompt84 symbolic family and prime failures           | Previously qualified only at audited scopes | Independently recalculated                            |
| Prompt87 aggregate reasoning                          | Unaccepted research input                   | Not used as a premise                                 |
| New (n=6) counterfamily                               | Response reasoning                          | Independently derived here                            |
| New finite scans                                      | Finite computation                          | Reproduced by two separate implementations            |

The MSS paper does state a linearly exponential finite-checking bound for integer velocities. This response does not upgrade the contract’s exact strict product interface beyond `literature` and `external-unformalized`. ([arXiv][1])

No repository was accessed or edited.

---

## 3. **Frozen definitions**

For every (n\ge 3),

[
N=n+1,\qquad
C_n=\binom{n+1}{2},\qquad
A_n=C_n^{,n(n-1)}.
]

The natural-number threshold is

[
T_n=\min{T\in\mathbb N:n^nT\ge A_n}.
]

The dyadic exponent and modulus are

[
E_n=\min{E\in\mathbb N:3\le E\ \text{and}\ T_n<2^E},
]

[
q_n=2^{E_n},\qquad M_n=Nq_n.
]

All minima use the ordinary natural-number order.

For (M>0), write (\bar x_M=x\bmod M\in{0,\ldots,M-1}), and define

[
\rho_M(x)=\min(\bar x_M,M-\bar x_M).
]

A tuple is a labelled function

[
v:\operatorname{Fin}n\longrightarrow{0,\ldots,M_n-1}.
]

Labels are ordered (0,\ldots,n-1). Equal values and equal bad sets remain separate labelled entries.

For deletion label (k),

[
\Delta_k(v)=\gcd\bigl(M_n,{v_i:i\ne k}\bigr),
]

where this is the iterated nonnegative natural gcd.

For owner (i),

[
B_i(v)=
{r\in{0,\ldots,M_n-1}:\rho_{M_n}(rv_i)<q_n}.
]

The cover condition is

[
\bigcup_{i<n}B_i(v)={0,\ldots,M_n-1}.
]

The conclusion is divisibility of the labelled natural product

[
q_n\mid\prod_{i<n}v_i.
]

The finite scans use the declared case order

[
(3,2),(3,4),(3,8),(3,16),(4,2),(4,4),(4,8),
]

followed by ordinary lexicographic order on labelled tuples.

---

## 4. **Elementary support**

### Threshold existence and minimality

Since (n\ge3), both (n^n) and (A_n) are positive. The defining set for (T_n) is nonempty because (T=A_n) satisfies

[
n^nA_n\ge A_n.
]

Natural-number well-ordering therefore gives (T_n).

If (T_n=0), then (n^nT_n=0<A_n), contradicting its defining property. Hence (T_n>0).

By membership,

[
n^nT_n\ge A_n.
]

If (n^nP<A_n) and (T_n\le P), monotonicity gives

[
A_n\le n^nT_n\le n^nP,
]

a contradiction. Therefore

[
n^nP<A_n\quad\Longrightarrow\quad P<T_n.
]

### Exponent existence and elementary consequences

The induction (2^m\ge m+1) shows

[
2^{T_n+1}\ge T_n+2>T_n.
]

Thus (E=\max(3,T_n+1)) belongs to the defining set for (E_n), so that set is nonempty.

By definition,

[
E_n\ge3,\qquad T_n<2^{E_n}=q_n.
]

Consequently,

[
q_n>0,\qquad 8\le q_n,\qquad M_n=Nq_n>0,\qquad q_n\mid M_n.
]

### Required controls

| (n) | Calculation                                                                                                                                                                     |
| --: | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|   3 | (C_3=6), (A_3=6^6=46656), (3^3\cdot1728=46656), so (T_3=1728). Also (2^{10}=1024\le T_3<2048=2^{11}), hence (E_3=11), (q_3=2048), (M_3=8192).                                   |
|   4 | (C_4=10), (A_4=10^{12}), and (4^4\cdot3906250000=10^{12}), so (T_4=3906250000). Since (2^{31}<T_4<2^{32}), (E_4=32), (q_4=4294967296), (M_4=21474836480).                       |
|   6 | (C_6=21), (A_6=21^{30}=4640650289117164100520051333566036654601). The minimum is (T_6=99465241107620972662038137293510731), with (2^{116}\le T_6<2^{117}). Therefore (E_6=117). |

For (n=6),

[
6^6(T_6-1)=A_6-35721<A_6,
]

[
6^6T_6=A_6+10935\ge A_6,
]

which verifies the exact minimum directly.

### Cover form versus contrapositive

Under the deletion premise, the original implication is

[
\left[\forall r,\exists i,\ \rho_M(rv_i)<q\right]
\Longrightarrow q\mid\prod_i v_i.
]

Its classical contrapositive is

[
q\nmid\prod_i v_i
\Longrightarrow
\neg\left[\forall r,\exists i,\ \rho_M(rv_i)<q\right].
]

Since both domains are finite and the predicates are decidable,

[
\neg\forall r,\exists i,P(r,i)
\iff
\exists r,\forall i,\neg P(r,i).
]

For natural numbers,

[
\neg(\rho_M(rv_i)<q)\iff q\le\rho_M(rv_i).
]

Thus the exact contrapositive is

[
q\nmid\prod_i v_i
\Longrightarrow
\exists r,\forall i,\ q\le\rho_M(rv_i).
]

Also,

[
q\nmid\prod_i v_i\Longrightarrow q\nmid v_i
\quad\text{for every }i,
]

but the reverse implication is false.

---

## 5. **PowerForcing separation**

### Four-divisible symbolic family

Let (n=4), (N=5), (4\mid q), (q\ge8), (M=5q), and

[
b=\frac M2=\frac{5q}{2}.
]

Take

[
v=(1,4,b-1,b).
]

All four values are canonical representatives.

Every deletion gcd is one. If any coordinate other than (1) is deleted, the surviving tuple still contains (1). If (1) is deleted, then

[
\gcd(M,4,b-1,b)=1
]

because (\gcd(b-1,b)=1).

No individual coordinate is divisible by (q):

[
b\bmod q=\frac q2,\qquad
(b-1)\bmod q=\frac q2-1,
]

and (q\ge8) excludes (q\mid4).

To prove the strict cover, let (r) be canonical.

If (r) is even, then

[
rb=r\frac M2\equiv0\pmod M,
]

so owner (b) is strictly bad.

Suppose (r) is odd and put (x=\min(r,M-r)). Reflection does not change any cyclic distance.

If (x<q), owner (1) is bad.

If (b-x<q), then, since (r) is odd,

[
r(b-1)\equiv b-r\pmod M,
]

and owner (b-1) is bad.

The remaining case has

[
q\le x\le b-q=\frac{3q}{2}.
]

Write (x=q+s). The endpoints are even, so for odd (x),

[
0<s<\frac q2.
]

Then

[
\rho_M(4x)=|4s-q|<q.
]

Thus owner (4) is bad. Equality remains safe for that owner; the equality residues are even and were already covered by owner (b).

Finally,

[
\prod_i v_i
=4\left(\frac{5q}{2}-1\right)\frac{5q}{2}
=10q\left(\frac{5q}{2}-1\right),
]

so (q) divides the aggregate product.

This includes both (q=q_4=2^{32}) and the literal fixture

[
q=8,\quad M=40,\quad v=(1,4,19,20).
]

It refutes the stronger coordinatewise PowerForcing conclusion while satisfying aggregate divisibility.

### Known-prime negative controls

For

[
n=3,\quad q=5,\quad M=20,\quad v=(1,3,4),
]

the deletion gcd vector is ((1,1,1)), and the strict bad sets are

[
B_1={0,1,2,3,4,16,17,18,19},
]

[
B_3={0,1,6,7,8,12,13,14,19},
]

[
B_4={0,1,4,5,6,9,10,11,14,15,16,19}.
]

Their union is all of ({0,\ldots,19}), but

[
1\cdot3\cdot4=12\not\equiv0\pmod5.
]

For

[
n=4,\quad q=7,\quad M=35,\quad v=(1,3,4,5),
]

the deletion gcd vector is ((1,1,1,1)), and

[
B_1={0,1,2,3,4,5,6,29,30,31,32,33,34},
]

[
B_3={0,1,2,10,11,12,13,22,23,24,25,33,34},
]

[
B_4={0,1,8,9,10,16,17,18,19,25,26,27,34},
]

[
B_5={0,1,6,7,8,13,14,15,20,21,22,27,28,29,34}.
]

Their union is all of ({0,\ldots,34}), while

[
1\cdot3\cdot4\cdot5=60\not\equiv0\pmod7.
]

These controls invalidate arbitrary-modulus and arbitrary-prime extensions. They do not themselves address the frozen dyadic target.

The (n=6) counterfamily below does address the frozen dyadic target and uses no LRC-counterexample origin, no selected pivot, no height hypothesis, and no external theorem.

---

## 6. **Independent falsification**

### Implementations

Implementation A uses:

* literal iterated deletion gcds for every label;
* the natural product remainder modulo (q);
* literal loops over every (r) and every owner;
* the strict test (\rho_M(rv_i)<q).

Implementation B independently uses:

* the primewise characterization of all deletion gcds;
* total truncated (2)-adic valuation;
* separately constructed owner-labelled bad-set bitsets;
* bitwise union to test full cover.

Both ran under Python 3.13.5. Neither used a seed. Both enumerated the complete domain in the frozen case order and lexicographic tuple order. Both outputs contain `completion_marker: COMPLETE`.

### Complete small-domain results

| ((n,q))   |    Raw tuples | Deletion-gcd premise | Product nondivisible | Full-cover failures |
| --------- | ------------: | -------------------: | -------------------: | ------------------: |
| ((3,2))   |           512 |                  256 |                   64 |                   0 |
| ((3,4))   |         4,096 |                2,048 |                1,280 |                   0 |
| ((3,8))   |        32,768 |               16,384 |               13,312 |                   0 |
| ((3,16))  |       262,144 |              131,072 |              118,784 |                   0 |
| ((4,2))   |        10,000 |                6,688 |                  608 |                   0 |
| ((4,4))   |       160,000 |              107,008 |               29,184 |                   0 |
| ((4,8))   |     2,560,000 |            1,712,128 |              856,064 |                   0 |
| **Total** | **3,029,520** |        **1,975,584** |        **1,019,296** |               **0** |

The two case-result objects agree exactly, including the absence of a first failure.

### Boundary and malformed fixtures

Both implementations confirmed:

1. For (M=8,q=2,v=1), (r=1) is strictly bad, while (r=2) and (r=6) have (\rho=2=q) and are safe.
2. (r=0) is included and bad for zero and nonzero owners.
3. ((1,1,2)) has deletion gcds ((1,1,1)), retains duplicate labels, and has product divisible by (2).
4. ((0,1,1)) has deletion gcds ((1,1,1)) and product zero divisible by (2).
5. ((1,2,2)) has deletion gcds ((2,1,1)), failing exactly deletion label (0).
6. Coincident owner masks remain in separate label slots.
7. Nonunits are used directly, with no cancellation.
8. Negative, noninteger, out-of-range, wrong-length, wrong-(M), and (n<3) fixtures are rejected.
9. Replacing (<q) by (\le q) changes both equality fixtures.
10. The strengthened conclusion (\exists i,\ q\mid v_i) fails for ((1,4,19,20)), although its aggregate product is divisible by (8).

### Hashes

```text
verifier_a.py
528b23b4e0dc2b5cbb447c6a947962edc6e00ce440037335243c036044a1924d

output_a.json
e09fa237362d388396ea8db4e430a912067c1fd79cffce979e64655344de6dbb

verifier_b.py
0262aedb8ef44712347ef6ff237c163f8acc038a44cf490e59de64bb8088890a

output_b.json
64d2c0dccb0a86cab7e97b151447a45056345de54310a80fef8304f2706d7129

target_counterexample.py
7fcbda9eae67ec1ec2a7c67b74297569dd33fa36f5bc00c8665a15ec2a456c02

target_counterexample.json
3c2aad8fb4d64ca1ba19d809fb5a16a4448cd9623884c47f019640715163ab10

bundle
e143a6ab77258caff1e84c639fd2de247b9b7ae7de646c159b736604ba8eea15
```

The prescribed post-domain structured scans for (n=3,4,5) were not continued after the exact (n=6) target-domain counterexample was established. This follows the contract’s immediate stop rule.

Artifacts:

* [Complete verifier bundle](sandbox:/mnt/data/p92_verifier_bundle.zip)
* [Hash manifest](sandbox:/mnt/data/p92/manifest.json)
* [Implementation A source](sandbox:/mnt/data/p92/verifier_a.py)
* [Implementation A output](sandbox:/mnt/data/p92/output_a.json)
* [Implementation B source](sandbox:/mnt/data/p92/verifier_b.py)
* [Implementation B output](sandbox:/mnt/data/p92/output_b.json)
* [Target counterexample source](sandbox:/mnt/data/p92/target_counterexample.py)
* [Target counterexample output](sandbox:/mnt/data/p92/target_counterexample.json)

---

## 7. **Attack A**

Assume the contrapositive premise

[
q=2^E\nmid\prod_i v_i.
]

Then no coordinate can be zero. Each coordinate has a unique decomposition

[
v_i=2^{e_i}u_i,
\qquad u_i\ \text{odd},
\qquad 0\le e_i<E,
]

and

[
\sum_i e_i<E.
]

For every prime (p\mid M), the all-deletion condition has the exact primewise characterization

[
#{i:p\nmid v_i}\ge2.
]

Indeed, if at most one label is a (p)-nonmultiple, deleting that label leaves every survivor divisible by (p). Conversely, two (p)-nonmultiples ensure that every deletion retains at least one.

For (p=2), at least two coordinates are odd.

These conditions do not force a safe multiplier. The counterfamily has valuation vector

[
(e_0,\ldots,e_5)=(0,0,0,0,0,E-1),
]

so it has five odd coordinates and

[
\sum_i e_i=E-1<E.
]

Nevertheless, its bad sets cover the full grid.

Thus the first unsupported arrow in Attack A is exactly:

[
\left[
\sum_i e_i<E
\ \text{and all deletion gcds are one}
\right]
\Longrightarrow
\left[
\exists r\text{ safe for every owner}
\right].
]

That implication is false even on the critical shell (\sum e_i=E-1). No compatible CRT construction can establish it from the frozen hypotheses.

A standard even-residue reduction also does not supply the missing final bit. For (q=2q'),

[
\rho_{Nq}(2x)=2\rho_{Nq'}(x),
]

so a cover at exponent (E) descends on even residues to a cover at exponent (E-1). An inductive approach would still have to force the final factor of two in the shell (\nu_2(P)=E-1). The family below occupies precisely that shell at every (E\ge3).

---

## 8. **Attack B**

### Generic exact fibre count

Let

[
d=\gcd(M,v).
]

Multiplication by (v) on (\mathbb Z/M\mathbb Z) has kernel size (d) and image the multiples of (d).

Because (N\ge4), (q\le M/4), so the strict target residues

[
0,\pm1,\ldots,\pm(q-1)
]

do not collide except at zero. The exact owner-set size is therefore

[
|B(v)|
======

d\left(1+2\left\lfloor\frac{q-1}{d}\right\rfloor\right).
]

This remains valid for (v=0), where (d=M) and (|B(0)|=M). The formula retains the complete gcd, including all odd factors shared with (N). It is not a function of the (2)-adic stratum alone.

### Exact labelled bad sets for the counterfamily

Let

[
M=7q,\qquad
a=\frac M4,\qquad
b=\frac M2,
]

and order the owners as

[
(1,1,a-1,a+1,b-1,b).
]

For a canonical residue (x), the first two labelled sets coincide but remain separate:

[
B_0=B_1=
{x:x<q\ \text{or}\ x>M-q}.
]

For the half-modulus owner,

[
B_5={x:x\text{ is even}}.
]

For (b-1),

[
B_4=
{x\text{ even}:\rho_M(x)<q}
\ \cup
{x\text{ odd}:b-q<x<b+q}.
]

For (a-1), with (c=x\bmod4),

[
x\in B_2
\iff
\begin{cases}
\rho_M(x)<q, & c=0,\
\rho_M(a-x)<q, & c=1,\
\rho_M(b-x)<q, & c=2,\
\rho_M(a+x)<q, & c=3.
\end{cases}
]

For (a+1),

[
x\in B_3
\iff
\begin{cases}
\rho_M(x)<q, & c=0,\
\rho_M(a+x)<q, & c=1,\
\rho_M(b-x)<q, & c=2,\
\rho_M(a-x)<q, & c=3.
\end{cases}
]

These are the complete labelled bad sets.

### Exact cover decision table

Take any canonical (r).

1. If (r) is even, then
   [
   rb\equiv0\pmod M,
   ]
   so (r\in B_5).

2. Suppose (r) is odd. Put
   [
   x=\min(r,M-r).
   ]
   Then (x) is odd and
   [
   \rho_M(rv)=\rho_M(xv)
   ]
   for every owner.

3. If (x<q), then (x\in B_0).

4. If (b-x<q), then, since (x) is odd,
   [
   x(b-1)\equiv b-x\pmod M,
   ]
   so (x\in B_4).

5. Otherwise,
   [
   q\le x\le b-q=\frac{5q}{2}.
   ]
   Set (a=7q/4). Then
   [
   |a-x|\le\frac{3q}{4}<q.
   ]

   If (x\equiv1\pmod4), then
   [
   xa\equiv a\pmod M,
   \qquad
   x(a-1)\equiv a-x\pmod M,
   ]
   so (x\in B_2).

   If (x\equiv3\pmod4), then
   [
   xa\equiv3a\equiv-a\pmod M,
   \qquad
   x(a+1)\equiv x-a\pmod M,
   ]
   so (x\in B_3).

This covers every residue.

The residues

[
q,\quad b-q,\quad b+q,\quad M-q
]

are all even because (8\mid q). They are handled by (B_5). No weak endpoint is used.

Consequently, any universal covering inequality asserting that a full strict cover forces total (2)-adic valuation at least (E) is false.

---

## 9. **Attack C**

The original six-label cover has two coincident labels of value (1). Removing one duplicate leaves the five distinct labelled values

[
(1,a-1,a+1,b-1,b).
]

All fixed-(M) deletion-gcd conditions still hold.

If a deletion leaves the value (1), its gcd is immediately one. If (1) itself is deleted, then

[
\gcd(a-1,a+1)=\gcd(a-1,2)=1
]

because (a) is even. Therefore the gcd with (M,b-1,b) is also one.

This five-set cover is inclusion-minimal. In the owner order

[
(1,a-1,a+1,b-1,b),
]

the following residues are private:

| Owner | Private residue | Badness vector |
| ----- | --------------: | -------------- |
| (1)   |             (1) | ((B,S,S,S,S))  |
| (a-1) |           (q+1) | ((S,B,S,S,S))  |
| (a+1) |           (q+3) | ((S,S,B,S,S))  |
| (b-1) |           (b-1) | ((S,S,S,B,S))  |
| (b)   |             (q) | ((S,S,S,S,B))  |

At (r=q), the four non-(b) owners have cyclic distance exactly (q), while owner (b) has cyclic distance zero. Thus strictness is essential and explicitly preserved.

Minimal-cover deletion therefore does not eliminate the obstruction. The resulting inclusion-minimal fixed-grid cover still has total product valuation (E-1). A valuation-preserving exchange that universally reduces the proposed frozen key cannot exist under only the stated premises.

---

## 10. **Attack D**

The symbolic obstruction is the following exact counterfamily.

### Counterfamily theorem

For every (E\ge3), let

[
q=2^E,\qquad M=7q,
]

and define

[
v_E=
\left(
1,,
1,,
\frac{7q}{4}-1,,
\frac{7q}{4}+1,,
\frac{7q}{2}-1,,
\frac{7q}{2}
\right).
]

Then:

1. Every coordinate is a canonical representative modulo (M).
2. Every deletion gcd with (M) is one.
3. The strict labelled bad sets cover every residue modulo (M).
4. The coordinate valuations are
   [
   (0,0,0,0,0,E-1).
   ]
5. Hence
   [
   q\nmid\prod_i(v_E)_i.
   ]

The cover proof is the parity and quarter-modulus decision table in Section 8. No prime chosen afterward, determinant, Fourier element, counterexample-origin premise, or external theorem occurs.

The literal first member is

[
E=3,\quad q=8,\quad M=56,\quad
v=(1,1,13,15,27,28).
]

It already has all deletion gcds one, a full strict cover, and product valuation (2<3).

---

## 11. **Sole lemma**

For the actual frozen target, select (n=6). Then

[
N=7,\qquad C_6=21,
]

[
T_6=99465241107620972662038137293510731,
]

[
E_6=117,
]

[
q_6=2^{117}
=166153499473114484112975882535043072,
]

[
M_6=7q_6
=1163074496311801388790831177745301504.
]

Put

[
a=\frac{M_6}{4}
=290768624077950347197707794436325376,
]

[
b=\frac{M_6}{2}
=581537248155900694395415588872650752.
]

The exact target tuple is

[
\begin{aligned}
v=\bigl(&1,,
1,,
290768624077950347197707794436325375,\
&290768624077950347197707794436325377,\
&581537248155900694395415588872650751,\
&581537248155900694395415588872650752
\bigr).
\end{aligned}
]

Every deletion leaves at least one coordinate equal to (1), so

[
(\Delta_0,\ldots,\Delta_5)=(1,1,1,1,1,1).
]

The exact labelled bad sets are those listed in Section 8, and the complete cover decision table proves

[
\forall r\in\operatorname{Fin}M_6,\quad
\exists i\in\operatorname{Fin}6,\quad
\rho_{M_6}(rv_i)<q_6.
]

The labelled product is

[
P=(a-1)(a+1)(b-1)b.
]

Here (a) is even, so (a-1) and (a+1) are odd. Also (b-1) is odd and

[
b=7\cdot2^{116}.
]

Therefore

[
\nu_2(P)=116=E_6-1.
]

More explicitly,

[
P\bmod q_6
==========

# 2^{116}

83076749736557242056487941267521536
\ne0.
]

Thus

[
q_6\nmid P.
]

The first missing conclusion is exactly the sole claimed conclusion. All premises hold, and the divisibility conclusion fails.

Therefore:

[
\boxed{\text{AGGREGATE-DYADIC-C2-COVER-DIVISIBILITY is false.}}
]

---

## 12. **Conditional C2 chain**

The implication chain requested by the contract is logically valid under the hypothetical aggregate lemma and the external MSS consequence. The target counterexample shows that its aggregate-lemma antecedent is false.

1. Fix (n\ge3) and assume positive-integer LRC in every smaller positive moving-speed dimension. Keep the accepted (n=1) and (n=2) bases separately.

2. Suppose
   [
   a=(a_0,\ldots,a_{n-1})
   ]
   is a positive injective integer counterexample. Let
   [
   d=\gcd(a_0,\ldots,a_{n-1})
   ]
   and define (b_i=a_i/d).

   Each (b_i) is a positive integer, and injectivity is preserved. Their total gcd is one.

   If (b) had a witness at time (t), then (a) would have the same positions at time (t/d), since
   [
   a_i(t/d)=b_it.
   ]
   Thus (b) is also a counterexample. This justifies primitive reduction.

3. The accepted C2 deletion wrapper requires all of the following:

   * (n\ge3);
   * positive integer coordinates;
   * injectivity;
   * total primitivity;
   * counterexamplehood at the closed threshold (1/(n+1));
   * positive-integer LRC in every smaller moving-speed dimension.

   Under these hypotheses it gives

   [
   \gcd(a_i:i\ne k)=1
   \quad\text{for every }k.
   ]

   This does not follow from total primitivity alone.

4. Put

   [
   v_i=a_i\bmod M_n.
   ]

   Zero and repeated residues are retained. If (d) divides (M_n) and every surviving (v_i), then

   [
   a_i=v_i+M_nz_i
   ]

   shows (d\mid a_i) for every survivor. The deletion gcd of the (a_i) is one, so (d=1). Hence

   [
   \Delta_k(v)=1
   \quad\text{for every }k.
   ]

5. If the strict cover failed, there would be (r) with

   [
   \rho_{M_n}(rv_i)\ge q_n
   \quad\text{for all }i.
   ]

   Since (a_i\equiv v_i\pmod{M_n}),

   [
   \rho_{M_n}(ra_i)=\rho_{M_n}(rv_i).
   ]

   At (t=r/M_n),

   [
   |ta_i|_{\mathbb R/\mathbb Z}
   ============================

   \frac{\rho_{M_n}(ra_i)}{M_n}
   \ge
   \frac{q_n}{Nq_n}
   ================

   \frac1N.
   ]

   Equality is retained. This contradicts counterexamplehood. Therefore the residue tuple has a full strict cover.

6. Under the hypothetical aggregate lemma,

   [
   q_n\mid\prod_i v_i.
   ]

7. Since (q_n\mid M_n),

   [
   a_i\equiv v_i\pmod{q_n}.
   ]

   Multiplication preserves congruence, so

   [
   \prod_i a_i\equiv\prod_i v_i\pmod{q_n}.
   ]

   Therefore

   [
   q_n\mid\prod_i a_i.
   ]

8. The speed product is positive. Divisibility gives

   [
   \prod_i a_i\ge q_n>T_n.
   ]

9. The external MSS consequence supplies

   [
   n^n\prod_i a_i<A_n.
   ]

   The elementary threshold property then gives

   [
   \prod_i a_i<T_n.
   ]

   This contradicts Step 8. The MSS paper is an external finite-checking source; the exact strict product interface remains `external-unformalized` under the contract. ([arXiv][1])

10. The contradiction would establish positive-integer LRC in dimension (n). Together with the two accepted bases, strong induction would establish it in every dimension.

11. The accepted positive-integer pivot-certificate equivalence would then transfer the theorem to the pivot formulation, and the accepted positive-integer versus real-speed equivalence would give real LRC with the closed endpoint and all quantifiers preserved.

The equivalent direct branch is:

[
P=\prod_i a_i<T_n<q_n.
]

Since (P>0), this implies (q_n\nmid P). Product congruence gives

[
q_n\nmid\prod_i v_i.
]

The hypothetical aggregate contrapositive would then produce a common safe residue (r), and Step 5 would lift it to the exact integer witness.

This entire chain remains a counterfactual conditional. Section 11 invalidates its modular premise at (n=6).

---

## 13. **Proof-obligation ledger**

| Claim                             | Dependency                                                          | Evidence class                           | Falsification or check           | First open or false edge | Recommended downstream owner   |
| --------------------------------- | ------------------------------------------------------------------- | ---------------------------------------- | -------------------------------- | ------------------------ | ------------------------------ |
| Existence and properties of (T_n) | Natural well-ordering and monotonicity                              | Response reasoning                       | Direct proof                     | None                     | Routine audit                  |
| Existence and properties of (E_n) | Unbounded powers of two                                             | Response reasoning                       | Direct proof                     | None                     | Routine audit                  |
| (n=3,4,6) controls                | Exact integer arithmetic                                            | Response reasoning plus computation      | Exact inequalities               | None                     | Arithmetic replay              |
| Contrapositive equivalence        | Finite classical logic                                              | Response reasoning                       | Predicate negation checked       | None                     | Routine audit                  |
| Prompt84 four-divisible family    | Symbolic modular arithmetic                                         | Response reasoning plus verifier fixture | (q=8) and symbolic proof         | None                     | Independent replay             |
| Known-prime controls              | Exact finite bad sets                                               | Finite computation plus listed sets      | Full unions listed               | None                     | Independent replay             |
| Complete frozen small domain      | Two independent programs                                            | Finite computation                       | Exact matching counts and hashes | No universal conclusion  | Luna replay permitted          |
| (n=6) deletion gcds               | Two surviving labels equal to (1)                                   | Response reasoning                       | Exact gcd vector                 | None                     | Independent Sol audit          |
| (n=6) full strict cover           | Parity and quarter-modulus partition                                | Response reasoning                       | Complete decision table          | None                     | Independent Sol audit          |
| (n=6) product failure             | Exact (2)-adic valuation                                            | Response reasoning plus certificate      | (\nu_2(P)=116)                   | None                     | Independent Sol audit          |
| Sole aggregate lemma              | Above counterexample                                                | Rejected by response reasoning           | Exact target instance            | Conclusion is false      | Close P92 after audit          |
| C2 deletion wrapper               | Lower-dimensional induction and primitive counterexample hypotheses | `proved-math-qualified`                  | Existing accepted audit          | None within its scope    | Existing owner                 |
| MSS strict-product interface      | External paper plus dependency audit                                | `literature`, `external-unformalized`    | Not formalized here              | External formalization   | Literature/formalization owner |
| Complete C2 chain                 | Aggregate lemma plus MSS                                            | `conditional`                            | Antecedent refuted               | Aggregate lemma          | Route closed                   |
| Unrestricted LRC                  | Independent of this false route                                     | `open`                                   | Not affected                     | Global conjecture        | Other research routes          |

---

## 14. **Verifier and Lean plan**

No Lean implementation of the proposed universal lemma is warranted. The exact arithmetic target has failed.

After independent mathematical audit, a counterexample formalization could use declaration-level signatures of the following form:

```lean
def p92q : Nat := 2 ^ 117

def p92M : Nat := 7 * p92q

def p92a : Nat := p92M / 4

def p92b : Nat := p92M / 2

def p92v : Fin 6 → Nat
  | 0 => 1
  | 1 => 1
  | 2 => p92a - 1
  | 3 => p92a + 1
  | 4 => p92b - 1
  | 5 => p92b

theorem p92v_canonical :
  ∀ i, p92v i < p92M

theorem p92_all_deletion_gcds :
  ∀ k : Fin 6,
    deletionGCD p92M p92v k = 1

theorem p92_full_strict_cover :
  ∀ r : Fin p92M,
    ∃ i : Fin 6,
      rho p92M (r.val * p92v i) < p92q

theorem p92_product_not_divisible :
  ¬ p92q ∣ ∏ i : Fin 6, p92v i

theorem aggregate_dyadic_c2_cover_divisibility_false :
  ¬ AggregateDyadicC2CoverDivisibility
```

The suggested proof decomposition is:

1. exact (E_6=117) arithmetic;
2. canonical representative bounds;
3. deletion gcds from the duplicate (1);
4. parity split on (r);
5. odd-residue reflection;
6. the two (r\bmod4) branches;
7. exact (2)-adic product valuation.

No repository edit was made.

---

## 15. **Final evidence boundary**

**`proved-lean`**

* Accepted positive-integer pivot-certificate equivalence.
* Accepted positive-integer versus real-speed equivalence.
* Accepted one- and two-positive-speed bases.

**`proved-math-qualified`**

* Accepted primitive/deletion-gcd C2 wrapper at its stated hypotheses.
* Accepted modular reduction and conditional lifting facts.
* Previously audited threshold and C2 arithmetic at their qualified scopes.

**`verified external dependency audit`**

* MSS indexing and strict-product logic as previously classified.
* No conversion of the external theorem into repository-proved mathematics.

**`literature`, `external-unformalized`**

* The MSS finite-checking theorem and the exact external product-bound interface.

**Response reasoning**

* Elementary threshold proofs.
* Contrapositive equivalence.
* Independent Prompt84 family proof.
* Exact (n=6) dyadic counterfamily.
* Complete symbolic strict-cover partition.
* Exact target product valuation and divisibility failure.

**Finite computation**

* Two complete independent scans over 3,029,520 tuples.
* Matching raw, premise, product-nondivisible, and failure counts.
* Boundary and malformed fixtures.
* Small-(q) calibrations of the (n=6) family.
* Recorded source and output hashes.

**Conditional**

* Aggregate lemma plus external MSS would imply the C2 induction chain.
* The aggregate antecedent is now refuted.

**Rejected**

* `AGGREGATE-DYADIC-C2-COVER-DIVISIBILITY`.
* Its exact contrapositive.
* Coordinatewise PowerForcing.
* Extension to arbitrary primes or arbitrary moduli.
* Any covering inequality claiming that the frozen premises alone force total valuation at least (E_n).

**Open**

* Unrestricted Lonely Runner.
* Any narrower residue theorem that excludes this family by a separately justified speed-origin property.
* Other independent routes, including the previously separated Prompt79, Prompt89, Prompt90, and Prompt91 programs.

[1]: https://arxiv.org/abs/2411.06903?utm_source=chatgpt.com "Linearly-exponential checking is enough for the Lonely Runner Conjecture and some of its variants"
