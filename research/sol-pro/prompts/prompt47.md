AUDIT OF RESPONSE 46 AND PROMPT 47 — KANOLD PROOF ACCEPTED MATHEMATICALLY; EXACT LEAN BOTTLENECK AND NEW PIVOT FRONTIER

Do not claim a proof or disproof of the Lonely Runner Conjecture. Continue as GPT-5.6 Pro. Preserve strict versus closed endpoints and distinguish proved-lean, proved-math, conditional, computed, conjectural, and rejected results.

RESPONSE 46 AUDIT

1. Your roots-of-unity/Vandermonde proof of the Kanold interval bound is accepted as a complete mathematical proof after an independent audit. For the squarefree radical M, the subset roots lambda_S are indeed pairwise distinct: reducing the exponent difference modulo p in S symmetric-difference T leaves exactly the nonzero term +/-M/p. The product F(x) vanishes exactly at integers sharing a prime factor with c. Vanishing at 2^omega(c) consecutive integers would give a square Vandermonde system with nonzero determinant and force the empty-subset coefficient 1 to vanish. The c=1 and x=0 cases and least-length interval convention are sound. This is proved-math, not yet proved-lean.

2. The sharpened conditional height theorem now compiles in Lean:

  seventeenThirdsHeight_family_witness_of_kanold

assumes the exact proposition KanoldIntervalBound and proves the common closed 1/N witness from 17*t <= 3*N and max speed <= N+t. The earlier 6*t<=N theorem is retained as a corollary. Lean checks every c<=6 case, 5*2^omega(c)<=2*c for c>=7, start+ell=2*N+1, and q=2*N. This remains conditional only because KanoldIntervalBound is not yet kernel-checked.

3. Your attached verifier was recovered byte-for-byte. Source SHA-256:

  53d525d152044fd2502550fa2854a2944441073c9c879e633bfb7cc345a1f261

Its exact output reproduces with SHA-256:

  23dbf402f45274bb77d28bc537b0ee26875bb34c2a1103fe229ff0bc5909f253

The 3,978,332 checked nonreciprocal triples for 17*t<=3*N are finite regression evidence only.

4. Your square-root-log proof c^2 <= 8*omega(c)*phi(c)^2 is accepted mathematically. The prime-slot bound, Wallis recurrence, product estimate, and square extraction are sound. It remains a formal fallback, not the priority while the stronger Kanold proof survives.

5. Independently, the exact primorial maximizer is now fully Lean-verified without an assumption. The new theorem

  boundedPrimorial_ratio_dominates

proves for every 0<c<=N that c*Q_N <= phi(c)*P_N, where P_N is the largest primorial <=N and Q_N=phi(P_N). The proof uses a terminating max-prime/missing-smaller-prime exchange and strong induction on the radical. boundedPrimorial_ratio_maximum includes attainment. Consequently boundedPrimorialHeight_family_witness and its exact-gain form are unconditional proved-lean bounded-height theorems. Combined clean build passed 3571 jobs; 225 trust reports use only propext, Classical.choice, and Quot.sound. This does not prove unrestricted LRC.

EXACT LEAN FAILURE FOR THE KANOLD ALGEBRAIC PROOF

Two difficult-looking downstream lemmas already compile in scratch:

- exponential_sum_not_vanish_consecutively, using Matrix.eq_zero_of_forall_pow_sum_mul_pow_eq_zero;
- primitiveRoot_subset_nodes_injective, reducing exponents modulo M and using IsPrimitiveRoot.pow_inj.

The first unresolved theorem is precisely:

```lean
def subsetExponent (s T : Finset Nat) : Nat :=
  ∑ p ∈ T, ∏ q ∈ s.erase p, q

theorem subsetExponent_mod_injective
    (s : Finset Nat) (hprime : ∀ p ∈ s, p.Prime) :
    Function.Injective
      (fun T : ↥s.powerset =>
        subsetExponent s T.1 % (∏ p ∈ s, p)) := by
  ...
```

In scratch/KanoldSubsetAttempt.lean:30, after choosing p in T\U, the exact remaining context and goal are:

```text
s : Finset Nat
hprime : forall p in s, p.Prime
T U : ↥s.powerset
hmod : subsetExponent s T % product(s) =
       subsetExponent s U % product(s)
p : Nat
hpT : p in T
hpU : p notin U
hpS : p in s
hpPrime : p.Prime
|- False
```

The symmetric branch is identical. The missing bridge is to reduce hmod modulo p, prove every q!=p summand is 0 mod p, and prove product(s.erase p) is nonzero mod p. The root-of-unity and Vandermonde APIs are no longer blockers.

Give Lean 4.32.1/mathlib code that closes this exact theorem. Do not handwave division. Prefer the erase-product definition above, which avoids M/p. Identify exact existing lemmas for:

- p divides product(s.erase q) when p,q in s and p!=q;
- p does not divide product(s.erase p), using pairwise distinct primes;
- reducing a Finset sum modulo p;
- transporting equality modulo product(s) to equality modulo p because p divides product(s).

If the Nat modulo proof is awkward, give a complete alternative in ZMod p, including casts and nonvanishing of the erased product. Supply compilable code, not pseudocode, or report the first exact unsolved goal.

COEFFICIENT-FIVE QUESTION

The fixed missing-hole selector under 5*t<=N fails only at the small local configuration (N,t,c)=(11,2,6), interval (20,21,22). There may nevertheless be a global family proof:

- the other arithmetic exceptions to the crude 2^omega length bound are (5,1,3) and (10,2,6); N=5 is covered by the existing n+2 bounded-height theorem, and the N=10 actual interval contains q=19;
- at N=11,t=2, if all speeds are <=12, the existing n+2 theorem applies;
- if speed 13 occurs, cardinality appears to force another missing c' in [1,11] with c'!=6, for which the Kanold selector works.

Audit this proposed repair completely. Either prove, conditional on KanoldIntervalBound, that 5*t<=N suffices for all positive injective N-1 speed families bounded by N+t, or give an exact counterexample to the repaired family argument. Track the chosen missing value and every cardinality step; do not infer a theorem from the single-hole computation.

NEW EXACT PIVOT FRONTIER

Define the top-two pivot conjecture by sorting 0<a_1<...<a_n and restricting the existing exact pivot-certificate existential to a_(n-1) or a_n. If true, it would imply the verified unrestricted pivot proposition and hence full LRC; it is only conjectural.

A deterministic exact artifact found no top-two failure among 878,245 primitive tuples in exhaustive boxes through eight runners, 86,745 structured CRT-oriented mutations through 15 runners, and 640 scaling-count checks. Hard rows have exactly two safe residues at each top pivot. This is finite evidence only.

The endpoint restriction is false:

```text
A=(1,4,5,6,7,11), N=7
pivot 1:  []
pivot 4:  []
pivot 5:  []
pivot 6:  [13,29] mod 42
pivot 7:  [15,34] mod 49
pivot 11: []
```

Thus neither slowest nor fastest pivot suffices, while the top two survive. Attack the top-two conjecture adversarially using a materially different structured CRT construction or derive a genuine cross-pivot invariant. Do not present more random finite survival as a proof. Any claimed counterexample must include the complete exact safe-residue table and a direct independent witness audit for the original LRC instance.

Continue the full prescribed Chebyshev/CRT score as a separate route. The quadratic projection remains rejected. Report either a genuine signed cross-pivot inequality or an exact all-pivot full-score failure; do not disguise safe-residue enumeration or full inclusion-exclusion as a uniform theorem.

Required output: exact quantified statements; compilable Lean repairs or the first exact compiler goal; complete proofs or explicit unsupported transitions; exact certificates and deterministic code for any computation; multiple materially different routes; and no unrestricted LRC completion claim.
