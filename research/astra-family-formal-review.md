# Independent formal review of the one-outlier family

Date: 2026-09-05. Reviewer task: `/root/vanishing_slope-family-formal-review`,
requested Astra/xhigh. The runtime does not independently expose its model or
effort; the routing record is not used as mathematical evidence.

**Accepted without source corrections.** Both public declarations prove the
specified family for every odd natural number `N ≥ 5` and every positive natural
outlier `v`, including composite `N` and nonunit `v` modulo `N`. This is a
kernel-checked sufficient family, not the unrestricted Lonely Runner Conjecture.

## Source binding and review boundary

- Reviewed the entire `LonelyRunner/AffineOneOutlierFamily.lean`, SHA-256
  `f4340eda138464cb2383af4582d1bbb64237cb31153f5296504023feaf994ec8`.
- Compared with Section 6 of `research/astra-exact-band-route.md`, SHA-256
  `0e2d264986a98b69d93cbfd28ffd81f759df6031869b96a3219249e77b504554`.
- Checkout HEAD during review: `4d65e3f47fdea6c0f920f01b928310af833d3247`;
  the reviewed source was an uncommitted checkpoint artifact. The source hash,
  rather than HEAD alone, binds this acceptance.
- Toolchain: `leanprover/lean4:v4.32.1`. Pinned `lake-manifest.json` SHA-256:
  `887450bc75a38effdae452a14b60f6d225bc10b48c71b3827e3479b800f41218`.
- Read the current configuration, workflow, policy and state; workflow structural
  validation passed. Only this review note was written. No theorem, state,
  integration, cache or Git changes were made by this review.

The earlier manuscript review and weighted formal review remain frozen at
`d489613c466422a94e1a1d95360bbba6854fc073765267b5fc47dd4496ba125a` and
`001591836ecb1bebbcb3145334fb95a5df70218280ff0c046ef250d2c880046d`, respectively.
The active cyclic-grid module is outside this review.

## Exact public contracts

The fresh `#check` output confirms the following types (with explicit real
annotations added here for readability):

```lean
affine_one_outlier_family_witness_nat (N v : ℕ)
    (hN : 5 ≤ N) (hodd : Odd N) (hv : 0 < v) :
    ∃ t : ℝ,
      (N : ℝ)⁻¹ ≤ circleNorm (t * v) ∧
      (N : ℝ)⁻¹ ≤ circleNorm (t * N) ∧
      (N : ℝ)⁻¹ ≤ circleNorm (t * (2 * N : ℕ)) ∧
      ∀ a : ℕ, 2 ≤ a → a ≤ N - 3 →
        (N : ℝ)⁻¹ ≤ circleNorm (t * a)

affine_one_outlier_family_witness (N v : ℕ)
    (hN : 5 ≤ N) (hodd : Odd N) (hv : 0 < v) :
    ∃ t : ℝ,
      (N : ℝ)⁻¹ ≤ circleNorm (t * v) ∧
      (N : ℝ)⁻¹ ≤ circleNorm (t * N) ∧
      (N : ℝ)⁻¹ ≤ circleNorm (t * (2 * N : ℕ)) ∧
      ∀ a : ℤ, 2 ≤ a → a ≤ (N : ℤ) - 3 →
        (N : ℝ)⁻¹ ≤ circleNorm (t * a)
```

There is one common real time before the quantifier over the entire core. The
threshold is closed. All displayed speeds are the actual speeds, with no
normalization, supplied witness, prime instance, coprimality, distinctness or
height hypothesis. For `N ≥ 5`, the core has `N-4` labels and the three displayed
extra labels make `N-1`. Duplicates are permitted; this is not a claim that the
underlying set always has `N-1` distinct elements. To obtain a distinct family,
exclude outliers already in the core or equal to `N` or `2*N`.

The integer version loses no indices. From `2 ≤ a` it obtains `0 ≤ a`, transports
both bounds to `a.toNat`, invokes the natural theorem, and rewrites the real cast
using `Int.toNat_of_nonneg`. There are no negative core speeds admitted by these
bounds. The only local typeclass added in the natural theorem is `NeZero N`,
derived from `5 ≤ N`.

## Independent proof audit

Write `h=(N+1)/2` and `t_k=k/N+1/N²`. In `ZMod N`, oddness proves `2h=1`.
The proof needs this inverse of two and `3 ≠ 0`, the latter following from
`0 < 3 < N`; it never assumes that three or every nonzero residue is a unit.

For nonzero `x` and arbitrary `q`, the three candidates are
`x+q`, `h*x+q`, and `-x+q`. The first and third are distinct because two is
invertible. If both lie in `{0,-1}`, they occupy opposite elements, so
`2*x=1` or `2*x=-1`. The middle candidate cannot equal the first: doubling
such an equality would force `x=0`. If it equalled the third, doubling gives
`3*x=0`; together with `2*x=±1`, this forces `3=0`, a contradiction. Thus the
three candidates cannot all lie in the two-element forbidden set. This remains
valid for `N=9` or `15`, where three is a zero divisor. The source's
`linear_combination` arguments implement precisely these ring identities.

For each core `2 ≤ a ≤ N-3`, all three choices
`k∈{1,h,N-1}` avoid residues zero and minus one. The source uses the nonzero
casts of `a`, `a+1`, `a+2`, the identity `2h=1`, and `a≠1`. It does not cancel
`a`; composite-modulus core speeds such as `N=9,a=3` are covered.

The transport includes the full outlier quotient. With natural-number divisions,
put `H=k*v+v/N`. Two Euclidean division identities give exactly

```text
t_k*v = floor(H/N) + ((H mod N) + (v mod N)/N)/N.
```

Avoidance gives `1 ≤ H mod N ≤ N-2`. The remaining correction belongs to
`[0,1)`, so the numerator lies in `[1,N-1]`. The helper then invokes the existing
closed integer-band theorem. In particular, this is valid for arbitrarily large
`v`; replacing `H` by `k*v` would be incorrect. The two fixed speeds have phases
`k+1/N` and `2k+2/N`, giving the required bounds for `N ≥ 5`.

The public theorem makes the exhaustive three-way split:

1. If `N ∤ v`, the ring lemma with `x=v` and `q=floor(v/N)` chooses one of the
   three times. It handles nonzero nonunits as well as units.
2. If `N | v` and `N² ∤ v`, write `v=N*d`. Then `N ∤ d` and
   `t_1*v=d+d/N`; the nonzero denominator-`N` residue has distance at least
   `1/N`. All core and fixed rows remain good at `t_1`.
3. If `N² | v`, use the actual time `t=t_1+1/(N*v)`. Writing `v=N²*d` gives
   `t*v=d*(N+1)+1/N`. Positivity and `N | v` imply `v ≥ N`, hence
   `0 ≤ N/v ≤ 1`. The phase of `N` is
   `1+(1+N/v)/N`, whose numerator belongs to `[1,2]`; that of `2*N` is
   `2+(2+2*N/v)/N`, with numerator in `[2,4]`. Both lie in `[1,N-1]` because
   `N ≥ 5`. For a core speed the phase is `(a+a/N+a/v)/N`;
   each of the last two terms is between zero and one, so its numerator lies
   between `a ≥ 2` and `a+2 ≤ N-1`.

The third branch's weaker bound `v ≥ N` is sufficient for these closed band
estimates. Square divisibility is still used in the extra speed's exact integer
phase, so the proof has not silently replaced that branch's substantive
condition. No wrapping is ignored: every invocation displays an integer plus a
fraction whose numerator is between one and `N-1`. The source directly perturbs
the original speeds, avoiding any unsupported transfer from lifted representatives.

## Fresh Lean verification

The following exact-source command completed successfully with no output:

```sh
env PATH="$HOME/.elan/bin:$PATH" lake env lean LonelyRunner/AffineOneOutlierFamily.lean
```

A separate `lake env lean --stdin` run imported the module, checked both public
types, printed their axioms, and compiled six contract probes: `N=5,v=1` with
the one-element integer core; arbitrary positive symbolic `v` at composite
`N=9`; the natural core at `N=9,v=3` (a nonunit); `N=9,v=18` (divisible but
not square-divisible, also a duplicate fixed speed); `N=9,v=81`; and `N=5,v=25`.
All passed. The symbolic composite probe alone quantifies over every positive
outlier, rather than checking only selected instances.

The exact axiom outputs were:

```text
'LonelyRunner.affine_one_outlier_family_witness_nat' depends on axioms: [propext, Classical.choice, Quot.sound]
'LonelyRunner.affine_one_outlier_family_witness' depends on axioms: [propext, Classical.choice, Quot.sound]
```

A word-boundary source search for `sorry`, `admit`, `axiom`, `native_decide`,
`unsafe`, `run_tac`, `implemented_by`, and `extern` returned no matches.
The fresh compile and axiom probe are this review's evidence. The separately
reported full integration build and audit are not represented as independently
rerun here.

The following compact probe reproduces the most important unrestricted contract
checks; the six instantiated checks above are applications of these declarations
using `simpa` and numeral proofs by `omega`/`decide`.

```sh
env PATH="$HOME/.elan/bin:$PATH" lake env lean --stdin <<'LEAN'
import LonelyRunner.AffineOneOutlierFamily
open LonelyRunner
#check affine_one_outlier_family_witness_nat
#check affine_one_outlier_family_witness
#print axioms affine_one_outlier_family_witness_nat
#print axioms affine_one_outlier_family_witness
example (v : ℕ) (hv : 0 < v) : ∃ t : ℝ,
    (9 : ℝ)⁻¹ ≤ circleNorm (t * v) ∧
    (9 : ℝ)⁻¹ ≤ circleNorm (t * 9) ∧
    (9 : ℝ)⁻¹ ≤ circleNorm (t * 18) ∧
    ∀ a : ℤ, 2 ≤ a → a ≤ 6 → (9 : ℝ)⁻¹ ≤ circleNorm (t*a) := by
  simpa using affine_one_outlier_family_witness 9 v (by omega) (by decide) hv
example : ∃ t : ℝ,
    (5 : ℝ)⁻¹ ≤ circleNorm (t * 25) ∧
    (5 : ℝ)⁻¹ ≤ circleNorm (t * 5) ∧
    (5 : ℝ)⁻¹ ≤ circleNorm (t * 10) ∧
    ∀ a : ℤ, 2 ≤ a → a ≤ 2 → (5 : ℝ)⁻¹ ≤ circleNorm (t*a) := by
  simpa using affine_one_outlier_family_witness 5 25 (by omega) (by decide) (by omega)
LEAN
```

## Independent exact arithmetic controls

The following standalone Fraction/integer control imports no project code. It
passed 2,024 ring cases and 4,270 complete family cases across `N=5,9,15,21,25,27`.
Branch counts were respectively 4,054 nondivisible, 198 divisible nonsquare and
18 square-divisible; each count includes selected outliers above `10^30`.
The finite controls support the implementation audit; the all-input result is
provided by the kernel-checked declarations.

The negative control `N=9,v=64` specifically catches dropping the quotient:
at `t_1=10/81`, the extra speed has distance `8/81 < 1/9`, while `t_5=46/81`
works for every row. The source chooses using the full quotient and remainder.

```python
# BEGIN INDEPENDENT FAMILY FORMAL CONTROLS
from fractions import Fraction as F

def norm(x):
    r = x % 1
    return min(r, 1-r)

ring_count = 0
for N in (5, 9, 15, 21, 25, 27):
    ks = (1, (N+1)//2, N-1)
    for x in range(1, N):
        for q in range(N):
            assert any((k*x+q) % N not in (0, N-1) for k in ks)
            ring_count += 1

family_count = 0
branches = [0, 0, 0]
for N in (5, 9, 15, 21, 25, 27):
    ks = (1, (N+1)//2, N-1)
    vs = list(range(1, 2*N*N+1)) + [N*N*10**30+1, N*N*10**30+N, N*N*10**30]
    for v in vs:
        if v % N:
            k = next(k for k in ks if (k*v+v//N) % N not in (0, N-1))
            t = F(k, N) + F(1, N*N)
            branches[0] += 1
        elif v % (N*N):
            t = F(N+1, N*N)
            branches[1] += 1
        else:
            t = F(N+1, N*N) + F(1, N*v)
            branches[2] += 1
        assert all(norm(w*t) >= F(1, N) for w in (*range(2, N-2), v, N, 2*N)), (N, v, t)
        family_count += 1
assert norm(64*F(10, 81)) == F(8, 81) < F(1, 9)
assert all(norm(w*F(46, 81)) >= F(1, 9) for w in (*range(2, 7), 64, 9, 18))
assert (ring_count, family_count, branches) == (2024, 4270, [4054, 198, 18])
print("family formal review controls passed", ring_count, family_count, branches)
# END INDEPENDENT FAMILY FORMAL CONTROLS
```

This source satisfies the complete requested family contract. No theorem
correction, additional hypothesis or withheld coordinate is required. There is
no conclusion here for even `N`, arbitrary speed tuples, global normalization
supply, or the canonical unrestricted conjecture.
