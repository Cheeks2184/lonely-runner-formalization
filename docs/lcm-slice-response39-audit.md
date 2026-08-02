# Exact audit of Response 39 LCM slices and signed replacement

## Scope

This audit independently reconstructs the common-LCM slice identities,
signed-polynomial bounds, direct low-depth certificates, and divisor
replacement conditions proposed in Sol Pro Response 39.  All arithmetic is
integer or `Fraction` arithmetic.  These are fixed finite calculations and
identities; no uniform or Lonely Runner conclusion follows.

The verifier is `scripts/audit_lcm_slice_bounds.py`.  It imports no Sol Pro
artifact or repository pivot oracle.

## Common-LCM construction

For positive speeds `a_1,...,a_n`, define

```text
ell = lcm(a_1,...,a_n),  N=n+1,  L=N*ell,  q_j=ell/a_j.
```

The pivot-`j` candidate grid embeds into `Z/LZ` by

```text
iota_j(r) = q_j*r mod L.
```

The verifier checks set equality between its image and

```text
C_j = q_j*(Z/LZ) minus N*q_j*(Z/LZ),
```

including injectivity and cardinality `n*a_j`.

For a common slice `s`, let

```text
b_i(s) = 1[rho_L(a_i*s)<ell],
k(s)   = sum_i b_i(s),
d(s)   = number of j with s in C_j,
D_k    = sum_{s:k(s)=k} d(s).
```

Here `rho_L` is circular residue distance and the inequality is strict, so
images exactly equal to `ell` or `L-ell` are good.  The weighted binomial
moments are

```text
H_q = sum_s d(s) * C(k(s),q) = sum_k D_k*C(k,q).
```

Literal pivot enumeration independently verifies

```text
sum_j U_j = sum_s d(s)*1[k(s)=0] = D_0,
```

where `U_j` is the number of globally safe candidates on pivot grid `j`.

## G histogram and safe counts

For

```text
G=(15,21,40,48,56,105,126,280,1200),
```

the verifier obtains `ell=25200`, `L=252000`, and

```text
(D_0,...,D_9)
  = (2272,6134,5610,2208,584,180,7,16,8,0).
```

Thus the nine-value tuple reported by Sol is exactly `(D_0,...,D_8)`; the
omitted terminal value is `D_9=0`.  The moments are

```text
(H_0,...,H_9)
  = (17019,27432,18203,7492,2709,1006,343,80,8,0).
```

The literal per-pivot safe counts, in increasing speed order, are

```text
(0,10,0,16,48,142,156,382,1518),
```

whose sum is `2272=D_0` exactly.

## Signed-polynomial bounds

For depth `d` with `2d<=n-1`, define

```text
P_{n,d}(k)
  = sum_{q=0}^{2d-1} (-1)^q C(k,q)
    + (2d/(n-1))*C(k,2d),

L_{n,d} = sum_k D_k*P_{n,d}(k).
```

The verifier checks both the moment and histogram forms and the pointwise
identity

```text
P_{n,d}(0)=1,
P_{n,d}(k)
  = -((n-1-k)/(n-1))*C(k-1,2d-1) <= 0
```

for `1<=k<=n-1`.  Consequently `D_0>=L_{n,d}`.

For G at the nontrivial low depth `d=2`, the exact value is

```text
L_{9,2} = 3305/2.
```

At maximal depth `d=4`, however, every positive-`k` coefficient vanishes and

```text
L_{9,4}=D_0=2272.
```

This high-depth equality is a reformulation of the safe-count sum, not a new
lower-bound mechanism.  It must be distinguished from positive low-depth
bounds such as `L_{9,2}`.

## Low-depth stress rows

For

```text
T10=(1,2,3,4,5,6,7,8,9,11),
T11=(1,2,3,4,5,6,7,8,9,11,12),
```

the exact rows are

```text
T10: L_{10,2}=-226/9,  L_{10,3}=4;
T11: L_{11,2}=-298/5, L_{11,3}=0, L_{11,4}=22.
```

The direct pivot-`3` candidates are also checked:

```text
T10: r=10 modulo 33,
  distances=(10,13,3,7,16,6,4,14,9,11);

T11: r=11 modulo 36,
  distances=(11,14,3,8,17,6,5,16,9,13,12).
```

Every distance is at least `3`.

For `(1,2,3,4,12)`, both admissible depths resolve the “near-top” ambiguity:

```text
L_{5,1}=0,
L_{5,2}=14=D_0.
```

Thus the reported zero is the nonmaximal depth `d=1`; the maximal-depth value
is again the tautological safe-count identity.  Pivot `3`, residue `7` modulo
`18`, has distance numerators `(7,4,3,8,6)` and is a direct safe candidate.

## Signed divisor replacement

The verifier exhausts the stated conditions.  Replacing `a_k` by `b` requires

```text
0<b<a_k,
b distinct from the other speeds,
b divides a_k with q=a_k/b,
gcd(q,N)=1,
b congruent to either +a_k or -a_k modulo N*a_j for every j != k.
```

For

```text
(1,2,3,24) -> (1,2,3,6),
```

the unique accepted replacement is `(a_k,b,q)=(24,6,4)`.  On the unchanged
pivots `1,2,3`, literal strict bad sets for speeds `24` and `6` are equal.
At the new pivot `6`, residue `r=6` modulo `30` has distances
`(6,12,12,6)`.  Mapping by `q` gives residue `24` at the old pivot `24`
modulo `120`, with distances `(24,48,48,24)`.

For G, all `sum_k(a_k-1)=1882` positive pairs `(k,b)` are enumerated before
the divisor, distinctness, coprimality, and signed-congruence filters.  No
replacement satisfies every condition.

## Reproduction

```bash
python3 scripts/audit_lcm_slice_bounds.py
PYTHONPATH=scripts python3 -m unittest -v tests.test_lcm_slice_bounds
```
