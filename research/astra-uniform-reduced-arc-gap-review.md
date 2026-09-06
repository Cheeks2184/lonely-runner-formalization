# Independent review of reduced arcs and neighboring gaps

Date: 2026-09-06. Task `/root/uniform_reduced_arc_gap_review`, executed by
`/root/uniform_screen_review`; requested Astra/xhigh. Runtime model, effort
and usage are not independently exposed. Root supplied checkpoint
`970295eb9ebe88498b3faa9831bac775548a7b43`. Only this review file is owned.

**Accepted at manuscript scope.** The canonical reductions, containment
criterion, periodic endpoint order, closed-gap decomposition and determinant
test are sound. Both uniform control families satisfy their claimed
hypotheses. No correction is required. The uniform existence of a surviving
neighboring pair passing the test remains unresolved.

The entire author report was read, and the actual source hashes matched:

```text
44dcb9cbc12443efb284cea86f91531d24b6abfd5718969bea9c6a2f0735e8ea  research/astra-uniform-reduced-arc-gap-screen.md
5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c  LonelyRunner/StructuredClasses.lean
00f37303fc266b1843964293500a1be112e3a9d8439d3dcad65a662d60be1b25  research/astra-uniform-endpoint-euler-screen.md
8c4b6ee094f0f311f360d3abf371e95f731e28cee997d3810dd3218ff6f25746  research/astra-uniform-divisor-minimality.md
```

The reviewer did not author the mathematical input. The relevant current
`minimumScaleResidueBands` declaration was inspected: it accepts real speeds,
a positive base, `n>=2`, and closed normalized absolute-value bands, and
returns the stated explicit witness. For positive speeds with
`max(v)<=n min(v)`, taking the base to be `min(v)` and every band index zero
does give the manuscript's existing first-center witness. It is not new
uniform supply. The earlier arc conventions and lcm family were checked
against their unchanged bound sources.

**Coincident centers and containment.** The count convention is
`n=N-1>=3`, with distinct positive integer speeds and `delta=1/N`.
A rational center in lowest terms `a/q` occurs among a speed's centers
exactly when q divides that speed. For q=1 the sole center is `0/1`;
`phi(1)=1` correctly includes it once. Thus the distinct-center count is
`sum_(q in D) phi(q)`. The widest arc at such a center has owner
`m_q=min{v_i:q divides v_i}`, with integer `e_q=m_q/q>=1`. Removing the
other arcs at that same center preserves the open bad union exactly.

All remaining arcs form a finite nonempty family. Keeping its inclusion-
maximal members preserves the union, since every member is contained in a
maximal one. Distinct centers cannot define the same open ball of these
radii, so this maximal family has no representative-choice ambiguity.

For `u<v`, write `d=min_z |v k-u l-zuv|`. The circle-center distance is
`d/(uv)`. Because the outer radius is at most `1/4`, containment of the
smaller open ball is equivalent to center distance plus inner radius being
at most the outer radius. Sufficiency follows from the triangle inequality;
necessity follows by approaching the inner endpoint away from the outer
center in a local interval lift. This gives exactly

```text
d/(uv)+1/(Nv)<=1/(Nu)  iff  N d<=v-u.
```

Equality is valid: the shared endpoint belongs to neither open interval.
For distinct centers d is a positive integer multiple of `gcd(u,v)`.
Consequently `v-u>=N gcd(u,v)>=N` is necessary, while the displayed test
remains the exact criterion for the specified centers. Equal radii at
distinct centers cannot contain each other. In particular, spread less
than N excludes every further distinct-center removal. No all-or-none
survival rule for the numerators of one denominator is assumed.

**Ordered endpoints and the circle cut.** On the periodic lift, a reversal
or equality of left endpoints for two increasing centers would put the
earlier interval inside the later one. A reversal or equality of right
endpoints would give the opposite containment. Projection contradicts
maximality. Repeated lifts of the same arc have endpoints translated by a
positive integer, so they cause no exception. Hence both endpoint sequences
are strictly increasing, including across the chosen period cut.

For `R_i<=L_(i+1)`, all earlier arcs end at or before R_i and all later
arcs start at or after L_(i+1). Thus the entire closed gap lies outside
every open arc, including translated arcs. Conversely, a full-good point
cannot be a surviving center. Between two consecutive centers it must lie
at or to the right of R_i and at or to the left of L_(i+1). This proves
the exact decomposition in (3). The bad neighborhoods of the intervening
centers separate different nonempty gaps, so these are precisely the
connected components. Equality gives one isolated witness. The reasoning
also handles a one-member maximal family and its periodic copy.

For consecutive surviving fractions `a/q<b/r`, including translated
numerators at the cut, `h=bq-ar` is a positive integer. Their gap is
nonnegative exactly when

```text
h/(qr) >= 1/(N m_q)+1/(N m_r)
        iff N h e_q e_r >= m_q+m_r.
```

All multiplied denominators are positive. Equality retains the closed
witness, and no determinant-one or full-Farey-neighbor property is needed.
This statement is valid for neighbors after both reductions; applying it
earlier would omit the containment hypothesis that orders the endpoints.

**Actual control before containment pruning.** For `N>=6`, the tuple
`(1,2,...,N-2,3N+1)` has exactly `N-1` distinct positive speeds. Put
`v=3N+1`. Its centers `1/v` and `2/v` precede every positive center of a
slower speed, since `2/v<1/(N-2)`. If `2/v` reduces, its denominator is
`v/2>N-2`, so its owner and radius remain v and `1/(Nv)`.

Their apparent gap has positive length `(1-2/N)/v`. Its upper endpoint
is `(2N-1)/(Nv)<1/N`, and its lower endpoint is positive; speed 1 is
strictly bad throughout. Both fast arcs are contained in the origin arc:
for their centered distances the integer tests are `N<=v-1` and
`2N<=v-1`. Thus the removed nonneighbor really blocks the proposed gap.

At `1/(N-1)`, the slow speeds have the nonzero residues `1,...,N-2` and
the fast speed has residue 4. The condition `N>=6` ensures
`1<=4<=N-2`, so every norm is at least `1/(N-1)`. Every deletion seed is
therefore supplied at an actual common time. This refutes the earlier
gap test's geometric inference, not full witness supply or the pruned test.

**Total length and the lcm block.** The periodic center increments sum to
one. Each radius is subtracted twice, giving exactly
`sum_i(L_(i+1)-R_i)=1-T_*`. Thus `T_*<=1` forces a nonnegative individual
gap, including the equality case, while `H=empty` forces every gap negative
and hence `T_*>1`. The pre-containment length is `T_0=2A/N`, with
`A=sum phi(q)/m_q`, and `T_*<=T_0`. The claimed sufficient condition
`A<=N/2` and necessary condition `A>N/2` for absence of H follow with
the stated directions. Neither is asserted as a necessary condition for
failure of Q.

For the block `v_j=L+j`, `0<=j<n=N-1`, `L=lcm(2,...,N)`, `N>=5`, its
spread `n-1=N-2<N` excludes distinct-center containment. Therefore
`T_*=T_0`. Processing owners from slowest to fastest, a center first
introduced by v_j contributes exactly `1/v_j` to A. The intersection of
two center sets has `gcd(v_i,v_j)` elements. The union bound on previously
seen centers consequently gives

```text
A >= n-sum_(i<j) gcd(v_i,v_j)/v_j
  >= n-n(n^2-1)/(6L).
```

Here gcd divides `j-i`, and summing those differences gives
`n(n^2-1)/6`. Since `n(n+1)=N(N-1)` divides L, the bound reduces to

```text
A >= (5n+1)/6,
T_* >= (5n+1)/(3(n+1)) > 1.
```

The strict final comparison is equivalent to `n>1`, so the stated `n>=4`
range is safely covered. At `t=1/(2L)`, the exact norms are
`1/2-j/(2L)>(n-1)/(2n)>=1/n`. This supplies all deletion seeds and a full
strict delta witness. Continuity gives a positive-length component of H,
hence a positive individual gap, even though the sum of the signed gaps
is negative. Passing an aggregate obstruction is not interpreted as an
all-negative-gap or connectivity statement.

These controls invalidate the proposed universal total-length shortcut.
They do not refute a different weighting, an individual-gap argument, or
a harder residual that also excludes the already understood minimum-scale
case. Their explicit witnesses remain consistent with the earlier arithmetic
profile and with the purpose of this scope screen.

**Exact unresolved obligation.** One must still prove that every relevant
tuple has a surviving neighboring pair with
`N h e_q e_r>=m_q+m_r`, or derive this under a least-counterexample profile
that leads to contradiction. The reductions and coincidence counts do not
supply such a pair. A witness obtained this way is an ordinary full witness;
membership in a protected deletion-seed ball would require an additional
argument to establish Q. No new Lean or unrestricted result follows from
the present exact checking reformulation.

**Actual checks.** Current project config, workflow, policy and focused state
were read. The standalone command `python3 -B scripts/validate_workflow.py`
exited 0 with complete output:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

The source-hash checks exited 0. All mathematical checks were algebraic and
are recorded above. No mathematical program, enumeration, Lean command,
dependency/cache operation, Git command, shared-state mutation or delegation
was performed. Only this owned Markdown review was created; concurrent
files and prior frozen reviews were preserved.
