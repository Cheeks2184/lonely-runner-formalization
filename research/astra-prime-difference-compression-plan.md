# General-prime compression from unequal difference levels

Status: complete author manuscript proof and proposed exact Lean contracts;
independent review and kernel implementation remain outstanding. This document
does not establish another runner count or the unrestricted conjecture.

Source checkpoint: `312158239315a3488cb522695b58c0a2fece7621`.
Owned file: this report only. No Lean, workflow-state, Git, dependency-cache, or
build changes were made. The project workflow validator passed on task entry.
No enumeration, candidate search, computational arithmetic control, or Lean
execution was performed. The numerical examples below are explicit manuscript
derivations, not reported test runs.

## Source and the finite-modulus issue

Barajas and Serra define the top digit modulo a prime power and use successive
prime-level multipliers in Lemma 2. Their Lemma 9(i) compresses three congruent
units when the two anchored differences have unequal valuations; its argument
sets both difference digits to six and invokes Remark 8(i). See the primary
[publisher PDF, pp. 3–4 and 10–11](https://www.combinatorics.org/ojs/index.php/eljc/article/download/v15i1r48/pdf).

Two details require explicit treatment in an exact finite-modulus contract.
A difference divisible by the modulus always has digit zero. Also, a difference
with residue `6R` has digit six but its negative has digit one. Thus setting
the two digits to six does not by itself prove the displayed all-ordered-
differences premise in that proof. The compression conclusion survives: use
signed lifts in the closed interval `[-R, 0]` instead. At the top level, forcing
digit six through Lemma 2 excludes only the other *nonzero* digits; zero cannot
occur for a noncollapsed top-level difference under a unit multiplier.

Everything below is a separately derived elementary proof for general prime
`p`, including the collapsed and endpoint cases. No unproved form of Remark 8
is used.

## Exact conventions and main conclusion

Let `p` be any prime, `m ≥ 0`, `R = p^m`, and `P = p^(m+1) = pR`.
For an integer `z`, write

* `res(z)` for its representative in `{0, ..., P-1}`;
* `q(z) = floor(z/R) mod p`, with Euclidean remainder in `{0, ..., p-1}`.

Then `q(z) = res(z) / R` using natural division. This follows by writing
`z = Pn + res(z)` and dividing by `R`; it holds also for negative `z`.

A set of digits has cyclic consecutive length at most two when it is contained
in `{a, (a+1) mod p}` for some `0 ≤ a < p`. Length counts residues, not steps.
In particular, `{p-1, 0}` is such a set. Repeated inputs are allowed.

For arbitrary integers `b0, b1, c`, put `x = res(b0-c)` and
`y = res(b1-c)`. Call a difference **collapsed** exactly when its representative
is zero. A noncollapsed representative `d` has a decomposition

`d = p^h u`, with `0 ≤ h ≤ m`, `u > 0`, and `p` not dividing `u`.

**Theorem C (triple compression).** Suppose either `x = 0`, or `y = 0`, or the
two noncollapsed representatives have different exponents in these
decompositions. There is a natural multiplier `lambda` with

`0 < lambda < P` and `p` not dividing `lambda`

such that, writing `t = q(lambda*c)`,

`q(lambda*b0), q(lambda*b1), q(lambda*c)` all belong to
`{(t+p-1) mod p, t}`.

This is the requested cyclic consecutive length at most two, with an explicit
choice of arc tied to the anchor. Neither unit hypotheses on the `b` values,
equality of their residues modulo `p`, distinctness of the inputs, nor `m > 1`
is needed. Primality is used to invert a nonzero coefficient modulo `p`.
The same proof works for an integer base at least two if each noncollapsed
unit coefficient is assumed coprime to that base instead.

The level-separation condition is sufficient, not claimed necessary. It cannot
simply be deleted: a concrete same-level obstruction is given below.

## Proof of independent digit control

The following stronger arithmetic fact is convenient and reusable.

**Theorem F (two distinct levels, prescribed digits).** Let

`x = p^a u`, `y = p^b v`, `a,b ≤ m`, `a ≠ b`,

where `p` divides neither `u` nor `v`. Let targets `tx,ty` satisfy
`0 ≤ tx,ty < p`. Require `tx ≠ 0` if `a = m` and `ty ≠ 0` if `b = m`.
There is a natural unit representative `0 < lambda < P` with

`q(lambda*x) = tx` and `q(lambda*y) = ty`.

The inputs in this theorem need not already lie below `P`. For a single live
difference the corresponding one-target statement also holds. The top-level
nonzero-target requirement is necessary, because a unit multiple of `p^m u`
has a nonzero top digit.

Here is a complete construction. For `j < m`, define

`H_j(k) = 1 + k p^(m-j)`, with `0 ≤ k < p`.

Every such correction is positive and congruent to one modulo `p`. If
`d = p^j w` and `A` is a positive unit, then the integer identity

`H_j(k) A d = A d + k R A w`

gives

`q(H_j(k) A d) = (q(A d) + k (A w mod p)) mod p`.       (1)

The coefficient `A w mod p` is nonzero. Consequently each target digit has
exactly one solution `k mod p`, obtained by multiplication by its inverse in
`Z/pZ`. This is an algebraic choice, not an enumeration.

If instead `d = p^ell w` with `ell > j`, the increment is divisible by `P`:

`H_j(k) A d - A d = k A w p^(m-j+ell)`,

and `m-j+ell ≥ m+1`. Thus the entire residue of every higher-level input is
preserved, not only its top digit.                                        (2)

After interchanging the named inputs if necessary, assume `a > b`.

1. If `a = m`, choose `J` in `{1,...,p-1}` satisfying
   `J u = tx (mod p)`. This exists because both `u` and `tx` are nonzero
   modulo `p`. Set `A = J`. Then `q(A x) = tx` exactly, since
   `A x = R A u`. If `a < m`, start with `A0 = 1` and use (1) to choose
   `ka` for target `tx`; set `A = H_a(ka)`.
2. Since `b < a ≤ m`, we have `b < m`. Apply (1) to `y = p^b v`, with its
   *current* coefficient `A v mod p`, and choose `kb` for target `ty`.
   Set `B = H_b(kb) A`. Equation (2) preserves the already achieved residue
   of `x`, while (1) gives the target for `y`.
3. Set `lambda = B mod P`. A positive unit modulo `p` cannot be zero modulo
   `P`, because `p` divides `P`. Thus `0 < lambda < P` and `p` does not divide
   `lambda`. Reduction preserves both product residues and hence both digits.

This proves F. The one-target version is precisely step 1 at the target's
level, followed by reduction. There is no use of `H_m(k)` as a unit
correction: `1+k` can be divisible by `p`, and the top level is instead
handled by the nonzero scalar `J`.

For compression take every live target to be `p-1`. This is always permitted,
including `p=2`. If both live levels are below `m`, the construction additionally
gives `lambda = 1 (mod p)`. More generally, an arbitrary positive unit seed
can replace `1` when all controlled levels are below `m`; the output retains
that seed's residue modulo `p`. When the largest controlled level is `h < m`,
all inputs divisible by `p^(h+1)` retain their entire product residues. These
refinements follow from (2) for every correction used.

## Proof of compression, with zero and boundary cases

**Lemma I (anchored interval).** Let `p ≥ 2`, `R > 0`, `P = pR`, and let `c`
and finitely many `bi` be integers. Suppose, for every `i`,

`res(bi-c) = 0` or `P-R ≤ res(bi-c) < P`.

Then all their top digits, including `q(c)`, belong to
`{(q(c)+p-1) mod p, q(c)}`.

For a zero representative choose the signed lift `si = 0`; otherwise choose
`si = res(bi-c)-P`. Each lift lies in the **closed** interval `[-R,0]`, and
`bi = c + si + P ni` for an integer `ni`. Put `Q = floor(c/R)`. From

`c-R ≤ c+si ≤ c`

we get

`Q-1 ≤ floor((c+si)/R) ≤ Q`.

Both endpoints are integral, so this quotient is either `Q-1` or `Q`.
Adding `P ni` changes the quotient by `p ni`, which vanishes modulo `p`.
This proves I, including equality `si = -R`, zero differences, arbitrary
negative anchors, and a cyclic wrap between digits `p-1` and zero.

Now prove C by exhaustive *logical* case division, not computation.

* If both differences collapse, take `lambda = 1`. The three product
  residues, hence their digits, agree. The anchor-predecessor conclusion
  follows immediately.
* If exactly one collapses, apply the one-target construction to the other,
  giving its digit `p-1`. The collapsed product remains zero modulo `P`
  under every multiplier.
* If neither collapses, use their unequal decomposition exponents and F
  with both targets `p-1`.

In either of the last two cases, a live transformed difference has residue
in `[P-R,P)`. A collapsed transformed difference has residue zero. Also
`lambda*(bi-c)` and `lambda*res(bi-c)` are congruent modulo `P`.
Apply I to the transformed inputs and anchor. This proves C.

For completeness, the finite decomposition used here has no valuation-at-zero
ambiguity. For `0 < d < P`, take the largest `h` for which `p^h` divides `d`
and let `u = d/p^h`. The unit part is positive and not divisible by `p`, by
maximality. If `h ≥ m+1`, then `d ≥ p^h ≥ P`, a contradiction. Hence `h ≤ m`.
Equivalently one may use `padicValNat p d` under the explicit `d ≠ 0` guard.

If a signed original difference `z` is nonzero with `nu_p(z) ≤ m`, reducing
modulo `P` preserves its valuation: writing `z = p^h w`, the reduced unit
part differs from `w` by a multiple of `p^(m+1-h)`, so remains nonzero modulo
`p`. If `z = 0` or `nu_p(z) ≥ m+1`, its representative is zero. It follows
that unequal *ordinary* valuations also imply C's finite-modulus hypothesis:
either both are live and retain unequal levels, or at least one collapses.
If both ordinary valuations exceed `m`, both collapse even if the valuations
are different. They must never be fed to F as live levels.

## Exact natural arithmetic interface proposed for Lean

These are proposed names, definitions, and declaration types, not claims of
existing or kernel-checked declarations. Proof terms are intentionally omitted.
The natural interface avoids truncated subtraction of the original inputs.

```lean
def primeAdicDigit (p m x : ℕ) : ℕ := (x / p ^ m) % p

def primeAdicDifference (p m a b : ℕ) : ℕ :=
  let P := p ^ (m + 1)
  (a % P + P - b % P) % P

def PrimeAdicDifferenceSeparated (p m x y : ℕ) : Prop :=
  x = 0 ∨ y = 0 ∨
    ∃ a b u v : ℕ,
      a ≤ m ∧ b ≤ m ∧ a ≠ b ∧
      x = p ^ a * u ∧ y = p ^ b * v ∧
      ¬ p ∣ u ∧ ¬ p ∣ v

theorem primeAdic_two_distinct_targets
    (p m x y a b u v tx ty : ℕ) (hp : Nat.Prime p)
    (hx : x = p ^ a * u) (hy : y = p ^ b * v)
    (ha : a ≤ m) (hb : b ≤ m) (hab : a ≠ b)
    (hu : ¬ p ∣ u) (hv : ¬ p ∣ v)
    (htx : tx < p) (hty : ty < p)
    (htopx : a = m → 0 < tx) (htopy : b = m → 0 < ty) :
    ∃ lam : ℕ, 0 < lam ∧ lam < p ^ (m + 1) ∧ ¬ p ∣ lam ∧
      primeAdicDigit p m (lam * x) = tx ∧
      primeAdicDigit p m (lam * y) = ty

theorem primeAdic_triple_compression
    (p m : ℕ) (hp : Nat.Prime p) (b : Fin 3 → ℕ)
    (hsep : PrimeAdicDifferenceSeparated p m
      (primeAdicDifference p m (b 0) (b 2))
      (primeAdicDifference p m (b 1) (b 2))) :
    ∃ lam : ℕ, 0 < lam ∧ lam < p ^ (m + 1) ∧ ¬ p ∣ lam ∧
      ∀ i : Fin 3,
        primeAdicDigit p m (lam * b i) =
          primeAdicDigit p m (lam * b 2) ∨
        primeAdicDigit p m (lam * b i) =
          (primeAdicDigit p m (lam * b 2) + p - 1) % p
```

For positive `P`, the subexpression `a % P + P - b % P` has no truncated-
subtraction loss, because `b % P < P`. It represents the signed difference
`a-b` modulo `P`. Both differences passed to `hsep` therefore lie below `P`.
In the live branch, `¬ p ∣ u` already excludes `u=0` and likewise for `v`.
In a collapsed branch the unused difference still has its automatic
nonzero-residue decomposition if needed; no bound is silently assumed for an
arbitrary caller-supplied number.

A signed adapter takes `b : Fin 3 → ℤ`, replaces every input by
`(b i).natMod (p^(m+1) : ℤ)`, invokes the natural theorem, and transfers the
product-digit conclusions by residue congruence. Its signed digit must use
Euclidean division (or this residue adapter), not truncation toward zero or
natural subtraction. No use of `Int.natAbs` is permitted for the oriented
differences unless the direction change is tracked.

## Boundaries visible without a search

The following constants are fixed examples to audit the formulas by hand.
They are not evidence from an executed verifier.

1. **Endpoint and negation:** take `p=7`, `m=2`, `R=49`, `P=343`, and
   `(b0,b1,c)=(295,337,1)`. With `lambda=1`, the anchored differences are
   `294=6R` and `336=7*48`, of levels two and one. Both have digit six;
   their signed lifts are `-49` and `-7`. The input digits are `(6,6,0)`,
   correctly in `{6,0}`. But the negative of the first difference has
   representative `49` and digit one. Thus the all-ordered-difference
   `{0,6}` assertion is not available even for three same-class units.
2. **One collapsed difference:** with the same modulus, take
   `(b0,b1,c)=(344,8,1)`. The anchored representatives are zero and seven.
   The level-one correction `lambda=1+6*7=43` sends the second difference
   to `301=6R+7`, hence digit six. The first difference remains zero and
   cannot have digit six. The products have residues `(43,1,43)`, with
   digits `(0,0,0)`.
3. **Both collapsed with unequal ordinary valuations:** still at `P=343`,
   take `(b0,b1,c)=(344,2402,1)`. The nonzero ordinary differences are
   `7^3` and `7^4`, yet both finite representatives vanish. `lambda=1`
   gives digit zero for all three. Actual zero differences are handled by
   this same residue case, without assigning an ordinary valuation to zero.
4. **Equal-level obstruction:** take `(b0,b1,c)=(1,50,99)` at `R=49`.
   All are units congruent to one modulo seven. For any unit `lambda`,
   writing `s=lambda mod 7`, their digits are
   `q(lambda)+{0,s,2s}` modulo seven. These are three distinct residues,
   so no such multiplier compresses the triple into two residues. Relative
   to anchor `99`, both nonzero difference representatives have level two.
5. **Small exponent:** at `p=7,m=0`, live representatives all have level
   zero; there are no two distinct live levels. A collapse branch can still
   apply. For `(b0,b1,c)=(2,5,5)`, `lambda=5` gives digits `(3,4,4)`.
   At `p=2`, F remains valid because its top target must be one, and C's
   two-residue arc is the whole digit group; there is no odd-prime omission.

The interval proof explains why the endpoint at `-R` must remain closed.
It must not be removed to make the stronger all-differences premise hold.

## What this reduces, and what it does not

The construction is input dependent through the live levels and their current
unit coefficients. It supplies multipliers at those levels, which a family
restricted to `J*(1+kR)` does not represent in general. This is a concrete
alternative primitive for later seven-adic work, not a further fixed-family
candidate scan.

If the original inputs are units in one class modulo `p`, their transformed
residues modulo `p` remain one common nonzero value `s`. Assume `m ≥ 1`.
For `K(k)=1+kR`, the elementary identity (1), at level zero, gives

`q(K(k)*lambda*bi) = q(lambda*bi) + k*s (mod p)`.

Thus the compressed pair moves by a common translation as `k` ranges modulo
`p`. At least `p-3` translations put the containing pair in
`{1,...,p-2}`: its starting digit may be any of `1,...,p-3`. For `p=7`
this supplies at least four choices good for all three inputs. This count
uses only a bijective affine shift; it is not an executed finite search.
Other inputs must still be accommodated by the same choices. Their forbidden
sets cannot simply be assumed disjoint or harmless.

The finite arithmetic also has a count-independent extension: for any finite
anchored family whose noncollapsed differences occupy pairwise distinct
levels, use the highest target first and descend through all occupied levels
by (1)–(2). At most one target occurs at the top level, so it can be set to
`p-1`; all others can too. Lemma I compresses the entire family into two
consecutive digits. Collapsed differences may repeat arbitrarily. This is
proved by the same finite descending induction, but it is a sparse-level
condition, not a condition known to hold for unrestricted runner inputs.

There is useful persistence for future combinations: after difference
compression, any correction at a level strictly below **every** live
difference preserves all these anchored difference residues by (2).
Lemma I then preserves two-digit compression, even though the anchor may
move. This statement concerns the proved residue certificate; arbitrary
further dilations are not asserted to preserve compression.

Equal-level difference configurations remain a real branch, as the obstruction
above shows. Compressing one class also does not settle all other residue
classes or lower-level filtering requirements. Independently, the current
canonical seven-real-runner route needs `LowerCountPositiveIntegerHypothesis 8`,
including the five-moving-integer case at its stronger margin `1/6`.
The source checkpoint provides the lower-count hypothesis at six via
`FiveRunnerOrdinary.lean`; a future six-moving integer theorem with margin
`1/7` would not imply that missing stronger-margin case by duplication.
The orchestrator identified this canonical integration gap during this task;
this report neither proves nor bypasses it.

## Source API map and bounded implementation plan

Only project source was inspected; `.lake` was not read or restored.

| Existing source | Applicable material | Limit |
| --- | --- | --- |
| `LonelyRunner/FiveAdicFiltering.lean:14`–`:95` | Natural digit definition, residue decomposition, selected correction product/digit, higher-level residue preservation | Fixed base five; generalize these arithmetic lemmas with explicit prime/base hypotheses |
| `LonelyRunner/FiveAdicFiltering.lean:100`–`:121` | Exact top residue and its closed distance bound | The digit `p-1` at the top is distance-good; ordinary digit exclusion is only sufficient, not equivalent |
| `LonelyRunner/FiveAdicFiltering.lean:123`–`:183` | Existing use of inverses in `ZMod 5` and natural representatives | Its two-label forbidden-set theorem is not the desired exact-target theorem |
| `LonelyRunner/FiveAdicFiltering.lean:185`–`:212` | Digit congruence and bounded unit representative | Straight general-prime arithmetic adaptation |
| `LonelyRunner/FiveAdicFiltering.lean:246`–`:368` | Descending seeded multiplication, preserving higher residues before reducing the unit | Reuse architecture; do not reinterpret its fixed-five distance conclusion as compression |
| `LonelyRunner/FiveAdicDecomposition.lean:15`–`:45` | Positive natural decomposition through `padicValNat`, `pow_padicValNat_dvd`, and `pow_succ_padicValNat_not_dvd` | Add arbitrary-prime instance and residue nonzero guard; exclude zero first |
| `LonelyRunner/FiveAdicHardPattern.lean:17`–`:64` | Generic cyclic-distance congruence and complement equalities | Distance symmetry does not establish digit symmetry |
| `LonelyRunner/PivotResidues.lean:20`, `:102`, `:151` | Natural cyclic distance and circle-norm bridge | Compression alone is not a distance lower bound |
| `LonelyRunner/ReverseGrid.lean:40`, `:164`–`:220` | Signed distance via `Int.natMod`, congruence, and negation | Useful convention precedent; an oriented signed digit adapter is still needed |

Implement in this order after independent review:

1. Add a small general-prime arithmetic module containing the natural digit,
   residue decomposition/congruence, unit representative, `H_j` equations,
   and one-target solver. Use `letI : Fact (Nat.Prime p) := ⟨hp⟩` and
   field inversion in `ZMod p`; use actual current coefficients in (1).
   Avoid importing the finite carry table merely to obtain generic facts.
2. Prove F by two algebraic target choices. Add the guarded positive-residue
   decomposition adapter. These are finite arithmetic proofs, with no
   computational certificate or finite candidate table needed.
3. Prove Lemma I, either with Euclidean integer division as above or a
   natural residue proof split at the wrap. In the natural proof the wrap
   case has anchor residue below `R` and input residue at least `P-R`;
   the nonwrap case has input at most `R` behind the anchor. Keep equality.
4. Prove C with the three collapse/live cases, then its integer-residue
   adapter. The anchor/predecessor output immediately gives an existential
   cyclic length-two statement without implementing a minimum-length API.
5. Obtain independent semantic review of these exact types before the
   implementation is accepted. Kernel-check the focused module and inspect
   axioms under pinned dependencies; appropriate endpoint examples should
   cover the five fixed cases above. A documentation-only report does not
   justify a current cache restore or full source build.

The most useful first integration deliverable is F plus C, retaining the
stronger difference-digit certificates internally. The arbitrary-family
extension and translation-count theorem may follow once a concrete downstream
case needs them. No blanket general-prime replacement of the completed
five-adic modules or the canonical Fin5 theorem is necessary.

Source SHA-256 values at inspection:

```text
1a210e70383e9b00d1a3aec321e9e1a838efcd26c24ca180101964e8c6e71429  LonelyRunner/FiveAdicFiltering.lean
049da0b10b478fe2cdb0a6239ebc97a60317022f15263c317d5aa56415a7357e  LonelyRunner/FiveAdicDecomposition.lean
b6caced5772fb4b33a7bb6d26792aaa49f5287557f3165c862edeaf7d69daeca  LonelyRunner/FiveAdicHardPattern.lean
362da5ab923f22e900ae7ac821dd4cf4aab91dfe70889987bc9e5a05d19c276a  LonelyRunner/PivotResidues.lean
f96f1de48140d77d734f873446b6d73707e2182f5d8ba2761524ee604543b391  LonelyRunner/ReverseGrid.lean
```

Disposition: the finite-modulus unequal-level compression contract is settled
at author-manuscript level, including signed, zero, collapsed, top-level, and
closed-endpoint cases. It has a concrete general-prime arithmetic implementation
path and limited reusable value across runner counts. Independent review and
kernel implementation remain; full LRC remains open in this project.
