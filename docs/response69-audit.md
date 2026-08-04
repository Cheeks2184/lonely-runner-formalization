# Response 69 mathematical audit

## Scope and disposition

This is an independent manuscript audit of the immutable recovered Response69
at commit `ed08c419d83b9f46daf7d30894c4b578098544f0`. It does not execute or
replay either recovered attachment. Recovery provenance is recorded separately
in `docs/response69-provenance-audit.md`.

The response's self-disposition `STOP` is not accepted as a status by itself.
The audit reaches the following more precise disposition:

- the elementary cover, boundary, reflection, scaling, one-owner, and `n=2`
  arguments are independently valid and are recommended for `proved-math`;
- the explicit `(1,3,4)` calculation independently rejects the proposed
  nearest-boundary exchange, but does not refute other injections or the
  weighted compensation statement;
- the incidence/first-moment argument supplies no cross-pivot destination
  safety and therefore stops at its stated first unsupported arrow;
- `CROSS-PIVOT-WEIGHTED-DEFICIT-COMPENSATION` remains an unrestricted,
  non-tautological `open` target; and
- all attachment-derived fixture counts and scan totals remain **unaccepted in
  this audit**, pending the independent artifact audit `VERIFY-P69-ARTIFACT-
  REPLAY-152`.

The route-level recommendation is **FREEZE**. Preserve the exact compensation
target as open, but do not continue the rejected nearest-boundary or raw
incidence-charge strategies without a genuinely new destination-safety law or
an exact counterexample. No claim about unrestricted Lonely Runner is promoted.

## Exact setting

Let `n >= 2`, put `N=n+1`, and let

```text
a : Fin n -> Nat
```

be positive and injective. For pivot `j`, write

```text
p_j = a_j,
M_j = N*a_j,
rho_M(x) = min(x mod M, M-(x mod M)),
R_j = {r in {0,...,M_j-1} : N does not divide r},
B_i^j = {r in R_j : rho_(M_j)(r*a_i) < a_j}  for i != j,
mu_j(r) = #{i : i != j and r in B_i^j},
Q_j = {r in R_j : mu_j(r)=0},
G_j = |Q_j|.
```

Coincident modular residues or bad sets retain distinct owner indices in
`mu_j`. Badness is strict: `rho=a_j-1` is bad and `rho=a_j` is safe. All
residues use their unique representatives in `[0,M_j)`, and cyclic distance
includes both sides of the circle.

For `j != k`, define the positive integer weight

```text
w(j,k) = a_k / gcd(a_j,a_k).
```

The frozen bridge is

```text
CROSS-PIVOT-WEIGHTED-DEFICIT-COMPENSATION:

For every n >= 2, every positive injective a : Fin n -> Nat,
and every j : Fin n,

  G_j = 0 ->
  2*a_j <= sum_{k != j} w(j,k)*G_k.
```

The antecedent `G_j=0` is equivalent to `Covers(j)`. The quantifier over `j`
is universal; proving the inequality only for a selected pivot would be a
weaker statement and would not be this target.

## Exact claim table

| Response lines | Exact claim | Independent result | Recommended label | Boundary |
| --- | --- | --- | --- | --- |
| 35--81 | `|R_j|=n*a_j` and the owner-indexed definitions above | Valid | `proved-math` | There are exactly `a_j` excluded multiples of `N` in `[0,N*a_j)`. Repeated owners are not quotiented. |
| 83--111 | `Q_j = R_j \ union_{i!=j} B_i^j`; hence `G_j=0` iff `Covers(j)` | Valid | `proved-math` | Uses finiteness only to turn cardinal zero into emptiness. |
| 113--127 | Complement of strict badness is `rho>=a_j` | Valid | `proved-math` | Equality is safe; no one-sided replacement is permitted. |
| 129--152 | Reflection invariance and all-odd half-time fixed-point classification | Valid | `proved-math` | The unique possible nonzero fixed point is counted once, not twice. |
| 154--192 | Positivity/integrality of `w(j,k)` and `|D_j|=sum w(j,k)G_k` | Valid | `proved-math` | `D_j` is a dependent disjoint union; this cardinal identity does not construct an injection. |
| 194--217 | `G_j(ca)=cG_j(a)`, weight invariance, and homogeneous scaling of the target for `c>0` | Valid | `proved-math` | Common scaling only. Different coordinate scalings are not covered. |
| 256--295 | One-owner rigidity: for `N>=3`, `B_q^p=R_p` iff `N*p` divides `q` | Valid | `proved-math` | Positivity is enough; injectivity is not used. |
| 297--339 | The frozen compensation inequality for `n=2` | Valid | `proved-math` | Exact formula `G_q=2mp` when `q=3mp`; closed endpoints are essential. |
| 345--367 | An inclusion-minimal selected owner cover has a private point for each selected owner | Valid | `proved-math` | Privacy is relative to the selected subcover; omitted owners may also cover the point. |
| 369--380 | The boundary-token set `E_j` has exactly `2a_j` distinct candidates, each pivot-safe at equality | Valid | `proved-math` | Requires `N>=3`; reflection pairs and fixed points are not being counted as good destinations. |
| 382--472 | The canonical nearest-boundary exchange reaches a good destination | False | `rejected` | `(1,3,4)` is an exact counterexample to this rule. It is not a counterexample to the compensation inequality. |
| 474--484 | A general noncircular injection from source tokens to weighted good-destination slots exists | Not established | `open` | Destination membership and collision control are both missing. |
| 488--552 | First-moment incidence can be converted into a nonnegative charge law with the frozen capacities | Not established | `open`; current proposed conversion stopped | The exact incidence identity is valid, but it does not lower-bound the zero-multiplicity set. |
| 556--644 | Fixture counts, 2,429-tuple scan, 806 covered rows, and zero target failures | Not checked here | unaccepted pending audit 152 | Recovered attachment claims are neither executed nor promoted by this mathematical audit. |
| 648--795 | The frozen bridge implies a canonical pivot certificate and then unrestricted LRC | Valid conditional implication | `proved-math` implication with an `open` premise | Does not prove the premise. Repository equivalence directions were independently checked. |
| 837--844 | `STOP` applies to the two proposed proof mechanisms while the compensation lemma remains open | Valid scope clarification | route `freeze`; target `open` | Interpreting `STOP` as a refutation of the target would be invalid. |

## Cover equivalence and strict boundary

For `r in R_j`, owner-indexed cardinality gives

```text
mu_j(r)=0
  iff for every i != j, r is not in B_i^j
  iff r is not in union_{i!=j} B_i^j.
```

Thus

```text
Q_j = R_j \ union_{i!=j} B_i^j.
```

Every bad set is a subset of `R_j`, so `Q_j` is empty exactly when that union
equals `R_j`. Because `Q_j` is finite, `G_j=0` is equivalent to `Q_j` being
empty. No subtraction of overlapping cardinalities is used.

The complement of

```text
rho_(M_j)(r*a_i) < a_j
```

inside `R_j` is exactly the closed inequality `rho>=a_j`. In particular,
changing `<` to `<=` would change both `Q_j` and the final certificate theorem.

## Reflection and the fixed point

The map `r |-> -r mod M_j` preserves `R_j`, because `N` divides `M_j`, and it
preserves every bad set because cyclic distance is even. It therefore preserves
`Q_j`.

A fixed residue satisfies `2r=0 mod M_j`. Besides zero, which is excluded from
`R_j`, the only possibility is `r=M_j/2` when `M_j` is even. This residue lies
in `R_j` exactly when `N` is even and `a_j` is odd:

- if `a_j` is even, `M_j/2=N*(a_j/2)` is excluded;
- if `a_j` is odd, evenness of `M_j` forces `N` even, and
  `(N/2)*a_j` is not divisible by `N`.

At this point, multiplication by an even speed gives residue zero and hence is
bad. Multiplication by an odd speed fixes the half-modulus residue, whose
distance is `M_j/2 >= a_j`. Since the pivot speed is already odd, the fixed
candidate is good exactly when every speed is odd. It is one fixed point and
must be counted once.

## Common-scaling law

Let `c>0`, set `a'_i=c*a_i`, and let `M'_j=c*M_j`. Reduction modulo `M_j`
maps every residue modulo `M'_j` to `s` with exactly `c` lifts. If `r=s+tM_j`,
then

```text
r*(c*a_i) = c*s*a_i  mod c*M_j,
rho_(c*M_j)(r*c*a_i) = c*rho_(M_j)(s*a_i).
```

Because `N` divides `M_j`, `N` divides `r` exactly when it divides `s`.
Consequently each candidate, each owner-bad membership, and each owner-indexed
multiplicity is copied to precisely `c` lifts. Therefore

```text
G_j(ca)=c*G_j(a).
```

Also

```text
w_ca(j,k)
  = c*a_k / gcd(c*a_j,c*a_k)
  = a_k / gcd(a_j,a_k)
  = w_a(j,k).
```

Both sides of the frozen inequality scale by `c`. This checks common scaling;
it supplies no transport between different pivot moduli and no proof of the
inequality.

## One-owner rigidity

Let `N>=3`, `p,q>0`, `M=N*p`, and define

```text
R_p = {r mod M : N does not divide r},
B_q^p = {r in R_p : rho_M(r*q)<p}.
```

If `M` divides `q`, every product is zero and `B_q^p=R_p`.

Conversely suppose `B_q^p=R_p`. Since `1 in R_p`, write

```text
q = +/-u mod M,  0 <= u < p.
```

If `u>0`, construct a safe candidate:

- if `2u>=p`, take `r=2`;
- if `2u<p`, put `c=ceil(p/u)` and take `r=c` unless `N` divides `c`, in
  which case take `r=c+1`.

In the first case `N` does not divide `2` because `N>=3`, and
`p<=2u<2p`. In the second, the selected `r` is not divisible by `N` and
`p<=r*u<2p`. The selected representative is below `M`; moreover
`M-r*u>=p` because `N>=3`. Hence

```text
rho_M(r*q)=rho_M(r*u)>=p,
```

contradicting full coverage. Thus `u=0`, so `N*p` divides `q`. This proof uses
the strict boundary correctly: the constructed equality case is safe.

## Exact `n=2` compensation case

Here `N=3`. Let the covered source speed be `p` and the only owner speed be
`q`. One-owner rigidity gives

```text
q=3*m*p
```

for an integer `m>=1`. At the `q` pivot the modulus is `3q=9mp`. Factoring the
owner speed `p` reduces its safety condition to

```text
rho_(9m)(r)>=3m.
```

Using unique representatives modulo `9m`, the safe interval is the closed
interval `[3m,6m]`. It contains `3m+1` residues, of which exactly `m+1` are
multiples of three. Thus it contains `2m` candidates. Each has exactly `p`
lifts modulo `9mp`, with three-divisibility preserved, so

```text
G_q=2*m*p.
```

Since `gcd(p,q)=p`,

```text
w(p,q)=3m,
w(p,q)*G_q=6*m^2*p>=2p.
```

This proves the target at every covered pivot when `n=2`. It does not supply an
induction step to higher dimension.

## Exact nearest-boundary failure

Take `a=(1,3,4)`, `n=3`, `N=4`, and source pivot speed `1`. Its modulus is
four and `R_1={1,2,3}`. The speed-three bad set is empty, while multiplication
by speed four is zero modulo four, so `B_4^1=R_1`. The canonical minimal cover
is the singleton owner four.

The two source boundary tokens are `e=1,3`. For `e=1`, the centered equation
against owner four is

```text
1*4 = 1*4+0,
```

so the proposed destination residues at the speed-four pivot are `3` and `5`
modulo sixteen. They are bad because

```text
rho_16(3*1)=3<4,
rho_16(5*3)=rho_16(15)=1<4.
```

For the reflected token `e=3`, the proposed residues are `11` and `13`, and

```text
rho_16(11*3)=1<4,
rho_16(13*1)=3<4.
```

Direct enumeration from the frozen definition gives

```text
Q_4={7,9}.
```

The proposed rule reaches neither good residue. The available weight is
`w(1,4)=4`, so lack of slot capacity is not the issue; destination safety fails
first. This is a mathematical counterexample to that exact exchange rule. It
does not refute a different injection and does not violate the frozen weighted
inequality: the independently enumerated `Q_4={7,9}` alone contributes
`w(1,4)*G_4=4*2=8`, already larger than the source demand two. No other fixture
count from the recovered batch is needed for this conclusion.

## Incidence and charge audit

The owner-indexed incidence identity

```text
sum_{i!=k} |B_i^k| = sum_{r in R_k} mu_k(r)
```

is double counting and is valid even when bad sets coincide. It does not give
a useful lower bound on

```text
G_k=#{r : mu_k(r)=0}.
```

Overlap can increase the first moment without creating or locating any
zero-multiplicity residue. Assigning a covered source token to a blocking owner
therefore lands in a bad incidence, not in a member of some `Q_k`.

Enumerating the `Q_k` first and then invoking cardinality to choose a target is
circular: the required capacity inequality is exactly the frozen target. The
first unsupported arrow is consequently

```text
covered source-row incidence
  -> explicit uncovered residue at a different pivot.
```

Neither quotient/remainder data nor the first moment proves this arrow.
Response69's two proposed proof mechanisms stop here.

## Non-tautology and exact open status

The frozen statement is not a definitional restatement of “some `G_k>0`.” For
each covered pivot it requires the fixed quantitative lower bound `2*a_j`, with
asymmetric arithmetic weights chosen before any good row is known. The
conditional LRC argument uses only the much weaker consequence that the right
side is positive.

Thus the bridge is quantitatively stronger on its face than the existential
certificate conclusion. This audit does **not** prove a formal logical
separation: no instance satisfying a pivot certificate but violating the
weighted inequality is known here, and no reverse derivation from unrestricted
LRC is known. The correct status is therefore:

- not tautological from the definitions;
- not refuted by the `(1,3,4)` exchange failure;
- proved only for `n=2` by the argument above; and
- `open` for unrestricted dimension and height.

The recovered bounded scan cannot change that status until independently
replayed, and even a successful replay would be finite evidence only.

## Conditional implication to the canonical theorem

Assume the frozen compensation lemma for all `n>=2`. Given a positive
injective tuple and any pivot `j`:

1. If `G_j>0`, select `r in Q_j`.
2. If `G_j=0`, the lemma gives a positive right-hand sum because `2a_j>0`.
3. Every weight and every `G_k` is a natural number. Positivity of the finite
   sum therefore gives some `k!=j` with `w(j,k)G_k>0`, hence `G_k>0`.
4. Select `r in Q_k`. Every nonpivot coordinate is safe by the definition of
   `Q_k` and the closed complement of the strict bad set.
5. Write the candidate representative as `r=Nq+s`, `1<=s<=N-1`. Then the
   pivot coordinate has cyclic distance
   `a_k*min(s,N-s)>=a_k`, so it is also safe.

This produces the exact pivot certificate. The `n=1` case is separate: there
are no nonpivot owners, and `r=1` is a candidate modulo `2p` whose pivot
distance is exactly `p`.

The repository declarations confirm the remaining directions:

- `LonelyRunner/PivotBoundary.lean:454` states witness existence iff pivot
  certificate existence; `.mpr` maps a certificate to a witness.
- `LonelyRunner/PivotBoundary.lean:479` defines the all-dimensional positive-
  integer pivot-certificate conjecture, with `n>=1`, positivity, and
  injectivity.
- `LonelyRunner/PivotBoundary.lean:491` states
  `PositiveIntegerConjecture <-> PositiveIntegerPivotCertificateConjecture`;
  `.mpr` maps the certificate conjecture to the positive-integer conjecture.
- `LonelyRunner/BHKRealReduction.lean:114` states
  `Conjecture <-> PositiveIntegerConjecture`; `.mpr` maps the positive-integer
  theorem to the canonical real conjecture.

These declarations are existing `proved-lean` dependencies. The implication
chain is valid but conditional on the open weighted lemma; it is not a proof of
unrestricted LRC.

## Artifact boundary

This audit did not open or execute `p69_compensation_audit.py` or
`p69_compensation_audit.json`. It therefore does not accept:

- the mandatory fixture table as a batch;
- the 750 permutation checks;
- the common-scaling regression runs;
- the 2,429 primitive tuples or 806 covered-row totals;
- the absence of a failure through maximum speed twelve; or
- the reported closest ratio `13/11`.

Those statements remain recovered response claims pending artifact audit 152.
The small `(1,3,4)` exchange counterexample above is accepted independently
because its complete calculation is reproduced in this document without the
attachments.

## Proof-obligation ledger and route recommendation

| ID | Exact obligation | Status after audit | First missing edge | Disposition |
| --- | --- | --- | --- | --- |
| P69-O1 | Prove the frozen weighted inequality for every `n>=2`, positive injective tuple, and covered pivot | `open`; proved here only for `n=2` | Cross-pivot lower bound with the exact weights | Preserve, inactive |
| P69-O2 | Construct a noncircular injection from `2a_j` source tokens to `sum w(j,k)G_k` destination slots | `open` | Destination safety before inspecting `Q_k`, then collision control | Freeze current construction |
| P69-O3 | Prove a nonnegative charge-conservation law with the frozen capacities | `open` | Bad incidence does not determine a zero-multiplicity destination | Freeze current construction |
| P69-R1 | Nearest-boundary exchange from canonical private points | `rejected` | Explicit `(1,3,4)` failure | Stop |
| P69-V1 | Replay recovered finite evidence and verify source/output binding | pending audit 152 | Independent execution and comparison | Verification lane |
| P69-LRC | Derive unrestricted LRC | `conditional` on P69-O1 | P69-O1 | No promotion |

Overall route disposition: **FREEZE**. The target itself remains `open`, not
`rejected`. Reactivate only upon one of the following:

- a new exact cross-pivot conservation identity that proves destination safety;
- an independently verified counterexample to the frozen inequality;
- an unrestricted theorem that supplies the inequality without choosing good
  rows post hoc; or
- a formal implication from a separately established unrestricted bridge.

Do not spend another repair cycle on the rejected nearest-boundary exchange or
on first-moment incidence alone.

## Evidence boundary

- `proved-lean`: only the existing repository equivalences and declarations
  cited above.
- Recommended `proved-math`: cover equivalence, strict-boundary complement,
  reflection/fixed-point classification, common scaling, weight/cardinality
  identities, one-owner rigidity, the `n=2` compensation theorem, private-point
  existence, boundary-token count, the `(1,3,4)` negative audit, and the
  conditional implication from the frozen lemma.
- `computed finite evidence`: none accepted by this audit; audit 152 is pending.
- `rejected`: the canonical nearest-boundary exchange and any inference from
  raw first moments to good-destination capacity.
- `open`: the frozen weighted compensation lemma, a valid general injection or
  charge law, and unrestricted Lonely Runner.
