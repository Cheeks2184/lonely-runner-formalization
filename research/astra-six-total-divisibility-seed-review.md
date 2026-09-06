# Independent review of the six-total divisibility seed

Disposition: **accept all eight proposed contracts unchanged, at manuscript
level**. The argument supplies the stated restricted five-moving witness and
the necessary divisor-count bounds for a hypothetical primitive counterexample.
No mathematical correction or unresolved manuscript gap was found. Lean
implementation and kernel verification remain separate work.

This review binds the entire frozen
`research/astra-six-total-divisibility-seed-plan.md`, 22,178 bytes, SHA-256
`752cc8e216bde3cc8b533e84da02967972781a2bd7cbc95e6b62503f26d5e792`.
The review's assigned source checkpoint is
`a39edc784be728b127aac6387277205136407c01`; the plan records its earlier authoring
checkpoint. All twelve source-file hashes listed in the plan match the files
inspected here. No fresh Git check or build is represented by those statements.

The assigned reviewer route is Astra/xhigh, with runtime-observed model and
effort unavailable in workflow state. I did not author the reviewed divisibility
plan or its future Lean implementation. I read the full plan, current project
instructions and focused state, and the relevant source interfaces. My only
owned output is this report. No source, other report, state, Git, cache, or
build changes were made; no Lean probe, numerical control, search, enumeration,
or solver was run.

## Exact accepted interfaces

The following is the plan's complete Lean fence, reproduced byte-for-byte.
Its contents have SHA-256
`de43f48cfe49a5394ee6b6319d6d9a74ba0666446ff2cc5eaa30154478070936`.
These are proposed declarations in namespace `LonelyRunner`, without proof
terms; this review does not claim that the fence elaborates as a Lean module.

```lean
-- Bounded representative adapter to an already checked integer-grid theorem.
theorem exists_nat_coprime_grid_circleNorm_ge
    (x : ℝ) (c n : ℕ) (hn : 0 < n) (hc : Nat.Coprime c n) :
    ∃ k : ℕ, k < n ∧
      ((n : ℝ) - 1) / (2 * (n : ℝ)) ≤
        circleNorm (x + (k : ℝ) * (c : ℝ) / (n : ℝ))

-- Strong reduced orbit statement: k is bounded by the actual orbit size.
theorem exists_nat_rational_shift_circleNorm_ge_mesh
    (ell d : ℕ) (hell : 2 ≤ ell) (hnot : ¬ ell ∣ d) (x : ℝ) :
    let n : ℕ := ell / Nat.gcd ell d
    ∃ k : ℕ, k < n ∧ k < ell ∧
      ((n : ℝ) - 1) / (2 * (n : ℝ)) ≤
        circleNorm (x + (k : ℝ) * (d : ℝ) / (ell : ℝ))

theorem exists_nat_rational_shift_circleNorm_ge_quarter
    (ell d : ℕ) (hell : 2 ≤ ell) (hnot : ¬ ell ∣ d) (x : ℝ) :
    ∃ k : ℕ, k < ell ∧ (1 : ℝ) / 4 ≤
      circleNorm (x + (k : ℝ) * (d : ℝ) / (ell : ℝ))

-- Preserves each divisible speed's exact norm for an arbitrary real time.
theorem circleNorm_time_add_nat_div_of_dvd
    (ell a k : ℕ) (hell : 0 < ell) (hdiv : ell ∣ a) (t : ℝ) :
    circleNorm ((t + (k : ℝ) / (ell : ℝ)) * (a : ℝ)) =
      circleNorm (t * (a : ℝ))

-- This preservation theorem needs no finite index type or supplied margin.
theorem exists_nat_shift_preserving_divisible_family {ι : Type*}
    (v : ι → ℕ) (ell d : ℕ) (hell : 2 ≤ ell) (hnot : ¬ ell ∣ d)
    (hdiv : ∀ i, ell ∣ v i) (t : ℝ) :
    ∃ k : ℕ, k < ell ∧
      (1 : ℝ) / 4 ≤ circleNorm ((t + (k : ℝ) / (ell : ℝ)) * (d : ℝ)) ∧
      ∀ i, circleNorm ((t + (k : ℝ) / (ell : ℝ)) * (v i : ℝ)) =
        circleNorm (t * (v i : ℝ))

-- Conditional five-moving witness; repeated input speeds are permitted.
theorem fiveMovingNaturalRunners_of_four_divisible
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (ell : ℕ) (hell : 2 ≤ ell) (p : Fin 5)
    (hnot : ¬ ell ∣ v p) (hdiv : ∀ i, i ≠ p → ell ∣ v i) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))

-- Upper count is valid for every denominator at least two.
theorem primitive_no_sixth_witness_divisor_count_le_three
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (hprimitive : Finset.univ.gcd v = 1)
    (hno : ¬ ∃ t : ℝ, ∀ i, (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)))
    (ell : ℕ) (hell : 2 ≤ ell) :
    ((Finset.univ : Finset (Fin 5)).filter (fun i => ell ∣ v i)).card ≤ 3

-- Exact Renault 2.1 count, phrased without a five-case denominator split.
theorem six_total_divisor_count_bounds
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (hprimitive : Finset.univ.gcd v = 1)
    (hno : ¬ ∃ t : ℝ, ∀ i, (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ)))
    (ell : ℕ) (hell : 2 ≤ ell) (hell6 : ell ≤ 6) :
    1 ≤ ((Finset.univ : Finset (Fin 5)).filter (fun i => ell ∣ v i)).card ∧
    ((Finset.univ : Finset (Fin 5)).filter (fun i => ell ∣ v i)).card ≤ 3
```

## Independent proof and scope checks

Write N(x) for `circleNorm x`, the distance of x modulo one to the origin.
All norm bounds below are closed. The proofs apply to arbitrary real phase;
no assumption that a phase lies in [0,1), or that time is nonnegative, is used
before the explicit positive-time insertion step.

**1. Bounded coprime-grid representative.** Use the existing
`exists_int_coprime_grid_circleNorm_ge x c n hn hc` to obtain K in the integers
with the required mesh bound. Set k to the nonnegative Euclidean remainder
of K modulo n, and z to its Euclidean quotient. Since n>0, k is natural,
k<n, and K=k+n*z. Thus, in the reals,

    x + K*c/n = (z*c) + (x + k*c/n).

The first summand is an integer. `circleNorm_add_int` transfers the exact
bound to k. This treats negative K without replacing it by its absolute value
or `K.toNat`. The source pattern `Int.natMod` together with
`Int.toNat_of_nonneg`, `Int.emod_nonneg`, `Int.natMod_lt`, and
`Int.emod_add_mul_ediv` gives precisely the needed identity and range.
No primality is involved. The admitted edge case n=1 is valid: k=0 and the
required bound is zero. In particular c=0, n=1 is allowed by the first
contract; it is not an omitted exceptional case. The already checked grid
estimate is used as an input and is not reproved or experimentally retested.

**2. Composite-modulus reduction.** Let g=gcd(ell,d), n=ell/g, and c=d/g.
Since ell>=2, g>0. Exact divisibility gives ell=g*n and d=g*c;
therefore n>0, n<=ell, and gcd(c,n)=1. For the last equality the existing
`Nat.coprime_div_gcd_div_gcd` pattern applied to ell,d yields the reversed
order n,c, followed by symmetry. If n=1, then ell=g divides d, contradicting
`hnot`. Hence n>=2. No primality or coprimality of d with ell has been added.
The case d=0 is already excluded by `hnot`, since every ell divides zero.

Cancellation of the positive factor g proves the exact real identity
d/ell=c/n. Apply contract 1 with the same arbitrary x to obtain k<n; the
additional k<ell follows from n<=ell. The resulting expression is exactly
x+k*d/ell. The time-shift denominator remains ell, even though the orbit size
is n. This proves contract 2 with both requested bounds on k.

**3. Closed quarter corollary and sharpness.** For n>=2, multiplying by the
positive denominator 4*(2*n) shows

    1/4 <= (n-1)/(2*n)  iff  n>=2.

Thus contract 2 implies contract 3. There is no strict inequality available
uniformly: if n=2 and x=1/4, coprimality forces c odd, and the two possible
phases modulo one are 1/4 and 3/4. Both have norm exactly 1/4. This is a
symbolic endpoint argument, not an executed finite control. More generally
the plan's claimed sharp mesh is sound: for
x=1/2-1/(2*n), the antipode lies midway between two consecutive n-grid points.
Every such point is at circular distance at least 1/(2*n) from the antipode,
with equality at an adjacent point; hence the largest norm is exactly
(n-1)/(2*n). Coprime multiplication only permutes these phases.

**4. Exact preservation of a divisible speed.** If a=ell*r, then ell>0 gives

    (t+k/ell)*a = t*a + k*r.

The added quantity is an integer, so integer periodicity proves contract 4.
It allows t negative, k=0, and a=0. None of these cases requires repair, and
there is no supplied norm bound to preserve separately.

**5. A shift preserving the entire divisible family.** Apply contract 3 at
x=t*d. Choose its single k first. Distributivity identifies its exceptional
phase with `(t+k/ell)*d`. Contract 4 then proves the equality for each i.
The same chosen k works for every divisible speed; no choice over the family
is needed. Consequently `ι : Type*` may be empty, finite, or infinite,
with no `Fintype`, positivity, injectivity, or common-margin hypothesis.

**6. Positive conditional Fin5 insertion.** For p:Fin5 define the four-label
family old(j)=v(p.succAbove j), j:Fin4. The positive-speed assumption restricts
to old. The source theorem `fourMovingNaturalRunners` provides t0>0 and
N(t0*old(j))>=1/5 for every j; its actual signature permits repeated speeds.
Use contract 5 with this family and d=v(p). The nondivisibility assumption
is the exceptional hypothesis, and `Fin.succAbove_ne p j` supplies each
divisibility hypothesis. It gives a natural k<ell and t=t0+k/ell.

Here k>=0 and ell>0 show t>=t0>0, including k=0. The exceptional norm is
at least 1/4. Every other label i is `p.succAbove j` for some j, by
`Fin.exists_succAbove_eq` applied to i!=p, so its norm remains at least 1/5.
Both lower bounds imply the requested 1/6. No order of speed values,
injectivity, consolidation, or extra label is used. Repeated old values are
retained as separate labels. The exceptional value necessarily differs from
each divisible value, as a consequence of the stated assumptions alone.

**7. Primitive upper count.** Put S={i:Fin5 | ell divides v(i)}. If S were
all five labels, `Finset.dvd_gcd_iff` would give ell dividing the finite gcd,
hence ell dividing 1. This contradicts ell>=2. Therefore choose p outside S.
Suppose |S|>=4. Since S is a subset of `univ.erase p`, which has cardinality
4, equality holds. A subset of a finite set with the same cardinality is that
set, so every i!=p belongs to S. Contract 6 then supplies a positive witness
and therefore a real witness, contradicting the exact `hno` hypothesis.
It follows that |S|<=3. This argument holds for every ell>=2; no upper bound
on ell was used.

Primitivity is needed in this argument to exclude the all-five-divisible
case before the four-divisible insertion applies. A nonprimitive family with
five divisible labels is merely a scaled instance of the still-unproved
unconditional five-moving problem at this stage. This is a dependency
statement, not a claim that a counterexample to six runners exists without
primitivity. Positivity remains a real requirement of the stated reduction:
the four-label witness input needs positive moving speeds. Counts throughout
are counts of labels, not counts of distinct values.

**8. Lower count and combined bounds.** Convert `hno` from 1/6 notation to
the equivalent inverse notation and apply the already checked
`divisor_cover_of_no_small_witness` with n=5 and N=6. For 2<=ell<=6 it yields
an i with ell dividing v(i); the filtered set is nonempty, so its cardinality
is at least one. Contract 7 provides its cardinality at most three. The lower
bound uses neither positivity nor primitivity nor distinctness; those
hypotheses remain in contract 8 because its upper bound uses them. The
restriction ell<=6 belongs to the lower bound: the existing time 1/ell
argument gives a norm bound 1/ell>=1/6 in precisely this range. The checked
divisor-cover theorem handles composite ell directly, without requiring a
nonzero residue to be invertible.

## Normalization and implementation dependencies

The plan's optional primitive normalization is also sound. For a nonempty
positive finite natural family let G be its finite gcd and w(i)=v(i)/G.
The mapped arithmetic helpers prove G>0, w(i)>0, gcd(w)=1, and v(i)=G*w(i),
while retaining every label. A witness for v at t gives a witness for w at
G*t; a witness for w at s gives one for v at s/G. These identities hold for
arbitrary real times and preserve positive times because G>0. Consequently
absence of a real witness transfers in both directions. No assertion from
the held Prompt95 redundancy route is required: only its independently stated
positive-gcd and factorization helpers are relevant. Sorted primitive
normalization of an injective integer tuple with a zero coordinate has a
different input contract and should not replace this labelled normalization.

The count conclusion is the necessary obstruction identified as Lemma 2.1
in Renault's *View-obstruction: a shorter proof for 6 lonely runners*,
Discrete Mathematics 287 (2004), 93–101, DOI 10.1016/j.disc.2004.06.008.
The frozen plan links the [hosted paper](https://compmath.wordpress.com/wp-content/uploads/2008/08/view-obstruction_a_shorter_proof_for_6_lonely-runners.pdf#page=2).
This review independently checks the plan's derivation against the local
interfaces; it makes no new paper-fetch or publisher-byte-identity claim.

The minimal dependency sequence is exactly contracts 1→2→3, independently
4, then 3+4→5, 5+the existing four-moving theorem→6, 6+finite-gcd/cardinality
arithmetic→7, and 7+the existing divisor cover→8. The optional normalization
does not need to be a new public theorem to implement these eight contracts.

The following source scopes were read directly and matched the plan:

| Source location | Scope actually available |
| --- | --- |
| `DivisorInsertion.lean:18,67` | Arbitrary real phase, positive grid size, integer shift; coprime version uses natural c and n. |
| `FastRunnerInsertion.lean:25` | Exact invariance under every integer additive phase. |
| `ReverseGrid.lean:61,131,145` | Correct natural Euclidean remainder, range, quotient identity; the local cast helper is private, so its proof pattern must be reused rather than importing that name. |
| `FiveRunnerMixed.lean:279` | Positive gcd, exact natural divisions, reduced coprimality with symmetry as needed. |
| `FiveRunnerOrdinary.lean:79,120` | Complement-label reindexing and positive Fin4 fifth-margin theorem with repeats. |
| `SmallDenominatorWitness.lean:67` | Lower divisor cover for arbitrary natural labelled speeds and any positive N. |
| `PrimitivePrompt95.lean:48,56,65,71,81` | Positive gcd, positive primitive part, factorization, and gcd-one arithmetic. |
| `PrimitiveAffineRank.lean:6` | `Finset.dvd_gcd_iff` usage. |

The alternate `codimensionOneDivisorInsertion` interface at line 103 is sound
but needs divided old speeds and returns an unrestricted real time. The
proposed natural-representative route proves positivity directly. The
`IntegerInduction` coprime-common-divisor constructor assumes coprimality of
the unreduced exceptional speed, which is stronger than nondivisibility for
composite ell. It should not be substituted for the reduced-orbit argument.

Remaining work is ordinary formalization: expose the representative adapter,
prove the exact gcd/cast identities with positive denominators, reindex the
complement, and assemble the finite-set count. Conversion between real inverse
and division notation does not change any threshold. No stronger premise or
weaker conclusion is authorized to avoid an implementation difficulty.

## Executed evidence and static replay

The only executable checks in this review are workflow validation and static
file/contract integrity checks. The workflow validator exited 0 and printed:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

The following read-only Python command is the complete integrity check run
from the repository root. It checks frozen input bytes, all twelve mapped
source bytes, and exact reproduction of the eight-contract fence. It performs
no mathematical test or search and writes no file.

```bash
python3 - <<'PY'
from pathlib import Path
import hashlib
import re

plan = Path('research/astra-six-total-divisibility-seed-plan.md').read_bytes()
assert len(plan) == 22178
assert hashlib.sha256(plan).hexdigest() == '752cc8e216bde3cc8b533e84da02967972781a2bd7cbc95e6b62503f26d5e792'
text = plan.decode()
bindings = re.findall(r'^([0-9a-f]{64})  (LonelyRunner/[^\n]+)$', text, re.M)
assert len(bindings) == 12
for expected, name in bindings:
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
blocks = re.findall(r'```lean\n(.*?)```', text, re.S)
assert len(blocks) == 1
assert hashlib.sha256(blocks[0].encode()).hexdigest() == 'de43f48cfe49a5394ee6b6319d6d9a74ba0666446ff2cc5eaa30154478070936'
review = Path('research/astra-six-total-divisibility-seed-review.md').read_text()
copied = re.findall(r'```lean\n(.*?)```', review, re.S)
assert copied == blocks
assert len(re.findall(r'^theorem ', blocks[0], re.M)) == 8
print('PASS frozen plan; 12 source bindings; exact 8-contract fence')
PY
```

Actual result: exit 0, empty stderr, stdout exactly:

```text
PASS frozen plan; 12 source bindings; exact 8-contract fence
```

No new kernel theorem, numeric receipt, or full source verification is claimed.
This acceptance does not prove unconditional five-moving loneliness at 1/6,
establish canonical six-total loneliness, supply the missing H7/H8 induction
cases, or resolve the unrestricted Lonely Runner Conjecture. The global goal
remains active; subsequent source implementation and independent verification
must retain these exact scopes.
