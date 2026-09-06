# Independent supplied phase-data review

**Accept the fixed source semantics; actual verification appears below.**
I authored neither program and own only this report. I read config/workflow/policy,
focused state (research/in_progress, checkpoint `9581b6c`, Astra/xhigh), the full
assessment, generator and verifier. Startup validator exited 0. Canonical N=6 then
uniform arbitrary-N remains the priority. Root authorized one fixed verification
after generator exit 0, empty streams and unchanged source; no generation or Lean
runs here. The exact seven bindings below were read independently.

The generator matches the assessment's 24 mixed candidates (weights 2,1,1),
15 initially-safe candidates and domains [0,1), [1/6,5/6]. The 120/120/81 atoms
exclude singleton 1 and include singleton 5/6; strict/closed singleton comparisons
and open endpoint bounds preserve ties. Positive slopes give strict interiors.
First representatives and proper-subset cores dominate in direction core⊆atom.
Sorted triples retain repetitions and sort only interchangeable rows. The loops
have fixed bounds 6975 predicates, 70722 containment tests, 963081 triples;
code/data limits require separate accounting for external diagnostics.

The independent verifier imports no generator. Exact rational cuts/candidates,
singleton norms and endpoint bands check every mask; midpoint floor equals Q=P//720
and checks whole intervals. It verifies first-occurrence core representatives,
321 dominations and every supplied least-common-bit witness with exact lengths
and hashes. **Minimality, least-dominator tie choice and the reported 19665
containments remain generator-reported.** The data totals 48821 bytes. Concrete
Lean band/domination/common-bit/continuum links remain open; retain the 6.4
initially-safe premise. No kernel phase or new runner-count theorem is claimed.

One guarded isolated-Python invocation, asserts enabled/no bytecode, uses 256 MiB
AS, CPU59/60, wall60, 128 KiB regular streams and group timeout kill; internal
verifier caps also apply. All bindings, exact file set and report are checked
before/after. No retry/escalation. The verifier is verbatim; raw output appears
once. A preparation heredoc SyntaxError preceded any write or verifier invocation.

Verifier SHA: `14da9b89be8bb9022eb57dc38f4b338433363ce964b484696651aa11f42328d5`

Launcher SHA: `88cc9ee10aa7e1ae749cd7a7be5cd2b2dbb78a77d9eba18437d53dc2aed023aa`

```json
{
  "scripts/remaining_phase_data.py": [15808, "0a6f3d8a415323fa3f5ebc86a5686a238c399671a30a8edd4e275d7ea3914c31"],
  "research/astra-remaining-phase-certificate-assessment.md": [11728, "16ad698faeac6f3469c391094806f8bc301bc46fdfe294caefbf557051ba0589"],
  "/tmp/astra-remaining-phase-supplied-verifier.py": [5735, "14da9b89be8bb9022eb57dc38f4b338433363ce964b484696651aa11f42328d5"],
  "/usr/bin/python3.12": [8025024, "a92f0f95e883390c7256b2e441484aac06b1002dbe1d924141a77c8d82f96223"],
  "/tmp/astra-remaining-phase-data-fixed-v1/data/metadata.json": [7619, "4fad760e1ce3231e0d66e8ef53b9eb401c6f7d2abf8403ed6f168a79fcdb01a9"],
  "/tmp/astra-remaining-phase-data-fixed-v1/data/six_one_witnesses.bin": [37926, "0f56b854ddef56e49731684bc4ccd9d15366d13bd337e4a2e0c194734e9aa0ce"],
  "/tmp/astra-remaining-phase-data-fixed-v1/data/six_four_witnesses.bin": [3276, "b68a691032caeed3ac4f71ea0967affc1946c19358774b928db53608e3846037"]
}
```

```python
"""One fixed supplied-data verification; no import or invocation of the generator."""
import hashlib, json, resource, signal, sys, time
from fractions import Fraction as F
from pathlib import Path

ROOT = Path('/home/joshua/lonely-runner-formalization')
DATA = Path('/tmp/astra-remaining-phase-data-fixed-v1/data')
EXPECTED_GENERATOR = '0a6f3d8a415323fa3f5ebc86a5686a238c399671a30a8edd4e275d7ea3914c31'

def sha(b):
    return hashlib.sha256(b).hexdigest()

def verify():
    assert sha((ROOT/'scripts/remaining_phase_data.py').read_bytes()) == EXPECTED_GENERATOR
    assert not (DATA/'failure.json').exists()
    d = json.loads((DATA/'metadata.json').read_text())
    assert d['status'] == 'success' and d['source_sha256'] == EXPECTED_GENERATOR
    assert d['spec_version'] == 'remaining-phase-6.1-6.4-v1'
    assert d['assessment_sha256'] == '16ad698faeac6f3469c391094806f8bc301bc46fdfe294caefbf557051ba0589'
    # Independently derive all common grid cuts as exact rational numbers.
    cuts = sorted({F(k,6*a) for a in range(1,6) for k in range(6*a+1)})
    assert len(cuts)==61 and cuts[0]==0 and cuts[-1]==1
    safe_cuts = [x for x in cuts if F(1,6)<=x<=F(5,6)]
    assert len(safe_cuts)==41 and safe_cuts[0]==F(1,6) and safe_cuts[-1]==F(5,6)
    assert d['cut_contract']['required_breakpoint_numerators']==[int(360*x) for x in cuts]
    c61 = [(a,b,False) for a in range(2,6) for b in range(1,6)] + [(1,b,True) for b in range(1,5)]
    c64 = [(2,0,True),(1,1,True),(1,5,True)] + [(a,b,False) for a in [3,5] for b in range(6)]
    for key,cs in [('six_one',c61),('six_four',c64)]:
        assert d['candidates'][key]==[dict(slope=a,b=b,strict=s) for a,b,s in cs]
    totals = dict(bands=0,dominations=0,mixed=0,equal=0)
    # Only supplied true bits are needed for soundness; exact equality below
    # also confirms no other finite-band bits were silently changed.
    for name,grid,count,cs,weight in [('six_one_weight_two',cuts,120,c61,2),('six_one_weight_one',cuts,120,c61,1),('six_four',safe_cuts,81,c64,1)]:
        masks=d['masks'][name]; assert len(masks)==count
        for atom,mask in enumerate(masks):
            assert type(mask) is int and 0<=mask<2**len(cs)
            expected=0
            for k,(a,b,strict) in enumerate(cs):
                totals['bands']+=1
                lo=a*grid[atom//2]+F(weight*b,6)
                if atom%2==0:
                    f=lo-(lo.numerator//lo.denominator); norm=min(f,1-f)
                    good=norm>F(1,6) if strict else norm>=F(1,6)
                else:
                    hi=a*grid[atom//2+1]+F(weight*b,6)
                    mid=(lo+hi)/2; q=mid.numerator//mid.denominator
                    good=F(q)+F(1,6)<=lo and hi<=F(q)+F(5,6)
                if good: expected|=1<<k
            assert mask==expected,(name,atom,'finite band mask mismatch')
        core=d['cores'][name]; cm=core['masks']; reps=core['representative_atoms']; dom=core['dominators']
        assert cm and len(cm)==len(reps) and len(dom)==count
        assert reps==sorted(set(reps))
        for j,r in enumerate(reps):
            assert type(r) is int and 0<=r<count and cm[j]==masks[r]
            assert masks.index(cm[j])==r
        for atom,i in enumerate(dom):
            assert type(i) is int and 0<=i<len(cm)
            assert cm[i]&masks[atom]==cm[i]
            totals['dominations']+=1
    for filename in ['six_one_witnesses.bin','six_four_witnesses.bin']:
        b=(DATA/filename).read_bytes(); f=d['witness_files'][filename]
        assert len(b)==f['bytes'] and sha(b)==f['sha256']
    w=(DATA/'six_one_witnesses.bin').read_bytes(); m2=d['cores']['six_one_weight_two']['masks']; m1=d['cores']['six_one_weight_one']['masks']; offset=0
    for a in m2:
        for j,b in enumerate(m1):
            for c in m1[j:]:
                z=a&b&c; assert z and offset<len(w)
                assert w[offset]==(z&-z).bit_length()-1
                offset+=1
    assert offset==len(w)==d['counts']['mixed_triples'];totals['mixed']=offset
    w=(DATA/'six_four_witnesses.bin').read_bytes(); cm=d['cores']['six_four']['masks'];offset=0
    for i,a in enumerate(cm):
        for j in range(i,len(cm)):
            for k in range(j,len(cm)):
                z=a&cm[j]&cm[k]; assert z and offset<len(w)
                assert w[offset]==(z&-z).bit_length()-1
                offset+=1
    assert offset==len(w)==d['counts']['equal_type_triples'];totals['equal']=offset
    assert totals['bands']==6975==d['counts']['predicate_calls']
    assert totals['mixed']+totals['equal']==d['counts']['triple_intersections']<=963081
    return {'counts':totals,'core_sizes':{k:len(v['masks']) for k,v in d['cores'].items()},'data_sha256':{p.name:sha(p.read_bytes()) for p in DATA.iterdir() if p.is_file()},'scope':'fixed supplied masks, actual core representatives, every supplied domination and all typed/sorted common-bit witnesses; no minimality claim or Lean execution'}

if __name__=='__main__':
    resource.setrlimit(resource.RLIMIT_AS,(256*1024**2,)*2)
    resource.setrlimit(resource.RLIMIT_CPU,(59,60))
    resource.setrlimit(resource.RLIMIT_CORE,(0,0))
    signal.alarm(60)
    before=resource.getrusage(resource.RUSAGE_SELF);start=time.monotonic()
    receipt={'source_sha256':sha(Path(__file__).read_bytes()),'passed':False}
    try:
        receipt.update(verify());receipt['passed']=True
    except BaseException as exc:
        receipt['error']=repr(exc)
    after=resource.getrusage(resource.RUSAGE_SELF)
    receipt.update(wall_seconds=time.monotonic()-start,user_seconds=after.ru_utime-before.ru_utime,system_seconds=after.ru_stime-before.ru_stime,max_rss_kib=after.ru_maxrss)
    print(json.dumps(receipt,sort_keys=True,indent=2))
    sys.exit(0 if receipt['passed'] else 1)
```

```bash
#!/usr/bin/env bash
set -euo pipefail
cd /home/joshua/lonely-runner-formalization
/usr/bin/python3 -I -B - <<'PY_FIXED'
import hashlib,json,os,re,resource,signal,subprocess,tempfile,time
from pathlib import Path
root=Path.cwd(); report=root/'research/astra-remaining-phase-data-review.md'
t=report.read_text(); fence=chr(96)*3
block=lambda label:t.split(fence+label+'\n',1)[1].split(fence,1)[0].encode()
sha=lambda b:hashlib.sha256(b).hexdigest()
g=json.loads(block('json')); v=block('python'); b=block('bash')
marker='\n<!-- RESULT -->\n'; prefix=t.split(marker,1)[0]
verifier=Path('/tmp/astra-remaining-phase-supplied-verifier.py')
data=Path('/tmp/astra-remaining-phase-data-fixed-v1/data')
dh={Path(p).name:h[1] for p,h in g.items() if Path(p).parent==data}
out=Path(tempfile.mkdtemp(prefix='remaining-phase-fixed-review-'))
r={'exit':None,'timeout':False,'error':None,'guards_before':False,'guards_after':False,
   'prefix_sha256':sha(prefix.encode()),'verifier_sha256':sha(v),'launcher_sha256':sha(b)}
limits={'as_bytes':268435456,'cpu_seconds':[59,60],'wall_seconds':60,'stream_bytes':131072}
r['limits']=limits
argv=['/usr/bin/python3.12','-I','-B',str(verifier)];r['argv']=argv

def check():
 for p,(n,h) in g.items():
  q=(root/p).read_bytes();assert len(q)==n and sha(q)==h,p
 assert sorted(p.name for p in data.iterdir())==sorted(dh),'data file set'

def caps():
 resource.setrlimit(resource.RLIMIT_AS,(268435456,)*2)
 resource.setrlimit(resource.RLIMIT_CPU,(59,60))
 resource.setrlimit(resource.RLIMIT_FSIZE,(131072,)*2)
 resource.setrlimit(resource.RLIMIT_CORE,(0,0))

start=time.monotonic(); proc=None
try:
 assert sha(v)==re.search(r'^Verifier SHA: `([0-9a-f]{64})`$',t,re.M)[1]
 assert sha(b)==re.search(r'^Launcher SHA: `([0-9a-f]{64})`$',t,re.M)[1]
 assert v==verifier.read_bytes()
 check();r['guards_before']=True
 with (out/'stdout').open('wb') as so,(out/'stderr').open('wb') as se:
  proc=subprocess.Popen(argv,stdin=subprocess.DEVNULL,stdout=so,stderr=se,
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
r['wall_seconds']=time.monotonic()-start
for name in ['stdout','stderr']:
 p=out/name
 if not p.exists():p.write_bytes(b'')
 q=p.read_bytes();r[name]={'bytes':len(q),'sha256':sha(q),'text':q.decode(errors='replace')}
try:
 result=json.loads(r['stdout']['text'])
 valid=(result.get('passed') is True and result.get('source_sha256')==sha(v)
        and result.get('data_sha256')==dh)
except Exception:valid=False
r['passed']=(r['exit']==0 and r['error'] is None and not r['timeout'] and valid
 and r['guards_before'] and r['guards_after'] and r['stderr']['bytes']==0
 and all(r[n]['bytes']<131072 for n in ['stdout','stderr']))
q=(json.dumps(r,sort_keys=True,indent=2)+'\n').encode();(out/'receipt.json').write_bytes(q)
print('EVIDENCE',out);print('RECEIPT_SHA',sha(q));print(q.decode(),end='')
raise SystemExit(0 if r['passed'] else 1)
PY_FIXED
```

<!-- RESULT -->

Accepted fixed data; one invocation, exit 0, no timeout/stderr. No rerun occurred.
Pre-run report SHA: `364801fedad37352b74132ad1cb1d669330fab28bce2f6023a039aa011052748`.
Outer capture `/tmp/remaining-phase-review-entry-9sxbm5s2` exited 0;
receipt SHA `cdce8537499eb717b6ac7aa628864a0918ad87343c0d3d4f2bf3a1fff054ca39`;
stdout 2184 bytes SHA `ff38d2a245aaccd8fb981e698d8d40b4700853f9c7e2b55eb0cc6fc1dd7901dd`,
stderr empty. Complete controller stdout follows; its nested text is the full raw
verifier output, reproduced once.

```text
EVIDENCE /tmp/remaining-phase-fixed-review-sr2l0qk8
RECEIPT_SHA b2d777a187095833baf33f8ff1d63fed4256c8c4744e62b503a66dea6de16b85
{
  "argv": [
    "/usr/bin/python3.12",
    "-I",
    "-B",
    "/tmp/astra-remaining-phase-supplied-verifier.py"
  ],
  "error": null,
  "exit": 0,
  "guards_after": true,
  "guards_before": true,
  "launcher_sha256": "88cc9ee10aa7e1ae749cd7a7be5cd2b2dbb78a77d9eba18437d53dc2aed023aa",
  "limits": {
    "as_bytes": 268435456,
    "cpu_seconds": [
      59,
      60
    ],
    "stream_bytes": 131072,
    "wall_seconds": 60
  },
  "passed": true,
  "prefix_after_sha256": "e83b7fd0513dfb8335986eaecc6bfbae43e58d51d4af0e462523f1fc09582a8f",
  "prefix_sha256": "e83b7fd0513dfb8335986eaecc6bfbae43e58d51d4af0e462523f1fc09582a8f",
  "stderr": {
    "bytes": 0,
    "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
    "text": ""
  },
  "stdout": {
    "bytes": 935,
    "sha256": "9f9b46bae1be59cee3eb86b803038acdd75c8bb7cf868610f0ded53bc76adefc",
    "text": "{\n  \"core_sizes\": {\n    \"six_four\": 26,\n    \"six_one_weight_one\": 42,\n    \"six_one_weight_two\": 42\n  },\n  \"counts\": {\n    \"bands\": 6975,\n    \"dominations\": 321,\n    \"equal\": 3276,\n    \"mixed\": 37926\n  },\n  \"data_sha256\": {\n    \"metadata.json\": \"4fad760e1ce3231e0d66e8ef53b9eb401c6f7d2abf8403ed6f168a79fcdb01a9\",\n    \"six_four_witnesses.bin\": \"b68a691032caeed3ac4f71ea0967affc1946c19358774b928db53608e3846037\",\n    \"six_one_witnesses.bin\": \"0f56b854ddef56e49731684bc4ccd9d15366d13bd337e4a2e0c194734e9aa0ce\"\n  },\n  \"max_rss_kib\": 16416,\n  \"passed\": true,\n  \"scope\": \"fixed supplied masks, actual core representatives, every supplied domination and all typed/sorted common-bit witnesses; no minimality claim or Lean execution\",\n  \"source_sha256\": \"14da9b89be8bb9022eb57dc38f4b338433363ce964b484696651aa11f42328d5\",\n  \"system_seconds\": 2.6000000000000415e-05,\n  \"user_seconds\": 0.03455299999999999,\n  \"wall_seconds\": 0.03458087801118381\n}\n"
  },
  "timeout": false,
  "verifier_sha256": "14da9b89be8bb9022eb57dc38f4b338433363ce964b484696651aa11f42328d5",
  "wall_seconds": 0.07914579001953825
}
```
