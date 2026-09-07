# Pass 101: full rank of bounded relations under lower-count supply

PR #99 merged `94a96d13c7877aeb37ef341543830ef253299008`. Its two hosted
checks passed, with 3,731 build jobs, 710 trust reports and 17 remote file
hashes plus ancestry verified. This pass records an independently reviewed
manuscript theorem. It adds no Lean declaration or unrestricted LRC proof.

Let n >= 6, let v be n distinct positive integer moving speeds, and assume
the ordinary positive-integer conjecture at every smaller moving count.
If the actual maximum of the full minimum is at most 1/(n+1), then the
integer zero relations with every coefficient bounded in magnitude by
E = 2n^2(n(n+1)-1) span a rational space of dimension n-1. This is rational
span, not integral generation of the entire relation lattice.

The proof uses a normalized power of a finite Fejer kernel. A phase point
annihilating every E-bounded relation is within a strict 1/(n(n+1)) of
the original orbit in every coordinate at one common time. If the relation
span had smaller rank, the existing adjacent-ratio construction would give
a nowhere-zero rational replacement with two opposite coordinates.
Deduplicating its magnitudes and applying lower-count supply gives a closed
1/n witness. The strict approximation then transfers all original labels
to a strict 1/(n+1) witness, contradicting the stated maximum bound.

This result settles two proposed routes. At any coefficient bound D >= E,
a partition splitting all bounded relations must consist of one block.
In particular, the suggested proper core with a nonempty outside group
cannot occur at D = 1568n^2(n+1)^2-2. Also, for primitive v, any positive
integer replacement preserving all E-bounded relations is an integer
multiple of v and cannot have smaller sum. Complete sum minimality supplies
witnesses for smaller tuples; it does not make those tuples preserve the
required relations.

The depth E is below the existing sharper height cutoff
binom(n+1,2)^(n-1), but a height bound derived from the new rank certificate
is larger than that cutoff. The result therefore does not improve the
finite-height reduction or supply its remaining universal finite family.
It is compatible with the native-sharp progression {1,...,n}, whose maximum
equals 1/(n+1). Strict failure remains a stronger condition than this
structural certificate.

Collision followed by Fourier transfer is already used in Section 4 of
[Tao's finite-checking argument](https://arxiv.org/pdf/1701.02048).
The present explicit rank formulation carries no strategy novelty claim.
Its immediate value is to exclude the two incompatible reduction plans and
identify the next missing inference: sufficient control of the phase of a
changed bounded relation to transfer every original coordinate at one time.

The full manuscript and independent review preserve all hypotheses,
closed endpoints, source contracts and limitations. New analytic Lean
infrastructure remains deferred until a useful transfer for the remaining
case is established. Verification for this pass checks bindings, unchanged
Lean sources and pinned dependencies, formatting and workflow consistency;
no local build or cache restoration is needed.
