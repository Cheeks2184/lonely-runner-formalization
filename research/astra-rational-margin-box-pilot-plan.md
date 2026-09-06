# Rational-margin box pilot: settled semantic plan

2026-09-06. Requested Astra/xhigh author `/root/mixed_equivalence_freeze`;
routing is requested, not independently attested. Owned file: this manuscript
only. Configuration, workflow, policy and active state were read; the structural
validator passed. Base checkpoint is `d1ac311bef74afad9220e19cb76077cc97f60b6f`.
The three pending Pass36 cores are source dependencies, not results of this
task. No Lean execution, cache access, source/state/Git edit, tuple enumeration
or certificate discovery is part of this plan. The unrestricted goal remains
active and unresolved. This future pilot is excluded from Pass36.

**Recommendation:** implement one additive box/partition module and exactly the
two supplied leaves below after independent review. The scalar band argument
is sound for arbitrary nonnegative rational margins, including zero. Derive
child boxes from split data; require a well-formed root box in the public
checker. This gives a reusable coverage theorem and a twelve-row toy region,
not a finite K5 certificate or any uniform supply claim.

## Definitions and exact contracts

Proposed names below belong to `LonelyRunner`; these are planned declarations,
not compiled Lean. A single import of `RationalMarginCertificates` also exposes
`StructuredClasses.circleNorm_ge_of_int_band` (the declaration itself is in
`LonelyRunner`) through `PivotResidues`.

```lean
structure NatSpeedBox (n : Nat) where
  lo : Fin n → Nat
  hi : Fin n → Nat

def NatSpeedBox.Contains (B : NatSpeedBox n) (w : Fin n → Nat) : Prop :=
  ∀ i, B.lo i ≤ w i ∧ w i ≤ B.hi i
def NatSpeedBox.WellFormed (B : NatSpeedBox n) : Prop :=
  ∀ i, B.lo i ≤ B.hi i

structure RationalMarginBandLeaf (n : Nat) where
  p : Nat
  q : Nat
  band : Fin n → Nat

inductive RationalMarginBoxTree (n : Nat) where
  | leaf (data : RationalMarginBandLeaf n)
  | split (i : Fin n) (cut : Nat)
      (left right : RationalMarginBoxTree n)
```

For `d : RationalMarginBandLeaf n`, let `leafOK B num den d` be `decide` of
`0 < d.p ∧ 0 < d.q ∧ ∀ i, 0 < den i ∧ lower_i ∧ upper_i`, where

```
lower_i: den_i * band_i * q + num_i * q ≤ den_i * p * lo_i
upper_i: den_i * p * hi_i + num_i * q ≤ den_i * (band_i + 1) * q
```

There is no natural subtraction, no reduced-fraction requirement, no bound
`p < q`, and no positive-speed, injectivity or nonempty-index assumption.
The field is a **band index**, not an assertion of the actual floor: at zero
margin the permitted upper endpoint is an integer with floor `band_i + 1`.
For example speed 1, time 1, zero margin and band 0 must be accepted.

The raw leaf theorem should preserve its useful vacuous scope:

```lean
theorem rationalMarginBandLeafOK_row
    (B : NatSpeedBox n) (num den : Fin n → Nat)
    (d : RationalMarginBandLeaf n)
    (hd : leafOK B num den d = true)
    (w : Fin n → Nat) (hw : B.Contains w) :
    rationalMarginRowOK w num den d.p d.q = true
```

Prove also the direct common-time statement with conclusion
`0 < (d.p : ℝ) / d.q ∧ ∀ w, B.Contains w → ∀ i,
 (num i : ℝ) / den i ≤ circleNorm (((d.p : ℝ) / d.q) * (w i : ℝ))`.
This is one fixed positive time for the entire leaf box.

For tree recursion, define `B.left i cut` with upper function
`Function.update B.hi i cut` and unchanged lower function; define
`B.right i cut` with lower function `Function.update B.lo i (cut + 1)` and
unchanged upper function. Children do **not** carry independent box bounds.
Define `treeOKCore` by structural recursion: the leaf case calls `leafOK`;
the split case conjoins `decide (B.lo i ≤ cut ∧ cut < B.hi i)` with the
recursive checks of these two derived boxes. Both children must pass.
The public `rationalMarginBoxTreeOK` additionally conjoins
`decide B.WellFormed`. It is decidable by finite-coordinate quantification.

Recommended principal tree contract:

```lean
theorem rationalMarginBoxTreeOK_row
    (B : NatSpeedBox n) (num den : Fin n → Nat)
    (tree : RationalMarginBoxTree n)
    (h : rationalMarginBoxTreeOK B num den tree = true)
    (w : Fin n → Nat) (hw : B.Contains w) :
    ∃ p q : Nat, 0 < p ∧ rationalMarginRowOK w num den p q = true
```

The existing `rationalMarginRowOK_exists_positive_time` immediately yields
`∀ w, B.Contains w → ∃ t : ℝ, 0 < t ∧ ∀ i,
 (num i : ℝ) / den i ≤ circleNorm (t * (w i : ℝ))`.
The tree has the quantifier order **forall row, exists time**; a common time
across different leaves is neither needed nor asserted. Retain the row theorem
so later callers can reuse rational witnesses without another completeness
argument. There is no assumption or conclusion of strict margins.

## Proof and edge scope

Fix a contained row and coordinate, and abbreviate its natural data by
`A,B,p,q,k,w`, with positive `B,q`. Monotonicity of multiplication transfers
the lower endpoint check through `lo ≤ w` and the upper check through
`w ≤ hi`. Casting and dividing by the positive real number `B*q` gives

```
k + δ ≤ x,       x + δ ≤ k + 1,
δ = A/B ≥ 0,     x = (p/q)*w.
```

Adding yields `2δ ≤ 1`. Apply `circleNorm_ge_of_int_band (k : ℤ) x δ`,
with the derived half bound and the upper inequality rearranged over reals.
The actual source theorem accepts closed endpoints and zero δ. Then apply
`rationalMarginRowOK_circleNorm_iff` with positive q and denominators. Positive
p,q prove the particular leaf time is positive. This route never equates a
zero-margin band index with a floor or performs natural subtraction.

Thus no explicit `2*num_i ≤ den_i` premise is needed: any contained row forces
it. A root well-formedness guard ensures `lo` itself is contained, so accepted
public certificates cannot hide impossible margins in empty boxes. The raw
leaf theorem remains valid on an empty box, vacuously. An extra half-margin
guard would be redundant on nonempty boxes, while restricting that vacuous
raw API; omit it. For `n=0` there are no coordinates, the empty function is a
row, and a positive-time leaf is still valid. A split at `Fin 0` is impossible.

Prove split coverage before the recursive theorem. For any contained w, either
`w i ≤ cut` and w lies in the left child, or `cut < w i`, whence the natural
discreteness implication `cut+1 ≤ w i` puts it in the right child. The other
coordinates retain the same bounds. Conversely each child is contained in the
parent using the split guard. A row cannot be in both children. Equality at
cut belongs to the left, equality at cut+1 to the right; no real-interval gap
argument substitutes for this natural-number proof. Well-formedness of both
children follows from the root guard and valid split. Induction on the tree,
generalizing B and w, selects the corresponding child theorem. Soundness of
the core itself does not require B to be nonempty.

No parser is needed for the first pilot: write a typed Lean tree literal. It
always has two children at every split and valid coordinate indices. If an
external data decoder is introduced later, malformed shapes or mismatched
dimensions must return failure, and its output must still pass this checker.

## Exactly the supplied two-leaf region

The root is `lo=(2,3,5,6)`, `hi=(3,4,5,8)`, with `num=(1,1,1,1)` and
`den=(5,5,5,4)`. Its cardinality is the product `2*2*1*3=12`, computed
algebraically, without enumerating its rows. Split coordinate 3 at cut 7.

| Leaf | p/q | band | Lower comparisons (coordinate order) | Upper comparisons |
|---|---|---|---|---|
| H from 6 through 7 | 1/10 | (0,0,0,0) | 10≤10; 10≤15; 10≤25; 10≤24 | 25≤50; 30≤50; 35≤50; 38≤40 |
| H equal to 8 | 5/32 | (0,0,0,1) | 32≤50; 32≤75; 32≤125; 160≤160 | 107≤160; 132≤160; 157≤160; 192≤256 |

These are all sixteen endpoint inequalities. The fastest quarter equality in
the right leaf and the lower fifth equality in the left are retained. The
root permits repeated coordinates, for example (3,3,5,8); the generic theorem
covers them. Restricting afterward to `0<a<b<c<H` is a direct implication,
not a requirement of leaf soundness or partition completeness.

The unsplit 1/10 leaf fails: at H=8 its upper test is `42 ≤ 40`, false, and
its fastest norm is exactly 1/5. A cut at 5 is below lo, and a cut at 8 equals
hi; both are rejected. Omitting a child is unrepresentable by the inductive
type. Supplying a leaf that fails on one child rejects the whole tree. Forged
child bounds are also unrepresentable: shortening the left high endpoint to
6 while the right starts at 8 would miss the named parent row (2,3,5,7).
Starting the right at 9 would miss (2,3,5,8). Both illustrate why derived
child bounds, rather than separately trusted rectangles, are essential.

## Implementation boundary and resource gate

The next implementation should contain the generic scalar/leaf argument,
split coverage, structural soundness and this two-leaf literal with a checked
acceptance proof, plus exact rejection/edge controls. Use ordinary kernel
evaluation (`decide`, `norm_num` as appropriate), never `native_decide` or an
unchecked external certificate assertion. Existing APIs remain additive and
unchanged. No discovery code, tuple iterator, K5 wrapper or global certificate
belongs to this checkpoint.

Proposed hard caps for later proof data are 256 leaves, 64 KiB of explicit
UTF-8 certificate data (including root, margins and tree), 60 seconds per
kernel check, and 4 GiB peak RSS. This full binary tree has only two leaves;
in general 256 leaves allow at most 511 nodes. Reject oversized data before
elaboration/evaluation and externally enforce time/RSS limits. The byte limit
does not bound expanded proof terms or guarantee kernel runtime. Apply the
time cap to each whole acceptance or soundness-instance check, not to tiny
subchecks that hide an unbounded aggregate. Record exact pinned commands and
actual resource results in the later implementation report. On a cap breach,
stop that pilot and report it; do not silently expand the budget or generalize
coverage. **No pilot resource usage or Lean success is claimed here.**

This tests reuse of one rational time on a box and exact partition coverage.
It supplies no evidence that the remaining normalized N5 region admits a
small tree. A proof of K5 still needs a complete finite-domain reduction and
coverage, with strict ordinary and closed mixed contracts kept distinct.

## Fixed-check status and provenance

The following sole Python block guards the exact source/design bytes used.
It checks only the named two-leaf construction, malformed alternatives and
scalar/empty-index edge cases; loops range over coordinates, source guards
or this fixed list of controls. It does not enumerate any speed tuples.
Python results test the concrete data and do not replace the symbolic proof
or the future Lean soundness theorem.

```python
from hashlib import sha256
from pathlib import Path

guards = {
    'LonelyRunner/RationalMarginCertificates.lean':
        'ffe31ce9636281f6c4b8fc2cdf618043a6c02b0195bf75ff6e0aee65c317c1d9',
    'LonelyRunner/StructuredClasses.lean':
        '5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c',
    'LonelyRunner/EndpointCompleteness.lean':
        '0e3f10f64daf41bedebf31bb71cb6b93ffa5358615c6c30ec941b01fc97b9d57',
    'LonelyRunner/StrictPairSumCompleteness.lean':
        '549e879d49b54560a56f402aec18d64b6b227f86a71821a28c13c7356f622bd6',
    'research/astra-five-runner-certificate-design.md':
        'cc7990790d3ca8ddd50d36dc64d80af74b1f82d45b64ba20e31fbbc0b78fc403',
    'research/astra-five-runner-certificate-design-review.md':
        'c86e42c2ed14c015f83776644469827a850614fc6fbdd5c55a96ce61c8b12b40',
}
for path, expected in guards.items():
    assert sha256(Path(path).read_bytes()).hexdigest() == expected, path

def natural(x):
    return type(x) is int and x >= 0

def comparisons(lo, hi, num, den, p, q, band):
    return tuple(((b*k*q+a*q, b*p*l), (b*p*h+a*q, b*(k+1)*q))
                 for l,h,a,b,k in zip(lo,hi,num,den,band))

def leaf(lo, hi, num, den, p, q, band):
    n = len(lo)
    if not all(len(v) == n for v in (hi,num,den,band)):
        return False
    if not all(natural(x) for v in (lo,hi,num,den,band) for x in v):
        return False
    if not natural(p) or not natural(q) or p == 0 or q == 0:
        return False
    return all(b > 0 for b in den) and all(
        x <= y for pair in comparisons(lo,hi,num,den,p,q,band) for x,y in pair)

def replace(v, i, x):
    return v[:i] + (x,) + v[i+1:]

def core(lo, hi, num, den, tree):
    if type(tree) is not tuple or not tree:
        return False
    if tree[0] == 'leaf' and len(tree) == 4:
        return leaf(lo,hi,num,den,*tree[1:])
    if tree[0] != 'split' or len(tree) != 5:
        return False
    _,i,cut,left,right = tree
    if not natural(i) or i >= len(lo) or not natural(cut):
        return False
    return (lo[i] <= cut < hi[i]
            and core(lo,replace(hi,i,cut),num,den,left)
            and core(replace(lo,i,cut+1),hi,num,den,right))

def check(lo, hi, num, den, tree):
    if not all(type(v) is tuple and len(v) == len(lo) for v in (lo,hi,num,den)):
        return False
    return (all(natural(x) for v in (lo,hi,num,den) for x in v)
            and all(l <= h for l,h in zip(lo,hi))
            and core(lo,hi,num,den,tree))

def contains(lo, hi, w):
    return len(lo) == len(hi) == len(w) and all(
        l <= x <= h for l,h,x in zip(lo,hi,w))

lo,hi = (2,3,5,6),(3,4,5,8)
num,den = (1,1,1,1),(5,5,5,4)
left = ('leaf',1,10,(0,0,0,0))
right = ('leaf',5,32,(0,0,0,1))
tree = ('split',3,7,left,right)
lc = comparisons(lo,(3,4,5,7),num,den,*left[1:])
rc = comparisons((2,3,5,8),hi,num,den,*right[1:])
results = [
    ('two_leaf_accepts',check(lo,hi,num,den,tree)),
    ('left_eight_exact',lc == (((10,10),(25,50)),((10,15),(30,50)),
                             ((10,25),(35,50)),((10,24),(38,40)))),
    ('right_eight_exact',rc == (((32,50),(107,160)),((32,75),(132,160)),
                              ((32,125),(157,160)),((160,160),(192,256)))),
    ('unsplit_rejects',not check(lo,hi,num,den,left)),
    ('cut_below_lower_rejects',not check(lo,hi,num,den,('split',3,5,left,right))),
    ('cut_at_upper_rejects',not check(lo,hi,num,den,('split',3,8,left,right))),
    ('missing_child_rejects',not check(lo,hi,num,den,('split',3,7,left))),
    ('failed_child_rejects',not check(lo,hi,num,den,('split',3,7,left,left))),
    ('wrong_band_rejects',not check((2,3,5,8),hi,num,den,
                                  ('leaf',5,32,(0,0,0,0)))),
    ('left_gap_exhibited',contains(lo,hi,(2,3,5,7))
        and not contains(lo,(3,4,5,6),(2,3,5,7))
        and not contains((2,3,5,8),hi,(2,3,5,7))),
    ('right_gap_exhibited',contains(lo,hi,(2,3,5,8))
        and not contains(lo,(3,4,5,7),(2,3,5,8))
        and not contains((2,3,5,9),hi,(2,3,5,8))),
    ('zero_upper_integer',check((1,),(1,),(0,),(1,),('leaf',1,1,(0,)))),
    ('zero_speed_zero_margin',check((0,),(0,),(0,),(1,),('leaf',1,1,(0,)))),
    ('half_equality',check((1,),(1,),(1,),(2,),('leaf',1,2,(0,)))),
    ('above_half_rejects',not check((1,),(1,),(2,),(3,),('leaf',1,2,(0,)))),
    ('zero_den_rejects',not check((1,),(1,),(0,),(0,),('leaf',1,1,(0,)))),
    ('zero_q_rejects',not check((1,),(1,),(0,),(1,),('leaf',1,0,(0,)))),
    ('zero_p_rejects',not check((1,),(1,),(0,),(1,),('leaf',0,1,(0,)))),
    ('empty_raw_accepts',leaf((1,),(0,),(0,),(1,),1,1,(0,))),
    ('empty_public_rejects',not check((1,),(0,),(0,),(1,),('leaf',1,1,(0,)))),
    ('zero_dimension_accepts',check((),(),(),(),('leaf',1,1,()))),
]
for name, result in results:
    assert result, name
assert len(results) == 21
print('source_guards=6 passed')
print('left_comparisons=' + str(lc))
print('right_comparisons=' + str(rc))
print('fixed_controls=21 passed; endpoint_inequalities=16; tree_leaves=2')
print('root_rows_product=12; tuple_enumeration=none; Lean_execution=none')
```

Run from the repository root without writing a script, stdout file or cache:

```sh
python3 -B - <<'PY'
from contextlib import redirect_stdout
from hashlib import sha256
from io import StringIO
from pathlib import Path
s = Path('research/astra-rational-margin-box-pilot-plan.md').read_text()
assert s.count('```python\n') == 1
program = s.split('```python\n',1)[1].split('```',1)[0]
out = StringIO()
with redirect_stdout(out):
    exec(compile(program, '<box-pilot-fixed-controls>', 'exec'), {})
print(out.getvalue(), end='')
print('program_sha256=' + sha256(program.encode()).hexdigest())
print('stdout_sha256=' + sha256(out.getvalue().encode()).hexdigest())
PY
```

The exact command above completed with exit 0: all six source guards, sixteen
endpoint inequalities and twenty-one fixed controls passed. Program SHA-256
is `6297f1298e7df800ade421f63cb2ec57e4239cf7d6177e08904044352d39814b`;
captured stdout SHA-256 (the five printed result lines, excluding the two
hash-report lines) is
`b1f17b7de8ae306ed47efc9cf740772115dadf35d2be841c5bb8e4f8a0f3c946`.
The program bytes are exactly the sole Python fence contents, including their
final newline. `python3 -B scripts/validate_workflow.py` also passed; it checks
workflow structure only. All commands have stopped, with no running or queued
Lean, dependency, cache, verifier or search process owned by this task.

Freeze outcome: the proposed API, proof composition and two-leaf data are
semantically settled by this author for independent review. The next bounded
action is implementation of this exact generic checker and fixed pilot after
that review. No kernel result, measured compression benefit, K5 implication
or unrestricted LRC conclusion is supplied by this manuscript.
