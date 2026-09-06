# Six-total divisibility preparation: orbit and divisor-count contracts

2026-09-06. Requested Astra/xhigh manuscript task
`/root/six_total_divisibility_seed_plan`, executed by reused agent
`/root/seven_adic_expanded_falsifier`. Runtime model/effort are not independently
attested. Source checkpoint in the active task record:
`a211fc2d332a9f6ab953fb46aa4362d9b208a14c`.
Configuration, workflow, policy and focused state were read; the actual
workflow validator passed. Only this report is owned. No Lean or other source,
state, Git, dependency or cache changes are made.

**Manuscript result: the requested orbit theorem and Renault preliminary
divisor-count conclusion follow without a gap.** The core sharp orbit estimate
already exists in checked source. The new implementation work is a bounded
natural representative adapter, gcd reduction, preservation/reindexing and
finite-label count corollaries. The proposed declarations below have not been
compiled or implemented in this task. No numerical experiment, enumeration,
search, solver or Lean execution was performed.

## Primary scope

Renault's *View-obstruction: a shorter proof for 6 lonely runners*, Discrete
Mathematics 287 (2004), 93–101, DOI `10.1016/j.disc.2004.06.008`, states the
five-positive-integer margin-1/6 target and begins Section 2 by normalizing the
joint gcd to one. Lemma 2.1 then says that a hypothetical counterexample has
between one and three multiples of each denominator 2 through 6. Its proof
uses time 1/ell for the lower count and rational shifts of a four-speed
witness for the upper count. I checked the paper's Sections 1–2 in the
[hosted primary-paper copy, printed pp. 93–94](https://compmath.wordpress.com/wp-content/uploads/2008/08/view-obstruction_a_shorter_proof_for_6_lonely-runners.pdf#page=2).
This is a hosted copy identifying the DOI, without an asserted byte identity
to a publisher-hosted PDF. The detailed composite-modulus orbit justification
below is our derivation. Propositions 3.1/4.1 and the later assembly are outside
this task.

Throughout, `N(x)` denotes the project's real `circleNorm x`, distance to the
nearest integer. All distance inequalities are closed. Label families are
allowed to repeat values. Counting divisible speeds means counting their
labels, not counting distinct numerical values.

## Sharp orbit bound, including composite moduli

Let ell>=2, d a natural number with ell not dividing d, and x any real number.
Set

    g = gcd(ell,d), n = ell/g, c = d/g.

Since ell>0, g>0. Divisibility gives ell=g*n and d=g*c, with n>0 and
gcd(c,n)=1. If n=1, ell=g divides d, a contradiction. Consequently

    2 <= n <= ell,    d/ell = c/n.

All divisions in these two factorizations are exact. In particular d>0 is
already forced by nondivisibility, but the orbit theorem need not assume it
separately. The only invertible residue used below is c modulo n; d modulo
ell need not be invertible. This distinction is essential for ell=4 or 6
and any other composite modulus.

First consider the translated 1/n grid. Put y=n*(1/2-x), and choose the
integer

    q = floor(y+1/2).

The floor inequalities give -1/2 < q-y <= 1/2, so in particular
`|q-y|<=1/2`. Thus

    |x+q/n-1/2| <= 1/(2*n).

The circle norm is 1-Lipschitz, and N(1/2)=1/2. Therefore

    N(x+q/n) >= 1/2-1/(2*n) = (n-1)/(2*n).              (1)

This argument takes x directly as an arbitrary real number; it does not
normalize x by a nonnegative integer division. It therefore also handles
negative x and nearest-integer ties. The use of <= at a tie is intentional.

Choose integers u,v with c*u+n*v=1. For K=q*u we have

    K*c/n = q/n-q*v.

The last summand is an integer, so integer periodicity and (1) give

    N(x+K*c/n) >= (n-1)/(2*n).                          (2)

Now choose the Euclidean natural residue k of K modulo positive n:

    k = K.natMod n,  0 <= k < n,  K = k+n*z

for an integer z. Then `K*c/n = k*c/n+z*c`, and periodicity transfers (2)
to k. Using d/ell=c/n, this yields the strengthened bounded conclusion

    exists k : Nat, k<n<=ell and
      N(x+k*d/ell) >= (n-1)/(2*n) >= 1/4.              (3)

The last inequality follows by multiplying by positive 4*n: it is
equivalent to n>=2. The strict bound k<n implies k<ell even when n=ell.
Zero is an allowed shift. The denominator in the time shift remains ell;
reducing the shift index modulo n does not change it to k/n.

For completeness, this is the exact reduced orbit, not just a subset:
every point k*c/n is a 1/n grid point modulo one, and Bézout represents
each residue r/n in this form. If k1*c=k2*c modulo n, coprimality implies
k1=k2 modulo n, so the n indices in [0,n) give a permutation of that grid.
The ell indices in [0,ell) repeat this orbit g times. This proves the orbit
size without a prime-modulus assumption or enumeration.

The bound is the sharp uniform one for a translated n-point grid. Taking
`x=1/2-1/(2*n)` places the antipode halfway between neighboring grid points;
their nearest antipodal distance is 1/(2*n), giving maximal circle norm
exactly (n-1)/(2*n). In particular an n=2 orbit can have both norms exactly
1/4, so (3) cannot generally be made strict. This is a symbolic endpoint
control, not an executed finite test.

### Existing checked implementation of the core argument

`DivisorInsertion.lean:18` already proves
`exists_int_grid_circleNorm_ge`, exactly (1) with an integer q, using
`floor(y+1/2)`, `Int.floor_le`, `Int.lt_floor_add_one` and the circle-norm
Lipschitz estimate. `DivisorInsertion.lean:67` already proves
`exists_int_coprime_grid_circleNorm_ge`, exactly (2), by
`Nat.gcdA`, `Nat.gcdB`, `Nat.gcd_eq_gcd_ab` and integer periodicity.
Neither declaration presumes a prime modulus. Their source proofs were
read in full. They are already root-imported and listed in the axiom audit;
this task does not claim a fresh kernel execution.

The new bounded adapter should therefore call the existing coprime theorem
and reduce its integer witness modulo n. `ReverseGrid.lean` already uses
`Int.natMod_lt`, the cast of a nonnegative Euclidean remainder, and
`Int.emod_add_mul_ediv` for exactly this conversion pattern. Its private
proofs are examples to adapt, not public lemmas callable from another module.
For gcd reduction, `FiveRunnerMixed.lean:279`–`:305` already demonstrates
positive gcd, exact factors via `Nat.mul_div_cancel'`, and
`Nat.coprime_div_gcd_div_gcd`. Apply the last identity with ell,d and take
symmetry to obtain coprimality of c,n in the desired order.

## Preserving divisible speeds and inserting the fifth label

Suppose ell divides a natural speed a, say a=ell*r. For any real t and
natural k,

    (t+k/ell)*a = t*a+k*r.

The second term is an integer, so

    N((t+k/ell)*a) = N(t*a).                            (4)

This preserves the entire phase modulo one and therefore any supplied
distance margin. It does not merely preserve the truth of a threshold test.
The same k preserves every ell-divisible speed simultaneously, regardless
of how many there are or whether any values repeat.

Now let v:Fin 5->Nat be positive at every label. Suppose p:Fin 5 is an
exception with ell not dividing v(p), and ell divides v(i) for every i!=p.
Reindex the other four labels by

    old(j) = v(p.succAbove(j)),  j:Fin 4.

These are four positive natural speeds, with no injectivity requirement.
Apply the checked `fourMovingNaturalRunners` to obtain t0>0 and
`N(t0*old(j))>=1/5` for every j. Apply (3) with x=t0*v(p). It gives a natural
k<ell for which the exceptional norm at

    t = t0+k/ell

is at least 1/4. Every other label retains its norm of at least 1/5 by (4).
Since t0>0, k>=0 and ell>0, also t>0. The two preserved margins both imply
the requested closed 1/6 margin. In fact the proof has spare margin; it
does not obtain strictness from an endpoint perturbation argument.

Every i!=p is some p.succAbove(j), by `Fin.exists_succAbove_eq`; conversely
`Fin.succAbove_ne` excludes p. Thus this proof covers all five labels and
loses none during reindexing. It does not assume sorted speeds or numerical
distinctness, and does not consolidate repeated inputs.

### Relation to existing divisor insertion and rescaling

There is also an existing `codimensionOneDivisorInsertion` theorem. Setting
its old dimension to 4, D=ell, g=gcd(ell,v(p)), c=v(p)/g and m=ell/g supplies
the same reduced orbit. Its closed mesh condition is
`2*m<=6*(m-1)`, which follows from m>=2. To use it, divide each old speed by
ell and first obtain its four-speed witness at s. The resulting time is
`(s+K)/ell`, so old phases become `s*divided(j)+K*divided(j)`.
Every divided speed is positive because it is an exact quotient of a
positive multiple of positive ell. This is a sound alternative route.

The direct t0+k/ell route above avoids this extra division of the old tuple
and retains a positive time immediately. The existing insertion theorem
allows an unbounded integer K and does not itself conclude positive time.
No positivity conclusion should be attributed to that interface without an
additional normalization. Also, `IntegerInduction.lean`'s wrapper
`exists_appended_witness_of_integerInsertionCover` imposes injectivity; it
should not be used to impose that unnecessary restriction on this repeated-
label result. Its coprime-common-divisor constructors do not accept arbitrary
nondivisibility at a composite modulus. The reduced gcd argument is needed.

## Positive primitive normalization

For a nonempty positive natural label family v, let G be its finite gcd and
w(i)=v(i)/G. Then G>0, all w(i)>0, gcd(w)=1 and v(i)=G*w(i). All divisions
are exact and the label set is unchanged. Repeated values remain repeated.
For any real margin delta, witness times transfer in both directions:

    original witness at t  -> primitive witness at s=G*t,
    primitive witness at s -> original witness at t=s/G,

because in either case the real products are equal, coordinate by
coordinate. Positive times stay positive since G>0. Thus absence of a
closed 1/6 witness passes to the primitive tuple, and a theorem proved for
all positive primitive five-label tuples would transfer back by s/G.
Multiplying the witness time by G in the latter direction would be wrong.

This exact positive, repeated-input normalization is already available in
`PrimitivePrompt95.lean`: `speedGCD_pos`, `primitivePart_pos`,
`scaleSpeeds_speedGCD_primitivePart`, `primitiveSpeedFamily_primitivePart`
and `exists_scaleSpeeds_primitive`. Its
`primitiveSpeedFamily_iff_speedGCD_eq_one` identifies the divisor formulation
with the finite gcd equality. Only these checked arithmetic helpers are
relevant; none of the historical Prompt95 redundancy claims is assumed or
relaunched. A lightweight new module may reproduce this short gcd argument
from the same library identities rather than import that larger route module.

`exists_sorted_primitive_integer_normalization` in
`PrimitiveTupleNormalization.lean` instead starts with an injective integer
tuple, sorts/translates it and includes a zero coordinate. It is not the
right direct interface for these arbitrary repeated positive Fin5 inputs.
No new sorted normalization is necessary here.

## Divisibility counts in a hypothetical primitive counterexample

Let v:Fin 5->Nat be positive, with `Finset.univ.gcd v=1`, and assume

    not exists t:Real, forall i, 1/6 <= N(t*v(i)).        (5)

For a fixed ell>=2, let S be the set of labels i with ell dividing v(i).

**Lower count for ell<=6.** If S is empty, each residue v(i)%ell belongs
to {1,...,ell-1}. Its cyclic integer distance is at least one, hence

    N(v(i)/ell) >= 1/ell >= 1/6.

Time 1/ell contradicts (5). Equality at either residue 1 or ell-1, and
at ell=6, is included. No nonzero-residue unit assertion is used.
This entire lower-bound argument already exists in
`SmallDenominatorWitness.lean`: apply `divisor_cover_of_no_small_witness`
with N=6 to get a label in S. Its proof uses the existing exact residue
distance bridge, and permits repeated or even arbitrary natural inputs.
It does not need the primitive or positivity assumptions of the final count.

**Upper count for every ell>=2.** First, not every label lies in S:
otherwise ell divides their finite gcd, so ell divides 1, contradicting
ell>=2. Thus choose p outside S. If |S|>=4, then

    S is a subset of (Finset.univ.erase p), whose cardinality is 4.

The two finite sets have equal cardinality and hence are equal. Consequently
all i!=p are divisible by ell, and p is not. The insertion argument above
constructs a positive all-label 1/6 witness, contradicting (5). Therefore
|S|<=3. Alternatively, if a second missing label existed, S would be
contained in a three-element double-erasure, immediately contradicting
|S|>=4. These are finite-set cardinal identities, not a case enumeration of
speed values or divisibility patterns.

Combining the bounds gives, for every 2<=ell<=6, exactly the desired

    1 <= |{i:Fin 5 : ell divides v(i)}| <= 3.

The upper bound's primitive hypothesis is essential to this reduction:
without it the all-five-divisible case is a scaled copy of the original
five-speed problem. The restriction ell<=6 is used only for the lower bound.
Positive labels are used to invoke the existing four-speed witness theorem.
The no-witness premise quantifies all real times at the closed 1/6 threshold.

## Exact proposed Lean contracts

These are proposed declaration signatures, without proof bodies. They are
not claimed to have been parsed, compiled or added to the repository. Namespace
is `LonelyRunner`; the spelling uses the existing `circleNorm`, standard
Fin/Finset types and explicit real casts. Implement only the needed small
adapters/corollaries, reusing the already checked integer-grid core.

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

No separate new primitive-normalization API is required: the existing positive
factorization helpers already supply it, and the time rescaling is the exact
coordinate identity described above. If a reusable witness-rescaling lemma is
desired, its contract may quantify any index type and real margin, assume a
positive natural scale G and equations v(i)=G*w(i), and conclude equivalence
of the two all-real-time witness existentials. It must not introduce sorting
or injectivity, and must use t=s/G from primitive to original.

## Minimal implementation dependency map

| Checked source | Exact applicable declarations/patterns | Role |
| --- | --- | --- |
| `DivisorInsertion.lean:18`, `:67` | `exists_int_grid_circleNorm_ge`, `exists_int_coprime_grid_circleNorm_ge` | Sharp grid estimate and Bézout permutation; already implemented |
| `FastRunnerInsertion.lean:25`, `:45` | `circleNorm_add_int`, `circleNorm_sub_abs_le_circleNorm` | Exact phase preservation and the grid proof's metric estimate |
| `ReverseGrid.lean:61`, `:131`, `:145` | Euclidean remainder cast pattern, `Int.natMod_lt`, `Int.emod_add_mul_ediv` | Turn arbitrary integer shift into k<n without mishandling negative values |
| `FiveRunnerMixed.lean:279`–`:305` | gcd positivity, exact division factors, `Nat.coprime_div_gcd_div_gcd` | Establish the actual reduced orbit at composite ell |
| `FiveRunnerOrdinary.lean:120` | `fourMovingNaturalRunners` | Positive 1/5 witness for exactly four positive labelled natural speeds, including repeats |
| `FiveRunnerOrdinary.lean:79` | `Fin.exists_succAbove_eq`, `Fin.succAbove_ne` | Reindex all labels except the selected exception |
| `SmallDenominatorWitness.lean:67` | `divisor_cover_of_no_small_witness` | Existing lower divisor-count bound at N=6 |
| `PrimitivePrompt95.lean:48`–`:91` | Positive gcd and primitive-part factorization helpers only | Normalize repeated positive families without changing labels |
| `PrimitiveAffineRank.lean:6` | `Finset.dvd_gcd_iff` use | All-five-divisible contradiction with gcd one |
| `PivotResidues.lean:91`, `:102` | Unit lower cyclic-residue bound and `circleNorm_nat_div_ge` | Existing arithmetic justification of time 1/ell |

Recommended order: bounded natural coprime-grid adapter; reduced nondivisible
orbit/quarter corollary; exact divisible-phase preservation; conditional
five-label insertion; primitive upper count; combine with existing lower
divisor cover. Gcd normalization can reuse the current arithmetic helpers.
There is no reason to rebuild a finite orbit table, impose primality or copy
the sharp real-grid proof. New code should retain explicit endpoint and
reindexing contracts; routine implementation uncertainty must not be resolved
by adding injectivity, odd-prime or coprimality-of-d-with-ell assumptions.

## Source provenance and evidence limits

The following SHA-256 values bind the read source. Source maps describe APIs
actually present in these files; no `.lake` source or build/cache access was
needed. Current checking is manuscript derivation and source inspection only,
with the workflow validator's actual success. The root's existing checked
source status is not relabeled as a fresh build by this task.

```text
212fa6d879bab6d70f09a4a43b2027b96724b5e5ac4a22cdf4b368509973166f  LonelyRunner/DivisorInsertion.lean
dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5  LonelyRunner/FastRunnerInsertion.lean
662d0116f13971bce85e76c503e2f3be4fdc6291ba8113aeda43957e38354ffe  LonelyRunner/FiveRunnerOrdinary.lean
f96f1de48140d77d734f873446b6d73707e2182f5d8ba2761524ee604543b391  LonelyRunner/ReverseGrid.lean
1e27f19d8906ee0d71b452758a38a7c44fff54e0b1b3c1e08dd5354921eb1eb0  LonelyRunner/FiveRunnerMixed.lean
1570a359100594f4a5589588e3b32674dc2d54d60e500df1d47aca64c2faf95f  LonelyRunner/SmallDenominatorWitness.lean
d1d6cf01650c809da0cb19ed722754071df070831e02e22a3c4b2c3dc28afb04  LonelyRunner/PrimitivePrompt95.lean
0b82838ac09e0572a329d7fe12091c250caa746441216e5a7ec84ceb7ff89eb9  LonelyRunner/PrimitiveAffineRank.lean
cac3351bf8c755c0bd354d0330e766f49c255d7ef21637d0975a8d8633cd94b0  LonelyRunner/PrimitiveTupleNormalization.lean
362da5ab923f22e900ae7ac821dd4cf4aab91dfe70889987bc9e5a05d19c276a  LonelyRunner/PivotResidues.lean
7b315fe9ea7f8639eb45e376365f1c3795c52e2f93e608db578390c1083a5753  LonelyRunner/IntegerInduction.lean
49131a7f9690042d1b16cbc876417f9d9ce1b53cc6565f87b6d1b53c4e3340cd  LonelyRunner/Prompt99Scaling.lean
```

The first broad source-location command produced truncated search output;
the focused state/validator and relevant files were then read separately.
No mathematical result is inferred from that truncated output. No experiment
program or numerical receipt exists for this manuscript task, and none is
needed to justify its symbolic derivation.

Final static checks: `python3 scripts/validate_workflow.py` exited 0 and
reported structural validation passed. A read-only SHA-256 check of all
twelve source bindings above also exited 0 with all guards matching. The
proposed signatures and manuscript proofs remain unexecuted Lean work.

This preparation only constrains a hypothetical positive primitive Fin5
counterexample and constructs witnesses in a restricted divisibility case.
It does not rule out all remaining patterns, establish a new runner count,
prove the unconditional five-moving 1/6 supply, fill H7/H8, or resolve LRC.
Root continues the independently owned source integration and kernel pilot.
