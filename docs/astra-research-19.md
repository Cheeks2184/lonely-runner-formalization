# Nineteenth Astra checkpoint: grid transport and induction limits

The full unrestricted Lonely Runner Conjecture remains unresolved. This pass
formalizes quantitative transport of a supplied witness to an actual pivot
grid, and audits which parts of a smaller-count induction it can support.

## Kernel-checked transport

`LonelyRunner.exists_nearestPivotGrid_residue` in
[`NearestPivotGrid.lean`](../LonelyRunner/NearestPivotGrid.lean) takes positive
natural pivot `p`, denominator `N>=2`, a finite family of natural speeds,
and a supplied real witness with margin `alpha`. It requires

```text
alpha > 1/(2N),
1/N <= alpha - d_i/(2Np)       for every listed coordinate.
```

It produces a natural residue below `Np`, not divisible by `N`, protecting
the pivot and every listed coordinate at the closed threshold `1/N`.
The proof rounds the signed real `Npt`, excludes forbidden multiples using
the original pivot margin, and reduces modulo `Np` using integer periodicity.
Coordinates need not be distinct, positive, or below the pivot; their witness
and margin hypotheses remain explicit. This theorem supplies no ordinary
LRC witness by itself.

## What induction supplies, and what it leaves open

The [nearest-grid manuscript](../research/astra-nearest-grid-induction.md)
keeps the count explicit: `c` lower speeds plus the pivot have `c+2` total
runners, including the stationary runner. From a supplied `1/(c+2)` witness,
the nearest-point criterion is `2Np >= (c+2)(2p+q)`, with largest lower speed
`q`. Choosing between adjacent grid points improves this to
`p(N-c-2)(q+s) >= (c+2)qs`, with the two largest lower speeds `q>s`.
These stronger count statements are manuscript results, not additional Lean
declarations in this checkpoint.

In a hypothetical least-count positive-integer counterexample, smaller-count
LRC supplies those witnesses for proper subfamilies. This rules out sparse
complete covers with `2c<N`. It does not supply a witness for the full set
of owners plus pivot: that would reuse the original count circularly.
Dense all-covered configurations remain the unresolved case.

The [dense manuscript](../research/astra-dense-pivot-induction.md) gives a
separate sufficient insertion test from a supplied stronger witness for the
old speeds. For each distinct old pair, define

```text
D_N(a,b) = N*gcd(a,b)*ceil((a+b)/((N-1)*gcd(a,b))) - a - b.
```

The inequalities `p*D_N(a,b) >= 2ab` for every pair suffice to insert the
fastest speed `p`. Closed component endpoints and the gcd constraint yield
this test. Its harmonic corollary has a strict-inequality precedent in
[Algebraic strengthening of lonely runner conjecture, PDF page 2](https://rxiverse.org/pdf/2509.0023v4.pdf);
this pass makes no novelty claim for that mechanism. These insertion results
remain at independently reviewed manuscript scope.

## A precise obstruction to local induction

For `N=7` and speeds `(1,4,5,6,7,11)`, all four components of the old `1/7`
good set that contain any old `1/6` witness lie strictly within an open bad
interval of speed `11`. Exhaustive selection among stronger old witnesses,
followed by movement within their entire old-good components, therefore fails.

The full tuple nevertheless has exactly two closed witness intervals in one
period: `[15/49,13/42]` and `[29/42,34/49]`. Neither meets the stronger old
witness set. This refutes that component-following strategy, not LRC.
The original covered labels are exactly `{1,4,5,11}`; speeds `6,7` are
noncovered and cannot be treated as internal owners. The actual internal
owner set leaves 22 candidates safe at pivot `11`.

## Verification and next step

The complete source build passed 3,616 jobs; the trust audit accepted 370
theorem reports. The new declaration uses only `propext`, `Classical.choice`,
and `Quot.sound`. All 58 focused workflow, storage, ledger, and trust tests
passed. Both author reproduction blocks and the independent dense review's
boundary-cell inventory passed root replay. Root also checked 4,362 insertion
instances, 2,638 determinant component bounds, and 59,964 two-neighbor grid
instances with exact rational arithmetic; these are supporting controls,
not exhaustive claims about arbitrary speeds.

Both the [dense independent review](../research/astra-dense-pivot-review.md)
and [nearest independent review](../research/astra-nearest-grid-review.md)
accepted their frozen artifacts. The latter also compiled the entire fresh
Lean source with five full-contract applications and three kernel residue
controls; root replay passed. Exact hashes, domains, commands, and dispositions
are recorded in [the verification record](../research/astra-pass19-verification.json).

Further research must explain relations between original covered pivot rows,
or justify reaching good components absent at the stronger induction
threshold. Neither the conditional grid transport nor the insertion criteria
provide that unrestricted step. The full canonical completion gate is unchanged.
