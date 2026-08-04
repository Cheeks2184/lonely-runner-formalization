# Prompt92 recovered artifact quarantine

This directory preserves the response-linked Prompt92 files recovered by the
GPT-5.6 Sol High desktop orchestrator. They are retained for provenance and a
later independently specified replay.

Every file under `quarantine/` is **UNVERIFIED / QUARANTINED**. The Python
files were not executed or imported, the JSON files were not parsed or
evaluated, and the ZIP file was not opened or extracted. A filename, embedded
completion marker, matching checksum, or response-authored independence claim
does not make any attachment computed evidence.

## Recovered inventory

| File | Bytes | SHA-256 |
| --- | ---: | --- |
| `quarantine/verifier_a.py` | 6,218 | `528b23b4e0dc2b5cbb447c6a947962edc6e00ce440037335243c036044a1924d` |
| `quarantine/output_a.json` | 3,884 | `e09fa237362d388396ea8db4e430a912067c1fd79cffce979e64655344de6dbb` |
| `quarantine/verifier_b.py` | 6,927 | `0262aedb8ef44712347ef6ff237c163f8acc038a44cf490e59de64bb8088890a` |
| `quarantine/output_b.json` | 3,269 | `64d2c0dccb0a86cab7e97b151447a45056345de54310a80fef8304f2706d7129` |
| `quarantine/target_counterexample.py` | 4,013 | `7fcbda9eae67ec1ec2a7c67b74297569dd33fa36f5bc00c8665a15ec2a456c02` |
| `quarantine/target_counterexample.json` | 3,189 | `3c2aad8fb4d64ca1ba19d809fb5a16a4448cd9623884c47f019640715163ab10` |
| `quarantine/manifest.json` | 970 | `d8c71bcad7855dd8559d02367d40f0f8727cb4a624d71bd914f75893e25f23a7` |
| `quarantine/p92_verifier_bundle.zip` | 11,405 | `e143a6ab77258caff1e84c639fd2de247b9b7ae7de646c159b736604ba8eea15` |

The supplied manifest was inspected only as inert text. Its six file entries
state the same byte counts and SHA-256 values independently measured for the
two Python verifiers, their two outputs, and the target-counterexample source
and output. It does not list itself or the ZIP container. That consistency is
an identity check, not verification of its `COMPLETE` claim or any content.

A separate zero-byte browser download placeholder was moved by Sol High into
ignored temporary storage. It is not part of the recovered bundle and is not
tracked here.

## Response boundary

The normalized response is
`../../responses/response92.md`. It preserves the response's `STOP`
self-disposition and counterfamily claims without accepting them. All new
mathematical reasoning is **RESPONSE-AUTHORED / UNVERIFIED**. All reported
computations are **UNVERIFIED / QUARANTINED** pending an independent clean-room
replay. The claimed counterfamily concerns only Prompt92's aggregate dyadic
lemma; it is not a Lonely Runner counterexample.

See `recovery-manifest.txt` for exact byte provenance and
`../../audits/response92-recovery-audit-298.md` for rapid claim triage.
