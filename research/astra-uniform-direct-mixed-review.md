# Independent review: uniform direct-or-mixed audit

2026-09-05. Reviewer `/root/mss_published_bound_audit`, requested Astra/xhigh;
observed runtime model/effort are not independently exposed. The active review
record names source checkpoint `27fe083febbc21b0b2c99d2ad421373bd1d0c300`.
Only this review file is owned. Other manuscripts, source, shared state, Git,
Lean, dependencies, and caches were not modified.

**Verdict: accepted at independently reviewed manuscript scope, with no
actionable mathematical findings.** The raw uniform union is false; primitive
N=3 succeeds. The component obstruction is necessary, its owner bound is sharp,
and the two exhibited primitive trap constructions have mixed witnesses in
other components. Primitive uniform supply and unrestricted LRC remain
unresolved. No new Lean theorem is certified here.

## Frozen sources

| Artifact | SHA-256 |
| --- | --- |
| `research/astra-uniform-direct-mixed-audit.md` | `6054472d7412bdb9c5a3c258191f58cf260d50c6240d81eecce05f3be3ba138b` |
| Its sole Python block, including final newline | `cf160dd62d224fa675219fd36efac9c4b6703f9f799c656449d1cee00dd0dc4e` |
| Exact root-replayed stdout | `e0697cefe8f43ed0554396fc9bb4e7977cd5619e02c4c88c600115de2bfce486` |
| `research/astra-mixed-supply-equivalence-review.md` | `f340c0a311ed6e04d802ee8edfb407a84bc329145bc7e9b446d692cd4e52430a` |

All four guards were checked. The imported equivalence was read: it concerns
the full stationary exact-packet contract S for every sorted positive integer
tuple, without a primitive restriction, and permits the N=3 zero-loss case.
Thus the author's S corollaries follow at that existing manuscript scope.
Any change to the guarded author bytes requires reassessing this approval.

## Complete N=3 classification

At N=3, mixed requires fastest norm exactly `1/2`. Divide `(a,H)` by its
positive gcd, giving coprime `0<a'<H'`; time rescaling preserves both ordinary
and mixed existence. The possible lower phases at fastest-half times are
`a'(2k+1)/(2H')`, `0<=k<H'`, a complete list modulo one.

When `a'` is odd, it is invertible modulo `2H'`, so these residues are all
odd residues. When `a'` is even, `H'` is odd, and dividing the residues by
two shows they are all even residues: multiplication by `a'/2` and by two
are invertible modulo `H'`. The largest lower norm is consequently `1/2`
if both parameters are odd, and `(H'-1)/(2H')` otherwise. This is at least
`1/3` for every `H'>=3`. At `H'=2`, necessarily `a'=1`, and the largest
norm is `1/4`. Mixed therefore fails exactly when `H=2a`.

For `(a,2a)`, denominator two is always covered, and denominator three is
covered exactly when `3|a`. Thus the raw direct-or-mixed failures are exactly
`(a,2a)` with `3|a`. They still have ordinary witness `T=1/(3a)`.
The primitive exceptional pair is only `(1,2)`, whose direct denominator
three succeeds; every other primitive N=3 pair is mixed.
The displayed `(6m,12m)` obstruction is a valid subfamily of this complete
classification. Common scaling preserves ordinary and mixed existence, but
can destroy the direct alternative. The raw counterexample is therefore
not a primitive-union failure or an LRC counterexample.

## Component endpoint lattice

For positive integer speeds, the ordinary time-circle good set excludes zero
and is a finite union of closed intervals, possibly singletons. On any complete
component every speed has a fixed floor: crossing an integer would violate its
positive ordinary threshold. If the component has no mixed point, the fastest
phase also cannot cross a half-integer, since `delta0=1/(N-1)<=1/2`.
Reflecting the whole component by `T -> 1-T` when necessary therefore makes
its fastest fractional phase increase below one half throughout `[L,R]`.

At R, some ordinary upper band must end; otherwise the component could extend
rightward. This remains true for a singleton. Fastest speed H is not an upper
owner, since its phase is below `delta0`, whereas an ordinary upper endpoint
has phase `1-1/N`. For each upper owner `a<H`, including every tied owner,
write `R=(n+1-1/N)/a` and `h=HR-k`. Then

```text
s = N*a*h-a = N*H*(n+1)-H-N*a*k-a is integral,
0 <= s < a/(N-1),       s congruent to -(H+a) mod N,
h = 1/N + s/(N*a).
```

If `s=0`, the fastest phase equals its lower ordinary boundary at R. Its
strict increase prevents any ordinary point immediately left of R in the
same floor cell, so the component is a singleton. Positive width therefore
requires `s>=1`; combined with the strict upper bound this gives `a>=N`
for every oriented right upper owner. Reflection changes the endpoint being
examined, not the conclusion. The criterion does not guarantee positive-width
ordinary components, nor does it rule out escape through another component.

For `(5,12,14)`, N=4, the three stated bands intersect exactly in
`[53/56,19/20]`. Fastest speed 14 blocks extension left and speed 5 blocks
extension right. Its fastest phase is `[1/4,3/10]`, below `1/3`; the owner
has `a=5,s=1`. The tuple is primitive and covers every direct denominator.
The distinct mixed witness `T=3/28` has norms `(13/28,2/7,1/2)`.
This disproves component-preserving conversion, not global mixed supply.

## Infinite sharp family

For `N>=4`, `H=N^2-2N-1>N` and `W={3,...,N} union {H}` has N-1 members,
gcd one because 3 and 4 occur, and every direct denominator covered. Put
`R=(N-1)/N^2` and `L=R-1/(N^2*H)`. Direct expansion gives

```text
H*R = N-3+(N+1)/N^2,       H*L = N-3+1/N.
```

The fastest phase remains in `[1/N,(N+1)/N^2]`, strictly below `1/(N-1)`
because `(N+1)(N-1)=N^2-1`. For lower `3<=k<=N`,
`kR<=1-1/N`, with equality only for k=N. Also
`L>(N-2)/N^2`, so `kL>=3L>1/N`. Thus all lower coordinates stay in their
ordinary bands. Fastest speed H blocks extension left at L; speed N alone
blocks extension right at R. The component is complete, has exact positive
width `1/(N^2*H)`, and its unique upper owner `a=N` has `s=1`.
This proves sharpness of the owner's lower bound.

Global mixed witnesses are independently justified for every N. For N>=7,
use `T=1/(N+2)`. Lower residues `3,...,N` have cyclic distance at least two;
`H congruent to 7 mod (N+2)` has that same property since `N+2>=9`.
Hence all norms are at least `2/(N+2)>=1/(N-1)`. For N=4,5,6 the listed
times `1/12,3/28,3/46` have fastest norms `5/12,1/2,1/2` and smallest lower
norms `1/4,9/28,9/46`, respectively. The formula therefore includes all
small cases; it makes no invalid residue-seven claim at N=4,5,6.

## Computational evidence and limits

The root replayed the guarded sole author block successfully. I inspected its
code and verified the exact stdout hash at
`/tmp/astra-uniform-direct-mixed-root-replay.json`. The sweeps use only the
following primitive, direct-covered tuple domains:

| Total N | Fastest H | Eligible tuples |
| --- | --- | --- |
| 4 | 6 through 20 | 351 |
| 5 | 7 through 20 | 1506 |
| 6 | 8 through 18 | 2406 |

The increasing combinations enumerate exactly those tuples. The band
intersection uses exact rationals and `<=`, retains singletons, and checks
each returned endpoint against the original mixed inequalities. Reflection
justifies its restriction to `[0,1/2]`. These are finite diagnostics, not an
unbounded primitive theorem. I did not rerun a tuple sweep.

Separate reviewer `python3 -B` controls, using standard-library `Fraction`,
checked four complete fastest-half lists: `(1,2),(3,4),(2,5),(3,5)` have
maximum lower norms `1/4,3/8,2/5,1/2`. Exact band checks also covered the
N=3 singleton `(1,2)` at `2/3`, with upper owner 1 and s=0, and the N=4
singleton `(5,9,11)` at `3/4`, with both upper owners 5 and 9 and s=0.
Fixed sharp-family members N=4 and N=7 had widths `1/112` and `1/1666`,
unique owner a=N, s=1, valid reflected endpoint norms, and the displayed
global mixed witnesses. All eight fixed controls passed. These supplement
the symbolic proof; they are not additional tuple enumerations.

Current workflow/state and routing were checked;
`python3 -B scripts/validate_workflow.py` passed. The author's initial
validator failure is historical and is explicitly followed by a successful
final replay in the author record. All reviewer commands are stopped at
handoff. Only this review file was written.
