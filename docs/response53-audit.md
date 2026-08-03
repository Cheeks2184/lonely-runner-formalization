# Response 53 audit: formal rectangle bridge and critical-core tests

Status: **accepted after formal repair, with one stale conjectural label
rejected**. The elementary two-rectangle reduction, explicit conditional
cutoff, and C1--C5 core identities/tests are sound. None proves the exact
Gamma selector, coefficient two in every dimension, top-two, or unrestricted
Lonely Runner.

## Recovery and provenance

Prompt 53 was submitted in the signed-in Chrome conversation with GPT-5.6 Sol
and Pro explicitly selected. Its exact 7,469-character composer value has
SHA-256
`47aa4c0f5896d746eb6c67b90f9165032ab3aff342caf09da5776fb0ddd8c0f9`.

The recovered response has 20,750 raw PowerShell characters, 20,788 UTF-8
bytes, and SHA-256
`f15009c2ec0dc5d8cb69c78bc373ca513d54185a08451daac872930b2110a7a6`.
Its LF-normalized form has 19,760 characters, 19,798 UTF-8 bytes, 990 line
feeds, a final line feed, and SHA-256
`c39e5860fe4d7c7d6eef51aa424a6fd273038cea8dd5226db416f0852c74fd44`.

The attached `GammaRectangleCore.lean` has 9,960 bytes and SHA-256
`9f11e2a46ef58dd3275d818b925af1161cb4bed2a79c455f20e9e34d26ca46fe`.
The exact unmodified source is preserved under `research/sol-pro/artifacts/`.

## Accepted rectangle and cutoff mathematics

For `t>=16`, `2*t<=N`, `q=floor(t/4)`, `ell=2*q`,
`b=floor((N+t)/2)`, and

```text
a0=max(t-ell,b-2*ell+1),
```

the adjacent left intervals `C0,C1` of length `ell` cover every generic
candidate. The disjoint extra intervals `D0,D1` of the same length lie in
`(N,N+t]`. Every pair in `C0 x D1` and `C1 x D0` satisfies exactly

```text
N+t < c+d <= 2*N.
```

Consequently, coprime injections on the two cross rectangles splice into a
Gamma SDR for every actual generic subset. The proof preserves the strict
lower boundary and closed upper boundary.

If explicit Pomerance constants `(cP,XP)` were supplied, the response's
conditional inequality

```text
N>=max(46,XP),
N-8 > 12*cP*(log(3*N/2))^2
```

is sufficient for coefficient-two bounded height: the active branch gives
`q>= (N-8)/12`, while the ambient value is at most `3*N/2`. This is a
conditional effective theorem, not a numerical cutoff. Pomerance's published
proof first loses explicitness at Iwaniec's unspecified constant `c1`, then
uses further unspecified constants and sufficiently-large thresholds. See the
primary [Pomerance paper](https://arxiv.org/abs/2111.07157). No inherently
ineffective ingredient was identified, but no number follows from the paper
as written.

The reversal total `Q=N+a0+2*ell` gives another sound special class:
`c -> Q-c` cross-bijects the two rectangle pairs, and
`gcd(c,Q-c)=gcd(c,Q)`. It is therefore an explicit SDR whenever every actual
candidate is coprime to `Q`. The common-coprimality premise is not uniform.

## Lean audit and repair

The exact attached source did not compile. Against Lean/mathlib `v4.32.1`, it
reported

```text
line 108: `dsimp` made no progress
line 117: `dsimp` made no progress
line 128: `dsimp` made no progress
line 162: `dsimp` made no progress
line 180: `dsimp` made no progress
line 135: unused variable warning for `ht`
```

The five `dsimp` calls were redundant because `Finset.mem_Ico.mp` had already
reduced the interval definitions. Removing only those calls and renaming the
unused private hypothesis `_ht` produced the tracked
`CoefficientTwoRectangle.lean`. It compiles cleanly and proves:

- exact Gamma membership;
- generic-band coverage by `C0 union C1`;
- disjointness and extra-range inclusion of the right rectangles;
- both strict/closed cross sum bands;
- the conditional coprime-injection splice to an SDR.

All seven direct axiom probes report only `propext`, `Classical.choice`, and
`Quot.sound`. The module assumes supplied coprime injections. It neither
declares Pomerance's theorem nor proves those injections exist uniformly.

## Accepted critical-core tests

For a minimal deficient core with `m` left vertices, `m-1` right vertices,
`e` edges, pair energy `p`, and triple energy `q3`, the response correctly
proves

```text
p >= 2*e - 3*(m-1),
e^3 <= (m-1)^2*(e+6*p+6*q3).
```

These follow pointwise from right degrees and from Holder's inequality. The
Mobius discrepancy bound

```text
|coprimeCount(J,q)-|J|*phi(q)/q| <= 2^omega(q)
```

is also sound. Combining its lower degree bounds and upper pair-intersection
bounds with the first inequality gives the response's C3 criterion: whenever
the displayed explicit prime-support comparison is strict, the tested set
cannot be a minimal deficient core. Candidate conditions are not known to
force this comparison, so C3 is an exclusion test rather than a selector
proof.

Deletion-perfect matchings also give the stated alternating-path theorem:
the symmetric difference of matchings omitting two different left vertices
is one alternating path between them plus disjoint even cycles. The exact
`(N,t)=(6,3)` coprime edges show that arbitrary crossing edges cannot be
uncrossed after gcd filtering.

## Exact correction returned to Sol Pro

The final table's `ENERGY-EXCLUSION` label is stale. It is **rejected**, not
conjectural. At `(N,t,A)=(14,6,{6,8,9,10})`, every proper subset is Hall-good,
but `m=4,e=9,p=9` gives equality

```text
e^2=(m-1)*(e+2*p)=81.
```

The full set is Hall-good, so this is not a Gamma-selector or LRC
counterexample. The deterministic public Gamma audit now reproduces the row.

## Remaining gap

The exact Gamma Hall selector remains open. The new formulas can reject a
specific proposed core, but no proved inequality forces their hypotheses for
every candidate set. Graph minimality, interval monotonicity before gcd
filtering, pair/triple moments, and alternating paths still do not control the
synchronized prime supports across different candidates.
