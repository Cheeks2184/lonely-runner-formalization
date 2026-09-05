# From conditional height reduction to the inclusive finite families

2026-09-05. Requested Astra xhigh semantic design, task
`/root/guard_internal_cover_audit-finite-family-contract`. Source checkpoint
`52eb99ea7d4cdd428dadd544c10f247a8a90d3e5` (Pass25). Runtime model/effort
metadata was not independently exposed. Only this note and small temporary
controls are owned. The project remains in authorized research.

**Disposition: a complete manuscript derivation and uncompiled implementation
contract for `Conjecture ↔ all F_N`.** This neither proves F_N nor declares
the equivalence in Lean. The already compiled large-height theorem is the
essential conditional input; sorting, normalization, transport, and induction
must still be implemented and independently reviewed at their exact types.

## Fixed input and exact finite-family statement

Read `LonelyRunner/FiniteHeightReduction.lean`, SHA-256
`61a5ac9e27c58db10bf014bd91346769665038ebb3c05689237870de49279be1`, and
its final independent review `research/astra-finite-height-formal-review.md`,
SHA-256 `723e52d4ba10a5e8976c301c2f94e312d77c8d1afb42d4ce37b4082892fd0375`.
The existing `primitive_sorted_largeHeight_lonelyAt` accepts m>=1,
`LowerCountPositiveIntegerHypothesis (m+2)`, a strictly increasing natural
tuple s on `Fin (m+2)`, s0=0, joint finite gcd one, and
`((m+2)*(m+1))^m < s(last)`. It returns a positive canonical lonely time
for each chosen original label. No normalization wrapper is in that type.

Use N=m+2 and C_m=((m+2)*(m+1))^m. Define F_N by the following proposed
Lean definitions; indexing by m avoids dependent endpoint casts. Every N>=3
appears once, at m=N-2>=1.

```lean
def InclusivePrimitiveFiniteFamily (m : ℕ) : Prop :=
  ∀ s : Fin (m + 2) → ℕ,
    StrictMono s → s 0 = 0 → Finset.univ.gcd s = 1 →
    s (Fin.last (m + 1)) ≤ ((m + 2) * (m + 1)) ^ m →
    ∀ r : Fin (m + 2), ∃ t : ℝ,
      LonelyAt (fun i => (s i : ℝ)) r t

def AllInclusivePrimitiveFiniteFamilies : Prop :=
  ∀ m : ℕ, 1 ≤ m → InclusivePrimitiveFiniteFamily m
```

The height bound is inclusive; replacing `≤` by `<` leaves a gap. The
quantifiers are `∀ s, ∀ r, ∃ t, ∀ other≠r`, with one common time for all
comparisons to that chosen runner. Neither a common time for all chosen
runners nor separately chosen times for their comparisons is asserted.

Real time is unrestricted, exactly as in `Conjecture`. This is equivalent
to the positive-time manuscript version: for N>=2, t=0 cannot be lonely
because all positions coincide and 1/N>0. A negative lonely time can be
negated using existing `lonelyAt_neg_time`. Thus choosing unrestricted time
does not weaken the mathematical finite-family obligation, and avoids a
positivity adapter on the shortest equivalence proof. The large-height
branch's stronger `0<t` conclusion can simply be discarded.

At a fixed m there are finitely many possible tuples: strict monotonicity
bounds every s_i by C_m, so they embed into functions
`Fin (m+2) → Fin (C_m+1)`. This is finiteness of the configuration family;
the displayed real-time existential is not automatically a kernel-`decide`
implementation. No exhaustive verification or certificate for F_N is supplied.

## 1. Sorting without losing the labels

New proposed contract, valid also for empty and singleton index types:

```lean
theorem exists_strictMono_reindex {n : ℕ} {α : Type*} [LinearOrder α]
    (a : Fin n → α) (hinj : Function.Injective a) :
    ∃ e : Fin n ≃ Fin n, StrictMono (fun j => a (e j))
```

For S=`Finset.univ.image a`, injectivity proves |S|=n. The pinned source
provides `S.orderIsoOfFin hcard` and `S.orderEmbOfFin hcard`, respectively
an order isomorphism to the range subtype and its increasing enumeration.
Membership and range lemmas are available. This was independently read from
[pinned mathlib Sort.lean](https://raw.githubusercontent.com/leanprover-community/mathlib4/520045ab14e26149ee970e2e617ca04b09bde5d6/Mathlib/Data/Finset/Sort.lean),
lines 175-208; the order embedding's strict-monotonicity use occurs at line
241. No dependency restoration was needed.

The original map to S, `i ↦ ⟨a i, membership⟩`, is bijective: injectivity is
hinj and surjectivity is image membership. Compose the increasing enumeration
with the inverse of that bijection to obtain e. Hence **e maps sorted labels
to original labels**, and the original runner r has sorted label `e.symm r`.
One may construct the original-range equivalence explicitly from unique
preimages, without asserting an uninspected convenience API signature.

A range-membership-only sorting lemma would suffice for the shortest
stationary argument, but the explicit permutation also supports the requested
general all-chosen normalization. No specialized gcd-under-permutation lemma
is needed below: take the gcd only after constructing the sorted residual row.

## 2. General integer translation and gcd normalization

```lean
theorem exists_sorted_primitive_integer_normalization {m : ℕ}
    (a : Fin (m + 2) → ℤ) (hinj : Function.Injective a) :
    ∃ (e : Fin (m + 2) ≃ Fin (m + 2)) (c : ℤ) (g : ℕ)
      (b : Fin (m + 2) → ℕ),
      0 < g ∧ StrictMono b ∧ b 0 = 0 ∧ Finset.univ.gcd b = 1 ∧
      ∀ j, a (e j) = c + (g : ℤ) * (b j : ℤ)
```

Sort a using contract 1. Put c=a(e0) and
`w_j=(a(ej)-c).toNat`. Every subtraction is first done in integers, and
nonnegativity follows from sortedness. Thus `a(ej)-c=(w_j:Z)`, w is strictly
increasing, w0=0, and w_last>0. Define `g=Finset.univ.gcd w` and b_j=w_j/g.
The gcd divides every w_j; because w_last is nonzero, g>0. Natural division
is exact: w_j=g*b_j. Positive g and strict monotonicity of w give strict
monotonicity of b; b0=0. The finite-gcd quotient lemma gives gcd(b)=1.

The actual preexisting `PrimitivePrompt95.lean` records `speedGCD_dvd`,
`primitivePart`, and exact factorization, and uses precisely these mathlib
interfaces: `Finset.gcd_ne_zero_iff`, `Finset.gcd_div_eq_one`, and
`Nat.mul_div_cancel'`. In particular the source application of
`gcd_div_eq_one` requires membership and one nonzero coordinate. Apply it
here at last. Do **not** apply `speedGCD_pos` or `primitivePart_pos` to w
using their all-positive hypotheses: w0=0 violates those hypotheses.
The underlying gcd facts give the needed variant directly. Nothing from
the unproved Prompt95 route is required.

This handles arbitrary signed integers, any original order, and every
original label. All labels remain distinct; there is no absolute-value
deduplication. The relevant normalized height is
`b_last=(max(a)-min(a))/g`, not the original maximum or unnormalized width.
The integer c may be negative. A gcd of one is joint and does not require
an individual speed to be coprime to the height.

## 3. Exact inverse-index and inverse-time transport

```lean
theorem lonelyAt_reindex_translate_scale_iff {n : ℕ}
    (a b : Fin n → ℝ) (e : Fin n ≃ Fin n) (c g : ℝ)
    (hg : g ≠ 0) (hfactor : ∀ j, a (e j) = c + g * b j)
    (r : Fin n) (T : ℝ) :
    LonelyAt a r (T / g) ↔ LonelyAt b (e.symm r) T
```

Use existing `lonelyAt_iff_relativeLonelyAt`. For each original other label i,
the factorization at `e.symm i` and `e.symm r` gives exactly

```text
(T/g)*(a_i-a_r) = T*(b_(e^-1 i)-b_(e^-1 r)).
```

The common translation cancels; g cancels because it is nonzero. The
equivalence preserves inequality of labels and hence every quantified
comparison, with the same original denominator n. This proves both directions.
Existing `LonelyRunner.circleNorm_div_time_mul_scale`, in
`Normalization.lean`, supplies the same scaling identity;
there is no existing general permutation/translation theorem being assumed.
If g>0 and T>0, the transported time T/g is positive as well. When returning
to original speeds, multiplying the witness by g is the wrong direction.

## 4. The complete fixed-count integer bridge, retaining H_N

```lean
theorem integer_lonelyAt_of_lower_and_finiteFamily {m : ℕ} (hm : 1 ≤ m)
    (hLower : LowerCountPositiveIntegerHypothesis (m + 2))
    (hFinite : InclusivePrimitiveFiniteFamily m)
    (a : Fin (m + 2) → ℤ) (hinj : Function.Injective a) :
    ∀ r : Fin (m + 2), ∃ t : ℝ,
      LonelyAt (fun i => (a i : ℝ)) r t
```

Contract 2 gives e,c,g,b. Split on b_last<=C_m. The low-height case uses
hFinite; the complementary case uses the **actual compiled**
`primitive_sorted_largeHeight_lonelyAt hm hLower b ...`. Apply either result
at `e.symm r`, obtaining T, and contract 3 returns t=T/g at original r.
This is a complete deduction, not an assumption that the original tuple was
already sorted or primitive. No F_N is used in the large-height branch, and
no H_N is used to assert a low-height witness. Both assumptions are explicit
at this fixed-count bridge; the next induction, not this lemma, supplies H_N.

## 5. Strong induction on moving counts and the canonical iff

The following proposed local predicate is definitionally the fixed moving-count
body of `PositiveIntegerConjecture`, up to unfolding `circleNorm`:

```lean
def PositiveIntegerAtCount (n : ℕ) : Prop :=
  ∀ a : Fin n → ℕ,
    Function.Injective a → (∀ i, 0 < a i) →
    ∃ t : ℝ, ∀ i,
      (((n + 1 : ℕ) : ℝ)⁻¹) ≤ circleNorm (t * (a i : ℝ))

theorem lowerCount_of_previous_counts {n : ℕ} (hn : 2 ≤ n)
    (hprevious : ∀ d : ℕ, 1 ≤ d → d < n → PositiveIntegerAtCount d) :
    LowerCountPositiveIntegerHypothesis (n + 1)

theorem positiveIntegerAtCount_of_lower_and_finiteFamily {m : ℕ}
    (hm : 1 ≤ m)
    (hLower : LowerCountPositiveIntegerHypothesis (m + 2))
    (hFinite : InclusivePrimitiveFiniteFamily m) :
    PositiveIntegerAtCount (m + 1)

theorem positiveIntegerConjecture_of_allInclusivePrimitiveFiniteFamilies
    (hFinite : AllInclusivePrimitiveFiniteFamilies) :
    PositiveIntegerConjecture

theorem conjecture_iff_allInclusivePrimitiveFiniteFamilies :
    Conjecture ↔ AllInclusivePrimitiveFiniteFamilies
```

For the second displayed theorem, an H_(n+1) request has
`1<=d<=(n+1)-2=n-1`, hence d<n. Apply hprevious at d, retaining its own
threshold 1/(d+1). No same-count request d=n is admitted.

For the next theorem let a have m+1 positive distinct natural moving speeds.
Append zero at `Fin.last (m+1)` using
`full := Fin.lastCases 0 (fun i => (a i : Z))`. Full injectivity follows
by the two `Fin.lastCases` cases: the old labels remain distinct and their
positive speeds are nonzero. The preexisting
`injective_lastCases_zero` has the real-valued version of exactly this proof;
do not pretend it already has the integer signature. Apply contract 4 to full
at its last label. For each moving i, use i.castSucc as the other label and
the canonical relative bridge. The zero speed makes its relative speed a_i,
so the threshold is 1/(m+2), exactly that for m+1 moving runners.

Now prove `∀ n, 1<=n -> PositiveIntegerAtCount n` by
`Nat.strong_induction_on`, retaining `1<=n` inside the induction motive.
At n=1 use the existing `oneMovingRunner`; every Fin 1 index is zero. Its
explicit witness is 1/(2*a0), positive because a0>0, although this induction
only needs an unrestricted time. At n>=2 write n=m+1 with m>=1. The induction
hypotheses give H_(m+2) by the previous-count lemma, and hFinite m gives
F_(m+2). The appended-zero theorem gives P(n). The n=0 branch is outside
the positive-count guard; no fictitious F_2 or F_1 obligation is introduced.
`IntegerInduction.lean` already uses this strong-induction proof pattern,
but its unproved insertion-cover premise is not invoked here.

Unfolding `circleNorm` turns all P(n), n>=1, into
`PositiveIntegerConjecture`. The existing global
`conjecture_iff_positiveIntegerConjecture` then gives canonical `Conjecture`.
This call occurs only after **all** positive-integer counts are available;
there is no index-preserving or least-counterexample real BHK assumption.

Conversely, Conjecture applied to each strictly increasing real cast of a
bounded primitive natural tuple gives its canonical witnesses directly.
The extra zero/gcd/height restrictions can be ignored in this direction.
This proves the final iff without assuming H_N globally or deriving F_N
from the conditional height theorem. The universal collection of unproved
finite obligations is equivalent to the original unresolved conjecture.

## Implementation ownership and order

Suggested bounded source ownership after semantic acceptance:

1. `LonelyRunner/FiniteTupleSorting.lean`: generic sorting/permutation only,
   using pinned `Mathlib.Data.Finset.Sort`. No LRC premise.
2. `LonelyRunner/LonelyAtTransport.lean`: contract 3, independently of sorting;
   import existing definitions/normalization. This can run alongside stage 1.
3. `LonelyRunner/PrimitiveTupleNormalization.lean`: contract 2, after stage 1;
   import finite-gcd arithmetic. Prove the zero-containing gcd variant directly.
4. `LonelyRunner/FinitePrimitiveFamilies.lean`: finite-family definitions and
   contract 4, after stages 2 and 3; use frozen `FiniteHeightReduction`.
5. `LonelyRunner/FiniteFamilyEquivalence.lean`: moving-count predicate,
   appended-zero adapter, strong induction, and final iff; import stage 4,
   existing base case, and the global BHK bridge.

These are proposed owned modules, not files created by this task. Source
integration, dependency restoration, module/full builds, trust audits, and
independent source review remain root-controlled. No owner should edit a
predecessor's unfrozen source to work around a missing contract. The only
remaining mathematical supply problem is proving all F_N; the listed bridge
work is formal encoding of the deduction above.

## Exact controls and replay

The following fixed rational controls check normalization, signed differences,
inverse label/time transport, the inclusive split, the one-moving base, and
the induction count arithmetic. They do not search for tuples or witnesses.
Literal witness times are provided only for the three 3-runner fixtures.

```python
from fractions import Fraction as F
from math import gcd
from collections import Counter
import json

def norm(x):
    f = x % 1
    return min(f, 1-f)

counts = Counter()
fixtures = [
    # Original labels, expected sorted-to-original permutation, c, g, primitive row.
    ((14,-10,2), (1,2,0), -10,12, (0,1,2), (F(1,3),F(1,2),F(1,3))),
    ((6,0,5), (1,2,0), 0,1, (0,5,6), (F(1,12),F(1,3),F(2,5))),
    ((2,11,0), (2,0,1), 0,1, (0,2,11), (F(1,3),F(1,6),F(1,20))),
    ((-91,769,-101,334), (2,0,3,1), -101,5, (0,2,87,174), None),
]
for a,expected_e,c,g,b,times in fixtures:
    n=len(a)
    e=tuple(sorted(range(n),key=lambda i:a[i]))
    assert e==expected_e and len(set(a))==n
    inv=tuple(e.index(i) for i in range(n))
    w=tuple(a[i]-min(a) for i in e)
    assert c==min(a) and g==gcd(*w)>0
    assert tuple(x//g for x in w)==b and gcd(*b)==1 and b[0]==0
    assert all(x<y for x,y in zip(b,b[1:]))
    assert all(a[e[j]]==c+g*b[j] for j in range(n))
    cutoff=(n*(n-1))**(n-2)
    counts['inclusive_low'] += b[-1]<=cutoff
    counts['strict_high'] += cutoff<b[-1]
    counts['height_equality'] += b[-1]==cutoff
    for r in range(n):
        for T in [F(-2,7),F(0),F(3,8)]:
            for i in range(n):
                if i==r: continue
                x=(a[i]-a[r])*T/g
                y=(b[inv[i]]-b[inv[r]])*T
                assert x==y and norm(x)==norm(y)
                counts['signed_transport_comparisons'] += 1
        if times is not None:
            T=times[inv[r]]
            assert T>0 and T/g>0
            assert all(norm((a[i]-a[r])*T/g)>=F(1,n)
                       for i in range(n) if i!=r)
            counts['literal_all_chosen_witnesses'] += 1
        assert any(i!=r for i in range(n))
        assert all(norm(F(a[i]-a[r])*0)==0<F(1,n)
                   for i in range(n) if i!=r)
        counts['zero_time_exclusions'] += 1
    counts['normalization_fixtures'] += 1

# Two concrete incorrect transports fail on the non-involutive first permutation.
a,e,c,g,b,times=fixtures[0]
r=0
wrong_index_time=times[e[r]]/g
assert norm((a[1]-a[r])*wrong_index_time)==0<F(1,3)
wrong_scale_time=times[e.index(r)]*g
assert all(norm((a[i]-a[r])*wrong_scale_time)==0 for i in range(3) if i!=r)
counts['wrong_transport_rejections'] += 2
# Translation/normalization is before the height split: raw width 24 becomes 2.
assert max(a)-min(a)==24>6 and b[-1]==2<=6
assert gcd(2,174)>1 and gcd(87,174)>1 and gcd(2,87,174)==1
counts['normalization_boundary_controls'] += 2
for v in [1,7,35]:
    t=F(1,2*v)
    assert t>0 and norm(v*t)==F(1,2)
    counts['one_moving_base'] += 1
for n in range(2,9):
    N,m=n+1,n-1
    assert N==m+2 and (N*(N-1))**(N-2)==((m+2)*(m+1))**m
    for d in range(1,N-1):
        assert 1<=d<=N-2 and d<n and d+1<N
        counts['strict_lower_count_requests'] += 1
print(json.dumps(dict(sorted(counts.items())),sort_keys=True))
```

Run only this fixed block from the repository root:

```bash
python3 -B - <<'FINITE_FAMILY_CONTRACT_CONTROLS'
from pathlib import Path
import re
p=Path('research/astra-finite-family-bridge-contract.md')
blocks=re.findall(r'^```python\n(.*?)^```[ \t]*$',p.read_text(),re.M|re.S)
assert len(blocks)==1
exec(compile(blocks[0],str(p),'exec'),{})
FINITE_FAMILY_CONTRACT_CONTROLS
```

The exact saved block passed on its first replay, exit zero:

```text
normalization_fixtures=4; signed_transport_comparisons=90;
literal_all_chosen_witnesses=9; zero_time_exclusions=13;
inclusive_low=2; strict_high=2; height_equality=1;
normalization_boundary_controls=2; wrong_transport_rejections=2;
one_moving_base=3; strict_lower_count_requests=28.
```

Additional inspected project source hashes:

| File | SHA-256 |
| --- | --- |
| `LonelyRunner/PrimitivePrompt95.lean` | `d1d6cf01650c809da0cb19ed722754071df070831e02e22a3c4b2c3dc28afb04` |
| `LonelyRunner/Normalization.lean` | `20193ad984f308ce8512930fe683d3118a2b3b5c18636a6a1f4454aa6df43797` |
| `LonelyRunner/StationaryEquivalence.lean` | `12dce8930c34b211bc01e2dc21e932087270726bce2bf127fa2d8d6594544b49` |
| `LonelyRunner/BHKRealReduction.lean` | `98d7c878eef7e4a3b7f7c504c882cf35191c1343816a59d731193ac8a207ed26` |
| `LonelyRunner/BaseCases.lean` | `31e2c328e060c077c6c9928e3fb431601326e4e54a949ee5148aed5cd3687d1f` |
| `LonelyRunner/Formulations.lean` | `0c3328e975bee236ff66862d3a5cadeb58fbc7c804fa953e53701ba466b9d788` |

This task read current configuration, workflow, policy, and state;
`python3 -B scripts/validate_workflow.py` passed.
Source inspection included the full final height theorem and review, actual
canonical/positive-integer definitions, strong-induction skeleton, primitive
and scaling interfaces, and the pinned sorting API. No Lean execution,
dependency/cache restoration, source edit, Git action, or shared-state write
was performed. No new broad search was run. All owned commands completed and
no owned background process remains running at handoff. The unrestricted
conjecture and universal finite-family supply obligation remain unresolved.
