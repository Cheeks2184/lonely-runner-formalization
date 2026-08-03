---
owner: GPT-5.6 Sol High top-level desktop orchestrator
supervising_authority: /root
launch_runtime: original browser-capable desktop Codex session
role: Medium - prompt preparation only
---

# Prompt 67: UNIFORM-PRIME-FORCING-SUPPLY

This is one isolated unrestricted Sol Pro research contract. Work only on the
uniform prime-forcing supply bridge below. Unrestricted Lonely Runner remains
open. This contract is not a proof, computation, launch record, response, or
status promotion.

Use `proved-lean`, `proved-math`, `computed finite evidence`, `conditional`,
`conjectural`, `rejected`, `open`, `literature`, and
`external-unformalized` strictly. The required classification `verified
external dependency audit` is reserved for a verified audit of an external
dependency; it does not convert that external theorem into repository-proved
mathematics. Give every theorem, lemma, experiment, and dependency its exact
applicable label or required literature/external classification. Do not
promote a finite check, heuristic, literature statement, external dependency,
or proposed formalization.

## Exact definitions and quantifiers

Fix an arbitrary natural `n>=3` and put `N=n+1`. For `M>0`, define

```text
rho_M(x) = min(x mod M, M-(x mod M)),
```

where `x mod M` is the canonical representative in `{0,...,M-1}`.

For a prime `p`, `PrimeForcing(n,p)` means:

```text
For every v : Fin n -> {0,...,N*p-1}, with repetitions allowed, if

  (1) for every k : Fin n, gcd(N*p, {v_i : i != k}) = 1, and
  (2) for every i : Fin n, p does not divide v_i,

then there exists an integer r with 0 <= r < N*p such that

  p <= rho_(N*p)(r*v_i)  for every i : Fin n.
```

In (1), the gcd includes `N*p` and all coordinates surviving deletion of
`k`. Do not replace this by pairwise coprimality, full-tuple gcd, distinctness,
or one selected deletion. Repeated residues are mandatory even for distinct
originating speeds. Safety is closed `>=p`; badness is strict `<p`. The witness
domain includes `r=0` even though the hypotheses make it unusable; do not
silently change the declared finite domain.

Define the exact integer MSS threshold

```text
C_n = binom(n+1,2),
T_n = min {T : Nat | n^n*T >= C_n^(n*(n-1))}.
```

The set-minimum definition and cross-multiplied inequality are authoritative.
Although `T_n` is the ceiling of the corresponding rational quotient, no step
may pass from a real bound to an integer claim without proving its exact
floor/ceiling statement.

The sole target `UniformPrimeForcingSupply` is:

```text
For every n>=3, there exists a finite set P_n of distinct primes such that
  (a) PrimeForcing(n,p) for every p in P_n, and
  (b) Q_n = product_(p in P_n) p satisfies
      Q_n >= T_n,
      equivalently n^n*Q_n >= C_n^(n*(n-1)).
```

Only distinct primes count. Prime powers, multiplicity in `P_n`, and repeated
use of one divisibility conclusion are forbidden. “Exceeds the MSS bound”
means the integer product reaches `T_n`, contradicting the published strict
upper bound. Weak `>=` at this threshold is enough.

## Required unrestricted implication chain

State and justify every arrow with exact hypotheses:

```text
lower-dimensional LRC
  -> a primitive minimal counterexample has every deletion gcd one
  -> PrimeForcing(n,p) forces p to divide the positive speed product
  -> every distinct p in P_n divides that product
  -> Q_n divides the speed product, so the speed product is at least Q_n
  -> n^n*Q_n >= C_n^(n*(n-1))
  -> contradiction with the strict MSS product upper bound
  -> PositiveIntegerConjecture in dimension n
  -> induction on dimension
  -> unrestricted positive-integer LRC
  -> standard real/integer reduction
  -> unrestricted LRC.
```

Do not abbreviate the induction base, primitive reduction, deletion indexing,
distinct-prime product assembly, positivity, or strict contradiction. Do not
infer an integer inequality from the real shorthand
`(C_n^(n-1)/n)^n`; use the exact integer formula above.

The induction indexing is fixed. At step `n`, there are `n` positive moving
speeds and, after adjoining the stationary runner, `N=n+1` total runners.
Deleting one positive moving speed leaves `n-1` positive moving speeds and
therefore `n` total runners, so the induction hypothesis is LRC for `n` total
runners. The two smaller positive-moving-speed cases are separate bases:

- `n=1` positive moving speed (`2` total runners) is `proved-lean` by
  `BASE-01`, specifically `LonelyRunner.oneMovingRunner` in
  `LonelyRunner/BaseCases.lean`.
- `n=2` positive moving speeds (`3` total runners) is `proved-lean` by
  `BASE-02`, specifically `twoMovingSpeeds_of_abs_le`, `twoMovingSpeeds`, and
  `twoMovingRunners` in `LonelyRunner/SmallDimensions.lean`.

The C2 statement starts at `n>=3`; it does not prove, subsume, or relabel these
base cases. A complete induction must cite both bases before applying the C2
step.

The Malikiosis--Santos--Schymura product theorem, including its strict upper
bound, is `literature` and `external-unformalized` in this repository. It is
not `proved-math` or `proved-lean` here. The verified external dependency audit
confirms its indexing and strict product corollary, not a repository proof of
MSS.

## Repository boundary and dependencies

| Dependency | Exact usable status | Boundary |
|---|---|---|
| `VER-C2-DEPENDENCY-038` | `verified external dependency audit` | Accepts MSS indexing, strict product logic, and the sufficient integer comparison; it is not `proved-math`, does not formalize MSS, and does not prove uniform supply. |
| MSS product upper bound | `literature`; `external-unformalized` | Primary-source theorem required by the bridge; no repository `proved-math` or `proved-lean` status may be claimed. |
| Missing Lean wrapper / assembled C2 route | `open` | The primitive wrapper, subset-gcd sum, AM--GM corollary, forced-prime assembly, final contradiction, and Lean connection to the external MSS theorem remain missing. |
| `BASE-01` | `proved-lean` | `LonelyRunner.oneMovingRunner` in `LonelyRunner/BaseCases.lean` proves the `n=1` positive-moving-speed base. |
| `BASE-02` | `proved-lean` | `twoMovingSpeeds_of_abs_le`, `twoMovingSpeeds`, and `twoMovingRunners` in `LonelyRunner/SmallDimensions.lean` prove the `n=2` positive-moving-speed base. |
| `PART-79` / Response60 audit | `proved-math` at stated hypotheses | Accepts local implication and exact product arithmetic; rejects several universal auxiliaries and leaves the supply open. |
| `RED-01` positive-integer to unrestricted LRC reduction | `proved-lean` | Cite only at documented scope; it does not supply the new C2 lemma. |

Quote any additional repository theorem exactly with its status and hypotheses.
An audit label is not a substitute for a theorem.

## Existing computed evidence and caveats

The only accepted finite slice here is `n=3`, hence `N=4`:

| Prime | Premise tuples | Failures | Label |
|---:|---:|---:|---|
| `2` | `64` | `0` | `computed finite evidence` |
| `3` | `256` | `0` | `computed finite evidence` |
| `7` | `6,912` | `0` | `computed finite evidence` |
| `11` | `32,000` | `0` | `computed finite evidence` |
| `13` | `55,296` | `0` | `computed finite evidence` |
| `5` | `2,048` | `192` | `computed finite evidence`; first failure `(1,3,4)` in declared order |

Thus `2,3,7,11,13` succeed and `5` fails only on this computed finite slice.
These rows imply no density, eventual validity, theorem in another dimension,
or all-dimension supply. The complete Response60 artifact remains
nonreproducible. Never label these outcomes `proved-math` or interpolate
between tested primes.

The `n=3` threshold reconciliation is also `computed finite evidence` only:

```text
C_3 = binom(4,2) = 6,
3^3 = 27,
6^6 = 46,656,
T_3 = min {T : Nat | 27*T >= 46,656} = 1,728,
Q_3 = 2*3*7*11*13 = 6,006,
27*6,006 = 162,162 >= 46,656.
```

This reconciles the five computed-success primes with the exact integer
threshold in one fixed dimension. It does not promote any
`PrimeForcing(3,p)` row to a theorem, prove a uniform prime supply, or change
the status of unrestricted LRC.

## Two materially different required attacks

Develop at least these two attacks within the fixed budget. Each must expose
exactly one named unresolved lemma. Every other step must be proved,
explicitly conditional on a listed dependency, or identified as fatal.

### Attack A: uniform prime interval from modular-cover structure

Seek a dimension-uniform condition from the deletion-gcd hypotheses and strict
modular bad arcs that guarantees `PrimeForcing(n,p)` for every prime in an
explicit interval or explicit finite family large enough to reach `T_n`.
Fourier cancellation, character sums, polynomial methods, or a direct cover
deficit are permitted, but repetitions and every admissible tuple must remain.

Name exactly one unresolved statement `INTERVAL-PRIME-FORCING-SUPPLY`. State
explicit quantifiers, interval endpoints or endpoint functions, primality,
repeated-residue domain, deletion-gcd premises, and exact integer product
conclusion. Prove that this one statement implies
`UniformPrimeForcingSupply`; do not hide a second unproved prime-counting or
product-growth lemma.

### Attack B: obstruction classification and distinct-prime extraction

Analyze failure of `PrimeForcing(n,p)` as a full cover of `Z/(N*p)Z` by the
coordinates' strict bad sets. Seek an algebraic/additive classification of
minimal covers that, across primes, permits only finitely many obstruction
signatures or leaves a product-large distinct-prime set. This route must not
assume eventual validity and must differ materially from an interval union
bound.

Name exactly one unresolved statement `OBSTRUCTION-EXTRACTION-SUPPLY`, with
explicit quantifiers and a direct exact-integer product guarantee. Show how
the classification plus this single statement yields the target. Put any
unproved classification-to-counting transition inside this named lemma, not
in background prose.

For each attack, say whether its lemma is genuinely narrower than the target.
If it merely renames the original modular cover problem, mark that attack
`STOP`.

## Mandatory adversarial falsification

Before recommending either route:

1. Include tuples with repeated residues modulo `N*p`.
2. Check every deletion-gcd premise, not only the full gcd.
3. Include residues at both strict boundaries and verify `rho=p` is safe.
4. Include every collision pattern compatible with no coordinate divisible by
   `p`, not only reductions of distinct small speeds.
5. Reproduce the `n=3,p=5` failure and first tuple `(1,3,4)` before trusting a
   verifier or sufficient condition.
6. Reject a density/eventual-prime claim at its first valid infinite
   residue-family obstruction.
7. Test whether a proposed lemma is equivalent to enumerating the original
   finite cover for each `(n,p)`; if so, record no structural progress.
8. Reject dimension-by-dimension computation as a uniform proof even if every
   tested interval succeeds.

Every counterexample must give its domain, ordering, premises, failure
certificate, and exact rejected claim. A failed sufficient condition does not
reject the target unless its logic proves that.

## Fixed budget and verifier plans

The whole cell has one major Pro turn, exactly one declared finite prime
interval in exactly one new dimension `n_new!=3`, and at most one
local-to-global Lean prototype.

Before computation, declare `n_new` and exact endpoints `L<=U`. Test all and
only primes in `[L,U]`, increasing. Define canonical enumeration of all
possibly repeated tuples in `{0,...,N*p-1}^n`, the exact premise filter,
`r=0,...,N*p-1` witness order, and deterministic early-stop semantics. Report
tuple totals, premise totals, failures, first failure, and a machine-checkable
certificate or witness for every outcome. Sampled, random, primitive-only,
distinct-coordinate, or moving intervals are rejected.

Give two independent verifier plans:

1. a literal enumerator implementing the definition directly; and
2. a structurally different verifier using canonical orbit reduction,
   bitsets, or another justified quotient, with proof that it preserves
   repetitions, premises, boundaries, and failure counts.

Specify source hashes, tool versions, deterministic ordering, replay commands,
expected summary fields, and cross-verifier comparison. Any new interval result
is only `computed finite evidence`.

An optional Lean prototype may cover only one local-to-global wrapper: either
from a supplied `PrimeForcing(n,p)` witness and exact deletion/primitive
hypotheses to `p` dividing the speed product, or from supplied distinct forced
primes to the cross-multiplied product contradiction. Do not attempt both or
formalize MSS. Claim `proved-lean` only after compilation and axiom audit.

## Stop and disposition contract

- `CONTINUE` only if an attack leaves one explicit lemma materially narrower
  than the original cover and a credible uniform path to the exact threshold.
- `PIVOT` if prime forcing yields a precise new intermediate theorem but no
  uniform product supply; state what evidence would change the ranking.
- `STOP` if both attacks reduce to the original cover, require uniform supply
  under another name, or no dimension-uniform supply survives the budget.

Success on the one finite interval cannot justify `CONTINUE` alone. Its failure
cannot refute the unrestricted target alone. Never claim unrestricted LRC
unless the whole chain, external MSS dependency, and exact integer arithmetic
are valid at their declared labels.

## Required output

Return one self-contained research memo with these sections in order:

1. **Research memo and disposition** - executive result and exactly one of
   `CONTINUE`, `PIVOT`, or `STOP`.
2. **Exact theorem statements** - `PrimeForcing`,
   `UniformPrimeForcingSupply`, `INTERVAL-PRIME-FORCING-SUPPLY`, and
   `OBSTRUCTION-EXTRACTION-SUPPLY`, with all quantifiers and boundaries.
3. **Proof sketches** - both materially different attacks and the complete
   implication chain to unrestricted LRC.
4. **Dependency and obligation table** - every input, new claim, status,
   unresolved lemma, and external/unformalized dependency.
5. **Falsification findings** - adversarial cases, rejected conditions, exact
   scope, and the frozen one-interval result if run.
6. **Verifier plan** - literal and independent optimized plans, deterministic
   transcript contract, replay commands, and optional single Lean prototype.
7. **Final boundary statement** - what was proved, computed, conjectured,
   rejected, and remains open, without promotion.

Do not substitute a progress narrative, dimension table, or computational
survey. The sole goal is a genuine uniform supply of distinct prime-forcing
statements strong enough to cross the exact integer MSS threshold.
