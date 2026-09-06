# Forty-third Astra checkpoint: fixed phase masks and generic real adapters

The complete41-mask intersection table now has Lean proofs, together with
a generic theorem extracting an actual bounded candidate from a nonzero
intersection. Generic rational-shift, strict-band, periodicity and finite-cut
coverage helpers also compile. Full root build and trust audit pass; independent source reviews and their exact root replays also pass. No new runner count is claimed.

## Fixed mask certificate

`FiniteMaskCertificates.lean` interprets a natural mask as candidates in Fin B.
Its common-bit theorem needs only a<2^B and a nonzero triple intersection;
the other two masks may have higher bits, and B=0 is handled by inconsistent
premises. The result is an actual common index in Fin B, not an unbounded bit.

`RenaultPhaseMasks.lean` contains the41 literal core masks in exactly the
frozen certificate order. Forty-one private row proofs use ordinary `decide`.
The universal theorem quantifies arbitrary first index i and j<=k, including
repeated indices. A size theorem bounds each mask by2^23. The generic
extraction theorem then supplies a common candidate in Fin23. This checks
the full core table, beyond the previous single-row pilot.

The certificate-to-source literal comparison is static data verification.
All mathematical intersection claims are Lean declarations. Concrete atom
masks, their domination by these core masks, endpoint-band facts and the
real-phase application remain separate obligations. The module by itself
does not prove Renault5.1 or any new runner count.

## Generic real and arithmetic helpers

`RationalShiftOrbits.lean` implements two reviewed contracts. The existing
integer coprime-grid witness gains a bounded natural index through Euclidean
remainder reduction, including negative integer witnesses. A separate exact
norm identity preserves a divisible speed under a reciprocal-divisor time
shift. The gcd reduction, quarter corollary, four-divisible five-label
insertion and primitive divisor counts are accepted manuscripts but remain
unimplemented here. The two manuscript/review files retain their exact scope.

`RealPhaseBands.lean` proves strict circular distance inside an integer band,
strict safety in an affine open interval from closed endpoint bounds and
positive slope, and natural-affine invariance under fractional-part
normalization. Arbitrary real offsets and negative phases are included.
The periodicity statement allows zero slope.

`FiniteCutCover.lean` proves an adjacent upward crossing for any finite real
sequence whose endpoints straddle x. No monotonicity is needed. It uses this
to cover[0,1) by singleton cut points and open adjacent intervals. The
generic theorem retains positive cut count and denominator, first cut0 and
last cut1; it does not replace endpoints by almost-everywhere coverage.

These helpers realize the generic portions of the concrete phase bridge
manuscript. Its remaining finite arithmetic contracts are stated explicitly
there, including different singleton tests for strict and closed candidates.

## Verification and evidence boundary

Full root build exited0 with3669 jobs. The source/trust audit exited0 with574 dependency reports and3 axiom-free
declarations; exact source hashes and execution records are saved in the
verification JSON. All16 new public definitions/theorems are audited.
No custom axioms, `sorry`, `admit`, unchecked native decision or unsafe
proof shortcuts are introduced.

Terra authored the source drafts. Root ran actual focused builds, corrected
reported elaboration errors without changing the contracts, and performed
root integration. The mask worker initially overstated retained execution
evidence; its corrected report explicitly identifies worker-reported runs
with no raw record. Those reports are not accepted as exact execution
receipts. Root source builds and independently captured universal/axiom
probes provide the verification for the frozen source.

## Publication and continuing work

Pass42 was merged as PR41 at2c503a4e3599646e77d5d9453be54e2667842ae6
after both required checks passed. Remote ancestry and local main were
verified. The shared pinned cache remains necessary for ongoing concrete
phase-table and real-soundness implementation. The unrestricted Lonely
Runner goal remains active and unresolved.

Independent probes and root replays checked all16 public declarations, their
exact universal scopes, literal vector and atom definition. Both passed with
only the three allowed axioms. One helper probe initially stopped at thread
startup; its identical retry with explicit serial settings passed at unchanged
resource limits. Complete failure and success records are retained. This
checkpoint is verified and ready for its authorized publication sequence.
