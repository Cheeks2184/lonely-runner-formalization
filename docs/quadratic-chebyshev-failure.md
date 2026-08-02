# Failure of the quadratic Chebyshev sufficient condition

## Scope

The primitive tuple

```text
(1,3,5,6,7)
```

has a nonpositive quadratic Chebyshev lower bound at every pivot. This rejects
only the Response 44 sufficient condition

```text
H_0-H_1+alpha_n*H_2>0.
```

It does not reject the full Chebyshev score, the exact pivot-certificate
proposition, or LRC. In fact three full pivot scores are positive and the
tuple has the direct lonely time `7/30`.

## Exact polynomial

Here `n=5`, `N=6`, and the prescribed Chebyshev degree is

```text
r=ceil(sqrt(4)/2*log(120))=5.
```

For `x_k=(5-2k)/3` and

```text
P(k)=(T_5(x_k)-1)/(T_5(5/3)-1),
```

the exact common-denominator values are

```text
P(0,...,4)=(29282,0,-2,-484,-486)/29282.
```

The candidate quadratic coefficients at multiplicities `2,3,4` are

```text
14640/14641, 80/121, 7280/14641,
```

so `alpha_5=7280/14641`.

## All-pivot calculation

The literal bad-multiplicity histograms `D_k` are

```text
pivot 1: (0,3,2,0,0)
pivot 3: (0,15,0,0,0)
pivot 5: (4,13,8,0,0)
pivot 6: (4,18,6,2,0)
pivot 7: (6,15,12,0,2).
```

Thus `(H_0,H_1,H_2)` equals

```text
(5,7,2), (15,15,0), (25,29,8), (30,36,12), (35,47,24).
```

After scaling the quadratic bound by `14641`, its pivot numerators are

```text
(-14722,0,-324,-486,-972).
```

All are nonpositive, and equality is insufficient for the strict score
certificate. By contrast, the exact full-score numerators over denominator
`29282` are

```text
(-4,0,117112,116148,174696),
```

so pivots `5,6,7` have positive full scores.

At pivot `5`, safe numerator `r=7` gives `t=7/30`. The circular distances for
the five speeds are exactly

```text
7/30, 3/10, 1/6, 2/5, 11/30,
```

all at least the closed threshold `1/6`.

## Search provenance

The primary exact Python scanner finds this after 84 primitive shell cases in
the ordering `n=3,4,5`, increasing maximum, then lexicographic tuple. Reproduce
the canonical output with:

```bash
bash scripts/audit_quadratic_chebyshev_failure.sh
```

Its source and output hashes are

```text
66ddc5aafa2f465245e82f163b18f8f016e57fc3b05c65caf3b40a95670e8429
  scripts/search_quadratic_chebyshev_failure.py
fa5f00fd042f71e98207eb40c640a3b1801bd5ed8627c75651f3e66480210532
  certificates/quadratic_chebyshev_failure_expected.txt
```

A separate exact bitset implementation found no failure among 1,899,601
primitive `n=3` tuples or 124,869,277 primitive `n=4` tuples of maximum at
most 240. A third implementation checked 288,879 adversarial,
highly-composite, mutation, and deterministic-random `n=3,4` tuples without a
failure. The optional several-minute replay is

```bash
bash scripts/audit_quadratic_chebyshev_calibration.sh
```

The exhaustive source hash is
`e6c4b79b62163197df8c7a0ed6279108814ad1ccadd324954326ea2643004eea`;
its elapsed-time-normalized output hash is
`5bb7105944b7ef857ad004042cd2521ef202988094c3e5fa905d2691c8b19007`.
The adversarial source/output hashes are
`7504b5bf1e6480b6935e68cd636fd0acc0426e599f0ea23f1f067b684658fd64`
and `52dbd868c5165252b669c0c6fc52c0be3ec8b32d44fabc81f48c6cbbc27c1ec7`.

These finite searches support only the stated calibration. They do not prove
global dimension-minimality of the failure.
