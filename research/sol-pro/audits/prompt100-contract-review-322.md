# Prompt100 independent contract review

- Task: `P100-INDEPENDENT-CONTRACT-REVIEW-322`
- Candidate commit: `f3870caca038cc889420ff1d69d9eedefe5818a4`
- Candidate base: `64d5a6a62df3cdc963aacc809600bd7d9d10a9ed`
- Decision: `ACCEPT` as a launch-ready supporting contract
- Route classification: Prompt95 maximum-covered-pivot subroute
- Independent third-cell classification: `NO`

The exact target is non-tautological and strictly narrower than Prompt95:
two distinct positive lower owners cannot cover the full strict candidate row
when `N>=4`. If proved, it excludes internal inclusion-minimal covers of size
two and proves the Prompt95 redundancy conclusion in the finite-label regime
`|F(a)|<=3`. It does not settle Prompt95 for `|F(a)|>=4`, the uniform pivot
existential, integer LRC, or unrestricted LRC.

## Scope and boundary review

The canonical residue convention, strict badness, closed safety complement,
candidate exclusion `N does not divide r`, labelled-owner semantics, and
nonunit multiplication fibers are all explicit. The `N=3` counterexamples
correctly explain the target boundary. The separate `N=3` owner-count argument
for the Prompt95 consequence is valid because `n=2` leaves at most one
nonpivot owner.

The finite-deletion argument is valid: when `|F(a)|<=3`, an internal cover at
the maximum covered pivot uses at most two labelled owners and has an
inclusion-minimal subcover of the same bound. The stated conclusion is
vacuous after internal covers are excluded, and the prompt labels it as such.

## Independent preflight

A separate literal in-memory checker recomputed singleton noncoverage for
`3<=N<=15`, `1<=p<=80`, and every `1<=d<p`; it also recomputed two-owner
noncoverage for `4<=N<=12`, `1<=p<=80`, and every `1<=b<c<p`. No failure was
found. This bounded run is contract preflight only, was not artifact-bound,
and is not `computed finite evidence`.

The candidate blob hashes were independently recomputed:

- full file SHA-256:
  `3c4fcbe31049b6d5b1b9253627b690dd71dc3abf15f9fa50e8234bc954faa96c`;
- prompt payload SHA-256, from the heading `# Prompt 100:` through EOF:
  `f353ac34583d2223276dd08f87acaac6afc996d4507040624c9141cb6386d344`.

`git diff --check` passed for the candidate change. No Lean source,
certificate, verifier, evidence label, or theorem status changed, so this is a
Level 1 contract review and no Level 3 replay is warranted.

## PI disposition

Prompt100 is launch-ready but does not satisfy the continuous-pipeline demand
for a genuinely independent third active route while Prompt98 and Prompt99
occupy the same Prompt95 program. It remains queued as one of the audited
ready contracts. A distinct global cross-pivot contract must fill the third
active cell first.
