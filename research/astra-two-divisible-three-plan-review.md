# Independent manuscript review: Renault's two-divisible-three branch

**Verdict: accept all seven proposed exact contracts and the complete symbolic
derivation.** No mathematical defect or missing essential hypothesis was found.
This is acceptance for implementation, not a claim that the new declarations
have been elaborated, proved in Lean, or audited by the kernel.

Reviewed the entire 482-line, 27605-byte manuscript
`research/astra-two-divisible-three-reduction-plan.md`, SHA-256
`07f27873785c463d7f9b2e8c2074510f42fcd973d07cc6e73ea62e5b3bac0ad6`.
The reviewer did not author it. Requested route is Astra/xhigh; independent
runtime model/effort attestation is unavailable. Assigned source checkpoint:
`354b5106ba34d0f92a2c991ea708d04ec34cfe22`. Only this review report is owned
and edited here; other workers' files and all source/state/Git/cache contents
are preserved.

## Primary source and evidence boundary

The primary mathematical source is Jérôme Renault, *View-obstruction: a shorter
proof for 6 lonely runners*, Discrete Mathematics 287 (2004), 93–101,
DOI 10.1016/j.disc.2004.06.008. This review directly retrieved the cited
[primary PDF copy](https://compmath.wordpress.com/wp-content/uploads/2008/08/view-obstruction_a_shorter_proof_for_6_lonely-runners.pdf).
It is a third-party-hosted copy of the paper, with nine pages; no publisher-copy
byte identity or downloaded-PDF hash is claimed.

The extracted text confirms: Section 2, printed p.94, fixes five positive
integer speeds with gcd one and defines safety using closed endpoints;
Proposition 3.1, printed pp.95–96, treats at least two speeds divisible by
three. It contains two third-shift arguments, an anchored pair-norm maximum,
residue cases, and the final divisibility/ratio step. The integer statement
does not require distinct speeds. The name is Proposition, not Lemma.
These source-scope observations use pp.94–96 only; no later paper case is
reviewed here.

The browser text extraction loses some inequality glyphs; therefore it is
used for source identification and proof structure, not as an inequality
oracle. Screenshot requests returned only reference text through this runtime,
so this report does not claim visual inspection of screenshots. Every
inequality and phase calculation below was checked independently from the
mathematical definitions and the frozen manuscript. No numerical fixture,
mathematical program, search, Lean command, compiler, build, or solver was run.

The reconstruction makes useful details explicit: a finite fiber maximum
that permits zero, signed rather than truncated transport, a folded scalar
bound a≥1/8, the two distinct badness times in the even case, and the full
hypotheses needed for gcd removal. Those are reviewed arguments below, not
additional results attributed verbatim to the paper.

## Exact accepted theorem contracts

These six code blocks are byte-for-byte extracted from the frozen manuscript
and contain its seven new declarations. They are specifications, not executed
Lean code. The separately quoted existing `fastRunnerInsertion` declaration
is not counted among the seven.

```lean
theorem false_of_primitive_no_sixth_witness_two_divisible_three
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (hprimitive : Finset.univ.gcd v = 1)
    (htwo : ((Finset.univ : Finset (Fin 5)).filter
      (fun i => 3 ∣ v i)).card = 2)
    (hno : ¬ ∃ t : ℝ, ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))) : False
```

```lean
theorem fiveMovingNaturalRunners_of_two_divisible_three
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (htwo : ((Finset.univ : Finset (Fin 5)).filter
      (fun i => 3 ∣ v i)).card = 2) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))

theorem fiveMovingNaturalRunners_of_primitive_two_divisible_three
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i)
    (hprimitive : Finset.univ.gcd v = 1)
    (htwo : 2 ≤ ((Finset.univ : Finset (Fin 5)).filter
      (fun i => 3 ∣ v i)).card) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))
```

```lean
theorem fiveMovingNaturalRunners_of_fast_speed
    (v : Fin 5 → ℕ) (hpos : ∀ i, 0 < v i) (p : Fin 5)
    (hfast : ∀ i, i ≠ p → 5 * v i ≤ v p) :
    ∃ t : ℝ, 0 < t ∧ ∀ i,
      (1 : ℝ) / 6 ≤ circleNorm (t * (v i : ℝ))
```

```lean
theorem exists_five_sixths_fiber_pair_maximizer
    (a b c : ℕ) (hc : 0 < c) :
    ∃ τ : ℝ, 0 < τ ∧ τ < 1 ∧
      Int.fract (τ * (c : ℝ)) = (5 : ℝ) / 6 ∧
      ∀ t : ℝ, Int.fract (t * (c : ℝ)) = (5 : ℝ) / 6 →
        min (circleNorm (t * (a : ℝ))) (circleNorm (t * (b : ℝ))) ≤
          min (circleNorm (τ * (a : ℝ))) (circleNorm (τ * (b : ℝ)))
```

```lean
theorem two_divisible_folded_band (a b : ℝ)
    (ha0 : 0 < a) (ha6 : a < (1 : ℝ) / 6)
    (hab : a ≤ b) (hbhalf : b ≤ (1 : ℝ) / 2)
    (h3 : circleNorm (3 * b) ≤ a)
    (h5 : circleNorm (5 * b) ≤ a) :
    (1 : ℝ) / 8 ≤ a ∧ (11 : ℝ) / 30 < b ∧ b < (7 : ℝ) / 18
```

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

The fiber theorem requires only c>0; its a,b may be zero. The scalar theorem
does not omit b≥0: ha0 and hab imply b>0. The boundary theorem keeps arbitrary
real t, two distinct divisible labels, an outside anchor, an actual multiple
of six among the pair, the even-count bound, and nonexistence of an all-real
closed witness. Neither count adapter adds injectivity. The primitive theorem
named `...of_primitive_two_divisible_three` has **at least two** in its type;
that is the accepted scope despite the abbreviated name.

## Independent proof review

Put N(x)=circleNorm x and X_i(t)=Int.fract(t*v_i), with real casts of natural
speeds understood. Say W(t) if N(t*v_i)≥1/6 for every label. Badness always
means N<1/6. Work under ¬∃t∈ℝ,W(t) only when deriving a contradiction.

### 1. Fast-speed witness and positivity

Remove the chosen label p using `p.succAbove : Fin 4 → Fin 5`. Every retained
speed is positive, so `fourMovingNaturalRunners` supplies a positive fifth-margin
seed. In `fastRunnerInsertion`, instantiate n=4, the old real speeds, and
newSpeed=v_p. The hypothesis 5*v_i≤v_p gives the required absolute-value
inequality because all these speeds are positive; v_p≠0 also follows.
The insertion gives all five closed sixth-margin bounds at a real time u.
The complement reindexing covers every label unequal to p, independent of
whether speed values repeat.

The perturbation estimate does not guarantee u>0. Instead W(0) is impossible
since N(0)=0<1/6, so u≠0. Reflect u to -u if necessary; N(-x)=N(x) preserves
the whole witness. The equality case in 5*v_i≤v_p remains valid. No primitive,
divisibility, strict-seed, or general five-moving sixth-margin premise enters.

Consequently nonexistence implies, for each selected label p, another label
i≠p with v_p<5*v_i. A comparison between two specifically selected speeds
needs the divisibility cover proved later.

### 2. The two rescue mechanisms and their exact shared-shift content

Let p≠q be exactly the labels whose speeds are divisible by three.
There are three outside labels. For an outside label i and arbitrary real
seed t, set B_i={k∈Fin 3:N((t+k.val/3)*v_i)<1/6}.
The checked third-shift spacing theorem gives separation at least 1/3
between distinct k. The triangle inequality implies that two strictly bad
phases would have mutual norm below 2*(1/6)=1/3. Thus |B_i|≤1.
Divisible labels p,q preserve their norms at every candidate shift.

If two distinct labels u,w are bad at t while p,q are safe, then u,w lie
outside the pair and 0 belongs to both B_u and B_w. Their subsingleton bounds
give B_u=B_w={0}. If c is the third outside label, the union is contained in
{0}∪B_c, of cardinality at most two. At least one of the three shifts is
outside that union; it makes every label closed-safe at once. Repeated speed
values do not alter the argument: all cardinality assertions concern labels.

If instead an outside anchor r has phase 1/6, 1/2, or 5/6, its phase under
any third shift is still an odd-sixth residue. Therefore it forbids no shift.
The two other outside labels are handled by the existing at-most-two family
theorem, using one k for both. Divisible labels and the anchor are safe for
that same k. The set includes its endpoints: 1/6 and 5/6 are good, not bad.

These rescues are conditional statements at arbitrary real t; they need no
positive-speed or positive-time premise. Under nonexistence their conclusions
contradict hno. Applying the existing at-most-two theorem directly to all three
outside labels would be invalid; the collision or anchor removes that obstacle.

### 3. Exact phase transport, including negative quantities

If d=6z+e with z,e integers and d a natural speed, and α,β are integers, then

    (α*t+β/6)*d
      = α*fract(t*d)+β*e/6 + (α*floor(t*d)+β*z).

The final parenthesis is an integer, so taking fractional parts proves exactly
the affine transport formula in the manuscript. This is valid for negative
t, e, α, and β. Signed representatives e=-1,-2 and shifts β=-1 must remain
integer/real operations; natural subtraction is inappropriate.

For the special-anchor transport to 5/6, write d=3u+c with c∈{1,2}, using
3∤d, and the initial phase as (2r+1)/6 with natural 0≤r<3.
Set k=((2-r)*c)%3. Here 2-r is a valid natural difference because r≤2.
Since c²≡1 modulo 3, k*d≡2-r modulo 3. Hence

    (2r+1)/6 + k*d/3 ≡ 5/6 modulo integers.

The residue k is in Fin 3 and gives the asserted exact anchor. This is a
symbolic inverse calculation over the prime modulus 3. No nonzero-composite-
residue-as-unit assumption appears. The rational-orbit lower-bound theorem
alone would not supply this fractional-part equality.

### 4. The global anchored maximum permits zero

For c>0, the set Fin c is nonempty. Candidate times

    t_j=(j.val+5/6)/c

lie strictly in (0,1): 0≤j<c implies 0<j+5/6<c. Each has anchor 5/6.
A maximum of the pair-norm minimum exists by finite linear-order maximization.
This remains valid when either or both of a,b are zero and makes no claim
that the attained maximum is positive.

For any real anchored time t, take s=fract t. Integer-time periodicity preserves
all natural-speed norms, and the anchor phase also agrees because t-s is an
integer. Now 0≤c*s<c and fract(c*s)=5/6, so n=floor(c*s) is an integer with
0≤n<c and c*s=n+5/6. Thus n defines an element of Fin c and s=t_n. The finite
maximum controls **all real anchored times**, including negative t. This is
a symbolic finite-existence proof, not an executed enumeration indexed by c.

For the selected pair p,q and outside anchor r, write M for that maximum.
The special-anchor rescue forbids M≥1/6; norm nonnegativity gives M≥0.
If M=0, every anchored minimum is bounded above by zero and below by zero.
If M>0, exchange the two labels so a=N(τ*v_p)=M≤b=N(τ*v_q).
This exchange preserves the symmetric pair hypotheses, including the disjunction
6∣v_p or 6∣v_q. It does not choose orientations for their fractional parts.

### 5. Folded identities and the two integer bands

For every real x, write x=z+r with r=fract x∈[0,1). If r≤1/2 then
N(x)=r and x=z+N(x). If r≥1/2 then N(x)=1-r and x=(z+1)-N(x).
Equality at r=1/2 is harmless. Thus x has an integer lift with either sign
of its norm.

For n natural and β integer, integer periodicity and this lift give

    N(n*x+β/2)=N(n*N(x)+β/2).

For a negative lift, first negate the phase and then add the integer β;
that changes n*N(x)-β/2 into n*N(x)+β/2. This works also for n=0, negative
x, and negative β. It does not extend this proof to an arbitrary rational
shift. The same folding gives N(x+1/2)=1/2-N(x), including N(x)=0 or 1/2.

Suppose 0<a<1/6. Then N(3a)=3a>a. Also 0<5a<1 and both 5a>a and
1-5a>a, so N(5a)=min(5a,1-5a)>a. At 3τ and 5τ the outside anchor is,
respectively, 1/2 and 1/6. Transport each by a third shift back to the
5/6 fiber; the pair norms are preserved. If N(3b)>a, both pair norms there
would exceed M=a, contrary to maximality. Hence N(3b)≤a, and likewise
N(5b)≤a. Norm bounds give a≤b≤1/2.

To audit the scalar contract, let z=round(3b). Then |3b-z|≤a.
Since b≥a>0 and a<1/6, the integer z lies strictly between -1 and 2, hence
is 0 or 1. If z=0 then 3b≤a contradicts 3b≥3a>a. Therefore z=1 and

    1-a≤3b≤1+a,
    5/18<b<7/18.

Put z'=round(5b). The last bounds imply 25/18<5b<35/18.
Together with |5b-z'|≤a<1/6, they place z' strictly between 1 and 3,
so z'=2. Thus 2-a≤5b≤2+a and b>11/30. Finally

    3*(2-a)≤15b≤5*(1+a)

gives 1≤8a. This proves exactly 1/8≤a and the two strict b bounds.
The strict inequalities came from a<1/6, not from unjustified rounding
tie rules. The lower endpoint a=1/8 remains allowed.

The complete band list is correct:

| Expression | Range implied by the scalar hypotheses | Safe integer band |
| --- | --- | --- |
| 2a | [1/4,1/3) | [1/6,5/6] |
| 3a | [3/8,1/2) | [1/6,5/6] |
| 4a | [1/2,2/3) | [1/6,5/6] |
| a+1/2 | [5/8,2/3) | [1/6,5/6] |
| 2a+1/2 | [3/4,5/6) | [1/6,5/6] |
| b | (11/30,7/18) | [1/6,5/6] |
| 2b | (11/15,7/9) | [1/6,5/6] |
| 4b | (22/15,14/9) | [7/6,11/6] |
| 2b+1/2 | (37/30,23/18) | [7/6,11/6] |
| 3b+1/2 | (8/5,5/3) | [7/6,11/6] |

Every displayed range lies inside the open interior of its safe band, so even
strict safety follows; the proposed assembly needs only the closed inequality.
The folded identity transfers these bounds to arbitrary orientations of the
actual pair phases.

### 6. Every residue row

Let x=τ*v_p and y=τ*v_q, oriented only by N(x)=a≤N(y)=b.
Both pair residues modulo 6 belong to {0,3}, and hsix rules out (3,3).
The outside anchor has signed residue e_r∈{1,-1,2,-2}. Let σ∈{1,-1}
denote its sign; then σ*e_r is 1 or 2. The integer transport gives these
complete possibilities:

| Pair residues | e_r | Time | Anchor arithmetic before fractional part | Pair phases modulo integers |
| --- | --- | --- | --- | --- |
| (0,0) | σ | 2τ+σ/6 | 10/6+1/6=11/6 | 2x, 2y |
| (0,3) | σ | 2τ+σ/6 | 11/6 | 2x, 2y+1/2 |
| (0,3) | 2σ | 3τ+σ/6 | 15/6+2/6=17/6 | 3x, 3y+1/2 |
| (3,0) | σ | 2τ+σ/6 | 11/6 | 2x+1/2, 2y |
| (3,0) | 2σ | τ+σ/6 | 5/6+2/6=7/6 | x+1/2, y |

For pair residue 3, the actual added half is σ/2, which differs from +1/2
by an integer when σ=-1. Thus both signs in every row give exactly the
listed norm calculation. All pair expressions occur in the safe-band table.
The first four rows have anchor 5/6 and the last has anchor 1/6. Both are
covered directly by special-anchor rescue; no reflection of the final row's
time is necessary. A possibly negative displayed time also causes no problem
because hno excludes witnesses at every real time.

The only omitted residue combination from this table is the explicitly handled
case (0,0) with e_r=±2. Therefore the table plus the next paragraph is exhaustive,
without assuming which member of the norm-ordered pair is divisible by six.

### 7. Both pair speeds divisible by six and even anchor

The pair and r are three distinct even labels. Since the even-label count is
at most three, the remaining labels u,w are both odd. Repeated speeds cannot
invalidate this count, since it is a count of labels.

At t₁=2τ and t₂=2τ+1/2, p,q have norms N(2x),N(2y), and r has phase 2/3.
All three are safe at both times; adding half a time changes their phases by
integers. Nonexistence chooses a bad outside label at t₁, say u. Oddness gives
N(t₂*v_u)=1/2-N(t₁*v_u)>1/3, so u is safe at t₂. Hence w must be bad at t₂.

If N(z)<1/6, folded doubling gives
N(2z+1/2)=N(2N(z)+1/2)>1/6, since 1/2≤2N(z)+1/2<5/6.
At s=4τ+1/2, for u take z=t₁*v_u. Its phase is 2z+v_u/2, congruent to
2z+1/2. For w take z=t₂*v_w. Its phase is 2z-v_w/2, also congruent to
2z+1/2; the difference is an integer because v_w is odd.
Thus both u,w are safe at s using their respective earlier badness facts.

At the same s, the pair has norms N(4x),N(4y), and the even anchor has phase
1/3. These are safe by the band table. This is a full W(s), a contradiction.
It does not transport an unsupported earlier safety claim forward in time.

All possible residues contradict M>0. Therefore M=0, and for every real time
in the 5/6 fiber the pair minimum equals zero by its nonnegativity and global
maximal bound. This proves the exact boundary-minimum contract.

### 8. Negative boundary time and the two-choice divisibility cover

Fix any outside label r and use t=-1/(6*v_r). Positivity makes the denominator
nonzero, and t*v_r=-1/6 has fractional part 5/6, so the boundary theorem applies.
A zero minimum of two nonnegative norms makes at least one norm zero.
Negation symmetry converts that statement to
N(v_p/(6*v_r))=0 or N(v_q/(6*v_r))=0.

For any natural Q>0 and A, N(A/Q)=0 implies Q∣A. Indeed Q∤A would yield
cyclicResidueDistance Q A≥1 and hence N(A/Q)≥1/Q>0 by the inspected
small-denominator/residue APIs. This helper works even for A=0; in its
application A is positive. We obtain, for each of the three outside labels r,

    6*v_r ∣ v_p  or  6*v_r ∣ v_q.

Choose one of the two options for each label (when both hold, choose either).
A map from three distinct labels to two choices is not injective. Thus two
distinct outside labels u,w divide the same selected pair speed after the
factor six. Call that pair speed A, the other B, and the third outside speed C.
This yields 6*v_u∣A, 6*v_w∣A, and 6*C∣A or 6*C∣B.
There is no requirement that the three outside speed values be distinct.

### 9. Both fast-ratio implications and the final two times

Positive divisibility gives v_u,v_w≤A/6. If 6*C∣A then C≤A/6; if
6*C∣B then C≤B/6.

Suppose A≥5B. It is already at least five times B. For u,w,
5*v_u,5*v_w≤5A/6≤A. If C≤A/6 the same bound applies to C;
if C≤B/6 then 5C≤5B/6≤A. Hence A satisfies the full fast-speed
hypothesis and contradicts hno.

Suppose B≥5A. It is at least five times A. Also
5*v_u,5*v_w≤5A/6≤B. If C≤A/6 then 5C≤5A/6≤B;
if C≤B/6 then 5C≤5B/6≤B. So B also gives a contradiction.
The closed fast condition excludes equality in each ratio and proves

    A<5B  and  B<5A.

At t₀=1/(6A)>0, A's phase is 1/6, and u,w have real phases in
(0,1/36], hence are both strictly bad. If B is safe, collision rescue supplies
a full witness. Otherwise put θ=B/(6A). The ratios imply
1/30<θ<5/6; in particular there is no wrap in this phase.
Since 1-θ>1/6, N(θ)<1/6 forces θ<1/6.

At s=5/(6A)=5t₀, A's phase is 5/6. The phase of B is 5θ∈(1/6,5/6),
also without wrap. The phases of u,w lie in (0,5/36], still strictly below
1/6. Collision rescue again applies. No condition is imposed on the phase
of C; the common shift handles it.

This establishes the contradiction using only the divisor cover, the two
rescue helpers, and the lower-count fast-speed adapter. It does not use the
target exactly-two theorem inside its own proof.

### 10. Divisor facts, gcd removal, and the at-least-two wrapper

For the primitive elimination contract, apply the existing divisor-count
theorems under hpos, hprimitive, and all-real hno. The lower bound at ℓ=6
supplies a six-divisible label; the exact three-divisibility characterization
puts it in {p,q}. The upper bound at ℓ=2 supplies heven≤3.
These are the only two count facts the reconstructed boundary proof needs.
Extract p,q using the exactly-two filter cardinality; their complement has
three labels. No denominator-4 or denominator-5 branch is imported.

For the nonprimitive exactly-two adapter, let g=univ.gcd v.
A positive input proves g≠0 using `gcd_ne_zero_iff`, so g>0. Each g divides
v_i, hence v_i=g*(v_i/g). If w_i=v_i/g were zero, this equation would
contradict v_i>0; thus every w_i is positive.
`Finset.gcd_div_eq_one` requires a nonzero input in the finite set, which is
provided by any Fin 5 label and hpos. It yields gcd w=1.

An outside label exists because the count is two. Since g divides that speed,
3∣g is impossible. Primality of 3 then gives
3∣v_i iff 3∣w_i from v_i=g*w_i, so the count stays exactly two.
Classical contradiction applies the primitive elimination to w and yields a
real witness. It is nonzero and can be reflected positive. Dividing its time
by g gives a positive witness for v, with exact phase equality from
`circleNorm_div_time_mul_scale`. No sorted normalization, translation, or
injectivity premise is needed.

For primitive at least two, the count is either exactly two or at least three.
Use the new exactly-two adapter in the first case and the separately reviewed
primitive at-least-three theorem in the second. Gcd one rules out five
three-divisible labels. The exactly-two inner proof does not invoke that
at-least-three theorem. There is no circular all-five-divisible reduction.
An unqualified at-least-two theorem would include every tuple after scaling
all five speeds by three and must not be inferred from this wrapper.

## Implementation priorities and remaining API obligations

The fast-speed adapter is the smallest independent implementation milestone:
its only new work is Fin 4 reindexing, natural-to-real casts, and positive-time
reflection around the existing insertion theorem. Keep the weak ratio hypothesis
and closed conclusion exactly as stated.

The remaining contracts are implementation-ready mathematics, but still require
new proofs. A useful dependency order is:

1. Integer phase periodicity/transport, folded half-shift identities, and the
   two finite-label rescue statements. These are independent of the new maximum.
2. The finite fiber maximum and scalar folded-band theorem, followed by the
   ten explicit safe-band consequences.
3. Boundary minimum zero, including label exchange, the five residue rows,
   and the both-even complement argument.
4. Norm-zero divisibility, three-label/two-choice assignment, ratio exclusions,
   and the final rational-time contradiction.
5. Primitive divisor-count supply and the count/gcd wrappers.

To make the missing obligations exact, the following are proposed helper
contracts in mathematical notation, not claims about existing Lean declarations:

- **Collision rescue:** natural v:Fin 5→ℕ; p≠q with
  ∀i, 3∣v_i iff i=p or i=q; arbitrary real t; p,q closed-safe; distinct
  u,w with N(t*v_u),N(t*v_w)<1/6. Conclusion:
  ∃k:Fin 3, ∀i, N((t+k.val/3)*v_i)≥1/6. Positivity is unnecessary;
  the badness premises imply u,w are outside the pair.
- **Anchor rescue:** the same pair characterization and safe pair, plus
  r≠p,q and X_r(t)∈{1/6,1/2,5/6}. The conclusion is the same common k.
- **Anchor transport:** d:ℕ with 3∤d, t:ℝ, X_d(t) in that three-point set.
  Conclusion: ∃k:Fin 3, fract((t+k.val/3)*d)=5/6.
- **Signed affine phase:** d:ℕ, z,e,α,β:ℤ, with (d:ℤ)=6z+e and t:ℝ.
  Conclusion:
  fract(((α:ℝ)*t+(β:ℝ)/6)*d)
  =fract((α:ℝ)*fract(t*d)+((β*e:ℤ):ℝ)/6).
- **Folded lift and half-shift:** for every real x, some z:ℤ satisfies
  x=z+N(x) or x=z-N(x); consequently for all n:ℕ and β:ℤ,
  N(n*x+β/2)=N(n*N(x)+β/2). Also N(x+1/2)=1/2-N(x).
  These identities have no sign hypothesis on x or β.
- **Norm-zero divisibility:** A,Q:ℕ, Q>0, N(A/Q)=0 ⇒ Q∣A.
  Do not infer a bound Q≤A until positivity of A is also known.

The current finite avoidance theorem has a **sum** bound. For collision rescue,
combine the two identical singleton constraints into one before applying that
API, or prove the direct union bound; a sum of three is not enough.
For the anchor rescue, apply the at-most-two family theorem to the subtype
excluding p,q,r. Prove its exact label cardinality rather than assuming two
distinct speed values.

The exact fractional-part normalization in the maximum needs an equality,
not only norm preservation. `Int.fract_eq_fract` has the required interface:
equality of fractional parts iff the difference is an integer. For c>0,
`Finset.exists_max_image` on univ:Finset(Fin c) provides the finite maximum.
The existing strict-seeded complement maximizer has a different domain and
cannot be substituted. Its `reciprocal_dilate_shift_improves` explicitly
assumes N∣d; setting N=6 for an odd multiple of three is invalid, including
when β=0. The folded scalar proof supplies the needed separate argument.

During implementation, keep arbitrary real t in the boundary theorem, signed
integers in transport, nonempty-fiber proof from c>0, weak a≥1/8, strict badness,
the two distinct bad-label witnesses, and the count-two assumption through gcd
division. None of these obligations can be removed merely to ease elaboration.

## Read-only API and static provenance receipts

Current config, workflow, policy, and focused state were read. The state records
research/in_progress and this bounded review at the assigned checkpoint.
The actual command `python3 scripts/validate_workflow.py` exited 0; its full
stdout was:

```text
workflow structural validation passed; it cannot certify mathematical validity.
```

The manuscript binding command `sha256sum research/astra-two-divisible-three-reduction-plan.md`
and `wc -l -c` exited 0 and returned the SHA above, 482 lines, 27605 bytes.
Static Python extraction checked all 23 source-binding rows already present in
the manuscript against current file bytes and found no mismatch. This is file
integrity bookkeeping only, not a mathematical execution.

Focused API declarations/proofs were read in FastRunnerInsertion,
FiveRunnerOrdinary, StructuredClasses, PivotBoundary, ConstrainedMaximizer,
RationalShiftOrbits, ThirdShiftExceptions, ModularCertificates,
SixTotalDivisorCounts, SmallDenominatorWitness, PivotResidues, Normalization,
ThreeDivisibleRunners, and the four listed mathlib source files below.
This does not claim a fresh full audit of every bound source file.

Verified manuscript bindings:

```text
dda82d1f8830d961499292656c3dfac884a471ad5ef38bd925b1a25c403603a5  LonelyRunner/FastRunnerInsertion.lean
662d0116f13971bce85e76c503e2f3be4fdc6291ba8113aeda43957e38354ffe  LonelyRunner/FiveRunnerOrdinary.lean
5328a7a88d2b42f86ffc3f0f0418ca22c761219e8fa3e5822bda5a18ac286e8c  LonelyRunner/StructuredClasses.lean
0e56cab74d30ef8b537ed4ec24503aae875bd8aadc369d26da99ba882cc3603f  LonelyRunner/PivotBoundary.lean
2ef07e6b83b8675a22184571c31d2a71dab9d5c072e3cd165cb8382957b46e92  LonelyRunner/ConstrainedMaximizer.lean
cf615dd6c6b3cf091cd5d31ac641f4f994c1c50d95e0120c311d3ac129b88591  LonelyRunner/RationalShiftOrbits.lean
6e9d1e3e084188a651e4c875cf36fd5d6fc7cbd5f1914784019a207a0cec01f4  LonelyRunner/RationalShiftGcd.lean
6ab6e77e8f5edcdc2a2d242fb2616327004b376496616f46896303a06876db23  LonelyRunner/RationalShiftInsertion.lean
0b62ef724eb8c24db4085e247e9f16f650ec450291c7ccac2b0ad0981f148727  LonelyRunner/SixTotalDivisorCounts.lean
1570a359100594f4a5589588e3b32674dc2d54d60e500df1d47aca64c2faf95f  LonelyRunner/SmallDenominatorWitness.lean
362da5ab923f22e900ae7ac821dd4cf4aab91dfe70889987bc9e5a05d19c276a  LonelyRunner/PivotResidues.lean
28c5db2425eef754156e57c284959ff02da743f1fde424e053c4eae0c721b6bd  LonelyRunner/SeparatedPhaseFamily.lean
146cdfd80495aced0eb93bc322559cf7e950a80b0d01534b2a57cce7129debaa  LonelyRunner/ThirdShiftSpacing.lean
85590988cd0e104dc93fd51bc79aa326fe2799974eae426b7ea3336853872073  LonelyRunner/ThirdShiftExceptions.lean
8b7e9dc5be1236acb812607c19454fe43ecd1333145aef675e7df8e6d0c3871c  LonelyRunner/ModularCertificates.lean
20193ad984f308ce8512930fe683d3118a2b3b5c18636a6a1f4454aa6df43797  LonelyRunner/Normalization.lean
cac3351bf8c755c0bd354d0330e766f49c255d7ef21637d0975a8d8633cd94b0  LonelyRunner/PrimitiveTupleNormalization.lean
1ceac85438299dffdd48d57fb0052b598a9bd5eda995cabff0256885529d89cb  LonelyRunner/RenaultPhaseLemma.lean
87c674ba5464c7868fb3e253e58a695821bf8841bb4e076bac5d570236dc6229  .lake/packages/mathlib/Mathlib/Data/Finset/Card.lean
6a67c04a5ad263999707cf927121c15edf11bd66f7b5b48652c0e0e660a0d58c  .lake/packages/mathlib/Mathlib/Data/Finset/Max.lean
11f61aaf83c406b6b0accc6d34bdb4f77a1566fbdc63eae4d704728b9acf038c  .lake/packages/mathlib/Mathlib/Algebra/Order/Floor/Ring.lean
e0e320bd1f4a5a9e79da9fde6e2e3691ebbbccea8a4fba5765bda3b56e715568  .lake/packages/mathlib/Mathlib/Algebra/GCDMonoid/Finset.lean
981748f0e5377735fdd43c3109c7011b33ea7a0d75272e9e371aedb443229eb9  research/astra-three-divisible-shift-plan-review.md
```

Additional current bindings:

```text
614dc7bbf75143da6960d74b3eef5427ef93c9c8b3cbe51ec5cd5c6ca47376a3  LonelyRunner/ThreeDivisibleRunners.lean
3dc34b10715809b31568b128d146f6bfaaf7df8a745493d361643fadda999439  research/astra-third-shift-source-review.md
8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af  lean-toolchain
887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218  lake-manifest.json
```

The exact raw stdout of the successful static binding check was:

```json
{
  "scope": "static source binding only; no mathematical execution",
  "plan_bytes": 27605,
  "plan_sha256": "07f27873785c463d7f9b2e8c2074510f42fcd973d07cc6e73ea62e5b3bac0ad6",
  "manuscript_source_bindings_checked": 23,
  "mismatches": [],
  "additional_bindings": {
    "LonelyRunner/ThreeDivisibleRunners.lean": "614dc7bbf75143da6960d74b3eef5427ef93c9c8b3cbe51ec5cd5c6ca47376a3",
    "research/astra-third-shift-source-review.md": "3dc34b10715809b31568b128d146f6bfaaf7df8a745493d361643fadda999439",
    "lean-toolchain": "8e3538e0ab5f81a3ee04927d8838c8c674e0e112838b4b3ce87ec218143276af",
    "lake-manifest.json": "887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218"
  }
}
```

Source bindings and exact-contract extraction may be reproduced without Lean:

```bash
python3 -I - <<'PY'
from pathlib import Path
import hashlib
import re

p = Path('research/astra-two-divisible-three-reduction-plan.md')
raw = p.read_bytes()
assert hashlib.sha256(raw).hexdigest() == '07f27873785c463d7f9b2e8c2074510f42fcd973d07cc6e73ea62e5b3bac0ad6'
s = raw.decode('utf-8')
rows = re.findall(r'^([0-9a-f]{64})  (.+)$', s, re.M)
assert len(rows) == 23
for expected, path in rows:
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
blocks = re.findall(r'```lean\n([\s\S]*?)\n```', s)
new_blocks = [b for b in blocks if not b.startswith('theorem fastRunnerInsertion ')]
assert len(new_blocks) == 6
assert sum(b.count('theorem ') for b in new_blocks) == 7
print('23 source bindings and seven extracted manuscript contracts match.')
PY
```

That final concise replay snippet is a supplied static receipt recipe; its
specific stdout is not claimed as a separately executed result in this review.
The actual earlier binding check and extraction counts are recorded above.
No proof probe, arithmetic fixture, search, or build was attempted, so there
is no Lean output or axiom audit for the seven proposed declarations.

Acceptance is restricted to this manuscript's exactly-two and primitive
at-least-two branch and its named helpers. Later kernel verification and
integration are still required. This report proves no canonical six-total
theorem, supplies no unrestricted five-moving sixth-margin theorem, and does
not close H8 or the unrestricted Lonely Runner goal.

