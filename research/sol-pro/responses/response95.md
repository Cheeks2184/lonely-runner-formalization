## 1. **Disposition**

**PIVOT**

The unrestricted `MAX-COVERED-PIVOT-INTERNAL-COVER-REDUNDANCY` theorem is neither proved nor refuted.

A new unrestricted arithmetic successor lemma is proved below:

> **MAXIMUM-PIVOT-LOWER-OWNER-SKELETON.**
> Every complete cover of a pivot (p) by distinct lower speeds (b<p) satisfies:
>
> 1. an exact gcd-sensitive formula for every labelled bad-set size;
> 2. an exact common-overlap capacity inequality;
> 3. three families of modular covering constraints on the residues (tp), (tp+1), and (tp-1);
> 4. explicit lower bounds on the cover size and therefore on (|F(a)|); and
> 5. when (N\nmid p), the cover must contain a lower owner speed divisible by (N).

This lemma applies to every hypothetical internal cover at (j_\star), uses (a_i<a_{j_\star}) essentially, is unrestricted in (n) and height, introduces no existential certificate, and strictly narrows the first open edge.

The first unsupported cross-pivot statement is the exact private-lift inclusion identified in Section 10.

---

## 2. **Evidence boundary**

| Claim or input                                                                  | Evidence label                |
| ------------------------------------------------------------------------------- | ----------------------------- |
| Frozen modular definitions and theorem quantifiers                              | `input-accepted`              |
| Positive-integer pivot-certificate equivalence                                  | `proved-lean`                 |
| Positive-integer to real-speed equivalence                                      | `proved-lean`                 |
| Finite deletion to a minimal labelled cover and relative private-point property | `proved-math-qualified`       |
| Singleton-cover rigidity                                                        | `proved-math-qualified`       |
| Three-form equivalence proved in Section 4                                      | `proved-math-response`        |
| Scaling and permutation laws                                                    | `proved-math-response`        |
| Private-point normal form ((q_i,e_i))                                           | `proved-math-response`        |
| Exact cross-pivot projection and fiber formulas                                 | `proved-math-response`        |
| Maximum-pivot lower-owner skeleton lemma                                        | `proved-math-response`        |
| Frozen bounded execution over 12,142 tuples and 59,996 pivots                   | `computed finite evidence`    |
| Sole unrestricted redundancy theorem                                            | `open`                        |
| Integer and real LRC consequences from the sole theorem                         | `conditional`                 |
| Prompt90 operational response                                                   | `rejected operational output` |
| Claims from P92, P93, P94, P89, or other separated routes                       | `out-of-scope`                |

No project-level evidence status is promoted by this response.

---

## 3. **Frozen definitions**

Let (n\ge 2), (N=n+1\ge 3), and let the labelled speed tuple be

[
a=(a_i)_{i\in I},\qquad I={0,\ldots,n-1},
]

with every (a_i>0) and all labels having distinct speeds.

For a pivot label (j), write

[
p_j=a_j,\qquad M_j=Np_j.
]

All residues are canonical representatives in ({0,\ldots,M_j-1}). Define

[
\rho_M(x)=\min(x\bmod M,;M-(x\bmod M)).
]

The candidate set is

[
R_j={r:0\le r<M_j,\ N\nmid r}.
]

Exactly (p_j) residues are excluded, so

[
|R_j|=Np_j-p_j=(N-1)p_j=np_j>0.
]

For each labelled owner (i\ne j),

[
B_i^j={r\in R_j:\rho_{M_j}(r a_i)<p_j}.
]

The inequality is strict. Residues satisfying equality are safe against that owner.

The uncovered set is

[
Q_j=R_j\setminus\bigcup_{i\ne j}B_i^j.
]

The covered-pivot set is

[
F(a)={j:Q_j=\varnothing}.
]

If (F(a)\ne\varnothing), injectivity gives a unique label (j_\star\in F(a)) with

[
a_{j_\star}=\max{a_j:j\in F(a)}.
]

For a labelled subset (C\subseteq I\setminus{j}):

[
C\text{ is complete at }j
\iff
R_j=\bigcup_{i\in C}B_i^j.
]

It is inclusion-minimal if no proper labelled subset remains complete. For (i\in C),

[
\operatorname{Priv}(j,C,i)
==========================

B_i^j\setminus\bigcup_{\substack{h\in C\h\ne i}}B_h^j.
]

Privacy is relative to (C). An omitted owner may cover every point of this set.

Owner labels are never deduplicated. In particular, if (B_i^j=B_h^j) for (i\ne h), the two owners remain separate labels.

### Pivot safety

For (r\in R_j), write (r=Nq+s) with (1\le s\le N-1). Then

[
\rho_{Np_j}(r p_j)
==================

p_j\min(s,N-s)\ge p_j.
]

Thus (r\in Q_j) is safe for the pivot coordinate and for every nonpivot coordinate.

### The three target forms

Let (p=a_{j_\star}).

1. **Redundancy form:** every complete (C\subseteq F(a)\setminus{j_\star}) has an owner whose deletion remains complete.
2. **Minimal-cover form:** every inclusion-minimal complete cover at (j_\star) contains an owner outside (F(a)).
3. **No-internal-cover form:** no subset of (F(a)\setminus{j_\star}) completely covers (R_{j_\star}).

---

## 4. **Equivalence audit**

Let (R=R_{j_\star}), which is nonempty.

### Redundancy implies no internal cover

Suppose an internal complete cover (C_0\subseteq F(a)\setminus{j_\star}) existed.

The redundancy form gives (i_0\in C_0) such that

[
C_1=C_0\setminus{i_0}
]

is complete. Repeating the same conclusion produces a strictly decreasing sequence of finite complete covers. It terminates at the empty set. That would imply

[
R=\bigcup_{i\in\varnothing}B_i^{j_\star}=\varnothing,
]

contradicting (|R|=np>0).

Hence no internal complete cover exists.

### No internal cover implies redundancy

If there is no internal complete cover, the implication

[
C\text{ internal and complete}\Longrightarrow
\exists i\in C\text{ redundant}
]

has a false premise for every (C), so the redundancy form holds.

### No internal cover implies the minimal-cover form

Let (C) be an inclusion-minimal complete cover at (j_\star). If every owner of (C) belonged to (F(a)), then, since (j_\star) cannot own its own pivot,

[
C\subseteq F(a)\setminus{j_\star},
]

contradicting the no-internal-cover form. Therefore (C) contains an owner outside (F(a)).

### The minimal-cover form implies no internal cover

Suppose (C\subseteq F(a)\setminus{j_\star}) were complete. Finite deletion yields an inclusion-minimal complete subcover (C'\subseteq C). Every owner of (C') would still belong to (F(a)), contradicting the minimal-cover form.

Therefore all three forms are equivalent, independently of LRC.

Evidence label: `proved-math-response`.

---

## 5. **Route separation**

The argument developed here is a literal fixed-pivot residue analysis.

It is not Prompt72 circuit escape. No abstract circuit, matroid rank, exchange axiom, or outgoing-edge principle is used as an arithmetic premise. The supplied abstract fixture confirms that circuit escape alone does not imply internal-cover redundancy.

It is not P92. No dyadic modulus, two-adic valuation, deletion-gcd supply, or product-divisibility threshold is introduced.

It is not P93. No common clock, rational score, or (\Psi)-functional is used.

It is not P94. The exact bad-set count uses elementary multiplication-fiber cardinalities, but there is no Möbius inversion, unit-gcd stratum, divisor-lattice deficit, or selected divisor stratum.

It is not P89. There are no bags, junction trees, separators, root stars, or square-root width bounds.

It does not use private-demand Hall sums, weighted compensation, common-prime propagation, local multiplicity scores, whole-block packing, multishifts, coefficient-two Gamma, or height compression.

The new successor lemma concerns only:

[
R(N,p),\quad B_b(N,p),\quad b<p,
]

and exact residue families (tp), (tp+1), and (tp-1).

---

## 6. **Mandatory fixtures**

Ranges such as (13\text{-}17) denote every integer in that range. Owner subscripts are shown by speed; all fixtures are injective, so this still identifies the labels uniquely. The machine-readable result contains the full literal residue arrays, every complete cover, every minimal cover, and every private set:

[Full literal fixture data](sandbox:/mnt/data/prompt95_result.json)

### Fastest-covered rows

#### ((1,6,11,12,13))

Here (N=6), (F={1,6}), and (j_\star) has speed (6).

* (p=1), (M=6), (|R|=5):
  (B_6={1\text{-}5}), (B_{11}=\varnothing), (B_{12}={1\text{-}5}), (B_{13}=\varnothing), (Q=\varnothing).
  Complete covers:
  [
  {6},{12},{6,11},{6,12},{6,13},{11,12},{12,13},
  ]
  [
  {6,11,12},{6,11,13},{6,12,13},{11,12,13},{6,11,12,13}.
  ]
  Minimal covers: ({6}), ({12}).

* (p=6), (M=36), (|R|=30):
  [
  B_1={1\text{-}5,31\text{-}35},
  ]
  [
  B_{11}={3,7,10,13,16,20,23,26,29,33},
  ]
  [
  B_{12}={3,9,15,21,27,33},
  ]
  [
  B_{13}={3,8,11,14,17,19,22,25,28,33},
  ]
  and (Q=\varnothing).
  The unique complete and minimal cover is ({1,11,12,13}).

* (p=11), (M=66):
  [
  B_1={1\text{-}5,7\text{-}10,56\text{-}59,61\text{-}65},
  ]
  [
  B_6={1,10\text{-}11,21\text{-}23,32\text{-}34,43\text{-}45,55\text{-}56,65},
  ]
  [
  B_{12}={5,11,16\text{-}17,22,27\text{-}28,33,38\text{-}39,44,49\text{-}50,55,61},
  ]
  [
  B_{13}={5,10,15\text{-}16,20\text{-}21,25\text{-}26,31,35,40\text{-}41,
  45\text{-}46,50\text{-}51,56,61}.
  ]
  [
  Q={13\text{-}14,19,29,37,47,52\text{-}53}.
  ]
  No complete cover exists.

* (p=12), (M=72):
  [
  B_1={1\text{-}5,7\text{-}11,61\text{-}65,67\text{-}71},
  ]
  [
  B_6={1,11,13,23,25,35,37,47,49,59,61,71},
  ]
  [
  B_{11}={1,7,13\text{-}14,19\text{-}20,26\text{-}27,32\text{-}33,
  39\text{-}40,45\text{-}46,52\text{-}53,58\text{-}59,65,71},
  ]
  [
  B_{13}={5,11,16\text{-}17,22\text{-}23,27\text{-}28,33\text{-}34,
  38\text{-}39,44\text{-}45,49\text{-}50,55\text{-}56,61,67}.
  ]
  [
  Q={15,21,29,31,41,43,51,57}.
  ]
  No complete cover exists.

* (p=13), (M=78):
  [
  B_1={1\text{-}5,7\text{-}11,67\text{-}71,73\text{-}77},
  ]
  [
  B_6={1\text{-}2,11,13\text{-}15,25\text{-}28,37\text{-}41,
  50\text{-}53,63\text{-}65,67,76\text{-}77},
  ]
  [
  B_{11}={1,7\text{-}8,14\text{-}15,21\text{-}22,28\text{-}29,35,43,
  49\text{-}50,56\text{-}57,63\text{-}64,70\text{-}71,77},
  ]
  [
  B_{12}={1,7,13\text{-}14,19\text{-}20,25\text{-}27,32\text{-}33,
  38\text{-}40,45\text{-}46,51\text{-}53,58\text{-}59,64\text{-}65,71,77}.
  ]
  [
  Q={16\text{-}17,23,31,34,44,47,55,61\text{-}62}.
  ]
  No complete cover exists.

The target minimal cover ({1,11,12,13}) contains three owners outside (F).

#### ((6,7,12,24,144))

Here (N=6), (F={6,7,12,24}), and (j_\star) has speed (24).

* (p=6): the owner (144) singleton-covers (R). The complete covers are exactly
  [
  {144},{7,144},{12,144},{24,144},
  ]
  [
  {7,12,144},{7,24,144},{12,24,144},{7,12,24,144}.
  ]
  The unique minimal cover is ({144}).

* (p=7), (M=42):
  [
  B_6={1,7\text{-}8,13\text{-}15,20\text{-}22,27\text{-}29,34\text{-}35,41},
  ]
  [
  B_{12}={3\text{-}4,7,10\text{-}11,14,17,21,25,28,31\text{-}32,35,38\text{-}39},
  ]
  [
  B_{24}=B_{144}={2,5,7,9,14,16,19,21,23,26,28,33,35,37,40}.
  ]
  (Q=\varnothing).
  Complete covers:
  [
  {6,12,24},\qquad {6,12,144},\qquad {6,12,24,144}.
  ]
  Minimal covers:
  [
  {6,12,24},\qquad {6,12,144}.
  ]
  The coincident sets for (24) and (144) remain separately labelled.

* (p=12): (144) singleton-covers. The eight complete covers are exactly the subsets containing (144); the unique minimal cover is ({144}).

* (p=24): (144) singleton-covers. The eight complete covers are exactly the subsets containing (144); the unique minimal cover is ({144}).

* (p=144): (Q) has 160 residues:
  [
  \begin{aligned}
  Q={}&{25\text{-}29,43\text{-}47,49\text{-}53,55\text{-}59,85\text{-}89,
  91\text{-}95,97\text{-}101,\
  &169\text{-}173,187\text{-}191,193\text{-}197,199\text{-}203,
  313\text{-}317,331\text{-}335,\
  &337\text{-}341,343\text{-}347,403\text{-}407,457\text{-}461,
  517\text{-}521,523\text{-}527,\
  &529\text{-}533,547\text{-}551,661\text{-}665,667\text{-}671,
  673\text{-}677,691\text{-}695,\
  &763\text{-}767,769\text{-}773,775\text{-}779,805\text{-}809,
  811\text{-}815,817\text{-}821,835\text{-}839}.
  \end{aligned}
  ]
  No complete cover exists.

The target pivot is (24), not (7), and its unique minimal cover ({144}) contains an owner outside (F).

#### ((1,4,5,6,7,11))

Here (N=7), (F={1,4,5,11}), and (j_\star) has speed (11).

* (p=1): (B_7=R={1,\ldots,6}); every complete cover contains (7). The unique minimal cover is ({7}).
* (p=4): the unique complete and minimal cover is ({1,5,6,7,11}).
* (p=5): the unique complete and minimal cover is ({1,4,6,7,11}).
* (p=6):
  [
  Q={13,29};
  ]
  no complete cover exists.
* (p=7):
  [
  Q={15,34};
  ]
  no complete cover exists.
* (p=11):
  [
  \begin{aligned}
  B_1&={1\text{-}6,8\text{-}10,67\text{-}69,71\text{-}76},\
  B_4&={1\text{-}2,17\text{-}20,36\text{-}41,57\text{-}60,75\text{-}76},\
  B_5&={1\text{-}2,15\text{-}17,29\text{-}32,45\text{-}48,60\text{-}62,75\text{-}76},\
  B_6&={1,12\text{-}13,24\text{-}27,37\text{-}40,50\text{-}53,64\text{-}65,76},\
  B_7&={1,10\text{-}12,22\text{-}23,32\text{-}34,43\text{-}45,
  54\text{-}55,65\text{-}67,76}.
  \end{aligned}
  ]
  (Q=\varnothing). The unique complete and minimal cover is
  [
  {1,4,5,6,7}.
  ]

The target minimal cover contains the uncovered owners (6) and (7).

### Strict boundary, cyclic, collision, and candidate controls

1. For ((1,3,4,5)), pivot (3), (M=15), owner (1):
   [
   B_1={1,2,13,14}.
   ]
   Hence (r=2) and (r=13) are bad, while
   [
   \rho_{15}(3)=3
   ]
   makes (r=3) safe against owner (1). Owner (4) is also at equality there; owner (5) has zero product and is bad there.

2. For ((1,3,13)), pivot (3), (M=12):
   [
   B_1=B_{13}={1,2,10,11},
   ]
   but the two labels remain distinct.

3. For ((1,3,4)), pivot (1), (M=4):
   [
   R={1,2,3},\qquad B_4=R,\qquad B_3=\varnothing.
   ]
   Owner (4) has zero modular product on every candidate.

4. For ((1,3,4)), pivot (3):
   [
   \rho_{12}(6)=6\ge 3,
   ]
   so the antipode is safe against owner (1). The residues (0,4,8) are excluded.

5. For ((1,2,3)), pivot (3):
   [
   Q={3,9}.
   ]
   Both are retained nonunits. For owner (1), both give equality (3=p); for owner (2), both give distance (6).

6. For ((4,5,9)), pivot (5), owner (4):
   [
   1\cdot4\equiv 6\cdot4\equiv4\pmod{20}.
   ]
   Both candidates are retained and bad.

7. For ((6,7,12,24,144)), pivot (7), the proposed cover ({6,12}) misses exactly
   [
   {2,5,9,16,19,23,26,33,37,40}.
   ]
   Its first-failure code is `EXPECTED_COVER_FAILURE`.

### Scaling law

Let (a'_i=c,a_i), (c\ge1). At pivot (j),

[
M'_j=cM_j.
]

Let

[
\pi_c:{0,\ldots,cM_j-1}\to{0,\ldots,M_j-1},
\qquad
\pi_c(r)=r\bmod M_j.
]

Because (N\mid M_j),

[
N\nmid r\iff N\nmid \pi_c(r).
]

Moreover,

[
\rho_{cM_j}(r,c a_i)
====================

c,\rho_{M_j}(\pi_c(r)a_i).
]

Consequently,

[
R'_j=\pi_c^{-1}(R_j),\qquad
B_i^j(a')=\pi_c^{-1}(B_i^j(a)),\qquad
Q'_j=\pi_c^{-1}(Q_j).
]

Every fiber has size (c). Therefore (F), complete labelled covers, minimal covers, and the (j_\star) label are unchanged; speeds are multiplied by (c). Private sets are also inverse images under (\pi_c).

### Permutation law

For a permutation (\sigma), define (a'*k=a*{\sigma(k)}). The pivot and owner sets satisfy

[
B_k^\ell(a')=B_{\sigma(k)}^{\sigma(\ell)}(a),
\qquad
Q_\ell(a')=Q_{\sigma(\ell)}(a).
]

Thus (F), (j_\star), covers, minimality, and privacy are transported by label relabelling.

For the required control:

[
(1,6,11,12,13)
\mapsto
(13,1,12,6,11)
\mapsto
(65,5,60,30,55).
]

The covered-speed sets are respectively

[
{1,6},\qquad {1,6},\qquad {5,30},
]

and the distinguished covered speeds are

[
6,\qquad6,\qquad30.
]

### Malformed controls

The deterministic first failures are:

```text
(0,1,2)
  -> NONPOSITIVE_SPEED

(1,1,2)
  -> NONINJECTIVE_SPEED

(1,3,13), pivot index 1, owners {0,1}
  -> PIVOT_OWNER_FORBIDDEN

(1,3,13), pivot speed 3, delete r=1
  -> RESIDUE_DOMAIN_MISMATCH

(1,3,13), merge owners 1 and 13
  -> OWNER_LABEL_MISMATCH

(6,7,12,24,144), pivot speed 7, owners {6,12}
  -> EXPECTED_COVER_FAILURE
```

### Abstract circuit fixture

Let (F={0,1,2,3}), with

[
C_0={1},\quad C_1={2},\quad C_2={3,4},\quad C_3={0,1}.
]

Every nonempty (S\subseteq F) has an outgoing circuit:

* if (2\in S), (C_2) contains (4\notin F);
* otherwise, if (1\in S), (C_1) contains (2\notin S);
* otherwise, if (0\in S), (C_0) contains (1\notin S);
* the remaining case is (S={3}), and (C_3\not\subseteq S).

Nevertheless, the fastest covered label (3) has the internal minimal cover ({0,1}). Thus abstract circuit escape passes and internal-cover redundancy fails. This fixture is outside the speed-tuple theorem domain.

---

## 7. **Verifier pseudocode**

```text
VALIDATE_TUPLE(a):
    if some a[i] <= 0:
        return NONPOSITIVE_SPEED
    if two labels have equal speeds:
        return NONINJECTIVE_SPEED
    return OK

R_LITERAL(n, pivot_speed p):
    N := n + 1
    M := N * p
    return [r in 0..M-1, increasing, such that r mod N != 0]

BAD_LITERAL(a, pivot j, owner i):
    reject if i == j with PIVOT_OWNER_FORBIDDEN
    p := a[j]
    M := (len(a)+1) * p
    R := R_LITERAL(len(a), p)
    return [r in R, increasing,
            such that min((r*a[i]) mod M,
                          M - ((r*a[i]) mod M)) < p]

PIVOT_DATA(a, j):
    R := R_LITERAL(...)
    for owners i != j in increasing (a[i], i):
        B[i] := BAD_LITERAL(a, j, i)
    Q := R minus union_i B[i]
    return (R, B, Q)

TUPLE_DATA(a):
    VALIDATE_TUPLE(a)
    process pivots in increasing pivot speed
    F := [j such that Q[j] is empty]
    if F is nonempty:
        j_star := unique label in F with maximum speed
    else:
        j_star := null
    return all pivot data, F, j_star

OWNER_SUBSETS(a, allowed):
    owners := sorted by increasing speed, retaining labels
    enumerate subsets by:
        cardinality first,
        then lexicographic increasing speed list

COMPLETE(data, j, C):
    return union_{i in C} B[i][j] == R[j]

ALL_COMPLETE_COVERS(data, j, allowed):
    return every C from OWNER_SUBSETS satisfying COMPLETE

INCLUSION_MINIMAL(data, j, C):
    require COMPLETE(data, j, C)
    return no proper labelled subset of C is complete

PRIVATE(data, j, C, i):
    return B[i][j] minus union_{h in C, h != i} B[h][j]

REDUNDANCY_FORM(data):
    if F is empty:
        theorem premise is false
    allowed := F minus {j_star}
    for every complete C subset allowed:
        require some i in C with COMPLETE(C minus {i})

MINIMAL_FORM(data):
    for every inclusion-minimal complete cover C at j_star:
        require some i in C with i not in F

NO_INTERNAL_FORM(data):
    require no complete C subset F minus {j_star}

CHECK_EQUIVALENCE(data):
    separately compute all three Boolean values
    require they are equal

FAILURE_RECORD(...):
    emit fields in this exact order:
        n, tuple, pivot_index, pivot_speed, N, M, residue,
        owner_indices, owner_speeds, expected, observed, failure_code
    append optional diagnostics only afterward

BOUNDED_REPLAY:
    for n increasing:
        for tuple lexicographically increasing in combinations(1..H, n):
            skip unless gcd(tuple) == 1
            compute all pivots
            check all three forms separately
            stop at first ordered failure

FIXTURES:
    process theorem-domain fixtures separately from abstract circuit fixture
    reject residue deletion, pivot ownership, owner merging,
    nonpositive input, noninjective input, and false cover declarations
```

Pseudocode alone has no execution evidence status.

---

## 8. **Optional execution**

The frozen domain was executed using response-authored deterministic source.

* Language: Python
* Interpreter: CPython 3.13.5
* Exit status: (0)
* Fixture completion: `true`
* Source/result binding: recorded in the manifest
* Completed tuple counts:
  [
  127,\ 997,\ 2919,\ 4311,\ 2996,\ 792
  ]
* Total completed tuples:
  [
  12{,}142
  ]
* Total completed pivots:
  [
  59{,}996
  ]
* Tuples with (F(a)\ne\varnothing):
  [
  3{,}149
  ]
* `first_failure=null`
* The three theorem forms were evaluated separately.
* No theorem failure occurred in the frozen bounded domain.

Attachments and exact SHA-256 hashes:

1. [Deterministic source](sandbox:/mnt/data/prompt95_literal_verifier.py)
   `2c1228c059b26b76f804bc3d55b1ca143344d1685c0c799f24707e10620082ff`

2. [Execution manifest](sandbox:/mnt/data/prompt95_manifest.json)
   `e1d4a00dec974926fcaa421e2ee10ef13871427b7a47895a74dd65e2c8c1f9ae`

3. [Machine-readable result](sandbox:/mnt/data/prompt95_result.json)
   `71c9c47d9869ee4f25ae5ab792797624cd993d330741c1098636d55b2767eb34`

Evidence label: `computed finite evidence`.

The execution is response-authored and is not an independent audit.

---

## 9. **Attack A**

Assume an inclusion-minimal internal cover (C) exists at (j_\star). Put

[
p=a_{j_\star},\qquad M=Np.
]

For every (i\in C),

[
i\in F(a),\qquad i\ne j_\star.
]

By maximality and injectivity,

[
0<a_i<p.
]

### The cover has at least two owners

The empty set cannot cover (R_{j_\star}\ne\varnothing).

If (C={i}), singleton rigidity gives

[
Np\mid a_i.
]

But

[
0<a_i<p<Np,
]

which is impossible. Therefore

[
|C|\ge2.
]

In particular, every hypothetical theorem counterexample has

[
|F(a)|\ge3.
]

### Private candidates and signed errors

Minimality gives a nonempty private set for every (i\in C). Let (r_i) be its least canonical residue.

Since (r_i\in B_i^{j_\star}),

[
\rho_M(r_i a_i)<p.
]

There is therefore an integer (e_i) satisfying

[
-(p-1)\le e_i\le p-1
]

and

[
r_i a_i\equiv e_i\pmod M.
]

This representative is unique. If (e_i,e_i') were two such representatives, then

[
M\mid e_i-e_i'
]

while

[
|e_i-e_i'|\le2p-2<Np=M
]

because (N\ge3). Hence (e_i=e_i').

Consequently there is a unique integer (q_i) with

[
r_i a_i=q_iNp+e_i.
]

All cases are retained:

* (e_i=0), corresponding to a zero modular product;
* (e_i>0), the lower cyclic side;
* (e_i<0), the upper cyclic side;
* nonunit (r_i);
* multiplication collisions;
* coincident labelled bad sets.

Moreover,

[
0\le q_i\le p-1.
]

Indeed (r_i a_i>0), and

[
r_i a_i
\le (Np-1)(p-1).
]

Since (e_i\ge-(p-1)),

[
q_iNp=r_i a_i-e_i\le Np(p-1).
]

### Exact safety against the other selected owners

For every (h\in C\setminus{i}), privacy gives

[
r_i\notin B_h^{j_\star}.
]

Therefore

[
\rho_{Np}(r_i a_h)\ge p.
]

Equality is permitted and remains safe.

There is no corresponding assertion for (h\notin C). An omitted owner may be bad at (r_i), including every point of (\operatorname{Priv}(j_\star,C,i)).

### First unsupported classification arrow

The equations

[
r_i a_i=q_iNp+e_i
]

and the inequalities

[
\rho_{Np}(r_i a_h)\ge p,\qquad h\in C\setminus{i},
]

do not relate different private residues (r_i) and (r_h) strongly enough to force an order contradiction.

Coveredness of pivot (i) supplies a cover modulo (Na_i), not modulo (Np). The first natural attempt is to reduce (r_i) modulo (Na_i), but badness at that smaller modulus does not transport to badness modulo (Np). Section 10 gives the exact failed implication.

Thus Attack A reaches the exact normal form but no unrestricted contradiction.

---

## 10. **Attack B**

For each (i\in C), let (D_i) be the first inclusion-minimal complete cover at pivot (i) under the frozen subset order. It exists because (i\in F(a)).

Define

[
E_i=(C\setminus{i})\cup(D_i\setminus{j_\star}).
]

### The only natural candidate-preserving projection

Write

[
b=a_i<p.
]

Define

[
\pi_i:R_{j_\star}\to R_i,\qquad
\pi_i(r)=r\bmod Nb.
]

This is well-defined and candidate-preserving because (Nb) is divisible by (N):

[
N\nmid r\iff N\nmid(r\bmod Nb).
]

It is surjective, since every (s\in R_i) already satisfies (0\le s<Nb<Np) and hence is also a member of (R_{j_\star}).

For (s\in R_i), the exact fiber is

[
\pi_i^{-1}(s)
=============

\left{
s+tNb:
0\le t\le
\left\lfloor\frac{Np-1-s}{Nb}\right\rfloor
\right}.
]

No residue is removed or deduplicated within these fibers.

### Exact lift formula

Suppose (s\in B_h^i). Let (f) be the unique representative with

[
-(b-1)\le f\le b-1
]

and let (k\in\mathbb Z) satisfy

[
s a_h=kNb+f.
]

For a lift

[
r=s+tNb,
]

one has the exact identity

[
r a_h
=====

(k+t a_h)Nb+f.
]

Therefore

[
r\in B_h^{j_\star}
\iff
\rho_{Np}!\left((k+t a_h)Nb+f\right)<p.
]

The condition (|f|<b) gives no implication that the right-hand side is (<p). The periods (Nb) and (Np) differ, and multiplication by (b) is not cancellable in general.

### Exact condition for (E_i) to cover

Because (C) is complete,

[
R_{j_\star}\setminus
\bigcup_{h\in C\setminus{i}}B_h^{j_\star}
=========================================

\operatorname{Priv}(j_\star,C,i).
]

Hence

[
E_i\text{ is complete}
]

is equivalent to the exact inclusion

[
\boxed{
\operatorname{Priv}(j_\star,C,i)
\subseteq
\bigcup_{h\in D_i\setminus{j_\star}}
B_h^{j_\star}.
}
\tag{PL}
]

No weaker small-modulus statement proves this inclusion.

### Literal transport failure

Use the stress tuple

[
(6,7,12,24,144)
]

at pivot (7). This is not the theorem’s (j_\star), so it is a transport control rather than a theorem counterexample.

The cover

[
C={6,12,24}
]

is inclusion-minimal at pivot (7). For (i=6), the unique minimal cover at pivot (6) is

[
D_6={144}.
]

Thus

[
E_6={12,24,144}.
]

It misses exactly

[
{1,8,13,15,20,22,27,29,34,41},
]

which is the private set of owner (6) relative to (C).

At the least private residue (r=1),

[
\pi_6(1)=1.
]

At pivot (6),

[
\rho_{36}(1\cdot144)=0<6,
]

so owner (144) covers the projected residue.

At pivot (7),

[
144\bmod42=18,\qquad \rho_{42}(144)=18\ge7.
]

Thus the same owner is safe at the lift. Even zero product at the smaller modulus does not transport.

This proves that no unconditional cross-modulus identity can establish (PL). The maximum-covered-speed hypothesis must do substantive additional work.

### The (j_\star\in D_i) problem

If (j_\star\in D_i), the owner (j_\star) may be essential at pivot (i). Since (j_\star) is prohibited from owning its own pivot, its contribution is removed in (E_i). The projection and lift formula provides no replacement for that contribution.

### Descent-key failure

Freeze

[
K(C)=
\left(
|C|,
\max_{h\in C}a_h,
\sum_{h\in C}a_h,
\text{increasing owner-speed list}
\right).
]

There is no proof that (K(E_i)<K(C)). In the literal transport control,

[
C={6,12,24},\qquad
E_6={12,24,144},
]

so the cardinality remains (3) and the maximum owner speed increases from (24) to (144).

Finding an owner outside (F(a)) in (E_i) does not make any owner of the original (C) redundant.

### First missing lemma

The exact first open edge is:

```text
PRIVATE-LIFT-COVERAGE:

For every hypothetical inclusion-minimal internal cover C at j_star,
with D_i chosen as the first inclusion-minimal cover at pivot i,
there exists i in C such that

Priv(j_star,C,i)
  subset union_(h in D_i \ {j_star}) B_h^j_star.
```

This is precisely the statement that (E_i) covers (R_{j_\star}). It is `open`. The stress calculation refutes it without the maximum-covered-pivot hypothesis.

---

## 11. **Attack C**

### MAXIMUM-PIVOT-LOWER-OWNER-SKELETON

Let (N\ge3), (p\ge1), (M=Np), and let (C) be a set of distinct positive integers (b<p). Define

[
R(N,p)={0\le r<Np:N\nmid r},
]

and

[
B_b(N,p)=
{r\in R(N,p):\rho_{Np}(rb)<p}.
]

Assume

[
R(N,p)=\bigcup_{b\in C}B_b(N,p).
\tag{1}
]

Then all of the following hold.

### 11.1 Exact bad-set cardinality

For (b\in C), put

[
d_b=\gcd(b,Np),\qquad g_b=\gcd(b,p).
]

Then

[
\boxed{
|B_b(N,p)|
==========

## d_b\left(1+2\left\lfloor\frac{p-1}{d_b}\right\rfloor\right)

g_b\left(1+2\left\lfloor\frac{p-1}{Ng_b}\right\rfloor\right).
}
\tag{2}
]

#### Proof

Multiplication by (b) on (\mathbb Z/(Np)\mathbb Z) has image equal to the multiples of (d_b), with exactly (d_b) preimages for each image point.

The strict bad output residues are

[
0,1,\ldots,p-1
]

and

[
Np-p+1,\ldots,Np-1.
]

The number of multiples of (d_b) in this set is

[
1+2\left\lfloor\frac{p-1}{d_b}\right\rfloor.
]

Thus the total number of bad preimages before candidate exclusion is

[
d_b\left(1+2\left\lfloor\frac{p-1}{d_b}\right\rfloor\right).
]

The excluded residues are (r=Nq), (0\le q<p). For these,

[
\rho_{Np}(Nqb)
==============

N\rho_p(qb).
]

The map (q\mapsto qb\bmod p) has image equal to the multiples of (g_b), each with (g_b) preimages. The strict inequality

[
N\rho_p(qb)<p
]

allows the output (0) and the pairs (\pm kg_b) satisfying

[
Nkg_b<p.
]

The number of excluded bad residues is therefore

[
g_b\left(1+2\left\lfloor\frac{p-1}{Ng_b}\right\rfloor\right).
]

Subtracting proves (2).

### 11.2 Common-overlap capacity inequality

Since (b<p),

[
\rho_{Np}(b)=b<p
]

and

[
\rho_{Np}((Np-1)b)=b<p.
]

Thus every lower-owner bad set contains both

[
1,\qquad Np-1.
]

If (k=|C|), then

[
\left|\bigcup_{b\in C}B_b(N,p)\right|
\le
\sum_{b\in C}|B_b(N,p)|-2(k-1).
]

Using (1) and (|R(N,p)|=(N-1)p),

[
\boxed{
(N-1)p
\le
\sum_{b\in C}
\left[
d_b\left(1+2\left\lfloor\frac{p-1}{d_b}\right\rfloor\right)
-----------------------------------------------------------

g_b\left(1+2\left\lfloor\frac{p-1}{Ng_b}\right\rfloor\right)
\right]
-------

2(k-1).
}
\tag{3}
]

This inequality counts coincident labelled sets separately in the sum, while the common-overlap subtraction remains valid.

### 11.3 Coarse universal cover-size bound

Because (b<p),

[
d_b\le b\le p-1.
]

Therefore

[
d_b\left(1+2\left\lfloor\frac{p-1}{d_b}\right\rfloor\right)
\le
d_b+2(p-1)\le3p-3.
]

The subtracted term in (2) is at least (1). Hence

[
|B_b(N,p)|\le3p-4.
]

Substitution into the common-overlap bound gives

[
(N-1)p\le k(3p-6)+2.
\tag{4}
]

A complete lower-owner cover has (k\ge2), so (p\ge3), and

[
\boxed{
k\ge
\left\lceil
\frac{(N-1)p-2}{3p-6}
\right\rceil.
}
\tag{5}
]

For a theorem-domain internal cover,

[
k\le \min(N-2,p-1),
]

and therefore every theorem counterexample must satisfy

[
\boxed{
(N-1)p
\le
\min(N-2,p-1)(3p-6)+2.
}
\tag{6}
]

It must also satisfy

[
\boxed{
|F(a)|
\ge
1+
\left\lceil
\frac{(N-1)p-2}{3p-6}
\right\rceil.
}
\tag{7}
]

In particular, the sole theorem holds whenever (|F(a)|\le2).

### 11.4 Exact (tp) slice

For (1\le t\le N-1), put

[
r_t^0=tp.
]

It is a candidate precisely when (N\nmid tp). For (b<p),

[
r_t^0b\equiv p(tb\bmod N)\pmod{Np}.
]

Hence

[
\rho_{Np}(r_t^0b)<p
\iff
tb\equiv0\pmod N.
]

Therefore a complete lower cover satisfies

[
\boxed{
\forall t\in{1,\ldots,N-1},
\quad
N\nmid tp
\Longrightarrow
\exists b\in C:\ N\mid tb.
}
\tag{8}
]

Taking (t=1) gives the useful corollary

[
\boxed{
N\nmid p
\Longrightarrow
\exists b\in C:\ N\mid b.
}
\tag{9}
]

Thus every theorem counterexample with (N\nmid a_{j_\star}) contains a lower covered owner whose speed is divisible by (N).

### 11.5 Exact (tp+1) slice

For (0\le t\le N-1), let

[
r_t^+=tp+1.
]

For (c=tb\bmod N), since (0<b<p),

[
r_t^+b\equiv pc+b\pmod{Np}
]

with (0<pc+b<Np). Direct comparison with the two strict bad intervals gives

[
\rho_{Np}(r_t^+b)<p
\iff
c\in{0,N-1}.
]

Therefore

[
\boxed{
N\nmid(tp+1)
\Longrightarrow
\exists b\in C:
tb\equiv0\text{ or }-1\pmod N.
}
\tag{10}
]

### 11.6 Exact (tp-1) slice

For (1\le t\le N), let

[
r_t^-=tp-1.
]

Writing (c=tb\bmod N), one obtains

[
r_t^-b\equiv pc-b\pmod{Np}.
]

If (c=0), this is represented by (Np-b); if (c\ge1), it lies between (p-b) and ((N-1)p-b). Hence

[
\rho_{Np}(r_t^-b)<p
\iff
c\in{0,1}.
]

Thus

[
\boxed{
N\nmid(tp-1)
\Longrightarrow
\exists b\in C:
tb\equiv0\text{ or }1\pmod N.
}
\tag{11}
]

Equations (2), (3), (8), (10), and (11) are simultaneous necessary conditions on every hypothetical internal cover at the maximum covered speed.

### Attempted determinant obstruction

Let (r_i) be private for owner (b=a_i), with

[
r_i b=qNp+e,\qquad |e|<p.
]

Reduce (r_i) modulo (Nb), and suppose owner (h) covers that projected residue at pivot (i). For the same lift (r_i), write

[
r_i h=kNb+f,\qquad |f|<b.
]

Eliminating (r_i) gives

[
\boxed{
N(qph-kb^2)=bf-he.
}
\tag{12}
]

This identity includes zero errors and both signs. It does not produce a height-independent contradiction because

[
|bf-he|<b^2+hp,
]

and (h) may be an arbitrarily large owner outside (F(a)). The left side need not have a fixed sign or be nonzero, and no cancellation by (b), (p), or (N) is justified.

The skeleton lemma is therefore a genuine restriction, but it does not close the cross-pivot edge.

Evidence label for the lemma: `proved-math-response`.

---

## 12. **Sole theorem**

The exact unrestricted theorem remains:

`open`

No theorem-domain counterexample was found in the frozen bounded domain, but that result has only `computed finite evidence` status.

No symbolic counterfamily was obtained.

The response proves the theorem in the following proper subcases:

1. (F(a)=\varnothing), where the premise is false.
2. (|F(a)|=1), where the internal owner set is empty.
3. (|F(a)|=2), where any internal cover would be a forbidden lower-speed singleton cover.
4. Every parameter instance failing the necessary inequalities (3) or (6).
5. Every proposed internal cover failing one of the modular slice conditions (8), (10), or (11).

These do not establish the theorem at every frozen quantifier.

The first remaining obligation is `PRIVATE-LIFT-COVERAGE` from Section 10.

---

## 13. **Complete implication chain**

Assume the sole unrestricted theorem.

### (n\ge2)

Suppose every pivot of a positive injective integer tuple were covered. Then

[
F(a)=I.
]

Let (j_\star) be the global maximum-speed label. The full owner set

[
I\setminus{j_\star}
]

completely covers (R_{j_\star}). Finite deletion produces an inclusion-minimal complete subcover (C).

Since every pivot is covered,

[
C\subseteq F(a)\setminus{j_\star}.
]

The sole theorem gives an owner (i\in C) whose deletion remains complete, contradicting inclusion-minimality.

Therefore not every pivot is covered. Hence some (j) satisfies

[
Q_j\ne\varnothing.
]

Choose (r\in Q_j), and let

[
t=\frac{r}{Na_j}.
]

Write (r=Nq+s), (1\le s\le N-1). For the pivot coordinate,

[
\left|t a_j\right|_{\mathbb R/\mathbb Z}
========================================

# \left|\frac rN\right|

\frac{\min(s,N-s)}N
\ge\frac1N.
]

For (i\ne j), because (r\notin B_i^j),

[
\rho_{Na_j}(ra_i)\ge a_j.
]

Therefore

[
\left|t a_i\right|_{\mathbb R/\mathbb Z}
========================================

\frac{\rho_{Na_j}(ra_i)}{Na_j}
\ge\frac1N.
]

The closed endpoint is retained because badness was defined using (<a_j), not (\le a_j).

This proves the positive-integer Lonely Runner statement for (n\ge2).

### (n=1)

Here (N=2). For the unique positive speed (a_0), take

[
r=1,\qquad t=\frac1{2a_0}.
]

Then

[
|t a_0|_{\mathbb R/\mathbb Z}=\frac12=\frac1N.
]

### Real reduction

Apply the accepted `proved-lean` implication from the positive-integer theorem to the real-speed theorem. Positivity, injectivity, every dimension quantifier, circle distance, and the closed threshold

[
\ge\frac1{n+1}
]

are preserved.

This chain remains `conditional` because the sole redundancy theorem is `open`.

---

## 14. **Proof-obligation ledger**

| Exact claim                            | Hypotheses                                        | Dependency                                       | Evidence label                                            | Falsifier or first open edge                                                              | Downstream audit                          |
| -------------------------------------- | ------------------------------------------------- | ------------------------------------------------ | --------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------- |
| Frozen (R,B,Q,F,j_\star) definitions   | Positive injective tuple                          | Prompt contract                                  | `input-accepted`                                          | Literal mismatch on a mandatory fixture                                                   | Specification audit                       |
| Three target forms are equivalent      | (F\ne\varnothing), finite labelled covers         | Nonempty (R_{j_\star}), finite deletion          | `proved-math-response`                                    | An internal complete cover with no minimal internal subcover, or an empty complete cover  | Independent proof review                  |
| Scaling law                            | Common positive integer scale                     | Exact projection (r\bmod M)                      | `proved-math-response`                                    | Failure of (B'=\pi^{-1}(B))                                                               | Independent proof or replay               |
| Permutation law                        | Label permutation                                 | Literal relabelling                              | `proved-math-response`                                    | Speed-labelled (F), covers, or (j_\star) change                                           | Independent proof or replay               |
| Private normal form                    | Minimal internal cover                            | Strict badness, (N\ge3)                          | `proved-math-response`                                    | Two signed errors in ([-(p-1),p-1]) representing one residue                              | Independent proof review                  |
| Exact bad-set size formula (2)         | (N\ge3), (b<p)                                    | Multiplication fibers and excluded (N)-multiples | `proved-math-response`                                    | One literal (N,p,b) with a different cardinality                                          | Independent proof and finite spot checks  |
| Capacity inequality (3)                | Complete lower-owner cover                        | Formula (2), common residues (1,Np-1)            | `proved-math-response`                                    | Complete cover violating the inequality                                                   | Independent proof review                  |
| Modular slices (8), (10), (11)         | Complete lower-owner cover                        | Exact evaluation at (tp,tp\pm1)                  | `proved-math-response`                                    | Complete cover missing the required congruence owner                                      | Independent proof review                  |
| Maximum-pivot lower-owner skeleton     | Hypothetical internal cover at (j_\star)          | Maximality gives every owner (b<p)               | `proved-math-response`                                    | Internal cover violating any skeleton clause                                              | Independent audit                         |
| Candidate-preserving projection        | (b<p)                                             | Reduction modulo (Nb)                            | `proved-math-response`                                    | Candidate whose reduction is excluded, or wrong fiber                                     | Independent proof review                  |
| Universal badness transport            | Small-pivot badness                               | None sufficient                                  | `refuted-exact` at generic cross-pivot scope              | Stress calculation (6\to7) with owner (144)                                               | No promotion to theorem-domain refutation |
| `PRIVATE-LIFT-COVERAGE`                | Minimal internal cover at maximum covered pivot   | Must use maximality beyond projection            | `open`                                                    | A theorem-domain internal cover for which every deterministic (D_i) misses a private lift | New proof or exact counterexample         |
| Sole redundancy theorem                | All (n\ge2), unrestricted height                  | First open edge plus later descent               | `open`                                                    | Exact theorem-domain internal irredundant cover                                           | Independent proof or reproduction         |
| Frozen bounded replay                  | Primitive increasing tuples in six frozen domains | Response-authored source                         | `computed finite evidence`                                | Hash-bound rerun finding a mismatch                                                       | Independent rerun                         |
| Positive-integer LRC from sole theorem | Sole theorem                                      | Minimal deletion and pivot safety                | `conditional`                                             | Failure of displayed implication                                                          | Kernel and proof audit                    |
| Real LRC from integer LRC              | Accepted equivalence                              | Lean theorem                                     | `proved-lean` for equivalence, `conditional` for use here | Kernel-check failure                                                                      | Existing Lean audit plus theorem proof    |

---

## 15. **Final evidence boundary**

The following are new response-authored mathematical results and remain `proved-math-response` pending independent review:

* the three-form equivalence proof;
* the exact scaling and permutation laws;
* the private-point signed-error normal form;
* the exact projection and lift formulas;
* the exact bad-set cardinality formula;
* the common-overlap capacity inequality;
* the (tp), (tp+1), and (tp-1) modular skeleton;
* the resulting cover-size and (|F(a)|) lower bounds.

The hash-bound bounded replay is `computed finite evidence` only. It covers exactly 12,142 primitive strictly increasing tuples and 59,996 pivots. It is response-authored and is not an independent reproduction.

The cross-pivot implication from small-modulus badness to large-modulus badness is `refuted-exact` only at the generic transport level. The stress example is not a theorem-domain counterexample because pivot (7) is not the fastest covered pivot.

The sole unrestricted redundancy theorem remains `open`.

The positive-integer and real Lonely Runner conclusions remain `conditional`.

Prompt90’s prior operational response remains `rejected operational output`.

No unrestricted LRC claim, theorem proof, counterexample, or project-level evidence promotion is made.
