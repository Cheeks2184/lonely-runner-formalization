# Contracts for the conditional primitive finite-height theorem

2026-09-05. Requested Astra xhigh semantic contract design; runtime model and
effort metadata were not independently exposed. Source checkpoint:
`26a06cd76f9bb2f912f6365ace6b95f86ebe0322`, branch
`codex/astra-affine-finite-height`. Only this note is owned by this task.

The accepted mathematical specification is
`research/astra-affine-finite-height-audit.md`, SHA-256
`6b676a05eb3a0036cd69e779150a5f1a868024d089ea75c142daeddccede938f`,
independently accepted in `research/astra-affine-finite-height-review.md`,
SHA-256 `eb0fb96e22096175fa3b68dc70a1b7981f39356aaf1377863dcaa95b6a510876`.
This note designs **uncompiled theorem contracts**, not new Lean declarations
or a formal acceptance of the implementation files being developed concurrently.
The proposed names below are new names unless expressly identified as existing.
Headers have no proof bodies and are not a compilable source file.

The target remains: under the lower-count hypothesis H_N alone, every primitive
sorted integer N-tuple, N>=3, with height H>[N(N-1)]^(N-2) has a positive
closed 1/N witness for every chosen runner. The inclusive finite family F_N
is unproved. This task does not attempt F_N or claim unrestricted LRC.

## Existing interfaces and count convention

Use `N=m+2`, with `1<=m`. Thus the full index type is `Fin (m+2)`, the
comparison type is `Fin (m+1)`, and the pigeonhole coordinates are `Fin m`.
The original endpoints are `0` and `Fin.last (m+1)`; for `j : Fin m` the
internal index is `j.castSucc.succ`. For a chosen `r : Fin (m+2)`,
`r.succAbove : Fin (m+1) -> Fin (m+2)` enumerates precisely its complement.
These are different enumerations serving different purposes.

Read current `LowerCountSupply.lean` definition:

```lean
def LowerCountPositiveIntegerHypothesis (N : ℕ) : Prop :=
  ∀ d : ℕ, 1 ≤ d → d ≤ N - 2 →
    ∀ speeds : Fin d → ℕ,
      Function.Injective speeds → (∀ i, 0 < speeds i) →
        ∃ time : ℝ, ∀ i,
          (((d + 1 : ℕ) : ℝ)⁻¹) ≤
            circleNorm (time * (speeds i : ℝ))
```

Its `lowerCountPositiveIntegerHypothesis_rational` transfers this exact
premise to positive distinct rational tuples. Its
`exists_lowerCount_rational_collision` gives threshold `((N-1 : ℕ) : ℝ)⁻¹`
for a nonempty nowhere-zero rational vector with at most `N-2` distinct
absolute values. Do not replace this premise with the all-dimensional
`PositiveIntegerConjecture` or `PositiveRationalConjecture`.

Current `exists_bhk_twoPhase_margin` accepts positive rational R and rational
S with nonconstant S/R, `0<k<=N-1`, `N>=3`, and H_N. It gives free real
A,B with all norms `||R_i*A+S_i*B||>=1/(N-1)`. It uses
`exists_bhk_adjacentRatioCombination`: all collision coordinates are nonzero
and two are opposite, so the absolute-value image has cardinality <k<=N-1.
The collision is not a signed equality. Denominator clearing is internal;
if exposed manually, a cleared-speed witness tau transfers by `t0=L*tau`,
never `tau/L`.

Current `exists_affinePhaseTransfer` in `AffinePhaseTransfer.lean` accepts
arbitrary index type, integer U, real V, real p,x,y,delta,epsilon, and exactly
`0<p`, `1/(2*p)<y`, joint margin `delta+epsilon`, and
`|V i|/(2*p)<=epsilon`. It returns `t>0`, `|t-y|<=1/(2*p)`, and the closed
delta bounds for `(p*U i+V i)*t`. It supplies no free phases itself.

During this task, `AffinePhasePeriod.lean`, `PositiveAffineWitness.lean`,
and the full `SimultaneousApproximation.lean` became available and were read.
The immediate remaining implementation order is **signed wrapper, endpoint
approximation packet and finite-gcd exclusion, relative-rank/canonical
composition**. Reuse the new positive core rather than duplicate its proof.

## 1. An algebraic rank interface, stable under changing the chosen runner

Avoid introducing linear algebra infrastructure solely to encode two vectors.
Use the following explicit rank condition:

```lean
def RationalPairRankTwo {ι : Type*} (u : ι → ℤ) (v : ι → ℚ) : Prop :=
  ∃ i j, (u i : ℚ) * v j ≠ (u j : ℚ) * v i

theorem rationalPairRankTwo_iff_no_relation {ι : Type*}
    (u : ι → ℤ) (v : ι → ℚ) :
    RationalPairRankTwo u v ↔
      ∀ A B : ℚ, (∀ i, A * (u i : ℚ) + B * v i = 0) →
        A = 0 ∧ B = 0

theorem relative_ratio_nonconstant_of_rankTwo {m : ℕ}
    (u : Fin (m + 2) → ℤ) (v : Fin (m + 2) → ℚ) (p : ℚ)
    (hu0 : u 0 = 0) (hv0 : v 0 = 0)
    (hrank : RationalPairRankTwo u v)
    (hinj : Function.Injective (fun i => p * (u i : ℚ) + v i))
    (r : Fin (m + 2)) :
    ∃ a b : Fin (m + 1),
      ((u (r.succAbove a) - u r : ℤ) : ℚ) /
          (p * ((u (r.succAbove a) - u r : ℤ) : ℚ) +
            (v (r.succAbove a) - v r)) ≠
      ((u (r.succAbove b) - u r : ℤ) : ℚ) /
          (p * ((u (r.succAbove b) - u r : ℤ) : ℚ) +
            (v (r.succAbove b) - v r))
```

The first bridge is elementary. A nonzero minor forces A=B=0 by elimination.
Conversely, if all minors vanish and some pair `(u i,v i)` is nonzero, the
nonzero coefficient pair `(v i,-u i)` annihilates every pair; if every pair
vanishes, `(1,0)` does. Thus this is exactly two-vector rational rank, not a
stronger hypothesis. This bridge is useful documentation but need not lie on
the shortest compilation path.

For the second contract, actual injectivity and `Fin.succAbove_ne` make every
denominator nonzero. If all ratios equal lambda, every relative pair obeys
`(1-lambda*p)*U-lambda*V=0`. Include the chosen label, where U=V=0. The
original zero label then makes the same relation hold on all original
coordinates. The coefficients cannot both vanish, contradicting rank two.
This proof works for every r; assuming only rank of the vector after deleting
the original zero label and then reusing it at other r would omit a bridge.

An alternative direct determinant proof avoids the first equivalence. Writing
`D(i,j)=u_i*v_j-u_j*v_i` and D_r for determinants after subtracting pair r,
anchoring at pair zero gives
`D(i,j)=D_r(i,j)-D_r(i,0)+D_r(j,0)`. Equal ratios imply every D_r=0 after
cross multiplication. Original rank then contradicts this identity. Repeated
u-values and zero relative U are permitted; only actual speed differences
are required to be nonzero.

## 2. Signed wrapper around the new positive core

Proposed header: the exact positive-core inputs with positivity replaced by
nonvanishing. Its real period q>=1 deliberately matches the existing API.

```lean
theorem exists_signedAffine_witness {N k : ℕ}
    (hN : 3 ≤ N) (hk : 0 < k) (hkN : k ≤ N - 1)
    (U : Fin k → ℤ) (V : Fin k → ℚ) (p : ℚ) (hp : 1 < p)
    (q : ℝ) (hq : 1 ≤ q)
    (hperiod : ∀ i, ∃ z : ℤ, q * (V i : ℝ) = (z : ℝ))
    (hactual : ∀ i, p * (U i : ℚ) + V i ≠ 0)
    (hratios : ∃ a b,
      (U a : ℚ) / (p * (U a : ℚ) + V a) ≠
      (U b : ℚ) / (p * (U b : ℚ) + V b))
    (herr : ∀ i, |(V i : ℝ)| / (2 * (p : ℝ)) ≤
      ((N * (N - 1) : ℕ) : ℝ)⁻¹)
    (hLower : LowerCountPositiveIntegerHypothesis N) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (N : ℝ)⁻¹ ≤ circleNorm
        (t * ((p : ℝ) * (U i : ℝ) + (V i : ℝ)))
```

Put T_i=p*U_i+V_i. On `0<T_i`, leave U_i,V_i unchanged; otherwise negate
both, retaining U' as an integer. Nonvanishing gives positivity of the new
actual row. The ratio U'/T' equals U/T, the absolute error is unchanged,
and each period witness z is unchanged or negated. Apply the actual
`exists_positiveAffine_witness` and remove each sign by circle-norm negation
invariance. These are two cases per row, not an additional rank premise.

The read positive core supplies free phases through BHK: for positive
R=pU+V and S=U its A,B become `x=p*A+B`, `y_raw=A`. It calls the read
`exists_normalized_affine_second_phase` to replace y_raw by
`y_raw-q*floor(y_raw/q)+q` in [q,2q). Phase changes are the integer
`(q*V_i)*(1-floor(y_raw/q))`. This works for negative or zero y_raw and
nonminimal q. It then calls the generic nearest-integer transfer. No
relation-compatibility claim with the original orbit is used, and period
one cannot replace q for general rational V.

## 3. A canonical affine wrapper with the original full count

```lean
theorem rational_affine_lonelyAt {m : ℕ} (hm : 1 ≤ m)
    (hLower : LowerCountPositiveIntegerHypothesis (m + 2))
    (u : Fin (m + 2) → ℤ) (v : Fin (m + 2) → ℚ)
    (p : ℚ) (hp : 1 < p) (q : ℕ) (hq : 0 < q)
    (hu0 : u 0 = 0) (hv0 : v 0 = 0)
    (hrank : RationalPairRankTwo u v)
    (hinj : Function.Injective (fun i => p * (u i : ℚ) + v i))
    (hperiod : ∀ i, ∃ z : ℤ, (q : ℚ) * v i = (z : ℚ))
    (r : Fin (m + 2))
    (herr : ∀ i, |v i - v r| ≤
      2 * p / (((m + 2) * (m + 1) : ℕ) : ℚ)) :
    ∃ t : ℝ, 0 < t ∧
      LonelyAt (fun i => ((p * (u i : ℚ) + v i : ℚ) : ℝ)) r t
```

Take the U,V differences on `r.succAbove`; subtract the two integral
representatives in hperiod to obtain the relative common period. Contract
1 supplies the nonconstant ratios, and contract 2 supplies t. Convert the
rational herr to its divided real form using positive 2p. The core already
uses `1/(m+2)+1/((m+2)*(m+1))=1/(m+1)` and `1/(2p)<q<=y`.
Final t is strictly positive, with equality allowed in distance and error;
the auxiliary BHK witness need not have been positive.

For any `other != r`, use the existing
`Fin.exists_succAbove_eq hother` to recover its comparison index. The
transport phase is exactly `(s_other-s_r)*t`; commute multiplication to
match `RelativeLonelyAt`. Finish with existing
`lonelyAt_iff_relativeLonelyAt`, using `circleNorm`'s definition. These exact
APIs and the `succAbove` pattern are already used in
`StationaryEquivalence.lean`. Never deduplicate these original comparisons
or replace their denominator m+2 by a cardinality of absolute differences.
The only deduplication is the auxiliary collision used to consume H_N.

## 4. Exactly m-coordinate pigeonhole, then an endpoint packet

The generic header is now present in the read implementing source:

```lean
theorem exists_simultaneous_integer_approximation (d Q : ℕ) (hQ : 0 < Q)
    (x : Fin d → ℝ) :
    ∃ q : ℕ, 0 < q ∧ q ≤ Q ^ d ∧
      ∃ z : Fin d → ℤ, ∀ i,
        |(q : ℝ) * x i - (z i : ℝ)| < (1 : ℝ) / (Q : ℝ)
```

The endpoint packet is the next proposed contract:

```lean
theorem exists_endpoint_affine_approximation {m : ℕ}
    (s : Fin (m + 2) → ℕ) (H Q : ℕ)
    (hH : 0 < H) (hQ : 0 < Q)
    (hs0 : s 0 = 0) (hsH : s (Fin.last (m + 1)) = H) :
    ∃ q : ℕ, 1 ≤ q ∧ q ≤ Q ^ m ∧
      ∃ u : Fin (m + 2) → ℤ,
        u 0 = 0 ∧ u (Fin.last (m + 1)) = (q : ℤ) ∧
        ∀ i, |(q : ℚ) * (s i : ℚ) / (H : ℚ) - (u i : ℚ)| <
          (1 : ℚ) / (Q : ℚ)
```

For the generic proof map `Fin (Q^d+1)` into `(Fin d -> Fin Q)` by box
number `floor(Q*fract(k*x_i))`. Each box lies in 0..Q-1. There are exactly
Q^d boxes, so the actual pinned
`Fintype.exists_ne_map_eq_of_card_lt` returns distinct k,ell with equal
boxes. Swap them to arrange k<ell and put q=ell-k. Membership in the same
half-open box proves the strict distance of their fractional parts is <1/Q.
Set `z_i=floor(ell*x_i)-floor(k*x_i)` and expand fractional parts. This also
works at d=0 and Q=1; empty comparisons do not invalidate pigeonhole. The
application here has d=m>=1 and Q=(m+2)*(m+1).

The endpoint packet applies this only to `x j=s(j.castSucc.succ)/H` for
`j : Fin m`. Extend z by `u := Fin.cases 0 (Fin.lastCases (q : ℤ) z)`.
The two endpoint errors are zero and therefore satisfy the same strict
inequality. Split indices into zero, internal, and final cases. Cast the
real inequality back to rationals, rather than imposing a rationality
assumption on generic x. This packet needs no sortedness of s and no
distinctness of u; those must not be added as hidden approximation claims.

Given the packet define, over Q,
`p=H/q` and `v_i=s_i-p*u_i`. Under `q<H`, p>1. Algebra gives
`q*v_i=q*s_i-H*u_i`, so hperiod has the explicit integer representative
`(q:Z)*(s_i:Z)-(H:Z)*u_i`. Both endpoint v-values vanish. Multiplying the
packet error by positive p gives `|v_i|<p/Q`; its weak form and the triangle
inequality give `|v_i-v_r|<=2p/Q` for every r. Actual speeds p*u+v are s
identically, so injectivity comes from s, even when u has repeated entries.

## 5. Primitivity excludes the exact rank-one approximation

Use the conventional natural finite gcd in the final theorem. No separate
Bezout certificate needs to be supplied or a new notion of primitive adopted.

```lean
theorem primitive_dvd_of_scaled_dvd {ι : Type*} [Fintype ι]
    (s : ι → ℕ) (hprimitive : Finset.univ.gcd s = 1)
    (H q : ℕ) (hdiv : ∀ i, H ∣ q * s i) : H ∣ q

theorem rankTwo_of_primitive_approximation {m : ℕ}
    (s : Fin (m + 2) → ℕ) (H q : ℕ)
    (hq : 0 < q) (hqH : q < H)
    (hprimitive : Finset.univ.gcd s = 1)
    (u : Fin (m + 2) → ℤ) (v : Fin (m + 2) → ℚ)
    (huH : u (Fin.last (m + 1)) = (q : ℤ))
    (hvH : v (Fin.last (m + 1)) = 0)
    (hidentity : ∀ i, (q : ℚ) * v i =
      (q : ℚ) * (s i : ℚ) - (H : ℚ) * (u i : ℚ)) :
    RationalPairRankTwo u v
```

The first result follows from the read pinned
`Finset.dvd_gcd_iff` and `Finset.gcd_mul_left`:

```text
H divides gcd_i(q*s_i) = normalize(q)*gcd_i(s_i) = q.
```

This is precisely the divisibility consequence of the manuscript's Bezout
argument. It does not require some individual s_i to be coprime to H.
Root independently suggested this simplification; the same finite-gcd route
was checked here against the actual source headers.

For the second result, if rank two fails, the determinant involving the
last coordinate `(q,0)` gives `q*v_i=0`, hence every v_i=0. The identity
then gives `H*u_i=q*s_i` over rationals. Cast this equality to integers,
obtaining divisibility there with witness u_i; the read
`Int.natCast_dvd_natCast` transfers it to `H | q*s_i` in naturals. Negative
approximating integers cause no difficulty and no positivity of u is needed.
The first lemma gives H|q, contradicting 0<q<H. Equivalently some v_i is
nonzero, and the determinant with last supplies the rank witness directly.

## 6. The full conditional primitive theorem

This is the required output contract, not a theorem with a supplied witness,
an extra nonconstant-ratio premise, or an unproved approximation premise:

```lean
theorem primitive_sorted_largeHeight_lonelyAt {m : ℕ} (hm : 1 ≤ m)
    (hLower : LowerCountPositiveIntegerHypothesis (m + 2))
    (s : Fin (m + 2) → ℕ)
    (hsorted : StrictMono s) (hs0 : s 0 = 0)
    (hprimitive : Finset.univ.gcd s = 1)
    (hheight : ((m + 2) * (m + 1)) ^ m < s (Fin.last (m + 1))) :
    ∀ runner : Fin (m + 2), ∃ t : ℝ, 0 < t ∧
      LonelyAt (fun i => (s i : ℝ)) runner t
```

Put N=m+2, Q=(m+2)*(m+1), H=s(last). Height gives H>0. Contract 4 gives
1<=q<=Q^m<H. Define p,v as above; contract 5 gives rank two. `StrictMono`
gives injectivity of s and therefore of p*u+v. For each runner r, the same
approximation supplies the relative error and period hypotheses of contract
3; its phase choices and resulting t may depend on r. Rewriting p*u+v=s
produces the displayed canonical `LonelyAt` statement.

This index convention covers exactly all N>=3: write N=m+2 using
`Nat.exists_eq_add_of_le'`, as the existing stationary equivalence does,
and derive 1<=m. Then N-2=m, N-1=m+1, and the cutoff is unchanged. A wrapper
over `Fin N` is optional presentation work; it must transport the tuple and
chosen index together. Gcd over all coordinates agrees with gcd over the
positive ones because s0=0 and strict monotonicity makes every later speed
positive. No finite tuple or chosen label is excluded by the m+2 convention.

To state the remaining obligation, F_N is the same primitive sorted family
with height **at most** Q^(N-2), with the same all-chosen conclusion. The
case of equality cannot move into this theorem: q=H, p=1, v=0 can then
occur. Without primitivity, rank one can occur at arbitrarily large height.
An optional later normalization wrapper sorts a general integer tuple,
subtracts its minimum, divides by its positive gcd g, and transports a
primitive witness T back at T/g, retaining every chosen label. That wrapper
must be proved; it is not silently needed to interpret the exact theorem
above, whose inputs are already primitive and sorted.

H_N plus F_N would give all integer configurations at this count after that
normalization. Strong induction, with the exact two-runner base, would
discharge H_N if F_N were proved at every larger count. Only after obtaining
all integer counts may the existing global
`conjecture_iff_positiveIntegerConjecture` supply the real canonical
conjecture. No index-preserving real-to-integer BHK theorem is assumed.

## Status, checked APIs, and reproducibility

No new mathematical premise is missing from this staged proof of the accepted
conditional large-height result. Required unfinished work is formal encoding:
the signed wrapper; determinant/relative-ratio adapter; endpoint extension;
finite-gcd exclusion; and canonical composition. The new helper implementations
do not establish the whole theorem until these bridges are compiled and
independently reviewed. F_N is the separate genuine mathematical supply gap.

The following relevant source bytes were read, not compiled by this task:

| Source | SHA-256 at inspection |
| --- | --- |
| `LonelyRunner/AffinePhaseTransfer.lean` | `069d7f05229f517639284a58d9bb10f6fd6ee8d949efc3d377361424e7381776` |
| `LonelyRunner/LowerCountSupply.lean` | `0705291adc53011fb72fc718a7260876512b092741442d6a6cceb4b76eb5ccf4` |
| `LonelyRunner/BHKTwoPhaseSupply.lean` | `2890e8ad41f9e3c2a0f098ba2a0da7060fa14ac2fe12842adf1c11905148ac09` |
| `LonelyRunner/AffinePhasePeriod.lean` | `340c4dd29276544566175cf791307ca42753ddc964345aa793d33abef1e9b176` |
| `LonelyRunner/PositiveAffineWitness.lean` | `ed9e66d5a8944f3b5862be66f96c30abe7829c063e866504ca9e9ac1989e2e03` |
| `LonelyRunner/SimultaneousApproximation.lean` | `144aec242a3f4d06853fed110bf8ee20f1cabf88b925acda889fe08cfe57c729` |
| `LonelyRunner/Definitions.lean` | `5f0258a6ab99950fc7045b2200d6708fe7603d3caa4d62855ef2b19a330c95aa` |
| `LonelyRunner/StationaryEquivalence.lean` | `12dce8930c34b211bc01e2dc21e932087270726bce2bf127fa2d8d6594544b49` |

Additional actual project interfaces read: `BHKAdjacentPair.lean`,
`RationalReduction.lean`, `FastRunnerInsertion.lean`, and the root's
`research/astra-affine-height-lean-interface.json`. The pinned mathlib
`Data/Fintype/Pigeonhole.lean` has
`Fintype.exists_ne_map_eq_of_card_lt (f : alpha -> beta)
 (h : card beta < card alpha) : exists x y, x!=y and f x=f y`.
`Algebra/GCDMonoid/Finset.lean` has `dvd_gcd_iff` and
`gcd_mul_left : gcd_i(a*f_i)=normalize a*gcd_i(f_i)`.
`Data/Fin/SuccPred.lean` has `succAbove_ne` and `exists_succAbove_eq` with
the orientation used above. `Data/Int/Basic.lean` uses
`Int.natCast_dvd_natCast` for cast divisibility. No nonexistent simultaneous
Dirichlet API or finite Bezout API is asserted. The full new simultaneous
proof was read when available; this note records source contracts, not an
independent compile, axiom check, or frozen-source acceptance of those helpers.

At startup and after compaction, current project configuration, workflow,
policy, and state were read; research is authorized and in progress.
`python3 -B scripts/validate_workflow.py` passed. Verification for this note
is source/header inspection and algebraic derivation against the independently
accepted manuscript; no Lean execution, dependency operation, tuple search,
finite enumeration, Git operation, or shared-state mutation was performed.
Only this note was written. All owned commands have completed, and no owned
background process remains running at handoff. Unrestricted LRC is unresolved.
