# Prompt97 contract stop audit

Task: `OPS-P97-CONTRACT-STOP-AUDIT-313`

Base: `ead7361e79923e8b4e27c1757f2304c68dcebb81`

Candidate commit: `efb8c60aac77c0bcb79e3bd0f0b7d78382c74212`

Candidate scoped prompt SHA-256:
`8727b28607829b9ced7f60b2d078a85bec2cd1a369491f33ee081bfb9d6c1f8b`.

Stopped-record scoped prompt SHA-256:
`91402ed82e69866c9078189de27dde730c016c548a62361228f5ea3b1645ced6`.

Stopped-record full-file SHA-256:
`85fcbf0aaf94372ab0f98f88849f70e607fe63fe4e411909322962eb96fb73ab`.

## Disposition: `STOP / NOT LAUNCHABLE`

Prompt97 is rejected as a research contract because its sole proposed bridge
is a tautological duplicate of Prompt94's open unit-certificate target after
using Prompt97's own elementary terminal lemma. This is a contract-design
failure, not a counterexample to the proposed theorem and not evidence against
the Lonely Runner Conjecture.

The exact theorem and definitions remain in
`research/sol-pro/prompts/prompt97.md` solely as a failed-approach record. The
file is not an actionable Sol Pro instruction and must not be launched.

## Exact independent-review logic

Fix one positive injective theorem-domain tuple and abbreviate:

```text
A := every unit pivot row is full;
S := the canonical selected-cover graph contains a synchronized cycle.
```

Prompt97's elementary terminal argument establishes

```text
A and S -> False.
```

Indeed, for a synchronized cycle it defines

```text
U = product_t u_t,
V = product_t v_t,
Z = product_t z_t.
```

Cyclic speed telescoping gives `V=U`. All cross congruences give `u_t|Z`
for every edge, pairwise coprimality gives `U|Z`, and the strict private-edge
bounds give `0<abs(Z)<U`, a contradiction.

The sole Prompt97 target is

```text
A -> S.
```

Together with the terminal lemma, `A->S` implies `not A`: assuming `A`
produces `S` and hence `False`. Conversely, `not A` implies `A->S` by ex
falso. Therefore, tuple by tuple,

```text
(A -> S) <-> not A.
```

But `not A` says that at least one unit pivot row is not full. Expanding the
frozen definitions, this is exactly the existence of a unit numerator outside
every strict bad set at some pivot. That is Prompt94's
`ALL-PIVOT-UNIT-STRATUM-MOBIUS-DEFICIT` target in its exact uncovered-unit
form.

Thus Prompt97 does not replace the Prompt94 open edge by a narrower lemma. It
encodes the same tuplewise obligation as the existence of an impossible
synchronized object under `A`. The extra cycle vocabulary supplies a proposed
proof shape, but no independent structural consequence between the
hypothesis and the already-open conclusion.

## Scope and evidence boundary

The review establishes only the logical equivalence above and the consequent
contract rejection.

- It does **not** prove or refute `A->S`.
- It does **not** prove or refute Prompt94's unit-certificate target.
- It does **not** prove or refute ordinary pivot-certificate existence.
- It does **not** prove or refute unrestricted integer or real LRC.
- It does **not** promote any finite calculation or computation.
- It does **not** rely on Prompt94's response-authored finite artifacts or
  self-assigned evidence labels.

The accepted classification is `rejected` / `STOP` for the Prompt97 route
contract only. Unrestricted LRC and the unit-certificate target remain `open`.

## Preservation boundary

The stopped prompt preserves the candidate's exact theorem, canonical-cover
definitions, private-edge data, synchronized-cycle conditions, hand
falsifiers, and proposed response schema. Only lifecycle metadata and the
prominent preamble are changed so the record cannot be mistaken for a
launchable prompt.

No browser action, Sol Pro turn, source execution, finite replay, Lean build,
task-ledger update, status-document update, or Level-3 verification is part of
this stop record.
