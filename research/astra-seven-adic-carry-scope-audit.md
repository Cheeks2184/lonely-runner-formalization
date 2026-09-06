# Scope audit of the direct seven-adic coupled-carry extension

2026-09-06. Assigned `/root/seven_adic_carry_scope_audit`, requested
GPT-6 Astra/xhigh (runtime routing not independently attested), source
checkpoint `0608747f78d8e07100af900f4f746da902bd2fa9`. Configuration,
project workflow, policy and focused active state were read; the structural
workflow validator passed. Research is authorized and unrestricted LRC remains
unresolved. This file alone is owned. The active five-total implementation and
review continue independently. No Lean/source/state/Git/cache mutation, build,
browser model, new dependency or further agent is part of this audit.

**Manuscript verdict: the direct J=1,...,5 analogue is false.** The explicit
five-state certificate below is realized by distinct positive integer speeds
at m=2. Discovery was heuristic; the fixed 35-candidate refutation and integer
realization were exactly checked separately. This is an auxiliary-family
refutation, with no Lean proof or independent semantic-review promotion.

## Exact proposed contract and reduction

Let m>=1, R=7^m, P=7R, and let d_1,...,d_5,v be natural numbers not divisible
by 7. The six moving speeds are d_1,...,d_5,Rv. Positivity follows from the
unit assumptions; ordering, pairwise distinctness and gcd conditions are not
needed for the proposed auxiliary statement. Normalize each d independently
to x in (0,P), congruent to d or -d modulo P, with r=x mod 7 in {1,2,3}.
This preserves dist_P(Ax)=dist_P(Ad) for every integer multiplier A.

Write x=Ra+z, 0<=a<7, 0<=z<R. The single coupled carry tag is the unique
half-open interval containing z/R in the following partition. Equality at
any internal cut belongs to the interval on its right.

| tag | interval for z/R | (c_1,c_2,c_3,c_4,c_5) |
|---|---|---|
| 0 | [0,1/5) | (0,0,0,0,0) |
| 1 | [1/5,1/4) | (0,0,0,0,1) |
| 2 | [1/4,1/3) | (0,0,0,1,1) |
| 3 | [1/3,2/5) | (0,0,1,1,1) |
| 4 | [2/5,1/2) | (0,0,1,1,2) |
| 5 | [1/2,3/5) | (0,1,1,2,2) |
| 6 | [3/5,2/3) | (0,1,1,2,3) |
| 7 | [2/3,3/4) | (0,1,2,2,3) |
| 8 | [3/4,4/5) | (0,1,2,3,3) |
| 9 | [4/5,1) | (0,1,2,3,4) |

Here c_J=floor(Jz/R). These are all the breakpoints of these five floor
functions, so the table is exhaustive. Independent carry choices would
change the contract. A state is s=(a,r,tag), giving 7*3*10=210 states.
For J in {1,...,5}, k in {0,...,6}, set A=J(1+kR). Exact integer division gives

    floor(Ax/R) = Ja + floor(Jz/R) + Jkx,
    D(s,J,k) = (Ja+c_J+Jkr) mod 7.

The retained current coefficient is Jr, not r. The finite claim under audit is

    for all s_1,...,s_5, there exist J,k such that
        D(s_i,J,k) in {1,2,3,4,5} for every i.                 (F7)

For actual normalized units Ax is a 7-unit, hence Ax mod R is nonzero. If
y=Ax mod P, then y=R*D+(Ax mod R). Therefore the five allowed digits are
equivalent to dist_P(Ax)>=R for units: digit 0 or 6 fails strictly. For the
top-level speed Rv, the residue is R*((Jv) mod 7), so every candidate already
meets distance >=R, including digit 6 at equality. Applying the units' digit
predicate to that speed would wrongly exclude a valid boundary case.

## Predeclared bounded falsification design

The candidate universe has 35 bits indexed by 7*(J-1)+k. Each state has a
bad mask consisting of D=0 or D=6. Since Jr is nonzero modulo 7, the row
has exactly two bad k values for each J and thus exactly 10 bad bits. F7
fails if five masks cover all 35 bits.

The deterministic discovery procedure enumerates the 210 individual states
and 21,945 unordered distinct seed pairs. From each seed it greedily adds
at most three rows maximizing uncovered-bit gain, breaking ties by state
index. This uses at most 21,945*3*210=13,825,350 gain evaluations, plus
7,350 digit evaluations for the individual masks. It stops at the first
five-row cover. Failure to find a cover is **inconclusive**, not a proof.
No 210^5 tuple traversal, arbitrary speed-domain enumeration, installed
solver or dependency is used. A fixed found cover receives a separate exact
verification run. Both children are capped at 60 seconds wall time and
256 MiB address space; retained manuscript/code/stdout must stay under 1 MiB.

For realizability, every tag interval has width at least 1/20. At R=343
every such interval has length at least 343/20>7, so it contains an integer
in each specified residue class modulo 7. Consequently **every finite state
tuple is simultaneously realizable** at this common R. A fixed certificate
may admit smaller R; only m=1,2,3 are checked by closed-form construction,
not speed enumeration. Select the least z congruent to r modulo 7 at or
above the interval's lower endpoint and test its upper bound.

The following is the complete discovery/verification child program. Its
source guards concern immutable read-only dependencies; it does not import
or execute project proof/search code. `search` is the predeclared heuristic;
`verify` uses the frozen tuple once supplied below. Output is exact JSON.

```python
from fractions import Fraction
from hashlib import sha256
from itertools import combinations
from pathlib import Path
import json, resource, signal, sys

resource.setrlimit(resource.RLIMIT_AS, (256*1024*1024, 256*1024*1024))
resource.setrlimit(resource.RLIMIT_CPU, (59, 60))
signal.alarm(60)
guards = {
    'LonelyRunner/FiveAdicCarry.lean':
        'f91d747198374da76ff9e62435db20a8917856d5b9dc52229ce576353cc11d81',
    'research/astra-five-adic-carry-symbolic-plan.md':
        'd1fef1fafc6c7ae6adaf0ee885b4d44931e26bda667ff040f6c237f082555f80',
    'research/astra-five-adic-hard-adapter-plan.md':
        'f2d5e74769d86dc729d0f63f098654a9a538bf690e0c47d952272259bba37eef',
    'research/astra-five-adic-hard-adapter-plan-review.md':
        '579b1ea58b05788dc388cba4bcabb26aa152bf23fdebc919c497815973e2303f',
}
for path, digest in guards.items():
    assert sha256(Path(path).read_bytes()).hexdigest() == digest, path

cuts = sorted({Fraction(n, d) for d in range(1, 6) for n in range(d+1)})
assert len(cuts) == 11
carries = tuple(tuple((J*t).numerator // (J*t).denominator
                     for J in range(1, 6)) for t in cuts[:-1])
assert carries == ((0,0,0,0,0), (0,0,0,0,1), (0,0,0,1,1),
    (0,0,1,1,1), (0,0,1,1,2), (0,1,1,2,2), (0,1,1,2,3),
    (0,1,2,2,3), (0,1,2,3,3), (0,1,2,3,4))
states = tuple((a,r,t) for a in range(7) for r in range(1,4)
               for t in range(10))
candidates = tuple((J,k) for J in range(1,6) for k in range(7))
assert len(states) == 210 and len(candidates) == 35
def digit(s, J, k):
    a,r,t = s
    return (J*a+carries[t][J-1]+J*k*r)%7
masks = tuple(sum(1<<b for b,(J,k) in enumerate(candidates)
                  if digit(s,J,k) in (0,6)) for s in states)
assert all(mask.bit_count() == 10 for mask in masks)
full = (1<<35)-1

mode = sys.argv[1]
seeds = gains = 0
if mode == 'search':
    selected = None
    for first, second in combinations(range(210), 2):
        seeds += 1
        trial = [first,second]
        covered = masks[first] | masks[second]
        for step in range(3):
            best, best_gain = -1, -1
            missing = full ^ covered
            for index, mask in enumerate(masks):
                gain = (mask & missing).bit_count()
                gains += 1
                if gain > best_gain:
                    best, best_gain = index, gain
            if best_gain <= 0:
                break
            trial.append(best)
            covered |= masks[best]
            if covered == full:
                selected = trial
                break
        if selected is not None:
            break
    assert seeds <= 21945 and gains <= 13825350
    if selected is None:
        print(json.dumps({'status':'INCONCLUSIVE','seed_pairs':seeds,
                          'gain_evaluations':gains}, sort_keys=True))
        sys.exit(0)
    fixed = tuple(states[index] for index in selected)
elif mode == 'verify':
    fixed = tuple(tuple(s) for s in json.loads(sys.argv[2]))
    assert len(fixed) == 5 and len(set(fixed)) == 5
    selected = [states.index(s) for s in fixed]
else:
    raise AssertionError('mode must be search or verify')
assert len(fixed) == 5

# This portion is a direct 35-candidate certificate verifier, independent
# of the greedy choices. Every printed bad-row index is checked again.
bad_k = [[[k for k in range(7) if digit(s,J,k) in (0,6)]
          for J in range(1,6)] for s in fixed]
cover_rows = [[next(i for i,s in enumerate(fixed)
                   if digit(s,J,k) in (0,6)) for k in range(7)]
              for J in range(1,6)]
for J in range(1,6):
    assert set().union(*(set(row[J-1]) for row in bad_k)) == set(range(7))
    for k in range(7):
        assert digit(fixed[cover_rows[J-1][k]],J,k) in (0,6)

realized = None
for m in (1,2,3):
    R = 7**m
    xs, zs = [], []
    for a,r,t in fixed:
        lower = cuts[t]*R
        ceiling = -(-lower.numerator // lower.denominator)
        z = ceiling + (r-ceiling)%7
        if not (cuts[t]*R <= z < cuts[t+1]*R):
            break
        x = R*a+z
        assert 0 < x < 7*R and x%7 == r
        assert tuple(J*z//R for J in range(1,6)) == carries[t]
        zs.append(z)
        xs.append(x)
    if len(xs) == 5:
        realized = (m,R,xs,zs)
        break
assert realized is not None
m,R,xs,zs = realized
assert len(set(xs+[R])) == 6
P = 7*R
def distance(y):
    residue = y%P
    return min(residue, P-residue)
for J,k in candidates:
    A = J*(1+k*R)
    assert A%7 == J and 0 < A%P < P
    assert distance(A*R) >= R
    for s,x in zip(fixed,xs):
        assert (A*x//R)%7 == digit(s,J,k)
        assert (distance(A*x) >= R) == (digit(s,J,k) in (1,2,3,4,5))
    row = cover_rows[J-1][k]
    assert distance(A*xs[row]) < R
for path, digest in guards.items():
    assert sha256(Path(path).read_bytes()).hexdigest() == digest, path
print(json.dumps({'status':'F7_FALSE_FIXED_CERTIFICATE', 'mode':mode,
    'states':fixed, 'indices':selected, 'bad_k_by_row_then_J':bad_k,
    'first_bad_row_by_J_then_k':cover_rows,
    'realization':{'m':m,'R':R,'P':P,'units':xs,'z':zs,'top_speed':R},
    'state_count':len(states),'candidate_count':len(candidates),
    'seed_pairs':seeds,'gain_evaluations':gains,'source_guards':len(guards)},
    sort_keys=True))
```

## Frozen result

The first discovered tuple is

    ((0,1,0), (0,3,1), (6,2,4), (6,3,4), (4,3,0)).

The following table is a directly checkable cover certificate. Each entry is
the complete pair of bad k values (digit 0 or 6) for that row and J. Every
column's union is exactly {0,1,2,3,4,5,6}, so no shared candidate survives.

| row | (a,r,tag) | J=1 | J=2 | J=3 | J=4 | J=5 |
|---|---|---|---|---|---|---|
| 0 | (0,1,0) | 0,6 | 0,3 | 0,2 | 0,5 | 0,4 |
| 1 | (0,3,1) | 0,2 | 0,1 | 0,3 | 0,4 | 5,6 |
| 2 | (6,2,4) | 0,4 | 2,4 | 5,6 | 2,3 | 1,3 |
| 3 | (6,3,4) | 0,5 | 5,6 | 1,4 | 2,6 | 2,3 |
| 4 | (4,3,0) | 1,3 | 1,2 | 1,4 | 1,5 | 0,1 |

At m=2, R=49 and P=343, select z=(1,10,23,24,3), producing normalized units
x=(1,10,317,318,199); the sixth moving speed is Rv=49 with v=1.
The ratios 1/49 and 3/49 lie in tag 0, 10/49 lies in tag 1, and 23/49 and
24/49 lie in tag 4. The stated residues modulo 7 and top digits follow by
division. Thus every one of the 35 multipliers fails the actual closed
1/7 distance bound for at least one unit, even after reduction modulo P.
For this fixed tuple m=1 is impossible because tag 1's interval [7/5,7/4)
contains no integer. No claim that this is a smallest counterexample among
all tuples is made.

The actual seven-runner configuration (stationary runner plus these six
moving speeds) has a simple ordinary witness for the stationary runner:
t=1/4. The six residues modulo 4 are (1,2,1,2,3,1), so the six circle
distances are (1/4,1/2,1/4,1/2,1/4,1/4), all above 1/7.

Moreover the **single fixed added candidate** J=6,k=4 also works at the
original grid: A=6*(1+4*49)=1182, lambda=A mod 343=153. In the same speed
order its residues are (153,158,138,291,263,294) and cyclic distances
(153,158,138,52,80,49), all at least R=49. These two controls were checked
by direct integer arithmetic, with no additional search. In particular this
certificate does not refute an expanded family permitting J=6.

### Reproduction and terminal evidence

The single Python fence above, including its final newline, has SHA-256
`552e002164843889b7c19da7a6e4e1511201e83e94fee9a4392bdcfdaef1140d`.
The read-only source guards are embedded there and checked before and after
each successful run. The following command reproduces the separate fixed
verification; replace `verify` by `search` in the child argument to reproduce
the deterministic discovery. It writes no additional files. The final three
assertions are precisely the separately executed fixed arithmetic controls.

```bash
python3 -B - <<'PY'
from pathlib import Path
from hashlib import sha256
import json,re,resource,subprocess,sys,time
p=Path('research/astra-seven-adic-carry-scope-audit.md')
assert p.stat().st_size < 1024*1024
blocks=re.findall(r'^```python\n(.*?)^```[ \t]*$',p.read_text(),re.M|re.S)
assert len(blocks)==1
program=blocks[0]
assert sha256(program.encode()).hexdigest()=='552e002164843889b7c19da7a6e4e1511201e83e94fee9a4392bdcfdaef1140d'
fixed='[[0,1,0],[0,3,1],[6,2,4],[6,3,4],[4,3,0]]'
t0=time.monotonic()
try:
 result=subprocess.run([sys.executable,'-B','-','verify',fixed],input=program,text=True,capture_output=True,timeout=60)
except subprocess.TimeoutExpired:
 print(json.dumps({'status':'PARENT_TIMEOUT','wall_cap_seconds':60,'program_sha256':sha256(program.encode()).hexdigest()}))
 raise SystemExit(124)
elapsed=time.monotonic()-t0
usage=resource.getrusage(resource.RUSAGE_CHILDREN)
print(result.stdout,end='')
print(json.dumps({'exit_code':result.returncode,'elapsed_seconds':elapsed,'child_peak_rss_KiB':usage.ru_maxrss,'child_user_seconds':usage.ru_utime,'child_system_seconds':usage.ru_stime,'program_sha256':sha256(program.encode()).hexdigest(),'stdout_sha256':sha256(result.stdout.encode()).hexdigest(),'stderr_sha256':sha256(result.stderr.encode()).hexdigest(),'stdout_bytes':len(result.stdout.encode()),'stderr':result.stderr},sort_keys=True))
assert result.returncode==0
units=[1,10,317,318,199,49]
assert [d%4 for d in units]==[1,2,1,2,3,1]
assert [153*d%343 for d in units]==[153,158,138,291,263,294]
assert [min(153*d%343,343-153*d%343) for d in units]==[153,158,138,52,80,49]
print('Fixed quarter-time and J=6,k=4 arithmetic controls passed.')
PY
```

Both terminal runs exited 0 with empty stderr. Each child set RLIMIT_AS to
268,435,456 bytes, RLIMIT_CPU to soft 59/hard 60 seconds, and a 60-second
alarm; each parent additionally used `subprocess.run(timeout=60)`.
`ru_maxrss` is measured in KiB on this Linux host. These are observations for
the finite computations, not resource predictions for any Lean proof.

| run | terminal chunk | wall seconds | user / system seconds | peak RSS KiB | seed pairs / gain evaluations |
|---|---|---|---|---|---|
| discovery | b2ef96 | 0.023965019994648173 | 0.019614 / 0.004129 | 16,368 | 21 / 13,230 |
| fixed verification | d2cb7c | 0.029569350997917354 | 0.023922 / 0.004983 | 16,188 | 0 / 0 |

Raw discovery stdout (769 bytes, including one terminal newline), SHA-256
`dc5969e16af25c8ca14274ac4140ff94421760e719ad2b449e08c12a19a7ebf7`:

```json
{"bad_k_by_row_then_J": [[[0, 6], [0, 3], [0, 2], [0, 5], [0, 4]], [[0, 2], [0, 1], [0, 3], [0, 4], [5, 6]], [[0, 4], [2, 4], [5, 6], [2, 3], [1, 3]], [[0, 5], [5, 6], [1, 4], [2, 6], [2, 3]], [[1, 3], [1, 2], [1, 4], [1, 5], [0, 1]]], "candidate_count": 35, "first_bad_row_by_J_then_k": [[0, 4, 1, 4, 2, 3, 0], [0, 1, 2, 0, 2, 3, 3], [0, 3, 0, 1, 3, 2, 2], [0, 4, 2, 2, 1, 0, 3], [0, 2, 3, 2, 0, 1, 1]], "gain_evaluations": 13230, "indices": [0, 21, 194, 204, 140], "mode": "search", "realization": {"P": 343, "R": 49, "m": 2, "top_speed": 49, "units": [1, 10, 317, 318, 199], "z": [1, 10, 23, 24, 3]}, "seed_pairs": 21, "source_guards": 4, "state_count": 210, "states": [[0, 1, 0], [0, 3, 1], [6, 2, 4], [6, 3, 4], [4, 3, 0]], "status": "F7_FALSE_FIXED_CERTIFICATE"}
```

Raw fixed-verification stdout (764 bytes, including one terminal newline),
SHA-256 `954bfaae5a245b193daa33de5c3fd27879137212a737c7952249619268cf8c9f`:

```json
{"bad_k_by_row_then_J": [[[0, 6], [0, 3], [0, 2], [0, 5], [0, 4]], [[0, 2], [0, 1], [0, 3], [0, 4], [5, 6]], [[0, 4], [2, 4], [5, 6], [2, 3], [1, 3]], [[0, 5], [5, 6], [1, 4], [2, 6], [2, 3]], [[1, 3], [1, 2], [1, 4], [1, 5], [0, 1]]], "candidate_count": 35, "first_bad_row_by_J_then_k": [[0, 4, 1, 4, 2, 3, 0], [0, 1, 2, 0, 2, 3, 3], [0, 3, 0, 1, 3, 2, 2], [0, 4, 2, 2, 1, 0, 3], [0, 2, 3, 2, 0, 1, 1]], "gain_evaluations": 0, "indices": [0, 21, 194, 204, 140], "mode": "verify", "realization": {"P": 343, "R": 49, "m": 2, "top_speed": 49, "units": [1, 10, 317, 318, 199], "z": [1, 10, 23, 24, 3]}, "seed_pairs": 0, "source_guards": 4, "state_count": 210, "states": [[0, 1, 0], [0, 3, 1], [6, 2, 4], [6, 3, 4], [4, 3, 0]], "status": "F7_FALSE_FIXED_CERTIFICATE"}
```

Both empty child stderrs have SHA-256
`e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.
The output hashes exclude the outer resource receipt and arithmetic-control
line. All owned processes have stopped, with no retained generated file
beyond this compact manuscript. No external source was required or consulted.

## First unresolved implication and scope disposition

F7 cannot supply the proposed seven-adic hard-pattern adapter. The precise
next question, **unresolved and not searched in this audit**, is whether the
same five-row predicate becomes universal for J in {1,...,6}. Its state must
retain the additional coupled carry c_6=floor(6z/R). The exact partition adds
1/6 and 5/6 to the old cuts, splitting old tags 0 and 9, giving 12 tags,
7*3*12=252 row states, and 42 candidates. The proposed obligation is

    for every five (a,r,tag) in Fin7 x {1,2,3} x these 12 coupled tags,
    there exist J in {1,...,6}, k in {0,...,6}, such that
      (J*a_i+c_{i,J}+J*k*r_i) mod 7 is in {1,...,5} for every i.

The six-carry table must be derived before any such bounded check; reusing
the old tag without splitting its first and last intervals is unsound.
The fixed J=6 control proves only that the displayed counterexample no
longer obstructs that family. It gives neither a universal theorem nor
evidence from a wider search. A true expanded lemma would still cover only
five unit speeds plus one top-level speed; further valuation-pattern and
canonical-quantifier arguments would be needed for a seven-total result.
It would not settle unrestricted LRC. No seven-adic Lean implementation is
authorized by this audit, and no change to the current five-total checkpoint
or the active unrestricted goal follows from this failed auxiliary branch.
