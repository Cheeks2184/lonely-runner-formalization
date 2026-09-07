# Global zero-only deletion amplification: exact contacts and the missing step

Task `/root/zero_only_deletion_amplification`; assigned checkpoint
`7d5e9677d56d6ff4d04268c0829f0ee6cbade6c0`. Requested route: Astra/xhigh.
Observed model, effort, elapsed time and usage: null. Only this manuscript
is owned. New hand derivations await independent review.

The proposed deletion recurrence is not proved. The existing determinant
bound is already the exact local contact bound; maximizing the retained
margin does not sharpen it. A complete all-zero example at a larger test
width violates the recurrence, even with actual whole-time coverage and
strong witnesses for every coordinate deletion. It fails native strictness
and replacement minimality, so it does not refute the proposal under the
actual minimal-failure hypotheses. This bounded investigation stops at
that precise global gap.

## Exact setting and proposed target

Assume a hypothetical canonical strict failure V of n>=3 positive distinct
primitive integer speeds, least first by moving count and then primitive
sum. Put

    alpha=1/(n+1), beta=1/n, m=max V,
    f(t)=min_(v in V\{m})||vt||,
    F(t)=min(f(t),||mt||),
    nu=max_t f(t)>=beta,       0<mu=max_t F(t)<alpha.

The maxima are attained on T=R/Z. Retain the whole W_m={f>=alpha} and
every attained collision index K_m. Assume C_k is EMPTY for every k in K_m:
every cross-pair of original endpoint-cover labels for its forced m-arc
sums to m. This is the global all-zero branch, not a selection of convenient
collisions. Minimum sum supplies some alpha-good replacement witness in
W_m for each positive u<m, but does not specify its collision.

For each k, the accepted gap theorem gives original parent arcs with labels
a,b, indices l,r and

    a+b=m, l+r=k, s=min(a,b), D=ar-bl>0,
    alpha*m<=D<=mu*(m+s),
    A_k=(k/m-alpha/m,k/m+alpha/m),
    W_(m,k)=[(l+alpha)/a,(r-alpha)/b].                         (1)

The parents are distinct. No other retained alpha-arc meets A_k, and its
center c=k/m belongs to W_(m,k). All these are statements about the full
original grid and exact open boundaries. They are not hypotheses about
independently placed arcs.

The proposed, UNPROVED target is

    nu<=mu/(1-mu), equivalently mu>=nu/(1+nu).                 (2)

It would contradict nu>=1/n and mu<1/(n+1). The investigation is whether
(1), simultaneously at every collision, supplies an additional argument
for (2). The target itself is not an established amplification principle.

## First approach: exact maximizing-gap contacts

Use the fixed lift e=mt-k in [-alpha,alpha]. Every nonparent norm is at
least alpha throughout this closed interval, by disjointness on A_k and
continuity at its endpoints. The signed parent phases are

    x=(D+a e)/m,       y=(D-b e)/m.

They are actual norms on the entire interval. Positivity at both extremes
uses D>=alpha*m; strict overlap gives
D<alpha(m+a) and D<alpha(m+b), so both upper extremes are less than
2alpha<=1/2. Also x-y=e. Consequently the full original minimum there is

    F(t)=min(|e|,x,y)
        =min(-e,x) when e<=0,
        =min(e,y)  when e>=0.                                (3)

The maximum on each half occurs where its increasing and decreasing lines
meet. Both contacts lie strictly inside A_k, by the same overlap bounds:

    e_-=-D/(m+a),  t_-=(k+l)/(m+a),  F(t_-)=D/(m+a),
    e_+= D/(m+b),  t_+=(k+r)/(m+b),  F(t_+)=D/(m+b).

The rational times follow from D=ak-ml=mr-bk, so their numerators are the
actual lifted integer labels. Thus the exact local maximum is

    lambda_k=max_(t in closure(A_k)) F(t)=D/(m+s).             (4)

In particular D<=mu(m+s) from (1) is already sharp for the full local
problem. The other labels cannot lower these contacts: they are alpha-good
there. This calculation does not supply a larger full-tuple value.

Every global nu-maximizer lies in some W_(m,k), because nu>=beta>alpha.
At that point f<=min(x,y)<=D/m. Hence, for such a maximizing gap,

    nu<=H_k:=D/m<=mu*(1+s/m).                                (5)

This is the accepted gap restriction with nu in place of beta. It is not
the desired recurrence. If nu=H_k, with the parent peak attained at c,
the contact inequality lambda_k>=nu/(1+nu) is equivalent to D>=s.
More generally it is equivalent to

    H_k-nu >= nu*(s/m-H_k).                                  (6)

The full maximizing-gap hypotheses force the right side to be positive.
Indeed put r=s/m and H=H_k. Equation (5) gives
r>=nu/mu-1>=beta/mu-1>beta/alpha-1=beta. Since
beta=alpha/(1-alpha), it follows that
H<=mu*(1+r)<alpha*(1+r)<r, and hence nu*(r-H)>0.
No sufficient lower bound on H-nu to meet (6) is supplied. Merely
replacing the selected seed by a global maximizer does not provide that
missing bound; no recurrence or contradiction follows.

There is also a precise domain obstruction to propagating these contacts
through coordinate minimality. At t_- both m and a have norm
D/(m+a)<=mu<alpha; at t_+ both m and b do. Each contact therefore belongs
to NO original deletion set W_j(alpha): deleting any one label leaves
another alpha-bad label. It cannot be treated as an original deletion
seed for another application of minimality. This matches the distinction
already preserved in the joint-seed audit.

## Second approach: global propagation across all forced gaps

Let U be the union of every forced m-arc A_k, and put
eta=max_(t in T\U) F(t). This is an attained maximum on a nonempty compact
set: in particular 0 is outside U. The exact full decomposition is

    mu=max(eta, max_(k in K_m) lambda_k).                     (7)

Together with nu=max_k max_(W_(m,k)) f, this keeps every collision and the
whole complement; it does not drop multiply-bad regions. A possible
global propagation would have to produce a sufficiently large contact
in another actual gap or a full value at least nu/(1+nu) in that complement.
Equation (7) itself supplies neither. The following complete control tests
this proposed propagation from all-zero geometry and whole-time coverage.

### A complete all-zero control, with its missing hypotheses exposed

Take a SEPARATE working width delta and the fixed tuple

    V={1,3,4,7}, m=7, n=4,
    alpha_native=1/5,       1/5<delta<1/4.

Its actual full maximum is mu=1/5. To prove this, at the native width
the retained (1,3,4) good set is exactly

    {1/5,4/5} union [2/5,9/20] union [11/20,3/5].             (8)

Reflection t->1-t reduces verification to [0,1/2]. Intersect the speed-1
good interval with the speed-3 and speed-4 good intervals there to get
{1/5} and [2/5,9/20]. On this latter interval 7t ranges over [14/5,63/20],
so ||7t||<=1/5; reflection gives the other interval. At the isolated
points an old norm equals 1/5. Outside (8) an old norm is below 1/5.
Finally t=2/5 attains full minimum 1/5. This proves the claimed global
mu, rather than assigning a convenient test constant to it.

The retained maximum is nu=2/7. Again restrict to [0,1/2]. On [0,2/7]
the speed-1 norm is at most 2/7; on [2/7,3/7], 3t is in [6/7,9/7],
so its norm is at most 2/7; on [3/7,1/2], the speed-4 norm is
2-4t<=2/7. At t=3/7 the retained norms are (3/7,2/7,2/7).
The equality cases also show that the retained maximizers are exactly
3/7 and its reflection 4/7. Therefore

    nu=2/7>1/4=mu/(1-mu).                                   (9)

At the working width, the WHOLE retained good set is

    W_delta=[(1+delta)/3,(2-delta)/4] and its reflection.      (10)

Indeed on [0,1/2] the first speed-3 good branch intersects the speed-1
interval in [delta,(1-delta)/3]. The first speed-4 branch ends at
(1-delta)/4<delta, and its next begins at (1+delta)/4>(1-delta)/3.
This eliminates the entire first branch. The second speed-3 branch starts
at (1+delta)/3, and its intersection with the next speed-4 good branch
ends at (2-delta)/4, proving (10). The interval is nonempty since
delta<1/4<2/7. At delta=21/100 its endpoints are 121/300 and 179/400.

The first interval lies strictly inside the m-delta arc about 3/7:
its lower endpoint exceeds (3-delta)/7 because delta>1/5, and its upper
endpoint is below (3+delta)/7 because delta>2/11. Reflection gives the
arc about 4/7. Thus the full attained index set is exactly {3,4}.

At L=(3-delta)/7 the speed-3 norm is (2-3delta)/7<delta;
the speed-1 norm is L>delta and the speed-4 norm is
(2+4delta)/7>delta. At R=(3+delta)/7 only speed 4 is bad, with norm
(2-4delta)/7<delta; the other two norms exceed delta. The m-norm equals
delta at both endpoints. Hence the unique original endpoint arcs are
(a,l)=(3,1), (b,r)=(4,2). They satisfy

    a+b=7, l+r=3, D=2, s=3>D.

Reflection swaps the parents at index 4. There are no other attained
maximum collisions and no positive endpoint candidate at either one.
The full mu-cover is the actual global one proved above. Both retained
maximizers are collision centers, so this control does not depend on
the previously isolated small-label centering obstruction.

In the first arc the exact contacts are t_-=2/5 with value 1/5 and
t_+=5/11 with value 2/11; the reflected arc has the reflected contacts.
Thus both local maxima lambda_k equal 1/5, and (8) proves that nowhere
else can the full value exceed 1/5. No propagation among these complete
gaps or into their complement can yield the desired 2/9=nu/(1+nu).

Even stronger deletion seeds exist for EVERY original coordinate, at the
correct lower-count margin beta=1/4:

| Deleted label | Time | Retained norms, in increasing label order |
| --- | --- | --- |
| 1 | 1/10 | (3/10,2/5,3/10) |
| 3 | 1/3 | (1/3,1/3,1/3) |
| 4 | 1/2 | (1/2,1/2,1/2) |
| 7 | 3/7 | (3/7,2/7,2/7) |

The failed assumptions are explicit. Native strictness fails because
mu=alpha_native. Replacement minimality also fails at the test width:
on (10), ||2t||=1-2t is at most

    (1-2delta)/3<delta,

and reflection preserves this norm. Thus the fresh smaller frequency 2
is strictly delta-bad on all W_delta. Outside W_delta an old retained
label is already strictly delta-bad. Replacing 7 by 2 therefore transports
test-width failure to the smaller-sum tuple {1,2,3,4}. This is exactly
the one-coordinate condition prohibited in an actual minimum, not merely
an assertion that the example lacks unspecified minimality.

The control refutes the proposed recurrence from the BROADER all-zero,
whole-time-cover and all-deletion-seed data, even with centered maxima.
It does not refute the recurrence under canonical strict failure and full
minimum-count/sum hypotheses. Delta was never substituted for the native
threshold in such a hypothesis-complete claim.

## Disposition and evidence

The contact identity (4) is the only refinement of the accepted gap
calculation, and it supplies no stronger bound on mu. The global attempt
does not establish new amplification over (5). The first missing implication
is an argument using the additional native or coupled-minimality information
to force either the contact improvement in (6) at a suitable gap or an actual
larger full-tuple value elsewhere. All-zero geometry, complete coverage, reflection,
and existence of every stronger deletion seed do not supply that implication,
as (8)--(10) show. The contacts themselves are outside every original W_j,
so no seed transfer is licensed. No generic insertion recurrence, new
uniform supply theorem, or LRC proof/disproof is claimed.

The contact computation was hand-derived here. Root supplied the stronger
global control; all its times, endpoint labels, maxima, attained indices,
and failed replacement condition were independently checked here. Only
these two bounded approaches were pursued; no additional example sweep or
mathematical program was used.

| Bound input | SHA-256 |
| --- | --- |
| `research/astra-zero-only-maximum-gaps.md` | `f21fc1de78ee9802ecf8992677395507984d26894b220b9890849054077546da` |
| `research/astra-zero-only-maximum-gaps-review.md` | `df1898cb979bc683f172a61e429e9ab48f01f1846bba0821097bdd4979161d4e` |
| `research/astra-forced-cycle-frequency-exchange.md` | `4ac28414ec9043c9ed11d69b7cc8520a2a1acc3b74168147acfc38091959046f` |
| `research/astra-maximum-frequency-exchange-review.md` | `9cd1282b49034073ad59e8df183df7e7b2cc65ce359d8ec8b088c6c032ab9515` |
| `research/astra-minimal-frequency-synthesis.md` | `03cf038021f0bc1a2328bb77a02f6ab4fe649f5d3626d7bc368a67cd6c7b0000` |
| `research/astra-joint-seed-maximum-audit.md` | `ac73e29474e272167403c91db34331236bb3832f7ce916b2997d7c2f0d6b46ac` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Current config, workflow, policy and focused state were read. The gate was
research/in_progress with explicit start authorization
`2026-09-05T04:12:25.208107+00:00` and this sole owned path.
`python3 -B scripts/validate_workflow.py` exited 0 with
`workflow structural validation passed; it cannot certify mathematical validity.`
The accepted inputs retain their reviewed scopes; source bindings used
`sha256sum`. Full readback, final binding/whitespace/workflow checks and the
frozen manuscript hash are reported at handoff. No solver, build, cache
operation, new agent, external model, Git/shared-state/memory write or
other-file edit was performed. Independent review of the new manuscript
remains necessary; the unrestricted goal remains unresolved.
