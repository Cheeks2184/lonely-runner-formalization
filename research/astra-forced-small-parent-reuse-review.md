# Independent review: smaller-parent reuse and its charged discount

Task `/root/forced_small_parent_reuse_review`; recorded checkpoint
`2dca882840ede6444cca50aeda81c72f283de1c4`. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed time and usage: null.
Only this review is owned; root owns shared state and publication.

**Accepted without correction** for the frozen author SHA-256
`897c6646545e5c57c29531cfb21a553304ab2627f754f69d71cbaaf0b534aedc`.
The source correctly restricts numerical adjacency to a seeded reused pair.
The general matching, complete-arc containment, additional safe deletion and
pointwise charge are valid. The discount refines a coarse completion bound;
it is already paid for by the existing excess/remainder budget and leaves a
strict positive deficit. No uniform contradiction or native failure example
is obtained. This is independent manuscript acceptance, not a kernel theorem.

## Hypotheses and the inherited endpoint domains

Assume n>=5 distinct positive primitive integer speeds V in a hypothetical
canonical strict failure, least by moving count and then primitive sum.
Put N=n+1, alpha=1/N<=1/6, beta=1/n, m=max V and
0<mu=max_t min_(v in V)||vt||<alpha, epsilon=alpha-mu>0.
Each W_v is the whole closed set where every other original norm is at
least alpha; Q_v=max(V\{v}). All attained indices K_v, including singleton
portions, define the forced original indexed arc family F. Set
f=sum_v |K_v|/v. Its members have actual private points relative to the
ENTIRE original open alpha-family. The full closed mu-family covers.

The accepted contraction is

    ||vt||<=mu-v*epsilon/Q_v on ALL W_v.                    (R1)

Assume the all-zero branch at EVERY forced maximum arc. Its distinct
parents, of labels u,w and lifted indices i,j, satisfy

    u+w=m, i+j=k,
    alpha*m<=D=u*j-w*i<=mu*(m+min(u,w)).                   (R2)

Only those two retained original arcs meet that maximum arc. Its left and
right endpoints lie respectively in W_u and W_w; the parents' near
endpoints lie in W_m. Thus the parents themselves are forced. The exact
stronger-seed restriction from the accepted gap/amplification sources applies
only to the component actually containing that seed. No transfer to every
other W_m component is part of these inputs.

## General reuse, seeded adjacency and the matching

Let B be a fixed smaller parent with label b<m/2, index l, endpoints
P=(l-alpha)/b and Q=(l+alpha)/b. Suppose it is the right parent of A_h
and the left parent of A_k. Their other parent label is a=m-b>b.
Choose the single B lift containing both of its endpoint configurations.
Then P lies strictly in A_h and Q strictly in A_k, both in W_m.

These cannot be the same lifted m-arc: Q-P=2alpha/b exceeds the entire
length 2alpha/m of such an arc. Their real order and same-speed disjointness
give h<k. Writing q=k-h and subtracting the two endpoint errors, each of
absolute value strictly below alpha, gives

    0<q<2alpha*m/b+2alpha<m.                               (R3)

For the last sign, the upper expression is at most (m+1)/3<m for m>=5.
Thus q is a positive integer less than m. This fixes distinct original
indices even across the circle cut, where k is the lifted later index.
The other parent indices are h-l and k-l, and direct substitution gives

    D_-=m*l-b*h, D_+=b*k-m*l,
    D_-+D_+=b*q,
    alpha*m<=D_-,D_+<=mu*(m+b).                            (R4)

Summing lower and upper bounds and solving for b yields exactly

    2m/(N*q)<=b<=2mu*m/(q-2mu)<2m/(N*q-2).                (R5)

Both denominators are positive since q>=1 and 2mu<2/N<1.
The last strict sign follows from mu<alpha and the strict increase of
2x/(q-2x) for x<q/2. No unseeded bound b>m/n has been used.

In either of these two maximum gaps, the two parent norms x,y are the
actual nonwrapped norms and satisfy a positive weighted average equal
to D/m: the weights are their opposite labels divided by m. Therefore
the retained minimum is at most min(x,y)<=D/m throughout that gap.
If THAT gap contains a retained beta-witness, then

    beta<=D/m<=mu*(1+b/m)<alpha*(1+b/m),
    b/m>beta/alpha-1=1/n.

Substituting m/b<n in (R3) gives q<2alpha*n+2alpha=2. Hence q=1,
D_-+D_+=b, and (R5) gives the stated bounds with q=1 and larger-parent
indices k-1-l,k-l. The seed need occur in only one of the two gaps, since
the same b is used in both configurations. Existence of a seed somewhere
in W_m does not ensure that it lies in either member of an arbitrary pair.

Conversely, q>=2 in (R5) implies

    b<=mu*m/(1-mu)<m/n,
    retained minimum <=D_-/m or D_+/m
                     <=mu*(1+b/m)<=mu/(1-mu)<beta.         (R6)

Here mu/(1-mu)<alpha/(1-alpha)=1/n. Thus neither gap can contain a beta
witness. The frozen source corrects the earlier blanket premise rather
than presenting an invented strict-failure counterexample to it.

A fixed indexed B can serve at most once as a right parent and once as a
left parent: each role puts its fixed near endpoint inside its assigned
original m-arc, and distinct m-arcs are disjoint. If B meets any other
forced m-arc, the all-zero nonparent exclusion makes it one of that arc's
two parents. Since b<m/2, it is necessarily the smaller one. Consequently
a reused B meets precisely its two assigned forced m-arcs, with no third.
Every forced maximum arc has exactly one smaller parent because its parents
are distinct and sum to m. The reused parents therefore define disjoint
pairs, a matching on K_m. This is a statement about original indexed arcs,
not an injection into the set of parent speed labels.

## Complete intervening arcs and safe accounting

The right endpoint R_h=(h+alpha)/m and left endpoint L_k=(k-alpha)/m
belong to W_b and are strictly inside B. Since Q_b=m, (R1) places them
in the SAME lifted contracted core

    H'_B=[l/b-(mu/b-epsilon/m),l/b+(mu/b-epsilon/m)].

The index is l because both points already lie inside the chosen original
B-arc, of radius alpha/b below half its grid spacing. The contracted radius
is nonnegative by the existence of these points. Convexity gives
[R_h,L_k] subset H'_B. The order R_h<L_k follows from q>=1>2alpha.
For every integer h<j<k, endpoint subtraction gives

    (j-alpha)/m>R_h, (j+alpha)/m<L_k,
    A_(m,j) subset (R_h,L_k) subset H'_B subset B.          (R7)

These strict signs use 1>2alpha. Thus the entire original alpha-arc is
contained, not just its center or mu-core. It cannot have a private point
because the other original arc B covers all of it. No forced m-index lies
strictly between h and k, so the pair is consecutive in cyclic K_m order
even when q>1. Closed gap endpoints, singleton private portions and the
period cut do not alter this argument.

Apply the accepted same-center deletion first: all inner arcs below a
forced owner are deleted, while at other centers only the outer two remain.
Its exact cost is S_c=C_3+C_(2,F). Let D_off count only the DISTINCT
remaining m-arcs supplied by (R7), each with cost 1/m. Fix their assignments
to eligible B by the prescribed lexicographic rule on (b,l mod b). This
avoids repeated cost or ambiguous charging across different reused pairs.

Every extra arc's center differs from its assigned parent's center. If
they coincided, B is a forced outer owner there, and m>b would already have
been deleted in S_c. Forced ownership excludes any smaller original owner
at that same center. Thus no previously discarded index is charged again.

Every extra arc is contained in a forced arc, so meets no actual completion
gap outside the forced union. Removing it cannot affect double coverage of
those gaps, including their closed endpoints or singleton cases. Recoloring
the remaining nonforced intervals gives the legitimate cost

    (n+f-S_c-D_off-B_new)/2.                               (R8)

B_new is the sum of the NEW cellwise absolute color-cost imbalances. It is
not the old B_c carried forward: deleting cost from one color can decrease
that earlier imbalance. The source correctly asserts no positivity of
D_off; there may be no reuse, no q>1 pair or no surviving intermediate arc.

This improves the explicit coarse accounting, not the exact feasible optimum.
The exact private-cell costs kappa_j already omit positive-cost arcs that
meet no gap. Removing them leaves every kappa_j unchanged. The minimum-cycle
comparison is also valid with the accepted auxiliary bound: an extra closed
mu_hat-core lies inside its original alpha-arc, hence inside H'_B at actual
mu, hence inside B's mu_hat-core. Every cycle contains forced B. Thus the
minimum-cycle contained-core shortcut already excludes the extra vertex.
This uses the full containment in (R7), and does not conflate actual and
auxiliary core radii.

## Exact pointwise charge and the strict remaining deficit

All multiplicities in the charge are for the FULL original family, not the
pruned one. At each distinct center c let M_c be its original count and
M=sum_c M_c. Put

    E_pt=(M-2)_+-sum_c(M_c-2)_+,
    E=(1/(2alpha))*integral E_pt,
    Lambda=sum_v |K_v|/Q_v.

The pointwise identity used in the source is correct. Write
Y=sum_c min(M_c,2), Z=sum_c(M_c-2)_+, so M=Y+Z. If Z=0 the identity is
immediate; if Z>0 then Y>=2 and (Y+Z-2)_+-Z=Y-2. Hence always

    E_pt=(Y-2)_+>=0.                                      (R9)

For each forced indexed A, U_A means its ENTIRE uniquely covered private
portion, not a selected private point. J_A is the original open alpha-arc
of its second same-center owner, or empty if none exists. The accepted
contraction/owner bound puts both U_A and J_A inside H'_A, disjoint from
one another. In particular an endpoint of J_A can be private because J_A
is open; this causes no conflict. Let H_A be the closed actual mu-core and

    R=sum_(A in F) measure(H_A\(U_A union J_A)).

The unchanged indexed-core identity is

    (mu/alpha)*f=1+S_c+E+R/(2alpha).                       (R10)

It follows from full native multiplicity M>=1, integral M=2n alpha,
measure{M=1}=2alpha+integral(M-2)_+, and decomposition of each individual
H_A. Different cores may overlap; R counts their separate remainders and
does not replace their indexed sum by union measure.

Let X be the indicator sum of the extra m-arcs. Same-speed disjointness
gives 0<=X<=1 and integral X=2alpha*D_off. If X(t)=1, its unique extra
arc has its fixed assigned B. Then t lies in H'_B and in both B and the
extra arc, so t is not in U_B. If t is outside J_B, it contributes to
H'_B\(U_B union J_B). If t is in J_B, the B-center has at least two
original covering arcs, while the extra arc has a different center. Thus
Y>=3 and E_pt(t)>=1 by (R9). This uses original J_B even if S_c removed
it; all quantities in this charge still refer to original multiplicities.
We have the pointwise bound

    X<=E_pt+sum_(A in F) 1_(H'_A\(U_A union J_A)).          (R11)

No disjointness between different H'_A is required. The deterministic
assignment and X<=1 prevent a multiplicity loss. At an open boundary of
J_B the first case applies, and an extra arc's omitted endpoints have X=0.

Because U_A,J_A are inside H'_A, each indexed remainder splits into its
contracted remainder and the strips H_A\H'_A. Those strips have length
2epsilon/Q_owner, even if a contracted core degenerates to a point. Summing
their lengths gives exactly 2epsilon*Lambda. Integrating (R11) proves

    D_off<=E+R/(2alpha)-(epsilon/alpha)*Lambda.             (R12)

Finally subtract D_off from (R10), using 1-mu/alpha=epsilon/alpha:

    f-1-S_c-D_off
      =(epsilon/alpha)*f+E+R/(2alpha)-D_off
      >=(epsilon/alpha)*(f+Lambda)>0.                     (R13)

The strict sign uses the actual native strict gap and f>0. This proves
that the complete additional deletion is insufficient by itself; it does
not bound B_new from below or show the constructed cover is cheap enough.

## Disposition, bindings and checks

The only correction history relevant here is the already corrected
overgeneralization of the beta-seed restriction. The frozen source makes
the general q and seeded q=1 cases precise, and all new claims pass review
without further correction. The matching restricts indexed incidence; the
off-center deletion is safe; its full cost is charged by (R12). None of
these statements supplies a native-failure counterexample or an admissible
smaller-sum tuple.

The first unresolved implication is a use of full failure minimality and
remaining original geometry that controls the recomputed completion cost
beyond the already charged deletion. Neither a sufficient lower bound on
B_new nor another uncharged saving is derived. Merely retaining minimum
sum among the assumptions does not provide this missing inequality.
No additional research mechanism or numerical control is introduced; no
count ladder or LRC resolution is accepted by this review.

The author and the bound amplification author/review were read fully. The
needed exact gap domains and indexed-core identities were checked against
the current source/review text; the other unchanged accepted interfaces
retain their earlier reviewed scopes. All nineteen bindings below (author
and eighteen inputs) were verified against current bytes.

| Bound source | SHA-256 |
| --- | --- |
| `research/astra-forced-small-parent-reuse.md` | `897c6646545e5c57c29531cfb21a553304ab2627f754f69d71cbaaf0b534aedc` |
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

Current configuration, workflow, policy and focused state were read, showing
research/in_progress, explicit start authorization
`2026-09-05T04:12:25.208107+00:00`, and this sole owned review path.
Initial `python3 -B scripts/validate_workflow.py` exited 0 with
`workflow structural validation passed; it cannot certify mathematical validity.`
Full owned readback, final binding/whitespace/newline checks, final workflow
validation and frozen hash are returned at handoff. Administrative checks
do not certify the hand mathematics. No mathematical program, enumeration,
solver, build/cache/dependency work, new agent, external model, Git/shared-state
or memory edit, or other-file write was performed. Unrestricted LRC remains
unresolved.
