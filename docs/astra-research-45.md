# Forty-fifth Astra checkpoint: rational shifts and divisor counts

Six more declarations implement the remaining contracts of the reviewed
six-total divisor-seed manuscript. They provide a sharp reduced-orbit bound,
a uniform quarter-margin, exact preservation of a divisible family, a
conditional five-moving sixth-margin witness, and necessary divisor counts
for a hypothetical primitive counterexample.

## Exact mathematical scope

For a denominator ell at least two and a speed d not divisible by ell, the
actual rational orbit has size n = ell / gcd(ell,d). The new mesh theorem
finds a natural k below both n and ell with circular distance at least
(n-1)/(2n). Since n is at least two, this implies the closed quarter-margin.
The denominator need not be prime, d need not be a unit modulo ell, and the
base phase may be any real number. The n=2 equality case is retained.

The preservation theorem applies to any labelled family, including an empty
or infinite one. If all of its speeds are divisible by ell, the same shift
k/ell preserves every original circle norm exactly while giving the supplied
nondivisible exceptional speed a quarter-margin. No family finiteness or
positivity is required for that norm identity.

For five positive natural speeds with four divisible by ell and one
nondivisible exception, the checked four-moving theorem supplies a positive
seed at margin 1/5 for the other labels. The reciprocal shift preserves that
seed and supplies margin 1/4 for the exception. Both imply the required
closed 1/6 bound, and the shifted time remains positive. Speeds may repeat.
This theorem retains its explicit divisibility assumptions; it is not the
unrestricted five-moving result.

For a positive gcd-one five-label tuple with no real closed-sixth witness,
at most three labels can be divisible by any ell at least two. Gcd one rules
out all five being divisible; four would contradict the conditional insertion
theorem. For 2 <= ell <= 6, the existing small-denominator witness theorem
also forces at least one divisible label. Thus the divisor count lies from
one through three. The upper bound allows every ell >= 2; the upper limit
six is used only in the lower bound.

## Implementation and verification

`RationalShiftGcd` reduces the denominator and speed by their positive gcd,
uses the existing bounded coprime-grid theorem and casts exact arithmetic
identities to the reals. `RationalShiftInsertion` transports the result to
time shifts and reindexes the four old labels by `Fin.succAbove`.
`SixTotalDivisorCounts` uses finite gcd divisibility, erasure cardinality and
the existing small-denominator obstruction.

Root read all source drafts and ran focused builds. Initial gcd elaboration
errors concerned quotient unfolding, coprimality orientation, cast placement
and reassociation of multiplication with division. The corrections preserved
the reviewed theorem statements. A deprecated tactic in the count proof was
replaced with its current spelling. The final focused build passed; the new
modules produce no warnings, although older dependencies replay warnings.

The full project build passed with 3,677 jobs. The trust audit accepted 595
dependency reports and eight axiom-free declarations. Independent source
review accepted all six exact contracts, and its single universal-type and
axiom probe passed. Root read the complete frozen review and replayed its
exact entry point successfully. Every new declaration uses only the three
permitted axioms. These records are preserved in the verification JSON.
Independent review of the separate third-shift manuscript also accepted all
seven exact proposed contracts. Root checked the complete narrative, literal
contract fence and all 15 source bindings. The later implementation is not
part of these six declarations.

The preceding phase-lemma checkpoint was merged as PR 43 at
`3e882b739ace4bd58a5762d7b2b4250d3495c77b` after both required checks passed.
Root verified remote ancestry and synchronized local main.

The unrestricted conjecture and the full five-moving sixth-margin supply
remain unresolved. These are conditional insertion and necessary-count
results, with no new canonical runner-count claim. The shared pinned cache
remains required for active review and immediately queued implementation.
