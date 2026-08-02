import Mathlib.Algebra.BigOperators.Field
import Mathlib.Tactic

/-!
# Fixed-row residual-variation debt algebra

This module isolates the denominator-free polynomial identity behind the
fixed-pivot, fixed-first-anchor debt calculation.  It deliberately does not
assert that concrete modular residual cells reindex with the required
multiplicity count: that arithmetic/combinatorial statement remains a
separate proof obligation.

After clearing the denominator `(m - 1) * (m - 2)`, a point of total
multiplicity `k` outside the first-anchor mask has

* binary-dispersion numerator `k * (k - 1) * (m - k - 1)`, and
* fixed-anchor pair-deficit numerator
  `-(m - 2) * (k - 1) * (m - k - 1)`.

Their sum is the negative of the debt numerator
`(k - 1) * (m - k - 1) * (m - k - 2)`.  The final theorem below also records
the abstract bookkeeping with a finite family of residual cells.  Its
reindexing and pair-deficit assumptions are explicit, so it cannot silently
stand in for the missing concrete modular bridge.
-/

namespace LonelyRunner

open scoped BigOperators

/-- Cleared-denominator binary-dispersion contribution of a point of
multiplicity `k` in a fixed row with `m` masks. -/
def fixedRowBinaryContributionNum (m k : ℤ) : ℤ :=
  k * (k - 1) * (m - k - 1)

/-- Cleared-denominator fixed-anchor pair deficit of a covered point.  The
polynomial extension to `k = 0` gives the positive uncovered-point term. -/
def fixedRowPairDeficitNum (m k : ℤ) : ℤ :=
  -((m - 2) * (k - 1) * (m - k - 1))

/-- Pointwise debt polynomial.  Under the concrete multiplicity bounds it is
positive exactly at the low/intermediate multiplicities, zero at the boundary
multiplicities, and negative at `k = 0`. -/
def fixedRowDebtContributionNum (m k : ℤ) : ℤ :=
  (k - 1) * (m - k - 1) * (m - k - 2)

/-- Denominator-free pointwise debt identity from the fixed-row audit.  No
range assumptions on `m` or `k` are needed for this polynomial identity. -/
theorem fixedRow_pairDeficit_add_binary_eq_neg_debt (m k : ℤ) :
    fixedRowPairDeficitNum m k + fixedRowBinaryContributionNum m k =
      -fixedRowDebtContributionNum m k := by
  simp only [fixedRowPairDeficitNum, fixedRowBinaryContributionNum,
    fixedRowDebtContributionNum]
  ring

/-- The debt polynomial at an uncovered point is the negative of the cleared
denominator.  Consequently its negative contributes one uncovered unit after
normalization. -/
@[simp] theorem fixedRowDebtContributionNum_at_zero (m : ℤ) :
    fixedRowDebtContributionNum m 0 = -((m - 1) * (m - 2)) := by
  simp only [fixedRowDebtContributionNum]
  ring

/-- Multiplicity one carries no debt. -/
@[simp] theorem fixedRowDebtContributionNum_at_one (m : ℤ) :
    fixedRowDebtContributionNum m 1 = 0 := by
  simp [fixedRowDebtContributionNum]

/-- Multiplicity `m - 2` carries no debt. -/
@[simp] theorem fixedRowDebtContributionNum_at_sub_two (m : ℤ) :
    fixedRowDebtContributionNum m (m - 2) = 0 := by
  simp only [fixedRowDebtContributionNum]
  ring

/-- Multiplicity `m - 1` carries no debt. -/
@[simp] theorem fixedRowDebtContributionNum_at_sub_one (m : ℤ) :
    fixedRowDebtContributionNum m (m - 1) = 0 := by
  simp only [fixedRowDebtContributionNum]
  ring

/-- On the actual intermediate-multiplicity range, every factor in the debt
polynomial is nonnegative. -/
theorem fixedRowDebtContributionNum_nonneg
    (m k : ℤ) (hk : 1 ≤ k) (hkm : k ≤ m - 2) :
    0 ≤ fixedRowDebtContributionNum m k := by
  unfold fixedRowDebtContributionNum
  have hfirst : 0 ≤ k - 1 := by omega
  have hsecond : 0 ≤ m - k - 1 := by omega
  have hthird : 0 ≤ m - k - 2 := by omega
  positivity

/-- Finite-sum form of the pointwise debt identity.  This is the reusable
algebra after a concrete residual-cell calculation has supplied the point
multiplicity function. -/
theorem sum_fixedRow_pairDeficit_add_binary_eq_neg_debt
    {α : Type*} [DecidableEq α]
    (points : Finset α) (m : ℤ) (multiplicity : α → ℤ) :
    points.sum (fun x => fixedRowPairDeficitNum m (multiplicity x)) +
        points.sum (fun x => fixedRowBinaryContributionNum m (multiplicity x)) =
      -points.sum (fun x => fixedRowDebtContributionNum m (multiplicity x)) := by
  rw [← Finset.sum_add_distrib]
  calc
    points.sum (fun x =>
        fixedRowPairDeficitNum m (multiplicity x) +
          fixedRowBinaryContributionNum m (multiplicity x)) =
        points.sum (fun x => -fixedRowDebtContributionNum m (multiplicity x)) := by
          apply Finset.sum_congr rfl
          intro x _hx
          exact fixedRow_pairDeficit_add_binary_eq_neg_debt m (multiplicity x)
    _ = -points.sum (fun x => fixedRowDebtContributionNum m (multiplicity x)) := by
      rw [Finset.sum_neg_distrib]

/-- Abstract loss of one residual cell when an exact binary-dispersion
quantity is replaced by a compressed lower bound. -/
def fixedRowCellLoss (exactBinary compressed : ℤ) : ℤ :=
  exactBinary - compressed

/-- A cell loss is nonnegative whenever the compressed quantity is indeed a
lower bound for the exact binary dispersion. -/
theorem fixedRowCellLoss_nonneg
    (exactBinary compressed : ℤ) (h : compressed ≤ exactBinary) :
    0 ≤ fixedRowCellLoss exactBinary compressed := by
  unfold fixedRowCellLoss
  omega

/-- **Abstract fixed-row debt/loss decomposition.**

`hpair` identifies the cleared fixed-anchor pair part with the sum of its
pointwise deficit numerators.  `hreindex` is the separate combinatorial
obligation saying that the sum of exact cellwise binary dispersions reindexes
to the pointwise multiplicity contribution.  With those hypotheses exposed,
replacing exact cell dispersion by `compressed` subtracts exactly the sum of
the cell losses.

In the intended modular application `points` are candidate residues outside
the first-anchor mask and `cells` are retained child/anchor cells.  This
theorem does not assert either description or prove `hreindex`. -/
theorem fixedRow_debt_loss_decomposition
    {α β : Type*} [DecidableEq α] [DecidableEq β]
    (points : Finset α) (cells : Finset β)
    (m : ℤ) (multiplicity : α → ℤ)
    (pairNumerator : ℤ) (exactBinary compressed : β → ℤ)
    (hpair : pairNumerator =
      points.sum (fun x => fixedRowPairDeficitNum m (multiplicity x)))
    (hreindex : cells.sum exactBinary =
      points.sum (fun x => fixedRowBinaryContributionNum m (multiplicity x))) :
    pairNumerator + cells.sum compressed =
      -points.sum (fun x => fixedRowDebtContributionNum m (multiplicity x)) -
        cells.sum (fun cell => fixedRowCellLoss
          (exactBinary cell) (compressed cell)) := by
  rw [hpair]
  have hdebt := sum_fixedRow_pairDeficit_add_binary_eq_neg_debt
    points m multiplicity
  rw [← hreindex] at hdebt
  rw [← hdebt]
  unfold fixedRowCellLoss
  rw [Finset.sum_sub_distrib]
  ring

/-- The cell-loss term in the abstract decomposition is nonnegative when each
compressed cell quantity is bounded by its exact binary dispersion. -/
theorem sum_fixedRowCellLoss_nonneg
    {β : Type*} [DecidableEq β]
    (cells : Finset β) (exactBinary compressed : β → ℤ)
    (hlower : ∀ cell ∈ cells, compressed cell ≤ exactBinary cell) :
    0 ≤ cells.sum (fun cell => fixedRowCellLoss
      (exactBinary cell) (compressed cell)) := by
  apply Finset.sum_nonneg
  intro cell hcell
  exact fixedRowCellLoss_nonneg _ _ (hlower cell hcell)

end LonelyRunner
