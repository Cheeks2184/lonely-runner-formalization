# Pair-sum geometry route

This note records a finite, non-Fourier interface for the exact compiled
positive-integer Lonely Runner problem. It also records counterexamples to
four tempting structural shortcuts. Nothing here proves the conjecture.

## 1. Literature anchor

For positive primitive integer velocities `v = (v_1,...,v_n)`, the standard
geometry-of-numbers model projects the cube

\[
  [1/(n+1),n/(n+1)]^n
\]

along the velocity line. The projected cube is a lattice zonotope with `n`
generators in dimension `n-1`; a lonely time exists exactly when its specified
central translate contains a lattice point. This is Proposition 1.5 and the
surrounding construction in Malikiosis--Santos--Schymura,
[*Linearly-exponential checking is enough for the Lonely Runner Conjecture and
some of its variants*](https://doi.org/10.1017/fms.2025.10107), pp. 3--5.
That paper also proves an inductive finite-checking theorem in terms of the
number of lattice points of the associated zonotope (Theorem A/A').

The newer preprint by Blanco--Criado--Santos,
[*Coloopless zonotopes and counterexamples to the Shifted Lonely Runner Conjecture*](https://arxiv.org/abs/2603.24784v2),
places LR zonotopes in a wider coloopless class and explicitly warns against
silently replacing the distinguished central-coset statement by a universal
covering-radius assertion: its Theorem 1.17 gives shifted-LRC counterexamples beginning with
five moving speeds (six total runners; zonotope dimension four). Thus a valid unshifted geometry argument must retain the
specified centre/coset.

## 2. The finite certificate

Let `a_1,...,a_n` be distinct positive integers and put `N=n+1`. For a pair
`p != q`, set

\[
  D=a_p+a_q,
  \qquad d_D(x)=\min(x\bmod D,D-(x\bmod D)).
\]

The proposed finite lemma is

> **Universal pair-sum certificate (for `n >= 2`).** There are `p != q` and `0 <= r < D`
> such that, for every `i`,
> \[
>     D\leq N d_D(r a_i).
> \]

This statement is finite for each tuple: at most
`sum_{p<q}(a_p+a_q)` numerators need to be examined. Moreover,

\[
  \left\|\frac{r a_i}{D}\right\|
    =\frac{d_D(r a_i)}D,
\]

so its conclusion gives a Lonely Runner witness at `t=r/D`, including equality
at the boundary.

`LonelyRunner/PairSumGeometry.lean` defines this as `PairSumCertificate` and
kernel-checks both the exact residue-to-circle bridge
`pairSumCertificate_iff_pair_time`, its witness corollary
`pairSumCertificate_circleNorm`, and

```text
PositiveIntegerPairSumCertificateConjecture -> PositiveIntegerConjecture.
```

No measure positivity or Fourier coefficient estimate is used.
The implication dispatches the omitted `n=1` case with the already checked
`oneMovingRunner` theorem; demanding a distinct pair at `n=1` would make the
certificate conjecture vacuously impossible.

The global-extremal motivation is the pair-sum critical spectrum already
audited in `docs/round6-strategies.md`: a maximum of
`min_i ||a_i t||` occurs at `r/(a_p+a_q)` because two active triangular-wave
facets have opposite slopes. Fully formalizing that extremal theorem would
show that the finite certificate is not merely sufficient but complete for
every fixed tuple known to have a witness. It does not prove universal
existence; that is the remaining geometric/arithmetic obstruction.

## 3. Exact failures of structural pair selection

Four natural attempts to reduce the pair family fail.

| proposed allowed pairs | first exact failure | unrestricted witness |
|---|---:|---:|
| adjacent speeds in sorted order | `(1,2,3)` | pair `(1,3)`, `t=1/4` |
| pairs containing the minimum | `(1,3,4)` | pair `(3,4)`, `t=3/7` |
| the minimum--maximum pair only | `(1,2,4)` | pair `(1,2)`, `t=1/3` |
| pairs containing the maximum | `(2,6,8,10,11)` | pair `(8,10)`, `t=2/9` |

These are counterexamples only to the restricted selection rules, not to LRC.
For example, at `t=2/9` the last tuple has distances

\[
  4/9,\ 1/3,\ 2/9,\ 2/9,\ 4/9,
\]

all at least `1/6`. The four denominators involving its maximum speed are
`13,17,19,21`; exhaustive natural-residue enumeration finds no valid
numerator for any of them.

Reproduce the full search, using exactly the same integer inequality as the
Lean definition, with

```sh
python3 scripts/search_pair_sum_geometry.py --max-runners 8 --max-speed 25
python3 scripts/search_pair_sum_geometry.py --mode all --max-runners 7 --max-speed 15
python3 -m unittest tests.test_pair_sum_geometry -v
```

The first command searches tuples in dimension-first lexicographic order and
prints the first failure of each rule together with an unrestricted pair-sum
witness. All decisions are exact integer or rational computations.
The unrestricted search reports no failure among all 16,368 distinct tuples
with two through seven moving speeds drawn from `1,...,15`. This is only a
bounded regression check, not evidence of a height bound or an
all-dimensional proof.

## 4. Remaining obligation

The useful geometry-of-numbers target is now precise:

```text
GEO-PAIR-01: prove PositiveIntegerPairSumCertificateConjecture.
```

One cannot assume that the active pair is adjacent, incident to an extremal
speed, or fixed in advance. A successful convex proof has to exploit the
distinguished central lattice coset and allow an arbitrary active pair. The
known shifted counterexamples rule out upgrading this to a claim about every
translate.
