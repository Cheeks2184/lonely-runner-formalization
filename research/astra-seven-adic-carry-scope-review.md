# Independent review of the restricted seven-adic carry claim

2026-09-06. Task `/root/seven_adic_scope_independent_review`, requested
GPT-6 Astra/xhigh; observed runtime model/effort are not independently
attested. Assigned source checkpoint `0608747f78d8e07100af900f4f746da902bd2fa9`.
Configuration, workflow, policy, focused state and validator were read;
`python3 -B scripts/validate_workflow.py` passed. The gate is open:
`research` / `in_progress`, with recorded user start authorization.
Only this new report is owned. No Lean/source/state/Git/cache changes,
builds, dependencies, browser model, extra agents or expanded search occur.

**Verdict: accept the restricted auxiliary refutation at manuscript level.**
The frozen author manuscript is `research/astra-seven-adic-carry-scope-audit.md`,
18,721 bytes, SHA-256
`4360a75613ba59fad5de8edcd23f37397876d0235816b9340b8707f93a63a126`.
Its five-state cover, realization and two limiting controls are correct.
The new J=1,...,6 statement remains unresolved. This review makes no kernel
proof claim and changes neither the five-total checkpoint nor the unresolved
unrestricted LRC goal.

## Hypotheses and exact reduction

Take m>=1, R=7^m, P=7R, and natural d_1,...,d_5,v with none divisible by 7.
The moving speeds are d_1,...,d_5,Rv. Reduce each d or its negative modulo P
to x in (0,P), choosing its sign so r=x mod 7 belongs to {1,2,3}.
This is always possible: the six nonzero residues split into the three
opposite pairs. Changing sign or adding a multiple of P preserves every
cyclic distance `dist_P(A*d)`. There is no ordering, distinctness, gcd,
residue-equality or carry-independence premise.

Write x=Ra+z, 0<=a<7 and 0<=z<R. In fact z is nonzero and z mod 7=r.
Let c_J=floor(J*z/R), all determined by the same z/R. For k in {0,...,6}
and J in {1,...,5}, set A=J(1+kR). Integer division gives

    floor(A*x/R) = J*a + floor(J*z/R) + J*k*x,
    D = floor(A*x/R) mod 7 = (J*a+c_J+J*k*r) mod 7.

The coefficient J on the translation term is necessary. All breakpoints of
the five floors are exactly the sorted fractions n/d for 1<=d<=5 and
0<=n<=d. They give the manuscript's ten half-open tags and its exact five
carry table. Thus the finite contract is precisely

    for every ordered five states in {0,...,6} x {1,2,3} x {0,...,9},
    some shared J in {1,...,5}, k in {0,...,6} makes all five D in {1,...,5}.

There are 210 row states and 35 shared candidates. Repeated states are
allowed by this universal quantifier. For every fixed row and J, Jr is
nonzero modulo 7, so precisely two k values give D in {0,6}. A bad row
therefore has ten candidate bits. Five-row failure means their union is
all 35 bits, not that each row separately has a failing candidate.

For the closed boundary, put w=A*x mod R and y=A*x mod P. Since A and x
are 7-units, 0<w<R. Hence y=R*D+w. If D=0 then y<R. If D=6 then
P-y=R-w<R. If 1<=D<=5 then R<y<6R, so both y and P-y exceed R.
Consequently `dist_P(A*x)>=R` is equivalent to D in {1,...,5} for these
units. The strict failure at digit 6 is not a boundary convention.

For Rv instead, y=R*((J*v) mod 7). Its nonzero digit can be any of 1,...,6
and its distance is R times min(q,7-q), hence at least R. Digits 1 and 6
can attain equality. Applying the units' predicate to Rv is invalid.
These arguments also hold for J=6 because it too is a 7-unit. Dividing
all distances by P identifies the threshold with the closed circle bound
1/7 at time A/P; reducing A modulo P does not change any integer-speed
residue.

For completeness, every one of the 210 states is genuinely realizable at
the same R=343. The smallest old tag width is 1/20. For any interval
[L,U) of length at least 7, its least integer z congruent to r modulo 7
at or above L satisfies L<=z<L+7<=U. Here each scaled interval has length
at least 343/20>7. Set x=343*a+z. This establishes simultaneous tuple
realizability without independent carry choices. If a separate application
requires distinct original speeds despite repeated states, distinct lifts
x+nP preserve their normalized states and all candidate distances.

## Fixed countermodel and scope controls

The five states, in order, are

    (0,1,0), (0,3,1), (6,2,4), (6,3,4), (4,3,0).

At R=49, z=(1,10,23,24,3) gives x=(1,10,317,318,199). Choose v=1,
so the sixth moving speed is 49. These six speeds are positive, pairwise
distinct and have gcd 1. The tags, top digits and residues satisfy exactly
the hypotheses above. At m=1, the required tag [7/5,7/4) contains no
integer; no global minimal-counterexample claim follows.

The following first-failing-row array covers all candidates; rows are
zero-indexed in the displayed tuple and each line corresponds to one J:

    J=1: 0 4 1 4 2 3 0
    J=2: 0 1 2 0 2 3 3
    J=3: 0 3 0 1 3 2 2
    J=4: 0 4 2 2 1 0 3
    J=5: 0 2 3 2 0 1 1

The reproducer below independently computes each actual integer residue,
checks the digit identity and boundary equivalence for all 175 unit/candidate
pairs, and checks every claimed failing row. It reconstructs the author's
entire fixed-verification JSON with the same byte hash. The result refutes
both the displayed finite contract and its universally quantified actual
restricted-multiplier assertion: a single admissible m=2 instance suffices.

There is no LRC counterexample. At t=1/4 the six speed residues modulo 4
are (1,2,1,2,3,1), giving distances (1/4,1/2,1/4,1/2,1/4,1/4), each >1/7.
The fixed additional candidate J=6,k=4 has A=1182 and A mod 343=153;
the six residues are (153,158,138,291,263,294), giving distances
(153,158,138,52,80,49). All meet R=49, including the top-speed equality.
This verifies only that candidate on this configuration, not universality
of the expanded family or an ordinary witness for every distinguished runner.

## Exact next contract, still unresolved

The expanded six-carry partition adds exactly 1/6 and 5/6. All tags are
half-open, with equality at an internal cut assigned to the right:

| tag | z/R interval | (c_1,c_2,c_3,c_4,c_5,c_6) |
|---|---|---|
| 0 | [0,1/6) | (0,0,0,0,0,0) |
| 1 | [1/6,1/5) | (0,0,0,0,0,1) |
| 2 | [1/5,1/4) | (0,0,0,0,1,1) |
| 3 | [1/4,1/3) | (0,0,0,1,1,1) |
| 4 | [1/3,2/5) | (0,0,1,1,1,2) |
| 5 | [2/5,1/2) | (0,0,1,1,2,2) |
| 6 | [1/2,3/5) | (0,1,1,2,2,3) |
| 7 | [3/5,2/3) | (0,1,1,2,3,3) |
| 8 | [2/3,3/4) | (0,1,2,2,3,4) |
| 9 | [3/4,4/5) | (0,1,2,3,3,4) |
| 10 | [4/5,5/6) | (0,1,2,3,4,4) |
| 11 | [5/6,1) | (0,1,2,3,4,5) |

Each entry is floor(J*l) at the lower endpoint l; the complete breakpoint
list proves constancy throughout that interval. It is not sound to retain
only the old ten tags when J=6 is admitted. The smallest new width is
1/30. The same realization argument applies because 343/30>7, so every
one of the 252 expanded states is realizable at R=343, simultaneously for
any five-state tuple. The code checks the 30 old and 36 expanded
(tag,residue) constructions; arbitrary top digits follow by adding 343*a.
These are individual-state arithmetic checks, not a five-row search.

The first unresolved implication is exactly

    for every s_1,...,s_5 in {0,...,6} x {1,2,3} x {0,...,11},
    there exist J in {1,...,6}, k in {0,...,6}, such that for every i,
      (J*a_i+c_{i,J}+J*k*r_i) mod 7 belongs to {1,...,5}.       (F7+)

It has 252 states and 42 candidates, with twelve bad bits per row. The
restricted refutation and the fixed J=6 success establish neither F7+
nor its negation. If true, it would give only the five-unit/one-top-speed
adapter under the exact hypotheses above. Further valuation-pattern and
canonical-quantifier arguments would still be required for seven total
runners, and that would still not resolve unrestricted LRC.

## Nominated bounded falsification experiment, not executed

Order states lexicographically by (a,r,tag), and candidates by (J,k), with
candidate bit 7*(J-1)+k. Precompute all 252 masks from the six-carry table:
252*42=10,584 individual digit evaluations. Enumerate the 31,626 unordered
distinct state-index seed pairs in lexicographic order. For each pair,
perform at most three greedy additions maximizing the number of currently
uncovered bits; ties go to the smallest state index. Stop that seed if the
best gain is zero, and stop the experiment upon a cover. This is at most
31,626*3*252=23,909,256 gain evaluations, with no 252^5 tuple traversal,
solver, speed sweep, extra J values or adaptive budget extension.

One small control-flow repair is needed for the prospective experiment:
if coverage is reached before five rows, pad to five with the least unused
indices. Padding cannot destroy coverage and needs no additional gain
evaluation. The author's search stops at an early cover but subsequently
asserts exactly five rows; counting alone does not exclude a four-row cover.
This has no effect on its actual five-row frozen result. Positive-gain
additions already avoid previous rows; padding makes the returned five
indices distinct without imposing distinctness on the universal theorem.

Predeclare 60 seconds wall time, 256 MiB child address space, and at most
1 MiB retained evidence, including readable program, exact inputs, output
and resource receipt. Use an independent parent timeout, child alarm and
resource limits. A timeout, resource stop or completed search with no cover
is **INCONCLUSIVE**. A cover is only a candidate refutation until a separate
fixed independent verification checks all 42 candidates, constructs actual
unit speeds using the common R=343 bound, and verifies the original closed
distance failure and always-good top speed directly. Each bounded child
must obey the same caps. No result may be promoted to a Lean theorem or
LRC claim. This review authorizes no execution; the orchestrator chooses
whether to launch that exact later task.

## Standalone fixed arithmetic reproducer

The sole Python fence is a fixed verifier. It has no discovery branch and
does not execute the author's search program. Its guards bind the author
manuscript and four immutable dependencies; no mutable Ordinary report,
root module, AxiomAudit, workflow state or cache is guarded. Hashes identify
bytes and provenance, not mathematical validity. Exact constants and the
complete program are readable below.

```python
from fractions import Fraction
from hashlib import sha256
from pathlib import Path
import json, re, resource, signal

resource.setrlimit(resource.RLIMIT_AS, (256*1024*1024, 256*1024*1024))
resource.setrlimit(resource.RLIMIT_CPU, (59, 60))
signal.alarm(60)
guards = {
    'research/astra-seven-adic-carry-scope-audit.md':
        '4360a75613ba59fad5de8edcd23f37397876d0235816b9340b8707f93a63a126',
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
author = Path('research/astra-seven-adic-carry-scope-audit.md').read_text()
assert len(author.encode()) == 18721
author_programs = re.findall(r'^```python\n(.*?)^```[ \t]*$', author, re.M|re.S)
assert len(author_programs) == 1
assert sha256(author_programs[0].encode()).hexdigest() == (
    '552e002164843889b7c19da7a6e4e1511201e83e94fee9a4392bdcfdaef1140d')
raw_outputs = re.findall(r'^```json\n(.*?)^```[ \t]*$', author, re.M|re.S)
assert len(raw_outputs) == 2
fixed_hash = '954bfaae5a245b193daa33de5c3fd27879137212a737c7952249619268cf8c9f'
assert sha256(raw_outputs[1].encode()).hexdigest() == fixed_hash
def partition(n):
    cuts = sorted({Fraction(b,d) for d in range(1,n+1) for b in range(d+1)})
    rows = tuple(tuple((j*l).__floor__() for j in range(1,n+1)) for l in cuts[:-1])
    return cuts, rows
cuts5, C5 = partition(5)
cuts6, C6 = partition(6)
assert C5 == ((0,0,0,0,0),(0,0,0,0,1),(0,0,0,1,1),(0,0,1,1,1),
    (0,0,1,1,2),(0,1,1,2,2),(0,1,1,2,3),(0,1,2,2,3),
    (0,1,2,3,3),(0,1,2,3,4))
assert C6 == ((0,0,0,0,0,0),(0,0,0,0,0,1),(0,0,0,0,1,1),
    (0,0,0,1,1,1),(0,0,1,1,1,2),(0,0,1,1,2,2),(0,1,1,2,2,3),
    (0,1,1,2,3,3),(0,1,2,2,3,4),(0,1,2,3,3,4),
    (0,1,2,3,4,4),(0,1,2,3,4,5))
assert set(cuts6)-set(cuts5) == {Fraction(1,6),Fraction(5,6)}
widths = [min(b-a for a,b in zip(cs,cs[1:])) for cs in (cuts5,cuts6)]
assert widths == [Fraction(1,20),Fraction(1,30)]
base_counts = []
for n,cs,rows in ((5,cuts5,C5),(6,cuts6,C6)):
    count = 0
    for t,(l,u) in enumerate(zip(cs,cs[1:])):
        assert 343*(u-l) > 7
        for r in (1,2,3):
            z = r + 7*((343*l-r)/7).__ceil__()
            assert 343*l <= z < 343*u and 0 < z < 343 and z%7 == r
            assert tuple(j*z//343 for j in range(1,n+1)) == rows[t]
            count += 1
    base_counts.append(count)
assert base_counts == [30,36]
fixed = [(0,1,0),(0,3,1),(6,2,4),(6,3,4),(4,3,0)]
xs, zs, R, P = [1,10,317,318,199], [1,10,23,24,3], 49, 343
assert len(set(xs+[R])) == 6
for (a,r,t),x,z in zip(fixed,xs,zs):
    assert divmod(x,R) == (a,z) and x%7 == r and 0<x<P
    assert cuts5[t]*R <= z < cuts5[t+1]*R
    assert tuple(j*z//R for j in range(1,6)) == C5[t]
bad = [[[] for j in range(5)] for i in range(5)]
cover = []
unit_checks = 0
for J in range(1,6):
    row_cover = []
    for k in range(7):
        A = J*(1+k*R)
        failures = []
        top = (A*R)%P
        assert min(top,P-top) >= R
        for i,((a,r,t),x) in enumerate(zip(fixed,xs)):
            q,w = divmod(A*x,R)
            D = (J*a+C5[t][J-1]+J*k*r)%7
            y = (A*x)%P
            assert 0<w<R and q%7 == D and y == R*D+w
            good = min(y,P-y) >= R
            assert good == (D in (1,2,3,4,5))
            unit_checks += 1
            if not good:
                bad[i][J-1].append(k)
                failures.append(i)
        assert failures
        row_cover.append(failures[0])
    cover.append(row_cover)
assert unit_checks == 175
assert all(len(pair)==2 for row in bad for pair in row)
assert cover == [[0,4,1,4,2,3,0],[0,1,2,0,2,3,3],[0,3,0,1,3,2,2],
    [0,4,2,2,1,0,3],[0,2,3,2,0,1,1]]
recomputed = {'status':'F7_FALSE_FIXED_CERTIFICATE','mode':'verify',
    'states':fixed,'indices':[a*30+(r-1)*10+t for a,r,t in fixed],
    'bad_k_by_row_then_J':bad,'first_bad_row_by_J_then_k':cover,
    'realization':{'m':2,'R':R,'P':P,'units':xs,'z':zs,'top_speed':R},
    'state_count':210,'candidate_count':35,'seed_pairs':0,
    'gain_evaluations':0,'source_guards':4}
recomputed_stdout = json.dumps(recomputed,sort_keys=True)+'\n'
assert recomputed_stdout == raw_outputs[1]
assert sha256(recomputed_stdout.encode()).hexdigest() == fixed_hash
speeds = xs+[R]
quarter = [d%4 for d in speeds]
assert quarter == [1,2,1,2,3,1]
assert all(7*min(y,4-y) > 4 for y in quarter)
assert 6*(1+4*R) == 1182 and 1182%P == 153
added = [153*d%P for d in speeds]
distances = [min(y,P-y) for y in added]
assert added == [153,158,138,291,263,294]
assert distances == [153,158,138,52,80,49]
assert all(d>=R for d in distances)
state_count, candidate_count = 7*3*len(C6), 6*7
seed_cap = state_count*(state_count-1)//2
assert (state_count,candidate_count,seed_cap) == (252,42,31626)
assert seed_cap*3*state_count == 23909256
assert state_count*candidate_count == 10584
check_guards()
out = json.dumps({'status':'FIXED_ARITHMETIC_AND_NEXT_CONTRACT_CHECKED',
    'source_guards':len(guards),'fixed_stdout_sha256':fixed_hash,
    'unit_candidate_checks':unit_checks,'closed_boundary_controls':'passed',
    'expanded_cuts':[str(c) for c in cuts6],'expanded_carries':C6,
    'minimum_widths':[str(w) for w in widths],
    'realizability_R':343,'tag_residue_checks':base_counts,
    'expanded_state_count':state_count,'expanded_candidate_count':candidate_count,
    'proposed_seed_pair_cap':seed_cap,'proposed_gain_cap':23909256,
    'proposed_digit_cap':10584,'expanded_search_executed':False},sort_keys=True)+'\n'
assert len(out.encode()) < 1024*1024
print(out,end='')
```

Run from the repository root. This extracts and guards the sole verifier
above, runs it in a resource-limited child, and prints its raw stdout plus
an outer resource receipt. It writes no extra artifact:

```bash
python3 -B - <<'PY'
from hashlib import sha256
from pathlib import Path
import json,re,resource,subprocess,sys,time
p=Path('research/astra-seven-adic-carry-scope-review.md')
assert p.stat().st_size+Path('research/astra-seven-adic-carry-scope-audit.md').stat().st_size < 1024*1024
blocks=re.findall(r'^```python\n(.*?)^```[ \t]*$',p.read_text(),re.M|re.S)
assert len(blocks)==1
program=blocks[0]
expected='5b9aee867f91f2ae1ae1b92911dbfed0996ae95cade59051b946e2637d1174bb'
assert sha256(program.encode()).hexdigest()==expected
t0=time.monotonic()
try:
    result=subprocess.run([sys.executable,'-B','-'],input=program,text=True,capture_output=True,timeout=60)
except subprocess.TimeoutExpired:
    print(json.dumps({'status':'PARENT_TIMEOUT','wall_cap_seconds':60,'program_sha256':expected}))
    raise SystemExit(124)
elapsed=time.monotonic()-t0
usage=resource.getrusage(resource.RUSAGE_CHILDREN)
assert len(result.stdout.encode())+len(result.stderr.encode())+p.stat().st_size+18721 < 1024*1024
print(result.stdout,end='')
print(json.dumps({'exit_code':result.returncode,'elapsed_seconds':elapsed,
    'child_peak_rss_KiB':usage.ru_maxrss,'child_user_seconds':usage.ru_utime,
    'child_system_seconds':usage.ru_stime,'program_sha256':expected,
    'stdout_bytes':len(result.stdout.encode()),
    'stdout_sha256':sha256(result.stdout.encode()).hexdigest(),
    'stderr_sha256':sha256(result.stderr.encode()).hexdigest(),
    'stderr':result.stderr},sort_keys=True))
assert result.returncode==0
PY
```

The single fixed replay (terminal chunk `b2275a`) exited 0 with empty stderr.
Child wall time was 0.022726938012056053 seconds, user/system time
0.018583/0.003912 seconds, and peak RSS 16,520 KiB on this Linux host.
The executable Python-fence bytes, including their final newline, have
SHA-256 `5b9aee867f91f2ae1ae1b92911dbfed0996ae95cade59051b946e2637d1174bb`.
All five source guards passed before and after the arithmetic. The child
limits were 268,435,456 address-space bytes, 59/60 CPU seconds and a
60-second alarm; its parent additionally enforced a 60-second timeout.
The author manuscript, this report and retained outputs total under 40 KiB,
well below the 1 MiB evidence cap. Measurements concern only this replay.

Raw child stdout is 885 bytes including the final newline, SHA-256
`ec024deaad93a45f818b3f21f227cb122626f0ae0609a013ba84bd6f43bb8484`:

```json
{"closed_boundary_controls": "passed", "expanded_candidate_count": 42, "expanded_carries": [[0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 1], [0, 0, 0, 0, 1, 1], [0, 0, 0, 1, 1, 1], [0, 0, 1, 1, 1, 2], [0, 0, 1, 1, 2, 2], [0, 1, 1, 2, 2, 3], [0, 1, 1, 2, 3, 3], [0, 1, 2, 2, 3, 4], [0, 1, 2, 3, 3, 4], [0, 1, 2, 3, 4, 4], [0, 1, 2, 3, 4, 5]], "expanded_cuts": ["0", "1/6", "1/5", "1/4", "1/3", "2/5", "1/2", "3/5", "2/3", "3/4", "4/5", "5/6", "1"], "expanded_search_executed": false, "expanded_state_count": 252, "fixed_stdout_sha256": "954bfaae5a245b193daa33de5c3fd27879137212a737c7952249619268cf8c9f", "minimum_widths": ["1/20", "1/30"], "proposed_digit_cap": 10584, "proposed_gain_cap": 23909256, "proposed_seed_pair_cap": 31626, "realizability_R": 343, "source_guards": 5, "status": "FIXED_ARITHMETIC_AND_NEXT_CONTRACT_CHECKED", "tag_residue_checks": [30, 36], "unit_candidate_checks": 175}
```

The empty stderr SHA-256 is
`e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.
Output hashes exclude the outer resource receipt. No expanded masks, seed
pairs, greedy additions or five-tuples were evaluated by this verifier;
its proposed search counts are arithmetic bounds only. All owned processes
have stopped. The frozen disposition is manuscript acceptance of the old
restricted refutation, with F7+ and its proposed later bounded experiment
unresolved and unexecuted. There is no promotion beyond that disposition.
