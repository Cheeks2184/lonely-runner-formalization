# PRO-C deletion/correlation audit bundle

Audit version: `PRO-C-AUDIT-1.0.0`.

## Reproduction

```bash
cd /mnt/data/pro_c_audit
./generate_domain.py
g++ -std=c++20 -O3 -Wall -Wextra -pedantic impl_b.cpp -lcrypto -o impl_b
./impl_a.py
./impl_b /mnt/data/pro_c_audit
cmp impl_a_core.tsv impl_b_core.tsv
cmp impl_a_active.tsv impl_b_active.tsv
./analyze_results.py
```

## Domain

`domain.tsv` contains 4,694 primitive, positive, injective tuples. Ordering is first insertion by the family order in `generate_domain.py`; tuple values are sorted ascending; exact duplicates are merged. The families are mandatory tuples, consecutive tuples through moving dimension 30, literature tight sets, `N`-spikes, affine-residue constructions, large `N`-multiples, mutations around raw-lift failures, forced-`N` mutations, CRT-structured tuples, and seeded deterministic mutations.

## Exact enumeration

For each tuple and each canonical pivot row `(j,r)`, both implementations compute every literal residue `rho_(n*a_j)(r*a_i)`. They classify the bad-coordinate set, enumerate every certificate member `(k,j,r)`, test the closed exceptional-good inequality, and update a SHA-256 digest of the full certificate stream. Stream order is pivot `j`, numerator `r`, deletion `k`.

`impl_a_core.tsv` and `impl_b_core.tsv` are byte-identical. Their fields are:

1. record id
2. family memberships
3. moving dimension `n`
4. tuple
5. primitive flag
6. residual-height flag
7. indices of `(n+1)`-divisible speeds
8. certificate counts by deletion
9. exceptional-good counts by deletion
10. exceptional-good counts by pivot
11. total certificate count
12. total exceptional-good count
13. every deletion nonempty flag
14. any exceptional-good certificate flag
15. empty-row counts by pivot
16. deep-singleton incidence matrix, pivot rows by deleted-coordinate columns
17. shell-singleton incidence matrix
18. SHA-256 of all literal certificate members and residue vectors

## Active-set audit

For the five mandatory tuples and every tuple with zero exceptional-good certificates, both implementations independently enumerate:

- every boundary point of each `K_k`;
- every connected component;
- every maximizing choice for the exceptional coordinate;
- every active survivor at each maximizer;
- every oriented canonical active edge;
- its `n*z+s` numerator, one-sided deleted residue, `b`, `q`, reverse numerator `R`, escape distance, reverse residue vector, and full-witness flag.

`impl_a_active.tsv` and `impl_b_active.tsv` are byte-identical. Fields are record id, deletion index, component count, maximum `eta_k`, all maximizing times, all active-index lists, and all oriented edge records.

## Result files

- `audit_summary.json`: normalized counts and minimum-escape selector census.
- `literal_tables.md`: literal tables for the rejected incidence and divisible-cycle mechanisms.
- `audit_manifest.json`: versions, commands, runtimes, source hashes, output hashes, and agreement checks.
