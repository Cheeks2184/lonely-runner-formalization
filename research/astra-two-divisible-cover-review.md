# Independent review: supplied two-divisible cover

**Accept the public conditional cover contract, generic two-choice helper,
and local finisher exactly as written below.** No mathematical defect or
missing essential hypothesis was found. This is a manuscript review for
implementation; no Lean declaration or kernel result is asserted.

The complete frozen input is
`research/astra-two-divisible-cover-contract.md`, 12666 bytes, SHA-256
`e37d214985a28e2622c3f9615bf4354f35d9baf481adf3acf22e5b15a4ea2766`.
This reviewer did not author that extraction. Requested role is Astra/xhigh;
independent runtime model/effort attestation is unavailable. The focused task
state records checkpoint 987c53d and research/in_progress. Only this owned
review file is edited; no Lean, numerical work, source change, Git action,
cache operation, or state mutation is part of this review.

Project config, workflow, policy, and current task state were read. The actual
startup command `python3 scripts/validate_workflow.py` exited 0 with full
stdout:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

## Exact accepted contracts

The three proposed declarations, including the private local finisher, are
copied exactly from the frozen input. They are specifications in the
`LonelyRunner` namespace, not executed Lean code.

```lean
theorem fiveMovingNaturalRunners_of_two_divisible_cover
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (p q : Fin 5) (hpq : p ≠ q)
    (hdiv : ∀ i, 3 ∣ v i ↔ i = p ∨ i = q)
    (hcover : ∀ i, i ≠ p → i ≠ q →
      6 * v i ∣ v p ∨ 6 * v i ∣ v q) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))
```

```lean
theorem exists_two_same_side_of_three {ι : Type*} [DecidableEq ι]
    (S : Finset ι) (hS : 3 ≤ S.card) (P Q : ι → Prop)
    (hcover : ∀ i ∈ S, P i ∨ Q i) :
    (∃ u ∈ S, ∃ w ∈ S, u ≠ w ∧ P u ∧ P w) ∨
    (∃ u ∈ S, ∃ w ∈ S, u ≠ w ∧ Q u ∧ Q w)
```

```lean
private theorem two_divisible_pair_small_witness
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (a b : Fin 5) (hab : a ≠ b)
    (hdiv : ∀ i, 3 ∣ v i ↔ i = a ∨ i = b)
    (hAB : v a < 5 * v b) (hBA : v b < 5 * v a)
    (u w : Fin 5) (huw : u ≠ w)
    (hu : 6 * v u ≤ v a) (hw : 6 * v w ≤ v a) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))
```

The public result requires the complete supplied divisibility cover, with
factor six, in addition to the exact characterization of the two divisible
labels. It does not assume primitivity, distinct speed values, a maximizer,
a parity bound, an existing witness, or the target unconditional theorem.
The finite-set helper is generic over any label type with DecidableEq and
does not require a global Fintype or exclusive P/Q alternatives. The local
finisher keeps both strict ratios, positivity, two distinct labels, and
the two factor-six inequalities.

## Independent derivation

Write N for circleNorm and W(t) for the universal closed sixth-margin bound.
The public proof can work under absence of a **positive** witness. It never
needs to infer absence of all-real witnesses from this assumption.

**Exception count.** Let S contain the labels divisible by three and E its
complement in Fin 5. The exact hdiv gives S={p,q}; hpq gives card S=2.
The filter partition identity then gives card E=3. E-membership is exactly
inequality to both p and q. This is counting labels; equal speed values
are not merged.

**Both fast-ratio exclusions.** Suppose 5*v_q≤v_p. For i≠p, if i=q then
5*v_i≤v_p is the supposition. Otherwise both inequalities needed for hcover
hold. In the first cover branch, 6*v_i∣v_p and v_p>0 give
6*v_i≤v_p, hence 5*v_i≤v_p. In the other branch,

    5*v_i ≤ 6*v_i ≤ v_q ≤ 5*v_q ≤ v_p.

Thus p satisfies the full checked fast-speed theorem, which returns a
positive witness and contradicts the assumed absence. Consequently
v_p<5*v_q. Interchanging p and q, while swapping the two cover alternatives,
proves v_q<5*v_p: the same argument controls every label other than q.
The weak fast hypothesis handles both equality cases. This deduction uses
the complete cover, not merely the negation of an unspecified fast-speed
condition, and it does not depend on a later pigeonhole choice.

The source API `Nat.le_of_dvd` here needs positivity of the dividend,
v_p or v_q, which hpos supplies. Positivity of only the divisor would not
justify the stated bound for a zero dividend.

**Two labels with a common target.** For the generic helper, work classically
and filter S by P. If the filter has at least two elements, `Finset.one_lt_card`
produces two distinct labels satisfying P. Otherwise its cardinality is at
most one. Since card S≥3 and the P / not-P filters partition S, the not-P
filter has at least two elements. Choose two distinct labels there and use
the cover and their not-P proofs to obtain Q. Overlap between P and Q creates
no difficulty because the selection favors P first. The argument works for
card S greater than three as well.

Apply this to E, P(i) meaning 6*v_i∣v_p and Q(i) meaning 6*v_i∣v_q.
Select the common target a and the other original pair label b. The two
distinct chosen labels u,w satisfy 6*v_u≤v_a and 6*v_w≤v_a by positive
divisibility. Both strict ratios already hold in either orientation.
The hdiv characterization is symmetric under swapping the pair. Therefore
each pigeonhole alternative meets exactly the local finisher's hypotheses.

**Local small-phase bounds.** Set A=v_a>0, B=v_b>0 and t₀=1/(6A)>0.
For U=v_u>0 with 6U≤A, positive denominator multiplication gives

    0 < t₀*U ≤ 1/36,
    0 < 5*t₀*U ≤ 5/36 < 1/6.

The same holds for W=v_w. Every one of these phases is at most 1/2, so
`circleNorm_eq_abs_of_abs_le_half` and nonnegativity identify the norm
with the real phase. Thus u,w are strictly bad at both seeds. No fractional
part calculation or wrap assumption is hidden in this step.
The factor six makes the second bound strictly below 1/6; it is retained
in both the supplied cover and the local inequalities.

At t₀, the phase of a is exactly 1/6, which is closed-safe.
Put x=t₀*B=B/(6A); hBA gives 0<x<5/6.
If b is safe at t₀, hdiv makes every divisible label safe. The exception
count is at most three, and u,w are distinct and strictly bad.
The checked seeded collision rescue gives one k:Fin 3 safe for **all** labels
at t₀+k.val/3. That time is positive because t₀>0 and k.val/3≥0.

If b is not safe, N(x)<1/6. Were x≥1/6, the known x<5/6 and the closed
integer-band theorem with q=0 would imply N(x)≥1/6, contradiction.
So x<1/6. The other ratio A<5B gives x>1/30.
Multiplying both strict inequalities by five yields

    1/6 < 5x < 5/6.

At 5t₀, label a has phase 5/6, and label b has phase 5x in that open middle
band. Both are closed-safe; u,w are still strictly bad.
The same seeded collision theorem gives one k safe for all labels at
5t₀+k.val/3>0. The third outside label requires no separate phase estimate:
it is included in the rescue's single universal conclusion.

This proves the local finisher constructively by its two cases once its
hypotheses are supplied, and completes the public contradiction argument.
No all-real nonexistence premise is smuggled into either application.

**No missing nondivisibility premise for u,w.** The local finisher need not
state that its selected labels are outside {a,b}. In each rescue application,
the two safe divisible seeds and their strict badness already imply that
neither label is divisible by three, exactly as the checked adapter proves.
Equivalently, some coincidences with a or b are inconsistent with positivity,
the smallness bounds, and the ratios; no invalid rescue occurs in such a case.
The source adapter requires u≠w as labels, and this premise is explicitly
retained. Repeated positive speed values, including equal pair speeds, remain
allowed wherever the hypotheses hold.

**Positive-time scope.** Both terminal seeds are positive, and the chosen
third shift is nonnegative. The local proof therefore needs no reflection
step. In the two fast-ratio branches the checked fast wrapper already proves
positive time, including reflection if its insertion witness was negative.
This is sufficient under positive-witness nonexistence; the manuscript's
warning against silently replacing it by all-real nonexistence is correct.

## Current APIs and implementation obligations

Read the full current `FiveMovingFast.lean` proof and the focused declarations
in `ThirdShiftRescues`, `FastRunnerInsertion`, `StructuredClasses`, and
mathlib's `Data.Finset.Card`. The generic collision source was independently
read earlier in this same sequence and remains bound to the same SHA below.

| Current interface | Verified scope and role |
| --- | --- |
| `fiveMovingNaturalRunners_of_fast_speed` | Positive Fin 5 natural speeds, one chosen label, weak factor-five dominance over every other label; conclusion includes 0<t and closed margin. |
| `exists_third_shift_of_two_bad_seeded_divisible` | Arbitrary real seed, every divisible label closed-safe, exception count≤3, two distinct strictly bad labels; one common k:Fin 3 for all labels. Positivity of the shifted time is not part of that API. |
| `circleNorm_eq_abs_of_abs_le_half` | Requires |x|≤1/2 and returns N(x)=|x|; positivity removes the absolute value in this application. |
| `circleNorm_ge_of_int_band` | Keeps q:ℤ, 0≤δ≤1/2 and both closed endpoint hypotheses. q=0 and δ=1/6 apply directly. |
| `Finset.card_filter_add_card_filter_not` | Counts the two complementary filters exactly; classical predicate instances suffice. |
| `Finset.one_lt_card` | 1<card S iff there are two distinct members, with both membership proofs. |

The extraction's proposed implementation requires only the finite-set helper,
local finisher, and public wrapper. Prove the exception cardinality once for
the pair and reuse it. Keep natural inequalities until the local real
argument, then cast them explicitly. Establish positive denominator facts
before division inequalities; derive the two seed phase identities by exact
field arithmetic. The quotient is real, not natural division.

No additional scalar theorem, normalization, gcd reduction, or special-phase
transport is required. The maximum, boundary-minimum-zero proof, and the
argument that obtains this cover remain separate. Later implementation still
needs a source build, exact type/axiom check, and independent source review.
This static acceptance does not replace those checks.

## Frozen source bindings

The input's ten bindings are retained exactly here. The static replay below
checks their current bytes, binds the input manuscript itself, and compares
all three proposed declaration blocks byte-for-byte with this report.

| File | SHA-256 |
| --- | --- |
| `research/astra-two-divisible-three-reduction-plan.md` | `07f27873785c463d7f9b2e8c2074510f42fcd973d07cc6e73ea62e5b3bac0ad6` |
| `research/astra-two-divisible-three-plan-review.md` | `4d499c4477e80445646c6f82fcb72e36009ed1b9fc35b0023dd278f399598f71` |
| `LonelyRunner/FiveMovingFast.lean` | `cc203315c6d36be23b7cdcfc9706785fb05e6d5406c84714a9fea42bdfce7212` |
| `LonelyRunner/ThirdShiftRescues.lean` | `829db12405e64ad88da5501ddb167d650ad82cf92295a88fd2374d9e08281732` |
| `LonelyRunner/ThirdShiftCollision.lean` | `5b984687f89ea16bad34453d3c048ceb974f999af9cd1969f73d56ce30e13cec` |
| `LonelyRunner/FastRunnerInsertion.lean` | `dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5` |
| `LonelyRunner/StructuredClasses.lean` | `5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c` |
| `.lake/packages/mathlib/Mathlib/Data/Finset/Card.lean` | `87c674ba5464c7868fb3e253e58a695821bf8841bb4e076bac5d570236dc6229` |
| `lean-toolchain` | `8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af` |
| `lake-manifest.json` | `887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218` |

## One static replay command

Run from `/home/joshua/lonely-runner-formalization`. This command performs
only file reads, text extraction, and SHA-256 checks. It does not run Lean,
evaluate the mathematics, enumerate speeds, or mutate files.

```bash
python3 -I - <<'PY'
from pathlib import Path
import hashlib
import json
import re

source = Path('research/astra-two-divisible-cover-contract.md').read_bytes()
source_hash = 'e37d214985a28e2622c3f9615bf4354f35d9baf481adf3acf22e5b15a4ea2766'
assert len(source) == 12666 and hashlib.sha256(source).hexdigest() == source_hash
s = source.decode('utf-8')
review = Path('research/astra-two-divisible-cover-review.md').read_text(encoding='utf-8')
pattern = r'^\| `([^`]+)` \| `([0-9a-f]{64})` \|$'
bindings = re.findall(pattern, s, re.M)
assert len(bindings) == 10 and re.findall(pattern, review, re.M) == bindings
for path, expected in bindings:
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
blocks = re.findall(r'```lean\n([\s\S]*?)\n```', s)
proposed = [b for b in blocks if not b.startswith(
    'theorem exists_third_shift_of_two_bad_seeded_divisible')]
names = [
    'fiveMovingNaturalRunners_of_two_divisible_cover',
    'exists_two_same_side_of_three',
    'two_divisible_pair_small_witness',
]
assert len(proposed) == 3
assert [re.search(r'(?:private )?theorem ([^\s]+)', b).group(1) for b in proposed] == names
assert re.findall(r'```lean\n([\s\S]*?)\n```', review) == proposed
print(json.dumps({
    'status': 'passed',
    'scope': 'static bindings and exact contract text only',
    'manuscript_sha256': source_hash,
    'manuscript_bytes': len(source),
    'source_bindings_checked': len(bindings),
    'exact_contracts_retained': names,
    'lean_invocations': 0,
    'numerical_experiments': 0
}, indent=2))
PY
```

This report accepts the supplied-cover implication only. It does not establish
the cover from arbitrary inputs or complete the two-divisible branch, a full
five-moving sixth-margin theorem, H8, a canonical new runner count, or the
unrestricted Lonely Runner Conjecture.

## Actual static receipt

The exact single Bash block above, including its trailing newline, was
extracted and executed once using `bash -c`, with separate captured stdout
and stderr. The launcher exited 0. The complete receipt below retains the
actual command exit and complete raw streams as JSON strings. Its ten
binding checks and three exact-contract comparisons passed. These are
text-integrity checks; the mathematical verdict comes from the independent
derivation above. The workflow validator was rerun after context compaction
and again exited 0 with the same one-line output retained above.

```json
{
  "command_sha256": "8ab0a0a36731ecd8d3ffd7cfaefaae490bba19a07c59255c509dceae2b606511",
  "command_bytes": 1555,
  "actual_exit_code": 0,
  "stdout": "{\n  \"status\": \"passed\",\n  \"scope\": \"static bindings and exact contract text only\",\n  \"manuscript_sha256\": \"e37d214985a28e2622c3f9615bf4354f35d9baf481adf3acf22e5b15a4ea2766\",\n  \"manuscript_bytes\": 12666,\n  \"source_bindings_checked\": 10,\n  \"exact_contracts_retained\": [\n    \"fiveMovingNaturalRunners_of_two_divisible_cover\",\n    \"exists_two_same_side_of_three\",\n    \"two_divisible_pair_small_witness\"\n  ],\n  \"lean_invocations\": 0,\n  \"numerical_experiments\": 0\n}\n",
  "stderr": ""
}
```
