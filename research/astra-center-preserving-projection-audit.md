# Ordinary centre-preserving projection: lift and descent audit

Task `/root/center_preserving_projection_audit`, requested Astra/xhigh, at
root checkpoint `ca9d2d7f20f66cceb7db3b440d0378203624aa39`.
Only this manuscript is owned. The two approaches below establish an exact
parity reformulation and a uniform obstruction to a specified integral
cube-lift mechanism. Neither supplies an unrestricted witness or a smaller
counterexample. No Lean implementation is proposed.

## Source contract and conventions

The primary-source audit used publisher HTML for Malikiosis--Santos--Schymura,
*Linearly exponential checking is enough for the lonely runner conjecture
and some of its variants* (2025): Definition 1.4, Proposition 1.5, Theorem
3.1 and its proof, and section 3.2 including Lemma 3.6. Their moving count
`n` is our `d=N-1`; the zonotope dimension is `d-1=N-2`. Theorem 3.1
supplies a contained lower-dimensional LR zonotope with congruent centre
under a lattice-surjective projection. Lemma 3.6 combines lower-count
ordinary LRC with a short lattice direction to obtain a closed fibre of
lattice length at least one. These are ordinary central-coset statements;
the shifted covering-radius hypothesis is different. [Primary article](https://www.cambridge.org/core/journals/forum-of-mathematics-sigma/article/linearly-exponential-checking-is-enough-for-the-lonely-runner-conjecture-and-some-of-its-variants/A51A991DE89B8C9C2E2FF13FBD4501DA).

Beck--Schymura, *Deep lattice points in zonotopes, lonely runners, and lonely
rabbits*, version 1, Proposition 9 and section 3, give the ordinary
zonohedron/depth equivalence. Its centre is `1/2` times the all-ones vector
modulo the velocity line. Theorem 1's general asymmetry bound has order
`d log log d`, whereas the required ordinary asymmetry bound is `d`.
Thus that general theorem supplies no missing sharp depth estimate here.
No interior-point count is used as a depth theorem. [Primary version](https://arxiv.org/html/2301.12182v1).

Hereafter the calculations and the narrow obstruction are this audit's
derivations. The all-lower-count extension of the cube argument was proposed
by root and independently checked here; the initial argument treated one
count reduction. No priority claim is made for the geometric reformulations.

Suppose an ordinary positive integer failure exists. Choose a positive
distinct tuple `v=(v_1,...,v_d)` of least moving count, then least natural
sum. Its gcd is one: division by a common factor preserves failure by time
scaling and would decrease the sum. Count minimality supplies ordinary LRC
at every smaller moving count, with that count's own closed margin.
The existing six-total-runner theorem excludes `d<=5`; the derivations
below only need their separately stated smaller lower bounds. The stationary
runner remains zero throughout. The global integer equivalence is used
before choosing the minimum; no count-preserving real-to-integer theorem
is assumed.

Use the intrinsic quotient

    E = R^d / R v,       Lambda = image(Z^d in E),
    U : R^d -> E,        u_i = U(e_i),
    C_d = [-1/2,1/2]^d,  B = U(C_d),
    Z = U([0,1]^d),      c = U((1/2)1_d),
    beta = (d-1)/(d+1),  K = beta B.

Primitivity gives `Z^d intersect Rv=Zv`, so `Lambda` is a lattice and its
integer kernel is exactly `Zv`. Coordinates may identify `Lambda` with
`Z^(d-1)`; a raw integer projection whose columns generate a proper
sublattice must instead retain that image lattice. We have `2c in Lambda`.
The ordinary condition is exactly

    K intersect (c+Lambda) != empty.                         (1)

Indeed, a point `U((1/2)1_d+m)` lies in `K` precisely when, for some real
`t`, every coordinate of `(1/2)1_d+m+t v` lies in
`[-1/2+1/N,1/2-1/N]`. Subtracting `1/2` gives integer translates of
`[-1+1/N,-1/N]`, which have norm at least `1/N`. This also verifies the
closed endpoints and the harmless sign of time. The cosets `c+Lambda` and
`-c+Lambda` agree, but neither can be replaced by an arbitrary translate.

With volume measured so a lattice fundamental parallelepiped has volume
one, `vol(Z)=sum_i v_i`: the maximal minors of a lattice-surjective matrix
for `U` are the signed primitive kernel coordinates, and the zonotope
volume is their absolute sum. This interpretation of sum minimality does
not survive an unrecorded change of lattice index. It gives no monotonicity
of failure under projection.

## Approach one: lower-count supply and the exact fibre

Take a primitive `w in Lambda` and the quotient map
`pi:E -> E/Rw`, with image lattice `barLambda=pi(Lambda)` and centre
`barc=pi(c)`. Put `alpha=(d-2)/d`, so this subsection assumes `d>=3`.
The source projection theorem and count minimality supply

    b in alpha*pi(B) intersect (barc+barLambda).             (2)

The centre issue in this application is essential. If a centrally symmetric
contained body has centre `z` congruent to `barc`, it can be recentered at
`barc` by an integral translation while remaining contained. To see the
containment, for each point `x` in that body, average `x` with the reflection
of its opposite point `2z-x` in `barc`; the average is `x-z+barc`.
The containing projected body is convex and symmetric. If the contained
LR zonotope's generators span a sublattice, apply lower-count LRC to the
untranslated generator body in that sublattice, then use the ambient centre
congruence to include its witness in `barc+barLambda`. Sign changes and duplicate
absolute speeds in its nonzero relation are handled by norm symmetry and
deduplication; the supplied margin is at least `1/d`.

Choose `x_b in c+Lambda` with `pi(x_b)=b`. Primitivity of `w` gives

    (c+Lambda) intersect pi^(-1)(b) = x_b+Z w.

The nonempty compact fibre of `K` has the unique description

    K intersect pi^(-1)(b) = {x_b+s w : L_b<=s<=R_b}.

Its exact lifting condition is

    ceil(L_b) <= R_b.                                      (3)

In particular `R_b-L_b>=1` is sufficient, including equality. Shortness
alone does not determine (3): position relative to the affine lattice
matters. If the original tuple fails, every such nonempty fibre has length
strictly below one and fails (3), not merely the fibre of a chosen witness.

This is actual common-time arithmetic. Choose integer `z,m` with
`U(z)=w` and `x_b=U((1/2)1_d+m)`. Then its interval consists exactly of
those `s` for which some real `t` satisfies

    |1/2+m_i+s*z_i+t*v_i| <= beta/2,       all i.            (4)

When `s` is an integer, its contribution `m_i+s*z_i` is an integer for
every original label, and (4) gives an original witness. A noninteger `s`
cannot be discarded as a harmless change of time or as independently
adjustable phases.

For comparison with the source's cutoff argument, let
`lambda_w=inf{lambda>0:w in lambda K}`. Its central chord has radius
`1/lambda_w` in `w` coordinates. Convexity gives, for every `b` in (2),

    R_b-L_b >= 4 / ((d-1)*d*lambda_w).                       (5)

This is the fibre estimate in MSS Lemma 3.6, applied to this direction.
The sufficient bound `lambda_w<=4/((d-1)*d)` closes (3). The current
kernel-checked coordinate reduction already covers the corresponding
large-height branch. Below that bound's guaranteed range, (2) supplies
existence but not an admissible choice satisfying (3). Counting projected
witnesses, without controlling their particular intervals in (4), does not
repair this quantifier loss.

### What centre parity does and does not improve

First, `c in Lambda` holds exactly when all primitive speeds are odd. In
one direction, `1_d-v` is even. In the other, `1_d-2m=t v` for an integer
vector `m`; Bezout and primitivity force `t` to be an integer, and then
its odd coordinates force `t` and all `v_i` to be odd. This case already
has the witness `t=1/2`.

Assume `c notin Lambda`. If `barc in barLambda`, then the central fibre's
affine lattice is precisely

    (c+Lambda) intersect Rw = (1/2+Z)w.                     (6)

Indeed, any representative on that line has twice its coordinate integral;
an integral coordinate would imply `c in Lambda`. Thus for this central
fibre the closed condition is simply `w/2 in K`, or `lambda_w<=2`.
This improvement over (5) is real, but arranging the requisite parity
and shortness is not supplied by count minimality.

More precisely, for any centrally symmetric convex `K` containing zero,
with `2c in Lambda` and `c notin Lambda`,

    K intersect (c+Lambda) != empty
      iff some primitive w in Lambda satisfies
          w-2c in 2Lambda and w in 2K.                     (7)

The reverse implication uses `w/2`. For the forward implication write
`2x=k w` for `x in K intersect(c+Lambda)`, `w` primitive and `k>0`
integer. The vector `2x` is nonzero and has nonzero parity, so `k` is
odd; consequently `w` has parity `2c`, and `w/2=x/k in K` by convexity.
Such a `w` automatically makes `barc` integral after projection.

Thus demanding a direction with both properties in (7) is exactly the
original central-coset supply obligation. It is not a new parity selection
theorem. For a direction without that parity, reflection pairs fibres over
`b` and `-b`; it does not turn a noncentral fibre into the centred interval
in (6). This ends the first approach at the missing choice in (3).

## Approach two: a short fibre and integral failure-preserving descent

A projected lower-count ordinary witness exists by minimality, even when
its original fibre is empty of affine lattice points. Consequently a
short fibre does not make the projected LR zonotope a counterexample.
To use count or sum minimality, a proposed operation must give an actual
smaller positive tuple `v'` and prove

    every supplied ordinary witness for v' can be
    transported to an ordinary witness for v.               (8)

Equivalently, original failure must imply failure of that smaller tuple.
An integral projection or a smaller volume alone does not establish (8).
Replacing the kernel direction changes the original phases in (4), and
the unavailable integer fibre coordinate is exactly what must be recovered.

The following result rules out a concrete strong way of establishing (8).
It is an obstruction to pointwise cube lifts before quotienting, not to
general containments after quotienting by the velocity line.

**Integral affine cube rigidity.** Let `2<=m<=d`, let

    alpha_m=(m-1)/(m+1),       beta_d=(d-1)/(d+1),
    A in Z^(d by m),          r in R^d.

Suppose the affine map `F(y)=Ay+r` satisfies both

    A(alpha_m C_m)+r subset beta_d C_d,                     (9)
    r+(1/2)A1_m-(1/2)1_d in Z^d.                           (10)

Condition (10) is exactly preservation of the half-integer ordinary coset
in these cube coordinates; it permits an integral affine translation in
the equivalent uncentred formulation. Then `r=0` and every row of `A`
is a signed coordinate selector.

For row `i`, write `h_i=sum_j |A_ij|`. Maximizing its linear functional
over the symmetric cube gives the exact necessary inequality

    |r_i| + (alpha_m/2)h_i <= beta_d/2 < 1/2.              (11)

By (10), `r_i` is an integer or a half-integer. Hence `r_i=0`, and
`sum_j A_ij` is odd. In particular `h_i` is a positive odd integer.
If `m=2`, then `alpha_m=1/3`, so (11) gives `h_i<3`, forcing `h_i=1`.
If `m>=3`, then `alpha_m>=1/2`, so it gives `h_i<2`, again forcing
`h_i=1`. Thus each row has precisely one entry `+1` or `-1`.

Now let `v'` be a positive moving-speed vector and suppose additionally

    A v' = kappa v,        kappa != 0.                     (12)

This is the required mapping of velocity lines. If `m<d`, the left side
has at most `m` distinct absolute coordinate values. The right side has
`d`, because the original positive speeds are distinct. This contradiction
rules out (9)--(12) for **every** lower moving count `2<=m<d`.

These hypotheses really would transport ordinary witnesses: apply `F` to
`y=(1/2)1_m+z+t v'` in the smaller closed cube. Equations (10) and (12)
place its image in `(1/2)1_d+Z^d+kappa*t*v`, and (9) places it in the
original closed cube. This explains the role of the strong pointwise
containment in (8), without changing the stationary runner.

If `m=d` and both speed tuples are primitive and positive distinct, the
selected coordinates must form a permutation. Equation (12) then shows
that `|kappa|=1`: Bezout for `v` first makes `kappa` integral, and the gcd
of the permuted signed `v'` is one. The natural sums are equal. Thus this
same-count pointwise cube-lift class supplies no smaller-sum descent either.

The exception `m=1` cannot be omitted: `alpha_1=0` makes the source cube
a point. Odd integer coefficients may then satisfy (9)--(10); the line
condition leads to the all-odd case after primitive normalization. The
strict bound `beta_d<1` and the use of closed cubes are both respected in
(11); there is no discarded equality case.

The theorem allows the simplest integer translations rather than excluding
them by definition. It does **not** cover an inclusion that holds only
modulo `Rv`, a lift depending on the witness, a piecewise choice of integer
representatives, or a map tested only on points representing actual
lower-tuple witnesses. Those possibilities need a separate proof of (8). In
particular MSS's contained projected body is not a forbidden matrix of
this theorem. The rigidity result must not be reported as impossibility of
zonotope projection, of all integral descent, or of unrestricted LRC.

## Settled result and remaining obligation

The primary theorem is applicable in the correct ordinary lattice and
centre convention. The exact interval lift is (3)--(4); parity gives the
special central case (6), but requiring its successful direction is the
equivalence (7), not a supply result. Shortness does not preserve failure
on projection. The integral affine cube class in (9)--(12) cannot perform
the requested count/sum descent for distinct positive primitive speeds.

The remaining mathematical obligation is to select a genuinely liftable
ordinary lower-count witness under hypotheses available below the cutoff,
or to construct a smaller tuple with a separately proved implication (8)
using structure beyond that cube class. Neither was established. The
previous joint-seed comparison and smaller replacement witness do not
provide either implication: their replacement is good, not a smaller
failure. This bounded audit does not close the finite-family gap.

The cube rigidity lemma has a straightforward finite-matrix Lean contract
if later needed to exclude an implementation plan. It is not a witness
supply theorem and does not justify a disconnected formalization now. No
new useful unrestricted supply contract was obtained; no restricted-family
implementation, fixed-count roadmap, or numerical search is proposed.

## Source bindings and checks

The local mathematical contracts and relevant proofs were read, including
the actual stationary large-height and all-count equivalence declarations;
historical computational programs were not replayed. Current
`FiniteHeightReduction.lean` includes the later mixed-witness strengthening,
so its actual hash differs from the older implementation receipt. Its
ordinary projection and strict-height hypothesis were inspected directly.

| Local input | Actual SHA-256 |
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

The checked source cutoff remains `choose(N,2)^(N-2)`, with equality in
the finite branch. The all-count finite-family premise remains unresolved.
The publisher and arXiv HTML were read through the web tool at the linked
versions; no downloaded PDF or invented byte hash is retained for them.
The current configuration, workflow, policy and focused active state were
read; the root-owned state was not modified.

Actual administrative check, working directory
`/home/joshua/lonely-runner-formalization`:

    python3 -B scripts/validate_workflow.py

Exit status: 0. Full raw output:

    workflow structural validation passed; it cannot certify mathematical validity.

Input readback used `sha256sum` on the exact paths in the table. Mathematical
verification was quotient-lattice algebra, convexity, parity, and the
row-norm argument above; no mathematical program, solver, enumeration,
Lean build, dependency/cache access, Git mutation, or other-file edit was
performed. Final owned-file whitespace and hash receipts are reported to
root with this frozen manuscript.
