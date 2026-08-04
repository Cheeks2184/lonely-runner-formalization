# Prompt101 independent contract review

- Task: `P101-INDEPENDENT-CONTRACT-REVIEW-326`
- Candidate commit: `2480b9baa8600a8e97338973e8b55bbe309354e9`
- Candidate base: `e70135a2a82c22c0e2664e91426e0820a50d023b`
- Decision: `ACCEPT / LAUNCH-READY`
- Route classification: independent unrestricted global cross-pivot route

The contract freezes one exact theorem: the normalized bad-incidence matrix
on the tuple-dependent covered-pivot set admits a strictly positive rational
vector `x` with `A_F*x<x`. This is not an unfolded pivot certificate. It is a
strict simultaneous matrix condition even for tuples that already have an
uncovered pivot outside `F(a)`.

If every pivot were covered, `F(a)` would contain every label. At a label of
minimum weight, the cover union bound gives a normalized row sum at least one,
while all other weights are at least the selected weight. This contradicts
the strict row inequality. The implication to a pivot certificate is therefore
correct, conditional on the new matrix theorem.

## Independence review

The matrix target selects no maximum pivot, minimal cover, private candidate,
escaping owner, prime, packing block, unit stratum, or height normalization.
It is distinct from Prompt98/99 maximum-pivot redundancy and from Prompt100's
single-row two-owner theorem. It partially resembles the stopped scalar-score
routes, but the weights solve a tuple-dependent coupled system rather than
summing a fixed separable margin. The Prompt82 negative-score tuple is an
explicit mandatory control rather than a premise.

## Independent preflight

A separate literal in-memory implementation constructed `F(a)` and `A_F`,
then solved `(I-A_F)x=1` exactly over rational numbers. It found positive
solutions for the three mandatory obstruction tuples and for every primitive
increasing tuple in the independent boxes `(n,H)=(2,20),(3,14),(4,11)`. The
all-label strengthening on `(1,2,3,5)` reproduced row sums
`(1,1,1,6/5)` and therefore failed as required. These bounded calculations
are admission preflight only, are not artifact-bound, and are not
`computed finite evidence`.

The candidate hashes were independently reproduced:

- full file SHA-256:
  `37fd5c003fd132935ecdba1489d46ce17b2906aa69f903495d20901e524576c2`;
- prompt body SHA-256 from `# Prompt 101:` through EOF:
  `8b521df036b221d916f43af34455f8dbf0f583b4b52b344d8c94a603a677f555`.

`git diff --check` passed. No source, certificate, theorem, or evidence label
changed, so this is a Level 1 contract checkpoint. Prompt101 is queued while
the three active Pro cells run; contract acceptance itself promotes nothing.
