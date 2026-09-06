# Five-runner ordinary assembly implementation

## Scope and source checkpoint

Implemented only the settled assembly in `FiveRunnerOrdinary.lean` and the
one-line `FiveRunnerCanonical.lean` specialization, against the accepted plan
`research/astra-five-runner-assembly-plan.md`:

| Input | SHA-256 |
| --- | --- |
| settled assembly plan | `dcfd7e6133c9b2018596b9ff76d5861fb0abc906e1e6fd00a5ac422a3c3d20bf` |
| `LonelyRunner/FiveRunnerOrdinary.lean` | `662d0116f13971bce85e76c503e2f3be4fdc6291ba8113aeda43957e38354ffe` |
| `LonelyRunner/FiveRunnerCanonical.lean` | `a78cdaafcc359110535422d1967676610587a69be8f2bf8810e0ba65be1c8946` |

The ordinary module applies the existing filtered multiplier in the
non-crowded branch.  In the crowded branch it uses `p.succAbove`, the exact
factorization `5^m = 5^j * 5^(m-j)`, the frozen hard-pattern theorem at
`m-j`, and `fiveAdic_cyclicResidueDistance_mul_left` to recover all four
original labels.  The output multiplier remains bounded by the original
modulus.  `fourMovingNaturalMultiplier` chooses an attained exponent maximum;
`fourMovingNaturalRunners` uses `lam / (5 * 5^m)`; and `H_6` uses the existing
`H_5` for `d <= 3` and the new four-moving witness only at `d = 4`.

The canonical module specializes `lonelyAt_of_lowerCount` at `m = 4`.  It
therefore quantifies exactly `Fin 5` real speeds and a chosen runner.

## Focused Lean verification

The original report incorrectly marked its first standalone declaration probe
as successful.  That command imported only `FiveRunnerCanonical`, then asked
for the older `fourRunners` declaration.  `fourRunners` belongs to the separate
`FourRunnerCanonical` module, so Lean returned exit `1` with the raw diagnostic
`<stdin>:7:7: error: Unknown identifier LonelyRunner.fourRunners`.  The command
put `sha256sum` at the end of a pipeline, obscuring the diagnostic in its
printed output. The command did include `set -euo pipefail` and returned `1`;
the earlier report misclassified that result as a pass. The retained facts are:

| original artifact | SHA-256 / result |
| --- | --- |
| report before this correction | `63a5b71c23e65182f27a704263d471330624a4e1a1a8de0792a50779fc176c70` |
| original command | `ef2eb28f5a584a6518c2f1f8e11dc93d1f4d04a5962e333712a89e59d04e459e`; exit `1` |
| original hash-pipeline stdout | `f387b0612875e66eba815c9f90a4e3b445a28a5adc58e0c12fecc7a1a556cbf0` |
| raw failing stdout | `02e5a0f8a75bb8c3a8193dc9fc7eeec372ebe32a40dccdcb5e850cc64dad2757` |

This correction adds the explicit old-module import, exports Elan's path, and
uses `subprocess.run` to inspect Lean's actual return code and both streams.
The input contains both `#check` output and explicit universal-type `example`
checks for every five new declaration, plus the retained old `fourRunners`
type. The exact readable Lean input is embedded below; no temporary probe
file is required.

```bash
set -euo pipefail
export PATH="$HOME/.elan/bin:$PATH"
lake build LonelyRunner.FiveRunnerOrdinary LonelyRunner.FiveRunnerCanonical >/dev/null
python3 -B - <<'PY'
from hashlib import sha256
from subprocess import PIPE, run
probe = r"""import LonelyRunner.FiveRunnerCanonical
import LonelyRunner.FourRunnerCanonical
#check LonelyRunner.fiveAdic_four_label_multiplier
#check LonelyRunner.fourMovingNaturalMultiplier
#check LonelyRunner.fourMovingNaturalRunners
#check LonelyRunner.lowerCountPositiveIntegerHypothesis_six
#check LonelyRunner.fiveRunners
#check LonelyRunner.fourRunners
example : ∀ (d ell u : Fin 4 → Nat) (m : Nat),
    (∀ i, 0 < d i) → (∀ i, d i = 5 ^ ell i * u i) →
    (∀ i, ¬ 5 ∣ u i) → (∀ i, ell i ≤ m) → (∃ p, ell p = m) →
    ∃ lam, 0 < lam ∧ lam < 5 * 5^m ∧ ¬ 5 ∣ lam ∧
      ∀ i, 5^m ≤ LonelyRunner.cyclicResidueDistance (5 * 5^m) (lam * d i) :=
  LonelyRunner.fiveAdic_four_label_multiplier
example : ∀ speeds : Fin 4 → Nat, (∀ i, 0 < speeds i) →
    ∃ m lam, 0 < lam ∧ lam < 5 * 5^m ∧ ¬ 5 ∣ lam ∧
      ∀ i, 5^m ≤ LonelyRunner.cyclicResidueDistance (5 * 5^m) (lam * speeds i) :=
  LonelyRunner.fourMovingNaturalMultiplier
example : ∀ speeds : Fin 4 → Nat, (∀ i, 0 < speeds i) → ∃ t : Real, 0 < t ∧
    ∀ i, (5 : Real)⁻¹ ≤ LonelyRunner.circleNorm (t * (speeds i : Real)) :=
  LonelyRunner.fourMovingNaturalRunners
example : LonelyRunner.LowerCountPositiveIntegerHypothesis 6 :=
  LonelyRunner.lowerCountPositiveIntegerHypothesis_six
example : ∀ (speeds : Fin 5 → Real), Function.Injective speeds → ∀ runner : Fin 5,
    ∃ t : Real, LonelyRunner.LonelyAt speeds runner t := LonelyRunner.fiveRunners
example : ∀ (speeds : Fin 4 → Real), Function.Injective speeds → ∀ runner : Fin 4,
    ∃ t : Real, LonelyRunner.LonelyAt speeds runner t := LonelyRunner.fourRunners
#print axioms LonelyRunner.fiveAdic_four_label_multiplier
#print axioms LonelyRunner.fourMovingNaturalMultiplier
#print axioms LonelyRunner.fourMovingNaturalRunners
#print axioms LonelyRunner.lowerCountPositiveIntegerHypothesis_six
#print axioms LonelyRunner.fiveRunners
""".encode()
p = run(["lake", "env", "lean", "--stdin"], input=probe, stdout=PIPE, stderr=PIPE)
assert p.returncode == 0, (p.returncode, p.stdout.decode(), p.stderr.decode())
assert b"error:" not in p.stdout and b"error:" not in p.stderr
assert p.stderr == b""
print("probe_source_sha256=" + sha256(probe).hexdigest())
print("probe_stdout_sha256=" + sha256(p.stdout).hexdigest())
print("probe_stderr_sha256=" + sha256(p.stderr).hexdigest())
print(p.stdout.decode(), end="")
PY
```

The corrected standalone command exited `0`, with no stderr and no `error:`
diagnostic.  Its complete command SHA-256 is
`0ed431149be2935776dd1f9a9d101c6bdf2bd1da48bbe1ccfe70332610929c67`;
the embedded subprocess program SHA-256 is
`44501584f75f23fed13c41840ea4f354ca62441c4f5b1b5c6e8ad8dd6b22a50d`;
the decoded Lean stdin program SHA-256 is
`a31fc9eacec2594e7c6fe8f162627bedcd512cd4e9f413344306c94de8b36cd1`;
and its Lean stdout SHA-256 is
`ad086aaf529f7adb2efd6ea6377b45b64dfb0195bb9ee222ec99ca3dcc0a3f4f`.
The empty stderr hash is
`e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.
An extraction-and-replay of this exact fenced command also exited `0`; its
complete command stdout hash (the three hash labels plus Lean stdout) was
`4b8627cf8eaa9dad4d3a8b72388d75ce4b39774476cdfc79faafa12b8b55420b`,
and its stderr was the same empty-stream hash.

The explicit examples passed for the certified `Fin 4` multiplier, attained
maximum multiplier, positive real witness, `H_6`, and chosen-runner `Fin 5`
canonical witness; the existing `Fin 4` `fourRunners` example passed as well.
Each of the five new declarations reported exactly `[propext,
Classical.choice, Quot.sound]` as axioms.

Direct source checks also exited `0`:

```bash
set -euo pipefail
lake env lean LonelyRunner/FiveRunnerOrdinary.lean
lake env lean LonelyRunner/FiveRunnerCanonical.lean
lake env lean LonelyRunner/FourRunnerCanonical.lean
```

The named build and the direct source checks emitted only pre-existing linter
warnings from imported frozen modules; neither new source emitted a warning or
error. `git diff --check` passed.  A focused source scan found no occurrence
of `sorry`, `admit`, `axiom`, `native_decide`, `unsafe`, or `implemented_by`
in either new module.

## Settled bounded controls

The exact embedded Python program in the settled plan was run with its own
source and stdout hashes asserted:

```bash
set -euo pipefail
python3 -B - <<'PY'
from pathlib import Path
from hashlib import sha256
import subprocess, sys
text = Path('research/astra-five-runner-assembly-plan.md').read_text()
blocks = text.split('```python\n')[1:]
assert len(blocks) == 1
code = blocks[0].split('```', 1)[0].encode()
assert sha256(code).hexdigest() == '4e4c3ef87641be643279612347a2503febb548401ee3b9695e5f12fb0194ca7a'
run = subprocess.run([sys.executable, '-B', '-c', code.decode()], capture_output=True)
assert run.returncode == 0, (run.returncode, run.stdout, run.stderr)
assert run.stderr == b''
assert sha256(run.stdout).hexdigest() == 'f899e54580e92adf78c6c3ad8789eb25255f911718106a062df87c8aa71258bf'
sys.stdout.buffer.write(run.stdout)
PY
```

It exited `0` with empty stderr.  Program SHA-256 was
`4e4c3ef87641be643279612347a2503febb548401ee3b9695e5f12fb0194ca7a` and
stdout SHA-256 was
`f899e54580e92adf78c6c3ad8789eb25255f911718106a062df87c8aa71258bf`.
It passed all 16 frozen source guards, five fixed natural controls (including
the two scaled hard controls at time `53/625`), four complement maps, both
degenerate scaling controls, and the signed chosen-runner fixture.

This is a bounded implementation and verification checkpoint.  It proves the
ordinary five-total-runner specialization only; it does not establish the
unrestricted Lonely Runner Conjecture.
