# From the mirrored-block witness to every chosen runner

Root Astra/high, 2026-09-05. Source:
`8db7eb32fb0aec5f1a62d18f93a72c5096d76743`.
Status: manuscript extension pending independent review and formalization.
Dependency: the designated-zero theorem in `astra-mirrored-block-witness.md`,
SHA256 `70b5545b8b7af311324967c7272a07f8d714eeabac2b21c381ae168326847e21`,
accepted independently in `astra-mirrored-block-review.md`.

Let m>=1 and p>=2m+1 be integers, and let the full speed configuration be

    T = {0,...,m} union {p-m,...,p}.

The two blocks are disjoint, each has m+1 elements, and |T|=N=2m+2.
Write delta=1/N. For each chosen r in T, there exists a positive real time t
such that for every s in T with s!=r,

    ||t*(s-r)|| >= delta.                                       (1)

This is the ordinary all-chosen-runner LRC statement for this particular
unbounded family. The witness may depend on r. It is not one common time
at which all runners are simultaneously lonely, and is not an assertion
about an arbitrary speed configuration.

## A runner in the lower block

First suppose 0<=r<=m and put P=p-r. Then P>=p-m>=m+1.
For s in the lower block, s!=r gives

    1 <= |s-r| <= m.

For s in the upper block we have s>=p-m>=m+1>r, so

    P-m <= s-r <= P.

There are two cases.

If P<=2m+1=N-1, every nonzero relative absolute speed above lies in
{1,...,N-1}, since m<P. The time t=1/N therefore gives a closed good
representative |s-r|/N in [delta,1-delta]. Reversing a real phase does not
change its circular norm, so signed relative differences satisfy (1).

If P>=2m+1, apply the accepted designated-zero theorem with parameters
m,P. It supplies a positive time good for every speed in

    {1,...,m} union {P-m,...,P}.

All the relative absolute speeds just identified lie in this set. Its
threshold is the same delta, determined by the original m. Therefore the
same time satisfies (1). At equality P=2m+1 both cases give valid witnesses.
No smaller-count strengthening is inferred from repeated absolute relative
speeds: only their membership and the unchanged original threshold are used.

## A runner in the upper block

If p-m<=r<=p, reflect the full speed configuration by s -> p-s. This
reflection exchanges its two blocks, maps r to r'=p-r in {0,...,m}, and is
an involution on T. It preserves distinctness and

    |(p-s)-(p-r)|=|s-r|.

Apply the lower-block result to r'. Its time satisfies (1) for the original
r as well, because circular distance is unchanged by negation. This is an
explicit chosen-runner argument, not the invalid assertion that a witness
for one chosen runner proves loneliness of another without a symmetry.

## Explicit per-runner witness

A deterministic construction is:

1. Set u=r when r<=m, otherwise u=p-r. Then 0<=u<=m.
2. Put P=p-u. If P<=2m+1, use t=1/(2m+2).
3. Otherwise use the accepted mirrored-block formula at m,P.

All real divisions, quotient/remainder arithmetic and closed boundaries
are inherited from the accepted formula. The construction is independent
of any induction hypothesis or prior smaller-tuple witness. It supplies
an exact canonical threshold for every chosen runner of the stated T.
A finite enumeration of T can translate (1) directly into the project's
labelled relative-speed formulation; cardinality and injectivity remain
explicit formalization obligations, rather than assumed API behavior.

The required new formal work is a bridge from the designated-zero witness
and the bounded consecutive relative-speed case, with sign invariance,
reflection membership, and |T|=2m+2 checked. No statement about all runner
counts and all real speed assignments follows from this family theorem.
