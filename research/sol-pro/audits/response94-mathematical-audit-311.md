# Response94 independent mathematical audit

- Task: `P94-MATHEMATICAL-VERIFICATION-311`
- Audit base: `ead7361e79923e8b4e27c1757f2304c68dcebb81`
- Persistence base: `4fec7c4225789e933d52270e23e68f4733bff887`
- Scope: tracked Prompt94 contract and normalized response only
- Overall disposition: `MIXED / OPEN`

This audit is independent of the Level-1 recovery decision. Recovery preserved
the response as response-authored and unverified; this memo checks the
displayed mathematics. It does not inspect or rely on the quarantined archive.
No archive member was opened, listed, parsed, extracted, imported, or executed.

## Provenance boundary

| Item | Commit or SHA-256 |
| --- | --- |
| Prompt integration commit | `3467593e061df081d318cbf957ca201b185949d0` |
| Prompt94 launch record commit | `1bc7708afd9e116c62ebf836ae85172319cb2d98` |
| Prompt94 launch record SHA-256 | `baa90c569761e85700813f4e6f8cd832272b9afff0fe0f4ced510c2378d89466` |
| Tracked prompt SHA-256 | `dfb9d28e46091512864edb182524a60819d5ae0e34b4d1c4b9ba05f09e0e3ae8` |
| Submitted prompt payload SHA-256 | `a639ddf8a11bd17a9aff998988a3a48d10c9102b14adfeb43fbbf0f134e8c0e8` |
| Ignored base64 capture SHA-256 | `23d7db131f451559a135d726eed581154b1ec28fd3303c21416a3650a539cd2e` |
| Raw decoded response SHA-256 | `5231192b29d4cbdce1c00bf6c7524fbec9eb769fe09ff91417cb248beccf8932` |
| Normalized response SHA-256 | `08715c3b0baa64dd5b252121f670ada6fe1e64b151223133f5eae564e707ff41` |
| Original recovery commit | `8f6fa5c7d6e85b7013fd862baaddfd3f8480b73a` |
| Authoritative integrated recovery commit at audit time | `ead7361e79923e8b4e27c1757f2304c68dcebb81` |
| Recovery manifest SHA-256 | `c25fb4ad62517033fd59277d3b59b05eaa028f12c9021beed32d5fc17316e25f` |
| Recovery audit SHA-256 | `359a053c432f7a64bc783ebefdc392923a5c1e6c61711ac67c1c6a84903a13a4` |

The recovery package records a quarantined archive hash for identity only.
Neither that identity check nor any response-reported finite result is used as
mathematical evidence here.

## Claim audit

Pre-existing Lean declarations retain their existing `proved-lean` status.
Every newly accepted response-local statement below is recommended only as
`proved-math-qualified`; none is Lean-verified by this audit.

| Claim | Decision | Exact scope and evidence recommendation |
| --- | --- | --- |
| Pivot-coordinate safety and `mu=0` certificate | ACCEPT | The residue calculation is exact, including equality safety. This is already covered by the tracked Lean pivot definitions, boundary lemmas, `pivotResidueWitness`, and the pivot-certificate equivalence; no new response-local status is needed. |
| Strict `K_j(d)` interval parameterization | QUALIFY | The reduction through `L`, `c_i`, `m_i`, and `H_i=floor((p-1)/(d*c_i))` is correct. Recommend `proved-math-qualified`. |
| Generalized CRT intersection count | QUALIFY | Pairwise gcd compatibility, `L/lcm` solution counts, and subtraction of the `nu|u` solutions are correct. Recommend `proved-math-qualified`. |
| Inclusion-exclusion formula for `K_j(d)` | ACCEPT | Correct conditional on the CRT count; labelled duplicate owners are retained while covered residues are counted once. Recommend `proved-math-qualified`. |
| Divisor zeta identity and Mobius orientation | ACCEPT | `K(d)=sum_(d|g) G(g)` and `G(g)=sum_(g|d) mob(d/g) K(d)` use the correct upper-divisor order in `Int`. Recommend `proved-math-qualified`. |
| `CoveredUnit_j=G_j(1)` | ACCEPT | Exact consequence of the correctly oriented inversion. Recommend `proved-math-qualified`. |
| Unit-deficit cardinality and nonnegativity | ACCEPT | Units are candidates because `N|M` and `N>1`; the deficit is exactly the uncovered-unit cardinality. Recommend `proved-math-qualified`. |
| Reflection parity | ACCEPT | `r -> -r` preserves every predicate and has no unit fixed point for `M>=3`. Recommend `proved-math-qualified`. |
| Common-scaling factor | QUALIFY | The exact factor is `lambda(h,M)=(h/s(h,M))*phi(s(h,M))`, where `s` is the product of primes dividing `h` but not `M`. Fiber exhaustion is correct. Recommend `proved-math-qualified`. |
| Permutation invariance | ACCEPT | Row deficits are merely relabelled. Recommend `proved-math-qualified`. |
| Consecutive tuple and its common scales | ACCEPT | At pivot speed one, every unit modulo `N` is safe for speeds `2,...,N-1`. This is a special-family `proved-math-qualified` result only. |
| Ordinary fixed-pivot certificate implies a unit certificate at that pivot | REJECT | For `(1,2,3)` at pivot `3`, the only safe candidates are `{3,9}`, both nonunits. Recommend a `proved-math-qualified` counterexample to this fixed-row implication. |
| Minimal full unit-cover private pairs | QUALIFY | Inclusion-minimality supplies private residues; reflection supplies distinct pairs, disjoint across owner labels, so `2*|C|<=phi(M)`. Recommend `proved-math-qualified`, pivot-local only. |
| Fourier/Ramanujan identity | QUALIFY | Under the response's unnormalized transform, the factor `M^(-(n-1))`, Ramanujan signs, gcd support, inverse direction, and Dirichlet factor are correct. Recommend `proved-math-qualified`. |
| `OmegaUnit(a)>0` for every positive injective tuple | REJECT as proved; retain OPEN | This is the sole all-pivot unit-deficit lemma and remains unproved at every frozen quantifier. |
| Conditional chain from positive unit deficit to LRC | ACCEPT as conditional | A positive unit deficit gives an ordinary pivot certificate; the existing Lean equivalences then apply. The antecedent remains open. |
| Response-reported finite scans and mutation totals | NOT AUDITED | The claims depend on quarantined artifacts. They remain unverified and are not `computed finite evidence` under this audit. |

## Proof-detail gaps before manuscript-level promotion

The local calculations are sound, but a complete standalone manuscript must
still supply these details explicitly:

1. State the finite generalized CRT theorem and prove the simultaneous
   excluded-class count, rather than only the one-prime statement.
2. Make the inclusion-exclusion index type, labelled-owner convention, and
   empty-owner behavior explicit.
3. Prove the unit-lift partition and exhaustion in the scaling argument,
   including primes shared by `h` and `M`.
4. In the private-pair argument, prove injectivity of the selected private
   representatives and disjointness of pairs belonging to distinct labels.
5. In the Fourier calculation, state
   `hat(h_i)=M*1_(k=0)-hat(b_i)` and handle the quotient-modulus-one case.
6. Repair the response's malformed display separators around `CoveredUnit`,
   `D_H`, and scaling. These are presentation defects, not mathematical ones.

## Distance to unrestricted LRC

The Mobius and Fourier formulas re-express the same uncovered-unit count. The
inequality `2*|C|<=phi(M)` is an unrestricted but pivot-local necessary
condition and supplies no label-preserving cross-pivot transfer. The fixed-row
counterexample blocks one shortcut. It does not prove that the all-pivot unit
target is logically inequivalent to ordinary LRC, because it separates
witness types at only one selected pivot.

Therefore no accepted Prompt94 claim materially narrows the unrestricted
cross-pivot existential. The first open edge remains a cross-pivot
incompatibility or conservation theorem forcing at least one unit row to have
positive deficit. Prompt94, integer LRC, and real LRC remain `open`.
