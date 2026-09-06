# General-prime digit selection and anchored compression implementation

Status: the exact F/C and signed-adapter declarations compile with the pinned
Lean/mathlib dependencies. The full root build and trust audit passed. Independent
frozen-source review and root replay also passed; the checkpoint is ready to publish.

Base main: `f1d45fdf95af26f31cffcc92485fc5951c4b0169` (Pass40, PR39).
The accepted manuscript is `astra-prime-difference-compression-plan.md`
(`ee396d22cae90460868ee13ba70c26204cafad190aea3b72835680218b3c88c2`),
independently reviewed in `astra-prime-difference-compression-review.md`
(`a3a77cdfbc4f983755d38bd75a7aad6ccdeb4534d5c1ec455dfce0320c1d4947`).

## Exact scope and proof

`primeAdic_two_distinct_targets` retains arbitrary prime p, m including zero,
positive-unit factorizations at two distinct live levels at most m, arbitrary
prescribed digits below p, and a nonzero target at any top level. It returns
a positive multiplier below p^(m+1), prime to p, with both exact digits.
The higher level is solved first: a nonzero scalar at the top, or a correction
below it. The lower correction uses the **current** multiplier times the unit
coefficient. It preserves the higher product's entire next-power residue.
Reducing the final product of units supplies the positive bounded representative.
The proof includes both level orderings. No top correction `1+k` is assumed a unit.

`primeAdic_triple_compression` retains the reviewed natural definition of
oriented difference `(a%P+P-b%P)%P`. Its premise permits a collapsed difference,
or two live differences with unequal levels. It imposes no unit, distinctness,
same-class or input-height condition on the original three coordinates.
Each live difference is sent to digit p-1; collapsed differences remain zero.

The source proves the manuscript's closed anchored-interval consequence via an
equivalent addition argument. The oriented difference plus anchor is the original
residue modulo P. Multiplication preserves that identity. In `Nat.add_div`, adding
a last-digit value has carry zero or one, so the resulting digit is the anchor's
cyclic predecessor or the anchor itself. This includes the closed endpoint -p^m
from the manuscript and both collapsed differences without signed subtraction.
The implementation does not assert the paper proof's stronger all-ordered-
differences digit claim, which earlier fixed evidence refuted.

`signedPrimeAdicDigit` uses `Int.natMod`, with integer modulus p^(m+1).
`signedPrimeAdicDigit_mul` proves multiplication commutes with this residue
adapter at the digit level. `primeAdic_triple_compression_int` applies the exact
natural theorem to the three Euclidean residues, retaining the oriented reduced
separation hypothesis. Negative inputs are not replaced by absolute values.

These arithmetic results do not prove simultaneous safety for arbitrary runner
families, eliminate same-level obstructions, supply the missing five-moving
1/6 or six-moving 1/7 integer cases, or resolve the unrestricted conjecture.
All existing FiveAdic and canonical source files are unchanged. The root imports
the two new modules and AxiomAudit includes every new public theorem.

## Authorship and recovery

Terra/medium implemented and compiled the prerequisite arithmetic file. Its
subsequent bounded F assignment returned unchanged source, citing remaining
context/runtime. A second Terra/medium worker created only a module shell and
also returned without a proof. The actual goal was read back as active after
each interruption. Root retained the helpers and completed the F/C/integer
assembly locally, without weakening the reviewed contracts. Runtime provenance
is reported as requested routing, not independently attested model metadata.

## Executed verification

The shell commands were executed with actual exit codes captured by the tool;
none of the successful outcomes below is inferred from a log hash alone.
Routine failed intermediate compiler attempts were corrected before the final
focused and full build. No search or new numerical enumeration was performed.

```bash
export PATH="$HOME/.elan/bin:$PATH"
lake build LonelyRunner.PrimeAdicCompression
lake build
python3 -B scripts/audit_lean_trust.py
```

Final focused build: exit 0, `Build completed successfully (3002 jobs).`
Full root source build: exit 0, `Build completed successfully (3659 jobs).`
Trust scan and explicit axiom audit: exit 0, `Trust audit accepted 552 theorem reports.`
The audit also emits three axiom-free declarations, for 555 total declarations.
Only `propext`, `Classical.choice`, and `Quot.sound` occur. All twenty new
public theorem reports are reproduced below.

```text
'LonelyRunner.primeAdicCorrection_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.primeAdicCorrection_mod_prime' depends on axioms: [propext, Quot.sound]
'LonelyRunner.primeAdic_residue_decomposition' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.primeAdicCorrection_selected_product' depends on axioms: [propext]
'LonelyRunner.primeAdicCorrection_selected_digit' depends on axioms: [propext]
'LonelyRunner.primeAdicCorrection_higher_residue' depends on axioms: [propext, Quot.sound]
'LonelyRunner.primeAdicDigit_of_mod_eq' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.primeAdic_unit_representative' depends on axioms: [propext]
'LonelyRunner.primeAdic_positive_bounded_residue_decomposition' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'LonelyRunner.primeAdicCorrection_exists_target' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.primeAdic_top_exists_target' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.primeAdicCorrection_not_dvd' depends on axioms: [propext, Quot.sound]
'LonelyRunner.primeAdic_one_target_unbounded' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.primeAdic_two_distinct_targets' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.primeAdicDifference_add_anchor' depends on axioms: [propext, Quot.sound]
'LonelyRunner.primeAdicDigit_add_last' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.primeAdic_zero_or_last_target' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.primeAdic_triple_compression' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.signedPrimeAdicDigit_mul' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.primeAdic_triple_compression_int' depends on axioms: [propext, Classical.choice, Quot.sound]
```

Frozen source SHA-256 values:

```text
78387d8bb606398f240d435df8e5874259f9fb782f0ebc21830905efdc57edf6  LonelyRunner/PrimeAdicArithmetic.lean
bd9f20169c49ac00acf6d27a53109d0d8770f2b224bf29f65d8ff76db8102eda  LonelyRunner/PrimeAdicCompression.lean
c4cdec234819184d3df0d376e1bf2111dd3ccadbd930a31fb073aa0b98e717d3  LonelyRunner.lean
9f449224e85ed16ac3e3131c43d27ad78eddb05b8d1ce56e6958b6731c460e03  LonelyRunner/AxiomAudit.lean
```

Execution log SHA-256 values (logs are rebuildable):

```text
3fb3ff3dc6964c393c0abb5db9c680acee7756c02f2042ee2fe0e73eb87cdeda  /tmp/astra-pass41-int-build.log
9ff063201366984e55b495805547ea2dbdcfdd1d279e50229ff8a7aae04a8aef  /tmp/astra-pass41-full-build.log
abab152a233bc26a3e1cccdfa370fc9f8cfd3f0836a0f65f2c9a9c3083a5effc  /tmp/astra-pass41-trust.log
```

## Independent review and root replay

`astra-prime-adic-final-source-review.md` (SHA-256
`687ea1cd302b3ce741ee67cf4045c828e755ed986db3993c6dba06f026aecd8d`)
accepts every exact contract and contains the full executable Lean probe and
actual author receipts, including earlier probe-only failures. Root read the
whole report and replayed the final bash fence verbatim: exit 0, fifteen
before/after source guards, twenty-eight allowed axiom reports, and exact
2,750-byte Lean stdout SHA-256
`5df227e79508b513cd76296cea3180a5f9d99153f06c3435ea6fa285fe969642`.
The probe includes universal F/C/integer and Fin4/Fin5 compatibility types,
five fixed target pairs, eight boundary/signed triples, both carry branches,
and a symbolic obstruction for every unit multiplier of (1,50,99).
Full root replay metadata and output are retained in Pass41 verification JSON.
