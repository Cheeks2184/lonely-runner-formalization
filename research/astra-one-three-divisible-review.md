# Independent mathematical review: exactly one three-divisible label

**Accept all twelve proposed exact contracts and the complete manuscript
argument.** No mathematical defect or missing essential hypothesis was found.
This is acceptance of a mathematical specification for implementation, not a
claim that the new phase lemmas, parity branches or endpoint have Lean proofs.

Reviewed the full frozen `research/astra-one-three-divisible-plan.md`, 769 lines,
40,112 bytes, SHA-256
`9da230600af3a0a0bc8223de3daca2575f8d41f447142687ca64db53ced4ae9e`.
The manuscript was authored by another Astra; I did not author it. Current
config/workflow/policy and focused state were read. Task checkpoint is `bdf6326`,
requested Astra/xhigh, observed model/effort unavailable, research/in_progress.
The actual workflow validator exited 0 with
`workflow structural validation passed; it cannot certify mathematical validity.`

Only this review file is owned. No Lean invocation, source implementation,
mathematical program, numerical fixture, solver, candidate search, cache,
state, Git or root import operation belongs to this review. Concurrent draft
sources were not inspected. The single replay below checks text and hashes;
it is not evidence of mathematical truth or kernel checking.

## Source scope and independent evidence

I directly retrieved Renault's nine-page primary paper copy and checked its
relevant statements. Section 2 uses positive integers and gcd one. The parity
branches are Propositions 4.1, 5.4 and 6.6; Lemma 6.1 has weights (2,1,1),
while Lemma 6.4 assumes initial closed safety and has two strict alternatives
and a closed alternative allowing shift zero. These scopes match the manuscript.
[Renault, DOI 10.1016/j.disc.2004.06.008, Sections 2 and 4–6](https://compmath.wordpress.com/wp-content/uploads/2008/08/view-obstruction_a_shorter_proof_for_6_lonely-runners.pdf).
This is a third-party-hosted copy of the primary paper; publisher-copy byte
identity is not asserted. The text extractor loses some inequality glyphs.
The proof checks below follow independent exact interval reasoning from the
norm definition and the frozen manuscript, not trust in those lost glyphs.

Current source interfaces inspected include the exact three maximizer/improvement
contracts, ComplementSafe, the decoded checked 5.1 theorem, reduced rational
orbit proof, and separated-third-shift lemmas. Previously reviewed fixed
interfaces retain their source bindings below. The phase and orbit claims
new in the manuscript remain proposed; existing 5.1 or large-norm grid results
do not automatically supply them.

## Independent proof audit

### Sixth-grid geometry and CLOSE

Let δ=1/6. For a normalized phase in the open kth sextant, strict badness
at sixth shifts occurs exactly at indices {-k-1,-k} modulo six. At the kth
grid endpoint only {-k} is strictly bad. This follows from the strict open
radius-δ neighborhood of an integer. Closed safety is its complement, so a
point exactly δ away is not incorrectly counted as bad.

For two phases at circle distance at most δ, choose integer lifts of their
negative centers whose separation is at most δ. Their two open radius-δ arcs
lie in an open arc of length at most 3δ=1/2. Four distinct sixth-grid points
in such an arc would have first-to-last separation at least 3/6. At length
1/2 the open endpoints still make that impossible. Therefore their bad union
contains at most three cyclically consecutive grid positions. If such a triple
crosses index zero, deleting zero leaves at most two in L={1,...,5}; otherwise
it is 123,234 or345. Their complements in L are respectively 45,15 and12.
None fits inside a doubled-weight bad class 14,25 or3. If the union has at most
two positions, at least three remain and again cannot fit inside one such
class. This proves CLOSE with a common b and the stated weak distance premise,
including equality N(y-z)=δ. No closed-arc substitution is permissible here.

If three unit-weight bad sets cover all six positions, each must have size two
and the three sets must be disjoint. Each is a cycle edge. The edge containing
zero is 01 or50; in either case the remaining path has a forced perfect
matching, giving 01/23/45 or12/34/50. The exact bad-set/sextant correspondence
then gives one phase in each even sextant or one in each odd sextant.
Grid endpoints are excluded because they have only one bad index. Three
label witnesses must be distinct and give the actual permutation in the
matching contract; repeated input phases cannot satisfy its premise.

### Scalar dilation and mixed Lemma 6.1

For 1/6<u=N(x)≤1/2, the manuscript's ordered cuts 7/30,7/24,7/18,13/30
are exhaustive. At every cut equality, the next row's lower bound places the
selected multiple *strictly* above the left endpoint of its bad interval.
The last row uses 2u≤1<7/6. Thus one of multipliers 5,4,3,5,2 places the phase
strictly within δ of an integer. Integer lifts and norm reflection justify
folding arbitrary real x before this choice.

If both alternatives of mixed 6.1 fail, CLOSE applied at each slope a=2..5
forces N(a(y-z))>δ. The scalar dilation lemma first gives N(y-z)≤δ. Equality
would make N(5(y-z))=δ; a value at most 1/12 would make N(2(y-z))≤δ.
Consequently 1/12<N(y-z)<1/6 and 1/6<N(2(y-z))<1/3.

For A=(B(fract(2y))∪B(fract(2z)))∩L, failure at slope two implies |A|≥3,
while the two unit-weight sets give |A|≤4. If |A|=3, its two-point complement
must be 14 or25, giving A=235 or134. For 235 the only allowed pair is 23,
with phase in (1/2,2/3), and the remaining phase lies in (0,1/6]; for 134 the
intervals are (1/3,1/2) and [5/6,1). Their ordinary positive separation lies
strictly between 1/3 and2/3, so their circle distance exceeds 1/3. This contradicts
the derived bound and retains the singleton grid-endpoint possibilities.

If |A|=4, the two disjoint edges in the path 1–5 have unions 1234,1245 or2345.
The middle case has phases in (2/3,5/6) and(1/6,1/3), also separated by more
than1/3 on the circle. In case1234, the uncovered index5 forces
fract(2u)∈(1/6,1/2). In case2345, uncovered index1 forces
fract(2u)∈(1/2,5/6). Taking the two inverse intervals under doubling yields
exactly the phase ranges stated in the manuscript.

In case1234, mixed choices of the lower/upper y,z intervals violate
N(y-z)<1/6, so they must be both lower or both upper. The four shared strict
shifts are 1,2,4,3 according to the manuscript's table. Direct addition gives
phases strictly in (δ,1-δ) in every row; the sign of an unreduced phase is
irrelevant after an integer turn is removed. In case2345, both lower intervals
are handled by b=3 or2. With both upper, b=4 already strictly protects y,z;
its assumed failure restricts u to (3/4,5/6]. The remaining slope4/shift1
candidate has folded phases in (1/3,2/3], (1/6,1/2), (1/2,5/6), respectively.
They are closed-safe, including u=5/6. Thus all cases contradict failure.
This proves exactly the mixed closed slopes 2..5, shifts1..5, or strict
slope-one shifts1..4, for arbitrary real inputs.

### Initially-safe Lemma 6.4

Initial closed safety normalizes each phase into [1/6,5/6]. Failure of strict
doubling selects m∈[5/12,7/12]; failure at shifts1 and5 selects
h∈[2/3,5/6] and l∈[1/6,1/3]. These intervals are disjoint, so the selections
are three distinct labels and exhaust Fin3. At slope3 the middle phase is
safe. Failure at b=0 therefore means the low phase is strictly bad near one
or the high phase is strictly bad near zero. Absence of a safe shift at slope3
allows the perfect-matching lemma, which excludes all tripled grid endpoints
before the proof uses open sextants.

If the low tripled phase is in sextant5, odd matching forces the high phase
into sextant1 and the middle into sextant3. The resulting intervals for
l,m,h are (5/18,1/3], (1/2,5/9), (13/18,7/9); their fifth phases minus1/6
lie in (2/9,1/2], (1/3,11/18), (4/9,13/18). All are safe, proving the
slope5/shift5 contradiction. In the other case even matching forces the
low and middle tripled phases into sextants4 and2. The resulting fifth phases
plus1/6 lie in (5/18,5/9), (7/18,2/3), [1/2,7/9). These prove the slope5/shift1
contradiction. The apparently retained endpoints l=1/3 or h=2/3 are harmless
weakenings of already-excluded matching endpoints. They do not leave an
unexamined zero phase. Natural b=0 remains allowed in the closed alternative.

### Signed transport, maxima and the first two parity cases

For signs e=±1 and weights w∈{1,2}, multiply the whole phase by e to obtain
N(a(ex)+wb/6)=N(ax+ewb/6). Applying the unsigned lemma to -ex and replacing
b by6-b gives the reflected version because the difference is the integer ew.
The reflected strict sets are exactly {2,4,5} and{2,3,4,5}. The {1,5} set is
stable. The closed alternative of 6.4 needs no reflection; keeping it unsigned
preserves b=0. Every subtraction6-b has the explicit upper bound needed for
natural arithmetic; signs themselves stay integers.

Deleting p yields four positive labelled speeds and a common 1/5 witness.
The inequality1/6<1/5 makes this the strict complement seed required by the
existing oriented-maximizer theorem. Its conclusion matches the proposed
adapter exactly: all-real safe-complement maximum, positive pivot fractional
phase m<δ equal to its norm, and an actual distinct upper-face label. It is
not the zero-permitted two-norm fiber maximum from the earlier branch.

For an odd face r with residue σ=±1, the shift t'=τ+σ/6 makes r's phase zero
and preserves the pivot phase. Applying the signed/reflected three-phase lemma
to the other three labels returns one common candidate. A closed slope a≥2
strictly improves the pivot at aτ+(aσ+b)/6 and keeps the complete complement
safe. The integer numerator aσ+b is permitted by the checked dilation API.
A strict slope-one candidate keeps the pivot's actual phase m and puts every
complement phase in [δ,5/6), with the face at the stated lower/interior phase.
The checked forward-improvement theorem allows the lower endpoint and requires
precisely this excluded upper endpoint. A single positive increment then
contradicts the all-real maximum. No intermediate time positivity is assumed.

In the one-even case the three-phase lemma is the checked unit-weight5.1.
In the two-even case with odd face, the other even label is assigned to index0
of mixed6.1 and the remaining two weights are one. With an even face instead,
the three odd phases at τ satisfy initial closed safety, so signed6.4 applies.
Its three alternatives put the even face respectively at2/3, at1/6 or1/2,
or at an odd sixth. The last assertion follows from the odd integer
5a±2b for a=3 or5, including b=0. Thus a≥2 uses strict pivot dilation; a=1
uses forward improvement. All choices are common to the labelled triple and
then to all four complement labels. Repeated speed values are never discarded.

### Weak avoidance, prescribed orbit and the three-even finish

For three selected nondivisible exceptions with N(old)≤δ, each nonzero third
shift has circle separation1/3, so the triangle inequality gives N(new)≥δ.
They are safe at both shifts1 and2. The only remaining exception has at most
one *strictly* bad shift, leaving one of those two shifts safe for it. The
pivot is preserved. If more than three exceptions are weakly bad, select any
three distinct labels; the same argument still works. No positivity or gcd
premise is needed by this helper.

For weak-even avoidance, the first phase is safe at all shifts1,2,4,5. The
second phase can forbid only14 or25, while the unit-weight phase's possible
two-element forbidden sets on that domain are12 or45. These cannot cover the
remaining pair. For weak-odd avoidance, a lift z∈[-δ,δ] can be strictly bad
only at1 or5, and not both. If neither doubled class forbids3, that shift works;
otherwise one doubled class is the singleton3, and the total forbidden union
has at most four positions among five. Both arguments retain equality atδ and
return one shared shift. Applying sign normalization gives actual sixth-time
shifts for residues±2,±1.

At a time with odd U at zero and the six-divisible pivot safe, these two
avoidance lemmas force the other three phases E,F,W strictly safe under hno.
If N(tW)≤1/3, adding half a time unit preserves the three even labels, makes
U have phase1/2 and makes W's norm1/2-N(tW)≥δ. This is a witness, so necessarily
N(tW)>1/3. This deduction requires all three even labels to be safe at that
same t; the manuscript has supplied that, not just pivot safety.

For the new orbit lemma, put g=gcd(q,A)>0, n=q/g, c=A/g. Divisibility gives
q=gn,A=gc; the existing gcd API gives Coprime(c,n). Nondivisibility q∤A implies
n>1, and n∣q with Coprime(q,6) gives n coprime to6. Hence n=5 or n≥7.
The construction does not presume arbitrary nonzero residues of composite q
are units. For n=5 use m=1. For7≤n<12 use m=1 again. For n≥12 use
m=ceil(n/12), with n/12≤m≤n/12+1≤n/6 and 1≤m<n. Thus m/n has exactly
the prescribed closed small band, or is1/5. A Bézout inverse of c modulo n
provides a natural k<n with kc≡m; k<n≤q and f(kA/q)=m/n. The missing
implementation is this prescribed-residue orbit step, not an inference from
the existing large-distance mesh conclusion. q=1 or A=0 is already impossible
under hnot; all valid composite denominators are included.

If U∤A, applying that lemma gives s=k/U with U at zero at s,2s,4s.
The pivot's selected phase r∈[1/12,1/6] or r=1/5 makes both2r and4r closed-safe.
The preceding consequence yields N(2sW)>1/3 and N(4sW)>1/3. Yet folding
N(x)>1/3 gives N(2x)=1-2N(x)<1/3, including N(x)=1/2. Contradiction proves
U∣A, and symmetry gives W∣A. Coprimality with6 then gives the *full* products
6U∣A and6W∣A, hence6U≤A and6W≤A. There is still no bound on E,F and no
fast-speed theorem may be invoked on this information alone.

At t0=1/(6A), every a=1..5 makes the pivot closed-safe. Both odd phases are
in (0,5/36], whose closed upper endpoint still satisfies5/36<δ.
If E orF were weakly bad, the weak-three-exception lemma would produce a
witness. Therefore both are strictly safe at all these dilations. Apply the
scalar bad-dilation lemma to t0*E; its a∈2..5 contradicts that strict safety.
This completes the three-even branch with no maximum construction, recursive
count argument or further speed-ratio premise.

### Endpoint and finite labels

Under primitive one-three-divisible nonexistence, the exact singleton filter
identifies p, divisor-count lower6 makes it six-divisible, and divisor-count
bounds at2 restrict the even count to1,2 or3. The three normalized parity
lemmas apply without an internal primitive assumption. Their labels come from
finite complements/subtypes; distinct *labels*, not distinct values, justify
the Fin3 reindexings and two odd exceptions. Every contradiction builds a
single all-real witness. Zero time cannot witness a positive sixth margin;
negating a negative witness preserves all norms and gives a positive one.
Thus the final endpoint retains all its exact positivity/gcd/count premises.

## Exact accepted contracts

The following seven Lean fences contain all twelve proposed declarations,
copied byte-for-byte from the frozen manuscript. They remain specifications;
none is elaborated or proved as part of this review.

```lean
theorem fiveMovingNaturalRunners_of_one_three_divisible
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (hprimitive : Finset.univ.gcd v = 1)
    (hone : ((Finset.univ : Finset (Fin 5)).filter
      (fun i => 3 ∣ v i)).card = 1) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))
```

```lean
theorem exists_one_sixth_complement_maximizer
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i) (p : Fin 5)
    (hno : ¬ ∃ t : ℝ, ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))) :
    ∃ τ : ℝ, 0 < τ ∧ τ < 1 ∧
      ComplementSafe v p ((1 : ℝ) / 6) τ ∧
      (∀ t : ℝ, ComplementSafe v p ((1 : ℝ) / 6) t →
        circleNorm (t * (v p : ℝ)) ≤ circleNorm (τ * (v p : ℝ))) ∧
      0 < Int.fract (τ * (v p : ℝ)) ∧
      Int.fract (τ * (v p : ℝ)) < (1 : ℝ) / 6 ∧
      Int.fract (τ * (v p : ℝ)) = circleNorm (τ * (v p : ℝ)) ∧
      ∃ r, r ≠ p ∧ Int.fract (τ * (v r : ℝ)) = (5 : ℝ) / 6
```

```lean
theorem renault_phase_six_one (x : Fin 3 → ℝ) :
    (∃ a b : ℕ, 2 ≤ a ∧ a ≤ 5 ∧ 1 ≤ b ∧ b ≤ 5 ∧
      ∀ j, (1 : ℝ) / 6 ≤ circleNorm
        ((a : ℝ) * x j +
          (if j = 0 then (2 : ℝ) else 1) * (b : ℝ) / 6)) ∨
    (∃ b : ℕ, 1 ≤ b ∧ b ≤ 4 ∧
      ∀ j, (1 : ℝ) / 6 < circleNorm
        (x j + (if j = 0 then (2 : ℝ) else 1) * (b : ℝ) / 6))
```

```lean
theorem renault_phase_six_four (x : Fin 3 → ℝ)
    (hx : ∀ j, (1 : ℝ) / 6 ≤ circleNorm (x j)) :
    (∀ j, (1 : ℝ) / 6 < circleNorm (2 * x j)) ∨
    (∃ b : ℕ, (b = 1 ∨ b = 5) ∧
      ∀ j, (1 : ℝ) / 6 < circleNorm (x j + (b : ℝ) / 6)) ∨
    (∃ a b : ℕ, (a = 3 ∨ a = 5) ∧ b ≤ 5 ∧
      ∀ j, (1 : ℝ) / 6 ≤
        circleNorm ((a : ℝ) * x j + (b : ℝ) / 6))
```

```lean
theorem exists_reciprocal_time_small_phase
    (A q : ℕ) (hq : 0 < q) (hcop : Nat.Coprime q 6)
    (hnot : ¬ q ∣ A) :
    ∃ k : ℕ, k < q ∧
      (((1 : ℝ) / 12 ≤ Int.fract ((k : ℝ) * (A : ℝ) / (q : ℝ)) ∧
        Int.fract ((k : ℝ) * (A : ℝ) / (q : ℝ)) ≤ (1 : ℝ) / 6) ∨
       Int.fract ((k : ℝ) * (A : ℝ) / (q : ℝ)) = (1 : ℝ) / 5)
```

```lean
theorem exists_bad_sixth_dilate (x : ℝ)
    (hx : (1 : ℝ) / 6 < circleNorm x) :
    ∃ a : ℕ, 2 ≤ a ∧ a ≤ 5 ∧
      circleNorm ((a : ℝ) * x) < (1 : ℝ) / 6

theorem sixth_shift_close_pair (x y z : ℝ)
    (hyz : circleNorm (y - z) ≤ (1 : ℝ) / 6) :
    ∃ b : ℕ, 1 ≤ b ∧ b ≤ 5 ∧
      (1 : ℝ) / 6 ≤ circleNorm (x + 2 * (b : ℝ) / 6) ∧
      (1 : ℝ) / 6 ≤ circleNorm (y + (b : ℝ) / 6) ∧
      (1 : ℝ) / 6 ≤ circleNorm (z + (b : ℝ) / 6)

theorem sixth_shift_weak_even (x y z : ℝ)
    (hx : circleNorm x ≤ (1 : ℝ) / 6) :
    ∃ b : ℕ, (b = 1 ∨ b = 2 ∨ b = 4 ∨ b = 5) ∧
      (1 : ℝ) / 6 ≤ circleNorm (x + 2 * (b : ℝ) / 6) ∧
      (1 : ℝ) / 6 ≤ circleNorm (y + 2 * (b : ℝ) / 6) ∧
      (1 : ℝ) / 6 ≤ circleNorm (z + (b : ℝ) / 6)

theorem sixth_shift_weak_odd (x y z : ℝ)
    (hz : circleNorm z ≤ (1 : ℝ) / 6) :
    ∃ b : ℕ, 1 ≤ b ∧ b ≤ 5 ∧
      (1 : ℝ) / 6 ≤ circleNorm (x + 2 * (b : ℝ) / 6) ∧
      (1 : ℝ) / 6 ≤ circleNorm (y + 2 * (b : ℝ) / 6) ∧
      (1 : ℝ) / 6 ≤ circleNorm (z + (b : ℝ) / 6)

theorem third_shift_of_three_weak_exceptions
    (v : Fin 5 → ℕ) (p : Fin 5)
    (hdiv : 3 ∣ v p) (hother : ∀ i, i ≠ p → ¬ 3 ∣ v i)
    (t : ℝ) (hp : (1 : ℝ) / 6 ≤ circleNorm (t * (v p : ℝ)))
    (hbad : 3 ≤ ((Finset.univ : Finset (Fin 5)).filter
      (fun i => i ≠ p ∧ circleNorm (t * (v i : ℝ)) ≤ (1 : ℝ) / 6)).card) :
    ∃ k : Fin 3, ∀ i, (1 : ℝ) / 6 ≤ circleNorm
      ((t + (k.val : ℝ) / 3) * (v i : ℝ))

theorem no_sixth_shift_implies_sextant_matching (x : Fin 3 → ℝ)
    (hno : ¬ ∃ b : Fin 6, ∀ j, (1 : ℝ) / 6 ≤
      circleNorm (x j + (b.val : ℝ) / 6)) :
    ∃ e : Fin 2, ∃ π : Equiv.Perm (Fin 3), ∀ j : Fin 3,
      ((2 * j.val + e.val : ℕ) : ℝ) / 6 < Int.fract (x (π j)) ∧
      Int.fract (x (π j)) < ((2 * j.val + e.val + 1 : ℕ) : ℝ) / 6
```

```lean
theorem one_three_divisible_parity_witness
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i) (p : Fin 5)
    (hsix : 6 ∣ v p) (hone : ∀ i, 3 ∣ v i ↔ i = p)
    (e : ℕ) (he : e = 1 ∨ e = 2 ∨ e = 3)
    (heven : ((Finset.univ : Finset (Fin 5)).filter
      (fun i => 2 ∣ v i)).card = e) :
    ∃ t : ℝ, ∀ i, (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))
```

## First safe implementation batches and scope

The two already assigned small contracts, `exists_bad_sixth_dilate` and
`third_shift_of_three_weak_exceptions`, are accepted independently of all mixed
phase work. This verdict concerns their manuscript specifications, not their
concurrent draft source. A useful next independent batch is the maximum adapter
from the checked four-moving seed and the signed/reflected5.1 transport for the
one-even case. The first common scalar foundation batch should establish the
exact sixth-grid bad-set shape, CLOSE, weak-even/weak-odd avoidance and sextant
matching. The prescribed coprime-residue orbit lemma is another independent
arithmetic batch. Then6.1/6.4 can be implemented from the settled interval cases
before the two-even assembly. These tasks need no numeric search or a new
candidate certificate. Finite label equivalences, exact casts and all theorem
compositions still require Lean proofs and independent source review.

The scope remains the canonical N=6 milestone followed by research on an
explicit uniform arbitrary-N mechanism. Successive higher runner counts are
not the roadmap; the N=6 milestone does not complete unrestricted LRC.

## Static-only replay and retained source bindings

The following sole Bash entry checks the frozen manuscript, all fifteen source
bindings it supplied, and the seven verbatim contract fences/twelve declaration
names above. It invokes no Lean, arithmetic experiment or solver and writes no
files. Bounds:10s wall, CPU9/10s, AS256MiB, regular-file limit128KiB, no core dump.
Its bounded output is captured in full by the separate execution receipt.
Hashes bind text only; they neither prove these contracts nor attest compiled
artifacts. Mutable root integration, concurrent drafts and policy files are
intentionally outside these mathematical source bindings.

Static launcher SHA-256: `2716a10c3a0c677268895cb892a8996c5b81e2f4f99913c1ee74d1d542943917`

```bash
#!/usr/bin/env bash
set -euo pipefail
cd /home/joshua/lonely-runner-formalization
timeout 10s python3 - <<'PY_STATIC'
import hashlib
import json
from pathlib import Path
import re
import resource

resource.setrlimit(resource.RLIMIT_AS, (256 * 1024**2,) * 2)
resource.setrlimit(resource.RLIMIT_CPU, (9, 10))
resource.setrlimit(resource.RLIMIT_FSIZE, (128 * 1024,) * 2)
resource.setrlimit(resource.RLIMIT_CORE, (0, 0))
root = Path('/home/joshua/lonely-runner-formalization')
guards = {
    'research/astra-one-three-divisible-plan.md': '9da230600af3a0a0bc8223de3daca2575f8d41f447142687ca64db53ced4ae9e',
    'lean-toolchain': '8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af',
    'lake-manifest.json': '887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218',
    'LonelyRunner/SixTotalDivisorCounts.lean': '0b62ef724eb8c24db4085e247e9f16f650ec450291c7ccac2b0ad0981f148727',
    'LonelyRunner/RenaultPhaseLemma.lean': '1ceac85438299dffdd48d57fb0052b598a9bd5eda995cabff0256885529d89cb',
    'LonelyRunner/ConstrainedMaximizer.lean': '2ef07e6b83b8675a22184571c31d2a71dab9d5c072e3cd165cb8382957b46e92',
    'LonelyRunner/FiveRunnerOrdinary.lean': '662d0116f13971bce85e76c503e2f3be4fdc6291ba8113aeda43957e38354ffe',
    'LonelyRunner/FiveMovingFast.lean': 'cc203315c6d36be23b7cdcfc9706785fb05e6d5406c84714a9fea42bdfce7212',
    'LonelyRunner/RationalShiftOrbits.lean': 'cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591',
    'LonelyRunner/RationalShiftGcd.lean': '6e9d1e3e084188a651e4c875cf36fd5d6fc7cbd5f1914784019a207a0cec01f4',
    'LonelyRunner/DivisorInsertion.lean': '212fa6d879bab6d70f09a4a43b2027b96724b5e5ac4a22cdf4b368509973166f',
    'LonelyRunner/SixthAffinePhase.lean': '76e420713079ec0c3979e9b169cd78ecb6a932d6dc790ea7d9711adbb64b7d4b',
    'LonelyRunner/FoldedCirclePhase.lean': '957606878108847d5ceff47be621ff0fc9c0a0d976568b5f5ef3dbb6db10481e',
    'LonelyRunner/SeparatedPhaseFamily.lean': '28c5db2425eef754156e57c284959ff02da743f1fde424e053c4eae0c721b6bd',
    'LonelyRunner/ThirdShiftSpacing.lean': '146cdfd80495aced0eb93bc322559cf7e950a80b0d01534b2a57cce7129debaa',
    'LonelyRunner/ModularCertificates.lean': '8b7e9dc5be1236acb812607c19454fe43ecd1333145aef675e7df8e6d0c3871c',
}
names = ['fiveMovingNaturalRunners_of_one_three_divisible', 'exists_one_sixth_complement_maximizer', 'renault_phase_six_one', 'renault_phase_six_four', 'exists_reciprocal_time_small_phase', 'exists_bad_sixth_dilate', 'sixth_shift_close_pair', 'sixth_shift_weak_even', 'sixth_shift_weak_odd', 'third_shift_of_three_weak_exceptions', 'no_sixth_shift_implies_sextant_matching', 'one_three_divisible_parity_witness']
sha = lambda b: hashlib.sha256(b).hexdigest()
for path, expected in guards.items():
    assert sha((root / path).read_bytes()) == expected, path
plan = (root / 'research/astra-one-three-divisible-plan.md').read_text()
report = (root / 'research/astra-one-three-divisible-review.md').read_text()
fence = chr(96) * 3
pattern = re.escape(fence + 'lean\n') + '(.*?)' + re.escape(fence)
original = [s for s in re.findall(pattern, plan, re.S) if s.startswith('theorem ')]
copied = re.findall(pattern, report, re.S)
assert len(original) == len(copied) == 7
assert copied == original, 'exact contract fences'
assert [n for s in copied for n in re.findall(r'^theorem (\w+)', s, re.M)] == names
program = report.split(fence + 'bash\n', 1)[1].split(fence, 1)[0].encode()
expected = re.search(r'^Static launcher SHA-256: `([0-9a-f]{64})`$', report, re.M)
assert expected and sha(program) == expected.group(1), 'static program predeclaration'
receipt = {
    'kind': 'static text/hash binding check only',
    'mathematical_execution': False,
    'lean_invoked': False,
    'files_written_by_entry': 0,
    'plan_bytes': len(plan.encode()),
    'plan_lines': len(plan.splitlines()),
    'bindings_checked': guards,
    'contract_fences': len(copied),
    'contract_bytes': sum(len(s.encode()) for s in copied),
    'declarations': names,
    'program_bytes': len(program),
    'program_sha256': sha(program),
    'limits': {'address_space_bytes': 256 * 1024**2, 'cpu_seconds': [9, 10],
               'wall_seconds': 10, 'file_bytes': 128 * 1024},
    'passed': True,
}
print(json.dumps(receipt, sort_keys=True, indent=2))
PY_STATIC
```

## Actual static replay receipt

The sole static replay exited 0 with complete stdout/stderr retained below.
This checks immutable text bindings and exact contract copies only. It is not a
mathematical experiment, implementation test or kernel proof check.

Actual receipt SHA-256: `a5a485f7bde40d91b9ed44765040389401b9ed4af7f537b1c5ea2437c9e2bfd0`

```json
{
  "actual_exit": 0,
  "argv": [
    "bash",
    "-c",
    "<exact sole Bash fence>"
  ],
  "passed": true,
  "program_bytes": 4273,
  "program_sha256": "2716a10c3a0c677268895cb892a8996c5b81e2f4f99913c1ee74d1d542943917",
  "stderr": "",
  "stderr_bytes": 0,
  "stderr_sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
  "stdout": "{\n  \"bindings_checked\": {\n    \"LonelyRunner/ConstrainedMaximizer.lean\": \"2ef07e6b83b8675a22184571c31d2a71dab9d5c072e3cd165cb8382957b46e92\",\n    \"LonelyRunner/DivisorInsertion.lean\": \"212fa6d879bab6d70f09a4a43b2027b96724b5e5ac4a22cdf4b368509973166f\",\n    \"LonelyRunner/FiveMovingFast.lean\": \"cc203315c6d36be23b7cdcfc9706785fb05e6d5406c84714a9fea42bdfce7212\",\n    \"LonelyRunner/FiveRunnerOrdinary.lean\": \"662d0116f13971bce85e76c503e2f3be4fdc6291ba8113aeda43957e38354ffe\",\n    \"LonelyRunner/FoldedCirclePhase.lean\": \"957606878108847d5ceff47be621ff0fc9c0a0d976568b5f5ef3dbb6db10481e\",\n    \"LonelyRunner/ModularCertificates.lean\": \"8b7e9dc5be1236acb812607c19454fe43ecd1333145aef675e7df8e6d0c3871c\",\n    \"LonelyRunner/RationalShiftGcd.lean\": \"6e9d1e3e084188a651e4c875cf36fd5d6fc7cbd5f1914784019a207a0cec01f4\",\n    \"LonelyRunner/RationalShiftOrbits.lean\": \"cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591\",\n    \"LonelyRunner/RenaultPhaseLemma.lean\": \"1ceac85438299dffdd48d57fb0052b598a9bd5eda995cabff0256885529d89cb\",\n    \"LonelyRunner/SeparatedPhaseFamily.lean\": \"28c5db2425eef754156e57c284959ff02da743f1fde424e053c4eae0c721b6bd\",\n    \"LonelyRunner/SixTotalDivisorCounts.lean\": \"0b62ef724eb8c24db4085e247e9f16f650ec450291c7ccac2b0ad0981f148727\",\n    \"LonelyRunner/SixthAffinePhase.lean\": \"76e420713079ec0c3979e9b169cd78ecb6a932d6dc790ea7d9711adbb64b7d4b\",\n    \"LonelyRunner/ThirdShiftSpacing.lean\": \"146cdfd80495aced0eb93bc322559cf7e950a80b0d01534b2a57cce7129debaa\",\n    \"lake-manifest.json\": \"887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218\",\n    \"lean-toolchain\": \"8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af\",\n    \"research/astra-one-three-divisible-plan.md\": \"9da230600af3a0a0bc8223de3daca2575f8d41f447142687ca64db53ced4ae9e\"\n  },\n  \"contract_bytes\": 4498,\n  \"contract_fences\": 7,\n  \"declarations\": [\n    \"fiveMovingNaturalRunners_of_one_three_divisible\",\n    \"exists_one_sixth_complement_maximizer\",\n    \"renault_phase_six_one\",\n    \"renault_phase_six_four\",\n    \"exists_reciprocal_time_small_phase\",\n    \"exists_bad_sixth_dilate\",\n    \"sixth_shift_close_pair\",\n    \"sixth_shift_weak_even\",\n    \"sixth_shift_weak_odd\",\n    \"third_shift_of_three_weak_exceptions\",\n    \"no_sixth_shift_implies_sextant_matching\",\n    \"one_three_divisible_parity_witness\"\n  ],\n  \"files_written_by_entry\": 0,\n  \"kind\": \"static text/hash binding check only\",\n  \"lean_invoked\": false,\n  \"limits\": {\n    \"address_space_bytes\": 268435456,\n    \"cpu_seconds\": [\n      9,\n      10\n    ],\n    \"file_bytes\": 131072,\n    \"wall_seconds\": 10\n  },\n  \"mathematical_execution\": false,\n  \"passed\": true,\n  \"plan_bytes\": 40112,\n  \"plan_lines\": 769,\n  \"program_bytes\": 4273,\n  \"program_sha256\": \"2716a10c3a0c677268895cb892a8996c5b81e2f4f99913c1ee74d1d542943917\"\n}\n",
  "stdout_bytes": 2778,
  "stdout_sha256": "208cbd6a5c1f7e4f81726d076b7ec9a9934b5a1f275fb31f1e7ecb3588499609",
  "timeout": false,
  "wall_seconds": 0.023401982994982973
}
```

Complete original static stdout, unescaped:

```text
{
  "bindings_checked": {
    "LonelyRunner/ConstrainedMaximizer.lean": "2ef07e6b83b8675a22184571c31d2a71dab9d5c072e3cd165cb8382957b46e92",
    "LonelyRunner/DivisorInsertion.lean": "212fa6d879bab6d70f09a4a43b2027b96724b5e5ac4a22cdf4b368509973166f",
    "LonelyRunner/FiveMovingFast.lean": "cc203315c6d36be23b7cdcfc9706785fb05e6d5406c84714a9fea42bdfce7212",
    "LonelyRunner/FiveRunnerOrdinary.lean": "662d0116f13971bce85e76c503e2f3be4fdc6291ba8113aeda43957e38354ffe",
    "LonelyRunner/FoldedCirclePhase.lean": "957606878108847d5ceff47be621ff0fc9c0a0d976568b5f5ef3dbb6db10481e",
    "LonelyRunner/ModularCertificates.lean": "8b7e9dc5be1236acb812607c19454fe43ecd1333145aef675e7df8e6d0c3871c",
    "LonelyRunner/RationalShiftGcd.lean": "6e9d1e3e084188a651e4c875cf36fd5d6fc7cbd5f1914784019a207a0cec01f4",
    "LonelyRunner/RationalShiftOrbits.lean": "cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591",
    "LonelyRunner/RenaultPhaseLemma.lean": "1ceac85438299dffdd48d57fb0052b598a9bd5eda995cabff0256885529d89cb",
    "LonelyRunner/SeparatedPhaseFamily.lean": "28c5db2425eef754156e57c284959ff02da743f1fde424e053c4eae0c721b6bd",
    "LonelyRunner/SixTotalDivisorCounts.lean": "0b62ef724eb8c24db4085e247e9f16f650ec450291c7ccac2b0ad0981f148727",
    "LonelyRunner/SixthAffinePhase.lean": "76e420713079ec0c3979e9b169cd78ecb6a932d6dc790ea7d9711adbb64b7d4b",
    "LonelyRunner/ThirdShiftSpacing.lean": "146cdfd80495aced0eb93bc322559cf7e950a80b0d01534b2a57cce7129debaa",
    "lake-manifest.json": "887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218",
    "lean-toolchain": "8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af",
    "research/astra-one-three-divisible-plan.md": "9da230600af3a0a0bc8223de3daca2575f8d41f447142687ca64db53ced4ae9e"
  },
  "contract_bytes": 4498,
  "contract_fences": 7,
  "declarations": [
    "fiveMovingNaturalRunners_of_one_three_divisible",
    "exists_one_sixth_complement_maximizer",
    "renault_phase_six_one",
    "renault_phase_six_four",
    "exists_reciprocal_time_small_phase",
    "exists_bad_sixth_dilate",
    "sixth_shift_close_pair",
    "sixth_shift_weak_even",
    "sixth_shift_weak_odd",
    "third_shift_of_three_weak_exceptions",
    "no_sixth_shift_implies_sextant_matching",
    "one_three_divisible_parity_witness"
  ],
  "files_written_by_entry": 0,
  "kind": "static text/hash binding check only",
  "lean_invoked": false,
  "limits": {
    "address_space_bytes": 268435456,
    "cpu_seconds": [
      9,
      10
    ],
    "file_bytes": 131072,
    "wall_seconds": 10
  },
  "mathematical_execution": false,
  "passed": true,
  "plan_bytes": 40112,
  "plan_lines": 769,
  "program_bytes": 4273,
  "program_sha256": "2716a10c3a0c677268895cb892a8996c5b81e2f4f99913c1ee74d1d542943917"
}
```

Complete original stderr (zero bytes):

```text
```

Final disposition remains acceptance of the twelve exact mathematical contracts
for implementation. All seven copied contract fences and all sixteen bindings
passed the static replay. No Lean/kernel result is claimed for the new lemmas.
The first safe drafting batch is the independent scalar bad-dilation and
three-weak-exception contracts; the next independent work can package the
existing maximum/signed5.1 route and prove the sixth-grid geometry and prescribed
coprime orbit interfaces as described above. The canonical N=6 milestone and
subsequent uniform arbitrary-N priority remain unchanged.
