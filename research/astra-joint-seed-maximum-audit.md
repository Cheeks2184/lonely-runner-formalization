# Joint deletion-seed maximum and minimal-height compatibility

This bounded audit proves a quantitative cross-deletion comparison using the
global maximum, and an exact smaller-replacement compatibility lemma at the
fastest deletion's endpoints. Neither argument produces a contradiction or
a smaller counterexample. The missing original-label seed transport and the
missing lower simultaneous endpoint blocker remain explicit.

Task: `/root/joint_seed_maximum_audit`, requested Astra/xhigh.
Source checkpoint: `d0f1fee0850373e5b35a9883752d45b226d5f868`.
Only this manuscript is owned. Concurrent files are preserved. No numerical
program, search, solver, Lean/cache work, or Git/state mutation was used.

## 1. Hypothetical minimum and the actual global extremum

Suppose a positive distinct integer LRC failure is minimal first by moving
count and then by the natural sum of speeds. Let its speed set be V, with
|V|=N-1 and N>=7. We use the speed itself as its label. Put

    delta=1/N,  gamma=1/(N-1),  eta=gamma-delta,
    P=max V,   M_p=max(V minus {p}),
    W_p={t: ||v t||>=delta for all v in V minus {p}},
    S_p={t: ||v t||>=gamma for all v in V minus {p}},
    rho_p(s)=min_(v!=p) (||v s||-delta)/v,
    F_p(s)=||p s||+p rho_p(s),    s in S_p.

The full closed delta-good set is empty. Count minimality supplies every
S_p. Each S_p is a nonempty compact set modulo the integer period 1; the
score is continuous there. Therefore the joint maximum

    Lambda=max_(p in V) max_(s in S_p) F_p(s)

is attained. The exact protected-ball lemma gives F_p(s)<delta at every
seed: otherwise its ball would contain a full closed delta witness. Compact
attainment strengthens these pointwise inequalities to

    Lambda<delta,    g=delta-Lambda>0.                     (1)

Moreover rho_P(s)>=eta/M_P for any fastest-deletion seed, and P>M_P, so

    Lambda >= F_P(s) >= P eta/M_P > eta.                  (2)

Every pivot antipode in a seed set would itself be a full witness, and is
therefore excluded. The accepted endpoint reduction consequently permits
a joint maximizer at a **strong** seed-component endpoint, including a
singleton. These are endpoints of S_p, not the weak endpoints of W_p used
in the minimal-height argument below. No maximum property on all of W_p
is implied.

The radius identity on a weak component I=[L,R] containing s is

    rho_p(s)=min(s-L,R-s).

Its protected ball lies in W_p. Under full failure, the entire connected
component I lies in one open p-bad interval, not only the protected ball.
The arguments below use the stated full-failure hypothesis when making
this stronger assertion. Q failure by itself would not justify it.

## 2. Approach one: a genuinely global transport comparison

First, the common bound Lambda supplies a quantitative separation between
different deletion seed sets. For p!=q, s in S_p and t in S_q,

    |t-s| >= rho_p(s)+rho_q(t)+g/min(p,q).                 (3)

Indeed, the q-seed condition and its radius give
||p t||>=delta+p rho_q(t), while the global score bound gives
||p s||<=Lambda-p rho_p(s). The p-Lipschitz estimate therefore yields
|t-s|>=rho_p(s)+rho_q(t)+g/p. Interchanging p and q yields the version
with g/q, proving (3). The same statement holds for time distance modulo
1 by choosing the nearest integer translate. It is a separation statement,
not a claim that these sets or their protected unions cover the circle.

Now take an actual joint maximizing seed s in S_p and write

    r=rho_p(s),    beta=||p s||=Lambda-p r.

Choose the direction in which the pivot norm increases, and let u be the
first time in that direction at which it reaches gamma. Because
beta<delta<gamma<1/2, this is within the same collision half-period and

    |u-s|=(gamma-beta)/p = r+(eta+g)/p.                   (4)

If beta=0 both directions have this property. Otherwise the first gamma
time in the opposite direction is farther away, at distance
(gamma+beta)/p; it is not covered by (4).

Suppose this actual common time u belongs to S_q for some q!=p. Since
q is retained at s,

    ||q s|| >= delta+q r.

Lipschitz transport over (4), followed by rho_q(u)>=eta/M_q, gives

    F_q(u) >= delta-(q/p)(eta+g)+q eta/M_q.               (5)

The global upper bound F_q(u)<=Lambda then forces

    (1-q/p)g <= q eta(1/p-1/M_q).                        (6)

Thus a supplied transport violating (6) would strictly improve the joint
maximum and contradict its definition. This is a comparison between
different actual deletions; it does not change the old endpoint owner's
name and declare the result to be a new seed.

**Fastest maximizing pivot.** If the joint maximum is attained with p=P,
every possible q differs from P and satisfies q<P and M_q=P. In (6) the
right side is zero and the left side is positive. Hence the time u in
(4) belongs to no original S_q. The pivot P is gamma-good at u, so at
least two retained labels must be strictly gamma-bad there: no bad label
would give a full gamma witness, and one bad label q would give u in S_q.
Only when beta=0 does this conclusion apply to both first gamma times.

For a slower maximizing pivot p<P and a proposed new pivot q<p, (6) reads

    g <= eta*q*(P-p)/(P*(p-q)),                          (7)

since then M_q=P. If q>=p, (6) need not be restrictive. Thus even a new
seed, if one is supplied, does not automatically improve the unweighted
score in every velocity order.

These are new necessary comparisons from the **joint** bound. Their limit
is precise. Maximizing over all deletions does not make the maximizing
pivot fastest. More fundamentally, no global argument here supplies a
new deletion seed at u. In the fastest case extremality instead forces a
second bad retained label at that time. Count minimality supplies each
S_q somewhere, with no bound placing one at u or close enough to improve
the score. Neither the earlier first-entry rule nor a local owner cycle
has been reused as such a supply theorem.

## 3. Approach two: all-label endpoint minimality and a compatible replacement

For each original p, let E_p be the fixed finite set of endpoints of W_p
in one period. Count minimality ensures W_p is nonempty. Full failure
ensures that every endpoint is p-bad and that the actual p-row is covered
by V minus {p}.

The accepted endpoint selector does not require p to be the largest speed.
For every positive integer q<p, its inequality

    2q <= (N-2)p

holds. Replacing p by q and deduplicating either lowers the sum at the same
count or lowers the count, so minimality supplies a delta witness for that
replacement. The selector then gives the all-label version of the fixed
endpoint invariant:

    for every 0<q<p, some e in E_p satisfies ||q e||>=delta;
    for every e in E_p, ||p e||<delta.                    (8)

All endpoints have denominator dividing N*lcm(V minus {p}), so simultaneous
endpoint badness is periodic and p is its least positive blocker. This is
a direct application of the previously proved selector to every deletion,
not a new unconditional witness theorem. A smaller counterexample would
require some 0<q<p bad at **every** endpoint of the same E_p.

### An outward endpoint produces a good smaller replacement

The following uniform lemma shows that the natural outward endpoint from
a fastest-deletion seed is compatible with (8), rather than contradicting
it. Let s be any point of S_P, let beta=||P s||, and let I=[L,R] be its
old weak component. Choose the endpoint e in the direction increasing the
P norm, and put d=|e-s|. If beta=0, either endpoint may be chosen.

The whole component is trapped in one open P-bad interval. Since s lies
strictly inside I, d>0 and

    beta_e=||P e||=beta+P d<delta.

Choose an actual old endpoint owner a: at a right endpoint its signed
fractional phase is -delta, and at a left endpoint it is +delta. Since P
is fastest, a<P and

    q=P-a

is a positive integer smaller than P. We claim

    ||q s||=beta+||a s|| >= gamma+beta,
    ||q e||=delta+beta_e >= delta+F_P(s).                 (9)

Here all displayed norms are norms of actual common-time integer-speed
phases. To verify the possible signs and wraps, write sigma=+1 for a right
endpoint and sigma=-1 for a left endpoint. Choose integers k,m with

    P e-k = sigma*beta_e,
    a e-m = -sigma*delta,
    s=e-sigma*d.

Then

    a s-m = -sigma*(delta+a d),
    q e-(k-m) = sigma*(beta_e+delta),
    q s-(k-m) = sigma*(beta+delta+a d).

Because d<delta/P and a<P, delta+a d<2delta<1/2. Moreover

    0<beta+delta+a d
      = beta_e+delta-q d < beta_e+delta < 2delta < 1/2.

Thus these signed expressions have exactly the norms asserted, without
an unproved choice of phase representatives. The strong seed gives
||a s||>=gamma, and rho_P(s)<=d gives the second inequality in (9).

All old speeds are gamma-good at s. Consequently s is a full gamma witness
for the smaller replacement (V minus {P}) union {q}, whether q is fresh
or duplicates an old speed. Along the segment from s to e, the old speeds
remain delta-good and the q norm increases from its value at s, so q
remains gamma-good throughout. At e its norm is in fact strictly larger
than gamma, by (2) applied to F_P(s) and (9).

If a joint maximizer happens to use P, the endpoint bound in (9) is
||q e||>=delta+Lambda. Generally it uses only that particular fastest
seed's score. In either case it supplies a **good** endpoint for a smaller
q. The replacement has smaller count or sum and an explicit witness;
it is not a smaller failure. Treating it as a descent counterexample would
reverse the needed inequality in (8).

### The two endpoint notions do not coincide

Every e in E_p has an old owner a with ||a e||=delta and also
||p e||<delta. Hence it has at least two original gamma-bad labels and
belongs to no original deletion seed set S_j. More quantitatively, for
any t in any S_j,

    j!=a: |t-e| >= eta/a;
    j=a:  |t-e| >= (gamma-||p e||)/p > eta/p.

Since both a and p are at most the full tuple's fastest speed P, the safe
uniform conclusion is distance at least eta/P from E_p to the union of
all original S_j, also modulo time period 1. This is **not** an eta/M_P
bound using the maximum of the old complement.

The joint maximum therefore does not apply at the endpoints supplied by
(8). Even when a weak component contains a strong seed, its outward weak
endpoint has beta_e>=F_P(s), and its norm need not be bounded above by
Lambda. Components containing no strong seed are another part of E_p.
Neither kind of endpoint may be silently substituted into the maximization
domain. Equation (9) gives one exact common-time transport through these
sets, but its endpoint and its smaller replacement do not provide a seed
for another original deletion.

## 4. What remains and verification

The first approach proves the global separation (3) and the score-improvement
test (5)--(7). A contradiction requires an additional globally justified
survivor theorem producing an actual original deletion seed where this
comparison is strict. The existence of all seed sets and their compact
maxima alone does not supply that admissible transported point.

The second approach extends the accepted least-blocker invariant to every
deletion and proves (9), an outward smaller-replacement witness with exact
margin and phase signs. That witness satisfies minimality's requirement;
it gives no positive lower simultaneous blocker. To use this route for
descent, one still needs a q<p bad at every fixed endpoint, or a separately
proved operation creating a genuine smaller failure. No implication from
the joint seed bound to that required endpoint condition was established.

These are manuscript statements under a hypothetical actual minimum, not
a counterexample to LRC or an assertion of universal Q for arbitrary tuples.
No endpoint-insensitive length accounting, independently assigned phases,
or raw Euclidean reuse premise was used. No disconnected Lean implementation
is proposed. Independent mathematical review remains necessary.

All eight source and review bindings were read and checked:

| File | SHA-256 |
| --- | --- |
| `astra-uniform-all-deletion-seed-screen.md` | `b2b6acd00dae3c8ed777bc3da4227fab0254016eec035c2c100f8d346a398f1b` |
| `astra-uniform-seed-screen-review.md` | `11f738862f1302dda62e2f0fcd7c8cdff0b3dad9462297b79cd1769371c70522` |
| `astra-uniform-seed-coupling.md` | `b52f92b8dca3de5b0ba9f41c24c2dc6bd83a27329a035d40a1273a0401f215ea` |
| `astra-uniform-seed-coupling-review.md` | `537c008719aa858c9d97ab46acb5b5cd197b873a78d0266aeae6c05950c7c0bb` |
| `astra-uniform-global-seed-geometry.md` | `3a4a825f3f801282eb39b469571bbd4cac3a4e1f768d58542b7c1555cd725524` |
| `astra-uniform-global-seed-geometry-review.md` | `dd1cb0c56f383cd9c4c92c7789a889c591da8a7f6eb7b418c06466546e05752d` |
| `astra-minimal-height-audit.md` | `40e59ba4539eb931a07612e9b972999d3b48006d39ef4760c0e493d08e734325` |
| `astra-minimal-height-review.md` | `4570fa22f788a0e832165dd4ec5da613003a0181b0200267fcc30b44d9776e92` |

All listed files are in `research/`. Old embedded mathematical programs
were not executed. Verification of the new statements was hand Lipschitz
algebra, phase-band geometry, and application of the reviewed endpoint
selector with its unchanged hypotheses. The current project config,
workflow, policy and focused state were read. The command
`python3 -B scripts/validate_workflow.py` exited 0 and reported:

    workflow structural validation passed; it cannot certify mathematical validity.

The owned file was checked for trailing whitespace and a final newline.
There were no other-source changes. The unrestricted goal remains unresolved;
this is the end of these two bounded approaches, not an overall blocked or
complete disposition.
