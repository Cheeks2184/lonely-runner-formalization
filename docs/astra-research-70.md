# Pass 70: exact ideal-row reduction and restricted selection proofs

The uniform ideal-row question now has an exact finite combinatorial form.
For N>=5, put b=N-2 and retain all regular pairs k=1,...,N-2,
ell=0,...,N-1 together with the exceptional pair (N-1,0). A real slope
contributes the pairs at which its circle norm is strictly below 1/N.
The unresolved claim is that b such masks cannot cover every pair.

The finite-cell manuscript proves that any real failure would already occur
at b distinct midpoints of the cuts j/k, for 1<=k<=N-1 and 0<=j<=Nk.
Strict failure persists when boundary slopes move into open cells, and each
bad-pair mask is constant within its cell. Duplicate masks can be removed
and the remaining set padded with other midpoints, preserving a cover.
This proves an equivalence, rather than merely a sampling approximation.

Every midpoint has reduced denominator at most D=2(N-1)^2. A positive bad
deficit is therefore at least 1/(ND). Using a common denominator bounded by
D^(N-2), the accepted ideal-to-integer transfer becomes explicit: an ideal
failure supplies an ordinary integer auxiliary counterexample with every
speed below

    N [2(N-1)^2]^(N-2) [2(N-1)^3+2].

This bounds a failure of the proposed two-digit construction. It is not a
finite-checking bound for LRC and does not replace the formalized published
cutoff. No such failure is exhibited in this checkpoint.

The exact N=5 control from Pass69 exhausted precisely the finite family in
this equivalence. Its unchanged 4,060-subset nonfinding consequently supports
ideal closed selection for every three real slopes at N=5, including cut
boundaries and repetitions. This interpretation uses the new mathematical
reduction. The retained program was not rerun, its unused witness-validation
branch remains unused, and no new numerical domain was explored. This is
computationally supported manuscript evidence, not a kernel theorem or a
runner-count milestone.

Two other uniform restricted families also select. For N=q+1 with q prime,
the punctured equally spaced slopes alpha+Nj/q reduce to finding an allowed
k with ||k alpha||<=1/q; cyclic pigeonhole supplies it. For prime N, small
perturbations |epsilon|<1/(N-2) of N-2 distinct residues select because the
fixed signs required to cover omitted centres contradict paired inverse
rows and an explicit reflection path. These proofs are closed-only and do
not reduce arbitrary slopes to their hypotheses.

All new manuscript arguments receive independent Astra review and root full
source review. One author sentence was corrected before independent review:
the data shared across rows are the slopes and resulting row points; the
candidate centre can be chosen separately for the selected row. No other
change to that manuscript was required at that stage.

The remaining uniform issue is how actual shared floor/carry sequences
constrain the union of masks. A separate bounded analytical task is examining
cell-wall exchanges and global incidence constraints. Its unfinished work
is excluded from this checkpoint. Closed ideal success still does not
automatically survive positive finite-M corrections at upper endpoints.

No Lean source change, dependency restoration, numerical expansion or new
Terra delivery is included. The canonical N=6 milestone is unchanged; the
unrestricted conjecture remains unresolved. Verification bindings and actual
administrative checks are retained in `research/astra-pass70-verification.json`.
Publication follows exact-head required CI and merge verification.
