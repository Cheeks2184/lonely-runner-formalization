# Prescribed small phase: settled implementation decomposition

This is a source-only implementation plan for the orbit step in the accepted
one-three-divisible manuscript. Its mathematical scope is unchanged. The
underlying argument and its independent review are bound below; the proposed
Lean snippets here have **not** been elaborated. No source implementation,
compiler, numerical experiment, search over speeds, state/Git edit, or cache
operation was performed. Only this report was written.

## 1. Three declarations suffice

Use one new module, provisionally `LonelyRunner/SmallPhaseOrbits.lean`, with
`RationalShiftGcd` and the mathlib APIs listed below available. Existing
`RationalShiftGcd`, `RationalShiftOrbits`, and `DivisorInsertion` need no edits.
The suggested surface consists of a reusable exact-phase theorem, a private
natural-number bound, and the requested public wrapper. These are declarations
inside `namespace LonelyRunner`, not new namespaces named after source files.

```lean
theorem exists_nat_coprime_grid_fract_eq
    (c n m : ℕ) (hn : 0 < n) (hc : Nat.Coprime c n) (hm : m < n) :
    ∃ k : ℕ, k < n ∧
      Int.fract ((k : ℝ) * (c : ℝ) / (n : ℝ)) = (m : ℝ) / (n : ℝ)

private theorem small_phase_numerator_bounds (n : ℕ) (hn : 7 ≤ n) :
    let m : ℕ := (n + 11) / 12
    0 < m ∧ m < n ∧ n ≤ 12 * m ∧ 6 * m ≤ n

theorem exists_reciprocal_time_small_phase
    (A q : ℕ) (hq : 0 < q) (hcop : Nat.Coprime q 6)
    (hnot : ¬ q ∣ A) :
    ∃ k : ℕ, k < q ∧
      (((1 : ℝ) / 12 ≤ Int.fract ((k : ℝ) * (A : ℝ) / (q : ℝ)) ∧
        Int.fract ((k : ℝ) * (A : ℝ) / (q : ℝ)) ≤ (1 : ℝ) / 6) ∨
       Int.fract ((k : ℝ) * (A : ℝ) / (q : ℝ)) = (1 : ℝ) / 5)
```

The exact-phase theorem allows `n=1`, `m=0`, and every compatible `c`, including
`c=0` when `n=1`. It needs no primality or coprimality between `m` and `n`.
The wrapper retains the original positive denominator, composite denominators
coprime to six, strict natural index bound, closed band, and exact `1/5`
alternative. Neither `A>0` nor an extra gcd-one assumption belongs in its
contract. The given `hnot` already excludes `A=0` and `q=1` where necessary.

## 2. Exact library APIs: residue realization is already available

The decisive existing theorem is in
`.lake/packages/mathlib/Mathlib/Data/Int/GCD.lean:144`:

```lean
Nat.exists_mul_mod_eq_of_coprime {k n : ℕ} (r : ℕ)
    (hkn : Nat.Coprime n k) (hk : k ≠ 0) :
    ∃ m < k, n * m % k = r % k
```

It is a natural-index theorem despite its source file's name. Its source proof
handles modulus one separately and otherwise obtains an inverse and reduces
the inverse times `r` modulo `k`. Its upstream APIs, read in the same file, are:

```lean
Nat.gcd_eq_gcd_ab (x y : ℕ) :
    (Nat.gcd x y : ℤ) = x * Nat.gcdA x y + y * Nat.gcdB x y

Nat.exists_mul_mod_eq_gcd {k n : ℕ} (hk : Nat.gcd n k < k) :
    ∃ m < k, n * m % k = Nat.gcd n k

Nat.exists_mul_mod_eq_one_of_coprime {k n : ℕ}
    (hkn : Nat.Coprime n k) (hk : 1 < k) :
    ∃ m < k, n * m % k = 1
```

Thus the proposed helper should invoke the first API directly. There is no
need for a new ZMod permutation, explicit Bézout witness declaration, or signed
`natMod` adapter. The inspected source proves the same inverse construction
as the accepted argument, with its natural range already checked.

The corresponding exact fractional-part API is in
`Mathlib/Algebra/Order/Floor/Ring.lean:531`. Specialized to the real field, its
type is:

```lean
Int.fract_div_natCast_eq_div_natCast_mod {m n : ℕ} :
    Int.fract ((m : ℝ) / (n : ℝ)) = ((m % n : ℕ) : ℝ) / (n : ℝ)
```

It has no positive-denominator hypothesis of its own; the orbit selection uses
`hn`. The division here is **real division of cast naturals**. This is distinct
from the natural division defining the selected numerator.

Recipe for `exists_nat_coprime_grid_fract_eq`:

1. Invoke
   `Nat.exists_mul_mod_eq_of_coprime (k := n) (n := c) m hc hn.ne'`.
   Rename its witness to `k`, obtaining `hk : k < n` and
   `hres : c * k % n = m % n`.
2. Use `Nat.mul_comm` and `Nat.mod_eq_of_lt hm` to obtain
   `hres' : (k * c) % n = m`. Use a short `calc` if a permutative `simp` obscures
   the multiplication orientation.
3. Instantiate the fractional-part API at natural numerator `k*c` and modulus
   `n`. Rewrite `Nat.cast_mul` and `hres'`. Its conclusion is exactly the
   desired fractional equality. Return the same `k` and `hk`.

This is the entire orbit helper proof. No real interval argument, integer
representative, negative quotient cast, or additional hypothesis is needed.

## 3. Natural numerator arithmetic

Define `m : ℕ := (n+11)/12` and `r : ℕ := (n+11)%12`. The exact division APIs
in the pinned Lean source give:

```lean
Nat.mod_add_div (a b : ℕ) : a % b + b * (a / b) = a
Nat.div_le_self (a b : ℕ) : a / b ≤ a
```

Using `Nat.mod_lt (n+11) (by decide : 0 < 12)` and `Nat.mod_add_div (n+11) 12`,
record these explicit local facts before invoking linear arithmetic:

`r < 12`, `r + 12*m = n+11`, hence `n ≤ 12*m` and `12*m ≤ n+11`.

The first inequality follows from `r≤11`; the second uses `r≥0`. Together
with `n≥7`, the first implies `m>0`.

For the upper bound `6*m≤n`, split only at `n<12`:

* If `7≤n<12`, the same equation gives `12*m≤22`, while `m>0`, so `m=1`.
  Then `6*m≤n`.
* If `12≤n`, use `12*m≤n+11≤2*n` and cancel the positive constant two to
  obtain `6*m≤n`.

Finally `m>0` implies `m<6*m≤n`. These are natural linear inequalities with
constant coefficients; `omega` can discharge each step once the quotient and
remainder facts are explicitly supplied. There is no need to ask a tactic to
unfold division recursively or enumerate values of `n`. This proof is exactly
the accepted ceiling argument, with the ceiling represented by natural
`(n+11)/12`.

Do not change `m` to `((n : ℝ)+11)/12`: that loses rounding. First establish
the natural inequalities above, then cast them when proving real band bounds.

## 4. Gcd wrapper: local facts and orientations

Reuse the local setup already present in
`LonelyRunner/RationalShiftGcd.lean:19`–57. Keep it local to the final theorem;
extracting a new public gcd structure is unnecessary for this task.

Set

```lean
let g : ℕ := Nat.gcd q A
let n : ℕ := q / g
let c : ℕ := A / g
```

Build the following facts in this order:

| Local fact | Inspected API / proof recipe |
| --- | --- |
| `hg : 0 < g` | `Nat.gcd_pos_of_pos_left A hq` |
| `hgq : g ∣ q` | `Nat.gcd_dvd_left q A` |
| `hgA : g ∣ A` | `Nat.gcd_dvd_right q A` |
| `hqeq : q = g*n` | symmetry of `Nat.mul_div_cancel' hgq` |
| `hAeq : A = g*c` | symmetry of `Nat.mul_div_cancel' hgA` |
| `hnpos : 0 < n` | `Nat.div_gcd_pos_of_pos_left A hq`, after unfolding `n,g` |
| `hnle : n ≤ q` | `Nat.div_le_self q g` |
| `hnone : n ≠ 1` | `n=1` and `hqeq` imply `q=g`; then `hgA` contradicts `hnot` |
| `hntwo : 1 < n` | `hnpos`, `hnone`, natural linear arithmetic |
| `hcn : Nat.Coprime c n` | symmetry of `Nat.coprime_div_gcd_div_gcd hg`, with original arguments `q,A` |
| `hndvd : n ∣ q` | witness `g`, using `hqeq` and `Nat.mul_comm` |
| `hn6 : Nat.Coprime n 6` | `Nat.Coprime.of_dvd_left hndvd hcop` |

The relevant exact signatures, with implicit naturals displayed, are:

```lean
Nat.gcd_pos_of_pos_left {m : ℕ} (n : ℕ) (mpos : 0 < m) :
    0 < Nat.gcd m n
Nat.div_gcd_pos_of_pos_left (b : ℕ) (h : 0 < a) :
    0 < a / Nat.gcd a b
Nat.mul_div_cancel' {n m : ℕ} (H : n ∣ m) : n * (m / n) = m
Nat.coprime_div_gcd_div_gcd (H : 0 < Nat.gcd m n) :
    Nat.Coprime (m / Nat.gcd m n) (n / Nat.gcd m n)
Nat.Coprime.of_dvd_left (ha : a₁ ∣ a₂) (h : Nat.Coprime a₂ b) :
    Nat.Coprime a₁ b
Nat.not_coprime_of_dvd_of_dvd (dgt1 : 1 < d)
    (Hm : d ∣ m) (Hn : d ∣ n) : ¬ Nat.Coprime m n
```

The first quotient produced by the gcd-coprime API is `q/g`, not `A/g`.
The `.symm` in the recipe is essential for the residue API's coefficient-first
orientation. All quotients in this table are natural quotients before casting.

Next derive `n=5 ∨ 7≤n`. From `hn6`, use
`Nat.not_coprime_of_dvd_of_dvd` with divisors two and three to prove
`¬ 2 ∣ n` and `¬ 3 ∣ n`; the corresponding divisibilities of six have explicit
witnesses three and two. These exclude `n=2,4,6` and `n=3`. Since `1<n`, if
`n<7` the only remaining value is five. Implementation may use
`Nat.dvd_iff_mod_eq_zero` to turn the two nondivisibilities into
`n%2 ≠ 0` and `n%3 ≠ 0`, then use `omega` with `hntwo`. This is a bounded
symbolic exclusion, not an assumption that nonzero residues are units.

The equality of real ratios should also be established once:

```lean
hphase : (A : ℝ) / (q : ℝ) = (c : ℝ) / (n : ℝ)
```

Rewrite `hAeq,hqeq`, push the casts of products, and cancel the nonzero real
cast of `g`. This is the same `field_simp` step already checked in
`RationalShiftGcd.lean`. Supply `hgR : (g : ℝ) ≠ 0` and, if needed for a
chosen normalization, `hnR : 0 < (n : ℝ)`. The identity holds even without a
positivity assumption on `A`.

## 5. Choose the target residue and finish

If `n=5`, use `m=1`; `m<n` follows immediately. The exact-phase helper gives
`k<n` and `f(k*c/n)=1/n=1/5`. The strict final bound is
`hk.trans_le hnle : k < q`, not merely `k≤q`.

If `7≤n`, let `m=(n+11)/12` and apply the private numerator bound. Use its
`m<n` to apply the same exact-phase helper. Cast `n≤12*m` and `6*m≤n` to
real inequalities. The exact positive-denominator API is

```lean
div_le_div_iff₀ (hb : 0 < b) (hd : 0 < d) :
    a / b ≤ c / d ↔ a * d ≤ c * b
```

For the lower band, instantiate the denominators as `12,n`, giving the
equivalent inequality `1*n≤m*12`. For the upper band use `n,6`, giving
`m*6≤1*n`. Each follows from the cast natural bound and commutativity. All
denominators are positive; there is no reversal of either comparison and no
strict inequality replacing the required closed endpoints.

In either branch transport the helper's equality to the original ratio via

`(k:ℝ)*(A:ℝ)/(q:ℝ) = (k:ℝ)*((A:ℝ)/(q:ℝ))
 = (k:ℝ)*((c:ℝ)/(n:ℝ)) = (k:ℝ)*(c:ℝ)/(n:ℝ)`.

The first and last equalities are `mul_div_assoc` in the appropriate direction;
the middle equality is `hphase`. Apply `Int.fract` to this equality and compose
with the helper result. Return the original natural `k`, its strict bound
`k<n≤q`, and the selected disjunct. A rewriting tactic should target this
scalar identity, not unfold the definitions of fractional part or gcd.

No new mathematical obligation is hidden in this composition: the inverse is
an existing theorem, the numerator bound is proved in section 3, and the gcd
reduction is the inspected existing local pattern. The remaining work is
ordinary Lean implementation and subsequent source/type/trust verification.
This task supplies no new runner theorem. Integration remains within canonical
N=6, followed by the standing transition to uniform arbitrary-N research.

## 6. Source-only provenance

Current configuration, workflow, policy, and focused state were read. The task
record was `/root/one_three_orbit_contract_plan`, requested Astra/xhigh, source
checkpoint `84d14b3`, with this file as its only owned output. State remained
`research` / `in_progress`. `python3 scripts/validate_workflow.py` actually
returned exit 0 with full stdout:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

Only static reads, text searches, hashes, and this report edit followed. Two
early source lookups named an absent alternative review filename and an old
toolchain-directory guess; they returned file-not-found diagnostics. The
successful bindings below use the actual reviewed filename and the pinned
`leanprover/lean4:v4.32.1` source directory. No compiler was launched or retried.

The table binds every source used for the decisive API signatures and recipes.
`ML/` expands to `.lake/packages/mathlib/Mathlib/`; `Init/` expands to
`/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/src/lean/Init/`.
Hashes were read using `sha256sum`; they are byte provenance, not proof checks.

| Source | SHA-256 |
| --- | --- |
| `research/astra-one-three-divisible-plan.md` | `9da230600af3a0a0bc8223de3daca2575f8d41f447142687ca64db53ced4ae9e` |
| `research/astra-one-three-divisible-review.md` | `8f720fbd8002918adaaa0d36fc7774c450eeb5dba84dd555552d24b5e57e6078` |
| `LonelyRunner/RationalShiftGcd.lean` | `6e9d1e3e084188a651e4c875cf36fd5d6fc7cbd5f1914784019a207a0cec01f4` |
| `LonelyRunner/RationalShiftOrbits.lean` | `cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591` |
| `LonelyRunner/DivisorInsertion.lean` | `212fa6d879bab6d70f09a4a43b2027b96724b5e5ac4a22cdf4b368509973166f` |
| `ML/Data/Int/GCD.lean` | `13cf17d1beed6c6a24bd471065f461a2449f6eb55101ff5a6e6828d7be28b568` |
| `ML/Algebra/Order/Floor/Ring.lean` | `11f61aaf83c406b6b0accc6d34bdb4f77a1566fbdc63eae4d704728b9acf038c` |
| `ML/Data/Nat/GCD/Basic.lean` | `c46b9173200adac93cefa0f8d9ee02306930771a1960796335c32455f719c3ac` |
| `ML/Algebra/Order/GroupWithZero/Basic.lean` | `74671293c3d7b461d91e80e5f9008571c327937c441846a49d6fc7ab5bc9a6b6` |
| `Init/Data/Nat/Coprime.lean` | `05b67b9e50bb0b92ba80dc4a8074580c14a8bdcdbdc150486f4796d104c8426a` |
| `Init/Data/Nat/Gcd.lean` | `672c96102205b59a47742be74c959ed780ba319713baaa8a2eeede2cdc46cbea` |
| `Init/Data/Nat/Div/Basic.lean` | `67f894497257111dff81a5b3bab0f849cc53f31a3c62656333366ad62ab63a58` |
| `Init/Data/Nat/Dvd.lean` | `12cd37a3909fddc05c1f5541662d1a099c083aa1084777ded9d583c7a6780f96` |
| `lean-toolchain` | `8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af` |
| `lake-manifest.json` | `887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218` |
