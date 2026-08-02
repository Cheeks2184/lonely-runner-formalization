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
  strongest Lean-verified height theorem.
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
