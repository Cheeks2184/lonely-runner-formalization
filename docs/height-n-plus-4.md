# The max-speed `n+4` theorem

## Status

Let `n>=1` and `N=n+1`. Every `n` distinct positive integer speeds with
maximum at most `n+4=N+3` have a time at closed circular distance at least
`1/N`. Consequently, a positive-integer counterexample would have maximum at
least `n+5=N+4`.

The proof for `N>=12` is deductive and has passed an independent adversarial
audit. `N=2` is elementary and `N=3` is already kernel-checked by the
two-moving-runner theorem. The 2,982 residual configurations for `N=4..11`
are covered by an exact reproducible finite certificate. The all-dimensional
statement is therefore a computer-assisted mathematical theorem, but is not
yet one Lean declaration. `BoundedHeight.lean` formalizes the entire
large-`N` runner/family bridge conditionally on the explicit arithmetic
selector `HeightThreeCoprimeSelector`; formalizing the totient classification
and exceptional table as a proof of that selector remains open.

This is a bounded-height partial result, not a proof of LRC.

## 1. Residue lemmas

Put `H=N+3` and let `A` be an `(N-1)`-element subset of `[1,H]`.

Reciprocal lemma (`R`). If `1<=c<=N` and every positive multiple of `c` at
most `H` is absent from `A`, then `t=1/c` works. Every selected speed has a
nonzero residue modulo `c`, so its circular distance is at least
`1/c>=1/N`.

Inverse lemma (`C_b`). Suppose `H<q<=bN`, `gcd(c,q)=1`, and every least
positive representative of

```text
+/-c, +/-2c, ..., +/-(b-1)c  (mod q)
```

that lies in `[1,H]` is absent from `A`. Choose `0<r<q` with
`c*r congruent 1 (mod q)`. Because every speed is strictly between zero and
`q`, its transformed residue is nonzero. A transformed residue `+/-j` with
`1<=j<b` would force the speed into one of the excluded classes. Hence
`rho_q(r*a)>=b`, and

```text
||r*a/q|| >= b/q >= 1/N.
```

The endpoint `q=bN` is valid because the conjecture uses `>=`.

## 2. Uniform proof for `N>=12`

There are exactly four holes in `[1,H]`. Only `N+1,N+2,N+3` exceed `N`, so
choose a hole `c<=N`.

If `2c>H`, then `c` is the only positive multiple of `c` in `[1,H]`; lemma
`R` applies. Assume instead `2c<=H`. Consider

```text
I = [N+c+4, 2N] = [H+c+1, 2N].
```

Its cardinality is `L=N-c-3`, which is positive under `N>=12` and
`2c<=N+3`. Every `q` in `I` satisfies

```text
H<q<=2N,        q-c>H.
```

Thus `c` and `q-c` are absent, and any `q` coprime to `c` invokes `C_2`.

If `L>=c`, the interval contains a complete residue system modulo `c`, hence
a unit. If `L<c`, its residues are distinct and their complement has size

```text
c-L = 2c-N+3 <= 6.
```

Therefore `phi(c)>6` again forces a unit in the interval.

The exact exceptional classification is

```text
phi(c)<=6 iff c in {1,2,3,4,5,6,7,8,9,10,12,14,18}.
```

Indeed every prime divisor `p` satisfies `p-1 | phi(c)`, so `p<=7`; the
prime-power totient factors then leave exactly the displayed list. In the
`2^a*3^b` enumeration, `24`, `36`, and `72` are the three nonsurvivors that
must be explicitly discarded. This repairs a minor omission in the first
draft without changing the classification.

When `N>=2c+3`, one already has `L>=c`. In the remaining range
`N>=12` and `2c-3<=N<=2c+2`, the following table gives `(N,q)` with
`q in I` and `gcd(c,q)=1`:

```text
c=5:  (12,21)
c=6:  (12,23) (13,23) (14,25)
c=7:  (12,23) (13,24) (14,25) (15,26) (16,27)
c=8:  (13,25) (14,27) (15,27) (16,29) (17,29) (18,31)
c=9:  (15,28) (16,29) (17,31) (18,31) (19,32) (20,34)
c=10: (17,31) (18,33) (19,33) (20,37) (21,37) (22,37)
c=12: (21,37) (22,41) (23,41) (24,41) (25,41) (26,43)
c=14: (25,43) (26,45) (27,45) (28,47) (29,47) (30,51)
c=18: (33,55) (34,59) (35,59) (36,59) (37,59) (38,61)
```

For `c<=4`, no `N>=12` lies in the residual range. Independent review
regenerated every table entry and checked all eligible `(N,c)` through
`N=1000`.

## 3. Exact small cases

For `N=4..11`, the verifier enumerates every four-hole subset of `[1,N+3]`.
It first searches lemma `R`, then `C_2`, then `C_3`, and directly asserts

```text
N * rho_q(r*a) >= q
```

for every selected speed. The case counts are

```text
35, 70, 126, 210, 330, 495, 715, 1001,
```

totalling 2,982. Two `N=4` cases genuinely require `C_3`:

```text
speeds (3,4,7), holes (1,2,5,6), witness 1/10;
speeds (1,3,4), holes (2,5,6,7), witness 5/12.
```

The first is an exact obstruction to extending the two-hole construction
using only reciprocal and `C_2` witnesses; it is not an LRC counterexample.

## 4. Reproduction

From the repository root under WSL:

```bash
bash scripts/audit_height_n_plus_4.sh
```

The source and canonical-output hashes are:

```text
7e461a44b61f2b6655feb5d9e0054507ce56c70f1d53b6a5a970cd9ebccd490e
  scripts/verify_height_n_plus_4.py
505a91fe3be6a6adaa4440c9df3183ddaeb74cab13422e68e3c7e6d10cd4da9e
  certificates/height_n_plus_4_expected.txt
```

The certificate-row SHA-256 printed by the verifier is
`dda4a7f68573195efc13338f6252712352a2efd7c18ca3d8ddd38bad02e0cd96`.
