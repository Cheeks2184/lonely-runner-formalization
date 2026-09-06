# Forward grid condition and exact commensurate insertion

Root manuscript candidate, 2026-09-06.
Source checkpoint: `600287d55a01d3c8c2d3bf4e4114eee4f9c1271e`.
Independent mathematical review required; no new program or Lean run.
This is an exact test of the proposed adapted grid, not an unrestricted
LRC result. It does not assert that every tuple satisfies the grid condition.

## Definitions and forward stability

Fix an integer N>=3 and m>=1 distinct positive integer speeds v_i.
Let L=lcm_i v_i, M=max_i v_i, D=N L. For assignments
k in {0,...,N-1}^m put

    g(k)=sum_i k_i/(N v_i).

All candidate times have denominator dividing D. Call k forward-good if

    fract(v_i g(k)) in [1/N, 1-1/N) for every i.       (F)

The lower endpoint is included and the upper endpoint is excluded. For
positive velocities this is exactly the condition that g(k) is a closed
target witness throughout some nontrivial interval immediately to its right.
At a lower boundary, increasing time moves into the good band; at an upper
boundary it immediately moves into the strict bad band. Interior phases
have positive slack. No independent phase shift has been added to a runner.

More precisely, for EVERY candidate k and EVERY common displacement

    0 < tau < 1/(D M),

we have the exact equivalence

    all i satisfy ||v_i(g(k)+tau)|| >= 1/N
        if and only if k is forward-good.             (1)

To prove it, write fract(v_i g(k))=r_i/D, with integer 0<=r_i<D.
Set a=L, so the closed good band is [a/D,(D-a)/D]. Every increment
v_i tau is positive and strictly less than 1/D. Therefore r_i<=D-1
ensures no phase wraps through 1 during this move. If r_i<a, the phase
cannot reach the lower good endpoint. If r_i>=D-a, it is already above
or moves strictly above the upper good endpoint. Conversely, if

    a<=r_i<D-a,

then r_i<=D-a-1 and the moved phase stays inside the good band.
This proves (1) coordinatewise, including every closed/half-open endpoint.
The same argument also shows that (F) provides a right interval of good
times, while a violated (F) cannot provide such an interval.

## Exact insertion of one sufficiently large commensurate speed

Let w be a positive integer multiple of D, with

    w > (N-1) D M / N = (N-1) L M.                   (2)

This implies w>M. The adapted grid on (v_1,...,v_m,w) consists of

    g(k)+ell/(N w),       0<=ell<N.

Since D divides w and D g(k) is integral, w g(k) is an integer.
The new phase at this time has fractional part ell/N. If ell=0 it is
strictly bad. For every 1<=ell<N it is closed-good, and (2) gives

    0<ell/(N w)<1/(D M).

Applying (1) proves, for every assignment, the exact characterization

    (k,ell) is a full closed-good assignment
        if and only if k is forward-good and 1<=ell<N.    (3)

In particular the number of full good assignments is exactly N-1 times
the number of forward-good old assignments. This counts assignments,
so it requires no injectivity of assignment-to-time maps.

An explicit admissible choice is w=D M=N L M: N>=3 makes
D M>(N-1)D M/N, and D M>M. Thus no asymptotic existence, unspecified
large constant, or numerical approximation is needed in this construction.

For the full adapted-grid conjecture at N total runners, take m=N-2.
Then a single old tuple with NO forward-good assignment produces an actual
N-1-speed tuple whose ENTIRE adapted N-grid misses the closed target,
by adjoining w=N L M. This would refute that candidate family, not LRC.
A separate actual witness or the relevant independently established LRC
case would distinguish those conclusions for a concrete control.

Conversely, if an old tuple has a forward-good assignment, (3) supplies a
full grid witness for every multiple w of D satisfying (2). The statement
does not cover arbitrary added speeds or prove the forward condition
for every old tuple. An unrestricted adapted-grid theorem would necessarily
imply the forward condition for every (N-2)-tuple, by this explicit embedding.

## A finite counting check in the range 2m<=N

There is a direct uniform source of forward-good assignments when 2m<=N.
On a coordinate fiber the phase advances by 1/N through an entire N-grid.
Exactly N-2 points lie in the half-open good band [1/N,1-1/N), regardless
of its translation. Hence the forward-bad count on EVERY fiber is exactly
two, including aligned fibers. Each label has 2 N^(m-1) bad assignments.

For the ordinary common-origin grid, the zero assignment is bad for all m
labels. Its overlap redundancy is m-1. Thus

    #forward-good >= N^m - 2m N^(m-1) + (m-1)
                  = (N-2m)N^(m-1) + m-1.             (4)

This lower bound is strictly positive for N>=3, m>=1 and 2m<=N.
If 2m<N the first term is positive; if 2m=N, then N>=4 and m>=2,
so the second term is positive. This proves the forward condition in that
range without a limiting argument, an extra alignment offset, or a program.

The phase-independent fiber count alone gives a strict inequality only
when 2m<N. At 2m=N the common zero assignment supplies the additional
saving. It cannot be used for arbitrary independently shifted phases.
The bound also holds for positive real frequencies with ordinary phases,
but the exact denominator-based equivalence (1)-(3) uses integer speeds.

For the necessary full-grid test m=N-2, this counting range covers only
N=3 and N=4. These are boundary controls of one uniform mechanism, not
new runner-count milestones. At larger N, (4) is not a positive supply
bound and must not be promoted into a forward-grid theorem.

## Proposed bounded verification and disposition

Before any implementation, independently review (1)-(4), especially the
strict displacement bound, no-wrap argument, excluded upper endpoint,
w=D M specialization, and assignment versus distinct-time counts.

After review, a useful exact falsification control can inspect the forward
condition directly, stopping at its first failure and adjoining w=D M.
This would test the structural obstruction without searching a large box
of arbitrary extra speeds. A positive finite test establishes only that
domain. No expansion, program execution, or new theorem is claimed here.

The unresolved mathematical input is a general forward-good assignment
for m=N-2, or an actual old tuple lacking one. Neither is supplied by the
new equivalence. No Lean implementation is queued without a uniform caller.
