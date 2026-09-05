# Astra research checkpoint 3

The unrestricted canonical conjecture remains unresolved. This pass adds two
full-size conditional grid theorems and a more general arithmetic bridge.
Each full-size theorem controls all `N-1` original moving speeds at the closed
`1/N` threshold; neither supplies its own hypotheses for arbitrary tuples.

## Product-free full-size grids

`LonelyRunner/AffineGridFullSize.lean` proves
`affine_avoidance_allow_zero_scale` and `affine_grid_full_size_witness`.
For the field lemma, slopes either enumerate all units, recovering the
existing product condition, or omit a unit, permitting the scale `s=0`.
The real-grid theorem handles the all-nonzero-offset branch separately at
time `1/N`. It retains the essential premise that some original speed is
nonzero modulo `N`, and removes the slope-product condition.

The fixed-grid negative control remains relevant: at `N=5`, `M=17`, the
speeds `(35,70,105,140)` have no witness on the `1/85` grid. Removing the
nonzero-offset premise would therefore make the theorem false, although
these speeds have an ordinary LRC witness on another denominator.

## A shifted grid for one vanishing slope

`LonelyRunner/AffineGridArithmetic.lean` now has a combined residue-band
theorem. The original arithmetic interface is a short wrapper around it,
so the quotient and real-phase identity have only one implementation.

`LonelyRunner/AffineShiftArithmetic.lean` reuses the existing integral
rounding construction to produce

`N*r=M*r0+beta`, with `M <= A*beta < M+N*A`.

`LonelyRunner/AffineGridVanishing.lean` uses this shift to prove
`affine_grid_one_zero_witness`. Its distinguished original speed `U` and
base `A` are divisible by the odd prime `N`. Ordinary bases satisfy
`0<a_i<A`, are nonzero modulo `N`, and have the stated congruences modulo
`M`. The exact integral size requirements are

`N*A <= (N-2)*M` and `N*a_i*A <= (A-a_i)*M`.

They keep the distinguished residue above the lower boundary and below
the upper boundary, while keeping every other correction within one residue
interval. The conclusion includes `U` and all `N-2` ordinary rows. The
external modulus need not be prime or coprime to `N`.

The coarse size assumptions imply `A<M` and `a_i<M`; those are derived
facts, not additional normalization premises. The manuscript's broader
exact-size and signed variants have not been formalized by this declaration.

## Scope, examples, and next gap

`research/astra-vanishing-slope.md` gives a lifted, primitive family that
blocks every simple denominator from 2 through `N` and escapes every
normalization of the earlier A/B methods. Its explicit witness works for
every integer `N>=7`, including even and composite counts. That explicit
specialization remains a manuscript argument; the general compiled one-zero
theorem still requires prime `N`.

The same note supplies a simultaneous multiple-zero extension under explicit
size and range assumptions. It also disproves automatic iteration of the
conservative correction interval: at `N=5`, zero bases `(10,50)` and ordinary
bases `(1,9)` admit no suitable common correction in `[0,1/9]`, even allowing
the zero rows to wrap. The actual tuple `(1,9,10,50)` has witness `1/4`, so this
is a limitation of the proposed intermediate step.

Independent semantic and source review is in `research/astra-pass3-review.md`.
The full build, trust audit, source fingerprints and compact reproduction
evidence are in `research/astra-pass3-verification.json`. The next audit asks
whether the union of the current normalization classes has an unrestricted
supply theorem, or whether another explicit family escapes them all. It must
allow the full authorized scaling and sign choices before claiming an
obstruction. The shared cache remains needed for ongoing formal work.
