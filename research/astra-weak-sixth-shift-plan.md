# Weak sixth-shift choices from checked third shifts

Root derived this shorter assembly from the already checked third-shift and
half-shift interfaces. It preserves the two exact manuscript contracts in
research/astra-one-three-divisible-plan.md, section 8.2. This is a source plan,
not a new checked theorem. No finite computation is required.

Implement LonelyRunner/WeakSixthShifts.lean with two public declarations:

```lean
theorem sixth_shift_weak_even (x y z : ℝ)
    (hx : circleNorm x ≤ (1 : ℝ) / 6) :
    ∃ b : ℕ, (b = 1 ∨ b = 2 ∨ b = 4 ∨ b = 5) ∧
      (1 : ℝ) / 6 ≤ circleNorm (x + 2 * (b : ℝ) / 6) ∧
      (1 : ℝ) / 6 ≤ circleNorm (y + 2 * (b : ℝ) / 6) ∧
      (1 : ℝ) / 6 ≤ circleNorm (z + (b : ℝ) / 6)

theorem sixth_shift_weak_odd (x y z : ℝ)
    (hz : circleNorm z ≤ (1 : ℝ) / 6) :
    ∃ b : ℕ, 1 ≤ b ∧ b ≤ 5 ∧
      (1 : ℝ) / 6 ≤ circleNorm (x + 2 * (b : ℝ) / 6) ∧
      (1 : ℝ) / 6 ≤ circleNorm (y + 2 * (b : ℝ) / 6) ∧
      (1 : ℝ) / 6 ≤ circleNorm (z + (b : ℝ) / 6)
```

For weak-even, apply exists_nonzero_third_shift_safe y 1 to obtain
k : Fin 3 with k≠0 and N(y+k/3)≥1/6. Thus k.val=1 or 2.
third_shift_safe_of_weak_bad x 1 gives N(x+k/3)≥1/6 at the SAME k.
Choose b=k.val if N(z+k/6)≥1/6. Otherwise choose b=k.val+3:
the doubled x and y phases differ from x+k/3,y+k/3 by the integer 1;
the z phase differs from z+k/6 by 1/2. The identity
circleNorm_add_half w : N(w+1/2)=1/2-N(w) makes it >1/3 in this
second branch. These choices are exactly in {1,2,4,5}. Endpoint equality
uses the first branch and is never classified as bad.

For weak-odd, instantiate exists_third_shift_safe_nondivisible_family on
Fin 2 with phases ![x,y] and speeds constantly 1. It supplies k : Fin 3
with BOTH N(x+k/3), N(y+k/3)≥1/6. Map k.val=0,1,2 to b=3,4,2
respectively. The doubled phases for b=3 and b=4 differ from the selected
third shifts by the integer 1; b=2 agrees exactly. For the unit z phase,
b=3 gives z+1/2 whose norm is 1/2-N(z)≥1/3. The choices b=4 and b=2
give z+2/3 and z+1/3, safe by third_shift_safe_of_weak_bad z 1 at the
corresponding nonzero shift. Thus the proof actually uses {2,3,4}, while the
public contract retains 1≤b≤5. Do not claim an unproved stronger public theorem.

The hypotheses are arbitrary x,y,z real and a CLOSED weak-bad inequality on
only the indicated phase. A common b is chosen once for all three coordinates.
No sign, ordering, pair separation, strictness, or extra hypothesis is added.
The existing theorem names and signatures were read directly:
- NonzeroThirdShift.lean: third_shift_safe_of_weak_bad and
  exists_nonzero_third_shift_safe, both with natural d=1, not divisible by 3.
- ThirdShiftExceptions.lean: exists_third_shift_safe_nondivisible_family
  for any Fintype with card≤2, independent phases and natural speeds.
- FoldedCirclePhase.lean: circleNorm_add_half.
- StructuredClasses.lean: circleNorm_add_int (integer added on the left).
Normalize integer shifts with ring and the existing periodicity lemma;
use fin_cases on k or its two/three explicit natural-value possibilities.

Use Terra High compiled delivery with root's serial cache slot and the standard
initial check plus at most two repair rounds. Retain exact source bytes and raw
logs before each check. These lemmas support the three-even part of the current
N=6 milestone; after canonical N=6, the focus remains uniform arbitrary N.
