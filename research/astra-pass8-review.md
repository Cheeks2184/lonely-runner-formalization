# Independent pass 8 review of the compact union obstruction

Status: **accepted**, 2026-09-05. The frozen compact manuscript, its exact
linear table checker, and the final contradictions are independently accepted
as a manuscript obstruction to the stated coarse union. This is not a Lean
kernel theorem or an LRC disproof.

Reviewer `/root/vanishing_slope`, requested in-session Astra xhigh, independent
of the manuscript author. Observed runtime model/effort metadata is unavailable.
The current project configuration, workflow, policy, and state were read;
`python3 scripts/validate_workflow.py` passed. Source checkpoint supplied by
the parent is `7ac9e1f5cb711cf794f9524af31cc8460459bfab`. Only this note is
reviewer-owned. No Lean cache restoration, source edits, or Git actions occur.

The reviewed target is the all-modulus A/B/R obstruction for `N=7` and the
speed set `{2,3,4,7,9,14}`. The order used in this note is
`V=(2,3,4,7,9,14)`; permutations do not affect any predicate. This review
does not assume the pass 7 computational answer as a proof premise.

Final source binding, read in full after author freeze:

```text
research/astra-union-obstruction.md
  3e6a7dc493a649ce786fe49d0ec8d94dd7555c75a11c21da6cbd8253e9238578
scripts/grid_normalization_decision.py (unchanged motivating engine)
  393cdc38eee2fdead8a3ef47bdad599917a5319e407d768b197c5997ffd8e5d1
```

No correction was required. The author's five-row lookup, grouped core
table, rational derivations, subsequent floor ranges, endpoint handling,
and short A/B proof agree with the independent derivation below. Its
192-case checker passed separately from this review's larger linear replay.

## 1. Independent reductions and endpoint audit

For an external modulus `M>=2` and a unit `1<=c<M`, put `x=c/M`.
Replacing `c` by `M-c` and reversing every independently chosen sign
preserves the actual signed residues. Therefore reflection reduces A/R to
`0<x<=1/2`. Equality requires the reduced pair `(c,M)=(1,2)`; the speed 2
then has residue zero, excluding A/R. More generally, every velocity
breakpoint `v*x in Z` gives a zero residue for that row under both signs
and is excluded. B requires separate treatment and cannot be discarded
by the open-cell reduction.

Write `(u,m)=(c mod 7,M mod 7)`. The pair cannot be `(0,0)` because
`gcd(c,M)=1`. Multiplying both classes by a nonzero field element preserves
each zero/nonzero signed-slope test. Hence the eight projective classes
are `(kappa,1)`, `kappa=0,...,6`, and `(1,0)` denoted infinity. This is a
reduction of zero tests, not an assertion that the reduced fraction itself
can be rescaled while preserving coprimality. In the finite class,

```text
q=floor(v*x),
positive option f=v*x-q:        zero iff v*kappa-q == 0 mod 7,
negative option f=q+1-v*x:      zero iff q+1-v*kappa == 0 mod 7.
```

For infinity both signs are zero exactly when `7|v`. In particular the
case `7|M` is present. Reflection maps finite `kappa` to `1-kappa` and
infinity to infinity, while reversing signs. This preserves every actual
base; it is stronger than merely preserving a count of zero rows.

Normalize the R minimum and maximum zero bases to `lambda=L/M` and
`eta=H/M`. Its exact zero inequality is

```text
eta*(1+7*lambda) <= 6*lambda,       eta >= lambda > 0.
```

Cancellation gives `lambda<=5/7`. Both rational functions
`6*lambda/(1+7*lambda)` and `lambda/(1+7*lambda)` increase for positive
`lambda`. Consequently every selected zero value is at most `5/7`, and
every ordinary value is at most `5/42`. Ordinary values are strictly less
than every zero value, and every zero is strictly less than six times
every other zero. These are necessary linear inequalities; the relaxation
keeps the individual caps closed and the two ordering comparisons strict.
It introduces no unproved equivalence to R.

## 2. Independent compact calculation

The three core speeds `2,3,4` divide `(0,1/2)` into exactly three open
cells: `(0,1/4)`, `(1/4,1/3)`, and `(1/3,1/2)`. Checking two signs per
row in all eight classes gives `3*8*8=192` cases. Using only each row's
zero/ordinary cap gives the following complete table. `+++` refers to
the ordered core `(2,3,4)`; the zero column lists actual speeds.

| Class | Signs | Zero speeds | Surviving interval |
| --- | --- | --- | --- |
| 0 | `+++` | 2,3,4 | `(0,5/28]` |
| 0 | `++-` | 2,3 | `[37/168,5/21]` |
| 1,2,6,infinity | `+++` | none | `(0,5/168]` |
| 3 | `+++` | none | `(0,5/168]` |
| 3 | `---` | 3 | `[79/168,1/2)` |
| 4 | `+++` | none | `(0,5/168]` |
| 4 | `---` | 2,4 | `[9/28,1/3)` |
| 4 | `-+-` | 2,4 | `(1/3,47/126]` |
| 5 | `+++` | none | `(0,5/168]` |
| 5 | `-+-` | 3 | `[79/168,1/2)` |

For nonzero finite classes, the extra intervals are eliminated by speed 7:
on the near-1/2 intervals `q_7=3` and both ordinary signed values are
at least `7/24`; on the class-4 middle intervals `q_7=2` and both are at
least `1/4`. Both lower bounds exceed `5/42`. Infinity has no extra core
interval. In the remaining `0<x<=5/168` interval, speed 7 is forced to
the zero value `7*x`: its negative option exceeds even `5/7`.
Speed 9 is forced to the positive ordinary value `9*x`. Its negative
option exceeds `5/7` throughout, so even its possible zero status in
class 4 cannot rescue it. Ordinary `9*x` cannot be below zero `7*x`.
This excludes every nonzero finite class and infinity.

In class 0, the extra core interval `[37/168,5/21]` has `q_7=1`;
both speed-7 options are ordinary and at least `1/3`, so it is excluded.
For the main core interval `(0,5/28]`, all three core values are the
positive zero values `2*x,3*x,4*x`. The speed-7 individual caps leave

```text
(0,5/49]                     with zero 7*x,
[37/294,1/7)                 with ordinary 1-7*x,
(1/7,47/294]                 with ordinary 7*x-1.
```

On the latter two intervals `q_9=1`; its two ordinary options violate
the cap: the positive option would require `x<=47/378<37/294`, while
the negative would require `x>=79/378>47/294`. On `(0,5/49]`, speed 9
leaves either `(0,5/63]` with zero `9*x`, or
`[37/378,5/49]` with ordinary `1-9*x`. The latter interval has `q_14=1`
and both speed-14 options exceed `5/42`, so it is excluded.

On `(0,5/63]`, adding speed 14 leaves exactly:

* `(0,5/98]`, all six positive values zero. Here `H/L=14/2=7>6`.
* `[37/588,1/14)`, zeros `2*x,3*x,4*x,7*x,9*x` and ordinary `1-14*x`.
* `(1/14,5/63]`, the same zeros and ordinary `14*x-1`.

The two latter intervals have `L/M=2*x` and `H/M=9*x`. The genuine
quadratic R inequality becomes

```text
9*x*(1+14*x) <= 12*x,
126*x^2 <= 3*x,
x <= 1/42.
```

Both intervals have `x>=37/588>1/42`. All interval endpoints and strict
velocity exclusions have been retained, so this contradiction also covers
the allowed equality boundaries.

## 3. Independent A and B exclusions

A can be excluded using only speeds `2,3,7`. After reflection, the speed-2
condition `||2*x||<1/6` gives `x<1/12` or `x>5/12`. In the latter
range, `3*x` lies between `5/4` and `3/2`, contradicting the speed-3
condition. In the former range, `||3*x||=3*x`, so `x<1/18`. Therefore
`7*x<7/18<1/2`, and the least absolute speed-7 residue is exactly `7*c`
for the reflected unit. It is divisible by 7, contrary to A.

The only B pivots not divisible by 7 are `2,3,4,9`; their nontrivial
divisor union is exactly `{2,3,4,9}`. Modulus 2 always leaves an additional
even nonpivot with zero residue; modulus 3 always leaves an additional
multiple of 3. At modulus 4 the nonpivot speed 2 has absolute residue 2
for every unit, violating `6*d<M`. At modulus 9 the nonpivot speed 3
has absolute residue 3 for every unit, again violating that bound. This
is a complete all-modulus B argument, not a scan cutoff.

## 4. Separate full linear replay

This standard-library-only reproducer independently checks all 24 full
velocity cells, eight projective classes and 64 sign choices, retaining
closed caps and strict comparisons. It does not import the pass 7 engine
or the author's compact checker. Unlike the compact proof, it deliberately
does not reduce by reflection or by the three-speed core table. Its four
survivors therefore check both reductions independently.

```python
# BEGIN INDEPENDENT LINEAR REPLAY
from fractions import Fraction as F
from itertools import product

def clip(interval, a, b, strict=False):
    lo, hi, lc, hc = interval
    if not a:
        return interval if b > 0 or b == 0 and not strict else None
    cut = -F(b, a)
    if a > 0:
        if cut > lo:
            lo, lc = cut, not strict
        elif cut == lo:
            lc = lc and not strict
    else:
        if cut < hi:
            hi, hc = cut, not strict
        elif cut == hi:
            hc = hc and not strict
    return (lo, hi, lc, hc) if lo < hi or lo == hi and lc and hc else None

V = (2,3,4,7,9,14)
T = sorted({F(0), F(1)} | {F(j,v) for v in V for j in range(1,v)})
checked, survivors = 0, []
for left, right in zip(T,T[1:]):
    sample = (left+right)/2
    for u,m in [(i,1) for i in range(7)] + [(1,0)]:
        for signs in product((1,-1), repeat=len(V)):
            checked += 1
            rows, interval = [], (left,right,False,False)
            for v,e in zip(V,signs):
                q = (v*sample).__floor__()
                a,b = (v,-q) if e == 1 else (-v,q+1)
                zero = (a*u+b*m) % 7 == 0
                rows.append((a,b,zero))
                cap = F(5,7) if zero else F(5,42)
                interval = clip(interval,-a,cap-b)
                if interval is None:
                    break
            if interval is None or not any(z for a,b,z in rows):
                continue
            for a,b,z in rows:
                for c,d,w in rows:
                    if not w:
                        continue
                    interval = clip(interval,6*c-a,6*d-b,True) if z else clip(interval,c-a,d-b,True)
                    if interval is None:
                        break
                if interval is None:
                    break
            if interval is not None:
                zeros = tuple(v for v,(_,_,z) in zip(V,rows) if z)
                survivors.append(((u,m), signs, zeros, interval))
assert checked == 12288
Z = (2,3,4,7,9)
assert survivors == [
    ((0,1),(1,1,1,1,1,-1),Z,(F(37,588),F(1,14),True,False)),
    ((0,1),(1,1,1,1,1,1),Z,(F(1,14),F(5,63),False,True)),
    ((1,1),(-1,-1,-1,-1,-1,-1),Z,(F(58,63),F(13,14),True,False)),
    ((1,1),(-1,-1,-1,-1,-1,1),Z,(F(13,14),F(551,588),False,True))]
assert F(1,42) < F(37,588)
print({'cases':checked,'survivors':survivors})
# END INDEPENDENT LINEAR REPLAY
```

## 5. Scope and exact-band control

The claimed failure concerns these coarse normalization contracts, not all
affine grids. In the original parent order `(2,3,4,7,14,9)`, choose
`M=35,b=1,s=1,r=2,r0=0,beta=14`, with actual speeds equal to the bases.
Then `7*r=M*r0+beta`, and the common time is `1/7+2/35=1/5`.
For residues `h=v mod 7`, the combined numerators `h*M+v*beta` are
`(98,147,196,98,196,196)`, each in the closed band `[35,210]`.
All bases are below 35. This meets the generic combined-band arithmetic
contract even though its corrections violate the coarse ordinary bounds.
The minimum actual circle distance is `1/5>1/7`.

No kernel proof of the obstruction, universal supply theorem, or resolution
of LRC is claimed. The accepted union equivalence supplies the connection
from the residue predicates to every permitted modular unit, lift, sign,
and permutation, including coarse C as the singleton-zero R case. The
present R argument excludes the residue conditions before using actual
offset restrictions; dropping those restrictions makes its negative
conclusion stronger, without introducing an assumed offset relation.

## 6. Verification and disposition

Verification completed after the author's final freeze:

* Read the final manuscript and every line of its compact checker. The
  checker exhausts the three core cells, eight projective classes and
  eight signs; it proves containment in a rational enclosure. Every point
  in those enclosures is then removed by the stated elementary inequalities.
* Executed its embedded Python block: all 192 core cases, the strict
  witness, and the exact-band escape passed.
* Executed the independent block in Section 4: exactly four surviving
  linear assignments among all 12,288 cases, with the claimed closed/open
  endpoints and reflection pairing. The last quadratic inequality rejects
  their entire real intervals, so no density, isolated-rational, or
  isolated-irrational issue remains in this fixed-tuple proof.
* Independently checked 13,824 row cases over all 24 velocity cells, all
  48 original nonzero arithmetic class pairs, six speeds and two signs.
  Normalization to the eight projective classes preserved zero flags;
  reflection preserved both flags and the exact normalized residue values.
  This uses the identity `floor(v*(1-x))=v-floor(v*x)-1` away from the
  already-excluded velocity boundaries.
* Checked the exact-band numerators and actual minimum circle distance
  directly with `Fraction`, and ran the workflow structural validator.
  No Lean source changed, so no Lean build or cache restoration was needed.

The author checker can be reproduced by extracting the sole Python fenced
block from `research/astra-union-obstruction.md` and executing it. The
independent replay can be reproduced by extracting between
`# BEGIN INDEPENDENT LINEAR REPLAY` and `# END INDEPENDENT LINEAR REPLAY`
in this note. Both use only standard-library integer/Fraction arithmetic.

Final disposition: accept the compact proof of an all-modulus obstruction
to A/B/coarse-C/R for this tuple. Keep its manuscript status distinct from
the accepted pass 7 computational engine result and from any later Lean
formalization. The unrestricted normalization replacement and canonical
LRC proof/disproof remain unresolved. Only this review note was edited by
the reviewer; no process remains running at handoff.
