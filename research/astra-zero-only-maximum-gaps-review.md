# Independent review of zero-only maximum-speed gaps

Task `/root/zero_only_maximum_gaps_review`; reviewer session
`/root/coordinate_cancellation_review`; assigned checkpoint
`07d39f4feb40f5fdf7fd26b900d70c7a553e8709`. Requested route:
`gpt-6-astra/xhigh`; observed model, effort, elapsed time, and usage: `null`.
Only this review is owned.

**Accept the complete frozen manuscript below without a mathematical
correction.** The maximum-owner interval theorem, the zero-only center
inclusion, the stronger-margin parent restriction, and the integer boundary
restriction are valid under their stated hypotheses. The rational control
refutes only the local centering assertion with its small-nondivisor
exception omitted. It is LRC-good and does not satisfy the full-failure
hypotheses. No simultaneous blocker exclusion, positive replacement supply,
kernel proof, or unrestricted LRC resolution follows.

## Hypotheses and retained contracts

Let n>=3, N=n+1, alpha=1/N, beta=1/n, and let V be n positive distinct
primitive integer speeds in a hypothetical canonical strict failure,
minimal first by moving count and then primitive sum. Write m=max V,
Q=max(V\{m}), and `0<mu=max_t min_(v in V)||vt||<alpha`. Retain the full
closed deletion-good set `W_m={t:||vt||>=alpha for all v!=m}` and every
attained collision index k modulo m. Least count supplies a common beta
witness for the retained tuple; its strict surplus over alpha also gives
a nonempty interval in W_m. This does not supply a beta witness in every
collision portion.

For an attained k choose the real lift c=k/m, with
`L=c-alpha/m`, `R=c+alpha/m`, `A=(L,R)`, and W_(m,k)=W_m intersect A.
This portion is nonempty and private to A. The accepted strict-core bound
is `|mt-k|<=mu_m`, where `mu_m=mu-m(alpha-mu)/Q` and 0<mu_m<mu.
Its invocation is at the full W_m: all other norms exceed mu for
`|s|<(alpha-mu)/Q`, and connectedness traps the m-phase in one closed
mu-bad component. Endpoint limits give the weak contracted bound. The
interval in W_m rules out mu_m=0. No global parameter of this kind will
be assigned to the separate control below.

Minimum sum also gives some alpha-good replacement witness in W_m for
each 0<u<m, with gcd normalization if necessary. Those witnesses may lie
in different portions; they are not assumed to be centers or beta-good.
The earlier divisor trapping and joint-seed contracts retain these margin
and location distinctions. Their unproved common-time transport is unused.

## The whole maximum-speed portion is an exact closed interval

Every retained speed is smaller than m, so every retained alpha-arc B has
length strictly greater than A. If B meets A, it cannot contain A because
A has an actual private point; it cannot be contained in A because it is
longer. Thus it crosses exactly one endpoint of A. To justify this on the
circle, the sum of their lengths is at most
`2alpha(1+1/m)<1`. Their union is proper and admits a common interval lift;
there cannot be a second intersection component through another lift.

The only possible orders are therefore
`B.left<L<B.right<R` or `L<B.left<R<B.right`. An external tangency does
not meet the open A. Equality with L or R in a putative containment case
still contains the whole open A, so it is excluded by privacy; it creates
no missing third order.

The full original open alpha-family covers both L and R, and no m-arc
does. Both endpoint-cover families are nonempty. Let ell be the largest
right endpoint of a left cover, and rgt the smallest left endpoint of a
right cover. Finiteness makes both attained. Any actual private point is
between them, so ell<=rgt. Within A the left covers have union (L,ell),
and the right covers have union (rgt,R). Every retained arc that meets A
belongs to one of these families. Hence exactly

`W_(m,k)=[ell,rgt]`, with `L<ell<=rgt<R`.

At ell and rgt the original bad arcs are open, so the endpoints survive;
ell=rgt gives a singleton. This proves connectedness for maximum owners,
not for arbitrary smaller owners. It is compatible with the earlier proof
that deliberately allowed disconnected portions without needing to exclude
them.

## The zero-only gap, actual norms, and a seeded center

In the zero-only case every pair of endpoint labels sums to m. Fixing
one side forces a unique label on the other, and same-label open arcs
are disjoint. There are therefore unique endpoint arcs I,J. Their labels
a,b<m are distinct: equal labels would have center separation at least
1/a, whereas their strict overlaps with A give
`1<2alpha(1+a/m)<4alpha<=1`. Take their real centers l/a<c<r/b.
Only these two retained arcs meet A, by the interval theorem.

For any private time set e=mt-k, x=at-l>=alpha, y=r-bt>=alpha. The strict
overlaps give
`x<alpha+(a/m)(alpha+e)` and
`y<alpha+(b/m)(alpha-e)`. Since a+b=m and |e|<alpha, the same cancellation
as in the accepted endpoint source gives |x-y-e|<alpha. But x-y-e=k-l-r
is an integer, so l+r=k. Thus the positive integral determinant satisfies

`D=ar-bl=ak-ml=mr-bk`, `D=bx+ay>=alpha m`.

Each endpoint is private for its unique owner: L belongs to W_a and R to
W_b. Because m is maximum, Q_a=Q_b=m. The positive a-residual at L is
`(D-a alpha)/m>=b alpha/m>0`; it is an actual norm because I covers L.
Its contracted bound is `mu-a(alpha-mu)/m`, yielding D<=(m+a)mu.
The right endpoint gives D<=(m+b)mu. Hence the reused exact window is

`alpha m<=D<=mu(m+min(a,b))`.

Writing z=D-alpha m>=0, the exact complement of I and J in A is

`W_(m,k)=[(l+alpha)/a,(r-alpha)/b]`,
`{mt-k:t in W_(m,k)}=[-z/a,z/b]`.

The endpoint errors follow by multiplying those endpoints by m and using
the determinant identities. In particular error zero occurs: c belongs
to W_m. If z=0 this is the permitted singleton. All statements use the
same endpoint lifts; integer translation of time translates k,l,r by
m,a,b respectively and preserves them.

On this entire interval x=(D+a e)/m and y=(D-b e)/m are at least alpha.
The maximum of x is at e=z/b and equals (D-a alpha)/b. Using
D<=mu(m+b), this is at most
`2mu-a(alpha-mu)/b<2mu<1/2`.
Symmetrically y<1/2. They are therefore the actual parent norms everywhere,
not merely positive signed representatives whose distance could wrap.

If this portion contains a common retained beta-witness, its x,y>=beta
give D=bx+ay>=beta m. Comparing with the determinant upper bound gives

`min(a,b)>=m(beta/mu-1)>m/n`.

The last strict sign uses mu<1/(n+1). At c both parent norms equal D/m
and are consequently beta-good. If all maximum collisions are zero-only,
least count ensures such a seeded portion exists somewhere, but not at
every index.

For any nonparent retained v, no v-alpha-arc meets A. The sum of the radii
alpha/m+alpha/v is below 1/2. Disjointness of these open arcs therefore
gives distance from c to every v-grid center at least that sum, allowing
equality. Taking the nearest grid center and multiplying by v gives

`||vc||>=alpha(1+v/m)`.

Thus v>=m/n implies ||vc||>=alpha(1+1/n)=beta. A beta-seeded portion can
lose its stronger margin on centering only at a nonparent v<m/n.

This possibility cannot be removed by the elementary speed spread. If
s=min V and m<=n s, then at time 1/(m+s) all original phases lie in
`[s/(m+s),m/(m+s)] subset [alpha,1-alpha]`, with no integer wrap. Thus
strict failure requires m>n s. It actually guarantees some retained label
below m/n, while the parents of a seeded zero-only gap are strictly above
m/n. These are compatible restrictions, not a contradiction.

## Integer restriction on the remaining small nondivisors

Let t0 be a beta-witness in this zero-only interval, and suppose a retained
v is beta-bad at c. The preceding bounds make it a nonparent below m/n.
The real segment from c to t0 remains in W_(m,k). Continuity of the v-norm
gives a beta boundary t* on that segment, different from c, with
`vt*=j+sigma/n`, j integer and sigma in {1,-1}. For e*=mt*-k one has

`e*=[m(nj+sigma)-n v k]/(n v)`, `0<|e*|<=mu_m`.

The numerator is nonzero because t* is not c in this fixed lift, and it
is divisible by gcd(m,nv). Thus the first integer lower bound is
`|e*|>=gcd(m,nv)/(n v)`.

For the sharper residue bound put g=gcd(m,v), M=m/g, Vv=v/g. The reduced
numerator `M(nj+sigma)-n Vv k` is a nonzero integer congruent to sigma M
modulo n. If n does not divide M, its absolute value is at least
dist(M,nZ). If n divides M, it is a nonzero multiple of n and its absolute
value is at least n, not zero. Defining d_n(M) by precisely these two cases
therefore gives

`|e*|>=d_n(M)/(n Vv)`, `Vv>=d_n(M)/(n mu_m)`.

In either case d_n(M)>=gcd(M,n)>=1: each relevant nonzero difference
M-nj is divisible by that gcd, and the zero-congruence case has d_n=n.
Since mu_m<1/(n+1), this implies Vv>(n+1)/n, so integral Vv>=2.
If v divides m then Vv=1, impossible. Every divisor therefore preserves
beta in this centering operation. A nondivisor violating the displayed
necessary inequality cannot be a blocker either. If all remaining small
labels violate it, the center is a common retained beta-witness.

This is a sufficient condition on the actual labels, not a theorem that
they satisfy it. The crossing uses one actual common time segment, with
all other coordinates retained in W_m. No phase-preserving translation or
arbitrary seed relocation was assumed. Even complete retained beta-goodness
at c leaves ||mc||=0 and provides no original-tuple witness by itself.

## Exact local control and falsification scope

For n=6, alpha=1/7, beta=1/6, use the positive distinct primitive tuple
V={2,5,7,22,27,49}, with m=49, k=4, c=4/49=28/343 and endpoints
L=27/343, R=29/343. Direct multiplication and nearest-integer reduction
give the retained norms in order 2,5,7,22,27:

`L: (54,135,154,92,43)/343`,
`R: (58,145,140,48,97)/343`.

The threshold is 49/343; hence only the (27,2) arc covers L and only the
(22,2) arc covers R. The m-norm is exactly alpha at both endpoints and
does not cover them openly. The parent labels sum to 49 and numerators to
4, with D=27*2-22*2=10 and z=D-alpha m=3.

The three nonparent center norms are (56,140,147)/343, respectively larger
than the disjointness bounds (51,54,56)/343. Thus none of their arcs meets
A. For the two parent labels the centered phases are 2+10/49 and
2-10/49. Every other parent-grid index has phase distance at least 39/49,
greater than the corresponding bounds 76/343 and 71/343, so no additional
parent arc enters A either. These direct exclusions do not use global
strict failure. Intersecting the two parent complements yields exactly

`W_(49,4)=[5/63,13/154]`,
`{49t-4:t in W_(49,4)}=[-1/9,3/22]`.

This nonempty interval lies strictly inside A and establishes actual
privacy of its maximum arc. The time t0=1/12 is in its interior, since
5/63<1/12<13/154. Its retained norms are
`(1/6,5/12,5/12,1/6,1/4)`, all beta-good. At c, the speed-2 norm is
8/49<1/6; the others are 20/49, 3/7, 10/49, and 10/49, all above beta.

For this blocker v=2, the boundary is t*=1/12, e*=1/12. With j=0 and
sigma=1 the integer numerator is `49-6*2*4=1`. Thus M=49, Vv=2,
d_6(M)=1, and the lower bound d_6(M)/(6Vv)=1/12 is attained exactly.
This verifies the integer boundary calculation without assigning mu_m to
the control.

Finally, at t=1/6 the full six-tuple norms are
`(1/3,1/6,1/6,1/3,1/2,1/6)`. The true global maximum is therefore at
least 1/6>alpha. No exact global maximum, mu<alpha, contraction parameter,
minimum-failure status, or global transport is asserted for this tuple.
It uses the native alpha and beta for its count, but is LRC-good. Its role
is to refute only local zero-only geometry plus a beta seed implying
unqualified beta-goodness of the collision center.

## First unresolved implication and checks

The exact interval and arithmetic restrictions are positive conditional
results. The first missing step is to handle the remaining small
nondivisors simultaneously using full-failure and coordinate-minimality
information. A beta seed somewhere, the determinant window, and separate
replacement witnesses do not supply that step. Successful centering would
still require an escape or positive count-preserving descent from a point
where m has phase zero. Neither is proved here. The local control is not
a hypothesis-complete counterexample to such a future implication.

The full frozen author was read and hand-checked. Its eleven bindings were
verified unchanged. Prior complete reads and accepted reviews were reused
at the exact invoked scopes, especially the all-choice zero-only endpoint
theorem and strict-core contraction. No historical mathematical program
or wider source audit was repeated. The new interval, seeded restrictions,
residue calculation, and all control fractions were checked directly above.

| Input | SHA-256 |
| --- | --- |
| `research/astra-zero-only-maximum-gaps.md` | `f21fc1de78ee9802ecf8992677395507984d26894b220b9890849054077546da` |
| `research/astra-forced-cycle-frequency-exchange.md` | `4ac28414ec9043c9ed11d69b7cc8520a2a1acc3b74168147acfc38091959046f` |
| `research/astra-maximum-frequency-exchange-review.md` | `9cd1282b49034073ad59e8df183df7e7b2cc65ce359d8ec8b088c6c032ab9515` |
| `research/astra-minimal-frequency-synthesis.md` | `03cf038021f0bc1a2328bb77a02f6ab4fe649f5d3626d7bc368a67cd6c7b0000` |
| `research/astra-uniform-divisor-minimality.md` | `8c4b6ee094f0f311f360d3abf371e95f731e28cee997d3810dd3218ff6f25746` |
| `research/astra-joint-seed-maximum-audit.md` | `ac73e29474e272167403c91db34331236bb3832f7ce916b2997d7c2f0d6b46ac` |
| `research/astra-strict-core-shell-supply.md` | `5cc9866b3c8a516494ad998355265335a5edd15158cf9701c7d814843b97210e` |
| `research/astra-strict-core-shell-review.md` | `dd733c2910f1f4579846c1c945ecac8e83d140eb29917b81dc11d2b1b119b95f` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Current config, workflow, policy, and focused live state were read. The
gate was research/in_progress with explicit start authorization at
`2026-09-05T04:12:25.208107+00:00`, and this task's route, source, and
sole owned path were recorded. Observed runtime metadata remained null.
`python3 -B scripts/validate_workflow.py` exited 0 with
`workflow structural validation passed; it cannot certify mathematical validity.`

The full owned review was read back. All twelve table bindings were checked
with `sha256sum` and final byte-hash comparison; final newline/whitespace
and workflow checks passed. These checks are administrative, separate from
the independent hand proofs. No mathematical program, search, solver,
build, cache operation, extra agent, external model, Git/shared-state edit,
memory write, or other-file edit was performed. The frozen author and other
inputs were preserved. No mathematical error or requested author correction
occurred. The final review hash is returned separately.
