AUDIT OF RESPONSE 48 AND PROMPT 49 — COEFFICIENT FIVE IS NOW LEAN-VERIFIED; ATTACK THE TOP-TWO FRONTIER

Do not claim a proof or disproof of the Lonely Runner Conjecture. Continue as GPT-5.6 Sol Pro. Preserve strict versus closed endpoints and distinguish proved-lean, proved-math, conditional, computed, conjectural, and rejected results.

RESPONSE 48 FORMAL AUDIT

Your coefficient-five mathematical argument was sound, but your attached Lean module did not compile against Lean 4.32.1/mathlib v4.32.1. The exact attachment SHA-256 was:

  ac0cebae690b6a3b3cc95316f2c16c5a1855171e5bab4e6622bfde585fca4ddb

The first exact failures were:

  line 34: unsolved c=8 and c=9 prime-factor-cardinality goals
  line 119: an impossible max-prime-equals-6 branch was not discharged
  line 124: multiplication order 2^r.card*2 = 2*2^r.card was unsolved
  line 128: a proof of 7<=m was supplied where 6<=m was required
  line 366: the (5,1,3) exception branch left a positivity metavariable

Do not describe that attachment as compiled or formal evidence.

Codex independently repaired the proof in the tracked module LonelyRunner/CoefficientFiveHeight.lean. The following declarations now compile:

  three_mul_two_pow_omega_le
  five_short_interval_exception_classification
  five_witness_or_exception
  exists_second_missing_of_extra_speed
  fiveHeight_family_witness

The final theorem quantifies over speeds : Fin n -> Nat and assumes n+1=N, 0<t, every speed positive, Function.Injective speeds, every speed <=N+t, and 5*t<=N. It concludes a real time tau at which every speed has closed circleNorm at least (N:Real)^-1. The three exact arithmetic exceptions are (5,1,3), (10,2,6), and (11,2,6). The family repairs use q=19, absence/presence of 6 or 12/13 as appropriate, and a second missing value forced by injective cardinality. No initially selected hole is assumed minimal or unique.

A clean no-local ext4 replay completed 3,573 Lean jobs. The trust audit accepted 240 reports using only propext, Classical.choice, and Quot.sound. All 153 tests and exact certificates passed. Independent adversarial review checked every guarded Nat subtraction, endpoint, cardinality step, and exception repair and returned ACCEPT. This is proved-lean bounded-height progress only, not unrestricted LRC.

YOUR RESPONSE 48 FASTEST-PIVOT RESTRICTION

You also proposed: if B is a fastest speed and every speed s satisfies B <= (N-1)*s, then pivot B with numerator r=N-1 is a safe canonical pivot certificate. Consequently failure of this fastest-pivot criterion requires (N-1)*a_min < a_max. We accept this only as proved-math pending an independent Lean check. Re-audit the strict bad-set endpoints. If you use it below, state its exact hypotheses rather than treating it as a global fastest-pivot theorem.

PRIMARY TASK A — SATURATED TOP-TWO CLASS, EXACT LEAN

Formalize your proved-math class for N>=4, A=N-2, B>A, and speeds (1,2,...,N-2,B) using the existing canonical definitions pivotCandidates, pivotBadResidues, and pivotResidueWitness. The manuscript cases are:

1. If N does not divide B, pivot A and r=A.
2. If N divides B but N*A does not divide B, write B=N*k and use pivot A with r=N-1.
3. If B=N*A*k, use pivot B and r=(N-1)*N*k-1.

Give pasteable Lean declarations, not pseudocode. Retain N>=4 and every nonzero/divisibility premise needed by Nat arithmetic. Prove candidate membership and avoidance for every lower speed and the other top speed. If the full module does not compile, report the first exact local context and goal. Do not replace the canonical certificate claim with a weaker real-time statement unless you prove the bridge exactly.

PRIMARY TASK B — GLOBAL TOP-TWO FRONTIER

The unrestricted top-two pivot conjecture remains open. At n=6,N=7, top speeds 98<187, an exact fractional cover of all 1,224 mutually-top-good vertices has total mass 962/241<4 while every constraint receives at least 248/241. This refutes the proposed global fractional-dual invariant by weak duality. Exhaustive enumeration of all C(97,4)=3,464,840 integral four-lower-speed sets found no top-two counterexample; the best covers 1,142/1,224 vertices. Reject only the fractional invariant, not the integral top-two conjecture.

Develop at least two materially different analytic strategies for the exact global frontier before choosing one. One must exploit the fastest-pivot restriction and the resulting large-gap regime (N-1)*a_min<a_max. The other must use a genuine cross-pivot relation, such as a signed common-LCM identity, divisor stratification, or structural compression of integral lower-speed covers. For each strategy:

- state an exact quantified lemma strong enough to advance the top-two conjecture;
- decompose it into explicit proof obligations;
- identify any sign, quantifier, finiteness, normalization, or subgroup-slice obstruction;
- either prove the lemma or clearly label the first unsupported transition.

Do not give more random finite survival as a proof. A proposed counterexample must include a complete exact safe-residue table at both top pivots and an independent direct lonely-time audit for the original tuple. A proposed proof may not use maximal-depth inclusion-exclusion under another name.

PRIMARY TASK C — HEIGHT BOUND BEYOND FIVE

As a separate route, investigate whether the arbitrary-hole/family-repair architecture can rigorously improve 5*t<=N. Analyze 4*t<=N first: classify every failure of the required Kanold interval length, determine whether the exception set is finite or infinite, and test whether family-level second-hole repairs genuinely close it. Supply a symbolic proof or an exact infinite obstruction family; finite searches alone are computed evidence. Do not assume a missing integer has a convenient divisor structure.

Required output: status corrections first; exact theorem statements; complete proofs or explicit gaps; compiler-targeted Lean for Task A; at least two materially different global strategies; deterministic code and exact certificates for any computation; and no unrestricted LRC completion claim.
