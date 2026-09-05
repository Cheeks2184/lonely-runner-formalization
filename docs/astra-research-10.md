# Pass 10: exact cyclic transport and limits of prime-square grids

`LonelyRunner/AffineGridCyclic.lean` adds an exact equivalence for arbitrary
rounded affine-grid phases. With the usual integral congruence and rounding
identity, write

```text
X = ((s*u+r0*a) mod N)*M + a*beta.
```

The actual speed has circle distance at least `1/N` exactly when
`M <= X mod (N*M) <= (N-1)*M`. This reduces the complete corrected numerator,
so it handles arbitrarily many wraps and both closed endpoints. It works for
all `N>=2`, including even composite counts, and allows zero bases, zero
actual offsets and `N|M`. It supplies no good grid parameters by itself.
The source has an independent exact-contract and axiom review.

The supply audit proves a positive special-case bound. If no speed is divisible
by `p^2`, and exactly `m` indices are units modulo the odd prime `p`, every
nonzero strip `k/p+j/p^2` has at least `p-2m` good choices of `k`. Thus the
bound supplies witnesses whenever `m< p/2`. This remains a manuscript proof.

The same audit rejects universal prime-square-grid supply. At `p=7`, the
primitive tuple `(1,3,4,5,18,7)` fails every time `n/49`, although `5/11` is
a strict witness with minimum distance `2/11`. An explicit reflected partition
proves the grid obstruction; independent multiples of 539 give an unbounded
family retaining the obstruction and strict witness. The obstruction includes
constant corrections `beta/M=j/p` and correct transports that stay on that
grid, but it says nothing negative about arbitrary correction envelopes.

A follow-up exact certificate also refutes the proposed covering bound
`tau_p>=p-2`. At `p=13`, the ten unit speeds

```text
1, 7, 8, 9, 10, 17, 33, 36, 64, 69
```

cover every unit numerator modulo 169 by their strict bad sets. Adding speeds
13 and 26 rules out every remaining numerator. This twelve-speed tuple is
distinct and primitive, with no speed divisible by 169. It nevertheless has
the strict witness `5/19`, of minimum distance `2/19`. Thus two prime-divisible
rows do not guarantee prime-square-grid supply. Multiples of 3211 in the last
eleven coordinates preserve this second obstruction and its strict witness.
The preceding frozen manuscript's covering question records its historical
unproved status; this later certificate rejects it. The bounded search at
`p=11` establishes no covering lower bound.

The integrated Lean build passes 3,609 jobs, and the trust audit accepts 351
theorem reports with only the three permitted standard axioms. Root ran all
seven concrete Lean cyclic probes, both independent review reproductions,
and the full positive p=13 certificate. Review scope, hashes and reproduction
commands are recorded in `research/astra-pass10-verification.json`.

The general one/two bad-residue characterization and weighted whole-envelope
bridge are still to be formalized. Arbitrary-tuple envelope supply and the
canonical unrestricted Lonely Runner Conjecture remain unresolved. The next
constant-correction audit is excluded from this checkpoint.
