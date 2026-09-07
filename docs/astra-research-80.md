# Pass 80: limits of compensation between nearby rational intervals

The proposed global slack-energy inequality remains unproved and unrefuted.
This pass establishes an exact obstruction to pairing or grouping intervals
within a fixed number of neighboring rational zero cuts. The obstruction
holds at every fixed moving count and threshold as the largest speed grows.
It is a manuscript result with independent review; no Lean source changed.

For `d>=2`, choose `A=(d+1)(4d+5)`, `a=1/A`, `M=AK+1`, and speeds
`(1,...,d-1,M)`. These tuples have an actual canonical witness at
`t=1/(d+1)`. Nevertheless, `K-1` consecutive rational-zero chambers inside
`(2a,3a)` each have a strictly negative energy defect. Their aggregate
negative deficit stays bounded away from zero as `K` grows. The manuscript
gives the full finite formulas for their integrals and threshold derivatives,
and the exact local maxima `(j+1)/(M+1)`.

Translation by `1/M` between neighboring chambers preserves the fast norm
and increases every slow slack. Their energies increase, but both defects
remain negative. Even arbitrary positive weights cannot make a group entirely
inside this run have a nonnegative budget. A sufficiently long run contains
the whole prescribed finite neighborhood of one chamber, refuting a partition
into nonnegative groups of uniformly bounded chamber-index diameter.

The restriction is to the number of intervening chamber boundaries. This
result does not rule out transport bounded in physical time, distant pairings,
height-dependent group sizes, or credit relayed through arbitrarily many
intervals. The complete defect of the example family was not evaluated.
The missing global step is to supply enough positive contributions and
control their use so that the same surplus is not spent repeatedly.

The author and independent reviewer checked the exact family, complete
integrals, differentiation with the speeds held fixed, local maxima,
strict inequalities, aggregate limsup, and all radius quantifiers. Root read
both manuscripts and independently checked the main calculations. Local
integration verification binds the files and their dependencies and checks
workflow consistency, whitespace and storage. No new numerical experiment,
local Lean build or cache restoration was needed.

Pass 79 was merged through PR78 at
`52dcb44f9d4dfe5d398089193d71a2dd3ed1aa0b`, after both required checks passed.
Root verified 16 hashes and head/parent ancestry on fetched remote main.
The new full cyclic-averaging investigation is excluded from this checkpoint
until it has a complete manuscript and independent review. The unrestricted
canonical proof/disproof goal remains active and unresolved.
