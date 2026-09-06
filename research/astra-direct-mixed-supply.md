# Mixed-margin supply for a one-deletion family

2026-09-05. Requested Astra/xhigh task
`/root/cluster_limit_review-direct-mixed-supply`, assigned checkpoint
`1412a65421d2b0898f7dc28fd1b6f3b736131d33`. Runtime model/effort metadata is
not independently exposed. Current project configuration, workflow, policy and
state were read; `python3 -B scripts/validate_workflow.py` passed. Research is
authorized and the canonical goal remains unresolved. Only this manuscript is
owned and written by this task.

**Disposition: the entire assigned structured family has an explicit mixed
witness, by the manuscript proof below; independent review is pending.** The
direct reciprocal branch fails throughout the family, but the necessary mixed
target always survives. This rules out this family as a source of an empty
mixed-good-set obstruction. It does not, by itself, prove exact packet supply,
the direct-or-exact union for arbitrary tuples, or unrestricted LRC. No novelty
claim is made. No computational search or numerical verification was used to
derive or prove the result.

## Exact quantified statement

Let N and a be integers with

```text
N>=4, 2<=a, 2a<=N,
W={1,2,...,N} minus {a}.
```

There are exactly N-1 positive distinct moving speeds, the stationary chosen
runner is zero, the fastest speed is H=N, and the full tuple is primitive
because speed 1 is retained. For every integer d with `2<=d<=N`, some speed
in W is divisible by d: use speed d if `d!=a`, and speed 2a otherwise.
Thus there is no direct reciprocal witness of the specified form `1/d`
with `2<=d<=N` dividing none of W.

Nevertheless, there is a positive rational T, in fact `0<T<1`, such that

```text
||k*T|| >= 1/N       for every k in W,
||N*T|| >= 1/(N-1).                                  (M)
```

Here `||x||` is distance to the nearest integer and every displayed target
is closed. The following formulas supply such a T, for **either** sign:

```text
If N>=2a+1:
    T = 1/a ± 1/(2aN).

If N=2a:
    T = 1/a ± 1/[N(N-1)].                            (1)
```

More generally, in the first case every real epsilon in the certified closed
interval

```text
1/(2aN) <= epsilon <= (N-1-a)/[a*N*(N-1)]             (2)
```

gives a witness `T=1/a ± epsilon`; rational epsilon gives rational T. This is
a sufficient interval, not a claim to classify every mixed witness time. Its
width is

```text
(N-1-2a)/[2a*N*(N-1)].
```

It is therefore nonempty when `N>=2a+1`, a singleton at `N=2a+1`, and has
positive width when `N>=2a+2`. The separate `N=2a` line in (1) is necessary
for these particular formulas: blindly using the first line there gives
fastest-coordinate norm `1/N`, which misses the mixed target `1/(N-1)`.
That formula failure is not a failure of (M).

## Proof

Two elementary circle-norm facts suffice. Integer translation and sign
reversal preserve the norm, and

```text
||x+z|| >= ||x||-|z|.
```

For integral k not divisible by positive integer a, the nonzero residue of k
modulo a lies between 1 and a-1, so `||k/a||>=1/a`. For `|z|<=1/2`,
`||z||=|z|`. These facts justify the estimates below without assuming that a
perturbed nonintegral phase remains in the same linear piece of the norm.

First suppose `N>=2a+1` and take epsilon in (2). Then

```text
epsilon >= 1/(2aN)>0,
N*epsilon <= 1/a-1/(N-1) < 1/a <= 1/2.              (3)
```

The upper bound in (2) is at least the lower bound precisely because
`N-1>=2a`. Fix either sign sigma in `{+1,-1}` and put
`T=1/a+sigma*epsilon`.

If a divides a retained speed k, write `k=j*a`. Positivity of k gives
`j>=1`, and removal of a excludes j=1; hence `k>=2a`. Since `k<=N`, (3)
puts `k*epsilon` strictly below 1/2. Integer translation and sign reversal
therefore give the **exact** value

```text
||k*T|| = ||j+sigma*k*epsilon|| = k*epsilon
        >= 2a*epsilon >= 1/N.                        (4)
```

If a does not divide k, use the nonzero-residue bound and the norm's
Lipschitz inequality:

```text
||k*T|| >= ||k/a||-k*epsilon
        >= 1/a-N*epsilon
        >= 1/(N-1).                                 (5)
```

This is stronger than the ordinary closed threshold. It includes the fastest
speed when a does not divide N. If a does divide N, (4) gives instead

```text
||N*T|| = N*epsilon >= 1/(2a) >= 1/(N-1),
```

where the last comparison again uses `N-1>=2a`. Thus all comparisons and
the extra endpoint margin hold for the same T, for both signs and throughout
the closed interval (2).

Now suppose `N=2a` and take `epsilon=1/[N(N-1)]`. The only positive multiples
of a at most N are a and N, and a is deleted. Therefore the only retained
multiple is the fastest speed, for which

```text
N*T = 2+sigma/(N-1),
||N*T|| = 1/(N-1),                                  (6)
```

because `N>=4` implies `1/(N-1)<=1/3<1/2`. Every other retained k is a
nonmultiple with `k<=N-1`. Hence

```text
||k*T|| >= ||k/a||-k*epsilon
        >= 1/a-(N-1)/[N(N-1)]
        = 2/N-1/N = 1/N.                            (7)
```

This proves (M) in the boundary case too. It preserves equality: for example,
with the plus sign, speed `N-1` has norm exactly `1/N` in this boundary
family, while the fastest speed has norm exactly `1/(N-1)`.

Finally, in both cases `0<epsilon<1/(aN)`. For the boundary case this follows
from `a<N-1=2a-1`; for the other case it follows from the strict inequality
in (3). Consequently

```text
0 < (1-1/N)/a < T < (1+1/N)/a <= 5/8 < 1.
```

Thus both returned times are positive and lie strictly inside one period.
Formula (1) is rational, so no approximation or density argument is needed.
The proof uses neither a lower-count hypothesis nor a collision packet.

## Known controls and source overlap

For `(N,a)=(4,2)`, formula (1) yields `5/12` and `7/12`, with endpoint norm
`1/3`. For `(N,a)=(5,2)`, it yields `9/20` and `11/20`, with endpoint norm
`1/4`. These are the stipulated mixed witnesses for `(1,3,4)` and
`(1,3,4,5)`. For `(N,a)=(6,3)`, the boundary formula yields `3/10` and
`11/30`. These explicit values are algebraic substitutions in the formulas;
no numerical control program was executed in this task.

The root supplied the plus-sign formula and its circle-norm estimates. This
task independently derived the minus-sign formula, then checked that the same
Lipschitz proof supports both signs and the wider closed epsilon interval.
The proof above is self-contained. It must still receive the separately
assigned independent semantic review before promotion.

The source check confirms that ordinary stationary witnesses on this entire
family are already covered by
`LonelyRunner.boundedHeight_stationary_witness`, in
`LonelyRunner/BoundedHeight.lean`: it takes n positive injective integer speeds,
`n>=3`, each at most `n+2`, and returns a common closed `1/(n+1)` witness.
Here `n=N-1` and `H=N<=N+1=n+2`. Its displayed conclusion does not give the
additional fastest-coordinate margin `1/(N-1)`.

`LonelyRunner/StructuredClasses.lean` supplies a generic closed residue-band
criterion, including `circleNorm_ge_of_int_band` and
`minimumScaleResidueBands`. It does not state the family theorem (M).
`LonelyRunner/FastRunnerInsertion.lean` already proves integer periodicity,
the small-absolute-phase identity, and
`circleNorm_sub_abs_le_circleNorm`. Those are compatible with the elementary
norm reasoning used above; no new Lean declaration or build is claimed.
The audit checked these interfaces and their source, not all historical
literature or every potentially equivalent theorem in the repository.

| Read-only source/evidence | SHA-256 |
| --- | --- |
| `LonelyRunner/StructuredClasses.lean` | `5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c` |
| `LonelyRunner/BoundedHeight.lean` | `681c38dae0158ffd4162fa471c429dea4e8b90e27ee6e3a6fdf7b3cbd6e47ecc` |
| `LonelyRunner/FastRunnerInsertion.lean` | `dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5` |
| Frozen two-anchor contract | `ba16410bdd0ca08262573fbfa36d6e46078a7b3910f68e7593318dea63d78c3c` |
| Frozen contract review | `37c5d7c39c24e3153d29008ebcccaa6e6141756b6ae0138f61d9c7c548840435` |
| Unchanged conditional constructor `research/astra-exact-affine-union-audit.md` | `a44b368e25bd88084ff7cd1d0098e912d452e77d28af7743a1b9f4d43c5be5b2` |

This manuscript does not use or assert a converse from mixed-witness existence
to exact S. Any combination with the separately reviewed anchor lemma and
constructor must retain their own hypotheses and review status. In particular,
the present family result is not a universal supply theorem on arbitrary
primitive speed sets, and does not make a statement about an actual minimal
counterexample to LRC.

## Settled routine-control specification

Per the assigned routing, the following exact specification was sent to the
root for a separate Terra control artifact. It is **not** recorded as executed
or passed here. The root can review this frozen proof independently of that
routine replay. Use only Python standard-library `Fraction` arithmetic; no
floating point, sampling, optimization, tuple discovery, Lean, or cache work.

Use exactly these eight parameter pairs:

```text
(4,2), (5,2), (6,3), (7,3), (8,3), (8,4), (11,3), (12,5).
```

For each pair form W literally as the integers 1 through N with a removed.
Check its cardinality N-1, positivity, distinctness, maximum N, and gcd 1.
For each `d=2,...,N`, verify the explicit divisibility witness d when `d!=a`
and 2a when `d=a`; do not search for a divisor witness.

When `N=2a`, use only `epsilon=1/[N(N-1)]`. Otherwise use the lower endpoint
of (2), its upper endpoint, and their arithmetic midpoint, deduplicating equal
values. For each epsilon and both signs:

1. Form T exactly and check `0<T<1`.
2. Check `||k*T||>=1/N` for every retained original speed k.
3. Check `||N*T||>=1/(N-1)` at that same T.
4. For every multiple of a, verify `||k*T||=k*epsilon`, with
   `0<=k*epsilon<1/2`.
5. In the nonboundary branch check every nonmultiple's stronger
   `||k*T||>=1/(N-1)` bound. In the boundary branch check the fastest
   equality `||N*T||=1/(N-1)`.
6. Emit the exact epsilon, T, all norms, and count information in deterministic
   order so another reviewer can replay the same finite controls.

The positive domain has **28 time controls, 218 retained coordinate/time
comparisons, and 53 divisibility facts**. These are counts of the settled
domain, not observed execution counts. Five parameter pairs have one epsilon;
the three pairs `(8,3),(11,3),(12,5)` have three. Each epsilon has both signs.

Also check these four named negative-formula controls, for both signs:

- At `(4,2)` and `(6,3)`, use the unadjusted epsilon `1/(2aN)` instead of
  the boundary formula. Ordinary closed `1/N` inequalities still hold, but
  the fastest norm is exactly `1/N<1/(N-1)`.
- At `(5,2)` and `(7,3)`, use epsilon `1/(4aN)`, below the lower endpoint.
  The retained speed `k=2a` has norm exactly `1/(2N)<1/N`.

These are eight negative time evaluations. They demonstrate failure of the
altered formulas, without changing any claim about existence of correct
witnesses. Save the eventual routine program, its exact source/domain,
stdout and their hashes in a separately owned artifact. The numeric replay
does not replace the quantified proof above.

## Commands, scope and freeze

Commands in this task were instruction/policy/state reads, successful workflow
structural validation, focused `rg`/`sed` source inspections, source SHA-256
checks, and writing/readback of this sole owned manuscript. One initial rg
call also named a nonexistent `LonelyRunner/ThreeShortInterval.lean` and
returned exit 2; the relevant existing height interfaces were then read
directly. No mathematical test program was run, so no numerical verification
result is claimed. The exact fixed-control specification has been delegated
by the root to a later separate routine task.

The previously frozen constructor was read/hash-checked and remains unchanged.
No source, state, Git, cache, dependency, or other manuscript was modified.
All owned commands are stopped at freeze. The final SHA-256 is reported to
the root separately. The next actions are independent semantic review and
the separately recorded routine replay. The original research goal remains
active and unresolved beyond this precisely supplied structured family.
