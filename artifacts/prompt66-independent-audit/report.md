# Prompt66 independent audit — LUNA-P66-CERT-REPLAY-069

Result: `PASS` for the finite frozen-domain replay. This is independently
verified finite evidence only. It does not prove the main packing lemma.

## Scope and provenance

- Exact base commit: `136e9c6e0eeeb608bfe943762969bdc412745da0`.
- Read-only bundle: `research/sol-pro/artifacts/prompt66/SOL-P66-PRO-B-001-artifacts.zip`.
- Read-only unpacked conceptual source: `research/sol-pro/artifacts/prompt66/unpacked`.
- Bundle bytes/SHA-256: `7235209` / `4fc0f17d8feda472c6a20a7af7d2bdbdcb2f02ae82586d6d153ebcc2430fdea8`.
- ZIP inventory: exactly 21 safe entries, ordered and path-checked.
- Raw contract SHA-256: `fc4300e55e72d00a70fc25b63f9504b42923714e1e7f95bc81c22ee42b9d5d24`.
- UI-readback SHA-256 after removing exactly one trailing line terminator: `3f4e4acbc21e0fd97c5a4ca318c519c0db89ad5b358450cffdbdf80f238da9e5`.
- No network, package installation, solver binary, floating-point evidence,
  randomness, or import/execution of the supplied solver/replay was used.

The 18 hashes and sizes explicitly listed by `p66_execution_manifest.json` were
recomputed from the ZIP and all matched. The complete 21-entry inventory is
recorded below for auditability.

| ZIP entry | bytes | SHA-256 |
|---|---:|---|
| `SOL-P66-PRO-B-001-report.md` | 21463 | `c82c9775663951824d3b1fcfb77fd6c2ac892c584ecd9132b9acca43b5a76cdb` |
| `prompt66_user_contract.md` | 14759 | `fc4300e55e72d00a70fc25b63f9504b42923714e1e7f95bc81c22ee42b9d5d24` |
| `p66_execution_manifest.json` | 9850 | `a619f466ec9c6fb1dac941cb0faca9a8340c2f5cac322c56c3ff644c16c4dd7d` |
| `p66_first_obstructions.json` | 35544 | `cedc59ffe243b4226a7463240c4fc0604c35dcd0567e4212aec09c9b10602772` |
| `p66_base_witness_digest.json` | 61839 | `643422cd4264192f07d6d73b5e086c321507da2b4bc879181de28b26683ff508` |
| `p66_solver.py` | 41495 | `d7390b0cbd3dff5b2bcb396647e474a08e050b6e2a77959c13e3423a1137dd5b` |
| `p66_modular_attacks.py` | 8534 | `f199b52980996fb20ed6ea546789bf7d700eda798578f582f8fa6bd9ed8c1b7f` |
| `p66_replay.py` | 15924 | `55000919f97e9421ad91c2f83150aff47751b5f8f67aabd5bf403733ebc0b9eb` |
| `p66_replay_pre_schema_fix.py` | 15831 | `8e9026dffeed74beedf050ea9bf2815330996dbc646b6ef1348fbc4bcd044986` |
| `run3/p66_transcript.jsonl` | 2097125 | `558d7dd69b7716659c74e1b8ae0c4a46800bd8726720c2118bd487b649ab60ab` |
| `run3/p66_certificates.jsonl` | 49696666 | `7855a40758961d899d96068bd18dec4ecb85daa65e1e2f3cda449e46212398ab` |
| `run3/p66_summary.json` | 875151 | `ab452759adbb7a0df4ea1dc6b75a83e8c6bdadb3b21f908a843bd02bda4f5529` |
| `run3/p66_replay_report.json` | 1131 | `077e98fd299802ab3182d6ff142d810146f21526d864c12eea248571f4af122d` |
| `run3/solver_progress.log` | 4285 | `f4dfe9fed1cfeb77e04b5e1057fa7dc68e4c05da631da7e66034701703b9d040` |
| `attacks/p66_attack_radial_descent_transcript.jsonl` | 2908 | `e810e0e8511be0733f38cc075e1ee9660f12cf87c83e45121d5bdcc018c4b93b` |
| `attacks/p66_attack_radial_descent_certificates.jsonl` | 208048 | `c9f706c13f676b578c41c1de17d97f124bdadb29af5433e361161337b911b75e` |
| `attacks/p66_attack_radial_descent_summary.json` | 1303 | `607b4e4dae4899b34f753f6c18c2a472b1fabe429dd9859999874550729ad2b2` |
| `attacks/p66_attack_signed_phase_cells_transcript.jsonl` | 2939 | `9a51b9811dd5d2925a906d276d0d127c8fce4c339ce246f069a69ff81c3c0b01` |
| `attacks/p66_attack_signed_phase_cells_certificates.jsonl` | 156211 | `9e51fb7727db023e1ccc94b3834464d694f9c2eeb79c37e9b917a9bfaf484f60` |
| `attacks/p66_attack_signed_phase_cells_summary.json` | 1303 | `8ca1ee50aea3befd520d38eb84431614eb46be609d68098d3d6cc715ef2f1b77` |
| `attacks/p66_attacks_summary.json` | 3295 | `af087931f9bcfada371bbae6032d6e75a827c7c4e60a5f76363ac12ca509cd04` |

## Independent replay counts

| Quantity | Verified value |
|---|---:|
| triangle preflight | 1 |
| base tuples / base pivots | 11 / 92 |
| retained mutation descriptors (not deduplicated) | 461 |
| mutation pivots | 4,057 |
| modular rows / total cases | 4,149 / 4,150 |
| complete tuple bundles | 472 |
| strict witness pivots | 3714 |
| fixed-pivot failures | 435 |
| exact rational weak-dual failures | 421 |
| exact rational branch-tree failures | 14 |
| exact integer optima independently certified | 380 |
| supplied exact-optimum flags not independently supported | 55 |
| all-pivot tuple hits | 0 |

Every modular row reconstructed `R`, all strict bad sets, canonical attained
targets, complete fibers, eligible whole blocks, `mu`, natural capacity `mu-1`,
`S`, and the literal bad-set union. Every supplied selection was checked for
one parent per token, parent eligibility/distinctness from its owner and pivot,
whole-block equality, exact residues, point capacities, credit, and strict
threshold. Equality was treated as failure.

The supplied transcript marks every fixed-pivot failure as `exact_optimum`.
That label was accepted only where an independently replayed feasible lower
bound coincided with the integer floor of the checked upper certificate. Rows
where the supplied selection was lower than the checked upper bound remain
verified fixed-pivot failures when the upper bound proves the threshold, but
their exact optimum label was not promoted.

## First fixed-pivot obstruction

The first fixed-pivot packing failure in the declared order is tuple `F`, pivot
speed `48`, with `R=432`, `S=706`, union size `392`, exact integer optimum
`262`, and rational upper bound `1314/5`. Its required strict credit boundary
is `274`, so the fixed-pivot packing instance fails. The same row has literal
noncoverage because its union is smaller than `R`; this does not turn the row
into an all-pivot packing refutation, an all-pivot certificate refutation, or
an LRC counterexample. No tuple had packing failure at every pivot.

## Rejected sufficient criteria on the complete nine-pivot F bundle

| Pivot | Radial-descent credit | Signed-phase-cell credit | Required strict boundary |
|---:|---:|---:|---:|
| 8 | 16 | 12 | 32 |
| 15 | 90 | 40 | 102 |
| 35 | 132 | 75 | 188 |
| 40 | 122 | 78 | 194 |
| 48 | 150 | 72 | 274 |
| 56 | 156 | 89 | 308 |
| 75 | 352 | 193 | 382 |
| 132 | 444 | 204 | 692 |
| 147 | 576 | 286 | 792 |

The radial-descent and signed-phase-cell data were replayed from their modular
definitions, including all per-token maxima, ties, chosen whole blocks,
capacity checks, and the signed cell-owner hash. Both criteria fail on every
pivot of `F`, so both are labeled `rejected`. This supports only rejection of
those sufficient criteria; it is not a failure of the main packing lemma.

## Toolchain and final artifact hashes

- Python: `3.14.4` (cpython).
- Platform: `Linux-6.18.33.2-microsoft-standard-WSL2-x86_64-with-glibc2.43`.
- Deterministic/no-randomness status: deterministic; no random source used.
- Runtime: `15.098` seconds.
- Verifier SHA-256: `2294a9764b4215a9e91c99f78fa70fe14fb25bc80fbfdba86bec75f8a0394fc0`.
- Tests SHA-256: `805a58b29e868b12f4011e2d134f65ffaa822b5353d37c7280f2625833f54ded`.

The final report SHA-256 is recorded in the audit manifest. The verifier emits
the final manifest SHA-256 after writing both artifacts.

## Status labels

- `computed finite evidence`: all 4,150 frozen cases and both complete F
  criterion bundles above.
- `rejected`: radial-descent and signed-phase-cell uniform criteria.
- `open`: `ALL-PIVOT-MODULAR-WHOLE-BLOCK-PACKING` and unrestricted LRC.

No theorem, axiom, solver output, or unrestricted status was promoted.
