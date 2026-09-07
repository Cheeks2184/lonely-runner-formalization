# Positive endpoint candidates: symmetry and the remaining coherence gap

Task `/root/positive_candidate_coherence`; assignment checkpoint
`07d39f4feb40f5fdf7fd26b900d70c7a553e8709`. Requested route: Astra/xhigh;
observed model, effort, elapsed time and usage: null. Only this manuscript
is owned. Its new deductions await independent mathematical review.

Two bounded hand approaches were pursued. The first retains the complete
endpoint data and derives a denominator restriction and reflection symmetry;
these exclude the positive-incoherent branch with only one reflection pair
or one available missing label. They do not force general coherence. The
second gives one exact native-width, LRC-good control with fresh positive
candidates at EVERY actual private arc, but no common candidate. Its full
deletion set also has untrapped components, so it does not refute the actual
globally trapped branch. No unrestricted LRC proof or disproof is claimed.

## Exact hypothetical branch and accepted interface

Let V contain n>=3 distinct positive primitive integer speeds in a
hypothetical ordinary strict failure, least by moving count and then
primitive sum. Put

    N=n+1, alpha=1/N, mu=max_(t in R/Z) min_(v in V)||vt||<alpha,
    m=max V, S=V\{m}, Q=max S.

Here mu>0 and `||x||=dist(x,Z)`. Retain the whole deletion set

    W={t:||vt||>=alpha for every v in S}.

Least count makes W nonempty, with an interval. The accepted contraction
puts every point of W in a unique nearest m-collision, with

    mt=k+e, |e|<=mu_m=mu-m(alpha-mu)/Q<mu<alpha.

Let K contain ALL attained indices modulo m and W_k all points of that
indexed portion, including disconnected and singleton portions. Every
original open m-arc `A_k=(k/m-alpha/m,k/m+alpha/m)` with k in K is forced.
Let E_k^- and E_k^+ be the complete original indexed arc families covering
its left and right endpoints. They are nonempty and have labels below m.
The accepted cancellation proves that every positive

    u=|a+b-m|, a in labels(E_k^-), b in labels(E_k^+),

is fresh, below m, and strictly alpha-bad on EVERY point of W_k. Let C_k
be exactly the set of these positive u. A common u across every C_k gives
a one-slot replacement failure; compactness and primitive normalization
contradict minimum sum. We study only the remaining possibility

    C_k nonempty for every k in K,    intersection_(k in K) C_k empty. (1)

No common candidate, pairwise intersection or global time transport is
assumed. The zero-only alternative is the
subject of a separate manuscript and is not reinvestigated here.

## First approach: the complete modular windows and their symmetries

For each retained label a write R_a(k) for the residue of ak in [0,m).
An attained maximum collision cannot have R_a(k)=0. Indeed, with t in W_k,
that equality would imply
`||at||<=a|e|/m<alpha`, contradicting the defining a-goodness of W.
Equivalently, if k/m has reduced denominator q, no label of S is divisible
by q. This uses an actual private portion, not an assumption that its
center is itself in W.

The complete endpoint labels have exact modular descriptions:

    A_k^-={a in S: 0<R_a(k)<(m+a)/N},
    A_k^+={a in S: 0<m-R_a(k)<(m+a)/N}.                         (2)

To check the left formula, the accepted maximum-owner geometry places
the center l/a of any covering arc strictly left of k/m. Its determinant
`D=ak-ml` is positive, and strict endpoint coverage says
`|ND-a|<m`. Since a<m and D>0, the lower inequality is automatic;
the upper gives `D<(m+a)/N<m`. Hence D=R_a(k). Conversely that residue
inequality, with l=(ak-D)/m, gives the actual original arc covering the
left endpoint. The right formula uses `D=mr-ak=m-R_a(k)` and is identical.
Strict inequalities keep all open endpoints exact. Formula (2) therefore
discards no original endpoint cover or alternate numerator lift.

The sets A_k^- and A_k^+ are disjoint: membership in both would give
`m<2(m+a)/N<4m/N<=m`. Their candidate image is

    C_k={|a+b-m|:a in A_k^-, b in A_k^+, a+b!=m}.              (3)

All C_k lie in the same actual hole set

    H={1,...,m-1}\S,       |H|=m-n.                           (4)

This is a consequence of whole-portion cancellation and old goodness on W;
the raw sumset formula by itself does not give freshness. In particular
(1) requires at least two missing labels: if |H|=1, every nonempty C_k
would be that one singleton. Thus this branch requires m>=n+2.

### Denominators of attained maximum collisions

The absence of retained q-multiples yields a quantitative common witness
without presuming any favorable center phases. The case q=1 is impossible
because every retained label is a multiple of 1. For q>=2 put c=k/m and

    s=1/[q(m+Q)].

Every retained norm at c is at least 1/q. At the SINGLE time c+s,

    ||m(c+s)||=ms=m/[q(m+Q)],
    ||a(c+s)||>=1/q-a s>=1/q-Qs=m/[q(m+Q)]  for all a in S.

The first equality uses ms<1/q<=1/2; the other bounds are the ordinary
circle Lipschitz inequality. Thus the actual maximum satisfies

    mu>=m/[q(m+Q)],
    q>=m/[mu(m+Q)]>Nm/(m+Q)>N/2.                              (5)

This root-supplied restriction was checked directly. It needs neither
center alpha-goodness nor a rounded candidate denominator in the speed
tuple. It is a necessary restriction on EVERY attained collision, not
the missing common-frequency selection.

### Reflection is exact, but supplies only one orbit at a time

Reflection t->-t preserves the whole W and maps W_k onto W_(m-k). It
swaps the original left and right endpoint covers, preserving labels.
Equivalently, the nonzero residues in (2) satisfy
`R_a(m-k)=m-R_a(k)`. Therefore

    K=-K mod m,       C_(m-k)=C_k.                            (6)

The only fixed indices would have denominator 1 or 2; (5) excludes both
because N>=4. All K therefore consists of distinct nontrivial reflection
pairs. If it consisted of one pair, nonemptiness of its C_k would give a
common candidate and the accepted descent. Thus (1) needs at least two
pairs, and |K|>=4. Reflection and (5) were also supplied by root and checked
against the full indexed portions, not only selected private points.

Equations (2)--(6) are the positive structural output of this approach.
The modular windows come from one shared speed set, but multiplication
by a different collision index need not preserve that speed set or its
endpoint-owner sumsets. Nothing proved here makes the C_k intervals,
makes different reflection orbits intersect, or gives a Helly property.
Minimum-sum minimality supplies, for any candidate u, an actual point of W
with ||ut||>=alpha in a portion where u is not a candidate. That accepted
escape statement does not order the alternative candidates by a decreasing
quantity and was not promoted to a coherence mechanism.

## Second approach: an exact native-width private-local control

Consider the positive distinct primitive tuple

    V_*=(1,5,6,7,8),     n=5, m=8, alpha=1/6.

This uses its native LRC width. Root supplied the control; all its endpoint
covers, full deletion components and scope were checked directly.

The FULL deletion set W_* for 8 is I_1 union I_2 union I_3 and their
reflections about 1/2, where

    I_1=[7/30,11/42],
    I_2=[13/36,11/30],
    I_3=[19/42,17/36].                                       (7)

For a direct check on [0,1/2], speed 1 restricts time to [1/6,1/2].
Speed 5 contributes [1/30,1/6], [7/30,11/30], [13/30,17/30]; speed 6
contributes [7/36,11/36] and [13/36,17/36]. The relevant speed-7 bands
are [1/6,11/42], [13/42,17/42], [19/42,23/42]. Their intersections are
exactly (7); the possible point t=1/6 is removed by speed 6. Reflection
gives the other half with no omitted points or extra components.

Distinguish two index sets, which coincide under actual global trapping:

    K_arc={k:W_* intersection A_(8,k) nonempty}={2,3,5,6},
    K_near={all nearest indices of 8t for t in W_*}={2,3,4,5,6}. (8)

There are no ties. Indeed `8I_1=[28/15,44/21]` has nearest index 2 and
I_1 lies inside A_(8,2); `8I_2=[26/9,44/15]` has index 3 and I_2 lies
inside A_(8,3). The third interval has
`8I_3=[76/21,34/9]`, with nearest index 4 and norm between 2/9 and 8/21,
entirely above alpha. Reflection gives the other indices. Thus the complete
actual private portions are precisely I_1, I_2 and their reflections;
the two I_3 components are fully recorded, not silently discarded.

Use all ORIGINAL open alpha-arcs at every endpoint. Direct evaluation gives:

| k | Left/right endpoints | All left labels | All right labels | Positive candidates |
| --- | --- | --- | --- | --- |
| 2 | 11/48, 13/48 | {5} | {7} | C_2={4} |
| 3 | 17/48, 19/48 | {6} | {5} | C_3={3} |
| 4 (raw only) | 23/48, 25/48 | {6} | {6} | {4} |

The entries for 6 and 5 swap the endpoint columns of 2 and 3. To verify
strict coverage, the four retained norms at the six endpoints, in the
order of labels (1,5,6,7), are respectively

    11/48: (11/48,7/48,3/8,19/48),
    13/48: (13/48,17/48,3/8,5/48),
    17/48: (17/48,11/48,1/8,23/48),
    19/48: (19/48,1/48,3/8,11/48),
    23/48: (23/48,19/48,1/8,17/48),
    25/48: (23/48,19/48,1/8,17/48).

Consequently EVERY actual private arc has a nonempty, entirely fresh
positive candidate set, and

    C_2=C_6={4},       C_3=C_5={3},
    intersection_(k in K_arc) C_k empty.                      (9)

No zero-only collision or retained positive candidate is used in (9).
The entire private portions are strictly inside their m-arcs with
`|8t-k|<=2/15<alpha`. Their local repair also holds directly:
`||4t||<=1/15` throughout I_1 and `||3t||<=1/10` throughout I_2,
and likewise on their reflections. No single private point substitutes
for either whole interval. The two individual escape witnesses even lie
in other actual private portions:

    t=13/36 in I_2: ||4t||=4/9>alpha,
    t=7/30 in I_1: ||3t||=3/10>alpha.

In fact every smaller positive replacement u<8 has an alpha-good point
in an actual private portion. For u=1,2,3,5,6,7 use t=1/4 in I_1; all
retained norms there are at least 1/4, while the norms for 2 and 3 are
1/2 and 1/4. For u=4 use t=13/36 as above. Also gcd(8,K_arc)=1.
These retain the indicated individual replacement-witness and collective
gcd consequences; they are not full minimum-failure hypotheses.

Thus freshness, strict whole-private-portion repair, exact original endpoint
covers, reflection symmetry and these individual replacement witnesses
do not force coherence. The same nonempty/fresh/empty-intersection pattern
survives on the full nearest-index extension because its additional raw
candidate at k=4 is 4. That m-arc itself is contained in the speed-6 arc
at center 1/2 and has no private portion; no canonical endpoint-geometry
conclusion is applied to it.

The missing global hypothesis is explicit. Time 11/24 lies in I_3 and has
the five norms

    (11/24,7/24,1/4,5/24,1/3).

Their minimum is 5/24>alpha. Therefore V_* is LRC-good, with actual maximum
at least 5/24. Its full W_* is not trapped inside the m-alpha arcs, and it
cannot satisfy the canonical minimum-count/minimum-sum failure hypothesis.
In particular m is not an alpha-bad covering frequency for ALL W_*.
The local residual bound above must not be called contraction by the actual
global maximum, which exceeds alpha. No exact maximum value is claimed.

Equation (9) is therefore a falsifier of private-local positive/fresh
coherence alone, at the native width. It is NOT a falsifier of coherence
under the full canonical failure assumptions. The full nearest-index and
actual-private-arc sets have both been retained so that their equality in
the intended branch is not silently assumed in the control.

## Disposition, source bindings and checks

The bounded attempt supplies (5), exact reflection (6), and the necessary
two-orbit/two-hole restrictions on the positive-incoherent branch. It does
not derive intersection or an alternative valid descent. The private-local
positive/fresh shortcut is refuted by (7)--(9) and the exact endpoint table;
the globally trapped assertion is neither proved nor falsified here. The first
unresolved implication remains a common positive choice across different
reflection orbits using the actual full minimum-failure geometry, beyond
the modular windows and individual replacement witnesses. No theorem
equivalent to the desired conclusion was presented as new supply.

The accepted endpoint source and independent review were read at the
following bindings, together with the invoked minimal-frequency and
contraction inputs. The separate zero-only manuscript was not used as
accepted evidence or independently re-audited in this task.

| Input | SHA-256 |
| --- | --- |
| `research/astra-forced-cycle-frequency-exchange.md` | `4ac28414ec9043c9ed11d69b7cc8520a2a1acc3b74168147acfc38091959046f` |
| `research/astra-maximum-frequency-exchange-review.md` | `9cd1282b49034073ad59e8df183df7e7b2cc65ce359d8ec8b088c6c032ab9515` |
| `research/astra-minimal-frequency-synthesis.md` | `03cf038021f0bc1a2328bb77a02f6ab4fe649f5d3626d7bc368a67cd6c7b0000` |
| `research/astra-minimal-frequency-review.md` | `b26182c2e482e7f83480eab9904779b958eb8b8b753c70bc45c6fabec55b747d` |
| `research/astra-strict-core-shell-supply.md` | `5cc9866b3c8a516494ad998355265335a5edd15158cf9701c7d814843b97210e` |
| `research/astra-strict-core-shell-review.md` | `dd733c2910f1f4579846c1c945ecac8e83d140eb29917b81dc11d2b1b119b95f` |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |

Current config, workflow, policy and focused state were read. The gate was
research/in_progress with explicit start authorization at
`2026-09-05T04:12:25.208107+00:00` and the recorded route/sole owned file.
`python3 -B scripts/validate_workflow.py` exited 0 with
`workflow structural validation passed; it cannot certify mathematical validity.`
Mathematics was checked by hand. Source hashes, full manuscript readback,
newline/whitespace and final workflow validation are checked at handoff.
No mathematical program, finite-domain sweep, solver, build, cache operation,
extra agent, external model, Git/state edit, memory write or other-file edit
was performed. New mathematical claims await independent review; the
unrestricted goal remains unresolved.
