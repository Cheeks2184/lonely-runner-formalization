# Exact finite-cell reduction of ideal row selection

This manuscript replaces arbitrary real slopes in the ideal row problem by
a finite family of rational midpoint slopes. It also makes the previously
reviewed ideal-to-integer failure transfer quantitatively explicit. Neither
result proves the uniform selection claim or LRC. Root derivation at source
`15ef35a75c255f3fcdaafe8fb289f1fe6d97ee30`; independent review is pending.

The accepted conditional transfer is
`research/astra-ideal-row-integer-transfer.md`, SHA-256
`a8e53ac960a0cd0907437a38042ed574498259a472dc92cf223e4568f1124ebc`.
Its independent review is `research/astra-ideal-row-transfer-review.md`,
SHA-256 `6ff5010979d42c2ebfacf98c7e33a2e599a80c13c8caec1ec42f7b269f599921`.
The one fixed control is `research/astra-general-slow-row-control.json`,
SHA-256 `fbef3674ec3c30719325cfc91d0fc15c1a347377d0b4e8bd114e487059363d0c`.

## 1. The finite family and exact equivalence

Fix N>=5 and b=N-2. Let

    P = ({1,...,N-2} x {0,...,N-1}) union {(N-1,0)},
    C_N = {j/k : 1<=k<=N-1, 0<=j<=Nk, j an integer}.

The finite cut set contains 0,1,...,N. Sort its distinct elements, and let
S_N contain the midpoint of each consecutive open interval. Thus S_N has
at least N elements, all rational and strictly between 0 and N. For a slope
x define its bad-pair mask

    B(x) = {(k,ell) in P : ||(kx+ell)/N|| < 1/N}.

The norm is distance to the nearest integer. A tuple fails ideal closed
selection exactly when the union of its b masks is P.

**Finite-cell equivalence.** Every b-tuple of real slopes has a closed-good
pair in P if and only if every b-element subset of S_N has such a pair.
The real slopes need not be distinct. The finite subsets have distinct
elements. This is an equivalence for the ideal problem only.

One direction is immediate: a finite subset supplies a real tuple. For the
other direction it suffices to turn any failing real tuple into a failing
b-element subset of S_N.

First note that B(x+Nz)=B(x) for every integer z, since k is an integer.
Reduce each slope modulo N. At every pair in P choose one bad slope. Since
there are finitely many pairs, their selected strict inequalities persist
under sufficiently small simultaneous changes of the real slopes. This is
ordinary continuity of the norm; the allowed perturbations need not preserve
any originally good inequalities. Perturb each slope off the finite set of
cuts while keeping its representative in (0,N). A slope at zero can be
perturbed a sufficiently small positive amount. A failing tuple therefore
exists with every slope in one of the consecutive open cut intervals.

For any fixed pair, the bad predicate is constant within a cut interval.
Indeed its good/bad boundary is

    kx+ell = Nz+1  or  kx+ell = Nz-1

for an integer z. Each such x in [0,N] belongs to C_N, because kx is an
integer and k is between 1 and N-1. No interval crosses such a boundary.
Continuity gives constant strict badness away from them. Integer wraps do
not create a discontinuity in circle norm; in any event their locations
also belong to C_N. Thus the whole finite mask B(x) is constant on each
open cell.

Replace each perturbed slope by its cell midpoint. The union of masks is
unchanged. If several slopes occupied the same cell, discard repetitions:
duplicate masks contributed no additional covered pairs. This yields a
subset of S_N of size at most b still covering P. Pad it to exactly b
distinct elements using any other midpoints. There are at least N>b
available, and adding masks cannot destroy a cover. The resulting b-element
subset fails every pair. This proves the equivalence, including cut-boundary
inputs and repeated-cell slopes, without enumerating either separately.

## 2. Rational denominators and an explicit integer failure bound

Set D=2(N-1)^2. Each midpoint has the form

    r = (j/k + l/h)/2 = (jh+lk)/(2kh),
    1<=k,h<=N-1.

Its reduced denominator is therefore at most D. Suppose ideal selection
fails. The equivalence supplies b distinct midpoint slopes r_i in (0,N)
whose masks cover P. Write each r_i in reduced rational form with positive
denominator q_i<=D, and choose q as the product of these denominators.
Then q is a positive common denominator and q<=D^b. Put d_i=q r_i in the
integers, so 0<d_i<Nq, and put H=max d_i-min d_i<Nq.

For any selected bad pair at a slope with denominator q_i, the phase has
denominator dividing Nq_i. Its positive deficit from 1/N is consequently
at least 1/(Nq_i), hence at least 1/(ND). More explicitly, its norm is
m/(Nq_i) for an integer m>=0, and badness says m<q_i. The deficit is
(q_i-m)/(Nq_i). Thus the finite minimum eta of selected deficits satisfies

    eta >= 1/(ND).

Take the explicit positive integer

    T = D(N-1)+1,
    a=q,       M=NqT+min d_i,       c_i=d_i-min d_i.

Since T>N-1 and max(H,q)<Nq, we have

    M >= NqT > (N-1)max(H,q).

Also

    H(N-1)/(NM) < (N-1)/(NT) < 1/(ND) <= eta.

All hypotheses of the accepted strict ideal-to-integer transfer hold at
this explicit T. Hence the N-1 ordinary positive distinct integer speeds
a and M+c_i have no closed-good assignment of the proposed two-digit form
k/(Na)+ell/(NM), with 0<=k,ell<=N-1. In particular this is a finite actual
auxiliary counterexample, not merely an asymptotic assertion.

Every speed is strictly less than

    N D^(N-2) (T+1)
      = N [2(N-1)^2]^(N-2) [2(N-1)^3+2].

For the fast speeds, this follows from M+c_i=NqT+d_i<Nq(T+1);
the slow speed q is smaller as well. Larger integer T also give failures,
as in the accepted transfer. This new bound concerns failures of the ideal
selection principle and the resulting auxiliary two-digit construction.
It is not a new finite-checking bound for LRC, and it does not replace the
Malikiosis-Santos-Schymura cutoff in the formal development.

## 3. Meaning of the retained N=5 computation

The retained exact Fraction program uses precisely C_5 and S_5: 31 cuts,
30 midpoint cells and all 4,060 three-element subsets. It found no subset
whose bad masks cover the 16 pairs in P. Its full decoded source was read
and hash-bound by root and by the earlier independent reviewer. The recorded
execution succeeded once; no replay or expanded domain was performed here.

Combined with the finite-cell equivalence, that retained computation
supports closed ideal selection for every three real slopes at N=5,
including boundary and repeated-slope inputs. This is a new mathematical
interpretation of the same finite evidence, not a change to its recorded
execution or an assertion that its unexercised modular-witness branch ran.
It remains a computationally supported manuscript result, not a kernel proof.

No conclusion for other N follows from that computation. Nor does ideal
closed success guarantee finite-M cluster success: a positive correction
may spoil an upper endpoint. The purpose of this reduction is to make the
uniform ideal obstruction problem exact; it does not make increasing N
one by one into the research roadmap. No fixed-count Lean implementation is
queued. The arbitrary-N mask-cover exclusion remains the unsolved uniform
obligation, and unrestricted LRC remains unresolved.

Verification of the new reduction and explicit bounds is hand algebra,
continuity, finite set reasoning and rational arithmetic. No new mathematical
program, external theorem, numerical domain, Lean build or cache restoration
was used. Independent review is required before promotion.
