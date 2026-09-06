# Rational-margin box pilot implementation

2026-09-06. The frozen plan SHA-256 was verified as
`0c1eecb6872e4c202643e5fdf237747b8262a06ed2de4cc7fea2bd84acf8a67a`.
Workflow validation passed. This additive pilot does not claim a finite K5
certificate, tuple search, or uniform supply result.

`RationalMarginBoxes.lean` implements natural boxes with derived split
children, a raw rational-band leaf Boolean, tree and public root guards, and
natural split coverage. A checked raw leaf transports its cross-product bounds
through a contained row and applies the closed integer-band circle-norm lemma.
It supplies a common positive leaf time. Structural tree induction gives the
planned row-dependent rational witness and positive-time theorem for every
contained root row. This retains zero margins, repeated or zero speeds,
`n = 0`, and vacuous raw empty boxes.

`RationalMarginBoxPilot.lean` contains exactly the supplied root
`(2,3,5,6)..(3,4,5,8)`, margins `(1/5,1/5,1/5,1/4)`, and two derived leaves
split at coordinate 3/cut 7. Named declarations provide kernel acceptance,
universal contained-row rational witnesses, and universal positive-time
witnesses. The source proves a two-leaf count and covers repeated coordinates
and both split-boundary rows through the universal theorem without row
enumeration.

Fixed kernel controls cover unsplit, below-root, and at-upper cuts; a failing
child and wrong band; zero-margin integer-upper and zero-speed acceptance;
closed-half acceptance and above-half rejection; zero denominator, zero
numerator-time, and zero denominator-time rejection; raw-empty acceptance
versus public-empty rejection; and `Fin 0` acceptance.

## Recovered milestones and ordinary checks

The initial pilot probe was a time-enforced source check with a measured RSS,
but did not enforce the RSS cap; it is historical only. The subsequently
recovered raw-leaf and structural soundness milestones each source-checked and
named-built successfully before the final pilot gate below. Focused builds
remain successful:

```text
lake env lean LonelyRunner/RationalMarginBoxes.lean    # exit 0
lake build LonelyRunner.RationalMarginBoxes             # exit 0, 3002 jobs
lake build LonelyRunner.RationalMarginBoxPilot          # exit 0, 3003 jobs, 1.4 s
```

An stdin import probe checked the exact public types of
`rationalMarginBoxPilot_accepts`, `rationalMarginBoxPilot_row`,
`rationalMarginBoxPilot_exists_positive_time`, and
`rationalMarginBoxPilot_two_leaves`. The acceptance and count declarations
use only `propext`; the row and positive-time declarations use only
`propext`, `Classical.choice`, and `Quot.sound`.

## Final externally enforced pilot gate

The following complete runnable command was executed from the repository.
It guards the frozen Lean source hashes and source byte bound before Lean,
asserts the fixed two-leaf certificate bound, starts Lean in a new process
group, samples `VmRSS` over every discovered process and every thread's child
list, and kills the whole group upon a sampled 4 GiB or 60-second breach.
GNU `time` supplies a post-run peak RSS. The command parses and asserts child
exit 0, whole wall time at most 60 seconds, and GNU peak RSS at most 4194304
KiB before it returns success.

```bash
#!/usr/bin/env bash
set -euo pipefail
root=/home/joshua/lonely-runner-formalization
cd "$root"
source=LonelyRunner/RationalMarginBoxPilot.lean
box_source=LonelyRunner/RationalMarginBoxes.lean
expected_pilot=25e144207b1ef4121c155f50d9ca9209655bcca46fdc40b1b06a4bc88f1f84e8
expected_boxes=9faab792a9e4120d931cb24eef071b072eee89a580d174f224ec2a7a123d51bf
printf '%s  %s\n%s  %s\n' "$expected_pilot" "$source" "$expected_boxes" "$box_source" | sha256sum -c -
test "$(wc -c < "$source")" -le 65536
test 2 -le 256
monitor=$(mktemp)
out=$(mktemp)
timing=$(mktemp)
trap 'rm -f "$monitor" "$out" "$timing"' EXIT
cat > "$monitor" <<'PYMON'
import os, signal, subprocess, sys, time
cmd = ["lake", "env", "lean", "LonelyRunner/RationalMarginBoxPilot.lean"]
cap = 4 * 1024 * 1024
p = subprocess.Popen(cmd, start_new_session=True)
start = time.monotonic()
peak = 0
def descendants_rss(root):
    pending, seen, total = [root], set(), 0
    while pending:
        pid = pending.pop()
        if pid in seen:
            continue
        seen.add(pid)
        try:
            task_dir = f"/proc/{pid}/task"
            for tid in os.listdir(task_dir):
                child_path = f"{task_dir}/{tid}/children"
                try:
                    with open(child_path) as f:
                        pending.extend(int(x) for x in f.read().split())
                except FileNotFoundError:
                    pass
            with open(f"/proc/{pid}/status") as f:
                for line in f:
                    if line.startswith("VmRSS:"):
                        total += int(line.split()[1])
                        break
        except (FileNotFoundError, ProcessLookupError):
            pass
    return total
while p.poll() is None:
    peak = max(peak, descendants_rss(p.pid))
    elapsed = time.monotonic() - start
    if elapsed > 60 or peak > cap:
        os.killpg(p.pid, signal.SIGKILL)
        rc = p.wait()
        print(f"monitor=limit_exceeded wall={elapsed:.3f} sampled_rss_kib={peak} child_exit={rc}")
        sys.exit(124 if elapsed > 60 else 137)
    time.sleep(.02)
rc = p.wait()
elapsed = time.monotonic() - start
peak = max(peak, descendants_rss(p.pid))
print(f"monitor=pass wall={elapsed:.3f} sampled_rss_kib={peak} child_exit={rc}")
sys.exit(rc)
PYMON
/usr/bin/time -o "$timing" -f 'gnu_time_wall=%e gnu_time_rss_kib=%M gnu_time_exit=%x' \
  python3 "$monitor" > "$out"
python3 - "$timing" <<'PYCHECK'
import re, sys
line = open(sys.argv[1]).read().strip()
m = re.fullmatch(r'gnu_time_wall=([0-9.]+) gnu_time_rss_kib=(\d+) gnu_time_exit=(\d+)', line)
assert m, line
wall, rss, rc = float(m.group(1)), int(m.group(2)), int(m.group(3))
assert rc == 0, line
assert wall <= 60, line
assert rss <= 4 * 1024 * 1024, line
PYCHECK
cat "$out"
cat "$timing"
printf 'source_bytes=%s leaves=%s\n' "$(wc -c < "$source")" 2
```

The final run exited 0. Its temporary command and captured stdout hashes were:

```text
7e79d8262730f7258e3b50fff058f778fad4e0fadac1d5e9699e3527cbd2c1e1  /tmp/rational-margin-box-pilot-monitor.sh
92c5d97e5c3ae2c77dc97c82cf3532e227189ab61fe3830860a934d1a4091747  /tmp/rational-margin-box-pilot-monitor.stdout
```

The captured stdout was:

```text
LonelyRunner/RationalMarginBoxPilot.lean: OK
LonelyRunner/RationalMarginBoxes.lean: OK
monitor=pass wall=1.873 sampled_rss_kib=4118028 child_exit=0
gnu_time_wall=1.89 gnu_time_rss_kib=3319496 gnu_time_exit=0
source_bytes=5646 leaves=2
```

The sampled RSS and GNU-time peak are reported separately: sampled RSS is the
online stop condition, while the GNU 3,319,496 KiB peak is the independently
asserted postcheck. Both are below 4 GiB. Timing output is necessarily
variable; the source and complete monitor code are hash-guarded above.

Final frozen source hashes:

```text
9faab792a9e4120d931cb24eef071b072eee89a580d174f224ec2a7a123d51bf  LonelyRunner/RationalMarginBoxes.lean
25e144207b1ef4121c155f50d9ca9209655bcca46fdc40b1b06a4bc88f1f84e8  LonelyRunner/RationalMarginBoxPilot.lean
```
