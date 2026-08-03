# Response 63 audit

Response 63 studies corrected deletion-pivot lifting through exact incidence
classification, active blockers, reverse-grid identities, and a proposed
first-blocker descent. Lead task `VER-R63-AUDIT-013` conditionally accepts the
finite replay and a bounded set of paper lemmas after required corrections.
The strict smaller-Delta descent and corrected DPLP selector remain
conjectural/open. No new Lean theorem or unrestricted Lonely Runner result is
accepted.

The audited repository base is
`477fbffc709d0550c163e2812f26193a4ec38cff`. Audited material is the tracked
[Response 63](../research/sol-pro/responses/response63.md) and
[Prompt 63 artifacts](../research/sol-pro/artifacts/prompt63/). The normalized
response SHA-256 is
`b3db11b42448d3b92d3d9522fdac89128a46ca7de32cca19b033ac202242e134`;
the quarantined source ZIP SHA-256 is
`5832a26d51410dd661c545be4490e39dadc445a65fc80590917dc4e1474a0f8b`.

## Routing record: no Luna endorsement

A fresh Luna/xhigh turn completed with public-safe fingerprint
`4d31833037ba35f443d9c9cd71580a510b5c62ffbb56cc975dd3ec0c5d10c16c`,
but it missed both external audit inputs. Its output is therefore invalid for
claim review and gives **no Luna worker endorsement** to any Response 63
disposition.

Two corrected launches failed before a worker turn began, first with operating
system error `3`, then with operating system error `2`. They produced no audit
evidence. No further launch is authorized. The dispositions below come from
the supervising lead's independent replay and mathematical inspection.

## Independent lead replay: PASS as finite evidence

The lead validated all 21 ZIP-member hashes and all 13 hashes declared by the
manifest. The generator, Python implementation, C++ implementation, analyzer,
deterministic outputs, and census matched exactly. The replay records:

- 4,694 primitive positive injective records;
- 4,296 records satisfying the corrected DPLP premise;
- zero corrected-DPLP failures in that finite domain;
- 36 records with zero exceptional-good certificates;
- minimum-escape selector census `36`, with `0` selector failures.

The Python/C++ core and active outputs agree byte-for-byte. The two redundant
1,756,631-byte core TSVs intentionally omitted from the public tree were
included in the lead's ZIP replay; each has SHA-256
`8eb8ad610e55c24170034cf634ea77fcd207cc5fc327efc9af155737beb6de2d`.
This is **lead-verified computed finite evidence**, not Luna-endorsed evidence
and not a uniform proof.

## Mathematical dispositions

The following are accepted as `proved-math` at their exact stated hypotheses:

- A1, the exact empty/shell/deep row classification;
- B1--B5, covering certificate-completeness nonemptiness, the oriented active
  blocker, one-sided canonical numerator/quotient identities, the global
  component-successor cycle, and its exact inter-component gap bound;
- C1, the exact reverse-grid identity.

C1 is a genuine unrestricted reusable arithmetic lemma. It is manuscript
mathematics only: no Lean declaration was compiled or kernel-checked.

C2, the Lipschitz escape implication, is sound only in the deep subcase

```text
N * d < n * p
```

The strict inequality must be carried as a premise. C2 does not establish a
global descent rule for arbitrary active blockers.

The exact tuple `(1,2,6,8,10)` verifies the obstruction to the claim that a
maximizing active cycle must meet an `N`-divisible coordinate under the bare
corrected-DPLP premises. It also blocks the proposed common-time/common-grid
synchronization: the relevant cycle vertices have disjoint maximizing sets
and distinct moduli. This is an obstruction to those mechanisms, not an LRC
counterexample.

The proposed strict smaller-Delta first-blocker transition remains
`conjectural/open`. The 36-row minimum-escape census does not test that
transition: in every zero-exceptional record, the minimizing reverse endpoint
was already a full witness. Finite selector success therefore cannot be cited
as evidence that Delta strictly decreases at the first blocker.

## Correct formal status

The corrected DPLP declaration contract and conditional selected-certificate
wrapper are already integrated. Their sound implication is Lean-verified, but
the selector that supplies a lifting certificate is unproved. Response 63's
description of the wrapper as pending main integration is stale and is
corrected here. DPLP remains conjectural.

The displayed `orientedActiveCert_reverseGrid` block is pseudo-Lean, not a
declaration that can compile: parameters and types are unbound, division and
signed arithmetic are not typed, and expressions such as `mod 1` and `rho`
are not valid project syntax as written. It receives no `proved-lean` status.
No fresh cold-cache kernel replay was performed as part of this audit.

## Packaging defects and portable replay

The bundle is sufficient for the lead replay but has four publication defects:

1. Its README hardcodes `/mnt/data/pro_c_audit`; after entering the artifact
   directory, the portable C++ invocation is `./impl_b .`.
2. `audit_manifest.json` is static. No generator command or source explains
   how to regenerate it.
3. The manifest's aggregate source/output hashes have no documented
   construction procedure and were not independently reproduced as aggregate
   values, even though every constituent declared file hash was checked.
4. There is no separate human-readable report artifact; the manifest,
   normalized JSON summary, literal tables, and stdout transcript must be read
   together.

The portable documented replay is therefore:

```text
./generate_domain.py
g++ -std=c++20 -O3 -Wall -Wextra -pedantic impl_b.cpp -lcrypto -o impl_b
./impl_a.py
./impl_b .
cmp impl_a_core.tsv impl_b_core.tsv
cmp impl_a_active.tsv impl_b_active.tsv
./analyze_results.py
```

The executable and regenerated large core outputs are replay products and must
not be committed.

## Final disposition

Overall Response 63 audit: **CONDITIONAL ACCEPT WITH REQUIRED CORRECTIONS**.

- Deterministic census and output claims are accepted as independent
  lead-verified computed finite evidence.
- A1, B1--B5, and C1 are accepted `proved-math` at exact hypotheses.
- C2 is accepted only with the deep premise `N*d<n*p`.
- The `(1,2,6,8,10)` obstruction is verified.
- The reverse-grid identity is reusable but not Lean-verified.
- Strict smaller-Delta first-blocker descent and the corrected DPLP selector
  remain conjectural/open.
- The pseudo-Lean block is invalid/noncompilable as written.
- No Luna claim-review endorsement, new Lean theorem, induction theorem,
  corrected DPLP proof, or unrestricted LRC claim is accepted.

Any continuation should formalize C1 with a real typed declaration, then state
the first-blocker descent with its deep-case and strict-Delta premises before
requesting implementation. The authoritative source checkpoint remains
`263a1cb8b68d8ea1d8b6333cd1e72f258b01bafa`.
