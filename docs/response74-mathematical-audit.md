# Independent mathematical audit of Response74

Task: `VERIFY-P74-MATHEMATICAL-AUDIT-174`

Recovery commit audited:
`967cabe9d0a94c2504e36e10473ef5eccef87adc`

Recovery provenance accepted at:
`1397c7ea75ccac75dce2067397881ec21123444e`

Immutable response SHA-256:
`dbe3073cbc6b25f890feec995ffa3baa369e65175721d01c4e33e1b5d3f5e94d`

## Disposition

**ACCEPT the exact common-scaling counterexample as `proved-math` and reject
`GLOBAL-DEGREE-2N-SIGNED-GRAM-GAP`.**

For every integer `c ≥ 6`, the positive injective tuple

\[
a=(c,2c,8c)
\]

has the frozen six-mode blocks

\[
K_c=-\tfrac14 I_6,
\qquad K_{2c}=-\tfrac14 I_6,
\qquad K_{8c}=0.
\]

The block sum is negative semidefinite and has largest eigenvalue exactly
zero, so no unit block vector has strictly positive energy. This is an exact
infinite family of counterexamples to the frozen signed-Gram lemma.

The family is not a counterexample to the pivot certificate or to Lonely
Runner. The pivot of speed `8c` has exactly `6c` uncovered candidates. In
particular, `r=9` is an explicit certificate for every `c≥6`, and
`t=9/(32c)` is an explicit closed-boundary Lonely Runner witness.

Response74's self-disposition was not used as evidence. It is now supported
only as a route disposition: the exact frozen spectral bridge is stopped.
Unrestricted LRC remains open.

## Frozen definitions reconstructed

For `n=3`, put `N=4`. At pivot speed `p=a_j`, let `M=4p` and

\[
R_j=\{0\le r<M:4\nmid r\}.
\]

For each nonpivot owner `i`, strict badness is

\[
\rho_M(ra_i)<p,
\qquad
\rho_M(x)=\min(x\bmod M,M-(x\bmod M)).
\]

Define `mu_j(r)` as the number of bad nonpivot owners and
`w_j(r)=1-mu_j(r)`. Thus uncovered points have weight `1`, singly covered
points weight `0`, and doubly covered points weight `-1`. Equality
`rho_M(ra_i)=p` is safe. The candidate filter excludes `r=0` and every
multiple of four.

With literal modes `m=0,…,5`, positive-sign characters, and
`q=ell-m`, the matrix is

\[
K_j[m,\ell]
=\frac1M\sum_{r\in R_j}w_j(r)
  \exp\!\left(\frac{2\pi i q r}{M}\right).
\]

This matches the frozen normalization: division is by the full pivot modulus
`M`, not by `|R_j|`, and repeated/aliased owner contributions remain in
`mu_j`.

## Exact base calculation

Take `b=(1,2,8)`. Direct enumeration using the strict condition gives:

| Pivot | Base modulus | Multiplicity histogram `#{mu=0},#{mu=1},#{mu=2}` | `G_j` | `sigma_j=sum(1-mu)` |
| ---: | ---: | ---: | ---: | ---: |
| 1 | 4 | `(0,2,1)` | 0 | -1 |
| 2 | 8 | `(0,4,2)` | 0 | -2 |
| 8 | 32 | `(6,12,6)` | 6 | 0 |

The nonzero weights are exactly:

\[
\begin{aligned}
p=1:&\quad w(2)=-1,\\
p=2:&\quad w(1)=w(7)=-1,\\
p=8:&\quad w=+1\text{ on }A,
\quad w=-1\text{ on }O,
\end{aligned}
\]

where

\[
A=\{9,10,11,21,22,23\},
\qquad
O=\{1,2,3,29,30,31\}.
\]

Every other candidate has multiplicity one and weight zero. Hence `A=Q_8`
and the weight-polynomial values at one are exactly `(-1,-2,0)`.

This calculation preserves the boundary. For example, at scaled pivot `8c`
and `r=9`, the pivot coordinate has cyclic distance exactly `8c`, so it is
safe rather than bad.

## Scaling-fiber proof

Let `a_i=c b_i`, set `M_j^0=4b_j`, and `M_j=cM_j^0`. Every
`0≤r<cM_j^0` is uniquely

\[
r=s+kM_j^0,
\qquad 0\le s<M_j^0,
\quad 0\le k<c.
\]

Since `4∣M_j^0`, `4∣r` iff `4∣s`; therefore the scaled candidate set is the
disjoint union of `c` copies of the base candidate set. Moreover,

\[
r(cb_i)\equiv c(sb_i)\pmod{cM_j^0}
\]

and

\[
\rho_{cM_j^0}(cu)=c\rho_{M_j^0}(u).
\]

Consequently strict badness, including equality safety, is preserved exactly:

\[
\rho_{cM_j^0}(r c b_i)<c b_j
\iff
\rho_{M_j^0}(s b_i)<b_j.
\]

Thus `mu^{cb}(s+kM_j^0)=mu^b(s)` and likewise for `w`. In particular,
`G_j(cb)=cG_j(b)`.

For a matrix frequency difference `q=ell-m`, the fiber factor is

\[
\sum_{k=0}^{c-1}\exp(2\pi i qk/c)
=
\begin{cases}
c,&c\mid q,\\
0,&c\nmid q.
\end{cases}
\]

The six literal modes give `|q|≤5`. The exact threshold `c≥6=2n` therefore
forces `c∣q` only when `q=0`. Every off-diagonal entry vanishes; on the
diagonal, the factor `c` cancels the scaled normalization:

\[
K_j^{cb}=\frac{\sigma_j(b)}{4b_j}I_6.
\]

Substitution of `sigma=(-1,-2,0)` proves the three claimed blocks for every
`c≥6`. For `c=6`, the scaled multiplicity histograms are exactly

\[
(0,12,6),\qquad(0,24,12),\qquad(36,72,36),
\]

on candidate sets of sizes `18,36,144`; hence `G=(0,0,36)`. No numerical
eigenvalue estimate is used.

The response's broader scaling statement is also correct when read in its
proper scope: if a positive injective base tuple has every `sigma_j≤0`, then
every common scaling `c≥2n` is a counterexample to the frozen signed-Gram
lemma. It is not thereby a counterexample to LRC.

## Surviving pivot certificate and LRC witness

At pivot speed `8c`, modulus `32c`, choose `r=9`. It is a candidate because
`4∤9`. The three cyclic distances are

\[
\rho_{32c}(9c)=9c,
\qquad
\rho_{32c}(18c)=14c,
\qquad
\rho_{32c}(72c)=8c.
\]

All are at least the pivot threshold `8c`; the last is equality. Therefore
`r=9` is an exact canonical pivot certificate. At time

\[
t=\frac9{32c},
\]

the three circle distances are `9/32`, `14/32`, and `8/32`, all at least
`1/4`. Thus this family positively exhibits the certificate and witness that
the spectral bridge failed to force abstractly.

This proves the logical boundary:

- `GLOBAL-DEGREE-2N-SIGNED-GRAM-GAP` is `rejected`;
- the pivot-certificate equivalence is not refuted;
- positive-integer LRC is not refuted; and
- unrestricted real LRC remains `open`.

The conditional implication from a positive signed form to a certificate is
sound: if every pivot were covered, every `mu_j(r)≥1`, so every weight is
nonpositive and every block energy is nonpositive. A positive block form would
contradict full coverage. The counterexample invalidates the universal
spectral premise, not that implication.

## Common-group normalization

The auxiliary `L=lcm_j M_j` calculation is sound. Reduction
`Z/LZ → Z/M_jZ` has exactly `L/M_j` points in each fiber, so

\[
\frac1L\sum_{x\bmod L}F_j(x\bmod M_j)
=\frac1{M_j}\sum_{r\bmod M_j}F_j(r).
\]

Pullback therefore neither changes `E_j` nor introduces cross-block terms.
For `(6,12,48)`, `L=192` and fiber sizes are `(8,4,1)`. The pulled-back form
remains

\[
-\tfrac14\lVert z_6\rVert^2
-\tfrac14\lVert z_{12}\rVert^2.
\]

This confirms that Attack B cannot repair the frozen form merely by changing
the carrier group.

## Auxiliary fixture audit

An independent integer-only checker enumerated the canonical candidates and
strict bad-owner multiplicities for all eight response fixtures. The reported
`G`, `sigma`, and complete multiplicity histograms match exactly, including:

- `Q_5={6,29}` and `Q_7={8,41}` for `(1,2,3,4,5,7)`;
- the first two fully covered pivots and `G=(8,8,10)` thereafter for
  `(1,6,11,12,13)`;
- the three signed supports for `(4,5,9)`;
- `Q_3={3,9}` and safe equality at `r=3` for `(1,2,3)`;
- the reflection-fixed antipodes for `(1,3,5)`, counted once; and
- coincident owner bad sets with multiplicity two at pivot `3` for
  `(1,3,13)`.

These bounded checks are `computed finite evidence` at exactly the displayed
fixture scope. They are not needed for the analytic counterexample beyond the
base tuple, whose complete weight sets are listed and proved above.

The response's comments about positive numerical directions at 12 modes and
the absence of a found direction at 6 modes for `(1,3,4,5,7,11)` remain
experimental diagnostics. They were not supplied with exact spectral
certificates and receive no evidence promotion here. They do not affect the
counterexample.

The inherited `PART-12` Fourier results and the three repository Lean
equivalences were not re-proved in this audit; their prior scoped labels are
preserved.

## Independent checker method

The following complete deterministic checker was run with WSL CPython 3.14.4:

```python
from collections import Counter

fixtures = [
    (1, 2, 8),
    (1, 2, 3, 4, 5, 7),
    (1, 6, 11, 12, 13),
    (4, 5, 9),
    (1, 2, 3),
    (1, 3, 5),
    (1, 3, 13),
    (1, 3, 4, 5, 7, 11),
]

def rho(M, x):
    u = x % M
    return min(u, M - u)

for a in fixtures:
    N = len(a) + 1
    print(a)
    for j, p in enumerate(a):
        M = N * p
        R = [r for r in range(M) if r % N != 0]
        mu = {
            r: sum(i != j and rho(M, r * a[i]) < p
                   for i in range(len(a)))
            for r in R
        }
        Q = tuple(r for r in R if mu[r] == 0)
        counts = Counter(mu.values())
        histogram = tuple(counts[k]
                          for k in range(max(counts, default=0) + 1))
        sigma = sum(1 - mu[r] for r in R)
        support = tuple((r, 1 - mu[r]) for r in R if 1 - mu[r] != 0)
        print(p, M, len(R), Q, sigma, histogram, support)
```

The snippet is the complete source used for the fixture replay and is bound by
this document's SHA-256. It exhausts every candidate at every pivot of the
eight declared fixtures in their listed order. No random seed, tolerance,
floating arithmetic, early stop, or external package is involved. No
recovered code existed or was executed. Exact root-of-unity cancellation and
matrix normalization were proved algebraically above rather than inferred
numerically.

## Evidence labels

| Claim | Recommended label |
| --- | --- |
| Common-scaling candidate/multiplicity identity | `proved-math` |
| Six-mode fiber cancellation for `c≥6` | `proved-math` |
| Exact blocks for `(c,2c,8c)`, `c≥6` | `proved-math` |
| `G=(0,0,6c)` and explicit `r=9` certificate | `proved-math` |
| `GLOBAL-DEGREE-2N-SIGNED-GRAM-GAP` | `rejected` |
| Conditional positive-form-to-certificate implication | `proved-math` |
| Auxiliary finite fixture tables | `computed finite evidence` |
| Uncertified fixture spectral-sign comments | `experimental`; no promotion |
| Primitive-only or scale-invariant replacement | `open` |
| Positive-integer and unrestricted real LRC | `open` |

No Lean theorem was added, compiled, or promoted. Formal status remains
manuscript-level `proved-math` until a separate exact formalization is accepted.

## Discrepancies and remaining boundary

No mismatch was found in the exact target family, scaling threshold, strict
boundary, character sign, normalization, matrices, uncovered count, or
logical scope.

One wording requires continued care: “counterexample after common scaling”
means a counterexample to the frozen signed-Gram lemma only. Response74's
surrounding context uses it that way, and the explicit certificate above rules
out any interpretation as an LRC counterexample.

The strongest surviving research question is a genuinely different,
scale-invariant or primitive-only spectral statement. Response74 does not
establish one.
