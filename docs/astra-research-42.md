# Forty-second Astra checkpoint: constrained maximizers and phase-certificate transfer

The exact reviewed P/M/D contracts now have Lean proofs, root imports and
explicit axiom-audit entries. The full build and trust audit pass, as do
independent source review and the root replay of its frozen probe.
The generic phase-certificate transfer also passes independent and root
verification. These are supporting results; no new runner count is proved.

## Mathematical changes

`ConstrainedMaximizer.lean` proves four public statements:

- `circleNorm_eq_min_fract` gives the exact norm formula at arbitrary real phases.
- `exists_forward_complement_improvement` preserves closed safety of every
  other label while strictly improving a distinguished phase below one half.
  Its complement phases may start on the lower boundary but must be strictly
  below the upper boundary.
- `exists_oriented_complement_maximizer` assumes positive natural speeds, a
  strict complement seed, margin in(0,1/2), and absence of a full closed
  witness. It supplies a positive time below1, global maximality over all
  real feasible times, positive distinguished phase below the margin, and an
  actual other label exactly on the upper fractional boundary.
- `reciprocal_dilate_shift_improves` handles N>=3, N dividing d,
  2<=alpha<N and every integer beta, with distinguished phase in(0,1/N).

The finite label type is arbitrary and repeated speeds are allowed.
Compactness is applied to the closed safe set; periodicity gives global
maximality, and reflection uses the distinguished phase. The strict seed
hypothesis is retained. D checks both branches of the circle norm and does
not assume monotonicity after crossing one half. Terra supplied the initial
norm helper; root completed P/M/D after the bounded worker handoff returned
without those proofs. The independent reviewer did not author this Lean source.

`RenaultPhaseCertificates.lean` defines the exact23-candidate `PhaseGood`
predicate for Renault5.1 and proves `phase_certificate_sound`. This is a
generic transfer from supplied120-atom partition and bit-soundness proofs,
mask domination, and sorted core-triple coverage to three normalized real
phases. Six order cases retain ties. The premises have not been discharged
for the concrete table in this checkpoint; this is not yet Renault5.1 in Lean.

## Finite evidence and kernel boundary

The predeclared exact Python discovery and separately executed fixed verifier
agree on120 atoms,98 distinct masks,41 minimal masks and12341 sorted triples.
The frozen certificate, complete receipts, programs and independent review
are retained. Root independently replayed the fixed verifier and the generic
Lean contract probe, with actual exit0 for both. The verification does not
turn external numerical output into a Lean theorem.

A separate fixed first-row pilot checks861 ordered pairs in Lean using only
`propext`. Its source and actual successful receipt are retained. It proves
one row only. The full concrete mask table, common-bit extraction, real
atom partition and band soundness, periodicity and final application remain
subsequent implementation obligations. Renault6.1 and6.4 have different
candidate/strictness contracts and remain separate.

## Verification and runtime evidence

The final focused maximizer build exited0 with1844 jobs. Full root build
exited0 with3661 jobs. Source/trust audit exited0 with558 dependency reports
and3 axiom-free declarations, using only `propext`, `Classical.choice`, and
`Quot.sound`. Six new public declarations are explicitly audited.
The frozen maximizer replay checks four complete universal signatures,
fixed boundary/repeated-input/signed-shift controls, and all four axiom lists.
Root replay exited0 with identical428-byte axiom stdout. The phase transfer
review checks its complete universal contract and candidate decoding.
Exact hashes and actual execution records are in the verification JSON.

Initial2GiB virtual-address caps prevented Lean startup;4GiB allowed startup
but exhausted import mappings. Capped traces identify failed mmap calls,
and the named import files exist and are readable. Identical fixed probes
passed after a documented8GiB virtual-address correction with CPU/wall
limits unchanged. Failed launches and probe-only arithmetic normalization
errors are preserved and never counted as successful verification.
The first-row pilot completed in1.83seconds at peak child RSS1581704KiB.
The8GiB value is an address-space cap, not measured physical usage.

## Publication and next work

Pass41 was merged as PR40 at a39edc784be728b127aac6387277205136407c01
after both required checks passed; remote main ancestry and local main were
verified. This checkpoint is ready for its authorized publication sequence.
The all-row kernel implementation and divisor/real-phase manuscripts are
separate ongoing work. The shared cache remains needed by those tasks; no
duplicate cache or unrelated cleanup was performed. The unrestricted
Lonely Runner goal remains active and unresolved.
