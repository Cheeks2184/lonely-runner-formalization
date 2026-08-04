---
owner: GPT-5.6 Sol High top-level desktop orchestrator
supervising_authority: /root
launch_runtime: original browser-capable desktop Codex session
role: Formalization/Specification Lead - prompt preparation only
---

# Prompt 70: SIMULTANEOUS-PIVOT-UNCOVERED-MASS

This is one isolated unrestricted Sol Pro research contract. Work only on the
simultaneous all-pivot lemma below, or decisively refute it. The cell is about
signed Fourier/additive-energy control or a global cover-multiplicity
invariant across every canonical pivot. It is distinct from Prompt68 cofinite
prime forcing and Prompt69 uncrossing/exchange. Do not turn it into packing,
height compression, first-blocker descent, radial descent, a top-two theorem,
an owner-shift theorem, Gamma matching, or a catalogue of earlier routes.

This file is a prepared contract only. It is not a launch record, response,
proof, computation, or status promotion. Only GPT-5.6 Sol High under `/root`
may launch the Pro turn. Do not delegate any part to Luna.

Use the labels `proved-lean`, `proved-math`, `computed finite evidence`,
`conditional`, `conjectural`, `rejected`, and `open` literally. A response may
not promote its own mathematics or artifacts before independent audit.

## Existing exact boundary

The repository already proves in Lean that, for a fixed nonempty positive
integer speed tuple, existence of a real witness is equivalent to existence
of one canonical pivot residue avoiding every strict nonpivot bad set:

```text
exists_witness_iff_exists_pivot_certificate.
```

It also proves

```text
positiveIntegerConjecture_iff_pivotCertificateConjecture
```

and the separate real/integer reduction

```text
conjecture_iff_positiveIntegerConjecture.
```

These declarations are `proved-lean`. They are exact equivalences, not an
existence proof. Merely restating pivot noncoverage, summing exact certificate
indicators and asking that the sum be positive, or encoding the same
existential as a Fourier coefficient is tautological and earns `STOP`.

`PART-12` is `proved-math`: the normalized candidate-filter transform, strict
Dirichlet kernel, gcd-supported multiplication pullback, and actual bad-set
convolution are audited in `docs/fourier-pivot-badsets.md`. They are not
Lean-formalized and do not prove a uniform certificate. Factorwise absolute
main-term domination is explicitly false, including on certified tuples.

## Frozen definitions and conventions

Let `n : Nat` satisfy `1 <= n`, put `N=n+1`, and let

```text
a : Fin n -> Nat
```

be positive and injective. Original speeds are distinct natural numbers.
Their reductions modulo a pivot modulus need not be distinct: repeated
modular residues, coincident bad sets, nonunits, and all gcd degeneracies must
remain in scope.

For a pivot `j : Fin n`, define

```text
p_j = a_j,
M_j = N*p_j,
rho_M(x) = min(x mod M, M-(x mod M)),
R_j = {r : Fin M_j | N does not divide r.val}.
```

Because `p_j>0` and `N>=2`, `M_j>0`. Every `Fin M_j` value uses its unique
representative `0 <= r.val < M_j`. The candidate set has exactly

```text
|R_j| = n*p_j.
```

For every nonpivot owner `i != j`, define the strict bad set

```text
B_i^j = {r : R_j | rho_(M_j)(r.val*a_i) < p_j}.
```

The boundary is frozen: `<p_j` is bad and equality `rho=p_j` is safe. Never
replace cyclic distance by a one-sided residue interval. The pivot coordinate
is automatically safe only because `r` is a candidate; prove or cite that
step rather than suppressing it.

Define the all-owner cover multiplicity and the uncovered count at pivot `j`:

```text
mu_j(r) = #{i : Fin n | i != j and r in B_i^j},
G_j(a) = #{r : R_j | mu_j(r)=0}.
```

Equivalently, `G_j(a)` is the cardinal deficit

```text
|R_j| - |union_(i!=j) B_i^j|,
```

where this equality must be proved before natural subtraction is used. The
global uncovered mass is

```text
U(a) = sum_(j : Fin n) G_j(a).
```

The summands live in different cyclic groups `Z/M_j Z`. All-pivot aggregation
means summing the resulting integer/cardinal quantities; it does not create a
canonical common frequency group or identify residues at different pivots.

Reflection is the involution `r |-> -r` in `Z/M_j Z`. Treat its fixed points,
especially `r=M_j/2` when defined, separately. Do not double a self-reflecting
certificate. Coordinate permutation relabels the summands. If
`d=gcd_i(a_i)` and `a=d*b`, any primitive normalization must prove the exact
scaling relation for each `G_j` (expected `G_j(a)=d*G_j(b)`) rather than infer
it from witness invariance.

## Sole unrestricted research lemma

There is exactly one permitted unresolved lemma:

```text
SIMULTANEOUS-PIVOT-UNCOVERED-MASS:

For every n : Nat with 1 <= n and every positive injective
a : Fin n -> Nat,

  U(a) >= n.
```

This is strictly stronger in conclusion than the already verified existential
pivot-certificate formulation: it demands at least `n` certificate incidences
across all pivots, not merely one. The cases `n=1` and `n=2`, reflection pairs,
and all-odd half-time fixed points may give elementary baseline mass. Isolate
those free consequences exactly. For `n>=3`, do not claim that reflection or
the existing equivalence yields the displayed `n` lower bound unless it is
actually proved.

The target is a quantitative sufficient theorem, not a renamed exact
certificate indicator. A valid proof must expose a prime-independent and
height-independent structural reason for the lower bound across all pivots.

## Complete implication chain

Prove every arrow, at its exact quantifiers:

```text
SIMULTANEOUS-PIVOT-UNCOVERED-MASS
  -> U(a) >= n >= 1
  -> some pivot j has G_j(a)>0
  -> some r in R_j has mu_j(r)=0
  -> r avoids every B_i^j for i!=j
  -> one canonical pivot certificate
  -> PositiveIntegerPivotCertificateConjecture
  -> PositiveIntegerConjecture
  -> conjecture_iff_positiveIntegerConjecture
  -> unrestricted real LRC.
```

Spell out finite-sum nonemptiness, the conversion from `mu_j(r)=0` to every
owner being absent, positivity of `n`, the closed boundary, and the pivot
coordinate. Do not assume injectivity survives modulo `M_j`. The final real
reduction is `proved-lean`, but it must be cited at the correct direction and
indexing rather than paraphrased as density.

## Attack A: exact signed Fourier aggregation

For each pivot separately, work on `Z/M_j Z` with normalized transform

```text
hat(f)(k) = (1/M_j) * sum_r f(r)*exp(-2*pi*i*k*r/M_j).
```

Define the candidate filter `c_j`, strict raw arc pullbacks `g_ij`, actual
bad indicators `beta_ij=c_j*g_ij`, and the good indicator

```text
h_j(r) = c_j(r) * product_(i!=j) (1-g_ij(r)).
```

Prove `sum_r h_j(r)=G_j(a)` with no boundary or candidate double count. Then
derive the complete zero-frequency convolution identity using one declared
Fourier sign and inverse convention. Insert the exact audited transforms only
after rechecking their hypotheses, including `N=2`, `M'=1`, nonunit speeds,
and the candidate-filter convolution.

Seek a signed, positive-definite, or energy-based inequality which survives
the sum over `j` and yields

```text
sum_j sum_r h_j(r) >= n.
```

Cancellation must be proved. Absolute values of every nonzero frequency term,
an arbitrary factorization-dependent triangle bound, or averaging quantities
from different moduli as though they shared characters is invalid. If using a
common multiple only as an auxiliary group, define every pullback, its fiber
size, and the exact preservation of each `G_j`; a height-dependent common
multiple is not by itself uniform progress.

This attack must finish with the target inequality or identify its first
unsupported spectral estimate. A formula for `hat(h_j)(0)` alone is the exact
count in disguise and is not a result.

## Attack B: multiplicity moments and additive-energy rigidity

Independently define, for `1 <= q <= n-1`,

```text
S_(j,q) = sum_(r in R_j) choose(mu_j(r),q)
        = sum_(I subset {i | i!=j}, |I|=q)
            |intersection_(i in I) B_i^j|.
```

Prove the equality with repetitions and coincident bad sets retained. Exact
inclusion-exclusion gives

```text
G_j(a) = |R_j| + sum_(q=1)^(n-1) (-1)^q S_(j,q).
```

This identity is bookkeeping, not the new lemma. Use arithmetic intersection
structure, additive energy, Parseval, or a classification forced by the
hypothetical global deficit `U(a)<n` to obtain new rigidity. If choosing an
inclusion-minimal cover at a pivot, define it canonically enough to handle
multiple minimal subcovers and prove all private-point claims. Do not use
Prompt69-style uncrossing, exchange steps, owner swaps, or residue transport
between pivot covers under different notation.

A valid contradiction must exploit simultaneous constraints on at least two
pivots or prove a global moment inequality summed over every pivot. A
fixed-pivot union bound, a pairwise-intersection estimate with uncontrolled
higher multiplicities, or general hypergraph integrality is insufficient.
Classify equality and near-equality cases rather than discarding them.

## Mandatory non-tautology audit

Before assigning `BRIDGE`, answer all of the following.

1. Separate `U(a)>=1`, which is exactly the existing existential target, from
   the proposed `U(a)>=n` quantitative conclusion.
2. Prove the exact lower bound supplied for free by reflection, including
   self-inverse residues and the all-odd half-time case.
3. Identify the first genuinely new inequality beyond that free bound.
4. Expand any Fourier or moment formula back to the finite bad sets and show
   that the proof did not assume `G_j>0` at one pivot.
5. Reject any argument whose decisive hypothesis is equivalent to the
   existence of an uncovered residue, a minimum over the unknown good set, or
   positivity of the exact good-count Fourier coefficient.
6. Explain why the argument is simultaneous across all pivots and is not a
   fixed-pivot sufficient criterion followed by an unsupported choice of `j`.

If the proposed mass bound follows from the existing equivalence plus a
purely formal relabeling, say so and return `STOP`; do not market it as a new
bridge.

## Known fixtures and mandatory falsification

Reproduce these exact boundary and obstruction fixtures before trusting either
attack. All counts are to be recomputed, not cited as proof.

1. `n=1`, primitive tuple `(1)`: the single pivot has `G=(1)` and `U=1`.
2. `n=2`, tuple `(1,3)`: pivot counts are `(0,2)`, so `U=2`; a theorem cannot
   require every pivot to be deficient.
3. `(1,2,3)` with `N=4`: pivot counts are `(2,2,2)`. At pivot `3`, `r=3`
   has equality `rho=3` for speed `1` and is safe. The audited factorwise
   absolute main-term criterion fails there despite explicit certificates.
4. `(4,5,9)`: pivot counts are `(2,2,4)`, while the audited absolute
   main-term criterion fails at every pivot. Any reused triangle domination is
   rejected.
5. Tight mass fixture `(1,2,3,5)`: independently verify pivot counts
   `(0,0,2,2)` and `U=4=n`. Preserve the zero-certificate pivots and every
   equality case.
6. All-odd tuple `(1,3,5)`: classify the self-inverse half-time residue at
   every pivot without counting its reflection twice.
7. Scaling pair `(1,2,3)` and `(2,4,6)`: verify the exact per-pivot scaling
   relation; injectivity is retained although primitivity is not.
8. Modular-collision tuple `(1,3,13)` at pivot speed `3`: the two nonpivot
   speeds coincide modulo `12`. Retain both owners and the coincident bad sets.
9. Test `r=0`, candidate exclusion `N|r`, both cyclic representatives,
   `rho=p_j-1`, equality `rho=p_j`, and the antipode when `N=2`.
10. Permute every mandatory tuple and verify that `U` is invariant while
    pivot-indexed counts are correspondingly relabeled.

Any counterexample must give `n`, the ordered tuple, every `G_j`, total `U`,
the first failed inequality, and a complete exact replay certificate. A
counterexample to the mass bound rejects only this stronger lemma, not the
existence of a pivot certificate or LRC.

## Fixed finite budget

Computation is optional and may be used only for falsification. If used, it is
limited to one new source file and one machine-readable output. Run the ten
mandatory fixtures first in their listed order. Then, at most, enumerate all
primitive strictly increasing tuples for `n=3,4,5` with largest speed at most
`12`, ordered by `n` and then lexicographically; within each tuple order pivots
by index and residues by their natural representatives. Stop at the first
`U<n` failure after emitting its complete certificate. Do not add random
samples, larger boxes, a changing cutoff, or a second search after seeing the
result.

Declare the implementation language/version, command, ordering, exact domain,
early-stop behavior, output schema, and SHA-256 hashes. Every result remains
`computed finite evidence`; zero failures cannot prove the unrestricted mass
bound.

An optional Lean prototype may formalize at most one local statement: either
the exact `G_j` reflection orbit decomposition or the finite implication
`U>=n -> exists one pivot certificate`. It may not formalize both, the full
research lemma, or an old route. Claim `proved-lean` only after a standalone
build and axiom audit.

## Disposition and stop rules

Return exactly one disposition.

- `BRIDGE` only if `SIMULTANEOUS-PIVOT-UNCOVERED-MASS` is proved at all stated
  quantifiers and the complete implication chain is established. If the mass
  target is refuted but a different precise simultaneous-pivot theorem is
  completely proved and itself yields an unrestricted pivot certificate, it
  also receives `BRIDGE`, with the refutation and replacement stated exactly.
- `PIVOT` only if a precise prime-independent and height-independent partial
  theorem is proved that does not itself yield the unrestricted certificate
  but materially narrows the remaining global inequality, or a decisive
  infinite family refutes the mass target and forces a materially different
  simultaneous invariant. A sufficient theorem that already yields a
  certificate receives `BRIDGE`, not `PIVOT`.
- `STOP` if both attacks reduce to exact certificate counting, retain an
  unsupported all-pivot cancellation step, use only finite enumeration, rely
  on the refuted absolute main-term criterion, or migrate to any forbidden
  route.

One isolated finite counterexample gives `STOP` for this exact mass lemma
unless the response proves an admissible replacement. Do not infer failure of
LRC. Conversely, finite success never earns `PIVOT` or `BRIDGE`.

## One-turn budget and required output

The budget is one major Sol Pro turn. Spend it on both attacks and the one
named lemma. No broad literature search, second research target, or follow-up
question is permitted.

Return one self-contained memo with these sections, in order:

1. **Disposition** — exactly `STOP`, `PIVOT`, or `BRIDGE`.
2. **Status table** — one strict label for every theorem, identity,
   computation, dependency, refutation, and open step.
3. **Exact target** — frozen definitions, quantifiers, normalization, and why
   `U>=n` is stronger than one certificate.
4. **Non-tautology audit** — reflection baseline and first genuinely new
   inequality.
5. **Attack A** — exact Fourier identity and proved signed estimate, or first
   fatal arrow.
6. **Attack B** — multiplicity/energy identities and proved rigidity, or
   first fatal arrow.
7. **Falsification** — every mandatory fixture and any bounded scan.
8. **Complete implication chain** — deficient pivot through positive-integer
   and real LRC, with exact repository dependencies.
9. **Artifacts and replay** — only if the optional verifier or Lean prototype
   was used.
10. **Final boundary** — exact proved, computed, conditional, rejected, and
    open claims, with no response self-promotion.

Do not substitute a progress narrative. The sole goal is the unrestricted
simultaneous uncovered-mass lemma, a decisive refutation, or a rigorously
narrower structural partial theorem under the disposition rules above.
