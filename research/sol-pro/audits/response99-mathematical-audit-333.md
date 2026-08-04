# Response99 independent mathematical audit

- Task: `P99-MATHEMATICAL-VERIFICATION-333`
- Audit base: `4fa5e8a77efde81eb09b72763b5e8ade0bf9729d`
- Overall disposition: `STOP — semantic contract defect`
- Theorem-domain counterexample: none
- Unrestricted LRC: `open`

This is an independent mathematical review of the normalized response. It is
separate from recovery provenance and does not use the response-supplied
program or finite counts.

## Exact audited statement

Fix `n>=2`, put `N=n+1`, and let `a : Fin n -> Nat` be positive and
injective. For a pivot label `j`, a labelled set `C` is a complete cover when
`C` excludes `j` and every canonical candidate

```text
0 <= r < N*a(j),  N does not divide r
```

is strictly bad for at least one owner in `C`. A covered pivot uses every
nonpivot label as a possible owner. A maximum covered pivot is covered and has
speed at least that of every covered pivot. Its internal covers use only other
covered pivot labels. Redundancy says that every such complete internal cover
has an owner whose deletion leaves a complete cover.

The unrestricted proposition quantifies this redundancy over every maximum
covered pivot. The Prompt99 proposition adds `N | a(j)`.

## Common-scaling proof

Let `t>0` and scale every speed by `t`. For an original pivot speed `p`, the
old modulus is `M=N*p` and the scaled modulus is `t*M`. Every scaled candidate
`r'` has a unique sheet decomposition `r'=q*M+r`, with `0<=r<M`. Because
`N | M`, divisibility by `N` is unchanged:

```text
N | r'  iff  N | r.
```

For an owner speed `b`, multiplication and circular residue distance satisfy

```text
r'*(t*b) = t*(r'*b),
rho_(t*M)(t*x) = t*rho_M(x),
rho_M(r'*b) = rho_M(r*b).
```

Therefore

```text
rho_(t*M)(r'*(t*b)) < t*p
  iff rho_M(r*b) < p.
```

The inequality is strict on both sides, so equality at the safety boundary is
preserved rather than accidentally converted into badness. Each scaled sheet
has exactly the same labelled bad-owner relation as the original row.

It follows in both directions that every fixed labelled owner set is a
complete cover after scaling exactly when it was a complete cover before
scaling. Hence the set of covered labels is unchanged. Positivity and
injectivity are preserved, and multiplication by positive `t` preserves and
reflects speed order. Maximum covered labels, internal owner sets, and the
coverwise redundancy proposition are consequently invariant.

Now take `t=N`. The scaled maximum covered speed is `N*a(j)`, hence divisible
by `N`. The Prompt99 universal theorem applied to the scaled tuple gives
redundancy there, and invariance transports it back to `a`. Thus Prompt99
implies the unrestricted Prompt95 redundancy theorem. The converse is direct
restriction.

## Claim audit

| Claim | Decision | Evidence label and exact scope |
| --- | --- | --- |
| Candidate rows reduce exactly across common-scaling sheets | ACCEPT | `proved-math-qualified`; positive naturals, canonical candidates, strict exclusion of multiples of `N` |
| Strict badness is invariant under common scaling | ACCEPT | `proved-math-qualified`; strict `< pivot` boundary exactly preserved |
| Labelled complete covers and covered-pivot sets are invariant | ACCEPT | `proved-math-qualified`; fixed labels and arbitrary owner subsets |
| Maximum covered pivot and internal-cover redundancy are invariant | ACCEPT | `proved-math-qualified`; positivity is essential for order cancellation |
| Universal Prompt99 iff full Prompt95 redundancy | ACCEPT | `proved-math-qualified`; exact unnormalized universal propositions above |
| “Prompt99 closes only the `N | p` branch” | REFUTE | `refuted-exact`; the universal restriction collapses by scaling with `t=N` |
| “Prompt99 alone cannot prove full Prompt95” | REFUTE | `refuted-exact`; it is equivalent to full Prompt95 at the frozen quantifiers |
| Response finite replay | DO NOT AUDIT OR PROMOTE | Attachment/source independence and binding are not established |
| Prompt99/full Prompt95 theorem | RETAIN OPEN | Equivalence proves neither side |
| Pivot certificate and unrestricted LRC | RETAIN OPEN | No redundancy existence theorem or counterexample is supplied |

## Adversarial checks

- No invalid reduction from real velocities to integers occurs; this result is
  wholly inside the already formal integer pivot model.
- No gcd condition on `t` and `N` is needed. Reducing modulo the old full
  modulus, rather than multiplying a fixed-grid candidate by a unit, is the
  correct mechanism.
- The proof does not assume a unique maximum covered pivot. It preserves every
  label satisfying the maximum predicate.
- The owner set is labelled; no speed-based reindexing or accidental quotient
  of equal owners occurs. Injectivity is preserved independently.
- The result is not vacuous when no covered pivot exists: both global
  propositions quantify over a label satisfying the same maximum predicate.
- Minimality and private witnesses discussed in the response are unnecessary
  for the exact coverwise redundancy equivalence audited here.

## Disposition and next bridge

The Prompt99 branch contract is stopped because its claimed restricted scope
is false. This is useful structural progress and a contract correction, not a
proof or disproof of Prompt95 or LRC. The exact remaining lemma is still the
unrestricted maximum-covered-pivot internal-cover redundancy proposition.

A genuinely narrower successor would need a normalization not destroyed by
common scaling—for example a primitive tuple condition—followed by a fresh
proof that the normalized branch decomposition is exhaustive and useful. No
such successor theorem is claimed here.
