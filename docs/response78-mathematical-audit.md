# Prompt78 independent mathematical audit

Task: `OPS-P78-MATH-AUDIT-209`

Base commit: `4252f1f3b6284a79a1f07204405e2916260e4af0`

Audited response: `research/sol-pro/responses/response78.md`

Immutable response SHA-256:
`96e3bc5d0c05fb2b04e8e2d9117a55bf86b1d96d608e92422553bf54ab0a2390`

## Recommended PI disposition

**Accept `(6,7,12,24,144)` as a manuscript-level counterexample to
`SPARSE-MINIMAL-COVER-OWNER-ESCAPE`; reject that bridge and its canonical-cover
weakening; do not change the status of unrestricted LRC.**

For `n=5`, `N=6`, take

\[
a=(6,7,12,24,144).
\]

At pivot speed `7`, the owner set `C={6,12,24}` is the canonical
inclusion-minimal complete cover and has the maximum permitted sparse size

\[
|C|=3=\lfloor5/2\rfloor+1.
\]

Nevertheless `Q_6`, `Q_12`, and `Q_24` are all empty, so no owner in `C`
satisfies the frozen escape conclusion.

This is not a Lonely Runner counterexample. At pivot speed `144`, numerator
`r=25` is an exact canonical pivot certificate. No repository evidence label
is promoted by this audit; Sol High retains promotion authority.

## Frozen definitions reconstructed

For pivot index `j` and pivot speed `p=a_j`, put

\[
M=6p,\qquad
R_j=\{0\le r<M:6\nmid r\},
\]

and, for every nonpivot owner `i`,

\[
B_i^j=\{r\in R_j:\rho_M(ra_i)<p\},\qquad
\rho_M(x)=\min(x\bmod M,M-(x\bmod M)).
\]

Badness is strict. Equality at cyclic distance `p` is safe. Define

\[
Q_j=R_j\setminus\bigcup_{i\ne j}B_i^j,qquad G_j=|Q_j|.
\]

A cover is complete when its labelled owner sets union to `R_j`. It is
inclusion-minimal when deleting any owner destroys completeness. The private
set of owner `i` relative to `C` is

\[
\operatorname{Priv}(j,C,i)
=B_i^j\setminus\bigcup_{h\in C,\ h\ne i}B_h^j.
\]

The canonical complete cover minimizes first cardinality and then the
increasing list of owner speed values. These are exactly the frozen Prompt78
definitions; no owner labels, coincident sets, nonunits, excluded multiples of
six, or strict endpoints were removed.

The tuple is positive and injective. It is primitive in the required common-
gcd sense because `gcd(6,7)=1`, hence the gcd of all five speeds is one.

## Pivot 7: exact cover classification

The modulus is `42`, and every residue class modulo seven contains exactly
five candidates after the unique multiple of six is removed. Dividing each
owner speed and the modulus by their common factor six gives the following
exact bad-class descriptions:

\[
\begin{array}{c|c}
\text{owner speed}&r\bmod7\text{ for }r\in B_i^7\\ \hline
6&\{0,1,6\}\\
12&\{0,3,4\}\\
24&\{0,2,5\}\\
144&\{0,2,5\}.
\end{array}
\]

For example, owner `12` is bad exactly when
`rho_42(12r)<7`; after division by six this says
`2r mod 7` is `0`, `1`, or `-1`, giving classes `0`, `4`, and `3`.
The other rows follow identically. This derivation retains the strict
inequality: the next possible nonzero cyclic distance is `6`, while distance
`12` is already safe.

The three class pairs `plus/minus 1`, `plus/minus 3`, and `plus/minus 2` are
disjoint. Therefore a complete cover must contain speed `6`, speed `12`, and
one of the two coincident labelled owners `24` or `144`. The complete covers
are exactly

\[
\{6,12,24\},\qquad
\{6,12,144\},\qquad
\{6,12,24,144\}.
\]

The first two, and only those two, are inclusion-minimal. Both have minimum
cardinality three; lexicographic comparison of their increasing speed lists
chooses

\[
C=\{6,12,24\}
\]

as the unique canonical cover.

The owner-labelled private sets relative to this cover are exactly

\[
\begin{aligned}
\operatorname{Priv}(7,C,6)
 &=\{1,8,13,15,20,22,27,29,34,41\},\\
\operatorname{Priv}(7,C,12)
 &=\{3,4,10,11,17,25,31,32,38,39\},\\
\operatorname{Priv}(7,C,24)
 &=\{2,5,9,16,19,23,26,33,37,40\}.
\end{aligned}
\]

Each set has ten elements, so deleting its labelled owner leaves those
candidates uncovered. This independently proves inclusion-minimality rather
than assuming it from the response.

## The singleton blocker and failed conclusion

Speed `144` is outside the selected owner set. At the three selected owner
pivots, their full moduli divide it:

\[
6\cdot6=36\mid144,\qquad
6\cdot12=72\mid144,\qquad
6\cdot24=144\mid144.
\]

Hence for every integer `r`, at each selected owner pivot `i`,

\[
\rho_{6a_i}(144r)=0<a_i.
\]

Thus `B_144^i=R_i`, and consequently

\[
Q_6=Q_{12}=Q_{24}=\varnothing.
\]

The frozen theorem requires, for every qualifying minimal cover, an owner in
that cover with nonempty `Q`. Here the canonical cover qualifies with
`2<=|C|<=3`, yet all three owner `Q` sets are empty. This is a direct
counterexample to both the unrestricted sparse theorem and its restriction to
canonical covers.

## Exact good-count vector

The blocker argument gives `G_6=G_12=G_24=0`; completeness of `C` gives
`G_7=0`.

At pivot `144`, the modulus is `864` and `|R_144|=720`. Directly reducing the
four strict badness tests gives

\[
\begin{aligned}
B_6^{144}&:\ \rho_{144}(r)<24,\\
B_{12}^{144}&:\ \rho_{72}(r)<12,\\
B_{24}^{144}&:\ \rho_{36}(r)<6,\\
B_7^{144}&:\ \rho_{864}(7r)<144,
\end{aligned}
\qquad 6\nmid r.
\]

Enumerating the five allowed residue classes `r mod 6` through these exact
integer intervals gives the complete intersection table:

| Owner subset | Intersection size |
| --- | ---: |
| each singleton `{6}`, `{7}`, `{12}`, `{24}` | 240 |
| `{6,7}` | 80 |
| `{6,12}` | 120 |
| `{6,24}` | 60 |
| `{7,12}` | 80 |
| `{7,24}` | 80 |
| `{12,24}` | 120 |
| `{6,7,12}` | 40 |
| `{6,7,24}` | 20 |
| `{6,12,24}` | 60 |
| `{7,12,24}` | 40 |
| `{6,7,12,24}` | 20 |

Inclusion-exclusion therefore gives

\[
\left|B_6^{144}\cup B_7^{144}\cup B_{12}^{144}\cup B_{24}^{144}\right|
=960-540+160-20=560.
\]

Consequently

\[
G_{144}=720-560=160,
\qquad
G=(0,0,0,0,160).
\]

All counts use finite integer intervals and the strict `<144` boundary; no
floating-point calculation or recovered output is involved.

## Exact pivot certificate and LRC boundary

At pivot speed `144`, choose `r=25`. It lies in the candidate set because
`25<864` and `6` does not divide `25`. The exact cyclic distances modulo `864`
for the five speeds are

\[
\bigl(
\rho_{864}(25\cdot6),
\rho_{864}(25\cdot7),
\rho_{864}(25\cdot12),
\rho_{864}(25\cdot24),
\rho_{864}(25\cdot144)
\bigr)
=(150,175,300,264,144).
\]

Every distance is at least the pivot threshold `144`; the pivot coordinate is
exactly on the safe boundary. Therefore `(pivot=144,r=25)` is a canonical
pivot certificate. At time

\[
t=\frac{25}{864},
\]

all five circle distances are at least `1/6`. The tuple satisfies LRC and is
not a counterexample to the pivot-certificate proposition, positive-integer
LRC, or unrestricted real LRC.

The exact logical scope is:

- `SPARSE-MINIMAL-COVER-OWNER-ESCAPE` is false;
- its canonical-cover restriction is false;
- the counterexample is not a simultaneous-full-cover tuple because
  `G_144=160`, so it does not refute `DENSE-CANONICAL-CORE`;
- the existing conditional bridge from a valid arithmetic premise remains
  logically valid, but this proposed premise cannot supply it; and
- the exact unrestricted pivot selector and LRC remain open.

## Surviving narrower unrestricted lemmas

Three elementary statements survive independently of the rejected escape
claim.

First, for any finite labelled owner family, a complete cover is
inclusion-minimal exactly when every owner-labelled private set is nonempty.
Deleting owner `i` fails precisely when a point remains that belongs to its
bad set and to no other selected owner's bad set.

Second, at a covered pivot the finite nonempty family of complete covers has a
unique least element under the frozen `(cardinality, speed-list)` order when
speeds are injective. A least-cardinality complete cover is inclusion-minimal,
since a redundant owner could be deleted to produce a smaller one.

Third, the counterexample exposes the following reusable unrestricted
arithmetic obstruction:

```text
DIVISIBLE-SINGLETON-BLOCKER:
If N*p divides c and c is a nonpivot speed, then B_c^p=R_p and Q_p is empty.
```

Indeed `c*r` is zero modulo `N*p` for every candidate `r`, so its cyclic
distance is zero and is strictly below positive `p`. More generally, if one
omitted speed `c` satisfies `N*a_i | c` for every owner `i` in a proposed
escape cover, then none of those owners can be the required escaping pivot.

This blocker lemma is recommendable as `proved-math`, but it is an obstruction,
not a positive LRC bridge. Excluding a common divisible blocker is a necessary
repair to this route, not a proved sufficient condition. No narrower positive
owner-escape theorem is established by the response or this audit.

## Independent clean-room check

The audit used a fresh ignored Python 3.14.4 integer-only script implementing
the frozen definitions directly. It did not compile, execute, import, or copy
the recovered C++ source and did not load or compare against the recovered
JSON. It exhaustively reconstructed every pivot set for this one tuple,
classified all covers at pivot `7`, checked the three private sets, verified
the blocker equalities, reproduced the full inclusion-exclusion table, and
checked the `r=25` certificate.

Command:

```text
python3 tmp/p78_math_audit_209.py
```

Ignored verifier SHA-256 during review:
`30771fd3db6d93fab2a52a6c250aa48855dc26c8e436d05835d0b641c82365ec`

Output:

```text
G=(0,0,0,0,160)
minimal covers at pivot 7: (6,12,24), (6,12,144)
canonical cover: (6,12,24); private-set sizes=(10,10,10)
pivot-144 certificate: r=25; distances=(150,175,300,264,144)
all exact integer assertions passed
```

A separate read-only adversarial spot-check independently reconstructed the
bad-class types, complete and minimal covers, private sets, all 15 pivot-144
intersection counts, blocker relations, and the `r=25` distances. It returned
`PASS` with no boundary, multiplicity, canonical-order, or logical-scope
objection.

This ignored checker is operational review material, not a tracked
certificate or promoted finite-evidence artifact. Prompt78's separate bounded
scan was not replayed, audited, or promoted. No recovered binary or recovered
program was run.

## Evidence table and remaining gaps

| Claim | Recommended disposition |
| --- | --- |
| Tuple primitivity and exact pivot-7 cover classification | `proved-math` |
| Canonical/minimal cover and three private sets | `proved-math` |
| `Q_6=Q_12=Q_24=empty` and blocker divisibilities | `proved-math` |
| `G=(0,0,0,0,160)` | `proved-math` |
| Pivot-144 certificate `r=25` | `proved-math` |
| `SPARSE-MINIMAL-COVER-OWNER-ESCAPE` | `rejected` |
| Canonical-cover weakening | `rejected` |
| Divisible singleton blocker lemma | `proved-math` |
| Response-authored bounded scan | unverified; no promotion |
| `DENSE-CANONICAL-CORE` | `open`; not refuted by this tuple |
| New Lean theorem | none |
| Exact unrestricted pivot selector and LRC | `open`; no status change |

The response's broader permutation, scaling, singleton-cardinality, fixture,
and all-but-one-family claims were outside this audit and receive no promotion
here. The remaining route gap is a genuinely stronger hypothesis that excludes
common blockers and still forces an owner escape; this audit proves no such
hypothesis sufficient.

The audit diff is documentation-only. It must pass `git diff --check`, the
targeted credential/private-path scan, and the repository task-ledger
validator before integration. The immutable Prompt78 response and its known
formula-separator conflict-marker false positive are not modified by this
branch.
