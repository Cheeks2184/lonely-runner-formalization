# Response 54 audit: matching dependencies and reversal totals

Status: **accepted after formal replacement and correction of one logical
wording**. The fixed-matching theorem, feasible-start arithmetic, fixed-total
reversal theorem, and endpoint prime-cover lemmas are sound at their exact
strength. The supplied Hall file does not compile. Exact Gamma Hall,
coefficient two in every dimension, top-two, and unrestricted Lonely Runner
remain open.

## Recovery and provenance

Prompt 54 was submitted in the signed-in Chrome conversation after Windows UI
Automation exposed both the `GPT-5.6 Sol` submenu radio and the `Pro` radio as
selected. Its exact 8,056-character, 8,064-byte composer value has SHA-256
`fbea371dddaa09182fec59078e958e635c63bd158b8516d52b1613ebd69cf85a`.

The recovered response has 24,549 raw PowerShell characters, 24,615 UTF-8
bytes, and SHA-256
`d005a9359849dab9dc519a617999b2924f191c9ee3a1c6f3eb5f2aacfa5e1290`.
Its LF-normalized form has 23,590 characters, 23,656 UTF-8 bytes, 959 line
feeds, a final line feed, and SHA-256
`f705be255c8485ca3bbf6f0954c2932dd86405d6ed9d0861b6473c19172c2bb1`.

The two downloaded attachments are:

- `HallDependency.lean`: 6,653 bytes, SHA-256
  `267a5fbec1898ac53d49c4e86f9a4b0f776abc91a76224845256930abdd21722`;
- `GammaRectangleReversal.lean`: 5,572 bytes, SHA-256
  `425bf751229bd0ae52412f95ad0a1316c82f4d0cd8341e3d64fbdec7de72e189`.

The exact Hall source is preserved under `research/sol-pro/artifacts/`. The
exact reversal source compiled unchanged and is tracked as
`CoefficientTwoReversal.lean`; its original attachment hash is therefore also
the tracked module's source hash.

## Compiler audit

The untouched `HallDependency.lean` attachment fails against Lean/mathlib
`v4.32.1`:

```text
line 45: failed to synthesize DecidableEq R
line 53: failed to synthesize DecidableEq R
line 142: `push Not` made no progress at hnot
```

The elaborator consequently reports generated declarations using `sorry` at
lines 61 and 108, even though the source contains no literal `sorry` token.
There are also unused-variable/linter warnings. This file is compiler-targeted
output, not formal evidence.

An independent implementation, `MatchingDependency.lean`, states the same
fixed-matching equivalence with explicit finite/decidable instances. After
removing only unused-section-variable warnings, it compiles cleanly. Its two
main declarations are:

```text
tight_iff_successorClosed_and_avoidsBad
strictHall_iff_every_vertex_reaches_bad
```

Both direct probes report only `propext`, `Classical.choice`, and
`Quot.sound`.

The untouched `GammaRectangleReversal.lean` attachment compiles successfully.
Its final theorem, now `rectangleReversal_gives_sdr`, assumes exactly that
each actual generic candidate is coprime to the one fixed reversal total and
returns an injective selector into the exact strict/closed Gamma
neighborhoods. It neither assumes nor proves a uniform coprime matching
theorem.

## Accepted dependency mathematics

Fix an injective left-saturating matching `M`. Direct `x` to `y` when `x` sees
the right vertex matched to `y`, and mark `x` when it sees a globally
unmatched right vertex. A finite left subset is tight exactly when it is
successor-closed and contains no marked vertex. Strict Hall for every
nonempty subset is therefore equivalent to every left vertex reaching a mark.
The empty subset is correctly tight in the first theorem and explicitly
excluded in the second.

The response's partial-matching augment-or-deficiency proof is also sound as
a reachability dichotomy. The phrase “exactly one” is too strong if read as
mutual exclusivity of the two existential conclusions: an augmenting path
from the current vertex does not exclude a different deficient subset
elsewhere. What is proved is that the current reachable set yields an
augmenting path when it reaches a mark, and yields a deficiency-one set when
it does not.

The proposed stronger completed-greedy reachability claim is correctly
refuted at `(N,t)=(20,10)`. Independent direct reconstruction gives the exact
candidate rows `10,...,15` displayed in the response. Under its matching,
`{12,14}` has the common neighborhood `{23,25}`, is successor-closed and
mark-free, and neither vertex reaches a mark. This is not a Hall failure:
the full graph has a saturating matching. It shows that a fixed completed
matching can contain tight dependency blocks.

## Accepted feasible-start and reversal mathematics

For an arbitrary start `s`, generic-band coverage and the two exact crossed
sum bands are equivalent to

```text
s <= a,
b < s+2*ell,
t <= s+ell,
s+3*ell <= N+1,
2*ell <= t.
```

Thus the complete feasible interval is

```text
max(t-ell,b+1-2*ell) <= s <= min(a,N+1-3*ell).
```

Natural subtraction is harmless under the displayed guards. The tracked
`rectangleA0` is the least feasible start. For every feasible `s`, the total
`Q_s=N+s+2*ell` reverses the two left rectangles onto the crossed right
rectangles, and `gcd(c,Q_s-c)=gcd(c,Q_s)`. A single total coprime to every
actual candidate therefore gives an SDR.

Only the least-start fixed-total theorem is Lean-verified in this checkpoint.
The complete variable-start interval is audited manuscript mathematics. The
remaining `DIAGONAL-HALL` claim for combining several totals is open; maps
from different totals can collide exactly when `c'-c=Q'-Q`.

Boundary checks retain `t=16`, `2*t=N`, every remainder modulo four, strict
failure at `c+d=N+t`, allowed equality at `c+d=2*N`, and disjoint adjacent
right rectangles.

## Accepted endpoint-strip consequences

For a minimal deficient core, an endpoint strip belonging only to the least
candidate is coprime-free for that candidate. The exact prime-divisibility
union bound gives

```text
length <= sum_(p|c) number of multiples of p in the strip.
```

Hence, when `sum_(p|c) 1/p < 1`, the strip length is at most
`omega(c)/(1-sum 1/p)`. Prime-power endpoints force length one, and if every
prime divisor exceeds the strip length then the length is at most `omega(c)`.
These are sound local exclusions. Candidate conditions do not yet force an
endpoint strip to overload its prime cover.

Deletion matchings also give the stated alternating coprime chains. The first
unproved synchronization step is still to extract a monotone chain, common
reversal total, private neighbor, or two-hole witness from every such path.

## Remaining gap

The new graph theorem makes a fixed matching audit efficient but does not
construct the missing uniform arithmetic matching. Subsequent exact search
refuted `DIAGONAL-HALL` at `(N,t)=(36,16)`: all seven actual candidates have a
feasible reversal-diagonal neighbor, but `{20,22,24}` has neighborhood
`{41,43}`. The full Gamma graph has an explicit SDR, so non-diagonal Gamma
edges are essential. `GAMMA-AUGMENT` and `ENDPOINT-OVERLOAD` remain open. No
result in Response 54 or this counterexample proves exact Gamma Hall,
coefficient two for every dimension, top-two, or unrestricted LRC.
