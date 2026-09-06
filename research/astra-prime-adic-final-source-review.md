# Independent final source review of prime-adic arithmetic and compression

2026-09-06. Requested independent Astra/xhigh review, task
`/root/prime_adic_final_source_review`, executed by reused agent
`/root/seven_adic_expanded_falsifier`. Runtime model/effort are not independently
attested. Root source checkpoint: `f1d45fdf95af26f31cffcc92485fc5951c4b0169`.
Only this report is owned. Configuration, workflow, policy and focused active
state were read, including after compaction; the workflow validator passed.
The overall unrestricted LRC goal remains active and unresolved.

## Independent semantic verdict

**Accept the exact F, C and signed C contracts and their source proofs, subject
to the actual focused kernel receipt below. No mathematical defect found.**
All 527 lines of the two new modules, their five public definitions, twenty
public theorems and three private helpers were read. The frozen author plan is
`research/astra-prime-difference-compression-plan.md`, SHA-256
`ee396d22cae90460868ee13ba70c26204cafad190aea3b72835680218b3c88c2`;
the prior independent review is
`research/astra-prime-difference-compression-review.md`, SHA-256
`a3a77cdfbc4f983755d38bd75a7aad6ccdeb4534d5c1ec455dfce0320c1d4947`.
The guards below bind the exact implementation, integration, old canonical
sources and pinned toolchain/manifest reviewed here.

Write `R=p^m`, `P=pR`, and `q(x)=(x/R)%p`. The new primitives preserve this
literal natural division convention. For `j<=m`, the selected correction
identity adds `k*R*A*u`; dividing by R gives the current coefficient
`(A*u)%p`. For `j<ell<=m`, the higher increment is a multiple of P.
The source's exponent subtraction is guarded precisely where used. The
unrestricted residue decomposition and digit-congruence identities also
respect Lean's total natural division conventions at degenerate bases;
the target and compression theorems require a prime and hence `p>=2`.

The unit representative is positive because a zero P-residue would force
zero residue modulo p. Its product-residue statement is universal in the
other factor. Positive bounded-residue decomposition excludes zero before
using `padicValNat`; divisibility and `x<P` force the valuation at most m.
Both ZMod solvers prove the denominator nonzero from the supplied unit
premises. At the top level the target is required positive and is selected
by a nonzero scalar below p. Below the top it is solved by a correction
congruent to one modulo p. These prove all eleven public arithmetic
theorems with their stated assumptions; positivity on u is already implied
by the unit assumption.

F orders the distinct levels, solves the high target first, then uses the
actual current multiplier in the low equation. The higher *residue* is
preserved, not merely its digit. Final reduction modulo P preserves both
products and the unit condition. Its exact type below retains both
decompositions, both live-level bounds, inequality of levels, both unit
factors, target bounds, both conditional top-target restrictions and a
positive bounded unit multiplier. There is no input bound `x,y<P`, odd-prime
restriction or additional separation premise. At m=0 its distinct live
level hypotheses are inconsistent, as they should be. The unbounded
one-target helper, correction-unit theorem and private ordered helper retain
the same top/lower distinction.

The natural oriented difference is `(a%P+P-b%P)%P`: the added P dominates
the subtrahend, so natural subtraction does not lose the orientation.
`primeAdicDifference_add_anchor` proves the required anchor congruence.
For the addition lemma, write `c=R*C+r`, `d=R*D+s`, with `r,s<R`.
The premise says `D mod p=p-1`. The carry is zero or one: zero gives
`(q(c)+p-1)%p`, one gives `q(c)`. At `d mod P=P-R`, `s=0`, so the carry is
zero, and the *closed* `-R` endpoint gives the cyclic predecessor. The
source `Nat.add_div` split implements exactly this proof, including cyclic
wrap when the anchor digit is zero. It makes no false assertion about
the digit of a negated endpoint difference. It is equivalent to the
accepted closed signed interval argument.

C first produces a common positive bounded unit sending each nonzero
oriented difference to digit p-1. Its separation predicate expressly admits
either zero residue, so both collapsed differences are allowed, including
unequal unreduced inputs separated by multiples of P. Only a nonzero
bounded residue is decomposed. For two live differences F applies with
positive targets p-1, including a top level and p=2. Anchor congruence is
multiplied by the same unit and the addition lemma supplies the two-digit
conclusion for each nonanchor label; the anchor is reflexive. This proves
the other seven natural public theorems, without presuming a minimum-length
API, input positivity or distinct labels.

The signed definition uses `Int.natMod`, not `natAbs`. For positive P its
natural residue cast is the integer Euclidean remainder in `[0,P)`.
The private cast lemma and public multiplication lemma use this congruence
to transfer arbitrary signed products, including negative values and zero.
Signed C states its separation hypothesis on exactly the two oriented
differences of these residues and applies natural C. There is no hidden
sign restriction, multiplication bound, or changed anchor. This reviews
the final two public theorems and fifth definition.

The accepted dependency order is arithmetic identities and unit reduction;
guarded decomposition and separate top/lower target solvers; ordered F;
oriented difference and carry lemma; zero/live common targets and C; signed
residue transfer and signed C. Root imports both modules and has placed all
twenty public theorem axiom commands in `LonelyRunner/AxiomAudit.lean`.
No changes to the older five-adic or canonical sources are needed.

## Focused kernel probe and fixed controls

The probe below contains five exact definitional checks, universal explicit
types for F/C/signed C and six existing natural/canonical interfaces, five
fixed target pairs, eight fixed triple witnesses, endpoint/current-coefficient
controls, and a symbolic proof for the single same-level obstruction tuple.
The obstruction quantifies its multiplier algebraically; it enumerates no
multiplier or speed family. `norm_num`, `omega` and ordinary `decide` produce kernel proof terms;
there is no `native_decide`, solver call, search or computational trust axiom.
The eight triples retain their earlier numerical choices, including negative
anchors, repeated actual inputs, both collapsed, m=0, p=2 and p=2,m=0.

Predeclared execution: one fixed stdin probe, at most three attempts only to
repair probe elaboration if necessary, at most 120 seconds per attempt.
No adaptive mathematical fixtures, source edits, builds, dependency restore,
state/Git writes or cache cleanup. The shared root build cache is retained.
The parent enforces the wall timeout; no artificial 256 MiB limit is applied
to Lean's existing large imported environment. Actual elapsed time, child
CPU and maximum RSS are reported. All retained evidence is below 1 MiB.
A probe error or timeout would be a verification failure, not a mathematical
counterexample. Full root build and project trust-audit evidence belong to
the orchestrator; this review independently checks focused imports and types.

The complete probe, with exactly one `lean` fence for replay extraction:

```lean
import LonelyRunner.PrimeAdicCompression
import LonelyRunner.FiveRunnerCanonical
import LonelyRunner.FourRunnerCanonical

open LonelyRunner
set_option maxHeartbeats 1000000

example (p m x : ℕ) : primeAdicDigit p m x = (x / p ^ m) % p := rfl
example (p m j k : ℕ) : primeAdicCorrection p m j k = 1 + k * p ^ (m-j) := rfl
example (p m a b : ℕ) : primeAdicDifference p m a b =
    (a % p^(m+1) + p^(m+1) - b % p^(m+1)) % p^(m+1) := rfl
example (p m x y : ℕ) : PrimeAdicDifferenceSeparated p m x y ↔
    x = 0 ∨ y = 0 ∨ ∃ a b u v : ℕ,
      a ≤ m ∧ b ≤ m ∧ a ≠ b ∧ x = p^a*u ∧ y = p^b*v ∧
      ¬ p ∣ u ∧ ¬ p ∣ v := Iff.rfl
example (p m : ℕ) (z : ℤ) : signedPrimeAdicDigit p m z =
    primeAdicDigit p m (z.natMod (p^(m+1) : ℤ)) := rfl

-- Universal F: every bound and conditional top restriction is explicit.
example (p m x y a b u v tx ty : ℕ) (hp : Nat.Prime p)
    (hx : x = p^a*u) (hy : y = p^b*v)
    (ha : a ≤ m) (hb : b ≤ m) (hab : a ≠ b)
    (hu : ¬ p ∣ u) (hv : ¬ p ∣ v) (htx : tx < p) (hty : ty < p)
    (htopx : a = m → 0 < tx) (htopy : b = m → 0 < ty) :
    ∃ lam : ℕ, 0 < lam ∧ lam < p^(m+1) ∧ ¬ p ∣ lam ∧
      primeAdicDigit p m (lam*x) = tx ∧ primeAdicDigit p m (lam*y) = ty :=
  primeAdic_two_distinct_targets p m x y a b u v tx ty hp hx hy ha hb hab
    hu hv htx hty htopx htopy

-- Universal C: unreduced natural labels and the exact oriented premise.
example (p m : ℕ) (hp : Nat.Prime p) (b : Fin 3 → ℕ)
    (hsep : PrimeAdicDifferenceSeparated p m
      (primeAdicDifference p m (b 0) (b 2))
      (primeAdicDifference p m (b 1) (b 2))) :
    ∃ lam : ℕ, 0 < lam ∧ lam < p^(m+1) ∧ ¬ p ∣ lam ∧ ∀ i : Fin 3,
      primeAdicDigit p m (lam*b i) = primeAdicDigit p m (lam*b 2) ∨
      primeAdicDigit p m (lam*b i) = (primeAdicDigit p m (lam*b 2)+p-1)%p :=
  primeAdic_triple_compression p m hp b hsep

-- Universal signed C: negative labels retain Euclidean orientation.
example (p m : ℕ) (hp : Nat.Prime p) (b : Fin 3 → ℤ)
    (hsep : PrimeAdicDifferenceSeparated p m
      (primeAdicDifference p m ((b 0).natMod (p^(m+1) : ℤ))
        ((b 2).natMod (p^(m+1) : ℤ)))
      (primeAdicDifference p m ((b 1).natMod (p^(m+1) : ℤ))
        ((b 2).natMod (p^(m+1) : ℤ)))) :
    ∃ lam : ℕ, 0 < lam ∧ lam < p^(m+1) ∧ ¬ p ∣ lam ∧ ∀ i : Fin 3,
      signedPrimeAdicDigit p m ((lam : ℤ)*b i) =
        signedPrimeAdicDigit p m ((lam : ℤ)*b 2) ∨
      signedPrimeAdicDigit p m ((lam : ℤ)*b i) =
        (signedPrimeAdicDigit p m ((lam : ℤ)*b 2)+p-1)%p :=
  primeAdic_triple_compression_int p m hp b hsep

example (d ell u : Fin 4 → ℕ) (m : ℕ) (hd : ∀ i, 0 < d i)
    (hdecomp : ∀ i, d i = 5^(ell i)*u i) (hu : ∀ i, ¬ 5 ∣ u i)
    (hell : ∀ i, ell i ≤ m) (hmax : ∃ i, ell i = m) :
    ∃ lam : ℕ, 0 < lam ∧ lam < 5*5^m ∧ ¬ 5 ∣ lam ∧
      ∀ i, 5^m ≤ cyclicResidueDistance (5*5^m) (lam*d i) :=
  fiveAdic_four_label_multiplier d ell u m hd hdecomp hu hell hmax
example (v : Fin 4 → ℕ) (hpos : ∀ i, 0 < v i) :
    ∃ m lam : ℕ, 0 < lam ∧ lam < 5*5^m ∧ ¬ 5 ∣ lam ∧
      ∀ i, 5^m ≤ cyclicResidueDistance (5*5^m) (lam*v i) :=
  fourMovingNaturalMultiplier v hpos
example (v : Fin 4 → ℕ) (hpos : ∀ i, 0 < v i) :
    ∃ t : ℝ, 0 < t ∧ ∀ i, (5 : ℝ)⁻¹ ≤ circleNorm (t*(v i : ℝ)) :=
  fourMovingNaturalRunners v hpos
example : LowerCountPositiveIntegerHypothesis 6 := lowerCountPositiveIntegerHypothesis_six
example (v : Fin 4 → ℝ) (h : Function.Injective v) (r : Fin 4) :
    ∃ t : ℝ, LonelyAt v r t := fourRunners v h r
example (v : Fin 5 → ℝ) (h : Function.Injective v) (r : Fin 5) :
    ∃ t : ℝ, LonelyAt v r t := fiveRunners v h r

namespace PrimeAdicSourceReview

-- Five earlier fixed target pairs, including both orders, p=2 and x,y>P.
example : primeAdicDigit 7 3 (1182*686) = 5 ∧
    primeAdicDigit 7 3 (1182*21) = 2 ∧ 0 < (1182 : ℕ) ∧
    1182 < 7^4 ∧ ¬ 7 ∣ (1182 : ℕ) := by norm_num [primeAdicDigit]
example : primeAdicDigit 5 3 (396*50) = 3 ∧
    primeAdicDigit 5 3 (396*3) = 4 ∧ 0 < (396 : ℕ) ∧
    396 < 5^4 ∧ ¬ 5 ∣ (396 : ℕ) := by norm_num [primeAdicDigit]
example : primeAdicDigit 3 2 (20*4) = 2 ∧
    primeAdicDigit 3 2 (20*18) = 1 ∧ 0 < (20 : ℕ) ∧
    20 < 3^3 ∧ ¬ 3 ∣ (20 : ℕ) := by norm_num [primeAdicDigit]
example : primeAdicDigit 2 1 (3*2) = 1 ∧
    primeAdicDigit 2 1 (3*1) = 1 ∧ 0 < (3 : ℕ) ∧
    3 < 2^2 ∧ ¬ 2 ∣ (3 : ℕ) := by norm_num [primeAdicDigit]
example : primeAdicDigit 7 2 (199*392) = 3 ∧
    primeAdicDigit 7 2 (199*400) = 0 ∧ 0 < (199 : ℕ) ∧
    199 < 7^3 ∧ ¬ 7 ∣ (199 : ℕ) := by norm_num [primeAdicDigit]

-- The wrong old coefficient chooses k=3 and misses target 2; k=4 succeeds.
example : (6*3 : ℕ)%7 = 4 ∧
    primeAdicDigit 7 3 (primeAdicCorrection 7 3 1 3*(6*21)) = 5 ∧
    primeAdicDigit 7 3 (primeAdicCorrection 7 3 1 4*(6*21)) = 2 ∧
    (primeAdicCorrection 7 3 1 4*(6*686)) % 7^4 = (6*686)%7^4 := by
  norm_num [primeAdicDigit, primeAdicCorrection]

-- Closed -R endpoint, negation asymmetry, and both carry branches.
example : primeAdicDifference 7 2 295 1 = 294 ∧
    primeAdicDifference 7 2 337 1 = 336 ∧
    primeAdicDigit 7 2 294 = 6 ∧ primeAdicDigit 7 2 49 = 1 ∧
    primeAdicDigit 7 2 (1+294) = 6 ∧ primeAdicDigit 7 2 (48+336) = 0 := by
  norm_num [primeAdicDifference, primeAdicDigit]
example : PrimeAdicDifferenceSeparated 7 2 294 336 := by
  exact Or.inr (Or.inr ⟨2,1,6,48, by norm_num⟩)
example : PrimeAdicDifferenceSeparated 7 2
    (primeAdicDifference 7 2 344 1) (primeAdicDifference 7 2 2402 1) := by
  left; norm_num [primeAdicDifference]

-- Witness predicates include the full multiplier and anchor/predecessor bounds.
def NatWitness (p m lam : ℕ) (b : Fin 3 → ℕ) : Prop :=
  0 < lam ∧ lam < p^(m+1) ∧ ¬ p ∣ lam ∧ ∀ i : Fin 3,
    primeAdicDigit p m (lam*b i) = primeAdicDigit p m (lam*b 2) ∨
    primeAdicDigit p m (lam*b i) = (primeAdicDigit p m (lam*b 2)+p-1)%p
def IntWitness (p m lam : ℕ) (b : Fin 3 → ℤ) : Prop :=
  0 < lam ∧ lam < p^(m+1) ∧ ¬ p ∣ lam ∧ ∀ i : Fin 3,
    signedPrimeAdicDigit p m ((lam : ℤ)*b i) =
      signedPrimeAdicDigit p m ((lam : ℤ)*b 2) ∨
    signedPrimeAdicDigit p m ((lam : ℤ)*b i) =
      (signedPrimeAdicDigit p m ((lam : ℤ)*b 2)+p-1)%p

example : NatWitness 7 2 1 ![295,337,1] := by
  unfold NatWitness; decide
example : NatWitness 7 2 43 ![344,8,1] := by
  unfold NatWitness; decide
example : NatWitness 7 2 1 ![344,2402,1] := by
  unfold NatWitness; decide
example : NatWitness 7 0 5 ![2,5,5] := by
  unfold NatWitness; decide
example : IntWitness 7 2 1 ![-391,-6,-342] := by
  unfold IntWitness; decide
example : IntWitness 7 2 1 ![-345,-345,-345] := by
  unfold IntWitness; decide
example : NatWitness 2 1 3 ![3,2,1] := by
  unfold NatWitness; decide
example : NatWitness 2 0 1 ![2,1,1] := by
  unfold NatWitness; decide

-- The fixed same-level tuple gives three distinct digits for every unit.
theorem fixed_same_level_distinct (lam : ℕ) (hu : ¬ 7 ∣ lam) :
    primeAdicDigit 7 2 lam ≠ primeAdicDigit 7 2 (lam*50) ∧
    primeAdicDigit 7 2 lam ≠ primeAdicDigit 7 2 (lam*99) ∧
    primeAdicDigit 7 2 (lam*50) ≠ primeAdicDigit 7 2 (lam*99) := by
  have hu' : lam % 7 ≠ 0 := fun h => hu (Nat.dvd_iff_mod_eq_zero.mpr h)
  have h50 : lam*50/49 = lam/49 + lam := by omega
  have h99 : lam*99/49 = lam/49 + 2*lam := by omega
  change lam/49%7 ≠ lam*50/49%7 ∧ lam/49%7 ≠ lam*99/49%7 ∧
    lam*50/49%7 ≠ lam*99/49%7
  rw [h50, h99]
  omega

theorem fixed_same_level_no_pair (lam : ℕ) (hu : ¬ 7 ∣ lam) (u v : ℕ) :
    ¬ ((primeAdicDigit 7 2 lam = u ∨ primeAdicDigit 7 2 lam = v) ∧
      (primeAdicDigit 7 2 (lam*50) = u ∨ primeAdicDigit 7 2 (lam*50) = v) ∧
      (primeAdicDigit 7 2 (lam*99) = u ∨ primeAdicDigit 7 2 (lam*99) = v)) := by
  have h := fixed_same_level_distinct lam hu
  omega

end PrimeAdicSourceReview

#print axioms LonelyRunner.primeAdicCorrection_pos
#print axioms LonelyRunner.primeAdicCorrection_mod_prime
#print axioms LonelyRunner.primeAdic_residue_decomposition
#print axioms LonelyRunner.primeAdicCorrection_selected_product
#print axioms LonelyRunner.primeAdicCorrection_selected_digit
#print axioms LonelyRunner.primeAdicCorrection_higher_residue
#print axioms LonelyRunner.primeAdicDigit_of_mod_eq
#print axioms LonelyRunner.primeAdic_unit_representative
#print axioms LonelyRunner.primeAdic_positive_bounded_residue_decomposition
#print axioms LonelyRunner.primeAdicCorrection_exists_target
#print axioms LonelyRunner.primeAdic_top_exists_target
#print axioms LonelyRunner.primeAdicCorrection_not_dvd
#print axioms LonelyRunner.primeAdic_one_target_unbounded
#print axioms LonelyRunner.primeAdic_two_distinct_targets
#print axioms LonelyRunner.primeAdicDifference_add_anchor
#print axioms LonelyRunner.primeAdicDigit_add_last
#print axioms LonelyRunner.primeAdic_zero_or_last_target
#print axioms LonelyRunner.primeAdic_triple_compression
#print axioms LonelyRunner.signedPrimeAdicDigit_mul
#print axioms LonelyRunner.primeAdic_triple_compression_int
#print axioms LonelyRunner.fiveAdic_four_label_multiplier
#print axioms LonelyRunner.fourMovingNaturalMultiplier
#print axioms LonelyRunner.fourMovingNaturalRunners
#print axioms LonelyRunner.lowerCountPositiveIntegerHypothesis_six
#print axioms LonelyRunner.fourRunners
#print axioms LonelyRunner.fiveRunners
#print axioms PrimeAdicSourceReview.fixed_same_level_distinct
#print axioms PrimeAdicSourceReview.fixed_same_level_no_pair
```

Exact bash replay from the repository root, using the pinned shared cache.
It writes no probe source or build artifact and verifies guards before and
after execution. Hashes use the exact UTF-8 fence content including its final
newline. The twenty new axiom reports are supplemented by six compatibility
reports and two fixed-obstruction reports.

```bash
python3 - <<'PY'
from pathlib import Path
from hashlib import sha256
import json, os, resource, subprocess, time
report = Path('research/astra-prime-adic-final-source-review.md').read_text()
probe = report.split('```lean\n', 1)[1].split('```', 1)[0]
guards = {
 'research/astra-prime-difference-compression-plan.md': 'ee396d22cae90460868ee13ba70c26204cafad190aea3b72835680218b3c88c2',
 'research/astra-prime-difference-compression-review.md': 'a3a77cdfbc4f983755d38bd75a7aad6ccdeb4534d5c1ec455dfce0320c1d4947',
 'LonelyRunner/PrimeAdicArithmetic.lean': '78387d8bb606398f240d435df8e5874259f9fb782f0ebc21830905efdc57edf6',
 'LonelyRunner/PrimeAdicCompression.lean': 'bd9f20169c49ac00acf6d27a53109d0d8770f2b224bf29f65d8ff76db8102eda',
 'LonelyRunner.lean': 'c4cdec234819184d3df0d376e1bf2111dd3ccadbd930a31fb073aa0b98e717d3',
 'LonelyRunner/AxiomAudit.lean': '9f449224e85ed16ac3e3131c43d27ad78eddb05b8d1ce56e6958b6731c460e03',
 'LonelyRunner/FiveAdicCarry.lean': 'f91d747198374da76ff9e62435db20a8917856d5b9dc52229ce576353cc11d81',
 'LonelyRunner/FiveAdicFiltering.lean': '1a210e70383e9b00d1a3aec321e9e1a838efcd26c24ca180101964e8c6e71429',
 'LonelyRunner/FiveAdicDecomposition.lean': '049da0b10b478fe2cdb0a6239ebc97a60317022f15263c317d5aa56415a7357e',
 'LonelyRunner/FiveAdicHardPattern.lean': 'b6caced5772fb4b33a7bb6d26792aaa49f5287557f3165c862edeaf7d69daeca',
 'LonelyRunner/FourRunnerCanonical.lean': '353b116d04d464fb9aedb92437e7f56168992e087a862f934044bc9062761c38',
 'LonelyRunner/FiveRunnerCanonical.lean': 'a78cdaafcc359110535422d1967676610587a69be8f2bf8810e0ba65be1c8946',
 'LonelyRunner/FiveRunnerOrdinary.lean': '662d0116f13971bce85e76c503e2f3be4fdc6291ba8113aeda43957e38354ffe',
 'lean-toolchain': '8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af',
 'lake-manifest.json': '887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218',
}
def guard():
    for path, expected in guards.items():
        assert sha256(Path(path).read_bytes()).hexdigest() == expected, path
guard()
env = dict(os.environ)
env['PATH'] = str(Path.home()/'.elan/bin') + os.pathsep + env['PATH']
cmd = ['lake', 'env', 'lean', '--stdin']
start = time.monotonic()
r = subprocess.run(cmd, input=probe.encode(), capture_output=True,
                   env=env, timeout=120)
elapsed = time.monotonic()-start
guard()
usage = resource.getrusage(resource.RUSAGE_CHILDREN)
print(json.dumps({'argv': cmd, 'guard_count': len(guards), 'guards': 'PASS',
 'probe_sha256': sha256(probe.encode()).hexdigest(), 'probe_bytes': len(probe.encode()),
 'exit': r.returncode, 'wall_seconds': round(elapsed, 6),
 'child_user_seconds': usage.ru_utime, 'child_system_seconds': usage.ru_stime,
 'child_max_rss_kib': usage.ru_maxrss,
 'stdout_sha256': sha256(r.stdout).hexdigest(),
 'stderr_sha256': sha256(r.stderr).hexdigest(),
 'stdout_bytes': len(r.stdout), 'stderr_bytes': len(r.stderr)}, sort_keys=True))
print('STDOUT-BEGIN')
print(r.stdout.decode(), end='')
print('STDOUT-END\nSTDERR-BEGIN')
print(r.stderr.decode(), end='')
print('STDERR-END')
raise SystemExit(r.returncode)
PY
```

## Execution receipt

The final probe **passed, exit 0**, with all fifteen frozen guards matching
before and after. Both sessions that actually reached Lean completed in under
four seconds. The accepted final probe is 9,629 UTF-8 bytes, SHA-256
`f100dcd2813c83d9e33732a7f9c7815c030358f5471428cb2e5f42f4ec9b947a`.
The bash replay is 3,062 bytes, SHA-256
`397d5ce02bcc5199d848827a13da0cef8cba4fb89a2365f427eb94129601c58a`.
Tool calls captured the actual exit codes, not just log contents.

The final execution's exact stdout and stderr are enclosed by the markers
below. The JSON line is the replay wrapper's actual metadata; its stdout
hash covers only Lean stdout, excluding metadata and markers. Maximum RSS
is the operating system's child-process measurement for the large imported
Lean environment, in KiB; it is not retained output size.

~~~text
{"argv": ["lake", "env", "lean", "--stdin"], "child_max_rss_kib": 3716244, "child_system_seconds": 0.642601, "child_user_seconds": 1.9169, "exit": 0, "guard_count": 15, "guards": "PASS", "probe_bytes": 9629, "probe_sha256": "f100dcd2813c83d9e33732a7f9c7815c030358f5471428cb2e5f42f4ec9b947a", "stderr_bytes": 0, "stderr_sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "stdout_bytes": 2750, "stdout_sha256": "5df227e79508b513cd76296cea3180a5f9d99153f06c3435ea6fa285fe969642", "wall_seconds": 2.249394}
STDOUT-BEGIN
'LonelyRunner.primeAdicCorrection_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.primeAdicCorrection_mod_prime' depends on axioms: [propext, Quot.sound]
'LonelyRunner.primeAdic_residue_decomposition' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.primeAdicCorrection_selected_product' depends on axioms: [propext]
'LonelyRunner.primeAdicCorrection_selected_digit' depends on axioms: [propext]
'LonelyRunner.primeAdicCorrection_higher_residue' depends on axioms: [propext, Quot.sound]
'LonelyRunner.primeAdicDigit_of_mod_eq' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.primeAdic_unit_representative' depends on axioms: [propext]
'LonelyRunner.primeAdic_positive_bounded_residue_decomposition' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'LonelyRunner.primeAdicCorrection_exists_target' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.primeAdic_top_exists_target' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.primeAdicCorrection_not_dvd' depends on axioms: [propext, Quot.sound]
'LonelyRunner.primeAdic_one_target_unbounded' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.primeAdic_two_distinct_targets' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.primeAdicDifference_add_anchor' depends on axioms: [propext, Quot.sound]
'LonelyRunner.primeAdicDigit_add_last' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.primeAdic_zero_or_last_target' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.primeAdic_triple_compression' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.signedPrimeAdicDigit_mul' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.primeAdic_triple_compression_int' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.fiveAdic_four_label_multiplier' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.fourMovingNaturalMultiplier' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.fourMovingNaturalRunners' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.lowerCountPositiveIntegerHypothesis_six' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.fourRunners' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.fiveRunners' depends on axioms: [propext, Classical.choice, Quot.sound]
'PrimeAdicSourceReview.fixed_same_level_distinct' depends on axioms: [propext, Classical.choice, Quot.sound]
'PrimeAdicSourceReview.fixed_same_level_no_pair' depends on axioms: [propext, Classical.choice, Quot.sound]
STDOUT-END
STDERR-BEGIN
STDERR-END
~~~

The 28 printed theorem dependency reports contain only `propext`,
`Classical.choice` and `Quot.sound`. The same-level obstruction is now a
kernel-checked symbolic fact for every unit multiplier of the fixed
`(1,50,99)` tuple, not just the earlier lambda=1 illustration. It rules out
any containing pair, so dropping the distinct-level/collapse condition from
C would be false. It makes no claim against LRC.

Two earlier attempts failed and are retained for provenance. The first
outer extraction wrapper split at a triple-backtick string *inside* the
bash code and therefore sent truncated Python to bash. Lean was never
invoked. It returned actual exit 1 with this output:

~~~text
bash: line 6: warning: here-document at line 1 delimited by end-of-file (wanted `PY')
  File "<stdin>", line 5
    probe = report.split('
                         ^
SyntaxError: unterminated string literal (detected at line 5)
~~~

The corrected outer invocation, used for both actual Lean executions, was:

    python3 - <<'PY'
    from pathlib import Path
    import subprocess
    report=Path('research/astra-prime-adic-final-source-review.md').read_text()
    program=report.split('```bash\n',1)[1].split('\n```',1)[0]+'\n'
    r=subprocess.run(['bash'],input=program.encode(),timeout=130)
    raise SystemExit(r.returncode)
    PY

The second attempt (first actual Lean run) checked the exact same statements,
but `norm_num` left the vector's anchor coordinate and some `Int.toNat`
expressions unreduced in the eight triple-witness proofs. No source theorem
failed. The universal probes, target pairs, arithmetic controls, symbolic
obstruction and all axiom reports already passed in that run. Only the eight
closed witness proof bodies were changed to `unfold NatWitness; decide` or
`unfold IntWitness; decide`, as shown in the final probe. Ordinary kernel
`decide` checks the three specified labels of each already fixed witness;
it searches neither speeds nor candidate multipliers. The failed probe can
be recovered exactly by replacing each of the six natural witness bodies
with `norm_num [NatWitness]; intro i; fin_cases i <;> norm_num [primeAdicDigit]`
and each signed body with the following two lines, preserving its original
two-space/four-space indentation:

    norm_num [IntWitness]; intro i; fin_cases i <;>
      norm_num [signedPrimeAdicDigit, Int.natMod, primeAdicDigit]

Its 10,089-byte probe hash and complete actual exit-1 output are:

~~~text
{"argv": ["lake", "env", "lean", "--stdin"], "child_max_rss_kib": 3724744, "child_system_seconds": 0.6511129999999999, "child_user_seconds": 2.748765, "exit": 1, "guard_count": 15, "guards": "PASS", "probe_bytes": 10089, "probe_sha256": "981367850a689f7abf1b5fde1509e02f16e8f167613532c34b1a6ddb14937e6c", "stderr_bytes": 0, "stderr_sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "stdout_bytes": 5490, "stdout_sha256": "a40339d11dffc09b72085a06f3c07dd1e6d687ce31faa15dac6640cb01fb6bc2", "wall_seconds": 3.015356}
STDOUT-BEGIN
<stdin>:123:43: error: unsolved goals
case «0»
⊢ 6 = ![295, 337, 1] 2 / 49 % 7 ∨ 6 = (![295, 337, 1] 2 / 49 + 6) % 7

case «1»
⊢ 6 = ![295, 337, 1] 2 / 49 % 7 ∨ 6 = (![295, 337, 1] 2 / 49 + 6) % 7

case «2»
⊢ 0 = ![295, 337, 1] 2 / 49 % 7 ∨ 0 = (![295, 337, 1] 2 / 49 + 6) % 7
<stdin>:125:42: error: unsolved goals
case «0»
⊢ 0 = 43 * ![344, 8, 1] 2 / 49 % 7 ∨ 0 = (43 * ![344, 8, 1] 2 / 49 + 6) % 7

case «1»
⊢ 0 = 43 * ![344, 8, 1] 2 / 49 % 7 ∨ 0 = (43 * ![344, 8, 1] 2 / 49 + 6) % 7

case «2»
⊢ 0 = 43 * ![344, 8, 1] 2 / 49 % 7 ∨ 0 = (43 * ![344, 8, 1] 2 / 49 + 6) % 7
<stdin>:127:44: error: unsolved goals
case «0»
⊢ 0 = ![344, 2402, 1] 2 / 49 % 7 ∨ 0 = (![344, 2402, 1] 2 / 49 + 6) % 7

case «1»
⊢ 0 = ![344, 2402, 1] 2 / 49 % 7 ∨ 0 = (![344, 2402, 1] 2 / 49 + 6) % 7

case «2»
⊢ 0 = ![344, 2402, 1] 2 / 49 % 7 ∨ 0 = (![344, 2402, 1] 2 / 49 + 6) % 7
<stdin>:129:39: error: unsolved goals
case «0»
⊢ 3 = 5 * ![2, 5, 5] 2 % 7 ∨ 3 = (5 * ![2, 5, 5] 2 + 6) % 7

case «1»
⊢ 4 = 5 * ![2, 5, 5] 2 % 7 ∨ 4 = (5 * ![2, 5, 5] 2 + 6) % 7

case «2»
⊢ 4 = 5 * ![2, 5, 5] 2 % 7 ∨ 4 = (5 * ![2, 5, 5] 2 + 6) % 7
<stdin>:131:46: error: unsolved goals
case «0»
⊢ Int.toNat 295 / 49 % 7 = (![-391, -6, -342] 2 % 343).toNat / 49 % 7 ∨
    Int.toNat 295 / 49 % 7 = ((![-391, -6, -342] 2 % 343).toNat / 49 + 6) % 7

case «1»
⊢ Int.toNat 337 / 49 % 7 = (![-391, -6, -342] 2 % 343).toNat / 49 % 7 ∨
    Int.toNat 337 / 49 % 7 = ((![-391, -6, -342] 2 % 343).toNat / 49 + 6) % 7

case «2»
⊢ 0 = (![-391, -6, -342] 2 % 343).toNat / 49 % 7 ∨ 0 = ((![-391, -6, -342] 2 % 343).toNat / 49 + 6) % 7
<stdin>:134:48: error: unsolved goals
case «0»
⊢ Int.toNat 341 / 49 % 7 = (![-345, -345, -345] 2 % 343).toNat / 49 % 7 ∨
    Int.toNat 341 / 49 % 7 = ((![-345, -345, -345] 2 % 343).toNat / 49 + 6) % 7

case «1»
⊢ Int.toNat 341 / 49 % 7 = (![-345, -345, -345] 2 % 343).toNat / 49 % 7 ∨
    Int.toNat 341 / 49 % 7 = ((![-345, -345, -345] 2 % 343).toNat / 49 + 6) % 7

case «2»
⊢ Int.toNat 341 / 49 % 7 = (![-345, -345, -345] 2 % 343).toNat / 49 % 7 ∨
    Int.toNat 341 / 49 % 7 = ((![-345, -345, -345] 2 % 343).toNat / 49 + 6) % 7
<stdin>:137:39: error: unsolved goals
case «0»
⊢ 0 = 3 * ![3, 2, 1] 2 / 2 % 2 ∨ 0 = (3 * ![3, 2, 1] 2 / 2 + 1) % 2

case «1»
⊢ 1 = 3 * ![3, 2, 1] 2 / 2 % 2 ∨ 1 = (3 * ![3, 2, 1] 2 / 2 + 1) % 2

case «2»
⊢ 1 = 3 * ![3, 2, 1] 2 / 2 % 2 ∨ 1 = (3 * ![3, 2, 1] 2 / 2 + 1) % 2
<stdin>:139:39: error: unsolved goals
case «0»
⊢ 0 = ![2, 1, 1] 2 % 2 ∨ 0 = (![2, 1, 1] 2 + 1) % 2

case «1»
⊢ 1 = ![2, 1, 1] 2 % 2 ∨ 1 = (![2, 1, 1] 2 + 1) % 2

case «2»
⊢ 1 = ![2, 1, 1] 2 % 2 ∨ 1 = (![2, 1, 1] 2 + 1) % 2
'LonelyRunner.primeAdicCorrection_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.primeAdicCorrection_mod_prime' depends on axioms: [propext, Quot.sound]
'LonelyRunner.primeAdic_residue_decomposition' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.primeAdicCorrection_selected_product' depends on axioms: [propext]
'LonelyRunner.primeAdicCorrection_selected_digit' depends on axioms: [propext]
'LonelyRunner.primeAdicCorrection_higher_residue' depends on axioms: [propext, Quot.sound]
'LonelyRunner.primeAdicDigit_of_mod_eq' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.primeAdic_unit_representative' depends on axioms: [propext]
'LonelyRunner.primeAdic_positive_bounded_residue_decomposition' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'LonelyRunner.primeAdicCorrection_exists_target' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.primeAdic_top_exists_target' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.primeAdicCorrection_not_dvd' depends on axioms: [propext, Quot.sound]
'LonelyRunner.primeAdic_one_target_unbounded' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.primeAdic_two_distinct_targets' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.primeAdicDifference_add_anchor' depends on axioms: [propext, Quot.sound]
'LonelyRunner.primeAdicDigit_add_last' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.primeAdic_zero_or_last_target' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.primeAdic_triple_compression' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.signedPrimeAdicDigit_mul' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.primeAdic_triple_compression_int' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.fiveAdic_four_label_multiplier' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.fourMovingNaturalMultiplier' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.fourMovingNaturalRunners' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.lowerCountPositiveIntegerHypothesis_six' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.fourRunners' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.fiveRunners' depends on axioms: [propext, Classical.choice, Quot.sound]
'PrimeAdicSourceReview.fixed_same_level_distinct' depends on axioms: [propext, Classical.choice, Quot.sound]
'PrimeAdicSourceReview.fixed_same_level_no_pair' depends on axioms: [propext, Classical.choice, Quot.sound]
STDOUT-END
STDERR-BEGIN
STDERR-END
~~~

The originally displayed source-read command used `AxiomAudit.lean` before
correcting the actual path to `LonelyRunner/AxiomAudit.lean`. That harmless
path error was corrected during frozen source inspection and is not a
compiler failure. No repository source was changed by this review.

## Acceptance and remaining scope

The final focused receipt discharges the conditional verification language
in the initial semantic verdict: **the exact frozen implementation is
accepted**. All new public proof types preserve the accepted contracts,
all required boundary controls passed, and the unchanged natural supply and
Fin4/Fin5 canonical interfaces remain compatible with the new modules.

The root separately reported a successful 3,659-job full root build and a
trust audit accepting 552 dependency reports plus three axiom-free reports.
Those are root-owned build/audit results, not executions by this reviewer.
The implementation report's mathematical description agrees with the source;
one truncated multiline axiom receipt was reported to root, who confirmed its
documentation correction without a source change. This focused review neither imports nor assesses the unrelated
concurrent `ConstrainedMaximizer.lean` work.

No new runner count or unrestricted LRC result follows. Current H6 supplies
the positive integer cases d=1 through 4. H7 still needs d=5 at margin 1/6;
H8 additionally needs d=6 at 1/7 and retains the stronger d=5 margin. Neither
triple compression nor a hypothetical six-moving 1/7 result fills the latter
gap. The next useful integration question is how to obtain or replace the
oriented separation premise for the needed input classes while controlling
the remaining labels. Publication, full-root receipt integration and any
subsequent mathematics remain with the orchestrator.
