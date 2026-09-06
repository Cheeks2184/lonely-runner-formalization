# Independent source review: one-even branch

Semantic verdict: accepted, with no source correction required. The two public
contracts are reproduced in full by the universal assignments below. They give
one positive real time with all five closed 1/6 bounds, under the stated residue
conditions. They require neither primitive/gcd data nor injectivity of speed
values. Repeated positive speeds are allowed. This is the restricted one-even
branch, not a canonical six-runner theorem or unrestricted LRC.

I authored the bound assembly plan `3c422d32…`, but did not author this Lean
implementation. This is independent implementation-source review. The original
one-three-divisible manuscript has the separate review `8f720fbd…`. Source,
assembly and original-manuscript bindings are included below. Terra's focused
compilation receipt is accepted rather than rerun.

## Complete proof assessment

The unit-residue helper removes the two even centered residues using integer
witnesses `3*z+1` and `3*z-1`. Integer divisibility is cast back to natural
`2∣d`; no positivity assumption on the integer quotient is introduced. The
fractional affine identity applies to arbitrary real time and integer shift.
Its norm counterpart follows by rewriting both norms as the minimum of the
two fractional distances. For a six-divisible natural speed, its natural
quotient is cast before the integer residue-zero identity is applied. Both
private phase and norm preservation statements allow negative shifts.

The map `ρ j = p.succAbove (q.succAbove j)`, where `p.succAbove q = r`, excludes
both selected labels. Cancellation in the outer map proves exclusion of `r`;
two applications of `Fin.exists_succAbove_eq` prove exhaustion of every other
label. These are facts about labels, so coincident speed values do not affect
the proof. Every remaining label obtains its signed unit residue independently,
but all three then use one shared phase-theorem choice of `a,b`.

The internal contradiction assumes absence of an all-real closed witness.
The existing complement maximizer gives `0<m<1/6`, `m=fract(τ*v p)=N(τ*v p)`,
a maximum over **all real** complement-safe times, and an actual upper face
`fract(τ*v r)=5/6`. Its strict complement seed comes from the four-moving 1/5
theorem. No five-moving 1/6 witness is supplied as a premise. Writing the
anchor residue as `σ=±1`, the shift `t'=τ+σ/6` preserves the pivot phase and
makes the anchor phase zero, because the integer square `σ*σ` is one.

For the closed phase alternative, `s=a*t'+b/6` transports the same choice to
all three remaining labels. The anchor has norm `N(σ*b/6)≥1/6` for
`1≤b≤5`. The label exhaustion proves its entire complement safe. The source
uses the actual **integer** `B=(a:ℤ)*σ+(b:ℤ)` and proves
`s=a*τ+B/6`; no truncated natural subtraction appears. With `2≤a≤5`, the
reciprocal improvement theorem at denominator six contradicts the all-real
maximum. The pivot is being strictly improved, not assumed safe at `s`.

For the strict alternative, the source selects signed 5.1 for `σ=1` and its
reflected version for `σ=-1`. The respective exact shift sets are `{1,2,4}`
and `{2,4,5}`. Its private rational endpoint proof splits these supplied
symbolic alternatives using `norm_num [Int.fract]`. This is ordinary kernel
proof, not a numerical experiment or external certificate. The anchor's
actual fractional part is at least 1/6 and strictly below 5/6, including the
allowed lower-face equality. Each of the other three strict norms yields both
strict fractional inequalities via `lt_min_iff`. The pivot's fractional part
and norm remain unchanged at `s=t'+b/6`. The forward-complement theorem thus
applies with positive speeds and actual upper faces strictly below 5/6. It
gives a larger objective at `s+ε`, again contradicting the all-real maximum.
Neither intermediate time needs to be positive.

The public wrapper first obtains an all-real witness. Its pivot bound excludes
time zero. A negative witness is reflected using `circleNorm_neg`, producing
a positive common time and preserving every closed bound. The count adapter
uses `6∣v p` to put `p` in the even-label filter, cardinality one to exclude all
other labels, and the supplied equivalence for three-divisibility. It invokes
the pointwise theorem without adding a gcd, distinct-speed or witness premise.
All private proofs and both public proofs have been inspected in full.

## Evidence and one-probe predeclaration

Current project instructions, workflow, policy and focused task state were
read. The active task was `/root/one_even_source_review`, checkpoint `a4e324a`,
requested Astra/xhigh; runtime-observed routing is not independently reported.
`python3 scripts/validate_workflow.py` exited 0 with stdout exactly
`workflow structural validation passed; it cannot certify mathematical validity.`
followed by a newline. An exploratory `lakefile.lean` hash lookup failed because
this repository uses `lakefile.toml`; the actual file is bound below. The first
report-generator command failed before execution with a Python unterminated
triple-string diagnostic from a nested shell heredoc delimiter; it created no
report and launched no Lean process. The corrected generator uses a distinct
outer shell delimiter. No mathematical execution was part of source discovery.

The worker receipt's three full source snapshots and log bodies were checked
against their recorded hashes. Its focused checks had exits 1, 1, 0, preserving
both repair rounds. The final source and olean match the bound files. The final
log ends `Built LonelyRunner.OneEvenRunners (2.6s)` and
`Build completed successfully (3542 jobs).`; its complete retained log hash is
`2a7e4373a43e846a84a7e8a13b1dc85675b12868c9b52ff2f00740e7fa434b87`.
Those historical focused checks were not rerun. The complete receipt remains
in its guarded JSON rather than being copied into this report.

Predeclare exactly one import-only invocation: the two expanded type
assignments and two axiom prints below, no additional examples or source build.
Child caps are 8 GiB address space, CPU soft/hard 59/60 seconds and 128 KiB per
regular output file; the supervisor waits at most 60 seconds before killing
the child process group. Lean is serial, with the explicit stack settings shown
in the launcher. All stdout/stderr bytes are read from regular files and
retained once as JSON strings; reaching an output cap fails the check. No
retry is authorized. Guards cover this source, its direct imports, the named
settled dependency sources/oleans, pins and manuscripts/receipt. This finite
list is not a hash closure of every transitive import; mutable root integration,
audit, state and other workers' files are deliberately outside the guard set.

Predeclared probe: 903 bytes, SHA-256 `6088fd3a7778b6f31fd82d2dd2ec67a7b9541569f832a0e42229e72164953f91`.

Predeclared guard block: 2695 bytes, SHA-256 `e495cadea1d92d80c531b1ca32b893edd89baa526008d299059c3d3fa0ed3a92`.

Predeclared launcher: 4498 bytes, SHA-256 `89dc1ab8255f187096fad3f3a12d818976cf45a833b01fbff2dff430b04d1790`.

<!-- probe:begin -->
```lean
import LonelyRunner.OneEvenRunners

example :
    ∀ (v : Fin 5 → ℕ), (∀ i, 0 < v i) → ∀ (p : Fin 5),
      6 ∣ v p →
      (∀ i, i ≠ p → ¬ 2 ∣ v i) →
      (∀ i, i ≠ p → ¬ 3 ∣ v i) →
      ∃ t : ℝ, 0 < t ∧ ∀ i,
        (1 : ℝ) / 6 ≤ LonelyRunner.circleNorm (t * (v i : ℝ)) :=
  LonelyRunner.fiveMovingNaturalRunners_of_one_even_residues

example :
    ∀ (v : Fin 5 → ℕ), (∀ i, 0 < v i) → ∀ (p : Fin 5),
      6 ∣ v p →
      (∀ i, 3 ∣ v i ↔ i = p) →
      ((Finset.univ : Finset (Fin 5)).filter (fun i => 2 ∣ v i)).card = 1 →
      ∃ t : ℝ, 0 < t ∧ ∀ i,
        (1 : ℝ) / 6 ≤ LonelyRunner.circleNorm (t * (v i : ℝ)) :=
  LonelyRunner.one_three_divisible_one_even_witness

#print axioms LonelyRunner.fiveMovingNaturalRunners_of_one_even_residues
#print axioms LonelyRunner.one_three_divisible_one_even_witness
```
<!-- probe:end -->

<!-- guards:begin -->
```json
{
  "LonelyRunner/OneEvenRunners.lean": "5bf5f01d7b31b410b680d646a832b273890cc267dc7a4775fea37eac5c58b810",
  ".lake/build/lib/lean/LonelyRunner/OneEvenRunners.olean": "eee9f9b95ef2992e33f1a46d742668ae516349eaee1c467591c479637949e014",
  "LonelyRunner/OneSixthComplementMaximizer.lean": "5a7011ca680b8a2b26c7bad466a8ee4008cf47507eb8b700846f296894bb90a1",
  ".lake/build/lib/lean/LonelyRunner/OneSixthComplementMaximizer.olean": "478c4c4899a0b4b0154c6be49ac35daf4d292706c79552adf9b990e3ae92d293",
  "LonelyRunner/SignedRenaultFiveOne.lean": "6971e02483c2b1e6f3d717ed5d4784fd8decfbdba6f6bdc9d8aca0dff2f4f3fc",
  ".lake/build/lib/lean/LonelyRunner/SignedRenaultFiveOne.olean": "368d25f93e3f7e339a157e1e13bc0bec91027993c25c146905b3bc7a9edd1bfa",
  "LonelyRunner/SixthAffinePhase.lean": "76e420713079ec0c3979e9b169cd78ecb6a932d6dc790ea7d9711adbb64b7d4b",
  ".lake/build/lib/lean/LonelyRunner/SixthAffinePhase.olean": "9a0cbfec2825c4b98fc7897835dc726929daabb3328a2d45818765c568cf47b3",
  "LonelyRunner/ConstrainedMaximizer.lean": "2ef07e6b83b8675a22184571c31d2a71dab9d5c072e3cd165cb8382957b46e92",
  ".lake/build/lib/lean/LonelyRunner/ConstrainedMaximizer.olean": "443a61889184bd7fc7ea52a85ebcfa3fc0ba6f1e458b34824afb166812f38170",
  "LonelyRunner/FiveRunnerOrdinary.lean": "662d0116f13971bce85e76c503e2f3be4fdc6291ba8113aeda43957e38354ffe",
  ".lake/build/lib/lean/LonelyRunner/FiveRunnerOrdinary.olean": "408abf21f2b4e3c356ae528f92762826556887d7e5068283399a79d6ca72ef31",
  "LonelyRunner/RenaultPhaseLemma.lean": "1ceac85438299dffdd48d57fb0052b598a9bd5eda995cabff0256885529d89cb",
  ".lake/build/lib/lean/LonelyRunner/RenaultPhaseLemma.olean": "b5a78878c8fa760a5eed5d42d0ba5b28c1735a5e8750c5acc258e921d9df4c6f",
  ".lake/packages/mathlib/Mathlib/Tactic.lean": "c6f2c548596b635a3d5c8aff8b19cbdeb60dd54e41bb89a1cd03b1a54d335fa5",
  ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Tactic.olean": "0534ef12e7aaf8ffbb6e520a91f922da4469d0dca2b54c87b4458e1faa28a6a2",
  "lean-toolchain": "8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af",
  "lake-manifest.json": "887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218",
  "lakefile.toml": "bdcbaaa18d518409619215e8acf7892452c1fa5c6e80ba742ce67f7380682a26",
  "research/astra-one-even-assembly-plan.md": "3c422d32bc73321f3b52726222b48b7b2c7d19052f4c5d07cbcd2ed9a935df04",
  "research/astra-one-three-divisible-plan.md": "9da230600af3a0a0bc8223de3daca2575f8d41f447142687ca64db53ced4ae9e",
  "research/astra-one-three-divisible-review.md": "8f720fbd8002918adaaa0d36fc7774c450eeb5dba84dd555552d24b5e57e6078",
  "research/astra-one-even-implementation.json": "91c51136837dfc992eb3fd8267cab7324be4272ddf8ee526c58ecd571515b5c1"
}
```
<!-- guards:end -->

<!-- launcher:begin -->
```python
import hashlib, json, os, pathlib, re, resource, signal, subprocess, tempfile, time
root = pathlib.Path.cwd()
report = (root / "research/astra-one-even-source-review.md").read_text()
def block(label, language):
    start = f"<!-- {label}:begin -->\n```{language}\n"
    end = f"```\n<!-- {label}:end -->"
    assert report.count(start) == 1 and report.count(end) == 1
    return report.split(start, 1)[1].split(end, 1)[0].encode()
def digest(data):
    return hashlib.sha256(data).hexdigest()
probe = block("probe", "lean")
guard_bytes = block("guards", "json")
assert digest(probe) == "6088fd3a7778b6f31fd82d2dd2ec67a7b9541569f832a0e42229e72164953f91"
assert digest(guard_bytes) == "e495cadea1d92d80c531b1ca32b893edd89baa526008d299059c3d3fa0ed3a92"
guards = json.loads(guard_bytes)
def verify():
    for path, expected in guards.items():
        with (root / path).open("rb") as stream:
            assert hashlib.file_digest(stream, "sha256").hexdigest() == expected, path
    return len(guards)
command = ["/home/joshua/.elan/bin/lake", "env", "lean", "-j1", "-s65536", "--stdin"]
cap = 131072
env = os.environ.copy()
env.update(LEAN_NUM_THREADS="1", LEAN_STACK_SIZE_KB="65536", LC_ALL="C.UTF-8")
env["PATH"] = "/home/joshua/.elan/bin:" + env.get("PATH", "")
def limits():
    resource.setrlimit(resource.RLIMIT_AS, (8589934592, 8589934592))
    resource.setrlimit(resource.RLIMIT_CPU, (59, 60))
    resource.setrlimit(resource.RLIMIT_FSIZE, (cap, cap))
    os.umask(0o077)
r = {"command": command, "cwd": str(root), "env_overrides": {
    "LEAN_NUM_THREADS": "1", "LEAN_STACK_SIZE_KB": "65536", "LC_ALL": "C.UTF-8",
    "PATH_prefix": "/home/joshua/.elan/bin:"},
    "limits": {"address_space_bytes": 8589934592, "cpu_soft_seconds": 59,
    "cpu_hard_seconds": 60, "parent_timeout_seconds": 60,
    "each_stream_file_limit_bytes": cap},
    "probe_sha256": digest(probe), "guard_block_sha256": digest(guard_bytes),
    "status": "not_started"}
try:
    r["guards_before"] = verify()
    with tempfile.TemporaryDirectory(prefix="lr-one-even-import-") as work:
        out = pathlib.Path(work) / "stdout"
        err = pathlib.Path(work) / "stderr"
        before = resource.getrusage(resource.RUSAGE_CHILDREN)
        start = time.monotonic()
        with out.open("wb") as stdout, err.open("wb") as stderr:
            child = subprocess.Popen(command, cwd=root, env=env, stdin=subprocess.PIPE,
                stdout=stdout, stderr=stderr, preexec_fn=limits, start_new_session=True)
            timed_out = False
            try:
                child.communicate(input=probe, timeout=60)
            except subprocess.TimeoutExpired:
                timed_out = True
                os.killpg(child.pid, signal.SIGKILL)
                child.communicate()
        elapsed = time.monotonic() - start
        after = resource.getrusage(resource.RUSAGE_CHILDREN)
        stdout_bytes, stderr_bytes = out.read_bytes(), err.read_bytes()
        r.update(exit_code=child.returncode, timed_out=timed_out, elapsed_seconds=elapsed,
            child_user_cpu_seconds=after.ru_utime-before.ru_utime,
            child_system_cpu_seconds=after.ru_stime-before.ru_stime,
            child_maxrss_kib=after.ru_maxrss,
            stdout_bytes=len(stdout_bytes), stderr_bytes=len(stderr_bytes),
            stdout_sha256=digest(stdout_bytes), stderr_sha256=digest(stderr_bytes),
            stdout=stdout_bytes.decode("utf-8"), stderr=stderr_bytes.decode("utf-8"))
    r["guards_after"] = verify()
    expected_names = ["LonelyRunner.fiveMovingNaturalRunners_of_one_even_residues",
                      "LonelyRunner.one_three_divisible_one_even_witness"]
    found = re.findall(r"'([^']+)' depends on axioms:\s*\[([^\]]*)\]", r["stdout"], re.S)
    assert [name for name, _ in found] == expected_names, "two exact axiom reports required"
    r["axioms"] = {name: [x.strip() for x in names.split(",") if x.strip()]
                   for name, names in found}
    allowed = {"propext", "Classical.choice", "Quot.sound"}
    assert all(set(values) <= allowed for values in r["axioms"].values()), "unexpected axiom"
    assert child.returncode == 0 and not timed_out, "import failed"
    assert len(stdout_bytes) < cap and len(stderr_bytes) < cap, "output reached cap"
    r["status"] = "passed"
except Exception as exc:
    r["status"] = "failed"
    r["error"] = type(exc).__name__ + ": " + str(exc)
print(json.dumps(r, indent=2, ensure_ascii=False))
raise SystemExit(0 if r["status"] == "passed" else 1)
```
<!-- launcher:end -->

The single exact entry point below executes the predeclared import probe. It
is provided for provenance; root will inspect this receipt without repeating
the identical invocation.

<!-- entry:begin -->
```bash
cd /home/joshua/lonely-runner-formalization
python3 - <<'PY'
import hashlib, pathlib
text = pathlib.Path("research/astra-one-even-source-review.md").read_text()
code = text.split("<!-- launcher:begin -->\n```python\n", 1)[1].split("```\n<!-- launcher:end -->", 1)[0]
assert hashlib.sha256(code.encode()).hexdigest() == "89dc1ab8255f187096fad3f3a12d818976cf45a833b01fbff2dff430b04d1790"
exec(compile(code, "<one-even-import-review>", "exec"))
PY
```
<!-- entry:end -->

## Actual outcome

Exact entry point executed once. Bash/launcher exit: `0`.

Complete launcher stdout below (1726 bytes; SHA-256 `a7c09bc9a85cd36bc23091c33f02dc5e2e1508f56df1ae7c34b7843eff5fc098`). Its `stdout` and `stderr` JSON strings retain the complete raw Lean streams without duplication.

```json
{
  "command": [
    "/home/joshua/.elan/bin/lake",
    "env",
    "lean",
    "-j1",
    "-s65536",
    "--stdin"
  ],
  "cwd": "/home/joshua/lonely-runner-formalization",
  "env_overrides": {
    "LEAN_NUM_THREADS": "1",
    "LEAN_STACK_SIZE_KB": "65536",
    "LC_ALL": "C.UTF-8",
    "PATH_prefix": "/home/joshua/.elan/bin:"
  },
  "limits": {
    "address_space_bytes": 8589934592,
    "cpu_soft_seconds": 59,
    "cpu_hard_seconds": 60,
    "parent_timeout_seconds": 60,
    "each_stream_file_limit_bytes": 131072
  },
  "probe_sha256": "6088fd3a7778b6f31fd82d2dd2ec67a7b9541569f832a0e42229e72164953f91",
  "guard_block_sha256": "e495cadea1d92d80c531b1ca32b893edd89baa526008d299059c3d3fa0ed3a92",
  "status": "passed",
  "guards_before": 23,
  "exit_code": 0,
  "timed_out": false,
  "elapsed_seconds": 1.9687483739980962,
  "child_user_cpu_seconds": 1.293863,
  "child_system_cpu_seconds": 0.659181,
  "child_maxrss_kib": 3650004,
  "stdout_bytes": 231,
  "stderr_bytes": 0,
  "stdout_sha256": "9afb5e155978e93447737dc3959052eeafec2cd7127f30c0ccdab656468e1d75",
  "stderr_sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
  "stdout": "'LonelyRunner.fiveMovingNaturalRunners_of_one_even_residues' depends on axioms: [propext, Classical.choice, Quot.sound]\n'LonelyRunner.one_three_divisible_one_even_witness' depends on axioms: [propext, Classical.choice, Quot.sound]\n",
  "stderr": "",
  "guards_after": 23,
  "axioms": {
    "LonelyRunner.fiveMovingNaturalRunners_of_one_even_residues": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ],
    "LonelyRunner.one_three_divisible_one_even_witness": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ]
  }
}
```

Complete launcher stderr: '' (0 bytes; SHA-256 `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`).

The pre-invocation report was frozen at SHA-256
`9c658a30412b622de475ee135f1d8efdba9166d82bc9959168ceac7493938539`.
The actual single probe passed both universal assignments and both complete
allowed-axiom checks; all 23 file guards passed before and after. There was no
Lean failure or retry. The reported Linux child maximum RSS is the supervisor's
`RUSAGE_CHILDREN.ru_maxrss`, not a sum of simultaneous processes' memory.

Final verdict: accept both exact public contracts and their source proofs.
No mathematical or source correction remains within this module. Integration
and trust validation of the complete checkpoint remain root-owned. This report
adds no unrestricted LRC or canonical N=6 completion claim; after the verified
canonical N=6 milestone, the standing research priority is a uniform arbitrary-N
mechanism. Only this report was persistently edited; temporary output files
were removed after their complete contents were retained here.
