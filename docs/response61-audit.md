# Response 61 audit

Response 61 studies minimal-counterexample height compression through
signed-divisor replacement. Verification task `VER-R61-AUDIT-005` accepts a
small collection of transport arguments on paper, rejects the naive
replacement rules, and freezes the exact height-compression route after a
mandatory artifact replay failure. No new Lean declaration or unrestricted
Lonely Runner result is accepted.

The audited repository base is
`d3b3f4966a4328b837e4df84eb138b48970a1a7e`. The public-safe runtime-routing
fingerprint is
`0210f54a540157b0fdfb2236c281028e20dc322ea6c2d2d57709a3ed06c076f5`;
it identifies the independently verified fresh Luna/xhigh route without
publishing a raw session identifier.

Audited source material is the tracked
[Response 61](../research/sol-pro/responses/response61.md),
[checker](../research/sol-pro/artifacts/prompt61_height_checker.cpp),
[manifest](../research/sol-pro/artifacts/prompt61_height_manifest.txt), and
[committed output](../research/sol-pro/artifacts/prompt61_height_sweep.txt).

## Mandatory artifact replay: FAIL / nonreproducible

The tracked artifact manifest requires:

```text
g++ (Debian 14.2.0-19) 14.2.0
-O3 -std=c++20 -march=native -DNDEBUG
AMD EPYC 9V74 80-Core Processor
```

The verification environment provides Ubuntu G++ `15.2.0`; `g++-14` and
`gcc-14` are absent. Substituting the available compiler would not reproduce
the declared build, so verification stopped instead of compiling a different
binary.

Even the exact compiler is insufficient for a stable portable artifact:
`-march=native` makes the generated binary depend on the host CPU, and the
program prints a `steady_clock` measurement as `runtime_microseconds`. Thus
the binary hash is host-sensitive and stdout is timing-sensitive by design.

Tracked provenance is:

- checker source SHA-256:
  `ab2aa75e019f407aa774ee65afb920a005be25a167db028828cb0e1aa6520084`;
- manifest SHA-256:
  `994cfe7e2762721a33a90cf14c2f61cbdf9bf86b4b29edfff16dd59158fc3d57`;
- committed output SHA-256:
  `8ed01720195b118e9a3b2b3b5e171c9f7076ca98ea572837dace3482feca5bc2`;
- claimed binary SHA-256 in the manifest:
  `693129b716678902980e7adb5bd026a7d3ab31e03c2dfa09c465a4b0b2c9ca6e`;
- claimed runtime: `5,896,358` microseconds.

The finite sweep is therefore committed computed evidence only and was not
replayed by verification. The sole residual tuple and its lack of an eligible
replacement are conditional on that unreplayed computation.

## Mathematical dispositions

The following are accepted as `proved-math` by inspection:

- existence of a least-dimension primitive counterexample selected by
  maximum, sum, and sorted lexicographic order, conditional on any
  counterexample existing;
- signed-congruence transport;
- coprime signed-divisor all-pivot transport;
- the common-period mixed-sign reformulation, which adds no scope beyond the
  signed-divisor operation.

Deletion gcd-one is conditional on the already verified codimension-one
divisor-insertion theorem. The transport argument was not compiled, so it is
`proved-math`, not `proved-lean`.

The following are rejected:

- direct subtraction `a -> a-N` with same-time lifting, by `(1,4,6)`;
- canonical fixed-pivot signed transport, also by `(1,4,6)`.

Replacement eligibility and `MinimalCounterexampleHeightCompression` remain
open. The only unresolved existential is: for a selected high counterexample,
find `b,q` such that

```text
0 < b < a,
b is not among the lower speeds,
a = q*b,
Coprime q N,
and for every lower speed x_i, N*x_i divides a-b or a+b.
```

Nothing in Response 61 derives that existential from minimality.

## Proposed Lean signature defect

The proposed local theorem takes `lower : Fin n -> Nat`, appends one speed,
and quantifies the resulting witness over `Fin (n+1)`, but leaves `N` as an
independent natural parameter. For a stationary tuple with `n+1` moving
speeds, contract fidelity requires the threshold denominator `N=n+2`.
Therefore a corrected signature must either assume `N = n + 2` explicitly or
replace every occurrence of `N` by `n+2`.

If the intended theorem is a genuine descent lemma rather than transport
alone, it must also assume `b<a`. Collision avoidance/injectivity of the
replacement belongs in the minimality application. With these defects
unrepaired and no compilation replay, the proposal is paper mathematics only,
not a Lean result.

## Freeze decision

Decision: **STOP and freeze this exact height-compression route**.

The only nonredundant replacement with a complete reverse-witness argument is
the coprime signed-divisor replacement, and the unreplayed finite evidence
reports that it applies to none of the tuples surviving the declared filter.
The remaining structural eligibility assertion is exactly the missing bridge;
assuming it as a minimal-counterexample property would be circular. The route
does not materially shorten the path to LRC and should not receive another
iteration without a genuinely new operation or a proof of the unresolved
existential above.
