# Two-even assembly handoff outline

Root extraction of the already reviewed manuscript section7, to be converted
into an exact implementation plan after unsigned and signed6.1/6.4 compile.
This is not a kernel result or a fresh geometric conjecture.

Use positive Fin5 speeds, a six-divisible pivot p and a distinct unique other
even label q; all other labels are odd, and all labels other than p are
nondivisible by3. Repeated speed values remain allowed. Assume no all-real
closed1/6 witness and obtain the existing all-real complement maximum tau,
pivot phase m in (0,1/6), and actual distinct upper-face label r at5/6.

If r is odd, its unit residue sigma=+-1 gives t'=tau+sigma/6 with r phase0
and unchanged pivot phase. Reindex the remaining three labels with q at index0
(weight2), the other two with weight1; residues are independent signs times
these weights. Apply signed6.1, reflected exactly when sigma=-1. The closed
a2..5,b1..5 alternative makes all four complement labels safe at s=a*t'+b/6;
write s=a*tau+(a*sigma+b)/6 with INTEGER numerator and invoke reciprocal
improvement. The strict alternative uses b1..4 if sigma=1 or b2..5 ifsigma=-1,
so r's actual phase lies in {1/6,1/3,1/2,2/3}, strictly below5/6. Every other
complement phase is strictsafe and pivotphaseunchanged, so forward improvement
contradicts the maximum.

If r=q is even, normalize each of the other three odd phases at tau by its
unit sign and apply the signed initially-safe6.4 theorem. For q write residue
e=2*sigma, sigma=+-1. Its actual new phase is fract((5*a+e*b)/6).
- Strict doubling a2,b0 gives qphase2/3 and pivotstrictimprovement.
- Strict a1,b1or5 gives qphase1/6or1/2, hence forwardimprovement with unchanged
  pivotphase and all four complement phases strictly below5/6.
- Closed a3or5,b0..5: integer5*a+e*b is odd, so modulo6 it is1,3or5; qclosedsafe,
  and reciprocalimprovement applies with a>=2,a<6. Preserve b=0.

The required helper proofs are actual affine-time norm/fract transport,
unit/even residue extraction, finite label reindexing with q at first position,
those bounded qface scalar facts, and positive-time conversion. Reuse the
OneEvenRunners proof pattern but its private helpers are not public APIs.
Do not weaken either strict alternative or replace actual phases by folded
norms. Final cardinality adapter uses unique3divisibility and evencount2;
under hno the small-denominator cover can derive the six-divisible pivot.

## Frozen inputs

- `research/astra-one-three-divisible-plan.md` `9da230600af3a0a0bc8223de3daca2575f8d41f447142687ca64db53ced4ae9e`
- `LonelyRunner/OneEvenRunners.lean` `5bf5f01d7b31b410b680d646a832b273890cc267dc7a4775fea37eac5c58b810`
- `LonelyRunner/SixthAffinePhase.lean` `76e420713079ec0c3979e9b169cd78ecb6a932d6dc790ea7d9711adbb64b7d4b`
- `LonelyRunner/OneSixthComplementMaximizer.lean` `5a7011ca680b8a2b26c7bad466a8ee4008cf47507eb8b700846f296894bb90a1`
