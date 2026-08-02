# Response 47 audit

Status: independently audited on 2026-08-02. Nothing here proves or
disproves unrestricted LRC.

## Kanold status correction

Response 47 still labelled the algebraic Kanold argument `proved-math` and
offered an alternate compiler-targeted subset-injectivity module. That status
was already stale when the response completed. The independent tracked
module `LonelyRunner/KanoldVandermonde.lean` compiles the full interval proof,
not only subset injectivity, and proves

```lean
kanoldIntervalBound_vandermonde : KanoldIntervalBound
```

The exact half-open interval, positive-modulus hypothesis, arbitrary natural
start, `c=1` case, and `start=0` case survived independent adversarial review.
The resulting `seventeenThirdsHeight_family_witness` is unconditional and
fully Lean-verified. Response 47's alternate uncompiled module is not used.

## Coefficient-five bounded-height theorem

Response 47 strengthens the height hypothesis from `17*t<=3*N` to
`5*t<=N`. The argument is now fully assembled in
`LonelyRunner/CoefficientFiveHeight.lean` and is `proved-lean`.

Under `5*t<=N`, `2*c<=N+t`, and `ell=N-c-t`, the response proves that

```text
ell < 2^omega(c)
```

can occur only at

```text
(N,t,c) = (5,1,3), (10,2,6), (11,2,6).
```

For `c>=7`, except `c=10`, it uses
`3*2^omega(c)<=c`. If `c<=3*t`, then
`ell>=4*t-c` and `3*ell>=c`; if `3*t<=c`, then
`ell>=c-2*t` and again `3*ell>=c`. The modulus `c=10` is checked directly.
For `c<=6`, the exact values of `omega(c)` leave only the three triples
above. The arithmetic and natural-subtraction guards passed independent
audit.

The exceptions are repaired at the family level:

- At `(10,2,6)`, `q=19` lies in the required interval and is coprime to 6.
- At `(5,1,3)`, if speed 6 is absent, `1/3` works. If it is present, only
  three speeds lie in `[1,5]`, so there is a second missing `d!=3`; the
  reciprocal-or-Kanold selector succeeds for `d`.
- At `(11,2,6)`, if neither 12 nor 13 occurs, no selected speed is divisible
  by 6 and `1/6` works. If either occurs, at most nine selected speeds lie in
  `[1,11]`, so there is another missing `d!=6`; the selector succeeds for
  `d`.

No uniqueness, minimality, or special choice of the initial missing modulus
is used. Lean kernel-checks the exception classification in
`five_short_interval_exception_classification`, the cardinality bridge in
`exists_second_missing_of_extra_speed`, the generic branch in
`five_witness_or_exception`, and the final assembly in
`fiveHeight_family_witness`. Its axiom report contains only `propext`,
`Classical.choice`, and `Quot.sound`.

Response 48 later supplied a separate compiler-targeted module, but the exact
attachment failed with unresolved `c=8`, `c=9`, maximal-prime, multiplication-
order, and exception-branch goals. The verified project theorem is the
independent tracked implementation, not that attachment.

## Saturated top-two class

For `N>=4`, `A=N-2`, and `B>A`, Response 47 proves on paper that the tuple

```text
(1,2,...,N-2,B)
```

has a safe canonical residue at one of its two largest speeds. The three
explicit cases are:

1. If `N` does not divide `B`, use pivot `A` and numerator `r=A`.
2. If `N|B` but `N*A` does not divide `B`, write `B=N*k` and use pivot `A`
   with `r=N-1`.
3. If `B=N*A*k`, use pivot `B` and `r=(N-1)*N*k-1`.

Direct modular inequalities verify every lower speed and the other top speed
in all three cases. This is an infinite `proved-math` class, not the global
top-two conjecture and not unrestricted LRC. Formalization remains open.

## Recovered computation

The recovered verifier's source SHA-256 is
`a7e7a302aabfb1a57b4a26d004459a58ea05727b8e11969bcefa8ca24b6d2703`.
Its output SHA-256 is
`19ffaeeb20fec5ed27bae8c84a9cf2fdb9025094be0a4ae244c5e20c1bdf2161`.
It checks 36,601,650 admissible height triples through `N=1000`, reproduces
the three exceptions and endpoint table, and checks 15,818 saturated-class
instances. These are regression checks for the manuscript proofs, not
uniform proofs themselves.

Reproduce with:

```bash
bash scripts/audit_response47.sh
```

## Remaining frontier

The unrestricted top-two pivot statement and uniform positivity of the full
Chebyshev/CRT score remain conjectural. Response 47 supplies neither an exact
top-two counterexample nor a signed cross-pivot inequality.
