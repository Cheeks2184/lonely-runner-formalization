import Mathlib.Data.Nat.Find
import Mathlib.NumberTheory.Primorial
import LonelyRunner.LogarithmicHeight

open Finset

namespace LonelyRunner

/-!
# Exact rational-coefficient bounded-height interface

This module formalizes the complete exact primorial-ratio height argument.
It first retains a reusable rational-coefficient interface with an explicit
ratio premise, then proves the uniform extremal inequality
`c * Q_N ≤ φ(c) * P_N` by a finite prime-exchange induction and discharges
that premise in the final unconditional wrappers.
-/

/-- Exact elimination in the short-interval branch. -/
theorem rational_short_interval_bound
    {N t c ell phi P Q : Nat}
    (hQP : Q ≤ P)
    (h2c : 2 * c ≤ N + t)
    (hell : ell = N - c - t)
    (hct : c + t < N)
    (hellc : ell < c)
    (hratio : c * Q ≤ phi * P)
    (hphi : phi ≤ c - ell) :
    N * Q ≤ (4 * P - Q) * t := by
  have hguard2 : Q ≤ 2 * P := by omega
  have hguard4 : Q ≤ 4 * P := by omega
  let d := c - ell
  let R := 4 * P - Q
  have hd : d + N = 2 * c + t := by
    dsimp [d]
    rw [hell]
    omega
  have hdP : (d + N) * P = (2 * c + t) * P :=
    congrArg (fun x : Nat => x * P) hd
  have hcQdP : c * Q ≤ d * P := by
    exact hratio.trans (Nat.mul_le_mul_right P hphi)
  have hA : N * P + c * Q ≤ 2 * c * P + t * P := by
    nlinarith [hdP]
  have hB : 2 * c * (2 * P - Q) ≤ (N + t) * (2 * P - Q) := by
    exact Nat.mul_le_mul_right (2 * P - Q) h2c
  have hRQ : R + Q = 4 * P := by
    dsimp [R]
    exact Nat.sub_add_cancel hguard4
  have hRQt : (R + Q) * t = (4 * P) * t :=
    congrArg (fun x : Nat => x * t) hRQ
  nlinarith [hA, hB, hRQt]

/-- Exact rational-coefficient bounded-height theorem.  Equality in the
growth condition is intentionally not accepted. -/
theorem rationalCoefficientHeight_family_witness
    {n N t P Q : Nat} (speeds : Fin n → Nat)
    (hnN : n + 1 = N) (ht : 0 < t)
    (hpos : ∀ i, 0 < speeds i) (hinj : Function.Injective speeds)
    (hbound : ∀ i, speeds i ≤ N + t)
    (hQP : Q ≤ P)
    (hratio : ∀ c, 0 < c → c ≤ N → c * Q ≤ c.totient * P)
    (hgrowth : (4 * P - Q) * t < N * Q) :
    ∃ tau : Real, ∀ i,
      (N : Real)⁻¹ ≤ circleNorm (tau * (speeds i : Real)) := by
  classical
  have hN : 0 < N := by omega
  let S : Finset Nat := Finset.univ.image speeds
  let U : Finset Nat := Finset.Icc 1 N
  have hcardS : S.card = n := by
    dsimp [S]
    rw [Finset.card_image_iff.mpr]
    · simp
    · intro i _ j _ hij
      exact hinj hij
  have hcardU : U.card = N := by
    dsimp [U]
    rw [Nat.card_Icc]
    omega
  have hnotSubset : ¬ U ⊆ S := by
    intro hsub
    have hcard := Finset.card_le_card hsub
    rw [hcardU, hcardS] at hcard
    omega
  obtain ⟨c, hcU, hcNotS⟩ := Finset.not_subset.mp hnotSubset
  have hcBounds : 0 < c ∧ c ≤ N := by
    have : c ∈ Finset.Icc 1 N := by simpa [U] using hcU
    have := Finset.mem_Icc.mp this
    omega
  have hmissc : ∀ i, speeds i ≠ c := by
    intro i heq
    apply hcNotS
    exact Finset.mem_image.mpr ⟨i, Finset.mem_univ i, heq⟩
  by_cases hrecip : N + t < 2 * c
  · apply smallDenominator_family_witness speeds hN hcBounds.1 hcBounds.2
    intro i hdiv
    rcases hdiv with ⟨k, hk⟩
    have hkpos : 0 < k := by
      by_contra hkzero
      have : k = 0 := by omega
      subst k
      simp at hk
      exact (Nat.ne_of_gt (hpos i)) hk
    have hkle : k = 1 := by
      by_contra hkone
      have hk2 : 2 ≤ k := by omega
      have hmul := Nat.mul_le_mul_left c hk2
      have hb := hbound i
      omega
    subst k
    apply hmissc i
    simpa using hk
  · have h2c : 2 * c ≤ N + t := by omega
    have hQpos : 0 < Q := by
      by_contra hQ
      have : Q = 0 := by omega
      subst Q
      simp at hgrowth
    have hcoef : 3 * Q ≤ 4 * P - Q := by omega
    have hscaled : (3 * Q) * t ≤ (4 * P - Q) * t :=
      Nat.mul_le_mul_right t hcoef
    have h3tNQ : (3 * t) * Q < N * Q := by
      nlinarith [hscaled]
    have h3tN : 3 * t < N := (Nat.mul_lt_mul_right hQpos).mp h3tNQ
    have hctlt : c + t < N := by omega
    let start := N + c + t + 1
    let ell := N - c - t
    have hellpos : 0 < ell := by
      dsimp [ell]
      omega
    have hsum : start + ell = 2 * N + 1 := by
      dsimp [start, ell]
      omega
    have hselector : ∃ q, q ∈ Finset.Ico start (start + ell) ∧ c.Coprime q := by
      by_cases hlong : c ≤ ell
      · obtain ⟨q, hq, hcop⟩ :=
          exists_coprime_in_Ico_full_period (start := start) hcBounds.1
        refine ⟨q, ?_, hcop⟩
        have hqm := Finset.mem_Ico.mp hq
        exact Finset.mem_Ico.mpr ⟨hqm.1, by omega⟩
      · have hellc : ell < c := by omega
        have hphi : c - ell < c.totient := by
          by_contra hnot
          have htotle : c.totient ≤ c - ell := by omega
          have hratioC : c * Q ≤ c.totient * P :=
            hratio c hcBounds.1 hcBounds.2
          have hcontra : N * Q ≤ (4 * P - Q) * t :=
            rational_short_interval_bound hQP h2c rfl hctlt hellc hratioC htotle
          omega
        exact exists_coprime_in_Ico_of_complement_lt_totient hellc hphi
    obtain ⟨q, hq, hcop⟩ := hselector
    have hqmem := Finset.mem_Ico.mp hq
    apply twoHole_witness_of_coprime_modulus_above_height
      speeds hN hcBounds.1 hpos hbound hmissc
    refine ⟨q, ?_, ?_, ?_, hcop⟩
    · dsimp [start] at hqmem
      omega
    · rw [hsum] at hqmem
      omega
    · dsimp [start] at hqmem
      omega

/-- Largest natural gain satisfying the strict coefficient inequality. -/
def rationalCoefficientHeightGain (N P Q : Nat) : Nat :=
  (N * Q - 1) / (4 * P - Q)

theorem rationalCoefficientHeightGain_spec
    {N P Q : Nat} (hNQ : 0 < N * Q) :
    (4 * P - Q) * rationalCoefficientHeightGain N P Q < N * Q := by
  have hle := Nat.div_mul_le_self (N * Q - 1) (4 * P - Q)
  dsimp [rationalCoefficientHeightGain]
  rw [Nat.mul_comm]
  omega

theorem rationalCoefficientHeightGain_maximal
    {N P Q t : Nat} (hD : 0 < 4 * P - Q)
    (ht : (4 * P - Q) * t < N * Q) :
    t ≤ rationalCoefficientHeightGain N P Q := by
  apply (Nat.le_div_iff_mul_le hD).2
  rw [Nat.mul_comm]
  omega

theorem rationalCoefficientHeightGain_family_witness
    {n N P Q : Nat} (speeds : Fin n → Nat)
    (hnN : n + 1 = N)
    (hgain : 0 < rationalCoefficientHeightGain N P Q)
    (hpos : ∀ i, 0 < speeds i) (hinj : Function.Injective speeds)
    (hbound : ∀ i, speeds i ≤ N + rationalCoefficientHeightGain N P Q)
    (hQP : Q ≤ P)
    (hratio : ∀ c, 0 < c → c ≤ N → c * Q ≤ c.totient * P)
    (hNQ : 0 < N * Q) :
    ∃ tau : Real, ∀ i,
      (N : Real)⁻¹ ≤ circleNorm (tau * (speeds i : Real)) := by
  exact rationalCoefficientHeight_family_witness speeds hnN hgain hpos hinj hbound hQP
    hratio (rationalCoefficientHeightGain_spec hNQ)

/-- The totient of a primorial is exactly the product of `p-1` over its
prime factors. -/
theorem totient_primorial_eq_prod_primesLE_pred (m : Nat) :
    (primorial m).totient = ∏ p ∈ Nat.primesLE m, (p - 1) := by
  rw [Nat.totient_eq_div_primeFactors_mul, primeFactors_primorial,
    ← primorial_eq_prod_primesLE]
  rw [Nat.div_self (primorial_pos m), one_mul]

/-- Largest cutoff at most `N` whose primorial is at most `N`. -/
def primorialCutoff (N : Nat) : Nat :=
  Nat.findGreatest (fun m => primorial m ≤ N) N

/-- The largest primorial value at most positive `N`. -/
def boundedPrimorial (N : Nat) : Nat := primorial (primorialCutoff N)

/-- Product of `p-1` for the primes in `boundedPrimorial N`. -/
def boundedPrimorialPredProduct (N : Nat) : Nat :=
  (boundedPrimorial N).totient

theorem boundedPrimorial_pos (N : Nat) : 0 < boundedPrimorial N :=
  primorial_pos _

theorem boundedPrimorialPredProduct_pos (N : Nat) :
    0 < boundedPrimorialPredProduct N :=
  Nat.totient_pos.mpr (boundedPrimorial_pos N)

theorem boundedPrimorial_le (N : Nat) (hN : 0 < N) :
    boundedPrimorial N ≤ N := by
  have hzero : primorial 0 ≤ N := by
    rw [primorial_zero]
    omega
  exact Nat.findGreatest_spec (P := fun m => primorial m ≤ N)
    (m := 0) (Nat.zero_le N) hzero

/-- `boundedPrimorial N` dominates every other primorial not exceeding `N`. -/
theorem primorial_le_boundedPrimorial {m N : Nat} (hm : primorial m ≤ N) :
    primorial m ≤ boundedPrimorial N := by
  have hmN : m ≤ N := (le_primorial_self (n := m)).trans hm
  have hmcut : m ≤ primorialCutoff N := Nat.le_findGreatest hmN hm
  exact primorial_mono hmcut

/-! ## The exact primorial-ratio maximizer

The exchange proof below avoids indexed primes.  If a finite prime set is not
an initial segment, replace its largest prime by a missing smaller prime.  The
radical strictly decreases while its ratio to the product of predecessor
factors weakly increases. -/

private def primeSet (s : Finset Nat) : Prop := ∀ p ∈ s, p.Prime

private def predProd (s : Finset Nat) : Nat := ∏ p ∈ s, (p - 1)

private theorem primeSet_prod_pos {s : Finset Nat} (hs : primeSet s) :
    0 < ∏ p ∈ s, p := by
  apply Finset.prod_pos
  intro p hp
  exact (hs p hp).pos

private theorem primeSet_predProd_pos {s : Finset Nat} (hs : primeSet s) :
    0 < predProd s := by
  apply Finset.prod_pos
  intro p hp
  exact Nat.sub_pos_of_lt (hs p hp).one_lt

private theorem primeSet_subset_primesLE_max'
    {s : Finset Nat} (hs : primeSet s) (hne : s.Nonempty) :
    s ⊆ Nat.primesLE (s.max' hne) := by
  intro p hp
  exact Nat.mem_primesLE.mpr ⟨Finset.le_max' s p hp, hs p hp⟩

/-- Replacing a prime `p` by a missing smaller prime `q` can only increase
the radical-to-predecessor-product ratio. -/
private theorem exchange_ratio
    {s : Finset Nat} (hs : primeSet s) {p q : Nat}
    (hp : p ∈ s) (hq : q.Prime) (hqs : q ∉ s) (hqp : q < p) :
    let s' := insert q (s.erase p)
    (∏ x ∈ s, x) * predProd s' ≤ predProd s * (∏ x ∈ s', x) := by
  classical
  dsimp
  have hqerase : q ∉ s.erase p := by simp [hqs]
  have hpPrime := hs p hp
  have hprod : (∏ x ∈ s.erase p, x) * p = ∏ x ∈ s, x := by
    simpa using Finset.prod_erase_mul s (fun x : Nat => x) hp
  have hpred : predProd (s.erase p) * (p - 1) = predProd s := by
    simpa [predProd] using Finset.prod_erase_mul s (fun x : Nat => x - 1) hp
  have hnewProd : ∏ x ∈ insert q (s.erase p), x =
      q * ∏ x ∈ s.erase p, x := by simp [hqerase]
  have hnewPred : predProd (insert q (s.erase p)) =
      (q - 1) * predProd (s.erase p) := by simp [predProd, hqerase]
  rw [← hprod, ← hpred, hnewProd, hnewPred]
  have hp1 : 1 ≤ p := hpPrime.one_le
  have hq1 : 1 ≤ q := hq.one_le
  have hpSub : p - 1 + 1 = p := Nat.sub_add_cancel hp1
  have hqSub : q - 1 + 1 = q := Nat.sub_add_cancel hq1
  have hpq : p * (q - 1) ≤ (p - 1) * q := by nlinarith
  calc
    (∏ x ∈ s.erase p, x) * p * ((q - 1) * predProd (s.erase p)) =
        ((∏ x ∈ s.erase p, x) * predProd (s.erase p)) * (p * (q - 1)) := by ring
    _ ≤ ((∏ x ∈ s.erase p, x) * predProd (s.erase p)) * ((p - 1) * q) :=
      Nat.mul_le_mul_left _ hpq
    _ = predProd (s.erase p) * (p - 1) *
        (q * ∏ x ∈ s.erase p, x) := by ring

/-- Every finite prime set is dominated, in the exact Euler ratio, by some
primorial no larger than its radical. -/
private theorem exists_primorial_ratio_dominate
    (s : Finset Nat) (hs : primeSet s) :
    ∃ m, primorial m ≤ ∏ p ∈ s, p ∧
      (∏ p ∈ s, p) * (primorial m).totient ≤ predProd s * primorial m := by
  classical
  generalize hR : (∏ p ∈ s, p) = R
  induction R using Nat.strong_induction_on generalizing s with
  | h R ih =>
    by_cases hse : s = ∅
    · subst s
      simp at hR
      subst R
      exact ⟨0, by simp, by simp [predProd]⟩
    · have hsne : s.Nonempty := Finset.nonempty_iff_ne_empty.mpr hse
      let p := s.max' hsne
      have hp : p ∈ s := by simpa [p] using Finset.max'_mem s hsne
      have hpPrime : p.Prime := hs p hp
      have hsSub : s ⊆ Nat.primesLE p := by
        simpa [p] using primeSet_subset_primesLE_max' hs hsne
      by_cases hinit : Nat.primesLE p ⊆ s
      · have hseq : s = Nat.primesLE p := Finset.Subset.antisymm hsSub hinit
        refine ⟨p, ?_, ?_⟩
        · rw [← hR, hseq, primorial_eq_prod_primesLE]
        · rw [← hR, hseq]
          rw [show predProd (Nat.primesLE p) =
              ∏ q ∈ Nat.primesLE p, (q - 1) by rfl]
          rw [← primorial_eq_prod_primesLE,
            totient_primorial_eq_prod_primesLE_pred]
          simp [Nat.mul_comm]
      · obtain ⟨q, hqT, hqNot⟩ := Finset.not_subset.mp hinit
        have hqData := Nat.mem_primesLE.mp hqT
        have hqle : q ≤ p := hqData.1
        have hqPrime : q.Prime := hqData.2
        have hqne : q ≠ p := by
          intro heq
          subst q
          exact hqNot hp
        have hqlt : q < p := lt_of_le_of_ne hqle hqne
        let s' := insert q (s.erase p)
        have hs' : primeSet s' := by
          intro x hx
          rcases Finset.mem_insert.mp hx with rfl | hx'
          · exact hqPrime
          · exact hs x (Finset.mem_of_mem_erase hx')
        have hqerase : q ∉ s.erase p := by simp [hqNot]
        have hprod : (∏ x ∈ s.erase p, x) * p = ∏ x ∈ s, x := by
          simpa using Finset.prod_erase_mul s (fun x : Nat => x) hp
        have hnewProd : ∏ x ∈ s', x = q * ∏ x ∈ s.erase p, x := by
          simp [s', hqerase]
        have hApos : 0 < ∏ x ∈ s.erase p, x := by
          apply primeSet_prod_pos
          intro x hx
          exact hs x (Finset.mem_of_mem_erase hx)
        have hlt : (∏ x ∈ s', x) < R := by
          rw [hnewProd, ← hR, ← hprod]
          simpa [Nat.mul_comm] using (Nat.mul_lt_mul_right hApos).mpr hqlt
        obtain ⟨m, hmProd, hmRatio⟩ := ih (∏ x ∈ s', x) hlt s' hs' rfl
        refine ⟨m, hmProd.trans hlt.le, ?_⟩
        rw [← hR]
        have hlocal := exchange_ratio hs hp hqPrime hqNot hqlt
        dsimp only at hlocal
        have hQpos : 0 < predProd s' := primeSet_predProd_pos hs'
        apply Nat.le_of_mul_le_mul_right (c := predProd s') ?_ hQpos
        calc
          ((∏ x ∈ s, x) * (primorial m).totient) * predProd s' =
              ((∏ x ∈ s, x) * predProd s') * (primorial m).totient := by ring
          _ ≤ (predProd s * (∏ x ∈ s', x)) * (primorial m).totient :=
            Nat.mul_le_mul_right _ hlocal
          _ = predProd s * ((∏ x ∈ s', x) * (primorial m).totient) := by ring
          _ ≤ predProd s * (predProd s' * primorial m) :=
            Nat.mul_le_mul_left _ hmRatio
          _ = (predProd s * primorial m) * predProd s' := by ring

private theorem ratio_mono_of_subset {s t : Finset Nat} (hst : s ⊆ t) :
    (∏ x ∈ s, x) * predProd t ≤ predProd s * (∏ x ∈ t, x) := by
  classical
  have hdiff : predProd (t \ s) ≤ ∏ x ∈ t \ s, x := by
    dsimp [predProd]
    exact Finset.prod_le_prod (fun _ _ => Nat.zero_le _)
      (fun x _ => Nat.sub_le x 1)
  have hprod := Finset.prod_sdiff hst (f := fun x : Nat => x)
  have hpred := Finset.prod_sdiff hst (f := fun x : Nat => x - 1)
  change (∏ x ∈ s, x) * predProd t ≤ predProd s * (∏ x ∈ t, x)
  rw [← hprod]
  change (∏ x ∈ s, x) * (∏ x ∈ t, (x - 1)) ≤
    predProd s * ((∏ x ∈ t \ s, x) * ∏ x ∈ s, x)
  rw [← hpred]
  change (∏ x ∈ s, x) * (predProd (t \ s) * predProd s) ≤
    predProd s * ((∏ x ∈ t \ s, x) * ∏ x ∈ s, x)
  calc
    (∏ x ∈ s, x) * (predProd (t \ s) * predProd s) =
        ((∏ x ∈ s, x) * predProd s) * predProd (t \ s) := by ring
    _ ≤ ((∏ x ∈ s, x) * predProd s) * (∏ x ∈ t \ s, x) :=
      Nat.mul_le_mul_left _ hdiff
    _ = predProd s * ((∏ x ∈ t \ s, x) * ∏ x ∈ s, x) := by ring

private theorem primorial_ratio_mono {m k : Nat} (hmk : m ≤ k) :
    primorial m * (primorial k).totient ≤
      (primorial m).totient * primorial k := by
  have hsub : Nat.primesLE m ⊆ Nat.primesLE k := Nat.primesLE_mono hmk
  have hratio := ratio_mono_of_subset hsub
  rw [← primorial_eq_prod_primesLE] at hratio
  change primorial m * predProd (Nat.primesLE k) ≤
    predProd (Nat.primesLE m) * primorial k at hratio
  simpa [predProd, totient_primorial_eq_prod_primesLE_pred] using hratio

/-- Exact primorial-ratio maximizer in cross-multiplied natural arithmetic.
For every positive `c ≤ N`, the largest primorial at most `N` has ratio
`P_N / φ(P_N)` at least `c / φ(c)`. -/
theorem boundedPrimorial_ratio_dominates
    {N c : Nat} (hc : 0 < c) (hcN : c ≤ N) :
    c * boundedPrimorialPredProduct N ≤ c.totient * boundedPrimorial N := by
  classical
  let s := c.primeFactors
  let R := ∏ p ∈ s, p
  let Q := predProd s
  have hs : primeSet s := by
    intro p hp
    exact Nat.prime_of_mem_primeFactors (by simpa [s] using hp)
  obtain ⟨m, hmR, hmRatio⟩ := exists_primorial_ratio_dominate s hs
  have hRd : R ∣ c := by
    simpa [R, s] using Nat.prod_primeFactors_dvd c
  have hRleC : R ≤ c := Nat.le_of_dvd hc hRd
  have htot : c.totient = (c / R) * Q := by
    simpa [R, Q, s, predProd] using Nat.totient_eq_div_primeFactors_mul c
  have hcEq : c = (c / R) * R := (Nat.div_mul_cancel hRd).symm
  have hcPrim : c * (primorial m).totient ≤ c.totient * primorial m := by
    calc
      c * (primorial m).totient =
          (c / R) * (R * (primorial m).totient) := by
            simpa [Nat.mul_assoc] using
              congrArg (fun x : Nat => x * (primorial m).totient) hcEq
      _ ≤ (c / R) * (Q * primorial m) := Nat.mul_le_mul_left _ hmRatio
      _ = c.totient * primorial m := by rw [htot]; ring
  have hmN : primorial m ≤ N := hmR.trans (hRleC.trans hcN)
  have hmIndex : m ≤ N := (le_primorial_self (n := m)).trans hmN
  have hmCut : m ≤ primorialCutoff N := Nat.le_findGreatest hmIndex hmN
  have hPrimBound : primorial m * boundedPrimorialPredProduct N ≤
      (primorial m).totient * boundedPrimorial N := by
    simpa [boundedPrimorial, boundedPrimorialPredProduct] using
      (primorial_ratio_mono hmCut)
  apply Nat.le_of_mul_le_mul_right (c := primorial m) ?_ (primorial_pos m)
  calc
    (c * boundedPrimorialPredProduct N) * primorial m =
        c * (primorial m * boundedPrimorialPredProduct N) := by ring
    _ ≤ c * ((primorial m).totient * boundedPrimorial N) :=
      Nat.mul_le_mul_left _ hPrimBound
    _ = (c * (primorial m).totient) * boundedPrimorial N := by ring
    _ ≤ (c.totient * primorial m) * boundedPrimorial N :=
      Nat.mul_le_mul_right _ hcPrim
    _ = (c.totient * boundedPrimorial N) * primorial m := by ring

/-- Cross-multiplied maximum characterization, including attainment at the
largest bounded primorial itself. -/
theorem boundedPrimorial_ratio_maximum (N : Nat) (hN : 0 < N) :
    0 < boundedPrimorial N ∧ boundedPrimorial N ≤ N ∧
      (∀ c, 0 < c → c ≤ N →
        c * boundedPrimorialPredProduct N ≤
          c.totient * boundedPrimorial N) ∧
      boundedPrimorial N * boundedPrimorialPredProduct N =
        (boundedPrimorial N).totient * boundedPrimorial N := by
  refine ⟨boundedPrimorial_pos N, boundedPrimorial_le N hN,
    fun _ hc hcN => boundedPrimorial_ratio_dominates hc hcN, ?_⟩
  simp [boundedPrimorialPredProduct, Nat.mul_comm]

/-- Exact gain associated with the largest primorial at most `N`. -/
def boundedPrimorialHeightGain (N : Nat) : Nat :=
  rationalCoefficientHeightGain N (boundedPrimorial N)
    (boundedPrimorialPredProduct N)

theorem boundedPrimorialCoefficient_pos (N : Nat) :
    0 < 4 * boundedPrimorial N - boundedPrimorialPredProduct N := by
  have hP := boundedPrimorial_pos N
  have hQP : boundedPrimorialPredProduct N ≤ boundedPrimorial N :=
    Nat.totient_le _
  omega

theorem boundedPrimorialHeightGain_spec {N : Nat} (hN : 0 < N) :
    (4 * boundedPrimorial N - boundedPrimorialPredProduct N) *
        boundedPrimorialHeightGain N <
      N * boundedPrimorialPredProduct N := by
  exact rationalCoefficientHeightGain_spec
    (Nat.mul_pos hN (boundedPrimorialPredProduct_pos N))

theorem boundedPrimorialHeightGain_maximal {N t : Nat}
    (ht : (4 * boundedPrimorial N - boundedPrimorialPredProduct N) * t <
      N * boundedPrimorialPredProduct N) :
    t ≤ boundedPrimorialHeightGain N := by
  exact rationalCoefficientHeightGain_maximal
    (boundedPrimorialCoefficient_pos N) ht

/-- Reusable conditional interface with the ratio inequality displayed as a
premise.  The unconditional specialization is below. -/
theorem boundedPrimorialRatioHeight_family_witness
    {n N t : Nat} (speeds : Fin n → Nat)
    (hnN : n + 1 = N) (ht : 0 < t)
    (hpos : ∀ i, 0 < speeds i) (hinj : Function.Injective speeds)
    (hbound : ∀ i, speeds i ≤ N + t)
    (hratio : ∀ c, 0 < c → c ≤ N →
      c * boundedPrimorialPredProduct N ≤ c.totient * boundedPrimorial N)
    (hgrowth : (4 * boundedPrimorial N - boundedPrimorialPredProduct N) * t <
      N * boundedPrimorialPredProduct N) :
    ∃ tau : Real, ∀ i,
      (N : Real)⁻¹ ≤ circleNorm (tau * (speeds i : Real)) := by
  apply rationalCoefficientHeight_family_witness speeds hnN ht hpos hinj hbound
    (P := boundedPrimorial N) (Q := boundedPrimorialPredProduct N)
  · exact Nat.totient_le _
  · exact hratio
  · exact hgrowth

/-- Unconditional exact primorial-ratio bounded-height theorem. -/
theorem boundedPrimorialHeight_family_witness
    {n N t : Nat} (speeds : Fin n → Nat)
    (hnN : n + 1 = N) (ht : 0 < t)
    (hpos : ∀ i, 0 < speeds i) (hinj : Function.Injective speeds)
    (hbound : ∀ i, speeds i ≤ N + t)
    (hgrowth : (4 * boundedPrimorial N - boundedPrimorialPredProduct N) * t <
      N * boundedPrimorialPredProduct N) :
    ∃ tau : Real, ∀ i,
      (N : Real)⁻¹ ≤ circleNorm (tau * (speeds i : Real)) := by
  exact boundedPrimorialRatioHeight_family_witness speeds hnN ht hpos hinj hbound
    (fun _ hc hcN => boundedPrimorial_ratio_dominates hc hcN) hgrowth

/-- Stationary-runner form with `N=n+1` visible. -/
theorem boundedPrimorialHeight_stationary_witness
    {n t : Nat} (speeds : Fin n → Nat) (ht : 0 < t)
    (hpos : ∀ i, 0 < speeds i) (hinj : Function.Injective speeds)
    (hbound : ∀ i, speeds i ≤ n + 1 + t)
    (hgrowth :
      (4 * boundedPrimorial (n + 1) - boundedPrimorialPredProduct (n + 1)) * t <
        (n + 1) * boundedPrimorialPredProduct (n + 1)) :
    ∃ tau : Real, ∀ i,
      (((n + 1 : Nat) : Real)⁻¹) ≤
        circleNorm (tau * (speeds i : Real)) := by
  exact boundedPrimorialHeight_family_witness speeds rfl ht hpos hinj hbound hgrowth

/-- Explicit-gain form retaining the ratio premise for reuse. -/
theorem boundedPrimorialHeightGain_family_witness_of_ratio
    {n N : Nat} (speeds : Fin n → Nat)
    (hnN : n + 1 = N)
    (hgain : 0 < boundedPrimorialHeightGain N)
    (hpos : ∀ i, 0 < speeds i) (hinj : Function.Injective speeds)
    (hbound : ∀ i, speeds i ≤ N + boundedPrimorialHeightGain N)
    (hratio : ∀ c, 0 < c → c ≤ N →
      c * boundedPrimorialPredProduct N ≤ c.totient * boundedPrimorial N) :
    ∃ tau : Real, ∀ i,
      (N : Real)⁻¹ ≤ circleNorm (tau * (speeds i : Real)) := by
  have hN : 0 < N := by omega
  exact boundedPrimorialRatioHeight_family_witness speeds hnN hgain hpos hinj hbound
    hratio (boundedPrimorialHeightGain_spec hN)

/-- Unconditional exact-gain primorial theorem. -/
theorem boundedPrimorialHeightGain_family_witness
    {n N : Nat} (speeds : Fin n → Nat)
    (hnN : n + 1 = N)
    (hgain : 0 < boundedPrimorialHeightGain N)
    (hpos : ∀ i, 0 < speeds i) (hinj : Function.Injective speeds)
    (hbound : ∀ i, speeds i ≤ N + boundedPrimorialHeightGain N) :
    ∃ tau : Real, ∀ i,
      (N : Real)⁻¹ ≤ circleNorm (tau * (speeds i : Real)) := by
  exact boundedPrimorialHeightGain_family_witness_of_ratio speeds hnN hgain hpos hinj hbound
    (fun _ hc hcN => boundedPrimorial_ratio_dominates hc hcN)

end LonelyRunner
