# Pass 12: a guard obstruction and a repaired sieve invariant

The proposed single-step escape from prime-square grids is false. Even when
many grid points have exactly one failing runner, moving to either boundary
of that runner's bad interval need not produce a common witness.

At `p=13`, the exact tuple is

```text
1,7,8,9,10,17,33,36,64,69,12399266880,26.
```

It has twelve distinct positive speeds, gcd one, exactly two speeds divisible
by 13, and none divisible by 169. Every `n/169` fails. There are 98 grid points
with a unique bad row, giving 196 signed endpoint occurrences, all of which
fail. Let `A` be the first ten speeds and `L=953789760`, a common multiple
of all of them. The added speed `C=13*L` is integral at every endpoint
`(k±1/13)/a` for `a in A`. At every nonunit numerator both divisible rows
fail, so no other unique owner supplies an escape. This proves the obstruction
symbolically, including all integer periods and both closed boundaries.

The tuple still has the strict LRC witness `5/19`, with minimum distance
`2/19>1/13`. Replacing `L` by `lcm(A)*(11+247*h)` for any natural `h` gives
an unbounded family retaining the same obstruction and strict witness.
A positive restriction with one maximal divisible row was also checked and
identified as an existing project result; it is not counted as new supply.

A separate audit examines Proposition 3.1 of the versioned
[Eleven, twelve, and thirteen lonely runners](https://arxiv.org/html/2604.23906v2#S3).
Its displayed projection-of-intersection equality fails under the stated weak
invariant. An exact example has 1,296 source representatives covering all base
classes, 20,736 proper lifts, and an improper tuple in another part of the
same base fiber. This refutes the equality, not the proposition's final
inclusion or the paper's computational theorem.

The audit proves a sufficient repair: retain every improper tuple over each
remaining base class. Properness survives lifts, so complete filtered lifting
and backward projection preserve this stronger invariant. This repairs the
symbolic sieve argument. Limited observations from six immutable C++ files
were independently checked, with explicit limits: no full enumeration,
symmetry, pruning, binary, log, or computational-theorem certification is claimed.

Both manuscripts have independent Astra reviews and exact author/reviewer
reproducers. Root read and replayed them. Verification and source hashes are
recorded in `research/astra-pass12-verification.json`. This checkpoint changes
no Lean source: the preceding source checkpoint's 3,610-job build and 354-report
trust audit are unchanged. Focused workflow, storage and ledger tests pass.
The 7.70 GB rebuildable cache removed after that verification remains absent.

These are manuscript results and exact finite controls, not new Lean proofs.
The unrestricted canonical LRC goal remains unresolved. The subsequent
balanced-cover and single-zero follow-ups are excluded from this checkpoint.
