AUDIT OF RESPONSE 50 AND PROMPT 51 — FIXED-PAIR AFFINE EVIDENCE ACCEPTED; SEEK A UNIFORM THEOREM

Do not claim a proof or disproof of the Lonely Runner Conjecture. Continue as GPT-5.6 Sol Pro. Preserve strict versus closed endpoints and distinguish proved-lean, proved-math, finite exact computation, conditional statements, conjectures, and rejected strategies.

RESPONSE 50 AUDIT

1. The affine-fiber identities are accepted as proved-math. For N>=4, 0<A<B, g=gcd(A,B), A=g*alpha, B=g*beta, L=N*g*alpha*beta, and d_A=gcd(N,alpha), d_B=gcd(N,beta), the fiber

  beta*r_A-alpha*r_B = h mod L

has N*g points before candidate exclusions and exactly

  g*(N - d_A*1_[d_A|h] - d_B*1_[d_B|h] + 1_[N|h])

points with N not dividing either numerator. The both-divisible intersection contributes g, not N*g. The phase identity and strict simultaneous-spoilage restriction

  rho_L(h*v) < 2*g*alpha*beta

are sound; equality remains good.

2. Your 14-shift result at the single fixed pair (N,A,B)=(7,98,187) is accepted only as exact finite evidence. The recovered verifier hashes matched, reran exactly, and an independent direct-coordinate implementation reproduced the result. For

  H={128273,80,71,151,128210,150,25,1156,114,87,149,2946,24,128252},

the robust-pair counts in that order are

  (5,5,5,4,5,4,5,4,4,5,4,4,5,5),

giving 64 endpoint constraints. All C(97,4)=3,464,840 four-speed sets fail to be H-transversals, while {7,63,70,77,84} is a five-speed H-transversal. Thus tau_H(98,187)=5. The individual cover numbers kappa_A=kappa_B=6 and quotient-slice counts (70,70,70,70,70,70) and (134,134,134,134,134,134) are also accepted exact computation. None of this proves a uniform top-two theorem.

3. The common first affine row is not itself a rescue. At (N,A,B,h)=(7,98,187,1), lower speed 63 is strict-bad at both endpoints of all six candidate pairs, with distances 7<98 and 14<187. Any uniform argument must explain how it selects or combines other phases; it may not silently reuse the rejected h=1 row.

4. Your coefficient-two singleton family S_m=[1,2m]\{m} is a valid obstruction to a pure missing-to-extra injection and has the displayed pivot witness. A sharper audited collision family is now authoritative manuscript mathematics: for every u>=1,

  N=4*u,  t=2*u,
  S=([1,4*u]\{2*u,3*u}) union {6*u}.

Then M={2*u,3*u}, E={6*u}, and both missing holes have the same singleton extra-neighborhood because

  6*u=3*(2*u)=2*(3*u).

The smaller hole is also blocked internally by occupied speed 4*u, so Hall fails with |M|=2>|E|=1 even though E is nonempty. This refutes the natural extra-blocker matching architecture more sharply. It is not an LRC counterexample: q=6*u+1, with complementary missing heights 2*u and 4*u+1, gives the existing two-hole witness.

NEW CLEAN LEAN STATUS

Fastest-pivot interval compression is now fully Lean-verified in the tracked Lean 4.32.1/mathlib v4.32.1 project. The declarations are

  exists_fastestPivotCertificate_of_mem_extremal_interval
  extremal_interval_compression_of_no_fastestPivotCertificate.

For positive integer speeds, N>=2, a selected nonpivot lower bound a_lower, an explicit positive nonpivot upper bound A, fastest pivot B, and

  L=ceil(B/a_lower),  U=floor((N-1)*B/A),

every r with L<=r<=U and N not dividing r gives the canonical fastest-pivot certificate. Failure of every certificate at B forces exactly

  U<L  or  (U=L and N|L).

Both interval endpoints are closed; pivotBadResidues remains strict. A fresh no-local ext4 replay built 3,577 jobs, the trust audit accepted 256 reports using only propext, Classical.choice, and Quot.sound, and all 153 tests passed. Treat this as a proved-lean input, but not as a theorem that a fastest or top-two pivot always succeeds.

COEFFICIENT-TWO FRONTIER

The exact short-hole classification is proved-math. If natural N,t,c satisfy

  0<t,  0<c<=N,  2*t<=N,  2*c<=N+t,
  N-c-t < 2^omega(c),

then either

  3*(N-t)<4*c

or (N,t,c) is one of exactly 22 triples:

  (4,1,2), (5,2,2), (6,3,2),
  (5,1,3), (6,2,3), (7,3,3), (8,4,3),
  (10,2,6), (11,2,6), (11,3,6), (12,3,6),
  (12,4,6), (13,4,6), (13,5,6), (14,5,6),
  (14,6,6), (15,6,6), (15,7,6), (16,7,6),
  (16,8,6), (17,8,6), (18,9,6).

The Lean-verified coefficient-three theorem removes the nine rows satisfying 3*t<=N. The exact residual coefficient-two table is:

  (5,2,2), (6,3,2), (7,3,3), (8,4,3),
  (13,5,6), (14,5,6), (14,6,6), (15,6,6),
  (15,7,6), (16,7,6), (16,8,6), (17,8,6),
  (18,9,6).

In the generic band, a problematic missing c has c>3*N/8; only 2*c and 3*c can block 1/c below N+t, 3*c is extra, and 2*c may be an occupied base speed. A coefficient-two proof therefore needs a mechanism that accounts for internal blockers rather than pretending every hole consumes an extra.

PRIMARY RESEARCH TASK

Develop at least three materially different UNIFORM strategies before committing to one. Merely choosing more random affine shifts or reporting larger finite searches does not count as a distinct strategy. Each strategy must state an exact quantified target lemma, list every dependency, and identify the first unsupported implication if it does not close.

Strategy family A — uniform affine transversals.

Either construct, for every admissible N,A,B, a finite arithmetically defined H subset Z/(N*lcm(A,B)) for which

  tau_H(A,B)>N-3,

or rigorously refute that target with an exact infinite obstruction or a fixed counterexample including a complete transversal of size <=N-3 for every possible H. A construction must bound |H| explicitly, use the strict bad-set convention, and prove why the same N-3 lower-speed set cannot hit both endpoints of every robust pair. Explain how empty fibers and fibers jointly covered by one lower speed are handled. Do not infer a uniform theorem from the accepted (7,98,187) certificate.

Strategy family B — a symbolic special-class theorem.

Prove a nontrivial infinite top-two class strictly beyond the already verified saturated family. State the speed family and all arithmetic hypotheses explicitly. Examples worth testing include a quantified large-gap/compressed-interval class derived from the Lean theorem, a gcd-stratified class where quotient slices on A and B admit a sign-controlled transport, or a class with bounded alpha or beta. The conclusion must be a canonical pivot certificate at A or B, with explicit numerator, or an exact finite disjunction whose branches each produce one. Give a dependency graph suitable for Lean formalization and do not hide divisibility or positivity conditions in prose.

Strategy family C — coefficient-two internal-blocker charging.

Formulate a graph, component, or discharging theorem that incorporates both extra blockers and occupied internal blockers 2*c. It must survive the sharper family

  M={2*u,3*u}, E={6*u}, occupied internal blocker 4*u,

and it must specify how a Hall-deficient component forces a reciprocal, complementary-hole, two-hole, or pivot witness. Use the 13 residual triples exactly: either repair them uniformly at the family level or isolate precise additional hypotheses under which they disappear. A rule that injects every hole, or every internal blocker, into E is already refuted.

For all three strategies:

* State domains and quantifier order exactly, including whether speeds form a Fin-indexed family, sorted tuple, set, or multiset.
* Preserve positivity, distinctness/injectivity, N=n+1 where required, candidate bounds 0<=r<N*P, N not dividing r, strict badness rho_(N*P)(r*s)<P, and safe equality rho=P.
* Do not interchange “each coordinate has a witness” with “one common witness works for all coordinates.”
* Do not reduce arbitrary real speeds to integers except through the already Lean-verified equivalence, and do not add a hidden rationality, finiteness, or minimal-counterexample assumption.
* Decompose surviving arguments into named lemmas with hypotheses and conclusions ready for Lean 4.32.1. If you provide Lean, it must use the repository's canonical pivotCandidates, pivotBadResidues, and pivot-certificate definitions.
* Any computed claim must include deterministic source, expected output, exact command, interpreter/compiler version, seed if any, case count, and SHA-256 hashes. Prefer compact independently checkable certificates over uncontrolled output.
* Give adversarial boundary tests, including equality cases, zero/one divisors, empty affine fibers, repeated masks, and natural-division guards.

Required output order:

1. Status corrections.
2. Three genuinely different strategy statements and obligation ledgers.
3. Complete proofs for every claim labeled proved-math, or the first exact gap.
4. The strongest surviving uniform or symbolic special-class theorem.
5. Reproducible artifacts only for claims that materially advance the proof.
6. A final status table distinguishing proved-lean, proved-math, computed fixed-pair evidence, conditional, conjectural, and rejected results.

Do not claim unrestricted top-two, coefficient-two height, or unrestricted Lonely Runner completion unless the exact theorem has actually been proved under the stated canonical definitions and independently verified.
