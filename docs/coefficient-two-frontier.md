# Coefficient-two bounded-height frontier

Status: independently audited manuscript mathematics on 2026-08-02. The
short-hole classification and the infinite Hall obstruction below are
`proved-math`, not `proved-lean`. No theorem under `2*t<=N` is claimed.

## Exact short-hole classification

Let `N,t,c` be natural numbers satisfying

```text
0<t,
0<c<=N,
2*t<=N,
2*c<=N+t,
N-c-t < 2^omega(c).
```

Then either

```text
3*(N-t) < 4*c
```

or `(N,t,c)` is one of the following 22 triples:

```text
(4,1,2),   (5,2,2),   (6,3,2),
(5,1,3),   (6,2,3),   (7,3,3),   (8,4,3),
(10,2,6),  (11,2,6),  (11,3,6),  (12,3,6),
(12,4,6),  (13,4,6),  (13,5,6),  (14,5,6),
(14,6,6),  (15,6,6),  (15,7,6),  (16,7,6),
(16,8,6),  (17,8,6),  (18,9,6).
```

Here `omega(c)` is the number of distinct prime factors of `c`.

### Uniform proof

Assume the displayed band inequality fails, so

```text
4*c <= 3*(N-t).
```

Together with `2*t<=N`, this implies `c+t<=N`. Put

```text
ell=N-c-t.
```

The failed band inequality gives

```text
c <= 3*ell,
```

while the short-hole hypothesis gives `ell<2^omega(c)`. For `c>=7` and
`c!=10`, the already audited arithmetic bound

```text
3*2^omega(c) <= c
```

is contradictory. For `c=10`, `omega(c)=2`, so `ell<4` implies
`3*ell<=9<c`, again contradictory. Hence `c<=6`.

The inequalities `c<=3*ell<3*2^omega(c)` leave only

```text
(c,ell)=(2,1),(3,1),(6,2),(6,3).
```

Since `N=c+t+ell`, the two remaining height inequalities give exactly:

```text
c=2, ell=1: t=1,2,3;
c=3, ell=1: t=1,2,3,4;
c=6, ell=2: t=2,...,8;
c=6, ell=3: t=2,...,9.
```

These are precisely the 22 triples above. An independent exact enumeration
through `N=500` reproduced the same list, but the symbolic argument is the
uniform proof.

## Reduction by the coefficient-three theorem

If `3*t<=N`, the already verified coefficient-three height theorem applies.
Removing those nine triples from the short-hole table leaves exactly these 13
coefficient-two frontier cases:

```text
(5,2,2),   (6,3,2),   (7,3,3),   (8,4,3),
(13,5,6),  (14,5,6),  (14,6,6),  (15,6,6),
(15,7,6),  (16,7,6),  (16,8,6),  (17,8,6),
(18,9,6).
```

For these cases the possible multipliers `k>=2` with `k*c>N` and
`k*c<=N+t` are, in the same order,

```text
{3}, {4}, {3}, {3,4}, {3}, {3}, {3},
{3}, {3}, {3}, {3,4}, {3,4}, {4}.
```

This is an exact finite boundary table. It is not itself a family-level
repair.

## Generic reciprocal blockers

In the generic band one has

```text
3*(N-t)<4*c.
```

Because `2*t<=N`, this implies `c>3*N/8`. Consequently

```text
3*c>N,
4*c>N+t.
```

If `c` is a missing speed, the only possible occupied positive multiples of
`c` below the height `N+t` are therefore `2*c` and `3*c`. The multiplier
`3*c` is always an extra speed above `N`; `2*c` may still lie in the base
interval `[1,N]`.

This is the obstruction to copying the coefficient-three cardinality proof.
Blocking the reciprocal witness `1/c` by an occupied base speed `2*c` need
not consume any member of the occupied-extra set. Even if one records only
extra blockers with the relation

```text
R(c,e) iff e=2*c or e=3*c,
```

the resulting neighborhoods need not satisfy Hall's condition.

## Infinite Hall obstruction

For every `u>=1`, put

```text
N=4*u,
t=2*u,
S=[1,4*u] \ {2*u,3*u} union {6*u}.
```

The set `S` has exactly `4*u-1=N-1` distinct positive speeds, maximum
`6*u=N+t`, and satisfies `2*t=N`. Its missing-base and occupied-extra sets are

```text
M={2*u,3*u},
E={6*u}.
```

The only extra blocker `6*u` equals `3*(2*u)` and `2*(3*u)`. Thus both holes
have the same extra neighborhood `{6*u}`, and Hall fails on the subset `M`:

```text
|M|=2 > 1=|E|.
```

The smaller hole is additionally blocked by the occupied base speed `4*u`.
Therefore neither a direct injection of holes into extras nor the natural
extra-blocker Hall relation can prove the coefficient-two theorem.

This is a proof-method obstruction, not an LRC counterexample. The family has
an exact two-hole witness. Set

```text
q=6*u+1,
c=2*u,
d=q-c=4*u+1.
```

Then, for every `u>=1`,

```text
0<c<q,
N<q<=2*N,
gcd(c,q)=1,
max S=6*u<q.
```

The coprimality is immediate from `q-3*c=1`. Both `c` and `d` are absent from
`S`: `c` is a removed base speed, while `4*u<d<6*u` and the only selected
speed above `4*u` is `6*u`. Hence the existing two-hole denominator argument
at modulus `q` gives a common closed `1/N` witness.

## Remaining obligations

- Repair the 13 low triples at the family level or prove that another missing
  height always avoids them.
- Replace the false injection/Hall step in the generic band by a structure
  that credits occupied base blockers without losing the missing-versus-extra
  cardinality surplus.
- Explain uniformly how complementary missing heights such as `q-c` arise;
  the explicit `4*u+1` hole in the obstruction family is not available from
  the current counting argument for an arbitrary family.
- Formalize the 22-triple classification only after a viable family-level use
  is identified; a compiled classifier alone would not prove the
  coefficient-two height theorem.

The coefficient-two bounded-height theorem remains conjectural/open.

