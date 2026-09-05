# Formalization of three lower owners at denominator seven

Task `/root/guard_internal_cover_audit-three-owner-formalization`, requested
Astra/xhigh, 2026-09-05. Base main commit:
`a25799bfbbb41b4c31f222b25060a4d6e0e5d117` (PR12). Runtime model metadata beyond
the requested routing was not independently exposed to this worker.

The project configuration, workflow, policy, and active research state were
read; `python3 scripts/validate_workflow.py` passed before work and after the
completed source check. The worker owned only
`LonelyRunner/ThreeLowerOwnerSeven.lean` and this note. The earlier guard
audit remained frozen. No shared state, Git operation, root import, axiom-audit
file, dependency restoration, or cache cleanup was changed by this worker.
Compilation began only after root confirmed the shared dependencies ready.

## Completed exact declarations

The source compiles and exports exactly:

```lean
theorem threeLowerOwner_noncover_seven (p a b c : Nat)
    (ha : 0 < a) (hab : a < b) (hbc : b < c) (hcp : c < p) :
    ∃ r ∈ pivotCandidates 7 p,
      r ∉ pivotBadResidues 7 p a ∧ r ∉ pivotBadResidues 7 p b ∧
        r ∉ pivotBadResidues 7 p c
```

There is no supplied witness, bounded pivot, divisibility condition,
coprimality assumption on the original tuple, or weakened target. The
strict bad-set definition leaves equality at distance `p` safe. The second
public declaration, `threeLowerOwner_circleNorm_witness_seven`, returns the
same canonical residue and establishes the common **closed** circle-distance
bound `1/7` for all four speeds `p,a,b,c`, at time `r/(7*p)`.

Both declarations are under `namespace LonelyRunner`. Every auxiliary lemma
in this source is private. No unrestricted LRC declaration or implication
has been added. The theorem protects exactly the three listed lower owners
and their pivot; it does not protect additional arbitrary original speeds.

## Reviewed source contract

The complete accepted manuscript and independent review were read:

```text
f6130fd8ed2bda6b50aa73b64a6fcbdbacb27efb478163d0b6e4e9e12d69dc50  research/astra-next-bridge-audit.md
5fb7f5765e1a4dd802dee0a5fe9dec592faaaa51a3e51a519b56f26584c166df  research/astra-three-owner-review.md
```

The formal proof preserves their arithmetic content. It uses their permitted
common-scaling implementation option for the exceptional overlaps, avoiding
any valuation induction or coprimality assumption on the actual pivot.

## Proof structure

For each genuine lower speed `d`, the proof factors `h=gcd(d,p)` and obtains
`p=hP`, `d=hD`, `0<D<P`, `Coprime D P`, and
`gcd(D,7)=1` or `7`. The existing exact normalized cardinality theorem then
reduces every row count to the reviewed scalar lemmas in
`ThreeOwnerSevenArithmetic.lean`.

The resulting uniform bounds are:

```text
4*|B_d| <= 9*p;
8*d != 7*p  implies  |B_d| <= 2*p.
```

The only possible exception to the second inequality is the owner `7p/8`.
For an exceptional owner `s`, every different lower owner has the strict
remainder bound

```text
8*|B_d \ B_s| < 15*p.
```

Kernel-one rows satisfy this directly from `7*|B_d|<=12*p`. Kernel-seven
rows satisfy it from the raw scalar estimate except at normalized
`P=9,15,16,22`; `P=8` would force `d=s` and is excluded.

The finite exceptions reduce to six base rows:

| Pivot | Other owner | Exceptional owner |
| ---: | ---: | ---: |
| 72 | 56 | 63 |
| 120 | 56 | 105 |
| 120 | 112 | 105 |
| 16 | 7 | 14 |
| 88 | 28 | 77 |
| 88 | 84 | 77 |

For each row the kernel checks the closed finite proposition
`8*(B_other \ B_exceptional).card < 15*pivot` with `decide`. This is ordinary
kernel evaluation of a finite statement, with no `native_decide`, trusted
external search, or custom axiom.

A separately proved scaling identity says

```text
|B(7,t*p,t*d) \ B(7,t*p,t*s)| = t*|B(7,p,d) \ B(7,p,s)|
```

for `p,t>0`. It follows directly from
`mem_pivotBadResidues_scale_reduce_iff` and
`card_filter_range_mod_mem`. Thus these six finite calculations prove every
positive scaled instance. In detail, the star equation forces the gcd scale
`h` to be divisible by 8 for `P=9,15`, by 4 for `P=22`, and imposes no further
factor for `P=16`. The coprimality of normalized `D,P` excludes `D=14` in
the latter two cases. No unbounded case is discharged by finite sampling.

If one of the three owners is exceptional, the union cardinality is at most
its own cardinality plus the two remainders. The bounds give a strict total
below `6p`. If none is exceptional, all three counts are at most `2p`, and
the common bad candidate `1` makes the union strictly smaller than the sum.
Only this one common point is needed; the manuscript's stronger two-point
correction is not required. The positive complement in the `6p`-element
candidate row supplies the stated residue.

These are presentation simplifications of the accepted argument: no zero-set
classification is required in the final union split, and no hypothesis has
been added to avoid a difficult case.

## Verification and source binding

Frozen implementation SHA-256:

```text
8f65dc593228a1e639b7997746987c75b4312b18b4fcd591fd47d701714c7645  LonelyRunner/ThreeLowerOwnerSeven.lean
```

The root-owned dependency sources used by the successful compile were:

```text
1f05a8f42c2d49b86e3d234cbd72b01e9b3b30d75549b133aad030f51a61455a  LonelyRunner/ThreeOwnerSevenArithmetic.lean
a6199b77071b81868abffe0959c1b5aa4e64a06369adb93eddbc2fa7b6c90b7e  LonelyRunner/PeriodicPivotCounts.lean
49131a7f9690042d1b16cbc876417f9d9ce1b53cc6565f87b6d1b53c4e3340cd  LonelyRunner/Prompt99Scaling.lean
```

The final direct source check passed with exit code 0 and no diagnostics:

```bash
PATH="$HOME/.elan/bin:$PATH" lake env lean LonelyRunner/ThreeLowerOwnerSeven.lean
```

A separate fresh replay of the complete source plus type and axiom checks
also passed with exit code 0:

```bash
python3 - <<'PY' | PATH="$HOME/.elan/bin:$PATH" lake env lean --stdin
from pathlib import Path
print(Path('LonelyRunner/ThreeLowerOwnerSeven.lean').read_text())
print('#check LonelyRunner.threeLowerOwner_noncover_seven')
print('#check LonelyRunner.threeLowerOwner_circleNorm_witness_seven')
print('#print axioms LonelyRunner.threeLowerOwner_noncover_seven')
print('#print axioms LonelyRunner.threeLowerOwner_circleNorm_witness_seven')
PY
```

The printed types matched the declarations above. Exact axiom output:

```text
'LonelyRunner.threeLowerOwner_noncover_seven' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.threeLowerOwner_circleNorm_witness_seven' depends on axioms: [propext, Classical.choice, Quot.sound]
```

Intermediate failures were resolved: an unnecessary unbuilt
`PivotZeroKernel` import was removed; the complement used the wrong direction
of `Finset.card_pos` on its first pass; and the circle adapter needed explicit
`N := 7` and `pivot := p` to resolve tactic metavariables. No remaining error,
placeholder, or unproved helper is retained. No dependency was rebuilt by the
worker, and all worker compilation processes completed.

## Remaining integration and scope

The exact requested theorem and optional closed-distance adapter are complete
at local kernel-check scope. Root must independently review the frozen source,
add any desired project imports and axiom-audit entries, and perform its
integration/publication checks. This worker did not run the full project build
or claim independent review of its own code.

Unrestricted internal-cover redundancy and the canonical unrestricted Lonely
Runner Conjecture remain unresolved. The accepted three-owner sufficient
class is now formalized; a general existence input is still absent.
