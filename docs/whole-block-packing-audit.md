# Exact whole-block capacity packing audit

## Scope and status

This audit implements the fixed-pivot whole-block capacity relaxation exactly
where the pure-Python branch-and-bound completes, and supplies replayed
feasible lower bounds plus literal union-debt upper bounds on every pivot of

```text
F = (8,15,35,40,48,56,75,132,147),
G = (15,21,40,48,56,105,126,280,1200).
```

It determines rigorously that `G` is rescued by the relaxation: pivot `56`
has a replayed packing of credit `400>392`, with additional witnesses at
pivots `105` and `1200`.  It does not claim exact maxima on the rows explicitly
marked as intervals below.  No uniform or Lonely Runner conclusion follows.

## Integer packing model

For each strict child/target token `e` and eligible parent `p`, let

```text
Q(e,p) = filtered whole target fiber of e intersect B_p.
```

Choose binary variables `y(e,p)` subject to

```text
sum_p y(e,p) <= 1,
sum_(e,p : r in Q(e,p)) y(e,p) <= mu(r)-1,
```

where `mu(r)` is the number of nonpivot bad sets containing candidate `r`.
The objective is

```text
maximize sum_(e,p) |Q(e,p)| y(e,p).
```

Writing `S` for the total bad multiplicity and `R` for the candidate universe,
a strict fixed-pivot certificate requires packing credit greater than
`S-|R|`.  The exact overlap debt

```text
S-|union B_i| = sum_r (mu(r)-1)
```

is always a safe upper bound on packing credit.

## Exact solver and safe pruning

`scripts/audit_whole_block_packing.py` reconstructs all candidates, strict bad
sets, fibers, and blocks literally.  Its exact solver uses only the following
equivalence-preserving reductions and upper bounds:

1. A residue constraint is removed only if its token degree is at most its
   capacity, so it can never bind.
2. Choices with the same remaining binding-residue signature are merged by
   keeping the largest whole-block weight; removed constraints cannot be
   violated later.
3. The token/binding-residue graph is split into independent connected
   components.
4. At a search node, future credit is bounded both by the sum of each
   remaining token's largest feasible choice and by residual binding capacity
   plus maximum nonbinding weight.
5. A nonnegative integer-grid dual gives another safe bound.  For scale `q`,
   any prices `z_r>=0` yield

   ```text
   sum_r cap(r) z_r
     + sum_e max_p (q*|Q(e,p)| - sum_(r in Q(e,p)) z_r).
   ```

   Dividing by `q` is a valid LP-dual upper bound; flooring is safe because the
   primal objective is integral.  Coordinate descent improves the chosen
   prices but is never assumed optimal.
6. Memoization prunes a repeated residual-capacity state only after that state
   has already been reached with at least as much credit.

Every returned selection is replayed against the original uncompressed whole
blocks and capacities.  Deterministic greedy seeds affect only runtime, never
the proof of optimality.

## Completed exact rows

`need` is `S-|R|`, `opt` is the proved integer optimum, and `debt` is the
literal union-debt upper bound.

| tuple | pivot | `need` | `opt` | `debt` | strict success? |
|---|---:|---:|---:|---:|---|
| F | 8 | 32 | 34 | 36 | yes |
| G | 15 | 155 | 155 | 155 | no, equality |
| G | 21 | 167 | 142 | 177 | no |
| G | 40 | 420 | 420 | 420 | no, equality |
| G | 48 | 424 | 412 | 440 | no |
| G | 126 | 688 | 654 | 844 | no |

The F pivot-`8` optimum confirms that the previously audited explicit credit
`34` is maximum.  For G, the exact pivot-`48` failure is notable because the
literal union leaves candidates: whole-block packing is still not the exact
union certificate.

## All-pivot certified intervals

Each interval `[lower,debt]` has a replayed feasible whole-block packing at its
lower endpoint.  Only rows in the exact table above have matching
branch-and-bound proofs of optimality.

| tuple | pivot | `need` | certified interval | strict witness found? |
|---|---:|---:|---:|---|
| F | 8 | 32 | `[34,36]` | yes |
| F | 15 | 102 | `[108,118]` | yes |
| F | 35 | 188 | `[204,222]` | yes |
| F | 40 | 194 | `[199,232]` | yes |
| F | 48 | 274 | `[254,314]` | not in bounded search |
| F | 56 | 308 | `[299,368]` | not in bounded search |
| F | 75 | 382 | `[436,464]` | yes |
| F | 132 | 692 | `[662,820]` | not in bounded search |
| F | 147 | 792 | `[793,936]` | yes |
| G | 15 | 155 | `[155,155]` | no |
| G | 21 | 167 | `[142,177]` | no |
| G | 40 | 420 | `[420,420]` | no |
| G | 48 | 424 | `[412,440]` | no |
| G | 56 | 392 | `[400,440]` | **yes** |
| G | 105 | 465 | `[472,607]` | **yes** |
| G | 126 | 688 | `[642,844]` | not in bounded search |
| G | 280 | 1270 | `[1230,1652]` | not in bounded search |
| G | 1200 | 6432 | `[6630,7950]` | **yes** |

“Not in bounded search” is deliberately not reported as failure: the lower
bound is insufficient and the upper bound remains above the threshold.

## Fixed stress-set search

A deterministic 64-round feasible-packing search was run on the nine named
prior stress tuples.  It found and replayed a strict pivot witness for each:

| case | pivot | credit | need |
|---|---:|---:|---:|
| RF | 3 | 17 | 15 |
| GCD1 | 8 | 40 | 36 |
| GCD2 | 6 | 36 | 34 |
| hardA | 7 | 32 | 26 |
| hardB | 7 | 32 | 26 |
| small `(1,2,3,5)` | 3 | 2 | 0 |
| D | 10 | 50 | 44 |
| C | 15 | 106 | 105 |
| E | 28 | 119 | 108 |

Together with F and G, this is a fixed collection of eleven documented tuples,
not a metric neighborhood or exhaustive speed box.  No all-pivot packing
failure occurs in this collection.  The search makes no statement beyond
these named inputs and deterministic round count.

## Reproduction

```bash
python3 scripts/audit_whole_block_packing.py
PYTHONPATH=scripts python3 -m unittest -v tests.test_whole_block_packing
```

The default command intentionally runs only the completed exact rows, all
replayed F/G intervals, and the fixed stress set.  It does not launch the
known CPU-heavy unresolved exact rows.
