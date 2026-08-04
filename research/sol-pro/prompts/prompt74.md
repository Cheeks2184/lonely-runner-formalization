---
owner: GPT-5.6 Sol High top-level desktop orchestrator
supervising_authority: /root
launch_runtime: original browser-capable desktop Codex session
role: Research Pipeline Lead - prompt preparation only
task_id: PIPE-P74-GLOBAL-PSD-CHARACTER-CONTRACT-139
---

# Prompt 74: GLOBAL-DEGREE-2N-SIGNED-GRAM-GAP

This is one isolated unrestricted Sol Pro research contract. Prove or
decisively refute the exact height-independent signed character/PSD bridge
below. The route uses a direct sum of explicitly normalized character Gram
forms over the separate pivot moduli, with an optional exact pullback to one
common auxiliary cyclic group.

This file is a prepared contract only. It is not a browser launch, response,
proof, computation, audit, or mathematical promotion. Only GPT-5.6 Sol High
under `/root`, using the original signed-in browser-capable desktop session,
may launch the Pro turn. Do not delegate research to Luna.

This route must remain distinct from:

- Prompt68 cofinite prime forcing;
- Prompt69 weighted uncovered-count deficit injection;
- Prompt70 simultaneous-full-cover common-prime propagation;
- Prompt72 modular-cover circuit expansion;
- Prompt66 packing, radial descent, and signed phase cells;
- the rejected `sum_j G_j >= n` target;
- a zero-frequency identity or Parseval applied to the unknown good indicator;
  and
- frozen top-two, owner-shift, Gamma, height, deletion, and descent routes.

Use `proved-lean`, `proved-math`, `computed finite evidence`, `conditional`,
`conjectural`, `rejected`, and `open` literally. The response may recommend a
disposition but may not promote its own mathematics before independent audit.

## Existing exact boundary

The repository has the `proved-lean` equivalences

```text
exists_witness_iff_exists_pivot_certificate
positiveIntegerConjecture_iff_pivotCertificateConjecture
conjecture_iff_positiveIntegerConjecture.
```

They identify a fixed-instance canonical pivot certificate with a real witness
and reduce unrestricted real LRC to the positive-integer statement. They do not
prove that a certificate exists.

`PART-12` is only `proved-math`: the normalized candidate-filter transform,
strict Dirichlet kernel, gcd-supported multiplication pullback, and actual
bad-set convolution are audited in `docs/fourier-pivot-badsets.md`. They are
not Lean-formalized and do not supply the bridge below. Factorwise absolute
main-term domination is explicitly refuted, including at every pivot of
`(4,5,9)` despite its certificates. Do not reuse that criterion.

## Frozen modular definitions and strict boundary

Let `n : Nat`, `2 <= n`, put `N=n+1`, and let

```text
a : Fin n -> Nat
```

be positive and injective. For each pivot `j : Fin n`, define

```text
p_j = a_j,
M_j = N*p_j,
rho_M(x) = min(x mod M, M-(x mod M)),
R_j = {r : Fin M_j | N does not divide r.val},
B_i^j = {r : R_j | rho_(M_j)(r.val*a_i) < p_j}  for i != j,
mu_j(r) = #{i : Fin n | i != j and r in B_i^j},
Q_j = {r : R_j | mu_j(r)=0},
G_j(a) = |Q_j|.
```

Badness is strict `<p_j`; equality is safe. Never replace cyclic distance by a
one-sided interval. Every residue uses its unique representative, and
`N`-multiples are excluded, making the pivot coordinate safe. Original speeds
are injective integers, but modular residues need not be distinct. Retain
nonunits, gcd degeneracies, repeated residues, coincident bad sets, and
separate owner multiplicities in `mu_j`.

Reflection `r |-> -r` must handle its fixed points without doubling. The pivot
groups have different moduli. No character or residue at one pivot is silently
identified with one at another pivot.

## Frozen degree-`2n` character Gram forms

Let the height-independent mode set be

```text
D_n = Fin (2*n).
```

For `m : D_n`, `r : Fin M_j`, use the positive-sign character

```text
chi_(j,m)(r) = exp(2*pi*I*m.val*r.val/M_j).
```

For `z : D_n -> Complex`, put

```text
P_(j,z)(r) = sum_(m : D_n) z_m * chi_(j,m)(r),

E_j(z) = (1/M_j) * sum_(r in R_j)
           (1-mu_j(r)) * |P_(j,z)(r)|^2.
```

Here `1-mu_j(r)` is an integer embedded in the reals. State complex norm-square
and conjugation conventions exactly. Frequencies are the literal integers
`0,...,2n-1`; when `M_j<2n`, character aliasing is retained rather than
quotiented away.

Equivalently define the Hermitian matrix

```text
K_j[m,l] = (1/M_j) * sum_(r in R_j)
  (1-mu_j(r)) * conjugate(chi_(j,m)(r))*chi_(j,l)(r),
```

and prove `E_j(z)=conjugate(z)^T K_j z`. Each term
`v_j(r)*v_j(r)^*` is positive semidefinite; `K_j` is their **signed** weighted
sum and is not assumed positive semidefinite.

For a block vector `Z=(z_j)_(j : Fin n)`, define

```text
||Z||^2 = sum_j sum_m |z_j(m)|^2,
E_a(Z) = sum_j E_j(z_j).
```

All normalizations are frozen. Multiplying a form by a hidden height-dependent
constant, changing the number of modes after seeing the tuple, or choosing a
frequency cutoff depending on `max a_i` is prohibited.

## Sole unrestricted PSD/character lemma

There is exactly one permitted unresolved bridge:

```text
GLOBAL-DEGREE-2N-SIGNED-GRAM-GAP:

For every n : Nat with 2 <= n and every positive injective
a : Fin n -> Nat, there exists a block vector Z such that

  ||Z||^2 = 1  and  E_a(Z) > 0.
```

Equivalently, the block-diagonal Hermitian operator
`directSum_j K_j` has a strictly positive eigenvalue. The eigenvalue wording
may be used only after proving the finite-dimensional equivalence; the
quadratic-form statement above is canonical.

This is not an exact good-count identity. It uses only the first bad-cover
multiplicity `mu_j`, assigns zero weight to singly covered candidates and
negative weight to overlap, and requires a fixed `2n`-mode polynomial to make
the positive uncovered contribution dominate that overlap. A good residue by
itself does not definitionally provide such a low-degree direction. Do not
weaken the target to `E_a(Z)>=0`, allow a delta basis of `M_j` modes, or replace
it by `U>0`, `G_j>0`, Parseval for `1_Qj`, or a minimum over the unknown good
set.

The strict gap need not have a height-uniform numerical lower bound; strict
positivity of this fixed-dimensional form is the uniform assertion. A bound
such as `1/lcm_j(M_j)` is not progress if its proof already assumes a good
residue.

## Complete implication chain

Split `n=1` first. There are no nonpivot owners, the unique pivot grid is
nonempty, and any candidate is a certificate. Do not invoke `D_n` or a second
pivot in this case.

For `n>=2`, assume every pivot is completely covered. Then every candidate has
`mu_j(r)>=1`, so every coefficient `1-mu_j(r)<=0`. For every `z_j`, the
nonnegative square `|P_(j,z_j)(r)|^2` gives `E_j(z_j)<=0`. Hence
`E_a(Z)<=0` for every block vector, contradicting the frozen strict gap.
Therefore some pivot has `mu_j(r)=0` at some candidate. Expand this into
avoidance of every strict owner bad set and prove the pivot coordinate safe.

Finish through

```text
one canonical pivot certificate
  -> PositiveIntegerPivotCertificateConjecture
  -> PositiveIntegerConjecture
  -> Conjecture
  -> unrestricted real LRC
```

using the `proved-lean` equivalences at their exact directions, hypotheses,
indexing, representatives, and closed boundary. Prove the finite sign argument
and extraction of a positive coefficient explicitly.

## Attack A: separate-modulus signed Gram separation

Work with the exact block matrices `K_j`. Recompute their entries from the
strict candidate and bad-set transforms, including every gcd-supported
frequency and candidate-filter convolution. Seek an explicit algebraic block
vector `Z(a)` or a height-independent trace/minimax argument that proves a
positive Rayleigh quotient.

Allowed tools include positive-semidefinite Gram comparison, Schur complements,
Fejer or Dirichlet coefficient vectors supported inside `D_n`, exact trace
identities, and signed additive-energy bounds. Every inequality must retain the
negative overlap terms. Factorwise absolute values, independent domination of
every nonzero frequency, or a zero-frequency main term with uncontrolled error
is rejected.

If choosing a pivot block, the selection rule must be proved from simultaneous
matrix data and must not assume `G_j>0`. If a principal minor or eigenvector is
used, give exact algebraic coefficients or certified rational/cyclotomic bounds;
floating eigenvalues are falsification diagnostics only. Finish at the strict
quadratic-form gap or identify the first unsupported spectral estimate.

## Attack B: exact common-group pullback and global sum of squares

Independently put

```text
L = lcm_(j : Fin n) M_j.
```

For each pivot, define the projection `pi_j : Z/LZ -> Z/M_jZ` and prove every
fiber has exactly `L/M_j` elements. Pull back `R_j`, `mu_j`, every character,
and `P_(j,z_j)`. Prove that dividing the pulled-back sum by `L` gives exactly
`E_j(z_j)`; no extra factor may be suppressed.

Use the common group only as a carrier for an exact sum-of-squares or
positive-definite identity whose fixed `2n` modes yield `E_a(Z)>0`. All
cancellation between pivot blocks must be proved. The height-dependent value
`L` may not become a cutoff, a lower-bound hypothesis, or a finite case split;
the resulting strict sign theorem must hold for every `L` generated by the
tuple.

A common-modulus rewrite alone, arbitrary block weights chosen after inspecting
eigenvalues, or a sum which expands back to the unknown good indicator is not a
result. Finish at the frozen gap or record the first fatal cancellation arrow.

## Mandatory non-tautology and falsification suite

Recompute exact pivot counts, signed weights, and Gram forms on these fixtures.

1. `(1,2,8)`: `G=(0,0,6)`. The certificate mass is concentrated at one pivot;
   test that the proof does not assume two good pivots or average positivity.
2. `(1,2,3,4,5,7)`: `G=(0,0,0,0,2,2)`. At speed `5`, good residues are
   `{6,29}` modulo `35`; at speed `7`, `{8,41}` modulo `49`. This refutes
   `U>=n` and stresses large negative overlap contributions.
3. `(1,6,11,12,13)`: `G=(0,0,8,8,10)`. Two pivot rows are fully covered and
   several good blocks coexist; do not choose a block from good-count data.
4. `(4,5,9)`: `G=(2,2,4)`, while the audited factorwise absolute main-term
   criterion fails at every pivot. Any recovered version of that domination is
   rejected.
5. `(1,2,3)`: `G=(2,2,2)` and equality `rho=3` is safe at pivot speed `3`.
6. `(1,3,5)`: classify all-odd half-time fixed points without doubling.
7. `(1,3,13)` at pivot speed `3`: the other owners coincide modulo `12`;
   retain both multiplicities in `mu_j`.
8. `(1,3,4,5,7,11)`: use this as a mode-cutoff regression. Test the frozen
   `2n` modes and every proposed reduction to `n` modes separately; a failed
   smaller cutoff cannot silently replace the contract.
9. Test `r=0`, exclusion `N|r`, `rho=p_j-1`, equality `rho=p_j`, antipodes,
   nontrivial gcd fibers, `M_j<2n` aliasing, permutations, and common scaling.
10. Expand a proposed positive quadratic form back to
    `sum_r (1-mu_j(r))*|P(r)|^2` and verify that no `Q_j` indicator or presumed
    good residue entered its construction.

A counterexample to the frozen lemma must give the ordered tuple, every `M_j`,
`G_j`, exact cyclotomic matrices `K_j`, and an exact proof that every block is
negative semidefinite. A floating eigenvalue, tolerance-based Cholesky result,
or failed search for `Z` is not a counterexample. Failure of this stronger
spectral bridge does not refute LRC.

## Fixed finite budget

Computation is optional and only for falsification or exact-certificate
discovery. If used, allow one source file and one machine-readable output. Run
the ten regressions first. Then enumerate primitive strictly increasing tuples
for `n=2,3,4,5,6`, largest speed at most `12`, ordered by `n` then
lexicographically. Order pivots and matrix entries naturally. Stop at the first
candidate with no certified positive block, emitting all exact matrices and
the attempted exact semidefiniteness certificate.

Declare language/version, command, domain, ordering, stop rule, algebraic-number
representation, interval precision policy, schema, and SHA-256 hashes. Any
completed bounded result remains `computed finite evidence`; numerical output
without certified signs is only experimental and cannot receive that label.

An optional Lean prototype may formalize at most one local statement: either
the implication from a positive block form to a pivot certificate, or the
common-group fiber normalization. It may not formalize both, the open global
gap, or an older route. Claim `proved-lean` only after standalone compilation
and an axiom audit.

## Disposition and stop rules

Return exactly one disposition.

- `BRIDGE`: the frozen degree-`2n` signed-Gram gap is proved for all quantified
  tuples and the complete implication chain is established. A replacement
  qualifies only if fully proved, fixed-dimensional and height-independent,
  genuinely signed/PSD, strictly stronger than certificate existence, and
  sufficient for unrestricted LRC without another open estimate.
- `PIVOT`: an unrestricted exact spectral theorem is proved which materially
  narrows one named matrix inequality to the frozen gap, or an infinite family
  refutes a named cutoff and leaves one precise smaller surviving obligation.
- `STOP`: the frozen bridge has an exact counterexample; both attacks reduce to
  the good-indicator identity; factorwise domination is reused; a common-group
  cancellation remains unsupported; positivity is only numerical; another open
  estimate is required; or the response migrates to a forbidden route.

Finite success never earns `PIVOT` or `BRIDGE`. Prompt preparation, numerical
eigenvalues, and launch are not mathematical evidence.

## One-turn budget and required output

Use one major Sol Pro turn for both attacks and the single frozen lemma. No
broad literature survey, second target, or follow-up question is permitted.

Return one self-contained memo with these sections, in order:

1. **Disposition** — exactly `STOP`, `PIVOT`, or `BRIDGE`.
2. **Status table** — one exact evidence label per claim and dependency.
3. **Exact target** — characters, normalization, matrices, quantifiers, and
   strict boundary.
4. **Non-tautology audit** — expand the form and identify the first genuinely
   new signed inequality.
5. **Attack A** — separate-modulus Gram proof or first fatal arrow.
6. **Attack B** — common-group sum-of-squares proof or first fatal arrow.
7. **Falsification** — exact fixtures, cutoff tests, and any bounded scan.
8. **Complete implication chain** — including `n=1` and exact Lean
   dependencies.
9. **Artifacts and replay** — only if an optional artifact was created.
10. **Final boundary** — proved, computed, conditional, rejected, and open
    claims without response self-promotion.

Do not return a catalogue of ideas. The sole goal is the exact
height-independent degree-`2n` signed-Gram gap, its decisive refutation, or one
rigorously proved structural partial theorem under these disposition rules.
