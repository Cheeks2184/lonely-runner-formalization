import LonelyRunner.PivotResidues
import LonelyRunner.Formulations
import LonelyRunner.BaseCases

/-!
# Pair-sum certificates for the integer Lonely Runner problem

For a positive integer speed tuple `speeds`, a pair `p ≠ q` supplies the
finite denominator

`D = speeds p + speeds q`.

At a numerator `r < D`, the exact closed Lonely Runner inequalities at time
`r / D` are equivalent to the natural-number inequalities

`D ≤ N * cyclicResidueDistance D (r * speeds i)`.

The definitions below isolate that finite certificate and prove, without any
Fourier estimate, that a universal supply of such certificates implies the
compiled positive-integer conjecture.  Proving the universal certificate
statement is still open; the pair-sum extremal argument explains why this is
a natural finite target.
-/

namespace LonelyRunner

/-- Exact natural-number certificate at a denominator obtained by summing two
tuple speeds.  The bound `r < D` makes the search visibly finite; it is not
needed by the analytic bridge because phases are periodic modulo `D`. -/
def PairSumCertificate {n : ℕ} (N : ℕ) (speeds : Fin n → ℕ) : Prop :=
  ∃ p q : Fin n, p ≠ q ∧
    ∃ r : ℕ, r < speeds p + speeds q ∧
      ∀ i, speeds p + speeds q ≤
        N * cyclicResidueDistance (speeds p + speeds q) (r * speeds i)

/-- The finite pair-sum certificate conjecture in every dimension with at
least two moving runners, with the positivity, injectivity, and threshold
denominator of `PositiveIntegerConjecture`.  The omitted one-moving-runner
case is handled directly by `oneMovingRunner`. -/
def PositiveIntegerPairSumCertificateConjecture : Prop :=
  ∀ (n : ℕ), 2 ≤ n →
    ∀ speeds : Fin n → ℕ,
      Function.Injective speeds → (∀ i, 0 < speeds i) →
        PairSumCertificate (n + 1) speeds

/-- The natural pair-sum certificate is exactly the corresponding finite
family of closed circle inequalities.  This theorem retains the chosen pair
and reduced numerator, unlike the witness-only corollary below. -/
theorem pairSumCertificate_iff_pair_time {n N : ℕ} (speeds : Fin n → ℕ)
    (hN : 0 < N) (hspeeds : ∀ i, 0 < speeds i) :
    PairSumCertificate N speeds ↔
      ∃ p q : Fin n, p ≠ q ∧
        ∃ r : ℕ, r < speeds p + speeds q ∧
          ∀ i, (N : ℝ)⁻¹ ≤
            circleNorm (((r : ℝ) / ((speeds p + speeds q : ℕ) : ℝ)) *
              (speeds i : ℝ)) := by
  constructor
  · rintro ⟨p, q, hpq, r, hr, hgood⟩
    refine ⟨p, q, hpq, r, hr, fun i => ?_⟩
    let D := speeds p + speeds q
    have hD : 0 < D := Nat.add_pos_left (hspeeds p) (speeds q)
    have hND : (D : ℝ) ≤ (N : ℝ) *
        (cyclicResidueDistance D (r * speeds i) : ℝ) := by
      exact_mod_cast hgood i
    have hNreal : (0 : ℝ) < (N : ℝ) := by exact_mod_cast hN
    have hDreal : (0 : ℝ) < (D : ℝ) := by exact_mod_cast hD
    have hphase :
        ((r * speeds i : ℕ) : ℝ) / (D : ℝ) =
          ((r : ℝ) / (D : ℝ)) * (speeds i : ℝ) := by
      push_cast
      ring
    change (N : ℝ)⁻¹ ≤
      circleNorm (((r : ℝ) / (D : ℝ)) * (speeds i : ℝ))
    rw [← hphase, circleNorm_nat_div_eq, inv_eq_one_div]
    exact (div_le_div_iff₀ hNreal hDreal).2 (by
      simpa [mul_comm] using hND)
  · rintro ⟨p, q, hpq, r, hr, hgood⟩
    refine ⟨p, q, hpq, r, hr, fun i => ?_⟩
    let D := speeds p + speeds q
    have hD : 0 < D := Nat.add_pos_left (hspeeds p) (speeds q)
    have hNreal : (0 : ℝ) < (N : ℝ) := by exact_mod_cast hN
    have hDreal : (0 : ℝ) < (D : ℝ) := by exact_mod_cast hD
    have hphase :
        ((r * speeds i : ℕ) : ℝ) / (D : ℝ) =
          ((r : ℝ) / (D : ℝ)) * (speeds i : ℝ) := by
      push_cast
      ring
    have hi := hgood i
    change (N : ℝ)⁻¹ ≤
      circleNorm (((r : ℝ) / (D : ℝ)) * (speeds i : ℝ)) at hi
    rw [← hphase, circleNorm_nat_div_eq, inv_eq_one_div] at hi
    have hND : (D : ℝ) ≤ (N : ℝ) *
        (cyclicResidueDistance D (r * speeds i) : ℝ) := by
      have := (div_le_div_iff₀ hNreal hDreal).1 hi
      simpa [mul_comm] using this
    exact_mod_cast hND

/-- The cyclic-residue inequalities in a pair-sum certificate give the exact
closed circle-distance inequalities at its rational time. -/
theorem pairSumCertificate_circleNorm {n N : ℕ} (speeds : Fin n → ℕ)
    (hN : 0 < N) (hspeeds : ∀ i, 0 < speeds i)
    (hcert : PairSumCertificate N speeds) :
    ∃ time : ℝ, ∀ i,
      (N : ℝ)⁻¹ ≤ circleNorm (time * (speeds i : ℝ)) := by
  obtain ⟨p, q, _hpq, r, _hr, hgood⟩ := hcert
  let D := speeds p + speeds q
  have hD : 0 < D := Nat.add_pos_left (hspeeds p) (speeds q)
  refine ⟨(r : ℝ) / (D : ℝ), fun i => ?_⟩
  have hND : (D : ℝ) ≤ (N : ℝ) *
      (cyclicResidueDistance D (r * speeds i) : ℝ) := by
    exact_mod_cast hgood i
  have hNreal : (0 : ℝ) < (N : ℝ) := by exact_mod_cast hN
  have hDreal : (0 : ℝ) < (D : ℝ) := by exact_mod_cast hD
  have hphase :
      ((r * speeds i : ℕ) : ℝ) / (D : ℝ) =
        ((r : ℝ) / (D : ℝ)) * (speeds i : ℝ) := by
    push_cast
    ring
  rw [← hphase, circleNorm_nat_div_eq]
  rw [inv_eq_one_div]
  exact (div_le_div_iff₀ hNreal hDreal).2 (by
    simpa [mul_comm] using hND)

/-- The proposed finite geometry lemma is genuinely sufficient for the exact
positive-integer formulation; no measure-positivity or absolute Fourier
domination enters the deduction. -/
theorem positiveIntegerPairSumCertificateConjecture_imp_positiveIntegerConjecture :
    PositiveIntegerPairSumCertificateConjecture → PositiveIntegerConjecture := by
  intro h n hn speeds hinjective hspeeds
  by_cases hnOne : n = 1
  · subst n
    have hspeedReal : (speeds 0 : ℝ) ≠ 0 := by
      exact_mod_cast (hspeeds 0).ne'
    obtain ⟨time, htime⟩ := oneMovingRunner (speeds 0 : ℝ) hspeedReal
    refine ⟨time, fun i => ?_⟩
    have hi : i = 0 := Subsingleton.elim _ _
    subst i
    simpa [circleNorm] using htime
  · have hnTwo : 2 ≤ n := by omega
    exact pairSumCertificate_circleNorm speeds (by omega) hspeeds
      (h n hnTwo speeds hinjective hspeeds)

end LonelyRunner
