# Twenty-ninth Astra checkpoint: conditional packets and mixed margins

This documentation checkpoint records workflow-validator support and accepted
research manuscripts after Pass 28. It does not add Lean source, a full build,
or an axiom audit. The latest such evidence remains Pass 28's 3,638-job build
and 427 permitted-only audit reports. The full canonical
`LonelyRunner.Conjecture` and the proposition for all inclusive primitive
finite families remain unproved. The checks cited here are exact manuscript
program replays, not a new Lean build.

## Accepted conditional constructor

The [exact affine-union manuscript](../research/astra-exact-affine-union-audit.md)
and its [independent review](../research/astra-exact-affine-union-review.md)
are accepted as a conditional result and were replayed by the root. Given the
stated stronger fastest-coordinate mixed witness and its nonzero second-anchor
inequality, the construction produces exact stationary packet `S` with the
true collision count `c=N-2`. This is a conditional constructor: it neither
derives its anchor premise from an arbitrary witness nor supplies the
direct-or-exact union uniformly.

## Accepted mixed-margin equivalence

For `N>=3`, call a real or rational witness mixed when every original norm is
at least `1/N` and its fastest-coordinate norm is at least `1/(N-1)`. The
[mixed-anchor manuscript](../research/astra-mixed-anchor-lemma.md) and its
[independent equivalence review](../research/astra-mixed-supply-equivalence-review.md)
are accepted at that exact scope: stationary exact `S` holds if and only if a
mixed real witness exists, and if and only if a mixed rational witness exists.
The review includes the `N=3` all-half case, where the required exact packet
has zero loss. For `(1,3)`, the only mixed witness modulo one has zero pair-sum norm;
the nonzero-anchor lemma therefore requires `N>=4`. The equivalence does not
supply witnesses or packets uniformly.

## Accepted one-deletion family

The [one-deletion manuscript](../research/astra-direct-mixed-supply.md) and
its [independent family review](../research/astra-direct-mixed-supply-review.md)
are accepted as a manuscript theorem for
`W={1,...,N} minus {a}`, with `N>=4`, `2<=a`, and `2a<=N`. The frozen author
gives both signs of the mixed witness across the full stated analytical
ranges, including the separate `N=2a` boundary formula. The corrected fixed
controls were replayed with 28 positive times, 218 retained-coordinate
comparisons, 53 divisibility facts, and 8 negative controls; they are finite
reproducibility evidence rather than a proof of the quantified statement.

The family is already ordinarily covered by
`boundedHeight_stationary_witness`, so the strengthened fastest-coordinate
margin supplies no new ordinary LRC coverage. It also gives no uniform mixed
witness supply, no exact-packet supplier for arbitrary tuples, and no proof or
disproof of LRC.

The separate two-hole manuscript remains independently unreviewed and is
excluded from this Pass 29 checkpoint.

Pass 28's finite pair-sum completeness and denominator bound remain unchanged:
for a supplied witness of a sorted distinct tuple, a candidate denominator is
at most `a_(n-1)+a_n <= 2a_n-1`, but no uniform certificate supply follows.
