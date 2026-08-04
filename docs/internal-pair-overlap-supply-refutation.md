# Internal pair-overlap supply refutation

Task: `VER-P95-INTERNAL-PAIR-OVERLAP-REFUTE-348`

Base commit: `b12887f1c46d58c03999ef5d82517203ea61a91b`

## Disposition

`REFUTED-EXACT` applies only to the proposed
`INTERNAL-PAIR-OVERLAP-SUPPLY` sufficient condition. The generic finite-set
multiplicity inequality survives. This is not a counterexample to Prompt95,
the pivot-certificate conjecture, or the Lonely Runner Conjecture.

## Exact tuple and pivot data

Use

```text
n = 8,
N = n + 1 = 9,
a = (7, 8, 9, 10, 11, 13, 18, 3243240).
```

Write `L=3243240`. The first seven pivots are covered by owner `L`, because
`9*b` divides `L` for every speed `b` among those pivots. The pivot `L` is
uncovered: the canonical candidate

```text
r = 15285851 < 9*L = 29189160
```

has owner distances

```text
(9755683, 5530168, 8373141, 6912710, 6990599, 5608057, 12442878),
```

all at least `L`. Hence the maximum covered pivot has speed `p=18`, and its
maximal internal owner set is

```text
C = {7, 8, 9, 10, 11, 13},
K = |C| = 6.
```

## A literal missed phase

At base residue `x=2`, the exact labelled phase sets in `Fin 9` are

```text
7  : {0,5}
8  : {0,1}
9  : {}
10 : {7,8}
11 : {4,8}
13 : {2,4}.
```

Their union is

```text
{0,1,2,4,5,7,8},
```

so phases `3` and `6` are missing. They correspond to the safe canonical
residues `56` and `110` modulo `9*18=162`. At `r=56`, the owner distances are

```text
(68, 38, 18, 74, 32, 80),
```

all at least `18`. Equality remains safe: owner speed `9` has an empty phase
set at `x=2` because its relevant cyclic distance is exactly the closed
boundary value `rho_18(2)=2=d`, not strictly less than `d`.

Thus the maximal internal owner set does not cover the pivot row. The tuple is
a positive control for the desired no-internal-cover conclusion, not an LRC
counterexample.

## Failure of the proposed strict supply

Let `I` be the sum of the six labelled phase-set cardinalities and `O` the sum
of pairwise intersection cardinalities over unordered labelled owner pairs.
The proposed supply requires, for some admissible base `x`,

```text
K*I < K*N + 2*O.
```

Literal enumeration of every `x` with `0 <= x < 18` and `9` not dividing `x`
gives:

| Bases | `I` | `O` | Required comparison | Result |
| --- | ---: | ---: | --- | --- |
| `1,17` | 19 | 20 | `114 < 94` | false |
| `4,14` | 10 | 2 | `60 < 58` | false |
| every other admissible base | 10 | 3 | `60 < 60` | false by equality |

No admissible base satisfies the strict supply inequality. Therefore the
maximal-internal-set version of `INTERNAL-PAIR-OVERLAP-SUPPLY` is false at its
exact theorem domain.

## What survives

For any finite labelled family of phase sets, with union `U`, total incidence
`I`, unordered-pair overlap `O`, and `K` labels, the generic inequality

```text
K*|U| + 2*O <= K*I
```

is unaffected. It gives a sufficient noncoverage certificate when the reverse
strict comparison holds against the full phase-universe size. This tuple shows
only that the sufficient certificate is not uniformly available: genuine
noncoverage can occur while every base fails that strict comparison.
