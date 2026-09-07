# Independent review of same-parity pair replacement

Task `/root/same_parity_pair_descent_review`; reviewer session
`/root/coordinate_cancellation_review`; assigned checkpoint
`3c71f4dc668896ff37169570f81bb9c87c899627`. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed time and usage: `null`.
Only this review is owned.

**Accept the complete frozen manuscript below without correction.** The
distinct-count supply, exact two-lift restrictions, whole-component
two-core inclusion and global maximum comparison are valid. The control
refutes selection by a new global maximizer, not existence of a favorable
new witness under full strict failure. The coarse guaranteed margin is
insufficient for contradiction; this does not exclude stronger use of the
exact new maximum or component positions. No failure-preserving descent,
kernel theorem or unrestricted LRC resolution is established.

## Admissibility and the supplied margin

Assume n>=3 positive distinct primitive integer speeds V form a hypothetical
canonical strict failure, least by moving count and then primitive sum.
Set alpha=1/(n+1), and let the ACTUAL old global maximum satisfy
`0<mu=max_t min_(v in V)||vt||<alpha<=1/4`.
For original same-parity a<b, put
`x=(b-a)/2`, `y=(b+a)/2`, `R=V\{a,b}`, `T=R union {x,y}`.
Both new labels are positive integers, x<y<b, and x+y=b.

Let `c=|{x,y} intersection R|`. Since x,y are distinct, the exact count
is `d=(n-2)+2-c=n-c`, c in {0,1,2}. The exact distinct sum is

`sum T=sum V-a-b+x+y-sum({x,y} intersection R)`
`     =sum V-a-sum({x,y} intersection R)<sum V`.

If x equals the removed a it is not a collision with R, and the formulas
remain unchanged. If c=0, a hypothetical new failure at alpha would,
after dividing its gcd, give a smaller primitive failure at the same
count. If c>0, least count supplies a witness at the new native margin
`beta=1/(d+1)`. For a normalized tuple T/g, a witness at s transfers
back to T at s/g; positivity and distinctness persist. Thus in all cases
the full closed set G_beta of new witnesses is nonempty and
`nu=max_t min_(v in T)||vt||>=beta>=alpha>mu`. No repeated labels are
used to inflate d or artificially preserve the old threshold.

## Exact pair norms and both common time lifts

At any t in G_beta let `r=||xt||`, `s=||yt||`, so r,s in [beta,1/2].
The signed nearest representatives are +/-r and +/-s. Changing their
relative signs exchanges the sum and difference, so the unordered old
pair norms are exactly

`{D,T_0}`, where `D=|r-s|`, `S=r+s`, `T_0=min(S,1-S)`.

Here 0<=D<=1/2 and 0<=S<=1. Consequently
`p=min(||at||,||bt||)=min(D,1-S)` because D<=S, and
`q=max(||at||,||bt||)=max(D,T_0)`. Since S>=2beta>=2alpha, the old
pair is closed-alpha-good precisely when D>=alpha and S<=1-alpha.
All retained old labels are already beta-good. Hence the full global
old bound forces p<=mu on EVERY point of G_beta.

For integral v, a common shift by 1/2 preserves ||vt|| when v is even
and replaces it by 1/2-||vt|| when v is odd. If a,b are even, the bad
pair therefore remains bad. If they are odd, both pair norms are
complemented; x,y have opposite parity, and every retained odd label
is complemented by the SAME shift.

Let O be the maximum original norm over retained odd labels, with O=0
if none exist. At the shifted time the pair minimum is 1/2-q. All
retained even labels remain beta-good, while all retained odd labels
are alpha-good exactly when O<=1/2-alpha. Thus the exact closed-witness
test for this second lift is

`q<=1/2-alpha` and `O<=1/2-alpha`.

Using the actual global bound at that time instead gives the necessary
whole-G_beta conjunction

`p<=mu`, `max(q,O)>=1/2-mu`.

The empty-O convention is harmless: 1/2-mu>0, so it cannot create the
second inequality. Neither original nor shifted retained labels are omitted.

For the pair branch, `D<=1/2-beta<1/2-mu`. Therefore q>=1/2-mu
forces T_0>=1/2-mu, equivalently |S-1/2|<=mu. Since mu<1/4, this
T_0 is strictly greater than mu. Combining with p<=mu then forces
D<=mu. Conversely these two bounds give p<=mu and q>=1/2-mu.
Thus the conjunction is exactly

`|r-s|<=mu` and `|r+s-1/2|<=mu`,
or `|r-1/4|+|s-1/4|<=mu`.

The last equivalence is the elementary maximum identity for the sum
and difference of r-1/4 and s-1/4. It is NOT a standalone identity for
the shifted minimum: both p<=mu and the large-q condition are used,
as are beta>mu and mu<1/4. Every new witness consequently lies in the
diamond or has O>=1/2-mu; no witness outside that union is supplied.

## Exact old/new maxima and the selection control

For old V_*=(1,2,3,5,7), choosing a=1,b=5 gives x=2,y=3 and
T_*=(2,3,7), with c=2,d=3,alpha=1/6,beta=1/4.
On one period, ||2t||>=2/5 restricts t to [1/5,3/10] or [7/10,4/5].
On the first interval ||3t||=1-3t and is >=2/5 only at t=1/5;
on the second ||3t||=3t-2 and is >=2/5 only at t=4/5. At both times
all three new norms equal 2/5. Therefore the actual new maximum is
exactly 2/5, attained ONLY at those two times modulo one; the pair
also excludes any higher margin over all real times.

At both maximizers the original 5-norm is zero. Their half-shifts are
7/10 and 3/10 modulo one. At each, the old pair norms are 3/10 and
1/2, but retained labels 3 and 7 both have norm 1/10<alpha (label 2
has norm 2/5). Thus every new global maximizer fails at both allowed
old lifts, despite its stronger new margin.

For the old maximum, t=1/4 gives norms
`(1/4,1/2,1/4,1/4,1/4)`. If both ||t|| and ||3t|| exceeded 1/4,
their exact good-band intersection would place t in (5/12,7/12)
modulo one, where ||2t||<1/6. Hence the old maximum is exactly 1/4.
The same time 1/4 is a new beta-witness and already works for the old
tuple. This proves the stated selection obstruction with every new
maximizer accounted for. Since old mu=1/4>alpha, it is a native-good
control, not a strict-failure counterexample or a counterexample to
favorable witness selection with all failure hypotheses restored.

## Every open new-good component lies in two fixed old cores

Let `U={t:||vt||>mu for every v in T}`. It contains G_beta. Each
connected component has a proper real interval lift I: the positive label
y already bounds it by a good interval of length (1-2mu)/y<1.
On I, floors J_x=floor(xt), J_y=floor(yt) are fixed, since crossing
an integer would violate new goodness. The fractional parts F_x,F_y
stay in (mu,1-mu).

At EVERY point of I all retained old labels exceed mu, so a or b must
be closed-mu-bad. In the exact identities

`at=(J_y-J_x)+(F_y-F_x)`,
`bt=(J_y+J_x)+(F_y+F_x)`,

the difference lies in (-1+2mu,1-2mu), which is farther than mu from
either adjacent nonzero integer. The sum lies in (2mu,2-2mu), farther
than mu from 0 and 2. Thus the only possible respective collision indices
are `k=J_y-J_x` and `l=J_y+J_x+1`. Therefore

`I subset H_(a,k) union H_(b,l)`,
`H_(v,j)=[(j-mu)/v,(j+mu)/v]`, `l-k=2J_x+1`.

This proves the full component inclusion with FIXED, opposite-parity
indices. It retains points where both old labels are bad and uses no
assumption about old deletion-set membership. The cores are closed;
their boundary points and possible tangency are retained. If disjoint,
connectedness puts I in one core. If intersecting, their union has
length at most the sum of lengths, even with containment or coincidence.
In all cases `length(I)<=2mu*(1/a+1/b)`.

For an actual core intersection, put `g=gcd(a,b)`, `D=b*k-a*l`.
The distance of their centers gives `|D|<=mu*(a+b)`, and g divides D.
If a/g and b/g are both odd, then D/g has parity k-l and is odd,
so |D|>=g. This case is exactly equality of the 2-adic valuations of
a and b. It forces `mu>=g/(a+b)` and, under strict failure,
`a+b>(n+1)*g`. This conclusion concerns an actual intersection, not
components lying in a single disjoint core.
Different valuations permit D=0: a=2,b=4,k=1,l=2 have opposite index
parity and common center 1/2. This is a local arithmetic check only;
no hypothetical failing tuple is assigned to it.

If a new time has common margin h>mu and M=max T, the circle Lipschitz
bound places the entire open interval of radius `(h-mu)/M` about that
time in U. It lies in a single lifted component. Comparing its length
with the established bound gives

`h<=mu*F`, where `F=1+M*(1/a+1/b)`.

Apply this to an attained maximizing time to get `nu<=mu*F`; if
nu<=mu that inequality is immediate anyway. Minimality supplies nu>=beta,
so also `mu>=beta/F`. This is a comparison of actual global maxima,
not a tracked local gauge or a bound tested at only one chosen old seed.

However, M>=y gives
`F>=1+(a+b)^2/(2ab)>3`, since a<b. Meanwhile d>=n-2 and n>=3 give
`beta/alpha=(n+1)/(d+1)<=(n+1)/(n-1)<=2`.
Thus the guaranteed lower bound beta/F is strictly below alpha for
every allowed choice: it cannot contradict mu<alpha. This diagnosis
uses the SUPPLIED beta, not an upper bound on nu/alpha. A sharper value
of nu or additional information on exact core positions could still
strengthen an argument; neither is ruled out or supplied by this estimate.

## Scope, bindings and checks

The first unresolved implication is favorable witness selection or valid
all-time failure transport under the full minimality assumptions, beyond
the lift barriers and component inclusion. Retained odd labels cannot be
dropped, and multiply-bad parts cannot be replaced by a single-deletion
domain. The manuscript proves restrictions and a coarse comparison,
without a uniform descent. Its controls do not satisfy native strict
failure. The accepted parity-coset audit's distinction between a tracked
candidate gauge and the global minimum remains intact; no new result
from that audit is assumed to resolve the missing quantifier.

The author was fully read and all displayed arithmetic checked by hand.
The parity-coset author and accepted review were fully read at the bound
hashes; the unchanged minimality and strict-core inputs retain their
earlier checked scope. All ten complete author input hashes matched.
The table binds the author and all ten inputs.

| Input | SHA-256 |
| --- | --- |
| `research/astra-same-parity-pair-descent.md` | `9ccb99d3ef297b5e1e3bb1f0dd6bc20234ff895ebcbe40d362098aaf72903a35` |
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

Current config, workflow, policy and focused state were read, with gate
research/in_progress and explicit start authorization recorded at
`2026-09-05T04:12:25.208107+00:00`. The active task matched this route,
checkpoint and sole owned file. `python3 -B scripts/validate_workflow.py`
exited 0 with `workflow structural validation passed; it cannot certify
mathematical validity.` Complete final readback, eleven source/input
bindings, whitespace/final newline and final workflow checks passed before
the separately reported frozen hash. Only administrative commands ran;
there was no mathematical program, enumeration, solver, Lean execution,
build, cache/dependency work, extra agent, external model, Git/shared-state/
memory write or other-file edit. The author remained frozen and required
no correction. Unrestricted LRC remains unresolved.
