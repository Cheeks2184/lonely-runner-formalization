# First authorized Astra research checkpoint

The full canonical Lonely Runner proof/disproof goal is active and **not
complete**. This pass adds four checked auxiliary declarations; none inhabits
`LonelyRunner.Conjecture` or its negation. It builds on source `ec30e17` with the
pinned Lean/mathlib versions unchanged. All work remains local.

## Kernel-checked additions

`LonelyRunner/OwnerKernelBound.lean` proves:

- `normalizedBadCount_ownerKernel_bound`: for `N>=2`, `P>0`, positive `k|N`,
  the normalized bad count satisfies
  `N*b <= 2*(N-1)*P + (N-2)*(k-1)`.
- `pivotBadResidues_ownerKernel_bound`: for an actual lower owner `0<d<p`,
  `N*card(B_d) <= 2*(N-1)*p + (N-2)*(gcd(d,N*p)-gcd(d,p))`.

The second theorem constructs the gcd normalization and proves its transport;
it does not assume a witness, complete cover, or the intended inequality.
The zero-fiber interpretation, its cardinality as a named finite set, equality
classification, and family noncover theorem are separate remaining formal tasks.

`LonelyRunner/AffineAvoidance.lean` proves:

- `affine_avoidance_of_slope_product`: over an odd prime field, a family of
  `p-1` nonzero slopes of product `-1`, with both zero and nonzero offsets,
  admits nonzero `r,s` for which every `s*v_i+r*a_i` avoids `0,-1`.
- `affine_avoidance_card_sub_two`: for `p-2` nonzero slopes, the same conclusion
  needs no slope-product or offset restriction. Repeated slopes are allowed.

The polynomial sum, unit bijection, cardinality contradiction, and dummy-row
corollary are proved internally. This extends a finite-field argument identified
in the established modular research route; mathematical novelty is not claimed.
No integer-grid bridge or uniform prime supply follows automatically.

Both modules are imported by the root, and all four public declarations are
included in `LonelyRunner/AxiomAudit.lean`.

## Reviewed mathematics and rejected shortcuts

The owner argument separates zero-product residues from nonzero bad residues.
For `c` lower owners, let `q` selected zero kernels dominate all other nonempty
zero kernels. The independently reviewed manuscript proves noncover if

```text
2*(N+1)*c + (N-2)*q <= N*(N+1).
```

The literal fixture `N=11,p=72,C=(22,33,55,66,70)` has 256 safe candidates.
It satisfies the new criterion while old density, exact summed capacity, and
common-endpoint correction alone fail to certify noncover. The manuscript and
independent review preserve exact positive/negative fixtures and reproduction
code in `research/astra-owner-route.md` and `research/astra-owner-review.md`.
The criterion itself is not yet a Lean theorem.

The pivot analysis gives an infinite family showing that endpoint-exit search
cannot have a step bound depending only on runner count. Its explicit witnesses
also show that this is an algorithmic obstruction, not an LRC counterexample.
See `research/astra-pivot-route.md`.

A proposed zero-separated pair-tree method with one dominating kernel was
proved to be subsumed by the repository's existing two-parent certificates.
That comparison prevents spending another search pass on a redundant method.
The regime with multiple dominators and incompatible ordering constraints is
not resolved by that comparison.

The literature check records the new fourteen-total-runner preprint, without
promoting its external computations to project evidence. See `docs/literature.md`.

## Verification and provenance

- Full integrated `lake build`: passed, **3,596 jobs**.
- `python3 scripts/audit_lean_trust.py`: passed, **319 theorem reports**, using
  only `propext`, `Classical.choice`, and `Quot.sound`.
- In-session Astra Extra High independently reviewed the mathematical contracts
  and compared all four final Lean declarations and the normalization adapter.
- Focused workflow/historical-ledger tests: **32 passed**. A setup-gate test
  incorrectly inherited the now-active research phase; it now uses an explicit
  setup fixture and also tests a valid start transition. Validator rules were
  not weakened.
- No full deterministic Python rerun was needed for these Lean additions and
  the isolated test-fixture correction. The prior 191-test baseline remains
  separately documented; it is not relabelled as a new full-suite run.

Terra Medium performed the owner formalization, cache/API support, and the
fixture repair. The affine proof was explicitly escalated to Astra Extra High
when Terra's support stopped short of its semantic core. Requested model and
work ownership records remain in `research/workflow-state.json`; unexposed
observed-runtime metadata remains null.

## Exact next obligations

1. Formalize zero-residue finite-set cardinality, its capacity bound, kernel
   containment, and the reviewed labelled family noncover criterion. Reuse the
   existing residue and ordered-union machinery.
2. Develop a checked integer-grid application of affine avoidance, keeping the
   external-prime and field-characteristic roles distinct. Test whether it
   improves an existing route before claiming additional reach.
3. Investigate dense internal covers violating the new criterion. They still
   require a uniform nonzero-overlap theorem, a valid pivot transformation, or
   another substantive arithmetic mechanism. Finite verification and the new
   local sufficient condition do not discharge this remaining existential.

The shared pinned build cache is retained for the immediately queued formal
obligations. Download archives may be removed after decompression and the idle
verification checkpoint. Source, unique evidence, and the installed toolchain
must remain. A failed branch or this checkpoint is not the end of the goal.
