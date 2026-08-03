AUDIT OF RESPONSE 53 AND PROMPT 54 — ENERGY TARGET REFUTED; USE MATCHING DEPENDENCIES OR VARIABLE REVERSAL TOTALS

Do not claim a proof or disproof of unrestricted Lonely Runner. Continue as
GPT-5.6 Sol Pro. Preserve strict versus closed endpoints and distinguish
proved-lean, proved-math, imported primary theorems, conditional results,
finite exact computation, conjectures, and rejected strategies.

RESPONSE 53 AUDIT

1. A1 and A2 are accepted as proved-math. For t>=16, 2t<=N,
q=floor(t/4), ell=2q, b=floor((N+t)/2), and

  a0=max(t-ell,b-2ell+1),

the two adjacent left intervals of length ell cover the generic candidate
band. The two right intervals are disjoint subsets of (N,N+t]. Every pair in
C0 x D1 and C1 x D0 satisfies the exact strict/closed band

  N+t<c+d<=2N.

Supplied coprime injections splice to a Gamma SDR. No coprime-matching theorem
is assumed in this elementary bridge.

2. B1 is accepted as proved-math conditional on explicit Pomerance constants
(cP,XP). The sufficient numerical conditions

  N>=max(46,XP),
  N-8>12*cP*(log(3N/2))^2

are correct. No numerical N0 follows from Pomerance's paper as written. The
first missing datum is Iwaniec's unspecified c1, followed by c2,c3,c4,c5 and
several asymptotic thresholds. No inherently ineffective input was identified,
but effectivization requires a new explicit analytic proof.

3. B2 is accepted as proved-math. With Q=N+a0+2ell, c -> Q-c reverses C0
onto D1 and C1 onto D0. Since gcd(c,Q-c)=gcd(c,Q), it gives an explicit SDR
if all actual candidates are coprime to Q. This is a special class, not a
uniform theorem.

4. C1--C5 are accepted only at their exact quantified strength. The degree
surplus inequality, Mobius discrepancy bound, conditional C3 prime-support
exclusion test, Holder third-moment inequality, and symmetric-difference
alternating-path theorem are sound. Candidate conditions are not known to
force C3 or a useful aggregate third-moment bound. Arbitrary coprime crossings
cannot be uncrossed.

5. ENERGY-EXCLUSION IS REJECTED, not conjectural. At

  (N,t,A)=(14,6,{6,8,9,10}),

the Gamma rows are

  6:{17,19},
  8:{15,17,19},
  9:{16,17,19},
  10:{17}.

Every proper subset is Hall-good. Nevertheless m=4,e=9,p=9 and

  e^2=(m-1)*(e+2p)=81.

The full A is also Hall-good, so this is not a selector or LRC counterexample.
An independent direct implementation and the tracked deterministic audit both
reproduce every row, every proper Hall cut, and the equality. Do not reuse the
rejected strict comparison.

6. Your exact attachment, SHA-256

  9f11e2a46ef58dd3275d818b925af1161cb4bed2a79c455f20e9e34d26ca46fe,

failed Lean 4.32.1 at lines 108,117,128,162,180 with `dsimp made no progress`
and warned at line 135 that ht was unused. Those five dsimp calls were already
redundant after `Finset.mem_Ico.mp`. Removing only them and renaming the private
hypothesis `_ht` produced tracked `CoefficientTwoRectangle.lean`. The exact
source compiles cleanly. Seven direct axiom probes report only propext,
Classical.choice, and Quot.sound. Its final theorem remains conditional on two
supplied coprime injections; it does not formalize or assume Pomerance.

STRONGER CRITICAL-CORE INPUTS

For any hypothetical inclusion-minimal deficient A outside the repaired rows,
N>=20, m=|A|>=3, |Gamma(A)|=m-1, and both incidence degrees are at least two.
In addition:

* every nonempty B subset Gamma(A) satisfies |N_A(B)|>=|B|+1;
* every ordered left prefix is crossed by an actual shared Gamma neighbor;
* every raw/extended interval strip exclusive to c is coprime-free for c and
  has length below 2^omega(c);
* if c1<c2<..., then c2-c1<2^omega(c1);
* e>=2m, p>=e-(m-1)>=m+1, and cycle rank e-2m+2>=2;
* deletion matchings give alternating paths between every pair of omitted
  left vertices.

Only raw supports are monotone; gcd filtering destroys biconvexity.

NEW EXACT MATCHING-DEPENDENCY LEMMA

Fix any matching M saturating a finite left set L. Direct every left vertex x
to the M-owner of each matched right neighbor of x. Mark x bad if it has an
unmatched right neighbor. Then tight Hall subsets S, |N(S)|=|S|, are exactly
the nonempty successor-closed left subsets avoiding all bad vertices.
Consequently the graph has strict Hall on every nonempty subset iff every left
vertex reaches a bad vertex. This is an elementary exact equivalence.

A deterministic exact sweep found no Gamma selector failure. In particular,
for every 1001<=N<=20000 at t=floor(N/2), explicit SDRs exist. At
(N,t)=(20000,10000), |C|=5001 with 22,800,241 edges; reverse reachability from
bad vertices reaches every left vertex, proving strict Hall for every subset
of that fixed graph. All 12,507,501 contiguous left intervals have Hall slack
at least 1145. A sparse deterministic active grid through N<100000 also found
no matching failure. These are finite evidence only, not a uniform theorem.

PRIMARY RESEARCH TASK

Develop at least three materially different attacks, with exact quantified
lemmas and the first unsupported implication. Do not merely enlarge the finite
search.

Strategy D — dependency-digraph reachability.

Construct a canonical arithmetic matching for Gamma, or a bounded explicit
family of matchings, and prove that every left vertex reaches an unmatched
right neighbor in its dependency digraph. Explore descending-c greedy,
reversal maps, and alternating augmentation as distinct constructions. State
the exact local step that would make reachability monotone. If it fails, give
the smallest exact Gamma row where it fails. Do not infer uniform strict Hall
from the N=20000 certificate.

Strategy E — variable reversal totals.

The fixed a0 is only the least feasible rectangle start. Determine the full
integer interval of starts s for which the two crossed rectangles still cover
the generic band and satisfy all Gamma boundaries. The reversal total becomes
Q=N+s+2ell. Prove a uniform theorem if some feasible Q is coprime to every
actual candidate, or replace one Q by a short explicitly bounded list whose
reversal maps combine through an augmenting argument. Account for shared
prime factors and show why the same candidate cannot block every total. A
Kanold argument applied to the product of all candidates is not acceptable
without a usable interval-length bound.

Strategy F — critical strips plus prime-support moments.

Combine c2-c1<2^omega(c1), coprime-free exclusive strips, dual strict Hall,
C3/C4, and alternating paths. Seek a quantified statement forcing either a
private neighbor, an automatic two-hole witness, or violation of one of the
moment inequalities. Work with exact raw endpoints and lcm prime supports.
State the first cross-candidate synchronization claim; do not hide it in an
averaging phrase.

FORMAL TASKS

Give Lean 4.32.1 declarations for complete lemmas only:

1. formalize the fixed-matching dependency-digraph characterization of tight
   Hall subsets and the reachability corollary;
2. formalize B2's reversal map on top of the now-compiled rectangle module,
   conditional on `forall c in A, Nat.Coprime c Q`;
3. do not declare Pomerance, a Gamma selector, coefficient two, top-two, or LRC
   as an axiom or premise disguised as a definition.

BOUNDARY REQUIREMENTS

Audit t=16, 2t=N, every division remainder t mod 4, equality c+d=2N, strict
failure at c+d=N+t, natural subtraction in a0, empty candidate sets, and
overlap/disjointness of every rectangle. Preserve the exact candidate guards,
Auto exclusion, and the 22 nongeneric rows. Any computation must include
source, expected output, commands, versions, domains, deterministic seeds, and
hashes.

Required output order:

1. Status corrections, explicitly rejecting ENERGY-EXCLUSION and accepting
   the corrected tracked Lean rectangle module.
2. Dependency-digraph theorem and uniform attack.
3. Full feasible-start/reversal-total analysis.
4. Critical-strip/prime-support-moment attack.
5. Lean declarations only for complete surviving lemmas.
6. Exact first gap for every incomplete route.
7. Final status table with no unrestricted completion claim.
