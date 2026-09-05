# Constant corrections, proportional rows, and the supply boundary

Status: bounded research audit, 2026-09-05. Only this note changes. The proposed
identity obstruction is false. Exact integral corrections provide certificates;
grouping proportional rows then gives a strict improvement on an open interval.
However, the unrestricted grouped constant-correction existence predicate is
equivalent to the original closed-witness predicate for each fixed tuple. That
equivalence is a barrier to claiming new global supply from the formulation alone.

Frozen sources used:

| Source | SHA-256 |
| --- | --- |
| `LonelyRunner/WeightedAffineAvoidance.lean` | `59c8421001abfa0b7776783ea0af3bae562eb3a5a3270c07d6971cf07a20b195` |
| `LonelyRunner/AffineGridCyclic.lean` | `b4b42a0dd0f00730c2fbd45814a362a7e30248c97c234fd4d7ed72c7bf521e4b` |
| `research/astra-exact-band-route.md` | `0e2d264986a98b69d93cbfd28ffd81f759df6031869b96a3219249e77b504554` |

The previously proposed bound \(\tau_p\ge p-2\) is not assumed. The supplied
\(p=13\) control with unit rows
\((1,7,8,9,10,17,33,36,64,69)\) covers all unit numerators modulo 169;
adding 13 and 26 gives a tuple with no 169-grid witness, but with strict witness
\(5/19\) and minimum \(2/19\). The reproducer independently checks those exact
claims. Thus that proposed universal covering bound is false, not a route
available as an input to the present work.

## 1. Exact constant-correction predicate for the prototype

Fix \(p=5\), original speeds \((1,6,11,5)\), and identity actual speeds and
bases. The three ordinary coefficient pairs are all \((1,1)\) modulo 5.
The fourth row has both coefficients zero. Write \(\theta=\beta/M\ge0\).
For each ordinary speed \(v\), put \(v\theta=q+e\), where \(q\) is an integer
and \(0\le e<1\), and define

\[
 B_v(\theta)=
 \begin{cases}\{-q\},&e=0,\\\{-q,-q-1\},&e>0,\end{cases}
 \qquad F_v(\theta)=B_v(\theta)\cup\{0\}\subseteq\mathbb F_5.
\]

Let \(w_v=|F_v|-1\). The ungrouped weighted hypotheses are exactly

\[
 \|\theta\|\ge\tfrac15,\qquad w_1+w_6+w_{11}\le3.             \tag{1.1}
\]

The first condition is the zero row's exact closed bound. The direction set
is \(\{-1\}\), so it already satisfies its bound. Individual weights obey

\[
 w_v=
 \begin{cases}
 0,&v\theta\in5\mathbb Z,\\
 1,&v\theta\in\mathbb Z\setminus5\mathbb Z,\\
 1,&v\theta\notin\mathbb Z\text{ and }\|v\theta/5\|<1/5,\\
 2,&v\theta\notin\mathbb Z\text{ and }\|v\theta/5\|\ge1/5.
 \end{cases}                                                 \tag{1.2}
\]

All boundaries in (1.2) matter. In particular, an integral correction can have
weight one even when its phase is far from zero, or weight zero and compensate
another row of weight two.

The predicate is periodic under \(\theta\mapsto\theta+5\), and invariant
under \(\theta\mapsto5-\theta\). Under the latter operation each forbidden
set is negated, preserving its cardinality and the zero-row distance.

## 2. Complete classification, including all exceptional points

There is no feasible \(\theta\) for which all three ordinary corrections are
nonintegral. Otherwise (1.1) forces all three weights to be one. Set
\(y_i=(1+5i)\theta/5\), \(i=0,1,2\), and choose integer translates
\(z_i\in(-1/5,1/5)\). Since \(y_0-2y_1+y_2=0\),
\(z_0-2z_1+z_2\) is an integer of absolute value strictly less than \(4/5\),
so it is zero. Consequently

\[
 \|\theta\|=\|y_1-y_0\|=|z_1-z_0|
 =\tfrac12|z_2-z_0|<\tfrac15,
\]

contradicting the zero row. This proves exclusion on every open cell without
relying on sampled failures. It also excludes zero-row boundary points unless
an ordinary correction is integral.

If \(\theta\) is integral, the zero row fails. Otherwise at most one of
\(6\theta,11\theta\) is integral, since \(2\cdot6-11=1\). By reflection it
suffices to examine \(0<\theta\le5/2\). The zero-row bound restricts the
remaining candidates as follows. The listed weights are in the order
\((w_1,w_6,w_{11})\); these tables include every eligible exceptional point.

| Denominator | Numerator \(k\) in \(\theta=k/d\) | Weights |
| --- | --- | --- |
| 6 | 2 | (1,1,2) |
| 6 | 3 | **(1,1,1)** |
| 6 | 4 | (1,1,2) |
| 6 | 8 | (2,1,1) |
| 6 | 9 | (2,1,2) |
| 6 | 10 | (2,0,2) |
| 6 | 14 | (2,1,1) |
| 6 | 15 | (2,0,2) |
| 11 | 3,4 | (1,2,1) |
| 11 | 5 | **(1,2,0)** |
| 11 | 6,7 | (1,2,1) |
| 11 | 8 | **(1,1,1)** |
| 11 | 14 | (2,2,1) |
| 11 | 15 | (2,2,0) |
| 11 | 16 | (2,2,1) |
| 11 | 17,18,19 | (2,1,1) |
| 11 | 25 | (2,2,0) |
| 11 | 26,27 | (2,1,1) |

For denominator 6 the eligible residues are \(k\bmod6\in\{2,3,4\}\); for
denominator 11 they are \(k\bmod11\in\{3,4,5,6,7,8\}\). This explains why
the table is exhaustive, rather than a cutoff search. Hence the exact feasible
set in \([0,5)\) is

\[
 \boxed{\{5/11,\ 1/2,\ 8/11,\ 47/11,\ 9/2,\ 50/11\}}.       \tag{2.1}
\]

The independent finite-cell replay below also checks all 91 breakpoints and
all 90 intervening open cells. In particular, checking only nonintegral
corrections would miss every certificate in this model.

## 3. Two exact certificates refute the proposed obstruction

For \(\theta=1/2\), take \(M=50\), \(\beta=25\), and prescribe
\(R(r_0)=10r_0+5\) for all \(r_0=1,\ldots,4\). Then
\(5R=Mr_0+\beta\). The ordinary forbidden sets are

\[
 F_1=\{0,4\},\qquad F_6=\{0,2\},\qquad F_{11}=\{0,4\},
\]

with total weight 3. Choose \(r_0=2,s=4\), both nonzero in the field, so the
common homogeneous residue is 1. The grid time is \(13/10\), equivalent to
\(3/10\), giving distances

\[
 (3/10,\ 1/5,\ 3/10,\ 1/2).
\]

Here \(6\theta=3\) is the indispensable singleton correction.

The other phenomenon occurs at \(\theta=5/11\):

\[
 F_1=\{0,4\},\quad F_6=\{0,2,3\},\quad F_{11}=\{0\},
\]

with weights \((1,2,0)\). Take \(M=275\), \(\beta=125\),
\(R(r_0)=55r_0+25\), again \(r_0=2,s=4\). The time is \(71/55\), equivalent
to \(16/55\), with distances

\[
 (16/55,\ 14/55,\ 1/5,\ 5/11).
\]

Thus zero-weight compensation is also real, not a hypothetical exception.
Both moduli exceed all bases and are divisible by 25. The actual speeds are
the original positive speeds, with multiplier 1 and all signs positive.

## 4. Proportional-class union lemma

The following is a direct, rigorous strengthening of charging each row
separately. It is suitable for implementation using the existing
`weighted_affine_avoidance_author` theorem.

Let \(p\) be prime, \(I,C\) finite sets, and \(\pi:I\to C\) a surjection.
For each row take a nonzero \(c_i\in\mathbb F_p\) and \(F_i\subseteq\mathbb F_p\)
with \(0\in F_i\). Suppose the coefficient pairs satisfy

\[
 (a_i,u_i)=c_i(A_{\pi(i)},U_{\pi(i)}).
\]

For every class define the **normalized class union**

\[
 G_C=\bigcup_{\pi(i)=C}c_i^{-1}F_i.
\]

Assume

\[
 \left|\{z\ne0:\exists C,\ A_C+zU_C=0\}\right|\le p-2,
 \qquad\sum_C|G_C\setminus\{0\}|\le p-2.                    \tag{4.1}
\]

Then there are nonzero \(r_0,s\) such that
\(r_0a_i+su_i\notin F_i\) for **every original row**.

**Proof.** Surjectivity makes each class nonempty, so \(0\in G_C\). Apply the
existing weighted theorem to \((A_C,U_C,G_C)\). Its output avoids all class
unions, hence after multiplication by each nonzero \(c_i\) it avoids the
original \(F_i\). \(\square\)

The normalized union has weight at most the sum of the individual weights,
and can have strictly smaller weight when the scaled forbidden sets overlap.
The *actual* bad-direction set is unchanged by this grouping: a nonzero scalar
does not change whether a form vanishes, and \(\pi\) is surjective. The number
of classes merely gives a sharper elementary upper bound than the number of
rows. No row is discarded and no unknown witness appears in the hypotheses.

For whole rounding envelopes, form each \(F_i\) by union over all prescribed
\(r_0\) **before** taking these class unions. The same proof then applies.
Computing the unions after choosing a favorable affine pair would change the
quantifiers and is not authorized by this lemma.

## 5. A strict gain, robust under varying corrections

For the prototype, all three ordinary forms are equal, so no rescaling is
needed. Take \(\theta=19/40\), \(M=200\), \(\beta=95\), and
\(R(r_0)=40r_0+19\). The row sets are

\[
 F_1=F_{11}=\{0,4\},\qquad F_6=\{0,2,3\}.
\]

Ungrouped weight is 4 and fails its bound, whereas the class union
\(G=\{0,2,3,4\}\) has nonzero weight 3 and passes. Its direction set is
\(\{-1\}\). With \(r_0=2,s=4\), the actual time is \(259/200\), equivalent
to \(59/200\), and the distances are

\[
 (59,46,49,95)/200.
\]

The minimum \(23/100\) is **strictly** above \(1/5\). This is a certificate
gained by aggregation, not just a rewriting of the earlier weight calculation.

More generally, the same allowed homogeneous residue 1 works for every

\[
 \theta\in[5/11,1/2],\qquad t\equiv(1+\theta)/5\pmod1.       \tag{5.1}
\]

On the interior the row sets are exactly those displayed above. At the left
endpoint \(F_{11}\) shrinks to \(\{0\}\); at the right endpoint \(F_6\) shrinks
to \(\{0,2\}\). Thus every whole class union over this closed interval stays
inside \(\{0,2,3,4\}\). The zero row has distance \(\|\theta\|\ge5/11\).
The critical real bounds are \(6t\le9/5\), equivalent to \(\theta\le1/2\),
and \(11t\ge16/5\), equivalent to \(\theta\ge5/11\), after choosing the
representative \(t=(1+\theta)/5\). All four inequalities are strict in the
interior; the endpoints remain good at the closed threshold.

This also supplies rounding envelopes for **every** integer
\(M\ge200\), with corrections allowed to vary, including moduli not divisible by 5. Prescribe

\[
 R(r_0)=\left\lceil\frac{Mr_0}{5}+\frac{19M}{200}\right\rceil,
 \quad\beta(r_0)=5R(r_0)-Mr_0.
\]

Then
\(\beta(r_0)/M\in[19/40,19/40+5/M)\subseteq[5/11,1/2)\)
for every \(r_0\). The whole class union has the same bound, the zero row is
uniformly good, and the same \(r_0=2,s=4\) works. This is a proved robust use
of the aggregation lemma, rather than relying on approximate access to one
of the isolated points in (2.1).

In contrast, in the **ungrouped identity** model, any variable correction
passing the whole-envelope bound must individually satisfy (1.1) at each
\(r_0\), because each pointwise set is a subset of its whole envelope. Hence
each correction lies in (2.1) modulo 5. This observation does not extend the
identity classification to arbitrary signs, multipliers, or chosen positive
bases. Such changes alter the arithmetic corrections and possibly the class
structure. The exact original-speed congruence modulo \(pM\) is still required
for transport; grouping alone supplies no replacement for it.

## 6. Exact equivalence when grouped constant supply is left unrestricted

There is a substantive limit to the preceding improvement. Fix an odd prime
\(p\), a finite positive integer tuple \(V\) of size \(p-1\), and threshold
\(1/p\). Let \(I\) be its coordinates not divisible by \(p\), and \(J\) the
others. Suppose \(I\ne\varnothing\), as holds for every primitive tuple.

In the identity model **all** ordinary pairs are proportional:
\((V_i,V_i)=[V_i]_p(1,1)\). For arbitrary rational \(\theta\ge0\), define
\(F_i=B_i(\theta)\cup\{0\}\) by the exact cyclic correction rule and

\[
 G(\theta)=\bigcup_{i\in I}[V_i]_p^{-1}F_i.
\]

Consider the predicate that there exist such a \(\theta\), a sufficiently
large modulus divisible by \(p^2\), and its integral constant rounding
realization, satisfying

\[
 \|V_j\theta/p\|\ge1/p\ (j\in J),\qquad
 |G(\theta)\setminus\{0\}|\le p-2.                           \tag{6.1}
\]

**Claim.** This predicate is equivalent to the existence of a real closed
\(1/p\) witness for the original tuple. The assertion is about this fixed
tuple and threshold; it is not a new proof of all prime-runner cases, much
less of unrestricted canonical LRC.

**Forward.** The one-class direction set is \(\{-1\}\), and (6.1) is precisely
its weight bound plus the automatic zero-row bounds. The grouped weighted
lemma and exact cyclic transport give an original-speed witness.

**Reverse, with closed endpoints handled exactly.** First any real closed
witness yields a rational closed witness \(t_0\). For each positive speed,
choose the integer floor \(m_i\) of its phase at the given witness. The
simultaneous closed-good region for those floors is the nonempty intersection

\[
 \bigcap_i\left[\frac{m_i+1/p}{V_i},
                   \frac{m_i+1-1/p}{V_i}\right].
\]

All endpoints are rational. Its largest lower endpoint is itself a rational
point of the intersection. This remains valid if the intersection is a
singleton; no strict slack, density, or perturbation is assumed. Reduce that
rational witness modulo 1 if necessary.

Choose rational \(0\le\theta<p\) congruent to \(pt_0-1\) modulo \(p\), and
let \(d\) be its positive denominator. Choose
\(M=p^2dL>\max_iV_i\) with positive integer \(L\), and set

\[
 a_i=u_i=V_i,\qquad\beta=M\theta,\qquad
 R(r_0)=\frac{Mr_0+\beta}{p}.
\]

These are positive bases less than \(M\), natural actual representatives,
and integral nonnegative rounding data for every \(r_0\); \(\beta\) is a
multiple of \(p\). Take \(r_0=2,s=p-1\), both in \(\{1,\ldots,p-1\}\).
Their sum is \(p+1\), so the resulting time is congruent to \(t_0\) modulo 1.
For every ordinary row its homogeneous residue is \([V_i]_p\ne0\). Since
the original phase is good, that residue avoids \(B_i(\theta)\), and also
avoids \(F_i\) after adjoining zero. Therefore \(1\notin G(\theta)\).
As \(0\in G(\theta)\), its nonzero weight is at most \(p-2\).

For **every** zero row \(V_j=pq_j\), the homogeneous part is integral;
\(\|V_j\theta/p\|\) equals its distance at the resulting original witness.
Thus all zero-row bounds hold simultaneously, including multiple zero rows
or speeds divisible by \(p^2\). The common multiplier can be 1, which is a
unit modulo every chosen \(M\), and all signs can be positive. No coprimality
condition, positive-representative condition, or closed endpoint was lost.
This completes the reverse implication. If \(I\) is empty, use no ordinary
classes; the same zero-row argument gives the analogous equivalence directly.

Consequently, allowing arbitrary valid normalizations cannot make the grouped
existential predicate independently easier: identity normalizations already
realize every closed witness, and proper transport always implies a witness.
In the one-class identity case the union bound is exactly the assertion that
some nonzero common multiplier survives the finite forbidden union. Leaving
its supply unproved is leaving the witness problem unproved.

The useful content of grouping is the **a priori overlap estimate**, such as
the explicit uniform union in Section 5. The next mathematical step must
establish another nontrivial estimate or use another route. It cannot merely
assume the normalized-union bound or cite the equivalence as progress toward
universality. The prototype prunes open-cell-only ungrouped reasoning while
also showing why exact resonances and genuine overlap deserve separate treatment.

## 7. Exact small reproducer

The code uses exact `Fraction` arithmetic. Breakpoints include all ordinary
integer corrections and all zero-row boundaries, so signs and cardinalities
are constant on each intervening open interval. The analytic argument and
exception table above establish the classification independently of those
midpoint checks.

```python
from fractions import Fraction as F

V = (1, 6, 11)
def norm(x):
    return min(x % 1, (-x) % 1)
def bad(v, theta, p=5):
    x = v*theta
    q = x.numerator//x.denominator
    return {(-q) % p} if x.denominator == 1 else {(-q) % p, (-q-1) % p}
def sets(theta):
    return [bad(v, theta) | {0} for v in V]
def weights(theta):
    return tuple(len(s)-1 for s in sets(theta))
def good(theta):
    return norm(theta) >= F(1,5) and sum(weights(theta)) <= 3

points = sorted({F(k,v) for v in V for k in range(5*v+1)} |
                {F(k)+e for k in range(5) for e in (F(1,5),F(4,5))})
expected = [F(5,11),F(1,2),F(8,11),F(47,11),F(9,2),F(50,11)]
assert len(points) == 91
assert [t for t in points if good(t)] == expected
assert not any(good((a+b)/2) for a,b in zip(points,points[1:]))
for t in points:
    assert weights(t) == weights(5-t)

table6 = {k:weights(F(k,6)) for k in range(1,16) if norm(F(k,6)) >= F(1,5)}
table11 = {k:weights(F(k,11)) for k in range(1,28) if norm(F(k,11)) >= F(1,5)}
assert set(table6) == {2,3,4,8,9,10,14,15}
assert set(table11) == {3,4,5,6,7,8,14,15,16,17,18,19,25,26,27}
assert [k for k,w in table6.items() if sum(w)<=3] == [3]
assert [k for k,w in table11.items() if sum(w)<=3] == [5,8]

for M,beta,r0,s,expected_time,expected_min in (
    (50,25,2,4,F(3,10),F(1,5)),
    (275,125,2,4,F(16,55),F(1,5)),
    (200,95,2,4,F(59,200),F(23,100))):
    theta = F(beta,M)
    assert M % 25 == 0 and M > 11
    assert all((M*k+beta) % 5 == 0 for k in range(1,5))
    R = (M*r0+beta)//5
    t = F(s,5)+F(R,M)
    rowsets = sets(theta)
    G = set.union(*rowsets)
    assert (s+r0) % 5 not in G
    assert t % 1 == expected_time
    assert min(norm(v*t) for v in V+(5,)) == expected_min
    if M == 200:
        assert sum(len(f)-1 for f in rowsets) == 4
        assert len(G)-1 == 3

interval_points = sorted({F(5,11),F(1,2)} |
                        {F(k,v) for v in V for k in range(1,7)
                         if F(5,11) <= F(k,v) <= F(1,2)})
for theta in interval_points + [(a+b)/2 for a,b in zip(interval_points,interval_points[1:])]:
    assert set.union(*sets(theta)) <= {0,2,3,4}
    t = (1+theta)/5
    assert min(norm(v*t) for v in V+(5,)) >= F(1,5)

variable = 0
for M in (200,201,202,203,204,205,275,1001):
    for r0 in range(1,5):
        x = F(M*r0,5)+F(19*M,200)
        R = -(-x.numerator//x.denominator)
        theta = F(5*R-M*r0,M)
        assert F(19,40) <= theta < F(1,2)
        assert set.union(*sets(theta)) <= {0,2,3,4}
        assert norm(theta) >= F(1,5)
        variable += 1
assert variable == 32

A = (1,7,8,9,10,17,33,36,64,69)
rows = A+(13,26)
assert all(any(min(a*n % 169,(-a*n) % 169) < 13 for a in A)
           for n in range(169) if n % 13)
assert not any(all(min(v*n % 169,(-v*n) % 169) >= 13 for v in rows)
               for n in range(169))
assert min(norm(v*F(5,19)) for v in rows) == F(2,19) > F(1,13)
print({'breakpoints':len(points), 'open_cells':len(points)-1,
       'feasible_points':len(expected), 'exception_table':len(table6)+len(table11),
       'certificates':3, 'variable_controls':variable, 'p13_control':'passed'})
```

Run from the repository root:

```sh
python3 - <<'PY'
from pathlib import Path
text = Path('research/astra-constant-correction-audit.md').read_text()
source = text.split('```python\n',1)[1].split('\n```',1)[0]
exec(compile(source,'astra-constant-correction-audit.md:reproducer','exec'))
PY
```

Executed on 2026-09-05, exit status 0, with exact output:

```text
{'breakpoints': 91, 'open_cells': 90, 'feasible_points': 6, 'exception_table': 23, 'certificates': 3, 'variable_controls': 32, 'p13_control': 'passed'}
```

`python3 scripts/validate_workflow.py` also passed structural validation.

This pass makes no source, shared-state, cache, or Git changes. All equivalences
and class-union statements above are manuscript results; no new Lean theorem
or canonical LRC resolution is claimed.
