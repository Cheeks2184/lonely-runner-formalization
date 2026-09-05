# Four lower owners at denominator nine: formalization record

Task `/root/guard_internal_cover_audit-four-owner-formalization`, requested
Astra/xhigh, 2026-09-05. Starting source main:
`a25799bfbbb41b4c31f222b25060a4d6e0e5d117`.
Runtime model metadata beyond the requested routing was not independently
exposed to this worker.

The current workflow, policy, configuration, and active state were read and
the workflow validator passed. The complete accepted manuscript and review
were read and their hashes verified:

```text
a51e581cdf4dc7b37a9b7481e930af00f0605fb4aa0a8aa06d848845fdb99f8f  research/astra-sparse-owner-supply-audit.md
0aacc39cf9dba3147b8002c2b0266309d0a2c57214b38645b246e20718f27684  research/astra-sparse-owner-supply-review.md
```

This worker owned only `LonelyRunner/FourLowerOwnerNine.lean` and this note.
The previous N7 source and record remained frozen. The worker did not edit
root imports, axiom-audit files, Git state, shared workflow state, or caches.
Root's dependency-ready signal preceded N9 compilation. A storage-cleanup
hold was acknowledged with no worker process running, and root released it
before compilation resumed. N9 remained separate from the concurrent Pass15
publication.

## Completed exact declarations

The source compiles and exports the exact requested theorem:

```lean
theorem fourLowerOwner_noncover_nine (p a b c d : Nat)
    (ha : 0 < a) (hab : a < b) (hbc : b < c) (hcd : c < d) (hdp : d < p) :
    ∃ r ∈ pivotCandidates 9 p,
      r ∉ pivotBadResidues 9 p a ∧ r ∉ pivotBadResidues 9 p b ∧
      r ∉ pivotBadResidues 9 p c ∧ r ∉ pivotBadResidues 9 p d
```

The second public declaration,
`fourLowerOwner_circleNorm_witness_nine`, returns the same residue and proves
closed `1/9` circle-distance bounds for `p,a,b,c,d` at time `r/(9*p)`.
Both declarations are in `namespace LonelyRunner`; every helper is private.

There is no supplied witness, bounded original pivot, divisibility or
coprimality assumption on the original tuple, omitted owner, or relaxed
boundary. Strict badness is `<p`, so equality with `p` remains safe. The
hypotheses imply `p>=5`, rather than introducing an additional small-pivot
exception. The result protects exactly these four owners and the actual
pivot, not eight arbitrary moving speeds at threshold `1/9`.

## Formal proof and finite completeness

The proof factors each lower speed as `d=hD`, `p=hP`, with `h=gcd(d,p)>0`,
`0<D<P`, and `Coprime D P`. The kernel size `gcd(D,9)` is exactly one of
`1,3,9`. Existing normalized counts and proved scalar inequalities show that
all rows have count at most `2p` except the four normalized stars:

```text
(P,D)=(10,9),(11,9),(19,9),(19,18).
```

Actual stars are represented by their exact integer slope equations
`10s=9p`, `11s=9p`, `19s=9p`, or `19s=18p`. Their counts are obtained by
scaling the closed base counts `24,24,40,40`, respectively. Each star has an
exact budget with integer coefficients `(u,v)` equal to `(15,28)`, `(33,64)`,
or `(57,112)`:

```text
u*|B_star| + 3*v*p = 8*u*p,
u*|B_other \ B_star| < v*p for every different lower owner.
```

For a normalized other row of raw count below its budget, the remainder
bound follows immediately from inclusion. Otherwise the existing scalar
inequality gives

```text
9*b <= 16*P + 7*(k-1),   v*P <= u*b.
```

`nine_exception_cap` splits all three budgets and all three kernel sizes
and proves the common bound **P<71** by integer arithmetic. The manuscript's
sharper bounds `(17,70)`, `(9,38)`, and `(8,33)` are not separate premises in
the formalization: the common cap contains them all. No original-pivot
height bound is inferred from a finite search.

Within this proved normalized cap, four kernel-checked exhaustive classifiers
range over every `P,D : Fin 71`. They retain `0<D<P`, coprimality, the exact
raw-density comparison including equality, and exclusion only of the star's
identical slope. They prove membership in the explicit lists of respectively
**37,13,9,9 pairs**, totaling 68. The other normalized owner at denominator
19 remains present in each relevant list.

Every listed pair has its own closed kernel `decide` proof of the exact
remainder bound at `L=lcm(S,P)`. The numeric lcm, divisions, and scaled owner
speeds in each certificate are connected to the general statement by checked
`norm_num` reductions. The lists were mechanically prepared with Python, but
neither their correctness nor their completeness is trusted: the classifiers
and all 68 inequalities are Lean proofs. No Python execution is needed to
check this source.

For efficient evaluation, `nineRemainderCount` uses a single filtered range
with the predicate

```text
r % 9 != 0 AND dist_(9p)(r*d)<p AND p<=dist_(9p)(r*s).
```

A theorem proves that this count equals the literal bad-set difference
cardinality. It neither replaces candidates with the whole residue range nor
changes strictness. The checker uses ordinary kernel `decide`, with no
`native_decide`, custom axiom, or external computation shortcut.

The generic lcm lift proves that if `S|p` and `P|p`, both owners and the pivot
are a common positive multiple of their values at `L=lcm(S,P)`. The exact
scaling identity is

```text
|B(9,tL,td) \ B(9,tL,ts)| = t*|B(9,L,d) \ B(9,L,s)|.
```

It follows from the existing candidate-preserving reduction and periodic
range count. Therefore every finite certificate covers all positive common
scalings, including every original power of three. No coprimality hypothesis
on the original pivot is introduced.

If a star occurs among the four owners, its own count plus the three strict
remainders gives union cardinality below `8p`. If no star occurs, all four
counts are at most `2p`, and the common candidate `1` makes the union strictly
smaller than their sum. This one common point suffices; the manuscript's
stronger two-point saving is not required. A positive complement in the
`8p`-element candidate row supplies the exact theorem. The closed-distance
adapter uses the existing modular-to-circle lemmas without changing the time.

## Verification and resource binding

Frozen implementation SHA-256:

```text
cf11f4738d51c4455e1c9fbe18810023d21794c8bb047414b793c048adbd1c5d  LonelyRunner/FourLowerOwnerNine.lean
```

The optimized direct source compile passed with exit code 0 and no Lean
diagnostics. It took **83.96 seconds**, with reported peak **3,563,596 KiB**:

```bash
/usr/bin/time -f 'elapsed_seconds=%e peak_kib=%M' timeout 240s \
  env PATH="$HOME/.elan/bin:$PATH" lake env lean LonelyRunner/FourLowerOwnerNine.lean
```

The implementation separates the 68 closed residue checks from the four
exhaustive classifiers and disables asynchronous elaboration locally around
the finite checks. This reduced the measured peak from 6,416,408 KiB in the
initial complete implementation. The first resource-refactor pass needed
explicit closed lcm/division normalization in its wrappers; those errors were
fixed before freezing. An earlier slow direct-Finset-difference check was
stopped by terminating its exact owned Lean process. No failed or interrupted
check is used as proof evidence.

A fresh replay of the entire frozen source, with exact type and axiom checks,
was run independently of the direct compile:

```bash
python3 - <<'PY' | /usr/bin/time -f 'elapsed_seconds=%e peak_kib=%M' \
  timeout 240s env PATH="$HOME/.elan/bin:$PATH" lake env lean --stdin
from pathlib import Path
print(Path('LonelyRunner/FourLowerOwnerNine.lean').read_text())
print('#check LonelyRunner.fourLowerOwner_noncover_nine')
print('#check LonelyRunner.fourLowerOwner_circleNorm_witness_nine')
print('#print axioms LonelyRunner.fourLowerOwner_noncover_nine')
print('#print axioms LonelyRunner.fourLowerOwner_circleNorm_witness_nine')
PY
```

The fresh replay passed with exit code 0, in **81.28 seconds**, with reported
peak **3,575,748 KiB**. Both printed declaration types matched the exact target
and the five-coordinate closed-distance adapter. Exact axiom output:

```text
'LonelyRunner.fourLowerOwner_noncover_nine' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.fourLowerOwner_circleNorm_witness_nine' depends on axioms: [propext, Classical.choice, Quot.sound]
```

The final workflow validation, frozen source-hash check, forbidden-token check,
and count of the 37+13+9+9 independent pair declarations passed. All owned
compilation processes completed. No temporary source or computational process
is required to resume this checkpoint.

## Explicit next task and acceptance boundary

The next task is an **independent Astra/xhigh semantic and kernel review** of
`LonelyRunner/FourLowerOwnerNine.lean` at the frozen hash above. It must verify
the exact unrestricted-height statement, strict bad/closed good boundary,
scalar-derived normalized cap, all 68 pair classifiers/certificates including
the two denominator-19 directions, common-scaling lift, and the adapter's
five original coordinates. It should replay the compile and axiom checks
against the pinned shared dependencies before acceptance.

Root must separately add project imports and axiom-audit entries, perform its
integration checks, and handle publication. The N9 files remain unreviewed
checkpoint artifacts until that independent task succeeds. This worker did
not run a full project build or independently review its own proof.

The parent reported a runtime-goal `blocked` status during the already
authorized task, differing from durable `in_progress` state. This worker
completed only the current formalization/verification and left this exact
review restart point; it did not change either goal status or shared state.
No further research was started.

The general all-N sparse-owner contract, N=10 case, unrestricted internal-cover
redundancy, and canonical unrestricted LRC remain unresolved. The N=15 failure
of a proposed individual remainder bound has not been extrapolated into this
theorem or misreported as a sparse-cover counterexample.
