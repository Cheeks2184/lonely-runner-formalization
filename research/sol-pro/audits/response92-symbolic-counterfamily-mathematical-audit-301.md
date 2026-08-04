# Response 92 symbolic counterfamily: independent mathematical audit

- **Task:** `P92-SYMBOLIC-COUNTERFAMILY-MATHEMATICAL-AUDIT-301`
- **Base commit:** `6fb384d24ad4d8bc04013d8a7117d8d9d526f0b5`
- **Scope:** independent hand audit of the symbolic family stated in `response92.md`
- **Quarantine boundary:** no quarantined code, JSON, or ZIP payload was opened, extracted, imported, or executed. The recovery audit and text manifest were read only to identify provenance and the quarantine boundary.
- **Disposition recommendation:** accept the symbolic family, the exact `n = 6` arithmetic, and the resulting refutation of the sole Prompt 92 lemma as `proved-math-qualified`. This is not a Lean proof and is not evidence against the Lonely Runner Conjecture.

## 1. Claim table

| Claim | Audit result | Recommended evidence label | Qualification |
|---|---|---|---|
| For every integer `E >= 3`, the displayed six-label family satisfies the Prompt 92 canonical-representative and deletion-gcd premises for `q = 2^E`, `M = 7q` | proved below | `proved-math-qualified` | Repeated labels are intentionally allowed by the Prompt 92 target |
| Its six strict bad sets cover every residue `r mod M` | proved below | `proved-math-qualified` | Includes zero, antipodes, nonunits, collisions, and strict equality boundaries |
| The labelled product has `2`-adic valuation `E - 1`, hence is not divisible by `q` | proved below | `proved-math-qualified` | In fact the product is congruent to `q/2 mod q` |
| For the frozen `n = 6` threshold, `E_6 = 117` and the displayed decimal tuple is the corresponding family | proved below | `proved-math-qualified` | All displayed `n = 6` decimal values used here agree with exact integer arithmetic |
| The `E = 117` instance is a counterexample in the exact domain of Prompt 92's sole lemma | proved below | `proved-math-qualified`; target disposition `refuted` | Sol High retains final status authority |
| The same instance refutes the aggregate bridge stated in Response 87 | proved by statement comparison plus the construction below | `proved-math-qualified`; bridge disposition `refuted` | This applies only because the audited Response 87 bridge has the same threshold, modulus, repeated-label domain, deletion-gcd premise, strict full-grid cover premise, and divisibility conclusion |
| The family refutes unrestricted LRC or the pivot-certificate equivalence | false inference; expressly rejected | retain existing status | The failed statement is an auxiliary aggregate divisibility bridge |
| Quarantined finite scans, scan counts, fixtures, or packaged verifier outputs establish computed evidence | not audited | no promotion | Recovery identity and hashes do not establish mathematical correctness |

## 2. Family and canonical representatives

Fix an integer `E >= 3`, and put

```text
q = 2^E,
M = 7q,
a = M/4 = 7 * 2^(E-2),
b = M/2 = 7 * 2^(E-1).
```

Because `8 | q`, both `a` and `b` are integers. Consider the labelled tuple

```text
v = (1, 1, a - 1, a + 1, b - 1, b).
```

Every coordinate is a canonical representative in `{0, ..., M - 1}`. Indeed,
`a >= 14`, so `a - 1 > 0`; also `a + 1 < b < M`, and `b - 1 > 0`.
The two occurrences of `1` are distinct labels with equal values. Prompt 92
explicitly allows repetitions, so they must not be silently deduplicated.

For every deleted label `k`, at least one of the two labelled coordinates equal
to `1` remains. Consequently

```text
gcd(M, {v_i : i != k}) = 1
```

for every `k`. This proves the deletion-gcd premise without any assertion that
all coordinates, or all residues being tested, are units.

## 3. Exact strict bad sets

Write

```text
rho_M(x) = min(x mod M, M - (x mod M))
```

for the circular distance to `0`, using the canonical residue in
`{0, ..., M - 1}`. For each labelled coordinate let

```text
B_i = {r mod M : rho_M(r v_i) < q}.
```

For canonical `0 <= r < M`, and with `c = r mod 4`, the bad sets are exactly as
follows.

1. For each of the two labelled `1` coordinates,

   ```text
   B_0 = B_1
       = {r : rho_M(r) < q}
       = [0, q - 1] union [M - q + 1, M - 1].
   ```

2. Since `rb` is `0 mod M` for even `r` and the antipode `b = M/2 mod M` for
   odd `r`,

   ```text
   B_5 = {r : r is even}.
   ```

   Here `rho_M(b) = b > q`; the odd case is not accidentally included.

3. For `b - 1`, even `r` gives `r(b - 1) = -r mod M`, whereas odd `r` gives
   `r(b - 1) = b - r mod M`. Since `|b-r| <= b`, this yields

   ```text
   B_4 = {r even : rho_M(r) < q}
         union {r odd : b - q < r < b + q}.
   ```

4. Since `4a = M`, one has `ra = ca mod M`. Therefore

   ```text
   r mod 4   rho_M(r(a - 1)) < q exactly when
       0      rho_M(r)     < q
       1      rho_M(a - r) < q
       2      rho_M(b - r) < q
       3      rho_M(a + r) < q
   ```

5. Similarly,

   ```text
   r mod 4   rho_M(r(a + 1)) < q exactly when
       0      rho_M(r)     < q
       1      rho_M(a + r) < q
       2      rho_M(b - r) < q
       3      rho_M(a - r) < q.
   ```

These are strict inequalities throughout. In particular, residues at circular
distance exactly `q` are not inserted into an endpoint by a closed-interval
convention.

## 4. Complete parity/band/quarter cover table

The following decision procedure assigns a strict bad-set owner to every
canonical residue `r`.

| Case | Normalization and condition | Owner | Exact reason |
|---|---|---|---|
| `r` even | none | `b` | `rb = 0 mod M`, so the distance is `0 < q` |
| `r` odd and `x < q` | `x = min(r, M-r)` | either labelled `1` | `rho_M(r) = x < q` |
| `r` odd and `b-x < q` | same `x` | `b-1` | `x` is odd, so `xb = b mod M`, hence `x(b-1) = b-x mod M` and its distance is `b-x < q` |
| `r` odd, `q <= x <= b-q`, and `x = 1 mod 4` | same `x` | `a-1` | `xa = a mod M`, so `x(a-1) = a-x mod M` |
| `r` odd, `q <= x <= b-q`, and `x = 3 mod 4` | same `x` | `a+1` | `xa = 3a = -a mod M`, so `x(a+1) = x-a mod M` |

This table is exhaustive. Reflection from `r` to `x = min(r,M-r)` preserves
every circular distance because multiplication by `M-r` negates multiplication
by `r` modulo `M`. Since `M` is even and `r` is odd, `x` is odd. In the last two
rows,

```text
q <= x <= b-q = 5q/2,
a = 7q/4,
```

so

```text
|a-x| <= max(a-q, (b-q)-a) = 3q/4 < q.
```

Thus the indicated quarter-class owner is strictly bad. This proves

```text
for every r mod M, there exists i with rho_M(r v_i) < q.
```

### Boundary and degenerate-residue audit

- The potential band boundaries `q`, `b-q`, `b+q`, and `M-q` are all even
  because `8 | q`. They are covered by the `b` coordinate through a zero
  product, even though another coordinate can have distance exactly `q` there.
- The middle rows use the stronger estimate `|a-x| <= 3q/4 < q`; no equality
  at `q` is treated as bad.
- `r = 0` is part of the full grid and is covered by zero products.
- For odd `r`, multiplication by `b` gives the antipode, which is correctly
  treated as safe for that coordinate; coverage then comes from another row.
- Nonunit residues and the nonunit coordinate `b` are not removed. No modular
  inversion is used.
- Collisions and the repeated labelled `1` coordinates are retained. The
  product and deletion conditions are label-indexed, as required by the target.

## 5. Product obstruction

For `E >= 3`, the integer `a` is even. Hence `a-1`, `a+1`, and `b-1` are odd,
as are the two coordinates equal to `1`. The only even factor is

```text
b = 7 * 2^(E-1).
```

Therefore, for the labelled product `P = product_i v_i`,

```text
nu_2(P) = E - 1.
```

It follows immediately that `q = 2^E` does not divide `P`. More precisely, the
odd cofactor gives

```text
P = q/2 mod q.
```

This contradicts exactly the divisibility conclusion of the Prompt 92 target
while all of its premises hold.

## 6. Frozen `n = 6` arithmetic

For the Prompt 92 definitions at `n = 6`,

```text
C = binomial(7,2) = 21,
A = C^30 = 4640650289117164100520051333566036654601,
6^6 = 46656,
T_6 = ceil(A / 46656)
    = 99465241107620972662038137293510731.
```

Exact bracketing gives

```text
46656 (T_6 - 1) = A - 35721 < A,
46656 T_6       = A + 10935 > A,
```

so this is the ceiling without a floating-point assumption. Moreover,

```text
2^116 = 83076749736557242056487941267521536 < T_6,
2^117 = 166153499473114484112975882535043072 > T_6.
```

Thus the least permitted exponent with `T_6 < 2^E` is exactly

```text
E_6 = 117,
q_6 = 166153499473114484112975882535043072,
M_6 = 1163074496311801388790831177745301504.
```

The associated quarter and half are

```text
a = 290768624077950347197707794436325376,
b = 581537248155900694395415588872650752,
```

and the exact labelled tuple is

```text
(1,
 1,
 290768624077950347197707794436325375,
 290768624077950347197707794436325377,
 581537248155900694395415588872650751,
 581537248155900694395415588872650752).
```

Its product satisfies

```text
nu_2(P) = 116,
P mod q_6 = 2^116
          = 83076749736557242056487941267521536.
```

The displayed Response 92 `n = 6` integers used above are arithmetically
correct. The heading immediately before its displayed product remainder is
malformed Markdown (a separator followed by `# 2^{116}`); that presentation
artifact is not an incorrect decimal value. No arithmetic decimal typo was
found in the audited `n = 6` data.

## 7. Exact target-domain consequence

Prompt 92 asks for one lemma asserting that, for every `n >= 3`, the frozen
`q_n` and `M_n` construction has this implication:

```text
canonical possibly repeated labelled tuple
+ every deletion has gcd 1 with M_n
+ every residue is in at least one strict bad set
=> q_n divides the labelled product.
```

At `n = 6`, the preceding `E = 117` family satisfies every quantified premise
and falsifies the conclusion. It is therefore a genuine counterexample in the
exact target domain, not merely a nearby counterexample obtained by weakening
injectivity, omitting a residue class, changing `<` to `<=`, or changing the
threshold.

The aggregate bridge recorded in Response 87 has the same frozen definitions,
repeated-label domain, deletion-gcd premise, full strict-cover premise, and
product-divisibility conclusion. The same instance therefore refutes that
bridge as well.

This result does **not** refute unrestricted LRC, integer LRC, the exact pivot
certificate equivalence, or all possible power-forcing/prime-forcing routes.
It refutes this particular aggregate dyadic divisibility lemma and any
implication chain whose only route through the open edge requires that lemma.

## 8. Conditional-chain and literature status

Any downstream C2 argument of the form “if the aggregate lemma, then the
modular obstruction, then the desired C2 conclusion” remains a valid
counterfactual implication only to the extent separately audited. Its
antecedent is false, so it cannot establish C2. This audit does not promote any
conditional wrapper to an unconditional theorem.

The cited Montgomery--Smith--Shen strict-product theorem remains
`literature` / `external-unformalized`. It was neither reproved nor formalized
here, and it is unnecessary for verifying the explicit counterexample to the
aggregate lemma.

## 9. Deliberately unverified material and remaining gaps

The following Response 92 material is outside this hand audit and receives no
evidence promotion:

- quarantined source, JSON, ZIP, verifier execution, scan counts, manifests as
  correctness evidence, and packaged fixtures;
- claimed finite-search totals or “first failure” outputs;
- auxiliary `n = 3` and `n = 4` control computations;
- any asserted inclusion-minimality or private-residue property of a selected
  subcover;
- any generic fiber-count theorem not needed by the direct family proof;
- a Lean formalization of this counterexample.

A fresh ephemeral integer calculation was used only as a private arithmetic
sanity check while constructing this audit. It is not a tracked artifact and
is not classified as computed finite evidence. The proof above is symbolic and
does not depend on that computation.

No mathematical gap remains in the stated symbolic counterfamily proof. The
remaining evidence gap is formal: there is not yet a kernel-checked Lean
declaration encoding this family and its exact instantiation. If such work is
prioritized, its theorem signature and strict-boundary conventions should be
frozen by the Formalization Lead before any narrow implementation task.
