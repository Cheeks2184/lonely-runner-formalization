# Astra research checkpoint 4

The unrestricted canonical conjecture remains unresolved. This checkpoint
formalizes an explicit family for every integer runner count at least seven
and identifies a uniform limit of the three previously compiled grid contracts.

## Explicit witness without primality

`LonelyRunner/AffineDenseFamily.lean` proves `affine_dense_family_witness`.
For every natural N >= 7 and z >= 0, set

```
M = N^2*(N-1)+1
H = 1+M*(1+N*z)
t = (N^3-2)/(N*M).
```

The theorem proves the closed 1/N distance bound for speeds 2, 3, N and
all j*H with 4 <= j < N. These are all N-1 moving speeds. The direct real
phase decomposition retains the integer part of each lift and requires
neither a prime nor an odd N. This is an infinite explicit family, not a
statement about arbitrary speed tuples. The root import and theorem axiom
audit include the declaration.

## The current normalization classes are not universal

`research/astra-grid-supply-audit.md` gives a manuscript proof that, for every
odd prime N >= 7, the primitive distinct tuple

```
(2,3,...,N-3, (N-2)*(N-1), N, 2*N)
```

escapes every normalization satisfying the compiled full-size, actual-pivot,
or coarse one-zero contracts. The argument allows every external modulus,
common modular unit, coordinate permutation, and independent sign choice.
It uses the five-speed core (2,3,4,N,2N), and does not exclude common integer
lifts divisible by N. A full ten-speed N=11 control demonstrates that the
smaller four-speed core would be an invalid obstruction.

The escaping family still has explicit ordinary LRC witnesses: 1/(N+2)
for prime N=7 or N>=13, and 1/14 for N=11. Thus this is a limitation of
these sufficient conditions. It is not a disproof of LRC. The obstruction
itself is a reviewed manuscript claim, not a Lean declaration; the broader
exact-size and simultaneous multiple-zero contracts remain outside its scope.

Independent review is recorded in `research/astra-pass4-review.md`; source
fingerprints and full integration checks are recorded in
`research/astra-pass4-verification.json`. The next research decision must
address the supply gap, rather than assume further scaling or modulus growth
makes the current three contracts universal.
