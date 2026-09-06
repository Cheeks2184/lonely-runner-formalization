# Independent source review: affine phases, folded safe bands, and fiber transport

**Source semantic decision: accept all seven exact public contracts and the
ten-field `Prop` structure.** Execution decision: the one predeclared import-only probe passed all seven
public theorem types, the structure type/constructor/ten fields, and all seven
allowed-axiom checks. Source review and this execution are separate evidence.

The frozen reviewed sources are `SixthAffinePhase.lean` (SHA-256
`76e420713079ec0c3979e9b169cd78ecb6a932d6dc790ea7d9711adbb64b7d4b`),
`FoldedPairSafeBands.lean` (`00903bcb0c131fdb31ab87d55cea809249dfacbbd5861f82ab3a987d39b74b5f`),
and `AnchoredPairTransport.lean` (`63414c3ccb6c12c1ed8775cb7e18dccc84c30da42cd4be089ac336df75ceca43`),
all under `LonelyRunner/`. I read every definition and proof in these files.
I authored the larger two-divisible manuscript, not these Lean sources or their
corrections. This is independent source review of Terra's drafts with root's
corrections; the manuscript had a separate independent review at SHA-256
`4d499c4477e80445646c6f82fcb72e36009ed1b9fc35b0023dd278f399598f71`.
Assigned checkpoint: `cd15103`; requested route: Astra/xhigh; exposed observed
model/effort: null. Only this report is owned; shared source, state and cache
remain untouched. No build, mathematical search, numerical fixture, or table
computation is part of this review.

## Affine and residue contracts

`fract_sixth_affine_time` quantifies over arbitrary real t, natural d, and
signed integers α, β, z, e, assuming only `d = 6*z+e` after casting d to ℤ.
In particular, e need not be centered; α and β may be negative or zero; t may
be negative; d may be zero with a compatible decomposition. Set `x=t*d`.
Subtracting the two displayed real lifts gives the integer

    α*floor(x) + β*z,

because `x=floor(x)+fract(x)` and `d=6*z+e`. The proof presents exactly this
integer to `Int.fract_eq_fract.mpr`, casts the decomposition, and multiplies
both equalities by the corresponding signed coefficient before arithmetic.
There is no positivity argument that would exclude negative coefficients,
no natural subtraction, and no division by d.

`exists_centered_sixth_residue_of_not_dvd_three` assumes only natural d with
`¬3∣d`. Natural Euclidean division gives `d=6*q+r`, `0≤r<6`. The two omitted
remainders are justified by explicit divisibility witnesses: r=0 gives
`d=3*(2*q)`; r=3 gives `d=3*(2*q+1)`. Thus r is 1,2,4,5. The actual output
pairs (z,e) are `(q,1)`, `(q,2)`, `(q+1,-2)`, `(q+1,-1)`, respectively.
The quotient is adjusted in the last two cases; the theorem does not assert
z=d/6 for every centered residue. Its four-way disjunction includes the two
even residues and uses integer negatives. d=0 is excluded by the stated
nondivisibility premise, not by an added positivity assumption. The source's
symbolic `omega` split is an ordinary proof already in the imported module;
this review does not rerun a finite computation.

## All ten bands and both strict improvements

`FoldedPairSafeBands a b : Prop` has exactly the ten named closed inequalities
listed below. It imposes no extra fields, no maximality or comparison premise,
and no safe conclusion for `5*b` or `3*b`. The constructor theorem assumes
only `1/8≤a<1/6` and `11/30<b<7/18`; these real interval hypotheses supply
all the bounds. The explicit ranges below are algebraic derivations, not
executed arithmetic fixtures. Each lies in the indicated closed integer band.

| Field | Phase | Range from the hypotheses | Band used |
| --- | --- | --- | --- |
| `left_two` | 2a | [1/4,1/3) | [1/6,5/6] |
| `left_three` | 3a | [3/8,1/2) | [1/6,5/6] |
| `left_four` | 4a | [1/2,2/3) | [1/6,5/6] |
| `left_half` | a+1/2 | [5/8,2/3) | [1/6,5/6] |
| `left_two_half` | 2a+1/2 | [3/4,5/6) | [1/6,5/6] |
| `right_one` | b | (11/30,7/18) | [1/6,5/6] |
| `right_two` | 2b | (11/15,7/9) | [1/6,5/6] |
| `right_four` | 4b | (22/15,14/9) | [7/6,11/6] |
| `right_two_half` | 2b+1/2 | (37/30,23/18) | [7/6,11/6] |
| `right_three_half` | 3b+1/2 | (8/5,5/3) | [7/6,11/6] |

The proof's two local band lemmas call `circleNorm_ge_of_int_band` at integer
q=0 and q=1, δ=1/6. Both are closed-band calls, so the structure keeps the
required `≤` conclusions. The constructor supplies all ten fields in their
actual declaration order. No folded norm identity is being substituted for
these raw real phases.

`small_folded_three_five_improve` has the weaker input `0<a<1/6`, without the
1/8 lower bound or any b. The strict integer-band theorem at q=0, δ=a applies:
`a<3a<1-a` follows from positivity and `4a<1`; likewise
`a<5a<1-a` follows from positivity and `6a<1`. Hence both norms are strictly
greater than a. The strict upper input matters, particularly for `5a` at
`a=1/6`; the code preserves it and makes no endpoint extension.

`circleNorm_double_half_gt_of_small` assumes only `N(x)<1/6` for arbitrary
real x. Set y=N(x); nonnegativity is derived from the absolute residual
formula, giving `0≤y<1/6`. The checked natural-dilation half-shift identity
at n=2 and signed integer β=1 gives `N(2x+1/2)=N(2y+1/2)`.
Now `1/6<2y+1/2<5/6`, including y=0, and the strict band theorem proves
the claimed strict sixth-margin improvement. Negative x and integer x are
covered; there is no assumption `0<x<1/6` hiding behind the norm premise.

## Exact fiber transport

`fract_int_dilate_eq` is exactly the affine theorem specialized to natural
d=1 and integer β=z=0, e=1. It retains arbitrary signed integer n and arbitrary
real x, including n=0 and negative x. It asserts fractional-part equality,
not equality of the unreduced real products.

`pair_min_le_of_special_sixth_fiber_bound` takes natural a,b,c with `3∣a`,
`3∣b`, `¬3∣c`, arbitrary real M, a supplied universal bound hmax on the
anchor's 5/6 fiber, and arbitrary real t at one of the three exact anchor
phases 1/6,1/2,5/6. The measured speeds may be zero or equal; the anchor is
nonzero as a consequence of its nondivisibility. No inequality comparing a,b,c,
no finite family, seed, time positivity, maximum attainment or M>0 occurs.

The special-phase theorem supplies one k in Fin 3 taking the anchor to 5/6.
Set `s=t+k.val/3`; the source proves the exact product identity for c and
applies hmax to this s. Since a,b are divisible by three, the rational-shift
periodicity theorem preserves each of their norms under the SAME shift.
Rewriting these two equalities in the bound proves the conclusion at t.
Nothing requires s or t to be positive. M=0 is admitted. Negative M is also
quantified without an extra hypothesis; in fact its supplied hmax would be
unsatisfiable because c>0 makes the fiber nonempty and both norms are
nonnegative. The proof does not assume this observation or use M's sign.
The binder name `hmax` denotes only an upper bound, not an asserted maximum.

I read the immediate project dependencies `FoldedCirclePhase`, `RealPhaseBands`,
`SpecialSixthPhase`, and `RationalShiftOrbits` in full. Their relevant proofs
supply signed half-folding, strict bands, special-phase third shifts, and
periodicity; `StructuredClasses` and `FastRunnerInsertion` supply the quotient
norm and closed bands. These interfaces are also guarded below, as is the
immediate mathlib tactic umbrella. The reviewed declarations use ordinary
kernel proof terms and no custom axiom, sorry/admit or native computation.
The import-only probe checks their full transitive axiom lists.

Root's separate `research/astra-pass49-verification.json` was read at SHA-256
`925a786def2f848c75041d370e9a8e8929c2c6206b2df4ab5f177ec4b9dee954`.
It preserves the affine floor-name/divisor-witness failure, the safe-band
cast/normalization failures, and the transport rewrite-shape failure, followed
by final exits 0 at 3016 joint jobs, 3002 jobs and 3008 jobs respectively.
Those are root's source-build records, not this reviewer's executions. They
are not discarded or interpreted as new mathematical counterexamples.

## Predeclared single import-only probe

The payload has three direct imports, seven full universal theorem assignments,
a `ℝ → ℝ → Prop` structure type assignment, its exact ten-input constructor
assignment, all ten field projection assignments, and seven full axiom prints.
There are no fixtures, new arithmetic proofs, finite tables or formatting
options. This probes all fields individually and rules out an unnoticed extra
constructor premise. The full UTF-8 fence bytes, including their final newline,
are bound by the following hashes before execution.

Probe SHA-256: `fe3aef017915ad2460f20160b3ee4f4730a77c2cd1f940cca1e6477ebe7c94ff`
Launcher SHA-256: `378e530ed4cd98122ef4039ebbe2184b90cdb6ff4e7eff40963fc3a865e632a0`

The single Bash entry contains the complete Python controller. It checks all
25 literal source/olean/pin/runtime guards before and after the invocation,
checks the two predeclared hashes, and pins PATH so the checked Lean/Lake
executables are the actual resolved commands. Lean uses the pinned v4.32.1
runtime and manifest (mathlib `520045ab14e26149ee970e2e617ca04b09bde5d6`).
Only `lake env lean -j1 -s65536 --stdin` is launched, with environment threads
1 and stack 65536 KiB; AS 8 GiB; CPU soft/hard 59/60 seconds; wall 60 seconds;
regular stdout/stderr files each limited to 128 KiB; core dumps disabled.
Timeout kills the child process group. There is no automatic retry or cap
escalation, and any error, signal, timeout or capped stream makes the result
fail. The complete raw streams and receipt survive either outcome.

The axiom parser requires exactly the seven named reports, in order, with no
extra stdout, duplicate/disallowed axiom, or stderr. Allowed axioms are only
`propext`, `Classical.choice`, `Quot.sound`. The controller snapshots this report;
that snapshot's hash changes on root's replay after the actual evidence is
appended. The Lean payload, Bash entry, guards and caps remain unchanged.

```lean
import LonelyRunner.SixthAffinePhase
import LonelyRunner.FoldedPairSafeBands
import LonelyRunner.AnchoredPairTransport

open LonelyRunner

example :
    ∀ (t : ℝ) (d : ℕ) (α β z e : ℤ), (d : ℤ) = 6 * z + e →
      Int.fract (((α : ℝ) * t + (β : ℝ) / 6) * (d : ℝ)) =
        Int.fract ((α : ℝ) * Int.fract (t * (d : ℝ)) +
          ((β * e : ℤ) : ℝ) / 6) :=
  LonelyRunner.fract_sixth_affine_time

example :
    ∀ d : ℕ, ¬ 3 ∣ d →
      ∃ z e : ℤ, (d : ℤ) = 6 * z + e ∧
        (e = 1 ∨ e = -1 ∨ e = 2 ∨ e = -2) :=
  LonelyRunner.exists_centered_sixth_residue_of_not_dvd_three

example :
    ∀ a b : ℝ, (1 : ℝ) / 8 ≤ a → a < (1 : ℝ) / 6 →
      (11 : ℝ) / 30 < b → b < (7 : ℝ) / 18 → FoldedPairSafeBands a b :=
  LonelyRunner.foldedPairSafeBands_of_bounds

example :
    ∀ a : ℝ, 0 < a → a < (1 : ℝ) / 6 →
      a < circleNorm (3 * a) ∧ a < circleNorm (5 * a) :=
  LonelyRunner.small_folded_three_five_improve

example :
    ∀ x : ℝ, circleNorm x < (1 : ℝ) / 6 →
      (1 : ℝ) / 6 < circleNorm (2 * x + 1 / 2) :=
  LonelyRunner.circleNorm_double_half_gt_of_small

example :
    ∀ (n : ℤ) (x : ℝ),
      Int.fract ((n : ℝ) * x) = Int.fract ((n : ℝ) * Int.fract x) :=
  LonelyRunner.fract_int_dilate_eq

example :
    ∀ (a b c : ℕ), 3 ∣ a → 3 ∣ b → ¬ 3 ∣ c → ∀ M : ℝ,
      (∀ s : ℝ, Int.fract (s * (c : ℝ)) = (5 : ℝ) / 6 →
        min (circleNorm (s * (a : ℝ))) (circleNorm (s * (b : ℝ))) ≤ M) →
      ∀ t : ℝ,
        (Int.fract (t * (c : ℝ)) = (1 : ℝ) / 6 ∨
          Int.fract (t * (c : ℝ)) = (1 : ℝ) / 2 ∨
          Int.fract (t * (c : ℝ)) = (5 : ℝ) / 6) →
        min (circleNorm (t * (a : ℝ))) (circleNorm (t * (b : ℝ))) ≤ M :=
  LonelyRunner.pair_min_le_of_special_sixth_fiber_bound

example : ℝ → ℝ → Prop := LonelyRunner.FoldedPairSafeBands

example :
    ∀ a b : ℝ,
      (1 : ℝ) / 6 ≤ circleNorm (2 * a) →
      (1 : ℝ) / 6 ≤ circleNorm (3 * a) →
      (1 : ℝ) / 6 ≤ circleNorm (4 * a) →
      (1 : ℝ) / 6 ≤ circleNorm (a + 1 / 2) →
      (1 : ℝ) / 6 ≤ circleNorm (2 * a + 1 / 2) →
      (1 : ℝ) / 6 ≤ circleNorm b →
      (1 : ℝ) / 6 ≤ circleNorm (2 * b) →
      (1 : ℝ) / 6 ≤ circleNorm (4 * b) →
      (1 : ℝ) / 6 ≤ circleNorm (2 * b + 1 / 2) →
      (1 : ℝ) / 6 ≤ circleNorm (3 * b + 1 / 2) →
      FoldedPairSafeBands a b :=
  @LonelyRunner.FoldedPairSafeBands.mk

example : ∀ a b : ℝ, FoldedPairSafeBands a b →
    (1 : ℝ) / 6 ≤ circleNorm (2 * a) :=
  @LonelyRunner.FoldedPairSafeBands.left_two
example : ∀ a b : ℝ, FoldedPairSafeBands a b →
    (1 : ℝ) / 6 ≤ circleNorm (3 * a) :=
  @LonelyRunner.FoldedPairSafeBands.left_three
example : ∀ a b : ℝ, FoldedPairSafeBands a b →
    (1 : ℝ) / 6 ≤ circleNorm (4 * a) :=
  @LonelyRunner.FoldedPairSafeBands.left_four
example : ∀ a b : ℝ, FoldedPairSafeBands a b →
    (1 : ℝ) / 6 ≤ circleNorm (a + 1 / 2) :=
  @LonelyRunner.FoldedPairSafeBands.left_half
example : ∀ a b : ℝ, FoldedPairSafeBands a b →
    (1 : ℝ) / 6 ≤ circleNorm (2 * a + 1 / 2) :=
  @LonelyRunner.FoldedPairSafeBands.left_two_half
example : ∀ a b : ℝ, FoldedPairSafeBands a b →
    (1 : ℝ) / 6 ≤ circleNorm b :=
  @LonelyRunner.FoldedPairSafeBands.right_one
example : ∀ a b : ℝ, FoldedPairSafeBands a b →
    (1 : ℝ) / 6 ≤ circleNorm (2 * b) :=
  @LonelyRunner.FoldedPairSafeBands.right_two
example : ∀ a b : ℝ, FoldedPairSafeBands a b →
    (1 : ℝ) / 6 ≤ circleNorm (4 * b) :=
  @LonelyRunner.FoldedPairSafeBands.right_four
example : ∀ a b : ℝ, FoldedPairSafeBands a b →
    (1 : ℝ) / 6 ≤ circleNorm (2 * b + 1 / 2) :=
  @LonelyRunner.FoldedPairSafeBands.right_two_half
example : ∀ a b : ℝ, FoldedPairSafeBands a b →
    (1 : ℝ) / 6 ≤ circleNorm (3 * b + 1 / 2) :=
  @LonelyRunner.FoldedPairSafeBands.right_three_half

#print axioms LonelyRunner.fract_sixth_affine_time
#print axioms LonelyRunner.exists_centered_sixth_residue_of_not_dvd_three
#print axioms LonelyRunner.foldedPairSafeBands_of_bounds
#print axioms LonelyRunner.small_folded_three_five_improve
#print axioms LonelyRunner.circleNorm_double_half_gt_of_small
#print axioms LonelyRunner.fract_int_dilate_eq
#print axioms LonelyRunner.pair_min_le_of_special_sixth_fiber_bound
```

```bash
#!/usr/bin/env bash
set -euo pipefail
cd /home/joshua/lonely-runner-formalization
export PATH="/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin:$HOME/.elan/bin:$PATH"
export LEAN_NUM_THREADS=1
export LEAN_STACK_SIZE_KB=65536
python3 - <<'PY'
import hashlib
import json
import os
from pathlib import Path
import re
import resource
import signal
import shutil
import subprocess
import tempfile
import time

root = Path('/home/joshua/lonely-runner-formalization')
report = root / 'research/astra-affine-bands-transport-source-review.md'
text = report.read_text()
fence = chr(96) * 3
probe = text.split(fence + 'lean\n', 1)[1].split(fence, 1)[0].encode()
launcher = text.split(fence + 'bash\n', 1)[1].split(fence, 1)[0].encode()
out = Path(tempfile.mkdtemp(prefix='astra-affine-bands-transport-review-'))
(out / 'stdin.bin').write_bytes(probe)
(out / 'launcher.sh').write_bytes(launcher)
(out / 'report-snapshot.md').write_bytes(text.encode())
guards = {
    'LonelyRunner/SixthAffinePhase.lean': '76e420713079ec0c3979e9b169cd78ecb6a932d6dc790ea7d9711adbb64b7d4b',
    '.lake/build/lib/lean/LonelyRunner/SixthAffinePhase.olean': '9a0cbfec2825c4b98fc7897835dc726929daabb3328a2d45818765c568cf47b3',
    'LonelyRunner/FoldedPairSafeBands.lean': '00903bcb0c131fdb31ab87d55cea809249dfacbbd5861f82ab3a987d39b74b5f',
    '.lake/build/lib/lean/LonelyRunner/FoldedPairSafeBands.olean': 'd000b970290ec9072f02465f527b817f32bb72113ed7fa09bd43c9f0a47287c8',
    'LonelyRunner/AnchoredPairTransport.lean': '63414c3ccb6c12c1ed8775cb7e18dccc84c30da42cd4be089ac336df75ceca43',
    '.lake/build/lib/lean/LonelyRunner/AnchoredPairTransport.olean': '5254122c6d4ab3e583adf5676fe05aa7268dfa3412e2aee7889fbacc3832a07e',
    'LonelyRunner/FoldedCirclePhase.lean': '957606878108847d5ceff47be621ff0fc9c0a0d976568b5f5ef3dbb6db10481e',
    '.lake/build/lib/lean/LonelyRunner/FoldedCirclePhase.olean': '3032bbcf8e5c414daea831a7a415a40b4f254e5b72428b6fa078742e891afc06',
    'LonelyRunner/RealPhaseBands.lean': '7f70467bad6bb5a8a859bff8947af1dc73e685910b69157b49bab259b3c02ca0',
    '.lake/build/lib/lean/LonelyRunner/RealPhaseBands.olean': '7442f9f49d9f1e2d214460557f6a891ba13717ededff679876033793ac2c6504',
    'LonelyRunner/SpecialSixthPhase.lean': '677372ee3dc86520051f4bcc037f685a3f5fd8748c737ef9e1d2bfc5ac0072d8',
    '.lake/build/lib/lean/LonelyRunner/SpecialSixthPhase.olean': '2e4951ab757b0fa22574e72381abd7be6cca5c971f9e38967cf24f0991532537',
    'LonelyRunner/RationalShiftOrbits.lean': 'cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591',
    '.lake/build/lib/lean/LonelyRunner/RationalShiftOrbits.olean': '8194c5c6ac0b8495146728fcac70a6a1e9d317f9e7689c4759f22ed33c14340f',
    'LonelyRunner/StructuredClasses.lean': '5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c',
    '.lake/build/lib/lean/LonelyRunner/StructuredClasses.olean': '4ada0ca2f0a5f20a8c83c3c2e58256e931c3b283882a88a074aeedb02d7e048f',
    'LonelyRunner/FastRunnerInsertion.lean': 'dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5',
    '.lake/build/lib/lean/LonelyRunner/FastRunnerInsertion.olean': '121edfbaed0d7b9fed32bacf891de838142988e48dcb4e7f2bed0c488ea49136',
    '.lake/packages/mathlib/Mathlib/Tactic.lean': 'c6f2c548596b635a3d5c8aff8b19cbdeb60dd54e41bb89a1cd03b1a54d335fa5',
    '.lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Tactic.olean': '0534ef12e7aaf8ffbb6e520a91f922da4469d0dca2b54c87b4458e1faa28a6a2',
    'lean-toolchain': '8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af',
    'lakefile.toml': 'bdcbaaa18d518409619215e8acf7892452c1fa5c6e80ba742ce67f7380682a26',
    'lake-manifest.json': '887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218',
    '/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lean': 'e8baaa71855a616dc351028f3ad2200051b0671f423a1696a100e809302d5550',
    '/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lake': '60330ab6f07dce20f3fa9ebb08e8b984ea9549eac172afeb15d9d2227060e2b3',
}
argv = ['lake', 'env', 'lean', '-j1', '-s65536', '--stdin']
limits = {'address_space_bytes': 8 * 1024**3, 'cpu_seconds': [59, 60],
          'wall_seconds': 60, 'stream_bytes': 128 * 1024}
symbols = [
    'LonelyRunner.fract_sixth_affine_time',
    'LonelyRunner.exists_centered_sixth_residue_of_not_dvd_three',
    'LonelyRunner.foldedPairSafeBands_of_bounds',
    'LonelyRunner.small_folded_three_five_improve',
    'LonelyRunner.circleNorm_double_half_gt_of_small',
    'LonelyRunner.fract_int_dilate_eq',
    'LonelyRunner.pair_min_le_of_special_sixth_fiber_bound',
]
allowed = {'propext', 'Classical.choice', 'Quot.sound'}
receipt = {'argv': argv, 'limits': limits, 'guards': guards,
           'environment': {'LEAN_NUM_THREADS': '1', 'LEAN_STACK_SIZE_KB': '65536'},
           'exit': None, 'timed_out': False, 'error': None,
           'guards_before': False, 'guards_after': False,
           'predeclarations_match': False, 'axioms': None,
           'axiom_output_valid': False}

def sha(data):
    return hashlib.sha256(data).hexdigest()

def check_guards():
    for name, expected in guards.items():
        assert sha((root / name).read_bytes()) == expected, name

def capped_child():
    resource.setrlimit(resource.RLIMIT_AS, (limits['address_space_bytes'],) * 2)
    resource.setrlimit(resource.RLIMIT_CPU, tuple(limits['cpu_seconds']))
    resource.setrlimit(resource.RLIMIT_FSIZE, (limits['stream_bytes'],) * 2)
    resource.setrlimit(resource.RLIMIT_CORE, (0, 0))

before = resource.getrusage(resource.RUSAGE_CHILDREN)
start = time.monotonic()
proc = None
try:
    probe_expected = re.search(r'^Probe SHA-256: `([0-9a-f]{64})`$', text, re.M)
    launcher_expected = re.search(r'^Launcher SHA-256: `([0-9a-f]{64})`$', text, re.M)
    assert probe_expected and launcher_expected, 'missing predeclarations'
    assert sha(probe) == probe_expected.group(1), 'probe bytes'
    assert sha(launcher) == launcher_expected.group(1), 'launcher bytes'
    receipt['predeclarations_match'] = True
    check_guards()
    receipt['resolved_executables'] = {name: str(Path(shutil.which(name)).resolve())
                                       for name in ['lake', 'lean']}
    for name, path in receipt['resolved_executables'].items():
        assert path == '/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/' + name, name
    receipt['guards_before'] = True
    env = os.environ.copy()
    env.update(receipt['environment'])
    with (out / 'stdin.bin').open('rb') as stdin, \
            (out / 'stdout.bin').open('wb') as stdout, \
            (out / 'stderr.bin').open('wb') as stderr:
        proc = subprocess.Popen(argv, cwd=root, stdin=stdin, stdout=stdout,
                                stderr=stderr, env=env, start_new_session=True,
                                preexec_fn=capped_child)
        try:
            receipt['exit'] = proc.wait(timeout=limits['wall_seconds'])
        except subprocess.TimeoutExpired:
            receipt['timed_out'] = True
            os.killpg(proc.pid, signal.SIGKILL)
            receipt['exit'] = proc.wait()
    check_guards()
    receipt['guards_after'] = True
    output = (out / 'stdout.bin').read_text()
    pattern = r"'([^']+)' depends on axioms:\s*\[([^\]]*)\]\s*"
    matches = list(re.finditer(pattern, output))
    if (''.join(m.group(0) for m in matches) == output
            and [m.group(1) for m in matches] == symbols):
        axioms = {m.group(1): [x.strip() for x in m.group(2).split(',') if x.strip()]
                  for m in matches}
        receipt['axioms'] = axioms
        receipt['axiom_output_valid'] = all(
            len(a) == len(set(a)) and set(a) <= allowed for a in axioms.values())
except BaseException as exc:
    receipt['error'] = repr(exc)
    if proc is not None and proc.poll() is None:
        os.killpg(proc.pid, signal.SIGKILL)
        receipt['exit'] = proc.wait()
finally:
    after = resource.getrusage(resource.RUSAGE_CHILDREN)
    receipt['wall_seconds'] = time.monotonic() - start
    receipt['child_user_seconds'] = after.ru_utime - before.ru_utime
    receipt['child_system_seconds'] = after.ru_stime - before.ru_stime
    receipt['child_max_rss_kib'] = after.ru_maxrss
    for name in ['stdout.bin', 'stderr.bin']:
        if not (out / name).exists():
            (out / name).write_bytes(b'')
    receipt['files'] = {}
    for name in ['stdin.bin', 'stdout.bin', 'stderr.bin', 'launcher.sh', 'report-snapshot.md']:
        data = (out / name).read_bytes()
        receipt['files'][name] = {'bytes': len(data), 'sha256': sha(data)}
    receipt['stream_cap_hit'] = any(receipt['files'][name]['bytes'] >= limits['stream_bytes']
                                    for name in ['stdout.bin', 'stderr.bin'])
    receipt['passed'] = (receipt['exit'] == 0 and receipt['error'] is None
                         and receipt['guards_before'] and receipt['guards_after']
                         and receipt['predeclarations_match']
                         and receipt['axiom_output_valid']
                         and receipt['files']['stderr.bin']['bytes'] == 0
                         and not receipt['timed_out'] and not receipt['stream_cap_hit'])
    encoded = (json.dumps(receipt, sort_keys=True, indent=2) + '\n').encode()
    (out / 'receipt.json').write_bytes(encoded)
    print('EVIDENCE_DIR', out)
    print('RECEIPT_SHA256', sha(encoded))
    print(encoded.decode(), end='')
    print('STDOUT-BEGIN')
    print((out / 'stdout.bin').read_text(errors='replace'), end='')
    print('STDOUT-END')
    print('STDERR-BEGIN')
    print((out / 'stderr.bin').read_text(errors='replace'), end='')
    print('STDERR-END')
raise SystemExit(0 if receipt['passed'] else 1)
PY
```

## Actual evidence

The first and only authorized invocation passed. The Lean child and complete
Bash entry both exited 0. All seven universal theorem assignments, the exact
Prop family type, the ten-input constructor and all ten individual projection
types checked. All seven complete axiom reports contain only allowed axioms;
the centered-residue theorem needs only `propext` and `Quot.sound`. There were
no errors, warnings, stderr, timeout, stream-cap hit, retry or resource changes.
The recorded child wall time is 1.9238493280136026 seconds and maximum resident
set size is 3,288,484 KiB. All 25 guards passed both before and after the run.

The pre-run report snapshot is SHA-256
`a1f31d2b5f0f8a41ce004756d1ef43484bde582b314a5d243c9e8a94e8db0c4e`
(24,071 bytes). The probe and launcher exactly matched their predeclarations
and remain unchanged in this final report. The inner evidence directory is
`/tmp/astra-affine-bands-transport-review-0ae1q695`; its complete receipt has
SHA-256 `7ec2f532f4dcf5f6113150bcd91a65c18cda9a15baa44d6debbaf914da88937c`.
Lean stdout is 729 bytes, SHA-256
`0122d5aa156d6161f9597a57edb261832fbb103dd5d13ebf1d4a4674fe8705de`.
Lean stderr is empty, SHA-256
`e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

An outer file-capture controller extracted the exact Bash fence, checked its
predeclared SHA-256, saved it as `entry.sh`, and invoked `bash entry.sh` once
with stdin `/dev/null` and regular stdout/stderr files. It used the same
8 GiB/59–60 CPU/128 KiB file caps and disabled cores, with 65 seconds wall
allowing the inner controller to report after its fixed 60-second timeout.
That reporting grace does not change the Lean child's 60-second wall bound.
Its complete receipt is below (SHA-256
`7767de6be455452a7a62e087d4555bbfb2824741c23ad46ad9fab0b995531e2c`), in
`/tmp/astra-affine-bands-transport-entry-7mxb3h85`.

```json
{
  "argv": [
    "bash",
    "/tmp/astra-affine-bands-transport-entry-7mxb3h85/entry.sh"
  ],
  "error": null,
  "exit": 0,
  "files": {
    "entry.sh": {
      "bytes": 9683,
      "sha256": "378e530ed4cd98122ef4039ebbe2184b90cdb6ff4e7eff40963fc3a865e632a0"
    },
    "stderr.bin": {
      "bytes": 0,
      "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    },
    "stdout.bin": {
      "bytes": 6389,
      "sha256": "2196afaea92f835815bab9dc8adb1383b4ea9156d140fb17446cef0f46b18259"
    }
  },
  "stream_cap_hit": false,
  "timed_out": false,
  "wall_seconds": 1.9684288789867423
}
```

The following is the **complete raw Bash stdout**, including the full inner
receipt and the full Lean stdout/stderr between their markers. Its 6,389 bytes
have SHA-256 `2196afaea92f835815bab9dc8adb1383b4ea9156d140fb17446cef0f46b18259`.
The outer stderr is also empty (the empty-stream hash above).

```text
EVIDENCE_DIR /tmp/astra-affine-bands-transport-review-0ae1q695
RECEIPT_SHA256 7ec2f532f4dcf5f6113150bcd91a65c18cda9a15baa44d6debbaf914da88937c
{
  "argv": [
    "lake",
    "env",
    "lean",
    "-j1",
    "-s65536",
    "--stdin"
  ],
  "axiom_output_valid": true,
  "axioms": {
    "LonelyRunner.circleNorm_double_half_gt_of_small": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ],
    "LonelyRunner.exists_centered_sixth_residue_of_not_dvd_three": [
      "propext",
      "Quot.sound"
    ],
    "LonelyRunner.foldedPairSafeBands_of_bounds": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ],
    "LonelyRunner.fract_int_dilate_eq": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ],
    "LonelyRunner.fract_sixth_affine_time": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ],
    "LonelyRunner.pair_min_le_of_special_sixth_fiber_bound": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ],
    "LonelyRunner.small_folded_three_five_improve": [
      "propext",
      "Classical.choice",
      "Quot.sound"
    ]
  },
  "child_max_rss_kib": 3288484,
  "child_system_seconds": 0.601326,
  "child_user_seconds": 1.2944879999999999,
  "environment": {
    "LEAN_NUM_THREADS": "1",
    "LEAN_STACK_SIZE_KB": "65536"
  },
  "error": null,
  "exit": 0,
  "files": {
    "launcher.sh": {
      "bytes": 9683,
      "sha256": "378e530ed4cd98122ef4039ebbe2184b90cdb6ff4e7eff40963fc3a865e632a0"
    },
    "report-snapshot.md": {
      "bytes": 24071,
      "sha256": "a1f31d2b5f0f8a41ce004756d1ef43484bde582b314a5d243c9e8a94e8db0c4e"
    },
    "stderr.bin": {
      "bytes": 0,
      "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    },
    "stdin.bin": {
      "bytes": 4415,
      "sha256": "fe3aef017915ad2460f20160b3ee4f4730a77c2cd1f940cca1e6477ebe7c94ff"
    },
    "stdout.bin": {
      "bytes": 729,
      "sha256": "0122d5aa156d6161f9597a57edb261832fbb103dd5d13ebf1d4a4674fe8705de"
    }
  },
  "guards": {
    ".lake/build/lib/lean/LonelyRunner/AnchoredPairTransport.olean": "5254122c6d4ab3e583adf5676fe05aa7268dfa3412e2aee7889fbacc3832a07e",
    ".lake/build/lib/lean/LonelyRunner/FastRunnerInsertion.olean": "121edfbaed0d7b9fed32bacf891de838142988e48dcb4e7f2bed0c488ea49136",
    ".lake/build/lib/lean/LonelyRunner/FoldedCirclePhase.olean": "3032bbcf8e5c414daea831a7a415a40b4f254e5b72428b6fa078742e891afc06",
    ".lake/build/lib/lean/LonelyRunner/FoldedPairSafeBands.olean": "d000b970290ec9072f02465f527b817f32bb72113ed7fa09bd43c9f0a47287c8",
    ".lake/build/lib/lean/LonelyRunner/RationalShiftOrbits.olean": "8194c5c6ac0b8495146728fcac70a6a1e9d317f9e7689c4759f22ed33c14340f",
    ".lake/build/lib/lean/LonelyRunner/RealPhaseBands.olean": "7442f9f49d9f1e2d214460557f6a891ba13717ededff679876033793ac2c6504",
    ".lake/build/lib/lean/LonelyRunner/SixthAffinePhase.olean": "9a0cbfec2825c4b98fc7897835dc726929daabb3328a2d45818765c568cf47b3",
    ".lake/build/lib/lean/LonelyRunner/SpecialSixthPhase.olean": "2e4951ab757b0fa22574e72381abd7be6cca5c971f9e38967cf24f0991532537",
    ".lake/build/lib/lean/LonelyRunner/StructuredClasses.olean": "4ada0ca2f0a5f20a8c83c3c2e58256e931c3b283882a88a074aeedb02d7e048f",
    ".lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Tactic.olean": "0534ef12e7aaf8ffbb6e520a91f922da4469d0dca2b54c87b4458e1faa28a6a2",
    ".lake/packages/mathlib/Mathlib/Tactic.lean": "c6f2c548596b635a3d5c8aff8b19cbdeb60dd54e41bb89a1cd03b1a54d335fa5",
    "/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lake": "60330ab6f07dce20f3fa9ebb08e8b984ea9549eac172afeb15d9d2227060e2b3",
    "/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lean": "e8baaa71855a616dc351028f3ad2200051b0671f423a1696a100e809302d5550",
    "LonelyRunner/AnchoredPairTransport.lean": "63414c3ccb6c12c1ed8775cb7e18dccc84c30da42cd4be089ac336df75ceca43",
    "LonelyRunner/FastRunnerInsertion.lean": "dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5",
    "LonelyRunner/FoldedCirclePhase.lean": "957606878108847d5ceff47be621ff0fc9c0a0d976568b5f5ef3dbb6db10481e",
    "LonelyRunner/FoldedPairSafeBands.lean": "00903bcb0c131fdb31ab87d55cea809249dfacbbd5861f82ab3a987d39b74b5f",
    "LonelyRunner/RationalShiftOrbits.lean": "cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591",
    "LonelyRunner/RealPhaseBands.lean": "7f70467bad6bb5a8a859bff8947af1dc73e685910b69157b49bab259b3c02ca0",
    "LonelyRunner/SixthAffinePhase.lean": "76e420713079ec0c3979e9b169cd78ecb6a932d6dc790ea7d9711adbb64b7d4b",
    "LonelyRunner/SpecialSixthPhase.lean": "677372ee3dc86520051f4bcc037f685a3f5fd8748c737ef9e1d2bfc5ac0072d8",
    "LonelyRunner/StructuredClasses.lean": "5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c",
    "lake-manifest.json": "887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218",
    "lakefile.toml": "bdcbaaa18d518409619215e8acf7892452c1fa5c6e80ba742ce67f7380682a26",
    "lean-toolchain": "8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af"
  },
  "guards_after": true,
  "guards_before": true,
  "limits": {
    "address_space_bytes": 8589934592,
    "cpu_seconds": [
      59,
      60
    ],
    "stream_bytes": 131072,
    "wall_seconds": 60
  },
  "passed": true,
  "predeclarations_match": true,
  "resolved_executables": {
    "lake": "/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lake",
    "lean": "/home/joshua/.elan/toolchains/leanprover--lean4---v4.32.1/bin/lean"
  },
  "stream_cap_hit": false,
  "timed_out": false,
  "wall_seconds": 1.9238493280136026
}
STDOUT-BEGIN
'LonelyRunner.fract_sixth_affine_time' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.exists_centered_sixth_residue_of_not_dvd_three' depends on axioms: [propext, Quot.sound]
'LonelyRunner.foldedPairSafeBands_of_bounds' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.small_folded_three_five_improve' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.circleNorm_double_half_gt_of_small' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.fract_int_dilate_eq' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.pair_min_le_of_special_sixth_fiber_bound' depends on axioms: [propext, Classical.choice, Quot.sound]
STDOUT-END
STDERR-BEGIN
STDERR-END
```

The two retained temporary evidence directories contain 61,057 bytes in
regular files, well below 1 MiB. No raw record was replaced with a success
summary. The report contains the complete replay entry and actual receipt;
root's requested exact replay remains a separate action.

Project configuration, workflow, policy and focused state were read. The
actual command `python3 scripts/validate_workflow.py` exited 0 and printed
`workflow structural validation passed; it cannot certify mathematical validity.`
No source or import edits, build, state/Git mutation, numerical enumeration,
certificate generation or shared-cache change was performed by this reviewer.
These seven auxiliary contracts do not establish the preceding maximizer,
residue, or divisibility-cover assembly, an unconditional six-total result, or
the unrestricted Lonely Runner Conjecture.
