# Independent review of the finite-family canonical bridge

Requested role: Astra xhigh; runtime model/effort metadata is not independently
attested. Source checkpoint `bf31ea82629c4101755e950faeb6e406fae7c1c9`.
Project configuration, workflow, policy, and current state were read;
`python3 -B scripts/validate_workflow.py` passed. Research is active and
canonical completion remains null. Only this review and small temporary
review programs/probes/logs are owned. No source, Git, state, build integration,
or shared-cache changes are made by this review.

**Accepted:** all five complete frozen bodies match the exact contract and
pass independent fresh-body elaboration with the fixed controls below. All
23 axiom reports contain only `propext`, `Classical.choice`, and `Quot.sound`.
No source defect was identified. This proves an equivalence with the universal
finite-family obligation; it does not prove that obligation or unrestricted LRC.

## Exact frozen scope

| File | SHA-256 |
| --- | --- |
| `LonelyRunner/FiniteTupleSorting.lean` | `71b47c20282d091129fe9990b2d1bbdfdebff45e49dea2bfbd7d4425fe89f775` |
| `LonelyRunner/LonelyAtTransport.lean` | `6596481a6087174f7f7bb7d5140e339d0a571b05bc369fd3a9f0c432875ee1ee` |
| `LonelyRunner/PrimitiveTupleNormalization.lean` | `cac3351bf8c755c0bd354d0330e766f49c255d7ef21637d0975a8d8633cd94b0` |
| `LonelyRunner/FinitePrimitiveFamilies.lean` | `1f693dc423af998e84291b854be3426242a962efe5b691a6cba492874d23b74a` |
| `LonelyRunner/FiniteFamilyEquivalence.lean` | `b47e65f4a519e017ff69b54e820e5b913360d8434f2c6518ebb42c988b4c76dc` |

The accepted design `research/astra-finite-family-bridge-contract.md` has
SHA-256 `214bfd677cae6cbe5f9a1717511a714bf47781a84689a2e534d470917f8aa018`.
The conditional height theorem is a preexisting dependency, not a new result
of this review. Its explicit `LowerCountPositiveIntegerHypothesis` is never
silently discharged at a fixed count. Current source, not a stale theorem
name or a preprint claim, determines the contracts reviewed here.

## Semantic findings

`exists_strictMono_reindex` has arbitrary `n`, arbitrary linearly ordered
codomain, and only actual tuple injectivity as a premise. It forms the range
finset with exactly `n` members and composes its order isomorphism with the
inverse original-range bijection. Its equivalence maps sorted positions to
original labels; empty and singleton index types are allowed. It does not
claim that an arbitrary input tuple is already increasing.

`exists_sorted_primitive_integer_normalization` applies for `m=0` as well
as larger `m`, so its smallest tuple has two labels. It sorts actual signed
integers and subtracts the minimum in integers before taking `toNat`.
Sortedness proves that conversion exact. The last coordinate is strictly
positive because it differs from the first. This supplies the nonzero entry
needed by the finite-gcd quotient theorem despite the first residual being
zero. Every division is exact; the common gcd is positive; the normalized
row is strictly increasing, begins at zero, and has joint gcd one.
The original factorization is `a(e j)=c+g*b j`. No label is removed, and no
absolute-value deduplication or pairwise coprimality assumption is used.

`lonelyAt_reindex_translate_scale_iff` accepts every nonzero real scale,
including negative scales, and unrestricted real `T`. It uses the original
runner `r`, inverse label `e.symm r`, and original time `T/g`. Its proof
transports each phase difference exactly, with translation cancelling and
scale dividing. Both directions preserve the original total count and all
other-label comparisons. Negative scale can change the time's sign; the
canonical statement permits that. The theorem asserts no unwarranted positive
time for negative scale.

`InclusivePrimitiveFiniteFamily m` quantifies over all strictly increasing
natural tuples on `Fin (m+2)`, anchored at zero and with joint gcd one, whose
last coordinate is **at most** `((m+2)*(m+1))^m`. It gives, for each chosen
original label, one real time serving every other comparison in `LonelyAt`.
`AllInclusivePrimitiveFiniteFamilies` asks for every `m>=1`, exactly every
total count `N=m+2>=3`, including odd counts. The omitted total count two is
handled separately by the one-moving-runner base case. For fixed `m` the
speed tuples are finite because every coordinate is bounded by the displayed
cutoff; no exhaustive check or decidability of the real existential is proved.

`integer_lonelyAt_of_lower_and_finiteFamily` requires both the bounded
lower-count hypothesis and the finite family explicitly. It first normalizes
an arbitrary injective signed integer tuple, then splits at the normalized
last coordinate. Equality belongs to the finite-family branch; the other
branch has the strict inequality required by the preexisting height theorem.
The chosen normalized runner is `e.symm r`; either witness is returned at
`T/g` for the actual original runner. It discards only the high branch's
extra positive-time result. It does not assume an actual-tuple witness.

`lowerCount_of_previous_counts` supplies a request with `1<=d<=N-2` only
from a genuinely smaller moving count. Writing `N=n+1`, the source derives
`d<n`; it retains the earlier tuple's own threshold `1/(d+1)`. The
`positiveIntegerAtCount_of_lower_and_finiteFamily` adapter appends an actual
zero at the last label. Positivity separates that label from all moving
speeds, while original injectivity separates the others. The canonical
witness is taken for this last zero, then restricted to each `castSucc`
moving label at exactly the threshold `1/(m+2)`.

The final induction retains `1<=n` in its motive, proves `n=1` with
`oneMovingRunner`, and for `n>=2` requests only strictly earlier positive
counts and the supplied finite family at `m=n-1>=1`. There is no same-count
induction request and no fictitious `F_1` or `F_2` premise. Only after it has
proved every positive-integer count does the final reverse implication use
the preexisting global BHK/canonical equivalence. No claim that a real-speed
reduction preserves a chosen minimal count is used.

The forward implication specializes canonical LRC to each sorted bounded
primitive tuple and ignores its additional restrictions. Thus the public
`conjecture_iff_allInclusivePrimitiveFiniteFamilies` is an unconditional
**equivalence**, with neither a remaining `H_N` argument nor a hidden finite
witness premise outside its right-hand proposition. Both sides remain
unproved here. The closed `1/N` boundary and quantifier order are unchanged.

## Replay design and fixed controls

The reproducer verifies all five source hashes and the accepted contract hash,
removes the five modules' imports, and concatenates their complete bodies in
dependency order. It hoists only preexisting imports. It recursively inspects
every local project dependency's source imports and rejects any direct or
transitive import of a reviewed module. The existing height theorem and other
preexisting source modules remain dependencies; no cached reviewed body can
satisfy a declaration in this probe. There is no root `LonelyRunner` import,
no full build, and no dependency restoration by the reviewer.

The probe prints each public declaration's type and axioms, and also checks
an expanded canonical iff spelling out both finite-family definitions.
Nonvacuous controls prove `H_3` from `oneMovingRunner` and full `F_3`
(`m=1`, all tuples and all chosen runners) from `twoMovingRunners` through
the canonical relative-speed bridge. It then uses the reviewed integer bridge
with those proved inputs on actual signed tuples whose normalized heights
are below, equal to, and above six:

| Original signed labels | Sorted-to-original labels | Translation | Gcd | Primitive tuple |
| --- | --- | --- | --- | --- |
| `(14,-10,2)` | `(1,2,0)` | `-10` | `12` | `(0,1,2)` |
| `(6,0,5)` | `(1,2,0)` | `0` | `1` | `(0,5,6)` |
| `(2,11,0)` | `(2,0,1)` | `0` | `1` | `(0,2,11)` |
| `(-91,769,-101,334)` | `(2,0,3,1)` | `-101` | `5` | `(0,2,87,174)` |

The fourth row checks only exact normalization/factorization/count and height
data. It does **not** assume or prove `F_4`. Its primitive gcd is joint:
`gcd(2,174)=2`, `gcd(87,174)=87`, but `gcd(2,87,174)=1`.

Additional controls cover empty/singleton sorting, two-label signed
normalization, a non-involutive three-cycle, generic transport at both scales
`12` and `-12`, and genuine closed-boundary original witnesses at times
`1/36` and `-1/36`. Using the forward permutation or multiplying time by the
scale instead gives the explicit failed times `1/24` and `4`; the probe
proves those are not lonely for the chosen original runner. It also proves
`P(1)`, obtains `H_3` through the strictly-smaller-count adapter, then proves
`P(2)` through the appended-zero adapter using the honest `F_3`.

The exact rational checks use the four table rows and one negative-scale
transport row, with fixed supplied times. No tuple or witness search is run.
They check 108 phase identities and 24 original witness comparisons for 12
chosen-runner witnesses, plus the inclusive split and two wrong-transport
rejections. Those finite controls supplement the generic kernel proofs.

The first preliminary launch exited before elaboration because the shared
cache lacked preexisting `LonelyRunner/SmallDimensions.olean`. The root's
already planned dependency/full build supplies it; no mathematical premise
or reviewed source is changed in response. Final replay evidence follows.

The first five-body run elaborated the reviewed declarations, but failed in
reviewer-only controls: singleton type inference, vector-index simplification,
and simplification of integral circle phases. Those controls were corrected
without changing their propositions or any reviewed source. That failed run,
including automatic `sorryAx` from unsolved control goals, was rejected.
The corrected entire five-body replay exited zero. There were nine tactic-style
linter warnings, no errors, and no forbidden axiom in any of the 23 reports.

The final successful probe contains eleven public source declarations, twelve
named probe theorems, and twenty-two anonymous kernel examples. In particular,
`FiniteFamilyReview.expandedCanonicalIff` has exactly the expanded unrestricted
canonical equivalence. `honestF3` is a proof for all admissible three-label
tuples and all chosen runners, not a finite list of times or an assumed input.
The finite examples use ordinary kernel-checkable `decide`, never
`native_decide`; the source and probe use no `sorry`, `admit`, or custom axiom.

Reproducibility identities:

| Artifact | SHA-256 |
| --- | --- |
| Complete generator below | `e91b82ad275d43b0878a0034605ff03a5c8536a4f76fccd36f40925db66a7ca9` |
| Generated five-body Lean probe | `0b91b8592a908bb80785634e3215043e0f91c5115b95f765bb4b483df86afe80` |
| Exact standalone Lean controls embedded in the generator | `be3d0014cb7375269ff3680ab6bae995c2d2d499313b9e56ff8a84a8eec61f6a` |
| Successful Lean stdout/stderr log | `a551a2c9960c24bbf2da633b34d7f103c85b0273bc40f2943fe9448840febfd5` |
| Sorted JSON map of 37 preexisting local dependency source hashes | `a9f5787dd5bbd4e535ebeb8d6943879a139b68b764115a4a2dc02ef436e7c90e` |

The dependency-map hash is computed with `json.dumps(map, sort_keys=True,
separators=(',',':'))`. The generator also enforces the pinned `lean-toolchain`
and `lake-manifest.json` hashes. It runs precisely `lake env lean` on a single
temporary combined source file, without `-o`; it does not restore dependencies
or run a full build. Its metadata JSON preserves the individual preexisting
source hashes and the 23 declaration names. The root's integrated full build
is separate evidence; no whole-project build result is attributed to this
review's command.

## Complete self-contained reproducer

The following program contains its full Lean controls. Run it from this
repository with the pinned shared dependencies ready. It overwrites only its
own small `/tmp/astra-finite-family-review-*` probe, metadata, and log files.

```python
from pathlib import Path
from hashlib import sha256
import re, json, subprocess, os, sys

root=Path('/home/joshua/lonely-runner-formalization')

# Fixed exact data checks; no tuple, denominator, or witness search.
from fractions import Fraction as F
from math import gcd
from collections import Counter
fixed_counts=Counter()
def norm(x):
    y=x%1
    return min(y,1-y)
fixtures=[
 ((14,-10,2),(1,2,0),-10,12,(0,1,2),(F(1,3),F(1,2),F(1,3))),
 ((6,0,5),(1,2,0),0,1,(0,5,6),(F(1,12),F(1,3),F(2,5))),
 ((2,11,0),(2,0,1),0,1,(0,2,11),(F(1,3),F(1,6),F(1,20))),
 ((-91,769,-101,334),(2,0,3,1),-101,5,(0,2,87,174),None),
 ((-34,-10,-22),(1,2,0),-10,-12,(0,1,2),(F(1,3),F(1,2),F(1,3))),
]
for a,e,c,g,b,times in fixtures:
    n=len(a)
    inv=tuple(e.index(i) for i in range(n))
    assert len(set(a))==len(set(e))==n and g!=0
    assert all(a[e[j]]==c+g*b[j] for j in range(n))
    if g>0:
        assert e==tuple(sorted(range(n),key=lambda i:a[i]))
        assert c==min(a) and gcd(*(x-c for x in a))==g
        assert gcd(*b)==1 and b[0]==0 and all(x<y for x,y in zip(b,b[1:]))
        C=(n*(n-1))**(n-2)
        fixed_counts['inclusive_low']+=b[-1]<=C
        fixed_counts['strict_high']+=C<b[-1]
        fixed_counts['height_equality']+=b[-1]==C
        fixed_counts['normalizations']+=1
    else:
        fixed_counts['negative_scale_fixtures']+=1
    for r in range(n):
        for T in (F(-2,7),F(0),F(3,8)):
            for i in range(n):
                if i==r: continue
                lhs=(a[i]-a[r])*T/g
                rhs=(b[inv[i]]-b[inv[r]])*T
                assert lhs==rhs and norm(lhs)==norm(rhs)
                fixed_counts['phase_identities']+=1
        if times:
            t=times[inv[r]]/g
            for i in range(n):
                if i==r: continue
                assert norm((a[i]-a[r])*t)>=F(1,n)
                fixed_counts['literal_witness_comparisons']+=1
            fixed_counts['literal_original_runner_witnesses']+=1
    fixed_counts['fixtures']+=1
assert gcd(2,174)==2 and gcd(87,174)==87 and gcd(2,87,174)==1
assert F(2)<6 and F(6)==6 and F(11)>6
assert norm(F(-24,24))==0<F(1,3)
assert norm(F(-24)*4)==0<F(1,3)
fixed_counts['wrong_transport_rejections']=2
assert fixed_counts==Counter(fixtures=5,normalizations=4,negative_scale_fixtures=1,
 inclusive_low=2,strict_high=2,height_equality=1,phase_identities=108,
 literal_witness_comparisons=24,literal_original_runner_witnesses=12,
 wrong_transport_rejections=2)
modules={
 'FiniteTupleSorting':'71b47c20282d091129fe9990b2d1bbdfdebff45e49dea2bfbd7d4425fe89f775',
 'LonelyAtTransport':'6596481a6087174f7f7bb7d5140e339d0a571b05bc369fd3a9f0c432875ee1ee',
 'PrimitiveTupleNormalization':'cac3351bf8c755c0bd354d0330e766f49c255d7ef21637d0975a8d8633cd94b0',
 'FinitePrimitiveFamilies':'1f693dc423af998e84291b854be3426242a962efe5b691a6cba492874d23b74a',
 'FiniteFamilyEquivalence':'b47e65f4a519e017ff69b54e820e5b913360d8434f2c6518ebb42c988b4c76dc',
}
contract=root/'research/astra-finite-family-bridge-contract.md'
assert sha256(contract.read_bytes()).hexdigest()=='214bfd677cae6cbe5f9a1717511a714bf47781a84689a2e534d470917f8aa018'
forbidden={'LonelyRunner.'+name for name in modules}|{'LonelyRunner.FiniteFamilyEquivalence'}
bodies=[]; imports=[]; public=[]
for name,wanted in modules.items():
    p=root/'LonelyRunner'/f'{name}.lean'
    body=p.read_text()
    assert sha256(p.read_bytes()).hexdigest()==wanted,p
    for imp in re.findall(r'^import (\S+)\s*$',body,re.M):
        if imp not in forbidden and imp not in imports: imports.append(imp)
    body=re.sub(r'^import .*\n','',body,flags=re.M)
    assert not re.search(r'\b(sorry|admit|axiom|native_decide)\b',body),name
    bodies.append(f'\n/- Fresh source body: {name} -/\n'+body)
    public+=['LonelyRunner.'+n for n in re.findall(r'^(?:noncomputable )?(?:def|theorem) (\w+)',body,re.M)]
for imp in ('LonelyRunner.SmallDimensions','LonelyRunner.BHKRealReduction'):
    if imp not in imports: imports.append(imp)
# Reject cached imports of any reviewed body, including through a project dependency.
seen={}
def inspect(imp):
    assert imp not in forbidden,imp
    if not imp.startswith('LonelyRunner.') or imp in seen: return
    p=root/(imp.replace('.','/')+'.lean')
    text=p.read_text()
    seen[imp]=sha256(p.read_bytes()).hexdigest()
    for sub in re.findall(r'^import (\S+)\s*$',text,re.M): inspect(sub)
for imp in imports: inspect(imp)
dependency_digest=sha256(json.dumps(seen,sort_keys=True,separators=(',',':')).encode()).hexdigest()
assert dependency_digest=='a9f5787dd5bbd4e535ebeb8d6943879a139b68b764115a4a2dc02ef436e7c90e'
assert sha256((root/'lean-toolchain').read_bytes()).hexdigest()=='8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af'
assert sha256((root/'lake-manifest.json').read_bytes()).hexdigest()=='887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218'
controls=r'''
namespace FiniteFamilyReview
open LonelyRunner

-- Genuine lower-count input: H_3 asks only for one moving runner.
theorem honestH3 : LowerCountPositiveIntegerHypothesis 3 := by
  intro d hd hupper a _hinj hpos
  have hd1 : d = 1 := by omega
  subst d
  obtain ⟨t, ht⟩ := oneMovingRunner (a 0 : ℝ) (by exact_mod_cast (hpos 0).ne')
  refine ⟨t, fun i => ?_⟩
  have hi : i = 0 := Subsingleton.elim _ _
  subst i
  simpa [circleNorm] using ht

-- Genuine all-chosen F_3, with no height/gcd restriction used in its proof.
theorem honestF3 : InclusivePrimitiveFiniteFamily 1 := by
  intro s hs _hzero _hgcd _hheight r
  let rel : Fin 2 → ℝ := fun j => (s (r.succAbove j) : ℝ) - (s r : ℝ)
  have hnz : ∀ j, rel j ≠ 0 := by
    intro j h
    have heq : s (r.succAbove j) = s r := by
      exact_mod_cast sub_eq_zero.mp h
    exact Fin.succAbove_ne r j (hs.injective heq)
  obtain ⟨t, ht⟩ := twoMovingRunners rel hnz
  refine ⟨t, (lonelyAt_iff_relativeLonelyAt _ r t).mpr ?_⟩
  intro i hi
  obtain ⟨j, rfl⟩ := Fin.exists_succAbove_eq hi
  simpa [rel, circleNorm] using ht j

example : ∃ e : Fin 0 ≃ Fin 0,
    StrictMono (fun j => (e j).val) := by
  exact exists_strictMono_reindex (fun i : Fin 0 => i.val) (fun i => Fin.elim0 i)

example : ∃ e : Fin 1 ≃ Fin 1,
    StrictMono (fun j => (fun _ : Fin 1 => (-7 : ℤ)) (e j)) := by
  exact exists_strictMono_reindex (fun _ : Fin 1 => (-7 : ℤ))
    (fun _ _ _ => Subsingleton.elim _ _)

example : ∃ (e : Fin 2 ≃ Fin 2) (c : ℤ) (g : ℕ) (b : Fin 2 → ℕ),
    0 < g ∧ StrictMono b ∧ b 0 = 0 ∧ Finset.univ.gcd b = 1 ∧
      ∀ j, (![(-8 : ℤ), -14]) (e j) = c + (g : ℤ) * (b j : ℤ) := by
  exact exists_sorted_primitive_integer_normalization ![(-8 : ℤ), -14] (by decide)

def cycle3 : Fin 3 ≃ Fin 3 where
  toFun := ![1, 2, 0]
  invFun := ![2, 0, 1]
  left_inv := by intro i; fin_cases i <;> rfl
  right_inv := by intro i; fin_cases i <;> rfl

def b3 : Fin 3 → ℝ := ![0, 1, 2]
def positive3 : Fin 3 → ℝ := ![14, -10, 2]
def negative3 : Fin 3 → ℝ := ![-34, -10, -22]

example : cycle3 (cycle3 0) ≠ (0 : Fin 3) := by decide
example : cycle3.symm (0 : Fin 3) = 2 := by rfl

example (r : Fin 3) (T : ℝ) :
    LonelyAt positive3 r (T / 12) ↔ LonelyAt b3 (cycle3.symm r) T := by
  exact lonelyAt_reindex_translate_scale_iff positive3 b3 cycle3 (-10) 12
    (by norm_num) (by intro j; fin_cases j <;> norm_num [positive3, b3, cycle3] <;> rfl) r T

example (r : Fin 3) (T : ℝ) :
    LonelyAt negative3 r (T / (-12)) ↔ LonelyAt b3 (cycle3.symm r) T := by
  exact lonelyAt_reindex_translate_scale_iff negative3 b3 cycle3 (-10) (-12)
    (by norm_num) (by intro j; fin_cases j <;> norm_num [negative3, b3, cycle3] <;> rfl) r T

-- Concrete original witnesses validate both signs of g at the closed boundary.
theorem b3_last_boundary : LonelyAt b3 2 (1 / 3) := by
  apply (lonelyAt_iff_relativeLonelyAt _ _ _).mpr
  intro i hi
  fin_cases i
  · change (3 : ℝ)⁻¹ ≤ circleNorm ((1 / 3) * (0 - 2))
    apply circleNorm_ge_of_int_band (-1) <;> norm_num
  · change (3 : ℝ)⁻¹ ≤ circleNorm ((1 / 3) * (1 - 2))
    apply circleNorm_ge_of_int_band (-1) <;> norm_num
  · exact (hi rfl).elim

theorem positive_boundary : LonelyAt positive3 0 (1 / 36) := by
  have h := (lonelyAt_reindex_translate_scale_iff positive3 b3 cycle3 (-10) 12
    (by norm_num) (by intro j; fin_cases j <;> norm_num [positive3, b3, cycle3] <;> rfl)
    0 (1 / 3)).mpr b3_last_boundary
  convert h using 1 <;> norm_num

theorem negative_boundary : LonelyAt negative3 0 (-1 / 36) := by
  have h := (lonelyAt_reindex_translate_scale_iff negative3 b3 cycle3 (-10) (-12)
    (by norm_num) (by intro j; fin_cases j <;> norm_num [negative3, b3, cycle3] <;> rfl)
    0 (1 / 3)).mpr b3_last_boundary
  convert h using 1 <;> norm_num

example : ∀ j, (![14, -10, 2] : Fin 3 → ℤ) (cycle3 j) =
    -10 + 12 * ((![0, 1, 2] : Fin 3 → ℕ) j : ℤ) := by decide
example : ∀ j, (![6, 0, 5] : Fin 3 → ℤ) (cycle3 j) =
    ((![0, 5, 6] : Fin 3 → ℕ) j : ℤ) := by decide
example : ∀ j, (![2, 11, 0] : Fin 3 → ℤ) (cycle3.symm j) =
    ((![0, 2, 11] : Fin 3 → ℕ) j : ℤ) := by decide
example : Finset.univ.gcd (![0, 1, 2] : Fin 3 → ℕ) = 1 ∧
    Finset.univ.gcd (![0, 5, 6] : Fin 3 → ℕ) = 1 ∧
    Finset.univ.gcd (![0, 2, 11] : Fin 3 → ℕ) = 1 := by decide
example : (2 : ℕ) < ((1 + 2) * (1 + 1)) ^ 1 ∧
    (6 : ℕ) = ((1 + 2) * (1 + 1)) ^ 1 ∧
    ((1 + 2) * (1 + 1)) ^ 1 < (11 : ℕ) := by decide

-- The four-label data use a joint gcd, not pairwise coprimality to the height.
def e4 : Fin 4 ≃ Fin 4 where
  toFun := ![2, 0, 3, 1]
  invFun := ![1, 3, 0, 2]
  left_inv := by intro i; fin_cases i <;> rfl
  right_inv := by intro i; fin_cases i <;> rfl

def a4 : Fin 4 → ℤ := ![-91, 769, -101, 334]
def b4 : Fin 4 → ℕ := ![0, 2, 87, 174]
example : Function.Injective a4 := by decide
example : StrictMono b4 := by decide
example : b4 0 = 0 := rfl
example : Finset.univ.gcd b4 = 1 := by decide
example : Nat.gcd 2 174 = 2 ∧ Nat.gcd 87 174 = 87 := by decide
example : ∀ j, a4 (e4 j) = -101 + (5 : ℤ) * (b4 j : ℤ) := by decide
example : b4 (Fin.last 3) > ((2 + 2) * (2 + 1)) ^ 2 := by decide

-- Fixed actual signed tuples, witnessed by the honest H3/F3 inputs above.
theorem below_cutoff : ∀ r : Fin 3, ∃ t : ℝ,
    LonelyAt (fun i => ((![14, -10, 2] : Fin 3 → ℤ) i : ℝ)) r t := by
  exact integer_lonelyAt_of_lower_and_finiteFamily (m := 1) (by omega)
    honestH3 honestF3 ![14, -10, 2] (by decide)

theorem at_cutoff : ∀ r : Fin 3, ∃ t : ℝ,
    LonelyAt (fun i => ((![6, 0, 5] : Fin 3 → ℤ) i : ℝ)) r t := by
  exact integer_lonelyAt_of_lower_and_finiteFamily (m := 1) (by omega)
    honestH3 honestF3 ![6, 0, 5] (by decide)

theorem above_cutoff : ∀ r : Fin 3, ∃ t : ℝ,
    LonelyAt (fun i => ((![2, 11, 0] : Fin 3 → ℤ) i : ℝ)) r t := by
  exact integer_lonelyAt_of_lower_and_finiteFamily (m := 1) (by omega)
    honestH3 honestF3 ![2, 11, 0] (by decide)

-- Reject the wrong forward index (T=1/2) and multiplied scale (t=4).
example : ¬ LonelyAt positive3 0 (1 / 24) := by
  intro h
  have hbad := (lonelyAt_iff_relativeLonelyAt _ _ _).mp h 1 (by decide)
  change (3 : ℝ)⁻¹ ≤ circleNorm ((1 / 24) * (positive3 1 - positive3 0)) at hbad
  have hp : (1 / 24) * (positive3 1 - positive3 0) = (-1 : ℝ) := by
    norm_num [positive3]
  have hz : circleNorm (-1 : ℝ) = 0 := by
    simpa [circleNorm] using circleNorm_add_int (-1) 0
  rw [hp, hz] at hbad
  norm_num at hbad

example : ¬ LonelyAt positive3 0 4 := by
  intro h
  have hbad := (lonelyAt_iff_relativeLonelyAt _ _ _).mp h 1 (by decide)
  change (3 : ℝ)⁻¹ ≤ circleNorm (4 * (positive3 1 - positive3 0)) at hbad
  have hp : 4 * (positive3 1 - positive3 0) = (-96 : ℝ) := by
    norm_num [positive3]
  have hz : circleNorm (-96 : ℝ) = 0 := by
    simpa [circleNorm] using circleNorm_add_int (-96) 0
  rw [hp, hz] at hbad
  norm_num at hbad


theorem honestP1 : PositiveIntegerAtCount 1 := by
  intro a _hinj hpos
  obtain ⟨t, ht⟩ := oneMovingRunner (a 0 : ℝ) (by exact_mod_cast (hpos 0).ne')
  refine ⟨t, fun i => ?_⟩
  have hi : i = 0 := Subsingleton.elim _ _
  subst i
  simpa [circleNorm] using ht

theorem honestPreviousH3 : LowerCountPositiveIntegerHypothesis 3 := by
  apply lowerCount_of_previous_counts (n := 2) (by omega)
  intro d hd hdlt
  have hd1 : d = 1 := by omega
  subst d
  exact honestP1

theorem honestP2 : PositiveIntegerAtCount 2 := by
  exact positiveIntegerAtCount_of_lower_and_finiteFamily (m := 1) (by omega)
    honestPreviousH3 honestF3

example : ¬ (1 ≤ (2 : ℕ) ∧ 2 ≤ (2 + 1) - 2) := by decide

-- Expanding both finite-family predicates checks the exact unconditional iff.
theorem expandedCanonicalIff : Conjecture ↔
    (∀ m : ℕ, 1 ≤ m → ∀ s : Fin (m + 2) → ℕ,
      StrictMono s → s 0 = 0 → Finset.univ.gcd s = 1 →
      s (Fin.last (m + 1)) ≤ ((m + 2) * (m + 1)) ^ m →
      ∀ r : Fin (m + 2), ∃ t : ℝ, LonelyAt (fun i => (s i : ℝ)) r t) :=
  conjecture_iff_allInclusivePrimitiveFiniteFamilies

end FiniteFamilyReview
'''
probe=''.join('import '+i+'\n' for i in imports)
probe+='\nset_option maxRecDepth 4096\nset_option maxHeartbeats 1500000\n'
probe+=''.join(bodies)+controls
reports=public+['FiniteFamilyReview.'+n for n in ('honestH3','honestF3','below_cutoff','at_cutoff','above_cutoff','b3_last_boundary','positive_boundary','negative_boundary','honestP1','honestPreviousH3','honestP2','expandedCanonicalIff')]
probe+='\n'+''.join('#check @'+n+'\n#print axioms '+n+'\n' for n in reports)
out=Path('/tmp/astra-finite-family-review-fresh.lean');out.write_text(probe)
metadata={'preexisting_dependency_manifest_sha256':dependency_digest,'fixed_control_counts':dict(fixed_counts),'module_hashes':modules,'probe_sha256':sha256(out.read_bytes()).hexdigest(),
 'preexisting_project_dependencies':seen,'expected_axiom_reports':reports}
Path('/tmp/astra-finite-family-review-metadata.json').write_text(json.dumps(metadata,indent=2,sort_keys=True)+'\n')
print(json.dumps({'probe_sha256':metadata['probe_sha256'],'source_bodies':len(modules),'fixed_controls':dict(fixed_counts),'preexisting_project_dependencies':len(seen),'axiom_reports':len(reports)},sort_keys=True),flush=True)
env=dict(os.environ);env['PATH']=str(Path.home()/'.elan/bin')+':'+env.get('PATH','')
with Path('/tmp/astra-finite-family-review-fresh.log').open('w') as log:
    result=subprocess.run(['lake','env','lean',str(out)],cwd=root,env=env,stdout=log,stderr=subprocess.STDOUT)
print('Lean exit',result.returncode,flush=True)
text=Path('/tmp/astra-finite-family-review-fresh.log').read_text()
if result.returncode:
    print(text)
    raise SystemExit(result.returncode)
found=re.findall(r"'([^']+)' depends on axioms: \[([^\]]*)\]",text,re.S)
assert {name for name,_ in found}==set(reports),(found,reports)
allowed={'propext','Classical.choice','Quot.sound'}
for name,axioms in found:
    used={a.strip() for a in axioms.split(',') if a.strip()}
    assert used<=allowed,(name,used)
assert 'error:' not in text and 'declaration uses' not in text,text
print('Allowed axiom reports',len(found))
print('Log SHA-256',sha256(text.encode()).hexdigest())
```

Exact saved-block replay command:

```sh
python3 -B - <<'FINITE_FAMILY_FRESH_REPLAY'
from pathlib import Path
from hashlib import sha256
import re
text = Path('research/astra-finite-family-formal-review.md').read_text()
blocks = re.findall(r'^```python\n(.*?)^```[ \t]*$', text, re.M | re.S)
assert len(blocks) == 1
assert sha256(blocks[0].encode()).hexdigest() == 'e91b82ad275d43b0878a0034605ff03a5c8536a4f76fccd36f40925db66a7ca9'
exec(compile(blocks[0], 'finite-family-formal-review-generator', 'exec'))
FINITE_FAMILY_FRESH_REPLAY
```

Observed final result: Lean exit `0`; `Allowed axiom reports 23`;
fixed exact controls `fixtures=5`, `normalizations=4`, `negative_scale_fixtures=1`,
`inclusive_low=2`, `strict_high=2`, `height_equality=1`, `phase_identities=108`,
`literal_witness_comparisons=24`, `literal_original_runner_witnesses=12`, and
`wrong_transport_rejections=2`. The saved-block replay also reproduces the
probe/log hashes above. All commands have stopped at handoff.

Accepted scope is the five frozen modules and their exact canonical bridge.
No proof of `AllInclusivePrimitiveFiniteFamilies` is supplied. The remaining
uniform finite-family supply problem, and thus unrestricted LRC, is unresolved.
