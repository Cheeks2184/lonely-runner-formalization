# Independent review of arithmetic winding exchanges

Task `/root/arithmetic_winding_review`, executed in the existing
`/root/coordinate_cancellation_review` session. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed time and usage: `null`.
Assignment checkpoint: `0f92e9a2f29ab5beccc22059baa916a2f82ce897`.
Only this review is owned. The author remains unchanged.

**Accepted at manuscript scope, with no mathematical correction required.**
The cyclic block gap, strict original-grid replacement criterion, winding
identity, conditional primitive-label contradiction and complete fourteen-arc
control are valid. The control refutes unrestricted optimal-cover uncrossing;
it does not satisfy strict failure. No implication supplying unit determinants
under actual minimal failure, unrestricted LRC theorem, or refutation of (E)
has been established.

## Hypotheses and all cyclic block cases

Let `n=N-1>=3`, with positive distinct primitive integer speeds. Assume a
strict failure chosen by least moving count and then least speed sum, and
choose `mu<delta<alpha=1/N<=1/4`. Count minimality supplies each deletion's
own margin `1/n`; rescaling a deletion by its gcd does not alter witness
existence. Height minimality supplies no exchange permission by itself.
The geometry below uses the actual complete family

```text
A_(v,k)={t mod 1 : dist_T(t,k/v)<delta/v},  0<=k<v.
```

It covers because `delta>mu`. A minimum reciprocal-cost subcover exists by
finiteness, and every selected arc is indispensable because every cost `1/v`
is positive. Consequently no selected arc is contained in another, and no
two selected centers coincide. This does not justify deleting contained
arcs from the complete candidate family before optimizing cost.

There is at most one original arc with label 1; every other arc has reciprocal
label at most `1/2`. Thus any three distinct arc indices have reciprocal sum
at most `1+1/2+1/2=2`, even when two indices have the same label. Their total
length is at most `4delta<1`. In particular at least four arcs are needed to
cover. If three selected arcs met, a point outside their union would cut them
into real intervals. After excluding containment, both endpoint orders agree;
the middle interval is contained in the union of the outer two, which overlap
at the common point. It could be removed. This proves absence of triple
intersection from irredundancy, with no circular Helly assumption.

Order the selected centers and extend periodically, with `m>=4` selected arcs:

```text
c_j=k_j/a_j,  ell_j=c_j-delta/a_j,  r_j=c_j+delta/a_j,
c_(j+m)=c_j+1,  ell_(j+m)=ell_j+1,  r_(j+m)=r_j+1.
```

Both endpoint sequences are strictly increasing: any reversal or equality
between two centers' left or right endpoints would contain one interval in
the other. Coverage forces `ell_(j+1)<r_j`, including across the period cut.
The absence of triples forces `r_(j-1)<=ell_(j+1)`. Equality is allowed,
because both exterior intervals omit their common boundary point.

Remove a nonempty proper block `p,...,q`, so `p<=q<=p+m-2`. All retained
adjacencies still overlap except at that block. Hence their complement is
exactly the projection of the closed interval

```text
G=[r_(p-1),ell_(q+1)],   g=ell_(q+1)-r_(p-1),
z=(ell_(q+1)+r_(p-1))/2,   C=sum_(j=p)^q 1/a_j.
```

Here `g>=0`: use `r_(p-1)<=ell_(p+1)<=ell_(q+1)`. If `q>p`, the second
inequality is strict, so `g>0`. For `q=p`, equality gives precisely a single
private point, still omitted by every remaining open arc. Also
`ell_(q+1)<=ell_(p-1)+1<r_(p-1)+1`, so `g<1` and the interval projects
injectively. When all but one selected arc are removed, the right boundary
is the remaining arc's left endpoint one period later, and
`g=1-2delta/a_(p-1)>0`. These observations cover every proper block, including
wrapped blocks, without treating zero and one as different circle points.

## Exact grid exchange and the determinant conclusion

For any ORIGINAL speed `u` with `1/u<C`, its arc at a lifted grid center `h/u`
covers G exactly when

```text
u ell_(q+1)-delta < h < u r_(p-1)+delta,   h in Z.       (R)
```

Both inequalities are strict because G is closed and the replacement arc is
open. Conversely, a circle arc containing G lifts to an interval containing
this entire connected lifted G; its endpoints give (R). This remains true
for a singleton. Integers modulo u give exactly the original grid, not new
phases. Such a replacement cannot already be among the retained arcs, each
of which omits G. It would lower cost, so (R) contains no integer.

Its midpoint is `u z` and its half-width is `R=delta-u g/2`. If `R>0`, the
absence of an integer is exactly `||u z||>=R`; if `R<=0`, the window is empty
and the condition is automatic. Therefore the author's complete statement is

```text
||u z|| >= max(0,delta-u g/2)  whenever u is original and 1/u<C.
```

No strict decrease is available at equal cost. A nonempty window has length
`2delta-u g<=2delta<1`; positive length alone cannot ensure an integer.
For retained boundary arcs `k/a` and `l/b`, substitution into (R) gives exactly

```text
a h-u k < delta(a+u),   u l-b h < delta(u+b).
```

The signs, endpoint strictness, and original denominators are all correct.
This bound only concerns eligible speeds and can be smaller than delta;
it supplies neither a full delta witness nor the larger margin alpha.

For consecutive lifted selected centers `k/a<l/b`, let `D=a l-b k`.
Then `D` is a positive integer, adjacency gives `D<delta(a+b)`, and the
center gaps `D/(ab)` sum to one over the full cycle. If a reduced `h/q` lies
strictly in this gap, with positive denominator q, the positive integers

```text
U=a h-k q,   V=l q-b h
```

satisfy the exact identity `D q=b U+a V>=a+b`. Combining the inequalities
gives `q>1/delta>N`. Thus every reduced rational of denominator at most N
is a selected center. This argument uses the actual, possibly nonprimitive,
center representations and works for general D and the wraparound gap.

An actual center label need only be a multiple of its reduced denominator.
Directly, at reduced `h/q` with `q<=N`, a speed not divisible by q has
`||v h/q||>=1/q>=1/N>delta`. A divisible label can cover there only through
its exactly coincident grid center. This recovers the same divisibility
restriction, not N different labels.

If every consecutive ACTUAL determinant were one, however, `gcd(k,a)`
would divide the next determinant and hence equal one for every selected
arc. The selected centers `1/q` for `2<=q<=N` would then have actual labels
exactly q. Center zero is also selected, since only zero-centered original
arcs can cover zero at `delta<1/2`; its primitive representation forces label
1. Equivalently it is `1/1` in the next lift. This requires N distinct
original labels when there are only `n=N-1`. The conditional contradiction
is complete. The unit-determinant premise is the missing theorem.

## Independent global check of the complete control

For `(1,5,8)` and `delta=17/50<1/2`, the complete family has `1+5+8=14`
arcs. Same-label arcs are disjoint. The following exact norms force individual
arc indices in EVERY subcover:

| Point | Norms for labels `(1,5,8)` | Unique original arc containing it |
| --- | --- | --- |
| `3/10` | `(3/10,1/2,2/5)` | label 1, center 0 |
| `21/50` | `(21/50,1/10,9/25)` | label 5, center `2/5` |
| `1/2` | `(1/2,1/2,0)` | label 8, center `4/8` |
| `29/50` | `(21/50,1/10,9/25)` | label 5, center `3/5` |

Every nonowner norm in the table is strictly greater than `17/50`, and each
owner norm is strictly smaller. This checks all fourteen candidate arcs
without a subset enumeration. The four forced centers, including the next
lift of zero, are `0,2/5,1/2,3/5,1`; their gaps are `2/5,1/10,1/10,2/5`.
The gap divided by the sum of reciprocal endpoint labels is respectively
`1/3,4/13,4/13,1/3`, each strictly below `17/50`. Thus these four open arcs
cover, including the outer wrap transition. They are the unique minimum-cost
subcover, since every subcover contains them and every extra cost is positive.
Their exact cost is `1+2/5+1/8=61/40` and their actual determinants are
`2,4,4,2`. This proves global optimality over the complete family, not just
resistance to one local exchange. Even the two outer transitions, whose
center representations are primitive, have determinant two.

The middle arc really has label 8 and radius `delta/8`. Reducing its center
`4/8` to `1/2` does not change that label. Replacing it by an arc of speed 2
would introduce an unavailable speed, quadruple the radius, and change its
cost from `1/8` to `1/2`.

At width `1/3`, the same four CLOSED arcs cover: the outer radius sums equal
their gaps `2/5`, while the inner sums are `1/15+1/24=13/120>1/10`.
Therefore every real time has some norm at most `1/3`. At `t=1/3` all three
norms are exactly `1/3`, proving `mu=1/3`; the same time supplies every
deletion's own margin `1/3`. Nevertheless `mu=1/3>alpha=1/4` and the chosen
open width is above mu. The example is LRC-good and supercritical. It is not
a least-count or least-height strict failure, and cannot refute an exchange
theorem restricted to those additional hypotheses.

## Scope, bindings and actual checks

The first unresolved implication is from actual strict failure and all
permitted grid exchanges to primitive selected owners (or another sufficient
contradiction). The proved windows need not contain an integer; winding only
gives divisibility; replacing an original speed by a missing reduced
denominator would require an independent transport of failure. None of those
missing steps is supplied here. The auxiliary unrestricted uncrossing rule
is falsified, but its strict-failure restriction, LRC and (E) are not.

The complete author was read and checked independently by hand. Its six
bound inputs were read at the hashes below. The two current cover/strategy
inputs already had complete same-session review at their unchanged hashes;
that accepted receipt is included. The older colour-critical and endpoint
Euler sources and reviews delimit the invoked graph, winding and deletion
claims; their entire old audits were not rerun. In particular an abstract
cover is not an integer-speed failure, deletion after pruning need not
preserve the original union, and graph or Euler reformulations supply no
unrestricted witness by themselves.

| Input | SHA-256 |
| --- | --- |
| `research/astra-arithmetic-winding-exchange.md` | `6fbd8b96223e1697c33d5e187c25fb9f93707c880f2794892dfa16ca0ab2d6d4` |
| `research/astra-uniform-strategy-after-energy.md` | `ee253b7ade891196bdf213250badac0ddf5992937eba32b625dbc9adb79f506e` |
| `research/astra-prime-progression-cover-cost.md` | `e5e26e0cffff1031dd1b14cd88f127ac5b624c2c798d22b0d0baa51e89a7ccd7` |
| `research/astra-cover-selection-review.md` | `a0fe2ed43372520ac30caec3844bbc90dc145089a8ba9113be4bba8b9bbab770` |
| `research/astra-uniform-colour-critical-cover.md` | `84b7f417a73dd8e580300390a3e1081f61904ad1860215487f03f7c1a51e578f` |
| `research/astra-uniform-colour-critical-review.md` | `49e42ed76159de73c3e2fd568021c82942913f76d976a596544323e1ef1caed9` |
| `research/astra-uniform-endpoint-euler-screen.md` | `00f37303fc266b1843964293500a1be112e3a9d8439d3dcad65a662d60be1b25` |
| `research/astra-uniform-endpoint-euler-review.md` | `b3dd8f9923bd77814cff6c8171ca1a930df5058cbf123cdfe165ec9591102aec` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Current project rules and focused state were read. The state recorded
`research/in_progress`, the explicit 2026-09-05 start authorization, this
review's requested route, source checkpoint and sole owned file. The command
`python3 -B scripts/validate_workflow.py` exited 0 with complete output:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

`sha256sum` readback matched all twelve displayed bindings. Administrative
Python checked those bindings again, a final newline and absence of trailing
whitespace, and returned the frozen review hash separately. Long combined
source output was truncated; the omitted ranges were reread before acceptance.
There was no mathematical or command failure and no author repair request.
No mathematical program, enumeration, existing-computation replay, build,
cache operation, external model, new agent, Git mutation, shared-state edit,
memory write or other-file edit was performed. This is independent manuscript
acceptance, not a new kernel-checked theorem.
