# Assembly of the ordinary five-total-runner theorem

2026-09-06. Requested route: Astra/xhigh, task
`/root/five_runner_assembly_plan`, executing in the existing reviewer agent.
Assigned source checkpoint: `ef64109257b09da2db481b43652ba0df891d3c1e`
(Pass38). Current project configuration, workflow, policy and focused state
were read; `python3 -B scripts/validate_workflow.py` exited 0. The validator
checks records, not mathematics. Only this new manuscript is owned.

**Recommendation: proceed with the assembly from the contracts below.**
The mathematical bridge is complete at manuscript level. It requires the
unconditional hard-pattern adapter still being implemented, followed by new
Lean assembly and independent final-source review. This manuscript does not
declare an already-proved canonical five-runner theorem. It does not use a
height cutoff, tuple enumeration, mixed margin, or unrestricted conjecture.

The immutable Filtering and Carry sources were accepted in Pass38. During
this task root separately froze `FiveAdicDecomposition.lean`; its entire
proof source was read and its elementary decomposition, scaling and
label-count argument checked. Its source is guarded below, but this task does
not replace its eventual independent integration review. The active
`FiveAdicHardPattern.lean`, its in-progress implementation report, root imports,
audit source and state are deliberately not source guards. No mutable adapter
bytes were read. No Lean process, build, dependency change or cache mutation
was performed here.

## Required and existing interfaces

All declarations are in namespace `LonelyRunner`. The names in this first
list are existing, source-read interfaces:

* `fiveAdic_positive_decomposition v hv` returns
  `v = 5 ^ fiveAdicExponent v * fiveAdicUnit v`, positivity of the unit,
  and `¬ 5 ∣ fiveAdicUnit v`. The definitions are `padicValNat 5 v` and
  division by that power. Positivity of v excludes the valuation-at-zero
  case. The proof uses exact divisibility and exclusion of the next power.
* `fin4_level_dichotomy ell m hbound hmax` returns either every layer
  `j < m` has at most two **labels**, or
  `∃ j, j < m ∧ ∃ p : Fin 4, ell p = m ∧ ∀ i, i ≠ p → ell i = j`.
  Attainment supplies a label outside the crowded layer; that layer has
  exactly three members and is the entire complement of p. Ties and repeated
  speed values cause no difficulty. The bound premise is harmless even
  though the proof of this particular dichotomy does not use it.
* `fiveAdic_cyclicResidueDistance_mul_left g P x` states, without hypotheses,
  `cyclicResidueDistance (g * P) (g * x) =
   g * cyclicResidueDistance P x`. Natural remainder scaling and distributivity
  of bounded subtraction prove it even at g=0 or P=0. Our caller has both
  positive.
* `exists_five_adic_filtered_multiplier d ell u m hd hdecomp hu hell hcard`
  applies to any finite decidable label type. Its result is
  `∃ lam, 0 < lam ∧ lam < 5*5^m ∧ lam%5=1 ∧ ¬5∣lam ∧
   lowerGoodDigits ∧ unchangedTopResidues ∧
   ∀ i, 5^m ≤ cyclicResidueDistance (5*5^m) (lam*d i)`.
  Use the exact conjunction order when destructuring. This branch already
  includes m=0 and arbitrarily many labels on the top layer.

The sole pending mathematical adapter needed by this plan is the following
**required contract**, with no extra ordering, injectivity, primitivity, or
lower-count assumption. Root confirmed the planned unconditional name below;
its actual source still awaits freezing:

```lean
theorem fiveAdic_hard_pattern
    (m : Nat) (hm : 1 ≤ m) (d : Fin 3 → Nat)
    (hd : ∀ i, ¬ 5 ∣ d i) (v : Nat) (hv : ¬ 5 ∣ v) :
    ∃ lam : Nat, 0 < lam ∧ lam < 5 * 5^m ∧ ¬ 5 ∣ lam ∧
      (∀ i, 5^m ≤ cyclicResidueDistance (5 * 5^m) (lam * d i)) ∧
      5^m ≤ cyclicResidueDistance (5 * 5^m) (lam * (5^m * v))
```

This is exactly the reviewed `fiveAdic_hard_pattern_of_carry` conclusion,
specialized with the already kernel-proved `fiveCarryTriple`. The adapter
must preserve the common multiplier through all three complement choices,
use the actual current coefficient J in its digit identity, allow top digit
4 at its closed boundary, and return the positive unit representative modulo
`5*5^m`. Those are adapter obligations, not new assumptions for this caller.
Its raw expression `J*(1+k*5^m)` must not be treated as already bounded.

## One assembly theorem with certified decomposition

The following new declaration is a convenient internal or public seam. Its
precise certified inputs match the two existing branches:

```lean
theorem fiveAdic_four_label_multiplier
    (d ell u : Fin 4 → Nat) (m : Nat)
    (hd : ∀ i, 0 < d i)
    (hdecomp : ∀ i, d i = 5 ^ (ell i) * u i)
    (hu : ∀ i, ¬ 5 ∣ u i)
    (hell : ∀ i, ell i ≤ m)
    (hmax : ∃ p, ell p = m) :
    ∃ lam : Nat, 0 < lam ∧ lam < 5 * 5^m ∧ ¬ 5 ∣ lam ∧
      ∀ i, 5^m ≤ cyclicResidueDistance (5 * 5^m) (lam * d i)
```

Apply `fin4_level_dichotomy ell m hell hmax`. In the first branch, call the
filtered multiplier theorem and project its positive, bounded, unit and
distance fields. Its additional residue-1 and unchanged-top conclusions
are unnecessary for the shared result; do not add them to the hard branch.

In the second branch obtain j, `hjm : j < m`, p, `hp : ell p = m`, and
`hlow : ∀ i, i ≠ p → ell i = j`. Set

```text
g = 5^j,       m' = m-j ≥ 1,
R' = 5^m',     P' = 5*R',
R = 5^m = g*R',             P = 5*R = g*P'.
```

Obtain `j+(m-j)=m` by `omega` from hjm, then use `pow_add` and
associative/commutative multiplication for these equalities.
Natural subtraction is used only with its certified j≤m bound. In particular
g≥1, so P'≤P. There is no division of the original speeds in this branch:
their supplied unit parts already give the exact factors below.

The pinned complement APIs have these exact directions:

```lean
Fin.succAbove_ne (p : Fin (n + 1)) (i : Fin n) : p.succAbove i ≠ p
Fin.exists_succAbove_eq {x y : Fin (n + 1)} (h : x ≠ y) :
  ∃ z, y.succAbove z = x
```

They are source-read in `Mathlib/Data/Fin/SuccPred.lean`, and the existing
stationary/canonical bridge already uses both in this orientation. Define
`lower : Fin 3 → Nat := fun q => u (p.succAbove q)` and `top := u p`.
Then `hu` directly supplies their unit assumptions, and

```text
d (p.succAbove q) = g * lower q,
d p               = g * (R' * top).
```

The first follows from `hdecomp` and `hlow _ (Fin.succAbove_ne p q)`;
the second from `hdecomp p`, hp and the power equality. Apply the hard theorem
at m' to this lower triple and top unit. It supplies one lam with
`0 < lam < P'`, `¬5∣lam`, and all four normalized distance bounds.

For every normalized speed x, commute the product and apply the scaling lemma:

```text
dist_P(lam * (g*x))
  = dist_(g*P')(g*(lam*x))
  = g * dist_P'(lam*x)
  ≥ g*R' = R.
```

For an arbitrary original label i, split on `i = p`. Use the top bound in
that case. Otherwise `Fin.exists_succAbove_eq hi` produces q with
`p.succAbove q = i`; use the corresponding lower bound. This covers every
label, including arbitrary positions of the top label and equal lower values.
The same lam remains positive and a unit, and `lam < P' ≤ P` supplies the
original upper bound. It need not be reduced again. The final common time
is lam/P. Using lam/P' on the original speeds would omit the factor g and
can destroy a witness; the fixed control below detects exactly that mistake.

This branch requires m'≥1, provided by j<m. If m=0 there is no hard branch:
all levels are top levels and the existing filtered theorem supplies the
closed bounds directly. No global minimum normalization, gcd argument,
sorting, sign choice or reindexing by speed value enters this assembly.

## Positive naturals, H6, and the canonical statement

The following are proposed declaration types, not claims of current Lean
availability:

```lean
theorem fourMovingNaturalMultiplier (speeds : Fin 4 → Nat)
    (hpos : ∀ i, 0 < speeds i) :
    ∃ m lam : Nat, 0 < lam ∧ lam < 5 * 5^m ∧ ¬ 5 ∣ lam ∧
      ∀ i, 5^m ≤ cyclicResidueDistance (5 * 5^m) (lam * speeds i)

theorem fourMovingNaturalRunners (speeds : Fin 4 → Nat)
    (hpos : ∀ i, 0 < speeds i) :
    ∃ t : ℝ, 0 < t ∧
      ∀ i, (5 : ℝ)⁻¹ ≤ circleNorm (t * (speeds i : ℝ))

theorem lowerCountPositiveIntegerHypothesis_six :
    LowerCountPositiveIntegerHypothesis 6

theorem fiveRunners (speeds : Fin 5 → ℝ)
    (hinj : Function.Injective speeds) (runner : Fin 5) :
    ∃ t : ℝ, LonelyAt speeds runner t
```

For the first, apply positive decomposition coordinatewise and choose an
attained maximum of the four exponents. No new maximum definition or
valuation arithmetic is needed: the pinned source-read API is

```lean
Finset.exists_max_image (s : Finset β) (f : β → α) (h : s.Nonempty) :
  ∃ x ∈ s, ∀ x' ∈ s, f x' ≤ f x
```

Instantiate s with `Finset.univ : Finset (Fin 4)`, f with the exponent map,
and use label 0 to prove nonemptiness. If p realizes the maximum, choose
`m := ell p`, obtain `hell` from the displayed result and
`hmax := ⟨p, rfl⟩`. Call `fiveAdic_four_label_multiplier`. The proof therefore
chooses the actual maximum exponent; the minimal public multiplier contract
above intentionally only exposes an existential m. Its fixed-m internal
contract retains all maximum information for callers that need it.

For the positive real time put R=5^m, P=5R and t=(lam:ℝ)/(P:ℝ). Both
numerator and denominator are positive, so t>0 (and t<1 is derivable but
unneeded in the public contract). Existing `circleNorm_nat_div_ge` gives
`R/P ≤ circleNorm (((lam*speeds i : Nat) : ℝ)/P)` from the natural distance
bound. Casting products rewrites the phase as `t*(speeds i:ℝ)`, and
R/P=(5:ℝ)⁻¹ since R>0. This transfers the **closed** inequality unchanged.
No injectivity is required even though the later lower-count interface asks
for it. No fastest-quarter or strict-fifth claim follows.

The definition of H_N is exactly supply for 1≤d≤N−2 moving natural speeds,
at each tuple's own closed margin 1/(d+1). Existing
`lowerCountPositiveIntegerHypothesis_five` covers d=1,2,3. In H6, split
on d≤3; use H5 directly there. Otherwise 1≤d≤4 forces d=4, so use
`fourMovingNaturalRunners`, dropping its positive-time conjunct and ignoring
the supplied injectivity hypothesis. No d=5 natural result is required or
obtained. A proposed H6 body is:

```lean
  intro d hd hdmax speeds hinj hpos
  by_cases hsmall : d ≤ 3
  · exact lowerCountPositiveIntegerHypothesis_five
      d hd (by omega) speeds hinj hpos
  · have hd4 : d = 4 := by omega
    subst d
    obtain ⟨t, _htpos, ht⟩ := fourMovingNaturalRunners speeds hpos
    exact ⟨t, by simpa using ht⟩
```

The canonical wrapper then has the exact same form as `fourRunners`:

```lean
-- Proposed body after the new H6 theorem has been checked.
  lonelyAt_of_lowerCount (m := 4) (by omega)
    lowerCountPositiveIntegerHypothesis_six speeds hinj runner
```

The stable generic theorem takes H_(m+2) for `Fin (m+1)` labelled real speeds.
At m=4 these are H6 and Fin5, with threshold 1/5. Its rational branch uses
at most four distinct positive magnitudes and H6, permitting repeats. Its
irrational-ratio branch obtains strictly fewer than four magnitudes, restricts
H6 to H5, and transfers the strict slack `1/5 < 1/4` through the existing
orbit-closure theorem. Coordinatewise absolute values then allow every
nonzero signed stationary tuple, and chosen-runner `succAbove` enumerates
the four nonzero relative speeds of an injective Fin5 family. The existing
`lonelyAt_iff_relativeLonelyAt` gives the canonical circular-distance predicate.
Thus there is no all-dimensional rational premise, ordering requirement,
stationary-label restriction, sign restriction, or change of runner count.

Prefer a new `FiveRunnerOrdinary.lean` importing Filtering, Decomposition,
the finalized HardPattern, and FourRunnerOrdinary (plus `Data.Finset.Max`
explicitly if needed). Put the multiplier/natural/H6 assembly there. A new
`FiveRunnerCanonical.lean` can import that module and BoundedRealReduction
for the one-line specialization. None of the prerequisites should import
either new caller. Preserve all existing public declarations; root imports
and axiom-audit additions are separate integration work. The import plan is
acyclic and parallels the existing four-total modules.

## Bounded exact controls and reproduction

The sole Python block below guards stable inputs, checks five named natural
fixtures with supplied multipliers, four complement-label maps, one signed
chosen-runner fixture, and two degenerate distance-scaling controls. It does
not discover multipliers, enumerate speed tuples, rerun carry tables, or
execute Lean. Mathematical universal claims rest on the derivations above
and the required source contracts, not on these finite controls.

The two pinned Mathlib source guards require the existing shared dependency
sources to be present. This script only reads them; it does not restore a
cache. The frozen decomposition guard was added after root's freeze notice.
Other currently edited sources and mutable workflow/publication records are
not guarded.

```python
from fractions import Fraction as F
from hashlib import sha256
from pathlib import Path
import json

guards = {
    'LonelyRunner/FiveAdicFiltering.lean': '1a210e70383e9b00d1a3aec321e9e1a838efcd26c24ca180101964e8c6e71429',
    'LonelyRunner/FiveAdicCarry.lean': 'f91d747198374da76ff9e62435db20a8917856d5b9dc52229ce576353cc11d81',
    'LonelyRunner/FiveAdicDecomposition.lean': '049da0b10b478fe2cdb0a6239ebc97a60317022f15263c317d5aa56415a7357e',
    'LonelyRunner/PivotResidues.lean': '362da5ab923f22e900ae7ac821dd4cf4aab91dfe70889987bc9e5a05d19c276a',
    'LonelyRunner/LowerCountSupply.lean': '0705291adc53011fb72fc718a7260876512b092741442d6a6cceb4b76eb5ccf4',
    'LonelyRunner/FourRunnerOrdinary.lean': '2fb2f5c9c0742daa3278ee0ddeacd8643e1e22f8c885de95f5f38e10734b29f6',
    'LonelyRunner/FourRunnerCanonical.lean': '353b116d04d464fb9aedb92437e7f56168992e087a862f934044bc9062761c38',
    'LonelyRunner/BoundedRealReduction.lean': '7eae68d2c46041b39c3e18f9a1e105c75680352f8e4b4edf65e0dd2a92becb72',
    'LonelyRunner/StationaryEquivalence.lean': '12dce8930c34b211bc01e2dc21e932087270726bce2bf127fa2d8d6594544b49',
    'LonelyRunner/Definitions.lean': '5f0258a6ab99950fc7045b2200d6708fe7603d3caa4d62855ef2b19a330c95aa',
    '.lake/packages/mathlib/Mathlib/Data/Fin/SuccPred.lean': 'b4abd81eb56af7f8178d592af2eabca0604ade556b85a09981ff301a44783dce',
    '.lake/packages/mathlib/Mathlib/Data/Finset/Max.lean': '6a67c04a5ad263999707cf927121c15edf11bd66f7b5b48652c0e0e660a0d58c',
    'research/astra-five-adic-filter-plan.md': '34725cc13001013cdeefa89d36620442bbe7d6ccffcc0ff6f85585bdd208f500',
    'research/astra-five-adic-hard-adapter-plan.md': 'f2d5e74769d86dc729d0f63f098654a9a538bf690e0c47d952272259bba37eef',
    'lean-toolchain': '8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af',
    'lake-manifest.json': '887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218',
}
for path, expected in guards.items():
    assert sha256(Path(path).read_bytes()).hexdigest() == expected, path

def dist(P, x):
    r = x % P if P else x  # Lean's Nat.mod x 0 = x
    return min(r, max(0, P-r))

def norm(x):
    r = x % 1
    return min(r, 1-r)

def decompose(v):
    assert v > 0
    e, u = 0, v
    while u % 5 == 0:
        e, u = e+1, u//5
    assert v == 5**e*u and u > 0 and u % 5 != 0
    return e, u

fixtures = [
    ('m0_repeated_unsorted', (4, 1, 4, 2), 1),
    ('all_top_positive_level', (20, 5, 20, 10), 1),
    ('filtered_multiple_levels', (25, 2, 1, 5), 31),
    ('hard_scaled_top_middle', (5, 375, 420, 245), 53),
    ('hard_scaled_repeated_lower', (245, 375, 245, 5), 53),
]
rows = []
for name, speeds, lam in fixtures:
    pairs = list(map(decompose, speeds))
    ell, units = tuple(p[0] for p in pairs), tuple(p[1] for p in pairs)
    m = max(ell)
    R, P = 5**m, 5**(m+1)
    assert 0 < lam < P and lam % 5 != 0
    distances = [dist(P, lam*v) for v in speeds]
    assert all(R <= x for x in distances)
    t = F(lam, P)
    assert 0 < t < 1
    assert all(norm(t*v) == F(x, P) >= F(1, 5)
               for v, x in zip(speeds, distances))
    if name.startswith('hard_'):
        j, top = min(ell), 1
        assert ell[top] == m and j < m
        indices = [q if q < top else q+1 for q in range(3)]
        assert all(ell[i] == j for i in indices)
        g, Rp = 5**j, 5**(m-j)
        Pp = 5*Rp
        assert R == g*Rp and P == g*Pp and lam < Pp <= P
        for i in indices:
            assert speeds[i] == g*units[i]
            assert dist(P, lam*speeds[i]) == g*dist(Pp, lam*units[i])
        assert speeds[top] == g*Rp*units[top]
        assert dist(P, lam*speeds[top]) == g*dist(Pp, lam*Rp*units[top])
        assert norm(F(lam, Pp)*speeds[top]) == 0  # missing g fails
    rows.append({'name': name, 'levels': ell, 'm': m, 'lambda': lam,
                 'time': str(t), 'distances': distances})

for p in range(4):  # four label maps only, not a speed search
    image = [q if q < p else q+1 for q in range(3)]
    assert image == [i for i in range(4) if i != p]
assert 3*(1+4*25) == 303 > 125
assert 303 % 125 == 53 and 0 < 53 < 125
assert dist(0*7, 0*11) == 0*dist(7, 11)
assert dist(3*0, 3*11) == 3*dist(0, 11)
signed, runner, t = (10, 9, 12, 7, 15), 2, F(1, 8)
relative = [v-signed[runner] for i, v in enumerate(signed) if i != runner]
assert relative == [-2, -3, -5, 3] and len(set(signed)) == 5
assert all(norm(t*v) >= F(1, 5) for v in relative)
assert all(norm(t*v) == norm(t*abs(v)) for v in relative)
assert list(range(1, 6-2+1)) == [1, 2, 3, 4]
assert F(1, 5) < F(1, 4) and (4+2, 4+1) == (6, 5)
print(json.dumps({'source_guards': len(guards), 'natural_controls': rows,
                  'complement_maps': 4, 'signed_relative': relative,
                  'signed_time': str(t), 'status': 'passed'}, sort_keys=True))
```

The first and only bounded execution exited 0 (tool chunk `fdd8bb`), with
empty stderr. It passed all 16 source guards and exactly the fixed controls
shown. Its exact byte hashes are:

| Artifact | SHA-256 |
|---|---|
| Sole Python block, including final newline | `4e4c3ef87641be643279612347a2503febb548401ee3b9695e5f12fb0194ca7a` |
| Raw stdout, including final newline | `f899e54580e92adf78c6c3ad8789eb25255f911718106a062df87c8aa71258bf` |
| Empty stderr | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |

The five resulting times are respectively `1/5`, `1/25`, `31/125`,
`53/625`, `53/625`. The scaled hard controls retain the top distance exactly
125 out of modulus 625, showing the accepted fifth boundary. Using the
normalized modulus 125 for those original speeds gives top norm zero.
The separate signed tuple has relative speeds `[-2,-3,-5,3]` at chosen
label 2 and time `1/8`, including repeated absolute magnitude 3.

From the repository root, this exact command extracts, guards and executes
the embedded program without writing any file:

```bash
python3 -B - <<'PY'
from pathlib import Path
from hashlib import sha256
import subprocess, sys
text = Path('research/astra-five-runner-assembly-plan.md').read_text()
blocks = text.split('```python\n')[1:]
assert len(blocks) == 1
code = blocks[0].split('```', 1)[0].encode()
assert sha256(code).hexdigest() == '4e4c3ef87641be643279612347a2503febb548401ee3b9695e5f12fb0194ca7a'
run = subprocess.run([sys.executable, '-B', '-c', code.decode()], capture_output=True)
assert run.returncode == 0, (run.returncode, run.stdout, run.stderr)
assert run.stderr == b''
assert sha256(run.stdout).hexdigest() == 'f899e54580e92adf78c6c3ad8789eb25255f911718106a062df87c8aa71258bf'
sys.stdout.buffer.write(run.stdout)
PY
```

Final disposition: the decomposition/label/scaling and H6/Fin5 contracts
are settled enough for Terra implementation. The remaining requirements
are the finalized hard adapter, assembly source, exact public-type and axiom
probes (including old API compatibility), independent mathematical source
review, and root's full build/trust checks. No additional finite search or
large carry computation is required by this plan. The existing and proposed
results concern exactly four moving / five total runners; unrestricted
`LonelyRunner.Conjecture` remains unresolved. All task processes are stopped
at handoff, and only this manuscript was written.
