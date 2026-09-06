# Independent review of the third-shift manuscript

**Accept all seven proposed contracts unchanged, at manuscript level.** No
mathematical correction or unresolved gap was found inside their stated
hypotheses. Implementation and kernel verification remain separate work.

This review binds the complete frozen
`research/astra-three-divisible-shift-plan.md`, 19,801 bytes, SHA-256
`e4d53b08ebfeb49ec31a7a6245bdb870795f31dc8831f326cba8005cc9cf03bc`.
The assigned review checkpoint is `6f7ed02`; the author's earlier checkpoint
is recorded in the plan. I did not author that plan. Requested reviewer route
is Astra/xhigh; runtime-observed model and effort are unavailable in focused
state. Only this review file is owned. Current project instructions, policy
and focused state were read, and the structural validator passed. No Lean
compilation, numerical execution, mathematical search, certificate generation,
source edit, cache mutation, Git operation, or state write was performed.

## Primary-source scope

Direct retrieval of the supplied primary-paper PDF confirms that Section 2
fixes five positive integers with gcd one and defines safety by the closed
interval [1/6,5/6]. The result is labelled **Lemma 2.3**, on printed pages
94–95. Its proof invokes Lemma 2.1 to leave two nondivisible labels and uses
the three third-turn shifts. That integer formulation adds no distinctness
assumption. These points agree with the plan; the gcd-one context must not be
dropped when reading the statement. [Renault, *View-obstruction: a shorter
proof for 6 lonely runners*, DOI 10.1016/j.disc.2004.06.008](https://compmath.wordpress.com/wp-content/uploads/2008/08/view-obstruction_a_shorter_proof_for_6_lonely-runners.pdf#page=2).

This was retrieval of the cited original-paper content from its hosted copy,
not a new literature search or a claim of byte identity with an inaccessible
publisher copy. The proof checks below independently assess the supplied
manuscript contracts using the local mathematical interfaces.

## Exact accepted contracts

The fence joins, in order, the six proposed-theorem Lean blocks of the frozen
plan; the first block contains two theorems. Their text is preserved, with
one extra newline between blocks. The resulting 2,008-byte fence contents
have SHA-256
`353b02b7042a6e6e9490faa0d0a4b5f0bb564534e8942276c51f5048c17b7a4e`.
These are proposed declarations in namespace `LonelyRunner`, not executed
Lean source or new theorem artifacts.

```lean
theorem circleNorm_sub_le_add (u v : ℝ) :
    circleNorm (u - v) ≤ circleNorm u + circleNorm v

theorem circleNorm_bad_subsingleton_of_separated {α : Type*}
    (f : α → ℝ) (δ : ℝ)
    (hsep : ∀ i j, i ≠ j →
      2 * δ ≤ circleNorm (f i - f j)) :
    Set.Subsingleton {i : α | circleNorm (f i) < δ}

theorem circleNorm_third_shift_sub_ge (x : ℝ) (d : ℕ)
    (hnot : ¬ 3 ∣ d) (k l : Fin 3) (hkl : k ≠ l) :
    (1 : ℝ) / 3 ≤ circleNorm
      ((x + (k.val : ℝ) * (d : ℝ) / 3) -
        (x + (l.val : ℝ) * (d : ℝ) / 3))

theorem exists_third_shift_safe_nondivisible_family {ι : Type*} [Fintype ι]
    (x : ι → ℝ) (d : ι → ℕ)
    (hnot : ∀ i, ¬ 3 ∣ d i) (hcard : Fintype.card ι ≤ 2) :
    ∃ k : Fin 3, ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm
        (x i + (k.val : ℝ) * (d i : ℝ) / 3)

theorem exists_third_shift_of_seeded_divisible
    (v : Fin 5 → ℕ) (t₀ : ℝ)
    (hseed : ∀ i, 3 ∣ v i →
      (1 : ℝ) / 6 ≤ circleNorm (t₀ * (v i : ℝ)))
    (hexceptions :
      ((Finset.univ : Finset (Fin 5)).filter
        (fun i => ¬ 3 ∣ v i)).card ≤ 2) :
    ∃ k : Fin 3, ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm
        ((t₀ + (k.val : ℝ) / 3) * (v i : ℝ))

theorem fiveMovingNaturalRunners_of_three_or_four_divisible_three
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (hlower : 3 ≤
      ((Finset.univ : Finset (Fin 5)).filter
        (fun i => 3 ∣ v i)).card)
    (hupper :
      ((Finset.univ : Finset (Fin 5)).filter
        (fun i => 3 ∣ v i)).card ≤ 4) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))

theorem fiveMovingNaturalRunners_of_primitive_three_divisible_three
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (hprimitive : Finset.univ.gcd v = 1)
    (hthree : 3 ≤
      ((Finset.univ : Finset (Fin 5)).filter
        (fun i => 3 ∣ v i)).card) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))
```

## Independent derivation and boundary audit

**1. Quotient triangle inequality.** Apply `norm_sub_le` to the two classes
of u,v in `UnitCircle`. `AddCircle.coe_sub` identifies their group difference
with the class of u-v, and unfolding `circleNorm` gives the stated inequality.
This uses the quotient norm, so it handles real phases on opposite sides of
an integer and arbitrary positive or negative representatives.

**2. Strictly bad labels are subsingleton.** If distinct labels i,j both
satisfy `circleNorm(f i)<δ` and `circleNorm(f j)<δ`, contract 1 gives

    circleNorm(f i-f j) <= circleNorm(f i)+circleNorm(f j) < 2*δ,

contradicting the supplied separation. Thus any two members of the bad set
are equal. The proof needs neither finiteness nor an assumption about the
sign or size of δ. In particular it does not require `0<δ` or `δ<=1/2`.
For nonpositive δ the bad set is empty anyway. Badness must remain strict:
the symbolic phases -1/6 and 1/6 have separation 1/3 and each has norm exactly
1/6, so a non-strict badness test would incorrectly count both as bad. Equality
is safe in every subsequent theorem.

**3. Third-shift separation.** Take distinct k,l in Fin3. In the order
l.val<k.val, the natural difference h=k.val-l.val has 0<h<3; hence 3 does
not divide h. Together with `3 ∤ d`, primality of 3 implies `3 ∤ h*d`.
The remainder r=(h*d)%3 is positive and below 3, so both r and 3-r are at
least one. Thus the cyclic residue distance of h*d modulo 3 is at least one,
and `circleNorm_nat_div_ge` yields the lower bound 1/3 for its quotient phase.
The ordered subtraction has the exact real cast
`(h:Real)=(k.val:Real)-(l.val:Real)`, which proves the required cancellation
of x. For the other order, swap k,l and apply `circleNorm_neg` to the negative
of that phase difference. No truncated subtraction is used before its order
has been established. No speed positivity hypothesis is missing: `3 ∤ d`
already excludes d=0. The argument is uniform in d and arbitrary real x;
it does not enumerate index pairs or treat nonzero composite residues as units.

**4. One shift for at most two exceptions.** For each exceptional label i,
filter the three candidate indices by the strict badness test at its own
base phase x(i) and speed d(i). Contracts 2 and 3 give a bad-set cardinality
at most one. Summing over the supplied Fintype gives total cardinality at
most `Fintype.card ι`, hence at most two and strictly below the three
candidates. The existing finite avoidance theorem supplies one index outside
every bad set. Negating `<1/6` gives `1/6<=circleNorm` for every i, all at
that same index k. Repeated speeds or base phases, the empty exceptional
family, and a singleton family are all admitted. No `DecidableEq ι` premise
is needed; local `classical` provides the decidability needed by filters.

**5. Supplied-seed adapter.** Let E be the filtered exceptional labels.
Its finite subtype has cardinality `E.card`, so contract 4 applies with
base phase `t₀*v i` and speed `v i`. At each exceptional label,

    (t₀+k/3)*v i = t₀*v i+k*v i/3.

At each divisible label, `circleNorm_time_add_nat_div_of_dvd` with ell=3
preserves the seed norm exactly. The resulting single k works for all five
labels. No positivity of v or t₀ is required by this conditional contract.
The all-five-divisible case is harmless here because its `hseed` premise
already supplies a witness for every label; the adapter does not manufacture
that seed from four labels.

**6. Positive seed when exactly three or four labels are divisible.** Write
S for the divisible labels. From `S.card<=4<5`, choose p outside S. The
four-label family `v(p.succAbove j)` retains all other labels and inherits
positivity. The checked `fourMovingNaturalRunners` supplies one positive
t₀ at margin 1/5, without an injectivity premise. Every label in S differs
from p and is represented by `Fin.exists_succAbove_eq`; hence all of S is
simultaneously seeded at margin 1/6. The complementary filter identity gives
`S.card+E.card=5`, so `S.card>=3` leaves at most two exceptions.

Apply contract 5 and put t=t₀+k.val/3. Because k.val is natural, t>=t₀>0.
When S has three labels, the four-label seed contains one additional
exceptional label. Its safety may be lost under a shift, but contract 4
handles it along with the other exception. This is not an unproved
preservation assumption. Counts and reindexing refer to labels; repeated
values remain valid throughout. No padding, sorting or deduplication is
needed, and no separate three-versus-four case split is required.

**7. Primitive at-least-three corollary.** If all five speeds were divisible
by 3, `Finset.dvd_gcd` would give `3 ∣ Finset.univ.gcd v=1`, a contradiction.
Thus the divisible set is a proper subset of five labels and has cardinality
at most four. Contract 6 now applies to the supplied lower bound. This uses
neither a no-witness assumption nor a divisor-count theorem whose proof is
still pending. It does not import a five-moving sixth-margin theorem.

The global gcd-one assumption is essential to this particular unrestricted
"at least three" reduction: it supplies the missing exclusion of all five
divisible labels. The logically needed exclusion is represented directly by
`hupper` in contract 6 and is derived from `hprimitive` in contract 7. Neither
hypothesis should be silently removed. This is a dependency statement, not
a claim that nonprimitive tuples are counterexamples.

Indeed, let w be any positive Fin5 natural family and set v(i)=3*w(i).
An unqualified theorem covering every positive tuple with at least three
divisible labels would apply to v, where all five are divisible. A positive
witness t for v gives the positive witness s=3*t for w, since
`t*(3*w i)=(3*t)*w i`. Conversely the full five-moving sixth theorem covers
such v immediately. Thus the all-five-inclusive statement is equivalent to
the unconditional positive five-moving sixth theorem, and this branch has
not proved it. Dividing out a gcd does not fix this branch: the reduced tuple
need not retain three multiples of 3.

## Verified APIs and implementation recommendations

The suggested interfaces are present with the required scopes. In particular,
`Fintype.card_coe` is at `Data/Fintype/Card.lean:371`; this is a more precise
location than the plan's aggregate source list. `norm_sub_le` is the additive
declaration generated by `norm_div_le` at
`Analysis/Normed/Group/Basic.lean:152` and explicitly attributed at line 155;
`AddCircle.coe_sub` is at `Topology/Instances/AddCircle/Defs.lean:211`.
These are API-location clarifications, not contract corrections.

| Checked source location | Application |
| --- | --- |
| `ModularCertificates.lean:33` | Exact sum-of-bad-cardinalities avoidance interface; no witness search. |
| `RationalShiftOrbits.lean:44` | Integer-periodic preservation for arbitrary real t, natural k, and positive ell. |
| `PivotResidues.lean:91,102` | Reuse the nonzero-remainder distance bound and natural quotient norm bridge. |
| `SmallDenominatorWitness.lean:16,24` | Existing nondivisibility-to-distance and direct norm bound, usable at N=q=3. |
| `StructuredClasses.lean:14` | Reverse the phase difference without natural subtraction errors. |
| `FiveRunnerOrdinary.lean:79,120` | Complement reindexing and positive Fin4 fifth-margin supply with repeated speeds. |
| `PrimitivePrompt95.lean:37` | Existing finite-gcd divisor pattern only; no held redundancy claim is needed. |
| `Data/Nat/Prime/Basic.lean:142` | `Nat.Prime.not_dvd_mul` has exactly the two nondivisibility premises required. |
| `Data/Finset/Card.lean:610,643,698,712` | Outside-label selection, complementary counts, and cardinality-at-most-one from subsingleton. |

Implement in the stated dependency order: quotient triangle, bad-set
subsingleton, third-shift spacing, common exceptional shift, seeded adapter,
positive three-or-four result, primitive corollary. The first triangle proof
can directly unfold `circleNorm` and rewrite `AddCircle.coe_sub` before
applying the quotient norm inequality. For spacing, use ordered Fin values
and prime-three nondivisibility of the product. Root identified a shorter
existing endpoint for the proof, and I checked its source: apply
`smallDenominator_circleNorm_ge` with N=q=3 and numerator h*d, then rewrite
real inverse notation to 1/3. It already proves the necessary quotient bound,
so no fresh remainder or cyclic-distance proof is needed in new source.
The alternative `one_le_cyclicResidueDistance_of_not_dvd` helper is also
available. These choices preserve contract 3 unchanged. Use the filtered
exceptional subtype with
`Fintype.card_coe` and the supplied avoidance theorem; separate existential
shifts for the two exceptions would not suffice.

Keep all new statements exactly as copied. Later implementation checks should
assign their full universal types and inspect axiom dependencies, with special
attention to strict badness, the common k, repeated labels, positive final
time, and the all-five exclusion. No finite test would replace those proof
obligations. No executable replay or numerical evidence is needed for this
manuscript review.

## Static provenance

All eleven source hashes in the frozen plan were checked and matched. The
three additional library API files and `SmallDenominatorWitness.lean` were
read and hashed as well. The complete
source bindings are:

```text
cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591  LonelyRunner/RationalShiftOrbits.lean
8b7e9dc5be1236acb812607c19454fe43ecd1333145aef675e7df8e6d0c3871c  LonelyRunner/ModularCertificates.lean
dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5  LonelyRunner/FastRunnerInsertion.lean
5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c  LonelyRunner/StructuredClasses.lean
362da5ab923f22e900ae7ac821dd4cf4aab91dfe70889987bc9e5a05d19c276a  LonelyRunner/PivotResidues.lean
662d0116f13971bce85e76c503e2f3be4fdc6291ba8113aeda43957e38354ffe  LonelyRunner/FiveRunnerOrdinary.lean
212fa6d879bab6d70f09a4a43b2027b96724b5e5ac4a22cdf4b368509973166f  LonelyRunner/DivisorInsertion.lean
d1d6cf01650c809da0cb19ed722754071df070831e02e22a3c4b2c3dc28afb04  LonelyRunner/PrimitivePrompt95.lean
87c674ba5464c7868fb3e253e58a695821bf8841bb4e076bac5d570236dc6229  .lake/packages/mathlib/Mathlib/Data/Finset/Card.lean
5a70d92ff1637a57053c8ccddd92752adb7f0938e9fd585b3cd77badee2e248b  .lake/packages/mathlib/Mathlib/Data/Fintype/EquivFin.lean
b97e83d65681b68b3ad1f4bdfd36defd0a30aa173cf726b3d2807acf8bde5027  .lake/packages/mathlib/Mathlib/Data/Nat/Prime/Basic.lean
12f2f3e9a3dc8b44ef43a1882b5710a0d3155f93ea22fb5669d89963c9416096  .lake/packages/mathlib/Mathlib/Analysis/Normed/Group/Basic.lean
2307820b0dee2080bd8245e268974bd02678d76067a6efc8878d004f7b8ed774  .lake/packages/mathlib/Mathlib/Data/Fintype/Card.lean
c9f5ceb8063d9d9c0f3803378d51e71f9f8bd2fe5eab3d57c72eb16889a74871  .lake/packages/mathlib/Mathlib/Topology/Instances/AddCircle/Defs.lean
1570a359100594f4a5589588e3b32674dc2d54d60e500df1d47aca64c2faf95f  LonelyRunner/SmallDenominatorWitness.lean
```

The exact proposed-contract fence was checked against the frozen plan by
static byte comparison. `python3 scripts/validate_workflow.py` exited 0 and
printed `workflow structural validation passed; it cannot certify mathematical
validity.` These checks establish file/record integrity, not a kernel proof.
The only external operation was direct reading of the cited primary PDF;
scoped local API lookups were read-only. No mathematical search or numerical
experiment was run.

The unrestricted project goal remains active. These accepted manuscripts
settle the stated third-shift branch only. The two-divisible and other speed
branches, unconditional five-moving sixth supply, H7/H8 and canonical
assembly remain separate; no new runner count is claimed.
