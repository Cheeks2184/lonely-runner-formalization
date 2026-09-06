# Independent review of general-prime difference compression

2026-09-06. Task `/root/prime_difference_compression_review`, executed in
reused agent `/root/seven_adic_expanded_falsifier`, requested Astra/xhigh;
runtime model and effort are not independently attested. Source checkpoint
`312158239315a3488cb522695b58c0a2fece7621`. Current configuration, workflow,
policy and focused active state were read, and the structural workflow
validator passed. Research is authorized; unrestricted LRC remains unresolved.
Only this report is owned. No Lean, other source, state, Git, dependency,
cache, build, or frozen-manuscript changes are part of this task.

**Verdict: accept the self-contained manuscript proofs and both proposed
natural Lean theorem contracts, without mathematical corrections.** The
frozen author report is `research/astra-prime-difference-compression-plan.md`,
22,270 bytes, SHA-256
`ee396d22cae90460868ee13ba70c26204cafad190aea3b72835680218b3c88c2`.
This is independent semantic acceptance, not a kernel implementation or a
new runner-count theorem. The numerical work recorded below is confined to
fixed arithmetic controls; the author's unexecuted prose is not relabeled
as a test run.

## Independent proof and contract audit

Write `R=p^m`, `P=pR`, where p is prime and m is any natural. Thus
`p>=2`, `R>0`, and `P>1`, including p=2 and m=0. For signed integers,
Euclidean division gives `z=Pn+r`, `0<=r<P`, and hence

    floor(z/R) mod p = floor(r/R).

This establishes the exact bridge between the signed digit and natural
residue digit. It does not involve absolute values or rounding toward zero.

For a live natural input `d=p^j*u`, and `j<m`, multiplication by
`H_j(k)=1+k*p^(m-j)` adds `k*R*A*u` to its current product `A*d`.
Division by R therefore translates its digit by `k*(A*u mod p)`.
The coefficient is invertible because A and u are units. Solving the one
linear equation in `ZMod p` supplies a unique k modulo p; no finite search
is needed. Every correction is 1 modulo p. If `ell>j`, its increment on
`p^ell*v` is divisible by P, so it preserves the entire higher residue.

To prove F, order the two levels high to low. At a high level below m,
start from 1 and use one such correction. At level m, solve
`J*u=target (mod p)` with `1<=J<p`; the nonzero target is essential here.
Then solve the lower target using the current coefficient, preserving the
high residue. Reducing the product B modulo P preserves both target digits
and its nonzero residue modulo p, so `0<B mod P<P`. This proves precisely
`primeAdic_two_distinct_targets`, including inputs greater than P.

There is no missing positivity hypothesis on u or v: `not p divides u`
excludes zero, so both factors and both inputs are positive. The two
targets are naturals, so `tx<p` and `ty<p` also give their lower bounds.
Distinct levels with `a,b<=m` imply m>0 automatically for F; at m=0 its
hypotheses cannot hold. The conditional top-target premises are exactly
what is needed. Neither an odd-prime restriction nor unit original inputs
in the later compression theorem are justified or necessary.

For the interval lemma, choose the lift 0 for a zero difference residue,
and `r-P` for one in `[P-R,P)`. Each lift lies in the **closed** interval
`[-R,0]`. If Q is the floor quotient of the anchor by R, monotonicity gives
only the two possible quotients `Q-1` and Q for every shifted input.
Modulo p, these are the anchor's predecessor and the anchor itself.
The endpoint `-R` gives `Q-1` exactly and must remain included. Negative
anchors, zero lifts and cyclic wrap are all covered by the same argument.

The definition `primeAdicDifference p m a b` correctly represents oriented
`a-b`: the term `a%P+P-b%P` cannot truncate, since `b%P<P`. Its result is
automatically below P. Thus the three cases in `PrimeAdicDifferenceSeparated`
are sufficient for `primeAdic_triple_compression`:

1. Both residues zero: use multiplier 1.
2. Exactly one zero: decompose only the nonzero residue and set its digit
   to p-1 by the one-target solver.
3. Both live: use the supplied unequal levels and F, with targets p-1.

The representative bound required in case 2 is supplied by the difference
definition, rather than omitted from an arbitrary-input interface. For
`0<d<P`, its largest divisible power has exponent at most m, and its unit
factor is positive. Values divisible by P are already in the zero branch.
No value of `padicValNat` at zero is used. A signed nonzero difference of
level h<=m has the same level after reduction, since its unit factor changes
by a multiple of `p^(m+1-h)`. Higher signed levels collapse. This also
justifies the manuscript's ordinary-valuation sufficient condition.

The two proposed declaration types retain all essential bounds, unit
conditions, level separation, top-target restrictions and multiplier
conclusions. In the triple conclusion, `b 2` is the anchor, and the stated
disjunction is exactly membership in its predecessor/anchor pair, even
when labels repeat. For a signed adapter, first reduce every input using
`Int.natMod` and transfer the products by residue congruence. Changing an
oriented difference to its `natAbs` would require a tracked sign change
and is not an acceptable shortcut.

The same-level obstruction is also sound as a universal manuscript
argument. For `(1,50,99)`, R=49, every unit lambda has nonzero
`s=lambda mod 7` and digits `q(lambda)+{0,s,2s}`. These are three distinct
residues in the field with seven elements, so no containing pair exists.
The fixed arithmetic check below illustrates lambda=1 only; the universal
conclusion rests on this algebra, not a multiplier enumeration.

## Relation to the primary source and existing APIs

I checked the publisher's Lemma 9(i), Remark 8 and filtering setup. Its
proof goes from two anchored difference digits equal to six to an assertion
about all ordered differences before invoking Remark 8. At residue 6R,
negation has residue R and digit one, so that implication needs repair at
the endpoint. A collapsed difference also cannot be forced to digit six.
The manuscript's closed anchored interval proof establishes compression
without that all-differences assertion. This review accepts the repaired
argument; it does not claim a refutation of Lemma 9's compression conclusion
or validate the remainder of the paper. See
[Barajas and Serra, pp. 3-4 and 10-11](https://www.combinatorics.org/ojs/index.php/eljc/article/download/v15i1r48/pdf).

The source map was checked against the actual project files. Existing
`FiveAdicFiltering.lean` has the required selected-product, current-coefficient
digit, higher-residue, digit-congruence and unit-representative patterns, all
fixed at five. `FiveAdicDecomposition.lean` guards positive inputs before
using `padicValNat`. `FiveAdicHardPattern.lean` proves distance symmetry,
which cannot be substituted for digit symmetry. `ReverseGrid.lean` supplies
the signed `Int.natMod` convention and distance congruence precedent, not
an existing oriented digit adapter. No `.lake` files were inspected.

Accepted implementation order, confined to new modules as appropriate:

1. General-prime digit, residue congruence and bounded unit representative;
   selected correction product/digit and higher-residue preservation.
2. One-target solver, with a distinct top-level scalar branch, then F.
   Supply `Fact (Nat.Prime p)` locally for `ZMod p` inversion.
3. Positive bounded-residue decomposition, then the closed interval lemma
   in signed arithmetic or an equivalent natural wrap split.
4. Triple compression from the exact collapse/live cases, then an oriented
   signed adapter. Retain the difference residue certificate internally.
5. Focused kernel verification and independent contract/axiom review after
   implementation. Neither theorem currently exists as a checked declaration.

No minimum-length API, general replacement of the five-adic modules, or
downstream translation-count formalization is needed for this first contract.
The manuscript's sparse family extension follows by descending through
distinct occupied levels. Its same-class translation count is sound with
m>=1: common nonzero slope gives at least `max(p-3,0)` safe positions for a
containing pair, hence four for p=7. Preservation under corrections strictly
below every live difference follows from the higher-residue identity. These
remain manuscript corollaries, with no unrestricted selection claim.

## Bounded fixed arithmetic controls

Before execution, this review fixes eight successful triple fixtures, one
equal-level obstruction fixture, and five two-target fixtures below. There
is no speed sweep, multiplier enumeration, solver, adaptive input, or
search. Modular inverses compute the prescribed algebraic choices only.
The first five author example groups are checked, supplemented by explicit
negative-anchor, actual-zero, p=2, and arbitrary-input-size controls.
The equal-level universal claim and general proofs above are symbolic,
not inferred from these fixed examples.

Each child is capped at 60 seconds wall time, 256 MiB address space, and
soft/hard CPU limits of 59/60 seconds. The parent has an independent
60-second timeout; all retained evidence must be below 1 MiB. Any execution
failure is a failed/inconclusive check, never a mathematical disproof.
The program uses nine frozen source guards before and after arithmetic.

```python
from hashlib import sha256
from pathlib import Path
import json, resource, signal

resource.setrlimit(resource.RLIMIT_AS,(256*1024*1024,256*1024*1024))
resource.setrlimit(resource.RLIMIT_CPU,(59,60))
signal.alarm(60)
GUARDS = {
 'research/astra-prime-difference-compression-plan.md':
  'ee396d22cae90460868ee13ba70c26204cafad190aea3b72835680218b3c88c2',
 'LonelyRunner/FiveAdicFiltering.lean':
  '1a210e70383e9b00d1a3aec321e9e1a838efcd26c24ca180101964e8c6e71429',
 'LonelyRunner/FiveAdicDecomposition.lean':
  '049da0b10b478fe2cdb0a6239ebc97a60317022f15263c317d5aa56415a7357e',
 'LonelyRunner/FiveAdicHardPattern.lean':
  'b6caced5772fb4b33a7bb6d26792aaa49f5287557f3165c862edeaf7d69daeca',
 'LonelyRunner/PivotResidues.lean':
  '362da5ab923f22e900ae7ac821dd4cf4aab91dfe70889987bc9e5a05d19c276a',
 'LonelyRunner/ReverseGrid.lean':
  'f96f1de48140d77d734f873446b6d73707e2182f5d8ba2761524ee604543b391',
 'LonelyRunner/LowerCountSupply.lean':
  '0705291adc53011fb72fc718a7260876512b092741442d6a6cceb4b76eb5ccf4',
 'LonelyRunner/FiveRunnerOrdinary.lean':
  '662d0116f13971bce85e76c503e2f3be4fdc6291ba8113aeda43957e38354ffe',
 'LonelyRunner/BoundedRealReduction.lean':
  '7eae68d2c46041b39c3e18f9a1e105c75680352f8e4b4edf65e0dd2a92becb72',
}
def guards():
    for path, expected in GUARDS.items():
        assert sha256(Path(path).read_bytes()).hexdigest()==expected,path
guards()
assert Path('research/astra-prime-difference-compression-plan.md').stat().st_size==22270

def digit(p,m,z):
    R,P=p**m,p**(m+1)
    assert (z//R)%p==(z%P)//R
    return (z//R)%p

def nat_difference(P,a,b):
    # All inputs here are already natural residues, preserving orientation.
    assert 0<=a<P and 0<=b<P and a+P>=b
    return (a+P-b)%P

triples = [
 ('endpoint',7,2,(295,337,1),1,(294,336),(6,6,0)),
 ('one_collapsed',7,2,(344,8,1),43,(0,7),(0,0,0)),
 ('both_collapsed',7,2,(344,2402,1),1,(0,0),(0,0,0)),
 ('m_zero',7,0,(2,5,5),5,(4,0),(3,4,4)),
 ('negative_anchor',7,2,(-391,-6,-342),1,(294,336),(6,6,0)),
 ('actual_zero',7,2,(-345,-345,-345),1,(0,0),(6,6,6)),
 ('p_two',2,1,(3,2,1),3,(2,1),(0,1,1)),
 ('p_two_m_zero',2,0,(2,1,1),1,(1,0),(0,1,1)),
]
triple_results=[]
for name,p,m,b,lam,expected_diff,expected_q in triples:
    R,P=p**m,p**(m+1)
    assert 0<lam<P and lam%p!=0
    original=[(b[i]-b[2])%P for i in (0,1)]
    assert tuple(original)==expected_diff
    assert original==[nat_difference(P,b[i]%P,b[2]%P) for i in (0,1)]
    transformed=[(lam*(b[i]-b[2]))%P for i in (0,1)]
    assert transformed==[(lam*d)%P for d in original]
    assert all(d==0 or P-R<=d<P for d in transformed)
    qs=[digit(p,m,lam*z) for z in b]
    assert tuple(qs)==expected_q
    assert all(q in {qs[2],(qs[2]-1)%p} for q in qs)
    assert qs==[digit(p,m,lam*(z%P)) for z in b]
    lifts=[0 if d==0 else d-P for d in transformed]
    assert all(-R<=s<=0 for s in lifts)
    Q=(lam*b[2])//R
    assert all((lam*b[2]+s)//R in (Q-1,Q) for s in lifts)
    triple_results.append({'name':name,'lambda':lam,'digits':qs,
        'difference_residues':original,'transformed_differences':transformed,
        'closed_lifts':lifts})

# Fixed diagnostics isolate the publisher step and collapsed/zero distinctions.
assert digit(7,2,294)==6 and digit(7,2,-294)==1
assert (344-1,2402-1)==(7**3,7**4)
assert (344-1)%343==(2402-1)%343==0
assert [43*z%343 for z in (344,8,1)]==[43,1,43]
assert [digit(7,2,z) for z in (1,50,99)]==[0,1,2]
assert [(z-99)%343 for z in (1,50)]==[5*49,6*49]

# Each fixture lists two live decompositions, prescribed targets and lambda.
targets=[
 ('top_then_lower',7,3,3,2,1,3,5,2,1182),
 ('both_below',5,3,2,2,0,3,3,4,396),
 ('swapped_order',3,2,0,4,2,2,2,1,20),
 ('binary_targets',2,1,1,1,0,1,1,1,3),
 ('unreduced_inputs',7,2,2,8,0,400,3,0,199),
]
target_results=[]
for name,p,m,a,u,b,v,tx,ty,expected_lam in targets:
    R,P=p**m,p**(m+1)
    assert a<=m and b<=m and a!=b and u%p and v%p
    assert 0<=tx<p and 0<=ty<p
    assert (a!=m or tx!=0) and (b!=m or ty!=0)
    high,low=sorted([(a,u,tx),(b,v,ty)],reverse=True)
    h,w,t=high
    if h==m:
        A=(t*pow(w%p,-1,p))%p
        assert 0<A<p
    else:
        kh=((t-digit(p,m,p**h*w))*pow(w%p,-1,p))%p
        A=1+kh*p**(m-h)
        assert A%p==1
    high_before=(A*p**h*w)%P
    assert digit(p,m,A*p**h*w)==t
    ell,z,s=low
    assert ell<h and ell<m
    coefficient=(A*z)%p
    k=((s-digit(p,m,A*p**ell*z))*pow(coefficient,-1,p))%p
    H=1+k*p**(m-ell)
    B=H*A
    assert H%p==1 and (B*p**h*w)%P==high_before
    assert B*p**ell*z==A*p**ell*z+k*R*A*z
    lam=B%P
    assert lam==expected_lam and 0<lam<P and lam%p!=0
    x,y=p**a*u,p**b*v
    assert [digit(p,m,lam*x),digit(p,m,lam*y)]==[tx,ty]
    if h<m:
        assert lam%p==1 and (lam*p**(h+1))%P==p**(h+1)%P
    target_results.append({'name':name,'inputs':[x,y],'lambda':lam,
        'targets':[tx,ty],'current_lower_coefficient':coefficient,
        'lower_k':k,'higher_residue_preserved':high_before})

# One wrong-coefficient value is a fixed negative control, not a search.
wrong_B=(1+3*7**2)*6
assert digit(7,3,wrong_B*21)==5 and 5!=2
# A top unit's target cannot be zero; both levels at m=0 cannot be distinct.
assert digit(2,0,1)==1 and digit(2,1,3*2)==1
assert not (0<=0 and 0<=0 and 0!=0)
guards()
out=json.dumps({'status':'FIXED_COMPRESSION_CONTROLS_PASSED',
 'source_guards':len(GUARDS),'successful_triple_fixtures':triple_results,
 'two_target_fixtures':target_results,'equal_level_fixed_digits':[0,1,2],
 'negated_endpoint_digit':1,'wrong_coefficient_digit':5,
 'search_executed':False,'lean_executed':False},sort_keys=True)+'\n'
assert len(out.encode())<32768
print(out,end='')
```

### Actual execution and guarded replay

The pre-execution report had SHA-256
`ffec9635765d61be3452b1ba97efe3a315549a2b2850830839207c6575b5e1c5`.
The sole Python fence is 5,600 bytes including its final newline, SHA-256
`76f290f661060c490a6a86c3c3ea6648cd971914b308cfee670d72acbfcf1c43`.
It has not changed since execution. The first run (terminal chunk `912442`)
exited 0 with empty stderr. Its parent wall time was 0.019417989009525627
seconds; child user/system time was 0.016097/0.003018 seconds and peak RSS
was 16,004 KiB on Linux. The child set all three stated resource limits,
and the parent independently used `subprocess.run(timeout=60)`.

Raw stdout is 2,288 bytes including the final newline, SHA-256
`73a26ab87c3f6e254166f6e9e92843023b48c0646f6a09cc58891bb9307f11a4`:

```json
{"equal_level_fixed_digits": [0, 1, 2], "lean_executed": false, "negated_endpoint_digit": 1, "search_executed": false, "source_guards": 9, "status": "FIXED_COMPRESSION_CONTROLS_PASSED", "successful_triple_fixtures": [{"closed_lifts": [-49, -7], "difference_residues": [294, 336], "digits": [6, 6, 0], "lambda": 1, "name": "endpoint", "transformed_differences": [294, 336]}, {"closed_lifts": [0, -42], "difference_residues": [0, 7], "digits": [0, 0, 0], "lambda": 43, "name": "one_collapsed", "transformed_differences": [0, 301]}, {"closed_lifts": [0, 0], "difference_residues": [0, 0], "digits": [0, 0, 0], "lambda": 1, "name": "both_collapsed", "transformed_differences": [0, 0]}, {"closed_lifts": [-1, 0], "difference_residues": [4, 0], "digits": [3, 4, 4], "lambda": 5, "name": "m_zero", "transformed_differences": [6, 0]}, {"closed_lifts": [-49, -7], "difference_residues": [294, 336], "digits": [6, 6, 0], "lambda": 1, "name": "negative_anchor", "transformed_differences": [294, 336]}, {"closed_lifts": [0, 0], "difference_residues": [0, 0], "digits": [6, 6, 6], "lambda": 1, "name": "actual_zero", "transformed_differences": [0, 0]}, {"closed_lifts": [-2, -1], "difference_residues": [2, 1], "digits": [0, 1, 1], "lambda": 3, "name": "p_two", "transformed_differences": [2, 3]}, {"closed_lifts": [-1, 0], "difference_residues": [1, 0], "digits": [0, 1, 1], "lambda": 1, "name": "p_two_m_zero", "transformed_differences": [1, 0]}], "two_target_fixtures": [{"current_lower_coefficient": 4, "higher_residue_preserved": 1715, "inputs": [686, 21], "lambda": 1182, "lower_k": 4, "name": "top_then_lower", "targets": [5, 2]}, {"current_lower_coefficient": 3, "higher_residue_preserved": 425, "inputs": [50, 3], "lambda": 396, "lower_k": 3, "name": "both_below", "targets": [3, 4]}, {"current_lower_coefficient": 2, "higher_residue_preserved": 9, "inputs": [4, 18], "lambda": 20, "lower_k": 1, "name": "swapped_order", "targets": [2, 1]}, {"current_lower_coefficient": 1, "higher_residue_preserved": 2, "inputs": [2, 1], "lambda": 3, "lower_k": 1, "name": "binary_targets", "targets": [1, 1]}, {"current_lower_coefficient": 3, "higher_residue_preserved": 147, "inputs": [392, 400], "lambda": 199, "lower_k": 6, "name": "unreduced_inputs", "targets": [3, 0]}], "wrong_coefficient_digit": 5}
```

The empty stderr has SHA-256
`e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.
The stdout digest excludes the outer resource receipt. This default Bash
replay is fixed-only and writes no additional file. It extracts and guards
the exact program, checks the frozen stdout, and reports actual resources.
It uses the same child invocation and limits as the original run.

```bash
python3 -B - <<'PY'
from pathlib import Path
from hashlib import sha256
import json,re,resource,subprocess,sys,time
p=Path('research/astra-prime-difference-compression-review.md')
blocks=re.findall(r'^```python\n(.*?)^```[ \t]*$',p.read_text(),re.M|re.S)
assert len(blocks)==1
program=blocks[0]
expected='76f290f661060c490a6a86c3c3ea6648cd971914b308cfee670d72acbfcf1c43'
assert sha256(program.encode()).hexdigest()==expected
retained=p.stat().st_size+Path('research/astra-prime-difference-compression-plan.md').stat().st_size
assert retained<1024*1024
t0=time.monotonic()
try:
    result=subprocess.run([sys.executable,'-B','-'],input=program,
        text=True,capture_output=True,timeout=60)
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
assert sha256(result.stdout.encode()).hexdigest()=='73a26ab87c3f6e254166f6e9e92843023b48c0646f6a09cc58891bb9307f11a4'
assert result.stderr==''
PY
```

The displayed Bash fence, including its final newline, has SHA-256
`5ce52f818fbfb0c01e24e9275cc2baa70acdc31d296b1b8b37581e97ca0ad553`.
It was replayed after assembly (terminal chunk `2f3ed1`): Bash and child
both exited 0 with empty stderr, reproducing the exact frozen child stdout.
The replay measured 0.018973005993757397 parent wall seconds,
0.013812/0.004933 child user/system seconds and 15,908 KiB peak RSS.
Full Bash stdout including the resource receipt has SHA-256
`9ebae82e917638d2e02e955e63ec57a57d2e9a04e293f559f4207f3f15512fc7`.
The source/output hashes and report whitespace passed integrity checks.
Report, frozen author manuscript and retained replay evidence total below
64 KiB, within the 1 MiB cap. All task-owned child processes have stopped;
no additional generated artifact is retained.

## Canonical scope

The live sources agree with the explicit limitation: `H_N` in
`LowerCountSupply.lean:20` supplies every d from 1 through N-2 at its own
margin `1/(d+1)`. `FiveRunnerOrdinary.lean:152` supplies H6, covering d<=4.
`BoundedRealReduction.lean:99` uses H(m+2) for a family of m+1 real runners;
thus its seven-real-runner specialization requires H8, including d=5 at
1/6 and d=6 at 1/7. Compression proves neither. A hypothetical six-moving
natural theorem at 1/7 would still not supply d=5 at its stronger 1/6
margin merely by duplication. No general LRC or new runner-count claim is
accepted by this review.
