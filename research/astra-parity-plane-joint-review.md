# Independent review of joint parity-plane descent

Reviewer task `/root/parity_plane_joint_review`, requested Astra/xhigh;
source checkpoint `cfee39546b7e5d6c1041a20f3a8cc3cd0d51929e`.
Only this review is owned. The complete frozen author is
`research/astra-parity-plane-joint-descent.md`, SHA-256
`2b9a2350701206bd4bf5af0589cb607b545afe5a96258239a5ad77a031f58472`.

**Verdict: accepted at the stated manuscript scope, without corrections.**
The exact ray identity, actual smaller-sum fold and conditional exclusion
of all odd competitors in the preserved plane are sound. They do not
transport a witness, establish iterative rank growth, or produce a smaller
counterexample. The zero and nonzero cases retain different obligations.

## Normalization and exact ray distance

The setup is an ordinary positive distinct primitive integer failure,
minimal by moving count and then natural sum, with `d=N-1>=6`. Mixed
parity is necessary because all-odd primitive speeds already have the
half-time witness. The radius `r=1-2mu(v)` satisfies
`beta_d=(d-1)/(d+1)<r<1`.

The doubled body and coset are consistent with the predecessor:
`B_0=U([-1,1]^d)`, `C=U(1_d+2Z^d)`, and `y=U(n)` for a globally
nearest odd lift. Both body and representative are doubled, so the gauge
`||y||_(B_0)=r` is unchanged. No half factor is missing. The actual image
lattice is retained, and saturation of `Zv+Zn` is the previously proved
consequence of global nearest-point primitivity.

For `|s|<=1` and any `z in C`, reverse triangle gives
`||z-sy||>=r(1-|s|)`. Choosing `z=y` or `z=-y` gives equality, including
`s=0` and the endpoints. Since `2y in 2Lambda`, translating by `2y`
preserves `C`. This proves period two, hence the exact identity

    dist(sy,C)=r*dist(s,2Z+1)

for every real `s`. The global nearest-point condition gives the lower
bound for every coset competitor. An arbitrary locally chosen odd vector
would not justify that step.

The coordinate formula minimizes over all odd vectors and one freely
chosen original-time parameter. Attainment is explicit: write
`n=s_0*v+e`; on the fundamental interval use `m=epsilon*n` and
`t=(epsilon-s)s_0`, leaving residual `(epsilon-s)e`. Periodic translation
preserves oddness and extends the equality to all `s`. This verifies both
attainment and full competitor scope.

It does not verify a folded witness at that minimizing `t`. A direction
`a*v+2b*n` uses the linked parameters `(a*tau,2b*tau)`. The statement
about `min_t F(t,s)` therefore gives a necessary projected condition for
that line, with a separately optimized parameter. It is not a sufficient
witness condition for the line.

## The fold and its two cases

Periodicity and reflection normalize an ordinary maximizing time to
`t_* in (0,1/2)`: both endpoints have zero minimum norm, while the maximum
is positive. Hence `s_0=2t_* in (0,1)`. A nearest odd lift with residual
strictly below one satisfies `-1<n_i<v_i+1`, and thus
`1<=n_i<=v_i`. At an even original speed, oddness strengthens this to
`n_i<=v_i-1`.

Consequently `w=v-2n` satisfies `|w_i|<=v_i` everywhere and strict
inequality at every even coordinate. There is at least one such coordinate,
so the absolute speed sum strictly decreases. This bound depends on the
normalized nearest lift, not on an arbitrary odd representative.

Primitivity of `w` follows from the saturated plane and the primitive
coefficient pair `(1,-2)`. Equivalently, any common divisor of its coordinates
would divide all minors of `[w n]`, which equal the minors of `[v n]`
and have gcd one. Thus `w` is not the zero vector. Removing zero entries,
taking absolute values and deduplicating produces a nonempty primitive
positive set whose sum is strictly smaller and whose count is at most `d`.
Count or sum minimality supplies the appropriate canonical witness for
that smaller set; it supplies no failure.

When every `w_i` is nonzero, signs and repeated absolute speeds can be
restored at the same doubled ordinary time. A supplied smaller witness
therefore gives an odd full vector `m'` with residual at most
`beta_m<=beta_d<r`. Repeated coordinates receive representatives compatible
with their signs, not independent times. This remains valid when
deduplication reduces the canonical count.

### All in-plane competitors are excluded in the nonzero case

Saturation makes every integral vector in `P=span_R(v,n)` an integer
combination `A*v+D*n`. Oddness forces `D` odd at an even original
coordinate, then `A` even at an odd original coordinate. Conversely these
parities suffice. Thus every such vector is `2c*v+D*n`, which modulo
`Rw` equals the nonzero odd multiple `(4c+D)n`.

For nonzero signed speeds the gauge formula uses the denominators
`|w_i|+|w_j|`. Simultaneously changing coordinate signs reduces it to
the positive-speed interval formula and leaves the absolute numerators
unchanged. Every denominator is positive. Since the minors of `[w n]`
equal those of `[v n]` and `|w_i|<=v_i`, the gauge of `n` relative
to `w` is at least its original value `r`.

Homogeneity proves the exact restricted minimum over *all* odd vectors
in `P`: it equals `G_w(n)>=r`, since the multipliers are precisely the
odd integers and `n` itself is allowed. Every full odd vector representing
a smaller witness with residual below `r` therefore lies outside the real
plane. The strict inequality uses actual original failure and the smaller
tuple's supplied canonical margin. This is a valid strict-failure
consequence, beyond the behavior of one transported candidate.

There is no iteration invariant. That outside-plane vector need not be
nearest for the original tuple, and the smaller tuple is good. Neither
fact allows another failure-only step or forces repeated rank growth.

### Zero entries change the full problem

In the zero case, meaning `Z` is nonempty, each zero obeys the equality
`v_i=2n_i`, hence `v_i congruent 2 mod 4`. The congruence alone is not
asserted to imply a zero. At that coordinate every odd residual has
absolute value at least one, regardless of time. Taking all odd entries
equal to one at time zero attains one globally, so the full raw folded
minimum is exactly one.

Deleting those coordinates gives a different residual problem. Its
positive-tuple witness cannot fill the deleted coordinates at any radius
below one. Indeed, the linked residual `F(tau,-2tau)` is at least one
for every `tau`, whereas the freely optimized value is at most `r<1`.
This is an explicit strict difference between the linked and independently
optimized parameters.

At original ordinary time `1/4`, the deleted coordinates have norm `1/2`,
odd speeds have norm `1/4`, and speeds divisible by four have norm zero.
Thus there is no universal quarter-time restoration. The stated closed
protection radius for deleted coordinates follows from the speed-dependent
Lipschitz estimate and their maximum positive speed. It protects those
coordinates only; no supplied smaller witness or repair of the remaining
coordinates is placed inside that interval by this argument.

## Joint quantifiers, fractional candidates and the open step

For each eligible primitive parity direction, minimality supplies some
time, with that direction's own deduplicated margin. It does not supply
a common time across directions. Substitution in the ray identity gives

    dist(2b*tau,2Z+1)<=beta_m/r,
    ||b*tau|| >= (1-beta_m/r)/2>0.

The identity `dist(2u,2Z+1)=1-2||u||` verifies the rearrangement, with
closed endpoints retained. The allowed phase sets are nonempty for nonzero
`b`, so these conditions do not contradict witness existence. With `b=0`,
the primitive coefficient condition permits only the original direction
up to sign, which gives no smaller count or sum.

Subtracting an even integral multiple of `n` would preserve oddness and
leave an original-time residual. The bound excludes that exact alignment
at every supplied new witness under original failure. It does not exclude
a more elaborate transport using residual information; none is proved here.

For the fractional candidate, direct expansion yields

    n'-tau*w = ((aD-4bc)/(a+2b*s_0))*e

at the stated common time when the denominator is nonzero. The
determinant-one specialization gives candidate residual magnitude
`r/|a+2b*s_0|`. It bounds a candidate gauge and hence the global minimum
from above. It cannot give the lower bound required for failure, and the
zero-denominator case is correctly excluded.

The accepted new statements are the strict fold decrease and the nonzero
fold's outside-plane necessity. What remains is either restoration of
deleted zeros or transport of a necessarily outside-plane smaller witness.
No uniform bound `r<=beta_d`, smaller failing tuple, or rank-growth mechanism
has been established. No disconnected Lean implementation is proposed.

## Exact bindings and verification

The full current author was read. Its predecessor and projection contracts
were already read in the preceding completed audits; current readback
confirmed their unchanged bytes. All eight author input bindings match:

| Input | Actual SHA-256 |
| --- | --- |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |
| `research/astra-parity-coset-minimum-audit.md` | `b5dd0bbc3ef5d27a986a47b144e225637e338d81c6abceedc2d05d37d392a942` |
| `research/astra-parity-coset-minimum-review.md` | `fda600dd2cdbf2f470bc18e24baeab0bb4b9a90616f34b10d160ba3fa86b3360` |
| `research/astra-center-preserving-projection-audit.md` | `0efe2d8bfb272f194249e6201491a64165d6a102900a71c8953618253f18c60e` |
| `research/astra-center-preserving-projection-review.md` | `a1402e6545dd2de6a2d4b2f832b2ff13ec52f759a1ae5fb183122d1ad3d0c7e6` |

The current config, workflow, policy and focused active state were read.
Actual command in `/home/joshua/lonely-runner-formalization`:

    python3 -B scripts/validate_workflow.py

Exit status 0; complete raw output:

    workflow structural validation passed; it cannot certify mathematical validity.

Source readback used `sha256sum` on the exact paths above and the author.
Mathematical verification consisted of the independent norm, parity,
interval and integer-lattice arguments recorded here. No mathematical
program, numerical search, solver, Lean/cache operation, Git mutation,
shared-state edit or additional agent was used. Final owned-file hygiene
and hash checks are supplied to root with this frozen review.
