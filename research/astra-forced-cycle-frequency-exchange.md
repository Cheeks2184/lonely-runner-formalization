# Cancellation across a complete private collision portion

Task `/root/forced_cycle_frequency_exchange`; assignment checkpoint
`c40889087108333dbe948221b045553fd44a5b0d`. Requested route: Astra/xhigh;
observed model, effort, elapsed time and usage: null. Only this manuscript
is owned. The new derivations await independent mathematical review.

There is a positive local exchange: two smaller original arcs covering the
opposite endpoints of a maximum-speed forced arc supply the signed frequency
`a+b-m`, which is strictly bad on that arc's **entire** private portion.
Such endpoint covers exist at every attained maximum-speed collision.
A common nonzero absolute frequency across all portions gives a genuine
one-slot height descent. Its common choice is not supplied. An exact
consecutive-speed family shows that all these local choices can be zero
at a larger, nonnative working width. No unrestricted LRC conclusion follows.

## Setting and accepted inputs

Let V consist of n>=3 distinct positive primitive integer speeds in a
hypothetical ordinary strict failure, chosen by least moving count and then
least primitive sum. Write

    N=n+1, alpha=1/N, 0<mu=max_(t in R/Z) min_(v in V)||vt||<alpha.

Here `||x||=dist(x,Z)`. For every owner m retain the whole closed deletion set

    W_m={t:||vt||>=alpha for every v in V\{m}}.

Least count supplies a common deletion witness at 1/n>alpha, so W_m
contains a nonempty interval. On all W_m, ||mt||<=mu. Let K_m contain
**every** nearest collision index attained there, modulo m. For k in K_m,
the original open arc

    A_(m,k)={t:dist_(R/Z)(t,k/m)<alpha/m}

is forced: any actual point of its W_m portion belongs to no other original
open alpha-arc. Conversely these are all forced original arcs. All portions,
including disconnected or singleton portions, are retained below.

The accepted strict-core contraction gives, with Q_m=max(V\{m}),

    mu_m=mu-m(alpha-mu)/Q_m,       0<mu_m<mu,
    |mt-k|<=mu_m on the lifted W_(m,k).                         (1)

For clarity, its mechanism is pointwise on all W_m. If
`|s|<(alpha-mu)/Q_m`, every other norm at t+s is strictly above mu.
The global maximum therefore keeps the m-coordinate inside one connected
closed mu-bad component throughout this interval. Taking the two endpoint
limits gives `||mt||+m(alpha-mu)/Q_m<=mu`. Positivity of mu_m follows because
otherwise W_m would consist only of finitely many collision centers.
The source was provisional at assignment and was subsequently accepted
without correction in the bound independent review. It is manuscript
evidence, not a kernel theorem.

Full minimum-sum minimality also supplies, for every 1<=u<m, a point in
W_m with ||ut||>=alpha. If u is retained, this holds throughout W_m;
otherwise an alpha-witness for the smaller replacement supplies it.
Failure of that replacement, followed by primitive normalization, would
contradict minimality. In particular the known residue escape inequality
improves using (1) to

    max_(k in K_m) dist(uk,mZ)>=m alpha-u mu_m.                 (2)

Indeed `ut=(uk+ue)/m`, |e|<=mu_m, at the replacement witness. Equation (2)
alone is an improved obstruction to a proposed replacement, not its supply.
The following calculation instead derives actual local badness from geometry.

## First attempt: two-sided cancellation on a whole collision portion

Fix a forced m-arc and use real lifts with center c=k/m. Suppose original
arcs of labels a<m and b<m overlap it from the left and right, respectively,
with noncontainment and increasing endpoints. Write their centers as

    l/a < k/m < r/b.

They need not themselves be forced. Every t in W_(m,k) is outside both
arcs. The endpoint orders force it to be at or right of the left arc's
right endpoint, and at or left of the right arc's left endpoint. Thus

    e=mt-k,       x=at-l>=alpha,       y=r-bt>=alpha.

The weak signs include private points on the other open arc's boundary.
Strict overlap gives the positive integral determinants

    D_L=ak-ml<alpha(m+a),       D_R=mr-bk<alpha(m+b),

and hence, at this same arbitrary private time,

    x=D_L/m+ae/m<alpha+(a/m)(alpha+e),
    y=D_R/m-be/m<alpha+(b/m)(alpha-e).

Set `s=a+b-m`, `h=l+r-k`. The signed cancellation is

    z=st-h=x-y-e.

Using y>=alpha for the upper estimate and x>=alpha for the lower gives

    z< a alpha/m-(m-a)e/m
      <=alpha-(m-a)(alpha-mu_m)/m,
    z> -b alpha/m-(m-b)e/m
      >=-alpha+(m-b)(alpha-mu_m)/m.                            (3)

Both outer bounds are strict, by strict overlap. Since a,b<m and
alpha-mu_m>0, they lie strictly inside (-alpha,alpha). Consequently

    u=|a+b-m|<m,
    ||ut||<alpha-[(m-max(a,b))/m](alpha-mu_m)<alpha
          for EVERY t in W_(m,k).                             (4)

This covers the full lifted portion without assuming that it is connected.
Integer translates change the lift h by s times that integer, leaving (4)
unchanged; taking |s| also preserves the norm. No small determinant, missing
original denominator, or closure of W_m under time addition is assumed.

If u>0, it is automatically fresh: an existing retained speed would have
norm at least alpha on the nonempty W_(m,k), contradicting (4). If u=0,
then z=-h is an integer of absolute value less than alpha<1/2. Therefore

    a+b=m,       l+r=k.                                       (5)

This is an exact mediant relation, not a positive replacement or a proof
that either determinant equals one. The uncontracted bound |e|<=mu<alpha
already suffices for strict cancellation; (1) improves its explicit margin.

## Second attempt: all endpoint choices and their actual globalization

Now take m=max V. For each k in K_m write
`L=k/m-alpha/m`, `R=k/m+alpha/m`. The full original open alpha-family covers
both endpoints. No m-arc contains either endpoint, so all covering labels
are smaller than m.

Choose any original arc I covering L, and lift it through L. Then
`I.left<L<I.right`. If I.right>=R, I would contain the whole open m-arc,
contradicting its actual private point. Thus

    I.left<L<I.right<R.

Every point of W_(m,k) is >=I.right. Its center satisfies
`center(I)=I.right-alpha/a<R-alpha/a<k/m`, since a<m. Similarly any original
arc J covering R has

    L<J.left<R<J.right,

every private point is <=J.left, and center(J)>k/m. Thus **every pair** of
endpoint-covering arcs satisfies the first attempt's hypotheses. The lifts
are the ones through L and R; the private portion lies in (L,R), so no
circle wrap or endpoint alternative is discarded.

The two labels differ. If a=b, their distinct lifted centers are separated
by at least 1/a. Strict overlap with the middle arc would give

    1/a<2alpha(1/a+1/m),
    1<2alpha(1+a/m)<4alpha<=1,

a contradiction. Their centers cannot be the same because they lie on
opposite sides of k/m. Thus positive candidates even satisfy u<=m-3.

Let E_k^- and E_k^+ denote **all** original arcs covering L and R, and set

    C_k={|a+b-m| : a labels an arc in E_k^-,
                    b labels an arc in E_k^+, a+b!=m}.        (6)

These are actual nonzero integers, all absent from V and less than m.
Every member of C_k is strictly alpha-bad throughout W_(m,k). The sets
E_k^-, E_k^+ are nonempty; C_k is allowed to be empty.

**Coherent endpoint theorem.** A hypothetical minimal failure cannot have

    intersection_(k in K_m) C_k nonempty.                      (7)

To prove this, choose u in that intersection. Equation (4) makes u bad on
all of W_m, with the original times unchanged. At any time outside W_m,
a retained old label is already strictly alpha-bad. Therefore replacing
m by u leaves no common closed-alpha witness anywhere on R/Z. The new
finite tuple is positive and distinct, and its continuous minimum norm
attains a maximum strictly below alpha on the compact circle. Divide its
speeds by their gcd g: the maximum is unchanged because t->gt is onto
R/Z. The resulting primitive tuple still has n distinct positive speeds
and sum at most the replacement sum, strictly below the original sum.
This contradicts the stipulated minimality. This is a one-slot descent,
not a count-increasing substitution.

In particular a common nonzero |a+b-m| for chosen two-sided forced neighbors
would suffice, but forced degree two is unnecessary for (7): the endpoint
covers just proved supply suitable original neighbors at every collision.
If u is a candidate at one collision, minimality supplies an actual
u-good point in W_m at another collision where u is **not** a candidate.
This retains the complete positional data beyond an unlocated residue set.
It does not give a rule making those escape collisions share a candidate.

There is also a precise zero-only alternative. If C_k is empty, then every
cross-pair of endpoint labels satisfies a+b=m. Fixing one label on either
side shows that each side has exactly one label. Same-speed open arcs are
disjoint, so each endpoint has exactly one original covering arc. The
endpoints are therefore actual private points for their unique owners;
both neighboring arcs are forced. Their complementary labels and lifted
numerators satisfy (5). If C_k is nonempty, that entire collision instead
has at least one fresh positive local candidate.

The zero-only case also retains a quantitative condition from the other
owners' full private sets. Its common determinant is
`D=D_L=D_R=ar-bl`. At any private m-point,
`D=bx+ay>=alpha(a+b)=alpha m`. The unique endpoint ownership gives
`L in W_a`, `R in W_b`, and Q_a=Q_b=m. At L the a-residual is positive,
`(D-a alpha)/m>=b alpha/m>0`; its contracted bound (1) gives
`D<=(m+a)mu`. The right endpoint similarly gives `D<=(m+b)mu`. Thus

    alpha m<=D<=mu(m+min(a,b)).                               (8)

In particular the neighboring closed mu-cores meet the m-core, by dividing
the corresponding determinant bounds by am and bm. This root-supplied
restriction uses actual endpoint privacy and full-core contraction; it
does not supply a positive replacement or rule out the zero case.

Different positive candidates, even when every C_k is nonempty, supply at
most a family of replacement speeds covering W_m by their bad sets. They
do not supply one speed. Keeping such a family can increase the moving
count, exactly the obstruction already isolated in the divisor-bundle
route; no count-preserving pruning or sum exchange is inferred here.

### Exact uniform control of the zero-only alternative

Take V={1,...,m}, m>=3, and a **separate working width**

    mu=1/(m+1)<delta<1/m.                                      (9)

The standard gap proof gives this exact mu: among 0,t,...,mt, a coincidence
gives a zero norm; otherwise the shortest circular gap is at most 1/(m+1)
and has an available nonzero difference speed. Time 1/(m+1) attains the
bound. Thus the full open delta-family covers.

Maximum-speed forced centers are exactly primitive k/m. A nonprimitive
center has reduced denominator q<m and its m-arc is inside the q-arc.
At a primitive k/m every other norm is at least 1/m>delta, so the center
itself is private. Fix any such k. The endpoint geometry above, with delta
in place of alpha, applies because m is maximum and there is a private point.
Any left or right endpoint-cover determinant is a positive integer with

    0<D<delta(m+v)<2,

so D=1. Hence the unique possible left label v and right label w satisfy

    vk=1 mod m,       wk=-1 mod m,       1<=v,w<m.

Because k is invertible modulo m, these labels exist uniquely and v+w=m.
They actually cover the endpoints. For `l=(vk-1)/m`,

    v(k/m-delta/m)-l=(1-v delta)/m in (0,delta):

positivity uses v delta<1, and the upper bound uses
`delta(m+v)>=delta(m+1)>1`. The right endpoint is symmetric, with
`r=(wk+1)/m` and signed residual `-(1-w delta)/m`. Thus every endpoint
choice at every maximum-speed collision gives **only zero**, and l+r=k.

The accepted progression classification additionally gives all deletion
sets nonempty at these widths. Every lower positive one-slot replacement
duplicates a retained speed, so the complete single-coordinate least-frequency
conditions hold there. The tuple also has the absolutely smallest sum among
m distinct positive integers. These facts do not turn (9) into the actual
failure hypothesis: its native threshold is 1/(m+1)=mu, strictly below
delta. The example is LRC-good. It refutes automatic nonzero endpoint supply
from the broader cover/private-point/minimum-frequency data, not an implication
using the native strict-failure inequality essentially. It is one mechanism
control at unbounded counts, not a successive-count research ladder.

## Disposition, bindings and actual checks

The new positive results are (3)--(4), automatic two-sided original endpoint
supply for a maximum owner, and the coherent one-slot descent (7). The first
unresolved implication is to produce a common **positive** replacement across
all attained collision portions under native strict failure, or to derive
a contradiction from its zero-only/incoherent alternatives. No such implication
was proved. No claimed failure satisfying the full LRC hypotheses was found.
The control falsifies only the stated broader nonzero-supply shortcut.
Neither a residue certificate alone nor the new conditional theorem is
promoted to a proof of unrestricted LRC.

The cancellation was derived here; root independently checked its signs and
supplied the maximal-owner endpoint upgrade and uniform zero-only control,
which were checked here including all open endpoints and integer lifts.
Accepted manuscript inputs retain their existing scopes. No literature
novelty or kernel verification is claimed.

| Input | SHA-256 |
| --- | --- |
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

Current config, workflow, policy and focused state were read, including after
compaction. The gate was research/in_progress with explicit start authorization
`2026-09-05T04:12:25.208107+00:00` and this sole owned file. The command
`python3 -B scripts/validate_workflow.py` exited 0 with
`workflow structural validation passed; it cannot certify mathematical validity.`
All mathematics was checked by hand; bindings used `sha256sum`. Full manuscript
readback, binding comparison, newline/whitespace and final workflow checks
are recorded with the frozen hash at handoff. No mathematical program, numerical search,
solver, build, cache operation, new agent, external model, Git/state change,
memory write or other-file edit was performed. Independent review of the new
claims remains required; the unrestricted goal remains unresolved.
