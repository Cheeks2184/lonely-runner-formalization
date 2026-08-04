---
owner: GPT-5.6 Sol High top-level desktop orchestrator
supervising_authority: /root
launch_runtime: original browser-capable desktop Codex session
role: Research Pipeline/Specification Lead - prompt preparation only
task_id: PIPE-P70-RESPEC-123
---

# Prompt 70: SIMULTANEOUS-FULL-COVER-COMMON-PRIME

This is one isolated unrestricted Sol Pro research contract. Prove or decisively
refute the exact cross-pivot arithmetic-rigidity lemma below. The intended new
structure is a common prime forced by the simultaneous existence of complete
arithmetic bad-set covers at **every** pivot. Seek it through canonical minimal
covers and multiplicity constraints, or through exact Fourier annihilation at
the separate pivot moduli.

This route is distinct from Prompt68 cofinite prime forcing: do not choose an
auxiliary prime modulus or use eventual good-prime supply. It is also distinct
from Prompt69 uncrossing/exchange and from Prompt66 packing, radial descent, and
signed phase cells. Do not reopen top-two, owner-shift, Gamma matching, height
compression, first-blocker descent, or coefficient-bounded searches.

This file is a prepared contract only. It is not a launch record, response,
proof, computation, or status promotion. Only GPT-5.6 Sol High under `/root`
may launch the Pro turn. Do not delegate research to Luna.

Use the labels `proved-lean`, `proved-math`, `computed finite evidence`,
`conditional`, `conjectural`, `rejected`, and `open` literally. The response
may recommend a disposition but may not promote its own claims before
independent audit.

## Existing exact boundary

The repository has these `proved-lean` equivalences:

```text
exists_witness_iff_exists_pivot_certificate
positiveIntegerConjecture_iff_pivotCertificateConjecture
conjecture_iff_positiveIntegerConjecture
```

They reduce a fixed positive integer tuple to existence of one canonical pivot
residue outside all strict nonpivot bad sets, and reduce real LRC to the
positive-integer formulation. They do not prove that a certificate exists.

`PART-12` is only `proved-math`: the normalized candidate-filter transform,
strict Dirichlet kernel, gcd-supported multiplication pullback, and actual
bad-set convolution are audited in `docs/fourier-pivot-badsets.md`. They are
not Lean-formalized and do not give a uniform certificate. Factorwise absolute
main-term domination is refuted, including on tuples with certificates.

The former Prompt70 target `U(a) >= n` is **rejected**. At `n=6`, `N=7`, the
primitive tuple `(1,2,3,4,5,7)` has pivot uncovered counts
`(0,0,0,0,2,2)`, hence `U=4<6`. Do not repair that target by silently changing
it to `U>0`, `U>=1`, `U>=2`, a reflection-parity statement, or any expression
definitionally equivalent to existence of a pivot certificate.

## Frozen definitions and boundary conventions

Let `n : Nat` satisfy `1 <= n`, put `N=n+1`, and let

```text
a : Fin n -> Nat
```

be positive and injective. Original speeds are distinct positive naturals.
Reductions modulo a pivot need not be distinct; repeated residues, coincident
bad sets, nonunits, and every gcd degeneracy remain in scope.

For `j : Fin n`, define

```text
p_j = a_j,
M_j = N*p_j,
rho_M(x) = min(x mod M, M-(x mod M)),
R_j = {r : Fin M_j | N does not divide r.val},
B_i^j = {r : R_j | rho_(M_j)(r.val*a_i) < p_j}  (i != j),
mu_j(r) = #{i : Fin n | i != j and r in B_i^j},
G_j(a) = #{r : R_j | mu_j(r)=0}.
```

The strict inequality `<p_j` is bad; equality is safe. Never replace cyclic
distance by a one-sided interval. The pivot coordinate is safe because
`N` does not divide the candidate numerator. Every representative satisfies
`0 <= r.val < M_j`, and `|R_j|=n*p_j`.

Write

```text
FullCover_j(a) :<=> G_j(a)=0
                 :<=> union_(i!=j) B_i^j = R_j.
```

Prove the displayed equivalence before using it. The cover is owner-indexed:
coincident sets retain both owners. Reflection `r |-> -r` has fixed points
which must be handled without doubling. Pivot groups have different moduli;
there is no implicit identification of their residues or characters.

For the finite nonempty family of speeds, let `gcdAll(a)` denote their natural
gcd. Any use of a primitive tuple must define division coordinatewise, prove
positivity and injectivity, and prove gcd one. Do not assume exact per-pivot
count scaling. If witness scaling is used, state its time direction exactly.

## Sole unrestricted structural lemma

There is exactly one permitted unresolved bridge:

```text
SIMULTANEOUS-FULL-COVER-COMMON-PRIME:

For every n : Nat with 1 <= n and every positive injective
a : Fin n -> Nat, if FullCover_j(a) holds for every pivot j, then

  there exists a natural prime q such that, for every i : Fin n,
  q divides a_i.
```

Equivalently, simultaneous complete arithmetic covers force
`1 < gcdAll(a)`, but the prime conclusion is the frozen target. This is not a
restatement of an uncovered residue: a valid proof must construct a common
prime from cross-pivot cover arithmetic. It is a stronger structural
consequence than the existing existential equivalence and a narrower
integer-cover rigidity problem than unrestricted real LRC.

Do not replace the conclusion by an existential chosen from the unknown good
set, by `not (forall j, FullCover_j(a))`, or by any formula which expands
definitionally to `exists j, G_j(a)>0`. Do not use LRC or either direction of
the pivot equivalence to declare the antecedent impossible. Such arguments are
tautological and receive `STOP`.

## Complete implication chain to unrestricted LRC

Prove every arrow, with exact quantifiers.

Assume a positive injective integer tuple has no pivot certificate. The exact
pivot definitions give `FullCover_j(a)` for every `j`. Normalize by
`d=gcdAll(a)>0` and put `b_i=a_i/d`. Prove that `b` is positive, injective,
and primitive.

Prove that lack of a certificate descends from `a` to `b` without assuming a
false cardinal scaling formula. Contrapositively, a real witness `t` for `b`
gives the same phases for `a=d*b` at time `t/d`; then use the fixed-instance
pivot equivalence in the correct direction. Thus every pivot cover is also
complete for `b`.

Apply `SIMULTANEOUS-FULL-COVER-COMMON-PRIME` to `b`. Its prime `q` divides all
`b_i`, contradicting `gcdAll(b)=1`. Therefore some integer pivot certificate
exists. Finish through

```text
PositiveIntegerPivotCertificateConjecture
  -> PositiveIntegerConjecture
  -> Conjecture
```

using the two `proved-lean` equivalences at their correct directions and the
same runner indexing and closed boundary. This normalization/descent wrapper
must be proved; it is not part of the sole open lemma.

## Attack A: canonical minimal covers and prime propagation

Under the simultaneous-full-cover hypothesis, for every pivot choose a
canonical inclusion-minimal owner subset `C_j` by a declared total ordering.
For every owner in `C_j`, prove existence of a private candidate covered by
that owner and by no other owner in `C_j`. Multiple minimal subcovers and
coincident full bad sets must be handled by the canonical choice, not ignored.

Translate private-point membership and nonmembership into exact cyclic
congruence inequalities. Seek a prime divisor forced to propagate through the
owner-pivot incidence digraph until it divides every speed. Any propagation
step must specify:

1. its pivot and owner hypotheses;
2. the exact gcd or divisibility conclusion;
3. why strict-boundary equality does not enter the bad arc;
4. how nonunits and modular collisions are retained; and
5. why the prime is the same across different pivot moduli.

A general-hypergraph private-point theorem, an owner exchange, or a locally
minimal cover with no arithmetic propagation is insufficient. Do not import
Prompt69 uncrossing under different notation. Finish with the common prime or
identify the first unsupported propagation arrow.

## Attack B: separate-modulus Fourier annihilation and gcd support

For each pivot separately define the candidate indicator `c_j`, the strict
raw arc pullbacks `g_ij`, actual bad indicators `beta_ij=c_j*g_ij`, and

```text
h_j(r)=c_j(r)*product_(i!=j)(1-g_ij(r)).
```

Prove `FullCover_j(a)` iff `h_j` is identically zero. Derive the complete
Fourier convolution identity on `Z/M_j Z` using one normalized sign convention
and recheck every hypothesis of the audited transforms, including `N=2`,
`M'=1`, nonunit speeds, and the candidate filter.

Seek a non-tautological consequence of simultaneous spectral annihilation:
for example, a prime appearing in the gcd-supported frequency constraints for
one pivot which exact cross-pivot arithmetic forces into every speed. If using
a common auxiliary modulus, define each pullback and fiber size and prove
preservation; do not average characters from different groups directly.

The zero Fourier coefficient of `h_j`, inclusion-exclusion for `G_j`, or
positivity of the exact good-count coefficient merely restates the cover.
Factorwise absolute domination is already refuted. A valid attack ends at the
common prime conclusion or records the first unsupported cross-pivot spectral
arrow.

## Mandatory non-tautology and falsification suite

Recompute these fixtures before trusting either attack.

1. `n=1`, `(1)`: `G=(1)`; the full-cover antecedent is false.
2. `n=2`, `(1,3)`: `G=(0,2)`; one complete pivot does not suffice.
3. `(1,2,3)`: `G=(2,2,2)` with equality `rho=3` safe at pivot speed `3`.
4. `(4,5,9)`: `G=(2,2,4)` although absolute main-term domination fails at
   every pivot.
5. `(1,2,3,5)`: `G=(0,0,2,2)`; two complete pivots do not force a common
   divisor.
6. The rejected-mass obstruction `(1,2,3,4,5,7)` has `n=6`, `N=7`,
   `G=(0,0,0,0,2,2)`, and gcd one. At pivot speed `5` the good residues are
   `{6,29}` modulo `35`; at speed `7` they are `{8,41}` modulo `49`; speeds
   `1,2,3,4` have complete covers. Thus even `n-2` complete pivots do not force
   the target prime.
7. `(1,3,5)`: classify every all-odd half-time fixed point without doubling.
8. `(1,3,13)` at pivot speed `3`: the other speeds coincide modulo `12`;
   retain both owners.
9. Scaling pairs `(1,2,3)/(2,4,6)` and the six-speed obstruction and its
   double: check witness/certificate scaling direction without inferring the
   target from a premise-violating tuple.
10. Test `r=0`, candidate exclusion `N|r`, `rho=p_j-1`, equality `rho=p_j`,
    both cyclic representatives, and the `N=2` antipode. Permutations must
    relabel pivot counts and leave the full-cover conjunction invariant.

Before `BRIDGE`, expand the decisive argument back to finite bad sets and show
where the common prime is constructed. Explain why the proof requires all
pivots and why fixture 6 defeats majority-pivot weakenings. Reject any step
equivalent to assuming the desired uncovered residue or to taking a minimum
over an unknown good set.

## Fixed finite budget

Computation is optional and only for falsifying the target or an intermediate
claim. If used, permit one source file and one machine-readable output. Run the
ten fixtures first. Then enumerate primitive strictly increasing tuples for
`n=3,4,5,6`, largest speed at most `12`, ordered by `n` then lexicographically;
order pivots and residues naturally. Record every tuple satisfying all pivot
covers and stop at the first, because such a tuple refutes unrestricted LRC as
well as the lemma's conclusion. Also stop at the first counterexample to any
named intermediate necessary condition.

Declare language/version, command, exact domain, ordering, early-stop rule,
schema, and SHA-256 hashes. Every completed finite result is only
`computed finite evidence`. No bounded absence proves the lemma.

An optional Lean prototype may formalize at most one local wrapper whose
signature is frozen in the memo: either common-divisor normalization of a
hypothetical full-cover tuple, or the private-point lemma for a supplied
canonical minimal cover. It may not formalize the open common-prime lemma.
Claim `proved-lean` only after standalone compilation and an axiom audit.

## Disposition and stop rules

Return exactly one disposition.

- `BRIDGE`: the common-prime lemma is proved for every stated tuple and the
  complete normalization/descent chain is established. A different theorem
  qualifies only if it is precisely stated, genuinely cross-pivot and
  arithmetic, strictly stronger than noncoverage, and independently supplies
  the unrestricted certificate.
- `PIVOT`: a prime-independent, height-independent structural theorem is
  proved which materially narrows one exact arrow to the common-prime result,
  or an infinite family decisively refutes a named strengthening and identifies
  a genuinely narrower surviving lemma.
- `STOP`: the target is refuted; both attacks reduce to certificate counting;
  the common prime is inferred from the desired conclusion; a cross-pivot
  propagation step remains unsupported; only finite enumeration is obtained;
  or the response migrates to a forbidden route.

A finite counterexample with all pivots covered would be a candidate
counterexample to LRC and must be reported without promotion. A counterexample
to a stronger intermediate claim rejects only that claim. Finite success never
earns `PIVOT` or `BRIDGE`.

## One-turn budget and required output

Use one major Sol Pro turn. Spend it on both attacks and the single common-prime
lemma. No broad literature survey, second research target, or follow-up
question is permitted.

Return one self-contained memo with these sections, in order:

1. **Disposition** — exactly `STOP`, `PIVOT`, or `BRIDGE`.
2. **Status table** — one exact evidence label per claim and dependency.
3. **Exact target** — all definitions, quantifiers, and strict boundaries.
4. **Regression and non-tautology audit** — including the six-speed rejected
   mass obstruction and the first genuinely new implication.
5. **Attack A** — canonical minimal covers and exact prime propagation, or the
   first fatal arrow.
6. **Attack B** — exact Fourier annihilation and cross-pivot gcd support, or
   the first fatal arrow.
7. **Falsification** — mandatory fixtures and any bounded scan.
8. **Complete implication chain** — primitive normalization through real LRC.
9. **Artifacts and replay** — only if an optional artifact was created.
10. **Final boundary** — proved, computed, conditional, rejected, and open
    claims, without response self-promotion.

Do not substitute a progress narrative. The sole goal is the exact
simultaneous-full-cover common-prime lemma, its decisive refutation, or one
rigorously proved structural partial theorem under these disposition rules.
