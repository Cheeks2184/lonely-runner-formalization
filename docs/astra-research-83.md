# Pass 83: arithmetic exchanges in an optimal bad-arc cover

This pass derives an exact replacement condition for a minimum-cost cover
chosen from the complete integer-speed arc grids. It also checks the stronger
claim that such a cover can be changed to have unit determinants between
successive centers. That general claim fails; its restriction to an actual
strict failure remains unproved. No unrestricted LRC conclusion follows.

At a hypothetical failure, choose an open-cover width delta below `1/(n+1)`.
A minimum-cost subcover has no contained arc or triple intersection. Removing
a proper consecutive block leaves a single closed gap, including the possible
singleton gap. If its length is g and its midpoint is z, a cheaper replacement
arc of an original speed u exists exactly when an integer lies in the stated
open interval. Equivalently, it requires
`||u z|| < delta-u*g/2`. Optimality excludes this inequality for each cheaper
candidate. The interval is shorter than one grid spacing, so the complete
grid does not itself supply a replacement.

The determinant identity between successive rational centers has an exact
global consequence: every reduced rational of denominator at most `n+1`
must appear as a selected center. This recovers the existing condition that
some original speed is divisible by every such denominator. It does not
make the actual speed equal to the reduced denominator. Unit determinants
would force equality and require at least `n+1` distinct speeds, contradicting
the number n. The missing step is a justified way to obtain unit determinants.

For `(1,5,8)` at width `17/50`, four private-point tests force four specific
arcs in every cover of the full fourteen-arc family. Those arcs cover and
form the unique minimum-cost subcover, of cost `61/40`. Its determinants
are `2,4,4,2`. In particular, reducing the center `4/8` to `1/2` does not
permit replacing its actual speed 8 with an absent speed 2: that would change
both the arc radius and the cost.

This tuple has maximum `1/3`, above its canonical threshold `1/4`. It is a
control for general optimal-cover uncrossing, not a strict-failure example.
No height-minimality transport for an absent replacement speed is proved.
The exchange route stops at this precise gap; a separate investigation is
examining the full set of lower-height replacement witnesses.

The manuscript uses exact hand geometry and arithmetic. Independent review
accepted it without corrections, and root read the complete author and review.
The integration receipt supplies the source bindings and administrative checks.
No numerical search, local Lean build or cache restoration is required.

Pass 82 merged through PR81 at
`0f92e9a2f29ab5beccc22059baa916a2f82ce897`, after both required checks passed
and fetched main passed twenty-three hash checks and head/parent ancestry
checks. The unrestricted canonical proof/disproof goal remains active.
