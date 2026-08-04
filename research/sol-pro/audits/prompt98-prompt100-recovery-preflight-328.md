# Prompt98-Prompt100 recovery and audit preflight

- Task: `OPS-P98-P100-RECOVERY-PREFLIGHT-PERSISTENCE-329`
- Source review task: `OPS-P98-P100-RECOVERY-PREFLIGHT-328`
- Frozen base reviewed: `1c3cfe7746ab672184c5f77a9d6dbe708a50ff37`
- Persistence base: `4b3f063dae5a6a1e6cac9298f5c95a99a997b2a2`
- Scope: tracked Prompt98, Prompt99, and Prompt100 contracts and public launch records only
- Evidence effect: none; this is an operational preflight

The provenance gate passed. All three recorded prompt commits, tracked prompt
hashes, submitted-payload hashes, sizes, and LF counts replay exactly. No
launch-provenance mismatch was found. This review did not operate a browser,
recover a response, access quarantine, execute an attachment, or promote any
mathematical or computational claim.

## Prompt98 checklist

Successor IDs:

- Recovery: `OPS-P98-RESPONSE-RECOVERY-330`
- Independent audit: `VER-P98-MATHEMATICAL-AUDIT-331`
- Conditional Luna replay: `LUNA-P98-STOP-OR-SCAN-REPLAY-336`

Frozen launch identity:

- Prompt task: `SOL-P98-PRO-MAX-COVERED-NONDIVISIBLE-PIVOT-REDUNDANCY-315`
- Launch task: `SOL-P98-DESKTOP-LAUNCH-317`
- Prompt path: `research/sol-pro/prompts/prompt98.md`
- Launch-record path: `research/sol-pro/launches/prompt98-2026-08-04.md`
- Prompt commit: `4c35f883e0bb11a2ab1c124327860116b3eff2a9`
- Blob: `9cdf12d13aaf2090b92bbd179800739b7261ac78`
- Prompt SHA-256: `cce1b85fe24c341b6b555eb245afc6bae17466cc3ec6bebc3b11a1e257b603c8`
- Submitted SHA-256: `930b63e7a07cff39cc3bbbb81bc82813fbd94c8b1f5f03f61745ac3a15bfacb5`
- Launch-record SHA-256: `6e91c3e4c4d9f9ae9b258fb4ec11f90a818a2437ab1b3c93cc63706405d2d41c`

Recovery:

- Capture the complete response without editing.
- Expect exactly 15 sections: Disposition; Evidence boundary; Exact
  definitions; Branch equivalences; `t*p` slice proof; Fixture ledger; Lanes
  A-D; Sole theorem; Branch consequence; Proof-obligation ledger;
  Declaration-level plan; Final evidence table.
- Accept only one self-disposition: `PIVOT`, `STOP`, or `SEPARATION`.
- Computation is optional. If present, inventory Implementation A/B source and
  outputs, language/version, domain, ordering, completion marker, hashes,
  disagreements, theorem failures, and malformed-input failures.
- Missing computation artifacts force all response-reported scan claims to
  `unverified response-authored`, not finite evidence.

Hash handling:

- Hash raw recovered bytes before transformation.
- Normalize only documented CRLF-to-LF line endings and terminal-LF policy.
- Do not trim, reflow, Unicode-normalize, or modify code blocks.
- Hash the normalized response independently and prove raw/normalized
  round-trip.
- Hash attachments over exact downloaded bytes; never normalize attachments.

Quarantine:

- Store every attachment or archive byte-for-byte in quarantine.
- Level 1 may record only public filename, byte count, whole-file hash, and
  response linkage.
- Do not list archive members, parse, import, or execute.
- Mathematical audit must use the normalized response only.
- Any later executable review requires a fresh safety-reviewed copy and a
  frozen Level-2 specification.

First mathematical checks:

- Verify every quantifier of the maximum-covered-pivot `N`-nondivisible branch
  and all three coverwise equivalences.
- Reprove `rho_(N*p)(t*p*b)=p*rho_N(t*b)`, candidate status, and badness iff
  `N` divides `t*b`.
- At `t=1`, verify that complete coverage forces an `N`-divisible selected
  owner.
- Reject any leap from forced ownership to redundancy without literal
  deletion, inclusion, projection, or descent.
- Audit every cross-modulus map, fiber, strict boundary, candidate
  preservation, label preservation, and descent key.
- Ensure the conclusion remains branch-only; the `N`-divisible branch,
  Prompt95, the pivot theorem, and LRC remain open.

Fixtures:

- `(6,7,12,24,144)`: `F={6,7,12,24}`, `j_star=24`, branch excluded; pivot
  `7` is transport-only with minimal covers `{6,12,24}` and `{6,12,144}`;
  `{6,12}` fails first at `r=2`.
- `(1,8,13,15,27,28)`: `F={1,8}`, `j_star=8`, only internal owner `1`;
  `r=8` is covered by `28` and safe for `1`.
- `(1,6,11,12,13)`: divisible-boundary exclusion.
- Strict equality `(1,3,4,5)`, coincident labelled sets `(1,3,13)`, nonunits
  `(1,2,3)`, malformed repeated speeds, and pivot-owner rejection.
- Scaling by `7` must change branch membership and cannot be used as
  normalization.

Triage:

- A valid theorem-domain `STOP` counterexample with full row, cover, and
  private data plus two immutable verifiers is provisionally promising.
  Conditional task 336 becomes `LUNA-READY` only after Medium source-safety
  review and fixture freeze.
- `PIVOT` is `MEDIUM-SPEC-REQUIRED`; first perform the proof audit. No Lean
  task starts until signatures and dependencies are frozen.
- `SEPARATION` containing only the mandatory slice is mixed or stopped and
  `RESEARCH-UNRESOLVED`.
- A genuinely proved narrower peeling or descent lemma is
  `MEDIUM-SPEC-REQUIRED`.
- A partial scan, missing artifacts, malformed counterexample, or wrong
  `j_star` is rejected operational output.

## Prompt99 checklist

Successor IDs:

- Recovery: `OPS-P99-RESPONSE-RECOVERY-332`
- Independent audit: `VER-P99-MATHEMATICAL-AUDIT-333`
- Conditional Luna replay: `LUNA-P99-STOP-OR-QUOTIENT-REPLAY-337`

Frozen launch identity:

- Prompt task: `SOL-P99-PRO-MAX-COVERED-DIVISIBLE-PIVOT-REDUNDANCY-316`
- Launch task: `SOL-P99-DESKTOP-LAUNCH-318`
- Prompt path: `research/sol-pro/prompts/prompt99.md`
- Launch-record path: `research/sol-pro/launches/prompt99-2026-08-04.md`
- Prompt commit: `79c81a5ee9d6d87948bc74aec703909ff89e8a30`
- Blob: `df8c238e68da776a9af6a0916eb65e72bb08d08b`
- Prompt SHA-256: `56afb4187eeb0f15e423f74a0c026f1725deaee3620d4b64819663b38564c716`
- Submitted SHA-256: `5bced1512485c8b7ca46a07cc6d7e7c9a4a8dc86ea2bdf872439a43a0fcef2b5`
- Launch-record SHA-256: `0e04dc063434d45387fb7664321fd7832c5a43df0744c15ba559549463359726`

Recovery:

- Expect exactly 15 sections: Disposition; Evidence boundary; Exact
  definitions; Branch equivalences; Quotient structure; Fixture ledger; Lanes
  A-D; Sole theorem; Dependency map; Proof-obligation ledger;
  Declaration-level plan; Final evidence table.
- Require exactly one `PIVOT`, `STOP`, or `SEPARATION`.
- If computation ran, inventory both independent implementations, quotient
  tables, sources, outputs, domain and order, completion markers, hashes,
  first disagreement, theorem failure, and malformed failure.
- Missing executable artifacts leave every scan claim unverified.

Raw/normalized hashing and quarantine:

- Apply the Prompt98 hashing and round-trip rules exactly.
- In Level 1, never parse phase tables or execute quotient code.
- Preserve archive or file bytes and identities only.
- Require a separate Level-2 safety and replay contract before extraction or
  execution.

First mathematical checks:

- Verify `p=N*d`, `M=N^2*d`, unique `r=x+k*p`, and `r in R` iff `x in S`.
- Verify phase multiplicities: for `h=gcd(N,b)`, phases visit `N/h` multiples
  of `h`, each exactly `h` times.
- For `N` dividing `b`, verify the full-fiber identities and strict quotient
  threshold.
- Reject projection-only coverage: every claimed inclusion must lift
  phasewise across all `N` sheets.
- Reject treating formal quotient pivot `d` as an actual covered tuple pivot
  without proving tuple, `F`, and `j_star` premises.
- Audit every `p/N` descent, cover exchange, lift-back, and well-founded
  decrease.
- Prompt98 is complementary active research, never a premise.

Fixtures:

- `(1,6,11,12,13)`: `F={1,6}`, `j_star=6`, `d=1`; minimal cover
  `{1,11,12,13}` is noninternal; internal `{1}` first misses `7`.
- `(6,7,12,24,144)`: `F={6,7,12,24}`, `j_star=24`, `d=4`; minimal cover
  `{144}`; internal `{6,7,12}` first misses `4`; owners `6,12` are full-fiber
  and `7` is phase-dependent.
- Base `(1,8,13,15,27,28)` is outside the branch; scaling by `7` gives
  `j_star=56`, minimal cover `{7,91,105,189,196}`, and internal `{7}` first
  misses `8`.
- Equality `(1,3,4,5)`, labelled collision `(1,4,17)`, nonunits `(1,2,3)`,
  excluded antipode, and malformed tuple, owner, and wrong-pivot controls.
- Require one constant fiber, unit-phase owner, intermediate-gcd owner,
  quotient equality, and a projected inclusion that fails on lift-back.

Triage:

- A valid `N`-divisible maximum-pivot internal-minimal-cover counterexample
  with quotient and phase data plus two verifiers is provisionally promising.
  Task 337 becomes `LUNA-READY` only after safety review and exact replay
  freeze.
- `PIVOT` is `MEDIUM-SPEC-REQUIRED`, pending full quotient and lift audit.
- Quotient identities alone are informative but not the theorem and remain
  `RESEARCH-UNRESOLVED`.
- A narrow proved phasewise inclusion or descent lemma is
  `MEDIUM-SPEC-REQUIRED`.
- Projection without phases, an invalid quotient tuple, missing lift-back, or
  a partial scan is rejected.

## Prompt100 checklist

Successor IDs:

- Recovery: `OPS-P100-RESPONSE-RECOVERY-334`
- Independent audit: `VER-P100-MATHEMATICAL-AUDIT-335`
- Conditional Luna replay: `LUNA-P100-TWO-OWNER-REPLAY-338`

Frozen launch identity:

- Prompt task: `SOL-P100-PRO-TWO-LOWER-OWNER-NONCOVER-319`
- Launch task: `SOL-P100-DESKTOP-LAUNCH-325`
- Route: P95 supporting subroute, not an independent third Pro route
- Prompt path: `research/sol-pro/prompts/prompt100.md`
- Launch-record path: `research/sol-pro/launches/prompt100-2026-08-04.md`
- Prompt commit and base at launch: `591b01173ef769bbbf02d265a7da3d92c7024e27`
- Blob: `aa112b5eaf028bd2ca2ae3fe4d9226d7839321a9`
- Prompt SHA-256: `a2aaa9c51334bcd9a93df54f470e4e4650494f027f28e04e9702b8bc5cffe4cd`
- Scoped SHA-256: `f353ac34583d2223276dd08f87acaac6afc996d4507040624c9141cb6386d344`
- Submitted SHA-256: `ea2f23f0b24bcf34540400c7cb003355021c1cc59c196ff13d41414d58080486`
- Launch-record SHA-256: `994ad840bd669fc21f56c561de95bba70d567f455516a07ba3355b75aa6a0d8a`

Recovery:

- Expect exactly 12 sections: Outcome; Frozen definitions and equivalence;
  Fixture audit; Main theorem or refutation; Common-overlap analysis; Slice
  analysis; Adversarial review; Prompt95 consequence; Finite falsifiers;
  Proof-obligation ledger; Declaration-level plan; Final evidence table.
- Require exactly one `PROVE`, `STOP`, or `SEPARATION`.
- If finite work ran, require three separate attachments: deterministic
  source, machine-readable manifest, and machine-readable result.
- Inventory both literal and independent congruence-fiber methods, frozen
  domains, source/result binding, fixture status, counts, exit status, first
  failure, and hashes.
- Any missing attachment, incomplete domain, stale binding, or failed fixture
  is rejected operational output.

Raw/normalized hashing and quarantine:

- Apply the same response rules as Prompt98.
- Hash each of the three expected attachments independently without
  normalization.
- Level 1 records identity only; no source parsing or execution.
- Level 2 begins only after a Medium source-safety review and exact replay
  contract.

First mathematical checks:

- Verify exact quantifiers `N>=4`, `p>=1`, `0<b<c<p`, canonical `R(N,p)`,
  strict `B_d`, and the closed complement.
- Audit any overlap-capacity count with gcd fiber multiplicities and strict
  endpoints.
- Verify `t*p` identities and every `t*p+/-1` candidate or wraparound claim
  without cancellation.
- Test explicit witnesses across adjacent owners, `N` dividing `b` or `c`,
  large gcd, `N` dividing `p`, coprime `p`, equality-only witnesses, nonunits,
  `N=4`, false `N=3`, and scaling.
- For `PROVE`, separately audit singleton rigidity and the complete seven-step
  `|F(a)|<=3` consequence.
- Do not treat the consequence as an independent global route or as full
  Prompt95.

Fixtures:

- False `N=3` covers `(3,3,1,2)` and `(3,5,2,3)`.
- Exact `N=4` controls `(4,3,1,2)`, `(4,4,1,3)`, and `(4,5,2,3)`.
- Equality and collision `(4,6,1,5,r=6)`.
- Scaling `(4,15,5,10)`.
- Degenerate fiber `N=4,p=5,d=2,r=1,11`.
- Malformed premises and a deliberately altered uncovered set.
- Prompt95 tuples `(1,6,11,12,13)`, `(6,7,12,24,144)`, and
  `(1,4,5,6,7,11)`, with all internal pairs checked.

Triage:

- An exact covering-pair counterexample with full canonical lists and
  independent reproduction is `LUNA-READY` for task 338 after immutable
  hashes and Medium preflight approval.
- A completed dual finite scan with all three artifacts is a candidate
  `LUNA-READY` replay after safety review, at finite scope only.
- `PROVE` is `MEDIUM-SPEC-REQUIRED`; audit the proof before freezing Lean
  signatures.
- A proved strict narrower lemma is `MEDIUM-SPEC-REQUIRED`.
- An open overlap inequality, witness ansatz, or missing uniform case is
  `RESEARCH-UNRESOLVED`.
- A zero-failure scan alone, tautological complement, or `N=3`
  "counterexample" is rejected as proof or refutation.

## Verification-level boundary

Level 1 includes only provenance, raw/normalized round-trip, hashes,
attachment inventory, privacy and secret scanning, response-schema checks,
and a provisional claim table. It does not parse or execute source, replay a
certificate, run Lean, or establish mathematical or computed finite evidence.

Level 2 starts only after source-safety review and a frozen specification. It
may then extract into isolation, run mandatory preflight fixtures, execute the
declared source, perform independent replay, verify certificate/source
binding, compile targeted Lean modules, and run axiom probes.

No Level-3 clean repository replay is triggered by response recovery or
documentation alone.
