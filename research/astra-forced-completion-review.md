# Independent review of forced-arc completion

Task `/root/forced_completion_review`, executed in the existing
`/root/coordinate_cancellation_review` session. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed time and usage: `null`.
Assignment checkpoint: `9f276366960df7a55c1f934d4f52fae1169a62fb`.
Only this review is owned. The frozen author and all other files are preserved.

**Accepted at manuscript scope, with no correction required.** The exact
minimum-cost factorization, two disjoint nonforced completions, cellwise cost
formula, multiplicity bound and strict forced-edge arithmetic are valid.
The completion is an actual exchange within the full original grid. No
sufficient arithmetic saving, missing adjacency, or unrestricted contradiction
has been proved. The completion-cost formula is not itself a sharp bound.

## Exact forced family and independent closed gaps

Assume n distinct positive primitive integer speeds, `n>=3`, in a hypothetical
ordinary strict failure chosen first by count and then by primitive sum. Set
`N=n+1`, `alpha=1/N` and `mu=max_t min_v ||vt||<alpha` on `T=R/Z`.
Choosing `0<t<1/(2 max V)` makes every norm positive, so `mu>0`.
The complete original open family consists of indexed arcs centered at k/v,
radius alpha/v, `0<=k<v`. It covers T, and its reciprocal cost is exactly n.

For each speed, `W_v={t:||wt||>=alpha for every w in V\{v}}` is nonempty
by the stronger own-margin deletion witness. On W_v its deleted norm is at most mu.
Every attained collision index therefore has an actual point in its closed
mu-core and in no other original open alpha-arc. Conversely, a point covered
by only one original arc is good for every other label, belongs to W_v, and
has the unique collision index of that same arc. Thus F is exactly the
individually indispensable indexed arcs of the COMPLETE original family.
For a finite cover, individual indispensability is equivalent to possessing
such a private point. This converse uses strict failure and the same-label
disjointness at `alpha<1/2`; it does not follow merely from membership in an
arbitrary irredundant subcover. The same points force these indices at every
`mu<delta<alpha`. At least one belongs to each speed, so `r=|F|>=n>=3`.

Choose a private point p_j for each forced arc A_j, in cyclic order. The
points are distinct because none belongs to two original arcs. Extend them
periodically and lift A_j through p_j. Since it cannot contain any other
private point, its endpoints satisfy

```text
p_(j-1)<=L_j<p_j<R_j<=p_(j+1).
```

Connectedness puts the lifted arc between the neighboring barriers; equality
at an outer endpoint is allowed because the arc is open. A nonforced arc
contains none of the private points and hence lies wholly in one unique
component `I_j=(p_j,p_(j+1))`. Its endpoints may equal cell boundaries.
It cannot cross a private point into another cell. Among F, only A_j and
A_(j+1) can meet I_j, contributing its left and right tails.

If `R_j>L_(j+1)`, those tails cover I_j and the residual gap is empty.
Otherwise their complement there is exactly

```text
G_j=[R_j,L_(j+1)] subset I_j.
```

Both endpoints are strictly inside I_j, and equality gives a genuine
singleton. No forced open arc covers these gap endpoints. Every gap point
has at least two nonforced covering arcs in that cell: coverage supplies one,
and a unique covering arc would itself belong to F, a contradiction. This
reasoning includes singleton gaps and the cell across the period cut.

Let kappa_j be the minimum cost of a nonforced subfamily in I_j covering
G_j, with kappa_j=0 for an empty gap. Finiteness and coverage give these
minima. Every full cover contains F and must fill each gap using only that
cell's nonforced arcs, so its cost is at least `f+sum_j kappa_j`, where
`f=cost(F)`. Taking all cell minima together with F attains the bound:

```text
minimum full-grid cover cost = f+sum_j kappa_j.
```

This is an exact factorization. It neither estimates the kappa sum nor moves
any original grid arc; periodic lifts are only coordinates for the proof.

The intersection graph of F is a subgraph of the cycle in private-point
order, with degree at most two. Its components are paths, including isolated
vertices, unless all cyclic edges are present. Such a cycle uses every vertex
and covers T, since every intervening pair of tails overlaps. A triangle
would then cover T with positive overlap, requiring total length greater
than one. But any three original indices have total length at most
`2alpha(1+1/2+1/2)=4alpha<=1`. Thus cycles have at least four vertices.
Away from the private points at most the two neighboring forced arcs can
occur, and at a private point only its owner occurs. This independently
proves no triple intersection for F. Path closures may touch at omitted
points; a forced cycle has not been excluded.

## Open-interval coloring and the exact exchange cost

The coloring lemma is valid for any finite family of open real intervals.
Process them in increasing left endpoint, arbitrarily breaking ties. Keep
each color's greatest right endpoint, initially negative infinity, and assign
the next interval to the color with the smaller maximum.

The invariant is exact: after any prefix the two color maxima are the two
greatest right endpoints seen so far, counting multiplicity and padding with
negative infinity until two endpoints exist. If their sorted
values are `s<=t` and the next right endpoint is b, the update gives
`(s,t)` when `b<=s`, `(b,t)` when `s<b<=t`, and `(t,b)` when `b>t`.
This covers nested intervals and all right-endpoint ties. For any real x,
consider the prefix with left endpoints STRICTLY below x. If at least two
intervals contain x, the greatest two right endpoints of this prefix both
exceed x strictly. Each color therefore has an interval containing x.
Intervals starting or ending at x are handled with the required open signs;
arbitrary ordering of equal left endpoints does not change the prefix.

Apply the lemma to all nonforced arcs within each I_j. Its two color classes
`E_j^0,E_j^1` each cover G_j, because every gap point has depth at least two.
Thus the families

```text
C^epsilon=F union (union_j E_j^epsilon),   epsilon=0,1,
```

are full covers. As families of INDEXED ARCS, they intersect exactly in F
and their union is the complete original family. This is not a statement
about intersections of their time unions, both of which are T. If all gaps
are empty the assertion is vacuous completion and remains valid. Colors
can also be chosen separately in every cell, without cross-cell interference.

Writing `c_j^epsilon=cost(E_j^epsilon)` and
`B=sum_j |c_j^0-c_j^1|`, choosing each less costly class produces an actual
cover C_* with

```text
cost(C_*)=f+sum_j min(c_j^0,c_j^1)=(n+f-B)/2.
```

The algebra uses `sum_j(c_j^0+c_j^1)=n-f`, since the nonforced family is
partitioned without duplicate indices. This is the exact cost of a constructed
cover, not an assertion that these color classes minimize each kappa_j.
Further removals might lower cost but are not assumed. In particular it gives
the upper bound `(n+f)/2` for some completion.

Every finite open alpha-cover has cost strictly greater than `N/2`.
Its sum of arc lengths is `2alpha cost`. The union has length one, and an
endpoint of any selected proper arc must belong to another selected open
arc. An open neighborhood of that endpoint overlaps the first arc in positive
length, so the length sum is strictly greater than one. Consequently every
cell coloring and its cover above satisfy

```text
(n+f-B)/2 > (n+1)/2,   equivalently B<f-1.
```

An arithmetic theorem forcing the opposite weak inequality would contradict
the hypothetical cover. The construction does not supply such a theorem.

## Full multiplicity and the forced mu-core bound

Let `M(t)=#{v:||vt||<alpha}` for the COMPLETE original family. Same-label
arcs are disjoint, so this is also its indexed-arc multiplicity. Strict
failure gives `M>=1` everywhere, while `integral M=2n alpha`. For integers
M>=1 the pointwise identity

```text
1_(M=1)=2-M+(M-2)_+
```

is exact. With normalized circle measure, `P=measure{M=1}` and
`T_3=integral(M-2)_+`, it follows that

```text
P=2-2n alpha+T_3=2alpha+T_3.
```

Every point with M=1 belongs to its unique owner's W_v and thus to a forced
closed mu-core. The total length of those cores, counted with multiplicity,
is `2mu f`; overlapping cores can only reduce their union's measure. Hence

```text
2alpha+T_3=P<=2mu f,
f>=alpha/mu+T_3/(2mu)>1.
```

The positivity and strict depth gap `0<mu<alpha` justify the division and
last strict inequality. This calculation uses full original multiplicity,
not multiplicity of F. No-triple overlap for F does not set T_3 to zero.
It rules out closing the coarse cost estimate by a proposed `f<=1`; it does
not estimate the required cellwise saving B.

## Actual forced-edge depth, integer window and center ownership

Take overlapping forced arcs with different actual speeds a,b. Coincident
centers or containment would contradict a private point. Same-speed arcs
never overlap. Their total length is at most `3alpha<=3/4<1`, so cut outside
their union and choose overlapping lifts with

```text
c_a=k/a<c_b=l/b,   d=c_b-c_a>0,   D=a l-b k=ab d.
```

Noncontainment makes both endpoint orders increase. The a-private point is
outside the b-arc, hence at or left of `c_b-alpha/b`; it is also at least
`c_a-mu/a`. The b-private point is at or right of `c_a+alpha/a` and at most
`c_b+mu/b`. Therefore

```text
d>=alpha/b-mu/a,   d>=alpha/a-mu/b,
max(alpha a-mu b,alpha b-mu a)<=D<alpha(a+b).
```

The lower inequalities are correctly weak, allowing private points on the
other open arc's boundary. The strict upper inequality is precisely overlap.
The same lifted private points lie in their corresponding mu-cores because
`mu<alpha`; no change of nearest collision index is made. The larger lower
bound equals
`alpha|a-b|+(alpha-mu)min(a,b)`, giving the strict consequence

```text
alpha|a-b|<D<alpha(a+b).
```

The positive integer D is divisible by `g=gcd(a,b)`. Put
`A=max(a,b)/g`, `B_0=min(a,b)/g`, `h=D/g`. Multiplying by N and dividing
by g gives `A-B_0<Nh<A+B_0`, exactly `|A-Nh|<B_0`.
These are actual integer labels and determinants, not reduced-center labels.

If speed 1 occurs, its sole zero-centered arc is forced because W_1 is
nonempty. For an overlapping forced arc of speed a, the integer window is
`|a-Nh|<1`, hence `a=Nh`. Choose the speed-1 center lift at zero. On its
right an overlapping center has lift `k/a` with positive determinant k;
on its left the determinant is -k. Thus `|k|=h=a/N` and the center is
`1/N` or `-1/N` modulo one, respectively. The actual speed is an arbitrary
allowed multiple of N, not necessarily N itself. No existence of speed 1
or either forced neighbor is claimed. Nonforced arcs can complete a path
endpoint and need not obey this two-private-point inequality.

Finally, suppose a forced arc of speed m is centered at reduced r/q. Then
q divides m. For another original speed v divisible by q, the center has
integer v-phase. At the forced arc's actual private point, use the matching
lift `t=k/m+e/m`, `|e|<=mu`. The other label is alpha-good, so

```text
alpha<=||vt||=||v e/m||<=v|e|/m<=v mu/m.
```

This proves `v>=alpha m/mu>m`: the forced owner is the smallest original
q-divisible speed, with the stated stronger separation. The norm bound is
valid even if its argument crosses an integer; no no-wrap hypothesis is
needed. If e=0, another q-divisible original speed would have norm zero and
is impossible. This neither introduces an absent speed q nor supplies any
new forced adjacency or determinant-one transition.

## Scope, bindings and actual checks

The first unresolved implication is an arithmetic saving for these genuine
completions, such as `B>=f-1`, or another admissible exchange using the full
minimality hypotheses. The pair windows and owner separation do not bound
all nonforced completion costs. Exact factorization and interval coloring
are proved; the required sharp arithmetic step and unrestricted LRC remain
open. No counterexample to the full minimum hypotheses is presented.

The complete author, including its final exact factorization (3a), was read
and checked independently by hand. Its eight bindings below were verified.
The forced-arc bridge and accepted review from the immediately preceding
task are also bound: they agree with the direct indispensability argument
above. All other bound mathematical sources and reviews were already fully
read in this same session and remain unchanged. Their prior programs and
whole audits were not rerun; no stronger joint-seed or bundle premise is used.

| Input | SHA-256 |
| --- | --- |
| `research/astra-forced-arc-completion.md` | `e48f80297a70e6630e76fe2b905ed86372383a5d170a539abccdba3decdd98a1` |
| `research/astra-coupled-descent-strategy.md` | `d9a029cb16c866a45741f97841f3b007d4823f86712fe827e899801208289bb2` |
| `research/astra-private-repair-review.md` | `a8aaec8468969723207dc12e9ff2c112a4560c1f51e97f13b43f4e342c849512` |
| `research/astra-minimal-frequency-synthesis.md` | `03cf038021f0bc1a2328bb77a02f6ab4fe649f5d3626d7bc368a67cd6c7b0000` |
| `research/astra-minimal-frequency-review.md` | `b26182c2e482e7f83480eab9904779b958eb8b8b753c70bc45c6fabec55b747d` |
| `research/astra-arithmetic-winding-exchange.md` | `6fbd8b96223e1697c33d5e187c25fb9f93707c880f2794892dfa16ca0ab2d6d4` |
| `research/astra-arithmetic-winding-review.md` | `45eca69dd2c8b48a0cec68ca737262b9f1a616b08f85046629c9c4e632618243` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Current project config, workflow, policy and focused state were read. The
state recorded `research/in_progress`, explicit 2026-09-05 start authorization,
this task, its requested route, assignment checkpoint and sole owned file.
`python3 -B scripts/validate_workflow.py` exited 0 with complete output:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

Source readback matched all eleven displayed bindings. Final administrative
Python checks verified them, a final newline and no trailing whitespace,
and returned this review's frozen hash separately. The review was read back
in full. All commands exited 0; no mathematical error or author correction
was found. No mathematical program, enumeration, search, solver, build,
cache operation, external model, additional agent, Git mutation, shared-state
edit, memory write or other-file edit was performed. This is independent
manuscript acceptance, not a kernel-checked theorem or project completion.
