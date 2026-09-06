# A uniform adapted-grid witness for one unit speed and a narrow fast cluster

Root manuscript candidate, 2026-09-06. Source checkpoint
`737ac0634c02c21025bcafebacc97c9152f04bf4`.
Independent review required. No program or Lean invocation supplies this proof.

Let N>=5 be an integer. Consider N-1 distinct positive integer speeds

    1, M+c_1, ..., M+c_b,    b=N-2,

where M is the least fast speed, one c_i=0, all c_i>=0, and H=max_i c_i.
Assume

    M > (N-1) max(H,1).                              (C)

There is a witness in the ordinary adapted N-grid whose fractional phases
all lie in [1/N,1-1/N). Only the digits of speeds 1 and M need be nonzero.
This is a sufficient uniform class, not a reduction of arbitrary tuples.

## A finite residue lemma

For every R subset of Z/N containing zero and having cardinality at most
N-2, there exist k in {1,...,N-2} and B in Z/N such that

    k*r+B is neither 0 nor -1 for every r in R.       (R)

If N is prime, choose two distinct missing residues a,b. They are nonzero
because zero belongs to R. Put k=(a-b)^(-1) and B=-k*a modulo N. Then
the unique preimages of 0 and -1 are a and b, respectively. Swapping a,b
negates k. At least one of k and -k is different from -1 since N>=5;
choose that orientation. Its representative is in {1,...,N-2}. Because
zero is in R, B itself is neither 0 nor -1.

If N is composite and N>=5, it has a proper divisor d with 3<=d<=N-2.
Indeed a nontrivial factorization N=a*b with 2<=a<=b gives b>=3, except
for N=4; also b<=N/2<=N-2. Set k=d and B=1. Every residue k*r+B is
one modulo d, whereas 0 is zero modulo d and -1 is d-1 modulo d. Since
d>=3, neither forbidden residue can occur. This case does not require
the cardinality bound on R.

These two cases prove (R). No assertion about simultaneous independent
phase choices is involved: k and B are common to the entire residue set.

## Realization by two actual grid digits

Take R to be the residues of the c_i modulo N. It contains zero and has
at most b=N-2 elements. Choose k,B by (R), and let ell in {0,...,N-1}
be the representative of B-k*M modulo N. Set

    t = k/N + ell/(N*M).                             (T)

This is an actual adapted-grid time, using digit k at speed 1, digit ell
at speed M, and zero at all other speeds. It remains so when ell=0.

For a fast speed M+c_i, its phase is

    (M+c_i)*t = [k*M+k*c_i+ell]/N + c_i*ell/(N*M).

The residue of the bracketed integer is k*c_i+B, so (R) places its
representative q_i in {1,...,N-2}. Its remaining increment e_i obeys

    0 <= e_i <= H*(N-1)/(N*M) < 1/N,

where the strict inequality follows from (C). Thus

    1/N <= q_i/N+e_i < (N-1)/N < 1.

There is no wrap, and this is the actual final fractional phase. This
includes the anchor c_i=0 and both ell=0 and ell=N-1. The upper target
endpoint remains excluded; the lower endpoint is included.

For speed 1, condition (C) also gives M>N-1. Hence

    1/N <= k/N <= t < (k+1)/N <= (N-1)/N < 1.

This is the required forward phase for the remaining label. Consequently
all N-1 speeds have circle norm at least 1/N at the same grid time.
No assumption that N divides M or any c_i is needed.

## Scope and relation to the failed repair route

The proof also works with fewer than N-2 fast speeds, keeping N as the
target denominator. Therefore it can supply old forward assignments in
the m=N-2 commensurate-insertion setting as well as full N-1-speed
witnesses directly. The stated full-arity version has a genuine ordinary
integer-speed caller under (C); no arbitrary-arity LRC conclusion follows.

The proposed revisiting-repair obstruction uses one unit speed and a fast
cluster with M=N^8 and offsets zero or N^4+r, r<N. It satisfies (C),
because (N-1)*(N^4+N-1)<N^8 for N>=5. Thus this residue argument
supplies a separate forward grid witness for that entire sufficiently
large cluster class. It does not validate the revisiting algorithm or
prove that its fixed initial slow digit can work. The precise repair
obstruction remains a separate manuscript requiring independent review.

This class is not supplied by the reciprocal-tail greedy theorem at full
arity. The two largest fast speeds have ratio at least M/(M+H). From
M>(N-1)H we obtain H/M<1/(N-1), so

    M/(M+H) > (N-1)/N > (N-3)/(N-1).

The last comparison is equivalent to N+1>0. Therefore the penultimate
speed's one-term tail already violates that theorem's required bound.
The new construction addresses a distinct narrow-cluster regime by choosing
the initial slow digit with the residue set in view.

The remaining gap is general positive integer tuples, including those
without a unit speed or without the narrow-cluster condition. This theorem
does not supply a partition, induction or normalization that puts them in
this class. No Lean implementation is queued without a broader uniform use.
