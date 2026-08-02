AUDIT OF RESPONSE 51 AND PROMPT 52 — CORRECT THE PAIRED FRONTIER AND ATTACK THE EXACT GAMMA HALL PROBLEM

Do not claim a proof or disproof of the Lonely Runner Conjecture. Continue as GPT-5.6 Sol Pro. Preserve strict versus closed endpoints and distinguish proved-lean, proved-math, finite exact computation, conditional statements, conjectures, and rejected strategies.

RESPONSE 51 AUDIT

1. Your affine-support inclusion A1 is accepted as proved-math. It is only a necessary consequence of simultaneous robust-grid covers.

2. AFFINE-SUPPORT-ESCAPE is false. At (N,A,B)=(4,2,8), the A-robust grid is empty, so the robust affine support is empty and is contained in every union of difference sets. Equivalently, every paired shift family is empty and has transversal number 0<=N-3. This is not a top-two counterexample: for speeds (1,2,8), pivot B=8 with numerator r=9 has cyclic distances (9,14,8) modulo 32 and is a valid closed 1/4 certificate.

The corrected frontier is disjunctive. Put k=N-3 and let kappa_A,kappa_B be the individual robust-grid cover numbers. It is enough to prove, for every top pair, at least one of:

  kappa_A>k;
  kappa_B>k;
  both robust grids are nonempty and an explicitly selected robust-pair family has transversal number >k.

The tracked Lean module TopTwoTransversal.lean now proves the sound abstract bridge only: if one lower-speed set covers both robust grids, it spoils both endpoints of every selected robust pair; if a lower-speed set is not a two-sided transversal, one endpoint is a complete top-pivot certificate. It assumes no uniform shift theorem. A fresh clean build and trust audit have succeeded; do not strengthen this declaration beyond its premise.

3. Your large-gap theorem B1 is accepted only with the full fastest-interval domain explicit: a is a positive selected lower speed, A is positive and bounds every nonfastest speed, B is the fastest speed, L=ceil(B/a), U=floor((N-1)B/A), and L<U. Under those hypotheses the two-consecutive-integers argument is sound. Please state a precise Fin-indexed theorem or corollary matching the canonical repository definitions.

4. Your common-g theorem B2 is accepted as conditional proved-math, not proved-lean. Its union-bound and scaling proof is plausible and uses the already verified exact bad-set cardinality theorem, but no source was supplied or compiled. Please give repository-compatible Lean 4.32.1 code only if you can state every domain, candidate-cardinality, divisibility, and cyclic-distance scaling hypothesis exactly. Do not label it proved-lean.

Your example (7,14,21,28,35,42) is only seven times the saturated family (1,2,3,4,5,6), so it does not witness the claimed strict extension. A genuinely nonsaturated test is N=7, g=7, lower speeds (7,14,21,35), A=56 (alpha=8), B=63 (beta=9): the four lower bad counts are zero and u=1 should work. Audit this example as well as the theorem.

5. The coefficient-two blocker-path structure C1/C2 is useful but CHAIN-REPAIR is not a quantified lemma and is unsupported. It does not control isolated internal 2c blockers, unrelated extras, or the thirteen residual rows. The new exact frontier below supersedes that vague repair target.

NEW COEFFICIENT-TWO GAMMA FRONTIER

Let N,t satisfy 4<=N, 0<t, and 2t<=N, and put H=N+t. A selected family S is a subset of {1,...,H} with |S|=N-1. Put U={1,...,N}, M=U\S, and E=S\U, so |M|=|E|+1. The guard 4<=N is essential to the exact selector exception list: at (N,t)=(3,1), C={2} and Gamma(2) is empty. That row is already covered by the Lean-verified coefficient-three theorem because 3t<=N.

For 1<=c<=N define

  Auto(c) iff there exists d with H<d, c+d<=2N, and gcd(c,d)=1,

  Gamma(c)={d : N<d<=H, H<c+d<=2N, gcd(c,d)=1}.

If c is missing and Auto(c), then q=c+d gives the existing two-hole denominator witness. If c is missing and some d in Gamma(c) is also missing, q=c+d gives the same witness. Hence under no witness,

  Gamma(c) subset E

for every relevant missing c. The raw integer interval before the coprimality filter is

  [max(N+1,H-c+1), min(H,2N-c)]

and, under 1<=c<=N and 2c<=H, has exactly min(c,t,N-c) integers.

Let C(N,t) contain exactly the c satisfying

  1<=c<=N,
  2c<=H,
  N-c-t < 2^omega(c),
  not Auto(c),

and either 3(N-t)<4c or (N,t,c) is in the already audited 22-triple short-hole table. The no-witness deductions force M subset C(N,t).

The exact uniform arithmetic conjecture is Hall's condition

  for every A subset C(N,t), |A| <= |union_{c in A} Gamma(c)|,

except at (N,t)=(4,2),(5,2),(8,4),(11,5). Deterministic exact enumeration for every 4<=N<=300 and 1<=t<=floor(N/2) finds only these four failures. Under M subset C, Gamma(M) subset E, |M|=|E|+1, and nonempty M, the compatible failure configurations reduce exactly to

  (4,2):  M={2,3}, E={5};
  (5,2):  M={2,3}, E={7};
  (8,4):  M={6}, E=empty, or M={4,5,6}, E={9,11};
  (11,5): M={6,8}, E={13}.

They are repaired by reciprocal witnesses using c=3, c=3, c=6 or c=5, and c=6 respectively. Thus a proof of the stated Hall theorem outside these four parameter pairs would prove the coefficient-two bounded-height theorem.

The finite verifier is independently reproducible and remains evidence only. Its source SHA-256 is 508ce445b8fe2d8429878c28eda890a053305964c4a6275e0b577ede2fc04e39 and expected-output SHA-256 is f087834eeb07f4ca1c4b258d16d3dd8ebb23bf5e6bbe15641c6ec28f89dfb925.

Simpler affine charges are refuted. At N=19,t=9, M={9,14}, E={28}, the rule collides because 3*9+1=2*14=28. Even the pair 3c-1,3c+1 is defeated by M={9,13,14}, E={26,28}. Neither is an LRC counterexample: q=29,c=9,d=20 repairs both.

PRIMARY RESEARCH TASK

Develop at least three materially different attacks on the exact uniform Gamma Hall theorem. Do not merely extend the finite range. For each strategy, state an exact quantified lemma, prove every claim labeled proved-math, list dependencies, and identify the first unsupported implication.

Strategy 1 — minimal Hall-deficient set and sliding endpoints.

Assume a minimal A subset C with |Gamma(A)|<|A|. Exploit the fact that the unfiltered intervals have monotone sliding endpoints and exact length min(c,t,N-c). Derive all consequences of minimality: private-neighbor restrictions, degree bounds, endpoint nesting/crossing, and arithmetic restrictions from gcd filtering. Either prove that such A forces one of the four small pairs, or give the smallest exact counterexample beyond N=300. Do not infer Hall merely from individual neighborhood sizes.

Strategy 2 — adapt coprime interval matchings.

Bohman–Peng (arXiv:2109.09860) and Pomerance (arXiv:2111.07157) prove coprime matchings for rectangular equal-length intervals. Determine precisely whether their lemmas can be specialized, partitioned, padded, or combined to handle the triangular sliding family Gamma(c). State the exact theorem used and verify every domain condition. If padding introduces edges not in Gamma or maps outside (N,H], stop at that exact gap. Seek a finite-small-N plus asymptotic proof only if all thresholds are explicit and reproducible.

Strategy 3 — arithmetic incidence/discharging.

Construct a weighted Hall certificate, interval matrix argument, compression/shifting proof, or prime-divisor charging scheme. It must tolerate composite c, empty Gamma(c), repeated neighborhoods, and the two N=19 charge collisions above. Identify whether candidate conditions N-c-t<2^omega(c) and not Auto(c) force a useful lower bound on coprime density or forbid a minimal deficient incidence component.

Also pursue two independent alternatives in case Gamma Hall is false:

Strategy 4 — common-q sufficient class. Find a uniform choice or short deterministic list of q in (H,2N] such that every possible missing-set configuration yields coprime complementary missing heights c and q-c. State the exact set-cover or averaging lemma needed.

Strategy 5 — formal special-class progress. Give a complete Lean-oriented theorem for Response 51's B1 or B2 class. Prefer B2 if its exact bad-count dependencies really suffice. The conclusion must use the canonical pivotCandidates/pivotBadResidues/certificate definitions, preserve strict badness and safe equality, and expose all positivity and coprimality assumptions.

BOUNDARY AND LOGIC REQUIREMENTS

* Preserve N=n+1, positivity, injectivity/distinctness, 0<=r<N*P, N not dividing r, strict badness rho_(N*P)(r*s)<P, and closed safety rho>=P.
* Do not interchange one witness per speed with one common witness for all speeds.
* Do not reduce arbitrary real speeds to integers except through the verified equivalence.
* Treat C(N,t) as a candidate superset forced by no witness, not as the actual missing set.
* Audit c=1, c=N, t=1, 2t=N, empty Gamma, singleton Gamma, equality c+d=H, equality c+d=2N, and gcd>1 boundaries.
* Any computational claim needs deterministic source, expected output, exact command, versions, case count, seed if relevant, and hashes.
* No result is proved-lean until the exact tracked source compiles and passes the independent trust audit.

Required output order:

1. Status corrections, including explicit rejection of AFFINE-SUPPORT-ESCAPE.
2. Three distinct Gamma-Hall strategies with exact obligation ledgers.
3. Complete proofs for every proved-math label, or the first exact gap.
4. Common-q and formal special-class alternatives.
5. Lean 4.32.1 declarations only for genuinely complete surviving lemmas.
6. Reproducible artifacts only if they materially advance the uniform problem.
7. Final status table separating proved-lean, proved-math, finite evidence, conditional, conjectural, and rejected.

Do not claim coefficient two, unrestricted top-two, or unrestricted Lonely Runner completion unless the exact canonical theorem is proved and independently verified.
