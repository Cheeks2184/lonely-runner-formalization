# Independent review of endpoint Euler and bad-arc graph arguments

Date: 2026-09-06. Task `/root/uniform_endpoint_euler_review`, executed by
`/root/uniform_screen_review`; requested Astra/xhigh. Runtime model, effort
and usage are not independently exposed. Root supplied checkpoint
`23c84a2cf28aeb6c9483d0ca08131aea0c901356`. Only this review file is owned.

**Accepted at manuscript scope.** The Euler identity, strict overlap count,
clique and edge arguments, lcm-family comparison, reflection equivalence and
conditional deletion coupling are valid. No correction is required in the
frozen manuscript. Their remaining supply obligations are explicitly open;
aggregate edge counting is not promoted to graph connectivity or to Q.

The complete author report was read. Actual SHA-256 values matched its four
source bindings and the dispatched manuscript:

```text
00f37303fc266b1843964293500a1be112e3a9d8439d3dcad65a662d60be1b25  research/astra-uniform-endpoint-euler-screen.md
0e3f10f64daf41bedebf31bb71cb6b93ffa5358615c6c30ec941b01fc97b9d57  LonelyRunner/EndpointCompleteness.lean
838a3bcec806b0e9d01cd117e64e5348de58a05127a3f7bef5dbe2d879ff292f  LonelyRunner/PairSumCompleteness.lean
3a4a825f3f801282eb39b469571bbd4cac3a4e1f768d58542b7c1555cd725524  research/astra-uniform-global-seed-geometry.md
8c4b6ee094f0f311f360d3abf371e95f731e28cee997d3810dd3218ff6f25746  research/astra-uniform-divisor-minimality.md
```

The endpoint and pair-sum declarations were inspected, including their exact
positivity, count and closed-margin assumptions and the canonical equivalence.
They convert supplied witnesses; they do not establish uniform endpoint or
pair-sum supply. The prior prime and lcm family proofs were checked against
their unchanged bound sources. The reviewer did not author the new report;
its attribution of the clique/reflection suggestions to root is explicit.

**Euler cells and contacts.** For `n=N-1>=3`, one has `0<delta=1/N<1/2`.
The event partition is finite, and the added cut at zero identifies one
circle point, not two interval endpoints. Refining an open cell replaces
its contribution `-1` by `-1+1-1`, preserving the valuation. In particular
`chi(T)=0`, whereas every nonempty proper closed interval and singleton has
value one. Since `H` excludes a neighborhood of zero, its Euler value is
exactly its number of components, including isolated points.

At an actual threshold event, strictly bad labels stay bad on both nearby
arcs. A rising contact is bad just before the event; a falling contact is
bad just after it. Therefore the displayed formulas for `h`, `h_minus` and
`h_plus` follow without treating simultaneous labels independently. Each
open arc contributes once to either oriented sum, or twice with weight
`-1/2` to the symmetric sum. This proves all three identities in (2).
A mixed contact with no strictly bad label contributes exactly one, regardless
of how many labels touch on each side. Pure rising and falling contacts give
the two half contributions at a positive-length component's endpoints.
The cut at zero contributes zero.

The oriented term `h-h_minus` is exactly the indicator of a feasible rising
event. Thus its positivity asks for the same endpoint supply as the existing
completeness theorem. Ordinary signed jumps sum to zero and miss singleton
witnesses. Copying an adjacent arc value onto a half-open cell likewise
requires the stated point correction to recover the closed set.

For opposite contacts, multiplying the two phase equations eliminates t
and gives `N(v_i k_j-v_j k_i)=v_i+v_j`; adding them gives
`t=(k_i+k_j)/(v_i+v_j)`. At `0<t<1` its integer numerator is strictly
between zero and the denominator. Same-oriented contacts instead force
divisibility of the speed difference by N. These necessary identities do
not exclude another strictly bad label at the same event.

Euler integration is not order preserving: each positive indicator of a
single speed's bad set has integral `-v_i`. Hence the pointwise inequality
`1_H>=1-K` supplies no corresponding Euler lower bound. For the prime family
`(1,...,N-1)`, `N>=5`, circle packing gives exactly `N-1` full-good points,
while the proposed lower bound is `N(N-1)/2`. The inequality fails strictly.
The bound global-geometry proof supplies every deletion seed and the exact
pivot-1 score delta. This is a control against the Euler inequality, not a
counterexample to Q or a tuple satisfying Q failure.

**Arc geometry and clique identity.** Each speed contributes `v_i` disjoint
proper open arcs. Graph components and components of their union coincide:
overlap chains give connected unions, and different graph components give
disjoint relatively open pieces. For distinct positive speeds a,b, the sum
of the two arc lengths is at most `3/N<1`. Cutting outside their union turns
them into intervals, proving that a nonempty pair intersection is connected.
Intersecting the resulting subintervals inside any one arc proves the same
for every finite nonempty intersection.

Every such intersection has Euler value `-1`. Finite inclusion-exclusion
and `chi(T)=0` therefore give `chi(H)=C_1-C_2+C_3-...` with the stated signs.
A clique contains at most one arc of each speed. Distinct positive integers
give total clique-arc length at most `2 H_(N-1)/N<1`, where H here denotes
the harmonic number. Explicitly `2 H_3=11/3<4`, and
`2 H_N=2 H_(N-1)+2/N<N+1` proves the induction. A cut outside the clique
union makes it a finite pairwise-intersecting family of open intervals,
which has a common point. Thus the C_r really are graph clique counts;
there is no independently chosen phase or unproved circular Helly premise.
The report's `N>=4` scope is retained for these strict length estimates.

**Strict pair count and connected-graph bound.** The homomorphism
`(k,l) -> b k-a l (mod ab)` from `Z/aZ x Z/bZ` has image the multiples of
`g=gcd(a,b)` and fibers of size g. With `L=ab/g` and `T=(a+b)/(N g)`, an
edge is exactly a centered residue of `Z/LZ` whose distance is less than T.
The inequality `T<L/2` follows from
`2(1/a+1/b)<=3<N`. Hence these residues number `2 ceil(T)-1`, giving
`g(2 ceil(T)-1)` edges between the two colours. At integer T, both boundary
residues are excluded. Touching open bad arcs therefore create no edge,
as required for the closed witness threshold.

If `H` is empty, the union is the connected circle, so G is connected.
The n distinct origin arcs form an actual `K_n`. Contracting it leaves
`V-n+1` vertices and requires at least `V-n` additional edges. Restoring the
clique gives `E>=V-n+choose(n,2)`. This is only necessary for connectivity
and therefore for absence of all full witnesses. Its strict violation
supplies a full witness. It is not a necessary condition established for
Q failure, which permits full witnesses outside the protected union.

**Uniform lcm control.** Write `L_N=lcm(2,...,N)` and `v_i=L_N+i` for
`0<=i<n=N-1`, with `N>=5`. Since `N(N-1)` divides L_N,
`V>=N n^2`. Also `gcd(v_i,v_j)<=j-i`, so their pairwise gcd sum is at most
`n(n^2-1)/6`. The exact ceiling formula yields

```text
E >= 2(n-1)V/N-n(n^2-1)/6.
```

Subtracting the connected-graph threshold leaves coefficient
`(n-3)/(n+1)>0` on V. Substituting `V>=(n+1)n^2` gives precisely

```text
E-[V-n+choose(n,2)] >= n(5n^2-21n+10)/6 > 0.
```

The quadratic is 6 at `n=4`, and its next-value difference is `10n-16>0`
thereafter. This is an arbitrary-N proof, not sampled evidence. The same
family's time `1/(2L_N)` has all norms
`1/2-i/(2L_N)>(n-1)/(2n)>=1/n`, so it supplies every deletion seed and a
full witness. It contains an even speed. Accordingly its actual graph is
disconnected by the next lemma, despite passing the aggregate edge bound.
No connectivity or zero-Euler claim is inferred from that bound.

**Reflection and colour deletion.** With an even speed, both zero and 1/2
belong to U. Reflection preserves H. Any full witness has a reflected
representative `0<t<1/2`; the omitted points t and `1-t` separate zero from
1/2. Since U contains both latter points and neither separator, U and G
are disconnected. The converse needs no parity: disconnected G cannot have
the whole circle as its union. This proves (7). In the all-odd case 1/2 is
a full witness, but this disconnection equivalence is not asserted.

After removing colour p, the graph describes the retained bad union at the
unchanged margin `delta=1/N`. A supplied gamma seed is an old delta witness.
The reflection proof only needs the margin and an even retained speed, so
it applies without falsely identifying this delta with the retained tuple's
own margin. Under `H=empty`, G is connected but each such colour-deleted
graph is disconnected. Two original even speeds cover every deletion; with
exactly one even speed, only deleting an odd speed is covered by this claim.
This coupling uses absence of full witnesses, not merely failure of Q.

**Exact unresolved obligation.** Endpoint Euler positivity still requires
an actual event with no strictly bad label. In the even-speed graph case,
ordinary witness supply is exactly the unproved disconnection statement.
No bound on the higher clique terms sufficient to force positivity, or
contradiction from all applicable colour deletions, has been supplied.
For Q, the target is instead
`chi(H intersect B)>0`; replacing it by `chi(H)>0` loses the protected-location
requirement. These limitations do not rule out future arguments using more
of the endpoint, clique or colour-cut structure.

**Actual checks.** Current project config, workflow, policy and focused state
were read. The standalone command `python3 -B scripts/validate_workflow.py`
exited 0 with complete output:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

The source-hash checks exited 0. All new reasoning was checked algebraically
as displayed above. No mathematical program, enumeration, Lean command,
dependency/cache operation, Git command or shared-state mutation was performed.
No other file was edited and no worker was delegated. This independent
manuscript acceptance does not constitute a new kernel-checked result.
