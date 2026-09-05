# Independent nearest-grid semantic review

Reviewer: `/root/guard_internal_cover_audit`, requested Astra/xhigh, 2026-09-05.
Base checkpoint: `808595cf7615d01f849eb071648d8a82ee7c97c1`.
Only this review file is reviewer-owned. Source, manuscript, shared state,
Git, and dependency caches are unchanged by this review.

Frozen inputs (SHA-256):

- `research/astra-nearest-grid-induction.md`:
  `1f6d97ac0eda4683fccb1b815f58621bfc9bd3c9fc0c477fd16bbcecf67f6997`.
- `LonelyRunner/NearestPivotGrid.lean`:
  `ca5f8c1eb511a5be14d3eb50c887421ac7efa96426beb5135c0693a76b4f497b`.
- `research/astra-nearest-grid-formalization.md`:
  `8e072939b7eefae717865f630f747a52d91a511408b9ec7d1ddb06b95eb3cb86`.

## Mathematical audit

The entire manuscript and formal source were read, together with current
workflow/policy/state. Workflow structural validation passed. No mathematical
defect was found. The final replay below passed; both frozen artifacts are
accepted within the explicit scope recorded here.

For generic transport, write M=Np and choose any integer z with
|z-Mt|<=1/2. The Lipschitz loss of coordinate d is at most d/(2M), so the
correct hypothesis is 1/N <= alpha-d/(2M). If N divides z, the rounded
pivot phase z/N is integral, contradicting its original norm at least alpha
when alpha>1/(2N). Signed Euclidean reduction z=qM+r preserves all integer
coordinate norms and exclusion of N-multiples. This proves the literal natural
candidate and closed strict-bad-set complement, including negative t and ties.
The Lean implementation uses one deterministic nearest integer; its result
requires only existence, so no stronger tie-choice promise is implicit.

The source accepts arbitrary natural coordinate maps, without positivity,
lower-than-pivot, distinctness, gcd, or cardinality bounds. This is sound:
nonnegativity suffices in the displacement estimate and every quantitative
margin remains explicit. Zero coordinates make the witness assumptions
inconsistent with positive alpha; repeated or above-pivot coordinates need
not do so. The finite index instance is explicit, though the argument is
pointwise. The manuscript specializes this stronger declaration to lower
owners. Neither version manufactures an ordinary witness.

For c lower owners plus the pivot there are c+1 moving speeds and k=c+2
total runners. An explicitly supplied ordinary 1/k witness gives nearest
transport under (A) 2N>=3k or the stronger speed-sensitive condition
(B) 2Np>=k(2p+q), with q the largest positive lower speed. Condition (B)
forces N>k and therefore the strict pivot gate. Equalities in (A) and (B)
are valid; q<p makes (A) sufficient for (B).

For the two-neighbor condition (C), p(N-k)(q+s)>=kqs, the distinct two
largest positive lowers q>s imply N>k. Both bracketing integers are strictly
inside the same interval between successive N-multiples because the original
pivot has fractional part in [1/k,1-1/k]. For each lower d the two lifted
phases stay in (0,1), since their displacement is strictly below d/M<1/N.
Only the lower endpoint can fail on the left and only the upper endpoint on
the right. One owner cannot block both: that would force d/M>1-2/N,
whereas d/M<1/N<=1-2/N. Two distinct blockers would force
1/M>(1/k-1/N)(1/d_L+1/d_R)>=(1/k-1/N)(1/q+1/s)>=1/M.
Thus one neighbor works, including equality in (C). The integral-grid case
is already a witness. The proof uses only positive denominators and remains
valid for negative t after signed reduction.

The one-owner N=3 boundary is also valid. Here alpha=delta=1/3:
N*alpha=1 still places both nonintegral brackets between N-multiples, and
h_-,h_+<1/M keeps phases strictly in (0,1). A single owner cannot block
both because d/M<delta=1-2delta. Empty families have candidate r=1 for
every N>=2,p>0. The strict alpha gate is sufficient for the generic
arbitrary-nearest argument, not a necessary condition for that existential
empty-family conclusion; the manuscript claims only the former.

## Induction, small cases, and Prompt95 scope

The manuscript first uses the checked all-dimensional
`conjecture_iff_positiveIntegerConjecture` and then minimizes the number n
of moving speeds among failing positive-integer instances. This avoids
assuming that the BHK bridge preserves the least failing real count.
For N=n+1, c<=N-3 makes the c+1 moving subfamily proper and supplies
exactly the ordinary margin 1/(c+2). The full c=N-2 cover receives no such
supply. Taking the contrapositives of (A), (B), and (C) under that properness
condition gives the three displayed strict cover inequalities. In particular
2N<3(c+2) gives c>=floor(2N/3)-1; the full size N-2 satisfies this
arithmetically for N>=3. Dense covers remain possible under these bounds.

The sparse-cover deduction inside a minimal counterexample is valid. For
c>=4, 2c<N implies properness and 2N>=3(c+2). For c=1,2,
`LonelyRunner.exists_pivotCandidate_avoiding_ownerKernel_family`
with E=C and each owner representing itself reduces its numerical premise
to 3c<=N+1, which holds on those sparse ranges. Its hypotheses require no
unit or distinct-owner exception. For c=3, N=7 is precisely the existing
`threeLowerOwner_noncover_seven`; distinct natural lowers may be sorted.
N>=8 satisfies the prior budget (or condition (A) with proper supply).
The empty case has a nonempty row. Thus every cover in the minimal instance
has c>=ceil(N/2); this is not an unconditional sparse theorem for arbitrary
independent tuples. N=9's four-owner theorem is unnecessary here.

The definitions of covered pivots, maximum covered pivot, and internal owner
sets justify internal owners being lower for injective positive speeds.
Uncovered labels may be higher and are omitted from transport. In a
witness-free original instance every pivot is covered; the maximum covered
pivot is then the actual maximum, and the full set of other labels is a
complete internal cover. Proper-owner noncover does not protect omitted
labels or force such a dense cover to be reducible. The manuscript correctly
retains the universal Prompt95 gap and asserts no converse or LRC resolution.

## Independent replay

The manuscript's sole Python block was independently extracted after checking
its full hash and executed with the standard library. Its five reported
outcomes passed: nearest original equality, nearest speed equality,
two-neighbor strict improvement, signed/boundary controls, and explicit-only
ordinary witness supply. This is finite control evidence, not the proof of
all real times. Fresh Lean and additional bounded controls are recorded below.

The following self-contained replay checks the frozen manuscript and compiles
fresh source text, rather than relying on an imported target olean. It then
instantiates the full conclusion for five nonvacuous cases: an empty family
at N=2, an above-pivot coordinate, repeated above-pivot coordinates, and the
positive/negative equality case. Rational norms are proved by an explicit
integer shift followed by the closed half-interval norm identity. The final
finite residue controls use kernel `decide`. Run the block from the repository
root with the pinned `lake` on PATH; no file other than this review is written.

```python
from pathlib import Path
from hashlib import sha256
from fractions import Fraction as F
import os
import subprocess

manuscript = Path('research/astra-nearest-grid-induction.md')
assert sha256(manuscript.read_bytes()).hexdigest() == \
    '1f6d97ac0eda4683fccb1b815f58621bfc9bd3c9fc0c477fd16bbcecf67f6997'
blocks = manuscript.read_text().split('```python\n')[1:]
assert len(blocks) == 1
exec(compile(blocks[0].split('```', 1)[0], str(manuscript), 'exec'))
source = Path('LonelyRunner/NearestPivotGrid.lean').read_text()
assert sha256(source.encode()).hexdigest() == \
    'ca5f8c1eb511a5be14d3eb50c887421ac7efa96426beb5135c0693a76b4f497b'

def real(x):
    x = F(x)
    return f'(({x.numerator} : ℝ) / ({x.denominator} : ℝ))'

def norm_proof(t, v, alpha):
    x = t*v
    z = (x+F(1,2)).numerator // (x+F(1,2)).denominator
    y = x-z
    return f'''have hn : {real(alpha)} ≤ circleNorm ({real(t)} * ({v} : ℝ)) := by
  rw [show {real(t)} * ({v} : ℝ) =
    ((({z} : ℤ) : ℝ)) + {real(y)} by norm_num,
    circleNorm_add_int, circleNorm_eq_abs_of_abs_le_half (by norm_num)]
  norm_num
convert hn using 1 <;> norm_num'''

probe = '''
namespace LonelyRunner
private def ReviewGridConclusion {ι : Type*} (N p : ℕ) (d : ι → ℕ) : Prop :=
  ∃ r : ℕ, r ∈ pivotCandidates N p ∧
    (∀ i, r ∉ pivotBadResidues N p (d i)) ∧
    (N : ℝ)⁻¹ ≤ circleNorm (((r : ℝ) / ((N * p : ℕ) : ℝ)) * (p : ℝ)) ∧
    ∀ i, (N : ℝ)⁻¹ ≤
      circleNorm (((r : ℝ) / ((N * p : ℕ) : ℝ)) * (d i : ℝ))
'''
cases = [
    ('empty_n2', 2, 1, (), F(1,2), F(1,2)),
    ('above_pivot', 9, 5, (7,), F(1,3), F(1,3)),
    ('repeated_above_pivot', 9, 5, (7,7), F(1,3), F(1,3)),
    ('positive_equality', 5, 8, (1,4), F(5,16), F(1,4)),
    ('negative_equality', 5, 8, (1,4), F(-5,16), F(1,4)),
]
for name, N, p, coords, t, alpha in cases:
    if not coords:
        d = '(fun i : Fin 0 => Fin.elim0 i)'
    elif len(coords) == 1:
        d = f'(fun _ : Fin 1 => {coords[0]})'
    else:
        d = f'(fun i : Fin 2 => if i.val = 0 then {coords[0]} else {coords[1]})'
    probe += f'''\nprivate theorem review_{name} : ReviewGridConclusion {N} {p} {d} := by
  unfold ReviewGridConclusion
  refine exists_nearestPivotGrid_residue {N} {p} (by omega) (by omega)
    {d} {real(t)} {real(alpha)} ?_ ?_ ?_ ?_
  · {norm_proof(t, p, alpha).replace(chr(10), chr(10)+'    ')}
'''
    if not coords:
        probe += '  · intro i; exact Fin.elim0 i\n'
    else:
        probe += '  · intro i; fin_cases i\n'
        for v in coords:
            probe += '    · ' + norm_proof(t, v, alpha).replace('\n','\n      ') + '\n'
    probe += '  · norm_num\n'
    if not coords:
        probe += '  · intro i; exact Fin.elim0 i\n'
    else:
        probe += '  · intro i; fin_cases i <;> norm_num\n'
    probe += f'#print axioms review_{name}\n'
probe += '''
example : 12 ∈ pivotCandidates 5 8 ∧ 12 ∉ pivotBadResidues 5 8 4 := by decide
example : 27 ∈ pivotCandidates 5 8 ∧ 28 ∈ pivotCandidates 5 8 ∧
    27 ∉ pivotBadResidues 5 8 4 ∧ 28 ∉ pivotBadResidues 5 8 4 := by decide
example : 1 ∈ pivotBadResidues 3 4 3 ∧ 2 ∈ pivotCandidates 3 4 ∧
    2 ∉ pivotBadResidues 3 4 3 := by decide
end LonelyRunner
#check LonelyRunner.exists_nearestPivotGrid_residue
#print axioms LonelyRunner.exists_nearestPivotGrid_residue
'''
env = os.environ.copy()
env['PATH'] = '/home/joshua/.elan/bin:' + env.get('PATH', '')
r = subprocess.run(['lake', 'env', 'lean', '--stdin'], input=source+probe,
                   text=True, capture_output=True, timeout=180, env=env)
print(r.stdout, end='')
print(r.stderr, end='')
assert r.returncode == 0, r.returncode
assert r.stdout.count('[propext, Classical.choice, Quot.sound]') == 6
assert 'sorryAx' not in r.stdout
print('fresh_source_and_5_full_contract_cases_and_3_kernel_residue_controls: passed')
```

Replay command used:

```bash
PYTHONDONTWRITEBYTECODE=1 python3 - <<'PY'
from pathlib import Path
p = Path('research/astra-nearest-grid-review.md')
code = p.read_text().split('```python\n')[1].split('\n```', 1)[0]
exec(compile(code, str(p), 'exec'))
PY
```

Final observed outcome: exit 0. The five manuscript outcome fields passed.
Fresh elaboration of the entire frozen source, all five full-contract cases,
and all three kernel finite-residue controls passed. The public theorem and
each of the five concrete applications reported exactly
`[propext, Classical.choice, Quot.sound]`, with no other axiom. The checked
public type retained arbitrary natural coordinates, both explicit original
witness hypotheses, the strict pivot margin, the correctly directed
coordinate margins, natural candidate membership, strict bad-set exclusion,
and closed real norm conclusions for the pivot and every coordinate.
Only nonblocking style-linter warnings were emitted. Initial reviewer harness
attempts had tactic indentation and natural-cast conversion errors; these were
fixed only in this review's code before the recorded successful replay.
The frozen source did not require a change.

**Disposition: accepted.** The manuscript's generic nearest transport,
stronger two-neighbor theorem, one-owner boundary, and explicitly conditional
minimal-count/cover consequences are mathematically sound as stated. The
freshly checked Lean declaration implements the generic transport contract,
including its stronger arbitrary-natural-coordinate form. This review does
not claim that the two-neighbor, ordinary-witness numerical corollaries, or
minimal-count wrappers are yet formalized by this source. The unrestricted
canonical conjecture and global Prompt95 premise remain unresolved.

All review commands completed. No build, search, or verifier launched by this
review remains running; no full build or dependency restoration was launched.
