# Response 59 audit

Response 59 proposed two low-order deletion-pivot counting bounds, a
continuous active-maximizer route, and a prime-forcing route. Independent
mathematical review and clean-room exact enumeration accept several local
lemmas, reject both proposed uniform low-order criteria, and leave every
unrestricted bridge open.

The repository verifier for this finite audit is
`scripts/audit_response59_claims.py`. Run it directly from the repository
root:

```bash
python3 scripts/audit_response59_claims.py
```

The verifier source has SHA-256
`a5116f7d8b8d89793e62c519e8534f9aa4f222078735b4a28ce88c836645659f`.
The canonical certificate `certificates/response59_claims_expected.txt` has
SHA-256
`6f3bf3d3fa95a8b9d5c4c6228ca280c865b6eb8936f93327e9de8890ad70f2d9`.
The regression test `tests/test_response59_claims.py` has SHA-256
`ba92c89838f3fe0bce61ab1f14356087e380ac8f55b75b366ecb8a0df2afaa19`.
The verifier is deterministic and has no seed; its stdout is compared
byte-for-byte with the canonical certificate by the regression test.

## Status corrections

At the snapshot audited by the independent verifier, Lean proved only the
selected `ExceptionalGood` certificate-to-witness theorem and a wrapper
conditional on a bare selector. The bare selector omitted the documented
structural hypotheses and is false at `(1,3,4,7)`: every deletion has a
certificate but none lifts. No speed in that tuple is divisible by `N=5`, so
the tuple belongs to the separate direct `t=1/5` branch and is not an LRC
counterexample.

A later isolated formalization task records the corrected DPLP proposition
with positivity, injectivity, primitivity, height, `N`-divisibility, and all
deletion-certificate premises. That declaration is a contract, not a proof
that DPLP holds. It must not be described as a kernel-checked induction proof.

## Deletion-pivot counting

For a fixed pivot `j`, let `R_j` be its canonical deletion candidates,
`D_ji` the strict deep-bad set, and `H_ji` the closed-lower-bound shell. Let
`G_j` consist of candidates with no deep coordinate and at most one shell
coordinate.

- **D1 — proved-math.** The complement of `G_j` is exactly the union of the
  deep sets together with the candidates lying in at least two shell sets.
- **D2 — proved-math bound; uniform criterion rejected.** Union-bounding the
  deep sets and pair-counting the shell multiplicity gives the stated lower
  bound for `|G_j|`. At `(1,2,3,60)` its pivot-order lower bounds are
  `(-1,0,-9,-36)`, although pivot `60` has 24 shell-singleton lifts.
- **D3 — proved-math bound; uniform criterion rejected.** Third-order
  Bonferroni for the deep union is valid. At `(1,3,4,5,18)` every pivot lower
  bound is zero, although pivot `18` has four shell-singleton lifts.

The four speed-labelled lifts at pivot `18` are

```text
(39,5,15), (41,4,16), (49,4,16), (51,5,15).
```

The recovered script stores coordinate indices and prints `3,2,2,3` in the
middle field; Response 59 converts those indices to speeds `5,4,4,5`. Both
representations describe the same four candidates, but this distinction is
part of the provenance record.

Independent enumeration reproduced the first claimed-box D3 failure:

```text
n=3, max=20: 557 eligible tuples, no failure
n=4, max=20: 2864 eligible tuples, no failure
n=5, max=18: 266 eligible tuples before (1,3,4,5,18)
```

These are finite computations, not a uniform theorem.

## Continuous active maximizers

Let

```text
K_k = {t in R/Z : ||a_i*t|| >= 1/n for every i != k}.
```

Assume every `K_k` is nonempty and the full tuple has no `1/(n+1)` witness.
Then:

- **D4 — proved-math under these hypotheses.** Distinct `K_k` are disjoint;
  a point in two of them protects every coordinate at the stronger threshold
  `1/n`.
- **D5 — proved-math under these hypotheses.** At every maximizer of
  `||a_k*t||` on `K_k`, some other coordinate is active at exactly `1/n`.
  Compact attainment and the absence of a sub-antipodal local maximum are
  essential.
- **D6 — proved-math after hypothesis repair.** Choosing one active
  coordinate at each maximizer gives a self-loop-free finite functional
  graph, hence a directed cycle. Bare selector failure alone is insufficient.

Contrary to one independent worker's first report, an active edge does retain
canonical pivot structure. If

```text
||a_i*t_k|| = 1/n,
```

then for some integer `z`, modulo one,

```text
t_k = (n*z + 1)/(n*a_i)  or  (n*z - 1)/(n*a_i).
```

After reduction modulo `n*a_i`, its numerator is congruent to `+1` or `-1`
modulo `n`, hence is a canonical pivot candidate for deletion `k`.
Membership in `K_k` supplies every surviving closed inequality. What remains
missing is a common time or grid: different cycle edges use different pivots,
moduli, and maximizing times.

The first unsupported implication is therefore precise:

```text
Use a cycle of canonical deep deletion certificates at distinct maximizing
times, together with a global N-divisible coordinate which may not lie on the
cycle, to force an empty or shell-singleton certificate.
```

No such cross-time arithmetic comparison is known. Moreover, ruling out all
deep active cycles would directly close the residual induction branch; it is
not automatically equivalent to proving the stronger DPLP selector for every
tuple.

## Prime forcing

For `M=N*p`, define `A_i={r mod M : rho_M(r*v_i)<p}` and let `Z_0,Z_1` count
residues lying in zero or one of the sets.

- **P1 — proved-math.** If `p` divides no `v_i`, then

  ```text
  2*Z_0 + Z_1 >= 2*p - (N-1)*(N-2).
  ```

  The deletion-gcd hypotheses are not used. The tuple
  `N=4,p=5,v=(1,3,4) mod 20` has deletion gcds `(1,1,1)`, `Z_0=0`, and
  `Z_1=13`, but its bad sets cover every residue. Thus P1 reaches only an
  empty-or-singleton conclusion and does not prove prime forcing.
- **P2 — proved-math conditional.** If the residues occupy `s` sign classes,
  the strict inequality `s*(2*p+N-2)<N*p` forces an uncovered residue. When
  `2*s<N`, this is equivalent to the appropriate strict integer rounding of
  `p>s*(N-2)/(N-2*s)`. Deletion-gcd hypotheses do not force `2*s<N`, so this
  does not supply a uniform family of primes.

The first unsupported prime-forcing implication is elimination of the
singleton-bad residues furnished by P1 under the deletion-gcd constraints.

## Product-bound correction

The stray-comma exponent in Response 59 is rejected. Put

```text
C_n = binom(n+1,2)^(n-1).
```

The primary theorem of Malikiosis--Santos--Schymura bounds the subset-gcd sum
of a primitive counterexample by `C_n`; Rosenfeld states the resulting product
corollary explicitly. For positive injective speeds, strict AM--GM gives

```text
product_i v_i < (C_n/n)^n.
```

If distinct forced primes have product `Q`, then `Q` divides the speed
product. The exact sufficient integer comparison is therefore

```text
n^n * Q >= C_n^n
```

(equivalently `Q >= (C_n/n)^n` over the rationals). Weak `>=` is sufficient
because injectivity makes the opposing AM--GM bound strict. This dependency is
published mathematics, not yet formalized in this Lean project. See
[Malikiosis--Santos--Schymura, Theorem A](https://arxiv.org/html/2411.06903v2)
and [Rosenfeld, Corollary 2](https://arxiv.org/html/2512.01912v1).

## Disposition

Low-order DPLP counting, P1 alone, and P2 sign classes stop under their current
contracts. The active-cycle/canonical-endpoint lemma is reusable unrestricted
mathematics, but its cross-time cycle break remains conjectural. Uniform prime
supply remains open and retains the unformalized product-bound dependency.
Nothing in Response 59 proves DPLP, positive-integer LRC, or unrestricted LRC.
