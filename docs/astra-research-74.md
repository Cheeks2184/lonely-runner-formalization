# Closest-coset basis descent needs control of every competitor

Pass73 merged through PR72 at
`4818e5916e57697f83e842ca642f4e7599bbd32c`. Both required checks passed.
Fetched main matched the three frozen files, twelve dependencies and exact
reviewed head; the previous main remained an ancestor.

The current audit retains the ordinary central lattice coset. For `d=N-1`
moving speeds, its minimum gauge is `r(v)=1-2*mu(v)`, where `mu` is the
maximum ordinary loneliness margin. Closed LRC failure means
`r(v)>(d-1)/(d+1)`. The exact pairwise gauge, balanced contacts and primitive
rank-two plane follow from a global minimizer. They do not bound its value.
For consecutive speeds, all closest points span a proper subspace in every
total count `N>=4`; strict-failure-specific spanning remains a separate claim.

The new uniform obstruction concerns a proposed parity-preserving basis
descent. For every `d>=6`, append `(39h+1,24h+1)` to the speed/odd-lift pair
`(1,2,12,18,21,27)` and `(1,1,7,11,13,17)`. The odd lift is globally closest,
with gauge `5/13`. The determinant-one change `w=3v-4n`, `n'=-2v+3n`, followed
by a common coordinate sign change, gives a positive distinct primitive
speed tuple with strictly smaller sum. Its tracked candidate has gauge
`5/7`, but its global minimum is `1/3`. A better odd competitor lies outside
the preserved plane. All minima are proved for every real time; no finite
search is used. Both families satisfy LRC, so this refutes the stated
monotonicity inference without refuting descent under actual strict failure.

For an arbitrary competitor `m=s*w+e'`, the audit derives
`||e'|| >= (1-2*||b*s||)*r(v)` for `w=a*v+2*b*n`. The factor can vanish.
A smaller tuple's supplied witness therefore needs additional phase or
residual control before it can be transported to the original tuple.
One tracked candidate and invariant pair determinants cannot supply this
all-competitor statement.

Independent review accepted the complete manuscript after one notation-only
clarification separating the quotient direction from the new speed vector.
Root read both reports. Eleven dependency bindings and administrative checks
are recorded in `research/astra-pass74-verification.json`. No Lean source,
dependency cache or mathematical program changed. A separate investigation
tests joint witness constraints from smaller directions; its unfinished
manuscript is excluded. Unrestricted formal LRC remains unresolved.
