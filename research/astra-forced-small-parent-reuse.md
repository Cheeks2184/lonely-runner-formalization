# Smaller-parent reuse: seed scope and an off-center accounting bound

Task `/root/forced_small_parent_reuse`; assigned checkpoint
`20ec10f1093b10962ddebd59732723c2ab3ff40e`. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed time and usage: null.
Only this manuscript is owned. These hand derivations await independent
review; they are not kernel theorems or an unrestricted LRC resolution.

A reused smaller parent joins consecutive **forced** maximum arcs, but
their integer indices need not be numerically adjacent by the present
argument. Numerical adjacency follows when either gap carries a stronger
deletion seed. For a larger index gap, the intervening original maximum
arcs lie inside the shared parent's contracted core. They can be omitted
from the coarse completion accounting. Their entire additional cost is
bounded by existing excess coverage, leaving a strictly positive deficit.
This refines that accounting without reducing the true cover optimum.

## 1. Exact hypotheses and indexed reuse

Assume a hypothetical canonical strict failure V of n>=5 distinct positive
primitive integer speeds, least by moving count and then primitive sum. Put

    N=n+1, alpha=1/N<=1/6, beta=1/n, m=max V,
    0<mu=max_t min_(v in V)||vt||<alpha, epsilon=alpha-mu,
    W_v={t:||ut||>=alpha for all u in V\{v}}, Q_v=max(V\{v}).

All sets live on T=R/Z. Use every original indexed open alpha-arc
`A_(v,j)=((j-alpha)/v,(j+alpha)/v)` in compatible real lifts, and every
collision K_v attained on the whole closed W_v. The forced family F is
exactly these attained arcs. Write `f=sum_v |K_v|/v`. The full closed
mu-family covers T, and the accepted all-coordinate contraction is

    ||vt||<=mu-v*epsilon/Q_v for every t in W_v.              (1)

Assume the all-zero branch at EVERY forced maximum arc. Its only retained
original arcs meeting it are its distinct left and right parents. With
their labels u,w and indices i,j, the accepted exact relations are

    u+w=m, i+j=k, D=u*j-w*i,
    alpha*m<=D<=mu*(m+min(u,w)).                              (2)

The maximum arc's left and right endpoints belong respectively to W_u and
W_w; the parents' near endpoints belong to W_m. All are actual original
indexed arcs. In particular the parents are forced. The bound predecessor
also excludes every other original m-arc from the larger parent's entire
open arc, using alpha<=1/6. No recursive argument on deleted families is
being assumed.

Let a fixed smaller parent B have label b, index l and endpoints

    P=(l-alpha)/b, Q=(l+alpha)/b.

Suppose B is the right parent of A_h and left parent of A_k. Its other
parent label in both configurations is `a=m-b>b`. Choose lifts through B.
Then P is strictly inside A_h and Q strictly inside A_k, and both are in
W_m. Same-m arcs are disjoint, so h<k. Put q=k-h. The endpoint separation
gives

    0<q<2alpha*m/b+2alpha<m.                                (3)

The last comparison uses b>=1, alpha<=1/6 and m>=n>=5. Thus q is a
positive integer less than m; this also handles a pair crossing zero by
lifting the second index above the first. The larger-parent indices are
h-l and k-l. Their two actual determinants, in left-to-right orientation,
are

    D_-=m*l-b*h, D_+=b*k-m*l, D_-+D_+=b*q,
    alpha*m<=D_-,D_+<=mu*(m+b).                              (4)

Consequently the general interval is

    2m/(N*q)<=b<=2mu*m/(q-2mu)<2m/(N*q-2).                  (5)

All denominators are positive. The final strict inequality uses mu<alpha
and monotonicity of `2mu/(q-2mu)` in mu.

The root's initial candidate used b>m/n at every gap. The accepted
amplification result only supplies it when that gap contains an all-retained
beta witness, in particular a retained-margin maximizer. Indeed the parent
norms throughout a maximum gap have minimum at most D/m. A beta witness
there therefore gives `beta<=D/m<=mu*(1+b/m)`, hence b>m/n.
For such a reused pair, (3) implies q<2 and thus q=1. Under this additional
hypothesis, (4)--(5) specialize to

    D_-+D_+=b,
    2m/N<=b<=2mu*m/(1-2mu)<2m/(N-2),                         (6)

with larger-parent indices k-1-l and k-l. No seed has been transferred to
another component of W_m.

Conversely, if q>=2, (5) gives `b<=mu*m/(1-mu)<m/n`. At EVERY time of
either reused maximum gap, its retained minimum is at most

    D_-/m or D_+/m <=mu*(1+b/m)<=mu/(1-mu)<beta.              (7)

Thus neither gap can contain a beta witness. This is a necessary scope
restriction, not an existence assertion for unseeded reused pairs.

### Matching and order, with the actual arc identities

A fixed indexed smaller parent can be assigned at most once on each side:
its fixed endpoint is strictly inside the corresponding original m-arc,
and distinct same-m arcs are disjoint. Every forced maximum arc has exactly
one smaller parent. Also, any forced maximum arc meeting B must have B as
one of its two parents, by the all-zero nonparent exclusion. Since b<m/2,
that role must be the smaller one. Hence a reused B meets precisely its two
assigned forced maximum arcs and cannot meet a third. Reuse therefore gives
a matching on K_m, with original indices understood modulo m.

These degree restrictions agree with the earlier forced intersection graph,
whose components are paths or a full cycle. They are not a new topology
principle. The more specific integer interval is (5), and the numerical
adjacency in (6) has the extra seed hypothesis. The next containment also
proves that h and k are consecutive in the cyclic order of K_m, whether or
not q=1.

## 2. One completion mechanism: the intervening maximum arcs

Let `R_h=(h+alpha)/m` and `L_k=(k-alpha)/m`. These points are in W_b by
the actual endpoint domains above, and they lie inside B. Since Q_b=m,
(1) places both in the same contracted closed core

    H'_B=[l/b-(mu/b-epsilon/m), l/b+(mu/b-epsilon/m)].

There is no change of collision component: both points are in the chosen
B lift, whose radius alpha/b is less than half its grid spacing. The
interval between R_h and L_k is consequently contained in H'_B. For every
integer h<j<k, the exact endpoint inequalities 1>2alpha give

    A_(m,j) subset (R_h,L_k) subset H'_B subset B.            (8)

These are complete original alpha-arcs, not just their mu-cores. Each is
nonforced, since it is contained in the different original arc B and has
no private point. This proves consecutive forced-index order. It also
proves that none of these arcs meets ANY completion gap outside the union
of F, including a singleton gap or a gap across zero.

Use the accepted same-center deletion: at a forced center delete all inner
arcs; at any other center keep the outer two. Its reciprocal cost is
`S_c=C_3+C_(2,F)`, where C_3 counts all third and later owners and C_(2,F)
counts second owners at forced centers. After this deletion, let D_off be
the cost of the DISTINCT remaining original m-arcs supplied by (8), over
all reused smaller parents. Count each index once. To fix charging even
if it has more than one eligible parent, assign it to the least pair
`(b,l mod b)` in lexicographic order. Every such arc has cost 1/m and its
center differs from its assigned parent's center: otherwise S_c already
removed it. Do not count any S_c deletion again.

Deleting these additional arcs preserves double coverage of every actual
completion gap because they meet no such gap at all. The surviving
nonforced arcs remain in their original private-point cells. Reapply the
interval two-color construction, and denote the resulting sum of absolute
color-cost imbalances by B_new. The genuine constructed cover then has
cost

    (n+f-S_c-D_off-B_new)/2.                                 (9)

B_new must be computed for the new family. Removing arcs of one color can
reduce an old imbalance, so the former B_c cannot simply be retained while
adding D_off. There is no assertion that D_off is positive: reuse may be
absent, all reuse may have q=1, or all intermediate arcs may already have
been removed by S_c.

This is an explicit aggregate discount of a coarse accounting bound. The
earlier exact private-cell minimum `f+sum_j kappa_j` already ignores arcs
meeting no gap, so this deletion does NOT improve that true optimum or
enlarge the class of feasible covers. Their mu-cores also lie inside a
forced parent's mu-core, so the accepted minimum-cycle contained-core
shortcut already forbids selecting them. No new upper bound on the true
optimum follows just from identifying them.

### The full discount is charged to existing excess coverage

Retain the exact quantities from the strict-core source. Let M be the FULL
original open alpha multiplicity, M_c its count at the distinct center c,
and define

    E_pt=(M-2)_+-sum_c(M_c-2)_+ >=0,
    E=(1/(2alpha))*integral E_pt,
    Lambda=sum_v |K_v|/Q_v.

For each forced A let H_A be its closed mu-core and H'_A its contraction
by epsilon/Q_owner. Let U_A be its private set, and J_A its concentric
second-owner open alpha-arc, or empty if absent. Both U_A and J_A lie in
H'_A and they are disjoint. The accepted exact indexed-core remainder is

    R=sum_(A in F) measure(H_A\(U_A union J_A)),
    (mu/alpha)*f=1+S_c+E+R/(2alpha).                        (10)

No cores are presumed disjoint. To recall the identity's basis, the full
family satisfies `integral M=2n alpha` and M>=1, so
`measure{M=1}=2alpha+integral(M-2)_+`. Nested same-center tails have
integral `2alpha*C_3`; decomposition of each H_A into U_A, J_A and its
indexed remainder then gives (10).

Let X be the indicator sum of the extra arcs counted by D_off. They all
have label m and hence are disjoint, so X<=1 and
`integral X=2alpha*D_off`. Suppose X(t)=1 and assign its arc to B as above.
By (8), t lies in H'_B and in two original arcs, so t is not in U_B.
There are two exhaustive possibilities:

* If t is outside J_B, it lies in `H'_B\(U_B union J_B)`.
* If t is in J_B, the center of B contributes at least two original arcs
  and the extra arc contributes at a different center. Thus E_pt(t)>=1.
  Explicitly, for integer center counts,
  `E_pt=(sum_c min(M_c,2)-2)_+`; these contributions give a sum at least 3.

The open boundary of J_B goes into the first case. Endpoints of the extra
open arcs have X=0. Because X<=1, the deterministic assignment gives the
pointwise bound without a multiplicity loss:

    X <= E_pt + sum_(A in F) 1_(H'_A\(U_A union J_A)).

The indexed strips H_A\H'_A have total length 2epsilon*Lambda and avoid
U_A and J_A. Integrating therefore proves

    D_off <= E+R/(2alpha)-(epsilon/alpha)*Lambda.             (11)

Combine (10)--(11) to obtain the substantive limitation of this pruning:

    f-1-S_c-D_off >=(epsilon/alpha)*(f+Lambda)>0.             (12)

Thus even all of these additional off-center deletions cannot supply the
entire deficit on their own. This uses the actual native identity and the
actual positive strict gap; it is not a counterexample at a test width.
It leaves open whether recomputed B_new or another legitimate saving is
large enough. The derivation supplies no lower bound for that additional
quantity.

## 3. Status, first missing implication, and receipts

The matching and seeded numerical adjacency are proved conditionally in
the full stated setting. The original blanket b>m/n premise was an
unsupported use of a seed belonging to only one component; it is corrected
here, not refuted by an invented strict-failure example. The concrete safe
discount (8)--(9) is bounded by (11), and (12) establishes its insufficiency
without an extra imbalance. No native failure, generic recurrence
counterexample, fresh blocker, or smaller-sum transport is constructed.

The first unresolved implication is an essential use of full minimality
and the remaining actual grid geometry that controls the recomputed
completion costs beyond this already charged deletion. The present method
does not use minimum sum to derive such a bound. Keeping it among the
hypotheses does not fill that gap. This bounded task stops after this one
completion mechanism; no second blocker approach or finite-count ladder
is proposed. Unrestricted LRC remains unresolved.

The accepted source facts and their indicated reviews retain their exact
scope. Required portions were read and the new derivations checked by hand;
no earlier numerical experiment was replayed. Binding hashes:

| Input | SHA-256 |
| --- | --- |
| `research/astra-zero-only-deletion-amplification.md` | `a28465087b02b4763833ffa43263a899b4db262f076b60dffd2342d9a51b5ba0` |
| `research/astra-zero-only-deletion-amplification-review.md` | `ef37fc563a75ea59b5b57b9fd3af43b3f09f7763971059268cf7878cfa8ffdb4` |
| `research/astra-zero-only-maximum-gaps.md` | `f21fc1de78ee9802ecf8992677395507984d26894b220b9890849054077546da` |
| `research/astra-zero-only-maximum-gaps-review.md` | `df1898cb979bc683f172a61e429e9ab48f01f1846bba0821097bdd4979161d4e` |
| `research/astra-forced-parent-global-cycle.md` | `e265c08b2e0204a8d539e1577ff9907c754287902e6474f043b42be6f5de7bae` |
| `research/astra-forced-parent-global-cycle-review.md` | `eaf481831b74dc031f697481a8f133e12646dc4c7282ff67dfcc9cbb16d566ca` |
| `research/astra-forced-arc-completion.md` | `e48f80297a70e6630e76fe2b905ed86372383a5d170a539abccdba3decdd98a1` |
| `research/astra-forced-completion-review.md` | `8e72687760576dc0e8524ecbae0bad81bcf3e8cd33f180219848da86a23adb02` |
| `research/astra-arithmetic-completion-saving.md` | `abfb14f274fb5c72461ce884b7fc44fb89367e056091f628933a601f52a33403` |
| `research/astra-arithmetic-completion-review.md` | `568e9a678777f93de6a4adace739d1b443177662ba7a95e231be30ef2551c019` |
| `research/astra-strict-core-shell-supply.md` | `5cc9866b3c8a516494ad998355265335a5edd15158cf9701c7d814843b97210e` |
| `research/astra-strict-core-shell-review.md` | `dd733c2910f1f4579846c1c945ecac8e83d140eb29917b81dc11d2b1b119b95f` |
| `research/astra-native-endpoint-cycle-arithmetic.md` | `2c80cee9d9f84f1850bda7aa1fc7798e890d7471b09d89578494cf208997257e` |
| `research/astra-native-endpoint-cycle-arithmetic-review.md` | `098c4da30496a606b3d4b9ff0bd41933d6b55f61f9c5da4f085b5e412a889404` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Current project instructions and focused state were read at startup and
after compaction: research/in_progress, recorded explicit authorization,
and this sole owned path. `python3 -B scripts/validate_workflow.py` exited 0:
`workflow structural validation passed; it cannot certify mathematical validity.`
Source bindings used `sha256sum`; full final readback, binding/whitespace
checks and the frozen hash are reported at handoff. Only administrative
checks were run, with no mathematical programs, searches, solvers, builds,
cache/dependency work, external models, additional agents, Git/shared-state
or memory writes, or other-file edits. Independent mathematical review is
required before acceptance.
