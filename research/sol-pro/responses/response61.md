# PRO-A result

**Decision: `STOP` and freeze this exact route.**

`MinimalCounterexampleHeightCompression` remains `open`. The only nonredundant replacement with a complete reverse-witness proof is the coprime signed-divisor replacement. It applies to none of the tuples surviving the complete declared finite filter. The first unsupported implication is a structural assertion that least counterexamples must admit such a replacement.

No unrestricted Lonely Runner conclusion is obtained.

## 1. Exact status table

| Item                                                                                                             | Status                     | Exact strength                                                                                           |
| ---------------------------------------------------------------------------------------------------------------- | -------------------------- | -------------------------------------------------------------------------------------------------------- |
| Closed witness ↔ canonical pivot certificate                                                                     | `proved-lean`              | Exact closed `1/N` boundary; strict bad inequalities                                                     |
| Common scaling and primitive normalization                                                                       | `proved-lean`              | Witness existence is invariant under multiplication by a positive common integer                         |
| Small dimensions, bounded small-height branch, and `threeHeight_family_witness`                                  | `proved-lean`              | Includes the required `t>0`, `3t≤N`, height `≤N+t`, closed-boundary endpoint                             |
| Endpoint-safe positive-integer ↔ real reduction                                                                  | `proved-lean`              | Exact equivalence, not an unrestricted proof                                                             |
| Existence of a selected least-dimension primitive max/sum/lex counterexample, assuming any counterexample exists | `proved-math`              | Derived from well-ordering, scaling, sorting, and finite lex minimization                                |
| Every coordinate deletion of a selected counterexample has remaining gcd `1`                                     | `proved-math`              | Uses least dimension and the verified codimension-one divisor insertion theorem                          |
| Coprime signed-divisor all-pivot transport                                                                       | `proved-math`              | Every certificate of the normalized replacement transports, including a certificate at the changed pivot |
| Common-period mixed-sign transport                                                                               | `proved-math`              | Sound, but exactly subsumed by the signed-divisor operation                                              |
| Direct replacement `a↦a−N` with same-time lifting                                                                | `rejected`                 | Smallest exact failure: `(1,4,6)`                                                                        |
| Canonical fixed-pivot signed replacement with uniform all-pivot lifting                                          | `rejected`                 | Same smallest failure; filtered changed-pivot failure also occurs at `(1,4,5,6,7,11)`                    |
| The enumerated necessary residual conditions force a sound signed-divisor replacement                            | `rejected`                 | `(1,4,5,6,7,11)` survives all filters but has no eligible sound replacement                              |
| Finite sweep through `n=8`, height `40`                                                                          | `computed finite evidence` | 100,145,903 sorted tuples; exact integer arithmetic                                                      |
| “Every selected high counterexample admits a signed-divisor replacement”                                         | `conjectural`              | No derivation from minimality; finite residual evidence does not support it                              |
| Signed-divisor eligibility implies contradiction to minimality                                                   | `conditional`              | Complete once eligibility is assumed                                                                     |
| `HEIGHT-DESCENT`                                                                                                 | `open`                     | First unresolved arrow                                                                                   |
| `MinimalCounterexampleHeightCompression`                                                                         | `open`                     | Not proved in Lean or mathematics here                                                                   |

The project dependencies used above include exact scaling invariance, witness/certificate equivalence, changed-pivot coprime scaling, and the existing signed-divisor arithmetic characterization.

---

## 2. Fully quantified theorem contract

For `n≥1`, write `N=n+1`. For `a : Fin n → ℕ`, define

```text
Witness(n,a) :=
  ∃ τ : ℝ, ∀ i : Fin n,
    (N : ℝ)⁻¹ ≤ circleNorm(τ * (a i : ℝ)).

Counterexample(n,a) := ¬Witness(n,a).

NormalizedCounterexample(n,a) :=
  (∀ i, 0 < a i)
  ∧ StrictMono(a)
  ∧ gcd{a i : i∈Fin n} = 1
  ∧ Counterexample(n,a).
```

For two strictly increasing tuples `a,b : Fin n → ℕ`, define

```text
LexLt(a,b) :=
  ∃ k : Fin n,
    (∀ j<k, a j = b j) ∧ a k < b k.
```

Let

```text
M(a) := a(Fin.last (n-1)),
S(a) := ∑ i, a i.

KeyLt(a,b) :=
     M(a) < M(b)
  ∨ (M(a) = M(b) ∧ S(a) < S(b))
  ∨ (M(a) = M(b) ∧ S(a) = S(b) ∧ LexLt(a,b)).
```

The declared selection predicate is

```text
Selected(n,a) :=
  NormalizedCounterexample(n,a)

  ∧ [∀ m, 1 ≤ m → m < n →
       ∀ b : Fin m → ℕ,
         Function.Injective(b) →
         (∀ i, 0 < b i) →
         Witness(m,b)]

  ∧ [∀ b : Fin n → ℕ,
       NormalizedCounterexample(n,b) →
       ¬KeyLt(b,a)].
```

This encodes:

1. least moving dimension;
2. division by the common gcd;
3. increasing sorting;
4. minimization by maximum, then sum, then sorted lexicographic tuple.

The requested theorem is exactly:

```text
MinimalCounterexampleHeightCompression :

  ∀ n : ℕ, 1 ≤ n →
  ∀ a : Fin n → ℕ,
    Selected(n,a) →

    let N := n+1
    let M := a(Fin.last (n-1))

    M ≤ N
    ∨
    (N < M ∧ 3 * (M - N) ≤ N).
```

The subtraction occurs only under the explicit guard `N<M`.

Its direct-height corollary is

```text
M ≤ N + N / 3,
```

where natural-number division is `floor(N/3)`.

### Arithmetic equivalence

In the second branch, put `d=M-N`. Since `N<M`, natural subtraction is exact and `M=N+d`. From `3d≤N`, write `N=3q+r`, `0≤r<3`. If `d>q`, then

```text
3d ≥ 3(q+1) = 3q+3 > 3q+r = N,
```

a contradiction. Therefore `d≤q=N/3`, so

```text
M=N+d≤N+N/3.
```

Conversely, if `N<M≤N+N/3`, then `M-N≤N/3`, hence

```text
3(M-N) ≤ 3(N/3) ≤ N.
```

Thus the guarded statement is the subtraction-safe form of the requested height bound.

---

## 3. Complete new `proved-math` lemmas

### 3.1 Selection exists whenever a counterexample exists

**Lemma.**

```text
(∃ n≥1, ∃a, Counterexample(n,a)
 ∧ positive(a) ∧ injective(a))
→
∃ n≥1, ∃a, Selected(n,a).
```

**Proof.**

Let

```text
D = {n≥1 : some positive injective integer n-tuple is a counterexample}.
```

By hypothesis, `D` is nonempty. The well-ordering of `ℕ` gives its least member `n₀`.

Take any counterexample in dimension `n₀`. Sorting its entries merely permutes the quantified coordinates, so it preserves witness existence and nonexistence. Let `g` be its positive common gcd and divide every entry by `g`. The resulting tuple remains positive and injective. Common scaling preserves witness existence in both directions, so it remains a counterexample. Its common gcd is `1`. Thus a normalized increasing counterexample exists in dimension `n₀`. The scaling equivalence is already kernel-checked.

Among normalized increasing counterexamples in dimension `n₀`, choose the least maximum `M₀`. Among those with maximum `M₀`, choose the least sum `S₀`. There are only finitely many strictly increasing positive `n₀`-tuples with maximum `M₀`, so the nonempty subset having sum `S₀` has a lexicographically least member `a`.

Minimality of `n₀` gives the lower-dimensional clause of `Selected`; the construction of `a` gives the max/sum/lex clause. Therefore `Selected(n₀,a)` holds. ∎

This derives the selection premise rather than assuming a free-standing “minimal counterexample.”

### 3.2 Deletion-gcd restriction

**Lemma.** Let `a` be selected in moving dimension `n≥3`. For every coordinate `j`,

```text
gcd{a i : i≠j}=1.
```

**Proof.**

Fix `j` and let

```text
D = gcd{a i : i≠j}.
```

Suppose `D≥2`. Since the entire tuple is primitive, `D` is coprime to `a j`: any divisor common to `D` and `a j` divides every coordinate, hence divides the total gcd `1`.

Delete coordinate `j`, divide every remaining coordinate by `D`, and call the resulting `(n−1)`-tuple `b`. It is positive and injective. Because `a` has least counterexample dimension, `b` has a witness at threshold `1/n`.

The verified codimension-one insertion theorem applies because:

```text
D≥2,
D divides every deleted-family speed,
gcd(D,a j)=1,
n−1≥2.
```

Its mesh inequality is automatic in old dimension at least two, and its completed insertion theorem lifts the `(n−1)`-dimensional witness to the original `n`-tuple at threshold `1/(n+1)`. This contradicts `Counterexample(n,a)`. Therefore `D=1`. ∎

The exact divisor-insertion constructor and witness theorem are kernel-checked in the project.

### 3.3 Signed congruence preserves a lower-pivot decision

**Lemma.** For positive modulus `m`, if

```text
m ∣ a-b  or  m ∣ a+b,
```

then for every natural `r`,

```text
cyclicResidueDistance(m,r*a)
=
cyclicResidueDistance(m,r*b).
```

**Proof.**

If `m∣a-b`, multiplication by `r` gives `ra≡rb (mod m)`, so the residues and cyclic distances are equal.

If `m∣a+b`, then `ra≡−rb (mod m)`. Write `u=rb mod m`. The residue of `−rb` is `0` when `u=0`, and `m-u` otherwise. Since

```text
min(u,m-u)=min(m-u,u),
```

the cyclic distance is unchanged. ∎

### 3.4 Coprime signed-divisor all-pivot transport

Let the old tuple be

```text
A = (x₁,…,xₙ₋₁,a)
```

and the replacement be

```text
B = (x₁,…,xₙ₋₁,b).
```

Assume

```text
0<b<a,
a=q*b,
gcd(q,N)=1,
```

and for every lower speed `x`,

```text
N*x ∣ a-b  or  N*x ∣ a+b.                 (SD)
```

Also require positivity and injectivity of `B`.

**Lemma.**

```text
Witness_N(B) → Witness_N(A).
```

**Proof.**

Take a witness for `B`. By the exact closed-boundary equivalence, it yields a pivot certificate for `B`. Split according to that certificate’s pivot.

**Lower pivot `x`.** Keep the same numerator `r`. All unchanged lower coordinates retain exactly the same modular decision. The only changed coordinate is `b→a`. Condition `(SD)` and the preceding signed-congruence lemma give

```text
cycDist(N*x,r*a)=cycDist(N*x,r*b).
```

Thus the certificate remains valid for `A` at pivot `x`.

**Changed pivot `b`.** Let `r` be the certificate numerator at modulus `N*b`, and use `s=q*r` at the old pivot `a=q*b`.

Candidate membership is preserved:

```text
r<N*b  ⇒  q*r<N*q*b=N*a,
N∤r and gcd(q,N)=1  ⇒  N∤q*r.
```

For each lower speed `x`,

```text
cycDist(N*a,s*x)
 = cycDist(q*(N*b),q*(r*x))
 = q*cycDist(N*b,r*x)
 ≥ q*b
 = a.
```

Therefore `s` is an old-tuple certificate at pivot `a`. The homogeneity and candidate-scaling facts used here are already kernel-checked.

In either pivot case, `A` has a certificate, hence a witness. ∎

**Normalization corollary.** If the raw replacement has common gcd `d`, write `B=dB₀`. A witness for primitive `B₀` gives a witness for raw `B` by common time rescaling; the lemma then gives a witness for `A`.

**Descent.** Replacing the unique maximum `a` by `b<a` makes the raw maximum strictly less than `a`. Dividing by `d≥1` cannot increase it. Hence the normalized replacement strictly lowers the first component of the declared key. Sum and lexicographic tie-breakers are not needed.

Therefore:

```text
Selected(A) ∧ eligible signed-divisor replacement
→ contradiction.
```

This implication is `conditional` but complete.

### 3.5 Common-period mixed-sign replacement adds no scope

The checker also tested the following operation. Let

```text
L=lcm(x₁,…,xₙ₋₁).
```

Require

```text
N*L ∣ a-b  or  N*L ∣ a+b,
N*b ∣ a-b  or  N*b ∣ a+b.                 (CP)
```

The first condition preserves all lower pivots because every lower `x` divides `L`. The second preserves a certificate whose pivot is `b`. Therefore its local transport is valid.

However, `(CP)` is a special case of the signed-divisor operation.

If `N*b∣a-b`, then for some `k`,

```text
a-b=k*N*b,
a=(kN+1)b.
```

Thus `a=q*b` with `q≡1 (mod N)`, so `gcd(q,N)=1`.

If `N*b∣a+b`, then

```text
a+b=k*N*b,
a=(kN-1)b,
```

so `q≡−1 (mod N)` and again `gcd(q,N)=1`.

The lower common-period condition supplies the signed compatibility required at every lower speed. Hence this route is sound but cannot cover a tuple not already covered by the signed-divisor route.

### 3.6 Height compression would complete the contradiction

A selected counterexample has `n≥3`, since moving dimensions one and two are already proved.

Let `M=max(a)`.

**Branch `M≤N`.** Every coordinate is at most `N=n+1<n+2`. The verified bounded-height theorem applies and supplies the closed `1/N` witness.

**Branch `N<M` and `3(M-N)≤N`.** Put

```text
t=M-N.
```

The guard gives `t>0`, and

```text
M=N+t,
∀i, a i≤N+t,
3t≤N.
```

The exact theorem `threeHeight_family_witness` therefore supplies the required closed `1/N` witness.

Either branch contradicts the selected tuple’s counterexample clause. Thus every implication after `MinimalCounterexampleHeightCompression` is complete.

---

## 4. Height-descent attempts

### Attempt A: direct top subtraction

Define

```text
b=a-N
```

when `a>N`, rejecting collisions and normalizing afterward.

This always lowers the maximum when defined, but has no phase-preservation mechanism.

The smallest exact failed certificate transport in the declared order is

```text
A=(1,4,6),  n=3,  N=4,
B=(1,2,4).
```

At pivot `4`, numerator `r=5` is a certificate for `B`. Modulo `16`, its distance numerators are

```text
B: (5,6,4),
```

all at least `4`. For `A`, speed `6` has

```text
5*6 ≡ 14 mod 16,
cyclic distance = 2 < 4.
```

Thus time `5/16` does not lift. The exact failed implication is the same-time reverse certificate statement, not the bare fact that this particular original tuple has no witness.

Status: `rejected`.

### Attempt B: canonical fixed-pivot signed reduction

For a chosen unchanged pivot `p`, put `D=Np` and replace `a` by its least positive signed representative

```text
b=min(a mod D, D-(a mod D)).
```

This preserves the changed coordinate’s phase on the selected `p`-grid. It does not control certificates based at any other pivot.

Its smallest failure is again

```text
A=(1,4,6), p=1, D=4, b=2,
B=(1,2,4),
```

with the pivot-`4`, numerator-`5` certificate above.

More importantly, the sole fully filtered high residual gives an exact changed-pivot failure:

```text
A=(1,4,5,6,7,11),
B=(1,3,4,5,6,7).
```

At the replacement’s pivot `4`, `r=13` gives modulus `28` and original distance numerators

```text
(13,4,9,6,7,3).
```

The final coordinate needs distance at least `4` but has distance `3`.

Status: `rejected`.

### Attempt C: coprime signed-divisor replacement

This is the operation from §3.4. It is the only nonredundant operation tested that has a complete every-pivot reverse proof.

It succeeds nonvacuously on the stress tuple

```text
A=(1,2,3,60), N=5,
b=30, q=2.
```

Here `gcd(2,5)=1`, and `60-30=30` is divisible by `5`, `10`, and `15`. The checker exhaustively transported all 16 certificates of the normalized replacement.

It is nevertheless absent on the complete filtered residual and on the tracked tuple

```text
(15,21,40,48,56,105,126,280,1200).
```

Status: local lemma `proved-math`; uniform applicability `open`.

### Attempt D: common-period mixed signs

This passed a nonvacuous six-certificate regression at

```text
A=(1,3,10), N=4, b=2, L=3,
12 ∣ 10+2,
8  ∣ 10-2.
```

As proved above, it is a strict specialization of Attempt C and adds no independent descent mechanism.

---

## 5. Deterministic exact sweep

### Audit metadata

| Field                  | Recorded value                                                             |
| ---------------------- | -------------------------------------------------------------------------- |
| Repository baseline    | `88c88789f5a503ad24adf54949fb330e88a70f35`                                 |
| Checker                | `prompt61-height-checker-v1.2.0`                                           |
| Compiler               | GCC `14.2.0`, C++20, `-O3 -march=native -DNDEBUG`                          |
| Domain                 | Every primitive strictly increasing tuple, `3≤n≤8`, maximum `≤40`          |
| Enumeration order      | `n` ascending, maximum ascending, lower tuple lexicographic                |
| Smallest-failure order | `(n, maximum, sum, tuple, parameter, pivot, numerator, failed coordinate)` |
| Boundary               | distance `≥pivot` good; distance `<pivot` bad                              |
| Runtime                | `5,896,358 μs`                                                             |
| Source SHA-256         | `ab2aa75e019f407aa774ee65afb920a005be25a167db028828cb0e1aa6520084`         |
| Output SHA-256         | `8ed01720195b118e9a3b2b3b5e171c9f7076ca98ea572837dace3482feca5bc2`         |

The divisor-cover and fastest-pivot filters are exact necessary conditions already present in the formal project; equality remains good throughout.

### Successive stage counts

The fastest columns are applied successively: ratio restriction, extremal interval restriction, then exact absence of a certificate on the fastest grid.

|       `n` |      All sorted |      Primitive |  Modulus cover |    Fast ratio | Fast interval | No fast certificate | All deletion gcds `1` | Above target |
| --------: | --------------: | -------------: | -------------: | ------------: | ------------: | ------------------: | --------------------: | -----------: |
|         3 |           9,880 |          8,410 |          3,177 |         1,655 |         1,125 |                   0 |                     0 |            0 |
|         4 |          91,390 |         85,771 |         27,600 |        14,408 |        11,856 |                   0 |                     0 |            0 |
|         5 |         658,008 |        641,166 |        203,431 |       109,145 |        95,178 |                   1 |                     0 |            0 |
|         6 |       3,838,380 |      3,797,877 |        861,477 |       431,305 |       387,462 |                   1 |                     1 |            1 |
|         7 |      18,643,560 |     18,564,316 |      3,965,253 |     1,905,549 |     1,765,047 |                   0 |                     0 |            0 |
|         8 |      76,904,685 |     76,777,427 |     13,431,573 |     6,160,232 |     5,845,593 |                   0 |                     0 |            0 |
| **Total** | **100,145,903** | **99,874,967** | **18,492,511** | **8,622,294** | **8,106,261** |               **2** |                 **1** |        **1** |

The two tuples with no fastest-pivot certificate were

```text
(6,18,24,30,37)
(1,4,5,6,7,11).
```

The first fails the deletion-gcd condition: deleting `37` leaves gcd `6`.

The sole final high residual was

```text
R=(1,4,5,6,7,11),
n=6, N=7,
max(R)=11 > 7+floor(7/3)=9.
```

It is not a counterexample. Pivot `6`, numerator `13`, gives time

```text
t=13/(7*6)=13/42
```

with exact distance numerators modulo `42`

```text
(13,10,19,6,7,17),
```

all at least `6`.

Thus the declared necessary conditions do not force a sound descent, and they do not characterize counterexamples.

### Operations on the sole final residual

| Operation                   |                       Defined | Structural descent | Reverse audit                      |
| --------------------------- | ----------------------------: | -----------------: | ---------------------------------- |
| `a−N`                       | No, because `11−7=4` collides |                  — | —                                  |
| Fixed signed representative |                           Yes |                Yes | Failed at first tested certificate |
| Coprime signed divisor      |                            No |                  — | —                                  |
| Common-period mixed sign    |                            No |                  — | —                                  |

The union of the two sound operations covered **0 of 1** final residuals.

The stress suite also covered:

```text
(1,…,n) for every 3≤n≤8
(1,3,4,7)
(1,2,3,60)
(1,2,6,8,10)
(4,6,24)
(5,28,35,40,68,88,108,148,165)
(8,15,35,40,48,56,75,132,147)
(15,21,40,48,56,105,126,280,1200)
(1,9,10,11,12)
(1,2,3,4,5,7)
(1,2,3,4,5,6,7,8,9,11)
(1,3,10).
```

Every defined passing operation was audited against every certificate of the normalized replacement. Rejected operations stopped at their first exact failed certificate.

---

## 6. Exact implication chain

| Arrow                                                                                                        | Status                                      |
| ------------------------------------------------------------------------------------------------------------ | ------------------------------------------- |
| Hypothetical positive-integer counterexample → selected least-dimension primitive max/sum/lex counterexample | `proved-math`, §3.1                         |
| Selected counterexample → `MinimalCounterexampleHeightCompression`                                           | **`open`**                                  |
| Guarded compression → `max≤N+floor(N/3)`                                                                     | `proved-math`, arithmetic above             |
| Height bound → small-height witness or `threeHeight_family_witness`                                          | `proved-math` using `proved-lean` endpoints |
| Witness → contradiction                                                                                      | Definition of counterexample                |
| No positive-integer counterexample → `PositiveIntegerConjecture`                                             | Direct unfolding                            |
| `PositiveIntegerConjecture` → endpoint-safe real formulation                                                 | `proved-lean` exact equivalence             |

The last equivalence is explicitly kernel-checked as

```text
Conjecture ↔ PositiveIntegerConjecture.
```

### First unsupported implication

For the selected tuple

```text
A=(x₁,…,xₙ₋₁,a),  N=n+1,
a>N+floor(N/3),
```

the first missing statement is exactly:

```text
∃ b q : ℕ,
  0 < b
  ∧ b < a
  ∧ b ∉ {x₁,…,xₙ₋₁}
  ∧ a = q*b
  ∧ Nat.Coprime q N
  ∧ ∀i,
      N*xᵢ ∣ a-b
      ∨
      N*xᵢ ∣ a+b.
```

Everything after this existential statement is complete: positivity, injectivity, primitive normalization, strict maximum descent, every-pivot reverse witness transport, and contradiction to selected minimality.

Nothing presently derives that existential statement from the declared selection order. Adding it as a “minimal-counterexample property” would merely assume the missing content.

---

## 7. Only admissible next Lean declaration

No new declaration was compiled, so this remains `proved-math`, not `proved-lean`. The only non-target declaration worth formalizing is the local transport theorem:

```lean
theorem exists_appended_witness_of_coprime_signed_top_replacement
    {n N a b q : ℕ}
    (lower : Fin n → ℕ)
    (hN : 2 ≤ N)
    (hlower : ∀ i, 0 < lower i)
    (hb : 0 < b)
    (hq : 0 < q)
    (ha : a = q * b)
    (hcop : Nat.Coprime q N)
    (hsigned :
      ∀ i, SignedDivisorCompatible N (lower i) a b)
    (hwitness :
      ∃ t : ℝ, ∀ i : Fin (n + 1),
        (N : ℝ)⁻¹ ≤
          circleNorm
            (t * (appendNatSpeed lower b i : ℝ))) :
    ∃ t : ℝ, ∀ i : Fin (n + 1),
      (N : ℝ)⁻¹ ≤
        circleNorm
          (t * (appendNatSpeed lower a i : ℝ))
```

This is not a renamed height-compression theorem. It packages the exact reverse invariant needed after an eligible replacement has been found.

Under the stated budget, I do **not** recommend spending the one Lean prototype on `HEIGHT-DESCENT` itself. The structural eligibility premise must first be derived noncircularly.

## 8. Stop decision

**`STOP`: freeze PRO-A minimal-counterexample height compression at this point.**

The stop condition is met for three independent reasons:

1. Both broad natural replacements fail the changed-pivot audit at the exact smallest tuple `(1,4,6)`.
2. The only sound nonredundant operation applies to no final residual in the complete declared sweep.
3. The sole surviving residual satisfies every enumerated necessary restriction yet admits no sound replacement; recovering the route would require a genuinely new consequence of full max/sum/lex minimality.

No unrestricted theorem, positive-integer theorem, or height-compression theorem is claimed.

### Audit artifacts

[Deterministic C++ checker](sandbox:/mnt/data/prompt61_height_checker.cpp)

[Complete exact sweep output](sandbox:/mnt/data/prompt61_height_sweep.txt)

[Environment and hash manifest](sandbox:/mnt/data/prompt61_height_manifest.txt)
