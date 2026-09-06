# Bounded falsifier for the expanded seven-adic carry family

2026-09-06. Task `/root/seven_adic_expanded_falsifier`, requested GPT-6
Astra/xhigh; observed runtime model and effort are not independently attested.
Assigned source checkpoint `312158239315a3488cb522695b58c0a2fece7621`.
Configuration, workflow, policy, and focused active state were read, and
`python3 scripts/validate_workflow.py` passed. Research is authorized; the
unrestricted canonical LRC remains unresolved. Only this report is owned.
No Lean changes, build, dependency restoration, state write, Git operation,
publication, solver, external source, or additional agent is part of this task.

The frozen prerequisites were fully read and their SHA-256 values checked:

- `research/astra-seven-adic-carry-scope-audit.md`:
  `4360a75613ba59fad5de8edcd23f37397876d0235816b9340b8707f93a63a126`.
- `research/astra-seven-adic-carry-scope-review.md`:
  `3be938da0c923c0894f768f18e807e39bfa08d8d6a999bb00a910813a201a452`.

## Predeclaration, saved before any expanded search

The tested auxiliary assertion F7+ has five arbitrary states `(a,r,tag)`
in `{0,...,6} x {1,2,3} x {0,...,11}`. The twelve tags are the half-open
intervals with ordered endpoints

    0, 1/6, 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 5/6, 1.

At the tag's lower endpoint l define `c_J=floor(J*l)` for J=1,...,6.
These are coupled carries of one real coordinate, not independent values.
For candidate `(J,k)` in `{1,...,6} x {0,...,6}`, the good predicate is

    (J*a+c_J+J*k*r) mod 7 in {1,2,3,4,5}.

F7+ asserts a shared good candidate for every five-state tuple. There are
252 states and 42 candidates. States and seed pairs are lexicographic;
candidate bit index is `7*(J-1)+k`. Exactly 252*42=10,584 digit calls
construct all row masks, each with twelve bad bits. The search considers
at most 31,626 lexicographic unordered distinct seed pairs. Each seed gets
at most three greedy additions, scanning all 252 states per addition,
maximizing uncovered-bit gain and choosing the minimum index on ties.
Thus there are at most 31,626*3*252=23,909,256 gain calls. Stop a seed
on zero gain and stop the entire search on the first cover. An early cover
is padded to exactly five distinct rows with the least unused indices,
without any further gain call. Positive-gain additions cannot repeat rows.

There is no full five-tuple or speed enumeration, additional J value,
solver, dependency, or budget increase. Every search/verification child
sets a 60-second wall alarm, soft/hard CPU limits 59/60 seconds, and an
address-space limit of 268,435,456 bytes. Each parent imposes an independent
60-second timeout. Total retained evidence, including this readable source,
prerequisite manuscripts, stdout, and resource receipts, must be <=1 MiB.
A failure, timeout, resource stop, or completed search without a cover is
**INCONCLUSIVE**, never a universal proof. No discovery result is promoted
until a separate child verifies just the fixed returned tuple by actual
integer residues and distances for all 42 candidates.

The fixed verifier uses R=343, P=2401, and the least z in the prescribed
residue class at or above its tag's scaled lower endpoint. Every tag has
width at least 1/30; 343/30>7 proves this construction works for every
state. It checks only the chosen five states, their distinct natural unit
speeds, and top speed R (v=1). It checks all 210 unit/candidate pairs,
the 42 always-good top-speed constraints, and at least one strict distance
failure per candidate. Any ordinary-time scope control will use separate,
explicitly fixed arithmetic rather than a new speed-domain search.

## Complete standalone child program

`search` performs precisely the bounded experiment above. `verify` takes
one JSON list of five states and never constructs all state masks or runs
the seed/greedy loops. Both modes guard the six frozen prerequisite files
before and after successful arithmetic. The fixed check recomputes failures
from natural-speed residues, independently of discovery masks and choices.

```python
from fractions import Fraction
from hashlib import sha256
from itertools import combinations
from pathlib import Path
import json, resource, signal, sys

resource.setrlimit(resource.RLIMIT_AS, (256*1024*1024, 256*1024*1024))
resource.setrlimit(resource.RLIMIT_CPU, (59, 60))
signal.alarm(60)
GUARDS = {
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
def guard_sources():
    for path, expected in GUARDS.items():
        assert sha256(Path(path).read_bytes()).hexdigest() == expected, path

def emit(value):
    guard_sources()
    out = json.dumps(value, sort_keys=True)+'\n'
    assert len(out.encode()) < 32768
    print(out, end='')

guard_sources()
CUTS = tuple(sorted({Fraction(n,d) for d in range(1,7)
                     for n in range(d+1)}))
CARRIES = tuple(tuple((J*l).__floor__() for J in range(1,7))
                for l in CUTS[:-1])
assert CUTS == tuple(map(Fraction, ['0','1/6','1/5','1/4','1/3','2/5',
    '1/2','3/5','2/3','3/4','4/5','5/6','1']))
assert CARRIES == ((0,0,0,0,0,0),(0,0,0,0,0,1),(0,0,0,0,1,1),
    (0,0,0,1,1,1),(0,0,1,1,1,2),(0,0,1,1,2,2),
    (0,1,1,2,2,3),(0,1,1,2,3,3),(0,1,2,2,3,4),
    (0,1,2,3,3,4),(0,1,2,3,4,4),(0,1,2,3,4,5))
assert min(u-l for l,u in zip(CUTS,CUTS[1:])) == Fraction(1,30)
CANDIDATES = tuple((J,k) for J in range(1,7) for k in range(7))
assert len(CANDIDATES) == 42

def discover():
    states = tuple((a,r,t) for a in range(7) for r in range(1,4)
                   for t in range(12))
    assert len(states) == 252
    masks, digits = [], 0
    for a,r,t in states:
        mask = 0
        for b,(J,k) in enumerate(CANDIDATES):
            D = (J*a+CARRIES[t][J-1]+J*k*r)%7
            digits += 1
            if D in (0,6):
                mask |= 1 << b
        assert mask.bit_count() == 12
        masks.append(mask)
    assert digits == 10584
    full, seeds, gains = (1<<42)-1, 0, 0
    selected, pad_count, steps_for_cover = None, 0, None
    for first,second in combinations(range(252),2):
        seeds += 1
        trial = [first,second]
        covered = masks[first] | masks[second]
        steps = 0
        # The coverage check precedes any next gain scan, including padding.
        while covered != full and steps < 3:
            missing = full ^ covered
            best, best_gain = -1, -1
            for index,mask in enumerate(masks):
                gain = (mask & missing).bit_count()
                gains += 1
                if gain > best_gain:
                    best, best_gain = index, gain
            steps += 1
            if best_gain == 0:
                break
            assert best not in trial
            trial.append(best)
            covered |= masks[best]
        if covered == full:
            steps_for_cover = steps
            for index in range(252):
                if len(trial) == 5:
                    break
                if index not in trial:
                    trial.append(index)
                    pad_count += 1
            selected = trial
            break
    assert seeds <= 31626 and gains <= 23909256
    summary = {'mode':'search', 'state_count':252, 'candidate_count':42,
        'digit_evaluations':digits, 'seed_pairs':seeds,
        'gain_evaluations':gains, 'source_guards':len(GUARDS)}
    if selected is None:
        return dict(summary, status='INCONCLUSIVE', reason='NO_GREEDY_COVER')
    assert len(selected) == len(set(selected)) == 5
    combined = 0
    for i in selected:
        combined |= masks[i]
    assert combined == full
    return dict(summary, status='F7_PLUS_COVER_CANDIDATE', indices=selected,
        states=[states[i] for i in selected], padding_rows=pad_count,
        greedy_steps_for_cover=steps_for_cover,
        selected_bad_masks=[masks[i] for i in selected])

def verify(fixed):
    assert len(fixed) == len(set(fixed)) == 5
    assert all(len(s)==3 and all(type(n) is int for n in s) for s in fixed)
    assert all(0<=a<7 and 1<=r<=3 and 0<=t<12 for a,r,t in fixed)
    R, P, xs, zs = 343, 2401, [], []
    assert R == 7**3 and P == 7*R and Fraction(R,30) > 7
    for a,r,t in fixed:
        lower = CUTS[t]*R
        ceiling = lower.__ceil__()
        z = ceiling+(r-ceiling)%7
        x = R*a+z
        assert CUTS[t]*R <= z < CUTS[t+1]*R
        assert 0<z<R and 0<x<P and x%7 == r
        assert divmod(x,R) == (a,z)
        assert tuple(J*z//R for J in range(1,7)) == CARRIES[t]
        xs.append(x)
        zs.append(z)
    assert len(set(xs+[R])) == 6
    bad = [[[] for J in range(6)] for x in xs]
    cover, failure_distances, top_distances = [], [], []
    unit_checks = 0
    for J in range(1,7):
        covering_rows, strict_distances, top_row = [], [], []
        for k in range(7):
            A = J*(1+k*R)
            assert A%7 == J and 0<A%P<P
            top = (A*R)%P
            top_distance = min(top,P-top)
            assert top_distance == R*min(J,7-J) and top_distance >= R
            top_row.append(top_distance)
            failures = []
            for i,((a,r,t),x) in enumerate(zip(fixed,xs)):
                y = (A*x)%P
                D,w = divmod(y,R)
                expected = (J*a+CARRIES[t][J-1]+J*k*r)%7
                assert 0<w<R and D == expected
                distance = min(y,P-y)
                assert (distance>=R) == (D in (1,2,3,4,5))
                unit_checks += 1
                if distance<R:
                    bad[i][J-1].append(k)
                    failures.append((i,distance))
            assert failures, (J,k)
            row,distance = failures[0]
            covering_rows.append(row)
            strict_distances.append(distance)
        cover.append(covering_rows)
        failure_distances.append(strict_distances)
        top_distances.append(top_row)
    assert unit_checks == 210
    assert all(len(pair)==2 for row in bad for pair in row)
    return {'status':'F7_PLUS_FALSE_FIXED_CERTIFICATE', 'mode':'verify',
        'states':fixed, 'indices':[a*36+(r-1)*12+t for a,r,t in fixed],
        'realization':{'m':3,'R':R,'P':P,'units':xs,'z':zs,'top_speed':R},
        'bad_k_by_row_then_J':bad, 'first_bad_row_by_J_then_k':cover,
        'first_bad_distance_by_J_then_k':failure_distances,
        'top_distance_by_J_then_k':top_distances,
        'unit_candidate_checks':unit_checks, 'top_candidate_checks':42,
        'state_count':252, 'candidate_count':42, 'seed_pairs':0,
        'gain_evaluations':0, 'discovery_digit_evaluations':0,
        'source_guards':len(GUARDS)}

try:
    mode = sys.argv[1] if len(sys.argv)>1 else 'verify'
    if mode == 'search':
        assert len(sys.argv) == 2
        emit(discover())
    else:
        assert mode == 'verify' and len(sys.argv) == 3
        emit(verify(tuple(tuple(s) for s in json.loads(sys.argv[2]))))
except Exception as error:
    print(json.dumps({'status':'INCONCLUSIVE', 'reason':type(error).__name__,
                      'detail':str(error)}, sort_keys=True))
    raise SystemExit(1)
```

## Execution evidence

**F7+ is false at manuscript and exact-arithmetic scope.** A cover was found
after 26 seed pairs and 19,656 gain calls, using all 10,584 predeclared mask
digit calls. Its last seed required three additions, so padding was not
needed for this result. The separate fixed verifier passed; it made no
discovery mask, seed, or gain calls. All frozen source guards passed before
and after each successful child. No seven-adic Lean theorem is claimed.

The first discovered states and their indices are

    states  = ((0,1,0), (0,3,2), (6,2,5), (6,3,5), (4,3,1))
    indices = (0,26,233,245,169).

The following table gives each row's complete pair of bad k values. Each
column has union `{0,1,2,3,4,5,6}`, so every shared candidate fails.

| row | state (a,r,tag) | J=1 | J=2 | J=3 | J=4 | J=5 | J=6 |
|---|---|---|---|---|---|---|---|
| 0 | (0,1,0) | 0,6 | 0,3 | 0,2 | 0,5 | 0,4 | 0,1 |
| 1 | (0,3,2) | 0,2 | 0,1 | 0,3 | 0,4 | 5,6 | 3,5 |
| 2 | (6,2,5) | 0,4 | 2,4 | 5,6 | 2,3 | 1,3 | 2,5 |
| 3 | (6,3,5) | 0,5 | 5,6 | 1,4 | 2,6 | 2,3 | 1,6 |
| 4 | (4,3,1) | 1,3 | 1,2 | 1,4 | 1,5 | 0,1 | 4,6 |

At m=3, R=343, P=2401, the fixed construction gives

    z     = (1,73,142,143,59)
    units = (1,73,2200,2201,1431)
    v     = 1, top speed Rv = 343.

The five units and top speed are six distinct positive naturals; their
gcd is 1 because the first is 1. Their prescribed residues are respectively
1,3,2,3,3 modulo 7. The tag intervals contain `z/R`, and division by R
recovers the exact top digits. No smaller-realization or minimality claim
is made, and no other R was searched.

For a normalized unit x, put `A=J*(1+kR)`, `y=A*x mod P`, and `w=y mod R`.
Since A and x are 7-units, `0<w<R`. Thus

    y = R*D+w,
    D = (J*a+c_J+J*k*r) mod 7.

Digits 0 and 6 each imply `min(y,P-y)<R`; digits 1 through 5 each imply
`min(y,P-y)>R`. This proves the exact equivalence with the closed bound
for unit speeds, including the potentially misleading digit-6 boundary.
For the top speed R instead, the distance is
`R*min(J,7-J)>=R`, with equality when J=1 or 6. The top-speed boundary
must not use the units' digit predicate. The fixed verifier checked all
210 unit/candidate instances, all 42 top constraints, and every recorded
strict failure from actual integer residues. Dividing by P proves failure
of the closed circle threshold 1/7 at all 42 times A/P; reducing A modulo
P does not change these integer-speed distances.

### Ordinary-time scope control

For these same six speeds, time t=1/6 gives residues modulo 6
`(1,1,4,5,3,1)` and circle distances `(1,1,2,1,3,1)/6`, all strictly
greater than 1/7. This is an ordinary lonely time for the stationary
runner of the corresponding seven-runner configuration. It makes no claim
about every choice of distinguished runner. It confirms that the discovered
obstruction is only to this auxiliary multiplier family. Neither this
certificate nor the search supplies a disproof of LRC.

Here is the separate fixed arithmetic control program, executed in its own
bounded child. It checks precisely that single rational time, with no
candidate-time sweep or expanded search.

```python
from hashlib import sha256
from pathlib import Path
import json, resource, signal
resource.setrlimit(resource.RLIMIT_AS,(256*1024*1024,256*1024*1024))
resource.setrlimit(resource.RLIMIT_CPU,(59,60))
signal.alarm(60)
guards={
 'research/astra-seven-adic-carry-scope-audit.md':'4360a75613ba59fad5de8edcd23f37397876d0235816b9340b8707f93a63a126',
 'research/astra-seven-adic-carry-scope-review.md':'3be938da0c923c0894f768f18e807e39bfa08d8d6a999bb00a910813a201a452'}
for path,expected in guards.items():
 assert sha256(Path(path).read_bytes()).hexdigest()==expected,path
speeds=[1,73,2200,2201,1431,343]
residues=[d%6 for d in speeds]
assert residues==[1,1,4,5,3,1]
distances=[min(y,6-y) for y in residues]
assert distances==[1,1,2,1,3,1]
assert all(7*d>6 for d in distances)
for path,expected in guards.items():
 assert sha256(Path(path).read_bytes()).hexdigest()==expected,path
print(json.dumps({'status':'ORDINARY_LONELY_TIME_CONTROL_PASSED','speeds':speeds,'time':'1/6','residues_mod_6':residues,'distance_numerators_over_6':distances,'stationary_runner_only':True,'source_guards':len(guards)},sort_keys=True))
```

### Exact source, stdout, and resource provenance

The predeclaration existed before discovery, at 11,858 bytes with SHA-256
`19f1f9b7acbc77507d652ad0aae6ac888e433fd35af461c0ac8f7194f39254b4`
(terminal chunk `59de17`). That digest identifies the historical report
snapshot with its initial pending-results paragraph, not this completed
report. The search parent explicitly guarded that predeclaration snapshot.
The first Python fence has not changed since that save: its 7,632 bytes,
including the final newline, have SHA-256
`ce122157dd4e408b325eb4c2156d28b5a65099a156480d55f017e03b5a8ba9ce`.
The separate ordinary-time program has SHA-256
`ad3edcf4d44bd4438aa87eb32e6859e17b78522f3ab25300e705ef2e8eb100f6`.
Both executable sources are standalone Python standard-library code.

All three original runs exited 0 with empty stderr. Each child had the
predeclared address-space, CPU, and alarm limits; each independent parent
used `subprocess.run(timeout=60)`. Parent wall times and Linux child usage
were actually observed as follows; they are not predictions for Lean.

| run | terminal chunk | parent wall seconds | child user / system seconds | child peak RSS KiB |
|---|---|---|---|---|
| discovery | c97fe2 | 0.026684106996981427 | 0.023511 / 0.002938 | 16456 |
| fixed tuple verification | f5f08f | 0.02513515201280825 | 0.022823 / 0.002074 | 16364 |
| fixed t=1/6 control | 5d94ca | 0.01889554999070242 | 0.015307999999999999 / 0.00328 | 15320 |

The raw discovery stdout is 440 bytes including its final newline, SHA-256
`cd2bdd971432a16dfd51da619fb692108d5281d0addd20ee3521734c091cbd49`:

```json
{"candidate_count": 42, "digit_evaluations": 10584, "gain_evaluations": 19656, "greedy_steps_for_cover": 3, "indices": [0, 26, 233, 245, 169], "mode": "search", "padding_rows": 0, "seed_pairs": 26, "selected_bad_masks": [107711907009, 1400195137925, 1239661677073, 2271106871329, 2749655974666], "source_guards": 6, "state_count": 252, "states": [[0, 1, 0], [0, 3, 2], [6, 2, 5], [6, 3, 5], [4, 3, 1]], "status": "F7_PLUS_COVER_CANDIDATE"}
```

The raw fixed-verification stdout is 1,436 bytes including its final
newline, SHA-256
`94578a03407c1d8e966c533cc7344de15a6b247d4ff619adfc1fc75f198f068b`:

```json
{"bad_k_by_row_then_J": [[[0, 6], [0, 3], [0, 2], [0, 5], [0, 4], [0, 1]], [[0, 2], [0, 1], [0, 3], [0, 4], [5, 6], [3, 5]], [[0, 4], [2, 4], [5, 6], [2, 3], [1, 3], [2, 5]], [[0, 5], [5, 6], [1, 4], [2, 6], [2, 3], [1, 6]], [[1, 3], [1, 2], [1, 4], [1, 5], [0, 1], [4, 6]]], "candidate_count": 42, "discovery_digit_evaluations": 0, "first_bad_distance_by_J_then_k": [[1, 59, 270, 284, 142, 143, 342], [2, 197, 59, 341, 284, 286, 57], [3, 86, 340, 124, 257, 83, 260], [4, 236, 118, 225, 51, 339, 114], [5, 24, 314, 319, 338, 321, 22], [6, 337, 177, 248, 332, 95, 171]], "first_bad_row_by_J_then_k": [[0, 4, 1, 4, 2, 3, 0], [0, 1, 2, 0, 2, 3, 3], [0, 3, 0, 1, 3, 2, 2], [0, 4, 2, 2, 1, 0, 3], [0, 2, 3, 2, 0, 1, 1], [0, 0, 2, 1, 4, 1, 3]], "gain_evaluations": 0, "indices": [0, 26, 233, 245, 169], "mode": "verify", "realization": {"P": 2401, "R": 343, "m": 3, "top_speed": 343, "units": [1, 73, 2200, 2201, 1431], "z": [1, 73, 142, 143, 59]}, "seed_pairs": 0, "source_guards": 6, "state_count": 252, "states": [[0, 1, 0], [0, 3, 2], [6, 2, 5], [6, 3, 5], [4, 3, 1]], "status": "F7_PLUS_FALSE_FIXED_CERTIFICATE", "top_candidate_checks": 42, "top_distance_by_J_then_k": [[343, 343, 343, 343, 343, 343, 343], [686, 686, 686, 686, 686, 686, 686], [1029, 1029, 1029, 1029, 1029, 1029, 1029], [1029, 1029, 1029, 1029, 1029, 1029, 1029], [686, 686, 686, 686, 686, 686, 686], [343, 343, 343, 343, 343, 343, 343]], "unit_candidate_checks": 210}
```

The raw fixed-control stdout is 247 bytes including its final newline,
SHA-256 `1cf1a4646dcd1448755ecb0f0594c022ea88c404dd4027f4c2fe82c311738efe`:

```json
{"distance_numerators_over_6": [1, 1, 2, 1, 3, 1], "residues_mod_6": [1, 1, 4, 5, 3, 1], "source_guards": 2, "speeds": [1, 73, 2200, 2201, 1431, 343], "stationary_runner_only": true, "status": "ORDINARY_LONELY_TIME_CONTROL_PASSED", "time": "1/6"}
```

Each empty child stderr has SHA-256
`e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.
The stdout hashes exclude the outer resource receipt. No raw output is
silently truncated. Actual command bodies used the extracted first program
with child arguments `search`, or `verify` followed by the exact frozen
JSON state list below. The scope-control command supplied the second
program, verbatim, to a separate child. The following readable command
consolidates those identical child invocations and resource limits.

### Bash replay, fixed verification by default

Run this from the repository root. The displayed command executes only the
fixed tuple verifier. To replay the single ordinary-time check, replace the
first line's `verify` by `control`; to deliberately rerun the exact bounded
discovery, replace it by `search`. There is no automatic search fallback.
Each invocation creates just one bounded child, retains no extra file, and
prints its stdout plus measured resource receipt. Any timeout or nonzero
child exit is explicitly inconclusive. Fixed output hashes are checked.

```bash
python3 -B - verify <<'PY'
from pathlib import Path
from hashlib import sha256
import json,re,resource,subprocess,sys,time
p=Path('research/astra-seven-adic-expanded-falsifier.md')
blocks=re.findall(r'^```python\n(.*?)^```[ \t]*$',p.read_text(),re.M|re.S)
assert len(blocks)==2
digests=['ce122157dd4e408b325eb4c2156d28b5a65099a156480d55f017e03b5a8ba9ce',
         'ad3edcf4d44bd4438aa87eb32e6859e17b78522f3ab25300e705ef2e8eb100f6']
assert [sha256(b.encode()).hexdigest() for b in blocks]==digests
mode=sys.argv[1] if len(sys.argv)>1 else 'verify'
assert mode in ('verify','control','search')
fixed='[[0,1,0],[0,3,2],[6,2,5],[6,3,5],[4,3,1]]'
index=1 if mode=='control' else 0
program,expected=blocks[index],digests[index]
args=[] if mode=='control' else ['search'] if mode=='search' else ['verify',fixed]
evidence_paths=[p,Path('research/astra-seven-adic-carry-scope-audit.md'),
                  Path('research/astra-seven-adic-carry-scope-review.md')]
retained=sum(q.stat().st_size for q in evidence_paths)
assert retained<1024*1024
t0=time.monotonic()
try:
    result=subprocess.run([sys.executable,'-B','-']+args,
        input=program,text=True,capture_output=True,timeout=60)
except subprocess.TimeoutExpired:
    print(json.dumps({'status':'INCONCLUSIVE','reason':'PARENT_TIMEOUT',
        'wall_cap_seconds':60,'program_sha256':expected},sort_keys=True))
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
    print(json.dumps({'status':'INCONCLUSIVE','reason':'CHILD_FAILED',
        'child_exit_code':result.returncode},sort_keys=True))
    raise SystemExit(1)
expected_output={
 'verify':'94578a03407c1d8e966c533cc7344de15a6b247d4ff619adfc1fc75f198f068b',
 'control':'1cf1a4646dcd1448755ecb0f0594c022ea88c404dd4027f4c2fe82c311738efe',
 'search':'cd2bdd971432a16dfd51da619fb692108d5281d0addd20ee3521734c091cbd49'}
assert sha256(result.stdout.encode()).hexdigest()==expected_output[mode]
assert result.stderr==''
PY
```

The final displayed Bash fence, including its final newline, has SHA-256
`fba9c4816345b476573bba88c1b1bd99efaf25ed8233ae7ffe78291231067e56`.
Its default fixed-only replay was executed after report assembly (terminal
chunk `c84828`): Bash and child both exited 0 with empty stderr, and the
1,436-byte child stdout reproduced the frozen fixed-verification hash.
That replay measured 0.02208709201659076 parent wall seconds,
0.017796/0.003954 child user/system seconds, and 16,260 KiB peak RSS.
The full Bash stdout, including its resource receipt, had SHA-256
`515f7621957753364780de4874dc17992dff63c9d8a183f4bdbe135968c35663`.
Both Python-source hashes, all three raw-stdout hashes, default replay mode,
and report whitespace passed integrity checks. The assembled manuscripts
and retained evidence remain below 80 KiB, within the 1 MiB cap.

## Mathematical disposition and next useful reasoning target

The finite F7+ claim is refuted, and simultaneous state realizability turns
that certificate into a refutation of the actual universally quantified
five-unit/one-top-speed assertion restricted to `A=J*(1+kR)`, J=1,...,6.
This is a manuscript result backed by reproducible exact Python arithmetic,
pending independent review. It is not a kernel-checked theorem. There is
no inference to the negation of the canonical LRC, no new seven-total
theorem, and no effect on the accepted Fin5 theorem or unrestricted goal.

The concrete obstacle is a restriction on the lower digits of the
multiplier: all current A satisfy `A mod R in {1,...,6}`. Adding J=6
therefore does not supply the required universal carry adapter. The next
useful reasoning target is input-dependent difference compression that
forces overlap among the final-digit bad pairs. For a general lower
multiplier b with `0<b<R` and `7` not dividing b, writing `lambda=b+kR`
gives the exact row digit

    (floor(b*x_i/R)+k*r_i) mod 7.

The two bad positions per row depend on the same b. A useful compression
lemma must preserve that dependence and force their union to omit a k.
This target remains unproved; no further experiment occurred here. Any
success would still retain valuation-pattern and runner-count gaps before
a seven-total theorem, and further gaps to the unrestricted conjecture.

All task-owned child processes have stopped. Only this compact report was
created; no cache or additional generated artifact is retained.
