# Independent review of the joint deletion-seed maximum

**Accepted at the stated conditional manuscript scope; no correction required.**
The joint separation and first-entry inequalities are valid. The fastest-seed
endpoint construction gives an explicit good smaller replacement, consistent
with minimality. The all-pivot endpoint invariant is a valid application of
the accepted selector, and the uniform distance to original strong seeds uses
the full maximum speed P. None of these statements supplies the missing
original-seed transport, a lower simultaneous blocker, a smaller failure,
or unrestricted LRC.

Review date: 2026-09-06. Task `/root/joint_seed_maximum_review`, in the
requested existing Astra/xhigh session. Review checkpoint:
`ca9d2d7f20f66cceb7db3b440d0378203624aa39`.
The entire frozen author file read is
`research/astra-joint-seed-maximum-audit.md`, SHA-256
`ac73e29474e272167403c91db34331236bb3832f7ce916b2997d7c2f0d6b46ac`.
Its own source provenance remains
`d0f1fee0850373e5b35a9883752d45b226d5f868`.

All eight listed dependencies and reviews were read, including their retained
code and receipt text without executing it. Every current binding matched:

| File in research/ | SHA-256 |
| --- | --- |
| `astra-uniform-all-deletion-seed-screen.md` | `b2b6acd00dae3c8ed777bc3da4227fab0254016eec035c2c100f8d346a398f1b` |
| `astra-uniform-seed-screen-review.md` | `11f738862f1302dda62e2f0fcd7c8cdff0b3dad9462297b79cd1769371c70522` |
| `astra-uniform-seed-coupling.md` | `b52f92b8dca3de5b0ba9f41c24c2dc6bd83a27329a035d40a1273a0401f215ea` |
| `astra-uniform-seed-coupling-review.md` | `537c008719aa858c9d97ab46acb5b5cd197b873a78d0266aeae6c05950c7c0bb` |
| `astra-uniform-global-seed-geometry.md` | `3a4a825f3f801282eb39b469571bbd4cac3a4e1f768d58542b7c1555cd725524` |
| `astra-uniform-global-seed-geometry-review.md` | `dd1cb0c56f383cd9c4c92c7789a889c591da8a7f6eb7b418c06466546e05752d` |
| `astra-minimal-height-audit.md` | `40e59ba4539eb931a07612e9b972999d3b48006d39ef4760c0e493d08e734325` |
| `astra-minimal-height-review.md` | `4570fa22f788a0e832165dd4ec5da613003a0181b0200267fcc30b44d9776e92` |

The new results use the accepted protected-radius and endpoint-selector
proofs. They do not treat the old bounded controls as evidence for a uniform
supply claim or revive their refuted local transition rules.

## 1. Hypothetical minimum and the joint bound

The premise is an actual failure of the closed ordinary integer LRC statement,
chosen first with least moving count and then with least natural sum among
failures at that count. Its positive distinct speed set V has `N-1` elements,
with integer `N>=7`. Speeds themselves serve as labels. Define

```
delta=1/N, gamma=1/(N-1), eta=gamma-delta,
P=max V, M_p=max(V minus {p}),
S_p={s: ||v s||>=gamma for every v!=p},
W_p={s: ||v s||>=delta for every v!=p},
rho_p(s)=min_(v!=p) (||v s||-delta)/v,
F_p(s)=||p s||+p rho_p(s).
```

Count minimality supplies each S_p at its honest own-count margin gamma.
Integer speeds make these sets and scores periodic with period one. Each
S_p is a nonempty closed subset of a compact period, and F_p is continuous,
so the maximum over all original deletions and seeds is attained.

At every seed all retained norms exceed delta. Full original failure therefore
forces `||p s||<delta`. Its protected ball is old delta-good, and the pivot's
maximum norm on that ball is `min(1/2,F_p(s))`. Since `delta<1/2`, a score
at least delta would give a full closed witness. Thus each score is strictly
below delta; attainment, rather than a bare supremum argument, gives

`Lambda=max F_p(s)<delta`, `g=delta-Lambda>0`.

For every fastest-deletion seed,

`rho_P(s)>=eta/M_P`, hence `F_P(s)>=P eta/M_P>eta`,

because P is strictly greater than every old speed. Nonemptiness of S_P
then gives `eta<Lambda<delta`. This does not show that a maximizing label
is P.

The accepted finite endpoint reduction maximizes a score at a strong seed
component endpoint or a pivot antipode. A seed antipode would already be
a full witness, so a joint maximizer may be chosen at a strong endpoint,
including a singleton. Integral pivot phases are cusp minima between the
monotone pieces and create no missing maximizer case. No conclusion about
the maximum on the larger weak set W_p follows.

For a weak component `[L,R]` containing a seed s, the exact radius is
`min(s-L,R-s)>0`. More strongly, **full original failure** gives
`W_p subset {t: ||p t||<delta}`. Connectedness puts each entire weak
component in a single open p-bad interval. Failure only of the protected
construction would not imply this containment, as the author correctly notes.

## 2. Separation and the short first-entry comparison

For distinct p and q, let `s in S_p`, `t in S_q`. Since p is retained
in the q-deletion radius,

`||p t||>=delta+p rho_q(t)`.

The global bound at s gives `||p s||<=Lambda-p rho_p(s)`. Combining these
with p-Lipschitz continuity proves

`|t-s|>=rho_p(s)+rho_q(t)+g/p`.

Interchanging p and q and taking the stronger inequality replaces `g/p`
by `g/min(p,q)`, as claimed. The proof applies to every integer translate
of t with unchanged score and radius, so choosing a nearest translate
also proves the statement for time distance modulo one.

Now let `(p,s)` attain the joint maximum and put
`r=rho_p(s)`, `beta=||p s||=Lambda-p r`. We have
`0<=beta<delta<gamma<1/2`. Choose the direction increasing the distance
from the nearest pivot collision. Before any antipode is encountered,
the first gamma entry u in that direction satisfies

`|u-s|=(gamma-beta)/p=r+(eta+g)/p`.

If beta is zero either direction works. If beta is positive the opposite
first entry has distance `(gamma+beta)/p`; it is not covered by this
short-entry formula. The strict and equality cases at gamma are preserved.

Suppose this actual u belongs to an original `S_q`, with `q!=p`. The
retained q coordinate at s obeys `||q s||>=delta+q r`. Therefore

```
||q u|| >= delta+q r-q|u-s| = delta-(q/p)(eta+g),
F_q(u) >= delta-(q/p)(eta+g)+q eta/M_q.
```

The last term uses the genuine radius bound at a q-seed, not an assumed
seed at an endpoint. Comparing with `F_q(u)<=Lambda=delta-g` yields

`(1-q/p)g <= q eta(1/p-1/M_q)`.

For p=P, every other q has `q<P` and `M_q=P`, making the right side
zero and the left side strictly positive. Consequently the short entry
u cannot belong to any such S_q. It cannot belong to S_P either: its
P norm is gamma, so that would be a full gamma witness. Since P is
gamma-good at u, zero bad old labels would give a full witness, while one
strictly gamma-bad old label q would give membership in S_q. Hence there
are at least two strictly gamma-bad retained labels at u. When beta is
zero the reasoning applies to both first entries; otherwise it applies
only to the norm-increasing short entry.

For `q<p<P`, we have `M_q=P`, and dividing the displayed inequality by
the positive factor `(p-q)/p` gives exactly

`g <= eta*q*(P-p)/(P*(p-q))`.

The author does not claim an improvement for every velocity ordering.
These are new necessary comparisons using the joint bound. They do not
supply an S_q at the proposed u or force a maximizing pivot to be fastest.

## 3. The fixed endpoint invariant applies to every original deletion

For any original p, let E_p be the finite weak endpoint set of W_p in one
period. It is nonempty: count minimality supplies S_p, and positivity and
integer periodicity bound the old-good components. At every p-row candidate
`r/(Np)` with `N` not dividing r, p is closed delta-good. Full original
failure therefore supplies complete old coverage of this actual p-row.

The accepted selector requires a nonempty finite set of positive integer
old speeds, a positive reference p, that row coverage, and
`2q<=(N-2)p`. It has no largest-pivot requirement. For every integer
`0<q<p`, the inequality holds under `N>=7`. Replacing p by q and
deduplicating either gives the same moving count with smaller sum, or a
smaller moving count. Minimality supplies a closed delta witness in the
fresh case and a gamma witness, hence a delta witness, in the duplicate
case. The selector then supplies an endpoint of the same E_p where q is
closed delta-good.

Full failure makes p strictly delta-bad at every endpoint. Thus, for all p,

`forall 0<q<p, exists e in E_p: ||q e||>=delta`,
`forall e in E_p: ||p e||<delta`.

An endpoint has an actual old boundary owner, so its denominator divides
`N*lcm(V minus {p})`. Simultaneous endpoint badness is periodic in the
test speed, with p its least positive blocker. This all-label statement
is an application of an already established selector plus minimality.
It does not construct a smaller speed bad at every endpoint; that opposite
condition would be required for the selector's descent contrapositive.

## 4. Outward fastest endpoint and the smaller replacement

Let s be any seed in S_P, not necessarily a joint maximizer. It lies
strictly inside its weak component I. Put `beta=||P s||` and choose the
endpoint e in the norm-increasing direction, either endpoint if beta is
zero. With `sigma=+1` for a right endpoint and minus one for a left
endpoint, write `s=e-sigma*d`, where d is positive. Full failure traps I
in one open P-bad interval, so for its collision integer k,

`P e-k=sigma*beta_e`, `beta_e=beta+P d<delta`.

In particular `d<(delta-beta)/P<=delta/P`. An old exit owner a exists.
At the right exit its fractional phase is the upper boundary, and at the
left exit it is the lower boundary. A lower boundary at a right exit,
or an upper boundary at a left exit, could not have the preceding strong
seed in the same good band. Thus for an integer m,

`a e-m=-sigma*delta`.

Distinctness and maximality of P give `0<a<P`. Set `q=P-a`, a positive
integer smaller than P. Direct subtraction gives the author's signed
identities

```
a s-m = -sigma*(delta+a d),
q e-(k-m) = sigma*(beta_e+delta),
q s-(k-m) = sigma*(beta+delta+a d).
```

All these expressions specify actual common-time phases. Their magnitudes
are in the nearest-integer range, because

```
delta+a d < 2delta < 1/2,
0 < beta+delta+a d
  = beta_e+delta-q d < beta_e+delta < 2delta < 1/2.
```

There is therefore no hidden wrap or antipodal ambiguity. Since s is a
strong old seed and `rho_P(s)<=d`, the exact norm conclusions are

```
||q s|| = beta+||a s|| >= gamma+beta,
||q e|| = delta+beta_e >= delta+F_P(s).
```

For `t=s+sigma*u`, `0<=u<=d`, the signed q phase is
`sigma*(beta+delta+a d+q u)`. It stays below one half in magnitude and
increases from its value at s to that at e. Thus q stays gamma-good on
the whole segment, while all original old labels stay delta-good. At s
all old labels are gamma-good; it is an explicit full gamma witness for
the replacement `(V minus {P}) union {q}`. This remains correct when q
duplicates an old label: the set is deduplicated and its count decreases.
If q is fresh, its sum decreases at the original moving count, and the
explicit gamma witness is stronger than minimality's guaranteed delta.

Moreover `F_P(s)>=P eta/M_P>eta`, so the endpoint replacement norm is
strictly greater than `delta+eta=gamma`. When this particular seed is a
joint maximizer, its bound strengthens to `||q e||>=delta+Lambda`.
No such Lambda substitution is made for an arbitrary fastest seed.

This construction exhibits a good endpoint for a smaller q, exactly the
direction required by minimality's invariant. It creates no smaller
counterexample and does not provide a seed for another original deletion.

## 5. Weak endpoints are separated from original strong seeds

For every `e in E_p`, choose an actual old boundary owner a. Then
`||a e||=delta` and `||p e||<delta`, with `a!=p`. These are two distinct
original gamma-bad labels, so e belongs to no original S_j.

If `t in S_j` and `j!=a`, a is retained and Lipschitz continuity gives

`|t-e| >= (gamma-delta)/a = eta/a`.

If `j=a`, p is retained, and instead

`|t-e| >= (gamma-||p e||)/p > eta/p`.

Since `a,p<=P`, both cases imply the safe uniform lower bound `eta/P`.
Applying the same inequalities to integer translates proves the bound
for periodic time distance. The full maximum P is essential to this stated
uniform conclusion; replacing it by the complement maximum M_P has not
been justified. The author explicitly preserves the correct distinction.

The joint maximum is defined on strong seed sets, not on E_p. In
particular the outward fastest endpoint has `beta_e>=F_P(s)` and is not
an admissible place to apply an upper bound by Lambda. Other weak components
may contain no strong seed at all. Neither type of weak endpoint can be
identified with a maximizing strong endpoint by relabelling its owner.

## 6. Verdict, new content, and remaining transport

The new manuscript content consists of the cross-deletion separation,
conditional first-entry score comparison, and exact outward replacement
identities with their margins. Extending the least-blocker invariant to
all original pivots is a legitimate use of the earlier general selector.
The endpoint-to-seed separation makes a quantifier gap explicit. These are
necessary consequences of the hypothetical minimum, not an existence
proof for that minimum or an unrestricted witness supply theorem.

Full original failure is materially used to exclude pivot-good seeds and
antipodes, trap entire weak components, cover each actual pivot row, and
spoil every weak endpoint. Mere failure of Q would not permit all of these
steps. Conversely, actual nonempty strong sets supplied by count minimality
have no proved location at the transported first-entry time. A contradiction
still needs original-label seed transport that makes the comparison strict,
or a smaller positive speed bad at every endpoint of one fixed E_p, or
another operation producing a genuine smaller failure. The constructions
proved here supply none of those missing steps.

The complete frozen manuscript and eight dependencies were read and hash
checked. Verification was hand Lipschitz algebra, phase-band geometry,
finite-set minimality, compactness, and the accepted selector with its full
unchanged hypotheses. No old control or embedded mathematical program was
executed. The current project configuration, workflow, policy, and focused
active state were read. The command
`python3 -B scripts/validate_workflow.py` exited 0 with complete output:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

Author and review passed trailing-whitespace and final-newline checks.
Only this review file was written. No mathematical search, solver, Lean
command, cache restoration, Git operation, shared-state change, or delegation
was performed. Per-task elapsed time, token usage, and independently observed
runtime model metadata are unavailable and remain null. No owned process or
dependency-cache requirement remains. This acceptance is manuscript-level
and leaves the unrestricted LRC goal unresolved.
