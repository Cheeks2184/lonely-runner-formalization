# Independent review of the ordinary centre-preserving projection audit

Reviewer task `/root/center_preserving_projection_review`, requested
Astra/xhigh. Assignment checkpoint:
`01961736f5c07af8d2f7d4cb9397553f0baa284e`.
Author task `/root/center_preserving_projection_audit`; author baseline:
`ca9d2d7f20f66cceb7db3b440d0378203624aa39`.

**Verdict: accepted at the stated manuscript scope, without corrections.**
The complete frozen author file is
`research/astra-center-preserving-projection-audit.md`, SHA-256
`0efe2d8bfb272f194249e6201491a64165d6a102900a71c8953618253f18c60e`.
Its exact fibre and parity statements are sound. Its integral affine
cube-rigidity theorem excludes the specified pointwise lifting mechanism
at every lower moving count `2<=m<d`, and excludes smaller-sum descent
within that class at equal primitive moving count. Neither approach proves
ordinary witness supply, a smaller counterexample, or unrestricted LRC.

## Primary sources and count conventions

I independently retrieved MSS's publisher HTML and read Definition 1.4,
Proposition 1.5, Theorem 3.1 and its proof, and section 3.2 through Lemma
3.6. Its `n` counts moving speeds: here `n=d=N-1`, the original zonotope
dimension is `d-1`, and the projected dimension is `d-2`. Theorem 3.1
retains the centre modulo the image lattice. Equations (3.7) and the final
calculation in Lemma 3.6 use `4/[d(d-1)]` as the first-minimum bound,
and give fibre length at least `4/[d(d-1) lambda_1(K)]`. These belong to
ordinary LRC's specified central coset. The covering-radius statements
for arbitrary translates have stronger hypotheses and are not used.
[MSS, published article](https://www.cambridge.org/core/journals/forum-of-mathematics-sigma/article/linearly-exponential-checking-is-enough-for-the-lonely-runner-conjecture-and-some-of-its-variants/A51A991DE89B8C9C2E2FF13FBD4501DA).

I also read Beck--Schymura version 1, Theorem 1, Propositions 4 and 8,
and section 3 including Proposition 9. The central norm parameter `r`
corresponds to asymmetry `(1+r)/(1-r)`, so `r<=(d-1)/(d+1)` gives
asymmetry at most `d`. Passing through the quotient by the velocity line
preserves this interpretation. Their general lattice-zonotope bound has
order `d log log d`; it does not supply that sharp estimate. The author
does not substitute the finite cube-plus-velocity zonotope for the whole
zonohedron, or count all interior points as points of the contracted body.
[Beck--Schymura, version 1](https://arxiv.org/html/2301.12182v1).

The following checks are independent algebra on the author's exact
contracts. No geometric reformulation or method obstruction is promoted
as a new literature theorem or a proof of the conjecture.

## Original lattice, centre and minimality

For primitive positive integer `v`, extend its primitive integer direction
to an integer basis. The quotient `Z^d/Zv` is free of rank `d-1`, and
its real span identifies the image lattice `Lambda` in `R^d/Rv`.
Thus the author's use of the image lattice is essential and correct.
For a lattice-surjective matrix representing this quotient, the cofactor
kernel vector is primitive, hence equals `v` up to sign. The zonotope
volume in this lattice is consequently the sum of the positive speeds.
Changing an ambient lattice index would change this volume normalization.

With `c=U(1_d/2)` and `beta=(d-1)/(d+1)`, a point of
`beta U(C_d) intersect(c+Lambda)` has a representative

    y=1_d/2+z+t v in beta C_d,       z in Z^d.

Coordinatewise this is
`z_i+t v_i in [-1+1/N,-1/N]`, exactly a closed norm bound `>=1/N`.
Conversely a common closed norm witness gives these representatives by
integer translation. Time sign is unrestricted. Since `2c in Lambda`,
the two signs of this particular coset agree; that does not allow an
arbitrary translate. There is one common `t`, never separate phases.

The hypothetical minimum is selected after passing to the global
positive-integer formulation. Count minimality supplies lower-count
ordinary witnesses at their own margins, while sum minimality supplies
only the original margin at a smaller same-count sum. Dividing a common
gcd preserves failure and reduces sum. These statements justify the
primitive minimum and do not require a count-preserving conversion of a
specified real tuple. Full ordinary failure is the hypothesis here;
failure of the deletion-seed assertion Q alone would not suffice.

## Projection, fibre and parity checks

The centre adjustment in approach one is valid, including containment.
If a contained symmetric body `D` has centre `z` and the containing
body has centre `barc`, then for `x in D` both `x` and
`2barc-(2z-x)` lie in the containing body. Their average is
`x-z+barc`. This proves containment of the recentered copy. The shift
is integral when `z` and `barc` are congruent. Lower-count supply may
be applied in the contained body's generator lattice; inclusion in the
ambient lattice and centre congruence retain the required coset. A
nonzero relation with repeated absolute entries is first deduplicated;
its resulting margin is at least `1/d`, so no distinctness premise is
silently lost.

For primitive `w`, the integer kernel along its line is `Zw`. Therefore,
for a projected point `b` in the projected coset, any coset lift `x_b`
has exactly the fibre lattice `x_b+Zw`. The target fibre is a compact
interval because the target body is compact and convex. The projected
lower-count point lies in `alpha*pi(B)` with `alpha=(d-2)/d<beta`,
so that fibre is nonempty. Its exact test is

    [L_b,R_b] intersect Z != empty  iff  ceil(L_b)<=R_b.

Length at least one is sufficient with closed endpoints. Under full
failure every nonempty fibre over the projected coset misses this lattice
and has length strictly below one. This implication goes from full
failure to fibre shortness, not from a short fibre to projected failure.

The direction-specific extension of the source's estimate is also valid.
Choose `a in alpha B` projecting to `b`, put
`theta=alpha/beta`, and let `a'=a/theta in K`. If
`lambda_w` is the gauge of `w` in `K`, compactness gives
`+/-w/lambda_w in K`. The two convex combinations

    theta*a' + (1-theta)*(+/-w/lambda_w)
       = a +/- 2*w/[d(d-1)lambda_w]

are in the same fibre. This proves the claimed length bound without
requiring `w` to minimize the gauge among lattice directions. It is a
sufficient width estimate, not a consequence of lower-count supply alone.
The author's integer-coordinate equation (4) accurately retains the
remaining lift variable; only its integer values give the original coset.

The parity claims require, and correctly retain, primitive normalization.
If `c in Lambda`, then `1_d-2z=t v` for an integer vector `z`.
Bezout makes `t` integral; each coordinate of `t v` is odd, so all speeds
are odd. The converse follows directly from `(1_d-v)/2` being integral.
This class already has the ordinary witness `1/2`.

Assume `c notin Lambda`. If its projected coset is integral, then a
representative on `Rw` has coordinate in `(1/2)Z`: twice that point
lies in `Lambda`, and `w` is primitive. An integral coordinate would
contradict `c notin Lambda`. The fibre lattice is therefore precisely
`(1/2+Z)w`. Symmetry about zero makes the central fibre liftable exactly
when `w/2 in K`, equivalently `lambda_w<=2`. This includes equality.

The more general equivalence (7) is sound. Given a coset point `x in K`,
write `2x=k w` with `k>0` integral and `w` primitive. The nonzero parity
of `2x` forces `k` odd, so `w-2c in 2Lambda`. Convexity and `0 in K`
give `w/2=x/k in K`. Conversely a direction of that parity with
`w in 2K` gives a coset point `w/2 in K`. Thus finding such a
direction is exactly the original supply obligation. Reflection of
noncentral fibres only pairs them; it does not establish this condition.

## Integral affine cube rigidity and transport

For any row `i` of `A`, the exact maximum over the smaller cube is

    max_y |(Ay+r)_i| = |r_i|+(alpha_m/2)*sum_j |A_ij|.

This follows by choosing the signs of all coordinates to align the row
functional with the sign of `r_i`, and also holds when `r_i=0`.
Containment bounds this maximum by `beta_d/2<1/2`. The coset condition
makes `r_i` integral or half-integral, hence forces `r_i=0`. It then
makes the row sum odd. Its absolute row sum is an odd positive integer
because `|a|` and `a` have the same parity for every integer entry.

For `m=2`, `alpha_m=1/3`, so the absolute row sum is strictly below
three and must be one. For `m>=3`, `alpha_m>=1/2`, so it is strictly
below two and again equals one. Every row is a signed coordinate
selector. This proves the entire stated range `2<=m<=d`; neither rank
nor a hidden positivity condition on matrix entries is needed.

Under `Av'=kappa v` with `kappa!=0`, the selected coordinates have at
most `m` distinct absolute values. The right side has `d` distinct
absolute values. For `m<d` this is impossible, independently of whether
all source coordinates are selected. For `m=d`, every source coordinate
must be selected once. When both positive tuples are primitive, Bezout
for `v` shows `kappa` is an integer, and taking gcds of absolute values
in the line equation gives `|kappa|=1`. Thus their natural sums agree.

The hypotheses indeed transport actual witnesses. For a smaller witness
represented by `1_m/2+z+t v'` inside the contracted cube, the affine
image is `1_d/2+z'+kappa*t*v` for a single integer vector `z'`.
It lies in the larger contracted cube by pointwise containment. This
verifies the desired implication in the correct failure-preserving
direction. The theorem excludes that particular way of establishing
the implication; it does not assert that every valid witness map must
have this form.

At `m=1` the source cube is a point. Odd integer row coefficients are
then possible; after the line condition and primitive normalization the
target is all odd. Excluding this case is necessary. Closed containment
causes no omitted endpoint: the decisive strict inequality is
`beta_d<1`, which holds at every finite count considered.

Quotient-level containments, nonintegral maps, piecewise choices and
maps depending on an actual witness are outside this theorem. In
particular the source projection theorem does not furnish a forbidden
matrix. No general prohibition of centre-preserving projection or all
integral descent follows.

## Existing formal scope and remaining dependency

I read the current complete `FiniteHeightReduction.lean` and
`FiniteFamilyEquivalence.lean`, and the sharper-cutoff implementation
and review. The current height file adds a mixed-margin conclusion to
the historical implementation, then derives the ordinary stationary
theorem. Its strict height premise is unchanged. With total count `N`,
the inclusive remaining range is `H<=choose(N,2)^(N-2)`; the proved
large-height branch requires strict `>` and lower-count supply.
This coordinate theorem is not a kernel formalization of the geometric
fibre estimate or of the stronger gcd-subset criterion. The all-count
finite-family premise remains explicit in the equivalence theorem.

The bound joint-seed and minimal-height manuscripts also leave the
needed implication unsupplied: their smaller replacement can be good,
and weak endpoints do not become original strong deletion seeds.
Nothing in this projection manuscript reverses those conclusions.

The exact missing step is a globally justified choice of a projected
ordinary witness whose particular fibre meets its affine lattice, or
a different operation proving that original failure entails a genuinely
smaller positive-tuple failure. The parity equivalence is not such a
choice, and volume reduction is not failure preservation. The accepted
new obstruction is useful for screening a proposed proof mechanism;
it does not warrant a disconnected Lean implementation or resolve Q
or the unrestricted conjecture.

## Exact local bindings and verification receipt

The complete frozen author and all twelve inputs in its binding table
were read and their current SHA-256 values compared. Every value matched:

| Input | SHA-256 |
| --- | --- |
| `.codex/config.toml` | `28212a53cf42cdc377df1f7dab040732d657e59d7bb97ee78791256d01d4bb2c` |
| `docs/project-workflow.md` | `2b42a133352b6b53ba2106fc73882733f176e04a0deffbb183b4c16eefd9cd67` |
| `research/workflow-policy.json` | `833c397b61d1ffdb994fb115019f6d60d6c1a62ff85f19cdd2c9f8ac3a979c8b` |
| `scripts/validate_workflow.py` | `250a3ce2a080f5835ac4fd2e4b2803568424c777cda5d421f9fe92efd34d5383` |
| `docs/astra-research-63.md` | `b3f9e49779092d09da83802cd80112c30c2ffee19bf005b18a91c0895f1f72e5` |
| `research/astra-sharper-cutoff-implementation.md` | `367482dfa7543e152167191e33574f97cb7631e39f4066225a7d83cda2abac92` |
| `research/astra-sharper-cutoff-review.md` | `ddd2c78b02357ace437f2c379d8088335149cca17b72e1f5906d56031ad68d2d` |
| `LonelyRunner/FiniteHeightReduction.lean` | `cb41059260b943411e2ab5360b84b59cd13f2ddf352c3c50a0b3715b9b9987d6` |
| `LonelyRunner/FiniteFamilyEquivalence.lean` | `475a46b9e10226f3de30628e595073a9765a8c03cb0ab071bdcc10acb6446be3` |
| `research/astra-minimal-height-audit.md` | `40e59ba4539eb931a07612e9b972999d3b48006d39ef4760c0e493d08e734325` |
| `research/astra-minimal-height-review.md` | `4570fa22f788a0e832165dd4ec5da613003a0181b0200267fcc30b44d9776e92` |
| `research/astra-joint-seed-maximum-audit.md` | `ac73e29474e272167403c91db34331236bb3832f7ce916b2997d7c2f0d6b46ac` |

Historical embedded mathematical programs and old builds were read as
evidence, not executed again. Their historical source hashes are not
substituted for current source bytes. Primary HTML retrievals used the
linked versions; no byte hash is invented for the remote rendering.

Current configuration, workflow, policy and focused state were read.
Actual command, working directory `/home/joshua/lonely-runner-formalization`:

    python3 -B scripts/validate_workflow.py

Exit status 0; complete raw output:

    workflow structural validation passed; it cannot certify mathematical validity.

Mathematical verification consisted of the complete source reads and the
independent quotient, convexity, parity and finite-matrix arguments above.
The only executable checks were administrative validation, source hashes
and text hygiene. No mathematical program, solver, enumeration, Lean
invocation, cache restoration, Git mutation or shared-state edit occurred.
Only this review was written. Its final hash and whitespace/newline receipt
are supplied separately to root; acceptance is bound to the author bytes
listed above and does not assert kernel verification of this manuscript.
