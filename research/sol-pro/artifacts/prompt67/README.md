# Prompt67 recovered verifier package

This directory preserves the exact public-safe attachments recovered by
`/root` from the completed Prompt67 GPT-5.6 Sol Pro turn. Recovery is not
independent verification.

## Canonical recovered files

| File | Bytes | SHA-256 |
| --- | ---: | --- |
| `p67_verifier_bundle.tar.gz` | 287,807 | `fd41143f944bdd22117b6048fab0905c4cba6d44101167d8105db0d74dfc537b` |
| `p67_execution_manifest.json` | 15,433 | `fb23bdd68c14970bb05c1a92f824c033145757f9c0585576b1e0f520475e8e8e` |
| `p67_literal_v1.cpp` | 9,628 | `92cdbe0666f6fdcb17d4deebdfc102656af8bf97c8390670ae4af08f0cce4fe3` |
| `p67_orbit_bitset_v1.py` | 10,548 | `8f8ba8e5b1178ed91788cf7a72ce485e7ebfa76e0819a4647b1fa80471b84332` |

The three separately downloaded manifest/source files are byte-identical to
their members in the compressed bundle.

## Archive safety and manifest boundary

The gzip-compressed tar archive contains 30 regular files totaling 5,242,372
uncompressed bytes; the largest member is 1,500,625 bytes. It contains no
absolute path, parent traversal, directory, symlink, hard link, device, or
other non-regular member. The manifest lists hashes for all 29 other members;
all 29 were present and matched, with no unlisted non-manifest member.

The bundle includes source, an executable, JSON/JSONL transcripts, timing
files, deterministic outcome maps, and failure-cover streams for the declared
`n=3,p=5` baseline and `n=4,p in {2,3,5,7}` interval. These are recovered
claims and artifacts only. They are not `computed finite evidence` until an
independent implementation and replay accept the domain, semantics, counts,
and outputs.

## Reproduction boundary

Inspect and unpack in a disposable directory:

```bash
sha256sum p67_verifier_bundle.tar.gz p67_execution_manifest.json \
  p67_literal_v1.cpp p67_orbit_bitset_v1.py
tar -tzf p67_verifier_bundle.tar.gz
mkdir bundle
tar -xzf p67_verifier_bundle.tar.gz -C bundle
```

Use the commands and environment declared by
`bundle/p67_execution_manifest.json` only after auditing them. Never execute a
recovered binary as proof. The response self-disposition is **PIVOT** to an
open obstruction-extraction route; `UniformPrimeForcingSupply`, the assembled
C2 bridge, the exact pivot selector, and unrestricted LRC remain open.
