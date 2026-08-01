# Audited round-6 structural lemmas

This note separates three mathematically valid fixed-integer-tuple lemmas from
the computational conjecture suggested in GPT-5.6 Sol Pro round 6. None is a
proof of the Lonely Runner Conjecture. The lemmas have been independently
audited on paper and by exact computation where applicable. The boundary-pivot
and divisor-insertion lemmas are now formalized in Lean; the pair-sum theorem
remains a paper proof.

Throughout, `a_1,...,a_n` are positive integers, `N=n+1`, and

\[
F_A(t)=\min_i \lVert a_i t\rVert.
\]

The boundary convention is closed: a witness satisfies
`F_A(t) >= 1/N`.

## 1. Boundary-pivot completeness

For a fixed nonempty positive-integer tuple, existence of an arbitrary real
witness is equivalent to existence of a canonical natural modular-pivot
certificate. In particular, if a witness exists, then one exists in a pivot
grid:

\[
t=\frac{Nm\mathbin\pm1}{Na_j}
\]

for some index `j` and integer `m`.

Proof. Work on `T=R/Z` and let

\[
S=\{t\in T:\lVert a_i t\rVert\ge 1/N\text{ for every }i\}.
\]

The set is nonempty by hypothesis, closed by continuity, and proper because
`0` is not safe. The circle is connected, so a nonempty proper closed subset
has nonempty boundary. At a boundary point `t'`, some constraint must be
tight: if all finitely many inequalities were strict, their minimum slack and
continuity would give a safe neighborhood, making `t'` interior. Thus
`||a_j t'||=1/N` for some `j`. Solving this equality modulo one gives the
displayed form.

The Lean proof in `LonelyRunner/PivotBoundary.lean` implements the same
boundary principle through a finite minimum and the intermediate value
theorem along the segment from time zero to the supplied witness. It then
extracts a signed numerator, normalizes it modulo `N a_j`, and preserves every
integer-speed phase under the resulting integral time shift. The argument is
uniform at the antipodal endpoint `N=2`.

More precisely, `exists_witness_iff_exists_pivot_certificate` proves, for
fixed `speeds : Fin n → ℕ`, an anchor witnessing `n>0`, `N≥2`, and positive
speeds, the equivalence

```text
(∃ t, ∀ i, N⁻¹ ≤ circleNorm (t * speeds i))
  ↔
∃ pivot r,
  r ∈ pivotCandidates N (speeds pivot) ∧
  ∀ i ≠ pivot,
    r ∉ pivotBadResidues N (speeds pivot) (speeds i).
```

The reverse direction uses `pivotResidueWitness`; the forward direction uses
the new boundary-pivot completeness theorem and the exact bad-residue
converse from `LonelyRunner/PivotResidues.lean`. At conjecture level,
`positiveIntegerConjecture_iff_pivotCertificateConjecture` proves

```text
PositiveIntegerConjecture ↔ PositiveIntegerPivotCertificateConjecture.
```

Thus the pivot-grid formulation is exactly equivalent to the positive-integer
problem, not a stronger ansatz. This equivalence supplies no uniform theorem
that a certificate exists: proving that some pivot bad-set union is proper for
every tuple remains the central integer obstruction. It also does not reduce
arbitrary real relative velocities to positive integers; that separate
simultaneous-approximation/Kronecker step remains open in Lean.

## 2. Pair-sum critical spectrum

For `n>=2`,

\[
\max_{t\in\mathbb R}F_A(t)=
\max_{p<q}\ \max_{0\le r<a_p+a_q}
F_A\!\left(\frac r{a_p+a_q}\right).
\]

Proof audit. Periodicity and continuity give a maximizer, and a sufficiently
small positive time shows that the maximum `M` is positive. If `M=1/2`, every
coordinate is half-integral at a maximizer, so the sum of any two active
phases is integral. If `0<M<1/2`, every active triangular wave is locally
affine with nonzero slope. Inactive coordinates retain strict slack locally.
Local maximality of the lower envelope forces active slopes of both signs;
they come from distinct indices `p,q`. Adding their two active equations gives
`(a_p+a_q)t` integral. Reducing the numerator modulo the denominator proves
the formula.

The invariant denominator bound is

\[
\max_{p<q}(a_p+a_q).
\]

No ordering or distinctness is needed. If the tuple is sorted, this is at most
`2a_n`; if it is sorted and pairwise distinct, it equals
`a_{n-1}+a_n <= 2a_n-1`. Sol Pro's first response omitted those hypotheses
from the sharper bound; the corrected statement above survived independent
audit. The committed regression suite exhaustively checks all 784
nondecreasing tuples of two through five speeds from `1,...,7`, including
repetitions, and finds no mismatch with the exact piecewise-linear optimizer.

This theorem gives a finite blocking formulation for each fixed tuple, but no
height bound for a minimal counterexample.

## 3. Codimension-one divisor insertion

Fix an exceptional index `j`, set

\[
D_j=\gcd(a_i:i\ne j),\qquad
m=\frac{D_j}{\gcd(D_j,a_j)},
\]

and assume LRC for the divided `(n-1)`-tuple `(a_i/D_j)_{i\ne j}` at its
threshold `1/n`. If

\[
N(m-1)\ge 2m,
\]

then the full tuple has a witness at threshold `1/N`.

Proof. Let `s` witness the divided tuple. At times
`t_k=(s+k)/D_j`, `0<=k<D_j`, every old coordinate has the same phase as at
`s`, so it remains at distance at least `1/n > 1/N`. The exceptional phases
form a rotated equally spaced orbit of size `m`. One of its points has circle
distance at least `(m-1)/(2m)`, which is at least `1/N` by the displayed
condition. Equality is allowed throughout.

This argument is kernel-checked as `codimensionOneDivisorInsertion` in
`LonelyRunner/DivisorInsertion.lean`. Its interface factors
`D=g*m` and the exceptional speed as `g*c` with `c` coprime to `m`; hence `m`
is exactly the reduced orbit size. The supporting theorems
`exists_int_grid_circleNorm_ge` and
`exists_int_coprime_grid_circleNorm_ge` prove the translated-grid bound and
the coprime-step permutation without finite enumeration.

For a primitive tuple, `gcd(D_j,a_j)=1`, hence `m=D_j`. The exact valid
deletion-gcd corollary must retain the induction hypothesis:

- For an arbitrary primitive counterexample in dimension `n`, deletion gcd
  one does not follow automatically.
- For a primitive counterexample of minimal dimension, or after LRC has been
  established in dimension `n-1`, every deletion gcd violates
  `N(D_j-1)>=2D_j`.
- Since this is equivalent to `(n-1)D_j>=n+1`, for `n>=3` it holds exactly
  when `D_j>=2`; only in this setting does every deletion gcd equal one. For
  `n=2`, the lemma only rules out `D_j>=3`.

Exact enumeration independently reproduces Sol Pro's six-runner counts. Among
primitive residual tuples, the arithmetic condition holds for 96 of 2,240
tuples through speed 15 and 20,878 of 239,928 through speed 30. The first
speed-15 example is `(1,2,4,6,8,14)`, with exceptional speed `1`, deletion gcd
`2`, and `m=2`. These are conditional insertion counts, not unconditional
proofs unless the five-runner integer theorem is supplied.

The same arithmetic test holds for 925 of the 28,259 primitive residual
seven-speed tuples through speed 20 and none of the 1,716 residual eight-speed
tuples through speed 15. These latter counts would require the corresponding
six- or seven-speed theorem before they become insertion proofs.

## 4. Half-parent computational conjecture

Sol Pro proposed allowing parent capacity

\[
p_n=\left\lceil\frac{n-2}{2}\right\rceil
\]

in the ordered overlap certificate. Exact dynamic programming over every
ordering and permitted parent subset gives:

| moving runners | cutoff | primitive residual tuples | certified at proposed capacity |
|---:|---:|---:|---:|
| 6 | 30 | 239,928 | 239,928 at capacity 2 |
| 7 | 20 | 28,259 | 28,259 at capacity 3 (also all at capacity 2) |
| 8 | 15 | 1,716 | 1,716 at capacity 3 |

At eight speeds, capacity two certifies only 1,714 tuples. Its two failures are
`(1,2,5,7,9,11,12,13)` and `(1,5,7,8,9,11,13,15)`. Both have a capacity-three
bound `50<56` at pivot `7`, with witnesses `8/63` and `20/63` respectively.

This finite evidence does not establish the half-parent rule for larger
speeds or arbitrary dimension. No proposed induction on overlap structure is
currently proved.

Reproduce the bounded counts and all regression counterexamples with:

```sh
python3 scripts/search_residual.py --runners 7 --max-speed 20 --primitive-only --sol-pivot-counts
python3 scripts/search_residual.py --runners 8 --max-speed 15 --primitive-only --sol-pivot-counts --parent-capacity 3
python3 scripts/search_residual.py --runners 6 --max-speed 30 --primitive-only --counts-only
python3 -m unittest discover -s tests -v
```
