# Exact failure of `OPT-ADD-UNIF`

## Scope

The primitive nine-speed tuple

```text
G = (15, 21, 40, 48, 56, 105, 126, 280, 1200)
```

fails the strict unrestricted optimized additive sufficient condition at
every pivot.  This refutes `OPT-ADD-UNIF`, not the exact pivot certificate and
not the Lonely Runner Conjecture.  Indeed, `t=13/160` is a directly verified
lonely time for `G`.

The acceptance oracle is `scripts/audit_opt_add_counterexample.py`.  It is a
clean-room implementation: it imports no Sol Pro artifact, search program, or
other repository fiber implementation.  It reconstructs candidates, strict
bad sets, fibers, and all parent intersection weights by literal residue
enumeration.

The speeds are positive and pairwise distinct, and

```text
gcd(15,21,40,48,56,105,126,280,1200) = 1.
```

## Strict modular conventions

There are `n=9` speeds and `N=n+1=10`.  At pivot `A`, the modulus is `M=10A`
and the candidate set is exactly

```text
C_A = {r in {0,...,M-1} : r is not divisible by 10},
```

of cardinality `9A`.  Thus every pivot-forbidden residue is excluded.  A
nonpivot speed `d` is strictly bad at `r` exactly when

```text
d*r mod M < A  or  d*r mod M > M-A.
```

Images equal to `A` or `M-A` are good.  The low/high actual endpoint hit
counts in increasing pivot order are

```text
(18,18), (0,0), (58,58), (17,17), (21,21),
(36,36), (21,21), (136,136), (48,48).
```

The classifier is also checked directly on both endpoints, including the
pivot-`21` row where neither endpoint occurs on an actual nonpivot image.

For every strict bad child target, the oracle reconstructs the whole filtered
target fiber.  Its weight for a distinct nonpivot parent is the literal
intersection cardinality with that parent's strict bad set.  Self-parents are
excluded.  Given an order, each fiber receives the maximum weight among
earlier parents.

## Exact all-pivot table

Let `S` be the sum of child bad-set sizes, `F*` the sum of maximum token
weights, and `Lopt` the exact minimum soft loss.  The optimized additive cost
is checked through the identity

```text
Dopt = S - F* + Lopt.
```

The independently reconstructed values agree exactly with Sol Pro Response
38:

| pivot `A` | `S` | `F*` | `Lopt` | `Dopt` | `9A` |
|---:|---:|---:|---:|---:|---:|
| 15 | 290 | 182 | 27 | 135 | 135 |
| 21 | 356 | 164 | 28 | 220 | 189 |
| 40 | 780 | 492 | 72 | 360 | 360 |
| 48 | 856 | 448 | 56 | 464 | 432 |
| 56 | 896 | 442 | 52 | 506 | 504 |
| 105 | 1410 | 529 | 66 | 947 | 945 |
| 126 | 1822 | 728 | 102 | 1196 | 1134 |
| 280 | 3790 | 1376 | 154 | 2568 | 2520 |
| 1200 | 17232 | 7636 | 1228 | 10824 | 10800 |

Thus `Dopt>=9A` at all nine pivots.  Equality at pivots `15` and `40` is still
failure because the sufficient condition requires the strict inequality
`Dopt<9A`.

For each pivot, the oracle first minimizes over the `2^8` predecessor states.
It then independently enumerates all `8!=40,320` nonpivot orders, accumulating
the literal insertion costs, and obtains the same optimum and the same
lexicographically least optimal order.  In total, the exhaustive cross-check
evaluates `9*40,320=362,880` complete orders.

## Direct lonely time

At pivot `A=48`, residue `r=39` is a valid candidate because it is not
divisible by `10`.  It gives

```text
t = 39/480 = 13/160.
```

The exact circular-distance numerators modulo `480`, in speed order, are

```text
(105, 141, 120, 48, 216, 225, 114, 120, 240).
```

Every numerator is at least `48`, so every circular distance is at least
`48/480=1/10`.  The speed `48` attains the allowed boundary exactly.  This
proves directly that `G` is not a Lonely Runner counterexample and also shows
why failure of the additive sufficient condition cannot be promoted to
failure of the exact union/pivot certificate.

## Reproduction

```bash
python3 scripts/audit_opt_add_counterexample.py
PYTHONPATH=scripts python3 -m unittest -v tests.test_opt_add_counterexample
```

The regression asserts every table entry, all `40,320` orders per pivot, the
two equality pivots, candidate counts, strict endpoints, primitiveness and
distinctness, and the explicit lonely time.  Any separate claim about how Sol
Pro's search reached `G` or about local minimality is outside this acceptance
audit and has not been used.
