# Independent pass 6 review: normalization supply and finite decisions

Status: **complete; accepted at the precise scopes below**, 2026-09-05.
Manuscript mathematics and the final fixed-pair implementation are accepted.
Final numeric-type guards and documentation corrections were read back and
tested before freezing this review. Requested reviewer: in-session Astra xhigh,
`/root/vanishing_slope`; independently observed runtime metadata unavailable.
The reviewer did not author any of the three pass 6 artifacts under review.
This is not a re-review of the reviewer's earlier multiple-zero Lean theorem.

Current project config, workflow, policy, and state were read, and workflow
validation passed. Only this note is reviewer-owned. No Lean build, cache
restoration, Git action, or source modification was performed. Python checks
were paused for the parent's storage cleanup and resumed after its release.

## 1. Immutable mathematical inputs and disposition

The following files were read in full and checked at the stated hashes:

```text
research/astra-union-supply-audit.md
dc5cf0ec0d7e0b77b79f998f6419a8d81b5be5851bc861a8701f062d7aec012e

research/astra-normalization-decision.md
6e3a76646f4f93dec9420a4285ffbdc8848b4437dc607a6485a555f7c7c4d89f

scripts/grid_normalization.py
38bc58b6a53c044998a9b48d4fda8dc4a717fa6936dee9e8cb68935bf690cdb0

tests/test_grid_normalization.py
f68d210ec6295f3196c7849d1effc1bbc90aef0dfb67ebe2739a8f5432bcd0da

research/astra-fixed-grid-checker.md
c3465adc8b5794e88404c8f1de41a45d64ddbdd59d07c864b631316e1d6bfa9c
```

I accept the residue A/B/R equivalence at its stated primitive positive,
odd-prime runner-count scope. I also accept the mathematical soundness,
completeness, and termination of the described finite all-modulus decision
reduction. Its real-algebraic implementation and negative-certificate verifier
do not yet exist. No particular tuple has been proved to fail the union for
every modulus by this work.

## 2. Residue equivalence: all lifts and modulus regimes

The common modular multiplier is a unit modulo `M`, with unrestricted
integer lifts of that class. The proof keeps the following distinctions.

For A and B the small positive bases are below `M/2`; their values are
therefore the absolute residues, while independent signs realize the chosen
orientation. If `N` does not divide `M`, CRT gives a common lift equal to 1
modulo `N`. If `N|M`, any modular unit is already nonzero modulo prime `N`.
Primitivity supplies a coordinate not divisible by `N`, so A's necessary
nonzero offset exists in both regimes. In B, `M|V_p` is equivalent to
divisibility of the transformed pivot by `M`, and the required nonzero pivot
offset is obtained from `N` not dividing `V_p` and the same lift choice.

For R when `N` does not divide `M`, choosing the common lift divisible by
`N` makes every transformed offset zero. Ordinary slopes may nevertheless
be nonzero; their offsets are unrestricted by the multiple-zero theorem.
When `N|M`, a signed residue divisible by `N` forces its original speed
divisible by `N`, since the common multiplier is a unit modulo `N`. Thus
the zero-offset condition is again satisfied. No restriction requiring the
common multiplier to be a unit modulo `N` has been inserted into R.

For every branch, a signed transformed speed can be replaced by a positive
integer congruent to it modulo `N*M`. At time `s/N+r/M`, multiplication by
the added `N*M` multiple changes the phase by an integer. The coordinate
signs preserve circle distance, and multiplying the common time by the
common lift transports the witness back to the original speeds. This is
exact grid periodicity, not an approximation or arbitrary speed alteration.

The bounds also exclude noncanonical large representatives. For zero extrema
`L,H`, the zero-size inequality can be rewritten as

```text
L*((N-1)*M-N*H) >= H*M > 0.
```

Consequently `H<(N-1)*M/N<M`. Each ordinary inequality implies
`a_i<M/N`. Hence all R bases are the actual positive signed residues.
The same observations rule out `M=1`, including the all-zero case.

## 3. Replacing auxiliary range bounds by actual extrema

Suppose an application uses bounds `L0<=A_j<=H0` that are not attained.
Let `L=min_j A_j` and `H=max_j A_j`. The replacement is valid in the
required direction: `L>=L0` and `H<=H0` improve every condition.

At `H0`, the coefficient `(N-1)*M-N*H0` is positive, because multiplying
it by `L0>0` gives at least `H0*M>0`. Decreasing `H0` increases that
coefficient and decreases the right-hand side `H0*M`. Increasing `L0`
then improves the left-hand side. Thus the zero-size inequality survives.
For an ordinary base `a`, its original inequality is

```text
L0*(M-N*a) >= a*M > 0,
```

so its coefficient is positive and increasing `L0` preserves it. The
strict span and the strict ordinary-base separation are preserved as well.
The zero set remains nonempty and unchanged because every ordinary slope
is required nonzero modulo `N`. No assumption that the original bounds
were themselves multiples of `N` is needed for this argument.

For one zero coordinate, putting `L=H=A` and cancelling the positive base
in the zero inequality gives exactly `N*A<=(N-2)*M`; this is the coarse
one-zero contract. It is correctly absorbed into R rather than counted as
an additional, potentially different supply branch.

## 4. Finite reduction: cells, signs, and exact zero anchors

For each velocity cell, `q_i=floor(V_i*x)` is constant. The signed values
are `f_i^+=V_i*x-q_i` and `f_i^-=q_i+1-V_i*x`; both are in `(0,1)`.
At a reduced ratio `x=c/M`, multiplying by `M` gives the two actual signed
integer residues. Their classes modulo `N` are

```text
delta_i^+ = V_i*u-q_i*m,
delta_i^- = (q_i+1)*m-V_i*u = m-delta_i^+.
```

The second expression is crucial. Substituting `-delta_i^+` would lose
valid signed zero options whenever the denominator class `m` is nonzero.
At a velocity breakpoint at least one signed residue is zero in both
orientations, so neither A nor R is possible there. The apparent value 1
from extending the negative affine formula to that endpoint is not a
positive representative below `M` and must not be used.

For R, fixing an anchor with zero class and value `lambda` is sound only
when that original row is actually selected at that value. The manuscript
does this explicitly. With `D=1+N*lambda`, the anchor and all selected zero
rows satisfy `f*D<=(N-1)*lambda` and `f>=lambda`. Every ordinary row
satisfies `f*D<=lambda` with nonzero class. Because `D>1` and all selected
values are positive, these inequalities imply the original strict zero
span and strict ordinary separation. Taking the maximum of the selected
zero values recovers the zero-size inequality; the anchor makes their
minimum exactly `lambda`.

Once the anchor is fixed, remaining row choices are independent. Therefore
the disjunction over at most `2*(N-1)` anchors is complete without an
exponential enumeration of signed partitions. An all-zero assignment is
included; no ordinary row is required.

## 5. Independent verification of the rational-density step

The interval argument is valid and uses no theorem on primes in arithmetic
progressions. Choose a reduced interior rational `a/b` unequal to `u/m`
when the latter exists, and set `Delta=a*m-b*u!=0`. The proposed pairs

```text
c(k)=N*a*k+u,             M(k)=N*b*k+m
```

have the desired classes. Any common prime divisor divides `Delta` because
`b*c-a*M=-Delta`. Prime `N` cannot divide both when `(u,m)!=(0,0)`.
For every other prime factor `p` of `Delta`, coprimality of `a,b` ensures
at least one invertible coefficient in the two equations for a common
factor. The determinant relation then makes the two equations consistent
at exactly one class of `k` modulo `p`. Avoiding that class for each such
prime, by CRT over distinct primes, excludes every possible common prime
factor. This also handles factors dividing one of `a,b`, the prime 2, and
an empty list of primes to avoid.

The approximation error is exactly

```text
|Delta| / (b*(N*b*k+m)) <= |Delta|/(N*b^2*k).
```

The manuscript's strict choice of `K` therefore places every sufficiently
large admissible `k` inside the desired interval. The first such member
lies in `[K,K+Q)`, proving the displayed finite bound for its denominator.
Both zero-numerator and zero-denominator classes are covered. The exclusion
of only `(0,0)` would be insufficient at composite `N`, but primality is
an explicit input to this reduction.

Feasible real intervals with algebraic endpoints can first be shrunk to
rational intervals. Exact root isolation supports that step effectively.
Thus open real feasibility supplies an admissible reduced rational pair
with the required arithmetic classes, rather than merely a nearby pair in
uncontrolled classes.

## 6. Point atoms, finite B, and completeness

Density cannot be used at a point atom. A rational point `p/q` in lowest
terms has exactly one admissible positive reduced pair, namely `(p,q)`.
Scaling it to alter the prescribed classes violates `gcd(c,M)=1`.
Irrational algebraic points cannot equal any permitted ratio. The manuscript
tests these cases separately and evaluates strict and non-strict comparisons
at the exact point; it does not replace feasibility by its closure.

The control `x=3/196` illustrates both arithmetic-class matching and a
valid coarse equality. Its true reduced classes modulo 7 are `(3,0)`,
even though the same real anchor formula is feasible at that point in the
different case `(1,3)`. The latter case cannot use that point. The supplied
actual-class R certificate retains equality at the ordinary upper bound.

B is finite independently of the semialgebraic reduction: any pivot forces
`M` to divide its original positive speed, and only finitely many units
exist at each such divisor. This scan includes the velocity breakpoints
excluded from A/R.

All remaining comparisons are univariate polynomials of degree at most two.
After treating constant and identically zero polynomials as constants, exact
root isolation gives finitely many point and open interval atoms. Signs and
Boolean feasibility are constant on each open atom. Every hypothetical
normalization lies in the B scan or in one of the enumerated A/R class cases
and atoms, proving completeness. A complete negative certificate must also
certify that these atoms cover every cell and that every case was enumerated;
a collection of sampled failures or a program's bare Boolean is insufficient.

## 7. Fixed-pair checker review

The complete finder and verifier were read, not only the tests. The finder
implements A first, then all possible B pivots, then the attained-minimum R
criterion. For a candidate integer `L`, its thresholds use
`D=N*L+M`; an actual zero row at exactly `L` is forced. The choices for
other rows are independent under these thresholds, so this implements the
same finite predicate as complete sign enumeration.

Affine reconstruction and verification use
`s*actual_i+r0*base_i` modulo `N`. The actual speed is congruent to its
base modulo `M`, but need not be congruent modulo `N`. In particular the
R lift with `N|b` often makes all actual offsets zero. I independently
checked a control where replacing the offset by the base selects an invalid
pair. The final implementation uses the correct expression on both paths.

The verifier does not invoke the finder, the R assignment routine, or the
affine search. It checks signed congruences, positive actual representatives,
branch inequalities, zero/ordinary flags, exact extrema, actual zero offsets,
rounding and time arithmetic, and finally all original-speed closed circle
distances. Both `N|M` and `N` not dividing `M` are handled. Reconstruction
failure after a successful predicate is an internal error, not a negative
fixed-pair result.

Final numeric guards require the common lift and both time fields to be
Python integers, reject booleans, and require a positive denominator before
constructing the exact fraction. This closes the parent's reported case in
which a numerically equal floating lift could enter congruence arithmetic.
The final source also documents the valid-input distinction below. No open
correctness finding remains against the frozen implementation.

The checker intentionally accepts only odd-prime `N`, a tuple of exactly
`N-1` positive, pairwise distinct, primitive integer speeds, and a valid
integer modulus/unit pair. Its implementation domain is therefore slightly
narrower than the manuscript reduction, which also permits repeated labels.
Invalid inputs also return `None`. Only on the accepted input domain does
`None` certify failure of A/B/R for that fixed `(M,c)`; it never certifies
failure for another pair or for every modulus.

## 8. Exact review evidence

Commands used were direct standard-library Python invocations and
`python3 -m unittest tests.test_grid_normalization -v`. No floating-point
arithmetic was used in the mathematical review oracles. All **eight** authored
focused tests passed on the final hashes above, including reconstruction-error
classification. Another 42 deliberately malformed numeric-field mutations
were rejected across direct A, mixed R, and all-zero R certificates: float,
boolean, and string lifts/time fields, plus zero and negative denominators.

Independent full sign enumeration was compared with the finder on:

| N | Positive tuple domain | Modulus domain | Compared fixed cases |
|---|---|---|---|
| 3 | Primitive 2-subsets of `1..12` | `2..35`, every unit | 17,235 |
| 5 | Primitive 4-subsets of `1..9` | `2..35`, every unit | 47,875 |
| 7 | Primitive 6-subsets of `1..9` | `2..28`, every unit | 20,244 |

All 85,354 comparisons agreed. Among them, 10,102 certificates were returned:
8,414 A, 270 B, and 1,418 R. Independently evaluating the final original-speed
circle distances accepted all 10,102, and mutating their time to zero caused
the verifier to reject every one. These are finite regression checks, not
all-modulus evidence.

Additional exact controls covered:

* A with `N|M`: `N=5,V=(1,2,3,4),M=20,c=1`.
* R with `N|M`: `N=5,V=(1,2,3,5),M=100,c=1`.
* R with `N` not dividing `M`: the same tuple with `M=101,c=1,b=405`.
  Its actual positive representatives are `(405,305,205,5)` modulo 505.
  Correct pair `(r0,s)=(1,1)` works; pair `(2,4)` from the erroneous
  base-only expression gives original time `45/101`, whose speed-2
  distance is `11/101<1/5`, and is rejected.
* All-zero R with empty ordinary family:
  `N=3,V=(1,10),M=11,c=3`, bases `(3,3)`, signs `(1,-1)`, actual
  representatives `(3,3)`, and original time `4/11`.
* A fixed negative with another-unit positive:
  `N=3,V=(1,2),M=7,c=3` fails, while `c=1` succeeds.

The normalized cell formulas were independently compared with direct signed
residues on 19,076 fixed cases: primitive subsets for `(N,max V,max M)` equal
to `(3,9,23)`, `(5,8,23)`, and `(7,8,17)`, including every unit. All agreed;
1,520 cases lay on velocity boundaries, where A/R correctly failed.

The decision manuscript's 160 density constructions, rational endpoint, and
B boundary controls passed. Another 576 constructions passed for every
admissible class at `N=11,13` in `(1/3,1/3+1/10^6)` and `(5/9,7/12)`.
The union manuscript's eight exact family controls were also reproduced.
These computations corroborate the preceding independently checked proofs;
they do not supply a symbolic engine or a negative certificate for any tuple.

## 9. Reproduction outline for independent differential checks

The decisive oracle used direct definitions, not the finder's anchor search.
Its core was:

```python
from itertools import product

def direct_union(N, V, M, c):
    d = [min(c*v % M, -c*v % M) for v in V]
    small = [0 < a and (N-1)*a < M and a % N != 0 for a in d]
    if all(small):
        return True
    if any(v % M == 0 and v % N != 0
           and all(small[k] for k in range(N-1) if k != p)
           for p, v in enumerate(V)):
        return True
    for signs in product((-1, 1), repeat=N-1):
        a = [e*c*v % M for e, v in zip(signs, V)]
        if min(a) == 0:
            continue
        zero = [x for x in a if x % N == 0]
        if not zero:
            continue
        L, H = min(zero), max(zero)
        if H >= (N-1)*L or N*H*L > ((N-1)*L-H)*M:
            continue
        if all(x % N == 0 or (x < L and N*x*L <= (L-x)*M) for x in a):
            return True
    return False
```

Enumerate exactly the tuple/modulus/unit domains in Section 8, compare this
Boolean with `find_fixed_normalization(...) is not None`, and independently
compute each returned time with `fractions.Fraction`. For cell checks,
construct both signed affine functions and both classes at the actual reduced
ratio; enumerate anchors and evaluate the manuscript inequalities using
`Fraction`, then compare A and R separately with their direct definitions.
Density controls are reproducible from the frozen decision manuscript's
embedded exact construction with the additional domains stated above.

## 10. Remaining scope

Acceptance establishes an exact normalization reformulation, a mathematical
finite decision reduction, and a tested fixed-pair implementation. It does
not establish universal supply, equivalence with strict witness existence,
an implemented all-modulus decision engine, a complete negative certificate
for a particular tuple, or unrestricted LRC. Future negative results must
state whether they concern a fixed pair, a bounded search, or a verified
complete all-modulus decomposition.

The subsequently assigned symbolic engine is a separate checkpoint. Neither
its evolving source nor any future negative certificates are accepted by
this review's manuscript/implementation disposition.
