# Weighted supply beyond one outlier: a grid bound and an exact obstruction

Status: bounded research audit, 2026-09-05. Only this note changes. The results
are manuscript arguments and exact standard-library computations; no new Lean
declaration is claimed. The canonical Lonely Runner Conjecture remains unresolved.

The answer is mixed: varying the constant correction rescues the proposed
two-outlier example, and a uniform counting theorem handles sufficiently many
speeds divisible by the field prime. However, the **complete** prime-square grid
already fails for a primitive six-speed tuple without any speed divisible by 49.

## 1. Frozen sources and the exact grid

| Source | SHA-256 |
| --- | --- |
| `research/astra-exact-band-route.md` | `0e2d264986a98b69d93cbfd28ffd81f759df6031869b96a3219249e77b504554` |
| `LonelyRunner/WeightedAffineAvoidance.lean` | `59c8421001abfa0b7776783ea0af3bae562eb3a5a3270c07d6971cf07a20b195` |
| `LonelyRunner/AffineOneOutlierFamily.lean` | `f4340eda138464cb2383af4582d1bbb64237cb31153f5296504023feaf994ec8` |
| `research/astra-pass9-review.md` | `d489613c466422a94e1a1d95360bbba6854fc073765267b5fc47dd4496ba125a` |

The compiled weighted lemma has separate bounds on forbidden directions and
nonzero forbidden weights. Its author-oriented version uses directions
\(a_i+zv_i=0\), as in the frozen manuscript. Nothing below assumes that arbitrary
tuples satisfy either bound.

Let \(p\) be an odd prime. If \(M\) is a sufficiently large multiple of \(p^2\),
then for each \(j\in\{1,\ldots,p-1\}\) one can prescribe

\[
 R(r_0)=\frac{Mr_0}{p}+\frac{jM}{p^2},\qquad \beta=\frac{jM}{p}.
\]

These are integral and satisfy \(pR=Mr_0+\beta\). The resulting grid time is

\[
 t=\frac{s+r_0}{p}+\frac{j}{p^2}
   \equiv\frac{k}{p}+\frac{j}{p^2}\pmod1,
 \quad k\in\{0,\ldots,p-1\}.                                \tag{1.1}
\]

Varying \(M\) in this construction does not refine the original time grid.
Varying \(j\) supplies every numerator not divisible by \(p\) modulo \(p^2\).
If a coordinate is divisible by \(p\) but not by \(p^2\), it rules out all
numerators divisible by \(p\), and is good at every other numerator.

The closed threshold is always \(1/p\). At \(t=n/p^2\), speed \(v\) is bad
exactly when

\[
 d_{p^2}(vn):=\min(vn\bmod p^2,\,-vn\bmod p^2)<p.            \tag{1.2}
\]

In particular a distance equal to \(p\) in (1.2) is good.

## 2. Two outliers can exhaust one correction

For \(p=7\), take

\[
 V=(2,3,12,8,7,14).
\]

At the fixed correction \(j=1\), the core speeds 2 and 3 leave only
\(k\in K=\{1,4,5,6\}\). Speed 12 blocks \(1,4\), while speed 8 blocks
\(5,6\). The following complete table gives one failing row at every \(k\):

| \(k\) | \(n=7k+1\) | Failing speed | \(d_{49}(vn)\) |
| --- | --- | --- | --- |
| 0 | 1 | 2 | 2 |
| 1 | 8 | 12 | 2 |
| 2 | 15 | 3 | 4 |
| 3 | 22 | 2 | 5 |
| 4 | 29 | 12 | 5 |
| 5 | 36 | 8 | 6 |
| 6 | 43 | 8 | 1 |

Every entry is strictly less than 7. Thus adding a second arbitrary outlier
cannot keep the one-outlier proof at the same fixed correction without a new
overlap argument. There are four core-good nonzero multipliers and two rows
that each can exclude two of them; the count can be attained exactly.

Nevertheless the full 49-grid has the good numerators

\[
 5,9,10,11,38,39,40,44.
\]

For example \(5/49\) is good. Thus this tuple refutes the fixed strip only,
and does not refute supply after varying \(j\). Its numerator 5 has \(k=0\),
which must not be excluded from the enlarged grid search.

## 3. A uniform supply theorem from the number of unit rows

**Proposition.** Let \(p\) be an odd prime, and let \(V_i\) be any finite list
of positive integer speeds, none divisible by \(p^2\). Let \(m\) be the number
of indices with \(p\nmid V_i\), counted with multiplicity. For every fixed
\(j\in\{1,\ldots,p-1\}\), at least \(p-2m\) values of
\(k\in\{0,\ldots,p-1\}\) are good for all coordinates at (1.1).
When \(p-2m\le0\), the assertion is interpreted as a vacuous integer lower bound.

Consequently, if \(m\le(p-1)/2\), every nonzero strip \(j\) supplies a witness.
There are at least \((p-1)(p-2m)\) good numerators modulo \(p^2\) when this
bound is positive. For a list of exactly \(p-1\) speeds, the sufficient input
is that at least \((p-1)/2\) coordinates are divisible by \(p\), and none by
\(p^2\). No speed height, distinctness, or common-gcd assumption is required.

**Proof.** If \(V_i=pq\), then \(p\nmid q\), and

\[
 V_i t=qk+\frac{qj}{p}.
\]

Since \(qj\ne0\pmod p\), its distance is at least \(1/p\), independently of
\(k\). Such a row imposes no restriction in this strip.

If \(p\nmid V_i\), write

\[
 V_i j=pq_i+e_i,\qquad 1\le e_i\le p-1.
\]

Its phase is

\[
 V_i t=\frac{V_i k+q_i}{p}+\frac{e_i}{p^2}.
\]

The exact cyclic-band rule says that the two bad residues are
\(V_i k+q_i=0,-1\pmod p\). Multiplication by \(V_i\) permutes the field,
so exactly two of the \(p\) values of \(k\) are bad. The union of the bad
sets has size at most \(2m\). Different strips have different numerators
modulo \(p^2\), giving the asserted total count. \(\square\)

This is a proved input-to-witness mechanism, rather than an assumed good pair.
It counts all \(p\) choices of \(k\), including zero, and does not adjoin a
common forbidden zero to each row. Therefore it is not merely the weighted
lemma with an unverified weight premise. The weighted formulation can lose a
choice by forcing nonzero homogeneous phases even when a correction already
makes phase zero good.

For completeness, when no speed is divisible by \(p\), the simpler time
\(1/p\) works immediately, without the bound on \(m\). Neither observation
settles the intermediate range with a small positive number of divisible rows.

## 4. The complete prime-square grid is not universal

**Exact counterexample to grid supply.** Take

\[
 p=7,\qquad V_*=(1,3,4,5,18,7).                               \tag{4.1}
\]

These are six positive distinct speeds with gcd one. None is divisible by 49.
There is nevertheless **no** integer \(n\) such that all their distances at
\(n/49\) are at least \(1/7\).

**Proof.** Periodicity reduces to \(0\le n<49\). Reflection
\(n\mapsto49-n\) preserves every distance, so it suffices to check 0 through
24. At zero every row fails. The following disjoint partition covers 1 through
24; the distance list is in the same order as the numerator list.

| Failing speed | Numerators | Distances modulo 49 |
| --- | --- | --- |
| 1 | 1,2,3,4,5,6 | 1,2,3,4,5,6 |
| 7 | 7,14,21 | 0,0,0 |
| 18 | 8,22 | 3,4 |
| 5 | 9,10,19,20 | 4,1,3,2 |
| 4 | 11,12,13,23,24 | 5,1,3,6,2 |
| 3 | 15,16,17,18 | 4,1,2,5 |

All displayed distances are strictly less than 7. This proves failure for
every integer numerator, not a miss through a modulus cutoff. \(\square\)

This is plainly not an LRC counterexample. At \(t=5/11\), the coordinate
distances in the original order are

\[
 (5,4,2,3,2,2)/11,
\]

whose minimum \(2/11\) is strictly greater than \(1/7\). The finer grid also
has the explicit strict witness \(156/343\), with minimum \(62/343\).
This is one positive control for that finer grid, not a universal 343-grid claim.

There is also an unbounded-height family of exactly the same obstruction. For
arbitrary nonnegative integers \(z_1,\ldots,z_5\), take

\[
 (1,\ 3+539z_1,\ 4+539z_2,\ 5+539z_3,\ 18+539z_4,\ 7+539z_5).  \tag{4.2}
\]

The six residues modulo 49 remain distinct, so the speeds are distinct; the
first speed makes their gcd one. They retain the partition above because
\(539=49\cdot11\). None becomes divisible by 49. They also retain the exact
strict witness \(5/11\), since each added phase is an integer. Thus the
counterexample is not a finite-height phenomenon.

## 5. What is obstructed, and what remains available

Every exact correction \(\beta/M=j/p\), with integral \(j\), produces a time
on the \(p^2\) grid by (1.1), regardless of the size of the external modulus.
The counterexample therefore defeats every such correction, not just \(j=1\).
It also defeats any correct common-multiplier and independent-sign transport
that leaves the original time on that grid. Indeed, multiplication of an
integer numerator by any integer \(b\) still gives a \(p^2\)-grid time, and
individual signs preserve circle distance. Under the frozen bridge's precise
condition \(W_i\equiv\epsilon_i bV_i\pmod{pM}\), the original time is \(bt\),
so no admissible positive representative or such lift can change this conclusion.

This is **not** an obstruction to arbitrary moduli and arbitrary correction
envelopes in the weighted bridge. Corrections other than integral multiples
of \(M/p\) can produce times off this grid. The strict witness \(5/11\) is
concrete evidence that a witness may require doing so at this scale.

For the identity normalization of (4.1), with speed 7 handled as an automatic
row, the five ordinary rows have nonzero slopes and a single forbidden ratio
\(-1\). Thus the direction bound is favorable. At constant corrections
\(\beta/M=j/7\), the total weights of the exact bad pairs after adjoining zero
are, for \(j=1,\ldots,6\),

\[
 6,8,8,9,9,9.
\]

Every one exceeds the allowed \(p-2=5\). The complete grid obstruction proves
that dropping the required weight bound cannot solve this example. Conversely,
an excessive weight alone would not have proved that the grid has no witness;
the reflected partition supplies that separate proof.

For general rounding functions, whole envelopes still have to contain bad
residues for **all** prescribed \(r_0\). Controlling one attractive correction
does not control their union. Uniform supply still needs an independent reason
for the available automatic rows, for the nonexhausted direction set, and for
enough overlap among these whole envelopes. The proposition in Section 3
supplies a genuine special input; no arbitrary-tuple version is established.

## 6. A precise unresolved covering question

One possible next target can be stated without referring to an already chosen
real witness. For an odd prime \(p\), put

\[
 G_p=(\mathbb Z/p^2\mathbb Z)^*,\qquad
 S_p(a)=\{n\in G_p:d_{p^2}(an)<p\}\quad(a\in G_p),
\]

and let \(\tau_p\) be the smallest number of sets \(S_p(a)\) whose union is
\(G_p\). This minimum exists, since choosing \(a=n^{-1}\) covers each unit
numerator \(n\). Each set has size \(2(p-1)\), whereas \(|G_p|=p(p-1)\).
Consequently \(\tau_p\ge\lceil p/2\rceil\), which recovers the counting
threshold above.

The concrete, falsifiable further question is

\[
 \text{Is }\tau_p\ge p-2\text{ for every odd prime }p\ge5?     \tag{6.1}
\]

This is **unproved here**, not a premise of any proved result in this note.
If true, it would guarantee a \(p^2\)-grid witness for every \(p-1\)-tuple
with at least two speeds divisible by \(p\), none divisible by \(p^2\), and
arbitrary remaining speeds. Those divisible rows rule out nonunit numerators
but impose no further condition on unit numerators; at most \(p-3\) other rows
could not cover the unit group. This implication is exact and retains all rows.

At \(p=7\), the five unit rows of (4.1) give \(\tau_7\le5\). An exhaustive
exact check of all \(\binom{21}{4}=5985\) four-element signed unit classes gives
no cover, hence computationally \(\tau_7=5\). Checking four-element subsets also
rules out smaller covers, since any smaller one could be extended to four.
This is a finite group computation with a reproducer below, not a Lean theorem
and not evidence sufficient to assume (6.1) at other primes.

Merely replacing the 49-grid by increasingly fine grids is not a new supply
theorem: a strict witness makes sufficiently fine grids work by continuity,
but presupposing that strict witness would remove the sought a priori content.
No claim about a uniform higher prime-power grid is made in this pass.

## 7. Exact reproduction and bounded negative controls

The standard-library block below verifies the full 49-grid counterexample,
its reflected partition, strict witnesses, and the fixed-strip example. It
also checks 1,622 instances of the proved strip-count bound. Separate controls
check all 120 normalized three-unit choices at \(p=5\), all 5,985 four-unit
choices at \(p=7\), and 171/1,176 two-outlier choices at \(p=7,11\). The last
controls give no counterexample in those exact finite domains and are not
generalized to other primes or to arbitrary moduli.

Signed unit representatives are \(1\le a\le(p^2-1)/2\) with \(p\nmid a\).
They represent every unit modulo \(p^2\) up to sign, which is sufficient for
these distance sets. Repeated classes cannot help to cover additional points.
In the covering checks, `bad_mask(p, p)` masks exactly the nonunit numerators;
the remaining coverage comparison is precisely the unit-group covering problem.

```python
from fractions import Fraction as F
from itertools import combinations
from math import gcd

def distance(modulus, x):
    return min(x % modulus, (-x) % modulus)

def norm(x):
    return min(x % 1, (-x) % 1)

def bad_mask(p, v):
    return sum(1 << n for n in range(p*p) if distance(p*p, v*n) < p)

def good_grid(p, V):
    return [n for n in range(p*p)
            if all(distance(p*p, v*n) >= p for v in V)]

V = (2, 3, 12, 8, 7, 14)
blockers = (2, 12, 3, 2, 12, 8, 8)
assert all(distance(49, v*(7*k+1)) < 7 for k, v in enumerate(blockers))
assert good_grid(7, V) == [5, 9, 10, 11, 38, 39, 40, 44]

V = (1, 3, 4, 5, 18, 7)
assert len(set(V)) == 6 and gcd(*V) == 1 and all(v % 49 for v in V)
assert good_grid(7, V) == []
partition = ((1, (1,2,3,4,5,6)), (7, (7,14,21)), (18, (8,22)),
             (5, (9,10,19,20)), (4, (11,12,13,23,24)), (3, (15,16,17,18)))
assert sorted(n for _, ns in partition for n in ns) == list(range(1, 25))
assert all(distance(49, v*n) < 7 for v, ns in partition for n in ns)
assert min(norm(v*F(5, 11)) for v in V) == F(2, 11) > F(1, 7)
assert min(norm(v*F(156, 343)) for v in V) == F(62, 343) > F(1, 7)
for z in (0, 1, 10):
    lifted = (1,) + tuple(v+539*z*(i+1) for i, v in enumerate(V[1:]))
    assert good_grid(7, lifted) == []
    assert min(norm(v*F(5, 11)) for v in lifted) == F(2, 11)
weights = [sum(len({0, (-((v*j)//7)) % 7, (-((v*j)//7)-1) % 7})-1
               for v in V if v % 7) for j in range(1, 7)]
assert weights == [6, 8, 8, 9, 9, 9]

strip_fixtures = 0
for p in (3, 5, 7):
    units = [a for a in range(1, p*p//2+1) if a % p]
    for m in range((p-1)//2+1):
        for unit_rows in combinations(units, m):
            rows = unit_rows + tuple(p*q for q in range(1, p-m))
            assert len(rows) == p-1
            for j in range(1, p):
                good = sum(all(distance(p*p, v*(p*k+j)) >= p for v in rows)
                           for k in range(p))
                assert good >= p-2*m
            strip_fixtures += 1
assert strip_fixtures == 1622

cover_controls = {}
for p, count_units in ((5, 3), (7, 4)):
    units = [a for a in range(1, p*p//2+1) if a % p]
    masks = {a: bad_mask(p, a) for a in units}
    target = (1 << (p*p))-1
    checked = 0
    for rows in combinations(units, count_units):
        cover = bad_mask(p, p)
        for v in rows:
            cover |= masks[v]
        assert cover != target
        checked += 1
    cover_controls[p] = checked
assert cover_controls == {5: 120, 7: 5985}

two_outliers = {}
for p in (7, 11):
    core = tuple(range(2, p-3))
    units = [a for a in range(1, p*p//2+1) if a % p and a not in core]
    base = bad_mask(p, p) | bad_mask(p, 2*p)
    for a in core:
        base |= bad_mask(p, a)
    masks = {a: bad_mask(p, a) for a in units}
    target = (1 << (p*p))-1
    checked = 0
    for v, w in combinations(units, 2):
        assert base | masks[v] | masks[w] != target
        checked += 1
    two_outliers[p] = checked
assert two_outliers == {7: 171, 11: 1176}
print({'strip_fixtures': strip_fixtures, 'cover_controls': cover_controls,
       'two_outliers': two_outliers, 'counterexample_and_witnesses': 'passed'})
```

Execute this exact block from the repository root with:

```sh
python3 - <<'PY'
from pathlib import Path
text = Path('research/astra-weighted-supply-audit.md').read_text()
source = text.split('```python\n', 1)[1].split('\n```', 1)[0]
exec(compile(source, 'astra-weighted-supply-audit.md:reproducer', 'exec'))
PY
```

Executed on 2026-09-05 with exit status 0 and exact output:

```text
{'strip_fixtures': 1622, 'cover_controls': {5: 120, 7: 5985}, 'two_outliers': {7: 171, 11: 1176}, 'counterexample_and_witnesses': 'passed'}
```

`python3 scripts/validate_workflow.py` passed structural validation. No source,
shared state, cache, or Git edits and no Lean builds were performed in this pass.

The intended result is a failed universal prime-square-grid assertion, a
proved positive row-count mechanism, and a precise unproved covering question.
Neither arbitrary weighted-envelope supply nor canonical LRC is resolved.
