# Independent formal review of the five-adic supporting modules

2026-09-06. Assigned reviewer `/root/mss_published_bound_audit`, requested
Astra/xhigh; runtime routing is not independently attested. Main checkpoint
`f55744833dd2876e582f0e4e0726614b6b527a54`. Configuration, workflow, policy
and current state were read and structural validation passed. Only this review
is owned. No source, Git, workflow state or dependency/cache modification is
performed; focused stdin probes use the shared prepared build.

**Final verdict: accept the three exact source modules and their root/audit
integration for this supporting checkpoint.** All 21 new public contracts
match their intended scope, and no source correction or theorem weakening is
required. The 44-example focused probe, source guards and verification receipts
are recorded below. The complete five-total-runner theorem and unrestricted
LRC remain unresolved.

## Filtering source assessment

I read all of FiveAdicFiltering.lean and its implementation report. The
16 public theorems realize the accepted arithmetic and arbitrary finite-label
filtering plan. The selected product/digit identities require j<=m, not j<m;
their arithmetic allows zero k,A,u. Correction positivity is unrestricted,
while residue-one requires j<m. The higher-residue identity preserves the
entire residue modulo 5*5^m, using j<ell<=m and an explicit power factor.
The selected digit shifts by the current coefficient (A*u)%5, with no
replacement by u%5. The decomposition and good-digit distance are exact
natural arithmetic; only the latter restricts the digit to [1,3].

The top residue theorem needs no unit premise. The separate top-distance
theorem requires only that A*u is not divisible by 5, and explicitly retains
digit 4 as a closed boundary. Digit equality follows from residue equality
by dividing by 5^m. The representative theorem proves positivity using
the nonzero residue modulo 5 and preserves every product residue; neither
A>0 nor A<P is an extra premise.

The avoider proves a union bound in ZMod 5. Each label contributes the two
solutions of its forbidden affine equations. There are at most four bad
points, so a fifth exists. Nonzero coefficients justify division in those
equations; no speed or slope injectivity is used. The conclusion accepts
arbitrary natural q,s on any finite label type of cardinal at most two,
including the empty type. The tiny uses of decide here establish scalar
primality and the five-element field's cardinality, not a large state table.

Layer filling applies that avoider to the subtype ell=r and uses A*u as
its slope. Its r<=m scope is deliberate: it only promises good digits,
not a unit correction at the top level. The seeded induction invokes it
strictly below m, where the correction does preserve the seed's unit class.
The induction generalizes A. It fills level r at successor r+1, constructs
the exact high-residue invariant, and recurses at r. Residue equality then
preserves the newly filled level's digit. The h=0 branch simply returns A.
There is no assumed existence of a lower-count lonely time.

The bounded wrapper reduces only after the induction, transports exact
product residues and digits, and preserves B%5=A%5. The unseeded wrapper
sets h=m,A=1 and discharges top-level distances from their automatic unit
bound. Thus it returns lambda%5=1 and unchanged top residues. Its assumptions
are exactly the fixed decomposition and at most two labels at each lower
level. No nonempty type, attained maximum, ordering, distinct values,
primitivity, Fin 4 restriction or global conjecture premise is introduced.
The retained positivity argument hd is unused in the inductive proof but
does not weaken the accepted contract. Empty and repeated top-level families
and m=0 are covered.

## Natural normalization source assessment

I read all of FiveAdicHardPattern.lean and its implementation report. Despite
the filename, this source currently proves only four generic symmetry and
normalization declarations. It imports PivotResidues and Mathlib.Tactic,
with no Carry or Filtering dependency and no hard-pattern assembly theorem.

Equal residues give equal distance even without P>0. The sum-zero lemma
assumes P>0 and splits the two bounded residues' sum into zero or P.
Both zero residues and the half-modulus case are included. The complement
lemma uses s<=P to justify natural subtraction and works for every A,
including zero and nonunits. The normalizer chooses d%P or its complement,
proves a positive representative below P with residue 1 or 2 modulo 5,
and returns distance preservation for all A after that one choice of x.
This quantifier order preserves a shared future multiplier across coordinates.
The constructor has no m>=1, injectivity, order or gcd-one assumption.

## Carry source and integration

After root supplied its frozen hash, I read the complete Carry source. It
retains the original public state fields, coupled carry table, natural digit
formula and unconditional forall-triples theorem exactly. The former failed
full-state decide is replaced by T (1,600 inputs) and P (80 inputs), each
under local recursion/heartbeat settings. The remaining finite checks concern
only scalar field residues, nonzero factors, escape choices and the eight
residue patterns. There is no full-state decision hidden in the assembly.

The natural-to-field digit and base bridges cast the actual modulo-five
formula. BaseGood first constructs its bounded representative before using
the five-value Good equivalence. The block bridge includes the wrapped
endpoint via the cast of (b+1)%5. Only its forward direction is required.
Representatives cover every ZMod 5 element and preserve field values.

The equal-residue case takes top differences, calls T, and solves the one
equation D*K=h-J*A(a), where D=J*r is nonzero. Rewriting produces exactly
T's three translated expressions. The pair case calls P, forms U, and
solves the two equations for translations onto {1,2} and {2,3}. Both choices
work for the paired labels. The third digit's displacement is 2 or 3 according
to the residue ratio, so the ten-case escape lemma selects a common choice.
The two permuted-pair branches reorder their output conjunctions correctly.
The final Fin 3 wrapper introduces no extra restriction on the state function.

The hard-pattern normalization file remains independent of Carry and
Filtering; no simultaneous tag, natural state-digit constructor or conditional
hard-pattern assembly has yet been implemented. In particular these modules
do not yet imply ordinary supply for every positive Fin 4 family, a canonical
Fin 5 theorem, mixed supply or unrestricted LRC.

Root and audit integration is additive: three new imports and 21 new public
axiom prints. Removing exactly those additions reconstructs the prior bytes.
All new modules import downward from existing modules, so there is no import
cycle. The final root import probe also proves compatibility with the unchanged
unconditional canonical fourRunners theorem.

## Guarded focused verification

The runner binds the final source/import/report bytes and reconstructs the
prior root/audit bytes by removing just the three imports and 21-print
addition. It also compares the final public Carry definitions and wrapper to
the exact failed-source text preserved in the implementation report, without
executing that historical source. The Lean block states all 21 new public
types explicitly and prints their types and axioms, plus old fourRunners
compatibility. Fixed controls exercise scope and arithmetic boundaries.

```python
from hashlib import sha256
from pathlib import Path
import json, os, re, subprocess

guards = {
    'LonelyRunner/FiveAdicFiltering.lean':'1a210e70383e9b00d1a3aec321e9e1a838efcd26c24ca180101964e8c6e71429',
    'LonelyRunner/FiveAdicHardPattern.lean':'1ca9b35f3e642639dfebc87a96b45894bbea3536f9a28f018c71a61292fa7904',
    'LonelyRunner/FiveAdicCarry.lean':'f91d747198374da76ff9e62435db20a8917856d5b9dc52229ce576353cc11d81',
    'LonelyRunner.lean':'f9cf041a31ae8b9434c248c48c2ea59569549b307cb971d841244ca9f846a99b',
    'LonelyRunner/AxiomAudit.lean':'5501c85618261d7b60668a47e7c4f3ef17bed9686341d4c1e460b978fd7fae72',
    'research/astra-five-adic-filter-arithmetic-implementation.md':'e81861a1a5757653a939921996ae092205af7d749bd60e274b81c14448ef084e',
    'research/astra-five-adic-hard-pattern-implementation.md':'f6ac85dabb50e0c115533e4c1710c551a453990194c11fcc9904a2ecef3e0535',
    'research/astra-five-adic-carry-implementation.md':'749c2c43d8d87fa0f8b09302bc211b8ad25b78ee7c3d799a0c25ad187d879059',
    'research/astra-five-adic-filter-plan.md':'34725cc13001013cdeefa89d36620442bbe7d6ccffcc0ff6f85585bdd208f500',
    'research/astra-five-adic-filter-plan-review.md':'750f12219cc784560ec8c8822274f455a3a12c316c95072d645b9f94fe3f328e',
    'research/astra-five-adic-carry-plan.md':'da1a4f4828f6e9d9cae6ed601151e0b56b518bea8e9add524e06b289b1713e69',
    'research/astra-five-adic-carry-symbolic-plan.md':'d1fef1fafc6c7ae6adaf0ee885b4d44931e26bda667ff040f6c237f082555f80',
    'research/astra-five-adic-carry-symbolic-plan-review.md':'7e26dfa590c14bc8ea1f680b51f5f508387983c23a703682440b4ad08aabd201',
    'research/astra-five-adic-hard-adapter-plan.md':'f2d5e74769d86dc729d0f63f098654a9a538bf690e0c47d952272259bba37eef',
    'research/astra-five-adic-hard-adapter-plan-review.md':'579b1ea58b05788dc388cba4bcabb26aa152bf23fdebc919c497815973e2303f',
    'LonelyRunner/PivotResidues.lean':'362da5ab923f22e900ae7ac821dd4cf4aab91dfe70889987bc9e5a05d19c276a',
    'LonelyRunner/FourRunnerCanonical.lean':'353b116d04d464fb9aedb92437e7f56168992e087a862f934044bc9062761c38',
    'lean-toolchain':'8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af',
    'lake-manifest.json':'887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218',
}
for path,digest in guards.items():
    assert sha256(Path(path).read_bytes()).hexdigest() == digest,path
root = Path('LonelyRunner.lean').read_text()
audit = Path('LonelyRunner/AxiomAudit.lean').read_text()
imports = r'^import LonelyRunner\.FiveAdic(Carry|Filtering|HardPattern)\n'
assert len(re.findall(imports,root,re.M)) == 3
assert sha256(re.sub(imports,'',root,flags=re.M).encode()).hexdigest() == 'a04502b8ac17cecdaa2aada77d66bac3e484e693f01c31c0b9d6f671cd586f96'
marker = '-- Five-adic filtering, finite coupled carries, and natural normalization.'
assert audit.count(marker) == 1
old_audit = re.sub(imports,'',audit.split(marker)[0].rstrip()+'\n',flags=re.M)
assert sha256(old_audit.encode()).hexdigest() == '170d1b3937d0c58b0a4b0601a33b570bb9e504b6102d943c5ee29d49718bd5c1'
public = []
for module,count in (('FiveAdicFiltering',16),('FiveAdicHardPattern',4),('FiveAdicCarry',1)):
    source = Path('LonelyRunner/'+module+'.lean').read_text()
    names = re.findall(r'^theorem (\w+)',source,re.M)
    assert len(names) == count
    public += ['LonelyRunner.'+n for n in names]
assert re.findall(r'^#print axioms (\S+)',audit.split(marker)[1],re.M) == [
    'LonelyRunner.fiveCarryTriple'] + public[:-1]
f = chr(96)*3
report = Path('research/astra-five-adic-carry-implementation.md').read_text()
old_sources = [s for s in re.findall(rf'^{f}lean\n(.*?)^{f}[ \t]*$',report,re.M|re.S)
    if sha256(s.encode()).hexdigest() == 'edcc4c6a1c8a31ce6188b92d9d0a21d09f01013027290d6ed6cfeb3d1876fdb3']
assert len(old_sources) == 1
old_carry = old_sources[0]
carry = Path('LonelyRunner/FiveAdicCarry.lean').read_text()
assert carry.split('/-! The two finite searches')[0] == old_carry.split('set_option maxRecDepth')[0]
public_marker = '/-- Every ordered triple of coupled carry states'
assert carry.split(public_marker)[1] == old_carry.split(public_marker)[1]

review = Path('research/astra-five-adic-formal-review.md').read_text()
blocks = re.findall(rf'^{f}lean\n(.*?)^{f}[ \t]*$',review,re.M|re.S)
assert len(blocks) == 1
lean = blocks[0]
env = dict(os.environ)
env['PATH'] = '/home/joshua/.elan/bin:' + env.get('PATH','')
proc = subprocess.run(['lake','env','lean','--stdin'],input=lean,text=True,
    stdout=subprocess.PIPE,stderr=subprocess.STDOUT,env=env)
print(proc.stdout,end='')
assert proc.returncode == 0,proc.returncode
reports = re.findall(r"'([^']+)' depends on axioms: \[([^\]]*)\]",proc.stdout)
free = re.findall(r"'([^']+)' does not depend on any axioms",proc.stdout)
assert len(reports) == 21 and free == ['LonelyRunner.cyclicResidueDistance_eq_of_mod_eq']
assert {name for name,_ in reports}|set(free) == set(public+['LonelyRunner.fourRunners'])
for name,axioms in reports:
    assert {a.strip() for a in axioms.split(',')} <= {'propext','Classical.choice','Quot.sound'},(name,axioms)
for path,digest in guards.items():
    assert sha256(Path(path).read_bytes()).hexdigest() == digest,path
print(json.dumps({'result':'PASS','source_guards':len(guards),'new_public_types':len(public),
    'kernel_examples':len(re.findall(r'^example\b',lean,re.M)),
    'dependency_reports':len(reports),'axiom_free_reports':len(free),'lean_exit_code':proc.returncode,
    'lean_stdin_sha256':sha256(lean.encode()).hexdigest(),
    'lean_stdout_sha256':sha256(proc.stdout.encode()).hexdigest(),
    'old_root_audit_and_carry_public_bytes_preserved':True,
    'full_state_replay':False,'resource_benchmark':False},sort_keys=True))
```

```lean
import LonelyRunner

open LonelyRunner

-- All sixteen exact Filtering contracts.
example : ∀ m j k : ℕ, 0 < fiveAdicCorrection m j k := @fiveAdicCorrection_pos
example : ∀ m j k : ℕ, j < m → fiveAdicCorrection m j k % 5 = 1 :=
  @fiveAdicCorrection_mod_five
example : ∀ m x : ℕ, x % (5 * 5 ^ m) =
    5 ^ m * fiveAdicDigit m x + x % 5 ^ m := @fiveAdic_residue_decomposition
example : ∀ m x : ℕ, FiveAdicGoodDigit m x →
    5 ^ m ≤ cyclicResidueDistance (5 * 5 ^ m) x := @fiveAdicGoodDigit_distance
example : ∀ m j k A u : ℕ, j ≤ m →
    fiveAdicCorrection m j k * (A * (5 ^ j * u)) =
      A * (5 ^ j * u) + k * 5 ^ m * (A * u) := @fiveAdicCorrection_selected_product
example : ∀ m j k A u : ℕ, j ≤ m →
    fiveAdicDigit m (fiveAdicCorrection m j k * (A * (5 ^ j * u))) =
      (fiveAdicDigit m (A * (5 ^ j * u)) + k * ((A * u) % 5)) % 5 :=
  @fiveAdicCorrection_selected_digit
example : ∀ m j ell k A u : ℕ, j < ell → ell ≤ m →
    (fiveAdicCorrection m j k * (A * (5 ^ ell * u))) % (5 * 5 ^ m) =
      (A * (5 ^ ell * u)) % (5 * 5 ^ m) := @fiveAdicCorrection_higher_residue
example : ∀ m A u : ℕ, (A * (5 ^ m * u)) % (5 * 5 ^ m) =
    5 ^ m * ((A * u) % 5) := @fiveAdic_top_residue
example : ∀ m A u : ℕ, ¬ 5 ∣ A * u →
    5 ^ m ≤ cyclicResidueDistance (5 * 5 ^ m) (A * (5 ^ m * u)) :=
  @fiveAdic_top_distance
example {I : Type*} [Fintype I] (q s : I → ℕ) (hcard : Fintype.card I ≤ 2)
    (hunit : ∀ i, ¬ 5 ∣ s i) :
    ∃ k : Fin 5, ∀ i, 1 ≤ (q i + k.val * s i) % 5 ∧
      (q i + k.val * s i) % 5 ≤ 3 := fiveAdic_avoid_two q s hcard hunit
example : ∀ m x y : ℕ, x % (5 * 5 ^ m) = y % (5 * 5 ^ m) →
    fiveAdicDigit m x = fiveAdicDigit m y := @fiveAdicDigit_of_mod_eq
example : ∀ m A : ℕ, ¬ 5 ∣ A →
    0 < A % (5 * 5 ^ m) ∧ A % (5 * 5 ^ m) < 5 * 5 ^ m ∧
      ¬ 5 ∣ A % (5 * 5 ^ m) ∧ (A % (5 * 5 ^ m)) % 5 = A % 5 ∧
        ∀ d : ℕ, ((A % (5 * 5 ^ m)) * d) % (5 * 5 ^ m) =
          (A * d) % (5 * 5 ^ m) := @fiveAdic_unit_representative
example {I : Type*} [Fintype I] [DecidableEq I] (d ell u : I → ℕ)
    (m r A : ℕ) (hr : r ≤ m) (hdecomp : ∀ i, d i = 5 ^ ell i * u i)
    (hu : ∀ i, ¬ 5 ∣ u i) (hA : ¬ 5 ∣ A)
    (hcard : (Finset.univ.filter fun i => ell i = r).card ≤ 2) :
    ∃ k : Fin 5, ∀ i, ell i = r →
      FiveAdicGoodDigit m (fiveAdicCorrection m r k.val * (A * d i)) :=
  fiveAdic_fill_level d ell u m r A hr hdecomp hu hA hcard
example {I : Type*} [Fintype I] [DecidableEq I] (d ell u : I → ℕ) (m h A : ℕ)
    (hd : ∀ i, 0 < d i) (hdecomp : ∀ i, d i = 5 ^ ell i * u i)
    (hu : ∀ i, ¬ 5 ∣ u i) (hell : ∀ i, ell i ≤ m) (hh : h ≤ m)
    (hApos : 0 < A) (hAunit : ¬ 5 ∣ A)
    (hcard : ∀ j, j < h → (Finset.univ.filter fun i => ell i = j).card ≤ 2)
    (hhigh : ∀ i, h ≤ ell i → 5 ^ m ≤ cyclicResidueDistance (5 * 5 ^ m) (A * d i)) :
    ∃ B : ℕ, 0 < B ∧ ¬ 5 ∣ B ∧ B % 5 = A % 5 ∧
      (∀ i, h ≤ ell i → (B * d i) % (5 * 5 ^ m) = (A * d i) % (5 * 5 ^ m)) ∧
      (∀ i, ell i < h → FiveAdicGoodDigit m (B * d i)) ∧
      (∀ i, 5 ^ m ≤ cyclicResidueDistance (5 * 5 ^ m) (B * d i)) :=
  fiveAdic_seeded_unbounded d ell u m h A hd hdecomp hu hell hh hApos hAunit hcard hhigh
example {I : Type*} [Fintype I] [DecidableEq I] (d ell u : I → ℕ) (m h A : ℕ)
    (hd : ∀ i, 0 < d i) (hdecomp : ∀ i, d i = 5 ^ ell i * u i)
    (hu : ∀ i, ¬ 5 ∣ u i) (hell : ∀ i, ell i ≤ m) (hh : h ≤ m)
    (hApos : 0 < A) (hAunit : ¬ 5 ∣ A)
    (hcard : ∀ j, j < h → (Finset.univ.filter fun i => ell i = j).card ≤ 2)
    (hhigh : ∀ i, h ≤ ell i → 5 ^ m ≤ cyclicResidueDistance (5 * 5 ^ m) (A * d i)) :
    ∃ lam : ℕ, 0 < lam ∧ lam < 5 * 5 ^ m ∧ ¬ 5 ∣ lam ∧ lam % 5 = A % 5 ∧
      (∀ i, h ≤ ell i → (lam * d i) % (5 * 5 ^ m) = (A * d i) % (5 * 5 ^ m)) ∧
      (∀ i, ell i < h → FiveAdicGoodDigit m (lam * d i)) ∧
      (∀ i, 5 ^ m ≤ cyclicResidueDistance (5 * 5 ^ m) (lam * d i)) :=
  fiveAdic_seeded_multiplier d ell u m h A hd hdecomp hu hell hh hApos hAunit hcard hhigh
example {I : Type*} [Fintype I] [DecidableEq I] (d ell u : I → ℕ) (m : ℕ)
    (hd : ∀ i, 0 < d i) (hdecomp : ∀ i, d i = 5 ^ ell i * u i)
    (hu : ∀ i, ¬ 5 ∣ u i) (hell : ∀ i, ell i ≤ m)
    (hcard : ∀ j, j < m → (Finset.univ.filter fun i => ell i = j).card ≤ 2) :
    ∃ lam : ℕ, 0 < lam ∧ lam < 5 * 5 ^ m ∧ lam % 5 = 1 ∧ ¬ 5 ∣ lam ∧
      (∀ i, ell i < m → FiveAdicGoodDigit m (lam * d i)) ∧
      (∀ i, ell i = m → (lam * d i) % (5 * 5 ^ m) = d i % (5 * 5 ^ m)) ∧
      (∀ i, 5 ^ m ≤ cyclicResidueDistance (5 * 5 ^ m) (lam * d i)) :=
  exists_five_adic_filtered_multiplier d ell u m hd hdecomp hu hell hcard

-- Four exact normalization types, preserving arbitrary multipliers.
example : ∀ P x y : ℕ, x % P = y % P →
    cyclicResidueDistance P x = cyclicResidueDistance P y :=
  @cyclicResidueDistance_eq_of_mod_eq
example : ∀ P X Y : ℕ, 0 < P → (X + Y) % P = 0 →
    cyclicResidueDistance P X = cyclicResidueDistance P Y :=
  @cyclicResidueDistance_eq_of_add_mod_eq_zero
example : ∀ P s A : ℕ, 0 < P → s ≤ P →
    cyclicResidueDistance P (A * (P - s)) = cyclicResidueDistance P (A * s) :=
  @cyclicResidueDistance_mul_complement
example : ∀ m d : ℕ, ¬ 5 ∣ d →
    ∃ x : ℕ, 0 < x ∧ x < 5 * 5 ^ m ∧ (x % 5 = 1 ∨ x % 5 = 2) ∧
      ∀ A : ℕ, cyclicResidueDistance (5 * 5 ^ m) (A * x) =
        cyclicResidueDistance (5 * 5 ^ m) (A * d) := @fiveAdic_normalize_unit

-- Unchanged full finite-carry type and earlier canonical compatibility.
example : ∀ s : Fin 3 → FiveCarryState, ∃ u : Fin 3, ∃ k : Fin 5, ∀ i,
    (fiveCarryDigit (s i) u k).val ∈ ({1, 2, 3} : Finset ℕ) := fiveCarryTriple
example : ∀ speeds : Fin 4 → ℝ, Function.Injective speeds →
    ∀ runner : Fin 4, ∃ t : ℝ, LonelyAt speeds runner t := fourRunners

-- Current coefficient, top equality, m=0 arithmetic and a bounded representative.
example : fiveAdicDigit 3 (fiveAdicCorrection 3 1 3 * (2 * (5 ^ 1 * 7))) = 2 := by
  norm_num [fiveAdicDigit, fiveAdicCorrection]
example : (fiveAdicDigit 3 (2 * (5 ^ 1 * 7)) + 3 * (7 % 5)) % 5 ≠ 2 := by
  norm_num [fiveAdicDigit]
example : (fiveAdicCorrection 3 1 3 * (2 * (5 ^ 2 * 3))) % (5 * 5 ^ 3) =
    (2 * (5 ^ 2 * 3)) % (5 * 5 ^ 3) :=
  fiveAdicCorrection_higher_residue 3 1 2 3 2 3 (by omega) (by omega)
example : cyclicResidueDistance 625 500 = 125 ∧ ¬ FiveAdicGoodDigit 3 500 := by
  norm_num [cyclicResidueDistance, FiveAdicGoodDigit, fiveAdicDigit]
example : fiveAdicDigit 0 (fiveAdicCorrection 0 0 1 * (2 * (5 ^ 0 * 2))) =
    (fiveAdicDigit 0 (2 * (5 ^ 0 * 2)) + 1 * ((2 * 2) % 5)) % 5 :=
  fiveAdicCorrection_selected_digit 0 0 1 2 2 (by omega)
example : 0 < 127 % 125 ∧ 127 % 125 < 125 ∧ ¬ 5 ∣ 127 % 125 ∧
    (127 % 125) % 5 = 127 % 5 ∧ ∀ d : ℕ,
      ((127 % 125) * d) % 125 = (127 * d) % 125 :=
  fiveAdic_unit_representative 2 127 (by norm_num)

-- Empty and repeated affine rows; the missing-unit converse is deliberately false.
example : ∃ k : Fin 5, ∀ _i : Empty, 1 ≤ (k.val * 0) % 5 ∧ (k.val * 0) % 5 ≤ 3 :=
  fiveAdic_avoid_two (fun _ : Empty => 0) (fun _ => 0) (by simp)
    (by intro i; exact nomatch i)
example : ∃ k : Fin 5, ∀ i : Fin 2,
    1 ≤ (![0,0] i + k.val * ![1,1] i) % 5 ∧
      (![0,0] i + k.val * ![1,1] i) % 5 ≤ 3 :=
  fiveAdic_avoid_two ![0,0] ![1,1] (by norm_num)
    (by intro i h; fin_cases i <;> norm_num at h)
example : ¬ ∃ k : Fin 5, 1 ≤ (k.val * 0) % 5 ∧ (k.val * 0) % 5 ≤ 3 := by
  rintro ⟨k,h⟩
  norm_num at h

-- Empty h=0 seed retains residue 2, then a nontrivial two-level seeded application.
example : ∃ lam : ℕ, 0 < lam ∧ lam < 125 ∧ lam % 5 = 2 := by
  obtain ⟨lam,hpos,hlt,hunit,hmod,hrest⟩ := fiveAdic_seeded_multiplier
    (fun i : Empty => nomatch i) (fun i => nomatch i) (fun i => nomatch i) 2 0 127
    (by intro i; exact nomatch i) (by intro i; exact nomatch i)
    (by intro i; exact nomatch i) (by intro i; exact nomatch i)
    (by omega) (by norm_num) (by norm_num) (by intro j hj; omega)
    (by intro i; exact nomatch i)
  exact ⟨lam,hpos,hlt,by simpa using hmod⟩
example : ∃ lam : ℕ, 0 < lam ∧ lam < 125 ∧ lam % 5 = 2 ∧
    (lam * 25) % 125 = 50 ∧ ∀ i : Fin 4,
      25 ≤ cyclicResidueDistance 125 (lam * (![1,2,5,25] i : ℕ)) := by
  obtain ⟨lam,hpos,hlt,hunit,hmod,hres,hgood,hdist⟩ :=
    fiveAdic_seeded_multiplier ![1,2,5,25] ![0,0,1,2] ![1,2,1,1] 2 2 2
      (by intro i; fin_cases i <;> norm_num)
      (by intro i; fin_cases i <;> norm_num)
      (by intro i h; fin_cases i <;> norm_num at h)
      (by intro i; fin_cases i <;> norm_num)
      (by omega) (by norm_num) (by norm_num)
      (by intro j hj; interval_cases j <;> decide)
      (by
        intro i hi
        fin_cases i
        · norm_num at hi
        · norm_num at hi
        · norm_num at hi
        · norm_num [cyclicResidueDistance])
  refine ⟨lam,hpos,hlt,by simpa using hmod,?_,hdist⟩
  simpa using hres (3 : Fin 4) (by decide)

-- More than two repeated top labels are allowed, including m=0 and digit four.
example : ∃ lam : ℕ, 0 < lam ∧ lam < 5 ∧ lam % 5 = 1 ∧
    ∀ i : Fin 3, 1 ≤ cyclicResidueDistance 5 (lam * (![4,4,4] i : ℕ)) := by
  obtain ⟨lam,hpos,hlt,hmod,hunit,hgood,hres,hdist⟩ :=
    exists_five_adic_filtered_multiplier ![4,4,4] ![0,0,0] ![4,4,4] 0
      (by intro i; fin_cases i <;> norm_num)
      (by intro i; fin_cases i <;> norm_num)
      (by intro i h; fin_cases i <;> norm_num at h)
      (by intro i; fin_cases i <;> norm_num) (by intro j hj; omega)
  exact ⟨lam,hpos,hlt,hmod,hdist⟩

-- Composite/zero/half symmetry, natural complement boundaries and m=0 normalization.
example : cyclicResidueDistance 6 14 = cyclicResidueDistance 6 4 :=
  cyclicResidueDistance_eq_of_add_mod_eq_zero 6 14 4 (by norm_num) (by norm_num)
example : cyclicResidueDistance 6 12 = cyclicResidueDistance 6 0 :=
  cyclicResidueDistance_eq_of_add_mod_eq_zero 6 12 0 (by norm_num) (by norm_num)
example : cyclicResidueDistance 6 3 = cyclicResidueDistance 6 3 :=
  cyclicResidueDistance_eq_of_add_mod_eq_zero 6 3 3 (by norm_num) (by norm_num)
example : cyclicResidueDistance 6 (0 * (6 - 6)) = cyclicResidueDistance 6 (0 * 6) :=
  cyclicResidueDistance_mul_complement 6 6 0 (by norm_num) (by norm_num)
example : cyclicResidueDistance 6 (2 * (6 - 2)) = cyclicResidueDistance 6 (2 * 2) :=
  cyclicResidueDistance_mul_complement 6 2 2 (by norm_num) (by norm_num)
example : cyclicResidueDistance 6 (6 - 8) ≠ cyclicResidueDistance 6 8 := by
  norm_num [cyclicResidueDistance]
example : ∃ x : ℕ, 0 < x ∧ x < 5 ∧ (x % 5 = 1 ∨ x % 5 = 2) ∧
    ∀ A : ℕ, cyclicResidueDistance 5 (A * x) = cyclicResidueDistance 5 (A * 13) :=
  fiveAdic_normalize_unit 0 13 (by norm_num)

-- Fixed coupled-carry rows: J=3 is necessary, and repeated states remain admitted.
private def reviewCarryFixture : Fin 3 → FiveCarryState :=
  ![⟨0,0,0⟩, ⟨1,0,2⟩, ⟨3,0,0⟩]
example : ∀ i, (fiveCarryDigit (reviewCarryFixture i) 2 1).val ∈
    ({1,2,3} : Finset ℕ) := by decide
example : ∀ k : Fin 5,
    (¬ ∀ i, (fiveCarryDigit (reviewCarryFixture i) 0 k).val ∈ ({1,2,3} : Finset ℕ)) ∧
    (¬ ∀ i, (fiveCarryDigit (reviewCarryFixture i) 1 k).val ∈ ({1,2,3} : Finset ℕ)) := by
  decide
example : ∃ u : Fin 3, ∃ k : Fin 5, ∀ _i : Fin 3,
    (fiveCarryDigit (⟨4,1,3⟩ : FiveCarryState) u k).val ∈ ({1,2,3} : Finset ℕ) :=
  fiveCarryTriple (fun _ => ⟨4,1,3⟩)

#check fiveAdicCorrection_pos
#check fiveAdicCorrection_mod_five
#check fiveAdic_residue_decomposition
#check fiveAdicGoodDigit_distance
#check fiveAdicCorrection_selected_product
#check fiveAdicCorrection_selected_digit
#check fiveAdicCorrection_higher_residue
#check fiveAdic_top_residue
#check fiveAdic_top_distance
#check fiveAdic_avoid_two
#check fiveAdicDigit_of_mod_eq
#check fiveAdic_unit_representative
#check fiveAdic_fill_level
#check fiveAdic_seeded_unbounded
#check fiveAdic_seeded_multiplier
#check exists_five_adic_filtered_multiplier
#check cyclicResidueDistance_eq_of_mod_eq
#check cyclicResidueDistance_eq_of_add_mod_eq_zero
#check cyclicResidueDistance_mul_complement
#check fiveAdic_normalize_unit
#check fiveCarryTriple
#check fourRunners
#print axioms LonelyRunner.fiveAdicCorrection_pos
#print axioms LonelyRunner.fiveAdicCorrection_mod_five
#print axioms LonelyRunner.fiveAdic_residue_decomposition
#print axioms LonelyRunner.fiveAdicGoodDigit_distance
#print axioms LonelyRunner.fiveAdicCorrection_selected_product
#print axioms LonelyRunner.fiveAdicCorrection_selected_digit
#print axioms LonelyRunner.fiveAdicCorrection_higher_residue
#print axioms LonelyRunner.fiveAdic_top_residue
#print axioms LonelyRunner.fiveAdic_top_distance
#print axioms LonelyRunner.fiveAdic_avoid_two
#print axioms LonelyRunner.fiveAdicDigit_of_mod_eq
#print axioms LonelyRunner.fiveAdic_unit_representative
#print axioms LonelyRunner.fiveAdic_fill_level
#print axioms LonelyRunner.fiveAdic_seeded_unbounded
#print axioms LonelyRunner.fiveAdic_seeded_multiplier
#print axioms LonelyRunner.exists_five_adic_filtered_multiplier
#print axioms LonelyRunner.cyclicResidueDistance_eq_of_mod_eq
#print axioms LonelyRunner.cyclicResidueDistance_eq_of_add_mod_eq_zero
#print axioms LonelyRunner.cyclicResidueDistance_mul_complement
#print axioms LonelyRunner.fiveAdic_normalize_unit
#print axioms LonelyRunner.fiveCarryTriple
#print axioms LonelyRunner.fourRunners
```

## Build, resource and terminal provenance

Root's full build, session `78054`, ended with terminal exit 0 and 3654 jobs.
Root's full trust audit, session `62541`, also ended with terminal exit 0.
I read and hash-checked the final logs and independently parsed all 517
dependency reports against the permitted axiom set. Three other declarations
are explicitly axiom-free: existing normalizedBadCount, existing
rationalMarginBoxPilot_fin_zero_accepts, and new
cyclicResidueDistance_eq_of_mod_eq. This is 520 total reports, not 517 total
declarations. No allowed-axiom exception was required.

I read the complete final Carry implementation report, including its fresh
runtime-environment capture and full-source resource command. Its command
hash is bound to root's successful replay below. The command checks the
frozen 16,638-byte source and pinned binary, runs the complete source through
a direct Lean process, enforces sampled descendant RSS and wall limits,
and separately checks GNU time's peak, wall and exit. It does not substitute
a prefix or old failed source. Runtime-variable preparation happens before
the timed source check. Root's replay measured monitor wall 4.921 seconds,
sampled RSS sum 3,853,936 KiB, GNU wall 4.94 seconds and peak 3,853,580 KiB,
with child and postcheck exit 0, below the single 60-second/4-GiB cap.

The RSS measures have distinct meanings: the process tree is sampled every
20 ms, and GNU time reports a separate peak. This does not constitute a
continuous OS-enforced aggregate-memory ceiling. No reviewer performance
rerun was needed. The failed full-state evaluations in the report remain
historical failures; only the new symbolic source was accepted.

| Root receipt | SHA-256 |
| --- | --- |
| `/tmp/astra-pass38-full-build.log` | `da969a453839b67325b7761867c53b63595221f98ece494c19294f47214715ed` |
| `/tmp/astra-pass38-trust.log` | `2ac6b236114e2185ecedb7cca2802bdddd12d8f5bb73e660f215a1710780400b` |
| Self-contained Carry resource command | `0a21598ca158b955d04a55be60e11cb536f27421962d1f6f14688579fe9a3d67` |
| Resource root-replay JSON | `8f5faaae3ab4777aaa68176732a760877011cf2c6a749802cb9ae007271e863b` |
| Raw resource root-replay stdout | `4e3460159d45487487fa5133863e3c89dbe177f9f21ca29c23915752af8f5757` |

The review's sole Python block was extracted from this file and run with
`python3 -B -`; its only Lean command is the embedded `lake env lean --stdin`.
The first focused run, session `63196`, reached terminal exit 1. All public
type/axiom prints were present, but my multi-level seeded control used
`norm_num ... at hi ⊢`, which closed its contradictory hypotheses before
the target pass, and used `norm_num` for a literal vector-index bound that
needed `decide`. These were control-tactic errors, not source or contract
failures. The raw failed stdout hash was
`c7d41b89a408490806654aedae76a157a77435e343d504285915b48f102d34b9`.
Only those two parts of the review's Lean control were repaired.

The corrected run, session `49272`, reached terminal exit 0 (tool chunk
`4bf919`). All 44 examples passed, including the exact 21 new types, old
fourRunners type, current-coefficient countercontrol, top-digit-four equality,
empty and repeated labels, h=0 residue-two seed, nontrivial seeded high-residue
preservation, m=0 unseeded top family, generic complement edge cases, universal
normalizer, and the fixed J=3 carry fixture. The 22 axiom prints consisted of
21 permitted-only dependency lists and the new axiom-free equality theorem.
All 19 guards and old root/audit/public-Carry byte checks passed before and
after. No subsequent warning-only control changes or extra Lean run was made.

| Frozen focused executable | SHA-256 |
| --- | --- |
| Sole Python block | `db5231f4c54fa22a8678d36f291db5a1335d70762f7e0cf39eed07fb651b505c` |
| Raw review-program stdout | `0a2f5d609b9bb4f2cb0a174c3c48a2852ccdda81233bdb40edd0b7e21273b306` |
| Lean stdin block | `d2105319d804858fc10a4a14d6e318125541fb968d5c3642849770e47d9005de` |
| Raw Lean stdout | `a87b636302712728a7fb3b51841b408b9a47f4569ebf63b2f4dee99bcb10e678` |

The review-program stdout hash includes its printed Lean output and final
JSON, excluding outer hash labels. The guarded source and report hashes are
explicit in the executable block, so no temporary proof file is required
to reproduce the focused checks. The historical source text is read only
for byte comparison, never compiled or evaluated by this reproducer.
Final structural workflow validation passed.

All reviewer processes have stopped. The three source modules, root/audit
files and shared cache are unchanged by the review. Remaining mathematical
integration work includes the simultaneous natural carry-tag/state/digit
adapter, conditional hard-pattern assembly, valuation case split and final
canonical bridge; the accepted supporting modules alone do not complete
those steps.
