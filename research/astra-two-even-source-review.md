# Independent source review: two-even witnesses

**Accept both exact public contracts and their proofs in the frozen source.**
No mathematical defect, hidden hypothesis, endpoint loss, coordinate-dependent
witness, or circular use of the subsequent six-runner assembly was found.
This accepts the restricted two-even branch; the normal root integration and
trust checks remain necessary before checkpoint promotion.

Reviewer: `/root/two_even_source_review`, requested Astra/XHIGH. Runtime-observed
model/effort and usage are unavailable. I authored neither the assembly plan,
the Lean implementation, nor the root repair, and supplied no implementation
guidance. I read all 568 source lines, including all eleven private proofs and
both public bodies, the complete accepted plan, the relevant actual dependency
contracts/proofs, and the signed-phase and orbit-helper acceptance reports.
I read the workflow, policy and focused current state and ran
`python3 scripts/validate_workflow.py`: exit 0, structural consistency only.
Only this review file was written. No Lean invocation, import/axiom probe,
numerical experiment, source/Git/state edit or shared-cache mutation occurred.

## Exact public scope

These are the only two public declarations in this module, in namespace
`LonelyRunner`. Static extraction matched their types to the accepted plan
after whitespace normalization only; there are no ambient section hypotheses.

```lean
theorem fiveMovingNaturalRunners_of_two_even_residues
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (hsix : 6 ∣ v 0) (heven1 : 2 ∣ v 1)
    (hodd2 : ¬ 2 ∣ v 2) (hodd3 : ¬ 2 ∣ v 3) (hodd4 : ¬ 2 ∣ v 4)
    (hother : ∀ i, i ≠ 0 → ¬ 3 ∣ v i) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))

theorem one_three_divisible_two_even_witness
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i) (p : Fin 5)
    (hone : ∀ i, 3 ∣ v i ↔ i = p)
    (heven : ((Finset.univ : Finset (Fin 5)).filter
      (fun i => 2 ∣ v i)).card = 2) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))
```

Both quantify five positive natural speeds, allow repeated speed values, and
return one positive real time shared by all labels with a closed margin.
There is no gcd, injectivity, ordering, ratio, coprimality of the whole tuple,
or supplied-witness requirement. The second theorem allows any pivot label;
it does not assume that the pivot is even or six-divisible in advance.

## Proof assessment

The affine helper at lines 17–23 transfers equality of actual fractional
phases to circle norms. Its slope and shift numerator are integers, and it
works for every real time. The pivot-shift helper at lines 25–31 uses residue
zero and `6 ∣ d`, so signed sixth-shifts preserve the pivot fractional part.
The reused even/odd residue helpers from `ThreeEvenOrbit` have exactly the
plan's two proposed residue contracts. Their complete bodies eliminate the
wrong parity using integer divisibility and cast back correctly; negative
integer quotients are permitted. Their source was independently accepted,
and its current source/artifacts match that review. Reuse therefore satisfies
the plan's conditional permission; it does not import the later three-even
witness theorem as a premise.

All five scalar face proofs at lines 33–71 preserve the required endpoints.
The odd closed case permits either sign and every `1 ≤ b ≤ 5`. The odd
forward case uses exactly positive sign with `b=1..4`, or negative sign with
`b=2..5`; both give actual fractional phases in `[1/6,5/6)`. For the even
face, doubling gives `2/3`; unit shifts `b=1,5` give `1/6` or `1/2`, including
the negative unreduced numerator `-5`. For `a=3,5`, every natural `b≤5`,
including zero, yields a phase in `{1/6,1/2,5/6}`. The finite `interval_cases`
and `norm_num [Int.fract]` proofs are checked proof terms, not an external
table assumption. The two band helpers at lines 76–87 distinguish closed
norm safety from a strict actual upper fractional endpoint.

The odd-face assembly at lines 89–227 has mixed weight two only at coordinate
zero, where `ρ 0 = 1`. The exclusion assumptions rule out `r=0,1`, so the
actual exposed face is odd. Writing its residue as `σ=±1` and shifting to
`t'=τ+σ/6` gives face phase zero because `σ²=1`; the pivot phase is unchanged.
The three other phases remain arbitrary reals. The positive face sign uses
signed 6.1 and the negative face sign uses its reflected version, producing
the exact strict ranges above. All signs are independent, while the selected
`a,b` remain common. Closed choices protect the face and all mapped labels;
`B=(a:ℤ)*σ+(b:ℤ)` is genuinely integer-valued, and the cast/ring identity
expresses the actual time as `a*τ+B/6` without natural subtraction. The
dilation theorem strictly improves the pivot's constrained maximum. Strict
choices instead establish the actual `[1/6,5/6)` bands and preserve its
starting norm, so the forward theorem supplies one common positive increment.

The even-face assembly at lines 231–385 uses the three odd labels `![2,3,4]`.
Initial closed safety is obtained from the maximizer's safe complement, as
required by signed 6.4. All three alternatives are retained: doubling uses
closed complement safety and dilation improvement; the shared unit shift
uses the actual strict upper bands and forward improvement; the closed
`a=3 ∨ a=5`, `b≤5` choice uses dilation improvement and permits both `b=0`
and face phase `5/6`. The even-face fractional formula is exactly
`fract((5*a+2*σ*b)/6)`, after integer casts and real ring normalization.

Every contradiction uses the supplied maximum over **all real times** with
a closed-safe complement. No step restricts candidate times to `[0,1]`,
requires them to be positive, or replaces the maximum by one over a strict
safe set. The source correctly uses an actual exposed fractional face
`5/6`, not merely norm `1/6`. In the fixed-role body, the three literal maps
are exactly `r=2 ↦ ![1,3,4]`, `r=3 ↦ ![1,2,4]`, and
`r=4 ↦ ![1,2,3]`; the supplied finite cases exhaust every remaining label.
The all-real witness cannot have time zero because its pivot bound would
give `1/6≤0`. Negating a negative witness preserves every norm and gives
the stated positive time, following the checked `OneEvenRunners` pattern.

The count adapter at lines 464–566 assumes all-real nonexistence temporarily.
The small-denominator cover at denominator six supplies a six-divisible
label, and unique three-divisibility identifies it with `p`. Thus the
six-divisible pivot is derived only where justified. Erasing `p` from the
two even labels yields the singleton `{q}` with `q≠p` and `q` even. Erasing
`p`, then `q`, from the five-label universe yields exactly three labels;
`simp [O,hqp]` uses the correct second-erase membership. Nested membership
projections exclude both pivots, and the characterization of even labels
makes all three remaining labels odd. The vector `![v p,v q,v u,v w,v z]`
satisfies every fixed-role premise, and its one witness transfers to every
original label by exhaustive membership cases. This is a label enumeration,
not a distinct-speed assumption. The already established fixed-role theorem
precedes its use here, and the final positive conversion is again valid.

## Static bindings and execution evidence

All paths below are relative to `/home/joshua/lonely-runner-formalization`
except the explicit `/tmp` paths. These SHA-256 bindings were actually checked.

| File | SHA-256 |
| --- | --- |
| `LonelyRunner/TwoEvenRunners.lean` | `d7c40736c944dc8f66a0b04def3035dd34cf20248afa86986a11942133bdf524` |
| `research/astra-two-even-assembly-plan.md` | `3b1cf3018ebb78b01a2d43eaf8d534d80ee313db4e55a37b863a147c07bc0073` |
| `LonelyRunner/SignedRemainingPhase.lean` | `f75e742e3b0109fc9b1e23818dcc4873e1d824395171adbc4188da862050597c` |
| `LonelyRunner/ThreeEvenOrbit.lean` | `2d2cbdd51dc51f1e23985feb9c7826ce5bb944118f01c8c7719e5ad25de4e088` |
| `LonelyRunner/ConstrainedMaximizer.lean` | `2ef07e6b83b8675a22184571c31d2a71dab9d5c072e3cd165cb8382957b46e92` |
| `LonelyRunner/OneSixthComplementMaximizer.lean` | `5a7011ca680b8a2b26c7bad466a8ee4008cf47507eb8b700846f296894bb90a1` |
| `LonelyRunner/SixthAffinePhase.lean` | `76e420713079ec0c3979e9b169cd78ecb6a932d6dc790ea7d9711adbb64b7d4b` |
| `LonelyRunner/SmallDenominatorWitness.lean` | `1570a359100594f4a5589588e3b32674dc2d54d60e500df1d47aca64c2faf95f` |
| `LonelyRunner/OneEvenRunners.lean` | `5bf5f01d7b31b410b680d646a832b273890cc267dc7a4775fea37eac5c58b810` |
| `research/astra-signed-remaining-phase-source-review.md` | `1b184342ddda5fb995c5c57c754f4c4ac38fefbdb1072bc4ad12fb3e7f352ae6` |
| `research/astra-three-even-orbit-source-review.md` | `69e38074735e7480e5fca33dbc15a0b5d81faf9a1048860d270f39f792b841b6` |
| `research/astra-two-even-runners-implementation.json` | `cabea4cbf4f81ce32fd628648ce0460036a8ca055fa4144a7e2c6527f525b90f` |
| `research/astra-two-even-astra-repair.json` | `3114d4c6b47bfff8e895b859bf92c8ec699ceac344970a8698ae3ec8677929dc` |
| `lean-toolchain` | `8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af` |
| `lake-manifest.json` | `887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218` |
| `.lake/build/lib/lean/LonelyRunner/TwoEvenRunners.olean` | `66b9987e79a42a25ee118b49e58a8046b5ba79de75f3a751a41aba50c42e8fb5` |
| `.lake/build/lib/lean/LonelyRunner/TwoEvenRunners.ilean` | `d4fc4b3d5ed5e13246ca8fc238a14dbf936ce0e0c893698f5d74c82d72aee732` |

Static checks also matched all eleven bindings in the assembly plan and every
listed source/artifact binding in the two prior acceptance reports. A focused
scan of the new source found no `sorry`, `admit`, custom `axiom`, `native_decide`,
`unsafe`, or `set_option`. Its local import ancestry is acyclic and contains
neither `SixRunnerOrdinary` nor `SixRunnerCanonical`. These checks supplement
source review; they are not a substitute for the root theorem-axiom audit.

The worker receipt accurately preserves initial failure and two failed repair
checks. The initial two checks have reported source hashes and transcript
references only: their physical snapshots and original raw streams are
missing. I did not reconstruct or claim to validate that missing history.
The final worker check is physically retained in
`/tmp/astra-two-even-repair2.json` (82,792 bytes,
`6ed93ebf7aa95bbeb181b4490e01a1cab7c6fe1fa6703c642bfc2d1876127701`).
Its embedded before/after source bytes both match historical source
`53c86efda33d942bb7e6f10362535c4c3962de5bbf85232d5b01ac30733d8789`.
I matched its physical before snapshot and complete raw streams, and read the
full diagnostic stdout: exit 1 after 7.377033557015238 seconds, with the eight
remaining elaboration errors. Its historical `source_after.path` now holds
the authorized root repair, so only its embedded after bytes bind that old
source. No successful artifact is claimed for this failed check.

The root receipt embeds the complete successful driver object. It equals the
physical `/tmp/astra-two-even-astra-repair1.json` (75,272 bytes,
`4c0265ce3d68863362f421985d7dd81e775cd845fa84f0d7807436b92a900349`).
I matched every embedded source/stream size and hash to its physical file;
both check-time source snapshots equal the current 26,216-byte reviewed
source. Here `source_before` means before the successful check, after the
root source repair. Final `.olean` and `.ilean` sizes are respectively
1,485,864 and 64,216 bytes and match the hashes above.

The successful captured argv, in the repository cwd with
`/home/joshua/.elan/bin` prepended to `PATH`, is:

```text
flock -n .lake/verification.lock timeout --preserve-status 180s prlimit --as=8589934592 --cpu=179:180 lake env lean -j1 -s65536 LonelyRunner/TwoEvenRunners.lean -o /home/joshua/lonely-runner-formalization/.lake/build/lib/lean/LonelyRunner/TwoEvenRunners.olean -i /home/joshua/lonely-runner-formalization/.lake/build/lib/lean/LonelyRunner/TwoEvenRunners.ilean
```

It records exit 0 and 8.255630145984469 elapsed seconds. I read its entire
physical stdout: eight unused-simp-argument warnings, no errors. That stream
is 2,122 bytes, SHA-256
`2eeff7768645cb3c75b70061f312a6ac599864b11eb9f8032c622cb1e766620c`;
physical stderr is empty with SHA-256
`e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.
The exact diff from the embedded worker-final source to current source
matches the root receipt: 26 added and 15 removed lines. Every change resolves
the captured casts/rewrites, ring normalization, both doubled-face band goals,
or erase-cardinality diagnostics; public contracts and proof strategy are
unchanged. No identical focused check was repeated by this reviewer.

Total metrics correctly retain first-check failure, two worker repair rounds,
two Astra repair rounds (one guidance round, one direct repair), and 41 direct
Astra changed lines, defined as additions plus removals. Overall worker time
and task usage remain null; check durations do not establish worker elapsed
time or token savings. Earlier provenance gaps in the orbit-helper receipt
remain those disclosed in its acceptance report.

No separate axiom probe for these two new declarations has yet been supplied
or run by this reviewer. Root's full integration build, source trust scan and
theorem-axiom audit remain pending obligations for this checkpoint. No distinct
unresolved concern warrants another identical focused check. This review does
not establish the unrestricted five-moving result or canonical N=6 bridge.
After the complete N=6 milestone passes its assembly/build/trust/scope gates,
the standing next research direction is a uniform arbitrary-N mechanism. The
unrestricted `LonelyRunner.Conjecture` remains unresolved.
