---
owner: GPT-5.6 Sol High top-level desktop orchestrator
supervising_authority: /root
launch_runtime: original browser-capable desktop Codex session
role: GPT-5.6 Sol / Pro mathematical research agent
task_id: SOL-P103-PRO-SQUAREFREE-GCD-PIVOT-CERTIFICATE
base_commit: 5f7fb970ffe1da4b1fd83d0dbbc3a2ac9fb257b2
admission: LAUNCH-CANDIDATE
prompt_encoding: ASCII
prompt_line_endings: LF
prompt_hash_scope: bytes from the line "# Prompt 103:" through EOF
prompt_sha256: 277ec02642ee46ec1a4e312d3e450865bcc235c4084f613f7544ae76d6f9e8c7
---

# Prompt 103: SQUAREFREE-GCD-PIVOT-CERTIFICATE

You are GPT-5.6 Sol running at Pro effort in a genuinely new ChatGPT
conversation. Act as the mathematical research agent. This is the actual
research turn, not a request to review admission, prepare a prompt, or propose
another contract. If this payload has been submitted, GPT-5.6 Sol High in the
original browser-capable desktop Codex session has already made the launch
decision.

Use one major turn. Prove the exact unrestricted theorem below, give one exact
independently reproducible theorem-domain counterexample, or prove one
unrestricted successor lemma that strictly narrows the first unsupported
edge. The squarefree condition is additional mathematical content; do not
discard it after finding an ordinary certificate.

## Frozen research contract

| Field | Frozen value |
| --- | --- |
| Exact theorem | `SQUAREFREE-GCD-PIVOT-CERTIFICATE` below |
| Scope | every `n>=2` and every positive injective integer tuple; unrestricted height |
| New structure | exact gcd strata of uncovered pivot residues, retaining all squarefree nonunit strata |
| Complete consequence | ordinary pivot certificate, then the kernel-checked integer and real Lonely Runner equivalences |
| Single unresolved lemma | some uncovered residue has squarefree gcd with its pivot modulus |
| Stop condition | exact tuple whose every pivot certificate is squarefull; collapse to Prompt94's unchanged unit target or ordinary pivot existence; or fatal scaling defect |
| Maximum budget | one major Pro turn; at most one fifth on bounded computation |

The target is stronger than ordinary pivot existence and weaker than the
all-pivot unit-stratum target of Prompt94. It permits nonunit numerators when
their exact gcd with the pivot modulus is squarefree.

## Evidence and provenance boundary

Unrestricted LRC remains open. Accepted project inputs at this contract's
base include:

- `proved-lean`: the exact positive-integer pivot-certificate equivalence;
- `proved-lean`: the endpoint-safe positive-integer/positive-real reduction;
- `proved-lean`: canonical candidate and strict bad-residue definitions;
- `proved-lean`: exact single bad-set counts and pair/triple CRT counts;
- `proved-math-qualified`: Prompt94's generalized CRT count, correctly
  oriented divisor zeta/Mobius identities, unit-deficit cardinality, and
  reflection parity at their audited scopes;
- `refuted-exact`: the fixed-row implication from an ordinary certificate to
  a unit certificate, witnessed at pivot `3` of `(1,2,3)`;
- `open`: Prompt94's all-pivot unit target, the squarefree-gcd target, the
  ordinary pivot existential, integer LRC, and real LRC.

No response, prompt launch, attachment, finite scan, or compiled conditional
wrapper is accepted evidence by itself.

Use only these evidence labels:

```text
input-accepted
proved-lean
proved-math-qualified
proved-math-response
computed finite evidence
refuted-exact
conditional
conjectural
open
not-run
out-of-scope
rejected operational output
```

`proved-math-response` requires independent audit before promotion.
`computed finite evidence` is finite-scope only and requires source/output
hashes, complete execution, fixtures, and independent checking.

## Exact canonical pivot definitions

Fix `n>=2`, put `N=n+1`, and let

```text
a : Fin n -> Nat
```

be positive and injective. Labels are indices. For pivot `j`, put

```text
p_j = a_j,
M_j = N*p_j,

rho_M(x) = min(x mod M, M-(x mod M)),

R_j = {r in {0,...,M_j-1} : N does not divide r},

B_i^j = {r in R_j : rho_(M_j)(r*a_i) < p_j}  for i != j,

Q_j = R_j minus union_(i != j) B_i^j.
```

Representatives are canonical. Equality `rho=p_j` is safe. Retain zero
products, both cyclic sides, antipodes, nonunits, nontrivial multiplication
fibers, repeated bad subsets with distinct labels, and the excluded
`N`-multiple representatives.

The pivot coordinate is safe on every `R_j`, so `Q_j` is exactly the set of
canonical pivot-certificate numerators at row `j`.

## Exact gcd strata

For every divisor `g` of `M_j`, define

```text
Q_j(g) = {r in Q_j : gcd(r,M_j)=g}.
```

Use the standard natural-number meaning of squarefree:

```text
Squarefree(g)  iff  no prime ell has ell^2 dividing g.
```

Equivalently, for positive `g`, the integer Mobius function satisfies
`mu(g) != 0`. The value `g=1` is squarefree. Candidate residues are nonzero
because `N` divides zero, hence every `gcd(r,M_j)` here is positive.

Reflection `r -> M_j-r` preserves the exact gcd stratum. It does not convert
a squarefull gcd into a squarefree one.

## Sole unrestricted theorem

Prove or refute exactly:

```text
SQUAREFREE-GCD-PIVOT-CERTIFICATE:

For every n>=2 and every positive injective a : Fin n -> Nat,
there exist j : Fin n and r : Nat such that

  r in Q_j,
  and Squarefree(gcd(r,N*a_j)).
```

Equivalent stratum-count form:

```text
sum over j and squarefree divisors g of N*a_j of |Q_j(g)| is positive.
```

The count form is only a finite rewriting of the displayed target. Do not
claim progress from writing the full sum over all gcd strata, which is exactly
ordinary pivot existence.

## Exact implication to unrestricted LRC

1. Forget the squarefree condition and retain `j,r` as an ordinary canonical
   pivot certificate.
2. Invoke the accepted kernel-checked positive-integer pivot equivalence.
3. Handle `n=1` directly.
4. Apply the accepted endpoint-safe integer-to-real reduction.

No unit certificate, prime-forcing premise, height bound, or internal-cover
theorem is required after the sole target. The chain remains `conditional`
until that target is proved.

## Non-equivalence and strength audit

Audit all of these before the main proof:

- `N` not dividing `r` does not imply `gcd(r,N*a_j)=1` or squarefree.
- An ordinary certificate may lie in a squarefull gcd stratum; reflection
  preserves that obstruction.
- Dividing `r` or the modulus by a repeated prime factor changes the time,
  pivot denominator, candidate guard, and strict threshold. It is not an
  automatic certificate transformation.
- Prompt94 asks for `g=1`. The present target permits every squarefree `g`, so
  a fixed-row failure of the unit property does not refute this theorem.
- Common scaling changes the modulus and can introduce prime powers. If
  normalization is used, prove an exact lift selecting a squarefree gcd among
  the scaled sheets. Do not assume the property is scale invariant.
- Summing every nonempty gcd stratum is the ordinary pivot theorem and is
  prohibited as a successor.

If a valid elementary transformation turns every ordinary certificate into a
squarefree-gcd certificate for the same tuple, return `STOP` with the complete
proof that the proposed theorem is equivalent rather than a new bridge.

## Required research attacks

Spend a strict majority of the turn on uniform mathematics and compare at
least two attacks.

### Attack A: prime-square obstruction charging

Assume every squarefree stratum is covered. Every safe residue would then
have some prime square dividing its gcd with the pivot modulus. Derive an exact
cross-pivot charging, incompatibility, or descent for those prime-square
obstructions. Prime factors must come from the actual pivot moduli; no new
forcing-prime supply may be assumed.

### Attack B: radical Mobius layers

Extend the audited gcd-layer CRT counts to the radical indicator

```text
1_Squarefree(g) = sum_(d^2 | g) mu(d).
```

Seek a sign-controlled all-pivot identity or inequality. Mobius coefficients
are signed, so termwise positivity is invalid. Full inclusion of all gcd
layers is forbidden because it recovers ordinary noncoverage exactly.

### Attack C: exact scaling-sheet selection

Prove or refute the support statement that a squarefree-gcd certificate for a
primitive quotient can be lifted through a positive common scale by choosing
one of the exact residue sheets. This is a support theorem, not permission to
leave scaling as a second open assumption. If it fails, attack nonprimitive
tuples directly or stop the normalization route.

## Forbidden duplicate methods

Do not reopen or rename:

- Prompt94's unchanged unit-stratum positivity target;
- Prompt67/68 prime-forcing supply, cofinite primes, or a product threshold;
- Prompt66 whole-block packing or signed phase cells;
- Prompt98 MBCP or the refuted maximal internal pair-overlap supply;
- Prompt99's non-genuine universal `N|p` branch split;
- Prompt100's two-lower-owner theorem;
- Prompt101's positive subcritical weights;
- top-two affine transversals;
- coefficient-two Gamma matching;
- height compression, signed replacement, deletion, or first-blocker descent;
- a full gcd-stratum sum, circuit escape, or exact complement restatement of
  ordinary pivot existence.

The phrase "prime-square obstruction" does not authorize prime forcing. This
cell studies repeated prime factors already present in `gcd(r,M_j)`.

## Mandatory falsification fixtures

Recompute all fixtures literally:

1. `(1,2,3)`, `N=4`: at pivot `3`, the safe candidates are `r=3,9`, both
   nonunit with gcd `3`, which is squarefree. A unit-only proof is invalid.
2. `(1,4)`, `N=3`, pivot `4`: `r=4` is an ordinary safe candidate with
   `gcd(4,12)=4`, which is squarefull. The squarefree predicate must reject
   this residue without rejecting ordinary badness calculations.
3. `(1,4,5,6,7,11)`, `N=7`: pivots `6,7` have unit certificates while the
   maximum pivot need not be certified.
4. `(1,5,25,125)`, `N=5`: the last pivot has unit certificates beginning
   `r=156`; the tuple refutes Prompt101, not this target.
5. `(1,3,13)`: owners `1` and `13` have coincident labelled bad sets at the
   declared pivot and must not be deduplicated.
6. At `N=4,p=3,q=1`, residues `3,9` are equality-safe and the strict bad set
   is `{1,2,10,11}`.
7. Include one nonprimitive scale by a square factor and enumerate every
   scaled sheet; no scale-invariance claim may be inferred from one lift.
8. Include a modulus with an antipode, a nonunit zero product, and a gcd with
   two distinct primes.
9. Repeated speeds, zero speeds, noncanonical residues, and `N`-multiple
   residues are malformed controls.
10. Deliberately alter one expected gcd from squarefree to squarefull; the
    verifier must fail.

If computation is included, enumerate tuples and pivot/residue pairs in a
frozen total order, report raw and primitive counts separately, compare a
literal gcd-stratum implementation with an independently optimized one, and
print the first tuple for which ordinary certificates exist but every one is
squarefull. A bounded absence of such a tuple is finite evidence only.

## Stop and disposition rules

Return `STOP` immediately on:

- an exact positive injective tuple whose complete ordinary certificate set
  is nonempty but entirely squarefull;
- a fatal squarefree, candidate, boundary, or scaling defect;
- a proof that the target is automatically equivalent to ordinary pivot
  existence;
- or an argument whose sole missing edge is unchanged unit positivity,
  forcing-prime supply, or full gcd-layer noncoverage.

Return `PIVOT` only for a proved unrestricted theorem eliminating a specified
infinite class of squarefull obstructions, with the residual class and full
implication to the frozen target stated exactly. A finite range, one pivot
family, conditional scaling lemma, or signed identity without positivity does
not qualify.

Return `PROVE` only with every universal quantifier closed. Return
`COUNTEREXAMPLE` only with every pivot row and every ordinary certificate
checked so the universal squarefree conclusion genuinely fails.

## Required response schema

Return one self-contained response with:

1. `Disposition` -- `PROVE`, `COUNTEREXAMPLE`, `PIVOT`, or `STOP`.
2. `Frozen definitions` -- candidate, badness, gcd strata, and squarefree.
3. `Input claim table` -- each imported result and evidence label.
4. `Non-equivalence audit` -- ordinary/unit/squarefree distinctions and
   scaling.
5. `Attack comparison` -- at least two uniform attacks.
6. `Main mathematics` -- proof, exact counterexample, or proved narrower
   theorem.
7. `Implication chain` -- every arrow to the target and unrestricted LRC.
8. `Falsification` -- mandatory fixtures and any bounded search.
9. `Proof-obligation ledger` -- one row per unresolved assertion.
10. `Lean plan` -- frozen declaration signatures only after survival; no
    `sorry`, `admit`, `unsafe`, `native_decide`, or new axioms.
11. `Artifacts` -- deterministic source/output commands and hashes, or
    `not-run`.
12. `Evidence table` -- exact scope and status of every response claim.

Do not ask a follow-up question or prepare another prompt. Do not claim LRC
from a finite scan, a conditional wrapper, or a response-authored theorem.
