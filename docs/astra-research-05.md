# Astra research checkpoint 5

The unrestricted canonical conjecture remains unresolved. This checkpoint
formalizes one shared grid correction for several zero slopes. It also records
which normalization implications are actually established and which remain open.

## Simultaneous original zero rows

`LonelyRunner/AffineGridMultipleZero.lean` proves
`affine_avoidance_card_le_sub_two` by padding ordinary rows with slope 1 and
offset 0, including an empty ordinary family. Its main declaration,
`affine_grid_multiple_zero_witness`, partitions exactly N-1 original speeds
into a nonempty zero set and an ordinary set, for odd prime N.

Zero bases A_j lie in a positive range L <= A_j <= H; both each base and
its actual speed U_j are divisible by N. Ordinary bases satisfy 0<a_i<L
and are nonzero modulo N. Every actual speed is congruent to its base modulo
positive M. The explicit size assumptions are

```
H < (N-1)*L
N*H*L <= ((N-1)*L-H)*M
N*a_i*L <= (L-a_i)*M.
```

The conclusion gives one time s/N+r/M, with 0<s<N, attaining the closed
1/N circle-distance bound for every U_j and every ordinary u_i. The proof
derives all bases<M internally. No ordinary nonemptiness, nonzero-offset,
or additional L/H divisibility premise is imposed. Its all-zero case is
included, and both new public declarations enter the root axiom audit.

## Demonstrated additional reach and exact limits

The independently reviewed value audit in
`research/astra-multiple-zero-value.md` provides a complete mixed certificate
for V7=(2,3,4,30,7,14). At M=257 and common multiplier b=35, zero bases
70,105,140 and ordinary bases 22,12,24 satisfy every coarse inequality.
The certificate controls all six original speeds after exact signed transport.
This tuple escapes every earlier A/B/coarse-C normalization, so the new theorem
has a demonstrated extension beyond those contracts.

The same audit characterizes all-zero normalization by a constrained
small-residue recurrence and proves that V7 admits no all-zero normalization,
despite its strict witness 1/9. Thus strict witness existence does not supply
that subclass automatically. The robust multiple-zero contract also misses
tight tuples (1,...,N-1), but A already handles them. Neither example refutes
universality of the enlarged union.

For moduli not divisible by N, a robust certificate gives a strict original
witness. When N divides M, only the closed implication is established here.
The N=5 tuple (1,2,5,20) demonstrates why perturbing independently lifted
positive representatives off the grid cannot establish strictness for the
original signed tuple. It has another strict witness, so this control only
refutes the perturbation argument.

Sufficiency of a strict witness for mixed normalization and universality of
A/B/C/multiple-zero remain unproved. The next bounded audit tests the union
on a different strict-witness family rather than assuming this extension
has solved the general supply problem.

Independent review and exact source fingerprints are recorded in
`research/astra-pass5-review.md` and `research/astra-pass5-verification.json`.
