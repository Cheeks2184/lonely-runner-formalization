# Response82 mathematical audit

Audit task: `VER-P82-MATHEMATICAL-AUDIT-231`
Base: `9a5ebc29ce91531d674a51908c4fcbedfd0aab6b`

## Scope and evidence boundary

This audit derives the stated counterexample directly from the frozen score
definitions. It did not execute, import, inspect, or use any recovered
attachment, output, manifest, timing, source hash, dual-execution claim,
permutation claim, or bounded-search count. Those response-authored
computations remain **unverified**.

The results explicitly derived below are `proved-math-qualified`: exact
finite arithmetic is shown from the definitions, but this document is not a
Lean formalization. In particular, it rejects one exact invariant only; it
does not establish a counterexample to Lonely Runner.

## Definitions audited

For a positive injective tuple `a` of length `n=7`, put `N=8`. At pivot `j`,
write `p=a_j`, `M=8p`, and define

```text
R_j = { r : 0 <= r < M and 8 does not divide r },
rho_M(x) = min(x mod M, M - (x mod M)),
B_i^j = { r in R_j : rho_M(r*a_i) < p }       (i != j),
mu_j(r) = #{ i != j : r in B_i^j },
phi_8(m) = (1-m)/(8m+1),
S_j(a) = sum_(r in R_j) phi_8(mu_j(r)),
S_8(a) = sum_j S_j(a).
```

The inequality is strict: distance `p-1` is bad and distance `p` is safe.
Owners are indices, so coincident bad sets are not collapsed. Since precisely
the `p` multiples of eight are excluded from `0,...,8p-1`, `|R_j|=7p`.

## Exact tuple audit

Take

```text
a = (1,4,5,6,7,11,32).
```

All entries are positive and strictly increasing, hence injective. Its gcd is
one because it contains `1`, so it is primitive.

For each pivot, I enumerated the finite set `R_j` in increasing `r` order,
computed each of the six centred distances using the displayed definition,
counted strict owner incidences, and summed the rational values of `phi_8` by
multiplicity. This is the literal reproducible calculation:

```text
for p in (1,4,5,6,7,11,32):
  h[0..6] = 0
  for r = 0,...,8*p-1:
    if 8 divides r: continue
    m = #{ x in a \ {p} : min((r*x) mod (8*p), 8*p-(r*x mod (8*p))) < p }
    h[m] += 1
  S_p = sum_m h[m]*(1-m)/(8*m+1)
```

All additions and reductions are integer numerator/denominator arithmetic;
no floating-point operation is involved. The resulting independent histogram
and local-score table is:

| Pivot `p` | `M` | histogram `(h_0,...,h_6)` | `S_p` |
| ---: | ---: | --- | ---: |
| 1 | 8 | `(0,4,2,1,0,0,0)` | `-84/425` |
| 4 | 32 | `(0,8,12,8,0,0,0)` | `-572/425` |
| 5 | 40 | `(0,22,10,3,0,0,0)` | `-352/425` |
| 6 | 48 | `(0,26,10,6,0,0,0)` | `-454/425` |
| 7 | 56 | `(2,34,8,3,2,0,0)` | `5178/4675` |
| 11 | 88 | `(2,50,18,5,0,2,0)` | `1206/3485` |
| 32 | 256 | `(4,150,46,14,2,4,4)` | `-7571024/9392075` |

Each histogram sums to `7p`; altogether the sum is
`7*(1+4+5+6+7+11+32)=462`. Summing the seven displayed reduced fractions
gives, after exact common-denominator reduction,

```text
S_8(a) = -5245398/1878415 < 0.
```

This exact value and the seven histograms are independently derived here.

## Boundary and definition-drift checks

These direct controls ensure that the calculation did not weaken or relabel
the definition.

- At pivot `p=7`, `M=56`, candidate `r=6`, owner speed `1` has distance
  `6=p-1`, so it is bad. Candidate `r=7` has distance `7=p`, so it is safe.
  Neither candidate is an excluded multiple of eight.
- At the same pivot and `r=17`, nonunit owner `4` has
  `gcd(4,56)=4` and centred distance `12`; it remains in the owner scan and
  is safe, rather than being discarded as a nonunit.
- At pivot `p=1`, owners `5` and `7` both have the same empty strict bad set
  on `R_j`. They are nevertheless distinct indexed owners in `mu_j`; no
  set-based deduplication is permitted.
- The enumeration includes zero products, both cyclic sides, and all
  non-multiples of eight. It excludes only the stated multiples of eight.

## Pivot certificate and the rejected converse

For pivot speed `7`, take `M=56` and `r=17`. Since `8` does not divide `17`,
it belongs to `R_j`. The centred distances in tuple order are

```text
(17,12,27,10,7,19,16).
```

Every value is at least `7`, including the pivot coordinate (where equality
is safe). Thus this is an exact pivot certificate. Together with the negative
score, it refutes the converse implication “a pivot certificate implies
`S_8(a)>0`.” It does **not** refute Lonely Runner, because the tuple has the
certificate just exhibited.

Consequently the universally quantified invariant

```text
GLOBAL-ALL-PIVOT-SATURATED-MULTIPLICITY-AVERAGE:
for every positive injective primitive tuple a of length at least 2,
S_8(a) > 0
```

is **rejected** by this primitive length-seven counterexample. The conditional
bridge from this invariant to a pivot certificate is blocked at its false
premise. The unrestricted Lonely Runner Conjecture remains **open**.

## Surviving local implications

### Positive score implies a pivot certificate

For `m>=1`, `phi_8(1)=0` and `phi_8(m)<0` for `m>=2`. If every candidate at
every pivot were covered, then every `mu_j(r)>=1`; every summand in `S_8`
would be nonpositive, contradicting `S_8>0`. Hence some `mu_j(r)=0`, so all
nonpivot centred distances are at least the pivot speed.

For the pivot coordinate itself, write `r=8q+s` with `1<=s<=7` (this is
exactly `r in R_j`). Then

```text
rho_(8*a_j)(r*a_j) = a_j*min(s,8-s) >= a_j.
```

Equality at `s=1` or `7` is safe. Thus `S_8(a)>0` implies a pivot certificate.
This is `proved-math-qualified` and does not supply the rejected universal
positivity premise.

### Common scaling

Let `A=c*a` for a positive integer `c`. For a pivot, set `M=8*a_j` and map
each `r' in R_j(A)` to `r=r' mod M`. The fiber above each `r in R_j(a)` is

```text
r, r+M, ..., r+(c-1)*M,
```

and all its elements remain non-multiples of eight; these are all fibers.
For each owner,

```text
rho_(cM)((r+kM)*(c*a_i)) = c*rho_M(r*a_i).
```

Strict badness and equality safety are therefore preserved owner by owner, so
every fiber has the same multiplicity. Hence `S_j(A)=c*S_j(a)` and
`S_8(c*a)=c*S_8(a)`. This is `proved-math-qualified`.

### Generating-function identity

For the finite polynomial `P_a(x)=sum_(j,r) x^(8*mu_j(r))`, termwise
integration and differentiation give

```text
S_8(a) = integral_0^1 (P_a(x) - x*P_a'(x)/8) dx
       = 9/8 * integral_0^1 P_a(x) dx - P_a(1)/8.
```

Indeed each monomial contributes `1/(8m+1)-m/(8m+1)`, which is
`phi_8(m)`. This identity is `proved-math-qualified`; it supplies no universal
positive lower bound and does not alter the rejected invariant.

## Final labels

| Item | Audit label |
| --- | --- |
| Exact tuple arithmetic, histograms, score, and certificate | `proved-math-qualified` |
| `S_8>0` implies pivot certificate; pivot-coordinate safety; common scaling; generating identity | `proved-math-qualified` |
| `GLOBAL-ALL-PIVOT-SATURATED-MULTIPLICITY-AVERAGE` | `rejected` |
| Bridge requiring universal positive score | `conditional`, blocked by rejected invariant |
| Response-authored scans, dual runs, manifests, replay, hashes, timings, and permutations | `unverified` |
| Unrestricted Lonely Runner Conjecture | `open` |
