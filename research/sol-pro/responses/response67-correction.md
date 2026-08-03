# Correction memo: FORM-P67-RESPONSE-MATH-AUDIT-103

## Sentence-level corrections

1. **Section 1, Research memo and disposition**

   Original:

   > “The latest primary fixed-dimensional result used here proves `LRC(k)` for `k≤12`; it does not provide an unrestricted theorem.”

   **Correction:** Retract this sentence. It depends only on arXiv:2604.23906v1, which is outside the source chain audited by `VER-C2-DEPENDENCY-038`, and it is unnecessary to the manuscript’s argument. If retained elsewhere, it must be labeled `unchecked literature`.

   The preceding sentence classifying MSS as `literature` and `external-unformalized` remains unchanged.

2. **Section 3.3, Attack B**

   Original:

   > “A current primary result demonstrates this kind of polynomial control for one special signature: when `k+1` and `p>k(k+1)` are odd primes, the signature `(1,2,…,k)` is eventually proper in that paper’s `(k,p,l)` framework. It does not classify all signatures and does not prove `PrimeForcing(n,p)` for arbitrary admissible repeated tuples.”

   **Correction:** Retract both sentences. They depend only on arXiv:2604.23906v1 and are not needed for the obstruction-extraction proposal. If retained, both must be labeled `unchecked literature`. No status of `OBSTRUCTION-EXTRACTION-SUPPLY` changes; it remains `open`.

3. **Section 3.4, opening provenance paragraph**

   Original:

   > “Rosenfeld states the subset-gcd theorem and derives the product sufficient condition by AM-GM.”

   and

   > “A later primary source states the exact strict counterexample bound … and the prime-product contradiction.”

   **Replacement:**

   > “The external product input is Malikiosis–Santos–Schymura, Theorem A, at status `literature`; `external-unformalized`. The audited Rosenfeld application is arXiv:2512.01912v1: Theorem 1 restates the MSS input, and Corollary 2 records the product bound used against a minimal counterexample.”

   The unsupported attribution of an AM–GM derivation to arXiv:2509.14111v2 is removed. MSS Theorem A is directly identifiable in arXiv:2411.06903v2 and the published article; Rosenfeld v1 identifies the corresponding results as Theorem 1 and Corollary 2. 

4. **Section 3.4, deletion-gcd paragraph**

   Original:

   > “This argument is `proved-math` at the stated hypotheses and agrees with the literature deletion lemma.”

   **Correction:** Preserve `proved-math` at the manuscript’s stated hypotheses, but replace the citation to arXiv:2509.14111v2 with **Rosenfeld, arXiv:2512.01912v1, Lemma 4**. The external citation is corroborative and does not supply or promote the manuscript’s `proved-math` status. ([ar5iv][1])

5. **Section 3.4, prime-forcing-to-divisibility paragraph**

   Original:

   > “This is `proved-math`; the same local-to-global logic appears in the literature prime-forcing lemma.”

   **Correction:** Preserve `proved-math` at the stated hypotheses, but replace the citation to arXiv:2509.14111v2 with **Rosenfeld, arXiv:2512.01912v1, Lemma 3**. ([ar5iv][1])

6. **Section 3.4, strict MSS contradiction**

   Original:

   > “The external MSS product corollary gives for a primitive counterexample under the lower-dimensional hypothesis …”

   **Correction:** Cite this sentence to **Malikiosis–Santos–Schymura, Theorem A**, together with its audited application in **Rosenfeld, arXiv:2512.01912v1, Theorem 1 and Corollary 2**. Its status remains `literature`; `external-unformalized`, not `proved-math` or `proved-lean`. 

7. **Sections 4 and 7**

   All references to the “MSS subset-gcd and product theorem,” “MSS strict product upper bound,” or “external MSS product theorem” must point to the replacement MSS bibliography entry below. Their existing labels remain unchanged. No claim in those sections may be described as verified through arXiv:2604.23906v1 or arXiv:2509.14111v2.

## Exact replacement bibliography

**[A]** Romanos Diogenes Malikiosis, Francisco Santos, and Matthias Schymura, *Linearly-exponential checking is enough for the Lonely Runner Conjecture and some of its variants*, **Forum of Mathematics, Sigma** 13 (2025), e164, DOI `10.1017/fms.2025.10107`; arXiv:`2411.06903v2`. Applicable identifier: **Theorem A**. Status in the repository: `literature`; `external-unformalized`. ([arXiv][2])

**[B]** Matthieu Rosenfeld, *The lonely runner conjecture holds for nine runners*, arXiv:`2512.01912v1`, submitted 1 December 2025. Applicable identifiers: **Theorem 1**, **Corollary 2**, **Lemma 3**, and **Lemma 4**. This remains an external literature application; citation through the audited source chain does not make it repository `proved-math` or `proved-lean`. ([arXiv][3])

ArXiv:`2604.23906v1` and arXiv:`2509.14111v2` are removed from the validated citation chain. The claims used solely from them are retracted above rather than retained as `unchecked literature`.

## Status and disposition

This correction changes no mathematical result or status:

* The existing `proved-math` claims remain only at their originally stated hypotheses.
* `INTERVAL-PRIME-FORCING-SUPPLY`, `OBSTRUCTION-EXTRACTION-SUPPLY`, and `UniformPrimeForcingSupply` remain `open`.
* MSS remains `literature`; `external-unformalized`.
* No new Lean theorem exists.
* Unrestricted positive-integer LRC and unrestricted LRC remain `open`.
* The disposition remains **PIVOT**.

[1]: https://ar5iv.org/html/2512.01912v1 "[2512.01912] The lonely runner conjecture holds for nine runners"
[2]: https://arxiv.org/abs/2411.06903v2 "[2411.06903v2] Linearly-exponential checking is enough for the Lonely Runner Conjecture and some of its variants"
[3]: https://arxiv.org/abs/2512.01912v1 "[2512.01912v1] The lonely runner conjecture holds for nine runners"
