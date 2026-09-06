# Independent review of the ordinary parity-coset minimum audit

Reviewer task `/root/parity_coset_minimum_review`, requested Astra/xhigh;
source checkpoint `4818e5916e57697f83e842ca642f4e7599bbd32c`.
Only this review is owned. Other files, shared state, Git, Lean and caches
were preserved.

**Disposition: accepted at the stated manuscript scope.** The frozen author is
`research/astra-parity-coset-minimum-audit.md`, SHA-256
`b5dd0bbc3ef5d27a986a47b144e225637e338d81c6abceedc2d05d37d392a942`.
The complete original version was read, then the sole notation clarification
of the quotient fibre direction was read and verified by reverse hash.
The formulas, uniform family and all-real bounds needed no mathematical
correction. The review distinguishes a method obstruction from a descent
theorem under actual strict failure, which remains unproved.

## Gauge, attainment, contacts and parity

The ordinary stationary convention is retained: `d=N-1` positive distinct
primitive integer moving speeds, quotient `E=R^d/Rv`, actual image lattice
`Lambda=U(Z^d)`, centre `c=U(1_d/2)`, and body
`B=U([-1/2,1/2]^d)`. A hypothetical count-and-sum minimum has `d>=6`,
using the established six-total-runner result, and closed failure means
`r(v)>(d-1)/(d+1)`. Minimality supplies smaller witnesses; it does not
make an arbitrary smaller tuple fail.

The normalization has no missing factor two. For `x=U(n/2)` with `n`
odd, its gauge is `min_s max_i |n_i-s*v_i|`. At each fixed common `s`,
minimizing over all odd integer coordinates gives

    min_n max_i |n_i-s*v_i| = 1-2*min_i ||s*v_i/2||.

Taking the global extrema proves `r(v)=1-2*mu(v)`. The ordinary time is
`s/2`; it is not the lift parameter `s`. The norm on the finite-dimensional
quotient is proper and the coset is discrete, so its minimum is attained.
A time avoiding the finitely many integral phases gives `mu(v)>0` and
therefore `r(v)<1`. Mixed parity makes the coset nonintegral and `r(v)>0`.
Primitivity is essential to the equivalence between integral centre and
all-odd speeds; the latter already have the half-time witness.

For the gauge formula (2), membership of a lift in `r*C` is exactly the
intersection of the displayed closed intervals. Positivity of every speed
justifies every denominator and inequality orientation. Comparing each
left endpoint with each right endpoint gives both signed pair inequalities,
so the maximum over unordered pairs has precisely the stated factor two.
Substituting `a=n/2` gives (3). No limited competitor set is substituted
for the global minimum.

For a minimizing odd lift at positive radius, a positive-length intersection
of lift intervals would contain a point strictly inside all of them and
permit a smaller radius. Thus the lift time is unique. At least one
positive and one negative extremal residual are necessary: otherwise a
small change in the common time decreases every active residual, with
inactive coordinates retaining slack. Since all speeds are positive,
equality in the pair estimate requires exactly opposite extremal residuals.
This proves the active-pair description and
`s=(n_i+n_j)/(v_i+v_j)`. Oddness makes the corresponding ordinary numerator
`(n_i+n_j)/2` integral. Reduction modulo the integer time period recovers
the positive bounded numerator used in the existing pair-sum certificate.

The manuscript correctly identifies this as completeness rather than
supply. I read the actual balanced-cell and witness-completeness source:
the former retains a supplied positive margin, handles a diagonal minimum
by choosing distinct indices at the half boundary, and the latter derives
a certificate from an already existing witness. None supplies the universal
certificate premise.

The primitive-plane claim holds for every nearest point in the mixed-parity
case. If `2x=k*w` with `w` primitive, its nonzero parity forces `k` odd.
The point `w/2` is in the same coset and has gauge `r(v)/k`, so global
minimality forces `k=1`. After extending primitive `v` to an integer basis,
the quotient coordinates of `n` generate the same integer ideal as the
two-by-two minors of `[v n]`. Unimodular row operations preserve that
ideal. Hence the minors have gcd one and the rank-two lattice is saturated.
This is a consequence of the global minimum, not a new estimate on its
size.

## The inclusive-boundary span control

The consecutive-speed argument is valid for every total `N>=4`, with no
primality assumption. If all `1,...,N-1` phases have margin at least `1/N`,
all pairs among the `N` orbit points have that separation. Their cyclic
gaps must therefore all equal `1/N`. Including zero identifies the whole
grid, and the first step is `k/N` with `gcd(k,N)=1`. Conversely those
times work. The same packing forbids a larger margin, giving `r(v)=beta`.

At each such time, the representative
`a_i=1/2-fract(k*i/N)` lies in the contracted cube and gives a coset point
after quotienting by the same time times `v`. All nearest points arise
this way. The side length is below one, so the coordinate representatives
at a fixed time are unique. A fixed odd lift has unique optimizing time.
If two odd lifts represent the same quotient point, their difference is
an integral multiple of primitive `v`; it is even coordinatewise, and
`v` has an odd coordinate, so that multiple is even. Thus the corresponding
ordinary times differ by an integer. This verifies the asserted time/coset
correspondence, including its factor two.

The unit residues pair as `k` and `N-k`, with opposite representatives
and no fixed unit for `N>=4`. Their linear span has dimension at most
`phi(N)/2 <= (N-1)/2 < N-2`. This also controls affine span because the
set is symmetric. It refutes an automatic full-span statement at the
inclusive boundary. It does not refute a statement additionally assuming
strict failure, and no exact rank is asserted.

## Basis changes and the all-competitor comparison

The matrix with columns `(a,2b)` and `(2c,d_0)` has determinant `+/-1`,
so it preserves the saturated rank-two lattice. Odd diagonal entries
preserve the required parities. Its new basis columns are primitive in
the plane and hence in the ambient integer lattice. Simultaneous coordinate
sign changes preserve norms, oddness and absolute minors. The manuscript
correctly excludes zero-speed removal as a norm-preserving operation and
distinguishes deduplication from an unchanged canonical count.

The tracked candidate's gauge is an upper bound on the new minimum.
Increasing that upper bound cannot prove that all competitors are bad.
Equation (7) addresses arbitrary competitors with the correct left side:
`R=||m-s*w||_infty`, rather than the global minimum before a minimizing
pair has been chosen.

Independently expanding the residual gives, for every integer `k`,

    (m-2k*n) - [s(a+2b*s_0)-2k*s_0]v
      = (m-s*w)+2(bs-k)(n-s_0*v).

The left-hand odd vector is admissible for the old global minimum. Taking
norms and then the nearest integer to `bs` gives exactly
`R >= (1-2||bs||)r(v)`. There is one common real time throughout. The
phase factor is nonnegative but can vanish as a function of `s`; no
assumption bounds it away from zero at a supplied new witness. Under
`r(v)>beta` and `R<=beta`, rearrangement gives precisely the closed
necessary condition (8). Equality is allowed and does not exclude a new
closed witness. The comparison therefore exposes a missing phase condition
instead of proving preserved failure.

## Independent all-dimension control check

The construction uses exactly `d` speeds for every `d>=6`. Appended old
speeds `39h+1` begin at 40, above the base maximum 27; appended new speeds
`21h-1` begin at 20, above the new maximum 13. Both sequences are strictly
increasing, and each tuple contains speed 1, so positivity, distinctness
and primitivity all hold. The original odd lifts remain odd. The first
two rows of `[v n]` have determinant `-1`, establishing saturation.

The base and appended residuals in (9) check directly at lift time `8/13`.
Ordinary time `4/13` therefore has margin `4/13`. For an all-real upper
bound, periodicity and reflection put time in `[0,1/2]`. Margin greater
than `4/13` for speeds 1 and 2 requires `4/13<t<9/26`, where the speed-12
phase lies strictly between `4-4/13` and `4+2/13` and is strictly too
close to 4. This proves the old optimum for every appended tuple.

The determinant-one coefficients produce exactly the displayed `w,n'`.
The sole negative speed is the first, and flipping that coordinate in
both vectors is legitimate. The base sum decreases from 81 to 45, and
each appended contribution decreases by `18h+2`. Every new speed is
nonzero modulo 3, so ordinary time `1/3` supplies margin `1/3`; speeds
1 and 2 give its matching global upper bound.

| Quantity | Old family | New positive family |
| --- | --- | --- |
| Global ordinary margin `mu` | `4/13` | `1/3` |
| Global coset minimum `r=1-2mu` | `5/13` | `1/3` |
| Tracked odd candidate's gauge | `5/13` | `5/7` |

The tracked new candidate at lift time `-2/7` has the stated residuals,
including appended value `5/7`. The pair of speeds 1 and 13 supplies
the matching lower bound `10/14`, so the candidate's gauge is exactly
`5/7`. This is distinct from the global new minimum.

The alternative raw odd vector at lift time `2/3` has base residuals
`(-1,-1,-1,1,-1,1)/3` and appended residual `-1/3`. It therefore attains
the new global minimum. Its first two coordinates force coefficients
`2,-3` in the old plane, whereas its third coordinate is 5 instead of 3.
It is outside even the real span of the old columns. The invertible basis
change preserves that plane; the common sign flip preserves nonmembership.
The phase `||b*s||=1/3` is consistent with (7), not a counterexample to it.

For all these counts, `beta>=5/7>5/13`: the old family satisfies LRC,
as does the new family. Thus this is a uniform counterexample to minimum
monotonicity based only on the listed closest-point, parity, saturation,
determinant and height data. It does not satisfy the extra strict-failure
hypothesis of a prospective true descent theorem. No method-wide or LRC
impossibility follows.

## Remaining obligation and verification

The closing central-fibre calculation is correct with direction `u=2x`
in the quotient: its gauge in `B` is `2r(v)`, so the target fibre is
`[-beta/(2r(v)),beta/(2r(v))]` in `u` coordinates. Its affine coset has
coordinates `1/2+Z`. Strict failure makes the interval miss that coset
while the projected centre is integral. Choosing the nearest direction
therefore does not supply a lift.

No new bound forcing `r(v)<=beta` has been proved. Descent still needs
control of every odd competitor for an actual smaller tuple under original
failure, or a justified transport of a supplied new witness. The accepted
example pinpoints why preserving a plane and one candidate is insufficient;
it does not replace that missing theorem. No Lean implementation is warranted
by this manuscript alone.

The complete author was read, along with the accepted projection review,
the relevant earlier arguments and actual pair-sum source contracts and
proofs. Current readback matched all eleven author input bindings:

| Input | Actual SHA-256 |
| --- | --- |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |
| `research/astra-center-preserving-projection-audit.md` | `0efe2d8bfb272f194249e6201491a64165d6a102900a71c8953618253f18c60e` |
| `research/astra-center-preserving-projection-review.md` | `a1402e6545dd2de6a2d4b2f832b2ff13ec52f759a1ae5fb183122d1ad3d0c7e6` |
| `research/astra-pair-sum-cell-contract.md` | `1b441ec0b0145007cf18bce59482396d175634cdd34d3ba4edba8c0376cb7c8f` |
| `LonelyRunner/PairSumGeometry.lean` | `3bc47a6f1a77950577edc54b571e9809bb03bffd37575ebc10bae0fcfcab9384` |
| `LonelyRunner/PairSumCompleteness.lean` | `838a3bcec806b0e9d01cd117e64e5348de58a05127a3f7bef5dbe2d879ff292f` |
| `research/astra-uniform-global-seed-geometry.md` | `3a4a825f3f801282eb39b469571bbd4cac3a4e1f768d58542b7c1555cd725524` |
| `research/astra-minimal-height-audit.md` | `40e59ba4539eb931a07612e9b972999d3b48006d39ef4760c0e493d08e734325` |

The current config, workflow, policy and focused active state were read.
Actual check in `/home/joshua/lonely-runner-formalization`:

    python3 -B scripts/validate_workflow.py

Exit status 0; full raw output:

    workflow structural validation passed; it cannot certify mathematical validity.

Hashes were read using `sha256sum` on the listed paths. All mathematical
checks above were exact hand algebra and all-real arguments. No mathematical
program, solver, enumeration, historical replay, Lean invocation, cache
access, Git mutation or shared-state edit was performed. The final owned-file
whitespace/newline and SHA-256 receipt is supplied to root separately.

The sole source clarification renamed the quotient direction to `u=2x`,
separating it from the new speed vector `w`. The following read-only
administrative command verified that all other bytes match the fully read
original; it does not execute any mathematics:

```bash
python3 -B - <<'PY'
from pathlib import Path
from hashlib import sha256
p = Path('research/astra-parity-coset-minimum-audit.md')
text = p.read_text()
new = 'along the closest primitive `2x` does not repair it: put `u=2x`; the central\ntarget fibre has `u`-coordinate interval'
old = 'along the closest primitive `2x` does not repair it: its central target\nfibre has `w`-coordinate interval'
assert text.count(new) == 1
assert sha256(text.replace(new, old).encode()).hexdigest() == 'd879214888177a9551b29229b503662c748742f1e9614c863927f714cdc1e4a2'
print('PASS: final source differs from the fully read original only by the requested fibre-direction notation.')
PY
```

Exit status 0; full raw output:

    PASS: final source differs from the fully read original only by the requested fibre-direction notation.
