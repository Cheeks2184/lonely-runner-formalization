# Exact three-owner API inventory

Source checkpoint: `7a3ea75d1221b815a46b97f2b487807e48375649`.
Root mechanically regenerated this note after the routine inventory returned
inaccurate line references and incomplete signatures. These are literal source
headers with proof bodies removed; they are not new mathematical results.

## `card_pivotBadResidues_normalized`

`LonelyRunner/Prompt100TwoOwnerCounts.lean:37`; SHA-256 `ac24bb6cfcf524a08c0ceb2a728b2febf826c595d4aaa72eb7f10d2e5baa96dd`.

```lean
theorem card_pivotBadResidues_normalized
    (N p d h P D k : Nat)
    (hN : 2 <= N) (hp : 0 < p) (hd : 0 < d) (hdp : d < p)
    (hh : h = Nat.gcd d p)
    (hpP : p = h * P) (hdD : d = h * D)
    (hDP : Nat.Coprime D P) (hk : k = Nat.gcd D N) :
    (pivotBadResidues N p d).card = h * normalizedBadCount N k P
```

## `mem_pivotCandidates_scale_reduce_iff`

`LonelyRunner/Prompt99Scaling.lean:68`; SHA-256 `49131a7f9690042d1b16cbc876417f9d9ce1b53cc6565f87b6d1b53c4e3340cd`.

```lean
theorem mem_pivotCandidates_scale_reduce_iff
    {N p t r' : Nat} (hN : 0 < N) (hp : 0 < p) (_ht : 0 < t) :
    r' ∈ pivotCandidates N (t * p) ↔
      r' < t * (N * p) ∧
        r' % (N * p) ∈ pivotCandidates N p
```

## `mem_pivotBadResidues_scale_reduce_iff`

`LonelyRunner/Prompt99Scaling.lean:118`; SHA-256 `49131a7f9690042d1b16cbc876417f9d9ce1b53cc6565f87b6d1b53c4e3340cd`.

```lean
theorem mem_pivotBadResidues_scale_reduce_iff
    {N p t b r' : Nat} (hN : 0 < N) (hp : 0 < p) (ht : 0 < t) :
    r' ∈ pivotBadResidues N (t * p) (t * b) ↔
      r' < t * (N * p) ∧
        r' % (N * p) ∈ pivotBadResidues N p b
```

## `pivotCompleteCover_scale_iff`

`LonelyRunner/Prompt99Scaling.lean:148`; SHA-256 `49131a7f9690042d1b16cbc876417f9d9ce1b53cc6565f87b6d1b53c4e3340cd`.

```lean
theorem pivotCompleteCover_scale_iff
    {n N t : Nat} {a : Fin n → Nat} {j : Fin n} {C : Finset (Fin n)}
    (hN : 0 < N) (hp : 0 < a j) (ht : 0 < t) :
    PivotCompleteCover N (scaleSpeeds t a) j C ↔
      PivotCompleteCover N a j C
```

## `one_and_last_mem_pivotBadResidues_sdiff_pivotZeroResidues`

`LonelyRunner/PivotZeroKernel.lean:252`; SHA-256 `6487d679e2f8d84657827f01f1c98e232c997c62cb48dad5ac9c22db897df3b1`.

```lean
theorem one_and_last_mem_pivotBadResidues_sdiff_pivotZeroResidues
    (N p d : ℕ) (hN : 3 ≤ N) (hp : 0 < p) (hd : 0 < d) (hdp : d < p) :
    1 ∈ pivotBadResidues N p d \ pivotZeroResidues N p d ∧
      N * p - 1 ∈ pivotBadResidues N p d \ pivotZeroResidues N p d ∧
      1 ≠ N * p - 1
```

## `pivot_circleNorm_ge`

`LonelyRunner/PivotResidues.lean:195`; SHA-256 `362da5ab923f22e900ae7ac821dd4cf4aab91dfe70889987bc9e5a05d19c276a`.

```lean
theorem pivot_circleNorm_ge {N pivot r : ℕ} (hN : 0 < N)
    (hpivot : 0 < pivot) (hr : r ∈ pivotCandidates N pivot) :
    ((N : ℝ)⁻¹) ≤
      circleNorm (((r : ℝ) / ((N * pivot : ℕ) : ℝ)) * (pivot : ℝ))
```

## `outside_pivotBadResidues_circleNorm_ge`

`LonelyRunner/PivotResidues.lean:216`; SHA-256 `362da5ab923f22e900ae7ac821dd4cf4aab91dfe70889987bc9e5a05d19c276a`.

```lean
theorem outside_pivotBadResidues_circleNorm_ge {N pivot other r : ℕ}
    (hN : 0 < N) (hpivot : 0 < pivot)
    (hr : r ∈ pivotCandidates N pivot)
    (hgood : r ∉ pivotBadResidues N pivot other) :
    ((N : ℝ)⁻¹) ≤
      circleNorm (((r : ℝ) / ((N * pivot : ℕ) : ℝ)) * (other : ℝ))
```

## `exists_pivotCandidate_avoiding_ownerKernel_family`

`LonelyRunner/OwnerKernelCover.lean:19`; SHA-256 `bf4c025bcdcc178f4e9c94884314635e3d26697fe105a9a9a6a55ca1aa60f139`.

```lean
theorem exists_pivotCandidate_avoiding_ownerKernel_family
    {ι : Type*} [DecidableEq ι] (N p : ℕ) (C E : Finset ι) (d : ι → ℕ)
    (hN : 3 ≤ N) (hp : 0 < p)
    (hd : ∀ i ∈ C, 0 < d i) (hdp : ∀ i ∈ C, d i < p)
    (hEsub : E ⊆ C)
    (hdom : ∀ i ∈ C, (pivotZeroResidues N p (d i)).Nonempty →
      ∃ j ∈ E, pivotZeroResidues N p (d i) ⊆ pivotZeroResidues N p (d j))
    (hnum : 2 * (N + 1) * C.card + (N - 2) * E.card ≤ N * (N + 1)) :
    ∃ r ∈ pivotCandidates N p, ∀ i ∈ C, r ∉ pivotBadResidues N p (d i)
```

The scaling declarations establish membership/cover transport. They do not
by themselves export a cardinality formula for every arbitrary set difference.
The proposed N=7 three-owner noncover and its exceptional-denominator remainder
bound still require independent semantic review and implementation.
