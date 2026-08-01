# Exact integer induction cover

This note records the strongest verified synthesis of the current induction,
divisor, structured-class, and modular-pivot machinery. It is a reduction of
the remaining positive-integer problem, not a proof of the Lonely Runner
Conjecture.

## Four sound branches

Let `old : Fin n -> N` be pairwise distinct positive speeds, let `new > 0`,
and put

```text
full = Fin.lastCases new old : Fin (n+1) -> N.
```

Assume the positive-integer theorem in moving dimension `n`. A witness for
`full` at threshold `1/(n+2)` follows from any one of these conditions:

1. **Fast insertion:** `(n+1) * old i <= new` for every `i`.
2. **Divisor insertion:** there are `divided`, `D=g*m`, and `new=g*c` such
   that `old i=D*divided i`, `g,m>0`, `gcd(c,m)=1`, and
   `2m <= (n+2)(m-1)`.
3. **Minimum-scale bands:** the full tuple satisfies the closed residue-band
   inequalities from `minimumScaleResidueBands` for some positive base.
4. **Pivot noncoverage:** some candidate residue in some pivot grid avoids
   every non-pivot strict bad set.

`exists_appended_witness_of_integerInsertionCover` in
`LonelyRunner/IntegerInduction.lean` proves this four-way statement in Lean.
The first two branches invoke the induction hypothesis; the last two give a
full-tuple witness directly.

## The exact covering dichotomy

For a pivot `j`, write `R_j` for `pivotCandidates (n+2) a_j` and `B_ij` for
the corresponding strict bad set. Define total pivot coverage by

```text
forall j r, r in R_j -> exists i != j, r in B_ij.
```

The sharp induction target is:

> For every appended positive injective tuple, either the divisor-insertion
> data above exist, or total pivot coverage is false.

The second alternative is literally the existence of an uncovered pivot
candidate. Lean proves

```text
PivotInsertionCase old new
  <-> not AllPivotCandidatesCovered old new
```

and then proves both

```text
DivisorOrUncoveredPivotPrinciple -> PositiveIntegerConjecture
```

and

```text
PositiveIntegerConjecture <-> DivisorOrUncoveredPivotPrinciple.
```

Thus this dichotomy would make induction complete, but it is not a reduction
in logical strength: pivot-grid completeness makes it an exact reformulation
of the remaining integer conjecture. Any successful induction proof must add
new arithmetic content showing why full pivot coverage forces a usable
divisor orbit, or must prove noncoverage by another uniform mechanism.

For a primitive tuple with at least three moving speeds, a deletion gcd
`D_j >= 2` gives reduced orbit size `m=D_j` and satisfies the mesh inequality.
The fixed appended-family implication is kernel-checked as
`divisorInsertionCase_of_coprime_commonDivisor_two_le`.
Consequently a minimal primitive counterexample would have every deletion gcd
equal to one and every pivot grid completely covered. This is the precise
residual obstruction; neither condition is currently ruled out uniformly.

## Exact finite audit and counterexamples to simpler covers

The reproducible script `scripts/search_induction_cover.py` enumerates
primitive increasing tuples. It applies fast insertion, bands, and the
divisor arithmetic condition in that order, then computes exact pivot unions.
For maximum speed 15 it reports:

| moving speeds | primitive tuples | structural residual | all deletion gcds one | exact pivot certified | all pivots covered |
|---:|---:|---:|---:|---:|---:|
| 3 | 409 | 48 | 48 | 48 | 0 |
| 4 | 1,325 | 364 | 364 | 364 | 0 |
| 5 | 2,981 | 872 | 872 | 872 | 0 |
| 6 | 4,998 | 2,144 | 2,144 | 2,144 | 0 |
| 7 | 6,434 | 2,067 | 2,067 | 2,067 | 0 |
| 8 | 6,435 | 1,716 | 1,716 | 1,716 | 0 |

The first failure of the three structural branches is `(1,3,4)`:

- `4 < 3*3`, so fast insertion fails;
- normalized speed `4` lies in the first forbidden band gap `(3,5)`;
- its deletion gcds are `(1,1,1)`, so divisor insertion has no nontrivial
  reduced orbit.

It nevertheless has the pivot-grid witness `t=5/12`. Hence fast insertion,
minimum-scale bands, and divisor insertion do not form an exhaustive
induction by themselves.

Simplifying the pivot branch also fails quickly. The first structural residual
not certified by the sum of individual bad-set cardinalities is `(1,4,5)`.
One-parent overlap bounds first fail at `(1,5,6,7,13)`, and two-parent bounds
first fail in the audited speed-15 box at
`(1,2,5,7,9,11,12,13)`. Those are certificate failures, not LRC
counterexamples; exact pivot unions still leave witnesses.

The reported `all_pivot_covered=0` counts do not test the proposed implication
from total pivot coverage to a deletion divisor in any nonvacuous instance.
They only confirm that no LRC counterexample occurs in these finite boxes.

Reproduce representative audits with:

```sh
python3 scripts/search_induction_cover.py --runners 3 --max-speed 15 --parent-capacity 1
python3 scripts/search_induction_cover.py --runners 8 --max-speed 15 --parent-capacity 2
python3 -m unittest discover -s tests -v
```

## Remaining obligation

The exact open arithmetic statement is to exclude a positive injective tuple
for which no divisor-insertion factorization is available and every pivot
candidate is covered. Existing bad-set cardinalities, fixed-capacity overlap
certificates, and deletion-gcd computations do not establish this. Because
the dichotomy is equivalent to `PositiveIntegerConjecture`, it must not be
recorded as a proved lemma without genuinely new uniform number theory or
additive combinatorics.
