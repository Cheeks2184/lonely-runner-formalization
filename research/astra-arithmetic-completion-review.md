# Independent review of coincident-center completion saving

Task `/root/arithmetic_completion_review`; reviewer session
`/root/coordinate_cancellation_review`; assigned source checkpoint
`4675bc0877fe732e0fd42946cc46154f09bda807`. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed time, and usage: `null`.
Only this review is owned.

**Accept the complete frozen manuscript at the hash below, without a
mathematical correction.** Its positive result is a safe arithmetic deletion
and an exact cost for a constructed completion. Its conditional obstruction
charges the third-and-later coincidence saving against full multiplicity.
Its explicit consecutive-speed control proves an exact minimum at widths
above the native threshold. These are manuscript conclusions, not kernel
theorems, an actual strict-failure example, or unrestricted LRC resolution.
This acceptance covers the frozen C_3 bound; it does not incorporate any
separate stronger charging argument.

## Hypotheses and the reused completion interface

For the first part, V has n>=3 positive distinct primitive integer speeds
and is a hypothetical ordinary strict failure, chosen by least moving count
and then least primitive sum. Write N=n+1, alpha=1/N, and
`0<mu=max_t min_(v in V)||vt||<alpha`. The complete original open arcs
`A_(v,k)={t:dist_T(t,k/v)<alpha/v}`, k modulo v, cover T=R/Z.
Each costs 1/v, so their total cost is n. Same-speed arcs are disjoint.

The unchanged accepted completion source and review identify F exactly with
the individually indispensable original arcs. In particular, every A in F
has an actual private point inside its closed mu-core and outside every
other original open arc. This uses the full deletion-good set, not just a
chosen extremizer or a residue center. Conversely, a uniquely covering arc
has its point in that deletion-good set, so is forced. Least count supplies
at least one forced arc per original speed.

Choose one private point for each forced arc. Their cyclic ordering gives
at least n>=3 distinct points. No nonforced arc can contain any of them;
connectedness places that entire open arc inside one cell between consecutive
private points, with endpoints possibly on its boundary. Only the two
neighboring forced arcs can enter a cell. If their tails overlap its gap is
empty; otherwise the uncovered part is the closed interval from the left
tail's right endpoint to the right tail's left endpoint. Equality gives a
singleton. Every point of this gap is covered by at least two nonforced
original arcs: a unique covering arc would be forced. This includes both
endpoints, where the forced open tails are absent.

Thus a cover must include F and cover each gap independently. Finite local
minimum costs kappa_j exist and give the exact global minimum
`f+sum_j kappa_j`, where f=cost(F). This factorization and the two-color
lemma are the actual invoked parts of the prior source; no new conclusion
from its separate determinant analysis is needed here.

## Safe pruning and its exact cost

Fix one circular center c and order all its actual owning speeds
`a_1<...<a_r`. Their arcs are strictly nested, with outer arc a_1. Any inner
arc is contained in this other original arc and cannot have a private point,
so only a_1 can be forced. Two cases exhaust the pruning:

* If a_1 is forced, no point of any completion gap lies in it, and therefore
  none lies in an inner arc. All inner arcs can be removed without affecting
  any gap, even at a boundary of the forced open arc.
* If a_1 is not forced, all arcs of this chain are nonforced. At any point,
  membership is a prefix of the chain. This remains true when the point is
  exactly an open endpoint: the corresponding arc and all smaller inner
  arcs are absent. Keeping the first two arcs therefore replaces its local
  multiplicity m_c by exactly min(2,m_c).

At a gap point the first kind of chain contributes zero. If the sum of the
other original multiplicities is at least two, then the sum of their
truncations is still at least two: either one contribution was at least two,
or two positive contributions survive. The proof is pointwise on the closed
gap, so it loses neither endpoints nor singleton gaps. Every retained arc
remains an original arc in its original cell. All nonforced arcs with one
center share a cell because they contain that center and avoid every
private point. No arbitrary singly dominated interval is deleted across
different centers or colors.

Every index of depth at least three is removed once; a depth-two index is
additionally removed exactly when its outer ancestor is forced. Thus

`C_3=sum_c sum_(s>=3) 1/a_s(c)`,
`C_(2,F)=sum_(c forced, r_c>=2) 1/a_2(c)`,
`S_c=C_3+C_(2,F)`, `R=n-f-S_c`.

These are exact costs, including forced-center tails in C_3 only once. The
zero center belongs to every speed, so
`C_3>=sum_(s=3)^n 1/v_(s)>0`. At a reduced center of denominator q, the
owners are precisely the original speeds divisible by q. There are phi(q)
such centers, taking phi(1)=1 for zero. This is a divisibility description
of the finite lists, not a numerical enumeration or a replacement of an
actual speed by its reduced denominator.

For completeness, the interval coloring works after this pruning. Process
increasing left endpoints and assign an interval to the color with the
smaller current largest right endpoint. If the two maxima are s<=t and the
new right endpoint is b, the new pair is s,t for b<=s, b,t for s<b<=t, and
t,b for b>t. These are the two largest processed right endpoints, counting
multiplicity and initially padding with minus infinity. At a point x, take
the prefix with left endpoints strictly below x. Double coverage means its
two largest right endpoints are strictly above x, hence both colors cover x.
Ties, nesting, and open endpoint exclusions are handled by these strict
tests. Each color therefore covers the entire closed gap in its cell.

With remaining color costs c_j^0,c_j^1 and
`B_c=sum_j |c_j^0-c_j^1|`, the cheaper class in each cell gives an actual
original-grid cover of exact constructed cost

`f+sum_j min(c_j^0,c_j^1)=(n+f-S_c-B_c)/2`.

If the original cell cost is d_j and removed cost is s_j, its remaining
cost is d_j-s_j=c_j^0+c_j^1. Hence
`kappa_j<=(d_j-s_j-|c_j^0-c_j^1|)/2`. The formula is an upper bound on the
local minimum, not a claim that the coloring is a weighted optimizer.
For an empty gap, retaining a cheaper color is unnecessary but still valid.

The manuscript's additional scan certificate is also correct. At a
nonforced center, a third or later arc has both outer ancestors processed
earlier, with strictly larger right endpoints. The two current color maxima
are therefore both larger than its right endpoint. Whichever color receives
it already has an interval starting no later and ending later, containing
it. Forced ancestors are outside that nonforced scan and instead use the
separate gap-disjointness proof above.

## The conditional excess-multiplicity obstruction

Here M is the multiplicity of the full original family, not F or the pruned
family. If x,y>=0, then
`(x+y-2)_+ >= (x-2)_+ + (y-2)_+`: if both exceed two the difference is two;
if only one exceeds two the other adds a nonnegative amount; if neither
exceeds two the right side is zero. Induction applies to all center counts.
Nestedness gives pointwise
`(M_c-2)_+=sum_(s>=3) 1_(A_(a_s,c))`, including their open boundaries.
Integration consequently yields

`T_3=integral (M-2)_+ >= sum_c integral (M_c-2)_+ = 2alpha C_3`.

This inequality retains, rather than discards, possible excess from
interactions between different centers. Since actual strict failure gives
M>=1 everywhere and integral M=2n alpha,
`1_(M=1)=2-M+(M-2)_+` integrates to
`P=measure{M=1}=2alpha+T_3`. Every such point is in its uniquely covering
forced arc's mu-core. Summing core lengths therefore gives P<=2mu f;
no assertion that all core points are private is needed.

Put rho=mu/alpha<1 and E=T_3/(2alpha)-C_3>=0. Division by 2alpha and
rearrangement give exactly

`rho f>=1+C_3+E`,
`f-1-C_3 >= (1-rho)f+E > 0`.

Strictness follows from f>0 and rho<1. Thus C_3 alone cannot reach the
required saving f-1 in a hypothetical actual failure. This conclusion does
not itself rule out a contribution from C_(2,F), B_c, or a better exact
completion. Indeed any finite open alpha-cover has cost strictly above
N/2: an endpoint of one chosen proper arc is covered by another open arc,
forcing positive-length overlap in a circle cover. For the constructed
cover this demands S_c+B_c<f-1. An arithmetic proof of the reverse weak
inequality would give a contradiction; none is present in the frozen source.

## Exact all-n consecutive-speed control

Independently use V_n={1,...,n}, n>=3, with
`alpha_n=1/(n+1)<a<1/n`. A shortest cyclic gap among 0,t,...,nt has length
at most alpha_n. If two points coincide, an available nonzero difference
speed has norm zero; otherwise the difference between the two gap indices
is in {1,...,n} and has norm at most the gap. At t=1/(n+1) all speeds have
norm at least alpha_n. Thus the exact maximum is mu(V_n)=alpha_n, and the
complete open a-family covers T.

An indexed arc with nonprimitive center k/v reduces to r/q with q<v and
q in V_n. It lies in the larger original q-arc at that center, so is not
forced. Each primitive-center q-arc has the following actual private point:

* For q>n/2, use its center k/q. No other original speed is divisible by q.
  Since k and q are coprime, every other norm is at least 1/q>=1/n>a.
* For q<=n/2, use t=k/q+a/(2q) modulo one. Its q-norm is a/2<a. For
  another multiple v=rq with r>=2, the phase after removing the integer rk
  is r a/2. It satisfies `a<=r a/2<=n a/(2q)<1/(2q)<=1/2`, so its norm
  is exactly that phase and is at least a, with no integer wrap. For a
  nonmultiple v, coprimality and the circle norm Lipschitz estimate give
  `||vt||>=1/q-v a/(2q)>=1/q-n a/(2q)>1/(2q)>=1/n>a`.
  At q=1 the nonmultiple case is empty, and the multiple calculation covers
  every other speed. Equality at a for v=2q correctly excludes its open arc.

Thus every listed primitive arc is indispensable, and these are all the
forced arcs. Each nonprimitive arc is contained in its forced primitive
ancestor, so this forced family already covers. Its exact cost and the exact
minimum among all original indexed open subcovers are

`f_n=sum_(q=1)^n phi(q)/q`, with phi(1)=1.

Every center here has a forced outer ancestor. Structured pruning removes
all nonforced arcs, giving S_c=n-f_n, R=B_c=0 and all kappa_j=0. This also
recovers 1+1/2+2/3=13/6 when n=3 without inspecting subfamilies.

At the closed canonical width alpha_n, the same primitive index family
still covers: first use the maximum to get the complete closed cover, then
contain every nonprimitive closed arc in its primitive ancestor. The two
primitive arcs centered at 1/n and 1/(n-1) have separation
`d=1/[n(n-1)]`, radii alpha_n/n and alpha_n/(n-1), and radius difference
alpha_n d<d. Their sum of radii exceeds d by exactly

`ell=(n-2)/[(n+1)n(n-1)]>0`.

They neither contain one another nor wrap at zero: both lower endpoints
are positive and the larger upper endpoint is
`(n+2)/[(n+1)(n-1)]<=5/8<1`. Hence ell is their actual overlap length.
The full primitive closed cover has multiplicity at least one everywhere
and at least two on this interval. Integrating gives

`2alpha_n f_n>=1+ell`,
`f_n>=(n+1)/2+(n-2)/[2n(n-1)]>(n+1)/2`.

If any deletion/color construction removes cost D from the nonforced budget
n-f_n, its remaining color imbalance is at most its remaining total cost
n-f_n-D. Thus D+imbalance<=n-f_n, even before imposing additional safety
requirements. The required saving f_n-1 exceeds that entire budget by

`2f_n-n-1 >= (n-2)/[n(n-1)]>0`.

This verifies the quantitative shortfall without totient asymptotics or
enumeration. All closed/open distinctions matter: the primitive family
covers closed at alpha_n and open throughout the stated interval above it.

## Falsification scope and first unresolved implication

The prior prime control already gave every deletion's own-margin witness
and no cheap subcover for n=p-1, p>=7 prime, on a common positive interval
above alpha_n. Its own-margin witnesses and the earlier exact n=3 cost are
unchanged accepted evidence. The present proof adds an exact primitive-arc
classification and exact totient minimum for every n>=3 on the whole
interval alpha_n<a<1/n. It does not claim own-margin deletion witnesses or
least-count minimality uniformly in this larger family.

The consecutive tuple has absolutely smallest sum among n distinct positive
integers. Every smaller positive replacement of a coordinate is already a
retained label and is good on that coordinate's full deletion-good set.
These fixed-count least-frequency conditions hold, but there is no fresh
smaller replacement and no native strict failure: mu=alpha_n with an actual
closed canonical witness. At the native threshold rho=1, so the strict
rho<1 conclusion above cannot be applied. Replacing alpha_n by the larger
test width a would also change the identity 2-2n alpha_n=2alpha_n.

The control therefore refutes a saving implication based only on the full
grid, forced positions, exhaustive same-center pruning, and those
fixed-count minimum-frequency conditions. It does not refute an implication
using native strict failure and its complete minimality profile essentially.
The first unresolved implication remains a bound supplying the additional
cost saving in actual private cells: for this construction one would need
`C_(2,F)+B_c>=f-1-C_3`, or a sufficiently strong alternative bound on the
exact sum of kappa_j. The frozen source supplies neither. There is no new
LRC proof/disproof, conditional Lean module, or runner-count ladder here.

## Source bindings and actual checks

The full author text was read and independently checked as above. Its ten
input bindings were verified unchanged. Prior full reads and accepted
reviews of those inputs were reused; the invoked completion sections and
the prime-progression source were read again at their stated scope, without
repeating prior computations or promoting unrelated results.

| Input | SHA-256 |
| --- | --- |
| `research/astra-arithmetic-completion-saving.md` | `abfb14f274fb5c72461ce884b7fc44fb89367e056091f628933a601f52a33403` |
| `research/astra-forced-arc-completion.md` | `e48f80297a70e6630e76fe2b905ed86372383a5d170a539abccdba3decdd98a1` |
| `research/astra-forced-completion-review.md` | `8e72687760576dc0e8524ecbae0bad81bcf3e8cd33f180219848da86a23adb02` |
| `research/astra-coupled-descent-strategy.md` | `d9a029cb16c866a45741f97841f3b007d4823f86712fe827e899801208289bb2` |
| `research/astra-private-repair-review.md` | `a8aaec8468969723207dc12e9ff2c112a4560c1f51e97f13b43f4e342c849512` |
| `research/astra-prime-progression-cover-cost.md` | `e5e26e0cffff1031dd1b14cd88f127ac5b624c2c798d22b0d0baa51e89a7ccd7` |
| `research/astra-cover-selection-review.md` | `a0fe2ed43372520ac30caec3844bbc90dc145089a8ba9113be4bba8b9bbab770` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Current configuration, workflow, policy, and focused live state were read.
The gate was research/in_progress with explicit start authorization at
`2026-09-05T04:12:25.208107+00:00`; the active review task recorded the
requested route, source checkpoint, and this sole owned file. Observed
runtime metadata remained null. `python3 -B scripts/validate_workflow.py`
exited 0 with `workflow structural validation passed; it cannot certify
mathematical validity.` The final workflow check and byte/hash/format checks
are administrative checks, separate from the hand proofs in this review.

All eleven source bindings were checked with `sha256sum` and final byte-hash
comparison. The full owned review was read back. Only this review was written;
the author and other inputs were preserved. No mathematical program,
enumeration, solver, build, Lean/cache operation, additional agent, external
model, Git mutation, shared-state edit, or memory write was used. One combined
read exceeded the display budget; the affected workflow and policy text was
reread completely in bounded output. No mathematical error or requested
author correction occurred. The review's final frozen SHA-256 is returned
separately so it does not hash itself.
