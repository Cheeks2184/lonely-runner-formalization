# Reduced bad arcs and exact neighboring gaps

Date: 2026-09-06. Registered task `/root/uniform_reduced_arc_gap_screen`,
executed by `/root/uniform_seed_coupling`; requested Astra/xhigh.
Supplied and read-back checkpoint:
`23c84a2cf28aeb6c9483d0ca08131aea0c901356`.
Only this report is owned. Current project config, workflow, policy and
focused state were read; workflow validation passed. Runtime model/effort,
elapsed time and token usage are not independently exposed.

**Result.** After coincident centers are merged and every contained arc is
removed, full-good components are exactly the nonnegative gaps between
neighboring surviving arcs. The proposed determinant inequality is therefore
correct, including equality, for those neighbors. This is an exact finite
checking reformulation; no uniform arithmetic gap supply was proved.
Distinct-center containment has a simple exact integer criterion. The
natural total-length bound after pruning is not universally available: the
established translated lcm block has no such further containment and has
remaining total arc length strictly greater than one for every `N>=5`,
despite an explicit full gamma witness.

The two approaches were canonical arc reduction with exact gap geometry,
and an aggregate arithmetic length bound with its scope obstruction. No
third direction, mathematical program, tuple enumeration, Lean work,
dependency/cache operation, shared-state edit, Git mutation or delegation
was performed. The earlier Euler report was not changed.

## Inputs and target

Read source bindings:

| Input | SHA-256 |
| --- | --- |
| `LonelyRunner/StructuredClasses.lean` | `5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c` |
| `research/astra-uniform-endpoint-euler-screen.md` | `00f37303fc266b1843964293500a1be112e3a9d8439d3dcad65a662d60be1b25` |
| `research/astra-uniform-divisor-minimality.md` | `8c4b6ee094f0f311f360d3abf371e95f731e28cee997d3810dd3218ff6f25746` |

Let `n=N-1>=3` and let the `n` speeds be distinct positive integers.
Set `delta=1/N`. For each speed `v` its open bad set is the union of arcs

```
A(v,k)={t in R/Z : distance(t,k/v)<1/(N*v)},  0<=k<v.
```

Write `U` for the union of all these arcs and `H=(R/Z)\U` for the full
closed delta-good set. This task concerns supply of a point of `H`; it
does not prove that such a point is in a protected deletion-seed ball.
Accordingly no implication from `H nonempty` to Q is used.

The read theorem `minimumScaleResidueBands` already gives the explicit
witness `1/(N*base)` when every normalized absolute speed is in a closed
band `[q*N+1,q*N+n]`. The simple first-center gap with
`max(v)<=n*min(v)` is its `q=0` case and is not a new result here.

## Approach 1: canonical reduction and a valid neighboring-gap criterion

### Coincident centers

Let `D` be the union of the positive divisors of the speeds. A reduced
fraction `a/q mod 1`, with `q in D` and `gcd(a,q)=1`, occurs as a center
exactly for the speeds divisible by `q`. Include the center zero as `0/1`.
Define

```
m_q=min{v_i : q divides v_i},    e_q=m_q/q.
```

Of all arcs at that center, the one with speed `m_q` is widest and contains
the others. Keeping it preserves `U` exactly. There are precisely

```
sum_(q in D) phi(q)
```

distinct centers, with `phi(1)=1`. Their radii are `1/(N*m_q)`. This is
an exact reduction based on actual shared rational centers.

### All containment, not just coincident centers

Among those finitely many distinct-center arcs, retain exactly the
inclusion-maximal arcs. Every removed arc is contained in a maximal one,
so this also preserves `U`. Distinct centers give distinct arcs, hence the
maximal family is unambiguous; no arbitrary tie-breaking is needed.

**Lemma 1 (integer containment criterion).** Let `u<v`, with arc centers
`k/u` and `l/v`. Define the centered integer distance

```
d=min_(z in Z) |v*k-u*l-z*u*v|.
```

Then the faster arc is contained in the slower arc if and only if

```
N*d <= v-u.                                     (1)
```

The center distance is `d/(u*v)`. For these arcs, whose radii are at most
`1/4`, containment is equivalent to

```
d/(u*v)+1/(N*v) <= 1/(N*u).
```

This gives (1). Equality is allowed: an open inner arc may share a boundary
point with the outer open arc and still be contained in it. For distinct
centers, `d` is a positive multiple of `gcd(u,v)`, so containment requires

```
v-u >= N*gcd(u,v) >= N.                         (2)
```

Equal radii at distinct centers cannot contain one another. In particular,
if the entire speed spread is less than `N`, no distinct-center arc can be
removed after the coincident-center reduction. Condition (2) is necessary
for containment somewhere; the exact condition for specific centers is (1).

Survival is generally a property of the numerator as well as the denominator:
one must not replace the surviving set by an unproved all-or-none rule for
each denominator `q`.

### Why containment pruning makes neighboring centers sufficient

List the surviving center lifts as

```
c_1<...<c_K<c_1+1,    c_(i+K)=c_i+1,
r_i=1/(N*owner_i),    L_i=c_i-r_i, R_i=c_i+r_i.
```

**Lemma 2 (ordered endpoints).** Both sequences `L_i` and `R_i` are
strictly increasing on the periodic lift.

If `c_i<c_j` but `L_i>=L_j`, then `r_j-r_i>=c_j-c_i` and the entire
lifted interval of arc `i` is contained in that of arc `j`. Projection to
the circle contradicts maximality. If `R_i>=R_j`, the interval of `j` is
contained in that of `i`. Equality of an endpoint is included in the same
containment argument. This proves both strict inequalities, also across
the chosen cut by using the translated lifts.

**Theorem 3 (exact gap decomposition).** The full-good set is exactly

```
H = union_(i : R_i<=L_(i+1)) [R_i,L_(i+1)] mod 1.            (3)
```

For a nonnegative gap, every arc with center at or before `c_i` ends no
later than `R_i`, and every arc with center at or after `c_(i+1)` starts
no earlier than `L_(i+1)`. Lemma 2 therefore excludes all nonneighbors,
including arcs crossing the cut. The two displayed endpoints are outside
their own open arcs. This proves that the entire closed gap is in `H`.

Conversely, a point of `H` between consecutive center lifts must be at
least `R_i`, to avoid the left arc, and at most `L_(i+1)`, to avoid the
right arc. This proves the reverse inclusion. Distinct nonempty gaps are
separated by surviving centers, which are bad, so they are exactly the
connected components of `H`. An equality `R_i=L_(i+1)` is one isolated
full witness, not a lost or merged component.

For neighboring surviving reduced fractions `a/q<b/r` on these lifts,
write

```
h=b*q-a*r>0,   m_q=q*e_q,   m_r=r*e_r.
```

The right numerator is increased by its denominator when passing through
the period cut; it need not lie in the usual fundamental range. Since
the center difference is `h/(q*r)`, (3) becomes the exact test

```
N*h*e_q*e_r >= m_q+m_r.                          (4)
```

Every quantity is an integer except the displayed fractions. Equality
supplies a closed witness. The uniform unresolved statement is that some
surviving neighboring pair satisfies (4). Neighboring pairs are taken
**after** maximal-arc pruning; they need not be neighbors in the full Farey
sequence of order `max(v)` and need not have determinant one.

### A real obstruction if nonneighbors are ignored before pruning

For every `N>=6`, take speeds `{1,2,...,N-2,3*N+1}` and write `v=3*N+1`.
The centers `1/v` and `2/v` are consecutive among the distinct positive
centers: every smaller speed has its first positive center at least
`1/(N-2)>2/v`. Both centers have radius `1/(N*v)`, even if `2/v` reduces,
because its reduced denominator still exceeds every smaller speed.

Their proposed closed neighboring gap is

```
[(1+1/N)/v, (2-1/N)/v],
```

of positive length. But the whole interval lies strictly between zero and
`1/N`, so speed `1` is bad throughout. Its wider arc at zero covers this
candidate gap; both fast arcs are contained in it and are removed by (1).
Thus coincident-center reduction alone does not justify the gap test.

This is a hypothesis-complete actual control, not synthetic phases. At the
single time `1/(N-1)`, the slow speeds have nonzero residues and the fast
speed has residue `4`; since `N-1>=5`, every norm is at least `1/(N-1)`.
All deletion seeds are nonempty. The example checks the necessity of the
geometric hypothesis in (3), not an additional runner-count milestone or
a counterexample to full witness supply.

## Approach 2: weighted total length and its limitation

Let `T_*` be the sum of lengths of the surviving maximal arcs. Summing the
signed neighboring gaps in (3) gives the exact telescoping relation

```
sum_i [L_(i+1)-R_i] = 1-2*sum_i r_i = 1-T_*.    (5)
```

Thus `T_*<=1` guarantees at least one nonnegative gap and a full closed
witness. If `H` is empty then all the gaps are strictly negative and
`T_*>1`. This is a valid sufficient bound, but not a uniform proof.

Before the distinct-center containment step, define the explicit divisor
quantity

```
A=sum_(q in D) phi(q)/m_q,
T_0=2*A/N.
```

We have `T_*<=T_0`. In particular `A<=N/2` is a sufficient condition for
a full witness, and `H=empty` forces `A>N/2`. This is an explicit
necessary arithmetic length condition for absence of all full witnesses;
its independence from earlier divisor/orbit conditions has not been proved.
It is not asserted as a necessary condition for Q failure.

### The established translated block defeats the total-length shortcut

Take the same previously analyzed family

```
N>=5, n=N-1, L=lcm(2,...,N),
v_j=L+j, 0<=j<n.
```

Its speed spread is `n-1=N-2<N`, so Lemma 1 rules out every distinct-center
containment. Hence `T_*=T_0`; only coincident centers disappear.

To bound their removal, process the speeds in increasing order. Speed
`v_j` has `v_j` centers, and its center set meets that of `v_i` in exactly
`gcd(v_i,v_j)` points. At most the sum of these intersection counts can
already have appeared. Each newly appearing center retains the radius of
this first, slowest owner. Therefore

```
A >= n-sum_(i<j) gcd(v_i,v_j)/v_j
  >= n-[n*(n^2-1)/(6*L)].
```

Here `gcd(L+i,L+j)<=j-i`, and
`sum_(i<j)(j-i)=n*(n^2-1)/6`. Coprimality of `N` and `N-1` gives
`L>=N*(N-1)=n*(n+1)`, so

```
A >= (5*n+1)/6,
T_* = 2*A/(n+1) >= (5*n+1)/[3*(n+1)] > 1.       (6)
```

Thus even complete canonical pruning leaves a negative total signed gap
in (5), uniformly for this family. Nevertheless it has a full gamma
witness at `t=1/(2*L)`: all norms are

```
1/2-j/(2*L) > (n-1)/(2*n) >= 1/n.
```

Every deletion seed is consequently nonempty. The existing divisor
manuscript establishes that this same family satisfies its earlier
arithmetic profile; the new work here is the no-containment and total-length
calculation. Formula (3) implies that some individual surviving gap is
positive, even though their sum is negative. No graph connectivity or
all-negative-gap claim is made for this positive family.

This refutes the proposed universal shortcut `T_*<=1` under the relevant
all-seed hypotheses. It does not refute (4), a different weighted argument,
or LRC. It shows that averaging the surviving gap lengths cannot by itself
force the required sign. The simple origin gap remains the old
minimum-scale witness test; no easy clustered case is promoted to a new
uniform mechanism.

## Exact residual and formal relevance

The reduction and gap theorem prove the equivalence

```
H nonempty
  iff some surviving neighboring pair satisfies
      N*h*e_q*e_r >= m_q+m_r.
```

The missing theorem is uniform arithmetic supply of such a pair for
`n=N-1`, or under a least-counterexample profile strong enough to lead to
contradiction. Coincidence counts, exact containment tests, and the total
length sum do not establish that theorem. Numerator-dependent pruning,
non-unit determinants and strict overlap at every remaining gap must all
be retained in a hypothetical failure. A full witness produced by this
criterion still needs a separate protected-location argument for Q.

The finite arc reduction, monotone endpoint lemma and closed-gap identity
are suitable for Lean, as are the integer containment and determinant
equivalences. No implementation was requested or attempted. Formalizing
them would provide exact checking infrastructure and correct scope, not
the missing arithmetic supply. All conclusions here are author manuscript
proofs awaiting independent semantic review; the only executed checks were
workflow validation and source/hash inspection.
