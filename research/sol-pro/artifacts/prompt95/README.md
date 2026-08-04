# Prompt95 recovered artifact quarantine

This directory preserves the three response-linked Prompt95 files recovered
by the GPT-5.6 Sol High desktop orchestrator. They are retained byte-for-byte
for provenance and a later independently specified replay.

Every file under `quarantine/` is **UNVERIFIED / QUARANTINED**. No attachment
was executed, imported, opened, read, parsed, or interpreted during recovery.
In particular, the `.py` and `.json` suffixes did not authorize source or JSON
inspection. Their internal schemas, fields, completion markers,
source-to-output bindings, and mathematical claims remain unverified.

## Recovered inventory

| File | Bytes | SHA-256 |
| --- | ---: | --- |
| `quarantine/prompt95_literal_verifier.py` | 24,203 | `2c1228c059b26b76f804bc3d55b1ca143344d1685c0c799f24707e10620082ff` |
| `quarantine/prompt95_manifest.json` | 1,397 | `e1d4a00dec974926fcaa421e2ee10ef13871427b7a47895a74dd65e2c8c1f9ae` |
| `quarantine/prompt95_result.json` | 138,577 | `71c9c47d9869ee4f25ae5ab792797624cd993d330741c1098636d55b2767eb34` |

Each measured file hash exactly matches the corresponding hash printed in the
response. This establishes byte identity only. It does not verify safe source,
result correctness, determinism, domain completion, independence, or any
mathematical claim.

## Response boundary

The normalized response is `../../responses/response95.md`. It preserves the
response's `PIVOT` self-label without accepting it. All response reasoning is
**RESPONSE-AUTHORED / UNVERIFIED**. The reported bounded run is
**UNVERIFIED / QUARANTINED**, not accepted computed finite evidence.

See `recovery-manifest.txt` for exact byte provenance and
`../../audits/response95-recovery-audit-310.md` for fail-closed provisional
triage.
