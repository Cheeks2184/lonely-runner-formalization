# Independent review of maximum-frequency endpoint exchange

Task `/root/maximum_frequency_exchange_review`; reviewer session
`/root/coordinate_cancellation_review`; assigned source checkpoint
`c63ea896f8218dce44ac270883867d7808c01a51`. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed time, and usage: `null`.
Only this review is owned.

**Accept the complete frozen manuscript below without a mathematical
correction.** It proves strict local badness on every point of an indexed
private portion, automatic endpoint choices for a maximum speed, a genuine
one-slot descent if their positive candidates have a common value, and a
precise zero-only alternative. The progression control shows only that
positive local supply can fail at a larger working width. Common positive
choice and exclusion of the canonical zero-only/incoherent alternatives
remain unproved. This is manuscript evidence, not a kernel theorem or
unrestricted LRC resolution.

## Hypotheses, contraction, and necessary residue escape

Let V have n>=3 distinct positive primitive integer speeds in a hypothetical
ordinary strict failure, chosen first by moving count and then primitive
sum. Put N=n+1, alpha=1/N and
`0<mu=max_(t in T) min_(v in V)||vt||<alpha`, T=R/Z. For each m retain
the full closed deletion-good set
`W_m={t:||vt||>=alpha for all v!=m}`. Least count supplies a common
deletion witness at 1/n>alpha, so W_m contains an interval. On W_m the
m-norm is at most mu. Every attained nearest index k modulo m belongs to
K_m, and its indexed arc A_(m,k) is forced. Its entire private portion
W_(m,k), lifted through k/m, is nonempty and lies inside that open arc;
it need not be connected or have interior.

The accepted strict-core source gives, for Q_m=max(V\{m}),
`mu_m=mu-m(alpha-mu)/Q_m`, with `0<mu_m<mu`, and
`|mt-k|<=mu_m` on every lifted W_(m,k). To check the invocation, for
`|s|<(alpha-mu)/Q_m` all other norms at t+s exceed mu. The full maximum
keeps the m-coordinate in a single closed mu-bad component throughout this
connected interval. Its two endpoint limits give
`||mt||+m(alpha-mu)/Q_m<=mu`. Nonemptiness rules out mu_m<0; if mu_m=0,
all of W_m would be at finitely many centers, contradicting its interval.
This uses all W_m and permits equality at the closed limiting boundary.

For every 1<=u<m, a retained u is alpha-good throughout W_m. For a fresh u,
the n-speed replacement has smaller sum. If it failed at alpha, division
by its gcd would preserve its maximum and lower its primitive sum, contrary
to minimality. Thus a common alpha-witness for that replacement supplies
a point t in W_m with ||ut||>=alpha. At this point, writing mt=k+e and
|e|<=mu_m, the circle norm triangle bound gives

`alpha<=||ut||<=dist(uk,mZ)/m+u mu_m/m`.

Consequently
`max_(k in K_m) dist(uk,mZ)>=m alpha-u mu_m`.
This is a necessary residue inequality, with the actual witness and its
attained k. It does not produce a replacement frequency or independently
choose coordinate phases.

## Cancellation on the entire private portion

Fix A_(m,k), with real center c=k/m. Suppose original arcs of labels
a,b<m overlap it from the left and right with increasing endpoints and
noncontainment, and centers l/a<c<r/b. They need not be forced. Because
every point of W_(m,k) is in A_(m,k) and outside both side arcs, endpoint
order gives, at every such point,

`e=mt-k`, `x=at-l>=alpha`, `y=r-bt>=alpha`.

The weak signs retain points on the boundaries of the other open arcs.
The center separations and strict overlap give positive integers

`D_L=ak-ml<alpha(m+a)`,
`D_R=mr-bk<alpha(m+b)`.

Using the same arbitrary private time throughout,

`x=D_L/m+ae/m<alpha+(a/m)(alpha+e)`,
`y=D_R/m-be/m<alpha+(b/m)(alpha-e)`.

Set s=a+b-m and h=l+r-k. The exact signed identity is
`z=st-h=x-y-e`. Subtracting y>=alpha in the first estimate, and x>=alpha
in the second, gives

`z<a alpha/m-(m-a)e/m`
` <=a alpha/m+(m-a)mu_m/m`
` =alpha-(m-a)(alpha-mu_m)/m`,

`z>-b alpha/m-(m-b)e/m`
` >=-b alpha/m-(m-b)mu_m/m`
` =-alpha+(m-b)(alpha-mu_m)/m`.

The outer inequalities remain strict because the overlaps were strict.
Both a,b<m, so with
`B=alpha-[(m-max(a,b))/m](alpha-mu_m)` one has 0<B<alpha and |z|<B.
For u=|s|, norm invariance under sign and the integer h imply

`u<m`, `||ut||<=|st-h|<B<alpha` on EVERY point of W_(m,k).

This argument does not use connectedness of the portion. Integer translation
of its time lift sends k,l,r to k+mj,l+aj,r+bj and h to h+sj, leaving z
unchanged. It neither adds private times nor assumes that W_m is closed
under an arithmetic operation on time.

If u>0, it is fresh: any existing retained label would have norm at least
alpha at the nonempty private portion, contradicting this bound. If u=0,
then z=-h is an integer with absolute value less than alpha<1/2. Therefore
h=0 and exactly `a+b=m`, `l+r=k`. This is a relation between actual labels
and actual lifted numerators, with no assertion of reducedness or unit
determinants. Even the weaker |e|<=mu<alpha would give a strict bound;
the contracted mu_m sharpens its numerical margin.

## Every maximum-speed endpoint choice is eligible

Now m=max V. Write the endpoints of its forced arc as
`L=k/m-alpha/m` and `R=k/m+alpha/m`. The complete original open alpha-family
covers both. No m-arc contains either endpoint: the central one omits its
boundary, and other m-arcs are separated from it. Every endpoint-covering
label is therefore smaller than m.

Lift any arc I covering L through that real point. Its endpoints satisfy
I.left<L<I.right. If I.right>=R, it would contain the whole open m-arc
and hence its actual private point, impossible. Thus
`I.left<L<I.right<R`. All private points in (L,R), being outside I, are
at or to the right of I.right. For its label a<m,
`center(I)=I.right-alpha/a<R-alpha/a<k/m`.
Similarly every arc J covering R has
`L<J.left<R<J.right`, all private points at or left of J.left, and its
center strictly to the right of k/m. These are the required lifts and
noncontainment for every pair of choices. No circular endpoint or alternate
private component has been omitted.

Their labels are distinct. If both were a, the distinct chosen center lifts
would differ by at least 1/a. Strict overlap with the middle arc would force
their distance below `2alpha(1/a+1/m)`, hence
`1<2alpha(1+a/m)<4alpha<=1`, a contradiction. Since a,b are distinct
integers in {1,...,m-1}, their sum lies in [3,2m-3], so every positive
candidate satisfies u<=m-3. No assumption about forced degree two is used.

Let E_k^- and E_k^+ contain all original indexed arcs covering the respective
endpoints, and define C_k from all their pairs as the positive values
|a+b-m|. Both endpoint sets are finite and nonempty; C_k may be empty.
Every member is a fresh integer below m and strictly alpha-bad on that
entire W_(m,k), by the preceding calculation.

If a positive u lies in every C_k, it is strictly bad throughout W_m, since
the complete attained portions cover W_m. Outside W_m, at least one retained
old label is already strictly alpha-bad. Thus the replacement of m by u has
minimum norm strictly below alpha at every time. This finite tuple's minimum
norm is continuous on the compact circle, so its attained maximum is also
strictly below alpha. Freshness makes its n positive speeds distinct. If g
is their gcd, the maximum of the divided tuple is identical because t->gt
is onto T. Division preserves n distinct positive speeds, and its primitive
sum is at most the replacement sum, which is strictly below the original
sum. This is the claimed count-preserving height contradiction.

It follows that a hypothetical minimum has empty intersection of the C_k.
There is no assertion that some positive common candidate exists. If u is
a candidate at one collision, the earlier replacement-witness argument gives
an actual u-good point in W_m. Its collision is different and u is not a
candidate there, since every candidate is bad on the whole portion. This is
valid positional escape information, not a coherence theorem. Different
candidates covering different portions supply at most several replacement
speeds; retaining them can raise the moving count and does not give this
one-slot descent.

## The exact zero-only alternative

Because both endpoint sets are nonempty, C_k is empty if and only if every
cross-pair of labels satisfies a+b=m. Fix one left label; every right label
is its complement. Fix that right label; every left label is uniquely its
complement. Same-speed open arcs are disjoint, so each endpoint then has
exactly one original covering arc. Conversely, unique complementary endpoint
owners give only zero candidates. The labels are distinct by the canonical
endpoint argument above.

Each endpoint is therefore an actual private point of its unique owner:
L belongs to W_a and R to W_b, so both side arcs are forced. Cancellation
gives l+r=k, and since a+b=m the three determinants agree:

`D_L=ak-ml=ar-bl=mr-bk=D_R=:D`.

For any private m-point, `D=bx+ay>=alpha(a+b)=alpha m`. At L the signed
a-residual is
`aL-l=(D-a alpha)/m>=b alpha/m>0`. It is below alpha because the a-arc
covers L, so it is the actual a-norm. Since L is in W_a and m is the
maximum retained speed for that deletion, Q_a=m. Its contracted bound gives

`(D-a alpha)/m<=mu-a(alpha-mu)/m`,
and therefore `D<=(m+a)mu`.

At R, similarly, `r-bR=(D-b alpha)/m>=a alpha/m>0` is its actual b-norm,
Q_b=m, and `D<=(m+b)mu`. Thus precisely

`alpha m<=D<=mu(m+min(a,b))`.

Both bounds may be weak: a private m-point can meet a side arc boundary,
and the contracted endpoint estimate is closed. The two upper bounds say
that the relevant center separations are at most
mu(1/a+1/m) and mu(1/b+1/m), respectively. Hence the neighboring closed
mu-cores meet the m-core; strict overlap of those cores is not asserted.
No positivity of a replacement or exclusion of this case follows.

## Uniform zero-only control and its exact scope

Take V={1,...,m}, m>=3, and separate the working width from the native one:
`mu=1/(m+1)<delta<1/m`. A coincidence or shortest circular gap among
0,t,...,mt proves the upper bound mu, and t=1/(m+1) attains it. The full
open delta-family consequently covers.

A nonprimitive maximum-speed center reduces to denominator q<m and its
m-arc is contained in the original q-arc. It cannot be forced. At each
primitive k/m, every other norm is at least 1/m>delta, so the center itself
is private. These are exactly the attained maximum-speed forced indices.

For any arc of label v<m covering one of their endpoints, the lift and
noncontainment argument gives a positive integral determinant with
`0<D<delta(m+v)<2`; hence D=1. This part of the endpoint argument does
not need the canonical alpha<=1/4 same-label estimate, which should not
be substituted at the larger working width when m=3. The determinant
calculation itself handles every m>=3.

The unique possible left label satisfies vk=1 modulo m; the unique right
label satisfies wk=-1 modulo m. Invertibility of k gives both labels in
{1,...,m-1} and w=m-v. They are distinct: if v=w=m/2, an invertible
residue v modulo m would force m=2, outside the domain. Their lifted
numerators are `l=(vk-1)/m`, `r=(wk+1)/m`, so l+r=k.

These possible arcs do cover the endpoints. At the left endpoint,
`v(k/m-delta/m)-l=(1-v delta)/m` is positive because v delta<1, and is
less than delta because `delta(m+v)>=delta(m+1)>1`. The right endpoint
has signed residual `-(1-w delta)/m` with the same strict bounds on its
absolute value. Thus every endpoint choice at every maximum-speed forced
collision gives only zero. No choices have been excluded by selecting
convenient neighbors.

The accepted progression classification also supplies nonempty deletion
sets for every label at these widths. Its explicit primitive-center
private points suffice; no lower-count theorem or sweep is needed here.
All lower positive one-slot replacements duplicate a retained speed, and
the consecutive tuple has absolutely smallest sum for m distinct positive
integers. Uniform least-count minimality at delta is not assumed. Most
decisively, the tuple has an actual closed native witness: its maximum is
1/(m+1), equal to the canonical threshold, whereas delta is larger.

The control therefore refutes automatic nonzero endpoint supply from the
broader open-cover/private-point/coordinate-minimum data. It is not a
canonical strict failure and does not refute an implication using that
missing premise essentially. The reviewed theorem excludes a common
positive candidate in a hypothetical minimum; it neither supplies one
nor rules out zero-only or mutually inconsistent positive candidates.
That is the first unresolved implication. No unit-determinant theorem
for actual strict failures, full transport from private repair alone,
count-increasing bundle shortcut, or unrestricted LRC result is inferred.

## Bindings and checks

The full frozen author was read and independently checked above. Its fifteen
input bindings were verified unchanged. Prior full source reads and accepted
independent reviews were reused at the actual invoked scopes: complete
deletion witnesses and normalization, forced indexed portions, real endpoint
geometry, the strict-core contraction, and the progression control. No
earlier mathematical computation was repeated. New cancellation, all-choice
endpoint supply, globalization, zero-only ownership, and the determinant
window were hand-derived here; administrative agreement alone was not
treated as acceptance.

| Input | SHA-256 |
| --- | --- |
| `research/astra-forced-cycle-frequency-exchange.md` | `4ac28414ec9043c9ed11d69b7cc8520a2a1acc3b74168147acfc38091959046f` |
| `research/astra-minimal-frequency-synthesis.md` | `03cf038021f0bc1a2328bb77a02f6ab4fe649f5d3626d7bc368a67cd6c7b0000` |
| `research/astra-minimal-frequency-review.md` | `b26182c2e482e7f83480eab9904779b958eb8b8b753c70bc45c6fabec55b747d` |
| `research/astra-arithmetic-winding-exchange.md` | `6fbd8b96223e1697c33d5e187c25fb9f93707c880f2794892dfa16ca0ab2d6d4` |
| `research/astra-arithmetic-winding-review.md` | `45eca69dd2c8b48a0cec68ca737262b9f1a616b08f85046629c9c4e632618243` |
| `research/astra-forced-arc-completion.md` | `e48f80297a70e6630e76fe2b905ed86372383a5d170a539abccdba3decdd98a1` |
| `research/astra-forced-completion-review.md` | `8e72687760576dc0e8524ecbae0bad81bcf3e8cd33f180219848da86a23adb02` |
| `research/astra-coupled-descent-strategy.md` | `d9a029cb16c866a45741f97841f3b007d4823f86712fe827e899801208289bb2` |
| `research/astra-private-repair-review.md` | `a8aaec8468969723207dc12e9ff2c112a4560c1f51e97f13b43f4e342c849512` |
| `research/astra-strict-core-shell-supply.md` | `5cc9866b3c8a516494ad998355265335a5edd15158cf9701c7d814843b97210e` |
| `research/astra-strict-core-shell-review.md` | `dd733c2910f1f4579846c1c945ecac8e83d140eb29917b81dc11d2b1b119b95f` |
| `research/astra-cover-selection-review.md` | `a0fe2ed43372520ac30caec3844bbc90dc145089a8ba9113be4bba8b9bbab770` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Current config, workflow, policy, and focused state were read. The gate was
research/in_progress with explicit start authorization at
`2026-09-05T04:12:25.208107+00:00`; the active task recorded this route,
checkpoint, and sole owned review. Observed runtime metadata remained null.
`python3 -B scripts/validate_workflow.py` exited 0 with
`workflow structural validation passed; it cannot certify mathematical validity.`

The full review was read back. All sixteen bindings were checked with
`sha256sum` and final byte-hash comparison; newline/whitespace and final
workflow checks passed. These are administrative checks, separate from the
hand mathematical review. No mathematical program, enumeration, solver,
build, cache operation, extra agent, external model, Git/shared-state edit,
memory write, or other-file edit was performed. The frozen author and other
inputs were preserved. No mathematical error or requested author correction
occurred. The review's frozen hash is returned separately.
