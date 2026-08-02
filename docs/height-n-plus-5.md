# The max-speed `n+5` theorem

## Status

Let `n>=1` and `N=n+1`. Every `n`-element set of distinct positive integer
speeds contained in `[1,n+5]=[1,N+4]` has a time at closed circular distance
at least `1/N`. Consequently, a positive-integer counterexample would have
maximum at least `n+6=N+5`.

The proof for `N>=20` is deductive. The 134,568 residual configurations for
`N=4,...,19` have exact reproducible certificates. `N=2` is elementary and
`N=3` is covered by the kernel-checked two-moving-runner theorem. A separate
adversarial review reconstructed the proof, regenerated every exceptional
row, and independently reimplemented the finite enumeration in C++.

This is a computer-assisted bounded-height theorem, not the full Lonely
Runner Conjecture and not yet one Lean declaration.

## Uniform proof for `N>=20`

Put `H=N+4` and let `A` be an `(N-1)`-element subset of `[1,H]`. Its
complement has five elements. Only four integers in `[1,H]` exceed `N`, so
choose a missing `c` with `1<=c<=N`.

If `2c>H`, then `c` is the only positive multiple of `c` at most `H`.
Therefore no speed is divisible by `c`, and `t=1/c` gives circular distance
at least `1/c>=1/N` for every speed.

Assume `2c<=H`. Consider the inclusive interval

```text
I=[N+c+5,2N]=[H+c+1,2N].
```

It contains `L=N-c-4` consecutive integers. Since `N>=20` and
`c<=(N+4)/2`, one has `L>=4`, so `I` is nonempty. Every `q` in `I` satisfies

```text
H<q<=2N,             q-c>H.
```

If `L>=c`, the interval contains a complete residue system modulo `c`, hence
a number coprime to `c`. If `L<c`, its residues are distinct and their
complement has cardinality

```text
c-L=2c-N+4<=8.
```

Thus `phi(c)>8` again forces a `q` in `I` coprime to `c`.

For such a `q`, take `0<r<q` with `c*r=1 (mod q)`. A selected speed cannot
give transformed residue zero because it lies strictly between zero and `q`.
Residue `+1` would force the speed to be the missing `c`; residue `-1` would
force it to be `q-c>H`. Hence every transformed circular residue is at least
two, and

```text
N*rho_q(r*a) >= 2N >= q.
```

The equality case `q=2N` is valid because the boundary is closed.

## Totient exceptions

The exact classification is

```text
phi(c)<=8 iff
c in {1,2,3,4,5,6,7,8,9,10,12,14,15,16,18,20,24,30}.
```

If a prime `p` divides `c`, then `p-1` divides `phi(c)`, so only
`p=2,3,5,7` can occur. The prime-power factors bound the exponents by
`a_2<=4`, `a_3<=2`, `a_5<=1`, and `a_7<=1`. Splitting on the `7` and `5`
factors and enumerating the remaining `2^a*3^b` cases gives exactly the
displayed set.

When `N>=2c+4`, the interval length already satisfies `L>=c`. The remaining
pairs obey

```text
max(20,2c-4)<=N<=2c+3.
```

The following 70 checked `(N,q)` rows cover every such pair; each listed `q`
lies in `I` and is coprime to `c`:

```text
c=9:  (20,34) (21,35)
c=10: (20,37) (21,37) (22,37) (23,39)
c=12: (20,37) (21,41) (22,41) (23,41) (24,41) (25,43) (26,43) (27,47)
c=14: (24,43) (25,45) (26,45) (27,47) (28,47) (29,51) (30,51) (31,51)
c=15: (26,46) (27,47) (28,49) (29,49) (30,52) (31,52) (32,52) (33,53)
c=16: (28,49) (29,51) (30,51) (31,53) (32,53) (33,55) (34,55) (35,57)
c=18: (32,55) (33,59) (34,59) (35,59) (36,59) (37,61) (38,61) (39,65)
c=20: (36,61) (37,63) (38,63) (39,67) (40,67) (41,67) (42,67) (43,69)
c=24: (44,73) (45,77) (46,77) (47,77) (48,77) (49,79) (50,79) (51,83)
c=30: (56,91) (57,97) (58,97) (59,97) (60,97) (61,97) (62,97) (63,101)
```

## Exact finite core

For `N=4,...,19`, the verifier enumerates all five-hole subsets of `[1,N+4]`
and checks every returned witness using the integer inequality

```text
N*rho_q(r*a)>=q.
```

It first searches reciprocal, `C_2`, and `C_3` patterns. Exactly three cases
need a direct rational witness:

```text
N=4, speeds=(2,6,8),   holes=(1,3,4,5,7), t=2/7;
N=4, speeds=(2,4,6),   holes=(1,3,5,7,8), t=1/8;
N=5, speeds=(1,3,4,5), holes=(2,6,7,8,9), t=4/9.
```

The first case has no reciprocal, `C_2`, or `C_3` certificate under the
stated search definitions. This is a construction failure, not an LRC
counterexample.

Reproduce the certificate with:

```bash
bash scripts/audit_height_n_plus_5.sh
```

Hashes:

```text
6f401c0dd6ed0a7d8670f1b7c5606133a9abb0436dbee15af3a67c05eac6125a
  scripts/verify_height_n_plus_5.py
884e01a2fdbcf44e970b44032655785b571b8c2c08f55e69b7c6b049a88aac1f
  certificates/height_n_plus_5_expected.txt
e7e703f7d2542e9e023e79b481646d9274afb2ad958b55426cfdd96bb5440397
  certificate rows printed by the verifier
```

## Unbounded constructive extension

The same argument gives a deductive theorem for arbitrary positive integers
`N,t`. If

```text
16*t^2+t<=N,
```

then every `(N-1)`-element positive-integer speed set bounded by `N+t` is
lonely. In the short-interval branch, at most `2t` residue classes are
missing. The elementary bound

```text
phi(c)>=sqrt(c/2)
```

implies that `phi(c)<=2t` forces `c<=8t^2`; the displayed hypothesis then
forces the interval to contain at least `c` consecutive integers, a
contradiction.

Define

```text
t_N=floor((sqrt(64N+1)-1)/32),
T_N=max(4,t_N).
```

Combining this deductive theorem with the five-hole result and the base cases
shows, for every `N>=2`, that maximum at most `N+T_N` is sufficient. Thus an
integer counterexample would satisfy

```text
max A >= N+T_N+1.
```

This grows as `N+sqrt(N)/4+O(1)`. The deduction was independently audited;
the six corresponding rows printed by the Prompt 44 verifier are merely
sanity checks, not the proof.
