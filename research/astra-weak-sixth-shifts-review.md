# Independent weak sixth-shift source review

**Accept both exact public contracts and their complete source proofs.** The
single authorized import probe is recorded below. I reviewed the original larger
manuscript previously, but authored neither this shorter root plan nor the Terra
Lean source. Only this report is owned. Current config/workflow/policy and focused
state were read: `/root/weak_sixth_shifts_review`, research/in_progress, checkpoint
`a4e324a`, requested Astra/xhigh, observed runtime metadata null. Startup validator
exit 0: `workflow structural validation passed; it cannot certify mathematical validity.`

The frozen source has only these two public declarations, at lines 15 and 57.
Both quantify over arbitrary real x,y,z, allowing negative and repeated phases.
The sole extra premise is the displayed weak inequality on x or z. Natural b is
chosen once, and the same b occurs in all three closed 1/6 conclusions. No speed,
sign, ordering, separation, positive-time, gcd or distinctness premise is added.

For weak-even, `exists_nonzero_third_shift_safe y 1` selects k≠0 in Fin 3;
`third_shift_safe_of_weak_bad x 1` is then used at that very same k. Thus k.val
is 1 or 2. If N(z+k/6)≥1/6, choose b=k.val. Equality belongs to this branch.
Otherwise N(z+k/6)<1/6 and b=k.val+3 gives the x,y phases an extra integer 1,
while the z phase gains 1/2. The exact identity N(w+1/2)=1/2−N(w) gives a norm
strictly greater than 1/3, sufficient for the closed target. The four natural
membership cases are precisely 1,2,4,5. Nat cast expansion precedes the integer
periodicity rewrites; there is no hidden subtraction/truncation assumption.

For weak-odd, `exists_third_shift_safe_nondivisible_family` is instantiated on
Fin 2 with phases ![x,y] and constant natural speed 1. Its strict-bad-set proof
allows at most one bad shift per label, so the chosen k simultaneously protects
both labels even if x=y. The three cases k=0,1,2 use b=3,4,2. The doubled phases
have shifts 1,4/3,2/3, equivalent to k/3 modulo integers. For k=0, the weak
premise gives N(z+1/2)≥1/3. For k=1 or 2, the z shifts are respectively 2/3
or 1/3, safe by the weak-bad helper at nonzero shifts 2 or 1. All endpoints stay
closed. The proof uses {2,3,4}, but the public contract remains 1≤b≤5.

I read the full three direct project dependencies, plus the spacing/separation
proofs and the actual norm/periodicity definitions. `circleNorm` is the quotient
norm on R/Z, not an absolute real phase. Integer translation is exact for every
real phase; the half-turn identity covers integer and half-integer endpoints.
The separation proof orders natural subtraction before casting, obtains ≥1/3,
and strict badness is used only where <1/6 is necessary. The imported family
lemma's cardinality hypothesis is exactly card≤2. The final proof uses ordinary
Lean tactics and no added axiom or computational trust shortcut.

Worker history: initial focused check exited 1; one repair then passed 3008 jobs.
The delivered receipt retains complete logs and initial/final hashes but **does
not retain the failed source bytes**. I cannot reconstruct or independently
certify that missing snapshot. The final log has tactic suggestions and linter
warnings; it is not warning-free. This historical evidence gap does not change
the reviewed final source or the separately guarded import probe. Receipt at
`research/astra-weak-sixth-shifts-implementation.json` had SHA `5588a6caeb02169855768aa5f3289410df11438da8367262972f75ba258e2074` when
read; it is excluded from runtime guards because root owns later bookkeeping.

These two phase helpers support the current N=6 branch. They establish neither
an unconditional five-moving theorem nor unrestricted LRC. After a verified
canonical N=6, research priority remains uniform arbitrary N.

Below are exact universal type assignments, full axiom queries and one frozen
Bash entry with its complete controller. Before running, source/artifact pairs,
plan, pins, Mathlib.Tactic and pinned runtime binaries are hashed. Mutable root
imports, AxiomAudit, state and other workers' files are excluded. The probe
imports WeakSixthShifts directly; no build, table evaluation, numerical fixture,
retry, cache cleanup or formatting option is used. AS8GiB, CPU59/60, wall60,
128KiB regular output files, -j1/-s65536 and both thread/stack environment values
are fixed. Timeout kills the child process group; all actual output is preserved
once in the receipt. A source/build-history conclusion is distinct from the
actual import-probe result. Root will inspect this receipt without a duplicate run.

Probe SHA: `35dca244236c91ba0dd4710129970f71a3c9c1ff045aab6b689a1ffb4d114762`

Launcher SHA: `848882ac11cd76265d9eae1271acab2321913cf6b85ea8d1fdad00b17bf3c921`

```json
{
  "LonelyRunner/WeakSixthShifts.lean": [4535, "8c2ba998a08976ffc33f6af0226908a1bc068c322bac793e071210c49b1ce61b"],
  "LonelyRunner/NonzeroThirdShift.lean": [1712, "fc8bdba703053b9e13b07b273ed9110345a51815422352e7e42d0a5552e13611"],
  "LonelyRunner/ThirdShiftExceptions.lean": [2183, "85590988cd0e104dc93fd51bc79aa326fe2799974eae426b7ea3336853872073"],
  "LonelyRunner/FoldedCirclePhase.lean": [2334, "957606878108847d5ceff47be621ff0fc9c0a0d976568b5f5ef3dbb6db10481e"],
  "LonelyRunner/ThirdShiftSpacing.lean": [1855, "146cdfd80495aced0eb93bc322559cf7e950a80b0d01534b2a57cce7129debaa"],
  "LonelyRunner/SeparatedPhaseFamily.lean": [1036, "28c5db2425eef754156e57c284959ff02da743f1fde424e053c4eae0c721b6bd"],
  "LonelyRunner/StructuredClasses.lean": [5385, "5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c"],
  "LonelyRunner/FastRunnerInsertion.lean": [6306, "dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5"],
  "LonelyRunner/ModularCertificates.lean": [6034, "8b7e9dc5be1236acb812607c19454fe43ecd1333145aef675e7df8e6d0c3871c"],
  ".lake/build/lib/lean/LonelyRunner/WeakSixthShifts.olean": [380896, "7417ff9d52f4b215e703e03b05b911f6876dfc37213f2b134c62e7c76e9a7208"],
  ".lake/build/lib/lean/LonelyRunner/NonzeroThirdShift.olean": [151344, "fe70d8a9609b15e9a3a1b12357025a6632a2f8316a957365b42ee8ec0f1ffd18"],
  ".lake/build/lib/lean/LonelyRunner/ThirdShiftExceptions.olean": [107128, "d9c38deec30bda66014ed4d3e4de79fe5934f323e44e39771d353667ce47c7f9"],
  ".lake/build/lib/lean/LonelyRunner/FoldedCirclePhase.olean": [169952, "3032bbcf8e5c414daea831a7a415a40b4f254e5b72428b6fa078742e891afc06"],
  ".lake/build/lib/lean/LonelyRunner/ThirdShiftSpacing.olean": [158224, "7bc4793433826271b91dd77e0eb635951c899f55acf5962b94ed3802a2b8c885"],
  ".lake/build/lib/lean/LonelyRunner/SeparatedPhaseFamily.olean": [67528, "eff265763238a85323240590e528ff8514eef2f4bdb405f0742e0f0a67f6ba41"],
  ".lake/build/lib/lean/LonelyRunner/StructuredClasses.olean": [326664, "4ada0ca2f0a5f20a8c83c3c2e58256e931c3b283882a88a074aeedb02d7e048f"],
  ".lake/build/lib/lean/LonelyRunner/FastRunnerInsertion.olean": [381480, "121edfbaed0d7b9fed32bacf891de838142988e48dcb4e7f2bed0c488ea49136"],
  ".lake/build/lib/lean/LonelyRunner/ModularCertificates.olean": [86696, "3fc9326cf1393d2b053c26cb27c8b6b174546cd588c7d8d4441c92dc5822f6c5"],
  ".lake/packages/mathlib/Mathlib/Tactic.lean": [16260, "c6f2c548596b635a3d5c8aff8b19cbdeb60dd54e41bb89a1cd03b1a54d335fa5"],
  ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Tactic.olean": [39360, "0534ef12e7aaf8ffbb6e520a91f922da4469d0dca2b54c87b4458e1faa28a6a2"],
  "lean-toolchain": [25, "8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af"],
  "lakefile.toml": [218, "bdcbaaa18d518409619215e8acf7892452c1fa5c6e80ba742ce67f7380682a26"],
  "lake-manifest.json": [3131, "887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218"],
  "research/astra-weak-sixth-shift-plan.md": [3461, "14b7ee8a536d6754d48f153d9962f97de5f86fc270cc50118a0bfa8ae6e3a6b9"],
  "/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lean": [9024, "e8baaa71855a616dc351028f3ad2200051b0671f423a1696a100e809302d5550"],
  "/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lake": [13840, "60330ab6f07dce20f3fa9ebb08e8b984ea9549eac172afeb15d9d2227060e2b3"],
  "/usr/bin/python3.12": [8025024, "a92f0f95e883390c7256b2e441484aac06b1002dbe1d924141a77c8d82f96223"]
}
```

```lean
import LonelyRunner.WeakSixthShifts

open LonelyRunner

example : ∀ x y z : ℝ,
    circleNorm x ≤ (1 : ℝ) / 6 →
    ∃ b : ℕ, (b = 1 ∨ b = 2 ∨ b = 4 ∨ b = 5) ∧
      (1 : ℝ) / 6 ≤ circleNorm (x + 2 * (b : ℝ) / 6) ∧
      (1 : ℝ) / 6 ≤ circleNorm (y + 2 * (b : ℝ) / 6) ∧
      (1 : ℝ) / 6 ≤ circleNorm (z + (b : ℝ) / 6) :=
  sixth_shift_weak_even

example : ∀ x y z : ℝ,
    circleNorm z ≤ (1 : ℝ) / 6 →
    ∃ b : ℕ, 1 ≤ b ∧ b ≤ 5 ∧
      (1 : ℝ) / 6 ≤ circleNorm (x + 2 * (b : ℝ) / 6) ∧
      (1 : ℝ) / 6 ≤ circleNorm (y + 2 * (b : ℝ) / 6) ∧
      (1 : ℝ) / 6 ≤ circleNorm (z + (b : ℝ) / 6) :=
  sixth_shift_weak_odd

#print axioms LonelyRunner.sixth_shift_weak_even
#print axioms LonelyRunner.sixth_shift_weak_odd
```

```bash
#!/usr/bin/env bash
set -euo pipefail
cd /home/joshua/lonely-runner-formalization
/usr/bin/python3 -I -B - <<'PY_WEAK_FIXED'
import hashlib,json,os,re,resource,signal,subprocess,tempfile,time
from pathlib import Path
root=Path.cwd(); report=root/'research/astra-weak-sixth-shifts-review.md'
t=report.read_text(); fence=chr(96)*3
block=lambda label:t.split(fence+label+'\n',1)[1].split(fence,1)[0].encode()
sha=lambda b:hashlib.sha256(b).hexdigest()
g=json.loads(block('json')); probe=block('lean'); launcher=block('bash')
marker='\n<!-- RESULT -->\n'; prefix=t.split(marker,1)[0]
base='/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/'
argv=[base+'lake','env','lean','-j','1','-s','65536','--stdin']
env={'PATH':base+':/usr/bin:/bin','HOME':os.environ['HOME'],'LANG':'C.UTF-8',
     'LEAN_NUM_THREADS':'1','LEAN_STACK_SIZE_KB':'65536'}
limits={'as_bytes':8589934592,'cpu_seconds':[59,60],'wall_seconds':60,'stream_bytes':131072}
out=Path(tempfile.mkdtemp(prefix='weak-sixth-review-'));(out/'probe.lean').write_bytes(probe)
r={'argv':argv,'environment':env,'limits':limits,'exit':None,'timeout':False,'error':None,
   'guards_before':False,'guards_after':False,'guard_count':len(g),
   'prefix_sha256':sha(prefix.encode()),'probe_sha256':sha(probe),'launcher_sha256':sha(launcher)}

def check():
 for p,(n,h) in g.items():
  q=(root/p).read_bytes();assert len(q)==n and sha(q)==h,p

def caps():
 resource.setrlimit(resource.RLIMIT_AS,(8589934592,)*2)
 resource.setrlimit(resource.RLIMIT_CPU,(59,60))
 resource.setrlimit(resource.RLIMIT_FSIZE,(131072,)*2)
 resource.setrlimit(resource.RLIMIT_CORE,(0,0))

start=time.monotonic(); before=resource.getrusage(resource.RUSAGE_CHILDREN); proc=None
try:
 assert sha(probe)==re.search(r'^Probe SHA: `([0-9a-f]{64})`$',t,re.M)[1]
 assert sha(launcher)==re.search(r'^Launcher SHA: `([0-9a-f]{64})`$',t,re.M)[1]
 check();r['guards_before']=True
 with (out/'probe.lean').open('rb') as si,(out/'stdout').open('wb') as so,(out/'stderr').open('wb') as se:
  proc=subprocess.Popen(argv,stdin=si,stdout=so,stderr=se,env=env,
                        start_new_session=True,preexec_fn=caps)
  try:r['exit']=proc.wait(timeout=60)
  except subprocess.TimeoutExpired:
   r['timeout']=True;os.killpg(proc.pid,signal.SIGKILL);r['exit']=proc.wait()
 check();r['guards_after']=True
 assert report.read_text()==t,'report changed'
 r['prefix_after_sha256']=sha(report.read_text().split(marker,1)[0].encode())
except BaseException as e:
 r['error']=repr(e)
 if proc is not None and proc.poll() is None:
  os.killpg(proc.pid,signal.SIGKILL);r['exit']=proc.wait()
after=resource.getrusage(resource.RUSAGE_CHILDREN)
r.update(wall_seconds=time.monotonic()-start,user_seconds=after.ru_utime-before.ru_utime,
         system_seconds=after.ru_stime-before.ru_stime,max_rss_kib=after.ru_maxrss)
for name in ['stdout','stderr']:
 p=out/name
 if not p.exists():p.write_bytes(b'')
 q=p.read_bytes();r[name]={'bytes':len(q),'sha256':sha(q),'text':q.decode(errors='replace')}
expected=['LonelyRunner.sixth_shift_weak_even','LonelyRunner.sixth_shift_weak_odd']
allowed={'propext','Classical.choice','Quot.sound'}
pat=r"'([^']+)' depends on axioms: \[([^\]]*)\]"
hits=list(re.finditer(pat,r['stdout']['text']));axioms={}
for m in hits:axioms[m[1]]=[s.strip() for s in m[2].split(',') if s.strip()]
r['axioms']=axioms
valid=(list(axioms)==expected and len(hits)==2 and
       all(set(v)<=allowed for v in axioms.values()) and
       re.sub(pat,'',r['stdout']['text']).strip()=='')
r['passed']=(r['exit']==0 and r['error'] is None and not r['timeout'] and valid
 and r['guards_before'] and r['guards_after'] and r['stderr']['bytes']==0
 and all(r[n]['bytes']<131072 for n in ['stdout','stderr']))
q=(json.dumps(r,sort_keys=True,indent=2)+'\n').encode();(out/'receipt.json').write_bytes(q)
print('EVIDENCE',out);print('RECEIPT_SHA',sha(q));print(q.decode(),end='')
raise SystemExit(0 if r['passed'] else 1)
PY_WEAK_FIXED
```

<!-- RESULT -->

**Import verification accepted.** One actual invocation, exit 0, no timeout or
stderr, both universal assignments accepted and both complete axiom lists within
the allowed three. All 27 guards and the report prefix matched before/after.
There was no build, retry or numeric evaluation. The final proof has no semantic
correction requested; retain the failed-worker-source evidence limitation above.

Pre-run report SHA: `8b12d909b03fa703793df30cb954baa18e69b0cef6306c99a2330f0cbb14aee1`.
Outer capture `/tmp/weak-sixth-entry-1iq3uz5u` exited 0;
receipt SHA `b72e57a9e352b13755cd0ea5a49281b116f761658fe663d7edecc3f4cab8716a`.
Its stdout is 1993 bytes, SHA
`6060a5c9ea2732b1cd08cd8958c7ffe26732571d4bee17549aa2c17842c3657a`; stderr empty.
Full controller stdout follows; nested stdout text preserves the exact raw Lean
output once. All original small receipt and stream files remain at these paths.

```text
EVIDENCE /tmp/weak-sixth-review-gfywwb1u
RECEIPT_SHA 15fde9d25a558e496ac5741a9f0d17267a4595cab6bdab3f7ed25392b9599d66
{
  "argv": [
    "/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lake",
    "env",
    "lean",
    "-j",
    "1",
    "-s",
    "65536",
    "--stdin"
  ],
  "axioms": {
    "LonelyRunner.sixth_shift_weak_even": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ],
    "LonelyRunner.sixth_shift_weak_odd": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ]
  },
  "environment": {
    "HOME": "/home/joshua",
    "LANG": "C.UTF-8",
    "LEAN_NUM_THREADS": "1",
    "LEAN_STACK_SIZE_KB": "65536",
    "PATH": "/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/:/usr/bin:/bin"
  },
  "error": null,
  "exit": 0,
  "guard_count": 27,
  "guards_after": true,
  "guards_before": true,
  "launcher_sha256": "848882ac11cd76265d9eae1271acab2321913cf6b85ea8d1fdad00b17bf3c921",
  "limits": {
    "as_bytes": 8589934592,
    "cpu_seconds": [
      59,
      60
    ],
    "stream_bytes": 131072,
    "wall_seconds": 60
  },
  "max_rss_kib": 3281972,
  "passed": true,
  "prefix_after_sha256": "7758619229b698e8838cbed59c14fcfba774138d3a8b92fdb70c33cc7dbbbb6f",
  "prefix_sha256": "7758619229b698e8838cbed59c14fcfba774138d3a8b92fdb70c33cc7dbbbb6f",
  "probe_sha256": "35dca244236c91ba0dd4710129970f71a3c9c1ff045aab6b689a1ffb4d114762",
  "stderr": {
    "bytes": 0,
    "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
    "text": ""
  },
  "stdout": {
    "bytes": 191,
    "sha256": "d9962b6322a28fafead6a846baeb9c3cae364f7c48e8c5b186cd141d9184ef39",
    "text": "'LonelyRunner.sixth_shift_weak_even' depends on axioms: [propext, Classical.choice, Quot.sound]\n'LonelyRunner.sixth_shift_weak_odd' depends on axioms: [propext, Classical.choice, Quot.sound]\n"
  },
  "system_seconds": 0.5798519999999999,
  "timeout": false,
  "user_seconds": 1.264356,
  "wall_seconds": 1.8858125149854459
}
```
