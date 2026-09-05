# Independent formal review of affine witness components

Disposition: **accept the seven frozen modules at their exact component
contracts**. The original six-module assignment was explicitly extended to
`SignedAffineWitness.lean` before this review froze. No source defect or
silent strengthening of an induction premise was found. Fresh elaboration
of all seven complete bodies, generic contract checks, and nonvacuous kernel
controls passed with only the permitted axioms.

This does not certify an all-chosen-runner, primitive-height, or unrestricted
LRC theorem. The accepted manuscript proves a broader conditional reduction;
the reviewed source currently supplies its lower-count, phase, approximation,
positive-row, and signed-row components. Other pending modules are outside
this review.

The assignment checkpoint is `26a06cd76f9bb2f912f6365ace6b95f86ebe0322`,
on the parent-reported branch `codex/astra-affine-finite-height`. Requested
routing is Astra/xhigh; the worker does not independently attest runtime
model/effort metadata. Project configuration, workflow, policy, and current
state were read. `python3 -B scripts/validate_workflow.py` passed. The state
remains `research` / `in_progress`, without a canonical completion. That
validator is a record-consistency check, not proof evidence.

## Frozen inputs

All module paths below are under `LonelyRunner/`.

| Module | Bytes | SHA-256 |
| --- | ---: | --- |
| `AffinePhaseTransfer.lean` | 2331 | `069d7f05229f517639284a58d9bb10f6fd6ee8d949efc3d377361424e7381776` |
| `LowerCountSupply.lean` | 4613 | `0705291adc53011fb72fc718a7260876512b092741442d6a6cceb4b76eb5ccf4` |
| `BHKTwoPhaseSupply.lean` | 2381 | `2890e8ad41f9e3c2a0f098ba2a0da7060fa14ac2fe12842adf1c11905148ac09` |
| `AffinePhasePeriod.lean` | 2030 | `340c4dd29276544566175cf791307ca42753ddc964345aa793d33abef1e9b176` |
| `SimultaneousApproximation.lean` | 4706 | `144aec242a3f4d06853fed110bf8ee20f1cabf88b925acda889fe08cfe57c729` |
| `PositiveAffineWitness.lean` | 3820 | `ed9e66d5a8944f3b5862be66f96c30abe7829c063e866504ca9e9ac1989e2e03` |
| `SignedAffineWitness.lean` | 3324 | `19018618fdb454ddbdb199a29db8672bd4729bf68052736133c1d708cc26f3e5` |

The manuscript `research/astra-affine-finite-height-audit.md` has SHA-256
`6b676a05eb3a0036cd69e779150a5f1a868024d089ea75c142daeddccede938f`.
Its accepted independent review `research/astra-affine-finite-height-review.md`
has SHA-256 `eb0fb96e22096175fa3b68dc70a1b7981f39356aaf1377863dcaa95b6a510876`.
These are file hashes, not Git references. The manuscript derivation and
review were read; their numerical checker was not used as proof of the new
source.

The shared pinned Lean/mathlib dependencies were used without restoration
or cleanup. Lean is pinned to `leanprover/lean4:v4.32.1`, mathlib to
`520045ab14e26149ee970e2e617ca04b09bde5d6`. The replay below freshly elaborates
every reviewed body and imports only preexisting dependencies. It also checks
the transitive project import closure to exclude indirect import of one of
the seven reviewed modules. This is not a fresh build of all dependencies
or the full project.

## Exact source-contract audit

`LowerCountPositiveIntegerHypothesis N` is exactly the bounded hypothesis
`H_N`: for every `1≤d≤N-2`, every injective positive natural speed tuple
on `Fin d` has some real time with the closed **own-count** threshold
`1/(d+1)`. It has no height bound and no positivity requirement on this
auxiliary time. It does not assume LRC in arbitrary dimension or at the
original moving count `N-1`. The generic probe checks equivalence with
`0<d` and `d+2≤N`, including natural subtraction edge cases.

`lowerCountPositiveIntegerHypothesis_rational` uses the existing positive
common-denominator clearing map, which preserves positivity and injectivity.
If `D` is that common denominator and `τ` is the integer witness, the returned
rational time is **`τ*D`**, so `(D*v_i)*τ=v_i*(D*τ)`. The own-count threshold
and coordinate count stay unchanged. The inspected clearing map is a product
of denominators; it need not be their least common multiple.

`exists_lowerCount_rational_collision` takes `N≥3`, `m>0`, a nowhere-zero
rational vector on `Fin m`, and the explicit condition that its **distinct
absolute-value image** has cardinality at most `N-2`. That image is nonempty,
positive, and enumerated injectively. The source applies `H_N` to its actual
size `d`, then weakens `1/(d+1)` to `1/(N-1)` using `d+1≤N-1`. Sign invariance
returns the inequalities to every original signed slot. The helper does not
assume `m≤N-1`; many duplicates are permitted if the stated image-cardinality
condition holds. No original-slot count is substituted for `d`.

`exists_bhk_twoPhase_margin` assumes `N≥3`, `0<m≤N-1`, a positive rational
row `r`, a rational row `s`, nonconstant ratios `s_i/r_i`, and `H_N`. It uses
the existing adjacent-ratio construction to obtain a nowhere-zero rational
combination

\[
w_k=(r_i+r_j)s_k-(s_i+s_j)r_k,\qquad w_i=-w_j,\quad i\ne j.
\]

Equal absolute values of that pair force the image cardinality strictly
below `m`, hence at most `N-2`. The collision helper then supplies real
`a,b` with `||r_i a+s_i b||≥1/(N-1)` for every slot. These are **two free
phases**. The theorem asserts no original-orbit compatibility and invokes
no relation-compatible orbit-closure theorem. For the fixed rows `(2,3)`
and `(1,0)`, the original relation `3*2-2*3=0` does not annihilate collision
`(3,-3)`. The replay explicitly checks that distinction.

`exists_normalized_affine_second_phase` allows any index type, arbitrary
real first phases and coefficients `A,V`, a real period `q>0`, and an
integer witness for each `q*V_i`. It returns `q≤y<2q` preserving every norm.
The actual construction is

\[
y=q\{y_0/q\}+q=y_0-q\lfloor y_0/q\rfloor+q.
\]

The change is an integer multiple of the **given period `q`**. The period
need not be minimal or integral. The proof handles negative `y0` and zero
coefficients and does not normalize with period one without justification.

`exists_affinePhaseTransfer` also allows any index type. It takes integer
`U`, real `V`, `p>0`, `y>1/(2p)`, a margin `δ+ε` in every free phase,
and `|V_i|/(2p)≤ε`. With `j=round(py-x)` and `t=(j+x)/p`, it proves
`|t-y|≤1/(2p)` and strictly `t>0`. The key identity is

\[
(pU_i+V_i)t=U_i j+(U_i x+V_i y)+V_i(t-y).
\]

The integer term disappears modulo one. The loss is bounded by the residual
coefficient `|V_i|`, not by the possibly large actual speed. The circle-norm
Lipschitz inequality gives the closed target `δ`. Negative slopes and
residuals are allowed. Nearest-integer ties retain weak error inequality;
the strict hypothesis on `y` is what gives a positive time. No extra margin
is silently assumed. The general lemma does not require separate positivity
of `δ,ε`; it uses its explicitly stated margin and error premises.

`exists_positiveAffine_witness` assumes `N≥3`, `0<m≤N-1`, integer `U`,
rational `V,p`, `p>1`, a real common period `q≥1`, positive actual speeds
`pU_i+V_i`, nonconstant ratios `U_i/(pU_i+V_i)`, the error bound

\[
\frac{|V_i|}{2p}\le\frac1{N(N-1)},
\]

and `H_N`. It obtains BHK free phases for `R=pU+V`, `S=U`; the identity
`Ra+Sb=U(pa+b)+Va` supplies `X=pa+b`, `Y0=a`. Period normalization moves
`Y0` into `[q,2q)`, so `Y≥1>1/(2p)`. The exact margin identity
`1/N+1/(N(N-1))=1/(N-1)` discharges the transport premise. It returns a
positive time with closed `1/N` bounds for the same actual row. Distinctness
of these speeds is not required by this component. `N` is a threshold
parameter when `m<N-1`; the statement is not an assertion that this row
already contains all `N-1` comparisons of an original configuration.

`exists_signedAffine_witness` changes only the positive-actual-speed premise
to `pU_i+V_i≠0`. The proof flips both `U_i` and `V_i` when that actual
speed is negative. This makes the actual row positive while preserving
`U_i/(pU_i+V_i)` coordinatewise. It negates the integral period witness
where needed and uses `abs_neg` for the residual bound. Finally the circle
norm is unchanged by the phase sign. The same `Fin m`, `N`, and all slots
are retained; there is no count deduplication in this wrapper. The seven
modules contain no proof that arbitrary chosen-runner relative data meet
the nonconstant-ratio hypothesis, and no primitive-height bridge.

`fractionalBox` is the natural floor of `Q*fract(x)`, with `Q>0`; its proof
keeps that index in `Fin Q`. `fractionalBox_eq_error` uses both half-open
floor bounds to obtain **strict** `|fract(x)-fract(y)|<1/Q` for equal boxes.
`exists_simultaneous_integer_approximation d Q hQ x` maps `Q^d+1` indices
to `Q^d` boxes and obtains distinct indices. In each ordering case it sets
`q` to their positive natural difference and `z_i` to the corresponding
integer-floor difference. Casts use the correct index order. It proves
`0<q≤Q^d` and `|q*x_i-z_i|<1/Q`. Coordinates may be arbitrary reals and
`d=0` is permitted; `Q=1` is permitted and forces `q=1`. `Q=0` is excluded.

## Independent kernel replay and controls

The single generator below hashes the seven sources, moves only their
imports to the top, removes imports of reviewed modules, and concatenates
the **complete bodies in dependency order**. It independently checks eight
preexisting project modules in the import closure for an indirect reviewed
import. The resulting probe is 37,894 bytes, SHA-256
`2d79b805f1612d2fde0cda1014f343fff58d132ceb7bb11807c94b4da6d1e842`.

The replay includes 10 generic contract checks, 29 fixed control declarations,
and four review helper theorems. The four helpers prove `H_3` directly for
all one-speed positive integer inputs, the one-magnitude collision card,
the `Q=1` specialization for arbitrary dimension, and a rational floor value.
Thus the positive, signed, rational-supply, and BHK fixtures use an honestly
proved induction premise rather than a postulated `H_N` or an original-count
witness. The fixed controls are:

| Controls | Number of fixed declarations | Exact scope |
| --- | ---: | --- |
| Rational clearing | 4 | One speed `1/5`, common denominator `5`, correct time `5/2`, incorrect divided time `1/10` |
| Signed collision | 1 | Four slots `(1/5,-1/5,1/5,-1/5)` with one distinct magnitude, under proved `H_3` |
| BHK phases | 3 | Rows `(2,3),(1,0)`, literal free phases, failed preservation of an original integer relation |
| Affine transport | 7 | `U=V=(-1,1)`, `p=2,x=-1/2,y=1,δ=ε=1/4`; both ties `j=2,3` and all four signed bounds |
| Period normalization | 4 | `V=(1/2,-1/2)`, nonminimal `q=4`, negative `y0=-5/3`, normalized value `19/3`; wrong period-one value `4/3` changes the norm |
| Positive affine row | 3 | Actual speeds `(14,18)` at sharp residual budget; rational row with `p=9/4,U=(1,3),V=(1/5,0)` and periods `5,10` |
| Constant-ratio exclusion | 1 | `U=V=(1,2),p=100` meets the error bound but has constant ratios |
| Approximation/boxes | 5 | `d=0,Q=1`; signed rational coordinates at `d=2,Q=3`; equal boxes across negative/positive lifts; strict error; exact-width boundary exclusion |
| Signed affine row | 1 | `p=5/2,U=(-2,1),V=(1/7,-1/7),q=7`, actual speeds `(-34/7,33/14)` |

All arithmetic in these controls is checked by ordinary Lean proof terms
from `norm_num`, `omega`, field identities, and theorem applications. Python
only constructs the text. No finite discovery search, `native_decide`,
`sorry`, `admit`, or custom axiom is used in the accepted probe.

The observed final command, from `/home/joshua/lonely-runner-formalization`,
was:

```sh
/home/joshua/.elan/bin/lake env lean /tmp/astra-affine-components-review.lean > /tmp/astra-affine-components-review.log 2>&1
```

It exited **zero**. The exact final log SHA-256 is
`ac316de2f8d7a99d15c80d36d703ce63a67224b1513624d7977ab21cbf5f1c23`.
Its 15 `#print axioms` reports cover all 11 public source declarations and
all four review helper theorems. Every report is exactly
`[propext, Classical.choice, Quot.sound]`. The log has no errors or `sorryAx`;
its three linter warnings concern reviewer-side unused binder/simplification
style, not missing proofs or reviewed source defects.

Two earlier development probes exited one on reviewer code only. The first
needed explicit inverse/cast normalization, a finite image proof rather
than reduction through a classical instance, correct tie-case branching,
numeric simplification, and an explicit floor bound; it reported `sorryAx`
for unfinished review helpers and was rejected. The second had a redundant
`omega` after a rewrite had already closed its goal. They are recorded as
`/tmp/astra-affine-components-review-attempt1.log` and
`/tmp/astra-affine-components-review-attempt2.log`, not accepted evidence.
No reviewed source changed between these attempts or the successful replay.

## Reproducer

Run the following Python block from the repository to regenerate the exact
successful probe. The block checks every source hash and the output hash.

```python
from pathlib import Path
from hashlib import sha256
import re
spec=[
 ('AffinePhaseTransfer','069d7f05229f517639284a58d9bb10f6fd6ee8d949efc3d377361424e7381776'),
 ('LowerCountSupply','0705291adc53011fb72fc718a7260876512b092741442d6a6cceb4b76eb5ccf4'),
 ('BHKTwoPhaseSupply','2890e8ad41f9e3c2a0f098ba2a0da7060fa14ac2fe12842adf1c11905148ac09'),
 ('AffinePhasePeriod','340c4dd29276544566175cf791307ca42753ddc964345aa793d33abef1e9b176'),
 ('SimultaneousApproximation','144aec242a3f4d06853fed110bf8ee20f1cabf88b925acda889fe08cfe57c729'),
 ('PositiveAffineWitness','ed9e66d5a8944f3b5862be66f96c30abe7829c063e866504ca9e9ac1989e2e03'),
 ('SignedAffineWitness','19018618fdb454ddbdb199a29db8672bd4729bf68052736133c1d708cc26f3e5')]
new={'LonelyRunner.'+name for name,_ in spec}
imports=[]; bodies=[]; byte_counts={}
for name,wanted in spec:
    raw=Path('LonelyRunner/'+name+'.lean').read_bytes()
    assert sha256(raw).hexdigest()==wanted,name
    s=raw.decode();byte_counts[name]=len(raw)
    assert not re.search(r'\b(sorry|admit|axiom|unsafe|native_decide|run_tac)\b',s)
    for line in s.splitlines():
        if line.startswith('import '):
            mod=line[7:]
            if mod not in new and mod not in imports: imports.append(mod)
    bodies.append('\n'.join(line for line in s.splitlines() if not line.startswith('import '))+'\n')
for mod in ['LonelyRunner.StructuredClasses','Mathlib.Tactic.FinCases']:
    if mod not in imports: imports.append(mod)
# Exclude an indirect import of any frozen reviewed body as well.
seen=set()
def inspect(mod):
    assert mod not in new,mod
    if mod in seen or not mod.startswith('LonelyRunner.'): return
    seen.add(mod)
    for line in Path(mod.replace('.','/')+'.lean').read_text().splitlines():
        if line.startswith('import '): inspect(line[7:])
for mod in imports: inspect(mod)
parts=[''.join('import '+mod+'\n' for mod in imports),*bodies,'\nopen LonelyRunner\n']
public=['exists_affinePhaseTransfer','LowerCountPositiveIntegerHypothesis',
 'lowerCountPositiveIntegerHypothesis_rational','exists_lowerCount_rational_collision',
 'exists_bhk_twoPhase_margin','exists_normalized_affine_second_phase',
 'fractionalBox','fractionalBox_eq_error','exists_simultaneous_integer_approximation',
 'exists_positiveAffine_witness','exists_signedAffine_witness']
for name in public:
    parts.append(f'#check LonelyRunner.{name}\n#print axioms LonelyRunner.{name}\n')
parts.append('''
-- Eight generic theorem-contract checks, plus an exact expansion of H_N.
example {ι : Type*} (U : ι → ℤ) (V : ι → ℝ) (p x y δ ε : ℝ)
    (hp : 0 < p) (hy : 1/(2*p) < y)
    (hm : ∀ i, δ+ε ≤ circleNorm ((U i : ℝ)*x+V i*y))
    (he : ∀ i, |V i|/(2*p) ≤ ε) :
    ∃ t : ℝ, 0 < t ∧ |t-y| ≤ 1/(2*p) ∧
      ∀ i, δ ≤ circleNorm ((p*(U i : ℝ)+V i)*t) :=
  exists_affinePhaseTransfer U V p x y δ ε hp hy hm he

example (N : ℕ) : LowerCountPositiveIntegerHypothesis N ↔
    (∀ d : ℕ, 0 < d → d+2 ≤ N → ∀ v : Fin d → ℕ,
      Function.Injective v → (∀ i, 0 < v i) →
      ∃ t : ℝ, ∀ i, (1/((d:ℝ)+1)) ≤ circleNorm (t*(v i : ℝ))) := by
  constructor
  · intro h d hd hN v hi hp
    simpa [one_div] using h d (by omega) (by omega) v hi hp
  · intro h d hd hN v hi hp
    simpa [one_div] using h d (by omega) (by omega) v hi hp

example {N d : ℕ} (h : LowerCountPositiveIntegerHypothesis N)
    (hd : 1 ≤ d) (hN : d ≤ N-2) (v : Fin d → ℚ)
    (hi : Function.Injective v) (hp : ∀ i, 0 < v i) :
    ∃ t : ℝ, ∀ i, (1/((d:ℝ)+1)) ≤ circleNorm (t*(v i : ℝ)) := by
  simpa [one_div] using lowerCountPositiveIntegerHypothesis_rational h hd hN v hi hp

example {N m : ℕ} (hN : 3 ≤ N) (hm : 0 < m) (w : Fin m → ℚ)
    (hw : ∀ i, w i ≠ 0) (hc : (Finset.univ.image (fun i => |w i|)).card ≤ N-2)
    (h : LowerCountPositiveIntegerHypothesis N) :
    ∃ t : ℝ, ∀ i, (1/((N-1:ℕ):ℝ)) ≤ circleNorm (t*(w i : ℝ)) := by
  simpa [one_div] using exists_lowerCount_rational_collision hN hm w hw hc h

example {N m : ℕ} (hN : 3 ≤ N) (hm : 0 < m) (hcount : m ≤ N-1)
    (r s : Fin m → ℚ) (hp : ∀ i, 0 < r i)
    (hratio : ∃ a b, s a/r a ≠ s b/r b)
    (h : LowerCountPositiveIntegerHypothesis N) :
    ∃ a b : ℝ, ∀ i, (1/((N-1:ℕ):ℝ)) ≤
      circleNorm ((r i : ℝ)*a+(s i : ℝ)*b) := by
  simpa [one_div] using exists_bhk_twoPhase_margin hN hm hcount r s hp hratio h

example {ι : Type*} (A V : ι → ℝ) (q y0 : ℝ) (hq : 0 < q)
    (hper : ∀ i, ∃ z : ℤ, q*V i=(z:ℝ)) :
    ∃ y : ℝ, q ≤ y ∧ y < 2*q ∧
      ∀ i, circleNorm (A i+V i*y)=circleNorm (A i+V i*y0) :=
  exists_normalized_affine_second_phase A V q y0 hq hper

example {Q : ℕ} (hQ : 0 < Q) (x y : ℝ)
    (h : fractionalBox Q hQ x = fractionalBox Q hQ y) :
    |Int.fract x-Int.fract y| < 1/(Q:ℝ) := fractionalBox_eq_error hQ x y h

example (d Q : ℕ) (hQ : 0 < Q) (x : Fin d → ℝ) :
    ∃ q : ℕ, 0 < q ∧ q ≤ Q^d ∧ ∃ z : Fin d → ℤ, ∀ i,
      |(q:ℝ)*x i-(z i:ℝ)| < 1/(Q:ℝ) :=
  exists_simultaneous_integer_approximation d Q hQ x

example {N m : ℕ} (hN : 3 ≤ N) (hm : 0 < m) (hc : m ≤ N-1)
    (U : Fin m → ℤ) (V : Fin m → ℚ) (p : ℚ) (hp : 1 < p)
    (q : ℝ) (hq : 1 ≤ q) (hper : ∀ i, ∃ z : ℤ, q*(V i:ℝ)=(z:ℝ))
    (hpos : ∀ i, 0 < p*(U i:ℚ)+V i)
    (hn : ∃ a b, (U a:ℚ)/(p*(U a:ℚ)+V a) ≠ (U b:ℚ)/(p*(U b:ℚ)+V b))
    (he : ∀ i, |(V i:ℝ)|/(2*(p:ℝ)) ≤ 1/((N*(N-1):ℕ):ℝ))
    (h : LowerCountPositiveIntegerHypothesis N) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      1/(N:ℝ) ≤ circleNorm (t*((p:ℝ)*(U i:ℝ)+(V i:ℝ))) := by
  simpa [one_div] using exists_positiveAffine_witness hN hm hc U V p hp q hq hper hpos hn (by simpa [one_div] using he) h

-- An honest lower-count premise for N=3, proved directly from one speed.
theorem reviewAffine_H3 : LowerCountPositiveIntegerHypothesis 3 := by
  intro d hd hdl speeds _hinj hpos
  have hd1 : d=1 := by omega
  subst d
  let v : ℝ := (speeds 0 : ℝ)
  have hv : 0 < v := by dsimp [v]; exact_mod_cast hpos 0
  refine ⟨1/(2*v), ?_⟩
  intro i
  have hi : i=0 := Subsingleton.elim _ _
  subst i
  have hp : (1/(2*v))*v = (1/2:ℝ) := by field_simp [ne_of_gt hv]
  have hb : (1/2:ℝ) ≤ circleNorm ((1/(2*v))*v) := by
    rw [hp]
    apply circleNorm_ge_of_int_band 0
    all_goals norm_num
  simpa [v] using hb
#print axioms reviewAffine_H3

-- Clearing a denominator multiplies time. One rational speed is nonvacuous.
example : ∃ t : ℝ, ∀ i : Fin 1, (1/2:ℝ) ≤ circleNorm (t*((1/5:ℚ):ℝ)) := by
  simpa using lowerCountPositiveIntegerHypothesis_rational reviewAffine_H3
    (d:=1) (by omega) (by omega) (fun _ => (1/5:ℚ))
    (by intro a b _; exact Subsingleton.elim _ _) (by intro i; norm_num)
example : rationalCommonDenominator (fun _ : Fin 1 => (1/5:ℚ)) = 5 := by
  norm_num [rationalCommonDenominator]
example : circleNorm ((5/2:ℝ)*(1/5)) = 1/2 := by
  norm_num
  rw [circleNorm_eq_abs_of_abs_le_half (by norm_num)]
  norm_num
example : circleNorm ((1/10:ℝ)*(1/5)) = 1/50 := by
  norm_num
  rw [circleNorm_eq_abs_of_abs_le_half (by norm_num)]
  norm_num

-- Four signed coordinates use only one distinct positive magnitude.
def reviewAffine_collision : Fin 4 → ℚ := ![1/5,-1/5,1/5,-1/5]
theorem reviewAffine_collisionCard :
    (Finset.univ.image (fun i => |reviewAffine_collision i|)).card = 1 := by
  have hs : Finset.univ.image (fun i => |reviewAffine_collision i|) = {(1/5:ℚ)} := by
    ext x
    simp only [Finset.mem_image, Finset.mem_univ, true_and, Finset.mem_singleton]
    constructor
    · rintro ⟨i,rfl⟩
      fin_cases i <;> norm_num [reviewAffine_collision]
    · rintro rfl
      exact ⟨0,by norm_num [reviewAffine_collision]⟩
  rw [hs]
  simp
example : ∃ t : ℝ, ∀ i, (1/2:ℝ) ≤ circleNorm (t*(reviewAffine_collision i:ℝ)) := by
  simpa using exists_lowerCount_rational_collision (N:=3) (by omega) (by omega)
    reviewAffine_collision (by intro i; fin_cases i <;> norm_num [reviewAffine_collision])
    (by rw [reviewAffine_collisionCard]) reviewAffine_H3

-- BHK phases are free; the original row's relation need not annihilate w.
example : ∃ a b : ℝ, ∀ i : Fin 2, (1/2:ℝ) ≤
    circleNorm ((![2,3] i : ℝ)*a+(![1,0] i : ℝ)*b) := by
  simpa using exists_bhk_twoPhase_margin (N:=3) (by omega) (by omega) (by omega)
    (![2,3] : Fin 2 → ℚ) (![1,0] : Fin 2 → ℚ)
    (by intro i; fin_cases i <;> norm_num)
    (by refine ⟨0,1,?_⟩; norm_num) reviewAffine_H3
example : (3:ℚ)*2-2*3=0 ∧ 3*3-2*(-3)≠0 := by norm_num
example : ∀ i : Fin 2, (1/2:ℝ) ≤
    circleNorm ((![2,3] i : ℝ)*(1/6)+(![1,0] i : ℝ)*(1/6)) := by
  intro i; fin_cases i <;> apply circleNorm_ge_of_int_band 0 <;> norm_num

-- Negative integer slopes and residuals, sharp error and closed target.
example : ∃ t : ℝ, 0 < t ∧ |t-1| ≤ 1/4 ∧ ∀ i : Fin 2,
    (1/4:ℝ) ≤ circleNorm ((2*(![-1,1] i : ℤ)+(![-1,1] i : ℝ))*t) := by
  convert exists_affinePhaseTransfer (![-1,1] : Fin 2 → ℤ)
    (![-1,1] : Fin 2 → ℝ) 2 (-1/2) 1 (1/4) (1/4)
    (by norm_num) (by norm_num)
    (by
      intro i
      fin_cases i
      · apply circleNorm_ge_of_int_band (-1); all_goals norm_num
      · apply circleNorm_ge_of_int_band 0; all_goals norm_num)
    (by intro i; fin_cases i <;> norm_num) using 1 <;> norm_num

-- Normalize by q=4, a nonminimal period for V=+/-1/2, at negative y0.
example : ∃ y : ℝ, 4 ≤ y ∧ y < 8 ∧ ∀ i : Fin 2,
    circleNorm ((![(1/2:ℝ),-1/2] i)*y) =
    circleNorm ((![(1/2:ℝ),-1/2] i)*(-5/3)) := by
  have h := exists_normalized_affine_second_phase (fun _ : Fin 2 => (0:ℝ))
    (![(1/2:ℝ),-1/2] : Fin 2 → ℝ) 4 (-5/3) (by norm_num)
    (by intro i; fin_cases i; exact ⟨2,by norm_num⟩; exact ⟨-2,by norm_num⟩)
  norm_num at h ⊢
  exact h
example : (4:ℝ) ≤ 19/3 ∧ (19/3:ℝ) < 8 ∧ (19/3:ℝ)-(-5/3)=2*4 := by norm_num
example : circleNorm ((1/2:ℝ)*(-5/3)) = 1/6 := by
  have h : (1/2:ℝ)*(-5/3) = (-1:ℤ)+(1/6:ℝ) := by norm_num
  rw [h,circleNorm_add_int,circleNorm_eq_abs_of_abs_le_half (by norm_num)]
  norm_num
example : circleNorm ((1/2:ℝ)*(4/3)) = 1/3 := by
  have h : (1/2:ℝ)*(4/3) = (1:ℤ)+(-1/3:ℝ) := by norm_num
  rw [h,circleNorm_add_int,circleNorm_eq_abs_of_abs_le_half (by norm_num)]
  norm_num

-- Positive affine row, sharp residual loss: original moving speeds 14,18.
example : ∃ t : ℝ, 0 < t ∧ ∀ i : Fin 2,
    (1/3:ℝ) ≤ circleNorm (t*(![14,18] i : ℝ)) := by
  have h := exists_positiveAffine_witness (N:=3) (by omega) (by omega) (by omega)
    (![2,3] : Fin 2 → ℤ) (![2,0] : Fin 2 → ℚ) 6 (by norm_num)
    1 (by norm_num)
    (by intro i; fin_cases i; exact ⟨2,by norm_num⟩; exact ⟨0,by norm_num⟩)
    (by intro i; fin_cases i <;> norm_num)
    (by refine ⟨0,1,?_⟩; norm_num)
    (by intro i; fin_cases i <;> norm_num) reviewAffine_H3
  norm_num at h ⊢
  exact h

-- Constant ratios are excluded even if the small residual bound holds.
example : (∀ i : Fin 2, |(![1,2] i : ℝ)|/(2*100) ≤ 1/6) ∧
    ¬ ∃ a b : Fin 2, (![(1:ℚ),2] a)/(100*(![1,2] a)+(![1,2] a)) ≠
      (![(1:ℚ),2] b)/(100*(![1,2] b)+(![1,2] b)) := by
  constructor
  · intro i; fin_cases i <;> norm_num
  · rintro ⟨a,b,h⟩; fin_cases a <;> fin_cases b <;> norm_num at h

-- Q=1 forces q=1, for every dimension, including the empty domain.
theorem reviewAffine_Q1 (d : ℕ) (x : Fin d → ℝ) :
    ∃ z : Fin d → ℤ, ∀ i, |x i-(z i:ℝ)| < 1 := by
  obtain ⟨q,hq,hb,z,hz⟩ := exists_simultaneous_integer_approximation d 1 (by omega) x
  have hb1 : q ≤ 1 := by simpa using hb
  have hq1 : q=1 := by omega
  subst q
  exact ⟨z,by simpa using hz⟩
#print axioms reviewAffine_Q1
example : ∃ q : ℕ, q=1 ∧ ∃ z : Fin 0 → ℤ, ∀ i,
    |(q:ℝ)*(Fin.elim0 i : ℝ)-(z i:ℝ)| < 1 := by
  obtain ⟨q,hq,hb,z,hz⟩ := exists_simultaneous_integer_approximation 0 1 (by omega)
    (fun i => (Fin.elim0 i : ℝ))
  have hq1 : q=1 := by norm_num at hb; omega
  exact ⟨q,hq1,z,by simpa using hz⟩
example : ∃ q : ℕ, 0 < q ∧ q ≤ 9 ∧ ∃ z : Fin 2 → ℤ, ∀ i,
    |(q:ℝ)*(![-1/6,1/3] i : ℝ)-(z i:ℝ)| < 1/3 := by
  simpa using exists_simultaneous_integer_approximation 2 3 (by omega)
    (![-1/6,1/3] : Fin 2 → ℝ)
theorem reviewAffine_floor19 : ⌊(19/10:ℝ)⌋₊ = 1 := by
  apply (Nat.floor_eq_iff (by norm_num)).mpr
  norm_num
example : fractionalBox 6 (by omega) (-5/6) = fractionalBox 6 (by omega) (19/60) := by
  apply Fin.ext
  norm_num [fractionalBox,Int.fract]
  exact reviewAffine_floor19.symm
example : |Int.fract (-5/6:ℝ)-Int.fract (19/60:ℝ)| < 1/6 :=
  fractionalBox_eq_error (by omega : 0 < 6) (-5/6) (19/60)
    (by apply Fin.ext; norm_num [fractionalBox,Int.fract]; exact reviewAffine_floor19.symm)
example : fractionalBox 6 (by omega) 0 ≠ fractionalBox 6 (by omega) (1/6) := by
  norm_num [fractionalBox,Int.fract]
''')
# Both nearest-integer ties of p*y-x=5/2 attain the allowed error.
for j,t in [(2,'3/4'),(3,'5/4')]:
    parts.append(f'''\nexample : |(5/2:ℝ)-{j}|=1/2 ∧ ({t}:ℝ)=({j}-1/2)/2 ∧
    0<({t}:ℝ) ∧ |({t}:ℝ)-1|=1/4 := by norm_num
''')
    for speed,k in [(-3,-3 if j==2 else -4),(3,2 if j==2 else 3)]:
        parts.append(f'''example : (1/4:ℝ) ≤ circleNorm ({speed}*({t}:ℝ)) := by
  apply circleNorm_ge_of_int_band ({k})
  all_goals norm_num
''')
for q in [5,10]:
    parts.append(f'''\nexample : ∃ t : ℝ, 0<t ∧ ∀ i : Fin 2,
    (1/3:ℝ) ≤ circleNorm (t*((9/4:ℝ)*(![1,3] i : ℤ)+(![1/5,0] i : ℚ))) := by
  simpa using exists_positiveAffine_witness (N:=3) (by omega) (by omega) (by omega)
    (![1,3] : Fin 2 → ℤ) (![1/5,0] : Fin 2 → ℚ) (9/4) (by norm_num)
    {q} (by norm_num)
    (by intro i; fin_cases i; exact ⟨{q//5},by norm_num⟩; exact ⟨0,by norm_num⟩)
    (by intro i; fin_cases i <;> norm_num)
    (by refine ⟨0,1,?_⟩; norm_num)
    (by intro i; fin_cases i <;> norm_num) reviewAffine_H3
''')
parts.append('''
example {N m : ℕ} (hN : 3 ≤ N) (hm : 0 < m) (hc : m ≤ N-1)
    (U : Fin m → ℤ) (V : Fin m → ℚ) (p : ℚ) (hp : 1 < p)
    (q : ℝ) (hq : 1 ≤ q) (hper : ∀ i, ∃ z : ℤ, q*(V i:ℝ)=(z:ℝ))
    (ha : ∀ i, p*(U i:ℚ)+V i ≠ 0)
    (hn : ∃ a b, (U a:ℚ)/(p*(U a:ℚ)+V a) ≠ (U b:ℚ)/(p*(U b:ℚ)+V b))
    (he : ∀ i, |(V i:ℝ)|/(2*(p:ℝ)) ≤ 1/((N*(N-1):ℕ):ℝ))
    (h : LowerCountPositiveIntegerHypothesis N) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      1/(N:ℝ) ≤ circleNorm (t*((p:ℝ)*(U i:ℝ)+(V i:ℝ))) := by
  simpa [one_div] using exists_signedAffine_witness hN hm hc U V p hp q hq hper ha hn
    (by simpa [one_div] using he) h

-- Signed actual speeds -34/7 and 33/14; no sign/count premise is postulated.
example : ∃ t : ℝ, 0<t ∧ ∀ i : Fin 2,
    (1/3:ℝ) ≤ circleNorm (t*((5/2:ℝ)*(![-2,1] i : ℤ)+(![1/7,-1/7] i : ℚ))) := by
  simpa using exists_signedAffine_witness (N:=3) (by omega) (by omega) (by omega)
    (![-2,1] : Fin 2 → ℤ) (![1/7,-1/7] : Fin 2 → ℚ) (5/2) (by norm_num)
    7 (by norm_num)
    (by intro i; fin_cases i; exact ⟨1,by norm_num⟩; exact ⟨-1,by norm_num⟩)
    (by intro i; fin_cases i <;> norm_num)
    (by refine ⟨0,1,?_⟩; norm_num)
    (by intro i; fin_cases i <;> norm_num) reviewAffine_H3
''')
parts.append('#print axioms reviewAffine_collisionCard\n#print axioms reviewAffine_floor19\n')
probe=Path('/tmp/astra-affine-components-review.lean')
probe.write_text(''.join(parts))
assert sha256(probe.read_bytes()).hexdigest()=='2d79b805f1612d2fde0cda1014f343fff58d132ceb7bb11807c94b4da6d1e842'
assert len(re.findall(r'^example\b',probe.read_text(),re.M))==39
assert len(re.findall(r'^theorem reviewAffine_',probe.read_text(),re.M))==4
print({'source_bytes':byte_counts,'public_declarations':len(public),
 'generic_contract_checks':10,'fixed_control_declarations':29,'review_helper_theorems':4,'preexisting_project_import_closure':len(seen),
 'probe_sha256':sha256(probe.read_bytes()).hexdigest(), 'probe_bytes':len(probe.read_bytes())})
```

Extract and run the generator without copying it manually:

```sh
python3 -B - <<'AFFINE_COMPONENT_REPLAY'
from pathlib import Path
import re
p=Path('research/astra-affine-components-formal-review.md')
blocks=re.findall(r'^```python\n(.*?)^```[ \t]*$',p.read_text(),re.M|re.S)
assert len(blocks)==1
exec(compile(blocks[0],str(p),'exec'),{})
AFFINE_COMPONENT_REPLAY
/home/joshua/.elan/bin/lake env lean /tmp/astra-affine-components-review.lean > /tmp/astra-affine-components-review.log 2>&1
```

The generator prints seven source sizes (23,205 bytes total), 11 public
source declarations, 10 generic contract checks, 29 fixed control declarations,
four review helper theorems, eight preexisting project modules in the import
closure, and the exact 37,894-byte probe hash stated above. The saved
manuscript's generator was extracted and replayed; it reproduced the already
successful probe bytes. All source bindings were rechecked unchanged.

Only this review and its small `/tmp` probe/generator/log files were written.
There was no source/state/Git/import/audit/cache change, dependency restoration,
cleanup, full project build, or tuple discovery. All reviewer commands were
terminated normally at the final handoff, with no background command queued.
The accepted boundary is the seven named components. A complete original-label
bridge and primitive finite-height theorem require separate frozen source and
review; general `H_N`, the retained finite families `F_N`, and unrestricted canonical
LRC remain unsupplied by this component checkpoint.
