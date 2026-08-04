# Response95 independent mathematical audit

- Task: `P95-MATHEMATICAL-VERIFICATION-321`
- Audit base: `3df57af646f0618110db6b352709af56a5bd6208`
- Scope: tracked Prompt95 contract and normalized response only
- Overall disposition: `MIXED / OPEN`

The auditor decoded the ignored raw capture in memory and reproduced raw
SHA-256
`093f68c9c2d9175bf9772d7da2053aa8f2ef3a48fb68311f366c52b699532eb8`.
No quarantined attachment was opened, parsed, imported, or executed during
this mathematical audit. An initial broad tracked-file enumeration printed
the three quarantine filenames without reading their contents; subsequent
audit work excluded the quarantine directory.

This memo reviews response-authored mathematics. It does not independently
validate the quarantined verifier, manifest, result, interpreter execution,
or source/result binding. No response claim is promoted to `proved-lean` or
`computed finite evidence` here.

## Claim audit

| Claim | Decision | Exact scope and evidence recommendation |
| --- | --- | --- |
| Redundancy, minimal-cover escape, and no-internal-cover forms are equivalent | ACCEPT | Finite deletion and the converse implications are valid once the nonempty candidate row is retained. Recommend `proved-math-qualified`. |
| Common scaling and label permutation preserve rows, covers, minimality, privacy, `F`, and `j_star` | ACCEPT | Reduction modulo the original modulus has constant fibers and exact cyclic-distance scaling. Recommend `proved-math-qualified`; no unrestricted existence follows. |
| Private signed-error normal form with `0<=q_i<=p-1` | ACCEPT | Correct for `N>=3`, strict badness, and privacy relative to the selected cover. Recommend `proved-math-qualified`; it supplies no descent. |
| Candidate-preserving projection and exact lift formula | ACCEPT | Reduction modulo `N*b` preserves candidate exclusion because `N` divides `N*b`; the lift identity is exact. Recommend `proved-math-qualified`. |
| Direct small-to-large badness transport | REFUTED at the displayed scope | The stress tuple's ten missed residues and the distances `rho_36(144)=0`, `rho_42(144)=18` independently reproduce. Recommend `refuted-exact-qualified` for that direct transport attempt only. |
| `PRIVATE-LIFT-COVERAGE` | OPEN | Its displayed inclusion is equivalent to completeness of the exchanged set, but the inclusion is unproved. Even if established, it yields another complete cover without a smaller cardinality, speed, sum, or lexicographic key, so it does not close Prompt95 by itself. |
| Exact gcd-sensitive bad-set cardinality | EXISTING `proved-lean` | This is already `LonelyRunner.card_pivotBadResidues_exact` in `LonelyRunner/PivotCounts.lean`; the response supplies no new theorem here. |
| Common-overlap and cover-size inequalities | ACCEPT | The common residues `1` and `N*p-1` produce the `2*(k-1)` correction; the `3*p-4` and rounded lower bounds follow. Recommend `proved-math-qualified`, as necessary conditions only. |
| Prompt95 for `|F(a)|<=2` | ACCEPT | A minimal internal cover would have at most one lower owner, contradicting singleton-cover rigidity. Recommend `proved-math-qualified`; this is largely an existing consequence. |
| `t*p`, `t*p+1`, and `t*p-1` slice constraints | ACCEPT | The calculations are valid with the stated candidate guards and strict equality convention. Recommend `proved-math-qualified`; they are necessary coverwise congruences, not a tuplewise proof. |
| `MAXIMUM-PIVOT-LOWER-OWNER-SKELETON` | QUALIFY | The elementary inequalities and slice constraints are sound after interpreting one malformed display through its proof and the existing Lean count theorem. It supplies no cross-pivot redundancy or well-founded descent. |
| Frozen bounded search | NOT AUDITED | An independent ephemeral literal implementation reproduced the response's counts and fixture summaries, but the response-authored interpreter, exit status, artifact source, manifest, output, and binding remain quarantined and unverified. Keep this as a finite-evidence candidate only. |
| Prompt95 implies integer and real LRC | ACCEPT as conditional | Universal redundancy contradicts a minimal internal cover at the global maximum and yields a pivot certificate. Prompt95 remains open and is stronger than bare certificate existence. |
| Prompt95 and unrestricted LRC | RETAIN OPEN | No response claim supplies redundancy, exchange-back, or a terminating descent. |

## Existing Lean overlap

The exact bad-set cardinality must be cited to the kernel-checked declaration
`LonelyRunner.card_pivotBadResidues_exact`, rather than treated as response
novelty. The response's floor form is the elementary rewrite
`ceil(p/d)=1+floor((p-1)/d)`. No attachment is needed for this comparison.

## Distance to unrestricted LRC

The accepted new material consists of local bookkeeping, capacity bounds,
and modular slice restrictions at a maximum covered pivot. These eliminate
some parameter regimes but do not force a redundant owner in an arbitrary
internal complete cover. `PRIVATE-LIFT-COVERAGE` remains open and would still
need a separate decreasing exchange invariant.

Therefore Prompt95, the exact uniform pivot existential, integer LRC, and
unrestricted real LRC remain `open`.

## Post-audit quarantine access boundary

After the independent audit above had completed, the PI ran an overbroad
tracked Python-source pattern search while locating existing pivot helpers.
That command caused filesystem reads under the Prompt95 quarantine directory,
although its displayed output exposed only paths and line positions, no
attachment claim was inspected, and nothing was executed or imported. This
operational mistake is not mathematical evidence and prevents treating the
PI's later context as a clean-room attachment review. The independent audit
reported above predates that event and did not rely on attachment contents.
Future attachment validation must use a fresh isolated reviewer and the
fail-closed quarantine procedure.
