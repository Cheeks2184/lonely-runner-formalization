# Bounded fixed-normalization candidates

This is a candidate-selection sweep for the all-modulus decision engine, not an
all-modulus result. It used the committed fixed checker from `9847215`, whose
`scripts/grid_normalization.py` SHA-256 is
`38bc58b6a53c044998a9b48d4fda8dc4a717fa6936dee9e8cb68935bf690cdb0`.
For every positive result, the same committed module's
`verify_certificate` returned true.

## Exact bounded domain and aggregate outcome

For `N=7`, the 65 tuples were `sorted(set((2,3,4,7,14,v)))`, for every
`v=1..70` except `2,3,4,7,14`; each has exactly six distinct positive speeds.
The other two cases were

```text
N=11: (2,3,4,5,6,7,8,90,11,22)
N=13: (2,3,4,5,6,7,8,9,10,132,13,26).
```

Each case examined every unit `c=1..M-1`, in increasing order, for each
`M=2..150` in increasing order: 6,857 possible pairs per full miss. The sweep
contained 67 cases and executed 238,286 fixed `(M,c)` checks: 39 first hits and
28 bounded misses. Every hit was branch R.

The positive table records the first hit; `v` abbreviates the corresponding
`N=7` core-plus tuple. All entries have `mode=R` and affine witnesses.

| `v` | minimal `(M,c)` | original time |
| --- | --- | --- |
| 1, 45, 59, 62, 63, 67-70 | (66, 1) | 1/6 |
| 5 | (123, 1) | 7/41 |
| 15, 37, 44, 49, 55, 58, 65, 66 | (51, 7) | 5/51 |
| 21, 22, 28, 29, 36, 43, 46-48, 52-54, 57, 64 | (50, 7) | 3/25 |
| 35 | (99, 14) | 4/33 |
| 42 | (99, 14) | 10/99 |
| 50 | (71, 1) | 12/71 |
| 51 | (72, 1) | 1/6 |
| 56 | (70, 1) | 3/5 |
| 60 | (67, 1) | 11/67 |
| 61 | (68, 1) | 3/17 |

The `N=7` bounded misses, each after all 6,857 pairs, are

```text
v = 6, 8-13, 16-20, 23-27, 30-34, 38-41.
```

Both escaping-family cases (`N=11` and `N=13`) are also bounded misses after
all 6,857 pairs. Eight prioritized inputs for the decision engine are the
`N=11` and `N=13` escaping-family tuples, followed by the `N=7` tuples at
`v=6,8,9,10,11,30`. The last is intentionally a cutoff control: the prior
fixed certificate for `N=7, V=(2,3,4,7,14,30)` occurs at `(M,c)=(257,35)`,
outside this range. It demonstrates why this list is not obstruction evidence.

## Standard-library reproducer

First materialize the pinned source with
`git show 9847215:scripts/grid_normalization.py >/tmp/grid984.py`, then run:

```python
import importlib.util
from math import gcd

spec = importlib.util.spec_from_file_location("g", "/tmp/grid984.py")
g = importlib.util.module_from_spec(spec); spec.loader.exec_module(g)

def sweep(N, V):
    checks = 0
    for M in range(2, 151):
        for c in range(1, M):
            if gcd(c, M) != 1:
                continue
            checks += 1
            cert = g.find_fixed_normalization(N, V, M, c)
            if cert is not None:
                assert g.verify_certificate(cert)
                a = cert["affine"]
                return checks, M, c, cert["mode"], (a["time_num"], a["time_den"])
    return checks, None

cases = [(7, tuple(sorted({2,3,4,7,14,v})))
         for v in range(1,71) if v not in {2,3,4,7,14}]
cases += [(N, tuple(range(2,N-2)) + ((N-2)*(N-1),N,2*N)) for N in (11,13)]
results = [(N, V, sweep(N, V)) for N, V in cases]
```

The remaining limitation is fundamental to this sweep: it says nothing about
moduli above 150, and therefore neither a listed miss nor the finite aggregate
can establish failure of any A/B/R predicate over all moduli.
