# Independent semantic review: sharper finite cutoff

Date: 2026-09-05. Reviewer assignment: `/root/mss_published_bound_audit`,
requested Astra/xhigh, independent of the Astra/high implementer. Runtime model
metadata is not independently exposed. Owned file: this review only.
Mathematical source baseline: `5e7d690e6606ad096bf4a2319be0328f9c6d2e68`.
Observed checkout HEAD during review: `cdd7f2c1e6a077726ee45a71b98ddd8591c97bf3`.
The source hashes below identify the reviewed working-tree artifact.

**Verdict: semantic approval; no actionable findings in the additive reduction.**
This establishes the sharper finite-family equivalence, conditional large-height
and normalization bridges, and their exact scopes. It supplies neither side of
the equivalence unconditionally. Full unrestricted LRC remains unresolved. This
review does not cover the separate Pass 29 manuscripts.

## Contract checks

1. **Count and cutoff.** `N = m + 2`, `m >= 1`, and
   `B_N = (Nat.choose (m + 2) 2)^m = (N(N-1)/2)^(N-2)`.
   `hQdouble` proves `2*Q = N(N-1)` as an exact natural-number identity before
   rational casts; there is no truncated-division assumption. The old cutoff is
   `2^(N-2)` times this value.

2. **Endpoint approximation and rank.** The approximation contract gives
   `1 <= q <= Q^m < H`, hence `p = H/q > 1`. Its endpoints satisfy `u_0=0`,
   `u_last=q`, and `v_0=v_last=0`. The residual identity makes every `q*v_i`
   integral. The existing primitive-rank argument remains applicable: rank
   failure would force every residual to vanish, then `H | q*s_i` for every
   coordinate. Primitive gcd one gives `H | q`, contradicting `0 < q < H`.
   Strict ordering supplies injectivity of the actual affine speeds.

3. **The factor two is used correctly.** The new theorem concludes loneliness
   only for label zero. At that label,
   `|v_i-v_0| <= p/Q = 2p/(N(N-1))`, exactly the accepted
   `rational_affine_lonelyAt` contract. Its downstream error is at most
   `1/(N(N-1))`, the margin between `1/(N-1)` and `1/N`. The implementation
   does not reuse the arbitrary-label triangle inequality with the smaller
   base or claim a smaller-cutoff arbitrary-label large-height theorem.

4. **Inclusive finite family and zero-label normalization.** The new finite
   obligation retains every runner label. The reverse proof deliberately uses
   only its label-zero instance. For an injective nonnegative integer tuple
   with distinguished zero label `r`, normalization supplies
   `a(e j)=c+g*b_j`, `g>0`, `b_0=0`, and primitive strictly ordered `b`.
   Evaluating at zero gives `c>=0`; evaluating at `e.symm r` gives `c<=0`.
   Thus `c=0`, injectivity gives `e 0=r`, and `e.symm r=0`. The exact case
   split is `H<=B_N` versus `B_N<H`; equality belongs to the finite branch.
   Witness transport uses the inverse permutation and time `T/g`, with the
   nonzero scale justified by `g>0`.

5. **Positive tuple and induction.** Appending zero to an injective positive
   natural tuple preserves injectivity and nonnegativity. The appended label's
   relative speeds are precisely the original moving speeds. At moving count
   `n>=2`, strong induction uses `m=n-1` and supplies only moving counts
   `1<=d<=N-2=n-1<n`; it does not assume the current count. Moving count one
   (`N=2`) is discharged by `oneMovingRunner`. No `m=0` finite obligation is
   silently required.

6. **Canonical scope.** The final declaration has exactly the type
   `LonelyRunner.Conjecture ↔ AllSharperInclusivePrimitiveFiniteFamilies`.
   The forward direction specializes arbitrary-real canonical witnesses to
   each bounded natural tuple and every chosen label. The reverse direction
   establishes the all-count positive-integer formulation and applies the
   existing unrestricted `conjecture_iff_positiveIntegerConjecture` bridge.
   `Conjecture` still quantifies over every total count at least two, every
   injective real speed tuple, every chosen runner, and a real witnessing
   time. All distance thresholds remain closed. The large-height theorem's
   positive-time conclusion is stronger than the real-time requirement of
   the family and canonical statements.

This is a coordinate proof of the published max-height cutoff, not a
formalization of Malikiosis--Santos--Schymura's stronger gcd-subset criterion
(Theorem A, [published article](https://doi.org/10.1017/fms.2025.10107)).
No LVP, shifted-LRC, zonotope, or novelty claim is introduced.

## Evidence and preservation

I read the exact four-file diff and current sources, including permanent axiom
probe imports, and the endpoint, primitive-rank, affine-witness, lower-count,
normalization, transport, base-case, and canonical bridge contracts. Read-only
comparison against the baseline found insertions only in all four files;
existing declarations and proofs are preserved. A combined 15-file set of
prerequisite Lean sources, the umbrella import, and pinned toolchain/manifest
was unchanged from the baseline.

The project workflow and current task records were inspected.
`python3 scripts/validate_workflow.py` passed; this is structural evidence only.
I inspected the implementer's exact five-theorem type/axiom probe source and
output: all five retain their premises and report only `propext`,
`Classical.choice`, and `Quot.sound`. No separate Lean build or cache operation
was run by this reviewer. Mechanical evidence was read from the implementer's
logs, separately from the semantic analysis above:

- Focused build: 3514 jobs passed, `/tmp/astra-sharper-cutoff-build.log`.
- Full pinned build: 3638 jobs passed,
  `/tmp/astra-sharper-cutoff-full-build.log`.
- Global trust audit: 432 theorem reports accepted, including all five new
  probes, `/tmp/astra-sharper-cutoff-trust.log`.

Pinned Lean: `leanprover/lean4:v4.32.1`.
Pinned mathlib: `520045ab14e26149ee970e2e617ca04b09bde5d6`.

## Reviewed source SHA-256

| File | SHA-256 |
| --- | --- |
| `LonelyRunner/FiniteHeightReduction.lean` | `d6ebb1974372dd8356c76b57ce322a6a7ca076404c7049b968cad207469f3406` |
| `LonelyRunner/FinitePrimitiveFamilies.lean` | `023b39b29e7939dd18b29a51217c3e3fcf353ee5843f3bc3effb27012137e9f0` |
| `LonelyRunner/FiniteFamilyEquivalence.lean` | `475a46b9e10226f3de30628e595073a9765a8c03cb0ab071bdcc10acb6446be3` |
| `LonelyRunner/AxiomAudit.lean` | `c500b0996ad5defd4bbab337d17b8b9a448d7f2b9e901b3f11e53e25084452aa` |

Any subsequent change to these bytes requires reassessing this approval.
Only this owned review file was written; source, shared workflow state, Git
state, dependencies, and caches were left to their respective owners.
