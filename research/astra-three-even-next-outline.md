# Three-even assembly: next exact-contract work

Root outline for the already accepted section 8 manuscript, now that the two
weak sixth-shift lemmas and small prescribed orbit are compiled. This is not a
formal proof claim or a replacement for independent contract review.

Use a positive pivot A divisible by six, two other even labels E,F not divisible
by three, and two odd labels U,W not divisible by three, with five distinct
labels exhausting Fin 5. Work under absence of an all-real sixth-margin witness.
At any time with U phase zero and pivot safe, signed normalization puts E,F,W
into the unsigned weight-(2,2,1) weak-shift contracts. If E or F is weakly bad,
apply sixth_shift_weak_even; if W is weakly bad, apply sixth_shift_weak_odd.
The pivot is preserved by sixth shifts and U has signed b/6, always safe for the
nonzero permitted b. Hence E,F,W are all strictly safe there. Moreover W's norm
must exceed 1/3: otherwise a half-time shift preserves the three even phases,
makes U's phase 1/2, and changes W's norm to 1/2 minus its old norm, giving a
full witness. All sign and actual-time transports need explicit Lean equalities.

To force U dividing A, if it does not, use the checked prescribed-orbit theorem
with q=U (positive and coprime to six). At t=k/U the U phase is zero and the
pivot fractional phase r is in [1/12,1/6] or equals 1/5. Both 2t and 4t have
pivot norm at least 1/6, by the integer-band bounds on 2r and 4r. The preceding
result then makes W's norm exceed 1/3 at both 2t and 4t. This is impossible:
if a circle norm lies in (1/3,1/2], doubling has norm 1-2a <1/3. The folded
phase dilation identity reduces this scalar claim to an ordinary integer band.
Interchange the two odd labels to force W dividing A as well.

Coprimality to six and 6 dividing A now yield 6U dividing A and 6W dividing A,
so each odd speed is at most A/6. At t0=1/(6A), and every natural dilation
1≤a≤5, both odd phases are at most 5/36, strictly below 1/6, while the pivot
has norm at least 1/6. If E is weakly bad at such a time, the three weak labels
E,U,W invoke third_shift_of_three_weak_exceptions and contradict hno. Thus E's
norm is strictly above 1/6 at every one of these five dilates. The checked
exists_bad_sixth_dilate applied at t0E produces a dilation between two and five
strictly below 1/6, a contradiction.

Required implementation plan: exact pointwise label theorem plus a cardinality
adapter for unique three-divisibility and three even labels; explicit sign
normalization, U-zero/time identities, pivot double/fourfold bands, doubled-norm
contradiction, coprime/divisibility adapters, and the three-weak-label count.
No primitive gcd or speed injectivity premise is needed for the pointwise
branch. Keep all closed endpoints and use all-real hno before positive conversion.
Existing relevant APIs: WeakSixthShifts, SmallPhaseOrbits, SixthAffinePhase,
OddHalfTimeShift, FoldedCirclePhase, ThreeWeakExceptions, BadSixthDilate,
SmallSixthSeeds, TwoOddOutsideThree. Exact signatures must be checked before
delegating implementation. This outline does not authorize running new searches.
