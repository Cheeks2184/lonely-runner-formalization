# Five-adic coupled-carry implementation attempt

2026-09-06. The workflow configuration, policy, active state, and validator
were read before work. `python3 scripts/validate_workflow.py` passed. The
settled plan SHA-256 was verified as
`da1a4f4828f6e9d9cae6ed601151e0b56b518bea8e9add524e06b289b1713e69`.
This future Pass38 supporting lemma is excluded from the frozen Pass37 box
work. It makes no integer-digit adapter, filtering, five-runner, uniform LRC,
or unrestricted-goal claim.

`LonelyRunner/FiveAdicCarry.lean` defines the requested finite API:
`FiveCarryState` contains `top : Fin 5`, `residue : Fin 2`, and a coupled
`carry : Fin 4`; the carry lookup is exactly `(0,0), (0,1), (1,1), (1,2)`.
`fiveCarryDigit` uses the required decoded formula, and `fiveCarryTriple` has
the requested closed universally quantified public type. There are no
additional state premises and repeated states remain allowed.

## Bounded ordinary-kernel attempt: failed as prescribed

The first direct proof was exactly ordinary kernel `by decide`; no
`native_decide`, external truth table, witness artifact, added axiom, or
recursion-depth adjustment was used. The source was 1158 bytes, below 64 KiB.
It was checked once as a whole source invocation under a 60-second/4 GiB
process-group monitor. The monitor visits every `/proc/<pid>/task/*/children`
list, sums discovered `VmRSS`, and kills the group upon either sampled limit;
GNU `time` reports a separate final peak.

```text
test "$(wc -c < LonelyRunner/FiveAdicCarry.lean)" -le 65536 && \
/usr/bin/time -f 'gnu_time_wall=%e gnu_time_rss_kib=%M gnu_time_exit=%x' \
python3 /tmp/five-adic-carry-monitor.py

LonelyRunner/FiveAdicCarry.lean:29:2: error: maximum recursion depth has been reached
use `set_option maxRecDepth <num>` to increase limit
use `set_option diagnostics true` to get diagnostic information
monitor=pass wall=2.014 sampled_rss_kib=4115208 child_exit=1
Command exited with non-zero status 1
gnu_time_wall=2.03 gnu_time_rss_kib=3315420 gnu_time_exit=1
```

This is a compile-time recursion-depth failure, not a mathematical
counterexample and not a resource-cap breach. In accordance with the fixed
attempt boundary, this task stops here rather than increasing `maxRecDepth`,
expanding a resource budget, or replacing the finite proof route. The next
justified route is the plan's symbolic case proof, if separately assigned.

Exact source and monitor hashes:

```text
a388134939c22fa2d77fbc9e7c4128b22b36848cb72ab5f0aed7d229c74801ce  LonelyRunner/FiveAdicCarry.lean
19ec84184a9cc640102381948c8f27f1d4ee1249ca12cfdb76c5e6532bbb28af  /tmp/five-adic-carry-monitor.py
```

The monitor source used for this attempt was:

```python
import os, signal, subprocess, sys, time
cmd = ["lake", "env", "lean", "LonelyRunner/FiveAdicCarry.lean"]
cap = 4 * 1024 * 1024
p = subprocess.Popen(cmd, start_new_session=True)
start = time.monotonic(); peak = 0
def rss(root):
    pending, seen, total = [root], set(), 0
    while pending:
        pid = pending.pop()
        if pid in seen: continue
        seen.add(pid)
        try:
            task = f"/proc/{pid}/task"
            for tid in os.listdir(task):
                try:
                    with open(f"{task}/{tid}/children") as f:
                        pending.extend(int(x) for x in f.read().split())
                except FileNotFoundError: pass
            with open(f"/proc/{pid}/status") as f:
                for line in f:
                    if line.startswith("VmRSS:"):
                        total += int(line.split()[1]); break
        except (FileNotFoundError, ProcessLookupError): pass
    return total
while p.poll() is None:
    peak = max(peak, rss(p.pid)); elapsed = time.monotonic() - start
    if elapsed > 60 or peak > cap:
        os.killpg(p.pid, signal.SIGKILL); rc = p.wait()
        print(f"monitor=limit_exceeded wall={elapsed:.3f} sampled_rss_kib={peak} child_exit={rc}")
        sys.exit(124 if elapsed > 60 else 137)
    time.sleep(.02)
rc = p.wait(); elapsed = time.monotonic() - start; peak = max(peak, rss(p.pid))
print(f"monitor=pass wall={elapsed:.3f} sampled_rss_kib={peak} child_exit={rc}")
sys.exit(rc)
```

## Successful forward-Block and scalar helper prefix

The forward Block cast and the six-to-ten-input scalar lemmas compile in an
extracted prefix only. Exact deterministic extraction:

```sh
head -n 162 LonelyRunner/FiveAdicCarry.lean > /tmp/astra-five-adic-carry-helper-prefix.lean
printf '\nend LonelyRunner\n' >> /tmp/astra-five-adic-carry-helper-prefix.lean
```

The prefix hash was `e400e2fec6f9a68b22dee8b9d48aac9830201b3b8caa8fba2e22d04264da3f1c`.
The direct pinned-binary all-thread monitor reported:

```text
monitor=pass wall=4.659 sampled_rss_kib=3779956 child_exit=0
```

It excludes line 163 and later, including the old full-state private theorem
and public wrapper. This is not a whole-module check and did not evaluate the
old full-state `decide`.

## Reconstructed explicit-three-state failed source

The following historical source was reconstructed after the implementation
attempt and verified against the pre-existing SHA-256
`edcc4c6a1c8a31ce6188b92d9d0a21d09f01013027290d6ed6cfeb3d1876fdb3`.
It was not compiled in this pass.

## Equal-residue symbolic assembly prefix

`fiveCarryTriple_same` now applies normalized `T` to representatives of the
two top-digit differences, solves the common field translation by division by
the nonzero `J * rho`, and transports each normalized good expression through
the digit-cast bridge. It has no state enumeration.

The safe prefix was extracted by this hash-bound command, which asserts the
old full-state marker appears exactly once and cuts before it:

```sh
python3 -B - <<'PY'
from pathlib import Path
p=Path('LonelyRunner/FiveAdicCarry.lean'); s=p.read_text()
marker='set_option maxRecDepth 100000 in\nset_option maxHeartbeats 10000000 in\nprivate theorem fiveCarryTripleThree'
assert s.count(marker)==1, s.count(marker)
Path('/tmp/astra-five-adic-carry-same-prefix.lean').write_text(s.split(marker)[0]+'end LonelyRunner\n')
PY
```

The extracted prefix SHA-256 was
`19678f95d44266542fa6a69f4bafecc82b388fe910cf6d59a42bb9cd1640143d`;
the owned source SHA-256 at extraction was
`202940dbde1d30e7f95a5a36eaba9aa8f91ff4e5fcbf0272d31e52aa4017410f`.
The one direct pinned-binary all-thread monitored run terminated successfully:

```text
monitor=pass wall=4.738 sampled_rss_kib=3755992 child_exit=0
```

Only linter warnings about `<;>` sequencing were emitted. This excludes the
retained old full-state body, is prefix-only evidence, and is not a public
theorem or whole-module verification.

## Unequal-residue pair assembly checkpoint

The accepted two-equal-residues case is now a private symbolic theorem:
`fiveCarryTriple_pair a b c hab hac`, where `a.residue = b.residue` and
`a.residue ≠ c.residue`. It invokes only the already declared normalized
80-input pair theorem, converts its adjacent natural block into two field
translations, and uses the four-input ratio plus ten-input escape facts for
the third state. No state triple is enumerated by this proof.

The proof defines `U`, `D`, `K0`, and `K1` in `ZMod 5`. The block bridge
shows the first two states are good at both translations; cancellation proves
the third translation differs by either 2 or 3, and `fiveCarryEscape` selects
the translation at which the third state is good. The existing field-to-digit
bridge then supplies the three public-form good predicates.

The preserved historical failed source was reconstructed at
`/tmp/astra-five-adic-edcc-recovered.lean` and SHA-256 matched
`edcc4c6a1c8a31ce6188b92d9d0a21d09f01013027290d6ed6cfeb3d1876fdb3` in
the preceding implementation history. That reconstruction was not compiled
in this checkpoint.

The following deterministic extraction asserts the unique old full-state
marker and cuts before it, so the retained `fiveCarryTripleThree` `by decide`
is never elaborated:

```sh
python3 -B - <<'PY'
from pathlib import Path
s = Path('LonelyRunner/FiveAdicCarry.lean').read_text()
marker = 'set_option maxRecDepth 100000 in\nset_option maxHeartbeats 10000000 in\nprivate theorem fiveCarryTripleThree'
assert s.count(marker) == 1, s.count(marker)
Path('/tmp/astra-five-adic-carry-pair-prefix.lean').write_text(
    s.split(marker)[0] + 'end LonelyRunner\n')
PY
```

With the pinned Lean 4.32.1 environment loaded from
`/tmp/astra-pinned-lean-env.json`, the extracted source was checked once by
the direct pinned binary under a 60-second, 4-GiB all-thread process-group
monitor sampled every 20 ms. The monitor command was wrapped separately by
GNU `time`:

```text
monitor=pass wall=4.829 sampled_rss_kib=3828160 child_exit=0
gnu_time_wall=4.84 gnu_time_rss_kib=3827340 gnu_time_exit=0
```

Exact artifacts at this checkpoint:

```text
2c1f45398d9b5b8c66b15e69a231ecc3354325e3ad4ee294b7d912a86328d242  LonelyRunner/FiveAdicCarry.lean
f4905db5d1fd1b6cd59e01bf597c0a11d0663e3564671d8ecd1034069c914ce4  /tmp/astra-five-adic-carry-pair-prefix.lean
5188a188c422f19280acf0f27082939a715c807b23dae90c8f0f12728fe6be5c  /tmp/astra-five-adic-carry-prefix-monitor.py
```

The source is 15,707 bytes, below 64 KiB. This is a successful private-prefix
kernel check only. It does not check the retained old full-state theorem,
does not assemble the eight residue cases, and does not establish the public
five-state carry theorem, five-total result, or the Lonely Runner Conjecture.

## Full symbolic carry-theorem checkpoint

The obsolete 64,000-state `fiveCarryTripleThree` body and its theorem-local
resource options have been replaced. The private theorem now splits the three
`Fin 2` residues with `fiveCarryResiduePartition`; that partition performs
exactly eight ordinary-kernel `decide` leaves after `fin_cases`. Its four
branches invoke either `fiveCarryTriple_same` or `fiveCarryTriple_pair`, with
the two permuted pair branches returning the conjuncts in public order. The
public `fiveCarryTriple` type and its original user-facing documentation are
unchanged.

This full-source check used no prefix substitution. It first asserted the
16,638-byte source is within 64 KiB, then ran the direct pinned Lean 4.32.1
binary on `LonelyRunner/FiveAdicCarry.lean` under the same all-thread,
20-ms-sampled, 60-second/4-GiB process-group monitor. GNU `time` supplied an
independent final peak:

```text
monitor=pass wall=4.998 sampled_rss_kib=3796720 child_exit=0
gnu_time_wall=5.01 gnu_time_rss_kib=3798184 gnu_time_exit=0
```

The exact shell invocation was:

```sh
test "$(wc -c < LonelyRunner/FiveAdicCarry.lean)" -le 65536
env LEAN_PATH="$(jq -r .LEAN_PATH /tmp/astra-pinned-lean-env.json)" \
  LEAN_SRC_PATH="$(jq -r .LEAN_SRC_PATH /tmp/astra-pinned-lean-env.json)" \
  LEAN_SYSROOT="$(jq -r .LEAN_SYSROOT /tmp/astra-pinned-lean-env.json)" \
  LD_LIBRARY_PATH="$(jq -r .LD_LIBRARY_PATH /tmp/astra-pinned-lean-env.json)" \
  PATH="$(jq -r .PATH /tmp/astra-pinned-lean-env.json)" \
  /usr/bin/time -f 'gnu_time_wall=%e gnu_time_rss_kib=%M gnu_time_exit=%x' \
  python3 /tmp/astra-five-adic-carry-prefix-monitor.py
```

The monitor's command is the direct pinned binary with the full module path;
its source hash and the full source hash are:

```text
f91d747198374da76ff9e62435db20a8917856d5b9dc52229ce576353cc11d81  LonelyRunner/FiveAdicCarry.lean
6d6419cd522a9da69c9ba4b6b532640e3363c7b0fda6ebac5b28565ca390f1c3  /tmp/astra-five-adic-carry-prefix-monitor.py
```

The named module build also completed successfully:

```text
lake build LonelyRunner.FiveAdicCarry
Build completed successfully (2997 jobs).
```

A separate checked probe imported the built module, restated the exact public
universal type using `example := fiveCarryTriple`, and printed:

```text
'LonelyRunner.fiveCarryTriple' depends on axioms: [propext, Classical.choice, Quot.sound]
```

The same probe checked the fixed original-plan fixture
`(top,residue,carry) = (0,0,0), (1,0,2), (3,0,0)`: for every `k`, multiplier
indices 0 and 1 (respectively J=1 and J=2) fail the three-good-digit
conjunction, while index 2 (J=3) with `k=1` satisfies it. The probe uses only
these fixed finite claims and does not enumerate carry-state triples. Its
SHA-256 is
`aa7396450d299345ded75fd7569beeec479c4266c97a01b75c1b02a6ce954c7e`.

The compiler emitted only existing tactic-style linter warnings. This is a
kernel-checked finite carry theorem with the permitted axiom report; it is not
a proof of the five-total runner result or the unrestricted Lonely Runner
Conjecture.

## Self-contained frozen-source reproduction

The prefix commands above are historical, checkpoint-specific evidence; they
are not instructions to validate the final source. The following single shell
command is the durable full-source reproduction for frozen SHA-256
`f91d747198374da76ff9e62435db20a8917856d5b9dc52229ce576353cc11d81`.
It freshly captures only the five allowlisted Lean runtime variables through
`lake env`, resolves the pinned binary through `elan`, checks the source hash
and size before starting Lean, samples all discovered child processes and
threads every 20 ms, and separately asserts GNU `time`'s result. The sampled
aggregate can miss a peak that exists entirely between samples; the GNU-time
number is a separate process-level peak, so the two measurements are reported
separately rather than treated as identical quantities.

```bash
set -euo pipefail
source_file='LonelyRunner/FiveAdicCarry.lean'
source_hash='f91d747198374da76ff9e62435db20a8917856d5b9dc52229ce576353cc11d81'
cap_kib=4194304
env_json=$(mktemp)
time_log=$(mktemp)
trap 'rm -f "$env_json" "$time_log"' EXIT
lake env python3 - "$env_json" <<'PY'
import json, os, sys
allowed = {"LEAN_PATH", "LEAN_SRC_PATH", "LEAN_SYSROOT", "PATH", "LD_LIBRARY_PATH"}
payload = {key: os.environ[key] for key in allowed}
assert set(payload) == allowed and all(payload.values())
json.dump(payload, open(sys.argv[1], "w"), sort_keys=True)
PY
binary=$(elan which lean)
python3 - "$env_json" "$binary" <<'PY'
import json, os, sys
payload = json.load(open(sys.argv[1]))
allowed = {"LEAN_PATH", "LEAN_SRC_PATH", "LEAN_SYSROOT", "PATH", "LD_LIBRARY_PATH"}
assert set(payload) == allowed and all(payload.values())
binary = os.path.realpath(sys.argv[2])
assert binary.endswith('/bin/lean'), binary
assert 'leanprover--lean4---v4.32.1' in binary, binary
payload['resolved_lean_binary'] = binary
json.dump(payload, open(sys.argv[1], "w"), sort_keys=True)
PY
/usr/bin/time -o "$time_log" -f '%e %M %x' python3 - "$env_json" "$source_file" "$source_hash" "$cap_kib" <<'PY'
import hashlib, json, os, signal, subprocess, sys, time
env_path, source, expected, cap_s = sys.argv[1:]
assert hashlib.sha256(open(source, 'rb').read()).hexdigest() == expected
assert os.path.getsize(source) <= 65536
payload = json.load(open(env_path))
binary = payload.pop('resolved_lean_binary')
allowed = {"LEAN_PATH", "LEAN_SRC_PATH", "LEAN_SYSROOT", "PATH", "LD_LIBRARY_PATH"}
assert set(payload) == allowed and all(payload.values())
env = os.environ.copy(); env.update(payload)
cap = int(cap_s); start = time.monotonic(); peak = 0
p = subprocess.Popen([binary, source], env=env, start_new_session=True)
def rss(root):
    pending, seen, total = [root], set(), 0
    while pending:
        pid = pending.pop()
        if pid in seen: continue
        seen.add(pid)
        try:
            for tid in os.listdir(f'/proc/{pid}/task'):
                try:
                    with open(f'/proc/{pid}/task/{tid}/children') as f:
                        pending.extend(int(x) for x in f.read().split())
                except FileNotFoundError: pass
            with open(f'/proc/{pid}/status') as f:
                for line in f:
                    if line.startswith('VmRSS:'):
                        total += int(line.split()[1]); break
        except (FileNotFoundError, ProcessLookupError): pass
    return total
while p.poll() is None:
    peak = max(peak, rss(p.pid)); elapsed = time.monotonic() - start
    if elapsed > 60 or peak > cap:
        os.killpg(p.pid, signal.SIGKILL); rc = p.wait()
        print(f'monitor=limit_exceeded wall={elapsed:.3f} sampled_rss_kib={peak} child_exit={rc}')
        sys.exit(124 if elapsed > 60 else 137)
    time.sleep(.02)
rc = p.wait(); elapsed = time.monotonic() - start; peak = max(peak, rss(p.pid))
print(f'monitor=pass wall={elapsed:.3f} sampled_rss_kib={peak} child_exit={rc}')
assert elapsed <= 60 and peak <= cap and rc == 0
PY
cat "$time_log"
python3 - "$time_log" "$cap_kib" <<'PY'
import sys
wall, rss, rc = open(sys.argv[1]).read().split()
assert float(wall) <= 60 and int(rss) <= int(sys.argv[2]) and int(rc) == 0
print(f'postcheck=pass gnu_time_wall={wall} gnu_time_rss_kib={rss} gnu_time_exit={rc}')
PY
```

Author validation of that exact command produced:

```text
monitor=pass wall=4.956 sampled_rss_kib=3818160 child_exit=0
4.97 3817720 0
postcheck=pass gnu_time_wall=4.97 gnu_time_rss_kib=3817720 gnu_time_exit=0
```

The following is the complete independent public-interface probe (SHA-256
`aa7396450d299345ded75fd7569beeec479c4266c97a01b75c1b02a6ce954c7e`).
It states the public universal type explicitly, checks the permitted axiom
set, and verifies the fixed J=1/J=2/J=3 fixture without any state-triple
enumeration:

```lean
import LonelyRunner.FiveAdicCarry

namespace LonelyRunner

example : ∀ s : Fin 3 → FiveCarryState,
    ∃ u : Fin 3, ∃ k : Fin 5, ∀ i,
      (fiveCarryDigit (s i) u k).val ∈ ({1, 2, 3} : Finset Nat) :=
  fiveCarryTriple

#print axioms fiveCarryTriple

def carryFixture0 : FiveCarryState := ⟨0, 0, 0⟩
def carryFixture1 : FiveCarryState := ⟨1, 0, 2⟩
def carryFixture2 : FiveCarryState := ⟨3, 0, 0⟩

private abbrev fixtureGood (s : FiveCarryState) (u : Fin 3) (k : Fin 5) : Prop :=
  (fiveCarryDigit s u k).val ∈ ({1, 2, 3} : Finset Nat)

example : ∀ k : Fin 5, ¬ (fixtureGood carryFixture0 0 k ∧
    fixtureGood carryFixture1 0 k ∧ fixtureGood carryFixture2 0 k) := by
  intro k
  fin_cases k <;> decide

example : ∀ k : Fin 5, ¬ (fixtureGood carryFixture0 1 k ∧
    fixtureGood carryFixture1 1 k ∧ fixtureGood carryFixture2 1 k) := by
  intro k
  fin_cases k <;> decide

example : fixtureGood carryFixture0 2 1 ∧ fixtureGood carryFixture1 2 1 ∧
    fixtureGood carryFixture2 2 1 := by
  decide

end LonelyRunner
```

Run it directly from standard input with:

```bash
lake env lean /dev/stdin <<'LEAN'
import LonelyRunner.FiveAdicCarry

namespace LonelyRunner

example : ∀ s : Fin 3 → FiveCarryState,
    ∃ u : Fin 3, ∃ k : Fin 5, ∀ i,
      (fiveCarryDigit (s i) u k).val ∈ ({1, 2, 3} : Finset Nat) :=
  fiveCarryTriple

#print axioms fiveCarryTriple

def carryFixture0 : FiveCarryState := ⟨0, 0, 0⟩
def carryFixture1 : FiveCarryState := ⟨1, 0, 2⟩
def carryFixture2 : FiveCarryState := ⟨3, 0, 0⟩
private abbrev fixtureGood (s : FiveCarryState) (u : Fin 3) (k : Fin 5) : Prop :=
  (fiveCarryDigit s u k).val ∈ ({1, 2, 3} : Finset Nat)
example : ∀ k : Fin 5, ¬ (fixtureGood carryFixture0 0 k ∧ fixtureGood carryFixture1 0 k ∧ fixtureGood carryFixture2 0 k) := by
  intro k; fin_cases k <;> decide
example : ∀ k : Fin 5, ¬ (fixtureGood carryFixture0 1 k ∧ fixtureGood carryFixture1 1 k ∧ fixtureGood carryFixture2 1 k) := by
  intro k; fin_cases k <;> decide
example : fixtureGood carryFixture0 2 1 ∧ fixtureGood carryFixture1 2 1 ∧ fixtureGood carryFixture2 2 1 := by decide
end LonelyRunner
LEAN
```

The standard-input probe exited 0 and its complete stdout was:

```text
'LonelyRunner.fiveCarryTriple' depends on axioms: [propext, Classical.choice, Quot.sound]
```

```lean
import Mathlib.Tactic

namespace LonelyRunner

/-- The finite data retained from one normalized five-adic unit.  The carry tag
couples the double and triple carries, rather than choosing them independently. -/
structure FiveCarryState where
  top : Fin 5
  residue : Fin 2
  carry : Fin 4
  deriving DecidableEq, Fintype

/-- The selected carry for multipliers 1, 2, and 3 respectively. -/
def fiveCarryCarry (tag : Fin 4) (u : Fin 3) : Nat :=
  (![![0, 0, 0], ![0, 0, 1], ![0, 1, 1], ![0, 1, 2]] tag) u

/-- The top base-five digit after choosing multiplier `u.val + 1` and
translation `k.val`. -/
def fiveCarryDigit (s : FiveCarryState) (u : Fin 3) (k : Fin 5) : Fin 5 :=
  ⟨((u.val + 1) * s.top.val + fiveCarryCarry s.carry u +
      (u.val + 1) * k.val * (s.residue.val + 1)) % 5,
    Nat.mod_lt _ (by decide)⟩

/-- The closed admissibility predicate for one carry state and one choice. -/
private abbrev fiveCarryGood (s : FiveCarryState) (u : Fin 3) (k : Fin 5) : Prop :=
  (fiveCarryDigit s u k).val ∈ ({1, 2, 3} : Finset Nat)

set_option maxRecDepth 100000 in
set_option maxHeartbeats 10000000 in
/-- This closed three-state encoding has the same 40³ mathematical domain as
the public theorem without first materializing functions `Fin 3 → State`. -/
private theorem fiveCarryTripleThree : ∀ a b c : FiveCarryState,
    ∃ u : Fin 3, ∃ k : Fin 5,
      fiveCarryGood a u k ∧ fiveCarryGood b u k ∧ fiveCarryGood c u k := by
  decide

/-- Every ordered triple of coupled carry states has a multiplier and
translation whose three digits avoid the two forbidden residues. -/
theorem fiveCarryTriple : ∀ s : Fin 3 → FiveCarryState,
    ∃ u : Fin 3, ∃ k : Fin 5, ∀ i,
      (fiveCarryDigit (s i) u k).val ∈ ({1, 2, 3} : Finset Nat) := by
  intro s
  obtain ⟨u, k, h0, h1, h2⟩ := fiveCarryTripleThree (s 0) (s 1) (s 2)
  refine ⟨u, k, ?_⟩
  intro i
  fin_cases i
  · exact h0
  · exact h1
  · exact h2

end LonelyRunner
```

## Symbolic helper-prefix implementation checkpoint

The accepted normalized `T` and `P` declarations were added together with the
representative, injectivity, digit/base cast, good-digit cast, and forward Block
cast bridge. The forward Block theorem has no compiler diagnostic. This pass
never invoked the old `fiveCarryTripleThree` full-state `decide`.

For bounded verification, lines 1--160 of `LonelyRunner/FiveAdicCarry.lean`
were extracted to `/tmp/astra-five-adic-carry-helper-prefix.lean` and one
`end LonelyRunner` line was appended. The resulting exact prefix had SHA-256
`e2be3c49023e2a118ed9aba4610e873c6c1e59056bebda281ceafcd5be5d11ba`.
It was run once through the direct pinned binary and the 60-second/4-GiB
all-thread process-group monitor, with this outcome:

```text
monitor=pass wall=4.682 sampled_rss_kib=3801484 child_exit=1
```

This is a prefix-only compiler result, not a full-module proof. The remaining
diagnostics are scalar proof normalization: `norm_num` leaves
`¬(2 : ZMod 5) = 0`, `(1 + 1)⁻¹ = 3`, and wrapped numeral equalities such as
`6 = 1`. The next repair should cast exact natural modular facts using
`ZMod.natCast_mod` before proving the nonzero, ratio, and escape lemmas. No
chunked state search, external witness table, full-state evaluation, or
unmonitored expensive helper evaluation occurred.


## Authorized scoped-budget retry: external-cap failure

After the initial recursion-depth failure, one retry was explicitly authorized
with no change to the theorem, digit formula, or proof method. Only the
`fiveCarryTriple` declaration now has these theorem-local options:

```lean
set_option maxRecDepth 100000 in
set_option maxHeartbeats 10000000 in
theorem fiveCarryTriple ... := by decide
```

The same 60-second/4 GiB all-thread process-group monitor was run exactly once;
source remained below 64 KiB. This retry did not reach a successful kernel
proof: its sampled process-tree RSS exceeded 4194304 KiB and the monitor killed
its process group. No second retry, global option, larger external cap,
precomputed witness artifact, or symbolic replacement was attempted.

```text
test "$(wc -c < LonelyRunner/FiveAdicCarry.lean)" -le 65536 && \
/usr/bin/time -f 'gnu_time_wall=%e gnu_time_rss_kib=%M gnu_time_exit=%x' \
python3 /tmp/five-adic-carry-retry-monitor.py

monitor=limit_exceeded wall=2.667 sampled_rss_kib=4198360 child_exit=-9
Command exited with non-zero status 137
gnu_time_wall=2.71 gnu_time_rss_kib=804216 gnu_time_exit=137
```

GNU `time` records the monitor's completed process accounting after the
process-group kill, while the all-thread `/proc` sample is the enforced
resource gate; this is why the latter is controlling here. The first attempt
failed at Lean's default recursion depth under the resource cap. The sole
scoped retry passed that internal point but hit the external RSS cap. Therefore
the bounded plain-`decide` branch is exhausted and the separately planned
symbolic proof is the next possible route.

Retry source and monitor hashes:

```text
5f0d3e79ad44b98088546d652d88a33965ecabaa477a946897ed6ac01d6f881e  LonelyRunner/FiveAdicCarry.lean
d2846e56882f126ce1fefd40a818a5c48ede2ee3e25f3e521f2b5c45ce1f867e  /tmp/five-adic-carry-retry-monitor.py
```

```python
import os, signal, subprocess, sys, time
p = subprocess.Popen(["lake", "env", "lean", "LonelyRunner/FiveAdicCarry.lean"], start_new_session=True)
cap = 4 * 1024 * 1024; start = time.monotonic(); peak = 0
def rss(root):
    pending, seen, total = [root], set(), 0
    while pending:
        pid = pending.pop()
        if pid in seen: continue
        seen.add(pid)
        try:
            task = f"/proc/{pid}/task"
            for tid in os.listdir(task):
                try:
                    with open(f"{task}/{tid}/children") as f: pending.extend(int(x) for x in f.read().split())
                except FileNotFoundError: pass
            with open(f"/proc/{pid}/status") as f:
                for line in f:
                    if line.startswith("VmRSS:"): total += int(line.split()[1]); break
        except (FileNotFoundError, ProcessLookupError): pass
    return total
while p.poll() is None:
    peak=max(peak,rss(p.pid)); elapsed=time.monotonic()-start
    if elapsed > 60 or peak > cap:
        os.killpg(p.pid, signal.SIGKILL); rc=p.wait()
        print(f"monitor=limit_exceeded wall={elapsed:.3f} sampled_rss_kib={peak} child_exit={rc}")
        sys.exit(124 if elapsed > 60 else 137)
    time.sleep(.02)
rc=p.wait(); elapsed=time.monotonic()-start; peak=max(peak,rss(p.pid))
print(f"monitor=pass wall={elapsed:.3f} sampled_rss_kib={peak} child_exit={rc}")
sys.exit(rc)
```


## Final direct-binary comparison: external-cap failure

One final same-source comparison was authorized to separate Lake-launcher
residency from proof evaluation. The source hash guard remained
`5f0d3e79ad44b98088546d652d88a33965ecabaa477a946897ed6ac01d6f881e`;
the theorem-local options and all proof data were unchanged. Before the
monitored proof process, the runtime environment was prepared and completed
outside the measured evaluation with:

```text
lake env python3 <allowlisted runtime-key capture>
elan which lean
# /home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lean
```

`/tmp/astra-pinned-lean-env.json` contained only `LEAN_PATH`,
`LEAN_SRC_PATH`, `LEAN_SYSROOT`, `PATH`, `LD_LIBRARY_PATH`, and
`resolved_lean_binary`. The direct monitor loaded precisely those five keys
into a copy of its environment, removed the resolved binary field, and ran
that binary directly in a new process group. It retained the exact same
60-second and 4194304 KiB all-thread sampled cap plus GNU-time postcheck.

```text
/usr/bin/time -f 'gnu_time_wall=%e gnu_time_rss_kib=%M gnu_time_exit=%x' \
python3 /tmp/five-adic-carry-direct-monitor.py

monitor=limit_exceeded wall=9.924 sampled_rss_kib=4196836 child_exit=-9
Command exited with non-zero status 137
gnu_time_wall=10.06 gnu_time_rss_kib=4196500 gnu_time_exit=137
```

Direct Lean therefore also exceeded the external RSS cap. It took longer than
the Lake invocation but has the same cap outcome; this experiment does not
establish that launcher residency caused either failure. No named build,
axiom probe, fixture, unmonitored evaluation, or further retry was run.

Direct monitor and prepared-runtime JSON hashes:

```text
49380e269cf299d2fd384556308b591ced667eb8bc07286adca3e7e70e44644c  /tmp/five-adic-carry-direct-monitor.py
228d1425b08258b8fb667c1d1f09328b29f294ce621736aab5c74559e1427665  /tmp/astra-pinned-lean-env.json
```

```python
import json, os, signal, subprocess, sys, time
payload = json.load(open("/tmp/astra-pinned-lean-env.json"))
binary = payload.pop("resolved_lean_binary")
allowed = {"LEAN_PATH", "LEAN_SRC_PATH", "LEAN_SYSROOT", "PATH", "LD_LIBRARY_PATH"}
assert set(payload) == allowed, set(payload)
env = os.environ.copy(); env.update(payload)
p = subprocess.Popen([binary, "LonelyRunner/FiveAdicCarry.lean"], env=env, start_new_session=True)
cap = 4 * 1024 * 1024; start = time.monotonic(); peak = 0
def rss(root):
    pending, seen, total = [root], set(), 0
    while pending:
        pid = pending.pop()
        if pid in seen: continue
        seen.add(pid)
        try:
            task = f"/proc/{pid}/task"
            for tid in os.listdir(task):
                try:
                    with open(f"{task}/{tid}/children") as f: pending.extend(int(x) for x in f.read().split())
                except FileNotFoundError: pass
            with open(f"/proc/{pid}/status") as f:
                for line in f:
                    if line.startswith("VmRSS:"): total += int(line.split()[1]); break
        except (FileNotFoundError, ProcessLookupError): pass
    return total
while p.poll() is None:
    peak = max(peak, rss(p.pid)); elapsed = time.monotonic() - start
    if elapsed > 60 or peak > cap:
        os.killpg(p.pid, signal.SIGKILL); rc = p.wait()
        print(f"monitor=limit_exceeded wall={elapsed:.3f} sampled_rss_kib={peak} child_exit={rc}")
        sys.exit(124 if elapsed > 60 else 137)
    time.sleep(.02)
rc = p.wait(); elapsed = time.monotonic() - start; peak = max(peak, rss(p.pid))
print(f"monitor=pass wall={elapsed:.3f} sampled_rss_kib={peak} child_exit={rc}")
sys.exit(rc)
```

## Symbolic implementation checkpoint (incomplete)

The prior structural-encoding source has SHA-256
`edcc4c6a1c8a31ce6188b92d9d0a21d09f01013027290d6ed6cfeb3d1876fdb3`.
It was reconstructed later from retained definitions and wrapper text and then
verified against this pre-existing hash; it was not already preserved here.
The normalized `T` and `P` declarations from the accepted plan were
added and checked only under the prescribed direct-binary monitor. The
helper-only stage passed: `wall=4.958`, sampled RSS `3759484 KiB`, exit 0.

The attempted `ZMod 5` bridge established the representative, injectivity,
digit-cast, base-cast, and normalized-good cast lemmas in that monitored stage.
The remaining block converse cannot be completed by directly taking `ZMod.val`
of the base-cast equality: Lean normalizes the left side to the field
expression's representative rather than the natural `fiveCarryBase` term.
The ratio and escape scalar checks also need explicit field-normalization lemmas
instead of bare `decide`/`norm_num`. No full-state `decide`, chunking, external
witness table, or unmonitored expensive evaluation was run. The source was
returned to the prior public theorem while this compiler gap remains unresolved.


## Preserved source before structural-encoding attempt

Before the authorized encoding change, the complete failed source had SHA-256
`5f0d3e79ad44b98088546d652d88a33965ecabaa477a946897ed6ac01d6f881e`. It is retained verbatim here:

```lean
import Mathlib.Tactic

namespace LonelyRunner

/-- The finite data retained from one normalized five-adic unit.  The carry tag
couples the double and triple carries, rather than choosing them independently. -/
structure FiveCarryState where
  top : Fin 5
  residue : Fin 2
  carry : Fin 4
  deriving DecidableEq, Fintype

/-- The selected carry for multipliers 1, 2, and 3 respectively. -/
def fiveCarryCarry (tag : Fin 4) (u : Fin 3) : Nat :=
  (![![0, 0, 0], ![0, 0, 1], ![0, 1, 1], ![0, 1, 2]] tag) u

/-- The top base-five digit after choosing multiplier `u.val + 1` and
translation `k.val`. -/
def fiveCarryDigit (s : FiveCarryState) (u : Fin 3) (k : Fin 5) : Fin 5 :=
  ⟨((u.val + 1) * s.top.val + fiveCarryCarry s.carry u +
      (u.val + 1) * k.val * (s.residue.val + 1)) % 5,
    Nat.mod_lt _ (by decide)⟩

/-- Every ordered triple of coupled carry states has a multiplier and
translation whose three digits avoid the two forbidden residues. -/
set_option maxRecDepth 100000 in
set_option maxHeartbeats 10000000 in
theorem fiveCarryTriple : ∀ s : Fin 3 → FiveCarryState,
    ∃ u : Fin 3, ∃ k : Fin 5, ∀ i,
      (fiveCarryDigit (s i) u k).val ∈ ({1, 2, 3} : Finset Nat) := by
  decide

end LonelyRunner
```


## Three-state quantifier encoding: external-cap failure

The preserved source above was replaced only by a private closed helper over
three explicit `FiveCarryState` arguments and a public derivation at `s 0`,
`s 1`, and `s 2` using `fin_cases`. The public theorem and digit API are
unchanged, so the logical domain is still all 40³ ordered triples; this
encoding simply avoids materializing `Fin 3 → FiveCarryState` before the
nested state quantifiers. The same theorem-local recursion and heartbeat
settings apply only to the helper.

The first syntax invocation exposed the documentation comment incorrectly
attached to a scoped `set_option`; after moving it, a second invocation showed
that an opaque private `def` blocked instance synthesis for the closed
proposition. Changing that internal predicate to `private abbrev` restored
ordinary decidability. Neither preliminary compiler diagnostic evaluated the
finite theorem or changed any resource cap. The one resulting direct pinned
Lean proof evaluation was:

```text
/usr/bin/time -f 'gnu_time_wall=%e gnu_time_rss_kib=%M gnu_time_exit=%x' \
python3 /tmp/five-adic-carry-three-monitor.py

monitor=limit_exceeded wall=8.554 sampled_rss_kib=4194484 child_exit=-9
Command exited with non-zero status 137
gnu_time_wall=8.68 gnu_time_rss_kib=4195788 gnu_time_exit=137
```

This retains the prepared allowlisted direct-binary environment and the same
all-thread 60-second/4 GiB process-group limit. The encoded finite proof also
exceeded the external RSS cap. No table, additional loop, source-domain
chunking, named build, axiom probe, `j = 3` fixture, or unmonitored evaluation
was run. The symbolic compression proof is now the separately assigned next
route, if chosen by the root.

Final structural-encoding source and monitor hashes:

```text
edcc4c6a1c8a31ce6188b92d9d0a21d09f01013027290d6ed6cfeb3d1876fdb3  LonelyRunner/FiveAdicCarry.lean
dd1126fc82224d8c924007a8e4d267659d558f49a61331400ff555e8b32c4f5a  /tmp/five-adic-carry-three-monitor.py
```

```python
import json, os, signal, subprocess, sys, time
payload=json.load(open("/tmp/astra-pinned-lean-env.json")); binary=payload.pop("resolved_lean_binary")
allowed={"LEAN_PATH","LEAN_SRC_PATH","LEAN_SYSROOT","PATH","LD_LIBRARY_PATH"}; assert set(payload)==allowed
env=os.environ.copy(); env.update(payload)
p=subprocess.Popen([binary,"LonelyRunner/FiveAdicCarry.lean"],env=env,start_new_session=True)
cap=4*1024*1024; start=time.monotonic(); peak=0
def rss(root):
    pending,seen,total=[root],set(),0
    while pending:
        pid=pending.pop()
        if pid in seen: continue
        seen.add(pid)
        try:
            task=f"/proc/{pid}/task"
            for tid in os.listdir(task):
                try:
                    with open(f"{task}/{tid}/children") as f: pending.extend(int(x) for x in f.read().split())
                except FileNotFoundError: pass
            with open(f"/proc/{pid}/status") as f:
                for line in f:
                    if line.startswith("VmRSS:"): total+=int(line.split()[1]); break
        except (FileNotFoundError,ProcessLookupError): pass
    return total
while p.poll() is None:
    peak=max(peak,rss(p.pid)); elapsed=time.monotonic()-start
    if elapsed>60 or peak>cap:
        os.killpg(p.pid,signal.SIGKILL); rc=p.wait()
        print(f"monitor=limit_exceeded wall={elapsed:.3f} sampled_rss_kib={peak} child_exit={rc}")
        sys.exit(124 if elapsed>60 else 137)
    time.sleep(.02)
rc=p.wait(); elapsed=time.monotonic()-start; peak=max(peak,rss(p.pid))
print(f"monitor=pass wall={elapsed:.3f} sampled_rss_kib={peak} child_exit={rc}")
sys.exit(rc)
```
