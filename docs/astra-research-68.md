# Uniform grid constructions and a revisiting-repair obstruction

Pass67 merged through PR66 at
`737ac0634c02c21025bcafebacc97c9152f04bf4`. Both required CI jobs
passed, and fetched main contains the exact reviewed head and frozen files.
This pass develops the uniform adapted-grid investigation analytically.
It adds no Lean declaration and does not resolve unrestricted LRC.

The first construction works for any finite list of positive real
frequencies, even with arbitrary fixed starting phases. If every ordered
tail satisfies

    (N-1) sum_(j>i) v_i/v_j <= N-3,

choose each own digit to put its current phase in [1/N,2/N). The full
remaining digit budget moves that phase by at most (N-3)/N, preserving
the forward-good band [1/N,1-1/N). The strict upper bound remains valid
at equality in the tail condition. For N>3, successive speed ratios at
least `2+2/(N-3)` suffice. This supplies a uniform separated class,
including full N-1-speed tuples; it does not put every tuple in that class.

Local repair cannot simply replace the global preservation condition.
The reviewed one-pass counterfamily has an alternate forward-grid witness.
The new revisiting analysis goes further: it refutes the exact algorithm
that repeatedly repairs the least-index bad label, allowing revisits,
but never decreases or resets a digit and stops if a digit exceeds N-1.

For every odd N>=7, put C=N^4 and M=N^8. Use the speed 1, the speed M,
and speeds M+C+r for r in 1..N-1 except 2,4,6. These are N-2 actual
ordinary positive integer speeds. The first two repairs force the slow
digit to one and the M digit to at least one. A weighted-mean identity
proves that every bounded assignment in this entire region has a strictly
bad fast label, while the slow label remains good. The algorithm cannot
leave the region by repairing bad labels, so a finite digit budget must
eventually fail. This is an algebraic invariant-region argument, not a
sampled execution trace.

The same tuple has a forward-grid witness using slow digit (N-1)/2,
M digit one, and all other digits zero. Thus the result refutes the
specified algorithm, not forward-grid supply, the insertion equivalence,
or LRC. Allowing extra revisits under the same rules cannot fix the trap;
a different initial choice or a different mechanism is needed.

A root construction supplies such a choice for a whole narrow-cluster
class. Let N>=5, with speeds 1 and N-2 speeds M+c_i, where M is the
least fast speed, some c_i=0, all c_i>=0, and H=max(c_i). If

    M > (N-1) max(H,1),

two actual grid digits suffice: `t=k/N+ell/(N*M)`. A common residue
multiplier k and translation B put every c_i residue away from 0 and -1.
For prime N, two missing residues determine k and B. For composite N,
a proper divisor d>=3 gives k=d and B=1. Setting ell=B-k*M modulo N
realizes this common translation; no divisibility assumption N|M is
needed. The remaining phase errors are positive and below 1/N, so all
phases stay in [1/N,1-1/N).

The construction applies to fewer fast speeds as well, including the
entire repair-obstruction family. It also handles a distinct regime from
the separated-tail theorem: the largest two speeds of a sufficiently
narrow cluster violate that theorem's tail bound. Choosing the initial
slow digit from the common residue structure escapes the algorithm's
fixed-choice trap.

These classes still do not cover arbitrary tuples. For the previously
recorded N=7 control (1,6,10,21,84,85), the largest-two tail contributes
`6*84/85>4`, while its full fast cluster has M=6,H=79 and fails
`6>6*79`. It therefore satisfies neither new sufficient condition.
The earlier explicit witness 43/168 remains valid. This existing hand
control identifies the remaining gap in combined coverage; it is not a
new enumerated domain or a higher-count proof milestone.

All three manuscripts have independent source-bound Astra reviews and
root full reads. No new mathematical program, numerical search, domain
expansion or local Lean build is needed for these derivations. Checkpoint
verification binds frozen sources, reviews and documentation, validates
workflow records and whitespace, and records storage status. The canonical
N=6 theorem remains established. The unrestricted goal requires a mechanism
covering the still-unhandled arbitrary tuples, followed by formalization
and the full completion audit.
