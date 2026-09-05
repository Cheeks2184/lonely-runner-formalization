# Independent formal review of the mirrored-block family

Requested reviewer: Astra xhigh, 2026-09-05. Base source checkpoint:
`8db7eb32fb0aec5f1a62d18f93a72c5096d76743`.
Current configuration, workflow, policy, and state were read; workflow
structural validation passed. Research is authorized and the unrestricted
canonical goal remains unresolved. Only this review manuscript is owned.

**Disposition: both frozen source files and the exact family bridge are
accepted.** Fresh source compilation, the transitive axiom reports, and the
kernel probes below passed. This is an unconditional result for the stated
mirrored family at every chosen runner, with unbounded even total counts
N=2m+2>=4. It is not a proof of unrestricted LRC or of an odd-count family.

## Frozen core and environment

The complete `LonelyRunner/MirroredBlockWitness.lean` source was read and
hash-checked against
`70d94cf55b457f49dcfa8c22bf8a3404abb4db1aec5e43254749ea73711da9c1`.
It has 8,401 bytes. The accepted core manuscript and review remain the
mathematical references, at hashes `70b5545b8b7af311324967c7272a07f8d714eeabac2b21c381ae168326847e21`
and `05d75866a7c71bf10e34252545d726e4dd3f4910de6ce5795e4ce85b39a299d2`.

The pinned toolchain file specifies `leanprover/lean4:v4.32.1` and has SHA-256
`8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af`.
`lake-manifest.json` has SHA-256
`887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218`;
its mathlib revision is `520045ab14e26149ee970e2e617ca04b09bde5d6`.
The existing shared pinned dependency cache was used without restoration,
cleanup, or modification by the reviewer. This is fresh compilation of the
reviewed source, not a fresh rebuild of every transitive dependency.

## Exact public core contract

`LonelyRunner.mirroredConsecutiveBlockWitness` takes arbitrary natural m,p
and only the arithmetic premises `1<=m` and `2*m+1<=p`. It concludes
existence of a real t>0 such that the closed bound
`((2*m+2 : Nat) : Real)^(-1)` holds for p and for both i and the actual
natural speed p-i, for every natural i with `1<=i<=m`.

The proof explicitly derives i<=p before rewriting `Nat.cast_sub`, so no
truncated subtraction enters the high block's real phase. Similarly it proves
m<=p, positivity of p-m, and r<=m+1 before casting the other subtractions.
The quotient and remainder are natural division and modulus by positive N;
the time divisions and inverse are real. The proof has no supplied witness,
induction, coverage, coprimality, or minimal-counterexample premise.

The private phase-cell lemma uses `circleNorm_ge_of_int_band` with closed
integer bands for each original speed. That imported lemma was read along
with `circleNorm` and the canonical definitions. `circleNorm x` is the norm
of the image of x in `AddCircle 1`; it is the required circular distance
from zero. The source implements the accepted two-case proof, including
`(p-m)*t=k+delta` in the adjusted branch and the inequalities
`delta<=t<=2*delta`, `m*t+delta<=y<=1-delta`.

`mirroredBlockTime` separately defines the same case formula, but the public
theorem is existential and its proof does not state correctness of that
named definition. No universal named-time correctness theorem is claimed
by this review. Finite kernel checks below test its value and selected phases
only at the listed parameters.

The core covers designated stationary zero with 2m+1 distinct positive
moving speeds. Adding zero gives N=2m+2, an unbounded family of **even total
counts at least four**. It does not cover every total count, arbitrary speed
sets, or every chosen runner without the separately reviewed bridge.

## Fresh core compilation and kernel controls

From the repository root, the direct command

```bash
/home/joshua/.elan/bin/lake env lean LonelyRunner/MirroredBlockWitness.lean
```

exited zero without diagnostics. This command elaborates the target source;
it is not evidence obtained by importing an existing core object file.

A separate probe began with the exact 8,401-byte source and appended six
explicit public-contract instances, six equations for the named time, and
26 phase-band controls for actual original speeds. Thus the core is freshly
elaborated again in the probe rather than imported from a possibly stale
core object. Its only import is the core source's existing StructuredClasses
dependency. The fixed fixtures were `(1,3)`, `(1,4)`, `(2,8)`, `(2,9)`,
`(17,36000017)`, and `(4096,8194004096)`. These exercise m=1, minimal p,
remainder zero, both split boundaries, and large parameters.

Exact probe generation, using Python only to write Lean statements whose
proofs are checked by Lean:

```python
from pathlib import Path
from hashlib import sha256
from fractions import Fraction as F
from math import floor
src=Path('LonelyRunner/MirroredBlockWitness.lean').read_bytes()
assert sha256(src).hexdigest()== \
    '70d94cf55b457f49dcfa8c22bf8a3404abb4db1aec5e43254749ea73711da9c1'
fixtures=[(1,3),(1,4),(2,8),(2,9),(17,36000017),(4096,8194004096)]
parts=[src.decode(),'\nopen LonelyRunner\n',
       '#print axioms LonelyRunner.mirroredConsecutiveBlockWitness\n',
       '#print axioms LonelyRunner.mirroredBlockTime\n',
       '#print axioms LonelyRunner.circleNorm_ge_of_int_band\n']
controls=0
for m,p in fixtures:
    N=2*m+2
    k,r=divmod(p,N)
    t=F(1,N) if r>=m+1 else F(N*k+1,N*(p-m))
    parts.append(f'''\n-- Exact public existential contract at m={m}, p={p}.
example : ∃ t : ℝ, 0 < t ∧ (1 / {N} : ℝ) ≤ circleNorm (t * {p}) ∧
    ∀ i : ℕ, 1 ≤ i → i ≤ {m} →
      (1 / {N} : ℝ) ≤ circleNorm (t * (i : ℝ)) ∧
      (1 / {N} : ℝ) ≤ circleNorm (t * (({p} - i : ℕ) : ℝ)) := by
  simpa using mirroredConsecutiveBlockWitness {m} {p} (by omega) (by omega)
example : mirroredBlockTime {m} {p} = ({t.numerator} / {t.denominator} : ℝ) := by
  norm_num [mirroredBlockTime]
''')
    for a in sorted({1,m,p-m,p-1,p}):
        q=floor(a*t)
        parts.append(f'''example : (1 / {N} : ℝ) ≤ circleNorm (mirroredBlockTime {m} {p} * {a}) := by
  apply circleNorm_ge_of_int_band {q}
  all_goals norm_num [mirroredBlockTime]
''')
        controls+=1
path=Path('/tmp/endpoint-mirrored-core-review.lean')
path.write_text(''.join(parts))
assert controls==26
assert sha256(path.read_bytes()).hexdigest()== \
    '274fd97b4cee48594a92b20a0c809cef60f9255d0888532c38b2efb2b7ee6362'
```

After executing this block with `python3 -B`, run

```bash
/home/joshua/.elan/bin/lake env lean /tmp/endpoint-mirrored-core-review.lean
```

It exited zero. Each of the following three declarations reported exactly
`[propext, Classical.choice, Quot.sound]` under `#print axioms`:

- `LonelyRunner.mirroredConsecutiveBlockWitness`;
- `LonelyRunner.mirroredBlockTime`;
- `LonelyRunner.circleNorm_ge_of_int_band`.

The probe uses ordinary `omega`, `norm_num`, and checked theorem application,
not `native_decide` or an external verification axiom. No `sorryAx`, custom
axiom, or computational-trust dependency appeared in these transitive reports.

## Frozen family source and exact canonical bridge

The entire `LonelyRunner/MirroredBlockFamily.lean` source, 7,865 bytes, was
reviewed after freezing at SHA-256
`670b27d5e0083cf84999ad81410c9def4437f6d23fca7390374ffd2926169272`.
Its all-runner manuscript was bound to
`1253cae99e31ff66f66eea170307296f8b3a4c181661ea0e91e5d2d5c9f27e98`,
and the accepted independent manuscript review to
`367004c97821d9b96c5bd423626af5684c1c414d8f4334e2b5c1895b3756bb9d`.
Both were read; acceptance here additionally checks the actual formal source.

The six public family declarations have these roles:

| Declaration | Verified scope |
| --- | --- |
| `mirroredBlockSpeeds` | The natural speed set `[0,m] union [p-m,p]`. |
| `card_mirroredBlockSpeeds` | Under p>=2m+1, its cardinality is exactly 2m+2. This count lemma also permits m=0. |
| `mirroredBlockMagnitudeCover` | For m>=1 and P>=m+1, covers magnitudes in `[1,m] union [P-m,P]` at the unchanged threshold 1/(2m+2). |
| `mirroredBlockLowerRunner` | Positive relative witness for every chosen natural r<=m under the original m,p bounds. |
| `mirroredBlockRunnerWitness` | Positive relative witness for every r in the full mirrored set. |
| `mirroredBlockLonelyAt` | Canonical `LonelyAt` for every runner under every injective natural-speed labelling of length 2m+2 whose image lies in the set. |

The count proof establishes disjointness before summing the two closed
interval cardinalities. It handles natural subtraction using p>=2m+1.
The magnitude-cover lemma correctly permits overlapping magnitude blocks:
when P<=2m+1 it uses 1/N, and every listed magnitude is in `[1,N-1]`;
otherwise it applies the core at m,P. It never obtains a stronger threshold
by deduplicating absolute relative speeds.

For a lower runner, the source distinguishes s<=r from r<s before casting
the natural magnitude r-s or s-r. It uses `circleNorm_neg` for the negative
signed phase. Upper-block magnitudes are bounded between p-r-m and p-r,
with p-r>=m+1. For an upper chosen runner, it proves that s->p-s preserves
membership and distinctness, proves both s<=p and r<=p before casting, and
checks the signed identity `(p-s)-(p-r)=-(s-r)`. The reflected chosen label
and every comparison label are transported together. There is no reuse of
a zero-runner witness for a different runner without this symmetry argument.

The final theorem's labelling has domain `Fin (2*m+2)`, not a deduplicated
relative-speed index set. It assumes injectivity and membership only; it
requires no witness premise. For distinct labels, injectivity gives distinct
natural speeds. The pointwise result is translated using the existing
`lonelyAt_iff_relativeLonelyAt`, whose full definition/proof was inspected.
`LonelyAt` uses the inverse of its actual domain size and all other labels,
with closed distance and the ordinary `AddCircle 1` metric. Thus the bound
is exactly the original canonical threshold. The quantifier order is
`forall runner, exists t>0`; it does not assert one time for all runners.

There is no enumeration definition in the source. This does not make the
labelled theorem vacuous: the generic kernel probe below constructs such
a labelling from `Finset.equivFinOfCardEq`, proves both natural and real-cast
injectivity, and applies the theorem for every runner. The exact cardinality
also means an injective labelling of this size contained in the set covers
the full set. The theorem still concerns these natural speeds cast to reals,
not every real-valued configuration.

## Fresh family compilation and nonvacuous labelled controls

The direct command

```bash
/home/joshua/.elan/bin/lake env lean LonelyRunner/MirroredBlockFamily.lean
```

exited zero without diagnostics. A second probe combines both frozen source
bodies, removes only their import lines, and places their external imports
at the top. In particular it imports neither reviewed module's object file.
Both complete source bodies are freshly elaborated in this probe.

The final exact generator is:

```python
from pathlib import Path
from hashlib import sha256
core=Path('LonelyRunner/MirroredBlockWitness.lean').read_text()
family=Path('LonelyRunner/MirroredBlockFamily.lean').read_text()
assert sha256(core.encode()).hexdigest()== \
    '70d94cf55b457f49dcfa8c22bf8a3404abb4db1aec5e43254749ea73711da9c1'
assert sha256(family.encode()).hexdigest()== \
    '670b27d5e0083cf84999ad81410c9def4437f6d23fca7390374ffd2926169272'
def body(s):
    return '\n'.join(line for line in s.splitlines() if not line.startswith('import '))+'\n'
parts=['import LonelyRunner.StructuredClasses\nimport Mathlib.Order.Interval.Finset.Nat\nimport Mathlib.Data.Fintype.EquivFin\n',body(core),body(family),'\nopen LonelyRunner\n']
for name in ['mirroredBlockSpeeds','card_mirroredBlockSpeeds','mirroredBlockMagnitudeCover',
             'mirroredBlockLowerRunner','mirroredBlockRunnerWitness','mirroredBlockLonelyAt']:
    parts.append(f'#print axioms LonelyRunner.{name}\n')
parts.append('''
def EndpointReviewLabelledProperty (m p : ℕ) : Prop :=
  ∃ speeds : Fin (2*m+2) → ℕ,
    Function.Injective speeds ∧
    Function.Injective (fun i => (speeds i : ℝ)) ∧
    (∀ i, speeds i ∈ mirroredBlockSpeeds m p) ∧
    ∀ runner, ∃ t : ℝ, 0 < t ∧ LonelyAt (fun i => (speeds i : ℝ)) runner t

theorem endpointReview_nonvacuousLabelledFamily (m p : ℕ) (hm : 1 ≤ m)
    (hp : 2*m+1 ≤ p) : EndpointReviewLabelledProperty m p := by
  classical
  let e : mirroredBlockSpeeds m p ≃ Fin (2*m+2) :=
    Finset.equivFinOfCardEq (card_mirroredBlockSpeeds m p hp)
  let speeds : Fin (2*m+2) → ℕ := fun i => (e.symm i).val
  have hinj : Function.Injective speeds := by
    intro i j hij
    apply e.symm.injective
    apply Subtype.ext
    exact hij
  have hreal : Function.Injective (fun i => (speeds i : ℝ)) := by
    intro i j hij
    apply hinj
    change (speeds i : ℝ) = (speeds j : ℝ) at hij
    exact_mod_cast hij
  have hmem : ∀ i, speeds i ∈ mirroredBlockSpeeds m p := by
    intro i
    exact (e.symm i).property
  exact ⟨speeds, hinj, hreal, hmem, mirroredBlockLonelyAt m p hm hp speeds hinj hmem⟩

#print axioms endpointReview_nonvacuousLabelledFamily
''')
fixtures=[(1,4,0),(1,4,1),(1,4,3),(1,4,4),
          (2,5,2),(2,5,3),(2,6,1),(2,6,5),(2,8,0),(2,9,9),
          (17,36000017,17),(17,36000017,36000000),
          (4096,8194004096,0),(4096,8194004096,8194004096)]
for m,p,r in fixtures:
    N=2*m+2
    parts.append(f'''\nexample : ∃ t : ℝ, 0 < t ∧ ∀ s : ℕ,
    s ∈ mirroredBlockSpeeds {m} {p} → s ≠ {r} →
    (1 / {N} : ℝ) ≤ circleNorm (t * ((s : ℝ) - {r})) := by
  simpa using mirroredBlockRunnerWitness {m} {p} (by omega) (by omega) {r}
    (by norm_num [mirroredBlockSpeeds])
''')
labelled=[(1,3),(1,4),(2,5),(2,8),(2,9),(17,36000017),(4096,8194004096)]
for m,p in labelled:
    N=2*m+2
    parts.append(f'''\nexample : (mirroredBlockSpeeds {m} {p}).card = {N} := by
  simpa using card_mirroredBlockSpeeds {m} {p} (by omega)
example : EndpointReviewLabelledProperty {m} {p} :=
  endpointReview_nonvacuousLabelledFamily {m} {p} (by omega) (by omega)
''')
path=Path('/tmp/endpoint-mirrored-family-review.lean')
path.write_text(''.join(parts))
assert len(fixtures)==14 and len(labelled)==7
assert sha256(path.read_bytes()).hexdigest()== \
    '7b2529dd6cf57dda5b7ca73caadc526e335a2833fa0645fe81ba71f9a31c7246'
```

Generate both probes from this manuscript and run them as follows:

```bash
python3 -B - <<'FORMAL_REVIEW_PROBES'
from pathlib import Path
import re
p=Path('research/astra-mirrored-formal-review.md')
blocks=re.findall(r'^```python\n(.*?)^```[ \t]*$',p.read_text(),re.M|re.S)
assert len(blocks)==2
for i,code in enumerate(blocks):
    exec(compile(code,f'{p}:block{i+1}','exec'),{})
FORMAL_REVIEW_PROBES
/home/joshua/.elan/bin/lake env lean /tmp/endpoint-mirrored-core-review.lean
/home/joshua/.elan/bin/lake env lean /tmp/endpoint-mirrored-family-review.lean
```

The final family probe exited zero. All six listed public family declarations
and `endpointReview_nonvacuousLabelledFamily` reported exactly
`[propext, Classical.choice, Quot.sound]`. Fourteen chosen-runner controls
and seven exact-cardinality/nonvacuous-labelled fixtures passed, including
lower and upper runners, negative relative speeds, repeated magnitudes,
m=1, minimal p, the small/large boundary, and large parameters.

The first family probe attempt failed only in the review helper: its
`exact_mod_cast hij` saw an unapplied lambda expression instead of the
displayed real-cast equality. That failed helper generated a `sorryAx`
report and was not accepted. Adding the explicit `change` line shown above
fixed the temporary probe. No reviewed source was changed; the final probe
compiled without errors and its helper's axiom report contains no `sorryAx`.

## Final scope and verification boundary

The two source hashes above remain the acceptance targets. The reviewer
made no Lean-source, shared-cache, Git, state, or integration changes. The
only project file written is this review; temporary Lean probes contain
reproducible kernel checks. No dependency restoration or cleanup ran.

Core and family direct compilations, both final fresh-source probes, and
the allowed-axiom checks passed. Whole-project build/import integration and
the repository-wide trust audit are separate orchestrator-owned checks;
they are not inferred from these local probes. All reviewer Lean processes
completed. The accepted result is the exact mirrored family with a positive
time for each chosen runner. Unrestricted LRC remains unresolved.
