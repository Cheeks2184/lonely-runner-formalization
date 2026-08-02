# Exact failure of `CHAIN3-UNIF`

## Scope

The primitive nine-speed tuple

```text
F = (8, 15, 35, 40, 48, 56, 75, 132, 147)
```

fails the strict three-deletion-chain sufficient condition at every pivot.
This refutes only `CHAIN3-UNIF`.  It does **not** refute unrestricted additive
ordering (`OPT-ADD-UNIF`) or the Lonely Runner Conjecture.  In fact, the
unrestricted additive optimizer succeeds at pivots `15`, `35`, and `75`, and
`t=13/80` is an explicit lonely time.

The acceptance oracle is `scripts/audit_chain3_counterexample.py`.  It is a
clean-room implementation: it imports no search result, Sol Pro artifact, or
other repository fiber implementation.  It reconstructs every set and weight
by literal residue enumeration and solves every finite optimization by an
exact subset dynamic program.

The speeds are positive and pairwise distinct, and
`gcd(8,15,35,40,48,56,75,132,147)=1`.

## Literal definitions checked

There are `n=9` moving speeds and `N=n+1=10`.  At pivot speed `A`, the modulus
is `M=10A` and the candidate universe is exactly

```text
C_A = {r in {0,...,M-1} : r is not divisible by 10}.
```

Thus `|C_A|=9A`; multiples of `10` are excluded, rather than silently retained
as candidates.  For each nonpivot child speed `d`, the oracle declares `r`
strictly bad precisely when

```text
d*r mod M < A  or  d*r mod M > M-A.
```

The boundary images `A` and `M-A` are good.  The low/high boundary occurrence
counts on the actual candidate grids are

```text
(13,13), (8,8), (12,12), (26,26), (31,31),
(19,19), (23,23), (3,3), (0,0)
```

in increasing pivot order.  Pivot `147` has no actual endpoint occurrence,
but the classifier is also directly checked on both synthetic boundary
arguments.

For every strict bad child target `y`, its token fiber contains all
`r in C_A` with `d*r=y (mod M)`.  A different nonpivot speed `p` has token
weight equal to the literal intersection cardinality of that fiber with
`p`'s strict bad set.  The token potential `W` is the maximum of these parent
weights; the owner is never eligible as its own parent.

Let `S` be the sum of the child bad-set cardinalities and `F*` the sum of all
token potentials.  If `L` is the soft loss of an order, its exact additive
cost is

```text
D = S - F* + L.
```

Consequently the strict additive threshold `D<9A` is equivalent to
`L<beta`, where

```text
beta = 9A - S + F*.
```

## Exact nested-chain calculation

For an unplaced vertex set `Q`, the external deficit of an owner is its total
potential minus the best weight supplied by parents outside `Q`, summed over
its tokens.  Define `g_k(Q)` as the minimum accumulated deficit along an
ordered deletion of `k` distinct members of the same nested chain and

```text
b_k(q) = max_{|Q|=q} g_{min(k,q)}(Q).
```

There are eight nonpivot vertices, so the audited three-step bound is exactly

```text
B3 = b3(8) + b3(5) + b2(2).
```

The three displayed components below are independently maximized over all
subsets of the indicated cardinality:

| pivot | `b3(8)` | `b3(5)` | `b2(2)` | `B3` |
|---:|---:|---:|---:|---:|
| 8 | 4 | 4 | 2 | 10 |
| 15 | 15 | 3 | 2 | 20 |
| 35 | 30 | 16 | 14 | 60 |
| 40 | 22 | 14 | 8 | 44 |
| 48 | 38 | 18 | 8 | 64 |
| 56 | 32 | 18 | 14 | 64 |
| 75 | 77 | 32 | 24 | 133 |
| 132 | 94 | 38 | 28 | 160 |
| 147 | 133 | 62 | 30 | 225 |

The full all-pivot table agrees exactly with Sol Pro Response 37:

| `A` | `S` | `F*` | `beta` | `B1` | `B2` | `B3` | soft optimum | `Dopt` | `9A` |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| 8 | 104 | 40 | 8 | 10 | 8 | 10 | 8 | 72 | 72 |
| 15 | 237 | 121 | 19 | 23 | 21 | 20 | 15 | 131 | 135 |
| 35 | 503 | 242 | 54 | 63 | 62 | 60 | 38 | 299 | 315 |
| 40 | 554 | 222 | 28 | 50 | 44 | 44 | 34 | 366 | 360 |
| 48 | 706 | 288 | 14 | 74 | 62 | 64 | 44 | 462 | 432 |
| 56 | 812 | 348 | 40 | 82 | 64 | 64 | 58 | 522 | 504 |
| 75 | 1057 | 515 | 133 | 149 | 139 | 133 | 93 | 635 | 675 |
| 132 | 1880 | 756 | 64 | 172 | 162 | 160 | 118 | 1242 | 1188 |
| 147 | 2115 | 945 | 153 | 256 | 227 | 225 | 180 | 1350 | 1323 |

Every row has `B3>=beta`.  Equality at pivot `75` still fails because the
sufficient condition requires the strict inequality `B3<beta`.

The exact soft optimum is separately obtained by deleting all eight vertices
in one dynamic program.  At pivot `15`, the deterministic lexicographically
least optimal order and its direct additive insertion costs are

```text
order = (40, 75, 48, 35, 132, 8, 56, 147)
costs = (25, 50, 14, 8, 12, 10, 8, 4)
sum   = 131 < 135.
```

This is an explicit separation: failure of `CHAIN3-UNIF` does not imply
failure of unrestricted optimized additive ordering.

## Direct lonely time

At pivot `A=8`, residue `r=13` is in the candidate universe because it is not
divisible by `10`.  It represents `t=13/80`.  The exact circular-distance
numerators modulo `80`, in speed order, are

```text
(24, 35, 25, 40, 16, 8, 15, 36, 9).
```

Every numerator is at least `8`, so every circular distance is at least
`8/80=1/10`.  The speed `56` attains the allowed boundary exactly.  This
directly confirms that `F` is not a Lonely Runner counterexample.

## Reproduction

From the repository root under WSL:

```bash
python3 scripts/audit_chain3_counterexample.py
PYTHONPATH=scripts python3 -m unittest -v tests.test_chain3_counterexample
```

For the audited files in this commit, the SHA-256 digests are

```text
scripts/audit_chain3_counterexample.py
  133b4aad0552ca47298677beb1ff2e82532a27aba17b04e99f4983acc6153384
tests/test_chain3_counterexample.py
  3a57e8b540ed130d41ed0f52365092ea04125d3f0a3e3b803103f45bf7a8720b
```

The regression suite asserts the complete table, the exact three-block
decomposition, the unique equality pivot, the pivot-`15` order and costs,
candidate exclusion, endpoint conventions, primitiveness, distinctness, and
the direct lonely time.
