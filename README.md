# Lonely Runner formalization

Machine-assisted mathematical research and Lean 4 formalization concerning
the Lonely Runner Conjecture (LRC).

> **Unrestricted LRC has not been proved or disproved.** A declaration named
> `Conjecture` is a formal statement under investigation, not a completed
> proof. See [STATUS.md](STATUS.md) for the current boundary of knowledge.

## Verified results

The project uses the standard closed circular-distance threshold. For `n`
moving runners, a witness time `t` must satisfy

```text
1/(n+1) <= ‖t*v_i‖_(R/Z)   for every i.
```

Fully Lean-verified results include:

- the canonical unrestricted real-speed statement and its nonnegative-time,
  relative-speed, stationary-runner, rational, and positive-integer
  formulations;
- the complete real-to-positive-integer reduction
  `conjecture_iff_positiveIntegerConjecture`;
- equivalence of the positive-integer conjecture with the exact finite
  pivot-certificate proposition;
- the one- and two-moving-runner base cases;
- several insertion, normalization, congruence, overlap, and structured-class
  theorems recorded in the [formal modules](LonelyRunner/);
- the bounded-height theorem `boundedHeight_stationary_witness`, covering
  positive injective integer speeds of maximum at most `n+2`;
- the stronger logarithmic bounded-height theorem: for `N=n+1` and `t>=1`,

  ```text
  (4*(Nat.log 2 N+1)+1)*t <= N
  ```

  and maximum speed at most `N+t` imply a common witness at the closed `1/N`
  threshold. `logarithmicHeightGain_positiveInteger_witness` supplies the
  explicit gain `N div (4*(Nat.log 2 N+1)+1)` using exactly the canonical
  `UnitCircle` norm.

`PrimorialHeight.lean` proves an exact unconditional bounded-height theorem.
Let `P_N` be the largest primorial at most `N` and `Q_N=phi(P_N)`. Lean proves
that `P_N/Q_N` is the maximum of `c/phi(c)` for `1<=c<=N`, in exact
cross-multiplied natural arithmetic. Therefore

```text
(4*P_N-Q_N)*t < N*Q_N
```

and maximum speed at most `N+t` imply a common closed `1/N` witness. The exact
largest integer gain is `(N*Q_N-1) div (4*P_N-Q_N)`. This is a verified
bounded-height result, not a proof of unrestricted LRC.

`KanoldVandermonde.lean` first gives the unconditional linear bound
`17*t<=3*N`; the coefficient-five and coefficient-four modules improve it;
`CoefficientThreeHeight.lean` is currently strongest. For
`speeds : Fin n -> Nat`, assume `n+1=N`, `t>0`, every speed is positive,
the speeds are injective, every speed is at most `N+t`, and

```text
3*t <= N.
```

Then `threeHeight_family_witness` gives one real time at which every speed has
closed circular distance at least `1/N`. The proof uses the Lean-verified
Kanold interval theorem. Under a hypothetical failure, every missing height
`c` in `[1,N]` must force the distinct occupied extra height `2*c`; the set of
missing base heights has cardinality one larger than the set of extra heights,
so this injection is impossible. Three small parameter pairs are repaired by
explicit reciprocal or complementary-hole witnesses. No number-theoretic
premise is assumed as an axiom. This remains a bounded-height theorem and does
not prove or disprove unrestricted LRC.

The strongest additional computer-assisted manuscript theorem covers maximum
speed `n+5`. Its 134,568-case finite core and uniform arithmetic proof have
been independently audited, but the combined theorem is not yet one Lean
declaration.

Claims are labelled throughout as:

- **proved-lean** — kernel-checked under the pinned dependencies;
- **proved-math** — complete manuscript proof independently audited but not
  fully assembled in Lean;
- **computed** — reproducible finite evidence only;
- **conditional**, **open**, or **rejected** — exactly as stated.

Counterexamples and failed approaches reject only their named sufficient
conditions. In particular, the exact tuple `(1,3,5,6,7)` rejects the quadratic
Chebyshev shortcut, not the full Chebyshev score and not LRC.

## Repository map

- [STATUS.md](STATUS.md): concise authoritative status and open bottleneck.
- [LonelyRunner/](LonelyRunner/): Lean definitions, equivalences, lemmas, and
  verified partial theorems.
- [proof-obligations.md](docs/proof-obligations.md): live obligation ledger.
- [manuscript.md](docs/manuscript.md): human-readable argument mapped to Lean.
- [approaches.md](docs/approaches.md) and
  [failed-approaches.md](docs/failed-approaches.md): surviving and refuted
  strategies.
- [height-logarithmic.md](docs/height-logarithmic.md): proof and audit of the
  earlier elementary logarithmic-height theorem.
- [response45-audit.md](docs/response45-audit.md): exact primorial-height
  manuscript theorem and reproducible Sol Pro artifacts.
- [response46-audit.md](docs/response46-audit.md): independently audited
  and Lean-verified roots-of-unity/Vandermonde proof of Kanold's interval
  bound.
- [response47-audit.md](docs/response47-audit.md): Lean-verified
  coefficient-five improvement, audited saturated top-two class, and
  recovered verifier.
- [top-two-pivot-search.md](docs/top-two-pivot-search.md): a sharp conjectural
  pivot restriction and its reproducible bounded stress search.
- [top-two-fractional-dual.md](docs/top-two-fractional-dual.md): a fixed exact
  fractional certificate whose proposed global extension is now refuted.
- [top-two-fractional-obstruction.md](docs/top-two-fractional-obstruction.md):
  exact weak-duality obstruction to that global fractional invariant; the
  integral top-two conjecture remains open.
- [response50-audit.md](docs/response50-audit.md): independently reproduced
  finite affine-transversal certificate for the fixed hard top pair.
- [affine-transversal-frontier.md](docs/affine-transversal-frontier.md): the
  Lean-formalized abstract bridge, empty-grid counterexample, and corrected
  disjunctive frontier.
- [coefficient-two-gamma.md](docs/coefficient-two-gamma.md): complementary
  coprime forcing, exact Hall bottleneck, finite repairs, and reproducible
  evidence.
- [computation.md](docs/computation.md): computational scope and interpretation.
- [publication-audit.md](docs/publication-audit.md): public-release privacy,
  secret-scanning, and redistribution audit.
- [certificates/](certificates/): canonical deterministic outputs.
- [scripts/](scripts/): certificate generators and exact audit commands.
- [research/sol-pro/session-001.md](research/sol-pro/session-001.md): archived
  GPT-5.6 Pro prompts, responses, objections, and revisions.
- [research/lean-build-log.md](research/lean-build-log.md): clean-build history.

## Reproduce the project

The repository pins Lean and mathlib to `v4.32.1`. The committed Lake manifest
pins mathlib commit `520045ab14e26149ee970e2e617ca04b09bde5d6`.
The current clean mathematical source checkpoint is
`9d45be484cb7dd91b4228e44ded7e66a9006e616`; see
[STATUS.md](STATUS.md) for its exact build, trust, and test results.

Install [Elan](https://github.com/leanprover/elan), clone the repository, and
run from its root:

```bash
lake exe cache get
lake build
python3 scripts/audit_lean_trust.py
python3 -m unittest discover -s tests -v
```

The trust audit runs `LonelyRunner/AxiomAudit.lean`, rejects placeholder or
unsafe source constructs, and permits only Lean's standard `propext`,
`Classical.choice`, and `Quot.sound` axioms.

Important individual certificates can also be replayed directly:

```bash
bash scripts/audit_logarithmic_height.sh
bash scripts/audit_height_n_plus_5.sh
bash scripts/audit_quadratic_chebyshev_failure.sh
bash scripts/audit_response44.sh
bash scripts/audit_response45.sh
bash scripts/audit_response46.sh
bash scripts/audit_response47.sh
bash scripts/audit_response50.sh
bash scripts/audit_coefficient_two_gamma.sh
bash scripts/audit_top_two_pivot_search.sh
bash scripts/audit_top_two_fractional_dual.sh
bash scripts/audit_top_two_fractional_obstruction.sh
bash scripts/audit_response42_cheb_multi.sh
bash scripts/audit_residual_compatibility_family.sh
```

The optional several-minute lower-dimensional calibration is:

```bash
bash scripts/audit_quadratic_chebyshev_calibration.sh
```

GitHub Actions runs a cached Lean build, the trust audit, and the complete
deterministic Python regression suite. The authoritative local standard remains
a clean ext4 checkout with the commands above; latest recorded results and
tool versions are in [STATUS.md](STATUS.md).

## Current research frontier

The exact unresolved step is the uniform positive-integer pivot-certificate
proposition: prove that some pivot candidate escapes all strict modular bad
sets for every positive injective integer tuple, or refute that exact
proposition. Current work attacks stronger explicit height bounds, the full
Chebyshev/CRT score, and corrected least-dimension residual restrictions.

## Public-release safety

The publication checkpoint was scanned with history-aware Gitleaks v8.30.1
and a separate manual history/current-tree audit. Local Lake builds, Python
caches, virtual environments, scratch work, credentials, browser/session data,
and verification clones are excluded by `.gitignore` and are not part of the
repository.

## License

No software or documentation license has been selected. No permission beyond
what applicable law already grants should be inferred from publication.
