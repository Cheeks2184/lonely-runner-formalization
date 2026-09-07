# Same-parity pair replacement: complete lift test and a global interval bound

Task `/root/same_parity_pair_descent`; assigned checkpoint
`f34b3bbaec88672616b4a6acd7fe8b30dc47a590`. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed time and usage: null.
Only this manuscript is owned. These hand results require independent
review; no kernel theorem or unrestricted LRC resolution is claimed.

The replacement is admissible after correctly counting duplicate labels,
but failure transport is not established. Two mechanisms were checked.
The complete two-time classification gives a necessary restriction on
every new witness, retaining all old odd labels. A separate interval
argument uses the full original maximum to trap each component of the
new good set in two fixed original cores. It gives a global comparison of
the two maxima, whose coefficient is uniformly too weak for the required
descent. Neither choosing a strongest new witness nor tracking one parity
competitor supplies the missing selection.

## 1. Minimality, distinct labels and the actual supplied margin

Assume a hypothetical canonical strict failure V of n>=3 distinct positive
primitive integer speeds, least by moving count and then primitive sum.
Set `N=n+1`, `alpha=1/N` and
`0<mu=max_t min_(v in V)||vt||<alpha` on T=R/Z.
The active unrestricted branch is beyond the established six-total-runner
milestone; no successive-count program is used here.

Choose original labels a<b of the same parity and put

    x=(b-a)/2, y=(b+a)/2, R=V\{a,b}, T_new=R union {x,y}.

The new pair consists of positive distinct integers with
`y-x=a`, `y+x=b`, `x+y=b<a+b`. Let

    c=|{x,y} intersection R| in {0,1,2}, d=|T_new|=n-c,
    beta=1/(d+1), M=max T_new.

These definitions use sets of actual labels. The distinct new sum is
`sum V-a-sum({x,y} intersection R)`, strictly below sum V. There is no
zero speed. A new label may equal the removed a, which does not alter
this calculation; y and x are both below b.

If d=n, failure of the new tuple at alpha, followed by gcd normalization,
would give a smaller primitive sum at the same count. If d<n, least count
instead supplies its own stronger margin 1/(d+1). Normalization preserves
the ordinary maximum by a common time rescaling. Thus in both cases the
ENTIRE closed set

    G_beta={t:||vt||>=beta for every v in T_new}

is nonempty. Write `nu=max_t min_(v in T_new)||vt||>=beta`. No independent
choice of the phases of x,y or the retained labels is allowed. When c=0,
the supplied beta is only alpha; duplicate removal really changes the
count and the available margin rather than preserving n by repetition.

## 2. First mechanism: both common time lifts, with every retained label

At an arbitrary t in G_beta put

    r=||xt||, s=||yt|| in [beta,1/2],
    D=|r-s|, S=r+s,
    p=min(||at||,||bt||), q=max(||at||,||bt||).

Choose signed nearest phases for x and y. Changing their relative sign
only interchanges the sum and difference. Consequently the unordered
old pair norms are exactly

    {D, min(S,1-S)},
    p=min(D,1-S), q=max(D,min(S,1-S)).                        (1)

The formula for p uses D<=S. As S>=2beta>=2alpha, the original pair is
closed-alpha-good at t exactly when

    D>=alpha and S<=1-alpha.                                (2)

Every old retained label is already beta-good at this time. Under original
strict failure, however, p<=mu<alpha on ALL G_beta.

For any integer v, shifting the common time by 1/2 keeps its norm when v
is even and changes it to `1/2-||vt||` when v is odd. Thus:

* If a,b are even, their norms are unchanged. A bad old pair at t remains
  bad at t+1/2. The shift supplies no repair of that pair.
* If a,b are odd, both old pair norms are complemented, and x,y have
  opposite parity, so exactly one of r,s is complemented. EVERY retained
  odd label is complemented as well; these flips cannot be selected
  separately.

In the odd-pair case define

    O(t)=max_(v in R, v odd)||vt||,

with O=0 if the set is empty. The second lift is an original closed-alpha
witness exactly when

    q<=1/2-alpha and O(t)<=1/2-alpha.                        (3)

Retained even labels stay beta-good. Formula (3) includes all equality
cases. Original global mu-coverage, applied also at the second lift, gives
the sharper necessary condition on the complete G_beta:

    p<=mu, max(q,O(t))>=1/2-mu.                              (4)

This is a genuine whole-set consequence of the actual maximum, rather
than a claim about one new witness. Since
`D<=1/2-beta<1/2-mu` and mu<alpha<=1/4, the alternative
`q>=1/2-mu`, together with p<=mu, is equivalent to

    |r-s|<=mu and |r+s-1/2|<=mu,
    equivalently |r-1/4|+|s-1/4|<=mu.                        (5)

Indeed the large pair norm must be min(S,1-S); it is strictly above mu,
so the small one is D. The last equivalence is
`max(|u+v|,|u-v|)=|u|+|v|`. Thus every supplied witness lies either in
this central pair region or has a retained odd label of norm at least
1/2-mu. Minimality supplies no witness outside their union. This is a
necessary constraint, not a new escape or coherence theorem.

### Maximizing the new margin does not select a working lift

Root supplied the exact control

    V_*=(1,2,3,5,7), a=1, b=5, x=2, y=3,
    T_*=(2,3,7), alpha=1/6, beta=1/4.

Here both new labels duplicate retained labels. The new global maximum is
exactly 2/5, with ONLY times 1/5 and 4/5 modulo one. To check this over all
times, `||2t||>=2/5` restricts t to `[1/5,3/10]` or `[7/10,4/5]`.
On the first interval, requiring `||3t||>=2/5` forces t=1/5; on the
second it forces t=4/5. At both points all of 2,3,7 have norm 2/5.
The pair therefore gives the upper bound and the full tuple attains it.

At either new maximizer the original speed 5 has norm zero. The half
shifts are 7/10 and 3/10, where the original retained labels 3 and 7 have
norm 1/10<alpha. The shifted pair itself is good: its norms are 3/10 and
1/2. Thus even selecting ANY GLOBAL new maximizer leaves the retained-
label obstruction. Neither omitted witness components nor a weaker-than-
required new seed explain this failure.

The old tuple has actual maximum 1/4. Its labels all have norm at least
1/4 at t=1/4. For the upper bound, `||t||>1/4` and `||3t||>1/4` force
t into `(5/12,7/12)` modulo one, where `||2t||<1/6`; hence the subtuple
(1,2,3) forbids a margin above 1/4. This is a native-good control, with
`mu(V_*)=1/4>alpha`, NOT a canonical strict failure. Also t=1/4 belongs
to G_beta for T_* and already works for the original tuple. The control
refutes universal two-lift transfer and selection by a global new maximum,
not existence of some selectable witness under the full failure premises.

## 3. Second mechanism: all new good components lie in two fixed old cores

This argument uses the full original maximum throughout time. Define the
open set

    U={t:||vt||>mu for EVERY v in T_new}.

It contains G_beta, because beta>=alpha>mu. Take any connected component
of U and lift it to an interval I in R. Such a lift is proper: the new
positive label y alone has separate good intervals of length
`(1-2mu)/y<1`. On I, the integer parts J_x=floor(xt), J_y=floor(yt)
are fixed and their fractional phases F_x,F_y lie in `(mu,1-mu)`.

All original retained labels are strictly above mu there, so at EVERY
point of I the global original bound forces a or b to be closed-mu-bad.
The inverse identities give

    at=(J_y-J_x)+(F_y-F_x),
    bt=(J_y+J_x)+(F_y+F_x).

Because `F_y-F_x in (-1+2mu,1-2mu)`, only the integer 0 can be within
mu of that difference. Because `F_y+F_x in (2mu,2-2mu)`, only the integer
1 can be within mu of that sum. Hence the ENTIRE component obeys

    I subset H_(a,k) union H_(b,l),
    k=J_y-J_x, l=J_y+J_x+1,
    H_(v,j)=[(j-mu)/v,(j+mu)/v], l-k=2J_x+1.                (6)

The two actual old collision indices have opposite parity. No grid
translation, independent coordinate phase, discarded original label, or
private-only repair is used. This retains every component of U, including
components containing times where both a and b are bad. Floors cannot
change inside I because that would cross an excluded integral new phase.

If the two cores are disjoint, connectedness places I in one of them.
If they meet, their union has length at most `2mu/a+2mu/b`, including
coincident centers, containment and a single touching point. Therefore

    length(I)<=2mu*(1/a+1/b).                               (7)

For the limited arithmetic information in an actual intersection, put
`g=gcd(a,b)` and `D=b*k-a*l`. Then

    g divides D, |D|<=mu*(a+b).                              (8)

If a/g and b/g are both odd, opposite index parity forces D/g odd and
nonzero; equivalently this case has equal 2-adic valuations of a and b.
Then (8) implies `mu>=g/(a+b)`, and strict failure requires
`a+b>N*g`. Different 2-adic valuations do NOT exclude coincident centers:
for a=2,b=4, indices k=1,l=2 have opposite parity and the same center
1/2. This is only a check of that local arithmetic possibility, not an
example of a failing full tuple. No nonzero determinant is silently assumed.

### The resulting global comparison and its numerical limitation

Take ANY common new margin h>mu attained at a time t; in particular one
may use h=beta or the full new maximum nu. With M=max T_new, every new
norm is strictly above mu throughout the open interval

    (t-eta,t+eta), eta=(h-mu)/M.

This follows from the circle Lipschitz bound for each of the actual new
labels. The entire interval lies in one component of U. Applying (7)
and taking lengths yields

    h<=mu*[1+M*(1/a+1/b)].

Consequently the full maxima satisfy the same global bound

    nu<=mu*[1+M*(1/a+1/b)],
    mu>=beta/[1+M*(1/a+1/b)].                               (9)

If nu<=mu the first inequality is immediate; otherwise the protected
interval argument proves it at a maximizing time. The hypotheses for
this comparison use global mu-coverage, not a candidate gauge or one old
deletion seed. The factor nevertheless cannot close the native failure:

    1+M*(1/a+1/b)
      >=1+(a+b)^2/(2ab)>3,
    beta/alpha=(n+1)/(d+1)<=(n+1)/(n-1)<=2.                 (10)

The first line uses M>=y=(a+b)/2 and a<b; the second uses d>=n-2 and
n>=3. Thus the lower bound for mu in (9) is strictly below alpha for
EVERY allowed choice of these parameters. This diagnoses the coarse
length estimate, not an impossibility theorem for the exact component
positions in (6). Neither a needed component choice nor a stronger
arithmetic coupling of those positions is supplied here.

## 4. Scope, remaining implication and checks

The positive global statement is the two-core inclusion (6) on all of U,
with the comparison (9). It is not claimed to improve existing uniform
LRC margins. The first mechanism gives the exact two-lift test and the
necessary all-witness restriction (4)--(5); its maximizer-selection shortcut
is refuted by the fully scoped control. The interval estimate is proved
but is uniformly too weak by (10). No preserved failure follows.

The first unresolved implication is an actual selection or all-time
transport using the original strict-failure/minimality assumptions beyond
these component and lift restrictions. A successful argument must keep
the retained odd labels and the multiply-bad parts in (6), not only repair
one new witness. No such argument emerged in these two bounded attempts.

The accepted parity-coset audit already refutes raising a tracked local
gauge as evidence for a larger GLOBAL minimum after a sum-decreasing
parity basis change. That hold is preserved; this manuscript instead keeps
all witnesses and the original global circle maximum, without claiming
that these are sufficient. No third mechanism, bounded-height substitute,
new failing tuple, axiom, Lean declaration or LRC completion is proposed.

| Input | SHA-256 |
| --- | --- |
| `research/astra-parity-coset-minimum-audit.md` | `b5dd0bbc3ef5d27a986a47b144e225637e338d81c6abceedc2d05d37d392a942` |
| `research/astra-parity-coset-minimum-review.md` | `fda600dd2cdbf2f470bc18e24baeab0bb4b9a90616f34b10d160ba3fa86b3360` |
| `research/astra-minimal-frequency-synthesis.md` | `03cf038021f0bc1a2328bb77a02f6ab4fe649f5d3626d7bc368a67cd6c7b0000` |
| `research/astra-minimal-frequency-review.md` | `b26182c2e482e7f83480eab9904779b958eb8b8b753c70bc45c6fabec55b747d` |
| `research/astra-strict-core-shell-supply.md` | `5cc9866b3c8a516494ad998355265335a5edd15158cf9701c7d814843b97210e` |
| `research/astra-strict-core-shell-review.md` | `dd733c2910f1f4579846c1c945ecac8e83d140eb29917b81dc11d2b1b119b95f` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Current config, workflow, policy and focused state were read, confirming
research/in_progress, explicit start authorization and this sole owned file.
`python3 -B scripts/validate_workflow.py` exited 0 with
`workflow structural validation passed; it cannot certify mathematical validity.`
The parity author/review were fully read and the accepted minimality/core
inputs retained at the displayed bindings. All new arithmetic and control
maxima were checked by hand. Full final readback, binding checks, final
newline/whitespace, workflow validation and frozen hash are returned at
handoff. Only administrative checks were run; no mathematical program,
sweep, solver, local build, cache/dependency work, additional agent,
external model, Git/shared-state/memory write or other-file edit was used.
Independent mathematical review remains required. Unrestricted LRC is open.
