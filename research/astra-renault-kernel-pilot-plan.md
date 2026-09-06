# Predeclared first-row kernel pilot for Renault 5.1

Status: source generated from the already fixed certificate, not yet executed.
This single pilot checks one retained mask row, rather than all triples. It is
not the phase theorem or the continuum bridge. The exact certificate SHA is
`c1374409d4f6804487179fe9765695a2f0d756ccd2a79b5ee8616e919acbb7b1`.

The 41 numeral masks below are extracted in the certificate's retained-class
order. No new candidate, atom, mask or witness discovery is performed. For fixed
first index 0, `j,k : Fin41` gives 1681 index pairs, of which 861 satisfy j<=k.
The proposition checks only their fixed three-mask intersection. Ordinary Lean
`decide` must return a kernel proof. No native_decide, source axiom, native-code
trust, #eval success flag or external solver may discharge it.

One attempt is authorized with maxHeartbeats1000000, maxRecDepth4096, a60-second
wall deadline, CPUsoft/hard59/60seconds and2GiB per-process address limit. The
launcher kills the entire process group on timeout. Complete stdout/stderr,
actual exit/signal and source/pinned-manifest hashes will be recorded; evidence
is accepted only below1MiB. A timeout, memory failure or failed elaboration ends
this pilot; no enlarged rerun is preauthorized. Imported dependency objects are
shared pinned cache, and no cache rebuild or cleanup is part of the experiment.

A successful first row would establish just this proposition. Before checking
all rows, fix the complete41-row schedule and its resource budget. For later
logical transfer, `Nat.zero_of_testBit_eq_false` and `Nat.testBit_land` imply
that a nonzero intersection has a common true bit. A bound on its first mask
below2^23 forces such a bit below23, by `Nat.testBit_eq_false_of_lt` and exponent
monotonicity. This gives membership in the concrete Fin23 good-mask finset;
its interval meaning and partition still need checked proofs. Supplying this
bridge is distinct from the pilot's performance measurement.

Exact proposed Lean source follows (including its final newline).

```lean
import Mathlib.Data.Nat.Bitwise
import Mathlib.Data.Fin.VecNotation

set_option maxHeartbeats 1000000
set_option maxRecDepth 4096
namespace RenaultKernelPilot

def masks : Fin 41 → Nat := ![7576815, 7970031, 7982311, 8178919, 8179303, 8185447, 8283751, 4158259, 3666739, 3406739, 3391385, 3784601, 3776473, 3973081, 4083196, 4154620, 3663100, 3404030, 3404414, 3799678, 1965951, 6078255, 6168367, 6168463, 6246279, 5754759, 5498823, 4846067, 5042675, 5044467, 5142771, 5127417, 5185145, 4693625, 6541116, 6934332, 6940476, 6940572, 7137180, 7140254, 7238558]

-- Fixed first retained row only: no whole-certificate theorem is asserted.
theorem first_row : ∀ j k : Fin 41, j ≤ k →
    (masks 0 &&& masks j &&& masks k) ≠ 0 := by
  decide

#print axioms first_row
end RenaultKernelPilot
```

Source SHA-256: `793235f5bf75617b5e9590e9f6256ef41da62046486559ab636688b42cbe4233`.

Runtime preparation before the first execution: the pinned `lean --help`
explicitly documents `-j/--threads`. Use `lake env lean -j 1` to limit Lean
worker threads within the fixed address-space budget. This changes only
scheduling, not the proposition, masks, caps or proof method. No attempt has
run at this point. The complete launcher is below.

```python
from pathlib import Path
import hashlib, json, os, resource, signal, subprocess, time
src = Path('/tmp/astra-renault-first-row-pilot.lean')
assert hashlib.sha256(src.read_bytes()).hexdigest() == '793235f5bf75617b5e9590e9f6256ef41da62046486559ab636688b42cbe4233'
env = dict(os.environ)
env['PATH'] = str(Path.home()/'.elan/bin') + os.pathsep + env['PATH']
def limits():
    resource.setrlimit(resource.RLIMIT_AS, (2*1024**3, 2*1024**3))
    resource.setrlimit(resource.RLIMIT_CPU, (59, 60))
    resource.setrlimit(resource.RLIMIT_CORE, (0, 0))
cmd = ['lake', 'env', 'lean', '-j', '1', str(src)]
start = time.monotonic()
p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                     env=env, start_new_session=True, preexec_fn=limits)
failure = None
try:
    stdout, stderr = p.communicate(timeout=60)
except subprocess.TimeoutExpired:
    failure = 'wall-timeout'
    os.killpg(p.pid, signal.SIGKILL)
    stdout, stderr = p.communicate()
elapsed = time.monotonic()-start
if len(stdout)+len(stderr) > 1000000:
    failure = 'evidence-cap'
record = {'command':cmd,'source_sha256':hashlib.sha256(src.read_bytes()).hexdigest(),
          'exit_code':p.returncode,'signal':-p.returncode if p.returncode < 0 else None,
          'wall_seconds':elapsed,'failure':failure,'capture_complete':failure is None,
          'stdout':stdout[:500000].decode(errors='replace'),
          'stderr':stderr[:500000].decode(errors='replace'),
          'stdout_bytes':len(stdout),'stderr_bytes':len(stderr),
          'stdout_sha256':hashlib.sha256(stdout).hexdigest(),
          'stderr_sha256':hashlib.sha256(stderr).hexdigest(),
          'child_max_rss_kib':resource.getrusage(resource.RUSAGE_CHILDREN).ru_maxrss,
          'cpu_limits':[59,60],'address_bytes_per_process':2*1024**3,
          'wall_limit_seconds':60}
assert hashlib.sha256(src.read_bytes()).hexdigest() == record['source_sha256']
Path('/tmp/astra-renault-first-row-pilot-receipt.json').write_text(json.dumps(record,indent=2)+'\n')
print(json.dumps(record,indent=2))
raise SystemExit(p.returncode if p.returncode >= 0 else 128-p.returncode)
```

## Startup failure and explicit recovery authorization

The first launch ended with childSIGABRT(-6), shell134, before producing any
Lean stdout; stderr was `failed to create thread`. Its full receipt is retained
in `research/astra-renault-kernel-pilot-startup-failure.json`. This did not
elaborate the theorem and says nothing about its computational cost or truth.

Root checked the pinned [Lean4.32.1 runtime source](https://raw.githubusercontent.com/leanprover/lean4/v4.32.1/src/runtime/object.cpp):
`get_lean_num_threads` reads `LEAN_NUM_THREADS` before falling back to hardware
concurrency, and default task-manager initialization uses that result. The
Lean CLI flag alone does not constrain Lake's startup task manager.

Root now explicitly authorizes one retry of the **identical** source, masks,
proposition and resource caps, adding only `env['LEAN_NUM_THREADS']='1'` in
the displayed launcher before process creation. This environment value is
local to the child process and is not a global/project configuration edit.
The changed launcher and all actual outcomes will be retained separately.
No larger numerical domain, heartbeat or memory allowance is authorized.

The thread-count-only retry also failed before stdout, with the same signal and
stderr. Direct pinned `lean -j1 --version` and `lake --version` under the same
address cap failed identically, isolating startup from imports or theorem work.
Its receipt is `research/astra-renault-kernel-pilot-thread-limit-failure.json`.

The pinned [thread runtime source](https://raw.githubusercontent.com/leanprover/lean4/v4.32.1/src/runtime/thread.cpp)
sets the 64-bit default stack reservation to1GiB and starts its main thread
before parsing CLI options. It explicitly reads `LEAN_STACK_SIZE_KB` before
creating that thread. Thus controlling only worker count did not address the
initial stack reservations. Root authorizes one evidence-based identical-source
retry adding `env['LEAN_STACK_SIZE_KB']='65536'` (64MiB stacks), retaining
LEAN_NUM_THREADS=1, -j1 and **all previous CPU, address, wall and heartbeat caps**.
This reduces virtual stack reservations; it neither weakens kernel checking
nor enlarges the finite domain. Environment changes remain process-local.

## Measured address-space correction before a further fixed attempt

The64MiB-stack environment retry still failed with the same startup error.
The environment-based explanation was therefore only a plausible hypothesis,
not an established remedy. Its receipt is preserved separately.
A capped direct-version strace now gives exact evidence: it successfully
reserves1,073,741,824bytes in a MAP_NORESERVE arena, then a1,073,745,920-byte
MAP_STACK reservation fails with ENOMEM. These reservations plus other mappings
cannot fit the2GiB address envelope. The trace is retained in
`research/astra-lean-capped-startup-trace.log` (SHA-256
`ace24a55f6664ecfd29195a3e26173fbe4f85f2c1215111c438c512a675822c2`).
This is virtual address reservation evidence, not physical memory consumption.

Root now explicitly authorizes one identical first-row attempt with4GiB
per-process virtual address space, accommodating those measured reservations.
All mathematical data, sourcehash, CPU59/60, wall60, heartbeat1,000,000 and
recursion4096limits remain unchanged. Local thread settings are retained but
are not claimed to have solved startup. This specific revised envelope follows
measured startup evidence and does not authorize a larger mathematical check.

## Import-mapping evidence and final address correction

The4GiB attempt exited1 at the import, reporting an unreadable pinned
Lean/Language/Lean/Types.olean. Root verified the file exists and is readable
(234352bytes); the exact failed receipt is retained in
`research/astra-renault-kernel-pilot-four-gib-import-failure.json`.
The independent maximizer review reproduced this class of failure under4GiB;
a capped failed-mmap trace observed ENOMEM on file-backed import mappings.
Its fixed review probe then reached all contracts and completed at8GiB.

On this evidence root authorizes one identical first-row pilot with8GiB
virtual address space, leaving source, finite domain, CPU59/60, wall60,
heartbeats and recursion unchanged. No larger mathematical check is implied.
The launcher is exactly the previous displayed launcher plus the two local
thread environment assignments and replacement of both address limits by
8*1024**3. Its hash and complete actual receipt will be recorded.

The8GiB identical-source run completed with actual child/shell exit0 in
1.830493090004893seconds and peak child RSS1581704KiB. Complete stdout is
`'RenaultKernelPilot.first_row' depends on axioms: [propext]` plus newline;
stderr is empty. The complete receipt is
`research/astra-renault-kernel-pilot-success.json`. This checks only the
first row (861 ordered conditions), not all triples or the continuum theorem.
Any all-row check requires its own finite scope and verification plan.
