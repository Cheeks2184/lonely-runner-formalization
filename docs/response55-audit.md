# Response 55 audit

Response 55 was generated in the separate ChatGPT conversation with the
`Pro` and `GPT-5.6 Sol` controls selected. The recovered response has 23,629
characters, 23,762 UTF-8 bytes, 1,126 line feeds, a final line feed, and
SHA-256
`51b41a34e7f17025ee1e0fa03ccde2f9cb0f0cd9d64ca039a04fd2a256b5952a`.

No claim below is accepted merely because it appeared in that response.

## Exact recovered artifacts

The diagonal verifier is preserved byte-for-byte as
`research/sol-pro/artifacts/response55_diagonal_hall_counterexample.py`:

```text
bytes: 4733
SHA-256: c640d591c6e15b6b53dc91adc629e73ff244e1c273a4b08aa9423efcf5663f8e
```

Its reproduced output has 687 bytes and SHA-256
`8ff94b024f96bc3c255d678751d1234927827ec2038688cbd89835b7615be43a`.
It correctly finds the first failure of the globally feasible diagonal union
at `(N,t)=(32,16)`, where four candidate rows are empty, and verifies an
explicit full-Gamma SDR. An independent stronger certificate finds the first
such failure with every diagonal row nonempty at `(36,16)`. Its source and
expected-output SHA-256 values are
`401a1323c2939c81507fbcd94a0ad7e9a588b4a0bfbe7c58d750bf2e69004937`
and `be8329bde9243a7baea21ed9e92e870d401bbb388267bf3087a05405ef36ec2e`.

The three Lean attachments are also preserved exactly:

| artifact | bytes | SHA-256 | exact compiler result |
|---|---:|---|---|
| `response55_PartialMatchingDichotomy.lean` | 3543 | `ffe1cd407e214c499680a36e64e7f018f10f85ac8d729a51c3123d965e2b3c2f` | compiles; two unused-variable/section warnings |
| `response55_CoefficientTwoFeasibleStarts.lean` | 5664 | `28a555c98bf226d815a82123bc0eec8c260ba003f16956de97a27c0f92cd9cb3` | fails at lines 98, 107, 141, and 146 because `dsimp` makes no progress |
| `response55_TightBlockRematching.lean` | 2831 | `07c46c6a0bc8216b55e71d08a73035ac56ca62797cd4611782db967bc0374d6e` | compiles; one unused-section warning |

Removing only the four redundant `dsimp` commands repairs the feasible-start
attachment. The tracked `CoefficientTwoFeasibleStarts.lean` module proves its
exact interval theorem. The tracked `PartialMatchingDichotomy.lean` removes an
unused hypothesis, thereby validly generalizing the theorem, and removes
warning noise without changing its conclusion.

## Accepted graph mathematics

The response's tight-block results G1--G4 are correct.

- Every saturating matching maps a tight left block bijectively onto its full
  neighborhood. Rematching therefore cannot dissolve a tight block.
- Contracting a nonempty proper tight block from an inclusion-minimal
  deficiency-one core leaves another inclusion-minimal deficiency-one graph.
- Repeated tight contraction terminates by strict decrease of the left
  cardinality and produces a core whose every proper nonempty subset has
  strict Hall expansion.
- In such a strict critical core, a deletion-perfect matching rooted at the
  deleted vertex has a dependency reachability set spanning every left
  vertex.

A stronger, independently developed theorem is now Lean-verified in
`MatchingContraction.lean`. For any supplied injective left-saturating
matching, the complete set of vertices that do not reach a marked vertex is
tight. Deleting it and its matched image leaves an induced residual graph with
an injective saturating matching and strict Hall expansion on every nonempty
left subset. This is an abstract decomposition theorem; it neither proves the
tight block empty nor constructs the original Gamma matching.

The response's exact total-layer decomposition H1 is also correct: every
Gamma edge has the unique total `Q=c+d`, and each fixed-total coprime layer is
an injective partial matching. The new obstruction shows that restricting to
totals feasible for the entire generic band is too severe.

## Accepted strip and translation lemmas

The prefix/suffix strip capacities I1, prime-cover union bound I2, and
cross-cut lcm witness I3 are valid at their stated strengths. They use the
dual strict Hall inequality and connectedness of a minimal deficient core.
They do not synchronize prime support across different candidates.

The two-translation class J1 is also sound. On candidates `c<=t`, the image
`N+c` lies in Gamma under `gcd(c,N)=1`; on candidates `t<c`, the image
`N-t+c` lies in Gamma under `gcd(c,N-t)=1`. Each branch is injective, and the
explicit exclusion `c1!=c0+t` removes cross-branch collisions. These
hypotheses are only a sufficient class and are not known uniformly.

## Exact surviving gaps

`DIAGONAL-HALL` is rejected, not open. The response's replacement questions
are exact but unproved:

- `GAMMA-ATOMIC-EXCLUSION`: rule out an atomically critical contraction
  residual using Gamma arithmetic even though contraction destroys the clean
  interval form;
- find an arithmetically controlled family of total layers using useful
  non-diagonal edges;
- `CUT-OR-STRIP-OVERLOAD`: synchronize strip prime covers and cross-cut lcm
  witnesses;
- extend the two-translation class through its gcd failures and cross
  collisions.

The response does not prove exact Gamma Hall, coefficient two in every
dimension, top-two, or unrestricted Lonely Runner.
