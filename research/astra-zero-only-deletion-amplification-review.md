# Independent review: zero-only deletion amplification

Task `/root/zero_only_deletion_amplification_review`; assigned checkpoint
`efc49c3806584c607d98c006927fb116442d9fc0`, with parent main
`7d5e9677d56d6ff4d04268c0829f0ee6cbade6c0`. Requested route:
`gpt-6-astra` / `xhigh`, the existing in-session review route. Observed
model, effort, elapsed time and usage: null. This review is the sole owned
file; root owns workflow state and publication.

**Accepted after one sign correction**, for the exact revised author hash
bound below. The full-arc contact formula is valid. The complete control
refutes deletion amplification from the stated broader geometric and seed
data, while failing both native strictness and replacement minimality.
The recurrence under the full hypothetical canonical minimal-failure
hypotheses remains unproved and unrefuted. This is manuscript mathematics,
not a kernel result or an unrestricted LRC resolution.

## Correction history and source scope

I fully read the original author at
`988470b7796211991e5c15409e212dd956758502c8f96f9dbb970d5f759bc3c6`.
Its sentence following (6), asserting that no sign for that equation's
right side followed from the local hypotheses, was incorrect under the
paragraph's full maximizing-gap hypotheses. Those hypotheses force that
side to be strictly positive. I reported this precise issue without editing
the author. Root accepted the correction, and the author replaced that
paragraph with the derivation independently checked below. I fully read
the revised manuscript at
`a28465087b02b4763833ffa43263a899b4db262f076b60dffd2342d9a51b5ba0`.
This acceptance binds the revised source, preserving the original error;
there are no outstanding correction requests.

The unchanged gap and frequency-exchange inputs were previously fully
reviewed in this session. Their current hashes and the scopes actually
invoked here were checked. In particular, the whole deletion set and all
attained indices are retained, the zero-only parents are actual indexed
original arcs, and no arbitrary multiple-bad time becomes a deletion
witness. The minimal-frequency and joint-seed inputs do not supply the
missing contact propagation asserted nowhere in the revised manuscript.

## Hypotheses and full-arc calculation

Assume, only conditionally, a least-moving-count and then least-primitive-
sum canonical strict failure V of n>=3 distinct positive primitive integer
speeds. Write

    alpha=1/(n+1), beta=1/n, m=max V,
    f(t)=min_(v in V\{m}) ||vt||,
    F(t)=min(f(t),||mt||), nu=max f, mu=max F.

Continuity on the circle gives the maxima. The finite zero sets leave a
time with all norms positive, so mu>0; strict failure gives mu<alpha.
Lower-count validity, with common-gcd normalization if needed, gives
nu>=beta>alpha. Thus W_m={f>=alpha} is nonempty and closed. At every point
of W_m, the full bound forces ||mt||<=mu<alpha, so its attained nearest
indices correspond to actual forced m-arcs. No nearest-index extension
outside W_m is used.

Under the all-zero assumption at EVERY such index k, the accepted inputs
give distinct parents a,b<m, actual lifted indices l,r, and

    a+b=m, l+r=k, s=min(a,b), D=ar-bl=ak-ml=mr-bk>0,
    alpha*m<=D<=mu*(m+s),
    A_k=(k/m-alpha/m,k/m+alpha/m),
    W_(m,k)=[(l+alpha)/a,(r-alpha)/b].

The only retained alpha-arcs meeting A_k are the two parent arcs. This
implies that every nonparent norm is at least alpha throughout A_k;
continuity extends the statement to both closed endpoints, including
tangencies. The real lifts come from the accepted circle geometry and are
not interchangeable with denominators obtained by reducing centers.

For e=mt-k in [-alpha,alpha], set x=at-l and y=r-bt. Then

    x=(D+a e)/m, y=(D-b e)/m, x-y=e.

At the extremes, D>=alpha*m gives
x>=alpha*b/m>0 and y>=alpha*a/m>0. Actual strict parent overlap gives
D<alpha*(m+a) and D<alpha*(m+b). Using the latter bound for the upper
extreme of x, and the former for y, yields

    x<alpha*(m+b+a)/m=2alpha,
    y<alpha*(m+a+b)/m=2alpha.

Consequently 0<x,y<2alpha<=1/2 on the WHOLE closed arc, not only its
private portion. These are the actual parent norms, without wrapping.
Also ||mt||=|e|<=alpha there. Nonparents can therefore be removed from
the minimum, exactly:

    F=min(|e|,x,y)
     =min(-e,x) for e<=0,
     =min(e,y)  for e>=0.

The first half compares a strictly decreasing line with a strictly
increasing line; the second does the reverse. The intersections lie
strictly inside their half-arcs because of the two strict overlap bounds:

    e_-=-D/(m+a), lambda_-=D/(m+a), t_-=(k+l)/(m+a),
    e_+= D/(m+b), lambda_+=D/(m+b), t_+=(k+r)/(m+b).

For example, substituting D=ak-ml in k/m-D/[m(m+a)] gives the stated
t_-; D=mr-bk gives t_+. These identities retain the actual integer lifts.
Each intersection is its half-arc's unique maximum, so

    max_(closure A_k) F = max(lambda_-,lambda_+)=D/(m+s).

Both maximizing contacts are interior points and hence actual full-tuple
values. Thus D<=mu*(m+s) is precisely this local maximum bound; the new
calculation identifies its sharp local meaning and does not improve it.

## Maximizers, sign correction and deletion domains

Every global maximizer of f has f=nu>=beta>alpha, so belongs to some
W_(m,k). In that gap f<=min(x,y), whose unique parent peak is D/m at
e=0. Writing H=D/m and q=s/m for this paragraph gives

    nu<=H<=mu*(1+q).

This remains true if a nonparent reduces the retained maximum below the
parent peak. If nu=H, then
H/(1+q)>=nu/(1+nu) is equivalent to H>=q, or D>=s. Without that equality,
the desired local improvement is exactly

    H-nu >= nu*(q-H).                                        (*)

All denominators are positive, and multiplying them gives (*) without
changing its direction. Under the full maximizing-gap hypotheses,

    q>=nu/mu-1>=beta/mu-1>beta/alpha-1=beta,
    H<=mu*(1+q)<alpha*(1+q)<q.

The final inequality uses beta=alpha/(1-alpha) and q>beta. Hence the
right side of (*) is strictly positive. This verifies the revised sign
paragraph and explains the original error. The estimate nu<=H only gives
H-nu>=0; it supplies no sufficient positive lower bound for (*). The
correction establishes neither amplification nor a contradiction.

At t_-, the two norms for m and a equal lambda_-<=mu<alpha. The other
parent has norm y=2lambda_-; indeed

    2lambda_-=2D/(m+a)>=2alpha*m/(m+a)>alpha,

since a<m. The whole-arc no-wrap check already proves this is the actual
norm. Every nonparent is alpha-good. Thus exactly m and a are alpha-bad
at this contact. Similarly exactly m and b are alpha-bad at t_+. Deleting
any one original label leaves a bad label, so neither contact lies in ANY
original W_j(alpha). The author's weaker statement, that at least two
labels are bad, is sufficient and valid. Neither ordinary coordinate
minimality nor the earlier joint-seed audit permits treating these contact
times as original single-deletion seeds.

For U equal to the union of all these forced m-arcs, T\U is compact and
nonempty. In particular A_0 cannot be forced: inside the arc about zero,
every lower label has norm less than alpha, so W_m has no point there.
No other m-arc contains zero. Thus eta=max_(T\U) F exists. There are
finitely many nonempty W_(m,k), and their union is W_m. The local contact
maxima are attained inside U, whence exactly

    mu=max(eta,max_k D_k/(m+s_k)),
    nu=max_k max_(W_(m,k)) f.

The complement keeps endpoints and every other multiple-bad region. These
are complete decompositions, not a selection of convenient gaps. They
do not compare either term of the first maximum with nu/(1+nu).

## Complete control and exact maxima

Let V={1,3,4,7}, m=7, n=4, native alpha=1/5, and choose a separate working
width 1/5<delta<1/4. I checked all the following over the whole circle,
using reflection t->1-t only to reduce the hand interval calculation.

At native width, on [0,1/2] speed 1 requires t in [1/5,1/2]. The relevant
speed-3 good branches are [1/15,4/15] and [2/5,3/5]; those of speed 4
are [1/20,1/5] and [3/10,9/20]. Their intersection in the half-circle is
{1/5} union [2/5,9/20]. Reflection gives the complete retained good set

    {1/5,4/5} union [2/5,9/20] union [11/20,3/5].

On [2/5,9/20], 7t ranges from 14/5 to 63/20, so its norm is at most
1/5. At the isolated points an old norm equals 1/5; outside this good
set an old norm is strictly smaller. At 2/5 the four norms are
(2/5,1/5,2/5,1/5). Therefore the actual global full maximum is mu=1/5.

For the retained maximum, speed 1 bounds f by 2/7 on [0,2/7]. On
[2/7,3/7], the phase 3t lies in [6/7,9/7] and has norm at most 2/7.
On [3/7,1/2], the actual speed-4 norm is 2-4t<=2/7. Equality in the
first interval could only occur at 2/7, where the speed-3 norm is 1/7.
Equality in either remaining interval requires 3/7. There the retained
norms are (3/7,2/7,2/7). Thus nu=2/7 and the complete maximizer set is
{3/7,4/7}. In particular

    nu=2/7>1/4=mu/(1-mu),
    mu=1/5<2/9=nu/(1+nu).

These are actual extrema, not test constants assigned to an unknown mu.

For the separate width delta, speed 1 restricts the half-circle to
[delta,1/2]. The first surviving speed-3 branch is
[delta,(1-delta)/3]. The first speed-4 branch ends at
(1-delta)/4<delta; the next begins at (1+delta)/4>(1-delta)/3.
The second inequality already holds for delta>1/7. Hence this entire
speed-3 branch disappears. The next branches intersect exactly in

    J_delta=[(1+delta)/3,(2-delta)/4].

It is nonempty precisely when delta<=2/7, strictly so in the chosen
range. Both endpoints are below 1/2, and the complete W_delta is J_delta
and its reflection. For delta=21/100 these endpoints are 121/300 and
179/400, respectively.

At those two endpoints the errors 7t-3 are (7delta-2)/3 and
(2-7delta)/4. The lower one exceeds -delta exactly when delta>1/5;
the upper one is below delta exactly when delta>2/11. Thus all of
J_delta lies strictly in the m-delta arc about 3/7. Reflection gives the
arc about 4/7, and these are ALL attained indices. No extra nearest-index
portion or omitted singleton is being conflated with an actual private
portion at this working width.

At L=(3-delta)/7 and R=(3+delta)/7, the actual retained norms are

| Endpoint | Speed 1 | Speed 3 | Speed 4 |
| --- | --- | --- | --- |
| L | (3-delta)/7 | (2-3delta)/7 | (2+4delta)/7 |
| R | (3+delta)/7 | (2+3delta)/7 | (2-4delta)/7 |

These values lie on the indicated nearest-integer branches throughout
1/5<delta<1/4. At L only speed 3 is strictly delta-bad; at R only speed
4 is. The speed-7 norm equals delta at both and hence provides no open
endpoint cover. The unique original parents are (a,l)=(3,1) and
(b,r)=(4,2), giving a+b=7, l+r=3, D=2 and s=3>D. Reflection interchanges
the parent labels at index 4. Each complete candidate set is zero-only.

Both retained maxima are the centers of these actual private portions.
The first arc's contact times are 2/5 and 5/11, with full values 1/5 and
2/11. At 5/11 the four norms are (5/11,4/11,2/11,2/11); at 2/5 they
are listed above. The reflected arc has the reflected contacts and the
same local maximum 1/5. In this control all formulas for the working
arcs apply with alpha replaced by delta: D>=7delta and the strict parent
overlap bounds hold in the chosen range. The global calculation already
bounds every point in the complement by 1/5. Hence neither another
actual contact nor that complement can supply the desired 2/9.

## Every deletion seed, failed minimality and native boundaries

Each displayed stronger deletion witness was checked against EVERY
retained label, in increasing label order:

| Deleted label | Time | Retained norms |
| --- | --- | --- |
| 1 | 1/10 | (3/10,2/5,3/10) |
| 3 | 1/3 | (1/3,1/3,1/3) |
| 4 | 1/2 | (1/2,1/2,1/2) |
| 7 | 3/7 | (3/7,2/7,2/7) |

All are at least beta=1/4>delta. Their existence alone therefore does not
repair the failed recurrence for this broader control.

On J_delta, t is between 2/5 and 9/20, so ||2t||=1-2t and

    ||2t|| <= 1-2(1+delta)/3=(1-2delta)/3<delta.

The strict inequality is equivalent to delta>1/5. Reflection preserves
this norm, so frequency 2 is strictly bad on the WHOLE W_delta. It is
positive, fresh relative to {1,3,4}, and smaller than 7. Outside W_delta
one of those retained labels is already strictly bad. Consequently
replacing 7 by 2 makes the full tuple {1,2,3,4} strictly delta-bad at every
time; compactness turns this pointwise strictness into a global maximum
strictly below delta. The tuple remains distinct and primitive, its count
stays four, and its sum decreases from 15 to 10. This is an explicit
failure of replacement minimality at the working width.

At native width the situation is different. First, mu=alpha_native, so
there is no canonical strict failure. Second, the retained good set has
the additional isolated points 1/5 and 4/5, where the speed-7 norm is
2/5. Thus native W is not trapped in the speed-7 alpha-arcs. At the
left contact 2/5 the norms of speeds 3 and 7 equal native alpha; they
are not strictly alpha-bad. The overlap inequality D<alpha*(m+a)
becomes equality there. The assertion that every contact is outside
every deletion W_j therefore cannot be transferred from the conditional
strict-failure setting to this native boundary case. At the working
delta these same two norms are strictly bad, as required.

Likewise the replacement estimate loses strictness at delta=1/5, and at
the isolated native retained-good points the speed-2 norm is 2/5. No
strict repair on the whole native W follows. These exact boundary and
minimality failures keep the control outside the full hypothetical
canonical failure domain.

## Disposition, bindings and checks

The proposed recurrence is equivalent to mu>=nu/(1+nu), since mu<1.
Together with nu>=beta it would force mu>=beta/(1+beta)=alpha and
contradict strict failure. The revised manuscript does not assume this
recurrence or infer it from its exact decompositions. Its first unresolved
implication is a use of native strictness or the full coupled minimality
constraints that forces (*) in a suitable actual gap, or produces a full
value at least nu/(1+nu) in the complement. The complete control refutes
that supply from all-zero geometry, whole-time coverage, all deletion
seeds and centered retained maxima alone. It does not refute the
recurrence under the full canonical hypotheses, and it gives no seed
propagation, uniform center supply, or LRC proof/disproof.

All eleven current bindings below were checked against the actual files.
The original rejected wording's author hash is retained above as history,
not as a current-source binding. No changing state hash is used as
mathematical evidence.

| Bound source | SHA-256 |
| --- | --- |
| `research/astra-zero-only-deletion-amplification.md` | `a28465087b02b4763833ffa43263a899b4db262f076b60dffd2342d9a51b5ba0` |
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

Current project config, workflow, policy and focused state were read at
task startup and after context compaction. The gate was research /
in_progress, with explicit start authorization
`2026-09-05T04:12:25.208107+00:00` and this recorded owned path.
`python3 -B scripts/validate_workflow.py` exited 0 with
`workflow structural validation passed; it cannot certify mathematical validity.`
The original and revised authors were fully read; the calculations above
are hand checks. `sha256sum` checked the author and ten inputs. Final
full owned-file readback, binding verification, final-newline and trailing-
whitespace checks, workflow validation and the frozen review hash are
reported at handoff. No mathematical program, search, solver, build,
cache operation, additional agent, external model, Git/shared-state/memory
write or other-file edit was performed by this reviewer.
