import LonelyRunner.RationalMarginCertificates
import Mathlib.Tactic

namespace LonelyRunner

structure NatSpeedBox (n : ℕ) where
  lo : Fin n → ℕ
  hi : Fin n → ℕ

def NatSpeedBox.Contains {n : ℕ} (B : NatSpeedBox n) (w : Fin n → ℕ) : Prop :=
  ∀ i, B.lo i ≤ w i ∧ w i ≤ B.hi i

def NatSpeedBox.WellFormed {n : ℕ} (B : NatSpeedBox n) : Prop :=
  ∀ i, B.lo i ≤ B.hi i

/-- The left child changes only the selected upper endpoint. -/
def NatSpeedBox.left {n : ℕ} (B : NatSpeedBox n) (i : Fin n) (cut : ℕ) : NatSpeedBox n :=
  ⟨B.lo, Function.update B.hi i cut⟩

/-- The right child changes only the selected lower endpoint. -/
def NatSpeedBox.right {n : ℕ} (B : NatSpeedBox n) (i : Fin n) (cut : ℕ) : NatSpeedBox n :=
  ⟨Function.update B.lo i (cut + 1), B.hi⟩

/-- A leaf uses one rational time and one integer band for each coordinate. -/
structure RationalMarginBandLeaf (n : ℕ) where
  p : ℕ
  q : ℕ
  band : Fin n → ℕ

inductive RationalMarginBoxTree (n : ℕ) where
  | leaf (data : RationalMarginBandLeaf n)
  | split (i : Fin n) (cut : ℕ) (left right : RationalMarginBoxTree n)

def rationalMarginBandLeafOK {n : ℕ} (B : NatSpeedBox n)
    (num den : Fin n → ℕ) (d : RationalMarginBandLeaf n) : Bool :=
  decide (0 < d.p ∧ 0 < d.q ∧ ∀ i, 0 < den i ∧
    den i * d.band i * d.q + num i * d.q ≤ den i * d.p * B.lo i ∧
    den i * d.p * B.hi i + num i * d.q ≤ den i * (d.band i + 1) * d.q)

def rationalMarginBoxTreeOKCore {n : ℕ} (B : NatSpeedBox n)
    (num den : Fin n → ℕ) : RationalMarginBoxTree n → Bool
  | .leaf d => rationalMarginBandLeafOK B num den d
  | .split i cut left right =>
      decide (B.lo i ≤ cut ∧ cut < B.hi i) &&
        rationalMarginBoxTreeOKCore (B.left i cut) num den left &&
        rationalMarginBoxTreeOKCore (B.right i cut) num den right

def rationalMarginBoxTreeOK {n : ℕ} (B : NatSpeedBox n)
    (num den : Fin n → ℕ) (tree : RationalMarginBoxTree n) : Bool :=
  decide (∀ i, B.lo i ≤ B.hi i) && rationalMarginBoxTreeOKCore B num den tree

/-- A checked leaf supplies the rational-margin row check for every contained
row.  This deliberately remains valid on an empty raw box. -/
theorem rationalMarginBandLeafOK_row {n : ℕ}
    (B : NatSpeedBox n) (num den : Fin n → ℕ) (d : RationalMarginBandLeaf n)
    (hd : rationalMarginBandLeafOK B num den d = true)
    (w : Fin n → ℕ) (hw : B.Contains w) :
    rationalMarginRowOK w num den d.p d.q = true := by
  have hd' : 0 < d.p ∧ 0 < d.q ∧ ∀ i, 0 < den i ∧
      den i * d.band i * d.q + num i * d.q ≤ den i * d.p * B.lo i ∧
      den i * d.p * B.hi i + num i * d.q ≤ den i * (d.band i + 1) * d.q := by
    simpa [rationalMarginBandLeafOK] using hd
  apply (rationalMarginRowOK_circleNorm_iff w num den d.p d.q).mpr
  refine ⟨hd'.2.1, fun i => ⟨(hd'.2.2 i).1, ?_⟩⟩
  let A := num i
  let D := den i
  let p := d.p
  let q := d.q
  let k := d.band i
  have hD : 0 < D := by simpa [D] using (hd'.2.2 i).1
  have hq : 0 < q := by simpa [q] using hd'.2.1
  have hlow : D * k * q + A * q ≤ D * p * w i := by
    have h0 := (hd'.2.2 i).2.1
    have hmono : D * p * B.lo i ≤ D * p * w i := by
      exact Nat.mul_le_mul_left (D * p) (hw i).1
    simpa [A, D, p, q, k] using h0.trans hmono
  have hupp : D * p * w i + A * q ≤ D * (k + 1) * q := by
    have h1 := (hd'.2.2 i).2.2
    have hmono : D * p * w i ≤ D * p * B.hi i := by
      exact Nat.mul_le_mul_left (D * p) (hw i).2
    have hmono' : D * p * w i + A * q ≤ D * p * B.hi i + A * q :=
      Nat.add_le_add_right hmono (A * q)
    simpa [A, D, p, q, k] using hmono'.trans h1
  have hDR : 0 < (D : ℝ) := by exact_mod_cast hD
  have hqR : 0 < (q : ℝ) := by exact_mod_cast hq
  have hlowR : (D : ℝ) * (k : ℝ) * (q : ℝ) + (A : ℝ) * (q : ℝ) ≤
      (D : ℝ) * (p : ℝ) * (w i : ℝ) := by exact_mod_cast hlow
  have huppR : (D : ℝ) * (p : ℝ) * (w i : ℝ) + (A : ℝ) * (q : ℝ) ≤
      (D : ℝ) * ((k + 1 : ℕ) : ℝ) * (q : ℝ) := by exact_mod_cast hupp
  have hkR : ((k + 1 : ℕ) : ℝ) = (k : ℝ) + 1 := by norm_num
  rw [hkR] at huppR
  have hleft : (k : ℝ) + (A : ℝ) / (D : ℝ) ≤
      ((p : ℝ) / (q : ℝ)) * (w i : ℝ) := by
    field_simp
    nlinarith
  have hright : ((p : ℝ) / (q : ℝ)) * (w i : ℝ) ≤
      (k : ℝ) + 1 - (A : ℝ) / (D : ℝ) := by
    field_simp
    nlinarith
  have hhalf : (A : ℝ) / (D : ℝ) ≤ (1 : ℝ) / 2 := by
    nlinarith [hleft, hright]
  apply circleNorm_ge_of_int_band (k : ℤ)
    (((p : ℝ) / (q : ℝ)) * (w i : ℝ)) ((A : ℝ) / (D : ℝ))
    (by positivity) hhalf
  · simpa [A, D, p, q, k] using hleft
  · simpa [A, D, p, q, k] using hright

theorem rationalMarginBandLeafOK_common_positive_time {n : ℕ}
    (B : NatSpeedBox n) (num den : Fin n → ℕ) (d : RationalMarginBandLeaf n)
    (hd : rationalMarginBandLeafOK B num den d = true) :
    0 < (d.p : ℝ) / (d.q : ℝ) ∧ ∀ w, B.Contains w → ∀ i,
      (num i : ℝ) / (den i : ℝ) ≤
        circleNorm (((d.p : ℝ) / (d.q : ℝ)) * (w i : ℝ)) := by
  have hd' : 0 < d.p ∧ 0 < d.q ∧ ∀ i, 0 < den i ∧
      den i * d.band i * d.q + num i * d.q ≤ den i * d.p * B.lo i ∧
      den i * d.p * B.hi i + num i * d.q ≤ den i * (d.band i + 1) * d.q := by
    simpa [rationalMarginBandLeafOK] using hd
  refine ⟨div_pos (by exact_mod_cast hd'.1) (by exact_mod_cast hd'.2.1), ?_⟩
  intro w hw i
  exact rationalMarginRowOK_sound w num den d.p d.q
    (rationalMarginBandLeafOK_row B num den d hd w hw) i

theorem rationalMarginBox_split_cover {n : ℕ} (B : NatSpeedBox n)
    (i : Fin n) (cut : ℕ) (hsplit : B.lo i ≤ cut ∧ cut < B.hi i)
    (w : Fin n → ℕ) (hw : B.Contains w) :
    (B.left i cut).Contains w ∨ (B.right i cut).Contains w := by
  by_cases hle : w i ≤ cut
  · left
    intro j
    by_cases hji : j = i
    · subst j
      simpa [NatSpeedBox.left, Function.update] using ⟨(hw i).1, hle⟩
    · simpa [NatSpeedBox.left, Function.update, hji] using hw j
  · right
    have hcut : cut + 1 ≤ w i := by omega
    intro j
    by_cases hji : j = i
    · subst j
      simpa [NatSpeedBox.right, Function.update] using ⟨hcut, (hw i).2⟩
    · simpa [NatSpeedBox.right, Function.update, hji] using hw j

/-- A passing tree core gives a checked rational row for each contained row;
the rational time may depend on the branch containing that row. -/
theorem rationalMarginBoxTreeOKCore_row {n : ℕ}
    (tree : RationalMarginBoxTree n) (B : NatSpeedBox n)
    (num den : Fin n → ℕ) (h : rationalMarginBoxTreeOKCore B num den tree = true)
    (w : Fin n → ℕ) (hw : B.Contains w) :
    ∃ p q : ℕ, 0 < p ∧ rationalMarginRowOK w num den p q = true := by
  induction tree generalizing B w with
  | leaf d =>
      refine ⟨d.p, d.q, ?_, rationalMarginBandLeafOK_row B num den d h w hw⟩
      have hd : 0 < d.p ∧ 0 < d.q ∧ ∀ i, 0 < den i ∧
          den i * d.band i * d.q + num i * d.q ≤ den i * d.p * B.lo i ∧
          den i * d.p * B.hi i + num i * d.q ≤ den i * (d.band i + 1) * d.q := by
        simpa [rationalMarginBoxTreeOKCore, rationalMarginBandLeafOK] using h
      exact hd.1
  | split i cut left right ihLeft ihRight =>
      have hparts : (decide (B.lo i ≤ cut ∧ cut < B.hi i) = true ∧
          rationalMarginBoxTreeOKCore (B.left i cut) num den left = true) ∧
          rationalMarginBoxTreeOKCore (B.right i cut) num den right = true := by
        simpa [rationalMarginBoxTreeOKCore, Bool.and_eq_true] using h
      have hsplit : B.lo i ≤ cut ∧ cut < B.hi i :=
        of_decide_eq_true hparts.1.1
      rcases rationalMarginBox_split_cover B i cut hsplit w hw with hleft | hright
      · exact ihLeft (B.left i cut) hparts.1.2 w hleft
      · exact ihRight (B.right i cut) hparts.2 w hright

/-- The public well-formed guard and passing core give a rational row for
every row in the root box. -/
theorem rationalMarginBoxTreeOK_row {n : ℕ}
    (B : NatSpeedBox n) (num den : Fin n → ℕ) (tree : RationalMarginBoxTree n)
    (h : rationalMarginBoxTreeOK B num den tree = true)
    (w : Fin n → ℕ) (hw : B.Contains w) :
    ∃ p q : ℕ, 0 < p ∧ rationalMarginRowOK w num den p q = true := by
  have hparts : decide (∀ i, B.lo i ≤ B.hi i) = true ∧
      rationalMarginBoxTreeOKCore B num den tree = true := by
    simpa [rationalMarginBoxTreeOK, Bool.and_eq_true] using h
  exact rationalMarginBoxTreeOKCore_row tree B num den hparts.2 w hw

/-- Each root row covered by a passing tree has a positive time meeting all
of its original closed rational margins. -/
theorem rationalMarginBoxTreeOK_exists_positive_time {n : ℕ}
    (B : NatSpeedBox n) (num den : Fin n → ℕ) (tree : RationalMarginBoxTree n)
    (h : rationalMarginBoxTreeOK B num den tree = true)
    (w : Fin n → ℕ) (hw : B.Contains w) :
    ∃ t : ℝ, 0 < t ∧ ∀ i, (num i : ℝ) / (den i : ℝ) ≤
      circleNorm (t * (w i : ℝ)) := by
  rcases rationalMarginBoxTreeOK_row B num den tree h w hw with ⟨p, q, hp, hrow⟩
  exact rationalMarginRowOK_exists_positive_time w num den p q hp hrow

end LonelyRunner
