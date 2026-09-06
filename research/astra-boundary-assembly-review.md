# Independent review: boundary-zero assembly manuscript

**Accept the exact target, all helper contracts, and the complete proposed
assembly.** No mathematical defect or missing essential hypothesis was found.
This static review does not assert that the new selector, fallback, or
boundary-zero theorem is implemented or kernel-checked.

The entire frozen manuscript is
`research/astra-two-divisible-boundary-assembly.md`, 18102 bytes, 324 lines,
SHA-256 `f282ced2c133f1bb607b2d5f6ca94d6b27bb8591605b445ee6de60b422a9800c`.
This reviewer did not author that decomposition. The earlier larger plan
was reviewed previously, but this verdict follows an independent read of
the full frozen decomposition and its cited current interfaces.

Only this report is owned/edited. Requested route is Astra/xhigh; independent
runtime model/effort attestation is unavailable. Focused task state records
research/in_progress at 901dcfd. Project config, workflow, policy and focused
state were read. The actual command `python3 scripts/validate_workflow.py`
exited 0 with complete stdout:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

No Lean invocation, source implementation, mathematical enumeration,
numerical fixture, solver, cache operation, state mutation or Git action
belongs to this review. Static text extraction and source hashing are the
only replay operations.

## Independent mathematical audit

**Target and maximum.** The boundary-zero target is exactly the corresponding
declaration in the frozen 07f278 original plan, retaining positive Fin 5
natural speeds; distinct p,q,r labels; exact three-divisibility
classification; one six-divisible pair label; at most three even labels;
all-real nonexistence at the closed sixth margin; and arbitrary queried
real t at the 5/6 anchor. It is not restricted to positive queried t.

The current maximizer API requires only positive anchor speed c, which
hpos r supplies. It returns τ in (0,1), the exact 5/6 phase, and a
bound over all anchored real times. No positive pair objective is in that
API: M=min(N(τv_p),N(τv_q)) may equal zero. Norm nonnegativity gives
M≥0. If M≥1/6, both pair labels are safe at τ; hdiv gives the
whole divisible seed, the independent exact count gives at most three
exceptions, and the special-anchor rescue returns one common shift for
all five labels. This contradicts the given hno. Therefore M<1/6.

Assuming M>0 only for the contradiction branch is legitimate. Order the
two norms; their minimum equals the selected smaller norm. In the reverse
ordering, swap labels rather than replacing either actual phase by its
norm. The all-real supplied fiber inequality is rewritten with min_comm,
so its bound remains the same M. The exact hdiv characterization and
six-divisibility disjunction are swapped, as are r's two inequalities;
the even-label count remains unchanged. In each ordering the checked
pair-band theorem receives its exact positive, small, ordered-norm
hypotheses and the actual fiber bound. The smaller-norm label need not
be the six-divisible one.

**Five rows, including both signs.** Let A=N(τa), B=N(τb).
The decomposition a=6z_a+3ε_a and b=6z_b+3ε_b has ε_a,ε_b∈{0,1},
and hsix excludes 11. A nondivisible anchor has centered residue
κσ, with κ∈{1,2} and σ∈{1,−1}. This is the four-case residue
certificate expressed with a common sign σ; no unit claim about arbitrary
composite residues is used.

For the selected row, take s=nτ+σ/6. The folded-norm interface gives
N(sa)=N(nA+σε_a/2) and N(sb)=N(nB+σε_b/2).
For ε=0 this is N(nA) or N(nB); for ε=1, sign −1 changes the
half-shift expression by exactly −1 from the +1/2 expression.
Integer periodicity therefore applies the listed H field for both signs.
No positive residual orientation is presumed.

The exact table is retained from the source:

| ε_a,ε_b | κ | n | Fields of H proving pair safety | Anchor numerator / 6 → phase |
| --- | --- | --- | --- | --- |
| 0,0 | 1 | 2 | `left_two`, `right_two` | 11/6 → 5/6 |
| 0,1 | 1 | 2 | `left_two`, `right_two_half` | 11/6 → 5/6 |
| 0,1 | 2 | 3 | `left_three`, `right_three_half` | 17/6 → 5/6 |
| 1,0 | 1 | 2 | `left_two_half`, `right_two` | 11/6 → 5/6 |
| 1,0 | 2 | 1 | `left_half`, `right_one` | 7/6 → 1/6 |

For the anchor, the signed affine fractional-part identity uses
integer α=n, β=σ and residue e=κσ. Since σ²=1 and fract(τc)=5/6,
the resulting phase is fract((5n+κ)/6). The table's fixed reductions
follow by removing respectively one, two, and one integer turns.
The fifth row deliberately returns 1/6, an accepted special anchor.
Each n is in {1,2,3}; the returned σ remains in {1,−1}. The selected
n and σ are shared by a,b,c. There is no per-speed selection.

Row premises are exactly the declared real time, natural speeds, signed
residue lifts and sign, three residue equalities with that row's fixed
ε_a,ε_b,κ, plus ht and H. These suffice without extra positivity,
order, nonexistence, or maximum assumptions: H already supplies the used
inequalities. Fixed row lemmas may be private and their premises inlined.
The only sixth combination, 00 with κ=2, implies 6∣a,6∣b and
2∣c, contradicting hregular. Integer evenness from c=6z_c±2
transfers to natural divisibility; it does not require z_c nonnegative.
Thus the public selector exhausts its exact hypotheses, including both signs.

**Both-six/even-anchor fallback.** The three pairwise distinct labels
p,q,r form K of cardinality three. They are all even under hp,hq,hr,
so K⊆E where E is the even-label finset. The upper bound card E≤3
forces E=K. Its complement in Fin 5 has cardinality two; the exact
`Finset.card_eq_two` API returns distinct labels u,w and equality
of that complement with {u,w}. Hence u,w are odd and p,q,r,u,w
exhaust all labels. This does not require distinct speed values, an exact
three-divisibility classification, or positivity of all speeds.

At 2τ, H.left_two/right_two make the pair safe; at 4τ,
H.left_four/right_four do so. This uses zero-half folding on the actual
phases. Even-speed preservation under half-time addition therefore makes
the pair safe at all three candidates 2τ,2τ+1/2,4τ+1/2.
The anchor at 2τ has fractional phase 2/3 and at 4τ phase 1/3.
The current min-of-fractions norm identity makes both norms 1/3;
evenness preserves them under the candidate half-time additions.

For an odd natural d, d=2·(d/2)+1 with natural quotient gives
(t+1/2)d=td+(d/2)+1/2. The difference from td+1/2 is the
integer natural quotient, proving the proposed odd half-time identity
for every real t, including negative t. No speed positivity is needed.
Even preservation uses the existing rational-shift API at denominator
2 and numerator 1.

Set x=(2τ)v_u, y=(2τ)v_w. The norms at the three candidate times
become the three paired phase alternatives in two_phase_half_choices:
(x,y), (x+1/2,y+1/2), (2x+1/2,2y+1/2).
One common scalar disjunct, combined with the already-safe p,q,r and
complete label decomposition, gives the corresponding AllSafe statement.
The fallback has no hno premise and proves its displayed disjunction
directly. It does not propagate an unknown safety assertion from τ.
Zero, repeated or negative phases and closed-safe boundary ties are
handled by the unconditional scalar helper. Some degenerate natural
inputs may make H or ht inconsistent, but no omitted premise is needed.

**Finish at every boundary point.** In the M>0 branch, either the
both-six/even-anchor condition holds and the fallback contradicts hno,
or its negation is exactly the selector's hregular. The selector then
supplies a safe pair and 1/6 or 5/6 anchor at its single affine time.
The special-anchor rescue accepts either endpoint (and also 1/2);
hdiv supplies all divisible-label safety and the exact-count helper
supplies its exception bound. Its output is one k for all labels.

The affine time can be negative because σ can be −1. The stated hno
quantifies over **all real times**, so the resulting witness is a
contradiction without a positivity argument. Replacing hno by
no-positive-witness is not an authorized simplification of this contract.
The fallback also needs no positive-time guarantee.

Thus M>0 is impossible and M≥0 gives M=0. Applying the original
global fiber bound to the arbitrary input time t gives its pair minimum
at most zero; nonnegativity gives equality. This last use of the original
bound is necessary: zero at the chosen τ alone would not prove the target.

**Dependencies and circularity.** The exact count theorem is proved
independently by filter cardinalities inside TwoDivisibleSmallPair.
Although that module also contains a witness finisher, neither its
count theorem nor this proposed boundary assembly uses the finisher or
the supplied-cover wrapper. Importing a module containing that theorem
does not create a logical use of it. The proof depends only on the count,
maximizer, band/phase interfaces and special-anchor rescue described here.
No gcd reduction, primitivity, unexplained cover supply, or unconditional
five-moving sixth-margin theorem enters the assembly.

## Exact accepted contracts

All eight Lean blocks below are copied byte-for-byte from the frozen
manuscript. They are interface specifications in namespace LonelyRunner.
The abbreviations are transparent and can be inlined. In particular the
existing two-phase contract here is definitionally the source's expanded
norm statement with its ordinary right-associated disjunction.
No new Lean execution is claimed by their inclusion.

**Original boundary-zero target.**

```lean
theorem two_divisible_boundary_min_eq_zero
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (p q r : Fin 5) (hpq : p ≠ q) (hrp : r ≠ p) (hrq : r ≠ q)
    (hdiv : ∀ i, 3 ∣ v i ↔ i = p ∨ i = q)
    (hsix : 6 ∣ v p ∨ 6 ∣ v q)
    (heven : ((Finset.univ : Finset (Fin 5)).filter
      (fun i => 2 ∣ v i)).card ≤ 3)
    (hno : ¬ ∃ t : ℝ, ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)))
    (t : ℝ) (ht : Int.fract (t * (v r : ℝ)) = (5 : ℝ) / 6) :
    min (circleNorm (t * (v p : ℝ)))
      (circleNorm (t * (v q : ℝ))) = 0
```

**Transparent private abbreviations.**

```lean
private abbrev SixthSafe (x : ℝ) : Prop :=
  (1 : ℝ) / 6 ≤ circleNorm x
private abbrev PairSafe (a b : ℕ) (s : ℝ) : Prop :=
  SixthSafe (s * (a : ℝ)) ∧ SixthSafe (s * (b : ℝ))
private abbrev AllSafe (v : Fin 5 → ℕ) (s : ℝ) : Prop :=
  ∀ i, SixthSafe (s * (v i : ℝ))
```

**Existing affine folded-norm interface.**

```lean
theorem circleNorm_sixth_affine_of_three_residue (t : ℝ) (d n : ℕ)
    (β z ε : ℤ) (hd : (d : ℤ) = 6 * z + 3 * ε) :
    circleNorm (((n : ℝ) * t + (β : ℝ) / 6) * (d : ℝ)) =
      circleNorm ((n : ℝ) * circleNorm (t * (d : ℝ)) +
        ((β * ε : ℤ) : ℝ) / 2)
```

**Existing three-residue interface.**

```lean
theorem exists_three_residue_mod_six (d : ℕ) (h3 : 3 ∣ d) :
    ∃ z ε : ℤ, (d : ℤ) = 6 * z + 3 * ε ∧
      (ε = 0 ∨ ε = 1) ∧ (6 ∣ d ↔ ε = 0)
```

**Three-speed five-row selector.**

```lean
theorem exists_pair_safe_special_sixth_affine
    (a b c : ℕ) (ha : 3 ∣ a) (hb : 3 ∣ b) (hc : ¬ 3 ∣ c)
    (hsix : 6 ∣ a ∨ 6 ∣ b)
    (hregular : ¬ (6 ∣ a ∧ 6 ∣ b ∧ 2 ∣ c))
    (τ : ℝ) (ht : Int.fract (τ * (c : ℝ)) = (5 : ℝ) / 6)
    (H : FoldedPairSafeBands (circleNorm (τ * (a : ℝ)))
      (circleNorm (τ * (b : ℝ)))) :
    ∃ (n : ℕ) (σ : ℤ), (n = 1 ∨ n = 2 ∨ n = 3) ∧
      (σ = 1 ∨ σ = -1) ∧
      PairSafe a b ((n : ℝ) * τ + (σ : ℝ) / 6) ∧
      (Int.fract (((n : ℝ) * τ + (σ : ℝ) / 6) * (c : ℝ)) =
          (1 : ℝ) / 6 ∨
        Int.fract (((n : ℝ) * τ + (σ : ℝ) / 6) * (c : ℝ)) =
          (5 : ℝ) / 6)
```

**Odd-speed half-time identity.**

```lean
theorem circleNorm_time_add_half_of_not_dvd_two
    (t : ℝ) (d : ℕ) (hodd : ¬ 2 ∣ d) :
    circleNorm ((t + (1 : ℝ) / 2) * (d : ℝ)) =
      circleNorm (t * (d : ℝ) + (1 : ℝ) / 2)
```

**Existing common two-phase choice, with abbreviations.**

```lean
theorem two_phase_half_choices (x y : ℝ) :
    (SixthSafe x ∧ SixthSafe y) ∨
      (SixthSafe (x + 1 / 2) ∧ SixthSafe (y + 1 / 2)) ∨
      (SixthSafe (2 * x + 1 / 2) ∧ SixthSafe (2 * y + 1 / 2))
```

**Both-six/even-anchor three-time fallback.**

```lean
theorem both_six_even_anchor_three_time_witness
    (v : Fin 5 → ℕ) (p q r : Fin 5)
    (hpq : p ≠ q) (hrp : r ≠ p) (hrq : r ≠ q)
    (hp : 6 ∣ v p) (hq : 6 ∣ v q) (hr : 2 ∣ v r)
    (heven : ((Finset.univ : Finset (Fin 5)).filter
      (fun i => 2 ∣ v i)).card ≤ 3)
    (τ : ℝ) (ht : Int.fract (τ * (v r : ℝ)) = (5 : ℝ) / 6)
    (H : FoldedPairSafeBands (circleNorm (τ * (v p : ℝ)))
      (circleNorm (τ * (v q : ℝ)))) :
    AllSafe v (2 * τ) ∨ AllSafe v (2 * τ + 1 / 2) ∨
      AllSafe v (4 * τ + 1 / 2)
```

## Implementation boundary and order

The existing affine norm, residue classification, two-phase choice,
pair-band and maximizer interfaces have the needed scopes. Implement only
the remaining odd half-time identity if it is not already available,
the five fixed row proofs and their selector, the complement/times fallback,
and the final maximum/rescue/swap assembly. Preserve the ordered H packet
after label swaps. Use exact cast/periodicity equalities before applying
H fields; all row arithmetic is fixed, symbolic source proof.

The cited `Finset.card_sdiff_of_subset` and `Finset.card_eq_two`
signatures were read and support the complement argument. The independent
boundary-zero-to-divisibility source review remains separate. It is not
needed to prove the target reviewed here and is not duplicated here.
The remaining gates are implementation, source build, exact type/axiom
verification and independent source review of the new assembly declarations.

## Eighteen frozen source/context bindings

| File | SHA-256 |
| --- | --- |
| `research/astra-two-divisible-three-reduction-plan.md` | `07f27873785c463d7f9b2e8c2074510f42fcd973d07cc6e73ea62e5b3bac0ad6` |
| `research/astra-two-divisible-three-plan-review.md` | `4d499c4477e80445646c6f82fcb72e36009ed1b9fc35b0023dd278f399598f71` |
| `LonelyRunner/AnchoredPairSafeBands.lean` | `14212e32cdd3a343b286dd0fc370cefa6c33c145541f61afdf42e8e5290bc306` |
| `LonelyRunner/AnchoredPairMaximizer.lean` | `050888f1d9017183661dbca6e2e61bfeb518849c339bc77b43605a6b3918bdd8` |
| `LonelyRunner/SixthAffineFoldedNorm.lean` | `4ce24ac7955800ccc5ff5220de83d1972bb624d9e9b7e29237ac84874bd5396d` |
| `LonelyRunner/ThreeResidueModSix.lean` | `5df5d3b25175ea631032a8acd567449442ec4d6e56408ab271d6601dec527dfa` |
| `LonelyRunner/SixthAffinePhase.lean` | `76e420713079ec0c3979e9b169cd78ecb6a932d6dc790ea7d9711adbb64b7d4b` |
| `LonelyRunner/FoldedCirclePhase.lean` | `957606878108847d5ceff47be621ff0fc9c0a0d976568b5f5ef3dbb6db10481e` |
| `LonelyRunner/FoldedPairSafeBands.lean` | `00903bcb0c131fdb31ab87d55cea809249dfacbbd5861f82ab3a987d39b74b5f` |
| `LonelyRunner/AnchoredPairTransport.lean` | `63414c3ccb6c12c1ed8775cb7e18dccc84c30da42cd4be089ac336df75ceca43` |
| `LonelyRunner/ThirdShiftSpecialSeed.lean` | `ffbab991e23c45a1cd0abb2f692c30f35665f04ae5843a70898da00c69ab6187` |
| `LonelyRunner/ThirdShiftRescues.lean` | `829db12405e64ad88da5501ddb167d650ad82cf92295a88fd2374d9e08281732` |
| `LonelyRunner/RationalShiftOrbits.lean` | `cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591` |
| `LonelyRunner/TwoDivisibleSmallPair.lean` | `ff40734821aae9abff43fdfc17c4275f4b5d045b4757b254dc11d24e695e8821` |
| `LonelyRunner/TwoPhaseHalfChoices.lean` | `cb5c23225a130c8613c1897a749eaa7834c14b3de504ae8b51f1744c53624acc` |
| `.lake/packages/mathlib/Mathlib/Data/Finset/Card.lean` | `87c674ba5464c7868fb3e253e58a695821bf8841bb4e076bac5d570236dc6229` |
| `lean-toolchain` | `8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af` |
| `lake-manifest.json` | `887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218` |

## One static replay command

Run from /home/joshua/lonely-runner-formalization. The command has a
10-second wall cap. It only checks exact bytes and text; it does not
execute Lean, arithmetic fixtures, or mathematical search, or write files.
It checks all 18 bindings, all eight contract/abbreviation blocks, the
exact fixed row table, and equality of the target with the original plan.

```bash
timeout --signal=KILL 10s python3 -I - <<'PY'
from pathlib import Path
import hashlib
import json
import re

src = Path('research/astra-two-divisible-boundary-assembly.md').read_bytes()
expected_sha = 'f282ced2c133f1bb607b2d5f6ca94d6b27bb8591605b445ee6de60b422a9800c'
assert len(src) == 18102 and len(src.splitlines()) == 324
assert hashlib.sha256(src).hexdigest() == expected_sha
s = src.decode('utf-8')
review = Path('research/astra-boundary-assembly-review.md').read_text(encoding='utf-8')
pattern = r'^\| `([^`]+)` \| `([0-9a-f]{64})` \|$'
bindings = re.findall(pattern, s, re.M)
assert len(bindings) == 18 and re.findall(pattern, review, re.M) == bindings
for path, expected in bindings:
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
blocks = re.findall(r'```lean\n([\s\S]*?)\n```', s)
assert len(blocks) == 8
assert re.findall(r'```lean\n([\s\S]*?)\n```', review) == blocks
original = Path('research/astra-two-divisible-three-reduction-plan.md').read_text(encoding='utf-8')
old_blocks = re.findall(r'```lean\n([\s\S]*?)\n```', original)
target = [b for b in old_blocks if b.startswith('theorem two_divisible_boundary_min_eq_zero')]
assert target == [blocks[0]]
table_pattern = r'\| ε_a,ε_b \|[^\n]*\n(?:\|[^\n]*\n){6}'
source_table = re.findall(table_pattern, s)
assert len(source_table) == 1 and re.findall(table_pattern, review) == source_table
print(json.dumps({
    'status': 'passed',
    'scope': 'static source bindings and exact manuscript text only',
    'manuscript_sha256': expected_sha,
    'manuscript_bytes': len(src),
    'manuscript_lines': len(src.splitlines()),
    'bindings_checked': len(bindings),
    'exact_lean_blocks': len(blocks),
    'target_matches_original_plan': True,
    'five_row_table_matches': True,
    'lean_invocations': 0,
    'numerical_experiments': 0
}, indent=2))
PY
```

This acceptance establishes only manuscript soundness of the stated
boundary-zero implication. It does not assert an implemented boundary-zero
theorem, full branch completion, a new canonical runner count or LRC.

## Actual static receipt

The exact single Bash block above, including its trailing newline, was
extracted and executed once with separate captured stdout and stderr.
Its inner wall limit was 10 seconds; the capture wrapper additionally
used a 12-second subprocess timeout. The command and wrapper both
actually exited 0, with empty stderr. The complete raw receipt below
retains both streams as JSON strings. Every static check passed.
These checks certify text integrity; the mathematical verdict comes
from the independent argument above, not from executing mathematics.

```json
{
  "command_sha256": "4afe17862fa3d0ba4a107535b994682ad0489e69be5e38b7d105f6267a6a0f1a",
  "command_bytes": 1853,
  "actual_exit_code": 0,
  "stdout": "{\n  \"status\": \"passed\",\n  \"scope\": \"static source bindings and exact manuscript text only\",\n  \"manuscript_sha256\": \"f282ced2c133f1bb607b2d5f6ca94d6b27bb8591605b445ee6de60b422a9800c\",\n  \"manuscript_bytes\": 18102,\n  \"manuscript_lines\": 324,\n  \"bindings_checked\": 18,\n  \"exact_lean_blocks\": 8,\n  \"target_matches_original_plan\": true,\n  \"five_row_table_matches\": true,\n  \"lean_invocations\": 0,\n  \"numerical_experiments\": 0\n}\n",
  "stderr": ""
}
```
