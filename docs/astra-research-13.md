# Pass 13: single-step escape also fails with only one zero row

The remaining version of the single-step endpoint proposal is false: exactly
one prime-divisible speed does not suffice. At `p=13`, take

```text
V=(1,7,8,10,17,136,133,64,100,80,423259206,47028800).
```

This tuple has twelve distinct positive speeds and gcd one. Only the last
speed is divisible by 13, and none is divisible by 169. Every `n/169` fails.
There are 86 grid points with a unique bad runner, giving 172 signed endpoint
attempts; every attempt fails. Nevertheless, `t=1/9` is a strict ordinary
witness, with minimum distance `1/9>1/13`.

The proof extends the guard construction using a balanced finite cover. Let
`A` be the first ten speeds, `D=lcm(A)=3617600`, `C=13*D`, and `B=9*C+6`.
The bad sets of `A` cover all 156 unit numerators modulo 169, and the ten
residues of `A` modulo 13 are distinct. Any unique bad owner at a unit grid
point belongs to `A`; `C` is integral at all endpoints of such a row.

At a nonzero prime-grid point `k/13`, `C` is the sole bad row. The rows of
`A` block ten of its right endpoints. The two remaining indices are 5 and 7,
and `B` blocks both by its exact correction quotient and remainder. Reflection
handles every left endpoint. The auxiliary row `B` is never a unique grid
owner, because `A` already covers every unit point. Periodicity covers every
integer numerator and retains both closed boundaries.

For every natural `h`, replace `C` by `C*(1+117*h)` and `B` by `9*C+6` using
the new `C`. Divisibility and residues modulo 169 and 9 are preserved, so the
same proof yields an unbounded family with the same strict witness. The known
maximal-zero positive theorem remains consistent: here the unit row `B` is
larger than the unique divisible row `C`.

The needed finite cover was found by replacing 9 with 80 in the previous
unbalanced ten-row cover. All 156 unit classes are checked exactly, and the
24-choice discovery step is retained. Negative local searches around a
different near-cover never ruled out this positive certificate. The root
proposal and limited near-cover verification notes are retained as frozen
historical inputs; the accepted audit supersedes their pending/no-hit status.
No unretained broad-search claim is used as proof.

An independent Astra review checks the conditional construction, orientation,
concrete tuple, all endpoints and the unbounded family. Root read and replayed
the accepted author and review blocks. Exact hashes and outcomes are in
`research/astra-pass13-verification.json`. This checkpoint changes no Lean
source and adds no kernel declaration. The preceding 354-report trust audit
remains the latest local Lean verification.

The general unique-bad single-step route is now retired for both one and
multiple prime-divisible rows. This is a manuscript obstruction to that method,
not a disproof of LRC. The canonical unrestricted conjecture remains unresolved;
the next research audit reassesses the existing owner/cover bridge.
