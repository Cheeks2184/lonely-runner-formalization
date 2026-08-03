# Response 62 audit

Response 62 studies a top-two pivot route through exact CRT counts, scalar
moment inequalities, quotient slices, and an owner-aware multi-shift affine
transversal. Verification task `VER-R62-AUDIT-010` accepts the finite replay
and several local paper lemmas at their exact hypotheses, rejects every tested
uniform scalar shortcut, and returns an overall branch result of **FAIL**.
The named multi-shift bridge remains conjectural/open, and no new Lean theorem
or unrestricted Lonely Runner claim is accepted.

The audited repository base is
`477fbffc709d0550c163e2812f26193a4ec38cff`. The public-safe Luna routing
fingerprint is
`7ca6b1c53c233b9f89de399fd264410d70a6346de1889e3d297fddb2f569f775`;
no raw session identifier is published.

Audited source material is the tracked
[Response 62](../research/sol-pro/responses/response62.md) and the
[Prompt 62 artifact directory](../research/sol-pro/artifacts/prompt62/).
The normalized response has SHA-256
`a1795d9ed48939feef55b66d59675eca4283c3ca6973fb8e93e4efa7f9bf5a17`.
This reconciles the audit to the corrected tracked recovery rather than an
earlier transport copy. The original clipboard capture remains provenance,
not the audited normalized file: SHA-256
`1bb1e183874e6217a232656848f7fc295b85fee42723135c41a4766ba9791c56`.

## Mandatory artifact replay: PASS with environment-only report drift

The audit replayed all 8,108 declared rows. Literal Python and optimized C++
outputs were byte-identical, the manifest and archived output hashes matched,
and the independent hard instance `(N,A,B)=(7,98,187)` reproduced affine
transversal number `tau=5`: all 3,464,840 four-element lower sets fail, while
a five-element hitting set exists. These are **verified computed finite
evidence**, not uniform proofs.

Key archived hashes are:

- manifest: `585c2237f294908f8a5d396c8859abf3b07b283f15b204db984ee3e240394411`;
- literal and optimized outputs:
  `233b2d03c6289d151d00355827b0994b766028a43ba4fb3c602945d0e0851236`;
- hard-affine transcript:
  `8d130da9b82d1833009cd901d01805e44760af6a85e06a1d8da1f462e4d0b73f`;
- archived report:
  `f9810398efbb676f4c59bdfa1385d936ceed99963494758d726baa8f2d16c75a`.

The regenerated report has SHA-256
`6498638acccad8a2d8308bd1cdf5533cd1d70bb2198fbf19b168c799292e2c`.
It differs from the archived report only at lines 3--5: the live `python`,
`compiler`, and `platform` fields. The report tails beginning at line 6 are
byte-identical. Runtime/environment drift therefore does not change the
deterministic finite payload.

### Corrected reproduction commands

The README commands are unusable as written. The literal and C++ programs
require explicit output arguments that the README omits. Shell redirection
also opens and truncates files that the generator, hard-affine verifier, and
reporter write themselves, making those commands self-corrupting.

Run from `research/sol-pro/artifacts/prompt62` without those redirects:

```text
python3 generate_manifest.py
python3 pro_b_top_two_literal.py pro_b_manifest.txt pro_b_literal.out
g++ -O3 -std=c++20 pro_b_top_two_optimized.cpp -o pro_b_top_two_optimized
./pro_b_top_two_optimized pro_b_manifest.txt pro_b_optimized.out
cmp -s pro_b_literal.out pro_b_optimized.out
python3 pro_b_affine_hard_verifier.py
python3 pro_b_report.py
sha256sum -c SHA256SUMS
```

The compiled executable is an untracked replay product and must not be added
to the repository.

## Mathematical dispositions

The following local arguments are accepted as `proved-math`, only at the
hypotheses stated in Response 62:

- canonical pivot-coordinate selection and explicit top-two maximality;
- `TOP-TWO-PIVOT` implying the all-pivot target, including its one-speed base;
- exact affine-fiber cardinality and same-owner affine-shift exclusion;
- the one-shift affine-union, quadratic multiplicity, cubic Bonferroni, and
  quotient-slice dual implications as conditional implications.

This audit does not relabel any Response 62 self-description as a new
`proved-lean` result. Existing project theorems retain only their previously
audited scope.

The finite sweep rejects uniform full quadratic, full cubic, robust
quadratic, robust cubic, quotient-slice dual, and one-shift affine-union
criteria. A finite minimum means minimum only in the declared 8,108-row order;
it is not global mathematical minimality.

The displayed `RQ2` formula requires `n>=3`. For `n=2`, the robust family has
no remaining lower bad sets after removing the other top speed, so the audit
uses the explicit convention `H0^R` rather than treating the displayed
coefficient formula as uniformly defined.

## Formal residual-spec audit: project-level chain FAIL

`FORM-R62-RESIDUAL-SPEC-012` checked whether Response 62's combined
`Residual` is a current project theorem assembled from tracked declarations.
It is not. There is no declaration or source-to-result chain establishing the
complete residual conjunction.

For top indices `jA,jB` with speeds `A<B` and `N=n+1`, the first genuinely
missing edge is

```text
2 * speeds jB <= N * speeds jA
```

Equivalently, in the response's top-speed notation, the missing inequality is
`2 * B ≤ N * A`.

This is the exact first project-level mathematical gap. It must not be hidden
inside a residual abbreviation or assumed as a consequence of the existing
compression results.

The neighboring steps are routine only after their premises are supplied:

- `B < n*A` follows from `FastRunnerInsertion` only with an explicit witness
  for the deleted family and the required reindexing;
- the terminal-interval conclusion follows from
  `divisor_cover_of_no_small_witness`, positivity, top-two ordering, and
  `B<2q`, under an explicit no-full-witness premise.

Neither observation assembles the full `Residual`. Lower-dimensional witness
or no-witness hypotheses must be bound explicitly; they cannot be inferred
from a response label.

## Final disposition

Overall Response 62 branch audit: **FAIL / mixed disposition**.

- The 8,108-row sweep and hard `tau=5` instance are verified computed finite
  evidence.
- The local lemmas above are accepted `proved-math` at exact hypotheses.
- Uniform scalar criteria are rejected.
- `RESIDUAL-2N-SHIFT-OWNER-TRANSVERSAL` is conjectural/open.
- `TOP-TWO-INTEGRAL-TRANSVERSAL`, `TOP-TWO-PIVOT`, the all-pivot certificate,
  corrected DPLP, and unrestricted Lonely Runner remain open.

No Luna implementation should begin until a theorem contract supplies the
missing `2*B<=N*A` edge and explicitly binds every lower-dimensional and
no-witness premise. The source checkpoint remains
`263a1cb8b68d8ea1d8b6333cd1e72f258b01bafa`.
