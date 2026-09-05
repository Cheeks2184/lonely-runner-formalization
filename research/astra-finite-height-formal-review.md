# Independent formal review of the conditional finite-height theorem

**Disposition: accepted at the exact conditional public type below.** The
five frozen adapters and final theorem agree with the accepted manuscript;
no source correction or extra caller premise is required. Fresh elaboration
of all twelve new source bodies, exact contract checks, nonvacuous canonical
fixtures, and 25 axiom reports passed. The only reported axioms are
`propext`, `Classical.choice`, and `Quot.sound`.

This accepts `LonelyRunner.primitive_sorted_largeHeight_lonelyAt` under
`LowerCountPositiveIntegerHypothesis (m+2)`. It does not prove that premise,
the inclusive finite families F_N, or unrestricted LRC. The theorem takes
already sorted primitive natural speeds; a wrapper normalizing arbitrary
integer configurations is outside its formal type and is not silently claimed.

Assignment checkpoint: `26a06cd76f9bb2f912f6365ace6b95f86ebe0322`,
parent-reported branch `codex/astra-affine-finite-height`. Requested routing:
Astra xhigh. The runtime did not independently expose model/effort metadata.
Registered task: `/root/cluster_limit_review-finite-height-formal`.
Current configuration, workflow document, policy, and state were read;
`python3 scripts/validate_workflow.py` passed. Research remains active and
the canonical completion gate remains unmet. Only this review and small
temporary probe/generator/log files were written.

## Frozen sources

The final theorem was initially under construction. Its provisional body
was not accepted; the final root-supplied hash below was verified and the
complete frozen body was reread before the full replay. The same applies
to the frozen hashes of the four other adapters.

All module paths are under `LonelyRunner/`.

| Module | Bytes | SHA-256 |
| --- | ---: | --- |
| `LowerCountSupply.lean` | 4613 | `0705291adc53011fb72fc718a7260876512b092741442d6a6cceb4b76eb5ccf4` |
| `BHKTwoPhaseSupply.lean` | 2381 | `2890e8ad41f9e3c2a0f098ba2a0da7060fa14ac2fe12842adf1c11905148ac09` |
| `AffinePhasePeriod.lean` | 2030 | `340c4dd29276544566175cf791307ca42753ddc964345aa793d33abef1e9b176` |
| `AffinePhaseTransfer.lean` | 2331 | `069d7f05229f517639284a58d9bb10f6fd6ee8d949efc3d377361424e7381776` |
| `PositiveAffineWitness.lean` | 3820 | `ed9e66d5a8944f3b5862be66f96c30abe7829c063e866504ca9e9ac1989e2e03` |
| `SignedAffineWitness.lean` | 3324 | `19018618fdb454ddbdb199a29db8672bd4729bf68052736133c1d708cc26f3e5` |
| `SimultaneousApproximation.lean` | 4706 | `144aec242a3f4d06853fed110bf8ee20f1cabf88b925acda889fe08cfe57c729` |
| `RationalPairRank.lean` | 3900 | `8ab0d557ad561415b2fdf06566482e780fca1aa5b37c2a9e2340c24805ca6cbe` |
| `PrimitiveAffineRank.lean` | 1930 | `0b82838ac09e0572a329d7fe12091c250caa746441216e5a7ec84ceb7ff89eb9` |
| `EndpointAffineApproximation.lean` | 2662 | `19989c0528c028bd0bcb8ef4e514ac35177fafd1a0f889e69b82f25651aaa3d3` |
| `AffineLonelyAt.lean` | 2818 | `19ef8e3e8b5cc0364b74d13cfb93b608adf176ffdbb1a7e020e2d5f1b484ec7b` |
| `FiniteHeightReduction.lean` | 5285 | `61a5ac9e27c58db10bf014bd91346769665038ebb3c05689237870de49279be1` |

Relevant manuscript/contract evidence was also read:

| File | SHA-256 |
| --- | --- |
| `research/astra-affine-finite-height-audit.md` | `6b676a05eb3a0036cd69e779150a5f1a868024d089ea75c142daeddccede938f` |
| `research/astra-affine-finite-height-review.md` | `eb0fb96e22096175fa3b68dc70a1b7981f39356aaf1377863dcaa95b6a510876` |
| `research/astra-affine-formal-contract.md` | `20ab1efc37e90d4838732098741e5b6486166ef0a737d794492eb9a41fe60a75` |
| `research/astra-affine-components-formal-review.md` | `6f025889a586ea05fba9ba40c11d0db2c02c19bde00c3ac7070f9cada28dc3de` |

The seven-component review's earlier probes were read as corroborating
evidence, not used instead of this fresh twelve-body replay. Its safe
concatenation approach was reused: imports of all new modules are removed,
the actual complete bodies are retained in dependency order, and the
transitive preexisting project import closure is checked to exclude indirect
imports of any new module. The independent adapter controls below are new.

## Exact theorem and count audit

The public declaration is:

```lean
theorem primitive_sorted_largeHeight_lonelyAt {m : ℕ} (hm : 1 ≤ m)
    (hLower : LowerCountPositiveIntegerHypothesis (m + 2))
    (s : Fin (m + 2) → ℕ)
    (hsorted : StrictMono s) (hs0 : s 0 = 0)
    (hprimitive : Finset.univ.gcd s = 1)
    (hheight : ((m + 2) * (m + 1)) ^ m < s (Fin.last (m + 1))) :
    ∀ runner : Fin (m + 2), ∃ t : ℝ, 0 < t ∧
      LonelyAt (fun i => (s i : ℝ)) runner t
```

Every N>=3 is m+2 for m=N-2>=1. Thus the cutoff is exactly
[N(N-1)]^(N-2), with a strict inequality on the large-height side. The
probe checks this natural-number reindexing explicitly. The full family
has m+2 original labels, m+1 comparisons after deleting the chosen label,
and m simultaneous-approximation coordinates. These three counts are not
interchanged. `StrictMono` implies injectivity of the original speeds.

`LowerCountPositiveIntegerHypothesis N` retains precisely every nonempty
injective positive natural tuple with d<=N-2 moving speeds, at its own
closed threshold 1/(d+1). It is not global LRC, same-count LRC, or a
height-bounded variant. The probe checks its equivalence with 0<d and
d+2<=N. The final caller supplies no affine rank, approximation error,
nonconstant-ratio, period, auxiliary tuple, or witness premise.

`LonelyAt` is the existing canonical predicate on the original `Fin (m+2)`
speed family: distance at least 1/(m+2) from every other original label.
The public existential includes `0<t`. A different t may be chosen for
each runner; there is no simultaneous all-runners-at-one-time claim.

## Adapter and composition review

`RationalPairRankTwo` is an explicit nonzero two-by-two minor of the
integer/rational rows. `rationalPairRankTwo_elim` multiplies and subtracts
two linear relations, then cancels that nonzero minor. It needs neither
positivity nor distinctness of the integer row. The formal path uses this
elimination direction, so an unproved converse rank characterization is
not being assumed.

`relative_ratio_nonconstant_of_rankTwo` uses `r.succAbove` to enumerate
exactly the complement of an arbitrary chosen r. Actual speed injectivity
keeps each denominator nonzero. If the ratios were constant lambda, all
relative pairs would satisfy `(1-lambda*p)*U-lambda*V=0`. Including the
chosen label and evaluating at the original anchor zero transports this
relation back to all original pairs. Elimination forces both 1-lambda*p
and -lambda to vanish, a contradiction. Interior/last runners and negative
or repeated u-coordinates are supported. No special choice r=0 is hidden.

`primitive_dvd_of_scaled_dvd` is a joint-gcd argument over any finite
index type. The finite gcd of q*s is q times the finite gcd of s in the
natural-number normalization; hence divisibility of every q*s_i by H and
gcd(s)=1 imply H|q. It does not assume an individually coprime coordinate.
An empty-index instance cannot misuse the premise: its natural gcd is zero,
so gcd(s)=1 would be false. The public applications have nonempty Fin types.

`rankTwo_of_primitive_approximation` argues that if all minors vanish,
the endpoint u_last=q>0 and v_last=0 force every v_i=0. The supplied
identity then gives H*u_i=q*s_i. The integer u_i may be negative; conversion
through integer divisibility to natural divisibility is explicit. The
joint-gcd lemma yields H|q, contradicting 0<q<H. The public theorem itself
constructs all the endpoint and identity hypotheses of this adapter.

`exists_endpoint_affine_approximation` applies the actual simultaneous
approximation theorem to precisely `j.castSucc.succ` for j in Fin m.
It extends the returned internal integer row with u0=0 and u_last=q.
Both endpoint errors are exactly zero, and all other errors remain strictly
below 1/Q after the real-to-rational cast. No internal labels or endpoint
constraints are dropped. The theorem is valid at m=0 as a genuine two-endpoint
packet; the final large-height theorem deliberately requires m>=1.

The underlying pigeonhole theorem uses Q^m+1 indices and Q^m half-open
boxes, forms a positive natural index difference in either ordering, and
returns q<=Q^m with strict error. Its preconditions include Q>0. This
endpoint wrapper does not invoke a hypothetical Dirichlet interface.

`rational_affine_lonelyAt` forms signed differences at every label in the
chosen runner's complement. Relative periods are obtained by subtracting
the two integral witnesses for q*v. Its error conversion divides by the
positive 2p and uses epsilon=1/[(m+2)(m+1)]. It calls the signed affine
theorem at N=m+2 and comparison count m+1, then uses the existing
`lonelyAt_iff_relativeLonelyAt` bridge and `Fin.exists_succAbove_eq` to
restore every original label. Negative comparisons retain their circle
norm. The original family and original closed threshold are preserved.

The seven supporting bodies were read in full. They clear rational
denominators by multiplying the witness time, deduplicate absolute values
of a nonzero opposite-coordinate collision, and invoke only H_N at that
smaller count. They normalize the second phase using its actual common
period q, preserve signed relative ratios, and round the first affine phase
to an integer. The final phase error is V*(t-y), not the large actual speed
times that displacement. The exact identity 1/(N-1)-1/[N(N-1)]=1/N leaves
the closed endpoint intact. None invokes the relation-compatible BHK
wrapper while omitting its relation premise.

`primitive_sorted_largeHeight_lonelyAt` constructs Q, H, q, u, p=H/q,
and v=s-p*u internally. From q<=Q^m<H it obtains p>1; endpoint identities
give zero anchor offsets, an integral common period q, and rank two by
primitivity. It reconstructs the actual original speeds exactly, and uses
strict monotonicity only to obtain their injectivity. Multiplying each
approximation error by positive p gives |v_i|<=p/Q; the triangle inequality
supplies |v_i-v_runner|<=2p/Q for every runner. Finally, function equality
rewrites the affine rational family back to the original natural-speed
family inside canonical `LonelyAt`. All caller hypotheses are consumed in
the intended direction.

The inclusive bound H=Q^m remains outside this large-height conclusion.
At that boundary q=H and p=1 can occur. Without primitivity, exact rank-one
approximations can occur above the bound. The final type is therefore neither
weakened to a caller-supplied affine representation nor overextended past
its rank-exclusion hypotheses.

## Fresh-source kernel evidence

Pinned Lean: `leanprover/lean4:v4.32.1`. Pinned mathlib revision from the
manifest: `520045ab14e26149ee970e2e617ca04b09bde5d6`. One existing shared
dependency cache was used. The probe imports only preexisting modules, with
an independently checked transitive project import closure of eleven modules.
All twelve new complete bodies, including the final theorem's private
helpers, are elaborated from source in the same probe. No newly compiled
object for any of these twelve modules can supply a declaration instead.
This is not a fresh source rebuild of all preexisting dependencies or the
full project; those remain the root's integration checks.

The final 49,519-byte probe is bound by SHA-256
`a23af085457a150bb571573e58b37fccc40ab6a35e5194fd953e83bc14390480`.
It contains nineteen public-declaration/axiom checks, sixteen examples,
and six named review theorems. Seven examples check generic contracts and
count coverage; nine check fixed adapter data or invalid hypotheses.

The named H3 proof uses the existing `oneMovingRunner`. H4 uses that same
case plus the existing `twoMovingRunners`. These are actual proofs of the
required lower-count premises for the fixtures, not assumed propositions.
The final public theorem is then applied without extra assumptions to
(0,2,11), at all three chosen labels, and (0,2,87,174), at all four chosen
labels. The latter has gcd one although gcd(2,174)>1 and gcd(87,174)>1.

Two further canonical fixture theorems use signed u=(0,-2,1), rational
v=(0,1/7,-1/7), p=5/2, and all three chosen labels, once with period 7 and
once with the nonminimal period 14. Separate controls cover the m=0 packet,
one internal coordinate with an explicit negative approximation error,
rank supplied by the joint-gcd adapter, the excluded inclusive height bound,
a nonprimitive tuple above the bound, rank-one zero residuals, and rejection
of m=0 by the final theorem's count premise. These fixtures do not exhaust
or certify any F_N.

The first development probe exited one only because four reviewer fixture
goals did not simplify vector notation at literal `Fin.last`/index values.
All twelve source declarations and the two public height fixtures already
elaborated; two unfinished reviewer signed-fixture proofs accordingly showed
`sorryAx` in that failed diagnostic run. Its probe hash was
`c0d7aaf7b7593fa358286430921da5206745e1f3fb139acf33dbba6656c51f84`.
The fixture goals were replaced with explicit definitionally equal numeric
goals. No source body or theorem statement was changed. The corrected
complete replay exited zero, and the strict log check below verifies exactly
25 reports, all within the permitted axiom set, with no error or `sorryAx`.

Observed logs:

| Log | SHA-256 | Result |
| --- | --- | --- |
| `/tmp/astra-finite-height-formal-review.log` | `df73f5c0a3f4cd6e21d0467594b1a5a2a6451463df6356f387b90f4fef88aaeb` | exit 0, final |
| `/tmp/astra-finite-height-formal-review-initial.log` | `a89d9dd903f9be9761ab12875ed5b0cd9ae221e4a0fb3612c153b4dc1a8a822a` | exit 1, rejected reviewer-fixture draft |

## Complete reproducer

The first Python block generates the exact successful probe and verifies all
twelve source hashes, import exclusion, example counts, and output hash.
Its SHA-256 is
`88aee9e7bd437c513e00ad68cd126c7fc0a91f2d447cf0680447cf041d8805e2`.

```python
from pathlib import Path
from hashlib import sha256
import re
import json

spec = [
 ('LowerCountSupply','0705291adc53011fb72fc718a7260876512b092741442d6a6cceb4b76eb5ccf4'),
 ('BHKTwoPhaseSupply','2890e8ad41f9e3c2a0f098ba2a0da7060fa14ac2fe12842adf1c11905148ac09'),
 ('AffinePhasePeriod','340c4dd29276544566175cf791307ca42753ddc964345aa793d33abef1e9b176'),
 ('AffinePhaseTransfer','069d7f05229f517639284a58d9bb10f6fd6ee8d949efc3d377361424e7381776'),
 ('PositiveAffineWitness','ed9e66d5a8944f3b5862be66f96c30abe7829c063e866504ca9e9ac1989e2e03'),
 ('SignedAffineWitness','19018618fdb454ddbdb199a29db8672bd4729bf68052736133c1d708cc26f3e5'),
 ('SimultaneousApproximation','144aec242a3f4d06853fed110bf8ee20f1cabf88b925acda889fe08cfe57c729'),
 ('RationalPairRank','8ab0d557ad561415b2fdf06566482e780fca1aa5b37c2a9e2340c24805ca6cbe'),
 ('PrimitiveAffineRank','0b82838ac09e0572a329d7fe12091c250caa746441216e5a7ec84ceb7ff89eb9'),
 ('EndpointAffineApproximation','19989c0528c028bd0bcb8ef4e514ac35177fafd1a0f889e69b82f25651aaa3d3'),
 ('AffineLonelyAt','19ef8e3e8b5cc0364b74d13cfb93b608adf176ffdbb1a7e020e2d5f1b484ec7b'),
 ('FiniteHeightReduction','61a5ac9e27c58db10bf014bd91346769665038ebb3c05689237870de49279be1'),
]
new = {'LonelyRunner.'+name for name,_ in spec}
imports, bodies, source_bytes = [], [], {}
for name,expected in spec:
    path = Path('LonelyRunner')/(name+'.lean')
    raw = path.read_bytes()
    assert sha256(raw).hexdigest() == expected,name
    source_bytes[name] = len(raw)
    s = raw.decode()
    assert not re.search(r'\b(sorry|admit|axiom|unsafe|native_decide|run_tac)\b',s)
    for line in s.splitlines():
        if line.startswith('import '):
            module = line[7:]
            if module not in new and module not in imports:
                imports.append(module)
    bodies.append('\n'.join(line for line in s.splitlines() if not line.startswith('import '))+'\n')
for module in ['LonelyRunner.SmallDimensions','Mathlib.Tactic.FinCases']:
    if module not in imports:
        imports.append(module)
closure = set()
def inspect(module):
    assert module not in new, 'indirect new-module import: '+module
    if module in closure or not module.startswith('LonelyRunner.'):
        return
    closure.add(module)
    for line in Path(module.replace('.','/')+'.lean').read_text().splitlines():
        if line.startswith('import '):
            inspect(line[7:])
for module in imports:
    inspect(module)

parts = [''.join('import '+module+'\n' for module in imports), *bodies,
         '\nopen LonelyRunner\nset_option maxHeartbeats 800000\n']
public = ['LowerCountPositiveIntegerHypothesis',
 'lowerCountPositiveIntegerHypothesis_rational','exists_lowerCount_rational_collision',
 'exists_bhk_twoPhase_margin','exists_normalized_affine_second_phase',
 'exists_affinePhaseTransfer','exists_positiveAffine_witness','exists_signedAffine_witness',
 'fractionalBox','fractionalBox_eq_error','exists_simultaneous_integer_approximation',
 'RationalPairRankTwo','rationalPairRankTwo_elim','relative_ratio_nonconstant_of_rankTwo',
 'primitive_dvd_of_scaled_dvd','rankTwo_of_primitive_approximation',
 'exists_endpoint_affine_approximation','rational_affine_lonelyAt',
 'primitive_sorted_largeHeight_lonelyAt']
for name in public:
    parts.append('#check LonelyRunner.'+name+'\n#print axioms LonelyRunner.'+name+'\n')
parts.append(r'''
-- Exact lower-count premise and five adapter/public theorem contracts.
example (N : ℕ) : LowerCountPositiveIntegerHypothesis N ↔
    (∀ d : ℕ, 0 < d → d+2 ≤ N → ∀ s : Fin d → ℕ,
      Function.Injective s → (∀ i, 0 < s i) →
        ∃ t : ℝ, ∀ i, (1/((d:ℝ)+1)) ≤ circleNorm (t*(s i:ℝ))) := by
  constructor
  · intro h d hd hc s hi hp
    simpa [one_div] using h d (by omega) (by omega) s hi hp
  · intro h d hd hc s hi hp
    simpa [one_div] using h d (by omega) (by omega) s hi hp

example {ι : Type*} (u : ι → ℤ) (v : ι → ℚ)
    (hr : RationalPairRankTwo u v) (a b : ℚ)
    (he : ∀ i, a*(u i:ℚ)+b*v i=0) : a=0 ∧ b=0 :=
  rationalPairRankTwo_elim u v hr a b he

example {ι : Type*} [Fintype ι] (s : ι → ℕ)
    (hs : Finset.univ.gcd s=1) (H q : ℕ) (h : ∀ i, H ∣ q*s i) : H ∣ q :=
  primitive_dvd_of_scaled_dvd s hs H q h

example {m : ℕ} (s : Fin (m+2) → ℕ) (H Q : ℕ)
    (hH : 0<H) (hQ : 0<Q) (hz : s 0=0) (hl : s (Fin.last (m+1))=H) :
    ∃ q : ℕ, 1≤q ∧ q≤Q^m ∧ ∃ u : Fin (m+2) → ℤ,
      u 0=0 ∧ u (Fin.last (m+1))=(q:ℤ) ∧
      ∀ i, |(q:ℚ)*(s i:ℚ)/(H:ℚ)-(u i:ℚ)| < 1/(Q:ℚ) :=
  exists_endpoint_affine_approximation s H Q hH hQ hz hl

example {m : ℕ} (hm : 1≤m)
    (hL : LowerCountPositiveIntegerHypothesis (m+2))
    (u : Fin (m+2) → ℤ) (v : Fin (m+2) → ℚ)
    (p : ℚ) (hp : 1<p) (q : ℕ) (hq : 0<q)
    (hu : u 0=0) (hv : v 0=0) (hr : RationalPairRankTwo u v)
    (hi : Function.Injective (fun i => p*(u i:ℚ)+v i))
    (hperiod : ∀ i, ∃ z : ℤ, (q:ℚ)*v i=(z:ℚ)) (r : Fin (m+2))
    (he : ∀ i, |v i-v r| ≤ 2*p/(((m+2)*(m+1):ℕ):ℚ)) :
    ∃ t : ℝ, 0<t ∧ LonelyAt (fun i => ((p*(u i:ℚ)+v i:ℚ):ℝ)) r t :=
  rational_affine_lonelyAt hm hL u v p hp q hq hu hv hr hi hperiod r he

example {m : ℕ} (hm : 1≤m)
    (hL : LowerCountPositiveIntegerHypothesis (m+2))
    (s : Fin (m+2) → ℕ) (hmono : StrictMono s) (hz : s 0=0)
    (hg : Finset.univ.gcd s=1)
    (hH : ((m+2)*(m+1))^m < s (Fin.last (m+1))) :
    ∀ r : Fin (m+2), ∃ t : ℝ, 0<t ∧ LonelyAt (fun i => (s i:ℝ)) r t :=
  primitive_sorted_largeHeight_lonelyAt hm hL s hmono hz hg hH

-- Every total count N>=3 has exactly the public m+2 convention and cutoff.
example (N : ℕ) (hN : 3≤N) :
    ∃ m : ℕ, 1≤m ∧ N=m+2 ∧ (N*(N-1))^(N-2)=((m+2)*(m+1))^m := by
  obtain ⟨m,hm,rfl⟩ : ∃ m : ℕ, 1≤m ∧ N=m+2 := ⟨N-2,by omega,by omega⟩
  exact ⟨m,hm,rfl,by simp⟩

-- Genuine lower-count premises from the preexisting one/two-moving theorems.
theorem reviewFH_H3 : LowerCountPositiveIntegerHypothesis 3 := by
  intro d hd hb s _hi hp
  have hd1 : d=1 := by omega
  subst d
  obtain ⟨t,ht⟩ := oneMovingRunner (s 0:ℝ) (by exact_mod_cast (hp 0).ne')
  refine ⟨t,?_⟩
  intro i
  have hi : i=0 := Subsingleton.elim _ _
  subst i
  simpa [circleNorm] using ht

theorem reviewFH_H4 : LowerCountPositiveIntegerHypothesis 4 := by
  intro d hd hb s hi hp
  have hd12 : d=1 ∨ d=2 := by omega
  rcases hd12 with rfl | rfl
  · exact reviewFH_H3 1 (by omega) (by omega) s hi hp
  · obtain ⟨t,ht⟩ := twoMovingRunners (fun i => (s i:ℝ))
      (by intro i; exact_mod_cast (hp i).ne')
    exact ⟨t,by simpa using ht⟩

-- Two nonvacuous public-theorem fixtures, covering all 3 and all 4 labels.
theorem reviewFH_three_all_chosen : ∀ r : Fin 3, ∃ t : ℝ, 0<t ∧
    LonelyAt (fun i => ((![0,2,11] : Fin 3 → ℕ) i:ℝ)) r t := by
  exact primitive_sorted_largeHeight_lonelyAt (m:=1) (by decide) reviewFH_H3
    (![0,2,11] : Fin 3 → ℕ) (by decide) (by decide) (by decide) (by decide)

theorem reviewFH_four_all_chosen : ∀ r : Fin 4, ∃ t : ℝ, 0<t ∧
    LonelyAt (fun i => ((![0,2,87,174] : Fin 4 → ℕ) i:ℝ)) r t := by
  exact primitive_sorted_largeHeight_lonelyAt (m:=2) (by decide) reviewFH_H4
    (![0,2,87,174] : Fin 4 → ℕ) (by decide) (by decide) (by decide) (by decide)

-- Primitivity is joint: neither internal speed is coprime to the height.
example : Finset.univ.gcd (![0,2,87,174] : Fin 4 → ℕ)=1 ∧
    ¬ Nat.Coprime 2 174 ∧ ¬ Nat.Coprime 87 174 := by decide

example : RationalPairRankTwo (![0,0,1,2] : Fin 4 → ℤ)
    (![0,2,0,0] : Fin 4 → ℚ) := by
  apply rankTwo_of_primitive_approximation
    (![0,2,87,174] : Fin 4 → ℕ) 174 2 (by decide) (by decide) (by decide)
    (![0,0,1,2] : Fin 4 → ℤ) (![0,2,0,0] : Fin 4 → ℚ)
    (by change (2:ℤ)=2; rfl) (by change (0:ℚ)=0; rfl)
  intro i
  fin_cases i <;> norm_num

-- The endpoint packet genuinely includes zero internal coordinates.
example : ∃ u : Fin 2 → ℤ, u 0=0 ∧ u 1=1 ∧
    ∀ i, |((![0,7] : Fin 2 → ℕ) i:ℚ)/7-(u i:ℚ)| < (1/3:ℚ) := by
  obtain ⟨q,hq,hb,u,hu,hl,he⟩ := exists_endpoint_affine_approximation
    (m:=0) (![0,7] : Fin 2 → ℕ) 7 3 (by decide) (by decide)
    (by decide) (by decide)
  have hq1 : q=1 := by norm_num at hb; omega
  subst q
  refine ⟨u,hu,by simpa using hl,?_⟩
  intro i
  simpa using he i

-- Exactly one internal coordinate, including negative approximation error.
example : ∃ q : ℕ, 1≤q ∧ q≤6 ∧ ∃ u : Fin 3 → ℤ,
    u 0=0 ∧ u 2=(q:ℤ) ∧
    ∀ i, |(q:ℚ)*((![0,4,13] : Fin 3 → ℕ) i:ℚ)/13-(u i:ℚ)| < (1/6:ℚ) := by
  simpa using exists_endpoint_affine_approximation
    (m:=1) (![0,4,13] : Fin 3 → ℕ) 13 6 (by decide) (by decide)
    (by decide) (by decide)

example : ∀ i : Fin 3,
    |(3:ℚ)*((![0,4,13] : Fin 3 → ℕ) i:ℚ)/13-
      ((![0,1,3] : Fin 3 → ℤ) i:ℚ)| < (1/6:ℚ) := by
  intro i
  fin_cases i <;> norm_num

-- Boundary and nonprimitive controls reject the omitted public premises.
example : StrictMono (![0,5,6] : Fin 3 → ℕ) ∧
    Finset.univ.gcd (![0,5,6] : Fin 3 → ℕ)=1 ∧ ¬ ((3*2)^1 < (6:ℕ)) := by decide

example : StrictMono (![0,35,70] : Fin 3 → ℕ) ∧ (3*2)^1 < (70:ℕ) ∧
    Finset.univ.gcd (![0,35,70] : Fin 3 → ℕ)=35 ∧
    ¬ Finset.univ.gcd (![0,35,70] : Fin 3 → ℕ)=1 := by decide

example : ¬ RationalPairRankTwo (![0,1,2] : Fin 3 → ℤ)
    (![0,0,0] : Fin 3 → ℚ) := by
  rintro ⟨i,j,h⟩
  fin_cases i <;> fin_cases j <;> norm_num at h

example : ¬ (1≤(0:ℕ)) := by decide
''')

for q in [7,14]:
    parts.append(f'''
-- Arbitrary signed slopes and all chosen labels; common period {q}.
theorem reviewFH_signed_all_chosen_{q} : ∀ r : Fin 3, ∃ t : ℝ, 0<t ∧
    LonelyAt (fun i => (((5/2:ℚ)*((![0,-2,1] : Fin 3 → ℤ) i:ℚ)+
      (![0,1/7,-1/7] : Fin 3 → ℚ) i:ℚ):ℝ)) r t := by
  intro r
  apply rational_affine_lonelyAt (m:=1) (by decide) reviewFH_H3
    (![0,-2,1] : Fin 3 → ℤ) (![0,1/7,-1/7] : Fin 3 → ℚ)
    (5/2) (by norm_num) {q} (by decide) (by norm_num) (by norm_num)
  · exact ⟨1,2,by change (-2:ℚ)*(-1/7) ≠ (1:ℚ)*(1/7); norm_num⟩
  · intro i j h
    fin_cases i <;> fin_cases j <;> norm_num at *
  · intro i
    fin_cases i
    · exact ⟨0,by norm_num⟩
    · exact ⟨{q//7},by norm_num⟩
    · exact ⟨-{q//7},by norm_num⟩
  · intro i
    fin_cases i <;> fin_cases r <;> norm_num
''')

helpers = ['reviewFH_H3','reviewFH_H4','reviewFH_three_all_chosen',
           'reviewFH_four_all_chosen','reviewFH_signed_all_chosen_7','reviewFH_signed_all_chosen_14']
for name in helpers:
    parts.append('#print axioms '+name+'\n')
probe = Path('/tmp/astra-finite-height-formal-review.lean')
probe.write_text(''.join(parts))
assert sha256(probe.read_bytes()).hexdigest() == 'a23af085457a150bb571573e58b37fccc40ab6a35e5194fd953e83bc14390480'
assert len(re.findall(r'^example\b',probe.read_text(),re.M)) == 16
assert len(re.findall(r'^theorem reviewFH_',probe.read_text(),re.M)) == 6
print(json.dumps(dict(source_modules=len(spec),source_bytes=source_bytes,
    preexisting_project_import_closure=len(closure),public_declarations=len(public),
    examples=len(re.findall(r'^example\b',probe.read_text(),re.M)),
    review_theorems=len(helpers),probe_bytes=len(probe.read_bytes()),
    probe_sha256=sha256(probe.read_bytes()).hexdigest()),sort_keys=True))
```

Generate and compile from the repository root:

```bash
python3 -B - <<'FINITE_HEIGHT_REVIEW_GENERATE'
from pathlib import Path
import re
p=Path('research/astra-finite-height-formal-review.md')
blocks=re.findall(r'^```python\n(.*?)^```[ \t]*$',p.read_text(),re.M|re.S)
assert len(blocks)==2
exec(compile(blocks[0],str(p),'exec'),{})
FINITE_HEIGHT_REVIEW_GENERATE
PATH="$HOME/.elan/bin:$PATH" lake env lean /tmp/astra-finite-height-formal-review.lean > /tmp/astra-finite-height-formal-review.log 2>&1
```

After Lean returns exit zero, the second Python block checks the exact
axiom-report set and rejects errors or any unpermitted axiom:

```python
from pathlib import Path
from hashlib import sha256
import re
p=Path('/tmp/astra-finite-height-formal-review.lean')
assert sha256(p.read_bytes()).hexdigest()=='a23af085457a150bb571573e58b37fccc40ab6a35e5194fd953e83bc14390480'
s=Path('/tmp/astra-finite-height-formal-review.log').read_text()
assert 'error:' not in s and 'sorryAx' not in s
expected=set(re.findall(r'^#print axioms ([A-Za-z0-9_.]+)$',p.read_text(),re.M))
reports={n:set(a.strip() for a in axioms.split(',') if a.strip())
         for n,axioms in re.findall(r"'([^']+)' depends on axioms: \[([^\]]*)\]",s)}
for n in re.findall(r"'([^']+)' does not depend on any axioms",s):
    reports[n]=set()
assert set(reports)==expected and len(reports)==25
assert all(ax <= {'propext','Classical.choice','Quot.sound'} for ax in reports.values())
print('25 exact axiom reports passed; no unpermitted axiom or error')
```

Run that log check without copying its contents:

```bash
python3 -B - <<'FINITE_HEIGHT_REVIEW_AXIOMS'
from pathlib import Path
import re
p=Path('research/astra-finite-height-formal-review.md')
blocks=re.findall(r'^```python\n(.*?)^```[ \t]*$',p.read_text(),re.M|re.S)
assert len(blocks)==2
exec(compile(blocks[1],str(p),'exec'),{})
FINITE_HEIGHT_REVIEW_AXIOMS
```

All owned commands completed and no owned process remains running at handoff.
No Lean source, root import list, axiom-audit source, shared state, Git data,
dependency, or cache was edited. No full build was run by this worker.
The accepted result is the exact conditional primitive large-height theorem;
the inclusive finite families and unrestricted canonical conjecture remain
unproved.
