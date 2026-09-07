# Pass 81: exact obstruction to a coarse cyclic induction bound

The proposed global slack-energy inequality remains unproved and unrefuted.
This pass tests an average over all translations in a period of the fastest
runner. That average retains the original common time, every residue and
every Fourier alias relation, and gives exact integral and derivative
identities. The tested global comparison still fails on an actual good tuple.
No Lean source changed and no unrestricted conclusion is claimed.

Write `I_bar=L^2 J` for the independent-product comparison, where J is the
full slow-tuple integral and `L=1/2-a`. The lower-count energy inequality
supplies a positive lower bound `B_low` for this comparison's defect. Let R
be the full correction needed to recover the actual defect. The proposed
estimate `R>=-B_low` would suffice for induction, but asks for an extra
reserve equal to a positive multiple of the actual lower-count defect.

For `(1,2,3,4)` the manuscript integrates every common-positive component
exactly. On `19/100<=a<1/5`, the full defect is strictly positive, yet
`B_low+R<0`. Thus the proposed induction estimate is false. Near the sharp
endpoint the discarded lower-count contribution has order `1/5-a`, while
the full defect has order `(1/5-a)^3`. Its exact polynomial and rational
interval bounds isolate the failed step without treating it as an LRC
counterexample or a refutation of the full energy inequality.

The same analysis derives the leading integral for every progression
`(1,...,d)` near its sharp threshold. Exactly two constraints are active at
each maximizing time, producing cubic decay with an explicit positive
coefficient. The full correlation with the independent-product comparison
therefore tends to zero. This rules out nondecreasing correlation and any
fixed fractional reserve in the tested comparison. Those progression
examples are LRC-good; they do not satisfy hypothetical failure assumptions.

A successful induction through this representation would have to control
the full correction together with the actual lower-count defect. Neither
the exact averaging identity nor rewriting that missing comparison proves
it. The stronger energy route is being reassessed before another mechanism
is selected. That ongoing assessment is excluded from this checkpoint.

Independent review accepted the final manuscript without corrections. Root
read both manuscripts and checked the complete integrals and bounds. The
integration receipt binds sources and records administrative checks. The
mathematical calculations use exact hand integration and arithmetic;
no new numerical experiment, local Lean build or cache restoration was run.

Pass 80 merged through PR79 at
`55df0b86d08964d2927000435006ac14a53c51a3` after both required checks passed.
Root verified fourteen hashes and head/parent ancestry on fetched remote
main. The unrestricted canonical proof/disproof goal remains active.
