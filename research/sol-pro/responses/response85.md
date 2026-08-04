## 1. **Disposition** -- `STOP`

`WIDTH-TWO-JUNCTION-COVER-DEFICIT` is false.

The positive injective tuple

[
a=(1,2,5,7,9,11,12,13),\qquad n=8,\qquad N=9
]

has exact pivot certificates, including (j=3), (p_j=7), (r=8), but exhaustive enumeration of every normalized width-two construction gives

[
\min_D J_j(D)\ge |R_j|
]

at all eight pivots. There are (793{,}800) normalized constructions per pivot.

At the certificate pivot (j=3),

[
|R_3|=56,\qquad
\left|\bigcup_{i\ne 3}B_i^3\right|=50,\qquad
G_3=6,\qquad
\min_DJ_3(D)=56.
]

Thus the minimum width-two overcount is exactly the six-residue uncovered gap. This refutes only the proposed invariant. It does not refute the pivot theorem or Lonely Runner.

---

## 2. **Frozen definitions and normalization audit**

Let (m=|O_j|=n-1).

For (m\le 3), the unique construction is the one-node tree with bag (O_j). All claims are immediate.

For (m>3), a finite encoding consists of:

* a length-(m) permutation (\sigma) of the canonically ordered owner type (O_j);
* the constraint (\sigma(0)<\sigma(1)<\sigma(2));
* a length-((m-3)) array of increasing owner pairs
  [
  S_k=(x_k,y_k),\qquad x_k<y_k,\qquad k=3,\ldots,m-1;
  ]
* a proof or Boolean certificate that (S_k) occurs in at least one earlier bag;
* derived bags
  [
  \operatorname{bag}*0={\sigma(0),\sigma(1),\sigma(2)},
  \quad
  \operatorname{bag}*{k-2}=S_k\cup{\sigma(k)};
  ]
* the derived parent
  [
  \operatorname{parent}(k-2)
  ==========================

  \min{b<k-2:S_k\subseteq\operatorname{bag}_b}.
  ]

Owner labels are never quotiented by equality of bad sets.

### Parent existence and strict precedence

The separator admissibility condition makes

[
{b<k-2:S_k\subseteq\operatorname{bag}_b}
]

a nonempty finite set. Its least element exists and satisfies

[
\operatorname{parent}(c)<c.
]

The least-parent rule introduces no additional enumeration choice.

### Tree property

Every nonroot bag has exactly one parent with smaller index. Repeated parent iteration produces a strictly decreasing sequence of natural indices, so it terminates at bag (0). Hence every bag is connected to the root.

A cycle is impossible because its largest-index vertex would have to connect along the cycle to a vertex larger than its unique smaller parent. Equivalently, the graph is connected and has one edge for every nonroot bag. It is therefore a finite rooted tree.

### Bag and separator cardinalities

The root has three owners. At step (k), the owner (\sigma(k)) has not appeared in an earlier bag. Therefore (\sigma(k)\notin S_k), and

[
|\operatorname{bag}_{k-2}|=3.
]

The parent is earlier, so it cannot contain (\sigma(k)). Consequently,

[
\operatorname{bag}*{k-2}
\cap
\operatorname{bag}*{\operatorname{parent}(k-2)}
===============================================

S_k,
]

and every separator has exactly two owners.

### Bag coverage

The root covers (\sigma(0),\sigma(1),\sigma(2)). Each later owner (\sigma(k)) occurs in bag (k-2). Since (\sigma) is a bijection,

[
\bigcup_b\operatorname{bag}_b=O_j.
]

### Running intersection

Induct over the actual bag-introduction order.

Initially each root owner occurs in the one root bag, hence in a connected subtree. Suppose the property holds before adding child bag (c).

* The newly introduced owner (\sigma(c+2)) occurs for the first time in bag (c), so its current occurrence set is connected.
* If an old owner (i) does not belong to the new bag, its occurrence set is unchanged.
* If an old owner (i) belongs to the new bag, then (i\in S_{c+2}), because the third owner is new. The parent bag also contains (S_{c+2}), so the new bag is attached directly to an existing bag containing (i).

Thus adding the new occurrence preserves connectedness. Therefore, for every owner (i), the bags containing (i) induce a connected subtree.

### Exact construction count

Once (t) owners have been introduced, the pairs occurring in earlier bags form the edge set of a growing labelled (2)-tree. The root contributes three pairs. Every new owner creates exactly two new pairs, because that owner has not appeared before. Thus there are

[
2t-3
]

available separator pairs when (t) owners are present.

For (m>3), the exact number of normalized constructions is

[
\boxed{
\binom m3(m-3)!
\prod_{t=3}^{m-1}(2t-3)
}.
]

In particular:

[
\begin{array}{c|c}
m&#D\ \hline
4&12\
5&300\
6&12{,}600\
7&793{,}800
\end{array}
]

These are finite encodings suitable for literal enumeration and for a Lean `Fintype`.

---

## 3. **Local junction theorem**

Write

[
A_b=U_j(\operatorname{bag}_b)
]

and, for a nonroot child (c) with parent (b),

[
C_c
===

# U_j(\operatorname{bag}_c\cap\operatorname{bag}_b)

U_j(S_{c+2}).
]

All cardinalities below are cast to `Int`.

### Leaf induction

Let (c) be a nonroot leaf and set

[
W=\bigcup_{d\ne c}A_d.
]

Because the parent bag remains in the family,

[
C_c
\subseteq A_c\cap A_b
\subseteq A_c\cap W.
]

Exact finite-set cardinality gives

[
|W\cup A_c|
===========

|W|+|A_c|-|W\cap A_c|.
]

Since (C_c\subseteq W\cap A_c),

[
\operatorname{Int}(|W\cap A_c|)
\ge
\operatorname{Int}(|C_c|).
]

Hence

[
\operatorname{Int}(|W\cup A_c|)
\le
\operatorname{Int}(|W|)
+
\operatorname{Int}(|A_c|)
-------------------------

\operatorname{Int}(|C_c|).
]

This subtraction is in `Int`; no truncated natural subtraction occurs.

Remove the leaf and its parent edge. Every other bag and parent edge remains unchanged. Applying the induction hypothesis to the remaining rooted tree gives

[
\operatorname{Int}\left(\left|\bigcup_bA_b\right|\right)
\le
\sum_b\operatorname{Int}(|A_b|)
-------------------------------

\sum_{c>0}\operatorname{Int}(|C_c|).
]

For a one-bag tree, the statement is equality. Because the bags cover (O_j),

[
\bigcup_bA_b
============

# U_j(O_j)

\bigcup_{i\ne j}B_i^j.
]

Therefore

[
\boxed{
\operatorname{Int}
\left(
\left|\bigcup_{i\ne j}B_i^j\right|
\right)
\le J_j(D)
}.
]

This proves `LOCAL-JUNCTION-BOUND` as generic finite-set mathematics.

Since its left side is nonnegative,

[
0\le J_j(D).
]

### Introduction-order identity

For child (c), put (z=\sigma(c+2)) and (S=S_{c+2}). Then

[
U_j(\operatorname{bag}_c)
=========================

U_j(S)\cup B_z^j.
]

Therefore

[
|U_j(\operatorname{bag}_c)|-|U_j(S)|
====================================

|B_z^j\setminus U_j(S)|.
]

After casting every term to `Int`,

[
\boxed{
J_j(D)
======

\operatorname{Int}(|U_j(\operatorname{bag}*0)|)
+
\sum*{c>0}
\operatorname{Int}
\left(
|B_{\sigma(c+2)}^j\setminus U_j(S_{c+2})|
\right)
}.
]

### Exact component interpretation

For an owner (i), let (T_i) be its connected bag-subtree. For a residue (r), define the covering-owner set

[
C_r={i\in O_j:r\in B_i^j}
]

and the forest

[
H_r=\bigcup_{i\in C_r}T_i.
]

For each bag (b),

[
r\in U_j(\operatorname{bag}_b)
\iff b\in V(H_r).
]

For each tree edge (e),

[
r\in U_j(\text{separator}_e)
\iff e\in E(H_r).
]

Consequently,

[
J_j(D)
======

\sum_{r\in U_j(O_j)}
\bigl(|V(H_r)|-|E(H_r)|\bigr).
]

Since (H_r) is a forest, (|V|-|E|) is its number of connected components, denoted (\kappa_D(r)). Thus

[
\boxed{
J_j(D)=
\sum_{r\in U_j(O_j)}\kappa_D(r)
}
]

and

[
\boxed{
J_j(D)-|U_j(O_j)|
=================

\sum_{r\in U_j(O_j)}(\kappa_D(r)-1)
}.
]

The junction overcount is exactly a disconnected-owner-subtree penalty.

---

## 4. **Logical-strength and route-separation audit**

For a fixed tuple (a), define

[
\mathcal C(a):\iff \exists j,\ Q_j\ne\varnothing
]

and

[
\mathcal W(a):\iff
\exists j,D,\ J_j(D)<\operatorname{Int}(|R_j|).
]

`LOCAL-JUNCTION-BOUND` proves

[
\mathcal W(a)\Longrightarrow\mathcal C(a).
]

The counterexample below satisfies

[
\mathcal C(a)
\quad\text{and}\quad
\neg\mathcal W(a).
]

Therefore the width-two condition is pointwise strictly stronger than existence of a pivot certificate. It is not an equivalence restatement.

### Collapse for (n\le4)

When (n\le4),

[
m=n-1\le3.
]

There is one bag, namely (O_j), and no separator. Hence

[
J_j(D)=|U_j(O_j)|
]

exactly. Consequently,

[
J_j(D)<|R_j|
\iff
Q_j\ne\varnothing.
]

Thus the width-two restriction introduces no loss in these dimensions.

### Genuine restriction for (n\ge5)

For four labelled owner sets, assign one universe point (e_{uv}) to exactly each owner pair ({u,v}). The exact union has six points.

Every normalized (m=4) construction chooses three root owners and introduces the fourth on a separator pair. The introduced owner and the root owner omitted from that separator share one point not covered by the separator. Therefore every construction overcounts at least once:

[
|U|=6,\qquad \min_DJ(D)=7.
]

This is the earliest possible (m), corresponding to (n=5), at which width two can impose a genuine loss.

### Exact gap formulation

Because

[
|R_j|=|U_j(O_j)|+G_j,
]

the component identity gives

[
J_j(D)<|R_j|
\iff
\sum_{r\in U_j(O_j)}(\kappa_D(r)-1)<G_j.
]

At a covered pivot (G_j=0), strict deficit is impossible. Equality may or may not be attainable. For example, the mandatory P82 fixture has a covered pivot with (J_{\min}>|R_j|).

At an uncovered pivot, the uncovered count supplies a gap, but width-two disconnectedness can consume all of it. That is exactly what happens in the counterexample.

### Route separation

The proof and refutation use only:

* finite owner-labelled sets;
* normalized (2)-tree introduction;
* finite-set cardinality;
* one-variable modular congruence counting;
* local (2)-tree exchanges;
* exact exhaustive enumeration and a state dynamic program.

No Fourier or character sums, signed Gram forms, PSD arguments, Hall transport, private points, sparse-cover exchange, whole-block packing, primes, prime powers, top-two arguments, Gamma matching, height bounds, deletion, divisor blocks, or witness lifting are used.

No uncovered pivot is assumed in proving the local theorem or minimizing (J_j(D)). The certificate is extracted independently after the junction minima have been computed.

---

## 5. **Attack A: modular intersection classification**

Fix a pivot and abbreviate

[
p=p_j,\qquad M=Np.
]

Let

[
T_p={-(p-1),\ldots,-1,0,1,\ldots,p-1}.
]

Because (N\ge4),

[
2p-1<M,
]

so reduction modulo (M) is injective on (T_p). The strict bad band is precisely the image of (T_p). The targets (\pm p) are not included.

For (A\subseteq O_j), with (1\le |A|\le3), define

[
I_A=
\left|
\bigcap_{i\in A}B_i^j
\right|.
]

### Solutions before candidate exclusion

For each (i\in A), put

[
g_i=\gcd(a_i,M),
\qquad
d_i=\frac{M}{g_i}.
]

For a target (t_i\in T_p), the congruence

[
a_i r\equiv t_i\pmod M
]

has solutions only if (g_i\mid t_i). When this holds, define

[
u_i(t_i)
\equiv
\left(\frac{a_i}{g_i}\right)^{-1}
\frac{t_i}{g_i}
\pmod{d_i}.
]

This inverse exists because

[
\gcd\left(\frac{a_i}{g_i},d_i\right)=1.
]

The simultaneous system for (\mathbf t=(t_i)_{i\in A}) is compatible exactly when

[
u_i(t_i)\equiv u_h(t_h)
\pmod{\gcd(d_i,d_h)}
]

for every (i,h\in A). This is the generalized CRT condition; no coprimality of the (d_i) is assumed.

Let

[
L_A=\operatorname{lcm}_{i\in A}d_i.
]

For a compatible target vector, the number of solutions (r\bmod M) is

[
\frac{M}{L_A}.
]

### Candidate subtraction

An excluded candidate has the form

[
r=Ns,\qquad s\bmod p.
]

Then

[
a_iNs\equiv t_i\pmod{Np}
]

requires (N\mid t_i). Writing

[
v_i=\frac{t_i}{N},
]

the reduced system is

[
a_i s\equiv v_i\pmod p.
]

Put

[
h_i=\gcd(a_i,p),
\qquad
e_i=\frac{p}{h_i}.
]

When (h_i\mid v_i), define

[
w_i(v_i)
\equiv
\left(\frac{a_i}{h_i}\right)^{-1}
\frac{v_i}{h_i}
\pmod{e_i}.
]

The reduced system is compatible exactly when

[
w_i(v_i)\equiv w_h(v_h)
\pmod{\gcd(e_i,e_h)}
]

for all (i,h\in A). Let

[
E_A=\operatorname{lcm}_{i\in A}e_i.
]

A compatible reduced target vector contributes

[
\frac{p}{E_A}
]

excluded (N)-multiple solutions.

### Exact intersection formula

Let (\chi_M^A(\mathbf t)) be the indicator of all (g_i)-divisibility and generalized-CRT compatibility conditions above. Let (\chi_p^A(\mathbf v)) be the corresponding reduced indicator. Then

[
\boxed{
I_A
===

\frac{M}{L_A}
\sum_{\mathbf t\in T_p^A}
\chi_M^A(\mathbf t)
-------------------

\frac{p}{E_A}
\sum_{\substack{\mathbf t\in T_p^A\
N\mid t_i\ \forall i}}
\chi_p^A!\left(\left(\frac{t_i}{N}\right)_{i\in A}\right)
}.
]

This formula retains:

* all nonunit fibers;
* all gcd compatibility conditions;
* both cyclic signs;
* zero targets;
* candidate subtraction;
* distinct labels for coincident bad sets;
* noncoprime moduli;
* strict exclusion of (\rho=p).

No owner speed is cancelled modulo (M) unless its required unit condition has first been established.

### Singleton formula

For one owner (i),

[
\boxed{
|B_i^j|
=======

g_i
\left(
2\left\lfloor\frac{p-1}{g_i}\right\rfloor+1
\right)
-------

h_i
\left(
2\left\lfloor\frac{p-1}{Nh_i}\right\rfloor+1
\right)
}.
]

The first term counts all strict-band fibers. The second subtracts exactly those fibers whose source residue is an excluded (N)-multiple.

### Pair and triple unions

Writing (I_x=|B_x^j|), (I_{xy}=|B_x^j\cap B_y^j|), and similarly for triples,

[
\boxed{
|U_j({x,y})|
============

I_x+I_y-I_{xy}
}
]

and

[
\boxed{
|U_j({x,y,z})|
==============

I_x+I_y+I_z
-I_{xy}-I_{xz}-I_{yz}
+I_{xyz}.
}
]

Consequently,

[
\begin{aligned}
|U_j({x,y,z})|-|U_j({x,y})|
&=
I_z-I_{xz}-I_{yz}+I_{xyz}\
&=
\boxed{
|B_z^j\setminus(B_x^j\cup B_y^j)|
}.
\end{aligned}
]

The exact modular formulas therefore compute every root cost and every leaf marginal.

### First failed strict estimate

To prove the sole target from these formulas, one would need, for some pivot,

[
\min_DJ_j(D)
\le
|U_j(O_j)|+G_j-1
================

|R_j|-1.
]

For the counterexample at (j=3), the required upper bound is (55), while exact enumeration gives (56). No approximation error is involved. The exact optimum already misses the necessary one-unit strictness.

Thus the first unsupported arrow is the transition from exact intersection counts to a tuple-uniform choice of pivot and construction satisfying a strict deficit.

---

## 6. **Attack B: elimination/energy**

Define the exact marginal cost

[
c(z\mid x,y)
============

|B_z^j\setminus(B_x^j\cup B_y^j)|.
]

Then

[
J_j(D)
======

|U_j(\operatorname{bag}_0)|
+
\sum c(z\mid x,y).
]

### Separator replacement

Suppose two separator pairs (S={x,y}) and (S'={x',y'}) are both available before introducing (z), and the replacement preserves every later separator's availability. Then

[
\begin{aligned}
J(D')-J(D)
&=
c(z\mid x',y')-c(z\mid x,y)\
&=
|B_z\cap(B_x\cup B_y)|
----------------------

|B_z\cap(B_{x'}\cup B_{y'})|.
\end{aligned}
]

There is no uniform sign.

The exchange is invalid when a later bag uses an edge created only by the old separator and no explicit rerouting is supplied. Recomputing the deterministic least parent is mandatory, although the parent index itself does not change the separator cardinality.

### Independent adjacent introductions

If (u) and (v) use separator pairs that were both available before either owner was introduced, then the introductions commute:

[
c(u\mid S)+c(v\mid T)
=====================

c(v\mid T)+c(u\mid S).
]

The exchange has exact difference zero.

### Triangle rotation

Suppose the old construction introduces (u) on ({x,y}), then introduces (v) on ({u,x}). The valid rotated construction introduces (v) on ({x,y}), then (u) on ({v,x}). The exact difference is

[
\boxed{
J_{\mathrm{new}}-J_{\mathrm{old}}
=================================

## |B_u\cap B_y\setminus(B_v\cup B_x)|

|B_v\cap B_y\setminus(B_u\cup B_x)|
}.
]

Again, either sign can occur. There is no monotone uncrossing rule.

### Root-edge flip

The two valid configurations

[
\text{root }{x,y,u},\quad v\text{ introduced on }{x,y},
]

and

[
\text{root }{x,y,v},\quad u\text{ introduced on }{x,y},
]

have the same contribution:

[
|U({x,y})|
+c(u\mid x,y)
+c(v\mid x,y).
]

The exact difference is zero.

### Leaf elimination order

For a fixed construction, changing the order in which leaves are removed in the proof does not change any bag or separator term. The exact before/after difference is zero.

### Exact energy form

The component identity gives

[
J_j(D)-|U_j(O_j)|
=================

\sum_{r\in U_j(O_j)}(\kappa_D(r)-1).
]

Thus minimizing (J_j(D)) is exactly minimizing the total number of additional connected components in the unions of owner subtrees selected by covered residues.

A covered pivot has (G_j=0), so it can never supply a strict deficit. An uncovered pivot succeeds precisely when its minimum disconnectedness penalty is strictly smaller than (G_j).

### Independent optimized minimization

The optimized checker uses the state

[
(V,E),
]

where (V) is the introduced-owner set and (E) is the set of owner pairs that occur in an earlier bag. Let (F(V,E)) be the minimum partial junction cost.

For every (z\notin V) and ({x,y}\in E),

[
\boxed{
F!\left(
V\cup{z},
E\cup{{z,x},{z,y}}
\right)
=======

\min
\left[
F(V,E)+c(z\mid x,y)
\right].
}
]

Future feasibility depends only on the available-pair set (E). The least-parent index is reconstructed from the selected history but does not affect future separator availability or junction cost.

For (m=7), the optimized state counts by introduced-owner cardinality are

[
35,\ 210,\ 1{,}470,\ 8{,}505,\ 27{,}951.
]

The literal construction enumerator, bit-vector state DP, and a separately implemented direct-set state DP agreed at every pivot of all mandatory named fixtures and the counterexample.

The exact counterexample penalties are

[
\begin{array}{c|c|c}
j&G_j&\min_DJ_j(D)-|U_j(O_j)|\ \hline
3&6&6\
4&8&8\
5&6&8\
6&6&6\
7&8&8
\end{array}
]

so width-two overcount consumes all available strictness at every certificate pivot.

---

## 7. **Exhaustive falsification report**

### Scaling and permutation reductions

For common scaling (a'_i=c,a_i),

[
p'_j=cp_j,\qquad M'_j=cM_j.
]

Reduction

[
\pi:\mathbb Z/(cM_j)\to\mathbb Z/M_j
]

has exactly (c) fibers. Since (M_j) is divisible by (N),

[
N\mid r
\iff
N\mid \pi(r).
]

Moreover,

[
\rho_{cM_j}(c,x)=c,\rho_{M_j}(x).
]

Therefore

[
R'_j=\pi^{-1}(R_j),
\qquad
(B_i^j)'=\pi^{-1}(B_i^j).
]

Every bag union and separator union has (c) times its original cardinality:

[
J'_j(D)=cJ_j(D),\qquad |R'_j|=c|R_j|.
]

Thus

[
J'_j(D)<|R'_j|
\iff
J_j(D)<|R_j|.
]

Primitive restriction is valid in both directions.

Owner permutation simply relabels pivots and bad sets. Mapping bags and separators through the permutation, sorting only the root triple and each separator pair, gives a bijection of normalized construction sets preserving (J). Increasing tuples therefore represent all coordinate permutations for existence and minimum-value testing.

### Mandatory preflight domains

Every tuple was processed in this order:

1. dimension;
2. exact maximum speed;
3. increasing primitive tuple, lexicographically;
4. pivot index;
5. normalized (\sigma);
6. separator sequence;
7. deterministic least parent.

The full output contains every required per-pivot record.

| (n) | maximum | primitive tuples | pivots | constructions per pivot | tuples with coincident bad sets | coincident-set pivots | result               |
| --: | ------: | ---------------: | -----: | ----------------------: | ------------------------------: | --------------------: | -------------------- |
|   3 |      20 |              997 |  2,991 |                       1 |                             119 |                   123 | no invariant failure |
|   4 |      20 |            4,619 | 18,476 |                       1 |                           1,845 |                 2,088 | no invariant failure |
|   5 |      20 |           15,246 | 76,230 |                      12 |                           7,514 |                 9,043 | no invariant failure |
|   6 |      15 |            4,998 | 29,988 |                     300 |                           4,208 |                 6,026 | no invariant failure |

All (25{,}860) tested tuples had at least one exact pivot certificate and at least one strict junction deficit. This is finite evidence only and supplies no unrestricted theorem.

The four domains required (9{,}932{,}627) literal normalized-construction evaluations.

### Named fixture reproduction

Pivot indices are zero-based.

| fixture | certificate pivot | (p_j) | (|R_j|) | exact union | (G_j) | (\min J_j) | least (r) |
|---|---:|---:|---:|---:|---:|---:|---:|
| P76 ((1,4,5,6,7,11)) | 3 | 6 | 36 | 34 | 2 | 34 | 13 |
| P77 ((6,7,168)) | 2 | 168 | 504 | 378 | 126 | 378 | 29 |
| P78 ((6,7,12,24,144)) | 4 | 144 | 720 | 560 | 160 | 560 | 25 |
| P80 ((1,3,16)) | 1 | 3 | 9 | 7 | 2 | 7 | 5 |
| P82 ((1,4,5,6,7,11,32)) | 4 | 7 | 49 | 47 | 2 | 47 | 17 |

All five reported observations were reproduced.

P82 also confirms that a covered pivot need not attain equality: at (j=3),

[
|R_3|=|U_3(O_3)|=42,
\qquad
\min_DJ_3(D)=46.
]

### Synthetic and boundary fixtures

* Five distinct labels with identical three-point bad sets:
  [
  |U|=3,\quad #D=300,\quad \min J=3.
  ]
  Labels remained distinct throughout enumeration.
* Four-owner pair-incidence fixture:
  [
  |U|=6,\quad #D=12,\quad \min J=7.
  ]
* Boundary fixture (N=4,p=3,M=12):
  [
  \rho(2)=2<p,\qquad \rho(3)=3=p,
  ]
  so (2) is bad and (3) is safe. Residues (10) and (2) test both cyclic sides; (6) tests the antipode; (0,4,8) are excluded (N)-multiples.
* P77 and P78 exercise nonunit owners and gcd-degenerate intersections.
* A common scaling replay of P76 by factor (3) multiplied every (|R|), exact union, (G), and minimum junction value by (3).
* The coordinate permutation
  [
  (5,0,2,1,4,3)
  ]
  of P76 preserved all pivot values after remapping indices.
* Repeated speeds, zero speeds, negative speeds, noninteger speeds, and (n<3) were rejected explicitly.
* A deliberately altered expectation
  [
  \min_DJ_3(D)=55
  ]
  for the counterexample was rejected; the exact value is (56).

### One added finite domain

The sole added speed domain was the singleton primitive increasing tuple

[
(1,2,5,7,9,11,12,13).
]

It was chosen to test the precise claim that width-two overcount can consume every exact uncovered residue. All

[
8\cdot793{,}800=6{,}350{,}400
]

normalized pivot constructions were enumerated.

### Deterministic replay record

The deterministic full output contains (127{,}685) preflight pivot reports, all named fixtures, synthetic fixtures, scaling and permutation checks, malformed-input checks, and the counterexample.

* Verifier source size: (16{,}689) bytes
* Full output size: (34{,}475{,}418) bytes
* Source SHA-256:
  `aee86da1bc79bb862221925b7897e335298fe407722b622a66b915578c32633a`
* Output SHA-256:
  `41b834978d4342e11bcba9a86c58db3d7ec46001685fb3ec304362a1820d2372`

---

## 8. **Sole theorem proof or counterexample certificate**

Take

[
a=(1,2,5,7,9,11,12,13).
]

All speeds are positive and pairwise distinct. The tuple is primitive and increasing.

### Complete pivot values

Every pivot has (793{,}800) normalized constructions.

| (j) | (p_j) | (|R_j|) | exact union | (G_j) | (\min_DJ_j(D)) | overcount | least uncovered (r) |
|---:|---:|---:|---:|---:|---:|---:|---:|
| 0 | 1 | 8 | 8 | 0 | 8 | 0 | none |
| 1 | 2 | 16 | 16 | 0 | 16 | 0 | none |
| 2 | 5 | 40 | 40 | 0 | 40 | 0 | none |
| 3 | 7 | 56 | 50 | 6 | 56 | 6 | 8 |
| 4 | 9 | 72 | 64 | 8 | 72 | 8 | 10 |
| 5 | 11 | 88 | 82 | 6 | 90 | 8 | 26 |
| 6 | 12 | 96 | 90 | 6 | 96 | 6 | 26 |
| 7 | 13 | 104 | 96 | 8 | 104 | 8 | 28 |

Thus

[
\forall j\ \forall D,\qquad
J_j(D)\ge |R_j|.
]

### Lexicographically least minimizing constructions

Each line lists

[
(\sigma;\ S_3,S_4,S_5,S_6;\ \text{parents};\ \text{bags};\ \text{marginals}),
]

with parent entries corresponding to child bags (1,2,3,4).

```text
j=0
sigma      = (1,2,3,4,5,6,7)
separators = ((1,2),(1,2),(1,4),(1,2))
parents    = (0,0,1,0)
bags       = ((1,2,3),(1,2,4),(1,2,5),(1,4,6),(1,2,7))
marginals  = (0,8,0,0,0)

j=1
sigma      = (0,2,3,4,5,6,7)
separators = ((0,2),(0,3),(0,4),(0,2))
parents    = (0,0,1,0)
bags       = ((0,2,3),(0,2,4),(0,3,5),(0,4,6),(0,2,7))
marginals  = (6,8,0,2,0)

j=2
sigma      = (0,1,3,5,6,4,7)
separators = ((0,1),(0,3),(0,6),(1,3))
parents    = (0,0,2,0)
bags       = ((0,1,3),(0,1,5),(0,3,6),(0,4,6),(1,3,7))
marginals  = (20,6,4,6,4)

j=3
sigma      = (0,1,5,2,6,4,7)
separators = ((0,5),(0,1),(0,6),(1,6))
parents    = (0,0,2,2)
bags       = ((0,1,5),(0,2,5),(0,1,6),(0,4,6),(1,6,7))
marginals  = (26,8,10,6,6)

j=4
sigma      = (0,1,5,2,3,6,7)
separators = ((0,5),(2,5),(1,5),(0,1))
parents    = (0,1,0,0)
bags       = ((0,1,5),(0,2,5),(2,3,5),(1,5,6),(0,1,7))
marginals  = (34,12,10,6,10)

j=5
sigma      = (0,1,7,2,3,4,6)
separators = ((0,7),(2,7),(0,2),(3,7))
parents    = (0,1,1,2)
bags       = ((0,1,7),(0,2,7),(2,3,7),(0,2,4),(3,6,7))
marginals  = (38,12,12,18,10)

j=6
sigma      = (0,1,5,2,7,3,4)
separators = ((0,5),(2,5),(5,7),(2,7))
parents    = (0,1,2,2)
bags       = ((0,1,5),(0,2,5),(2,5,7),(3,5,7),(2,4,7))
marginals  = (42,14,12,12,16)

j=7
sigma      = (0,1,4,2,5,3,6)
separators = ((0,4),(0,2),(2,5),(2,4))
parents    = (0,1,2,1)
bags       = ((0,1,4),(0,2,4),(0,2,5),(2,3,5),(2,4,6))
marginals  = (50,16,12,14,12)
```

Every separator occurs in an earlier bag, and every listed parent is the least earlier containing bag.

### Explicit certificate independent of the invariant

Choose pivot

[
j=3,\qquad p_j=7,\qquad M_j=9\cdot7=63,
]

and numerator

[
r=8.
]

Since (9\nmid8), (r\in R_3).

The exact cyclic distances, in speed-index order, are

[
\bigl(
\rho_{63}(8\cdot1),
\rho_{63}(8\cdot2),
\rho_{63}(8\cdot5),
\rho_{63}(8\cdot7),
\rho_{63}(8\cdot9),
\rho_{63}(8\cdot11),
\rho_{63}(8\cdot12),
\rho_{63}(8\cdot13)
\bigr)
]

# [

(8,16,23,7,9,25,30,22).
]

Every value is at least (7). The pivot coordinate attains equality (7), which is safe because badness is strict. Hence

[
8\in Q_3.
]

The corresponding time is

[
t=\frac{8}{63},
]

and every circle distance is at least

[
\frac7{63}=\frac19.
]

The tuple therefore has an exact Lonely Runner certificate while failing the width-two invariant at every pivot. This is the required fail-closed counterexample.

---

## 9. **Complete implication chain**

Let

[
u=
\left|\bigcup_{i\ne j}B_i^j\right|,
\qquad
r_0=|R_j|,
]

and write (\iota:\mathbb N\to\mathbb Z) for the natural-to-integer cast.

Conditionally, a strict junction deficit would give

[
\iota(u)
\le
J_j(D)
<
\iota(r_0).
]

Therefore

[
\iota(u)<\iota(r_0).
]

Strict monotonicity of the `Nat` cast gives

[
u<r_0.
]

Since every (B_i^j\subseteq R_j),

[
\left|
R_j\setminus
\bigcup_{i\ne j}B_i^j
\right|
=======

r_0-u

>

0.

]

Finite-set nonemptiness yields an explicit

[
r\in
R_j\setminus
\bigcup_{i\ne j}B_i^j
=====================

Q_j.
]

For (i\ne j),

[
r\notin B_i^j
]

and strict badness imply

[
\rho_{M_j}(ra_i)\ge p_j.
]

For the pivot coordinate,

[
\rho_{M_j}(ra_j)
================

p_j\min(r\bmod N,N-(r\bmod N))
\ge p_j,
]

because (r\in R_j) means (N\nmid r).

At time

[
t=\frac{r}{Na_j},
]

[
|ta_i|_{\mathbb R/\mathbb Z}
============================

\frac{\rho_{M_j}(ra_i)}{M_j}
\ge
\frac{p_j}{Np_j}
================

\frac1N.
]

Thus the complete conditional chain is

```text
positive injective integer tuple a
  -> WIDTH-TWO-JUNCTION-COVER-DEFICIT supplies j,D
  -> Int(|union_i B_i^j|) <= J_j(D)
  -> J_j(D) < Int(|R_j|)
  -> |union_i B_i^j| < |R_j|
  -> R_j \ union_i B_i^j is nonempty
  -> explicit r in Q_j
  -> proved-lean pivotResidueWitness
  -> positive-integer LRC
  -> proved-lean real/integer equivalence
  -> unrestricted real LRC.
```

The first substantive arrow is rejected by the counterexample. All downstream arrows remain conditional and do not establish unrestricted LRC.

---

## 10. **Proof-obligation ledger**

| Statement                                                     | Dependency                                   | Status                     | Falsification or audit                             | First open arrow                   | Stop condition                                                 | Recommended owner              |
| ------------------------------------------------------------- | -------------------------------------------- | -------------------------- | -------------------------------------------------- | ---------------------------------- | -------------------------------------------------------------- | ------------------------------ |
| Parent existence, finite tree, coverage, running intersection | normalized introduction definitions          | `proved-math`              | direct induction and decreasing-parent proof       | Lean encoding                      | unavailable pair, nonleast parent, lost label                  | Luna for one frozen Lean lemma |
| `LOCAL-JUNCTION-BOUND`                                        | tree and separator overlap                   | `proved-math`              | leaf induction plus component identity             | Lean formalization                 | truncated Nat subtraction or missing separator inclusion       | Luna                           |
| Introduction and component identities                         | running intersection, finite indicator sums  | `proved-math`              | synthetic equality and overcount fixtures          | Lean formalization                 | treating (J) as exact union for (n\ge5)                        | Luna                           |
| Singleton, pair, and triple intersection formulas             | one-variable congruences and generalized CRT | `proved-math`              | nonunit P77/P78 and direct-set replay              | Lean formalization                 | nonunit cancellation, weak band, omitted candidate subtraction | Luna                           |
| Scaling and permutation invariance                            | reduction modulo (M_j), relabelling          | `proved-math`              | factor-three and permutation fixtures              | Lean formalization                 | failure of (N)-divisibility preservation                       | Luna                           |
| Preflight and named fixtures                                  | literal normalized enumerator                | `computed finite evidence` | complete output hash and three-checker agreement   | external `/root` replay            | omitted construction or hash mismatch                          | Sol High `/root`               |
| Counterexample minima                                         | 793,800 constructions per pivot plus two DPs | `computed finite evidence` | altered value rejected; direct certificate checked | external replay or Lean reflection | checker disagreement                                           | Sol High `/root`               |
| `WIDTH-TWO-JUNCTION-COVER-DEFICIT`                            | sole universal target                        | `rejected`                 | (a=(1,2,5,7,9,11,12,13))                           | none; theorem is false             | replay contradicts a listed minimum                            | closed                         |
| Downstream implication to integer and real LRC                | local theorem plus accepted Lean bridges     | `conditional`              | cast and finite-difference chain audited           | false width-two premise            | claiming LRC after premise failure                             | `/root`                        |
| Unrestricted Lonely Runner                                    | existing project status                      | `open`                     | counterexample has witness (8/63)                  | another independent route          | promoting this invariant failure to an LRC result              | research pipeline              |

---

## 11. **Verifier and Lean plan**

### Frozen verifier types

* Speeds: finite array of arbitrary-precision positive integers.
* Malformed input:

  * reject (n<3);
  * reject nonintegers;
  * reject zero or negative speeds;
  * reject repeated speeds without deduplication.
* Pivot residues: exact finite type `Fin (N * p_j)`.
* (R_j) and (B_i^j): bit vectors and independently constructed finite sets.
* Owner labels: original `Fin n` indices, never bad-set equivalence classes.
* Ordering: length-(m) permutation with first three entries increasing.
* Separator: increasing pair of actual owner indices.
* Bag: sorted owner tuple derived from ordering and separator.
* Parent: least earlier bag containing the separator.
* Serialization:

  ```text
  tuple, pivot, |R|, |union|, G, construction_count,
  minJ, least_uncovered, sigma, separators, parents,
  bags, root-and-child marginals
  ```

### Literal checker

For every root triple, every remaining-owner permutation, and every available separator pair in lexicographic order:

1. derive the child bag;
2. derive its deterministic least parent;
3. add the exact marginal;
4. retain the first minimum in the frozen lexicographic order;
5. verify the total enumeration count against
   [
   \binom m3(m-3)!\prod_{t=3}^{m-1}(2t-3).
   ]

### Independent optimized checker

Use the exact state recurrence on introduced owners and available pairs. A second implementation should use ordinary finite sets rather than bit masks. Acceptance requires all three values to agree for every mandatory fixture and counterexample pivot.

### Lean structures and theorem signatures

A suitable skeleton is:

```text
abbrev Owner (j : Fin n) := {i : Fin n // i ≠ j}
abbrev Residue (j : Fin n) := Fin ((n+1) * a j)

def Rj (j : Fin n) : Finset (Residue a j)
def Bj (j : Fin n) (i : Owner j) : Finset (Residue a j)
def Uj (j : Fin n) (S : Finset (Owner j)) : Finset (Residue a j)

structure NormalizedWidthTwo (j : Fin n) where
  sigma          : Equiv (Fin (n-1)) (Owner j)
  root_sorted    : sigma 0 < sigma 1 ∧ sigma 1 < sigma 2
  separator      : ...
  separator_card : ...
  available      : ...
  parent         : ...
  parent_isLeast : ...

def junction (D : NormalizedWidthTwo a j) : Int
```

Required generic theorems:

```text
theorem normalized_parent_lt ...
theorem normalized_tree ...
theorem normalized_bag_cover ...
theorem normalized_running_intersection ...

theorem local_junction_bound
  (D : NormalizedWidthTwo a j) :
  ((Uj a j Finset.univ).card : Int) ≤ junction a j D

theorem junction_introduction_identity ...
theorem junction_component_identity ...
theorem modular_intersection_card ...
theorem common_scaling_junction ...
```

Counterexample declarations:

```text
def p85Speeds : Fin 8 → Nat :=
  ![1,2,5,7,9,11,12,13]

theorem p85_certificate :
  (8 : Fin 63) ∈ Q p85Speeds 3

theorem p85_no_width_two_deficit :
  ∀ (j : Fin 8) (D : NormalizedWidthTwo p85Speeds j),
    ((Rj p85Speeds j).card : Int) ≤ junction p85Speeds j D
```

The final theorem should use a reflected finite DP or a verified enumeration over the finite construction type. It must not introduce the uncovered residue as an assumption.

### Acceptance commands

```text
python3 p85_verify.py > p85_output_full.json
sha256sum p85_verify.py p85_output_full.json
```

The hashes must equal those in Section 7.

For Lean:

```text
lake env lean P85/NormalizedWidthTwo.lean
lake env lean P85/LocalJunction.lean
lake env lean P85/ModularIntersections.lean
lake env lean P85/Counterexample.lean
lake build
```

Acceptance requires:

* exact source and output hashes;
* complete construction counts;
* literal/bit-DP/set-DP agreement;
* failure of the deliberately altered (55) expectation;
* successful boundary, collision, scaling, permutation, and malformed-input fixtures;
* no theorem asserting the rejected universal target.

---

## 12. **Final evidence boundary**

* **`proved-lean`**: only the previously accepted positive-integer pivot-certificate bridge and real/integer equivalence. No new Lean result is claimed here.
* **Generic `proved-math`**: normalized construction properties, running intersection, the leaf-induction junction bound, introduction identity, component identity, exact modular intersection formulas, common-scaling law, and permutation invariance.
* **Response-authored observations**: the interpretation of junction error as disconnected owner-subtree energy and the identification of the counterexample as the route's fatal obstruction. These are not repository promotions.
* **`computed finite evidence`**: the full preflight domains, mandatory named fixtures, synthetic fixtures, all counterexample pivot minima, lexicographically least minimizers, and literal-versus-two-DP agreement under the recorded hashes.
* **`conditional`**: the implication from a strict junction deficit through the accepted pivot and real/integer bridges to unrestricted real LRC.
* **`rejected`**: `WIDTH-TWO-JUNCTION-COVER-DEFICIT`.
* **`open`**: unrestricted Lonely Runner, external replay of the frozen computation, and Lean formalization of the generic local theorem and finite counterexample.
