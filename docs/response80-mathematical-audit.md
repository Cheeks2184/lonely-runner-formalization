# Response80 mathematical audit

Audit task: `VER-P80-MATHEMATICAL-AUDIT-236`

Base: `22cef48fcb40194222e1fcc79a3b4632ccefac10`

## Scope and evidence boundary

This audit uses only the frozen definitions in Response80 and fresh exact
arithmetic. It did not execute, import, inspect, or rely on any recovered
attachment or output. The response-authored bounded searches, mutation
counts, dual execution, manifests, hashes, timings, and infinite-family
claims remain **unverified**.

Claims proved below receive `proved-math-qualified`: the arguments are
self-contained mathematical derivations, not Lean formalizations. The exact
structural lemma is labelled `rejected` only after checking every antecedent
and all six exceptional subsets.

## Frozen definitions and quantifiers

Let `a` be a positive injective tuple of length `n`, and put `N=n+1`. Define

```text
rho_M(x) = min(x mod M, M-(x mod M)).
```

For deletion index `k`, surviving pivot `j != k`, and
`0 <= r < n*a_j`, `DelCert(a;k,j,r)` means

```text
n does not divide r,
rho_(n*a_j)(r*a_i) >= a_j for every i != k.
```

The pivot coordinate `i=j` is included. Certificates are ordered by the
lexicographic key `(a_j,j,r)`; injectivity makes the first key unambiguous.
The least certificate is canonical. If it is `(j_k,r_k)`, its lift succeeds
when

```text
N*rho_(n*a_(j_k))(r_k*a_k) >= n*a_(j_k).
```

Equality is safe; canonical failure is the strict reverse inequality.

For a nonempty proper exceptional index set `S`, let its nonempty complement
be `T` and set

```text
d = gcd(a_i : i in T),
g_k = gcd(d,a_k),
q_k = d/g_k,
cap_N(d,a_k) = g_k*ceil(2*q_k/N).
```

It is a strict divisor block exactly when

```text
sum_(k in S) cap_N(d,a_k) < d.
```

All subsets are index-labelled; for reporting below they are ordered first by
cardinality and then lexicographically. Equality in the capacity sum is not a
block.

## Exact counterexample `(1,3,16)`

Take `a=(1,3,16)`, so `n=3` and `N=4`. The tuple is positive and strictly
increasing, hence injective. It is primitive because its gcd is one. It also
lies in the stated hard branch:

```text
max(a)=16 > 4+floor(4/3)=5,
4 divides 16.
```

### All deletion certificates and canonical ordering

I independently enumerated every permitted `(j,r)` in increasing pivot-speed,
pivot-index, numerator order and checked every survivor coordinate, including
the pivot. The exact results are:

| Deleted speed | Number of certificates | Canonical `(p,j,r)` | Modulus | Distances in tuple order | Lift failure |
| ---: | ---: | --- | ---: | --- | ---: |
| 1 | 12 | `(3,1,2)` | 9 | `(2,3,4)` | `4*2=8 < 9` |
| 3 | 14 | `(1,0,1)` | 3 | `(1,0,1)` | `4*0=0 < 3` |
| 16 | 2 | `(3,1,4)` | 9 | `(4,3,1)` | `4*1=4 < 9` |

The canonical minima can also be seen without the counts:

- after deleting `1`, pivot `3`, numerator `1` fails on survivor `16`, while
  numerator `2` works;
- after deleting `3`, pivot `1`, numerator `1` is the first allowed row; and
- after deleting `16`, pivot `1` is impossible because survivor `3` is zero
  modulo `3`; at pivot `3`, numerators `1` and `2` fail on survivor `1`, and
  numerator `4` works.

Thus every deletion has a certificate and every frozen canonical lift fails
strictly. No post-inspection choice of a different certificate is part of the
canonical premise.

### All six nonempty proper exceptional sets

Direct substitution in the capacity definition gives:

| `S` by speeds | `T` by speeds | `d` | Capacity terms | Sum versus `d` |
| --- | --- | ---: | --- | --- |
| `{1}` | `{3,16}` | 1 | `1` | `1=d` |
| `{3}` | `{1,16}` | 1 | `1` | `1=d` |
| `{16}` | `{1,3}` | 1 | `1` | `1=d` |
| `{1,3}` | `{16}` | 16 | `8+8` | `16=d` |
| `{1,16}` | `{3}` | 3 | `2+2` | `4>d` |
| `{3,16}` | `{1}` | 1 | `1+1` | `2>d` |

For example, in the equality row `S={1,3}`, both exceptional speeds are
coprime to `d=16`, so each has `g=1`, `q=16`, and capacity
`ceil(32/4)=8`. None of the six sums is strictly below `d`; hence there is no
strict divisor block.

Every hard canonical-failure premise is therefore true, while the asserted
block conclusion is false. This proves the exact universal statement
`CANONICAL-DELETION-FAILURE-FORCES-DIVISOR-BLOCK` **rejected**.

### This is not an LRC counterexample

At `t=5/11`, the three circle distances are

```text
speed 1: 5/11,
speed 3: 4/11,
speed 16: 3/11.
```

All are strictly greater than `1/4`. The tuple therefore has a full Lonely
Runner witness; it refutes only the proposed structural implication.

## `DIVISOR-BLOCK-WITNESS-LIFT`

### Statement

Let `S` be a strict divisor block, let `T` be its nonempty complement, put
`d=gcd(a_i:i in T)`, and write `a_i=d*b_i` on `T`. If a real `t` satisfies

```text
circleDist(t*b_i) >= 1/(|T|+1)  for every i in T,
```

then some `h in {0,...,d-1}` makes `tau_h=(t+h)/d` a full `1/N` witness for
the original tuple.

### Survivor phases

For `i in T`,

```text
a_i*tau_h = b_i*t+h*b_i = b_i*t (mod 1).
```

Thus every survivor phase and distance is independent of `h`.

### Exceptional orbit and multiplicity

Fix `k in S`. Let `g=gcd(d,a_k)`, `d=g*q`, and `a_k=g*c`; then
`gcd(c,q)=1`. Modulo one,

```text
a_k*tau_h = a_k*t/d + h*c/q.
```

As `h` runs modulo `q`, multiplication by `c` permutes the `q` residue
classes. Hence there are exactly `q` equally spaced phases. The full range
`0<=h<d=g*q` contains `g` complete periods, so every phase occurs with
multiplicity exactly `g`.

### Open bad-arc count

The bad phases form the open circular arc `circleDist(x)<1/N`, of length
`2/N`. If `u` points of a `q`-point equally spaced orbit lie in this arc,
unwrap the arc to an open real interval and order those points. Their first
and last points are separated by at least `(u-1)/q`, while openness gives

```text
(u-1)/q < 2/N.
```

Therefore `u-1 < 2q/N`, and integrality yields

```text
u <= ceil(2q/N).
```

This remains correct when `2q/N` is integral precisely because the arc is
open. A phase at distance exactly `1/N` is safe.

Multiplying by the phase multiplicity, exceptional coordinate `k` excludes
at most

```text
g_k*ceil(2*q_k/N) = cap_N(d,a_k)
```

of the `d` shifts.

### Strict union bound and survivor threshold

The union of all exceptional bad-shift sets has size at most the sum of their
capacities. Strict block capacity makes this sum `<d`, so at least one shift
is excluded by no exceptional coordinate.

Let `m=|T|`. Since `S` is nonempty and `T` is nonempty,
`1<=m<=n-1`; hence

```text
1/(m+1) >= 1/n > 1/(n+1) = 1/N.
```

All survivors are safe at that shift, and all exceptional coordinates are
safe by construction. This proves `DIVISOR-BLOCK-WITNESS-LIFT` at the
`proved-math-qualified` level, including orbit collisions, open-boundary
counting, equality safety, and the survivor threshold.

## Required local fixtures

### Strict local success `(2,4,5)`

Let `T={2,4}`, `S={5}`, so `n=3`, `N=4`, `d=2`, `gcd(2,5)=1`, and `q=2`.
The capacity is `ceil(4/4)=1<2`, so this is a strict block. The divided
survivors are `(1,2)` and at `t=1/3` both have distance `1/3`. The shifts are
`tau_0=1/6` and `tau_1=2/3`. Speed `5` is bad at `tau_0` with distance
`1/6`, but at `tau_1` all three distances equal `1/3`. Thus the surviving
shift gives a full witness.

### Capacity-equality failure `(2,4,6)`

With the same survivor set, `d=2`, but for exceptional speed `6`, `g=2` and
`q=1`. Its capacity is `2*ceil(2/4)=2=d`, not strict. At both
`tau_0=1/6` and `tau_1=2/3`, speed `6` has phase zero, so every shift is
excluded. Capacity equality therefore cannot replace the strict inequality.

### Additional drift controls

- In every `DelCert`, `n` rather than `N` is the modulus factor and excluded
  divisor; the lift comparison uses `N` on the exceptional distance.
- The canonical order is `(speed,index,numerator)`, not numerator-first.
- The pivot coordinate is retained among the survivor inequalities.
- `S` is nonempty and proper, so `T`, `d`, `g_k`, and `q_k` are well-defined.
- Strict bad arcs exclude equality; strict block capacity excludes equality.
- Nonunit exceptional speeds are handled through `g_k`; repeated phases are
  counted `g_k` times rather than deduplicated.

## First failed arrow and final labels

The induction route first fails at

```text
all frozen canonical lifts fail
  -> some nonempty proper exceptional set is a strict divisor block.
```

The tuple `(1,3,16)` satisfies the left side and refutes the right side. If a
strict block were independently available, the local lifting theorem would
complete that branch; it does not produce the missing block.

| Item | Audit label |
| --- | --- |
| Exact tuple premises, canonical rows, capacity table, and full witness | `proved-math-qualified` |
| `CANONICAL-DELETION-FAILURE-FORCES-DIVISOR-BLOCK` | `rejected` |
| `DIVISOR-BLOCK-WITNESS-LIFT` | `proved-math-qualified` |
| Strong-induction route through the structural lemma | `conditional`, blocked |
| Response scans, mutations, infinite family, executions, outputs, manifests, hashes, and timings | `unverified` |
| Unrestricted Lonely Runner Conjecture | `open` |
