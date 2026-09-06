# Finite-grid critical horizon: root candidate

Source checkpoint: `8b9ea58d8a477a0fad733c3cf6674c307c1f9782`.
Status: root manuscript candidate; independent mathematical review required.
No Lean check, enumeration, or mathematical program has run for this argument.
This is a uniform weak-margin lemma and a conditional insertion mechanism,
not a proof of unrestricted LRC. No novelty or sharp-horizon claim is made.

## Exact theorem

Let b >= 1 be an integer, let w_i > 0 be arbitrary real frequencies,
and let theta_i be arbitrary real phases, indexed by i in {0,...,b-1}.
Write ||x|| for distance to the nearest integer. Fix any anchor j and set

    P = sum_i 1/w_i,
    H_j = ((b-1) P + 1/w_j)/b.

Every closed interval [a,a+H_j] contains a t such that
||theta_i+w_i t|| >= 1/(2b) for every i. In fact t can be chosen
in the half-open interval [a,a+H_j).

## Finite proof

Absorb a into the phases, so a=0. Set delta=1/(2b),

    h = fract(1/2 - b theta_j)/(b w_j),
    Omega = {0,...,b-1}^b,
    t(k) = h + sum_i k_i/(b w_i).

Thus 0 <= h < 1/(b w_j). If z=floor(1/2-b theta_j), then

    theta_j+w_j h = delta-z/b.

For label i let Bad_i be the subset of Omega on which
||theta_i+w_i t(k)|| < delta. Fix every coordinate except k_i.
The resulting phases form a translated b-grid, with increments 1/b.
For b>=2 any two distinct residues of this grid have circle distance
at least 1/b. Two strictly bad phases would have mutual circle distance
less than 2delta=1/b, a contradiction. For b=1 a fiber has one element
and the same at-most-one assertion is immediate.
Consequently each of the b^(b-1) fibers contains at most one Bad_i point.

For the anchor j, the fiber with all other coordinates zero has phases

    delta + (k_j-z)/b = (2(k_j-z)+1)/(2b).

Every such number has distance at least 1/(2b) from every integer:
a nonzero odd numerator remains after subtracting any integer multiple
of 2b. Hence this entire anchor fiber is disjoint from Bad_j.
This also holds for b=1, where the unique phase is an antipode.

Writing B=b^(b-1), we have |Bad_i|<=B for all i and
|Bad_j|<=B-1. Therefore

    |union_i Bad_i| <= sum_i |Bad_i| <= b B - 1 < b^b = |Omega|.

An assignment outside the union supplies the closed margin delta directly.
No independence, measure theory, continuity limit, rationality of phases,
or commensurability of frequencies is used. Finally

    0 <= t(k) < 1/(b w_j) + ((b-1)/b) P = H_j.

This proves the exact theorem, including interval translation and endpoints.
Choosing the fastest anchor minimizes H_j. If all w_i>=W>0, then
H_j <= (b-1+1/b)/W. For b>=2, H_j<P; for b=1, H_j=P.

## Conditional insertion into a slow seed

Let N>=3, m=N-1-b>=1, 1<=b, and 2b<=N. Suppose the m positive
slow speeds have maximum M>0 and a simultaneous seed s at margin
1/(N-b). Set eta=b/[N(N-b)]. The Lipschitz inequality protects all
slow runners at margin 1/N throughout the closed interval
[s-eta/M,s+eta/M]. If

    M ((b-1) sum_fast 1/w_i + 1/w_j) <= 2b eta,

then H_j<=2eta/M, and the theorem places a simultaneous fast witness
inside that slow interval. Its fast margin 1/(2b)>=1/N finishes the tuple.
The fast phases may be arbitrary; the ordinary common-origin case is included.
At critical N=2b this condition simplifies to

    M ((b-1) sum_fast 1/w_i + 1/w_j) <= 1.

In particular min_fast>= (b^2-b+1)M suffices, improving the earlier
product-uniform horizon's sufficient b^2 M. For b=1 this method is
weaker than the existing sharp single-fast insertion contract.

For a fixed b, choosing the b largest speeds as the fast set and the
global maximum as anchor minimizes the left side: every other partition
has a slow maximum at least v_(N-1-b), the largest slow speed in the
tail partition, a fast
reciprocal sum at least this tail's reciprocal sum, and an anchor
reciprocal at least the reciprocal of the global maximum. All factors
are nonnegative. This is a useful necessary restriction on a minimal
counterexample, conditional on the lower-count slow theorem.
It does not establish that some b satisfies the condition for every tuple.
The 2b>N ordinary one-seed obstruction in the separate gluing manuscript
remains outside this theorem's range.

## Lean plan to audit before implementation

Use finite assignments Fin b -> Fin b, strict bad subsets, and projection
away from coordinate i. Projection is injective on each bad subset by the
circle-distance grid separation lemma. Its codomain has cardinal b^(b-1).
For the anchor, zero is missing from the projection image. Finite union
cardinality then produces a surviving assignment. The alignment h uses
Int.fract and floor decomposition. The odd-numerator argument gives the
anchor's closed margin without a limiting step. Formalize the finite
cover counting lemma separately from real arithmetic only if that split
has a reusable exact contract; do not fragment routine proof repairs.

No implementation or cache restoration is queued by this manuscript alone.
First independently review b=1, real phases/frequencies, wraparound,
strict-versus-closed margins, support, and insertion algebra. Then assess
whether this stronger conditional profile supports a new uniform selection
or seed-supply step rather than accumulating disconnected conditional lemmas.
