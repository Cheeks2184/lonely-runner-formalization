# Independent review of the frozen constrained-maximizer implementation

2026-09-06. Requested Astra/xhigh; observed runtime model and effort are not
independently attested. Only this report is owned. Project configuration,
workflow, policy, and focused state were read; the workflow validator passed.
Source checkpoint supplied by the orchestrator:
`f1d45fdf95af26f31cffcc92485fc5951c4b0169`.

**Verdict: accept the frozen implementation of all four public theorems.**
The full universal type assignments, all predeclared fixed boundary controls,
and allowed-axiom checks passed in the final focused import-only run. No
source defect or contract change was found. No source, imports, state, Git,
or cache were edited by this reviewer. This is acceptance of the generic
helpers, not a six-total or unrestricted LRC result.

Review target: `LonelyRunner/ConstrainedMaximizer.lean`, 13,143 bytes,
SHA-256 `2ef07e6b83b8675a22184571c31d2a71dab9d5c072e3cd165cb8382957b46e92`.
The entire module was read. Terra authored the initial norm helper; root
authored P, the private positive-objective helper, M, and D. This reviewer
authored the mathematical plan, but did not author or edit this Lean source.
The separate manuscript review was performed by another Astra agent.

The accepted reference contracts are the author plan
`ef0b17914b831106650ff0f09152054131fcaba58ce47a10a0bf36c0fdccb100`
and independent manuscript review
`d65b1a984cc6a6469b2200c40e061cdb5462d34c6fb15d5804d5e15057a418a0`.
Both were read and their frozen hashes checked. The root-reported focused
source build passed with 1844 jobs and no warnings; that build is attributed
to root, not claimed as a build rerun by this review.

## Source contract and proof audit

The source matches the accepted P/M/D declarations without weakening a
hypothesis or conclusion. The four public theorems are
`circleNorm_eq_min_fract`, `exists_forward_complement_improvement`,
`exists_oriented_complement_maximizer`, and
`reciprocal_dilate_shift_improves`. `ComplementSafe` is the actual closed
condition on every label other than the distinguished one.

The norm helper subtracts the integer floor and handles both sides of one
half. On the upper branch it translates by -1 before using the half-unit
norm formula. The strict fractional upper bound excludes the spurious
zero norm at fractional phase 1. There is no assumption that fractional
part is globally continuous.

P takes any universe-polymorphic finite label type, a distinguished label,
positive natural speeds, arbitrary real time, and any real margin in
`(0,1/2)`. It allows repeated speeds. Its capacity minimum includes the
distinguished label, so nonemptiness follows from the given label and no
nonempty-complement premise is hidden. Positivity of speeds makes every
capacity and forward increment positive. The exact old integer floor is
retained in the updated phase identity. A complement phase equal to the
lower margin is allowed; every upper bound is strict before perturbation.
The distinguished phase starts in `[0,1/2)` and remains on its increasing
norm branch. The output is closed complement safety and strict improvement.

The private helper uses the strict complement seed exactly as stated.
If its distinguished norm is zero, the min formula and fractional bounds
force its phase to zero; P then supplies a positive feasible objective.
It does not infer positivity merely from closed feasibility.

M defines the closed complement-safe set, intersects it with `[0,1]`,
and uses norm continuity to attain a maximum. Fractional-time normalization
is applied to both constraints and the objective, making the resulting
bound global over **all real feasible times**. The positive feasible value
excludes both compact-interval endpoints. The no-full-closed-witness
hypothesis implies the strict bound `maximum < delta`, including exclusion
of equality. Reflection is chosen from the distinguished fractional phase,
not the time coordinate. The reflected remainder is certified by an
explicit integer `v_i-floor(u*v_i)-1`. Its representative is positive and
below one, justified by the positive maximum and margin bounds.

The final face argument extracts an actual label distinct from i with
fractional phase exactly `1-delta`. If no such label existed, every
complement phase would satisfy P's upper-strict interval, producing a
globally feasible time with a larger objective. It does not conclude only
an unoriented norm equality or rely on a lower face blocking forward motion.
The theorem has no cardinality, gcd, injectivity, reciprocal-margin, or
complement-nonemptiness restriction beyond its explicit hypotheses.

D keeps arbitrary natural N,d,alpha with `N>=3`, `N|d`,
`2<=alpha<N`, arbitrary real t, and **every integer beta**. Its positive
fractional-phase premise already rules out d=0. It proves both
`x<alpha*x` and `x<1-alpha*x`, using `(alpha+1)*x<=N*x<1` for the latter;
there is no incorrect monotonicity assumption after crossing one half.
Writing `d=N*q` makes the shift integer `beta*q`, and the final floor-band
identity includes `alpha*floor(t*d)+beta*q`. No primality, beta sign, or
speed distinctness assumption is introduced. The strict endpoints on x
are retained.

No mathematical defect or contract drift was found in the source read.
Kernel probe acceptance and its exact evidence are recorded below. This
module is directly importable but was not yet imported by the
frozen root module; this review does not alter that staged integration.
No new runner count, six-total assembly, or unrestricted LRC conclusion
follows from these conditional generic helpers alone.

## Fixed probe predeclaration

One fixed import-only Lean probe is declared below: four full universal contract
assignments, four public-theorem axiom prints, and fixed rational controls.
There is no search, solver experiment, candidate enumeration, source build,
or cache restoration. `norm_num` and `linarith` here produce ordinary Lean
proof terms for fixed arithmetic; no `native_decide` is used.

The fixed controls are norm values at `-1/10,0,1/10,1/2,9/10,11/10`;
P on two repeated unit speeds with time and margin 1/6; D with N=6,d=12,
alpha=5,t=1/80 and arbitrary integer beta; its explicit beta=-3 and beta=2
phase identities, crossing the half point; equality at x=1/6 for alpha=5;
and the strict/closed distinction for the fixed `(3,1,2)` seed at time 1/3.
The seed control checks that particular boundary point, not a new universal
claim about the entire feasible set. D's general beta test is accompanied
by exact negative/positive shift evaluations.

The import uses the existing artifact at
`.lake/build/lib/lean/LonelyRunner/ConstrainedMaximizer.olean`, SHA-256
`443a61889184bd7fc7ea52a85ebcfa3fc0ba6f1e458b34824afb166812f38170`.
The source, artifact, accepted manuscripts, toolchain, and manifest are
guarded before and after the run. Importing this artifact and checking the
probe is separate from root's reported source build; both provenance facts
are retained. The shared cache is read, preserved, and not cleaned.

Run limit: 60 seconds child-process wall time, CPU soft/hard 59/60 seconds,
an initial 2 GiB address-space limit per subprocess, corrected through 4 GiB
to 8 GiB after the fixed startup/import mapping evidence recorded below;
output files capped at 256 KiB
each, and total retained evidence below 1 MiB. These are explicit bounds,
not a prediction of memory usage. A failed probe is recorded as such and
does not authorize source changes or a broader experiment.

## Complete Lean probe

```lean
import LonelyRunner.ConstrainedMaximizer

set_option autoImplicit false
set_option maxHeartbeats 1000000
set_option linter.unusedVariables false

open LonelyRunner
universe u

-- Each assignment checks the complete public type at an arbitrary universe.
example : ∀ x : ℝ, circleNorm x = min (Int.fract x) (1 - Int.fract x) :=
  circleNorm_eq_min_fract

example {I : Type u} [Fintype I] [DecidableEq I]
    (v : I → ℕ) (i : I) (hv : ∀ j, 0 < v j)
    (δ s : ℝ) (hδ : 0 < δ) (hδhalf : δ < (1 : ℝ) / 2)
    (hi : Int.fract (s * (v i : ℝ)) < (1 : ℝ) / 2)
    (hbands : ∀ j, j ≠ i →
      δ ≤ Int.fract (s * (v j : ℝ)) ∧
      Int.fract (s * (v j : ℝ)) < 1 - δ) :
    ∃ ε : ℝ, 0 < ε ∧ ComplementSafe v i δ (s + ε) ∧
      circleNorm (s * (v i : ℝ)) <
        circleNorm ((s + ε) * (v i : ℝ)) :=
  exists_forward_complement_improvement v i hv δ s hδ hδhalf hi hbands

example {I : Type u} [Fintype I] [DecidableEq I]
    (v : I → ℕ) (i : I) (hv : ∀ j, 0 < v j)
    (δ : ℝ) (hδ : 0 < δ) (hδhalf : δ < (1 : ℝ) / 2)
    (hstrict : ∃ s : ℝ, ∀ j, j ≠ i →
      δ < circleNorm (s * (v j : ℝ)))
    (hno : ¬ ∃ t : ℝ, ∀ j, δ ≤ circleNorm (t * (v j : ℝ))) :
    ∃ τ : ℝ, 0 < τ ∧ τ < 1 ∧ ComplementSafe v i δ τ ∧
      (∀ t : ℝ, ComplementSafe v i δ t →
        circleNorm (t * (v i : ℝ)) ≤ circleNorm (τ * (v i : ℝ))) ∧
      0 < Int.fract (τ * (v i : ℝ)) ∧
      Int.fract (τ * (v i : ℝ)) < δ ∧
      Int.fract (τ * (v i : ℝ)) = circleNorm (τ * (v i : ℝ)) ∧
      ∃ j, j ≠ i ∧ Int.fract (τ * (v j : ℝ)) = 1 - δ :=
  exists_oriented_complement_maximizer v i hv δ hδ hδhalf hstrict hno

example (N d α : ℕ) (β : ℤ) (t : ℝ) (hN : 3 ≤ N)
    (hdiv : N ∣ d) (hα : 2 ≤ α) (hαN : α < N)
    (hx : 0 < Int.fract (t * (d : ℝ)))
    (hxN : Int.fract (t * (d : ℝ)) < (N : ℝ)⁻¹) :
    circleNorm (t * (d : ℝ)) <
      circleNorm (((α : ℝ) * t + (β : ℝ) / (N : ℝ)) * (d : ℝ)) :=
  reciprocal_dilate_shift_improves N d α β t hN hdiv hα hαN hx hxN

#print axioms LonelyRunner.circleNorm_eq_min_fract
#print axioms LonelyRunner.exists_forward_complement_improvement
#print axioms LonelyRunner.exists_oriented_complement_maximizer
#print axioms LonelyRunner.reciprocal_dilate_shift_improves

-- Exact integer floor certificates, including negative real phases.
private theorem norm_from_band (x r : ℝ) (z : ℤ)
    (hr0 : 0 ≤ r) (hr1 : r < 1) (hx : x = (z : ℝ) + r) :
    circleNorm x = min r (1 - r) := by
  have hf : Int.fract x = r := by
    apply Int.fract_eq_iff.mpr
    refine ⟨hr0, hr1, ⟨z, ?_⟩⟩
    linarith
  rw [circleNorm_eq_min_fract, hf]

example : circleNorm (-(1 : ℝ) / 10) = (1 : ℝ) / 10 ∧
    circleNorm 0 = 0 ∧
    circleNorm ((1 : ℝ) / 10) = (1 : ℝ) / 10 ∧
    circleNorm ((1 : ℝ) / 2) = (1 : ℝ) / 2 ∧
    circleNorm ((9 : ℝ) / 10) = (1 : ℝ) / 10 ∧
    circleNorm ((11 : ℝ) / 10) = (1 : ℝ) / 10 := by
  have hn := norm_from_band (-(1 : ℝ) / 10) (9 / 10) (-1)
    (by norm_num) (by norm_num) (by norm_num)
  have hz := norm_from_band 0 0 0 (by norm_num) (by norm_num) (by norm_num)
  have hp := norm_from_band ((1 : ℝ) / 10) (1 / 10) 0
    (by norm_num) (by norm_num) (by norm_num)
  have hh := norm_from_band ((1 : ℝ) / 2) (1 / 2) 0
    (by norm_num) (by norm_num) (by norm_num)
  have hl := norm_from_band ((9 : ℝ) / 10) (9 / 10) 0
    (by norm_num) (by norm_num) (by norm_num)
  have hu := norm_from_band ((11 : ℝ) / 10) (1 / 10) 1
    (by norm_num) (by norm_num) (by norm_num)
  norm_num at hn hz hp hh hl hu ⊢
  exact ⟨hn, hz, hp, hh, hl, hu⟩

-- Repeated inputs and a lower-endpoint equality remain admissible for P.
example : ∃ ε : ℝ, 0 < ε ∧
    ComplementSafe (fun _ : Fin 2 => 1) 0 ((1 : ℝ) / 6) ((1 : ℝ) / 6 + ε) ∧
    circleNorm ((1 : ℝ) / 6 * 1) < circleNorm (((1 : ℝ) / 6 + ε) * 1) := by
  have hf : Int.fract ((1 : ℝ) / 6) = (1 : ℝ) / 6 :=
    Int.fract_eq_self.mpr ⟨by norm_num, by norm_num⟩
  have result := exists_forward_complement_improvement (fun _ : Fin 2 => 1) 0
    (by intro j; norm_num) ((1 : ℝ) / 6) ((1 : ℝ) / 6)
    (by norm_num) (by norm_num)
    (by simpa only [Nat.cast_one, mul_one, hf] using
      (show (1 : ℝ) / 6 < 1 / 2 by norm_num))
    (by intro j hj; norm_num only [Nat.cast_one, mul_one, hf]; trivial)
  simpa only [Nat.cast_one] using result

-- D applied to fixed speeds and phase, still universally quantified over beta.
example (β : ℤ) : circleNorm ((1 : ℝ) / 80 * 12) <
    circleNorm ((5 * ((1 : ℝ) / 80) + (β : ℝ) / 6) * 12) := by
  have hf : Int.fract ((1 : ℝ) / 80 * 12) = (3 : ℝ) / 20 := by
    apply Int.fract_eq_iff.mpr
    exact ⟨by norm_num, by norm_num, ⟨0, by norm_num⟩⟩
  refine reciprocal_dilate_shift_improves 6 12 5 β ((1 : ℝ) / 80)
    (by norm_num) (by norm_num) (by norm_num) (by norm_num) ?_ ?_
  · simpa only [Nat.cast_ofNat] using
      (show 0 < Int.fract ((1 : ℝ) / 80 * 12) by rw [hf]; norm_num)
  · simpa only [Nat.cast_ofNat] using
      (show Int.fract ((1 : ℝ) / 80 * 12) < (6 : ℝ)⁻¹ by rw [hf]; norm_num)

example : (5 * ((1 : ℝ) / 80) + (-3 : ℝ) / 6) * 12 = -(21 : ℝ) / 4 ∧
    circleNorm (-(21 : ℝ) / 4) = (1 : ℝ) / 4 ∧
    (5 * ((1 : ℝ) / 80) + (2 : ℝ) / 6) * 12 = (19 : ℝ) / 4 ∧
    circleNorm ((19 : ℝ) / 4) = (1 : ℝ) / 4 ∧
    (3 : ℝ) / 20 < 1 / 4 := by
  have hn := norm_from_band (-(21 : ℝ) / 4) (3 / 4) (-6)
    (by norm_num) (by norm_num) (by norm_num)
  have hp := norm_from_band ((19 : ℝ) / 4) (3 / 4) 4
    (by norm_num) (by norm_num) (by norm_num)
  norm_num at hn hp ⊢
  exact ⟨hn, hp⟩

-- The upper endpoint excluded by D can give equality instead of improvement.
example : circleNorm ((1 : ℝ) / 6) = circleNorm (5 * ((1 : ℝ) / 6)) := by
  have h1 := norm_from_band ((1 : ℝ) / 6) (1 / 6) 0
    (by norm_num) (by norm_num) (by norm_num)
  have h5 := norm_from_band (5 * ((1 : ℝ) / 6)) (5 / 6) 0
    (by norm_num) (by norm_num) (by norm_num)
  norm_num at h1 h5 ⊢
  exact h1.trans h5.symm

-- Fixed seed (3,1,2) at t=1/3: closed complement, zero objective, not strict.
example : circleNorm ((1 : ℝ) / 3) = (1 : ℝ) / 3 ∧
    circleNorm ((2 : ℝ) / 3) = (1 : ℝ) / 3 ∧
    circleNorm 1 = 0 ∧ ¬ ((1 : ℝ) / 3 < circleNorm ((1 : ℝ) / 3)) := by
  have h1 := norm_from_band ((1 : ℝ) / 3) (1 / 3) 0
    (by norm_num) (by norm_num) (by norm_num)
  have h2 := norm_from_band ((2 : ℝ) / 3) (2 / 3) 0
    (by norm_num) (by norm_num) (by norm_num)
  have hz := norm_from_band 1 0 1 (by norm_num) (by norm_num) (by norm_num)
  norm_num at h1 h2 hz
  refine ⟨h1, h2, hz, ?_⟩
  rw [h1]
  norm_num
```

## Complete guarded Bash replay

This creates only a fresh temporary evidence directory and runs the probe
through the pinned project environment. It does not run `lake build` or
request any import change. Source guards are frozen below; the probe hash
is filled by static text hashing before the first execution.

```bash
#!/usr/bin/env bash
set -euo pipefail
cd /home/joshua/lonely-runner-formalization
export PATH="$HOME/.elan/bin:$PATH"
export LEAN_NUM_THREADS=1
export LEAN_STACK_SIZE_KB=65536
python3 - <<'PY'
import hashlib
import json
import os
from pathlib import Path
import resource
import signal
import subprocess
import tempfile
import time

root = Path('/home/joshua/lonely-runner-formalization')
report = root / 'research/astra-constrained-maximizer-final-source-review.md'
text = report.read_text()
probe = (text.split('```lean\n', 1)[1].split('\n```', 1)[0] + '\n').encode()
launcher = (text.split('```bash\n', 1)[1].split('\n```', 1)[0] + '\n').encode()
expected_probe = '120c938fe6ba3eeb2c3b5f9b805d5dc9203e20690dc495a2481517852764e858'
guards = {
    'LonelyRunner/ConstrainedMaximizer.lean': '2ef07e6b83b8675a22184571c31d2a71dab9d5c072e3cd165cb8382957b46e92',
    '.lake/build/lib/lean/LonelyRunner/ConstrainedMaximizer.olean': '443a61889184bd7fc7ea52a85ebcfa3fc0ba6f1e458b34824afb166812f38170',
    'research/astra-six-total-maximizer-plan.md': 'ef0b17914b831106650ff0f09152054131fcaba58ce47a10a0bf36c0fdccb100',
    'research/astra-six-total-maximizer-review.md': 'd65b1a984cc6a6469b2200c40e061cdb5462d34c6fb15d5804d5e15057a418a0',
    'lean-toolchain': '8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af',
    'lake-manifest.json': '887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218',
}

def digest(data):
    return hashlib.sha256(data).hexdigest()

def check_guards():
    for name, expected in guards.items():
        if digest((root / name).read_bytes()) != expected:
            raise ValueError('frozen guard mismatch: ' + name)

def caps():
    resource.setrlimit(resource.RLIMIT_AS, (8 * 1024**3, 8 * 1024**3))
    resource.setrlimit(resource.RLIMIT_CPU, (59, 60))
    resource.setrlimit(resource.RLIMIT_FSIZE, (256 * 1024, 256 * 1024))
    resource.setrlimit(resource.RLIMIT_CORE, (0, 0))

check_guards()
if digest(probe) != expected_probe:
    raise ValueError('probe hash mismatch')
out = Path(tempfile.mkdtemp(prefix='astra-constrained-review-', dir='/tmp'))
(out / 'Probe.lean').write_bytes(probe)
(out / 'replay.sh').write_bytes(launcher)
(out / 'stdin.bin').write_bytes(b'')
command = ['/home/joshua/.elan/bin/lake', 'env', 'lean', '-j1', '-s65536', '-DwarningAsError=true',
           str(out / 'Probe.lean')]
failure = None
started = time.monotonic()
with (out / 'stdin.bin').open('rb') as sin, (out / 'stdout.bin').open('wb') as sout, \
        (out / 'stderr.bin').open('wb') as serr:
    process = subprocess.Popen(command, cwd=root, stdin=sin, stdout=sout, stderr=serr,
                               start_new_session=True, preexec_fn=caps)
    try:
        process.wait(timeout=60)
    except subprocess.TimeoutExpired:
        failure = 'wall-timeout'
        try:
            os.killpg(process.pid, signal.SIGKILL)
        except ProcessLookupError:
            pass
        process.wait()
elapsed = time.monotonic() - started
check_guards()
hashes = {p.name: digest(p.read_bytes()) for p in out.iterdir()}
sizes = {p.name: p.stat().st_size for p in out.iterdir()}
receipt = {'command': command, 'cwd': str(root), 'returncode': process.returncode,
           'lean_num_threads': os.environ.get('LEAN_NUM_THREADS'),
           'lean_stack_size_kb': os.environ.get('LEAN_STACK_SIZE_KB'),
           'failure': failure, 'wall_seconds': elapsed, 'cpu_limits': [59, 60],
           'address_limit_bytes': 8 * 1024**3, 'stream_limit_bytes': 256 * 1024,
           'python': os.sys.version, 'source_guards_unchanged': True,
           'guards': guards, 'sha256': hashes, 'bytes': sizes}
(out / 'receipt.json').write_text(json.dumps(receipt, indent=2, sort_keys=True) + '\n')
evidence_bytes = sum(p.stat().st_size for p in out.iterdir())
if evidence_bytes > 1024 * 1024:
    raise ValueError('evidence exceeds 1 MiB')
print(json.dumps({'evidence': str(out), 'bytes': evidence_bytes,
                  'returncode': process.returncode, 'failure': failure}, sort_keys=True))
print('STDOUT_BEGIN')
print((out / 'stdout.bin').read_text(), end='')
print('STDOUT_END')
print('STDERR_BEGIN')
print((out / 'stderr.bin').read_text(), end='')
print('STDERR_END')
print((out / 'receipt.json').read_text(), end='')
raise SystemExit(124 if failure else (process.returncode if process.returncode >= 0
                                    else 128 - process.returncode))
PY
```

## Probe outcome

The first launch aborted before any theorem output with actual returncode
`-6` (SIGABRT), propagated shell exit 134, after 1.1177899860194884 seconds.
Its full stderr, including the final newline, was:

```text
libc++abi: terminating due to uncaught exception of type lean::exception: failed to create thread
```

Stdout and stdin were both empty. The exact first-run evidence is retained
at `/tmp/astra-constrained-review-7gs4hhhk`, 12697 bytes. Probe SHA-256:
`67781e523e63ff4dd189c43853abf005939ab4ddd548c6123459017dcdeb7dcb`;
launcher SHA-256:
`9293e2386ef5dbdff38cd4bf351b1b6be451dbf22f7e0058f21b1af59ef3d640`;
stderr SHA-256:
`32a60967270365f092cad81a408cf0e68f13aceab4359f32700f140a54129b9b`.
Empty-stream SHA-256 is
`e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.
All frozen guards remained unchanged. The receipt's `failure:null` means
only that the driver's wall-timeout handler did not fire; returncode -6 is
an actual failure and is not accepted as a successful probe.

The installed Lean 4.32.1 help was read and confirms `-j` selects the thread
count. A retry of the identical probe with the same resource bounds is
authorized as a bounded execution correction. The second launch's only change was
inserting `'-j1', ` immediately before `'-DwarningAsError=true',`; removing
that insertion from the complete Bash fence reconstructs the first launcher
byte for byte before the additional environment correction below. This
correction did not change a theorem, a numeric control, or the mathematical scope.

The second launch also aborted before theorem output with returncode -6,
shell exit 134, after 1.116638765000971 seconds. Evidence directory:
`/tmp/astra-constrained-review-7uighay5`, 12714 bytes. Probe, empty streams,
stderr, caps, and frozen guard hashes are identical to the first launch.
The second launcher hash is
`d3ad79c3a14e60877d2b1636a0050dfdcadacc86a373e703f2cb62b2d2448110`.

The pinned upstream runtime reads `LEAN_NUM_THREADS` when initializing its
default task manager; absent that variable it uses hardware concurrency.
See [Lean 4.32.1 runtime, lines 1006–1020](https://raw.githubusercontent.com/leanprover/lean4/v4.32.1/src/runtime/object.cpp).
This supports setting the environment for Lake itself, rather than relying
only on an argument to its later Lean child. The third launch adds
`export LEAN_NUM_THREADS=1` to the Bash fence and the corresponding
`lean_num_threads` receipt field; the identical fixed probe and resource
caps remain. Removing exactly those two lines reconstructs the second
launcher; additionally removing `'-j1', ` reconstructs the first. Their
byte hashes are verified below after also reversing later corrections.

The third launch had the same no-output SIGABRT/-6, shell 134, after
1.1170560540049337 seconds. Its 12835-byte evidence is retained at
`/tmp/astra-constrained-review-ofw2hgxk`. Launcher hash:
`d64b2302fd9a68182a31ccaf6ba068944cafdae7471abb1f482b25bb10e98891`.
Probe and stream hashes, caps, and frozen guards remained identical. The
receipt confirms the actual environment `LEAN_NUM_THREADS=1`.

The pinned runtime defaults each 64-bit Lean thread stack to 1 GiB and
starts its main function on a new thread before command-line handling.
It reads `LEAN_STACK_SIZE_KB` before creating that thread. See
[Lean 4.32.1 thread runtime, lines 21–26 and 160–177](https://raw.githubusercontent.com/leanprover/lean4/v4.32.1/src/runtime/thread.cpp).
This supplies an evidence-based explanation for the startup failure under
a 2 GiB virtual-address cap even when thread count is one. Root separately
reported that direct pinned `lean --version` and `lake --version` also
abort under this cap; those diagnostic runs belong to root's evidence.

The fourth launch reduces the configured thread stack to 64 MiB by adding
`export LEAN_STACK_SIZE_KB=65536`, CLI `'-s65536', `, and the
`lean_stack_size_kb` receipt field. Removing exactly these changes from the
complete fence reconstructs the third launcher. No resource cap was raised;
the probe and all numeric cases remain byte-identical in that launch.

The fourth launch still aborted before theorem output: returncode -6,
shell 134, 1.1167334420024417 seconds. Its evidence directory is
`/tmp/astra-constrained-review-9ula7146`, 12997 bytes, with launcher hash
`9f3ba3ee79b3cef0c295709ca32f14b9dec9bdd7b01724a20a2a5a9fe77b3c2f`.
All probe/stream/frozen hashes remain as above. Thus the environment change
was insufficient in the installed binary; the source-based explanation
alone must not be described as a confirmed successful correction.

A single fixed direct `lean --version` diagnostic was then traced, with
one thread, the 64 MiB stack settings, the same 2 GiB address limit, a
10-second wall bound, CPU 9/10 seconds, and 64 KiB per output/trace file.
Actual returncode was -6, stdout empty, stderr the same 98 bytes, wall
2.7211646570067387 seconds. Evidence:
`/tmp/astra-lean-startup-trace-q8s8auii`. The trace hash is
`ace24a55f6664ecfd29195a3e26173fbe4f85f2c1215111c438c512a675822c2`.
It shows a successful anonymous MAP_NORESERVE mapping of 1073741824 bytes,
then a failed MAP_STACK mapping of 1073745920 bytes with ENOMEM. Their sum
already exceeds 2 GiB before libraries or other mappings are counted.
The observed first stack is therefore still approximately 1 GiB despite
the requested smaller setting. This is an observed virtual-address
failure before any theorem, rather than an inference from proof complexity.

Based on those two measured reservations, the fifth launch changes only
the address cap to 4 GiB; wall, CPU, output, theorem source, and fixed
arithmetic controls are unchanged. The change and its reason were reported
to root before execution. This is a bounded runtime-cap correction, not a
larger mathematical experiment. Replacing the three occurrences of
`4 * 1024**3` in the complete Bash fence by `2 * 1024**3` reconstructs the
fourth launcher (after reversing any later cap correction below).

The fifth launch reached imports but exited 1 after 0.766089851007564
seconds, with no axiom output. Stderr/stdin are empty. Its exact stdout is:

```text
/tmp/astra-constrained-review-gxux_d4t/Probe.lean:1:0: error: failed to read file '/home/joshua/lonely-runner-formalization/.lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Algebra/Group/Submonoid/Operations.olean'
```

Evidence directory `/tmp/astra-constrained-review-gxux_d4t`, 13116 bytes;
stdout hash `bee74184b9702de45f03575579925a90f80a330709cdb97c8ed948a33c623ff4`;
launcher hash `aa5b4e9368c064cd3188d0a6bb5d8ac54138147ed2910d7840a645de51aa3c03`.
The named dependency was independently readable outside the cap, 1379272
bytes, SHA-256 `b7e025f0a7c530eed0749008df6c57fd2b638ea979a5555fcb22ec1a4c093ba1`.
It was not restored, rewritten, or deleted.

A fixed failed-mmap trace of that same probe under 4 GiB confirmed ENOMEM
on imported file mappings. The installed `strace --help` was checked for
`-f`, `-Z`, and `-e trace=mmap`. The 64 KiB trace cap was reached, and
strace exited -25 (SIGXFSZ), so this trace is an **incomplete captured
prefix**, not a successful verification. The first recorded ENOMEM was:

```text
1194660 mmap(0x3eb3411c0000, 64368, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED_NOREPLACE, 11, 0) = -1 ENOMEM (Cannot allocate memory)
```

Evidence `/tmp/astra-lean-import-trace-d_v0ncnx`, total 66635 bytes, wall
3.0211335749772843 seconds, 10-second wall and CPU 9/10 limits. The trace
is exactly 65536 bytes with SHA-256
`406ed8a7f938128e3675f3d7372b3b82775d681e2cf2d2f07f8b652be3fedfb1`.
The stdout reproduces the fifth-launch import error with the same hash;
stderr is empty. The tracing wrapper itself returned 0 after saving this
failure receipt; its child returncode -25 is the actual diagnostic outcome.
No theorem was accepted from either trace.

The failure evidence establishes insufficient virtual mapping room at
4 GiB. A final fixed-probe retry at 8 GiB was proposed to root with all
other caps and all source bytes unchanged, then announced before execution
as a routine evidenced cap correction within the source-review assignment.
Replacing the three `8 * 1024**3` occurrences in the complete Bash fence
by `4 * 1024**3` reconstructs the fifth launcher after restoring the original
`expected_probe` hash recorded below.

The sixth launch, at 8 GiB, passed all four full universal contract
assignments and printed all four allowed axiom lists. It then exited 1
because this reviewer's numeric probe proof terms had normalization
mismatches: negative division placement, natural-literal casts, and
`5*(1/6)` versus `5/6`. These were probe-proof defects, not defects in the
frozen module or changes to its theorem statements. Evidence is retained
at `/tmp/astra-constrained-review-1d3yv8g6`, 16830 bytes; wall
2.068965215003118 seconds; stderr/stdin empty; stdout 3931 bytes with hash
`d23a4b728055abc5a5eb00447ea75075b8dc7d209601f745b1fddbdb2892525e`.
Launcher hash `0071dbe973c82921722f21376a1e8a4c7044eb5bae3ecd9b791647bbd0cb745a`.

The numeric proof normalization was repaired without changing any control
statement, any of the four universal assignments, or the frozen module.
The seventh-launch probe was 6799 bytes, SHA-256
`6d667af6ce89e5fed04d425aae77703f4018144ae21ff15def7c2db95ece0131`.
Its changes are: also normalize the goal in the three norm-arithmetic
blocks; explicitly simplify natural casts when supplying P and D; and
use a named P result before casting its conclusion. The original probe
is retained as each earlier `Probe.lean`, including the sixth evidence
directory, with its original hash `67781e523e63ff4dd189c43853abf005939ab4ddd548c6123459017dcdeb7dcb`.
Replacing only the final `expected_probe` hash in the Bash fence by the
original one recovers the sixth launcher; the earlier reverse edits then
recover launchers five through one.

The seventh launch again passed all universal assignments and axiom prints,
then exited 1 because two probe-only normalization goals remained:
`True ∧ True` after `norm_num only`, and the now shorter conjunction after
normalizing the fixed shift identities. Its evidence directory is
`/tmp/astra-constrained-review-vdfffwt6`, 14014 bytes; wall
2.0688452599861193 seconds. Stdout is 957 bytes with hash
`4bd13f9a1d4893f4135f958b644b06a2548c2b045b6d1ed6bbc5bac04092e62d`;
stdin/stderr are empty. Launcher hash:
`851c8523b424e728958f1173b82df6944128ddfa35587ed59617318a2cac8c78`.

The final proof-only correction closes that trivial conjunction and
supplies the two remaining norm equalities directly. All theorem/control
statements and resource bounds remain unchanged. Final probe: 6769 bytes,
SHA-256 `120c938fe6ba3eeb2c3b5f9b805d5dc9203e20690dc495a2481517852764e858`.
The eighth launch passed with actual child exit 0 and propagated Bash
exit 0 in 2.1186751589993946 seconds, under the declared 8 GiB address-space,
CPU 59/60, 60-second wall, and 256 KiB-per-stream bounds. Exact evidence
directory: `/tmp/astra-constrained-review-rrucn5x5`, 13455 bytes. All frozen
guards were unchanged before and after the run. There were no warnings or
errors with `-DwarningAsError=true`; stderr and stdin were both empty.

The entire successful stdout is exactly these four lines, including their
final newline:

```text
'LonelyRunner.circleNorm_eq_min_fract' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.exists_forward_complement_improvement' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.exists_oriented_complement_maximizer' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.reciprocal_dilate_shift_improves' depends on axioms: [propext, Classical.choice, Quot.sound]
```

| Final artifact | Bytes | SHA-256 |
| --- | ---: | --- |
| `Probe.lean` | 6769 | `120c938fe6ba3eeb2c3b5f9b805d5dc9203e20690dc495a2481517852764e858` |
| `replay.sh` | 4406 | `2d666c61785457c89c8b93551e6735fd0d5160d2736b128db15898c803bb319e` |
| `stdout.bin` | 428 | `24f50b15c9b6c8cfc0112f0fff416184177b15db02b8c6c3be02cf2ddb2e0035` |
| `stdin.bin`, `stderr.bin` | 0 each | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| `receipt.json` | 1852 | `e2e5419b27107872af8bb6593724f0c77bac79514a58598c770f741b71a66b45` |

The passing examples check all four exact universal declaration types
at arbitrary label universe, followed by all six fixed-control groups.
The four axiom outputs include the transitive dependencies of the private
positive-objective helper through M. The module's source scan found no
`sorry`, `admit`, custom `axiom`, `native_decide`, or `unsafe` token.
The complete source was also read, so this token scan is supplemental
evidence rather than the mathematical review itself.

Root may replay the complete Bash fence once with the existing shared
artifact and its guards. This review requests no root import change and
performs no publication or cache work. Source compilation remains root's
separate reported build; the evidence here is exact contract checking,
public axiom auditing, fixed kernel-checked controls, and independent
source reasoning. The ordinary five-moving margin-1/6 theorem, phase
certificate kernel bridge, divisibility assembly, and canonical six-total
and unrestricted conclusions remain separate obligations.

Final static readback confirmed that all ten `example` declaration headers
are byte-identical between the original and successful probes: only their
proof normalization changed. The documented reverse edits reproduce every
earlier launcher hash. The final Lean/Bash fences match the successful
evidence files exactly, and the report has no trailing whitespace. These
are text-integrity checks, not additional Lean runs.

At assignment the root import was absent. Final readback found it present;
root confirmed that Terra added the import/audit separately after PR40
merged as main `a39edc`. This review neither made nor requested that change,
and its frozen guards intentionally target the reviewed module, artifact,
manuscripts, and pinned dependencies. The source hash above is unchanged.
