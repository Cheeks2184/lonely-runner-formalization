# Ordinary five-runner insertion and finite-certificate planning

2026-09-06. Requested Astra/xhigh author `/root/mixed_equivalence_freeze`;
routing is requested, not independently attested. Owned file: this manuscript
only. Current configuration, workflow, policy and state were read and the
structural validator passed. Source checkpoint:
`a9050d209eacb78dfe32b435d67a7e115819f3e9` (Pass36). Other work is preserved.
No Lean execution, source/state/Git/cache edit, tuple enumeration, certificate
discovery or external research belongs to this task. Unrestricted LRC remains
active and unresolved.

**Recommendation:** the ordinary corollaries are worth formalizing as small
additive analytic filters after review. They lower both mixed buffer height
thresholds by exactly one fifth and strengthen the first-lap region. Direct
ordinary coverage also has the useful H6/canonical bridge described below.
This does not supply the missing finite certificate or justify a large scan.

## Closed ordinary insertion, with every premise explicit

For natural `0<a<b<c<H`, write O(a,b,c,H) for
`∃ t : ℝ, 0<t ∧ ∀ w∈{a,b,c,H}, 1/5 ≤ circleNorm(t*w)`.
No strict ordinary witness, primitive condition or unproved lower-count
hypothesis is assumed in the following sufficient criteria.

The existing `fourRunnerMixed_iff` gives a positive seed with lower margins
`(1/4,1/4,1/3)` unless `b=2a ∧ c=3a`. In that exception the already formal
`fiveRunnerMixed_exceptional a H` applies for every `0<a` and `3a<H`; its
fastest quarter weakens to a fifth. In particular, no divisible-height,
coprimality or normalization condition may be appended to this exception.
Its source proof handles arbitrary a,H by their common gcd. The exceptional
branch should be discharged before asking for the stronger lower seed.

For the nonexceptional branch, use `bufferedRunnerInsertion` at δ=β=1/5.
The old-speed slacks are `1/20,1/20,2/15`, all strictly positive. For any
same endpoint owner w≤c<H, the required width inequality is

```
2/(5H) ≤ 3/(5w), equivalently 2w ≤ 3H,
```

which is automatic. For distinct owners (a,b) and (b,c), the requirements are

```
2/(5H) ≤ 1/(20a)+1/(20b)   iff   8ab ≤ H(a+b),
2/(5H) ≤ 1/(20b)+2/(15c)   iff   24bc ≤ H(3c+8b).       (B)
```

The (a,c) right side is greater than the (b,c) right side because a<b.
Reversing the owner order preserves its sum, so these cases cover all ordered
distinct pairs. All denominators are positive. The generic theorem supplies
one positive time preserving the three old fifths and giving the fourth
fifth. Its finite floor-band proof retains equality, including endpoint ties;
no positive-width or strict-witness hypothesis is imported into O.
Thus (B) proves O for every stated quadruple, including the exception.

The sufficient coarse condition is

```
16b ≤ 3H.                                               (C)
```

Indeed `8ab/(a+b)<4b≤H`. Also `16bc≤3Hc` and `8bc<8Hb`, whose sum gives
`24bc≤H(3c+8b)`. Equality in (C) is allowed. These are the same source
mechanisms used in `fiveRunnerMixed_of_buffer_inequalities` and its coarse
corollary, with the new runner's target changed from 1/4 to 1/5.

For comparison, a uniform all-quarter lower seed gives the ordinary harmonic
test `8bc≤H(b+c)`, stronger than the basic insertion condition `4c≤H`.
Both thresholds in (B) are strictly smaller than `8bc/(b+c)` when a<b<c:
the first follows by monotonicity in the smaller speed, and the second from
`3(b+c)<3c+8b`. The special lower exception is already covered outright.
These are improvements between sufficient tests, not new ordinary existence
for rows that were otherwise known to have no witness.

A useful interpolation, optional to formalize, is β∈[1/5,1/4]. The same seed
gives three old fifths and new margin β if
`40βab≤H(a+b)` and `120βbc≤H(3c+8b)`; same-owner width remains automatic
because β≤1/4. The exception is covered by its quarter witness. A sufficient
coarse condition is `(120β-8)b≤3H`: it implies `20βb≤H` since β≥2/15,
and the second pair inequality follows by adding `8bc≤8Hb`. This explains
the coefficients (8,24,16) for ordinary and (10,30,22) for mixed without
asserting that these tests give the actual maximal attainable margin.

## First-lap correction and planned public contracts

The common first-lap ordinary band is exactly
`[1/(5a),4/(5H)]`; it is nonempty iff

```
H ≤ 4a.                                                 (F)
```

At `t=1/(5a)>0`, every phase lies in `[1/5,4/5]`, so O holds, including
H=4a. The initially proposed `H≤5a` does not justify that witness: at H=5a
the fastest phase is 1 and its norm is zero. This refutes the proposed-time
argument, not ordinary existence for such a tuple. Mixed first-lap coverage
instead requires `4H≤15a`, as in the accepted design.

Suggested additive declarations use an ordinary analogue of `FiveRunnerMixed`
with all four inverse-fifth comparisons and one positive existential time:

```
FiveRunnerOrdinary a b c H : Prop
fiveRunnerOrdinary_of_mixed : FiveRunnerMixed a b c H → FiveRunnerOrdinary a b c H
fiveRunnerOrdinary_of_buffer_inequalities
  (ha : 0<a) (hab : a<b) (hbc : b<c) (hcH : c<H)
  (hAB : 8*a*b ≤ H*(a+b)) (hBC : 24*b*c ≤ H*(3*c+8*b)) :
  FiveRunnerOrdinary a b c H
fiveRunnerOrdinary_of_three_mul_height_ge
  (ha : 0<a) (hab : a<b) (hbc : b<c) (hcH : c<H)
  (hheight : 16*b ≤ 3*H) : FiveRunnerOrdinary a b c H
fiveRunnerOrdinary_of_first_lap
  (ha : 0<a) (hab : a<b) (hbc : b<c) (hcH : c<H)
  (hfirst : H ≤ 4*a) : FiveRunnerOrdinary a b c H
```

These are proposed contracts, not new kernel declarations. Reuse the generic
buffer theorem and existing exception directly; do not duplicate its endpoint
construction. The first-lap proof only needs `circleNorm_ge_of_int_band` at
integer band zero. Rational-margin box leaves can specialize the current
`rationalMarginRowOK` to num=(1,1,1,1), den=(5,5,5,5).

## Exact counts from one-index arithmetic sums

These counts concern **all** natural ordered quadruples `0<a<b<c<H≤1000`,
before any gcd, direct-divisor, deletion-gcd, exception or determinant filter.
For each H≥4 put `L=ceil(H/4)` and `K=floor(3H/16)`. First-lap rows have
a≥L, giving `choose(H-L,3)` choices. Coarse-buffer rows have b≤K, giving

```
sum_{b=2}^K (b-1)(H-1-b) = K(K-1)(3H-2K-5)/6.
```

This identity follows from the sums of b and b², and includes K=0,1 with
value zero. Since `L>K`, the two covered regions are disjoint: a≥L and
b≤K cannot hold with a<b. Consequently their exact complement is

```
R_O = sum_{H=4}^{1000} [choose(H-1,3)-choose(H-ceil(H/4),3)
                       -K(K-1)(3H-2K-5)/6], K=floor(3H/16).   (G_O)
```

The corresponding accepted mixed sum uses `L=ceil(4H/15)` and
`K=floor(3H/22)`, and equals 23,010,550,937. Both ordinary sufficient regions
contain their corresponding mixed regions. Thus `R_O≤R_M`, and their exact
difference counts rows newly removed by these two ordinary parameter tests.
It does not count tuples with M false or tuples not already covered by some
other ordinary theorem. No value for the fully combined residual is inferred.

The sole reproducer below evaluates these one-index sums and the five fixed
fixtures named in it. It performs no quadruple enumeration. Exact results:

| Domain at H≤1000, before all other filters | Ordinary | Mixed |
|---|---:|---:|
| All positive increasing quadruples | 41,417,124,750 | 41,417,124,750 |
| First-lap sufficient region | 17,484,593,500 | 16,333,614,388 |
| Coarse-buffer sufficient region | 3,792,202,720 | 2,072,959,425 |
| Complement of those two disjoint regions | 20,140,328,530 | 23,010,550,937 |

The ordinary tests remove 2,870,222,407 additional rows. This is a material
improvement to these particular filters, but not evidence of an affordable
flat certificate or of the size of the fully filtered region. A structural
compression argument and a resource-bounded demonstration remain necessary.

## Finite ordinary target and canonical benefit

For a general quadruple divide by its positive common gcd G. Ordering,
positivity and the ordinary property are preserved, using time multiplication
by G in one direction and division by G in the other. The proved H5 is
`lowerCountPositiveIntegerHypothesis_five`. Apply the ordinary projection
`primitive_sorted_largeHeight_stationary_lonelyAt` at m=3 to `(0,a,b,c,H)`:
it covers normalized H>choose(5,2)^3=1000. A complete positive stationary
ordinary certificate for every primitive H≤1000 would therefore give all
positive distinct natural four-moving rows. Equality H=1000 stays finite.

Sorting with `exists_strictMono_reindex` then supplies arbitrary `Fin 4`
labels. Combine its own fifth margin with H5 for d=1,2,3 to construct
`LowerCountPositiveIntegerHypothesis 6` (d ranges through 4). Only then call
the existing `lonelyAt_of_lowerCount (m:=4)` to obtain

```
∀ speeds : Fin 5 → ℝ, Function.Injective speeds →
  ∀ runner : Fin 5, ∃ t : ℝ, LonelyAt speeds runner t.
```

The bounded real bridge already handles relative signs, repeated magnitudes
and their reduced counts. No all-dimensional `PositiveIntegerConjecture`
premise is required. A stationary certificate should not be silently replaced
by an all-chosen-label finite contract. This future composition gives ordinary
five-total-runner LRC only, not unrestricted LRC.

O leaves also admit existing complete ordinary pair-sum certificates via
`exists_witness_iff_pairSumCertificate`, in addition to rational endpoint
and box witnesses. K5 permits not-strict-ordinary leaves that provide no O
witness; hence K5 alone does not complete this ordinary bridge. Ordinary
targeting removes the fastest-quarter requirement, but also requires positive
O coverage on every finite row, including those without a strict point.
Closed O and K5 are therefore not interchangeable targets.

The next justified action is the small corollary implementation above, followed
by a reviewed compression proposal using the generic box checker. A smaller
geometric count does not make billions of rows suitable for direct kernel
enumeration, establish a small partition, or authorize certificate discovery.

## Source guards and fixed arithmetic reproducer

These hashes bind the source declarations and accepted design actually used.
The code loops over H=4,...,1000 to evaluate each of the two proven count
formulas; the only evaluated quadruples are the five explicitly named fixtures.
They compare sufficient tests and supplied rational times, never global M
absence. The false first-lap proposal has a successful mixed time as a control.

```python
from fractions import Fraction as Q
from hashlib import sha256
from math import comb
from pathlib import Path

guards = {
    'LonelyRunner/BufferedRunnerInsertion.lean':
        'a135f5c41ead308a2a4250f07535bf3e32f78c88599497bf79bb632cd1e05f0a',
    'LonelyRunner/FiveRunnerBuffered.lean':
        '70f690a2300e122da3e9646e48d2f4e9c6af630c16da89d403e8508cb16b6d04',
    'LonelyRunner/FiveRunnerMixed.lean':
        '1e27f19d8906ee0d71b452758a38a7c44fff54e0b1b3c1e08dd5354921eb1eb0',
    'LonelyRunner/FourRunnerMixed.lean':
        'ae47b419c5b4cebfa72a325bdb50cd32e03444c39850a74b885037d83e312a5c',
    'LonelyRunner/FourRunnerOrdinary.lean':
        '2fb2f5c9c0742daa3278ee0ddeacd8643e1e22f8c885de95f5f38e10734b29f6',
    'LonelyRunner/FiniteHeightReduction.lean':
        'cb41059260b943411e2ab5360b84b59cd13f2ddf352c3c50a0b3715b9b9987d6',
    'LonelyRunner/LowerCountSupply.lean':
        '0705291adc53011fb72fc718a7260876512b092741442d6a6cceb4b76eb5ccf4',
    'LonelyRunner/BoundedRealReduction.lean':
        '7eae68d2c46041b39c3e18f9a1e105c75680352f8e4b4edf65e0dd2a92becb72',
    'LonelyRunner/FiniteTupleSorting.lean':
        '71b47c20282d091129fe9990b2d1bbdfdebff45e49dea2bfbd7d4425fe89f775',
    'LonelyRunner/PairSumCompleteness.lean':
        '838a3bcec806b0e9d01cd117e64e5348de58a05127a3f7bef5dbe2d879ff292f',
    'LonelyRunner/RationalMarginCertificates.lean':
        'ffe31ce9636281f6c4b8fc2cdf618043a6c02b0195bf75ff6e0aee65c317c1d9',
    'research/astra-five-runner-certificate-design.md':
        'cc7990790d3ca8ddd50d36dc64d80af74b1f82d45b64ba20e31fbbc0b78fc403',
    'research/astra-five-runner-certificate-design-review.md':
        'c86e42c2ed14c015f83776644469827a850614fc6fbdd5c55a96ce61c8b12b40',
}
for path, expected in guards.items():
    assert sha256(Path(path).read_bytes()).hexdigest() == expected, path

def count(first_num, first_den, coarse_den):
    total = first = coarse = 0
    for H in range(4,1001):
        L = (first_num*H + first_den-1)//first_den
        K = (3*H)//coarse_den
        assert 0 <= K < L <= H
        numerator = K*(K-1)*(3*H-2*K-5)
        assert numerator % 6 == 0
        covered_first = comb(H-L,3) if H-L >= 3 else 0
        covered_coarse = numerator//6
        rows = comb(H-1,3)
        assert covered_first + covered_coarse <= rows
        total += rows
        first += covered_first
        coarse += covered_coarse
    return total,first,coarse,total-first-coarse

ordinary = count(1,4,16)
mixed = count(4,15,22)
assert ordinary[0] == mixed[0] == comb(1000,4) == 41417124750
assert mixed[3] == 23010550937
assert ordinary[1] >= mixed[1] and ordinary[2] >= mixed[2]

def norm(x):
    r = x % 1
    return min(r,1-r)

def buffer(w,beta):
    a,b,c,H = w
    assert 0 < a < b < c < H
    return 40*beta*a*b <= H*(a+b) and 120*beta*b*c <= H*(3*c+8*b)

fixtures = [
    ('first_lap_equality',(4,5,9,16),Q(1,20)),
    ('ab_equality',(3,5,7,15),Q(1,12)),
    ('bc_equality',(9,10,40,48),Q(1,30)),
    ('coarse_equality',(2,3,7,16),Q(1,10)),
    ('rejected_first_lap_time',(4,5,9,20),Q(1,20)),
]
for name,w,t in fixtures:
    a,b,c,H = w
    assert 0 < a < b < c < H and t > 0
    distances = tuple(norm(t*x) for x in w)
    if name == 'rejected_first_lap_time':
        assert H == 5*a and distances[-1] == 0
        alternative = tuple(norm(Q(1,12)*x) for x in w)
        assert min(alternative[:3]) >= Q(1,5) and alternative[-1] >= Q(1,4)
    else:
        assert min(distances) >= Q(1,5)
    if name == 'first_lap_equality':
        assert H == 4*a and 15*a < 4*H and 3*H < 22*b
        assert not buffer(w,Q(1,5)) and not buffer(w,Q(1,4))
    if name == 'ab_equality':
        assert 8*a*b == H*(a+b) and buffer(w,Q(1,5)) and not buffer(w,Q(1,4))
    if name == 'bc_equality':
        assert 24*b*c == H*(3*c+8*b) and buffer(w,Q(1,5)) and not buffer(w,Q(1,4))
    if name == 'coarse_equality':
        assert 16*b == 3*H and 3*H < 22*b and buffer(w,Q(1,5))

print('source_guards=13 passed; named_quadruple_controls=5 passed')
print('columns=total,first_lap,coarse_buffer,residual')
print('ordinary=' + str(ordinary))
print('mixed=' + str(mixed))
print('additional_parameter_coverage=' + str(mixed[3]-ordinary[3]))
print('height_domain=4..1000; tuple_enumeration=none; Lean_execution=none')
```

Replay in memory from the repository root:

```sh
python3 -B - <<'PY'
from contextlib import redirect_stdout
from hashlib import sha256
from io import StringIO
from pathlib import Path
s = Path('research/astra-five-runner-ordinary-insertion-plan.md').read_text()
assert s.count('```python\n') == 1
program = s.split('```python\n',1)[1].split('```',1)[0]
out = StringIO()
with redirect_stdout(out):
    exec(compile(program, '<ordinary-insertion-fixed-controls>', 'exec'), {})
print(out.getvalue(), end='')
print('program_sha256=' + sha256(program.encode()).hexdigest())
print('stdout_sha256=' + sha256(out.getvalue().encode()).hexdigest())
PY
```

The exact command completed with exit 0. All thirteen source guards, both
997-height arithmetic sums, and five fixed quadruple controls passed.
Program SHA-256:
`4d14debe65c2eacfdd19c6a648a1be6af87c887d2e044a8fe095c1e9c2b1a7ba`.
Captured stdout SHA-256:
`53297f4758ec9d857cbc44edb68a18347dc8334fc67e39996a2fafd93bef7854`.
Program bytes are the sole Python fence contents including their final
newline; stdout is its six printed result lines, excluding the hash reports.
`python3 -B scripts/validate_workflow.py` passed as a structural check only.
All commands have stopped. No Lean, cache-dependent or discovery process was
started or queued by this task; no pilot resource measurements are claimed.

Frozen author conclusion: formalize the corrected first-lap and two ordinary
buffer corollaries as useful small supporting lemmas. Prefer a positive
ordinary finite certificate over a comparably costly K5 certificate when the
aim is the canonical five-total-runner theorem. Neither complete finite
coverage nor its manageable compressed representation has been obtained here.
