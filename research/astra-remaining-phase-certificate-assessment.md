# Renault 6.1/6.4: certificate route assessment

**Recommendation:** try the exact certificate route for both reviewed contracts.
Three small generic additions suffice; keep the checked 5.1 implementation
unchanged. The principal uncertainty is the size of the new minimal mask
families and their kernel-checking cost, not the real-variable bridge. A bounded
data pass should measure that before committing to full concrete Lean tables.
Direct symbolic proofs remain the fallback if the measured table cost is poor.

This is an assessment and experiment pre-plan only. No candidate coverage was
computed, no compiler or numerical search was run, and no new phase theorem is
claimed. Only this report was edited. The larger one-three-divisible argument
and independent review remain the accepted mathematical contracts.

## Exact finite problems

Use `Good(s,A,S,x) := if s then 1/6 < N(A*x+S/6)
else 1/6 ≤ N(A*x+S/6)`, with positive natural slope `A`, natural effective
shift numerator `S`, and strictness flag `s`.

| Contract | Candidate decoding | Coordinate types and domain |
| --- | --- | --- |
| 6.1: 24 candidates | Indices 0–19: closed, `A=2+i/5`, `b=1+i%5`. Indices 20–23: strict, `A=1`, `b=1+(i-20)`. | Coordinate 0 has `S=2*b`; coordinates 1,2 have `S=b`. All normalized phases in `[0,1)`. |
| 6.4: 15 candidates | Index 0: strict `(A,b)=(2,0)`. Indices 1,2: strict `(1,1),(1,5)`. Indices 3–14: closed, `A=3+2*((i-3)/6)`, `b=(i-3)%6`. | All coordinates have `S=b`; normalized input restricted to `[1/6,5/6]`. |

The strict sets are precisely `{1,2,3,4}` for 6.1 and the separate doubling/
`{1,5}` alternatives for 6.4. The latter's closed candidates include `b=0`.
One candidate index must work for all three coordinates. No distinctness of
phases is assumed.

The literal `renaultPhaseCuts` has 61 points, denominator 360. All relevant
band boundaries satisfy `x=k/(6*A)`, for `1≤A≤5`; effective shift `2*b`
changes the integer numerator, not that denominator. Thus the same cuts are
appropriate for both weight types of 6.1, including unreduced `S` up to ten.
The next data checker must explicitly confirm the required boundaries occur;
the assessment has not executed that check.

For 6.4 use `C₄(i)=renaultPhaseCuts(i+10)` for `0≤i≤40`, from numerator 60
through 300. This gives 41 singletons plus 40 open intervals: **81 atoms**.
The final singleton is atom 80; do not omit `5/6` or append an open interval
beyond it. The current unit-interval cover excludes its final endpoint, so it
cannot simply be relabeled as this closed-domain cover.

## What is reusable and what is fixed

`FiniteMaskCertificates` already parameterizes the candidate count: its
`exists_common_mask_candidate B a b c` uses `a<2^B` and
`a &&& b &&& c ≠ 0`. `FiniteMaskSubset.maskCandidates_subset_of_and_eq` also
works for arbitrary `B`. Reuse both unchanged.

`PhaseGood`, `phase_certificate_sound`, `PhaseBandFacts`, and
`phaseBandFacts_sound` are fixed to 23 candidates/120 atoms and the 5.1
decoder. Their proofs are reusable patterns, not directly applicable theorem
types. `RealPhaseBands` already supplies arbitrary real affine offsets,
strict integer-band soundness, positive-slope open-band soundness, and natural
affine periodicity. It supplies the delicate real argument needed below.

Three proposed additions are enough:

**1. Candidate-independent band fact and soundness.** Keep denominator 360;
generalizing denominators would add work without helping these targets. For
natural atom index `a`, define

`R = if a%2=0 then 2*C(a/2) else C(a/2)+C(a/2+1)`,
`P=A*R+120*S`, and `Q=P/720` (natural quotient).

Define `AffineSixthBandFact C a A S s` by these exact finite conditions:

* Singleton: `120 < P%720 < 600` if strict; otherwise
  `120 ≤ P%720 ≤ 600`.
* Open interval: `360*Q+60 ≤ A*C(a/2)+60*S` and
  `A*C(a/2+1)+60*S ≤ 360*Q+300`, for either strictness flag.

The proposed interface is

```lean
theorem affineSixthBandFact_sound
    (C : ℕ → ℕ) (a A S : ℕ) (s : Bool) (hA : 0 < A)
    (h : AffineSixthBandFact C a A S s) (x : ℝ)
    (hx : CutAtomMem C 360 a x) :
    if s then (1 : ℝ) / 6 < circleNorm ((A : ℝ) * x + (S : ℝ) / 6)
    else (1 : ℝ) / 6 ≤ circleNorm ((A : ℝ) * x + (S : ℝ) / 6)
```

At singletons, quotient/remainder arithmetic gives the exact phase. On open
atoms the two **closed endpoint** inequalities imply strict interior goodness
because `A>0`, by `circleNorm_gt_of_affine_open_band`. Therefore those same
finite inequalities serve both flags. No strict singleton boundary may be
promoted to true. Only true-bit implication is required; false bits need no
real soundness theorem. Natural effective shifts need no reduction modulo six;
the quotient already accounts for their integer part.

**2. Closed cut cover.** A small extension of the existing adjacent-crossing
proof, not a new partition algorithm:

```lean
theorem cutAtomMem_covers_closed_interval
    (n D : ℕ) (hD : 0 < D) (C : ℕ → ℕ) (x : ℝ)
    (hlo : (C 0 : ℝ) / (D : ℝ) ≤ x)
    (hhi : x ≤ (C n : ℝ) / (D : ℝ)) :
    ∃ a : Fin (2*n+1), CutAtomMem C D a.val x
```

If `x=C n/D`, choose atom `2*n`. Otherwise apply
`exists_adjacent_cut_interval`, then distinguish equality at its left cut from
the open interval. No sortedness assumption is necessary for this cover, and
`n=0` remains valid. Concrete cut completeness is a separate finite check.

**3. Coordinate-indexed common-candidate assembly.** Avoid three independently
chosen candidates and avoid sorting a weight-two row among weight-one rows.
A minimal assembly interface can consume already-sound core rows:

```lean
theorem typed_phase_certificate_sound
    (B : ℕ) (m : Fin 3 → ℕ)
    (M : (j : Fin 3) → Fin (m j) → Finset (Fin B))
    (Domain : Fin 3 → ℝ → Prop) (Good : Fin 3 → Fin B → ℝ → Prop)
    (hrow : ∀ j x, Domain j x →
      ∃ i, ∀ c, c ∈ M j i → Good j c x)
    (hcommon : ∀ i : (j : Fin 3) → Fin (m j),
      ∃ c, ∀ j, c ∈ M j (i j)) :
    ∀ x : Fin 3 → ℝ, (∀ j, Domain j (x j)) →
      ∃ c, ∀ j, Good j c (x j)
```

Select one sound row per coordinate and apply `hcommon` once. Construct `hrow`
from atom coverage, true-bit soundness, and a supplied smaller core mask.
Require `core(dom a) &&& atomMask(a)=core(dom a)` separately for each type.
Minimality itself is unnecessary for kernel soundness; it is only an economy.

For 6.1 use independent cores `M₂,M₁`; verify
`M₂ i &&& M₁ j &&& M₁ k ≠ 0` for all `i` and `j≤k`. Only the two unit-weight
indices may be sorted. For 6.4 verify one common core on `i≤j≤k`, allowing
equal indices. Existing mask bounds and subset lemmas then discharge the
abstract hypotheses.

Normalize arbitrary reals with `Int.fract` and
`circleNorm_nat_affine_fract`. For 6.4 the supplied safe norms imply
fractional parts in the **closed** interval `[1/6,5/6]`; this premise must
remain in the final theorem. Signed versions follow by applying the unsigned
statement to signed phases and norm reflection, as in the reviewed manuscript.
This preserves one common affine choice and requires no signed certificate.

## Economy and bounded next experiment — not executed

The direct 6.1 proof needs exact bad-set shapes, cyclic geometry, mixed-row
classification, and several interval branches. Direct 6.4 is shorter but still
needs the unimplemented matching/endpoint machinery. The three additions above
serve both lemmas while reusing checked real inequalities and bit operations.
That favors certificates, conditionally on the data and kernel cost checks.

Propose one separately authorized, predeclared fixed-family data pass:

1. Freeze the cuts and exact decoders above. Confirm endpoints and all required
   breakpoints. Evaluate the stated finite band predicates only: two
   `120×24` tables and one `81×15` table, **6,975 predicate calls**.
2. Deduplicate masks within each type; find inclusion-minimal rows and supplied
   dominators deterministically, breaking ties by least representative atom.
   Bound minimality plus domination by **70,722 directed containment tests**
   (`2*(2*120²+81²)`). No candidate family changes are permitted.
3. Check all compressed triples and retain the least common set-bit witness.
   Worst-case bounds before any compression are `120*120*121/2=871,200`
   mixed triples and `81*82*83/6=91,881` equal-type triples: at most
   **963,081 triple intersections**, each two bitwise ANDs. Preserve repeated
   indices. Stop at the first uncovered triple and report it without claiming
   a phase theorem or a counterexample to LRC.
4. Predeclare wall 60 seconds, CPU soft/hard 59/60, address space 256 MiB,
   and total retained evidence at most 1 MiB. Store supplied witnesses as
   single bytes in deterministic order, not verbose JSON: at most 963,081
   bytes. Reserve at most 65,536 bytes for code, masks, metadata and complete
   bounded diagnostics. Failure, timeout, or excess output ends this attempt;
   no automatic budget increase or widened family.

Retain exact program/source/output hashes and actual exit/resource receipts.
A separate bounded fixed verifier must replay only supplied data and witnesses
before Lean transcription. Data generation is not a kernel proof. After that,
use ordinary kernel `decide` rows, as in the existing concrete modules, with
the agreed Terra High compile/repair protocol. A largest-row pilot under the
root's serial check slot should decide whether full tables are economical;
do not extrapolate Python speed to kernel performance. If unsuccessful, keep
the reviewed direct symbolic proof as the next route rather than weakening
strict alternatives or input domains.

The purpose is completion of canonical N=6; subsequent research must follow
the standing uniform arbitrary-N priority, not successive runner counts.

## Static provenance

Updated config/workflow/policy and focused state were read: research active,
task `/root/remaining_phase_certificate_assessment`, checkpoint `c63bb23`,
requested Astra/xhigh. Terra High routing and compile ownership were recorded
in current policy. Validator command `python3 scripts/validate_workflow.py`
returned exit 0 with stdout `workflow structural validation passed; it cannot
certify mathematical validity.` No literature retrieval or mathematical
execution occurred. These SHA-256 bindings were obtained by source reads and
`sha256sum`; they are not fresh build claims. Lean paths below are relative to
`LonelyRunner/`.

| Source | SHA-256 |
| --- | --- |
| `RenaultPhaseCertificates.lean` | `36b58c04e0c755d462f32bae3388c30d744d97ccb20a3bc27aa0daa99b7e49f0` |
| `RenaultPhaseBandFacts.lean` | `c775da2dfb8d3c6ff24f6d66c49d7b690f3422cc7dc95b410c064cc08c78d721` |
| `RenaultPhaseBandSoundness.lean` | `b7773a0755413e03371c2322d221bfda68cf1174bcbfac694e61a4803189ccf7` |
| `RenaultPhaseConcreteData.lean` | `1d5709da3631bc51d60bb4dbeb94fa2668da5cdbf5a63007e7b4ebd96a5b6c17` |
| `FiniteCutCover.lean` | `b7e7e50834bc86d13ffde759e3d0c2dc4d2480a03ec61eb88a70ca215fcc1011` |
| `RealPhaseBands.lean` | `7f70467bad6bb5a8a859bff8947af1dc73e685910b69157b49bab259b3c02ca0` |
| `FiniteMaskCertificates.lean` | `72629bc0780161890a31dd705b744c7ce2a77c884a915d7eaf4b3d69855b181e` |
| `FiniteMaskSubset.lean` | `8a7dec857dc4a9c4f2b5d4360389e97487163bd69d2d01ed3408b1335f162c3e` |
| `RenaultPhaseMasks.lean` | `fc1360b225d440c99c6dc44067f2bfda2668c9e6984078770c70dc23dc3a4857` |
| `research/astra-one-three-divisible-plan.md` (repository root) | `9da230600af3a0a0bc8223de3daca2575f8d41f447142687ca64db53ced4ae9e` |
| `research/astra-one-three-divisible-review.md` (repository root) | `8f720fbd8002918adaaa0d36fc7774c450eeb5dba84dd555552d24b5e57e6078` |
