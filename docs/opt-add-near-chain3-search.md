# Exact OPT-ADD search near the CHAIN3 counterexample

## Scope

This audit searches finite neighborhoods of

```text
F = (8, 15, 35, 40, 48, 56, 75, 132, 147)
```

for a tuple failing unrestricted optimized additive ordering at every pivot.
It finds none.  These are exhaustive statements only for the five domains
defined below; they imply neither `OPT-ADD-UNIF` nor the Lonely Runner
Conjecture.

The exact objective of a tuple is

```text
max_A (n*A - Dopt(A)),
```

where `Dopt(A)` is the unrestricted additive subset-DP optimum at pivot `A`.
An all-pivot failure requires this objective to be nonpositive.  A positive
objective supplies at least one strict pivot certificate.

## Exact domains and results

All proposed tuples are sorted, required to remain positive and distinct,
normalized by their gcd, deduplicated, and then filtered to primitive tuples.
The strict modular oracle uses modulus `(n+1)A`, excludes candidate residues
divisible by `n+1`, and treats images equal to `A` or `(n+1)A-A` as good.

| domain | generated | distinct valid | primitive | minimum objective |
|---|---:|---:|---:|---:|
| replace exactly one coordinate by any unused value in `[1,300]` | 2,619 | 2,619 | 2,619 | `+16` |
| perturb exactly two coordinates by nonzero offsets in `[-5,5]` | 3,600 | 3,428 | 3,428 | `+18` |
| perturb exactly three coordinates by nonzero offsets in `[-2,2]` | 5,376 | 5,376 | 5,376 | `+32` |
| adjoin one unused speed from `[1,300]` | 291 | 291 | 291 | `+62` |
| delete exactly one speed | 9 | 9 | 9 | `+92` |

The closest tuple and its descending all-pivot surplus profile in each domain
are:

```text
single:
  (7,8,15,35,40,48,56,132,147)
  (16,8,5,4,4,4,0,-14,-65)

two-coordinate:
  (5,15,35,40,48,56,77,132,147)
  (18,18,16,12,2,-12,-36,-88,-99)

three-coordinate:
  (10,15,35,42,48,56,77,132,147)
  (32,26,14,11,10,-6,-34,-35,-60)

one-speed extension:
  (8,15,22,35,40,48,56,75,132,147)
  (62,46,40,22,14,14,12,8,6,-10)

one-speed deletion:
  (8,15,35,40,48,56,75,132)
  (92,60,48,28,26,26,18,10)
```

Thus the closest exact domain remains separated from all-pivot failure by a
positive margin of `16`.  Equality at a nonbest pivot, such as surplus `0`
for the closest single-coordinate tuple at pivot `48`, is not an all-pivot
failure because several other pivots are strict.

## Search correctness and exhaustiveness

`scripts/search_opt_add_near_chain3.js` imports only the exact literal
residue/fiber optimizer from `scripts/search_opt_add_failures.js`.  The latter
now exposes its pure scoring functions while retaining the original command
line behavior.

Within each listed generator, every distinct valid primitive tuple is
considered.  A candidate may be pruned after a pivot surplus exceeds the
current best objective: its maximum surplus is then already too large to
improve the incumbent, and in particular is positive, so it cannot be an
all-pivot failure.  Every surviving incumbent is rescored at all pivots.
This establishes both the absence of a failure and the displayed minimum
objective in each finite domain.

No random or heuristic sample is included in the table.  The words “near” and
“small extension” refer exactly to the enumerated coordinate/range rules, not
to an unreported metric ball or an unbounded claim.

## Reproduction

The fixed audit runs all five domains and checks their counts, closest tuples,
profiles, and objectives:

```bash
node scripts/search_opt_add_near_chain3.js --mode audit
python3 -m unittest -v tests.test_opt_add_near_chain3
```

Individual parameterized runs are also available:

```bash
node scripts/search_opt_add_near_chain3.js --mode single --maximum 300
node scripts/search_opt_add_near_chain3.js --mode pair --radius 5
node scripts/search_opt_add_near_chain3.js --mode triple --radius 2
node scripts/search_opt_add_near_chain3.js --mode extend --maximum 300
node scripts/search_opt_add_near_chain3.js --mode delete
```

The JSON output includes the complete pivot rows and optimizing orders for
each closest tuple, providing directly replayable strict pivot certificates.
