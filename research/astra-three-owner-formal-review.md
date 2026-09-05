# Independent formal review: three lower owners at denominator seven

Task `/root/affine_grid-three-owner-formal-review`, requested Astra/xhigh,
2026-09-05. Base checkpoint reported by root:
`a25799bfbbb41b4c31f222b25060a4d6e0e5d117`.
The current workflow, policy, and active research state were read and
`python3 scripts/validate_workflow.py` passed. This worker edited only this
review note; no source, Git, state, root imports, or cache was changed.

**ACCEPT without correction**, bound to both complete frozen artifacts:

```text
8f65dc593228a1e639b7997746987c75b4312b18b4fcd591fd47d701714c7645  LonelyRunner/ThreeLowerOwnerSeven.lean
7141c0f8c20d79bd35e2fe11454662b221d7185d04af169712359614aec1a7d4  research/astra-three-owner-formalization.md
```

I read all 293 source lines and the entire author note. I authored the earlier
mathematical draft, which received a separate independent manuscript review;
I did not implement or edit this Lean source. This is independent review of
the formal implementation, not a claim of independence from the original
mathematical derivation.

## 1. Exact public scope

The source exports two theorems in `namespace LonelyRunner`:

```text
threeLowerOwner_noncover_seven
threeLowerOwner_circleNorm_witness_seven
```

Both quantify over arbitrary natural `p,a,b,c` with exactly
`0<a`, `a<b`, `b<c`, and `c<p`. These imply `p>=4`; there is no additional
height limit, primality condition on p, coprimality, zero-kernel exclusion,
supplied witness, or probabilistic premise.

The first concludes that a residue in `pivotCandidates 7 p` avoids all three
literal sets `pivotBadResidues 7 p a`, `... b`, and `... c`. The second returns
a residue in the same candidate row and the four closed inequalities

```text
1/7 <= circleNorm((r/(7*p))*d),       d=p,a,b,c.
```

The time and pivot are retained. The denominator is `7*p`, with the natural
product cast to the reals, and the target is the real inverse of seven.
These statements protect **three lower speeds and their pivot**, not six
arbitrary moving speeds. No theorem of the unrestricted canonical conjecture
or its negation is supplied.

The underlying definitions were checked directly: candidates satisfy
`0<=r<7p` and `7` does not divide `r`; badness is
`min((r*d)%(7p),7p-(r*d)%(7p)) < p`. Thus equality at p is safe. The existing
real adapters divide this exact inequality by the positive modulus, while
candidate membership protects the original pivot speed p. There is no
off-grid perturbation, independent speed replacement, or changed threshold.

## 2. Proof and quantifier audit

For each genuine lower owner d, `seven_normalize` takes `h=gcd(d,p)` and
`P=p/h`, `D=d/h`. It proves `h>0`, `0<D<P`, `Coprime D P`, `p=hP`, `d=hD`,
and `gcd(D,7)` equal to 1 or 7. The existing normalized cardinality adapter
is applied with **h equal to the actual gcd**, not merely an arbitrary common
factor. Every required positivity and lower-owner premise is supplied.

The accepted scalar helpers give `4|B_d|<=9p` for every lower owner and
`|B_d|<=2p` unless `8d=7p`. In the kernel-seven case, `D>=7` and `P>=8`;
P=8 forces D=7. Consequently the exceptional owner, when it exists, is
uniquely the speed `s=7p/8`.

For any different owner d, the source proves

```text
8*|B_d \ B_s| < 15*p.                                  (1)
```

Kernel-one rows use the raw bound `7|B_d|<=12p`, which is strictly stronger
than the required remainder estimate. Kernel-seven rows use the raw strict
scalar bound except at P=9,15,16,22. P=8 would force d=s and is correctly
excluded using the original speed inequality.

The exceptional reductions are exhaustive:

| P | Allowed D after coprimality | Factor forced by `8s=7hP` | Base `(p,d,s)` |
| ---: | --- | --- | --- |
| 9 | 7 | `8 divides h` | (72,56,63) |
| 15 | 7,14 | `8 divides h` | (120,56,105), (120,112,105) |
| 16 | 7 | none | (16,7,14) |
| 22 | 7,21 | `4 divides h` | (88,28,77), (88,84,77) |

For P=16 and P=22, D=14 is excluded by the explicitly available normalized
coprimality. The stated factors follow from the star equation, so no
divisibility premise has been silently added to the public statement. Each
resulting scale t is positive because h is positive.

The key private scaling identity is exact for every positive p,t:

```text
|B(7,tp,td) \ B(7,tp,ts)| = t*|B(7,p,d) \ B(7,p,s)|.    (2)
```

It uses the existing membership equivalence under common scaling and
reduction modulo `7p`, including its explicit upper-range conjunct. The
literal difference becomes a filter of `range(t*(7p))` with predicate
`r%(7p) in S`, where `S=B_d\B_s` lies in `range(7p)`.
`card_filter_range_mod_mem` then counts all t copies. This is the complete-
range helper, **not** the candidate-period helper requiring a coprime period.
The period here is `7p` and need not be coprime to seven. In particular (2)
remains valid when `7 divides p` or `7 divides t`.

The six base differences have exact cardinalities

```text
90, 150, 150, 12, 102, 102,
```

in table order. The source proves their sufficient strict bounds using
kernel `decide`; (2) lifts each finite calculation to every required height.
It does not extrapolate a finite search to an unrestricted statement.

If a star is present, the union is bounded by the star plus two remainders.
The star costs at most `9p/4`; each remainder costs strictly less than
`15p/8`. Their total is strictly below `6p`. All three possible positions of
the star in the ordered input are handled by explicit union rearrangements.
If no star is present, the three raw counts are at most `2p` each, and
candidate 1 belongs to the first two bad sets because both speeds are
strictly below p. This one common point already makes the union smaller
than `6p`; the proof does not need the manuscript's stronger common-pair
correction. Since the entire union is a subset of the `6p` candidates, its
complement is nonempty. No owner is dropped from that complement.

## 3. Independent kernel checks

Fresh direct compilation passed with exit 0 and no diagnostics:

```sh
PATH="$HOME/.elan/bin:$PATH" lake env lean LonelyRunner/ThreeLowerOwnerSeven.lean
```

I then sent the **entire source text**, followed by the block below, to
`PATH="$HOME/.elan/bin:$PATH" lake env lean --stdin`. This separately replayed
the source proof rather than relying only on an imported compiled module.
Both exact public types matched Section 1. Each theorem printed exactly
`[propext, Classical.choice, Quot.sound]` as its axiom dependencies. All 13
semantic probes passed, with exit 0 and no diagnostics. There is no
`sorryAx`, custom axiom, `native_decide`, unsafe declaration, or trust shortcut
in the reviewed source. The finite probes below also use kernel `decide`.

```lean
#check LonelyRunner.threeLowerOwner_noncover_seven
#check LonelyRunner.threeLowerOwner_circleNorm_witness_seven
#print axioms LonelyRunner.threeLowerOwner_noncover_seven
#print axioms LonelyRunner.threeLowerOwner_circleNorm_witness_seven
open LonelyRunner Finset
set_option maxRecDepth 10000
example : (pivotBadResidues 7 72 56 \ pivotBadResidues 7 72 63).card = 90 := by decide
example : (pivotBadResidues 7 120 56 \ pivotBadResidues 7 120 105).card = 150 := by decide
example : (pivotBadResidues 7 120 112 \ pivotBadResidues 7 120 105).card = 150 := by decide
example : (pivotBadResidues 7 16 7 \ pivotBadResidues 7 16 14).card = 12 := by decide
example : (pivotBadResidues 7 88 28 \ pivotBadResidues 7 88 77).card = 102 := by decide
example : (pivotBadResidues 7 88 84 \ pivotBadResidues 7 88 77).card = 102 := by decide
example : 2 ∈ pivotCandidates 7 4 ∧ 2 ∉ pivotBadResidues 7 4 2 ∧
    cyclicResidueDistance 28 (2*2) = 4 := by decide
example : (7 : ℝ)⁻¹ ≤ circleNorm (((2 : ℝ)/28)*2) := by
  exact outside_pivotBadResidues_circleNorm_ge (N:=7) (pivot:=4)
    (by decide) (by decide) (by decide) (by decide)
example : ∃ r ∈ pivotCandidates 7 56,
    r ∉ pivotBadResidues 7 56 7 ∧ r ∉ pivotBadResidues 7 56 28 ∧
      r ∉ pivotBadResidues 7 56 49 := by
  exact threeLowerOwner_noncover_seven 56 7 28 49
    (by decide) (by decide) (by decide) (by decide)
example (t : Nat) (ht : 0 < t) : ∃ r ∈ pivotCandidates 7 (120*t),
    r ∉ pivotBadResidues 7 (120*t) (56*t) ∧
      r ∉ pivotBadResidues 7 (120*t) (105*t) ∧
      r ∉ pivotBadResidues 7 (120*t) (112*t) := by
  exact threeLowerOwner_noncover_seven _ _ _ _
    (by omega) (by omega) (by omega) (by omega)
example (p a b c : Nat) (ha : 0<a) (hab : a<b) (hbc : b<c) (hcp : c<p) :
    ∃ t : ℝ, (7 : ℝ)⁻¹ ≤ circleNorm (t*(p:ℝ)) ∧
      (7 : ℝ)⁻¹ ≤ circleNorm (t*(a:ℝ)) ∧
      (7 : ℝ)⁻¹ ≤ circleNorm (t*(b:ℝ)) ∧
      (7 : ℝ)⁻¹ ≤ circleNorm (t*(c:ℝ)) := by
  obtain ⟨r,_,hp,ha',hb,hc⟩ := threeLowerOwner_circleNorm_witness_seven p a b c ha hab hbc hcp
  exact ⟨(r:ℝ)/((7*p:Nat):ℝ),hp,ha',hb,hc⟩
example : pivotBadResidues 7 4 0 = pivotCandidates 7 4 := by decide
example : pivotBadResidues 7 4 28 = pivotCandidates 7 4 := by decide
```

The last two probes exhibit why arbitrary zero speeds or unrestricted upper
owners cannot replace the current hypotheses. They are countercontrols to
such changes, not failures of the reviewed statement.

## 4. Independent exact domain and mutation controls

This self-contained standard-library block imports no project checker. It
enumerates the literal finite definitions, checks normalization and row
bounds for every `1<=p<=120`, `1<=d<p`, then checks every increasing triple
of lower owners at `4<=p<=40`. It separately checks every star remainder at
p=8,16,...,240 and all six base differences at common factors
1,2,7,49,343. Full set equality, not just cardinality, is checked for the
scaled differences. These are finite regressions supporting the proof audit;
they are not its unrestricted existence argument.

```python
from itertools import combinations
from math import gcd

def R(p):
    return {r for r in range(7*p) if r%7}

def B(p,d):
    return {r for r in R(p)
            if min((r*d)%(7*p),7*p-(r*d)%(7*p))<p}

def bits(S):
    return sum(1<<r for r in S)

base=[(72,56,63),(120,56,105),(120,112,105),
      (16,7,14),(88,28,77),(88,84,77)]
base_counts=[len(B(p,d)-B(p,s)) for p,d,s in base]
assert base_counts==[90,150,150,12,102,102]
rows=0
for p in range(1,121):
    for d in range(1,p):
        count=len(B(p,d))
        h=gcd(p,d); P=p//h; D=d//h; k=gcd(D,7)
        assert count==h*(k*(2*((P-1)//k)+1)-(2*((P-1)//7)+1))
        assert 4*count<=9*p
        if 8*d!=7*p:
            assert count<=2*p
        assert 1 in B(p,d)
        rows+=1

triples=0; branches=[0,0,0,0]
for p in range(4,41):
    full=bits(R(p))
    bb={d:bits(B(p,d)) for d in range(1,p)}
    for a,b,c in combinations(range(1,p),3):
        covered=bb[a]|bb[b]|bb[c]
        assert covered!=full
        safe=full^covered
        r=(safe & -safe).bit_length()-1
        assert all(min((r*d)%(7*p),7*p-(r*d)%(7*p))>=p
                   for d in (p,a,b,c))
        branch=next((i+1 for i,d in enumerate((a,b,c)) if 8*d==7*p),0)
        branches[branch]+=1
        triples+=1

remainders=0
for p in range(8,241,8):
    s=7*p//8; bs=B(p,s)
    for d in range(1,p):
        if d!=s:
            assert 8*len(B(p,d)-bs)<15*p
            remainders+=1

scales=0
for p,d,s in base:
    original=B(p,d)-B(p,s)
    for t in (1,2,7,49,343):
        actual=B(t*p,t*d)-B(t*p,t*s)
        assert len(actual)==t*len(original)
        assert actual=={r for r in range(7*t*p) if r%(7*p) in original}
        assert 8*len(actual)<15*t*p
        scales+=1

# Five false changes: allow a zero owner, allow an upper owner, count the
# closed endpoint as bad, scale only an owner, or remove the star exception.
assert B(4,0)==R(4)
assert B(4,28)==R(4)
assert 2 in R(4) and 2 not in B(4,2)
assert min((2*2)%28,28-(2*2)%28)==4
assert len(B(16,14))==2*len(B(8,7))
assert len(B(8,14))!=2*len(B(8,7))
assert len(B(8,7))>2*8
assert (rows,triples,remainders,scales)==(7140,91390,3660,30)
assert branches==[89915,10,270,1195]
print(dict(base_counts=base_counts,rows=rows,triples=triples,
           branches=branches,remainders=remainders,scales=scales,
           mutation_controls=5))
```

All assertions passed. The branch vector records no star, then a star in
position a, b, or c respectively. Thus the finite domain exercises every
union rearrangement, as well as common factors divisible by seven. No broad
new search or large artifact was needed.

## 5. Source dependencies and disposition

The two scalar/periodic helper sources remain at their separately accepted
hashes. I inspected the actual scaling equivalence, normalized-count adapter,
candidate/bad definitions, and closed circle adapters used here. Their bindings
are:

```text
a6199b77071b81868abffe0959c1b5aa4e64a06369adb93eddbc2fa7b6c90b7e  LonelyRunner/PeriodicPivotCounts.lean
1f05a8f42c2d49b86e3d234cbd72b01e9b3b30d75549b133aad030f51a61455a  LonelyRunner/ThreeOwnerSevenArithmetic.lean
49131a7f9690042d1b16cbc876417f9d9ce1b53cc6565f87b6d1b53c4e3340cd  LonelyRunner/Prompt99Scaling.lean
ac24bb6cfcf524a08c0ceb2a728b2febf826c595d4aaa72eb7f10d2e5baa96dd  LonelyRunner/Prompt100TwoOwnerCounts.lean
362da5ab923f22e900ae7ac821dd4cf4aab91dfe70889987bc9e5a05d19c276a  LonelyRunner/PivotResidues.lean
73a4e6cec433c79eda9382d4938932bd03583ba117d475afc6324272ab8cd9b7  research/astra-periodic-arithmetic-review.md
f6130fd8ed2bda6b50aa73b64a6fcbdbacb27efb478163d0b6e4e9e12d69dc50  research/astra-next-bridge-audit.md
5fb7f5765e1a4dd802dee0a5fe9dec592faaaa51a3e51a519b56f26584c166df  research/astra-three-owner-review.md
```

The checks used the shared pinned `leanprover/lean4:v4.32.1` toolchain and
mathlib revision `520045ab14e26149ee970e2e617ca04b09bde5d6`. Source hashes
were rechecked after verification. No source correction or unresolved semantic
gap was found in either public theorem. Integration/root build and publication
remain root's responsibility. General owner redundancy and unrestricted LRC
remain unresolved.
