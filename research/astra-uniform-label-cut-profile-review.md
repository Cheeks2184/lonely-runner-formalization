# Independent review of the label-cut profile screen

**Accept the complete frozen manuscript at its stated scope. No mathematical
correction is required.** The two-sign anchor lemma is valid, including an
external anchor and N=2. The seven-speed control satisfies every condition
in the explicitly listed arithmetic profile while its label graph is
disconnected. This establishes the claimed nonredundancy of graph
connectedness relative to that profile. It is neither an LRC counterexample
nor an unconditional anchor-supply theorem.

Date: 2026-09-06. Task `/root/uniform_label_cut_profile_review`, executed in
the existing `/root/uniform_affine_phase_screen` session, requested Astra/xhigh.
Supplied source checkpoint: `15a34041b72e17734d746fea005c83130a7e41fb`.
I did not author the reviewed manuscript or its anchor/control construction.
Only this review file is owned. Current project config, workflow, policy and
focused active state were read; the research gate is authorized/in progress.
Startup workflow validation exited 0. Runtime model/effort and per-task usage
are not independently exposed; total elapsed time is unmeasured/null.

## Frozen manuscript and all five dependency bindings

The complete final manuscript was read. The actual `sha256sum` readback
matched its requested final hash and all five listed dependency hashes:

| File | SHA-256 |
| --- | --- |
| `research/astra-uniform-label-cut-profile.md` | `05b89f854f5076ffcfb139a19ea34a8ed6d9481c893211560aa443881bc89326` |
| `research/astra-uniform-colour-critical-cover.md` | `84b7f417a73dd8e580300390a3e1081f61904ad1860215487f03f7c1a51e578f` |
| `research/astra-uniform-colour-critical-review.md` | `49e42ed76159de73c3e2fd568021c82942913f76d976a596544323e1ef1caed9` |
| `research/astra-uniform-divisor-minimality.md` | `8c4b6ee094f0f311f360d3abf371e95f731e28cee997d3810dd3218ff6f25746` |
| `research/astra-subset-gcd-profile-screen.md` | `979fb69005f60f4e0f4b350a272ac7234917695b7df085ab858a7bf9324456f9` |
| `research/astra-subset-gcd-profile-review.md` | `f9826bab2d9810e6ff8427fcc57eaf12c0dcf5ff0d346d1a9ebdb182ab35cf81` |

Acceptance binds this final external-anchor version, not the superseded
earlier author hash beginning `fbba7e`. The graph manuscript and its complete
review were inspected, as were the exact profile definitions and relevant
proofs in the other dependencies. The subset-gcd primary-source statement is
inherited with its previously reviewed scope; this task did not retrieve or
reaudit the external article's geometric proof.

## Uniform two-sign anchor lemma

The exact accepted contract is: for every integer N>=2, every positive integer
m, and every finite family of positive integers a_i, if

`a_i+m <= N*gcd(a_i,m)` for every i,

then **both** positive real times `(N-1)/(N*m)` and `(N+1)/(N*m)` satisfy
`||t*a_i||>=1/N` for every i. The family may be empty, contain repeated
speeds, or omit m. There is no family-cardinality restriction, primitivity
condition, seed premise, or independent phase choice. Positivity of m keeps
the denominators nonzero and both times positive.

For any fixed coordinate a, positivity gives `g=gcd(a,m)>0`. Write
`a=g*d`, `m=g*e`, with d,e positive coprime integers. Dividing the hypothesis
by g gives `d+e<=N`, and the two phases are exactly

`d/e + d/(N*e)` and `d/e - d/(N*e)`.

When e=1, `1<=d<=N-1`. Removing the integer d and using evenness of the
circle norm identifies the two norms with `||d/N||`. Since
`d/N` lies in the closed interval `[1/N,1-1/N]`, this norm is at least
1/N. Thus the minus case uses both integer periodicity and sign symmetry;
there is no assumption that the negative perturbation itself is positive.

When e>=2, the residue of d modulo e is nonzero by coprimality. Both it and
its complementary residue are at least one, giving `||d/e||>=1/e`.
The 1-Lipschitz estimate applies with the same perturbation magnitude
`d/(N*e)` for either sign. Hence each norm is at least

`1/e-d/(N*e) = (N-d)/(N*e) >= 1/N`,

where the final comparison is precisely `N-d>=e`. Equality is allowed
throughout. The argument proves each sign separately for every coordinate,
so either single sign supplies one time common to the entire family; it
does not produce coordinate-dependent sign choices.

At N=2 the positive integers d,e with `d+e<=2` must be d=e=1. Both times
therefore give norm exactly 1/2, so the smallest allowed N is handled rather
than discarded by a strict-threshold argument. If a=m is present for any
N>=2, its premise is automatic and its two phases are `1+/-1/N`, of norm
exactly 1/N. Neither fact requires the anchor to belong to the family in the
general statement. The external-anchor edit is consequently sound.

## Inherited graph scope and logical direction

For the original graph setting, the speeds are distinct positive integers,
there are n=N-1 labels, and the inherited reviewed construction has n>=3.
I use its consequence within that scope; the anchor lemma above has the
separately proved wider N>=2 scope. Let H be the common closed-margin good
set and put an edge between distinct speeds a,b exactly when
`a+b>N*gcd(a,b)`.

The original colour-critical author proved `H=empty => C connected` with
deletion seeds. Its independent reviewer correctly removes that premise:
after merging only coincident centres, every speed v>1 retains its arc at
1/v, since another integer grid contains this centre only when its speed is
a multiple of v and hence is no smaller. Distinctness makes the smallest
speed unique. Speed 1, if present, retains the widest arc at zero. Thus every
label survives without any seed or privacy assumption.

Coincident-centre merging preserves the bad union. Full coverage makes its
finite intersection graph connected, and any edge between distinct centres
of speeds a,b has centre distance at least `gcd(a,b)/(a*b)`. Intersection of
the **open** bad arcs forces that distance to be strictly less than
`(a+b)/(N*a*b)`. Each edge therefore projects to an edge of C. A path between
retained representatives projects to a label walk, proving connectedness.
The contrapositive is `C disconnected => H nonempty`.

This verifies the manuscript's inherited seed-free statement without
transferring survival to later containment pruning. It also avoids treating
deletion in an already reduced graph as the reduction of a deleted family.
The weak inequality `a+b<=N*gcd(a,b)` is correctly a nonedge; changing it to
a strict nonedge would lose closed-boundary cases.

The prime-N redundancy argument also retains its exact scope. Across a
nonedge, unequal N-adic valuations would leave one reduced positive quotient
divisible by N and another at least one, contradicting their sum being at
most N. In a disconnected graph, cross-component comparisons then force the
same valuation for every label. Primitivity together with a speed divisible
by N rules this out. That prime reasoning does not prohibit the composite
control below.

## Complete hand verification of the control

Take N=8 and the ordered tuple `(1,2,4,6,8,15,42)`, with anchor m=6.
These are seven distinct positive integers. The reduced sums for a equal
to `1,2,4,8,15,42` are respectively `7,4,5,7,7,8`. Their gcds with 6 are
`1,2,2,2,3,6`, giving reduced pairs
`(1,6),(1,3),(2,3),(4,3),(5,2),(7,1)`.
Every sum is at most eight. Label 6 is therefore isolated, and a graph with
seven labels and this isolated vertex is disconnected. The pair (6,42)
has sum 48 equal to `8*gcd(6,42)`, so its nonedge uses the required equality.

All deletion gcds are one: deleting any speed other than 1 leaves 1; deleting
1 leaves the coprime pair 2,15. This also verifies full primitivity. For
every integer d>=2, six d-divisible speeds would themselves form a deletion
with gcd at least d. Thus the all-divisor count is at most five, with no
exception for a particular deleted label or a large divisor.

All seven small denominators are covered, in order `q=2,...,8`, by the
speeds `6,6,8,15,6,42,8`. In particular the composite denominators 6 and 8
are covered by actual individual speeds, rather than by factors distributed
across several coordinates.

For the unbounded orbit condition, a nondivisible coordinate has integer
orbit size `r=ell/gcd(ell,a)>=2` and contribution
`ceil(r/4)/r>=1/4`. At ell=2 exactly the speeds 1 and 15 are nondivisible;
each has r=2 and contribution 1/2, so the sum is exactly one. For every
ell>=3, the manuscript's exhaustive alternatives are valid:

* Odd ell divides none of `1,2,4,8`, leaving at most `6,15,42` divisible.
* An even power of two is at least four; only `4,8` can be divisible,
  since 6 and 42 have precisely one factor of two and 1,15 are odd.
* An even non-power of two has an odd prime divisor, excluding `1,2,4,8`,
  while parity excludes 15; only `6,42` can be divisible.

Every ell>=3 therefore leaves at least four nondivisible coordinates.
Their contributions sum to at least one. This proves the entire infinite
family of orbit inequalities, not a finite sample or a prime-only version.
The ceiling is preserved exactly, including the ell=2 equality case.

For both height conditions, `B_8=28^6`. The maximum is 42. There are exactly
127 nonempty index subsets, and each subset gcd is a positive divisor of
one of its elements and is at most 42. Thus the full subset sum satisfies

`F(v)<=127*42=5334<21952=28^3<28^6`.

This bound includes all singleton and nonsingleton subsets, with no extra
empty-subset term. It immediately implies the separately listed maximum
bound as well. For the fast-speed exclusion, the largest speed satisfies
`42<7*15=105`; every other speed is at most 15 and has complementary
maximum 42, so it satisfies `v_p<7*42`. Every label has been covered.

The minus anchor time is 7/48. Its exact norm numerators on denominator 48
are `(7,14,20,6,8,9,6)`, whose minimum is 6/48=1/8. As an additional hand
check of the other sign, the plus time is 3/16 and its norm numerators on
denominator 16 are `(3,6,4,2,8,3,2)`, again of minimum 1/8.
At the stated stronger time 3/10, the norm vector is exactly
`(3/10,2/5,1/5,1/5,2/5,1/2,2/5)`. Its minimum is 1/5>1/7.
Consequently that same real time supplies every deletion's own-margin seed
and a full target witness, independently of any higher-count hypothesis.

For this specific control, Q follows immediately: the pivot norm at 3/10
already exceeds 1/8 and every old coordinate has positive slack. This does
not infer Q from arbitrary H nonemptiness, or make a general connection
between disconnected C and a protected seed union. No such implication
was proved or used in the manuscript.

## Disposition and implementation relevance

Let P be exactly the profile displayed in the frozen manuscript. The verified
control satisfies P and violates connectedness of C. It therefore refutes
the universal implication `P => C connected`, including the all-ell orbit
and full subset-gcd clauses. This is the precise nonredundancy established;
it is not a claim of logical independence in both directions, independence
from every existing sufficient theorem, or a classification of composite N.
It plainly does not satisfy a no-witness assumption.

The two-sign anchor lemma is a reasonable small conditional implementation
candidate if no existing result already supplies its full external-anchor
contract. Such an implementation should state either both explicit common
times or each sign uniformly and retain N>=2 and closed inequalities.
It needs gcd reduction, periodicity/sign symmetry, and the Lipschitz bound.
Full circle-arc or label-graph infrastructure is unnecessary for this anchor
subcase. No unconditional anchor existence follows, and connected graphs
remain outside the supplied argument. Formalizing this lemma alone would
not complete the unrestricted conjecture or establish a new runner-count
milestone.

Verification used only source reads, SHA-256 readback and the hand arguments
above. No mathematical program, numerical search, Lean command, cache or
dependency operation, Git command, shared-state mutation or delegation was
performed. The only write was this review. The structural validator's complete
output at startup was:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

It exited 0; this certifies workflow structure only. All six listed SHA-256
bindings were read successfully. No correction to the author source or new
verification run is required by this review. This task needs no `.lake`
artifact or dependency source.

## Addendum: connectivity still leaves a compatible family for unbounded N

This observation was proposed by root after the review above and independently
checked by this reviewer. It is an addition to the review, not a claim newly
attributed to the unchanged author manuscript `05b89f85...`.

For every N>=5, let `L=lcm(2,...,N)` and take the previously accepted family

`v_i=L+i`, for `0<=i<=N-2`.

Its label graph is in fact complete. To check any pair i<j, the positive
integer `g=gcd(L+i,L+j)` divides the positive difference j-i. Therefore

`g <= j-i <= N-2`.

Both N and N-1 divide L and are coprime, so `N*(N-1)` divides L and
`L>=N*(N-1)`. Since i+j>=1, it follows that

`v_i+v_j >= 2L+1 >= 2N(N-1)+1 > N(N-2) >= N*g`.

The middle strict difference is exactly `N^2+1>0`. Thus every distinct pair
is an edge under the required strict rule, and the graph is the complete
graph on N-1 labels. No endpoint or equality exception remains.

The frozen divisor-minimality and subset-gcd reports bound above already
prove, for this same family and every N>=5, primitivity, every deletion gcd
one, all small-denominator covers, all unbounded orbit-capacity inequalities,
both listed height bounds and the fast-speed exclusion. They also prove
that `t=1/(2L)` has every norm strictly above `1/(N-1)`. Those are the same
speed labels and normalization used here; no properties are transferred
from the different seven-speed anchor control.

Consequently adding graph connectedness to the entire listed arithmetic
profile still leaves a compatible positive family for every N>=5. The
family is unbounded as N varies; this is not an unbounded-height assertion
at a fixed N under its finite cutoff. The explicit strong common witness
also supplies all deletion seeds and Q for these particular tuples. None of
this proves Q from general H nonemptiness or a witness theorem for arbitrary
connected label graphs. Together with the disconnected control, it precisely
shows that the new necessary graph restriction is nonredundant yet does not
make the enlarged profile inconsistent.

This addendum used only the displayed integer inequalities and the already
bound, read dependencies. No mathematical program, search, Lean invocation,
cache, Git or shared-state operation was performed; the author file remains
unchanged. No additional graph infrastructure or unconditional supply claim
is recommended on the strength of this observation.
