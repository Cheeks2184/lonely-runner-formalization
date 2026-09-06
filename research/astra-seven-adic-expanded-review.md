# Independent fixed-certificate review of F7+

2026-09-06. Requested Astra/xhigh; observed model/effort is not independently
attested. Source checkpoint `312158239315a3488cb522695b58c0a2fece7621`.
The current configuration, workflow, policy and focused state were read;
the workflow validator passed. This report alone is owned. The reviewer did
not author the F7+ experiment and did not rerun discovery. No Lean, state,
Git, build, cache, or other report was changed.

Frozen inputs:

* `research/astra-seven-adic-expanded-falsifier.md`, SHA-256
  `58f35ff3fdc138fd5ebadeeb09d10447734b1fd4cda82a49f263b727cf1d0845`.
* `research/astra-seven-adic-carry-scope-review.md`, SHA-256
  `3be938da0c923c0894f768f18e807e39bfa08d8d6a999bb00a910813a201a452`.

## Mathematical review

**Accept the exact auxiliary F7+ refutation at manuscript level.** The
independent fixed verifier below supplies reproducible arithmetic evidence;
no kernel theorem is claimed. The universal assertion being refuted is

    for every five states (a_i,r_i,t_i) in
      {0,...,6} x {1,2,3} x {0,...,11},
    some J in {1,...,6}, k in {0,...,6} has, for all i,
      (J*a_i + c[t_i,J] + J*k*r_i) mod 7 in {1,...,5}.

The twelve tags have endpoints
`0,1/6,1/5,1/4,1/3,2/5,1/2,3/5,2/3,3/4,4/5,5/6,1`, with left endpoints
included and right endpoints excluded. Their carry at coordinate J is
`floor(J*left)`. Every discontinuity of `floor(J*z/R)`, for J from one to
six, is one of these endpoints, so this records coupled carries of the
same `z/R`; it does not permit independent carry choices. In particular,
the two extra sixth-coordinate breakpoints cannot be represented by the
old ten tags.

For m>=1, set R=7^m and P=7R. Any integer 7-unit has a representative x
or its negative in (0,P) with x mod 7 in {1,2,3}. Negation and reduction
preserve cyclic distance after every multiplier. Write x=Ra+z, where
0<z<R. For A=J(1+kR), direct integer division gives

    floor(A*x/R) = J*a + floor(J*z/R) + J*k*x.

Reducing modulo seven proves the displayed digit formula, including its
factor J on the translation term. Both A and x are units modulo seven,
so w=(A*x mod P) mod R lies strictly between zero and R. With digit D,
the residue is RD+w. If D=0, its distance is less than R; if D=6, its
distance is at most P-(6R+w)=R-w<R. If 1<=D<=5, both directed distances
strictly exceed R. This proves equivalence with the **closed** good-distance
condition for the unit inputs.

For the top input Rv, v a 7-unit, its residue is
R*((J*v) mod 7). The distance is at least R regardless of k. At v=1,
the exact distances by J are R,2R,3R,3R,2R,R. In particular, digit six
can be distance-good at the top: equality must not be excluded there.

The fixed states are

    (0,1,0), (0,3,2), (6,2,5), (6,3,5), (4,3,1).

At R=343 and P=2401, their respective z values are (1,73,142,143,59),
and their unit speeds are (1,73,2200,2201,1431). The top speed is 343.
All six speeds are distinct and positive, and their gcd is one. Each z
is the least member of its prescribed residue class at or above its
scaled tag lower endpoint. The minimum tag width is 1/30, and 343/30>7,
so this choice also proves realizability of every individual state at the
same R; a five-tuple does not require independent carry assumptions.
Only the five fixed states are tested here.

The following first-failing-row array, with zero-based row indices, covers
all 42 candidate choices. Every cited failure has distance strictly below
343, not merely a forbidden symbolic digit.

    J=1: 0 4 1 4 2 3 0
    J=2: 0 1 2 0 2 3 3
    J=3: 0 3 0 1 3 2 2
    J=4: 0 4 2 2 1 0 3
    J=5: 0 2 3 2 0 1 1
    J=6: 0 0 2 1 4 1 3

The verifier independently checks all 210 unit/candidate comparisons,
all 42 top distances, every first failing row and distance, all thirty
bad-k pairs, and the five certificate masks. It reconstructs the complete
author fixed-verification JSON from direct residues and matches its byte
hash. It does not execute either author Python program or construct the
252-row discovery table. The 42 candidate residues are distinct: J is
determined modulo seven, and for fixed J the difference between two
numerators is J(k-k')R, divisible by P only when k=k'.

At the single fixed time t=1/6, the six residues modulo six are
(1,1,4,5,3,1). Their circle distances are (1,1,2,1,3,1)/6, all greater
than 1/7. This is an ordinary witness for the stationary runner in this
configuration. It is neither a claim about every distinguished runner
nor a six-total theorem at the universal margin 1/6.

Thus this admissible tuple refutes the actual universally quantified
five-unit/one-top-speed assertion restricted to A=J(1+kR), J=1,...,6.
There is no inference to an LRC counterexample. The general seven-real-
runner route still needs the missing five-moving integer case at margin
1/6 inside `LowerCountPositiveIntegerHypothesis 8`; a six-moving result
at margin 1/7 would not provide it. The accepted Fin5 result is unchanged.

## Discovery-program audit, without executing discovery

The first author Python fence was read in full and its digest checked.
Its state order `(a,r,t)` and `combinations(range(252),2)` seed order are
lexicographic. Candidate bit index is 7*(J-1)+k. Each affine row has
nonzero slope Jr modulo seven, hence exactly two bad k values for each
J, or twelve bad bits in total. The mask has no bits outside the 42-bit
domain, so `full ^ covered` correctly denotes its missing bits.

For each seed, at most three scans each evaluate all 252 gains. A strict
`gain > best_gain` update in ascending index order selects the least
index on ties. A positive gain cannot select a previously included row.
Coverage is tested before another scan, and an early cover is padded
with the least unused indices to five distinct rows without another
gain calculation. Padding preserves coverage. Zero gain ends the seed;
no cover after the bounded loop returns INCONCLUSIVE.

The syntactic bounds are exactly 252*42=10,584 digit calls and
31,626*3*252=23,909,256 gain calls, with 31,626 distinct unordered seeds.
The child imposes 256 MiB address space, 59/60 CPU seconds and a
60-second alarm; the displayed parent separately uses a 60-second
timeout and checks retained evidence below 1 MiB. Its default is fixed
verification, and there is no automatic discovery fallback. Changing
the explicit mode to search would rerun discovery; this reviewer did not.

The author's 26 seeds, 19,656 gains, three final additions, no padding,
historical timings and predeclaration chronology are **reported run
provenance**, not independently reproduced discovery results. The counts
are consistent with 26*3*252=19,656, and the source bounds are independently
audited. The first Python source digest and all frozen output hashes are
independently checked. This review does not claim to establish chronology
from a hash or to verify that this was the earliest greedy cover. Neither
claim is required to validate the fixed counterexample.

## Predeclared independent fixed replay

Only the following finite constants and operations are executed: the twelve
fixed carry intervals; the five displayed states and their thirty carry
values; the 42 displayed candidates and 210 unit comparisons; 42 top
comparisons; five fixed certificate masks; and the one time 1/6 on six
speeds. No additional state, seed, greedy gain, speed domain or time domain
is explored. The child uses at most 60 seconds wall time and 256 MiB
address space; total retained evidence is limited to 1 MiB. The parent
has an independent 60-second timeout. Both sources below are complete.

```python
from fractions import Fraction
from hashlib import sha256
from pathlib import Path
import json, re, resource, signal

resource.setrlimit(resource.RLIMIT_AS, (256*1024*1024, 256*1024*1024))
resource.setrlimit(resource.RLIMIT_CPU, (59,60))
signal.alarm(60)
guards = {
 'research/astra-seven-adic-expanded-falsifier.md':
  '58f35ff3fdc138fd5ebadeeb09d10447734b1fd4cda82a49f263b727cf1d0845',
 'research/astra-seven-adic-carry-scope-audit.md':
  '4360a75613ba59fad5de8edcd23f37397876d0235816b9340b8707f93a63a126',
 'research/astra-seven-adic-carry-scope-review.md':
  '3be938da0c923c0894f768f18e807e39bfa08d8d6a999bb00a910813a201a452',
 'LonelyRunner/FiveAdicCarry.lean':
  'f91d747198374da76ff9e62435db20a8917856d5b9dc52229ce576353cc11d81',
 'research/astra-five-adic-carry-symbolic-plan.md':
  'd1fef1fafc6c7ae6adaf0ee885b4d44931e26bda667ff040f6c237f082555f80',
 'research/astra-five-adic-hard-adapter-plan.md':
  'f2d5e74769d86dc729d0f63f098654a9a538bf690e0c47d952272259bba37eef',
 'research/astra-five-adic-hard-adapter-plan-review.md':
  '579b1ea58b05788dc388cba4bcabb26aa152bf23fdebc919c497815973e2303f',
}
def check_guards():
 for path, expected in guards.items():
  assert sha256(Path(path).read_bytes()).hexdigest() == expected, path
check_guards()
author = Path('research/astra-seven-adic-expanded-falsifier.md').read_text()
programs = re.findall(r'^```python\n(.*?)^```[ \t]*$',author,re.M|re.S)
assert [sha256(s.encode()).hexdigest() for s in programs] == [
 'ce122157dd4e408b325eb4c2156d28b5a65099a156480d55f017e03b5a8ba9ce',
 'ad3edcf4d44bd4438aa87eb32e6859e17b78522f3ab25300e705ef2e8eb100f6']
outputs = re.findall(r'^```json\n(.*?)^```[ \t]*$',author,re.M|re.S)
hashes = ['cd2bdd971432a16dfd51da619fb692108d5281d0addd20ee3521734c091cbd49',
 '94578a03407c1d8e966c533cc7344de15a6b247d4ff619adfc1fc75f198f068b',
 '1cf1a4646dcd1448755ecb0f0594c022ea88c404dd4027f4c2fe82c311738efe']
assert [sha256(s.encode()).hexdigest() for s in outputs] == hashes
reported_discovery = json.loads(outputs[0])
cuts = tuple(map(Fraction, ['0','1/6','1/5','1/4','1/3','2/5',
 '1/2','3/5','2/3','3/4','4/5','5/6','1']))
assert min(u-l for l,u in zip(cuts,cuts[1:])) == Fraction(1,30)
R, P = 343, 2401
fixed = ((0,1,0),(0,3,2),(6,2,5),(6,3,5),(4,3,1))
xs, zs = (1,73,2200,2201,1431), (1,73,142,143,59)
indices = [a*36+(r-1)*12+t for a,r,t in fixed]
assert indices == [0,26,233,245,169]
assert R == 7**3 and P == 7*R and Fraction(R,30) > 7
assert len(set(xs+(R,))) == 6 and xs[0] == 1
carry = []
for (a,r,t),x,z in zip(fixed,xs,zs):
 assert x == R*a+z and 0<x<P and 0<z<R and x%7 == r
 assert cuts[t]*R <= z < cuts[t+1]*R
 ceiling = (cuts[t]*R).__ceil__()
 assert z == ceiling+(r-ceiling)%7
 row = tuple(J*z//R for J in range(1,7))
 assert row == tuple((J*cuts[t]).__floor__() for J in range(1,7))
 carry.append(row)
bad = [[[] for _ in range(6)] for _ in range(5)]
cover, first_distances, top_distances = [], [], []
certificate_masks, residues_seen = [0]*5, set()
unit_checks = top_checks = 0
for J in range(1,7):
 rows, distances, tops = [], [], []
 for k in range(7):
  A = J*(1+k*R)
  assert A%7 == J and 0<A%P<P
  residues_seen.add(A%P)
  top = A*R%P
  top_distance = min(top,P-top)
  assert top_distance == R*min(J,7-J) and top_distance >= R
  tops.append(top_distance)
  top_checks += 1
  failures = []
  for i,((a,r,t),x) in enumerate(zip(fixed,xs)):
   y = A*x%P
   D, w = divmod(y,R)
   assert 0<w<R
   assert D == (J*a+carry[i][J-1]+J*k*r)%7
   distance = min(y,P-y)
   assert (distance>=R) == (D in (1,2,3,4,5))
   assert distance != R
   unit_checks += 1
   if distance<R:
    failures.append((i,distance))
    bad[i][J-1].append(k)
    certificate_masks[i] |= 1 << (7*(J-1)+k)
  assert failures
  row,distance = failures[0]
  rows.append(row)
  distances.append(distance)
 cover.append(rows)
 first_distances.append(distances)
 top_distances.append(tops)
assert (unit_checks,top_checks,len(residues_seen)) == (210,42,42)
assert all(len(pair)==2 for row in bad for pair in row)
assert all(mask.bit_count()==12 for mask in certificate_masks)
combined = 0
for mask in certificate_masks:
 combined |= mask
assert combined == (1<<42)-1
assert certificate_masks == reported_discovery['selected_bad_masks']
assert [list(s) for s in fixed] == reported_discovery['states']
recomputed = {'status':'F7_PLUS_FALSE_FIXED_CERTIFICATE','mode':'verify',
 'states':fixed,'indices':indices,
 'realization':{'m':3,'R':R,'P':P,'units':xs,'z':zs,'top_speed':R},
 'bad_k_by_row_then_J':bad,'first_bad_row_by_J_then_k':cover,
 'first_bad_distance_by_J_then_k':first_distances,
 'top_distance_by_J_then_k':top_distances,'unit_candidate_checks':unit_checks,
 'top_candidate_checks':top_checks,'state_count':252,'candidate_count':42,
 'seed_pairs':0,'gain_evaluations':0,'discovery_digit_evaluations':0,
 'source_guards':6}
fixed_raw = json.dumps(recomputed,sort_keys=True)+'\n'
assert fixed_raw == outputs[1]
speeds = xs+(R,)
ordinary_residues = [d%6 for d in speeds]
ordinary_distances = [min(y,6-y) for y in ordinary_residues]
assert ordinary_residues == [1,1,4,5,3,1]
assert ordinary_distances == [1,1,2,1,3,1]
assert all(7*d>6 for d in ordinary_distances)
control = {'status':'ORDINARY_LONELY_TIME_CONTROL_PASSED','speeds':speeds,
 'time':'1/6','residues_mod_6':ordinary_residues,
 'distance_numerators_over_6':ordinary_distances,
 'stationary_runner_only':True,'source_guards':2}
control_raw = json.dumps(control,sort_keys=True)+'\n'
assert control_raw == outputs[2]
assert 252*42 == 10584 and 252*251//2 == 31626
assert 31626*3*252 == 23909256
check_guards()
out = json.dumps({'status':'F7_PLUS_INDEPENDENT_FIXED_REVIEW_PASSED',
 'source_guards':len(guards),'unit_candidate_checks':unit_checks,
 'top_candidate_checks':top_checks,'distinct_candidates':len(residues_seen),
 'certificate_masks_checked':len(certificate_masks),'bad_k_pairs_checked':30,
 'first_bad_rows':cover,'maximum_first_failure_distance':max(map(max,first_distances)),
 'threshold':R,'fixed_stdout_sha256':sha256(fixed_raw.encode()).hexdigest(),
 'ordinary_control_stdout_sha256':sha256(control_raw.encode()).hexdigest(),
 'discovery_executed':False,'author_programs_executed':False,
 'seed_pairs':0,'gain_evaluations':0},sort_keys=True)+'\n'
assert len(out.encode()) < 32768
print(out,end='')
```

The following sole Bash fence runs this fixed-only program from the repository
root, using its literal Python fence as the complete child stdin. It creates
no file, accepts no discovery mode, propagates nonzero child status, and
prints raw child stdout followed by a measured resource receipt.

```bash
python3 -B - <<'PY'
from hashlib import sha256
from pathlib import Path
import json,re,resource,subprocess,sys,time
p=Path('research/astra-seven-adic-expanded-review.md')
blocks=re.findall(r'^```python\n(.*?)^```[ \t]*$',p.read_text(),re.M|re.S)
assert len(blocks)==1
program=blocks[0]
expected='2a2ee6a431b9842bc7ee269ba2f2539186a78471aad3ec4df0c7aeac2939ebf8'
assert sha256(program.encode()).hexdigest()==expected
retained=p.stat().st_size+sum(Path(q).stat().st_size for q in [
 'research/astra-seven-adic-expanded-falsifier.md',
 'research/astra-seven-adic-carry-scope-audit.md',
 'research/astra-seven-adic-carry-scope-review.md'])
assert retained+65536<1024*1024
t0=time.monotonic()
try:
 result=subprocess.run([sys.executable,'-B','-'],input=program,text=True,
  capture_output=True,timeout=60)
except subprocess.TimeoutExpired:
 print(json.dumps({'status':'INCONCLUSIVE','reason':'PARENT_TIMEOUT',
  'program_sha256':expected},sort_keys=True))
 raise SystemExit(124)
elapsed=time.monotonic()-t0
usage=resource.getrusage(resource.RUSAGE_CHILDREN)
assert retained+len(result.stdout.encode())+len(result.stderr.encode())+4096<1024*1024
print(result.stdout,end='')
print(json.dumps({'exit_code':result.returncode,'elapsed_seconds':elapsed,
 'child_peak_rss_KiB':usage.ru_maxrss,'child_user_seconds':usage.ru_utime,
 'child_system_seconds':usage.ru_stime,'program_sha256':expected,
 'stdout_bytes':len(result.stdout.encode()),
 'stdout_sha256':sha256(result.stdout.encode()).hexdigest(),
 'stderr_sha256':sha256(result.stderr.encode()).hexdigest(),
 'stderr':result.stderr},sort_keys=True))
if result.returncode:
 raise SystemExit(result.returncode if result.returncode>0 else 1)
assert result.stderr==''
PY
```

## Independent execution receipt

The declared Bash command was executed once (terminal chunk `6c7c55`). Bash
and its bounded Python child both exited 0, with empty stderr. No discovery
or author program was executed. The complete child stdin is the sole Python
fence above, including its final newline; its SHA-256 is
`2a2ee6a431b9842bc7ee269ba2f2539186a78471aad3ec4df0c7aeac2939ebf8`.
The Bash fence, also including its final newline, has SHA-256
`18b6163869e133e97c7eed864ded0f2e748892fa6d70966686503fc9e1863250`.

Raw child stdout is exactly 730 bytes including the final newline, SHA-256
`ded002372cb7f3fcde1deb01cfdba20f6ffdb87d92310ed330d9a6c512450376`:

```json
{"author_programs_executed": false, "bad_k_pairs_checked": 30, "certificate_masks_checked": 5, "discovery_executed": false, "distinct_candidates": 42, "first_bad_rows": [[0, 4, 1, 4, 2, 3, 0], [0, 1, 2, 0, 2, 3, 3], [0, 3, 0, 1, 3, 2, 2], [0, 4, 2, 2, 1, 0, 3], [0, 2, 3, 2, 0, 1, 1], [0, 0, 2, 1, 4, 1, 3]], "fixed_stdout_sha256": "94578a03407c1d8e966c533cc7344de15a6b247d4ff619adfc1fc75f198f068b", "gain_evaluations": 0, "maximum_first_failure_distance": 342, "ordinary_control_stdout_sha256": "1cf1a4646dcd1448755ecb0f0594c022ea88c404dd4027f4c2fe82c311738efe", "seed_pairs": 0, "source_guards": 7, "status": "F7_PLUS_INDEPENDENT_FIXED_REVIEW_PASSED", "threshold": 343, "top_candidate_checks": 42, "unit_candidate_checks": 210}
```

The measured resource receipt was the following second line of Bash stdout:

```json
{"child_peak_rss_KiB": 16424, "child_system_seconds": 0.001997, "child_user_seconds": 0.022971, "elapsed_seconds": 0.025278979999711737, "exit_code": 0, "program_sha256": "2a2ee6a431b9842bc7ee269ba2f2539186a78471aad3ec4df0c7aeac2939ebf8", "stderr": "", "stderr_sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "stdout_bytes": 730, "stdout_sha256": "ded002372cb7f3fcde1deb01cfdba20f6ffdb87d92310ed330d9a6c512450376"}
```

Concatenating those two JSON lines, each with its final newline, reconstructs
the exact Bash stdout, SHA-256
`a8c6ffbe160df6f8d05045bc4f4b6f46f953b024c5825015000cc546d8ac6863`.
Empty Bash and child stderr each have SHA-256
`e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.
The replay stayed within all declared caps; all seven guards passed before
and after the fixed arithmetic. No process or extra generated file remains.
These are observations of this independent replay, separate from the
author's discovery timings and counters. The final disposition is acceptance
of the exact auxiliary refutation only; unrestricted LRC remains unresolved.
