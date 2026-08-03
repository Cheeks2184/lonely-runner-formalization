# Public-release audit

Audit date: 2026-08-02.

The publication audit covers the current tree, ignored/untracked paths, Git
filenames and blobs across all preserved commits, commit metadata, and the
largest historical objects. History was inspected without rewriting it.

## Automated history scan

Gitleaks v8.30.1 was run with redaction from the pinned container image:

```bash
docker run --rm -v "$PWD:/repo" \
  zricethezav/gitleaks@sha256:c00b6bd0aeb3071cbcb79009cb16a60dd9e0a7c60e2be9ab65d25e6bc8abbb7f \
  detect --source /repo --redact --no-banner
```

Result: 211 commits and approximately 2.50 MB were scanned; no leaks were
found.

The exact staged public delta was also passed to Gitleaks through standard
input so newly added, not-yet-committed files were covered. It scanned 117.15
KB before this audit-note update and found no leak. Together, the history scan,
manual current-tree scan, and staged scan cover the resulting preserved public
history without rewriting it. The final staged delta is rescanned after this
note is staged and passed without a finding.

## Independent manual audit

The current tree and history were separately checked for:

- private-key headers;
- GitHub, OpenAI, and AWS credential shapes;
- JWT-shaped values and database/Redis connection URIs;
- credential/profile/session/cookie/screenshot filenames;
- personal email addresses in tracked content and commit metadata;
- absolute user/profile paths and machine identifiers;
- papers, archives, screenshots, and other redistribution-sensitive binaries;
- generated builds, caches, virtual environments, scratch files, and nested
  verification repositories;
- historical blobs larger than 5 MiB.

No credential or sensitive artifact was found. Commit metadata uses only local
placeholder email domains. No tracked paper, archive, screenshot, raster
image, browser profile, session export, or historical blob over 5 MiB exists.
Nine non-secret local checkout paths in the build log were replaced by the
public placeholder `<clean-ext4-checkout>` in the release tree. Ignored local
state consists of Lake and Python caches.

At the latest checkpoint there are 340 tracked-or-staged public files and no
untracked public file. The only generic risky-name match is the deliberately
published mathematical transcript `research/sol-pro/session-001.md`; manual
inspection found no browser or authentication session data in it. The targeted
scan found no absolute local path, email address in file content,
high-confidence secret shape, file over 5 MiB, or Gitlink. Ignored state is
limited to `.lake/`, `scratch/`, and Python bytecode caches; none is staged.

The repository has no selected license. The README states this explicitly.

## Ongoing policy

Before a coherent checkpoint is pushed, run:

```bash
bash scripts/audit_public_release.sh
git status --short --ignored
```

Then run the Lean/Python checks appropriate to the changed files, update
`STATUS.md` and the proof-obligation ledger, and inspect every newly added
path. A real credential in preserved history is a stop condition requiring
history remediation and credential rotation before publication.
