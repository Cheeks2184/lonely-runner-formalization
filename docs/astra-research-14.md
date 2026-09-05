# Fourteenth Astra research checkpoint

The owner-cover audit supplies a manuscript proof that three distinct positive
speeds below a pivot cannot cover its candidate row at threshold `1/7`, for
arbitrarily large speeds. Independent Astra review accepts the full manuscript.
This is a statement
about three lower speeds and their pivot; it does not protect unlisted speeds
or prove the unrestricted Lonely Runner Conjecture.

The proof separates rows by whether their exact zero-product kernel is empty.
For a nonempty kernel, the reduced denominator determines its cardinality.
Only the speed `7p/8` can have more than `2p` bad candidates. If that exceptional
row occurs with two other nonempty kernels, exact periodic overlap bounds the
part of each other row outside it by less than `15p/8`. This leaves a candidate
outside all three rows. The proof handles common powers of seven by positive
common scaling. Existing kernel-family results handle three owners for `N>=8`,
so the manuscript fills the remaining `N=7` case of that sufficient class.

The same audit checks the preceding endpoint obstruction against the actual
maximum-covered-pivot definitions. Its two large speeds have explicit pivot
certificates. Its ten small speeds are exactly the covered pivots, because the
large divisible speed kills their entire rows. At the largest covered speed,
`136`, the nine internal owners violate the existing numerical budget but have
the safe candidate `196`. Thus maximum-covered status does not supply that
budget; this example does not refute the desired redundancy principle.

Evidence is retained in:

- [The complete contract audit and proof](../research/astra-next-bridge-audit.md).
- [Independent mathematical review](../research/astra-three-owner-review.md).
- [Exact existing Lean interfaces](../research/astra-three-owner-api-inventory.md).

Root read the full manuscript and replayed its sole exact Python block:
230,300 triples, 6,074 periodic pairs, two common-seven-power controls, two
fixtures outside the earlier numerical criterion, and three explicit pivot
certificates passed. Root also replayed the independent review's 4,950 literal
rows, 27,405 triples, 65 remainders, and 18 exceptional-period controls, including
common powers of seven. Exact hashes and outcomes are retained in
`research/astra-pass14-verification.json`.
These finite checks support the manuscript; they are not
the proof of its unbounded quantifiers. No Lean source or dependencies changed,
and the large rebuildable cache remains absent.

The next decision is whether the reviewed arithmetic bound justifies immediate
formalization or extends to a more useful general owner bound. Neither a
conditional certificate format nor a bounded search nonfinding will be treated
as universal supply. The canonical conjecture remains unresolved.
