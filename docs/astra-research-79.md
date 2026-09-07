# Pass 79: full frequency interactions and phase normalization

The proposed global slack-energy inequality remains unproved and unrefuted.
This pass closes one attempted argument for it and checks a specific
author-linked method for a usable uniform estimate. It supplies no new Lean
declaration and does not change the unrestricted proof/disproof goal.

The exact-support analysis includes every frequency in the relation lattice.
For `(1,2,4)`, the complete three-coordinate contribution repairs a negative
defect from the constant and all pair contributions. For tuples containing
`(1,2,3)`, an exact parity and endpoint-derivative argument instead gives
negative three-coordinate defects at sufficiently small positive thresholds.
The two directions of compensation rule out a termwise positivity argument.
They do not give a negative full defect or a counterexample to LRC. The
complete integrations and endpoint analysis passed independent review.

The primary-source comparison uses the author-linked Bedert--Hu note at
commit `d53fa46aedf01779481fc5f17726bb0ab6770ac4`, with its LaTeX source
hash recorded. Its moving count is `N-1`; its additive dimension is a
different parameter. The audited phase randomization controls selected
Fourier coefficients while retaining all supports in its final test.
Its cited earlier Bedert and Bonami inputs remain explicit assumptions of
this source audit. This is not an independent formal proof of the paper.

Applied to the full nonnegative slack product, the phase argument yields a
homogeneous coefficient estimate. It does not compare the integral with
its threshold derivative, which is the missing input for our proposed
inequality. The source's quantitative bounds also fall short of the sharp
distance, and its cover-only hypothesis differs from the all-threshold
derivative contract. Independent starting-phase averages cannot supply a
conclusion at the prescribed common starting phase.

Independent review corrected one author error concerning auxiliary phase
densities: dividing the full dependent Riesz product by its phase-dependent
mass **does** preserve the uniform phase average. Covariance under a common
time translation proves this exactly. The corrected manuscript preserves
the error history. The simple Fourier coefficient formula and disjoint
support layers still require new analysis after normalization. This
correction led to an exact analysis of the normalized coefficients.

The normalized analysis retains every phase harmonic. It derives the exact
Fourier transfer and nonnegative aggregate spectral gains. Individual phase
weights can be negative, and their total first-order magnitude has an upper
bound whose average tends to zero for consecutive speeds. A direct uniform
replacement of the original first-order signal therefore fails.

There is a further precise limit: for each fixed speed tuple, every density
in this family, and every probability mixture of them, misses uncovered
intervals at thresholds sufficiently close below the tuple's actual optimum.
The proof uses positivity, compactness and an explicit bound on the density.
It includes an exact `(1,2)` control and consecutive-speed examples for every
moving count. This refutes an all-subthreshold certificate claim; those good
examples do not meet hypothetical minimal-failure assumptions. Neither this
obstruction nor the first-order bound rules out a stronger argument using
all Fourier modes or a different, increasingly concentrated density family.
The exact aggregate variance constraint still lacks a sharp arithmetic lower
bound. The independent review accepted these exact claims without corrections.

Only manuscript algebra, source comparisons and administrative checks were
needed. No new numerical search, local Lean build or cache restoration was
performed. The verification receipt distinguishes reviewed mathematics,
source-bound conditional inputs and the remaining sharp proof obligation.

Pass 78 merged through PR77 at main commit
`92d567677620fec37008cff35a70092339a87fd3`. Both required CI checks
passed; root verified 33 source and receipt hashes plus head and parent
ancestry on fetched remote main. This checkpoint includes the independently
accepted normalized-coefficient manuscript and its review.
