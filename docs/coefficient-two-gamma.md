# Coefficient-two complementary-hole charging

Status: the forcing lemmas and four finite repairs are audited mathematics.
The uniform Hall selector below is **conjectural**. Exact computation through
`N=300` is evidence only; no coefficient-two or unrestricted LRC theorem is
claimed.

## Complementary-extra neighborhoods

Let `H=N+t`, with `0<t` and `2*t<=N`. For a base height `c`, define

```text
Auto(c) iff there exists d with H<d, c+d<=2N, and gcd(c,d)=1.

Gamma(c)={d : N<d<=H, H<c+d<=2N, gcd(c,d)=1}.
```

For `c<=N` and `2c<=H`, the raw interval underlying `Gamma(c)` is

```text
[max(N+1,H-c+1), min(H,2N-c)],
```

with exactly `min(c,t,N-c)` integers before filtering by coprimality.

Suppose `c` is a missing base height. If `Auto(c)` holds, choose its `d` and
put `q=c+d`. Then `N<q<=2N`, every selected speed is at most `H<d<q`, both
`c` and `q-c=d` are missing, and `gcd(c,q)=gcd(c,d)=1`. The existing two-hole
denominator theorem gives the closed `1/N` witness.

Likewise, if `d in Gamma(c)` is missing, `q=c+d` has `H<q<=2N` and gives the
same witness. Therefore a hypothetical no-witness family must satisfy

```text
Gamma(c) subset E
```

for every missing base height `c`, where `E` is the occupied-extra set in
`(N,H]`.

## Exact selector conjecture

Let `C(N,t)` consist of the `c` satisfying

```text
1<=c<=N,
2c<=H,
N-c-t < 2^omega(c),
not Auto(c),
```

and either `3*(N-t)<4c` or `(N,t,c)` belongs to the audited 22-triple
short-hole table.

Except for

```text
(N,t)=(4,2),(5,2),(8,4),(11,5),
```

the conjectural arithmetic statement is that the family `Gamma(c)`,
`c in C(N,t)`, has a system of distinct representatives. Equivalently,

```text
for every A subset C(N,t),
  |A| <= |union_{c in A} Gamma(c)|.
```

This one statement would close coefficient two. Under no witness, every
missing base height lies in `C(N,t)`: the reciprocal branch forces `2c<=H`,
the Kanold branch forces the short-interval inequality, the 22-case classifier
gives the generic-or-exception alternative, and `Auto(c)` has just been
eliminated. A selector restricted to the actual missing set `M`, together with
`Gamma(M) subset E`, would inject `M` into `E`, contradicting the already
verified identity `|M|=|E|+1`.

No proof of this selector theorem is known.

## Four finite repairs

Assume the no-witness consequences `M subset C`, `Gamma(M) subset E`,
nonempty `M`, and `|E|=|M|-1`. Exact finite deductions leave only:

```text
(4,2):  M={2,3},     E={5};
(5,2):  M={2,3},     E={7};
(8,4):  M={6},       E=empty,
         or M={4,5,6}, E={9,11};
(11,5): M={6,8},     E={13}.
```

Every configuration has a reciprocal witness. Use `c=3`, `c=3`, `c=6` or
`c=5`, and `c=6`, respectively: no selected speed in the corresponding
configuration is divisible by that missing height. Thus these four parameter
pairs are repairs to the proposed selector theorem, not exceptions to the
coefficient-two target.

## Reproducible evidence

The deterministic verifier checks every `4<=N<=300` and
`1<=t<=floor(N/2)`. The only full-candidate selector failures are the four
pairs above; it also enumerates every compatible finite repair configuration
and checks a collision counterexample to a simpler charge. Reproduce with

```bash
bash scripts/audit_coefficient_two_gamma.sh
```

The exact Python source SHA-256 is

```text
508ce445b8fe2d8429878c28eda890a053305964c4a6275e0b577ede2fc04e39
```

and the expected-output SHA-256 is

```text
f087834eeb07f4ca1c4b258d16d3dd8ebb23bf5e6bbe15641c6ec28f89dfb925.
```

The public replay under Python 3.14.4 completed in 8.24 seconds with maximum
RSS 28,996 KB. This finite range cannot promote the selector conjecture.

## Refuted simpler charges

At `N=19,t=9`, take `M={9,14}` and `E={28}`. Both reciprocals are blocked,
but the one-output rule collides because

```text
3*9+1=28=2*14.
```

This is not an LRC counterexample: `q=29`, `c=9`, and `q-c=20` give an exact
two-hole witness. A second collision with `M={9,13,14}`, `E={26,28}` defeats
even the two affine alternatives `3*9-1` and `3*9+1`. Again the missing height
`20` repairs the family. The full `Gamma` relation records complementary
heights rather than choosing one affine output prematurely.

## Relation to known coprime matching work

Bohman and Peng prove an asymptotic coprime mapping theorem for two equal
intervals and use it to establish LRC for sufficiently large `n` when the
maximum speed is below `(2-epsilon)n`. Pomerance improves the interval-length
requirement to order `(log n)^2`. These primary results concern rectangular
interval matchings; they do not directly imply the sliding, truncated,
candidate-dependent `Gamma` Hall condition above, nor do they provide the
needed exact all-dimension Lean bridge. See
[Bohman--Peng](https://arxiv.org/abs/2109.09860) and
[Pomerance](https://arxiv.org/abs/2111.07157).

The remaining task is to exploit the monotone sliding endpoints and minimal
Hall-deficiency incidence, beyond scalar coprime-gap bounds.
