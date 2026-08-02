AUDIT OF RESPONSE 47 AND PROMPT 48 — KANOLD NOW FULLY LEAN-VERIFIED; FORMALIZE THE COEFFICIENT-FIVE REPAIR

Your Response 47 has been independently audited. Two major status corrections are required before continuing.

1. The Kanold/Jacobsthal interval bound is no longer merely proved-math or compiler-targeted. Codex independently completed and compiled the entire chain in Lean 4.32.1/mathlib v4.32.1:

```lean
theorem kanoldIntervalBound_vandermonde : KanoldIntervalBound

theorem seventeenThirdsHeight_family_witness
    {n N t : Nat} (speeds : Fin n → Nat)
    (hnN : n + 1 = N) (ht : 0 < t)
    (hpos : ∀ i, 0 < speeds i) (hinj : Function.Injective speeds)
    (hbound : ∀ i, speeds i ≤ N + t)
    (hgrowth : 17 * t ≤ 3 * N) :
    ∃ tau : Real, ∀ i,
      (N : Real)⁻¹ ≤ circleNorm (tau * (speeds i : Real))
```

The tracked proof compiles its subset-exponent injection, primitive-root node injection, exact powerset expansion, divisor-factor vanishing, consecutive Vandermonde contradiction, prime-set interval selector, and prime-factor-to-coprimality conversion. Independent adversarial review checked c=1, start=0, M=1, half-open endpoints, all powerset/cardinality indexing, and every final height hypothesis, and returned ACCEPT. Every axiom report is contained in `[propext, Classical.choice, Quot.sound]`. Do not spend further effort on your alternate uncompiled `KanoldSubsetInjective.lean` unless you find a genuine defect in the compiled theorem.

2. Your coefficient-five repair appears mathematically sound after a first independent audit, but it is not yet Lean-verified. The exact open task is now to formalize it without introducing a new premise. Use the existing unconditional `kanoldIntervalBound_vandermonde` and the existing bridge

```lean
twoHole_witness_of_coprime_modulus_above_height
```

as dependencies. Decompose and prove the following exact obligations:

- under `5*t ≤ N`, `2*c ≤ N+t`, and `ell=N-c-t`, classify `ell < 2^omega(c)` exactly as `(N,t,c)=(5,1,3),(10,2,6),(11,2,6)`;
- prove the c≥7 estimate used in that classification, including the exceptional c=10 branch, without an unproved assertion about the ordered prime factors;
- kernel-check all c≤6 cases and every natural-subtraction guard;
- repair `(10,2,6)` with q=19 and the exact interval/coprimality facts;
- for `(5,1,3)`, formalize the speed-6 case split and the existence of a second missing `d∈[1,5]`, `d≠3`, then rerun the reciprocal-or-Kanold selector at d;
- for `(11,2,6)`, formalize the 12/13 case split, the cardinality argument producing another missing `d∈[1,11]`, `d≠6`, and rerun the selector at d;
- preserve positivity, injectivity, `n+1=N`, maximum speed `≤N+t`, and the closed `1/N` boundary.

Target theorem:

```lean
theorem fiveHeight_family_witness
    {n N t : Nat} (speeds : Fin n → Nat)
    (hnN : n + 1 = N) (ht : 0 < t)
    (hpos : ∀ i, 0 < speeds i) (hinj : Function.Injective speeds)
    (hbound : ∀ i, speeds i ≤ N + t)
    (hgrowth : 5 * t ≤ N) :
    ∃ tau : Real, ∀ i,
      (N : Real)⁻¹ ≤ circleNorm (tau * (speeds i : Real))
```

Give a Lean-ready lemma graph and then the first complete declarations that can be pasted and compiled. If a family-level exception repair silently assumes that the initially selected missing c is minimal, unique, or chosen with some property not supplied by the cardinality argument, identify it exactly rather than smoothing it over.

Your saturated top-two class `(1,2,...,N-2,B)` also passes direct mathematical audit in all three divisibility cases. Provide a concise Lean-ready formulation using the existing canonical pivot certificate definitions, but keep this secondary to the coefficient-five theorem.

A separate exact search has refuted the proposed GLOBAL fractional-dual invariant from the prior frontier. At n=6, N=7, top speeds 98<187, an explicit rational fractional cover of all 1,224 mutually-top-good vertices has total weight `962/241 < 4=n-2`, with every cover constraint at least `248/241>1`. This rules out the desired dual mass by weak LP duality. Exhaustive enumeration of all C(97,4)=3,464,840 actual four-lower-speed sets still found no integral cover; the best covers 1,142 vertices. Therefore reject only the fractional-dual proof invariant, not the top-two conjecture.

Finally, continue seeking either a genuine top-two counterexample or a uniform cross-pivot theorem. Do not infer unrestricted LRC from the saturated class, fixed certificates, or finite searches. No unrestricted proof or disproof claim is authorized.
