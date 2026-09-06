# Strict ideal row failure transfers to ordinary integer clusters

This manuscript records a conditional transfer used to interpret the bounded
row-control experiment. It supplies no counterexample by itself. The proposed
two-digit construction is an auxiliary claim; its failure would not refute LRC.
Root derivation at main `4227fef76e8a2081460c27b3af627bc6dcb501d4`.
Independent mathematical review is required before promotion.

Let N>=5 and let r_1,...,r_(N-2) be distinct nonnegative rational numbers.
Write delta=1/N and

    P = ({1,...,N-2} x {0,...,N-1}) union {(N-1,0)}.

Suppose that for every (k,ell) in P there is an index i such that

    ||(k r_i+ell)/N|| < delta.

Here ||x|| is distance to the nearest integer. All slopes are fixed across
all pairs. Choose one such bad index for each pair and let eta be the minimum
of its finitely many positive deficits delta-||(k r_i+ell)/N||. Thus eta>0.
Strict failure of the closed target, including the exceptional pair, is an
essential hypothesis. Mere failure of an upper-strict forward target does
not supply this positive margin.

Choose a positive common denominator q and put d_i=q r_i in the nonnegative
integers. Let d_min=min_i d_i and H=max_i d_i-d_min. For any sufficiently
large positive integer T put

    a=q,       M=N q T+d_min,       c_i=d_i-d_min.

The c_i form a set of exactly N-2 distinct nonnegative integer offsets
containing zero, with maximum H. Choose T large enough that simultaneously

    M>(N-1)max(H,q),       H(N-1)/(N M)<eta.                 (1)

Such a T exists because M grows without bound. The actual ordinary integer
speeds are a and the N-2 distinct speeds M+c_i, all larger than a. They have
exactly the arity and separation of the proposed general-slow cluster claim.
There are infinitely many such T, and the separation ratio M/max(H,a)
tends to infinity. No assumption of primitive speeds is needed.

Consider every proposed assignment

    t(k,ell)=k/(N a)+ell/(N M),        0<=k,ell<=N-1.

The slow phase is k/N+q ell/(N M), with its second term in [0,1/N).
It is below 1 even for k=N-1. Consequently its closed-good assignments
are exactly P: rows k=1,...,N-2 in full, plus (N-1,0). All assignments
outside P already fail on the slow speed.

For every pair in P, direct expansion of the actual fast phase gives

    (M+c_i)t(k,ell)
      = T k + (k r_i+ell)/N + c_i ell/(N M).                (2)

The integer Tk does not affect circle norm. The last summand e_i is
nonnegative and satisfies

    e_i <= H(N-1)/(N M) < eta.

For the bad index selected for this pair, the 1-Lipschitz inequality for
distance to the nearest integer therefore implies

    ||(M+c_i)t(k,ell)||
      <= ||(k r_i+ell)/N|| + e_i
       < delta.

This argument includes carries and wrap through an integer; it does not
require keeping a chosen fractional-part branch fixed. Every assignment in
P fails on a fast speed. Together with slow-row pruning, every one of the
N^2 proposed assignments fails the closed threshold. Hence it also fails
the forward target.

The same conclusion follows from a strict failure with real slopes: strict
inequalities for finitely many pairs persist in a sufficiently small common
neighborhood. Distinct rational slopes can be chosen there, since only
finitely many coincidences need be avoided. Adding an integer multiple of N
to any individual slope preserves every ideal phase and can make slopes
nonnegative and pairwise distinct. The rational construction above then
applies. This last observation transfers a supplied strict failure; it does
not assert one exists.

Conversely, this manuscript does not infer ideal failure from a finite-M
integer example, and does not infer actual two-digit success from ideal
closed success. A good phase at an endpoint may be spoiled by an arbitrarily
small positive correction. The transfer is deliberately one-way.

Verification here is hand algebra, finite minimum positivity, rational
density, and the elementary circle-norm Lipschitz inequality. No mathematical
program, numerical enumeration, external theorem retrieval, or Lean work was
performed to establish this conditional derivation.
