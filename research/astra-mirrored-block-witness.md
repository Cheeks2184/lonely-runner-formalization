# Explicit witness for a mirrored consecutive block

Root Astra/high derivation, 2026-09-05. Source checkpoint:
`8db7eb32fb0aec5f1a62d18f93a72c5096d76743`.
Status: manuscript pending independent review and kernel formalization.
This is a structured, unbounded-count family, not unrestricted LRC.
No claim of literature novelty is made.

## Exact canonical family and witness

Let m>=1 and p>=2m+1 be integers. Consider the positive moving-speed set

    A = {1,...,m} union {p-m,...,p-1} union {p}.

The blocks are disjoint and positive; A has 2m+1 moving speeds, together
with stationary speed zero. Its exact canonical denominator is N=2m+2,
and put delta=1/N. Write p=N*k+r with 0<=r<N. Define

    if r>=m+1: t=1/N;
    if r<=m:   t=(N*k+1)/(N*(p-m)).

Then t>0 and every a in A has ||a*t||>=delta. All divisions in this
statement are rational/real; p-m is positive. There is no supplied smaller-
tuple witness, no count minimality and no failure premise.

## A sufficient phase cell

It suffices to exhibit an integer k and real y satisfying

    delta <= t <= 2*delta,
    p*t=k+y,
    m*t+delta <= y <= 1-delta.                                  (1)

For 1<=i<=m, the low phase i*t lies between delta and
2*m*delta=1-2*delta, hence in [delta,1-delta]. The high phase satisfies

    (p-i)*t = k+(y-i*t),
    delta <= y-i*t <= 1-delta.

Indeed its lower bound follows from y>=m*t+delta and i<=m, while its
upper bound follows from y<=1-delta and i*t>=0. Finally y itself is in
[delta,1-delta]. All displayed representatives therefore lie in the
closed unit good band, proving (1) sufficient for every original speed,
including p. No modulo representative is guessed or silently wrapped.

## Constructing the phase cell

In the first case r>=m+1 choose t=delta and y=r/N. Then

    p*t=k+y,
    m*t+delta=(m+1)/N=1/2 <= y <= (N-1)/N=1-delta,

so (1) holds.

In the second case r<=m, define

    Delta=(m+1-r)/(N*(p-m)),
    t=delta+Delta.

Since p-m>=m+1 and 0<m+1-r<=m+1, we have
0<Delta<=delta, and therefore delta<t<=2*delta. Also

    (p-m)*Delta=(m+1-r)/N,
    p*t=k+r/N+p*Delta
       =k+(m+1)/N+m*Delta
       =k+m*t+delta.

Set y=m*t+delta. Its lower bound in (1) is equality, and

    y <= 2*m*delta+delta = (2m+1)/N = 1-delta.

This proves (1). The stated rational formula follows from

    delta+Delta=(p+1-r)/(N*(p-m))=(N*k+1)/(N*(p-m)).

The integer k here is the quotient floor(p/N) from the start. In both
cases delta<=y<=1-delta<1, so it is also the integer part of p*t.
There are no hidden parity, divisibility, prime, or bounded-height
hypotheses. Equality in p>=2m+1 and the closed distance bounds is allowed.
At p=2m+1 the two blocks and p form the consecutive family 1,...,2m+1,
and the first case gives its usual time 1/N.

## Scope relative to the complement route

The construction adapts the p-phase and controls each original low and
high speed directly. It does not infer that an arbitrary witness of a
complemented tuple can be reused. The crucial extra structure is that all
low speeds lie in the consecutive block 1,...,m; the phase cell in (1)
uses the same m that determines the canonical runner count.

For arbitrary sparse low speeds, replacing m by their maximum changes the
phase-cell inequalities without changing the count. The proof therefore
does not extend automatically to such tuples. Nor does it cover unpaired
old speeds or arbitrary dense all-covered instances. A smaller subfamily
inherits only the displayed threshold unless its stronger canonical
threshold is independently established.

The theorem is a positive test of explicit phase adjustment for an
unbounded structured family. It is not a new exclusion of every least
counterexample, a proof of the endpoint candidate, or a formalized proof
of unrestricted LRC. The full project's completion gate remains unchanged.
