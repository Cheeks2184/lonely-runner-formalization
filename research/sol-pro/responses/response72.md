## 1. Disposition

**STOP**

The frozen circuit-escape lemma was neither proved nor refuted. The decisive structural finding is that, as a schema over all dimensions, it is equivalent to the positive-integer Lonely Runner Conjecture. Moreover, any closed subset, including a proper subset, would produce a lower-dimensional Lonely Runner counterexample. The prescribed finite search found no closed subset, but finite success cannot establish the lemma.

## 2. Status table

| Claim or dependency                                                             | Status                     | Basis                                                     |               |                               |   |             |
| ------------------------------------------------------------------------------- | -------------------------- | --------------------------------------------------------- | ------------- | ----------------------------- | - | ----------- |
| `exists_witness_iff_exists_pivot_certificate`                                   | `proved-lean`              | Supplied repository boundary; not recompiled in this turn |               |                               |   |             |
| `positiveIntegerConjecture_iff_pivotCertificateConjecture`                      | `proved-lean`              | Supplied repository boundary; not recompiled in this turn |               |                               |   |             |
| `conjecture_iff_positiveIntegerConjecture`                                      | `proved-lean`              | Supplied repository boundary; not recompiled in this turn |               |                               |   |             |
| `Covers(j) ↔ ⋃_{i≠j} B_i^j = R_j`                                               | `proved-math`              | Direct finite-set proof below                             |               |                               |   |             |
| Existence and uniqueness of (C_j), inclusion-minimality, and private points     | `proved-math`              | Finite lexicographic minimization and removal argument    |               |                               |   |             |
| Reflection invariance and exact fixed-point classification                      | `proved-math`              | Direct modular calculation                                |               |                               |   |             |
| Coverage-rank normalization, monotonicity, submodularity, and marginal formulas | `proved-math`              | Direct finite-set calculation                             |               |                               |   |             |
| Exact gcd-dependent singleton-rank formula                                      | `proved-math`              | Fiber count for modular multiplication                    |               |                               |   |             |
| Boundary-grid lemma for an arbitrary subset (S) at threshold (1/N)              | `proved-math`              | First-entry argument on a continuous witness interval     |               |                               |   |             |
| A closed (S) gives a Lonely Runner counterexample in dimension (                | S                          | )                                                         | `proved-math` | Boundary-grid lemma plus (1/( | S | +1)\ge 1/N) |
| Global circuit-escape schema is equivalent to positive-integer LRC              | `proved-math`              | Both directions proved below                              |               |                               |   |             |
| Mandatory fixtures and regression checks                                        | `computed finite evidence` | Exact integer replay                                      |               |                               |   |             |
| No failure among 2,429 prescribed primitive tuples                              | `computed finite evidence` | Frozen bounded scan                                       |               |                               |   |             |
| Quotient-based circuit transport in Attack A                                    | `rejected`                 | Explicit private-point failures                           |               |                               |   |             |
| Derivation of escape from local coverage-submodularity alone                    | `rejected`                 | Local rank axioms admit closed abstract circuits          |               |                               |   |             |
| Any additional arithmetic cross-pivot rank inequality sufficient for escape     | `open`                     | No noncircular inequality was established                 |               |                               |   |             |
| `MODULAR-COVER-CIRCUIT-ESCAPE`                                                  | `open`                     | Equivalent in global strength to positive-integer LRC     |               |                               |   |             |
| Complete unrestricted implication chain                                         | `conditional`              | Valid if circuit escape is supplied                       |               |                               |   |             |
| Unrestricted real LRC                                                           | `open`                     | Supplied project boundary                                 |               |                               |   |             |

The new `proved-math` entries are manuscript-level claims and are not repository promotions before independent audit.

## 3. Exact target

Fix (n\ge2), (N=n+1), and positive injective speeds (a:\mathrm{Fin},n\to\mathbb N). For pivot (j), write

[
p=a_j,\qquad M=Np.
]

The residue grid and owner bad sets are

[
R_j={r\in\mathrm{Fin},M:N\nmid r},
]

[
B_i^j={r\in R_j:\rho_M(r a_i)<p},\qquad i\ne j,
]

with

[
\rho_M(x)=\min(x\bmod M,M-(x\bmod M)).
]

The boundary remains strict. Residues satisfying (\rho_M(r a_i)=p) are safe.

Let

[
U_j=\bigcup_{i\ne j}B_i^j,\qquad Q_j=R_j\setminus U_j.
]

Since every (B_i^j\subseteq R_j),

[
Q_j=\varnothing
\iff R_j\subseteq U_j
\iff U_j=R_j.
]

Therefore

[
\boxed{\operatorname{Covers}(j)\iff \bigcup_{i\ne j}B_i^j=R_j.}
]

For a covered pivot, the full nonpivot owner set is a complete cover. The collection of complete owner subsets is finite and nonempty. Injectivity of (a) makes the increasing speed list identify its owner subset uniquely. Consequently the key

[
\left(|C|,\operatorname{sort}{a_i:i\in C}\right)
]

is a strict total order on complete covers, and it has a unique least element (C_j).

If (D\subsetneq C_j) were complete, then (|D|<|C_j|), contradicting minimum cardinality. Hence (C_j) is inclusion-minimal. For each (i\in C_j), absence of a private point would give

[
B_i^j\subseteq\bigcup_{h\in C_j\setminus{i}}B_h^j,
]

so (C_j\setminus{i}) would remain complete. Thus

[
B_i^j\setminus\bigcup_{h\in C_j\setminus{i}}B_h^j\ne\varnothing.
]

The exact frozen target is

[
\forall n\ge2;\forall a;\forall\varnothing\ne S\subseteq F(a),\quad
\exists j\in S;\exists i\in C_j,\quad i\notin S.
]

Reflection is the involution

[
\sigma_j(r)=(-r)\bmod M_j.
]

It preserves (R_j), every owner-labelled (B_i^j), and (Q_j). Its fixed residues satisfy (2r=0\pmod M). The residue (0) is excluded. The antipode (M/2) lies in (R_j) exactly when (N) is even and (p) is odd. It is one fixed orbit and must never be doubled.

Finally, the pivot coordinate is always safe. If (r\in R_j) and (k=r\bmod N), then (1\le k\le N-1) and

[
\rho_{Np}(rp)
=p\min(k,N-k)\ge p.
]

## 4. Regression and non-tautology audit

### Mandatory fixtures

Pivots and circuits below are identified by speed, not coordinate index.

| Speeds           | (G) in speed order | Covered pivots and canonical circuits                          |
| ---------------- | -----------------: | -------------------------------------------------------------- |
| ((1,3,4))        |          ((0,2,2)) | (C_1={4})                                                      |
| ((1,3,4,5))      |        ((0,0,2,2)) | (C_1={5}), (C_3={1,4,5})                                       |
| ((1,2,3,4,5,7))  |    ((0,0,0,0,2,2)) | (C_1={7}), (C_2={1,3,5,7}), (C_3={1,4,5,7}), (C_4={1,2,3,5,7}) |
| ((1,6,11,12,13)) |     ((0,0,8,8,10)) | (C_1={6}), (C_6={1,11,12,13})                                  |
| ((1,2,8))        |          ((0,0,6)) | (C_1=C_2={8})                                                  |
| ((1,3))          |            ((0,2)) | (C_1={3})                                                      |
| ((1,2,3))        |          ((2,2,2)) | No covered pivot                                               |
| ((1,3,5))        |          ((3,3,5)) | No covered pivot                                               |
| ((1,3,13))       |          ((3,5,9)) | No covered pivot                                               |

For the six-speed fixture,

[
Q_5={6,29}\pmod{35},\qquad
Q_7={8,41}\pmod{49}.
]

For ((1,6,11,12,13)), selecting the least-speed owner creates

[
1\longrightarrow6\longrightarrow1.
]

The full circuit at (6) nevertheless contains (11,12,13), all outside the covered set ({1,6}). This rejects a single-owner selector argument.

For ((1,2,8)), both covered circuits escape to the sole uncovered pivot (8). Any strengthening demanding two uncovered pivots is false.

For ((1,3)), the good residues at pivot (3) are the reflection pair

[
Q_3={4,5}\pmod9.
]

For ((1,2,3)), at pivot speed (3), owner speed (1) gives

[
\rho_{12}(2)=2=p-1,
]

which is bad, while

[
\rho_{12}(3)=3=p,
]

which is safe. The good residues are (3) and (9).

For ((1,3,5)), (N=4) and every pivot speed is odd. The reflection-fixed antipodes are

[
2,\quad6,\quad10
]

at pivot speeds (1,3,5), respectively. Every owner speed is odd, so at an antipode (M/2),

[
(M/2)a_i\equiv M/2\pmod M,
]

and its cyclic distance is (M/2=2p\ge p). These are single safe fixed points, not reflection pairs.

For ((1,3,13)), at pivot speed (3), (M=12) and

[
1\equiv13\pmod{12}.
]

The two owner-labelled sets remain distinct objects but coincide extensionally:

[
B_1^3=B_{13}^3={1,2,10,11}.
]

Neither label is discarded.

The replay also checked (r=0), every excluded multiple of (N), (p-1), equality at (p), antipodes, a unit pair, a nonunit pair with (\gcd(12,36)=12), all 870 coordinate permutations of fixtures 1 through 4, and common scaling by (2) and (3). Under common scaling by (k), each good-set pattern repeats (k) times, (G_j) is multiplied by (k), and the speed-labelled canonical circuit is unchanged apart from scaling every speed by (k).

### Reverse boundary theorem

The central non-tautology audit produces a stronger conclusion than the prompt allowed.

**Boundary-grid lemma.** Let (S) be any nonempty finite set of positive integer speeds and let (N\ge2). If a real time (t) satisfies

[
|t a_i|\ge\frac1N\qquad(i\in S),
]

then there are (j\in S) and a residue (r\in{0,\ldots,Na_j-1}), with (N\nmid r), such that

[
\rho_{Na_j}(r a_i)\ge a_j\qquad(i\in S\setminus{j}).
]

**Proof.** Reduce (t) modulo (1), so (0<t<1). On the interval ([0,t]), let

[
K=\left{x:|x a_i|\ge\frac1N\text{ for every }i\in S\right}.
]

This is a nonempty closed set. Let (x_0=\min K). Since (0\notin K), (x_0>0). If every coordinate were strictly above (1/N) at (x_0), continuity would give a smaller point of (K). Hence, for some (j),

[
|x_0a_j|=\frac1N.
]

Thus

[
x_0a_j=k+\frac1N
\quad\text{or}\quad
x_0a_j=k-\frac1N
]

for an integer (k), so

[
x_0=\frac{Nk\pm1}{Na_j}.
]

Reduce (Nk\pm1) modulo (Na_j) to its unique representative (r). It remains nonzero modulo (N). Replacing the numerator by this representative changes time by an integer, which does not alter any integer-speed coordinate. The required modular inequalities follow. ∎

Now suppose (S\subseteq F(a)) is closed under canonical circuits. For every (j\in S),

[
C_j\subseteq S\setminus{j},
]

and (C_j) covers (R_j). The boundary-grid lemma shows that no real time can make all speeds in (S) safe at threshold (1/N).

Put (m=|S|). Since (m\le n),

[
\frac1{m+1}\ge\frac1{n+1}=\frac1N.
]

Therefore the subtuple indexed by (S) has no witness at the standard (m)-runner threshold (1/(m+1)). It is a genuine positive-integer Lonely Runner counterexample in dimension (m).

Consequently:

[
\boxed{\text{Every failure of circuit escape, including a proper closed }S,
\text{ refutes unrestricted LRC.}}
]

The prompt’s statement that only an all-pivot closed subset would disprove LRC is therefore `rejected`.

Conversely, if positive-integer LRC holds in every dimension, apply it to the subtuple (S). Its (1/(m+1))-witness is also a (1/N)-witness, and the boundary-grid lemma contradicts closure.

Hence, as schemas over all dimensions,

[
\boxed{\text{MODULAR-COVER-CIRCUIT-ESCAPE}
\iff \text{positive-integer LRC}.}
]

Through the supplied repository equivalence, this has the same global truth value as unrestricted real LRC. The circuit formulation is finite and canonical, but it does not reduce the logical strength of the unresolved theorem.

## 5. Attack A

For a private point (r\in B_i^j), write (p=a_j), (b=a_i), and (M=Np). Strict badness gives a unique centered equation

[
rb=qNp+e,\qquad |e|<p.
]

Uniqueness follows from (N\ge3), since the two strict bad arcs do not meet.

The natural attempt is to use (q) as a residue at the owner pivot (i). Two independent failures occur.

### Failure 1: the quotient need not be a target candidate

For ((1,3,4,5)), (N=5), take pivot (p=3), owner (b=1), and the private point (r=1). Then

[
1\cdot1=0\cdot15+1.
]

Thus (q=0), and (N\mid q). It is excluded from (R_i), so the circuit at pivot (1) says nothing about it.

Closure, minimality, and private-point status do not themselves imply (N\nmid q).

### Failure 2: target badness does not transport back

In the same fixture, the private points belonging to owner (1) in (C_3) include (r=13). Its source equation is

[
13\cdot1=1\cdot15-2.
]

Here (q=1\in R_1). The circuit at pivot (1) is (C_1={5}), and

[
1\cdot5=1\cdot5+0,
]

so (q\in B_5^1).

Nevertheless,

[
13\cdot5=65\equiv5\pmod{15},
\qquad
\rho_{15}(65)=5\ge3.
]

Therefore

[
13\notin B_5^3.
]

Indeed,

[
C_3\setminus{1}\cup C_1={4,5}
]

does not cover this private point.

The general arithmetic identity explains the missing implication. If

[
rb=qNp+e,\qquad |e|<p,
]

and target badness gives

[
qh=sNb+f,\qquad |f|<b,
]

then exact multiplication yields

[
b\bigl(rh-sN^2p\bigr)=eh+Npf.
]

No nonunit is cancelled in a congruence; the right side is exactly divisible by (b). But transfer would require

[
\rho_{Np}\left(\frac{eh+Npf}{b}\right)<p,
]

and the hypotheses provide no such bound. In the example, the quotient is (-10), whose residue modulo (15) has cyclic distance (5).

### Failure 3: successful replacement need not decrease the circuit key

For ((1,6,11,12,13)),

[
C_1={6},\qquad C_6={1,11,12,13}.
]

At the original pivot (1), owner (1) from (C_6) is diagonal and inadmissible. Owner (12) alone covers (R_1), because (12\equiv0\pmod6). But the replacement key is

[
(1,[12]),
]

which is lexicographically larger than the canonical key

[
(1,[6]).
]

Using all non-diagonal owners ({11,12,13}) increases cardinality. In the reverse direction, replacing owner (1) in (C_6) by (C_1={6}) introduces the original pivot (6), which is not an owner at that pivot.

Thus the false selector cycle cannot be resolved by the proposed elimination without a new arithmetic theorem proving both private-point coverage and strict key decrease. No such theorem was established.

## 6. Attack B

For a fixed pivot (j), write

[
U_j(A)=\bigcup_{i\in A}B_i^j.
]

Then

[
\operatorname{rank}_j(A)=|U_j(A)|.
]

It satisfies:

[
\operatorname{rank}_j(\varnothing)=0,
]

[
A\subseteq D\implies \operatorname{rank}_j(A)\le\operatorname{rank}_j(D),
]

and

[
\operatorname{rank}_j(A)+\operatorname{rank}_j(D)
\ge
\operatorname{rank}_j(A\cup D)+\operatorname{rank}_j(A\cap D).
]

For submodularity, (U_j(A\cup D)=U_j(A)\cup U_j(D)), while

[
U_j(A\cap D)\subseteq U_j(A)\cap U_j(D).
]

The exact marginal is

[
\operatorname{rank}_j(A\cup{i})-\operatorname{rank}_j(A)
========================================================

\left|B_i^j\setminus U_j(A)\right|.
]

At a canonical circuit,

[
\operatorname{def}_j(C_j\setminus{i})
=====================================

\left|B_i^j\setminus
\bigcup_{h\in C_j\setminus{i}}B_h^j
\right|>0.
]

This is a coverage polymatroid, not a matroid rank. Singleton ranks and marginal increments can exceed (1). For example, in ((1,3,4)), the singleton owner (4) at pivot (1) has rank (3=|R_1|).

### Exact singleton count with nonunit fibers

Let (p=a_j), (b=a_i),

[
g=\gcd(b,Np),\qquad d=\gcd(b,p),\qquad
L=\left\lfloor\frac{p-1}{N}\right\rfloor.
]

Multiplication by (b) modulo (Np) has image the multiples of (g), with fiber size (g). Removing the excluded residues (r=Nk) gives

[
\boxed{
|B_i^j|
=======

## g\left(2\left\lfloor\frac{p-1}{g}\right\rfloor+1\right)

d\left(2\left\lfloor\frac{L}{d}\right\rfloor+1\right).
}
]

This retains nonunits and gcd degeneracies exactly. It does not control overlaps among different owners, and therefore cannot determine a circuit or a cross-pivot rank inequality.

### The decisive proposed rank inequality is the witness problem

For nonempty (S), define the internal deficit sum

[
D_N(S)=
\sum_{j\in S}
\operatorname{def}_j(S\setminus{j}).
]

All summands are nonnegative. Hence (D_N(S)>0) exactly when some pivot (j\in S) has a residue in (R_j) safe against every other speed in (S).

Such a residue directly gives a real (1/N)-witness. Conversely, the boundary-grid lemma turns every real (1/N)-witness into such a residue. Therefore

[
\boxed{
D_N(S)>0
\iff
\text{the subtuple }S\text{ has a real witness at threshold }1/N.
}
]

If (S) is closed, (C_j\subseteq S\setminus{j}) covers (R_j), so every summand is zero. Proving (D_N(S)>0) would rule out closure, but it is exactly the subtuple Lonely Runner witness statement, not a consequence of submodularity.

Local coverage-rank axioms alone cannot imply escape. As an abstract countermodel, take two labels with singleton residue sets (R_1={x}), (R_2={y}), and

[
B_2^1=R_1,\qquad B_1^2=R_2.
]

Both rank functions are normalized, monotone, and submodular; both canonical circuits have private points; and ({1,2}) is closed. This is not an arithmetic counterexample, but it proves that a successful rank argument needs a genuinely new cross-pivot arithmetic axiom.

No such noncircular inequality was obtained. The ranks live on different moduli, their gcd fibers differ, diagonal owners are excluded differently, and coincident bad sets retain separate labels.

## 7. Falsification

The required scan was run in the exact order:

[
n=2,3,4,5,6,
]

then primitive strictly increasing tuples lexicographically, with largest speed at most (12). Primitive means gcd (1).

For every tuple:

1. Pivots were processed in natural order.
2. Complete covers were ordered by cardinality and then increasing speed list.
3. Nonempty subsets of (F(a)) were ordered by cardinality and then lexicographically.
4. The run would stop at the first closed subset.

The counts were:

|       (n) | Primitive tuples examined |
| --------: | ------------------------: |
|         2 |                        45 |
|         3 |                       196 |
|         4 |                       479 |
|         5 |                       786 |
|         6 |                       923 |
| **Total** |                 **2,429** |

No closed subset was found.

This is only `computed finite evidence`. No larger box, random search, or second scan was run.

The scan did produce exact counterexamples to two sufficient elimination rules:

* The centered quotient need not lie in the target candidate set.
* Even when the quotient is covered by the target circuit, target badness need not transport back to the original private point.

Neither counterexample refutes the frozen circuit-escape lemma.

## 8. Complete implication chain

### Case (n=1)

Here (N=2). There is one pivot with speed (p>0) and no nonpivot owners. Its modulus is (2p). The residue (r=1) lies in (R_j), since it is odd, and no bad owner set exists.

The pivot coordinate satisfies

[
\rho_{2p}(p)=p,
]

so equality is safe. This gives a canonical pivot certificate without invoking a circuit or a second pivot.

### Case (n\ge2), conditional on circuit escape

Assume every pivot is covered. Then

[
F(a)=\mathrm{Fin},n,
]

which is nonempty. Apply circuit escape to (S=F(a)). It produces

[
j\in F(a),\qquad i\in C_j,\qquad i\notin F(a).
]

But every owner (i) is an element of (\mathrm{Fin},n=F(a)), a contradiction.

Hence some pivot (j) is not covered. Since

[
Q_j=R_j\setminus\bigcup_{i\ne j}B_i^j
]

is nonempty, choose (r\in Q_j). Then:

[
N\nmid r,
]

[
\rho_{Np_j}(r a_i)\ge p_j\qquad(i\ne j),
]

and, from pivot safety,

[
\rho_{Np_j}(r p_j)\ge p_j.
]

Thus the time

[
t=\frac{r}{Np_j}
]

satisfies

[
|t a_i|\ge\frac1N
]

for every speed.

At the repository level, the directions required are:

[
\text{pivot certificate}
\longrightarrow
\text{fixed-instance witness}
]

using the right-to-left direction of

```text
exists_witness_iff_exists_pivot_certificate;
```

[
\text{PositiveIntegerPivotCertificateConjecture}
\longrightarrow
\text{PositiveIntegerConjecture}
]

using the right-to-left direction of

```text
positiveIntegerConjecture_iff_pivotCertificateConjecture;
```

and

[
\text{PositiveIntegerConjecture}
\longrightarrow
\text{Conjecture}
]

using the right-to-left direction of

```text
conjecture_iff_positiveIntegerConjecture.
```

No density argument is needed or used.

The implication chain is complete but remains `conditional` because the escape lemma remains `open`.

## 9. Artifacts and replay

The computation used CPython 3.13.5 with exact arbitrary-precision integer arithmetic.

Replay command:

```bash
python3 modular_cover_circuit_scan.py \
  --output modular_cover_circuit_scan.json
```

Artifacts:

* [Exact scan and regression source](sandbox:/mnt/data/modular_cover_circuit_scan.py)
* [Machine-readable replay output](sandbox:/mnt/data/modular_cover_circuit_scan.json)

SHA-256:

```text
modular_cover_circuit_scan.py
6440b7877e5218049b99780e40e1d2a94dc8ac376d4983a3c2d330a36be9fde2

modular_cover_circuit_scan.json
582d3d5b0a31622241dbbd60836274b232737dd76a68043fa86d8ba1e35c5f62
```

The JSON contains the full fixture pivot records, owner-labelled bad sets, good residues, canonical circuits, private points, centered quotient equations, permutation and scaling checks, scan-domain declaration, and early-stop result.

No Lean prototype was created.

## 10. Final boundary

**`proved-lean`:** The three supplied repository equivalences, at their supplied exact strength.

**`proved-math`:** Cover equivalence, canonical-cover existence and uniqueness, inclusion-minimality, private points, reflection classification, pivot safety, coverage-polymatroid properties, the gcd-dependent singleton formula, the boundary-grid lemma, and the theorem that every closed subset yields a genuine lower-dimensional LRC counterexample. These remain pending independent project audit.

**`computed finite evidence`:** All mandatory fixtures and edge regressions pass. No closed subset occurs among the 2,429 prescribed primitive tuples.

**`rejected`:** Quotient membership in the second pivot grid is not automatic. Badness at the second pivot does not transport to the original modulus. Successful replacement does not automatically decrease the canonical key. Local submodularity alone cannot imply circuit escape. The claim that a proper closed subset would not refute LRC is also rejected.

**`conditional`:** Circuit escape implies a pivot certificate and therefore unrestricted real LRC through the supplied Lean equivalences.

**`open`:** The exact frozen circuit-escape lemma, every genuinely arithmetic cross-pivot elimination or rank inequality sufficient to prove it, and unrestricted LRC.
